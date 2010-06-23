(define token-key '%data)

(define (token? object)
  (and (pair? object)
       (eq? (car object) token-key)))

(define token-value cadr)

(define (make-token value)
  (list token-key value))

(define substitute-token
  (case-lambda
   ((token key-values)
    (substitute-token token
                      key-values
                      (lambda (key)
                        (error 'substitute-token "key not found" key))))
   ((token key-values default)
    (let* ((key (token-value token))
           (value (alist-ref key key-values eq? #f)))
      (if value
          value
          (default key))))))

(define (map-token-tree token-mapper tree)
  (cond ((token? tree)
         (token-mapper tree))
        ((pair? tree)
         (cons (map-token-tree token-mapper (car tree))
               (map-token-tree token-mapper (cdr tree))))
        ((vector? tree)
         (vector-map (lambda (i x)
                       (map-token-tree token-mapper x))
                     tree))
        (else tree)))

(define substitute-tokens
  (case-lambda
   ((tree key-values)
    (map-token-tree (cut substitute-token <> key-values) tree))
   ((tree key-values default)
    (map-token-tree (cut substitute-token <> key-values default) tree))))

(define (substitute-tokens/partial tree key-values)
  (substitute-tokens tree key-values (lambda (key) (make-token key))))
