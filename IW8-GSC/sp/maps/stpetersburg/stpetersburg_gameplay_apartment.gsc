/********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\stpetersburg\stpetersburg_gameplay_apartment.gsc
********************************************************************/

apartment_init() {
  scripts\engine\utility::flag_init("flag_apartment_enforcer_stairs_vignette");
  scripts\engine\utility::flag_init("flag_apartment_enforcer_stairs_vignette_alt");
  scripts\engine\utility::flag_init("flag_apartment_enforcer_blindfire_teleport");
  scripts\engine\utility::flag_init("flag_apartment_price_go_around_corner");
  scripts\engine\utility::flag_init("blindfire_entrance_vignette_start");
  scripts\engine\utility::flag_init("blindfire_entrance_vignette_end");
  scripts\engine\utility::flag_init("blindfire_vignette_end");
  scripts\engine\utility::flag_init("flag_apartment_enforcer_blindfire_end");
  scripts\engine\utility::flag_init("flag_apartment_enforcer_shelf_end");
  scripts\engine\utility::flag_init("flag_apartment_enforcer_obstruct_vignette");
  scripts\engine\utility::flag_init("flag_slide_hint_end");
  scripts\engine\utility::flag_init("flag_apartment_vignette_peek_2");
  scripts\engine\utility::flag_init("flag_apartment_player_at_grenade_door");
  scripts\engine\utility::flag_init("flag_apartment_enforcer_grenade_vignette");
  scripts\engine\utility::flag_init("flag_apartment_grenade_explosion");
  scripts\engine\utility::flag_init("flag_apartment_grenade_aftermath");
  scripts\engine\utility::flag_init("flag_apartment_player_blew_up_civ");
  scripts\engine\utility::flag_init("flag_grenade_backup");
  scripts\engine\utility::flag_init("flag_grenade_bypass");
  scripts\engine\utility::flag_init("flag_apartment_enforcer_grenade_throw");
  scripts\engine\utility::flag_init("flag_apartment_enforcer_window_break");
  scripts\engine\utility::flag_init("flag_apartment_grenade_pickup");
  scripts\engine\utility::flag_init("flag_apartment_grenade_thrown_outside");
  scripts\engine\utility::flag_init("flag_apartment_blockers_idle");
  scripts\engine\utility::flag_init("flag_apartment_player_done_speaking");
  scripts\engine\utility::flag_init("flag_apartment_end");
  precachemodel("body_civ_london_female_4_2");
  precachemodel("head_sc_f_eghbali_hair");
  precachemodel("body_civ_western_girl_4_1");
  precachemodel("head_sc_f_chivikina_child");
}

apartment_main() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::transient_waittill("flag_apartment_enforcer_blindfire_end", "stpetersburg_bar_script_tr", "stpetersburg_canal_script_tr");
  thread apartment_toggle_containment();
  thread apartment_pursuit_timer_handler();
  thread apartment_price_handler();
  thread apartment_enforcer_movement_handler();
  thread apartment_grenade_door_handler();
  thread civilian_stairs_shock_handler();
  thread civilian_stairs_death_handler();
  thread civilians_hallway_flee_handler();
  thread apartment_handsup_civ();
  thread apartment_dying_crawl_civ();
  thread apartment_dead_bodies("apartment_dead_bodies", "flag_canal_player_on_bridge");
  thread apt_hallway_door_setup();
  thread canal_start_watcher();
  thread delete_scriptables_in_bar();
  setsaveddvar("TLOLRMSL", 1);
  scripts\engine\utility::flag_wait("flag_grenade_bypass");
  scripts\engine\utility::flag_set("flag_apartment_end");
}

apartment_pursuit_timer_handler() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::pursuit_timer("flag_apartment_enforcer_stairs_vignette", 20, undefined, 1, undefined, 1);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::pursuit_timer("flag_grenade_backup", 15, "flag_apartment_enforcer_blindfire_end", 0, undefined, 1);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::pursuit_timer("flag_apartment_enforcer_grenade_vignette", 15, undefined, 1, undefined, 1);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::pursuit_timer("flag_apartment_end", 15, "flag_apartment_grenade_explosion", 1, undefined, 1);
}

