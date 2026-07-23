/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_opforce_manhattan_ak47.gsc
***********************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "mp412";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  switch (codescripts\character::get_random_weapon(5)) {
    case 0:
      self.weapon = "ak47";
      break;
    case 1:
      self.weapon = "ak47_acog";
      break;
    case 2:
      self.weapon = "ak47_grenadier";
      break;
    case 3:
      self.weapon = "ak47_reflex";
      break;
    case 4:
      self.weapon = "ak47_silencer_acog";
      break;
  }

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      _id_0631::main();
      break;
    case 1:
      _id_0632::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  _id_0631::precache();
  _id_0632::precache();
  precacheitem("ak47");
  precacheitem("ak47_acog");
  precacheitem("ak47_grenadier");
  precacheitem("gl_ak47");
  precacheitem("ak47_reflex");
  precacheitem("ak47_silencer_acog");
  precacheitem("mp412");
  precacheitem("fraggrenade");
}