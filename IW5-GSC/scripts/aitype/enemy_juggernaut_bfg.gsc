/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_juggernaut_bfg.gsc
***************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "juggernaut.csv";
  self.team = "axis";
  self.type = "human";
  self.subclass = "juggernaut";
  self.accuracy = 0.2;
  self.health = 3600;
  self.secondaryweapon = "beretta";
  self.sidearm = "beretta";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(0.0, 0.0);
    self setengagementmaxdist(256.0, 1024.0);
  }

  self.weapon = "pecheneg";
  _id_05C5::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  _id_05C5::precache();
  precacheitem("pecheneg");
  precacheitem("beretta");
  precacheitem("beretta");
  precacheitem("fraggrenade");
  _id_05C6::main();
}