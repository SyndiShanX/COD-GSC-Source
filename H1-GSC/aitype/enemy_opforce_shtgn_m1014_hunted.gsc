/*******************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\enemy_opforce_shtgn_m1014_hunted.gsc
*******************************************************/

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
    self setengagementmaxdist(280.0, 400.0);
  }

  self.weapon = "m1014";

  switch (codescripts\character::get_random_character(4)) {
    case 0:
      character\character_sp_opforce_b::main();
      break;
    case 1:
      character\character_sp_opforce_c::main();
      break;
    case 2:
      character\character_sp_opforce_e::main();
      break;
    case 3:
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
  character\character_sp_opforce_e::precache();
  character\character_sp_opforce_derik::precache();
  precacheitem("m1014");
  precacheitem("beretta");
  precacheitem("beretta");
  precacheitem("fraggrenade");
}