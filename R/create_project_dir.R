
########################################################
##
## @utor - 06-08-2018
##      funcion que crea estructura carpeta para el
##      el proyecto
##
########################################################

#' @title crear directorio del proyecto
#' @description esta funcion cre la esrtrucutra de carpetas para el proyecto.
#' @path ruta donde se creara el proyecto.
#' @name create_project_dir.
#' @export

create_project_dir<- function(path,name){

        dir.create(path2<-file.path(path, name), showWarnings = FALSE)
        dir.create(file.path(path2, "Manuales"), showWarnings = FALSE)
        dir.create(file.path(path2, "Main_Project"), showWarnings = FALSE)
        dir.create(file.path(path2, "Automatization"), showWarnings = FALSE)
        dir.create(file.path(path2, "DataTreatment"), showWarnings = FALSE)

        main_project<-paste0(path2,"/","Main_Project")

        dir.create(file.path(main_project,"Data"), showWarnings = FALSE)
        dir.create(file.path(main_project,"Scripts"), showWarnings = FALSE)
        dir.create(file.path(main_project,"Model"), showWarnings = FALSE)
        dir.create(file.path(main_project,"Staging"), showWarnings = FALSE)

        main_scripts<-paste0(main_project,"/","Scripts","/")
        main_data<-paste0(main_project,"/","Data","/")

        dir.create(file.path(main_scripts,"Config"), showWarnings = FALSE)
        dir.create(file.path(main_scripts,"Executions"), showWarnings = FALSE)
        dir.create(file.path(main_scripts,"Functions"), showWarnings = FALSE)
        dir.create(file.path(main_scripts,"Executions"), showWarnings = FALSE)
        dir.create(file.path(main_scripts,"Old_Scripts"), showWarnings = FALSE)

        dir.create(file.path(main_data,"Input"), showWarnings = FALSE)

        main_input<-paste0(main_data,"Input","/")

        dir.create(file.path(main_data,"Output"), showWarnings = FALSE)
        dir.create(file.path(main_data,"Rawdata"), showWarnings = FALSE)

        dir.create(file.path(main_input,"Auxiliars"), showWarnings = FALSE)

}
