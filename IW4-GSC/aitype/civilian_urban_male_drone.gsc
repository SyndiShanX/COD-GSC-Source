/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\civilian_urban_male_drone.gsc
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
      character\character_civilian_urban_male_aa_drone::main();
      break;
    case 1:
      character\character_civilian_urban_male_ab_drone::main();
      break;
    case 2:
      character\character_civilian_urban_male_ac_drone::main();
      break;
    case 3:
      character\character_city_civ_male_a_drone::main();
      break;
    case 4:
      character\character_civilian_urban_male_ba_drone::main();
      break;
    case 5:
      character\character_civilian_urban_male_bb_drone::main();
      break;
    case 6:
      character\character_civilian_urban_male_bc_drone::main();
      break;
  }
}

spawner() {
  self setspawnerteam("neutral");
}

precache() {
  character\character_civilian_urban_male_aa_drone::precache();
  character\character_civilian_urban_male_ab_drone::precache();
  character\character_civilian_urban_male_ac_drone::precache();
  character\character_city_civ_male_a_drone::precache();
  character\character_civilian_urban_male_ba_drone::precache();
  character\character_civilian_urban_male_bb_drone::precache();
  character\character_civilian_urban_male_bc_drone::precache();
}