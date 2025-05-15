@echo off
echo 正在设置VSCode右键菜单选项...

:: 请求管理员权限
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorlevel% NEQ 0 (
    echo 需要管理员权限来修改注册表。
    echo 请右键点击此脚本，选择"以管理员身份运行"。
    pause
    exit /B
)

:: 检查VSCode安装路径
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

echo 未找到VSCode安装路径。
echo 请输入VSCode安装路径（例如：C:\Program Files\Microsoft VS Code）：
set /p input_path=
if exist "%input_path%\Code.exe" (
    set "vscode_exe=%input_path%\Code.exe"
    goto setup
) else (
    echo 在指定路径未找到Code.exe，请确认路径是否正确。
    pause
    exit /B
)

:setup
echo 找到VSCode路径：%vscode_exe%

:: 添加右键菜单 - 为文件添加"使用VSCode打开"选项
reg add "HKEY_CLASSES_ROOT\*\shell\VSCode" /t REG_SZ /d "使用 VS Code 打开" /f
reg add "HKEY_CLASSES_ROOT\*\shell\VSCode" /v Icon /t REG_SZ /d "%vscode_exe%" /f
reg add "HKEY_CLASSES_ROOT\*\shell\VSCode\command" /t REG_SZ /d "\"%vscode_exe%\" \"%%1\"" /f

:: 添加右键菜单 - 为文件夹添加"使用VSCode打开"选项
reg add "HKEY_CLASSES_ROOT\Directory\shell\VSCode" /t REG_SZ /d "使用 VS Code 打开" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\VSCode" /v Icon /t REG_SZ /d "%vscode_exe%" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\VSCode\command" /t REG_SZ /d "\"%vscode_exe%\" \"%%1\"" /f

:: 添加右键菜单 - 为文件夹背景添加"使用VSCode打开"选项
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\VSCode" /t REG_SZ /d "使用 VS Code 打开" /f
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\VSCode" /v Icon /t REG_SZ /d "%vscode_exe%" /f
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\VSCode\command" /t REG_SZ /d "\"%vscode_exe%\" \"%%V\"" /f

echo 设置完成！现在您可以通过右键菜单使用VSCode打开文件和文件夹了。
pause