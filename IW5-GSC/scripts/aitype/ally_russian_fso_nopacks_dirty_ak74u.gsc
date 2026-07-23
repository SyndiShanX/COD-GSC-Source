/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\ally_russian_fso_nopacks_dirty_ak74u.gsc
*******************************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "fnfiveseven";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "ak74u";

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      _id_34E2::main();
      break;
    case 1:
      _id_34E3::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_34E2::precache();
  _id_34E3::precache();
  precacheitem("ak74u");
  precacheitem("fnfiveseven");
  precacheitem("fraggrenade");
}