@echo off
echo ��������VSCode�Ҽ��˵�ѡ��...

:: �������ԱȨ��
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorlevel% NEQ 0 (
    echo ��Ҫ����ԱȨ�����޸�ע���
    echo ���Ҽ�����˽ű���ѡ��"�Թ���Ա�������"��
    pause
    exit /B
)

:: ���VSCode��װ·��
set "vscode_exe="

if exist "%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe" (
    set "vscode_exe=%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe"
    goto setup
)

if exist "C:\Program Files\Microsoft VS Code\Code.exe" (
    set "vscode_exe=C:\Program Files\Microsoft VS Code\Code.exe"
    goto setup
)

if exist "C:\Program Files (x86)\Microsoft VS Code\Code.exe" (
    set "vscode_exe=C:\Program Files (x86)\Microsoft VS Code\Code.exe"
    goto setup
)

echo δ�ҵ�VSCode��װ·����
echo ������VSCode��װ·�������磺C:\Program Files\Microsoft VS Code����
set /p input_path=
if exist "%input_path%\Code.exe" (
    set "vscode_exe=%input_path%\Code.exe"
    goto setup
) else (
    echo ��ָ��·��δ�ҵ�Code.exe����ȷ��·���Ƿ���ȷ��
    pause
    exit /B
)

:setup
echo �ҵ�VSCode·����%vscode_exe%

:: ����Ҽ��˵� - Ϊ�ļ����"ʹ��VSCode��"ѡ��
reg add "HKEY_CLASSES_ROOT\*\shell\VSCode" /t REG_SZ /d "ʹ�� VS Code ��" /f
reg add "HKEY_CLASSES_ROOT\*\shell\VSCode" /v Icon /t REG_SZ /d "%vscode_exe%" /f
reg add "HKEY_CLASSES_ROOT\*\shell\VSCode\command" /t REG_SZ /d "\"%vscode_exe%\" \"%%1\"" /f

:: ����Ҽ��˵� - Ϊ�ļ������"ʹ��VSCode��"ѡ��
reg add "HKEY_CLASSES_ROOT\Directory\shell\VSCode" /t REG_SZ /d "ʹ�� VS Code ��" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\VSCode" /v Icon /t REG_SZ /d "%vscode_exe%" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\VSCode\command" /t REG_SZ /d "\"%vscode_exe%\" \"%%1\"" /f

:: ����Ҽ��˵� - Ϊ�ļ��б������"ʹ��VSCode��"ѡ��
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\VSCode" /t REG_SZ /d "ʹ�� VS Code ��" /f
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\VSCode" /v Icon /t REG_SZ /d "%vscode_exe%" /f
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\VSCode\command" /t REG_SZ /d "\"%vscode_exe%\" \"%%V\"" /f

echo ������ɣ�����������ͨ���Ҽ��˵�ʹ��VSCode���ļ����ļ����ˡ�
pause