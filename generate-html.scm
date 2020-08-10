; The list of all files in `directory`.
(define (files-in directory)
  (filter
    (lambda (path)
      (not (file-directory? path)))
    (directory-read directory)))

; The content of `file` as a character list.
(define (file->list file)
  (call-with-input-file
    file
    (lambda (input-port)
      (let loop ((x (read-char input-port)))
        (if (not (eof-object? x))
            (cons x
                  (loop (read-char input-port)))
            '())))))

; The content of `file` as a string.
(define (file->string file)
  (list->string (file->list file)))

; test code
(display
  (file->string
    (car (files-in "chapter-2/"))))
(newline)
