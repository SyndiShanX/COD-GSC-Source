/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_hero_price_arctic.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.secondaryweapon = "at4";
  self.sidearm = "usp_silencer";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  self.weapon = "m21_scoped_arctic_silenced";

  character\character_hero_arctic_price::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_hero_arctic_price::precache();

  precacheItem("m21_scoped_arctic_silenced");
  precacheItem("at4");
  precacheItem("usp_silencer");
  precacheItem("fraggrenade");
}