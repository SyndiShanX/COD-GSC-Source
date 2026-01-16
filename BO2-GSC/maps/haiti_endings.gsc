/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\haiti_endings.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_music;
#include maps\_objectives;
#include maps\_scene;
#include maps\haiti_util;
#include maps\_vehicle;
#include maps\haiti_anim;
#include maps\haiti;
#include maps\haiti_transmission;
#include maps\_audio;
#include maps\createart\haiti_art;
#include maps\_quadrotor;
#include maps\_osprey;
#include maps\_fxanim;
#include maps\_anim;

init_flags() {
  flag_init("scenarios_begin");
  flag_init("player_shot_guy1");
  flag_init("player_shot_guy2");
  flag_init("scene_0_complete");
  flag_init("scene_1_complete");
  flag_init("scene_2_complete");
  flag_init("scene_3_complete");
  flag_init("killed_menendez");
  flag_init("capture_menendez");
  flag_init("drag_body_end");
  flag_init("delete_react_guys");
  flag_init("the_end");
}

init_spawn_funcs() {
}

skipto_endings_scenario1() {
  level.is_defalco_alive = 1;
  level.is_harper_alive = 1;
  skipto_endings();
}

skipto_endings_scenario2() {
  level.is_defalco_alive = 1;
  level.is_harper_alive = 0;
  skipto_endings();
}

skipto_endings_scenario3() {
  level.is_defalco_alive = 0;
  level.is_harper_alive = 1;
  skipto_endings();
}

skipto_endings_scenario4() {
  level.is_defalco_alive = 0;
  level.is_harper_alive = 0;
  skipto_endings();
}

skipto_endings() {
  maps\haiti_anim::endings_anims();
  level thread maps\haiti::fxanim_construct_hangar();
  level thread model_restore_area("convert_after_trap");
  ending_ceiling = getent("ending_ceiling", "targetname");
  ending_ceiling hide();
  setup_harper();
  skipto_teleport("skipto_endings");
  level thread maps\haiti_transmission::sliding_door_think();
}

endings_main() {
  iprintln("Endings");

  setsaveddvar("Cg_aggressivecullradius", 50);
  setup_endscene_characters();
  level thread slide_door();
  flag_wait("the_end");
  level.player notify("mission_finished");
  wait 0.1;
  nextmission();
}

setup_endscene_characters() {
  if(level.is_harper_alive) {
    level.ai_harper.ignoreme = 1;
    level.ai_harper.animname = "harper";
    level.ai_harper set_ignoreall(1);
    level.ai_harper set_blend_in_out_times(0.2);
    level.ai_harper.overrideactordamage = ::harper_shot_callback;
  }

  if(!isDefined(level.ai_menendez))
    level.ai_menendez = simple_spawn_single("menendez");

  level.ai_menendez.ignoreme = 1;
  level.ai_menendez.animname = "menendez";
  level.ai_menendez disableaimassist();
  level.ai_menendez.health = 99999;
  level.ai_menendez set_ignoreall(1);
  level.ai_menendez set_blend_in_out_times(0.2);
  level.m_fnp45 = spawn("script_model", level.ai_menendez.origin);
  level.m_fnp45 setmodel("t6_wpn_pistol_fnp45_view");
  level.m_fnp45 linkto(level.ai_menendez, "tag_weapon_right", (0, 0, 0));

  if(level.is_defalco_alive) {
    level.ai_defalco = simple_spawn_single("defalco");
    level.ai_defalco disable_long_death();
    level.ai_defalco.ignoreme = 1;
    level.ai_defalco.animname = "defalco";
    level.ai_defalco.health = 1;
    level.ai_defalco set_ignoreall(1);
    level.ai_defalco.overrideactordamage = ::guy2_shot_callback;
    level.ai_defalco set_blend_in_out_times(0.2);
  }

  if(!level.is_defalco_alive) {
    level.ai_pmc = simple_spawn_single("pmc");
    level.ai_pmc disable_long_death();
    level.ai_pmc.ignoreme = 1;
    level.ai_pmc.animname = "defalco";
    level.ai_pmc.health = 1;
    level.ai_pmc set_ignoreall(1);
    level.ai_pmc.overrideactordamage = ::guy2_shot_callback;
    level.ai_pmc set_blend_in_out_times(0.2);
  }

  level.ai_camo = simple_spawn_single("ending_camo");
  level.ai_camo ent_flag_init("camo_suit_on");
  level.ai_camo ent_flag_set("camo_suit_on");
  level.ai_camo disable_long_death();
  level.ai_camo.ignoreme = 1;
  level.ai_camo.animname = "ending_camo";
  level.ai_camo.health = 1;
  level.ai_camo set_ignoreall(1);
  level.ai_camo.overrideactordamage = ::guy1_shot_callback;
  level.ai_camo set_blend_in_out_times(0.2);
}

harper_shot_callback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
  if(isplayer(eattacker))
    missionfailedwrapper_nodeath(&"HAITI_HARPER_KILL");

  return idamage;
}

guy1_shot_callback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
  v_start = vpoint;
  v_end = vpoint + vdir * 1000;
  recordline(v_start, v_end, (1, 0, 0));

  if(isplayer(eattacker))
    flag_set("player_shot_guy1");

  return idamage;
}

