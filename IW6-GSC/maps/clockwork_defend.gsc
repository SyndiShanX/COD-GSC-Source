/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\clockwork_defend.gsc
*****************************************************/

clockwork_defend_pre_load() {
  precacheitem("smoke_grenade_american");
  common_scripts\utility::flag_init("defend_finished");
  common_scripts\utility::flag_init("defend_combat_finished");
  common_scripts\utility::flag_init("ally1_on_podium");
  common_scripts\utility::flag_init("ally2_on_podium");
  common_scripts\utility::flag_init("player_on_podium");
  common_scripts\utility::flag_init("defend_player_drop_bag");
  common_scripts\utility::flag_init("def_in_riot_gear");
  common_scripts\utility::flag_init("def_wave1_done");
  common_scripts\utility::flag_init("def_wave2_done");
  common_scripts\utility::flag_init("def_wave3_done");
  common_scripts\utility::flag_init("def_scientist_intro_complete");
  common_scripts\utility::flag_init("defend_start_waves");
  common_scripts\utility::flag_init("defend_used_duffel");
  common_scripts\utility::flag_init("defend_used_sentry");
  common_scripts\utility::flag_init("defend_used_mines");
  common_scripts\utility::flag_init("defend_sentry_placed");
  common_scripts\utility::flag_init("get_turret");
  common_scripts\utility::flag_init("get_shockwave");
  common_scripts\utility::flag_init("get_teargas");
  common_scripts\utility::flag_init("get_proximity_mine");
  common_scripts\utility::flag_init("trickle_spawn_all");
  common_scripts\utility::flag_init("disallow_interrupt_baker");
  common_scripts\utility::flag_init("defend_baker_in_position");
  common_scripts\utility::flag_init("defend_smoke_thrown");
  common_scripts\utility::flag_init("wave2_pre_dialog");
  common_scripts\utility::flag_init("player_out_of_defend");
  common_scripts\utility::flag_init("cypher_in_position");
  common_scripts\utility::flag_init("cypher_baker_interaction_done");
  common_scripts\utility::flag_init("defend_timeto_hide_player_bag");
  common_scripts\utility::flag_init("defend_allies_smoke_thrown");
  common_scripts\utility::flag_init("other_allies_post_vault");
  common_scripts\utility::flag_init("cypher_defend_close_door");
  common_scripts\utility::flag_init("defend_timeout");
  common_scripts\utility::flag_init("ally_died");
  maps\_utility::add_hint_string("teargas_hint", &"CLOCKWORK_PROMPT_TEARGAS", ::handle_bag_hints);
  maps\_utility::add_hint_string("shockwave_hint", &"CLOCKWORK_PROMPT_SHOCKWAVE", ::handle_bag_hints);
  maps\_utility::add_hint_string("mine_hint", &"CLOCKWORK_PROMPT_MINE", ::handle_bag_hints);
}

setup_defend_blowdoors1() {
  level.override_check = 1;
  level.timer_override_check = level.override_check;
  setup_defend_plat("defend_plat");
}

setup_defend_blowdoors2() {
  level.override_check = 2;
  level.timer_override_check = level.override_check;
  setup_defend_plat("defend_plat");
}

setup_defend_fire_blocker() {
  level.override_check = 3;
  level.timer_override_check = level.override_check;
  setup_defend_plat("defend_plat");
}

setup_defend_plat(var_0) {
  maps\clockwork_code::dog_setup();
  level.start_time = gettime();
  maps\clockwork_code::setup_player();
  level.start_point = "defend_plat";
  maps\clockwork_code::spawn_allies();
  maps\_utility::vision_set_changes("clockwork_indoor", 0);
  common_scripts\utility::flag_set("interior_cqb_finished");
  common_scripts\utility::flag_set("cqb_guys7");
  common_scripts\utility::flag_set("to_cqb");
  set_blow_doors_vis(1);
  defend_setup_common();
  defend_begin_common();
  common_scripts\utility::array_thread(level.allies, ::handle_ally_bag_vis);
  common_scripts\utility::flag_set("defend_player_drop_bag");
  maps\_utility::delaythread(1, ::defend_platform);
  thread maps\clockwork_audio::checkpoint_defend();

  if(level.woof)
    thread handle_dog_defend();
}

begin_defend_plat() {
  maps\_utility::battlechatter_on("axis");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::set_team_bcvoice("allies", "taskforce");
  common_scripts\utility::flag_wait("defend_finished");
}

begin_defend_blowdoors1() {
  maps\_utility::battlechatter_on("axis");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::set_team_bcvoice("allies", "taskforce");
  common_scripts\utility::flag_wait("defend_finished");
}

begin_defend_blowdoors2() {
  maps\_utility::battlechatter_on("axis");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::set_team_bcvoice("allies", "taskforce");
  common_scripts\utility::flag_wait("defend_finished");
}

begin_defend_fire_blocker() {
  maps\_utility::battlechatter_on("axis");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::set_team_bcvoice("allies", "taskforce");
  common_scripts\utility::flag_wait("defend_finished");
  common_scripts\utility::flag_set("defend_flasher_struct");
}

debug_lookflag() {
  thread flag_state("defend_looking_south");
  thread flag_state("defend_looking_north");
  thread flag_state("defend_looking_south_doors");
  thread flag_state("defend_looking_north_doors");
}

flag_state(var_0) {
  for(;;) {
    common_scripts\utility::flag_wait(var_0);
    common_scripts\utility::flag_waitopen(var_0);
  }
}

setup_defend() {
  maps\clockwork_code::dog_setup();
  level.start_point = "defend";
  maps\clockwork_code::setup_player();
  maps\clockwork_code::spawn_allies();
  defend_setup_common();
  maps\_utility::vision_set_changes("clockwork_indoor", 0);
  common_scripts\utility::flag_set("interior_cqb_finished");
  common_scripts\utility::flag_set("cqb_guys7");
  common_scripts\utility::flag_set("to_cqb");
  thread maps\clockwork_interior::fight_objective();
  thread maps\clockwork_audio::checkpoint_defend();
}

defend_setup_common() {
  level.allies[0].animname = "baker";
  level.allies[1].animname = "keegan";
  level.allies[2].animname = "cypher";

  foreach(var_1 in level.allies) {
    if(var_1.animname == "keegan")
      var_1 maps\_utility::forceuseweapon("cz805bren+reflex_sp", "primary");

    if(var_1.animname == "baker")
      var_1 maps\_utility::forceuseweapon("cz805bren+reflex_sp", "primary");

    if(var_1.animname == "cypher")
      var_1 maps\_utility::forceuseweapon("mts255", "primary");
  }
}

defend_begin_common() {
  level.custom_sentry_position_func = ::updatesentrypositionclockwork;
  setup_blockers();
  thread handle_platform_blockers();
  maps\clockwork_code::safe_disable_trigger_with_targetname("defend_pickup_backups_trigger");
  thread maps\clockwork_fx::turn_effects_on("defend_flasher_struct", "fx/lights/lights_strobe_red_dist_max_small");
  level.moveup_doublespeed = 0;
  set_bags_invisible();
  level.allies[0].animname = "baker";
  level.allies[1].animname = "keegan";
  level.allies[2].animname = "cypher";
  set_bag_objective_visibility(0);
  thread maps\clockwork_audio::defend_start();
  thread defend_end();
  disable_bag_trigger("defend_duffle_bag_turret_trigger");
  disable_bag_trigger("defend_duffle_bag_proximity_trigger");
  disable_bag_trigger("defend_duffle_bag_teargas_trigger");
  disable_bag_trigger("defend_duffle_bag_shockwave_trigger");
  level.defend_save_safe = 1;
  thread listen_for_use_turret_duffle_bag();
  thread listen_for_use_shockwave_duffle_bag();
  thread listen_for_use_teargas_duffle_bag();
  thread listen_for_use_proximity_duffle_bag();
  thread handle_cypher_backups();
  thread handle_animated_duffelbags();
}

begin_defend() {
  level endon("defend_player_fail_leaving");
  level endon("ally_died");

  if(level.woof)
    thread handle_dog_defend();

  defend_begin_common();

  if(common_scripts\utility::flag("defend_player_fail_leaving") || common_scripts\utility::flag("ally_died")) {
    return;
  }
  thread maps\_utility::autosave_by_name("defend_start");
  common_scripts\utility::array_thread(level.allies, maps\_utility::cqb_walk, "off");
  common_scripts\utility::array_thread(level.allies, maps\_utility::set_moveplaybackrate, 1, 0.5);
  set_blow_doors_vis(0);
  maps\_utility::stop_exploder(850);
  maps\_utility::battlechatter_on("axis");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::set_team_bcvoice("allies", "taskforce");
  thread defend_intro();
  level.player setactionslot(1, "");
  common_scripts\utility::flag_wait("defend_finished");
}

disable_bag_trigger(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1.force_off = 1;
  var_1 common_scripts\utility::trigger_off();
}

enable_bag_trigger(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1.force_off = 0;
  var_1 common_scripts\utility::trigger_on();
}

watch_player_wake_scientists() {
  level endon("defend_shoot_air");

  while(!common_scripts\utility::flag("defend_player_fail_leaving"))
    wait 0.05;

  level.player waittill("weapon_fired");
  level.player_woke_scientists = 1;
  level notify("defend_shoot_air");
}

defend_intro() {
  thread fail_mission_leave_area();
  common_scripts\utility::flag_wait("defend_vo_intro");
  thread watch_player_wake_scientists();
  thread spawn_scientists();
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_timecheck");
  wait 0.2;
  maps\_utility::music_play("mus_clock_defend_prep");
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_diz_onschedule");
  common_scripts\utility::flag_wait("defend_room_entered");

  if(!isDefined(level.player_woke_scientists)) {
    var_0 = common_scripts\utility::getstruct("defend_animate_to_me", "targetname");
    var_1 = spawn("script_origin", var_0.origin + (0, 0, 12));
    var_1.angles = var_0.angles;
    var_1 maps\_anim::anim_reach_solo(level.allies[0], "baker_fire_air");
    var_1 thread maps\_anim::anim_single_solo(level.allies[0], "baker_fire_air");
  }

  wait 1.5;
  level notify("defend_shoot_air");
  maps\clockwork_code::safe_activate_trigger_with_targetname("dog_to_platform");
  level.allies[0] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_outnow");
  wait 2;
  level.allies[0] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_preppingfortransfer");
  common_scripts\utility::array_thread(level.allies, ::handle_ally_bag_vis);
  wait 1;
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_commandplatform");
  level notify("begin_defend_radio_chatter");
  thread nag_podium();
  thread set_bag_objective_visibility(1);
  common_scripts\utility::flag_wait("player_on_podium");
  common_scripts\utility::flag_set("Obj_datacenter_complete");
  var_2 = getent("defend_player_drop_bag_trigger", "targetname");
  var_3 = getent("defend_duffle_bag_turret", "targetname");
  maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(var_2, var_3);
  common_scripts\utility::flag_set("defend_player_drop_bag");
  thread delay_show_blow_doors();
  thread watch_placed_sentry();
  thread maps\clockwork_audio::command_platform_bag_player();
  set_bag_objective_visibility(0);
  defend_platform();
}

delay_show_blow_doors() {
  wait 2.5;
  set_blow_doors_vis(1);
}

