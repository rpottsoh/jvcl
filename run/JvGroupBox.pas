{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvGroupBox.PAS, released on 2000-11-22.

The Initial Developer of the Original Code is Peter Below <100113.1101@compuserve.com>
Portions created by Peter Below are Copyright (C) 2000 Peter Below.
All Rights Reserved.

Contributor(s): ______________________________________.

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id$

{$I jvcl.inc}

unit JvGroupBox;

interface

uses
  SysUtils, Classes,
  {$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF MSWINDOWS}
  {$IFDEF VCL}
  Messages, Graphics, Controls, Forms, StdCtrls,
  {$ENDIF VCL}
  {$IFDEF VisualCLX}
  Types, Qt, QWindows, QGraphics, QControls, QForms, QStdCtrls,
  {$ENDIF VisualCLX}
  JvThemes, JvExControls, JvExStdCtrls;

type
  TJvGroupBox = class(TJvExGroupBox, IJvDenySubClassing)
  private
    FOnHotKey: TNotifyEvent;
    FPropagateEnable: Boolean;
    procedure SetPropagateEnable(const Value: Boolean);
  protected
    function WantKey(Key: Integer; Shift: TShiftState;
      const KeyText: WideString): Boolean; override;
    procedure EnabledChanged; override;
    procedure DoHotKey; dynamic;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Canvas;
  published
    property HintColor;
    {$IFDEF JVCLThemesEnabledD56}
    property ParentBackground default True;
    {$ENDIF JVCLThemesEnabledD56}
    property PropagateEnable: Boolean read FPropagateEnable write SetPropagateEnable default False;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnParentColorChange;
    property OnHotKey: TNotifyEvent read FOnHotKey write FOnHotKey;
  end;

implementation

uses
  Math;

constructor TJvGroupBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPropagateEnable := False;
  ControlStyle := ControlStyle + [csAcceptsControls];
  {$IFDEF JVCLThemesEnabledD56}
  IncludeThemeStyle(Self, [csParentBackground]);
  {$ENDIF JVCLThemesEnabledD56}
end;

procedure TJvGroupBox.Paint;
{$IFDEF VisualCLX}
const
  clWindowFrame = cl3DDkShadow;
{$ENDIF VisualCLX}
var
  H: Integer;
  R: TRect;
  Flags: Longint;
  {$IFDEF JVCLThemesEnabledD56}
  Details: TThemedElementDetails;
  CaptionRect: TRect;
  {$ENDIF JVCLThemesEnabledD56}
  LastBkMode: Integer;
  {$IFDEF VCL}
  Txt: PChar;
  {$ENDIF VCL}
  {$IFDEF VisualCLX}
  Txt: WideString;
  {$ENDIF VisualCLX}
begin
  {$IFDEF JVCLThemesEnabled}
  if ThemeServices.ThemesEnabled then
  begin
    {$IFDEF COMPILER7_UP}
    inherited Paint;
    {$ELSE}
    if Enabled then
      Details := ThemeServices.GetElementDetails(tbGroupBoxNormal)
    else
      Details := ThemeServices.GetElementDetails(tbGroupBoxDisabled);
    R := ClientRect;
    Inc(R.Top, Canvas.TextHeight('0') div 2);
    ThemeServices.DrawElement(Canvas.Handle, Details, R);

    CaptionRect := Rect(8, 0, Min(Canvas.TextWidth(Caption) + 8, ClientWidth - 8),
      Canvas.TextHeight(Caption));

    Canvas.Brush.Color := Self.Color;
    DrawThemedBackground(Self, Canvas, CaptionRect);
    ThemeServices.DrawText(Canvas.Handle, Details, Caption, CaptionRect, DT_LEFT, 0);
    {$ENDIF COMPILER7_UP}
    Exit;
  end;
  {$ENDIF JVCLThemesEnabled}
  with Canvas do
  begin
    {$IFDEF VCL}
    Txt := PChar(Text);
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
    Txt := Text;
    Start;
    {$ENDIF VisualCLX}
    LastBkMode := GetBkMode(Handle);
    try
      Font := Self.Font;
      H := TextHeight('0');
      R := Rect(0, H div 2 - 1, Width, Height);
      {$IFDEF VCL}
      if Ctl3D then
      begin
      {$ENDIF VCL}
        Inc(R.Left);
        Inc(R.Top);
        Brush.Color := clBtnHighlight;
        {$IFDEF VCL}
        FrameRect(R);
        {$ENDIF VCL}
        {$IFDEF VisualCLX}
        QWindows.FrameRect(Canvas, R);
        {$ENDIF VisualCLX}
        OffsetRect(R, -1, -1);
        Brush.Color := clBtnShadow;
      {$IFDEF VCL}
      end
      else
        Brush.Color := clWindowFrame;
      FrameRect(R);
      {$ENDIF VCL}
      {$IFDEF VisualCLX}
      QWindows.FrameRect(Canvas, R);
      {$ENDIF VisualCLX}
      if Text <> '' then
      begin
        if not UseRightToLeftAlignment then
          R := Rect(8, 0, 0, H)
        else
          R := Rect(R.Right - Canvas.TextWidth(Text) - 8, 0, 0, H);
        Flags := DrawTextBiDiModeFlags(DT_SINGLELINE);
        // calculate text rect
        SetBkMode(Handle, OPAQUE);
        DrawText(Handle, Txt, Length(Text), R, Flags or DT_CALCRECT);
        Brush.Color := Color;
        if not Enabled then
        begin
          OffsetRect(R, 1, 1);
          Font.Color := clBtnHighlight;
          DrawText(Handle, Txt, Length(Text), R, Flags);
          OffsetRect(R, -1, -1);
          Font.Color := clBtnShadow;
          SetBkMode(Handle, TRANSPARENT);
          DrawText(Handle, Txt, Length(Text), R, Flags);
        end
        else
          DrawText(Handle, Txt, Length(Text), R, Flags);
      end;
    finally
      SetBkMode(Handle, LastBkMode);
      {$IFDEF VisualCLX}
      Stop;
      {$ENDIF VisualCLX}
    end;
  end;
end;

function TJvGroupBox.WantKey(Key: Integer; Shift: TShiftState;
  const KeyText: WideString): Boolean;
begin
  Result := inherited WantKey(Key, Shift, KeyText);
  if Result then
    DoHotKey;
end;

procedure TJvGroupBox.EnabledChanged;
var
  I: Integer;
begin
  inherited EnabledChanged;
  if PropagateEnable then
    for I := 0 to ControlCount - 1 do
      Controls[I].Enabled := Enabled;
  Invalidate;
end;

procedure TJvGroupBox.DoHotKey;
begin
  if Assigned(FOnHotKey) then
    FOnHotKey(Self);
end;

procedure TJvGroupBox.SetPropagateEnable(const Value: Boolean);
var
  I: Integer;
begin
  FPropagateEnable := Value;
  for I := 0 to ControlCount - 1 do
    Controls[I].Enabled := Enabled;
end;

end.

