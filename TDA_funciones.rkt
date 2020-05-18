#lang racket
;TDA Comandos: nos permiten trabajar entre las zonas de trabajo, por lo que seran puramente funciones




;La funcion git es un tipo de funcion de pertenencia, tiene como parametro una funcion y en caso de que el parametro no corresponda a una funcion retorna #f
(define git (lambda (funcion)
              (lambda (parametros)
                    (if (= (funcion? (funcion)) #t) 
                         (lambda (parametros)(funcion parametros))
                          "Funcion invalida"
                    )      
              )    
       )
)

;Pregunta si un parametro es una funcion, retorna true si corresponde a alguna de las funciones o false si no
(define funcion? (lambda(funcion)
                   (if (or (pull? funcion)(add? funcion)(commit? funcion)(push? funcion)) 
                       #t
                       #f
                 )
         )
)


;Git: Funcion que recibe una lista con los nombres de los archivos en workspace y los lleva a index, si la lista esta vacia lleva todos los archivos en index

(define add (lambda (lista)
              (if (= (null? lista) #t)
                  (add-all lista)
                  ()
              )     
        )
)