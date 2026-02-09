/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\skyway_rooftops.gsc
*****************************************************/

section_flag_inits() {
  common_scripts\utility::flag_init("flag_rooftops_jump");
  common_scripts\utility::flag_init("flag_rooftops_start");
  common_scripts\utility::flag_init("flag_rooftops_rt0_hit");
  common_scripts\utility::flag_init("flag_rt0_move_up");
  common_scripts\utility::flag_init("flag_rt1_move_up");
  common_scripts\utility::flag_init("flag_helo_ready");
  common_scripts\utility::flag_init("flag_helo_start");
  common_scripts\utility::flag_init("flag_helo_reinforce");
  common_scripts\utility::flag_init("flag_helo_tunnel");
  common_scripts\utility::flag_init("flag_helo_fail");
  common_scripts\utility::flag_init("flag_helos_dead");
  common_scripts\utility::flag_init("flag_helo_end");
  common_scripts\utility::flag_init("flag_tunnel_ready");
}

section_precache() {
  vehicle_scripts\aas_72x::main("vehicle_aas_72x", undefined, "script_model");
}

section_post_inits() {
  thread setup_spawners();
  var_0 = getEntArray("rt_helos", "script_noteworthy");
  common_scripts\utility::array_call(var_0, ::hide);
  var_1 = getent("rt0_trig_jump", "targetname");
  var_1 setmovingplatformtrigger();
}

start() {
  iprintln("rooftops");
  var_0 = getent("rt1_start_player", "targetname");
  level.player setorigin(var_0.origin);
  level.player setplayerangles(var_0.angles);
  var_1 = getent("rt1_start_ally", "targetname");
  level._ally forceteleport(var_1.origin, var_1.angles);
  common_scripts\utility::flag_set("flag_helo_ready");
  thread maps\skyway_util::ambient_airbursts_startpoint();
}

main() {
  var_0 = ["train_rt0", "train_rt1", "train_rt2"];

  foreach(var_2 in var_0) {
    level._train.cars[var_2].trigs = common_scripts\utility::array_removeundefined(level._train.cars[var_2].trigs);
    common_scripts\utility::array_call(level._train.cars[var_2].trigs, ::setmovingplatformtrigger);
  }

  level.ally_impact_org = getent("rt_helo_crash_ally", "targetname");
  level.old_goalradius = level.default_goalradius;
  level.default_goalradius = 768;
  level._ally.a.bdisablemovetwitch = undefined;
  level._ally thread maps\_utility::enable_careful();
  level._ally thread maps\_utility::set_grenadeammo(0);
  level._ally thread maps\_utility::follow_path(getnode("rt0_node_start_ally", "targetname"));
  thread maps\skyway_fx::fx_turnon_loco_exterior_lights();
  common_scripts\utility::flag_set("flag_pause_ambient_train_shakes");
  level.player setclienttriggeraudiozone("skyway_train_ext_rooftop", 0.5);
  level.player setmantlesoundflavor("scn_skyway_train_mantle", "scn_skyway_train_mantle");
  rt_start();
  level.player setmantlesoundflavor(undefined, undefined);
  rt_helos(level._train);
  thread rt_helos_dead();
}

rt_start() {
  common_scripts\utility::flag_wait("flag_rooftops_jump");
  wait 0.05;
  level._ally thread maps\_utility::follow_path(getnode("rt0_node_wait_ally", "targetname"));
  level.player maps\_utility::blend_movespeedscale(0.8);
  common_scripts\utility::flag_wait("flag_rooftops_start");
  common_scripts\utility::flag_clear("can_save");
  level._ally thread maps\_utility::set_force_color("r");
  thread rt_hero_train_impact(level._train.cars["train_rt0"], level._ally);
  common_scripts\utility::flag_wait("flag_rt0_move_up");
  getent("rt1_color_reach", "targetname") notify("trigger");
}

