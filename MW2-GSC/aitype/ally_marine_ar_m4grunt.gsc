/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_marine_ar_m4grunt.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "colt45";
  self.sidearm = "colt45";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  self.weapon = "m4_grunt";

  switch (codescripts\character::get_random_character(7)) {
    case 0:
      character\character_sp_usmc_james::main();
      break;
    case 1:
      character\character_sp_usmc_sami::main();
      break;
    case 2:
      character\character_sp_usmc_at4::main();
      break;
    case 3:
      character\character_sp_usmc_ryan::main();
      break;
    case 4:
      character\character_sp_usmc_sami_goggles::main();
      break;
    case 5:
      character\character_sp_usmc_zach::main();
      break;
    case 6:
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
  character\character_sp_usmc_at4::precache();
  character\character_sp_usmc_ryan::precache();
  character\character_sp_usmc_sami_goggles::precache();
  character\character_sp_usmc_zach::precache();
  character\character_sp_usmc_zach_goggles::precache();

  precacheItem("m4_grunt");
  precacheItem("colt45");
  precacheItem("colt45");
  precacheItem("fraggrenade");
}