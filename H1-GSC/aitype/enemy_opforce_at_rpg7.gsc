/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\enemy_opforce_at_rpg7.gsc
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
  self.secondaryweapon = "ak47";
  self.sidearm = "beretta";

  if(isai(self)) {
    self setengagementmindist(768.0, 512.0);
    self setengagementmaxdist(1024.0, 1500.0);
  }

  self.weapon = "rpg";
  character\character_sp_opforce_a::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_sp_opforce_a::precache();
  precacheitem("rpg");
  precacheitem("ak47");
  precacheitem("beretta");
  precacheitem("fraggrenade");
}