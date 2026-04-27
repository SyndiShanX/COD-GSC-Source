/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_pilot_zach_desert.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 149;
  self.secondaryweapon = "beretta";
  self.sidearm = "beretta";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  self.weapon = "none";

  character\character_sp_pilot_zack_desert::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_sp_pilot_zack_desert::precache();

  precacheItem("beretta");
  precacheItem("beretta");
  precacheItem("fraggrenade");
}