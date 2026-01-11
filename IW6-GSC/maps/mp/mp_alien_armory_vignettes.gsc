/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_alien_armory_vignettes.gsc
*************************************************/

main() {
  vignette_precache();
  vignettes_startup();
}

vignettes_startup() {
  thread boss_introduction();
}

test_calls() {}

vignette_precache() {
  precachemodel("mp_body_us_rangers_assault_a_urban");
  precachemodel("head_mp_head_a");
  precachemodel("body_extinction_civ_female_a");
  precachemodel("head_extinction_civ_female_a");
}

cross_lab_scene() {
  delay_vo_until_all_clear(20);
  var_0 = getent("crossarcher_lab_doors", "targetname");
  thread lab_scene_marker();
  var_1 = spawn("script_model", (-600, -1561, 720));
  var_1 setModel("body_cross_a");
  var_1.angles = (0, 0, 0);
  var_2 = spawn_model("head_cross_a", var_1, "J_spine4", (0, 0, 0));
  wait 0.25;
  var_3 = spawn("script_model", var_1 gettagorigin("tag_weapon_right"));
  var_3.angles = var_1 gettagangles("tag_weapon_right");
  var_3 setModel("weapon_mp443");
  var_3 linkto(var_1, "tag_weapon_right");
  thread lab_doors_open();
  var_0 scriptmodelplayanim("alien_armory_doors_roomvignette_init");
  thread handle_vo_foley(var_1, "scn_female_glass_hit", 0.46);
  thread handle_vo_foley(var_1, "scn_female_glass_hit", 1.33);
  thread handle_vo_foley(var_1, "scn_female_glass_hit", 1.666);
  thread handle_vo_foley(var_1, "scn_female_glass_hit", 2.2);
  thread handle_vo_foley(var_1, "scn_female_glass_hit", 3.56);
  thread handle_vo_foley(var_1, "scn_female_glass_hit", 4.93);
  thread handle_vo_foley(var_1, "scn_female_glass_hit", 5.6);
  thread handle_vo_foley(var_1, "scn_female_glass_hit", 6.33);
  thread handle_vo_foley(var_1, "scn_female_glass_hit", 7.8);
  thread handle_vo_foley(var_1, "scn_female_glass_hit", 9.06);
  thread handle_vo_foley(var_1, "scn_female_glass_hit", 10);
  thread handle_vo_foley(var_1, "scn_female_glass_hit", 11.133);
  thread handle_vo_foley(var_1, "scn_female_foley_hand_slide", 2);
  var_1 scriptmodelplayanimdeltamotion("alien_armory_cross_roomvignette_init");
  var_2 scriptmodelplayanim("alien_armory_cross_roomvignette_init");
  thread maps\mp\mp_alien_armory_fx::fx_cross_lab_light_on();
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  var_4 = getent("stop_cross_idle", "targetname");
  var_4 thread cross_nags(var_1);
  wait 12.33;
  thread maps\mp\mp_alien_armory_fx::fx_cross_lab_light_flicker();
  var_5 = spawn("script_model", (-425, -1860, 720));
  var_5 setModel("body_archer_a");
  var_5.angles = (0, 0, 0);
  var_6 = spawn_model("head_archer_a", var_5, "J_spine4", (0, 0, 0));
  var_7 = spawn("script_model", var_5 gettagorigin("tag_weapon_right"));
  var_7.angles = var_5 gettagangles("tag_weapon_right");
  var_7 setModel("weapon_mp443");
  var_7 linkto(var_5, "tag_weapon_right");
  var_7 thread lab_gunfire();
  thread lab_scene_vo(var_1, var_5);
  thread aliens_lab_scene();
  thread lab_doors_sfx();
  var_1 scriptmodelplayanimdeltamotion("alien_armory_cross_roomvignette");
  var_2 scriptmodelplayanim("alien_armory_cross_roomvignette");
  thread handle_vo_foley(var_1, "scn_female_foley_hand_slide", 1.5666);
  thread handle_vo_foley(var_1, "scn_female_foley_gun_pickup_raise", 8.2666);
  thread handle_vo_foley(var_1, "scn_female_foley_getting_shot", 16.833);
  thread handle_vo_foley(var_3, "scn_female_foley_gun_drop", 17.466);
  thread handle_vo_foley(var_1, "scn_female_foley_getting_pickedup", 20.166);
  thread handle_vo_foley(var_5, "scn_male_button_slam", 28.3);
  var_5 scriptmodelplayanimdeltamotion("alien_armory_archer_roomvignette");
  var_6 scriptmodelplayanim("alien_armory_archer_roomvignette");
  thread handle_vo_foley(var_5, "scn_male_enter", 13.73);
  thread handle_vo_foley(var_5, "scn_male_approach", 17.933);
  thread handle_vo_foley(var_5, "scn_male_exit", 27.95);
  thread handle_vo_foley(var_5, "scn_male_button_slam", 28.3);
  thread handle_vo_foley(var_5, "scn_male_door_open", 13.2);
  thread handle_vo_foley(var_5, "scn_male_post_lift", 24.06);
  thread handle_vo_foley(var_5, "scn_male_slap", 21.133);
  var_0 scriptmodelplayanim("alien_armory_doors_roomvignette");
  wait 35;
  var_3 delete();
  var_7 delete();
  var_1 delete();
  var_2 delete();
  var_5 delete();
  var_6 delete();
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

lab_alarm1() {
  playsoundatpos((-291, -1665, 846), "scn_arm_mtl_roll_door_alarm");
}

lab_doors_open() {
  playsoundatpos((-668, -1434, 816), "scn_arm_mtl_door_roll_open_l");
  playsoundatpos((-668, -1723, 816), "scn_arm_mtl_door_roll_open_r");
}

lab_doors_sfx() {
  wait 28.6333;
  playsoundatpos((-668, -1434, 816), "scn_arm_mtl_roll_door_l");
  playsoundatpos((-668, -1723, 816), "scn_arm_mtl_roll_door_r");
}

lab_gunfire() {
  wait 17.33;
  thread maps\mp\mp_alien_armory_fx::fx_archer_shoots();
  self playSound("scn_cross_gunshot");
}

aliens_lab_scene() {
  var_0 = maps\mp\gametypes\aliens::addalienagent("axis", (-420, -1867, 594), (0, 0, 0), "wave brute", undefined);
  var_0 maps\mp\alien\_utility::enable_alien_scripted();
  var_0 scragentsetscripted(1);
  var_0.no_outline_on_alien = 1;
  var_0 scragentsetphysicsmode("noclip");
  var_0 scragentsetorientmode("face angle abs", var_0.angles);
  var_0 thread animate_alien(0);
  thread play_sound_alien(33.3666, "scn_cross_left_alien_vocals", var_0.origin, var_0);
  thread play_sound_alien(30.966, "scn_cross_left_alien_door_burst", (-475, -1332, 780), undefined);
  var_1 = maps\mp\gametypes\aliens::addalienagent("axis", (-464, -1270, 720), (0, 0, 0), "wave brute", undefined);
  var_1 maps\mp\alien\_utility::enable_alien_scripted();
  var_1 scragentsetscripted(1);
  var_1.no_outline_on_alien = 1;
  var_1 scragentsetphysicsmode("noclip");
  var_1 scragentsetorientmode("face angle abs", var_1.angles);
  var_1 thread animate_alien(1);
  thread play_sound_alien(31.8333, "scn_cross_right_alien_door_burst", (-428, -1806, 780), undefined);
  thread play_sound_alien(33.1666, "scn_cross_right_alien_vocals", var_1.origin, var_1);
}

play_sound_alien(var_0, var_1, var_2, var_3) {
  wait(var_0);

  if(!isDefined(var_3)) {
    playsoundatpos(var_2, var_1);
  }
  else {
    var_3 playsoundonmovingent(var_1);
  }
}

animate_alien(var_0) {
  self scragentsetanimmode("anim deltas");
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("armory_vignettes", var_0, "armory_vignettes", "end");
  wait 5;
  self hide();
  self suicide();
}

cross_armory_exit() {
  var_0 = [];
  var_1 = getent("archer_escape", "targetname");
  var_1 waittill("trigger");
  var_2 = maps\mp\agents\alien\_alien_human::alienhumanspawn((-2903.6, 1437, 663.2), (0, 107.554, 0), "body_cross_a", "head_cross_a");
  var_2 scragentsetscripted(1);
  var_2 scragentsetphysicsmode("noclip");
  var_2 scragentsetorientmode("face angle abs", var_2.angles);
  var_3 = maps\mp\agents\alien\_alien_human::alienhumanspawn((-2904.4, 1442.5, 663.2), (0, -12.343, 0), "body_archer_a", "head_archer_a");
  var_3 scragentsetscripted(1);
  var_3 scragentsetphysicsmode("noclip");
  var_3 scragentsetorientmode("face angle abs", var_3.angles);
  var_4 = spawn("script_model", (-2700.3, 1514.7, 663.5));
  var_4 setModel("vehicle_gaz71_iw6_dlc");
  var_4.angles = (0, 33.871, 0);
  thread final_hive_vo();
  var_4 thread archer_exfil_sfx_spawn();
  var_4 scriptmodelplayanimdeltamotion("alien_armory_gaz71_exit_facility");
  thread gate_close();
  var_2 thread animate_human(2);
  var_3 animate_human(3);
  var_4 delete();
}

archer_exfil_sfx_spawn() {
  wait 0.02;
  self playsoundonmovingent("scn_archer_exfil");
}

gate_close() {
  wait 12;
  var_0 = getent("rolling_gate", "targetname");

  if(isDefined(var_0)) {
    var_0 thread archer_exfil_gate_close_sfx_spawn();
    var_0 moveto((-648, 1956, 592), 2, 0, 1);
  }
}

archer_exfil_gate_close_sfx_spawn() {
  wait 0.02;
  self playsoundonmovingent("scn_archer_exfil_gate_close");
}

animate_human(var_0, var_1) {
  self scragentsetanimmode("anim deltas");
  maps\mp\agents\alien\_alien_human::playanimation("idle", var_0);
  self hide();

  if(isDefined(var_1) && var_1 == 1) {
    return;
  }
  self suicide();
  return;
}

boss_introduction() {
  thread intro_music();
  wait 2;
  var_0 = getEntArray("intro_fence", "targetname");
  var_1 = getscriptablearray("intro_fence_script", "targetname");
  intro_vo();
  var_2 = spawn("script_model", (-2160, -7364.86, 607.431));
  var_2 setModel("mp_body_us_rangers_assault_a_urban");
  var_2.angles = (0, -90, 0);
  var_3 = spawn("script_model", var_2 gettagorigin("J_spine4"));
  var_3.angles = var_2 gettagangles("J_spine4");
  var_3 setModel("head_mp_head_a");
  var_3 linkto(var_2, "J_spine4");
  var_4 = spawn("script_model", var_2 gettagorigin("tag_weapon_right"));
  var_4.angles = var_2 gettagangles("tag_weapon_right");
  var_4 setModel("weapon_rm_22");
  var_4 hidepart("tag_barrel_sniper", "weapon_rm_22");
  var_4 linkto(var_2, "tag_weapon_right");
  thread redshirt_vo();
  thread spider_tunnel();
  var_4 thread gunswap();
  var_2 thread add_loot_drops_around_body();
  var_2 scriptmodelplayanimdeltamotion("alien_redshirt_intro_tunnel");
  var_3 scriptmodelplayanim("alien_redshirt_intro_tunnel");
  var_1[0] setscriptablepartstate(0, 2);
  level.gate_is_open = 1;
  thread sfx_intro();
  wait 15.8333;
  thread knockback_players(var_2);

  foreach(var_6 in var_0) {
    if(isDefined(var_6)) {
      var_6 delete();
    }
  }

  wait 2.93;
  thread pre_set_scriptables();
  var_1[0] setscriptablepartstate(0, 3);
  godfather_hive_explain_vo();
}

gunswap() {
  wait 15.866;
  self unlink();
  var_0 = common_scripts\utility::getstructarray("item", "targetname");
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(var_3.script_noteworthy == "weapon_iw6_aliendlc15_mp") {
      var_1 = var_3.use_ent;
      break;
    }
  }

  var_1.origin = self.origin + (0, 0, 5);
  var_1.angles = self.angles;
  var_1 hidepart("tag_barrel_sniper", "weapon_rm_22");
  self delete();
}