rt_hero_train_impact(var_0, var_1) {
  thread maps\skyway_util::jet_flyover(level._train.cars["train_loco"].body, "rt_bomb");

  while(!common_scripts\utility::flag("flag_rooftops_rt0_hit") && distancesquared(var_0.body gettagorigin("j_spineupper"), var_1.origin) > 302500)
    wait 0.1;

  thread rt_hero_train_impact_sequence();
  thread rt_train_impact_fic();
  level waittill("hero_train_impact_ready");
  maps\_utility::delaythread(0.2, ::player_push_train, level._train.cars["train_rt0"], (0, 285, 0), 40, 0.7, undefined, 1);
  maps\_utility::delaythread(0.9, ::player_push_train, level._train.cars["train_rt0"], (0, 75, 0), 60, 0.5, undefined, 1);
  maps\_utility::delaythread(1.4, ::player_push_train, level._train.cars["train_rt0"], (0, 300, 0), 20, 0.4, undefined, 1);
  maps\_utility::delaythread(1.8, common_scripts\utility::flag_set, "can_save");
  maps\_utility::delaythread(1.9, maps\_utility::autosave_by_name, "rooftops_start");
  maps\_utility::delaythread(1.95, ::rt_respawn_ammo);
  var_2 = level._ally animscripts\utility::getanimendpos(level.scr_anim["ally1"]["rt_train_impact"]);
  var_3 = distancesquared(var_0.body gettagorigin("j_spineupper"), level._ally.origin);
  var_4 = distancesquared(var_0.body gettagorigin("j_spineupper"), var_2);

  if(var_3 < 160000 && var_4 < 144400) {
    var_5 = level._ally common_scripts\utility::spawn_tag_origin();
    var_6 = maps\skyway_util::get_local_coords(level._ally.origin, var_0.body gettagorigin("j_spineupper"), var_0.body gettagangles("j_spineupper"), 1);
    var_5 linkto(var_0.body, "j_spineupper", var_6, (0, 0, 0));
    level._ally linkto(var_5, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_5 maps\_anim::anim_single_solo(level._ally, "rt_train_impact", undefined, 0.1);
    level._ally unlink();
    wait 0.1;
    var_5 unlink();
    var_5 delete();
  }
}

rt_hero_train_impact_sequence(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 0.65;

  if(!isDefined(var_1))
    var_1 = 1;

  var_2 = "tag_explode_close_r";
  var_3 = "tag_explode_close_r2";
  var_4 = "tag_explode_close_r3";
  var_5 = "sathit_sat_explode_R";
  var_6 = ["scn_skyway_missile_explode", "scn_skyway_missile_impact", "skyway_missile_hit_01"];
  var_7 = 0.7;
  thread maps\skyway_util::hero_train_impact(level._train.cars["train_rt1"].body, var_2, var_5, var_6, var_0, var_1);
  wait(var_7);
  thread maps\skyway_util::hero_train_impact(level._train.cars["train_rt1"].body, var_3, var_5, var_6, 0, 0, 0);
  wait(var_7);
  thread maps\skyway_util::hero_train_impact(level._train.cars["train_rt1"].body, var_4, var_5, var_6, 0, 0, 0);
}

rt_train_impact_fic() {
  level waittill("hero_train_impact_near");
  level._ally maps\_utility::smart_dialogue("skyway_hsh_incoming");
  level waittill("hero_train_impact_ready");
  wait 2.1;
  level._ally maps\_utility::smart_dialogue("skyway_hsh_youokloganlets");
}

rt_helos(var_0) {
  common_scripts\utility::flag_wait_all("flag_helo_start", "flag_helo_ready");
  setthreatbias("axis", "player", 500);
  thread rt_helos_fic();
  level._ally thread maps\_utility::set_force_color("b");
  getent("rt1_color_mid", "targetname") notify("trigger");
  level.helos = [getent("rt_helo0", "targetname"), getent("rt_helo1", "targetname")];
  var_1 = level.helos.size;

  foreach(var_4, var_3 in level.helos) {
    var_3.org = maps\_utility::spawn_anim_model("rt_helo" + maps\_utility::string(var_4) + "_mover");
    var_3.org.link1 = common_scripts\utility::spawn_tag_origin();
    var_3.org.link2 = common_scripts\utility::spawn_tag_origin();
    var_3 vehicle_scripts\aas_72x::init_local();
    init_helo(var_3);
    var_3 thread maps\skyway_util::rt_helo_bullethits();
    var_3 thread maps\skyway_audio::sfx_skyway_helo(var_4);

    if(var_4 > 0)
      var_3 thread rt_helo_lane_switch(level.helos[0]);
  }

  wait 0.05;
  common_scripts\utility::flag_set("sfx_helo_flyin");
  common_scripts\utility::flag_clear("flag_helo_tunnel");
  common_scripts\utility::array_thread(level.helos, ::rt_helo_proc, var_0, var_0.cars["train_rt1"]);
  thread rt_tunnel_queue(var_0.cars["train_rt1"]);
  thread rt_traincar_tracker(level._train, ["train_rt1", "train_rt2", "train_rt3"]);
  maps\_utility::delaythread(10, ::rt_traincar_tracker, level._train, ["train_rt0", "train_rt1", "train_rt2", "train_rt3"]);
  wait 15;
  common_scripts\utility::flag_set("flag_helo_reinforce");

  if(level.helos.size >= var_1 || level.helos.size <= 0) {
    return;
  }
  var_5 = level.helos[0].linked_car;
  var_3 = getent("rt_helo2", "targetname");
  level.helos[level.helos.size] = var_3;
  var_3.org = maps\_utility::spawn_anim_model("rt_helo1_mover");
  var_3.org.link1 = common_scripts\utility::spawn_tag_origin();
  var_3.org.link2 = common_scripts\utility::spawn_tag_origin();
  var_3 vehicle_scripts\aas_72x::init_local();
  init_helo(var_3);
  var_3 thread maps\skyway_util::rt_helo_bullethits();
  var_3 thread rt_helo_lane_switch(level.helos[0]);
  wait 0.05;
  var_3 thread rt_helo_proc(var_0, var_0.cars[var_5], level.helos[0]);
}

rt_helos_dead() {
  common_scripts\utility::flag_wait_any("flag_helo_end", "flag_helo_tunnel", "flag_rooftops_combat_done");

  if(common_scripts\utility::flag("flag_helo_tunnel") || common_scripts\utility::flag("flag_rooftops_combat_done")) {
    common_scripts\utility::flag_set("flag_helo_fail");

    foreach(var_1 in level.helos) {
      if(isDefined(var_1) && isalive(var_1))
        var_1 notify("rt_helo_dead", "tunnel");
    }
  }

  if(!common_scripts\utility::flag("flag_helos_dead"))
    common_scripts\utility::flag_set("flag_helos_dead");

  if(!common_scripts\utility::flag("flag_helo_end"))
    common_scripts\utility::flag_set("flag_helo_end");

  if(common_scripts\utility::flag("flag_rooftops_combat_done") || common_scripts\utility::flag("flag_loco_started")) {
    return;
  }
  if(!common_scripts\utility::flag("flag_rt2_combat_start"))
    thread maps\_utility::autosave_by_name("rooftops_helo_end");

  level._ally thread maps\_utility::set_force_color("r");

  if(!common_scripts\utility::flag("flag_rt2_combat_start"))
    getent("rt2_color_start", "targetname") notify("trigger");

  common_scripts\utility::flag_wait("flag_rt2_combat_start");
  maps\_utility::autosave_by_name("rooftops_combat");
}

rt_helos_fic() {
  level endon("flag_helo_tunnel");
  level endon("flag_rooftops_end");
  wait 3;
  level._ally maps\_utility::smart_dialogue("skyway_hsh_helostakecoveradam");
  var_0 = level common_scripts\utility::waittill_notify_or_timeout_return("rt_helo_dead", randomfloatrange(3, 5));

  if(isDefined(var_0) && var_0 == "timeout")
    level._ally maps\_utility::smart_dialogue("skyway_hsh_takeoutthegunners");

  while(level.helos.size > 1)
    wait 0.5;

  if(!common_scripts\utility::flag("flag_helo_reinforce")) {
    level._ally maps\_utility::smart_dialogue("skyway_hsh_niceshot");
    common_scripts\utility::flag_wait("flag_helo_reinforce");
    wait 0.1;

    while(level.helos.size > 1)
      wait 0.05;
  } else
    level._ally maps\_utility::smart_dialogue("skyway_hsh_onedown");

  common_scripts\utility::flag_wait("flag_helos_dead");
  wait 1.0;

  if(!common_scripts\utility::flag("flag_rt2_combat_start")) {
    level._ally thread maps\_utility::smart_dialogue("skyway_hsh_helosdownletsgo");
    level._ally maps\_utility::delaythread(1.75, maps\_utility::smart_dialogue, "skyway_hsh_getdown");
  } else
    level._ally thread maps\_utility::smart_dialogue("skyway_hsh_helosdown");

  level waittill("rt1_compromised");
  wait 3;

  if(!common_scripts\utility::flag("flag_rt2_combat_start"))
    level._ally maps\_utility::smart_dialogue("skyway_hsh_moveitthecars");

  wait 2;

  if(!common_scripts\utility::flag("flag_rt1_move_up"))
    level._ally maps\_utility::smart_dialogue("skyway_hsh_cmonlogankeepmoving");

  wait 10;
  var_1 = ["skyway_hsh_comeonadamget", "skyway_hsh_moveitweneed", "skyway_hsh_whereareyouwe", "skyway_hsh_moveitthecars"];

  for(var_2 = 0; !common_scripts\utility::flag("flag_rt2_combat_start"); var_2++) {
    level._ally maps\_utility::smart_dialogue(var_1[common_scripts\utility::mod(var_2, var_1.size)]);
    wait(5 + var_2 + randomfloat(1));
  }
}

rt_helo_proc(var_0, var_1, var_2) {
  self.train = var_0;
  self.car = var_1;
  self.linked_car = var_1.body.script_noteworthy;
  self.healthbuffer = 20000;
  self.health = self.healthbuffer + 3000;
  self.critical = self.healthbuffer + 2500;
  self.damaged = self.healthbuffer + 1000;
  self.is_idling = 0;
  self show();
  maps\skyway_util::rt_helo_fx_setup(self.car);
  var_3 = getEntArray(self.targetname + "_clip", "targetname");

  if(isDefined(var_3) && var_3.size > 0) {
    foreach(var_5 in var_3)
    var_5 linkto(self);
  }

  self.dam = [];
  thread rt_helo_loc_dam("tail", 600, 500, 200);
  thread rt_helo_loc_dam("engine", 600, 500, 200);
  thread rt_helo_loc_dam("belly", 1200, 1000, 300);
  thread rt_helo_loc_dam_watcher();
  thread rt_helo_dam();
  thread rt_helo_shooter_check();
  thread rt_helo_driver_check();
  self.riders[0].allowdeath = 1;
  self.riders[0].deathanim = level.scr_anim["generic"]["helo_pilot_death"][randomint(1)];
  common_scripts\utility::array_thread(self.riders, maps\_utility::set_ignoreall, 1);
  common_scripts\utility::array_thread(self.riders, maps\_utility::set_ignoreme, 1);
  wait 0.05;
  var_7 = level.scr_anim["generic"]["helo_shooter_death"];

  foreach(var_10, var_9 in self.shooters)
  var_9.deathanim = var_7[common_scripts\utility::mod(var_10, var_7.size)];

  self.deathanims = var_7;
  maps\_utility::assign_animtree("rt_helo_small");
  self setanim(level.scr_anim["rt_helo_small"]["blades"]);
  self.org.link1 linkto(var_1.body, "j_mainroot", (0, 0, 0), (0, 0, 0));
  self.org.link2 linkto(var_1.body, "j_spineupper", (0, 0, 0), (0, 0, 0));
  self.org thread maps\skyway_util::blended_link(self.org.link1, self.org.link2, 1);
  wait 0.05;
  self teleportentityrelative(self, self.org);
  self linkto(self.org, "tag_helo", (0, 0, 0), (0, 0, 0));
  self.org setanimknob(level.scr_anim[self.org.animname]["flyin"]);

  if(!isDefined(var_2)) {
    wait(getanimlength(level.scr_anim[self.org.animname]["flyin"]) - 0.5);
    self.org setanimknob(level.scr_anim[self.org.animname]["idle"][0], 1, 0.5);
  } else {
    wait(getanimlength(level.scr_anim[self.org.animname]["flyin"]) - 2.5);
    var_11 = var_2 getanimtime(level.scr_anim[var_2.org.animname]["idle"][0]);
    self.org setanimknob(level.scr_anim[self.org.animname]["idle"][0], 1, 2.5);
    self.org setanimtime(level.scr_anim[self.org.animname]["idle"][0], var_11);
  }

  self.is_idling = 1;
  self setCanDamage(1);
  thread rt_helo_target_anim();
  thread rt_helo_set_ignore(0);
  self waittill("rt_helo_dead", var_12);
  level.helos = common_scripts\utility::array_remove(level.helos, self);
  thread rt_helo_set_ignore(1, 0);
  self setCanDamage(0);

  if(!isDefined(var_12))
    var_12 = "generic";

  self.org thread maps\skyway_util::blend_link_over_time(self.org.link1, self.org.link2, 1.8, 0.5);

  if(level.helos.size > 0 || self.linked_car != "train_rt1" && self.linked_car != "train_rt0") {
    var_13 = 0;

    if(level.helos.size <= 0) {
      common_scripts\utility::flag_set("flag_helos_dead");
      var_13 = 1;
    }

    switch (var_12) {
      case "shooters":
      case "tunnel":
        rt_helo_flyout("flyout");
        break;
      case "tail":
        rt_helo_crash_ground("death_spin");
        break;
      case "driver":
      case "generic":
      case "belly":
      case "engine":
        rt_helo_crash_ground("death_norm");
    }

    if(var_13)
      common_scripts\utility::flag_set("flag_helo_end");
  } else {
    common_scripts\utility::flag_set("flag_helos_dead");

    if(self.linked_car == "train_rt0" && var_12 != "tunnel") {
      var_14 = var_0.cars[self.linked_car].body;
      var_15 = var_0.cars["train_rt1"].body;
      self.org.link1 thread maps\skyway_util::blend_link_over_time(var_14, var_15, 3.35, 0, "j_mainroot", "j_mainroot");
      self.org.link2 thread maps\skyway_util::blend_link_over_time(var_14, var_15, 3.35, 0, "j_spineupper", "j_spineupper");
      self.linked_car = "train_rt1";
      self.car = var_0.cars[self.linked_car];
      wait 1;
    }

    switch (var_12) {
      case "tunnel":
        rt_helo_flyout("flyout");
        break;
      case "shooters":
      case "engine":
      case "tail":
        rt_helo_crash_train("crash_spin");
        break;
      case "driver":
      case "generic":
      case "belly":
        rt_helo_crash_train("crash_norm");
    }

    common_scripts\utility::flag_set("flag_helo_end");
    thread maps\skyway_util::rt_helo_cleanup();
    return;
  }

  self notify("rt_helo_delete");
  self notify("stop_link_train_angles");
  maps\skyway_util::rt_helo_cleanup();
  self delete();
}

rt_helo_flyout(var_0) {
  wait(randomfloat(1));
  self.org setanim(level.scr_anim[self.org.animname]["tilt_parent"], 0, 2.0);
  self.org setanimknob(level.scr_anim[self.org.animname][var_0], 1, 2.7);
  wait(getanimlength(level.scr_anim[self.org.animname][var_0]));
  self stoploopsound("scn_skyway_heli_loop");
}

rt_helo_crash_train(var_0) {
  var_0 = level.scr_anim[self.org.animname][var_0];
  self.org setanim(level.scr_anim[self.org.animname]["tilt_parent"], 0, 2.0);
  self.org setanimknob(var_0, 1, 2.7);
  self setanim(level.scr_anim["rt_helo_small"]["blades_death"]);
  var_1 = distancesquared(level._ally.origin, level.ally_impact_org.origin);

  if(var_1 < 16)
    level._ally thread rt_helo_crash_ally();

  thread maps\skyway_audio::sfx_heli_crash(self);
  self stoploopsound("scn_skyway_heli_loop");
  thread maps\_utility::play_sound_on_entity("aascout72x_helicopter_hit");
  thread common_scripts\utility::play_loop_sound_on_entity("aascout72x_helicopter_dying_loop");
  self.crashed = maps\_utility::spawn_anim_model("rt_helo_crashed");
  self.crashed hide();
  self.crashed linkto(self.org, "tag_helo", (0, 0, 0), (0, 0, 0));
  self.crashed playLoopSound("emt_sw_fire_metal_large");
  self.crashed setanim(level.scr_anim["rt_helo_crashed"]["rt_helo_crash"]);
  self.car thread maps\skyway_util::train_overlay_solo("rt_helo_crash", undefined, undefined, undefined, 2, undefined, 1);
  self.car thread maps\skyway_util::train_overlay_solo("rt_helo_damaged", "waitforpreviousanim", 1, undefined, undefined, undefined, 1);
  maps\skyway_util::rt_helo_crashed_fx_setup(self.car);
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2 thread maps\skyway_fx::fx_origin_link_with_train_angles(self.car.sus_f, self.car.body, "j_elbow_le");
  var_3 = getnotetracktimes(var_0, "helo_hit_train")[0] * getanimlength(var_0);
  wait(var_3);
  level notify("rt1_compromised");
  thread maps\skyway_audio::sfx_heli_crash_impact(self);
  playFXOnTag(common_scripts\utility::getfx("rt_helo_blades_shred"), self, "TAG_blades_damage_fx");
  wait(getnotetracktimes(var_0, "helo_explode")[0] * getanimlength(var_0) - var_3);
  thread maps\skyway_audio::sfx_heli_crash_explo(self);
  thread rt_player_helocrash_effect(self.crashed.origin);
  stopFXOnTag(common_scripts\utility::getfx("rt_helo_blades_shred"), self, "TAG_blades_damage_fx");
  self stoploopsound("scn_skyway_heli_loop");
  thread common_scripts\utility::stop_loop_sound_on_entity("aascout72x_helicopter_dying_loop");
  thread maps\skyway_audio::sfx_train_derail();
  radiusdamage(self.crashed.fx_org_body.origin, 320, 999, 50);
  maps\skyway_util::delay_multi_fx(0, self.crashed.fx_org_body, ["roofhit_helo_explode", "roofhit_helo_smoke"]);
  maps\skyway_util::delay_multi_fx(0, self.crashed.fx_org_tail_rotor, ["rt_helo_tail_fire_rotor"]);
  maps\skyway_util::delay_multi_fx(0, self.crashed.fx_org_tail_break, ["rt_helo_tail_fire_break"]);
  maps\skyway_util::delay_multi_fx(0, var_2, ["roofhit_wheel_break", "roofhit_wheel_sparks_small"]);
  thread rt_fire_proc(getent("rt1_dam_fire", "targetname"), 200, 4, 0.1, "flag_rooftops_combat_done");
  level._train thread maps\skyway_util::train_new_sus_path_anims("train_rt1", "sus_r_broken");
  var_4 = getent("rt1_helo_col", "targetname");
  var_5 = getent("rt1_sus_col", "targetname");
  var_4 linkto(level._train.cars["train_rt1"].body, "j_spineupper", (374, -2, -58), (0, 0, 0));
  var_5 linkto(level._train.cars["train_rt1"].sus_f, "j_mainroot", (0, 0, 63), (0, 0, 0));
  self.org linkto(level._train.cars["train_rt1"].body, "j_spineupper");
  self.crashed show();
  self hide();
  maps\_vehicle::vehicle_lights_off("running");
  wait 0.1;

  if(level.player istouching(var_4) || level.player istouching(var_5))
    level.player kill();
}

rt_helo_crash_ally() {
  level._ally linkto(level.ally_impact_org);
  level.ally_impact_org maps\_anim::anim_single_solo(level._ally, "rt_helo_crash", undefined, 0.1);
  level._ally unlink();
}

rt_player_helocrash_effect(var_0) {
  level endon("flag_loco_enter");
  player_push(var_0, 500, 10, 75, 2, ::rumble_helo_hit);

  if(level.player.car == "train_rt1")
    thread maps\skyway_util::player_view_roll_with_traincar("roll_R", 1);
  else
    thread maps\skyway_util::player_view_roll_with_traincar("roll_R", 0.4);

  var_1 = 0.6;
  var_2 = 0.15;
  var_3 = 0.11;
  var_4 = 0;

  for(;;) {
    if(level.player.car == "train_rt1" && level.player isonground()) {
      if(!var_4) {
        level.player_rumble_ent maps\_utility::rumble_ramp_to(var_3, 0.05);
        maps\skyway_util::player_sway_blendto(0.2, var_1);
        maps\skyway_util::player_wind_blendto(0.2, var_2);
        var_4 = 1;
      }
    } else if(var_4) {
      maps\skyway_util::player_sway_blendto(0.2, level.player_default_sway_weight);
      maps\skyway_util::player_wind_blendto(0.2, 0.0);
      level.player_rumble_ent maps\_utility::rumble_ramp_to(0.0, 0.05);
      var_4 = 0;
    }

    wait(level.timestep);
  }
}

rt_fire_proc(var_0, var_1, var_2, var_3, var_4) {
  level endon(var_4);

  for(;;) {
    radiusdamage(var_0.origin, var_1, var_2, var_2);
    wait 0.1;
  }
}

rt_helo_crash_ground(var_0) {
  thread rt_helo_blend_backward(level._train, 2);
  self.org setanim(level.scr_anim[self.org.animname]["tilt_parent"], 0, 2.0);
  self.org setanimknob(level.scr_anim[self.org.animname][var_0], 1, 2.7);
  self stoploopsound("scn_skyway_heli_loop");
  thread maps\_utility::play_sound_on_entity("aascout72x_helicopter_hit");
  thread common_scripts\utility::play_loop_sound_on_entity("aascout72x_helicopter_dying_loop");
  wait(getanimlength(level.scr_anim[self.org.animname][var_0]));
  thread maps\_utility::play_sound_on_entity("aascout72x_helicopter_crash");
}

rt_helo_blend_backward(var_0, var_1, var_2) {
  var_3 = 0;

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_2))
    var_2 = 3;

  foreach(var_3, var_5 in var_0.names) {
    if(var_5 == self.linked_car) {
      break;
    }
  }

  var_3 = int(clamp(var_3 - 1, var_1, var_0.names.size - 1));
  var_6 = var_0.cars[self.linked_car].body;
  var_7 = var_0.cars[var_0.names[var_3]].body;
  self.org.link1 thread maps\skyway_util::blend_link_over_time(var_6, var_7, var_2, 0, "j_mainroot", "j_mainroot");
  self.org.link2 thread maps\skyway_util::blend_link_over_time(var_6, var_7, var_2, 0, "j_spineupper", "j_spineupper");
  self.linked_car = var_0.names[var_3];
  self.car = var_0.cars[self.linked_car];
}

