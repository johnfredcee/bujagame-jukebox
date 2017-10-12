

(in-package #:bujagame-jukebox)


;; (defun enough-url (url url-prefix)
;;   "Returns the relative portion of URL relative to URL-PREFIX, similar
;; to what ENOUGH-NAMESTRING does for pathnames."
;;   (let ((prefix-length (length url-prefix)))
;;     (if (string= url url-prefix :end1 prefix-length)
;;         (subseq url prefix-length)
;;         url)))

;;; Simple composite handler that searches a list of sub-handlers for
;;; one that can handle the request.

(defclass search-handler ()
  ((handlers :initarg :handlers :initform () :accessor handlers)))

(defun make-search-handler (&rest sub-handlers)
  (make-instance 'search-handler :handlers sub-handlers))

(defun add-handler (search-handler sub-handler)
  (push sub-handler (handlers search-handler)))

(defmethod handle-request ((handler search-handler) request)
  (loop for sub in (handlers handler)
     do (handle-request sub request) until (response-sent-p request)))

(defun make-exact-path-handler (path sub-handler)
  "Make a handler that handles the request with SUB-HANDLER if the
file name of the request is exactly the given PATH."
  (lambda (request)
    (when (string= path (request-path request))
      (handle-request sub-handler request))))

;; fallback (echo request) handler
(defun fallback-handler (request)
  (with-response-body (s request)
	(format s "~&<html><head><title>Unknown request</title></head><body>")
	(loop for (k . v) in (request-headers request) do
		 (format s "~&<p><code>~a: ~a</code></p>" k v))
	(format s "~&</body></html>")))

;; asset handler
(defun asset-handler ()
  (make-search-handler
   (make-exact-path-handler "/assets" 'list-assets-page)
   (make-instance 'static-file-handler :root (test-document-directory))))

(defun reset-asset-handler ()
  (setf (handler *acceptor*) (asset-handler)))

;; start server
(defparameter *acceptor* nil)

(defun start-bujagame-server (port)
  (setf *acceptor* (toot:start-server :port port :handler (asset-handler)))
  (format nil "http://localhost:~d/" (toot:port *acceptor*)))

(defun stop-bujagame-server ()
  (toot:stop-acceptor *acceptor*))
