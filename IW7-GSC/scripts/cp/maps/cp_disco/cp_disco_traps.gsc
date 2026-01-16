/*******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\cp_disco_traps.gsc
*******************************************************/

init_buffer_trap() {
  scripts\engine\utility::array_thread(scripts\engine\utility::getstructarray("trap_buffer", "script_noteworthy"), ::power_on_buffer);
}

power_on_buffer() {
  var_0 = getent(self.target, "targetname");
  var_0 setnonstick(1);
  if(scripts\engine\utility::istrue(self.requires_power)) {
    var_1 = undefined;
    if(isDefined(self.script_area)) {
      var_1 = self.script_area;
    } else {
      var_1 = scripts\cp\cp_interaction::get_area_for_power(self);
    }

    if(isDefined(var_1)) {
      level scripts\engine\utility::waittill_any("power_on", var_1 + " power_on");
    }
  }

  self.powered_on = 1;
}

use_buffer_trap(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
  var_2 = getent(var_0.target, "targetname");
  if(!isDefined(var_2.var_127C9)) {
    var_3 = [];
    foreach(var_5 in scripts\engine\utility::getstructarray(var_0.target, "targetname")) {
      var_3[var_3.size] = spawn("trigger_radius", var_5.origin, 0, var_5.fgetarg, var_5.height);
    }

    foreach(var_8 in var_3) {
      var_8 enablelinkto();
      var_8 linkto(var_2);
    }

    var_2.var_127C9 = var_3;
  }

  playFXOnTag(level._effect["buffer_smoke"], var_2, "tag_origin");
  var_1 playlocalsound("purchase_generic");
  var_2 buffer_trap_sfx();
  var_0.trap_kills = 0;
  if(!isDefined(var_0.offset_vector)) {
    var_0.offset_forward = distance2d(var_2.origin, var_0.origin) * -1;
  }

  var_0.offset_up = distance2d(var_2.origin, var_0.origin);
  var_10 = var_2.origin;
  var_11 = 0;
  while(var_11 < 2) {
    var_2 moveto(var_2.origin + (0, 0, 5), 0.1);
    foreach(var_1 in level.players) {
      var_13 = var_1.origin[2] - var_2.origin[2];
      if(distance(var_2.origin, var_1.origin) < 72 && var_1.origin[2] > var_2.origin[2] && var_13 < 72) {
        var_1 setvelocity((randomintrange(220, 250), randomintrange(220, 250), 0));
      }
    }

    wait(0.1);
    var_2 moveto(var_10, 0.1);
    wait(0.2);
    var_11 = var_11 + 0.3;
  }

  foreach(var_8 in var_2.var_127C9) {
    var_2 thread kill_zombies(var_8, var_1, var_0);
  }

  var_2 thread buffer_move();
  wait(16);
  var_2 notify("stop_buffer");
  var_2 rotateyaw(30, 1, 0, 0);
  var_2 rotateyaw(-30, 1, 0, 1);
  stopFXOnTag(level._effect["buffer_smoke"], var_2, "tag_origin");
  var_2 moveto(var_2.origin + anglesToForward(var_2.last_spot.angles) * 2, 0.25, 0, 0.25);
  var_2 playsoundonmovingent("trap_buffer_stop");
  wait(1);
  var_2 stoploopsound("trap_buffer_spin_lp");
  wait(1);
  var_2 stopsounds();
  var_2.last_spot = undefined;
  var_2.last_yaw = undefined;
  level notify("buffer_trap_kills", var_0.trap_kills);
  var_0.origin = var_2.origin + anglesToForward(var_2.angles) * var_0.offset_forward + (0, 0, var_0.offset_up);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  scripts\cp\cp_interaction::interaction_cooldown(var_0, 90);
}