rt_helo_tunnel_check() {
  self endon("rt_helo_dead");
  self endon("rt_helo_delete");
  common_scripts\utility::flag_wait("flag_helo_tunnel");
  self notify("rt_helo_dead", "tunnel");
}

rt_helo_shooter_check() {
  self endon("rt_helo_dead");
  self endon("rt_helo_delete");

  while(self.shooters.size > 0)
    wait 1;

  wait(randomfloat(1));
  self notify("rt_helo_dead", "shooters");
}

rt_helo_driver_check() {
  self endon("rt_helo_dead");
  self endon("rt_helo_delete");

  while(self.usedpositions[0])
    wait 0.1;

  self notify("rt_helo_dead", "driver");
}

rt_helo_dam() {
  self endon("rt_helo_dead");
  self endon("rt_helo_delete");

  while(self.health > self.damaged)
    wait 0.05;

  thread maps\skyway_util::rt_helo_damage_fx("belly_damage");

  while(self.health > self.critical)
    wait 0.05;

  thread maps\skyway_util::rt_helo_damage_fx("engine_damage");

  while(self.health > self.healthbuffer)
    wait 0.05;

  thread maps\skyway_util::rt_helo_damage_fx("belly_death");
  thread maps\skyway_util::rt_helo_damage_fx("engine_death");
  self notify("rt_helo_dead", "generic");
}

