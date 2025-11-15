/***************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\enemy_arab_ar_ak47_h1_lowrez.gsc
***************************************************/

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
    self setengagementmindist(128.0, 0.0);
    self setengagementmaxdist(512.0, 1024.0);
  }

  self.weapon = "ak47";

  switch (codescripts\character::get_random_character(6)) {
    case 0:
      character\character_sp_arab_regular_asad_lowrez::main();
      break;
    case 1:
      character\character_sp_arab_regular_sadiq_lowrez::main();
      break;
    case 2:
      character\character_sp_arab_regular_ski_mask_low::main();
      break;
    case 3:
      character\character_sp_arab_regular_ski_mask2_lw::main();
      break;
    case 4:
      character\character_sp_arab_regular_suren_lowrez::main();
      break;
    case 5:
      character\character_sp_arab_regular_yasir_lowrez::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_sp_arab_regular_asad_lowrez::precache();
  character\character_sp_arab_regular_sadiq_lowrez::precache();
  character\character_sp_arab_regular_ski_mask_low::precache();
  character\character_sp_arab_regular_ski_mask2_lw::precache();
  character\character_sp_arab_regular_suren_lowrez::precache();
  character\character_sp_arab_regular_yasir_lowrez::precache();
  precacheitem("ak47");
  precacheitem("beretta");
  precacheitem("beretta");
  precacheitem("fraggrenade");
}