defend_platform() {
  level endon("defend_player_fail_leaving");
  level endon("ally_died");
  level.missileglassshattervel = getdvarfloat("missileGlassShatterVel");
  setsaveddvar("missileGlassShatterVel", 0);
  player_drop_bag();

  if(common_scripts\utility::flag("defend_player_fail_leaving") || common_scripts\utility::flag("ally_died")) {
    return;
  }
  thread maps\_utility::autosave_by_name("defend_bag_dropoff");
  var_0 = getent("defend_player_drop_bag_trigger", "targetname");

  if(isDefined(var_0))
    var_0 common_scripts\utility::trigger_off();

  common_scripts\utility::flag_wait("defend_baker_in_position");
  maps\_utility::stop_exploder(200);
  var_1 = [];
  var_1[0] = 40;
  var_1[1] = 15;
  var_1[2] = 12;

  if(!isDefined(level.override_check)) {
    thread trickle_spawn(70, "defend_wave1", var_1);
    thread trickle_spawn(70, "defend_wave1_uppers", var_1);
    var_2 = [];
    var_2[0] = 40;
    var_2[1] = 17;
    var_2[2] = 6;
    thread trickle_spawn(70, "defend_wave1_quick", var_2);

    if(!isDefined(level.defend_quick)) {
      wait 3;
      var_3 = 0;
      var_4 = 0;

      if(!common_scripts\utility::flag("defend_used_sentry")) {
        level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_sentryturretfrombags");
        var_3 = 1;
      }

      if(!common_scripts\utility::flag("defend_used_mines") && !var_3) {
        level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_minesfrombag");
        var_4 = 1;
      }

      level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_theyllbefollowingus");
      var_5 = common_scripts\utility::getstruct("defend_player_drop_bag_location_mod", "targetname");
      var_5 notify("baker_stop_table_loop");
      level.allies[0] maps\_utility::disable_ai_color();
      level.allies[0].fixednode = 0;
      level.allies[0].goalraidus = 64;
      level.allies[1] maps\_utility::disable_ai_color();
      level.allies[1].fixednode = 0;
      level.allies[1].goalraidus = 64;
      level.allies[1] allowedstances("crouch", "prone");
      level.allies[0] allowedstances("crouch", "prone");
      var_6 = getent("def_ally_middle", "targetname");
      var_7 = getent("defend_ally_split", "targetname");
      level.allies[0] setgoalvolumeauto(var_6);
      level.allies[1] setgoalvolumeauto(var_7);
      wait 5;

      if(!common_scripts\utility::flag("defend_used_mines") && !var_4) {
        level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_minesfrombag");
        level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_theyllbefollowingus");
      }

      level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_30secsdefenses");
    }
  } else {
    var_5 = common_scripts\utility::getstruct("defend_player_drop_bag_location_mod", "targetname");
    var_5 notify("baker_stop_table_loop");
    level.allies[0] maps\_utility::disable_ai_color();
    level.allies[1] maps\_utility::disable_ai_color();
    wait 0.3;
    level.allies[1] allowedstances("crouch", "prone");
    level.allies[0] allowedstances("crouch", "prone");
    var_6 = getent("def_ally_middle", "targetname");
    var_7 = getent("defend_ally_split", "targetname");
    level.allies[0] setgoalvolumeauto(var_6);
    level.allies[1] setgoalvolumeauto(var_7);
    common_scripts\utility::flag_set("def_wave1_done");
  }

  maps\_utility::delaythread(14, maps\clockwork_audio::defend_combat);
  thread defend_start();
  var_8 = 8;
  thread temp_music_thread_defend_prep_2(var_8);
  wait(var_8);
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_heshdidyoufind");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_hsh_ohyeahitsall");
}

temp_music_thread_defend_prep_2(var_0) {
  wait(var_0 - 4.5);
  thread maps\_utility::music_play("mus_clock_defend_prep_2", 4);
}

fail_mission_leave_area() {
  common_scripts\utility::flag_wait_any("def_player_north", "player_on_podium", "def_player_south");
  thread watch_player_leave_area();
  common_scripts\utility::flag_wait("defend_player_fail_leaving");
  setdvar("ui_deadquote", &"CLOCKWORK_QUOTE_LEFT_TEAM");
  maps\_utility::missionfailedwrapper();
}

watch_player_leave_area() {
  level endon("elevator_open");
  common_scripts\utility::flag_clear("defend_player_fail_leaving");
  level endon("defend_player_fail_leaving");
  var_0 = gettime();
  var_1 = [];
  var_1[0] = "clockwork_bkr_getbackhererook";
  var_1[1] = "clockwork_bkr_rookwhereyagoing";
  var_2 = 0;

  for(;;) {
    common_scripts\utility::flag_wait("defend_player_warn_leaving");

    while(common_scripts\utility::flag("defend_player_warn_leaving")) {
      if(var_0 < gettime()) {
        maps\clockwork_code::radio_dialog_add_and_go(var_1[var_2]);
        var_2++;

        if(var_2 >= var_1.size)
          var_2 = 0;

        var_0 = gettime() + 10000;
      }

      common_scripts\utility::waitframe();
    }
  }
}

player_drop_bag() {
  var_0 = getent("defend_duffle_bag_turret", "targetname");
  var_1 = maps\_utility::spawn_anim_model("player_rig");
  var_2 = maps\_utility::spawn_anim_model("player_bag");
  var_3 = common_scripts\utility::getstruct("defend_player_drop_bag_location_mod", "targetname");
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_4.origin = var_3.origin;
  var_4.angles = var_3.angles;
  var_1 linkto(var_4, "tag_origin", (0, 0, 0), (0, 0, 0));
  level.player_bag.animname = "player_bag";
  var_4 maps\_anim::anim_first_frame_solo(var_1, "defend_bagdrop");
  var_5 = [];
  var_5[0] = var_1;
  var_5[1] = var_2;
  var_1 hide();
  var_2 hide();
  level.player setstance("stand");
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player playerlinktoblend(var_1, "tag_player", 0.3);
  level.player disableweapons();
  var_4 thread maps\_anim::anim_single(var_5, "defend_bagdrop");
  wait 0.3;
  var_1 show();
  var_2 show();
  common_scripts\utility::flag_wait("defend_timeto_hide_player_bag");
  var_4 maps\_anim::anim_first_frame_solo(level.player_bag, "defend_world_player_bag");
  var_5[0] waittillmatch("single anim", "end");
  level.player unlink();
  var_1 delete();
  level.player enableweapons();
  level.player enableoffhandweapons();
  level.player allowcrouch(1);
  level.player allowprone(1);
  var_2 delete();
  set_bag_visibility("defend_duffle_bag_turret", level.player_bag);

  if(!common_scripts\utility::flag("defend_used_sentry")) {
    level.sentry_obj = spawn("script_model", var_0 gettagorigin("tag_sentry"));
    level.sentry_obj setModel("weapon_sentry_smg_collapsed_small_obj");
    thread cleanup_sentry_hud_outline();
    level.sentry_obj.angles = var_0 gettagangles("tag_sentry");
    enable_bag_trigger("defend_duffle_bag_turret_trigger");
  }

  common_scripts\utility::flag_wait("cypher_baker_interaction_done");
}

cleanup_sentry_hud_outline() {
  common_scripts\utility::flag_wait("defend_combat_finished");

  if(isDefined(level.sentry_obj))
    level.sentry_obj setModel("weapon_sentry_smg_collapsed_small_obj");
}

handle_ally_bag_vis() {
  var_0 = common_scripts\utility::getstruct("defend_player_drop_bag_location_mod", "targetname");
  self pushplayer(1);
  var_0 maps\_anim::anim_reach_solo(self, "defend_bagdrop");
  common_scripts\utility::flag_wait("player_on_podium");

  if(self.animname == "keegan")
    thread maps\clockwork_audio::command_platform_bag_keegan();

  if(self.animname == "cypher")
    thread maps\clockwork_audio::command_platform_bag_cypher();

  if(self.animname == "baker")
    thread maps\clockwork_audio::command_platform_bag_baker();

  var_0 maps\_anim::anim_single_solo(self, "defend_bagdrop");

  if(self.animname == "keegan") {
    level.allies[1] maps\_utility::enable_ai_color();
    maps\clockwork_code::safe_activate_trigger_with_targetname("def_keegan_during_defend");
    level.allies[1] pushplayer(0);
  }
}

bag_vis_callback(var_0) {
  if(var_0.animname == "cypher")
    var_0 thread cipher_vo();

  var_1 = common_scripts\utility::getstruct("defend_player_drop_bag_location_mod", "targetname");
  var_2 = undefined;

  switch (var_0.animname) {
    case "cypher":
      var_1 maps\_anim::anim_first_frame_solo(level.bags[2], "defend_world_cypher_bag");
      level.allies[2] maps\_utility::set_ignoreall(1);
      level.allies[2] maps\_utility::set_ignoreme(1);
      level.allies[2] pushplayer(1);
      var_2 = level.bags[2];
      break;
    case "keegan":
      var_1 maps\_anim::anim_first_frame_solo(level.bags[1], "defend_world_keegan_bag");
      var_2 = level.bags[1];
      break;
    case "baker":
      var_1 maps\_anim::anim_first_frame_solo(level.bags[0], "defend_world_baker_bag");
      var_2 = level.bags[0];
      break;
    default:
      common_scripts\utility::flag_set("defend_timeto_hide_player_bag");
      return;
  }

  var_0 thread set_bag_visibility(var_0.bag_name, var_2);
  wait 0.1;
  var_0 maps\clockwork_code::hide_dufflebag();
  var_0 waittill("single anim", var_3);
  var_1 = common_scripts\utility::getstruct("defend_player_drop_bag_location_mod", "targetname");

  switch (var_0.animname) {
    case "cypher":
      thread cipher_podium();
      break;
    case "keegan":
      var_1 waittillmatch("single anim", "end");
      level.allies[1] maps\_utility::enable_ai_color();
      maps\clockwork_code::safe_activate_trigger_with_targetname("def_keegan_during_defend");
      level.allies[1] pushplayer(0);
      break;
    case "baker":
      common_scripts\utility::flag_set("defend_baker_in_position");
      var_1 thread maps\_anim::anim_loop_solo(level.allies[0], "table_stand_idle", "baker_stop_table_loop");
      wait 3;
      level.allies[0] pushplayer(0);
      break;
  }
}

watch_placed_sentry() {
  common_scripts\utility::flag_wait("defend_used_sentry");
  wait 0.25;
  level.player waittill("sentry_placement_finished");
  common_scripts\utility::flag_set("defend_sentry_placed");
  thread handle_autoturret_chatter();
}

nag_podium() {
  thread nag_bag();
  wait 5;

  for(;;) {
    wait 9;

    if(common_scripts\utility::flag("player_on_podium")) {
      break;
    }

    level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_getuphere");
    wait 14;

    if(common_scripts\utility::flag("player_on_podium")) {
      break;
    }

    level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_commandplatform");
    wait 5;
  }
}

nag_bag() {
  common_scripts\utility::flag_wait("player_on_podium");

  while(!common_scripts\utility::flag("defend_player_drop_bag")) {
    level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_tableoverhere");
    wait 9;
  }
}

defend_start() {
  thread place_defenses();
  thread handle_defend_waves();
}

cipher_vo() {
  common_scripts\utility::flag_waitopen("disallow_interrupt_baker");
  level.allies[2] pushplayer(1);
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_computerbank");
  wait 0.5;
  level.allies[2] maps\clockwork_code::char_dialog_add_and_go("clockwork_cyr_need2minutes");
  wait 0.5;
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_defensiveposition");
  var_0 = maps\_utility::obj("defendcypher");
  objective_add(var_0, "active", &"CLOCKWORK_OBJ_DEFEND");
  objective_current(var_0);
  wait 1;
  common_scripts\utility::flag_wait("cypher_in_position");
  common_scripts\utility::flag_set("cypher_baker_interaction_done");
  wait 4;
  thread download_timer();
  common_scripts\utility::flag_wait("defend_combat_finished");
  maps\_utility::objective_complete(var_0);
}

cipher_podium() {
  var_0 = common_scripts\utility::getstruct("defend_player_drop_bag_location_mod", "targetname");
  var_0 thread maps\_anim::anim_loop_solo(level.allies[2], "laptop_sit_idle_calm", "stop_hacking");
  common_scripts\utility::flag_set("cypher_in_position");
  level.allies[2] pushplayer(0);

  if(isDefined(level.spiral_blocker)) {
    level.spiral_blocker solid();
    level.spiral_blocker disconnectpaths();
  }
}

place_defenses() {
  thread listen_for_use_multi_turret();
}

handle_defend_saves(var_0) {
  level endon("defend_combat_finished");
  level endon("defend_player_fail_leaving");
  level endon("ally_died");
  var_1 = 1;
  var_2 = 20000;

  for(;;) {
    var_3 = gettime() - var_0;

    if(var_3 < var_2)
      wait((var_2 - var_3) / 1000);
    else
      wait 1;

    if(level.defend_save_safe && !common_scripts\utility::flag("game_saving")) {
      if(!isDefined(level.curautosave))
        var_4 = 1;
      else
        var_4 = level.curautosave;

      var_5 = "defend_ongoing" + var_1;
      var_6 = gettime();

      if(common_scripts\utility::flag("defend_player_fail_leaving")) {
        return;
      }
      thread maps\_utility::autosave_by_name(var_5);
      var_1++;
      common_scripts\utility::flag_wait("game_saving");
      common_scripts\utility::flag_waitopen("game_saving");
      level notify("stop_watch_abandon_save");
      var_7 = gettime();

      if(level.curautosave > var_4)
        var_0 = var_7;
    }
  }
}

