/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\team3_merc_smg.gsc
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
    self setEngagementMinDist(128.000000, 0.000000);
    self setEngagementMaxDist(512.000000, 768.000000);
  }

  switch (codescripts\character::get_random_weapon(5)) {
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
      self.weapon = "uzi";
      break;
    case 4:
      self.weapon = "uzi";
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
  self setspawnerteam("team3");
}

precache() {
  character\character_opforce_merc_smg_a::precache();
  character\character_opforce_merc_smg_b::precache();
  character\character_opforce_merc_smg_a::precache();

  precacheItem("p90");
  precacheItem("p90_acog");
  precacheItem("p90_reflex");
  precacheItem("uzi");
  precacheItem("uzi");
  precacheItem("pp2000");
  precacheItem("fraggrenade");
}