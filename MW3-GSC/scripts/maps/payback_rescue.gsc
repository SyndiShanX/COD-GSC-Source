/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\payback_rescue.gsc
*******************************************/

_id_6505() {
  maps\payback_util::_id_594A("soap");
  maps\payback_util::_id_594A("price");
  maps\payback_util::_id_594A("nikolai");
  maps\payback_util::move_player_to_start();
}

_id_6506() {
  maps\_audio::aud_send_msg("s3_rescue");
  _id_6505();
  maps\payback_sandstorm_code::_id_5C03();
  common_scripts\utility::exploder(6000);
  objective_state(maps\_utility::_id_2816("obj_kruger"), "done");
  objective_state(maps\_utility::_id_2816("obj_secondary_lz"), "done");
  objective_state(maps\_utility::_id_2816("obj_find_chopper"), "current");
  maps\payback_env_code::_id_6507("s3_rescue");
  thread maps\payback_sandstorm_code::_id_6486("extreme", 0.051);
  thread _id_5698::_id_5682(5);
  maps\payback_sandstorm::_id_6508();
  maps\payback_util::_id_64D4();
  maps\_compass::setupminimap("compass_map_payback_sandstorm", "sandstorm_minimap_corner");
  thread _id_650E();

  if(!maps\_utility::_id_0A36()) {
    maps\payback_fx_sp::_id_6504();
  }
  wait 2;
  thread maps\payback_sandstorm::_id_6509();
  setsunflareposition((343.8, 313.993, 0));
  var_0 = getent("sslight_01", "targetname");
  var_0 setlightintensity(7);
  thread _id_5698::_id_5682(5);
  var_1 = getent("street_light_gate", "targetname");
  var_1 setlightintensity(3);
}

_id_650A() {
  maps\_audio::aud_send_msg("s3_escape");
  _id_6505();
  maps\payback_sandstorm_code::_id_5C03();
  common_scripts\utility::exploder(6000);
  _id_650C();
  objective_state(maps\_utility::_id_2816("obj_kruger"), "done");
  objective_state(maps\_utility::_id_2816("obj_secondary_lz"), "done");
  objective_state(maps\_utility::_id_2816("obj_find_chopper"), "done");
  objective_state(maps\_utility::_id_2816("obj_rescue"), "current");
  maps\payback_env_code::_id_6507("s3_escape");
  thread maps\payback_sandstorm_code::_id_6486("extreme", 0.051);
  maps\payback_sandstorm::_id_6508();
  maps\_compass::setupminimap("compass_map_payback_sandstorm", "sandstorm_minimap_corner");
  thread _id_650F();
  maps\payback_util::_id_64D4();
  _id_6578();
  _id_657D(1);
  thread _id_6562();
  thread _id_651C();

  if(!maps\_utility::_id_0A36()) {
    maps\payback_fx_sp::_id_6504();
  }
  wait 2;
  thread maps\payback_sandstorm::_id_6509();
  setsunflareposition((343.8, 313.993, 0));
}

_id_650B() {
  common_scripts\utility::flag_init("rescue_c4_aborted");
  common_scripts\utility::flag_init("carry_warn");
  common_scripts\utility::flag_init("carry_kill");
  common_scripts\utility::flag_init("slide_started");
  common_scripts\utility::flag_init("start_flare_fade");
  common_scripts\utility::flag_init("player_entering_jeep");
  common_scripts\utility::flag_init("player_in_jeep");
  common_scripts\utility::flag_init("price_at_ridge");
  common_scripts\utility::flag_init("start_nikolai_pullout_echo");
  common_scripts\utility::flag_init("player_in_escape_jeep");
  common_scripts\utility::flag_init("price_in_escape_jeep_1");
  common_scripts\utility::flag_init("spawn_follow_technical");
  common_scripts\utility::flag_init("stop_laser_handler");
  common_scripts\utility::flag_init("wait_to_move_follow_technical");
}

_id_650C() {
  if(!isDefined(level._id_650C)) {
    _id_657D(0);
    var_0 = getEntArray("rescue_escape_trigger", "script_noteworthy");

    foreach(var_2 in var_0) {}
    var_2 common_scripts\utility::trigger_off();

    var_4 = getEntArray("rescue_trigger_rpg", "targetname");
    common_scripts\utility::array_thread(var_4, ::_id_6580);
    level thread maps\payback_util::_id_64D6("rescue_begin");
    level thread maps\payback_util::_id_64D6("rescue_allies_at_chopper");
    level thread maps\payback_util::_id_64D6("rescue_player_warn");
    level thread maps\payback_util::_id_64D6("rescue_trigger_drone_wake");
    level thread maps\payback_util::_id_64D6("rescue_escape_dialogue");
    level thread maps\payback_util::_id_64D6("rescue_kill_nikolai");
    level thread maps\payback_util::_id_64D6("run_objective_spot_2");
    level thread maps\payback_util::_id_64D6("run_objective_spot_3");
    level thread maps\payback_util::_id_64D6("start_player_slide");
    level thread maps\payback_util::_id_64D6("start_flare");
    level thread maps\payback_util::_id_64D6("run_objective_spot_jeep");
    level thread maps\payback_util::_id_64D6("jeep_escape_rpg_1");
    level thread maps\payback_util::_id_64D6("jeep_escape_rpg_2");
    level thread maps\payback_util::_id_64D6("jeep_escape_rpg_3");
    level thread maps\payback_util::_id_64D6("price_check_anim_ref_2");
    level thread maps\payback_util::_id_64D6("price_check_anim_ref_3");
    level thread maps\payback_util::_id_64D6("price_check_anim_ref_4");
    level thread maps\payback_util::_id_64D6("soap_check_anim_ref_2");
    level thread maps\payback_util::_id_64D6("soap_check_anim_ref_3");
    level thread maps\payback_util::_id_64D6("soap_check_anim_ref_4");
    level thread maps\payback_util::_id_64D6("soap_check_anim_ref_5");
    level thread maps\payback_util::_id_64D6("final_technicals");
    level thread maps\payback_util::_id_64D6("ridge_contain");
    level thread maps\payback_util::_id_64D6("winning");
    var_5 = getent("jeep_flare", "targetname");
    var_5 setlightintensity(0);

    if(!isDefined(level._id_64A5)) {
      maps\payback_util::_id_594A("nikolai", "s3_rescue_nikolai");
      level._id_64A5.ignoreall = 1;
    }

    level._id_650D = common_scripts\utility::getstruct("chopper_rescue_reference", "targetname");
    level thread _id_6520();
    level._id_650C = 1;
    thread _id_651D();
    thread _id_6514();
  }
}

_id_650E() {
  _id_650C();
  self notify("rescue_thread");
  self endon("rescue_thread");
  thread _id_6562();
  thread _id_650F();
  _id_6578();
  level waittill("rescue_begin");
  _id_6510();
}

_id_650F() {
  common_scripts\utility::flag_wait("use_exit_minimap");
  maps\_compass::setupminimap("compass_map_payback_exit", "exit_minimap_corner");
}

_id_6510() {
  maps\_audio::aud_send_msg("begin_npc_weapon_audio_hack");
  thread _id_6564();
  thread _id_6512();
  thread _id_6511();
  level waittill("all_pre_rescue_enemies_dead");
  objective_state(maps\_utility::_id_2816("obj_find_chopper"), "done");
  var_0 = common_scripts\utility::getstruct("rescue_nikolai_obj_spot", "targetname");
  objective_state(maps\_utility::_id_2816("obj_rescue"), "current");
  objective_position(maps\_utility::_id_2816("obj_rescue"), var_0.origin);
  thread _id_6513();
  _id_651C();
}

_id_6511() {
  level endon("disable_clear_chopper_obj_spot");
  common_scripts\utility::flag_wait("clear_chopper_obj_spot");
  objective_position(maps\_utility::_id_2816("obj_rescue"), (0, 0, 0));
}

_id_6512() {
  common_scripts\utility::flag_wait("rescue_intro_firing_at_nikolai");
  var_0 = maps\payback_util::_id_5DD7("rescue_intro_firing_at_nikolai");
  var_1 = getent("rescue_intro_fire_at_nikolai_spot", "targetname");

  foreach(var_3 in var_0) {
    var_3 setentitytarget(var_1);
    var_3 thread maps\payback_sandstorm_code::_id_648A();
    var_3 thread _id_651A();
  }

  maps\payback_util::_id_64F2(var_0, "rescue_intro");
  var_0 = maps\_utility::_id_1361(var_0);

  foreach(var_3 in var_0) {
    var_3 clearentitytarget();
    var_3 notify("rescue_end_shoot_at_target_thread");
    var_3.fixednode = 0;
  }

  maps\_utility::_id_2636(var_0);
  maps\_utility::_id_26BF("rescue_intro_post_combat");
  level notify("all_pre_rescue_enemies_dead");
}