add_loot_drops_around_body() {
  wait 18;
  var_0 = spawn("script_origin", self.origin);
  var_1 = -50;
  var_2 = 50;
  var_3 = var_0.origin;
  var_0.origin = var_3 + (var_1 + randomint(40), var_2 + randomint(40), 0);
  var_0 thread maps\mp\mp_alien_armory::create_dropped_pillage_item("clip", level.pillageinfo.clip_model, 1);
  var_0.origin = var_3 + (var_1 + randomint(40), var_2 + randomint(40), 0);
  var_0 thread maps\mp\mp_alien_armory::create_dropped_pillage_item("clip", level.pillageinfo.clip_model, 1);
  var_0.origin = var_3 + (var_1 + randomint(40), var_2 + randomint(40), 0);
  var_0 thread maps\mp\mp_alien_armory::create_dropped_pillage_item("explosive", "tag_origin", 1, "aliensemtex_mp", 2);
  var_0.origin = var_3 + (var_1 + randomint(40), var_2 + randomint(40), 0);
  var_0 thread maps\mp\mp_alien_armory::create_dropped_pillage_item("explosive", "tag_origin", 1, "aliensemtex_mp", 2);
}

spider_tunnel() {
  var_0 = maps\mp\agents\alien\alien_spider\_alien_spider::alienspiderspawn((-2375, -7784.86, 977.432), (0, 0, 0));
  var_0 maps\mp\alien\_utility::set_alien_emissive(0.2, 1);
  var_0 maps\mp\alien\_utility::enable_alien_scripted();
  var_0 scragentsetscripted(1);
  var_0 scragentsetphysicsmode("noclip");
  var_0 scragentsetorientmode("face angle abs", var_0.angles);
  var_0 scragentsetanimmode("anim deltas");
  var_0 thread maps\mp\mp_alien_armory_fx::fx_intro_tunnel_stab();
  var_0 maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("tunnel_intro", 0, "tunnel_intro", "end");
  var_0 maps\mp\alien\_utility::set_alien_emissive(0.2, 0);
  var_0 hide();
  var_0.vignette_death_skip = 1;
  var_0 maps\mp\agents\alien\alien_spider\_alien_spider::alienspiderkilled();
  var_0 suicide();
}

