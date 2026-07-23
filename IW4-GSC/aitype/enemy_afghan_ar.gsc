/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_afghan_ar.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "glock";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  switch (codescripts\character::get_random_weapon(8)) {
    case 0:
      self.weapon = "ak47_desert";
      break;
    case 1:
      self.weapon = "ak47_reflex";
      break;
    case 2:
      self.weapon = "ak47_desert_grenadier";
      break;
    case 3:
      self.weapon = "ak47_acog";
      break;
    case 4:
      self.weapon = "fal";
      break;
    case 5:
      self.weapon = "fal_acog";
      break;
    case 6:
      self.weapon = "ak47_desert";
      break;
    case 7:
      self.weapon = "fal_shotgun";
      break;
  }

  character\character_opforce_arab_assault_a::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_opforce_arab_assault_a::precache();

  precacheItem("ak47_desert");
  precacheItem("ak47_reflex");
  precacheItem("ak47_desert_grenadier");
  precacheItem("gl_ak47_desert");
  precacheItem("ak47_acog");
  precacheItem("fal");
  precacheItem("fal_acog");
  precacheItem("ak47_desert");
  precacheItem("fal_shotgun");
  precacheItem("fal_shotgun_attach");
  precacheItem("glock");
  precacheItem("fraggrenade");
}