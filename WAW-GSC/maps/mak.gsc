/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mak.gsc
*****************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\_music;
#include maps\_busing;
#using_animtree("generic_human");

main() {
  battlechatter_off();
  SetSavedDvar("compassMaxRange", 2000);
  build_custom_vehicle("rubber_raft");
  build_custom_vehicle("type94");
  maps\_destructible_type94truckcamo::init();
  precache_models();
  precache_rumbles();
  precache_shock();
  precache_strings();
  maps\_banzai::init();
  maps\mak_net::main();
  maps\mak_fx::main();
  CreateThreatBiasGroup("players");
  CreateThreatBiasGroup("heroes");
  CreateThreatBiasGroup("none");
  CreateThreatBiasGroup("rushers");
  maps\_flare::main("tag_origin", undefined, "white");
  level.player_seek_timer = 7;
  level.drone_weaponlist_axis = [];
  level.drone_weaponlist_axis[0] = "type100_smg";
  level.drone_weaponlist_axis[1] = "type99_rifle";
  level.drone_spawnFunction["axis"] = ::drone_character_axis;
  maps\_drones::init();
  default_start(::event1_start);
  add_start("event1_intro", ::event1_after_intro_start, &"STARTS_MAK_EVENT1_AFTER_INTRO");
  add_start("event1_v_under_hut", ::event1_vignette_start, &"STARTS_MAK_EVENT1_V_UNDER_HUT");
  add_start("event1_v_guy2shed", ::event1_vignette_start, &"STARTS_MAK_EVENT1_V_GUY2SHED");
  add_start("event1_v_pond_fight", ::event1_vignette_start, &"STARTS_MAK_EVENT1_V_POND_FIGHT");
  add_start("event1_v_fire_beatdown", ::event1_vignette_start, &"STARTS_MAK_EVENT1_V_FIRE_BEATDOWN");
  add_start("event1_v_tower_collapse", ::event1_vignette_start, &"STARTS_MAK_EVENT1_V_TOWER_COLLAPSE");
  add_start("event1_v_showdown", ::event1_vignette_start, &"STARTS_MAK_EVENT1_V_SHOWDOWN");
  add_start("event1_lmg", ::event1_vignette_start, &"STARTS_MAK_EVENT1_LMG");
  add_start("event2", ::event2_start, &"STARTS_MAK_EVENT2");
  add_start("event2_beach", ::event2_beach_start, &"STARTS_MAK_EVENT2_BEACH");
  add_start("event3_feign", ::event3_feign_start, &"STARTS_MAK_EVENT3_FEIGN");
  add_start("event4", ::event4_start, &"STARTS_MAK_EVENT4");
  add_start("event5", ::event5_start, &"STARTS_MAK_EVENT5");
  add_start("outtro", ::event6_outtro_start, &"STARTS_MAK_OUTTRO");
  level.custom_introscreen = ::custom_introscreen;
  maps\_load::main();
  set_player_attrib("fov", 65);
  level.callbackSaveRestored = ::onMakSaveGameRestored;
  maps\mak_amb::main();
  maps\mak_anim::main();
  maps\_mgturret::init_mg_animent();
  add_hint_string("truck_hint", &"MAK_TRUCK_HINT", ::event4_hint_check);
  init_flags();
  init_threatbias_groups();
  dof_enable(false);
  init_spawn_functions();
  init_lights();
  init_hidden_objects();
  init_script_brushmodels();
  init_radio_destructibles();
  init_friendlies();
  init_plant_charges();
  filter_out_names();
  level thread init_event4_truck();
  level thread set_custom_approach();
  killspawner = 102;
  spawners = GetspawnerArray();
  for(i = 0; i < spawners.size; i++) {
    if((isDefined(spawners[i].script_killspawner)) && (killspawner == spawners[i].script_killspawner)) {
      spawners[i] Delete();
    }
  }
  if(GetDvar("nolink_player") == "") {
    SetDvar("nolink_player", "0");
  }
  level thread debug_ai_prints();
}

set_custom_approach() {
  if(!isDefined(anim.NotFirstTime)) {
    wait(0.1);
  }
  add_custom_exposed_approach(0, % ch_makinraid_creepywalk_stop_center2);
  add_custom_exposed_exit(0, % ch_makinraid_creepywalk_start_center2);
}

add_custom_exposed_approach(index, approach_anim) {
  type = "custom_exposed";
  anim.coverTrans[type][index] = approach_anim;
  anim.coverTransDist[type][index] = getMoveDelta(anim.coverTrans[type][index], 0, 1);
  anim.coverTransAngles[type][index] = getAngleDelta(anim.coverTrans[type][index], 0, 1);
}

add_custom_exposed_exit(index, approach_anim) {
  type = "custom_exposed";
  anim.coverExit[type][index] = approach_anim;
  anim.coverExitDist[type][index] = getMoveDelta(anim.coverExit[type][index], 0, 1);
  anim.coverExitAngles[type][index] = getAngleDelta(anim.coverExit[type][index], 0, 1);
}

precache_models() {
  PrecacheModel("tag_origin");
  PrecacheModel("tag_origin_animate");
  PrecacheModel("viewmodel_usa_raider_player");
  PrecacheModel("radio_jap_bro");
  PrecacheModel("clutter_peleliu_us_helmet");
  PrecacheModel("weapon_jap_katana_short");
  PrecacheModel("weapon_jap_katana_long");
  PrecacheModel("weapon_jap_beating_stick");
  PrecacheModel("static_makin_cigarette");
  PrecacheModel("viewmodel_usa_kbar_knife");
  PrecacheModel("clutter_makin_flashlight");
  PrecacheModel("anim_makin_hutbeamcollapse");
  PrecacheModel("anim_peleliu_fly2shed");
  PrecacheModel("anim_intro_hut_explosion");
  PrecacheModel("anim_makin_firehut_fall");
  PrecacheModel("lights_searchlight_guardtower_v2_off");
  PrecacheModel("anim_makin_radiotower_dest");
  PrecacheModel("static_type94_bed_door_obj");
  PrecacheModel("weapon_rus_zippo");
  PrecacheModel("viewmodel_usa_kbar_knife");
  PrecacheModel("weapon_satchel_charge");
}

precache_shock() {
  PrecacheShellshock("mak_intro");
  PrecacheShellshock("explosion");
  PrecacheShellshock("explosion_mak");
}

precache_rumbles() {
  PrecacheRumble("explosion_generic");
}

precache_strings() {
  PrecacheString(&"MAK_TRUCK_TRIGGER");
}

init_flags() {
  flag_init("intro_done");
  flag_init("event1_detonate_hut4");
  flag_init("event1_corner_hut_destroyed");
  flag_init("beatdown_break_apart");
  flag_init("event1_past_mg");
  flag_init("event2_mg_target_ai");
  flag_init("event2_before_shrine_dialogue");
  flag_init("event2_after_shrine");
  flag_init("event2_banzai_dead");
  flag_init("event2_after_banzai_dialog");
  flag_init("event2_flank_mg");
  flag_init("event2_path_stop2");
  flag_init("event2_barrel_exploded");
  flag_init("event2_boat_on_shore");
  flag_init("event2_beach_clear");
  flag_init("spotlight_dead");
  flag_init("jog_enabled");
  flag_init("event3_charge");
  flag_init("event3_unblock");
  flag_init("feign_can_be_interrupted");
  flag_init("event4_truck_go");
  flag_init("event4_truck_hint");
  flag_init("truck_dialogue_intro");
  flag_init("roebuck_in_truck");
  flag_init("event4_tower_collapse");
  flag_init("event4_light_fuel");
  flag_init("roebuck_event5_planting_charges");
  flag_init("event5_player_charge_set");
  flag_init("event5_charge_set");
  flag_init("event5_bunker_door");
  flag_init("event6_exit1");
  flag_init("event6_exit2");
  flag_init("event6_exit3");
  flag_init("event6_exit4");
  flag_init("event6_boat1_ready");
  flag_init("event6_boat2_ready");
  flag_init("sullivan_boat_in");
  flag_init("roebuck_dialogue_cmon_time");
  flag_init("sullivan_outtro_ready");
  flag_init("sullivan_at_boat");
  flag_init("roebuck_in_boat");
  flag_init("random_player_seek");
  flag_set("random_player_seek");
  flag_init("player_in_boat");
}

init_lights() {
  lights = getEntArray("hut2_corner_light", "targetname");
  array_thread(lights, maps\_lights::turn_off);
  lights = getEntArray("hut1_lights", "targetname");
  array_thread(lights, maps\_lights::turn_off);
}

init_hidden_objects() {
  d_gate1 = GetEnt("compound_destroyed_gate1", "targetname");
  d_gate1 Hide();
  d_gate2 = GetEnt("compound_destroyed_gate2", "targetname");
  d_gate2 Hide();
  trigger = GetEnt("event4_truck_trigger", "targetname");
  trigger SetHintString(&"MAK_TRUCK_TRIGGER");
  trigger trigger_off();
}

init_script_brushmodels() {
  ent = GetEnt("radio_tower_monsterclip", "targetname");
  ent ConnectPaths();
}

init_radio_destructibles() {
  ents = getEntArray("radio", "targetname");
  for(i = 0; i < ents.size; i++) {
    ents[i] thread destructible_radio();
  }
}

destructible_radio() {
  assert(isDefined(self.script_sound));
  self playLoopSound(self.script_sound);
  self.health = 75;
  self setCanDamage(true);
  self waittill("death");
  self StopLoopSound();
  self setModel("radio_jap_bro");
  for(i = 0; i < 7; i++) {
    self playSound("radio_destroyed");
    playFX(level._effect["radio_explode"], self.origin);
    wait(1 + RandomFloat(2));
  }
}

destructible_radio_loop() {
  self endon("death");
  while(1) {
    self playSound(self.script_sound, "sounddone");
    self waittill("sounddone");
  }
}

init_friendlies() {
  guys = getEntArray("starting_allies", "targetname");
  for(i = 0; i < guys.size; i++) {
    guys[i] set_bullet_shield();
    guys[i].ignoreme = true;
    guys[i].ignoreall = true;
  }
  level.sullivan = GetEnt("sullivan", "script_noteworthy");
  level.roebuck = GetEnt("roebuck", "script_noteworthy");
  guys = get_force_color_guys("allies", "g");
  level.sniper = guys[0];
  CreateThreatBiasGroup("sullivan");
  CreateThreatBiasGroup("roebuck");
  CreateThreatBiasGroup("sniper");
  level.sullivan SetThreatBiasGroup("sullivan");
  level.roebuck SetThreatBiasGroup("roebuck");
  level.sniper SetThreatBiasGroup("sniper");
  level.sullivan.animname = "sullivan";
  level.roebuck.animname = "roebuck";
  level.sullivan.goalradius = 32;
  level.roebuck.goalradius = 32;
  level.heroes = [];
  level.heroes[0] = level.sullivan;
  level.heroes[1] = level.roebuck;
  level.heroes[2] = level.sniper;
  for(i = 0; i < level.heroes.size; i++) {
    level.heroes[i] make_hero();
  }
}

init_threatbias_groups() {
  CreateThreatBiasGroup("event1_katana_run_axis");
  CreateThreatBiasGroup("event1_katana_run_ally");
  CreateThreatBiasGroup("event2_beach_allies");
  CreateThreatBiasGroup("event2_beach_axis");
  SetThreatBias("event2_beach_allies", "event2_beach_axis", 120);
  CreateThreatBiasGroup("event5_bunker_allies");
  CreateThreatBiasGroup("event5_bunker_axis");
  SetThreatBias("event5_bunker_axis", "event5_bunker_allies", 2000000);
}

init_spawn_functions() {
  create_spawner_function("event1_ally_held_down", "script_noteworthy", ::set_targetname_to_noteworthy);
  create_spawner_function("event1_boatsquad1", "script_noteworthy", ::set_targetname_to_noteworthy);
  create_spawner_function("event1_guys_behind_hut", "script_noteworthy", ::set_targetname_to_noteworthy);
  create_spawner_function("event1_lmg_backup", "script_noteworthy", ::set_targetname_to_noteworthy);
  create_spawner_function("event2_boatsquad1", "targetname", ::set_targetname_to_noteworthy);
  create_spawner_function("event2_boatsquad2", "targetname", ::set_targetname_to_noteworthy);
  create_spawner_function("event2_axis_spawners", "targetname", ::event2_flood_spawner);
  create_spawner_function("event2_spawn_to_die", "targetname", ::spawn_to_die);
  create_spawner_function("event2_spot_lighter", "script_noteworthy", ::event2_spotter);
  create_spawner_function("event2_spot_lighter", "script_noteworthy", ::balcony_death);
  create_spawner_function("event2_spot_light_sniper", "script_noteworthy", ::balcony_death);
  create_spawner_function("event2_banzai_spawners", "targetname", ::set_no_gib);
  create_spawner_function("event1_hut_collapse_spawner", "targetname", ::collapse_guy_gun_remove);
  create_spawner_function("event3_blocker_spawners", "targetname", ::event3_blocker);
  create_spawner_function("event6_respawner2", "targetname", ::event6_reset_ignoreme);
  spawners = GetspawnerArray();
  for(i = 0; i < spawners.size; i++) {
    if(isDefined(spawners[i].script_playerseek) && spawners[i].script_playerseek == 999) {
      spawners[i].script_playerseek = undefined;
      if(isDefined(spawners[i].script_goalvolume)) {
        continue;
      }
      spawners[i] add_spawn_function(::random_player_seek);
    }
  }
}

init_plant_charges() {
  triggers = getEntArray("plant_charge", "targetname");
  for(i = 0; i < triggers.size; i++) {
    triggers[i] thread plant_charge_think();
  }
}

filter_out_names() {
  names = [];
  names[names.size] = "Lozano";
  names[names.size] = "Denny";
  names[names.size] = "Cook";
  names[names.size] = "Hutchinson";
  names[names.size] = "Allen";
  names[names.size] = "Gallagher";
  names[names.size] = "Ryan";
  names[names.size] = "Bunting";
  names[names.size] = "McCawley";
  names[names.size] = "Dwyer";
  names[names.size] = "Rivera";
  names[names.size] = "Anderson";
  names[names.size] = "Luyties";
  new_names = [];
  for(i = 0; i < level.names["american"].size; i++) {
    add_name = true;
    for(q = 0; q < names.size; q++) {
      if(level.names["american"][i] == names[q]) {
        add_name = false;
        break;
      }
    }
    if(add_name) {
      new_names[new_names.size] = level.names["american"][i];
    }
  }
  level.names["american"] = new_names;
}

init_event4_truck() {
  truck = GetEnt("event4_truck", "targetname");
  truck ent_flag_init("started_on_path");
  truck setCanDamage(false);
  truck.animname = "event4_truck";
  template = GetEnt("event4_truck_template", "targetname");
  barrels = getEntArray("event4_truck_barrels", "targetname");
  truck thread maps\mak_anim::play_vehicle_anim("init");
  tags[0] = "tag_passenger7";
  tags[1] = "tag_passenger5";
  tags[2] = "tag_passenger3";
  tags[3] = "tag_passenger9";
  for(i = 0; i < barrels.size; i++) {
    barrels[i] LinkTo(truck, tags[i], (0, 0, 0), (0, 0, 0));
  }
  template Delete();
}

drone_character_axis() {
  if(RandomInt(100) > 98) {
    character\char_jap_off::main();
  } else {
    character\char_jap_makonly_rifle::main();
  }
}

custom_introscreen(string1, string2, string3, string4, string5) {
  if(GetDvar("introscreen") == "0") {
    wait(0.05);
    waittillframeend;
    level notify("finished final intro screen fadein");
    waittillframeend;
    flag_set("starting final intro screen fadeout");
    waittillframeend;
    level notify("controls_active");
    waittillframeend;
    flag_set("introscreen_complete");
    flag_set("pullup_weapon");
    return;
  }
  if(level.start_point != "default") {
    return;
  }
  level.introblack = NewHudElem();
  level.introblack.x = 0;
  level.introblack.y = 0;
  level.introblack.horzAlign = "fullscreen";
  level.introblack.vertAlign = "fullscreen";
  level.introblack.foreground = true;
  level.introblack SetShader("black", 640, 480);
  flag_wait("all_players_connected");
  freezecontrols_all(true);
  level._introscreen = true;
  wait(0.05);
  level.introstring = [];
  if(isDefined(string1)) {
    maps\_introscreen::introscreen_create_line(string1, "lower_left", 1.75);
  }
  wait(2);
  level thread set_all_players_double_vision(5, 0.05);
  level thread set_all_players_blur(2, 0.05);
  if(isDefined(string2)) {
    maps\_introscreen::introscreen_create_line(string2, "lower_left", 1.75);
  }
  if(isDefined(string3)) {
    maps\_introscreen::introscreen_create_line(string3, "lower_left", 1.75);
  }
  level thread set_all_players_shock("mak_intro", 6);
  if(isDefined(string4)) {
    wait(2);
    maps\_introscreen::introscreen_create_line(string4, "lower_left", 1.75);
  }
  if(isDefined(string5)) {
    wait(2);
    maps\_introscreen::introscreen_create_line(string5, "lower_left", 1.75);
  }
  level notify("finished final intro screen fadein");
  wait(2);
  level.introblack FadeOverTime(0.5);
  level.introblack.alpha = 0;
  flag_set("starting final intro screen fadeout");
  if(is_mature()) {
    freezecontrols_all(false);
  }
  level._introscreen = false;
  level notify("controls_active");
  level thread maps\_introscreen::introscreen_fadeOutText();
  flag_set("introscreen_complete");
  level thread set_all_players_double_vision(0, 2);
  level thread set_all_players_blur(0, 2);
  wait(4.5);
  level thread set_all_players_shock("mak_intro", 3);
  level thread set_all_players_double_vision(3, 2);
  level thread set_all_players_blur(1, 2);
  wait(2.25);
  level thread set_all_players_double_vision(0, 3);
  level thread set_all_players_blur(0, 3.25);
}

event1_start() {
  set_player_attrib("ignoreme", true);
  set_start_position("event1_starts", true);
  level thread event1_intro();
}

event1_after_intro_start() {
  set_start_position("event1_starts", true);
  patrollers = getEntArray("event1_patroller", "targetname");
  doc_guys = [];
  for(i = 0; i < patrollers.size; i++) {
    if(IsSubStr(patrollers[i].script_noteworthy, "secondary")) {
      patrollers[i].targetname = "doc_guy";
      doc_guys[doc_guys.size] = patrollers[i];
    }
  }
  event1_remove_start_ents();
  for(i = 0; i < doc_guys.size; i++) {
    doc_guys[i].targetname = "event1_patroller";
  }
  wait(2);
  flag_set("intro_done");
  event1_start_delayed_patrollers();
  level thread event1_detonate_huts();
  maps\mak_anim::anim_intro_shed_light();
  pow2 = GetEnt("pow2", "script_noteworthy");
  pow2 Delete();
}

event1_vignette_start() {
  triggers = getEntArray("flood_spawner", "targetname");
  for(i = 0; i < triggers.size; i++) {
    spawners = getEntArray(triggers[i].target, "targetname");
    for(q = 0; q < spawners.size; q++) {
      spawners[q].count = 0;
    }
  }
  event1_remove_start_ents(true);
  if(level.start_point == "event1_v_under_hut") {
    set_start_position("event1_v_under_hut_starts", true);
    exploder(104);
    level thread maps\mak_amb::hut_4_exp();
    flag_wait("event1_under_hut4");
    level thread event1_under_hut();
  } else if(level.start_point == "event1_v_guy2shed") {
    set_start_position("event1_v_guy2shed_starts", true);
    level thread event1_guy_2_shed();
  } else if(level.start_point == "event1_v_pond_fight") {
    set_start_position("event1_pond_fight_starts", true);
    level thread event1_pond_fight();
    flag_wait("event1_hut3_corner_explosion");
    level thread event1_corner_explosion();
  } else if(level.start_point == "event1_v_fire_beatdown") {
    set_start_position("event1_fire_beatdown_starts", true);
    spawner = GetEnt("event1_ally_fire_beatdown", "script_noteworthy");
    guy = spawn_guy(spawner);
    flag_wait("event1_hut3_corner_explosion");
    level thread event1_corner_explosion();
    level thread event1_fire_beatdown();
  } else if(level.start_point == "event1_v_showdown") {
    set_start_position("event1_showdown_starts", true);
    flag_wait("event1_showdown");
    level thread event1_showdown();
  } else if(level.start_point == "event1_lmg") {
    scout1 = GetEnt("scout1", "script_noteworthy");
    scout1 Delete();
    scout2 = GetEnt("scout2", "script_noteworthy");
    scout2 Delete();
    set_start_position("event1_boatsquad1_starts");
    ally_showdown_spawner = GetEnt("ally_showdown", "script_noteworthy");
    ally_showdown_spawner.origin = (-11598, -15118, 156);
    guy = spawn_guy(ally_showdown_spawner);
    guy set_force_color("y");
    guy thread replace_on_death();
    trigger_color_trigger(8);
    guys = getEntArray("starting_allies", "targetname");
    for(i = 0; i < guys.size; i++) {
      guys[i].ignoreall = false;
      guys[i].ignoreme = false;
    }
    spawners = getEntArray("event1_boatsquad1", "script_noteworthy");
    spawn_guys(spawners);
    flag_set("event1_boatsquad1_moveup");
    level thread event1_boatsquad1();
  } else if(level.start_point == "event1_v_tower_collapse") {
    set_start_position("event1_tower_collapse_starts", true);
    exploder(101);
    level thread event1_hut1_fx();
    wait(2);
    flag_wait("event1_hut1_collapse");
    level thread event1_hut_collapse();
  }
}

event1_remove_start_ents(all) {
  axis = getEntArray("intro_axis_group", "targetname");
  axis2 = getEntArray("event1_patroller", "targetname");
  axis = array_combine(axis, axis2);
  for(i = 0; i < axis.size; i++) {
    axis[i] Delete();
  }
  mitch = GetEnt("mitch", "script_noteworthy");
  mitch Delete();
  pow_group = get_event1_pow_group();
  for(i = 0; i < pow_group.size; i++) {
    if(pow_group[i].targetname == "event1_pow_beaters") {
      pow_group[i] Delete();
    }
  }
  if(isDefined(all)) {
    for(i = 0; i < pow_group.size; i++) {
      if(isDefined(pow_group[i])) {
        pow_group[i] Delete();
      }
    }
    rescuers = getEntArray("event1_rescuers", "targetname");
    for(i = 0; i < rescuers.size; i++) {
      rescuers[i] Delete();
    }
    trigger = GetEnt("first_spawners", "script_noteworthy");
    trigger Delete();
  }
}

event1_intro() {
  level thread collectible_corpse();
  setmusicstate("INTRO");
  set_player_attrib("crouch", false);
  set_player_attrib("prone", false);
  flag_wait("all_players_connected");
  flag_wait("all_players_spawned");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    player SetClientDvar("hud_showStance", "0");
    player SetClientDvar("compass", "0");
    player SetClientDvar("ammoCounterHide", "1");
    player setclientdvar("miniscoreboardhide", "1");
  }
  share_screen(get_host(), true, true);
  for(i = 0; i < players.size; i++) {
    players[i] DisableWeapons();
  }
  level waittill("finished final intro screen fadein");
  wait(1.8);
  node = GetNode("intro", "targetname");
  pow_group = get_event1_pow_group();
  level thread anim_single(pow_group, "intro", undefined, node);
  for(i = 0; i < pow_group.size; i++) {
    if(pow_group[i].animname == "pow2") {
      pow_group[i] thread maps\mak_anim::death_after_anim();
    } else if(pow_group[i].animname == "pow1" || pow_group[i].animname == "pow3") {
      pow_group[i] thread maps\mak_anim::loop_after_anim("loop", undefined, node, "stop_tied_up_loop");
    }
    pow_group[i] thread maps\mak_anim::print_tag_pos("tag_inhand");
  }
  officer = GetEnt("intro_officer", "script_noteworthy");
  officer Attach("static_makin_cigarette", "tag_inhand");
  officer thread maps\mak_anim::detach_after_anim("static_makin_cigarette", "tag_inhand");
  level thread maps\mak_fx::cig_smoke(officer);
  officer init_intro_settings();
  interogator = GetEnt("interogator", "script_noteworthy");
  interogator init_intro_settings();
  interogator Attach("weapon_jap_beating_stick", "tag_weapon_right");
  mitch = GetEnt("mitch", "script_noteworthy");
  mitch init_intro_settings();
  mitch.weapon = "";
  mitch.dropweapon = false;
  guys = [];
  guys[0] = officer;
  guys[1] = mitch;
  guys[2] = interogator;
  level thread event1_give_player_weapons();
  hide_all_player_models();
  level thread maps\mak_anim::all_players_play_viewhands("intro", node, false, 0, 1, 20, 20, 10, 10, false, "intro_hands");
  level thread anim_single(guys, "intro", undefined, node);
  mitch thread maps\mak_anim::death_after_anim();
  interogator thread maps\mak_anim::death_after_anim();
  level thread event1_intro_player_blocker();
  flag_wait("intro_done");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    num = players[i] GetEntityNumber();
    level._player_breadcrumbs[num][0].pos = players[i].origin;
    level._player_breadcrumbs[num][0].ang = players[i].angles;
  }
  autosave_now("after_intro");
  event1_start_delayed_patrollers();
}

