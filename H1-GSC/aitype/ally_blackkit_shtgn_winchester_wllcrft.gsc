/*************************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\ally_blackkit_shtgn_winchester_wllcrft.gsc
*************************************************************/

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

  self.weapon = "winchester1200";
  character\character_sp_sas_ct_charles::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_sp_sas_ct_charles::precache();
  precacheitem("winchester1200");
  precacheitem("usp");
  precacheitem("usp");
  precacheitem("fraggrenade");
}