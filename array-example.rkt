#lang rosette

(writeln "hello")

(require rosette/lib/synthax)
(require rosette/solver/smt/array)

(writeln "includes done")

(output-smt #t)
(current-bitwidth #f)
(define BITS 8)

(writeln "settings done")

(define-symbolic* b1 (bitvector BITS))
(define-symbolic* b2 (bitvector BITS))
(define-symbolic* b3 (bitvector BITS))

(writeln "symbolic defs done")

(define a1 (array-make!))
(define a2 (array-make!))

(solver-assert (current-solver) (list (assert-array-declare a1)))
(solver-assert (current-solver) (list (assert-array-declare a2)))
(solver-assert (current-solver) (list (assert-array-store a1 b1 b2 a2)))
(solver-assert (current-solver) (list (assert-array-select a2 b1 b3)))

(solver-check (current-solver))