handle_defend_waves() {
  level endon("defend_player_fail_leaving");
  level.allies[2] endon("death");
  level endon("ally_died");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::battlechatter_on("axis");
  thread monitor_enemies_in_pods();

  if(!isDefined(level.override_check))
    thread defend_wave_1();
  else
    thread handle_backfill();

  thread open_vault_door();
  common_scripts\utility::flag_wait_either("def_wave1_done", "defend_combat_finished");

  if(common_scripts\utility::flag("defend_player_fail_leaving") || common_scripts\utility::flag("ally_died")) {
    return;
  }
  wait 0.1;
  common_scripts\utility::flag_wait_either("def_wave3_done", "defend_combat_finished");

  if(common_scripts\utility::flag("defend_player_fail_leaving")) {
    return;
  }
  thread maps\_utility::autosave_by_name("defend_wave3");
  wait 0.1;
  common_scripts\utility::flag_wait("defend_combat_finished");
  setsaveddvar("missileGlassShatterVel", level.missileglassshattervel);
}

defend_start_player_shield() {
  level.player enableinvulnerability();
  wait 15;
  level.player disableinvulnerability();
}

defend_wave_1() {
  level endon("defend_combat_finished");
  wait 27;
  level.player thread maps\clockwork_code::radio_dialog_add_and_go("clockwork_mrk_tangoesincomingdownthe");
  wait 2;
  level.allies[0] maps\_utility::disable_ai_color();
  level.allies[1] maps\_utility::disable_ai_color();
  wait 0.3;
  var_0 = getent("def_ally_middle", "targetname");
  level.allies[1] maps\_utility::set_goal_pos(level.allies[1].origin);
  var_1 = getent("defend_ally_split", "targetname");
  level.allies[0] setgoalvolumeauto(var_0);
  level.allies[1] setgoalvolumeauto(var_1);
  thread defend_start_player_shield();
  wait 1;
  common_scripts\utility::flag_set("trickle_spawn_all");
  wait 8;
  thread handle_backfill();
  thread wave1_radio_chatter();
  var_2 = maps\_utility::get_ai_group_ai("defend_group");
  maps\_utility::waittill_dead_or_dying(var_2, var_2.size - 3);
  level.allies[0] notify("stop_defend_movement");
  level.allies[1] notify("stop_defend_movement");
  common_scripts\utility::flag_set("def_wave1_done");
}

handle_accuracy() {
  var_0 = self.baseaccuracy;
  maps\_utility::set_baseaccuracy(50);
  maps\_utility::set_ignoreme(1);
  self.grenadeawareness = 0;
  self.ignoreexplosionevents = 1;
  self.ignorerandombulletdamage = 1;
  self.ignoresuppression = 1;
  self.disablebulletwhizbyreaction = 1;
  maps\_utility::disable_pain();
  common_scripts\utility::flag_wait("defend_allies_smoke_thrown");
  self.grenadeawareness = 1;
  self.ignoreexplosionevents = 0;
  self.ignorerandombulletdamage = 0;
  self.ignoresuppression = 0;
  self.disablebulletwhizbyreaction = 0;
  maps\_utility::enable_pain();
  maps\_utility::set_baseaccuracy(var_0);
  maps\_utility::set_ignoreme(0);
  maps\clockwork_code::safe_activate_trigger_with_targetname("def_allies_after_smoke");
}

setup_ai_for_end() {
  var_0 = getaiarray("axis");
  var_1 = getent("def_ground_middle_mid", "targetname");
  common_scripts\utility::array_call(var_0, ::setgoalvolumeauto, var_1);
  common_scripts\utility::array_thread(var_0, maps\_utility::set_baseaccuracy, 0.01);

  foreach(var_3 in var_0)
  var_3.health = 1;

  common_scripts\utility::array_thread(level.allies, ::handle_accuracy);
  var_5 = getent("defend_upper_area", "targetname");
  var_6 = var_5 maps\_utility::get_ai_touching_volume("axis");
  common_scripts\utility::array_thread(var_6, maps\_utility::set_ignoreall, 1);
  wait 8;

  foreach(var_3 in var_6) {
    if(isDefined(var_3) && isalive(var_3))
      var_3 maps\_utility::set_ignoreall(0);
  }
}

defend_end() {
  level.allies[2] endon("death");
  common_scripts\utility::flag_wait("defend_combat_finished");
  neutralize_turret();
  level.allies[1] allowedstances("crouch", "prone", "stand");
  level.allies[0] allowedstances("crouch", "prone", "stand");
  common_scripts\utility::array_thread(level.allies, maps\_utility::enable_ai_color);
  thread setup_ai_for_end();
  var_0 = common_scripts\utility::getstruct("defend_player_drop_bag_location_mod", "targetname");
  var_0 notify("stop_hacking");
  waittillframeend;
  var_1 = common_scripts\utility::getstruct("defend_player_drop_bag_location_mod", "targetname");
  var_1 thread maps\_anim::anim_single_solo(level.allies[2], "laptop_stand");
  wait 1;
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_datasecure");
  wait 2;
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_diz_makingthecall");
  wait 2;
  thread defend_do_smoke();
  common_scripts\utility::flag_wait("defend_allies_smoke_thrown");
  common_scripts\utility::flag_set("defend_finished");
  neutralize_turret();
  wait 4;
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_throughheregogo");
  thread vault_nag();
  common_scripts\utility::flag_wait("defend_vault_room");
  handle_defend_vault();
}

vault_nag() {
  level endon("defend_vault_room");

  if(common_scripts\utility::flag("defend_vault_room")) {
    return;
  }
  wait 5;
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_oby_backdoorisopen");
  wait 5;
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_move");
}

defend_exit_objective() {
  var_0 = maps\_utility::obj("defendexit");
  var_1 = common_scripts\utility::getstruct("defend_exit_obj", "targetname");
  objective_add(var_0, "active", &"CLOCKWORK_OBJ_DEFEND_ESCAPE");
  objective_current(var_0);
  objective_position(var_0, var_1.origin);
  common_scripts\utility::flag_wait("defend_vault_room");
  common_scripts\utility::flag_wait("inpos_player_elevator");
}

watch_smoke() {
  level endon("defend_player_left_area");
  level endon("got_smoke");

  for(;;) {
    level.player waittill("grenade_fire", var_0, var_1);

    if(common_scripts\utility::string_starts_with(var_1, "smoke_")) {
      common_scripts\utility::flag_set("defend_smoke_thrown");
      break;
    }
  }
}

waittill_ready_to_do_smoke() {
  level.allies[2] endon("death");
  common_scripts\utility::flag_wait("defend_combat_finished");
  level.allies[2] common_scripts\utility::waittill_notify_or_timeout("goal", 10);
}

defend_do_smoke() {
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_coverourexit");
  level.player takeweapon("teargas_grenade");
  level.player setoffhandsecondaryclass("smoke");
  level.player giveweapon("smoke_grenade_american");
  common_scripts\utility::array_thread(level.allies, maps\_utility::disable_pain);
  common_scripts\utility::array_thread(level.allies, maps\_utility::set_ignoresuppression, 1);
  level.allies[0] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_popsomesmoke");
  thread watch_smoke();
  waittill_ready_to_do_smoke();
  common_scripts\utility::flag_set("defend_smoke_thrown");

  if(common_scripts\utility::flag("defend_player_fail_leaving") || common_scripts\utility::flag("ally_died")) {
    return;
  }
  thread watch_ally_throw_end_smoke(level.allies[2], "defend_smoke_onexit", 1);
  level.player forceusehintoff();
  level notify("got_smoke");
  wait 2;
  var_0 = common_scripts\utility::getstructarray("defend_smoke", "targetname");
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(isDefined(level.ps3) && level.ps3 == 1) {
      var_1++;

      if(var_1 % 2)
        continue;
    }

    magicgrenade("smoke_grenade_american", var_3.origin + (0, 0, 50), var_3.origin, randomfloatrange(0.1, 1));
  }

  thread freshen_smoke(var_0);
  thread defend_exit_objective();
  wait 5;
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs4_smaokegrenades", 1, "defend_vault_room");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs2_thermlstolab", 2, "defend_vault_room");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs1_affirmative", 3, "defend_vault_room");
}

freshen_smoke(var_0) {
  var_1 = 10;
  level endon("defend_player_left_area");

  for(;;) {
    wait(var_1);
    var_2 = 0;

    foreach(var_4 in var_0) {
      if(isDefined(level.ps3) && level.ps3 == 1) {
        var_2++;

        if(var_2 % 2)
          continue;
      }

      magicgrenade("smoke_grenade_american", var_4.origin + (0, 0, 50), var_4.origin, randomfloatrange(0.1, 1));
    }
  }
}

neutralize_turret() {
  if(isDefined(level.defend_sentry)) {
    foreach(var_1 in level.defend_sentry) {
      if(isDefined(var_1)) {
        wait 0.05;
        var_2 = undefined;

        if(isDefined(var_1.carrier)) {
          var_2 = var_1.carrier canplayerplacesentry();
          var_1 common_scripts\_sentry::sentry_place_mode_reset();
        }

        if(isDefined(var_1.badplace_name))
          var_1 common_scripts\_sentry::sentry_badplace_delete();

        var_1 setCanDamage(0);
        var_1.ignoreme = 1;
        var_1 common_scripts\_sentry::sentrypoweroff();
        var_1 makeunusable();
        var_1 setcontents(0);

        if(isDefined(var_2) && !var_2["result"]) {
          var_1 notify("deleted");
          wait 0.05;
          var_1 delete();
        }
      }
    }
  }

  var_4 = getEntArray("defend_disable_on_finish", "script_noteworthy");

  foreach(var_6 in var_4)
  var_6 common_scripts\utility::trigger_off();
}

handle_defend_vault() {
  var_0 = getent("entrance_tunnel_door", "targetname");
  var_0 rotateyaw(210, 0.1);
}

open_vault_door() {
  var_0 = common_scripts\utility::getstruct("defend_vault_door_pos", "targetname");
  var_1 = getent("defend_exit_vault_door", "targetname");
  var_1.animname = "vault_door";
  var_1 maps\_utility::assign_animtree();
  var_0 thread maps\_anim::anim_first_frame_solo(var_1, "defend_open");
  var_2 = getent("defend_exit_vault_door_block", "targetname");
  var_2 linkto(var_1);
  level waittill("defend_open_door");
  thread maps\clockwork_audio::defend_door_open();
  var_0 maps\_anim::anim_single_solo(var_1, "defend_open");
  var_2 connectpaths();
  waittill_allies_exit();
  var_2 disconnectpaths();
  thread maps\clockwork_audio::defend_door_close();
  var_0 thread maps\_anim::anim_single_solo(var_1, "defend_close");
  wait 11;

  if(!common_scripts\utility::flag("player_out_of_defend")) {
    setdvar("ui_deadquote", &"CLOCKWORK_QUOTE_SEPARATED");
    maps\_utility::missionfailedwrapper();
  } else {
    var_3 = maps\_utility::obj("defendexit");
    maps\_utility::objective_complete(var_3);
    var_4 = maps\_utility::obj("exitfac");
    objective_add(var_4, "active", &"CLOCKWORK_EXIT");
    objective_current(var_4);
  }

  common_scripts\utility::array_thread(level.allies, maps\_utility::enable_pain);
  common_scripts\utility::array_thread(level.allies, maps\_utility::set_ignoresuppression, 0);
  common_scripts\utility::flag_wait("door_close");
  var_2 connectpaths();
}

watch_ally_throw_end_smoke(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2)
    var_0 maps\_utility::disable_ai_color();

  if(isDefined(var_2) && var_2) {
    common_scripts\utility::flag_wait_either("ally_throw_smoke", "chaos_moving_to_elevator");
    var_0 maps\_utility::disable_ai_color();
  }

  var_0.grenadeammo = 1;
  var_0.grenadeweapon = "smoke_grenade_american";
  var_0.grenade_roll_end_struct = var_1;
  var_0 maps\_anim::anim_single_solo(var_0, "grenade_throw_exit");

  if(isDefined(var_2) && var_2) {
    var_0 maps\_utility::disable_ai_color();
    common_scripts\utility::flag_wait("other_allies_post_vault");
    var_3 = common_scripts\utility::getstruct("defend_vault_door_pos", "targetname");
    var_3 maps\_anim::anim_reach_solo(var_0, "defend_close_door");
    var_3 maps\_anim::anim_single_solo(var_0, "defend_close_door");
    var_0 maps\_utility::enable_ai_color();
    common_scripts\utility::flag_set("cypher_defend_close_door");
  }
}

