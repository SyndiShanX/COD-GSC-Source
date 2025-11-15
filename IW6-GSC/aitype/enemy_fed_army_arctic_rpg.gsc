/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_fed_army_arctic_rpg.gsc
************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "panzerfaust3_player.csv";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "ak12";
  self.sidearm = "p226";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "panzerfaust3";
  character\character_fed_army_assault_a_arctic::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_fed_army_assault_a_arctic::precache();
  precacheitem("panzerfaust3");
  precacheitem("ak12");
  precacheitem("p226");
  precacheitem("fraggrenade");
}