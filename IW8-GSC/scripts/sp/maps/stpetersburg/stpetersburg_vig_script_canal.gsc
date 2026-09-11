/**************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\stpetersburg\stpetersburg_vig_script_canal.gsc
**************************************************************************/

function canal_vig_init() {
  scripts\engine\utility::flag_init("car_wait_here");
  scripts\engine\utility::flag_init("flag_head_to_bridge");
  scripts\engine\utility::flag_init("flag_out_window");
  scripts\engine\utility::flag_init("flag_across_bridge");
  scripts\engine\utility::flag_init("flag_car_crashed");
  scripts\engine\utility::flag_init("flag_clean_up_canal_ai");
  scripts\engine\utility::flag_init("flag_can_street_civs_flee");
  scripts\engine\utility::flag_init("flag_parent_child_flee_start");
  scripts\engine\utility::flag_init("flag_canal_ambulance_stop");
  level._effect["vfx_steam"] = loadfx("vfx/iw8/level/townhouse/vfx_alley_steam_billow.vfx");
}

function canal_vig_start() {
  thread car_zooms_past_handler();
  thread canal_traffic();
  thread fakeactor_cross_canal_runners();
  thread canal_civs_onlookers_handler();
  thread canal_civs_flee_parent_child();
  thread canal_civs_flee_handler();
  thread canal_background_fakecivs();
}

function canal_civs_onlookers_handler() {
  var0 = scripts\engine\sp\utility::spawn_targetname("can_street_onlookers_civ02", 1);
  var1 = scripts\engine\sp\utility::spawn_targetname("can_street_onlookers_civ03", 1);
  var2 = [var0, var1];
  var3 = scripts\engine\utility::getStruct("can_street_onlookers_org", "targetname");
  var4 = scripts\engine\utility::getStruct("can_street_onlookers_org2", "targetname");
  thread canal_civs_onlookers_behavior(var0, var3);
  thread canal_civs_onlookers_behavior(var1, var3);
  scripts\engine\sp\utility::trigger_wait_targetname("flag_across_bridge");
  var2 = scripts\engine\utility::array_removedead_or_dying(var2);
  scripts\engine\utility::array_delete(var2);
}

function canal_civs_onlookers_behavior(var0, var1) {
  self endon("death");
  self endon("entitydeleted");
  self.allowdeath = 1;
  var0 scripts\common\anim::anim_first_frame_solo(self, "canal_civs_onlookers");
  scripts\engine\utility::flag_wait("flag_grenade_bypass");
  scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var0 scripts\common\anim::anim_single_solo_run(self, "canal_civs_onlookers");
  var1 scripts\sp\anim::anim_reach_solo(self, "canal_civs_onlookers_idle2");
  var1 scripts\common\anim::anim_loop_solo(self, "canal_civs_onlookers_idle2");
}

function canal_civs_flee_car() {
  var0 = scripts\engine\sp\utility::spawn_targetname("can_street_onlookers_civ04", 1);
  var1 = scripts\engine\sp\utility::spawn_targetname("can_street_onlookers_civ05", 1);
  var2 = scripts\engine\sp\utility::spawn_targetname("can_street_onlookers_civ06", 1);
  thread canal_civs_flee_car_handler();
  thread canal_civs_flee_car_handler();
  thread canal_civs_flee_car_handler();
}

function canal_civs_flee_car_handler() {
  self endon("death");
  self.allowdeath = 1;
  self.ignoreall = 1;
  var0 = scripts\engine\utility::getStruct("can_street_civdeathcars_org", "targetname");
  var1 = scripts\engine\utility::getStruct("can_street_civdeathcars_org2", "targetname");
  var1 scripts\common\anim::anim_first_frame_solo(self, "canal_civs_flee_idle");
  scripts\engine\utility::flag_wait("flag_canal_driveby_far");
  scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var1 scripts\sp\anim::anim_reach_solo(self, "canal_civs_flee_idle");
  scripts\engine\sp\utility::trigger_wait_targetname("flag_across_bridge");
  self delete();
}

