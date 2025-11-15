/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\civilian_us_civ_male_lite.gsc
************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "neutral";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 30;
  self.grenadeweapon = "";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self.sidearm = "";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "none";

  switch (codescripts\character::get_random_character(4)) {
    case 0:
      character\character_us_civ_male_yb_a::main();
      break;
    case 1:
      character\character_us_civ_male_yb_b::main();
      break;
    case 2:
      character\character_us_civ_male_yb_c::main();
      break;
    case 3:
      character\character_us_civ_male_yb_d::main();
      break;
  }
}

spawner() {
  self setspawnerteam("neutral");
}

precache() {
  character\character_us_civ_male_yb_a::precache();
  character\character_us_civ_male_yb_b::precache();
  character\character_us_civ_male_yb_c::precache();
  character\character_us_civ_male_yb_d::precache();
}