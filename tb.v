module TB;

	reg clk, reset;
	reg [4:0] in_btn, out_btn, in_snsr, out_snsr;

	wire direction, motor;

	Elevator elevator (
		.clk(clk),
		.in_btn(in_btn),
		.out_btn(out_btn),
		.in_snsr(in_snsr),
		.out_snsr(out_snsr),
		.reset(reset),
		.direction(direction),
		.motor(motor)
	);

	initial begin
		clk = 0;
	end

	always #5 clk = ~clk;

	initial begin

		// Level 0: reset

		in_btn = 0;
		out_btn = 0;
		in_snsr = 0;
		out_snsr = 0;
		reset = 1;
		#100;
		reset = 0;
		#100;
		in_snsr[0] = 1;
		out_snsr[0] = 1;
		#100;

		// Level 1: out button 3 pressed
		out_btn[3] = 1; #30; out_btn[3] = 0; #20;
		in_snsr[0] = 0; #50; out_snsr[0] = 0;
		#100;

		// Level 2: pass one floor
		in_snsr[1] = 1; #50; out_snsr[1] = 1;
		#50;
		in_snsr[1] = 0; #50; out_snsr[1] = 0;
		#50;

		// Level 3: out button 4 pressed
		out_btn[4] = 1; #30; out_btn[4] = 0; #20;
		in_snsr[2] = 1; #50; out_snsr[2] = 1;
		#50;
		in_snsr[2] = 0; #50; out_snsr[2] = 0;
		#100;

		// Level 4: reach floor 3
		in_snsr[3] = 1; #50; out_snsr[3] = 1;
		#1000;
		#50;
		in_snsr[3] = 0; #50; out_snsr[3] = 0;
		#50;

		// Level 5: in button 0 (lobby) pressed
		in_btn[0] = 1; #30; in_btn[0] = 0;

		// Level 6: reach floor 4
		#20; in_snsr[4] = 1; #50; out_snsr[4] = 1;
		#1000;
		#50;

		// Level 7: Go down
		in_snsr[4] = 0; #50; out_snsr[4] = 0;
		#100;
		in_snsr[3] = 1; #50; out_snsr[3] = 1;
		#50;
		in_snsr[3] = 0; #50; out_snsr[3] = 0;
		#50;
		
		// Level 8: in button 1 pressed
		in_btn[1] = 1; #30; in_btn[1] = 0; #20;
		in_snsr[2] = 1; #50; out_snsr[2] = 1;
		#50;
		in_snsr[2] = 0; #50; out_snsr[2] = 0;
		#100;

		// Level 9: reach floor 1
		in_snsr[1] = 1; #50; out_snsr[1] = 1;
		#1000;
		#50;
		in_snsr[1] = 0; #50; out_snsr[1] = 0;
		#100;

		// Level 10: reach lobby
		in_snsr[0] = 1; #50; out_snsr[0] = 1;
		#50;

		#100; $finish;
	end

	initial begin
		$dumpfile("result.vcd");
		$dumpvars(0, TB);
	end

endmodule