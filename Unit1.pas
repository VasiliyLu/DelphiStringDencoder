unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Character,
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
    btnToSimpleString: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure mInClick(Sender: TObject);
    procedure btnToSimpleStringClick(Sender: TObject);
  private
    { Private declarations }
    function StrFromClipboard(const AClear: boolean = false): string;
    function StrToStrDelphi(const AString: string): string;
    procedure StrToClipBoard(const AString: string);
    function StrDelphiToString(const ADelphiString: string): string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Vcl.ClipBrd;

{$R *.dfm}

procedure TForm1.btnToSimpleStringClick(Sender: TObject);
begin
  mOut.Lines.Text := StrDelphiToString(mIn.Lines.Text);
end;

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
var
  inText: string;
begin
  inText := StrFromClipboard(true);
  mIn.Lines.Text := inText;
  if (inText.Length > 1) and (inText[1] = '''') and
    (inText[inText.Length] = '''') then
    mOut.Text := StrDelphiToString(inText)
  else
    mOut.Text := StrToStrDelphi(inText);
  StrToClipBoard(mOut.Text);
  if not inText.IsEmpty then
    Timer1.Enabled := true;
end;

procedure TForm1.mInClick(Sender: TObject);
begin
  Timer1.Enabled := false;
end;

function TForm1.StrDelphiToString(const ADelphiString: string): string;
var
  i: integer;
  startQuote: integer;

  procedure RaiseInvalidDelphiString;
  begin
    raise Exception.Create(ADelphiString + ' is Invalid Delphi String');
  end;

  function GetCharByGrid: Char;
  var
    buf: string;
  begin
    buf := '';
    if ADelphiString[i] = '#' then
      inc(i);
    while ADelphiString[i].IsDigit do
    begin
      buf := buf + ADelphiString[i];
      inc(i);
    end;
    if buf.Length > 0 then
      Result := Chr(StrToInt(buf))
    else
      Result := #0;
    dec(i);
  end;

begin
  startQuote := 0;
  i := 1;

  while i <= ADelphiString.Length do
  begin
    if ADelphiString[i] = '''' then
    begin
      if (i + 1 <= ADelphiString.Length) and (ADelphiString[i + 1] = '''') then
      begin
        Result := Result + ADelphiString[i];
        inc(i, 2);
        continue;
      end;

      if startQuote = 0 then
      begin
        startQuote := i;
      end
      else
      begin
        startQuote := 0;
      end;

    end
    else if startQuote = 0 then
    begin
      if ADelphiString[i] = '#' then
      begin
        Result := Result + GetCharByGrid;
      end;
    end
    else
    begin
      Result := Result + ADelphiString[i];
    end;
    inc(i);
  end;

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

procedure TForm1.StrToClipBoard(const AString: string);
begin
  if AString <> '' then
    Clipboard.AsText := AString;
end;

function TForm1.StrToStrDelphi(const AString: string): string;
var
  sl: TStringList;
  i: integer;

  function GetsLineBreakStr(const AValue: String): string; inline;
  var
    i: integer;
  begin
    Result := '';
    for i := 1 to AValue.Length do
      Result := Result + '#' + Ord(AValue[i]).ToString;
  end;

  function ProcessLine(const ALine: string): string; inline;
  begin
    Result := '''' + ALine + '''+' + GetsLineBreakStr(sLineBreak) + '+' +
      sLineBreak;
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