guy2_shot_callback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
  v_start = vpoint;
  v_end = vpoint + vdir * 1000;
  recordline(v_start, v_end, (1, 0, 0));

  if(isplayer(eattacker))
    flag_set("player_shot_guy2");

  return idamage;
}

slide_door() {
  level thread player_in_hanger();
  level thread dead_poses();
  level thread killed_menendez();
  level thread capture_menendez();
  trigger_wait("trig_slided_door");
  level.player setstance("stand");
  level.player allowcrouch(0);
  level.player allowstand(1);
  level.player allowprone(0);
  level.player allowjump(0);
  level.player disableweapons();
  level.player takeallweapons();
  luinotifyevent(&"hud_shrink_ammo");

  if(level.is_harper_alive)
    level thread run_scene_and_delete("harper_slide_door_fall");

  level thread run_scene_and_delete("player_slide_door_fall");
  scene_wait("player_slide_door_fall");
  flag_set("scenarios_begin");
}

player_in_hanger() {
  level endon("ending_outside_capture");
  level endon("ending_outside_killed");
  level.player.body = spawn("script_model", level.player.origin);
  level.player.body setmodel(level.player_interactive_model);
  level.player.body.animname = "player_body_model";
  level.player.body set_blend_in_out_times(0.2);
  level.player.body setmovingplatformenabled(1);
  level.player.body hide();

  if(level.is_defalco_alive && level.is_harper_alive)
    run_scene_first_frame("scene_0_v1");
  else if(level.is_defalco_alive && !level.is_harper_alive)
    run_scene_first_frame("scene_0_v2");
  else if(!level.is_defalco_alive && level.is_harper_alive)
    run_scene_first_frame("scene_0_v3");
  else if(!level.is_defalco_alive && !level.is_harper_alive)
    run_scene_first_frame("scene_0_v4");

  flag_wait("scenarios_begin");
  level.player playerlinktoabsolute(level.player.body, "tag_player");
  level.player.body show();
  level.player thread run_whole_ending();
}

run_whole_ending() {
  level endon("scene_complete");
  e_streamer_hint = createstreamerhint((-20803, 4339, -62), 1.0);
  e_streamer_hint1 = createstreamerhint((-20563, 4421, -14), 1.0);
  self thread run_scene_and_delete_0();
  flag_wait("scene_0_complete");
  self thread run_scene_and_delete_1();
  flag_wait("scene_1_complete");
  self thread run_scene_and_delete_2();
  flag_wait("scene_2_complete");
  e_streamer_hint delete();
  e_streamer_hint1 delete();
  self thread moral_choice_scene();
}

dead_poses() {
  level endon("ending_outside_capture");
  level endon("ending_outside_killed");
  run_scene_first_frame("deathpose_gun");
  flag_wait_either("killed_menendez", "capture_menendez");
  delete_scene("deathpose_gun");
}

save_the_game(player) {
  level thread autosave_now("haiti_hanger");
}

run_scene_and_delete_0() {
  level endon("ending_outside_capture");
  level endon("ending_outside_killed");
  createstreamermodelhint("c_mul_menendez_old_seal6_head", 8.0);

  if(level.is_defalco_alive && level.is_harper_alive) {
    run_scene_and_delete("scene_0_v1");
    scene_wait("scene_0_v1");
  } else if(level.is_defalco_alive && !level.is_harper_alive) {
    run_scene_and_delete("scene_0_v2");
    scene_wait("scene_0_v2");
  } else if(!level.is_defalco_alive && level.is_harper_alive) {
    run_scene_and_delete("scene_0_v3");
    scene_wait("scene_0_v3");
  } else if(!level.is_defalco_alive && !level.is_harper_alive) {
    run_scene_and_delete("scene_0_v4");
    scene_wait("scene_0_v4");
  }

  flag_set("scene_0_complete");
}

run_scene_and_delete_1() {
  level endon("ending_outside_capture");
  level endon("ending_outside_killed");

  if(level.is_defalco_alive && level.is_harper_alive) {
    level thread success_watcher_damage("scene_1_v1", level.ai_camo);
    level thread fail_watcher_notetrack("scene_1_v1", level.ai_camo, "scene_1_v1", "event_01_fail");
    level thread scene_complete_on_signal("scene_1_v1_test_failed", "scene_1_v1_test_succeeded");
    run_scene_and_delete("scene_1_v1");
    scene_wait("scene_1_v1");
  } else if(level.is_defalco_alive && !level.is_harper_alive) {
    level thread success_watcher_damage("scene_1_v2", level.ai_camo);
    level thread fail_watcher_notetrack("scene_1_v2", level.ai_camo, "scene_1_v2", "event_01_fail");
    level thread scene_complete_on_signal("scene_1_v2_test_failed", "scene_1_v2_test_succeeded");
    run_scene_and_delete("scene_1_v2");
    scene_wait("scene_1_v2");
  } else if(!level.is_defalco_alive && level.is_harper_alive) {
    level thread success_watcher_damage("scene_1_v3", level.ai_camo);
    level thread fail_watcher_notetrack("scene_1_v3", level.ai_camo, "scene_1_v1", "event_01_fail");
    level thread scene_complete_on_signal("scene_1_v3_test_failed", "scene_1_v3_test_succeeded");
    run_scene_and_delete("scene_1_v3");
    scene_wait("scene_1_v3");
  } else if(!level.is_defalco_alive && !level.is_harper_alive) {
    level thread success_watcher_damage("scene_1_v4", level.ai_camo);
    level thread fail_watcher_notetrack("scene_1_v4", level.ai_camo, "scene_1_v2", "event_01_fail");
    level thread scene_complete_on_signal("scene_1_v4_test_failed", "scene_1_4_test_succeeded");
    level thread run_scene_and_delete("scene_1_v4");
    scene_wait("scene_1_v4");
  }

  flag_set("scene_1_complete");
}

