(in-package :opusmodus)
;;; CSOUND.LISP
;;; ---------------
;;; UTILS:
;;;PCH TO FREQ FACTOR MAPPER: pch-to-freqfact list
(defun pchfrq-mapper (pch)
  (cond
   ((= pch 7.00) 1)
   ((= pch 7.00) 1)
   ((= pch 7.00) 1)
   ((= pch 7.01) 1.0595)
   ((= pch 7.02) 1.1225)
   ((= pch 7.03) 1.1892)
   ((= pch 7.04) 1.2599)
   ((= pch 7.05) 1.3348)
   ((= pch 7.06) 1.4142)
   ((= pch 7.07) 1.4983)
   ((= pch 7.08) 1.5874)
   ((= pch 7.09) 1.6818)
   ((= pch 7.10) 1.7818)
   ((= pch 7.11) 1.8878)
   ((= pch 8.00) 2)
   ((= pch 6.00) 0.5)
   ((= pch 6.01) 0.5297)
   ((= pch 6.02) 0.5612)
   ((= pch 6.03) 0.5946)
   ((= pch 6.04) 0.6300)
   ((= pch 6.05) 0.6674)
   ((= pch 6.06) 0.7071)
   ((= pch 6.07) 0.7492)
   ((= pch 6.08) 0.7937)
   ((= pch 6.09) 0.8409)
   ((= pch 6.10) 0.8909)
   ((= pch 6.11) 0.9439)
))

