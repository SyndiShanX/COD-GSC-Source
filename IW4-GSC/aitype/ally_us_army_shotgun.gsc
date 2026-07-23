/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_us_army_shotgun.gsc
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

  switch (codescripts\character::get_random_weapon(3)) {
    case 0:
      self.weapon = "m1014";
      break;
    case 1:
      self.weapon = "m1014_reflex";
      break;
    case 2:
      self.weapon = "m1014_eotech";
      break;
  }

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character\character_us_army_shotgun::main();
      break;
    case 1:
      character\character_us_army_shotgun_b::main();
      break;
    case 2:
      character\character_us_army_shotgun_c::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_us_army_shotgun::precache();
  character\character_us_army_shotgun_b::precache();
  character\character_us_army_shotgun_c::precache();

  precacheItem("m1014");
  precacheItem("m1014_reflex");
  precacheItem("m1014_eotech");
  precacheItem("beretta");
  precacheItem("fraggrenade");
}