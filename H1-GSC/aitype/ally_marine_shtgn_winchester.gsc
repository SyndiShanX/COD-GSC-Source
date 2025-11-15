/***************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\ally_marine_shtgn_winchester.gsc
***************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "colt45";
  self.sidearm = "colt45";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "winchester1200";

  switch (codescripts\character::get_random_character(6)) {
    case 0:
      character\character_sp_usmc_james::main();
      break;
    case 1:
      character\character_sp_usmc_sami::main();
      break;
    case 2:
      character\character_sp_usmc_ryan::main();
      break;
    case 3:
      character\character_sp_usmc_sami_goggles::main();
      break;
    case 4:
      character\character_sp_usmc_zach::main();
      break;
    case 5:
      character\character_sp_usmc_zach_goggles::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_sp_usmc_james::precache();
  character\character_sp_usmc_sami::precache();
  character\character_sp_usmc_ryan::precache();
  character\character_sp_usmc_sami_goggles::precache();
  character\character_sp_usmc_zach::precache();
  character\character_sp_usmc_zach_goggles::precache();
  precacheitem("winchester1200");
  precacheitem("colt45");
  precacheitem("colt45");
  precacheitem("fraggrenade");
}