buffer_move() {
  self endon("stop_buffer");
  var_0 = 1;
  var_1 = scripts\engine\utility::getstructarray(self.target, "targetname");
  var_2 = squared(192);
  for(;;) {
    var_3 = [];
    var_4 = [];
    foreach(var_6 in var_1) {
      var_7 = distance2dsquared(var_6.origin, self.origin);
      if(var_7 > var_2) {
        if(isDefined(self.last_spot) && var_6.angles == self.last_spot.angles) {
          continue;
        }

        var_4[var_3.size] = var_7;
        var_3[var_3.size] = var_6;
      }
    }

    var_9 = randomintrange(0, var_3.size - 1);
    if(!isDefined(var_9)) {
      break;
    }

    var_10 = undefined;
    if(!isDefined(self.last_spot)) {
      var_11 = var_3[var_9];
      var_10 = sqrt(var_4[var_9]) / 180;
      self moveto(var_11.origin, var_10, 1, 0);
    } else {
      var_11 = var_3[var_9];
      var_10 = sqrt(var_4[var_9]) / 180;
      self playsoundonmovingent("trap_buffer_bump_edge");
      self moveto(var_11.origin, var_10, 0, 0);
      self rotateyaw(randomintrange(500, 1080) * var_0, var_10, randomfloatrange(0, var_10 * 0.5), 0);
      var_0 = var_0 * -1;
    }

    wait(var_10);
    self.last_spot = var_11;
  }
}

buffer_trap_sfx() {
  self endon("stop_buffer");
  self playsoundonmovingent("trap_buffer_startup");
  wait(3.1);
  self playLoopSound("trap_buffer_spin_lp");
}

kill_zombies(var_0, var_1, var_2) {
  self endon("stop_buffer");
  for(;;) {
    var_0 waittill("trigger", var_3);
    if(isplayer(var_3) && !scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      if(scripts\engine\utility::istrue(var_3.flung)) {
        continue;
      }

      var_3.flung = 1;
      var_3 thread throwandkillplayer();
      continue;
    }

    if(isDefined(var_3.flung)) {
      continue;
    }

    if(isDefined(var_3.agent_type) && var_3.agent_type == "slasher") {
      continue;
    }

    var_3.flung = 1;
    var_2.trap_kills++;
    level thread fling_zombie(var_3, self, var_1);
  }
}

throwandkillplayer() {
  self endon("disconnect");
  self endon("last_stand");
  self dodamage(35, self.origin);
  self setvelocity((randomintrange(220, 250), randomintrange(220, 250), 0));
  wait(0.5);
  self.flung = undefined;
}

fling_zombie(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0.do_immediate_ragdoll = 1;
  var_0.customdeath = 1;
  var_0.disable_armor = 1;
  var_0.nocorpse = 1;
  var_0.full_gib = 1;
  var_3 = ["kill_trap_generic", "trap_kill_buffer"];
  if(var_2 scripts\cp\utility::is_valid_player()) {
    var_4 = var_2;
    var_4 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_3), "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
  } else {
    var_4 = undefined;
  }

  var_0 dodamage(var_0.health + 1000, var_0.origin, var_4, var_4, "MOD_UNKNOWN", "iw7_buffertrap_zm");
}

init_hydrant_trap() {
  level._effect["trap_hydrant_spray"] = loadfx("vfx\iw7\levels\cp_disco\vfx_trap_hydrant_spray.vfx");
  level._effect["trap_hydrant_spray2"] = loadfx("vfx\iw7\levels\cp_disco\vfx_trap_hydrant_spray_2.vfx");
  level._effect["trap_hydrant_pool"] = loadfx("vfx\iw7\levels\cp_disco\vfx_trap_hydrant_pool.vfx");
}

use_hydrant_trap(var_0, var_1) {
  var_2 = getent(var_0.target, "targetname");
  var_3 = [];
  foreach(var_5 in scripts\engine\utility::getstructarray(var_0.target, "targetname")) {
    var_5.pool_spot = scripts\engine\utility::getstruct(var_5.target, "targetname");
    foreach(var_7 in getEntArray(var_5.target, "targetname")) {
      if(issubstr(var_7.classname, "phys")) {
        var_5.physvolume = var_7;
        continue;
      }

      if(issubstr(var_7.classname, "trigger")) {
        var_5.trigger = var_7;
      }
    }

    var_5.player = var_1;
    var_5.interaction = var_0;
    var_5.valve = var_2;
    var_3[var_3.size] = var_5;
  }

  var_1 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
  var_0.trap_kills = 0;
  var_1 playlocalsound("purchase_generic");
  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
  wait(0.5);
  var_2 rotateyaw(360, 1);
  playsoundatpos(var_2.origin, "trap_hydrant_valve");
  wait(0.5);
  playrumbleonposition("light_3s", var_2.origin);
  earthquake(0.2, 2, var_2.origin, 500);
  wait(0.5);
  scripts\engine\utility::array_thread(var_3, ::shoot_water);
  wait(15);
  level notify("hydrant_trap_kills", var_0.trap_kills);
  var_2 notify("stop_hydrant_trap");
  playsoundatpos(var_2.origin, "trap_hydrant_valve");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  scripts\cp\cp_interaction::interaction_cooldown(var_0, 90);
}

