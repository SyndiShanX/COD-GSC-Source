/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_elite_pmc_desert_gm6.gsc
*************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "elite";
  self.accuracy = 0.4;
  self.health = 250;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self.sidearm = "p226";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  switch (codescripts\character::get_random_weapon(2)) {
    case 0:
      self.weapon = "gm6+acog_sp";
      break;
    case 1:
      self.weapon = "gm6+scopegm6_sp";
      break;
  }

  character\character_elite_pmc_assault_b_desert::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_elite_pmc_assault_b_desert::precache();
  precacheitem("gm6+acog_sp");
  precacheitem("gm6+scopegm6_sp");
  precacheitem("p226");
  precacheitem("fraggrenade");
}