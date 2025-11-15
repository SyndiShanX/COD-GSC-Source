/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_elite_pmc_desert_ar.gsc
************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "elite";
  self.accuracy = 0.2;
  self.health = 250;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self.sidearm = "mp443";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  switch (codescripts\character::get_random_weapon(9)) {
    case 0:
      self.weapon = "fads+acog_sp";
      break;
    case 1:
      self.weapon = "fads+eotech_sp";
      break;
    case 2:
      self.weapon = "fads+reflex_sp";
      break;
    case 3:
      self.weapon = "cz805bren+acog_sp";
      break;
    case 4:
      self.weapon = "cz805bren+eotech_sp";
      break;
    case 5:
      self.weapon = "cz805bren+reflex_sp";
      break;
    case 6:
      self.weapon = "ak12+acog_sp";
      break;
    case 7:
      self.weapon = "ak12+eotech_sp";
      break;
    case 8:
      self.weapon = "ak12+reflex_sp";
      break;
  }

  character\character_elite_pmc_assault_b_desert::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_elite_pmc_assault_b_desert::precache();
  precacheitem("fads+acog_sp");
  precacheitem("fads+eotech_sp");
  precacheitem("fads+reflex_sp");
  precacheitem("cz805bren+acog_sp");
  precacheitem("cz805bren+eotech_sp");
  precacheitem("cz805bren+reflex_sp");
  precacheitem("ak12+acog_sp");
  precacheitem("ak12+eotech_sp");
  precacheitem("ak12+reflex_sp");
  precacheitem("mp443");
  precacheitem("fraggrenade");
}