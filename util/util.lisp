(in-package :cl-utils-pw.util)

(defmacro with-keywords (keywords args &body body)
  "Run BODY with keyword arguments in ARGS bond to corresponding symbols."
  `(apply #'(lambda (&key ,@keywords &allow-other-keys) ,@body) ,args))

(defun random-select-from-list (list &key random-state destructive)
  (let ((*random-state* (if random-state random-state *random-state*))
	(list (if destructive list (copy-list list))))
    (nbutlast (shuffle list) (random (length list)))))

(defun random-list (limit list-length &key random-state)
  (let ((*random-state* (if random-state random-state *random-state*)))
    (loop repeat list-length collect (random limit))))
