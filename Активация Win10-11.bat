::Sintal TG:@Salatx160fps @SoftWareDeweloper

@echo off
setlocal EnableDelayedExpansion
chcp 1251 >nul

:: Конфигурация
set "PRODUCT_KEY=W269N-WFGWX-YVC9B-4J6C9-T83GX"
set "KMS_SERVERS=kms.digiboy.ir;kms.msguides.com;kms.lotro.cc"
set "LOG_FILE=%TEMP%\kms_activation.log"

net session >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Ошибка: Требуются права администратора.
    echo Запустите скрипт от имени администратора.
    pause
    exit /b 1
)

::Sintal TG:@Salatx160fps @SoftWareDeweloper

if exist "%LOG_FILE%" del "%LOG_FILE%"

echo [%DATE% %TIME%] Начало активации >> "%LOG_FILE%"
echo.

echo TG:@Salatx160fps
echo TG:@SoftWareDeweloper
echo.
echo.
echo.
echo Установка ключа: %PRODUCT_KEY%
cscript //nologo "%WINDIR%\System32\slmgr.vbs" /ipk %PRODUCT_KEY% >> "%LOG_FILE%" 2>&1
if %ERRORLEVEL% neq 0 (
    echo Ошибка: Не удалось установить ключ.
    echo [%DATE% %TIME%] Ошибка установки ключа: %PRODUCT_KEY% >> "%LOG_FILE%"
    pause
    exit /b 1
) else (
    echo Ключ успешно установлен.
    echo [%DATE% %TIME%] Ключ установлен: %PRODUCT_KEY% >> "%LOG_FILE%"
)

::Sintal TG:@Salatx160fps @SoftWareDeweloper

set "ACTIVATED=0"
for %%S in (%KMS_SERVERS%) do (
    if !ACTIVATED! equ 0 (
        echo Подключение к KMS-серверу: %%S
        cscript //nologo "%WINDIR%\System32\slmgr.vbs" /skms %%S >> "%LOG_FILE%" 2>&1
        if !ERRORLEVEL! equ 0 (
            echo Сервер %%S установлен.
            echo [%DATE% %TIME%] Сервер %%S установлен >> "%LOG_FILE%"
            :: Попытка активации
            cscript //nologo "%WINDIR%\System32\slmgr.vbs" /ato >> "%LOG_FILE%" 2>&1
            if !ERRORLEVEL! equ 0 (
                echo Успех: Windows активирована через %%S!
                echo [%DATE% %TIME%] Активация успешна через %%S >> "%LOG_FILE%"
                set "ACTIVATED=1"
            ) else (
                echo Ошибка: Активация через %%S не удалась.
                echo [%DATE% %TIME%] Ошибка активации через %%S >> "%LOG_FILE%"
            )
        ) else (
            echo Ошибка: Не удалось подключиться к %%S.
            echo [%DATE% %TIME%] Ошибка подключения к %%S >> "%LOG_FILE%"
        )
    )
)

if %ACTIVATED% equ 0 (
    echo Ошибка: Не удалось активировать Windows.
    echo Подробности в %LOG_FILE%.
    pause
    exit /b 1
)

::Sintal TG:@Salatx160fps @SoftWareDeweloper

echo Проверка статуса активации...
cscript //nologo "%WINDIR%\System32\slmgr.vbs" /xpr >> "%LOG_FILE%" 2>&1
echo [%DATE% %TIME%] Проверка статуса завершена >> "%LOG_FILE%"

echo.
echo Готово. Лог сохранён в %LOG_FILE%.
pause
exit /b 0

::Sintal TG:@Salatx160fps @SoftWareDeweloper