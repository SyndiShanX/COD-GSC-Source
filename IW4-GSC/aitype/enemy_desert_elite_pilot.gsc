/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_desert_elite_pilot.gsc
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

  switch (codescripts\character::get_random_weapon(7)) {
    case 0:
      self.weapon = "kriss";
      break;
    case 1:
      self.weapon = "kriss_reflex";
      break;
    case 2:
      self.weapon = "ump45_acog";
      break;
    case 3:
      self.weapon = "ump45_eotech";
      break;
    case 4:
      self.weapon = "ump45_reflex";
      break;
    case 5:
      self.weapon = "tmp";
      break;
    case 6:
      self.weapon = "tmp_reflex";
      break;
  }

  character\character_flightsuit_black::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_flightsuit_black::precache();

  precacheItem("kriss");
  precacheItem("kriss_reflex");
  precacheItem("ump45_acog");
  precacheItem("ump45_eotech");
  precacheItem("ump45_reflex");
  precacheItem("tmp");
  precacheItem("tmp_reflex");
  precacheItem("glock");
  precacheItem("fraggrenade");
}