/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_airborne_drone.gsc
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
  self.sidearm = "pp2000";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  self.weapon = "ak47";

  character\character_airborne_assault_a_drone::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_airborne_assault_a_drone::precache();

  precacheItem("ak47");
  precacheItem("pp2000");
  precacheItem("fraggrenade");
}