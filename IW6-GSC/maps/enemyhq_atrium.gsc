/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\enemyhq_atrium.gsc
*****************************************************/

enemyhq_atrium_pre_load() {
  thread check_triggers_flagset("TRIG_advance_allies_wave2");
  thread check_triggers_flagset("TRIG_advance_allies_wave3");
  thread check_triggers_flagset("TRIG_advance_allies_wave4");
  thread check_triggers_flagset("TRIG_advance_allies_wave5");
  thread check_triggers_flagset("TRIG_advance_allies_wave6");
  common_scripts\utility::flag_init("kick_off_atrium_combat");
  common_scripts\utility::flag_init("player_getout_atrium");
  common_scripts\utility::flag_init("FLAG_bust_thru_prep");
  common_scripts\utility::flag_init("FLAG_kill_dog_kill_guy");
  common_scripts\utility::flag_init("FLAG_player_exit_truck");
  common_scripts\utility::flag_init("FLAG_atrium_dog_hint");
  common_scripts\utility::flag_init("atrium_done");
  common_scripts\utility::flag_init("FLAG_atrium_wave2");
  common_scripts\utility::flag_init("FLAG_atrium_wave3");
  common_scripts\utility::flag_init("FLAG_atrium_wave4");
  common_scripts\utility::flag_init("FLAG_atrium_wave5");
  common_scripts\utility::flag_init("FLAG_atrium_wave6");
  common_scripts\utility::flag_init("FLAG_atrium_done");
  common_scripts\utility::flag_init("FLAG_bust_thru_prep");
  common_scripts\utility::flag_init("FLAG_ai_final_stand");
  common_scripts\utility::flag_init("FLAG_vo_triggersonfingers");
  common_scripts\utility::flag_init("FLAG_mk32_detach");
  common_scripts\utility::flag_init("FLAG_mk32_atrium_detonate");
  common_scripts\utility::flag_init("FLAG_mk32_shot1");
  common_scripts\utility::flag_init("FLAG_mk32_shot2");
  common_scripts\utility::flag_init("FLAG_mk32_shot3");
  common_scripts\utility::flag_init("FLAG_mk32_shot4");
  common_scripts\utility::flag_init("FLAG_atrium_ally_mk32_anim");
  common_scripts\utility::flag_init("FLAG_player_outside");
}

rampfx() {
  common_scripts\utility::exploder(9000);
  wait 0.5;
  common_scripts\utility::exploder(9001);
  wait 0.5;
  common_scripts\utility::exploder(9002);
  wait 0.5;
  common_scripts\utility::exploder(9003);
  wait 0.5;
  common_scripts\utility::exploder(9004);
}

setup_atrium() {
  level.start_point = "atrium";
  maps\enemyhq::setup_common();
  thread maps\enemyhq_audio::aud_check("atrium");
  level.setup_atrium_check = 1;
  spawn_truck_setup_riders();
  common_scripts\utility::flag_set("FLAG_bust_thru_prep");
  level.player enabledeathshield(1);
  thread wall_chunks_hide();
  level.dog maps\enemyhq_code::lock_player_control();
}

begin_atrium() {
  thread maps\_utility::autosave_tactical();
  thread bust_thru();
  thread bust_thru_prep();
  handle_ally_threatbiasgroup();
  thread watch_inside_trigger();
  thread watch_outside_trigger();
  maps\_utility::battlechatter_on("allies");
  maps\_utility::battlechatter_on("axis");
  maps\_utility::delaythread(0.05, maps\_utility::set_team_bcvoice, "allies", "delta");
  level.dog maps\enemyhq_code::lock_player_control();
  setignoremegroup("dog", "axis");
  thread start_atrium_combat();
  common_scripts\utility::trigger_off("TRIG_player_exit_truck", "targetname");
  common_scripts\utility::flag_wait("atrium_done");

  foreach(var_1 in level.allies)
  var_1.ignoresuppression = 1;
}

