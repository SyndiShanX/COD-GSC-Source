/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\hero_kick_udt_water_glowstick_ar.gsc
*******************************************************/

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

  self.weapon = "aps_underwater+swim";
  character\character_kick_udt_water_glowstick::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_kick_udt_water_glowstick::precache();
  precacheitem("aps_underwater+swim");
  precacheitem("m9a1");
  precacheitem("m9a1");
  precacheitem("fraggrenade");
}