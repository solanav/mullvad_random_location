# Get the list of relays
$list_vpns = mullvad.exe relay list;

# Remove the tabs at the start
$list_vpns = $list_vpns.TrimStart()

# Select only countries (start with upper-case and don't contain a comma)
$list_vpns = $list_vpns | Select-String -CaseSensitive "^[A-Z]";
$list_vpns = $list_vpns | Select-String -NotMatch ",";

# Create a list to store the country code
$random_locations = New-Object Collections.Generic.List[String];
foreach ($match in $list_vpns)
{
	# Extract the country code from the string
	$location = $match.ToString().Split("(")[1].Split(")")[0];
	
	# Add the country code to our list
	$random_locations.add($location);
}

# Get a random country code
$chosen_location = $random_locations | Get-Random;

# Change the relay location with our random one
mullvad.exe relay set location $chosen_location;
