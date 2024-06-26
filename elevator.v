module Elevator (
	input clk,
	input [4:0] in_btn, out_btn, in_snsr, out_snsr,
	input reset,
	output reg direction, motor
);

	reg [2:0] boundary_floor;
	reg [4:0] floor_requests;

	integer floor_timer;

	integer i;
	reg above, below;

	always @ (posedge clk, posedge reset) begin
		if (reset) begin
			boundary_floor = 0;
			floor_requests = 0;
			floor_timer = 0;
			above = 0;
			below = 0;

			direction = 0;
			motor = 0;
		end
		else begin
			for (i = 0; i < 5; i = i + 1) begin
				if (in_btn[i] || out_btn[i]) begin
					floor_requests[i] = 1;
				end
			end

			above = 0;
			below = 0;

			for (i = 0; i < 5; i = i + 1) begin
				if (floor_requests[i]) begin
					if (i > boundary_floor) above = 1;
					if (i < boundary_floor) below = 1;
				end
			end

			if (floor_timer > 0)
				floor_timer = floor_timer - 1;
			else if (in_snsr != 0 && out_snsr != 0) begin
				boundary_floor = ((in_snsr[0] == 1) ? 0 : (in_snsr[1] == 1) ? 1 : (in_snsr[2] == 1) ? 2 : (in_snsr[3] == 1) ? 3 : 4);
				if (above != below)
					direction = (above == 1) ? 1 : 0;
				if (floor_requests[boundary_floor] == 1) begin
					motor = 0;
					floor_timer = 100;
					floor_requests[boundary_floor] = 0;
				end
				else if ((boundary_floor == 0 && direction == 0) || (boundary_floor == 4 && direction == 1)) begin
					motor = 0;
				end
				else
					motor = 1;
			end
		end
	end
endmodule
