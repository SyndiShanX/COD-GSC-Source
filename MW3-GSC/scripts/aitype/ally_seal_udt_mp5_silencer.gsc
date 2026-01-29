/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\ally_seal_udt_mp5_silencer.gsc
*********************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "usp_silencer";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "mp5_silencer";

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      _id_4958::main();
      break;
    case 1:
      _id_4959::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_4958::precache();
  _id_4959::precache();
  precacheitem("mp5_silencer");
  precacheitem("usp_silencer");
  precacheitem("fraggrenade");
}