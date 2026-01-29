/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\ally_hero_nikolai_payback.gsc
********************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "";
  self.grenadeweapon = "";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "usp";
  _id_647F::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_647F::precache();
  precacheitem("usp");
}