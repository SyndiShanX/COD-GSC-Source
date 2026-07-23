/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_afghan_unarmed.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "neutral";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "glock";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  self.weapon = "ak47_desert";

  character\character_opforce_arab_unarmed_a::main();
}

spawner() {
  self setspawnerteam("neutral");
}

precache() {
  character\character_opforce_arab_unarmed_a::precache();

  precacheItem("ak47_desert");
  precacheItem("glock");
  precacheItem("fraggrenade");
}