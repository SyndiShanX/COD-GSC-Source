/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_marine_woodland_ar_m4grunt.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "usp";
  self.sidearm = "usp";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  self.weapon = "m4_grunt";

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character\character_sp_usmc_force_a::main();
      break;
    case 1:
      character\character_sp_usmc_force_b::main();
      break;
    case 2:
      character\character_sp_usmc_force_c::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_sp_usmc_force_a::precache();
  character\character_sp_usmc_force_b::precache();
  character\character_sp_usmc_force_c::precache();

  precacheItem("m4_grunt");
  precacheItem("usp");
  precacheItem("usp");
  precacheItem("fraggrenade");
}