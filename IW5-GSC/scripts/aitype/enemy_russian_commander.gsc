/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_russian_commander.gsc
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

  self.weapon = "ak74u";
  _id_34E8::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  _id_34E8::precache();
  precacheitem("ak74u");
  precacheitem("fnfiveseven");
  precacheitem("fraggrenade");
}