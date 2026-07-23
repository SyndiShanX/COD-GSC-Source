/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_africa_militia_payback_lmg.gsc
***************************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "common_rambo_anims.csv";
  self.team = "axis";
  self.type = "human";
  self.subclass = "militia";
  self.accuracy = 0.12;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "usp";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(512.0, 400.0);
    self setengagementmaxdist(1024.0, 1250.0);
  }

  switch (codescripts\character::get_random_weapon(3)) {
    case 0:
      self.weapon = "pecheneg";
      break;
    case 1:
      self.weapon = "pecheneg_acog";
      break;
    case 2:
      self.weapon = "pecheneg_reflex";
      break;
  }

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character/character_africa_militia_lmg_a::main();
      break;
    case 1:
      character/character_africa_militia_lmg_b::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character/character_africa_militia_lmg_a::precache();
  character/character_africa_militia_lmg_b::precache();
  precacheitem("pecheneg");
  precacheitem("pecheneg_acog");
  precacheitem("pecheneg_reflex");
  precacheitem("usp");
  precacheitem("fraggrenade");
  maps/_rambo::main();
}