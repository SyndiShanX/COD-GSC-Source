/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\enemyhq_basement.gsc
*****************************************************/

enemyhq_basement_pre_load() {
  common_scripts\utility::flag_init("basement_combat_done");
  common_scripts\utility::flag_init("gas_guys_dead");
  common_scripts\utility::flag_init("cage_guys2");
  common_scripts\utility::flag_init("flee_guys_dead");
  common_scripts\utility::flag_init("ready_to_throw");
  common_scripts\utility::flag_init("clubhouse_done");
  common_scripts\utility::flag_init("hvt_done");
  common_scripts\utility::flag_init("pick_up_bishop");
  common_scripts\utility::flag_init("slowmo_over");
  common_scripts\utility::flag_init("start_gas_scene");
  common_scripts\utility::flag_init("cage_runners");
  common_scripts\utility::flag_init("dog_scratching");
  common_scripts\utility::flag_init("basement_guys_dead");
  common_scripts\utility::flag_init("enter_cage_vo");
  common_scripts\utility::flag_init("cage_firing");
  common_scripts\utility::flag_init("cage_firing1");
  common_scripts\utility::flag_init("cage_firing2");
  common_scripts\utility::flag_init("tossed_gas");
  common_scripts\utility::flag_init("gassed_out");
  common_scripts\utility::flag_init("bishop_keegan_interact");
  common_scripts\utility::flag_init("breach_setup1_ready");
  common_scripts\utility::flag_init("start_the_dog");
  common_scripts\utility::flag_init("go_under_debris");
  common_scripts\utility::flag_init("pre_breach_hall");
  common_scripts\utility::flag_init("drop_flare");
  common_scripts\utility::flag_init("pickup_flare");
  common_scripts\utility::flag_init("start_hesh_rescue");
  common_scripts\utility::flag_init("start_merrick_rescue");
  common_scripts\utility::flag_init("dog_leave_rescue");
  common_scripts\utility::flag_init("to_trophy_room");
  common_scripts\utility::flag_init("enemies_surprised");
  common_scripts\utility::flag_init("media_room_clear");
  common_scripts\utility::flag_init("keegan_at_gas_door");
  common_scripts\utility::flag_init("keegan_breach");
  common_scripts\utility::flag_init("start_hvt_rescue");
  common_scripts\utility::flag_init("allies_in_position");
  common_scripts\utility::flag_init("teargas_hot");
  common_scripts\utility::flag_init("basement_teargas_done");
}

escape_objective() {
  var_0 = maps\_utility::obj("escapeobj");
  objective_add(var_0, "current", &"ENEMY_HQ_ESCAPE_FROM_THE_ENEMY");
  common_scripts\utility::flag_wait("obj_escape_complete");
  maps\_utility::objective_complete(var_0);
}

setup_combat() {
  level.start_point = "basement_combat";
  maps\enemyhq::setup_common();
  thread maps\enemyhq_audio::aud_check("combat");
  maps\enemyhq_code::safe_activate_trigger_with_targetname("basement_ally_combat1");
  give_player_teargas();
  common_scripts\utility::array_thread(level.allies, maps\enemyhq_code::stream_waterfx, "breach_activate", "step_walk_water");
  level.player thread maps\enemyhq_code::gasmask_hud_on();
  level.player notify("dog_guard_me");
}

begin_combat() {
  var_0 = getent("clubhouse_breach_light", "targetname");
  var_0 setlightintensity(0);
  maps\_utility::disable_trigger_with_targetname("breach_trigger");
  var_1 = getent("clubhouse_doorhandle2_obj", "targetname");
  var_2 = getent("clubhouse_doorhandle3_obj", "targetname");
  var_1 hide();
  var_2 hide();
  var_3 = getent("clubhouse_door1a_handle", "targetname");
  var_4 = getent("clubhouse_door1a", "targetname");
  var_3 linkto(var_4);
  var_3 = getent("clubhouse_door1_handle", "targetname");
  var_4 = getent("clubhouse_door1", "targetname");
  var_3 linkto(var_4);
  thread basement_ally_movement();
  thread basement_combat_handlers();
  thread combat_vo();
  maps\_utility::battlechatter_on("allies");
  maps\_utility::battlechatter_on("axis");
  wait 1;
  maps\_utility::autosave_by_name("basement_combat");
  thread media_guys();
  thread new_glowstick_scene();
  thread handle_pickup_flare();
  common_scripts\utility::flag_wait("enter_media_room");
  level.dog maps\enemyhq_code::set_dog_scripted_mode(level.player);
  common_scripts\utility::flag_wait("basement_combat_done");
}

combat_vo() {
  level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_quickbeforetheymove");
  level.dog maps\_utility_dogs::disable_dog_sniff();
  common_scripts\utility::flag_wait("basement_final_stand");
  level.dog maps\_utility_dogs::disable_dog_sniff();
  level.dog waittill("start_sniffing");
  level.dog playSound("anml_dog_bark");
  wait 1;
  level.allies[2] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_hsh_rileyspickedupthe");
  thread maps\enemyhq_audio::aud_flare_grab();
  level.dog waittill("stop_sniffing");
  wait 2.5;
  level.dog playSound("anml_dog_bark");
  wait 1;
  level.dog playSound("anml_dog_bark");
  wait 1;
  thread dog_scratch_scene();
  level.allies[2] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_hsh_mustbeclosenow");
  common_scripts\utility::flag_wait("dog_scratching");
  level.allies[1] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_kgn_thismustbewhere");
  common_scripts\utility::flag_set("breach_setup1_ready");
  level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_keeganadamseeif");
  level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_wellwaitherefor");
  wait 2;
  level.allies[1] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_kgn_youandmelogan");
}

basement_combat_handlers() {
  common_scripts\utility::flag_wait("basement_guys1");
  level.dog maps\_utility_dogs::disable_dog_sniff();
  level.dog playSound("anml_dog_bark");
  var_0 = maps\enemyhq_code::array_spawn_targetname_allow_fail("basement_guys1");
  thread maps\enemyhq_code::set_flag_on_killcount(var_0, var_0.size - 1, "basement_guys2");
  thread handle_basement_guys2();
  thread handle_basement_guys3b();
  thread handle_basement_guys3c();
  common_scripts\utility::flag_wait("basement_guys3");
  level.dog maps\_utility_dogs::disable_dog_sniff();
  var_0 = maps\enemyhq_code::array_spawn_targetname_allow_fail("basement_guys3");
  var_1 = getaiarray("axis");
  thread maps\enemyhq_code::set_flag_on_killcount(var_1, var_1.size - 3, "basement_final_stand");
  common_scripts\utility::flag_wait("basement_final_stand");
  var_0 = getaiarray("axis");

  foreach(var_3 in var_0) {
  var_3.script_forcecolor = "r";
  }

  var_0 = maps\enemyhq_code::array_spawn_targetname_allow_fail("basement_guys4");
  var_1 = getaiarray("axis");
  thread maps\enemyhq_code::set_flag_on_killcount(var_1, var_1.size, "basement_guys_dead");
  common_scripts\utility::flag_wait("basement_guys_dead");
}

handle_basement_guys2() {
  common_scripts\utility::flag_wait("basement_guys2");
  var_0 = maps\enemyhq_code::array_spawn_targetname_allow_fail("basement_guys2");
  var_1 = getaiarray("axis");
  thread maps\enemyhq_code::set_flag_on_killcount(var_1, var_1.size - 3, "basement_guys3");
}

