/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_juggernaut_explosive.gsc
*********************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "juggernaut.csv";
  self.team = "axis";
  self.type = "human";
  self.subclass = "juggernaut";
  self.accuracy = 0.2;
  self.health = 3600;
  self.secondaryweapon = "fnfiveseven";
  self.sidearm = "fnfiveseven";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(0.0, 0.0);
    self setengagementmaxdist(256.0, 1024.0);
  }

  self.weapon = "pecheneg";
  _id_05C9::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  _id_05C9::precache();
  precacheitem("pecheneg");
  precacheitem("fnfiveseven");
  precacheitem("fnfiveseven");
  precacheitem("fraggrenade");
  _id_05C6::main();
}