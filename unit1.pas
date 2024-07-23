(*
    videoDownloader escrito em object-pascal
    Copyright (C) <2024>  <Luiz Gabriel Magalhães Trindade>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*)

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