rt_helo_loc_dam(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("rt_helo_dead");
  self endon("rt_helo_delete");
  self.dam[var_0] = spawnStruct();
  self.dam[var_0].healthbuffer = 20000;
  self.dam[var_0].health = self.dam[var_0].healthbuffer + 1000;
  self.dam[var_0].damaged = self.dam[var_0].healthbuffer + 750;
  self.dam[var_0].critical = self.dam[var_0].healthbuffer + 200;

  if(isDefined(var_1))
    self.dam[var_0].health = self.dam[var_0].healthbuffer + var_1;

  if(isDefined(var_2))
    self.dam[var_0].damaged = self.dam[var_0].healthbuffer + var_2;

  if(isDefined(var_3))
    self.dam[var_0].critical = self.dam[var_0].healthbuffer + var_3;

  while(self.dam[var_0].health > self.dam[var_0].damaged)
    wait 0.05;

  thread maps\skyway_util::rt_helo_damage_fx(var_0 + "_damage");

  while(self.dam[var_0].health > self.dam[var_0].critical)
    wait 0.05;

  thread maps\skyway_util::rt_helo_damage_fx(var_0 + "_crit");

  while(self.dam[var_0].health > self.dam[var_0].healthbuffer)
    wait 0.05;

  thread maps\skyway_util::rt_helo_damage_fx(var_0 + "_death");
  self notify("rt_helo_dead", var_0);
}

