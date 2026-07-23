/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitype\enemy_juggernaut_riotshield.gsc
**********************************************************/

main() {
  self.animtree = "";
  self.additionalassets = "juggernaut_riotshield.csv";
  self.team = "axis";
  self.type = "human";
  self.subclass = "riotshield";
  self.accuracy = 0.2;
  self.health = 3600;
  self.secondaryweapon = "iw5_riotshield_so";
  self.sidearm = "fnfiveseven";
  self.grenadeweapon = "fraggrenade";
  self.grenadeammo = 0;

  if(isai(self)) {
    self setengagementmindist(0.0, 0.0);
    self setengagementmaxdist(256.0, 1024.0);
  }

  self.weapon = "pecheneg";
  character/character_so_juggernaut_mid::main();
}

spawner() {
  self setspawnerteam("axis");
}

precache() {
  character/character_so_juggernaut_mid::precache();
  precacheitem("pecheneg");
  precacheitem("iw5_riotshield_so");
  precacheitem("fnfiveseven");
  precacheitem("fraggrenade");
  maps/_riotshield::init_riotshield();
  maps/_juggernaut::main();
}