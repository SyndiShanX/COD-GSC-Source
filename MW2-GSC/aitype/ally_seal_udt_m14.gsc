/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_seal_udt_m14.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "beretta";
  self.grenadeWeapon = "fraggrenade";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  self.weapon = "m14_scoped";

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character\character_seal_udt_assault_a::main();
      break;
    case 1:
      character\character_seal_udt_smg::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_seal_udt_assault_a::precache();
  character\character_seal_udt_smg::precache();

  precacheItem("m14_scoped");
  precacheItem("beretta");
  precacheItem("fraggrenade");
}