;;;; cl-utils-pw.lisp

(in-package #:cl-utils-pw)

(defmacro with-swank-server (port-file &body body)
  "Run BODY (which is ideally an event loop)with Swank TCP server for Emacs started and the port number stored in PORT-FILE (with \"swank:start-server\")."
  (alexandria:with-gensyms (delete-port-file)
    `(let ((,delete-port-file (lambda () (when (probe-file ,port-file) (delete-file ,port-file)))))
       (unwind-protect (progn
			 (funcall ,delete-port-file)
			 (swank:start-server ,port-file :dont-close t)
			 ,@body)
	 (funcall ,delete-port-file)))))

(defmacro with-keywords (keywords args &body body)
  "Run BODY with keyword arguments in ARGS bond to corresponding symbols."
  `(apply #'(lambda (&key ,@keywords &allow-other-keys) ,@body) ,args))

(defmacro quickload-and-optionally-use (&rest systems-or-use)
  "quickload and optionally (all SYSTEMS after T and before end/NIL) use the SYSTEMs"
  `(progn
     ,@(let ((use nil))
	 (loop :for system :in systems-or-use
	       :if (or (null system) (eql system t))
	       :do (setf use system)
	       :else
	       :collect
	       `(progn
		  (ql:quickload ,system)
		  (when ,use
		    (use-package ,system)))
	       :end))))
