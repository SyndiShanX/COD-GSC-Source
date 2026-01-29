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
      _id_05CC::main();
      break;
    case 1:
      _id_05CD::main();
      break;
    case 2:
      _id_05CE::main();
      break;
    case 3:
      _id_05CF::main();
      break;
    case 4:
      _id_05D0::main();
      break;
    case 5:
      _id_05D1::main();
      break;
    case 6:
      _id_05D2::main();
      break;
    case 7:
      _id_05D3::main();
      break;
    case 8:
      _id_05D4::main();
      break;
    case 9:
      _id_05D5::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  _id_05CC::precache();
  _id_05CD::precache();
  _id_05CE::precache();
  _id_05CF::precache();
  _id_05D0::precache();
  _id_05D1::precache();
  _id_05D2::precache();
  _id_05D3::precache();
  _id_05D4::precache();
  _id_05D5::precache();
  precacheitem("p90");
  precacheitem("p90_eotech");
  precacheitem("p90_reflex");
  precacheitem("pp90m1");
  precacheitem("pp90m1_eotech");
  precacheitem("pp90m1_reflex");
  precacheitem("fnfiveseven");
  precacheitem("fraggrenade");
}