apartment_price_handler() {
  level.price scripts\engine\utility::disable_pain();
  scripts\engine\utility::flag_clear("blindfire_entrance_vignette_start");
  level.price scripts\engine\utility::set_movement_speed(250);
  scripts\engine\sp\utility::activate_trigger_with_targetname("apartment_price_door");
  var_0 = getnode("apartment_door_price_node", "targetname");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_push_off();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_apartment_price_flank_target();
  level.price scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::color_node_arrive(var_0);
  scripts\engine\utility::flag_wait("flag_apartment_price_go_around_corner");
  var_1 = scripts\engine\utility::getStruct("apartment_entrance_blindfire_target", "targetname");
  level.price scripts\asm\gesture::ai_request_gesture("military_point", var_1);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_push_on();
  level.price.grenadeawareness = 0;
  var_2 = scripts\engine\utility::getStruct("struct_price_flank_path", "targetname");
  level.price thread scripts\sp\spawner::go_to_node(var_2);
  scripts\engine\utility::flag_wait("flag_apartment_player_at_grenade_door");
  var_3 = getnode("price_canal_start_node", "targetname");
  level.price scripts\engine\sp\utility::teleport_ai(var_3);
  level.price scripts\engine\sp\utility::enable_dontevershoot();
  scripts\engine\utility::flag_wait("flag_apartment_enforcer_grenade_vignette");
}

apartment_enforcer_movement_handler() {
  level.enforcer endon("death");

  if(!isDefined(level.enforcer)) {
    return;
  }
  scripts\engine\utility::flag_clear("blindfire_entrance_vignette_end");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enforcer_safe_run();
  var_0 = getEntArray("apartment_door_open", "targetname");
  scripts\engine\utility::array_delete(var_0);
  level.enforcer.oldgoalradius = level.enforcer.goalradius;
  level.enforcer.goalradius = 1;
  scripts\engine\utility::flag_wait("flag_apartment_enforcer_blindfire_teleport");
  thread entrance_blindfire_vignette();
  scripts\engine\utility::flag_wait("flag_apartment_enforcer_stairs_vignette");
  thread aptstairblockers();
  scripts\engine\utility::flag_wait_or_timeout("flag_apartment_enforcer_blindfire_end", 5);
  scripts\engine\utility::flag_set("flag_apartment_enforcer_blindfire_end");
  level.enforcer notify("end_fake_fire");
  level.enforcer.animname = "enforcer";

  if(scripts\engine\utility::flag("flag_bar_street_enforcer_in_apt"))
    level.enforcer scripts\common\anim::anim_single_solo_run(level.enforcer, "sdr_com_exposed_run_exit_2");

  level.enforcer scripts\engine\utility::set_movement_speed(300);
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_apartment_enforcer_hallway_taunt();
  var_1 = scripts\engine\utility::getStruct("apt_struct_enforcer_grenade", "targetname");
  var_1 thread scripts\sp\anim::anim_reach_solo(level.enforcer, "stp_apt_grenade_loop");
  thread aptenforcergrenade();
}

aptenforcerfakefire() {
  level.player endon("death");
  level endon("missionfailed");
  level.enforcer endon("death");
  level.enforcer endon("end_fake_fire");

  for(;;) {
    var_0 = level.enforcer gettagorigin("tag_flash");
    var_1 = level.enforcer gettagangles("tag_flash");

    if(scripts\engine\utility::within_fov(var_0, var_1, level.player getEye(), cos(10))) {
      playFXOnTag(scripts\engine\utility::getfx("vfx_muz_ar_w"), level.enforcer, "tag_flash");
      magicbullet("iw8_ar_akilo47", var_0, level.player getEye() + scripts\engine\utility::randomvectorrange(8, 10), level.enforcer);
      wait 0.1;
    }

    waitframe();
  }
}

entrance_blindfire_vignette() {
  var_0 = scripts\engine\utility::getStruct("apartment_entrance_blindfire_source", "targetname");
  var_1 = scripts\engine\utility::getStruct("apartment_entrance_blindfire_target", "targetname");
  var_2 = scripts\engine\utility::flag_wait_either_return("blindfire_entrance_vignette_end", "blindfire_entrance_vignette_start");

  if(var_2 == "blindfire_entrance_vignette_start") {
    wait 1;
    thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enforcer_blindfire(var_0.origin, var_1.origin, "blindfire_entrance_vignette_end");
  } else
    thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enforcer_blindfire(var_0.origin, var_1.origin, "blindfire_entrance_vignette_start");
}

