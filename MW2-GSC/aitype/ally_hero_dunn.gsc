/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_hero_dunn.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.secondaryweapon = "";
  self.sidearm = "beretta";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  self.weapon = "scar_h_thermal";

  character\character_hero_us_army_dunn::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_hero_us_army_dunn::precache();

  precacheItem("scar_h_thermal");
  precacheItem("beretta");
  precacheItem("fraggrenade");
}