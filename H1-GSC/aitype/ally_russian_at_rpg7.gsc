/*******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: aitype\ally_russian_at_rpg7.gsc
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
  self.secondaryweapon = "ak47";
  self.sidearm = "beretta";

  if(isai(self)) {
    self setengagementmindist(768.0, 512.0);
    self setengagementmaxdist(1024.0, 1500.0);
  }

  self.weapon = "rpg";

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
  precacheitem("rpg");
  precacheitem("ak47");
  precacheitem("beretta");
  precacheitem("fraggrenade");
}