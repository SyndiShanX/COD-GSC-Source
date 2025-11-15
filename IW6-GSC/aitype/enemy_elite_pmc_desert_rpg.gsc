/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_elite_pmc_desert_rpg.gsc
*************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "panzerfaust3_player.csv";
  self.team = "axis";
  self.type = "human";
  self.subclass = "elite";
  self.accuracy = 0.2;
  self.health = 250;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "ak12";
  self.sidearm = "mp443";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "panzerfaust3";
  character\character_elite_pmc_assault_b_desert::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_elite_pmc_assault_b_desert::precache();
  precacheitem("panzerfaust3");
  precacheitem("ak12");
  precacheitem("mp443");
  precacheitem("fraggrenade");
}