unit frmTestapp;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, BufDataset, db, memds, Forms, Controls, Graphics,
  Dialogs, StdCtrls;

type
  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    BufDSFacilities : TMemDataset;

  public
    SourcecodeHwaders : TList;
    FacilitiesL : Tlist;
    ErrorCodes : Tlist;

  end;

var
  Form1: TForm1;

implementation

uses
  ErrorCodesU, customDatatypesU, ShellApi, CSVU;

{$R *.lfm}

function SortHeaderName(Val1, Val2 : Pointer): integer;
begin
  result := PErrorSourceHeaders(Val1)^._SHC - PErrorSourceHeaders(Val2)^._SHC;
end;

function SortFacility(Val1, Val2 : Pointer): integer;
begin
  result := PFacilityList(val1)^._FC - PFacilityList(val2)^._FC;
end;

function SortError(Val1, Val2 : Pointer): integer;
begin
  result := 0;
  if assigned(val1) and assigned(val1) then
  if result = 0 then result := POutPutErrorCodes(val1)^._EC - POutPutErrorCodes(val2)^._EC;
  if result = 0 then result := POutPutErrorCodes(val1)^._FC - POutPutErrorCodes(val2)^._FC;
  if result = 0 then result := POutPutErrorCodes(val1)^._SHC - POutPutErrorCodes(val2)^._SHC;
end;

{ TForm1 }
procedure TForm1.Button1Click(Sender: TObject);
var
  i, j : integer;
  ErrorSourceHeader: PErrorSourceHeaders;
  FacilityList: PFacilityList;
  OutPutErrorCodes: POutPutErrorCodes;
  Infile : TStringList;
  ErrorCodeF : TBinary1024;
  Errordone : Boolean;
  ch : char;
  mc, md : integer;
  procedure MoveHelpfile(var seq : integer; aname : string);
  var
    k : integer;
  begin
    for k := seq to SourcecodeHwaders.Count-1 do
      if PErrorSourceHeaders(SourcecodeHwaders.Items[k])^._SN = aname then
      begin
        PErrorSourceHeaders(SourcecodeHwaders.Items[k])^._SHC:= seq;
        SourcecodeHwaders.Move(k, seq);
        inc(seq);
        break;
      end;
  end;

  function FindHF(hc : string): integer;
  var
    k : integer;
  begin
    for k := 0 to SourcecodeHwaders.Count-1 do
      if PErrorSourceHeaders(SourcecodeHwaders.Items[k])^._SN = hc then
      begin
        Result := k;
        Break;
      end;
  end;

  function RPadString(aSTR : String; len : integer): String;
  var
    l : Integer;
  begin
    l := Length(aSTR);
    result := aSTR + StringOfChar(' ', len-l);
  end;

  function lPadString(aSTR : String; len : integer): String;
  var
    l : Integer;
  begin
    l := Length(aSTR);
    result := StringOfChar(' ', len-l) + aSTR;
  end;

begin
  Errordone := False;
//  ShellExecute(0, 'OPEN' , 'Err_6.4.5.exe', '/:listTables  > listTables.xml','',0);

  Infile := TStringList.Create;
  Infile.LoadFromFile('listTables.xml');

  for i := 2 to Infile.Count-2 do
  begin
    if Pos('.h', Infile.Strings[i]) > 0 then
    begin
      new(ErrorSourceHeader);
      ErrorSourceHeader^._SHC := i;
      ErrorSourceHeader^._SN := Infile.Strings[i];
      Delete(ErrorSourceHeader^._SN , 1 , 9);
      Delete(ErrorSourceHeader^._SN , Length(ErrorSourceHeader^._SN)-2 , 3);
      ErrorSourceHeader^._SN := trim(ErrorSourceHeader^._SN);
      ErrorSourceHeader^._SHC := -1;
      SourcecodeHwaders.Add(ErrorSourceHeader);
      ErrorSourceHeader := nil;
    end;
  end;

