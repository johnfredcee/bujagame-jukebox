

(in-package #:bujagame-jukebox)


(defparameter *acceptor* nil)

(defun fallback-handler (request)
  (let ((s (toot:send-headers request)))
    (format s "<html><head><title>Hello, world!</title></head><body><p>Hello, world!</p></body></html>")))

(defun start-bujagame-server (port)
  (setf *acceptor* (toot:start-server :port port :handler 'fallback-handler))
  (format nil "http://localhost:~d/" (toot:port *acceptor*)))


(defun stop-bujagame-server ()
  (toot:stop-acceptor *acceptor*))
