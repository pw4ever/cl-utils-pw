;;;; cl-utils-pw.asd

(asdf:defsystem #:cl-utils-pw
  :serial t
  :description "Common Lisp utility collection."
  :author "Wei Peng <write.to.peng.wei@gmail.com>"
  :license "MIT"
  :depends-on (
	       #:alexandria
	       #:quicklisp
               #:swank
	       #:iterate
	       #:getopt
	       )
  :components ((:file "package")

	       (:module :getopt
		:components ((:file "package")
			     (:file "getopt")))

	       (:module :swank
		:components ((:file "package")
			     (:file "swank")))

	       (:module :quicklisp
		:components ((:file "package")
			     (:file "quicklisp")))

	       (:module :util
		:components ((:file "package")
			     (:file "util")))

	       ))