sfx_intro() {
  wait 4;
  level.sfx_intro_guard = spawn("script_origin", (-2290, -7778, 664));
  level.sfx_intro_guard playSound("scn_intro_guard");
  wait 3.3;

  foreach(var_1 in level.players) {
  var_1 playSound("scn_intro_spider");
  }

  wait 15;
  level.sfx_intro_guard delete();
}

first_spider_fence() {
  var_0 = getscriptablearray("fence_blocker_01", "targetname");
  var_0[0] setscriptablepartstate(0, 1);
}

knockback_players(var_0) {
  foreach(var_2 in level.players) {
    if(distance(var_2.origin, var_0.origin) <= 128) {
      var_2 setvelocity(vectornormalize(var_2.origin - var_0.origin) * 800);
      var_2 dodamage(var_2.maxhealth / 3, var_0.origin);
    }
  }
}

spider_exit_a_props() {
  var_0 = getscriptablearray("armory_alien_rail_a", "targetname");
  var_0[0] setscriptablepartstate(0, 1);
  var_1 = getscriptablearray("antenna_retreat_event_a", "targetname");
  var_1[0] setscriptablepartstate(0, 1);
}

spider_entrance_b() {
  wait 3;
  level.spider = maps\mp\agents\alien\alien_spider\_alien_spider::alienspiderspawn((-1138.05, -2542.5, 565.487), (0, 0, 0));
  level.spider maps\mp\alien\_utility::set_alien_emissive(0.2, 1);
  level.spider maps\mp\alien\_utility::enable_alien_scripted();
  level.spider scragentsetscripted(1);
  level.spider scragentsetphysicsmode("noclip");
  level.spider scragentsetorientmode("face angle abs", level.spider.angles);
  level thread maps\mp\mp_alien_armory_fx::fx_spider_entrance_b();
  level.spider scragentsetanimmode("anim deltas");
  var_0 = getscriptablearray("antenna_event_02", "targetname");
  var_0[0] setscriptablepartstate(0, 2);
  var_1 = getscriptablearray("armory_alien_rail_b", "targetname");
  var_1[0] setscriptablepartstate(0, 2);
  level.spider maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("retreat", 1, "retreat", "end");
}

