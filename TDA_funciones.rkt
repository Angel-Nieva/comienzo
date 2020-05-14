#lang racket
;TDA Comandos: nos permiten trabajar entre las zonas de trabajo, por lo que seran puramente funciones

;La funcion git es un tipo de funcion de pertenencia, tiene como parametro una funcion y en cao de que el parametro no corresponda a una funcion retorna #f
(define git (lambda (funcion)
              (if (= (funcion? (funcion)) #t) 
                  (lambda (parametros)(funcion parametros))
                  #f
              )    
            )
)

;Pregunta si un parametro es una funcion, retorna true si corresponde a alguna de las funciones o false si no
(define funcion? (lambda(funcion)
                   (if (= #t (or (pull? funcion)(add? funcion)(commit? funcion)(push? funcion)) )
                       #t
                       #f
                    )
                  )
)

