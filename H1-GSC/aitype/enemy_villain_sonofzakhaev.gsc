/*************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\enemy_villain_sonofzakhaev.gsc
*************************************************/

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
  self.secondaryweapon = "colt45";
  self.sidearm = "colt45";

  if(isai(self)) {
    self setengagementmindist(128.0, 0.0);
    self setengagementmaxdist(512.0, 1024.0);
  }

  self.weapon = "uzi_sd";
  character\character_sp_zakhaevs_son::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_sp_zakhaevs_son::precache();
  precacheitem("uzi_sd");
  precacheitem("colt45");
  precacheitem("colt45");
  precacheitem("fraggrenade");
}