grenade_tossed(var_0) {
  var_1 = 2;

  if(var_0.animname == "cypher")
    var_1 = 0.5;

  var_2 = common_scripts\utility::getstruct(var_0.grenade_roll_end_struct, "targetname");
  var_3 = var_0 magicgrenade(var_0 gettagorigin("tag_weapon_left"), var_2.origin, var_1);

  if(!isDefined(var_3)) {
    var_2 = common_scripts\utility::getstruct(var_0.grenade_roll_end_struct + "2", "targetname");

    if(isDefined(var_2))
      var_3 = var_0 magicgrenade(var_0 gettagorigin("tag_weapon_left"), var_2.origin, var_1);
  }

  var_4 = [];
  var_4[0] = var_2;
  thread freshen_smoke(var_4);
}

waittill_allies_exit() {
  var_0 = getent("exit_defend_room_trigger", "targetname");
  var_1 = 0;

  while(var_1 < 3) {
    var_0 waittill("trigger", var_2);

    for(var_3 = 0; var_3 < level.allies.size; var_3++) {
      var_4 = level.allies[var_3];

      if(var_2 == var_4 && !isDefined(var_2.left_defend)) {
        var_2.left_defend = 1;
        var_1++;

        if(var_1 == 2)
          common_scripts\utility::flag_set("other_allies_post_vault");
      }
    }
  }

  common_scripts\utility::flag_set("allies_finished_defend_anims");
  var_0 delete();
}

update_file_download() {
  level endon("defend_combat_finished");
  level.hudtimerindex = 20;
  level.timer = maps\_hud_util::get_countdown_hud(0, 120, undefined, 1);
  level.timer.alignx = "right";
  level.timer setpulsefx(30, 900000, 700);
  level.timer.label = "File: ";
  var_0 = 0;
  var_1 = [];
  var_1[var_1.size] = "contacts.bkp";
  var_1[var_1.size] = "zork.exe";
  var_1[var_1.size] = "evo.zip";
  var_1[var_1.size] = "passwd.sys";
  var_1[var_1.size] = "mail.box";
  var_1[var_1.size] = "kerosene.ogg";
  var_1[var_1.size] = "harlequin.prj";
  var_1[var_1.size] = "rog.txt";
  var_1[var_1.size] = "odin.bak";
  var_1[var_1.size] = "gloaming.ogg";
  var_1[var_1.size] = "bluprnt.zip";
  var_1[var_1.size] = "odin.plan";
  var_2 = [];
  var_2[var_2.size] = ".txt";
  var_2[var_2.size] = ".bak";
  var_2[var_2.size] = ".arch";
  var_2[var_2.size] = ".plan";
  var_2[var_2.size] = ".sys";
  var_2[var_2.size] = ".bak";
  var_2[var_2.size] = ".ogg";
  var_2[var_2.size] = ".log";
  var_2[var_2.size] = ".vis";
  var_2[var_2.size] = ".com";
  var_2[var_2.size] = ".rar";
  var_2[var_2.size] = ".arj";
  var_2[var_2.size] = ".tar";
  var_2[var_2.size] = ".prn";
  var_2[var_2.size] = ".ch3";
  var_2[var_2.size] = ".fngr";
  var_3 = [];
  var_3[var_3.size] = "b";
  var_3[var_3.size] = "ch";
  var_3[var_3.size] = "d";
  var_3[var_3.size] = "ten";
  var_3[var_3.size] = "fl";
  var_3[var_3.size] = "gr";
  var_3[var_3.size] = "th";
  var_3[var_3.size] = "ph";
  var_3[var_3.size] = "nk";
  var_3[var_3.size] = "ck";
  var_3[var_3.size] = "tr";
  var_3[var_3.size] = "m";
  var_3[var_3.size] = "n";
  var_3[var_3.size] = "st";
  var_3[var_3.size] = "p";
  var_3[var_3.size] = "sn";
  var_3[var_3.size] = "rt";
  var_3[var_3.size] = "t";
  var_3[var_3.size] = "at";
  var_3[var_3.size] = "un";
  var_3[var_3.size] = "v";
  var_3[var_3.size] = "w";
  var_3[var_3.size] = "sh";
  var_3[var_3.size] = "sl";
  var_3[var_3.size] = "nd";
  var_4 = [];
  var_4[var_4.size] = "a";
  var_4[var_4.size] = "ee";
  var_4[var_4.size] = "o";
  var_4[var_4.size] = "ou";
  var_4[var_4.size] = "i";
  var_4[var_4.size] = "u";
  var_4[var_4.size] = "_";
  var_4[var_4.size] = "ai";

  for(;;) {
    if(var_0 < var_1.size && randomint(100) > 96) {
      level.timer settext(var_1[var_0]);
      var_0++;
      wait(randomfloatrange(2, 6));
    } else {
      var_5 = randomintrange(3, 5);
      var_6 = "";

      for(var_7 = 0; var_7 < var_5; var_7++) {
        if(!(var_7 % 2)) {
          var_6 = var_6 + var_3[randomintrange(0, var_3.size)];
          continue;
        }

        var_6 = var_6 + var_4[randomintrange(0, var_4.size)];
      }

      var_6 = var_6 + var_2[randomintrange(0, var_2.size)];
      level.timer settext(var_6);
    }

    wait(randomfloatrange(0.05, 0.5));
  }
}

download_timer() {
  level.allies[2] endon("death");
  var_0 = 9;
  var_1 = 150;
  var_1 = var_1 + 40;
  var_1 = var_1 + 15;
  var_2 = 0;

  if(var_2 != 0)
    var_1 = var_2;
  else if(isDefined(level.timer_override_check)) {
    if(level.timer_override_check == 3)
      var_1 = 45;
    else
      var_1 = var_1 - 40 * level.timer_override_check;
  }

  common_scripts\utility::flag_wait("defend_timeto_hide_player_bag");
  level.download_timer = var_1;
  level notify("download_timer_started");
  thread update_file_download();
  level.start_time = gettime();
  level.download_time = var_1;
  thread download_progress_bar(level.start_time, var_1 * 1000);
  level thread maps\_utility::notify_delay("defend_open_door", var_1 - var_0);
  wait(var_1);
  level.timer destroy();
  level.timer = undefined;
  common_scripts\utility::flag_set("defend_combat_finished");
  level notify("stop_callout");
  level.allies[0] notify("stop_defend_movement");
  level.allies[0] maps\_utility::enable_ai_color();
  level.allies[1] maps\_utility::enable_ai_color();
  level.allies[1] notify("stop_defend_movement");
  level.allies[2] maps\_utility::enable_ai_color();
}

download_progress_bar(var_0, var_1) {
  var_2 = maps\_hud_util::createclientprogressbar(level.player, -60);
  var_2 maps\_hud_util::setpoint("MIDDLERIGHT", undefined, 0, -60);
  var_2.foreground = 1;
  var_2.bar.foreground = 1;

  while(gettime() - var_0 <= var_1) {
    var_2 maps\_hud_util::updatebar((gettime() - var_0) / var_1);
    wait 0.05;
  }

  var_2.bar destroy();
  var_2 destroy();
}

handle_backfill() {
  watch_backfill();
  var_0 = maps\_utility::get_ai_group_ai("defend_backfill");
  common_scripts\utility::array_call(var_0, ::delete);
}

watch_backfill() {
  level endon("defend_player_left_area");
  var_0 = getnodearray("defend_disable_stair_nodes", "targetname");
  common_scripts\utility::array_call(var_0, ::disconnectnode);
  var_1 = gettime();
  var_2 = [];
  var_2[0] = 30;
  var_2[1] = 25;
  var_2[2] = 22;
  var_3 = 3;
  var_4 = [];
  var_4[0] = 10;
  var_4[1] = 14;
  var_4[2] = 17;
  var_4[3] = 20;
  var_4[4] = 16;
  var_4[5] = 16;
  var_4[6] = 23;
  var_5 = [];
  var_5[0] = var_1 + 25000;
  var_5[var_5.size] = var_5[var_5.size - 1] + 35000;
  var_5[var_5.size] = var_5[var_5.size - 1] + 45000;
  var_5[var_5.size] = var_5[var_5.size - 1] + 40000;
  var_5[var_5.size] = var_5[var_5.size - 1] + 30000;
  var_5[var_5.size] = var_5[var_5.size - 1] + 990000;
  var_5[var_5.size] = var_5[var_5.size - 1] + 990000;
  var_6 = 0;
  var_7 = getEntArray("defend_atrium_backfill", "targetname");

  for(;;) {
    var_8 = maps\_utility::get_ai_group_sentient_count("defend_backfill");

    if(common_scripts\utility::flag("trickle_spawn_all"))
      var_8 = var_8 + maps\_utility::get_ai_group_sentient_count("defend_group");

    if(var_8 < var_4[var_6]) {
      var_9 = randomint(var_7.size);

      if(common_scripts\utility::flag("defend_combat_finished"))
        var_10 = getent("def_ground_middle_mid", "targetname");
      else
        var_10 = getent(var_7[var_9].target, "targetname");

      var_11 = undefined;
      var_12 = 4;

      if(isDefined(var_10.script_parameters))
        var_12 = int(var_10.script_parameters);

      var_13 = var_10 maps\_utility::get_ai_touching_volume("axis");

      if(var_13.size < var_12)
        var_11 = var_7[var_9] maps\_utility::spawn_ai(1);

      if(isDefined(var_11)) {
        if(common_scripts\utility::flag("defend_combat_finished"))
          var_11 maps\_utility::set_baseaccuracy(0.2);
        else
          var_11 thread monitor_guy_moveup(var_2);
      }
    }

    if(gettime() > var_5[var_6] || isDefined(level.override_check)) {
      var_6++;

      if(var_6 >= var_4.size) {
        var_6 = var_4.size - 1;
        var_5[var_6] = gettime() + 990000;
      }

      for(var_14 = 0; var_14 < var_2.size; var_14++)
        var_2[var_14] = var_2[var_14] * 0.85;

      if(isDefined(level.override_check)) {
        if(level.override_check >= 2) {
          thread blowdoors("door_blow_north");
          maps\clockwork_code::safe_delete_trigger_with_targetname("defend_looking_north_trigger");
        }

        if(level.override_check >= 3) {
          thread blowdoors("door_blow_south");
          maps\clockwork_code::safe_delete_trigger_with_targetname("defend_looking_south_trigger");
        }

        var_6 = level.override_check;
        level.override_check = undefined;
      }

      if(var_6 == 1 || var_6 == 2) {
        maps\_utility::delaythread(10, common_scripts\utility::flag_set, "defend_timeout");
        var_15 = common_scripts\utility::flag_wait_any_return("defend_timeout", "defend_looking_south_doors", "defend_looking_north_doors");

        if(var_15 == "defend_timeout") {
          var_16 = getent("defend_looking_north_trigger", "targetname");

          if(isDefined(var_16))
            var_15 = "defend_looking_north_doors";
          else
            var_15 = "defend_looking_south_doors";
        }

        var_17 = "door_blow_north";

        if(var_15 == "defend_looking_south_doors") {
          var_17 = "door_blow_south";
          maps\clockwork_code::safe_delete_trigger_with_targetname("defend_looking_south_trigger");
          var_13 = getEntArray("defend_south_backfill", "targetname");
          level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_theyvebreachedthedoors");
        } else {
          maps\clockwork_code::safe_delete_trigger_with_targetname("defend_looking_north_trigger");
          level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_theyrecominginthrough");
          var_13 = getEntArray("defend_north_backfill", "targetname");
        }

        thread blowdoors(var_17);
        var_7 = common_scripts\utility::array_combine(var_7, var_13);
      }

      if(var_6 == 3) {
        level notify("blow_fire_blocker");

        if(isDefined(level.spiral_blocker)) {
          level.spiral_blocker connectpaths();
          level.spiral_blocker notsolid();
        }

        level waittill("fire_blocker_success");
        common_scripts\utility::array_call(var_0, ::connectnode);

        if(level.fire_blocker_blown == 0)
          var_7 = getEntArray("defend_south_pressure", "targetname");
        else
          var_7 = getEntArray("defend_north_pressure", "targetname");
      } else
        level.moveup_doublespeed = 1;
    }

    if(var_8 >= var_4[var_6]) {
      wait 5;
      continue;
    }

    wait 1;
  }
}

