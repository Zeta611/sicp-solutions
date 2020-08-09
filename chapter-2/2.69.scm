(load "huffman-deps.scm")

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaves)
  (define (merge nodes)
    (if (null? (cdr nodes))
        nodes
        (merge
          (adjoin-set (make-code-tree (car nodes)
                                      (cadr nodes))
                      (cddr nodes)))))
  (car (merge leaves)))

; test code
(define sample-pairs
  '((A 8) (B 3) (C 1) (D 1) (E 1) (F 1) (G 1) (H 1)))
(display
  (generate-huffman-tree sample-pairs))
(newline)
; A 0
; B 111
; C 1101
; D 1100
; E 1011
; F 1010
; G 1001
; H 1000
