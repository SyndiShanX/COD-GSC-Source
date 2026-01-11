/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_vignette_util.gsc
*****************************************************/

vignette_register(var_0, var_1) {
  if(!common_scripts\utility::flag_exist(var_1)) {
    common_scripts\utility::flag_init(var_1);
  }

  thread vignette_register_wait(var_0, var_1);
}

vignette_register_wait(var_0, var_1) {
  common_scripts\utility::flag_wait(var_1);
  level thread[[var_0]]();
}

vignette_drone_spawn(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_2.script_forcespawn = 1;
  var_3 = maps\_spawner::spawner_dronespawn(var_2);
  var_3.animname = var_1;
  return var_3;
}

vignette_actor_spawn(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_2.script_forcespawn = 1;
  var_2 thread maps\_utility::add_spawn_function(::vignette_actor_spawn_func);
  var_3 = var_2 maps\_utility::spawn_ai();
  var_3.animname = var_1;
  return var_3;
}

vignette_actor_spawn_func() {
  self endon("death");
  thread maps\_utility::magic_bullet_shield();
  thread vignette_actor_ignore_everything();
}

vignette_actor_delete() {
  if(isDefined(self.magic_bullet_shield)) {
    maps\_utility::stop_magic_bullet_shield();
  }

  self delete();
}

vignette_actor_kill() {
  if(!isalive(self)) {
    return;
  }
  if(isDefined(self.magic_bullet_shield)) {
    maps\_utility::stop_magic_bullet_shield();
  }

  self.allowdeath = 1;
  self.a.nodeath = 1;
  maps\_utility::set_battlechatter(0);
  self kill();
}

vignette_actor_ignore_everything() {
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.grenadeawareness = 0;
  self.ignoreexplosionevents = 1;
  self.ignorerandombulletdamage = 1;
  self.ignoresuppression = 1;
  self.fixednode = 0;
  self.disablebulletwhizbyreaction = 1;
  maps\_utility::disable_pain();
  self.dontavoidplayer = 1;
  self.og_newenemyreactiondistsq = self.newenemyreactiondistsq;
  self.newenemyreactiondistsq = 0;
}

vignette_vehicle_spawn(var_0, var_1) {
  var_2 = maps\_vehicle::spawn_vehicle_from_targetname(var_0);
  var_2.animname = var_1;
  return var_2;
}

vignette_vehicle_delete() {
  self delete();
}