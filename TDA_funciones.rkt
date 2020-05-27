#lang racket
(require "TDA_repositorios.rkt")
(require "TDA_otros.rkt")
;TDA Comandos: nos permiten trabajar entre las zonas de trabajo, por lo que seran puramente funciones



;-----------------------------------------------------------------------GIT----------------------------------------------------------------------------------
;Funcion currificada que recive una funcion(comando) con los parametros propios de esta funcion
;Entrada: funcion que representa un comando de git, parametro de entrada del comando, repositorio
;Salida: comando con los parametros ingresados
(define git (lambda (funcion)
              (lambda (parametros)
                  (lambda (zonas)
                      ((funcion parametros)zonas)
                   ) 
              )    
       )
)
;------------------------------------------------------------------------ADD---------------------------------------------------------------------------------

(define add-no-curry (lambda (archivos zonas)
                 (if (null? archivos)
                     zonas
                     (similitud-archivos-workspace zonas archivos)
                  )      
          )
)


(define add (lambda (archivos)
             (lambda (zonas)
                  (if (and (lista_string? archivos)(repository? zonas))
                      (add-no-curry archivos zonas)
                      #f
                  )
             )     
       )
)

;(rep_set_index zonas archivos)
;(((git add)'("asd" "asd"))repo1)
(define repo1 (list "master" '("asd" "asd") '() '() '() '("add" "push" "commit")))