event1_intro_player_blocker() {
  flag_wait("intro_done");
  wait(0.5);
  blocker = getEntArray("intro_player_blocker", "targetname");
  for(i = 0; i < blocker.size; i++) {
    blocker[i] Delete();
  }
}

event1_redshirts_regroup() {
  redshirts = getEntArray("event1_redshirts", "script_noteworthy");
  nodes = GetNodeArray("event1_redshirt_nodes", "targetname");
  for(i = 0; i < redshirts.size; i++) {
    redshirts[i].goalradius = 64;
    redshirts[i] SetGoalNode(nodes[i]);
  }
}

event1_give_player_weapons() {
  level waittill("intro_viewhands_anim_done");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    player EnableWeapons();
    player SetClientDvar("hud_showStance", "1");
    player SetClientDvar("compass", "1");
    player SetClientDvar("ammoCounterHide", "0");
    player setclientdvar("miniscoreboardhide", "0");
  }
  set_player_attrib("crouch", true);
  set_player_attrib("prone", true);
}

init_intro_settings() {
  self.animname = self.script_noteworthy;
  self.a.nodeath = true;
  if(self.script_noteworthy != "scout1" && self.script_noteworthy != "scout2") {
    self thread maps\mak_anim::goalpos_after_anim();
  }
  if(self.script_noteworthy == "pow_beater2") {
    return;
  }
  self gun_remove();
}

event1_detonate_huts() {
  struct = GetStruct("event1_response_light", "targetname");
  for(i = 0; i < 2; i++) {
    light_ent = spawn("script_model", struct.origin);
    light_ent setModel("tag_origin");
    light_ent.angles = VectorToAngles(level.roebuck.origin - light_ent.origin);
    playFXOnTag(level._effect["flash_light"], light_ent, "tag_origin");
    wait(0.35);
    light_ent Delete();
    if(i == 0) {
      wait(0.2);
    }
  }
  level thread event1_patroller_reactions();
  struct = GetStruct("intro_hut1_rumble", "targetname");
  PlayRumbleOnPosition("explosion_generic", struct.origin);
  Earthquake(0.2, 1, struct.origin, 2000);
  exploder(101);
  playsoundatposition("exp_hut_1", (-10608, -16232, 8));
  level thread event1_hut1_fx();
  wait(0.5);
  struct = GetStruct("intro_hut2_rumble", "targetname");
  PlayRumbleOnPosition("explosion_generic", struct.origin);
  Earthquake(0.3, 1, struct.origin, 3000);
  playsoundatposition("exp_hut_2", (-9720, -16504, 152));
  exploder(102);
  wait(1);
  struct = GetStruct("intro_hut3_rumble", "targetname");
  PlayRumbleOnPosition("explosion_generic", struct.origin);
  Earthquake(0.4, 1.5, struct.origin, 3000);
  playsoundatposition("exp_hut_3", (-10568, -16776, 152));
  exploder(103);
  wait(0.5);
  struct = GetStruct("intro_hut4_rumble", "targetname");
  PlayRumbleOnPosition("explosion_generic", struct.origin);
  playsoundatposition("exp_hut_4", (-10136, -17560, 152));
  Earthquake(0.5, 3, struct.origin, 3000);
  exploder(104);
  level thread maps\mak_anim::anim_hut4_pieces();
  level thread maps\mak_amb::hut_4_exp();
  flag_set("event1_detonate_hut4");
  level thread event1_open_fire();
  setmusicstate("VILLAGE");
  wait(1);
  lights = getEntArray("hut1_lights", "targetname");
  array_thread(lights, maps\_lights::turn_on);
  level.sullivan disable_ai_color();
  level thread event1_roebuck_after_intro_run();
  level thread event1_sullivan_3_route();
  wait(3);
  trigger_color_trigger(0);
  level thread event1_master_thread();
  battlechatter_on();
}

event1_roebuck_after_intro_run() {
  pos = level.roebuck.origin + (0, 230, 0);
  trace = bulletTrace(pos + (0, 0, 100), pos + (0, 0, -1000), false, undefined);
  level.roebuck.moveplaybackrate = 0.7;
  level.roebuck disable_ai_color();
  og_goalradius = level.roebuck.goalradius;
  level.roebuck SetGoalPos(trace["position"]);
  level.roebuck waittill("goal");
  level.roebuck.goalradius = og_goalradius;
  level.roebuck.moveplaybackrate = 1;
  flag_wait("intro_done");
  level.roebuck enable_ai_color();
}

event1_sullivan_3_route() {
  node = GetNode("event1_sullivan_3_route", "targetname");
  anim_reach_solo(level.sullivan, "3_route", undefined, node);
  level thread anim_single_solo(level.sullivan, "3_route", undefined, node);
  level.sullivan enable_ai_color();
  level.sullivan disable_arrivals(true, true, undefined, 4);
}

event1_hut1_fx() {
  pieces = getEntArray("hut1_pieces", "script_noteworthy");
  org = getstruct("hut1_collapse_fx1", "targetname");
  parent = undefined;
  fx_models = [];
  if(NumRemoteClients()) {
    max_lower_fx = 4;
  } else {
    max_lower_fx = 9;
  }
  pieces = array_randomize(pieces);
  for(i = 0; i < pieces.size; i++) {
    if(isDefined(pieces[i].script_string) && pieces[i].script_string == "parent") {
      pieces[i].smoke_fx = spawn("script_model", org.origin);
      pieces[i].smoke_fx setModel("tag_origin");
      pieces[i].smoke_fx.angles = (-90, 0, 0);
      pieces[i].smoke_fx LinkTo(pieces[i]);
      playFXOnTag(level._effect["hut1_smoke"], pieces[i].smoke_fx, "tag_origin");
      parent = pieces[i];
    }
    pieces[i].fx_models = [];
    if(max_lower_fx > 0 && pieces[i].origin[2] > 0 && pieces[i].origin[2] < 300) {
      fx_model = spawn("script_model", pieces[i].origin);
      fx_model setModel("tag_origin");
      fx_model.angles = (-90, 0, 0);
      fx_model LinkTo(pieces[i]);
      fx = "hut1_fire_pole";
      playFXOnTag(level._effect[fx], fx_model, "tag_origin");
      pieces[i].fx_models[pieces[i].fx_models.size] = fx_model;
      max_lower_fx--;
    } else {
      structs = getstructarray(pieces[i].script_linkto, "script_noteworthy");
      pieces[i].upper = true;
      for(q = 0; q < structs.size; q++) {
        fx_model = 0;
        if(!NumRemoteClients()) {
          fx_model = spawn("script_model", structs[q].origin);
          fx_model setModel("tag_origin");
          fx_model.angles = (-90, 0, 0);
          fx_model LinkTo(pieces[i]);
        }
        fx = "hut1_fire_medium";
        if(isDefined(structs[q].script_string)) {
          if(structs[q].script_noteworthy == "large") {
            fx = "hut1_fire_large";
          }
        }
        if(!NumRemoteClients()) {
          playFXOnTag(level._effect[fx], fx_model, "tag_origin");
          pieces[i].fx_models[pieces[i].fx_models.size] = fx_model;
        }
      }
    }
  }
}

event1_start_delayed_patrollers() {
  patrollers = getEntArray("event1_patroller", "targetname");
  for(i = 0; i < patrollers.size; i++) {
    if(isDefined(patrollers[i].script_string)) {
      patrollers[i] thread maps\_patrol::patrol(patrollers[i].script_string);
    }
  }
}

event1_patroller_reactions() {
  patrollers = getEntArray("event1_patroller", "targetname");
  for(i = 0; i < patrollers.size; i++) {
    patrollers[i] thread event1_patroller_reaction_internal();
  }
}

event1_patroller_reaction_internal() {
  self endon("death");
  if(isDefined(self.script_animation)) {
    self thread anim_single_solo(self, self.script_animation);
  }
  self notify("end_patrol");
  self.ignoreall = false;
  self.ignoreme = false;
  delete_me = false;
  self.goalradius = 256;
  if(self.script_noteworthy == "event1_patroller_delete") {
    delete_me = true;
    self.goalradius = 32;
  } else if(self.script_noteworthy == "die") {
    flag_wait("event1_detonate_hut4");
    wait(2);
    hut_origin = (-10112, -17320, -500);
    angles = VectorToAngles(self.origin - hut_origin);
    yaw = (0, angle_normalize_180(angles[1] - self.angles[1]), 0);
    self.deathanim = get_explosion_death(yaw[1]);
    self set_random_gib();
    self AnimMode("nogravity");
    self DoDamage(self.health + 10, (0, 0, 0));
    return;
  }
  node = GetNode(self.script_noteworthy, "targetname");
  self follow_nodes(node);
  if(delete_me) {
    self Delete();
  }
}

event1_open_fire() {
  wait(4);
  set_player_attrib("ignoreme", false);
  guys = getEntArray("starting_allies", "targetname");
  for(i = 0; i < guys.size; i++) {
    guys[i].ignoreall = false;
    guys[i].ignoreme = false;
  }
}

event1_master_thread() {
  flag_clear("random_player_seek");
  array = [];
  array[array.size] = "random_keep_up1";
  array[array.size] = "random_keep_up2";
  array[array.size] = "random_keep_up3";
  array[array.size] = "random_keep_up4";
  array[array.size] = "random_keep_up5";
  array[array.size] = "random_keep_up6";
  array[array.size] = "random_keep_up7";
  array[array.size] = "random_keep_up8";
  array[array.size] = "random_keep_up9";
  array[array.size] = "random_keep_up10";
  array[array.size] = "random_keep_up11";
  array[array.size] = "random_keep_up12";
  array[array.size] = "random_keep_up13";
  array[array.size] = "random_keep_up14";
  array[array.size] = "random_keep_up15";
  array[array.size] = "random_keep_up16";
  level.roebuck thread repeat_dialog_along_vec(array, (0, 90, 0), 300, 5, 5, "event1_showdown");
  flag_wait("event1_near_hut4");
  level thread event1_pond_fight();
  flag_wait("event1_under_hut4");
  level thread event1_under_hut();
  flag_wait("event1_guy_2_shed");
  flag_set("random_player_seek");
  level thread event1_guy_2_shed();
  level thread event1_near_shed();
  flag_wait("event1_grenade_scene");
  level.special_autosavecondition = ::autosave_light_check;
  autosave_by_name("event1_grenade_scene");
  level thread event1_orange_team_death();
  flag_wait("event1_hut3_corner_explosion");
  level.special_autosavecondition = undefined;
  level thread event1_corner_explosion();
  level thread event1_fire_beatdown();
  flag_wait("event1_save_ryan");
  level thread event1_kill_off_enemies();
  level thread event1_boatsquad1_lookat();
  level thread event1_after_beatdown_enemies();
  flag_wait("event1_boatsquad1_moveup");
  autosave_by_name("after_beatdown");
  level thread event1_boatsquad1();
  flag_wait("event1_hut1_collapse");
  level thread event1_hut_collapse();
  flag_wait("event1_showdown");
  level thread event1_showdown();
}

event1_pond_fight() {
  spawners = getEntArray("event1_pond_fighter", "targetname");
  ally = undefined;
  axis = undefined;
  guys = [];
  for(i = 0; i < spawners.size; i++) {
    guys[i] = spawners[i] Stalingradspawn();
    if(spawn_failed(guys[i])) {
      continue;
    }
    if(guys[i].script_noteworthy == "ally_pond_fighter") {
      ally = guys[i];
    } else {
      axis = guys[i];
    }
    guys[i].animname = guys[i].script_noteworthy;
  }
  ally setCanDamage(false);
  ally.saved = false;
  axis thread event1_pond_fighter_damage(ally);
  node = GetNode("event1_pond_fight", "targetname");
  level anim_loop(guys, "pond_fight_loop", undefined, "stop_pond_fight", node);
  if(ally.saved) {
    if(isDefined(axis) && IsAlive(axis)) {
      axis.allowdeath = true;
      axis DoDamage(axis.health + 50, (0, 0, 0));
    }
    ally anim_stopanimscripted();
    ally setCanDamage(true);
    ally set_force_color("y");
  } else {
    level thread anim_single(guys, "pond_fight_out", undefined, node);
    for(i = 0; i < guys.size; i++) {
      guys[i] thread maps\mak_anim::death_after_anim(undefined, "ragdoll", "explosion");
    }
  }
  wait(10);
  level thread event1_corner_explosion();
}

event1_pond_fighter_damage(ally) {
  level endon("stop_pond_fight");
  count = 0;
  for(;;) {
    self waittill("damage", dmg, attacker);
    if(IsPlayer(attacker)) {
      count++;
      if(count > 1) {
        break;
      }
    }
    self.health = 50;
  }
  if(isDefined(ally) && IsAlive(ally)) {
    ally.saved = true;
    level notify("stop_pond_fight");
  }
}

event1_under_hut() {
  level.sullivan thread anim_single_solo(level.sullivan, "no_one_standing");
  spawner = GetEnt("event1_hut_collapse_spawner", "targetname");
  spawner.animname = "axis_hut_collapse";
  node = GetNode("event1_gunner_collapse", "targetname");
  level thread maps\mak_anim::spawn_and_play_solo(spawner, "vignette", node, undefined, "death");
}

collapse_guy_gun_remove() {
  wait(3);
  self gun_remove();
}

event1_guy_2_shed() {
  spawner = GetEnt("event1_blown_shed_spawner", "targetname");
  guy = spawn_guy(spawner);
  guy disable_arrivals(true, true);
  guy setCanDamage(false);
  guy.animname = "guy_2_shed";
  node = GetNode("event1_fly2shed", "targetname");
  anim_reach_solo(guy, "vignette", undefined, node);
  playsoundatposition("exp_hut_1_spc", (-9711, -16421, 147));
  exploder(111);
  level thread anim_single_solo(guy, "vignette", undefined, node);
  guy thread maps\mak_anim::death_after_anim(undefined, "ragdoll");
}

event1_near_shed() {
  flag_wait("event1_near_shed");
  level.sullivan thread anim_single_solo(level.sullivan, "watch_flank");
  guy = GetEnt("event1_guy_in_shed", "targetname");
  if(isDefined(guy) && IsAlive(guy)) {
    guy SetGoalEntity(get_closest_player(guy.origin));
  }
}

event1_orange_team_death() {
  guys = get_force_color_guys("allies", "o");
  for(i = 0; i < guys.size; i++) {
    guys[i].grenadeawareness = 0;
  }
  spawner = GetEnt("event1_grenade_enemy", "targetname");
  enemy = spawn_guy(spawner);
  enemy waittill("reached_path_end");
  struct = getstruct("event1_grenade_position", "targetname");
  enemy thread maps\_grenade_toss::force_grenade_toss(struct.origin, undefined, 2);
  count = 0;
  for(i = 0; i < guys.size; i++) {
    if(isDefined(guys[i]) && IsAlive(guys[i])) {
      count++;
    }
  }
  if(count > 0) {
    trigger = GetEnt("event1_orange_death", "targetname");
    while(1) {
      trigger waittill("trigger");
      count = 0;
      for(i = 0; i < guys.size; i++) {
        if(guys[i] IsTouching(trigger)) {
          count++;
        }
      }
      if(count == 2) {
        break;
      }
      wait(0.2);
    }
    for(i = 0; i < guys.size; i++) {
      guys[i] stop_bullet_shield();
      guys[i].health = 100;
    }
    playsoundatposition("exp_barrel_2d", (0, 0, 0));
    exploder(105);
  }
}

event1_corner_explosion() {
  if(flag("event1_corner_hut_destroyed")) {
    return;
  }
  flag_set("event1_corner_hut_destroyed");
  playsoundatposition("exp_hut_corner", (-10392, -15800, 144));
  exploder(108);
  lights = getEntArray("hut2_corner_light", "targetname");
  array_thread(lights, maps\_lights::turn_on);
  wait(0.2);
  level notify("stop_pond_fight");
}

event1_kill_off_enemies() {
  bloody_death_array("event1_guys_behind_hut", "targetname", 1, 3);
  bloody_death_array("event1_svp_enemies", "script_noteworthy", 2, 5);
}

event1_after_beatdown_enemies() {
  flag_wait("event1_before_saving_ryan");
  flag_wait("beatdown_break_apart");
  level.sullivan thread anim_single_solo(level.sullivan, "more_of_them");
  spawners = getEntArray("event1_after_beatdown_enemies", "targetname");
  if(isDefined(spawners) && spawners.size > 0) {
    maps\_spawner::flood_spawner_scripted(spawners);
  }
}

event1_fire_beatdown() {
  flag_wait("event1_guy_2_shed");
  spawner = GetEnt("event1_ally_fire_beatdown", "script_noteworthy");
  ally = spawner stalingradspawn();
  ally set_bullet_shield();
  level.ryan = ally;
  flag_wait("event1_save_ryan");
  ally setCanDamage(false);
  node = GetNode("fire_beatdown_spot1", "targetname");
  ally.animname = "ally_fire_beatdown";
  ally.dontavoidplayer = true;
  ally.goalradius = 32;
  node = GetNode("event1_fire_beatdown_sync", "targetname");
  anim_reach_solo(ally, "vignette1", undefined, node);
  ally.ignoreall = true;
  ally.ignoreme = true;
  spawner = GetEnt("event1_fire_beater", "targetname");
  spawner.animname = "axis_fire_beatdown";
  axis = spawner stalingradspawn();
  axis.dropweapon = false;
  axis thread torch_ai();
  axis maps\mak_anim::remove_gun();
  axis thread print_health();
  axis.grenadeammo = 0;
  axis.targetname = "event1_axis_fire_beatdown";
  axis thread event1_axis_beatdown_death();
  axis playSound("japanese_yell_hut");
  guys[0] = ally;
  guys[1] = axis;
  axis thread maps\mak_anim::death_after_anim(undefined, "ragdoll");
  level thread anim_single(guys, "vignette1", undefined, node);
  ally set_force_color("r");
  ally.ignoreme = false;
  ally.ignoreall = false;
  ally stop_bullet_shield();
  ally setCanDamage(true);
  wait(1);
  level.roebuck anim_single_solo(level.roebuck, "help_ryan");
  if(isDefined(axis) && axis.health > 1) {
    wait(1);
    level.roebuck anim_single_solo(level.roebuck, "save_ryan");
  }
  flag_wait("beatdown_break_apart");
  wait(0.5);
  if(ally.health > 1) {
    level.sullivan anim_single_solo(level.sullivan, "after_ryan_save");
  } else {
    level.roebuck anim_single_solo(level.roebuck, "too_late");
  }
}

event1_axis_beatdown_death() {
  level endon("beatdown_break_apart");
  end_time = GetTime() + 2500;
  while(self.health > 1) {
    self waittill("damage", dmg, attacker, dir, point);
    if(is_mature()) {
      playFX(level._effect["flesh_hit"], point);
    }
    level.beatdown_attacker = attacker;
  }
  if(GetTime() > end_time) {
    return;
  }
  self maps\mak_anim::ragdoll_after_anim();
  wait(0.05);
  self anim_stopanimscripted();
}

event1_hut_collapse() {
  pieces = getEntArray("hut1_pieces", "script_noteworthy");
  if(isDefined(pieces[0])) {
    playsoundatposition("tower_splash_lowpitch", pieces[0].origin);
  }
  parent = undefined;
  for(i = 0; i < pieces.size; i++) {
    if(isDefined(pieces[i].script_string) && pieces[i].script_string == "parent") {
      parent = pieces[i];
    }
    if(isDefined(pieces[i].fx_models)) {
      for(q = 0; q < pieces[i].fx_models.size; q++) {
        if(!isDefined(pieces[i].fx_models[q])) {
          continue;
        }
        if(isDefined(pieces[i].upper)) {
          playsoundatposition("wood_pre_crack", pieces[i].origin);
          if(pieces[i].script_linkto == "hutchunk2_jnt") {
            pieces[i].fx_models[q] Delete();
          }
        }
      }
    }
  }
  level thread maps\_anim::anim_ents(pieces, "collapse", undefined, undefined, parent, "hut1");
  org = getstruct("hut1_collapse_fx1", "targetname");
  big_fx = spawn("script_model", org.origin);
  big_fx setModel("tag_origin");
  big_fx.angles = org.angles;
  big_fx LinkTo(parent);
  playFXOnTag(level._effect["hut1_collapse"], big_fx, "tag_origin");
  parent.big_fx = big_fx;
  parent.targetname = "hut1_parent";
}

event1_boatsquad1_lookat() {
  flag_wait("event1_before_saving_ryan");
  trigger = GetEnt("event1_boatsquad1_lookat", "targetname");
  trigger waittill("trigger");
  flag_set("event1_boatsquad1_moveup");
}

event1_showdown() {
  if(is_german_build()) {
    return;
  }
  spawners = getEntArray("event1_show_down_spawners", "targetname");
  for(i = 0; i < spawners.size; i++) {
    spawners[i].animname = spawners[i].script_string;
    spawners[i] add_spawn_function(::set_targetname_to_noteworthy);
    if(spawners[i].animname == "axis_showdown") {
      spawners[i] add_spawn_function(maps\mak_anim::ragdoll_after_anim);
    } else {
      spawners[i] add_spawn_function(maps\mak_anim::remove_gun);
    }
  }
  node = GetNode("event1_show_down", "targetname");
  maps\mak_anim::spawn_and_play(spawners, "vignette", node);
  ally = GetEnt("ally_showdown", "targetname");
  ally set_force_color("y");
  ally thread replace_on_death();
  ally.ignoreme = false;
  ally.ignoreall = false;
  axis = GetEnt("axis_showdown", "targetname");
  axis thread event1_showdown_damage(ally);
}

event1_showdown_damage(ally) {
  self endon("stop_showdown_damage");
  count = 0;
  for(;;) {
    self waittill("damage", dmg, attacker, dir, point, mod);
    if(IsPlayer(attacker)) {
      if(is_mature()) {
        playFX(level._effect["flesh_hit"], point);
      }
      count += dmg;
      if(count > 100) {
        break;
      }
    }
    self.health = 500;
  }
  if(isDefined(ally) && IsAlive(ally)) {
    ally.saved = true;
    ally thread event1_showdown_color_delay();
    ally anim_stopanimscripted();
    ally Detach(GetWeaponModel(ally.og_weapon), "tag_inhand");
    ally animscripts\shared::placeWeaponOn(ally.og_weapon, "right");
  }
  self anim_stopanimscripted();
}

event1_showdown_color_delay() {
  self disable_ai_color();
  wait(1.5);
  self enable_ai_color();
}