handle_basement_guys3b() {
  common_scripts\utility::flag_wait("basement_guys3b");
  var_0 = maps\enemyhq_code::array_spawn_targetname_allow_fail("basement_guys3b");
}

handle_basement_guys3c() {
  common_scripts\utility::flag_wait("basement_guys3c");
  var_0 = maps\enemyhq_code::array_spawn_targetname_allow_fail("basement_guys3c");
}

basement_ally_movement() {
  common_scripts\utility::flag_wait("basement_guys2");
  wait 1.5;
  maps\enemyhq_code::safe_activate_trigger_with_targetname("basement_allies2");
  common_scripts\utility::flag_wait("basement_final_stand");
  maps\enemyhq_code::safe_activate_trigger_with_targetname("basement_allies4");
  common_scripts\utility::flag_wait("basement_guys_dead");
  maps\enemyhq_code::safe_activate_trigger_with_targetname("basement_allies5");
}

setup_teargas() {
  level.start_point = "basement_teargas";
  maps\enemyhq::setup_common();
  thread maps\enemyhq_audio::aud_check("teargas");
  level.dog maps\enemyhq_code::lock_player_control();
  level.dog maps\enemyhq_code::set_dog_scripted_mode(level.player);
  maps\enemyhq_code::safe_activate_trigger_with_targetname("basement_allies3");
}

begin_teargas() {
  thread maps\_utility::battlechatter_off("allies");
  thread maps\_utility::battlechatter_off("axis");
  common_scripts\utility::array_thread(level.allies, maps\enemyhq_code::stream_waterfx, "breach_activate", "step_walk_water");
  var_0 = getaiarray("axis");
  common_scripts\utility::array_thread(var_0, maps\enemyhq_code::delete_ai);
  common_scripts\utility::flag_wait("basement_vision");
  level notify("stop_leave_fails");
  level.player allowprone(0);
  common_scripts\utility::array_thread(level.allies, maps\_utility::enable_cqbwalk);
  thread teargas_patrol();
  thread handle_gas();
  thread keegan_throw_gas();
  thread teargas_vo();
  thread gas_flee_guys();
  thread teargas_handle_ps4_ssao();
  wait 0.2;
  maps\_utility::autosave_by_name("teargas");
  common_scripts\utility::flag_wait("start_gas_scene_allies");
  common_scripts\utility::flag_wait_or_timeout("start_gas_scene", 5);
  level.dog maps\_utility_dogs::disable_dog_sniff();
  level.dog playSound("anml_dog_growl");
  common_scripts\utility::flag_set("start_gas_scene");
  common_scripts\utility::flag_wait("gassed_out");
  level.dog maps\_utility_dogs::disable_dog_sniff();
  common_scripts\utility::flag_wait("basement_teargas_done");
  level.dog maps\_utility_dogs::disable_dog_sniff();
}

teargas_handle_ps4_ssao() {
  if(!level.ps4) {
    return;
  }
  common_scripts\utility::flag_wait("gassed_out");
  wait 5;
  maps\_art::disable_ssao_over_time(2);
  level common_scripts\utility::waittill_notify_or_timeout("basement_guys1", 20);
  maps\_art::enable_ssao_over_time(4);
}

teargas_patrol() {
  common_scripts\utility::flag_wait("start_gas_scene_allies");
  var_0 = maps\enemyhq_code::array_spawn_targetname_allow_fail("cage_runners", 1);

  foreach(var_2 in var_0) {
    var_2.disablearrivals = 1;
    var_2.disableexits = 1;
    var_2.animname = "generic";
    var_2 maps\_utility::set_run_anim(common_scripts\utility::random(["active_patrolwalk_gundown", "patrol_bored_patrolwalk"]), 1);
    var_2.moveplaybackrate = randomfloatrange(0.85, 1.0);
    var_2 thread shoot_patrol_kick_off_gas();
  }

  common_scripts\utility::flag_wait("tossed_gas");
  var_0 = maps\_utility::array_removedead_or_dying(var_0);

  foreach(var_2 in var_0) {
  var_2 setgoalpos(var_2.origin);
  }

  wait 1;
  var_0 = maps\_utility::array_removedead_or_dying(var_0);

  foreach(var_2 in var_0) {
    var_2.ignoreme = 0;
    var_2.ignoreall = 0;
  }
}

shoot_patrol_kick_off_gas() {
  level endon("tossed_gas");
  self addaieventlistener("grenade danger");
  self addaieventlistener("projectile_impact");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("gunshot");
  self addaieventlistener("gunshot_teammate");
  self addaieventlistener("explode");
  common_scripts\utility::waittill_any("ai_event", "death_by_player", "damage_by_player");
  maps\_utility::battlechatter_on("axis");
  maps\_utility::clear_run_anim();
  self.disablearrivals = 0;
  self.disableexits = 0;
  self.ignoreall = 0;
  self setgoalpos(self.origin);
  self getenemyinfo(level.player);
  common_scripts\utility::flag_set("teargas_hot");
  common_scripts\utility::flag_set("ready_to_throw");
}

stop_externalfx() {
  maps\_utility::stop_exploder(8);
  maps\_utility::stop_exploder(89);
  maps\_utility::stop_exploder(9090);
  maps\_utility::stop_exploder(9080);
  maps\_utility::stop_exploder(666);
  maps\_utility::stop_exploder(1111);
}

wait_for_player_gas() {
  var_0 = getent("batting_cage_volume", "script_noteworthy");
  level.player waittill("teargas_thrown");
  common_scripts\utility::flag_set("tossed_gas");
  var_0 waittill("teargas_exploded");
  common_scripts\utility::flag_set("gassed_out");
}

handle_gas() {
  thread wait_for_player_gas();
  var_0 = getent("batting_cage_volume", "script_noteworthy");
  common_scripts\utility::flag_wait("gassed_out");
  wait 2;
  wait 1;
  common_scripts\utility::exploder(999);
  var_1 = getent("maintenance_door1", "targetname");
  var_1 rotateyaw(-90, 1.0, 0.1, 0.75);
  var_1 connectpaths();
  stop_externalfx();
  common_scripts\utility::exploder(308);
  common_scripts\utility::exploder(301);
  var_2 = getEntArray("cage_guys", "targetname");
  common_scripts\utility::array_thread(var_2, ::spawn_animate_and_get_shot, 200, 1, 1, 1);
  wait 0.5;
  thread cage_guys2();
  common_scripts\utility::flag_wait_or_timeout("cage_guys2a", 2);
  var_2 = getEntArray("cage_guys2a", "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
  var_3[var_3.size] = var_5 spawn_animate_and_get_shot(100, 1, 1);
  }

  wait 1;
  common_scripts\utility::flag_set("cage_guys2");
  common_scripts\utility::flag_set("enter_cage_vo");
  wait 0.1;
  var_3 = getaiarray("axis");
  thread maps\enemyhq_code::set_flag_on_killcount(var_3, var_3.size - 2, "gas_flee_guys");
  thread maps\enemyhq_code::set_flag_on_killcount(var_3, var_3.size, "gas_guys_dead");
  level.dog maps\enemyhq_code::unlock_player_control();
  var_1 = getent("maintenance_roll_door1", "targetname");
  var_7 = getent("teargas_door_clip", "targetname");
  var_8 = getent("teargas_door_clip_ai", "targetname");
  var_9 = common_scripts\utility::getstruct("battingcage_gas", "targetname");
  var_10 = maps\_utility::spawn_anim_model("teargas_door_prop");
  var_9 thread maps\_anim::anim_first_frame_solo(var_10, "teargas_dooropen");
  wait 0.05;
  var_1 linkto(var_10, "J_prop_2");
  level.allies[1].animname = "generic";
  var_1 notsolid();
  var_7 linkto(var_1);
  var_9 thread maps\_anim::anim_single([level.allies[1], var_10], "teargas_dooropen");
  var_10 waittillmatch("single anim", "end");
  var_1 unlink();
  var_1 solid();
  var_10 delete();
  var_8 notsolid();
  var_8 connectpaths();
  var_1 connectpaths();
  maps\_utility::battlechatter_on("allies");
  level.player allowprone(1);
  wait 4.25;
  common_scripts\utility::array_thread(level.allies, maps\_utility::disable_cqbwalk);
  maps\enemyhq_code::safe_activate_trigger_with_targetname("battingcage1");
  level.allies[0] maps\_utility::enable_ai_color();
  wait 1;
  wait 2;
  var_3 = getaiarray("axis");
  var_3 = maps\_utility::array_removedead_or_dying(var_3);
  common_scripts\utility::array_thread(var_3, maps\_utility::set_ignoreme, 0);
}

