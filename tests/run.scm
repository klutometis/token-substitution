(load "token-substitution.scm")
(use token-substitution test debug)

(test "list substitution"
      '(a 2)
      (let ((document '(a (%data b))))
        (substitute-tokens document '((b . 2)))))

(test "vector substitution"
      '#(a 2)
      (let ((document '#(a (%data b))))
        (substitute-tokens document '((b . 2)))))

(trace map)

(test "list and vector substitution"
      '#((grid . #((colModel #((name . id))))))
      (let ((document '#((grid . #((colModel #((name . (%data name)))))))))
        (substitute-tokens document '((name . id)))))
