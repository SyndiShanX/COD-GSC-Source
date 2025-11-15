/*************************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\ally_marine_woodland_ar_m4grenadiernbp.gsc
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

  self.weapon = "m4_grenadier";
  character\character_sp_usmc_force_a::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_sp_usmc_force_a::precache();
  precacheitem("m4_grenadier");
  precacheitem("m203_m4");
  precacheitem("usp");
  precacheitem("usp");
  precacheitem("fraggrenade");
}