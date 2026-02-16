/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\enemyhq_finale.gsc
*****************************************************/

enemyhq_finale_pre_load() {
  common_scripts\utility::flag_init("finale_sniping");
  common_scripts\utility::flag_init("open_finale_doors");
  common_scripts\utility::flag_init("start_butchdance");
  common_scripts\utility::flag_init("end_of_sniping");
  common_scripts\utility::flag_init("butchdance_sniping");
  common_scripts\utility::flag_init("finale_combat1");
  common_scripts\utility::flag_init("finale_combat3");
  common_scripts\utility::flag_init("more_finale_guys");
  common_scripts\utility::flag_init("flyaway_baddies");
  common_scripts\utility::flag_init("flyaway_lynx2");
  common_scripts\utility::flag_init("finale_done");
  common_scripts\utility::flag_init("merrick_exfil");
  common_scripts\utility::flag_init("ghosts_exfil2");
  common_scripts\utility::flag_init("chopper_ready");
  common_scripts\utility::flag_init("killed_trucks");
  common_scripts\utility::flag_init("obj_escape_complete");
  common_scripts\utility::flag_init("stop_drones");
}

setup_finale() {
  level.start_point = "finale";
  maps\enemyhq::setup_common();
  thread maps\enemyhq_audio::aud_check("finale");
  common_scripts\utility::flag_set("hvt_done");
  var_0 = getent("bishop", "targetname");
  level.bishop = var_0 maps\_utility::spawn_ai(1, 1);
  level.bishop.animname = "bishop";
  level.bishop maps\_utility::make_hero();
  level.bishop maps\_utility::gun_remove();
  level.allies[1] maps\enemyhq_code::carry_bishop();
  maps\enemyhq_code::safe_activate_trigger_with_targetname("pre_exit");
  thread keegan_idle_with_bishop();
  thread enable_finale_and_ghost_chopper_clips();
  thread maps\enemyhq_code::handle_leave_team_fail("leaving_clubhouse", "left_clubhouse");
}

setup_new_finale() {
  setup_finale();
  thread maps\enemyhq_audio::aud_check("newfinale");
}

begin_new_finale() {
  begin_finale();
}

#using_animtree("player");

