/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_desert_elite_rpg.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 200;
  self.secondaryweapon = "masada";
  self.sidearm = "glock";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(128.000000, 0.000000);
    self setEngagementMaxDist(512.000000, 1024.000000);
  }

  self.weapon = "at4";

  character\character_shadow_co_lmg::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_shadow_co_lmg::precache();

  precacheItem("at4");
  precacheItem("masada");
  precacheItem("glock");
  precacheItem("fraggrenade");
}