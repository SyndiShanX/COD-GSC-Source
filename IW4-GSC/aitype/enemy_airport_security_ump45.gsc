/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_airport_security_ump45.gsc
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
  self.sidearm = "beretta";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(128.000000, 0.000000);
    self setEngagementMaxDist(512.000000, 768.000000);
  }

  switch (codescripts\character::get_random_weapon(4)) {
    case 0:
      self.weapon = "ump45";
      break;
    case 1:
      self.weapon = "ump45_acog";
      break;
    case 2:
      self.weapon = "ump45_reflex";
      break;
    case 3:
      self.weapon = "ump45_eotech";
      break;
  }

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character\character_secret_service_shotgun::main();
      break;
    case 1:
      character\character_secret_service_smg::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_secret_service_shotgun::precache();
  character\character_secret_service_smg::precache();

  precacheItem("ump45");
  precacheItem("ump45_acog");
  precacheItem("ump45_reflex");
  precacheItem("ump45_eotech");
  precacheItem("beretta");
  precacheItem("fraggrenade");
}