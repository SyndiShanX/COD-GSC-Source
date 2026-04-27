/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_arctic_welder.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "usp";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(128.000000, 0.000000);
    self setEngagementMaxDist(512.000000, 1024.000000);
  }

  self.weapon = "ak47_arctic";

  character\character_civilian_worker_welder::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_civilian_worker_welder::precache();

  precacheItem("ak47_arctic");
  precacheItem("usp");
  precacheItem("fraggrenade");
}