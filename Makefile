inputconditioner: inputconditioner.t
	./inputconditioner

inputconditioner.t: inputconditioner.v inputconditioner.t.v
	iverilog -o inputconditioner inputconditioner.t.v	