_id_6513() {
  level endon("pickup_nikolai_vo_started");
  level._id_54E0 maps\_utility::_id_168C("payback_mct_theresnikschopper");
  maps\_audio::aud_send_msg("mus_rescue_start_nikolai_music");
  wait 0.2;
  level._id_4877 maps\_utility::_id_168C("payback_pri_echoteampinned");
  wait 0.2;
  level._id_4877 maps\_utility::_id_168C("payback_pri_fromnorthwest");
  wait 0.1;
  maps\_utility::_id_11F4("payback_eol_copythat");
  maps\_audio::aud_send_msg("mus_nikolai");
}

_id_6514() {
  level endon("clear_echo_stuff");
  setlasermaterial("gfx_laser_bright", "");
  level._id_6515 = getent("rescue_echo_1_spawner", "targetname") maps\_utility::_id_166F(1);
  level._id_6515 maps\_utility::_id_0D04();
  level._id_6515._id_1032 = "rescue_echo_1";
  level._id_6515._id_6516 = level._effect["dust_kickup"];
  level._id_6515._id_6517 = "j_mainroot";
  level._id_6515 thread _id_651B();
  level._id_6515 thread _id_6528();
  level._id_6518 = getent("rescue_echo_2_spawner", "targetname") maps\_utility::_id_166F(1);
  level._id_6518 maps\_utility::_id_0D04();
  level._id_6518._id_1032 = "rescue_echo_2";
  level._id_6518 thread _id_651B();
  level._id_6518._id_6516 = level._effect["dust_kickup"];
  level._id_6518._id_6517 = "j_mainroot";
  level._id_6518 thread _id_6528();
  level._id_6519 = getent("rescue_echo_3_spawner", "targetname") maps\_utility::_id_166F(1);
  level._id_6519 maps\_utility::_id_0D04();
  level._id_6519._id_1032 = "rescue_echo_3";
  level._id_6519 thread _id_6528();
  level._id_6519._id_59C3 = 1;
  level._id_6519.ignoreme = 1;
  common_scripts\utility::flag_wait("start_nikolai_pullout_echo");
  level._id_6519 laserforceoff();
  level._id_650D maps\_anim::_id_1246(level._id_6519, "payback_sstorm_chopper_rescue_echo_pullout");
  level._id_6519 setgoalnode(getnode("rescue_echo_3_end_spot", "targetname"));
  level._id_6519 waittill("goal");
  level._id_6519._id_59C3 = 0;
  level._id_6519.ignoreme = 0;
  level._id_6519 thread _id_651B();
}

_id_651A() {
  self endon("death");
  common_scripts\utility::flag_wait("start_nikolai_pullout_echo");

  if(isDefined(self) && isalive(self)) {
    self kill();
  }
}

_id_651B() {
  level endon("stop_laser_handler");
  var_0 = 1;

  while(!common_scripts\utility::flag("stop_laser_handler")) {
    if(animscripts\utility::_id_0CE3() && var_0) {
      self laserforceon();
      var_0 = 0;
    } else if(!animscripts\utility::_id_0CE3() && !var_0) {
      self laserforceoff();
      var_0 = 1;
    }

    wait(randomfloatrange(0.25, 0.5));
  }
}

_id_651C() {
  _id_657D(1);
  level._id_4877 maps\_utility::_id_123B();
  level._id_54E0 maps\_utility::_id_123B();
  level._id_4877.goalradius = 128;
  level._id_54E0.goalradius = 128;
  level._id_4877 maps\_utility::_id_265A();
  level._id_54E0 maps\_utility::_id_265A();
  level._id_4877 thread _id_6528();
  level._id_54E0 thread _id_6528();
  thread _id_656E();
  level._id_54E0._id_2199 = 0;
  level._id_54E0 setgoalnode(getnode("rescue_soap_chopper", "targetname"));
}

_id_651D() {
  wait 0.5;
  level.player endon("death");

  for(;;) {
    var_0 = getaiarray("axis");
    var_0 = maps\_utility::_id_0AEC(level.player.origin, var_0, undefined, 4);

    if(var_0.size > 0) {
      var_1 = randomintrange(0, var_0.size);
      var_2 = var_0[var_1];
      var_2 maps\_utility::_id_1EFE("order_move_combat");
    }

    wait(randomfloatrange(1.5, 5.0));
  }
}

_id_651E() {
  level endon("rescue_picking_up_nikolai");
  level notify("pickup_nikolai_vo_started");
  common_scripts\utility::flag_wait("player_near_crashed_chopper");
  level._id_4877 maps\_utility::_id_168C("payback_pri_goodtoseeyou");
  wait 0.5;
  level._id_6515 maps\_utility::_id_168C("payback_eol_twovehicles");
  common_scripts\utility::trigger_on("ready_to_pick_up_niko_save_trig", "targetname");
  wait 0.5;
  level._id_4877 maps\_utility::_id_168C("payback_pri_suppress");
  wait 4;

  for(;;) {
    level._id_4877 maps\_utility::_id_168C("payback_pri_getnikolai");
    wait 4;
    level._id_4877 maps\_utility::_id_168C("payback_pri_grabnikolai");
    wait 4;
    level._id_4877 maps\_utility::_id_168C("payback_pri_waitingfor");
    wait 4;
  }
}

_id_651F() {
  level.player._id_20F2._id_22F5 = 2;
  level.player._id_20F2._id_22F6 = 2;
  level.player._id_20F2._id_22F4 = 2;
  level.player._id_20F2._id_22F9 = 500;
  level.player._id_20F2._id_22FC = 0.1;
  level.player._id_20F2.playerhealth_regularregendelay = 500;
  level.player._id_20F2._id_22F6 = 2;
  level.player._id_20F2._id_22FB = 0.1;
  level.player._id_20F2._id_22F8 = 0.01;
}

_id_6520() {
  level waittill("rescue_kill_nikolai");
  level._id_6521 delete();
  level._id_650D thread maps\_anim::_id_1246(level._id_64A5, "rescue_nikolai_death");
  level._id_64A5.allowdeath = 1;
  level._id_64A5 maps\_utility::_id_1902();
  magicbullet("ak47", level._id_64A5 getEye() + (0, 0, 10), level._id_64A5 getEye());
  level._id_64A5 kill();
  wait 1;
  setDvar("ui_deadquote", "@PAYBACK_NIKOLAI_KILLED");
  maps\_utility::_id_1826();
}

_id_6522() {
  var_0 = getEntArray("rescue_escape_trigger", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 common_scripts\utility::trigger_on();

    if(isDefined(var_2._id_164F) && var_2._id_164F == "phantom_fire") {
      var_2 thread _id_657F();
    }
  }
}

_id_6523() {
  _id_6522();
  _id_657D(0);
  var_0 = common_scripts\utility::getStructArray("rescue_phantom_fire_source1", "targetname");
  thread maps\payback_util::_id_64E9(level.player, "ak47", var_0, 0.05, 1.5, 3000, 5000);
  level waittill("rescue_escape_dialogue");
  level notify("stop_rescue_respawns");
}

_id_6524() {
  thread _id_6529();
  thread _id_652A();
  thread _id_652B();
  thread _id_652C();
  thread _id_652D();
  thread _id_6525();
  thread _id_6536();
}

_id_6525() {
  level waittill("start_flare");
  maps\_audio::aud_send_msg("mus_rescue_music_day_saved");
  thread _id_6526::_id_409C("jeep_escape_flare");
  thread _id_52A4();
  level waittill("flare_done");
  common_scripts\utility::flag_set("start_flare_fade");
}

_id_52A4() {
  var_0 = getent("jeep_flare", "targetname");
  level waittill("flare_explodes");
  var_0 setlightintensity(6.0);
  var_0 setlightradius(1800);
  common_scripts\utility::flag_wait("start_flare_fade");
  var_1 = 1;
  var_2 = 0;
  var_3 = var_0 getlightintensity();

  while(var_2 < var_1) {
    var_2 = var_2 + 0.05;
    var_0 setlightintensity((var_1 - var_2) / var_1 * var_3);
    wait 0.05;
  }
}

