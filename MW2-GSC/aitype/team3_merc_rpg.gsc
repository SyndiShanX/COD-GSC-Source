/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\team3_merc_rpg.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "team3";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "ak47_reflex";
  self.sidearm = "pp2000";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(768.000000, 512.000000);
    self setEngagementMaxDist(1024.000000, 1500.000000);
  }

  self.weapon = "rpg";

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character\character_opforce_merc_assault_a::main();
      break;
    case 1:
      character\character_opforce_merc_assault_b::main();
      break;
    case 2:
      character\character_opforce_merc_assault_c::main();
      break;
  }
}

spawner() {
  self setspawnerteam("team3");
}

precache() {
  character\character_opforce_merc_assault_a::precache();
  character\character_opforce_merc_assault_b::precache();
  character\character_opforce_merc_assault_c::precache();

  precacheItem("rpg");
  precacheItem("ak47_reflex");
  precacheItem("pp2000");
  precacheItem("fraggrenade");
}