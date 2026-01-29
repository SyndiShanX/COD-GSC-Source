/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_villain_makarov_hijack.gsc
***********************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.secondaryweapon = "";
  self.sidearm = "";
  self.grenadeweapon = "";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "fnfiveseven";
  _id_34E5::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_34E5::precache();
  precacheitem("fnfiveseven");
}