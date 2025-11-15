/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_venezuela_army_smg_pp19_d.gsc
******************************************************/

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
    self setengagementmindist(128.0, 0.0);
    self setengagementmaxdist(512.0, 768.0);
  }

  switch (codescripts\character::get_random_weapon(4)) {
    case 0:
      self.weapon = "pp19";
      break;
    case 1:
      self.weapon = "pp19+eotechsmg_sp";
      break;
    case 2:
      self.weapon = "pp19+reflexsmg_sp";
      break;
    case 3:
      self.weapon = "pp19+acogsmg_sp";
      break;
  }

  character\character_venezuela_army_smg_a_head_d::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_venezuela_army_smg_a_head_d::precache();
  precacheitem("pp19");
  precacheitem("pp19+eotechsmg_sp");
  precacheitem("pp19+reflexsmg_sp");
  precacheitem("pp19+acogsmg_sp");
  precacheitem("p226");
  precacheitem("fraggrenade");
}