function prompt
{
	$date = Get-Date
	$time = $date.GetDateTimeFormats()[88]
	$ctx = $ExecutionContext.SessionState.Path.CurrentLocation.Path.Split("\")

	$DRIVE_LETTER = $ExecutionContext.SessionState.Drive.Current.Name
	$PATH = $ctx[-1]
	if ( $ctx.Length -gt 2)
	{
		$PATH = "$(($ctx)[-2])\$PATH"
	}
	if ( $ctx.Length -gt 3)
	{
		$PATH = "...\$PATH"
	}
	$PATH = "${DRIVE_LETTER}:\${PATH}"

	return "${env:USERNAME}@${env:COMPUTERNAME} :: ( ${PATH} ) `n `>>` "
}