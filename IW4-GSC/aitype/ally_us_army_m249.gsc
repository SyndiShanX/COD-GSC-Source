/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_us_army_m249.gsc
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
      self.weapon = "m240";
      break;
    case 1:
      self.weapon = "m240_acog";
      break;
    case 2:
      self.weapon = "m240_reflex";
      break;
  }

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character\character_us_army_lmg::main();
      break;
    case 1:
      character\character_us_army_lmg_b::main();
      break;
    case 2:
      character\character_us_army_lmg_c::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_us_army_lmg::precache();
  character\character_us_army_lmg_b::precache();
  character\character_us_army_lmg_c::precache();

  precacheItem("m240");
  precacheItem("m240_acog");
  precacheItem("m240_reflex");
  precacheItem("beretta");
  precacheItem("fraggrenade");
}