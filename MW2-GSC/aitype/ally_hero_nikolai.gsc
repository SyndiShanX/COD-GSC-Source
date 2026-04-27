/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_hero_nikolai.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "beretta";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  self.weapon = "masada_acog";

  character\character_hero_nikolai::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_hero_nikolai::precache();

  precacheItem("masada_acog");
  precacheItem("beretta");
  precacheItem("fraggrenade");
}