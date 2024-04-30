
data {
  real y_obs;
  int<lower=0> n_obs;
}

parameters {
  real mu;
  real<lower=0> sigma;
}

model {
  // Priors
  mu ~ normal(20, 10);
  sigma ~ normal(0, 5.5);

  // Likelihood
  y_obs ~ normal(mu, sigma / sqrt(n_obs));
}

