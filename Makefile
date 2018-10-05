inputconditioner: inputconditioner.t
	rm inputconditioner
	./inputconditioner

inputconditioner.t: inputconditioner.v inputconditioner.t.v
	iverilog -o inputconditioner inputconditioner.t.v	
