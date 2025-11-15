/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_elite_pmc_desert_smg_b.gsc
***************************************************/

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

  switch (codescripts\character::get_random_weapon(8)) {
    case 0:
      self.weapon = "k7";
      break;
    case 1:
      self.weapon = "k7+acogsmg_sp";
      break;
    case 2:
      self.weapon = "k7+eotechsmg_sp";
      break;
    case 3:
      self.weapon = "k7+reflexsmg_sp";
      break;
    case 4:
      self.weapon = "microtar";
      break;
    case 5:
      self.weapon = "microtar+acogsmg_sp";
      break;
    case 6:
      self.weapon = "microtar+eotechsmg_sp";
      break;
    case 7:
      self.weapon = "microtar+reflexsmg_sp";
      break;
  }

  character\character_elite_pmc_smg_b_desert::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_elite_pmc_smg_b_desert::precache();
  precacheitem("k7");
  precacheitem("k7+acogsmg_sp");
  precacheitem("k7+eotechsmg_sp");
  precacheitem("k7+reflexsmg_sp");
  precacheitem("microtar");
  precacheitem("microtar+acogsmg_sp");
  precacheitem("microtar+eotechsmg_sp");
  precacheitem("microtar+reflexsmg_sp");
  precacheitem("p226");
  precacheitem("fraggrenade");
}