/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_villain_widowmaker_captain.gsc
***************************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.secondaryweapon = "";
  self.sidearm = "glock";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "ak47";
  _id_6865::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  _id_6865::precache();
  precacheitem("ak47");
  precacheitem("glock");
  precacheitem("fraggrenade");
}