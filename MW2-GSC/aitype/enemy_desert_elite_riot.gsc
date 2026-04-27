/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_desert_elite_riot.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "riotshield.csv";
  self.team = "axis";
  self.type = "human";
  self.subclass = "riotshield";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "riotshield";
  self.sidearm = "usp";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  self.weapon = "mp5";

  character\character_shadow_co_riot::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
    character\character_shadow_co_riot::precache();

    precacheItem("mp5");
    precacheItem("riotshield");
    precacheItem("usp");
    precacheItem("fraggrenade");