_id_6527() {
  self clearenemy();
  self.ignoreall = 1;
  self.goalradius = 32;
  self.ignoreexplosionevents = 1;
  self.grenadeawareness = 0;
  self._id_59C3 = 1;
  self.ignoreme = 1;
  self.ignoresuppression = 1;
  self.suppressionwait = 0;
  self._id_0EEE = 1;
  self.ignorerandombulletdamage = 1;
  thread maps\_utility::_id_1057();
  thread maps\_utility::_id_0EEC();
  self allowedstances("stand");
  self.badplaceawareness = 0;
}

_id_6528() {
  self.ignoreexplosionevents = 1;
  self.grenadeawareness = 0;
  self.ignoresuppression = 1;
  self.suppressionwait = 0;
  self._id_0EEE = 1;
  self.ignorerandombulletdamage = 1;
  thread maps\_utility::_id_1057();
  thread maps\_utility::_id_0EEC();
  self.badplaceawareness = 0;
}

_id_6529() {
  level._id_4877 _id_6527();
  thread _id_6531();
}

_id_652A() {
  level._id_54E0 _id_6527();
  thread _id_6532();
}

_id_652B() {
  var_0 = common_scripts\utility::getstruct("slide_ref", "targetname");
  level waittill("move_echo_2_and_3");
  level._id_6515 maps\_utility::_id_27A1(getnode("rescue_echo_1_run_start_spot", "targetname"));
  level._id_6515 _id_6527();
  level._id_6515 laserforceoff();
  var_0 maps\_anim::_id_124A(level._id_6515, "rescue_echo_1_slide");
  var_0 maps\_anim::_id_1246(level._id_6515, "rescue_echo_1_slide");
  level._id_6515 setgoalnode(getnode("rescue_echo_1_goal", "targetname"));
  var_1 = common_scripts\utility::getstruct("shoot_echo_1_and_2_bullet_spot", "targetname");
  level._id_6515 waittill("goal");
  level._id_6515 maps\_utility::_id_1902();
  magicbullet("ak47", var_1.origin, level._id_6515 gettagorigin("J_SpineUpper") + (4, 2, 10));
  wait 0.1;
  magicbullet("ak47", var_1.origin, level._id_6515 gettagorigin("J_SpineUpper") + (10, 12, 5));
  wait 0.1;
  magicbullet("ak47", var_1.origin, level._id_6515 gettagorigin("J_SpineUpper") + (7, 3, 8));
  wait 0.1;
  magicbullet("ak47", var_1.origin, level._id_6515 gettagorigin("J_SpineUpper") + (4, 2, 10));

  if(isDefined(level._id_6515) && isalive(level._id_6515)) {
    level._id_6515 kill();
  }
}

_id_652C() {
  var_0 = common_scripts\utility::getstruct("slide_ref", "targetname");
  level waittill("move_echo_2_and_3");
  level._id_6518 maps\_utility::_id_27A1(getnode("rescue_echo_2_run_start_spot", "targetname"));
  level._id_6518 _id_6527();
  level._id_6518 laserforceoff();
  var_0 maps\_anim::_id_124A(level._id_6518, "rescue_echo_2_slide");
  var_0 maps\_anim::_id_1246(level._id_6518, "rescue_echo_2_slide");
  level._id_6518 setgoalnode(getnode("rescue_echo_2_goal", "targetname"));
  var_1 = common_scripts\utility::getstruct("shoot_echo_1_and_2_bullet_spot", "targetname");
  level._id_6518 waittill("goal");
  level._id_6518 maps\_utility::_id_1902();
  magicbullet("ak47", var_1.origin, level._id_6518 gettagorigin("J_SpineUpper") + (4, 2, 10));
  wait 0.1;
  magicbullet("ak47", var_1.origin, level._id_6518 gettagorigin("J_SpineUpper") + (10, 12, 5));
  wait 0.1;
  magicbullet("ak47", var_1.origin, level._id_6518 gettagorigin("J_SpineUpper") + (7, 3, 8));
  wait 0.1;
  magicbullet("ak47", var_1.origin, level._id_6518 gettagorigin("J_SpineUpper") + (4, 2, 10));

  if(isDefined(level._id_6518) && isalive(level._id_6518)) {
    level._id_6518 kill();
  }
}

_id_652D() {
  var_0 = common_scripts\utility::getstruct("rescue_echo_3_bullet_spot", "targetname");
  level waittill("move_echo_2_and_3");
  level._id_6519 maps\_utility::_id_27A1(getnode("rescue_echo_3_run_start_spot", "targetname"));
  level._id_6519 _id_6527();
  level._id_6519 setgoalnode(getnode("rescue_echo_3_goal", "targetname"));
  level._id_6519._id_0D50 = maps\_utility::_id_270F("echo_stumble_forward_death");
  level._id_6519 waittill("goal");
  level._id_6519 maps\_utility::_id_1902();
  magicbullet("ak47", var_0.origin, level._id_6519 gettagorigin("J_SpineUpper") + (4, 2, 10));
  wait 0.1;
  magicbullet("ak47", var_0.origin, level._id_6519 gettagorigin("J_SpineUpper") + (10, 12, 5));
  wait 0.1;
  magicbullet("ak47", var_0.origin, level._id_6519 gettagorigin("J_SpineUpper") + (7, 3, 8));
  wait 0.1;
  magicbullet("ak47", var_0.origin, level._id_6519 gettagorigin("J_SpineUpper") + (4, 2, 10));

  if(isDefined(level._id_6519) && isalive(level._id_6519)) {
    level._id_6519 kill();
  }
}

_id_652E() {
  level endon("notify_slide_started");

  while(!common_scripts\utility::flag("slide_started")) {
    var_0 = distancesquared(level.player.origin, level._id_54E0.origin);
    var_1 = distancesquared(level.player.origin, level._id_4877.origin);

    if(var_0 > 1000000 && var_1 > 1000000) {
      level notify("disable_ignore_player_triggers");
      level.player enabledeathshield(0);
      level.player._id_652F = 0;
      level.player disableinvulnerability();
      setDvar("ui_deadquote", "@PAYBACK_KEEP_UP");
      magicbullet("ak47", level.player.origin + (0, 50, 200), level.player.origin);
      wait 0.05;
      magicbullet("ak47", level.player.origin + (0, 40, 220), level.player.origin);
      wait 0.05;
      magicbullet("ak47", level.player.origin + (0, 50, 230), level.player.origin);
      wait 0.05;
      magicbullet("ak47", level.player.origin + (0, 30, 180), level.player.origin);
      wait 0.05;

      if(isalive(level.player)) {
        level.player kill();
        maps\_utility::_id_1826();
      }

      return;
    }

    wait 1;
  }
}

_id_6530() {
  level endon("notify_slide_started");
  common_scripts\utility::flag_wait("price_at_ridge");
  wait 7;
  level.player disableinvulnerability();
  wait 7;
  setDvar("ui_deadquote", "@PAYBACK_KEEP_UP");
  magicbullet("ak47", level.player.origin + (0, 50, 200), level.player.origin);
  wait 0.05;
  magicbullet("ak47", level.player.origin + (0, 40, 220), level.player.origin);
  wait 0.05;
  magicbullet("ak47", level.player.origin + (0, 50, 230), level.player.origin);
  wait 0.05;
  magicbullet("ak47", level.player.origin + (0, 30, 180), level.player.origin);
  wait 0.05;

  if(isalive(level.player)) {
    level.player kill();
    maps\_utility::_id_1826();
  }
}

