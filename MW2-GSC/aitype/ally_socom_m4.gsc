/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_socom_m4.gsc
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
      self.weapon = "m4_grenadier";
      break;
    case 1:
      self.weapon = "m4_grunt";
      break;
  }

  character\character_seal_soccom_assault_c::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_seal_soccom_assault_c::precache();

  precacheItem("m4_grenadier");
  precacheItem("m203_m4");
  precacheItem("m4_grunt");
  precacheItem("glock");
  precacheItem("fraggrenade");
}