#lang racket
(require "TDA_otros.rkt")
(require "TDA_commit.rkt")
;TDA REPOSITORIO: Lista compuesta por las 4 zonas de trabajo, rama actual (master rama origen) y un listado con las funciones usadas sobre la rama.
;Ej: (list master workspace index local_repository remote_repository (push add pull))

;TDA WORKSPACE: Lista conformada unicamente por strings, que representaran los nombres de los archivos.
;Ej: (list "archivo1" "archivo2" ....."archivoN")

;TDA INDEX: Lista conformada unicamente por strings, que representaran los nombres de los archivos.
;Ej: (list "archivo1" "archivo2" ....."archivoN")

;TDA LOCAL REPOSITORY: Lista conformada unicamente por commits, el tda commit estara mas detallado en un archivo aparte
;Ej: (list commit1 commit2 .... commitN)

;TDA REMOTE REPOSITORY: Lista conformada unicamente por commits, el tda commit estara mas detallado en un archivo aparte
;Ej: (list commit1 commit2 .... commitN)

;----------------------------------------------------------------CONSTRUCTORES------------------------------------------------------------------------------------
;Funciones que construyen un workspace,index,local repository,remote repository,rama,lista funciones
;Entrada: workspace,index,local repository,remote repository,rama,lista funciones
;(define repositorio_cons_rama (lambda (rama)(if (string? rama) rama null)))
;(define repositorio_cons_workspace (lambda (workspace) (if (lista_string? workspace) workspace null )))
;(define repositorio_cons_index (lambda (index) (if (lista_string? index) index null )))
;(define repositorio_cons_local_rep (lambda (local_rep)(if (lista_commit? local_rep) local_rep null)))
;(define repositorio_cons_remote_rep (lambda (remote_rep)(if (lista_commit? remote_rep) remote_rep null)))
;(define repositorio_cons_funciones (lambda (funciones)(if (lista_string? funciones) funciones null)))

;Funcion que construye un repositorio
;Entrada: workspace,index,local repository,remote repository,rama,lista funciones
;Salida: lista con los datos ingresados si son todos correctos, null en caso contrario
(define cons_repositorio (lambda (rama workspace index local_repository remote_repository funciones)
            (if (and (string? rama)(lista_string? workspace)(lista_string? index)(lista_commit? local_repository)(lista_commit? remote_repository)(lista_string? funciones))
                (list rama workspace index local_repository remote_repository funciones)
                null
            )
       )
)

;----------------------------------------------------------------PERTENENCIA---------------------------------------------------------------------------;

;Funciones que verifican si un dato ingresado corresponde a un workspace,index,local repository,remote repository,rama,lista funciones o repositorio
;Entrada: workspace,index,repositorio local o repositorio remoto en la funcion correspondiente
;Salida: #t si el dato ingresado es correcto, #f en caso contrario
(define rama? (lambda (rama)(string? rama)))
(define workspace? (lambda (workspace)(lista_string? workspace)))
(define index? (lambda (index)(lista_string? index)))
(define local_repository? (lambda (repositorio_local)(lista_commit? repositorio_local)))
(define remote_repository? (lambda (repositorio_remoto)(lista_commit? repositorio_remoto)))
(define funciones? (lambda (funciones)(lista_string? funciones)))

(define repository? (lambda (repositorio)
            (if (and (rama? (list-ref 0))(workspace? (list-ref 1))(index? (list-ref 2))(local_repository? (list-ref 3))(remote_repository? (list-ref 4))(funciones? (list-ref 5)))
                #t
                #f
            )
      )
)

;----------------------------------------------------------------SELECTORES----------------------------------------------------------------------------;
(define repositorio_get_ramificacion (lambda (repositorio)(if (repository? repositorio)(list-ref repositorio 0) null)))
(define repositorio_get_workspace (lambda (repositorio) (if (repository? repositorio)(list-ref repositorio 1) null)))
(define repositorio_get_index (lambda (repositorio)(if (repository? repositorio)(list-ref repositorio 2) null)))
(define repositorio_get_local_rep (lambda (repositorio)(if (repository? repositorio)(list-ref repositorio 3) null)))
(define repositorio_get_remote_rep (lambda (repositorio)(if (repository? repositorio)(list-ref repositorio 4) null)))
(define repositorio_get_funciones (lambda (repositorio)(if (repository? repositorio)(list-ref repositorio 5) null)))












;(define constructor_local_repository(lambda (commit)(list commit)))
;(define constructor_remote_repository(lambda (commit)(list commit)))


                              