keegan_throw_gas() {
  var_0 = getnode("battingcage_gas_node", "targetname");
  level.allies[1].oldgoalradius = level.allies[1].goalradius;
  level.allies[1] maps\_utility::set_goalradius(20);
  level.allies[1] setgoalnode(var_0);
  level.allies[1] waittill("goal");
  level.allies[1] maps\_utility::set_goalradius(level.allies[1].oldgoalradius);
  common_scripts\utility::flag_set("keegan_at_gas_door");
  common_scripts\utility::flag_wait_any("tossed_gas", "ready_to_throw");
  var_1 = maps\_utility::spawn_anim_model("clubhouse_grenade");
  var_2 = maps\_utility::spawn_anim_model("teargas_grenade_prop");
  var_1 linkto(var_2, "J_prop_1");
  var_3 = common_scripts\utility::getstruct("battingcage_gas", "targetname");
  level.allies[1].animname = "generic";
  var_3 thread maps\_anim::anim_single([level.allies[1], var_2], "teargas_initiate");
  thread breach_grenade_smoke(var_1, 1.6);
  wait 3.6;
  var_3 = common_scripts\utility::getstruct("cage_door_gas_targ", "targetname");
  var_4 = var_3.origin;
  var_3 = common_scripts\utility::getstruct("cage_door_gas_org", "targetname");
  var_5 = var_3.origin;
  var_6 = magicgrenade("teargas_grenade", var_5, var_4, 1.5, 1);
  var_6 thread maps\_teargas::track_teargas();
  wait 1.5;
  common_scripts\utility::flag_set("gassed_out");
  wait 3;
  var_1 delete();
  var_2 delete();
}

gas_flee_guys() {
  common_scripts\utility::flag_wait("gas_flee_guys");
  var_0 = maps\enemyhq_code::array_spawn_targetname_allow_fail("gas_flee_guys");
  thread maps\enemyhq_code::set_flag_on_killcount(var_0, var_0.size, "flee_guys_dead");
  wait 0.5;
  level.dog thread maps\enemyhq_code::dog_attack_targets_by_priority(var_0, "basement_combat_done");
  common_scripts\utility::flag_set("basement_teargas_done");
  wait 1;
  var_0 = maps\_utility::array_removedead_or_dying(var_0);
  common_scripts\utility::array_thread(var_0, maps\_utility::set_ignoreall, 0);
  common_scripts\utility::array_thread(var_0, maps\_utility::set_ignoreme, 0);
  common_scripts\utility::flag_wait("flee_guys_dead");
  level.player notify("dog_guard_me");
}

battingcage_door_peek() {
  var_0 = getent("basement_door1", "targetname");
  var_0 rotateyaw(20, 2.5, 0.1, 0.75);
}

merrick_shoots_first_guy(var_0) {
  wait 1.5;
  var_0.ignoreme = 0;
  level.allies[1].ignoreall = 0;
  level.allies[1] getenemyinfo(var_0);
}

cage_guys2() {
  common_scripts\utility::flag_wait("cage_guys2");
  var_0 = getEntArray("cage_guys2", "targetname");
  common_scripts\utility::array_thread(var_0, ::spawn_animate_and_get_shot, 256, 1, 1);
}

cage_guys3() {
  common_scripts\utility::flag_wait("cage_guys3");
  var_0 = maps\enemyhq_code::array_spawn_targetname_allow_fail("cage_guys3");
  wait 1;
  var_1 = common_scripts\utility::getstruct("battingcage_gas_origin", "targetname");
  var_2 = var_1.origin;
  var_1 = common_scripts\utility::getstruct("battingcage_gas_target", "targetname");
  var_3 = var_1.origin;
  var_4 = magicgrenade("teargas_grenade", var_2, var_3, 0.5, 1);
  var_4 thread maps\_teargas::track_teargas();
}

monitor_teargas_lookat(var_0, var_1) {
  self endon("death");
  var_2 = 0;
  var_3 = var_0 * var_0;
  var_4 = distance2dsquared(level.player.origin, self.origin);

  while(isDefined(self) && isalive(self) && !var_2) {
    if(var_4 < var_3 && maps\enemyhq_code::raven_player_can_see_ai(self)) {
      var_2 = 1;
      continue;
    }

    wait 0.1;
    var_4 = distance2dsquared(level.player.origin, self.origin);
  }

  wait(var_1);
  self.ignoreme = 0;
  wait 1;
  kill_me_now();
}

cage_fake_firing(var_0) {
  var_1 = getent("battingcage_shoot_from", "targetname");
  var_2 = getent("battingcage_shoot_at", "targetname");

  while(!common_scripts\utility::flag(var_0)) {
    var_3 = randomintrange(30, 120);

    for(var_4 = 1; var_4 < var_3; var_4++) {
      var_5 = random_offset(var_1.origin, 16);
      var_6 = random_offset(var_2.origin, 64);
      magicbullet("m27", var_5, var_6);
      wait 0.1;

      if(common_scripts\utility::flag(var_0)) {
        var_4 = var_3;
      }
    }

    wait(randomfloatrange(0.5, 1.25));
  }
}

random_offset(var_0, var_1) {
  var_2 = (var_0[0] + randomfloatrange(-1 * var_1, var_1), var_0[1] + randomfloatrange(-1 * var_1, var_1), var_0[2] + randomfloatrange(-1 * var_1, var_1));
  return var_2;
}

give_player_teargas() {
  level.player.gasmask_on = 1;

  foreach(var_1 in level.allies) {
  var_1.gasmask_on = 1;
  }

  level.player takeweapon("flash_grenade");
  level.player setoffhandprimaryclass("smoke");
  level.player giveweapon("teargas_grenade");
  level.player givemaxammo("teargas_grenade");
}

teargas_hot_vo() {
  common_scripts\utility::flag_wait_any("teargas_hot", "gassed_out");

  if(!common_scripts\utility::flag("gassed_out")) {
    maps\enemyhq_code::radio_dialog_add_and_go("enemyhq_mrk_adamgasem");
    wait 0.5;
    var_0 = getent("enemy_yell_loc", "targetname");
    var_0 playSound("enemyhq_pmc3_weareunderattack");
  }
}

