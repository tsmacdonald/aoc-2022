(defpackage aoc-2022/tests/main
  (:use :cl
        :aoc-2022
        :rove))
(in-package :aoc-2022/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :aoc-2022)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
