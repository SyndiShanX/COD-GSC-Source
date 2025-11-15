/*********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\ally_sas_woodland_ar_m4_light_gear.gsc
*********************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "usp";
  self.sidearm = "usp";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "m16_basic";

  switch (codescripts\character::get_random_character(12)) {
    case 0:
      character\character_sp_sas_woodland_colon_a::main();
      break;
    case 1:
      character\character_sp_sas_woodland_colon_b::main();
      break;
    case 2:
      character\character_sp_sas_woodland_colon_c::main();
      break;
    case 3:
      character\character_sp_sas_woodland_colon_d::main();
      break;
    case 4:
      character\character_sp_sas_woodland_colon_e::main();
      break;
    case 5:
      character\character_sp_sas_woodland_colon_f::main();
      break;
    case 6:
      character\character_sp_sas_woodland_golden_a::main();
      break;
    case 7:
      character\character_sp_sas_woodland_golden_b::main();
      break;
    case 8:
      character\character_sp_sas_woodland_golden_c::main();
      break;
    case 9:
      character\character_sp_sas_woodland_golden_d::main();
      break;
    case 10:
      character\character_sp_sas_woodland_golden_e::main();
      break;
    case 11:
      character\character_sp_sas_woodland_golden_f::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_sp_sas_woodland_colon_a::precache();
  character\character_sp_sas_woodland_colon_b::precache();
  character\character_sp_sas_woodland_colon_c::precache();
  character\character_sp_sas_woodland_colon_d::precache();
  character\character_sp_sas_woodland_colon_e::precache();
  character\character_sp_sas_woodland_colon_f::precache();
  character\character_sp_sas_woodland_golden_a::precache();
  character\character_sp_sas_woodland_golden_b::precache();
  character\character_sp_sas_woodland_golden_c::precache();
  character\character_sp_sas_woodland_golden_d::precache();
  character\character_sp_sas_woodland_golden_e::precache();
  character\character_sp_sas_woodland_golden_f::precache();
  precacheitem("m16_basic");
  precacheitem("usp");
  precacheitem("usp");
  precacheitem("fraggrenade");
}