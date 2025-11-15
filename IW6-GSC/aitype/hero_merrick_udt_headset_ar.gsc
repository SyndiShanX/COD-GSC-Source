/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\hero_merrick_udt_headset_ar.gsc
**************************************************/

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
  self.secondaryweapon = "m9a1";
  self.sidearm = "m9a1";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "r5rgp+eotech_sp";
  character\character_merrick_udt_assault_c::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_merrick_udt_assault_c::precache();
  precacheitem("r5rgp+eotech_sp");
  precacheitem("m9a1");
  precacheitem("m9a1");
  precacheitem("fraggrenade");
}