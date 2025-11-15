/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_fed_army_lmg.gsc
*****************************************/

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
      self.weapon = "m27";
      break;
    case 1:
      self.weapon = "m27+acoglmg_sp";
      break;
    case 2:
      self.weapon = "m27+eotechlmg_sp";
      break;
    case 3:
      self.weapon = "m27+reflexlmg_sp";
      break;
  }

  character\character_fed_army_lmg_a::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_fed_army_lmg_a::precache();
  precacheitem("m27");
  precacheitem("m27+acoglmg_sp");
  precacheitem("m27+eotechlmg_sp");
  precacheitem("m27+reflexlmg_sp");
  precacheitem("p226");
  precacheitem("fraggrenade");
}