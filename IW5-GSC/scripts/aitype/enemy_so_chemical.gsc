/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_so_chemical.gsc
************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "none";

  switch (codescripts\character::get_random_character(4)) {
    case 0:
      character/character_chemwar_russian_assault_a::main();
      break;
    case 1:
      character/character_chemwar_russian_assault_aa::main();
      break;
    case 2:
      character/character_chemwar_m_d_so::main();
      break;
    case 3:
      character/character_chemwar_m_dd_so::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character/character_chemwar_russian_assault_a::precache();
  character/character_chemwar_russian_assault_aa::precache();
  character/character_chemwar_m_d_so::precache();
  character/character_chemwar_m_dd_so::precache();
  precacheitem("fraggrenade");
}