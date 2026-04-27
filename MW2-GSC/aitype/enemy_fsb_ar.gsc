/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\enemy_fsb_ar.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "riotshield.csv";
  self.team = "axis";
  self.type = "human";
  self.subclass = "elite";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "usp";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  switch (codescripts\character::get_random_weapon(6)) {
    case 0:
      self.weapon = "tavor_acog";
      break;
    case 1:
      self.weapon = "tavor_mars";
      break;
    case 2:
      self.weapon = "fn2000";
      break;
    case 3:
      self.weapon = "fn2000_acog";
      break;
    case 4:
      self.weapon = "fn2000_reflex";
      break;
    case 5:
      self.weapon = "fn2000_scope";
      break;
  }

  character\character_opforce_fsb_assault_a::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_opforce_fsb_assault_a::precache();

  precacheItem("tavor_acog");
  precacheItem("tavor_mars");
  precacheItem("fn2000");
  precacheItem("fn2000_acog");
  precacheItem("fn2000_reflex");
  precacheItem("fn2000_scope");
  precacheItem("usp");
  precacheItem("fraggrenade");
}