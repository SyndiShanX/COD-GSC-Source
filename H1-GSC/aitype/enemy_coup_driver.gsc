/****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\enemy_coup_driver.gsc
****************************************/

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

  self.weapon = "ak47";
  character\character_sp_arab_regular_coup_b::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_sp_arab_regular_coup_b::precache();
  precacheitem("ak47");
  precacheitem("beretta");
  precacheitem("beretta");
  precacheitem("fraggrenade");
}