/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\mod_gal_us_army_riotshield.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "riotshield.csv";
  self.team = "neutral";
  self.type = "human";
  self.subclass = "riotshield";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "riotshield";
  self.sidearm = "usp";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  switch (codescripts\character::get_random_weapon(2)) {
    case 0:
      self.weapon = "mp5";
      break;
    case 1:
      self.weapon = "mp5_reflex";
      break;
  }

  character\character_us_army_riot::main();
}

spawner() {
  self setspawnerteam("neutral");
}

precache() {
    character\character_us_army_riot::precache();

    precacheItem("mp5");
    precacheItem("mp5_reflex");
    precacheItem("riotshield");
    precacheItem("usp");
    precacheItem("fraggrenade");