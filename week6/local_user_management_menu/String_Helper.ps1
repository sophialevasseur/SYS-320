function checkPassword($password){

    # Convert the secure string back to plain text so we can check it
    $plain = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
                [Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

    # Check: must be at least 6 characters long
    if($plain.Length -lt 6){
        return $false
    }

    # Check: must contain at least one letter (a-z or A-Z)
    if($plain -notmatch "[a-zA-Z]"){
        return $false
    }

    # Check: must contain at least one number (0-9)
    if($plain -notmatch "[0-9]"){
        return $false
    }

    # Check: must contain at least one special character
    if($plain -notmatch "[^a-zA-Z0-9]"){
        return $false
    }

    # If all checks passed, the password is good!
    return $true
}
