{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvgBitBtn.PAS, released on 2003-01-15.

The Initial Developer of the Original Code is Andrey V. Chudin,  [chudin@yandex.ru]
Portions created by Andrey V. Chudin are Copyright (C) 2003 Andrey V. Chudin.
All Rights Reserved.

Contributor(s):
Michael Beck [mbeck@bigfoot.com].

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id$

{$I jvcl.inc}

unit JvgBitBtn;

interface

uses
  Windows, Messages, Classes, Controls, Graphics, ExtCtrls, Buttons, Forms,
  JVCLVer,
  JvgTypes, JvgCommClasses, JvgUtils, JvExButtons;

type
  TJvgBitBtn = class(TJvExBitBtn)
  private
    FAboutJVCL: TJVCLAboutInfo;
    FCanvas: TControlCanvas;
    function GetCanvas: TCanvas;
    procedure CNDrawItem(var Msg: TWMDrawItem); message CN_DRAWITEM;
  protected
    procedure DrawItem(const DrawItemStruct: TDrawItemStruct);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Canvas: TCanvas read GetCanvas;
  published
    property AboutJVCL: TJVCLAboutInfo read FAboutJVCL write FAboutJVCL stored False;
    property HintColor;
    property OnParentColorChange;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

implementation

constructor TJvgBitBtn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self; //...i can draw now! :)
end;

destructor TJvgBitBtn.Destroy;
begin
  inherited Destroy;
  // (rom) destroy Canvas AFTER inherited Destroy
  FCanvas.Free;
end;

function TJvgBitBtn.GetCanvas: TCanvas;
begin
  Result := FCanvas;
end;

procedure TJvgBitBtn.CNDrawItem(var Msg: TWMDrawItem);
begin
  inherited;
  DrawItem(Msg.DrawItemStruct^);
end;

procedure TJvgBitBtn.DrawItem(const DrawItemStruct: TDrawItemStruct);
var
  IsDown: Boolean;
  R: TRect;
begin
  if csDestroying in ComponentState then
    Exit;
  FCanvas.Handle := DrawItemStruct.hDC;
  R := ClientRect;
  IsDown := DrawItemStruct.itemState and ODS_SELECTED <> 0;
  if (not MouseOver) and (not IsDown) then
    with FCanvas do
      if not Focused and not Default then
      begin
        Pen.Color := clBtnFace;
        MoveTo(R.Left + 1, R.Top + 1);
        LineTo(R.Right - 1, R.Top + 1);
        MoveTo(R.Left + 1, R.Top + 1);
        LineTo(R.Left + 1, R.Bottom - 1);

        Pen.Color := (Parent as TWinControl).Brush.Color;
        MoveTo(R.Left, R.Bottom - 1);
        LineTo(R.Right, R.Bottom - 1);
        MoveTo(R.Right - 1, R.Top);
        LineTo(R.Right - 1, R.Bottom);

        Pen.Color := clBtnShadow;
        MoveTo(R.Left - 2, R.Bottom - 2);
        LineTo(R.Right - 1, R.Bottom - 2);
        MoveTo(R.Right - 2, R.Top);
        LineTo(R.Right - 2, R.Bottom - 1);
      end
      else
      begin
        Brush.Color := clBtnFace;
        FrameRect(Rect(R.Left + 2, R.Top + 2, R.Right - 2, R.Bottom - 2));
      end;
  FCanvas.Handle := 0;
end;

end.

