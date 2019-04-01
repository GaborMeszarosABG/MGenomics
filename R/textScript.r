#' A Dog Function
#'
#' This function allows you to express your love of dogs.
#' Based on the Cat script of https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/
#' @param love Do you love dogs? Defaults to TRUE.
#' @keywords dogs
#' @export
#' @examples
#' myTestDogs()

myTestDogs <- function(love=TRUE){
    if(love==TRUE){
        print("I love dogs!")
    }
    else {
        print("I am not a cool person.")
    }
}
