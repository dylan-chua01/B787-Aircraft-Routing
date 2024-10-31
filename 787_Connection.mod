/*********************************************
 * OPL 22.1.1.0 Model
 * Author: dylanchua
 * Creation Date: Oct 10, 2024 at 4:48:27 PM
 *********************************************/
 
//Variables
 int f=...; 
 range F=1..f; 
 int n=...; 
 range N=1..n; 
 range S = 15..21;
 int A=...;
 
 int c[N][N] = ...; 
 int M[N][N] =...; 
 
 //Decision Variables
 dvar boolean x[N][N]; 
 dvar int+ y[S];
 
 //Objective Function
 minimize 
 	sum(i in N,j in N) c[i][j] * x[i][j]; 	
 
 //Constraints
 subject to {
  
   ctFleetSize:
   		sum(s in S) y[s]==A; 
   		
	//flight coverage constraint
	ctFlightCoverage:
		forall(i in F)
		  sum(j in N) M[i][j] *x[i][j] ==1; 
		  
    //flow balance for all flight nodes
    ctFlowBalance:
    	forall(j in F)
    	  sum(i in N) M[i][j]*x[i][j] - 
    	  	sum(i in N) M[j][i]*x[j][i] == 0; 
   
   //source node to first flights for each station, s
   forall (s in S)
     y[s] - sum(i in F) M[s][i]*x[s][i] == 0; 
     
   //overnight aircraft flow conservation for each station
   sum(i in F) M[15][i]*x[15][i] - sum(i in F) M[i][22]*x[i][22] == 0; 
   sum(i in F) M[16][i]*x[16][i] - sum(i in F) M[i][23]*x[i][23] == 0; 
   sum(i in F) M[17][i]*x[17][i] - sum(i in F) M[i][24]*x[i][24] == 0;  
   sum(i in F) M[18][i]*x[18][i] - sum(i in F) M[i][25]*x[i][25] == 0; 
   sum(i in F) M[19][i]*x[19][i] - sum(i in F) M[i][26]*x[i][26] == 0;
   sum(i in F) M[20][i]*x[20][i] - sum(i in F) M[i][27]*x[i][27] == 0;
   sum(i in F) M[21][i]*x[21][i] - sum(i in F) M[i][28]*x[i][28] == 0; 
   }
   
//output and display my results
execute Display_result {
  writeln("Routing model results are shown below:");
  
  for (var i in N)
  	for (var j in N)
  		if(x[i][j] == 1){
  		  writeln ("Flight ", i, " is connected with flight ", j);
  		  }
  }
   