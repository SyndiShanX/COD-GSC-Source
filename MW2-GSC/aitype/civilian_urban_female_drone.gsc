/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\civilian_urban_female_drone.gsc
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

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character\character_civilian_urban_fem_a_drone::main();
      break;
    case 1:
      character\character_civilian_urban_fem_b_drone::main();
      break;
  }
}

spawner() {
  self setspawnerteam("neutral");
}

precache() {
  character\character_civilian_urban_fem_a_drone::precache();
  character\character_civilian_urban_fem_b_drone::precache();
}