;;;; cl-utils-pw.asd

(asdf:defsystem #:cl-utils-pw
  :serial t
  :description "Common Lisp utility collection."
  :author "Wei Peng <write.to.peng.wei@gmail.com>"
  :license "MIT"
  :depends-on (#:alexandria
               #:swank)
  :components ((:file "package")
               (:file "cl-utils-pw")))