run_scene_and_delete_2() {
  level endon("ending_outside_capture");
  level endon("ending_outside_killed");

  if(level.is_defalco_alive && level.is_harper_alive) {
    level thread success_watcher_damage("scene_2_v1", level.ai_defalco);
    level thread fail_watcher_notetrack("scene_2_v1", level.ai_defalco, "scene_2_v1", "event_02_fail");
    level thread scene_complete_on_signal("scene_2_v1_test_failed", "scene_2_v1_test_succeeded");
    run_scene_and_delete("scene_2_v1");
    scene_wait("scene_2_v1");
  } else if(level.is_defalco_alive && !level.is_harper_alive) {
    level thread success_watcher_damage("scene_2_v2", level.ai_defalco);
    level thread fail_watcher_notetrack("scene_2_v2", level.ai_defalco, "scene_2_v1", "event_02_fail");
    level thread scene_complete_on_signal("scene_2_v2_test_failed", "scene_2_v2_test_succeeded");
    run_scene_and_delete("scene_2_v2");
    scene_wait("scene_2_v2");
  } else if(!level.is_defalco_alive && level.is_harper_alive) {
    level thread success_watcher_damage("scene_2_v3", level.ai_pmc);
    level thread fail_watcher_notetrack("scene_2_v3", level.ai_pmc, "scene_2_v2", "event_02_fail");
    level thread scene_complete_on_signal("scene_2_v3_test_failed", "scene_2_v3_test_succeeded");
    run_scene_and_delete("scene_2_v3");
    scene_wait("scene_2_v3");
  } else if(!level.is_defalco_alive && !level.is_harper_alive) {
    level thread success_watcher_damage("scene_2_v4", level.ai_pmc);
    level thread fail_watcher_notetrack("scene_2_v4", level.ai_pmc, "scene_2_v2", "event_02_fail");
    level thread scene_complete_on_signal("scene_2_v4_test_failed", "scene_2_v4_test_succeeded");
    run_scene_and_delete("scene_2_v4");
    scene_wait("scene_2_v4");
  }

  flag_set("scene_2_complete");
}

scene_complete_on_signal(signal, endon_signal) {
  level endon(endon_signal);
  level waittill(signal);
  level notify("scene_complete");
}

success_watcher_damage(scene_name, entity) {
  level endon(scene_name + "_test_failed");
  level endon("ending_outside_capture");
  level endon("ending_outside_killed");

  if(entity.animname == "ending_camo")
    flag_wait("player_shot_guy1");
  else if(entity.animname == "defalco")
    flag_wait("player_shot_guy2");

  level notify(scene_name + "_test_succeeded");
}

fail_watcher_notetrack(scene_name, entity, fail_scene, fail_notetrack) {
  level endon(scene_name + "_test_succeeded");
  level endon("ending_outside_capture");
  level endon("ending_outside_killed");
  flag_wait(fail_notetrack);
  level notify(scene_name + "_test_failed");
  setmusicstate("HAI_DROP_DOWN_FAIL");
  entity playsound("evt_slide_fail_plr");
  entity shoot();
  level.player dodamage(50, level.player.origin);
  earthquake(0.5, 0.6, level.player.origin, 128);
  level.player playrumbleonentity("damage_heavy");
  level.player shellshock("default", 10);
  scene_wait(scene_name);
  screen_message_delete();
  level.player disableweapons();
  waittillframeend;
  level thread run_scene_and_delete(fail_scene + "_fail");
  missionfailedwrapper();
}

moral_choice_scene() {
  level endon("ending_outside_capture");
  level endon("ending_outside_killed");
  level thread maps\_audio::switch_music_wait("HAI_MORALS", 3);

  if(level.is_defalco_alive)
    level.player set_story_stat("DEFALCO_DEAD_IN_HAITI", 1);

  level.m_knife = spawn("script_model", level.player.body.origin);
  level.m_knife setmodel("t6_wpn_knife_base_prop");
  level.m_knife linkto(level.player.body, "tag_weapon1", (0, 0, 0));
  level thread run_scene_and_delete("moral_choice");
  scene_wait("moral_choice");
}

moral_event_start(player) {
  level endon("menendez_shot");
  level endon("menendez_capture");
  level endon("ending_outside_capture");
  level endon("ending_outside_killed");
  screen_message_create(&"HAITI_SHOOT_MENENDEZ", & "HAITI_CAPTURE_MENENDEZ", undefined, 150);
  wait 0.05;
  level.player thread watch_shoot_menendez();
  level.player thread watch_capture_menendez();
  scene_wait("moral_choice");
  level notify("player_noInput");
  screen_message_delete();
  level.player set_story_stat("MENENDEZ_CAPTURED", 1);
  flag_set("capture_menendez");
}