//  DeleteFile('listTables.xml');

    i := 0;
    MoveHelpfile(i, 'winerror.h');
    MoveHelpfile(i, 'ntstatus.h');
    MoveHelpfile(i, 'winbio_err.h');
    MoveHelpfile(i, 'wincrypt.h');
    MoveHelpfile(i, 'windowsplayready.h');
    MoveHelpfile(i, 'windowssearcherrors.h');
    MoveHelpfile(i, 'winfax.h');
    MoveHelpfile(i, 'winhttp.h');
    MoveHelpfile(i, 'wininet.h');
    MoveHelpfile(i, 'winioctl.h');
    MoveHelpfile(i, 'winldap.h');
    MoveHelpfile(i, 'winsnmp.h');
    MoveHelpfile(i, 'winsock2.h');
    MoveHelpfile(i, 'winspool.h');
    MoveHelpfile(i, 'ntdddisk.h');
    MoveHelpfile(i, 'ntdsapi.h');
    MoveHelpfile(i, 'ntdsbmsg.h');
    MoveHelpfile(i, 'ntiologc.h');
    MoveHelpfile(i, 'netcfgx.h');
    MoveHelpfile(i, 'netevent.h');
    MoveHelpfile(i, 'netmon.h');
    MoveHelpfile(i, 'netsh.h');
    MoveHelpfile(i, 'activprof.h');
    MoveHelpfile(i, 'activscp.h');
    MoveHelpfile(i, 'adoint.h');
    MoveHelpfile(i, 'adserr.h');
    MoveHelpfile(i, 'asferr.h');
    MoveHelpfile(i, 'audioclient.h');
    MoveHelpfile(i, 'audioenginebaseapo.h');
    MoveHelpfile(i, 'bitsmsg.h');
    MoveHelpfile(i, 'bthdef.h');
    MoveHelpfile(i, 'bugcodes.h');
    MoveHelpfile(i, 'cderr.h');
    MoveHelpfile(i, 'cdosyserr.h');
    MoveHelpfile(i, 'cfgmgr32.h');
    MoveHelpfile(i, 'cierror.h');
    MoveHelpfile(i, 'corerror.h');
    MoveHelpfile(i, 'corsym.h');
    MoveHelpfile(i, 'ctffunc.h');
    MoveHelpfile(i, 'd3d.h');
    MoveHelpfile(i, 'd3d9.h');
    MoveHelpfile(i, 'd3d9helper.h');
    MoveHelpfile(i, 'd3dx10.h');
    MoveHelpfile(i, 'd3dx10core.h');
    MoveHelpfile(i, 'd3dx9.h');
    MoveHelpfile(i, 'd3dx9xof.h');
    MoveHelpfile(i, 'daogetrw.h');
    MoveHelpfile(i, 'dbdaoerr.h');
    MoveHelpfile(i, 'dciddi.h');
    MoveHelpfile(i, 'ddeml.h');
    MoveHelpfile(i, 'ddraw.h');
    MoveHelpfile(i, 'dhcpssdk.h');
    MoveHelpfile(i, 'difxapi.h');
    MoveHelpfile(i, 'dinput.h');
    MoveHelpfile(i, 'dinputd.h');
    MoveHelpfile(i, 'dlnaerror.h');
    MoveHelpfile(i, 'dmerror.h');
    MoveHelpfile(i, 'drt.h');
    MoveHelpfile(i, 'dsound.h');
    MoveHelpfile(i, 'dxfile.h');
    MoveHelpfile(i, 'eaphosterror.h');
    MoveHelpfile(i, 'ehstormsg.h');
    MoveHelpfile(i, 'esent.h');
    MoveHelpfile(i, 'fherrors.h');
    MoveHelpfile(i, 'filterr.h');
    MoveHelpfile(i, 'fltdefs.h');
    MoveHelpfile(i, 'hidpi.h');
    MoveHelpfile(i, 'iiscnfg.h');
    MoveHelpfile(i, 'imapi2error.h');
    MoveHelpfile(i, 'imapi2fserror.h');
    MoveHelpfile(i, 'imapierror.h');
    MoveHelpfile(i, 'ime.h');
    MoveHelpfile(i, 'intshcut.h');
    MoveHelpfile(i, 'ipexport.h');
    MoveHelpfile(i, 'iscsierr.h');
    MoveHelpfile(i, 'iscsilog.h');
    MoveHelpfile(i, 'jscript9diag.h');
    MoveHelpfile(i, 'legacyErrorCodes.h');
    MoveHelpfile(i, 'lmerr.h');
    MoveHelpfile(i, 'lmerrlog.h');
    MoveHelpfile(i, 'lmsvc.h');
    MoveHelpfile(i, 'lpmapi.h');
    MoveHelpfile(i, 'lzexpand.h');
    MoveHelpfile(i, 'mciavi.h');
    MoveHelpfile(i, 'mdmregistration.h');
    MoveHelpfile(i, 'mdmsg.h');
    MoveHelpfile(i, 'mediaerr.h');
    MoveHelpfile(i, 'mferror.h');
    MoveHelpfile(i, 'mmstream.h');
    MoveHelpfile(i, 'mobsync.h');
    MoveHelpfile(i, 'mpeg2error.h');
    MoveHelpfile(i, 'mprerror.h');
    MoveHelpfile(i, 'mq.h');
    MoveHelpfile(i, 'mqoai.h');
    MoveHelpfile(i, 'msctf.h');
    MoveHelpfile(i, 'msdrmerror.h');
    MoveHelpfile(i, 'msime.h');
    MoveHelpfile(i, 'msiquery.h');
    MoveHelpfile(i, 'msopc.h');
    MoveHelpfile(i, 'mswmdm.h');
    MoveHelpfile(i, 'msxml2.h');
    MoveHelpfile(i, 'nb30.h');
    MoveHelpfile(i, 'ndattrib.h');
    MoveHelpfile(i, 'nserror.h');
    MoveHelpfile(i, 'odbcinst.h');
    MoveHelpfile(i, 'oledlg.h');
    MoveHelpfile(i, 'p2p.h');
    MoveHelpfile(i, 'patchapi.h');
    MoveHelpfile(i, 'patchwiz.h');
    MoveHelpfile(i, 'pbdaerrors.h');
    MoveHelpfile(i, 'pdhmsg.h');
    MoveHelpfile(i, 'photoacquire.h');
    MoveHelpfile(i, 'portabledevice.h');
    MoveHelpfile(i, 'qossp.h');
    MoveHelpfile(i, 'raserror.h');
    MoveHelpfile(i, 'rdcentraldb.h');
    MoveHelpfile(i, 'reconcil.h');
    MoveHelpfile(i, 'routprot.h');
    MoveHelpfile(i, 'rtcerr.h');
    MoveHelpfile(i, 'sberrors.h');
    MoveHelpfile(i, 'scesvc.h');
    MoveHelpfile(i, 'schannel.h');
    MoveHelpfile(i, 'setupapi.h');
    MoveHelpfile(i, 'shellapi.h');
    MoveHelpfile(i, 'sherrors.h');
    MoveHelpfile(i, 'shimgdata.h');
    MoveHelpfile(i, 'shobjidl_core.h');
    MoveHelpfile(i, 'slerror.h');
    MoveHelpfile(i, 'snmp.h');
    MoveHelpfile(i, 'spatialaudioclient.h');
    MoveHelpfile(i, 'spatialaudiometadata.h');
    MoveHelpfile(i, 'sperror.h');
    MoveHelpfile(i, 'stierr.h');
    MoveHelpfile(i, 'synchronizationerrors.h');
    MoveHelpfile(i, 'tapi.h');
    MoveHelpfile(i, 'tapi3err.h');
    MoveHelpfile(i, 'tcerror.h');
    MoveHelpfile(i, 'textserv.h');
    MoveHelpfile(i, 'textstor.h');
    MoveHelpfile(i, 'thumbcache.h');
    MoveHelpfile(i, 'tpcerror.h');
    MoveHelpfile(i, 'txdtc.h');
    MoveHelpfile(i, 'upnp.h');
    MoveHelpfile(i, 'upnphost.h');
    MoveHelpfile(i, 'urlmon.h');
    MoveHelpfile(i, 'usb.h');
    MoveHelpfile(i, 'usp10.h');
    MoveHelpfile(i, 'vdserr.h');
    MoveHelpfile(i, 'vfw.h');
    MoveHelpfile(i, 'vfwmsgs.h');
    MoveHelpfile(i, 'vsserror.h');
    MoveHelpfile(i, 'wbemcli.h');
    MoveHelpfile(i, 'wcmerrors.h');
    MoveHelpfile(i, 'wcntypes.h');
    MoveHelpfile(i, 'wdfstatus.h');
    MoveHelpfile(i, 'wdscpmsg.h');
    MoveHelpfile(i, 'wdsmcerr.h');
    MoveHelpfile(i, 'wdstptmgmtmsg.h');
    MoveHelpfile(i, 'werapi.h');
    MoveHelpfile(i, 'wiadef.h');
    MoveHelpfile(i, 'wpc.h');
    MoveHelpfile(i, 'wsbapperror.h');
    MoveHelpfile(i, 'wsmerror.h');
    MoveHelpfile(i, 'wuerror.h');
    MoveHelpfile(i, 'xapo.h');
    MoveHelpfile(i, 'xaudio2.h');
    MoveHelpfile(i, 'xmllite.h');
    MoveHelpfile(i, 'xpsdigitalsignature.h');
    MoveHelpfile(i, 'xpsobjectmodel.h');
    MoveHelpfile(i, 'xpsobjectmodel_1.h');

     mc := 0;
     md := 0;
    //  ShellExecute(0, 'OPEN' , 'Err_6.4.5.exe', '/:outputtoJS  > outputtoJS.js','',0);
      Infile.LoadFromFile('outputtoJS.js');
      for i := 2 to Infile.Count-2 do
      begin
        if pos('"', infile.Strings[i]) = 0 then
        Errordone := true
        else if trim(infile.Strings[i]) <> '' then
        if Errordone then
        begin
          new(FacilityList);
          SetCSVString(infile.Strings[i]);

          FacilityList^._FC := GetCSVWord(0);
          FacilityList^._FN := GetCSVStr(1);
          FacilitiesL.add(FacilityList);
          FacilityList := nil
        end
        else
        begin
          new(OutPutErrorCodes);
          SetCSVString(infile.Strings[i]);
          ErrorCodeF.AsWord := GetCSVWord(0);
          OutPutErrorCodes^._CC := GetCSVStr(0);;
          OutPutErrorCodes^._CB := ErrorCodeF.AsString;
          OutPutErrorCodes^._CN := GetCSVStr(2);
          OutPutErrorCodes^._TD := GetCSVStr(3);
          OutPutErrorCodes^._SH := GetCSVStr(4);

          OutPutErrorCodes^._SHC := FindHF(OutPutErrorCodes^._SH);
          OutPutErrorCodes^._EC:=  ErrorCodeF.GetByteSetAsWord(1,16);
          OutPutErrorCodes^._FC:=  ErrorCodeF.GetByteSetAsWord(17,27,-16);
          OutPutErrorCodes^._Sev:=  ErrorCodeF.GetByteSetAsWord(32,32,-31);
          OutPutErrorCodes^._Cus:=  ErrorCodeF.GetByteSetAsWord(31,31,-30);
          OutPutErrorCodes^._Res:=  ErrorCodeF.GetByteSetAsWord(30,30,-29);
          OutPutErrorCodes^._NSt:=  ErrorCodeF.GetByteSetAsWord(29,29,-28);

          if mc < Length(OutPutErrorCodes^._CN) then mc := Length(OutPutErrorCodes^._CN);
          if md < Length(OutPutErrorCodes^._TD) then md := Length(OutPutErrorCodes^._TD);
          ErrorCodes.add(OutPutErrorCodes);
          OutPutErrorCodes := nil;
        end;

      //ShellExecute(0, 'CMD' , 'Err_6.4.5.exe', '','',0);
      //ShellExecute(0, 'CMD' , 'Err_6.4.5.exe', '','',0);
      //ShellExecute(0, 'CMD' , 'Err_6.4.5.exe', '','',0);
      end;

    //  SourcecodeHwaders.Sort(@SortHeaderName);

  FacilitiesL.Sort(@SortFacility);
  ErrorCodes.Sort(@SortError);

  Infile.clear;
  Infile.Add('unit WindowsErrorCodesToPas;');
  Infile.Add('');
  Infile.Add('{$IFDEF FPC}');
  Infile.Add('  {$mode objfpc}{$H+}');
  Infile.Add('{$ENDIF}');
  Infile.Add('  interface');
  Infile.Add('');
  Infile.Add('uses');
  Infile.Add('  Classes, SysUtils;');
  Infile.Add('');
  Infile.Add('Type');
  Infile.Add('  TWinErrSourceCodeHeader = (');
  for i := 0 to SourcecodeHwaders.Count-1 do
  begin
    if i = SourcecodeHwaders.Count-1 then
      ch := ' '
    else ch := ',';

    Infile.Add('    ' + StringReplace(PErrorSourceHeaders(SourcecodeHwaders.items[i])^._SN ,'.', '_', [rfReplaceAll, rfIgnoreCase]) + ch);
  end;
  Infile.Add(');');

  Infile.Add('');
  Infile.Add('Type');
  Infile.Add('  TWondowsErrorFacility = packed record');
  Infile.Add('    FC : word;');
  Infile.Add('    FD : String;');
  Infile.Add('  end;');
  Infile.Add('');
  Infile.Add('const');
  Infile.Add('  WondowsErrorFacilityList : array[0..' + IntToStr(FacilitiesL.Count-1) + '] of TWondowsErrorFacility = (');
  for i := 0 to FacilitiesL.Count-1 do
  with PFacilityList(FacilitiesL.Items[i])^ do
  begin
    if i = FacilitiesL.Count-1 then
      ch := ' '
    else ch := ',';
    Infile.Add('    (FC:' + RPadString(IntToStr(_FC) + ';' , 5) +
                   ' FN:' + RPadString(QuotedStr(_FN) + ';',53) + ')' + ch);
  end;
  Infile.Add('  );');
  Infile.Add('');
  Infile.Add('Type');
  Infile.Add('  TWondowsErrorCode = packed record');
  Infile.Add('    FC : word; // Facility Code');
  Infile.Add('    EC : word; // Error Code');
  Infile.Add('    Severity : String; // Facility Code');
  Infile.Add('    Customer : String; // Facility Code');
  Infile.Add('    Reserved : String; // Facility Code');
  Infile.Add('    NStatus : String; // Facility Code');
  Infile.Add('    CODE : String; // Facility Code');
  Infile.Add('    BinVal : String; // Facility Code');
  Infile.Add('    HC : TWinErrSourceCodeHeader;');
  Infile.Add('    CC : String; // Error code class');
  Infile.Add('    CD : String; // Error code description');
  Infile.Add('  end;');
  Infile.Add('');
  Infile.Add('const');
  Infile.Add('  WondowsErrorCodeList : array[0..' + IntToStr(ErrorCodes.Count-1) + '] of TWondowsErrorCode = (');
  for i := 0 to ErrorCodes.Count-1 do
  with POutPutErrorCodes(ErrorCodes.Items[i])^ do
  begin
    if i = ErrorCodes.Count-1 then
      ch := ' '
    else ch := ',';
    Infile.Add('  ' +
                  ' EC:' + IntToStr(_EC) + ';'+
                  ' FC:' + RPadString(IntToStr(_FC) + ';' , 5) +
                  ' Severity:' + IntToStr(_Sev) + ';'+
                  ' Customer:' + IntToStr(_Cus) + ';'+
                  ' Reserved:' + IntToStr(_Res) + ';'+
                  ' NStatus:' + IntToStr(_NSt) + ';'+
                  ' CODE:' + RPadString(QuotedStr(_CC) + ';' , 20) +
                  ' BinVal: ' + LPadString(QuotedStr(_CB) + ';' , 43) +
                  ' HC:' + RPadString(StringReplace(_SH, '.' , '_', [rfReplaceAll, rfIgnoreCase])  + ';' , 26)+
                  ' CC:' + RPadString(QuotedStr(_CN) + ';',mc+2) +
                  ' CD:' + RPadString(QuotedStr(_TD) + ';',md+2) +')' + ch);
  end;
  Infile.Add('  );');
  Infile.SaveToFile('WindowsErrorCodesToPas.inc');
  Infile.Clear;

  Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SourcecodeHwaders := TList.Create;
  FacilitiesL:= Tlist.Create;
  ErrorCodes := Tlist.Create;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Button1Click(Button1);
end;

end.