event1_boatsquad1() {
  level thread event1_held_guy();
  guys = getEntArray("event1_boatsquad1", "targetname");
  sorted_guys = [];
  for(i = 0; i < guys.size; i++) {
    guys[i] setCanDamage(false);
    guys[i].animname = guys[i].script_string;
    if(guys[i].animname == "boatsquad1_1") {
      sorted_guys[3] = guys[i];
    } else if(guys[i].animname == "boatsquad1_2") {
      sorted_guys[0] = guys[i];
    } else if(guys[i].animname == "boatsquad1_3") {
      sorted_guys[1] = guys[i];
    } else if(guys[i].animname == "boatsquad1_4") {
      sorted_guys[2] = guys[i];
    }
  }
  assertEx(sorted_guys.size > 0, "YOU SHOULD NOT SEE THIS -- BUGZ!");
  flag_wait("event1_mg_hut");
  autosave_by_name("event1_mg");
  disable_grenades_for_team("allies");
  spawner = GetEnt("event1_lmg_spawner", "targetname");
  mger = spawn_guy(spawner);
  mger setCanDamage(false);
  mger.targetname = "mg_dude";
  level thread event1_mg_dialog();
  level thread event1_mg_target(sorted_guys, mger);
  level thread event1_mger_death(mger);
  level thread event1_boatsquad1_rush_thread(sorted_guys);
  mg = GetEnt("event1_lmg", "script_noteworthy");
  tarp = GetEnt("event1_lmg_curtains", "targetname");
  spawners = getEntArray("event1_lmg_backup", "script_noteworthy");
  maps\_spawner::flood_spawner_scripted(spawners);
  trigger = GetEnt("event2_color_trigger", "targetname");
  level thread event1_killoff_mg_guys(trigger);
  check_trigger = GetEnt("event1_check_axis", "targetname");
  trigger_waittill_dead("event1_lmg_backup", "targetname", check_trigger);
  flag_set("event1_past_mg");
  trigger notify("trigger");
  level thread event2();
}

event1_mg_dialog() {
  level endon("event1_past_mg");
  mg = GetEnt("event1_lmg", "script_noteworthy");
  owner = mg GetTurretOwner();
  while(!isDefined(owner)) {
    owner = mg GetTurretOwner();
    wait(0.05);
  }
  owner KnockBack(false);
  mg SetTurretIgnoreGoals(true);
  wait(0.25);
  level.sullivan thread anim_single_solo(level.sullivan, "take_out_mg");
  wait(2);
  if(isDefined(owner) && IsAlive(owner)) {
    level.sniper redshirt_dialog("cant_get_clear_shot");
    level.sullivan thread anim_single_solo(level.sullivan, "shoot_through_wood");
  }
  dialogs = [];
  dialogs[dialogs.size] = "keep_on_mg";
  dialogs[dialogs.size] = "hit_that_mg";
  owner = undefined;
  has_owner = false;
  num = 0;
  timer = GetTime() + 5000 + RandomInt(3000);
  while(1) {
    wait(0.1);
    while(!isDefined(owner)) {
      if(has_owner) {
        has_owner = false;
        wait(2);
        level.sullivan anim_single_solo(level.sullivan, "no_crew_on_mg");
      }
      owner = mg GetTurretOwner();
      wait(0.05);
    }
    has_owner = true;
    if(GetTime() > timer) {
      timer = GetTime() + 5000 + RandomInt(3000);
      if(num == dialogs.size) {
        num = 0;
      }
      level.sullivan anim_single_solo(level.sullivan, dialogs[num]);
      num++;
    }
  }
}

event1_killoff_mg_guys(trigger) {
  trigger waittill("trigger");
  extra_guys = getEntArray("extra_guys", "targetname");
  for(i = 0; i < extra_guys.size; i++) {
    if(IsAlive(extra_guys[i])) {
      extra_guys[i] thread bloody_death(RandomFloat(3));
    }
  }
}

event1_boatsquad1_rush_thread(sorted_guys) {
  spawners = getEntArray("boatsquad1_extra_spawner", "targetname");
  extra_guys = [];
  extra_guys = spawn_guys(spawners);
  for(i = 0; i < extra_guys.size; i++) {
    extra_guys[i].ignoreall = false;
    extra_guys[i].ignoreme = false;
    extra_guys[i].targetname = "event1_extra_guys";
    extra_guys[i].health = 50;
  }
  node = GetNode("event1_lmg_mowdown", "targetname");
  sorted_guys[0] thread event1_boatsquad1_rush(node);
  wait(1);
  sorted_guys[1] thread event1_boatsquad1_rush(node);
  wait(0.8);
  sorted_guys[2] thread event1_boatsquad1_rush(node);
  wait(0.3);
  sorted_guys[3] thread event1_boatsquad1_rush(node);
}

event1_boatsquad1_rush(node) {
  self endon("death");
  level anim_reach_solo(self, "vignette", undefined, node);
  level thread anim_single_solo(self, "vignette", undefined, node);
  self thread maps\mak_anim::death_after_anim(undefined, "ragdoll");
  wait(0.1);
  self setCanDamage(true);
  tags = [];
  tags[0] = "j_hip_le";
  tags[1] = "j_hip_ri";
  tags[2] = "j_head";
  tags[3] = "j_spine4";
  tags[4] = "j_elbow_le";
  tags[5] = "j_elbow_ri";
  tags[6] = "j_clavicle_le";
  tags[7] = "j_clavicle_ri";
  wait(1 + RandomFloat(1));
  while(1) {
    playFXOnTag(level._effect["flesh_hit"], self, tags[RandomInt(tags.size)]);
    wait(0.1 + RandomFloat(0.5));
  }
}

event1_mger_death(guy) {
  guy.threatbias = -500;
  guy disable_long_death();
  guy waittill("death");
  wait(RandomFloatRange(1, 3));
  mg = GetEnt("event1_lmg", "script_noteworthy");
  backup = getEntArray("event1_lmg_backup", "targetname");
  new_mger = undefined;
  if(backup.size > 0) {
    backup = get_array_of_closest(mg.origin, backup);
    backup = array_removeDead(backup);
    if(backup.size > 3) {
      num = RandomIntRange(1, 4);
      new_mger = backup[num];
    } else {
      new_mger = backup[0];
    }
  }
  if(isDefined(new_mger)) {
    new_mger thread event1_get_on_mg(mg);
    level thread event1_mger_death(new_mger);
  }
}

event1_get_on_mg(mg) {
  node = GetNode(mg.targetname, "target");
  self.goalradius = 16;
  self SetGoalNode(node);
  self waittill("goal");
  self UseTurret(mg);
}

event1_mg_target(guys, mger) {
  org = GetEnt("event1_lmg_target", "script_noteworthy");
  mg = GetEnt("event1_lmg", "script_noteworthy");
  for(i = 0; i < guys.size; i++) {
    while(IsAlive(guys[i]) && guys[i].origin[0] < -10500) {
      org MoveTo(guys[i].origin + (0, 0, 32), 0.1);
      wait(0.1);
    }
  }
  mg = GetEnt("event1_lmg", "script_noteworthy");
  mg notify("stop_burst_fire_unmanned");
  mg.script_shooting = false;
  mg SetMode("auto_ai");
  mger setCanDamage(true);
}

event1_held_guy() {
  if(is_german_build()) {
    return;
  }
  level endon("stop_held_guy_vignette");
  level thread event1_held_guy_dialog();
  flag_wait("event1_held_guy");
  if(!is_mature()) {
    return;
  }
  spawners = getEntArray("event1_held_down_spawners", "targetname");
  for(i = 0; i < spawners.size; i++) {
    spawners[i].animname = spawners[i].script_string;
    if(spawners[i].animname == "ally_held_down") {
      spawners[i] add_spawn_function(maps\mak_anim::death_after_anim);
      spawners[i] add_spawn_function(maps\mak_anim::remove_gun);
    } else if(spawners[i].animname == "axis1_held_down") {
      spawners[i] add_spawn_function(maps\mak_anim::remove_gun);
    }
    spawners[i] add_spawn_function(::set_targetname_to_noteworthy);
  }
  node = GetNode("event1_held_down", "targetname");
  maps\mak_anim::spawn_and_play(spawners, "vignette", node);
}

event1_held_guy_dialog() {
  level endon("event1_held_guy");
  level endon("stop_held_guy_vignette");
  flag_wait("event1_held_guy_dialog");
  sounds = [];
  delays = [];
  sounds[sounds.size] = "Mak1_IGD_116A_PAYE";
  delays[delays.size] = 0.5;
  sounds[sounds.size] = "Mak1_IGD_117A_PAYE";
  delays[delays.size] = 0;
  sounds[sounds.size] = "Mak1_IGD_118A_JAS1";
  delays[delays.size] = 2;
  sounds[sounds.size] = "Mak1_IGD_119A_PAYE";
  delays[delays.size] = 1;
  sounds[sounds.size] = "Mak1_IGD_120A_JAS1";
  delays[delays.size] = 0;
  ent = GetEnt("held_guy_ent", "targetname");
  for(i = 0; i < sounds.size; i++) {
    ent playSound(sounds[i], "sounddone");
    ent waittill("sounddone");
    if(delays[i] > 0) {
      wait(delays[i]);
    }
  }
  sounds = [];
  delays = [];
  sounds[sounds.size] = "Mak1_IGD_116A_PAYE";
  delays[delays.size] = 0.5;
  sounds[sounds.size] = "Mak1_IGD_117A_PAYE";
  delays[delays.size] = 0;
  sounds[sounds.size] = "Mak1_IGD_118A_JAS1";
  delays[delays.size] = 2;
  num_array = [];
  for(i = 0; i < sounds.size; i++) {
    num_array[num_array.size] = i;
  }
  while(1) {
    num_array = array_randomize(num_array);
    for(i = 0; i < num_array.size; i++) {
      wait(5 + RandomFloat(5));
      ent playSound(sounds[num_array[i]], "sounddone");
      ent waittill("sounddone");
    }
  }
}

event2_start() {
  event1_remove_start_ents(true);
  event2_start_allies();
  set_start_position("event2_starts");
  trigger_color_trigger(10);
  level thread event2();
}

event2_beach_start() {
  event1_remove_start_ents(true);
  event2_start_allies();
  set_start_position("event2_lmg_starts");
  trigger_color_trigger(14);
  level thread event2(true);
  wait(0.05);
  trigger = GetEnt("event2_setup_lmg", "targetname");
  trigger notify("trigger");
}

event2_start_allies() {
  scout1 = GetEnt("scout1", "script_noteworthy");
  scout1 disable_replace_on_death();
  scout1 Delete();
  scout2 = GetEnt("scout2", "script_noteworthy");
  scout2 disable_replace_on_death();
  scout2 Delete();
  ally_showdown_spawner = GetEnt("ally_showdown", "script_noteworthy");
  ally_showdown_spawner.origin = (-11598, -15118, 156);
  guy = spawn_guy(ally_showdown_spawner);
  guy add_extra_starting_guy();
  guy set_force_color("y");
  guy thread replace_on_death();
  guys = getEntArray("starting_allies", "targetname");
  for(i = 0; i < guys.size; i++) {
    guys[i].ignoreall = false;
    guys[i].ignoreme = false;
  }
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(RandomInt(2) == 0) {
      players[i] GiveWeapon("type100_smg");
      players[i] GiveMaxAmmo("type100_smg");
    } else {
      players[i] GiveWeapon("type99_rifle");
      players[i] GiveMaxAmmo("type99_rifle");
    }
  }
}

event2(event2_beach_start) {
  battlechatter_off();
  if(!isDefined(event2_beach_start)) {
    event2_beach_start = false;
  }
  if(!event2_beach_start) {
    autosave_by_name("after_village_mg");
    level thread player_speed_within_coords(110, "x", -9900, -6300, "event2_path_last_stop");
    set_objective(1);
    level thread event2_dialog_thread();
  }
  node = GetNode("event2_snare", "targetname");
  branch = getstruct("event2_snare_branch", "targetname");
  dist = Distance(node.origin, branch.origin);
  level.snare_rope_id = CreateRope(branch.origin, node.origin, dist + 10);
  enable_grenades_for_team("allies");
  setmusicstate("PATH");
  level thread event2_setup_mg();
  level thread event2_beach();
  level thread event2_barrels();
  level thread event2_wait_for_sullivan();
  flag_wait("event2_beach");
  flag_wait_or_timeout("event2_beach_advance", 10);
  spawners = getEntArray("event2_axis_spawners2", "targetname");
  maps\_spawner::flood_spawner_scripted(spawners);
  level thread event2_spawn_event3_blockers();
  level thread event2_mg_thread();
  flag_wait_or_timeout("event2_beach_clear", 15);
  blue = get_force_color_guys("allies", "b");
  for(i = 0; i < blue.size; i++) {
    blue[i].goalradius = 384;
  }
  guys = getEntArray("boatsquad2", "targetname");
  for(i = 0; i < guys.size; i++) {
    if(IsAlive(guys[i])) {
      guys[i] thread bloody_death(RandomFloat(5));
    }
  }
  maps\_spawner::kill_spawnerNum(201);
  check_trigger = GetEnt("event2_check_axis", "targetname");
  level thread trigger_waittill_dead("axis", "team", check_trigger, "event2_beach_clear");
  flag_wait_either("event2_beach_clear", "event3_start");
  boatsquad = getEntArray("boatsquad1", "targetname");
  guys = [];
  for(i = 0; i < boatsquad.size; i++) {
    if(IsAlive(boatsquad[i])) {
      boatsquad[i] stop_bullet_shield();
      boatsquad[i] set_force_color("b");
      boatsquad[i] thread replace_on_death();
      guys[guys.size] = boatsquad[i];
    }
  }
  if(!flag("event3_start")) {
    trigger_color_trigger(17);
  }
  level thread event3();
}

event2_wait_for_sullivan() {
  flag_wait("event2_beach_clear");
  bloody_death_array("axis", "team", 5, 10, true);
  check_trigger = GetEnt("event2_check_axis", "targetname");
  trigger_waittill_dead("axis", "team", check_trigger);
  flag_set("event3_unblock");
  wait(0.05);
  blocker = GetEnt("event3_blocker", "targetname");
  blocker Delete();
  guys = getEntArray("event2_allies_group2", "targetname");
  exclude = array_combine(guys, level.heroes);
  closest_ally = get_closest(level.sullivan.origin, "allies", "team", exclude, true);
  closest_ally thread event3_goat_path("event3_redshirt_start");
  level.roebuck thread event3_goat_path("event3_roebuck_start");
  level.sullivan thread event3_goat_path("event3_sullivan_start");
}

event3_goat_path(t_name) {
  self setCanDamage(false);
  self.ignoreall = true;
  self.ignoreme = true;
  self disable_ai_color();
  node = GetNode(t_name, "targetname");
  self thread follow_nodes(node);
  flag_wait("event3_goat_stop3");
  self notify("stop_follow_nodes");
}

event2_mg_thread() {
  timer = GetTime() + 30000;
  mgs = getEntArray("event2_lmg", "script_noteworthy");
  while(1) {
    count = 0;
    for(i = 0; i < mgs.size; i++) {
      owner = mgs[i] GetTurretOwner();
      if(!isDefined(owner) || !IsAI(owner)) {
        count++;
      }
    }
    if(GetTime() > timer) {
      break;
    }
    if(count > 1) {
      break;
    }
    wait(0.25);
  }
  flag_set("event2_flank_mg");
}

event2_banzai() {
  spawners = getEntArray("event2_banzai_spawners", "targetname");
  for(i = 0; i < spawners.size; i++) {
    spawn_guy(spawners[i]);
    wait(RandomFloatRange(1, 1.5));
  }
}

event2_dialog_thread() {
  level endon("before_shrine");
  level thread event2_before_shrine();
  level thread event2_after_shrine();
  level thread event2_top_of_hill();
  level.sullivan anim_single_solo(level.sullivan, "good_work_marines");
  level.sullivan anim_single_solo(level.sullivan, "goat_path_info2");
  wait(2);
  closest_ally = get_closest(level.sullivan.origin, "allies", "team", level.heroes, true);
  closest_ally do_dialogue("creeps_me_out");
  wait(1);
  level.sullivan do_dialogue("home_in_this");
  wait(1);
  level.sullivan do_dialogue("eyes_peeled");
}

event2_stop_held_guy_vignette() {
  trigger = GetEnt("before_shrine", "targetname");
  trigger waittill("trigger");
  spawner = GetEnt("snare_spawner", "targetname");
  guy = spawn_guy(spawner, "snare_guy");
  guy setCanDamage(false);
  level notify("stop_held_guy_vignette");
}

event2_before_shrine() {
  set_all_players_visionset("mak_path", 20);
  if(isDefined(level.ryan) && IsAlive(level.ryan)) {
    level.ryan setCanDamage(true);
    level.ryan set_force_color("r");
    level.ryan disable_ai_color();
    level.ryan bloody_death();
  }
  red = get_force_color_guys("allies", "r");
  yellow = get_force_color_guys("allies", "y");
  green = get_force_color_guys("allies", "g");
  guys = array_combine(red, yellow);
  guys = array_combine(guys, green);
  level thread start_jog(guys, -9500, -5400, "event2_jog_path");
  level thread event2_stop_held_guy_vignette();
  level thread event2_kill_enemyai_before_goatpath();
  nodes = GetNodeArray("before_shrine_nodes", "targetname");
  nodes = sort_nodes_by_script_int(nodes);
  guys = get_array_of_closest(nodes[0].origin, guys);
  path_guys = [];
  exit_node = GetNode("event1_exit", "targetname");
  for(i = 0; i < guys.size; i++) {
    guys[i].dontavoidplayer = true;
    guys[i].goalradius = 32;
    if(isDefined(nodes[i])) {
      if(isDefined(nodes[i].script_string)) {
        if(nodes[i].script_string == "right") {
          guys[i].jog_anim = "jog_right";
        } else if(nodes[i].script_string == "left") {
          guys[i].jog_anim = "jog_left";
        }
      }
      path_guys[path_guys.size] = guys[i];
      guys[i] thread event2_jogger_thread(nodes[i]);
    }
  }
  all = GetAiArray("allies");
  for(i = 0; i < all.size; i++) {
    is_path_guy = false;
    for(q = 0; q < path_guys.size; q++) {
      if(all[i] == path_guys[q]) {
        is_path_guy = true;
        break;
      }
    }
    if(is_path_guy) {
      continue;
    }
    all[i] thread bloody_death(randomfloatrange(0.5, 1.5));
  }
  level event2_before_shrine_waittill(guys);
  PlaySoundatposition("bush_rustle_00", (-7502, -14802.5, 216));
  level notify("before_shrine");
  level.roebuck StopSounds();
  level.roebuck do_dialogue("shhh");
  wait(0.5);
  level thread event2_snare_trap();
  wait(3.5);
  blocker = GetEnt("goat_path_blocker", "targetname");
  blocker Delete();
  level thread event2_banzai();
}

event2_kill_enemyai_before_goatpath() {
  flag_wait("event2_jog_start");
  bloody_death_array("axis", "team", undefined, undefined, false, -9000.0);
}

event2_snare_trap() {
  node = GetNode("event2_snare", "targetname");
  guy = GetEnt("snare_guy", "targetname");
  guy setCanDamage(false);
  guy.ignoreall = true;
  guy.ignoreme = true;
  guy.dontavoidplayer = true;
  guy.nododgemove = true;
  guy pushPlayer(true);
  guy.ignoresuppression = 1;
  guy.grenadeawareness = 0;
  guy anim_generic(guy, "what_is_this");
  level.roebuck thread anim_single_solo(level.roebuck, "check_it_out");
  wait(1);
  guy thread event2_snare_trap_temple_dialogue();
  guy.goalradius = 32;
  guy SetGoalNode(node);
  guy anim_stopanimscripted();
  guy notify("stop_jog_idle");
  guy waittill("goal");
  guy.custom_approachType = undefined;
  guy.custom_approachNumber = undefined;
  guy.custom_exitType = undefined;
  guy.custom_exitNumber = undefined;
  level maps\mak_anim::event2_snare_trap(guy);
  playsoundatposition("snare_trap_yell", guy.origin);
  setmusicstate("BANZAI");
}

event2_snare_trap_temple_dialogue() {
  wait(0.5);
  self animscripts\face::SaySpecificDialogue(undefined, level.scr_sound["generic"]["new_snare_trap_temple"], 1.0, "dialogue_done");
}

event2_jogger_thread(node) {
  self endon("stop_event2_jogger_thread");
  self endon("death");
  self disable_ai_color();
  og_interval = self.interval;
  self.interval = 20;
  if(isDefined(self.animname) && self is_hero()) {
    jog_idle = level.scr_anim["generic"]["jog_idle"][0];
    jog_stop = level.scr_anim["generic"]["jog_stop"];
    jog_start = level.scr_anim["generic"]["jog_start"];
    level.scr_anim[self.animname]["jog_idle"][0] = jog_idle;
    level.scr_anim[self.animname]["jog_stop"] = jog_stop;
    level.scr_anim[self.animname]["jog_start"] = jog_start;
  } else {
    self.animname = "generic";
  }
  self thread follow_nodes(node);
  self waittill("event2_before_shrine");
  wait(0.05);
  og_jog_anim = self.jog_anim;
  if(RandomInt(100) > 50) {
    self.jog_anim = "jog1";
  } else {
    self.jog_anim = "jog2";
  }
  self.jogger_node = self.node;
  delay = undefined;
  if(isDefined(self.jogger_node.script_delay)) {
    delay = self.jogger_node.script_delay;
  }
  self disable_arrivals(false, false);
  self.custom_approachType = "custom_exposed";
  self.custom_approachNumber = 0;
  self.custom_exitType = "custom_exposed";
  self.custom_exitNumber = 0;
  self.custom_exposed_idle = level.scr_anim[self.animname]["jog_idle"][0];
  self waittillmatch("coverArrival", "end");
  self thread anim_loop_solo(self, "jog_idle", undefined, "stop_jog_idle");
  flag_wait("event2_path_stop2");
  if(isDefined(delay)) {
    wait(delay);
  }
  self.custom_stop_idle = undefined;
  self anim_stopanimscripted();
  self notify("stop_jog_idle");
  while(self.origin[0] < -7100) {
    wait(0.1);
  }
  self.custom_approachType = undefined;
  self.custom_approachNumber = undefined;
  self.custom_exitType = undefined;
  self.custom_exitNumber = undefined;
  self.jog_anim = og_jog_anim;
  self.enable_arrivals_on_last_node = true;
  self disable_arrivals(true, true);
  self waittill("follow_nodes_done");
  self.interval = og_interval;
  self enable_ai_color();
}

delay_print_spot() {
  wait(0.05);
  println("**** start = ", self.origin);
}

event2_before_shrine_dialogue() {
  level endon("stop_shrine_dialogue");
  flag_wait("event2_path_stop1");
  closest_ally = get_closest(level.sullivan.origin, "allies", "team", level.heroes, true);
  guys[0] = level.sullivan;
  guys[1] = level.roebuck;
  guys[2] = closest_ally;
  closest_ally2 = get_closest(closest_ally.origin, "allies", "team", guys, true);
  closest_ally do_dialogue("ever_seen_banzai");
  closest_ally2 do_dialogue("a_what");
  closest_ally do_dialogue("a_banzai");
  wait(0.75);
  closest_ally do_dialogue("crazy_tactic");
  flag_set("event2_before_shrine_dialogue");
}

event2_before_shrine_waittill(guys) {
  level endon("stop_before_shrine_waittill");
  wait_for_group_notify(guys, "event2_before_shrine");
}

event2_after_shrine() {
  trigger = GetEnt("event2_after_shrine", "targetname");
  trigger waittill("trigger");
  flag_wait("event2_banzai_dead");
  wait(1.5);
  trigger_color_trigger(14);
  flag_set("event2_after_shrine");
  flag_wait("event2_after_banzai_dialog");
  wait(3);
  level.roebuck anim_single_solo(level.roebuck, "second_team");
}

event2_top_of_hill() {
  trigger = GetEnt("event2_top_of_hill", "targetname");
  trigger waittill("trigger");
  autosave_by_name("top_of_hill");
  level.sullivan anim_single_solo(level.sullivan, "pickup_pace");
  flag_clear("jog_enabled");
}

event2_setup_mg() {
  trigger = GetEnt("event2_setup_lmg", "targetname");
  trigger waittill("trigger");
  setmusicstate("BEACH_FIGHT");
  spawners = getEntArray("event2_lmg_spawner", "targetname");
  mgers = spawn_guys(spawners);
  for(i = 0; i < mgers.size; i++) {
    mgers[i].threadbias = 10;
    mgers[i] disable_long_death();
  }
  mg_targets = getEntArray("event2_lmg_target", "script_noteworthy");
  for(i = 0; i < mg_targets.size; i++) {
    level thread event2_mg_targets(mg_targets[i]);
  }
}

