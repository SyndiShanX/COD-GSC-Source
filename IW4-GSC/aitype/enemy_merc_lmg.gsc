/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_merc_lmg.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "pp2000";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(512.000000, 400.000000);
    self setEngagementMaxDist(1024.000000, 1250.000000);
  }

  switch (codescripts\character::get_random_weapon(3)) {
    case 0:
      self.weapon = "rpd";
      break;
    case 1:
      self.weapon = "rpd_reflex";
      break;
    case 2:
      self.weapon = "rpd_acog";
      break;
  }

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character\character_opforce_merc_lmg_a::main();
      break;
    case 1:
      character\character_opforce_merc_lmg_b::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_opforce_merc_lmg_a::precache();
  character\character_opforce_merc_lmg_b::precache();

  precacheItem("rpd");
  precacheItem("rpd_reflex");
  precacheItem("rpd_acog");
  precacheItem("pp2000");
  precacheItem("fraggrenade");
}