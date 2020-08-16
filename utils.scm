; Put `delim` between each element in list `l`.
(define (put-between delim l)
  (cdr
    (fold-right
      (lambda (hd tl)
        (cons delim (cons hd tl)))
      '()
      l)))

(define (string-replace contents from to)
  (define (from->to contents)
    (string-replace contents from to))
  (let ((from-len (string-length from)))
    (cond ((string-null? contents) "")
          ((string-prefix? from contents)
           (string-append
             to
             (from->to (string-tail contents from-len))))
          (else
            (string-append
              (string-head contents 1)
              (from->to (string-tail contents 1)))))))
