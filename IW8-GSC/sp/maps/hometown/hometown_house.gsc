/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\hometown\hometown_house.gsc
***********************************************/

house_boss_skip_fight_hide_intro() {
  level.boss_skip_fight_overlay fadeovertime(1.0);
  level.boss_skip_fight_overlay.alpha = 0;
  level.boss_skip_fight_intro fadeovertime(1.0);
  level.boss_skip_fight_intro.alpha = 0;
  wait 1;
  level.boss_skip_fight_overlay scripts\sp\hud_util::destroyelem();
  level.boss_skip_fight_intro scripts\sp\hud_util::destroyelem();
  level.player freezecontrols(0);
}

house_boss_skip_fight_show_intro() {
  level.boss_skip_fight_overlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  level.boss_skip_fight_overlay.foreground = 0;
  level.boss_skip_fight_intro = scripts\sp\hud_util::createfontstring("default", 1.8);
  level.boss_skip_fight_intro settext(&"HOMETOWN/BOSS_KILLED");
  level.boss_skip_fight_intro scripts\sp\hud_util::setpoint("CENTER", undefined, 0, -90);
  level.boss_skip_fight_intro.alpha = 0;
  level.boss_skip_fight_intro.foreground = 1;
  level.player freezecontrols(1);
  level.boss_skip_fight_overlay fadeovertime(2.0);
  level.boss_skip_fight_overlay.alpha = 1.0;
  level.boss_skip_fight_intro fadeovertime(2.0);
  level.boss_skip_fight_intro.alpha = 1.0;
  wait 2;
}

house_exit_skip_boss_fight_catchup() {
  scripts\engine\sp\utility::set_start_location("house_exit_start", [level.player]);
  var_0 = scripts\engine\utility::getStructArray("boss_struggle_loc_" + level.player get_current_house_room(), "script_noteworthy");
  level.boss_struggle_anim_node = scripts\engine\utility::getclosest(level.player.origin, var_0);
  level.boss_kill_sling_model = scripts\engine\sp\utility::spawn_anim_model("boss_kill_sling", level.boss_struggle_anim_node.origin, level.boss_struggle_anim_node.angles);
  level.gas_attack_anim_node = getEnt("gas_attack_street_node", "script_noteworthy");
  level.father_body_model = scripts\engine\sp\utility::spawn_anim_model("farah_father_body", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  thread dad_procedural_bones();
  level.father_body_model attach("head_hero_farahs_father");
  level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.father_body_model, "house_dad_dead_frame");
  level.player giveweapon("iw8_gunless_farrah");
  level.player switchtoweaponimmediate("iw8_gunless_farrah");
  level.current_knife_weapon = level.player getcurrentweapon();
  level.current_knife_weapon_string = level.current_knife_weapon.basename;
  level.hadir_body_model delete();
  scripts\sp\maps\hometown\hometown_util.gsc::spawn_hadir();
  level.hadir_ai attach("hat_waist_child_hadir_gas_mask", "J_Proc_SpineLower_Swivel");
  level.hadir_ai setModel("body_hero_hadir_child");
  level.farah_father_ai scripts\sp\maps\hometown\hometown_util.gsc::kill_and_delete_quietly(level.goliath_ai);
  level.goliath_ai scripts\sp\maps\hometown\hometown_util.gsc::kill_and_delete_quietly(level.player);
  level notify("boss_dying");
  level notify("lantern_break");
  scripts\engine\utility::flag_set("lantern_smoke");
  scripts\engine\utility::flag_set("lighting_house_exit_start");
}

