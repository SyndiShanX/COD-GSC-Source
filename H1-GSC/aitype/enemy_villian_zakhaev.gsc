/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\enemy_villian_zakhaev.gsc
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
  self.sidearm = "beretta";

  if(isai(self)) {
    self setengagementmindist(128.0, 0.0);
    self setengagementmaxdist(512.0, 1024.0);
  }

  self.weapon = "ak74u";
  character\character_sp_zakhaev::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_sp_zakhaev::precache();
  precacheitem("ak74u");
  precacheitem("beretta");
  precacheitem("beretta");
  precacheitem("fraggrenade");
}