/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_us_space_int_no_weapon.gsc
**************************************************/

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
  self.secondaryweapon = "";
  self.sidearm = "";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "none";

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character\character_us_space_int_a::main();
      break;
    case 1:
      character\character_us_space_int_b::main();
      break;
    case 2:
      character\character_us_space_int_c::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_us_space_int_a::precache();
  character\character_us_space_int_b::precache();
  character\character_us_space_int_c::precache();
}