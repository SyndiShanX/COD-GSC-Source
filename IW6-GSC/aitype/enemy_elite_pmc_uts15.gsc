/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_elite_pmc_uts15.gsc
********************************************/

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

  switch (codescripts\character::get_random_weapon(3)) {
    case 0:
      self.weapon = "maul";
      break;
    case 1:
      self.weapon = "maul+eotech_sp";
      break;
    case 2:
      self.weapon = "maul+reflex_sp";
      break;
  }

  character\character_elite_pmc_shotgun_b::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_elite_pmc_shotgun_b::precache();
  precacheitem("maul");
  precacheitem("maul+eotech_sp");
  precacheitem("maul+reflex_sp");
  precacheitem("p226");
  precacheitem("fraggrenade");
}