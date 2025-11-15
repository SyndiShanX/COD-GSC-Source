/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\hero_ajax_flood_ar.gsc
*****************************************/

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
  self.secondaryweapon = "m9a1";
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
      self.weapon = "fads+acog_sp";
      break;
  }

  character\character_ajax_flood_a::main();
}

spawner() {
  self setspawnerteam("allies");
}

precache() {
  character\character_ajax_flood_a::precache();
  precacheitem("r5rgp+acog_sp");
  precacheitem("fads+acog_sp");
  precacheitem("m9a1");
  precacheitem("m9a1");
  precacheitem("fraggrenade");
}