begin_finale() {
  var_0 = getent("dog_chopper_clip", "targetname");
  var_0 notsolid();
  var_0 connectpaths();
  level.sniper_vision_override = "enemyhq_sniper_view_b";
  var_1 = getent("finale_dead_truck_clip", "targetname");

  if(isDefined(var_1))
    var_1 solid();

  var_1 = getent("finale_dead_truck", "targetname");

  if(isDefined(var_1))
    var_1 show();

  maps\_utility::stop_exploder(8);
  common_scripts\utility::exploder(888);
  maps\_utility::stop_exploder(8010);
  maps\_utility::stop_exploder(9090);
  level.ghost_chopper = maps\_vehicle::spawn_vehicles_from_targetname("ghost_chopper");
  level.ghost_chopper = level.ghost_chopper[0];
  var_2 = getaiarray("axis");
  common_scripts\utility::array_thread(var_2, maps\enemyhq_code::die_quietly);
  common_scripts\utility::array_thread(level.allies, maps\_utility::disable_pain);
  common_scripts\utility::flag_clear("done_sniping_early");
  maps\_utility::autosave_by_name("finale");
  thread handle_agressive_player();
  thread finale_vo();
  thread new_finale_dog_hijack();
  level.dog maps\enemyhq_code::lock_player_control();
  thread butchdance_combat();
  common_scripts\utility::flag_wait("open_finale_doors");
  thread maps\enemyhq_audio::aud_door_bust_open();
  thread open_exit_doors();
  level.remote_sniper_return_struct = common_scripts\utility::getstruct("butchdance_return_struct", "targetname");
  maps\enemyhq_code::safe_activate_trigger_with_targetname("to_exit");
  common_scripts\utility::flag_wait("start_butchdance");
  var_3 = common_scripts\utility::array_combine(level.allies, maps\_utility::make_array(level.bishop, level.dog));
  common_scripts\utility::array_thread(var_3, ::super_guy, 1);
  common_scripts\utility::flag_wait("butchdance_sniping");
  level notify("stop_leave_fails");
  level.dog thread maps\_utility::disable_pain();
  level.dog maps\_utility::set_ignoresuppression(1);
  wait 0.5;
  maps\enemyhq_code::safe_activate_trigger_with_targetname("butchdance0");
  var_4 = getnode("pre_exit_spot0", "targetname");
  level.allies[0] maps\_utility::teleport_ai(var_4);
  var_4 = getnode("pre_exit_spot1", "targetname");
  level.allies[1] maps\_utility::teleport_ai(var_4);
  common_scripts\utility::flag_wait("finale_asplode");
  var_5 = maps\_utility::spawn_anim_model("player_rig");
  var_5 linkto(level.finale_chopper, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_5 thread maps\_anim::anim_first_frame_solo(var_5, "get_in_chopper");
  var_5 hide();
  wait 0.1;
  common_scripts\utility::flag_wait("get_in_choppa");
  var_6 = level.player.origin - level.finale_chopper.origin;
  var_7 = anglestoright(level.finale_chopper.angles);
  var_8 = vectordot(var_6, var_7);

  if(var_8 > 0) {
    var_9 = "right";
    level.scr_anim["player_rig"]["get_in_chopper"] = % ehq_helicopter_enter_opposite_side_player;
    var_5 thread maps\_anim::anim_first_frame_solo(var_5, "get_in_chopper");
    wait 0.05;
  } else
    var_9 = "left";

  level.player enableinvulnerability();
  thread maps\_utility::autosave_now();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player setstance("stand");
  level.player disableweapons();
  level.player disableoffhandweapons();
  level.player playerlinktoblend(var_5, "tag_player", 0.5);
  var_5 thread arms_delayed_show();
  thread dog_ride_chopper(var_9);
  var_5 maps\_anim::anim_single_solo(var_5, "get_in_chopper");
  var_5 hide();
  level.player playerlinktodelta(var_5, "tag_player", 1, 25, 45, 30, 30, 1);
  level.player enableweapons();
  thread finale_flyaway();
  thread finale_sniping();
  wait 28;
  var_10 = 5;
  thread digital_out(0.5, var_10);
  wait 2.5;
  common_scripts\utility::flag_set("finale_done");
  level.player notify("fadeup_static_finale");
  wait 3.5;
  var_11 = maps\enemyhq_code::create_overlay_element("black", 0);
  var_11 fadeovertime(2);
  var_11.alpha = 1;
  wait 2;
  maps\_utility::nextmission();
  wait 10;
}

arms_delayed_show() {
  wait 0.5;
  self show();
}

digital_out(var_0, var_1) {
  var_2 = 0;
  var_3 = 0.3;
  var_4 = var_2;

  if(isDefined(var_0))
    var_3 = var_0;

  var_5 = 1.25;

  if(isDefined(var_1))
    var_5 = var_1;

  var_6 = 0.05;
  var_7 = var_5 / var_6;
  var_8 = 1 / var_7;
  var_9 = 90 / var_7;
  var_10 = 89.9;

  while(var_10 > 0) {
    var_11 = cos(var_10);
    level.player digitaldistortsetparams(var_11, var_11);
    wait 0.05;
    var_4 = var_4 + var_8;

    if(var_10 > 45) {
      var_10 = var_10 - var_9 / 2;
      continue;
    }

    var_10 = var_10 - var_9;
  }

  level.player digitaldistortsetparams(1, 0);
}

keegan_idle_with_bishop() {
  level.allies[1] maps\_utility::disable_ai_color();
  var_0 = common_scripts\utility::getstruct("keegan_putdown_bishop_org", "targetname");
  var_0 maps\_anim::anim_reach_solo(level.allies[1], "wounded_carry_putdown");
  level.allies[1] notify("stop_anim");
  level.bishop notify("stop_anim");
  level.bishop maps\_utility::anim_stopanimscripted();
  waittillframeend;
  level.allies[1] thread maps\_anim::anim_loop_solo(level.allies[1], "wounded_carry_idle");
  level.bishop thread bishop_loop_carry_pose();
  common_scripts\utility::flag_wait("butchdance_sniping");
  level.allies[1] maps\_utility::anim_stopanimscripted();
  common_scripts\utility::waitframe();
  level.allies[1] maps\_utility::enable_ai_color();
  level.allies[1] maps\enemyhq_code::carry_bishop();
}

bishop_loop_carry_pose() {
  level.bishop thread maps\_anim::anim_loop_solo(level.bishop, "wounded_carry_idle");
  common_scripts\utility::flag_wait("butchdance_sniping");
  level.bishop maps\_utility::anim_stopanimscripted();
}

hesh_ride_chopper() {
  var_0 = level.allies[0];
  var_0.ignoreme = 0;
  var_0 linkto(level.finale_chopper);
  var_0 maps\_utility::gun_remove();
  level.finale_chopper maps\_anim::anim_single_solo(var_0, "get_in_chopper", "tag_origin");
  var_0.script_startingposition = 0;
  level.finale_chopper thread maps\_vehicle::vehicle_load_ai(level.allies);
}

dog_ride_chopper(var_0) {
  level.dog maps\enemyhq_code::set_dog_scripted_mode(level.player);

  if(isDefined(var_0) && var_0 == "right")
    wait 3.0;
  else
    level.finale_chopper maps\_anim::anim_single_solo(level.dog, "get_in_chopper", "tag_origin");

  if(isDefined(level.dog.magic_bullet_shield) && level.dog.magic_bullet_shield == 1)
    level.dog maps\_utility::stop_magic_bullet_shield();

  level.dog maps\_utility_dogs::kill_dog_fur_effect_and_delete();
}

super_guy(var_0) {
  self.ignoresuppression = var_0;

  if(var_0) {
    self.old_accuracy = self.baseaccuracy;
    self.baseaccuracy = 0.1;
  } else
    self.baseaccuracy = self.old_accuracy;

  self.dodangerreact = !var_0;
  self.disablebulletwhizbyreaction = var_0;
}

new_finale_dog_hijack() {
  var_0 = common_scripts\utility::getstruct("finale_dog_scene", "targetname");
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname("new_finale_chopper");
  var_1.animname = "heli";
  level.finale_chopper = var_1;
  level.finale_chopper maps\_vehicle::godon();
  thread maps\enemyhq_audio::aud_chopper_second(var_1);
  common_scripts\utility::flag_wait("end_of_sniping");
  var_2 = getent("dog_chopper_clip", "targetname");
  var_2 solid();
  var_2 disconnectpaths();
  var_3 = getent("amazing_crate", "targetname");
  var_4 = getent("amazing_crate_clip", "targetname");
  var_4 linkto(var_3);
  var_4 connectpaths();
  var_5 = common_scripts\utility::getstruct("amazing_crate_loc", "targetname");
  var_3.origin = var_5.origin;
  var_4 disconnectpaths();
  var_6 = getent("dog_hijackee", "targetname");
  var_7 = var_6 maps\_utility::spawn_ai(1, 1);
  var_7.ignoreall = 1;
  var_7.ignoreme = 1;
  var_7.animname = "generic";
  level.dog maps\_utility::anim_stopanimscripted();
  level.dog unlink();
  wait 0.1;
  level.allies[0].animname = "hesh";
  var_8 = maps\_utility::make_array(var_1, level.dog, var_7, level.allies[0]);
  var_9 = var_1 setcontents(0);
  var_0 thread maps\_anim::anim_single(var_8, "new_dog_hijack");
  var_1 waittillmatch("single anim", "end");
  var_2 connectpaths();
  var_2 notsolid();
  var_10 = getent("dog_chopper_player_clip", "targetname");
  var_10 notsolid();
  var_1 setcontents(var_9);
  var_1 thread maps\_vehicle_code::animate_drive_idle();
  wait 1;
  common_scripts\utility::flag_set("chopper_ready");
}

finale_flyaway() {
  var_0 = common_scripts\utility::getstruct("finale_chopper_path", "targetname");
  level.finale_chopper.attachedpath = undefined;
  level.finale_chopper notify("newpath");
  level.finale_chopper thread maps\_vehicle::vehicle_paths(var_0);
  level.finale_chopper vehicle_setspeed(5, 30, 30);
  level.finale_chopper resumespeed(5);
  wait 5.0;
  level notify("finale_chopper_taking_off");
  common_scripts\utility::flag_set("finale_chopper_continue");
}

open_exit_doors() {
  var_0 = getent("dugout_exit_door_left", "targetname");
  var_1 = getent("dugout_exit_door_right", "targetname");
  var_0 rotateyaw(-105, 0.2, 0.1, 0.1);
  var_0 connectpaths();
  var_1 rotateyaw(105, 0.2, 0.1, 0.1);
  var_1 connectpaths();
  wait 1;
  level.allies[1] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_kgn_incomingbackdown");
}

watch_for_end_of_sniping() {
  level waittill("hot_butchdance_action");
  common_scripts\utility::flag_set("butchdance_sniping");
  level.player waittill("remote_turret_deactivate");
  common_scripts\utility::flag_set("end_of_sniping");
  thread player_fail_finale();
  thread player_fail_finale_instakill();
  common_scripts\utility::array_thread(level.allies, maps\_utility::enable_pain);
}

spawn_lockdown_guy() {
  while(!common_scripts\utility::flag("finale_sniping")) {
    var_0 = maps\_utility::spawn_ai(1);
    var_0 maps\enemyhq_code::gasmask_on_npc();

    if(isDefined(self.script_aigroup) && self.script_aigroup == "finale_lmgs")
      var_0 getenemyinfo(level.player);

    var_0 thread handle_butchdance_enemies();

    if(isDefined(var_0)) {
      var_0 waittill("death");
      wait 0.5;
      continue;
    }

    return;
  }
}

clear_lmgs() {
  wait 0.2;
  maps\_utility::waittill_aigroupcleared("finale_lmgs");
  common_scripts\utility::flag_set("finale_combat1");
}

handle_agressive_player() {
  level endon("death");
  var_0 = common_scripts\utility::getstruct("killer_org", "targetname");
  common_scripts\utility::flag_wait("open_finale_doors");
  wait 1;

  while(!common_scripts\utility::flag("end_of_sniping")) {
    common_scripts\utility::flag_wait_any("finale_kill", "finale_really_kill", "end_of_sniping");
    var_1 = 0.5;

    if(common_scripts\utility::flag("end_of_sniping")) {
      break;
    }

    while(common_scripts\utility::flag("finale_kill") || common_scripts\utility::flag("finale_really_kill")) {
      magicbullet("m27", var_0.origin, level.player.origin + (0, 0, 32));

      if(common_scripts\utility::flag("finale_really_kill"))
        level.player kill();

      wait(var_1);

      if(!common_scripts\utility::flag("finale_kill")) {
        var_1 = 0.5;
        continue;
      }

      var_1 = var_1 - 0.1;

      if(var_1 < 0.1)
        var_1 = 0.1;
    }
  }
}

butchdance_combat() {
  var_0 = getEntArray("exfil_guys1", "targetname");

  foreach(var_2 in var_0)
  var_2 thread spawn_lockdown_guy();

  thread maps\enemyhq_code::toggle_ally_outlines(0);
  level.player waittill("player_switching_to_tablet");
  thread maps\enemyhq_audio::aud_start_sniper("enhq_stadium_large_room");
  common_scripts\utility::flag_set("finale_sniping");
  var_4 = maps\enemyhq_code::array_spawn_targetname_allow_fail("exfil_guys1b", 1);
  common_scripts\utility::array_thread(var_4, ::handle_butchdance_enemies);
  var_4 = getaiarray("axis");
  thread maps\enemyhq_code::ai_array_killcount_flag_set(var_4, 2, "finale_combat1");
  thread clear_lmgs();
  common_scripts\utility::flag_wait("finale_combat1");
  var_4 = getaiarray("axis");
  var_4 common_scripts\utility::array_thread(var_4, maps\_utility::set_force_color, "y");
  var_4 common_scripts\utility::array_thread(var_4, maps\_utility::enable_ai_color);
  common_scripts\utility::array_thread(level.allies, maps\_utility::set_ignoresuppression, 1);
  var_5 = common_scripts\utility::array_add(level.allies, level.dog);
  common_scripts\utility::array_thread(var_5, ::super_guy, 0);
  wait 0.5;
  var_6 = maps\_utility::obj("defendsnipe");
  objective_onentity(var_6, level.allies[0], (0, 0, 0));
  objective_add(var_6, "current", &"ENEMY_HQ_PROTECT_MERRICK_AND_KEEGAN");
  objective_setpointertextoverride(var_6, &"ENEMY_HQ_PROTECT");
  maps\enemyhq_code::safe_activate_trigger_with_targetname("butchdance1");
  var_4 = maps\enemyhq_code::array_spawn_targetname_allow_fail("ghost_exfil_wave1", 1);
  thread maps\enemyhq_code::ai_array_killcount_flag_set(var_4, var_4.size - 1, "ghosts_exfil2");

  foreach(var_8 in var_4)
  var_8 thread maps\enemyhq_audio::aud_handle_remote_sniper_ai(level.aud_finale_sniper);

  common_scripts\utility::flag_wait("ghost_timer_start");
  level.player thread maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_mrk_giveussomecovering");
  common_scripts\utility::flag_wait_or_timeout("ghosts_exfil2", 10);

  if(!common_scripts\utility::flag("ghosts_exfil2"))
    level.player thread maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_mrk_weretakingfire");

  common_scripts\utility::flag_wait_or_timeout("ghosts_exfil2", 10);

  if(!common_scripts\utility::flag("ghosts_exfil2")) {
    var_10 = common_scripts\utility::getstruct("ghost_kill", "targetname");
    level.allies[0] maps\_utility::stop_magic_bullet_shield();
    level.allies[1] maps\_utility::stop_magic_bullet_shield();
    magicbullet("m27", var_10.origin, level.allies[0].origin);
    magicbullet("m27", var_10.origin, level.allies[1].origin);
    wait 0.5;
    setDvar("ui_deadquote", &"ENEMY_HQ_MERRICK_AND_KEEGAN_WERE");
    maps\_utility::missionfailedwrapper();
    return;
  } else
    var_4 = maps\enemyhq_code::array_spawn_targetname_allow_fail("ghost_exfil_wave2", 1);

  var_11 = getnode("merrick_node", "targetname");
  var_12 = getnode("keegan_node", "targetname");
  level.allies[0] maps\_utility::disable_ai_color();
  level.allies[1] maps\_utility::disable_ai_color();
  level.allies[0] maps\_utility::set_goalradius(20);
  level.allies[1] maps\_utility::set_goalradius(20);
  level.allies[0] maps\_utility::set_goal_node(var_11);
  level.allies[1] maps\_utility::set_goal_node(var_12);
  level.allies[0] maps\_utility::set_ignoresuppression(1);
  level.allies[0] clearenemy();
  level.allies[1] maps\_utility::set_ignoresuppression(1);
  level.allies[1] clearenemy();
  level.allies[0].ignoreall = 1;
  level.allies[1].ignoreall = 1;
  level.allies[1].ignoreme = 1;
  wait 1;
  thread waitfor_merrick();
  level.allies[1] waittill("goal");
  objective_position(var_6, (0, 0, 0));
  common_scripts\utility::flag_wait("merrick_exfil");
  level.player thread maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_mrk_wemadeitthanks");
  level.allies[0].vehicle_position = 1;
  level.allies[0].script_startingposition = 1;
  level.ghost_chopper thread maps\_vehicle::vehicle_load_ai([level.allies[0]]);
  level.bishop notify("stop_anim");
  level.allies[1] notify("stop_anim");
  level.allies[1] hide();
  level.bishop hide();
  level.allies[1] maps\enemyhq_code::die_quietly();
  level.bishop maps\enemyhq_code::die_quietly();
  level.allies = maps\_utility::make_array(level.allies[2]);
  var_13 = common_scripts\utility::getstruct("ghost_chopper_path", "targetname");
  level.ghost_chopper.attachedpath = undefined;
  level.ghost_chopper notify("newpath");
  level.ghost_chopper thread maps\_vehicle::vehicle_paths(var_13);
  level.ghost_chopper vehicle_setspeed(5, 30, 30);
  level.ghost_chopper resumespeed(5);
  level notify("ghost_chopper_taking_off");
  wait 2;
  level.player thread maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_mrk_takinoff");
  wait 4;
  level.player thread maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_mrk_weregoodnowget");
  wait 2;
  maps\_utility::objective_complete(var_6);
  thread handle_ghost_chopper_removal();
  common_scripts\utility::flag_set("done_sniping_early");
  var_4 = getaiarray("axis");
  var_4 = maps\_utility::array_removedead_or_dying(var_4);
  var_4 = sortbydistance(var_4, level.dog.origin);

  if(var_4.size > 2) {
    var_4 = common_scripts\utility::array_remove(var_4, var_4[0]);
    var_4 = common_scripts\utility::array_remove(var_4, var_4[1]);
  }

  level.dog.ignoreme = 1;
  level.dog thread maps\enemyhq_code::dog_attack_targets_by_priority(var_4, "finale_push1");
  thread maps\enemyhq_code::toggle_ally_outlines(1);
  var_4 = maps\enemyhq_code::array_spawn_targetname_allow_fail("exfil_guys2", 1);
  var_14 = getaiarray("axis");
  var_14 = maps\_utility::array_removedead_or_dying(var_14);
  thread maps\enemyhq_code::ai_array_killcount_flag_set(var_14, var_14.size - 1, "finale_push2");
  common_scripts\utility::flag_wait_or_timeout("start_finale_truck", 4);
  common_scripts\utility::flag_wait("start_finale_truck");
  maps\_utility::delaythread(3, maps\enemyhq_code::safe_activate_trigger_with_targetname, "butchdance1a");
  wait 2;
  var_4 = getaiarray("axis");
  thread maps\enemyhq_code::ai_array_killcount_flag_set(var_4, 2, "finale_push1");
  common_scripts\utility::flag_wait_or_timeout("finale_push1", 5);
  common_scripts\utility::flag_set("finale_push1");
  thread handle_final_finale_guys();
  thread handle_finale_drones();
  maps\enemyhq_code::safe_activate_trigger_with_targetname("butchdance2");
  var_4 = getaiarray("axis");
  thread maps\enemyhq_code::ai_array_killcount_flag_set(var_4, 2, "finale_push1");
  common_scripts\utility::flag_wait("chopper_ready");
  thread handle_final_combat();
  common_scripts\utility::flag_wait("get_in_choppa");
  var_15 = getaiarray("axis");
  var_5 = level.allies;
  level.dog.ignoreall = 1;
  level.dog.ignoreme = 1;
  level.finale_chopper setvehicleteam("allies");
  level.finale_chopper.script_team = "allies";
  thread hesh_ride_chopper();
  wait 1;
  level.dead_finale_trucks = 0;
  var_16 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("flyaway_lynx");
  var_17 = get_vehicle_turret_ai(var_16);

  foreach(var_8 in var_17)
  var_8 getenemyinfo(level.allies[0]);

  common_scripts\utility::array_thread(var_16, ::flyaway_lynx_death_watcher);
  common_scripts\utility::array_thread(var_16, ::handle_truck_shooting);
  thread maps\enemyhq_code::ai_array_killcount_flag_set(var_17, var_17.size - 1, "killed_trucks");
  common_scripts\utility::flag_wait("flyaway_baddies");
  wait 2;
  maps\_utility::delaythread(2, ::finale_explosions);
  var_20 = maps\_utility::obj("finale_defend");
  objective_add(var_20, "current", &"ENEMY_HQ_DESTROY_VEHICLE_MOUNTED");
  objective_onentity(var_20, level.finale_chopper, (0, 0, 0));
  objective_setpointertextoverride(var_20, &"ENEMY_HQ_PROTECT");

  if(1) {
    common_scripts\utility::flag_set("stop_drones");
    maps\_utility::array_delete(level.drones["axis"].array);
    var_15 = maps\_utility::array_removedead_or_dying(var_15);
    var_4 = maps\enemyhq_code::array_spawn_targetname_allow_fail("dan_guys", 1);
    wait 0.1;
    common_scripts\utility::array_thread(var_15, maps\enemyhq_code::die_quietly);
    level.allies[0].ignoreme = 0;
    common_scripts\utility::array_thread(var_4, ::fire_at_chopper, level.allies[0], 3, 5);
  } else {
    var_21 = getaiarray("axis");

    if(var_21.size < 7) {
      var_4 = maps\enemyhq_code::array_spawn_targetname_allow_fail("exfil_guys4", 1);
      common_scripts\utility::array_thread(var_4, ::fire_at_chopper, level.finale_chopper, 3, 5);
    }
  }

  thread maps\enemyhq_audio::aud_lynx_turrets(var_16);
  common_scripts\utility::array_thread(var_16, ::handle_end_lynxes);

  while(level.dead_finale_trucks < 2)
    wait 0.1;

  common_scripts\utility::flag_set("killed_trucks");
  common_scripts\utility::flag_wait("finale_done");
  common_scripts\utility::flag_set("obj_escape_complete");
  maps\_utility::objective_complete(var_20);
}

handle_final_combat() {
  common_scripts\utility::flag_wait_or_timeout("finale_push2", 9);
  common_scripts\utility::flag_set("finale_push2");
  level.allies[0].ignoreall = 1;
  level.allies[0] maps\_utility::set_ignoresuppression(1);
  level.allies[0] clearenemy();
  maps\enemyhq_code::safe_activate_trigger_with_targetname("butchdance3");
  level.allies[0] maps\_utility::delaythread(2, maps\_utility::set_ignoreall, 0);
}

handle_truck_shooting() {
  var_0 = self.mgturret[0];
  var_0 settoparc(90);
  var_0 setsuppressiontime(10);
  var_0 setaispread(10);
  level.allies[0].ignoreme = 0;
  var_0 setmode("manual_ai");
  var_0 settargetentity(level.finale_chopper);

  foreach(var_2 in self.riders) {
    var_2.favoriteenemy = level.player;
    var_2.maxsightdistsqrd = 400000000;
  }

  self waittill("reached_dynamic_path_end");
  self setturrettargetent(level.finale_chopper);
}

flyaway_lynx_death_watcher() {
  self waittill("death");
  playFX(level._effect["vfx_ehq_lynxexplode"], self.origin);
  playFX(level._effect["vfx_lynx_fire_exfil"], self.origin);
  level.player thread maps\_utility::play_sound_on_entity("car_explode_2");
}

handle_ghost_chopper_removal() {
  level.ghost_chopper waittill("reached_dynamic_path_end");

  foreach(var_1 in level.ghost_chopper.riders)
  var_1 maps\enemyhq_code::die_quietly();

  level.ghost_chopper delete();
}

get_vehicle_turret_ai(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    foreach(var_5 in var_3.riders) {
      if(var_5.vehicle_position == 3)
        var_1[var_1.size] = var_5;
    }
  }

  return var_1;
}

