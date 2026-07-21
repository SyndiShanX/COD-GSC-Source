/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\stpetersburg\stpetersburg_vig_script_canal.gsc
******************************************************************/

canal_vig_init() {
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

canal_vig_start() {
  thread car_zooms_past_handler();
  thread canal_traffic();
  thread fakeactor_cross_canal_runners();
  thread canal_civs_onlookers_handler();
  thread canal_civs_flee_parent_child();
  thread canal_civs_flee_handler();
  thread canal_background_fakecivs();
}

canal_civs_onlookers_handler() {
  var_0 = scripts\engine\sp\utility::spawn_targetname("can_street_onlookers_civ02", 1);
  var_1 = scripts\engine\sp\utility::spawn_targetname("can_street_onlookers_civ03", 1);
  var_2 = [var_0, var_1];
  var_3 = scripts\engine\utility::getStruct("can_street_onlookers_org", "targetname");
  var_4 = scripts\engine\utility::getStruct("can_street_onlookers_org2", "targetname");
  var_0 thread canal_civs_onlookers_behavior(var_3, var_4);
  var_1 thread canal_civs_onlookers_behavior(var_3, var_4);
  scripts\engine\sp\utility::trigger_wait_targetname("flag_across_bridge");
  var_2 = scripts\engine\utility::array_removedead_or_dying(var_2);
  scripts\engine\utility::array_delete(var_2);
}

canal_civs_onlookers_behavior(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");
  self.allowdeath = 1;
  var_0 scripts\common\anim::anim_first_frame_solo(self, "canal_civs_onlookers");
  scripts\engine\utility::flag_wait("flag_grenade_bypass");
  scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var_0 scripts\common\anim::anim_single_solo_run(self, "canal_civs_onlookers");
  var_1 scripts\sp\anim::anim_reach_solo(self, "canal_civs_onlookers_idle2");
  var_1 scripts\common\anim::anim_loop_solo(self, "canal_civs_onlookers_idle2");
}

canal_civs_flee_car() {
  var_0 = scripts\engine\sp\utility::spawn_targetname("can_street_onlookers_civ04", 1);
  var_1 = scripts\engine\sp\utility::spawn_targetname("can_street_onlookers_civ05", 1);
  var_2 = scripts\engine\sp\utility::spawn_targetname("can_street_onlookers_civ06", 1);
  var_0 thread canal_civs_flee_car_handler();
  var_1 thread canal_civs_flee_car_handler();
  var_2 thread canal_civs_flee_car_handler();
}

canal_civs_flee_car_handler() {
  self endon("death");
  self.allowdeath = 1;
  self.ignoreall = 1;
  var_0 = scripts\engine\utility::getStruct("can_street_civdeathcars_org", "targetname");
  var_1 = scripts\engine\utility::getStruct("can_street_civdeathcars_org2", "targetname");
  var_1 scripts\common\anim::anim_first_frame_solo(self, "canal_civs_flee_idle");
  scripts\engine\utility::flag_wait("flag_canal_driveby_far");
  scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var_1 scripts\sp\anim::anim_reach_solo(self, "canal_civs_flee_idle");
  scripts\engine\sp\utility::trigger_wait_targetname("flag_across_bridge");
  self delete();
}

canal_civs_flee_handler() {
  var_0 = scripts\engine\utility::getStruct("can_farside_civs_org", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_targetname("can_street_onlookers_civ07", 1);
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_1.animname = "civ07";
  var_0 scripts\common\anim::anim_first_frame_solo(var_1, "canal_civs_flee");
  scripts\engine\sp\utility::trigger_wait_targetname("flag_across_bridge");
  var_0 scripts\common\anim::anim_single_solo_run(var_1, "canal_civs_flee");
  var_1 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var_2 = scripts\engine\utility::getStruct("can_street_onlookers_civ07_target", "targetname");
  var_1 scripts\engine\sp\utility::set_goal_ent(var_2);
  scripts\engine\utility::flag_wait("flag_acquire_player_mid_alley");
  var_1 delete();
}

canal_civs_flee_parent_child() {
  var_0 = scripts\engine\sp\utility::spawn_targetname("can_street_civ_child01", 1);
  var_0 setModel("body_civ_london_female_7_1");
  var_1 = scripts\engine\sp\utility::spawn_targetname("can_street_civ_parent01", 1);
  var_1 setModel("body_civ_stpeterburg_male_4_1");
  var_0 thread canal_civs_flee_parent_child_handler();
  var_1 thread canal_civs_flee_parent_child_handler();
  var_0 thread scripts\sp\utility::civilianfailwrapper([7]);
}

canal_civs_flee_parent_child_handler() {
  self endon("death");
  self.allowdeath = 1;
  self.ignoreall = 1;
  var_0 = scripts\engine\utility::getStruct("can_street_civs_org", "targetname");
  var_1 = scripts\engine\utility::getStruct("can_street_civs_parentchild_idle_org", "targetname");
  var_0 scripts\common\anim::anim_first_frame_solo(self, "canal_civs_flee");
  scripts\engine\sp\utility::trigger_wait_targetname("flag_out_window");
  scripts\asm\asm_bb::bb_setcivilianstate("panic");
  scripts\engine\utility::delaythread(0.05, scripts\common\anim::anim_set_time, [self], "canal_civs_flee", 0.25);
  var_0 scripts\common\anim::anim_single_solo(self, "canal_civs_flee", undefined, 4);
  scripts\engine\utility::flag_wait("flag_canal_driveby_far");
  var_1 scripts\sp\anim::anim_reach_solo(self, "canal_civs_flee_idle");
  scripts\engine\utility::flag_wait("flag_acquire_player_mid_alley");
  self delete();
}

spawn_car_and_link_driver(var_0) {
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive(var_0.targetname);
  scripts\engine\sp\utility::teleport_to_ent_tag(var_0, "TAG_DRIVER");
  self linkTo(var_0, "Tag_Driver", (0, 0, 0), (0, 0, 0));
  self.animname = "trafficdriver";
  thread scripts\common\anim::anim_loop_solo(self, "stp_street_traffic");
}

fakeactor_cross_canal_runners() {
  scripts\engine\sp\utility::trigger_wait_targetname("flag_across_bridge");
  var_0 = getspawnerarray("civ_canal_cross_runners");

  foreach(var_2 in var_0) {
    var_3 = scripts\engine\sp\utility::fakeactorspawn(var_2);
    var_3 thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::delete_on_flag("flag_acquire_complete");
  }
}

canal_traffic() {
  var_0 = [];
  var_0[0] = ["veh_periph_canal_right_spawner1", "vehicle_skilo_civ_idle_RF", "veh8_civ_lnd_skilo", "veh8_civ_lnd_skilo_black", "veh8_civ_lnd_skilo_green", "veh8_civ_lnd_skilo_grey", "veh8_civ_lnd_skilo_blue", "veh8_civ_lnd_skilo_red"];
  var_0[1] = ["veh_periph_canal_right_spawner2", "vehicle_ralfa_civ_idle_RF", "veh8_civ_lnd_ralfa", "veh8_civ_lnd_ralfa_grey", "veh8_civ_lnd_ralfa_brown", "veh8_civ_lnd_ralfa_blue", "veh8_civ_lnd_ralfa_red"];
  var_0[2] = ["veh_periph_canal_right_spawner3", "vehicle_victor40_civ_idle_RF", "veh8_civ_lnd_victor40", "veh8_civ_lnd_victor40_black", "veh8_civ_lnd_victor40_brown", "veh8_civ_lnd_victor40_blue", "veh8_civ_lnd_victor40_silver", "veh8_civ_lnd_victor40_red"];
  var_0[3] = ["veh_periph_canal_right_spawner4", "vehicle_audi_civ_idle_RF", "veh8_civ_lnd_secho", "veh8_civ_lnd_secho_black", "veh8_civ_lnd_secho_blue", "veh8_civ_lnd_secho_grey", "veh8_civ_lnd_secho_red", "veh8_civ_lnd_secho_green"];
  var_0[4] = ["veh_periph_canal_right_spawner5", "vehicle_decho_civ_idle_RF", "veh8_civ_lnd_decho_black", "veh8_civ_lnd_decho", "veh8_civ_lnd_decho_silver", "veh8_civ_lnd_decho_blue", "veh8_civ_lnd_decho_green", "veh8_civ_lnd_decho_tan", "veh8_civ_lnd_decho_brown"];
  var_1 = getspawnerarray("civ_veh_periph_canal_right_spawner");
  var_2 = getvehiclenodearray("veh_periph_canal_right_start", "targetname");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::periph_vehicle_loop_new("flag_acquire_complete", var_0, var_1, var_2);
  var_3 = [];
  var_3[0] = ["veh_periph_canal_left_spawner1", "vehicle_skilo_civ_idle_RF", "veh8_civ_lnd_skilo", "veh8_civ_lnd_skilo_black", "veh8_civ_lnd_skilo_green", "veh8_civ_lnd_skilo_grey", "veh8_civ_lnd_skilo_blue", "veh8_civ_lnd_skilo_red"];
  var_3[1] = ["veh_periph_canal_left_spawner2", "vehicle_ralfa_civ_idle_RF", "veh8_civ_lnd_ralfa", "veh8_civ_lnd_ralfa_grey", "veh8_civ_lnd_ralfa_brown", "veh8_civ_lnd_ralfa_blue", "veh8_civ_lnd_ralfa_red"];
  var_3[2] = ["veh_periph_canal_left_spawner3", "vehicle_victor40_civ_idle_RF", "veh8_civ_lnd_victor40", "veh8_civ_lnd_victor40_black", "veh8_civ_lnd_victor40_brown", "veh8_civ_lnd_victor40_blue", "veh8_civ_lnd_victor40_silver", "veh8_civ_lnd_victor40_red"];
  var_3[3] = ["veh_periph_canal_left_spawner4", "vehicle_audi_civ_idle_RF", "veh8_civ_lnd_secho", "veh8_civ_lnd_secho_black", "veh8_civ_lnd_secho_blue", "veh8_civ_lnd_secho_grey", "veh8_civ_lnd_secho_red", "veh8_civ_lnd_secho_green"];
  var_3[4] = ["veh_periph_canal_left_spawner5", "vehicle_decho_civ_idle_RF", "veh8_civ_lnd_decho_black", "veh8_civ_lnd_decho", "veh8_civ_lnd_decho_silver", "veh8_civ_lnd_decho_blue", "veh8_civ_lnd_decho_green", "veh8_civ_lnd_decho_tan", "veh8_civ_lnd_decho_brown"];
  var_4 = getspawnerarray("civ_veh_periph_canal_left_spawner");
  var_5 = getvehiclenodearray("veh_periph_canal_left_start", "targetname");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::periph_vehicle_loop_new("flag_acquire_complete", var_3, var_4, var_5);
}

car_zooms_past_handler() {
  scripts\engine\utility::flag_wait("flag_canal_driveby_start");
  wait 0.5;
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname("canal_driveby_car");
  var_0 thread driveby_proximity_monitor();
  var_0.godmode = 1;
  var_0 thread canal_ambulance_siren();
  var_1 = (0, 0, 0);
  var_2 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_2 linkTo(var_0, "tag_origin", (40, 0, 71), var_1);
  var_2 scripts\engine\sp\utility::fx_playontag_safe("vfx_stpburg_police_lights", "tag_origin");
  var_3 = scripts\engine\sp\utility::spawn_targetname("canal_driveby_car_driver", 1);
  var_3.animname = "trafficdriver";
  var_4 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_4 linkTo(var_0, "Tag_Driver", (18, 0, 12), (0, 0, 0));
  var_3 linkTo(var_4, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_4 thread scripts\common\anim::anim_loop_solo(var_3, "stp_street_traffic");
  scripts\engine\utility::flag_wait("flag_canal_player_jump_down");
  var_0 vehicle_setspeed(50, 45, 30);
  thread scripts\common\vehicle_paths::gopath(var_0);
  scripts\engine\utility::delaythread(3.1, scripts\engine\utility::exploder, "splash_fx");
  var_0 thread canal_car_kill_player();
  var_0 thread canal_car_hit_player();
  scripts\engine\utility::flag_wait("flag_canal_driveby_far");
  var_5 = getEnt("canal_driveby_car_vol", "targetname");
  var_6 = createnavbadplacebyent(var_5, "axis");
  scripts\engine\utility::flag_wait("flag_canal_driveby_end");
  destroynavobstacle(var_6);
  var_3 delete();
  var_2 delete();
}

canal_ambulance_siren() {
  var_0 = self gettagorigin("tag_origin");
  var_1 = spawn("script_model", var_0 + (0, 0, 120));
  var_1 linkTo(self, "tag_origin");
  var_1 playLoopSound("stp_canal_ambulance_lp");
  var_1 scalevolume(0);
  waitframe();
  var_1 scalevolume(1, 4);
  snd_doppler(var_1, 7.0);
  wait 11;
  var_1 scalevolume(0, 8);
  wait 8.05;
  var_1 delete();
}

_snd_get_velocity() {
  var_0 = gettime();

  if(isDefined(self.origin_velocity_time) == 1 && self.origin_velocity_time == var_0)
    return self.origin_velocity;

  var_1 = self.origin;

  if(isagent(self) || isPlayer(self))
    var_1 = self getvieworigin();

  if(isDefined(self.origin_last) == 0)
    self.origin_last = var_1;

  self.origin_velocity = var_1 - self.origin_last;
  self.origin_velocity_time = var_0;
  self.origin_last = var_1;
  return self.origin_velocity;
}

snd_doppler_tick(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = (0, 0, 0);
  var_8 = 39.3701;

  if(isDefined(var_2) == 0)
    var_2 = 1.0;

  if(isDefined(var_5) == 0)
    var_5 = 1.0;

  if(isDefined(var_6) == 0)
    var_6 = 343.3;

  if(var_2 == 0.0 && var_5 == 0.0 || var_6 == 0.0)
    return [0.0, 0.0, 0.0];

  var_9 = var_6 * var_8;
  var_10 = var_0 - var_3;
  var_11 = length(var_10);
  var_12 = 0.0;
  var_13 = 0.0;

  if(var_2 > 0 && var_1 != var_7) {
    var_12 = vectordot(var_1, var_10) / var_11;
    var_12 = var_12 * var_2;
  }

  if(var_5 > 0 && var_4 != var_7) {
    var_13 = vectordot(var_4, var_10) / var_11;
    var_13 = var_13 * var_5;
  }

  var_14 = (var_9 - var_12) / (var_9 - var_13);
  return [var_14, var_12, var_13];
}

_snd_doppler_main(var_0, var_1, var_2) {
  self notify("stop_doppler");
  self endon("death");
  self endon("stop_doppler");
  setdvarifuninitialized("snd_scrDebug", "0");
  setdvarifuninitialized("snd_scrDebugScale", "1.0");
  var_3 = level.player;
  var_4 = 0.05;

  while(isent(self)) {
    var_5 = self.origin;
    var_6 = _snd_get_velocity();
    var_7 = var_0;
    var_8 = var_3 getvieworigin();
    var_9 = var_3 _snd_get_velocity();
    var_10 = var_2;

    if(isDefined(var_9) == 0 || var_2 == 0.0)
      var_9 = (0, 0, 0);

    var_11 = snd_doppler_tick(var_5, var_6, var_7, var_8, var_9, var_10);
    var_12 = var_11[0];

    if(isDefined(var_1) == 1)
      var_12 = var_12 * var_1;

    var_12 = clamp(var_12, 0.01, 2.0);
    self scalepitch(var_12, var_4);
    wait(var_4);
  }
}

snd_doppler(var_0, var_1, var_2, var_3) {
  if(isent(var_0) == 0) {
    return;
  }
  if(isDefined(var_1) == 0)
    var_1 = 1.0;

  if(isDefined(var_2) == 0)
    var_2 = 1.0;

  if(isDefined(var_3) == 0)
    var_3 = 1.0;

  var_0 thread _snd_doppler_main(var_1, var_2, var_3);
}

snd_doppler_stop(var_0) {
  var_0 notify("stop_doppler");
}

driveby_proximity_monitor() {
  var_0 = squared(200);

  while(isDefined(self)) {
    if(distance2dsquared(self.origin, level.player.origin) < var_0) {
      earthquake(0.2, 1.0, level.player.origin, 200);
      playrumbleonposition("light_1s", level.player.origin);
      return;
    }

    waitframe();
  }
}

canal_car_kill_player() {
  self endon("death");
  self endon("entitydeleted");

  while(isDefined(level.player) && isalive(level.player))
    wait 0.1;

  self vehicle_setspeedimmediate(0, 10, 5);
}

canal_car_hit_player() {
  self endon("death");
  self endon("entitydeleted");

  while(!scripts\engine\utility::flag("flag_canal_driveby_end")) {
    self waittill("touch", var_0);

    if(var_0 == level.player) {
      level.player viewkick(10, self.origin, 0);
      earthquake(1, 0.3, level.player.origin, 75);
      level.player shellshock("default_nosound", 1);
      level.player playRumbleOnEntity("light_1s");
      var_1 = self.origin - level.player.origin;
      var_1 = vectorNormalize(var_1);
      var_2 = anglestoright(self.angles);
      var_3 = vectordot(var_2, var_1);
      var_4 = 100;
      var_5 = scripts\common\utility::getdifficulty();

      if(var_5 == "hard" || var_5 == "fu")
        var_4 = 500;

      var_6 = var_4 - abs(var_3) * 100;

      if(level.player isjumping())
        var_6 = var_6 * 5;

      if(var_6 > 0)
        level.player scripts\sp\utility::do_damage(var_6, self.origin);

      if(var_3 <= 0)
        var_1 = anglestoright(self.angles);
      else
        var_1 = anglestoleft(self.angles);

      if(isalive(level.player))
        level.player pushplayervector(var_1 * 50 + (0, 0, 10), 1);
      else {
        var_1 = anglesToForward(self.angles);
        level.player pushplayervector(var_1 * 500 + (0, 0, 10), 1);
      }

      break;
    }

    if(isai(var_0) && isalive(var_0)) {
      var_1 = self.origin - var_0.origin;
      var_1 = vectorNormalize(var_1);
      var_2 = anglestoright(self.angles);
      var_3 = vectordot(var_2, var_1);
      var_0 scripts\sp\utility::do_damage(300, self.origin);
    }

    waitframe();
  }

  wait 0.5;

  if(isDefined(level.player) && isalive(level.player))
    level.player pushplayervector((0, 0, 0), 0);
  else
    self vehicle_setspeedimmediate(0, 10, 5);
}

canal_background_fakecivs() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::background_fakeciv_setup("canal_bg_fakeciv_idle1", "flag_canal_enforcer_on_bridge", "flag_acquire_complete");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::background_fakeciv_setup("canal_bg_fakeciv_idle2", "flag_canal_player_on_bridge", "flag_acquire_complete");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::background_fakeciv_setup("canal_bg_fakeciv_idle3", "flag_canal_driveby_far", "flag_acquire_complete");
}