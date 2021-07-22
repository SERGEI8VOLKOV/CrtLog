unit uStart;

interface

  procedure PStart();

implementation

uses System.Classes,Vcl.Forms,SysUtils,System.IOUtils,IniFiles,uLog;

procedure PStart();
  var
      i: integer;
      sExeName,sIniName,sIniFile,sSectionSearch,sOper,
      sParol,sLogin,sParol1,sLogin1: AnsiString;
      lIni,lCorrect: Boolean;
      FIniFile: TIniFile;
      stLogin: array [1..2] of AnsiString;
      stParol: array [1..2] of AnsiString;
  begin
    sExeName := Application.ExeName;
    uLog.LogFileName := ChangeFileExt(sExeName,'.log');

    slog('','Starting project',2);

    write('Введите логин ');
    readln(sLogin);
    if sLogin='' then
    begin
      slog('','Exit project',2);
      exit;
    end;

    write('Введите пароль ');
    readln(sParol);
    if sParol='' then
    begin
      slog('','Exit project',2);
      exit;
    end;

    sIniName := ChangeFileExt(sExeName,'.INI');
    FIniFile := TIniFile.Create(sIniName);
    lIni := true;

   	try
      for i := 1 to 2 do
      begin
        sSectionSearch := 'Oper' + IntToStr(i);
        sLogin1 := FIniFile.ReadString(sSectionSearch, 'Login', '');
        sParol1 := FIniFile.ReadString(sSectionSearch, 'Parol', '');
        if (sLogin1='') or (sParol1='') then
        begin
          lIni := false;
          break;
        end;
        stLogin[i] := sLogin1;
        stParol[i] := sParol1;
      end;
    except
      lIni := false;
    end;

    FIniFile.Free;

    if lIni=false then
     begin
      slog('','Некорректные данные в ini файле',3);
      lCorrect := false;
     end
    else
     begin
      lCorrect := false;
      for i:=1 to 2 do
       if stLogin[i]=sLogin Then
       begin
        lCorrect := true;
        break;
       end;
      if lCorrect=false then
        slog('','Некорректный Login',3);

      if (lCorrect=true) and (stParol[i]<>sParol) then
       begin
         slog('','Некорректный Parol',3);
         lCorrect := false;
       end;
     end;

    if lCorrect then
    begin
      slog('','Начало работы оператра ' + sLogin,2);
      // ...
      slog('','Конец работы оператра ' + sLogin,2);
    end;

    slog('','Exit project',2);

  end;

end.