handle_flyaway_fail() {
  wait 17;

  if(!common_scripts\utility::flag("killed_trucks")) {
    level.finale_chopper notify("going_down");
    playFXOnTag(level._effect["vfx_heli_fire"], level.finale_chopper, "tag_engine_right");
    var_0 = common_scripts\utility::getstruct("finale_crash_path", "targetname");
    level.finale_chopper thread maps\_vehicle_code::helicopter_crash_rotate();
    thread truck_turret_fail();
    level.finale_chopper maps\_vehicle_code::helicopter_crash_path(var_0);
    playFXOnTag(level._effect["vfx_heli_crash"], level.finale_chopper, "tag_deathfx");
  }
}

truck_turret_fail() {
  wait 4;
  setDvar("ui_deadquote", &"ENEMY_HQ_YOU_WERE_SHOT_DOWN_BY");
  maps\_utility::missionfailedwrapper();
}

waitfor_merrick() {
  level.allies[0] waittill("goal");
  common_scripts\utility::flag_set("merrick_exfil");
}

handle_end_lynxes() {
  thread handle_dead_truck();
  var_0 = self.riders;
}

handle_dead_truck() {
  self waittill("death");
  level.dead_finale_trucks++;
}

fire_at_chopper(var_0, var_1, var_2) {
  var_0.ignoreme = 0;
  self.ignoreall = 0;
  self getenemyinfo(var_0);
}