rt_helo_loc_dam_watcher() {
  self endon("death");
  self endon("rt_helo_dead");
  self endon("rt_helo_delete");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    var_12 = maps\skyway_util::get_local_coords(var_3, var_10, var_11);

    if(var_12[0] < -220) {
      self.dam["tail"].health = self.dam["tail"].health - var_0;
      continue;
    }

    if(var_12[0] > -90 && var_12[2] > -65 && var_12[2] < -35) {
      self.dam["engine"].health = self.dam["engine"].health - var_0;
      continue;
    }

    if(var_12[0] > -95 && var_12[0] < 20 && var_12[2] > -130 && var_12[2] < -65)
      self.dam["belly"].health = self.dam["belly"].health - var_0;
  }
}

rt_helo_target_anim() {
  self endon("rt_helo_dead");
  self endon("rt_helo_delete");
  self.org setanim(level.scr_anim[self.org.animname]["tilt"], 1, 0);
  self.org setanim(level.scr_anim[self.org.animname]["tilt_parent"], 0, 0);
  wait 5;

  for(;;) {
    var_0 = distance(self.origin, level.player.origin);
    var_1 = distance(self.origin, level._ally.origin) + 100;
    var_2 = level.player;

    if(var_1 < var_0)
      var_2 = level._ally;

    var_3 = vectortoangles(var_2.origin - self.origin) - self.angles - (0, 90, 0);
    var_4 = clamp(var_3[1], 0, 90) / 90.0;
    self.org setanim(level.scr_anim[self.org.animname]["tilt_parent"], var_4, 1.5);
    wait(randomfloatrange(2, 5));
    self.org setanim(level.scr_anim[self.org.animname]["tilt_parent"], var_4, 1.5);
    wait(randomfloatrange(1.5, 4));
  }
}

