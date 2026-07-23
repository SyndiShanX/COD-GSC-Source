/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\team3_merc_shotgunauto.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "team3";
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

  switch (codescripts\character::get_random_weapon(2)) {
    case 0:
      self.weapon = "striker_woodland";
      break;
    case 1:
      self.weapon = "striker_woodland_reflex";
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
  self setspawnerteam("team3");
}

precache() {
  character\character_opforce_merc_shotgun_a::precache();
  character\character_opforce_merc_shotgun_b::precache();

  precacheItem("striker_woodland");
  precacheItem("striker_woodland_reflex");
  precacheItem("pp2000");
  precacheItem("fraggrenade");
}