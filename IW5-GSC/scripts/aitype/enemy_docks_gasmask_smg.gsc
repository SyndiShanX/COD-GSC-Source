/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_docks_gasmask_smg.gsc
******************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "fnfiveseven";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  switch (codescripts\character::get_random_weapon(6)) {
    case 0:
      self.weapon = "p90";
      break;
    case 1:
      self.weapon = "p90_eotech";
      break;
    case 2:
      self.weapon = "p90_reflex";
      break;
    case 3:
      self.weapon = "pp90m1";
      break;
    case 4:
      self.weapon = "pp90m1_eotech";
      break;
    case 5:
      self.weapon = "pp90m1_reflex";
      break;
  }

  switch (codescripts\character::get_random_character(10)) {
    case 0:
      character/character_chemwar_russian_assault_a::main();
      break;
    case 1:
      character/character_chemwar_russian_assault_m_b::main();
      break;
    case 2:
      character/character_chemwar_russian_assault_m_c::main();
      break;
    case 3:
      character/character_chemwar_russian_assault_m_d::main();
      break;
    case 4:
      character/character_chemwar_russian_assault_m_e::main();
      break;
    case 5:
      character/character_chemwar_russian_assault_aa::main();
      break;
    case 6:
      character/character_chemwar_russian_assault_m_bb::main();
      break;
    case 7:
      character/character_chemwar_russian_assault_m_cc::main();
      break;
    case 8:
      character/character_chemwar_russian_assault_m_dd::main();
      break;
    case 9:
      character/character_chemwar_russian_assault_m_ee::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character/character_chemwar_russian_assault_a::precache();
  character/character_chemwar_russian_assault_m_b::precache();
  character/character_chemwar_russian_assault_m_c::precache();
  character/character_chemwar_russian_assault_m_d::precache();
  character/character_chemwar_russian_assault_m_e::precache();
  character/character_chemwar_russian_assault_aa::precache();
  character/character_chemwar_russian_assault_m_bb::precache();
  character/character_chemwar_russian_assault_m_cc::precache();
  character/character_chemwar_russian_assault_m_dd::precache();
  character/character_chemwar_russian_assault_m_ee::precache();
  precacheitem("p90");
  precacheitem("p90_eotech");
  precacheitem("p90_reflex");
  precacheitem("pp90m1");
  precacheitem("pp90m1_eotech");
  precacheitem("pp90m1_reflex");
  precacheitem("fnfiveseven");
  precacheitem("fraggrenade");
}