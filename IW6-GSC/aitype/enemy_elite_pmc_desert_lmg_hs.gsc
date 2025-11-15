/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_elite_pmc_desert_lmg_hs.gsc
****************************************************/

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

  switch (codescripts\character::get_random_weapon(3)) {
    case 0:
      self.weapon = "lsat";
      break;
    case 1:
      self.weapon = "lsat+eotechlmg_sp";
      break;
    case 2:
      self.weapon = "lsat+reflexlmg_sp";
      break;
  }

  character\character_elite_pmc_lmg_b_desert_hs::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_elite_pmc_lmg_b_desert_hs::precache();
  precacheitem("lsat");
  precacheitem("lsat+eotechlmg_sp");
  precacheitem("lsat+reflexlmg_sp");
  precacheitem("mp443");
  precacheitem("fraggrenade");
}