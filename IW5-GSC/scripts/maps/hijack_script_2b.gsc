/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\hijack_script_2b.gsc
*********************************************/

start_post_tarmac() {
  level.commander = maps\hijack_code::spawn_ally("commander_tarmac");
  waittillframeend;
  var_0 = common_scripts\utility::getStruct("player_start_post_tarmac", "targetname");
  level.player setOrigin(var_0.origin);
  level.player setplayerangles(var_0.angles);
  maps\_compass::setupminimap("compass_map_hijack_tarmac", "tarmac_minimap_corner");
  setsaveddvar("compassmaxrange", 3500);
  thread maps\hijack_tarmac::tarmac_dead_allies();
  maps\_audio::aud_send_msg("start_post_tarmac");
  common_scripts\utility::flag_set("player_on_feet_post_crash");
  common_scripts\utility::flag_set("spawn_makarov_heli");
  common_scripts\utility::flag_set("start_spotlight_random_targeting");
  common_scripts\utility::flag_init("flag_red_leave_tarmac_combat");
  common_scripts\utility::flag_init("tarmac_combat_level_fail");
  common_scripts\utility::flag_set("fx_crash_trench_fire");
  thread maps\hijack_tarmac::main_script_thread();
  thread combat_scene_fail_trigger();
  level.player_original_jump_height = getdvarfloat("jump_height");
  var_1 = common_scripts\utility::getStruct("makarov_heli_end_scene_loop", "targetname");
  level.makarov_heli vehicle_teleport(var_1.origin, var_1.angles);
  level.makarov_heli thread maps\_vehicle::vehicle_paths(var_1);
  wait 2;
  var_2 = getaiarray();

  foreach(var_4 in var_2) {
    if(!isenemyteam(var_4.team, level.player.team)) {
      var_4 thread maps\hijack_code::cold_breath_hijack();
    }
  }

  level.player giveweapon("fraggrenade");
  level.player setoffhandprimaryclass("frag");
  level.player setweaponammoclip("fraggrenade", 0);
  level.player setweaponammostock("fraggrenade", 0);
  level.player setoffhandsecondaryclass("flash");
  level.player giveweapon("flash_grenade");
  level.player setweaponammoclip("flash_grenade", 0);
  level.player setweaponammostock("flash_grenade", 0);
}

main() {
  thread maps\hijack_script_2c::end_scene();
  level.fixednodesaferadius_default = 256;
  thread start_tarmac_combat1();
  thread tarmac_combat_wave2();
  thread tarmac_combat_wave3();
  thread tarmac_combat_wave4();
  common_scripts\utility::flag_wait("entered_post_tarmac_area");
  thread tarmac_combat_vo();
  level waittill("commander_react_to_combat");
  level.commander.ignoreall = 0;
  level.commander.notarget = 0;
  level.commander.ignoreme = 0;
  level.commander notify("reach_notify");
  level.commander maps\_utility::clear_run_anim();
  level.commander maps\_utility::clear_generic_idle_anim();
  level.commander notify("stop_relaxed_idle");
  level.commander maps\_utility::anim_stopanimscripted();
  level.commander animscripts\animset::clear_custom_animset();
  level.commander maps\_utility::set_force_color("r");
  level.commander maps\_utility::enable_ai_color();
  level.commander.moveplaybackrate = 1.0;
  level.commander.disablearrivals = 0;
  maps\hijack_tarmac::set_player_move_and_jump_speed(1.0);
  level.commander maps\_utility::set_run_anim("tarmac_enter_combat_commander");
  var_0 = getanimlength(level.commander maps\_utility::getanim("tarmac_enter_combat_commander"));
  wait(var_0);
  level.commander maps\_utility::clear_generic_run_anim();
  wait 0.05;
  var_1 = level.commander.goalpos;
  level.commander setgoalpos(level.commander.origin);
  wait 0.05;
  level.commander setgoalpos(var_1);
}

