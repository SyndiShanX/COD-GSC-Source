/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_tf_141_desert_at4.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.secondaryweapon = "m4_grenadier";
  self.sidearm = "beretta";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  self.weapon = "at4";

  character\character_tf_141_desert_lmg::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_tf_141_desert_lmg::precache();

  precacheItem("at4");
  precacheItem("m4_grenadier");
  precacheItem("m203_m4");
  precacheItem("beretta");
  precacheItem("fraggrenade");
}