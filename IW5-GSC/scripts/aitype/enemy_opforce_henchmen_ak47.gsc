/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_opforce_henchmen_ak47.gsc
**********************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "glock";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "ak47";

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
  precacheitem("ak47");
  precacheitem("glock");
  precacheitem("fraggrenade");
}