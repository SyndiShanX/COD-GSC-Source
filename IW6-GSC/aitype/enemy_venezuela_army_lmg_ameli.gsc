/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_venezuela_army_lmg_ameli.gsc
*****************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
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
      self.weapon = "ameli";
      break;
    case 1:
      self.weapon = "ameli+acoglmg_sp";
      break;
    case 2:
      self.weapon = "ameli+eotechlmg_sp";
      break;
    case 3:
      self.weapon = "ameli+reflexlmg_sp";
      break;
  }

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character\character_venezuela_army_assault_a::main();
      break;
    case 1:
      character\character_venezuela_army_smg_a::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_venezuela_army_assault_a::precache();
  character\character_venezuela_army_smg_a::precache();
  precacheitem("ameli");
  precacheitem("ameli+acoglmg_sp");
  precacheitem("ameli+eotechlmg_sp");
  precacheitem("ameli+reflexlmg_sp");
  precacheitem("p226");
  precacheitem("fraggrenade");
}