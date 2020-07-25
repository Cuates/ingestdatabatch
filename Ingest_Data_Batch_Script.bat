@echo off
REM ECHO without anything following results in ECHO is off

ECHO Check if file exist
if exist \\path_to_file\File_Name.csv (
  ECHO CSV File
  REM CSV File
  "E:\SQL (x86)\Microsoft SQL Server\110\DTS\Binn\DTExec.exe" /File "\\path_to_file\IngestData.dtsx"

  ECHO Update Table In Bulk
  REM Update Table In Bulk Temp
  sqlcmd -S <Server_Name> -d <Database_Name> -Q "exec [dbo].[<Stored_Procedure_Name>] @optionMode = '<Option_Mode_Name>'"

  ECHO Insert Table In Bulk
  REM Insert Table In Bulk
  sqlcmd -S <Server_Name> -d <Database_Name> -Q "exec [dbo].[<Stored_Procedure_Name>] @optionMode = '<Option_Mode_Name>'"

  ECHO Delete CSV file
  REM Delete CSV file
  del \\path_to_file\File_Name.csv
)

REM pause