spawn_truck_setup_riders() {
  level.player_truck = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("vehicle_breakthru");
  level.player_truck.dontunloadonend = 1;
  var_0 = level.player_truck;
  level.allies[1] linkto(level.player_truck, "tag_driver");
  level.allies[1] maps\_utility::gun_remove();
  var_0 thread maps\_anim::anim_loop_solo(level.allies[1], "enter_truck_loop", "stop_keegan_loop", "tag_driver");
  level.allies[0] linkto(level.player_truck, "tag_detach");
  var_0 thread maps\_anim::anim_loop_solo(level.allies[0], "enter_truck_loop", "stop_baker_loop", "tag_detach");
  level.allies[2] linkto(level.player_truck, "tag_detach");
  var_0 thread maps\_anim::anim_loop_solo(level.allies[2], "enter_truck_loop", "stop_hesh_loop", "tag_detach");
  level.dog linkto(level.player_truck, "tag_dog");
  level.player_truck thread maps\_anim::anim_loop_solo(level.dog, "veh_idle", "stop_dog_loop", "tag_dog");
  thread maps\enemyhq_code::player_enter_truck_atrium_startpoint(level.player_truck);
}

bust_thru_prep() {
  common_scripts\utility::flag_wait("FLAG_bust_thru_prep");
  thread rampfx();
  thread maps\enemyhq_audio::aud_bust_thru();
  level.allies[2].animname = "hesh";
  level.allies[1].animname = "keegan";
  thread bust_thru_prep_dog();
  thread pre_spawn_atrium_runners();
  thread screenshake_bust_thru_prep();
  common_scripts\utility::exploder(9094);
}

screenshake_bust_thru_prep() {
  level notify("stop_vehicle_shake_loop");
  screenshake(level.player.origin, 0.5, 0.8, 0.4, 2.95, 0, 0.2, 0, 10, 8, 5, 1);
}

pre_spawn_atrium_runners() {
  var_0 = array_spawn_targetname_allow_fail_setthreat_insideaware("bust_thru_runners");
  thread spawn_dog_jump_guy();
}

bust_thru_prep_dog() {
  level.player_truck notify("stop_dog_loop");
  level.player_truck maps\_anim::anim_single_solo(level.dog, "bust_thru_prep", "tag_dog");
}

bust_thru() {
  common_scripts\utility::flag_wait("kick_off_atrium_combat");
  var_0 = common_scripts\utility::getstruct("player_teleport_atrium", "targetname");
  level notify("bust_thru");
  common_scripts\utility::flag_clear("FLAG_VO_hang_on_again");
  thread mk32_badassery(level.allies[0], var_0);
  level.player_truck maps\_vehicle::vehicle_lights_off("headlightsL");
  level.player_truck maps\_vehicle::vehicle_lights_off("headlightsR");
  level.allies[0] unlink();
  level.allies[1] unlink();
  level.allies[2] unlink();
  level.dog unlink();
  level.allies[0] maps\_utility::set_force_color("o");
  level.allies[2] maps\_utility::set_force_color("r");
  common_scripts\utility::waitframe();
  var_1 = [];
  var_1[0] = level.player_truck;
  var_1[1] = level.allies[1];
  var_1[3] = level.dog_jump_guy;
  var_1[4] = level.dog;
  var_1[0].animname = "truck";
  var_1[1].animname = "keegan";
  var_1[3].animname = "enemy1";
  var_1[4].animname = "dog";
  var_0 notify("stop_loop");
  level.player_truck notify("stop_keegan_loop");
  level.player_truck notify("stop_hesh_loop");
  level.player_truck notify("stop_dog_loop");
  screenshake(level.player.origin, 18, 16, 10, 1, 0, 0.5, 256, 8, 15, 12, 1.8);
  var_0 thread maps\_anim::anim_single(var_1, "bust_thru");
  level.allies[1] maps\_utility::gun_recall();
  level.dog thread dog_wait_anim_finished();
  thread kill_after_anim(var_1[3]);
  maps\_utility::delaythread(5, maps\_utility::battlechatter_on, "allies");
  maps\_utility::delaythread(5, maps\_utility::battlechatter_on, "axis");
}

