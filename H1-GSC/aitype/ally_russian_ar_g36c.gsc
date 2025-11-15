/*******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\ally_russian_ar_g36c.gsc
*******************************************/

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
  self.secondaryweapon = "beretta";
  self.sidearm = "beretta";

  if(isai(self)) {
    self setengagementmindist(128.0, 0.0);
    self setengagementmaxdist(512.0, 1024.0);
  }

  self.weapon = "g36c";

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character\character_sp_russian_loyalist_a::main();
      break;
    case 1:
      character\character_sp_russian_loyalist_b::main();
      break;
    case 2:
      character\character_sp_russian_loyalist_c::main();
      break;
  }
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_sp_russian_loyalist_a::precache();
  character\character_sp_russian_loyalist_b::precache();
  character\character_sp_russian_loyalist_c::precache();
  precacheitem("g36c");
  precacheitem("beretta");
  precacheitem("beretta");
  precacheitem("fraggrenade");
}