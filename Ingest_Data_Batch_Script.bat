@echo off
REM ECHO without anything following results in ECHO is off

setlocal enabledelayedexpansion

ECHO Check if file exists
if exist "\\path_to_file\File_Name.csv" (
  ECHO CSV File found
  REM CSV File
  "path_to_dtsx_executable\SQL (x86)\Microsoft SQL Server\110\DTS\Binn\DTExec.exe" /File "\\path_to_file\IngestData.dtsx"
  if !errorlevel! neq 0 (
    ECHO Error executing DTExec
    exit /b 1
  )

  ECHO Updating Table In Bulk
  REM Update Table In Bulk Temp
  sqlcmd -S "<Server_Name>" -d "<Database_Name>" -Q "exec [dbo].[<Stored_Procedure_Name>] @optionMode = '<Option_Mode_Name>'"
  if !errorlevel! neq 0 (
    ECHO Error updating table
    exit /b 1
  )

  ECHO Inserting Table In Bulk
  REM Insert Table In Bulk
  sqlcmd -S "<Server_Name>" -d "<Database_Name>" -Q "exec [dbo].[<Stored_Procedure_Name>] @optionMode = '<Option_Mode_Name>'"
  if !errorlevel! neq 0 (
    ECHO Error inserting table
    exit /b 1
  )

  ECHO Deleting CSV file
  REM Delete CSV file
  del "\\path_to_file\File_Name.csv"
  if !errorlevel! neq 0 (
    ECHO Error deleting CSV file
    exit /b 1
  )
) else (
  ECHO CSV File not found
  exit /b 1
)

ECHO Script completed successfully
REM Uncomment the pause line below if you want to see the output of the executions above in the terminal before it disappears
REM pause
exit /b 0
