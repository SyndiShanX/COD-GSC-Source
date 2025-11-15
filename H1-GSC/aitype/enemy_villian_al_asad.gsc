/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\enemy_villian_al_asad.gsc
********************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "beretta";
  self.sidearm = "deserteagle";

  if(isai(self)) {
    self setengagementmindist(128.0, 0.0);
    self setengagementmaxdist(512.0, 1024.0);
  }

  self.weapon = "ak74u";
  character\character_sp_al_asad::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_sp_al_asad::precache();
  precacheitem("ak74u");
  precacheitem("beretta");
  precacheitem("deserteagle");
  precacheitem("fraggrenade");
}