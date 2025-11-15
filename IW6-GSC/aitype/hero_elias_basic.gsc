/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\hero_elias_basic.gsc
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

  switch (codescripts\character::get_random_weapon(2)) {
    case 0:
      self.weapon = "honeybadger+acog_sp";
      break;
    case 1:
      self.weapon = "honeybadger+reflex_sp";
      break;
  }

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character\character_elias_a::main();
      break;
    case 1:
      character\character_elias_b::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_elias_a::precache();
  character\character_elias_b::precache();
  precacheitem("honeybadger+acog_sp");
  precacheitem("honeybadger+reflex_sp");
  precacheitem("m9a1");
  precacheitem("fraggrenade");
}