teargas_vo() {
  level.player endon("death");
  thread teargas_hot_vo();
  common_scripts\utility::flag_wait("start_gas_scene");
  common_scripts\utility::flag_wait_any("keegan_at_gas_door", "teargas_hot");

  if(!common_scripts\utility::flag("teargas_hot")) {
    level.allies[1] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_kgn_enemypatrolsprobablya");
  }

  if(!common_scripts\utility::flag("teargas_hot")) {
    level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_wedonthavetime");
  }

  if(!common_scripts\utility::flag("teargas_hot")) {
    maps\_utility::delaythread(7, common_scripts\utility::flag_set, "ready_to_throw");
  }

  maps\enemyhq_code::gas_mask_on_player_anim();
  give_player_teargas();

  if(!common_scripts\utility::flag("teargas_hot")) {
    thread maps\enemyhq_code::nag_player_until_flag(level.allies[0], "gassed_out", "enemyhq_mrk_throwgasunderthe", "enemyhq_mrk_throwsomegasin");
  }

  thread teargas_hint();
  common_scripts\utility::flag_wait("enter_cage_vo");
  level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_move");
}

dog_scratch_scene() {
  common_scripts\utility::flag_wait("breach_setup1");
  level.dog maps\_utility::disable_ai_color();
  level.dog maps\enemyhq_code::lock_player_control();
  level.dog maps\enemyhq_code::set_dog_scripted_mode(level.player);
  wait 0.05;
  var_0 = common_scripts\utility::getstruct("dog_at_door", "targetname");
  maps\enemyhq_code::safe_activate_trigger_with_targetname("clubhouse1");
  level.dog maps\_utility::delaythread(0.5, maps\_utility::set_goalradius, 30);
  var_0 maps\_anim::anim_reach_solo(level.dog, "found_door");
  common_scripts\utility::flag_set("dog_scratching");
  level.dog playSound("anml_dog_whine");
  thread maps\enemyhq_audio::aud_dog_scratch();
  var_0 maps\_anim::anim_single_solo(level.dog, "found_door");
  level.dog maps\_utility_dogs::enable_dog_sniff();
  level.dog maps\_utility::enable_ai_color();
}

teargas_hint_wait() {
  if(common_scripts\utility::flag("tossed_gas") || common_scripts\utility::flag("gassed_out")) {
    return 1;
  }

  return 0;
}

teargas_hint() {
  wait 2;

  if(!common_scripts\utility::flag("tossed_gas")) {
    thread maps\_utility::display_hint("tear_hint");
  }
}

spawn_animate_and_get_shot(var_0, var_1, var_2, var_3) {
  var_4 = self.animation;
  var_5 = -1;

  if(isDefined(self.script_parameters)) {
    var_5 = float(self.script_parameters);
  }

  var_6 = undefined;

  if(isDefined(self.target)) {
    var_6 = common_scripts\utility::getstruct(self.target, "targetname");
  }

  var_7 = maps\_utility::spawn_ai();

  if(isDefined(var_7)) {
    level.teargas_scripted_guys[level.teargas_scripted_guys.size] = var_7;

    if(isDefined(var_3)) {
      var_7.gasmask_on = var_3;
    }

    var_7.allowdeath = 1;

    if(var_2 == 1) {
      var_7 maps\_utility::gun_remove();
    }

    var_7 thread animate_and_get_shot(var_0, var_1, var_5, var_4, var_6);
  }

  return var_7;
}

animate_and_get_shot(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;
  var_5 thread monitor_teargas_lookat(var_0, var_1);
  var_5 endon("death");

  if(!isDefined(var_4)) {
    var_4 = self;
  }

  if(var_2 > 0) {
    var_4 thread maps\_anim::anim_generic(var_5, var_3);
    wait(var_2 - 1);
  } else
    var_4 maps\_anim::anim_generic(var_5, var_3);

  var_5.ignoreme = 0;
  wait 1;
  var_5 kill_me_now();
}

kill_me_now() {
  maps\_utility::die();
}

media_guys() {
  common_scripts\utility::flag_wait("media_guys");
  thread cqb_time();
  maps\_utility::autosave_by_name("media_guys");
  common_scripts\utility::array_thread(level.allies, maps\_utility::enable_cqbwalk);
  common_scripts\utility::array_thread(level.allies, maps\_utility::disable_surprise);
}

cqb_time() {
  var_0 = getent("start_cqb", "targetname");

  while(!common_scripts\utility::flag("breach_setup1_ready")) {
    var_0 waittill("trigger", var_1);

    if(var_1 != level.dog) {
      var_1 maps\_utility::cqb_walk("on");
    }
  }
}

dog_ambush() {
  common_scripts\utility::flag_wait("dog_ambush");
  var_0 = maps\enemyhq_code::array_spawn_targetname_allow_fail("dog_ambush");
}

glowstick_scene() {
  var_0 = common_scripts\utility::getstruct("light_glowstick", "targetname");
  common_scripts\utility::flag_wait("breach_setup1_ready");
  maps\enemyhq_code::safe_activate_trigger_with_targetname("ch_door_positions1");
  var_1 = maps\_utility::spawn_anim_model("glowstick_prop", var_0.origin);
  var_2 = maps\_utility::spawn_anim_model("glowstick", var_0.origin);
  var_2 linkto(var_1, "J_prop_1");
  var_3 = level.allies[1];
  var_3.animname = "keegan";
  var_4 = maps\_utility::make_array(var_3, var_1);
  var_0 maps\_anim::anim_reach_solo(var_3, "light_glowstick");
  var_0 thread maps\_anim::anim_single(var_4, "light_glowstick");
  var_5 = level.scr_anim["keegan"]["light_glowstick"];

  while(var_3 getanimtime(var_5) < 0.16) {
    wait 0.05;
  }

  var_3 maps\_utility::anim_stopanimscripted();
  var_1 maps\_utility::anim_stopanimscripted();
  var_1 unlink();
  var_1 linkto(var_3, "TAG_STOWED_BACK", (12, 0, 0), (0, 90, 0));
  var_3 maps\_utility::enable_ai_color();
  common_scripts\utility::flag_set("basement_combat_done");
}

handle_glowstick(var_0) {
  var_1 = maps\_utility::spawn_anim_model("glowstick", (0, 0, 0));
  wait 3;
  var_1 linkto(var_0, "tag_inhand", (0, 0, 0), (0, 0, 0));
  playFXOnTag(level._effect["glowstick"], var_0, "tag_inhand");
  common_scripts\utility::flag_wait("drop_flare");
  var_1 unlink();
  stopFXOnTag(level._effect["glowstick"], var_0, "tag_inhand");
  playFX(level._effect["glowstick"], var_1.origin);
}

handle_pickup_flare() {
  level.rubble_flare = getent("keegan_flare", "targetname");
  playFXOnTag(level._effect["vfx_handflare_ehq_lit"], level.rubble_flare, "tag_fire_fx");
  common_scripts\utility::flag_wait("pickup_flare");
  level.rubble_flare linkto(level.allies[1], "tag_inhand", (0, 0, 0), (0, 0, 0));
  common_scripts\utility::flag_wait("drop_flare");
  level.rubble_flare unlink();
}

handle_flare_slow() {
  level endon("death");

  while(!common_scripts\utility::flag("breach_activate")) {
    common_scripts\utility::flag_wait("flare_slow");
    level.player maps\_utility::player_speed_percent(50, 1);
    level.player allowsprint(0);
    wait 1;
    common_scripts\utility::flag_waitopen("flare_slow");
    level.player maps\_utility::player_speed_percent(100, 1);
    level.player allowsprint(1);
    wait 1;
  }
}

