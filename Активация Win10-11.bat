::Sintal TG:@Salatx160fps @SoftWareDeweloper

@echo off
setlocal EnableDelayedExpansion
chcp 1251 >nul

:: ������������
set "PRODUCT_KEY=W269N-WFGWX-YVC9B-4J6C9-T83GX"
set "KMS_SERVERS=kms.digiboy.ir;kms.msguides.com;kms.lotro.cc"
set "LOG_FILE=%TEMP%\kms_activation.log"

net session >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ������: ��������� ����� ��������������.
    echo ��������� ������ �� ����� ��������������.
    pause
    exit /b 1
)

::Sintal TG:@Salatx160fps @SoftWareDeweloper

if exist "%LOG_FILE%" del "%LOG_FILE%"

echo [%DATE% %TIME%] ������ ��������� >> "%LOG_FILE%"
echo.

echo TG:@Salatx160fps
echo TG:@SoftWareDeweloper
echo.
echo.
echo.
echo ��������� �����: %PRODUCT_KEY%
cscript //nologo "%WINDIR%\System32\slmgr.vbs" /ipk %PRODUCT_KEY% >> "%LOG_FILE%" 2>&1
if %ERRORLEVEL% neq 0 (
    echo ������: �� ������� ���������� ����.
    echo [%DATE% %TIME%] ������ ��������� �����: %PRODUCT_KEY% >> "%LOG_FILE%"
    pause
    exit /b 1
) else (
    echo ���� ������� ����������.
    echo [%DATE% %TIME%] ���� ����������: %PRODUCT_KEY% >> "%LOG_FILE%"
)

::Sintal TG:@Salatx160fps @SoftWareDeweloper

set "ACTIVATED=0"
for %%S in (%KMS_SERVERS%) do (
    if !ACTIVATED! equ 0 (
        echo ����������� � KMS-�������: %%S
        cscript //nologo "%WINDIR%\System32\slmgr.vbs" /skms %%S >> "%LOG_FILE%" 2>&1
        if !ERRORLEVEL! equ 0 (
            echo ������ %%S ����������.
            echo [%DATE% %TIME%] ������ %%S ���������� >> "%LOG_FILE%"
            :: ������� ���������
            cscript //nologo "%WINDIR%\System32\slmgr.vbs" /ato >> "%LOG_FILE%" 2>&1
            if !ERRORLEVEL! equ 0 (
                echo �����: Windows ������������ ����� %%S!
                echo [%DATE% %TIME%] ��������� ������� ����� %%S >> "%LOG_FILE%"
                set "ACTIVATED=1"
            ) else (
                echo ������: ��������� ����� %%S �� �������.
                echo [%DATE% %TIME%] ������ ��������� ����� %%S >> "%LOG_FILE%"
            )
        ) else (
            echo ������: �� ������� ������������ � %%S.
            echo [%DATE% %TIME%] ������ ����������� � %%S >> "%LOG_FILE%"
        )
    )
)

if %ACTIVATED% equ 0 (
    echo ������: �� ������� ������������ Windows.
    echo ����������� � %LOG_FILE%.
    pause
    exit /b 1
)

::Sintal TG:@Salatx160fps @SoftWareDeweloper

echo �������� ������� ���������...
cscript //nologo "%WINDIR%\System32\slmgr.vbs" /xpr >> "%LOG_FILE%" 2>&1
echo [%DATE% %TIME%] �������� ������� ��������� >> "%LOG_FILE%"

echo.
echo ������. ��� ������� � %LOG_FILE%.
pause
exit /b 0

::Sintal TG:@Salatx160fps @SoftWareDeweloper