handle_butchdance_enemies(var_0) {
  self endon("death");
  level waittill("hot_butchdance_action");
  self.ignoreme = 0;
  wait(randomfloatrange(1.5, 2.5));
  self.accuracy = 0.1;
  self.ignoreall = 0;
}

handle_finale_drones() {
  level endon("death");
  var_0 = getEntArray("finale_drone", "targetname");
  var_0 = common_scripts\utility::array_randomize(var_0);

  foreach(var_2 in var_0) {
    var_3 = maps\_utility::dronespawn(var_2);
    var_3.spawner = var_2;
    var_3 thread handle_drone();
    wait(randomfloatrange(0.2, 0.75));
  }
}

handle_drone() {
  self endon("death");
  self waittill("goal");

  if(!common_scripts\utility::flag("finale_done") && !common_scripts\utility::flag("stop_drones")) {
    var_0 = maps\_utility::dronespawn(self.spawner);
    var_0.spawner = self.spawner;
    var_0 thread handle_drone();
  }

  self delete();
}

handle_final_finale_guys() {
  level endon("death");

  while(!common_scripts\utility::flag("finale_done")) {
    var_0 = maps\enemyhq_code::array_spawn_targetname_allow_fail("exfil_guys3", 1);

    if(common_scripts\utility::flag("get_in_choppa"))
      common_scripts\utility::array_thread(var_0, ::fire_at_chopper, level.allies[0], 3, 5);

    var_0 = getaiarray("axis");
    maps\enemyhq_code::ai_array_killcount_flag_set(var_0, int(var_0.size / 2), "more_finale_guys");
    common_scripts\utility::flag_wait("more_finale_guys");
    common_scripts\utility::flag_clear("more_finale_guys");
  }
}