stairs_blindfire_vignette(var_0) {
  var_1 = scripts\engine\utility::getStruct("apartment_stairs_blindfire_source", "targetname");
  var_2 = scripts\engine\utility::getStruct("apartment_stairs_blindfire_target", "targetname");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enforcer_blindfire(var_1.origin, var_2.origin, "flag_apartment_enforcer_blindfire_end", 5);
  wait 1.5;
  var_0 visiblenotsolid();
}

grenade_handler() {
  level endon("flag_apartment_grenade_explosion");
  level endon("flag_apartment_grenade_pickup");
  thread grenade_backup_handler();
  thread grenade_pickup_handler();
  self waittill("explode", var_0);
  playFX(scripts\engine\utility::getfx("grenade_dirt_explosion"), var_0);
  thread apartment_destruction_grenade_effects(var_0);
  thread apartment_player_grenade_effects(var_0);
  scripts\engine\utility::flag_set("flag_apartment_grenade_explosion");
}

grenade_backup_handler() {
  level endon("flag_apartment_grenade_explosion");
  level endon("flag_apartment_grenade_pickup");
  wait 2.0;
  var_0 = getEnt("grenade_backup_area", "targetname");
  var_1 = getEnt("fallback_end_apartment_exit", "targetname");

  for(;;) {
    if(level.player istouching(var_0) || level.player istouching(var_1)) {
      playFX(scripts\engine\utility::getfx("grenade_dirt_explosion"), level.apt_grenade.origin);
      thread apartment_destruction_grenade_effects(level.apt_grenade.origin);
      thread apartment_player_grenade_effects(level.apt_grenade.origin);
      level.apt_grenade detonate();
      scripts\engine\utility::flag_set("flag_apartment_grenade_explosion");
    }

    wait 0.1;
  }
}

grenade_pickup_handler() {
  level endon("flag_apartment_grenade_explosion");

  for(;;) {
    if(level.player isthrowingbackgrenade()) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("flag_apartment_grenade_pickup");
  level.player waittill("grenade_fire", var_0);
  var_1 = scripts\engine\sp\utility::get_living_ai("apartment_dying_crawl_civ", "targetname");

  if(isDefined(var_1))
    var_1.no_civ_ff_penalty = 1;

  wait 0.2;

  if(isDefined(var_0)) {
    var_2 = getEnt("grenade_shellshock_area", "targetname");

    if(!ispointinvolume(var_0.origin, var_2))
      scripts\engine\utility::flag_set("flag_apartment_grenade_thrown_outside");

    thread apartment_destruction_grenade_effects(var_0.origin);
    thread apartment_player_grenade_effects(var_0.origin);
    var_3 = magicgrenade("frag", var_0.origin + (0, 0, 1), var_0.origin, 0, 0);
    var_0 delete();
  }

  scripts\engine\utility::flag_set("flag_apartment_grenade_explosion");
}

apartment_check_if_grenade_explodes_in_apt() {
  self waittill("explode", var_0);
  var_1 = getEnt("grenade_shellshock_area", "targetname");

  if(ispointinvolume(var_0, var_1))
    playFX(scripts\engine\utility::getfx("grenade_dirt_explosion"), var_0);
  else
    scripts\engine\utility::flag_set("flag_apartment_grenade_thrown_outside");

  thread apartment_player_grenade_effects(var_0);
}

apartment_player_grenade_effects(var_0) {
  level.player endon("death");
  var_1 = getEnt("grenade_shellshock_area", "targetname");
  var_2 = getEnt("fallback_end_apartment_exit", "targetname");
  waitframe();
  var_3 = 20;
  var_4 = scripts\common\utility::getdifficulty();

  if(var_4 == "medium")
    var_3 = 30;
  else if(var_4 == "hard")
    var_3 = 40;
  else if(var_4 == "fu")
    var_3 = 50;

  if(isalive(level.player) && level.player istouching(var_1)) {
    if((scripts\engine\sp\utility::players_within_distance(var_3, var_0) || level.player istouching(var_2)) && !scripts\engine\utility::flag("flag_apartment_grenade_pickup")) {
      level.player.ignorerandombulletdamage = 0;
      level.player scripts\sp\player::killplayer(level.enforcer, "MOD_GRENADE");
    } else {
      if(isDefined(level.enforcer))
        level.player scripts\sp\utility::do_damage(1, var_0, level.enforcer, level.enforcer, "MOD_GRENADE");

      playrumbleonposition("grenade_rumble", var_0);
      earthquake(0.6, 1.0, var_0, 600);

      if(createheadicon(level.player.currentweapon) != "none")
        level.player thread scripts\engine\sp\utility::player_gesture_force("ges_frag_block");
      else
        level.player notify("actionslot 1");
    }

    level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
    scripts\sp\player::player_movement_state("creep");
    level.player allowsprint(0);
    level.player allowjump(0);
    wait 2.0;
    scripts\sp\player::player_movement_state("default");
    level.player scripts\engine\sp\utility::set_player_demeanor("normal");
    level.player allowsprint(1);
    level.player allowjump(1);
  }
}

apartment_destruction_grenade_effects(var_0) {
  scripts\engine\utility::exploder("debris");
  scripts\engine\utility::exploder("force");
  scripts\engine\utility::exploder("papers");
  var_1 = getglassarray("apartment_explosion_glass");

  foreach(var_3 in var_1)
  destroyglass(var_3);

  radiusdamage(var_0, 300, 100, 200, undefined, undefined, undefined, 1);
  var_5 = getscriptablearrayinradius("apt_scriptable", "targetname", var_0, 400);

  foreach(var_7 in var_5)
  var_7 scripts\sp\utility::do_damage(1000, var_0);

  wait 0.1;
  physicsexplosionsphere(var_0, 600, 200, 30);
}

apartment_check_if_grenade_kills_civilian() {
  level endon("flag_canal_player_on_bridge");
  var_0 = getaiarray("neutral");
  scripts\engine\utility::array_thread(var_0, ::check_for_grenade_kill);
  scripts\engine\utility::flag_wait("flag_apartment_player_blew_up_civ");
  thread player_grenade_killed_civ();
}

player_grenade_killed_civ() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_set("disable_autosaves");
  wait 1;
  scripts\sp\player_death::set_custom_death_quote(9);
  thread scripts\sp\utility::missionfailedwrapper();
}

