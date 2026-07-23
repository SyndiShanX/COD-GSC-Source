/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\civilian_urban_male.gsc
********************************************************/

main() {
  self.animTree = "";
  self.additionalAssets = "";
  self.team = "neutral";
  self.type = "civilian";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 30;
  self.secondaryweapon = "";
  self.sidearm = "";
  self.grenadeWeapon = "";
  self.grenadeAmmo = 0;

  if(isAI(self)) {
    self setEngagementMinDist(256.000000, 0.000000);
    self setEngagementMaxDist(768.000000, 1024.000000);
  }

  self.weapon = "none";

  switch (codescripts\character::get_random_character(7)) {
    case 0:
      character\character_civilian_urban_male_aa_wht::main();
      break;
    case 1:
      character\character_civilian_urban_male_ab_wht::main();
      break;
    case 2:
      character\character_civilian_urban_male_ac_wht::main();
      break;
    case 3:
      character\character_city_civ_male_a::main();
      break;
    case 4:
      character\character_civilian_urban_male_ba_wht::main();
      break;
    case 5:
      character\character_civilian_urban_male_bb_wht::main();
      break;
    case 6:
      character\character_civilian_urban_male_bc_wht::main();
      break;
  }
}

spawner() {
  self setspawnerteam("neutral");
}

precache() {
  character\character_civilian_urban_male_aa_wht::precache();
  character\character_civilian_urban_male_ab_wht::precache();
  character\character_civilian_urban_male_ac_wht::precache();
  character\character_city_civ_male_a::precache();
  character\character_civilian_urban_male_ba_wht::precache();
  character\character_civilian_urban_male_bb_wht::precache();
  character\character_civilian_urban_male_bc_wht::precache();
}