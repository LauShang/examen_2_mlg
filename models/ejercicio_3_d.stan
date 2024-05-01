
data {
  int<lower=0> fire_calls; 
}

parameters {
  real<lower=0> alpha; 
  real<lower=0> beta;  
  vector[3] lambda;    
}

generated quantities {
  int<lower=0> predicted_building_fires;
  real lambda_19066 = lambda[3];        
  predicted_building_fires = poisson_rng(lambda_19066 * fire_calls);
}

