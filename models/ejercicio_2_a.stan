
data {
  int<lower=0> N;          
  vector[N] y;             
  vector<lower=0>[N] n;    
}

parameters {
  real mu;                 
  real<lower=0> inv_tau_squared;
  vector[N] mu_i;          
  real<lower=0> sigma;     
}

transformed parameters {
  real<lower=0> tau = sqrt(1 / inv_tau_squared);
}

model {
  // Priors
  mu ~ normal(20, 10);
  inv_tau_squared ~ gamma(0.01, 0.1);
  sigma ~ normal(0, 5.5);
  mu_i ~ normal(mu, tau);
  
  // Likelihood
  y ~ normal(mu_i, sigma ./ sqrt(n));
}

