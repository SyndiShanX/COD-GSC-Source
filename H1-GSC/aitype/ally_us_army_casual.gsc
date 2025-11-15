/******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\ally_us_army_casual.gsc
******************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.grenadeweapon = "";
  self.grenadeammo = 0;
  self.secondaryweapon = "beretta";
  self.sidearm = "";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "m4_grunt";

  switch (codescripts\character::get_random_character(8)) {
    case 0:
      character\character_sp_sas_woodland_soldier2_a::main();
      break;
    case 1:
      character\character_sp_sas_woodland_soldier2_b::main();
      break;
    case 2:
      character\character_sp_sas_woodland_soldier2_c::main();
      break;
    case 3:
      character\character_sp_sas_woodland_soldier2_d::main();
      break;
    case 4:
      character\character_sp_sas_woodland_soldier2_e::main();
      break;
    case 5:
      character\character_sp_sas_woodland_soldier2_f::main();
      break;
    case 6:
      character\character_sp_sas_woodland_afro_01::main();
      break;
    case 7:
      character\character_sp_sas_woodland_afro_02::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_sp_sas_woodland_soldier2_a::precache();
  character\character_sp_sas_woodland_soldier2_b::precache();
  character\character_sp_sas_woodland_soldier2_c::precache();
  character\character_sp_sas_woodland_soldier2_d::precache();
  character\character_sp_sas_woodland_soldier2_e::precache();
  character\character_sp_sas_woodland_soldier2_f::precache();
  character\character_sp_sas_woodland_afro_01::precache();
  character\character_sp_sas_woodland_afro_02::precache();
  precacheitem("m4_grunt");
  precacheitem("beretta");
}