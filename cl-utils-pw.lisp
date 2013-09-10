;;;; cl-utils-pw.lisp

(in-package #:cl-utils-pw)

;;; "cl-utils-pw" goes here. Hacks and glory await!

(defmacro with-swank-server (port-file &body body)
  "Run BODY (which is ideally an event loop) with Swank TCP server for Emacs started and the port number stored in PORT-FILE (with \"swank:start-server\")."
  (alexandria:with-gensyms (delete-port-file)
    `(let ((,delete-port-file (lambda () (when (probe-file ,port-file) (delete-file ,port-file)))))
       (unwind-protect (progn
			 (funcall ,delete-port-file)
			 (swank:start-server ,port-file :dont-close t)
			 ,@body)
	 (funcall ,delete-port-file)))))
