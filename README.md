Here is a collection of script that basic prep a linux server and join them into Domain running AD

The initsetup.sh script will install necessary packages and call the JoinDomain.exp to join the machine into the domain

To be able to run the script, you will need to pass the below argument into the script
  
  1. Name of the PDC (This is used to sync the system clock with the domain you are going to join)
  2. FQDN of the Domain you wanted to join
  3. Username to join the domain
  4. Password of the user account used to join the domain
  5. Name of the AD group which can logon and manage this linux host 

Usage: ./initsetup.sh {Name of the PDC} {Domain you wanted to join} {Username to join the domain} {Password} {Name of the server admin group}

The script in the role folder will help you to install software packages

The script in the config folder will help you to config software application
