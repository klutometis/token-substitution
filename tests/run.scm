(use token-substitution test)

(test "List substitution"
      '(a 2)
      (let ((document '(a (%data b))))
        (substitute-tokens document '((b . 2)))))

(test "Vector substitution"
      '#(a 2)
      (let ((document '#(a (%data b))))
        (substitute-tokens document '((b . 2)))))

(test "List and vector substitution"
      '#((grid . #((colModel #((name . id))))))
      (let ((document '#((grid . #((colModel #((name . (%data name)))))))))
        (substitute-tokens document '((name . id)))))

(test "Substitute #f (should not be mistaken for lack of value)."
      '(#f)
      (substitute-tokens '((%data false)) '((false . #f))))