mk32_badassery(var_0, var_1) {
  common_scripts\utility::flag_wait("FLAG_atrium_ally_mk32_anim");
  var_0.animname = "merrick";
  var_0 unlink();
  var_0 notify("stop_hesh_loop");
  common_scripts\utility::waitframe();
  var_1 thread maps\_anim::anim_single_solo(var_0, "bust_thru");
  var_2 = spawn("script_model", var_0 gettagorigin("tag_inhand"));
  var_2.angles = var_0 gettagangles("tag_inhand");
  var_2 linkto(var_0, "tag_inhand");
  var_2 setModel("weapon_mk14_iw6");
  var_2 thread unlink_gun_on_flag("FLAG_mk32_detach");
  var_3 = common_scripts\utility::getstruct("gren1pos_tossalt", "targetname");
  var_4 = common_scripts\utility::getstruct("gren2pos_tossalt", "targetname");
  var_5 = common_scripts\utility::getstruct("gren3pos_tossalt", "targetname");
  var_6 = common_scripts\utility::getstruct("gren2pos", "targetname");
  var_7 = common_scripts\utility::getstruct("gren1pos", "targetname");
  var_8 = common_scripts\utility::getstruct("gren2posalt", "targetname");
  var_9 = common_scripts\utility::getstruct("gren1pos_tossalt", "targetname");
  var_10 = common_scripts\utility::getstruct("gren2pos_tossalt", "targetname");
  var_11 = common_scripts\utility::getstruct("gren3pos_tossalt", "targetname");
  var_12 = common_scripts\utility::getstruct("gren2posalt", "targetname");
  thread gren_explosion_sphere(var_6, 1.1);
  thread gren_explosion_sphere(var_7, 0.1);
  level.rpgfx = "rpg_geotrail8";
  level.trailwait = 0.05;
  thread grenades_merrick(var_2);
  common_scripts\utility::flag_wait("FLAG_mk32_shot1");
  thread track_gren(var_3, var_2, var_9, 0);
  common_scripts\utility::flag_wait("FLAG_mk32_shot2");
  thread track_gren(var_4, var_2, var_10, 0.5);
  common_scripts\utility::flag_wait("FLAG_mk32_shot3");
  thread track_gren(var_12, var_2, var_12, 1.0);
  common_scripts\utility::flag_wait("FLAG_mk32_shot4");
  thread track_gren(var_5, var_2, var_11, 1.5);
}

grenades_merrick(var_0) {
  var_1 = gettime();

  for(;;) {
    var_2 = gettime() - var_1;

    if(!common_scripts\utility::flag("FLAG_mk32_shot1") && var_2 >= 500)
      common_scripts\utility::flag_set("FLAG_mk32_shot1");

    if(!common_scripts\utility::flag("FLAG_mk32_shot2") && var_2 >= 800)
      common_scripts\utility::flag_set("FLAG_mk32_shot2");

    if(!common_scripts\utility::flag("FLAG_mk32_atrium_detonate") && var_2 >= 2200) {
      common_scripts\utility::flag_set("FLAG_mk32_atrium_detonate");
      break;
    }

    wait 0.05;
  }
}

unlink_gun_on_flag(var_0) {
  common_scripts\utility::flag_wait(var_0);
  self unlink();
}

track_gren(var_0, var_1, var_2, var_3) {
  level.mygren = 0.1;
  var_4 = var_1 gettagorigin("tag_flash");
  var_5 = magicbullet("mk32_dud_rocket", var_4, var_2.origin);
  var_6 = var_5 common_scripts\utility::spawn_tag_origin();
  var_6 linkto(var_5);
  thread common_scripts\utility::play_sound_in_space("weap_mk32_fire_npc_special", var_2.origin);
  playFXOnTag(common_scripts\utility::getfx("rpg_geotrail4"), var_5, "tag_origin");
  thread gren_explosion_sphere(var_0, var_3);

  if(level.trailwait > 0)
    wait(level.trailwait);

  var_7 = playFXOnTag(level._effect[level.rpgfx], var_5, "tag_fx");
}

gren_explosion_sphere(var_0, var_1) {
  common_scripts\utility::flag_wait("FLAG_mk32_atrium_detonate");
  wait(var_1);
  magicgrenademanual("fraggrenade", var_0.origin, (0, 0, 0), 0);
  physicsexplosionsphere(var_0.origin, 150, 140, 65);
}