start_tarmac_combat1() {
  level.secret_service_assist = maps\_utility::array_spawn_targetname("secret_service_assist");

  foreach(var_1 in level.secret_service_assist) {}
  var_1 maps\_utility::magic_bullet_shield();

  var_3 = maps\_utility::get_living_ai("tarmac_combat_running_agent", "script_noteworthy");
  var_3 thread tarmac_combat_fso_runner();
  common_scripts\utility::flag_wait("start_tarmacend_combat");
  level.commander.ignoreall = 0;
  level.commander.ignoreme = 0;
  thread maps\_utility::autosave_by_name("start_tarmac_combat");
  maps\_utility::battlechatter_on("axis");
  level.player giveweapon("fraggrenade");
  level.player setoffhandprimaryclass("frag");
  level.player setweaponammoclip("fraggrenade", 0);
  level.player setweaponammostock("fraggrenade", 0);
  level.player setoffhandsecondaryclass("flash");
  level.player giveweapon("flash_grenade");
  level.player setweaponammoclip("flash_grenade", 0);
  level.player setweaponammostock("flash_grenade", 0);
  var_4 = maps\_utility::array_spawn_targetname("tarmacrunners");
  var_5 = maps\_utility::array_spawn_targetname("tarmacrunners_delete");
  var_6 = getEntArray("tarmacrunners_shgn", "script_noteworthy");

  foreach(var_8 in var_6) {
    if(!isspawner(var_8)) {
      var_8 setgoalentity(level.player);
      break;
    }
  }

  foreach(var_1 in var_5) {}
  var_1.ignoreall = 1;

  thread tarmacrunners_delete();
  var_12 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("intro_gaz_turret");
  var_12 thread maps\hijack_tarmac::turn_on_headlights();
  var_12 thread suv_setup();
  var_13 = undefined;

  foreach(var_1 in var_12.riders) {}
  var_12 thread handle_rider_death(var_1, var_12);

  wait 0.25;
  var_16 = maps\_utility::get_ai_group_ai("tarmacwave1");

  foreach(var_1 in var_16) {}
  var_1.pathrandompercent = randomintrange(30, 100);

  maps\_audio::aud_send_msg("first_suv");
  wait 10;
  common_scripts\utility::flag_set("tarmac_combat_wave2");
}

tarmac_combat_fso_runner() {
  self endon("death");
  var_0 = getEnt("runner_ak74u", "targetname");
  var_0 hidepart("tag_acog_2");
  var_0 hidepart("tag_eotech");
  var_0 hidepart("tag_hamr_hybrid");
  var_0 hidepart("tag_silencer");
  var_0 hidepart("tag_thermal_scope");
  self.animname = "generic";
  maps\_utility::gun_remove();
  self.ignoreall = 1;
  self.ignoreme = 1;
  common_scripts\utility::flag_wait("entered_post_tarmac_area");
  wait 2.5;
  var_1 = common_scripts\utility::getStruct("agent_grabs_gun_origin", "targetname");
  var_1 maps\_anim::anim_reach_solo(self, "tarmac_enter_combat_agent");
  var_1 thread maps\_anim::anim_single_solo(self, "tarmac_enter_combat_agent");
  wait 1.2;
  maps\_utility::gun_recall();
  var_0 delete();
  self waittillmatch("single anim", "end");
  self.ignoreall = 0;
  self.ignoreme = 0;
  var_2 = getnode("agent_post_anim_node", "targetname");
  self setgoalnode(var_2);
  wait 10;
  maps\_utility::set_force_color("b");
}

tarmac_combat_wave2() {
  common_scripts\utility::flag_wait("tarmac_combat_wave2");
  thread maps\_utility::autosave_by_name("wave2_starting");
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("turret_gaz2");
  var_0 thread maps\hijack_tarmac::turn_on_headlights();
  var_0 thread suv_setup();
  var_1 = undefined;

  foreach(var_3 in var_0.riders) {}
  var_0 thread handle_rider_death(var_3, var_0);

  var_5 = maps\_utility::array_spawn_targetname("tarmacrunners2");
  var_6 = maps\_utility::get_ai_group_ai("tarmacwave2");

  foreach(var_3 in var_6) {}
  var_3.pathrandompercent = randomintrange(30, 100);

  maps\_utility::waittill_aigroupcount("tarmacwave2", 2);
  common_scripts\utility::flag_set("tarmac_combat_wave3");
  wait 10;
  retreat_from_vol_to_vol("tarmac_goal", "tarmac_goal_ret");
}

