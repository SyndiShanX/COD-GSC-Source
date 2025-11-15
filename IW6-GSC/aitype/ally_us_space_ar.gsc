/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_us_space_ar.gsc
***************************************/

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
  self.secondaryweapon = "";
  self.sidearm = "";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  switch (codescripts\character::get_random_weapon(2)) {
    case 0:
      self.weapon = "arx160_space";
      break;
    case 1:
      self.weapon = "arx160_space+acog_sp";
      break;
  }

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character\character_us_space_assault_a::main();
      break;
    case 1:
      character\character_us_space_assault_b::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_us_space_assault_a::precache();
  character\character_us_space_assault_b::precache();
  precacheitem("arx160_space");
  precacheitem("arx160_space+acog_sp");
  precacheitem("fraggrenade");
}