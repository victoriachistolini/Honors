
process_corr_matrix <- function(data_matrx, params){
  
  data_matrx = data_matrx[,-c(1:2)]
  chr_vector = character(13*13)
  num_vector = numeric(13*13)
  countr=0
  
  rownames(data_matrx) <- params
  colnames(data_matrx)<- params[2:length(params)]
  
  for (i in 1:length(params)){
    
    for (j in 1:(length(params)-1)){
       
      vals = data_matrx[i,j]
      #vals = data_matrx[1,1]
       if (is.na(vals)){
         next
       }
      
       if(vals > 0.4){
         chr_vector[countr] = paste(rownames(data_matrx)[i],colnames(data_matrx)[j],sep=" ~ ")
         num_vector[countr] = vals
         countr=countr+1
         
       }
  
    }
  }
  

  output = data.frame(num_vector,chr_vector)
  colnames(output) = c("Correlation_Coef", "Params")
  
  
  return(output)
  
  
  
}

data_matrx = read.csv("/Users/jhkamherst/Desktop/exp1/spring.csv")
params = c("first_vegtyp", "max_airtemp", "mean_airtemp", "mean_relhum", 
           "mean_sncvr", "mean_sndep", "mean_trnstr", "mean_uwind", "mean_vegcvr", 
           "mean_vwind", "mean_wilt", "min_airtemp", "sum_precip")


q = process_corr_matrix(data_matrx,params)