check_for_grenade_kill() {
  self endon("entitydeleted");
  level endon("flag_canal_player_on_bridge");
  self waittill("death", var_0, var_1, var_2);

  if(isDefined(var_2) && getweaponbasename(var_2) == "frag")
    scripts\engine\utility::flag_set("flag_apartment_player_blew_up_civ");
}

apartment_check_if_grenade_goes_out_window() {
  self endon("explode");
  self endon("entitydeleted");
  var_0 = getEnt("apartment_window_ext_vol", "targetname");

  for(;;) {
    if(self istouching(var_0)) {
      break;
    }

    wait 0.1;
  }

  wait 0.1;
  var_1 = self.origin;
  thread apartment_player_grenade_effects(var_1);
  scripts\engine\utility::flag_set("flag_apartment_grenade_thrown_outside");
  scripts\engine\utility::flag_set("flag_apartment_grenade_explosion");
  self detonate();
}

aptenforcergrenade() {
  level.enforcer endon("death");
  scripts\engine\utility::flag_wait("flag_grenade_backup");
  var_0 = scripts\engine\utility::getStruct("apt_struct_enforcer_grenade", "targetname");
  var_0 scripts\common\anim::anim_first_frame_solo(level.enforcer, "stp_apt_grenade_outro");
  scripts\engine\utility::flag_wait("flag_apartment_enforcer_grenade_vignette");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_apartment_enforcer_grenade_taunt();
  var_0 notify("stop_loop");
  waitframe();
  thread apartment_enforcer_grenade_throw();
  thread scripts\engine\utility::flag_set_delayed("flag_apartment_enforcer_grenade_throw", 0.6);
  var_0 scripts\common\anim::anim_single_solo_run(level.enforcer, "stp_apt_grenade_outro");
  var_1 = scripts\engine\utility::getStruct("start_petersburg_canal_enforcer", "targetname");
  level.enforcer scripts\engine\sp\utility::set_goal_pos(var_1.origin);
  level.enforcer scripts\engine\sp\utility::set_goal_radius(16);
  level.enforcer scripts\common\ai::disable_arrivals();
  level.enforcer scripts\common\ai::disable_exits();

  if(!scripts\engine\utility::flag("flag_grenade_bypass"))
    level.enforcer waittill("goal");

  scripts\engine\utility::flag_set("flag_canal_enforcer_on_bridge");
}

