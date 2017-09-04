
(in-package #:bujagame-jukebox)

  
(defun make-attribute-data-array (dim type)
  `(make-array ,dim :element-type ',type))

;; GL-PLAYGROUND> (make-attribute-data-array 3 'vec3)
;; (MAKE-ARRAY 3 :ELEMENT-TYPE 'VEC3)

;; GL-PLAYGROUND> (setf *v2-array* (make-array 3 :element-type 'thing :adjustable t))
;; #(0 0 0)

;; Need to think about this; do I work with untyped array elements and unpack to typed?
;; (array-total-size  (aref *v3-array* 0)) - use as size?
;; More convienent to work with lisp arrays and splurge to gpu as and when
;; (make-gpu-buffer )
;; (upload-gpu-buffer )

;; eg (unpack-to-simple-vector (make-array 6 :element-type 'rtg-math.types::vec3 :initial-element (v3:make 0.0 0.0 0.0)))
(defun unpack-to-simple-vector (array)
  (let ((component-count (array-total-size (aref array 0)))
	(element-count (array-total-size array))
	(component-type (array-element-type (aref array 0))))
    (let ((buffer
	   (make-array (* element-count component-count) :element-type component-type)))
    (iterate
      (for component in-vector array with-index element-index)
      (iterate
	(for scalar in-vector component with-index component-index)
	(setf (aref buffer (+ (* element-index component-count) component-index))
	      scalar)))
    buffer)))
