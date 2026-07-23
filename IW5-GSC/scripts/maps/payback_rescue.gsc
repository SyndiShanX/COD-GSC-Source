/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\payback_rescue.gsc
*******************************************/

start_spawn_key_actors() {
  maps\payback_util::spawn_ally("soap");
  maps\payback_util::spawn_ally("price");
  maps\payback_util::spawn_ally("nikolai");
  maps\payback_util::move_player_to_start();
}

start_s3_rescue() {
  maps\_audio::aud_send_msg("s3_rescue");
  start_spawn_key_actors();
  maps\payback_sandstorm_code::sandstorm_skybox_show();
  common_scripts\utility::exploder(6000);
  objective_state(maps\_utility::obj("obj_kruger"), "done");
  objective_state(maps\_utility::obj("obj_secondary_lz"), "done");
  objective_state(maps\_utility::obj("obj_find_chopper"), "current");
  maps\payback_env_code::_id_6507("s3_rescue");
  thread maps\payback_sandstorm_code::set_sandstorm_level("extreme", 0.051);
  thread _id_5698::_id_5682(5);
  maps\payback_sandstorm::moroccan_lamp_thread();
  maps\payback_util::chopper_init_fog_brushes();
  maps\_compass::setupminimap("compass_map_payback_sandstorm", "sandstorm_minimap_corner");
  thread rescue_thread();

  if(!maps\_utility::is_specialop()) {
    maps\payback_fx_sp::_id_6504();
  }
  wait 2;
  thread maps\payback_sandstorm::lighten_sandstorm();
  setsunflareposition((343.8, 313.993, 0));
  var_0 = getEnt("sslight_01", "targetname");
  var_0 setlightintensity(7);
  thread _id_5698::_id_5682(5);
  var_1 = getEnt("street_light_gate", "targetname");
  var_1 setlightintensity(3);
}

start_s3_escape() {
  maps\_audio::aud_send_msg("s3_escape");
  start_spawn_key_actors();
  maps\payback_sandstorm_code::sandstorm_skybox_show();
  common_scripts\utility::exploder(6000);
  rescue_init();
  objective_state(maps\_utility::obj("obj_kruger"), "done");
  objective_state(maps\_utility::obj("obj_secondary_lz"), "done");
  objective_state(maps\_utility::obj("obj_find_chopper"), "done");
  objective_state(maps\_utility::obj("obj_rescue"), "current");
  maps\payback_env_code::_id_6507("s3_escape");
  thread maps\payback_sandstorm_code::set_sandstorm_level("extreme", 0.051);
  maps\payback_sandstorm::moroccan_lamp_thread();
  maps\_compass::setupminimap("compass_map_payback_sandstorm", "sandstorm_minimap_corner");
  thread minimap_change_watcher();
  maps\payback_util::chopper_init_fog_brushes();
  rescue_spawn_initial();
  rescue_contain_player_enable(1);
  thread rescue_carry_nikolai_setup();
  thread rescue_advance_to_chopper();

  if(!maps\_utility::is_specialop()) {
    maps\payback_fx_sp::_id_6504();
  }
  wait 2;
  thread maps\payback_sandstorm::lighten_sandstorm();
  setsunflareposition((343.8, 313.993, 0));
}