apartment_enforcer_grenade_throw() {
  level.player endon("death");
  level endon("missionfailed");
  level.enforcer endon("death");
  level.enforcer.grenadeawareness = 0;
  var_0 = scripts\engine\utility::getStruct("apartment_enforcer_grenade_1_origin", "targetname");
  var_1 = scripts\engine\utility::getStruct("apartment_enforcer_grenade_1_target", "targetname");
  scripts\engine\utility::flag_wait("flag_apartment_enforcer_grenade_throw");
  waitframe();
  scripts\engine\utility::flag_clear("can_save");
  scripts\engine\utility::flag_set("disable_autosaves");
  var_0 = level.enforcer gettagorigin("j_wrist_le");
  var_2 = level.enforcer gettagangles("j_wrist_le");
  var_0 = var_0 + anglesToForward(var_2) * 3;
  level.apt_grenade = magicgrenade("frag", var_0, var_1.origin, 4.0, 1);
  thread audio_grenade_warning();
  waitframe();

  while(!isDefined(level.apt_grenade))
    waitframe();

  level.apt_grenade thread grenade_handler();
  scripts\engine\utility::flag_wait("flag_apartment_grenade_explosion");
  wait 1.2;
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_apartment_price_grenade_aftermath();
  scripts\engine\utility::flag_set("flag_apartment_grenade_aftermath");
  scripts\engine\utility::flag_set("can_save");
  scripts\engine\utility::flag_clear("disable_autosaves");
}

audio_grenade_warning() {
  wait 2.0;

  if(isDefined(level.apt_grenade))
    level.apt_grenade playSound("semtex_warning");
}

apartment_enforcer_glass_break() {
  var_0 = getglass("apartment_enforcer_window_glass");
  destroyglass(var_0);
  wait 0.5;
  deleteglass(var_0);
}