handle_rider_death(var_0, var_1) {
  var_0.noragdoll = 1;
  var_0.no_vehicle_ragdoll = 1;
}

tarmac_combat_wave3() {
  common_scripts\utility::flag_wait("tarmac_combat_wave3");
  thread maps\_utility::autosave_by_name("wave3_starting");
  retreat_from_vol_to_vol("tarmac_goal_ret", "tarmac_goal_ret2");
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("turret_gaz3");
  var_0 thread maps\hijack_tarmac::turn_on_headlights();
  var_0 thread suv_setup();
  var_1 = undefined;

  foreach(var_3 in var_0.riders) {}
  var_0 thread handle_rider_death(var_3, var_0);

  foreach(var_3 in level.secret_service_assist) {}
  var_3 maps\_utility::stop_magic_bullet_shield();

  var_7 = maps\_utility::array_spawn_targetname("tarmacwave3");

  foreach(var_3 in var_7) {}
  var_3.pathrandompercent = randomintrange(30, 100);

  maps\_utility::waittill_aigroupcleared("tarmacwave3");
  retreat_from_vol_to_vol("tarmac_goal_ret2", "tarmac_goal_ret3");
  common_scripts\utility::flag_set("tarmac_combat_wave4");
  var_10 = getEnt("red_leave_tarmac_combat", "targetname");

  if(isDefined(var_10)) {
    var_10 maps\_utility::activate_trigger();
  }
  common_scripts\utility::flag_set("flag_red_leave_tarmac_combat");
  thread maps\_utility::autosave_by_name("wave3_done");
}

tarmac_combat_wave4() {
  common_scripts\utility::flag_wait("tarmac_combat_wave4");
  var_0 = maps\_utility::array_spawn_noteworthy("endsceneguys_SUV");

  if(level.start_point != "end_scene") {
    var_1 = maps\_utility::array_spawn_noteworthy("endsceneguys");
    var_0 = common_scripts\utility::array_combine(var_0, var_1);
  }

  thread check_endsceneguys_commander_advance();
  var_2 = maps\_vehicle::spawn_vehicle_from_targetname("endsuburban");
  var_2 thread maps\hijack_tarmac::turn_on_headlights();
  level.commander.ignoresuppression = 1;
  level.endguytarget = getEnt("endguytarget", "targetname");

  foreach(var_4 in var_0) {
    if(isalive(var_4)) {
      if(var_4.script_aigroup == "endsceneguys") {
        var_4 setentitytarget(level.endguytarget);
        var_4 thread damagemonitor(var_0);
      }
    }
  }

  retreat_from_vol_to_vol("tarmac_goal_ret", "tarmac_goal_ret2");
  thread force_kill_endguys(var_0);
  maps\_utility::waittill_aigroupcleared("endsceneguys");
  wait 1;
  common_scripts\utility::flag_set("endguys_dead");
}

check_endsceneguys_commander_advance() {
  maps\_utility::waittill_aigroupcleared("endtarmacguys1");
  var_0 = getEnt("red_leave_tarmac_combat2", "targetname");
  var_1 = getEnt("red_leave_tarmac_combat", "targetname");

  if(isDefined(var_0)) {
    var_0 maps\_utility::activate_trigger();
  }
  level.commander.ignoreall = 1;

  if(isDefined(var_1)) {
    var_1 common_scripts\utility::trigger_off();
  }
}

combat_scene_fail_trigger() {
  var_0 = getEnt("combat_scene_fail_trigger", "targetname");
  common_scripts\utility::flag_wait("tarmac_combat_level_fail");
  setDvar("ui_deadquote", &"HIJACK_FAIL_TARMAC");
  level notify("mission failed");
  maps\_utility::missionfailedwrapper();
}

force_kill_endguys(var_0) {
  common_scripts\utility::flag_wait("kill_final_enemies");
  thread cleanup_tarmac();

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      magicbullet("AK74u", level.end_secret_service gettagorigin("tag_weapon"), var_2.origin + (0, 0, 36));
      wait 0.05;
      magicbullet("AK74u", level.end_secret_service gettagorigin("tag_weapon"), var_2.origin + (0, 0, 36));
      wait 0.05;
      magicbullet("AK74u", level.end_secret_service gettagorigin("tag_weapon"), var_2.origin + (0, 0, 36));
      wait 0.05;
      magicbullet("AK74u", level.end_secret_service gettagorigin("tag_weapon"), var_2.origin + (0, 0, 36));
      wait 0.05;
      var_2 kill();
    }

    wait 0.5;
  }
}

