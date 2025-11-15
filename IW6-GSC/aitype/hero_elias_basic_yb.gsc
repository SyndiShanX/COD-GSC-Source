/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\hero_elias_basic_yb.gsc
******************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.grenadeweapon = "";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self.sidearm = "";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "none";
  character\character_elias_e::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_elias_e::precache();
}