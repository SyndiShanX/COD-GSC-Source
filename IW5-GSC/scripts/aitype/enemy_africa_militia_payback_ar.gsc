/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_africa_militia_payback_ar.gsc
**************************************************************/

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
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  switch (codescripts\character::get_random_weapon(4)) {
    case 0:
      self.weapon = "ak47";
      break;
    case 1:
      self.weapon = "ak47_reflex";
      break;
    case 2:
      self.weapon = "ak47_grenadier";
      break;
    case 3:
      self.weapon = "ak47_acog";
      break;
  }

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character/character_africa_militia_assault_a::main();
      break;
    case 1:
      character/character_africa_militia_assault_b::main();
      break;
    case 2:
      character/character_africa_militia_assault_c::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character/character_africa_militia_assault_a::precache();
  character/character_africa_militia_assault_b::precache();
  character/character_africa_militia_assault_c::precache();
  precacheitem("ak47");
  precacheitem("ak47_reflex");
  precacheitem("ak47_grenadier");
  precacheitem("gl_ak47");
  precacheitem("ak47_acog");
  precacheitem("usp");
  precacheitem("fraggrenade");
  maps/_rambo::main();
}