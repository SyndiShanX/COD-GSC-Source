/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_us_army_mp5.gsc
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

  self.weapon = "mp5";

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character\character_us_army_smg::main();
      break;
    case 1:
      character\character_us_army_smg_b::main();
      break;
    case 2:
      character\character_us_army_smg_c::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_us_army_smg::precache();
  character\character_us_army_smg_b::precache();
  character\character_us_army_smg_c::precache();

  precacheItem("mp5");
  precacheItem("beretta");
  precacheItem("fraggrenade");
}