spawn_dog_jump_guy() {
  var_0 = getent("enemy1_bust_thru", "targetname");
  level.dog_jump_guy = var_0 maps\_utility::spawn_ai(1);
  level.dog_jump_guy setcontents(0);
  level.dog_jump_guy.nocorpsedelete = 1;
  level.dog_jump_guy.ignoreme = 1;
  level.dog_jump_guy.health = 1;
  level.dog_jump_guy.no_pain_sound = 1;
  level.dog_jump_guy.diequietly = 1;
  level.dog_jump_guy.ignoreall = 1;
  level.dog_jump_guy.dontevershoot = 1;
}

wall_chunks_show() {
  var_0 = getent("bust_thru_brushes", "targetname");
  var_1 = getEntArray("bust_thru_models", "targetname");
  var_2 = getent("security_gate_crash_pieces2", "targetname");
  var_2 delete();
  var_0 show();

  foreach(var_4 in var_1)
  var_4 show();

  var_6 = getent("bust_wall_clip", "targetname");
  var_6 solid();
  var_6 show();
}

wall_chunks_hide() {
  var_0 = getent("bust_thru_brushes", "targetname");
  var_1 = getEntArray("bust_thru_models", "targetname");
  var_0 hide();

  foreach(var_3 in var_1)
  var_3 hide();

  var_5 = getent("bust_wall_clip", "targetname");
  var_5 notsolid();
  var_5 hide();
}

combat_vo() {
  level endon("atrium_done");

  while(!common_scripts\utility::flag("FLAG_atrium_done")) {
    wait(randomintrange(9, 13));
    level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_hurrybeforemoreguys");
    wait(randomintrange(9, 13));
    level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_keepfiring");
    wait(randomintrange(9, 13));
    level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_gottareachajax");
    wait(randomintrange(9, 13));
    level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_covertocover");
    wait(randomintrange(9, 13));
    level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_pushandclear");
    wait(randomintrange(9, 13));
    level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_dontgetpinneddown");
  }
}

start_atrium_combat() {
  common_scripts\utility::flag_wait("kick_off_atrium_combat");
  thread atrium_wave2();
  thread combat_vo();
  var_0 = array_spawn_targetname_allow_fail_setthreat_insideaware("atrium_wave_1");
  var_1 = array_spawn_targetname_allow_fail_setthreat_insideaware("atrium_mk32_guys");

  foreach(var_3 in var_1)
  var_3.accuracy = 0.01;

  thread maps\_utility::autosave_tactical();
  maps\_utility::activate_trigger_with_targetname("TRIG_advance_allies_wave1");
  thread maps\enemyhq_code::ai_array_killcount_flag_set(var_0, int(var_0.size - 2), "FLAG_atrium_wave2");
  wait 6;
}

atrium_wave2() {
  common_scripts\utility::flag_wait("FLAG_atrium_wave2");
  thread maps\_utility::autosave_tactical();
  thread atrium_wave3();
  var_0 = array_spawn_targetname_allow_fail_setthreat_insideaware("atrium_wave_2");
  var_1 = array_spawn_targetname_allow_fail_setthreat_insideaware("atrium_wave_2_b");
  thread maps\enemyhq_code::ai_array_killcount_flag_set(var_0, int(var_0.size - 3), "FLAG_atrium_wave3");
  maps\enemyhq_code::safe_activate_triggers_with_targetname("TRIG_advance_allies_wave2", 1);
}

atrium_wave3() {
  common_scripts\utility::flag_wait("FLAG_atrium_wave3");
  thread maps\_utility::autosave_tactical();
  thread atrium_wave4();
  var_0 = array_spawn_targetname_allow_fail_setthreat_insideaware("atrium_wave_3");
  var_1 = array_spawn_targetname_allow_fail_setthreat_insideaware("atrium_wave_3_b");
  thread maps\enemyhq_code::ai_array_killcount_flag_set(var_0, int(var_0.size - 1), "FLAG_atrium_wave4");
  thread maps\enemyhq_code::retreat_from_vol_to_vol("atrium_wave2_vol_l", "atrium_wave3_vol_l");
  thread maps\enemyhq_code::retreat_from_vol_to_vol("atrium_wave2_vol_r", "atrium_wave3_vol_r");
  level.allies[0] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_keeppushingforwardtangoes");
  maps\enemyhq_code::safe_activate_triggers_with_targetname("TRIG_advance_allies_wave3", 1);
}

