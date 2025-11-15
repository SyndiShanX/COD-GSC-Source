/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\test_enemy_oilrocks_rpg.gsc
**********************************************/

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
    self setengagementmindist(768.0, 512.0);
    self setengagementmaxdist(1024.0, 1500.0);
  }

  self.weapon = "panzerfaust3_cheap";

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character\character_fed_army_assault_a_elite::main();
      break;
    case 1:
      character\character_fed_army_assault_b_elite::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_fed_army_assault_a_elite::precache();
  character\character_fed_army_assault_b_elite::precache();
  precacheitem("panzerfaust3_cheap");
  precacheitem("ak12");
  precacheitem("p226");
  precacheitem("fraggrenade");
}