spider_posture_b() {}

spider_exit_b() {
  level.spider maps\mp\alien\_utility::enable_alien_scripted();
  level.spider scragentsetscripted(1);
  level.spider scragentsetphysicsmode("noclip");
  level.spider scragentsetorientmode("face angle abs", level.spider.angles);
  var_0 = getscriptablearray("antenna_event_02", "targetname");
  var_0[0] setscriptablepartstate(0, 3);
  var_1 = getscriptablearray("armory_alien_rail_b", "targetname");
  var_1[0] setscriptablepartstate(0, 3);
  level thread maps\mp\mp_alien_armory_fx::fx_spider_exit_b();
  level.spider scragentsetanimmode("anim deltas");
  level.spider maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("retreat", 2, "retreat", "end");
  level.spider.vignette_death_skip = 1;
  level.spider suicide();
}

spider_entrance_c() {
  if(!isDefined(level.jumped_to_final_boss) || level.jumped_to_final_boss == 0) {
    thread cross_armory_exit();
    common_scripts\utility::flag_wait("start_spider_encounter");
  }

  wait 10;
  level.spider = maps\mp\agents\alien\alien_spider\_alien_spider::alienspiderspawn((-300, 3140, 967), (0, 0, 0));
  level.spider maps\mp\alien\_utility::set_alien_emissive(0.2, 1);
  level.spider maps\mp\alien\_utility::enable_alien_scripted();
  level.spider scragentsetscripted(1);
  level.spider scragentsetphysicsmode("noclip");
  level.spider scragentsetorientmode("face angle abs", level.spider.angles);
  thread maps\mp\mp_alien_armory_fx::fx_spider_impact_big();
  level.spider scragentsetanimmode("anim deltas");
  wait 0.1;
  level.spider maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("retreat", 3, "retreat", "end");
  level.spider maps\mp\alien\_utility::disable_alien_scripted();
  level.spider scragentsetscripted(0);
  level.spider maps\mp\alien\_utility::set_alien_emissive(0.2, 0);
}