cleanup_tarmac() {
  var_0 = getaiarray("axis");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] kill();
  }
}

damagemonitor(var_0) {
  for(;;) {
    self waittill("damage", var_1, var_2);
    level.commander.ignoreall = 0;

    if(isDefined(var_2) && isPlayer(var_2)) {
      foreach(var_4 in var_0) {
        if(isDefined(var_4) && isalive(var_4)) {
          var_4 clearentitytarget(level.endguytarget);
        }
      }

      break;
    }
  }
}

tarmac_combat_vo() {
  maps\_utility::radio_dialogue("hijack_fso4_heavyfire");
  level notify("commander_react_to_combat");
  level.commander maps\_utility::dialogue_queue("hijack_cmd_wehavetomove");
  maps\_utility::radio_dialogue("hijack_fso4_notsecure");
  level notify("commander_call_to_combat");
  level.commander maps\_utility::dialogue_queue("hijack_cmd_getalenaout");
  common_scripts\utility::flag_wait("tarmac_combat_wave2");
  wait 1.0;
  maps\_utility::radio_dialogue("hijack_fso1_nearhangar");
  level.commander maps\_utility::dialogue_queue("hijack_cmd_letsmoveit");
  common_scripts\utility::flag_wait("tarmac_combat_wave3");
  wait 1.5;
  level.commander maps\_utility::dialogue_queue("hijack_cmd_keeppushing2");
  common_scripts\utility::flag_wait("tarmac_combat_wave4");
  wait 2.0;
  maps\_utility::radio_dialogue("hijack_fso2_multiplewounded");
  level.commander maps\_utility::dialogue_queue("hijack_cmd_moveupmoveup");
  maps\_utility::radio_dialogue("hijack_fso3_critical");
  wait 2.0;
  tarmac_combat_vo_end();
}

tarmac_combat_vo_end() {
  maps\_utility::radio_dialogue("hijack_fso3_codeblack");
  common_scripts\utility::flag_wait("player_approaching_end_guys");
  level.commander maps\_utility::dialogue_queue("hijack_cmd_takethemdown");
  common_scripts\utility::flag_wait("player_entered_end_area");
  level.commander maps\_utility::dialogue_queue("hijack_cmd_holdyourfire");
}

tarmacrunners_delete() {
  var_0 = getEnt("tarmacrunners_goal2", "targetname");

  for(;;) {
    wait 1;
    var_1 = var_0 maps\_utility::get_ai_touching_volume("axis");

    foreach(var_3 in var_1) {
      if(isDefined(var_3) && isalive(var_3) && isDefined(var_3.script_noteworthy)) {
        if(var_3.script_noteworthy == "tarmacrunners_goal2") {
          var_3 delete();
        }
      }
    }
  }
}

retreat_from_vol_to_vol(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_3 = var_2 maps\_utility::get_ai_touching_volume("axis");
  var_4 = getEnt(var_1, "targetname");
  var_5 = getnode(var_4.target, "targetname");

  foreach(var_7 in var_3) {
    if(isDefined(var_7) && isalive(var_7)) {
      var_7.fixednode = 0;
      var_7.pathrandompercent = randomintrange(75, 100);
      var_7 setgoalnode(var_5);
      var_7 setgoalvolume(var_4);
    }
  }
}

streets_ignore_enemies(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 3;
  }
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  self.ignoreall = 1;
  self clearenemy();

  if(var_0 == -1) {
    self waittill("goal");
  } else {
    wait(var_0);
  }
  if(isDefined(self) && isalive(self)) {
    if(var_1) {
      self delete();
      return;
    }

    self.ignoreall = 0;
    maps\_utility::disable_sprint();
  }
}

suv_setup() {
  self waittill("death");
  maps\_audio::aud_send_msg("suv_explosion");
  maps\_utility::play_sound_on_entity("hijk_suv_explosion");
}