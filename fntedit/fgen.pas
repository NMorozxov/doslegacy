program font_generator;
 uses graph,crt,dos;
 type
 fonttype=array[0..127,0..7]of byte;
 readktype=(leftkn,rightkn,upkn,downkn,f1kn,f2kn,f3kn,enterkn,esckn,err);
 const
  tx='f1-getchar;f2-putchar;f3-quit';
   wdw=10;htw=8;wdt=15;htt=11;xw=wdw;
   f1f:boolean=false;f2f:boolean=false;iw:byte=0;jw:byte=0;
   if1:byte=4;jf1:byte=1;if2:byte=8;jf2:byte=0;
   cng:boolean=false;flagfont:boolean=false;
   impName='8x8.fnt';OutName='8x8fnt.new';
 var f:file of fontType;
   font:fontType;
   FntC:array[-4..10]of byte;
   yw,xt,yt,i,j,x,y,d,r,e:integer;
   brdr,pw,pw0,pc,pt:pointer;
   fontb:array[0..7,0..7]of boolean;
procedure build;
procedure readFont;
 begin
   for i:=0 to 127 do
   for j:=0 to 7 do font[i,j]:=0;
   assign(f,impname);
   {$i-}reset(f);{$i+}
   if ioresult=0 then begin read(f,font);
   close(f);
   flagfont:=true
   end;
   setintvec(31,@font);
   end;
procedure buildwork;
var is:integer;
   begin
   yw:=(getmaxy-htw*8-9)div 2;
   for i:=0 to 8 do begin
   is:=ImageSize(xw+1,yw+1,xw+wdw,yw+htw);
   line(xw,yw+i*htw,xw+8*wdw,yw+i*htw);
   line(xw+i*wdw,yw,xw+wdw*i,yw*8);
   end;
   getmem(pw,is);
   getmem(pw0,is);
   getimage(xw+1,yw+1,xw+wdw,yw+htw,pw0^);
   end;
