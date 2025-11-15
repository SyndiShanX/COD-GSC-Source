/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\hero_elias_hostage.gsc
*****************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self.sidearm = "m9a1";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "r5rgp+acog_sp";
  character\character_elias_hostage::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_elias_hostage::precache();
  precacheitem("r5rgp+acog_sp");
  precacheitem("m9a1");
  precacheitem("fraggrenade");
}