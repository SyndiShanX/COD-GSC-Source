/*************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\ally_nvg_marine_ar_m4grunt.gsc
*************************************************/

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

  self.weapon = "m4_grunt";

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character\character_sp_usmc_zach_nod::main();
      break;
    case 1:
      character\character_sp_usmc_sami_nod::main();
      break;
    case 2:
      character\character_sp_usmc_zach_nod::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_sp_usmc_zach_nod::precache();
  character\character_sp_usmc_sami_nod::precache();
  character\character_sp_usmc_zach_nod::precache();
  precacheitem("m4_grunt");
  precacheitem("colt45");
  precacheitem("colt45");
  precacheitem("fraggrenade");
}