@echo off
goto runme

n mdcode.bin
l 0050:0000
o 1166 8
o 1160 21
o 1163 1
o 1166 0
o 1167 0
o 1164 81
o 1163 3
o 1167 0f
o 1166 f0
m 0050:0000 l 82 ce00:0100
o 1163 1
o 1164 81
q

REM I used the DOS parameter area at 0050:0000 because my assembled 68k program was
REM only a hundred-odd bytes. The MD only have 64KB of worm RAM, which is only a single
REM segment. If you wanna change it, go right for, just remember to update lines
REM 5 AND 15.

:runme
echo This will load the 68k binary into PC RAM, start the interface,
echo transfer that binary into MD work RAM, and transfer control.
echo.
echo Once the 68k is out of reset, it brings the system into dual-CPU
echo mode, and DOS resumes.
echo.
pause
debug < dualgo.bat
echo Should be done now.
echo.
pause
cls
echo The two sides can now only communicate through **TWO BITS** in each
echo direction:
echo.
echo MD $AE0001 bits 0, 1 :: PC I/O Port 1163 bits 4, 5
echo PC I/O Port 1163 bits 6, 7 :: MD $AE0001 bits 2, 3
echo.
echo Either CPU can set/clear port 1164 bits 0 and 3 to end dual mode.