function canal_civs_flee_handler() {
  var0 = scripts\engine\utility::getStruct("can_farside_civs_org", "targetname");
  var1 = scripts\engine\sp\utility::spawn_targetname("can_street_onlookers_civ07", 1);
  var1 endon("death");
  var1 endon("entitydeleted");
  var1.animname = "civ07";
  var0 scripts\common\anim::anim_first_frame_solo(var1, "canal_civs_flee");
  scripts\engine\sp\utility::trigger_wait_targetname("flag_across_bridge");
  var0 scripts\common\anim::anim_single_solo_run(var1, "canal_civs_flee");
  var1 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var2 = scripts\engine\utility::getStruct("can_street_onlookers_civ07_target", "targetname");
  var1 scripts\engine\sp\utility::set_goal_ent(var2);
  scripts\engine\utility::flag_wait("flag_acquire_player_mid_alley");
  var1 delete();
}

function canal_civs_flee_parent_child() {
  var0 = scripts\engine\sp\utility::spawn_targetname("can_street_civ_child01", 1);
  var0 setModel("body_civ_london_female_7_1");
  var1 = scripts\engine\sp\utility::spawn_targetname("can_street_civ_parent01", 1);
  var1 setModel("body_civ_stpeterburg_male_4_1");
  thread canal_civs_flee_parent_child_handler();
  thread canal_civs_flee_parent_child_handler();
  var0 thread scripts\sp\utility::civilianfailwrapper([7]);
}

function canal_civs_flee_parent_child_handler() {
  self endon("death");
  self.allowdeath = 1;
  self.ignoreall = 1;
  var0 = scripts\engine\utility::getStruct("can_street_civs_org", "targetname");
  var1 = scripts\engine\utility::getStruct("can_street_civs_parentchild_idle_org", "targetname");
  var0 scripts\common\anim::anim_first_frame_solo(self, "canal_civs_flee");
  scripts\engine\sp\utility::trigger_wait_targetname("flag_out_window");
  scripts\asm\asm_bb::bb_setcivilianstate("panic");
  scripts\engine\utility::delaythread(0.05, &scripts\common\anim::anim_set_time, [self], "canal_civs_flee", 0.25);
  var0 scripts\common\anim::anim_single_solo(self, "canal_civs_flee", undefined, 4);
  scripts\engine\utility::flag_wait("flag_canal_driveby_far");
  var1 scripts\sp\anim::anim_reach_solo(self, "canal_civs_flee_idle");
  scripts\engine\utility::flag_wait("flag_acquire_player_mid_alley");
  self delete();
}

function spawn_car_and_link_driver(var0) {
  var0 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive(var0.targetname);
  scripts\engine\sp\utility::teleport_to_ent_tag(var0, "TAG_DRIVER");
  self linkTo(var0, "Tag_Driver", (0, 0, 0), (0, 0, 0));
  self.animname = "trafficdriver";
  thread scripts\common\anim::anim_loop_solo(self, "stp_street_traffic");
}

function fakeactor_cross_canal_runners() {
  scripts\engine\sp\utility::trigger_wait_targetname("flag_across_bridge");
  var0 = getspawnerarray("civ_canal_cross_runners");

  foreach(var2 in var0) {
    var3 = scripts\engine\sp\utility::fakeactorspawn(var2);
    var3 thread scripts\sp\maps\stpetersburg\stpetersburg_utility::delete_on_flag("flag_acquire_complete");
  }
}

function canal_traffic() {
  var0 = [];
  GscBinSkip0(0x2e, 0, ["veh_periph_canal_right_spawner1", "vehicle_skilo_civ_idle_RF", "veh8_civ_lnd_skilo", "veh8_civ_lnd_skilo_black", "veh8_civ_lnd_skilo_green", "veh8_civ_lnd_skilo_grey", "veh8_civ_lnd_skilo_blue", "veh8_civ_lnd_skilo_red"]);
}