rt_helo_lane_switch(var_0) {
  self endon("rt_helo_dead");
  self endon("rt_helo_delete");
  var_0 waittill("rt_helo_dead");
  wait(randomfloatrange(1, 5));

  while(!isDefined(self.is_idling) || !self.is_idling)
    wait 0.05;

  self.org setanimknob(level.scr_anim[self.org.animname]["idle_inside"], 1, 2.7);
  wait(getanimlength(level.scr_anim[self.org.animname]["idle_inside"]) - 0.5);
  self.org maps\_utility::assign_animtree("rt_helo0_mover");
  self.org setanimknob(level.scr_anim[self.org.animname]["idle"][0], 1, 0.5);
}

rt_tunnel_queue(var_0) {
  if(isDefined(level.debug_no_move) && level.debug_no_move) {
    return;
  }
  var_1 = var_0.body maps\_utility::getanim(level._train.path.anime);
  var_2 = (1 - var_0.body getanimtime(var_1)) * getanimlength(var_1);

  if(level._train.path.anime == "loop_a2" && var_2 < 20) {
    while(level._train.path.anime == "loop_a2")
      wait 0.25;
  }

  common_scripts\utility::flag_set("flag_tunnel_ready");
}

rt_traincar_tracker(var_0, var_1, var_2) {
  level endon("flag_helos_dead");
  level notify("starting_traincar_tracker");
  level endon("starting_traincar_tracker");

  if(!isDefined(var_2))
    var_2 = ["train_hangar", "train_sat_1", "train_sat_2"];

  wait(randomfloatrange(0.1, 1));

  while(!common_scripts\utility::flag("flag_helos_dead")) {
    wait 1;

    if(level.player.car != level.helos[0].linked_car) {
      if(maps\_utility::is_in_array(var_2, level.player.car)) {
        rt_helos_kill_ally(var_0, var_2);

        foreach(var_4 in level.helos) {
          foreach(var_6 in var_4.shooters) {
            if(isDefined(var_6) && isai(var_6) && isalive(var_6))
              var_6.baseaccuracy = 1;
          }
        }

        level._ally maps\_utility::set_ignoresuppression(0);
        level._ally.v.invincible = 1;
        continue;
      }

      if(!maps\_utility::is_in_array(var_1, level.player.car)) {
        continue;
      }
      var_9 = var_0.cars[level.helos[0].linked_car].body;
      var_10 = var_0.cars[level.player.car].body;

      foreach(var_4 in level.helos) {
        var_4.org.link1 thread maps\skyway_util::blend_link_over_time(var_9, var_10, 4, 0, "j_mainroot", "j_mainroot");
        var_4.org.link2 thread maps\skyway_util::blend_link_over_time(var_9, var_10, 4, 0, "j_spineupper", "j_spineupper");
        var_4.linked_car = level.player.car;
        var_4.car = var_0.cars[var_4.linked_car];
      }
    }
  }
}