turn_off_player_clip(var_0) {
  var_1 = getent("flare_blocker", "targetname");
  wait(2.88 / var_0);
  var_1 notsolid();
}

new_glowstick_scene() {
  var_0 = common_scripts\utility::getstruct("club_traverse", "targetname");
  thread handle_flare_slow();
  common_scripts\utility::flag_wait("breach_setup1_ready");
  thread maps\enemyhq_audio::aud_music("lookfordoor");
  maps\_utility::battlechatter_off("axis");
  maps\_utility::battlechatter_off("allies");
  var_1 = maps\_utility::spawn_targetname("flare_kill_guy", 1);
  var_1.animname = "generic";
  var_1.gasmask_on = 1;
  var_1 maps\_utility::magic_bullet_shield();
  var_0 maps\_anim::anim_first_frame_solo(var_1, "flare_kill");
  level.flare_knife = spawn("script_model", (0, 0, 0));
  level.flare_knife setModel("weapon_knife_iw6");
  level.flare_knife hide();
  level.flare_gun = spawn("script_model", (0, 0, 0));
  level.flare_gun setModel("weapon_mp443");
  level.flare_gun hide();
  var_2 = level.allies[1];
  var_2.animname = "keegan";
  var_3 = getnode("keegan_start_look", "targetname");
  var_2 setgoalnode(var_3);
  var_2 waittill("goal");
  wait 1.5;
  maps\enemyhq_code::safe_activate_trigger_with_targetname("ch_door_positions1");
  maps\_utility::delaythread(2.43, common_scripts\utility::flag_set, "pickup_flare");
  level.allies[1] notify("start_flare");
  var_2.animname = "keegan";
  var_0 thread maps\_anim::anim_single_solo(var_2, "ct_start");
  var_2 waittillmatch("single anim", "end");

  if(!common_scripts\utility::flag("go_under_debris") && !common_scripts\utility::flag("looking_at_debris") && !common_scripts\utility::flag("pre_breach_hall")) {
    var_2.animname = "keegan";
    var_0 thread maps\_anim::anim_single_solo(var_2, "ct_enter_loop1");
    var_2 waittillmatch("single anim", "end");

    if(!common_scripts\utility::flag("go_under_debris") && !common_scripts\utility::flag("looking_at_debris") && !common_scripts\utility::flag("pre_breach_hall")) {
      var_2.animname = "keegan";
      var_0 thread maps\_anim::anim_loop_solo(var_2, "ct_loop1", "stop_waiting");
      common_scripts\utility::flag_wait_any("go_under_debris", "pre_breach_hall", "looking_at_debris");
      var_0 notify("stop_waiting");
    }

    var_2.animname = "keegan";
    var_0 thread maps\_anim::anim_single_solo(var_2, "ct_exit_loop1");
    var_2 waittillmatch("single anim", "end");
  } else {
    var_2.animname = "keegan";
    var_0 maps\_anim::anim_single_solo(var_2, "ct_nowait1");
    var_2 waittillmatch("single anim", "end");
  }

  thread turn_off_player_clip(1.2);
  var_2.animname = "keegan";
  var_0 thread maps\_anim::anim_single_solo(var_2, "ct_walk1");
  var_2 waittillmatch("single anim", "end");

  if(!common_scripts\utility::flag("start_flare_kill")) {
    if(!common_scripts\utility::flag("start_flare_kill")) {
      var_2.animname = "keegan";
      var_0 thread maps\_anim::anim_loop_solo(var_2, "flare_kill_loop", "stop_waiting");
      common_scripts\utility::flag_wait("start_flare_kill");
      var_0 notify("stop_waiting");
    }
  }

  var_4 = [var_2, var_1];
  level.flare_guys = var_4;
  thread maps\enemyhq_audio::aud_flare_kill();
  var_2.animname = "keegan";
  var_0 thread maps\_anim::anim_single(var_4, "flare_kill");
  wait 0.05;
  maps\_anim::anim_set_rate(var_4, "flare_kill", 1.3);
  level waittill("blend_out");

  if(!common_scripts\utility::flag("pre_breach_hall")) {
    var_2 waittillmatch("single anim", "end");
  }

  if(!common_scripts\utility::flag("pre_breach_hall")) {
    if(!common_scripts\utility::flag("pre_breach_hall")) {
      var_2.animname = "keegan";
      var_0 thread maps\_anim::anim_loop_solo(var_2, "ct_loop2", "stop_waiting");
      common_scripts\utility::flag_wait("pre_breach_hall");
      var_0 notify("stop_waiting");
    }
  } else {}

  level.allies[1] notify("steath_kill_done");
  maps\enemyhq_code::safe_activate_trigger_with_targetname("clubhouse_allies0");
  var_2.animname = "keegan";
  var_0 thread maps\_anim::anim_single_solo(var_2, "ct_walk2");
  wait 0.05;
  maps\_anim::anim_set_rate_single(var_2, "ct_walk2", 1.3);
  var_2 waittillmatch("single anim", "end");
  var_2 maps\_utility::enable_ai_color();
  thread keegan_breach_anim();
  common_scripts\utility::flag_set("basement_combat_done");
  maps\_utility::battlechatter_off("axis");
  maps\_utility::battlechatter_off("allies");
}

setup_clubhouse() {
  level.start_point = "clubhouse_breach";
  maps\enemyhq::setup_common();
  thread maps\enemyhq_audio::aud_check("clubhouse");
  maps\enemyhq_code::safe_activate_trigger_with_targetname("clubhouse_allies0");
  level.player thread maps\enemyhq_code::gasmask_hud_on();
  thread keegan_breach_anim();
}

begin_clubhouse() {
  maps\_utility::disable_trigger_with_targetname("breach_trigger");
  var_0 = getent("clubhouse_doorhandle2_obj", "targetname");
  var_1 = getent("clubhouse_doorhandle3_obj", "targetname");
  var_0 hide();
  var_1 hide();
  common_scripts\utility::flag_wait("clubhouse_ready");
  thread maps\enemyhq_audio::aud_enemy_muffled_vo("enemies_surprised", "enemy_vo_struct", "clubhouse_ready");
  maps\_utility::delaythread(1, maps\_utility::autosave_by_name, "clubhouse");
  spawn_bishop(1);
  thread ch_vo();
  common_scripts\utility::flag_wait("clubhouse_done");
}

