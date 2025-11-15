/*********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\ally_hero_price_desert.gsc
*********************************************/

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
  self.secondaryweapon = "colt45";
  self.sidearm = "colt45";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "m16_grenadier";
  character\character_sp_usmc_vasquez::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_sp_usmc_vasquez::precache();
  precacheitem("m16_grenadier");
  precacheitem("m203");
  precacheitem("colt45");
  precacheitem("colt45");
  precacheitem("fraggrenade");
}