init_flags_rescue() {
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

rescue_init() {
  if(!isDefined(level.rescue_init)) {
    rescue_contain_player_enable(0);
    var_0 = getEntArray("rescue_escape_trigger", "script_noteworthy");

    foreach(var_2 in var_0) {}
    var_2 common_scripts\utility::trigger_off();

    var_4 = getEntArray("rescue_trigger_rpg", "targetname");
    common_scripts\utility::array_thread(var_4, ::rescue_trigger_fire_rpg);
    level thread maps\payback_util::notify_on_trigger("rescue_begin");
    level thread maps\payback_util::notify_on_trigger("rescue_allies_at_chopper");
    level thread maps\payback_util::notify_on_trigger("rescue_player_warn");
    level thread maps\payback_util::notify_on_trigger("rescue_trigger_drone_wake");
    level thread maps\payback_util::notify_on_trigger("rescue_escape_dialogue");
    level thread maps\payback_util::notify_on_trigger("rescue_kill_nikolai");
    level thread maps\payback_util::notify_on_trigger("run_objective_spot_2");
    level thread maps\payback_util::notify_on_trigger("run_objective_spot_3");
    level thread maps\payback_util::notify_on_trigger("start_player_slide");
    level thread maps\payback_util::notify_on_trigger("start_flare");
    level thread maps\payback_util::notify_on_trigger("run_objective_spot_jeep");
    level thread maps\payback_util::notify_on_trigger("jeep_escape_rpg_1");
    level thread maps\payback_util::notify_on_trigger("jeep_escape_rpg_2");
    level thread maps\payback_util::notify_on_trigger("jeep_escape_rpg_3");
    level thread maps\payback_util::notify_on_trigger("price_check_anim_ref_2");
    level thread maps\payback_util::notify_on_trigger("price_check_anim_ref_3");
    level thread maps\payback_util::notify_on_trigger("price_check_anim_ref_4");
    level thread maps\payback_util::notify_on_trigger("soap_check_anim_ref_2");
    level thread maps\payback_util::notify_on_trigger("soap_check_anim_ref_3");
    level thread maps\payback_util::notify_on_trigger("soap_check_anim_ref_4");
    level thread maps\payback_util::notify_on_trigger("soap_check_anim_ref_5");
    level thread maps\payback_util::notify_on_trigger("final_technicals");
    level thread maps\payback_util::notify_on_trigger("ridge_contain");
    level thread maps\payback_util::notify_on_trigger("winning");
    var_5 = getEnt("jeep_flare", "targetname");
    var_5 setlightintensity(0);

    if(!isDefined(level.nikolai)) {
      maps\payback_util::spawn_ally("nikolai", "s3_rescue_nikolai");
      level.nikolai.ignoreall = 1;
    }

    level.chopper_rescue_ref = common_scripts\utility::getStruct("chopper_rescue_reference", "targetname");
    level thread rescue_wait_kill_nikolai();
    level.rescue_init = 1;
    thread rescue_enemy_battlechatter();
    thread spawn_echo_team_near_chopper();
  }
}

rescue_thread() {
  rescue_init();
  self notify("rescue_thread");
  self endon("rescue_thread");
  thread rescue_carry_nikolai_setup();
  thread minimap_change_watcher();
  rescue_spawn_initial();
  level waittill("rescue_begin");
  rescue_begin();
}

minimap_change_watcher() {
  common_scripts\utility::flag_wait("use_exit_minimap");
  maps\_compass::setupminimap("compass_map_payback_exit", "exit_minimap_corner");
}

rescue_begin() {
  maps\_audio::aud_send_msg("begin_npc_weapon_audio_hack");
  thread player_out_in_open();
  thread rescue_intro_combat();
  thread clear_chopper_obj_spot();
  level waittill("all_pre_rescue_enemies_dead");
  objective_state(maps\_utility::obj("obj_find_chopper"), "done");
  var_0 = common_scripts\utility::getStruct("rescue_nikolai_obj_spot", "targetname");
  objective_state(maps\_utility::obj("obj_rescue"), "current");
  objective_position(maps\_utility::obj("obj_rescue"), var_0.origin);
  thread rescue_begin_dialogue_thread();
  rescue_advance_to_chopper();
}

clear_chopper_obj_spot() {
  level endon("disable_clear_chopper_obj_spot");
  common_scripts\utility::flag_wait("clear_chopper_obj_spot");
  objective_position(maps\_utility::obj("obj_rescue"), (0, 0, 0));
}

rescue_intro_combat() {
  common_scripts\utility::flag_wait("rescue_intro_firing_at_nikolai");
  var_0 = maps\payback_util::array_spawn_targetname_allow_fail("rescue_intro_firing_at_nikolai");
  var_1 = getEnt("rescue_intro_fire_at_nikolai_spot", "targetname");

  foreach(var_3 in var_0) {
    var_3 setentitytarget(var_1);
    var_3 thread maps\payback_sandstorm_code::flashlight_on_guy();
    var_3 thread cleanup_arch_enemies();
  }

  maps\payback_util::payback_array_waittill_combat(var_0, "rescue_intro");
  var_0 = maps\_utility::array_removedead(var_0);

  foreach(var_3 in var_0) {
    var_3 clearentitytarget();
    var_3 notify("rescue_end_shoot_at_target_thread");
    var_3.fixednode = 0;
  }

  maps\_utility::waittill_dead_or_dying(var_0);
  maps\_utility::activate_trigger_with_targetname("rescue_intro_post_combat");
  level notify("all_pre_rescue_enemies_dead");
}

rescue_begin_dialogue_thread() {
  level endon("pickup_nikolai_vo_started");
  level.soap maps\_utility::dialogue_queue("payback_mct_theresnikschopper");
  maps\_audio::aud_send_msg("mus_rescue_start_nikolai_music");
  wait 0.2;
  level.price maps\_utility::dialogue_queue("payback_pri_echoteampinned");
  wait 0.2;
  level.price maps\_utility::dialogue_queue("payback_pri_fromnorthwest");
  wait 0.1;
  maps\_utility::radio_dialogue("payback_eol_copythat");
  maps\_audio::aud_send_msg("mus_nikolai");
}

spawn_echo_team_near_chopper() {
  level endon("clear_echo_stuff");
  setlasermaterial("gfx_laser_bright", "");
  level.rescue_echo_1 = getEnt("rescue_echo_1_spawner", "targetname") maps\_utility::spawn_ai(1);
  level.rescue_echo_1 maps\_utility::magic_bullet_shield();
  level.rescue_echo_1.animname = "rescue_echo_1";
  level.rescue_echo_1._id_6516 = level._effect["dust_kickup"];
  level.rescue_echo_1._id_6517 = "j_mainroot";
  level.rescue_echo_1 thread laser_handler();
  level.rescue_echo_1 thread crash_site_ally_prep();
  level.rescue_echo_2 = getEnt("rescue_echo_2_spawner", "targetname") maps\_utility::spawn_ai(1);
  level.rescue_echo_2 maps\_utility::magic_bullet_shield();
  level.rescue_echo_2.animname = "rescue_echo_2";
  level.rescue_echo_2 thread laser_handler();
  level.rescue_echo_2._id_6516 = level._effect["dust_kickup"];
  level.rescue_echo_2._id_6517 = "j_mainroot";
  level.rescue_echo_2 thread crash_site_ally_prep();
  level.rescue_echo_3 = getEnt("rescue_echo_3_spawner", "targetname") maps\_utility::spawn_ai(1);
  level.rescue_echo_3 maps\_utility::magic_bullet_shield();
  level.rescue_echo_3.animname = "rescue_echo_3";
  level.rescue_echo_3 thread crash_site_ally_prep();
  level.rescue_echo_3.notarget = 1;
  level.rescue_echo_3.ignoreme = 1;
  common_scripts\utility::flag_wait("start_nikolai_pullout_echo");
  level.rescue_echo_3 laserforceoff();
  level.chopper_rescue_ref maps\_anim::anim_single_solo(level.rescue_echo_3, "payback_sstorm_chopper_rescue_echo_pullout");
  level.rescue_echo_3 setgoalnode(getnode("rescue_echo_3_end_spot", "targetname"));
  level.rescue_echo_3 waittill("goal");
  level.rescue_echo_3.notarget = 0;
  level.rescue_echo_3.ignoreme = 0;
  level.rescue_echo_3 thread laser_handler();
}

cleanup_arch_enemies() {
  self endon("death");
  common_scripts\utility::flag_wait("start_nikolai_pullout_echo");

  if(isDefined(self) && isalive(self)) {
    self kill();
  }
}

laser_handler() {
  level endon("stop_laser_handler");
  var_0 = 1;

  while(!common_scripts\utility::flag("stop_laser_handler")) {
    if(animscripts\utility::canseeenemy() && var_0) {
      self laserforceon();
      var_0 = 0;
    } else if(!animscripts\utility::canseeenemy() && !var_0) {
      self laserforceoff();
      var_0 = 1;
    }

    wait(randomfloatrange(0.25, 0.5));
  }
}

rescue_advance_to_chopper() {
  rescue_contain_player_enable(1);
  level.price maps\_utility::disable_ai_color();
  level.soap maps\_utility::disable_ai_color();
  level.price.goalradius = 128;
  level.soap.goalradius = 128;
  level.price maps\_utility::battlechatter_off();
  level.soap maps\_utility::battlechatter_off();
  level.price thread crash_site_ally_prep();
  level.soap thread crash_site_ally_prep();
  thread rescue_nikolai_price();
  level.soap.script_grenades = 0;
  level.soap setgoalnode(getnode("rescue_soap_chopper", "targetname"));
}

rescue_enemy_battlechatter() {
  wait 0.5;
  level.player endon("death");

  for(;;) {
    var_0 = getaiarray("axis");
    var_0 = maps\_utility::get_array_of_closest(level.player.origin, var_0, undefined, 4);

    if(var_0.size > 0) {
      var_1 = randomintrange(0, var_0.size);
      var_2 = var_0[var_1];
      var_2 maps\_utility::custom_battlechatter("order_move_combat");
    }

    wait(randomfloatrange(1.5, 5.0));
  }
}

rescue_chopper_extract_dialogue() {
  level endon("rescue_picking_up_nikolai");
  level notify("pickup_nikolai_vo_started");
  common_scripts\utility::flag_wait("player_near_crashed_chopper");
  level.price maps\_utility::dialogue_queue("payback_pri_goodtoseeyou");
  wait 0.5;
  level.rescue_echo_1 maps\_utility::dialogue_queue("payback_eol_twovehicles");
  common_scripts\utility::trigger_on("ready_to_pick_up_niko_save_trig", "targetname");
  wait 0.5;
  level.price maps\_utility::dialogue_queue("payback_pri_suppress");
  wait 4;

  for(;;) {
    level.price maps\_utility::dialogue_queue("payback_pri_getnikolai");
    wait 4;
    level.price maps\_utility::dialogue_queue("payback_pri_grabnikolai");
    wait 4;
    level.price maps\_utility::dialogue_queue("payback_pri_waitingfor");
    wait 4;
  }
}

health_mods() {
  level.player.gs.invultime_onshield = 2;
  level.player.gs.invultime_postshield = 2;
  level.player.gs.invultime_preshield = 2;
  level.player.gs.longregentime = 500;
  level.player.gs.player_attacker_accuracy = 0.1;
  level.player.gs.playerhealth_regularregendelay = 500;
  level.player.gs.invultime_postshield = 2;
  level.player.gs.regenrate = 0.1;
  level.player.gs.worthydamageratio = 0.01;
}

rescue_wait_kill_nikolai() {
  level waittill("rescue_kill_nikolai");
  level.nikolai_use_trigger delete();
  level.chopper_rescue_ref thread maps\_anim::anim_single_solo(level.nikolai, "rescue_nikolai_death");
  level.nikolai.allowdeath = 1;
  level.nikolai maps\_utility::stop_magic_bullet_shield();
  magicbullet("ak47", level.nikolai getEye() + (0, 0, 10), level.nikolai getEye());
  level.nikolai kill();
  wait 1;
  setDvar("ui_deadquote", "@PAYBACK_NIKOLAI_KILLED");
  maps\_utility::missionfailedwrapper();
}

rescue_exit_setup() {
  var_0 = getEntArray("rescue_escape_trigger", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 common_scripts\utility::trigger_on();

    if(isDefined(var_2.script_parameters) && var_2.script_parameters == "phantom_fire") {
      var_2 thread rescue_phantom_trigger_wait();
    }
  }
}

rescue_exit_sequence() {
  rescue_exit_setup();
  rescue_contain_player_enable(0);
  var_0 = common_scripts\utility::getStructArray("rescue_phantom_fire_source1", "targetname");
  thread maps\payback_util::phantom_pressure(level.player, "ak47", var_0, 0.05, 1.5, 3000, 5000);
  level waittill("rescue_escape_dialogue");
  level notify("stop_rescue_respawns");
}

move_allies_after_pickup() {
  thread rescue_exit_sequence_price();
  thread rescue_exit_sequence_soap();
  thread rescue_exit_sequence_echo_1();
  thread rescue_exit_sequence_echo_2();
  thread rescue_exit_sequence_echo_3();
  thread flare_thread();
  thread new_jeep_escape_setup();
}

flare_thread() {
  level waittill("start_flare");
  maps\_audio::aud_send_msg("mus_rescue_music_day_saved");
  thread maps/_flare::flare_from_targetname("jeep_escape_flare");
  thread flare_light();
  level waittill("flare_done");
  common_scripts\utility::flag_set("start_flare_fade");
}

flare_light() {
  var_0 = getEnt("jeep_flare", "targetname");
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

ally_run_prep() {
  self clearenemy();
  self.ignoreall = 1;
  self.goalradius = 32;
  self.ignoreexplosionevents = 1;
  self.grenadeawareness = 0;
  self.notarget = 1;
  self.ignoreme = 1;
  self.ignoresuppression = 1;
  self.suppressionwait = 0;
  self.disablebulletwhizbyreaction = 1;
  self.ignorerandombulletdamage = 1;
  thread maps\_utility::disable_pain();
  thread maps\_utility::disable_surprise();
  self allowedstances("stand");
  self.badplaceawareness = 0;
}

crash_site_ally_prep() {
  self.ignoreexplosionevents = 1;
  self.grenadeawareness = 0;
  self.ignoresuppression = 1;
  self.suppressionwait = 0;
  self.disablebulletwhizbyreaction = 1;
  self.ignorerandombulletdamage = 1;
  thread maps\_utility::disable_pain();
  thread maps\_utility::disable_surprise();
  self.badplaceawareness = 0;
}

rescue_exit_sequence_price() {
  level.price ally_run_prep();
  thread price_run_part_1();
}

rescue_exit_sequence_soap() {
  level.soap ally_run_prep();
  thread soap_run_part_1();
}

rescue_exit_sequence_echo_1() {
  var_0 = common_scripts\utility::getStruct("slide_ref", "targetname");
  level waittill("move_echo_2_and_3");
  level.rescue_echo_1 maps\_utility::teleport_ai(getnode("rescue_echo_1_run_start_spot", "targetname"));
  level.rescue_echo_1 ally_run_prep();
  level.rescue_echo_1 laserforceoff();
  var_0 maps\_anim::anim_reach_solo(level.rescue_echo_1, "rescue_echo_1_slide");
  var_0 maps\_anim::anim_single_solo(level.rescue_echo_1, "rescue_echo_1_slide");
  level.rescue_echo_1 setgoalnode(getnode("rescue_echo_1_goal", "targetname"));
  var_1 = common_scripts\utility::getStruct("shoot_echo_1_and_2_bullet_spot", "targetname");
  level.rescue_echo_1 waittill("goal");
  level.rescue_echo_1 maps\_utility::stop_magic_bullet_shield();
  magicbullet("ak47", var_1.origin, level.rescue_echo_1 gettagorigin("J_SpineUpper") + (4, 2, 10));
  wait 0.1;
  magicbullet("ak47", var_1.origin, level.rescue_echo_1 gettagorigin("J_SpineUpper") + (10, 12, 5));
  wait 0.1;
  magicbullet("ak47", var_1.origin, level.rescue_echo_1 gettagorigin("J_SpineUpper") + (7, 3, 8));
  wait 0.1;
  magicbullet("ak47", var_1.origin, level.rescue_echo_1 gettagorigin("J_SpineUpper") + (4, 2, 10));

  if(isDefined(level.rescue_echo_1) && isalive(level.rescue_echo_1)) {
    level.rescue_echo_1 kill();
  }
}

rescue_exit_sequence_echo_2() {
  var_0 = common_scripts\utility::getStruct("slide_ref", "targetname");
  level waittill("move_echo_2_and_3");
  level.rescue_echo_2 maps\_utility::teleport_ai(getnode("rescue_echo_2_run_start_spot", "targetname"));
  level.rescue_echo_2 ally_run_prep();
  level.rescue_echo_2 laserforceoff();
  var_0 maps\_anim::anim_reach_solo(level.rescue_echo_2, "rescue_echo_2_slide");
  var_0 maps\_anim::anim_single_solo(level.rescue_echo_2, "rescue_echo_2_slide");
  level.rescue_echo_2 setgoalnode(getnode("rescue_echo_2_goal", "targetname"));
  var_1 = common_scripts\utility::getStruct("shoot_echo_1_and_2_bullet_spot", "targetname");
  level.rescue_echo_2 waittill("goal");
  level.rescue_echo_2 maps\_utility::stop_magic_bullet_shield();
  magicbullet("ak47", var_1.origin, level.rescue_echo_2 gettagorigin("J_SpineUpper") + (4, 2, 10));
  wait 0.1;
  magicbullet("ak47", var_1.origin, level.rescue_echo_2 gettagorigin("J_SpineUpper") + (10, 12, 5));
  wait 0.1;
  magicbullet("ak47", var_1.origin, level.rescue_echo_2 gettagorigin("J_SpineUpper") + (7, 3, 8));
  wait 0.1;
  magicbullet("ak47", var_1.origin, level.rescue_echo_2 gettagorigin("J_SpineUpper") + (4, 2, 10));

  if(isDefined(level.rescue_echo_2) && isalive(level.rescue_echo_2)) {
    level.rescue_echo_2 kill();
  }
}

rescue_exit_sequence_echo_3() {
  var_0 = common_scripts\utility::getStruct("rescue_echo_3_bullet_spot", "targetname");
  level waittill("move_echo_2_and_3");
  level.rescue_echo_3 maps\_utility::teleport_ai(getnode("rescue_echo_3_run_start_spot", "targetname"));
  level.rescue_echo_3 ally_run_prep();
  level.rescue_echo_3 setgoalnode(getnode("rescue_echo_3_goal", "targetname"));
  level.rescue_echo_3.deathanim = maps\_utility::getgenericanim("echo_stumble_forward_death");
  level.rescue_echo_3 waittill("goal");
  level.rescue_echo_3 maps\_utility::stop_magic_bullet_shield();
  magicbullet("ak47", var_0.origin, level.rescue_echo_3 gettagorigin("J_SpineUpper") + (4, 2, 10));
  wait 0.1;
  magicbullet("ak47", var_0.origin, level.rescue_echo_3 gettagorigin("J_SpineUpper") + (10, 12, 5));
  wait 0.1;
  magicbullet("ak47", var_0.origin, level.rescue_echo_3 gettagorigin("J_SpineUpper") + (7, 3, 8));
  wait 0.1;
  magicbullet("ak47", var_0.origin, level.rescue_echo_3 gettagorigin("J_SpineUpper") + (4, 2, 10));

  if(isDefined(level.rescue_echo_3) && isalive(level.rescue_echo_3)) {
    level.rescue_echo_3 kill();
  }
}

keep_up_or_die() {
  level endon("notify_slide_started");

  while(!common_scripts\utility::flag("slide_started")) {
    var_0 = distancesquared(level.player.origin, level.soap.origin);
    var_1 = distancesquared(level.player.origin, level.price.origin);

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
        maps\_utility::missionfailedwrapper();
      }

      return;
    }

    wait 1;
  }
}

