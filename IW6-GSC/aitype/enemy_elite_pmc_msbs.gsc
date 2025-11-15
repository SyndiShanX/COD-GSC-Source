/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_elite_pmc_msbs.gsc
*******************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "elite";
  self.accuracy = 0.2;
  self.health = 250;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self.sidearm = "p226";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  switch (codescripts\character::get_random_weapon(4)) {
    case 0:
      self.weapon = "msbs";
      break;
    case 1:
      self.weapon = "msbs+acog_sp";
      break;
    case 2:
      self.weapon = "msbs+eotech_sp";
      break;
    case 3:
      self.weapon = "msbs+reflex_sp";
      break;
  }

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character\character_elite_pmc_assault_a::main();
      break;
    case 1:
      character\character_elite_pmc_assault_b::main();
      break;
    case 2:
      character\character_elite_pmc_assault_a_black::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_elite_pmc_assault_a::precache();
  character\character_elite_pmc_assault_b::precache();
  character\character_elite_pmc_assault_a_black::precache();
  precacheitem("msbs");
  precacheitem("msbs+acog_sp");
  precacheitem("msbs+eotech_sp");
  precacheitem("msbs+reflex_sp");
  precacheitem("p226");
  precacheitem("fraggrenade");
}