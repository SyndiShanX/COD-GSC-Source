/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\hero_keegan_end_xb_sniper.gsc
************************************************/

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
  self.secondaryweapon = "l115a3+scopel115a3_sp";
  self.sidearm = "m9a1";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  switch (codescripts\character::get_random_weapon(2)) {
    case 0:
      self.weapon = "r5rgp+acog_sp";
      break;
    case 1:
      self.weapon = "r5rgp+eotech_sp";
      break;
  }

  character\character_keegan_end_smg_a::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_keegan_end_smg_a::precache();
  precacheitem("r5rgp+acog_sp");
  precacheitem("r5rgp+eotech_sp");
  precacheitem("l115a3+scopel115a3_sp");
  precacheitem("m9a1");
  precacheitem("fraggrenade");
}