watch_shoot_menendez() {
  level endon("menendez_capture");
  level endon("player_noInput");
  level endon("ending_outside_capture");
  level endon("ending_outside_killed");

  while(true) {
    if(self usebuttonpressed()) {
      level thread maps\_audio::switch_music_wait("HAI_CHOICE_KILL", 4);
      break;
    }

    wait 0.05;
  }

  screen_message_delete();
  flag_wait("start_choice");
  level notify("menendez_shot");
  moral_achievements();
  level.player set_story_stat("MENENDEZ_DEAD_IN_HAITI", 1);
  flag_wait("kill_menendez");
  level thread run_scene_and_delete("shoot_menendez");
  flag_wait("kill_menendez_fadeout");
  screen_fade_out(1);
  scene_wait("shoot_menendez");
  flag_set("killed_menendez");
}

watch_capture_menendez() {
  level endon("menendez_shot");
  level endon("player_noInput");
  level endon("ending_outside_capture");
  level endon("ending_outside_killed");

  while(true) {
    if(self jumpbuttonpressed()) {
      setmusicstate("HAI_CHOICE_CAPTURE");
      break;
    }

    wait 0.05;
  }

  screen_message_delete();
  flag_wait("start_choice");
  level notify("menendez_capture");
  moral_achievements();
  level.player set_story_stat("MENENDEZ_CAPTURED", 1);
  scene_wait("moral_choice");
  flag_set("capture_menendez");
}

moral_achievements() {
  level.player giveachievement_wrapper("SP_STORY_MENENDEZ_CAPTURED");
}

killed_menendez() {
  level endon("ending_outside_capture");
  flag_wait("killed_menendez");
  level.m_fnp45 delete();
  level.player.body delete();
  level.player enableinvulnerability();
  level thread run_scene_and_delete("menendez_corpse");

  if(level.is_harper_alive) {
    setmusicstate("HAITI_END_KILLED_HARPER");
    level thread run_scene_and_delete("end05_inside_harper");
    exploder(668);
    flag_wait("end05_harper_fadeout");
    screen_fade_out(2);
  }

  level notify("ending_outside_killed");
  delete_exploder(668);
  delete_exploder(100, 650);
  delete_exploder(10110, 10510);
  end_scene("menendez_corpse");
  cleanup_ents("cleanup_hangar");
  load_gump("haiti_gump_endings");
  level thread autosave_now("haiti_ending");
  level thread maps\createart\haiti_art::team_america();
  exploder(651);
  setup_ending_quadrotor();
  setup_ending_vtol();
  level thread civ_vtol();
  level thread claw_spawning();
  level thread wave_spawning();
  level thread lerp_sun_direction((-38, 81, 0), 20);
  rpc("clientscripts/haiti_amb", "sndEndingSnapshot");

  if(level.is_harper_alive) {
    setmusicstate("HAITI_END_KILLED_OUTSIDE_HARPER");
    level thread screen_fade_in(3);
    level thread enemies_capture3(10);
    level thread ending_cowbell(37.8);
    level thread run_scene_and_delete("end05_outside_player");
    level thread run_scene_and_delete("end05_outside_harper");
    level thread run_scene_and_delete("end05_outside_quad");
    level thread run_scene_and_delete("end05_outside_vtol");
    level thread run_scene_and_delete("end05_outside_officers");
    level thread run_scene_and_delete("end05_civ_helper_loop");
  } else {
    setmusicstate("HAITI_END_KILLED_OUTSIDE_NOHARPER");
    level thread screen_fade_in(3);
    level thread reactions_guy(0.1);
    level thread enemies_capture3(5);
    level thread ending_cowbell(26.5);
    level thread run_scene_and_delete("end06_outside_player");
    level thread run_scene_and_delete("end06_outside_quad");
    level thread run_scene_and_delete("end06_outside_vtol");
    level thread run_scene_and_delete("end06_outside_officers");
    level thread run_scene_and_delete("end06_civ_helper_loop");
  }
}

open_end05_gate(player) {
  wait 1.5;
  level thread left_front_prisoners();
  hangar_door_left_1 = getent("hangar_door_left_1", "targetname");
  hangar_door_left_1 movey(-80, 10);
  playsoundatposition("evt_endout04_door_left", (-21146, 4180, -35));
  hangar_door_right_1 = getent("hangar_door_right_1", "targetname");
  hangar_door_right_1 movey(150, 10);
  playsoundatposition("evt_endout04_door_right", (-21135, 4350, -58));
}

end05_start_drag(player) {
  level thread run_scene_and_delete("end05_drag_body");
  scene_wait("end05_drag_body");
  flag_set("drag_body_end");
}

end05_start_kids(player) {
  level thread run_scene_and_delete("end05_civ_kids");
  wait 6;
  flag_set("delete_react_guys");
}

end05_fade_out_black(player) {
  wait 51.9;
  rpc("clientscripts/haiti_amb", "sndTheEnd");
  screen_fade_out(0);
  flag_set("the_end");
}

end06_start_drag(player) {
  level thread run_scene_and_delete("end06_drag_body");
  scene_wait("end06_drag_body");
  flag_set("drag_body_end");
}

end06_start_kids(player) {
  level thread run_scene_and_delete("end06_civ_kids");
  wait 6;
  flag_set("delete_react_guys");
}

