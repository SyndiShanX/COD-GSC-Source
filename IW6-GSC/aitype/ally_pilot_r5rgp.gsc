/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_pilot_r5rgp.gsc
***************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self.sidearm = "m9a1";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  switch (codescripts\character::get_random_weapon(4)) {
    case 0:
      self.weapon = "r5rgp";
      break;
    case 1:
      self.weapon = "r5rgp+acog_sp";
      break;
    case 2:
      self.weapon = "r5rgp+eotech_sp";
      break;
    case 3:
      self.weapon = "r5rgp+reflex_sp";
      break;
  }

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character\character_pilot_a::main();
      break;
    case 1:
      character\character_pilot_b::main();
      break;
    case 2:
      character\character_pilot_b_tan::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_pilot_a::precache();
  character\character_pilot_b::precache();
  character\character_pilot_b_tan::precache();
  precacheitem("r5rgp");
  precacheitem("r5rgp+acog_sp");
  precacheitem("r5rgp+eotech_sp");
  precacheitem("r5rgp+reflex_sp");
  precacheitem("m9a1");
  precacheitem("fraggrenade");
}