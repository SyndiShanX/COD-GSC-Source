/**********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\ally_hero_mark_blackkit.gsc
**********************************************/

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
  self.secondaryweapon = "winchester1200";
  self.sidearm = "usp_silencer";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "m4_silencer";
  character\character_sp_sas_ct_charles::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_sp_sas_ct_charles::precache();
  precacheitem("m4_silencer");
  precacheitem("winchester1200");
  precacheitem("usp_silencer");
  precacheitem("fraggrenade");
}