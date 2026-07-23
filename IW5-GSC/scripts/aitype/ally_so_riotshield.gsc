/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\ally_so_riotshield.gsc
*************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "riotshield";
  self.accuracy = 0.2;
  self.health = 100;
  self.secondaryweapon = "iw5_riotshield_so";
  self.sidearm = "";
  self.grenadeweapon = "";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "none";

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character/character_gign_paris_smg::main();
      break;
    case 1:
      character/character_gign_paris_assault::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character/character_gign_paris_smg::precache();
  character/character_gign_paris_assault::precache();
  precacheitem("iw5_riotshield_so");
  maps/_riotshield::init_riotshield();
}