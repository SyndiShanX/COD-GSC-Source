/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\hometown\hometown_house.gsc
*******************************************************/

function house_boss_skip_fight_hide_intro() {
  level.boss_skip_fight_overlay fadeovertime(1);
  level.boss_skip_fight_overlay.alpha = 0;
  level.boss_skip_fight_intro fadeovertime(1);
  level.boss_skip_fight_intro.alpha = 0;
  wait 1;
  level.boss_skip_fight_overlay scripts\sp\hud_util::destroyelem();
  level.boss_skip_fight_intro scripts\sp\hud_util::destroyelem();
  level.player freezecontrols(0);
}

function house_boss_skip_fight_show_intro() {
  level.boss_skip_fight_overlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  level.boss_skip_fight_overlay.foreground = 0;
  level.boss_skip_fight_intro = scripts\sp\hud_util::createfontstring("default", 1.8);
  level.boss_skip_fight_intro settext(&"HOMETOWN/BOSS_KILLED");
  level.boss_skip_fight_intro scripts\sp\hud_util::setpoint("CENTER", undefined, 0, -90);
  level.boss_skip_fight_intro.alpha = 0;
  level.boss_skip_fight_intro.foreground = 1;
  level.player freezecontrols(1);
  level.boss_skip_fight_overlay fadeovertime(2);
  level.boss_skip_fight_overlay.alpha = 1;
  level.boss_skip_fight_intro fadeovertime(2);
  level.boss_skip_fight_intro.alpha = 1;
  wait 2;
}

function house_exit_skip_boss_fight_catchup() {
  scripts\engine\sp\utility::set_start_location("house_exit_start", [level.player]);
  var0 = scripts\engine\utility::getStructArray("boss_struggle_loc_" + get_current_house_room(level.player), "script_noteworthy");
  level.boss_struggle_anim_node = scripts\engine\utility::getclosest(level.player.origin, var0);
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
  scripts\sp\maps\hometown\hometown_util::spawn_hadir();
  level.hadir_ai attach("hat_waist_child_hadir_gas_mask", "J_Proc_SpineLower_Swivel");
  level.hadir_ai setModel("body_hero_hadir_child");
  level.farah_father_ai scripts\sp\maps\hometown\hometown_util::kill_and_delete_quietly(level.goliath_ai);
  level.goliath_ai scripts\sp\maps\hometown\hometown_util::kill_and_delete_quietly(level.player);
  level notify("boss_dying");
  level notify("lantern_break");
  scripts\engine\utility::flag_set("lantern_smoke");
  scripts\engine\utility::flag_set("lighting_house_exit_start");
}

