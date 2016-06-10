#PITCHFORK API                                                                                                                                          
                                                                                                                                                       
##All data taken from http://www.pitchfork.com 
##API is live at https://shrouded-badlands-35511.herokuapp.com/api                                                                                                       
                                                                                                                                                       
#USAGE:                                                                                                                                                 
                                                                                                                                                       
## api/artists                                                                                                                                          
* query arguments:                                                                                                                                    
  * name: filter by artist name                                                                                                                        
  * avg: filter by minimum artist average rating        
  * example: api/artists?name=Pri&avg=8.5                                                                                               
                                                                                                                                                       
## api/artists/:id                                                                                                                                      
* get artist by id      
*  example: api/artists/1                                                                                                                              
                                                                                                                                                       
## api/albums                                                                                                                                           
* query arguments:                                                                                                                                    
  * name: filter by album name                                                                                                                         
  * rating: filter by exact album rating                                                                                                               
  * min\_rating: filter by minimum album rating                                                                                                         
  * artist: filter by artist name 
  * example: api/albums?min\_rating=8.5&artist=Pri                                                                                                              
                                                                                                                                                       
## api/albums/:id                                                                                                                                       
* get album by id  
*  example: api/albums/1
