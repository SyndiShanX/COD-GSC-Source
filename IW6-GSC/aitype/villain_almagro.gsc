/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\villain_almagro.gsc
**************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self.sidearm = "p226";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "kriss";
  character\character_almagro_assault_a::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_almagro_assault_a::precache();
  precacheitem("kriss");
  precacheitem("p226");
  precacheitem("fraggrenade");
}