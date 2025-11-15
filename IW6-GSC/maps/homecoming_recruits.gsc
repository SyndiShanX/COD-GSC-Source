/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\homecoming_recruits.gsc
****************************************/

recruit_scene() {
  common_scripts\utility::flag_wait("FLAG_start_recruit_scene");
  level.player setclienttriggeraudiozone("homecoming_recruits", 0.5);
  thread maps\_utility::autosave_now_silent();
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 9.01);
  level.debug_do_rhythm_rumble = 1;
  level.timestep = 0.05;
  maps\homecoming_recruits_util::hc_hide_hud();
  level.default_fov = getdvarint("cg_fov");
  level.player thread maps\_utility::lerp_fov_overtime(level.timestep, level.default_fov * 0.9);
  recruit_spawn();
}

recruit_spawn() {
  var_0 = maps\_vignette_util::vignette_actor_spawn("elias_recruits", "elias");
  var_1 = maps\_vignette_util::vignette_actor_spawn("hesh_recruits", "hesh");
  var_2 = maps\_vignette_util::vignette_actor_spawn("merrick_recruits", "merrick");
  var_3 = maps\_vignette_util::vignette_actor_spawn("keagan_recruits", "keagan");
  var_0 maps\_utility::gun_remove();
  var_1 maps\_utility::gun_remove();
  var_1 attach("weapon_mts_255_small", "tag_stowed_back");
  recruit_setup_pilot();
  level.merrick_mask = maps\_utility::spawn_anim_model("merrick_mask");
  level.outside_tower = maps\_utility::spawn_anim_model("outside_tower");
  level.outside_palmtree = maps\_utility::spawn_anim_model("outside_palmtree");
  thread recruit(var_0, var_1, var_2, var_3);
  level waittill("notify_fade_end");
  level.player setclienttriggeraudiozone("homecoming_fade_to_final_black", 2.0);
  level.black_overlay fadeovertime(1.0);
  level.black_overlay.alpha = 1;
  wait 6;
  maps\_utility::nextmission();
}

recruit_setup_pilot() {
  var_0 = maps\_vignette_util::vignette_actor_spawn("pilot_recruits", "pilot");
  var_1 = common_scripts\utility::getstruct("pilot_anim_node", "targetname");
  var_1 thread maps\_anim::anim_loop_solo(var_0, "sitting_idle_pilot");
  var_0 maps\_utility::gun_remove();
  level.pilot = var_0;
}

recruit(var_0, var_1, var_2, var_3) {
  var_4 = common_scripts\utility::getstruct("recruit_anim_node_r", "script_noteworthy");
  var_5 = level.recruits_dog;
  var_6 = [];
  var_6["hesh"] = var_1;
  var_6["merrick"] = var_2;
  var_6["keagan"] = var_3;
  var_6["riley"] = var_5;
  var_6["outside_tower"] = level.outside_tower;
  var_6["outside_palmtree"] = level.outside_palmtree;
  level.player_rig = maps\_utility::spawn_anim_model("player_rig");
  var_6["player_rig"] = level.player_rig;
  level.player playerlinktodelta(var_6["player_rig"], "tag_player", 1, 0, 0, 0, 0);
  maps\homecoming_recruits_util::player_animated_sequence_restrictions();
  var_4 maps\_anim::anim_first_frame(var_6, "recruit");
  common_scripts\utility::waitframe();
  level.player_rig thread maps\homecoming_recruits_util::player_sway();
  thread recruits_dof_changes();
  thread maps\homecoming_fx::fx_recruit_ambient();
  thread maps\homecoming_audio::sfx_scn_recruitment();
  thread maps\homecoming_audio::recruits_pilot_flavorbursts();
  maps\_utility::delaythread(17.8, maps\_utility::music_play, "mus_homecoming_recruits");
  var_5 thread maps\homecoming_audio::sfx_scn_recruitment_riley_growl();
  thread recruit_fadein(var_6["player_rig"]);
  var_1 maps\_utility::delaythread(0.5, maps\_utility::play_sound_on_entity, "scn_recruitment_foley_hesh");
  var_4 thread maps\_anim::anim_single(var_6, "recruit");
  var_4 maps\_anim::anim_single_solo(var_0, "recruit_pt1", undefined, 0.2);
  var_4 maps\_anim::anim_single_solo(var_0, "recruit_pt2");
}

recruit_fadein(var_0) {
  wait 0.65;
  var_1 = 1.0;
  level.black_overlay fadeovertime(var_1);
  level.black_overlay.alpha = 0;
  level.player playerlinktodelta(var_0, "tag_player", 1, 30, 30, 30, 30);
  level.player springcamenabled(level.timestep, 1.6, 0.6);
  level.player setplayerangles(var_0 gettagangles("tag_player"));
}

recruit_extended_intro(var_0, var_1) {
  wait(level.timestep);
  level.player setclienttriggeraudiozone("homecoming_recruits", 0.02);
  level.player playSound("scn_hc_recruitment_intro_lr");
  var_1 maps\_utility::delaythread(5.96, maps\_utility::smart_dialogue, "homcom_els_easysonyoullbeok");
  wait(var_0);
}

recruits_dof_changes() {
  var_0 = level.dofdefault;
  var_1 = [];
  var_1["nearStart"] = 1;
  var_1["nearEnd"] = 2;
  var_1["nearBlur"] = 6;
  var_1["farStart"] = 3;
  var_1["farEnd"] = 450;
  var_1["farBlur"] = 4;
  var_2 = [];
  var_2["nearStart"] = 1;
  var_2["nearEnd"] = 2;
  var_2["nearBlur"] = 6;
  var_2["farStart"] = 3;
  var_2["farEnd"] = 450;
  var_2["farBlur"] = 2;
  maps\_art::dof_enable_script(1, 2, 6, 60, 300, 5, 1.0);
  wait 38.0;
  maps\_art::dof_enable_script(1, 2, 6, 30, 300, 3, 3.0);
  wait 57.0;
  maps\_art::dof_disable_script(4.0);
}

recruits_dog_spawn() {
  var_0 = maps\homecoming_util::dog_spawn();
  var_0.animname = "riley";
  var_1 = common_scripts\utility::getstruct("recruit_anim_node_r", "script_noteworthy");
  var_2 = var_1 common_scripts\utility::spawn_tag_origin();
  var_0 linkto(var_2, "tag_origin", (0, 0, 0), (0, 0, 0));
  level.recruits_dog = var_0;
  common_scripts\utility::flag_wait("FLAG_start_recruit_scene");
  var_0 unlink();
  var_2 delete();
}