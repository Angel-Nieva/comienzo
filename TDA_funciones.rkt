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
;Funcion que recorre recorre recursivamente (recursion de cola) una lista, por cada elemento revisado se pregunta si se encuentra en una segunda lista,
;  si el elemento no se encuentra en la lista se agrega a una tercera.
;Entrada: lista de archivos, index(zona de trabajo), lista de archivos
;Salida: Lista sin archivos repetidos (lista salida)
(define ingresar_archivos_index_no_encapsulada (lambda (lista_archivos index salida)
                  (if (null? lista_archivos)
                          salida
                          (if (comparar_archivo_lista (car lista_archivos) index)
                               (ingresar_archivos_index_no_encapsulada (cdr lista_archivos) index salida) ;Si se encuentra el archivo en index
                               (ingresar_archivos_index_no_encapsulada (cdr lista_archivos) index (append salida (list (car lista_archivos))));Si no se encuentra en index
                          )
                   )              
          )
)
;Encapsula la funcion anterior fijando la salida como una lista vacia para comenzar a ingresar archivos dentro
(define ingresar_archivos_index (lambda (lista_archivos index)
            (ingresar_archivos_index_no_encapsulada lista_archivos index '())
      )
)

;Funcion que modifica un repositorio para ingresar una funcion "add" dentro de la sub-lista funciones
;Entrada: lista con archivos, repositorio
;Salida: nuevo repositorio con los cambios registrados del workspace al index y la funcion utilizada
(define add-repository (lambda (archivos zonas)
    (rep_set_funciones (rep_set_index zonas (append (rep_get_index zonas) (ingresar_archivos_index archivos (rep_get_index zonas))))(append (rep_get_funciones zonas)'("add") )))
)

;Funcion que compara dos listas (archivos ingresados y workspace) y entrega un repositorio con los archivos ingresados
;Entrada: lista de archivos, repositorio
;Salida: si los archivos se encuentran en el workspace entrega un nuevo repositorio con los archivos ingresados en el index, sino se despliega un mensaje
(define add-no-curry (lambda (archivos zonas)
                 (if (null? archivos)
                     zonas
                     (if (comparar_archivos_lista archivos (rep_get_workspace zonas))
                         (add-repository archivos zonas)
                         "Un archivo no fue encontrado en el workspace"
                         )
                  )      
          )
)

;Funcion que encapsula la funcion anterior y pregunta si los datos ingresados son correctos
;Entrada: lista archivos, repositorio
;Salida: si los archivos son correctos entrega un nuevo repositorio con los archivos ingresados en el index, sino se despliega un mensaje
(define add (lambda (archivos)
             (lambda (zonas)
                  (if (and (lista_string? archivos)(repository? zonas))
                      (add-no-curry archivos zonas)
                      "Error en el ingreso de datos"
                  )
             )     
       )
)

;(rep_set_index zonas archivos)
;(((git add)'("asd" "asd"))repo1)
(define repo1 (list "master" '("asd" "str1" "str2") '("str1") '() '() '()))