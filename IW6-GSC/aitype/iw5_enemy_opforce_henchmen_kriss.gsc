/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\iw5_enemy_opforce_henchmen_kriss.gsc
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
  self.secondaryweapon = "";
  self.sidearm = "glock";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "kriss";

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character\character_opforce_henchmen_smg_a::main();
      break;
    case 1:
      character\character_opforce_henchmen_smg_b::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_opforce_henchmen_smg_a::precache();
  character\character_opforce_henchmen_smg_b::precache();
  precacheitem("kriss");
  precacheitem("glock");
  precacheitem("fraggrenade");
}