_id_6531() {
  level endon("notify_slide_started");
  level._id_4877._id_0FC6 = 1.2;
  level._id_4877._id_10F7 = 1.2;
  wait 1;
  var_0 = common_scripts\utility::getstruct("price_run_anim_ref_1", "targetname");
  var_1 = common_scripts\utility::getstruct("price_run_anim_ref_2", "targetname");
  var_2 = common_scripts\utility::getstruct("price_run_anim_ref_2_debris", "targetname");
  var_3 = maps\_utility::_id_1287("escape_debris");
  var_3._id_10F7 = 1.2;
  var_2 thread maps\_anim::_id_11CF(var_3, "escape_debris_dodge");
  var_4 = common_scripts\utility::getstruct("price_run_anim_ref_3", "targetname");
  var_5 = common_scripts\utility::getstruct("price_dodge_rpg_spot", "targetname");
  var_6 = common_scripts\utility::getstruct(var_5.target, "targetname");
  var_7 = common_scripts\utility::getstruct("price_run_anim_ref_4", "targetname");
  var_8 = getnode("price_run_spot_4", "targetname");
  var_9 = getnode("price_rpg_dodge_alt", "targetname");
  var_0 maps\_anim::_id_11CF(level._id_4877, "payback_escape_start_backpedal_price");
  wait 3.5;
  level._id_4877.a._id_0D26 = "stand";
  level._id_4877.a._id_0D2B = "run";
  var_0 maps\_anim::_id_1247(level._id_4877, "payback_escape_start_backpedal_price");
  level notify("move_echo_1");
  var_1 maps\_anim::_id_124A(level._id_4877, "escape_debris_dodge");

  if(!common_scripts\utility::flag("price_check_anim_ref_2")) {
    var_2 thread maps\_anim::_id_1246(var_3, "escape_debris_dodge");
    var_1 maps\_anim::_id_1247(level._id_4877, "escape_debris_dodge");
  }

  var_4 maps\_anim::_id_124A(level._id_4877, "payback_escape_rpg_react_price");
  magicbullet("rpg_straight", var_5.origin, var_6.origin, level.player);

  if(!common_scripts\utility::flag("price_check_anim_ref_3")) {
    var_4 maps\_anim::_id_1247(level._id_4877, "payback_escape_rpg_react_price");
  } else {
    level._id_4877 setgoalnode(var_9);
    level._id_4877 waittill("goal");
  }

  var_7 maps\_anim::_id_124A(level._id_4877, "payback_escape_forward_wave_right_price");

  if(!common_scripts\utility::flag("price_check_anim_ref_4")) {
    var_7 maps\_anim::_id_1247(level._id_4877, "payback_escape_forward_wave_right_price");
  }
  level._id_4877.goalradius = 64;
  level._id_4877 setgoalnode(var_8);
  level._id_4877 waittill("goal");
  common_scripts\utility::flag_set("price_at_ridge");
  level._id_4877 allowedstances("stand");
  level._id_4877._id_10F7 = 1;
  level._id_4877._id_0FC6 = 1;
  level._id_4877.ignoreall = 0;
  level._id_4877._id_59C3 = 0;
  level._id_4877.ignoreme = 0;
}

_id_6532() {
  level endon("notify_slide_started");
  level._id_54E0._id_0FC6 = 1.2;
  level._id_54E0._id_6517 = "j_mainroot";
  level._id_54E0._id_6516 = level._effect["dust_kickup"];
  level._id_54E0._id_10F7 = 1.3;
  var_0 = common_scripts\utility::getstruct("soap_run_anim_ref_1", "targetname");
  var_1 = common_scripts\utility::getstruct("soap_run_anim_ref_2", "targetname");
  var_2 = common_scripts\utility::getstruct("soap_run_anim_ref_3", "targetname");
  var_3 = common_scripts\utility::getstruct("soap_run_anim_ref_4", "targetname");
  var_4 = common_scripts\utility::getstruct("soap_run_anim_ref_5", "targetname");
  var_5 = getnode("soap_slide_goal", "targetname");
  var_0 maps\_anim::_id_11CF(level._id_54E0, "payback_escape_start_wave_soap");
  wait 4.4;
  level notify("move_echo_2_and_3");
  level._id_54E0.a._id_0D26 = "stand";
  level._id_54E0.a._id_0D2B = "run";
  var_0 maps\_anim::_id_1247(level._id_54E0, "payback_escape_start_wave_soap");
  var_1 maps\_anim::_id_124A(level._id_54E0, "payback_escape_turn_shoot_wave_soap");

  if(!common_scripts\utility::flag("soap_check_anim_ref_2")) {
    var_1 maps\_anim::_id_1247(level._id_54E0, "payback_escape_turn_shoot_wave_soap");
  }
  var_2 maps\_anim::_id_124A(level._id_54E0, "payback_escape_hood_slide_soap");

  if(!common_scripts\utility::flag("soap_check_anim_ref_3")) {
    maps\_audio::aud_send_msg("soap_hood_slide");
    var_2 maps\_anim::_id_1247(level._id_54E0, "payback_escape_hood_slide_soap");
  }

  var_3 maps\_anim::_id_124A(level._id_54E0, "payback_escape_forward_wave_left_soap");

  if(!common_scripts\utility::flag("soap_check_anim_ref_4")) {
    var_3 maps\_anim::_id_1247(level._id_54E0, "payback_escape_forward_wave_left_soap");
  }
  var_4 maps\_anim::_id_124A(level._id_54E0, "payback_escape_turn_shoot_wave_soap");

  if(!common_scripts\utility::flag("soap_check_anim_ref_5")) {
    var_4 maps\_anim::_id_1247(level._id_54E0, "payback_escape_turn_shoot_wave_soap");
  }
  level._id_54E0.goalradius = 64;
  level._id_54E0 setgoalnode(var_5);
  level._id_54E0 waittill("goal");
  level._id_4877 allowedstances("stand");
  level._id_54E0._id_10F7 = 1;
  level._id_54E0._id_0FC6 = 1;
  level._id_54E0.ignoreall = 0;
  level._id_54E0._id_59C3 = 0;
  level._id_54E0.ignoreme = 0;
}

_id_6533() {
  level._id_6534 waittill("trigger");
  common_scripts\utility::flag_set("player_in_escape_jeep");
  level notify("player_jumping_in_jeep");
}

_id_6535(var_0, var_1) {
  level.player playerlinktoblend(var_0, "tag_player", var_1);
}