event2_mg_targets(target) {
  mg = GetEnt(target.targetname, "target");
  owner = undefined;
  while(!isDefined(owner)) {
    owner = mg GetTurretOwner();
    wait(0.1);
  }
  mg thread event2_mg_owner_death(owner);
  target1 = getstruct("event2_lmg_spray_target", "targetname");
  target2 = getstruct(target1.target, "targetname");
  diff = target2.origin - target1.origin;
  for(;;) {
    if(!isDefined(mg GetTurretowner()) || owner != mg GetTurretowner()) {
      break;
    }
    if(flag("event2_mg_target_ai")) {
      wait(0.1);
      targets = array_combine(getEntArray("boatsquad1", "targetname"), getEntArray("boatsquad2", "targetname"));
      targets = array_randomize(targets);
      if(targets.size == 0) {
        return;
      }
      for(i = 0; i < targets.size; i++) {
        if(!isDefined(targets[i]) || !IsAlive(targets[i])) {
          continue;
        }
        origin = targets[i].origin;
        burst_time = GetTime() + (2000 + RandomInt(3000));
        while(GetTime() < burst_time) {
          base = 64;
          base_neg = base * -1;
          base_dub = base * 2;
          offset = (base_neg + RandomInt(base_dub), base_neg + RandomInt(base_dub), 32 + (base_neg + RandomInt(base_dub)));
          pos = origin + offset;
          if(DistanceSquared(target.origin, origin) < 64 * 64) {
            time = 0.1;
          } else {
            time = 0.5;
          }
          target MoveTo(pos, time + RandomFloat(time));
          target waittill("movedone");
        }
      }
    } else {
      pos = target1.origin + (RandomFloat(diff[0]), RandomFloat(diff[1]), RandomFloat(diff[2]));
      target MoveTo(pos, 1 + RandomFloat(1), 0.5, 0.5);
      target waittill("movedone");
    }
  }
}

event2_mg_owner_death(owner) {
  while(isDefined(self GetTurretowner()) && owner == self GetTurretowner()) {
    wait(0.1);
  }
  self notify("stop_burst_fire_unmanned");
  self ClearTargetEntity();
}

event2_beach() {
  flag_wait("event2_beach");
  set_objective(1.5);
  level thread event2_spotlight();
  spawner = GetEnt("event2_spawn_to_die", "targetname");
  spawn_guy(spawner);
  flag_clear("jog_enabled");
  allies = GetAiArray("allies");
  level thread ignore_all_timer(allies, 5);
  level thread event2_beach_dialogue();
  wait(0.1);
  spawners = getEntArray("event2_axis_spawners", "targetname");
  maps\_spawner::flood_spawner_scripted(spawners);
  event2_spawner_relocation();
  spawners = getEntArray("event2_spot_light_spawners", "targetname");
  spawn_guys(spawners, undefined, true);
  wait(0.1);
  spawners = getEntArray("event2_boatsquad1", "targetname");
  boatsquad1 = spawn_guys(spawners, "boatsquad1");
  for(i = 0; i < boatsquad1.size; i++) {
    boatsquad1[i] set_bullet_shield();
  }
  level thread event2_beach_grenade(boatsquad1);
  wait(0.1);
  spawners = getEntArray("event2_boatsquad2", "targetname");
  boatsquad2 = spawn_guys(spawners, "boatsquad2");
  for(i = 0; i < boatsquad2.size; i++) {
    boatsquad2[i].NoFriendlyfire = true;
  }
  flag_set("event2_mg_target_ai");
  level thread event2_boatsquad2_raft(boatsquad2);
}

event2_spotlight() {
  light = GetEnt("event2_spot_light", "targetname");
  level thread event2_spot_light_damage(light);
  light endon("death");
  level endon("event2_stop_spotlight");
  light.fx = playFXOnTag(level._effect["spot_light"], light, "tag_fx");
  light.spot_target = GetStruct(light.target, "targetname");
  light.angles = VectorToAngles(light.spot_target.origin - light.origin);
  boat = GetEnt("event2_boatsquad2_raft", "targetname");
  targets = GetStructArray("spotlight_targets", "targetname");
  old_target = targets[0];
  red = get_force_color_guys("allies", "r");
  yellow = get_force_color_guys("allies", "y");
  green = get_force_color_guys("allies", "g");
  blue = get_force_color_guys("allies", "b");
  guys = array_combine(red, yellow);
  guys = array_combine(guys, green);
  guys = array_combine(guys, blue);
  for(;;) {
    if(flag("event2_flank_mg")) {
      time = 0.25;
      players = get_players();
      if(RandomInt(100) > 40 - (10 * (players.size - 1))) {
        current_target = players[RandomInt(players.size)];
      } else {
        guys = array_removeundefined(guys);
        guys = array_removedead(guys);
        if(guys.size == 0) {
          wait(0.2);
          continue;
        }
        current_target = guys[RandomInt(guys.size)];
      }
    } else {
      current_target = targets[RandomInt(targets.size)];
      time = 0.25 + RandomFloat(1);
      if(old_target != current_target) {
        old_target = current_target;
      }
    }
    if(!isDefined(current_target)) {
      wait(0.2);
      continue;
    }
    if(current_target.origin[0] < -4750) {
      wait(0.2);
      continue;
    }
    if(DistanceSquared(current_target.origin, light.origin) < 1500 * 1500) {
      wait(0.2);
      continue;
    }
    if(!isDefined(current_target)) {
      wait(0.2);
      continue;
    }
    if(flag("event2_flank_mg") && IsAlive(current_target)) {
      num = RandomIntRange(8, 16);
      for(i = 0; i < num; i++) {
        if(!isDefined(current_target)) {
          break;
        }
        pos = current_target.origin + (-20 + RandomInt(40), -20 + RandomInt(40), -20 + RandomInt(40));
        light RotateTo(VectorToAngles(pos - light.origin), time, time * 0.25, time * 0.25);
        wait(time);
      }
    } else {
      pos = current_target.origin + (-50 + RandomInt(100), -50 + RandomInt(100), -50 + RandomInt(100));
      light RotateTo(VectorToAngles(pos - light.origin), time, time * 0.25, time * 0.25);
      wait(time);
    }
  }
}

event2_spotter() {
  level endon("event2_stop_spotlight");
  self.targetname = "event2_spotter";
  self waittill("death");
  level notify("event2_stop_spotlight");
}

event2_spot_light_damage(light) {
  light setCanDamage(true);
  for(;;) {
    light waittill("damage", dmg, attacker);
    if(IsPlayer(attacker)) {
      maps\_utility::arcademode_assignpoints("arcademode_score_generic250", attacker);
      break;
    }
  }
  light notify("event2_stop_spotlight");
  dmg_model = spawn("script_model", light.origin);
  dmg_model.angles = light.angles;
  dmg_model setModel("lights_searchlight_guardtower_v2_off");
  flag_set("spotlight_dead");
  spotter = GetEnt("event2_spotter", "targetname");
  if(isDefined(spotter)) {
    spotter.maxSightDistSqrd = 4096 * 4096;
  }
  if(!flag("event2_beach_clear") && !flag("event3_start")) {
    level.roebuck thread anim_single_solo(level.roebuck, "good_shooting");
  }
  light Delete();
  dmg_model playSound("spotlight_break");
  playFX(level._effect["spot_light_death"], dmg_model.origin);
  for(i = 0; i < 5; i++) {
    playFX(level._effect["radio_explode"], dmg_model.origin);
    wait(1 + RandomFloat(3));
  }
}

event2_spawner_relocation() {
  spawners = getEntArray("event2_axis_spawners2", "targetname");
  for(i = 0; i < spawners.size; i++) {
    struct = getstruct(spawners[i].script_noteworthy, "targetname");
    spawners[i].origin = struct.origin;
  }
}

event2_flood_spawner() {
  self endon("death");
  nodes = GetNodeArray("event2_mg_flank_nodes", "targetname");
  node = nodes[RandomInt(nodes.size)];
  if(flag("event2_flank_mg")) {
    wait(0.1);
    self.goalradius = node.radius;
    self SetGoalNode(node);
  } else {
    flag_wait("event2_flank_mg");
    wait(0.25 + RandomFloat(1));
    if(!isDefined(level.mg_flankers)) {
      level.mg_flankers = 0;
    }
    level.mg_flankers++;
    self.goalradius = node.radius;
    self SetGoalNode(node);
  }
}

event2_beach_dialogue() {
  battlechatter_on();
  level.roebuck anim_single_solo(level.roebuck, "theyve_been_spotted");
  wait(2);
  level.sullivan anim_single_solo(level.sullivan, "hold_tight");
  level.roebuck anim_single_solo(level.roebuck, "aint_eyeballed");
  level.sullivan anim_single_solo(level.sullivan, "mg_on_right");
  level.sullivan anim_single_solo(level.sullivan, "go");
  wait(2);
  if(!flag("spotlight_dead")) {
    level.roebuck anim_single_solo(level.roebuck, "take_out_spotlight");
  }
}

event2_beach_grenade(squad) {
  wait(3);
  if(!flag("event2_barrel_exploded")) {
    struct1 = GetStruct("event2_grenade_spawn", "targetname");
    struct2 = GetStruct("event2_grenade_target", "targetname");
    squad[0] MagicGrenade(struct1.origin, struct2.origin);
  }
}

event2_boatsquad2_raft(guys) {
  boat = GetEnt("event2_boatsquad2_raft", "targetname");
  for(i = 0; i < guys.size; i++) {
    guys[i] LinkTo(boat, "tag_origin", (0, 0, 0), (0, 0, 0));
  }
  boat thread anim_loop(guys, "loop", undefined, "exit_boat", boat);
  v_node = GetVehicleNode("event2_boatpath1", "targetname");
  boat AttachPath(v_node);
  boat StartPath();
  boat waittill("reached_end_node");
  boat notify("exit_boat");
  for(i = 0; i < guys.size; i++) {
    guys[i] Unlink();
  }
  anim_single(guys, "exit", undefined, boat);
  flag_set("event2_boat_on_shore");
}

event2_barrels() {
  barrels = getEntArray("event2_barrels", "script_noteworthy");
  for(i = 0; i < barrels.size; i++) {
    level thread event2_barrel_explode(barrels[i]);
  }
  flag_wait("event2_barrel_exploded");
  net = GetEnt("event2_mg_net1", "targetname");
  tags = [];
  tags[tags.size] = "flap06_1";
  tags[tags.size] = "flap02_1";
  tags[tags.size] = "flap04_1";
  tags[tags.size] = "flap11_1";
  fx = [];
  fx[fx.size] = "fire_debris_small";
  fx[fx.size] = "fire_debris_med";
  for(i = 0; i < tags.size; i++) {
    playFXOnTag(level._effect[fx[RandomInt(fx.size)]], net, tags[i]);
  }
  wait(3);
  net StartTanning();
}

event2_barrel_explode(barrel) {
  barrel waittill("exploding");
  flag_set("event2_barrel_exploded");
}

event2_spawn_event3_blockers() {
  wait(0.1);
  yellow = get_force_color_guys("allies", "y");
  if(yellow.size > 2) {
    for(i = 0; i < yellow.size; i++) {
      if(yellow[i] == level.roebuck) {
        continue;
      }
      if(IsSubStr(yellow[i].name, "Lozano")) {
        continue;
      }
      yellow[i] bloody_death(RandomFloat(1));
      wait(1);
    }
  }
  wait(0.1);
  yellow = get_force_color_guys("allies", "y");
  assertex(yellow.size < 3, "Too many yellow-group guys (shouldn't see this)");
  spawners = getEntArray("event3_blocker_spawners", "targetname");
  spawn_guys(spawners);
}

event3_blocker() {
  self.ignoreme = true;
  self.dontavoidplayer = true;
  self set_bullet_shield();
  self.ignoresuppression = 1;
  self.grenadeawareness = 0;
  flag_wait("event3_unblock");
  self.ignoresuppression = 0;
  self.grenadeawareness = 1;
  self.dontavoidplayer = false;
  self stop_bullet_shield();
  self set_force_color("y");
}

event3_start_allies() {
  event2_start_allies();
  spawners = getEntArray("event2_boatsquad1", "targetname");
  boatsquad1 = spawn_guys(spawners, "boatsquad1");
  for(i = 0; i < boatsquad1.size; i++) {
    boatsquad1[i] set_force_color("b");
    boatsquad1[i] thread replace_on_death();
    boatsquad1[i] add_extra_starting_guy();
  }
}

event3_feign_start() {
  battlechatter_off();
  event1_remove_start_ents(true);
  event3_start_allies();
  set_start_position("event3_feign_starts");
  wait(2);
  level thread event3();
  wait(0.05);
  guys = getEntArray("event2_allies_group2", "targetname");
  exclude = array_combine(guys, level.heroes);
  closest_ally = get_closest(level.sullivan.origin, "allies", "team", exclude, true);
  closest_ally thread event3_goat_path("event3_redshirt_start");
  level.roebuck thread event3_goat_path("event3_roebuck_start");
  level.sullivan thread event3_goat_path("event3_sullivan_start");
  flag_set("event3_goat_stop1");
  flag_set("event3_goat_stop2");
}

event3() {
  autosave_by_name("second_beach");
  set_objective(2);
  maps\mak_amb::change_music_state("CREEK");
  red = get_force_color_guys("allies", "r");
  yellow = get_force_color_guys("allies", "y");
  green = get_force_color_guys("allies", "g");
  blue = get_force_color_guys("allies", "b");
  guys = array_combine(red, yellow);
  guys = array_combine(guys, green);
  guys = array_combine(guys, blue);
  battlechatter_off();
  level thread player_speed_within_coords(110, "x", -2558, -1581, "event3_player_ahead");
  level thread start_jog(guys, -2800, -1500, "event3_jog_path", 200);
  level thread event3_player_ahead();
  level thread event3_dialogue();
  level thread event3_feign_death_scene();
  level thread event4();
}

event3_player_ahead() {
  flag_wait("event3_player_ahead");
  flag_clear("jog_enabled");
}

event3_dialogue() {
  if(level.start_point == "event3_feign") {
    return;
  }
  flag_wait("event3_start");
  level thread event2_kill_off_remaining();
  autosave_by_name("end_of_2nd_beach");
  guys = getEntArray("event2_light_guys", "targetname");
  for(i = 0; i < guys.size; i++) {
    if(isDefined(guys[i]) && IsAlive(guys[i])) {
      guys[i] thread bloody_death(RandomFloatRange(0.5, 3));
    }
  }
  level endon("event3_player_ahead");
  level.sullivan do_dialogue("listen_up");
  wait(0.5);
  level.sullivan do_dialogue("quick_clean1");
  wait(0.5);
  level.sullivan do_dialogue("quick_clean2");
  wait(2);
  level.sullivan do_dialogue("stay_sharp");
  wait(1);
}

event2_kill_off_remaining() {
  trigger = GetEnt("event2_check_axis", "targetname");
  ai = GetAiArray("axis");
  for(i = 0; i < ai.size; i++) {
    if(ai[i] IsTouching(trigger)) {
      ai[i] thread bloody_death(RandomFloatRange(2, 5));
    }
  }
}

event3_feign_death_scene() {
  flag_wait("event3_goat_stop2");
  node = GetNode("event3_feign_death_node", "targetname");
  spawners = getEntArray("event3_feign_guys", "targetname");
  axis = spawn_guys(spawners, "feign_enemy");
  officer = undefined;
  for(i = 0; i < axis.size; i++) {
    axis[i].activatecrosshair = false;
    axis[i].ignoreme = true;
    axis[i].ignoreall = true;
    axis[i].dontgetup = false;
    level thread event3_feign_interrupted(axis[i]);
    if(axis[i].script_animname == "feign_officer") {
      axis[i].targetname = "feign_officer";
      axis[i] gun_remove();
      axis[i] Attach("weapon_jap_katana_long", "tag_weapon_right");
      officer = axis[i];
    }
    if(axis[i].animname != "feign_guy1" && axis[i].animname != "feign_guy4") {
      axis[i] thread anim_loop_solo(axis[i], "feign", undefined, "stop_feign", node);
    } else {
      axis[i] thread anim_loop_solo(axis[i], "feign", undefined, "stop_feign");
    }
    axis[i] thread maps\mak_anim::print_tag_pos("tag_inhand", axis[i].animname);
  }
  level thread event3_feign_interrupted_flare();
  flag_wait("event3_goat_stop3");
  autosave_by_name("before_feign");
  trigger_color_trigger(19);
  flag_set("event3_player_ahead");
  flag_set("feign_can_be_interrupted");
  guys = getEntArray("event2_allies_group2", "targetname");
  exclude = array_combine(guys, level.heroes);
  closest_ally = get_closest(node.origin, "allies", "team", exclude, true);
  closest_ally.animname = "feign_redshirt";
  closest_ally setCanDamage(false);
  allies[0] = level.sullivan;
  allies[1] = level.roebuck;
  allies[2] = closest_ally;
  struct = spawnStruct();
  struct.count = 0;
  struct.total = 3;
  for(i = 0; i < allies.size; i++) {
    allies[i] thread event3_anim_reach(node, struct);
  }
  flag_clear("jog_enabled");
  level waittill("event3_anim_reached");
  if(!flag("feign_interrupted")) {
    for(i = 0; i < allies.size; i++) {
      allies[i] thread maps\mak_anim::enable_color_after_anim();
      allies[i].goalradius = 384;
    }
    axis = array_remove(axis, officer);
    officer notify("stop_feign");
    closest_ally.animname = "feign_redshirt";
    level thread event3_double_feign_anim(officer, node, true);
    level thread event3_double_feign_anim(level.sullivan, node);
    level thread event3_double_feign_anim(level.roebuck, node);
    level thread event3_double_feign_anim(closest_ally, node, true);
  } else {
    level thread event3_single_feign2_anim(officer, node, true);
    level thread event3_single_feign2_anim(level.sullivan, node);
    level thread event3_single_feign2_anim(level.roebuck, node);
    level thread event3_single_feign2_anim(closest_ally, node, true);
  }
  wait(0.2);
}

event3_anim_reach(node, struct) {
  anim_reach_solo(self, "feign_in", undefined, node);
  self anim_single_solo(self, "feign_in", undefined, node);
  self.goalradius = 8;
  self SetGoalPos(self.origin);
  struct.count++;
  if(struct.count == struct.total) {
    level notify("event3_anim_reached");
  }
}

event3_double_feign_anim(guy, node, death_after_anim) {
  level thread event3_feign_interrupt_thread(guy);
  guy thread anim_single_solo(guy, "feign_1", undefined, node);
  guy waittill_either("feign_interrupted", "feign_1");
  guy StopAnimScripted();
  if(!isDefined(death_after_anim)) {
    guy.ignoreall = false;
  }
  guy thread anim_single_solo(guy, "feign_2", undefined, node);
  if(guy.team == "axis") {
    guy thread event3_stabber_death();
  }
  if(isDefined(death_after_anim)) {
    guy thread maps\mak_anim::death_after_anim(undefined, "ragdoll");
  }
}

event3_single_feign2_anim(guy, node, death_after_anim) {
  guy anim_reach_solo(guy, "feign_2", undefined, node);
  guy thread anim_single_solo(guy, "feign_2", undefined, node);
  guy.ignoreall = false;
  guy.goalradius = 384;
  guy enable_ai_color();
  if(guy.team == "axis") {
    guy thread event3_stabber_death();
  }
  if(isDefined(death_after_anim)) {
    guy thread maps\mak_anim::death_after_anim(undefined, "ragdoll");
  }
}

event3_stabber_death() {
  wait(2);
  self endon("end");
  self endon("death");
  self thread event3_stabber_death_thread();
  wait(3);
  self notify("finished_feign_ambush_anim");
}

event3_stabber_death_thread() {
  self endon("finished_feign_ambush_anim");
  self.health = 500;
  count = 0;
  for(;;) {
    self waittill("damage", dmg, attacker, dir, point, mod);
    if(IsPlayer(attacker)) {
      count += dmg;
      if(count > 100) {
        break;
      }
    }
    self.health = 500;
  }
  self thread maps\mak_anim::ragdoll_after_anim();
  self anim_stopanimscripted();
}

event3_feign_interrupt_thread(guy) {
  level endon("stop_feign_interrupt");
  guy endon("feign_1");
  level waittill("feign_interrupted");
  guy notify("feign_interrupted");
}

event3_feign_interrupted_flare() {
  level endon("stop_feign_interrupt");
  level waittill("feign_interrupted");
  level thread maps\mak_anim::event3_flare();
}

event3_feign_interrupted(guy) {
  level endon("stop_feign_interrupt");
  guy endon("death");
  og_health = guy.health;
  flag_wait("feign_can_be_interrupted");
  while(IsAlive(guy) && guy.health == og_health) {
    wait(0.05);
  }
  if(guy.script_animname != "feign_officer") {
    guy.dontgetup = true;
    guy.skipDeathAnim = true;
    guy stopanimscripted();
    guy thread bloody_death();
  }
  level notify("feign_interrupted");
  flag_set("feign_interrupted");
}

event3_flare() {
  level thread event3_bloom();
  level maps\_flare::flare_from_targetname("flare1", 1, 2, 1, (0.83, 0.82, 1));
  wait(5);
  level thread maps\_flare::flare_from_targetname("flare2", 1, 2, 1, (0.83, 0.82, 1));
}

event3_bloom() {
  flag_wait("flare_start_setting_sundir");
  VisionSetNaked("mak_flare", 0.3);
  if(NumRemoteClients()) {
    blue = get_force_color_guys("allies", "b");
    for(i = 0; i < blue.size; i++) {
      blue[i] disable_replace_on_death();
    }
    level thread bloody_death_array("allies", "b", 1, 3, true);
  }
  maps\mak_amb::ambush_stuff();
  wait(0.2);
  VisionSetNaked("mak", 2);
}

event4_start() {
  event1_remove_start_ents(true);
  event4_start_allies();
  set_start_position("event4_starts");
  set_start_objective(3);
  level thread event4();
  wait(0.1);
  trigger_color_trigger(23);
  trigger = GetEnt("event4", "targetname");
  trigger notify("trigger");
}

event4_start_allies() {
  event3_start_allies();
}

event4() {
  trigger = GetEnt("event4", "targetname");
  trigger waittill("trigger");
  level thread event4_bypass_initial_enemies();
  event4_initial_enemies();
  level notify("event4_start");
  level anim_single_solo(level.sullivan, "compound_ahead");
  setmusicstate("POST_AMBUSH");
  if(numremoteclients()) {
    SetAiLimit(22);
  }
  autosave_by_name("truck");
  spawners = getEntArray("event4_initial_enemies", "targetname");
  maps\_spawner::flood_spawner_scripted(spawners);
  level thread event4_truck_scene();
}

event4_bypass_initial_enemies() {
  level endon("event4_start");
  trigger = GetEnt("event4_cleanup_event3", "targetname");
  trigger waittill("trigger");
  axis = GetAiArray("axis");
  check_trigger = GetEnt("event4_check_axis", "targetname");
  for(i = 0; i < axis.size; i++) {
    if(axis[i] IsTouching(check_trigger)) {
      axis[i] thread bloody_death(RandomFloat(1));
    }
  }
}

event4_initial_enemies() {
  check_trigger = GetEnt("event4_check_axis", "targetname");
  trigger_waittill_dead("axis", "team", check_trigger);
  trigger_color_trigger(23);
}

event4_truck_scene() {
  level.sullivan disable_ai_color();
  level.roebuck disable_ai_color();
  truck = GetEnt("event4_truck", "targetname");
  node = GetNode("event4_driver_node", "targetname");
  level thread anim_reach_solo(level.roebuck, "undefined", undefined, node);
  node = GetNode("event4_tailgate_node", "targetname");
  level thread event4_truck_dialogue(node);
  anim_reach_solo(level.sullivan, "open_tailgate", undefined, truck);
  level thread event4_roebuck_truck();
  flag_wait("truck_dialogue_intro");
  setbusstate("TRUCK");
  level thread event4_sullivan_truck(truck);
  hint_model = spawn("script_model", truck.origin);
  hint_model.angles = truck.angles;
  hint_model setModel("static_type94_bed_door_obj");
  trigger = GetEnt("event4_truck_trigger", "targetname");
  trigger trigger_on();
  trigger waittill("trigger", other);
  hint_model Delete();
  flag_set("event4_truck_hint");
  trigger Delete();
  other thread event4_player_coop_truck_anim();
  level thread event4_player_truck_anim(other, truck);
  other waittill("player_view_lerped");
  truck maps\mak_anim::play_vehicle_anim("hatch_open");
  truck playSound("truck_roll");
  level notify("truck_rolling");
  flag_set("event4_truck_go");
  flag_wait("roebuck_in_truck");
  level thread event4_truck_go(truck);
  setmusicstate("TRUCK_AMBUSH");
  truck waittill("smash_gate");
}