end06_fade_out_black(player) {
  wait 40.5;
  rpc("clientscripts/haiti_amb", "sndTheEnd");
  screen_fade_out(0);
  flag_set("the_end");
}

open_gate(player) {
  wait 3;
  hangar_door_left_1 = getent("hangar_door_left_1", "targetname");
  hangar_door_left_1 movey(-80, 10);
  playsoundatposition("evt_endout04_door_left", (-21146, 4180, -35));
  hangar_door_right_1 = getent("hangar_door_right_1", "targetname");
  hangar_door_right_1 movey(150, 10);
  playsoundatposition("evt_endout04_door_right", (-21135, 4350, -58));
}

notetrack_eye_candy01(player) {
  level thread left_front_prisoners();
}

capture_menendez() {
  level endon("ending_outside_killed");
  flag_wait("capture_menendez");
  level.player enableinvulnerability();

  if(level.is_harper_alive) {
    level thread maps\_audio::switch_music_wait("HAITI_END_CAPTURED", 0.65);
    level thread run_scene_and_delete("end03_harperalive");
    level.m_rebar = get_model_or_models_from_scene("end03_harperalive", "rebar");
    flag_wait("end03_harperalive_fadeout");
    screen_fade_out(2);
  } else {
    level thread maps\_audio::switch_music_wait("HAITI_END_CAPTURED", 4.5);
    level thread run_scene_and_delete("end04_harperdead");
    flag_wait("end04_harperdead_fadeout");
    screen_fade_out(2);
  }

  level notify("ending_outside_capture");
  level.ai_menendez delete();
  level.m_fnp45 delete();
  delete_exploder(100, 650);
  delete_exploder(10110, 10510);
  cleanup_ents("cleanup_hangar");
  load_gump("haiti_gump_endings");
  level thread autosave_now("haiti_ending");
  level thread maps\createart\haiti_art::team_america();
  exploder(651);
  setup_ending_quadrotor();
  setup_menendez();
  setup_ending_vtol();

  if(level.is_harper_alive)
    level thread run_scene_and_delete("capture_harper_medic");

  level thread civ_vtol();
  level thread wave_spawning();
  level thread reactions_guy(0.1);
  level thread claw_spawning();
  level thread enemies_capture3(10);
  level thread ending_cowbell(70);
  level thread run_scene_and_delete("capture_menendez1_1");
  level thread run_scene_and_delete("capture_menendez1_2");
  give_scene_models_guns("capture_menendez1_2");
  level thread lerp_sun_direction((-38, 81, 0), 20);
  rpc("clientscripts/haiti_amb", "sndEndingSnapshot");
  level thread screen_fade_in(3);
  scene_wait("capture_menendez1_1");
  level thread run_scene_and_delete("capture_menendez2_1");
  level thread run_scene_and_delete("capture_menendez2_2");
  scene_wait("capture_menendez2_1");
  level thread run_scene_and_delete("capture_menendez3_1");
  level thread run_scene_and_delete("capture_menendez3_2");
  level thread run_scene_and_delete("capture_menendez3_3");

  if(level.is_sco_supporting) {
  }
}

end04_fade_out_black(player) {
  wait 84;
  rpc("clientscripts/haiti_amb", "sndTheEnd");
  screen_fade_out(0);
  flag_set("the_end");
}

setup_menendez() {
  level.ai_menendez = simple_spawn_single("menendez");
  level.ai_menendez.ignoreme = 1;
  level.ai_menendez.animname = "menendez";
  level.ai_menendez.health = 99999;
  level.ai_menendez set_ignoreall(1);
  level.ai_menendez set_blend_in_out_times(0.2);
}

end04_start_drag(player) {
  level thread run_scene_and_delete("capture_menendez1_3");
  scene_wait("capture_menendez1_3");
  flag_set("drag_body_end");
}

setup_ending_vtol() {
  level.vh_vtol = spawn_vehicle_from_targetname("menendez_vtol");
  level.vh_vtol.animname = "menendez_vtol";
}

turn_off_sun_flash_fx(player) {
  level.vh_vtol play_fx("vtol_spotlight", level.vh_vtol.origin, level.vh_vtol.angles + vectorscale((1, 0, 0), 180.0), undefined, 1);
}

menendez_vtol_engines_on(menendez_vtol) {
  level.vh_vtol play_fx("vtol_lights", (0, 0, 0), (0, 0, 0), "engines_off", 1, "tag_origin");
  level.vh_vtol play_fx("end_vtol_exhaust", (0, 0, 0), (0, 0, 0), "engines_off", 1, "tag_fx_engine_left1");
  level.vh_vtol play_fx("end_vtol_exhaust", (0, 0, 0), (0, 0, 0), "engines_off", 1, "tag_fx_engine_right1");
  exploder(653);
  exploder(655);
}

menendez_vtol_engines_off(menendez_vtol) {
  level.vh_vtol notify("engines_off");
  stop_exploder(653);
  wait 5;
  stop_exploder(655);
}

menendez_vtol_engines_on_final(menendez_vtol) {
  level.vh_vtol play_fx("end_vtol_exhaust", (0, 0, 0), (0, 0, 0), undefined, 1, "tag_fx_engine_left1");
  level.vh_vtol play_fx("end_vtol_exhaust", (0, 0, 0), (0, 0, 0), undefined, 1, "tag_fx_engine_right1");
  exploder(655);
  exploder(654);
  wait 1;
  level.vh_vtol play_fx("vtol_lights", (0, 0, 0), (0, 0, 0), undefined, 1, "tag_origin");
}

