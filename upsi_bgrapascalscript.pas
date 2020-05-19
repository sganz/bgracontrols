unit uPSI_BGRAPascalScript;
{
This file has been generated by UnitParser v0.7, written by M. Knight
and updated by NP. v/d Spek and George Birbilis. 
Source Code from Carlo Kok has been used to implement various sections of
UnitParser. Components of ROPS are used in the construction of UnitParser,
code implementing the class wrapper is taken from Carlo Kok's conv utility

}
interface
 
uses
   SysUtils
  ,Classes
  ,uPSComponent
  ,uPSRuntime
  ,uPSCompiler
  ;
 
type 
(*----------------------------------------------------------------------------*)
  TPSImport_BGRAPascalScript = class(TPSPlugin)
  public
    procedure CompileImport1(CompExec: TPSScript); override;
    procedure ExecImport1(CompExec: TPSScript; const {%H-}ri: TPSRuntimeClassImporter); override;
  end;
 
 
{ compile-time registration functions }
procedure SIRegister_bgrapascalscript(CL: TPSPascalCompiler);

{ run-time registration functions }
procedure RIRegister_bgrapascalscript_Routines(S: TPSExec);

{$IFDEF FPC}procedure Register;{$ENDIF}

implementation


uses
   BGRABitmap
  ,BGRABitmapTypes
  ,BGRAPascalScript
  ,Dialogs;
 
 
{$IFDEF FPC}
procedure Register;
begin
  RegisterComponents('BGRA Controls', [TPSImport_bgrapascalscript]);