event4_player_coop_truck_anim() {
  self SetStance("stand");
  self freezecontrols(true);
  self AllowProne(false);
  self Allowcrouch(false);
  self playeranimscriptevent("mak_truck_hatch");
  self waittill("done");
  self freezecontrols(false);
  self AllowProne(true);
  self Allowcrouch(true);
}

event4_player_truck_anim(player, truck) {
  player endon("disconnect");
  PlaySoundatposition("tailgate_open", (0, 0, 0));
  PlaySoundatposition("barrel_hit_knife", (0, 0, 0));
  player SetStance("stand");
  player freezecontrols(true);
  player AllowProne(false);
  player Allowcrouch(false);
  player DisableWeapons();
  player maps\mak_anim::play_viewhands("event4_truck", truck, true, 0.5, 1, 20, 20, 15, 15, false);
  player EnableWeapons();
  player freezecontrols(false);
  player AllowProne(true);
  player Allowcrouch(true);
}

event4_truck_hint() {
  level endon("event4_truck_go");
  wait(6);
  level thread display_hint("truck_hint");
}

event4_hint_check() {
  return flag("event4_truck_hint");
}

event4_sullivan_truck(truck) {
  level endon("event4_truck_go");
  level.sullivan AllowedStances("crouch");
  level.sullivan.a.pose = "crouch";
  level.sullivan anim_reach_solo(level.sullivan, "open_tailgate", undefined, truck);
  level.sullivan anim_single_solo(level.sullivan, "open_tailgate", undefined, truck);
  level.sullivan SetGoalPos(level.sullivan.origin);
  level endon("event4_truck_hint");
  array = [];
  array[array.size] = "open_tailgate_hurry1";
  array[array.size] = "open_tailgate_hurry2";
  delay = 3;
  for(;;) {
    array = array_randomize(array);
    for(i = 0; i < array.size; i++) {
      if(flag("event4_truck_hint")) {
        return;
      }
      wait(delay);
      delay = 4 + RandomFloat(3);
      level.sullivan anim_single_solo(level.sullivan, array[i], undefined, truck);
    }
  }
}

event4_roebuck_truck() {
  truck = GetEnt("event4_truck", "targetname");
  tag = "tag_driver";
  truck anim_reach_solo(level.roebuck, "truck_getin", tag, truck);
  truck thread maps\mak_anim::play_vehicle_anim("getin");
  truck anim_single_solo(level.roebuck, "truck_getin", tag, truck);
  flag_set("roebuck_in_truck");
  truck playSound("truck_start");
  truck thread event4_truck_sounds();
  level.roebuck LinkTo(truck, tag);
  level.roebuck thread anim_loop_solo(level.roebuck, "truck_idle", tag, "jump_out_of_truck", truck);
  truck waittill("jump_out");
  level.roebuck notify("jump_out_of_truck");
  truck thread maps\mak_anim::play_vehicle_anim("getout");
  truck anim_single_solo(level.roebuck, "truck_getout1", tag, truck);
  level.roebuck UnLink();
  level.roebuck anim_single_solo(level.roebuck, "truck_getout2");
  node = Getnode("event4_roebuck_spot1", "targetname");
  level.roebuck.goalradius = 32;
  level.roebuck SetGoalNode(node);
}

event4_truck_sounds() {
  wait(2);
  truck_origin = spawn("script_origin", self.origin);
  truck_origin playLoopSound("truck_idle");
  level waittill("truck_rolling");
  truck_origin StopLoopSound(2);
  wait(0.1);
  truck_origin Delete();
}

event4_truck_go(truck, using_start) {
  println("truck.origin = ", truck.origin);
  println("truck.angles = ", truck.angles);
  level thread maps\_vehicle::gopath(truck);
  truck ent_flag_set("started_on_path");
  spawners = getEntArray("event4_fallback_spawners1", "targetname");
  spawn_guys(spawners, undefined, true);
  truck.animname = "event4_truck";
  truck thread event4_smash_gate();
  truck thread event4_truck_anims();
  level thread event4_fallback();
  level thread event4_sullivan_light_fuel();
  flag_wait("event4_light_fuel");
  fire_ent = undefined;
  if(!isDefined(using_start) || !using_start) {
    fire_ent = spawn("script_model", truck.fuel_trail[0]);
    fire_ent setModel("tag_origin");
    playFXOnTag(level._effect["truck_fuel_spill_fire"], fire_ent, "tag_origin");
    wait(1);
    fire_ent playSound("flame_on");
    offset = (0, 0, 5);
    for(i = 1; i < truck.fuel_trail.size; i++) {
      time = 0.2 + RandomFloat(0.1);
      fire_ent MoveTo(truck.fuel_trail[i] + offset, time);
      wait(time - 0.05);
    }
    level thread event4_tower();
    truck setCanDamage(true);
    RadiusDamage(truck.origin, 500, truck.health + 10, truck.health + 10);
  }
  level thread event4_truck_barrels();
  wait(35);
  if(!isDefined(using_start) || !using_start) {
    if(isDefined(fire_ent)) {
      fire_ent Delete();
    }
  }
}

event4_truck_anims() {
  self maps\mak_anim::play_vehicle_anim("drive_start");
  self thread maps\mak_anim::play_vehicle_animloop("drive_loop", "stop_drive_loop");
  self waittill("reached_end_node");
  self notify("stop_drive_loop");
}

event4_sullivan_light_fuel() {
  level.sullivan anim_single_solo(level.sullivan, "light_the_match");
  level.sullivan thread anim_single_solo(level.sullivan, "event4_move_move");
  level.sullivan AllowedStances("prone", "crouch", "stand");
  wait(2);
  level.sullivan anim_single_solo(level.sullivan, "c_squad");
  wait(1);
  level.sullivan anim_single_solo(level.sullivan, "thats_extraction_point");
}

event4_truck_barrels() {
  barrels = getEntArray("event4_truck_barrels", "targetname");
  for(i = 0; i < barrels.size; i++) {
    barrels[i] thread event4_throw_barrel();
    wait(RandomFloatRange(0.1, 0.5));
  }
}

event4_throw_barrel() {
  time = 6;
  self Unlink();
  power = RandomIntRange(1100, 1500);
  foward = anglesToForward((RandomIntRange(60, 80) * -1, RandomIntRange(30, 120) * -1, 0));
  velocity = foward * power;
  temp_model = spawn("script_model", self.origin);
  temp_model setModel("tag_origin");
  temp_model LinkTo(self);
  playFX(level._effect["barrel_explosion"], self.origin);
  playFXOnTag(level._effect["barrel_trail"], temp_model, "tag_origin");
  self RotateVelocity((RandomIntRange(400, 600), RandomIntRange(800, 1200), 0), 12);
  self MoveGravity(velocity, time);
  wait(time);
  temp_model Delete();
  self Delete();
}

event4_tower() {
  tower = GetEnt("radio_tower1", "targetname");
  tower setModel("anim_makin_radiotower_dest");
  tower.animname = "event4_tower";
  tower SetAnimTree();
  tower anim_single_solo(tower, "intro");
  tower thread anim_loop_solo(tower, "loop", undefined, "stop_tower_loop");
  flag_wait("event4_tower_collapse");
  wait(3);
  tower playSound("tower_collapse");
  level notify("tower_collapse");
  exploder(601);
  tower playSound("exp_barrel");
  tower notify("stop_tower_loop");
  tower anim_single_solo(tower, "outtro");
}

event4_fallback() {
  flag_wait("event4_fallback");
  trigger = GetEnt("event4_fallback_trigger", "targetname");
  trigger notify("trigger");
  spawners = getEntArray("squad_c_spawner", "targetname");
  spawn_guys(spawners, undefined, true);
  cyan_guys = get_force_color_guys("allies", "c");
  for(i = 0; i < cyan_guys.size; i++) {
    cyan_guys[i] set_bullet_shield();
  }
  trigger_color_trigger(25);
  level thread event5();
}

event4_truck_dialogue(node) {
  setmusicstate("POST_AMBUSH");
  wait(3);
  level.sullivan anim_single_solo(level.sullivan, "get_to_truck");
  flag_set("truck_dialogue_intro");
}

event4_smash_gate() {
  self waittill("smash_gate");
  blocker = GetEnt("event4_gate_blocker", "targetname");
  blocker Delete();
  gate1 = GetEnt("compound_gate1", "targetname");
  gate2 = GetEnt("compound_gate2", "targetname");
  d_gate1 = GetEnt("compound_destroyed_gate1", "targetname");
  d_gate2 = GetEnt("compound_destroyed_gate2", "targetname");
  d_gate1 ConnectPaths();
  d_gate2 ConnectPaths();
  gate1_origin = gate1.origin;
  gate1 Delete();
  PlaySoundatposition("imp_fence", gate1_origin);
  gate2 Delete();
  d_gate1 Show();
  d_gate2 Show();
  level thread maps\_anim::anim_ents_solo(d_gate1, "crash", undefined, undefined, d_gate1, "event4_gate1");
  level thread maps\_anim::anim_ents_solo(d_gate2, "crash", undefined, undefined, d_gate2, "event4_gate2");
  self waittill("reached_end_node");
  self playSound("truck_hit_tower");
  playFXOnTag(level._effect["truck_tower_collision"], self, "tag_origin");
  tower = GetEnt("radio_tower1", "targetname");
  tower playSound("tower_explosion");
  setbusstate("RESET");
  tower thread maps\mak_amb::play_tower_creaks();
}

event4_fuel_trail() {
  self endon("reached_end_node");
  self.fuel_trail = [];
  barrel = GetEnt("event4_truck_fuel_barrel", "script_noteworthy");
  spill_ent = spawn("script_model", barrel.origin + (AnglesToUp(barrel.angles) * 45) + (0, -3, -5));
  spill_ent setModel("tag_origin");
  spill_ent.angles = (0, self.angles[1] + 180, 0);
  playFXOnTag(level._effect["truck_fuel_spill"], spill_ent, "tag_origin");
  spill_ent LinkTo(barrel);
  self ent_flag_wait("started_on_path");
  prev_pos = (-10000, 0, 0);
  for(;;) {
    next_pos = barrel.origin + (AnglesToUp(barrel.angles) * 60);
    if(DistanceSquared(next_pos, prev_pos) > 80 * 80) {
      prev_pos = next_pos;
      trace = bulletTrace(next_pos, next_pos + (0, 0, -1000), false, undefined);
      self.fuel_trail[self.fuel_trail.size] = trace["position"];
    }
    wait(0.05);
  }
}

print_fuel_point() {
  self endon("death");
  player = get_host();
  while(1) {
    wait(0.05);
    forward = self.origin + (anglesToForward(self.angles) * 5);
    line(self.origin, forward);
    line(self.origin, player.origin);
  }
}

event5_start() {
  event1_remove_start_ents(true);
  wait(0.1);
  trigger = GetEnt("color_trigger24", "script_noteworthy");
  trigger Delete();
  truck = GetEnt("event4_truck", "targetname");
  level thread event4_truck_go(truck, true);
  wait(8);
  event5_start_allies();
  trigger_color_trigger(24);
  set_start_position("event5_starts");
  set_start_objective(3);
  wait(1);
  trigger_color_trigger(24);
  wait(1);
  trigger_color_trigger(25);
}

event5_start_allies() {
  event4_start_allies();
}

event5() {
  level.player_seek_timer = 20;
  event5_setup_respawner2();
  respawner("event6_respawner1", "targetname", 0.2, 1.5, 5);
  respawner("event6_respawner2", "targetname", 0.2, 0.5, 6);
  respawner("event6_respawner3", "targetname", 0.2, 1.5, 10);
  node = GetNode("event5_sullivan_spot1", "targetname");
  level.sullivan disable_ai_color();
  level.sullivan anim_reach_solo(level.sullivan, "plant_charges", undefined, node);
  level thread event4_sullivan_roebuck_dialog(node);
  level.sullivan anim_single_solo(level.sullivan, "plant_charges", undefined, node);
  level thread event5_clear_out_camp();
  set_objective(3);
  array = event5_split_up();
  level thread event5_plant_charges(array["guys_charge1"], "event5_plant_charge1");
  level thread event5_plant_charges(array["guys_charge2"], "event5_plant_charge2");
  level thread event5_roebuck_charge(array["redshirt"]);
  bloody_death_array("allies", "b", 3, 10);
  flag_wait("event4_fallback");
  wait(randomintrange(20, 40));
  level.respawner_controls["event6_respawner1"] notify("stop_respawning");
  wait(randomintrange(5, 10));
  level.respawner_controls["event6_respawner2"] notify("stop_respawning");
  wait(randomintrange(5, 10));
  level.respawner_controls["event6_respawner3"] notify("stop_respawning");
  flag_wait("event5_charge_set");
  flag_wait("event5_player_charge_set");
  respawner("event6_respawner1", "targetname", 0.2, 0.3, 10);
  respawner("event6_respawner3", "targetname", 0.1, 0.2, 10);
}

event4_sullivan_roebuck_dialog(node) {
  if(!flag("event5_player_charge_set")) {
    level.sullivan anim_single_solo(level.sullivan, "plant_charges_now", undefined, node);
  }
  wait(1);
  level.roebuck anim_single_solo(level.roebuck, "miller_back_me_up");
  wait(0.5);
  level.roebuck anim_single_solo(level.roebuck, "cmon_lets_go");
  while(!flag("event5_bunker_door")) {
    wait(randomintrange(12, 15));
    which_line = randomintrange(1, 4);
    if(which_line == 1) {
      level.roebuck anim_single_solo(level.roebuck, "need_to_cover");
    } else {
      level.roebuck anim_single_solo(level.roebuck, "get_back_here");
    }
  }
}

event5_clear_out_camp() {
  wait(2);
  level.sullivan anim_single_solo(level.sullivan, "clear_out_camp");
  level.sullivan enable_ai_color();
}

event5_setup_respawner2() {
  spawners = getEntArray("event6_respawner2", "targetname");
  for(i = 0; i < spawners.size; i++) {
    spawners[i].og_target = spawners[i].target;
    if(isDefined(spawners[i].script_string)) {
      spawners[i].script_threatbiasgroup = "event5_bunker_axis";
      spawners[i].target = spawners[i].script_string;
    }
  }
}

event5_reset_respawner2() {
  spawners = getEntArray("event6_respawner2", "targetname");
  for(i = 0; i < spawners.size; i++) {
    spawners[i].script_threatbiasgroup = undefined;
    spawners[i].target = spawners[i].og_target;
  }
}

event5_split_up() {
  heroes = [];
  heroes = level.heroes;
  bomb_planter_group1 = [];
  node = GetNode("event5_plant_charge1", "targetname");
  guy = get_closest(node.origin, "allies", "team", heroes, true);
  heroes[heroes.size] = guy;
  bomb_planter_group1[bomb_planter_group1.size] = guy;
  guy set_bullet_shield();
  guy = get_closest(node.origin, "allies", "team", heroes, true);
  heroes[heroes.size] = guy;
  bomb_planter_group1[bomb_planter_group1.size] = guy;
  guy set_bullet_shield();
  bomb_planter_group2 = [];
  node = GetNode("event5_plant_charge1", "targetname");
  guy = get_closest(node.origin, "allies", "team", heroes, true);
  heroes[heroes.size] = guy;
  bomb_planter_group2[bomb_planter_group2.size] = guy;
  guy set_bullet_shield();
  guy = get_closest(node.origin, "allies", "team", heroes, true);
  heroes[heroes.size] = guy;
  bomb_planter_group2[bomb_planter_group2.size] = guy;
  guy thread set_bullet_shield();
  guy = get_closest(level.roebuck.origin, "allies", "team", heroes, true);
  redshirt = guy;
  redshirt set_bullet_shield();
  array = [];
  array["guys_charge1"] = bomb_planter_group1;
  array["guys_charge2"] = bomb_planter_group2;
  array["redshirt"] = redshirt;
  return array;
}

event5_plant_charges(guys, node_name) {
  node = GetNode(node_name, "targetname");
  for(i = 0; i < guys.size; i++) {
    guys[i] disable_ai_color();
    guys[i] thread maps\mak_anim::follow_path(node);
    wait(RandomFloatRange(0.5, 1.5));
  }
  guys[0] waittill("done_following_path");
  wait(5);
  for(i = 0; i < guys.size; i++) {
    if(isDefined(guys[i]) && IsAlive(guys[i])) {
      guys[i] enable_ai_color();
    }
  }
}

event5_roebuck_charge(redshirt) {
  flag_set("event5_plant_charge");
  level.roebuck disable_ai_color();
  redshirt disable_ai_color();
  level.roebuck.redshirt_support = redshirt;
  node = GetNode("event5_roebuck_door_node", "targetname");
  level.roebuck thread event5_roebuck_charge_movment(node);
  node = GetNode("event5_redshirt_door_node", "targetname");
  redshirt thread event5_roebuck_charge_movment(node);
  event5_bunker_door(redshirt);
  level.roebuck.ignoreme = false;
  redshirt.ignoreme = false;
  node = GetNode("event5_redshirt_support_node", "targetname");
  redshirt SetGoalNode(node);
  autosave_by_name("plant_charge");
  level thread event6();
  player_plant = 1;
  guys = get_players();
  guys[guys.size] = redshirt;
  guys[guys.size] = level.roebuck;
  for(i = 0; i < guys.size; i++) {
    guys[i] SetThreatBiasGroup("event5_bunker_allies");
  }
  level thread anim_single_solo(level.roebuck, "player_plant_charges");
  node = GetNode("event5_roebuck_charge_node", "targetname");
  anim_reach_solo(level.roebuck, "plant_charge_intro", undefined, node);
  anim_single_solo(level.roebuck, "plant_charge_intro", undefined, node);
  level thread event5_roebuck_plant_charge_timer();
  level thread anim_loop_solo(level.roebuck, "plant_charge_loop", undefined, "event5_charge_set", node);
  level thread event5_roebuck_charge_dialogue();
  flag_wait("event5_charge_set");
  flag_wait("event5_player_charge_set");
  event5_roebuck_post_charge_dialogue();
  set_objective(4);
  guys = get_players();
  guys[guys.size] = redshirt;
  guys[guys.size] = level.sullivan;
  for(i = 0; i < guys.size; i++) {
    if(!isDefined(guys[i]) || !IsAlive(guys[i])) {
      continue;
    }
    if(IsPlayer(guys[i])) {
      guys[i] SetThreatBiasGroup("players");
    } else {
      guys[i] SetThreatBiasGroup("allies");
    }
  }
  node = GetNode("event6_redshirt_startnode", "targetname");
  redshirt thread follow_nodes(node);
  wait(3);
  anim_single_solo_animname(level.roebuck, "stay_with_me", undefined, undefined, undefined, "roebuck");
  wait(2);
  anim_single_solo_animname(level.roebuck, "all_around_us", undefined, undefined, undefined, "roebuck");
}

event5_roebuck_post_charge_dialogue() {
  level.roebuck anim_single_solo_animname(level.roebuck, "extraction_point", undefined, undefined, undefined, "roebuck");
  level.roebuck anim_single_solo_animname(level.roebuck, "jerry_rig_charges", undefined, undefined, undefined, "roebuck");
  wait(3);
  level thread repeat_dialog(level.roebuck, "get_to_boats", 5, 3, 5, "outtro_start", "roebuck");
}

event5_roebuck_charge_dialogue() {
  wait(4.2);
  level.roebuck animscripts\face::SaySpecificDialogue(undefined, "Mak1_IGD_208A_ROEB", 1.0, "dialogue_done");
}

event5_roebuck_charge_movment(node) {
  level endon("event5_bunker_door");
  self.goalradius = 32;
  self.ignoreme = true;
  self follow_nodes(node);
  self.ignoreme = false;
  self.ignoreall = false;
}

event5_bunker_door(redshirt) {
  trigger = GetEnt("event5_bunker_door_scene", "targetname");
  trigger waittill("trigger");
  flag_set("event5_bunker_door");
  redshirt.og_animname = redshirt.animname;
  redshirt.animname = "bunkerdoor_redshirt";
  guys = [];
  guys[guys.size] = level.roebuck;
  guys[guys.size] = redshirt;
  door = GetEnt("bunker_door", "targetname");
  anim_pos = spawnStruct();
  anim_pos.origin = door.origin;
  anim_pos.angles = (0, -90, 0);
  door playSound("door_squeak_open");
  for(i = 0; i < guys.size; i++) {
    guys[i].ignoreall = true;
    guys[i].ignoreme = true;
  }
  anim_reach(guys, "bunkerdoor", undefined, anim_pos);
  spawner = GetEnt("event5_bunkerdoor_spawner", "targetname");
  guy = spawner stalingradspawn();
  if(!isDefined(guy)) {
    guy = event5_bunker_guy_spawn();
  }
  guy.animname = "bunkerdoor_japanese";
  guys[guys.size] = guy;
  guy gun_switchto(guy.sidearm, "right");
  playsoundatposition("door_guy_yell", guy.origin);
  guy thread maps\mak_anim::death_after_anim(undefined, "no_deathanim");
  door_blocker = getent("bunker_door_clip", "targetname");
  door_blocker ConnectPaths();
  door_blocker delete();
  level thread anim_ents_solo(door, "open", undefined, undefined, anim_pos, "event5_bunkerdoor");
  anim_single(guys, "bunkerdoor", undefined, anim_pos);
  level notify("bunkerdoor_done");
  for(i = 0; i < guys.size; i++) {
    guys[i].ignoreme = false;
    guys[i].ignoreall = false;
  }
  level.roebuck thread anim_single_solo(level.roebuck, "cover_door");
  if(isDefined(redshirt) && IsAlive(redshirt)) {
    redshirt.animname = redshirt.og_animname;
  }
  setmusicstate("BOMB_IS_ARMING");
}

event5_bunker_guy_spawn() {
  player = get_closest_player(level.roebuck.origin);
  ai_axis = GetAiArray("axis");
  guy = getFarthest(player.origin, ai_axis);
  while(!isDefined(guy) || !isalive(guy)) {
    guy = getFarthest(player.origin, ai_axis);
  }
  if(isDefined(guy.script_goalvolume)) {
    guy.script_goalvolume = "";
  }
  guy.targetname = "event5_bunkerdoor_guy";
  return guy;
}

event5_drone_thread() {
  structs = GetStructArray("event5_drone_wave1", "targetname");
  min_delay = 0.3;
  max_delay = 0.7;
  level.max_drones["axis"] = 20;
  for(;;) {
    structs = array_randomize(structs);
    for(i = 0; i < structs.size; i++) {
      while(level.drones["axis"].lastindex > level.max_drones["axis"]) {
        wait(0.1);
      }
      structs[i] thread maps\_drones::drone_spawngroup(structs[i].targeted, true, 3 + RandomInt(2), false, "axis");
      wait(RandomFloatRange(min_delay, max_delay));
    }
  }
}

event5_roebuck_plant_charge_timer() {
  flag_set("roebuck_event5_planting_charges");
  wait(4);
  flag_set("event5_charge_set");
}

event5_start_respawner() {
  respawner("event6_respawner2", "targetname", 0.2, 0.5, 15);
}

