/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_hero_shepherd.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "elite";
  self.accuracy = 0.12;
  self.health = 150;
  self.secondaryweapon = "coltanaconda";
  self.sidearm = "coltanaconda";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(512.000000, 1024.000000);
  }

  self.weapon = "m4_grunt";

  character\character_vil_shepherd::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_vil_shepherd::precache();

  precacheItem("m4_grunt");
  precacheItem("coltanaconda");
  precacheItem("coltanaconda");
  precacheItem("fraggrenade");
}