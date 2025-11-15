/**********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\ally_blackkit_smg_mp5sd.gsc
**********************************************/

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

  switch (codescripts\character::get_random_character(5)) {
    case 0:
      character\character_sp_sas_ct_benjamin::main();
      break;
    case 1:
      character\character_sp_sas_ct_charles::main();
      break;
    case 2:
      character\character_sp_sas_ct_mitchel::main();
      break;
    case 3:
      character\character_sp_sas_ct_neal::main();
      break;
    case 4:
      character\character_sp_sas_ct_william::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_sp_sas_ct_benjamin::precache();
  character\character_sp_sas_ct_charles::precache();
  character\character_sp_sas_ct_mitchel::precache();
  character\character_sp_sas_ct_neal::precache();
  character\character_sp_sas_ct_william::precache();
  precacheitem("mp5_silencer");
  precacheitem("usp_silencer");
  precacheitem("usp_silencer");
  precacheitem("fraggrenade");
}