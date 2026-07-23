/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\civilian_russian_president.gsc
*********************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "civilian";
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

  self.weapon = "ak47";
  _id_3E5E::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_3E5E::precache();
  precacheitem("ak47");
  precacheitem("fraggrenade");
}