event6_outtro_start() {
  event1_remove_start_ents(true);
  event6_start_allies();
  trigger_color_trigger(26);
  wait(0.1);
  trigger = GetEnt("color_trigger24", "script_noteworthy");
  trigger Delete();
  truck = GetEnt("event4_truck", "targetname");
  level thread event4_truck_go(truck, true);
  flag_wait("event4_light_fuel");
  wait(5);
  set_start_position("event6_outtro_starts");
  set_start_objective(4);
  level.event6_boat1 = GetEnt("event6_boat1", "targetname");
  level.event6_boat1.boaters = 0;
  level.event6_boat1.enter_node = GetNode("boat1_enter", "targetname");
  level.event6_boat2 = GetEnt("event6_boat2", "targetname");
  level.event6_boat2.boaters = 0;
  level.event6_boat2.enter_node = GetNode("boat2_enter", "targetname");
  node = GetNode("event6_sullivan_spot3", "targetname");
  level.sullivan SetGoalNode(node);
  level.sullivan waittill("goal");
  flag_set("sullivan_outtro_ready");
  level.event6_boat1 = GetEnt("event6_boat1", "targetname");
  level.event6_boat1.boaters = 0;
  level.event6_boat1.enter_node = GetNode("boat1_enter", "targetname");
  level.event6_boat1 thread event6_boat_ride();
  level.event6_boat2 = GetEnt("event6_boat2", "targetname");
  level.event6_boat2.boaters = 0;
  level.event6_boat2.enter_node = GetNode("boat2_enter", "targetname");
  level.event6_boat2 thread event6_boat_ride();
  level thread event6_outtro();
}

event6_start_allies() {
  event5_start_allies();
}

event6() {
  level.event6_boat1 = GetEnt("event6_boat1", "targetname");
  level.event6_boat1.boaters = 0;
  level.event6_boat1.enter_node = GetNode("boat1_enter", "targetname");
  level.event6_boat1 thread event6_boat_ride();
  level.event6_boat2 = GetEnt("event6_boat2", "targetname");
  level.event6_boat2.boaters = 0;
  level.event6_boat2.enter_node = GetNode("boat2_enter", "targetname");
  level.event6_boat2 thread event6_boat_ride();
  level thread event5_sullivan_position();
  level.roebuck thread event6_navigate("event6_roebuck_startnode");
  flag_wait("event5_player_charge_set");
  level thread maps\mak_amb::music_switch_delay(3, "BOMB_IS_ARMED");
  level thread event6_exit_trigger_think();
  trigger_color_trigger(26);
  level thread event6_outtro();
}

event5_sullivan_position() {
  node = GetNode("event6_sullivan_spot2", "targetname");
  level.sullivan disable_ai_color();
  level.sullivan.goalradius = 64;
  level.sullivan SetGoalNode(node);
}

event6_reset_ignoreme() {
  self endon("death");
  self endon("player_seeking");
  if(RandomInt(100) > 30) {
    self.ignoreme = true;
    self.goalradius = 128;
    self waittill("reached_path_end");
    self.ignoreme = false;
  } else {
    self.ignoreme = true;
    wait(4);
    self.ignoreme = false;
  }
}

event6_exit_trigger_think() {
  boaters = level.heroes;
  if(isDefined(level.roebuck.redshirt_support) && IsAlive(level.roebuck.redshirt_support)) {
    boaters[boaters.size] = level.roebuck.redshirt_support;
  }
  trigger = GetEnt("event6_exit2", "script_noteworthy");
  while(1) {
    trigger waittill("trigger", other);
    if(isDefined(trigger.script_noteworthy)) {
      flag_set(trigger.script_noteworthy);
      if(trigger.script_noteworthy == "event6_exit2") {
        level.roebuck.redshirt_support stop_bullet_shield();
        level thread event6_sullivan_to_boats();
        maps\_colors::kill_color_replacements();
        respawner("event6_hill_respawners", "targetname", 0.2, 1.5, 5);
        trigger_color_trigger(27);
      } else if(trigger.script_noteworthy == "event6_exit3") {
        flag_set("event4_tower_collapse");
      }
    }
    if(!isDefined(trigger.target)) {
      break;
    }
    trigger = GetEnt(trigger.target, "targetname");
  }
}

event6_mg_manned(mg) {
  mg waittill("manned");
  iprintln("LMG!!! GET THE HELL OUTTA HERE!!!");
}

event6_sullivan_to_boats() {
  level.sullivan anim_single_solo(level.sullivan, "get_to_boats", undefined, level.sullivan.node);
  level.sullivan.ignoreall = true;
  node = GetNode("event6_sullivan_spot3", "targetname");
  level.sullivan thread anim_single_solo(level.sullivan, "get_to_boats_b");
  level.sullivan thread anim_reach_solo(level.sullivan, "undefined", undefined, node);
  level thread repeat_dialog(level.sullivan, "get_to_boats", 7, 3, 5, "outtro_start");
  level.sullivan.grenadeawareness = 0;
  level.sullivan.ignoreme = true;
  level.sullivan waittill("anim_reach_complete");
  level.sullivan.ignoreall = false;
  flag_set("sullivan_outtro_ready");
}

event6_navigate(t_name) {
  self set_bullet_shield();
  self.ignoresuppression = 1;
  self.grenadeawareness = 0;
  flag_wait("event5_charge_set");
  node = GetNode("event5_roebuck_charge_node", "targetname");
  anim_single_solo(level.roebuck, "plant_charge_outro", undefined, node);
  node = GetNode("event5_roebuck_support_node", "targetname");
  level.roebuck SetGoalNode(node);
  level anim_single_solo(level.roebuck, "plant_charge_outro2");
  flag_wait("event5_player_charge_set");
  self thread event6_get_to_boat();
  flag_wait("roebuck_dialogue_cmon_time");
  level.roebuck do_dialogue("cmon");
  wait(2.7);
  level.roebuck do_dialogue("you_are_gonna_be_ok");
}

event6_get_to_boat() {
  self set_bullet_shield();
  if(isDefined(self.assigned_to_boat)) {
    println("Already assigned to boat");
    return;
  }
  self.assigned_to_boat = true;
  boat = undefined;
  is_sullivan = false;
  if(isDefined(self.script_noteworthy)) {
    if(self == level.roebuck) {
      boat = level.event6_boat1;
    } else if(self == level.sullivan) {
      is_sullivan = true;
      boat = level.event6_boat1;
    } else if(self == level.sniper) {
      boat = level.event6_boat2;
    }
  }
  if(!isDefined(boat)) {
    boat = level.event6_boat2;
  }
  boat.boaters++;
  node = boat.enter_node;
  if(boat.boaters > 4) {
    println("Too many boaters, aborting...");
    return;
  }
  self.ignoreall = true;
  self setCanDamage(false);
  self.goalradius = 64;
  self.ignoresuppression = 1;
  self.grenadeawareness = 0;
  self disable_arrivals(true, true);
  if(!is_sullivan) {
    self.animname = "boat_guy1";
  }
  anim_reach_solo(self, "undefined", undefined, node);
  if(!isDefined(boat.rider_count)) {
    boat.rider_count = 0;
  }
  boat.rider_count++;
  if(!is_sullivan) {
    self.animname = "boat_guy" + boat.rider_count;
  }
  anim_reach_solo(self, "boat_getin", undefined, boat);
  if(self == level.sullivan) {
    flag_set("roebuck_dialogue_cmon_time");
  }
  if(self == level.sullivan) {
    self thread event6_get_to_boat_sullivan(boat);
  }
  else {
    anim_single_solo(self, "boat_getin", undefined, boat);
  }
  if(self == level.roebuck) {
    flag_set("roebuck_in_boat");
  }
  if(!isDefined(boat.rider_on_count)) {
    boat.rider_on_count = 0;
  }
  boat.rider_on_count++;
  self LinkTo(boat, "tag_origin", (0, 0, 0), (0, 0, 0));
  if(self != level.sullivan) {
    level thread anim_loop_solo(self, "boat_underfire", undefined, "stop_boat_underfire", boat);
  }
  if(boat == level.event6_boat1) {
    if(is_sullivan) {
      flag_wait("sullivan_boat_in");
      flag_wait("roebuck_in_boat");
      flag_set("event6_boat1_ready");
    }
  } else {
    if(boat.rider_on_count == 4) {
      flag_set("event6_boat2_ready");
    }
    flag_wait("event6_boat2_ready");
  }
  flag_wait("event6_boat1_ready");
  self notify("on_boat");
  if(self == level.roebuck) {
    self thread event6_get_to_boat_roebuck(boat);
  } else if(self != level.sullivan) {
    level waittill("stop_boat_underfire");
    anim_single_solo(self, "boat_reaction", undefined, boat);
    level thread anim_loop_solo(self, "boat_calm", undefined, "never", boat);
  }
}

event6_get_to_boat_roebuck(boat) {
  self.animname = "roebuck";
  anim_single_solo(self, "outtro_end", undefined, boat);
}

event6_get_to_boat_sullivan(boat) {
  self.animname = "sullivan";
  anim_single_solo(self, "boat_getin", undefined, boat);
}

event6_outtro() {
  players = get_players();
  if(players.size > 1) {
    flag_wait("sullivan_outtro_ready");
  }
  trigger = GetEnt("event6_ambush", "targetname");
  trigger waittill("trigger");
  level.enable_cover_warning = false;
  setbusstate("ATTACKED");
  setmusicstate("ATTACKED");
  playsoundatposition("rocket_dirt_scripted", (0, 0, 0));
  playsoundatposition("dew", (0, 0, 0));
  playsoundatposition("player_scream_cool", (0, 0, 0));
  playsoundatposition("Mak1_OUT_300a_SULL", (0, 0, 0));
  level notify("outtro_start");
  level.sniper thread event6_get_to_boat();
  level thread event6_get_ai_on_boats();
  spawner = GetEnt("outtro_spawner", "targetname");
  guy = spawner stalingradspawn();
  if(!isDefined(guy)) {
    guy = event5_outtro_guy_spawn();
  }
  guy.animname = "outtro_enemy";
  guy.targetname = "outtro_enemy_ai";
  guy gun_remove();
  guy Attach("weapon_jap_katana_long", "tag_weapon_right");
  level thread event6_outtro_effects();
  level thread event6_stop_laststand();
  level thread event6_guys_to_boats();
  players = get_players();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    level.players_part1_done = 0;
    player thread event6_outtro_player(player);
  }
  level waittill("part1_done");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    player thread event6_outtro_player_part2(player, i);
  }
}

event6_outtro_player(player) {
  player EnableInvulnerability();
  player Hide();
  if(player maps\_laststand::player_is_in_laststand()) {
    player RevivePlayer();
  }
  player StartCameraTween(0.5);
  node = GetNode("event6_ambush_node", "targetname");
  event6_player_outtro(player, node);
  player StartCameraTween(0.5);
  setsaveddvar("ai_friendlySuppression", "0");
  level.players_part1_done++;
  if(level.players_part1_done == get_players().size) {
    level notify("part1_done");
  }
}

event6_outtro_player_part2(player, i) {
  level.sullivan.ignoreSuppression = true;
  player PlayerLinkTo(level.sullivan, "tag_sync", 0, 30, 30, 30, 30, true);
  level thread maps\mak_amb::play_dragging_sound();
  level thread maps\mak_amb::play_shock_loop_manual();
  flag_wait("sullivan_at_boat");
  level notify("IN_BOAT");
  player StartCameraTween(0.5);
  player Unlink();
  player thread maps\mak_anim::play_viewhands("outtro2", level.event6_boat1, true, 1, 1, 15, 15, 10, 10, false, undefined);
  player waittill("player_view_lerped");
  if(i == 0) {
    level.sullivan thread event6_get_to_boat();
  }
  player waittill("outtro2_viewhands_anim_done");
  player StartCameraTween(0.6);
  player PlayerLinkTo(level.event6_boat1);
  player SetStance("crouch");
  player AllowProne(false);
  player AllowCrouch(true);
  player AllowStand(false);
  if(i == 0) {
    flag_set("player_in_boat");
  }
  setsaveddvar("ai_friendlySuppression", "1");
  if(numremoteclients()) {
    ResetAILimit();
  }
}

event6_outtro_effects() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] thread event6_outtro_effects_internal();
    players[i] thread event6_outtro_sounds();
  }
}

event6_outtro_effects_internal() {
  playFX(level._effect["rocket_explode"], (3088, -15120, 88.9));
  playsoundatposition("rocket_dirt_scripted", (0, 0, 0));
  PlayRumbleOnPosition("explosion_generic", self.origin);
  self StopShellShock();
  wait(0.05);
  self shellshock("explosion_mak", randomfloatrange(2, 3));
}

event6_outtro_sounds() {
  while(!(flag("player_in_boat"))) {
    self playSound("breathing_hurt");
    wait(1);
    self playSound("breathing_heartbeat");
  }
  for(i = 0; i < 5; i++) {
    self playSound("breathing_better");
    wait(1);
  }
}

event5_outtro_guy_spawn() {
  player = get_closest_player(level.sullivan.origin);
  ai_axis = GetAiArray("axis");
  guy = getFarthest(player.origin, ai_axis);
  while(!isDefined(guy) || !isalive(guy)) {
    guy = getFarthest(player.origin, ai_axis);
  }
  if(isDefined(guy.script_goalvolume)) {
    guy.script_goalvolume = "";
  }
  guy.targetname = "outtro_spawner";
  return guy;
}

event6_outtro_playerspectate_think(player) {
  players = get_players();
  if(players.size > 1) {
    for(i = 0; i < players.size; i++) {
      players[i] thread event6_outtro_player_warp(player);
    }
  }
}

event6_outtro_player_warp(player) {
  self endon("disconnect");
  self endon("death");
  if(isDefined(self) && isalive(self)) {
    if(self != player) {
      self hide();
      self notify("stop damage hud");
      self disableWeapons();
      self freezecontrols(true);
      self EnableInvulnerability();
      level.otherPlayersSpectate = true;
      level.otherPlayersSpectateClient = player;
      self thread maps\_callbackglobal::spawnSpectator();
    }
  }
}

event6_stop_laststand() {
  level.no_laststandmissionfail = false;
  level.playerlaststand_func = ::event6_no_death_last_stand;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(players[i] maps\_laststand::player_is_in_laststand()) {
      players[i] event6_no_death_last_stand();
    }
  }
}

event6_no_death_last_stand() {
  self thread event6_no_death_last_stand_internal();
}

event6_no_death_last_stand_internal() {
  self setCanDamage(false);
  self.bleedout_time = 999999;
}

event6_get_ai_on_boats() {
  excluders = [];
  excluders[excluders.size] = level.sullivan;
  excluders[excluders.size] = level.roebuck;
  excluders[excluders.size] = level.sniper;
  for(i = 0; i < 5; i++) {
    wait(1);
    guy = get_closest(level.event6_boat2.origin, "allies", "team", excluders, true);
    if(!isDefined(guy)) {
      continue;
    }
    excluders[excluders.size] = guy;
    guy thread event6_get_to_boat();
  }
}

event6_outtro_enemy() {
  guy = GetEnt("outtro_enemy_ai", "targetname");
  node = GetNode("event6_ambush_node", "targetname");
  level thread anim_single_solo(guy, "ambush", undefined, node);
  guy thread maps\mak_anim::death_after_anim(undefined, "ragdoll", "start_ragdoll");
}

event6_player_outtro(player, node) {
  player endon("disconnect");
  player DisableWeapons();
  level thread event6_outtro_enemy();
  player maps\mak_anim::play_viewhands("outtro", node, true, 1, 1, 25, 25, 20, 20, false, undefined);
  level thread event6_enemy_nodes();
  weapons = player GetWeaponsList();
  pistol = undefined;
  clip = undefined;
  ammo = undefined;
  for(i = 0; i < weapons.size; i++) {
    if(WeaponClass(weapons[i]) == "pistol") {
      pistol = weapons[i];
      clip = player GetWeaponAmmoClip(pistol);
      ammo = player GetWeaponAmmoStock(pistol);
    }
  }
  if(!isDefined(pistol)) {
    pistol = level.laststandpistol;
    clip = RandomIntRange(4, 7);
    ammo = RandomIntRange(16, 25);
  }
  if(ammo < 16) {
    ammo = RandomIntRange(16, 25);
  }
  player TakeAllWeapons();
  player GiveWeapon(pistol);
  player SetWeaponAmmoClip(pistol, clip);
  player SetWeaponAmmoStock(pistol, 16);
  player SwitchToWeapon(pistol);
  player EnableWeapons();
}

event6_guys_to_boats() {
  cyan_guys = [];
  yellow_guys = [];
  blue_guys = [];
  cyan_guys = get_force_color_guys("allies", "c");
  yellow_guys = get_force_color_guys("allies", "y");
  blue_guys = get_force_color_guys("allies", "b");
  guys = array_combine(cyan_guys, yellow_guys);
  guys = array_combine(guys, blue_guys);
  origin = level.event6_boat2.origin;
  guys = get_array_of_closest(origin, guys);
  for(i = 0; i < guys.size; i++) {
    if(!isDefined(guys[i]) || !IsAlive(guys[i])) {
      continue;
    }
    wait(0.5);
    guys[i] thread event6_get_to_boat();
  }
}

event6_enemy_nodes() {
  nodes = GetNodeArray("outtro_enemy_nodes", "targetname");
  spawners = getEntArray("event6_respawner3", "targetname");
  for(i = 0; i < spawners.size; i++) {
    spawners[i].target = "outtro_enemy_nodes";
  }
  ai = GetAiArray("axis");
  for(i = 0; i < nodes.size; i++) {
    if(isDefined(ai[i])) {
      ai[i].goalradius = 64;
      ai[i] SetGoalNode(nodes[i]);
    }
  }
}

event6_boat_ride(delay) {
  if(self == level.event6_boat1) {
    self playLoopSound("boat_idle");
    flag_wait("event6_boat1_ready");
    spawners = getEntArray("event6_last_enemies", "targetname");
    spawn_guys(spawners, "event6_last_ai");
    players = get_players();
    for(i = 0; i < players.size; i++) {
      players[i] StartCameraTween(0.6);
    }
    setbusstate("ENDING");
    self StartPath();
    self stoploopsound();
    hut_trig = getent("event6_las_enemies_hut_trig", "targetname");
    hut_trig notify("trigger");
    level.event6_boat1 waittill("blow_up");
    level notify("stop_boat_underfire");
    level event6_blow_up_compound();
    level.nextmission_cleanup = ::clean_up_fadeout_hud;
    players = get_players();
    for(i = 0; i < players.size; i++) {
      players[i] thread hud_fade_to_black(5);
      players[i] thread outtro_hide_hud();
    }
    setbusstate("LEVEL_OUT");
    wait(7.5);
    nextmission();
  } else {
    self playLoopSound("boat_idle");
    flag_wait("event6_boat2_ready");
    if(!flag("event6_boat1_ready")) {
      flag_wait("event6_boat1_ready");
      wait(1.5);
    }
    self StartPath();
    setbusstate("ENDING");
    self stoploopsound();
  }
}

outtro_hide_hud() {
  self SetClientDvar("hud_showStance", "0");
  self SetClientDvar("compass", "0");
  self SetClientDvar("ammoCounterHide", "1");
  self setclientdvar("miniscoreboardhide", "1");
}

hud_fade_to_black(time) {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(time)) {
    time = 1;
  }
  if(!isDefined(self.warpblack)) {
    self.warpblack = NewClientHudElem(self);
    self.warpblack.x = 0;
    self.warpblack.y = 0;
    self.warpblack.horzAlign = "fullscreen";
    self.warpblack.vertAlign = "fullscreen";
    self.warpblack.foreground = false;
    self.warpblack.sort = 50;
    self.warpblack.alpha = 0;
    self.warpblack SetShader("black", 640, 480);
  }
  self.warpblack FadeOverTime(time);
  self.warpblack.alpha = 1;
}

clean_up_fadeout_hud() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i].warpblack)) {
      players[i].warpblack Destroy();
    }
  }
}

event6_blow_up_compound() {
  exploder(605);
  playsoundatposition("exp_hut_1_end", (3928, -13647, 273));
  wait(1);
  exploder(609);
  playsoundatposition("exp_hut_2_end", (3313, -12838, 529));
  level thread play_explosion_death_anim((3606.4, -15165.5, 157.1), (0, 318.75, 0));
  level thread play_explosion_death_anim((3606.4, -15165.5, 157.1), (0, 270, 0));
  level thread play_explosion_death_anim((3606.4, -15165.5, 157.1), (0, 3.75, 0));
  wait(2);
  exploder(617);
  playsoundatposition("exp_hut_3_end", (3928, -13647, 273));
  wait(4);
}

anim_single_solo_animname(guy, anime, tag, node, tag_entity, animname_override) {
  self endon("death");
  newguy[0] = guy;
  anim_single(newguy, anime, tag, node, tag_entity, animname_override);
}

get_closest(origin, value, key, exclude, check_if_alive) {
  dist = 99999 * 99999;
  if(!isDefined(check_if_alive)) {
    check_if_alive = false;
  }
  if(key == "team") {
    if(value == "both" || value == "") {
      array = GetAiArray();
    } else {
      array = GetAiArray(value);
    }
  } else {
    array = getEntArray(value, key);
  }
  if(array.size < 1) {
    return;
  }
  if(isDefined(exclude)) {
    new_array = [];
    for(i = 0; i < array.size; i++) {
      do_exclude = false;
      for(q = 0; q < exclude.size; q++) {
        if(array[i] == exclude[q]) {
          do_exclude = true;
        }
      }
      if(!do_exclude) {
        new_array[new_array.size] = array[i];
      }
    }
    array = new_array;
  }
  ent = undefined;
  for(i = 0; i < array.size; i++) {
    if(check_if_alive && !Isalive(array[i])) {
      continue;
    }
    newdist = DistanceSquared(array[i].origin, origin);
    if(newdist >= dist) {
      continue;
    }
    dist = newdist;
    ent = array[i];
  }
  return ent;
}

repeat_dialog_along_vec(array, vec, dist, min_time, max_time, level_endon) {
  level notify("stop_repeat_dialog");
  level endon("stop_repeat_dialog");
  self endon("death");
  if(isDefined(level_endon)) {
    level endon(level_endon);
  }
  by_pass_wait = false;
  while(1) {
    array = array_randomize(array);
    for(i = 0; i < array.size; i++) {
      if(by_pass_wait) {
        wait(1);
      } else {
        wait(min_time + RandomFloat(max_time));
      }
      players = get_players();
      furthest = -999999;
      furthest_player = players[0];
      for(q = 0; q < players.size; q++) {
        dot = VectorDot(players[q].origin, anglesToForward(vec));
        if(dot > furthest) {
          furthest = dot;
          furthest_player = players[q];
        }
      }
      diff = self.origin - furthest_player.origin;
      dot = VectorDot(diff, anglesToForward(vec));
      if(dot < dist) {
        by_pass_wait = true;
        i--;
        println("^1 (" + self.name + ") FAILED TO REMIND PLAYER AS THE PLAYER IS TOO CLOSE");
        continue;
      }
      if(self._animActive > 0) {
        by_pass_wait = true;
        i--;
        println("^1 (" + self.name + ") FAILED TO REMIND PLAYER AS I AM PLAYING A ANIMATION");
        continue;
      }
      by_pass_wait = false;
      self playSound(level.scr_sound[self.animname][array[i]]);
    }
  }
}

balcony_death() {
  self.animname = "generic";
  self.balcony_guy = true;
  self disable_long_death();
  node = GetNode(self.target, "targetname");
  dmg_total = 0;
  self.health = 1000;
  self.targetname = "event2_light_guys";
  while(1) {
    self waittill("damage", dmg);
    if(flag("event3_start")) {
      return;
    }
    self.health = 1000;
    dmg_total += dmg;
    if(dmg_total > 150) {
      self playSound("japanese_yell_delay");
      self thread anim_single_solo(self, "balcony_death", undefined, node);
      self thread maps\mak_anim::death_after_anim(undefined, "ragdoll", "start_ragdoll");
      return;
    }
  }
}

spawn_to_die() {
  wait(0.1);
  self DoDamage(self.health + 10, self.origin);
}

trigger_waittill_dead(value, key, trigger, flag_name) {
  for(;;) {
    wait(0.2);
    touching = false;
    if(key == "team") {
      guys = GetAiArray(value);
    } else {
      guys = getEntArray(value, key);
    }
    for(i = 0; i < guys.size; i++) {
      if(isDefined(guys[i]) && IsAlive(guys[i]) && guys[i] IsTouching(trigger)) {
        touching = true;
        break;
      }
    }
    if(!touching) {
      break;
    }
  }
  if(isDefined(flag_name)) {
    flag_set(flag_name);
  }
}

