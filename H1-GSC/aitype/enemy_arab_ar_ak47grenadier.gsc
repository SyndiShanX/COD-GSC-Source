/**************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\enemy_arab_ar_ak47grenadier.gsc
**************************************************/

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

  self.weapon = "ak47_grenadier";

  switch (codescripts\character::get_random_character(6)) {
    case 0:
      character\character_sp_arab_regular_asad::main();
      break;
    case 1:
      character\character_sp_arab_regular_sadiq::main();
      break;
    case 2:
      character\character_sp_arab_regular_ski_mask::main();
      break;
    case 3:
      character\character_sp_arab_regular_ski_mask2::main();
      break;
    case 4:
      character\character_sp_arab_regular_suren::main();
      break;
    case 5:
      character\character_sp_arab_regular_yasir::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_sp_arab_regular_asad::precache();
  character\character_sp_arab_regular_sadiq::precache();
  character\character_sp_arab_regular_ski_mask::precache();
  character\character_sp_arab_regular_ski_mask2::precache();
  character\character_sp_arab_regular_suren::precache();
  character\character_sp_arab_regular_yasir::precache();
  precacheitem("ak47_grenadier");
  precacheitem("gp25");
  precacheitem("beretta");
  precacheitem("beretta");
  precacheitem("fraggrenade");
}