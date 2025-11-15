/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_fed_army_urban_ar_sc2010gl.gsc
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
  self.sidearm = "p226";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "sc2010+gl_sp";

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character\character_fed_army_assault_a_urban::main();
      break;
    case 1:
      character\character_fed_army_assault_b_urban::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_fed_army_assault_a_urban::precache();
  character\character_fed_army_assault_b_urban::precache();
  precacheitem("sc2010+gl_sp");
  precacheitem("p226");
  precacheitem("fraggrenade");
}