respawner(key, value, min_delay, max_delay, total_amount) {
  spawners = getEntArray(key, value);
  control = spawnStruct();
  if(isDefined(min_delay)) {
    control.script_delay_min = min_delay;
  }
  if(isDefined(max_delay)) {
    control.script_delay_max = max_delay;
  }
  control.total_amount = 32;
  if(isDefined(total_amount)) {
    control.total_amount = total_amount;
  }
  control.amount = 0;
  for(i = 0; i < spawners.size; i++) {
    control thread respawner_think(spawners[i]);
  }
  if(!isDefined(level.respawner_controls)) {
    level.respawner_controls = [];
  }
  level.respawner_controls[key] = control;
}

respawner_think(spawner) {
  self endon("stop_respawning");
  spawner endon("death");
  for(;;) {
    while(self.amount >= self.total_amount) {
      wait(0.1);
    }
    spawner.count = 1;
    guy = spawn_guy(spawner, undefined, true);
    if(isDefined(guy)) {
      self.amount++;
      guy waittill("death");
      self.amount--;
    }
    self script_delay();
  }
}

follow_nodes(node, start_delay) {
  self notify("stop_follow_nodes");
  self endon("stop_follow_nodes");
  self endon("death");
  if(isDefined(start_delay)) {
    wait(start_delay);
  }
  og_goalradius = self.goalradius;
  self.goalradius = 32;
  for(;;) {
    if(isDefined(node.radius)) {
      self.goalradius = node.radius;
    }
    if(!isDefined(node.target)) {
      if(isDefined(self.enable_arrivals_on_last_node) && self.enable_arrivals_on_last_node) {
        self disable_arrivals(false, false);
        self.enable_arrivals_on_last_node = undefined;
      }
    }
    self SetGoalNode(node);
    self.follow_node = node;
    self waittill("goal");
    if(isDefined(node.script_flag)) {
      self notify(node.script_flag);
    }
    if(isDefined(node.script_flag_set)) {
      flag_set(node.script_flag_set);
    }
    if(isDefined(node.script_flag_wait)) {
      flag_wait(node.script_flag_wait);
    }
    node script_delay();
    if(isDefined(self.script_noteworthy)) {
      if(self.script_noteworthy == "die") {
        self stop_bullet_shield();
        self setCanDamage(true);
        self DoDamage(self.health + 10, self.origin);
      }
    }
    if(!isDefined(node.target)) {
      break;
    }
    node = GetNode(node.target, "targetname");
  }
  self SetGoalNode(node);
  self waittill("goal");
  if(isDefined(node.script_flag_wait)) {
    flag_wait(node.script_flag_wait);
  }
  self.goalradius = og_goalradius;
  self notify("follow_nodes_done");
}

sort_nodes_by_script_int(nodes) {
  for(i = 0; i < nodes.size; i++) {
    for(j = i; j < nodes.size; j++) {
      if(nodes[j].script_int < nodes[i].script_int) {
        temp = nodes[i];
        nodes[i] = nodes[j];
        nodes[j] = temp;
      }
    }
  }
  return nodes;
}

trigger_color_trigger(num) {
  trigger = GetEnt("color_trigger" + num, "script_noteworthy");
  if(isDefined(trigger)) {
    trigger notify("trigger");
  }
}

start_jog(guys, min_x, max_x, struct_name, optional_leader_dist) {
  level endon("stop_jog");
  flag_set("jog_enabled");
  level thread jog_run_thread(guys, struct_name, optional_leader_dist);
  for(i = 0; i < guys.size; i++) {
    if(isDefined(guys[i])) {
      guys[i] thread jog_internal(min_x, max_x);
      wait(RandomFloat(1));
    }
  }
}

jog_internal(min_x, max_x) {
  self endon("death");
  jogs = [];
  jogs[jogs.size] = "jog1";
  jogs[jogs.size] = "jog2";
  self disable_arrivals(true, true);
  self.run_dont_jog = false;
  jogging = false;
  while(flag("jog_enabled")) {
    if(self.origin[0] > min_x && self.origin[0] < max_x) {
      jogging = true;
      if(!self.run_dont_jog) {
        if(isDefined(self.jog_anim)) {
          jog = self.jog_anim;
          self.moveplaybackrate = 1;
        } else {
          jog = jogs[RandomInt(jogs.size)];
          self.moveplaybackrate = 0.9;
        }
        self set_generic_run_anim(jog);
        delay = GetAnimLength(level.scr_anim["generic"][jog]);
        wait(delay - (0.1 + RandomFloat(0.5)));
      } else {
        jogging = false;
      }
    } else {
      jogging = false;
    }
    if(!jogging) {
      if(self.origin[0] < -9200) {
        if(isDefined(self.jog_anim)) {
          jog = self.jog_anim;
          self.moveplaybackrate = 1;
        } else {
          jog = jogs[RandomInt(jogs.size)];
          self.moveplaybackrate = 0.9;
        }
        self set_generic_run_anim(jog);
        self.moveplaybackrate = 1.2;
      } else {
        self.moveplaybackrate = 1;
        self set_generic_run_anim("jog_sprint");
      }
    }
    wait(0.5);
  }
  self.jog_anim = undefined;
  self.moveplaybackrate = 1.0;
  self clear_run_anim();
  self disable_arrivals(false, false);
  level notify("stop_jog");
}

jog_run_thread(guys, struct_name, optional_leader_dist) {
  level endon("stop_jog");
  leader_dist = 256;
  if(isDefined(optional_leader_dist)) {
    leader_dist = optional_leader_dist;
  }
  old_struct = undefined;
  struct = GetStruct(struct_name, "targetname");
  structs = [];
  structs[0] = struct;
  while(isDefined(struct.target)) {
    old_struct = struct;
    struct = GetStruct(struct.target, "targetname");
    structs[structs.size] = struct;
    old_struct.angles = VectorToAngles(struct.origin - old_struct.origin);
  }
  struct.angles = old_struct.angles;
  for(;;) {
    guys = array_removeundefined(guys);
    guys = array_removedead(guys);
    lead_guy = guys[0];
    for(i = 1; i < guys.size; i++) {
      if(guys[i].origin[0] > lead_guy.origin[0]) {
        lead_guy = guys[i];
      }
    }
    players = get_players();
    furthest = players[0];
    for(i = 1; i < players.size; i++) {
      if(players[i].origin[0] > furthest.origin[0]) {
        furthest = players[i];
      }
    }
    struct = get_closest_exclude(lead_guy.origin, structs);
    diff = lead_guy.origin - furthest.origin;
    dot = VectorDot(diff, anglesToForward(struct.angles));
    for(i = 0; i < guys.size; i++) {
      if(dot < 200) {
        if(guys[i] == lead_guy) {
          guys[i] thread print3d_on_ent("^2Lead RUN", "jogging", "stop_jog");
        } else {
          guys[i] thread print3d_on_ent("RUN", "jogging", "stop_jog");
        }
        guys[i].run_dont_jog = true;
      } else {
        if(guys[i] == lead_guy) {
          guys[i] thread print3d_on_ent("^2Lead JOG", "jogging", "stop_jog");
          guys[i].run_dont_jog = false;
        } else if(DistanceSquared(guys[i].origin, lead_guy.origin) > leader_dist * leader_dist) {
          guys[i] thread print3d_on_ent("RUN", "jogging", "stop_jog");
          guys[i].run_dont_jog = true;
        } else {
          guys[i] thread print3d_on_ent("JOG", "jogging", "stop_jog");
          guys[i].run_dont_jog = false;
        }
      }
    }
    wait(0.25);
  }
}

get_avg_center(array) {
  center = (0, 0, 0);
  for(i = 0; i < array.size; i++) {
    center = (center[0] + array[i].origin[0], center[1] + array[i].origin[1], center[2] + array[i].origin[2]);
  }
  center = (center[0] / array.size, center[1] / array.size, center[2] / array.size);
  return center;
}

ignore_all_timer(array, time) {
  for(i = 0; i < array.size; i++) {
    array[i].ignoreall = true;
  }
  wait(time);
  for(i = 0; i < array.size; i++) {
    if(isDefined(array[i])) {
      array[i].ignoreall = false;
    }
  }
}

redshirt_dialog(ref) {
  og_animname = undefined;
  if(isDefined(self.animname)) {
    og_animname = self.animname;
  }
  self.animname = "generic";
  self anim_single_solo(self, ref);
  if(isDefined(og_animname)) {
    self.animname = og_animname;
  } else {
    if(!isDefined(self.animname)) {
      self.animname = undefined;
    }
  }
}

disable_grenades_for_team(team) {
  ai = GetAiArray(team);
  for(i = 0; i < ai.size; i++) {
    ai[i] disable_grenades();
  }
}

enable_grenades_for_team(team) {
  ai = GetAiArray(team);
  for(i = 0; i < ai.size; i++) {
    ai[i] enable_grenades();
  }
}

disable_grenades() {
  self.og_grenadeammo = self.grenadeammo;
  self.grenadeammo = 0;
}

enable_grenades() {
  if(isDefined(self.og_grenadeammo)) {
    self.grenadeammo = self.og_grenadeammo;
  }
}

disable_arrivals(arrivals, exits, level_waittill, delay) {
  if(isDefined(level_waittill)) {
    level waittill(level_waittill);
  }
  if(isDefined(delay)) {
    wait(delay);
  }
  self.disableArrivals = arrivals;
  self.disableexits = exits;
}

build_custom_vehicle(type) {
  model = undefined;
  death_model = undefined;
  death_fx = "explosions/large_vehicle_explosion";
  death_sound = "explo_metal_rand";
  health = 2000;
  min_health = 1000;
  max_health = 5000;
  team = "axis";
  turretType = undefined;
  turretModel = undefined;
  func = undefined;
  if(type == "rubber_raft") {
    model = "makin_raft_rubber";
    death_fx = undefined;
    death_model = "makin_raft_rubber";
    health = 7500;
    min_health = 5000;
    max_health = 10000;
    team = "allies";
    func = ::rubber_raft_init;
  } else if(type == "type94") {
    model = "vehicle_jap_wheeled_type94_camo";
    death_fx = undefined;
    death_model = undefined;
    health = -1;
    min_health = -1;
    max_health = -1;
    team = "allies";
    func = ::rubber_raft_init;
  }
  maps\_vehicle::build_template(type, model);
  maps\_vehicle::build_life(health, min_health, max_health);
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_team(team);
  maps\_vehicle::build_localinit(func);
  if(isDefined(death_model)) {
    maps\_vehicle::build_deathmodel(model, death_model);
  }
  if(isDefined(death_fx)) {
    maps\_vehicle::build_deathfx(death_fx, "tag_engine", death_sound, undefined, undefined, undefined, undefined);
  }
  if(isDefined(turretType) && isDefined(turretModel)) {
    maps\_vehicle::build_turret(turretType, "tag_gunLeft", turretModel, true);
    maps\_vehicle::build_turret(turretType, "tag_gunRight", turretModel, true);
  }
}

rubber_raft_init() {}
type94_init() {}
torch_ai(delay) {
  self endon("death");
  wait(0.05);
  tagArray = [];
  tagArray[tagArray.size] = "J_Wrist_RI";
  tagArray[tagArray.size] = "J_Wrist_LE";
  tagArray[tagArray.size] = "J_Elbow_LE";
  tagArray[tagArray.size] = "J_Elbow_RI";
  tagArray[tagArray.size] = "J_Knee_RI";
  tagArray[tagArray.size] = "J_Knee_LE";
  tagArray[tagArray.size] = "J_Ankle_RI";
  tagArray[tagArray.size] = "J_Ankle_LE";
  tagArray = array_randomize(tagArray);
  for(i = 0; i < 3; i++) {
    playFXOnTag(level._effect["character_fire_death_sm"], self, tagArray[i]);
    if(isDefined(delay)) {
      wait(delay);
    }
  }
  playFXOnTag(level._effect["character_fire_death_torso"], self, "J_SpineLower");
  wait(3);
  self StartTanning();
}

angle_normalize_180(angle) {
  scaled_angle = angle * 0.00277778;
  return int((scaled_angle - int(scaled_angle + 0.5)) * 360);
}

angles_normalize_180(angles) {
  return (angle_normalize_180(angles[0]), angle_normalize_180(angles[1]), angle_normalize_180(angles[2]));
}

get_explosion_death(yaw) {
  death_array = [];
  if((yaw > 135) || (yaw <= -135)) {
    death_array[death_array.size] = % death_explosion_stand_B_v1;
    death_array[death_array.size] = % death_explosion_stand_B_v2;
    death_array[death_array.size] = % death_explosion_stand_B_v3;
    death_array[death_array.size] = % death_explosion_stand_B_v4;
  } else if((yaw > 45) && (yaw <= 135)) {
    death_array[death_array.size] = % death_explosion_stand_L_v1;
    death_array[death_array.size] = % death_explosion_stand_L_v2;
    death_array[death_array.size] = % death_explosion_stand_L_v3;
  } else if((yaw > -45) && (yaw <= 45)) {
    death_array[death_array.size] = % death_explosion_stand_F_v1;
    death_array[death_array.size] = % death_explosion_stand_F_v2;
    death_array[death_array.size] = % death_explosion_stand_F_v3;
    death_array[death_array.size] = % death_explosion_stand_F_v4;
  } else {
    death_array[death_array.size] = % death_explosion_stand_R_v1;
    death_array[death_array.size] = % death_explosion_stand_R_v2;
  }
  return get_random(death_array);
}

get_random(array) {
  return array[RandomInt(array.size)];
}

set_random_gib() {
  refs = [];
  refs[refs.size] = "right_arm";
  refs[refs.size] = "left_arm";
  refs[refs.size] = "right_leg";
  refs[refs.size] = "left_leg";
  refs[refs.size] = "no_legs";
  refs[refs.size] = "guts";
  self.a.gib_ref = get_random(refs);
}

dof_enable(toggle) {
  SetSavedDvar("scr_dof_enable", toggle);
}

spawn_guys(spawners, target_name, ok_to_spawn) {
  guys = [];
  for(i = 0; i < spawners.size; i++) {
    guy = spawn_guy(spawners[i], target_name, ok_to_spawn);
    if(isDefined(guy)) {
      guys[guys.size] = guy;
    }
  }
  if(!isDefined(ok_to_spawn) || !ok_to_spawn) {
    return guys;
  }
}

spawn_guy(spawner, target_name, ok_to_spawn) {
  if(isDefined(ok_to_spawn) && ok_to_spawn) {
    while(!OkTospawn()) {
      wait(0.1);
    }
  }
  if(isDefined(spawner.script_forcespawn) && spawner.script_forcespawn) {
    guy = spawner Stalingradspawn();
  } else {
    guy = spawner Dospawn();
  }
  if(!spawn_failed(guy)) {
    if(isDefined(target_name)) {
      guy.targetname = target_name;
    }
    return guy;
  }
  return undefined;
}

reach_node_bloody_death(node, delay, wait_til_goal) {
  self.goalradius = 32;
  self SetGoalNode(node);
  if(isDefined(wait_til_goal)) {
    self waittill("goal");
  }
  self thread bloody_death(delay);
}

bloody_death_array(value, key, min_delay, max_delay, one_at_a_time, x) {
  guys = [];
  if(!isDefined(one_at_a_time)) {
    one_at_a_time = false;
  }
  if(key == "r" || key == "b" || key == "c" || key == "y") {
    guys = get_force_color_guys(value, key);
  } else if(key == "team") {
    guys = GetAiArray(value);
  } else {
    guys = getEntArray(value, key);
  }
  for(i = 0; i < guys.size; i++) {
    if(isDefined(x)) {
      if(x > guys[i].origin[0]) {
        guys[i] thread bloody_death();
        continue;
      }
    }
    if(one_at_a_time) {
      if(isDefined(guys[i])) {
        guys[i] bloody_death(min_delay + RandomFloat(max_delay));
      }
    } else {
      if(isDefined(guys[i])) {
        guys[i] thread bloody_death(min_delay + RandomFloat(max_delay));
      }
    }
  }
}

bloody_death(delay) {
  self endon("death");
  if(!IsAi(self) || !IsAlive(self)) {
    return;
  }
  if(isDefined(self.bloody_death) && self.bloody_death) {
    return;
  }
  self.bloody_death = true;
  if(isDefined(delay)) {
    wait(RandomFloat(delay));
  }
  tags = [];
  tags[0] = "j_hip_le";
  tags[1] = "j_hip_ri";
  tags[2] = "j_head";
  tags[3] = "j_spine4";
  tags[4] = "j_elbow_le";
  tags[5] = "j_elbow_ri";
  tags[6] = "j_clavicle_le";
  tags[7] = "j_clavicle_ri";
  for(i = 0; i < 2; i++) {
    random = RandomIntRange(0, tags.size);
    self thread bloody_death_fx(tags[random], undefined);
    wait(RandomFloat(0.1));
  }
  dmg = self.health + 10;
  if(isDefined(self.balcony_guy) && self.balcony_guy) {
    dmg = 155;
  }
  self DoDamage(dmg, self.origin);
}

bloody_death_fx(tag, fxName) {
  if(!is_mature()) {
    return;
  }
  if(!isDefined(fxName)) {
    fxName = level._effect["flesh_hit"];
  }
  playFXOnTag(fxName, self, tag);
}

wait_for_group_notify(ents, waittill_msg) {
  struct = spawnStruct();
  threads = ents.size;
  for(i = 0; i < ents.size; i++) {
    ents[i] thread wait_for_groupent_notify(struct, waittill_msg);
  }
  while(threads) {
    struct waittill("group_notify");
    threads--;
  }
}

wait_for_groupent_notify(struct, waittill_msg) {
  self waittill_either("death", waittill_msg);
  struct notify("group_notify");
}

get_event1_pow_group() {
  pows = getEntArray("event1_pows", "targetname");
  beaters = getEntArray("event1_pow_beaters", "targetname");
  guys = array_combine(pows, beaters);
  for(i = 0; i < guys.size; i++) {
    guys[i] init_intro_settings();
    if(guys[i].targetname == "event1_pow_beaters") {
      guys[i].a.nodeath = false;
      guys[i] thread maps\mak_anim::death_after_anim(undefined, "ragdoll", undefined, RandomFloat(1));
    }
    if(guys[i].targetname == "event1_pows") {
      guys[i].weapon = "";
    }
  }
  return guys;
}

random_player_seek() {
  self endon("death");
  if(flag("random_player_seek")) {
    if(isDefined(self.player_no_seek)) {
      return;
    }
    level thread flag_clear_delayed("random_player_seek", level.player_seek_timer);
    self.player_seek = true;
    self.goalradius = 128;
    self SetThreatBiasGroup("rushers");
    self SetGoalEntity(get_closest_player(self.origin));
    self notify("player_seeking");
    if(isDefined(self.script_sound)) {
      self animscripts\face::SaySpecificDialogue(undefined, self.script_sound, 1.0);
    }
    wait(1);
    self.ignoreme = false;
  }
}

set_targetname_to_noteworthy() {
  self.targetname = self.script_noteworthy;
}

set_disable_arrivals() {
  self disable_arrivals(true, true);
}

set_bullet_shield() {
  if(!isDefined(self.magic_bullet_shield)) {
    self thread magic_bullet_shield();
  }
}

stop_bullet_shield() {
  if(isDefined(self.magic_bullet_shield)) {
    self thread stop_magic_bullet_shield();
  }
}

set_no_damage() {
  self setCanDamage(false);
}

set_no_gib() {
  self.no_gib = 1;
}

get_sorted_players() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    for(j = i; j < players.size; j++) {
      if(players[j] GetEntityNumber() > players[i] GetEntityNumber()) {
        temp = players[i];
        players[i] = players[j];
        players[j] = temp;
      }
    }
  }
  return players;
}

set_player_attrib(attrib, value) {
  if(!isDefined(level.player_attribs)) {
    level.player_attribs = [];
  }
  level.player_attribs[attrib] = value;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] set_player_attrib_internal(attrib, value);
  }
}

set_player_attrib_internal(attrib, value, value2) {
  switch (attrib) {
    case "ignoreme":
      self.ignoreme = value;
      break;
    case "stand":
      self AllowStand(value);
      break;
    case "crouch":
      self AllowCrouch(value);
      break;
    case "prone":
      self AllowProne(value);
      break;
    case "fov":
      self SetClientDvar("cg_fov", value);
      break;
  }
}

set_onplayer_attribs() {
  if(isDefined(level.player_attribs)) {
    keys = GetArrayKeys(level.player_attribs);
    for(i = 0; i < keys.size; i++) {
      self set_player_attrib_internal(keys[i], level.player_attribs[keys[i]]);
    }
  }
}

set_player_speed(player_speed, time) {
  self notify("stop_set_player_speed");
  self endon("stop_set_player_speed");
  base_speed = 190;
  level.player_speed = player_speed;
  if(!isDefined(time)) {
    time = 0;
  }
  steps = abs(int(time * 4));
  target_speed_scale = player_speed / base_speed;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] thread set_player_speed_internal(target_speed_scale, steps);
  }
}

set_player_speed_internal(target_speed_scale, steps) {
  self endon("death");
  self endon("disconnect");
  self notify("stop_set_player_speed");
  self endon("stop_set_player_speed");
  if(!isDefined(self.move_speed_scale)) {
    self.move_speed_scale = 1;
  }
  if(self.move_speed_scale == target_speed_scale) {
    return;
  }
  difference = target_speed_scale - self.move_speed_scale;
  increment = difference / steps;
  for(i = 0; i < steps; i++) {
    self.move_speed_scale += increment;
    self SetMoveSpeedScale(self.move_speed_scale);
    wait(0.5);
  }
  self.move_speed_scale = target_speed_scale;
  self SetMoveSpeedScale(self.move_speed_scale);
}

timescale_duration(timescale, in_time, duration, out_time, delay) {
  if(isDefined(delay)) {
    wait(delay);
  }
  set_timescale(timescale, in_time);
  wait(duration);
  set_timescale(1, out_time);
}

set_timescale(timescale, trans_time) {
  curr_scale = GetTimeScale();
  difference = timescale - curr_scale;
  steps = trans_time * 20;
  increment = difference / steps;
  for(i = 0; i < steps; i++) {
    curr_scale += increment;
    SetTimeScale(curr_scale);
    wait(0.05);
  }
  SetTimeScale(timescale);
}

create_spawner_function(value, key, func) {
  spawners = getEntArray(value, key);
  for(i = 0; i < spawners.size; i++) {
    spawners[i] add_spawn_function(func);
  }
}

reman_mg_thread(mg, guy, threatbias, value, key) {
  mg endon("stop_reman_mg_think");
  owner = mg GetTurretOwner();
  if(isDefined(owner)) {
    guy = owner;
  }
  if(isDefined(guy)) {
    if(isDefined(threatbias)) {
      guy.threatbias = threatbias;
    }
    guy.player_no_seek = true;
    guy disable_long_death();
    guy waittill("death");
  }
  while(1) {
    wait(RandomFloatRange(1, 3));
    if(key == "team") {
      backup = GetAiArray(value);
    } else {
      backup = getEntArray(value, key);
    }
    new_mger = undefined;
    if(backup.size > 0) {
      backup = get_array_of_closest(mg.origin, backup);
      backup = array_removeUndefined(backup);
      backup = array_removeDead(backup);
      if(backup.size > 3) {
        num = RandomIntRange(1, 4);
        new_mger = backup[num];
      } else {
        new_mger = backup[0];
      }
      break;
    }
  }
  if(isDefined(new_mger)) {
    new_mger thread reman_mg_goto(mg);
    level thread reman_mg_thread(mg, new_mger, threatbias, value, key);
  }
}

reman_mg_goto(mg) {
  node = GetNode(mg.targetname, "target");
  self.player_no_seek = true;
  self.ignoreme = true;
  self.ignoreall = true;
  self.goalradius = 16;
  self SetGoalNode(node);
  self waittill("goal");
  self.ignoreme = false;
  self.ignoreall = false;
  mg notify("manned");
  self UseTurret(mg);
  self KnockBack(false);
}