function car_zooms_past_handler() {
  scripts\engine\utility::flag_wait("flag_canal_driveby_start");
  wait 0.5;
  var0 = scripts\common\vehicle::spawn_vehicle_from_targetname("canal_driveby_car");
  thread driveby_proximity_monitor();
  var0.godmode = 1;
  thread canal_ambulance_siren();
  var1 = (0, 0, 0);
  var2 = scripts\engine\utility::spawn_tag_origin(var0.origin, var0.angles);
  var2 linkTo(var0, "tag_origin", (40, 0, 71), var1);
  var2 scripts\engine\sp\utility::fx_playontag_safe("vfx_stpburg_police_lights", "tag_origin");
  var3 = scripts\engine\sp\utility::spawn_targetname("canal_driveby_car_driver", 1);
  var3.animname = "trafficdriver";
  var4 = scripts\engine\utility::spawn_tag_origin(var0.origin, var0.angles);
  var4 linkTo(var0, "Tag_Driver", (18, 0, 12), (0, 0, 0));
  var3 linkTo(var4, "tag_origin", (0, 0, 0), (0, 0, 0));
  var4 thread scripts\common\anim::anim_loop_solo(var3, "stp_street_traffic");
  scripts\engine\utility::flag_wait("flag_canal_player_jump_down");
  var0 vehicle_setspeed(50, 45, 30);
  thread scripts\common\vehicle_paths::gopath(var0);
  scripts\engine\utility::delaythread(3.1, &scripts\engine\utility::exploder, "splash_fx");
  thread canal_car_kill_player();
  thread canal_car_hit_player();
  scripts\engine\utility::flag_wait("flag_canal_driveby_far");
  var5 = getEnt("canal_driveby_car_vol", "targetname");
  var6 = createnavbadplacebyent(var5, "axis");
  scripts\engine\utility::flag_wait("flag_canal_driveby_end");
  destroynavobstacle(var6);
  var3 delete();
  var2 delete();
}

function canal_ambulance_siren() {
  var0 = self gettagorigin("tag_origin");
  var1 = spawn("script_model", var0 + (0, 0, 120));
  var1 linkTo(self, "tag_origin");
  var1 playLoopSound("stp_canal_ambulance_lp");
  var1 scalevolume(0);
  waitframe();
  var1 scalevolume(1, 4);
  snd_doppler(var1, 7);
  wait 11;
  var1 scalevolume(0, 8);
  wait 8.05;
  var1 delete();
}

function _snd_get_velocity() {
  var0 = gettime();

  if(isDefined(self.origin_velocity_time) == 1 && self.origin_velocity_time == var0) {
    return self.origin_velocity;
  }

  var1 = self.origin;

  if(isagent(self) || isPlayer(self)) {
    var1 = self getvieworigin();
  }

  if(isDefined(self.origin_last) == 0) {
    self.origin_last = var1;
  }

  self.origin_velocity = var1 - self.origin_last;
  self.origin_velocity_time = var0;
  self.origin_last = var1;
  return self.origin_velocity;
}

function snd_doppler_tick(var0, var1, var2, var3, var4, var5, var6) {
  var7 = (0, 0, 0);
  var8 = 39.3701;

  if(isDefined(var2) == 0) {
    var2 = 1;
  }

  if(isDefined(var5) == 0) {
    var5 = 1;
  }

  if(isDefined(var6) == 0) {
    var6 = 343.3;
  }

  if(var2 == 0 && var5 == 0 || var6 == 0) {
    return [0, 0, 0];
  }

  var9 = var6 * var8;
  var10 = var0 - var3;
  var11 = length(var10);
  var12 = 0;
  var13 = 0;

  if(var2 > 0 && var1 != var7) {
    var12 = vectordot(var1, var10) / var11;
    var12 *= var2;
  }

  if(var5 > 0 && var4 != var7) {
    var13 = vectordot(var4, var10) / var11;
    var13 *= var5;
  }

  var14 = (var9 - var12) / (var9 - var13);
  return [var14, var12, var13];
}

