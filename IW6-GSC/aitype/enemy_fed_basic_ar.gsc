/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_fed_basic_ar.gsc
*****************************************/

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
  self.sidearm = "p226";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  switch (codescripts\character::get_random_weapon(12)) {
    case 0:
      self.weapon = "sc2010";
      break;
    case 1:
      self.weapon = "sc2010+acog_sp";
      break;
    case 2:
      self.weapon = "sc2010+eotech_sp";
      break;
    case 3:
      self.weapon = "sc2010+reflex_sp";
      break;
    case 4:
      self.weapon = "ak12";
      break;
    case 5:
      self.weapon = "ak12+acog_sp";
      break;
    case 6:
      self.weapon = "ak12+eotech_sp";
      break;
    case 7:
      self.weapon = "ak12+reflex_sp";
      break;
    case 8:
      self.weapon = "cz805bren";
      break;
    case 9:
      self.weapon = "cz805bren+acog_sp";
      break;
    case 10:
      self.weapon = "cz805bren+eotech_sp";
      break;
    case 11:
      self.weapon = "cz805bren+reflex_sp";
      break;
  }

  character\character_fed_basic_assault_a::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_fed_basic_assault_a::precache();
  precacheitem("sc2010");
  precacheitem("sc2010+acog_sp");
  precacheitem("sc2010+eotech_sp");
  precacheitem("sc2010+reflex_sp");
  precacheitem("ak12");
  precacheitem("ak12+acog_sp");
  precacheitem("ak12+eotech_sp");
  precacheitem("ak12+reflex_sp");
  precacheitem("cz805bren");
  precacheitem("cz805bren+acog_sp");
  precacheitem("cz805bren+eotech_sp");
  precacheitem("cz805bren+reflex_sp");
  precacheitem("p226");
  precacheitem("fraggrenade");
}