spawn_bishop(var_0) {
  var_1 = getent("bishop", "targetname");
  var_2 = var_1 maps\_utility::spawn_ai(1);
  var_2 maps\_utility::gun_remove();
  var_2 maps\_utility::magic_bullet_shield();
  var_2.allowdeath = 0;
  var_2 maps\_utility::disable_pain();
  var_2.animname = "bishop";
  level.bishop = var_2;
  var_3 = common_scripts\utility::getstruct("hvt_find_struct", "targetname");

  if(var_0) {
    var_3 = common_scripts\utility::getstruct("hvt_find_struct", "targetname");
    var_3 thread maps\_anim::anim_first_frame_solo(level.bishop, "find_bishop");
  }

  level.flashlight_prop = maps\_utility::spawn_anim_model("bishop_flashlight_prop", var_3.origin);
  level.ajax_flare = maps\_utility::spawn_anim_model("ajax_flare", var_3.origin);
  level.ajax_flare linkto(level.flashlight_prop, "J_prop_2", (0, 0, 0), (0, 0, 0));
  level.ajax_flare hide();
  level.flashlight = maps\_utility::spawn_anim_model("flashlight");
  level.flashlight linkto(level.flashlight_prop, "J_prop_1", (0, 0, 0), (0, 0, 0));
  level.flashlight hide();
  level.stool_prop = maps\_utility::spawn_anim_model("bishop_chair_prop", var_3.origin);
  var_3 maps\_anim::anim_first_frame_solo(level.stool_prop, "find_bishop");
  var_4 = getent("bishop_chair_clip", "targetname");
  var_5 = getent("bishop_chair", "targetname");
  level.bishop_stool = var_5;
  var_4 linkto(var_5);
  var_5 linkto(level.stool_prop, "J_prop_1", (0, 0, 0), (0, 0, 0));
  var_4 = getent("ajax_chair2_clip", "targetname");
  var_5 = getent("ajax_chair2", "targetname");
  level.bishop_chair = var_5;
  var_4 linkto(var_5);
  var_5 linkto(level.stool_prop, "J_prop_2", (0, 0, 0), (0, 0, 0));
  level.bishop_mask = maps\_utility::spawn_anim_model("bishop_mask", var_3.origin);
  var_3 maps\_anim::anim_first_frame_solo(level.bishop_mask, "find_bishop");
}

get_base_weapon_name(var_0) {
  var_1 = "";
  var_2 = 0;

  for(var_3 = getsubstr(var_0, var_2, var_2 + 1); var_3 != "" && var_3 != "+"; var_3 = getsubstr(var_0, var_2, var_2 + 1)) {
    var_1 = var_1 + var_3;
    var_2++;
  }

  return var_1;
}

clubhouse_breach() {
  level.allies[1] maps\_utility::disable_surprise();
  var_0 = getent("clubhouse_door2", "targetname");
  var_1 = getent("clubhouse_door3", "targetname");
  var_2 = getent("clubhouse_doorhandle2", "targetname");
  var_3 = getent("clubhouse_doorhandle3", "targetname");
  var_2 linkto(var_0);
  var_3 linkto(var_1);
  var_4 = getent("clubhouse_doorhandle2_obj", "targetname");
  var_5 = getent("clubhouse_doorhandle3_obj", "targetname");
  var_4 show();
  var_5 show();
  var_2 hide();
  var_3 hide();
  common_scripts\utility::flag_wait("breach_activate");

  while(level.player isthrowinggrenade()) {
    wait 0.1;
  }

  level.player takeweapon("teargas_grenade");
  var_2 show();
  var_3 show();
  var_4 hide();
  var_5 hide();
  thread maps\enemyhq_audio::aud_breach();
  maps\_utility::disable_trigger_with_targetname("breach_trigger");
  level.dog maps\_utility_dogs::disable_dog_sniff();
  level.dog maps\_utility_dogs::disable_dog_sneak();
  var_6 = level.player getcurrentweapon();

  if(var_6 != "none") {
    level.player setweaponammoclip(var_6, weaponclipsize(var_6));
  }

  maps\enemyhq_code::setupplayerforanimations();
  level.dog maps\enemyhq_code::lock_player_control();
  thread kick_breach_anim("breach_struct_player");
  thread pre_breach_guys();
  thread ally_breach_gas();
  wait 9;
  maps\enemyhq_code::setupplayerforgameplay();
  thread keegan_breach_enemies();
  var_7 = getEntArray("CH_guys", "targetname");
  common_scripts\utility::array_thread(var_7, ::spawn_animate_and_get_shot, 256, 5, 0);
  var_7 = getEntArray("CH_guys_no_gun", "targetname");
  common_scripts\utility::array_thread(var_7, ::spawn_animate_and_get_shot, 256, 5, 1);
  thread clubhouse_clear();
  common_scripts\utility::exploder(450);
  wait 0.5;
  thread handle_breach_body_count();
  maps\enemyhq_code::safe_activate_trigger_with_targetname("breach_colors");
  setslowmotion(1.0, 0.3, 0.2);
  level.player maps\_utility::player_speed_percent(50, 1);
  thread breach_end_early();
  thread far_allies_breach();
  level common_scripts\utility::waittill_notify_or_timeout("abort_slowmo", 4);
  setslowmotion(0.3, 1.0, 1.0);
  level notify("finished_slowmo");
  wait 1;
  common_scripts\utility::flag_set("slowmo_over");
  level.player maps\_utility::player_speed_percent(100, 2);
  level.fake_teargas_coughing = 0;
}

handle_breach_body_count() {
  var_0 = getaiarray("axis");
  maps\_utility::waittill_dead_or_dying(var_0, var_0.size);
  level notify("abort_slowmo");
}

breach_end_early() {
  level endon("breach_done");
  level.player notifyonplayercommand("melee_button_pressed", "+melee");
  level.player common_scripts\utility::waittill_any("weapon_switch_started", "melee_button_pressed", "reload_start");
  level notify("abort_slowmo");
}

ally_breach_gas() {
  wait 2.0;
  common_scripts\utility::array_thread(level.allies, maps\_utility::set_ignoreall, 1);
  var_0 = getent("clubhouse_door1", "targetname");
  var_0 rotateyaw(20, 0.5, 0.1, 0.1);
  wait 0.5;
  var_1 = common_scripts\utility::getstruct("clubhouse_ally_gas_targ", "targetname");
  var_2 = var_1.origin;
  var_1 = common_scripts\utility::getstruct("clubhouse_ally_gas_start", "targetname");
  var_3 = var_1.origin;
  var_4 = magicgrenade("teargas_grenade", var_3, var_2, 1.5, 1);
  wait 1.5;
  var_0 rotateyaw(-20, 0.25, 0.1, 0.1);
  wait 0.25;
  common_scripts\utility::array_thread(level.allies, maps\_utility::set_ignoreall, 0);
}

pre_breach_guys() {
  var_0 = 1.8;
  var_1 = 4.0;
  wait(var_0);
  var_2 = getEntArray("CH_pre_breach_guys", "targetname");
  common_scripts\utility::array_thread(var_2, ::spawn_animate_and_get_shot, 1, 15, 1);
  wait(var_1 - var_0);
  common_scripts\utility::flag_set("enemies_surprised");
  var_3 = getaiarray("axis");
  stop_externalfx();
  maps\_utility::stop_exploder(308);
  maps\_utility::stop_exploder(890);
  common_scripts\utility::exploder(306);
  common_scripts\utility::exploder(307);

  foreach(var_5 in var_3) {
  var_5 delete();
  }

  wait 0.2;
}

far_allies_breach() {
  thread ch_dog_breach();
  var_0 = getent("clubhouse_door1", "targetname");
  var_0 rotateyaw(92, 0.2, 0.1, 0.1);
  var_0 connectpaths();
  var_1 = getent("clubhouse_door1a", "targetname");
  var_1 rotateyaw(-95, 0.2, 0.1, 0.1);
  var_1 connectpaths();
  var_2 = common_scripts\utility::getstruct("breach_struct", "targetname");
  level.allies[0].animname = "ally1";
  level.allies[2].animname = "ally3";
  var_2 thread maps\_anim::anim_single([level.allies[0], level.allies[2]], "ch_breach");
  wait 0.1;
  common_scripts\utility::flag_set("start_the_dog");
}

