/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombie_repulsor.gsc
********************************************************/

init() {
  level._effect["dlc_repulsor"] = loadfx("vfx/gameplay/mp/zombie/dlc_repulsor");
}

onplayerspawn() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  self notify("onPlayerSpawnZombieRepulsor");
  self endon("onPlayerSpawnZombieRepulsor");
  var_0 = self.team;

  for(;;) {
    self waittill("grenade_fire", var_1, var_2);
    var_3 = maps\mp\_utility::strip_suffix(var_2, "_lefthand");

    if(var_3 != "repulsor_zombie_mp") {
      continue;
    }
    var_4 = (var_1.origin[0], var_1.origin[1], self.origin[2] + 20);
    var_1 delete();
    dorepulsor(var_4, var_0);
  }
}

dorepulsor(var_0, var_1) {
  var_2 = self.angles;
  var_3 = (0, 0, 1);
  playFX(common_scripts\utility::getfx("dlc_repulsor"), self.origin, var_2, var_3);
  self radiusdamage(var_0, 500, 100, 25, self, "MOD_EXPLOSIVE", "repulsor_zombie_mp");
  wait 0.1;
  physicsexplosionsphere(var_0, 500, 0, 10, 0);
}