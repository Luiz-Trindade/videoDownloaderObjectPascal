unit Unit1;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, Forms, Controls, Graphics,
    Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, Process;

type

    { TForm1 }

    TForm1 = class(TForm)
        Button1: TButton;
        Edit1: TEdit;
        Image1: TImage;
        SelectDirectoryDialog1: TSelectDirectoryDialog;
        StaticText1: TStaticText;
        procedure Button1Click(Sender: TObject);
        procedure StaticText1Click(Sender: TObject);
    private

    public

    end;

var
    Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
//Declaração de variáveis
var
   linkToDownload: String;
   directoryToSave: String;
   AProcess: TProcess;

begin
   linkToDownload := Edit1.Text;

   //Selecionar um diretório
   if SelectDirectoryDialog1.Execute then
   begin
     directoryToSave := SelectDirectoryDialog1.FileName;

     //WriteLn('Link para download: ', linkToDownload);
     //WriteLn('Diretório selecionado para salvar: ', directoryToSave);

     AProcess := TProcess.Create(nil);
     try
       AProcess.Executable := './yt-dlp/yt-dlp_linux';
       AProcess.Parameters.Add(linkToDownload);
       AProcess.Parameters.Add('-o');
       AProcess.Parameters.Add(directoryToSave + '/%(title)s.%(ext)s');
       AProcess.Options := AProcess.Options + [poWaitOnExit];
       AProcess.Execute;
     finally
       AProcess.Free;
       ShowMessage('Download concluído com sucesso!');
     end;
   end

   //Caso a seleção do diretório seja cancelada
   else
   begin
        ShowMessage('Seleção de arquivos cancelada');
   end;
end;

procedure TForm1.StaticText1Click(Sender: TObject);
begin

end;

end.

