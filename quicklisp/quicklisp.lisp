(in-package :cl-utils-pw.quicklisp)

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