_id_6536() {
  level.player endon("death");
  thread _id_6560();
  thread _id_654B();
  var_0 = [];
  level._id_6537 = common_scripts\utility::getstruct("slide_ref", "targetname");
  level._id_6538 = maps\_vehicle::_id_2A99("escape_jeep_1");
  level._id_6538 setCanDamage(0);
  level._id_6538 maps\_vehicle::_id_2B17();
  level._id_6534 = getent("player_enter_jeep_trigger", "targetname");
  level._id_6539 = spawn("script_model", level._id_6538.origin);
  level._id_6539 linkto(level._id_6538, "tag_brakelight_right", (0, 0, 0), (0, 0, 0));
  level._id_653A = maps\_vehicle::_id_2A99("escape_jeep_2");
  level._id_653A setCanDamage(0);
  level._id_653A maps\_vehicle::_id_2B17();
  thread _id_6558();
  thread _id_6552();
  thread _id_6553();
  level._id_653B = getent("escape_jeep_1_driver", "targetname") maps\_utility::_id_166F(1);
  level._id_653B maps\_utility::_id_0D04();
  level._id_653B maps\_utility::_id_265A();
  level._id_653B maps\_utility::_id_24F5();
  level._id_653B._id_1032 = "escape_jeep_1_driver";
  level._id_653B linkto(level._id_6538, "tag_driver", (0, 0, 0), (0, 0, 0));
  level._id_6538 thread maps\_anim::_id_124E(level._id_653B, "escape_jeep_1_driver_loop", "stop_escape_jeep_1_driver_loop_1", "tag_driver");
  level._id_653C = getent("escape_jeep_2_driver", "targetname") maps\_utility::_id_166F(1);
  level._id_653C maps\_utility::_id_0D04();
  level._id_653C maps\_utility::_id_265A();
  level._id_653C maps\_utility::_id_24F5();
  level._id_653C._id_1032 = "escape_jeep_2_driver";
  level._id_653C linkto(level._id_653A, "tag_driver", (0, 0, 0), (0, 0, 0));
  level._id_653A thread maps\_anim::_id_124E(level._id_653C, "escape_jeep_2_driver_loop", "stop_escape_jeep_2_driver_loop_1", "tag_driver");
  level._id_653D = getent("escape_jeep_1_gunner", "targetname") maps\_utility::_id_166F(1);
  level._id_653D maps\_utility::_id_0D04();
  level._id_653D laserforceon();
  level._id_653D._id_1032 = "escape_jeep_1_gunner";
  level._id_653D linkto(level._id_6538, "tag_passenger", (0, 0, 0), (0, 0, 0));
  level._id_6538 thread maps\_anim::_id_124E(level._id_653D, "escape_jeep_1_gunner_shoot_loop", "stop_gunner_1_shoot_loop", "tag_passenger");
  level._id_653E = getent("escape_jeep_2_gunner", "targetname") maps\_utility::_id_166F(1);
  level._id_653E maps\_utility::_id_0D04();
  level._id_653E laserforceon();
  level._id_653E._id_1032 = "escape_jeep_2_gunner";
  level._id_653E linkto(level._id_653A, "tag_guy0", (0, 0, 0), (0, 0, 0));
  level._id_653A thread maps\_anim::_id_124E(level._id_653E, "escape_jeep_2_gunner_shoot_loop", "stop_gunner_2_shoot_loop", "tag_guy0");
  level._id_653F = getent("nikolai_jeep_escape", "targetname") maps\_utility::_id_166F(1);
  level._id_653F._id_1032 = "nikolai_jeep_escape";
  level._id_653F setCanDamage(0);
  level._id_653F maps\_utility::_id_265A();
  level._id_653F.ignoreall = 1;
  level._id_653F.ignoreme = 1;
  level._id_653F maps\_utility::_id_24F5();
  level._id_653F hide();
  level._id_653F._id_6516 = level._effect["dust_kickup"];
  level._id_653F._id_6517 = "j_mainroot";
  var_0 = maps\_utility::_id_0BC3(var_0, level._id_653F);
  level._id_6537 thread maps\_anim::_id_11CF(level._id_653F, "jeep_slide_escape");
  var_0 = maps\_utility::_id_0BC3(var_0, level._id_4877);
  level._id_4877._id_6517 = "j_mainroot";
  level._id_4877._id_6516 = level._effect["dust_kickup"];
  var_0 = maps\_utility::_id_0BC3(var_0, level._id_54E0);
  level._id_6540 = maps\_utility::_id_1287("player_slide_arms");
  var_0 = maps\_utility::_id_0BC3(var_0, level._id_6540);
  level._id_6540 hide();
  level._id_6537 thread maps\_anim::_id_11CF(level._id_6540, "jeep_slide_escape");
  level._id_6540 thread _id_6555();
  level._id_6541 = maps\_utility::_id_1287("player_slide_legs");
  var_0 = maps\_utility::_id_0BC3(var_0, level._id_6541);
  level._id_6541 hide();
  level._id_6541._id_6516 = level._effect["dust_kickup"];
  level._id_6541._id_6517 = "j_ankle_le";
  level._id_6537 thread maps\_anim::_id_11CF(level._id_6541, "jeep_slide_escape");
  level._id_6542 = maps\_utility::_id_1287("player_jeep_arms");
  level._id_6542 hide();
  level._id_6542 linkto(level._id_6538, "tag_guy1", (0, 0, 0), (0, 0, 0));
  level._id_6542 thread maps\_anim::_id_11CF(level._id_6542, "end_mount");
  level._id_6542 thread _id_6557();
  common_scripts\utility::flag_wait("start_player_slide");
  level._id_6543 = missile_createrepulsorent(level._id_4877, 5000, 200);
  level._id_6544 = missile_createrepulsorent(level._id_54E0, 5000, 200);
  level._id_6545 = missile_createrepulsorent(level.player, 5000, 200);
  level._id_6546 = missile_createrepulsorent(level._id_653F, 5000, 200);
  var_1 = missile_createrepulsorent(level._id_6538, 5000, 200);
  var_2 = missile_createrepulsorent(level._id_653A, 5000, 200);
  level.player enableinvulnerability();
  level.player.health = level.player.maxhealth;
  level.player freezecontrols(1);
  level.player setstance("stand");
  level.player disableweapons();
  thread _id_6575();
  common_scripts\utility::flag_set("slide_started");
  level notify("notify_slide_started");
  level._id_653F common_scripts\utility::delaycall(1, ::show);
  level._id_4877 maps\_utility::_id_1414();
  level._id_54E0 maps\_utility::_id_1414();
  level._id_54E0._id_10F7 = 1;
  level._id_54E0._id_0FC6 = 1;
  level._id_4877._id_10F7 = 1;
  level._id_4877._id_0FC6 = 1;
  wait 0.05;
  maps\_audio::aud_send_msg("outro_slide_start");
  level._id_6537 thread maps\_anim::_id_11DD(var_0, "jeep_slide_escape");
  level._id_6540 thread _id_6547();
  level._id_4877 thread _id_6550();
  level._id_54E0 thread _id_6551();
  level._id_653F thread _id_6554();
  maps\_utility::delaythread(0.05, ::_id_6535, level._id_6540, 0.25);
  level._id_6541 common_scripts\utility::delaycall(1, ::show);
}

_id_6547() {
  self waittillmatch("single anim", "slide_fx_on");
  level.player playrumbleonentity("light_1s");
  wait 0.4;
  level.player playrumblelooponentity("subtle_tank_rumble");
  self waittillmatch("single anim", "slide_fx_off");
  level.player stoprumble("subtle_tank_rumble");
}

_id_6548() {
  maps\_utility::_id_27CA("jeep_escape_enemies", maps\payback_sandstorm_code::_id_648A);
  maps\_utility::_id_272C("jeep_escape_enemies", 1);
}

_id_6549(var_0, var_1) {
  var_2 = maps\_vehicle::_id_2A99(var_0);
  var_2._id_2955 = 1;
  var_2 maps\_vehicle::_id_2B17();
  level waittill(var_1);
  var_2 maps\_vehicle::_id_1FA6();
}

_id_654A() {
  level endon("player_jumping_in_jeep");
  common_scripts\utility::flag_wait("ridge_contain");

  if(!common_scripts\utility::flag("player_in_escape_jeep")) {
    level.player disableinvulnerability();
    level.player enabledeathshield(0);
    setDvar("ui_deadquote", "@PAYBACK_RUN_TO_JEEP");
    magicbullet("ak47", level.player.origin + (0, 50, 200), level.player.origin);
    wait 0.05;
    magicbullet("ak47", level.player.origin + (0, 40, 220), level.player.origin);
    wait 0.05;
    magicbullet("ak47", level.player.origin + (0, 50, 230), level.player.origin);
    wait 0.05;
    magicbullet("ak47", level.player.origin + (0, 30, 180), level.player.origin);
    wait 0.05;

    if(isalive(level.player)) {
      level.player kill();
      maps\_utility::_id_1826();
    }
  }
}

_id_654B() {
  common_scripts\utility::flag_wait("final_technicals");
  thread _id_655D();
  thread _id_655E();
  common_scripts\utility::flag_wait("winning");

  if(common_scripts\utility::flag("player_in_escape_jeep")) {
    thread _id_654D();

    if(isalive(level._id_654C)) {
      level._id_654C maps\_vehicle::_id_2A11();
    }
    wait 1;
    objective_state(maps\_utility::_id_2816("obj_rescue"), "done");
    level._id_653A notify("stop_soap_new_fire_loop");
    thread _id_02A6();
    wait 4;
    level.player thread maps\payback_util::_id_64E0(1, 2);
    level._id_02A5 maps\_utility::_id_27AE(4);
    wait 6;
    maps\payback_util::_id_64A9();
    maps\_utility::_id_195A();
  }
}

_id_02A6() {
  level._id_653B maps\_utility::_id_168C("payback_eol_glad");
  wait 0.5;
  maps\_utility::_id_11F4("payback_mct_inparis");
  wait 0.5;
  level._id_4877 maps\_utility::_id_168C("payback_pri_iknowwho");
}

_id_654D() {
  wait 0.5;

  if(isalive(level._id_654E)) {
    level._id_654E maps\_vehicle::_id_2A11();
  }
}

_id_654F() {
  level endon("player_jumping_in_jeep");
  level.player.ignoreme = 1;
  wait 4;
  thread _id_655F();
  wait 6;
  level.player.ignoreme = 0;
  wait 5;

  if(!common_scripts\utility::flag("player_in_escape_jeep")) {
    level.player disableinvulnerability();
    level.player enabledeathshield(0);
    setDvar("ui_deadquote", "@PAYBACK_RUN_TO_JEEP");
    magicbullet("ak47", level.player.origin + (0, 50, 200), level.player.origin);
    wait 0.05;
    magicbullet("ak47", level.player.origin + (0, 40, 220), level.player.origin);
    wait 0.05;
    magicbullet("ak47", level.player.origin + (0, 50, 230), level.player.origin);
    wait 0.05;
    magicbullet("ak47", level.player.origin + (0, 30, 180), level.player.origin);
    wait 0.05;

    if(isalive(level.player)) {
      level.player kill();
      maps\_utility::_id_1826();
    }
  }
}

_id_6550() {
  self waittillmatch("single anim", "end");
  level._id_4877 linkto(level._id_6538, "tag_guy0", (0, 0, 0), (0, 0, 0));
  common_scripts\utility::flag_set("price_in_escape_jeep_1");
  level._id_6538 thread maps\_anim::_id_124E(level._id_4877, "price_jeep_shoot_loop", "stop_price_jeep_wave_and_shoot_loop", "tag_guy0");
  level._id_6538 waittill("stop_price_jeep_wave_and_shoot_loop");
  level._id_6538 maps\_anim::_id_1246(level._id_4877, "price_jeep_sit_down", "tag_guy0");
  level._id_6538 thread maps\_anim::_id_124E(level._id_4877, "price_back_jeep_loop", "stop_price_jeep_wave_and_shoot_loop", "tag_guy0");
}

