function GetTeamsInfo ($AllTeams) {
	foreach ($team in $AllTeams) {
        $props = @{
		'DisplayName'=$team.DisplayName;
		'Visibility'=$team.Visibility;
		'Description' = $team.Description;
		'AllowGiphy' = $team.AllowGiphy;
		'AllowUserEditMessages' = $team.AllowUserEditMessages;
		'AllowTeamMentions' = $team.AllowTeamMentions;
		'Channel#'= @(Get-TeamChannel -GroupId $team.groupid).count
		}
		New-Object -TypeName PSObject -Property $props
        }}


$params = @{'As'='Table';
'EvenRowCssClass'='even';
'OddRowCssClass'='odd';
'TableCssClass'='grid';
'Properties'='DisplayName','Visibility','Description','AllowGiphy','AllowUserEditMessages','AllowTeamMentions','Channel#'}

$Teams = Get-Team
$Teamsinfo = GetTeamsInfo $Teams | ConvertTo-EnhancedHTMLFragment @params

ConvertTo-EnhancedHTML -HTMLFragments $Teamsinfo -CssUri 'C:\PowerShell\CSS\styles2.css' -PreContent "<h1>Teams Report</H1>" | Out-File "C:\PowerShell\TeamsReport.html"