function _snd_doppler_main(var0, var1, var2) {
  self notify("stop_doppler");
  self endon("death");
  self endon("stop_doppler");
  setdvarifuninitialized("snd_scrDebug", "0");
  setdvarifuninitialized("snd_scrDebugScale", "1.0");
  var3 = level.player;
  var4 = 0.05;

  while(isent(self)) {
    var5 = self.origin;
    var6 = _snd_get_velocity();
    var7 = var0;
    var8 = var3 getvieworigin();
    var9 = _snd_get_velocity(var3);
    var10 = var2;

    if(isDefined(var9) == 0 || var2 == 0) {
      var9 = (0, 0, 0);
    }

    [var12] = snd_doppler_tick(var5, var6, var7, var8, var9, var10);

    if(isDefined(var1) == 1) {
      var12 *= var1;
    }

    var12 = clamp(var12, 0.01, 2);
    self scalepitch(var12, var4);
    wait var4;
  }
}

function snd_doppler(var0, var1, var2, var3) {
  if(isent(var0) == 0) {
    return;
  }

  if(isDefined(var1) == 0) {
    var1 = 1;
  }

  if(isDefined(var2) == 0) {
    var2 = 1;
  }

  if(isDefined(var3) == 0) {
    var3 = 1;
  }

  thread _snd_doppler_main(var0, var1, var2);
}

function snd_doppler_stop(var0) {
  var0 notify("stop_doppler");
}

function driveby_proximity_monitor() {
  var0 = squared(200);

  while(isDefined(self)) {
    if(distance2dsquared(self.origin, level.player.origin) < var0) {
      earthquake(0.2, 1, level.player.origin, 200);
      playrumbleonposition("light_1s", level.player.origin);
      return;
    }

    waitframe();
  }
}

function canal_car_kill_player() {
  self endon("death");
  self endon("entitydeleted");

  while(isDefined(level.player) && isalive(level.player)) {
    wait 0.1;
  }

  self vehicle_setspeedimmediate(0, 10, 5);
}

function canal_car_hit_player() {
  self endon("death");
  self endon("entitydeleted");

  while(!scripts\engine\utility::flag("flag_canal_driveby_end")) {
    self waittill("touch", var0);

    if(var0 == level.player) {
      level.player viewkick(10, self.origin, 0);
      earthquake(1, 0.3, level.player.origin, 75);
      level.player shellshock("default_nosound", 1);
      level.player playRumbleOnEntity("light_1s");
      var1 = self.origin - level.player.origin;
      var1 = vectorNormalize(var1);
      var2 = anglestoright(self.angles);
      var3 = vectordot(var2, var1);
      var4 = 100;
      var5 = scripts\common\utility::getdifficulty();

      if(var5 == "hard" || var5 == "fu") {
        var4 = 500;
      }

      var6 = var4 - abs(var3) * 100;

      if(level.player isjumping()) {
        var6 *= 5;
      }

      if(var6 > 0) {
        level.player scripts\sp\utility::do_damage(var6, self.origin);
      }

      if(var3 <= 0) {
        var1 = anglestoright(self.angles);
      } else {
        var1 = anglestoleft(self.angles);
      }

      if(isalive(level.player)) {
        level.player pushplayervector(var1 * 50 + (0, 0, 10), 1);
      } else {
        var1 = anglesToForward(self.angles);
        level.player pushplayervector(var1 * 500 + (0, 0, 10), 1);
      }

      break;
    }

    if(isai(var0) && isalive(var0)) {
      var1 = self.origin - var0.origin;
      var1 = vectorNormalize(var1);
      var2 = anglestoright(self.angles);
      var3 = vectordot(var2, var1);
      var0 scripts\sp\utility::do_damage(300, self.origin);
    }

    waitframe();
  }

  wait 0.5;

  if(isDefined(level.player) && isalive(level.player)) {
    level.player pushplayervector((0, 0, 0), 0);
    return;
  }

  self vehicle_setspeedimmediate(0, 10, 5);
}

function canal_background_fakecivs() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::background_fakeciv_setup("canal_bg_fakeciv_idle1", "flag_canal_enforcer_on_bridge", "flag_acquire_complete");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::background_fakeciv_setup("canal_bg_fakeciv_idle2", "flag_canal_player_on_bridge", "flag_acquire_complete");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::background_fakeciv_setup("canal_bg_fakeciv_idle3", "flag_canal_driveby_far", "flag_acquire_complete");
}