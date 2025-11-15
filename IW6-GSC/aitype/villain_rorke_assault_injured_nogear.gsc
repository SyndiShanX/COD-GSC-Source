/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\villain_rorke_assault_injured_nogear.gsc
***********************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
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

  self.weapon = "magnum_sw_rorke";
  character\character_rorke_assault_nogear_injured::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_rorke_assault_nogear_injured::precache();
  precacheitem("magnum_sw_rorke");
}