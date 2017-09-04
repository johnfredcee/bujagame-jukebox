
(in-package #:bujagame-jukebox)

(defmethod glop:on-button (window pressed button)
  (declare (ignore window))
  (format t "Button ~:[released~;pressed~]: ~S~%" pressed button))

(defmethod glop:on-mouse-motion (window x y dx dy)
  (declare (ignore window x y dx dy))
  (format t "Mouse motion~%"))

(defmethod glop:on-resize (window w h)
  (declare (ignore window))
  (gl:viewport 0 0 w h)
  (format t "Resize: ~Sx~S~%" w h))

(defmethod glop:on-draw (window)
  (declare (ignore window))
  (format t "Draw~%"))

(defmethod glop:on-close (window)
  (declare (ignore window))
  (format t "Close~%"))

(defun gl-main ()
  (glop:with-window (win "Glop test window" 800 600)
    (format t "Created window: ~S~%" win)
    ;; GL init
    (gl:clear-color 0.3 0.3 1.0 0)
    ;; setup view
    (gl:matrix-mode :projection)
    (gl:load-identity)
    (gl:ortho 0 1 0 1 -1 1)
    ;; idle loop, we draw here anyway
    (loop while (glop:dispatch-events win :blocking nil) do
          ;; rendering
          (gl:clear :color-buffer)
          (gl:color 1 1 1)
          (gl:with-primitive :polygon
                             (gl:vertex 0.25 0.25 0)
                             (gl:vertex 0.75 0.25 0)
                              (gl:vertex 0.75 0.75 0)
                              (gl:vertex 0.25 0.75 0))
          (glop:swap-buffers win))))