atrium_wave4() {
  common_scripts\utility::flag_wait("FLAG_atrium_wave4");
  level.allies[0] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_layitonthem");
  thread maps\_utility::autosave_tactical();
  thread atrium_final_stand();
  var_0 = array_spawn_targetname_allow_fail_setthreat_insideaware("atrium_wave_4");
  wait 1;
  thread maps\enemyhq_code::ai_array_killcount_flag_set(var_0, var_0.size, "FLAG_atrium_wave6");
  wait 0.5;
  maps\enemyhq_code::safe_activate_triggers_with_targetname("TRIG_advance_allies_wave4", 1);
  thread maps\enemyhq_code::retreat_from_vol_to_vol("atrium_wave3_vol_r", "atrium_wave4_vol_r");
}

atrium_final_stand() {
  common_scripts\utility::flag_wait("FLAG_atrium_wave6");
  level.allies[0] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_almosttothetarget");
  maps\enemyhq_code::safe_activate_triggers_with_targetname("TRIG_advance_allies_wave6", 1);
  thread maps\enemyhq_code::retreat_from_vol_to_vol("atrium_wave3_vol_l", "atrium_wave5_vol_l");
  thread maps\enemyhq_code::retreat_from_vol_to_vol("atrium_wave4_vol_r", "atrium_wave5_vol_r");
  thread check_atrium_done();
  var_0 = getaiarray("axis");
  thread maps\enemyhq_code::ai_array_killcount_flag_set(var_0, int(var_0.size - 3), "FLAG_ai_final_stand");
  common_scripts\utility::flag_wait("FLAG_ai_final_stand");
  thread maps\enemyhq_code::retreat_from_vol_to_vol("atrium_wave5_vol_r", "atrium_wave5_vol_l");
}

check_atrium_done() {
  var_0 = getaiarray("axis");
  thread maps\enemyhq_code::ai_array_killcount_flag_set(var_0, int(var_0.size), "FLAG_atrium_done", 30);
  thread atrium_done(var_0);
}

atrium_done(var_0) {
  common_scripts\utility::flag_wait("FLAG_atrium_done");
  level notify("atrium_done");
  thread maps\enemyhq_code::retreat_from_vol_to_vol("atrium_wave5_vol_l", "atrium_stair_vol");
  level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_moveajaxwontlast");
  common_scripts\utility::flag_set("atrium_done");
  level.allies[0] maps\_utility::set_force_color("r");
  level.allies[2] maps\_utility::set_force_color("o");
  thread triggers_on_fingers_vo();
  maps\enemyhq_code::safe_activate_trigger_with_targetname("TRIG_atrium_done");

  foreach(var_2 in level.allies)
  var_2.ignoresuppression = 0;
}

triggers_on_fingers_vo() {
  common_scripts\utility::flag_wait("FLAG_vo_triggersonfingers");
  level.allies[0] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_bishopshouldbeup");
}

dog_wait_anim_finished() {
  var_0 = getnode("dog_here_post_bust_thru", "targetname");
  self waittillmatch("single anim", "end");
  self setgoalnode(var_0);
  common_scripts\utility::flag_wait("FLAG_player_exit_truck");

  if(!isDefined(self.script_forcecolor))
    maps\_utility::enable_ai_color();

  maps\enemyhq_code::unlock_player_control();
}

at_end_anim_freeze_frame(var_0) {
  self waittillmatch("single anim", "end");
  var_0 thread maps\_anim::anim_last_frame_solo(self, "bust_thru");
}

kill_after_anim(var_0) {
  common_scripts\utility::flag_wait("FLAG_kill_dog_kill_guy");

  if(!isalive(var_0)) {
    return;
  }
  var_0.allowdeath = 1;
  var_0.a.nodeath = 1;
  var_0 maps\_utility::set_battlechatter(0);
  var_0 kill();
}