shoot_water() {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "2") {
    playFX(scripts\engine\utility::getfx("trap_hydrant_spray2"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  } else {
    playFX(scripts\engine\utility::getfx("trap_hydrant_spray"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  }

  playsoundatpos(self.origin, "trap_hydrant_spray");
  var_0 = anglesToForward(self.angles);
  self.physvolume physics_volumesetasdirectionalforce(1, var_0, 5000);
  self.physvolume physics_volumesetactivator(1);
  self.physvolume physics_volumeenable(1);
  thread kill_zombies_hydrant(var_0);
  self.valve waittill("stop_hydrant_trap");
  self.physvolume physics_volumeenable(0);
  self.physvolume physics_volumesetactivator(0);
}

kill_zombies_hydrant(var_0) {
  self.valve endon("stop_hydrant_trap");
  for(;;) {
    self.trigger waittill("trigger", var_1);
    if(isplayer(var_1)) {
      var_2 = var_1 getvelocity();
      var_1 setvelocity(var_2 + var_0 * 35);
      continue;
    }

    if(!scripts\cp\utility::should_be_affected_by_trap(var_1, undefined, 1)) {
      continue;
    }

    self.interaction.trap_kills++;
    var_1 thread fling_zombie_hydrant(self.interaction, self.player);
  }
}

fling_zombie_hydrant(var_0, var_1) {
  self endon("death");
  self.flung = 1;
  self.marked_for_death = 1;
  self.do_immediate_ragdoll = 1;
  self.customdeath = 1;
  self.disable_armor = 1;
  wait(randomfloatrange(0.5, 1.5));
  if(var_1 scripts\cp\utility::is_valid_player()) {
    var_2 = var_1;
    var_3 = ["kill_trap_generic", "trap_kill_firehydrant"];
    var_2 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_3), "zmb_comment_vo", "high", 10, 0, 0, 1, 25);
  } else {
    var_2 = undefined;
  }

  self dodamage(self.health + 100, self.origin, var_2, var_2, "MOD_UNKNOWN", "iw7_hydranttrap_zm");
}

init_mosh_trap() {
  scripts\engine\utility::flag_init("flag_moshing_allowed");
  scripts\engine\utility::array_thread(scripts\engine\utility::getstructarray("trap_mosh", "script_noteworthy"), ::power_on_mosh);
}

power_on_mosh() {
  level.punk_rockspots = [];
  level.punk_speakers = [];
  self.aoe = undefined;
  foreach(var_1 in scripts\engine\utility::getstructarray(self.target, "targetname")) {
    if(var_1.script_area == "rockout") {
      level.punk_rockspots[level.punk_rockspots.size] = var_1;
      continue;
    }

    if(var_1.script_area == "radius") {
      self.aoe = var_1;
      continue;
    }

    if(var_1.script_area == "speaker") {
      level.punk_speakers[level.punk_speakers.size] = var_1;
    }
  }

  self.aoe_trigger = spawn("trigger_radius", self.aoe.origin + (0, 0, 16), 0, 600, 64);
  self.powered_on = 1;
}

use_mosh_trap(var_0, var_1) {
  scripts\engine\utility::flag_clear("flag_moshing_allowed");
  var_0.trap_kills = 0;
  var_1 playlocalsound("purchase_generic");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
  level.punk_rockers = [];
  level.punk_moshers = [];
  wait(0.5);
  level thread scripts\cp\maps\cp_disco\cp_disco::start_mosh_trap_music();
  level thread mosh_trap_trigger(var_0, var_1);
  wait(1.1);
  scripts\engine\utility::exploder(50);
  wait(28);
  level notify("stop_mosh_trap");
  level notify("mosh_trap_kills", var_0.trap_kills);
  kill_mosh_stragglers(var_1);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  scripts\cp\cp_interaction::interaction_cooldown(var_0, 90);
}

mosh_trap_trigger(var_0, var_1) {
  level endon("stop_mosh_trap");
  for(;;) {
    var_0.aoe_trigger waittill("trigger", var_2);
    if(var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_2.is_turned) || scripts\engine\utility::istrue(var_2.mosh_trap) || scripts\engine\utility::istrue(var_2.is_traversing)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_2.is_skeleton)) {
      continue;
    }

    if(!scripts\cp\utility::should_be_affected_by_trap(var_2) || var_2.about_to_dance || var_2.scripted_mode) {
      continue;
    }

    if(var_2.agent_type == "ratking" || var_2.agent_type == "karatemaster" || var_2.agent_type == "cop_dlc2" || var_2.agent_type == "skater") {
      continue;
    }

    var_2 thread release_zombie_on_trap_done(var_1);
    var_2 thread rockmode(var_0, var_1);
  }
}

