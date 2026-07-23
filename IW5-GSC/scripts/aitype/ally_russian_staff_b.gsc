/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\ally_russian_staff_b.gsc
***************************************************/

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
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "ak47";
  _id_7D84::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_7D84::precache();
  precacheitem("ak47");
  precacheitem("fraggrenade");
}