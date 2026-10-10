/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_3ae866a6dd08daf9.gsc
*************************************************/

#using script_2a8fc67f80783750;
#using script_3ae866a6dd08daf9;
#using scripts\common\devgui;
#using scripts\cp\cp_objectives;
#using scripts\cp\damagefeedback;
#using scripts\cp\equipment;
#using scripts\cp\killcam;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace laser_traps;

function main(trigger_name) {
  initsentrysettings();
  function_af78ce8adb2963e1();
  init_laser_trap();
  level thread init_laser_traps(trigger_name);
}

function init_laser_trap() {
  level.scripted_laser_func = &laser_func;
}

function load_laser_fx() {
  level._effect["vfx_laser_smoke"] = loadfx("vfx/iw8_cp/raid/vfx_cp_steampipe_exp.vfx");
  level._effect["vfx_laser_pointer"] = loadfx("vfx/iw8_cp/vfx_red_laser_cp.vfx");
  level._effect["vfx_laser_pointer_thermal"] = loadfx("vfx/iw8_cp/vfx_red_laser_cp_thermalonly.vfx");
  level._effect["vfx_laser_pointer_nvg"] = loadfx("vfx/jup/equipment/vfx_equip_trip_laser_nv.vfx");
  level._effect["vfx_laser_destroy"] = loadfx("vfx/iw8_cp/vfx_red_laser_cp_destroy.vfx");
  level._effect["vfx_laser_burn"] = loadfx("vfx/jup/equipment/vfx_equip_trip_laser_end.vfx");
  level._effect["vfx_c4_light"] = loadfx("vfx/iw9/cp/vfx_cp_c4_light.vfx");
  level._effect["vfx_turret_light"] = loadfx("vfx/iw9/cp/vfx_cp_turret_light.vfx");
  level._effect["vfx_c4_explode"] = loadfx("vfx/iw9/core/equipment/c4/vfx_equip_c4_gen_ch.vfx");
  level._effect["vfx_c4_light_5"] = loadfx("vfx/iw9/cp/vfx_cp_c4_light_0_5s.vfx");
  level._effect["vfx_turret_light_5"] = loadfx("vfx/iw9/cp/vfx_cp_turret_light_0_5s.vfx");
  level._effect["vfx_c4_light_175"] = loadfx("vfx/iw9/cp/vfx_cp_c4_light_1_75s.vfx");
  level._effect["vfx_turret_light_175"] = loadfx("vfx/iw9/cp/vfx_cp_turret_light_1_75s.vfx");
  level._effect["vfx_c4_light_2"] = loadfx("vfx/iw9/cp/vfx_cp_c4_light_2_0s.vfx");
  level._effect["vfx_turret_light_2"] = loadfx("vfx/iw9/cp/vfx_cp_turret_light_2_0s.vfx");
  level._effect["vfx_c4_light_3"] = loadfx("vfx/iw9/cp/vfx_cp_c4_light_3_0s.vfx");
  level._effect["vfx_turret_light_3"] = loadfx("vfx/iw9/cp/vfx_cp_turret_light_3_0s.vfx");
  level._effect["vfx_laser_destroy_nvg"] = loadfx("vfx/iw9/cp/vfx_red_laser_cp_nvgonly_die.vfx");
  level._effect["vfx_laser_destroy_end"] = loadfx("vfx/iw9/core/lasers/vfx_laser_nvg_end_die.vfx");
  level._effect["vfx_drone_explo"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_sm_dest_exp.vfx");
  level._effect["smoke_pipe"] = loadfx("vfx/iw8_cp/raid/vfx_cp_steampipe_exp.vfx");
  level._effect["vfx_bullet_impact"] = loadfx("vfx/test/tracey/bullet_impact.vfx");
  level._effect["vfx_blood_spurt"] = loadfx("vfx/test/tracey/blood_spurt_large.vfx");
  level._effect["vfx_blood_screen_right"] = loadfx("vfx/iw8/level/highway/vfx_blood_screen_right.vfx");
  level._effect["vfx_blood_screen_left"] = loadfx("vfx/iw8/level/highway/vfx_blood_screen_left.vfx");
  level._effect["vfx_illumination_flare_unlit"] = loadfx("vfx/iw8/level/embassy/vfx_illumination_flare_unlit.vfx");
  level._effect["vfx_illumination_flare"] = loadfx("vfx/iw8/level/embassy/vfx_illumination_flare.vfx");
  level._effect["vfx_illumination_flare_launch_trail"] = loadfx("vfx/iw8/level/embassy/vfx_illumination_flare_launch_trail.vfx");
  level._effect["vfx_cp_iw8_water_elec"] = loadfx("vfx/iw8_cp/elec/vfx_cp_iw8_water_elec.vfx");
}

function laser_func() {
  level endon("game_ended");
  spawn_pos = self.origin;

  if(self.ent tagexists("tag_laser")) {
    spawn_pos = self.ent gettagorigin("tag_laser");
  }

  trace = ray_trace(spawn_pos, spawn_pos + anglestoup(self.angles) * int(self.struct.height));
  self.laser_start_ent_thermal = create_tag_origin(spawn_pos, self);
  self.laser_reset_position = self.laser_start_ent_thermal.origin;
  self.laser_end_ent_thermal = create_tag_origin(trace["position"], self);
  self.laser_show_position = self.laser_end_ent_thermal.origin;
  self.fx_thermal_end = spawnfx(level._effect["vfx_laser_burn"], self.laser_show_position);
  triggerfx(self.fx_thermal_end);
  self.fx_thermal = playfxontagsbetweenclients(level._effect["vfx_laser_pointer_nvg"], self.laser_start_ent_thermal, "tag_origin", self.laser_end_ent_thermal, "tag_origin");
  thread cleanup_target_stats_thermal(self.fx_thermal);
}

function cleanup_target_stats(fx) {
  self endon("death");

  while(true) {
    result = waittill_any_return_4("cleanup_target", "delete_fx_between_points", "delete_trap", "death");

    if(isDefined(result) && (result == "delete_trap" || result == "delete_fx_between_points")) {
      if(isDefined(fx)) {
        fx delete();
      }

      self.ent delete();
      self.laser_end_ent delete();
      self.laser_start_ent delete();
      self notify("cleanup_target_thermal");

      if(isDefined(self)) {
        self delete();
      }
    }
  }
}

function cleanup_target_stats_thermal(fx) {
  self endon("death");
  self notify("cleanup_target_stats_thermal");
  self endon("cleanup_target_stats_thermal");

  while(true) {
    result = waittill_any_return_5("cleanup_target_nvg", "hide_laser", "show_laser", "trigger_alarm", "disable_trap_no_alarm");

    if(isDefined(result)) {
      if(result == "disable_trap_no_alarm") {
        playFX(level._effect["vfx_laser_destroy"], self.laser_start_ent_thermal.origin);
        fx delete();
        self.laser_end_ent_thermal delete();
        self.fx_thermal_end delete();
        self.laser_start_ent_thermal delete();

        if(isDefined(self)) {
          self delete();
        }
      }

      if(result == "trigger_alarm") {}

      if(result == "cleanup_target_nvg") {
        self.laser_start_ent_thermal playSound("recon_drone_explode");
        self.laser_end_ent_thermal playSound("recon_drone_explode");
        playFX(level._effect["vfx_laser_destroy"], self.laser_start_ent_thermal.origin);
        fx delete();
        self.laser_end_ent_thermal delete();
        self.fx_thermal_end delete();
        self.laser_start_ent_thermal delete();

        if(isDefined(self.ent)) {
          self.ent delete();
        }

        if(isDefined(self)) {
          self delete();
        }
      }

      if(result == "hide_laser") {
        playFX(level._effect["vfx_laser_destroy"], self.laser_start_ent_thermal.origin);
        fx delete();
      }

      if(result == "show_laser") {
        self.fx_thermal = playfxontagsbetweenclients(level._effect["vfx_laser_pointer_nvg"], self.laser_start_ent_thermal, "tag_origin", self.laser_end_ent_thermal, "tag_origin");
        thread cleanup_target_stats_thermal(self.fx_thermal);
      }
    }
  }
}

function follow_tag_laser_attach(sniper, laser_start_ent) {
  laser_start_ent endon("death");

  while(true) {
    var_5638c3c19559c7f0 = sniper gettagorigin("tag_flash");
    laser_start_ent.origin = var_5638c3c19559c7f0;
    waitframe();
  }
}

function create_tag_origin(spawn_pos, sniper) {
  tag_origin = spawn("script_model", spawn_pos);
  tag_origin setModel("tag_origin");
  tag_origin thread clean_up_think(tag_origin, sniper);
  return tag_origin;
}

function clean_up_think(tag_origin, sniper) {
  tag_origin endon("death");
  sniper waittill("death");
  tag_origin delete();
}

function init_laser_traps(trigger_name) {
  level endon("game_ended");
  wait 1;
  flag_wait("create_script_initialized");
  wait 1;

  if(!isDefined(trigger_name)) {
    assertmsg("<dev string:x1c>");
    return;
  }

  triggers = getEntArray(trigger_name, "targetname");

  foreach(trigger in triggers) {
    assertex(isDefined(trigger.target), "laser trigger with no targetted model");
    assertex(isDefined(trigger.script_noteworthy), "laser trigger with no noteworthy defined.");
    ent = getEnt(trigger.target, "targetname");
    ent.trigger = trigger;
    trigger.ent = ent;

    if(trigger.classname == "trigger_radius" || trigger.classname == "trigger_rotatable_radius") {
      trigger enablelinkTo();
    }

    trigger linkTo(ent);
    trigger initialize_laser_trap_entity(1);
    ent initialize_laser_trap_entity();
  }
}

function initialize_laser_trap_entity(istrigger) {
  if(!isDefined(level.laser_traps)) {
    level.laser_traps = [];
  }

  if(istrue(istrigger)) {
    if(isDefined(self.struct.script_groupname) && self.struct.script_groupname == "toggle") {
      self.current_state = 333;
      thread trap_toggle_logic();
    } else if(isDefined(self.struct.script_groupname) && self.struct.script_groupname == "toggle_fx") {
      thread laser_func();
      self.current_state = 69;
      toggle_fx_trap(96);
    } else {
      self.current_state = 0;
    }

    if(!isDefined(level.laser_traps[self.struct.script_groupname])) {
      level.laser_traps[self.struct.script_groupname] = [];
    }

    level.laser_traps[self.struct.script_groupname] = array_add(level.laser_traps[self.struct.script_groupname], self);
    thread trap_trigger_logic();
    return;
  }

  if(isDefined(self.trigger.struct.script_groupname) && self.trigger.struct.script_groupname == "toggle") {
    return;
  }

  if(isDefined(self.trigger.struct.script_groupname) && self.trigger.struct.script_groupname == "toggle_fx") {
    if(!istrue(level.var_8aca98661b1886b1)) {
      thread watch_for_damage_on_trap();
    }

    if(istrue(level.var_79928ec6a4845a9c)) {
      self makeusable();
      self setHintString(&"COOP_GAME_PLAY/DISABLE_TRAP");
      self sethintdisplayrange(120);
      self sethintdisplayfov(120);
      self setusefov(120);
      self setuserange(120);
      self sethintonobstruction("hide");
      self setuseholdduration("duration_medium");
      thread model_use_thread();
    }

    return;
  }

  self.v_start_pos = self.origin;
  self.v_end_pos = getStruct(self.target, "targetname").origin;
  collision = spawn("script_model", self.origin);
  collision dontinterpolate();
  collision.angles = self.angles;
  collision clonebrushmodeltoscriptmodel(getEnt("care_package_col", "targetname"));
  collision linkTo(self);
  self.collision = collision;
  self.current_state = 0;
}

function model_use_thread() {
  self notify("model_use_thread");
  self endon("model_use_thread");
  self endon("death");

  while(true) {
    self waittill("trigger", entity);

    if(!isPlayer(entity)) {
      continue;
    }

    if(isPlayer(entity)) {
      entity iprintln("<dev string:x41>");

      self.trigger notify("disable_trap_no_alarm");
      self makeunusable();
    }
  }
}

function watch_for_damage_on_trap() {
  self endon("death");
  self setCanDamage(1);
  self.health = 9999;
  self.maxhealth = 9999;
  self.var_abbaa2fc2b3da347 = 0;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(!isPlayer(attacker)) {
      continue;
    }

    if(meansofdeath == "MOD_GRENADE_SPLASH") {
      continue;
    }

    attacker thread scripts\cp\damagefeedback::updatedamagefeedback("hitturret", undefined, damage, 1);
    self.var_abbaa2fc2b3da347++;

    if(self.var_abbaa2fc2b3da347 < 2) {
      continue;
    }

    attacker iprintln("<dev string:x61>");

    self.health = 9999;
    self.maxhealth = 9999;
    playFX(level._effect["vfx_laser_destroy"], self.trigger.laser_start_ent_thermal.origin);
    playFX(level._effect["vfx_laser_destroy"], self.trigger.laser_end_ent_thermal.origin);

    if(isDefined(level.var_df3ad2237853744a)) {
      if(self[[level.var_df3ad2237853744a]]()) {
        self.trigger notify("cleanup_target_nvg");
      }

      continue;
    }

    self radiusdamage(self.trigger.laser_start_ent_thermal.origin, 256, 666, 133);
    self radiusdamage(self.trigger.laser_end_ent_thermal.origin, 256, 666, 133);
    self.trigger notify("cleanup_target_nvg");
  }
}

