
data {
  int<lower=1> N;           // number of players
  vector[N] y;              // observed values for each player
  vector<lower=0>[N] n_obs; // number of observations for each player

  // Hyperparameters
  real mu_mu;               // mean for the general mu
  real<lower=0> tau_alpha;  // shape parameter for the tau distribution
  real<lower=0> tau_beta;   // rate parameter for the tau distribution
}

parameters {
  real general_mu;          // general mean across all players
  real<lower=0> inv_squared_tau; // inverse squared scale for individual player means
  vector[N] mu;             // player-specific means

  // Model parameters
  real<lower=0> sigma;      // common standard deviation
}

transformed parameters {
  real<lower=0> tau = 1 / sqrt(inv_squared_tau); // standard deviation for player means
}

model {
  general_mu ~ normal(mu_mu, 0.01); // very weak prior on general_mu
  inv_squared_tau ~ gamma(tau_alpha, tau_beta);
  mu ~ normal(general_mu, tau); // player-specific means
  y ~ normal(mu, sigma ./ sqrt(n_obs)); // likelihood
}

generated quantities {
  vector[N] y_pred;
  for (i in 1:N) {
    y_pred[i] = normal_rng(mu[i], sigma / sqrt(n_obs[i]));
  }
}

