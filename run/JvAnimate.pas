{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvAnimate.PAS, released on 2001-02-28.

The Initial Developer of the Original Code is S�bastien Buysse [sbuysse@buypin.com]
Portions created by S�bastien Buysse are Copyright (C) 2001 S�bastien Buysse.
All Rights Reserved.

Contributor(s): Michael Beck [mbeck@bigfoot.com].
                Andr� Snepvangers [asn@xs4all.nl]

2003-01-19 - (asn) support for CLX

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id$

{$I jvcl.inc}

unit JvAnimate;

interface

uses
  SysUtils, Classes,
  {$IFDEF VCL}
  Graphics, Controls, Forms, ComCtrls,
  {$ENDIF VCL}
  {$IFDEF VisualCLX}
  QGraphics, QControls, QForms, QComCtrls,
  {$ENDIF VisualCLX}
  JvThemes, JvExComCtrls;

{$IFDEF VisualCLX}
 {$IF not declared(TJvExAnimate)}
  This unit needs at least Delphi 7 or Kylix 3.
 {$IFEND}
{$ENDIF VisualCLX}

type
  TJvAnimate = class(TJvExAnimate)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property HintColor;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnParentColorChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
    property OnResize;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
  end;

implementation

constructor TJvAnimate.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF VCL}
  IncludeThemeStyle(Self, [csParentBackground]);
  {$ENDIF VCL}
end;

end.

