/***********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\ally_hero_mark_no_helmet.gsc
***********************************************/

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
  self.secondaryweapon = "beretta";
  self.sidearm = "beretta";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "saw";
  character\character_sp_usmc_force_mark_no_helmet::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_sp_usmc_force_mark_no_helmet::precache();
  precacheitem("saw");
  precacheitem("beretta");
  precacheitem("beretta");
  precacheitem("fraggrenade");
}