procedure buildtable;
   var is,k:integer;
   begin
   xt:=getmaxx-16*wdt-xw-1;
   yt:=(getmaxy-16*htt-8)div 2+8;
   for i:=0 to 16 do begin
   line(xt,yt+i*htt,xt+16*wdt,yt+i*htt);
   line(xt+i*wdt,yt,xt+i*wdt,yt+16*htt);
   end;
   rectangle(xt-1,yt-1,xt+8*wdt-1,yt+16*htt+1);
   rectangle(xt+8*wdt+1,yt-1,xt+16*wdt+1,yt+16*htt+1);
   is:=imagesize(0,0,7,7);
   getimage(0,0,7,7,fntc);
   getmem(pc,is);
   for i:=0 to (8*succ(ord(flagfont)+1)-1) do
   for j:=0 to 15 do begin
   gotoxy(1,1);
   k:=i*16+j;
   if (k=7)or(k=8)or(k=10)or(k=13)
   then outtextxy(0,0,chr(k))
   else write(chr(k));
   Getimage(0,0,7,7,pc^);
   Putimage(0,0,pc^,xorput);
   Putimage(xt+i*wdt+(wdt-8) div 2+1,yt+j*htt+(htt-8) div 2+1,pc^,normalput);
   end;
   getmem(pt,imagesize(0,0,wdt,htt)) end;
   const tx='f1-getchar;f2-putchar;f3-quit';
 begin
   readfont;buildwork;buildtable;gotoXY((80-textwidth(tx) div 8) div 2+1,1);
   write(tx);
   rectangle(0,10,getmaxX,GetmaxY) end;
   {------------------}
   Procedure work;
   function readK:readktype;
   const readktable:array[0..6]of byte=(75,77,72,80,59,60,61);
   temp=5;
   var p:pointer;
   c1,c2:char;
   rk:readktype;
   begin if not(f1f or f2f) then begin
   x:=xw+iw*wdw+3;
   y:=yw+jw*htw+2;   p:=pw;
   Getimage(x,y,x+wdw-7,y+htw-4,p^) end else
 begin if f1f then begin
   x:=xt+if1*wdt;y:=yt+jf1*htt end else
 begin x:=xt+if2*wdt;
   y:=yt+jf2*htt end;
   p:=pt;
   Getimage(x,y,x+wdt,y+htt,p^) end;
   repeat while not keypressed do begin
   putimage(x,y,p^,notput);
   for i:=1 to 50 do if not keypressed then delay(temp);
   putimage(x,y,p^,normalput);
   if not keypressed then for i:=1 to 50 do
   if not keypressed then delay (temp) end;
   rk:=err;
   c1:=readkey;
   if ord(c1)=0 then c2:=readkey else c2:=chr(0);
   if ord(c1)=13 then rk:=enterkn else
   if ord(c1)=27 then rk:=esckn else
   if ord(c1)=0 then for i:=0 to 6 do
   if ord(c2)=readktable[i] then rk:=readktype(i);
   until rk<>err;
   readk:=rk end;
 Procedure moveXY(x:integer);
   procedure left(var i:byte; a,b:byte);
   begin if i=a then i:=b else dec(i) end;
 Procedure right(var i:byte;a,b:byte);
   begin if i=b then i:=a else inc(i) end;
   procedure Up (var i:byte; a:byte);
   begin if i=0 then i:=a else dec(i) end;
 Procedure Down (var i:byte; a:byte);
   begin if i=a then i:=0 else inc(i) end;
   BEGIN
   if f1f then begin
    case x of
    1:left(if1,0,15);
    2:right(if1,0,15);
    3:up(jf1,15);
    4:down(jf1,15); end;
   GotoXY(76,1);write(if1*16+jf1:3) end else
       if f2f then begin
    case x of
    1:left(if2,8,15);
    2:right(if2,8,15);
    3:up(jf2,15);
    4:down(jf2,15); end;
   GotoXY(76,1);write(if2*16+jf2:3) end
   else begin
    case x of
    1:left(iw,0,7);
    2:right(iw,0,7);
    3:up(jw,7);
    4:down(jw,7); end end end;
  Procedure copychar;
  begin
    x:=xw+8*wdw+1;
    x:=x+(xt-x-24) div 2;
    y:=(GetMaxY-32) div 2;
    for i:=0 to 2 do for j:=0 to 2 do
    putimage(x+8*j,y+8*i,fntc,normalput);
    rectangle(x-1,y-1,x+25,y+25) end;
  Procedure Enter;
  Procedure GetChar;
    begin x:=xt+if1*wdt+(wdt-8) div 2+1;
    y:=yt+jf1*htt+(htt-8) div 2+1;
    GetImage(x,y,x+7,y+7,fntC);
    for i:=0 to 7 do
    for j:=0 to 7 do
    if ((fntc[i]) and ( 128 shr j )) <> 0 then
    begin putImage(xw+j*wdw+1,yw+i*htw+1,pw0^,notput);
    FontB[i,j]:=true end else begin
    Putimage(xw+j*wdw+1,yw+i*htw+1,pw0 ^,normalput);
    fontb[i,j]:=false end;copychar;
   GotoXY(76,1);write('   ');f1f:=false;end;
  Procedure Putchar;
    begin
    x:=xt+if2*wdt+(wdt-8) div 2+1;
    y:=yt+jf2*htt+(htt-8) div 2+1;
   Putimage(x,y,fntc,normalput);
   i:=if2*16+jf2-128;
   for j:=0 to 7 do font[i,j]:=fntc[j];
   for i:=0 to 7 do begin
    Fntc[i]:=0; for j:=0 to 7 do begin
   Putimage(xw+j*wdw+1,yw+i*htw+1,pw0^,normalput);
    FontB[i,j]:=false end;end;
    Cng:=true;Copychar;gotoXY(76,1);write('  ');
    f2f:=false end;
    begin
     if f1f then Getchar else if f2f then Putchar
    else begin
    if FontB[jw,iw] then begin
    putimage(xw+iw*wdw+1,yw+jw*htw+1,pw0^,normalput);
    fontB[jw,iw]:=false end else
    begin putimage(xw+iw*wdw+1,yw+jw*htw+1,pw0^,notput);
    fontB[jw,iw]:=true end;
    fntc[jw]:=fntc[jw] xor (128 shr iw);
    copychar end end;
  Procedure quit;
    begin if cng then begin
    assign(f,outname);rewrite(f);write(f,font);
    close(f) end; closegraph;halt end;
  begin
    for i:=0 to 7 do for j:=0 to 7 do
    fontB[i,j]:=false;
    while true do
     case readk of
     leftkn  :movexy(1);
     rightkn :movexy(2);
     upkn    :movexy(3);
     downkn  :movexy(4);
     f1kn    : begin f1f:=true;  f2f:=false end;
     f2kn    : begin f1f:=false; f2f:=true  end;
     f3kn    : quit;
     enterkn : enter;
     esckn   : begin f1f:=false; f2f:=false end end end;
   begin
     d:=CGA; r:=CGAhi;
     initgraph(d,r,'D:\TP\BGI\');
     e:=graphresult;
     if e=0 then begin directvideo:=false;
         build;
         work
         end else    begin  closegraph; writeln(grapherrormsg(e)) end
         end.