claw_spawning() {
  a_vh_claws = simple_spawn("sp_ending_claw_allies", ::claw_think);
  s_defend_spot = getstruct("s_end_defend", "targetname");
  a_vh_qr_allies = spawn_vehicles_from_targetname("ending_quadrotor");
  array_thread(a_vh_qr_allies, ::defend, s_defend_spot.origin, s_defend_spot.radius);
}

claw_think() {
  self.ignoreall = 1;
  self.moveplaybackrate = 0.7;

  if(isDefined(self.target)) {
    n_dest = getnode(self.target, "targetname");
    self setgoalnode(n_dest);
  }
}

setup_ending_quadrotor() {
  vh_quadrotor = [];

  for(i = 0; i < 1; i++) {
    vh_quadrotor[i] = spawn_vehicle_from_targetname("end_quadrotor");
    vh_quadrotor[i].supportsanimscripted = 1;
    vh_quadrotor[i].animname = "end_quadrotor_" + (i + 1);
    vh_quadrotor[i] maps\_quadrotor::quadrotor_start_scripted();
  }
}

civ_vtol() {
  level thread run_scene_first_frame("end_right_vtol");
  level thread run_scene_first_frame("end04_civ_vtol");
  level thread run_scene_and_delete("vtol_group1");
  level thread run_scene_and_delete("vtol_civ4_idle");
  level thread run_scene_and_delete("vtol_civ5_idle");
  level thread run_scene_and_delete("vtol_civ6_idle");
  level thread run_scene_and_delete("vtol_civ7_idle");
  give_scene_models_guns("vtol_civ7_idle");
}

wave_spawning() {
  level thread medic_groups(0.1);
  level thread enemies_capture1(0.2);
  level thread enemies_capture2(0.15);
  level thread reactions_groups(0.1);
}

medic_groups(delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  level thread run_scene_and_delete("medic_group3_loop");
  level thread run_scene_and_delete("medic_group2_loop");
  level thread run_scene_and_delete("medic_group4_loop");
  level thread run_scene_and_delete("medic_group5_loop");
}

enemies_capture1(delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  level thread scene_and_loop("grp01_guard02");
  give_scene_models_guns("grp01_guard02");
  level thread scene_and_loop("grp01_guard03");
  give_scene_models_guns("grp01_guard03");
  level thread scene_and_loop("grp01_prisoner05");
  level thread run_scene_and_delete("grp01_guard01_loop");
  give_scene_models_guns("grp01_guard01_loop");
  level thread run_scene_and_delete("grp01_prisoner1_loop");
  level thread run_scene_and_delete("grp01_prisoner2_loop");
}

left_front_prisoners() {
  level thread run_scene_and_delete("grp01_guard01_1_loop");
  give_scene_models_guns("grp01_guard01_1_loop");
  level thread run_scene_and_delete("grp01_prisoner1_1_loop");
  level thread run_scene_and_delete("grp01_prisoner2_1_loop");
  flag_wait("drag_body_end");
  end_scene("grp01_guard01_1_loop");
  end_scene("grp01_prisoner1_1_loop");
  end_scene("grp01_prisoner2_1_loop");
}

enemies_capture2(delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  level thread scene_and_loop("grp02_guard04");
  give_scene_models_guns("grp02_guard04");
  level thread scene_and_loop("grp02_guard05");
  give_scene_models_guns("grp02_guard05");
  level thread scene_and_loop("grp02_prisoner06");
  level thread scene_and_loop("grp02_prisoner07");
  level thread scene_and_loop("grp02_prisoner08");
  level thread scene_and_loop("grp02_prisoner09");
}

enemies_capture3(delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  level thread scene_and_loop("grp02_guard04_1");
  give_scene_models_guns("grp02_guard04_1");
  level thread scene_and_loop("grp02_guard05_1");
  give_scene_models_guns("grp02_guard05_1");
  level thread scene_and_loop("grp02_prisoner06_1");
  level thread scene_and_loop("grp02_prisoner07_1");
  level thread scene_and_loop("grp02_prisoner08_1");
  level thread scene_and_loop("grp02_prisoner09_1");
}

reactions_groups(delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  level thread three_scenes("reactions_grp01_1");
  level thread three_scenes("reactions_grp01_2");
  level thread three_scenes("reactions_grp01_3");
  level thread reactions_grp02_2();
  level thread reactions_grp02_3();
  level thread run_scene_and_delete("landing_guy");
}

reactions_grp02_2() {
  run_scene_and_delete("reactions_grp02_2");
  level thread run_scene_and_delete("reactions_grp02_2_loop");
  flag_wait("delete_react_guys");
  end_scene("reactions_grp02_2_loop");
}

reactions_grp02_3() {
  run_scene_and_delete("reactions_grp02_3");
  level thread run_scene_and_delete("reactions_grp02_3_loop");
  flag_wait("delete_react_guys");
  end_scene("reactions_grp02_3_loop");
}

reactions_guy(delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  run_scene_and_delete("reactions_grp02_1");
  level thread run_scene_and_delete("reactions_grp02_1_loop");
  flag_wait("delete_react_guys");
  end_scene("reactions_grp02_1_loop");
}

