/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\ally_hero_truck_delta_m4.gsc
*******************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.secondaryweapon = "";
  self.sidearm = "deserteagle";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "m4_grunt";
  _id_5FA3::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_5FA3::precache();
  precacheitem("m4_grunt");
  precacheitem("deserteagle");
  precacheitem("fraggrenade");
}