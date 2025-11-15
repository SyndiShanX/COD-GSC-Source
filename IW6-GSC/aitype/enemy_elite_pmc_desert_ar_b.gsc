/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_elite_pmc_desert_ar_b.gsc
**************************************************/

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
      self.weapon = "msbs";
      break;
    case 5:
      self.weapon = "msbs+acog_sp";
      break;
    case 6:
      self.weapon = "msbs+eotech_sp";
      break;
    case 7:
      self.weapon = "msbs+reflex_sp";
      break;
    case 8:
      self.weapon = "fads";
      break;
    case 9:
      self.weapon = "fads+acog_sp";
      break;
    case 10:
      self.weapon = "fads+eotech_sp";
      break;
    case 11:
      self.weapon = "fads+reflex_sp";
      break;
  }

  character\character_elite_pmc_assault_b_desert::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_elite_pmc_assault_b_desert::precache();
  precacheitem("sc2010");
  precacheitem("sc2010+acog_sp");
  precacheitem("sc2010+eotech_sp");
  precacheitem("sc2010+reflex_sp");
  precacheitem("msbs");
  precacheitem("msbs+acog_sp");
  precacheitem("msbs+eotech_sp");
  precacheitem("msbs+reflex_sp");
  precacheitem("fads");
  precacheitem("fads+acog_sp");
  precacheitem("fads+eotech_sp");
  precacheitem("fads+reflex_sp");
  precacheitem("p226");
  precacheitem("fraggrenade");
}