three_scenes(scene_name) {
  level thread run_scene_and_delete(scene_name + "_intro");
  give_scene_models_guns(scene_name + "_intro");
}

scene_and_loop(scene_name) {
  run_scene_and_delete(scene_name);
  level thread run_scene_and_delete(scene_name + "_loop");
}

give_scene_models_guns(str_scene_name) {
  a_m_guys = get_model_or_models_from_scene(str_scene_name);

  foreach(m_guy in a_m_guys)
  m_guy attach("t6_wpn_lmg_mk48_world", "tag_weapon_right");
}

ending_cowbell(time) {
  wait 6;
  vehicles = spawn_vehicles_from_targetname("ending_vtol_group_1");
  array_thread(vehicles, ::ending_vtol_think, "start_ending_vtol_group_1");
  wait 3;
  vehicles = spawn_vehicles_from_targetname("ending_vtol_group_2");
  array_thread(vehicles, ::ending_vtol_think, "start_ending_vtol_group_2");
  wait(time);
  vehicles = spawn_vehicles_from_targetname("ending_f35_group_1");
  array_thread(vehicles, ::ending_f35_think, "start_ending_fa38_group_1");
  vehicles[0] playsound("evt_fake_f35_flyby");
  wait 1;
  vehicles = spawn_vehicles_from_targetname("ending_f35_group_2");
  array_thread(vehicles, ::ending_f35_think, "start_ending_fa38_group_2");
  vehicles[0] playsound("evt_fake_f35_flyby");
  wait 1;
  vehicles = spawn_vehicles_from_targetname("ending_f35_group_3");
  array_thread(vehicles, ::ending_f35_think, "start_ending_fa38_group_3");
  vehicles[0] playsound("evt_fake_f35_flyby");
  wait 2.1;
  playsoundatposition("mus_end_hit", (0, 0, 0));
}

ending_vtol_think(path_start) {
  self maps\_osprey::main();

  if(isDefined(path_start)) {
    playfxontag(level._effect["vtol_exhaust_cheap"], self, "tag_engine_left");
    path = getvehiclenode(path_start, "targetname");
    path_fwd = anglestoforward(path.angles);
    path_right = anglestoright(path.angles);
    path_up = anglestoup(path.angles);
    delta = self.origin - path.origin;
    x = vectordot(delta, path_fwd);
    y = vectordot(delta, path_right);
    z = vectordot(delta, path_up);
    self pathfixedoffset((x, y, z));
    self thread go_path(path);
    self waittill("reached_end_node");
    self delete();
  } else {
    fwd = anglestoforward(self.angles);
    self setvehvelocity(fwd * 30 * 17.6);
  }
}

ending_f35_think(path_start) {
  path = getvehiclenode(path_start, "targetname");
  path_fwd = anglestoforward(path.angles);
  path_right = anglestoright(path.angles);
  path_up = anglestoup(path.angles);
  delta = self.origin - path.origin;
  x = vectordot(delta, path_fwd);
  y = vectordot(delta, path_right);
  z = vectordot(delta, path_up);
  self pathfixedoffset((x, y, z));
  self thread go_path(path);
  self waittill("reached_end_node");
  self delete();
}

show_time() {
  time = 0;

  while(true) {
    time = time + 0.05;
    iprintln(time);
    wait 0.05;
  }
}

notetrack_flash_on_camera_cut(m_player_body) {
  rpc("clientscripts/haiti", "screen_flash");
}

grab_gun(player) {
  m_kard = getent("deadguy_kard", "targetname");
  m_kard hide();
  level.player.body attach("t6_wpn_pistol_kard_world", "tag_weapon");
  level.player playerlinktodelta(level.player.body, "tag_player", 1, 30, 12, 15, 15, 1, 1);
  level.player giveweapon("kard_nofirstraise_sp");
  level.player givemaxammo("kard_nofirstraise_sp");
  level.player switchtoweapon("kard_nofirstraise_sp");
  luinotifyevent(&"hud_expand_ammo");
}

scene_0_v1_rebar(harper) {
  ai_harper = get_ais_from_scene("scene_0_v1", "harper");
  m_rebar = spawn("script_model", ai_harper.origin);
  m_rebar setmodel("rebar_anim_haiti");
  m_rebar linkto(ai_harper, "tag_weapon_left", (0, 0, 0));
  exploder(667);
  flag_wait("scene_2_complete");
  m_rebar delete();
  stop_exploder(667);
}

scene_0_v3_rebar(harper) {
  ai_harper = get_ais_from_scene("scene_0_v3", "harper");
  m_rebar = spawn("script_model", ai_harper.origin);
  m_rebar setmodel("rebar_anim_haiti");
  m_rebar linkto(ai_harper, "tag_weapon_left", (0, 0, 0));
  exploder(667);
  flag_wait("scene_2_complete");
  m_rebar delete();
  stop_exploder(667);
}

camo_fail(ai_camo) {
  if(level.ai_camo ent_flag("camo_suit_on"))
    level.ai_camo toggle_camo_suit(1, 0);
}

gun_fire(defalco) {
  level.ai_defalco shoot();
  level.player dodamage(50, level.player.origin);
  playfxontag(level._effect["player_shot_blood"], level.player.body, "tag_origin");
  playfxontag(level._effect["player_fire_death"], level.player.body, "tag_origin");
}

