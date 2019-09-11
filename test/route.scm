(use-modules (guest test)
             (schingle route))

(define make-pathmap (@@ (schingle route) make-pathmap))
(define pathmap-ref (@@ (schingle route) pathmap-ref))

(define-test (schingle route pathmap)
  (equal? (pathmap-ref #f '("a" "b") 'default) 'default)
  (equal? (pathmap-ref (make-hash-table) '("a" "b") 'default) 'default)
  (equal? (pathmap-ref (make-pathmap '("a" :b) 5) '("a" "b") 'default) 5)
  (equal? (pathmap-ref (make-pathmap '("a" "c") 5) '("a" "b") 'default) 'default)
  (equal? (pathmap-ref (make-pathmap '("a" "c") 5) '("a" "c" "d")) #f))

(define-test (schingle route pathmap-splat)
  (equal? (pathmap-ref (make-pathmap '("a" (*) "b") 5) '("a" "b")) 5)
  (equal? (pathmap-ref (make-pathmap '("a" ("y" * ".c") "b") 5) '("a" "yx.c" "b")) 5)
  (equal? (pathmap-ref (make-pathmap '("a" (*) "b") 5) '("a" "c" "b")) 5)
  (equal? (pathmap-ref (make-pathmap '("a" (*) "b") 5) '("a" "c" "d" "b")) 5)
  (equal? (pathmap-ref (make-pathmap '("a" (*) "b") 5) '("a" "c" "d" "b")) 5)
  (equal? (pathmap-ref (make-pathmap '("a" (*) "c" (*) "e") 5) '("a" "b" "c" "d" "e")) 5)
  (equal? (pathmap-ref (make-pathmap '("a" (*) "c" (*) "e") 5) '("a" "c" "c" "c" "e")) 5)
  (equal? (pathmap-ref (make-pathmap '("a" (*) "c" (*) "e") 5) '("a" "c" "c" "c" "c" "e")) 5))
