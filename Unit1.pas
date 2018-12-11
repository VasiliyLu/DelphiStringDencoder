unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    mIn: TMemo;
    Splitter1: TSplitter;
    Panel1: TPanel;
    mOut: TMemo;
    Button1: TButton;
    Button2: TButton;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure mInClick(Sender: TObject);
  private
    { Private declarations }
    function StrFromClipboard(const AClear: boolean = false): string;
    function StrToStrDelphi(const AString:string): string;
    procedure StrToClipBoard(const AString:string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Vcl.ClipBrd;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Timer1.Enabled := false;
  mOut.Text := StrToStrDelphi(mIn.Lines.Text);
  StrToClipBoard(mOut.Text);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Timer1.Enabled := false;
  StrToClipBoard(mOut.Text);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  mIn.Lines.Text := StrFromClipboard(true);
  mOut.Text := StrToStrDelphi(mIn.Lines.Text);
  StrToClipBoard(mOut.Text);
end;

procedure TForm1.mInClick(Sender: TObject);
begin
  Timer1.Enabled := false;
end;

function TForm1.StrFromClipboard(const AClear: boolean): string;
begin
  if Clipboard.HasFormat(CF_TEXT) then
  begin
    Result := Clipboard.AsText;
    if AClear then
      Clipboard.Clear;
  end
  else
    Result := '';
end;

procedure TForm1.StrToClipBoard(const AString:string);
begin
  if AString <> '' then
    Clipboard.AsText := AString;
end;

function TForm1.StrToStrDelphi(const AString:string): string;
var
  sl: TStringList;
  i: integer;

  function GetsLineBreakStr(const AValue: String): string; inline;
  var
  i: integer;
  begin
    Result := '';
    for i := 1 to AValue.Length do
      Result := Result+'#'+Ord(AValue[i]).ToString;
  end;

  function ProcessLine(const ALine: string): string; inline;
  begin
    Result := '''' + ALine + '''+' +GetsLineBreakStr(sLineBreak)+'+'+ sLineBreak;
  end;

  function ProcessLastLine(const ALine: string): string; inline;
  begin
    Result := '''' + ALine + '''';
  end;

begin
  sl := TStringList.Create;
  try
    sl.Text := AString;
    Result := '';
    if sl.Count > 0 then
    begin
      for i := 0 to sl.Count - 2 do
        Result := Result + ProcessLine(sl[i]);
      Result := Result + ProcessLastLine(sl[sl.Count - 1]);
    end;
  finally
    sl.Free;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Close;
end;

end.
