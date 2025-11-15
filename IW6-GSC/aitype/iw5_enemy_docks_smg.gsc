/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\iw5_enemy_docks_smg.gsc
******************************************/

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
  self.sidearm = "fnfiveseven";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  switch (codescripts\character::get_random_weapon(3)) {
    case 0:
      self.weapon = "p90";
      break;
    case 1:
      self.weapon = "p90_eotech";
      break;
    case 2:
      self.weapon = "p90_reflex";
      break;
  }

  switch (codescripts\character::get_random_character(8)) {
    case 0:
      character\character_chemwar_russian_assault_b::main();
      break;
    case 1:
      character\character_chemwar_russian_assault_c::main();
      break;
    case 2:
      character\character_chemwar_russian_assault_d::main();
      break;
    case 3:
      character\character_chemwar_russian_assault_e::main();
      break;
    case 4:
      character\character_chemwar_russian_assault_bb::main();
      break;
    case 5:
      character\character_chemwar_russian_assault_cc::main();
      break;
    case 6:
      character\character_chemwar_russian_assault_dd::main();
      break;
    case 7:
      character\character_chemwar_russian_assault_ee::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_chemwar_russian_assault_b::precache();
  character\character_chemwar_russian_assault_c::precache();
  character\character_chemwar_russian_assault_d::precache();
  character\character_chemwar_russian_assault_e::precache();
  character\character_chemwar_russian_assault_bb::precache();
  character\character_chemwar_russian_assault_cc::precache();
  character\character_chemwar_russian_assault_dd::precache();
  character\character_chemwar_russian_assault_ee::precache();
  precacheitem("p90");
  precacheitem("p90_eotech");
  precacheitem("p90_reflex");
  precacheitem("fnfiveseven");
  precacheitem("fraggrenade");
}