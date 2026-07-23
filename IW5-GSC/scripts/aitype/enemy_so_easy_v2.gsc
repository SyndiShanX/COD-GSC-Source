/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_so_easy_v2.gsc
***********************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "none";
  _id_05D8::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  _id_05D8::precache();
  precacheitem("fraggrenade");
}