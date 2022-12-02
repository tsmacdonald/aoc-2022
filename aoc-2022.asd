(defsystem "aoc-2022"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on (#:str)
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "aoc-2022/tests"))))

(defsystem "aoc-2022/tests"
  :author ""
  :license ""
  :depends-on ("aoc-2022"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for aoc-2022"
  :perform (test-op (op c) (symbol-call :rove :run c)))
