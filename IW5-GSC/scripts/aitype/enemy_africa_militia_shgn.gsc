/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_africa_militia_shgn.gsc
********************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "common_rambo_anims.csv";
  self.team = "axis";
  self.type = "human";
  self.subclass = "militia";
  self.accuracy = 0.18;
  self.health = 150;
  self.secondaryweapon = "";
  self.sidearm = "glock";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(0.0, 0.0);
    self setengagementmaxdist(280.0, 400.0);
  }

  self.weapon = "model1887";

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character/character_africa_militia_shotgun_a::main();
      break;
    case 1:
      character/character_africa_militia_shotgun_b::main();
      break;
  }
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character/character_africa_militia_shotgun_a::precache();
  character/character_africa_militia_shotgun_b::precache();
  precacheitem("model1887");
  precacheitem("glock");
  precacheitem("fraggrenade");
  maps/_rambo::main();
}