;;;; bujagame-jukebox.asd

(asdf:defsystem #:bujagame-jukebox
  :description "Describe bujagame-jukebox here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :depends-on (#:iterate
               #:alexandria
               #:toot
               #:com.gigamonkeys.binary-data
               #:babel
	       #:opticl
	       #:cl-fad
	       #:cl-opengl
	       #:glop
	       #:rtg-math)
  :serial t
  :components ((:file "package")
               (:file "bujagame-jukebox")
	       (:file "gl-types")
	       (:file "images")
	       (:file "glop-loop")
	       (:file "server")))