set_blow_doors_vis(var_0) {
  var_1 = getEntArray("door_blow_north", "targetname");
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("door_blow_south", "targetname"));
  var_2 = getent("blowdoors_playerclip_north", "script_noteworthy");
  var_3 = getent("blowdoors_playerclip_south", "script_noteworthy");

  if(var_0) {
    common_scripts\utility::array_thread(var_1, maps\_utility::show_solid);
    var_2 solid();
    var_2 common_scripts\utility::delaycall(5, ::disconnectpaths);
    var_3 solid();
    var_3 common_scripts\utility::delaycall(5, ::disconnectpaths);
  } else {
    common_scripts\utility::array_thread(var_1, maps\_utility::hide_notsolid);
    var_2 notsolid();
    var_2 connectpaths();
    var_3 notsolid();
    var_3 connectpaths();
  }
}

blowdoors(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.oldcontents))
      var_3.oldcontents = undefined;

    var_3 maps\_utility::hide_notsolid();
  }

  if(issubstr(var_0, "north")) {
    var_5 = getent("blowdoors_playerclip_north", "script_noteworthy");
    var_5 notsolid();
    var_5 connectpaths();
  } else {
    var_6 = getent("blowdoors_playerclip_south", "script_noteworthy");
    var_6 notsolid();
    var_6 connectpaths();
  }

  var_7 = common_scripts\utility::getstruct(var_0 + "_struct", "targetname");
  thread maps\clockwork_audio::defend_door_explosion(var_7.origin);
  magicgrenade("smoke_grenade_american", var_7.origin, var_7.origin + (0, 0, -30), 0);
  playFX(common_scripts\utility::getfx("throwbot_explode"), var_7.origin, anglesToForward(var_7.angles), anglestoup(var_7.angles));
  var_8 = [];
  var_8[0] = 45;
  var_8[1] = 10;
  var_8[2] = 10;
  var_9 = maps\clockwork_code::array_spawn_targetname_allow_fail(var_0 + "_guys", 1);
  common_scripts\utility::array_thread(var_9, ::monitor_guy_moveup, var_8);
}

trickle_spawn(var_0, var_1, var_2, var_3) {
  level endon("defend_player_left_area");

  if(!isDefined(var_3))
    var_3 = 5;

  var_4 = getEntArray(var_1, "targetname");
  var_5 = var_4.size;
  var_6 = var_0 / var_5;
  maps\_utility::array_spawn_function(var_4, ::setup_trickle_guy, var_2);
  var_7 = 0;

  for(var_8 = []; var_7 < var_5; var_7++) {
    if(!common_scripts\utility::flag("trickle_spawn_all"))
      wait(var_6 - randomfloat(var_6) / 2);
    else
      wait(var_3 - randomfloat(var_3 / 2));

    var_9 = var_4[var_7] maps\_utility::spawn_ai(1);

    if(isDefined(var_9))
      var_8[var_8.size] = var_9;
  }
}

setup_trickle_guy(var_0) {
  self endon("death");
  common_scripts\utility::flag_wait("trickle_spawn_all");

  if(isDefined(self.script_noteworthy)) {
    var_1 = getent(self.script_noteworthy, "targetname");

    if(isDefined(var_1)) {
      self setgoalvolumeauto(var_1);
      monitor_guy_moveup(var_0);
    }
  }
}

spawn_scientists() {
  common_scripts\utility::flag_wait("defend_spawn_scientists");
  var_0 = getEntArray("defend_scientists", "targetname");
  maps\_utility::array_spawn_function(var_0, ::setup_scientist);
  maps\_utility::array_spawn_function(var_0, maps\_utility::disable_bulletwhizbyreaction);
  maps\_utility::array_spawn_function(var_0, maps\_utility::disable_pain);
  maps\_utility::array_spawn_function(var_0, maps\_utility::disable_surprise);
  maps\_utility::array_spawn_function(var_0, maps\_utility::disable_arrivals);
  maps\_utility::array_spawn_function(var_0, maps\_utility::disable_exits);
  common_scripts\utility::array_thread(var_0, ::set_scientist_talking);
  common_scripts\utility::array_thread(var_0, maps\clockwork_code::ambient_animate, 1);
  wait 0.1;
  var_1 = maps\_utility::get_ai_group_ai("defend_scientist_sprint");
  common_scripts\utility::array_thread(var_1, ::set_scientist_sprinting);
  level waittill("defend_shoot_air");
  common_scripts\utility::flag_set("moveit_scientist");
}

scientist_always_stand(var_0) {
  return "stand";
}

setup_scientist() {
  self.chooseposefunc = ::scientist_always_stand;
  self.no_dog_target = 1;
}

set_scientist_sprinting() {
  level waittill("defend_shoot_air");
  wait(randomfloatrange(0, 0.7));

  if(!isDefined(self)) {
    return;
  }
  maps\_utility::clear_run_anim();
  waittillframeend;
  var_0 = "defend_run_scientist_" + randomintrange(1, 4);
  maps\_utility::set_run_anim(var_0);

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "def_sci_1")
    maps\_utility::set_generic_idle_anim("scientist_idle");
}

set_scientist_talking() {
  maps\_utility::set_generic_idle_anim("civilian_stand_idle");
}

monitor_guy_moveup(var_0) {
  if(!isDefined(self)) {
    return;
  }
  self endon("death");
  var_1 = self getgoalvolume();
  var_2 = 0;

  if(!isDefined(var_1)) {
    return;
  }
  while(isDefined(var_1.script_noteworthy)) {
    var_3 = getent(var_1.script_noteworthy, "targetname");
    var_4 = var_0[var_2] + randomfloat(5) - 2;

    if(level.moveup_doublespeed)
      var_4 = var_4 / 2;

    var_5 = 4;

    if(isDefined(var_3.script_parameters))
      var_5 = int(var_3.script_parameters);

    for(;;) {
      wait(var_4);
      var_6 = var_3 maps\_utility::get_ai_touching_volume("axis");

      if(var_6.size < var_5) {
        break;
      }

      var_4 = 3;
    }

    if(common_scripts\utility::flag("defend_combat_finished")) {
      common_scripts\utility::flag_wait("defend_smoke_thrown");
      wait(randomfloatrange(0, 5));
    }

    var_2++;

    if(var_2 >= var_0.size)
      var_2 = var_0.size - 1;

    self setgoalvolumeauto(var_3);
    var_1 = var_3;
  }

  self allowedstances("stand");
}

monitor_enemies_in_pods() {
  thread watch_pod("def_south_has_enemy", level.allies[2]);
}

cypher_defend_self() {
  self.sidearm = "m9a1";
  level endon("defend_combat_finished");
  self endon("death");
  var_0 = common_scripts\utility::getstruct("defend_player_drop_bag_location_mod", "targetname");
  var_1 = getent("cypher_shoot_left", "targetname");
  var_2 = getent("cypher_shoot_right", "targetname");

  for(;;) {
    if(!level.defend_save_safe) {
      if(self.last_defend_time < gettime()) {
        var_3 = 1;
        var_4 = var_1 maps\_utility::get_ai_touching_volume("axis");

        if(var_4.size == 0) {
          wait 0.05;
          var_3 = 0;
          var_4 = var_2 maps\_utility::get_ai_touching_volume("axis");
        }

        if(var_4.size > 0 && (!isDefined(var_4[0].dogcypher_claimed) || var_4[0].dogcypher_claimed == self)) {
          var_4[0].dogcypher_claimed = self;
          self.last_defend_time = gettime() + 5000 * randomfloatrange(1, 2);
          var_0 notify("stop_hacking");
          waittillframeend;

          if(var_3)
            var_0 thread maps\_anim::anim_single_solo(self, "defend_shoot_left_cypher");
          else
            var_0 thread maps\_anim::anim_single_solo(self, "defend_shoot_right_cypher");

          self waittillmatch("single anim", "fire");

          if(isalive(var_4[0]))
            magicbullet("m9a1", self gettagorigin("tag_flash"), var_4[0] gettagorigin("j_head"));

          self waittillmatch("single anim", "end");
          var_0 thread maps\_anim::anim_loop_solo(self, "laptop_sit_idle_calm", "stop_hacking");
        }
      }

      wait 0.1;
      continue;
    }

    wait 1;
  }
}

watch_pod(var_0, var_1) {
  watch_pod_blocker(var_0, var_1);
  common_scripts\utility::flag_set("can_save");
}

watch_pod_blocker(var_0, var_1) {
  var_2 = [];
  var_3 = [];
  var_3[var_2.size] = 2;
  var_2[var_2.size] = "clockwork_cyr_underattack";
  var_3[var_2.size] = 2;
  var_2[var_2.size] = "clockwork_cyr_tangoesonme";
  var_3[var_2.size] = 0;
  var_2[var_2.size] = "clockwork_bkr_takingfire";
  var_3[var_2.size] = 0;
  var_2[var_2.size] = "clockwork_bkr_getbackthere";
  var_3[var_2.size] = -1;
  var_2[var_2.size] = "clockwork_dz_gotcompany";
  var_3[var_2.size] = -1;
  var_2[var_2.size] = "clockwork_dz_protectcypher";
  var_3[var_2.size] = -1;
  var_2[var_2.size] = "clockwork_dz_commandplatform";
  var_4 = 0;
  var_5 = 0;
  var_1.last_defend_time = gettime();
  var_1 thread cypher_defend_self();
  var_6 = getent("defend_last_stand", "targetname");

  for(;;) {
    common_scripts\utility::flag_wait(var_0);

    if(common_scripts\utility::flag("defend_combat_finished")) {
      var_1.allowdeath = 0;

      if(!isDefined(var_1.magic_bullet_shield))
        var_1 maps\_utility::magic_bullet_shield();

      return;
    }

    level.defend_save_safe = 0;
    level.allies[0] setgoalvolumeauto(var_6);
    level.allies[1] setgoalvolumeauto(var_6);

    if(gettime() > var_5 + 10000) {
      var_7 = randomintrange(0, var_2.size);

      if(var_3[var_7] == -1)
        maps\clockwork_code::radio_dialog_add_and_go(var_2[var_7]);
      else
        level.allies[var_3[var_7]] maps\clockwork_code::char_dialog_add_and_go(var_2[var_7]);
    }

    var_8 = gettime();
    var_1.ignoreme = 0;

    while(common_scripts\utility::flag(var_0)) {
      if(!isDefined(var_1) || !isalive(var_1)) {
        common_scripts\utility::flag_set("ally_died");
        var_9 = &"CLOCKWORK_QUOTE_CYPHER_SHOT";
        setdvar("ui_deadquote", var_9);
        maps\_utility::missionfailedwrapper();
        return;
      }

      if(!common_scripts\utility::flag("def_player_mid")) {
        common_scripts\utility::flag_clear("can_save");
        var_1.allowdeath = 1;

        if(isDefined(var_1.magic_bullet_shield))
          var_1 maps\_utility::stop_magic_bullet_shield();
      } else {
        var_1.allowdeath = 0;

        if(!isDefined(var_1.magic_bullet_shield))
          var_1 maps\_utility::magic_bullet_shield();
      }

      if(common_scripts\utility::flag("defend_combat_finished")) {
        var_1.allowdeath = 0;

        if(!isDefined(var_1.magic_bullet_shield))
          var_1 maps\_utility::magic_bullet_shield();

        return;
      }

      wait 0.05;
    }

    common_scripts\utility::flag_set("can_save");
    var_6 = getent("def_ally_middle", "targetname");
    var_10 = getent("defend_ally_split", "targetname");
    level.allies[0] setgoalvolumeauto(var_6);
    level.allies[1] setgoalvolumeauto(var_10);
    var_1.allowdeath = 0;

    if(!isDefined(var_1.magic_bullet_shield))
      var_1 maps\_utility::magic_bullet_shield();

    level.defend_save_safe = 1;
    var_5 = var_8;
    var_1.ignoreme = 1;
  }
}

set_bag_objective_visibility(var_0) {
  level notify("set_bag_objective_visibility");
  level endon("set_bag_objective_visibility");
  var_1 = getent("defend_duffle_obj", "targetname");
  var_2 = getent("defend_player_drop_bag_trigger", "targetname");

  if(var_0) {
    var_1 show();
    var_2.force_off = 0;

    for(;;) {
      if(level.player getstance() == "stand")
        var_2.force_off = 0;
      else if(level.player getstance() != "stand")
        var_2.force_off = 1;

      common_scripts\utility::waitframe();
    }
  } else {
    var_1 hide();
    var_2 common_scripts\utility::trigger_off();
  }
}

