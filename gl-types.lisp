g
(in-package #:bujagame-jukebox)


;; (setf *v3-array*  (make-array 3 :element-type 'gl-v3 :initial-element (make-gl-v3)))
;; #(#(0.0 0.0 0.0) #(0.0 0.0 0.0) #(0.0 0.0 0.0))

(defparameter *gl-types*
   ;; size (multiple of 4), default scale, default clamp, base type, count, gl type
   `(:vec1 (4 nil nil single-float 1 :float)
     :vec2 (8 nil nil single-float 2 :float)
     :vec3 (12 nil nil single-float 3 :float)
     :vec4 (16 nil nil single-float 4 :float)
     :vec1u8 (4 255 (0 1) (unsigned-byte 8) 1 :unsigned-byte)
     :vec2u8 (4 255 (0 1) (unsigned-byte 8) 2 :unsigned-byte)
     :vec3u8 (4 255 (0 1) (unsigned-byte 8) 3 :unsigned-byte)
     :vec4u8 (4 255 (0 1) (unsigned-byte 8) 4 :unsigned-byte)
     :vec1s8 (4 127 (-1 1) (signed-byte 8) 1 :byte)
     :vec2s8 (4 127 (-1 1) (signed-byte 8) 2 :byte)
     :vec3s8 (4 127 (-1 1) (signed-byte 8) 3 :byte)
     :vec4s8 (4 127 (-1 1) (signed-byte 8) 4 :byte)
     :vec1u16 (4 65535 (0 1) (unsigned-byte 16) 1 :unsigned-short)
     :vec2u16 (4 65535 (0 1) (unsigned-byte 16) 2 :unsigned-short)
     :vec3u16 (8 65535 (0 1) (unsigned-byte 16) 3 :unsigned-short)
     :vec4u16 (8 65535 (0 1) (unsigned-byte 16) 4 :unsigned-short)
     :vec1s16 (4 32767 (-1 1) (signed-byte 16) 1 :short)
     :vec2s16 (4 32767 (-1 1) (signed-byte 16) 2 :short)
     :vec3s16 (8 32767 (-1 1) (signed-byte 16) 3 :short)
     :vec4s16 (8 32767 (-1 1) (signed-byte 16) 4 :short)))



(defun gl-type (x)
  (typecase x
    (single-float :float)
    ((unsigned-byte 8) :unsigned-byte)
    ((signed-byte 8) :byte)
    ((unsigned-byte 16) :unsigned-short)
    ((signed-byte 16) :short)
    ((unsigned-byte 32) :unsigned-int)
    ((signed-byte 32) :int)))


(defun cl-type (x)
  (case x
    (:float 'single-float)
    (:unsigned-byte '(unsigned-byte 8))
    (:byte '(signed-byte 8))
    (:unsigned-short '(unsigned-byte 16))
    (:short '(signed-byte 16))
    (:unsigned-int '(unsigned-byte 32))
    (:int '(signed-byte 32))))

(defun cl-default-value (x)
  (case x
    (:float (the single-float 0.0))
    (:unsigned-byte (the (unsigned-byte 8) 0))
    (:byte (the (signed-byte 8) 0))
    (:unsigned-short (the (unsigned-byte 16) 0))
    (:short (the (signed-byte 16) 0))
    (:unsigned-int (the (unsigned-byte 32) 0))
    (:int (the (signed-byte 32) 0))))

(defun make-gl-component-array (component-type component-count)
  (make-array component-count :element-type (cl-type component-type) :initial-element (cl-default-value component-type)))	   

(defun gl-component-array-type (component-type component-count)
  `(simple-array ,(cl-type component-type) ,(list component-count)))

(defun make-gl-data-array (element-count component-type component-count)
 (make-array element-count :element-type (gl-component-array-type component-type component-count) :initial-element (make-gl-component-array component-type component-count)))
		   

