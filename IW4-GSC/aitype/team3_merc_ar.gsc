/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\team3_merc_ar.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "team3";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "pp2000";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  switch (codescripts\character::get_random_weapon(9)) {
    case 0:
      self.weapon = "tavor_woodland_acog";
      break;
    case 1:
      self.weapon = "tavor_mars";
      break;
    case 2:
      self.weapon = "tavor_woodland_eotech";
      break;
    case 3:
      self.weapon = "tavor_reflex";
      break;
    case 4:
      self.weapon = "fn2000";
      break;
    case 5:
      self.weapon = "fn2000_acog";
      break;
    case 6:
      self.weapon = "fn2000_eotech";
      break;
    case 7:
      self.weapon = "fn2000_reflex";
      break;
    case 8:
      self.weapon = "fn2000_thermal";
      break;
  }

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character\character_opforce_merc_assault_a::main();
      break;
    case 1:
      character\character_opforce_merc_assault_b::main();
      break;
    case 2:
      character\character_opforce_merc_assault_c::main();
      break;
  }
}

spawner() {
  self setspawnerteam("team3");
}

precache() {
  character\character_opforce_merc_assault_a::precache();
  character\character_opforce_merc_assault_b::precache();
  character\character_opforce_merc_assault_c::precache();

  precacheItem("tavor_woodland_acog");
  precacheItem("tavor_mars");
  precacheItem("tavor_woodland_eotech");
  precacheItem("tavor_reflex");
  precacheItem("fn2000");
  precacheItem("fn2000_acog");
  precacheItem("fn2000_eotech");
  precacheItem("fn2000_reflex");
  precacheItem("fn2000_thermal");
  precacheItem("pp2000");
  precacheItem("fraggrenade");
}