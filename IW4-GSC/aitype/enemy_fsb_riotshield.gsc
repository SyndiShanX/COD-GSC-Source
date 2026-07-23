/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_fsb_riotshield.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "riotshield.csv";
  self.team = "axis";
  self.type = "human";
  self.subclass = "riotshield";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "riotshield";
  self.sidearm = "usp";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  switch (codescripts\character::get_random_weapon(2)) {
    case 0:
      self.weapon = "mp5";
      break;
    case 1:
      self.weapon = "mp5_reflex";
      break;
  }

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character\character_opforce_fsb_assault_a::main();
      break;
    case 1:
      character\character_opforce_fsb_shotgun::main();
      break;
    case 2:
      character\character_opforce_fsb_smg::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
    character\character_opforce_fsb_assault_a::precache();
    character\character_opforce_fsb_shotgun::precache();
    character\character_opforce_fsb_smg::precache();

    precacheItem("mp5");
    precacheItem("mp5_reflex");
    precacheItem("riotshield");
    precacheItem("usp");
    precacheItem("fraggrenade");