aptstairblockers() {
  var_0 = scripts\engine\utility::getStruct("struct_stairBlocker", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_targetname("civStairBlocker01", 1);
  var_1.animname = "blockCiv01";
  var_1.civ_ff_idle = 1;
  var_2 = scripts\engine\sp\utility::spawn_targetname("civStairBlocker02", 1);
  var_2.animname = "blockCiv02";
  var_2.civ_ff_idle = 1;
  var_3 = [var_1, var_2];
  var_1 thread civilian_stairwell_blocker_handler();
  var_2 thread civilian_stairwell_blocker_handler();
  var_0 thread scripts\common\anim::anim_loop(var_3, "apt_stairs_block_idle", "stop_loop");
  scripts\engine\utility::flag_wait("flag_apartment_end");
  scripts\engine\utility::array_delete(var_3);
}

civilian_stairwell_blocker_handler() {
  var_0 = scripts\engine\utility::getStruct("struct_stairBlocker", "targetname");
  self.allowdeath = 1;
  self.cowering = 0;
  thread scripts\sp\utility::civilianfailwrapper(undefined, undefined, 400);
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::scared_civs_player_looking(var_0);
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::scared_civs_trigger_grenade(var_0);
}

canal_start_watcher() {
  scripts\engine\utility::flag_wait("flag_apartment_end");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vig_script_canal.gsc::canal_vig_start();
}

apartment_grenade_door_handler() {
  level.player endon("death");
  level endon("missionfailed");
  var_0 = scripts\sp\door::get_interactive_door("apartment_grenade_door");
  var_0 scripts\game\sp\door::remove_door_c4_ability();
  var_0.script_max_left_angle = 120;
  var_0.script_max_right_angle = 120;
  var_0 scripts\sp\door::init_max_yaws();
  scripts\engine\sp\utility::trigger_wait_targetname("grenade_apt_door_close_trig");
  var_0.pivot_ent rotateTo((0, 50, 0), 2.5, 0.2, 1.5);
  var_0.disable_bounceback = 1;
  scripts\engine\utility::flag_wait("flag_apartment_player_at_grenade_door");
  scripts\engine\utility::flag_set("flag_apartment_enforcer_grenade_vignette");

  if(level.player issprinting())
    var_0 scripts\sp\door::door_bash_open(level.player);
  else
    var_0 scripts\sp\utility::door_force_open_fully();

  scripts\sp\player::player_movement_state("cqb");
  scripts\engine\utility::flag_wait("flag_apartment_grenade_explosion");
  scripts\sp\player::player_movement_state("default");
}

delete_scriptables_in_bar() {
  wait 3;
  var_0 = getscriptablearray("deletable_stp_bar", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(var_2.model == "" || !isDefined(var_2.model)) {
      continue;
    }
    var_2 hideallparts();
  }
}

civilian_stairs_shock_handler() {
  var_0 = scripts\engine\utility::getStruct("shocked_civ_org", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_targetname("apt_shocked_civ", 1);
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_1.allowdeath = 1;
  var_1 thread scripts\sp\utility::civilianfailwrapper(undefined, undefined, 400);
  var_1.animname = "apt_shocked_civ";
  var_1 setModel("body_civ_london_male_5_1");
  var_1.civ_ff_idle = 1;
  var_1 thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_apartment_civ_shocked();
  var_0 thread scripts\common\anim::anim_loop_solo(var_1, "apt_entrance_hiding", "stop_loop");
  scripts\engine\utility::flag_wait("flag_apartment_enforcer_stairs_vignette");
  var_0 notify("stop_loop");
  var_0 scripts\common\anim::anim_single_solo(var_1, "apt_entrance_react");
  var_0 thread scripts\common\anim::anim_loop_solo(var_1, "apt_entrance_react_idle");
  scripts\engine\utility::flag_wait("flag_apartment_enforcer_grenade_vignette");

  if(isalive(var_1))
    var_1 delete();
}

civilian_stairs_death_handler() {
  scripts\engine\utility::flag_wait("flag_apartment_enforcer_stairs_vignette");
  var_0 = scripts\engine\utility::getStruct("aptStairs_org", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_targetname("apt_stairs_civ01", 1);
  var_1.animname = "apt_stairs_civ01";
  var_1.script_forcespawn = 1;
  var_1.skip_friendly_fire_check = 1;
  var_1 notify("stop_civ_stationary_ff_penalty");
  var_1 notify("stop_civilian_fail_wrapper");
  var_1 setModel("body_civ_london_male_8_1");
  var_1 endon("entitydeleted");
  var_1 endon("death");
  scripts\engine\utility::delaythread(1.0, ::stairs_blindfire_vignette, var_1);
  var_1 thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_apartment_civ_stairs();
  var_0 scripts\common\anim::anim_single_solo(var_1, "apt_stairs_scene");
  var_0 thread scripts\common\anim::anim_loop_solo(var_1, "apt_stairs_scene_idle", "ender");
  wait 0.2;
  var_0 notify("ender");
  var_1.forceragdollimmediate = 1;
  var_1 scripts\engine\sp\utility::anim_stopanimScripted();
  var_1 scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_stop();
  var_1 scripts\engine\sp\utility::set_allowdeath(1);
  var_1 scripts\engine\sp\utility::die();
  wait 0.1;
  var_1.forceragdollimmediate = 1;
  var_1 scripts\engine\sp\utility::anim_stopanimScripted();
  var_1 scripts\engine\sp\utility::set_allowdeath(1);
  var_1 scripts\engine\sp\utility::die();
  scripts\engine\utility::flag_wait("flag_apartment_end");
  var_1 delete();
}

civilians_hallway_flee_handler() {
  var_0 = scripts\engine\utility::getStruct("apt_hallway_civ_flee_org", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_targetname("apt_hallway_flee_parent", 1);
  var_1 setcharmodels("body_civ_stpeterburg_female_3_1", "head_sc_f_eghbali_hair", undefined);
  var_2 = scripts\engine\sp\utility::spawn_targetname("apt_hallway_flee_child", 1);
  var_2 setcharmodels("body_civ_western_girl_4_1", "head_sc_f_chivikina_child", undefined);
  var_3 = [var_1, var_2];
  var_0 scripts\common\anim::anim_first_frame(var_3, "apt_hallway_flee");
  var_1 notify("stop_civ_stationary_ff_penalty");
  var_2 notify("stop_civ_stationary_ff_penalty");
  scripts\engine\sp\utility::trigger_wait_targetname("apt_hallway_civ_flee_trig");

  if(level.player issprinting())
    wait 0.5;
  else
    scripts\engine\sp\utility::trigger_wait_targetname("apt_hallway_civ_flee_slow_trig");

  thread walla_mom_child_hallway(var_1, var_2);
  thread walla_apt_wounded();
  thread walla_man_and_woman_hallway();
  var_1 thread civilians_hallway_flee_single(0);
  var_2 thread civilians_hallway_flee_single(1);
  var_4 = getEnt("apt_hallway_door", "targetname");
  var_0 thread scripts\common\anim::anim_single_solo(var_4, "apt_hallway_flee");
  thread scripts\engine\utility::play_sound_in_space("stp_mom_child_door_open", (52, -1082, 192));
}

setcharmodels(var_0, var_1, var_2) {
  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  self setModel(var_0);

  if(isDefined(var_1) && var_1 != "") {
    self attach(var_1, "", 1);
    self.headmodel = var_1;
  } else
    self.headmodel = undefined;
}

walla_mom_child_hallway(var_0, var_1) {
  wait 0.1;
  var_1 playSound("stp_walla_apt_child_react");
  wait 2.5;

  if(isalive(var_0))
    var_0 playLoopSound("stp_walla_apt_mom_lp");

  wait 1;

  if(isalive(var_1))
    var_1 playLoopSound("stp_walla_apt_child_lp");
}

walla_apt_wounded() {
  var_0 = spawn("script_origin", (-42, -604, 192));
  var_0 playLoopSound("stp_walla_apt_wounded_lp");
  scripts\engine\utility::flag_wait("flag_apartment_grenade_explosion");
  var_0 scripts\engine\sp\utility::sound_fade_and_delete(1, 1);
}

walla_man_and_woman_hallway() {
  thread scripts\engine\utility::play_loopsound_in_space("stp_walla_apt_female_lp", (178, -852, 180));
}

civilians_hallway_flee_single(var_0) {
  var_1 = scripts\engine\utility::getStruct("apt_hallway_civ_flee_org", "targetname");
  self endon("death");
  self endon("entitydeleted");
  self.allowdeath = 1;
  self.skipdeathanim = 1;
  self.diequietly = 1;

  if(!var_0) {
    self notify("stop_civ_stationary_ff_penalty");
    thread scripts\sp\utility::civilianfailwrapper();
    thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_apartment_civ_hallway();
  } else {
    self notify("stop_civ_stationary_ff_penalty");
    thread scripts\sp\utility::civilianfailwrapper([7]);
  }

  var_1 scripts\common\anim::anim_single_solo(self, "apt_hallway_flee");
  var_1 thread scripts\common\anim::anim_loop_solo(self, "apt_hallway_flee_idle", "stop_loop");
  scripts\engine\utility::flag_wait("flag_apartment_end");
  self delete();
}

alive_monitor(var_0, var_1) {
  self waittill("death");

  if(isalive(var_0)) {
    var_1 notify("stop_loop");
    var_0 stopanimScripted();
    var_0.skipdeathanim = 1;
    var_0.diequietly = 1;
    var_0 kill();
  }
}

apt_hallway_door_setup() {
  var_0 = scripts\engine\utility::getStruct("apt_hallway_civ_flee_org", "targetname");
  var_1 = getEnt("apt_hallway_door", "targetname");
  var_1.linked = getEntArray("apt_hallway_door_clip", "targetname");

  foreach(var_3 in var_1.linked)
  var_3 linkTo(var_1);

  var_1 scripts\engine\sp\utility::assign_animtree("apt_hallway_door");
  var_1.og_rot = var_1.angles;
  var_0 scripts\common\anim::anim_first_frame_solo(var_1, "apt_hallway_flee");
  scripts\engine\sp\utility::trigger_wait_targetname("apt_hallway_civ_flee_trig");
  wait 0.8;
  var_0 scripts\common\anim::anim_single_solo(var_1, "apt_hallway_flee");
}

apartment_toggle_containment() {
  scripts\engine\utility::flag_wait("flag_apartment_enforcer_blindfire_end");
  scripts\engine\utility::flag_set("flag_start_apartment_containment");
}

apartment_handsup_civ() {
  scripts\engine\utility::flag_wait("flag_apartment_enforcer_blindfire_end");
  var_0 = scripts\engine\sp\utility::spawn_targetname("apartment_handsup_civ", 1);
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_0.animname = "generic";
  var_0 setModel("body_civ_london_male_8_1");
  var_0 thread scripts\sp\utility::civilianfailwrapper();
  var_0 scripts\engine\sp\utility::set_allowdeath(1);
  var_1 = scripts\engine\utility::getStruct("apartment_handsup_org", "targetname");
  var_1 thread scripts\common\anim::anim_loop_solo(var_0, "apartment_handsup_idle", "end_handsup_idle");
  var_0 scripts\engine\sp\utility::set_deathanim("apartment_handsup_death");
  var_0.diequietly = 1;
  var_0.skipdeathanim = 1;
  scripts\engine\utility::flag_wait("flag_apartment_vignette_peek_2");
  wait 0.5;
  var_0 thread apartment_handsup_civ_mb();
  var_1 notify("end_handsup_idle");
  var_1 scripts\common\anim::anim_single_solo(var_0, "apartment_handsup_death");
  var_0.forceragdollimmediate = 1;
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  var_0 scripts\engine\sp\utility::set_allowdeath(1);
  var_0 scripts\engine\sp\utility::die();
}

apartment_handsup_civ_mb() {
  self endon("death");
  self endon("entitydeleted");
  level.enforcer endon("death");
  wait 0.5;
  var_0 = scripts\engine\utility::getStruct("apartment_enforcer_grenade_1_origin", "targetname");
  magicbullet("iw8_ar_akilo47", var_0.origin, self getEye(), level.enforcer);
  playFXOnTag(scripts\engine\utility::getfx("vfx_blood_hit_01"), self, "tag_eye");
}

apartment_dying_crawl_civ() {
  scripts\engine\utility::flag_wait("flag_apartment_vignette_peek_2");
  var_0 = scripts\engine\sp\utility::spawn_targetname("apartment_dying_crawl_civ", 1);
  var_0.animname = "generic";
  var_0 setModel("body_civ_stpeterburg_female_4_1");
  var_1 = scripts\engine\utility::getStruct("apartment_dying_crawl_org", "targetname");
  var_1 scripts\common\anim::anim_first_frame_solo(var_0, "dying_crawl");
  var_0 scripts\engine\sp\utility::set_deathanim("dying_crawl_shoot_death");
  var_0.diequietly = 1;
  var_0 scripts\engine\sp\utility::set_allowdeath(1);
  var_0 thread apartment_dying_crawl_civ_kill();
  scripts\engine\utility::flag_wait("flag_apartment_enforcer_grenade_vignette");
  var_1 scripts\common\anim::anim_single_solo(var_0, "dying_crawl");
  var_0 kill();
}

apartment_dying_crawl_civ_kill() {
  self endon("death");
  scripts\engine\utility::flag_wait("flag_apartment_grenade_explosion");

  if(scripts\engine\utility::flag("flag_apartment_grenade_thrown_outside")) {
    scripts\engine\sp\utility::set_deathanim("dying_crawl_death");
    wait 1;
    self kill();
  } else
    self kill();
}

apartment_dead_bodies(var_0, var_1) {
  level.enforcer endon("death");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::setup_dead_bodies(var_0, var_1);
  scripts\engine\utility::flag_wait("flag_apartment_vignette_peek_2");
  var_2 = scripts\engine\utility::getStruct("apartment_enforcer_grenade_1_origin", "targetname");
  var_3 = getspawnerarray(var_0);
  var_4 = getcompleteweaponname("iw8_ar_akilo47");
  var_5 = weaponfiretime(var_4);

  foreach(var_7 in var_3) {
    magicbullet("iw8_ar_akilo47", var_2.origin, var_7.origin + scripts\engine\utility::randomvectorrange(1, 5), level.enforcer);
    wait(var_5 * 0.5);
    magicbullet("iw8_ar_akilo47", var_2.origin, var_7.origin + scripts\engine\utility::randomvectorrange(1, 5), level.enforcer);
    wait(var_5 * 0.5);
  }
}