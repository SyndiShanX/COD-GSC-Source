/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_socom_shotgun.gsc
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
  self.sidearm = "glock";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  switch (codescripts\character::get_random_weapon(2)) {
    case 0:
      self.weapon = "spas12";
      break;
    case 1:
      self.weapon = "spas12_reflex";
      break;
  }

  character\character_seal_soccom_assault_c_blk::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_seal_soccom_assault_c_blk::precache();

  precacheItem("spas12");
  precacheItem("spas12_reflex");
  precacheItem("glock");
  precacheItem("fraggrenade");
}