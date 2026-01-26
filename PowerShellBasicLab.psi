# Get IPv4 Address (Deliverable 1)
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet*"}).IPAddress

# Get the IPv4 prefix length from the ethernet interface (Deliverable 2)
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet*"}).PrefixLength

# Show what classes there are in the Win32 library that start with net (Deliverable 3)
# Sort classes alphabetically (Deliverable 4)
Get-WmiObject -List | Where-Object { $_.Name -like "Win32_Net*" } | Sort-Object Name | Select-Object Name

# Get DHCP Server IP (Deliverable 5)
Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=True" | Select-Object DHCPServer

# Hide Table Headers (Deliverable 6)
Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=True" | Select-Object DHCPServer | Format-Table -HideTableHeaders

# Get DNS Server IP for ethernet and display first one
(Get-DnsClientServerAddress -InterfaceAlias "Ethernet" -AddressFamily IPv4).ServerAddresses[0]