rt_helos_kill_ally(var_0, var_1) {
  level endon("flag_helos_dead");
  level endon("starting_traincar_tracker");
  var_2 = var_0.cars[level.helos[0].linked_car].body;
  var_3 = var_0.cars["train_rt1"].body;

  foreach(var_5 in level.helos) {
    var_5.org.link1 thread maps\skyway_util::blend_link_over_time(var_2, var_3, 4, 0, "j_mainroot", "j_mainroot");
    var_5.org.link2 thread maps\skyway_util::blend_link_over_time(var_2, var_3, 4, 0, "j_spineupper", "j_spineupper");
    var_5.linked_car = "train_rt1";
    var_5.car = var_0.cars[var_5.linked_car];

    foreach(var_7 in var_5.shooters) {
      if(isDefined(var_7) && isai(var_7) && isalive(var_7))
        var_7.baseaccuracy = 9;
    }
  }

  level._ally thread rt_ally_dam_watch();

  while(maps\_utility::is_in_array(var_1, level.player.car))
    wait 0.1;

  level notify("rt_player_stopped_avoiding_helos");
}

rt_ally_dam_watch() {
  level endon("flag_helos_dead");
  level endon("starting_traincar_tracker");
  level endon("rt_player_stopped_avoiding_helos");
  maps\_utility::set_ignoresuppression(1);
  self.v.invincible = 0;
  wait(randomintrange(3, 5));
  self waittill("damage");
  setDvar("ui_deadquote", &"SKYWAY_HESH_BY_HELOS");
  maps\_utility::missionfailedwrapper();
}

player_push(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = distance(level.player.origin, var_0);

  if(var_6 < var_1) {
    var_7 = clamp(var_6 / var_1, 0, 1);
    var_8 = vectornormalize(level.player.origin - var_0);
    var_8 = var_8 * (var_2 * var_7 + var_3 * (1 - var_7));
    thread player_push_impulse(var_8, var_4);
  }

  if(isDefined(var_5))
    thread[[var_5]](var_6 / var_1, var_0);
}

player_push_train(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_5) && var_5 && level.player.car != var_0.body.script_noteworthy) {
    return;
  }
  var_6 = (0, 1, 0) * var_0.body gettagangles("j_spineupper") + var_1;
  var_7 = anglesToForward(var_6) * var_2;
  thread player_push_impulse(var_7, var_3);

  if(isDefined(var_4))
    thread[[var_4]](level.player.origin + var_7, var_2);
}

player_push_impulse(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0.5;

  var_2 = var_1;

  while(var_2 > 0.0) {
    var_3 = clamp(var_2 / var_1, 0, 1);
    var_4 = var_0 * var_3;
    level.player pushplayervector(var_4);
    var_2 = var_2 - 0.05;
    wait 0.05;
  }

  level.player pushplayervector((0, 0, 0));
}

rumble_player_push(var_0, var_1) {
  level.player playrumbleonentity("grenade_rumble");
  maps\skyway_util::train_quake(0.3, 1.2, level.player.origin, 256);
  level.player viewkick(10, var_0);
}

rumble_helo_hit(var_0, var_1) {
  if(level.player.car == "train_rt1") {
    if(var_0 > 1) {
      level.player playrumbleonentity("grenade_rumble");
      maps\skyway_util::train_quake(0.33, 1.4, level.player.origin, 128);
    } else {
      level.player playrumbleonentity("grenade_rumble");
      maps\skyway_util::train_quake(0.45, 1.6, level.player.origin, 256);
      level.player shellshock("default_nosound", 2);
      level.player dodamage(50, var_1);
    }
  }
}

rt_helo_set_ignore(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = var_0;

  foreach(var_3 in self.shooters) {
    if(isDefined(var_3) && isai(var_3) && isalive(var_3)) {
      var_3 thread maps\_utility::set_ignoreall(var_0);
      var_3 thread maps\_utility::set_ignoreme(var_1);
    }
  }
}

rt_helo_tele_proc(var_0) {
  self endon("death");

  for(;;) {
    var_0 waittill("train_teleport_ready");
    wait 0.05;
    self teleportentityrelative(var_0.path.start_org, var_0.path.end_org);
    self notify("goal");
    wait 0.05;
  }
}

rt_respawn_ammo() {
  while(common_scripts\utility::flag("game_saving"))
    wait 0.05;

  var_0 = getdvarint("rt_helo_lives", 0);
  setDvar("rt_helo_lives", var_0 + 1);

  if(getdvarint("rt_helo_lives", 0) > 1) {
    var_1 = level.player getweaponslistprimaries();

    foreach(var_3 in var_1) {
      if(level.player getfractionmaxammo(var_3) < 0.7)
        level.player setweaponammostock(var_3, int(weaponmaxammo(var_3) * 0.8));
    }
  }
}

