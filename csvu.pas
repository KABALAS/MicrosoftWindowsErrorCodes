unit CSVU;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

  function SetCSVString(aString : String): integer;
  function GetCSVStr(apos : integer):String;
  function GetCSVInt(apos : integer):Integer;
  function GetCSVWord(apos : integer):QWord;

implementation

var
  FCSV : array of string;

function SetCSVString(aString: String): integer;
var
  lTTTSSS, TTTSSS : string;
  lOpenArray, lOpenq : Boolean;
  csvc : integer;
begin
  try
    TTTSSS := trim(aString);
    if pos('[', TTTSSS) = 1 then
    begin
      if TTTSSS[length(TTTSSS)] = ']' then
      TTTSSS := copy(TTTSSS,2 , length(TTTSSS)-2)
      else
      TTTSSS := copy(TTTSSS,2 , length(TTTSSS)-3)
    end;

    SetLength(FCSV , 100);
    csvc := 0;
    while TTTSSS <> '' do
    begin
      if Pos('"', TTTSSS) = 1 then
      begin
        delete(TTTSSS,1,1);
        lTTTSSS := copy(TTTSSS , 1, pos('"' , TTTSSS)-1);
        delete(TTTSSS,1,length(lTTTSSS)+1);
      end
      else
      begin
        lTTTSSS:=  copy(TTTSSS , 1, pos(',' , TTTSSS));
        delete(TTTSSS,1,length(lTTTSSS));
      end;

      delete(TTTSSS,1, pos(',', TTTSSS));
      TTTSSS := trim(TTTSSS);
      FCSV[csvc] := lTTTSSS;
      inc(csvc);
    end;

    SetLength(FCSV, csvc);
    result := csvc;
  except on e:exception do
    csvc := 0;
  end;
end;

function GetCSVStr(apos: integer): String;
begin
  if apos > high(FCSV) then
  result := ''
  else
    result := FCSV[apos];
end;

function GetCSVInt(apos : integer):Integer;
var
  lts : String;
begin
  lts := trim(GetCSVStr(apos));
  if lts = '' then
     result := 0
  else
     result := StrToInt(lts);
end;

function GetCSVWord(apos : integer):QWord;
var
  lts : String;
begin
  lts := trim(GetCSVStr(apos));
  if lts = '' then
     result := 0
  else
     result := StrToDWord(lts);
end;


end.

