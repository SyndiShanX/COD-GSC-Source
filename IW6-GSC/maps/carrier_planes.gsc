/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\carrier_planes.gsc
*****************************************************/

setup_planes() {
  carrier_planes_precache();
  thread mig29_missile_dives();
}

carrier_planes_precache() {
  precacheitem("AGM_65");
  precacheitem("a10_30mm_player");
  precacherumble("ac130_25mm_fire");
  level._effect["a10_muzzle_flash"] = loadfx("fx/muzzleflashes/a10_muzzle_flash");
}

mig29_gun_dives() {
  maps\_utility::array_spawn_function_noteworthy("mig29_gun", ::setup_mig29_waits);
}

mig29_missile_dives() {
  maps\_utility::array_spawn_function_noteworthy("mig29_missile", ::setup_mig29_waits);
}

setup_mig29_waits() {
  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "mig29_gun") {
      thread mig29_wait_start_firing();
      thread mig29_wait_stop_firing();
    } else if(self.script_noteworthy == "mig29_missile")
      thread mig29_wait_fire_missile();
  }
}

random_wait_and_kill(var_0, var_1) {
  self endon("death");
  wait(randomfloatrange(var_0, var_1));
  self kill();
}

mig29_wait_start_firing() {
  self endon("death");
  maps\_utility::ent_flag_init("start_firing");
  maps\_utility::ent_flag_wait("start_firing");
  maps\_utility::ent_flag_clear("start_firing");
  thread mig29_fire();
}

mig29_wait_stop_firing() {
  self endon("death");
  maps\_utility::ent_flag_init("stop_firing");
  maps\_utility::ent_flag_wait("stop_firing");
  self stoploopsound("a10p_gatling_loop");
  self playSound("a10p_gatling_tail");
  maps\_utility::ent_flag_clear("stop_firing");
}

mig29_wait_fire_missile() {
  self endon("death");
  maps\_utility::ent_flag_init("fire_missile");
  maps\_utility::ent_flag_wait("fire_missile");

  if(isDefined(self.script_parameters)) {
    var_0 = getent(self.script_parameters, "targetname");
    thread mig29_fire_missiles(var_0);
  } else
    thread mig29_fire_missiles();

  maps\_utility::ent_flag_clear("fire_missile");
}

mig29_missile_set_target(var_0) {
  wait 0.2;
  self missile_settargetent(var_0);

  if(isDefined(var_0.godmode) && var_0.godmode == 1)
    var_0 maps\_vehicle::godoff();
}

mig29_fire_missiles(var_0, var_1) {
  self playSound("a10p_missile_launch");
  var_2 = anglesToForward(self.angles);
  var_3 = 1000;
  var_4 = self gettagorigin("tag_origin") + var_2 * var_3;
  var_5 = var_4 + anglesToForward(self gettagangles("tag_origin") + (0, 0, 30)) * 100;
  var_6 = magicbullet("AGM_65", var_4, var_5);
  var_6.angles = self gettagangles("tag_origin");
  var_7 = self;

  if(isDefined(var_0)) {
    var_6 thread mig29_missile_set_target(var_0);

    if(isDefined(var_1))
      var_6 thread monitor_missile_distance(260000, var_0, var_7);
  }
}

monitor_missile_distance(var_0, var_1, var_2) {
  while(isDefined(self) && distancesquared(self.origin, var_1.origin) > var_0)
    wait 0.05;

  playFXOnTag(level._effect["vehicle_explosion_slamraam_no_missiles"], var_1, "tag_origin");

  if(isDefined(self))
    self delete();

  wait 0.1;

  if(isDefined(var_2.kill_target) && var_2.kill_target == 1) {
    playFXOnTag(level._effect["aerial_explosion_mig29"], var_1, "tag_origin");
    wait 0.1;
    playFXOnTag(level._effect["jet_crash_dcemp"], var_1, "tag_origin");
    var_1 maps\_vehicle::godoff();
    var_1 kill();
    wait 0.25;

    if(isDefined(var_1))
      var_1 delete();
  } else {
    playFXOnTag(level._effect["airplane_damage_blacksmoke_fire"], var_1, "tag_engine_right");
    wait 0.1;
    stopFXOnTag(level._effect["vehicle_explosion_slamraam_no_missiles"], var_1, "tag_origin");
  }
}

mig29_fire() {
  self endon("death");
  self endon("stop_firing");
  self.firing_sound_ent = spawn("script_origin", (0, 0, 0));

  for(;;) {
    var_0 = anglesToForward(self.angles);
    var_1 = 1000;
    var_2 = self gettagorigin("tag_flash") + var_0 * var_1;
    var_3 = var_2 + var_0 * 999999999;
    magicbullet("a10_30mm_player", var_2 + var_0, var_3);
    playFXOnTag(level._effect["a10_muzzle_flash"], self, "tag_flash");
    earthquake(0.2, 0.05, self.origin, 1000);
    self playLoopSound("a10p_gatling_loop");
    wait 0.1;
  }
}

mig29_afterburners_node_wait() {
  self endon("death");
  maps\_utility::ent_flag_init("start_afterburners");
  maps\_utility::ent_flag_wait("start_afterburners");
  self playSound("veh_mig29_sonic_boom");
  thread vehicle_scripts\_mig29::playafterburner();
}

mig29_monitor_projectile_death() {
  self endon("deleted");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(var_4 != "MOD_PROJECTILE") {
      continue;
    }
    var_5 = common_scripts\utility::getfx("FX_mig29_on_fire");
    playFXOnTag(var_5, self, "tag_origin");
    wait(randomfloatrange(0.33, 0.75));

    if(!isDefined(self)) {
      return;
    }
    var_5 = common_scripts\utility::getfx("vfx_missile_death_air");
    var_6 = self.origin;
    var_7 = anglesToForward(self.angles);
    playFX(var_5, var_6, var_7);
    common_scripts\utility::stop_loop_sound_on_entity("veh_f15_dist_loop");
    self delete();
    self notify("death");
  }
}