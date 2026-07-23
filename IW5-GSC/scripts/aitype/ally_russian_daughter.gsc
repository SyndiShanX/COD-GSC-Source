/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\ally_russian_daughter.gsc
****************************************************/

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

  self.weapon = "none";
  _id_34DE::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_34DE::precache();
}