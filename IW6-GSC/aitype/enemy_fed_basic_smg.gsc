/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_fed_basic_smg.gsc
******************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self.sidearm = "p226";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  switch (codescripts\character::get_random_weapon(8)) {
    case 0:
      self.weapon = "cbjms";
      break;
    case 1:
      self.weapon = "cbjms";
      break;
    case 2:
      self.weapon = "cbjms";
      break;
    case 3:
      self.weapon = "cbjms";
      break;
    case 4:
      self.weapon = "pp19";
      break;
    case 5:
      self.weapon = "pp19+acogsmg_sp";
      break;
    case 6:
      self.weapon = "pp19+eotechsmg_sp";
      break;
    case 7:
      self.weapon = "pp19+reflexsmg_sp";
      break;
  }

  character\character_fed_basic_smg_a::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_fed_basic_smg_a::precache();
  precacheitem("cbjms");
  precacheitem("cbjms");
  precacheitem("cbjms");
  precacheitem("cbjms");
  precacheitem("pp19");
  precacheitem("pp19+acogsmg_sp");
  precacheitem("pp19+eotechsmg_sp");
  precacheitem("pp19+reflexsmg_sp");
  precacheitem("p226");
  precacheitem("fraggrenade");
}