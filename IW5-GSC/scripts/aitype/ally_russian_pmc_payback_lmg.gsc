/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\ally_russian_pmc_payback_lmg.gsc
***********************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "usp";
  self.sidearm = "";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "pecheneg";
  _id_6482::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_6482::precache();
  precacheitem("pecheneg");
  precacheitem("usp");
  precacheitem("fraggrenade");
}