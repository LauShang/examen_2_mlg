
data {
  int<lower=0> N;  
  vector<lower=0>[N] fire_calls;  
  array[N] int<lower=0> building_fires;  
}

parameters {
  real<lower=0> alpha;  
  real<lower=0> beta;  
  vector<lower=0>[N] lambda;  
}

transformed parameters {
  real building_fire_rate = alpha / beta;  
}

model {
  // Weakly informative priors for hyperparameters
  alpha ~ normal(0, 10);
  beta ~ normal(0, 10);

  
  lambda ~ gamma(alpha, beta);

  // Likelihood
  for (i in 1:N) {
    building_fires[i] ~ poisson(lambda[i] * fire_calls[i]);
  }
}

