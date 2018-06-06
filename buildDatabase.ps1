# Script created 5/24/2018 by Dasra
# Shared freely, but a beer would be appreciated if you find this useful and we are ever in the same pub
# Full documentation for Redgate DLM Automation PowerShell cmdlets at:
# https://documentation.red-gate.com/display/DLMA2/Cmdlet+reference
 
# Variables (fill these in)
 
   # Required - the location of your source code
   $scriptsFolder = args[0] #"C:\gith\dasra"  # where\is\your\DB\source\code
   
   # Required - package name and version number (must not already exist in output directory)
   $packageID = "dasra"
   $packageVersion = args[1]
   
   # Required - An output directory in which to save your build artifacts (must already exist)
   $outputDir = "C:\gith"
   
   # Optional - If using an alternate SQL instance for schema validation provide details here. Also, uncomment this parameter from line 34 below.
   #$buildDb = "Data Source=.\test_devops"
      
   # Required for sync step only - the database you wish to deploy to. Uncomment below and also lines 46-8 if running a sync step.
   $targetServerInstance = "WIN-5G0BS5PR8OG\SQLEXPRESS"
   $targetDatabaseName = "dasra"
   
   # Optional - If using SQL Auth for target DB add a username and password. Also, uncomment these parameters from line 42 below.
   $username = "sa"
   $password = "Nepal12#"
 
# Script to build DB (you can probably leave this as is)
   
   $errorActionPreference = "stop"
    
   # Validate the scripts folder
   $validatedScriptsFolder = Invoke-DlmDatabaseSchemaValidation $scriptsFolder # -TemporaryDatabaseServer $buildDb
 
   # Export NuGet package
   $package = New-DlmDatabasePackage $validatedScriptsFolder -PackageId $packageID -PackageVersion $packageVersion
   Export-DlmDatabasePackage $package -Path $outputDir
 
# Script to run tests and/or deploy to an integration DB (uncomment as appropriate)
 
   # # Run tSQLt unit tests
   # Invoke-DlmDatabaseTests $package | Export-DlmDatabaseTestResults -OutputFile "$outputDir\$packageID.$packageVersion.junit.xml"
 
   # # Sync a test database
  # $targetDB = New-DlmDatabaseConnection -ServerInstance $targetServerInstance -Database $targetDatabaseName  -Username $username -Password $password
  # Test-DlmDatabaseConnection $targetDB
   # Sync-DlmDatabaseSchema -Source $package -Target $targetDB 