clubhouse_clear() {
  wait 0.1;
  maps\_utility::waittill_aigroupcleared("ch_guys");
  common_scripts\utility::flag_wait("slowmo_over");
  wait 2;
  level.allies[2] maps\_utility::delaythread(2, maps\enemyhq_code::char_dialog_add_and_go, "enemyhq_hsh_onrileyhesfound_2");
  thread maps\enemyhq_audio::aud_music("foundajax");
  common_scripts\utility::flag_set("clubhouse_done");
  thread maps\enemyhq_code::handle_leave_team_fail("leaving_clubhouse", "left_clubhouse");
  wait 4;
  maps\enemyhq_code::safe_activate_trigger_with_targetname("post_breach_colors");
  wait 5;

  if(!common_scripts\utility::flag("start_hvt_fight")) {
    level.allies[0] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_hsh_overhere");
  }
}

ch_vo() {
  common_scripts\utility::flag_wait("clubhouse_ready");
  level.allies[1] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_kgn_wefoundanotherdoor");
  level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_wellwaitforyour");
  wait 0.5;
  thread maps\enemyhq_code::nag_player_until_flag(level.player, "breach_activate", "enemyhq_kgn_adamgetoverto", "enemyhq_kgn_getovertothe", "enemyhq_kgn_adamgetoverhere");
  thread clubhouse_breach();
  maps\_utility::enable_trigger_with_targetname("breach_trigger");
  common_scripts\utility::flag_wait("breach_activate");
  wait 0.5;
  level.allies[1] thread maps\_utility::smart_radio_dialogue_interrupt("enemyhq_kgn_breachin5");
  thread enemy_breach_vo();
}

enemy_breach_vo() {
  common_scripts\utility::flag_wait("enemies_surprised");
  var_0 = getent("enemy_vo_struct2", "targetname");
  var_0 playSound("enemyhq_fs5_whatwasthat", "done");
  var_0 waittill("done");
  var_0 playSound("enemyhq_pmc3_teargastapersoffinto", "done");
}

ch_dog_breach() {
  var_0 = common_scripts\utility::getstruct("breach_struct3", "targetname");
  var_1 = getent("CH_dog_guy", "targetname");
  var_2 = var_1 maps\_utility::spawn_ai(1);
  var_2.animname = "generic";
  var_2 maps\_utility::gun_remove();
  level.dog.animname = "dog";
  var_3 = maps\_utility::make_array(var_2, level.dog);
  var_0 maps\_anim::anim_first_frame(var_3, "dog_breach");
  common_scripts\utility::flag_wait("start_the_dog");
  var_0 thread maps\_anim::anim_single(var_3, "dog_breach");
  level.dog waittillmatch("single_anim", "end");
  level.dog setgoalpos(level.dog.origin);
  level.dog maps\_utility::disable_ai_color();
  level.dog maps\_utility_dogs::disable_dog_sniff();
  wait 0.1;
  level.dog maps\_utility::enable_ai_color();
}

near_allies_breach() {
  var_0 = getnode("keegan_breach_node2", "targetname");
  level.allies[1] maps\_utility::teleport_ai(var_0);
  wait 0.5;
  var_1 = common_scripts\utility::getstruct("breach_struct2", "targetname");
  level.allies[1].animname = "ally2";
  var_1 thread maps\_anim::anim_single([level.allies[1]], "ch_breach");
}

kick_breach_anim(var_0) {
  var_1 = common_scripts\utility::getstruct(var_0, "targetname");
  var_2 = maps\_utility::spawn_anim_model("clubhouse_doors");
  level.breach_player_rig = maps\_utility::spawn_anim_model("player_rig");
  level.breach_player_rig hide();
  level.breach_player_legs = maps\_utility::spawn_anim_model("player_legs");
  level.breach_player_legs hide();
  level.breach_grenade = maps\_utility::spawn_anim_model("clubhouse_grenade");
  level.breach_grenade hide();
  var_3 = [level.breach_player_rig, level.breach_player_legs, var_2, level.breach_grenade];
  var_1 maps\_anim::anim_first_frame(var_3, "ch_breach");
  var_4 = getent("clubhouse_door2", "targetname");
  var_5 = getent("clubhouse_door3", "targetname");
  var_4 linkto(var_2, "J_prop_1");
  var_5 linkto(var_2, "J_prop_2");
  level.player playerlinktoblend(level.breach_player_rig, "tag_player", 0.4, 0.2, 0.2);
  var_6 = 0.4;
  wait(var_6);
  level.breach_player_rig show();
  level.breach_player_legs show();
  level.breach_grenade show();
  thread breach_grenade_smoke(level.breach_grenade, 1.88, 1);
  level.allies[1].animname = "keegan";
  common_scripts\utility::flag_set("keegan_breach");
  var_1 thread maps\_anim::anim_single(var_3, "ch_breach");
  level.breach_player_rig waittillmatch("single anim", "end");
  maps\_utility::battlechatter_on("axis");
  maps\_utility::battlechatter_on("allies");
  level.player unlink();
  level.breach_player_rig delete();
  level.breach_player_legs delete();
  level notify("kick_breach_anim_done");
}

keegan_breach_anim() {
  var_0 = common_scripts\utility::getstruct("club_traverse", "targetname");
  var_1 = common_scripts\utility::getstruct("breach_struct_player", "targetname");
  var_2 = maps\_utility::spawn_anim_model("ch_breach_gun_l");
  var_3 = maps\_utility::spawn_anim_model("ch_breach_gun_r");
  var_4 = level.allies[1];
  level.keegan_gun_l = var_2;
  level.keegan_gun_r = var_3;
  var_3 linkto(var_4, "tag_weapon_chest", (0, 0, 0), (0, 0, 0));
  var_2 linkto(var_4, "tag_weapon_left", (0, 0, 0), (0, 0, 0));
  var_2 hide();
  var_3 hide();
  var_5 = [var_4];
  var_0 thread maps\_anim::anim_loop(var_5, "ch_idle", "stop_loop");
  common_scripts\utility::flag_wait("keegan_breach");
  var_0 notify("stop_loop");
  level.keegan_gun_r show();

  if(isDefined(level.flare_gun)) {
    level.flare_gun hide();
    level.flare_gun unlink();
    level.flare_gun delete();
  }

  var_1 maps\_anim::anim_single_run(var_5, "ch_breach");
  var_2 unlink();
  var_3 unlink();
}

keegan_breach_enemies() {
  var_0 = "CH_keegan_guy";
  level.keegan_shoot_guys = 6;
  level.keegan_breach_guys = [];
  level.keegan_shoot_next = 0;
  level.keegan_shots_so_far = 0;

  for(var_1 = 1; var_1 <= level.keegan_shoot_guys; var_1++) {
    var_2 = var_0 + maps\_utility::string(var_1);
    var_3 = getent(var_2, "targetname");
    var_4 = var_3 spawn_animate_and_get_shot(256, 5, 1);
    level.keegan_breach_guys[level.keegan_breach_guys.size] = var_4;
  }
}

