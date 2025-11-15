/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_fed_udt_smg.gsc
****************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self.sidearm = "p226";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "aps_underwater";
  character\character_fed_udt_assault_a::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_fed_udt_assault_a::precache();
  precacheitem("aps_underwater");
  precacheitem("p226");
  precacheitem("fraggrenade");
}