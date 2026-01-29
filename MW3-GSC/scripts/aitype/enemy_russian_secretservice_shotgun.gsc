/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_russian_secretservice_shotgun.gsc
******************************************************************/

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

  self.weapon = "aa12";

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      _id_5893::main();
      break;
    case 1:
      _id_5894::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  _id_5893::precache();
  _id_5894::precache();
  precacheitem("aa12");
  precacheitem("fnfiveseven");
  precacheitem("fraggrenade");
}