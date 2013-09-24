(in-package :cl-utils-pw.util)

(defmacro with-keywords (keywords args &body body)
  "Run BODY with keyword arguments in ARGS bond to corresponding symbols."
  `(apply #'(lambda (&key ,@keywords &allow-other-keys) ,@body) ,args))