_id_6551() {
  level endon("player_entering_jeep");
  self waittillmatch("single anim", "end");
  self linkto(level._id_653A, "tag_guy1", (0, 0, 0), (0, 0, 0));
  level._id_653A thread maps\_anim::_id_124E(self, "soap_jeep_shoot_loop", "stop_soap_and_nikolai_loops", "tag_guy1");
}

_id_6552() {
  common_scripts\utility::flag_wait("player_entering_jeep");
  wait 0.05;
  level._id_54E0 maps\_utility::_id_1414();
  level._id_54E0 linkto(level._id_653A, "tag_guy1", (0, 0, 0), (0, 0, 0));
  level._id_653A thread maps\_anim::_id_124E(level._id_54E0, "soap_jeep_shoot_loop_2", "stop_soap_new_fire_loop", "tag_guy1");
  level._id_653A waittill("stop_soap_new_fire_loop");
  level._id_653A maps\_anim::_id_1246(level._id_54E0, "soap_jeep_sit_down", "tag_guy1");
  level._id_653A thread maps\_anim::_id_124E(level._id_54E0, "soap_back_jeep_loop", undefined, "tag_guy1");
}

_id_6553() {
  level endon("nikolai_attached_to_jeep_natural");
  common_scripts\utility::flag_wait("player_entering_jeep");
  wait 0.05;
  level._id_653F maps\_utility::_id_1414();
  level._id_653F linkto(level._id_653A, "tag_passenger", (0, 0, 0), (0, 0, 0));
  level._id_653A maps\_anim::_id_124E(level._id_653F, "nikolai_passenger_loop", undefined, "tag_passenger");
}

_id_6554() {
  level endon("player_entering_jeep");
  self waittillmatch("single anim", "end");
  level notify("nikolai_attached_to_jeep_natural");
  self linkto(level._id_653A, "tag_passenger", (0, 0, 0), (0, 0, 0));
  level._id_653A maps\_anim::_id_124E(self, "nikolai_passenger_loop", "stop_soap_and_nikolai_loops", "tag_passenger");
}

_id_6555() {
  self waittillmatch("single anim", "gun_up");
  thread _id_6556();
  level.player enableweapons();
  self waittillmatch("single anim", "end");
  thread _id_654F();
  thread _id_654A();
  thread _id_6533();
  level.player disableinvulnerability();
  level notify("move_jeep_escape_technical_1");
  level notify("move_jeep_escape_technical_2");
  level.player unlink();
  level.player allowjump(1);
  level.player allowcrouch(1);
  level._id_6540 delete();
  level._id_6541 delete();
  maps\_utility::_id_1C43();
}

_id_6556() {
  level._id_4877 maps\_utility::_id_168C("payback_pri_letsgocmon");
  wait 0.5;
  level._id_4877 maps\_utility::_id_168C("payback_pri_gottamove");
}

_id_6557() {
  self waittillmatch("single anim", "end");
  level._id_6538 notify("stop_price_jeep_wave_and_shoot_loop");
  level._id_6542 hide();
  level.player playerlinktodelta(level._id_6542, "tag_player");
  level.player freezecontrols(0);
  level.player enableweapons();
  common_scripts\utility::flag_set("player_in_jeep");
}

_id_6558() {
  level waittill("player_jumping_in_jeep");
  common_scripts\utility::exploder(7000);
  level._id_566C = 0.3;
  maps\_audio::aud_send_msg("mus_rescue_start_finale_music");
  level.player enableinvulnerability();
  level.player.health = level.player.maxhealth;
  thread _id_6559();
  thread maps\_utility::_id_11F4("payback_pri_moveout_r");
  level._id_653D maps\_utility::_id_265A();
  level._id_653E maps\_utility::_id_265A();
  thread _id_655C();
  level._id_6538 thread maps\_vehicle::_id_1FA6();
  level._id_653A maps\_utility::delaythread(0.5, maps\_vehicle::_id_1FA6);
  level._id_6538 vehicle_setspeed(41, 10);
  level._id_653A vehicle_setspeed(41, 10);
  level._id_6538 _id_655A();
  level._id_653A _id_655A();
  level.player freezecontrols(1);
  level.player setstance("stand");
  level.player disableweapons();
  level._id_6534 delete();
  level.player playerlinktoblend(level._id_6542, "tag_player", 0.25);
  level._id_6542 common_scripts\utility::delaycall(0.25, ::show);
  common_scripts\utility::flag_set("player_entering_jeep");
  level notify("player_entering_jeep");
  level._id_653A notify("stop_soap_and_nikolai_loops");
  maps\payback_util::_id_64A8();
  maps\_audio::aud_send_msg("outro_player_in_jeep");
  level._id_6542 maps\_anim::_id_1246(level._id_6542, "end_mount");
  thread _id_655B();
}

_id_6559() {
  wait 0.5;
  level.player playrumbleonentity("light_1s");
  wait 0.4;
  level._id_02A5 = level.player maps\_utility::_id_27AB("subtle_tank_rumble");
}

_id_655A() {
  playFXOnTag(level._effect["pb_jeep_trail"], self, "tag_wheel_back_left");
  wait 0.05;
  playFXOnTag(level._effect["pb_jeep_trail"], self, "tag_wheel_back_right");
}

_id_655B() {
  level._id_6538 notify("stop_gunner_1_shoot_loop");
  level._id_6538 maps\_anim::_id_1246(level._id_653D, "escape_jeep_1_gunner_sit_down", "tag_passenger");
  level._id_6538 maps\_anim::_id_124E(level._id_653D, "escape_jeep_1_gunner_passenger_loop", undefined, "tag_passenger");
}

_id_655C() {
  wait 3;
  level._id_653A notify("stop_gunner_2_shoot_loop");
  level._id_653A maps\_anim::_id_1246(level._id_653E, "escape_jeep_2_gunner_sit_down", "tag_guy0");
  level._id_653A maps\_anim::_id_124E(level._id_653E, "escape_jeep_2_gunner_rear_loop", undefined, "tag_guy0");
}

_id_655D() {
  level._id_654C = maps\_vehicle::_id_2881("jeep_escape_final_technical_1");
  level._id_654C._id_2955 = 1;
  level._id_654C maps\_vehicle::_id_2B17();
}

_id_655E() {
  level._id_654E = maps\_vehicle::_id_2881("jeep_escape_final_technical_2");
  level._id_654E._id_2955 = 1;
  level._id_654E maps\_vehicle::_id_2B17();
}

_id_655F() {
  var_0 = maps\_vehicle::_id_2881("jeep_escape_uaz");
  var_0 maps\_vehicle::_id_2B17();
}

_id_6560() {
  common_scripts\utility::flag_wait("jeep_escape_rpg_1");
  thread _id_6561("jeep_escape_rpg_1");
  common_scripts\utility::flag_wait("jeep_escape_rpg_2");
  thread _id_6561("jeep_escape_rpg_2");
  common_scripts\utility::flag_wait("jeep_escape_rpg_3");
  thread _id_6561("jeep_escape_rpg_3");
}

_id_6561(var_0) {
  var_1 = common_scripts\utility::getstruct(var_0, "targetname");
  var_2 = common_scripts\utility::getstruct(var_1.target, "targetname");
  magicbullet("rpg", var_1.origin, var_2.origin);
}

_id_6562() {
  level._id_64A5 endon("death");
  level endon("rescue_kill_nikolai");

  if(!isDefined(level._id_64A5)) {
    maps\payback_util::_id_594A("nikolai", "s3_rescue_nikolai");
  }
  level._id_64A5 maps\_utility::_id_1057();
  level._id_64A5._id_0D68 = 1;
  level._id_64A5 pushplayer(1);
  level._id_64A5.a._id_0D26 = "crouch";
  thread _id_6567();
  thread _id_656F();
  thread _id_6570();
  level._id_64A5 thread maps\_utility::_id_24F5();
  level._id_650D thread maps\_anim::_id_11CF(level._id_64A5, "payback_sstorm_chopper_rescue_nikolai_pullout");
  common_scripts\utility::flag_wait("start_nikolai_pullout");
  common_scripts\utility::flag_set("start_nikolai_pullout_echo");
  level._id_650D maps\_anim::_id_1246(level._id_64A5, "payback_sstorm_chopper_rescue_nikolai_pullout");
  level._id_650D thread maps\_anim::_id_124E(level._id_64A5, "rescue_nikolai_idle", "stop_nikolai_loop");
  level notify("disable_clear_chopper_obj_spot");
  thread _id_6563();
  objective_position(maps\_utility::_id_2816("obj_rescue"), level._id_64A5.origin + (0, 0, 20));
  objective_setpointertextoverride(maps\_utility::_id_2816("obj_rescue"), &"PAYBACK_NIKOLAI");
  level._id_6521 sethintstring(&"PAYBACK_USE_FREE_NIKOLAI");
  level._id_6521 usetriggerrequirelookat();
  level._id_6521 common_scripts\utility::trigger_on();
}