player_no_headlook(player) {
  level.player playerlinktodelta(level.player.body, "tag_player", 1, 0, 0, 0, 0, 1, 1);
}

stab_leg(menendez) {
  playfxontag(level._effect["menendez_knife_stab"], level.m_knife, "tag_fx");
  playfxontag(level._effect["menendez_body_decal"], level.ai_menendez, "j_knee_le");
}

stab_shoulder(menendez) {
  playfxontag(level._effect["menendez_knife_stab"], level.m_knife, "tag_fx");
  playfxontag(level._effect["menendez_body_decal"], level.ai_menendez, "j_shoulder_ri");
  exploder(666);
}

menendez_headshot(ai_menendez) {
  playfxontag(level._effect["muzzle_flash"], level.m_fnp45, "TAG_FLASH");
  playfxontag(level._effect["headshot"], level.ai_menendez, "J_Head");
  exploder(659);
  level.ai_menendez detach("c_mul_menendez_old_seal6_head");
  level.ai_menendez attach("c_mul_menendez_old_seal6_shot_head");
}

rebar_blood_fx(ai_harper) {
  playfxontag(level._effect["harper_blood_spurt"], level.m_rebar, "tag_origin");
}

player_start_slowmo(player) {
  setmusicstate("HAITI_DROP_DOWN");
  level thread timescale_tween(1, 0.15, 0.3);
  level thread player_slowmo_audio();
  clientnotify("timeslow_verb");
  wait 0.7;
  level thread timescale_tween(0.15, 0.65, 0.25);
}

player_end_slowmo(player) {
  clientnotify("fov_reset");
  level notify("timeslow_done");
  level thread timescale_tween(0.65, 1, 0.1);
  level.player disableweapons();
  level.player takeallweapons();
}

player_start_raise_gun(player) {
  level.player enableweapons();
}

player_slowmo_audio() {
  rpc("clientscripts/haiti_amb", "timeslow_reverb");
  level.player playsound("evt_timeslow_start");
  level.player playloopsound("evt_timeslow_loop", 1.5);
  level waittill("timeslow_done");
  clientnotify("timeslow_snd_stop");

  if(!flag("event_02_fail") && !flag("event_01_fail"))
    level.player playsound("evt_timeslow_end");

  level.player stoploopsound(1);
}

fade_out(player) {
  level screen_fade_out(2);
}

fade_in(player) {
  level screen_fade_in(2);
}

start_fov(player) {
  clientnotify("fov_change_1_start");
}

fov_change_1(player) {
  clientnotify("fov_change_1");
}

fov_change_2(player) {
  clientnotify("fov_change_2");
}

fov_change_3(player) {
  clientnotify("fov_change_3");
}

turn_off_spot_light(player) {
  wait 3;
  level notify("ending_explosions");
}

explosions_go_off(player) {
  earthquake(0.8, 2, level.player.origin, 500);
  level.player shellshock("default", 1);
  level.player playrumbleonentity("artillery_rumble");
  playfxontag(getfx("camo_transition"), level.ai_camo, "J_SpineLower");
  exploder(650);
  level thread radial_damage_from_spot("destroy_paper_spot");
  ending_floor = getentarray("ending_floor", "targetname");

  foreach(m_floor in ending_floor)
  m_floor delete();

  setmusicstate("HAITI_END_EXPLOSION");
}

show_ceiling(player) {
  wait 4;
  ending_ceiling = getent("ending_ceiling", "targetname");
  ending_ceiling show();
}

floor_falls(player) {
  level notify("fxanim_floor_collapse_start");
  level thread maps\createart\haiti_art::slip_and_slide();
}

delete_floor(player) {
  maps\_fxanim::fxanim_delete("fxanim_haiti_floor_collapse");
  maps\_fxanim::fxanim_delete("fxanim_haiti_floor_collapse_props");
}

stab_event_start(player) {
  level.player playrumbleonentity("damage_heavy");
  earthquake(0.7, 2, level.player.origin, 500);
  level.player shellshock("default", 2);
}

notetrack_bandana_show(bandana) {
  m_bandana = get_model_or_models_from_scene("capture_menendez2_1", "bandana");
  m_bandana show();
}

notetrack_bandana_hide(bandana) {
  m_bandana = get_model_or_models_from_scene("capture_menendez2_1", "bandana");
  m_bandana hide();
  flag_set("delete_react_guys");
}

notetrack_set_blend_times(e_player_body) {
  e_player_body maps\_anim::anim_set_blend_in_time(0.2);
  e_player_body maps\_anim::anim_set_blend_out_time(0.2);
}

radial_damage_from_spot(str_spot, n_delay) {
  if(isDefined(n_delay))
    wait(n_delay);

  if(isDefined(str_spot)) {
    center = getstruct(str_spot, "targetname");
    n_radius = center.radius;
  }

  if(!isDefined(center)) {
    center = self;
    n_radius = center.radius / 2;
  }

  radiusdamage(center.origin, n_radius, 1000, 900);
}

notetrack_camo_shoot(m_camo) {
  wait 0.3;
  level.ai_camo shoot();
  wait 0.2;
  level.ai_camo shoot();
}

notetrack_defalco_shoot(m_defalco) {
  wait 0.1;
  level.ai_defalco shoot();
}

notetrack_pmc_shoot(m_defalco) {
}