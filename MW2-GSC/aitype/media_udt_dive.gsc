/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\media_udt_dive.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "neutral";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.secondaryweapon = "fraggrenade";
  self.sidearm = "glock";
  self.grenadeWeapon = "";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  self.weapon = "beretta";

  character\character_media_udt_dive::main();
}

spawner() {
  self setspawnerteam("neutral");
}

precache() {
  character\character_media_udt_dive::precache();

  precacheItem("beretta");
  precacheItem("fraggrenade");
  precacheItem("glock");
}