street_run_allow_damage() {
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
    maps\_utility::missionfailedwrapper();
  }
}

price_run_part_1() {
  level endon("notify_slide_started");
  level.price.moveplaybackrate = 1.2;
  level.price.animplaybackrate = 1.2;
  wait 1;
  var_0 = common_scripts\utility::getStruct("price_run_anim_ref_1", "targetname");
  var_1 = common_scripts\utility::getStruct("price_run_anim_ref_2", "targetname");
  var_2 = common_scripts\utility::getStruct("price_run_anim_ref_2_debris", "targetname");
  var_3 = maps\_utility::spawn_anim_model("escape_debris");
  var_3.animplaybackrate = 1.2;
  var_2 thread maps\_anim::anim_first_frame_solo(var_3, "escape_debris_dodge");
  var_4 = common_scripts\utility::getStruct("price_run_anim_ref_3", "targetname");
  var_5 = common_scripts\utility::getStruct("price_dodge_rpg_spot", "targetname");
  var_6 = common_scripts\utility::getStruct(var_5.target, "targetname");
  var_7 = common_scripts\utility::getStruct("price_run_anim_ref_4", "targetname");
  var_8 = getnode("price_run_spot_4", "targetname");
  var_9 = getnode("price_rpg_dodge_alt", "targetname");
  var_0 maps\_anim::anim_first_frame_solo(level.price, "payback_escape_start_backpedal_price");
  wait 3.5;
  level.price.a.pose = "stand";
  level.price.a.movement = "run";
  var_0 maps\_anim::anim_single_solo_run(level.price, "payback_escape_start_backpedal_price");
  level notify("move_echo_1");
  var_1 maps\_anim::anim_reach_solo(level.price, "escape_debris_dodge");

  if(!common_scripts\utility::flag("price_check_anim_ref_2")) {
    var_2 thread maps\_anim::anim_single_solo(var_3, "escape_debris_dodge");
    var_1 maps\_anim::anim_single_solo_run(level.price, "escape_debris_dodge");
  }

  var_4 maps\_anim::anim_reach_solo(level.price, "payback_escape_rpg_react_price");
  magicbullet("rpg_straight", var_5.origin, var_6.origin, level.player);

  if(!common_scripts\utility::flag("price_check_anim_ref_3")) {
    var_4 maps\_anim::anim_single_solo_run(level.price, "payback_escape_rpg_react_price");
  } else {
    level.price setgoalnode(var_9);
    level.price waittill("goal");
  }

  var_7 maps\_anim::anim_reach_solo(level.price, "payback_escape_forward_wave_right_price");

  if(!common_scripts\utility::flag("price_check_anim_ref_4")) {
    var_7 maps\_anim::anim_single_solo_run(level.price, "payback_escape_forward_wave_right_price");
  }
  level.price.goalradius = 64;
  level.price setgoalnode(var_8);
  level.price waittill("goal");
  common_scripts\utility::flag_set("price_at_ridge");
  level.price allowedstances("stand");
  level.price.animplaybackrate = 1;
  level.price.moveplaybackrate = 1;
  level.price.ignoreall = 0;
  level.price.notarget = 0;
  level.price.ignoreme = 0;
}

