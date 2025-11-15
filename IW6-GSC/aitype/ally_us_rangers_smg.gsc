/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\ally_us_rangers_smg.gsc
******************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 100;
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self.sidearm = "m9a1";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  switch (codescripts\character::get_random_weapon(8)) {
    case 0:
      self.weapon = "kriss";
      break;
    case 1:
      self.weapon = "kriss+acogsmg_sp";
      break;
    case 2:
      self.weapon = "kriss+eotechsmg_sp";
      break;
    case 3:
      self.weapon = "kriss+reflexsmg_sp";
      break;
    case 4:
      self.weapon = "microtar";
      break;
    case 5:
      self.weapon = "microtar+acogsmg_sp";
      break;
    case 6:
      self.weapon = "microtar+eotechsmg_sp";
      break;
    case 7:
      self.weapon = "microtar+reflexsmg_sp";
      break;
  }

  character\character_us_rangers_smg_a::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_us_rangers_smg_a::precache();
  precacheitem("kriss");
  precacheitem("kriss+acogsmg_sp");
  precacheitem("kriss+eotechsmg_sp");
  precacheitem("kriss+reflexsmg_sp");
  precacheitem("microtar");
  precacheitem("microtar+acogsmg_sp");
  precacheitem("microtar+eotechsmg_sp");
  precacheitem("microtar+reflexsmg_sp");
  precacheitem("m9a1");
  precacheitem("fraggrenade");
}