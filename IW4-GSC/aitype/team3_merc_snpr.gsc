/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\team3_merc_snpr.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "sniper_glint.csv";
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
    self setEngagementMinDist(1250.000000, 1024.000000);
    self setEngagementMaxDist(1600.000000, 2400.000000);
  }

  switch (codescripts\character::get_random_weapon(2)) {
    case 0:
      self.weapon = "dragunov";
      break;
    case 1:
      self.weapon = "dragunov_woodland";
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
      character\character_opforce_merc_smg_c::main();
      break;
  }
}

spawner() {
  self setspawnerteam("team3");
}

precache() {
    character\character_opforce_merc_smg_a::precache();
    character\character_opforce_merc_smg_b::precache();
    character\character_opforce_merc_smg_c::precache();

    precacheItem("dragunov");
    precacheItem("dragunov_woodland");
    precacheItem("pp2000");
    precacheItem("fraggrenade");