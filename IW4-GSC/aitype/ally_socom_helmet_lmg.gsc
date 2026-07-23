/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_socom_helmet_lmg.gsc
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

  self.weapon = "mg4";

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character\character_seal_soccom_h_assault_c::main();
      break;
    case 1:
      character\character_seal_soccom_h_assault_c_blk::main();
      break;
    case 2:
      character\character_seal_soccom_h_assault_d::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_seal_soccom_h_assault_c::precache();
  character\character_seal_soccom_h_assault_c_blk::precache();
  character\character_seal_soccom_h_assault_d::precache();

  precacheItem("mg4");
  precacheItem("beretta");
  precacheItem("fraggrenade");
}