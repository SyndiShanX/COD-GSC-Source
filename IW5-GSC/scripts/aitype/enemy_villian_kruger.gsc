/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_villian_kruger.gsc
***************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.12;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(512.0, 1024.0);
  }

  self.weapon = "usp";
  _id_5B98::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  _id_5B98::precache();
  precacheitem("usp");
  precacheitem("fraggrenade");
}