soap_run_part_1() {
  level endon("notify_slide_started");
  level.soap.moveplaybackrate = 1.2;
  level.soap._id_6517 = "j_mainroot";
  level.soap._id_6516 = level._effect["dust_kickup"];
  level.soap.animplaybackrate = 1.3;
  var_0 = common_scripts\utility::getStruct("soap_run_anim_ref_1", "targetname");
  var_1 = common_scripts\utility::getStruct("soap_run_anim_ref_2", "targetname");
  var_2 = common_scripts\utility::getStruct("soap_run_anim_ref_3", "targetname");
  var_3 = common_scripts\utility::getStruct("soap_run_anim_ref_4", "targetname");
  var_4 = common_scripts\utility::getStruct("soap_run_anim_ref_5", "targetname");
  var_5 = getnode("soap_slide_goal", "targetname");
  var_0 maps\_anim::anim_first_frame_solo(level.soap, "payback_escape_start_wave_soap");
  wait 4.4;
  level notify("move_echo_2_and_3");
  level.soap.a.pose = "stand";
  level.soap.a.movement = "run";
  var_0 maps\_anim::anim_single_solo_run(level.soap, "payback_escape_start_wave_soap");
  var_1 maps\_anim::anim_reach_solo(level.soap, "payback_escape_turn_shoot_wave_soap");

  if(!common_scripts\utility::flag("soap_check_anim_ref_2")) {
    var_1 maps\_anim::anim_single_solo_run(level.soap, "payback_escape_turn_shoot_wave_soap");
  }
  var_2 maps\_anim::anim_reach_solo(level.soap, "payback_escape_hood_slide_soap");

  if(!common_scripts\utility::flag("soap_check_anim_ref_3")) {
    maps\_audio::aud_send_msg("soap_hood_slide");
    var_2 maps\_anim::anim_single_solo_run(level.soap, "payback_escape_hood_slide_soap");
  }

  var_3 maps\_anim::anim_reach_solo(level.soap, "payback_escape_forward_wave_left_soap");

  if(!common_scripts\utility::flag("soap_check_anim_ref_4")) {
    var_3 maps\_anim::anim_single_solo_run(level.soap, "payback_escape_forward_wave_left_soap");
  }
  var_4 maps\_anim::anim_reach_solo(level.soap, "payback_escape_turn_shoot_wave_soap");

  if(!common_scripts\utility::flag("soap_check_anim_ref_5")) {
    var_4 maps\_anim::anim_single_solo_run(level.soap, "payback_escape_turn_shoot_wave_soap");
  }
  level.soap.goalradius = 64;
  level.soap setgoalnode(var_5);
  level.soap waittill("goal");
  level.price allowedstances("stand");
  level.soap.animplaybackrate = 1;
  level.soap.moveplaybackrate = 1;
  level.soap.ignoreall = 0;
  level.soap.notarget = 0;
  level.soap.ignoreme = 0;
}

waittill_player_triggers_jeep() {
  level.player_enter_jeep_trigger waittill("trigger");
  common_scripts\utility::flag_set("player_in_escape_jeep");
  level notify("player_jumping_in_jeep");
}

enter_jeep_player_blend_to_anim(var_0, var_1) {
  level.player playerlinktoblend(var_0, "tag_player", var_1);
}