function removesuppressioneffectsaftertimeout(timeout) {
  self endon("death");

  if(isDefined(self.trigger)) {
    self.trigger endon("death");
  }

  self.trigger notify("hide_laser");
  wait timeout;
  self.trigger notify("show_laser");
}

function trap_trigger_logic(var_c0d7a5fb530d544a) {
  self notify("trap_trigger_logic");
  self endon("trap_trigger_logic");
  self endon("death");

  while(true) {
    self waittill("trigger", entity);

    if(self.struct.script_groupname != "toggle_fx") {
      if(self.current_state == 333) {
        continue;
      }
    }

    if(!isPlayer(entity) && !isai(entity)) {
      continue;
    }

    if(isPlayer(entity)) {
      entity iprintln("<dev string:x85>");

      if(isDefined(level.var_dd58fe315b085d35)) {
        self[[level.var_dd58fe315b085d35]](entity);
        continue;
      }

      entity push_players_back_and_deal_damage(entity);
      entity dodamage(entity.health + 10000, entity.origin);

      if(self.struct.script_groupname == "toggle_fx") {
        playFX(level._effect["vfx_laser_destroy"], self.laser_start_ent_thermal.origin);
        playFX(level._effect["vfx_laser_destroy"], self.laser_end_ent_thermal.origin);
        self radiusdamage(self.laser_start_ent_thermal.origin, 256, 666, 133);
        self radiusdamage(self.laser_end_ent_thermal.origin, 256, 666, 133);
      }

      self notify("cleanup_target_nvg");
      level notify("start_floor_spawners");
    }
  }
}

function trap_toggle_logic() {
  self notify("trap_toggle_logic");
  self endon("trap_toggle_logic");

  while(true) {
    wait 5;
    toggle_trap();
  }
}

function toggle_trap() {
  if(self.current_state == 333) {
    if(isDefined(self.smoke_fx)) {
      self.smoke_fx delete();
    }

    if(isDefined(self.distort_fx)) {
      self.distort_fx delete();
    }

    self.current_state = 666;
    playFX(level._effect["vfx_laser_smoke"], self.origin - (0, -8, 16), anglesToForward(self.angles), anglestoright(self.angles));
    childthread play_loop_sound_on_entity("fire_system_hiss");
    childthread scripts\engine\utility::playsoundonentity("fire_system_start");
    return;
  }

  self notify("stop sound" + "fire_system_hiss");
  self notify("stop sound" + "fire_system_start");
  self.current_state = 333;
}

function trap_toggle_fx_logic() {
  self endon("death");
  self notify("trap_toggle_fx_logic");
  self endon("trap_toggle_fx_logic");

  while(true) {
    level waittill("smoke_grenade_explosion", position, radius, duration, delay);

    if(isDefined(delay)) {
      wait delay;
    }

    if(distance2dsquared(position, self.origin) > squared(radius)) {
      continue;
    }

    toggle_fx_trap(96);
    wait duration;
    toggle_fx_trap(69);
  }
}

