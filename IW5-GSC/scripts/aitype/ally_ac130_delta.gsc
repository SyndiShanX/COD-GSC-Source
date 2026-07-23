/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\ally_ac130_delta.gsc
***********************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.secondaryweapon = "";
  self.sidearm = "";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "none";

  switch (codescripts\character::get_random_character(4)) {
    case 0:
      character/character_delta_elite_assault_aa::main();
      break;
    case 1:
      character/character_delta_elite_assault_ab::main();
      break;
    case 2:
      character/character_delta_elite_assault_ba::main();
      break;
    case 3:
      _id_06B9::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character/character_delta_elite_assault_aa::precache();
  character/character_delta_elite_assault_ab::precache();
  character/character_delta_elite_assault_ba::precache();
  _id_06B9::precache();
  precacheitem("fraggrenade");
}