new_jeep_escape_setup() {
  level.player endon("death");
  thread jeep_escape_ambient_rpg();
  thread jeep_escape_path_triggers();
  var_0 = [];
  level.slide_ref = common_scripts\utility::getStruct("slide_ref", "targetname");
  level.escape_jeep_1 = maps\_vehicle::spawn_vehicle_from_targetname("escape_jeep_1");
  level.escape_jeep_1 setCanDamage(0);
  level.escape_jeep_1 maps\_vehicle::vehicle_lights_on();
  level.player_enter_jeep_trigger = getEnt("player_enter_jeep_trigger", "targetname");
  level.jeep_obj_spot = spawn("script_model", level.escape_jeep_1.origin);
  level.jeep_obj_spot linkTo(level.escape_jeep_1, "tag_brakelight_right", (0, 0, 0), (0, 0, 0));
  level.escape_jeep_2 = maps\_vehicle::spawn_vehicle_from_targetname("escape_jeep_2");
  level.escape_jeep_2 setCanDamage(0);
  level.escape_jeep_2 maps\_vehicle::vehicle_lights_on();
  thread player_enter_jeep();
  thread soap_attach_to_jeep();
  thread nikolai_attach_to_jeep();
  level.escape_jeep_1_driver = getEnt("escape_jeep_1_driver", "targetname") maps\_utility::spawn_ai(1);
  level.escape_jeep_1_driver maps\_utility::magic_bullet_shield();
  level.escape_jeep_1_driver maps\_utility::battlechatter_off();
  level.escape_jeep_1_driver maps\_utility::gun_remove();
  level.escape_jeep_1_driver.animname = "escape_jeep_1_driver";
  level.escape_jeep_1_driver linkTo(level.escape_jeep_1, "tag_driver", (0, 0, 0), (0, 0, 0));
  level.escape_jeep_1 thread maps\_anim::anim_loop_solo(level.escape_jeep_1_driver, "escape_jeep_1_driver_loop", "stop_escape_jeep_1_driver_loop_1", "tag_driver");
  level.escape_jeep_2_driver = getEnt("escape_jeep_2_driver", "targetname") maps\_utility::spawn_ai(1);
  level.escape_jeep_2_driver maps\_utility::magic_bullet_shield();
  level.escape_jeep_2_driver maps\_utility::battlechatter_off();
  level.escape_jeep_2_driver maps\_utility::gun_remove();
  level.escape_jeep_2_driver.animname = "escape_jeep_2_driver";
  level.escape_jeep_2_driver linkTo(level.escape_jeep_2, "tag_driver", (0, 0, 0), (0, 0, 0));
  level.escape_jeep_2 thread maps\_anim::anim_loop_solo(level.escape_jeep_2_driver, "escape_jeep_2_driver_loop", "stop_escape_jeep_2_driver_loop_1", "tag_driver");
  level.escape_jeep_1_gunner = getEnt("escape_jeep_1_gunner", "targetname") maps\_utility::spawn_ai(1);
  level.escape_jeep_1_gunner maps\_utility::magic_bullet_shield();
  level.escape_jeep_1_gunner laserforceon();
  level.escape_jeep_1_gunner.animname = "escape_jeep_1_gunner";
  level.escape_jeep_1_gunner linkTo(level.escape_jeep_1, "tag_passenger", (0, 0, 0), (0, 0, 0));
  level.escape_jeep_1 thread maps\_anim::anim_loop_solo(level.escape_jeep_1_gunner, "escape_jeep_1_gunner_shoot_loop", "stop_gunner_1_shoot_loop", "tag_passenger");
  level.escape_jeep_2_gunner = getEnt("escape_jeep_2_gunner", "targetname") maps\_utility::spawn_ai(1);
  level.escape_jeep_2_gunner maps\_utility::magic_bullet_shield();
  level.escape_jeep_2_gunner laserforceon();
  level.escape_jeep_2_gunner.animname = "escape_jeep_2_gunner";
  level.escape_jeep_2_gunner linkTo(level.escape_jeep_2, "tag_guy0", (0, 0, 0), (0, 0, 0));
  level.escape_jeep_2 thread maps\_anim::anim_loop_solo(level.escape_jeep_2_gunner, "escape_jeep_2_gunner_shoot_loop", "stop_gunner_2_shoot_loop", "tag_guy0");
  level.nikolai_jeep_escape = getEnt("nikolai_jeep_escape", "targetname") maps\_utility::spawn_ai(1);
  level.nikolai_jeep_escape.animname = "nikolai_jeep_escape";
  level.nikolai_jeep_escape setCanDamage(0);
  level.nikolai_jeep_escape maps\_utility::battlechatter_off();
  level.nikolai_jeep_escape.ignoreall = 1;
  level.nikolai_jeep_escape.ignoreme = 1;
  level.nikolai_jeep_escape maps\_utility::gun_remove();
  level.nikolai_jeep_escape hide();
  level.nikolai_jeep_escape._id_6516 = level._effect["dust_kickup"];
  level.nikolai_jeep_escape._id_6517 = "j_mainroot";
  var_0 = maps\_utility::array_add(var_0, level.nikolai_jeep_escape);
  level.slide_ref thread maps\_anim::anim_first_frame_solo(level.nikolai_jeep_escape, "jeep_slide_escape");
  var_0 = maps\_utility::array_add(var_0, level.price);
  level.price._id_6517 = "j_mainroot";
  level.price._id_6516 = level._effect["dust_kickup"];
  var_0 = maps\_utility::array_add(var_0, level.soap);
  level.escape_player_arms = maps\_utility::spawn_anim_model("player_slide_arms");
  var_0 = maps\_utility::array_add(var_0, level.escape_player_arms);
  level.escape_player_arms hide();
  level.slide_ref thread maps\_anim::anim_first_frame_solo(level.escape_player_arms, "jeep_slide_escape");
  level.escape_player_arms thread player_escape_notetracks();
  level.escape_player_legs = maps\_utility::spawn_anim_model("player_slide_legs");
  var_0 = maps\_utility::array_add(var_0, level.escape_player_legs);
  level.escape_player_legs hide();
  level.escape_player_legs._id_6516 = level._effect["dust_kickup"];
  level.escape_player_legs._id_6517 = "j_ankle_le";
  level.slide_ref thread maps\_anim::anim_first_frame_solo(level.escape_player_legs, "jeep_slide_escape");
  level.jeep_player_arms = maps\_utility::spawn_anim_model("player_jeep_arms");
  level.jeep_player_arms hide();
  level.jeep_player_arms linkTo(level.escape_jeep_1, "tag_guy1", (0, 0, 0), (0, 0, 0));
  level.jeep_player_arms thread maps\_anim::anim_first_frame_solo(level.jeep_player_arms, "end_mount");
  level.jeep_player_arms thread player_enter_jeep_notetracks();
  common_scripts\utility::flag_wait("start_player_slide");
  level.price_repulsor = missile_createrepulsorent(level.price, 5000, 200);
  level._id_6544 = missile_createrepulsorent(level.soap, 5000, 200);
  level.player_repulsor = missile_createrepulsorent(level.player, 5000, 200);
  level._id_6546 = missile_createrepulsorent(level.nikolai_jeep_escape, 5000, 200);
  var_1 = missile_createrepulsorent(level.escape_jeep_1, 5000, 200);
  var_2 = missile_createrepulsorent(level.escape_jeep_2, 5000, 200);
  level.player enableinvulnerability();
  level.player.health = level.player.maxhealth;
  level.player freezecontrols(1);
  level.player setstance("stand");
  level.player disableweapons();
  thread rescue_carry_nikolai_drop();
  common_scripts\utility::flag_set("slide_started");
  level notify("notify_slide_started");
  level.nikolai_jeep_escape common_scripts\utility::delaycall(1, ::show);
  level.price maps\_utility::anim_stopanimscripted();
  level.soap maps\_utility::anim_stopanimscripted();
  level.soap.animplaybackrate = 1;
  level.soap.moveplaybackrate = 1;
  level.price.animplaybackrate = 1;
  level.price.moveplaybackrate = 1;
  wait 0.05;
  maps\_audio::aud_send_msg("outro_slide_start");
  level.slide_ref thread maps\_anim::anim_single(var_0, "jeep_slide_escape");
  level.escape_player_arms thread player_slide_rumbles();
  level.price thread price_escape_notetracks();
  level.soap thread soap_escape_notetracks();
  level.nikolai_jeep_escape thread nikolai_escape_notetracks();
  maps\_utility::delaythread(0.05, ::enter_jeep_player_blend_to_anim, level.escape_player_arms, 0.25);
  level.escape_player_legs common_scripts\utility::delaycall(1, ::show);
}

player_slide_rumbles() {
  self waittillmatch("single anim", "slide_fx_on");
  level.player playRumbleOnEntity("light_1s");
  wait 0.4;
  level.player playrumblelooponentity("subtle_tank_rumble");
  self waittillmatch("single anim", "slide_fx_off");
  level.player stoprumble("subtle_tank_rumble");
}

jeep_escape_enemies() {
  maps\_utility::array_spawn_function_targetname("jeep_escape_enemies", maps\payback_sandstorm_code::flashlight_on_guy);
  maps\_utility::array_spawn_targetname("jeep_escape_enemies", 1);
}

jeep_escape_technical_wait_for_goto(var_0, var_1) {
  var_2 = maps\_vehicle::spawn_vehicle_from_targetname(var_0);
  var_2.dontunloadonend = 1;
  var_2 maps\_vehicle::vehicle_lights_on();
  level waittill(var_1);
  var_2 maps\_vehicle::gopath();
}

ridge_contain() {
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
      maps\_utility::missionfailedwrapper();
    }
  }
}

jeep_escape_path_triggers() {
  common_scripts\utility::flag_wait("final_technicals");
  thread jeep_escape_final_technical_1();
  thread jeep_escape_final_technical_2();
  common_scripts\utility::flag_wait("winning");

  if(common_scripts\utility::flag("player_in_escape_jeep")) {
    thread destroy_final_technical_2();

    if(isalive(level.final_technical_1)) {
      level.final_technical_1 maps\_vehicle::force_kill();
    }
    wait 1;
    objective_state(maps\_utility::obj("obj_rescue"), "done");
    level.escape_jeep_2 notify("stop_soap_new_fire_loop");
    thread jeep_escape_vo();
    wait 4;
    level.player thread maps\payback_util::set_black_fade(1, 2);
    level.jeep_rumble_loop maps\_utility::rumble_ramp_off(4);
    wait 6;
    maps\payback_util::show_hud_after_scripted_sequence();
    maps\_utility::nextmission();
  }
}

jeep_escape_vo() {
  level.escape_jeep_1_driver maps\_utility::dialogue_queue("payback_eol_glad");
  wait 0.5;
  maps\_utility::radio_dialogue("payback_mct_inparis");
  wait 0.5;
  level.price maps\_utility::dialogue_queue("payback_pri_iknowwho");
}

destroy_final_technical_2() {
  wait 0.5;

  if(isalive(level.final_technical_2)) {
    level.final_technical_2 maps\_vehicle::force_kill();
  }
}

get_in_jeep_timer() {
  level endon("player_jumping_in_jeep");
  level.player.ignoreme = 1;
  wait 4;
  thread jeep_escape_uaz();
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
      maps\_utility::missionfailedwrapper();
    }
  }
}

price_escape_notetracks() {
  self waittillmatch("single anim", "end");
  level.price linkTo(level.escape_jeep_1, "tag_guy0", (0, 0, 0), (0, 0, 0));
  common_scripts\utility::flag_set("price_in_escape_jeep_1");
  level.escape_jeep_1 thread maps\_anim::anim_loop_solo(level.price, "price_jeep_shoot_loop", "stop_price_jeep_wave_and_shoot_loop", "tag_guy0");
  level.escape_jeep_1 waittill("stop_price_jeep_wave_and_shoot_loop");
  level.escape_jeep_1 maps\_anim::anim_single_solo(level.price, "price_jeep_sit_down", "tag_guy0");
  level.escape_jeep_1 thread maps\_anim::anim_loop_solo(level.price, "price_back_jeep_loop", "stop_price_jeep_wave_and_shoot_loop", "tag_guy0");
}

soap_escape_notetracks() {
  level endon("player_entering_jeep");
  self waittillmatch("single anim", "end");
  self linkTo(level.escape_jeep_2, "tag_guy1", (0, 0, 0), (0, 0, 0));
  level.escape_jeep_2 thread maps\_anim::anim_loop_solo(self, "soap_jeep_shoot_loop", "stop_soap_and_nikolai_loops", "tag_guy1");
}

