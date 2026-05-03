module tb_apb;

  reg pclk, presetn;
  reg [1:0] psel;
  reg pwrite, penable;
  reg [3:0] pwdata, paddr;

  reg [3:0] prdata0, prdata1, prdata2;

  wire [3:0] data;
  wire pready;

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

  always #5 pclk = ~pclk;

  initial begin
    $dumpfile("apb.vcd");
    $dumpvars(0, tb_apb);
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

  
    #10;
    presetn = 1;
    @(posedge pclk);
    psel   = 2'b01;
    paddr  = 4'h1;
    pwrite = 1;
    pwdata = 4'h5;
    penable = 0;   

    @(posedge pclk);
    penable = 1;   

    @(posedge pclk);
    psel = 2'b00;
    penable = 0;
    @(posedge pclk);
    psel   = 2'b01;
    paddr  = 4'h2;
    pwrite = 0;
    penable = 0;   
    @(posedge pclk);
    penable = 1;  

    @(posedge pclk);
    psel = 2'b00;
    penable = 0;
    @(posedge pclk);
    psel   = 2'b10;
    paddr  = 4'h5;
    pwrite = 1;
    pwdata = 4'h9;
    penable = 0;   

    @(posedge pclk);
    penable = 1;  

    @(posedge pclk);
    psel = 2'b00;
    penable = 0;

    @(posedge pclk);
    psel   = 2'b10;
    paddr  = 4'h6;
    pwrite = 0;
    penable = 0; 

    @(posedge pclk);
    penable = 1;  

    @(posedge pclk);
    psel = 2'b00;
    penable = 0;

    @(posedge pclk);
    psel   = 2'b11;
    paddr  = 4'h9;
    pwrite = 1;
    pwdata = 4'hF;
    penable = 0;  

    @(posedge pclk);
    penable = 1;  

    @(posedge pclk);
    psel = 2'b00;
    penable = 0;
    @(posedge pclk);
    psel   = 2'b11;
    paddr  = 4'hA;
    pwrite = 0;
    penable = 0;  

    @(posedge pclk);
    penable = 1; 

    @(posedge pclk);
    psel = 2'b00;
    penable = 0;

    #20;
    $finish;
  end

endmodule