function toggle_fx_trap(state_override) {
  self endon("death");

  if(isDefined(self.laser_end_ent)) {
    self.laser_end_ent endon("death");
  }

  if(isDefined(state_override)) {
    if(state_override == 69) {
      self.current_state = 69;

      if(isDefined(self.laser_fx)) {
        self.laser_fx delete();
      }

      self.laser_end_ent moveTo(self.laser_reset_position, 0.05);
    } else {
      if(isDefined(self.laser_fx)) {
        self.laser_fx delete();
      }

      self.current_state = 96;
    }

    return;
  }

  if(self.current_state == 69) {
    if(isDefined(self.laser_fx)) {
      self.laser_fx delete();
    }

    self.current_state = 96;
    self.laser_end_ent moveTo(self.laser_show_position, 0.05);
    thread laser_func();
    return;
  }

  self.current_state = 69;

  if(isDefined(self.laser_fx)) {
    self.laser_fx delete();
  }

  self.laser_end_ent moveTo(self.laser_reset_position, 0.05);
}

function push_players_back_and_deal_damage(player) {
  dir = -1 * anglesToForward(player.angles);
  var_d01387bda9e91e50 = player getvelocity();
  var_adc4b2bf275805c7 = length2d(var_d01387bda9e91e50);

  if(var_adc4b2bf275805c7 == 0) {
    var_adc4b2bf275805c7 = 60;
  }

  if(var_adc4b2bf275805c7 < 60) {
    var_adc4b2bf275805c7 = 60;
  }

  var_e73621f0a50827ac = player getvelocity();
  var_e73621f0a50827ac = (var_e73621f0a50827ac[0], var_e73621f0a50827ac[1], 0);
  var_2fdce9f0da5412e0 = length2d(var_e73621f0a50827ac);

  if(var_2fdce9f0da5412e0 > 0) {
    var_3173030081735e94 = dir * var_adc4b2bf275805c7;
    var_80e3e9c318e99cf1 = var_e73621f0a50827ac + var_3173030081735e94;
    var_2297d1c3903888ed = length2d(var_80e3e9c318e99cf1);

    if(vectordot(var_80e3e9c318e99cf1, var_3173030081735e94) < 0) {
      right = vectorcross((0, 0, 1), dir);

      if(vectordot(right, var_e73621f0a50827ac) > 0) {
        var_2fdce9f0da5412e0 = length2d(var_e73621f0a50827ac);
        var_e73621f0a50827ac = right * var_2fdce9f0da5412e0;
      } else {
        left = right * -1;
        var_2fdce9f0da5412e0 = length2d(var_e73621f0a50827ac);
        var_e73621f0a50827ac = left * var_2fdce9f0da5412e0;
      }

      var_80e3e9c318e99cf1 = var_e73621f0a50827ac + var_3173030081735e94;
      var_adc4b2bf275805c7 = length2d(var_80e3e9c318e99cf1);
    } else {
      if(var_2fdce9f0da5412e0 > var_adc4b2bf275805c7) {
        var_adc4b2bf275805c7 = var_2fdce9f0da5412e0;
      }

      dir = vectorNormalize(var_80e3e9c318e99cf1);
    }
  }

  player knockback(dir, var_adc4b2bf275805c7);

  player iprintln("<dev string:xa6>");
}

function initsentrysettings() {
  level.sentrysettings["bs_laser"] = spawnStruct();
  level.sentrysettings["bs_laser"].health = 999999;
  level.sentrysettings["bs_laser"].maxhealth = 350;
  level.sentrysettings["bs_laser"].burstmin = 20;
  level.sentrysettings["bs_laser"].burstmax = 120;
  level.sentrysettings["bs_laser"].pausemin = 0.15;
  level.sentrysettings["bs_laser"].pausemax = 0.35;
  level.sentrysettings["bs_laser"].maxrange = 4000000;
  level.sentrysettings["bs_laser"].laserrange = 7562500;
  level.sentrysettings["bs_laser"].lockstrength = 2;
  level.sentrysettings["bs_laser"].sentrymodeon = "manual";
  level.sentrysettings["bs_laser"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["bs_laser"].ammo = 200;
  level.sentrysettings["bs_laser"].timeout = 999999;
  level.sentrysettings["bs_laser"].spinuptime = 0.65;
  level.sentrysettings["bs_laser"].overheattime = 8;
  level.sentrysettings["bs_laser"].cooldowntime = 0.1;
  level.sentrysettings["bs_laser"].fxtime = 0.3;
  level.sentrysettings["bs_laser"].streakname = "sentry_gun";

  if(getdvarint(@ "hash_94577b429c0e801", 1) != 0) {
    if(istrue(scripts\cp\weapon::player_has_nvg())) {
      level.sentrysettings["bs_laser"].weaponinfo = "laser_trap_nvg";
      level.sentrysettings["bs_laser"].playerweaponinfo = "laser_trap_nvg";
    } else {
      level.sentrysettings["bs_laser"].weaponinfo = "laser_trap_not_nvg";
      level.sentrysettings["bs_laser"].playerweaponinfo = "laser_trap_not_nvg";
    }
  } else {
    level.sentrysettings["bs_laser"].weaponinfo = "sentry_turret_mp";
    level.sentrysettings["bs_laser"].playerweaponinfo = "sentry_turret_mp";
  }

  level.sentrysettings["bs_laser"].scriptable = "ks_sentry_turret_mp";
  level.sentrysettings["bs_laser"].modelbasecover = "electronics_ir_laser_device_assembly_nogeo";
  level.sentrysettings["bs_laser"].modelbaseground = "electronics_ir_laser_device_assembly_nogeo";
  level.sentrysettings["bs_laser"].modeldestroyedcover = "electronics_ir_laser_device_assembly_nogeo";
  level.sentrysettings["bs_laser"].modeldestroyedground = "electronics_ir_laser_device_assembly_nogeo";
  level.sentrysettings["bs_laser"].placementhintstring = &"KILLSTREAKS_HINTS/SENTRY_GUN_PLACE";
  level.sentrysettings["bs_laser"].ownerusehintstring = &"KILLSTREAKS_HINTS/SENTRY_USE";
  level.sentrysettings["bs_laser"].otherusehintstring = &"KILLSTREAKS_HINTS/SENTRY_OTHER_USE";
  level.sentrysettings["bs_laser"].dismantlehintstring = &"KILLSTREAKS_HINTS/SENTRY_DISMANTLE";
  level.sentrysettings["bs_laser"].headicon = 1;
  level.sentrysettings["bs_laser"].teamsplash = "used_sentry_gun";
  level.sentrysettings["bs_laser"].destroyedsplash = "callout_destroyed_sentry_gun";
  level.sentrysettings["bs_laser"].shouldsplash = 1;
  level.sentrysettings["bs_laser"].votimeout = "sentry_shock_timeout";
  level.sentrysettings["bs_laser"].vodestroyed = "sentry_shock_destroy";
  level.sentrysettings["bs_laser"].scorepopup = "destroyed_sentry";
  level.sentrysettings["bs_laser"].lightfxtag = "tag_fx";
  level.sentrysettings["bs_laser"].iskillstreak = 1;
  level.sentrysettings["bs_laser"].headiconoffset = (0, 0, 75);

  if(isDefined(level.var_2184802e7b6495dd)) {
    [[level.var_2184802e7b6495dd]]();
  }

  namespace_84c374d417dc82cf::function_af78ce8adb2963e1();
}

function function_af78ce8adb2963e1() {
  level.sentrysettings["dungeon_laser"] = spawnStruct();
  level.sentrysettings["dungeon_laser"] = level.sentrysettings["bs_laser"];
  level.sentrysettings["dungeon_laser"].weaponinfo = "laser_trap_nvg_jup_dungeons";
  level.sentrysettings["dungeon_laser"].playerweaponinfo = "laser_trap_nvg_jup_dungeons";

  setdevdvarifuninitialized(@ "hash_69de6d4d9ba136d1", 0);
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:xc1>");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:xea>", "<dev string:x106>");
  scripts\common\devgui::function_fe953f000498048f();
}

