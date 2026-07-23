/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_airport_comrad_shotgun.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 3600;
  self.secondaryweapon = "beretta";
  self.sidearm = "beretta";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 4;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  self.weapon = "striker";

  character\character_airport_c::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_airport_c::precache();

  precacheItem("striker");
  precacheItem("beretta");
  precacheItem("beretta");
  precacheItem("fraggrenade");
}