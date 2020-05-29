#lang racket
(require "TDA_repositorios.rkt")
(require "TDA_otros.rkt")
(require "TDA_commit.rkt")
;TDA Comandos: nos permiten trabajar entre las zonas de trabajo, por lo que seran puramente funciones



;-----------------------------------------------------------------------GIT---------------------------------------------------------------------------------------;
;Funcion currificada que recive una funcion(comando) con los parametros propios de esta funcion
;Entrada: funcion que representa un comando de git, parametro de entrada del comando, repositorio
;Salida: comando con los parametros ingresados
(define git (lambda (funcion)
              (lambda (parametros)
                (funcion parametros)    
              )    
       )
)

;------------------------------------------------------------------------ADD-------------------------------------------------------------------------------------;

;Funcion que modifica un repositorio para ingresar una funcion "add" dentro de la sub-lista funciones y copiar los archivos del workspace al index
;Entrada: lista con archivos, repositorio
;Salida: nuevo repositorio con los cambios registrados del workspace al index y la funcion utilizada
(define add-repository (lambda (archivos zonas)
    (rep_set_funciones (rep_set_index zonas archivos) (append (rep_get_funciones zonas) '("add")) ) )
)

;Funcion que compara dos listas (archivos ingresados y workspace) y entrega un repositorio con los archivos ingresados
;Entrada: lista de archivos, repositorio
;Salida: si los archivos se encuentran en el workspace entrega un nuevo repositorio con los archivos ingresados en el index, sino se despliega un mensaje
(define add-no-curry (lambda (archivos zonas)
                 (if (null? archivos)
                     (rep_set_funciones zonas '("add"))
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
;--------------------------------------------------------------------COMMIT-------------------------------------------------------------------------------------;
;Funcion que retorna el ultimo commit en el repositorio local
;Entrada: repositorio local
;Salida: commit
(define get-last-commit (lambda (local-rep)(if (null? (cdr local-rep)) (car local-rep) (get-last-commit(cdr local-rep)))))

;Funcion que crea un commit con un mensaje descriptivo, los archivos guardados en index y el identificador del ultimo commit guardado en el repositorio local
;Entrada: mensaje descriptivo y repositorio con las zonas de trabajo
;Salida: Si el repositorio local esta vacio crea el primer commit (Id anterior = 0), si no retorna un nuevo commit con el id del commit anterior
(define crear_commit (lambda (mensaje zonas)
                  (if (null? (rep_get_local_rep zonas)) ;Si el repositorio local esta vacio
                      (cons_commit "Angel" mensaje (rep_get_index zonas) 0) ;Se crea el commit inicial (id anterior = 0)
                      (cons_commit "Angel" mensaje (rep_get_index zonas) (com_get_id_anterior (get-last-commit (rep_get_local_rep zonas))))
                  )
         )              
)             

;Funcion que crea un repositorio con un nuevo commit agregado al repositorio local y el index vacio
;Entrada: mensaje descriptivo y repositorio con las zonas de trabajo
;Salida: nuevo repositorio con index vacio y cambios guardados en repositorio local
(define commit-no-curry (lambda (mensaje zonas)
        (rep_set_index (rep_set_local_rep zonas (append (rep_get_local_rep zonas) (list (crear_commit mensaje zonas)) )) '( ) ) ;Se vacia el index 
    )
) 

;Funcion que crea un repositorio con un registro de la funcion "commit"
;Entrada: mensaje descriptivo, repositorio (currificada)
;Salida: si los datos de entrada son correctos pregunta si el index esta vacio. Si se encuentra vacio retorna zonas sin cambios, sino retorna una nueva version del repositorio.
;        si los datos de entrada no son correctos retorna un mensaje
(define commit (lambda (mensaje)
                  (lambda (zonas)
                      (if (and (string? mensaje)(repository? zonas))
                            (if (null? (rep_get_index zonas)) ;Si el index esta vacio se retorna las zonas como estaba
                                zonas
                               (rep_set_funciones (commit-no-curry mensaje zonas) (append (rep_get_funciones zonas) '("commit")) );Se deja registro de la funcion "commit"
                            )
                            "Error en el ingreso de datos"
                      )     
              )
      ) 
)
;--------------------------------------------------------------------PUSH----------------------------------------------------------------------------------------;
;Funcion que envia todos los commits en el repositorio local al repositorio remoto
;Entrada: zonas
;Salida: zonas con los cambios guardados y un registro de la funcion "push"
(define push (lambda (zonas)(rep_set_funciones (rep_set_remote_rep zonas (rep_get_local_rep zonas)) '("push"))))
;--------------------------------------------------------------------PULL----------------------------------------------------------------------------------------;





;(rep_set_index zonas archivos)
;(((git add)'("asd" "asd"))repo1)

(define repo1 (list "master" '("asd" "str1" "str2") '("str1") '() '() '("add")))