function house_enter_main() {
  thread scripts\sp\maps\hometown\hometown_util::transient_unload_carried();
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
  thread scripts\sp\maps\hometown\hometown_vo::house_enter_start_vo();
  scripts\sp\maps\hometown\hometown_util::spawn_hadir();
  level.hadir_body_model = scripts\engine\sp\utility::spawn_anim_model("hadir_body", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  level.hadir_body_model hide();
  thread hadir_procedural_bones();
  level.hadir_body_model attach("head_sc_m_coto");
  level.hadir_body_model.fakeactor_face_anim = 1;
  level.hadir_body_model.animationarchetype = "soldier";
  var0 = scripts\engine\sp\utility::spawn_anim_model("house_intro_pack", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var1 = scripts\engine\sp\utility::spawn_anim_model("house_intro_mask", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var2 = scripts\engine\sp\utility::spawn_anim_model("house_intro_photo", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var3 = scripts\engine\sp\utility::spawn_anim_model("house_intro_lantern", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var4 = scripts\engine\sp\utility::spawn_anim_model("house_intro_cupboard", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var5 = scripts\engine\sp\utility::spawn_anim_model("house_intro_cupboard_b", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var6 = scripts\engine\sp\utility::spawn_anim_model("house_intro_HadirPhone", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  level.house_intro_phone_farah_model = scripts\engine\sp\utility::spawn_anim_model("house_intro_FarahPhone", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var7 = scripts\engine\sp\utility::spawn_anim_model("house_intro_bottle", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var8 = scripts\engine\sp\utility::spawn_anim_model("house_intro_dresser", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var9 = scripts\engine\sp\utility::spawn_anim_model("house_intro_hutch", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var10 = scripts\engine\sp\utility::spawn_anim_model("house_intro_vase", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  var11 = scripts\engine\sp\utility::spawn_anim_model("house_intro_towel", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  thread lantern_fire(level);
  level.hadir_body_model makefakeai();
  level.hadir_body_model.health = 100;
  var0 scriptmoverdistancefade();
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player allowstand(1);
  thread phone_table_interact(var2, var3, var7, var8, var9, var10, var4, var5, var6, var0, var1);
  wait 36;
  scripts\engine\utility::flag_set("objective_prepare_to_escape");
  thread ambient_house_enter_explosions();
  var12 = scripts\engine\utility::spawn_tag_origin(level.house_intro_phone_farah_model.origin);
  var12 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"HOMETOWN/CELLPHONE", 75, 175, 50, 0);
  var12 waittill("trigger");
  level notify("player_got_phone");
  var12 delete();
  level.dad_phone_blocker = getEnt("dad_phone_blocker", "script_noteworthy");
  level.dad_phone_blocker scripts\engine\sp\utility::hide_entity();
  level notify("kill_random_explos");
  level.dead_dad_blocker scripts\engine\sp\utility::show_entity();
  var13 = scripts\engine\utility::getStruct("dad_dead_blocker_wall_loc", "script_noteworthy");
  var14 = level.dead_dad_blocker.origin;
  level.dead_dad_blocker.origin = var13.origin;
  level.gas_attack_anim_node notify("stop_loop");
  level.gas_attack_anim_node notify("stop_play_anim_and_then_loop");
  thread player_phone_pickup_anim();
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_delete(var2, "SceneB_Phones");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_delete(var6, "SceneB_Phones");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_delete(level.house_intro_phone_farah_model, "SceneB_Phones");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(var0, "SceneB_Phones", "house_foyer_idle");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(var1, "SceneB_Phones", "house_foyer_idle");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.farah_father_ai, "SceneB_Phones", "house_foyer_idle");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.hadir_ai, "SceneB_Phones", "house_foyer_idle");
  level.gas_attack_anim_node scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.hadir_body_model, "SceneB_Phones", "house_foyer_idle");
  thread ambient_house_enter_explosions();
  level notify("waiting_in_foyer");
  scripts\engine\utility::flag_wait("player_went_to_foyer");
  waitframe();
  thread audio_truck_passby_ext();
  level notify("kill_random_explos");
  thread late_foyer_save();
  thread boss_enter_anim_monitor();
  level.player.ignoreme = 1;
  scripts\sp\maps\hometown\hometown_util::spawn_goliath_boss();
  scripts\engine\utility::flag_set("russian_entered_house");
  thread house_enter_goliath_kill(var0);
  level thread scripts\sp\utility::context_melee_enable(1);
  level.goliath_melee_weapon_spawn_count = 0;
  thread goliath_player_death_monitor();
  thread goliath_round_monitor();
  thread goliath_knife_monitor();
  thread goliath_player_location_monitor();
  thread goliath_struggle();
  level.hadir_melee_weapon_pickup = scripts\engine\sp\utility::spawn_anim_model("house_intro_knife", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  thread audio_house_boss_enter_music();
  thread lantern_listener();
  thread dad_dies_fight_hits();
  thread dad_dies_fight_hits_hadir();
  thread vfx_doorgas();
  thread boss_stream_pos();
  thread dad_shot_by_boss_listener();
  thread hide_bottle_monitor(var7);
  thread hadir_helps_dad_monitor();
  thread goliath_sees_player_monitor();
  level notify("dad_dies_start");
  level.gas_attack_anim_node notify("stop_loop");
  level.gas_attack_anim_node notify("stop_play_anim_and_then_loop");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(var0, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(var1, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(var3, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(level.hadir_melee_weapon_pickup, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(level.farah_father_ai, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(level.gas_attack_house_door_model, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(level.goliath_ai, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(level.house_intro_deadbolt_model, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(var7, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(var8, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(var9, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(var10, "house_dad_dies");
  level.dead_dad_blocker scripts\engine\utility::delaycall(38, &moveto, var14, 5);
  thread hadir_dad_dies_scene();
  thread shelf_monitor();

  if(scripts\sp\maps\hometown\hometown_util::skipchildrenkillingscene()) {
    level waittill("fight_hit_hadir");
    level waittill("fight_hit_hadir");
    level notify("house_enter_boss_anim_complete");
    level notify("goliath_boss_dead");
    wait 2.5;
    house_boss_skip_fight_show_intro();
    var0 scripts\engine\sp\utility::anim_stopanimScripted();
    var1 scripts\engine\sp\utility::anim_stopanimScripted();
    var3 scripts\engine\sp\utility::anim_stopanimScripted();
    level.hadir_melee_weapon_pickup scripts\engine\sp\utility::anim_stopanimScripted();
    level.farah_father_ai scripts\engine\sp\utility::anim_stopanimScripted();
    level.hadir_ai scripts\engine\sp\utility::anim_stopanimScripted();
    level.hadir_body_model scripts\engine\sp\utility::anim_stopanimScripted();
    level.gas_attack_house_door_model scripts\engine\sp\utility::anim_stopanimScripted();
    level.goliath_ai scripts\engine\sp\utility::anim_stopanimScripted();
    level.house_intro_deadbolt_model scripts\engine\sp\utility::anim_stopanimScripted();
    var7 scripts\engine\sp\utility::anim_stopanimScripted();
    var8 scripts\engine\sp\utility::anim_stopanimScripted();
    var9 scripts\engine\sp\utility::anim_stopanimScripted();
    var10 scripts\engine\sp\utility::anim_stopanimScripted();
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(var0, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(var1, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(var3, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.hadir_melee_weapon_pickup, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.farah_father_ai, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.hadir_ai, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.hadir_body_model, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.gas_attack_house_door_model, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.goliath_ai, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.house_intro_deadbolt_model, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(var7, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(var8, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(var9, "house_dad_dies");
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(var10, "house_dad_dies");
    level.goliath_ai stopsounds();
    level.farah_father_ai stopsounds();
    waitframe();
    house_exit_skip_boss_fight_catchup();
    wait 4;
    thread house_boss_skip_fight_hide_intro();
  } else {
    var15 = getanimlength(level.scr_anim["generic"]["house_dad_dies"]);
    wait var15;
  }

  level notify("house_enter_boss_anim_complete");
  level.hadir_melee_weapon_pickup delete();
  var1 delete();
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

  if(!level.player_got_dad_dies_save) {
    thread house_dad_dies_late_save();
    return;
  }
}

function hadir_dad_dies_scene() {
  level.player endon("grabbed_by_boss");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(level.hadir_ai, "house_dad_dies");
  level.gas_attack_anim_node scripts\common\anim::anim_single_solo(level.hadir_body_model, "house_dad_dies");
  level.hadir_ai delete();
  level.hadir_body_model show();
}

function house_dad_dies_late_save() {
  wait 15;

  if(distancesquared(level.goliath_ai.origin, level.player.origin) > 10000) {
    if(!level.goliath_ai[[level.goliath_ai.fnisinstealthcombat]]()) {
      if(!scripts\engine\utility::flag("disable_autosaves")) {
        scripts\engine\sp\utility::autosave_by_name();
        return;
      }

      return;
    }

    return;
  }
}

function hide_bottle_monitor(var0) {
  wait 38.25;
  var0 hide();
}

function late_foyer_save() {
  wait 10;

  if(!scripts\engine\utility::flag("disable_autosaves")) {
    thread scripts\engine\sp\utility::autosave_now();
  }

  wait 7;
  scripts\engine\utility::flag_set("russian_entered_house_objective");
}

function hadir_helps_dad_monitor() {
  wait 31;
  level.hadir_body_model scriptmoverdistancefade();
  var0 = 1296;

  if(distancesquared(level.goliath_ai.origin, level.player.origin) > var0) {
    if(!scripts\engine\utility::flag("disable_autosaves")) {
      scripts\engine\sp\utility::autosave_now_silent();
    }
  }

  wait 3;
  level.hadir_body_model scriptmoverdistancefade();
}

function dad_shot_by_boss_listener() {
  level waittill("dad_shot_by_boss");
  level.farah_father_ai setModel("body_hero_farahs_father_bloody");
  level.farah_father_ai playRumbleOnEntity("heavy_3s");
}

function vfx_doorgas() {
  wait 17;
  scripts\engine\utility::exploder("doorgas");
}

function goliath_sees_player_monitor() {
  level endon("house_enter_boss_anim_complete");

  for(;;) {
    waitframe();

    if(level.goliath_ai cansee(level.player)) {
      level.goliath_ai.player_seen_pos = level.player.origin;
    }
  }
}

function audio_house_enter_music() {
  wait 0.1;
  setmusicstate("");
  wait 2;
  setmusicstate("mx_hometown_04_house_lp");
}

function audio_house_boss_enter_music() {
  wait 4;
  setmusicstate("mx_hometown_05_house_fight");
}

function phone_table_interact(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  level.gas_attack_anim_node notify("stop_loop");
  level.gas_attack_anim_node notify("stop_play_anim_and_then_loop");
  thread audio_door_slam_shut();
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(var0, "SceneB_Phones");
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(var1, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(level.house_intro_deadbolt_model, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(var2, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(var3, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(var4, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(var5, "house_dad_dies");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("house_intro_towel", "house_find_hadir");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("house_intro_prop01", "house_get_mask_kitchen");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("house_intro_prop02", "house_get_mask_kitchen");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("house_intro_prop03", "house_get_mask_kitchen");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(var6, "house_get_mask_kitchen");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(var7, "house_get_mask_kitchen");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(level.gas_attack_house_door_model, "house_find_hadir");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(var8, "house_find_hadir");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(level.house_intro_phone_farah_model, "house_find_hadir");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(var9, "house_find_hadir", "house_find_hadir_idle");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(var10, "house_find_hadir", "house_find_hadir_idle");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.farah_father_ai, "house_find_hadir", "house_find_hadir_idle");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.hadir_ai, "house_find_hadir", "house_find_hadir_idle");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.hadir_body_model, "house_find_hadir", "house_find_hadir_idle");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(level.house_intro_deadbolt_model, "SceneB_Phones");
}

function audio_door_slam_shut() {
  wait 1.5;
  thread scripts\engine\utility::play_sound_in_space("htf_ff_hf_010_sceneb_door_01", (-1300, -2494, 62));
}

function audio_distant_gas_death_scream_handler() {
  level waittill("house_entered");
  thread audio_distant_gas_death_screams_01();
  thread audio_distant_gas_death_screams_02();
  thread audio_distant_gas_death_screams_03();
}

function audio_distant_gas_death_screams_01() {
  var0 = randomfloatrange(2, 12);
  wait var0;
  level endon("death");
  var1 = spawn("script_origin", (-581, -2769, 95));
  level.death_01_snd_handle = undefined;

  for(;;) {
    if(!isDefined(level.death_01_snd_handle)) {
      level.death_01_snd_handle = scripts\engine\utility::play_sound_in_space("emt_dist_death_screams", (-581, -2769, 95), 0, var1);
    }

    if(scripts\engine\utility::flag("russian_entered_house")) {
      if(isDefined(level.death_01_snd_handle)) {
        level.death_01_snd_handle thread scripts\engine\sp\utility::sound_fade_and_delete(5);
      }

      break;
    }

    var2 = randomfloatrange(15, 25);
    wait var2;
    level.death_01_snd_handle = undefined;
  }

  var1 delete();
  var1 = undefined;

  if(isDefined(level.death_01_snd_handle)) {
    level.death_01_snd_handle = undefined;
    return;
  }
}

function audio_distant_gas_death_screams_02() {
  var0 = randomfloatrange(2, 12);
  wait var0;
  level endon("death");
  var1 = spawn("script_origin", (-689, -1618, 74));
  level.death_02_snd_handle = undefined;

  for(;;) {
    if(!isDefined(level.death_02_snd_handle)) {
      level.death_02_snd_handle = scripts\engine\utility::play_sound_in_space("emt_dist_death_screams", (-689, -1618, 74), 0, var1);
    }

    if(scripts\engine\utility::flag("russian_entered_house")) {
      if(isDefined(level.death_02_snd_handle)) {
        level.death_02_snd_handle thread scripts\engine\sp\utility::sound_fade_and_delete(5);
      }

      break;
    }

    var2 = randomfloatrange(15, 25);
    wait var2;
    level.death_02_snd_handle = undefined;
  }

  var1 delete();
  var1 = undefined;

  if(isDefined(level.death_02_snd_handle)) {
    level.death_02_snd_handle = undefined;
    return;
  }
}

function audio_distant_gas_death_screams_03() {
  var0 = randomfloatrange(2, 12);
  wait var0;
  level endon("death");
  var1 = spawn("script_origin", (-1843, -1419, 121));
  level.death_03_snd_handle = undefined;

  for(;;) {
    if(!isDefined(level.death_03_snd_handle)) {
      level.death_03_snd_handle = scripts\engine\utility::play_sound_in_space("emt_dist_death_screams", (-1843, -1419, 121), 0, var1);
    }

    if(scripts\engine\utility::flag("russian_entered_house")) {
      if(isDefined(level.death_03_snd_handle)) {
        level.death_03_snd_handle thread scripts\engine\sp\utility::sound_fade_and_delete(5);
      }

      break;
    }

    var2 = randomfloatrange(15, 25);
    wait var2;
    level.death_03_snd_handle = undefined;
  }

  var1 delete();
  var1 = undefined;

  if(isDefined(level.death_03_snd_handle)) {
    level.death_03_snd_handle = undefined;
    return;
  }
}

function shelf_monitor() {
  level waittill("shelf_broken");
  playmayhem("mayhem_shelf_model");
}

function player_phone_pickup_anim() {
  var0 = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  scripts\engine\utility::flag_set("lighting_cellphone_moment");
  level.player_rig = var0;
  level.gas_attack_anim_node thread scripts\sp\player_rig::link_player_to_rig("SceneB_Phones", "stand", 1, 0.5, 1);
  level.gas_attack_anim_node scripts\common\anim::anim_single_solo(var0, "SceneB_Phones");
  scripts\sp\player_rig::unlink_player_from_rig(0, "stand");
  level.door_clip_boss_enter solid();
  waitframe();
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player allowstand(1);
}

function lantern_listener() {
  level waittill("lantern_break");
  scripts\engine\utility::flag_set("lantern_break");
}

function lantern_fire(var0) {
  playFXOnTag(level._effect["vfx_htown_lantern_flame"], var0, "tag_origin");
  scripts\engine\utility::flag_wait("lantern_break");
  wait 0.1;
  var1 = scripts\engine\utility::spawn_tag_origin(var0.origin, anglesToForward(var0.angles) * -1);
  thread sfx_lantern_fire(var0.origin);
  thread lanter_fire_damage(var0);
  stopFXOnTag(level._effect["vfx_htown_lantern_flame"], var0, "tag_origin");
  playFXOnTag(level._effect["vfx_htown_lantern_fire"], var1, "tag_origin");
  thread scripts\engine\utility::exploder("wallfire");
  thread scripts\engine\utility::exploder("ceilingsmoke");
  visionsetnaked("hometown_house_int_postfire", 10);
  scripts\engine\utility::flag_wait("lantern_smoke");
  scripts\engine\utility::flag_wait("lantern_spawned");
  stopFXOnTag(level._effect["vfx_htown_lantern_fire"], var1, "tag_origin");
  scripts\engine\utility::stop_exploder("wallfire");
  thread scripts\engine\utility::exploder("wallfire_post");
  scripts\engine\utility::stop_exploder("ceilingsmoke");
  level.lantern_fire_trigger delete();
}

function lanter_fire_damage(var0) {
  wait 1;
  scripts\engine\utility::flag_set("lantern_spawned");
  var1 = 5;
  var2 = 10;
  var3 = var0.origin - (12, 0, 0);
  level.lantern_fire_trigger = spawn("trigger_radius_fire", var3, 0, var1, var2);
  level.lantern_fire_trigger.script_damage = 5;
  thread scripts\sp\trigger::trigger_fire(level.lantern_fire_trigger);
}

function sfx_lantern_fire(var0) {
  var1 = spawn("script_origin", (-1349, -2571, 51));
  var1 playSound("scn_hometown_lantern_fire_ignite");
  wait 1;
  var1 playLoopSound("scn_hometown_lantern_fire_lp");
  scripts\engine\utility::flag_wait("lantern_smoke");
  var1 playLoopSound("scn_hometown_lantern_fire_smolder_lp");
}

function house_enter_goliath_kill(var0) {
  level endon("house_enter_boss_anim_complete");
  var1 = 576;

  for(;;) {
    waitframe();

    if(distancesquared(level.goliath_ai.origin, level.player.origin) > var1) {
      continue;
    }

    var2 = 5;
    var3 = 60;
    var4 = (0, 0, 5);

    if(!scripts\engine\trace::capsule_trace_passed(level.player.origin + var4, level.goliath_ai.origin + var4, var2, var3, level.player.angles, [level.player, level.goliath_ai])) {
      continue;
    }

    level.player notify("grabbed_by_boss");
    level.player notify("house_enter_grabbed_by_boss");
    level.player scripts\sp\player\context_melee::disable_dynamic_takedowns();
    level.player scripts\common\utility::allow_melee(0);
    level.player lerpfovscalefactor(0, 0.5);
    scripts\engine\utility::flag_set("disable_autosaves");

    if(isDefined(level.hadir_melee_weapon_pickup)) {
      level.hadir_melee_weapon_pickup delete();
    }

    var5 = "boss_capture_";
    var6 = scripts\engine\math::get_dot(level.player.origin, level.player.angles, level.goliath_ai.origin);

    if(var6 >= 0.5) {
      var5 += "front";
    } else if(var6 <= -0.5) {
      var5 += "back";
    } else {
      var6 = vectordot(vectorNormalize(level.goliath_ai.origin - level.player.origin), anglestoright(level.player.angles));

      if(var6 > 0) {
        var5 += "right";
      } else {
        var5 += "left";
      }
    }

    var7 = scripts\engine\utility::spawn_script_origin(level.goliath_ai.origin, vectortoangles(level.player.origin - level.goliath_ai.origin));

    if(level.player istouching(getEnt("boss_grab_near_door_trigger", "script_noteworthy"))) {
      var8 = scripts\engine\utility::getStruct("anim_preview_loc_4", "targetname");
      var7 moveTo(var8.origin, 1);
    }

    thread kill_dad(var0);
    thread kill_hadir();
    thread goliath_strangle_effects_capture();
    thread house_enter_animate_and_kill_player(var7, var5);
    return;
  }
}

function house_enter_animate_and_kill_player(var0, var1) {
  level.player_rig = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig", level.player.origin, level.player.angles);
  var0 scripts\sp\player_rig::link_player_to_rig(var1, "stand", 1, 0.2, 0, 5, 5, 5, 5, 1);
  var0 thread scripts\common\anim::anim_single([level.goliath_ai, level.player_rig], var1);
  level scripts\sp\player_death::set_custom_death_quote(78);
  wait 3;
  scripts\sp\utility::missionfailedwrapper();
}

function kill_dad(var0) {
  wait 1;

  if(isDefined(var0)) {
    var0 hide();
  }

  if(isDefined(level.farah_father_ai)) {
    level.farah_father_ai.skipdeathanim = 1;
    level.farah_father_ai scripts\engine\sp\utility::anim_stopanimScripted();
    level.farah_father_ai scripts\common\ai::stop_magic_bullet_shield();
    level.farah_father_ai.diequietly = 1;
    waitframe();
    level.farah_father_ai kill(level.farah_father_ai.origin, level.goliath_ai);
    return;
  }
}

function kill_hadir() {
  wait 1;

  if(isDefined(level.hadir_ai)) {
    level.hadir_ai.skipdeathanim = 1;
    level.hadir_ai scripts\engine\sp\utility::anim_stopanimScripted();
    level.hadir_ai scripts\common\ai::stop_magic_bullet_shield();
    level.hadir_ai.diequietly = 1;
    waitframe();
    level.hadir_ai kill(level.hadir_ai.origin, level.goliath_ai);
    return;
  }
}

function house_enter_trigger_monitor() {
  scripts\engine\sp\utility::trigger_wait("kitchen_gas_mask_scene_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("player_went_to_kitchen");
  scripts\engine\sp\utility::trigger_wait("foyer_dad_dies_scene_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("player_went_to_foyer");
}

function house_boss_main() {
  level thread scripts\sp\utility::context_melee_enable(1);
  setsaveddvar("OMNONNMOTP", "0.1 400 2.25 1000");
  level.current_knock_off = "drop_all";
  thread scripts\sp\maps\hometown\hometown_util::goliath_delete_weapon_interacts_monitor();
  thread goliath_blood_stab_vfx();
  thread weapon_knock_off_room_monitor();
  thread scripts\sp\maps\hometown\hometown_util::search_ground_hint();
  thread goliath_swipe_awareness();
  setsaveddvar("TMTPTQNMN", 1);
  setmusicstate("mx_hometown_06_house_evade_01_lp");
  thread scripts\sp\analytics::analytics_kleenex_update("House Boss Start to First Stab");
  level.father_body_model = scripts\engine\sp\utility::spawn_anim_model("farah_father_body", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  thread dad_procedural_bones();
  level.father_body_model attach("head_hero_farahs_father");
  level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.father_body_model, "house_dad_dead_frame");

  if(isDefined(level.hadir_ai)) {
    level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.hadir_ai, "house_dad_dead_frame");
  }

  level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.hadir_body_model, "house_dad_dead_frame");
  waitframe();
  scripts\common\anim::anim_set_time([level.father_body_model, level.hadir_body_model], "house_dad_dead_frame", 1);

  if(isDefined(level.hadir_ai)) {
    scripts\common\anim::anim_set_time([level.hadir_ai], "house_dad_dead_frame", 1);
  }

  thread scripts\sp\maps\hometown\hometown_vo::house_boss_start_vo();
  level notify("dad_stabbed_chest");

  if(isDefined(level.hadir_ai)) {
    level.hadir_ai delete();
  }

  level.hadir_body_model show();
  level.hadir_body_model notsolid();
  level.father_body_model notsolid();

  if(isDefined(level.farah_father_ai)) {
    level.farah_father_ai scripts\sp\maps\hometown\hometown_util::kill_and_delete_quietly(level.goliath_ai);
  }

  var0 = scripts\engine\utility::getStruct("buried_start", "targetname");
  waitframe();
  thread house_boss_analytics();
  thread goliath_investigate();
  scripts\engine\utility::flag_set("objective_find_a_weapon");

  if(isDefined(level.goliath_ai.player_seen_pos) && distancesquared(level.goliath_ai.player_seen_pos, level.player.origin) < 1024) {
    level.goliath_ai aieventlistenerevent("combat", level.player, level.player.origin);
    level.goliath_ai.player_seen_pos = undefined;
  }

  level waittill("goliath_boss_dead");
  setsaveddvar("TMTPTQNMN", 0);
  level.goliath_ai scripts\sp\maps\hometown\hometown_util::kill_and_delete_quietly(level.player);
  scripts\sp\maps\hometown\hometown_util::clear_goliath_bloody_footsteps();
  thread scripts\engine\sp\utility::autosave_by_name("boss_dead");
}

function boss_stream_pos() {
  var0 = scripts\engine\utility::getStruct("boss_stream_pos", "script_noteworthy");
  wait 0.1;
  var1 = spawn("script_model", var0.origin);
  var1 setModel("body_russian_soldier_boss_stab_1_chest_dad");
  wait 0.1;
  var2 = spawn("script_model", var0.origin);
  var2 setModel("body_russian_soldier_boss_stab_2_leg_l_back");
  wait 0.1;
  var3 = spawn("script_model", var0.origin);
  var3 setModel("body_russian_soldier_boss_stab_3_leg_r_back");
  wait 0.1;
  var4 = spawn("script_model", var0.origin);
  var4 setModel("body_russian_soldier_boss_stab_4_neck");
  wait 0.1;
  var5 = spawn("script_model", var0.origin);
  var5 setModel("body_russian_soldier_boss_stab_5_chest_a");
  wait 0.1;
  var6 = spawn("script_model", var0.origin);
  var6 setModel("body_russian_soldier_boss_stab_6_chest_b");
  wait 0.1;
  var7 = spawn("script_model", var0.origin);
  var7 setModel("body_russian_soldier_boss_stab_7_chest_c");
  wait 0.1;
  var8 = spawn("script_model", var0.origin);
  var8 setModel("body_russian_soldier_boss_stab_8_chest_d");
  wait 0.1;
  var9 = spawn("script_model", var0.origin);
  var9 setModel("body_russian_soldier_boss_stab_9_gunshots");
  wait 0.1;
  var10 = spawn("script_model", var0.origin);
  var10 setModel("body_hero_farahs_father_bloody");
  wait 0.1;
  level waittill("goliath_boss_dead");
}

function house_boss_analytics() {
  level.goliath_ai waittill("start_context_melee");
  thread scripts\sp\analytics::analytics_kleenex_update("First Stab to Second Stab");
  level.goliath_ai waittill("start_context_melee");
  thread scripts\sp\analytics::analytics_kleenex_update("Second Stab to House Boss End");
}

function weapon_knock_off_room_monitor() {
  level endon("boss_dying");
  var0 = [];

  foreach(var2 in getEntArray("house_room_trigger", "targetname")) {
    var3 = spawnStruct();
    var3.trigger = var2;
    var3.smartobjects = [];
    var0 = var3;
  }

  var5 = [];

  foreach(var7 in anim.smartobjectpoints) {
    if(!issubstr(var7.script_smartobject, "knock_off")) {
      continue;
    }

    var5 = var7;
    var7.prioritymultiplier = 100;

    foreach(var9, var3 in var0) {
      if(ispointinvolume(var7.origin, var3.trigger)) {
        var7.room = var9;
        var3.smartobjects[var3.smartobjects.size] = var7;
        break;
      }
    }
  }

  foreach(var3 in var0) {
    if(!var3.smartobjects.size) {
      var0 = scripts\engine\utility::array_remove_key(var0, var9);
    }
  }

  for(;;) {
    level waittill("knock_off", var7);
    thread scripts\engine\utility::play_sound_in_space("scn_hometown_brute_knock_smartobj", var7.origin);

    if(isDefined(var7.script_noteworthy)) {
      level.current_knock_off = var7.script_noteworthy;
    }

    var3 = var0[var7.room];

    foreach(var7 in var3.smartobjects) {
      var7.donotuse = 1;
      var5 = scripts\engine\utility::array_remove(var5, var7);
    }

    var0 = scripts\engine\utility::array_remove_key(var0, var7.room);

    if(!var0.size) {
      return;
    }
  }
}

function prioritize_knock_off_on_context_melee(var0) {
  level endon("knock_off");
  level.goliath_ai waittill("start_context_melee");

  foreach(var2 in var0) {
    var2.prioritymultiplier = 100;
  }
}

function goliath_player_death_monitor() {
  level endon("boss_dying");
  scripts\engine\utility::waittill_any_ents(level, "counter_kill", level.player, "death");

  if(isDefined(level.goliath_weapon_exists)) {
    if(!isDefined(level.player_found_a_weapon)) {
      level scripts\sp\player_death::set_custom_death_quote(61);
      return;
    }

    if(scripts\engine\utility::is_equal(level.player.stealth.hints.causeofdeath, "footstep_sprint")) {
      level scripts\sp\player_death::set_custom_death_quote(68);
      return;
    }

    if(player_failed_context_melee()) {
      level scripts\sp\player_death::set_custom_death_quote(randomintrange(93, 96));
      return;
    }

    if(isDefined(level.player_found_a_weapon) && !isDefined(level.player_stabbed_boss)) {
      level scripts\sp\player_death::set_custom_death_quote(58);
      return;
    }

    if(isDefined(level.player_found_a_weapon) && isDefined(level.player_stabbed_boss)) {
      if(scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_rebar") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_screwdriver") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_scissors")) {
        level scripts\sp\player_death::set_custom_death_quote(scripts\engine\utility::random([58, 93, 94, 95]));
        return;
      }

      level scripts\sp\player_death::set_custom_death_quote(79);
      return;
    }

    return;
  }

  level scripts\sp\player_death::set_custom_death_quote(58);
}

function player_failed_context_melee() {
  if(scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_rebar") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_screwdriver") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_scissors")) {
    if(isDefined(level.player.context_melee_last_inactive_time) && gettime() - level.player.context_melee_last_inactive_time < 3000) {
      return true;
    } else if(getdvarint("context_melee_debug")) {
      iprintln("active too long ago: " + gettime() - level.player.context_melee_last_inactive_time);
    }
  }

  return false;
}

function goliath_knife_monitor() {
  level endon("boss_dying");

  for(;;) {
    level.goliath_ai waittill("start_context_melee");
    thread launch_player_from_boss();
    var0 = level.player getcurrentweapon();
    thread goliath_knife_fov_scale_factor();
    var1 = undefined;

    if(var0.basename == "iw8_knife_kid") {
      level.player.context_melee_knife = "weapon_vm_me_kitchen_knife";
    } else if(var0.basename == "iw8_knife_kid_rebar") {
      level.player.context_melee_knife = "weapon_vm_me_screwdriver";
    } else if(var0.basename == "iw8_knife_kid_scissors") {
      level.player.context_melee_knife = "weapon_vm_me_scissors";
    } else if(var0.basename == "iw8_knife_kid_screwdriver") {
      level.player.context_melee_knife = "weapon_vm_me_screwdriver";
    } else {
      level.player.context_melee_knife = "tag_origin";
      var1 = "true";
    }

    level notify("boss_stab_vo_start");
    thread audio_music_stab();
    var2 = level.player.origin;
    level.player setstance("stand", 1);
    level waittill("player_knife_part_done");

    if(!scripts\engine\utility::flag("disable_autosaves")) {
      thread scripts\engine\sp\utility::autosave_now();
    }

    var3 = spawn("script_model", level.player.origin);
    var3 setModel(level.player.context_melee_knife);
    var3 notsolid();
    var3 linkTo(level.goliath_ai, "tag_accessory_left", (0, 0, 0), (0, 0, 0));
    waitframe();
    level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_counter_back", "back", "tag_view", "player_eye");
    level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_counter_front", "front", "tag_view", "player_eye");
    level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_counter_left", "left", "tag_view", "player_eye");
    level.goliath_ai scripts\sp\utility::context_melee_override_anim("boss_counter_right", "right", "tag_view", "player_eye");
    level.goliath_ai aieventlistenerevent("combat", level.player, level.player.origin);
    level scripts\sp\utility::context_melee_waittill_player_finished();
    level.player takeweapon(var0);
    level.player notify("knife_change");
    level.player enableweapons();
    level.player giveweapon("iw8_gunless_farrah");
    level.player switchtoweapon("iw8_gunless_farrah");
    waitframe();
    level.player_stabbed_boss = 1;
    level waittill("enemy_knife_part_done");
    var3 delete();
    var4 = scripts\engine\utility::getStruct("known_loc_" + level.current_room, "script_noteworthy");
    level.goliath_ai aieventlistenerevent("combat", level.player, var4.origin);
    var5 = level.goliath_ai gettagangles("tag_accessory_left");
    var6 = level.goliath_ai gettagorigin("tag_accessory_left");
    var7 = spawn("script_model", var6);

    if(var0.basename == "iw8_knife_kid") {
      var7 setModel("weapon_wm_me_kitchen_knife");
    } else if(var0.basename == "iw8_knife_kid_rebar") {
      var7 setModel("weapon_wm_me_screwdriver");
    } else if(var0.basename == "iw8_knife_kid_scissors") {
      var7 setModel("weapon_wm_me_scissors");
    } else if(var0.basename == "iw8_knife_kid_screwdriver") {
      var7 setModel("weapon_wm_me_screwdriver");
    } else {
      var7 setModel("weapon_vm_me_screwdriver");
    }

    var8 = anglesToForward(var5);
    var8 *= randomfloatrange(100, 150);
    var9 = var8[0];
    var10 = var8[1];
    var11 = randomfloatrange(100, 200);
    var7 physicslaunchserver(var7.origin, (var9, var10, var11));
    wait 1.8;
    var7 thread scripts\sp\maps\hometown\hometown_util::goliath_melee_weapon_interact(var0.basename);
  }
}

function launch_player_from_boss() {
  self endon("pain_fx_done");
  waitframe();
  level.player.melee_arms setModel(scripts\sp\maps\hometown\hometown_util::getfarrahbloodymodel());
  level waittill("impact_effects");
  thread sfx_impact_shellshock();
  wait 1;
  self endon("pain_fx_done");
}

function sfx_impact_shellshock() {
  level.player shellshock("default_nosound", 2);
  level.player scripts\engine\utility::delaycall(2.5, &fadeoutshellshock);
  var0 = spawn("script_origin", level.player.origin);
  var0 linkTo(level.player);
  var0 playLoopSound("flashbang_tinnitus_loop");
  var0 scripts\engine\sp\utility::sound_fade_and_delete(3, 1);
}

function goliath_knife_fov_scale_factor() {
  level.player lerpfovscalefactor(0, 0.5);
  level waittill("impact_effects");
  level.player lerpfovscalefactor(1, 0);
}

function launch_player_physics() {
  var0 = anglesToForward(level.player.angles) * -1;
  var0 *= 60;

  for(var1 = 1; var1 < 10; var1++) {
    level.player setvelocity(var0);
    var0 -= 10;
    waitframe();
  }
}

function goliath_player_location_monitor() {
  level endon("boss_dying");
  var0 = getEnt("foyer", "script_noteworthy");
  var1 = getEnt("hall", "script_noteworthy");
  var2 = getEnt("kids_room", "script_noteworthy");
  var3 = getEnt("kitchen", "script_noteworthy");
  var4 = getEnt("bathroom", "script_noteworthy");
  var5 = getEnt("master_bedroom", "script_noteworthy");
  var6 = getEnt("living_room", "script_noteworthy");
  level.current_room = "living_room";

  for(;;) {
    var7 = level.current_room;

    if(level.player istouching(var0)) {
      level.current_room = "foyer";
    } else if(level.player istouching(var1)) {
      level.current_room = "hall";
    } else if(level.player istouching(var2)) {
      level.current_room = "kids_room";
    } else if(level.player istouching(var3)) {
      level.current_room = "kitchen";
    } else if(level.player istouching(var4)) {
      level.current_room = "bathroom";
    } else if(level.player istouching(var5)) {
      level.current_room = "master_bedroom";
    } else if(level.player istouching(var6)) {
      level.current_room = "living_room";
    } else {
      level.current_room = "living_room";
    }

    if(level.current_room != var7) {
      level notify("room_changed");
    }

    waitframe();
  }
}

function goliath_boss_location_monitor() {
  level endon("boss_dying");
  var0 = getEnt("foyer", "script_noteworthy");
  var1 = getEnt("hall", "script_noteworthy");
  var2 = getEnt("kids_room", "script_noteworthy");
  var3 = getEnt("kitchen", "script_noteworthy");
  var4 = getEnt("bathroom", "script_noteworthy");
  var5 = getEnt("master_bedroom", "script_noteworthy");
  var6 = getEnt("living_room", "script_noteworthy");
  thread goliath_room_time_monitor();
  level.boss_current_room = "living_room";

  for(;;) {
    var7 = level.boss_current_room;

    if(level.goliath_ai istouching(var0)) {
      level.boss_current_room = "foyer";
    } else if(level.goliath_ai istouching(var1)) {
      level.boss_current_room = "hall";
    } else if(level.goliath_ai istouching(var2)) {
      level.boss_current_room = "kids_room";
    } else if(level.goliath_ai istouching(var3)) {
      level.boss_current_room = "kitchen";
    } else if(level.goliath_ai istouching(var4)) {
      level.boss_current_room = "bathroom";
    } else if(level.goliath_ai istouching(var5)) {
      level.boss_current_room = "master_bedroom";
    } else if(level.goliath_ai istouching(var6)) {
      level.boss_current_room = "living_room";
    } else {
      level.boss_current_room = "living_room";
    }

    if(level.boss_current_room != var7) {
      level notify("boss_room_changed");
    }

    waitframe();
  }
}

function goliath_room_time_monitor() {
  level endon("boss_dying");
  level.min_time_in_room = 0;

  for(;;) {
    level waittill("boss_room_changed");
    level.min_time_in_room = 0;
    var0 = gettime();
    var1 = var0;

    while(var0 <= var1 + 10000) {
      var0 = gettime();
      waitframe();
    }

    level.min_time_in_room = 1;
    waitframe();
  }
}

function goliath_hunt_known_location_monitor() {
  level endon("boss_dying");

  for(;;) {
    level waittill("room_changed");
    wait randomfloatrange(4, 6);

    while(!level.min_time_in_room) {
      waitframe();
    }

    var0 = scripts\engine\utility::getStruct("known_loc_" + level.current_room, "script_noteworthy");

    if(level.goliath_ai scripts\aitypes\stealth::ishunting()) {
      scripts\stealth\group::group_updatepodhuntorigin(level.goliath_ai, var0.origin);
    }
  }
}

function goliath_strangle_effects() {
  level.eyeshutoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  wait 0.1;
  level.eyeshutoverlay fadeovertime(2);
  level.eyeshutoverlay.alpha = 0.5;
  setblur(1.5, 2);
  wait 3;
  level notify("hadir_stabbed_neck");
  level.eyeshutoverlay fadeovertime(0.75);
  level.eyeshutoverlay.alpha = 0;
  setsaveddvar("MLTTMLTKOR", 0.01);
  setsaveddvar("LSOPQMRPNR", 0.002);
  setblur(0, 0.75);
}

function goliath_strangle_effects_capture() {
  level.eyeshutoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  wait 0.1;
  level.eyeshutoverlay fadeovertime(2);
  level.eyeshutoverlay.alpha = 0.5;
  setblur(1.5, 2);
}

function goliath_struggle_lights() {
  level.boss_struggle_light_key = getEnt("boss_light_key", "script_noteworthy");
  level.boss_struggle_light_key setlightintensity(0);
  level.boss_struggle_light_key setlightcolor((255, 242, 230));
  level.boss_struggle_light_key setlightradius(60);
  level.boss_struggle_light_key setlightfovrange(70, 50);
  level.boss_struggle_light_fill = getEnt("boss_light_fill", "script_noteworthy");
  level.boss_struggle_light_fill setlightintensity(0);
  level.boss_struggle_light_fill setlightcolor((255, 241, 228));
  level.boss_struggle_light_fill setlightradius(55);
  level.boss_struggle_light_fill setlightfovrange(70, 50);
  level.boss_struggle_lights_node = getEnt("boss_light_org", "script_noteworthy");
  level.boss_struggle_light_key linkTo(level.boss_struggle_lights_node);
  level.boss_struggle_light_fill linkTo(level.boss_struggle_lights_node);
  var0 = level.boss_struggle_lights_node.origin;
  var1 = level.boss_struggle_lights_node.angles;
  level.boss_struggle_lights_node.origin = level.boss_struggle_anim_node.origin;
  level.boss_struggle_lights_node.angles = level.boss_struggle_anim_node.angles;
  level.boss_struggle_lights_node linkTo(level.boss_struggle_anim_node);
  wait 1;
  thread goliath_struggle_key_intensity(0.35, 0.01);
  thread goliath_struggle_fill_intensity(0.12, 0.01);
  level waittill("set_boss_lights_og");
  level.boss_struggle_lights_node.origin = var0;
  level.boss_struggle_lights_node.angles = var1;
  waitframe();
  level.boss_struggle_lights_node delete();
}

function goliath_struggle_key_intensity(var0, var1) {
  var2 = 0;

  while(var2 < var0) {
    level.boss_struggle_light_key setlightintensity(var2);
    var2 += var1;
    waitframe();
  }

  level waittill("fade_boss_lights_off");

  while(var2 >= 0.1) {
    level.boss_struggle_light_key setlightintensity(var2);
    var2 -= var1;
    waitframe();
  }

  level.boss_struggle_light_key setlightintensity(0);
  wait 1;
  level notify("set_boss_lights_og");
}

function goliath_struggle_fill_intensity(var0, var1) {
  var2 = 0;

  while(var2 < var0) {
    level.boss_struggle_light_fill setlightintensity(var2);
    var2 += var1;
    waitframe();
  }

  level waittill("fade_boss_lights_off");

  while(var2 >= 0.1) {
    level.boss_struggle_light_fill setlightintensity(var2);
    var2 -= var1;
    waitframe();
  }

  level.boss_struggle_light_fill setlightintensity(0);
  wait 1;
  level notify("set_boss_lights_og");
}

function goliath_struggle() {
  self endon("stab_delay_time_exceeded");
  level.player waittill("skipped_melee_anim");
  scripts\engine\utility::flag_set("lantern_smoke");
  var0 = level.player.context_melee_direction;
  level.player setstance("stand", 1);
  setmusicstate("mx_hometown_11_last_stab_miss");
  level.goliath_ai.ignoreall = 1;
  level.boss_struggle_anim_node = level.goliath_ai scripts\engine\utility::spawn_tag_origin();
  thread goliath_struggle_lights();
  var1 = scripts\engine\utility::getStructArray("boss_struggle_loc_" + get_current_house_room(level.player), "script_noteworthy");
  var2 = scripts\engine\utility::getclosest(level.player.origin, var1);
  level.boss_struggle_anim_node_safe = var2;
  level.boss_struggle_anim_node moveTo(var2.origin, 3);
  level.boss_struggle_anim_node rotateTo(var2.angles, 3);
  level.player disableweapons();
  level.boss_struggle_player_model = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig", level.boss_struggle_anim_node.origin, level.boss_struggle_anim_node.angles);
  level.boss_kill_sling_model = scripts\engine\sp\utility::spawn_anim_model("boss_kill_sling", level.goliath_ai.origin, level.goliath_ai.angles);
  level.boss_kill_sling_model hide();
  level.player_rig = level.boss_struggle_player_model;

  if(var0 == "back") {
    var3 = "boss_grab";
  } else if(var1 == "right") {
    var3 = "boss_grab_right";
  } else if(var2 == "left") {
    var3 = "boss_grab_left";
  } else if(var3 == "front") {
    var3 = "boss_grab_front";
  } else {
    var3 = "boss_grab";
  }

  level.boss_struggle_player_model setModel(scripts\sp\maps\hometown\hometown_util::getfarrahbloodymodel());
  level.boss_struggle_anim_node thread scripts\sp\player_rig::link_player_to_rig(var3, "stand", 1, 0.3, 0, 0, 0, 0, 0, 1);
  level.boss_struggle_player_model linkTo(level.boss_struggle_anim_node);
  level.goliath_ai linkTo(level.boss_struggle_anim_node);
  level.current_knife_weapon = level.player getcurrentweapon();
  level.current_knife_weapon_string = level.current_knife_weapon.basename;

  if(level.current_knife_weapon_string == "iw8_knife_kid") {
    var4 = "weapon_vm_me_kitchen_knife";
  } else if(level.current_knife_weapon_string == "iw8_knife_kid_rebar") {
    var4 = "weapon_vm_me_screwdriver";
  } else if(level.current_knife_weapon_string == "iw8_knife_kid_scissors") {
    var4 = "weapon_vm_me_scissors";
  } else if(level.current_knife_weapon_string == "iw8_knife_kid_screwdriver") {
    var4 = "weapon_vm_me_screwdriver";
  } else {
    var4 = "weapon_vm_me_screwdriver";
  }

  var5 = spawn("script_model", level.boss_struggle_player_model gettagorigin("tag_accessory_right"));
  var5 setModel(var4);
  var5.angles = level.boss_struggle_player_model gettagangles("tag_accessory_right");
  var5 linkTo(level.boss_struggle_player_model, "tag_accessory_right");
  level notify("boss_struggle_vo_start");

  if(!scripts\engine\utility::flag("disable_autosaves")) {
    thread scripts\engine\sp\utility::autosave_now();
  }

  level notify("clean_up_goliath_interacts");
  level thread scripts\sp\utility::context_melee_enable(0);
  level.player lerpfovscalefactor(0, 0.3);
  level.vfx_stab_tear_screenfx_01 = spawnfx(level._effect["vfx_stab_tear_screenfx_01"], (0, 0, 0));
  triggerfx(level.vfx_stab_tear_screenfx_01);
  level.boss_struggle_anim_node scripts\common\anim::anim_single([level.boss_struggle_player_model, level.goliath_ai, level.boss_kill_sling_model], var4);
  scripts\sp\maps\hometown\hometown_util::spawn_hadir();
  thread audio_music_stab_kill_brute();
  var6 = 0;
  thread goliath_strangle_effects();
  level.goliath_ai scripts\sp\nvg\nvg_ai::flashlight_off();
  level.boss_struggle_anim_node scripts\common\anim::anim_single([level.boss_struggle_player_model, level.goliath_ai, level.boss_kill_sling_model], "boss_strangle");
  level.hadir_body_model delete();
  var7 = spawn("script_model", level.hadir_ai gettagorigin("tag_accessory_right"));
  var7 setModel("weapon_wm_me_kitchen_knife");
  var7.angles = level.hadir_ai gettagangles("tag_accessory_right");
  var7 linkTo(level.hadir_ai, "tag_accessory_right");
  level.hadir_ai attach("hat_waist_child_hadir_gas_mask", "J_Proc_SpineLower_Swivel");
  level.goliath_ai scripts\sp\nvg\nvg_ai::flashlight_off();
  level.hadir_ai setModel("body_hero_hadir_child_bloody");
  level.boss_kill_sling_model scripts\engine\utility::delaycall(3.5, &show);
  level.goliath_ai hidepart("J_Dummy_SlingCenterAim");
  level.goliath_ai hidepart("J_Dummy_Sling_Spine");
  level.goliath_ai hidepart("J_Dummy_Sling_Clavicle");
  level.goliath_ai hidepart("J_Sling_Clavicle");
  level.goliath_ai hidepart("J_Sling_Spine");
  level.goliath_ai hidepart("J_Sling_pivot");
  level.vfx_htown_hadirj_blink = spawnfx(level._effect["vfx_htown_hadirj_blink"], (0, 0, 0));
  triggerfx(level.vfx_htown_hadirj_blink);
  level.boss_struggle_anim_node scripts\common\anim::anim_single([level.boss_struggle_player_model, level.goliath_ai, level.hadir_ai, level.boss_kill_sling_model], "boss_pull_off");
  var5 delete();
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
  var7 unlink();
  var7 delete();
  goliath_struggle_use_gun_scene();
  level notify("boss_dying");

  if(!istrue(level.player.goliath_melee_allowed)) {
    level.player scripts\common\utility::allow_melee(1);
  }

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

  if(!scripts\engine\utility::flag("disable_autosaves")) {
    thread scripts\engine\sp\utility::autosave_now();
    return;
  }
}

function audio_music_stab_kill_brute() {}

function get_current_house_room() {
  var0 = getEntArray("house_room_trigger", "targetname");

  foreach(var2 in var0) {
    if(self istouching(var2)) {
      return var2.script_noteworthy;
    }
  }

  return undefined;
}

function goliath_struggle_use_gun_scene() {
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
  level.boss_shoot_player_model setModel(scripts\sp\maps\hometown\hometown_util::getfarrahbloodymodel());
  level.goliath_ai scripts\sp\nvg\nvg_ai::flashlight_off();
  level.boss_struggle_anim_node thread scripts\sp\player_rig::link_player_to_rig("kill_flip_gun_grab", "stand", 1, 0.5, 0, 0, 0, 0, 0, 1);
  level.boss_struggle_anim_node notify("stop_loop");
  level.boss_struggle_anim_node scripts\common\anim::anim_single([level.hadir_ai, level.goliath_ai, level.boss_shoot_player_model, level.boss_kill_sling_model], "kill_flip_gun_grab");
  level.goliath_ai scripts\sp\nvg\nvg_ai::flashlight_off();
  level.boss_struggle_anim_node notify("stop_loop");
  level.boss_struggle_anim_node thread scripts\common\anim::anim_loop([level.hadir_ai, level.goliath_ai, level.boss_shoot_player_model, level.boss_kill_sling_model], "kill_flip_gun_grab_idle");
  level.ak_shoot_timer = 90;
  var0 = 0;

  while(var0 == 0) {
    if(level.player attackButtonPressed() || level.player fragButtonPressed() || level.player secondaryoffhandbuttonPressed() || level.player meleeButtonPressed() || level.player useButtonPressed()) {
      var0 = 1;
    }

    waitframe();

    if(level.didnt_shoot_ak_in_time) {
      for(;;) {
        waitframe();
      }
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

function ak_shoot_timer() {
  level endon("player_shot_boss");
  level.ak_shoot_timer = 90;
  level.didnt_shoot_ak_in_time = 0;

  while(level.ak_shoot_timer > 0) {
    level.ak_shoot_timer -= 1;
    waitframe();
  }

  level.didnt_shoot_ak_in_time = 1;
  level thread scripts\sp\player_death::set_custom_death_quote(65);
  scripts\sp\utility::missionfailedwrapper();
}

function player_shoot_boss() {
  level.player enableinvulnerability();
  level notify("fade_boss_lights_off");
  level.player playRumbleOnEntity("heavy_2s");
  thread stab_blink_black_fade();
  level.vfx_htown_stab_blink_ak = spawnfx(level._effect["vfx_htown_stab_blink_3"], (0, 0, 0));
  triggerfx(level.vfx_htown_stab_blink_ak);
  level.player shellshock("hometown_boss_intro", 3, undefined, 0);
  setblur(2, 0.01);
  scripts\engine\utility::noself_delaycall(0.1, &setblur, 0, 3);
  level.vfx_stab_tear_screenfx_01 delete();
  level.boss_struggle_anim_node scripts\common\anim::anim_single([level.boss_shoot_player_model], "kill_flip_gun_shoot");
  thread scripts\sp\maps\hometown\hometown_util::boss_blocker();
  level.player enableweapons();
  level.player scripts\sp\player_rig::unlink_player_from_rig(0, "stand");
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowstand(1);
  level.player disableinvulnerability();
}

function goliath_struggle_fail() {
  level endon("kill_flip_start");
  level waittill("stab_delay_time_exceeded");
  level notify("stab_failed");

  if(isDefined(level.player.goliath_melee_allowed) && !level.player.goliath_melee_allowed) {
    level.player scripts\common\utility::allow_melee(1);
  }

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
  level.hadir_ai scripts\sp\maps\hometown\hometown_util::kill_quietly(level.goliath_ai);
  level thread scripts\sp\player_death::set_custom_death_quote(65);
  scripts\sp\utility::missionfailedwrapper();
}

function goliath_stab_time_monitor() {
  level endon("kill_flip_start");
  level.time_since_last_stab = 0;

  for(;;) {
    level.time_since_last_stab += 1;

    if(level.time_since_last_stab >= 100) {
      level notify("stab_delay_time_exceeded");
    }

    waitframe();
  }
}

function goliath_stab_model_swap_monitor() {
  level waittill("dad_stabbed_chest");
  level.goliath_ai setModel("body_russian_soldier_boss_stab_1_chest_dad");
  level waittill("player_stabbed_boss");
  level.goliath_ai setModel("body_russian_soldier_boss_stab_2_leg_l_back");
  level waittill("player_stabbed_boss");
  level.goliath_ai setModel("body_russian_soldier_boss_stab_3_leg_r_back");
  level waittill("hadir_stabbed_neck");
  level.goliath_ai scripts\engine\utility::delaycall(1.6, &setmodel, "body_russian_soldier_boss_stab_4_neck");
  level.goliath_ai scripts\engine\utility::delaycall(1.6, &detach, "head_russian_soldier_boss");
  level.goliath_ai scripts\engine\utility::delaycall(1.6, &attach, "head_russian_soldier_boss_stab_4_neck");
  level waittill("player_stabbed_boss");
  level.goliath_ai setModel("body_russian_soldier_boss_stab_5_chest_a");
  level waittill("player_stabbed_boss");
  level.goliath_ai setModel("body_russian_soldier_boss_stab_7_chest_c");
  level waittill("player_stabbed_boss");
  level.goliath_ai setModel("body_russian_soldier_boss_stab_8_chest_d");
  level waittill("player_shot_boss");
  level.goliath_ai setModel("body_russian_soldier_boss_stab_9_gunshots");
}

function goliath_struggle_stab_monitor() {
  level endon("boss_dying");
  level endon("stab_failed");
  level.player.goliath_melee_allowed = 1;

  for(;;) {
    var0 = goliath_struggle_stab_check_for_close_victim();

    if(var0 == "true") {
      if(istrue(level.player.goliath_melee_allowed)) {
        level.player scripts\common\utility::allow_melee(0);
        level.player.goliath_melee_allowed = 0;
      }

      if(level.player attackButtonPressed() || level.player meleeButtonPressed()) {
        var1 = goliath_struggle_stab_direction();

        if(var1 != "back") {
          level notify("player_stabbed_struggling_goliath");
        }
      }
    } else if(!istrue(level.player.goliath_melee_allowed)) {
      level.player scripts\common\utility::allow_melee(1);
      level.player.goliath_melee_allowed = 1;
    }

    waitframe();
  }
}

function goliath_struggle_stab() {
  level endon("player_unlinked_from_kill_flip");
  level endon("stab_failed");
  var0 = ["boss_stab_context02", "boss_stab_context05", "boss_stab_context07"];
  level.boss_stabbed_amount = 0;

  foreach(var2 in var0) {
    level waittill("player_stabbed_struggling_goliath");
    level notify("start_stab");
    level.boss_struggle_anim_node notify("stop_loop");

    if(var2 == "boss_stab_context01") {
      level.stab_tag = "TAG_blood_1";
    } else if(var2 == "boss_stab_context02") {
      level.stab_tag = "TAG_blood_7";
    } else if(var2 == "boss_stab_context04") {
      level.stab_tag = "TAG_blood_4";
    } else if(var2 == "boss_stab_context05") {
      level.stab_tag = "TAG_blood_3";
    } else if(var2 == "boss_stab_context07") {
      level.stab_tag = "TAG_blood_6";
    } else {
      level.stab_tag = "TAG_blood_1";
    }

    level.time_since_last_stab = 0;
    var3 = level.player.origin;
    level.boss_stab_player_model = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig", level.boss_struggle_anim_node.origin, level.boss_struggle_anim_node.angles);
    level.player_rig = level.boss_stab_player_model;
    level.boss_stab_player_model setModel(scripts\sp\maps\hometown\hometown_util::getfarrahbloodymodel());
    level.boss_struggle_anim_node thread scripts\sp\player_rig::link_player_to_rig(var2, "stand", 1, 0.2, 0, 0, 0, 0, 0, 1);
    level.player hideviewmodel();

    if(level.current_knife_weapon_string == "iw8_knife_kid") {
      var4 = "weapon_vm_me_kitchen_knife";
      level.player takeallweapons();
      level.player giveweapon("iw8_knife_kid_bloody");
      level.player switchtoweaponimmediate("iw8_knife_kid_bloody");

      if(!level.boss_stabbed_amount == 0) {
        var4 = "weapon_vm_me_kitchen_knife_bloody";
      }
    } else if(level.current_knife_weapon_string == "iw8_knife_kid_rebar") {
      var4 = "weapon_vm_me_screwdriver";
      level.player takeallweapons();
      level.player giveweapon("iw8_knife_kid_screwdriver_bloody");
      level.player switchtoweaponimmediate("iw8_knife_kid_screwdriver_bloody");

      if(!level.boss_stabbed_amount == 0) {
        var4 = "weapon_vm_me_screwdriver_bloody";
      }
    } else if(level.current_knife_weapon_string == "iw8_knife_kid_scissors") {
      var4 = "weapon_vm_me_scissors";
      level.player takeallweapons();
      level.player giveweapon("iw8_knife_kid_scissors_bloody");
      level.player switchtoweaponimmediate("iw8_knife_kid_scissors_bloody");

      if(!level.boss_stabbed_amount == 0) {
        var4 = "weapon_vm_me_scissors_bloody";
      }
    } else if(level.current_knife_weapon_string == "iw8_knife_kid_screwdriver") {
      var4 = "weapon_vm_me_screwdriver";
      level.player takeallweapons();
      level.player giveweapon("iw8_knife_kid_screwdriver_bloody");
      level.player switchtoweaponimmediate("iw8_knife_kid_screwdriver_bloody");

      if(!level.boss_stabbed_amount == 0) {
        var4 = "weapon_vm_me_screwdriver_bloody";
      }
    } else {
      var4 = "weapon_vm_me_screwdriver";
      level.player takeallweapons();
      level.player giveweapon("iw8_knife_kid_screwdriver_bloody");
      level.player switchtoweaponimmediate("iw8_knife_kid_screwdriver_bloody");

      if(!level.boss_stabbed_amount == 0) {
        var4 = "weapon_vm_me_screwdriver_bloody";
      }
    }

    var5 = spawn("script_model", level.boss_stab_player_model gettagorigin("tag_accessory_right"));
    var5.angles = level.boss_stab_player_model gettagangles("tag_accessory_right");
    var5 setModel(var4);
    var5 linkTo(level.boss_stab_player_model, "tag_accessory_right");
    level.boss_struggle_anim_node scripts\common\anim::anim_single([level.boss_stab_player_model, level.goliath_ai, level.hadir_ai, level.boss_kill_sling_model], var2);

    if(var2 == "boss_stab_context07") {
      level.boss_struggle_anim_node notify("stop_loop");
      level.time_since_last_stab = 0;
      level notify("kill_flip_start");
      level notify("start_kill_flip_vo");
      thread boss_turn_on_hadir_hit();
      thread boss_turns_on_hadir_anim();

      if(!scripts\engine\utility::flag("disable_autosaves")) {
        thread scripts\engine\sp\utility::autosave_now();
      }

      level.boss_struggle_anim_node scripts\common\anim::anim_single([level.boss_stab_player_model], "kill_flip");
      level.time_since_last_stab = 0;
    }

    var5 delete();
    level.player scripts\sp\player_rig::unlink_player_from_rig(0, "stand");
    level.player disableweapons();
    level.player showviewmodel();
    level.time_since_last_stab = 0;
    level.boss_stabbed_amount += 1;

    if(var2 == "boss_stab_context07") {
      level notify("player_unlinked_from_kill_flip");
      continue;
    }

    level.boss_struggle_anim_node thread scripts\common\anim::anim_loop([level.hadir_ai, level.goliath_ai, level.boss_kill_sling_model], "boss_struggle_a");
  }
}

function boss_turns_on_hadir_anim() {
  level.boss_struggle_anim_node scripts\common\anim::anim_single([level.hadir_ai, level.goliath_ai, level.boss_kill_sling_model], "kill_flip");
  level notify("boss_turns_on_hadir");
}

function boss_turn_on_hadir_hit() {
  self endon("pain_fx_done");
  wait 0.9;
  earthquake(1, 0.3, level.player.origin, 75);
  level.player playRumbleOnEntity("heavy_1s");
  thread painvision_replacement();
  level.player thread scripts\sp\player::radial_distortion(0.05, 0.2, 0.25);
  thread painvision_replacement();
  wait 1;
  self notify("pain_fx_done");
}

function painvision_replacement() {
  visionsetpain("damage_severe");
  setsaveddvar("MLLRKTPNRR", 0);
  setsaveddvar("OONLORSMO", 1.9);
  level.player shellshock("hometown_boss_intro", 3, undefined, 0);
  setblur(2, 0.01);
  scripts\engine\utility::noself_delaycall(0.1, &setblur, 0, 3);
  level.player painvisionon();
  wait 0.1;
  level.player painvisionoff();
}

function audio_music_stab() {
  var0 = level.goliath_boss_round;

  if(getdvarint("greenlight")) {
    var0 = 1;
  }

  switch (var0) {
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

function stab_blink_black_fade() {
  level.blinkblackoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  waitframe();
  level.blinkblackoverlay fadeovertime(0.1);
  level.blinkblackoverlay.alpha = 0.9;
  wait 0.2;
  level.blinkblackoverlay fadeovertime(0.5);
  level.blinkblackoverlay.alpha = 0;
  wait 0.5;
  level.blinkblackoverlay destroy();
}

function goliath_blood_stab_vfx() {
  level endon("boss_dying");
  thread goliath_blood_stab_hands();
  var0 = 0;

  for(;;) {
    level waittill("player_stabbed_boss");

    if(var0 == 2) {
      thread stab_blink_black_fade();
      level.vfx_htown_stab_blink_1 = spawnfx(level._effect["vfx_htown_stab_blink_1"], (0, 0, 0));
      triggerfx(level.vfx_htown_stab_blink_1);
      level.player shellshock("hometown_boss_intro", 3, undefined, 0);
      setblur(2, 0.01);
      scripts\engine\utility::noself_delaycall(0.1, &setblur, 0, 3);
    } else if(var0 == 3) {
      thread stab_blink_black_fade();
      level.vfx_htown_stab_blink_2 = spawnfx(level._effect["vfx_htown_stab_blink_2"], (0, 0, 0));
      triggerfx(level.vfx_htown_stab_blink_2);
      level.player shellshock("hometown_boss_intro", 3, undefined, 0);
      setblur(2, 0.01);
      scripts\engine\utility::noself_delaycall(0.1, &setblur, 0, 3);
    } else if(var0 == 4) {
      thread stab_blink_black_fade();
      level.vfx_htown_stab_blink_3 = spawnfx(level._effect["vfx_htown_stab_blink_3"], (0, 0, 0));
      triggerfx(level.vfx_htown_stab_blink_3);
      level.player shellshock("hometown_boss_intro", 3, undefined, 0);
      setblur(2, 0.01);
      scripts\engine\utility::noself_delaycall(0.1, &setblur, 0, 3);
    }

    playFXOnTag(level._effect["vfx_htown_blood_stab"], level.goliath_ai, level.stab_tag);
    level.player playRumbleOnEntity("light_1s");
    var0 += 1;
  }
}

function goliath_blood_stab_hands() {
  level endon("boss_dying");
  level waittill("player_stabbed_boss");
  scripts\sp\player\youngfarrah::setplayerviewmodel(scripts\sp\maps\hometown\hometown_util::getfarrahbloodymodel(), undefined, "viewmodel_farah_child_shadowcaster");
}

function goliath_struggle_player_check_final_pos(var0) {
  wait 0.05;
  var1 = self.origin + (0, 0, 1);
  var2 = scripts\engine\trace::player_trace(var0 + (0, 0, 1), var1, self.angles, [self]);
  var3 = var2["position"];

  if(distancesquared(var1, var3) > 0.0001) {
    var4 = vectorNormalize(var0 - var1);
    self setOrigin(var3 + var4);
    return;
  }
}

function goliath_struggle_stab_direction() {
  var0 = level.goliath_ai gettagangles("j_spinelower");
  var1 = level.goliath_ai gettagorigin("j_spinelower");
  var2 = anglestoright(var0);
  var3 = anglesToForward(var0);
  var4 = level.player.origin - var1;
  var4 = (var4[0], var4[1], 0);
  var4 = vectorNormalize(var4);
  var5 = abs(vectordot(var3, (0, 0, 1)));

  if(var5 > 0.7) {
    var3 = vectorNormalize((var2[0], var2[1], 0));
  } else {
    var3 = vectorNormalize((var3[0], var3[1], 0));
  }

  var6 = anglesToForward(level.goliath_ai.angles);

  if(vectordot(var4, var6) > vectordot(var3, var6)) {
    var3 = var6;
  }

  var2 = vectorcross(var3, (0, 0, 1));
  var7 = vectordot(var3, var4);
  var8 = vectordot(var2, var4);
  var9 = -0.6;

  if(var7 < var9) {
    return "back";
  } else if(var7 > 0.6) {
    return "front";
  } else if(var8 > 0) {
    return "right";
  } else {
    return "left";
  }

  return undefined;
}

function goliath_struggle_stab_check_for_close_victim() {
  var0 = 100;
  var1 = var0 * var0;
  var2 = anglesToForward((0, level.player getplayerangles()[1], 0));
  var3 = level.player getEye();
  var4 = level.goliath_ai gettagorigin("j_spinelower");
  var5 = distancesquared(var4, var3);

  if(var5 < var1) {
    var6 = vectorNormalize(var4 - var3);

    if(vectordot(var6, var2) > 0.5) {
      if(scripts\engine\trace::_bullet_trace_passed(level.player.origin + (0, 0, 48), var4, 0, undefined)) {
        return "true";
      }
    }
  }

  return "false";
}

function melee_weapon_safe_gesture() {
  level.player giveweapon("iw8_gunless_farrah");
  level.player switchtoweapon("iw8_gunless_farrah");
  wait 1;
}

function house_exit_main() {
  setsaveddvar("OMNONNMOTP", "0.1 400 2.25 1000");
  level.player allowsprint(1);
  level.player allowjump(1);
  level.door_clip_boss_enter notsolid();
  level.father_body_model detach("head_hero_farahs_father");
  level.father_body_model attach("head_sc_m_ward_blendshape");
  var0 = scripts\engine\utility::getStruct("boost_anim_node", "script_noteworthy");
  var0 thread scripts\common\anim::anim_loop_solo(level.father_body_model, "boost_father_enter_idle");
  level.player_view_blur = 0;
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

  if(isDefined(level.boss_kill_sling_model)) {
    level.boss_kill_sling_model hide();
  }

  level.goliath_body_model.gas_mask = spawn("script_model", level.goliath_body_model.origin);
  level.goliath_body_model.gas_mask setModel("tag_origin");
  level.goliath_body_model.gas_mask notsolid();
  level.goliath_body_model.gas_mask linkTo(level.goliath_body_model, "j_helmet", (-6, -2.5, -0.25), (180, -270, 90));
  level.goliath_body_model.gas_mask hide();
  level.boss_struggle_anim_node thread scripts\common\anim::anim_first_frame_solo(level.goliath_body_model, "try_get_gun_scene");
  waitframe();
  scripts\common\anim::anim_set_time([level.father_body_model], "house_dad_dead_frame", 1);
  scripts\sp\player\youngfarrah::setplayerviewmodel(scripts\sp\maps\hometown\hometown_util::getfarrahbloodymodel(), undefined, "viewmodel_farah_child_shadowcaster");
  thread scripts\sp\maps\hometown\hometown_vo::house_exit_start_vo();
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
    if(level.boss_struggle_anim_node_safe.script_index == 1) {
      level.boss_struggle_anim_node thread scripts\common\anim::anim_single_solo(level.hadir_ai, "step_over_boss");
    }

    if(level.boss_struggle_anim_node_safe.targetname == "anim_preview_loc_26") {
      level.boss_struggle_anim_node scripts\common\anim::anim_single_solo(level.hadir_ai, "turnaround_at_boss");
    }
  }

  thread front_door_boost_open_anim();
  level waittill("house_exit_complete");
  level.father_body_model delete();
  level.goliath_body_model delete();
  thread nod_gesture();
  level.hadir_ai scripts\asm\asm_bb::bb_setcivilianstate("stealth");

  if(!scripts\engine\utility::flag("disable_autosaves")) {
    thread scripts\engine\sp\utility::autosave_now();
    return;
  }
}

function audio_music_stop_music_delay(var0) {
  if(isDefined(var0)) {
    wait var0;
    return;
  }
}

function audio_music_house_post_stab() {
  level endon("hadir_mourn_father");

  for(;;) {
    var0 = distance(level.hadir_ai.origin, (-1494, -2485, 58));

    if(var0 < 150) {
      break;
    }

    wait 0.1;
  }

  wait 1;
  setmusicstate("mx_hometown_13_house_post_stab");
}

function nod_gesture() {
  level.player giveweapon("iw8_gunless_farrah");
  level.player switchtoweapon("iw8_gunless_farrah");
  level.player enableweapons();
  wait 1;
  level.player stopgestureviewmodel("ges_kitchen_knife_safe", 1);
}

function talk_to_hadir() {
  if(isDefined(level.boss_struggle_anim_node)) {
    level.try_get_gun_anim_node = level.boss_struggle_anim_node;
  } else {
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

  if(!isDefined(level.player_interacted_on_body)) {
    level.try_get_gun_anim_node thread scripts\common\anim::anim_loop_solo(level.hadir_ai, "hadir_ready_idle", "hadir_loop_stop");
    return;
  }
}

function interact_on_boss_body_timer() {
  wait 3.33;
  level notify("loot_interacts_active");
  level.got_gas_mask = 0;
  level.tried_to_get_gun = 0;
  thread gas_mask_pickup_playerlogic();
  thread gun_try_pickup();
}

function hadir_talk_monitor() {
  level endon("house_exit_complete");
  var0 = 0;
  var1 = 0;

  while(var0 <= 20 && var1 <= 100) {
    var2 = level.hadir_ai gettagorigin("tag_eye");
    var3 = level.hadir_ai gettagorigin("J_SpineUpper");
    var4 = level.hadir_ai gettagorigin("J_SpineLower");

    if(scripts\engine\utility::distance_2d_squared(level.player.origin, var2) <= 2500 || scripts\engine\utility::distance_2d_squared(level.player.origin, var3) <= 2500) {
      if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var2, cos(15)) || scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var4, cos(15)) || scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var3, cos(15))) {
        var0 += 1;
      }
    }

    var1 += 1;
    waitframe();
  }

  level.hadir_ai notify("trigger");
  level waittill("farah_reassure_vo_finish");
}

function mourn_dad_monitor() {
  level endon("house_exit_complete");
  scripts\engine\utility::flag_wait("player_can_mourn");
  GscBinSkip4(0x6e, level, 50, "tag_eye");
}

function notify_on_lookat_dad(var0, var1) {
  self endon("player_mourn_father");
  level.player scripts\sp\maps\hometown\hometown_util::wait_lookat(level.father_body_model, var0, var1, 0.25, 100);
  self notify("player_mourn_father");
}

function gun_try_pickup() {
  level.try_get_gun_interact = scripts\engine\utility::spawn_tag_origin(level.goliath_body_model.origin);
  level.try_get_gun_interact linkTo(level.goliath_body_model);
  level.try_get_gun_interact scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, -3, 2), &"HOMETOWN/AK47", undefined, undefined, 50, 0);
  level.try_get_gun_interact waittill("trigger");
  level.player_interacted_on_body = 1;

  if(!level.got_gas_mask) {
    level.goliath_body_model scripts\sp\player\cursor_hint::remove_cursor_hint();
  }

  level.player notify("boss_stuff_pickup", "gun");
  level.player stopgestureviewmodel("ges_kitchen_knife_safe", 1);
  level.try_get_gun_anim_node notify("hadir_loop_stop");
  level.try_get_gun_interact delete();
  var0 = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig", level.try_get_gun_anim_node.origin, level.try_get_gun_anim_node.angles);
  level.player_rig = var0;
  var0 setModel(scripts\sp\maps\hometown\hometown_util::getfarrahbloodymodel());
  level.player setstance("stand");
  level.try_get_gun_anim_node thread scripts\sp\player_rig::link_player_to_rig("try_get_gun_scene", "stand", 1, 1, 0, 0, 0, 0, 0, 1);
  level.player disableweapons();
  thread gun_try_pickup_hadir();
  level.player lerpfovscalefactor(0, 0.6);
  level.try_get_gun_anim_node thread scripts\common\anim::anim_single_solo(level.boss_kill_sling_model, "try_get_gun_scene");
  level.try_get_gun_anim_node thread scripts\common\anim::anim_single_solo(level.goliath_body_model, "try_get_gun_scene");
  level.try_get_gun_anim_node thread scripts\common\anim::anim_single_solo(level.gas_mask_from_boss_model_pre, "try_get_gun_scene");
  level.try_get_gun_anim_node scripts\common\anim::anim_single_solo(var0, "try_get_gun_scene");
  level.player enableweapons();
  level.player scripts\sp\player_rig::unlink_player_from_rig(0, "stand");
  thread melee_weapon_safe_gesture();
  scripts\engine\utility::flag_set("tried_to_get_gun");
  wait 1;
  level.tried_to_get_gun = 1;

  if(!level.got_gas_mask) {
    level.goliath_body_model scripts\sp\player\cursor_hint::create_cursor_hint("j_head", (0, 0, 0), &"HOMETOWN/GASMASK", undefined, undefined, undefined, 1);
    return;
  }
}

function gun_try_pickup_hadir() {
  level.try_get_gun_anim_node scripts\common\anim::anim_single_solo(level.hadir_ai, "try_get_gun_scene");
  scripts\engine\utility::flag_set("tried_to_get_gun_hadir_anim_done");

  if(!scripts\engine\utility::flag("got_gas_mask_from_boss")) {
    level.try_get_gun_anim_node notify("hadir_loop_stop");
    level.try_get_gun_anim_node thread scripts\common\anim::anim_loop_solo(level.hadir_ai, "hadir_ready_idle", "hadir_loop_stop");
    return;
  }
}

function front_door_boost_open_mask_spawn(var0) {
  wait 35.5;
  level.hadir_ai detach("hat_waist_child_hadir_gas_mask", "J_Proc_SpineLower_Swivel");
  var0 show();
  wait 4;
  var0 delete();
  level.hadir_ai attach("hat_child_hadir_gas_mask");
}

function goodbye_father_vo_captions() {
  iprintlnbold("HADIR: Baba...?");
  wait 2;
  iprintlnbold("FATHER: My loves.");
  wait 2;
  iprintlnbold("HADIR: You have to get up...");
  wait 2;
  iprintlnbold("FATHER: I can't... go with you.");
  wait 2;
  iprintlnbold("FARAH: They're coming...");
  wait 2;
  iprintlnbold("HADIR: What do we do?");
  wait 2;
  iprintlnbold("FATHER: Survive. Whatever it takes.");
  wait 2;
  iprintlnbold("FATHER: Never back down.");
  wait 2;
  iprintlnbold("FATHER: Fight. Protect each other.");
  wait 2;
  iprintlnbold("FATHER: Whatever...it takes...");
  wait 2;
  iprintlnbold("FATHER: Fight. Never back down.");
}

function remove_hadir_blocker_house() {
  scripts\engine\utility::flag_wait("player_can_mourn");
  level.dead_dad_blocker_hadir scripts\engine\sp\utility::hide_entity();
}

function front_door_boost_open_anim() {
  var0 = scripts\engine\utility::getStruct("boost_anim_node", "script_noteworthy");
  var0 thread scripts\common\anim::anim_first_frame_solo(level.house_intro_deadbolt_model, "boost_exitA_unlock");
  level.hadir_ai scripts\asm\asm_bb::bb_setcivilianstate("panic");
  level.hadir_ai scripts\engine\utility::set_movement_speed(45);
  level.hadir_ai.arrivalspeed = 0.82;
  thread audio_music_house_post_stab();
  var0 scripts\sp\anim::anim_reach_and_approach_solo(level.hadir_ai, "boost_hadir_enter");
  level.hadir_ai.arrivalspeed = undefined;
  var1 = scripts\engine\sp\utility::spawn_anim_model("gas_mask_from_dad", var0.origin, var0.angles);
  var1 hide();
  thread front_door_boost_open_mask_spawn(var1);
  level notify("hadir_mourn_father");
  var0 thread scripts\common\anim::anim_first_frame_solo(level.gas_attack_house_door_model, "boost_exitB");
  level.hadir_ai detach("head_sc_m_coto");
  level.hadir_ai attach("head_sc_m_coto_blendshape");
  thread remove_hadir_blocker_house();
  var0 thread scripts\common\anim::anim_single_solo(var1, "boost_hadir_enter");
  var0 thread scripts\common\anim::anim_single_solo(level.father_body_model, "boost_hadir_enter");
  var0 scripts\common\anim::anim_single_solo(level.hadir_ai, "boost_hadir_enter");
  level.hadir_ai detach("head_sc_m_coto_blendshape");
  level.father_body_model detach("head_sc_m_ward_blendshape");
  level.hadir_ai attach("head_sc_m_coto");
  level.father_body_model attach("head_hero_farahs_father");
  level notify("hadir_reached_door");
  var0 thread scripts\common\anim::anim_loop_solo(level.hadir_ai, "boost_hadir_idle", "hadir_loop_stop");
  level.hadir_ai scripts\sp\player\cursor_hint::create_cursor_hint("j_wrist_le", (3, 0, 0), &"HOMETOWN/CLIMB");
  level.hadir_ai waittill("trigger");
  thread player_putgasmaskon();
  scripts\engine\utility::flag_set("lighting_make_on");
  setaudiotriggerstate("gas_outsidehouse", "gasthrown", 1);

  if(level.current_knife_weapon_string == "iw8_knife_kid_bloody" || level.current_knife_weapon_string == "iw8_knife_kid") {
    var2 = "weapon_vm_me_kitchen_knife_bloody";
    var3 = "_knife";
  } else if(level.current_knife_weapon_string == "iw8_knife_kid_rebar_bloody" || level.current_knife_weapon_string == "iw8_knife_kid_rebar") {
    var2 = "weapon_vm_me_screwdriver_bloody";
    var3 = "";
  } else if(level.current_knife_weapon_string == "iw8_knife_kid_scissors_bloody" || level.current_knife_weapon_string == "iw8_knife_kid_scissors") {
    var2 = "weapon_vm_me_scissors_bloody";
    var3 = "_scissors";
  } else if(level.current_knife_weapon_string == "iw8_knife_kid_screwdriver_bloody" || level.current_knife_weapon_string == "iw8_knife_kid_screwdriver") {
    var2 = "weapon_vm_me_screwdriver_bloody";
    var3 = "";
  } else {
    var2 = "weapon_vm_me_screwdriver";
    var3 = "";
  }

  var4 = scripts\engine\sp\utility::spawn_anim_model("boost_screwdriver", level.player.origin, level.player.angles);
  var4 setModel(var2);
  var2 notify("hadir_loop_stop");
  level.player lerpfovscalefactor(0, 0.3);
  level.player disableweapons();
  level.player takeallweapons();
  var5 = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig", var2.origin, var2.angles);
  level.player_rig = var5;
  var5 setModel(scripts\sp\maps\hometown\hometown_util::getfarrahbloodymodel());
  var2 thread scripts\sp\player_rig::link_player_to_rig("boost_exitA" + var3, "stand", 1, 0.75, 0, 0, 0, 0, 0, 1);
  var4.origin = var5 gettagorigin("tag_accessory_right");
  var4.angles = var5 gettagangles("tag_accessory_right");
  var4 linkTo(var5, "tag_accessory_right");
  var6 = spawn("script_origin", level.player.origin);
  var6 scalevolume(0, 0);
  var7 = spawn("script_origin", level.player.origin);
  var7 scalevolume(0, 0);
  var8 = "scn_hometown_lock_loop" + var3;
  var9 = "scn_hometown_unlock_loop" + var3;
  level.gas_mask_from_boss_model scripts\engine\utility::delaycall(0.75, &show);
  var2 thread scripts\common\anim::anim_single_solo(level.hadir_ai, "boost_exitA");
  var2 thread scripts\common\anim::anim_single_solo(level.gas_mask_from_boss_model, "boost_exitA");
  var2 scripts\common\anim::anim_single_solo(var5, "boost_exitA" + var3);
  level.gas_mask_from_boss_model delete();
  level.player lerpviewangleclamp(0.5, 0.5, 0.5, 40, 40, 40, 40);

  if(!getdvarint("scr_no_springcam")) {
    level.player springcamdisabled(0.5);
  }

  var2 thread scripts\common\anim::anim_loop_solo(level.hadir_ai, "boost_exitA_idle", "stop_exitA_idle");
  var2 thread scripts\common\anim::anim_loop_solo(var5, "boost_exitA_idle" + var3, "stop_exitA_idle");
  level notify("start_lock_pry");
  var10 = scripts\engine\utility::spawn_tag_origin(var4.origin);
  var10 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"HOMETOWN/PRY", undefined, undefined, undefined, 1, undefined, undefined, undefined, "duration_none");
  setsaveddvar("OMNONNMOTP", "0.1 400 0.75 1000");
  var10 waittill("trigger");
  var10 delete();
  var2 notify("stop_exitA_idle");
  var6 playLoopSound(var9);
  var7 playLoopSound(var8);
  var11 = var5 scripts\engine\utility::getanim("boost_exitA_unlock" + var3);
  var12 = level.hadir_ai scripts\engine\utility::getanim("boost_exitA_unlock");
  var13 = level.house_intro_deadbolt_model scripts\engine\utility::getanim("boost_exitA_unlock");
  var5 setanim(var11);
  level.hadir_ai setanim(var12);
  level.house_intro_deadbolt_model setanim(var13);
  wait 0.3;
  var5 setanimrate(var11, 0);
  level.hadir_ai setanimrate(var12, 0);
  level.house_intro_deadbolt_model setanimrate(var13, 0);
  var14 = 1;
  var15 = var5 getanimtime(var11);
  var16 = 1;
  var17 = var16 * -1;
  var18 = 0;

  while(var15 < var14) {
    if(level.player useButtonPressed()) {
      var19 = 1;
      level.player playrumblelooponentity("tank_rumble");

      if(var18 != 1) {
        level.player playSound("scn_hometown_unlock_loop_start");
        var6 scalevolume(1, 0.2);
        var7 scalevolume(0, 0.2);
        var18 = 1;
      }
    } else {
      var19 = -2;
      level.player stoprumble("tank_rumble");

      if(var18 == 1) {
        level.player playSound("scn_hometown_lock_loop_start");
        var7 scalevolume(1, 0.2);
        var6 scalevolume(0, 0.2);
        var18 = 2;
      }
    }

    var5 setanimrate(var11, var19);
    level.hadir_ai setanimrate(var12, var19);
    level.house_intro_deadbolt_model setanimrate(var13, var19);
    var15 = var5 getanimtime(var11);

    if(var15 == 0 && var18 == 2) {
      var7 scalevolume(0, 0.2);
      var18 = 0;
    }

    waitframe();
  }

  level.player stoprumble("tank_rumble");
  level.player playRumbleOnEntity("heavy_1s");
  level notify("lock_broken");
  level.player playSound("scn_hometown_lock_door_open");
  var7 scalevolume(0, 0.5);
  var6 scalevolume(0, 0.5);
  var7 scripts\engine\utility::delaycall(0.5, &delete);
  var6 scripts\engine\utility::delaycall(0.5, &delete);
  level.player scripts\engine\utility::delaycall(0.5, &lerpfovscalefactor, 1, 0.3);

  if(!getdvarint("scr_no_springcam")) {
    level.player springcamenabled(0, 5, 5);
  }

  scripts\engine\utility::stop_exploder("window_gas");
  scripts\engine\utility::exploder("gasgrenadeplayground");
  scripts\engine\utility::flag_set("lighting_gas_progression");

  if(level.player ispcplayer()) {
    setsaveddvar("OMNONNMOTP", "0.1 400 0.75 1000");
  } else {
    setsaveddvar("OMNONNMOTP", "0.1 400 3.25 1000");
  }

  var2 thread scripts\common\anim::anim_single_solo(level.hadir_ai, "boost_exitB");
  var2 thread scripts\common\anim::anim_single_solo(level.gas_attack_house_door_model, "boost_exitB");
  var2 thread scripts\common\anim::anim_single_solo(level.house_intro_deadbolt_model, "boost_exitB");
  var2 scripts\common\anim::anim_single_solo(var5, "boost_exitB" + var3);
  level.player scripts\sp\player_rig::unlink_player_from_rig(0, "stand");
  level.player enableweapons();
  level.player giveweapon("iw8_gunless_farrah");
  level.player switchtoweapon("iw8_gunless_farrah");
  var4 delete();
  level.house_intro_deadbolt_model delete();
  level notify("house_exit_complete");
}

function break_lock(var0) {
  var1 = scripts\engine\utility::spawn_tag_origin(var0.origin);
  var1 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"HOMETOWN/PRY", undefined, undefined, undefined, 1, undefined, undefined, undefined, "duration_medium");
  var1 waittill("trigger");
  level notify("lock_broken");
  var1 delete();
}

function gas_mask_pickup_playerlogic() {
  level.goliath_body_model scripts\sp\player\cursor_hint::create_cursor_hint("j_head", (0, 0, 0), &"HOMETOWN/GASMASK", undefined, undefined, 50, 0);
  level.goliath_body_model waittill("trigger");

  if(!level.tried_to_get_gun) {
    level.try_get_gun_interact scripts\sp\player\cursor_hint::remove_cursor_hint();
  }

  level.player notify("boss_stuff_pickup", "gas_mask");
  level.player stopgestureviewmodel("ges_kitchen_knife_safe", 1);
  level.get_mask_anim_node = level.boss_struggle_anim_node;
  var0 = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig", level.get_mask_anim_node.origin, level.get_mask_anim_node.angles);
  level.player_rig = var0;
  var0 setModel(scripts\sp\maps\hometown\hometown_util::getfarrahbloodymodel());
  level.player setstance("stand");
  level.try_get_gun_anim_node thread scripts\sp\player_rig::link_player_to_rig("get_gas_mask", "stand", 1, 1, 0, 0, 0, 0, 0, 1);
  level.gas_mask_from_boss_model = scripts\engine\sp\utility::spawn_anim_model("gas_mask_from_boss", level.get_mask_anim_node.origin, level.get_mask_anim_node.angles);
  level.gas_mask_from_boss_model hide();
  level.player lerpfovscalefactor(0, 0.9);
  level.player disableweapons();
  level.get_mask_anim_node thread scripts\common\anim::anim_single_solo(level.boss_kill_sling_model, "get_gas_mask");
  level.get_mask_anim_node thread scripts\common\anim::anim_single_solo(level.gas_mask_from_boss_model_pre, "get_gas_mask");
  level.get_mask_anim_node thread scripts\common\anim::anim_single_solo(level.goliath_body_model, "get_gas_mask");
  level.get_mask_anim_node scripts\common\anim::anim_single_solo(var0, "get_gas_mask");
  level.player enableweapons();
  level.player scripts\sp\player_rig::unlink_player_from_rig(0, "stand");
  level.gas_mask_from_boss_model_pre hide();
  level notify("gas_mask_acquired");
  thread melee_weapon_safe_gesture();
  scripts\engine\utility::flag_set("got_gas_mask_from_boss");
  wait 1;
  level.got_gas_mask = 1;

  if(!level.tried_to_get_gun) {
    level.try_get_gun_interact scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, -3, 2), &"HOMETOWN/AK47");
    return;
  }
}

function player_putgasmaskon() {
  setsaveddvar("OMNONNMOTP", "0.1 400 0.1 1000");
  wait 2;
  level.gas_mask_overlay = scripts\sp\hud_util::create_client_overlay("gasmask_overlay_russian", 0);
  level.gas_mask_overlay.lowresbackground = 1;
  level.gas_mask_overlay fadeovertime(0.5);
  level.gas_mask_overlay.alpha = 1;
  thread scripts\sp\art::dof_enable_script(0, 0, 0, 2, 100, 3, 0);
  level.player setentitysoundcontext("gender", "gasmask_child_female");
  wait 2;

  if(level.player ispcplayer()) {
    setsaveddvar("OMNONNMOTP", "0.1 400 0.75 1000");
    return;
  }

  setsaveddvar("OMNONNMOTP", "0.1 400 3.25 1000");
}

function goliath_investigate() {
  level.goliath_ai endon("death");

  for(;;) {
    if(level.goliath_ai scripts\aitypes\stealth::ishunting()) {
      level.goliath_ai scripts\engine\utility::set_movement_speed(20);
    } else {
      level.goliath_ai scripts\engine\utility::set_movement_speed(60);
    }

    waitframe();
  }
}

function goliath_struggle_stab_slow() {
  level endon("boss_dying");
  level endon("stab_failed");
}

function goliath_struggle_stab_slow_player() {
  level endon("boss_dying");
  level endon("stab_failed");
}

function goliath_round_monitor() {
  level endon("boss_dying");
  thread goliath_counter_monitor();
  level.goliath_boss_round = 0;
  var0 = [];

  foreach(var2 in anim.smartobjectpoints) {
    if(!issubstr(var2.script_smartobject, "_rage_") && var2.script_smartobject != "stealth_exposed_fire_up") {
      continue;
    }

    var2.donotuse = 1;
    var0 = var2;
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

    thread boss_round_updates(var0);
    level.goliath_ai waittill("context_melee_anim_ended");
    level.goliath_ai scripts\engine\sp\utility::set_battlechatter(0);
    level.goliath_ai scripts\stealth\enemy::bt_event_combat();
    level.goliath_ai getenemyinfo(level.player);
  }
}

function boss_round_updates(var0) {
  switch (level.goliath_boss_round) {
    case 1:
      stop_goliath_grab();
      break;
    case 2:
      foreach(var2 in var0) {
        var2.donotuse = undefined;

        if(scripts\engine\utility::is_equal(var2.script_noteworthy, "chair")) {
          var2.prioritymultiplier = 10;
          continue;
        }

        var2.prioritymultiplier = 5;
      }

      level.player waittill("knife_change");
      break;
  }
}

function goliath_grab_init() {
  level.goliath_ai scripts\engine\sp\utility::enable_dontevershoot();
  level.goliath_ai.meleechargedistvsplayer = 2000;
  level.goliath_ai.meleerangesq = 1024;
  level.goliath_ai.meleetryhard = 1;
  thread goliath_grab_monitor();
  thread goliath_grab_give_up_and_shoot();
}

function stop_goliath_grab() {
  level.goliath_ai scripts\engine\sp\utility::disable_dontevershoot();
  level.goliath_ai.meleechargedistvsplayer = 200;
  level.goliath_ai.meleerangesq = 4096;
  level.goliath_ai.meleetryhard = undefined;
  level notify("stop_goliath_grab");

  if(isDefined(level.boss_vo) && level.boss_vo.phase < 3) {
    scripts\sp\maps\hometown\hometown_vo::goto_boss_phase(3);
    level.boss_vo.combat = level.boss_vo.combat_loop;
    return;
  }
}

function goliath_grab_monitor() {
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

    var0 = 6;
    var1 = 40;
    var2 = (0, 0, 5);

    if(!scripts\engine\trace::capsule_trace_passed(level.player.origin + var2, level.goliath_ai.origin + var2, var0, var1, level.player.angles, [level.player, level.goliath_ai])) {
      continue;
    }

    var3 = "boss_capture_";
    var4 = scripts\engine\math::get_dot(level.player.origin, level.player.angles, level.goliath_ai.origin);

    if(var4 >= 0.5) {
      var3 += "front";
    } else if(var4 <= -0.5) {
      var3 += "back";
    } else {
      var4 = vectordot(vectorNormalize(level.goliath_ai.origin - level.player.origin), anglestoright(level.player.angles));

      if(var4 > 0) {
        var3 += "right";
      } else {
        var3 += "left";
      }
    }

    var5 = scripts\engine\utility::spawn_script_origin(level.goliath_ai.origin, vectortoangles(level.player.origin - level.goliath_ai.origin));
    level.player_rig = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig", level.player.origin, level.player.angles);
    level.player_rig hide();
    var5 scripts\common\anim::anim_first_frame_solo(level.player_rig, var3);
    var6 = level.player_rig.origin;
    var7 = level.player_rig.angles;
    var5 scripts\common\anim::anim_last_frame_solo(level.player_rig, var3);
    var8 = level.player_rig.origin;

    if(!scripts\engine\trace::capsule_trace_passed(var6, var8, var0, var1, var7, [level.player, level.goliath_ai])) {
      var5 delete();
      level.player_rig delete();
      continue;
    }

    var0 = 25;
    var1 = 60;
    var6 = level.goliath_ai.origin;
    var7 = level.goliath_ai.angles;
    var9 = scripts\engine\sp\utility::spawn_anim_model("goliath_body", level.goliath_ai.origin, level.goliath_ai.angles);
    var9.animname = "generic";
    var9 hide();
    var5 scripts\common\anim::anim_last_frame_solo(var9, var3);
    var8 = var9.origin;

    if(!scripts\engine\trace::capsule_trace_passed(var6, var8, var0, var1, var7, [level.player, level.goliath_ai])) {
      var5 delete();
      level.player_rig delete();
      var9 delete();
      continue;
    }

    level.player notify("grabbed_by_boss");
    level.player scripts\sp\player\context_melee::disable_dynamic_takedowns();
    level.player scripts\common\utility::allow_melee(0);
    level.player lerpfovscalefactor(0, 0.5);
    thread goliath_strangle_effects_capture();
    var5 thread scripts\sp\player_rig::link_player_to_rig(var3, "stand", 1, 0.2, 0, 5, 5, 5, 5, 1);
    var5 thread scripts\common\anim::anim_single([level.goliath_ai, level.player_rig], var3);

    if(!isDefined(level.player_found_a_weapon)) {
      level scripts\sp\player_death::set_custom_death_quote(61);
    } else if(scripts\engine\utility::is_equal(level.player.stealth.hints.causeofdeath, "footstep_sprint")) {
      level scripts\sp\player_death::set_custom_death_quote(68);
    } else if(player_failed_context_melee()) {
      level scripts\sp\player_death::set_custom_death_quote(randomintrange(93, 96));
    } else {
      level scripts\sp\player_death::set_custom_death_quote(58);
    }

    wait 3;
    scripts\sp\utility::missionfailedwrapper();
  }
}

function goliath_grab_give_up_and_shoot() {
  level.goliath_ai endon("start_context_melee");
  level.player endon("grabbed_by_boss");

  for(;;) {
    level.goliath_ai waittill("stealth_combat");
    var0 = 0;
    var1 = 0;

    for(var2 = 0;; var2 = 1) {
      if(var2) {
        var0++;
      } else {
        var0 = 0;
      }

      if(var0 >= 40 || var1 >= 400) {
        stop_goliath_grab();
        return;
      }

      var2 = 0;
      waitframe();

      if(!level.goliath_ai[[level.goliath_ai.fnisinstealthcombat]]()) {
        break;
      }

      var1++;

      if(distancesquared(level.goliath_ai.origin, level.player.origin) > 8100) {
        continue;
      }

      if(!does_goliath_know_where_player_is()) {
        continue;
      }

      if(distancesquared(level.player.origin, getclosestpointonnavmesh(level.player.origin, level.goliath_ai)) < level.goliath_ai.meleerangesq) {
        if(scripts\engine\trace::ray_trace_passed(level.player.origin, level.player.origin + (0, 0, 60), level.player)) {
          continue;
        }
      }
    }
  }
}

function does_goliath_know_where_player_is() {
  if(level.goliath_ai cansee(level.player)) {
    return true;
  }

  var0 = level.goliath_ai lastknownpos(level.player);

  if(distancesquared(var0, level.player.origin) < 100) {
    return true;
  }

  if(isDefined(level.player.lowcovervolume) && ispointinvolume(var0, level.player.lowcovervolume)) {
    return true;
  }

  return false;
}

function boss_enter_anim_monitor() {
  level waittill("house_enter_boss_anim_complete");
  level.boss_enter_anim_done = 1;
}

function goliath_counter_monitor() {
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
      } else if(level.goliath_boss_round == 2) {
        level.player.skip_context_melee_anim = 1;
      } else {
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

    if(scripts\engine\utility::flag("goliath_weapon_exists_hint")) {
      scripts\sp\utility::context_melee_set_hint_directions(["back", "left", "right", "front"]);
    } else {
      scripts\sp\utility::context_melee_set_hint_directions([]);
    }

    scripts\sp\utility::context_melee_set_custom_hint("stab_soldier_noweap");
    scripts\sp\utility::nvidiaansel_scriptdisable(0);
  }
}

function goliath_counter_kill() {
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

      if(isDefined(level.hadir_melee_weapon_pickup)) {
        level.hadir_melee_weapon_pickup delete();
      }

      level notify("boss_counter_vo_start");
      level waittill("start_blur_fail");
      thread counter_black_fade();
      wait 3;
      waitframe();
      level.player enabledeathshield(0);
      waitframe();
      level.player disableinvulnerability();
      level notify("counter_kill");
      wait 1;
      scripts\sp\utility::missionfailedwrapper();
    }
  }
}

function counter_black_fade() {
  level.counterblackoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  waitframe();
  level.counterblackoverlay fadeovertime(2.25);
  level.counterblackoverlay.alpha = 1;
}

function counter_hit_effects() {
  level waittill("hit_effects");
  thread painvision_replacement();
  level.player playRumbleOnEntity("heavy_1s");
  level waittill("hit_effects");
  thread painvision_replacement();
  level.player playRumbleOnEntity("heavy_1s");
}

function hadir_melee_weapon_spawn_catchup() {
  wait 1;
  level.hadir_melee_weapon_pickup = scripts\engine\sp\utility::spawn_anim_model("house_intro_knife", level.gas_attack_anim_node.origin, level.gas_attack_anim_node.angles);
  level.gas_attack_anim_node thread scripts\common\anim::anim_last_frame_solo(level.hadir_melee_weapon_pickup, "house_dad_dies");
  level.hadir_melee_weapon_pickup thread scripts\sp\maps\hometown\hometown_util::goliath_melee_weapon_interact("iw8_knife_kid");
}

function hadir_melee_weapon_spawn() {
  level.hadir_melee_weapon_pickup thread scripts\sp\maps\hometown\hometown_util::goliath_melee_weapon_interact("iw8_knife_kid");
}

function dad_dies_fight_hits() {
  level endon("house_enter_boss_anim_complete");

  for(;;) {
    level waittill("fight_hit");
    earthquake(0.25, 0.2, level.farah_father_ai.origin, 250);
    level.farah_father_ai playRumbleOnEntity("heavy_1s");
  }
}

function dad_dies_fight_hits_hadir() {
  level endon("house_enter_boss_anim_complete");

  for(;;) {
    level waittill("fight_hit_hadir");
    earthquake(0.1, 0.1, level.hadir_body_model.origin, 250);
    level.farah_father_ai playRumbleOnEntity("light_1s");
  }
}

function ambient_house_enter_explosions() {
  level endon("kill_random_explos");

  for(;;) {
    wait randomintrange(10, 16);
    thread scripts\sp\maps\hometown\hometown_anim::play_house_explo(1);
    wait randomintrange(10, 16);
    thread scripts\sp\maps\hometown\hometown_anim::play_house_explo(1);
    wait randomintrange(10, 16);
    thread scripts\sp\maps\hometown\hometown_anim::play_house_explo(1);
  }
}

function audio_truck_passby_ext() {
  level.player setsoundsubmix("sp_ht_truck_by_door", 1, 1);
  wait 9.5;
  var0 = spawn("script_origin", (-816, -1712, 58));
  var0 playSound("scn_hometown_house_truck_by_ext", "trucksounddone");
  var0 moveTo((-713, -2944, 58), 18, 1, 1);
  var0 waittill("trucksounddone");
  level notify("truck_passby_done");
  waitframe();
  var0 stopsounds();
  waitframe();
  var0 delete();
}

#using_animtree("");

function hadir_boost_mayhem() {
  level.hadir_ai detach("head_sc_m_coto");
  level.hadir_ai setanim(%htf_esc_010_boost_hadir_enter_face, 1, 0, 1);
  level notify("hadir_reached_door");
  level.hadir_ai setanim($htf_esc_010_boost_hadir_enter_face, 0, 0, 1);
  level.hadir_ai attach("head_sc_m_coto");
}

function dad_boost_mayhem() {
  level.father_body_model detach("head_hero_farahs_father");
  level.father_body_model setanim(%htf_esc_010_boost_father_enter_face, 1, 0, 1);
  level notify("hadir_reached_door");
  level.father_body_model setanim(%htf_esc_010_boost_father_enter_face, 0, 0, 1);
  level.father_body_model attach("head_hero_farahs_father");
}

function hadir_talk_mayhem() {
  level waittill("mayhem_hadir_talk_start");
  level.hadir_ai detach("head_sc_m_coto");
  level.hadir_ai setanim(%htf_boss_040_hadir_talk_face, 1, 0, 1);
  level waittill("mayhem_hadir_talk_end");
  level.hadir_ai setanim(%htf_boss_040_hadir_talk_face, 0, 0, 1);
  level.hadir_ai attach("head_sc_m_coto");
}

function goliath_procedural_bones() {
  if(getdvarint("scr_use_procedural_bones")) {
    level.goliath_body_model setanim(%proc_node, 1, 0);
    level.goliath_body_model.anim_getrootfunc = &scripts\asm\gesture\script_funcs::set_root;
    return;
  }
}

function hadir_procedural_bones() {
  if(getdvarint("scr_use_procedural_bones")) {
    level.hadir_body_model setanim(%proc_node, 1, 0);
    level.hadir_body_model.anim_getrootfunc = &scripts\asm\gesture\script_funcs::set_root;
    return;
  }
}

function dad_procedural_bones() {
  if(getdvarint("scr_use_procedural_bones")) {
    level.father_body_model setanim(%proc_node, 1, 0);
    level.father_body_model.anim_getrootfunc = &scripts\asm\gesture\script_funcs::set_root;
    return;
  }
}

function goliath_swipe_awareness() {
  level.goliath_ai endon("death");
  var0 = 10000;

  for(;;) {
    if(level.player attackButtonPressed() || level.player meleeButtonPressed()) {
      if(distancesquared(level.goliath_ai.origin, level.player.origin) < var0) {
        if(level.goliath_ai[[level.goliath_ai.fnisinstealthcombat]]()) {
          level.goliath_ai getenemyinfo(level.player);
        } else {
          level.goliath_ai aieventlistenerevent("investigate", level.player, level.player.origin);
        }
      }
    }

    waitframe();
  }
}