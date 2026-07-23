/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_hijacker_ar.gsc
************************************************/

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

  switch (codescripts\character::get_random_weapon(4)) {
    case 0:
      self.weapon = "pp90m1";
      break;
    case 1:
      self.weapon = "pp90m1_eotech";
      break;
    case 2:
      self.weapon = "pp90m1_acog";
      break;
    case 3:
      self.weapon = "pp90m1_reflex";
      break;
  }

  switch (codescripts\character::get_random_character(4)) {
    case 0:
      _id_5FD7::main();
      break;
    case 1:
      _id_5FD8::main();
      break;
    case 2:
      _id_5FD9::main();
      break;
    case 3:
      _id_5FDA::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  _id_5FD7::precache();
  _id_5FD8::precache();
  _id_5FD9::precache();
  _id_5FDA::precache();
  precacheitem("pp90m1");
  precacheitem("pp90m1_eotech");
  precacheitem("pp90m1_acog");
  precacheitem("pp90m1_reflex");
  precacheitem("fnfiveseven");
  precacheitem("fraggrenade");
}