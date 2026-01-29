/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\ally_russian_pmc_payback_ar.gsc
**********************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "usp";
  self.sidearm = "";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  switch (codescripts\character::get_random_weapon(6)) {
    case 0:
      self.weapon = "ak47";
      break;
    case 1:
      self.weapon = "ak47_acog";
      break;
    case 2:
      self.weapon = "ak47_eotech";
      break;
    case 3:
      self.weapon = "ak47_reflex";
      break;
    case 4:
      self.weapon = "m4_grunt";
      break;
    case 5:
      self.weapon = "m4_grenadier";
      break;
  }

  _id_647E::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  _id_647E::precache();
  precacheitem("ak47");
  precacheitem("ak47_acog");
  precacheitem("ak47_eotech");
  precacheitem("ak47_reflex");
  precacheitem("m4_grunt");
  precacheitem("m4_grenadier");
  precacheitem("m203_m4");
  precacheitem("usp");
  precacheitem("fraggrenade");
}