_id_6563() {
  level endon("rescue_picking_up_nikolai");
  var_0 = getent("rescue_nikolai_disable_weapons_trigger", "targetname");
  var_1 = getdvarint("cg_fov");
  setsaveddvar("objectiveHide", 0);

  for(;;) {
    if(level.player istouching(var_0) && level.player worldpointinreticle_circle(level._id_64A5.origin, var_1, 120)) {
      level.player disableweapons();
      setsaveddvar("objectiveHide", 1);

      while(level.player istouching(var_0) && level.player worldpointinreticle_circle(level._id_64A5.origin, var_1, 120)) {
        wait 0.5;
      }
      level.player enableweapons();
      setsaveddvar("objectiveHide", 0);
    }

    wait 0.05;
  }
}

_id_6564() {
  level endon("slide_started");
  var_0 = getent("player_out_in_open", "targetname");

  for(;;) {
    if(level.player istouching(var_0)) {
      level.player._id_20F2._id_22FC = 1.5;

      while(level.player istouching(var_0)) {
        wait 0.05;
      }
      level.player._id_20F2._id_22FC = 0.1;
    }

    wait 0.05;
  }
}

_id_6565(var_0, var_1) {
  level endon("start_player_slide");
  level endon("disable_ignore_player_triggers");
  var_2 = getdvarint("cg_fov");
  level.player.ignoreme = 1;
  level.player enabledeathshield(1);
  level.player._id_652F = 1;
  level.player._id_20F2._id_22FC = 0.1;

  for(;;) {
    if(level.player istouching(var_0) && level.player worldpointinreticle_circle(var_1.origin, var_2, 160)) {
      level.player.ignoreme = 0;
      level.player enabledeathshield(0);
      level.player._id_652F = 0;
      level.player._id_20F2._id_22FC = 1.5;

      while(level.player istouching(var_0) && level.player worldpointinreticle_circle(var_1.origin, var_2, 160)) {
        wait 0.05;
      }
      level.player.ignoreme = 1;
      level.player enabledeathshield(1);
      level.player._id_652F = 1;
      level.player._id_20F2._id_22FC = 0.1;
    }

    wait 0.05;
  }
}

_id_6566() {
  level._id_650D notify("stop_nikolai_loop");
  level._id_650D maps\_anim::_id_1246(level._id_64A5, "rescue_nikolai");
}

_id_6567() {
  var_0 = maps\_utility::_id_1287("rescue_nikolai_player_rig");
  var_0 hide();
  level._id_650D maps\_anim::_id_11CF(var_0, "rescue_nikolai");
  level._id_6521 = getent("nikolai_use_trigger", "targetname");
  level._id_6521 common_scripts\utility::trigger_off();
  level._id_6521 waittill("trigger");
  thread _id_6569();
  var_1 = getent("ignore_player_trigger_1", "targetname");
  var_2 = getent("ignore_player_target_1", "targetname");
  thread _id_6565(var_1, var_2);
  var_1 = getent("ignore_player_trigger_2", "targetname");
  var_2 = getent("ignore_player_target_2", "targetname");
  thread _id_6565(var_1, var_2);
  level.player enableinvulnerability();
  thread _id_651F();
  level._id_4877 maps\_utility::_id_265A();
  level._id_54E0 maps\_utility::_id_265A();
  level._id_6515 maps\_utility::_id_265A();
  level._id_6518 maps\_utility::_id_265A();
  level._id_6519 maps\_utility::_id_265A();
  level.player.health = level.player.maxhealth;
  thread _id_656A();
  var_3 = getEntArray("street_run_anim_check_triggers", "script_noteworthy");

  foreach(var_1 in var_3) {}
  var_1 common_scripts\utility::trigger_on();

  level notify("clear_echo_stuff");
  level notify("stop_laser_handler");
  common_scripts\utility::flag_set("stop_laser_handler");
  level._id_6519 laserforceoff();
  thread _id_6524();
  thread _id_656B();
  thread _id_6571();
  thread _id_652E();
  thread _id_6530();
  objective_position(maps\_utility::_id_2816("obj_rescue"), (0, 0, 0));
  objective_setpointertextoverride(maps\_utility::_id_2816("obj_rescue"), "");
  level._id_6521 delete();
  level notify("rescue_picking_up_nikolai");
  setsaveddvar("objectiveHide", 0);
  level.player disableweapons();
  thread _id_6568();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player setstance("stand");
  level.player playerlinktoblend(var_0, "tag_player", 0.4, 0.2, 0.2);
  wait 0.4;
  setsunflareposition((345, 253, 0));
  var_0 show();
  thread _id_6523();
  maps\_audio::aud_send_msg("nikolai_pickup");
  thread _id_6566();
  level._id_650D maps\_anim::_id_1246(var_0, "rescue_nikolai");
  level.player disableinvulnerability();
  thread _id_656C();
  setsaveddvar("mantle_enable", 0);
  level.player unlink();
  var_0 delete();
  thread _id_6579();
  _id_6572();
  maps\_utility::_id_1C43();
}

_id_6568() {
  var_0 = level.player getcurrentweapon();

  if(var_0 != "none") {
    var_1 = level.player getcurrentweaponclipammo();
    var_2 = weaponclipsize(var_0);

    if(isDefined(var_2)) {
      var_3 = var_2 - var_1;

      if(isDefined(var_3) && var_3 > 0) {
        level.player setweaponammoclip(var_0, var_1 + var_3);
      }
    }
  }
}

_id_6569() {
  common_scripts\utility::flag_wait("spawn_follow_technical");
  var_0 = maps\_vehicle::_id_2881("follow_technical");
  var_0 setCanDamage(0);
  var_0._id_2955 = 1;
  var_0 thread maps\_vehicle::_id_2B17();
  common_scripts\utility::flag_wait("wait_to_move_follow_technical");
  var_1 = getvehiclenode("follow_technical_path_2", "targetname");
  var_0 attachpath(var_1);
  var_0 thread maps\_vehicle::_id_1FA6();
}

_id_656A() {
  level._id_4877.ignoreall = 1;
  level._id_4877 clearenemy();
  level._id_4877 setgoalnode(getnode("echo_2_3_price_pickup_niko_move_spot", "targetname"));
  level._id_6518.ignoreall = 1;
  level._id_6518 clearenemy();
  level._id_6518 setgoalnode(getnode("echo_2_3_price_pickup_niko_move_spot", "targetname"));
  level._id_6519.ignoreall = 1;
  level._id_6519 clearenemy();
  level._id_6519 setgoalnode(getnode("echo_2_3_price_pickup_niko_move_spot", "targetname"));
}

_id_656B() {
  wait 0.5;
  level._id_4877 maps\_utility::_id_168C("payback_pri_headingtoexfil");
}

_id_656C() {
  level.player endon("death");
  level endon("start_player_slide");
  thread _id_656D();
  level._id_4877 maps\_utility::_id_168C("payback_pri_moveout4");
  wait 2;
  level._id_54E0 maps\_utility::_id_168C("payback_mct_followme");
  wait 2;
  level._id_4877 maps\_utility::_id_168C("payback_pri_comeonyuri");
  common_scripts\utility::flag_wait("start_flare");
  setculldist(0);
  wait 1;
  level._id_54E0 maps\_utility::_id_168C("payback_mct_iseethem");
  wait 2;
  level._id_4877 maps\_utility::_id_168C("payback_pri_yurithisway");
  wait 2;
  level._id_54E0 maps\_utility::_id_168C("payback_mct_keepmoving2");
  wait 2;
  level._id_4877 maps\_utility::_id_168C("payback_pri_letsgoyuri");
}

_id_656D() {
  level.player endon("death");
  wait 3;
  level._id_6515 maps\_utility::_id_168C("payback_eol_approachingexfil");
  common_scripts\utility::flag_wait("start_flare");
  wait 2;

  if(isDefined(level._id_6515) && isalive(level._id_6515)) {
    level._id_6515 maps\_utility::_id_168C("payback_eol_letsgo");
  }
}

_id_656E() {
  level endon("rescue_picking_up_nikolai");
  level._id_4877._id_2199 = 0;
  level._id_4877 setgoalnode(getnode("rescue_price_chopper", "targetname"));
  level._id_4877 waittill("goal");
  thread _id_651E();
}

