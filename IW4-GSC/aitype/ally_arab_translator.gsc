/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_arab_translator.gsc
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

  switch (codescripts\character::get_random_weapon(12)) {
    case 0:
      self.weapon = "m16_basic";
      break;
    case 1:
      self.weapon = "m240";
      break;
    case 2:
      self.weapon = "m16_grenadier";
      break;
    case 3:
      self.weapon = "m240_reflex";
      break;
    case 4:
      self.weapon = "m16_acog";
      break;
    case 5:
      self.weapon = "m240_acog";
      break;
    case 6:
      self.weapon = "m4_grenadier";
      break;
    case 7:
      self.weapon = "scar_h_acog";
      break;
    case 8:
      self.weapon = "m4_grunt";
      break;
    case 9:
      self.weapon = "scar_h_shotgun";
      break;
    case 10:
      self.weapon = "scar_h_reflex";
      break;
    case 11:
      self.weapon = "scar_h_grenadier";
      break;
  }

  character\character_trn_arab_b::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_trn_arab_b::precache();

  precacheItem("m16_basic");
  precacheItem("m240");
  precacheItem("m16_grenadier");
  precacheItem("m203");
  precacheItem("m240_reflex");
  precacheItem("m16_acog");
  precacheItem("m240_acog");
  precacheItem("m4_grenadier");
  precacheItem("m203_m4");
  precacheItem("scar_h_acog");
  precacheItem("m4_grunt");
  precacheItem("scar_h_shotgun");
  precacheItem("scar_h_shotgun_attach");
  precacheItem("scar_h_reflex");
  precacheItem("scar_h_grenadier");
  precacheItem("scar_h_m203");
  precacheItem("beretta");
  precacheItem("fraggrenade");
}