setup_spawners() {
  maps\_utility::array_spawn_function_targetname("rt_helo0_link", ::init_helo_ai);
  maps\_utility::array_spawn_function_targetname("rt_helo1_link", ::init_helo_ai);
  maps\_utility::array_spawn_function_targetname("rt_helo2_link", ::init_helo_ai);
}

init_helo_ai() {
  self endon("death");
  self.ridingvehicle endon("rt_helo_dead");
  self.ridingvehicle endon("rt_helo_delete");
  thread helo_ai_handle_death();
  wait 0.05;

  if(self.vehicle_position > 1) {
    while(self.ridingvehicle.shooters.size > 1)
      wait 0.05;
  }

  thread helo_ai_dam_mon();
}

helo_ai_handle_death() {
  self.ridingvehicle endon("rt_helo_dead");
  self.ridingvehicle endon("rt_helo_delete");
  self waittill("death");

  if(self.vehicle_position > 1)
    self.ridingvehicle.shooters = common_scripts\utility::array_remove(self.ridingvehicle.shooters, self);
  else
    self linkto(self.ridingvehicle, "tag_pilot1", (0, 0, -16), (16, 16, 0));
}

helo_ai_dam_mon() {
  self endon("death");
  self.ridingvehicle endon("rt_helo_dead");
  self.ridingvehicle endon("rt_helo_delete");
  self.damageshield = 1;

  for(;;) {
    if(maps\_utility::player_can_see_ai(self)) {
      self.damageshield = 0;
      wait 0.5;
    } else if(!self.damageshield)
      self.damageshield = 1;

    wait 0.05;
  }
}

rt_falling_death() {
  self endon("no_falling_death");
  self waittill("death");
  self unlink();
}

init_helo(var_0) {
  var_1 = var_0.classname;

  if(isDefined(level.vehicle_hide_list[var_1])) {
    foreach(var_3 in level.vehicle_hide_list[var_1])
    var_0 hidepart(var_3);
  }

  var_5 = var_0.vehicletype;
  var_0 maps\_utility::ent_flag_init("unloaded");
  var_0 maps\_utility::ent_flag_init("loaded");
  var_0.riders = [];
  var_0.unloadque = [];
  var_0.unload_group = "default";
  var_0.fastroperig = [];

  if(isDefined(level.vehicle_attachedmodels) && isDefined(level.vehicle_attachedmodels[var_1])) {
    var_6 = level.vehicle_attachedmodels[var_1];
    var_7 = getarraykeys(var_6);

    foreach(var_9 in var_7) {
      var_0.fastroperig[var_9] = undefined;
      var_0.fastroperiganimating[var_9] = 0;
    }
  }

  if(isDefined(var_0.script_godmode))
    var_0.godmode = 1;

  var_0.damage_functions = [];
  var_0 thread maps\_vehicle_aianim::handle_attached_guys();
  var_0 thread maps\_vehicle_code::vehicle_rumble();

  if(isDefined(var_0.script_physicsjolt) && var_0.script_physicsjolt)
    var_0 thread maps\_utility::physicsjolt_proximity();

  if(isDefined(level.vehiclespawncallbackthread))
    level thread[[level.vehiclespawncallbackthread]](var_0);

  maps\_vehicle_code::vehicle_levelstuff(var_0);
  var_0 maps\_vehicle_code::spawn_group();
}

bmcd_debug_loop() {
  level notify("stop_cody_debug");

  for(;;) {
    if(level.player buttonpressed("DPAD_RIGHT")) {
      break;
    } else if(level.player buttonpressed("DPAD_LEFT") || level.player buttonpressed("DPAD_UP") || level.player buttonpressed("DPAD_DOWN")) {
      return;
    }
    wait 0.1;
  }

  iprintln("starting bmcd debug loop");
  wait 1;

  for(;;) {
    if(level.player buttonpressed("DPAD_LEFT")) {
      iprintln("blue");
      level._ally thread maps\_utility::set_force_color("b");
      wait 0.2;
    } else if(level.player buttonpressed("DPAD_RIGHT")) {
      iprintln("red");
      level._ally thread maps\_utility::set_force_color("r");
      wait 0.2;
    } else if(level.player buttonpressed("DPAD_UP")) {
      iprintln("dist check");
      thread temp_dist_check();
      wait 0.2;
    } else if(level.player buttonpressed("DPAD_DOWN")) {
      if(isDefined(level._ally.ignoreall) && level._ally.ignoreall) {
        iprintln("ignoreall off");
        level._ally maps\_utility::set_ignoreme(0);
        level._ally maps\_utility::set_ignoreall(0);
      } else {
        iprintln("ignoreall on");
        level._ally maps\_utility::set_ignoreme(1);
        level._ally maps\_utility::set_ignoreall(1);
      }

      wait 0.2;
    }

    wait 0.1;
  }
}

temp_dist_check() {
  level endon("stop_temp_dist_check");

  if(isDefined(level.test_dist_check)) {
    level.test_dist_check = undefined;
    level notify("stop_temp_dist_check");
  } else
    level.test_dist_check = 1;

  for(;;) {
    var_0 = distance(level.player.origin, level._train.cars["train_rt3"].sus_f.origin);
    iprintln(var_0);
    wait 0.1;
  }
}

temp_ref_check() {
  level endon("temp_ref_check");

  if(isDefined(level.test_ref_check)) {
    level.test_ref_check = undefined;
    level notify("temp_ref_check");
  } else
    level.test_ref_check = 1;

  for(;;) {
    var_0 = level.player_rumble_ent.origin;
    var_1 = level.player getEye();

    if(isDefined(distance(var_0 - var_1)))
      iprintln("delta: " + distance(var_0 - var_1));
    else
      iprintln("delta: 0");

    wait 0.05;
  }
}