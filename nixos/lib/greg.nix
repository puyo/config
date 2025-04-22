{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.greg = {
    isNormalUser = true;
    description = "Greg";
    extraGroups = ["networkmanager" "wheel"];
  };
}
