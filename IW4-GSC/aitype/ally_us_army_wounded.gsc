/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\ally_us_army_wounded.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.secondaryweapon = "beretta";
  self.sidearm = "";
  self.grenadeWeapon = "";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  self.weapon = "m4_grunt";

  switch (codescripts\character::get_random_character(6)) {
    case 0:
      character\character_us_army_dmg_a_blk::main();
      break;
    case 1:
      character\character_us_army_dmg_a_wht::main();
      break;
    case 2:
      character\character_us_army_dmg_b_blk::main();
      break;
    case 3:
      character\character_us_army_dmg_b_wht::main();
      break;
    case 4:
      character\character_us_army_dmg_c_blk::main();
      break;
    case 5:
      character\character_us_army_dmg_c_wht::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_us_army_dmg_a_blk::precache();
  character\character_us_army_dmg_a_wht::precache();
  character\character_us_army_dmg_b_blk::precache();
  character\character_us_army_dmg_b_wht::precache();
  character\character_us_army_dmg_c_blk::precache();
  character\character_us_army_dmg_c_wht::precache();

  precacheItem("m4_grunt");
  precacheItem("beretta");
}