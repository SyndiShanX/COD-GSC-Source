/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_fed_army_rpg.gsc
*****************************************/

main() {
  self.animtree = "";
  self.additionalassets = "panzerfaust3_player.csv";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "ak12";
  self.sidearm = "p226";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "panzerfaust3";

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character\character_fed_army_assault_a::main();
      break;
    case 1:
      character\character_fed_army_assault_b::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_fed_army_assault_a::precache();
  character\character_fed_army_assault_b::precache();
  precacheitem("panzerfaust3");
  precacheitem("ak12");
  precacheitem("p226");
  precacheitem("fraggrenade");
}