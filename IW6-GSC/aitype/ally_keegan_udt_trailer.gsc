/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_keegan_udt_trailer.gsc
**********************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.grenadeweapon = "flash_grenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self.sidearm = "beretta";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "aps_underwater";
  character\character_keegan_udt_water_b::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_keegan_udt_water_b::precache();
  precacheitem("aps_underwater");
  precacheitem("beretta");
  precacheitem("flash_grenade");
}