function setup_sentry(var_804269875f5062f1, damage_type, turret_model, parent_struct, var_385e9c9e53753524, var_507ba3530ef8559e, time_delay) {
  sentrytype = ter_op(isDefined(var_507ba3530ef8559e), var_507ba3530ef8559e, "bs_laser");

  if(isDefined(var_385e9c9e53753524)) {
    sentrytype = var_385e9c9e53753524;
  }

  config = level.sentrysettings[sentrytype];
  turret = spawnturret("laser_trap", var_804269875f5062f1.origin, level.sentrysettings[sentrytype].weaponinfo);

  if(!isDefined(turret)) {
    assertmsg("laser_traps - turret spawn failed! Origin:" + var_804269875f5062f1.origin);
    return;
  }

  turret.team = "axis";

  if(!isDefined(var_804269875f5062f1.angles)) {
    var_804269875f5062f1.angles = (0, 0, 0);
  }

  turret.angles = var_804269875f5062f1.angles;
  turret.health = config.maxhealth;
  turret.maxhealth = config.maxhealth;
  turret.sentrytype = sentrytype;
  turret.turrettype = sentrytype;
  turret.damage_type = damage_type;
  turret.momentum = 0;
  turret.heatlevel = 0;
  turret.overheated = 0;
  turret.cooldownwaittime = 2;
  turret.maxrange = level.sentrysettings[sentrytype].maxrange;
  turret.laserrange = level.sentrysettings[sentrytype].laserrange;
  turret.owner = turret;
  var_804269875f5062f1.var_20868c2af60860fa = undefined;
  var_804269875f5062f1.var_d81ab2ce16e0a4d2 = undefined;

  if(isDefined(var_804269875f5062f1.script_oneway)) {
    if(is_equal(int(var_804269875f5062f1.script_oneway), 1)) {
      var_804269875f5062f1.var_20868c2af60860fa = 1;
    } else if(is_equal(int(var_804269875f5062f1.script_oneway), 2)) {
      var_804269875f5062f1.var_d81ab2ce16e0a4d2 = 1;
    }
  }

  if(isDefined(var_804269875f5062f1.radius)) {
    maxdistsq = var_804269875f5062f1.radius * var_804269875f5062f1.radius;
    turret.maxrange = int(maxdistsq - maxdistsq * 0.1);
    turret.laserrange = int(maxdistsq);
  }

  var_804269875f5062f1.turret = turret;
  var_804269875f5062f1.maxangle = 15;

  if(isDefined(var_804269875f5062f1.script_duration)) {
    var_804269875f5062f1.maxangle = int(var_804269875f5062f1.script_duration);
  }

  var_804269875f5062f1.var_d7a35fd5bd92cc60 = undefined;

  if(isDefined(var_804269875f5062f1.script_looping)) {
    var_804269875f5062f1.var_d7a35fd5bd92cc60 = int(var_804269875f5062f1.script_looping);
  }

  turret.sentry_struct = var_804269875f5062f1;
  turret.parent_struct = parent_struct;

  if(!isDefined(turret_model)) {
    turret_model = "electronics_ir_laser_device_assembly_rig_skeleton";
  }

  if(istrue(turret function_d1cb6967231a8e1d()) || istrue(turret function_b19f85f4a1d36e2b())) {
    turret_model = "electronics_ir_laser_device_vertical_rig_skeleton";
  }

  turret setModel(turret_model);

  if(istrue(turret function_d1cb6967231a8e1d())) {
    turret hidepart("tag_turret");
  }

  turret setturretteam("axis");
  turret makeunusable();
  turret setnodeploy(1);
  turret setautorotationdelay(0.2);
  turret maketurretinoperable();
  turret setleftarc(180);
  turret setrightarc(180);
  turret setbottomarc(50);
  turret settoparc(60);
  turret setconvergencetime(0.6, "pitch");
  turret setconvergencetime(0.6, "yaw");
  turret setconvergenceheightpercent(0.65);
  turret setdefaultdroppitch(-90);
  turret setturretmodechangewait(1);
  turret notsolid();
  turret scripts\cp_mp\emp_debuff::set_start_emp_callback(&sentryturret_empstarted);
  turret scripts\cp_mp\emp_debuff::set_clear_emp_callback(&sentryturret_empcleared);
  turret scripts\cp_mp\emp_debuff::allow_emp(0);

  if(!isDefined(level.killstreak_additional_targets)) {
    level.killstreak_additional_targets = [];
  }

  level.killstreak_additional_targets = array_add(level.killstreak_additional_targets, turret);

  if(!isDefined(level.var_ceef08cfb883a461)) {
    level.var_ceef08cfb883a461 = [];
  }

  level.var_ceef08cfb883a461 = array_add(level.var_ceef08cfb883a461, turret);
  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeon);
  turret scripts\cp_mp\emp_debuff::allow_emp(1);
  turret sentryturret_empupdate();
  turret laseron();
  turret thread function_42929a0d4354a323(time_delay);
  turret notify("lasers_started");
  turret.killcament = spawn("script_model", turret.origin);
  turret.killcament linkTo(turret, "TAG_AIM_ANIMATED", (0, 0, 0), (0, 0, 0));
  turret.killcament setModel("tag_origin");
  turret.killcament setscriptmoverkillcam("laser trap");
  return turret;
}

function sentryturret_empstarted(data) {
  sentryturret_empupdate();
}

function sentryturret_empcleared(isdeath) {
  if(isdeath) {
    return;
  }

  sentryturret_empupdate();
}

function sentryturret_empupdate() {
  if(scripts\cp_mp\emp_debuff::is_empd()) {
    self turretfiredisable();
    self setmode(level.sentrysettings[self.turrettype].sentrymodeoff);
    self laseroff();
    return;
  }

  self turretfireenable();
  self setmode(level.sentrysettings[self.turrettype].sentrymodeon);
}

function sentryturret_setinactive(turret) {
  turret laseroff();
  turret setdefaultdroppitch(30);
  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeoff);
}

