(in-package #:cl-utils-pw.getopt)

(defparameter *getopts* nil
  "the OPTION argument to GETOPT:GETOPT")

(defparameter *init-opts* (make-hash-table :test 'equal))

(defun declare-getopt-options (&rest options)
  "alist of (OPTION . TYPE). TYPE is one of :REQUIRED, :OPTIONAL, :NONE as understood by GETOPT:GETOPT.

Example:
(apply #'declare-getopt-options
       '(
	 (:world . :required)
	 (:random-state . :optional)
	 (:repl . :none)
	 (:init . :none)
	))
"
  (iterate:iter
    (iterate:for (option . type) :in options)
    (let ((option (string-upcase (if (stringp option) option (symbol-name option)))))
      (push (list (string-downcase option) type t) *getopts*)
      (setf (gethash (make-keyword option) *init-opts*) nil))))

(defun parse-getopt-options (arg-list)
  "ARG-LIST should be, for example, #+SBCL SB-EXT:*POSIX-ARGV*"
  (let ((opts (alist-hash-table 
	       (mapcar #'(lambda (opt) 
			   (cons (make-keyword (string-upcase (car opt))) (cdr opt)))
		       (nth-value 1 (getopt:getopt arg-list *getopts*)))
	       :test 'equal)))
    (iterate:iter
      (iterate:for (opt val) :in-hashtable *init-opts*)
      (setf (gethash opt *init-opts*)
	    (ensure-gethash opt opts nil)))))

(defun getopt (option)
  "get OPTION"
  (ensure-gethash option *init-opts* nil))

(defun getopts ()
  "return all options"
  (hash-table-alist *init-opts*))

(defun setopt (option value)
  "set OPTION"
  (setf (gethash option *init-opts*) value))

(defun help ()
  "return a help string on the command-line options"
  (format nil "~{~A~^ ~}"
	  (iter:iter
	   (iter:for (option type . rest) :in *getopts*)
	   (when option
	     (iter:collect
	      (format nil "--~A~A"
		      option
		      (case type
			(:none "")
			(:optional "[=]")
			(:required "=")
			(t ""))))))))