keegan_shoots_a_guy(var_0) {
  var_1 = 8;
  level.keegan_shots_so_far++;
  var_2 = 0;

  if(level.keegan_shots_so_far > var_1 - level.keegan_breach_guys.size) {
    var_2 = 1;
  }

  var_3 = var_0 gettagorigin("tag_flash");
  var_4 = var_0 gettagangles("tag_flash");
  var_5 = anglesToForward(var_4);
  var_6 = var_3 + var_5 * 500;
  playFXOnTag(level._effect["keegan_muzzleflash"], var_0, "tag_flash");

  if(level.keegan_shots_so_far > var_1 - level.keegan_breach_guys.size && var_2) {
    var_7 = level.keegan_breach_guys[level.keegan_shoot_next];

    if(isalive(var_7)) {
      var_6 = var_7.origin + (0, 0, 30);
    }

    magicbullet("sc2010", var_3, var_6);
    wait 0.2;

    if(isalive(var_7)) {
      var_7 maps\_utility::die();
    }

    level.keegan_shoot_next++;
  } else
    magicbullet("sc2010", var_3, var_6);
}

breach_grenade_smoke(var_0, var_1, var_2) {
  wait(var_1);
  var_3 = playFXOnTag(level._effect["smoke_tgas_trail_ehq"], var_0, "tag_fx");
  wait 3;
  stopFXOnTag(level._effect["smoke_tgas_trail_ehq"], var_0, "tag_fx");

  if(isDefined(var_2) && var_2) {
    var_0 delete();
  }
}

setup_hvt() {
  level.start_point = "hvt_rescue";
  maps\enemyhq::setup_common();
  thread maps\enemyhq_audio::aud_check("hvt");
  common_scripts\utility::flag_set("clubhouse_done");
  spawn_bishop(1);
  level.player thread maps\enemyhq_code::gasmask_hud_on();
  common_scripts\utility::flag_set("FLAG_ehq_give_objective");
  maps\enemyhq_intro::obj_getingetajaxgetout();
  thread maps\enemyhq_code::handle_leave_team_fail("leaving_clubhouse", "left_clubhouse");
}

begin_hvt() {
  maps\_utility::autosave_by_name("hvt_rescue");
  thread new_hvt_find();
  level.dog maps\enemyhq_code::set_dog_scripted_mode(level.player);
  common_scripts\utility::flag_wait("hvt_done");
}

new_hvt_find() {
  common_scripts\utility::flag_wait("clubhouse_done");
  maps\_utility::stop_exploder(306);
  maps\_utility::stop_exploder(307);
  thread hvt_dog_bark();
  var_0 = common_scripts\utility::getstruct("hvt_find_struct", "targetname");
  var_1 = level.bishop;
  thread start_hvt_scene(var_0);
  thread hvt_dog_bishop_anims(var_0);
  wait 2;
  maps\enemyhq_code::safe_activate_trigger_with_targetname("post_rescue");
  common_scripts\utility::flag_wait("pick_up_bishop");
  common_scripts\utility::array_thread(level.allies, maps\_utility::enable_ai_color);
  level.dog maps\_utility_dogs::disable_dog_sneak();
  level.dog maps\_utility::enable_ai_color();
  common_scripts\utility::flag_set("obj_rescue_obj");
  thread escape_objective();
  maps\_utility::autosave_by_name("gotbishop");
  thread maps\enemyhq_finale::enable_finale_and_ghost_chopper_clips();
  common_scripts\utility::flag_set("to_trophy_room");
  common_scripts\utility::flag_set("hvt_done");
}

start_hvt_scene(var_0) {
  level.hvt_guys_in_position = 0;
  level.allies[0].animname = "merrick";
  level.allies[1].animname = "keegan";
  level.allies[2].animname = "hesh";
  var_0 thread maps\_anim::anim_reach_together(level.allies, "find_bishop");
  common_scripts\utility::array_thread(level.allies, ::hvt_reach_and_animate, var_0);
  maps\_utility::delaythread(10, common_scripts\utility::flag_set, "allies_in_position");

  while(level.hvt_guys_in_position < 4 && !common_scripts\utility::flag("allies_in_position")) {
    wait 0.1;
  }

  common_scripts\utility::flag_wait("start_hvt_fight");
  common_scripts\utility::flag_set("start_hvt_rescue");
  var_1 = common_scripts\utility::array_add(level.allies, level.bishop);
  var_0 thread maps\_anim::anim_single_run(var_1, "find_bishop");

  foreach(var_3 in level.allies) {
    var_3 maps\enemyhq_code::gasmask_on_npc(0);
    var_3 detach("prop_sas_gasmask_attach", "j_head");
  }

  thread animate_chairs(var_0);
  maps\_utility::delaythread(1, maps\enemyhq_code::gas_mask_off_player_anim);
  common_scripts\utility::array_thread(level.allies, maps\_utility::disable_cqbwalk);
  thread maps\enemyhq_audio::aud_hvt_rescue_thread();
  level.allies[1] waittillmatch("single anim", "end");
  level.allies[1] maps\enemyhq_code::carry_bishop();
  thread maps\enemyhq_finale::keegan_idle_with_bishop();
}

animate_chairs(var_0) {
  var_0 thread maps\_anim::anim_single([level.stool_prop, level.bishop_mask, level.flashlight_prop], "find_bishop");
  thread unclip("aj_p_stool_clip", 8.17);
  thread unclip("aj_p_chair_clip", 29);
  level.stool_prop waittillmatch("single anim", "end");
  level.bishop_chair unlink();
  level.bishop_stool unlink();
  level.flashlight_prop waittillmatch("single anim", "end");
}

unclip(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  wait(var_1);
  var_2 notsolid();
}

hvt_reach_and_animate(var_0) {
  self waittill("anim_reach_complete");
  level.hvt_guys_in_position++;
}

hvt_dog_bishop_anims(var_0) {
  var_0 thread maps\_anim::anim_first_frame_solo(level.bishop, "find_bishop");
  level.dog.animname = "dog";
  var_0 maps\_anim::anim_reach_solo(level.dog, "find_bishop");
  level.hvt_guys_in_position++;
  common_scripts\utility::flag_wait("start_hvt_rescue");
  var_0 maps\_anim::anim_single_solo(level.dog, "find_bishop");
  var_0 thread maps\_anim::anim_loop_solo(level.dog, "find_bishop_dog_loop", "stop_dog_loop");
  common_scripts\utility::flag_wait("dog_leave_rescue");
  var_0 notify("stop_dog_loop");
  var_0 maps\_anim::anim_single_solo_run(level.dog, "find_bishop_exit");
}

hvt_dog_bark() {
  while(!common_scripts\utility::flag("start_hvt_fight")) {
    level.dog playSound("anml_dog_bark");
    wait(randomfloatrange(0.25, 0.75));
  }
}

breach_gun_up(var_0) {
  level.player playerlinkto(level.breach_player_rig, "tag_player", 1, 70, 70, 70, 70);
  level.player enableweapons();
}

bishop_speaks(var_0) {
  level.bishop maps\enemyhq_code::char_dialog_add_and_go("enemyhq_oby_var");
}

time_to_go(var_0) {
  common_scripts\utility::flag_set("pick_up_bishop");
  maps\_utility::delaythread(0.25, maps\enemyhq_code::safe_activate_trigger_with_targetname, "pre_exit");
  common_scripts\utility::exploder(8);
}

setup_hvt_test() {
  level.start_point = "hvt_rescue";
  maps\enemyhq::setup_common();
}

begin_hvt_test() {
  var_0 = getent("bishop", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai(1);
  var_1 maps\_utility::gun_remove();
  var_1.animname = "bishop";
  level.bishop = var_1;
  var_2 = common_scripts\utility::getstruct("new_hvt_find_struct", "targetname");
  var_2 maps\_anim::anim_first_frame_solo(level.bishop, "find_bishop");
  common_scripts\utility::flag_wait("hvt_done");
}