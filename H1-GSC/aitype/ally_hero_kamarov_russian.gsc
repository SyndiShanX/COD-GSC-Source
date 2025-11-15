/************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\ally_hero_kamarov_russian.gsc
************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "usp";
  self.sidearm = "usp";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "ak47_grenadier";
  character\character_sp_russian_loyalist_d::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_sp_russian_loyalist_d::precache();
  precacheitem("ak47_grenadier");
  precacheitem("gp25");
  precacheitem("usp");
  precacheitem("usp");
  precacheitem("fraggrenade");
}