/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_elite_pmc_desert_dmr.gsc
*************************************************/

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

  self.weapon = "svu+scopesvu_sp";
  character\character_elite_pmc_assault_b_desert::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_elite_pmc_assault_b_desert::precache();
  precacheitem("svu+scopesvu_sp");
  precacheitem("mp443");
  precacheitem("fraggrenade");
}