function function_42929a0d4354a323(time_delay) {
  self endon("death");
  self endon("exit_idle");
  self endon("stop_idle_movement");

  if(isDefined(self.state) && self.state == "idle") {
    return;
  }

  self stopfiring();
  self.state = "idle";
  self notify("enter_idle");
  self notify("stop_shooting");

  if(!isDefined(self.targetent)) {
    self.targetent = spawn("script_model", self.origin);
    self.targetent setModel("tag_origin");
  }

  thread function_a9a8361dace89499();
  tag = "tag_laser";

  if(!hastag(self.model, tag)) {
    tag = "tag_turret";
  }

  loc = self gettagorigin(tag) + anglesToForward(self gettagangles(tag)) * 3000;
  self.targetent.origin = loc;
  self.targetent dontinterpolate();
  self settargetentity(self.targetent);

  if(isDefined(self.idle_func)) {
    self[[self.idle_func]]();
    return;
  }

  if(isDefined(self.sentry_struct.idle_func)) {
    self[[self.sentry_struct.idle_func]]();
    return;
  }

  sentry_origin = self.sentry_struct.origin;
  sentry_angles = self.sentry_struct.angles;
  var_878bae61aca86fc5 = anglesToForward(sentry_angles);
  var_a1b727d30fc62a0f = anglestoup(sentry_angles);
  var_77064c73f538ee42 = anglestoup(sentry_angles) * -1;
  var_1b77e17a42e2545b = anglestoleft(sentry_angles);
  var_6232855eba31163a = anglestoright(sentry_angles);
  maxangle = self.sentry_struct.maxangle;
  drawdist = 300;
  var_b716ed1e1043d49d = rotatepointaroundvector(var_a1b727d30fc62a0f, var_878bae61aca86fc5, maxangle);
  var_37acb3a5ef4e3396 = vectorNormalize(vectorcross(var_b716ed1e1043d49d, var_a1b727d30fc62a0f));
  var_13b2c03f423eb4f1 = vectorcross(var_37acb3a5ef4e3396, var_b716ed1e1043d49d);
  var_5a8f11024e7733a5 = axistoangles(var_b716ed1e1043d49d, var_37acb3a5ef4e3396, var_13b2c03f423eb4f1);
  var_f4feef348ddcce80 = rotatepointaroundvector(var_a1b727d30fc62a0f, var_878bae61aca86fc5, maxangle * -1);
  var_28a104b41542054b = vectorNormalize(vectorcross(var_f4feef348ddcce80, var_a1b727d30fc62a0f));
  var_71068ef94589e94a = vectorcross(var_28a104b41542054b, var_f4feef348ddcce80);
  var_6b5bd2eb86959740 = axistoangles(var_f4feef348ddcce80, var_28a104b41542054b, var_71068ef94589e94a);
  var_d5c157bf3efda129 = vectortoangles(var_a1b727d30fc62a0f);
  var_d11155af3ef22cb0 = vectortoangles(var_77064c73f538ee42);
  var_3c19d396e8243a45 = vectortoangles(var_878bae61aca86fc5);
  var_a0d15869f98efc85 = vectortoangles(var_1b77e17a42e2545b);
  var_10972f86bc3d391e = vectortoangles(var_6232855eba31163a);

  if(!isDefined(time_delay)) {
    time_delay = 10;
  }

  if(istrue(function_d1cb6967231a8e1d())) {
    function_64109b7cba5261eb(var_3c19d396e8243a45, time_delay, "fwd");
    function_60d6fd7d2cc9347a(var_3c19d396e8243a45);
    return;
  }

  if(istrue(function_b19f85f4a1d36e2b())) {
    if(!self.sentry_struct function_a0857113d8c32a2a()) {
      function_64109b7cba5261eb(var_3c19d396e8243a45, time_delay, "fwd");
      function_1df98bfa8297278b(var_3c19d396e8243a45);
      waitframe();

      while(true) {
        function_64109b7cba5261eb(var_d5c157bf3efda129, time_delay, "up");
        function_64109b7cba5261eb(var_3c19d396e8243a45, time_delay, "fwd");
        function_64109b7cba5261eb(var_d11155af3ef22cb0, time_delay, "down");
        function_64109b7cba5261eb(var_3c19d396e8243a45, time_delay, "fwd");
      }
    } else {
      function_64109b7cba5261eb(var_3c19d396e8243a45, time_delay, "fwd");
      function_60d6fd7d2cc9347a(var_3c19d396e8243a45);
    }

    return;
  }

  if(!self.sentry_struct function_a0857113d8c32a2a()) {
    sentry_origin = self gettagorigin(tag);
    newdir = anglesToForward(var_3c19d396e8243a45);
    newpos = sentry_origin + newdir * 2000;
    trace = scripts\engine\trace::ray_trace(sentry_origin, newpos, self);
    end = trace["position"];
    newposfinal = (newpos[0], newpos[1], sentry_origin[2]);
    vmidpoint = (sentry_origin + end) / 2;
    thread function_a890d51e917ad74(1, vmidpoint);
    waitframe();
    var_f7269954c1d2798a = 0;

    while(true) {
      if(!istrue(var_f7269954c1d2798a)) {
        var_f7269954c1d2798a = 1;
        function_c2659db9dbffda55(var_5a8f11024e7733a5, 0.2, "left");
      }

      function_c2659db9dbffda55(var_5a8f11024e7733a5, time_delay, "left");
      function_c2659db9dbffda55(var_3c19d396e8243a45, time_delay, "fwd");
      function_c2659db9dbffda55(var_6b5bd2eb86959740, time_delay, "right");
      function_c2659db9dbffda55(var_3c19d396e8243a45, time_delay, "fwd");
    }

    return;
  }

  tag = "tag_laser";

  if(!hastag(self.model, tag)) {
    tag = "tag_turret";
  }

  sentry_origin = self gettagorigin(tag);
  newdir = anglesToForward(var_3c19d396e8243a45);
  newpos = sentry_origin + newdir * 2000;
  trace = scripts\engine\trace::ray_trace(sentry_origin, newpos, self);
  end = trace["position"];
  newposfinal = (newpos[0], newpos[1], sentry_origin[2]);
  vmidpoint = (sentry_origin + end) / 2;
  self.targetent moveTo(newposfinal, 7, 1.5, 1.5);
  thread function_a890d51e917ad74(undefined, vmidpoint);
}

function function_b19f85f4a1d36e2b() {
  return istrue(self.sentry_struct.var_20868c2af60860fa);
}

function function_d1cb6967231a8e1d() {
  return istrue(self.sentry_struct.var_d81ab2ce16e0a4d2);
}

function function_60d6fd7d2cc9347a(var_3c19d396e8243a45) {
  tag = "tag_laser";

  if(!hastag(self.model, tag)) {
    tag = "tag_laser";
  }

  sentry_origin = self gettagorigin(tag);
  newdir = anglesToForward(var_3c19d396e8243a45);
  newpos = sentry_origin + newdir * 2000;
  trace = scripts\engine\trace::ray_trace(sentry_origin, newpos, self);
  end = trace["position"];
  newposfinal = newpos;
  vmidpoint = (sentry_origin + end) / 2;
  self.targetent moveTo(newposfinal, 7, 1.5, 1.5);
  thread function_a890d51e917ad74(undefined, vmidpoint);
}

function function_1df98bfa8297278b(var_3c19d396e8243a45) {
  tag = "tag_laser";

  if(!hastag(self.model, tag)) {
    tag = "tag_laser";
  }

  sentry_origin = self gettagorigin(tag);
  newdir = anglesToForward(var_3c19d396e8243a45);
  newpos = sentry_origin + newdir * 2000;
  trace = scripts\engine\trace::ray_trace(sentry_origin, newpos, self);
  end = trace["position"];
  newposfinal = newpos;
  vmidpoint = (sentry_origin + end) / 2;
  self.targetent moveTo(newposfinal, 7, 1.5, 1.5);
  thread function_a890d51e917ad74(undefined, vmidpoint);
}

function function_64109b7cba5261eb(angles, timehere, debug_text) {
  timehere = 4;
  tag = "tag_laser";
  newdir = anglesToForward(angles);
  sentry_origin = self gettagorigin(tag) + newdir * 2;
  newpos = sentry_origin + newdir * 666;
  newposfinal = (newpos[0], newpos[1], sentry_origin[2]);
  newposfinal = newpos;
  movetime = timehere * 0.7;
  var_93912c82c941f846 = timehere * 0.15;
  var_dbfa2182fe49a2af = timehere * 0.15;
  newup = anglestoup(angles);
  rotatetoangles = vectortoanglessafe(newdir, newup);
  self.targetent moveTo(newposfinal, movetime, var_93912c82c941f846, var_dbfa2182fe49a2af);

  if(getdvarint(@ "hash_69de6d4d9ba136d1", 0)) {
    if(isDefined(debug_text)) {
      announcement(debug_text);
    }

    level thread scripts\cp_mp\utility\debug_utility::drawline(self.origin, newposfinal, timehere, (1, 0, 0));
  }

  if(isDefined(self.sentry_struct.var_d7a35fd5bd92cc60)) {
    wait movetime;
    return;
  }

  wait timehere;
}

function function_c2659db9dbffda55(angles, timehere, debug_text) {
  if(!isDefined(timehere)) {
    timehere = 4;
  }

  tag = "bi_base";

  if(!hastag(self.model, tag)) {
    tag = "tag_turret";
  }

  sentry_origin = self gettagorigin(tag);
  newdir = anglesToForward(angles);
  newpos = sentry_origin + newdir * 2000;
  newposfinal = (newpos[0], newpos[1], sentry_origin[2]);
  movetime = timehere * 0.7;
  var_93912c82c941f846 = timehere * 0.15;
  var_dbfa2182fe49a2af = timehere * 0.15;
  newup = anglestoup(angles);
  rotatetoangles = vectortoanglessafe(newdir, newup);
  self.targetent moveTo(newposfinal, movetime, var_93912c82c941f846, var_dbfa2182fe49a2af);

  if(getdvarint(@ "hash_69de6d4d9ba136d1", 0)) {
    if(isDefined(debug_text)) {
      announcement(debug_text);
    }

    level thread scripts\cp_mp\utility\debug_utility::drawline(self.origin, newposfinal, timehere, (1, 0, 0));
  }

  if(isDefined(self.sentry_struct.var_d7a35fd5bd92cc60)) {
    wait movetime;
    return;
  }

  wait timehere;
}

function function_2cc59ea2a67bd2f4(struct, turrets) {
  struct.hint_obj = spawn("script_model", struct.origin);
  struct.hint_obj.angles = struct.angles;

  if(isDefined(level.var_9bf3c4b5835fa48f)) {
    struct.hint_obj setModel(level.var_9bf3c4b5835fa48f);
    struct.fx = spawn_tag_origin(struct.origin, struct.angles);
    struct.hint_obj.screenfx = level._effect["vfx_shdb_killstreak_tablet_02_lnd"];
    wait 1;
    playFXOnTag(struct.hint_obj.screenfx, struct.fx, "tag_origin");
  } else if(function_240f7f4e57340e8f()) {
    struct.hint_obj setModel("offhand_2h_wm_c4_v0_jup_cp");
  } else {
    struct.hint_obj setModel("offhand_2h_wm_c4_v0");
  }

  struct.hint_obj.turret_structs = getStructArray(struct.target, "targetname");
  struct.hint_obj.parent_struct = struct;
  struct.hint_obj makeusable();
  hintstring = &"COOP_GAME_PLAY/DISABLE_TRAP";
  struct.hint_obj setHintString(hintstring);
  struct.hint_obj setCursorHint("HINT_BUTTON");
  struct.hint_obj sethintdisplayrange(256);
  struct.hint_obj sethintdisplayfov(80);
  struct.hint_obj setuserange(96);
  struct.hint_obj setusefov(50);

  if(is_equal(struct.script_parameters, "show_on_obstruct")) {
    struct.hint_obj sethintonobstruction("show");
  } else {
    struct.hint_obj sethintonobstruction("hide");
  }

  struct.hint_obj setuseholdduration("duration_short");
  struct.hint_obj thread function_2de9d0204a3afb2e(struct);
  thread function_52c16ddca816e35f(struct, turrets);
  thread function_fa30749284648339(struct, turrets);
  return struct.hint_obj;
}

