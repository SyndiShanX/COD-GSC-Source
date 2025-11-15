/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_fed_army_arctic_smg.gsc
************************************************/

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

  switch (codescripts\character::get_random_weapon(12)) {
    case 0:
      self.weapon = "cbjms";
      break;
    case 1:
      self.weapon = "cbjms+acogsmg_sp";
      break;
    case 2:
      self.weapon = "cbjms+eotechsmg_sp";
      break;
    case 3:
      self.weapon = "cbjms+reflexsmg_sp";
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
    case 8:
      self.weapon = "vepr";
      break;
    case 9:
      self.weapon = "vepr+acogsmg_sp";
      break;
    case 10:
      self.weapon = "vepr+eotechsmg_sp";
      break;
    case 11:
      self.weapon = "vepr+reflexsmg_sp";
      break;
  }

  character\character_fed_army_smg_a_arctic::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character\character_fed_army_smg_a_arctic::precache();
  precacheitem("cbjms");
  precacheitem("cbjms+acogsmg_sp");
  precacheitem("cbjms+eotechsmg_sp");
  precacheitem("cbjms+reflexsmg_sp");
  precacheitem("pp19");
  precacheitem("pp19+acogsmg_sp");
  precacheitem("pp19+eotechsmg_sp");
  precacheitem("pp19+reflexsmg_sp");
  precacheitem("vepr");
  precacheitem("vepr+acogsmg_sp");
  precacheitem("vepr+eotechsmg_sp");
  precacheitem("vepr+reflexsmg_sp");
  precacheitem("p226");
  precacheitem("fraggrenade");
}