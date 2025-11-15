/********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\ally_blackkit_smg_mp5sd_wallcroft.gsc
********************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "usp_silencer";
  self.sidearm = "usp_silencer";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "mp5_silencer";
  character\character_sp_sas_ct_neal::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_sp_sas_ct_neal::precache();
  precacheitem("mp5_silencer");
  precacheitem("usp_silencer");
  precacheitem("usp_silencer");
  precacheitem("fraggrenade");
}