finale_explosions() {
  var_0 = common_scripts\utility::getStructArray("finale_explosion", "targetname");

  foreach(var_2 in var_0) {
    playFX(level._effect["finale_explosion"], var_2.origin);
    wait(randomfloatrange(0.5, 1));
  }
}

finale_sniping() {
  level.player thread maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_hsh_coveruswiththe");
  wait 1.5;
  common_scripts\utility::flag_set("start_exfil_sniper");
  wait 0.2;
  level.player notify("scripted_sniper_dpad");
  thread handle_flyaway_fail();
  common_scripts\utility::flag_set("flyaway_baddies");
  wait 7;
  maps\enemyhq_code::safe_activate_trigger_with_targetname("butchdance4");
}

spawn_player_dummy() {
  wait 1;
  var_0 = getent("player_dummy", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai();
  var_1 maps\_utility::magic_bullet_shield();
  var_1.animname = "generic";
  var_1 linkto(level.finale_chopper, "tag_guy4", (0, 0, 0), (0, 0, 0));
}

finale_vo() {
  common_scripts\utility::flag_wait("pre_exit_scene");
  var_0 = level.allies[2];
  level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_youboysdidok");
  thread watch_for_end_of_sniping();
  common_scripts\utility::flag_wait("open_finale_doors");
  wait 3;
  thread maps\enemyhq_code::nag_player_until_flag(level.allies[0], "start_butchdance", "enemyhq_mrk_adamthinemout", "enemyhq_mrk_usetheremotesniper_2", "enemyhq_mrk_adamgetonthe");
  common_scripts\utility::flag_set("enable_butchdance");
  maps\_utility::delaythread(1, maps\enemyhq_code::sniper_hint, "start_butchdance", 4);
  level.player waittill("player_switching_to_tablet");
  common_scripts\utility::flag_set("start_butchdance");
  wait 3;
  level.player maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_mrk_thosechoppersareour");
  level.player thread maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_mrk_welltaketheone");
  wait 1;
  thread maps\enemyhq_code::nag_player_until_flag(level.player, "butchdance_sniping", "enemyhq_mrk_takeoutthoselmgs", "enemyhq_mrk_wheneveryoureready", "enemyhq_mrk_takeashot_2");
  common_scripts\utility::flag_wait("butchdance_sniping");
  thread hurry_lines();
  common_scripts\utility::flag_wait("finale_combat1");
  level.player maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_mrk_itsclear");
  level.player maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_mrk_gogogo_2");
  level.player maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_mrk_coverus");
  common_scripts\utility::flag_wait("end_of_sniping");
  wait 0.25;
  level.player maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_hsh_ourrideisleaving");
  level.player maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_hsh_riley");
  wait 3;
  common_scripts\utility::flag_wait("chopper_ready");
  level.player maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_hsh_clearapathto");
  common_scripts\utility::flag_wait("finale_push2");
  thread maps\enemyhq_code::nag_player_until_flag(var_0, "get_in_choppa", "enemyhq_hsh_gettothechopper", "enemyhq_hsh_adamthechopper", "enemyhq_hsh_adamgetoverhere", "enemyhq_hsh_weveleaving");
  common_scripts\utility::flag_wait("get_in_choppa");
  wait 8;
  level.player thread maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_hsh_takeouttheturrets");
  wait 5;

  if(!common_scripts\utility::flag("killed_trucks")) {
    level.player thread maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_hsh_shootthetrucks");
    wait 5;

    if(!common_scripts\utility::flag("killed_trucks"))
      level.player thread maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_hsh_yougottahitthose");
  }

  common_scripts\utility::flag_wait("killed_trucks");
  wait 3;
  level.player maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_hsh_commandthisisviking");
  level.player maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_els_heshlogancanyou");
  level.player maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_hsh_dad");
  level.player maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_els_wevegotafull");
  level.player maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_hsh_daddad");
}

hurry_lines() {
  level waittill("hot_butchdance_action");
  wait 6;
  level.player maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_hsh_chopperswindingup");
  wait 1;

  if(!common_scripts\utility::flag("end_of_sniping"))
    level.player maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_hsh_loganhurry");
}

enable_finale_and_ghost_chopper_clips() {
  var_0 = getent("new_finale_chopper_ai_clip", "targetname");
  var_1 = getent("ghost_chopper_ai_clip", "targetname");
  level waittill("ghost_chopper_taking_off");
  var_1 notsolid();
  var_1 connectpaths();
  level waittill("finale_chopper_taking_off");
  var_0 notsolid();
  var_0 connectpaths();
}

player_fail_finale() {
  level.player endon("death");
  var_0 = [];
  var_0[0] = "enemyhq_hsh_whereareyougoing";
  var_0[1] = "enemyhq_hsh_logangetoverhere";

  for(;;) {
    common_scripts\utility::flag_wait("player_left_finale_area");
    var_1 = 0;

    while(common_scripts\utility::flag("player_left_finale_area")) {
      if(var_1 > var_0.size - 1) {
        setDvar("ui_deadquote", &"ENEMY_HQ_YOU_LEFT_YOUR_TEAM_BEHIND");
        maps\_utility::missionfailedwrapper();
        break;
      }

      level.player maps\enemyhq_code::radio_dialog_add_and_go(var_0[var_1]);
      var_1++;
      wait(randomfloatrange(2, 4));
    }
  }
}

player_fail_finale_instakill() {
  level.player endon("death");
  common_scripts\utility::flag_wait("player_left_finale_area_instakill");
  setDvar("ui_deadquote", &"ENEMY_HQ_YOU_LEFT_YOUR_TEAM_BEHIND");
  maps\_utility::missionfailedwrapper();
}