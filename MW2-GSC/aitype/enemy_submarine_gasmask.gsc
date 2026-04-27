/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_submarine_gasmask.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 30;
  self.secondaryweapon = "";
  self.sidearm = "usp";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  switch (codescripts\character::get_random_weapon(7)) {
    case 0:
      self.weapon = "ak47";
      break;
    case 1:
      self.weapon = "spas12";
      break;
    case 2:
      self.weapon = "kriss";
      break;
    case 3:
      self.weapon = "kriss_reflex";
      break;
    case 4:
      self.weapon = "spas12_eotech";
      break;
    case 5:
      self.weapon = "ak47_shotgun";
      break;
    case 6:
      self.weapon = "ak47_eotech";
      break;
  }

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character\character_submarine_enemy_a::main();
      break;
    case 1:
      character\character_submarine_enemy_b::main();
      break;
    case 2:
      character\character_submarine_enemy_c::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_submarine_enemy_a::precache();
  character\character_submarine_enemy_b::precache();
  character\character_submarine_enemy_c::precache();

  precacheItem("ak47");
  precacheItem("spas12");
  precacheItem("kriss");
  precacheItem("kriss_reflex");
  precacheItem("spas12_eotech");
  precacheItem("ak47_shotgun");
  precacheItem("ak47_shotgun_attach");
  precacheItem("ak47_eotech");
  precacheItem("usp");
  precacheItem("fraggrenade");
}