soap_attach_to_jeep() {
  common_scripts\utility::flag_wait("player_entering_jeep");
  wait 0.05;
  level.soap maps\_utility::anim_stopanimscripted();
  level.soap linkTo(level.escape_jeep_2, "tag_guy1", (0, 0, 0), (0, 0, 0));
  level.escape_jeep_2 thread maps\_anim::anim_loop_solo(level.soap, "soap_jeep_shoot_loop_2", "stop_soap_new_fire_loop", "tag_guy1");
  level.escape_jeep_2 waittill("stop_soap_new_fire_loop");
  level.escape_jeep_2 maps\_anim::anim_single_solo(level.soap, "soap_jeep_sit_down", "tag_guy1");
  level.escape_jeep_2 thread maps\_anim::anim_loop_solo(level.soap, "soap_back_jeep_loop", undefined, "tag_guy1");
}

nikolai_attach_to_jeep() {
  level endon("nikolai_attached_to_jeep_natural");
  common_scripts\utility::flag_wait("player_entering_jeep");
  wait 0.05;
  level.nikolai_jeep_escape maps\_utility::anim_stopanimscripted();
  level.nikolai_jeep_escape linkTo(level.escape_jeep_2, "tag_passenger", (0, 0, 0), (0, 0, 0));
  level.escape_jeep_2 maps\_anim::anim_loop_solo(level.nikolai_jeep_escape, "nikolai_passenger_loop", undefined, "tag_passenger");
}

nikolai_escape_notetracks() {
  level endon("player_entering_jeep");
  self waittillmatch("single anim", "end");
  level notify("nikolai_attached_to_jeep_natural");
  self linkTo(level.escape_jeep_2, "tag_passenger", (0, 0, 0), (0, 0, 0));
  level.escape_jeep_2 maps\_anim::anim_loop_solo(self, "nikolai_passenger_loop", "stop_soap_and_nikolai_loops", "tag_passenger");
}

player_escape_notetracks() {
  self waittillmatch("single anim", "gun_up");
  thread price_slide_end_vo();
  level.player enableweapons();
  self waittillmatch("single anim", "end");
  thread get_in_jeep_timer();
  thread ridge_contain();
  thread waittill_player_triggers_jeep();
  level.player disableinvulnerability();
  level notify("move_jeep_escape_technical_1");
  level notify("move_jeep_escape_technical_2");
  level.player unlink();
  level.player allowjump(1);
  level.player allowcrouch(1);
  level.escape_player_arms delete();
  level.escape_player_legs delete();
  maps\_utility::autosave_now();
}

price_slide_end_vo() {
  level.price maps\_utility::dialogue_queue("payback_pri_letsgocmon");
  wait 0.5;
  level.price maps\_utility::dialogue_queue("payback_pri_gottamove");
}

player_enter_jeep_notetracks() {
  self waittillmatch("single anim", "end");
  level.escape_jeep_1 notify("stop_price_jeep_wave_and_shoot_loop");
  level.jeep_player_arms hide();
  level.player playerlinktodelta(level.jeep_player_arms, "tag_player");
  level.player freezecontrols(0);
  level.player enableweapons();
  common_scripts\utility::flag_set("player_in_jeep");
}

player_enter_jeep() {
  level waittill("player_jumping_in_jeep");
  common_scripts\utility::exploder(7000);
  level._id_566C = 0.3;
  maps\_audio::aud_send_msg("mus_rescue_start_finale_music");
  level.player enableinvulnerability();
  level.player.health = level.player.maxhealth;
  thread jeep_ride_exit_rumbles();
  thread maps\_utility::radio_dialogue("payback_pri_moveout_r");
  level.escape_jeep_1_gunner maps\_utility::battlechatter_off();
  level.escape_jeep_2_gunner maps\_utility::battlechatter_off();
  thread gunner_2_sit_down_and_idle();
  level.escape_jeep_1 thread maps\_vehicle::gopath();
  level.escape_jeep_2 maps\_utility::delaythread(0.5, maps\_vehicle::gopath);
  level.escape_jeep_1 vehicle_setspeed(41, 10);
  level.escape_jeep_2 vehicle_setspeed(41, 10);
  level.escape_jeep_1 jeep_tread_fx();
  level.escape_jeep_2 jeep_tread_fx();
  level.player freezecontrols(1);
  level.player setstance("stand");
  level.player disableweapons();
  level.player_enter_jeep_trigger delete();
  level.player playerlinktoblend(level.jeep_player_arms, "tag_player", 0.25);
  level.jeep_player_arms common_scripts\utility::delaycall(0.25, ::show);
  common_scripts\utility::flag_set("player_entering_jeep");
  level notify("player_entering_jeep");
  level.escape_jeep_2 notify("stop_soap_and_nikolai_loops");
  maps\payback_util::hide_hud_for_scripted_sequence();
  maps\_audio::aud_send_msg("outro_player_in_jeep");
  level.jeep_player_arms maps\_anim::anim_single_solo(level.jeep_player_arms, "end_mount");
  thread gunner_1_sit_down_and_idle();
}

jeep_ride_exit_rumbles() {
  wait 0.5;
  level.player playRumbleOnEntity("light_1s");
  wait 0.4;
  level.jeep_rumble_loop = level.player maps\_utility::get_rumble_ent("subtle_tank_rumble");
}

jeep_tread_fx() {
  playFXOnTag(level._effect["pb_jeep_trail"], self, "tag_wheel_back_left");
  wait 0.05;
  playFXOnTag(level._effect["pb_jeep_trail"], self, "tag_wheel_back_right");
}

gunner_1_sit_down_and_idle() {
  level.escape_jeep_1 notify("stop_gunner_1_shoot_loop");
  level.escape_jeep_1 maps\_anim::anim_single_solo(level.escape_jeep_1_gunner, "escape_jeep_1_gunner_sit_down", "tag_passenger");
  level.escape_jeep_1 maps\_anim::anim_loop_solo(level.escape_jeep_1_gunner, "escape_jeep_1_gunner_passenger_loop", undefined, "tag_passenger");
}

gunner_2_sit_down_and_idle() {
  wait 3;
  level.escape_jeep_2 notify("stop_gunner_2_shoot_loop");
  level.escape_jeep_2 maps\_anim::anim_single_solo(level.escape_jeep_2_gunner, "escape_jeep_2_gunner_sit_down", "tag_guy0");
  level.escape_jeep_2 maps\_anim::anim_loop_solo(level.escape_jeep_2_gunner, "escape_jeep_2_gunner_rear_loop", undefined, "tag_guy0");
}

jeep_escape_final_technical_1() {
  level.final_technical_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("jeep_escape_final_technical_1");
  level.final_technical_1.dontunloadonend = 1;
  level.final_technical_1 maps\_vehicle::vehicle_lights_on();
}

jeep_escape_final_technical_2() {
  level.final_technical_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("jeep_escape_final_technical_2");
  level.final_technical_2.dontunloadonend = 1;
  level.final_technical_2 maps\_vehicle::vehicle_lights_on();
}

jeep_escape_uaz() {
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("jeep_escape_uaz");
  var_0 maps\_vehicle::vehicle_lights_on();
}

jeep_escape_ambient_rpg() {
  common_scripts\utility::flag_wait("jeep_escape_rpg_1");
  thread jeep_escape_rpg("jeep_escape_rpg_1");
  common_scripts\utility::flag_wait("jeep_escape_rpg_2");
  thread jeep_escape_rpg("jeep_escape_rpg_2");
  common_scripts\utility::flag_wait("jeep_escape_rpg_3");
  thread jeep_escape_rpg("jeep_escape_rpg_3");
}

jeep_escape_rpg(var_0) {
  var_1 = common_scripts\utility::getStruct(var_0, "targetname");
  var_2 = common_scripts\utility::getStruct(var_1.target, "targetname");
  magicbullet("rpg", var_1.origin, var_2.origin);
}

