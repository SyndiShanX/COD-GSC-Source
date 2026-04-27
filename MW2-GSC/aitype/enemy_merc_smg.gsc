/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_merc_smg.gsc
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
  self.sidearm = "glock";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(128.000000, 0.000000);
    self setEngagementMaxDist(512.000000, 768.000000);
  }

  switch (codescripts\character::get_random_weapon(7)) {
    case 0:
      self.weapon = "p90";
      break;
    case 1:
      self.weapon = "p90_acog";
      break;
    case 2:
      self.weapon = "p90_reflex";
      break;
    case 3:
      self.weapon = "ump45_reflex";
      break;
    case 4:
      self.weapon = "tmp";
      break;
    case 5:
      self.weapon = "ump45_acog";
      break;
    case 6:
      self.weapon = "ump45_eotech";
      break;
  }

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character\character_opforce_merc_smg_a::main();
      break;
    case 1:
      character\character_opforce_merc_smg_b::main();
      break;
    case 2:
      character\character_opforce_merc_smg_a::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_opforce_merc_smg_a::precache();
  character\character_opforce_merc_smg_b::precache();
  character\character_opforce_merc_smg_a::precache();

  precacheItem("p90");
  precacheItem("p90_acog");
  precacheItem("p90_reflex");
  precacheItem("ump45_reflex");
  precacheItem("tmp");
  precacheItem("ump45_acog");
  precacheItem("ump45_eotech");
  precacheItem("glock");
  precacheItem("fraggrenade");
}