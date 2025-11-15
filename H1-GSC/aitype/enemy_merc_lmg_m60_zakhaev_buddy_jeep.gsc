/************************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\enemy_merc_lmg_m60_zakhaev_buddy_jeep.gsc
************************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "beretta";
  self.sidearm = "beretta";

  if(isai(self)) {
    self setengagementmindist(512.0, 400.0);
    self setengagementmaxdist(1024.0, 1250.0);
  }

  self.weapon = "m60e4_jeeprideending_zakhaevbuddy1";
  character\character_sp_spetsnaz_boris_jeepride::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_sp_spetsnaz_boris_jeepride::precache();
  precacheitem("m60e4_jeeprideending_zakhaevbuddy1");
  precacheitem("beretta");
  precacheitem("beretta");
  precacheitem("fraggrenade");
}