clean_array(var_0) {
  var_1 = [];
  foreach(var_3 in var_0) {
    if(isDefined(var_3) && isalive(var_3)) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

rockmode(var_0, var_1) {
  level endon("stop_mosh_trap");
  self endon("death");
  self.mosh_trap = 1;
  self.og_movemode = self.synctransients;
  self.synctransients = "sprint";
  self.goalradius_old = self.objective_playermask_showto;
  self.is_rocking = 1;
  self.about_to_dance = 1;
  self.scripted_mode = 1;
  self ghostskulls_total_waves(32);
  var_2 = get_rock_spot(var_0);
  thread release_rockspot_on_death();
  self.desired_dance_angles = (0, var_2.angles[1], 0);
  self.precacheleaderboards = 1;
  self ghostskulls_complete_status(var_2.origin);
  scripts\engine\utility::waittill_any("goal", "goal_reached");
  self notify("rockmode");
  self.do_immediate_ragdoll = 1;
  self.is_dancing = 1;
  level.punk_rockers[level.punk_rockers.size] = self;
}

moshdeath(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1)) {
    self.electrocuted = 1;
    self.dontmutilate = 1;
    self playSound("trap_electric_shock");
  }

  var_2 = ["kill_trap_generic", "trap_kill_moshpit"];
  if(var_0 scripts\cp\utility::is_valid_player()) {
    var_3 = var_0;
    var_3 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_2), "zmb_comment_vo", "high", 10, 0, 0, 1, 25);
  } else {
    var_3 = undefined;
  }

  if(scripts\engine\utility::istrue(self.is_moshing)) {
    self.team = "axis";
  }

  self setscriptablepartstate("eyes", "yellow_eyes");
  self dodamage(self.health + 1000, self.origin, var_3, var_3, "MOD_UNKNOWN", "iw7_moshtrap_zm");
}

get_rock_spot(var_0) {
  if(isDefined(self.rockspot)) {
    self.rockspot.owner = undefined;
    self.rockspot = undefined;
  }

  var_1 = sortbydistance(level.punk_rockspots, var_0.origin);
  foreach(var_3 in var_1) {
    if(!isDefined(var_3.owner)) {
      var_3.owner = self;
      self.rockspot = var_3;
      return var_3;
    }
  }

  return scripts\engine\utility::random(var_1);
}

get_mosh_spot(var_0) {
  var_1 = sortbydistance(level.punk_rockspots, var_0.origin);
  return var_1[0];
}

kill_mosh_stragglers(var_0) {
  foreach(var_2 in level.punk_rockers) {
    if(!isDefined(var_2) || !isalive(var_2)) {
      continue;
    }

    var_3 = scripts\engine\utility::random(level.punk_speakers);
    var_4 = var_2 gettagorigin("J_HEAD");
    playfxbetweenpoints(level._effect["blue_ark_beam"], var_3.origin, vectortoangles(var_3.origin - var_4), var_4);
    var_2 moshdeath(var_0, 1);
    wait(randomfloatrange(0.1, 0.2));
  }
}

release_zombie_on_trap_done(var_0) {
  self endon("death");
  self endon("moshmode");
  self endon("rockmode");
  level waittill("stop_mosh_trap");
  if(isDefined(self.og_goalradius)) {
    self.objective_playermask_showto = self.og_goalradius;
  }

  self ghostskulls_total_waves(self.objective_playermask_showto);
  self.og_goalradius = undefined;
  self.scripted_mode = 0;
  if(isDefined(self.og_movemode)) {
    self.synctransients = self.og_movemode;
  }

  self.og_movemode = undefined;
  self.precacheleaderboards = 0;
  self.about_to_dance = 0;
  self.mosh_trap = undefined;
  self.is_rocking = undefined;
  self.do_immediate_ragdoll = 0;
  if(isDefined(self.rockspot)) {
    self.rockspot.owner = undefined;
  }

  self.rockspot = undefined;
}

release_rockspot_on_death() {
  self waittill("death");
  if(isDefined(self.rockspot)) {
    self.rockspot.owner = undefined;
  }
}