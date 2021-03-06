data(SEITL_deter)


SEIT2L_deter_name <- "deterministic SEIT2L model with daily incidence and constant population size"
SEIT2L_state.names <- c("S","E","I","T1", "T2","L","Inc")

SEIT2L_simulateDeterministic <- function(theta,init.state,times) {

	SEIT2L_ode <- function(time, state, theta) {

		# param
		beta <- theta[["R0"]]/theta[["D_inf"]]
		epsilon <- 1/theta[["D_lat"]]
		nu <- 1/theta[["D_inf"]]
		alpha <- theta[["alpha"]]
		tau <- 1/theta[["D_imm"]]

		# states
		S <- state[["S"]]
		E <- state[["E"]]
		I <- state[["I"]]
		T1 <- state[["T1"]]
		T2 <- state[["T2"]]
		L <- state[["L"]]
		Inc <- state[["Inc"]]

		N <- S + E +I + T1 + T2 + L

		dS <- -beta*S*I/N + (1-alpha)*2*tau*T2
		dE <- beta*S*I/N - epsilon*E
		dI <- epsilon*E - nu*I
		dT1 <- nu*I - 2*tau*T1
		dT2 <- 2*tau*T1 - 2*tau*T2
		dL <- alpha*2*tau*T2
		dInc <- epsilon*E

		return(list(c(dS,dE,dI,dT1,dT2,dL,dInc)))
	}


	# put incidence at 0 in init.state
	init.state["Inc"] <- 0

	traj <- as.data.frame(ode(init.state, times, SEIT2L_ode, theta, method = "ode45"))

	# compute incidence of each time interval
	traj$Inc <- c(0, diff(traj$Inc))

	return(traj)

}


SEIT2L_deter <- fitmodel(
	name=SEIT2L_deter_name,
	state.names=SEIT2L_state.names,
	theta.names=SEITL_theta.names,
	simulate=SEIT2L_simulateDeterministic,
	dprior=SEITL_prior,
	rPointObs=SEITL_genObsPoint,
	dPointObs=SEITL_pointLike)
