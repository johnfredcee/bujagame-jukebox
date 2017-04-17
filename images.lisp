
;; scratch implementation of a resource - template for macro-ification

(in-package #:bujagame-jukebox)

(defun image-directory ()
  (merge-pathnames "images/" *project-data-path*))

(defun available-image-list ()
  (let ((result (make-array 0 :adjustable t :fill-pointer 0)))
	(labels
		((aquire-image (n) (vector-push-extend n  result)))
	  (cl-fad:walk-directory (image-directory) #'aquire-image))
	result))

(defun create-image (name &key x y channels)
  )

(defun load-image (name)
  )

(defun load-all-images ()
  )

(defun save-image (name)
  )

(defun unload-image (name)
  )