house_enter_main() {
  thread scripts\sp\maps\hometown\hometown_util.gsc::transient_unload_carried();
  thread house_enter_trigger_monitor();
  thread audio_distant_gas_death_scream_handler();
  scripts\engine\utility::stop_exploder("bigsmoke");
  level notify("house_entered");
  scripts\engine\utility::flag_set("objective_entered_house_complete");
  scripts\engine\utility::flag_set("lighting_house_enter_progression");
  setsaveddvar("OMNONNMOTP", "0.1 400 2.25 1000");
  level.player scripts\common\utility::allow_melee(1);
  level.dead_dad_blocker = getEnt("dead_dad_blocker", "script_noteworthy");
  level.dead_dad_blocker scripts\engine\sp\utility::hide_entity();
  level.dead_dad_blocker_hadir = getEnt("dead_dad_blocker_hadir", "script_noteworthy");
  level.dead_dad_blocker_hadir scripts\engine\sp\utility::hide_entity();
  level.dead_boss_blocker = getEnt("dead_boss_blocker", "script_noteworthy");
  level.dead_boss_blocker scripts\engine\sp\utility::hide_entity();
  level.dead_boss_blocker_use = getEnt("dead_boss_blocker_use", "script_noteworthy");
  level.dead_boss_blocker_use scripts\engine\sp\utility::hide_entity();
  thread audio_house_enter_music();
  thread goliath_stab_model_swap_monitor();
  scripts\engine\utility::exploder("window_gas");
  visionsetnaked("hometown_house_int", 0.1);
  thread scripts\sp\analytics::analytics_kleenex_update("House Enter to House Boss Start");
  thread scripts\sp\maps\hometown\hometown_vo.gsc::house_enter_start_vo();
  scripts\sp\maps\hometown\hometown_util.gsc::spawn_hadir();
  level.hadir_body_model = scripts\engine\sp\utility::spawn_anim_model("hadir_body", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  level.hadir_body_model hide();
  thread hadir_procedural_bones();
  level.hadir_body_model attach("head_sc_m_coto");
  level.hadir_body_model.fakeactor_face_anim = 1;
  level.hadir_body_model.animationarchetype = "soldier";
  var_0 = scripts\engine\sp\utility::spawn_anim_model("house_intro_pack", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var_1 = scripts\engine\sp\utility::spawn_anim_model("house_intro_mask", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var_2 = scripts\engine\sp\utility::spawn_anim_model("house_intro_photo", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var_3 = scripts\engine\sp\utility::spawn_anim_model("house_intro_lantern", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var_4 = scripts\engine\sp\utility::spawn_anim_model("house_intro_cupboard", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var_5 = scripts\engine\sp\utility::spawn_anim_model("house_intro_cupboard_b", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var_6 = scripts\engine\sp\utility::spawn_anim_model("house_intro_HadirPhone", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  level.house_intro_phone_farah_model = scripts\engine\sp\utility::spawn_anim_model("house_intro_FarahPhone", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var_7 = scripts\engine\sp\utility::spawn_anim_model("house_intro_bottle", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var_8 = scripts\engine\sp\utility::spawn_anim_model("house_intro_dresser", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var_9 = scripts\engine\sp\utility::spawn_anim_model("house_intro_hutch", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var_10 = scripts\engine\sp\utility::spawn_anim_model("house_intro_vase", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var_11 = scripts\engine\sp\utility::spawn_anim_model("house_intro_towel", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  level thread lantern_fire(var_3);
  level.hadir_body_model makefakeai();
  level.hadir_body_model.health = 100;
  var_0 scriptmoverdistancefade();
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player allowstand(1);
  thread phone_table_interact(var_2, var_3, var_7, var_8, var_9, var_10, var_4, var_5, var_6, var_0, var_1);
  wait 36.0;
  scripts\engine\utility::flag_set("objective_prepare_to_escape");
  thread ambient_house_enter_explosions();
  var_12 = scripts\engine\utility::spawn_tag_origin(level.house_intro_phone_farah_model.origin);
  var_12 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"HOMETOWN/CELLPHONE", 75, 175, 50, 0);
  var_12 waittill("trigger");
  level notify("player_got_phone");
  var_12 delete();
  level.dad_phone_blocker = getEnt("dad_phone_blocker", "script_noteworthy");
  level.dad_phone_blocker scripts\engine\sp\utility::hide_entity();
  level notify("kill_random_explos");
  level.dead_dad_blocker scripts\engine\sp\utility::show_entity();
  var_13 = scripts\engine\utility::getStruct("dad_dead_blocker_wall_loc", "script_noteworthy");
  var_14 = level.dead_dad_blocker.origin;
  level.dead_dad_blocker.origin = var_13.origin;
  level.gas_attack_anim_node notify("stop_loop");
  level.gas_attack_anim_node notify("stop_play_anim_and_then_loop");
  thread player_phone_pickup_anim();
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util.gsc::play_anim_and_delete(var_2, "SceneB_Phones");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util.gsc::play_anim_and_delete(var_6, "SceneB_Phones");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util.gsc::play_anim_and_delete(level.house_intro_phone_farah_model, "SceneB_Phones");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util.gsc::play_anim_and_then_loop(var_0, "SceneB_Phones", "house_foyer_idle");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util.gsc::play_anim_and_then_loop(var_1, "SceneB_Phones", "house_foyer_idle");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util.gsc::play_anim_and_then_loop(level.farah_father_ai, "SceneB_Phones", "house_foyer_idle");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util.gsc::play_anim_and_then_loop(level.hadir_ai, "SceneB_Phones", "house_foyer_idle");
  level.gas_attack_anim_node scripts\sp\maps\hometown\hometown_util.gsc::play_anim_and_then_loop(level.hadir_body_model, "SceneB_Phones", "house_foyer_idle");
  thread ambient_house_enter_explosions();
  level notify("waiting_in_foyer");
  scripts\engine\utility::flag_wait("player_went_to_foyer");
  waitframe();
  thread audio_truck_passby_ext();
  level notify("kill_random_explos");
  thread late_foyer_save();
  thread boss_enter_anim_monitor();
  level.player.ignoreme = 1;
  scripts\sp\maps\hometown\hometown_util.gsc::spawn_goliath_boss();
  scripts\engine\utility::flag_set("russian_entered_house");
  thread house_enter_goliath_kill(var_0);
  level thread scripts\sp\utility::context_melee_enable(1);
  level.goliath_melee_weapon_spawn_count = 0;
  level.player thread goliath_player_death_monitor();
  level thread goliath_round_monitor();
  level thread goliath_knife_monitor();
  level thread goliath_player_location_monitor();
  level thread goliath_struggle();
  level.hadir_melee_weapon_pickup = scripts\engine\sp\utility::spawn_anim_model("house_intro_knife", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  thread audio_house_boss_enter_music();
  level thread lantern_listener();
  thread dad_dies_fight_hits();
  thread dad_dies_fight_hits_hadir();
  thread vfx_doorgas();
  thread boss_stream_pos();
  thread dad_shot_by_boss_listener();
  thread hide_bottle_monitor(var_7);
  thread hadir_helps_dad_monitor();
  thread goliath_sees_player_monitor();
  level notify("dad_dies_start");
  level.gas_attack_anim_node notify("stop_loop");
  level.gas_attack_anim_node notify("stop_play_anim_and_then_loop");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(var_0, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(var_1, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(var_3, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(level.hadir_melee_weapon_pickup, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(level.farah_father_ai, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(level.gas_attack_house_door_model, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(level.goliath_ai, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(level.house_intro_deadbolt_model, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(var_7, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(var_8, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(var_9, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(var_10, "house_dad_dies");
  level.dead_dad_blocker scripts\engine\utility::delaycall(38.0, ::moveto, var_14, 5.0);
  thread hadir_dad_dies_scene();
  thread shelf_monitor();

  if(scripts\sp\maps\hometown\hometown_util.gsc::skipchildrenkillingscene()) {
    level waittill("fight_hit_hadir");
    level waittill("fight_hit_hadir");
    level notify("house_enter_boss_anim_complete");
    level notify("goliath_boss_dead");
    wait 2.5;
    house_boss_skip_fight_show_intro();
    var_0 scripts\engine\sp\utility::anim_stopanimScripted();
    var_1 scripts\engine\sp\utility::anim_stopanimScripted();
    var_3 scripts\engine\sp\utility::anim_stopanimScripted();
    level.hadir_melee_weapon_pickup scripts\engine\sp\utility::anim_stopanimScripted();
    level.farah_father_ai scripts\engine\sp\utility::anim_stopanimScripted();
    level.hadir_ai scripts\engine\sp\utility::anim_stopanimScripted();
    level.hadir_body_model scripts\engine\sp\utility::anim_stopanimScripted();
    level.gas_attack_house_door_model scripts\engine\sp\utility::anim_stopanimScripted();
    level.goliath_ai scripts\engine\sp\utility::anim_stopanimScripted();
    level.house_intro_deadbolt_model scripts\engine\sp\utility::anim_stopanimScripted();
    var_7 scripts\engine\sp\utility::anim_stopanimScripted();
    var_8 scripts\engine\sp\utility::anim_stopanimScripted();
    var_9 scripts\engine\sp\utility::anim_stopanimScripted();
    var_10 scripts\engine\sp\utility::anim_stopanimScripted();
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(var_0, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(var_1, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(var_3, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.hadir_melee_weapon_pickup, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.farah_father_ai, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.hadir_ai, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.hadir_body_model, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.gas_attack_house_door_model, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.goliath_ai, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.house_intro_deadbolt_model, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(var_7, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(var_8, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(var_9, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(var_10, "house_dad_dies");
    level.goliath_ai stopsounds();
    level.farah_father_ai stopsounds();
    waitframe();
    house_exit_skip_boss_fight_catchup();
    wait 4;
    level thread house_boss_skip_fight_hide_intro();
  } else {
    var_15 = getanimlength(level.scr_anim["generic"]["house_dad_dies"]);
    wait(var_15);
  }

  level notify("house_enter_boss_anim_complete");
  level.hadir_melee_weapon_pickup delete();
  var_1 delete();
  level.player.ignoreme = 0;
  level.player_got_dad_dies_save = 0;

  if(!isDefined(level.goliath_ai.player_seen_pos) || distancesquared(level.goliath_ai.player_seen_pos, level.player.origin) > 1024) {
    if(!level.player istouching(getEnt("foyer_dad_dies_scene_trigger", "script_noteworthy"))) {
      if(!scripts\engine\utility::flag("disable_autosaves")) {
        thread scripts\engine\sp\utility::autosave_now();
        level.player_got_dad_dies_save = 1;
      }
    }
  }

  if(!level.player_got_dad_dies_save)
    thread house_dad_dies_late_save();
}

hadir_dad_dies_scene() {
  level.player endon("grabbed_by_boss");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(level.hadir_ai, "house_dad_dies");
  level.gas_attack_anim_node scripts\common\anim::anim_single_solo(level.hadir_body_model, "house_dad_dies");
  level.hadir_ai delete();
  level.hadir_body_model show();
}

house_dad_dies_late_save() {
  wait 15.0;

  if(distancesquared(level.goliath_ai.origin, level.player.origin) > 10000) {
    if(!level.goliath_ai[[level.goliath_ai.fnisinstealthcombat]]()) {
      if(!scripts\engine\utility::flag("disable_autosaves"))
        scripts\engine\sp\utility::autosave_by_name();
    }
  }
}

hide_bottle_monitor(var_0) {
  wait 38.25;
  var_0 hide();
}

late_foyer_save() {
  wait 10.0;

  if(!scripts\engine\utility::flag("disable_autosaves"))
    thread scripts\engine\sp\utility::autosave_now();

  wait 7.0;
  scripts\engine\utility::flag_set("russian_entered_house_objective");
}

hadir_helps_dad_monitor() {
  wait 31.0;
  level.hadir_body_model scriptmoverdistancefade();
  var_0 = 1296;

  if(distancesquared(level.goliath_ai.origin, level.player.origin) > var_0) {
    if(!scripts\engine\utility::flag("disable_autosaves"))
      scripts\engine\sp\utility::autosave_now_silent();
  }

  wait 3.0;
  level.hadir_body_model scriptmoverdistancefade();
}

dad_shot_by_boss_listener() {
  level waittill("dad_shot_by_boss");
  level.farah_father_ai setModel("body_hero_farahs_father_bloody");
  level.farah_father_ai playRumbleOnEntity("heavy_3s");
}

vfx_doorgas() {
  wait 17;
  scripts\engine\utility::exploder("doorgas");
}

goliath_sees_player_monitor() {
  level endon("house_enter_boss_anim_complete");

  for(;;) {
    waitframe();

    if(level.goliath_ai cansee(level.player))
      level.goliath_ai.player_seen_pos = level.player.origin;
  }
}

audio_house_enter_music() {
  wait 0.1;
  setmusicstate("");
  wait 2.0;
  setmusicstate("mx_hometown_04_house_lp");
}

audio_house_boss_enter_music() {
  wait 4.0;
  setmusicstate("mx_hometown_05_house_fight");
}

phone_table_interact(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  level.gas_attack_anim_node notify("stop_loop");
  level.gas_attack_anim_node notify("stop_play_anim_and_then_loop");
  thread audio_door_slam_shut();
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(var_0, "SceneB_Phones");
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(var_1, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(level.house_intro_deadbolt_model, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(var_2, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(var_3, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(var_4, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(var_5, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util.gsc::spawn_thing_play_anim_and_delete("house_intro_towel", "house_find_hadir");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util.gsc::spawn_thing_play_anim_and_delete("house_intro_prop01", "house_get_mask_kitchen");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util.gsc::spawn_thing_play_anim_and_delete("house_intro_prop02", "house_get_mask_kitchen");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util.gsc::spawn_thing_play_anim_and_delete("house_intro_prop03", "house_get_mask_kitchen");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(var_6, "house_get_mask_kitchen");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(var_7, "house_get_mask_kitchen");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(level.gas_attack_house_door_model, "house_find_hadir");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(var_8, "house_find_hadir");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(level.house_intro_phone_farah_model, "house_find_hadir");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util.gsc::play_anim_and_then_loop(var_9, "house_find_hadir", "house_find_hadir_idle");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util.gsc::play_anim_and_then_loop(var_10, "house_find_hadir", "house_find_hadir_idle");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util.gsc::play_anim_and_then_loop(level.farah_father_ai, "house_find_hadir", "house_find_hadir_idle");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util.gsc::play_anim_and_then_loop(level.hadir_ai, "house_find_hadir", "house_find_hadir_idle");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util.gsc::play_anim_and_then_loop(level.hadir_body_model, "house_find_hadir", "house_find_hadir_idle");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(level.house_intro_deadbolt_model, "SceneB_Phones");
}

audio_door_slam_shut() {
  wait 1.5;
  thread scripts\engine\utility::play_sound_in_space("htf_ff_hf_010_sceneb_door_01", (-1300, -2494, 62));
}

audio_distant_gas_death_scream_handler() {
  level waittill("house_entered");
  thread audio_distant_gas_death_screams_01();
  thread audio_distant_gas_death_screams_02();
  thread audio_distant_gas_death_screams_03();
}

audio_distant_gas_death_screams_01() {
  var_0 = randomfloatrange(2.0, 12.0);
  wait(var_0);
  level endon("death");
  var_1 = spawn("script_origin", (-581, -2769, 95));
  level.death_01_snd_handle = undefined;

  for(;;) {
    if(!isDefined(level.death_01_snd_handle))
      level.death_01_snd_handle = scripts\engine\utility::play_sound_in_space("emt_dist_death_screams", (-581, -2769, 95), 0, var_1);

    if(scripts\engine\utility::flag("russian_entered_house")) {
      if(isDefined(level.death_01_snd_handle))
        level.death_01_snd_handle thread scripts\engine\sp\utility::sound_fade_and_delete(5);

      break;
    }

    var_2 = randomfloatrange(15.0, 25.0);
    wait(var_2);
    level.death_01_snd_handle = undefined;
  }

  var_1 delete();
  var_1 = undefined;

  if(isDefined(level.death_01_snd_handle))
    level.death_01_snd_handle = undefined;
}

audio_distant_gas_death_screams_02() {
  var_0 = randomfloatrange(2.0, 12.0);
  wait(var_0);
  level endon("death");
  var_1 = spawn("script_origin", (-689, -1618, 74));
  level.death_02_snd_handle = undefined;

  for(;;) {
    if(!isDefined(level.death_02_snd_handle))
      level.death_02_snd_handle = scripts\engine\utility::play_sound_in_space("emt_dist_death_screams", (-689, -1618, 74), 0, var_1);

    if(scripts\engine\utility::flag("russian_entered_house")) {
      if(isDefined(level.death_02_snd_handle))
        level.death_02_snd_handle thread scripts\engine\sp\utility::sound_fade_and_delete(5);

      break;
    }

    var_2 = randomfloatrange(15.0, 25.0);
    wait(var_2);
    level.death_02_snd_handle = undefined;
  }

  var_1 delete();
  var_1 = undefined;

  if(isDefined(level.death_02_snd_handle))
    level.death_02_snd_handle = undefined;
}

audio_distant_gas_death_screams_03() {
  var_0 = randomfloatrange(2.0, 12.0);
  wait(var_0);
  level endon("death");
  var_1 = spawn("script_origin", (-1843, -1419, 121));
  level.death_03_snd_handle = undefined;

  for(;;) {
    if(!isDefined(level.death_03_snd_handle))
      level.death_03_snd_handle = scripts\engine\utility::play_sound_in_space("emt_dist_death_screams", (-1843, -1419, 121), 0, var_1);

    if(scripts\engine\utility::flag("russian_entered_house")) {
      if(isDefined(level.death_03_snd_handle))
        level.death_03_snd_handle thread scripts\engine\sp\utility::sound_fade_and_delete(5);

      break;
    }

    var_2 = randomfloatrange(15.0, 25.0);
    wait(var_2);
    level.death_03_snd_handle = undefined;
  }

  var_1 delete();
  var_1 = undefined;

  if(isDefined(level.death_03_snd_handle))
    level.death_03_snd_handle = undefined;
}

shelf_monitor() {
  level waittill("shelf_broken");
  playmayhem("mayhem_shelf_model");
}

player_phone_pickup_anim() {
  var_0 = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  scripts\engine\utility::flag_set("lighting_cellphone_moment");
  level.player_rig = var_0;
  level.gas_attack_anim_node thread scripts\sp\player_rig::link_player_to_rig("SceneB_Phones", "stand", 1, 0.5, 1);
  level.gas_attack_anim_node scripts\common\anim::anim_single_solo(var_0, "SceneB_Phones");
  scripts\sp\player_rig::unlink_player_from_rig(0, "stand");
  level.door_clip_boss_enter solid();
  waitframe();
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player allowstand(1);
}

lantern_listener() {
  level waittill("lantern_break");
  scripts\engine\utility::flag_set("lantern_break");
}

lantern_fire(var_0) {
  playFXOnTag(level._effect["vfx_htown_lantern_flame"], var_0, "tag_origin");
  scripts\engine\utility::flag_wait("lantern_break");
  wait 0.1;
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, anglesToForward(var_0.angles) * -1.0);
  thread sfx_lantern_fire(var_0.origin);
  thread lanter_fire_damage(var_0);
  stopFXOnTag(level._effect["vfx_htown_lantern_flame"], var_0, "tag_origin");
  playFXOnTag(level._effect["vfx_htown_lantern_fire"], var_1, "tag_origin");
  thread scripts\engine\utility::exploder("wallfire");
  thread scripts\engine\utility::exploder("ceilingsmoke");
  visionsetnaked("hometown_house_int_postfire", 10);
  scripts\engine\utility::flag_wait("lantern_smoke");
  scripts\engine\utility::flag_wait("lantern_spawned");
  stopFXOnTag(level._effect["vfx_htown_lantern_fire"], var_1, "tag_origin");
  scripts\engine\utility::stop_exploder("wallfire");
  thread scripts\engine\utility::exploder("wallfire_post");
  scripts\engine\utility::stop_exploder("ceilingsmoke");
  level.lantern_fire_trigger delete();
}

lanter_fire_damage(var_0) {
  wait 1.0;
  scripts\engine\utility::flag_set("lantern_spawned");
  var_1 = 5;
  var_2 = 10;
  var_3 = var_0.origin - (12, 0, 0);
  level.lantern_fire_trigger = spawn("trigger_radius_fire", var_3, 0, var_1, var_2);
  level.lantern_fire_trigger.script_damage = 5;
  thread scripts\sp\trigger::trigger_fire(level.lantern_fire_trigger);
}

sfx_lantern_fire(var_0) {
  var_1 = spawn("script_origin", (-1349, -2571, 51));
  var_1 playSound("scn_hometown_lantern_fire_ignite");
  wait 1;
  var_1 playLoopSound("scn_hometown_lantern_fire_lp");
  scripts\engine\utility::flag_wait("lantern_smoke");
  var_1 playLoopSound("scn_hometown_lantern_fire_smolder_lp");
}

house_enter_goliath_kill(var_0) {
  level endon("house_enter_boss_anim_complete");
  var_1 = 576;

  for(;;) {
    waitframe();

    if(distancesquared(level.goliath_ai.origin, level.player.origin) > var_1) {
      continue;
    }
    var_2 = 5;
    var_3 = 60;
    var_4 = (0, 0, 5);

    if(!scripts\engine\trace::capsule_trace_passed(level.player.origin + var_4, level.goliath_ai.origin + var_4, var_2, var_3, level.player.angles, [level.player, level.goliath_ai])) {
      continue;
    }
    level.player notify("grabbed_by_boss");
    level.player notify("house_enter_grabbed_by_boss");
    level.player scripts\sp\player\context_melee::disable_dynamic_takedowns();
    level.player scripts\common\utility::allow_melee(0);
    level.player lerpfovscalefactor(0, 0.5);
    scripts\engine\utility::flag_set("disable_autosaves");

    if(isDefined(level.hadir_melee_weapon_pickup))
      level.hadir_melee_weapon_pickup delete();

    var_5 = "boss_capture_";
    var_6 = scripts\engine\math::get_dot(level.player.origin, level.player.angles, level.goliath_ai.origin);

    if(var_6 >= 0.5)
      var_5 = var_5 + "front";
    else if(var_6 <= -0.5)
      var_5 = var_5 + "back";
    else {
      var_6 = vectordot(vectorNormalize(level.goliath_ai.origin - level.player.origin), anglestoright(level.player.angles));

      if(var_6 > 0)
        var_5 = var_5 + "right";
      else
        var_5 = var_5 + "left";
    }

    var_7 = scripts\engine\utility::spawn_script_origin(level.goliath_ai.origin, vectortoangles(level.player.origin - level.goliath_ai.origin));

    if(level.player istouching(getEnt("boss_grab_near_door_trigger", "script_noteworthy"))) {
      var_8 = scripts\engine\utility::getStruct("anim_preview_loc_4", "targetname");
      var_7 moveTo(var_8.origin, 1.0);
    }

    thread kill_dad(var_0);
    thread kill_hadir();
    thread goliath_strangle_effects_capture();
    thread house_enter_animate_and_kill_player(var_7, var_5);
    return;
  }
}

house_enter_animate_and_kill_player(var_0, var_1) {
  level.player_rig = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig", level.player.origin, level.player.angles);
  var_0 scripts\sp\player_rig::link_player_to_rig(var_1, "stand", 1, 0.2, 0, 5, 5, 5, 5, 1);
  var_0 thread scripts\common\anim::anim_single([level.goliath_ai, level.player_rig], var_1);
  level scripts\sp\player_death::set_custom_death_quote(78);
  wait 3;
  scripts\sp\utility::missionfailedwrapper();
}

kill_dad(var_0) {
  wait 1.0;

  if(isDefined(var_0))
    var_0 hide();

  if(isDefined(level.farah_father_ai)) {
    level.farah_father_ai.skipdeathanim = 1;
    level.farah_father_ai scripts\engine\sp\utility::anim_stopanimScripted();
    level.farah_father_ai scripts\common\ai::stop_magic_bullet_shield();
    level.farah_father_ai.diequietly = 1;
    waitframe();
    level.farah_father_ai kill(level.farah_father_ai.origin, level.goliath_ai);
  }
}

kill_hadir() {
  wait 1.0;

  if(isDefined(level.hadir_ai)) {
    level.hadir_ai.skipdeathanim = 1;
    level.hadir_ai scripts\engine\sp\utility::anim_stopanimScripted();
    level.hadir_ai scripts\common\ai::stop_magic_bullet_shield();
    level.hadir_ai.diequietly = 1;
    waitframe();
    level.hadir_ai kill(level.hadir_ai.origin, level.goliath_ai);
  }
}

house_enter_trigger_monitor() {
  scripts\engine\sp\utility::trigger_wait("kitchen_gas_mask_scene_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("player_went_to_kitchen");
  scripts\engine\sp\utility::trigger_wait("foyer_dad_dies_scene_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("player_went_to_foyer");
}

house_boss_main() {
  level thread scripts\sp\utility::context_melee_enable(1);
  setsaveddvar("OMNONNMOTP", "0.1 400 2.25 1000");
  level.current_knock_off = "drop_all";
  thread scripts\sp\maps\hometown\hometown_util.gsc::goliath_delete_weapon_interacts_monitor();
  thread goliath_blood_stab_vfx();
  thread weapon_knock_off_room_monitor();
  thread scripts\sp\maps\hometown\hometown_util.gsc::search_ground_hint();
  thread goliath_swipe_awareness();
  setsaveddvar("TMTPTQNMN", 1);
  setmusicstate("mx_hometown_06_house_evade_01_lp");
  thread scripts\sp\analytics::analytics_kleenex_update("House Boss Start to First Stab");
  level.father_body_model = scripts\engine\sp\utility::spawn_anim_model("farah_father_body", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  thread dad_procedural_bones();
  level.father_body_model attach("head_hero_farahs_father");
  level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.father_body_model, "house_dad_dead_frame");

  if(isDefined(level.hadir_ai))
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.hadir_ai, "house_dad_dead_frame");

  level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.hadir_body_model, "house_dad_dead_frame");
  waitframe();
  scripts\common\anim::anim_set_time([level.father_body_model, level.hadir_body_model], "house_dad_dead_frame", 1.0);

  if(isDefined(level.hadir_ai))
    scripts\common\anim::anim_set_time([level.hadir_ai], "house_dad_dead_frame", 1.0);

  thread scripts\sp\maps\hometown\hometown_vo.gsc::house_boss_start_vo();
  level notify("dad_stabbed_chest");

  if(isDefined(level.hadir_ai))
    level.hadir_ai delete();

  level.hadir_body_model show();
  level.hadir_body_model notsolid();
  level.father_body_model notsolid();

  if(isDefined(level.farah_father_ai))
    level.farah_father_ai scripts\sp\maps\hometown\hometown_util.gsc::kill_and_delete_quietly(level.goliath_ai);

  var_0 = scripts\engine\utility::getStruct("buried_start", "targetname");
  waitframe();
  thread house_boss_analytics();
  level thread goliath_investigate();
  scripts\engine\utility::flag_set("objective_find_a_weapon");

  if(isDefined(level.goliath_ai.player_seen_pos) && distancesquared(level.goliath_ai.player_seen_pos, level.player.origin) < 1024) {
    level.goliath_ai aieventlistenerevent("combat", level.player, level.player.origin);
    level.goliath_ai.player_seen_pos = undefined;
  }

  level waittill("goliath_boss_dead");
  setsaveddvar("TMTPTQNMN", 0);
  level.goliath_ai scripts\sp\maps\hometown\hometown_util.gsc::kill_and_delete_quietly(level.player);
  scripts\sp\maps\hometown\hometown_util.gsc::clear_goliath_bloody_footsteps();
  thread scripts\engine\sp\utility::autosave_by_name("boss_dead");
}

boss_stream_pos() {
  var_0 = scripts\engine\utility::getStruct("boss_stream_pos", "script_noteworthy");
  wait 0.1;
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("body_russian_soldier_boss_stab_1_chest_dad");
  wait 0.1;
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel("body_russian_soldier_boss_stab_2_leg_l_back");
  wait 0.1;
  var_3 = spawn("script_model", var_0.origin);
  var_3 setModel("body_russian_soldier_boss_stab_3_leg_r_back");
  wait 0.1;
  var_4 = spawn("script_model", var_0.origin);
  var_4 setModel("body_russian_soldier_boss_stab_4_neck");
  wait 0.1;
  var_5 = spawn("script_model", var_0.origin);
  var_5 setModel("body_russian_soldier_boss_stab_5_chest_a");
  wait 0.1;
  var_6 = spawn("script_model", var_0.origin);
  var_6 setModel("body_russian_soldier_boss_stab_6_chest_b");
  wait 0.1;
  var_7 = spawn("script_model", var_0.origin);
  var_7 setModel("body_russian_soldier_boss_stab_7_chest_c");
  wait 0.1;
  var_8 = spawn("script_model", var_0.origin);
  var_8 setModel("body_russian_soldier_boss_stab_8_chest_d");
  wait 0.1;
  var_9 = spawn("script_model", var_0.origin);
  var_9 setModel("body_russian_soldier_boss_stab_9_gunshots");
  wait 0.1;
  var_10 = spawn("script_model", var_0.origin);
  var_10 setModel("body_hero_farahs_father_bloody");
  wait 0.1;
  level waittill("goliath_boss_dead");
}

house_boss_analytics() {
  level.goliath_ai waittill("start_context_melee");
  thread scripts\sp\analytics::analytics_kleenex_update("First Stab to Second Stab");
  level.goliath_ai waittill("start_context_melee");
  thread scripts\sp\analytics::analytics_kleenex_update("Second Stab to House Boss End");
}

weapon_knock_off_room_monitor() {
  level endon("boss_dying");
  var_0 = [];

  foreach(var_2 in getEntArray("house_room_trigger", "targetname")) {
    var_3 = spawnStruct();
    var_3.trigger = var_2;
    var_3.smartobjects = [];
    var_0[var_2.script_noteworthy] = var_3;
  }

  var_5 = [];

  foreach(var_7 in anim.smartobjectpoints) {
    if(!issubstr(var_7.script_smartobject, "knock_off")) {
      continue;
    }
    var_5[var_5.size] = var_7;
    var_7.prioritymultiplier = 100;

    foreach(var_9, var_3 in var_0) {
      if(ispointinvolume(var_7.origin, var_3.trigger)) {
        var_7.room = var_9;
        var_3.smartobjects[var_3.smartobjects.size] = var_7;
        break;
      }
    }
  }

  foreach(var_9, var_3 in var_0) {
    if(!var_3.smartobjects.size)
      var_0 = scripts\engine\utility::array_remove_key(var_0, var_9);
  }

  for(;;) {
    level waittill("knock_off", var_7);
    thread scripts\engine\utility::play_sound_in_space("scn_hometown_brute_knock_smartobj", var_7.origin);

    if(isDefined(var_7.script_noteworthy))
      level.current_knock_off = var_7.script_noteworthy;

    var_3 = var_0[var_7.room];

    foreach(var_7 in var_3.smartobjects) {
      var_7.donotuse = 1;
      var_5 = scripts\engine\utility::array_remove(var_5, var_7);
    }

    var_0 = scripts\engine\utility::array_remove_key(var_0, var_7.room);

    if(!var_0.size)
      return;
  }
}

prioritize_knock_off_on_context_melee(var_0) {
  level endon("knock_off");
  level.goliath_ai waittill("start_context_melee");

  foreach(var_2 in var_0)
  var_2.prioritymultiplier = 100;
}

goliath_player_death_monitor() {
  level endon("boss_dying");
  scripts\engine\utility::waittill_any_ents(level, "counter_kill", level.player, "death");

  if(isDefined(level.goliath_weapon_exists)) {
    if(!isDefined(level.player_found_a_weapon))
      level scripts\sp\player_death::set_custom_death_quote(61);
    else if(scripts\engine\utility::is_equal(level.player.stealth.hints.causeofdeath, "footstep_sprint"))
      level scripts\sp\player_death::set_custom_death_quote(68);
    else if(player_failed_context_melee())
      level scripts\sp\player_death::set_custom_death_quote(randomintrange(93, 96));
    else if(isDefined(level.player_found_a_weapon) && !isDefined(level.player_stabbed_boss))
      level scripts\sp\player_death::set_custom_death_quote(58);
    else if(isDefined(level.player_found_a_weapon) && isDefined(level.player_stabbed_boss)) {
      if(scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_rebar") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_screwdriver") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_scissors"))
        level scripts\sp\player_death::set_custom_death_quote(scripts\engine\utility::random([58, 93, 94, 95]));
      else
        level scripts\sp\player_death::set_custom_death_quote(79);
    }
  } else
    level scripts\sp\player_death::set_custom_death_quote(58);
}

player_failed_context_melee() {
  if(scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_rebar") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_screwdriver") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_scissors")) {
    if(isDefined(level.player.context_melee_last_inactive_time) && gettime() - level.player.context_melee_last_inactive_time < 3000)
      return 1;
    else if(getdvarint("context_melee_debug"))
      iprintln("active too long ago: " + (gettime() - level.player.context_melee_last_inactive_time));
  }

  return 0;
}

goliath_knife_monitor() {
  level endon("boss_dying");

  for(;;) {
    level.goliath_ai waittill("start_context_melee");
    thread launch_player_from_boss();
    var_0 = level.player getcurrentweapon();
    thread goliath_knife_fov_scale_factor();
    var_1 = undefined;

    if(var_0.basename == "iw8_knife_kid")
      level.player.context_melee_knife = "weapon_vm_me_kitchen_knife";
    else if(var_0.basename == "iw8_knife_kid_rebar")
      level.player.context_melee_knife = "weapon_vm_me_screwdriver";
    else if(var_0.basename == "iw8_knife_kid_scissors")
      level.player.context_melee_knife = "weapon_vm_me_scissors";
    else if(var_0.basename == "iw8_knife_kid_screwdriver")
      level.player.context_melee_knife = "weapon_vm_me_screwdriver";
    else {
      level.player.context_melee_knife = "tag_origin";
      var_1 = "true";
    }

    level notify("boss_stab_vo_start");
    thread audio_music_stab();
    var_2 = level.player.origin;
    level.player setstance("stand", 1);
    level waittill("player_knife_part_done");

    if(!scripts\engine\utility::flag("disable_autosaves"))
      thread scripts\engine\sp\utility::autosave_now();

    var_3 = spawn("script_model", level.player.origin);
    var_3 setModel(level.player.context_melee_knife);
    var_3 notsolid();
    var_3 linkTo(level.goliath_ai, "tag_accessory_left", (0, 0, 0), (0, 0, 0));
    waitframe();
    level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_counter_back", "back", "tag_view", "player_eye");
    level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_counter_front", "front", "tag_view", "player_eye");
    level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_counter_left", "left", "tag_view", "player_eye");
    level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_counter_right", "right", "tag_view", "player_eye");
    level.goliath_ai aieventlistenerevent("combat", level.player, level.player.origin);
    level scripts\sp\utility::context_melee_waittill_player_finished();
    level.player takeweapon(var_0);
    level.player notify("knife_change");
    level.player enableweapons();
    level.player giveweapon("iw8_gunless_farrah");
    level.player switchtoweapon("iw8_gunless_farrah");
    waitframe();
    level.player_stabbed_boss = 1;
    level waittill("enemy_knife_part_done");
    var_3 delete();
    var_4 = scripts\engine\utility::getStruct("known_loc_" + level.current_room, "script_noteworthy");
    level.goliath_ai aieventlistenerevent("combat", level.player, var_4.origin);
    var_5 = level.goliath_ai gettagangles("tag_accessory_left");
    var_6 = level.goliath_ai gettagorigin("tag_accessory_left");
    var_7 = spawn("script_model", var_6);

    if(var_0.basename == "iw8_knife_kid")
      var_7 setModel("weapon_wm_me_kitchen_knife");
    else if(var_0.basename == "iw8_knife_kid_rebar")
      var_7 setModel("weapon_wm_me_screwdriver");
    else if(var_0.basename == "iw8_knife_kid_scissors")
      var_7 setModel("weapon_wm_me_scissors");
    else if(var_0.basename == "iw8_knife_kid_screwdriver")
      var_7 setModel("weapon_wm_me_screwdriver");
    else
      var_7 setModel("weapon_vm_me_screwdriver");

    var_8 = anglesToForward(var_5);
    var_8 = var_8 * randomfloatrange(100, 150);
    var_9 = var_8[0];
    var_10 = var_8[1];
    var_11 = randomfloatrange(100, 200);
    var_7 physicslaunchserver(var_7.origin, (var_9, var_10, var_11));
    wait 1.8;
    var_7 thread scripts\sp\maps\hometown\hometown_util.gsc::goliath_melee_weapon_interact(var_0.basename);
  }
}

launch_player_from_boss() {
  self endon("pain_fx_done");
  waitframe();
  level.player.melee_arms setModel(scripts\sp\maps\hometown\hometown_util.gsc::getfarrahbloodymodel());
  level waittill("impact_effects");
  thread sfx_impact_shellshock();
  wait 1.0;
  self endon("pain_fx_done");
}

sfx_impact_shellshock() {
  level.player shellshock("default_nosound", 2);
  level.player scripts\engine\utility::delaycall(2.5, ::fadeoutshellshock);
  var_0 = spawn("script_origin", level.player.origin);
  var_0 linkTo(level.player);
  var_0 playLoopSound("flashbang_tinnitus_loop");
  var_0 scripts\engine\sp\utility::sound_fade_and_delete(3, 1);
}

goliath_knife_fov_scale_factor() {
  level.player lerpfovscalefactor(0, 0.5);
  level waittill("impact_effects");
  level.player lerpfovscalefactor(1, 0);
}

launch_player_physics() {
  var_0 = anglesToForward(level.player.angles) * -1;
  var_0 = var_0 * 60;

  for(var_1 = 1; var_1 < 10; var_1++) {
    level.player setvelocity(var_0);
    var_0 = var_0 - 10;
    waitframe();
  }
}

goliath_player_location_monitor() {
  level endon("boss_dying");
  var_0 = getEnt("foyer", "script_noteworthy");
  var_1 = getEnt("hall", "script_noteworthy");
  var_2 = getEnt("kids_room", "script_noteworthy");
  var_3 = getEnt("kitchen", "script_noteworthy");
  var_4 = getEnt("bathroom", "script_noteworthy");
  var_5 = getEnt("master_bedroom", "script_noteworthy");
  var_6 = getEnt("living_room", "script_noteworthy");
  level.current_room = "living_room";

  for(;;) {
    var_7 = level.current_room;

    if(level.player istouching(var_0))
      level.current_room = "foyer";
    else if(level.player istouching(var_1))
      level.current_room = "hall";
    else if(level.player istouching(var_2))
      level.current_room = "kids_room";
    else if(level.player istouching(var_3))
      level.current_room = "kitchen";
    else if(level.player istouching(var_4))
      level.current_room = "bathroom";
    else if(level.player istouching(var_5))
      level.current_room = "master_bedroom";
    else if(level.player istouching(var_6))
      level.current_room = "living_room";
    else
      level.current_room = "living_room";

    if(level.current_room != var_7)
      level notify("room_changed");

    waitframe();
  }
}

goliath_boss_location_monitor() {
  level endon("boss_dying");
  var_0 = getEnt("foyer", "script_noteworthy");
  var_1 = getEnt("hall", "script_noteworthy");
  var_2 = getEnt("kids_room", "script_noteworthy");
  var_3 = getEnt("kitchen", "script_noteworthy");
  var_4 = getEnt("bathroom", "script_noteworthy");
  var_5 = getEnt("master_bedroom", "script_noteworthy");
  var_6 = getEnt("living_room", "script_noteworthy");
  thread goliath_room_time_monitor();
  level.boss_current_room = "living_room";

  for(;;) {
    var_7 = level.boss_current_room;

    if(level.goliath_ai istouching(var_0))
      level.boss_current_room = "foyer";
    else if(level.goliath_ai istouching(var_1))
      level.boss_current_room = "hall";
    else if(level.goliath_ai istouching(var_2))
      level.boss_current_room = "kids_room";
    else if(level.goliath_ai istouching(var_3))
      level.boss_current_room = "kitchen";
    else if(level.goliath_ai istouching(var_4))
      level.boss_current_room = "bathroom";
    else if(level.goliath_ai istouching(var_5))
      level.boss_current_room = "master_bedroom";
    else if(level.goliath_ai istouching(var_6))
      level.boss_current_room = "living_room";
    else
      level.boss_current_room = "living_room";

    if(level.boss_current_room != var_7)
      level notify("boss_room_changed");

    waitframe();
  }
}

goliath_room_time_monitor() {
  level endon("boss_dying");
  level.min_time_in_room = 0;

  for(;;) {
    level waittill("boss_room_changed");
    level.min_time_in_room = 0;
    var_0 = gettime();
    var_1 = var_0;

    while(var_0 <= var_1 + 10000) {
      var_0 = gettime();
      waitframe();
    }

    level.min_time_in_room = 1;
    waitframe();
  }
}

goliath_hunt_known_location_monitor() {
  level endon("boss_dying");

  for(;;) {
    level waittill("room_changed");
    wait(randomfloatrange(4.0, 6.0));

    while(!level.min_time_in_room)
      waitframe();

    var_0 = scripts\engine\utility::getStruct("known_loc_" + level.current_room, "script_noteworthy");

    if(level.goliath_ai scripts\aitypes\stealth::ishunting())
      scripts\stealth\group::group_updatepodhuntorigin(level.goliath_ai, var_0.origin);
  }
}

goliath_strangle_effects() {
  level.eyeshutoverlay = scripts\sp\hud_util::create_client_overlay("black", 0.0);
  wait 0.1;
  level.eyeshutoverlay fadeovertime(2.0);
  level.eyeshutoverlay.alpha = 0.5;
  setblur(1.5, 2.0);
  wait 3.0;
  level notify("hadir_stabbed_neck");
  level.eyeshutoverlay fadeovertime(0.75);
  level.eyeshutoverlay.alpha = 0.0;
  setsaveddvar("MLTTMLTKOR", 0.01);
  setsaveddvar("LSOPQMRPNR", 0.002);
  setblur(0.0, 0.75);
}

goliath_strangle_effects_capture() {
  level.eyeshutoverlay = scripts\sp\hud_util::create_client_overlay("black", 0.0);
  wait 0.1;
  level.eyeshutoverlay fadeovertime(2.0);
  level.eyeshutoverlay.alpha = 0.5;
  setblur(1.5, 2.0);
}

goliath_struggle_lights() {
  level.boss_struggle_light_key = getEnt("boss_light_key", "script_noteworthy");
  level.boss_struggle_light_key setlightintensity(0.0);
  level.boss_struggle_light_key setlightcolor((255, 242, 230));
  level.boss_struggle_light_key setlightradius(60.0);
  level.boss_struggle_light_key setlightfovrange(70, 50);
  level.boss_struggle_light_fill = getEnt("boss_light_fill", "script_noteworthy");
  level.boss_struggle_light_fill setlightintensity(0.0);
  level.boss_struggle_light_fill setlightcolor((255, 241, 228));
  level.boss_struggle_light_fill setlightradius(55.0);
  level.boss_struggle_light_fill setlightfovrange(70, 50);
  level.boss_struggle_lights_node = getEnt("boss_light_org", "script_noteworthy");
  level.boss_struggle_light_key linkTo(level.boss_struggle_lights_node);
  level.boss_struggle_light_fill linkTo(level.boss_struggle_lights_node);
  var_0 = level.boss_struggle_lights_node.origin;
  var_1 = level.boss_struggle_lights_node.angles;
  level.boss_struggle_lights_node.origin = level.boss_struggle_anim_node.origin;
  level.boss_struggle_lights_node.angles = level.boss_struggle_anim_node.angles;
  level.boss_struggle_lights_node linkTo(level.boss_struggle_anim_node);
  wait 1.0;
  thread goliath_struggle_key_intensity(0.35, 0.01);
  thread goliath_struggle_fill_intensity(0.12, 0.01);
  level waittill("set_boss_lights_og");
  level.boss_struggle_lights_node.origin = var_0;
  level.boss_struggle_lights_node.angles = var_1;
  waitframe();
  level.boss_struggle_lights_node delete();
}

goliath_struggle_key_intensity(var_0, var_1) {
  var_2 = 0;

  while(var_2 < var_0) {
    level.boss_struggle_light_key setlightintensity(var_2);
    var_2 = var_2 + var_1;
    waitframe();
  }

  level waittill("fade_boss_lights_off");

  while(var_2 >= 0.1) {
    level.boss_struggle_light_key setlightintensity(var_2);
    var_2 = var_2 - var_1;
    waitframe();
  }

  level.boss_struggle_light_key setlightintensity(0.0);
  wait 1.0;
  level notify("set_boss_lights_og");
}

goliath_struggle_fill_intensity(var_0, var_1) {
  var_2 = 0;

  while(var_2 < var_0) {
    level.boss_struggle_light_fill setlightintensity(var_2);
    var_2 = var_2 + var_1;
    waitframe();
  }

  level waittill("fade_boss_lights_off");

  while(var_2 >= 0.1) {
    level.boss_struggle_light_fill setlightintensity(var_2);
    var_2 = var_2 - var_1;
    waitframe();
  }

  level.boss_struggle_light_fill setlightintensity(0.0);
  wait 1.0;
  level notify("set_boss_lights_og");
}

goliath_struggle() {
  self endon("stab_delay_time_exceeded");
  level.player waittill("skipped_melee_anim");
  scripts\engine\utility::flag_set("lantern_smoke");
  var_0 = level.player.context_melee_direction;
  level.player setstance("stand", 1);
  setmusicstate("mx_hometown_11_last_stab_miss");
  level.goliath_ai.ignoreall = 1;
  level.boss_struggle_anim_node = level.goliath_ai scripts\engine\utility::spawn_tag_origin();
  thread goliath_struggle_lights();
  var_1 = scripts\engine\utility::getStructArray("boss_struggle_loc_" + level.player get_current_house_room(), "script_noteworthy");
  var_2 = scripts\engine\utility::getclosest(level.player.origin, var_1);
  level.boss_struggle_anim_node_safe = var_2;
  level.boss_struggle_anim_node moveTo(var_2.origin, 3.0);
  level.boss_struggle_anim_node rotateTo(var_2.angles, 3.0);
  level.player disableweapons();
  level.boss_struggle_player_model = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig", level.boss_struggle_anim_node.origin, level.boss_struggle_anim_node.angles);
  level.boss_kill_sling_model = scripts\engine\sp\utility::spawn_anim_model("boss_kill_sling", level.goliath_ai.origin, level.goliath_ai.angles);
  level.boss_kill_sling_model hide();
  level.player_rig = level.boss_struggle_player_model;

  if(var_0 == "back")
    var_3 = "boss_grab";
  else if(var_0 == "right")
    var_3 = "boss_grab_right";
  else if(var_0 == "left")
    var_3 = "boss_grab_left";
  else if(var_0 == "front")
    var_3 = "boss_grab_front";
  else
    var_3 = "boss_grab";

  level.boss_struggle_player_model setModel(scripts\sp\maps\hometown\hometown_util.gsc::getfarrahbloodymodel());
  level.boss_struggle_anim_node thread scripts\sp\player_rig::link_player_to_rig(var_3, "stand", 1, 0.3, 0, 0, 0, 0, 0, 1);
  level.boss_struggle_player_model linkTo(level.boss_struggle_anim_node);
  level.goliath_ai linkTo(level.boss_struggle_anim_node);
  level.current_knife_weapon = level.player getcurrentweapon();
  level.current_knife_weapon_string = level.current_knife_weapon.basename;

  if(level.current_knife_weapon_string == "iw8_knife_kid")
    var_4 = "weapon_vm_me_kitchen_knife";
  else if(level.current_knife_weapon_string == "iw8_knife_kid_rebar")
    var_4 = "weapon_vm_me_screwdriver";
  else if(level.current_knife_weapon_string == "iw8_knife_kid_scissors")
    var_4 = "weapon_vm_me_scissors";
  else if(level.current_knife_weapon_string == "iw8_knife_kid_screwdriver")
    var_4 = "weapon_vm_me_screwdriver";
  else
    var_4 = "weapon_vm_me_screwdriver";

  var_5 = spawn("script_model", level.boss_struggle_player_model gettagorigin("tag_accessory_right"));
  var_5 setModel(var_4);
  var_5.angles = level.boss_struggle_player_model gettagangles("tag_accessory_right");
  var_5 linkTo(level.boss_struggle_player_model, "tag_accessory_right");
  level notify("boss_struggle_vo_start");

  if(!scripts\engine\utility::flag("disable_autosaves"))
    thread scripts\engine\sp\utility::autosave_now();

  level notify("clean_up_goliath_interacts");
  level thread scripts\sp\utility::context_melee_enable(0);
  level.player lerpfovscalefactor(0, 0.3);
  level.vfx_stab_tear_screenfx_01 = spawnfx(level._effect["vfx_stab_tear_screenfx_01"], (0, 0, 0));
  triggerfx(level.vfx_stab_tear_screenfx_01);
  level.boss_struggle_anim_node scripts\common\anim::anim_single([level.boss_struggle_player_model, level.goliath_ai, level.boss_kill_sling_model], var_3);
  scripts\sp\maps\hometown\hometown_util.gsc::spawn_hadir();
  thread audio_music_stab_kill_brute();
  var_6 = 0;
  thread goliath_strangle_effects();
  level.goliath_ai scripts\sp\nvg\nvg_ai::flashlight_off();
  level.boss_struggle_anim_node scripts\common\anim::anim_single([level.boss_struggle_player_model, level.goliath_ai, level.boss_kill_sling_model], "boss_strangle");
  level.hadir_body_model delete();
  var_7 = spawn("script_model", level.hadir_ai gettagorigin("tag_accessory_right"));
  var_7 setModel("weapon_wm_me_kitchen_knife");
  var_7.angles = level.hadir_ai gettagangles("tag_accessory_right");
  var_7 linkTo(level.hadir_ai, "tag_accessory_right");
  level.hadir_ai attach("hat_waist_child_hadir_gas_mask", "J_Proc_SpineLower_Swivel");
  level.goliath_ai scripts\sp\nvg\nvg_ai::flashlight_off();
  level.hadir_ai setModel("body_hero_hadir_child_bloody");
  level.boss_kill_sling_model scripts\engine\utility::delaycall(3.5, ::show);
  level.goliath_ai hidepart("J_Dummy_SlingCenterAim");
  level.goliath_ai hidepart("J_Dummy_Sling_Spine");
  level.goliath_ai hidepart("J_Dummy_Sling_Clavicle");
  level.goliath_ai hidepart("J_Sling_Clavicle");
  level.goliath_ai hidepart("J_Sling_Spine");
  level.goliath_ai hidepart("J_Sling_pivot");
  level.vfx_htown_hadirj_blink = spawnfx(level._effect["vfx_htown_hadirj_blink"], (0, 0, 0));
  triggerfx(level.vfx_htown_hadirj_blink);
  level.boss_struggle_anim_node scripts\common\anim::anim_single([level.boss_struggle_player_model, level.goliath_ai, level.hadir_ai, level.boss_kill_sling_model], "boss_pull_off");
  var_5 delete();
  level.boss_struggle_player_model unlink();
  level.goliath_ai unlink();
  level.player scripts\sp\player_rig::unlink_player_from_rig(0, "stand");
  level.player enableweapons();
  thread goliath_stab_time_monitor();
  thread goliath_struggle_fail();
  thread goliath_struggle_stab_monitor();
  thread goliath_struggle_stab();
  thread goliath_struggle_stab_slow();
  thread goliath_struggle_stab_slow_player();
  level.friendlyfiredisabled = 1;
  level.goliath_ai scripts\sp\nvg\nvg_ai::flashlight_off();
  level.boss_struggle_anim_node thread scripts\common\anim::anim_loop([level.hadir_ai, level.goliath_ai, level.boss_kill_sling_model], "boss_struggle_a");
  level waittill("boss_turns_on_hadir");
  var_7 unlink();
  var_7 delete();
  goliath_struggle_use_gun_scene();
  level notify("boss_dying");

  if(!istrue(level.player.goliath_melee_allowed))
    level.player scripts\common\utility::allow_melee(1);

  level.player.goliath_melee_allowed = undefined;
  scripts\engine\utility::flag_clear("disable_autosaves");
  level.hadir_ai setgoalpos(level.hadir_ai.origin);
  level.friendlyfiredisabled = 0;
  level.goliath_ai.ignoreall = 1;
  level notify("goliath_boss_dead");
  level.vfx_htown_hadirj_blink delete();
  level.vfx_htown_stab_blink_1 delete();
  level.vfx_htown_stab_blink_2 delete();
  level.vfx_htown_stab_blink_3 delete();
  level.vfx_htown_stab_blink_ak delete();
  thread scripts\sp\analytics::analytics_kleenex_update("House Boss End to Gas Start");

  if(!scripts\engine\utility::flag("disable_autosaves"))
    thread scripts\engine\sp\utility::autosave_now();
}

audio_music_stab_kill_brute() {}

get_current_house_room() {
  var_0 = getEntArray("house_room_trigger", "targetname");

  foreach(var_2 in var_0) {
    if(self istouching(var_2))
      return var_2.script_noteworthy;
  }

  return undefined;
}

goliath_struggle_use_gun_scene() {
  level.boss_struggle_anim_node thread scripts\common\anim::anim_loop([level.hadir_ai, level.goliath_ai, level.boss_kill_sling_model], "kill_flip_idle");
  level.goliath_ai scripts\sp\player\cursor_hint::create_cursor_hint("j_trigger", (0, 0, 0), &"HOMETOWN/AK47", undefined, undefined, 100);
  thread ak_shoot_timer();
  level.player giveweapon("iw8_gunless_farrah");
  level.player switchtoweapon("iw8_gunless_farrah");
  level.player disableweapons();
  level.goliath_ai waittill("trigger");
  level.ak_shoot_timer = 90;
  level.boss_shoot_player_model = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig", level.boss_struggle_anim_node.origin, level.boss_struggle_anim_node.angles);
  level.player_rig = level.boss_shoot_player_model;
  level.boss_shoot_player_model setModel(scripts\sp\maps\hometown\hometown_util.gsc::getfarrahbloodymodel());
  level.goliath_ai scripts\sp\nvg\nvg_ai::flashlight_off();
  level.boss_struggle_anim_node thread scripts\sp\player_rig::link_player_to_rig("kill_flip_gun_grab", "stand", 1, 0.5, 0, 0, 0, 0, 0, 1);
  level.boss_struggle_anim_node notify("stop_loop");
  level.boss_struggle_anim_node scripts\common\anim::anim_single([level.hadir_ai, level.goliath_ai, level.boss_shoot_player_model, level.boss_kill_sling_model], "kill_flip_gun_grab");
  level.goliath_ai scripts\sp\nvg\nvg_ai::flashlight_off();
  level.boss_struggle_anim_node notify("stop_loop");
  level.boss_struggle_anim_node thread scripts\common\anim::anim_loop([level.hadir_ai, level.goliath_ai, level.boss_shoot_player_model, level.boss_kill_sling_model], "kill_flip_gun_grab_idle");
  level.ak_shoot_timer = 90;
  var_0 = 0;

  while(var_0 == 0) {
    if(level.player attackButtonPressed() || level.player fragButtonPressed() || level.player secondaryoffhandbuttonPressed() || level.player meleeButtonPressed() || level.player useButtonPressed())
      var_0 = 1;

    waitframe();

    if(level.didnt_shoot_ak_in_time) {
      for(;;)
        waitframe();
    }
  }

  level notify("player_shot_boss");
  level.boss_struggle_anim_node notify("stop_loop");
  thread player_shoot_boss();
  level notify("player_shot_boss");
  level.goliath_ai scripts\sp\nvg\nvg_ai::flashlight_off();
  level.boss_kill_sling_model hide();
  level.goliath_ai showpart("J_Dummy_SlingCenterAim");
  level.goliath_ai showpart("J_Dummy_Sling_Spine");
  level.goliath_ai showpart("J_Dummy_Sling_Clavicle");
  level.goliath_ai showpart("J_Sling_Clavicle");
  level.goliath_ai showpart("J_Sling_Spine");
  level.goliath_ai showpart("J_Sling_pivot");
  level.get_mask_anim_node = level.boss_struggle_anim_node;
  level.gas_mask_from_boss_model_pre = scripts\engine\sp\utility::spawn_anim_model("gas_mask_from_boss", level.get_mask_anim_node.origin, level.get_mask_anim_node.angles);
  level.goliath_ai detach("hat_russian_soldier_boss");
  level.boss_struggle_anim_node scripts\common\anim::anim_single([level.hadir_ai, level.goliath_ai, level.boss_kill_sling_model, level.gas_mask_from_boss_model_pre], "kill_flip_gun_shoot");
  level.boss_struggle_anim_node thread scripts\common\anim::anim_last_frame_solo(level.goliath_ai, "kill_flip_gun_shoot");
  level.boss_struggle_anim_node thread scripts\common\anim::anim_last_frame_solo(level.boss_kill_sling_model, "kill_flip_gun_shoot");
}

ak_shoot_timer() {
  level endon("player_shot_boss");
  level.ak_shoot_timer = 90;
  level.didnt_shoot_ak_in_time = 0;

  while(level.ak_shoot_timer > 0) {
    level.ak_shoot_timer = level.ak_shoot_timer - 1;
    waitframe();
  }

  level.didnt_shoot_ak_in_time = 1;
  level thread scripts\sp\player_death::set_custom_death_quote(65);
  scripts\sp\utility::missionfailedwrapper();
}

player_shoot_boss() {
  level.player enableinvulnerability();
  level notify("fade_boss_lights_off");
  level.player playRumbleOnEntity("heavy_2s");
  thread stab_blink_black_fade();
  level.vfx_htown_stab_blink_ak = spawnfx(level._effect["vfx_htown_stab_blink_3"], (0, 0, 0));
  triggerfx(level.vfx_htown_stab_blink_ak);
  level.player shellshock("hometown_boss_intro", 3, undefined, 0);
  setblur(2.0, 0.01);
  scripts\engine\utility::noself_delaycall(0.1, ::setblur, 0.0, 3.0);
  level.vfx_stab_tear_screenfx_01 delete();
  level.boss_struggle_anim_node scripts\common\anim::anim_single([level.boss_shoot_player_model], "kill_flip_gun_shoot");
  thread scripts\sp\maps\hometown\hometown_util.gsc::boss_blocker();
  level.player enableweapons();
  level.player scripts\sp\player_rig::unlink_player_from_rig(0, "stand");
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowstand(1);
  level.player disableinvulnerability();
}

goliath_struggle_fail() {
  level endon("kill_flip_start");
  level waittill("stab_delay_time_exceeded");
  level notify("stab_failed");

  if(isDefined(level.player.goliath_melee_allowed) && !level.player.goliath_melee_allowed)
    level.player scripts\common\utility::allow_melee(1);

  level.boss_struggle_anim_node notify("stop_loop");

  if(isDefined(level.boss_kill_sling_model)) {
    level.boss_kill_sling_model delete();
    level.goliath_ai showpart("J_Dummy_SlingCenterAim");
    level.goliath_ai showpart("J_Dummy_Sling_Spine");
    level.goliath_ai showpart("J_Dummy_Sling_Clavicle");
    level.goliath_ai showpart("J_Sling_Clavicle");
    level.goliath_ai showpart("J_Sling_Spine");
    level.goliath_ai showpart("J_Sling_pivot");
  }

  level.boss_struggle_anim_node scripts\common\anim::anim_single([level.hadir_ai, level.goliath_ai], "boss_fail");
  level.hadir_ai stopsounds();
  level.hadir_ai scripts\sp\maps\hometown\hometown_util.gsc::kill_quietly(level.goliath_ai);
  level thread scripts\sp\player_death::set_custom_death_quote(65);
  scripts\sp\utility::missionfailedwrapper();
}

goliath_stab_time_monitor() {
  level endon("kill_flip_start");
  level.time_since_last_stab = 0;

  for(;;) {
    level.time_since_last_stab = level.time_since_last_stab + 1;

    if(level.time_since_last_stab >= 100)
      level notify("stab_delay_time_exceeded");

    waitframe();
  }
}

goliath_stab_model_swap_monitor() {
  level waittill("dad_stabbed_chest");
  level.goliath_ai setModel("body_russian_soldier_boss_stab_1_chest_dad");
  level waittill("player_stabbed_boss");
  level.goliath_ai setModel("body_russian_soldier_boss_stab_2_leg_l_back");
  level waittill("player_stabbed_boss");
  level.goliath_ai setModel("body_russian_soldier_boss_stab_3_leg_r_back");
  level waittill("hadir_stabbed_neck");
  level.goliath_ai scripts\engine\utility::delaycall(1.6, ::setmodel, "body_russian_soldier_boss_stab_4_neck");
  level.goliath_ai scripts\engine\utility::delaycall(1.6, ::detach, "head_russian_soldier_boss");
  level.goliath_ai scripts\engine\utility::delaycall(1.6, ::attach, "head_russian_soldier_boss_stab_4_neck");
  level waittill("player_stabbed_boss");
  level.goliath_ai setModel("body_russian_soldier_boss_stab_5_chest_a");
  level waittill("player_stabbed_boss");
  level.goliath_ai setModel("body_russian_soldier_boss_stab_7_chest_c");
  level waittill("player_stabbed_boss");
  level.goliath_ai setModel("body_russian_soldier_boss_stab_8_chest_d");
  level waittill("player_shot_boss");
  level.goliath_ai setModel("body_russian_soldier_boss_stab_9_gunshots");
}

goliath_struggle_stab_monitor() {
  level endon("boss_dying");
  level endon("stab_failed");
  level.player.goliath_melee_allowed = 1;

  for(;;) {
    var_0 = goliath_struggle_stab_check_for_close_victim();

    if(var_0 == "true") {
      if(istrue(level.player.goliath_melee_allowed)) {
        level.player scripts\common\utility::allow_melee(0);
        level.player.goliath_melee_allowed = 0;
      }

      if(level.player attackButtonPressed() || level.player meleeButtonPressed()) {
        var_1 = goliath_struggle_stab_direction();

        if(var_1 != "back")
          level notify("player_stabbed_struggling_goliath");
      }
    } else if(!istrue(level.player.goliath_melee_allowed)) {
      level.player scripts\common\utility::allow_melee(1);
      level.player.goliath_melee_allowed = 1;
    }

    waitframe();
  }
}

goliath_struggle_stab() {
  level endon("player_unlinked_from_kill_flip");
  level endon("stab_failed");
  var_0 = ["boss_stab_context02", "boss_stab_context05", "boss_stab_context07"];
  level.boss_stabbed_amount = 0;

  foreach(var_2 in var_0) {
    level waittill("player_stabbed_struggling_goliath");
    level notify("start_stab");
    level.boss_struggle_anim_node notify("stop_loop");

    if(var_2 == "boss_stab_context01")
      level.stab_tag = "TAG_blood_1";
    else if(var_2 == "boss_stab_context02")
      level.stab_tag = "TAG_blood_7";
    else if(var_2 == "boss_stab_context04")
      level.stab_tag = "TAG_blood_4";
    else if(var_2 == "boss_stab_context05")
      level.stab_tag = "TAG_blood_3";
    else if(var_2 == "boss_stab_context07")
      level.stab_tag = "TAG_blood_6";
    else
      level.stab_tag = "TAG_blood_1";

    level.time_since_last_stab = 0;
    var_3 = level.player.origin;
    level.boss_stab_player_model = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig", level.boss_struggle_anim_node.origin, level.boss_struggle_anim_node.angles);
    level.player_rig = level.boss_stab_player_model;
    level.boss_stab_player_model setModel(scripts\sp\maps\hometown\hometown_util.gsc::getfarrahbloodymodel());
    level.boss_struggle_anim_node thread scripts\sp\player_rig::link_player_to_rig(var_2, "stand", 1, 0.2, 0, 0, 0, 0, 0, 1);
    level.player hideviewmodel();

    if(level.current_knife_weapon_string == "iw8_knife_kid") {
      var_4 = "weapon_vm_me_kitchen_knife";
      level.player takeallweapons();
      level.player giveweapon("iw8_knife_kid_bloody");
      level.player switchtoweaponimmediate("iw8_knife_kid_bloody");

      if(!level.boss_stabbed_amount == 0)
        var_4 = "weapon_vm_me_kitchen_knife_bloody";
    } else if(level.current_knife_weapon_string == "iw8_knife_kid_rebar") {
      var_4 = "weapon_vm_me_screwdriver";
      level.player takeallweapons();
      level.player giveweapon("iw8_knife_kid_screwdriver_bloody");
      level.player switchtoweaponimmediate("iw8_knife_kid_screwdriver_bloody");

      if(!level.boss_stabbed_amount == 0)
        var_4 = "weapon_vm_me_screwdriver_bloody";
    } else if(level.current_knife_weapon_string == "iw8_knife_kid_scissors") {
      var_4 = "weapon_vm_me_scissors";
      level.player takeallweapons();
      level.player giveweapon("iw8_knife_kid_scissors_bloody");
      level.player switchtoweaponimmediate("iw8_knife_kid_scissors_bloody");

      if(!level.boss_stabbed_amount == 0)
        var_4 = "weapon_vm_me_scissors_bloody";
    } else if(level.current_knife_weapon_string == "iw8_knife_kid_screwdriver") {
      var_4 = "weapon_vm_me_screwdriver";
      level.player takeallweapons();
      level.player giveweapon("iw8_knife_kid_screwdriver_bloody");
      level.player switchtoweaponimmediate("iw8_knife_kid_screwdriver_bloody");

      if(!level.boss_stabbed_amount == 0)
        var_4 = "weapon_vm_me_screwdriver_bloody";
    } else {
      var_4 = "weapon_vm_me_screwdriver";
      level.player takeallweapons();
      level.player giveweapon("iw8_knife_kid_screwdriver_bloody");
      level.player switchtoweaponimmediate("iw8_knife_kid_screwdriver_bloody");

      if(!level.boss_stabbed_amount == 0)
        var_4 = "weapon_vm_me_screwdriver_bloody";
    }

    var_5 = spawn("script_model", level.boss_stab_player_model gettagorigin("tag_accessory_right"));
    var_5.angles = level.boss_stab_player_model gettagangles("tag_accessory_right");
    var_5 setModel(var_4);
    var_5 linkTo(level.boss_stab_player_model, "tag_accessory_right");
    level.boss_struggle_anim_node scripts\common\anim::anim_single([level.boss_stab_player_model, level.goliath_ai, level.hadir_ai, level.boss_kill_sling_model], var_2);

    if(var_2 == "boss_stab_context07") {
      level.boss_struggle_anim_node notify("stop_loop");
      level.time_since_last_stab = 0;
      level notify("kill_flip_start");
      level notify("start_kill_flip_vo");
      thread boss_turn_on_hadir_hit();
      thread boss_turns_on_hadir_anim();

      if(!scripts\engine\utility::flag("disable_autosaves"))
        thread scripts\engine\sp\utility::autosave_now();

      level.boss_struggle_anim_node scripts\common\anim::anim_single([level.boss_stab_player_model], "kill_flip");
      level.time_since_last_stab = 0;
    }

    var_5 delete();
    level.player scripts\sp\player_rig::unlink_player_from_rig(0, "stand");
    level.player disableweapons();
    level.player showviewmodel();
    level.time_since_last_stab = 0;
    level.boss_stabbed_amount = level.boss_stabbed_amount + 1;

    if(var_2 == "boss_stab_context07") {
      level notify("player_unlinked_from_kill_flip");
      continue;
    }

    level.boss_struggle_anim_node thread scripts\common\anim::anim_loop([level.hadir_ai, level.goliath_ai, level.boss_kill_sling_model], "boss_struggle_a");
  }
}

boss_turns_on_hadir_anim() {
  level.boss_struggle_anim_node scripts\common\anim::anim_single([level.hadir_ai, level.goliath_ai, level.boss_kill_sling_model], "kill_flip");
  level notify("boss_turns_on_hadir");
}

boss_turn_on_hadir_hit() {
  self endon("pain_fx_done");
  wait 0.9;
  earthquake(1, 0.3, level.player.origin, 75);
  level.player playRumbleOnEntity("heavy_1s");
  thread painvision_replacement();
  level.player thread scripts\sp\player::radial_distortion(0.05, 0.2, 0.25);
  thread painvision_replacement();
  wait 1.0;
  self notify("pain_fx_done");
}

painvision_replacement() {
  visionsetpain("damage_severe");
  setsaveddvar("MLLRKTPNRR", 0);
  setsaveddvar("OONLORSMO", 1.9);
  level.player shellshock("hometown_boss_intro", 3, undefined, 0);
  setblur(2.0, 0.01);
  scripts\engine\utility::noself_delaycall(0.1, ::setblur, 0.0, 3.0);
  level.player painvisionon();
  wait 0.1;
  level.player painvisionoff();
}

audio_music_stab() {
  var_0 = level.goliath_boss_round;

  if(getdvarint("greenlight"))
    var_0 = 1;

  switch (var_0) {
    case 0:
      wait 0.4;
      setmusicstate("mx_hometown_07_house_evade_02_lp");
      break;
    case 1:
      wait 0.4;
      setmusicstate("mx_hometown_10_house_evade_03_lp");
      break;
  }
}

stab_blink_black_fade() {
  level.blinkblackoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  waitframe();
  level.blinkblackoverlay fadeovertime(0.1);
  level.blinkblackoverlay.alpha = 0.9;
  wait 0.2;
  level.blinkblackoverlay fadeovertime(0.5);
  level.blinkblackoverlay.alpha = 0.0;
  wait 0.5;
  level.blinkblackoverlay destroy();
}

goliath_blood_stab_vfx() {
  level endon("boss_dying");
  thread goliath_blood_stab_hands();
  var_0 = 0;

  for(;;) {
    level waittill("player_stabbed_boss");

    if(var_0 == 2) {
      thread stab_blink_black_fade();
      level.vfx_htown_stab_blink_1 = spawnfx(level._effect["vfx_htown_stab_blink_1"], (0, 0, 0));
      triggerfx(level.vfx_htown_stab_blink_1);
      level.player shellshock("hometown_boss_intro", 3, undefined, 0);
      setblur(2.0, 0.01);
      scripts\engine\utility::noself_delaycall(0.1, ::setblur, 0.0, 3.0);
    } else if(var_0 == 3) {
      thread stab_blink_black_fade();
      level.vfx_htown_stab_blink_2 = spawnfx(level._effect["vfx_htown_stab_blink_2"], (0, 0, 0));
      triggerfx(level.vfx_htown_stab_blink_2);
      level.player shellshock("hometown_boss_intro", 3, undefined, 0);
      setblur(2.0, 0.01);
      scripts\engine\utility::noself_delaycall(0.1, ::setblur, 0.0, 3.0);
    } else if(var_0 == 4) {
      thread stab_blink_black_fade();
      level.vfx_htown_stab_blink_3 = spawnfx(level._effect["vfx_htown_stab_blink_3"], (0, 0, 0));
      triggerfx(level.vfx_htown_stab_blink_3);
      level.player shellshock("hometown_boss_intro", 3, undefined, 0);
      setblur(2.0, 0.01);
      scripts\engine\utility::noself_delaycall(0.1, ::setblur, 0.0, 3.0);
    }

    playFXOnTag(level._effect["vfx_htown_blood_stab"], level.goliath_ai, level.stab_tag);
    level.player playRumbleOnEntity("light_1s");
    var_0 = var_0 + 1;
  }
}

goliath_blood_stab_hands() {
  level endon("boss_dying");
  level waittill("player_stabbed_boss");
  scripts\sp\player\youngfarrah::setplayerviewmodel(scripts\sp\maps\hometown\hometown_util.gsc::getfarrahbloodymodel(), undefined, "viewmodel_farah_child_shadowcaster");
}

goliath_struggle_player_check_final_pos(var_0) {
  wait 0.05;
  var_1 = self.origin + (0, 0, 1);
  var_2 = scripts\engine\trace::player_trace(var_0 + (0, 0, 1), var_1, self.angles, [self]);
  var_3 = var_2["position"];

  if(distancesquared(var_1, var_3) > 0.0001) {
    var_4 = vectorNormalize(var_0 - var_1);
    self setOrigin(var_3 + var_4);
  }
}

goliath_struggle_stab_direction() {
  var_0 = level.goliath_ai gettagangles("j_spinelower");
  var_1 = level.goliath_ai gettagorigin("j_spinelower");
  var_2 = anglestoright(var_0);
  var_3 = anglesToForward(var_0);
  var_4 = level.player.origin - var_1;
  var_4 = (var_4[0], var_4[1], 0);
  var_4 = vectorNormalize(var_4);
  var_5 = abs(vectordot(var_3, (0, 0, 1)));

  if(var_5 > 0.7)
    var_3 = vectorNormalize((var_2[0], var_2[1], 0));
  else
    var_3 = vectorNormalize((var_3[0], var_3[1], 0));

  var_6 = anglesToForward(level.goliath_ai.angles);

  if(vectordot(var_4, var_6) > vectordot(var_3, var_6))
    var_3 = var_6;

  var_2 = vectorcross(var_3, (0, 0, 1));
  var_7 = vectordot(var_3, var_4);
  var_8 = vectordot(var_2, var_4);
  var_9 = -0.6;

  if(var_7 < var_9)
    return "back";
  else if(var_7 > 0.6)
    return "front";
  else if(var_8 > 0)
    return "right";
  else
    return "left";

  return undefined;
}

goliath_struggle_stab_check_for_close_victim() {
  var_0 = 100;
  var_1 = var_0 * var_0;
  var_2 = anglesToForward((0, level.player getplayerangles()[1], 0));
  var_3 = level.player getEye();
  var_4 = level.goliath_ai gettagorigin("j_spinelower");
  var_5 = distancesquared(var_4, var_3);

  if(var_5 < var_1) {
    var_6 = vectorNormalize(var_4 - var_3);

    if(vectordot(var_6, var_2) > 0.5) {
      if(scripts\engine\trace::_bullet_trace_passed(level.player.origin + (0, 0, 48), var_4, 0, undefined))
        return "true";
    }
  }

  return "false";
}

melee_weapon_safe_gesture() {
  level.player giveweapon("iw8_gunless_farrah");
  level.player switchtoweapon("iw8_gunless_farrah");
  wait 1.0;
}

house_exit_main() {
  setsaveddvar("OMNONNMOTP", "0.1 400 2.25 1000");
  level.player allowsprint(1);
  level.player allowjump(1);
  level.door_clip_boss_enter notsolid();
  level.father_body_model detach("head_hero_farahs_father");
  level.father_body_model attach("head_sc_m_ward_blendshape");
  var_0 = scripts\engine\utility::getStruct("boost_anim_node", "script_noteworthy");
  var_0 thread scripts\common\anim::anim_loop_solo(level.father_body_model, "boost_father_enter_idle");
  level.player_view_blur = 0.0;
  thread melee_weapon_safe_gesture();
  scripts\engine\utility::stop_exploder("ceilingsmoke");
  level.goliath_body_model = scripts\engine\sp\utility::spawn_anim_model("goliath_body", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  thread goliath_procedural_bones();
  level.goliath_body_model attach("head_russian_soldier_boss_stab_4_neck");
  setmusicstate("");
  level.goliath_body_model attach("attachment_wm_receiver_akilo47");
  level.goliath_body_model attach("attachment_wm_reflex_west01");
  level.goliath_body_model attach("attachment_wm_smgbarrel_akilo47");
  level.goliath_body_model attach("attachment_wm_smgmag_akilo47");
  level.goliath_body_model attach("attachment_wm_tac_light");
  level.goliath_body_model attach("attachment_wm_vertgrip_stubby01");

  if(isDefined(level.boss_kill_sling_model))
    level.boss_kill_sling_model hide();

  level.goliath_body_model.gas_mask = spawn("script_model", level.goliath_body_model.origin);
  level.goliath_body_model.gas_mask setModel("tag_origin");
  level.goliath_body_model.gas_mask notsolid();
  level.goliath_body_model.gas_mask linkTo(level.goliath_body_model, "j_helmet", (-6, -2.5, -0.25), (180, -270, 90));
  level.goliath_body_model.gas_mask hide();
  level.boss_struggle_anim_node thread scripts\common\anim::anim_first_frame_solo(level.goliath_body_model, "try_get_gun_scene");
  waitframe();
  scripts\common\anim::anim_set_time([level.father_body_model], "house_dad_dead_frame", 1.0);
  scripts\sp\player\youngfarrah::setplayerviewmodel(scripts\sp\maps\hometown\hometown_util.gsc::getfarrahbloodymodel(), undefined, "viewmodel_farah_child_shadowcaster");
  thread scripts\sp\maps\hometown\hometown_vo.gsc::house_exit_start_vo();
  level.goliath_body_model notsolid();
  level.father_body_model notsolid();
  thread mourn_dad_monitor();
  thread talk_to_hadir();
  scripts\engine\utility::stop_exploder("ceilingsmoke");
  scripts\engine\utility::stop_exploder("wallfire");
  thread scripts\engine\utility::exploder("wallfire_post");
  scripts\engine\utility::flag_set("objective_get_gas_mask");
  scripts\engine\utility::flag_wait("tried_to_get_gun");
  scripts\engine\utility::flag_wait("got_gas_mask_from_boss");
  scripts\engine\utility::flag_wait("tried_to_get_gun_hadir_anim_done");
  level.dead_boss_blocker delete();
  level.dead_boss_blocker_use delete();
  level.goliath_body_model scriptmoverdistancefade();
  level.dead_dad_blocker_hadir scripts\engine\sp\utility::show_entity();
  level.get_mask_anim_node notify("stop_loop");
  level.try_get_gun_anim_node notify("hadir_loop_stop");
  scripts\engine\utility::flag_set("objective_leave_the_house");
  thread melee_weapon_safe_gesture();

  if(isDefined(level.boss_struggle_anim_node_safe.script_index)) {
    if(level.boss_struggle_anim_node_safe.script_index == 1)
      level.boss_struggle_anim_node thread scripts\common\anim::anim_single_solo(level.hadir_ai, "step_over_boss");

    if(level.boss_struggle_anim_node_safe.targetname == "anim_preview_loc_26")
      level.boss_struggle_anim_node scripts\common\anim::anim_single_solo(level.hadir_ai, "turnaround_at_boss");
  }

  thread front_door_boost_open_anim();
  level waittill("house_exit_complete");
  level.father_body_model delete();
  level.goliath_body_model delete();
  thread nod_gesture();
  level.hadir_ai scripts\asm\asm_bb::bb_setcivilianstate("stealth");

  if(!scripts\engine\utility::flag("disable_autosaves"))
    thread scripts\engine\sp\utility::autosave_now();
}

audio_music_stop_music_delay(var_0) {
  if(isDefined(var_0))
    wait(var_0);
}

audio_music_house_post_stab() {
  level endon("hadir_mourn_father");

  for(;;) {
    var_0 = distance(level.hadir_ai.origin, (-1494, -2485, 58));

    if(var_0 < 150) {
      break;
    }

    wait 0.1;
  }

  wait 1;
  setmusicstate("mx_hometown_13_house_post_stab");
}

nod_gesture() {
  level.player giveweapon("iw8_gunless_farrah");
  level.player switchtoweapon("iw8_gunless_farrah");
  level.player enableweapons();
  wait 1.0;
  level.player stopgestureviewmodel("ges_kitchen_knife_safe", 1.0);
}

talk_to_hadir() {
  if(isDefined(level.boss_struggle_anim_node))
    level.try_get_gun_anim_node = level.boss_struggle_anim_node;
  else {
    wait 0.1;
    level.try_get_gun_anim_node = scripts\engine\utility::spawn_tag_origin(level.goliath_body_model.origin);
    level.try_get_gun_anim_node scripts\common\anim::anim_last_frame_solo(level.boss_kill_sling_model, "kill_flip_gun_shoot");
  }

  level.try_get_gun_anim_node thread scripts\common\anim::anim_loop_solo(level.hadir_ai, "hadir_slumped_idle", "hadir_loop_stop");
  hadir_talk_monitor();
  thread audio_music_stop_music_delay(2);
  level.try_get_gun_anim_node notify("hadir_loop_stop");
  thread interact_on_boss_body_timer();
  level.try_get_gun_anim_node scripts\common\anim::anim_single_solo(level.hadir_ai, "hadir_talk");

  if(!isDefined(level.player_interacted_on_body))
    level.try_get_gun_anim_node thread scripts\common\anim::anim_loop_solo(level.hadir_ai, "hadir_ready_idle", "hadir_loop_stop");
}

interact_on_boss_body_timer() {
  wait 3.33;
  level notify("loot_interacts_active");
  level.got_gas_mask = 0;
  level.tried_to_get_gun = 0;
  thread gas_mask_pickup_playerlogic();
  thread gun_try_pickup();
}

hadir_talk_monitor() {
  level endon("house_exit_complete");
  var_0 = 0;
  var_1 = 0;

  while(var_0 <= 20 && var_1 <= 100) {
    var_2 = level.hadir_ai gettagorigin("tag_eye");
    var_3 = level.hadir_ai gettagorigin("J_SpineUpper");
    var_4 = level.hadir_ai gettagorigin("J_SpineLower");

    if(scripts\engine\utility::distance_2d_squared(level.player.origin, var_2) <= 2500 || scripts\engine\utility::distance_2d_squared(level.player.origin, var_3) <= 2500) {
      if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_2, cos(15)) || scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_4, cos(15)) || scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_3, cos(15)))
        var_0 = var_0 + 1;
    }

    var_1 = var_1 + 1;
    waitframe();
  }

  level.hadir_ai notify("trigger");
  level waittill("farah_reassure_vo_finish");
}

mourn_dad_monitor() {
  level endon("house_exit_complete");
  scripts\engine\utility::flag_wait("player_can_mourn");
  level childthread notify_on_lookat_dad(50, "tag_eye");
  level childthread notify_on_lookat_dad(80, "j_chest");
  level waittill("player_mourn_father");
  var_0 = level.player_view_blur;
  var_1 = spawnfx(level._effect["vfx_tear_screenfx_01"], (0, 0, 0));
  triggerfx(var_1);
  wait 2.0;
  level.player scripts\engine\sp\utility::player_gesture_force("ges_htf_farah_cry");
  wait 4.0;
  var_1 delete();
}

notify_on_lookat_dad(var_0, var_1) {
  self endon("player_mourn_father");
  level.player scripts\sp\maps\hometown\hometown_util.gsc::wait_lookat(level.father_body_model, var_0, var_1, 0.25, 100);
  self notify("player_mourn_father");
}

gun_try_pickup() {
  level.try_get_gun_interact = scripts\engine\utility::spawn_tag_origin(level.goliath_body_model.origin);
  level.try_get_gun_interact linkTo(level.goliath_body_model);
  level.try_get_gun_interact scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, -3, 2), &"HOMETOWN/AK47", undefined, undefined, 50, 0);
  level.try_get_gun_interact waittill("trigger");
  level.player_interacted_on_body = 1;

  if(!level.got_gas_mask)
    level.goliath_body_model scripts\sp\player\cursor_hint::remove_cursor_hint();

  level.player notify("boss_stuff_pickup", "gun");
  level.player stopgestureviewmodel("ges_kitchen_knife_safe", 1.0);
  level.try_get_gun_anim_node notify("hadir_loop_stop");
  level.try_get_gun_interact delete();
  var_0 = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig", level.try_get_gun_anim_node.origin, level.try_get_gun_anim_node.angles);
  level.player_rig = var_0;
  var_0 setModel(scripts\sp\maps\hometown\hometown_util.gsc::getfarrahbloodymodel());
  level.player setstance("stand");
  level.try_get_gun_anim_node thread scripts\sp\player_rig::link_player_to_rig("try_get_gun_scene", "stand", 1, 1.0, 0, 0, 0, 0, 0, 1);
  level.player disableweapons();
  thread gun_try_pickup_hadir();
  level.player lerpfovscalefactor(0, 0.6);
  level.try_get_gun_anim_node thread scripts\common\anim::anim_single_solo(level.boss_kill_sling_model, "try_get_gun_scene");
  level.try_get_gun_anim_node thread scripts\common\anim::anim_single_solo(level.goliath_body_model, "try_get_gun_scene");
  level.try_get_gun_anim_node thread scripts\common\anim::anim_single_solo(level.gas_mask_from_boss_model_pre, "try_get_gun_scene");
  level.try_get_gun_anim_node scripts\common\anim::anim_single_solo(var_0, "try_get_gun_scene");
  level.player enableweapons();
  level.player scripts\sp\player_rig::unlink_player_from_rig(0, "stand");
  thread melee_weapon_safe_gesture();
  scripts\engine\utility::flag_set("tried_to_get_gun");
  wait 1.0;
  level.tried_to_get_gun = 1;

  if(!level.got_gas_mask)
    level.goliath_body_model scripts\sp\player\cursor_hint::create_cursor_hint("j_head", (0, 0, 0), &"HOMETOWN/GASMASK", undefined, undefined, undefined, 1);
}

gun_try_pickup_hadir() {
  level.try_get_gun_anim_node scripts\common\anim::anim_single_solo(level.hadir_ai, "try_get_gun_scene");
  scripts\engine\utility::flag_set("tried_to_get_gun_hadir_anim_done");

  if(!scripts\engine\utility::flag("got_gas_mask_from_boss")) {
    level.try_get_gun_anim_node notify("hadir_loop_stop");
    level.try_get_gun_anim_node thread scripts\common\anim::anim_loop_solo(level.hadir_ai, "hadir_ready_idle", "hadir_loop_stop");
  }
}

front_door_boost_open_mask_spawn(var_0) {
  wait 35.5;
  level.hadir_ai detach("hat_waist_child_hadir_gas_mask", "J_Proc_SpineLower_Swivel");
  var_0 show();
  wait 4.0;
  var_0 delete();
  level.hadir_ai attach("hat_child_hadir_gas_mask");
}

goodbye_father_vo_captions() {
  iprintlnbold("HADIR: Baba...?");
  wait 2.0;
  iprintlnbold("FATHER: My loves.");
  wait 2.0;
  iprintlnbold("HADIR: You have to get up...");
  wait 2.0;
  iprintlnbold("FATHER: I can't... go with you.");
  wait 2.0;
  iprintlnbold("FARAH: They're coming...");
  wait 2.0;
  iprintlnbold("HADIR: What do we do?");
  wait 2.0;
  iprintlnbold("FATHER: Survive. Whatever it takes.");
  wait 2.0;
  iprintlnbold("FATHER: Never back down.");
  wait 2.0;
  iprintlnbold("FATHER: Fight. Protect each other.");
  wait 2.0;
  iprintlnbold("FATHER: Whatever...it takes...");
  wait 2.0;
  iprintlnbold("FATHER: Fight. Never back down.");
}

remove_hadir_blocker_house() {
  scripts\engine\utility::flag_wait("player_can_mourn");
  level.dead_dad_blocker_hadir scripts\engine\sp\utility::hide_entity();
}

front_door_boost_open_anim() {
  var_0 = scripts\engine\utility::getStruct("boost_anim_node", "script_noteworthy");
  var_0 thread scripts\common\anim::anim_first_frame_solo(level.house_intro_deadbolt_model, "boost_exitA_unlock");
  level.hadir_ai scripts\asm\asm_bb::bb_setcivilianstate("panic");
  level.hadir_ai scripts\engine\utility::set_movement_speed(45);
  level.hadir_ai.arrivalspeed = 0.82;
  thread audio_music_house_post_stab();
  var_0 scripts\sp\anim::anim_reach_and_approach_solo(level.hadir_ai, "boost_hadir_enter");
  level.hadir_ai.arrivalspeed = undefined;
  var_1 = scripts\engine\sp\utility::spawn_anim_model("gas_mask_from_dad", var_0.origin, var_0.angles);
  var_1 hide();
  thread front_door_boost_open_mask_spawn(var_1);
  level notify("hadir_mourn_father");
  var_0 thread scripts\common\anim::anim_first_frame_solo(level.gas_attack_house_door_model, "boost_exitB");
  level.hadir_ai detach("head_sc_m_coto");
  level.hadir_ai attach("head_sc_m_coto_blendshape");
  thread remove_hadir_blocker_house();
  var_0 thread scripts\common\anim::anim_single_solo(var_1, "boost_hadir_enter");
  var_0 thread scripts\common\anim::anim_single_solo(level.father_body_model, "boost_hadir_enter");
  var_0 scripts\common\anim::anim_single_solo(level.hadir_ai, "boost_hadir_enter");
  level.hadir_ai detach("head_sc_m_coto_blendshape");
  level.father_body_model detach("head_sc_m_ward_blendshape");
  level.hadir_ai attach("head_sc_m_coto");
  level.father_body_model attach("head_hero_farahs_father");
  level notify("hadir_reached_door");
  var_0 thread scripts\common\anim::anim_loop_solo(level.hadir_ai, "boost_hadir_idle", "hadir_loop_stop");
  level.hadir_ai scripts\sp\player\cursor_hint::create_cursor_hint("j_wrist_le", (3, 0, 0), &"HOMETOWN/CLIMB");
  level.hadir_ai waittill("trigger");
  thread player_putgasmaskon();
  scripts\engine\utility::flag_set("lighting_make_on");
  setaudiotriggerstate("gas_outsidehouse", "gasthrown", 1.0);

  if(level.current_knife_weapon_string == "iw8_knife_kid_bloody" || level.current_knife_weapon_string == "iw8_knife_kid") {
    var_2 = "weapon_vm_me_kitchen_knife_bloody";
    var_3 = "_knife";
  } else if(level.current_knife_weapon_string == "iw8_knife_kid_rebar_bloody" || level.current_knife_weapon_string == "iw8_knife_kid_rebar") {
    var_2 = "weapon_vm_me_screwdriver_bloody";
    var_3 = "";
  } else if(level.current_knife_weapon_string == "iw8_knife_kid_scissors_bloody" || level.current_knife_weapon_string == "iw8_knife_kid_scissors") {
    var_2 = "weapon_vm_me_scissors_bloody";
    var_3 = "_scissors";
  } else if(level.current_knife_weapon_string == "iw8_knife_kid_screwdriver_bloody" || level.current_knife_weapon_string == "iw8_knife_kid_screwdriver") {
    var_2 = "weapon_vm_me_screwdriver_bloody";
    var_3 = "";
  } else {
    var_2 = "weapon_vm_me_screwdriver";
    var_3 = "";
  }

  var_4 = scripts\engine\sp\utility::spawn_anim_model("boost_screwdriver", level.player.origin, level.player.angles);
  var_4 setModel(var_2);
  var_0 notify("hadir_loop_stop");
  level.player lerpfovscalefactor(0, 0.3);
  level.player disableweapons();
  level.player takeallweapons();
  var_5 = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig", var_0.origin, var_0.angles);
  level.player_rig = var_5;
  var_5 setModel(scripts\sp\maps\hometown\hometown_util.gsc::getfarrahbloodymodel());
  var_0 thread scripts\sp\player_rig::link_player_to_rig("boost_exitA" + var_3, "stand", 1, 0.75, 0, 0, 0, 0, 0, 1);
  var_4.origin = var_5 gettagorigin("tag_accessory_right");
  var_4.angles = var_5 gettagangles("tag_accessory_right");
  var_4 linkTo(var_5, "tag_accessory_right");
  var_6 = spawn("script_origin", level.player.origin);
  var_6 scalevolume(0, 0);
  var_7 = spawn("script_origin", level.player.origin);
  var_7 scalevolume(0, 0);
  var_8 = "scn_hometown_lock_loop" + var_3;
  var_9 = "scn_hometown_unlock_loop" + var_3;
  level.gas_mask_from_boss_model scripts\engine\utility::delaycall(0.75, ::show);
  var_0 thread scripts\common\anim::anim_single_solo(level.hadir_ai, "boost_exitA");
  var_0 thread scripts\common\anim::anim_single_solo(level.gas_mask_from_boss_model, "boost_exitA");
  var_0 scripts\common\anim::anim_single_solo(var_5, "boost_exitA" + var_3);
  level.gas_mask_from_boss_model delete();
  level.player lerpviewangleclamp(0.5, 0.5, 0.5, 40, 40, 40, 40);

  if(!getdvarint("scr_no_springcam"))
    level.player springcamdisabled(0.5);

  var_0 thread scripts\common\anim::anim_loop_solo(level.hadir_ai, "boost_exitA_idle", "stop_exitA_idle");
  var_0 thread scripts\common\anim::anim_loop_solo(var_5, "boost_exitA_idle" + var_3, "stop_exitA_idle");
  level notify("start_lock_pry");
  var_10 = scripts\engine\utility::spawn_tag_origin(var_4.origin);
  var_10 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"HOMETOWN/PRY", undefined, undefined, undefined, 1, undefined, undefined, undefined, "duration_none");
  setsaveddvar("OMNONNMOTP", "0.1 400 0.75 1000");
  var_10 waittill("trigger");
  var_10 delete();
  var_0 notify("stop_exitA_idle");
  var_6 playLoopSound(var_9);
  var_7 playLoopSound(var_8);
  var_11 = var_5 scripts\engine\utility::getanim("boost_exitA_unlock" + var_3);
  var_12 = level.hadir_ai scripts\engine\utility::getanim("boost_exitA_unlock");
  var_13 = level.house_intro_deadbolt_model scripts\engine\utility::getanim("boost_exitA_unlock");
  var_5 setanim(var_11);
  level.hadir_ai setanim(var_12);
  level.house_intro_deadbolt_model setanim(var_13);
  wait 0.3;
  var_5 setanimrate(var_11, 0);
  level.hadir_ai setanimrate(var_12, 0);
  level.house_intro_deadbolt_model setanimrate(var_13, 0);
  var_14 = 1.0;
  var_15 = var_5 getanimtime(var_11);
  var_16 = 1.0;
  var_17 = var_16 * -1.0;
  var_18 = 0;

  while(var_15 < var_14) {
    if(level.player useButtonPressed()) {
      var_19 = 1.0;
      level.player playrumblelooponentity("tank_rumble");

      if(var_18 != 1) {
        level.player playSound("scn_hometown_unlock_loop_start");
        var_6 scalevolume(1, 0.2);
        var_7 scalevolume(0, 0.2);
        var_18 = 1;
      }
    } else {
      var_19 = -2.0;
      level.player stoprumble("tank_rumble");

      if(var_18 == 1) {
        level.player playSound("scn_hometown_lock_loop_start");
        var_7 scalevolume(1, 0.2);
        var_6 scalevolume(0, 0.2);
        var_18 = 2;
      }
    }

    var_5 setanimrate(var_11, var_19);
    level.hadir_ai setanimrate(var_12, var_19);
    level.house_intro_deadbolt_model setanimrate(var_13, var_19);
    var_15 = var_5 getanimtime(var_11);

    if(var_15 == 0 && var_18 == 2) {
      var_7 scalevolume(0, 0.2);
      var_18 = 0;
    }

    waitframe();
  }

  level.player stoprumble("tank_rumble");
  level.player playRumbleOnEntity("heavy_1s");
  level notify("lock_broken");
  level.player playSound("scn_hometown_lock_door_open");
  var_7 scalevolume(0, 0.5);
  var_6 scalevolume(0, 0.5);
  var_7 scripts\engine\utility::delaycall(0.5, ::delete);
  var_6 scripts\engine\utility::delaycall(0.5, ::delete);
  level.player scripts\engine\utility::delaycall(0.5, ::lerpfovscalefactor, 1, 0.3);

  if(!getdvarint("scr_no_springcam"))
    level.player springcamenabled(0, 5, 5);

  scripts\engine\utility::stop_exploder("window_gas");
  scripts\engine\utility::exploder("gasgrenadeplayground");
  scripts\engine\utility::flag_set("lighting_gas_progression");

  if(level.player ispcplayer())
    setsaveddvar("OMNONNMOTP", "0.1 400 0.75 1000");
  else
    setsaveddvar("OMNONNMOTP", "0.1 400 3.25 1000");

  var_0 thread scripts\common\anim::anim_single_solo(level.hadir_ai, "boost_exitB");
  var_0 thread scripts\common\anim::anim_single_solo(level.gas_attack_house_door_model, "boost_exitB");
  var_0 thread scripts\common\anim::anim_single_solo(level.house_intro_deadbolt_model, "boost_exitB");
  var_0 scripts\common\anim::anim_single_solo(var_5, "boost_exitB" + var_3);
  level.player scripts\sp\player_rig::unlink_player_from_rig(0, "stand");
  level.player enableweapons();
  level.player giveweapon("iw8_gunless_farrah");
  level.player switchtoweapon("iw8_gunless_farrah");
  var_4 delete();
  level.house_intro_deadbolt_model delete();
  level notify("house_exit_complete");
}

break_lock(var_0) {
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin);
  var_1 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"HOMETOWN/PRY", undefined, undefined, undefined, 1, undefined, undefined, undefined, "duration_medium");
  var_1 waittill("trigger");
  level notify("lock_broken");
  var_1 delete();
}

gas_mask_pickup_playerlogic() {
  level.goliath_body_model scripts\sp\player\cursor_hint::create_cursor_hint("j_head", (0, 0, 0), &"HOMETOWN/GASMASK", undefined, undefined, 50, 0);
  level.goliath_body_model waittill("trigger");

  if(!level.tried_to_get_gun)
    level.try_get_gun_interact scripts\sp\player\cursor_hint::remove_cursor_hint();

  level.player notify("boss_stuff_pickup", "gas_mask");
  level.player stopgestureviewmodel("ges_kitchen_knife_safe", 1.0);
  level.get_mask_anim_node = level.boss_struggle_anim_node;
  var_0 = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig", level.get_mask_anim_node.origin, level.get_mask_anim_node.angles);
  level.player_rig = var_0;
  var_0 setModel(scripts\sp\maps\hometown\hometown_util.gsc::getfarrahbloodymodel());
  level.player setstance("stand");
  level.try_get_gun_anim_node thread scripts\sp\player_rig::link_player_to_rig("get_gas_mask", "stand", 1, 1.0, 0, 0, 0, 0, 0, 1);
  level.gas_mask_from_boss_model = scripts\engine\sp\utility::spawn_anim_model("gas_mask_from_boss", level.get_mask_anim_node.origin, level.get_mask_anim_node.angles);
  level.gas_mask_from_boss_model hide();
  level.player lerpfovscalefactor(0, 0.9);
  level.player disableweapons();
  level.get_mask_anim_node thread scripts\common\anim::anim_single_solo(level.boss_kill_sling_model, "get_gas_mask");
  level.get_mask_anim_node thread scripts\common\anim::anim_single_solo(level.gas_mask_from_boss_model_pre, "get_gas_mask");
  level.get_mask_anim_node thread scripts\common\anim::anim_single_solo(level.goliath_body_model, "get_gas_mask");
  level.get_mask_anim_node scripts\common\anim::anim_single_solo(var_0, "get_gas_mask");
  level.player enableweapons();
  level.player scripts\sp\player_rig::unlink_player_from_rig(0, "stand");
  level.gas_mask_from_boss_model_pre hide();
  level notify("gas_mask_acquired");
  thread melee_weapon_safe_gesture();
  scripts\engine\utility::flag_set("got_gas_mask_from_boss");
  wait 1.0;
  level.got_gas_mask = 1;

  if(!level.tried_to_get_gun)
    level.try_get_gun_interact scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, -3, 2), &"HOMETOWN/AK47");
}

player_putgasmaskon() {
  setsaveddvar("OMNONNMOTP", "0.1 400 0.1 1000");
  wait 2.0;
  level.gas_mask_overlay = scripts\sp\hud_util::create_client_overlay("gasmask_overlay_russian", 0.0);
  level.gas_mask_overlay.lowresbackground = 1;
  level.gas_mask_overlay fadeovertime(0.5);
  level.gas_mask_overlay.alpha = 1;
  thread scripts\sp\art::dof_enable_script(0, 0, 0, 2, 100, 3.0, 0.0);
  level.player setentitysoundcontext("gender", "gasmask_child_female");
  wait 2.0;

  if(level.player ispcplayer())
    setsaveddvar("OMNONNMOTP", "0.1 400 0.75 1000");
  else
    setsaveddvar("OMNONNMOTP", "0.1 400 3.25 1000");
}

goliath_investigate() {
  level.goliath_ai endon("death");

  for(;;) {
    if(level.goliath_ai scripts\aitypes\stealth::ishunting())
      level.goliath_ai scripts\engine\utility::set_movement_speed(20);
    else
      level.goliath_ai scripts\engine\utility::set_movement_speed(60);

    waitframe();
  }
}

goliath_struggle_stab_slow() {
  level endon("boss_dying");
  level endon("stab_failed");
}

goliath_struggle_stab_slow_player() {
  level endon("boss_dying");
  level endon("stab_failed");
}

goliath_round_monitor() {
  level endon("boss_dying");
  thread goliath_counter_monitor();
  level.goliath_boss_round = 0;
  var_0 = [];

  foreach(var_2 in anim.smartobjectpoints) {
    if(!issubstr(var_2.script_smartobject, "_rage_") && var_2.script_smartobject != "stealth_exposed_fire_up") {
      continue;
    }
    var_2.donotuse = 1;
    var_0[var_0.size] = var_2;
  }

  goliath_grab_init();

  for(;;) {
    level scripts\sp\utility::context_melee_waittill_player_finished();

    if(level.goliath_boss_round == 2) {
      continue;
    }
    level.goliath_boss_round++;

    if(getdvarint("greenlight")) {
      stop_goliath_grab();
      level.goliath_boss_round = 2;
      level.boss_vo.phase = 4;
    }

    thread boss_round_updates(var_0);
    level.goliath_ai waittill("context_melee_anim_ended");
    level.goliath_ai scripts\engine\sp\utility::set_battlechatter(0);
    level.goliath_ai scripts\stealth\enemy::bt_event_combat();
    level.goliath_ai getenemyinfo(level.player);
  }
}

boss_round_updates(var_0) {
  switch (level.goliath_boss_round) {
    case 1:
      stop_goliath_grab();
      break;
    case 2:
      foreach(var_2 in var_0) {
        var_2.donotuse = undefined;

        if(scripts\engine\utility::is_equal(var_2.script_noteworthy, "chair")) {
          var_2.prioritymultiplier = 10;
          continue;
        }

        var_2.prioritymultiplier = 5;
      }

      level.player waittill("knife_change");
  }
}

goliath_grab_init() {
  level.goliath_ai scripts\engine\sp\utility::enable_dontevershoot();
  level.goliath_ai.meleechargedistvsplayer = 2000;
  level.goliath_ai.meleerangesq = 1024;
  level.goliath_ai.meleetryhard = 1;
  thread goliath_grab_monitor();
  thread goliath_grab_give_up_and_shoot();
}

stop_goliath_grab() {
  level.goliath_ai scripts\engine\sp\utility::disable_dontevershoot();
  level.goliath_ai.meleechargedistvsplayer = 200;
  level.goliath_ai.meleerangesq = 4096;
  level.goliath_ai.meleetryhard = undefined;
  level notify("stop_goliath_grab");

  if(isDefined(level.boss_vo) && level.boss_vo.phase < 3) {
    scripts\sp\maps\hometown\hometown_vo.gsc::goto_boss_phase(3);
    level.boss_vo.combat = level.boss_vo.combat_loop;
  }
}

goliath_grab_monitor() {
  level endon("boss_dying");
  level endon("stop_goliath_grab");
  level.player endon("house_enter_grabbed_by_boss");
  level.goliath_ai endon("start_context_melee");

  for(;;) {
    waitframe();

    if(!level.goliath_ai[[level.goliath_ai.fnisinstealthcombat]]()) {
      continue;
    }
    if(distancesquared(level.goliath_ai.origin, level.player.origin) > 2304) {
      continue;
    }
    var_0 = 6;
    var_1 = 40;
    var_2 = (0, 0, 5);

    if(!scripts\engine\trace::capsule_trace_passed(level.player.origin + var_2, level.goliath_ai.origin + var_2, var_0, var_1, level.player.angles, [level.player, level.goliath_ai])) {
      continue;
    }
    var_3 = "boss_capture_";
    var_4 = scripts\engine\math::get_dot(level.player.origin, level.player.angles, level.goliath_ai.origin);

    if(var_4 >= 0.5)
      var_3 = var_3 + "front";
    else if(var_4 <= -0.5)
      var_3 = var_3 + "back";
    else {
      var_4 = vectordot(vectorNormalize(level.goliath_ai.origin - level.player.origin), anglestoright(level.player.angles));

      if(var_4 > 0)
        var_3 = var_3 + "right";
      else
        var_3 = var_3 + "left";
    }

    var_5 = scripts\engine\utility::spawn_script_origin(level.goliath_ai.origin, vectortoangles(level.player.origin - level.goliath_ai.origin));
    level.player_rig = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig", level.player.origin, level.player.angles);
    level.player_rig hide();
    var_5 scripts\common\anim::anim_first_frame_solo(level.player_rig, var_3);
    var_6 = level.player_rig.origin;
    var_7 = level.player_rig.angles;
    var_5 scripts\common\anim::anim_last_frame_solo(level.player_rig, var_3);
    var_8 = level.player_rig.origin;

    if(!scripts\engine\trace::capsule_trace_passed(var_6, var_8, var_0, var_1, var_7, [level.player, level.goliath_ai])) {
      var_5 delete();
      level.player_rig delete();
      continue;
    }

    var_0 = 25;
    var_1 = 60;
    var_6 = level.goliath_ai.origin;
    var_7 = level.goliath_ai.angles;
    var_9 = scripts\engine\sp\utility::spawn_anim_model("goliath_body", level.goliath_ai.origin, level.goliath_ai.angles);
    var_9.animname = "generic";
    var_9 hide();
    var_5 scripts\common\anim::anim_last_frame_solo(var_9, var_3);
    var_8 = var_9.origin;

    if(!scripts\engine\trace::capsule_trace_passed(var_6, var_8, var_0, var_1, var_7, [level.player, level.goliath_ai])) {
      var_5 delete();
      level.player_rig delete();
      var_9 delete();
      continue;
    }

    level.player notify("grabbed_by_boss");
    level.player scripts\sp\player\context_melee::disable_dynamic_takedowns();
    level.player scripts\common\utility::allow_melee(0);
    level.player lerpfovscalefactor(0, 0.5);
    thread goliath_strangle_effects_capture();
    var_5 thread scripts\sp\player_rig::link_player_to_rig(var_3, "stand", 1, 0.2, 0, 5, 5, 5, 5, 1);
    var_5 thread scripts\common\anim::anim_single([level.goliath_ai, level.player_rig], var_3);

    if(!isDefined(level.player_found_a_weapon))
      level scripts\sp\player_death::set_custom_death_quote(61);
    else if(scripts\engine\utility::is_equal(level.player.stealth.hints.causeofdeath, "footstep_sprint"))
      level scripts\sp\player_death::set_custom_death_quote(68);
    else if(player_failed_context_melee())
      level scripts\sp\player_death::set_custom_death_quote(randomintrange(93, 96));
    else
      level scripts\sp\player_death::set_custom_death_quote(58);

    wait 3;
    scripts\sp\utility::missionfailedwrapper();
  }
}

goliath_grab_give_up_and_shoot() {
  level.goliath_ai endon("start_context_melee");
  level.player endon("grabbed_by_boss");

  for(;;) {
    level.goliath_ai waittill("stealth_combat");
    var_0 = 0;
    var_1 = 0;
    var_2 = 0;

    for(;;) {
      if(var_2)
        var_0++;
      else
        var_0 = 0;

      if(var_0 >= 40 || var_1 >= 400) {
        stop_goliath_grab();
        return;
      }

      var_2 = 0;
      waitframe();

      if(!level.goliath_ai[[level.goliath_ai.fnisinstealthcombat]]()) {
        break;
      }

      var_1++;

      if(distancesquared(level.goliath_ai.origin, level.player.origin) > 8100) {
        continue;
      }
      if(!does_goliath_know_where_player_is()) {
        continue;
      }
      if(distancesquared(level.player.origin, getclosestpointonnavmesh(level.player.origin, level.goliath_ai)) < level.goliath_ai.meleerangesq) {
        if(scripts\engine\trace::ray_trace_passed(level.player.origin, level.player.origin + (0, 0, 60), level.player))
          continue;
      }

      var_2 = 1;
    }
  }
}

does_goliath_know_where_player_is() {
  if(level.goliath_ai cansee(level.player))
    return 1;

  var_0 = level.goliath_ai lastknownpos(level.player);

  if(distancesquared(var_0, level.player.origin) < 100)
    return 1;

  if(isDefined(level.player.lowcovervolume) && ispointinvolume(var_0, level.player.lowcovervolume))
    return 1;

  return 0;
}

boss_enter_anim_monitor() {
  level waittill("house_enter_boss_anim_complete");
  level.boss_enter_anim_done = 1;
}

goliath_counter_monitor() {
  level endon("boss_dying");
  level.goliath_ai.context_melee_victim_lives = 1;
  thread goliath_counter_kill();
  level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_counter_back", "back", "tag_view", "player_eye");
  level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_counter_front", "front", "tag_view", "player_eye");
  level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_counter_left", "left", "tag_view", "player_eye");
  level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_counter_right", "right", "tag_view", "player_eye");
  scripts\sp\utility::context_melee_set_hint_directions([]);
  scripts\sp\utility::context_melee_set_custom_hint("stab_soldier_noweap");

  for(;;) {
    level.player waittill("knife_change");

    if(scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_rebar") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_screwdriver") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_scissors")) {
      if(level.goliath_boss_round == 0) {
        level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_stab_round_1_A_slide", "back", "tag_player", undefined, 1);
        level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_stab_round_1_A_slide_left", "left", "tag_player", undefined, 1);
        level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_stab_round_1_A_slide_right", "right", "tag_player", undefined, 1);
        level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_stab_round_1_A_slide_front", "front", "tag_player", undefined, 1);
        level.stab_tag = "TAG_blood_9";
      } else if(level.goliath_boss_round == 1) {
        level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_stab_round_2_A_slide", "back", "tag_player", undefined, 1);
        level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_stab_round_2_A_slide_left", "left", "tag_player", undefined, 1);
        level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_stab_round_2_A_slide_right", "right", "tag_player", undefined, 1);
        level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_stab_round_2_A_slide_front", "front", "tag_player", undefined, 1);
        level.stab_tag = "TAG_blood_8";
      } else if(level.goliath_boss_round == 2)
        level.player.skip_context_melee_anim = 1;
      else {
        level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_stab_round_2_A_slide", "back", "tag_player", undefined, 1);
        level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_stab_round_2_A_slide_left", "left", "tag_player", undefined, 1);
        level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_stab_round_2_A_slide_right", "right", "tag_player", undefined, 1);
        level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_stab_round_2_A_slide_front", "front", "tag_player", undefined, 1);
        level.stab_tag = "TAG_blood_8";
      }

      scripts\sp\utility::context_melee_set_hint_directions(["back", "left", "right", "front"]);
      scripts\sp\utility::context_melee_set_custom_hint("stab_soldier");
      continue;
    }

    level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_counter_back", "back", "tag_view", "player_eye");
    level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_counter_front", "front", "tag_view", "player_eye");
    level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_counter_left", "left", "tag_view", "player_eye");
    level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_counter_right", "right", "tag_view", "player_eye");

    if(scripts\engine\utility::flag("goliath_weapon_exists_hint"))
      scripts\sp\utility::context_melee_set_hint_directions(["back", "left", "right", "front"]);
    else
      scripts\sp\utility::context_melee_set_hint_directions([]);

    scripts\sp\utility::context_melee_set_custom_hint("stab_soldier_noweap");
    scripts\sp\utility::nvidiaansel_scriptdisable(0);
  }
}

goliath_counter_kill() {
  level endon("boss_dying");
  level.player endon("death");

  for(;;) {
    level.goliath_ai waittill("start_context_melee");
    scripts\sp\utility::nvidiaansel_scriptdisable(1);
    level.player setstance("stand", 1);

    if(level.player.context_melee_animation == "boss_counter_front" || level.player.context_melee_animation == "boss_counter_back" || level.player.context_melee_animation == "boss_counter_left" || level.player.context_melee_animation == "boss_counter_right" || level.player.context_melee_animation == "boss_counter_wep_front" || level.player.context_melee_animation == "boss_counter_wep_left" || level.player.context_melee_animation == "boss_counter_wep_right") {
      thread counter_hit_effects();
      thread kill_dad();
      thread kill_hadir();
      scripts\engine\utility::flag_set("disable_autosaves");

      if(isDefined(level.hadir_melee_weapon_pickup))
        level.hadir_melee_weapon_pickup delete();

      level notify("boss_counter_vo_start");
      level waittill("start_blur_fail");
      thread counter_black_fade();
      wait 3.0;
      waitframe();
      level.player enabledeathshield(0);
      waitframe();
      level.player disableinvulnerability();
      level notify("counter_kill");
      wait 1.0;
      scripts\sp\utility::missionfailedwrapper();
    }
  }
}

counter_black_fade() {
  level.counterblackoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  waitframe();
  level.counterblackoverlay fadeovertime(2.25);
  level.counterblackoverlay.alpha = 1.0;
}

counter_hit_effects() {
  level waittill("hit_effects");
  thread painvision_replacement();
  level.player playRumbleOnEntity("heavy_1s");
  level waittill("hit_effects");
  thread painvision_replacement();
  level.player playRumbleOnEntity("heavy_1s");
}

hadir_melee_weapon_spawn_catchup() {
  wait 1.0;
  level.hadir_melee_weapon_pickup = scripts\engine\sp\utility::spawn_anim_model("house_intro_knife", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.hadir_melee_weapon_pickup, "house_dad_dies");
  level.hadir_melee_weapon_pickup thread scripts\sp\maps\hometown\hometown_util.gsc::goliath_melee_weapon_interact("iw8_knife_kid");
}

hadir_melee_weapon_spawn() {
  level.hadir_melee_weapon_pickup thread scripts\sp\maps\hometown\hometown_util.gsc::goliath_melee_weapon_interact("iw8_knife_kid");
}

dad_dies_fight_hits() {
  level endon("house_enter_boss_anim_complete");

  for(;;) {
    level waittill("fight_hit");
    earthquake(0.25, 0.2, level.farah_father_ai.origin, 250);
    level.farah_father_ai playRumbleOnEntity("heavy_1s");
  }
}

dad_dies_fight_hits_hadir() {
  level endon("house_enter_boss_anim_complete");

  for(;;) {
    level waittill("fight_hit_hadir");
    earthquake(0.1, 0.1, level.hadir_body_model.origin, 250);
    level.farah_father_ai playRumbleOnEntity("light_1s");
  }
}

ambient_house_enter_explosions() {
  level endon("kill_random_explos");

  for(;;) {
    wait(randomintrange(10, 16));
    thread scripts\sp\maps\hometown\hometown_anim.gsc::play_house_explo(1);
    wait(randomintrange(10, 16));
    thread scripts\sp\maps\hometown\hometown_anim.gsc::play_house_explo(1);
    wait(randomintrange(10, 16));
    thread scripts\sp\maps\hometown\hometown_anim.gsc::play_house_explo(1);
  }
}

audio_truck_passby_ext() {
  level.player setsoundsubmix("sp_ht_truck_by_door", 1, 1);
  wait 9.5;
  var_0 = spawn("script_origin", (-816, -1712, 58));
  var_0 playSound("scn_hometown_house_truck_by_ext", "trucksounddone");
  var_0 moveTo((-713, -2944, 58), 18, 1, 1);
  var_0 waittill("trucksounddone");
  level notify("truck_passby_done");
  waitframe();
  var_0 stopsounds();
  waitframe();
  var_0 delete();
}

#using_animtree("generic_human");

hadir_boost_mayhem() {
  level.hadir_ai detach("head_sc_m_coto");
  level.hadir_ai setanim(%htf_esc_010_boost_hadir_enter_face, 1.0, 0.0, 1.0);
  level notify("hadir_reached_door");
  level.hadir_ai setanim(%htf_esc_010_boost_hadir_enter_face, 0.0, 0.0, 1.0);
  level.hadir_ai attach("head_sc_m_coto");
}

dad_boost_mayhem() {
  level.father_body_model detach("head_hero_farahs_father");
  level.father_body_model setanim(%htf_esc_010_boost_father_enter_face, 1.0, 0.0, 1.0);
  level notify("hadir_reached_door");
  level.father_body_model setanim(%htf_esc_010_boost_father_enter_face, 0.0, 0.0, 1.0);
  level.father_body_model attach("head_hero_farahs_father");
}

hadir_talk_mayhem() {
  level waittill("mayhem_hadir_talk_start");
  level.hadir_ai detach("head_sc_m_coto");
  level.hadir_ai setanim(%htf_boss_040_hadir_talk_face, 1.0, 0.0, 1.0);
  level waittill("mayhem_hadir_talk_end");
  level.hadir_ai setanim(%htf_boss_040_hadir_talk_face, 0.0, 0.0, 1.0);
  level.hadir_ai attach("head_sc_m_coto");
}

goliath_procedural_bones() {
  if(getdvarint("scr_use_procedural_bones")) {
    level.goliath_body_model setanim(%proc_node, 1.0, 0.0);
    level.goliath_body_model.anim_getrootfunc = scripts\asm\gesture\script_funcs::set_root;
  }
}

hadir_procedural_bones() {
  if(getdvarint("scr_use_procedural_bones")) {
    level.hadir_body_model setanim(%proc_node, 1.0, 0.0);
    level.hadir_body_model.anim_getrootfunc = scripts\asm\gesture\script_funcs::set_root;
  }
}

dad_procedural_bones() {
  if(getdvarint("scr_use_procedural_bones")) {
    level.father_body_model setanim(%proc_node, 1.0, 0.0);
    level.father_body_model.anim_getrootfunc = scripts\asm\gesture\script_funcs::set_root;
  }
}

goliath_swipe_awareness() {
  level.goliath_ai endon("death");
  var_0 = 10000;

  for(;;) {
    if(level.player attackButtonPressed() || level.player meleeButtonPressed()) {
      if(distancesquared(level.goliath_ai.origin, level.player.origin) < var_0) {
        if(level.goliath_ai[[level.goliath_ai.fnisinstealthcombat]]())
          level.goliath_ai getenemyinfo(level.player);
        else
          level.goliath_ai aieventlistenerevent("investigate", level.player, level.player.origin);
      }
    }

    waitframe();
  }
}