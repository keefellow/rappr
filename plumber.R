library(plumber)
library(randomForestSRC)

rf_model <-readRDS("model.Rds")

#* @filter cors
  res$setHeader("Access-Control-Allow-Origin","*")
  if (req$REQUEST_METHOD == "OPTIONS"){
        res$setHeader("Access-Control-Allow-Methods","*")
        res$setHeader("Access-Control-Allow-Headers",req$HTTP_ACCESS_CONTROL_REQUEST_HEADERS)
        res$status <-200
        return(list())
        else {
        plumber::forward()  
        }
}
      
#* @post /predict
function(req,res){
  data<-tryCatch(json::parse_json(req$postBody,simplifyVector=TRUE),
                 error = function(e) NULL)
  if (is.null(data)){
    res$status <- 400
    list(error = "No data submitted")
  }
  data <- data.frame(data)
  ret<-predict(rf_model,data)
  ret<-ret$chf[,length(ret$time.interest)]
  ret
  
  }
  
} 