intro_music() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread intro_music_play();
  }
}

intro_music_play() {
  self waittill("spawned_player");

  foreach(var_1 in level.players) {
    if(common_scripts\utility::flag("alien_music_playing")) {
      var_1 stoplocalsound("mp_suspense_01");
      var_1 stoplocalsound("mp_suspense_02");
      var_1 stoplocalsound("mp_suspense_03");
      var_1 stoplocalsound("mp_suspense_04");
      var_1 stoplocalsound("mp_suspense_05");
      var_1 stoplocalsound("mp_suspense_06");
      var_1 stoplocalsound("us_spawn_music");
      var_1 stoplocalsound("mus_alien_newwave");
      common_scripts\utility::flag_clear("alien_music_playing");
    }

    if(!common_scripts\utility::flag("exfil_music_playing")) {
      wait 0.01;
    }

    level thread maps\mp\alien\_music_and_dialog::play_alien_music("mus_alien_dlc1_armory_intro");
    wait 0.1;
  }
}

intro_vo() {
  wait 4;
}

godfather_hive_explain_vo() {
  wait 2;
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  play_sound_on_player("armory_god_2_1_1");
  wait 12;
  play_sound_on_player("armory_god_2_1_2");
  wait 9;
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

godfather_area_1_first() {
  delay_vo_until_all_clear();
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  play_sound_on_player("armory_god_2_2_1");
  wait 10;
  play_sound_on_player("armory_god_2_2_2");
  wait 4;
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
  thread security_room_vo();
}

godfather_area_1_midway() {}

area_1_final_hive() {
  var_0 = distance(level.drill.origin, (-3653, -6322, 859));

  if(var_0 >= 256) {
    delay_vo_until_all_clear(10);
    thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
    play_sound_on_player("armory_god_2_3_1");
    wait 7.75;
    play_sound_on_player("armory_god_2_3_2");
    wait 2.75;
    play_sound_on_player("armory_god_2_3_3");
    wait 5;
    thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
  }
}

post_first_boss_vo() {
  delay_vo_until_all_clear();
  wait 5;
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  play_sound_on_player("armory_god_5_1");
  wait 11.25;
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

pre_second_boss_vo() {
  delay_vo_until_all_clear();
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  play_sound_on_player("armory_cross_5_3");
  wait 6.8;
  play_sound_on_player("armory_cross_5_5");
  wait 2.5;
  play_sound_on_player("armory_cross_5_6");
  wait 5.2;
  play_sound_on_player("armory_cross_5_6_1");
  wait 2;
  thread cross_office_vo();
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

cross_office_vo() {
  var_0 = getent("cross_office_VO", "targetname");
  var_0 waittill("trigger");
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  play_sound_on_player("armory_cross_6_2");
  wait 5.5;
  play_sound_on_player("armory_cross_6_3");
  wait 2.25;
  play_sound_on_player("armory_cross_6_4");
  wait 2.5;
  play_sound_on_player("armory_cross_6_8");
  wait 3.5;
  var_0 delete();
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

lab_scene_vo(var_0, var_1) {
  wait 0.8;
  var_0 playSound("armory_cross_7_6");
  thread lab_scene_music();
  wait 1.2;
  var_0 playSound("armory_cross_7_7");
  wait 6.46;
  var_0 playSound("armory_cross_7_8");
  wait 9.4;
  var_0 playSound("armory_cross_7_9");
  wait 3.3;
  var_1 playSound("armory_arc_7_10");
  wait 5;
}

lab_scene_music() {
  wait 1.2;

  foreach(var_1 in level.players) {
    if(common_scripts\utility::flag("alien_music_playing")) {
      var_1 stoplocalsound("mp_suspense_01");
      var_1 stoplocalsound("mp_suspense_02");
      var_1 stoplocalsound("mp_suspense_03");
      var_1 stoplocalsound("mp_suspense_04");
      var_1 stoplocalsound("mp_suspense_05");
      var_1 stoplocalsound("mp_suspense_06");
      var_1 stoplocalsound("mus_alien_newwave");
      common_scripts\utility::flag_clear("alien_music_playing");
    }

    level thread maps\mp\alien\_music_and_dialog::play_alien_music("mus_alien_dlc1_scn_cross");
  }
}

final_hive_vo() {
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  play_sound_on_player("armory_god_8_1");
  thread play_third_spider_music();
  wait 4.75;
  play_sound_on_player("armory_god_8_2");
  wait 4;
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

play_third_spider_music() {
  wait 3;

  foreach(var_1 in level.players) {
    if(common_scripts\utility::flag("alien_music_playing")) {
      var_1 stoplocalsound("mp_suspense_01");
      var_1 stoplocalsound("mp_suspense_02");
      var_1 stoplocalsound("mp_suspense_03");
      var_1 stoplocalsound("mp_suspense_04");
      var_1 stoplocalsound("mp_suspense_05");
      var_1 stoplocalsound("mp_suspense_06");
      var_1 stoplocalsound("mus_alien_newwave");
      common_scripts\utility::flag_clear("alien_music_playing");
    }

    if(!common_scripts\utility::flag("exfil_music_playing")) {
      level thread maps\mp\alien\_music_and_dialog::play_alien_music("mus_alien_dlc1_archer_exfil");
    }
  }
}

redshirt_vo() {
  var_0 = spawn("script_origin", (-2304, -7666, 652));
  wait 3.9;
  level notify("spawn_intro_drill");
  var_0 playSound("armory_grd_1_1");
  wait 2.63;
  var_0 playSound("armory_grd_1_2");
  wait 4.47;
  var_0 playSound("armory_grd_1_3");
  thread spider_intro_screen_shake(var_0);
  wait 2.56;
  var_0 playSound("armory_grd_1_4");
  common_scripts\utility::flag_set("intro_sequence_complete");
  wait 4;
  spider_intro_screen_shake_exit(var_0);
  var_0 delete();
}

spider_intro_screen_shake(var_0) {
  var_1 = 0.1;

  for(var_2 = 0; var_2 < 6; var_2++) {
    earthquake(var_1, 0.4, var_0.origin, 768);
    playrumbleonposition("grenade_rumble", var_0.origin);
    var_1 = var_1 + 0.05;

    if(var_2 > 1) {
      common_scripts\utility::exploder(120);
    }

    wait 0.6;
  }
}

spider_intro_screen_shake_exit(var_0) {
  var_1 = 0.4;

  for(var_2 = 0; var_2 < 6; var_2++) {
    earthquake(var_1, 0.4, var_0.origin, 768);
    playrumbleonposition("grenade_rumble", var_0.origin);
    var_1 = var_1 - 0.05;

    if(var_2 < 3) {
      common_scripts\utility::exploder(120);
    }

    wait 0.6;
  }
}

post_final_boss_vo() {
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  wait 11.75;
  play_sound_on_player("armory_god_9_1");
  wait 5;
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

cross_nags(var_0) {
  self endon("stop_nags");
  wait 0.7;
  var_0 playSound("armory_cross_7_1");
  wait 3.26;
  var_0 playSound("armory_cross_7_2");
  wait 2;
  var_0 playSound("armory_cross_7_3");
  wait 1.57;
  var_0 playSound("armory_cross_7_4");
  wait 1.23;
  var_0 playSound("armory_cross_7_5");
}

security_room_vo() {
  var_0 = getent("security_room_vo_trigger", "targetname");
  var_0 waittill("trigger");
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  var_1 = spawn("script_origin", (-3354, -6616, 808));
  var_1 playSound("armory_arc_3_1");
  wait 6.5;
  var_1 playSound("armory_god_3_2");
  wait 1.5;
  var_1 playSound("armory_arc_3_3");
  wait 4.5;
  var_1 playSound("armory_god_3_4");
  wait 4.5;
  var_1 playSound("armory_arc_3_5");
  wait 5;
  level notify("cinematic_end");
  var_1 delete();
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

delay_vo_until_all_clear(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 30;
  }

  var_1 = gettime();
  var_2 = var_1 - var_0 * 1000;

  while(var_2 <= var_1) {
    var_2 = var_1 - var_0 * 1000;
    var_3 = 0;

    foreach(var_5 in level.agentarray) {
      if(isDefined(var_5)) {
        if(isalive(var_5)) {
          if(var_5.team == "axis" && isDefined(var_5.alien_type) && var_5.alien_type != "spider") {
            var_3 = 1;
            break;
          }
        }
      }
    }

    if(var_3 == 0) {
      return;
    }
    wait 0.5;
  }
}

play_vignette_vo(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    var_1 = "high";
  }

  if(!isDefined(var_2)) {
    var_2 = 30;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0.25;
  }

  foreach(var_6 in level.players) {
    var_6 maps\mp\alien\_music_and_dialog::play_vo_on_player(var_0, var_1, var_2, var_3, var_4);
    break;
  }
}

gate_check() {}

spawn_model(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", (0, 0, 0));
  var_4 setModel(var_0);
  var_4.origin = var_1 gettagorigin(var_2);
  var_4.angles = var_1 gettagangles(var_2) + var_3;
  var_4 linkto(var_1, var_2);
  return var_4;
}

lab_scene_marker() {
  var_0 = "waypoint_alien_blocker";
  var_1 = 14;
  var_2 = 14;
  var_3 = 0.5;
  var_4 = (-906, -1570, 780);
  var_5 = 49;
  var_6 = 256;
  var_7 = 100;
  var_8 = maps\mp\alien\_hud::make_waypoint(var_0, var_1, var_2, var_3, var_4);
  var_9 = spawn("trigger_radius", var_4, 0, var_6, var_7);
  var_9 thread watch_trigger_by_player();
  var_9 common_scripts\utility::waittill_any_timeout(var_5, "trigger_by_player");
  var_9 delete();
  var_8 destroy();
}

watch_trigger_by_player() {
  self endon("death");
  level endon("game_ended");
  common_scripts\utility::waitframe();

  for(;;) {
    self waittill("trigger", var_0);

    if(isplayer(var_0)) {
      break;
    }
  }

  self notify("trigger_by_player");
}

handle_vo_foley(var_0, var_1, var_2) {
  wait(var_2);
  var_0 playSound(var_1);
}

pre_set_scriptables() {
  var_0 = getscriptablearray("armory_alien_rail_a", "targetname");
  var_0[0] setscriptablepartstate(0, 4);
  var_1 = getscriptablearray("antenna_retreat_event_a", "targetname");
  var_1[0] setscriptablepartstate(0, 4);
}

queen_hole_marker() {
  var_0 = "waypoint_alien_blocker";
  var_1 = 14;
  var_2 = 14;
  var_3 = 0.5;
  var_4 = (-3271, 135, 841);
  var_5 = 49;
  var_6 = 256;
  var_7 = 100;
  var_8 = maps\mp\alien\_hud::make_waypoint(var_0, var_1, var_2, var_3, var_4);
  var_9 = spawn("trigger_radius", var_4, 0, var_6, var_7);
  var_9 thread watch_trigger_by_player();
  var_9 common_scripts\utility::waittill_any_timeout(var_5, "trigger_by_player");
  var_9 delete();
  var_8 destroy();
}

play_sound_on_player(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      var_2 playSound(var_0);
      break;
    }
  }
}