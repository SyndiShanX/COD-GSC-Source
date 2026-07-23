/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: aitype\civilian_worker_male_bomb.gsc
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

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character\character_civilian_worker_bomb_a::main();
      break;
    case 1:
      character\character_civilian_worker_bomb_b::main();
      break;
    case 2:
      character\character_civilian_worker_bomb_c::main();
      break;
  }
}

spawner() {
  self setspawnerteam("neutral");
}

precache() {
  character\character_civilian_worker_bomb_a::precache();
  character\character_civilian_worker_bomb_b::precache();
  character\character_civilian_worker_bomb_c::precache();
}