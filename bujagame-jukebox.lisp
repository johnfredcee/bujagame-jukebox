;;;; bujagame-jukebox.lisp

(in-package #:bujagame-jukebox)

;;; "bujagame-jukebox" goes here. Hacks and glory await!

(defun set-project-system (name)
  "Set the name of the game project we are working with. This is the first thing you need to do. Returns the path of system subdirectory for holding data."
  (setf *project-system-path*
		(cl-fad:pathname-directory-pathname
		 (multiple-value-bind (foundp found-system pathname previous previous-time)
			 (asdf:locate-system name)
		   pathname)))
	(setf *project-data-path* (merge-pathnames "data/" *project-system-path*)))



							 