set_bags_invisible() {
  var_0 = [];
  var_0[var_0.size] = "defend_duffle_bag_proximity";
  var_0[var_0.size] = "defend_duffle_bag_shockwave";
  var_0[var_0.size] = "defend_duffle_bag_teargas";
  var_0[var_0.size] = "defend_duffle_bag_turret";
  level.allies[0].bag_name = var_0[0];
  level.allies[1].bag_name = var_0[1];
  level.allies[2].bag_name = var_0[2];

  foreach(var_2 in var_0) {
    var_3 = getent(var_2, "targetname");
    var_4 = var_2 + "_trigger";
    var_5 = getent(var_4, "targetname");
    var_3 hide();
    var_5 common_scripts\utility::trigger_off();
  }

  level.teargas_bag = getEntArray("defend_duffel_teargas1", "targetname");
  common_scripts\utility::array_call(level.teargas_bag, ::hide);
  common_scripts\utility::array_call(level.teargas_bag, ::notsolid);
}

handle_animated_duffelbags() {
  maps\clockwork_code::init_animated_dufflebags();
}

set_bag_visibility(var_0, var_1) {
  var_2 = [];

  if(var_0 == "all") {
    var_2[var_2.size] = "defend_duffle_bag_teargas";
    var_2[var_2.size] = "defend_duffle_bag_shockwave";
    var_2[var_2.size] = "defend_duffle_bag_turret";
    var_2[var_2.size] = "defend_duffle_bag_proximity";
  } else
    var_2[var_2.size] = var_0;

  foreach(var_4 in var_2) {
    var_5 = var_4 + "_trigger";
    var_6 = getent(var_5, "targetname");

    if(var_2.size == 1)
      common_scripts\utility::flag_wait("defend_player_drop_bag");

    if(var_0 != "defend_duffle_bag_turret")
      enable_bag_trigger(var_5);

    if(var_4 == "defend_duffle_bag_proximity") {
      level.bettys = [];

      for(var_7 = 0; var_7 < 4; var_7++) {
        level.bettys[var_7] = spawn("script_model", var_1 gettagorigin("tag_mine_" + (var_7 + 1)));
        level.bettys[var_7] setModel("weapon_proximity_mine_small_obj");
        level.bettys[var_7].angles = var_1 gettagangles("tag_mine_" + (var_7 + 1));
      }

      level.curr_betty = 0;
      continue;
    }

    if(var_4 == "defend_duffle_bag_teargas") {
      common_scripts\utility::array_call(level.teargas_bag, ::show);
      continue;
    }

    if(var_4 == "defend_duffle_bag_shockwave") {
      level.shockwaves = [];

      for(var_7 = 0; var_7 < 2; var_7++) {
        level.shockwaves[var_7] = spawn("script_model", var_1 gettagorigin("tag_claymore_" + (var_7 + 1)));
        level.shockwaves[var_7] setModel("weapon_electric_claymore_small_obj");
        level.shockwaves[var_7].angles = var_1 gettagangles("tag_claymore_" + (var_7 + 1));
      }

      level.curr_shockwave = 0;
    }
  }
}

listen_for_use_shockwave_duffle_bag() {
  var_0 = 0;
  level.player thread watchshockwaves();
  bag_trigger_wait("defend_duffle_bag_shockwave_trigger", "defend_duffle_bag_shockwave", "get_shockwave");

  if(common_scripts\utility::flag("defend_finished")) {
    return;
  }
  thread maps\clockwork_audio::mines_grab();
  level.player giveweapon("shockwave");
  level.player switchtoweapon("shockwave");
  level.player setactionslot(4, "weapon", "shockwave");
  common_scripts\utility::flag_set("defend_used_duffel");
  common_scripts\utility::waitframe();
  common_scripts\utility::flag_clear("get_shockwave");
  maps\_utility::display_hint_timeout("shockwave_hint", 2.5);

  if(isDefined(level.shockwaves[var_0]))
    level.shockwaves[var_0] hide();

  var_0 = var_0 + 1;
  thread bag_trigger_off_if_player_has_weapon("defend_duffle_bag_shockwave_trigger", "shockwave");

  while(!common_scripts\utility::flag("defend_finished")) {
    bag_trigger_wait("defend_duffle_bag_shockwave_trigger", "defend_duffle_bag_shockwave", "get_shockwave");

    if(common_scripts\utility::flag("defend_finished")) {
      continue;
    }
    if(level.player hasweapon("shockwave")) {
      common_scripts\utility::flag_clear("get_shockwave");
      continue;
    }

    thread maps\clockwork_audio::mines_grab();
    level.player giveweapon("shockwave");
    level.player switchtoweapon("shockwave");
    level.player setactionslot(4, "weapon", "shockwave");
    common_scripts\utility::flag_set("defend_used_duffel");
    common_scripts\utility::waitframe();
    common_scripts\utility::flag_clear("get_shockwave");
    maps\_utility::display_hint_timeout("shockwave_hint", 2.5);

    if(isDefined(level.shockwaves[var_0]))
      level.shockwaves[var_0] hide();

    var_0 = var_0 + 1;

    if(var_0 >= 2) {
      var_1 = getent("defend_duffle_bag_shockwave_trigger", "targetname");
      var_1 delete();
      return;
    }
  }

  while(isDefined(level.shockwaves[var_0]) && var_0 < level.shockwaves.size) {
    level.shockwaves[var_0] delete();
    var_0 = var_0 + 1;
  }

  common_scripts\utility::flag_wait("player_out_of_defend");

  if(level.player getcurrentweapon() == "shockwave")
    level.player switchtoweaponimmediate(level.player getweaponslistprimaries()[0]);

  level.player takeweapon("shockwave");
  level.player setactionslot(4, "");
}

watchshockwaves() {
  while(!common_scripts\utility::flag("defend_finished")) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "shockwave") {
      var_0.owner = self;
      var_0 thread shockwavedetonation();
      var_0 thread playshockwaveeffects();
      wait 0.65;

      if(self getammocount("shockwave") == 0) {
        level.player takeweapon("shockwave");
        level.player setactionslot(4, "");
      }
    }
  }
}

shockwavedetonation() {
  self waittill("missile_stuck");
  var_0 = 192;

  if(isDefined(self.detonateradius))
    var_0 = self.detonateradius;

  var_1 = spawn("trigger_radius", self.origin + (0, 0, 0 - var_0), 9, var_0, var_0 * 2);
  thread shockwavedeleteondeath(var_1);
  thread shockwave_damage_monitor(var_1);

  if(!isDefined(level.shockwaves))
    level.shockwaves = [];

  level.shockwaves = common_scripts\utility::array_add(level.shockwaves, self);

  if(!maps\_utility::is_specialop() && level.shockwaves.size > 15)
    level.shockwaves[0] delete();

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(isDefined(self.owner) && isDefined(var_2) && var_2 == self.owner) {
      continue;
    }
    if(isDefined(var_2) && isplayer(var_2)) {
      continue;
    }
    if(!isDefined(var_2) || var_2 damageconetrace(self.origin, self) > 0) {
      if(isDefined(var_2))
        wait 0.4;

      var_3 = [];

      foreach(var_5 in getaiarray(common_scripts\utility::get_enemy_team(self.owner.team))) {
        if(distance2dsquared(self.origin, var_5.origin) < pow(var_0 * 2.0, 2.0) && vectordot(anglesToForward(self.angles), vectornormalize(var_5.origin - self.origin)) > 0.13397 && var_5 damageconetrace(self.origin, self) > 0) {
          var_5 thread watch_for_shockwave_hit();
          var_3[var_3.size] = var_5;
        }
      }

      self playSound("shock_charge_detonate");

      if(isDefined(self.owner))
        self detonate(self.owner);
      else
        self detonate(undefined);

      if(isDefined(self.damage_proxy)) {
        self.damage_proxy delete();
        self.damage_proxy = undefined;
      }

      wait 15;

      foreach(var_5 in var_3)
      var_5 notify("end_shockwave_watch");

      return;
    }
  }
}

