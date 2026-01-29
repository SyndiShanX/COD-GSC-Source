/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\civilian_hamburg_male_hostage.gsc
************************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "neutral";
  self.type = "civilian";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 30;
  self.secondaryweapon = "";
  self.sidearm = "";
  self.grenadeweapon = "";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "none";
  _id_5BA1::main();
}

spawner() {
  self setspawnerteam("neutral");
}

precache() {
  _id_5BA1::precache();
}