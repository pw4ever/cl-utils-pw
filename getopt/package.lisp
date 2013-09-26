(defpackage #:cl-utils-pw.getopt
  (:use 
   #:cl
   #:alexandria
   )
  (:export
   #:declare-getopt-options
   #:parse-getopt-options
   #:getopts
   #:getopt
   #:setopt
   #:help
   ))