function function_fa30749284648339(struct, turrets) {
  wait 2;

  if(function_ee8a913e5baf0c5d()) {
    struct.hint_obj thread function_e071eff8292be8d4();

    foreach(turret in turrets) {
      turret thread function_e071eff8292be8d4(struct.hint_obj, 1);
    }
  }
}

function function_1b0d0f614ddf4a43() {
  self endon("disconnect");
  self endon("end_irlaser_hints");
  self notify("show_irlaser_hint");
  self endon("show_irlaser_hint");
  level endon("kill_irlasertraps_thread");

  while(!isDefined(level.var_b39eb382281f2d25)) {
    waitframe();
  }

  ent = level.var_b39eb382281f2d25;
  player = self;

  if(!isDefined(self.var_ad598507b33fa7ee)) {
    self.var_ad598507b33fa7ee = 1;
  }

  ent.var_9e9d858ab478c9d3 = "irlaser_" + self.var_ad598507b33fa7ee;
  self notify("show_irlaser_hint" + ent.var_9e9d858ab478c9d3);
  self endon("show_irlaser_hint" + ent.var_9e9d858ab478c9d3);

  if(!isDefined(level.var_93c0ce22b61e1683)) {
    level.var_93c0ce22b61e1683 = [];
  }

  level.var_93c0ce22b61e1683[ent.var_9e9d858ab478c9d3] = 0;
  self.var_ad598507b33fa7ee++;
  player.var_2af69b114646dc71 = 0;

  while(true) {
    if(function_eac0cd99c9c6d8ee() == "spotted") {
      wait 2;
      continue;
    }

    if(self istouching(ent)) {
      if(self isnightvisionon()) {
        wait 3;
        continue;
      }

      if(istrue(player.var_4935c7889506b68c)) {
        wait 3;
        continue;
      }

      if(player.var_2af69b114646dc71 >= 2) {
        return;
      }

      var_5d149987bb3c462 = function_8117dbc7d87d715d(player);

      if(!isDefined(var_5d149987bb3c462)) {
        wait 3;
        continue;
      }

      if(!istrue(level.var_93c0ce22b61e1683[ent.var_9e9d858ab478c9d3])) {
        level.var_93c0ce22b61e1683[ent.var_9e9d858ab478c9d3] = 1;
        num = randomintrange(1, 8);
        player.var_4935c7889506b68c = 1;
        player.var_2af69b114646dc71++;

        switch (num) {
          case 1:
            self sethudtutorialmessage(&"COOP_GAME_PLAY/NVG_HINT", 1);
            break;
          case 2:
            self sethudtutorialmessage(&"COOP_GAME_PLAY/NVG_HINT", 1);
            break;
          case 3:
            self sethudtutorialmessage(&"COOP_GAME_PLAY/NVG_HINT", 1);
            break;
          case 4:
            self sethudtutorialmessage(&"COOP_GAME_PLAY/NVG_HINT", 1);
            break;
          case 5:
            self sethudtutorialmessage(&"COOP_GAME_PLAY/NVG_HINT", 1);
            break;
          case 6:
            self sethudtutorialmessage(&"COOP_GAME_PLAY/NVG_HINT", 1);
            break;
          case 7:
            self sethudtutorialmessage(&"COOP_GAME_PLAY/NVG_HINT", 1);
            break;
          default:
            self sethudtutorialmessage(&"COOP_GAME_PLAY/NVG_HINT", 1);
            break;
        }

        ent thread function_d522dbaebcb26e26(16 * player.var_2af69b114646dc71, self);
      }
    } else if(istrue(level.var_93c0ce22b61e1683[ent.var_9e9d858ab478c9d3])) {
      level.var_93c0ce22b61e1683[ent.var_9e9d858ab478c9d3] = 0;
    }

    wait 3;
  }
}

function function_8117dbc7d87d715d(player) {
  if(!isDefined(level.var_7b5771f0d3e048a0)) {
    return undefined;
  }

  var_d593621dd76b812c = getclosest(player.origin, level.var_7b5771f0d3e048a0, 96);

  if(isDefined(var_d593621dd76b812c)) {
    return var_d593621dd76b812c;
  }

  foreach(struct in level.var_7b5771f0d3e048a0) {
    if(player math::point_in_fov(struct.origin)) {
      return struct;
    }

    foreach(turret in struct.turrets) {
      if(player math::point_in_fov(turret.soundorg.origin)) {
        return turret.soundorg;
      }

      if(player scripts\engine\trace::can_see_origin(turret.origin)) {
        return turret;
      }
    }
  }
}

function function_d522dbaebcb26e26(delay, player) {
  self endon("end_irlaser_hints");
  player waittill_any_timeout_1(delay / 3, "night_vision_on");
  player clearhudtutorialmessage();
  player waittill_any_timeout_1(delay / 6, "night_vision_on");
  player.var_4935c7889506b68c = undefined;
  level.var_93c0ce22b61e1683[self.var_9e9d858ab478c9d3] = undefined;
}

function function_2de9d0204a3afb2e(parentstruct) {
  self endon("death");

  if(getdvarint(@ "hash_5820cd337a0495f5") != 0) {
    return;
  }

  self setCanDamage(1);
  self.health = 9999;
  self.maxhealth = 9999;
  self.var_abbaa2fc2b3da347 = 0;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(!isPlayer(attacker)) {
      continue;
    }

    if(meansofdeath == "MOD_GRENADE_SPLASH") {
      if(damage >= 160) {
        self.var_abbaa2fc2b3da347++;
      }
    }

    attacker thread scripts\cp\damagefeedback::updatedamagefeedback("hitturret", undefined, damage, 1);
    self.var_abbaa2fc2b3da347++;

    if(self.var_abbaa2fc2b3da347 < 2) {
      continue;
    }

    self.health = 9999;
    self.maxhealth = 9999;
    defuse_struct = parentstruct;
    function_fab50c852e0e8e32(defuse_struct, attacker);

    foreach(turret in defuse_struct.turrets) {
      if(!turret.sentry_struct function_a0857113d8c32a2a()) {
        turret function_d33f98412123374(1);
      } else {
        turret function_d33f98412123374();
      }

      thread function_277b35006fab38dd(turret, attacker);
    }

    if(isDefined(self)) {
      if(function_ee8a913e5baf0c5d()) {
        defuse_struct.hint_obj thread function_876bc60d7ad75112();
      }

      playFX(level._effect["vfx_c4_explode"], self.origin);
      waittillframeend();
      self delete();
    }

    return;
  }
}

function function_ee8a913e5baf0c5d() {
  if(isDefined(level.var_9bf3c4b5835fa48f)) {
    return false;
  }

  if(getdvarint(@ "hash_7693c920bebdb71b", 1) != 0) {
    return true;
  }

  return false;
}

function function_53dbc1c223362f47() {
  if(getdvarint(@ "hash_2648c1c97bdedf8c", 0) != 0) {
    return true;
  }

  return false;
}

