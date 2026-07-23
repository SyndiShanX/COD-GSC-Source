/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_opforce_widowmaker_ak47.gsc
************************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.25;
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
  _id_4957::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  _id_4957::precache();
  precacheitem("ak47");
  precacheitem("glock");
  precacheitem("fraggrenade");
}