/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\enemy_opforce_ar_g36c.gsc
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

  self.weapon = "g36c";
  character\character_sp_opforce_f::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_sp_opforce_f::precache();
  precacheitem("g36c");
  precacheitem("beretta");
  precacheitem("beretta");
  precacheitem("fraggrenade");
}