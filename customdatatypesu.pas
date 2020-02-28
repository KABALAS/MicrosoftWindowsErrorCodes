unit customDatatypesU;

{$mode objfpc}{$H+}
{$MODESWITCH AdvancedRecords}
{$inline on}
{$h+}


interface

uses
  Classes, SysUtils;

Type
  PBit32 = ^TBit32;
  TBit32 = array[1..32] of Boolean;
  PBit64 = ^TBit64;
  TBit64 = array[1..64] of Boolean;

  { TBinary1024 }

  TBinary1024 =
    {$ifndef FPC_REQUIRES_PROPER_ALIGNMENT}
          packed
    {$endif FPC_REQUIRES_PROPER_ALIGNMENT}
    record
    private
      Type
        PBinaryArr = ^TBinaryArr;
        TBinaryArr = Array[1..1024] of Boolean;
      const Size = 1024;
      Function BinToStr(aBin : PBinaryArr): String;
      procedure StrToBin(AValue: String; aBin : PBinaryArr);
      Function BinToWord(aBin : PBinaryArr): QWord;
      procedure WordToBin(AValue: QWord; aBin : PBinaryArr);
    private
      BinaryDecode : TBinaryArr;
      function GetAsString: String;
      function GetAsWord: QWord;
      procedure SetAsstring(AValue: String);
      procedure SetAsWord(AValue: QWord);
    public
      Function GetByteSetAsWord(aRangeFrom, aRangeTo : integer; aShift : integer = 0 ): QWord;
      procedure SetByteSetFromWord(aValue : Qword; aRangeFrom, aRangeTo : integer; aShift : integer = 0 );
      property AsString : String read GetAsString write SetAsstring;
      property AsWord : QWord read GetAsWord write SetAsWord;
    end;

//function SetErrorcode(aError : QWord): TErrorCodeF;

implementation

uses
  windows, math;

//Function BinToWordShift(Bin : PBit32; RangeStart, RangeEnd : Byte):QWord;
//var
//  i : integer;
//  nv : Qword;
//begin
//  nv := 0;
//  result := 0;
//  for i := RangeEnd downto RangeStart do
//  begin
//     nv := nv * 2;
//     if Bin^[i] then
//        inc(nv);
//  end;
//  result := nv;
//end;

//procedure ClearRange(Bin : PBit32; RangeStart, RangeEnd : Byte);
//var
//  ltemP :Bool;
//  i, J : integer;
//begin
//  for i := RangeEnd downto RangeStart do
//  for j := 1 to 32 do
//  begin
//     if j = 1 then ltemP:= Bin^[j];
//     else
//     begin
//       Bin^[j-1] := Bin^[j];
//       if j := 32 then
//       Bin^[j] := ltemP;;
//     end;
//  end;
//end;

//procedure ShiftRight(Bin : PBit32; NumBytes : Byte);
//var
//  i, J : integer;
//begin
//  for i := RangeEnd downto RangeStart do
//     Bin^[i] := False;
//end;

{ TBinary1024 }

function TBinary1024.BinToStr(aBin: PBinaryArr): String;
var
  i : integer;
  f : Boolean;
begin
  f := false;
  result := '';
  for i := Size downto 1 do
    if aBin^[i] or f then
    begin
      if (i mod 4) = 0 then
      result := result + ' ';

      if aBin^[i] then
      begin
         result := result + '1';
         f := true;
      end
      else
        result := result + '0';
    end;

end;

procedure TBinary1024.StrToBin(AValue: String; aBin: PBinaryArr);
var
  l, i : integer;
begin
  l := Length(AValue);
  for i := 1 to Size  do
  if l >= i then
  begin
    if AValue[l-i+1] = '1' then
      aBin^[i] := True
    else
      aBin^[i] := False;
  end
  else
    aBin^[i] := False;
end;

function TBinary1024.BinToWord(aBin: PBinaryArr): QWord;
var
  i : integer;
begin
  result := 0;
  for i := Size downto 1 do
  begin
     result := result * 2;
     if aBin^[i] then
        inc(result);
  end;

end;

procedure TBinary1024.WordToBin(AValue: QWord; aBin: PBinaryArr);
var
  i : integer;
  nv : Qword;
begin
  nv := AValue;
  FillChar(aBin^, sizeof(aBin^), #0);
  for i := 1 to size do
  begin
     if (nv mod 2) = 1 then
     begin
       aBin^[i] := True;
       dec(NV);
     end
     else
       aBin^[i] := False;

     NV := nv div 2;
  end;

end;

function TBinary1024.GetAsString: String;
begin
  result := BinToStr(@BinaryDecode);
end;

function TBinary1024.GetAsWord: QWord;
begin
  result := BinToWord(@BinaryDecode);
end;

procedure TBinary1024.SetAsstring(AValue: String);
begin
  StrToBin(AValue, @BinaryDecode);
end;

procedure TBinary1024.SetAsWord(AValue: QWord);
begin
  WordToBin(AValue, @BinaryDecode);
end;

function TBinary1024.GetByteSetAsWord(aRangeFrom, aRangeTo: integer; aShift: integer): QWord;
var
  BinaryOut : Array[1..Size] of Boolean;
  i : integer;
begin
  FillChar(BinaryOut , sizeof(BinaryOut), #0);
  for i := aRangeFrom to aRangeTo do
  begin
     BinaryOut[i+aShift] := BinaryDecode[i];
  end;

  result := BinToWord(@BinaryOut);
end;

procedure TBinary1024.SetByteSetFromWord(aValue: Qword; aRangeFrom,
  aRangeTo: integer; aShift: integer);
var
  BinaryOut : Array[1..Size] of Boolean;
  i : integer;
begin
  FillChar(BinaryOut , sizeof(BinaryOut), #0);

  WordToBin(aValue, @BinaryOut);

  for i := aRangeFrom to aRangeTo do
  begin
     BinaryDecode[i] := BinaryOut[i+aShift];
  end;
end;


end.

