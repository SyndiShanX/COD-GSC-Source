/**********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\ally_sas_woodland_ar_m4grunt_hunted.gsc
**********************************************************/

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
  self.secondaryweapon = "usp";
  self.sidearm = "usp";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "m4_grunt";

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character\character_sp_sas_woodland_zied::main();
      break;
    case 1:
      character\character_sp_sas_woodland_peter::main();
      break;
    case 2:
      character\character_sp_sas_woodland_todd::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_sp_sas_woodland_zied::precache();
  character\character_sp_sas_woodland_peter::precache();
  character\character_sp_sas_woodland_todd::precache();
  precacheitem("m4_grunt");
  precacheitem("usp");
  precacheitem("usp");
  precacheitem("fraggrenade");
}