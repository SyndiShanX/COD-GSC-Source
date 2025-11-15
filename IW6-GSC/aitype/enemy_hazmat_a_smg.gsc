/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_hazmat_a_smg.gsc
*****************************************/

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
  self.secondaryweapon = "";
  self.sidearm = "p226";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "pp19";
  character\character_hazmat_a::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_hazmat_a::precache();
  precacheitem("pp19");
  precacheitem("p226");
  precacheitem("fraggrenade");
}