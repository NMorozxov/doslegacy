 program code;
 var i,j,k:integer ;
  begin
  for i:=1 to 16 do begin
  for j:=1 to 8 do begin
  k:=128+(i-1)+(j-1)*16;
  write(k:5,'-',chr(k));
  end;
  writeln;
  end
  end.