shockwave_damage_monitor(var_0) {
  self endon("detonate");
  var_1 = spawn("script_model", self.origin);
  var_1.angles = self.angles;
  var_1 setModel("weapon_electric_claymore");
  var_1 hide();
  var_1 setCanDamage(1);
  var_1.maxhealth = 100000;
  var_1.health = var_1.maxhealth;
  self.damage_proxy = var_1;
  var_2 = undefined;

  for(;;) {
    var_1 waittill("damage", var_3, var_2, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(!isDefined(var_2) || !isplayer(var_2)) {
      continue;
    }
    break;
  }

  var_0 notify("trigger");
}

watch_for_shockwave_hit() {
  self endon("death");
  self endon("end_shockwave_watch");
  var_0 = gettime();
  self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

  if(gettime() - var_0 < 0.1 && var_10 == "shockwave") {
    var_0 = gettime();
    var_11 = self.allowdeath;
    self.allowdeath = 1;
    self.shockwave_pain_anim_index = randomintrange(1, 5);

    while(gettime() - var_0 < 10000 && isDefined(self) && isalive(self)) {
      self playSound("shock_charge");
      playFXOnTag(common_scripts\utility::getfx("shockwave_shock"), self, "tag_origin");
      maps\_anim::anim_generic(self, "shockwave_shock_" + self.shockwave_pain_anim_index);
    }

    if(isDefined(self) && isalive(self))
      self.allowdeath = var_11;
  }
}

playshockwaveeffects() {
  self endon("death");
  self waittill("missile_stuck");
  playFXOnTag(common_scripts\utility::getfx("claymore_laser"), self, "tag_fx");
}

shockwavedeleteondeath(var_0) {
  self waittill("death");
  level.shockwaves = maps\_utility::array_remove_nokeys(level.shockwaves, self);
  wait 0.05;

  if(isDefined(var_0))
    var_0 delete();
}

listen_for_use_multi_turret() {
  level.player notifyonplayercommand("use_multi_turret", "+actionslot 4");

  for(;;)
    level.player waittill("use_multi_turret");
}

listen_for_use_turret_duffle_bag() {
  var_0 = 0;
  thread watch_sentry_badplace();

  while(!common_scripts\utility::flag("defend_finished")) {
    bag_trigger_wait("defend_duffle_bag_turret_trigger", "defend_duffle_bag_turret", "get_turret");

    if(common_scripts\utility::flag("defend_finished")) {
      continue;
    }
    level.sentry_obj hide();
    common_scripts\utility::flag_set("defend_used_duffel");
    common_scripts\utility::flag_set("defend_used_sentry");
    var_1 = level.player common_scripts\_sentry::spawn_and_place_sentry("sentry_smg", (0, 0, 0), (0, 0, 0), 1);
    var_1 useby(level.player);

    if(!isDefined(level.defend_sentry))
      level.defend_sentry = [];

    level.defend_sentry[level.defend_sentry.size] = var_1;
    var_0++;
    common_scripts\utility::waitframe();
    common_scripts\utility::flag_clear("get_turret");

    if(var_0 >= 1) {
      var_2 = getent("defend_duffle_bag_turret_trigger", "targetname");
      var_2 delete();
      return;
    }

    level.player waittill("sentry_placement_finished");
    level.sentry_obj show();
  }
}

handle_bag_hints() {
  return 0;
}

listen_for_use_teargas_duffle_bag() {
  while(!common_scripts\utility::flag("defend_finished")) {
    bag_trigger_wait("defend_duffle_bag_teargas_trigger", "defend_duffle_bag_teargas", "get_teargas");

    if(common_scripts\utility::flag("defend_finished")) {
      return;
    }
    thread maps\clockwork_audio::teargas_grab();
    level.player takeweapon("flash_grenade");
    level.player setoffhandsecondaryclass("smoke");
    level.player giveweapon("teargas_grenade");
    common_scripts\utility::array_call(level.teargas_bag, ::hide);
    common_scripts\utility::waitframe();
    common_scripts\utility::flag_clear("get_teargas");
    common_scripts\utility::flag_set("defend_used_duffel");
    var_0 = getent("defend_duffle_bag_teargas_trigger", "targetname");
    var_0 delete();
    maps\_utility::display_hint_timeout("teargas_hint", 2.5);
    return;
  }
}

bag_trigger_wait(var_0, var_1, var_2) {
  level endon("defend_finished");
  var_3 = getent(var_0, "targetname");
  var_4 = getent(var_1, "targetname");
  maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(var_3, var_4);

  if(isDefined(var_2))
    common_scripts\utility::flag_set(var_2);
}

bag_trigger_off_if_player_has_weapon(var_0, var_1) {
  level endon("defend_finished");
  var_2 = getent(var_0, "targetname");

  while(isDefined(var_2)) {
    if(level.player hasweapon(var_1))
      var_2.force_off = 1;
    else
      var_2.force_off = 0;

    wait 0.05;
  }
}

listen_for_use_proximity_duffle_bag() {
  var_0 = 0;
  bag_trigger_wait("defend_duffle_bag_proximity_trigger", "defend_duffle_bag_proximity", "get_proximity_mine");

  if(common_scripts\utility::flag("defend_finished")) {
    return;
  }
  thread maps\clockwork_audio::mines_grab();
  level.player giveweapon("thermobaric_mine");
  level.player switchtoweapon("thermobaric_mine");
  level.player setactionslot(1, "weapon", "thermobaric_mine");
  common_scripts\utility::flag_set("defend_used_duffel");
  common_scripts\utility::flag_set("defend_used_mines");
  thread listen_for_mine_layed();
  thread player_monitor_mine_friendly_fire();
  common_scripts\utility::waitframe();
  common_scripts\utility::flag_clear("get_proximity_mine");

  if(isDefined(level.bettys[var_0]))
    level.bettys[var_0] hide();

  var_0 = var_0 + 1;
  thread bag_trigger_off_if_player_has_weapon("defend_duffle_bag_proximity_trigger", "thermobaric_mine");

  while(!common_scripts\utility::flag("defend_finished")) {
    bag_trigger_wait("defend_duffle_bag_proximity_trigger", "defend_duffle_bag_proximity", "get_proximity_mine");

    if(common_scripts\utility::flag("defend_finished")) {
      continue;
    }
    if(level.player hasweapon("thermobaric_mine")) {
      common_scripts\utility::flag_clear("get_proximity_mine");
      continue;
    }

    thread maps\clockwork_audio::mines_grab();
    level.player giveweapon("thermobaric_mine");
    level.player switchtoweapon("thermobaric_mine");
    level.player setactionslot(1, "weapon", "thermobaric_mine");
    common_scripts\utility::flag_set("defend_used_duffel");
    common_scripts\utility::flag_set("defend_used_mines");
    thread listen_for_mine_layed();
    thread player_monitor_mine_friendly_fire();
    common_scripts\utility::waitframe();
    common_scripts\utility::flag_clear("get_proximity_mine");

    if(isDefined(level.bettys[var_0]))
      level.bettys[var_0] hide();

    var_0 = var_0 + 1;

    if(var_0 >= 4) {
      var_1 = getent("defend_duffle_bag_proximity_trigger", "targetname");
      var_1 delete();
      return;
    }
  }

  while(isDefined(level.bettys[var_0]) && var_0 < level.bettys.size) {
    level.bettys[var_0] setModel("weapon_proximity_mine_small");
    var_0 = var_0 + 1;
  }

  common_scripts\utility::flag_wait("player_out_of_defend");

  if(level.player getcurrentweapon() == "thermobaric_mine")
    level.player switchtoweaponimmediate(level.player getweaponslistprimaries()[0]);

  level.player takeweapon("thermobaric_mine");
  level.player setactionslot(1, "");
  level.player notify("stop_thermobaric_mine");
}

player_monitor_mine_friendly_fire() {
  level.player endon("death");
  level notify("player_monitor_mine_friendly_fire");
  level endon("player_monitor_mine_friendly_fire");
  level.player endon("stop_thermobaric_mine");
  var_0 = getdvar("g_friendlyfireDist");
  var_1 = "timeout";

  while(level.player hasweapon("thermobaric_mine")) {
    setsaveddvar("g_friendlyfireDist", var_0);

    if(isDefined(var_1))
      level.player waittill("start_attack");

    if(level.player getcurrentweapon() != "thermobaric_mine") {
      continue;
    }
    setsaveddvar("g_friendlyfireDist", "0");
    level.player waittill("end_attack");
    var_1 = undefined;
    var_1 = level.player common_scripts\utility::waittill_notify_or_timeout_return("start_attack", 2);
  }
}

looking_at_ally() {
  var_0 = level.player;
  return var_0 islookingat(level.allies[0]) || var_0 islookingat(level.allies[1]) || var_0 islookingat(level.allies[2]);
}

watch_remove_hint() {
  level notify("watch_remove_hint");
  level endon("watch_remove_hint");
  wait 2;
  self forceusehintoff();
  self.force_hint = undefined;
}

listen_for_mine_layed() {
  level notify("listen_for_mine_laying");
  level endon("listen_for_mine_laying");
  level.mine_pickup_sound = 0;
  level.player notifyonplayercommand("start_attack", "+attack");
  level.player notifyonplayercommand("end_attack", "-attack");
  maps\_utility::display_hint_timeout("mine_hint", 2.5);

  while(level.player hasweapon("thermobaric_mine")) {
    level.player waittill("end_attack");

    if(looking_at_ally()) {
      continue;
    }
    if(level.player getcurrentweapon() == "thermobaric_mine") {
      var_0 = 0;

      while(!var_0) {
        var_1 = getEntArray("grenade", "classname");

        foreach(var_3 in var_1) {
          if(var_3.model == "weapon_proximity_mine" && !isDefined(var_3.is_setup)) {
            var_3 thread arm_mine();
            var_0 = 1;

            if(level.mine_pickup_sound < 7) {
              level.mine_pickup_sound++;
              thread maps\clockwork_audio::mines_ready_to_throw();
            }

            break;
          }
        }

        wait 0.05;
      }

      if(level.player getammocount("thermobaric_mine") == 0) {
        level.player takeweapon("thermobaric_mine");
        level.player setactionslot(1, "");
      }
    }
  }
}

arm_mine() {
  self.is_setup = 1;
  self waittill("missile_stuck");
  var_0 = bulletTrace(self.origin + (0, 0, 4), self.origin - (0, 0, 4), 0, self);
  var_1 = var_0["position"];

  if(var_0["fraction"] == 1) {
    var_1 = getgroundposition(self.origin, 12, 0, 32);
    var_0["normal"] = var_0["normal"] * -1;
  }

  var_2 = vectornormalize(var_0["normal"]);
  var_3 = vectortoangles(var_2);
  var_3 = var_3 + (90, 0, 0);
  var_4 = spawnmine(var_1, var_3);

  if(!isDefined(level.clockwork_thermobaric_mines))
    level.clockwork_thermobaric_mines = [];

  level.clockwork_thermobaric_mines[level.clockwork_thermobaric_mines.size] = var_4;
  self delete();
  wait 1;
  var_4.trigger = spawn("trigger_radius", var_4.origin, 73, 72, 12);
  var_4 thread listen_for_mine_trigger();
}

spawnmine(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = (0, randomfloat(360), 0);

  var_2 = "weapon_proximity_mine";
  var_3 = spawn("script_model", var_0);
  var_3.angles = var_1;
  var_3 setModel(var_2);
  var_3.weaponname = "thermobaric_mine";
  var_3 thread minedamagemonitor();
  return var_3;
}

minedamagemonitor() {
  self endon("mine_triggered");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_0 = undefined;

  for(;;) {
    self waittill("damage", var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isplayer(var_0) || isDefined(var_9) && var_9 == "thermobaric_mine") {
      continue;
    }
    break;
  }

  self notify("mine_destroyed");

  foreach(var_11 in getaiarray("axis")) {
    if(distancesquared(var_11.origin, self.origin) < 19600)
      var_11 thread mine_damage_increase();
  }

  playFX(common_scripts\utility::getfx("throwbot_explode"), self.origin);
  radiusdamage(self.origin, 140, 10, 1, undefined, undefined, "thermobaric_mine");
  thread common_scripts\utility::play_sound_in_space("clkw_mine_explode", self.origin);
  level.clockwork_thermobaric_mines = common_scripts\utility::array_remove(level.clockwork_thermobaric_mines, self);

  foreach(var_14 in level.clockwork_thermobaric_mines) {
    if(distancesquared(var_14.origin, self.origin) <= 19600) {
      var_14 notify("mine_triggered");
      var_14 notify("mine_destroyed");
      level.clockwork_thermobaric_mines = common_scripts\utility::array_remove(level.clockwork_thermobaric_mines, var_14);

      if(isDefined(var_14.trigger))
        var_14.trigger delete();

      if(isDefined(var_14))
        var_14 delete();
    }
  }

  if(isDefined(self.trigger))
    self.trigger delete();

  if(isDefined(self))
    self delete();
}

listen_for_mine_trigger() {
  self endon("mine_destroyed");
  self.trigger waittill("trigger", var_0);
  self notify("mine_triggered");

  if(isDefined(self.trigger))
    self.trigger delete();

  var_1 = self.origin;
  playFX(common_scripts\utility::getfx("mine_explode"), self.origin + (0, 0, 5));
  thread maps\clockwork_audio::mine_explode(var_1);
  level.clockwork_thermobaric_mines = common_scripts\utility::array_remove(level.clockwork_thermobaric_mines, self);
  var_2 = [];

  foreach(var_4 in level.clockwork_thermobaric_mines) {
    if(distancesquared(var_4.origin, self.origin) <= 129600) {
      var_4 notify("mine_triggered");
      var_4 notify("mine_destroyed");
      level.clockwork_thermobaric_mines = common_scripts\utility::array_remove(level.clockwork_thermobaric_mines, var_4);
      var_2[var_2.size] = var_4;
    }
  }

  wait 0.5;
  var_6 = getaiarray("axis");

  foreach(var_0 in var_6) {
    if(distancesquared(var_0.origin, var_1) < 32400)
      var_0 maps\_utility::flashbangstart(5);
  }

  wait 1;

  foreach(var_0 in getaiarray("axis")) {
    if(distancesquared(var_0.origin, var_1) < 129600)
      var_0 thread mine_damage_increase();
  }

  playFX(common_scripts\utility::getfx("throwbot_explode"), var_1 + (0, 0, 5));
  radiusdamage(var_1 + (0, 0, 50), 360, 50, 1, undefined, undefined, "thermobaric_mine");

  if(isDefined(self))
    self delete();

  foreach(var_4 in var_2) {
    if(isDefined(var_4.trigger))
      var_4.trigger delete();

    if(isDefined(var_4))
      var_4 delete();
  }
}

mine_damage_increase() {
  self endon("death");
  self endon("stop_mine_damage_increase");
  self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(isDefined(var_9) && var_9 == "thermobaric_mine")
    self dodamage(var_0 * 10, var_3, var_1);
}

wave1_radio_chatter() {
  wait 5;
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs2_idintruders", 1, "def_wave1_done");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs2_onserverdeck", 2, "def_wave1_done");
}

handle_autoturret_chatter() {
  level endon("defend_combat_finished");
  common_scripts\utility::flag_wait("def_wave1_done");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs4_autoturret", 1, "wave2_pre_dialog");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs4_approachcwing", 2, "wave2_pre_dialog");
}

handle_teargas_chatter() {
  level endon("defend_combat_finished");
  var_0 = getent("teargas_flush_volume", "targetname");
  var_0 waittill("teargas_exploded");
  wait 5;
  level.player maps\clockwork_code::radio_dialog_add_and_go("clockwork_rs4_teargas");
}

