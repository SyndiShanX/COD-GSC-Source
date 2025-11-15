/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\animal_drone_deer.gsc
****************************************/

main() {
  self.animtree = "";
  self.additionalassets = "";
  self.team = "team3";
  self.type = "dog";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 200;
  self.grenadeweapon = "";
  self.grenadeammo = 0;
  self.secondaryweapon = "";
  self.sidearm = "";

  if(isai(self)) {
    self setengagementmindist(256.0, 0.0);
    self setengagementmaxdist(768.0, 1024.0);
  }

  self.weapon = "none";

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character\character_deer_a::main();
      break;
    case 1:
      character\character_deer_b::main();
      break;
    case 2:
      character\character_deer_c::main();
      break;
  }
}

spawner() {
  self setspawnerteam("team3");
}

precache() {
  character\character_deer_a::precache();
  character\character_deer_b::precache();
  character\character_deer_c::precache();
}