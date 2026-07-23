/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_africa_militia_payback_rpg.gsc
***************************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "common_rambo_anims.csv";
  self.team = "axis";
  self.type = "human";
  self.subclass = "militia";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "ak47";
  self.sidearm = "usp";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(768.0, 512.0);
    self setengagementmaxdist(1024.0, 1500.0);
  }

  self.weapon = "rpg";

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character/character_africa_militia_rpg_a::main();
      break;
    case 1:
      character/character_africa_militia_rpg_b::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character/character_africa_militia_rpg_a::precache();
  character/character_africa_militia_rpg_b::precache();
  precacheitem("rpg");
  precacheitem("ak47");
  precacheitem("usp");
  precacheitem("fraggrenade");
  maps/_rambo::main();
}