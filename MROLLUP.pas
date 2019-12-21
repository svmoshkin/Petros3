unit MRollUp;

interface

uses
  Windows, Buttons, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;


type

  TRolState = (rsUp, rsDown);

  TRollsUp = class(TForm)
  private
    { Private declarations }
    CaptionBtn: TRect;
    CloseBtn: TRect;
    FState: TRolState;

    procedure DrawCaptButton;
    procedure WMNCPaint(var Msg: TWMNCPaint); message WM_NCPaint;
    procedure WMNCActivate(var Msg: TWMNCActivate); message WM_NCACTIVATE;
    procedure WMSetText(var Msg: TWMSetText); message WM_SETTEXT;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCLButtonDown(var Msg: TWMNCLButtonDown); message WM_NCLBUTTONDOWN;
    procedure SetState(const Value: TRolState);
  public
    { Public declarations }

    MaxW: integer;
    MaxH: Integer;
    RollAmount: integer;
    Rolling: Boolean;
    property State: TRolState read FState write SetState;
    constructor Create(AOwner: TComponent); override;
  published

  end;

var
  RollsUp: TRollsUp;
  BRCl, BRUp, BRDo: TBitmap;

implementation
const
  htCaptionBtn = htSizeLast + 10;
  htCloseBtn = htSizeLast + 11;
{$R *.DFM}
{$R MRollUp.Res}

procedure TRollsUp.DrawCaptButton;
var
  xFrame, yFrame, xSize, ySize: Integer;
  {R: TRect;}
begin
  if not Rolling then begin
  //Dimensions of Sizeable Frame
    xFrame := GetSystemMetrics(SM_CXFIXEDFRAME);
    yFrame := GetSystemMetrics(SM_CYFIXEDFRAME);
  //Dimensions of Caption Buttons
    xSize := GetSystemMetrics(SM_CXSIZE);
    ySize := GetSystemMetrics(SM_CYSIZE);
  //Define the placement of the new caption button
    CaptionBtn := Bounds(Width - xFrame - 2 * xSize,
      yFrame + 2, xSize - 2, ySize - 3);
    CloseBtn := Bounds(Width - xFrame - xSize,
      yFrame + 2, xSize - 2, ySize - 3);
  //Get the handle to canvas using Form's device context
    Canvas.Handle := GetWindowDC(Self.Handle);
  {Canvas.Font.Name := 'Symbol';
  Canvas.Font.Color := clBlack;
  Canvas.Font.Style := [fsBold];}
    Canvas.Pen.Color := clYellow;
    Canvas.Brush.Color := clBtnFace;
    try
      DrawButtonFace(Canvas, CaptionBtn, 1, bsAutoDetect, False, False, False);
      DrawButtonFace(Canvas, CloseBtn, 1, bsAutoDetect, False, False, False);
      Canvas.Pen.Width := 2;
      Canvas.Pen.Color := clBlack;
    {R := Bounds(Width - xFrame - 2 * xSize + 1,
      yFrame + 5, xSize - 6, ySize - 10);}
      if State = rsUp then
      {Canvas.TextRect(R, R.Left + 2, R.Top + 1, '­')}
        Canvas.Draw(Width - xFrame - 2 * xSize + 2, yFrame + 4, BrUp)

      else {Canvas.TextRect(R, R.Left + 2, R.Top - 4, '¯');}
        Canvas.Draw(Width - xFrame - 2 * xSize + 2, yFrame + 4, BrDo);


    {R := Bounds(Width - xFrame - xSize + 1,
      yFrame + 4, xSize - 6, ySize - 9);}
      Canvas.Draw(Width - xFrame - xSize + 3, yFrame + 5, BrCl);
    {Canvas.TextRect(R, R.Left + 2, R.Top - 1, '´');}
    finally
      ReleaseDC(Self.Handle, Canvas.Handle);
      Canvas.Handle := 0;
    end;
  end;
end;

procedure TRollsUp.WMNCPaint(var Msg: TWMNCPaint);
begin
  inherited;
  DrawCaptButton;
end;

procedure TRollsUp.WMNCActivate(var Msg: TWMNCActivate);
begin
  inherited;
  DrawCaptButton;
end;

procedure TRollsUp.WMSetText(var Msg: TWMSetText);
begin
  inherited;
  DrawCaptButton;
end;

procedure TRollsUp.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;
  with Msg do
    if PtInRect(CaptionBtn, Point(XPos - Left, YPos - Top)) then
      Result := htCaptionBtn
    else if PtInRect(CloseBtn, Point(XPos - Left, YPos - Top)) then
      Result := htCloseBtn;
end;

procedure TRollsUp.WMNCLButtonDown(var Msg: TWMNCLButtonDown);
begin
  inherited;
  case Msg.HitTest of
    htCaptionBtn: if State = rsUp then State := rsDown else State := rsUp;
    htCloseBtn: Close;
    HTCAPTION	: if State = rsUp then State := rsDown else State := rsUp;
  end;
end;


procedure TRollsUp.SetState(const Value: TRolState);
var
  H, W, R: integer;
begin
  FState := Value;
  Rolling := True;
  if Value = rsUp then begin
    if (RollAmount <> 0) and (Height <> MaxH) then begin
      R := Round((MaxW - Width) / (MaxH - Height) * RollAmount);
      while Height < MaxH - RollAmount do begin
        Height := Height + RollAmount;
        if Width < MaxW - R then
          Width := Width + R;
      end;
    end;
    Width := MaxW;
    Height := MaxH;
  end else begin
    W := GetSystemMetrics(SM_CXMINIMIZED);
    H := GetSystemMetrics(SM_CYMINIMIZED);
    if RollAmount <> 0 then begin
      R := Round((Width - W) / (Height - H) * RollAmount);
      while Height > H + RollAmount do begin
        Height := Height - RollAmount;
        if Width > W + R then
          Width := Width - R;
      end;
    end;
    Width := W;
    Height := H;
  end;
  Rolling := False;
  DrawCaptButton;
end;

constructor TRollsUp.Create(AOwner: TComponent);
begin
  inherited;
  MaxW := Width;
  MaxH := Height;
  RollAmount := 20;
  Rolling := False;
end;

initialization
  begin
    BRCl := TBitmap.Create;
    BRUp := TBitmap.Create;
    BRDo := TBitmap.Create;
    BRCl.Transparent := True;
    BRUp.Transparent := True;
    BRDo.Transparent := True;
      {$IFDEF DEBUG}
  ShowMessage('Initialize TRollsUp');
  {$ENDIF}
    BrCl.LoadFromResourceName(HInstance, 'MROLLCLOSE');
    BRUp.LoadFromResourceName(HInstance, 'MROLLUP');
    BRDo.LoadFromResourceName(HInstance, 'MROLLDOWN');
      {$IFDEF DEBUG}
  ShowMessage('Resources Loaded');
  {$ENDIF}
  end;

finalization
  begin
    BRCl.Free;
    BRUp.Free;
    BRDo.Free;
  end;

end.

