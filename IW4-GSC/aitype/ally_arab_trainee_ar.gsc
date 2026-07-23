/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_arab_trainee_ar.gsc
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
      self.weapon = "m16_basic";
      break;
    case 1:
      self.weapon = "m16_acog";
      break;
    case 2:
      self.weapon = "m4_grunt";
      break;
  }

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character\character_trn_arab_a::main();
      break;
    case 1:
      character\character_trn_arab_b::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_trn_arab_a::precache();
  character\character_trn_arab_b::precache();

  precacheItem("m16_basic");
  precacheItem("m16_acog");
  precacheItem("m4_grunt");
  precacheItem("beretta");
  precacheItem("fraggrenade");
}