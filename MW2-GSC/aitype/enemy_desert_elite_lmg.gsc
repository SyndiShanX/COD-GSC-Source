/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_desert_elite_lmg.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 200;
  self.secondaryweapon = "";
  self.sidearm = "glock";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(128.000000, 0.000000);
    self setEngagementMaxDist(512.000000, 1024.000000);
  }

  switch (codescripts\character::get_random_weapon(3)) {
    case 0:
      self.weapon = "m240";
      break;
    case 1:
      self.weapon = "m240_acog";
      break;
    case 2:
      self.weapon = "m240_reflex";
      break;
  }

  character\character_shadow_co_lmg::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_shadow_co_lmg::precache();

  precacheItem("m240");
  precacheItem("m240_acog");
  precacheItem("m240_reflex");
  precacheItem("glock");
  precacheItem("fraggrenade");
}