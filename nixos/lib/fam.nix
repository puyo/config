{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fam = {
    isNormalUser = true;
    description = "Fam";
    extraGroups = ["networkmanager" "wheel"];
  };
}
