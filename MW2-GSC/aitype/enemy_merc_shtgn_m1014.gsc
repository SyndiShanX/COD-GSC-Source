/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_merc_shtgn_m1014.gsc
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
    self setEngagementMinDist(0.000000, 0.000000);
    self setEngagementMaxDist(280.000000, 400.000000);
  }

  switch (codescripts\character::get_random_weapon(3)) {
    case 0:
      self.weapon = "m1014";
      break;
    case 1:
      self.weapon = "m1014";
      break;
    case 2:
      self.weapon = "m1014";
      break;
  }

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character\character_opforce_merc_shotgun_a::main();
      break;
    case 1:
      character\character_opforce_merc_shotgun_b::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_opforce_merc_shotgun_a::precache();
  character\character_opforce_merc_shotgun_b::precache();

  precacheItem("m1014");
  precacheItem("m1014");
  precacheItem("m1014");
  precacheItem("pp2000");
  precacheItem("fraggrenade");
}