function function_52c16ddca816e35f(struct, turrets) {
  struct.hint_obj endon("death");

  while(true) {
    struct.hint_obj waittill("trigger", player);

    if(isPlayer(player)) {
      if(function_240f7f4e57340e8f()) {
        level thread function_b2bcaab3f4eef8f6(struct, player);
      } else {
        struct.hint_obj makeunusable();

        if(!isDefined(level.var_9bf3c4b5835fa48f)) {
          level thread namespace_3bbec94305f740f0::function_91bdcd29d2bcb28(struct, player);
        } else {
          killfxontag(struct.hint_obj.screenfx, struct.fx, "tag_origin");
        }
      }

      playsoundatpos(struct.origin, "cp_laser_disable");

      foreach(turret in turrets) {
        namespace_84c374d417dc82cf::sentryturret_setinactive(turret);
        playFX(level._effect["vfx_laser_destroy_nvg"], turret.origin);
        start = turret gettagorigin("tag_laser");
        trace = scripts\engine\trace::ray_trace(start, turret.targetent.origin);
        end = trace["position"];
        playFX(level._effect["vfx_laser_destroy_end"], start);
        playFX(level._effect["vfx_laser_destroy_end"], end);
        turret setmode("sentry_offline");

        if(function_ee8a913e5baf0c5d()) {
          turret thread function_571c0f2116929a45();
        }

        turret notify("stop_idle_movement");

        if(!turret.sentry_struct function_a0857113d8c32a2a()) {
          turret function_d33f98412123374(1);
        } else {
          turret function_d33f98412123374();
        }

        if(function_53dbc1c223362f47()) {
          if(isDefined(turret.targetent)) {
            turret.targetent delete();
          }

          turret delete();
        }
      }

      if(function_ee8a913e5baf0c5d()) {
        struct.hint_obj thread function_876bc60d7ad75112();
      }

      flag_set("traps_defused_" + struct.script_noteworthy);

      if(!function_240f7f4e57340e8f()) {
        struct.hint_obj delete();
      }

      return;
    }
  }
}

function private function_14fc08d9f4820185(script_index) {
  if(isstring(script_index)) {
    if(script_index == "0.5") {
      return 1;
    } else if(script_index == "1.75") {
      return 2;
    } else if(script_index == "2") {
      return 3;
    } else if(script_index == "3") {
      return 4;
    }
  } else if(isint(script_index)) {
    return script_index;
  }

  return 0;
}

function function_876bc60d7ad75112() {
  if(isDefined(self.parent_struct.script_index)) {
    switch (function_14fc08d9f4820185(self.parent_struct.script_index)) {
      case 1:
        stopFXOnTag(level._effect["vfx_c4_light_5"], self, "tag_fx");
        break;
      case 2:
        stopFXOnTag(level._effect["vfx_c4_light_175"], self, "tag_fx");
        break;
      case 3:
        stopFXOnTag(level._effect["vfx_c4_light_2"], self, "tag_fx");
        break;
      case 4:
        stopFXOnTag(level._effect["vfx_c4_light_3"], self, "tag_fx");
        break;
    }
  }
}

function function_571c0f2116929a45() {
  if(isDefined(self.parent_struct.script_index)) {
    switch (function_14fc08d9f4820185(self.parent_struct.script_index)) {
      case 1:
        stopFXOnTag(level._effect["vfx_turret_light_5"], self, "tag_fx");
        break;
      case 2:
        stopFXOnTag(level._effect["vfx_turret_light_175"], self, "tag_fx");
        break;
      case 3:
        stopFXOnTag(level._effect["vfx_turret_light_2"], self, "tag_fx");
        break;
      case 4:
        stopFXOnTag(level._effect["vfx_turret_light_3"], self, "tag_fx");
        break;
    }
  }
}

function function_378a45d52d6ec58(player, start, end, should_detonate) {
  level endon("game_ended");
  self endon("death");
  self endon("stop_idle_movement");

  if(getdvarint(@ "hash_69cb90d22e939f4f", 0) == 0 || getdvarint(@ "hash_69cb90d22e939f4f", 0) == 2) {
    if(!istrue(should_detonate)) {
      var_f5709ff014fb0607 = self[[self.parent_struct.var_208398798bfa4135]]();

      if(istrue(var_f5709ff014fb0607)) {
        return 0;
      }
    }

    if(isDefined(self.parent_struct.var_a92e83b5bd4bfdd1)) {
      self[[self.parent_struct.var_a92e83b5bd4bfdd1]]();
    }

    defuse_struct = self.parent_struct;

    if(istrue(should_detonate)) {
      if(isDefined(player) && isPlayer(player)) {
        if(player isufo()) {
          return 0;
        }

        if(!function_240f7f4e57340e8f()) {
          player.var_230a3287f9ad2965 = 1;
        }

        player.shouldskipdeathsshield = 1;
      }
    }

    playsoundatpos(defuse_struct.origin, "cp_laser_trigger");
    time = lookupsoundlength("cp_laser_trigger") * 0.001;

    if(function_d416ac98347de9cf()) {
      self setturretteam("allies");

      if(!isPlayer(player)) {
        if(isDefined(player.owner)) {
          player = player.owner;
        }
      }

      self setturretowner(player);
      player.nocorpse = 1;
      player.skipcorpse = 1;
    }

    wait time;

    if(istrue(should_detonate)) {
      if(function_240f7f4e57340e8f()) {
        var_9ad84e4cee9ffa58 = 40;
        var_33af5852c130c934 = 10;
        var_338b4652c10826e6 = 5;
      } else {
        var_9ad84e4cee9ffa58 = 384;
        var_33af5852c130c934 = 666;
        var_338b4652c10826e6 = 333;
      }

      foreach(turr in defuse_struct.turrets) {
        self radiusdamage(turr.soundorg.origin, var_9ad84e4cee9ffa58, var_33af5852c130c934, var_338b4652c10826e6, self, "MOD_EXPLOSIVE", "frag_grenade_mp");
      }

      function_fab50c852e0e8e32(defuse_struct, player);

      if(isPlayer(player)) {
        thread namespace_3bbec94305f740f0::function_3e2f7fdfd94f71ba(player);
      }
    }

    level notify("trigger_reinforcements_if_applicable");

    if(!function_d416ac98347de9cf()) {
      playFX(level._effect["vfx_laser_destroy_nvg"], start);
      playFX(level._effect["vfx_laser_destroy_end"], start);
      playFX(level._effect["vfx_laser_destroy_nvg"], end);
      playFX(level._effect["vfx_laser_destroy_end"], end);
    }

    if(!function_d416ac98347de9cf()) {
      foreach(turret in defuse_struct.turrets) {
        if(!turret.sentry_struct function_a0857113d8c32a2a()) {
          turret function_d33f98412123374(1);
        } else {
          turret function_d33f98412123374();
        }

        if(self != turret) {
          thread function_277b35006fab38dd(turret);
        }
      }

      if(isDefined(defuse_struct.hint_obj)) {
        if(function_ee8a913e5baf0c5d()) {
          defuse_struct.hint_obj thread function_876bc60d7ad75112();
        }

        playFX(level._effect["vfx_c4_explode"], defuse_struct.hint_obj.origin);
        defuse_struct.hint_obj delete();
      }

      thread function_277b35006fab38dd(self);
      return 1;
    }

    self setturretowner(undefined);
    self setturretteam("axis");
    self laseron();

    if(scripts\cp\utility::function_aae723485e3b0e9d()) {
      if(isDefined(level.var_f107bd5b4c54277e)) {
        thread[[level.var_f107bd5b4c54277e]]();
      }
    }

    return 0;
  }
}

function function_a9a8361dace89499() {
  level endon("game_ended");
  self endon("death");
  self endon("stop_idle_movement");
  flag_wait("player_spawned_with_loadout");
  wait 2;
  var_4a5d9d7667048bf3 = scripts\engine\trace::create_character_contents();
  var_71fcc381ba289efb = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 1);
  should_detonate = isDefined(self.parent_struct.var_208398798bfa4135) ? 0 : 1;

  if(scripts\cp\utility::function_aae723485e3b0e9d()) {
    var_4a5d9d7667048bf3 = scripts\engine\trace::create_contents(1, undefined, undefined, undefined, undefined, 1);
  }

  while(true) {
    start = self gettagorigin("tag_laser");
    nearby_players = sortbydistancecullbyradius(level.players, start, 1024);

    if(nearby_players.size == 0) {
      waitframe();
      continue;
    }

    all_ai = getaiarray();
    trace = scripts\engine\trace::ray_trace(start, self.targetent.origin, all_ai, var_71fcc381ba289efb);

    if(isDefined(trace["entity"]) && trace["hittype"] == "hittype_entity") {
      var_2056ee644f4c232a = trace["entity"] scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp\utility::function_aae723485e3b0e9d() && isDefined(level.var_f107bd5b4c54277e);

      if(isPlayer(trace["entity"]) || istrue(var_2056ee644f4c232a)) {
        player = trace["entity"];
        detonated = function_378a45d52d6ec58(player, start, self.targetent.origin, should_detonate);

        if(istrue(detonated)) {
          return;
        }
      }
    }

    end = trace["position"];
    gooddistsq = lengthsquared(start - end);
    trace = scripts\engine\trace::ray_trace(start, end, all_ai, var_4a5d9d7667048bf3);

    if(isDefined(trace["entity"]) && trace["hittype"] == "hittype_entity") {
      var_2056ee644f4c232a = trace["entity"] scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp\utility::function_aae723485e3b0e9d() && isDefined(level.var_f107bd5b4c54277e);

      if(isPlayer(trace["entity"]) || istrue(var_2056ee644f4c232a)) {
        player = trace["entity"];

        if(!var_2056ee644f4c232a) {
          eyepos = player getEye();

          if(trace["position"][2] <= eyepos[2]) {
            detonated = function_378a45d52d6ec58(player, start, end, should_detonate);

            if(istrue(detonated)) {
              return;
            }
          }
        } else {
          detonated = function_378a45d52d6ec58(player, start, end, should_detonate);

          if(istrue(detonated)) {
            return;
          }
        }
      }
    }

    waitframe();
  }
}