(defun pch-to-freqfact (list)
  (mapcar 'pchfrq-mapper list))

;;Exemple :
;(pch-to-freqfact '(7.00 7.03 6.02))



;;; ===============================================================
;;; CSOUND FRAMEWORK FOR OPUSMODUS
;;; Final hybrid version
;;;
;;; Philosophy:
;;; - Use the Lisp DSL for most Csound lines.
;;; - Use raw strings whenever a Csound expression/opcode line is
;;;   easier, safer, or clearer to write directly.
;;;
;;; Examples of valid body/global lines:
;;;   (kamp = (ampdb p4))
;;;   (asig oscil iamp ifreq ifun)
;;;   ((aL aR) pan2 aout kpan)
;;;   (outleta leftout asig)
;;;   "aout = asig * aenv"
;;;   "asig = foscili:a(kamp, kcps, 1, kmod, kndx, gisine)"
;;;
;;; In short:
;;; - DSL when convenient
;;; - strings when needed
;;; ===============================================================

;;; ---------------------------------------------------------------
;;; Utilities
;;; ---------------------------------------------------------------
(defparameter *csound-process* nil)
(defparameter *csound-last-file* nil)
(defparameter *csound-last-command* nil)

(defun csound-running-p ()
  (and *csound-process*
       (ignore-errors
         (uiop:process-alive-p *csound-process*))))

(defun stop-csound ()
  "Stop the currently running Csound process."
  (when *csound-process*
    (ignore-errors
      (uiop:terminate-process *csound-process*))
    (sleep 0.1)
    (setf *csound-process* nil))
  :stopped)

(defun restart-csound ()
  "Restart the last launched Csound process."
  (when *csound-last-command*
    (stop-csound)
    (sleep 0.1)
    (setf *csound-process*
          (uiop:launch-program *csound-last-command*
                               :output nil
                               :error-output nil))
    *csound-process*))

(defun %stringify (x)
  (typecase x
    (string x)
    (symbol (string-downcase (symbol-name x)))
    (t (princ-to-string x))))

(defun %keywordify (sym)
  (intern (string-upcase (symbol-name sym)) :keyword))

(defun %ensure-list (x)
  (if (listp x) x (list x)))

(defun %repeat-to-length (lst len)
  (let ((src (%ensure-list lst)))
    (cond
      ((null src)
       (make-list len :initial-element nil))
      ((= (length src) len)
       src)
      (t
       (loop for i from 0 below len
             collect (nth (mod i (length src)) src))))))

(defun %max-param-length (&rest things)
  (let ((lengths
         (remove nil
                 (mapcar (lambda (x)
                           (when (listp x)
                             (length x)))
                         things))))
    (if lengths
        (apply #'max lengths)
        1)))

(defun split-lines (string)
  "Split STRING into a list of lines."
  (let ((start 0)
        (len (length string))
        (lines '()))
    (loop for i from 0 to len do
      (when (or (= i len)
                (char= (aref string i) #\Newline))
        (push (subseq string start i) lines)
        (setf start (1+ i))))
    (nreverse lines)))

(defun keynum-to-hertz (knum)
  (* 6.875 (expt 2 (/ (+ knum 3) 12))))

;;; ---------------------------------------------------------------
;;; Clause normalization
;;; ---------------------------------------------------------------

(defun %normalize-flat-clause-values (clause)
  "Normalize a flat clause.
Examples:
  (:pfields amp midi mod)
  (:pfields (amp midi mod))
=> (amp midi mod)"
  (let ((vals (rest clause)))
    (cond
      ((null vals)
       '())
      ((and (= (length vals) 1)
            (listp (first vals)))
       (first vals))
      (t
       vals))))

(defun %normalize-line-clause-values (clause)
  "Normalize a clause containing one or more lines.
Examples:
  (:globals
    (gisine ftgen 1 0 16384 10 1))
=> ((gisine ftgen 1 0 16384 10 1))

  (:body
    (kamp = (ampdb p4))
    (kcps = (mtof p5)))
=> ((kamp = (ampdb p4))
    (kcps = (mtof p5)))

  (:body
    ((kamp = (ampdb p4))
     (kcps = (mtof p5))))
=> ((kamp = (ampdb p4))
    (kcps = (mtof p5)))

Also supports string lines."
  (let ((vals (rest clause)))
    (cond
      ((null vals)
       '())

      ;; Single argument which is itself a list of lines.
      ((and (= (length vals) 1)
            (listp (first vals))
            (or (null (first vals))
                (listp (first (first vals)))))
       (first vals))

      ;; Single argument which is one DSL line.
      ((and (= (length vals) 1)
            (listp (first vals)))
       (list (first vals)))

      ;; Multiple lines already separated.
      (t
       vals))))

;;; ---------------------------------------------------------------
;;; Instrument model
;;; ---------------------------------------------------------------

(defstruct csound-instrument
  name
  type          ; :instrument | :fx | :output
  pfields       ; symbolic names for p4...pn
  globals       ; list of lines (strings or DSL forms)
  inputs        ; list of inlet names
  outputs       ; list of outlet names
  body          ; list of lines (strings or DSL forms)
  doc)

(defparameter *csound-library* (make-hash-table :test #'equal)
  "Library of Csound instruments.")

(defun clear-csound-library ()
  (clrhash *csound-library*))

(defun register-csound-instrument (instrument)
  (setf (gethash (string-downcase (csound-instrument-name instrument))
                 *csound-library*)
        instrument)
  instrument)

(defun find-csound-instrument (name)
  (or (gethash (string-downcase (%stringify name)) *csound-library*)
      (error "Unknown Csound instrument: ~A" name)))

(defun list-csound-instruments ()
  (sort (loop for k being the hash-keys of *csound-library*
              collect k)
        #'string<))

(defun describe-csound-instrument (name)
  (let ((instr (find-csound-instrument name)))
    (list :name    (csound-instrument-name instr)
          :type    (csound-instrument-type instr)
          :pfields (csound-instrument-pfields instr)
          :inputs  (csound-instrument-inputs instr)
          :outputs (csound-instrument-outputs instr)
          :doc     (csound-instrument-doc instr))))

;;; ---------------------------------------------------------------
;;; Csound DSL rendering
;;; ---------------------------------------------------------------

(defun %cs-token->string (x)
  (cond
    ((null x) "")
    ((stringp x) x)
    ((symbolp x) (string-downcase (symbol-name x)))
    ((numberp x) (princ-to-string x))
    (t (princ-to-string x))))

(defun %cs-lhs->string (lhs)
  (cond
    ((symbolp lhs)
     (%cs-token->string lhs))
    ((stringp lhs)
     lhs)
    ((listp lhs)
     (format nil "~{~a~^, ~}"
             (mapcar #'%cs-token->string lhs)))
    (t
     (%cs-token->string lhs))))

(defun %cs-quote-token (x)
  (format nil "\"~a\"" (%cs-token->string x)))

(defun %cs-infix-op-p (sym)
  (member sym '(+ - * / > < >= <= == != && ||) :test #'equal))

(defun %cs-join-infix (op args)
  (with-output-to-string (s)
    (format s "(")
    (loop for a in args
          for i from 0 do
          (when (> i 0)
            (format s " ~a " (%cs-token->string op)))
          (format s "~a" (%cs-expr->string a)))
    (format s ")")))

(defun %cs-expr->string (expr)
  (cond
    ((stringp expr)
     expr)
    ((numberp expr)
     (princ-to-string expr))
    ((symbolp expr)
     (%cs-token->string expr))
    ((and (listp expr) (null expr))
     "")
    ((and (listp expr)
          (symbolp (first expr))
          (%cs-infix-op-p (first expr)))
     (%cs-join-infix (first expr) (rest expr)))
    ((listp expr)
     (format nil "~a(~{~a~^, ~})"
             (%cs-token->string (first expr))
             (mapcar #'%cs-expr->string (rest expr))))
    (t
     (princ-to-string expr))))

(defun %cs-line->string (line)
  (cond
    ;; raw string line
    ((stringp line)
     line)

    ;; raw symbol line
    ((symbolp line)
     (%cs-token->string line))

    ;; empty
    ((null line)
     "")

    ;; DSL form
    ((listp line)
     (cond
       ;; (lhs = expr)
       ((and (= (length line) 3)
             (equal (second line) '=))
        (format nil "~a = ~a"
                (%cs-lhs->string (first line))
                (%cs-expr->string (third line))))

       ;; (outleta leftout asig)
       ((eq (first line) 'outleta)
        (destructuring-bind (_ channel signal) line
          (declare (ignore _))
          (format nil "outleta ~a, ~a"
                  (%cs-quote-token channel)
                  (%cs-expr->string signal))))

       ;; (outs aL aR)
       ((eq (first line) 'outs)
        (format nil "outs ~{~a~^, ~}"
                (mapcar #'%cs-expr->string (rest line))))

       ;; bare statement like (turnoff)
       ((and (symbolp (first line))
             (null (rest line)))
        (%cs-token->string (first line)))

       ;; ((a1 a2) opcode arg1 arg2 ...)
       ((and (listp (first line))
             (symbolp (second line)))
        (format nil "~a ~a~@[ ~{~a~^, ~}~]"
                (%cs-lhs->string (first line))
                (%cs-token->string (second line))
                (and (cddr line)
                     (mapcar #'%cs-expr->string (cddr line)))))

       ;; (lhs opcode arg1 arg2 ...)
       ((and (symbolp (first line))
             (symbolp (second line)))
        (let ((lhs (first line))
              (opcode (second line))
              (args (cddr line)))
          (cond
            ;; (aleftin inleta leftin)
            ((eq opcode 'inleta)
             (format nil "~a ~a ~a"
                     (%cs-token->string lhs)
                     (%cs-token->string opcode)
                     (%cs-quote-token (first args))))

            ;; general opcode statement
            (t
             (format nil "~a ~a~@[ ~{~a~^, ~}~]"
                     (%cs-token->string lhs)
                     (%cs-token->string opcode)
                     (and args
                          (mapcar #'%cs-expr->string args)))))))

       ;; fallback -> functional expression
       (t
        (%cs-expr->string line))))

    (t
     (princ-to-string line))))

;;; ---------------------------------------------------------------
;;; Instrument definition macros
;;; ---------------------------------------------------------------

(defmacro defcsinstr (name &body clauses)
  "Declarative Csound instrument definition.
Supports DSL forms and raw strings in :globals and :body."
  (let* ((type-clause    (assoc :type clauses))
         (pfields-clause (assoc :pfields clauses))
         (globals-clause (assoc :globals clauses))
         (inputs-clause  (assoc :inputs clauses))
         (outputs-clause (assoc :outputs clauses))
         (body-clause    (assoc :body clauses))
         (doc-clause     (assoc :doc clauses))

         (type-value
          (if type-clause
              (second type-clause)
              :instrument))

         (pfields-value
          (if pfields-clause
              (%normalize-flat-clause-values pfields-clause)
              '()))

         (globals-value
          (if globals-clause
              (%normalize-line-clause-values globals-clause)
              '()))

         (inputs-value
          (if inputs-clause
              (%normalize-flat-clause-values inputs-clause)
              '()))

         (outputs-value
          (if outputs-clause
              (%normalize-flat-clause-values outputs-clause)
              '()))

         (body-value
          (if body-clause
              (%normalize-line-clause-values body-clause)
              '()))

         (doc-value
          (if doc-clause
              (second doc-clause)
              nil)))
    `(register-csound-instrument
      (make-csound-instrument
       :name ,(string-downcase (symbol-name name))
       :type ',type-value
       :pfields ',pfields-value
       :globals ',globals-value
       :inputs ',inputs-value
       :outputs ',outputs-value
       :body ',body-value
       :doc ,doc-value))))

(defmacro def-simple-stereo-instrument (name pfields &body body)
  `(defcsinstr ,name
     (:type :instrument)
     (:pfields ,pfields)
     (:outputs (leftout rightout))
     (:body ,@body)))

(defmacro def-simple-stereo-fx (name &body body)
  `(defcsinstr ,name
     (:type :fx)
     (:inputs (leftin rightin))
     (:outputs (leftout rightout))
     (:body ,@body)))

(defmacro def-simple-direct-instrument (name pfields &body body)
  `(defcsinstr ,name
     (:type :instrument)
     (:pfields ,pfields)
     (:body ,@body)))

(defmacro def-simple-output (name &body body)
  `(defcsinstr ,name
     (:type :output)
     (:inputs (leftin rightin))
     (:body ,@body)))

;;; ---------------------------------------------------------------
;;; Optional converter from raw Csound instr text
;;; ---------------------------------------------------------------

(defun make-defcsinstr-form (instr-text &key (default-type :instrument))
  "Convert a raw Csound instr...endin block to a DEFCSINSTR form."
  (let* ((lines (remove-if (lambda (s)
                             (string= "" (string-trim '(#\Space #\Tab) s)))
                           (split-lines instr-text)))
         (header (first lines))
         (header-clean (string-trim '(#\Space #\Tab) header))
         (space-pos (position #\Space header-clean))
         (name (if space-pos
                   (string-trim '(#\Space #\Tab)
                                (subseq header-clean (1+ space-pos)))
                   "unnamed"))
         (body-lines (butlast (rest lines) 1)))
    `(defcsinstr ,(intern (string-upcase name) :opusmodus)
       (:type ,default-type)
       (:body ,(mapcar (lambda (l)
                         (string-trim '(#\Space #\Tab) l))
                       body-lines)))))

;;; ---------------------------------------------------------------
;;; Event model
;;; ---------------------------------------------------------------

(defstruct csound-event
  instrument
  start
  dur
  params)

(defun validate-csound-event (event)
  (let* ((instr (find-csound-instrument (csound-event-instrument event)))
         (allowed (mapcar #'%keywordify
                          (csound-instrument-pfields instr)))
         (params (csound-event-params event))
         (itype (csound-instrument-type instr)))
    (unless (eq itype :instrument)
      (error "Only :instrument definitions may receive score events. ~A is of type ~A."
             (csound-instrument-name instr)
             itype))
    (loop for (k v) on params by #'cddr do
      (unless (member k allowed)
        (error "Parameter ~A is not declared in instrument ~A. Allowed parameters: ~A"
               k
               (csound-instrument-name instr)
               allowed)))
    t))

(defun cs-quoted-string (s)
  "Return S as a Csound-ready quoted string."
  (format nil "\"~a\"" s))

(defun cs-already-quoted-string-p (s)
  "True if S already looks like a quoted Csound string."
  (and (stringp s)
       (>= (length s) 2)
       (char= (char s 0) #\")
       (char= (char s (1- (length s))) #\")))

(defparameter *csound-string-pfields*
  '(:file :path :sample :samplefile :filename)
  "Pfields that should automatically be rendered as quoted Csound strings.")

(defun maybe-cs-string (val)
  "Conservative automatic quoting for probable Csound file/path strings."
  (cond
    ((not (stringp val))
     val)
    ((cs-already-quoted-string-p val)
     val)
    ((or (search "/" val)
         (search "\\" val)
         (search ".wav" val :test #'char-equal)
         (search ".aif" val :test #'char-equal)
         (search ".aiff" val :test #'char-equal)
         (search ".flac" val :test #'char-equal)
         (search ".mp3" val :test #'char-equal)
         (search ".ogg" val :test #'char-equal)
         (search ".snd" val :test #'char-equal))
     (cs-quoted-string val))
    (t
     val)))

(defun normalize-csound-param-value-by-key (key value)
  "Normalize VALUE according to KEY."
  (cond
    ((member key *csound-string-pfields*)
     (if (listp value)
         (mapcar (lambda (x)
                   (if (stringp x)
                       (if (cs-already-quoted-string-p x)
                           x
                           (cs-quoted-string x))
                       x))
                 value)
         (if (stringp value)
             (if (cs-already-quoted-string-p value)
                 value
                 (cs-quoted-string value))
             value)))

    (t
     (if (listp value)
         (mapcar #'maybe-cs-string value)
         (maybe-cs-string value)))))

(defun normalize-csound-params (params)
  "Normalize a property list of cs-event params."
  (loop for (k v) on params by #'cddr
        append (list k (normalize-csound-param-value-by-key k v))))

(defun make-csound-event* (instrument start dur params)
  (let* ((normalized-params (normalize-csound-params params))
         (ev (make-csound-event
              :instrument (%stringify instrument)
              :start start
              :dur dur
              :params normalized-params)))
    (validate-csound-event ev)
    ev))
(defmacro cs-event (instrument &rest args)
  "Create one logical event block using named parameters.
Mandatory keywords: :start :dur"
  (let ((start (getf args :start))
        (dur   (getf args :dur)))
    `(make-csound-event*
      ,instrument
      ,start
      ,dur
      (list
       ,@(loop for (k v) on args by #'cddr
               unless (member k '(:start :dur))
               append (list k v))))))

(defun cs-events (instrument &rest args)
  "Functional version of cs-event."
  (make-csound-event*
   instrument
   (getf args :start)
   (getf args :dur)
   (loop for (k v) on args by #'cddr
         unless (member k '(:start :dur))
         append (list k v))))

;;; ---------------------------------------------------------------
;;; Rendering
;;; ---------------------------------------------------------------

(defun render-csound-instrument (instrument)
  (with-output-to-string (s)
    (dolist (g (remove nil (csound-instrument-globals instrument)))
      (format s "~a~%" (%cs-line->string g)))
    (when (csound-instrument-globals instrument)
      (format s "~%"))
    (format s "instr ~a~%" (csound-instrument-name instrument))
    (dolist (line (csound-instrument-body instrument))
      (format s "~a~%" (%cs-line->string line)))
    (format s "endin~%~%")))

(defun render-csound-header (&key
                             (cs-options "-odac")
                             (sr 44100)
                             (ksmps 32)
                             (nchnls 2)
                             (dbfs 1))
  (format nil
          "<CsoundSynthesizer>
<CsOptions>
~a
</CsOptions>
<CsInstruments>

sr = ~a
ksmps = ~a
nchnls = ~a
0dbfs = ~a

"
          cs-options sr ksmps nchnls dbfs))

(defun render-csound-event (event)
  (validate-csound-event event)
  (let* ((instr (find-csound-instrument (csound-event-instrument event)))
         (pfields (csound-instrument-pfields instr))
         (params  (csound-event-params event))
         (start   (csound-event-start event))
         (dur     (csound-event-dur event))
         (param-values
          (mapcar (lambda (pf)
                    (getf params (%keywordify pf)))
                  pfields))
         (real-len
          (apply #'%max-param-length
                 (append (list start dur) param-values)))
         (starts (%repeat-to-length start real-len))
         (durs   (%repeat-to-length dur real-len))
         (columns
          (mapcar (lambda (pf)
                    (%repeat-to-length
                     (getf params (%keywordify pf))
                     real-len))
                  pfields)))
    (with-output-to-string (s)
      (loop for i from 0 below real-len do
        (format s "i \"~a\" ~a ~a"
                (csound-instrument-name instr)
                (nth i starts)
                (nth i durs))
        (dolist (col columns)
          (format s " ~a" (nth i col)))
        (format s "~%")))))

;;; ---------------------------------------------------------------
;;; Routing
;;; ---------------------------------------------------------------

(defun make-stereo-route (from to)
  (list (list (%stringify from) (%stringify to) "leftout" "leftin")
        (list (%stringify from) (%stringify to) "rightout" "rightin")))

(defun make-default-routes (instruments fx)
  "Default stereo routing:
instrument(s) -> first fx
fx1 -> fx2 -> ... -> last fx"
  (let ((routes '()))
    (when fx
      (dolist (ins instruments)
        (setf routes
              (append routes
                      (make-stereo-route ins (first fx)))))
      (loop for a in fx
            for b in (cdr fx) do
              (setf routes
                    (append routes
                            (make-stereo-route a b)))))
    routes))

(defun render-connect-lines (routes)
  (with-output-to-string (s)
    (dolist (rt routes)
      (destructuring-bind (from to out in) rt
        (format s "connect \"~a\", \"~a\", \"~a\", \"~a\"~%"
                from out to in)))
    (when routes
      (format s "~%"))))

(defun render-alwayson-lines (fx-list)
  (with-output-to-string (s)
    (dolist (fx fx-list)
      (format s "alwayson \"~a\"~%" (%stringify fx)))
    (when fx-list
      (format s "~%"))))

;;; ---------------------------------------------------------------
;;; CSD generation
;;; ---------------------------------------------------------------

(defun def-csound-score
    (&key
     (write-to-file t)
     (file (uiop:native-namestring "~/temp.csd"))
     (instruments '())
     (fx '())
     routes
     (events '())
     (score-headers '())
     (global-orchestra-code '())
     

(cs-options "-odac
--env:SSDIR=/Users/stephaneboussuge/Samples
--env:SFDIR=/Users/stephaneboussuge/CsoundOutput
--env:SADIR=/Users/stephaneboussuge/CsoundAnalyses
--env:INCDIR=/Users/stephaneboussuge/CsoundInclude")

;(cs-options "-odac") ;; Version de base si Csound est bien configuré

     (sr 44100)
     (ksmps 32)
     (nchnls 2)
     (dbfs 1)
     (play nil)
     (csound-bin "/usr/local/bin/csound"))
  "Generate a complete CSD file."
  (let* ((instrument-names (mapcar #'%stringify instruments))
         (fx-names (mapcar #'%stringify fx))
         (instr-objs (mapcar #'find-csound-instrument instrument-names))
         (fx-objs (mapcar #'find-csound-instrument fx-names))
         (all-routes (or routes
                         (make-default-routes instrument-names fx-names)))
         (result
          (with-output-to-string (s)
            ;; header
            (format s "~a"
                    (render-csound-header
                     :cs-options cs-options
                     :sr sr
                     :ksmps ksmps
                     :nchnls nchnls
                     :dbfs dbfs))

            ;; project globals
            (dolist (line global-orchestra-code)
              (format s "~a~%" (%cs-line->string line)))
            (when global-orchestra-code
              (format s "~%"))

            ;; instruments
            (dolist (obj instr-objs)
              (format s "~a" (render-csound-instrument obj)))

            ;; fx
            (dolist (obj fx-objs)
              (format s "~a" (render-csound-instrument obj)))

            ;; routing + alwayson
            (format s "~a" (render-connect-lines all-routes))
            (format s "~a" (render-alwayson-lines fx-names))

            ;; score
            (format s "</CsInstruments>~%<CsScore>~%")
            (dolist (h score-headers)
              (format s "~a~%" h))
            (when score-headers
              (format s "~%"))

            (dolist (ev events)
              (format s "~a" (render-csound-event ev)))

            (format s "</CsScore>~%</CsoundSynthesizer>"))))
    (when write-to-file
      (with-open-file (out file
                           :direction :output
                           :if-exists :supersede
                           :if-does-not-exist :create)
        (write-string result out)))

    (when play
  (when (csound-running-p)
    (stop-csound))
  (setf *csound-last-file* file)
  (setf *csound-last-command* (list csound-bin file))
  (setf *csound-process*
        (uiop:launch-program *csound-last-command*
                             :output nil
                             :error-output nil)))

    result))


;;; ---------------------------------------------------------------
;;; Optional iblock compatibility helper
;;; ---------------------------------------------------------------

(defun iblock (&rest args)
  "Broadcast utility.
Example:
(iblock '(\"fmtest\") '(0 1 2) '(0.5) '(-12) '(60 64 67))"
  (let* ((non-nil-args (remove nil args))
         (sizes (remove nil
                        (mapcar (lambda (arg)
                                  (when (listp arg)
                                    (length arg)))
                                non-nil-args)))
         (size (if sizes (apply #'max sizes) 1))
         (expanded (mapcar (lambda (arg)
                             (%repeat-to-length arg size))
                           non-nil-args)))
    (loop for i from 0 below size
          collect (mapcar (lambda (col)
                            (nth i col))
                          expanded))))

(defun iblock-to-csound-lines (iblock-result)
  (with-output-to-string (out)
    (dolist (line iblock-result)
      (format out "i~{ ~a~}~%" line))))

;;; ---------------------------------------------------------------
;;; Example library
;;; ---------------------------------------------------------------

(defcsinstr fmtest
  (:type :instrument)
  (:pfields amp midi mod index1 index2 rise dec pan1 pan2)
  (:globals
   (gisine ftgen 1 0 16384 10 1))
  (:outputs (leftout rightout))
  (:body
   (kamp = (ampdb p4))
   (kcps = (mtof p5))
   (kmod = p6)
   (kndx line p7 p3 p8)
   (irise = p9)
   (idec = p10)
   (kpan line p11 p3 p12)
   (asig foscili kamp kcps 1 kmod kndx gisine)
   (aenv linen 1 irise p3 idec)
   (aout = "asig * aenv")
   ((asigl asigr) pan2 aout kpan)
   (outleta leftout asigl)
   (outleta rightout asigr))
  (:doc "FM stereo instrument with evolving index and pan."))

(def-simple-stereo-fx reverberator
  (aleftin inleta leftin)
  (arightin inleta rightin)
  (idelay = 0.71)
  (icutoff = 12000)
  ((aleftout arightout) reverbsc aleftin arightin idelay icutoff)
  (outleta leftout aleftout)
  (outleta rightout arightout))

(def-simple-stereo-fx compressor
  (aleftin inleta leftin)
  (arightin inleta rightin)
  (kthreshold = 25000)
  (icomp1 = 0.5)
  (icomp2 = 0.763)
  (irtime = 0.1)
  (iftime = 0.1)
  (aleftout dam aleftin kthreshold icomp1 icomp2 irtime iftime)
  (arightout dam arightin kthreshold icomp1 icomp2 irtime iftime)
  (outleta leftout aleftout)
  (outleta rightout arightout))

(def-simple-output output
  (aleftin inleta leftin)
  (arightin inleta rightin)
  (outs aleftin arightin))

;;; ---------------------------------------------------------------
;;; Example usage
;;; ---------------------------------------------------------------

#|
(clear-csound-library)

(defcsinstr fmtest
  (:type :instrument)
  (:pfields amp midi mod index1 index2 rise dec pan1 pan2)
  (:globals
   (gisine ftgen 1 0 16384 10 1))
  (:outputs (leftout rightout))
  (:body
   (kamp = (ampdb p4))
   (kcps = (mtof p5))
   (kmod = p6)
   (kndx line p7 p3 p8)
   (irise = p9)
   (idec = p10)
   (kpan line p11 p3 p12)
   (asig foscili kamp kcps 1 kmod kndx gisine)
   (aenv linen 1 irise p3 idec)
   (aout = "asig * aenv")
   ((asigl asigr) pan2 aout kpan)
   (outleta leftout asigl)
   (outleta rightout asigr))
  (:doc "FM stereo instrument with evolving index and pan."))

(def-simple-stereo-fx reverberator
  (aleftin inleta leftin)
  (arightin inleta rightin)
  (idelay = 0.71)
  (icutoff = 12000)
  ((aleftout arightout) reverbsc aleftin arightin idelay icutoff)
  (outleta leftout aleftout)
  (outleta rightout arightout))

(def-simple-stereo-fx compressor
  (aleftin inleta leftin)
  (arightin inleta rightin)
  (kthreshold = 25000)
  (icomp1 = 0.5)
  (icomp2 = 0.763)
  (irtime = 0.1)
  (iftime = 0.1)
  (aleftout dam aleftin kthreshold icomp1 icomp2 irtime iftime)
  (arightout dam arightin kthreshold icomp1 icomp2 irtime iftime)
  (outleta leftout aleftout)
  (outleta rightout arightout))

(def-simple-output output
  (aleftin inleta leftin)
  (arightin inleta rightin)
  (outs aleftin arightin))

(setf ev1
      (cs-event "fmtest"
                :start (sort-asc (rnd-number 8 0.0 8.0))
                :dur   (rnd-number 8 0.5 3.0)
                :amp   -18
                :midi  (rnd-number 8 24 72)
                :mod   (rnd-number 8 1.10 1.99)
                :index1 12
                :index2 3
                :rise  0.1
                :dec   0.25
                :pan1  0
                :pan2  1))

(def-csound-score
  :file "/Users/stephaneboussuge/test.csd"
  :instruments '("fmtest")
  :fx '("reverberator" "compressor" "output")
  :score-headers '("; generated from Opusmodus")
  :events (list ev1)
  :play t)
|#

;;; ===============================================================
;;; END
;;; ===============================================================