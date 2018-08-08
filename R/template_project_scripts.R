
########################################################
##
## @utor - 07-08-2018
##      funcion que crea estructura carpeta para el
##      el proyecto
##
########################################################

#' @title crear templates de scripts para proyectos de ciencia de datos
#' @description esta funcion crea scripts de ejemplo para proyectos de ciencia de datos.
#' @path ruta donde se creara el proyecto.
#' @name template_project_scripts
#' @export


template_project_scripts<- function(project_path){

        ## create file config.
        project_path<-paste0(project_path,"/Scripts/Config/")

        file.create(paste0(project_path,"Config.R"))
        fileConn<-file(paste0(project_path,"Config.R"))

        head_comment_doc <- c("\n###################################################################################\n")

        comment_doc <-c("##
## wsepulve - 'fecha de modificaci?n' (formato de fecha dd-mm-yyyy).
##      se debe documentar todos los cambios realizados en el c?digo
##\n")

        foo_comment_doc <- c("###################################################################################\n")

        space_comment_doc<- c('\n')

        writeLines(paste0(head_comment_doc,
                          comment_doc,
                          foo_comment_doc,
                          space_comment_doc
        ),
        fileConn)

        close(fileConn)
}
