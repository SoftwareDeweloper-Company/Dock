rem By Salatx160fps
rem Короче это вирус на добавление Программы в автозагрузку (Прикол в том что она запускается после запуска ОС)
@echo off
set "programPath=C:\ВАШ ПУТЬ К ФАЙЛУ"  rem Укажите полный путь к вашему исполняемому файлу
rem reg add ...: Эта команда добавляет запись в реестр Windows для автозагрузки программы.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "MyProgram" /t REG_SZ /d "%programPath%" /f
echo Программа добавлена в автозагрузку.
pause
