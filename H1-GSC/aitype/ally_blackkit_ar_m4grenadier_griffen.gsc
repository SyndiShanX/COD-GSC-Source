/***********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\ally_blackkit_ar_m4grenadier_griffen.gsc
***********************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "usp";
  self.sidearm = "usp";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "m4_grenadier";
  character\character_sp_sas_ct_william::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_sp_sas_ct_william::precache();
  precacheitem("m4_grenadier");
  precacheitem("m203_m4");
  precacheitem("usp");
  precacheitem("usp");
  precacheitem("fraggrenade");
}