setup_blockers() {
  level.phys_blockers_brush[0] = getEntArray("phys_blocker_north_brush", "targetname");
  level.phys_blockers_model[0] = getEntArray("phys_blocker_north_model", "targetname");
  level.fire_blockers_brush[0] = getEntArray("fire_blocker_north_brush", "targetname");
  level.fire_blockers_hurt[0] = getEntArray("fire_blocker_north_hurt", "targetname");
  level.fire_blockers_jet[0] = common_scripts\utility::getstructarray("fire_blocker_north_jet", "targetname");
  level.fire_blockers_body[0] = common_scripts\utility::getstructarray("fire_blocker_north_body", "targetname");
  level.fire_radiusdamage[0] = common_scripts\utility::getstruct("fire_blocker_north_radiusdamage", "targetname");
  level.phys_blockers_brush[1] = getEntArray("phys_blocker_south_brush", "targetname");
  level.phys_blockers_model[1] = getEntArray("phys_blocker_south_model", "targetname");
  level.fire_blockers_brush[1] = getEntArray("fire_blocker_south_brush", "targetname");
  level.fire_blockers_hurt[1] = getEntArray("fire_blocker_south_hurt", "targetname");
  level.fire_blockers_jet[1] = common_scripts\utility::getstructarray("fire_blocker_south_jet", "targetname");
  level.fire_blockers_body[1] = common_scripts\utility::getstructarray("fire_blocker_south_body", "targetname");
  level.fire_radiusdamage[1] = common_scripts\utility::getstruct("fire_blocker_south_radiusdamage", "targetname");
  level.spiral_blocker = getent("spiral_stair_blocker", "targetname");

  if(isDefined(level.spiral_blocker)) {
    level.spiral_blocker connectpaths();
    level.spiral_blocker notsolid();
  }

  foreach(var_1 in level.phys_blockers_brush) {
    foreach(var_3 in var_1) {
      var_3 connectpaths();
      var_3 hide();
      var_3 notsolid();
    }
  }

  foreach(var_1 in level.phys_blockers_model) {
    foreach(var_8 in var_1) {
      var_8 hide();
      var_8 notsolid();
    }
  }

  foreach(var_1 in level.fire_blockers_hurt) {
    foreach(var_13 in var_1)
    var_13 common_scripts\utility::trigger_off();
  }

  foreach(var_1 in level.fire_blockers_brush) {
    foreach(var_3 in var_1) {
      var_3 connectpaths();
      var_3 hide();
      var_3 notsolid();
    }
  }
}

handle_platform_blockers() {
  level waittill("blow_fire_blocker");
  var_0 = getent("def_ally_south", "targetname");
  var_1 = getent("def_ally_north", "targetname");
  var_2 = 15;
  var_3 = gettime() + var_2 * 100;
  var_4 = -1;

  for(;;) {
    common_scripts\utility::flag_clear("defend_timeout");
    maps\_utility::delaythread(var_2 + 0.1, common_scripts\utility::flag_set, "defend_timeout");
    var_5 = common_scripts\utility::flag_wait_any_return("defend_timeout", "defend_looking_south", "defend_looking_north");
    var_6 = ispointinvolume(level.player.origin + (0, 0, 50), var_0);

    if(var_3 < gettime() || var_5 == "defend_timeout") {
      var_4 = 1;

      if(var_6)
        var_4 = 0;

      thread handle_fire_blocker(var_4);
      break;
    }

    if(var_5 == "defend_looking_south") {
      if(!var_6) {
        var_4 = 1;
        thread handle_fire_blocker(var_4);
        break;
      }
    } else if(!ispointinvolume(level.player.origin + (0, 0, 50), var_1)) {
      var_4 = 0;
      thread handle_fire_blocker(var_4);
      break;
    }

    wait 0.1;
  }

  level notify("fire_blocker_success");
  level.fire_blocker_blown = var_4;
  var_7 = getEntArray("defend_fireblocker_lookers", "targetname");
  common_scripts\utility::array_call(var_7, ::delete);

  if(common_scripts\utility::flag("defend_player_fail_leaving") || common_scripts\utility::flag("ally_died")) {
    return;
  }
  thread maps\_utility::autosave_by_name("post_fireblocker");
  level waittill("setup_blockade");
}

handle_fire_blocker(var_0) {
  var_1 = 4;
  thread move_allies_from_fire_blocker(var_1);

  foreach(var_3 in level.fire_blockers_hurt[var_0])
  var_3 common_scripts\utility::trigger_on();

  radiusdamage(level.fire_radiusdamage[var_0].origin, 256, 200, 150);

  foreach(var_6 in level.fire_blockers_jet[var_0])
  playFX(common_scripts\utility::getfx("throwbot_explode"), var_6.origin, anglesToForward(var_6.angles), anglestoup(var_6.angles));

  foreach(var_6 in level.fire_blockers_body[var_0])
  playFX(common_scripts\utility::getfx("fx/fire/fire_gaz_clk"), var_6.origin, anglesToForward(var_6.angles), anglestoup(var_6.angles));

  var_6 = level.fire_blockers_jet[var_0][0];
  thread maps\clockwork_audio::defend_fire(var_6.origin);
  waittill_allies_out_of_fire_blocker(var_0);
  badplace_cylinder("", var_1, level.fire_blockers_body[var_0][0].origin - (0, 0, 40), 150, 150, "allies", "axis");

  foreach(var_11 in level.fire_blockers_brush[var_0])
  badplace_brush("", var_1, var_11, "allies", "axis");

  wait(var_1);

  foreach(var_11 in level.fire_blockers_brush[var_0]) {
    var_11 show();
    var_11 solid();

    if(isDefined(var_11.script_noteworthy) && var_11.script_noteworthy == "hideme") {
      var_11 disconnectpaths();
      var_11 hide();
      var_11 notsolid();
    }
  }

  common_scripts\utility::flag_wait("door_close");

  foreach(var_11 in level.fire_blockers_brush[var_0]) {
    if(isDefined(var_11.script_noteworthy) && var_11.script_noteworthy == "hideme") {
      var_11 notsolid();
      var_11 connectpaths();
    }
  }
}

waittill_allies_out_of_fire_blocker(var_0) {
  for(;;) {
    var_1 = 0;

    foreach(var_3 in level.fire_blockers_brush[var_0]) {
      if(level.allies[0] istouching(var_3) || level.allies[1] istouching(var_3)) {
        var_1 = 1;
        break;
      }
    }

    if(!var_1) {
      return;
    }
    common_scripts\utility::waitframe();
  }
}

move_allies_from_fire_blocker(var_0) {
  level.allies[0] thread ally_move_from_fire_blocker("baker_fireblocker_node", var_0);
  level.allies[1] thread ally_move_from_fire_blocker("keegan_fireblocker_node", var_0);
}

ally_move_from_fire_blocker(var_0, var_1) {
  var_2 = getnode(var_0, "targetname");

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = 15;
  self.ignoreall = 1;

  if(distance2dsquared(self.origin, var_2.origin) <= var_3)
    wait(var_1);
  else {
    var_4 = self.goalradius;
    self.goalradius = var_3;
    self setgoalnode(var_2);
    wait(var_1);
    self.goalradius = var_4;
  }

  self.ignoreall = 0;
}

handle_cypher_backups() {
  level.allies[2] endon("death");
  level endon("defend_player_left_area");
  var_0 = [];
  var_1 = [];

  for(var_2 = 1; var_2 < 6; var_2++) {
    var_0[var_0.size] = getent("cypher_backup_" + var_2, "targetname");
    var_1[var_1.size] = getent("cypher_backup_obj_" + var_2, "targetname");
    var_0[var_0.size - 1] hide();
    var_1[var_1.size - 1] hide();
  }

  var_3 = 0;
  level waittill("download_timer_started");

  for(var_4 = (level.download_timer - 10) / (var_0.size + 1); var_3 < var_0.size; var_3++) {
    level common_scripts\utility::waittill_notify_or_timeout("add_cypher_backup", var_4);
    var_0[var_3] show();
  }

  common_scripts\utility::flag_wait("defend_combat_finished");
  maps\clockwork_code::safe_activate_trigger_with_targetname("def_combat_finished");
  common_scripts\utility::waitframe();
  level.allies[2] maps\_utility::disable_ai_color();
  thread allies_throw_smoke();
  thread handle_random_mg_fire();
}

allies_throw_smoke() {
  common_scripts\utility::flag_wait("defend_smoke_thrown");
  thread watch_ally_throw_end_smoke(level.allies[0], "baker_smoke_toss");
  wait 0.2;
  watch_ally_throw_end_smoke(level.allies[1], "keegan_smoke_toss");

  if(isDefined(level.allies[0].maxfaceenemydist))
    level.allies[0].old_maxfaceenemydist = level.allies[0].maxfaceenemydist;
  else
    level.allies[0].old_maxfaceenemydist = undefined;

  level.allies[0].maxfaceenemydist = 2048;

  if(isDefined(level.allies[1].maxfaceenemydist))
    level.allies[1].old_maxfaceenemydist = level.allies[0].maxfaceenemydist;
  else
    level.allies[1].old_maxfaceenemydist = undefined;

  level.allies[1].maxfaceenemydist = 2048;
  common_scripts\utility::flag_set("defend_allies_smoke_thrown");
  common_scripts\utility::flag_wait("defend_player_left_area");
  level.allies[0].maxfaceenemydist = level.allies[0].old_maxfaceenemydist;
  level.allies[1].maxfaceenemydist = level.allies[1].old_maxfaceenemydist;
}

handle_random_mg_fire() {
  common_scripts\utility::flag_wait("defend_smoke_thrown");
  var_0 = common_scripts\utility::getstructarray("defend_mg_fire", "targetname");
  var_1 = common_scripts\utility::getstructarray("defend_mg_fire_target", "targetname");
  var_2 = 0;

  while(!common_scripts\utility::flag("door_close")) {
    foreach(var_4 in var_0) {
      foreach(var_6 in var_1) {
        var_7 = (randomintrange(-128, 128), randomintrange(-128, 128), randomintrange(-64, 0));
        magicbullet("m27", var_4.origin, var_6.origin + var_7);
        var_2++;
        common_scripts\utility::waitframe();

        if(var_2 >= 40 || var_2 == randomintrange(0, 40)) {
          var_2 = 0;
          magicbullet("m27", var_4.origin, level.player.origin + (0, 0, 32));
        }
      }
    }

    wait(randomfloatrange(0.25, 1));
  }
}

watch_sentry_badplace() {
  level endon("defend_combat_finished");

  for(;;) {
    level.player waittill("sentry_placement_finished");
    wait 0.3;

    if(isDefined(level.defend_sentry[0].badplace_name)) {
      call[[level.badplace_delete_func]](level.defend_sentry[0].badplace_name);
      call[[level.badplace_cylinder_func]](level.defend_sentry[0].badplace_name, 0, level.defend_sentry[0].origin, 32, 48, level.defend_sentry[0].team, "neutral");
    }
  }
}

handle_dog_defend() {
  common_scripts\utility::flag_wait("defend_player_drop_bag");
  handle_dog_combat_defend();
  common_scripts\utility::flag_wait("defend_combat_finished");
  level.dog maps\_utility::set_ignoreall(1);
  level.dog maps\_utility::set_ignoreme(1);
  level.dog maps\ally_attack_dog::set_dog_scripted_mode(level.player);
  level.dog thread maps\ally_attack_dog::lock_player_control_until_flag("ele_anim_done");
}

handle_dog_combat_defend() {
  handle_dog_combat_defend_static();
  level.dog maps\ally_attack_dog::dog_enable_ai_color();
  level.dog.goalradius = 64;
  level.dog.goalheight = 128;
  level.dog.pathenemyfightdist = 0;
  level.dog setdogattackradius(128);
}

handle_dog_combat_defend_static() {
  level endon("defend_combat_finished");
  level.dog maps\ally_attack_dog::dog_disable_ai_color();
  level.dog.goalradius = 64;
  level.dog.goalheight = 64;
  level.dog.pathenemyfightdist = 0;
  level.dog setdogattackradius(256);
  var_0 = getent("defend_last_stand", "targetname");

  for(;;) {
    common_scripts\utility::flag_wait("def_south_has_enemy");
    var_1 = var_0 maps\_utility::get_ai_touching_volume("axis");

    if(var_1.size > 0) {
      var_2 = randomint(var_1.size);

      if(!isDefined(var_1[var_2].dogcypher_claimed) || var_1[var_2].dogcypher_claimed == level.dog) {
        var_1[var_2].dogcypher_claimed = level.dog;
        level.override_dog_enemy = var_1[var_2];
        level.player notify("dog_attack_override");
        var_1[var_2] common_scripts\utility::waittill_notify_or_timeout("dead", 15);
      }
    }

    wait 0.1;
  }
}

updatesentrypositionclockwork(var_0) {
  var_1 = 0;
  var_2 = getent("no_turret", "targetname");

  if(isDefined(var_2) && !common_scripts\utility::flag("cypher_baker_interaction_done"))
    var_1 = var_0 istouching(var_2);

  var_3 = self canplayerplacesentry();
  var_0.origin = var_3["origin"];
  var_0.angles = var_3["angles"];
  self.canplaceentity = self isonground() && var_3["result"] && !var_1;
  common_scripts\_sentry::sentry_placement_hint_show(self.canplaceentity);

  if(self.canplaceentity)
    var_0 setModel(level.sentry_settings[var_0.sentrytype].placementmodel);
  else
    var_0 setModel(level.sentry_settings[var_0.sentrytype].placementmodelfail);
}