plant_charge_think(trigger) {
  self endon("death");
  if(isDefined(self.script_flag_wait)) {
    if(!isDefined(level.flag[self.script_flag_wait])) {
      flag_init(self.script_flag_wait);
    }
  }
  if(isDefined(self.script_flag)) {
    if(!isDefined(level.flag[self.script_flag])) {
      flag_init(self.script_flag);
    }
  }
  glowy_model = undefined;
  planted_model = undefined;
  targets = getEntArray(self.target, "targetname");
  for(i = 0; i < targets.size; i++) {
    if(isDefined(targets[i].script_noteworthy)) {
      if(targets[i].script_noteworthy == "glowy") {
        glowy_model = targets[i];
      }
    } else {
      planted_model = targets[i];
    }
    targets[i] Hide();
  }
  self trigger_off();
  if(isDefined(self.script_flag_wait)) {
    flag_wait(self.script_flag_wait);
  }
  self trigger_on();
  self SetHintString(&"SCRIPT_PLATFORM_HINT_PLANTEXPLOSIVES");
  glowy_model Show();
  self.charge_planted = false;
  while(1) {
    self waittill("trigger", other);
    if(!isDefined(self.script_timer)) {
      break;
    }
    other DisableWeapons();
    other AllowProne(false);
    other plant_charge_bar(self);
    other AllowProne(true);
    other EnableWeapons();
    if(self.charge_planted) {
      other stopsounds();
      playsoundatposition("mak_charge_set", self.origin);
      break;
    }
  }
  if(isDefined(self.script_flag)) {
    flag_set(self.script_flag);
  }
  if(isDefined(planted_model)) {
    planted_model Show();
  }
  if(isDefined(glowy_model)) {
    glowy_model Delete();
  }
  self Delete();
}

plant_charge_animation_think(player) {
  self endon("stop_charge_bar");
  self endon("stop_charge_bar_thread");
  if(is_coop()) {
    while(1) {
      stance = player getstance();
      if(stance == "stand") {
        player playeranimscriptevent("mak_bomb_stand");
      } else if(stance == "crouch") {
        player playeranimscriptevent("mak_bomb_crouch");
      }
      player waittill("done");
    }
  }
}

plant_charge_bar(trigger) {
  self endon("disconnect");
  self endon("death");
  trigger endon("stop_charge_bar");
  trigger thread plant_charge_bar_thread(self);
  trigger thread plant_charge_animation_think(self);
  x = 0;
  y = -90;
  x_size = 100;
  y_size = 10;
  time = trigger.script_timer;
  self.plant_title = newClientHudElem(self);
  self.plant_title.x = x;
  self.plant_title.y = y - 20;
  self.plant_title.alignX = "center";
  self.plant_title.horzAlign = "center";
  self.plant_title.vertAlign = "bottom";
  self.plant_title.foreground = true;
  self.plant_title.fontScale = 1.25;
  self.plant_title.sort = 1;
  self.plant_title.hidewheninmenu = true;
  self.plant_title SetText(&"MAK_PLANTING");
  self.plant_bg = newClientHudElem(self);
  self.plant_bg.x = x - (x_size * 0.5);
  self.plant_bg.y = y;
  self.plant_bg.horzAlign = "center";
  self.plant_bg.vertAlign = "bottom";
  self.plant_bg.foreground = true;
  self.plant_bg.sort = 1;
  self.plant_bg.hidewheninmenu = true;
  self.plant_bg SetShader("black", x_size, y_size);
  self.plant_fg = newClientHudElem(self);
  self.plant_fg.x = x - (x_size * 0.5) + 2;
  self.plant_fg.y = y + 2;
  self.plant_fg.horzAlign = "center";
  self.plant_fg.vertAlign = "bottom";
  self.plant_fg.foreground = true;
  self.plant_fg.sort = 2;
  self.plant_fg.hidewheninmenu = true;
  self.plant_fg SetShader("white", 0, y_size - 4);
  self.plant_fg ScaleOverTime(time, x_size - 4, y_size - 4);
  wait(time);
  trigger notify("stop_charge_bar_thread");
  if(isDefined(self.plant_title)) {
    self.plant_title Destroy();
  }
  if(isDefined(self.plant_bg)) {
    self.plant_bg Destroy();
  }
  if(isDefined(self.plant_fg)) {
    self.plant_fg Destroy();
  }
  trigger.charge_planted = true;
}

plant_charge_bar_thread(other) {
  self endon("stop_charge_bar_thread");
  while(isDefined(other) && other UseButtonPressed() && DistanceSquared(other.origin, self.origin) < 512 * 512) {
    other thread plant_charge_trigger_hint(self);
    other thread plant_charge_ticker_sound(self);
    wait(0.05);
  }
  self notify("stop_charge_bar");
  other stoploopsound();
  if(isDefined(other)) {
    if(isDefined(other.plant_title)) {
      other.plant_title Destroy();
    }
    if(isDefined(other.plant_bg)) {
      other.plant_bg Destroy();
    }
    if(isDefined(other.plant_fg)) {
      other.plant_fg Destroy();
    }
  }
}

plant_charge_trigger_hint(trigger) {
  if(!isDefined(trigger.nohintstring)) {
    trigger.nohintstring = false;
  }
  if(!(trigger.nohintstring)) {
    trigger.nohintstring = true;
    trigger SetHintString("");
    trigger waittill("stop_charge_bar");
    trigger SetHintString(&"SCRIPT_PLATFORM_HINT_PLANTEXPLOSIVES");
    trigger.nohintstring = false;
  }
}

plant_charge_ticker_sound(trigger) {
  if(!isDefined(self.isplayingticker)) {
    self.isplayingticker = false;
  }
  if(!(self.isplayingticker)) {
    self.isplayingticker = true;
    self playSound("mak_charge_planting");
    trigger waittill("stop_charge_bar");
    self stopsounds();
    self.isplayingticker = false;
  }
}

repeat_dialog(guy, anime, amount, min_delay, max_delay, end_on, animname_override) {
  level endon(end_on);
  level notify("stop_repeat_dialog");
  level endon("stop_repeat_dialog");
  guy endon("death");
  array = [];
  for(i = 1; i < amount; i++) {
    array[array.size] = anime + i;
  }
  for(;;) {
    array = array_randomize(array);
    for(i = 0; i < array.size; i++) {
      delay = min_delay + RandomFloat(max_delay);
      wait(delay);
      guy anim_single_solo_animname(guy, array[i], undefined, undefined, undefined, animname_override);
    }
  }
}

autosave_light_check() {
  if(level.missionfailed) {
    return false;
  }
  if(maps\_arcademode::arcademode_complete()) {
    return false;
  }
  if(maps\_laststand::player_any_player_in_laststand()) {
    return false;
  }
  if(!maps\_autosave::autosave_health_check()) {
    return false;
  }
  host = get_host();
  if(host IsThrowingGrenade() && host GetCurrentOffHand() != "molotov") {
    maps\_autosave::auto_save_print("autosave_player_check: FAILED!!! -> host is throwing a grenade");
    return false;
  }
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(players[i] animscripts\banzai::in_banzai_attack()) {
      maps\_autosave::auto_save_print("autosave_player_check: FAILED!!! -> player " + i + " is in banzai attack.");
      return false;
    }
  }
  if(!IsSaveSuccessful()) {
    maps\_autosave::auto_save_print("autosave_check: FAILED!!! -> save call was unsuccessful");
    return false;
  }
  return true;
}

get_starting_guys() {
  guys = getEntArray("starting_allies", "targetname");
  return guys;
}

add_extra_starting_guy() {
  if(!isDefined(level.starting_guys)) {
    level.starting_guys = [];
  }
  level.starting_guys[level.starting_guys.size] = self;
}

get_sorted_starts(start_name) {
  starts = getstructarray(start_name, "targetname");
  player_starts = [];
  ai_starts = [];
  for(i = 0; i < starts.size; i++) {
    if(isDefined(starts[i].script_int)) {
      player_starts[player_starts.size] = starts[i];
    } else {
      ai_starts[ai_starts.size] = starts[i];
    }
  }
  for(i = 0; i < player_starts.size; i++) {
    for(j = i; j < player_starts.size; j++) {
      if(player_starts[j].script_int < player_starts[i].script_int) {
        temp = player_starts[i];
        player_starts[i] = player_starts[j];
        player_starts[j] = temp;
      }
    }
  }
  split_array = [];
  split_array[0] = ai_starts;
  split_array[1] = player_starts;
  return split_array;
}

set_start_position(start_name, only_players) {
  start_hide_players();
  start_warp_guys(start_name, only_players);
}

start_warp_guys(start_name, only_players) {
  players = [];
  ai = [];
  if(isDefined(only_players)) {
    players = get_sorted_players();
  } else {
    players = get_sorted_players();
    ai = get_starting_guys();
  }
  if(isDefined(level.starting_guys)) {
    ai = array_combine(level.starting_guys, ai);
  }
  guys = array_combine(ai, players);
  starts_array = get_sorted_starts(start_name);
  ai_starts = starts_array[0];
  player_starts = starts_array[1];
  if(!isDefined(starts_array) || starts_array.size < 1 || !isDefined(guys)) {
    println("^1start_warp_guys(), starts or guys are not defined!");
    return;
  }
  ai_num = 0;
  player_num = 0;
  for(i = 0; i < guys.size; i++) {
    if(IsPlayer(guys[i])) {
      if(!isDefined(player_starts[player_num])) {
        player_num--;
      }
      guys[i] SetOrigin(player_starts[player_num].origin);
      guys[i] SetPlayerAngles(player_starts[player_num].angles);
      player_num++;
    } else {
      guys[i] Teleport(ai_starts[ai_num].origin, ai_starts[ai_num].angles);
      guys[i] SetGoalPos(ai_starts[ai_num].origin);
      ai_num++;
    }
  }
}

start_hide_players() {
  players = get_players();
  hide_spot = GetStruct("hide_spot", "targetname");
  for(i = 0; i < players.size; i++) {
    players[i] SetOrigin(hide_spot.origin);
  }
}

set_start_objective(num) {
  num++;
  for(i = 0; i < num; i++) {
    set_objective(i);
  }
}

hide_players() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    org = spawn("script_origin", players[i].origin);
    players[i].start_org = org;
    players[i] LinkTo(players[i].start_org);
    players[i].start_org MoveTo(players[i].start_org.origin - (0, 0, 10000), 0.1, 0.1);
  }
  level waittill("ai teleported");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i].start_org MoveTo(players[i].start_org.origin + (0, 0, 10000), 0.1, 0.1);
    players[i] UnLink();
    players[i].start_org Delete();
  }
}

set_objective(num, ent) {
  if(num == 0) {
    Objective_Add(0, "active", &"MAK_OBJ_SECURE_VILLAGE", (-9705, -15483, 132));
    Objective_Current(0);
  } else if(num == 1) {
    Objective_State(0, "done");
    Objective_Add(1, "active", &"MAK_OBJ_REGROUP_2ND_SQUAD", (-3096, -16800, 39.2));
    Objective_Current(1);
  } else if(num == 1.5) {
    Objective_String(1, &"MAK_OBJ_RESCUE_2ND_SQUAD");
  } else if(num == 2) {
    Objective_State(1, "done");
    Objective_Add(2, "active", &"MAK_OBJ_EXTRACTION_POINT", (3048, -14174, 376));
    Objective_Current(2);
  } else if(num == 3) {
    origin = (2684, -12778, 144);
    players = get_players();
    if(players.size > 1) {
      Objective_Add(3, "active", &"MAK_OBJ_PLANTCHARGE_COOP", origin);
    } else {
      Objective_Add(3, "active", &"MAK_OBJ_PLANTCHARGE", origin);
    }
    Objective_Current(3);
  } else if(num == 4) {
    Objective_State(3, "done");
    wait_network_frame();
    Objective_Position(2, (3473, -15627, 6));
    Objective_Current(2);
  }
  wait_network_frame();
}

end_level() {
  trigger = GetEnt("end_level", "targetname");
  if(isDefined(trigger)) {
    trigger waittill("trigger");
    to_be_continued();
  }
}

to_be_continued() {
  if(GetDvar("not_demo") != "") {
    return;
  }
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] EnableInvulnerability();
  }
  bg = NewHudElem();
  bg.x = 0;
  bg.y = 0;
  bg.horzAlign = "fullscreen";
  bg.vertAlign = "fullscreen";
  bg.foreground = false;
  bg.sort = 50;
  bg SetShader("black", 640, 480);
  bg.alpha = 0;
  bg FadeOverTime(0.5);
  bg.alpha = 1;
  set_all_players_shock("level_end", 20);
  maps\mak_amb::change_music_state("ENDLEVEL");
  wait(0.5);
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] FreezeControls(true);
  }
  wait(1.5);
  continued_text = NewHudElem();
  continued_text.x = 0;
  continued_text.y = 0;
  continued_text.alignX = "center";
  continued_text.alignY = "middle";
  continued_text.horzAlign = "center";
  continued_text.vertAlign = "middle";
  continued_text.sort = 1;
  continued_text.foreground = true;
  continued_text.fontScale = 1.75;
  continued_text SetText(&"MAK_CONTINUED");
  continued_text.alpha = 0;
  continued_text FadeOverTime(1.2);
  continued_text.alpha = 1;
  wait(6);
  nextmission();
}

player_speed_within_coords(speed, axis, min, max, flag_name) {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] thread player_speed_within_coords_internal(speed, axis, min, max, flag_name);
  }
}

player_speed_within_coords_internal(speed, axis, min, max, flag_name) {
  self endon("disconnect");
  base_speed = 190;
  level.player_speed = speed;
  steps = abs(int(5 * 4));
  target_speed = speed / base_speed;
  using_speed = false;
  while(!flag(flag_name)) {
    change_speed = false;
    if(axis == "x") {
      if(self.origin[0] > min && self.origin[0] < max) {
        change_speed = true;
      }
    } else if(axis == "y") {
      if(self.origin[1] > min && self.origin[1] < max) {
        change_speed = true;
      }
    }
    if(change_speed && !using_speed) {
      using_speed = true;
      self thread set_player_speed_internal(target_speed, steps);
    }
    if(!change_speed && using_speed) {
      using_speed = false;
      self thread set_player_speed_internal(1, steps);
    }
    wait(0.1);
  }
  self thread set_player_speed_internal(1, steps);
}

onMakSaveGameRestored() {
  maps\_callbackglobal::Callback_SaveRestored();
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] set_onplayer_attribs();
  }
}

spawn_todo(msg, origin, time, wait_flag) {
  org = spawn("script_origin", origin);
  if(isDefined(wait_flag)) {
    org thread do_print3d(msg, time);
    flag_wait(wait_flag);
  } else {
    org do_print3d(msg, time);
  }
  org Delete();
}

do_print3d_pos(vec, msg, timer, offset) {
  self endon("stop_do_print3d_pos");
  if(!isDefined(timer)) {
    timer = GetTime() + 99999999999;
  } else {
    timer = GetTime() + (timer * 1000);
  }
  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }
  self endon("death");
  while(GetTime() < timer) {
    print3d(vec + offset, msg);
    wait(0.05);
  }
}

do_print3d(msg, timer, offset) {
  self endon("death");
  if(!isDefined(timer)) {
    timer = GetTime() + 99999999999;
  } else {
    timer = GetTime() + (timer * 1000);
  }
  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }
  self endon("death");
  while(GetTime() < timer) {
    print3d(self.origin + offset, msg);
    wait(0.05);
  }
}

line_to_player() {
  self endon("death");
  players = get_players();
  while(1) {
    line(self.origin, players[0].origin);
    wait(0.05);
  }
}

line_points(point1, point2, color) {
  self endon("stop_line_points");
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }
  while(1) {
    line(point1, point2, color);
    wait(0.05);
  }
}

set_hudelem(text, x, y, scale, alpha, color, sort) {
  if(!isDefined(alpha)) {
    alpha = 1;
  }
  if(!isDefined(scale)) {
    scale = 1;
  }
  if(!isDefined(sort)) {
    sort = 20;
  }
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }
  players = get_players();
  hud = NewDebugHudElem(players[0]);
  hud.location = 0;
  hud.alignX = "center";
  hud.alignY = "middle";
  hud.foreground = 1;
  hud.fontScale = scale;
  hud.sort = sort;
  hud.alpha = alpha;
  hud.x = x;
  hud.y = y;
  hud.og_scale = scale;
  if(isDefined(text)) {
    hud SetText(text);
  }
  return hud;
}

draw_tag_angles(tagname, color) {
  self endon("death");
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }
  while(1) {
    forward = anglesToForward(self GetTagAngles(tagname));
    pos2 = self GetTagOrigin(tagname) + vector_multiply(forward, 5);
    line(self GetTagOrigin(tagname), pos2, color);
    wait(0.05);
  }
}

draw_tag_name(tagname, color) {
  self endon("death");
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }
  while(1) {
    print3d(self GetTagOrigin(tagname), tagname);
    wait(0.05);
  }
}

print_health() {
  self endon("death");
  while(1) {
    print3d(self.origin + (0, 0, 72), self.health);
    wait(0.05);
  }
}

print3d_on_ent(msg, thread_endon, level_endon, offset) {
  self endon("death");
  if(isDefined(thread_endon)) {
    self notify(thread_endon);
    self endon(thread_endon);
  }
  if(isDefined(level_endon)) {
    level endon(level_endon);
  }
  if(!isDefined(offset)) {
    offset = (0, 0, 72);
  }
  while(1) {
    print3d(self.origin + offset, msg);
    wait(0.05);
  }
}

draw_line_ent_to_ent(ent1, ent2) {
  ent1 endon("death");
  ent2 endon("death");
  while(1) {
    line(ent1.origin, ent2.origin);
    wait(0.05);
  }
}

draw_line_pos_to_pos(pos1, pos2) {
  self endon("death");
  while(1) {
    line(pos1, pos2);
    wait(0.05);
  }
}

draw_line_to_player(pos, color) {
  level notify("stop_draw_line");
  level endon("stop_draw_line");
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }
  players = get_players();
  while(1) {
    line(players[0].origin, pos, color);
    wait(0.05);
  }
}

speed_check() {
  flag_wait("all_players_connected");
  time = 0.1;
  old_pos = (0, 0, 0);
  players = get_players();
  text = undefined;
  value = undefined;
  for(;;) {
    if(GetDvarInt("debug_speed") < 1) {
      if(isDefined(text)) {
        text Destroy();
      }
      if(isDefined(value)) {
        value Destroy();
      }
      wait(0.1);
      continue;
    }
    wait(time);
    if(!isDefined(text)) {
      text = create_speed_hudelem(false);
    }
    if(!isDefined(value)) {
      value = create_speed_hudelem(true);
    }
    new_pos = players[0].origin;
    speed = int(Distance(new_pos, old_pos) / time);
    value SetValue(speed);
    old_pos = new_pos;
  }
}

create_speed_hudelem(is_value) {
  align_x = "right";
  if(is_value) {
    align_x = "left";
  }
  hud = NewHudElem();
  hud.x = 320;
  hud.y = 450;
  hud.alignX = align_x;
  hud.alignY = "middle";
  hud.sort = 1;
  hud.foreground = true;
  hud.fontScale = 1.75;
  if(is_value) {
    hud SetValue(0);
  } else {
    hud SetText("Speed: ");
  }
  return hud;
}

debug_ai_prints() {
  if(GetDvar("debug_ai_print") == "") {
    SetDvar("debug_ai_print", "0");
  }
  if(GetDvar("debug_ai_print_range") == "") {
    SetDvar("debug_ai_print_range", "1000");
  }
  level.debug_ai_print = false;
  while(1) {
    wait(0.5);
    if(GetDvar("debug_ai_print") == "0") {
      level.debug_ai_print = false;
      continue;
    }
    level.debug_ai_print = true;
    ai = GetAiArray();
    for(i = 0; i < ai.size; i++) {
      ai[i] thread debug_ai_prints_thread();
    }
  }
}

debug_ai_prints_thread() {
  self endon("death");
  if(isDefined(self.ai_print)) {
    return;
  }
  self.ai_print = true;
  while(level.debug_ai_print) {
    range = GetDvarInt("debug_ai_print_range");
    player = get_host();
    if(DistanceSquared(player.origin, self.origin) < range * range) {
      print3d(self.origin + (0, 0, 96), self get_debug_ai_print());
      wait(0.05);
    } else {
      wait(0.2);
    }
  }
  self.ai_print = false;
}

get_debug_ai_print() {
  dvar = GetDvar("debug_ai_print");
  switch (dvar) {
    case "script_noteworthy":
      value = self.script_noteworthy;
      break;
    case "threatbias":
      value = self.threatbias;
      break;
    case "getthreatbiasgroup":
      value = self GetThreatBiasGroup();
      break;
    case "accuracy":
      value = self.accuracy;
      break;
    case "ignoreme":
      value = self.ignoreme;
      break;
    case "ignoreall":
      value = self.ignoreall;
      break;
    case "health":
      value = self.health;
      break;
    case "goalradius":
      value = self.goalradius;
      break;
    case "disablearrivals":
      value = self.disableArrivals;
      break;
    case "disableexits":
      value = self.disableexits;
      break;
    case "moveplaybackrate":
      value = self.moveplaybackrate;
      break;
    case "animname":
      value = self.animname;
      break;
    case "script_forcecolor":
      if(isDefined(self.script_forceColor)) {
        value = self.script_forceColor;
      } else {
        value = "undefined";
      }
      break;
    case "player_seek":
      if(isDefined(self.player_seek)) {
        value = self.player_seek;
      } else {
        value = "undefined";
      }
      break;
    default:
      value = "undefined";
  }
  if(!isDefined(value)) {
    value = "undefined";
  }
  return value;
}

flame_guy_death() {
  self waittill("death");
}

died_by_flame_explosion() {
  self waittill("death");
  if(WeaponClass(self.damageWeapon) == "grenade") {
    attacker = self.attacker;
    if(WeaponType(attacker.weapon) != "gas") {
      return;
    }
    if(!isDefined(attacker.flame_kills)) {
      attacker.flame_kills = 0;
    }
    attacker.flame_kills++;
    if(attacker.flame_kills > 4) {}
  }
}

float_print3d(msg, time, rate) {
  self endon("death");
  time = GetTime() + (time * 1000);
  offset = (0, 0, 72);
  while(GetTime() < time) {
    offset = offset + (0, 0, 2);
    print3d(self.origin + offset, msg, (1, 0, 0));
    wait(0.05);
  }
}

print_notetracks(anime) {
  self endon("death");
  self notify("stop_draw_notetrack");
  self endon("stop_draw_notetrack");
  while(1) {
    self waittill(anime, notetrack);
    self thread float_print3d(anime + ": " + notetrack, 3);
  }
}

do_dialogue(dialogue, lookTarget) {
  if(self == level.sullivan) {
    aname = "sullivan";
  } else if(self == level.roebuck) {
    aname = "roebuck";
  } else {
    aname = "generic";
  }
  self thread maps\_anim::anim_facialFiller("dialogue_done", lookTarget);
  self animscripts\face::SaySpecificDialogue(undefined, level.scr_sound[aname][dialogue], 1.0, "dialogue_done");
  self waittill("dialogue_done");
}

play_explosion_death_anim(origin, angles) {
  guy = spawn_fake_guy(origin, angles, "axis", "generic");
  level thread anim_single_solo(guy, "death_explosion_forward", undefined, guy);
  wait(1);
  guy startragdoll();
}

#using_animtree("generic_human");

spawn_fake_guy(startpoint, startangles, side, animname) {
  guy = spawn("script_model", startpoint);
  guy.angles = startangles;
  {
    guy character\char_jap_makonly_rifle::main();
    guy maps\_drones::drone_axis_assignWeapon_japanese();
    guy.team = "axis";
  }
  guy UseAnimTree(#animtree);
  guy.animname = animname;
  guy makeFakeAI();
  return guy;
}

#using_animtree("generic_human");

collectible_corpse() {
  orig = getstruct("orig_collectible_loop", "targetname");
  corpse = spawn("script_model", orig.origin);
  corpse.angles = orig.angles;
  corpse character\char_jap_makonly_rifle::main();
  corpse detach(corpse.gearModel);
  corpse UseAnimTree(#animtree);
  corpse.animname = "collectible";
  corpse.targetname = "collectible_corpse";
  level thread anim_loop_solo(corpse, "collectible_loop", undefined, "stop_collectible_loop", orig);
}