rescue_carry_nikolai_setup() {
  level.nikolai endon("death");
  level endon("rescue_kill_nikolai");

  if(!isDefined(level.nikolai)) {
    maps\payback_util::spawn_ally("nikolai", "s3_rescue_nikolai");
  }
  level.nikolai maps\_utility::disable_pain();
  level.nikolai.flashbangimmunity = 1;
  level.nikolai pushplayer(1);
  level.nikolai.a.pose = "crouch";
  thread rescue_nikolai_player();
  thread crashed_chopper_prop();
  thread crashed_chopper_tail();
  level.nikolai thread maps\_utility::gun_remove();
  level.chopper_rescue_ref thread maps\_anim::anim_first_frame_solo(level.nikolai, "payback_sstorm_chopper_rescue_nikolai_pullout");
  common_scripts\utility::flag_wait("start_nikolai_pullout");
  common_scripts\utility::flag_set("start_nikolai_pullout_echo");
  level.chopper_rescue_ref maps\_anim::anim_single_solo(level.nikolai, "payback_sstorm_chopper_rescue_nikolai_pullout");
  level.chopper_rescue_ref thread maps\_anim::anim_loop_solo(level.nikolai, "rescue_nikolai_idle", "stop_nikolai_loop");
  level notify("disable_clear_chopper_obj_spot");
  thread pickup_nikolai_enable_and_disable_weapons();
  objective_position(maps\_utility::obj("obj_rescue"), level.nikolai.origin + (0, 0, 20));
  objective_setpointertextoverride(maps\_utility::obj("obj_rescue"), &"PAYBACK_NIKOLAI");
  level.nikolai_use_trigger setHintString(&"PAYBACK_USE_FREE_NIKOLAI");
  level.nikolai_use_trigger useTriggerRequireLookAt();
  level.nikolai_use_trigger common_scripts\utility::trigger_on();
}

pickup_nikolai_enable_and_disable_weapons() {
  level endon("rescue_picking_up_nikolai");
  var_0 = getEnt("rescue_nikolai_disable_weapons_trigger", "targetname");
  var_1 = getdvarint("cg_fov");
  setsaveddvar("objectiveHide", 0);

  for(;;) {
    if(level.player istouching(var_0) && level.player worldpointinreticle_circle(level.nikolai.origin, var_1, 120)) {
      level.player disableweapons();
      setsaveddvar("objectiveHide", 1);

      while(level.player istouching(var_0) && level.player worldpointinreticle_circle(level.nikolai.origin, var_1, 120)) {
        wait 0.5;
      }
      level.player enableweapons();
      setsaveddvar("objectiveHide", 0);
    }

    wait 0.05;
  }
}

player_out_in_open() {
  level endon("slide_started");
  var_0 = getEnt("player_out_in_open", "targetname");

  for(;;) {
    if(level.player istouching(var_0)) {
      level.player.gs.player_attacker_accuracy = 1.5;

      while(level.player istouching(var_0)) {
        wait 0.05;
      }
      level.player.gs.player_attacker_accuracy = 0.1;
    }

    wait 0.05;
  }
}

ignore_player_until_looking_at_target(var_0, var_1) {
  level endon("start_player_slide");
  level endon("disable_ignore_player_triggers");
  var_2 = getdvarint("cg_fov");
  level.player.ignoreme = 1;
  level.player enabledeathshield(1);
  level.player._id_652F = 1;
  level.player.gs.player_attacker_accuracy = 0.1;

  for(;;) {
    if(level.player istouching(var_0) && level.player worldpointinreticle_circle(var_1.origin, var_2, 160)) {
      level.player.ignoreme = 0;
      level.player enabledeathshield(0);
      level.player._id_652F = 0;
      level.player.gs.player_attacker_accuracy = 1.5;

      while(level.player istouching(var_0) && level.player worldpointinreticle_circle(var_1.origin, var_2, 160)) {
        wait 0.05;
      }
      level.player.ignoreme = 1;
      level.player enabledeathshield(1);
      level.player._id_652F = 1;
      level.player.gs.player_attacker_accuracy = 0.1;
    }

    wait 0.05;
  }
}

rescue_nikolai() {
  level.chopper_rescue_ref notify("stop_nikolai_loop");
  level.chopper_rescue_ref maps\_anim::anim_single_solo(level.nikolai, "rescue_nikolai");
}

rescue_nikolai_player() {
  var_0 = maps\_utility::spawn_anim_model("rescue_nikolai_player_rig");
  var_0 hide();
  level.chopper_rescue_ref maps\_anim::anim_first_frame_solo(var_0, "rescue_nikolai");
  level.nikolai_use_trigger = getEnt("nikolai_use_trigger", "targetname");
  level.nikolai_use_trigger common_scripts\utility::trigger_off();
  level.nikolai_use_trigger waittill("trigger");
  thread follow_technical();
  var_1 = getEnt("ignore_player_trigger_1", "targetname");
  var_2 = getEnt("ignore_player_target_1", "targetname");
  thread ignore_player_until_looking_at_target(var_1, var_2);
  var_1 = getEnt("ignore_player_trigger_2", "targetname");
  var_2 = getEnt("ignore_player_target_2", "targetname");
  thread ignore_player_until_looking_at_target(var_1, var_2);
  level.player enableinvulnerability();
  thread health_mods();
  level.price maps\_utility::battlechatter_off();
  level.soap maps\_utility::battlechatter_off();
  level.rescue_echo_1 maps\_utility::battlechatter_off();
  level.rescue_echo_2 maps\_utility::battlechatter_off();
  level.rescue_echo_3 maps\_utility::battlechatter_off();
  level.player.health = level.player.maxhealth;
  thread move_echo_2_3_price_when_nikolai_picked_up();
  var_3 = getEntArray("street_run_anim_check_triggers", "script_noteworthy");

  foreach(var_1 in var_3) {}
  var_1 common_scripts\utility::trigger_on();

  level notify("clear_echo_stuff");
  level notify("stop_laser_handler");
  common_scripts\utility::flag_set("stop_laser_handler");
  level.rescue_echo_3 laserforceoff();
  thread move_allies_after_pickup();
  thread pickup_nikolai_radio_echo();
  thread carry_warn_and_kill_trigs();
  thread keep_up_or_die();
  thread street_run_allow_damage();
  objective_position(maps\_utility::obj("obj_rescue"), (0, 0, 0));
  objective_setpointertextoverride(maps\_utility::obj("obj_rescue"), "");
  level.nikolai_use_trigger delete();
  level notify("rescue_picking_up_nikolai");
  setsaveddvar("objectiveHide", 0);
  level.player disableweapons();
  thread max_player_ammo_for_ending();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player setstance("stand");
  level.player playerlinktoblend(var_0, "tag_player", 0.4, 0.2, 0.2);
  wait 0.4;
  setsunflareposition((345, 253, 0));
  var_0 show();
  thread rescue_exit_sequence();
  maps\_audio::aud_send_msg("nikolai_pickup");
  thread rescue_nikolai();
  level.chopper_rescue_ref maps\_anim::anim_single_solo(var_0, "rescue_nikolai");
  level.player disableinvulnerability();
  thread pickup_nikolai_and_escape_vo();
  setsaveddvar("mantle_enable", 0);
  level.player unlink();
  var_0 delete();
  thread run_objective_markers();
  rescue_carry_nikolai_pickup_finish();
  maps\_utility::autosave_now();
}