reach_goal_die() {
  self waittill("goal");

  if(!maps\enemyhq_code::raven_player_can_see_ai(self))
    self delete();
}

ai_group_killcount_flag_set(var_0, var_1, var_2) {
  while(maps\_utility::get_ai_group_sentient_count(var_0) > var_1)
    wait 0.05;

  common_scripts\utility::flag_set(var_2);
}

check_triggers_flagset(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1)
  var_3 thread set_flag_in_trigger();
}

set_flag_in_trigger() {
  self waittill("trigger");

  if(isDefined(self.script_flag_set))
    common_scripts\utility::flag_set(self.script_flag_set);
}

check_trigger_flagset(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 waittill("trigger");

  if(isDefined(var_1.script_flag_set))
    common_scripts\utility::flag_set(var_1.script_flag_set);
}

array_spawn_targetname_allow_fail_setthreat_insideaware(var_0) {
  var_1 = maps\enemyhq_code::array_spawn_targetname_allow_fail(var_0);

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      if(isDefined(var_3.script_parameters) && var_3.script_parameters == "atrium_ai_starting_inside") {
        var_3 setthreatbiasgroup("axis_inside");
        var_3.inside = 1;
        continue;
      }

      var_3 setthreatbiasgroup("axis_outside");
      var_3.inside = 0;
    }
  }

  return var_1;
}

watch_inside_trigger() {
  var_0 = getent("atrium_inside_border", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_1)) {
      if(var_1.team == "axis") {
        if(var_1 getthreatbiasgroup() != "axis_inside") {
          var_1 setthreatbiasgroup("axis_inside");
          var_1.inside = 1;
          pokebiasgroups();
        }

        continue;
      }

      if(var_1 == level.player) {
        if(level.atrium_player_outside == 1)
          setplayerinside();

        continue;
      }

      if(var_1 getthreatbiasgroup() != "ally_inside") {
        var_1 setthreatbiasgroup("ally_inside");
        pokebiasgroups();
      }
    }
  }
}

watch_outside_trigger() {
  var_0 = getent("atrium_outside_border", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_1)) {
      if(var_1.team == "axis") {
        if(var_1 getthreatbiasgroup() != "axis_outside") {
          var_1 setthreatbiasgroup("axis_outside");
          var_1.inside = 0;
          pokebiasgroups();
        }

        continue;
      }

      if(var_1 == level.player) {
        if(level.atrium_player_outside == 0)
          setplayeroutside();

        continue;
      }

      if(var_1 getthreatbiasgroup() != "ally_outside") {
        var_1 setthreatbiasgroup("ally_outside");
        pokebiasgroups();
      }
    }
  }
}

handle_ally_threatbiasgroup() {
  createthreatbiasgroup("ally_outside");
  createthreatbiasgroup("ally_inside");
  createthreatbiasgroup("axis_inside");
  createthreatbiasgroup("axis_outside");
  setthreatbias("ally_outside", "axis_outside", 200);
  setthreatbias("ally_outside", "axis_inside", 75);
  setthreatbias("ally_inside", "axis_inside", 200);
  setthreatbias("ally_inside", "axis_outside", 75);
  level.player setthreatbiasgroup("ally_inside");
  level.atrium_player_inside = 1;
  level.atrium_player_outside = 0;
  level.allies[0] setthreatbiasgroup("ally_inside");
  level.allies[2] setthreatbiasgroup("ally_outside");
  level.allies[1] setthreatbiasgroup("ally_inside");
  pokebiasgroups();
}

pokebiasgroups() {
  setthreatbias("ally_outside", "axis_outside", 200);
  setthreatbias("ally_outside", "axis_inside", 30);
  setthreatbias("ally_inside", "axis_inside", 200);
  setthreatbias("ally_inside", "axis_outside", 30);
}

setplayerinside() {
  level.player setthreatbiasgroup("ally_inside");
  level.atrium_player_outside = 0;
  common_scripts\utility::flag_clear("FLAG_player_outside");
  pokebiasgroups();
}

setplayeroutside() {
  common_scripts\utility::flag_set("FLAG_player_outside");
  level.player setthreatbiasgroup("ally_outside");
  level.atrium_player_outside = 1;
  pokebiasgroups();
}