{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvExExtCtrls.pas, released on 2004-01-04

The Initial Developer of the Original Code is Andreas Hausladen [Andreas.Hausladen@gmx.de]
Portions created by Andreas Hausladen are Copyright (C) 2004 Andreas Hausladen.
All Rights Reserved.

Contributor(s): -

Last Modified: 2004-01-13

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
{$I jvcl.inc}

unit JvExExtCtrls;
interface
uses
  {$IFDEF VCL}
  Windows, Messages, Graphics, Controls, Forms, ExtCtrls,
  {$ENDIF VCL}
  {$IFDEF VisualCLX}
  Qt, QGraphics, QControls, QForms, QExtCtrls,
  {$ENDIF VisualCLX}
  Classes, SysUtils,
  JvThemes, JvExControls;

{$IFDEF VCL}
 {$DEFINE NeedMouseEnterLeave}
{$ELSE}
 {$IF not declared(PatchedVCLX)}
  {$DEFINE NeedMouseEnterLeave}
 {$IFEND}
{$ENDIF VCL}

type
  JV_CONTROL_EVENTS(Shape)
  JV_CONTROL_EVENTS(PaintBox)
  JV_CONTROL_EVENTS(Image)
  JV_CONTROL_EVENTS(Bevel)
  JV_CUSTOMCONTROL_EVENTS(CustomPanel)
  JV_CUSTOMCONTROL_EVENTS(Panel)
  JV_WINCONTROL_EVENTS(CustomRadioGroup)
  JV_WINCONTROL_EVENTS(RadioGroup)
  JV_CONTROL_EVENTS(Splitter)

  JV_CUSTOMCONTROL_EVENTS_BEGIN(CustomControlBar)
  {$IFDEF VisualCLX}
  protected
    function HitTest(X, Y: Integer): Boolean; overload; dynamic;
  {$ENDIF VisualCLX}
  JV_CUSTOMCONTROL_EVENTS_END(CustomControlBar)

  JV_CUSTOMCONTROL_EVENTS_BEGIN(ControlBar)
  {$IFDEF VisualCLX}
  protected
    function HitTest(X, Y: Integer): Boolean; overload; dynamic;
  {$ENDIF VisualCLX}
  JV_CUSTOMCONTROL_EVENTS_END(ControlBar)
  
{$IFDEF VCL}
  JV_CUSTOMCONTROL_EVENTS(Page)
  JV_CUSTOMCONTROL_EVENTS(Notebook)
  JV_CUSTOMCONTROL_EVENTS(Header)
  {$IFDEF COMPILER6_UP}
  JV_CONTROL_EVENTS(BoundLabel)
  JV_WINCONTROL_EVENTS(CustomLabeledEdit)
  JV_WINCONTROL_EVENTS(LabeledEdit)
  JV_WINCONTROL_EVENTS(CustomColorBox)
  JV_WINCONTROL_EVENTS(ColorBox)
  {$ENDIF COMPILER6_UP}
{$ENDIF VCL}

implementation

JV_CONTROL_EVENTS_IMPL(Shape)
JV_CONTROL_EVENTS_IMPL(PaintBox)
JV_CONTROL_EVENTS_IMPL(Image)
JV_CONTROL_EVENTS_IMPL(Bevel)
JV_CUSTOMCONTROL_EVENTS_IMPL(CustomPanel)
JV_CUSTOMCONTROL_EVENTS_IMPL(Panel)
JV_WINCONTROL_EVENTS_IMPL(CustomRadioGroup)
JV_WINCONTROL_EVENTS_IMPL(RadioGroup)
JV_CONTROL_EVENTS_IMPL(Splitter)

JV_CUSTOMCONTROL_EVENTS_IMPL_BEGIN(CustomControlBar)
{$IFDEF VisualCLX}
function TJvExCustomControlBar.HitTest(X, Y: Integer): Boolean;
begin
  Result := (X >= 0) and (Y >= 0) and (X < Width) and (Y < Height);
end;
{$ENDIF VisualCLX}
JV_CUSTOMCONTROL_EVENTS_IMPL_END(CustomControlBar)

JV_CUSTOMCONTROL_EVENTS_IMPL_BEGIN(ControlBar)
{$IFDEF VisualCLX}
function TJvExControlBar.HitTest(X, Y: Integer): Boolean;
begin
  Result := (X >= 0) and (Y >= 0) and (X < Width) and (Y < Height);
end;
{$ENDIF VisualCLX}
JV_CUSTOMCONTROL_EVENTS_IMPL_END(ControlBar)

{$IFDEF VCL}
JV_CUSTOMCONTROL_EVENTS_IMPL(Page)
JV_CUSTOMCONTROL_EVENTS_IMPL(Notebook)
JV_CUSTOMCONTROL_EVENTS_IMPL(Header)
 {$IFDEF COMPILER6_UP}
JV_CONTROL_EVENTS_IMPL(BoundLabel)
JV_WINCONTROL_EVENTS_IMPL(CustomLabeledEdit)
JV_WINCONTROL_EVENTS_IMPL(LabeledEdit)
JV_WINCONTROL_EVENTS_IMPL(CustomColorBox)
JV_WINCONTROL_EVENTS_IMPL(ColorBox)
 {$ENDIF COMPILER6_UP}
{$ENDIF VCL}

end.