_id_656F() {
  var_0 = maps\_utility::_id_1287("chopper_prop");
  level._id_650D maps\_anim::_id_124E(var_0, "payback_sstorm_chopper_rescue_propeller");
}

_id_6570() {
  var_0 = maps\_utility::_id_1287("chopper_tail");
  var_1 = common_scripts\utility::getstruct("crashed_chopper_tail_spot", "targetname");
  var_0.origin = var_1.origin;
  var_0.angles = var_1.angles;
  var_0 maps\_anim::_id_124E(var_0, "payback_sstorm_chopper_rescue_tail_rotor");
}

_id_6571() {
  common_scripts\utility::flag_clear("carry_warn");
  common_scripts\utility::flag_clear("carry_kill");
  var_0 = [];
  var_0 = maps\_utility::_id_0BC3(var_0, "payback_pri_wheregoing");
  var_0 = maps\_utility::_id_0BC3(var_0, "payback_pri_getbackhere2");
  var_1 = common_scripts\utility::random(var_0);
  common_scripts\utility::flag_wait("carry_warn");
  level thread maps\_utility::_id_11F4(var_1);
  common_scripts\utility::flag_wait("carry_kill");
  setDvar("ui_deadquote", "@PAYBACK_STAY_WITH_TEAM");
  maps\_utility::_id_1826();
}

_id_6572() {
  _id_6573(1);
  level.player setmovespeedscale(0.75);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowjump(0);
  level.player allowmelee(0);
  thread _id_6576();
  _id_6577(level.player, 1);

  if(isDefined(level._id_64A5)) {
    level._id_64A5 maps\_utility::_id_1902();
    level._id_64A5 delete();
    level._id_64A5 = undefined;
  }
}

_id_6573(var_0) {
  if(isDefined(var_0) && var_0 == 0) {
    _id_6574();
    return;
  }

  if(isDefined(level.stance_carry)) {
    level.stance_carry destroy();
  }
  setsaveddvar("hud_showStance", "0");
  level.stance_carry = newhudelem();
  level.stance_carry setshader("stance_carry", 80, 80);
  level.stance_carry.x = -65;
  level.stance_carry.y = -10;
  level.stance_carry.alignx = "right";
  level.stance_carry.aligny = "bottom";
  level.stance_carry.horzalign = "right_adjustable";
  level.stance_carry.vertalign = "bottom_adjustable";
  level.stance_carry.foreground = 1;
  level.stance_carry.hidewheninmenu = 1;
  level.stance_carry.hidewhendead = 1;
  level.stance_carry.alpha = 1;
}

_id_6574() {
  if(isDefined(level.stance_carry)) {
    level.stance_carry destroy();
  }
  setsaveddvar("hud_showStance", "1");
}

_id_6575() {
  _id_6573(0);
  setsaveddvar("mantle_enable", 1);
  level.player setmovespeedscale(1);
  level notify("rescue_carry_prevent_weapon_pickup_thread_stop");
  _id_6577(level.player, 0);
}

_id_6576() {
  level notify("rescue_carry_prevent_weapon_pickup_thread");
  level endon("rescue_carry_prevent_weapon_pickup_thread");
  level endon("rescue_carry_prevent_weapon_pickup_thread_stop");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2._id_217A = 1;
    }
  }

  for(;;) {
    var_4 = getweaponarray();

    if(isDefined(var_4)) {
      foreach(var_6 in var_4) {}
      var_6 delete();
    }

    wait 0.05;
  }
}

_id_6577(var_0, var_1) {
  if(var_1) {
    setsaveddvar("bg_viewBobAmplitudeStanding", "0.007 0.007");
    setsaveddvar("bg_viewBobAmplitudeStandingAds", "0.007 0.007");
    setsaveddvar("bg_viewBobAmplitudeSprinting", "0.02 0.014");
    setsaveddvar("bg_weaponBobAmplitudeStanding", "0.055 0.025");
    setsaveddvar("bg_weaponBobAmplitudeSprinting", "0.02 0.014");
  } else {
    setsaveddvar("bg_viewBobAmplitudeStanding", "0.007 0.007");
    setsaveddvar("bg_viewBobAmplitudeStandingAds", "0.007 0.007");
    setsaveddvar("bg_viewBobAmplitudeSprinting", "0.02 0.014");
    setsaveddvar("bg_weaponBobAmplitudeStanding", "0.055 0.025");
    setsaveddvar("bg_weaponBobAmplitudeSprinting", "0.02 0.014");
  }
}

_id_6578() {
  maps\_audio::aud_send_msg("set_pre_rescue_mix");
  var_0 = common_scripts\utility::getStructArray("rescue_phantom_fire_source1", "targetname");
  thread maps\payback_util::_id_64E9(level._id_64A5, "ak47", var_0, 0.05, 1.5, 3000, 5000, 0.5);
  thread _id_6581(level.player, "rescue_escape_dialogue");
  getent("pb_end_vista", "targetname") show();
}

_id_6579() {
  var_0 = common_scripts\utility::getstruct("jeep_escape_objective_spot_1", "targetname");
  objective_position(maps\_utility::_id_2816("obj_rescue"), var_0.origin);
  level waittill("run_objective_spot_2");
  _id_657A();
  var_1 = common_scripts\utility::getstruct("jeep_escape_objective_spot_2", "targetname");
  objective_position(maps\_utility::_id_2816("obj_rescue"), var_1.origin);
  wait 1;
  thread _id_6548();
  thread _id_6549("jeep_escape_technical_1", "move_jeep_escape_technical_1");
  thread _id_6549("jeep_escape_technical_2", "move_jeep_escape_technical_2");
  level waittill("run_objective_spot_3");
  objective_onentity(maps\_utility::_id_2816("obj_rescue"), level._id_6539);
  level waittill("player_jumping_in_jeep");
  objective_position(maps\_utility::_id_2816("obj_rescue"), (0, 0, 0));
}

_id_657A() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "follow_technical_enemies") {
      continue;
    } else {
      var_2 delete();
    }
  }
}

_id_657B(var_0) {
  playFXOnTag(var_0._id_6516, var_0, var_0._id_6517);
}

_id_657C(var_0) {
  stopFXOnTag(var_0._id_6516, var_0, var_0._id_6517);
}

_id_657D(var_0) {
  var_1 = getEntArray("rescue_contain_player_triggers", "script_noteworthy");

  foreach(var_3 in var_1) {
    if(var_0) {
      var_3 common_scripts\utility::trigger_on();
      continue;
    }

    var_3 common_scripts\utility::trigger_off();
  }

  if(var_0) {
    level thread _id_657E();
  }
}

_id_657E() {
  level notify("rescue_player_contain");
  level endon("rescue_player_contain");
  level.player endon("death");
  var_0 = [];
  var_0 = maps\_utility::_id_0BC3(var_0, "payback_pri_wheregoing");
  var_0 = maps\_utility::_id_0BC3(var_0, "payback_pri_getbackhere2");
  level waittill("rescue_player_warn");
  var_1 = common_scripts\utility::random(var_0);
  level thread maps\_utility::_id_11F4(var_1);
}

_id_657F() {
  if(isDefined(self.target)) {
    self waittill("trigger");
    var_0 = common_scripts\utility::getStructArray(self.target, "targetname");
    thread maps\payback_util::_id_64E9(level.player, "ak47", var_0, 0.05, 1.5, 3000, 5000);
  }
}

_id_6580() {
  self endon("death");

  if(isDefined(self.target)) {
    var_0 = maps\_utility::_id_27F1(self.target, "targetname");

    if(isDefined(var_0) && isDefined(var_0.target)) {
      var_1 = maps\_utility::_id_27F1(var_0.target, "targetname");

      if(isDefined(var_1)) {
        self waittill("trigger", var_2);

        if(!isDefined(self._id_164F) || self._id_164F != "force") {
          while(vectordot(vectornormalize(var_0.origin - level.player.origin), anglesToForward(level.player.angles)) > 0.5) {
            wait 0.1;
          }
          magicbullet("rpg_straight", var_0.origin, var_1.origin);
        }
      }
    }
  }
}

_id_6581(var_0, var_1, var_2) {
  var_3 = missile_createrepulsorent(var_0, 25000, 350);

  if(isDefined(var_2)) {
    if(!isDefined(var_1)) {
      var_1 = "rescue_protect_from_rpg_till";
    }
    var_0 thread maps\_utility::_id_1424(var_1, var_2);
  }

  if(isDefined(var_1)) {
    var_0 waittill(var_1);
  } else {
    return;
  }
  missile_deleteattractor(var_3);
}