max_player_ammo_for_ending() {
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

follow_technical() {
  common_scripts\utility::flag_wait("spawn_follow_technical");
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("follow_technical");
  var_0 setCanDamage(0);
  var_0.dontunloadonend = 1;
  var_0 thread maps\_vehicle::vehicle_lights_on();
  common_scripts\utility::flag_wait("wait_to_move_follow_technical");
  var_1 = getvehiclenode("follow_technical_path_2", "targetname");
  var_0 attachpath(var_1);
  var_0 thread maps\_vehicle::gopath();
}

move_echo_2_3_price_when_nikolai_picked_up() {
  level.price.ignoreall = 1;
  level.price clearenemy();
  level.price setgoalnode(getnode("echo_2_3_price_pickup_niko_move_spot", "targetname"));
  level.rescue_echo_2.ignoreall = 1;
  level.rescue_echo_2 clearenemy();
  level.rescue_echo_2 setgoalnode(getnode("echo_2_3_price_pickup_niko_move_spot", "targetname"));
  level.rescue_echo_3.ignoreall = 1;
  level.rescue_echo_3 clearenemy();
  level.rescue_echo_3 setgoalnode(getnode("echo_2_3_price_pickup_niko_move_spot", "targetname"));
}

pickup_nikolai_radio_echo() {
  wait 0.5;
  level.price maps\_utility::dialogue_queue("payback_pri_headingtoexfil");
}

pickup_nikolai_and_escape_vo() {
  level.player endon("death");
  level endon("start_player_slide");
  thread pickup_nikolai_and_escape_radio_vo();
  level.price maps\_utility::dialogue_queue("payback_pri_moveout4");
  wait 2;
  level.soap maps\_utility::dialogue_queue("payback_mct_followme");
  wait 2;
  level.price maps\_utility::dialogue_queue("payback_pri_comeonyuri");
  common_scripts\utility::flag_wait("start_flare");
  setculldist(0);
  wait 1;
  level.soap maps\_utility::dialogue_queue("payback_mct_iseethem");
  wait 2;
  level.price maps\_utility::dialogue_queue("payback_pri_yurithisway");
  wait 2;
  level.soap maps\_utility::dialogue_queue("payback_mct_keepmoving2");
  wait 2;
  level.price maps\_utility::dialogue_queue("payback_pri_letsgoyuri");
}

pickup_nikolai_and_escape_radio_vo() {
  level.player endon("death");
  wait 3;
  level.rescue_echo_1 maps\_utility::dialogue_queue("payback_eol_approachingexfil");
  common_scripts\utility::flag_wait("start_flare");
  wait 2;

  if(isDefined(level.rescue_echo_1) && isalive(level.rescue_echo_1)) {
    level.rescue_echo_1 maps\_utility::dialogue_queue("payback_eol_letsgo");
  }
}

rescue_nikolai_price() {
  level endon("rescue_picking_up_nikolai");
  level.price.script_grenades = 0;
  level.price setgoalnode(getnode("rescue_price_chopper", "targetname"));
  level.price waittill("goal");
  thread rescue_chopper_extract_dialogue();
}

crashed_chopper_prop() {
  var_0 = maps\_utility::spawn_anim_model("chopper_prop");
  level.chopper_rescue_ref maps\_anim::anim_loop_solo(var_0, "payback_sstorm_chopper_rescue_propeller");
}

crashed_chopper_tail() {
  var_0 = maps\_utility::spawn_anim_model("chopper_tail");
  var_1 = common_scripts\utility::getStruct("crashed_chopper_tail_spot", "targetname");
  var_0.origin = var_1.origin;
  var_0.angles = var_1.angles;
  var_0 maps\_anim::anim_loop_solo(var_0, "payback_sstorm_chopper_rescue_tail_rotor");
}

carry_warn_and_kill_trigs() {
  common_scripts\utility::flag_clear("carry_warn");
  common_scripts\utility::flag_clear("carry_kill");
  var_0 = [];
  var_0 = maps\_utility::array_add(var_0, "payback_pri_wheregoing");
  var_0 = maps\_utility::array_add(var_0, "payback_pri_getbackhere2");
  var_1 = common_scripts\utility::random(var_0);
  common_scripts\utility::flag_wait("carry_warn");
  level thread maps\_utility::radio_dialogue(var_1);
  common_scripts\utility::flag_wait("carry_kill");
  setDvar("ui_deadquote", "@PAYBACK_STAY_WITH_TEAM");
  maps\_utility::missionfailedwrapper();
}

rescue_carry_nikolai_pickup_finish() {
  payback_stance_carry_icon_enable(1);
  level.player setmovespeedscale(0.75);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowjump(0);
  level.player allowmelee(0);
  thread rescue_carry_prevent_weapon_pickup_thread();
  rescue_set_carry_viewbob(level.player, 1);

  if(isDefined(level.nikolai)) {
    level.nikolai maps\_utility::stop_magic_bullet_shield();
    level.nikolai delete();
    level.nikolai = undefined;
  }
}

payback_stance_carry_icon_enable(var_0) {
  if(isDefined(var_0) && var_0 == 0) {
    payback_stance_carry_icon_disable();
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

payback_stance_carry_icon_disable() {
  if(isDefined(level.stance_carry)) {
    level.stance_carry destroy();
  }
  setsaveddvar("hud_showStance", "1");
}

rescue_carry_nikolai_drop() {
  payback_stance_carry_icon_enable(0);
  setsaveddvar("mantle_enable", 1);
  level.player setmovespeedscale(1);
  level notify("rescue_carry_prevent_weapon_pickup_thread_stop");
  rescue_set_carry_viewbob(level.player, 0);
}

rescue_carry_prevent_weapon_pickup_thread() {
  level notify("rescue_carry_prevent_weapon_pickup_thread");
  level endon("rescue_carry_prevent_weapon_pickup_thread");
  level endon("rescue_carry_prevent_weapon_pickup_thread_stop");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2.dontdropweapon = 1;
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

rescue_set_carry_viewbob(var_0, var_1) {
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

rescue_spawn_initial() {
  maps\_audio::aud_send_msg("set_pre_rescue_mix");
  var_0 = common_scripts\utility::getStructArray("rescue_phantom_fire_source1", "targetname");
  thread maps\payback_util::phantom_pressure(level.nikolai, "ak47", var_0, 0.05, 1.5, 3000, 5000, 0.5);
  thread rescue_protect_from_rpg_till(level.player, "rescue_escape_dialogue");
  getEnt("pb_end_vista", "targetname") show();
}

run_objective_markers() {
  var_0 = common_scripts\utility::getStruct("jeep_escape_objective_spot_1", "targetname");
  objective_position(maps\_utility::obj("obj_rescue"), var_0.origin);
  level waittill("run_objective_spot_2");
  check_if_ok_to_delete();
  var_1 = common_scripts\utility::getStruct("jeep_escape_objective_spot_2", "targetname");
  objective_position(maps\_utility::obj("obj_rescue"), var_1.origin);
  wait 1;
  thread jeep_escape_enemies();
  thread jeep_escape_technical_wait_for_goto("jeep_escape_technical_1", "move_jeep_escape_technical_1");
  thread jeep_escape_technical_wait_for_goto("jeep_escape_technical_2", "move_jeep_escape_technical_2");
  level waittill("run_objective_spot_3");
  objective_onentity(maps\_utility::obj("obj_rescue"), level.jeep_obj_spot);
  level waittill("player_jumping_in_jeep");
  objective_position(maps\_utility::obj("obj_rescue"), (0, 0, 0));
}

check_if_ok_to_delete() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "follow_technical_enemies") {
      continue;
    } else {
      var_2 delete();
    }
  }
}

slide_fx_on(var_0) {
  playFXOnTag(var_0._id_6516, var_0, var_0._id_6517);
}

slide_fx_off(var_0) {
  stopFXOnTag(var_0._id_6516, var_0, var_0._id_6517);
}

rescue_contain_player_enable(var_0) {
  var_1 = getEntArray("rescue_contain_player_triggers", "script_noteworthy");

  foreach(var_3 in var_1) {
    if(var_0) {
      var_3 common_scripts\utility::trigger_on();
      continue;
    }

    var_3 common_scripts\utility::trigger_off();
  }

  if(var_0) {
    level thread rescue_player_contain();
  }
}

rescue_player_contain() {
  level notify("rescue_player_contain");
  level endon("rescue_player_contain");
  level.player endon("death");
  var_0 = [];
  var_0 = maps\_utility::array_add(var_0, "payback_pri_wheregoing");
  var_0 = maps\_utility::array_add(var_0, "payback_pri_getbackhere2");
  level waittill("rescue_player_warn");
  var_1 = common_scripts\utility::random(var_0);
  level thread maps\_utility::radio_dialogue(var_1);
}

rescue_phantom_trigger_wait() {
  if(isDefined(self.target)) {
    self waittill("trigger");
    var_0 = common_scripts\utility::getStructArray(self.target, "targetname");
    thread maps\payback_util::phantom_pressure(level.player, "ak47", var_0, 0.05, 1.5, 3000, 5000);
  }
}

rescue_trigger_fire_rpg() {
  self endon("death");

  if(isDefined(self.target)) {
    var_0 = maps\_utility::getent_or_struct(self.target, "targetname");

    if(isDefined(var_0) && isDefined(var_0.target)) {
      var_1 = maps\_utility::getent_or_struct(var_0.target, "targetname");

      if(isDefined(var_1)) {
        self waittill("trigger", var_2);

        if(!isDefined(self.script_parameters) || self.script_parameters != "force") {
          while(vectordot(vectorNormalize(var_0.origin - level.player.origin), anglesToForward(level.player.angles)) > 0.5) {
            wait 0.1;
          }
          magicbullet("rpg_straight", var_0.origin, var_1.origin);
        }
      }
    }
  }
}

rescue_protect_from_rpg_till(var_0, var_1, var_2) {
  var_3 = missile_createrepulsorent(var_0, 25000, 350);

  if(isDefined(var_2)) {
    if(!isDefined(var_1)) {
      var_1 = "rescue_protect_from_rpg_till";
    }
    var_0 thread maps\_utility::notify_delay(var_1, var_2);
  }

  if(isDefined(var_1)) {
    var_0 waittill(var_1);
  } else {
    return;
  }
  missile_deleteattractor(var_3);
}