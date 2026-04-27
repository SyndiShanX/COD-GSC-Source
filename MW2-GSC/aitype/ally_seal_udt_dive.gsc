/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_seal_udt_dive.gsc
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
  self.grenadeWeapon = "flash_grenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  self.weapon = "m4_silencer";

  character\character_seal_udt_dive_a::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_seal_udt_dive_a::precache();

  precacheItem("m4_silencer");
  precacheItem("beretta");
  precacheItem("flash_grenade");
}