function function_277b35006fab38dd(turret, attacker) {
  turret playSound("recon_drone_explode");

  if(function_ee8a913e5baf0c5d()) {
    turret thread function_571c0f2116929a45();
  }

  namespace_84c374d417dc82cf::sentryturret_setinactive(turret);
  turret laseroff();
  turret notify("stop_idle_movement");

  if(isDefined(turret.parent_struct) && istrue(turret.parent_struct.var_ac53b80788c2ec3d)) {
    if(turret isscriptable()) {
      turret setscriptablepartstate("explode", "violent", 1);
    }

    if(isDefined(attacker) && isPlayer(attacker) && !isalive(attacker) && scripts\cp\killcam::function_3f8b7ecacb8eb472(level.var_51c1068f1991312e)) {
      level waittill("player_killcam_over");
    }

    turret delete();
  }
}

function function_a0857113d8c32a2a() {
  if(isDefined(self.script_groupname) && self.script_groupname == "nomove") {
    return true;
  }

  return false;
}

function function_e071eff8292be8d4(hintobj, var_7cdbe41e37064ddb) {
  self endon("death");
  pos = self gettagorigin("tag_fx");

  if(istrue(var_7cdbe41e37064ddb)) {
    self endon("stop_idle_movement");

    if(isDefined(hintobj.parent_struct.script_index)) {
      switch (function_14fc08d9f4820185(hintobj.parent_struct.script_index)) {
        case 1:
          playFXOnTag(level._effect["vfx_turret_light_5"], self, "tag_fx");
          break;
        case 2:
          playFXOnTag(level._effect["vfx_turret_light_175"], self, "tag_fx");
          break;
        case 3:
          playFXOnTag(level._effect["vfx_turret_light_2"], self, "tag_fx");
          break;
        case 4:
          playFXOnTag(level._effect["vfx_turret_light_3"], self, "tag_fx");
          break;
      }
    }

    return;
  }

  if(isDefined(self.parent_struct.script_index)) {
    switch (function_14fc08d9f4820185(self.parent_struct.script_index)) {
      case 1:
        playFXOnTag(level._effect["vfx_c4_light_5"], self, "tag_fx");
        break;
      case 2:
        playFXOnTag(level._effect["vfx_c4_light_175"], self, "tag_fx");
        break;
      case 3:
        playFXOnTag(level._effect["vfx_c4_light_2"], self, "tag_fx");
        break;
      case 4:
        playFXOnTag(level._effect["vfx_c4_light_3"], self, "tag_fx");
        break;
    }
  }
}

function function_a890d51e917ad74(var_f095df44cb4d44c3, var_b1912d395068cf48) {
  self endon("death");
  wait 5;

  if(isDefined(var_b1912d395068cf48) && isvector(var_b1912d395068cf48)) {
    self.soundorg = spawn("script_model", var_b1912d395068cf48);
  } else {
    self.soundorg = spawn("script_model", self.origin);
  }

  self.soundorg setModel("tag_origin");
  waitframe();

  if(!istrue(var_f095df44cb4d44c3)) {
    self.soundorg playLoopSound("cp_laser_idle");
    return;
  }

  self.soundorg linkTo(self, "tag_aim_pivot");
  self.soundorg playLoopSound("cp_laser_mvmt");
}

function function_d33f98412123374(var_f095df44cb4d44c3) {
  if(!isDefined(self.soundorg)) {
    return;
  }

  if(!istrue(var_f095df44cb4d44c3)) {
    self.soundorg stoploopsound("cp_laser_idle");
  } else {
    self.soundorg stoploopsound("cp_laser_mvmt");
  }

  self.soundorg delete();
}

function function_d416ac98347de9cf() {
  return istrue(level.var_608454029f3370f2);
}

function function_4855a66011f5974b(structs, var_4d11817a3622efdf, var_43c554793a6e16d3, var_d55ece6d49e05425) {
  if(!isDefined(var_4d11817a3622efdf)) {
    var_4d11817a3622efdf = 1;
  }

  if(!isDefined(var_43c554793a6e16d3)) {
    var_43c554793a6e16d3 = 1;
  }

  if(!isDefined(var_d55ece6d49e05425)) {
    var_d55ece6d49e05425 = 1;
  }

  foreach(str in structs) {
    str.turrets = [];
    laser_structs = getStructArray(str.target, "targetname");

    foreach(laser_struct in laser_structs) {
      turret = setup_sentry(laser_struct, undefined, undefined, str, "dungeon_laser");
      str.turrets = array_add(str.turrets, turret);

      if(!var_4d11817a3622efdf) {
        turret hideallparts();
        continue;
      }

      if(turret isscriptable()) {
        turret setscriptablepartstate("visibility", "show", 1);
      }
    }

    str.var_1850e5fe23b4a98b = var_43c554793a6e16d3;
    str.var_ac53b80788c2ec3d = var_d55ece6d49e05425;
    thread function_2cc59ea2a67bd2f4(str, str.turrets);
  }
}

function function_fab50c852e0e8e32(defuse_struct, attacker) {
  if(function_240f7f4e57340e8f()) {
    var_292c3675e17d6e35 = 256;
    var_68d9e85d794db855 = 230;
    var_68fcd25d7973cfab = 30;
  } else {
    var_292c3675e17d6e35 = 384;
    var_68d9e85d794db855 = 666;
    var_68fcd25d7973cfab = 333;
  }

  self playSound("cp_laser_expl");
  self radiusdamage(defuse_struct.origin, var_292c3675e17d6e35, var_68d9e85d794db855, var_68fcd25d7973cfab, self, "MOD_EXPLOSIVE", "frag_grenade_mp");
  playrumbleonposition("grenade_rumble", defuse_struct.origin);
  earthquake(0.45, 0.7, defuse_struct.origin, 800);
  playFX(getfx("claymore_explode"), self.origin);
  nearby_ai = getaiarrayinradius(self.origin, 2048, "axis");

  foreach(ai in nearby_ai) {
    ai aieventlistenerevent("combat", attacker, self.origin);
  }

  waitframe();
}

function function_b2bcaab3f4eef8f6(defuse_struct, player) {
  level endon("game_ended");
  defuse_struct.hint_obj.owner = player;
  defuse_struct.hint_obj.weapon_name = "jup_c4_mp";
  pickupent = spawnStruct();
  pickupent.scriptablename = "brloot_offhand_c4";
  pickupent.equipname = level.br_pickups.br_equipname[pickupent.scriptablename];
  pickupent.maxcount = player scripts\cp_mp\equipment::getequipmentmaxammo(pickupent.equipname);
  pickupent.count = 1;
  pickupent.origin = defuse_struct.origin;
  pickupent.isstuck = 1;
  defuse_struct.hint_obj thread scripts\cp\equipment::makeexplosiveusabletag("tag_use", 0, undefined, pickupent);
  defuse_struct.hint_obj setCursorHint("HINT_BUTTON");

  if(istrue(defuse_struct.var_1850e5fe23b4a98b)) {
    level thread function_699c8edefecc8612(defuse_struct);
  }
}

function function_699c8edefecc8612(defuse_struct) {
  defuse_struct endon("death");
  defuse_struct.hint_obj waittill("pickup_equipment_success");

  foreach(turret in defuse_struct.turrets) {
    turret delete();
  }
}