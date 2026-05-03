module tb_apb;

  reg pclk, presetn;
  reg [1:0] psel;
  reg pwrite, penable;
  reg [3:0] pwdata, paddr;

  reg [3:0] prdata0, prdata1, prdata2;

  wire [3:0] data;
  wire pready;

  // DUT Instantiation
  apb uut (
    .pclk(pclk),
    .presetn(presetn),
    .psel(psel),
    .pwrite(pwrite),
    .penable(penable),
    .pwdata(pwdata),
    .paddr(paddr),
    .prdata0(prdata0),
    .prdata1(prdata1),
    .prdata2(prdata2),
    .data(data),
    .pready(pready)
  );

  // Clock generation
  always #5 pclk = ~pclk;

  initial begin
    $dumpfile("apb.vcd");
    $dumpvars(0, tb_apb);

    // Initial values
    pclk    = 0;
    presetn = 0;
    psel    = 2'b00;
    pwrite  = 0;
    penable = 0;
    pwdata  = 4'h0;
    paddr   = 4'h0;

    prdata0 = 4'hA;
    prdata1 = 4'hB;
    prdata2 = 4'hC;

    // Reset
    #10 presetn = 1;

    // Write to Slave 0
    @(posedge pclk);
    psel    = 2'b00;
    pwrite  = 1;
    pwdata  = 4'h5;
    penable = 0;

    @(posedge pclk);
    penable = 1;

    // Read from Slave 0
    @(posedge pclk);
    pwrite  = 0;
    penable = 0;

    @(posedge pclk);
    penable = 1;

    @(posedge pclk);
    psel    = 2'b01;
    pwrite  = 1;
    pwdata  = 4'h6;
    penable = 0;

    @(posedge pclk);
    penable = 1;

    @(posedge pclk);
    pwrite  = 0;
    penable = 0;

    @(posedge pclk);
    penable = 1;

    @(posedge pclk);
    psel    = 2'b10;
    pwrite  = 1;
    pwdata  = 4'h9;
    penable = 0;

    @(posedge pclk);
    penable = 1;

    @(posedge pclk);
    pwrite  = 0;
    penable = 0;

    @(posedge pclk);
    penable = 1;

    @(posedge pclk);
    psel    = 2'b11;
    pwrite  = 1;
    pwdata  = 4'hF;
    penable = 0;

    @(posedge pclk);
    penable = 1;

    @(posedge pclk);
    pwrite  = 0;
    penable = 0;

    @(posedge pclk);
    penable = 1;

    // End
    #20;
    $finish;
  end

endmodule
