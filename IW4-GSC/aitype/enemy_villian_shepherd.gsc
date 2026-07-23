/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_villian_shepherd.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "elite";
  self.accuracy = 0.12;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "coltanaconda";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(512.000000, 1024.000000);
  }

  self.weapon = "coltanaconda_shepherd";

  character\character_vil_shepherd::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_vil_shepherd::precache();

  precacheItem("coltanaconda_shepherd");
  precacheItem("coltanaconda");
  precacheItem("fraggrenade");
}