module apb(
  input pclk,
  input presetn,

  input [1:0] psel,
  input pwrite,
  input penable,

  input [3:0] pwdata,
  input [3:0] paddr,

  input [3:0] prdata0,
  input [3:0] prdata1,
  input [3:0] prdata2,

  output reg [3:0] data,
  output reg pready
);

always @(posedge pclk or negedge presetn)
begin
  if (!presetn)
  begin
    data   <= 0;
    pready <= 0;
  end
  else
  begin
    if (|psel && !penable)
    begin
      pready <= 0;
    end
    else if (|psel && penable)
    begin
      case (psel)
        2'b00: begin
          if (pwrite)
            data <= pwdata;     // WRITE
          else
            data <= prdata0;    // READ
        end
        2'b01: begin
          if (pwrite)
            data <= pwdata;
          else
            data <= prdata1;
        end
        2'b10: begin
          if (pwrite)
            data <= pwdata;
          else
            data <= prdata2;
        end
        2'b11: begin
          if (pwrite)
            data <= pwdata;
          else
            data <= prdata2;
        end
        default: data <= 0;

      endcase

      pready <= 1; 
    end
    else
    begin
      pready <= 0;
    end
  end
end

endmodule
