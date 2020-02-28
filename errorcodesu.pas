unit ErrorCodesU;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, customDatatypesU;

Type
  PErrorSourceHeaders = ^TErrorSourceHeaders;
  TErrorSourceHeaders = packed record
    _SHC : Word; // Source Header Code;
    _SN : ShortString; // pcszSymbolicName
  end;

  PFacilityList = ^TFacilityList;
  TFacilityList = packed record
    _FC : Word; // FacilityCode;
    _FN : ShortString; // pcszSymbolicName
  end;

  POutPutErrorCodes = ^TOutPutErrorCodes;
  TOutPutErrorCodes = packed record
    _CC : String;
    _CB : String;
    _SHC : QWord; // Source Header Code; // test1
    _Sev : Byte; // Severity;
    _Res : Byte; // Reserved;
    _Cus : Byte; // Customer;
    _NSt : Byte; // Nstatus;
    _FC : QWord; // FacilityCode; // test2
    _EC : QWord; // Short wrror code
    _CN : ShortString; // pcszSourceHeader
    _SH : ShortString; // pcszSourceHeader
    _TD : ShortString; // pcszTextDescription
 end;

  //TRecdata = (rdHeaderFileInfo, rdFacilityInfo, rdErrorInfo);
  //TWindowsErrorCodes = packed Record
  //  Recdata : TRecdata;
  //  case TRecdata of
  //    rdHeaderFileInfo : (SH : TErrorSourceHeaders);
  //    rdFacilityInfo   : (FC : Word);
  //    rdErrorInfo      : (ER : TOutPutErrorCodes);
  //end;


//  'ole.h',                   'olectl.h',                'oledberr.h',
//const
  //MAX_ERRORS  = 25259;
  //Headerfl : array[0..172] of shortstring = (
  //'winerror.h',
  //'winbio_err.h',            'wincrypt.h',              'windowsplayready.h',      'windowssearcherrors.h',
  //'winfax.h',                'winhttp.h',               'wininet.h',               'winioctl.h',              'winldap.h',
  //'winsnmp.h',               'winsock2.h',              'winspool.h',
  //'ntstatus.h',              'ntdddisk.h',              'ntdsapi.h',               'ntdsbmsg.h',              'ntiologc.h',
  //'netcfgx.h',               'netevent.h',              'netmon.h',                'netsh.h',
  //
  //  'activprof.h',             'activscp.h',              'adoint.h',                'adserr.h',                'asferr.h',
  //  'audioclient.h',           'audioenginebaseapo.h',    'bitsmsg.h',               'bthdef.h',                'bugcodes.h',
  //  'cderr.h',                 'cdosyserr.h',             'cfgmgr32.h',              'cierror.h',               'corerror.h',
  //  'corsym.h',                'ctffunc.h',               'd3d.h',                   'd3d9.h',                  'd3d9helper.h',
  //  'd3dx10.h',                'd3dx10core.h',            'd3dx9.h',                 'd3dx9xof.h',              'daogetrw.h',
  //  'dbdaoerr.h',              'dciddi.h',                'ddeml.h',                 'ddraw.h',                 'dhcpssdk.h',
  //  'difxapi.h',               'dinput.h',                'dinputd.h',               'dlnaerror.h',             'dmerror.h',
  //  'drt.h',                   'dsound.h',                'dxfile.h',                'eaphosterror.h',          'ehstormsg.h',
  //  'esent.h',                 'fherrors.h',              'filterr.h',               'fltdefs.h',               'hidpi.h',
  //  'iiscnfg.h',               'imapi2error.h',           'imapi2fserror.h',         'imapierror.h',            'ime.h',
  //  'intshcut.h',              'ipexport.h',              'iscsierr.h',              'iscsilog.h',              'jscript9diag.h',
  //  'legacyErrorCodes.h',      'lmerr.h',                 'lmerrlog.h',              'lmsvc.h',                 'lpmapi.h',
  //  'lzexpand.h',              'mciavi.h',                'mdmregistration.h',       'mdmsg.h',                 'mediaerr.h',
  //  'mferror.h',               'mmstream.h',              'mobsync.h',               'mpeg2error.h',            'mprerror.h',
  //  'mq.h',                    'mqoai.h',                 'msctf.h',                 'msdrmerror.h',            'msime.h',
  //  'msiquery.h',              'msopc.h',                 'mswmdm.h',                'msxml2.h',                'nb30.h',
  //  'ndattrib.h',
  //  'nserror.h',
  //  'odbcinst.h',
  //  'oledlg.h',                'p2p.h',                   'patchapi.h',              'patchwiz.h',              'pbdaerrors.h',
  //  'pdhmsg.h',                'photoacquire.h',          'portabledevice.h',        'qossp.h',                 'raserror.h',
  //  'rdcentraldb.h',           'reconcil.h',              'routprot.h',              'rtcerr.h',                'sberrors.h',
  //  'scesvc.h',                'schannel.h',              'setupapi.h',              'shellapi.h',              'sherrors.h',
  //  'shimgdata.h',             'shobjidl_core.h',         'slerror.h',               'snmp.h',                  'spatialaudioclient.h',
  //  'spatialaudiometadata.h',  'sperror.h',               'stierr.h',                'synchronizationerrors.h', 'tapi.h',
  //  'tapi3err.h',              'tcerror.h',               'textserv.h',              'textstor.h',              'thumbcache.h',
  //  'tpcerror.h',              'txdtc.h',                 'upnp.h',                  'upnphost.h',              'urlmon.h',
  //  'usb.h',                   'usp10.h',                 'vdserr.h',                'vfw.h',                   'vfwmsgs.h',
  //  'vsserror.h',              'wbemcli.h',               'wcmerrors.h',             'wcntypes.h',              'wdfstatus.h',
  //  'wdscpmsg.h',              'wdsmcerr.h',              'wdstptmgmtmsg.h',         'werapi.h',                'wiadef.h',
  //  'wpc.h',                   'wsbapperror.h',
  //  'wsmerror.h',              'wuerror.h',               'xapo.h',                  'xaudio2.h',               'xmllite.h',
  //  'xpsdigitalsignature.h',   'xpsobjectmodel.h',        'xpsobjectmodel_1.h');


implementation


end.