end;
{$ENDIF}
(* === compile-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure SIRegister_BGRAPascalScript(CL: TPSPascalCompiler);
begin
  {Types}
  CL.AddTypeS('TRect','record Left, Top, Right, Bottom: Integer; end;');
  CL.AddTypeS('TPoint','record x, y: LongInt; end;');
  {Types}
  CL.AddTypeS('TPointF','record x, y: single; end;');
  CL.AddTypeS('TBGRAColor','LongWord');
  CL.AddTypeS('TMedianOption','( moNone, moLowSmooth, moMediumSmooth, moHighSmooth )');
  CL.AddTypeS('TResampleFilter','( rfBox, rfLinear, rfHalfCosine, rfCosine, rfBicubic, rfMitchell, rfSpline, rfLanczos2, rfLanczos3, rfLanczos4, rfBestQuality )');
  CL.AddTypeS('TRadialBlurType','( rbNormal, rbDisk, rbCorona, rbPrecise, rbFast )');
  {Utils}
  CL.AddDelphiFunction('function bgra_GetHighestID: Integer;');
  {Color}
  CL.AddDelphiFunction('function rgb(red,green,blue: byte): TBGRAColor;');
  CL.AddDelphiFunction('function rgba(red,green,blue,alpha: byte): TBGRAColor;');
  CL.AddDelphiFunction('function getBlue(AColor: TBGRAColor): byte;');
  CL.AddDelphiFunction('function getGreen(AColor: TBGRAColor): byte;');
  CL.AddDelphiFunction('function getRed(AColor: TBGRAColor): byte;');
  CL.AddDelphiFunction('function getAlpha(AColor: TBGRAColor): byte;');
  CL.AddDelphiFunction('function setBlue(AColor: TBGRAColor; AValue: byte): TBGRAColor;');
  CL.AddDelphiFunction('function setGreen(AColor: TBGRAColor; AValue: byte): TBGRAColor;');
  CL.AddDelphiFunction('function setRed(AColor: TBGRAColor; AValue: byte): TBGRAColor;');
  CL.AddDelphiFunction('function setAlpha(AColor: TBGRAColor; AValue: byte): TBGRAColor;');
  {Constructors}
  CL.AddDelphiFunction('Procedure bgra_Create( id : Integer)');
  CL.AddDelphiFunction('Procedure bgra_CreateWithSize( id : Integer; AWidth, AHeight: integer)');
  CL.AddDelphiFunction('Procedure bgra_CreateFromFile( id : Integer; AFilename : string)');
  CL.AddDelphiFunction('Procedure bgra_Destroy( id : Integer)');
  CL.AddDelphiFunction('Procedure bgra_DestroyAll');
  {}
  CL.AddDelphiFunction('Procedure bgra_Fill( id : Integer; AColor: TBGRAColor)');
  CL.AddDelphiFunction('procedure bgra_SetPixel(id: Integer; x,y: integer; AColor: TBGRAColor);');
  CL.AddDelphiFunction('function bgra_GetPixel(id: Integer; x,y: integer): TBGRAColor;');
  {Loading functions}
  CL.AddDelphiFunction('procedure bgra_SaveToFile(id: integer; const filename: string);');
  {Filters}
  CL.AddDelphiFunction('procedure bgra_FilterSmartZoom3( id: integer; Option: TMedianOption )');
  CL.AddDelphiFunction('procedure bgra_FilterMedian( id: integer; Option: TMedianOption )');
  CL.AddDelphiFunction('procedure bgra_FilterSmooth( id: integer )');
  CL.AddDelphiFunction('procedure bgra_FilterSharpen( id: integer; Amount: single )');
  CL.AddDelphiFunction('procedure bgra_FilterSharpenRect( id: integer; ABounds: TRect; Amount: single )');
  CL.AddDelphiFunction('procedure bgra_FilterContour( id: integer )');
  CL.AddDelphiFunction('procedure bgra_FilterPixelate( id: integer; pixelSize: integer; useResample: boolean; filter: TResampleFilter )');
  CL.AddDelphiFunction('procedure bgra_FilterBlurRadial( id: integer; radius: integer; blurType: TRadialBlurType )');
  CL.AddDelphiFunction('procedure bgra_FilterBlurRadialRect( id: integer; ABounds: TRect; radius: integer; blurType: TRadialBlurType )');
  CL.AddDelphiFunction('procedure bgra_FilterBlurMotion(id: integer; distance: integer; angle: single; oriented: boolean);');
  CL.AddDelphiFunction('procedure bgra_FilterBlurMotionRect(id: integer; ABounds: TRect; distance: integer; angle: single; oriented: boolean);');
  CL.AddDelphiFunction('procedure bgra_FilterCustomBlur(id: integer; mask: integer);');
  CL.AddDelphiFunction('procedure bgra_FilterCustomBlurRect(id: integer; ABounds: TRect; mask: integer);');
  CL.AddDelphiFunction('procedure bgra_FilterEmboss(id: integer; angle: single);');
  CL.AddDelphiFunction('procedure bgra_FilterEmbossRect(id: integer; angle: single; ABounds: TRect);');
  CL.AddDelphiFunction('procedure bgra_FilterEmbossHighlight(id: integer; FillSelection: boolean);');
  CL.AddDelphiFunction('procedure bgra_FilterEmbossHighlightBorder(id: integer; FillSelection: boolean; BorderColor: TBGRAColor); ');
  CL.AddDelphiFunction('procedure bgra_FilterEmbossHighlightBorderAndOffset(id: integer; FillSelection: boolean; BorderColor: TBGRAColor; Offset: TPoint);');
  CL.AddDelphiFunction('procedure bgra_FilterGrayscale(id: integer);   ');
  CL.AddDelphiFunction('procedure bgra_FilterGrayscaleRect(id: integer; ABounds: TRect);  ');
  CL.AddDelphiFunction('procedure bgra_FilterNormalize(id: integer; eachChannel: boolean);   ');
  CL.AddDelphiFunction('procedure bgra_FilterNormalizeRect(id: integer; ABounds: TRect; eachChannel: boolean); ');
  CL.AddDelphiFunction('procedure bgra_FilterRotate(id: integer; origin: TPointF; angle: single; correctBlur: boolean);  ');
  CL.AddDelphiFunction('procedure bgra_FilterSphere(id: integer);   ');
  CL.AddDelphiFunction('procedure bgra_FilterTwirl(id: integer; ACenter: TPoint; ARadius: single; ATurn: single; AExponent: single);');
  CL.AddDelphiFunction('procedure bgra_FilterTwirlRect(id: integer; ABounds: TRect; ACenter: TPoint; ARadius: single; ATurn: single; AExponent: single);');
  CL.AddDelphiFunction('procedure bgra_FilterCylinder(id: integer);');
  CL.AddDelphiFunction('procedure bgra_FilterPlane(id: integer);');
  {Others}
  CL.AddDelphiFunction('Procedure ShowMessage( const AMessage: string)');
end;

(* === run-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure RIRegister_BGRAPascalScript_Routines(S: TPSExec);
begin
  {Utils}
  S.RegisterDelphiFunction(@bgra_GetHighestID, 'bgra_GetHighestID', cdRegister);
  {Constructors}
  S.RegisterDelphiFunction(@bgra_Create, 'bgra_Create', cdRegister);
  S.RegisterDelphiFunction(@bgra_CreateWithSize, 'bgra_CreateWithSize', cdRegister);
  S.RegisterDelphiFunction(@bgra_CreateFromFile, 'bgra_CreateFromFile', cdRegister);
  S.RegisterDelphiFunction(@bgra_Destroy, 'bgra_Destroy', cdRegister);
  S.RegisterDelphiFunction(@bgra_DestroyAll, 'bgra_DestroyAll', cdRegister);
  {}
  S.RegisterDelphiFunction(@bgra_Fill, 'bgra_Fill', cdRegister);
  {Loading functions}
  S.RegisterDelphiFunction(@bgra_SaveToFile, 'bgra_SaveToFile', cdRegister);
  {Color}
  S.RegisterDelphiFunction(@rgb, 'rgb', cdRegister);
  S.RegisterDelphiFunction(@rgba, 'rgba', cdRegister);
  S.RegisterDelphiFunction(@getRed, 'getRed', cdRegister);
  S.RegisterDelphiFunction(@getGreen, 'getGreen', cdRegister);
  S.RegisterDelphiFunction(@getBlue, 'getBlue', cdRegister);
  S.RegisterDelphiFunction(@getAlpha, 'getAlpha', cdRegister);
  S.RegisterDelphiFunction(@setRed, 'setRed', cdRegister);
  S.RegisterDelphiFunction(@setGreen, 'setGreen', cdRegister);
  S.RegisterDelphiFunction(@setBlue, 'setBlue', cdRegister);
  S.RegisterDelphiFunction(@setAlpha, 'setAlpha', cdRegister);
  S.RegisterDelphiFunction(@bgra_SetPixel, 'bgra_SetPixel', cdRegister);
  S.RegisterDelphiFunction(@bgra_GetPixel, 'bgra_GetPixel', cdRegister);
  {Filters}
  S.RegisterDelphiFunction(@bgra_FilterSmartZoom3,'bgra_FilterSmartZoom3', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterMedian,'bgra_FilterMedian', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterSmooth,'bgra_FilterSmooth', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterSharpen,'bgra_FilterSharpen', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterSharpenRect,'bgra_FilterSharpenRect', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterContour,'bgra_FilterContour', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterPixelate,'bgra_FilterPixelate', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterBlurRadial,'bgra_FilterBlurRadial', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterBlurRadialRect,'bgra_FilterBlurRadialRect', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterBlurMotion,'bgra_FilterBlurMotion', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterBlurMotionRect,'bgra_FilterBlurMotionRect', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterCustomBlur,'bgra_FilterCustomBlur', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterCustomBlurRect,'bgra_FilterCustomBlurRect', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterEmboss,'bgra_FilterEmboss', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterEmbossRect,'bgra_FilterEmbossRect', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterEmbossHighlight,'bgra_FilterEmbossHighlight', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterEmbossHighlightBorder,'bgra_FilterEmbossHighlightBorder', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterEmbossHighlightBorderAndOffset,'bgra_FilterEmbossHighlightBorderAndOffset', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterGrayscale,'bgra_FilterGrayscale', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterGrayscaleRect,'bgra_FilterGrayscaleRect', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterNormalize,'bgra_FilterNormalize', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterNormalizeRect,'bgra_FilterNormalizeRect', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterRotate,'bgra_FilterRotate', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterSphere,'bgra_FilterSphere', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterTwirl,'bgra_FilterTwirl', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterTwirlRect,'bgra_FilterTwirlRect', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterCylinder,'bgra_FilterCylinder', cdRegister);
  S.RegisterDelphiFunction(@bgra_FilterPlane,'bgra_FilterPlane', cdRegister);
  {Others}
  S.RegisterDelphiFunction(@ShowMessage, 'ShowMessage', cdRegister);
end;

 
 
{ TPSImport_BGRAPascalScript }
(*----------------------------------------------------------------------------*)
procedure TPSImport_BGRAPascalScript.CompileImport1(CompExec: TPSScript);
begin
  SIRegister_BGRAPascalScript(CompExec.Comp);
end;
(*----------------------------------------------------------------------------*)
procedure TPSImport_BGRAPascalScript.ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter);
begin
  //RIRegister_BGRAPascalScript(ri);
  RIRegister_BGRAPascalScript_Routines(CompExec.Exec); // comment it if no routines
end;
(*----------------------------------------------------------------------------*)
 
 
end.
