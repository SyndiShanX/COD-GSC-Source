/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_desert_elite_shgn.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "axis";
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
      self.weapon = "spas12";
      break;
    case 1:
      self.weapon = "m1014";
      break;
    case 2:
      self.weapon = "aa12_reflex";
      break;
  }

  character\character_shadow_co_shotgun::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_shadow_co_shotgun::precache();

  precacheItem("spas12");
  precacheItem("m1014");
  precacheItem("aa12_reflex");
  precacheItem("beretta");
  precacheItem("fraggrenade");
}