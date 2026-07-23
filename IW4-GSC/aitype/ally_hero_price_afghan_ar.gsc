/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_hero_price_afghan_ar.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.secondaryweapon = "usp_silencer";
  self.sidearm = "usp_silencer";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  self.weapon = "m4_grenadier";

  character\character_hero_desert_price::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_hero_desert_price::precache();

  precacheItem("m4_grenadier");
  precacheItem("m203_m4");
  precacheItem("usp_silencer");
  precacheItem("usp_silencer");
  precacheItem("fraggrenade");
}