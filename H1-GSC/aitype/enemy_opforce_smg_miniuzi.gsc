/************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\enemy_opforce_smg_miniuzi.gsc
************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "beretta";
  self.sidearm = "beretta";

  if(isai(self)) {
    self setengagementmindist(0.0, 0.0);
    self setengagementmaxdist(256.0, 512.0);
  }

  self.weapon = "uzi";

  switch (codescripts\character::get_random_character(8)) {
    case 0:
      character\character_sp_opforce_b::main();
      break;
    case 1:
      character\character_sp_opforce_c::main();
      break;
    case 2:
      character\character_sp_opforce_d::main();
      break;
    case 3:
      character\character_sp_opforce_e::main();
      break;
    case 4:
      character\character_sp_opforce_f::main();
      break;
    case 5:
      character\character_sp_opforce_collins::main();
      break;
    case 6:
      character\character_sp_opforce_geoff::main();
      break;
    case 7:
      character\character_sp_opforce_derik::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_sp_opforce_b::precache();
  character\character_sp_opforce_c::precache();
  character\character_sp_opforce_d::precache();
  character\character_sp_opforce_e::precache();
  character\character_sp_opforce_f::precache();
  character\character_sp_opforce_collins::precache();
  character\character_sp_opforce_geoff::precache();
  character\character_sp_opforce_derik::precache();
  precacheitem("uzi");
  precacheitem("beretta");
  precacheitem("beretta");
  precacheitem("fraggrenade");
}