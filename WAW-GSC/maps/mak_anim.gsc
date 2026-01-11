/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mak_anim.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#using_animtree("generic_human");

main() {
  level.scr_anim["collectible"]["collectible_loop"][0] = % death_pose_on_desk;
  event1();
  event2();
  event3();
  event4();
  event5();
  event6();
  player_anims();
  patrol_anims();
  run_anims();
  geo_hut1_collapse();
  geo_hut4_pieces();
  geo_intro_hut_light();
  geo_under_hut_collapse();
  geo_guy_to_shed();
  geo_event4_gates();
  geo_event5_bunkerdoor();
  geo_event1_door_collapse();
  model_event4_tower();
  event1_mg_tarp();
  event2_mg_net();
  vehicle_anims();
}

run_anims() {
  level.scr_anim["generic"]["roebuck_run"] = % ai_roebuck_run;
  level.scr_anim["generic"]["sullivan_run"] = % ai_sullivan_run;
  level.scr_anim["generic"]["jog1"] = % ch_makinraid_creepy_run_guy1;
  level.scr_anim["generic"]["jog2"] = % ch_makinraid_creepy_run_guy2;
  level.scr_anim["generic"]["jog_right"] = % ch_makinraid_creepy_run_guy3;
  level.scr_anim["generic"]["jog_left"] = % ch_makinraid_creepy_run_guy4;
  level.scr_anim["generic"]["jog_sprint"] = % ai_sprint_1cycle;
  level.scr_anim["generic"]["jog_idle"][0] = % ch_makinraid_creepywalk_idle_center2;
  level.scr_anim["generic"]["jog_stop"] = % ch_makinraid_creepywalk_stop_center2;
  level.scr_anim["generic"]["jog_start"] = % ch_makinraid_creepywalk_start_center2;
}

event1() {
  level.scr_anim["mitch"]["intro"] = % ch_makinraid_intro_mitch;
  level.scr_anim["mitch"]["death"] = % ch_makinraid_intro_mitch_dead;
  addnotetrack_customfunction("mitch", "knife_slash", ::event1_mitch_slash, "intro");
  addnotetrack_customfunction("mitch", "blood_pool", ::event1_mitch_blood_pool, "intro");
  addnotetrack_fxontag("mitch", "intro", "spit", "spit", "TAG_EYE");
  addnotetrack_sound("mitch", "spit", "intro", "spit");
  addnotetrack_dialogue("mitch", "hit", "intro", "MITCH_Scream_01");
  addnotetrack_dialogue("mitch", "hit", "intro", "MITCH_Scream_02");
  addnotetrack_dialogue("mitch", "hit", "intro", "MITCH_Scream_03");
  addnotetrack_dialogue("mitch", "hit", "intro", "MITCH_Scream_03b");
  addnotetrack_dialogue("mitch", "dialog", "intro", "Mak1_INT_003A_MITC", "null");
  addnotetrack_dialogue("mitch", "scream", "intro", "MITCH_Scream_05");
  addnotetrack_dialogue("mitch", "knife_slash", "intro", "MITCH_ThroatSlit_02");
  addnotetrack_customfunction("mitch", "hit", ::mitch_beatstick_hit, "intro");
  level.scr_anim["roebuck"]["intro"] = % ch_makinraid_intro_roebuck;
  addnotetrack_customfunction("roebuck", "sullivan_start", ::event1_intro_sullivan_start, "intro");
  addnotetrack_customfunction("roebuck", "give_gun", ::recall_gun, "intro");
  addnotetrack_customfunction("roebuck", "flashlight_on", ::event1_flashlight, "intro");
  addnotetrack_customfunction("roebuck", "flashlight_off", ::event1_flashlight_off, "intro");
  addnotetrack_detach("roebuck", "detach_knife", "viewmodel_usa_kbar_knife", "tag_inhand", "intro");
  addnotetrack_attach("roebuck", "attach_flashlight", "clutter_makin_flashlight", "tag_weapon_left", "intro");
  addnotetrack_detach("roebuck", "detach_flashlight", "clutter_makin_flashlight", "tag_weapon_left", "intro");
  addnotetrack_dialogue("roebuck", "dialog", "intro", "Mak1_INT_007B_ROEB");
  addnotetrack_dialogue("roebuck", "dialog", "intro", "Mak1_INT_010B_ROEB", "null");
  level.scr_sound["roebuck"]["help_ryan"] = "Mak1_IGD_507A_ROEB";
  level.scr_sound["roebuck"]["save_ryan"] = "Mak1_IGD_508A_ROEB";
  level.scr_sound["roebuck"]["too_late"] = "Mak1_IGD_509A_ROEB";
  level.scr_anim["sullivan"]["intro"] = % ch_makinraid_intro_sullivan;
  addnotetrack_attach("sullivan", "attach_nambo", "weapon_jap_nambu_pistol", "tag_weapon_left", "intro");
  addnotetrack_detach("sullivan", "detach_nambo", "weapon_jap_nambu_pistol", "tag_weapon_left", "intro");
  addnotetrack_customfunction("sullivan", "attach_helmet", ::event1_give_nambo, "intro");
  addnotetrack_attach("sullivan", "attach_helmet", "clutter_peleliu_us_helmet", "tag_inhand", "intro");
  addnotetrack_customfunction("sullivan", "attach_helmet", ::event1_delete_helmet, "intro");
  addnotetrack_detach("sullivan", "detach_helmet", "clutter_peleliu_us_helmet", "tag_inhand", "intro");
  addnotetrack_custom("sullivan", "intro", "detach_shotgun", "detach gun", true, "tag", "tag_weapon_right");
  addnotetrack_custom("sullivan", "intro", "attach_shotgun", "attach gun right", true, "tag", "tag_weapon_right");
  addnotetrack_customfunction("sullivan", "dialog", ::event1_set_objective, "intro");
  addnotetrack_dialogue("sullivan", "dialog", "intro", "undefined");
  addnotetrack_dialogue("sullivan", "dialog", "intro", "Mak1_INT_014A_SULL");
  addnotetrack_dialogue("sullivan", "dialog", "intro", "Mak1_INT_015A_SULL");
  addnotetrack_dialogue("sullivan", "dialog", "intro", "Mak1_INT_016A_SULL");
  level.scr_anim["interogator"]["intro"] = % ch_makinraid_intro_interogator;
  level.scr_anim["interogator"]["death"] = % ch_makinraid_intro_interogator_dead;
  addnotetrack_detach("interogator", "detach_stick", "weapon_jap_beating_stick", "tag_weapon_right", "intro");
  addnotetrack_attach("interogator", "attach_knife", "weapon_jap_katana_short", "tag_inhand", "intro");
  addnotetrack_customfunction("interogator", "roebuck_start", ::event1_intro_roebuck_start, "intro");
  addnotetrack_customfunction("interogator", "hit_lamp", ::anim_intro_shed_light, "intro");
  addnotetrack_dialogue("interogator", "dialog", "intro", "Mak1_INT_100A_JINT");
  level.scr_anim["intro_officer"]["intro"] = % ch_makinraid_intro_officer_a;
  level.scr_anim["intro_officer"]["intro2"] = % ch_makinraid_intro_officer_b;
  level.scr_anim["intro_officer"]["death"] = % ch_makinraid_intro_officer_b_dead;
  addnotetrack_fxontag("intro_officer", "intro", "exhale", "cigarette_exhale", "TAG_EYE");
  addnotetrack_fxontag("intro_officer", "intro", "smoke", "cigarette_glow_puff", "tag_efx");
  addnotetrack_fxontag("intro_officer", "intro", "ember_fx", "cigarette_embers", "tag_efx");
  addnotetrack_sound("intro_officer", "intro", "exhale", "smoking_exhale");
  addnotetrack_sound("intro_officer", "exhale", "intro", "smoking_exhale");
  addnotetrack_sound("intro_officer", "intro", "smoke", "smoking_inhale");
  addnotetrack_sound("intro_officer", "deep_smoke", "intro", "smoking_inhale");
  addnotetrack_fxontag("intro_officer", "intro", "deep_smoke", "cigarette_glow_puff2", "tag_efx");
  addnotetrack_sound("intro_officer", "intro", "deep_smoke", "smoking_inhale");
  addnotetrack_dialogue("intro_officer", "dialog", "intro", "Mak1_INT_000A_JPOF");
  addnotetrack_dialogue("intro_officer", "dialog", "intro", "Mak1_INT_001A_JPOF");
  addnotetrack_dialogue("intro_officer", "dialog", "intro", "Mak1_INT_002A_JPOF");
  addnotetrack_dialogue("intro_officer", "dialog", "intro", "Mak1_INT_004A_JPOF");
  addnotetrack_dialogue("intro_officer", "dialog", "intro", "Mak1_INT_005A_JPOF");
  level.scr_anim["pow1"]["intro"] = % ch_makinraid_intro_pow1;
  level.scr_anim["pow2"]["intro"] = % ch_makinraid_intro_pow2;
  level.scr_anim["pow3"]["intro"] = % ch_makinraid_intro_pow3;
  level.scr_anim["pow1"]["loop"][0] = % ch_makinraid_tied_pow1;
  level.scr_anim["pow2"]["death"] = % ch_makinraid_tied_pow2;
  level.scr_anim["pow3"]["loop"][0] = % ch_makinraid_tied_pow3;
  level.scr_anim["pow_beater1"]["intro"] = % ch_makinraid_intro_japanese1;
  level.scr_anim["pow_beater2"]["intro"] = % ch_makinraid_intro_japanese2;
  level.scr_anim["intro_redshirt1"]["intro"] = % ch_makinraid_intro_redshirt1;
  level.scr_anim["intro_redshirt2"]["intro"] = % ch_makinraid_intro_redshirt2;
  level.scr_anim["generic"]["rescue_pow_cycle1"] = % ch_makinraid_rescue_medic1;
  level.scr_anim["generic"]["rescue_pow_cycle2"] = % ch_makinraid_rescue_medic2;
  level.scr_anim["rescuer1"]["castoff"] = % ch_makinraid_rescue_medic1_castoff;
  level.scr_anim["rescuer2"]["castoff"] = % ch_makinraid_rescue_medic2_castoff;
  level.scr_anim["rescued_pow1"]["castoff"] = % ch_makinraid_rescue_pow1_castoff;
  level.scr_anim["rescued_pow2"]["castoff"] = % ch_makinraid_rescue_pow2_castoff;
  level.scr_anim["rescuer1"]["idle"][0] = % ch_makinraid_rescue_medic1_castoff_idle;
  level.scr_anim["rescuer2"]["idle"][0] = % ch_makinraid_rescue_medic2_castoff_idle;
  level.scr_anim["rescued_pow1"]["idle"][0] = % ch_makinraid_rescue_pow1_castoff_idle;
  level.scr_anim["rescued_pow2"]["idle"][0] = % ch_makinraid_rescue_pow2_castoff_idle;
  level.scr_anim["rescued_pow1"]["run"] = % ch_makinraid_rescue_pow1;
  level.scr_anim["rescued_pow2"]["run"] = % ch_makinraid_rescue_pow2;
  level.scr_sound["sullivan"]["up_the_walkway"] = "Mak1_IGD_511A_SULL";
  level.scr_sound["sullivan"]["after_ryan_save"] = "Mak1_IGD_512A_SULL";
  level.scr_anim["ally_pond_fighter"]["pond_fight_loop"][0] = % ch_makinraid_coy_pond_fight1_US_loop;
  level.scr_anim["ally_pond_fighter"]["pond_fight_out"] = % ch_makinraid_coy_pond_fight2_US;
  level.scr_anim["axis_pond_fighter"]["pond_fight_loop"][0] = % ch_makinraid_coy_pond_fight1_Jap_loop;
  level.scr_anim["axis_pond_fighter"]["pond_fight_out"] = % ch_makinraid_coy_pond_fight2_Jap;
  level.scr_anim["2vs1_ally_1"]["traverse"] = % ch_makinraid_traverse40_in_l;
  level.scr_anim["2vs1_ally_2"]["traverse"] = % ch_makinraid_traverse40_in_ml;
  level.scr_anim["boatsquad1_1"]["vignette"] = % ch_makinraid_lmg_mowdown_guy1;
  level.scr_anim["boatsquad1_2"]["vignette"] = % ch_makinraid_lmg_mowdown_guy2;
  level.scr_anim["boatsquad1_3"]["vignette"] = % ch_makinraid_lmg_mowdown_guy3;
  level.scr_anim["boatsquad1_4"]["vignette"] = % ch_makinraid_lmg_mowdown_guy4;
  level.scr_anim["ally_showdown"]["vignette"] = % ch_makinraid_showdown_guy1;
  addnotetrack_customfunction("ally_showdown", "attach_gun_right", ::holster_weapon_switch_to_sidearm, "vignette");
  addnotetrack_customfunction("ally_showdown", "fire", ::showdown_fire, "vignette");
  addnotetrack_customfunction("ally_showdown", "detach_pistol", ::holster_sidearm_switch_to_weapon, "vignette");
  addnotetrack_dialogue("ally_showdown", "dialog", "vignette", "Mak1_IGD_004A_USR4", "null");
  level.scr_anim["axis_showdown"]["vignette"] = % ch_makinraid_showdown_guy2;
  addnotetrack_customfunction("axis_showdown", "door_open", ::showdown_hut_door, "vignette");
  addnotetrack_sound("axis_showdown", "door_open", "vignette", "door_bash_open");
  level.scr_anim["axis_hut_collapse"]["vignette"] = % ch_makinraid_fire_hut;
  level.scr_anim["axis_hut_collapse"]["death"] = % ch_makinraid_fire_hut_dead;
  addnotetrack_customfunction("axis_hut_collapse", "collapse", ::anim_under_hut_collapse, "vignette");
  level.scr_anim["guy_2_shed"]["vignette"] = % ch_makinraid_blown_into_shed;
  level.scr_sound["guy_2_shed"]["vignette"] = "japanese_yell_hut";
  addnotetrack_customfunction("guy_2_shed", "collapse", ::anim_guy_to_shed, "vignette");
  addnotetrack_sound("guy_2_shed", "collapse", "vignette", "shed_break");
  level.scr_anim["axis1_held_down"]["vignette"] = % ch_makinraid_held_down_head_shot_guy1;
  addnotetrack_customfunction("axis1_held_down", "attach_gun", ::recall_gun, "vignette");
  addnotetrack_dialogue("axis1_held_down", "dialog", "vignette", "Mak1_IGD_006A_USR2", "null");
  level.scr_anim["axis2_held_down"]["vignette"] = % ch_makinraid_held_down_head_shot_guy2;
  addnotetrack_customfunction("axis2_held_down", "fire", ::held_guy_blood_Fx, "vignette");
  addnotetrack_dialogue("axis2_held_down", "dialog", "vignette", "Mak1_IGD_007A_USR1", "null");
  addnotetrack_dialogue("axis2_held_down", "dialog", "vignette", "Mak1_IGD_008A_USR1", "null");
  level.scr_anim["ally_held_down"]["vignette"] = % ch_makinraid_held_down_head_shot_guy3;
  level.scr_anim["ally_held_down"]["death"] = % ch_makinraid_held_down_head_shot_guy3_death;
  level.scr_anim["axis_katana_run"]["intro"] = % ch_makinraid_sword_attack_intro;
  level.scr_anim["generic"]["katana_run"] = % ch_makinraid_sword_attack_loop;
  level.scr_anim["axis_katana_run"]["death"] = % ch_makinraid_sword_attack_death;
  addnotetrack_custom("axis_katana_run", "vignette", "detatch_gun_right", "detach gun", true, "tag", "tag_weapon_right");
  addnotetrack_attach("axis_katana_run", "grab_sword_right", "weapon_jap_katana_long", "tag_inhand", "intro");
  level.scr_anim["ally_fire_beatdown"]["vignette1"] = % ch_makinraid_fire_beatdown1_US;
  addnotetrack_customfunction("ally_fire_beatdown", "break_apart", ::beatdown_break_apart, "vignette1");
  addnotetrack_custom("ally_fire_beatdown", "vignette1", "dropgun", "detach gun", true, "tag", "tag_weapon_right");
  addnotetrack_dialogue("ally_fire_beatdown", "dialog", "vignette1", "Mak1_IGD_003A_USR3");
  level.scr_anim["axis_fire_beatdown"]["vignette1"] = % ch_makinraid_fire_beatdown1_JAP;
  addnotetrack_customfunction("axis_fire_beatdown", "break_through_door", ::beatdown_hut_door, "vignette1");
  level.scr_anim["ally_fire_beatdown"]["vignette2"] = % ch_makinraid_fire_beatdown2_US;
  level.scr_anim["axis_fire_beatdown"]["vignette2"] = % ch_makinraid_fire_beatdown2_JAP;
  level.scr_anim["sullivan"]["3_route"] = % ch_makinraid_sullivan_3_route;
  addnotetrack_dialogue("sullivan", "dialog", "3_route", "Mak1_IGD_002A_SULL");
  addnotetrack_dialogue("sullivan", "dialog", "3_route", "Mak1_IGD_000A_SULL");
  addnotetrack_dialogue("sullivan", "dialog", "3_route", "Mak1_IGD_001A_SULL");
  level.scr_sound["sullivan"]["take_out_mg"] = "Mak1_IGD_009A_SULL";
  level.scr_sound["sullivan"]["shoot_through_wood"] = "Mak1_IGD_011A_SULL";
  level.scr_sound["sullivan"]["keep_on_mg"] = "Mak1_IGD_513A_SULL";
  level.scr_sound["sullivan"]["no_crew_on_mg"] = "Mak1_IGD_514A_SULL";
  level.scr_sound["sullivan"]["hit_that_mg"] = "Mak1_IGD_515A_SULL";
  level.scr_sound["roebuck"]["random_keep_up1"] = "Mak1_IGD_100A_ROEB";
  level.scr_sound["roebuck"]["random_keep_up2"] = "Mak1_IGD_101A_ROEB";
  level.scr_sound["roebuck"]["random_keep_up3"] = "Mak1_IGD_102A_ROEB";
  level.scr_sound["roebuck"]["random_keep_up4"] = "Mak1_IGD_103A_ROEB";
  level.scr_sound["roebuck"]["random_keep_up5"] = "Mak1_IGD_104A_ROEB";
  level.scr_sound["roebuck"]["random_keep_up6"] = "Mak1_IGD_105A_ROEB";
  level.scr_sound["roebuck"]["random_keep_up7"] = "Mak1_IGD_106A_ROEB";
  level.scr_sound["roebuck"]["random_keep_up8"] = "Mak1_IGD_107A_ROEB";
  level.scr_sound["roebuck"]["random_keep_up9"] = "Mak1_IGD_108A_ROEB";
  level.scr_sound["roebuck"]["random_keep_up10"] = "Mak1_IGD_109A_ROEB";
  level.scr_sound["roebuck"]["random_keep_up11"] = "Mak1_IGD_110A_ROEB";
  level.scr_sound["roebuck"]["random_keep_up12"] = "Mak1_IGD_111A_ROEB";
  level.scr_sound["roebuck"]["random_keep_up13"] = "Mak1_IGD_112A_ROEB";
  level.scr_sound["roebuck"]["random_keep_up14"] = "Mak1_IGD_113A_ROEB";
  level.scr_sound["roebuck"]["random_keep_up15"] = "Mak1_IGD_114A_ROEB";
  level.scr_sound["roebuck"]["random_keep_up16"] = "Mak1_IGD_115A_ROEB";
  level.scr_sound["sullivan"]["no_one_standing"] = "Mak1_IGD_500A_SULL";
  level.scr_sound["sullivan"]["watch_flank"] = "Mak1_IGD_501A_SULL";
  level.scr_sound["sullivan"]["more_of_them"] = "Mak1_IGD_504A_SULL";
  level.scr_sound["roebuck"]["put_em_down_fast"] = "Mak1_IGD_502A_ROEB";
  level.scr_sound["roebuck"]["theyre_regrouping"] = "Mak1_IGD_503A_ROEB";
  level.scr_sound["roebuck"]["watch_out"] = "Mak1_IGD_506A_ROEB";
  level.scr_sound["roebuck"]["thats_all_of_them"] = "Mak1_IGD_505A_ROEB";
  level.scr_sound["generic"]["cant_get_clear_shot"] = "Mak1_IGD_010A_USR2";
}

event1_mitch_slash(guy) {
  if(!is_mature()) {
    return;
  }
  struct = getstruct("event1_blood_spray_target", "targetname");
  origin = guy GetTagOrigin("j_neck");
  angles = VectorToAngles(struct.origin - origin);
  playFX(level._effect["blood_spray"], origin, anglesToForward(angles), AnglesToUp(angles));
  guy codescripts\character::new();
  guy character\char_usa_marine_h_pow_cut::main();
}

event1_mitch_blood_pool(guy) {
  if(is_mature()) {
    z = 49;
    origin = guy GetTagOrigin("J_NECK");
    origin = (origin[0], origin[1], z);
    playFX(level._effect["blood_pool"], origin);
  }
  level notify("intro_rejoin_player_to_hands");
}

event1_intro_roebuck_start(guy) {
  node = GetNode("intro", "targetname");
  level.roebuck Attach("viewmodel_usa_kbar_knife", "tag_inhand");
  remove_gun(level.roebuck);
  level anim_single_solo_earlyout(level.roebuck, "intro", undefined, node, undefined, undefined, 0.5);
}

event1_intro_sullivan_start(guy) {
  node = GetNode("intro", "targetname");
  level thread event1_redshirts_move_up();
  redshirts[0] = GetEnt("scout1", "script_noteworthy");
  redshirts[1] = GetEnt("scout2", "script_noteworthy");
  level thread maps\mak::event1_redshirts_regroup();
  level thread event1_rescuers();
  level.roebuck maps\mak::disable_arrivals(true, true);
  level.sullivan maps\mak::disable_arrivals(true, true);
  level thread anim_single_solo_earlyout(level.sullivan, "intro", undefined, node, undefined, undefined, 0.5);
  wait(.5);
  officer = GetEnt("intro_officer", "script_noteworthy");
  level anim_single_solo(officer, "intro2", undefined, node);
  officer thread death_after_anim();
  level.sullivan waittill("anim_early_out");
  flag_set("intro_done");
  wait(3);
  for(i = 0; i < redshirts.size; i++) {
    redshirts[i] thread maps\mak::disable_arrivals(false, false, undefined, 1);
  }
}

event1_redshirts_move_up() {
  node = GetNode("intro", "targetname");
  redshirts = [];
  redshirts[0] = GetEnt("scout1", "script_noteworthy");
  redshirts[0].animname = "intro_redshirt1";
  redshirts[1] = GetEnt("scout2", "script_noteworthy");
  redshirts[1].animname = "intro_redshirt2";
  for(i = 0; i < redshirts.size; i++) {
    redshirts[i] maps\mak::disable_arrivals(true, true);
  }
  level anim_reach(redshirts, "intro", undefined, node);
  level thread anim_single_earlyout(redshirts, "intro", undefined, node, undefined, undefined, 0.5);
  for(i = 0; i < redshirts.size; i++) {
    redshirts[i] enable_ai_color();
  }
}

event1_rescuers(no_waittill) {
  rescuers = getEntArray("event1_rescuers", "targetname");
  nodes = GetNodeArray("rescuer_path", "targetname");
  for(i = 0; i < rescuers.size; i++) {
    rescuers[i] setCanDamage(false);
    rescuers[i] maps\mak::disable_arrivals(true, true);
    rescuers[i].goalradius = 128;
    rescuers[i] thread follow_path(nodes[i]);
  }
  if(isDefined(no_waittill)) {
    wait(7);
  } else {
    wait(2);
  }
  pows[0] = GetEnt("pow1", "script_noteworthy");
  pows[1] = GetEnt("pow3", "script_noteworthy");
  boat = GetEnt("event1_rescue_raft", "targetname");
  v_node = GetVehicleNode("event1_rescuer_boatpath", "targetname");
  boat AttachPath(v_node);
  counter = spawnStruct();
  counter.count = 0;
  for(i = 0; i < pows.size; i++) {
    rescuers[i] gun_remove();
    rescuers[i] thread event1_rescue_pow(pows[i], i, counter);
  }
  counter waittill("guys_on_boat");
  boat StartPath();
  boat waittill("reached_end_node");
  for(i = 0; i < pows.size; i++) {
    rescuers[i] Delete();
    pows[i] Delete();
  }
  boat Delete();
}

event1_rescue_pow(pow, num, counter) {
  pow_anims[0] = % ch_makinraid_rescue_pow1;
  pow_anims[1] = % ch_makinraid_rescue_pow2;
  self.animname = "rescuer" + (num + 1);
  boat = GetEnt("event1_rescue_raft", "targetname");
  self thread set_generic_run_anim("rescue_pow_cycle" + (num + 1), true);
  pow notify("stop_tied_up_loop");
  pow StopAnimScripted();
  pow.animname = "rescued_pow" + (num + 1);
  pow thread pow_loop(pow_anims[num], self);
  pow LinkTo(self, "tag_sync", (0, 0, 0), (0, 0, 0));
  level anim_reach_solo(self, "castoff", undefined, boat);
  pow notify("stop_pow_loop");
  guys[0] = self;
  guys[1] = pow;
  boat thread anim_single(guys, "castoff", undefined, boat);
  wait(.05);
  pow LinkTo(boat, "tag_origin");
  wait(6);
  for(i = 0; i < guys.size; i++) {
    guys[i] LinkTo(boat, "tag_origin", (0, 0, 0), (0, 0, 0));
  }
  counter.count++;
  if(counter.count == 2) {
    counter notify("guys_on_boat");
  }
  level anim_loop(guys, "idle", undefined, "stop_boat_idle", boat);
}

pow_loop(animation, rescuer) {
  self endon("stop_pow_loop");
  while(1) {
    rescuer anim_single_solo(self, "run", "tag_sync");
  }
}

event2() {
  level endon("event2_shutup");
  level.scr_sound["sullivan"]["good_work_marines"] = "Mak1_IGD_012A_SULL";
  level.scr_sound["sullivan"]["goat_path_info2"] = "Mak1_IGD_014B_SULL";
  level.scr_sound["sullivan"]["follow_my_lead"] = "Mak1_IGD_015A_SULL";
  level.scr_sound["sullivan"]["hear_something"] = "Mak1_IGD_022A_SULL";
  level.scr_sound["sullivan"]["hold_ground"] = "Mak1_IGD_402A_SULL";
  level.scr_sound["sullivan"]["thats_a_banzai"] = "Mak1_IGD_403A_SULL";
  level.scr_sound["sullivan"]["keep_it_together"] = "Mak1_IGD_024A_SULL";
  level.scr_sound["sullivan"]["dont_know"] = "Mak1_IGD_028A_SULL";
  level.scr_sound["sullivan"]["pickup_pace"] = "Mak1_IGD_030A_SULL";
  level.scr_sound["sullivan"]["hold_tight"] = "Mak1_IGD_032A_SULL";
  level.scr_sound["sullivan"]["mg_on_right"] = "Mak1_IGD_035A_SULL";
  level.scr_sound["sullivan"]["go"] = "Mak1_IGD_036A_SULL";
  level.scr_sound["sullivan"]["listen_up"] = "Mak1_IGD_037A_SULL";
  level.scr_sound["sullivan"]["quick_clean1"] = "Mak1_IGD_038A_SULL";
  level.scr_sound["sullivan"]["quick_clean2"] = "Mak1_IGD_039A_SULL";
  level.scr_sound["sullivan"]["move_out"] = "Mak1_IGD_040A_SULL";
  level.scr_sound["sullivan"]["stay_sharp"] = "Mak1_IGD_041A_SULL";
  level.scr_sound["sullivan"]["dont_like_surpises"] = "Mak1_IGD_042A_SULL";
  level.scr_sound["sullivan"]["home_in_this"] = "Mak1_IGD_044A_SULL";
  level.scr_sound["sullivan"]["eyes_peeled"] = "Mak1_IGD_045A_SULL";
  level.scr_anim["sullivan"]["event2_regroup"] = % ch_makinraid_beachregroup_guy1;
  level.scr_sound["roebuck"]["shhh"] = "Mak1_IGD_021A_ROEB";
  level.scr_sound["roebuck"]["check_it_out"] = "Pel2_IGD_400A_ROEB";
  level.scr_sound["roebuck"]["snare_trap_reaction"] = "Mak1_IGD_061A_ROEB";
  level.scr_sound["roebuck"]["booby_trap"] = "Mak1_IGD_400A_ROEB";
  level.scr_sound["roebuck"]["here_they_come"] = "Mak1_IGD_401A_ROEB";
  level.scr_sound["roebuck"]["second_team"] = "Mak1_IGD_029B_ROEB";
  level.scr_sound["roebuck"]["theyve_been_spotted"] = "Mak1_IGD_031A_ROEB";
  level.scr_sound["roebuck"]["aint_eyeballed"] = "Mak1_IGD_033A_ROEB";
  level.scr_sound["roebuck"]["take_out_spotlight"] = "Mak1_IGD_516A_ROEB";
  level.scr_sound["roebuck"]["good_shooting"] = "Mak1_IGD_517A_ROEB";
  level.scr_sound["rooker"]["yes_sir"] = "Mak1_IGD_049A_ROOK";
  level.scr_sound["generic"]["ever_seen_banzai"] = "Mak1_IGD_017A_PHIL";
  level.scr_sound["generic"]["a_what"] = "Mak1_IGD_019A_PSOU";
  level.scr_sound["generic"]["a_banzai"] = "Mak1_IGD_018A_PHIL";
  level.scr_sound["generic"]["crazy_tactic"] = "Mak1_IGD_020A_PHIL";
  level.scr_sound["generic"]["heart_attack"] = "Mak1_IGD_023A_USR2";
  level.scr_sound["generic"]["hell_is_that"] = "Mak1_IGD_025A_PSOU";
  level.scr_sound["generic"]["temple"] = "Mak1_IGD_026A_PHIL";
  level.scr_sound["generic"]["japanese_pray"] = "Mak1_IGD_027A_USR2";
  level.scr_sound["generic"]["creeps_me_out"] = "Mak1_IGD_043A_USR2";
  level.scr_sound["generic"]["what_is_this"] = "Mak1_IGD_025A_PSOU";
  level.scr_anim["generic"]["new_snare_trap"] = % patrol_bored_react_look_v1;
  level.scr_sound["generic"]["new_snare_trap_temple"] = "Mak1_IGD_026A_PHIL";
  level.scr_anim["generic"]["snare_trap"] = % ch_makinraid_strung_up;
  addnotetrack_customfunction("generic", "strung_up", ::event2_snare_trap, "snare_trap");
  level.scr_anim["boatsquad_guy1"]["loop"][0] = % ch_makinraid_raft_combat_idle_guy1;
  level.scr_anim["boatsquad_guy1"]["loop" + "weight"][0] = 100;
  level.scr_anim["boatsquad_guy1"]["loop"][1] = % ch_makinraid_raft_combat_guy1;
  level.scr_anim["boatsquad_guy1"]["loop" + "weight"][1] = 50;
  level.scr_anim["boatsquad_guy1"]["exit"] = % ch_makinraid_raft_exit_guy1;
  level.scr_anim["boatsquad_guy2"]["loop"][0] = % ch_makinraid_raft_combat_idle_guy2;
  level.scr_anim["boatsquad_guy2"]["loop" + "weight"][0] = 100;
  level.scr_anim["boatsquad_guy2"]["loop"][1] = % ch_makinraid_raft_combat_guy2;
  level.scr_anim["boatsquad_guy2"]["loop" + "weight"][1] = 50;
  level.scr_anim["boatsquad_guy2"]["exit"] = % ch_makinraid_raft_exit_guy2;
  level.scr_anim["boatsquad_guy3"]["loop"][0] = % ch_makinraid_raft_combat_idle_guy3;
  level.scr_anim["boatsquad_guy3"]["loop" + "weight"][0] = 100;
  level.scr_anim["boatsquad_guy3"]["loop"][1] = % ch_makinraid_raft_combat_guy3;
  level.scr_anim["boatsquad_guy3"]["loop" + "weight"][1] = 50;
  level.scr_anim["boatsquad_guy3"]["exit"] = % ch_makinraid_raft_exit_guy3;
  level.scr_anim["boatsquad_guy4"]["loop"][0] = % ch_makinraid_raft_combat_idle_guy4;
  level.scr_anim["boatsquad_guy4"]["loop" + "weight"][0] = 100;
  level.scr_anim["boatsquad_guy4"]["loop"][1] = % ch_makinraid_raft_combat_guy4;
  level.scr_anim["boatsquad_guy4"]["loop" + "weight"][1] = 50;
  level.scr_anim["boatsquad_guy4"]["exit"] = % ch_makinraid_raft_exit_guy4;
  level.scr_anim["generic"]["balcony_death"] = % ai_deathbalcony_b;
}

event2_snare_trap(guy) {
  node = GetNode("event2_snare", "targetname");
  branch = getstruct("event2_snare_branch", "targetname");
  pos = (branch.origin[0], branch.origin[1], node.origin[2]);
  what_to_gib = randomintrange(0, 2);
  if(0) {
    guy.a.gib_ref = "left_arm";
  } else {
    guy.a.gib_ref = "right_arm";
  }
  dist = Distance(node.origin, branch.origin);
  DeleteRope(level.snare_rope_id);
  guy playSound("trap_spring");
  ropeId = CreateRope(branch.origin, (0, 0, 0), dist * 0.55, guy, "j_ankle_le", 2);
  guy playSound("trap_vx");
  guy StartRagDoll();
  level thread event2_snare_death_break_rope(ropeId);
  wait(0.5);
  guy setCanDamage(true);
  guy.NoFriendlyfire = true;
  guy.health = 10;
  level thread event2_snare_dialog();
  wait(0.5);
  level.sullivan MagicGrenadeManual(pos + (0, 0, 5), (0, 0, 0), 0);
}

event2_snare_death_break_rope(ropeId) {
  wait(randomintrange(3, 4));
  breakrope(ropeId, 0);
}

event2_snare_death() {
  refs = [];
  refs[refs.size] = "right_arm";
  refs[refs.size] = "left_arm";
  self.a.gib_ref = maps\mak::get_random(refs);
  self animscripts\shared::DropAllAIWeapons();
  self thread animscripts\death::do_gib();
  return true;
}

event2_snare_dialog() {
  level.roebuck anim_single_solo(level.roebuck, "snare_trap_reaction");
  level.roebuck thread anim_single_solo(level.roebuck, "booby_trap");
  flag_set("event2_path_stop2");
  level.roebuck thread anim_single_solo(level.roebuck, "here_they_come");
  wait(1);
  level.sullivan anim_single_solo(level.sullivan, "hold_ground");
  check_trigger = GetEnt("event2_goatpath_check_axis", "targetname");
  maps\mak::trigger_waittill_dead("axis", "team", check_trigger);
  flag_set("event2_banzai_dead");
  wait(3);
  wait(1);
  flag_set("event2_after_banzai_dialog");
}

event3() {
  level.scr_anim["sullivan"]["feign_in"] = % ch_makinraid_feigning_death_sullivan_transition;
  level.scr_anim["sullivan"]["feign_1"] = % ch_makinraid_feigning_death_sullivan_a;
  level.scr_anim["sullivan"]["feign_2"] = % ch_makinraid_feigning_death_sullivan_b;
  addnotetrack_dialogue("sullivan", "dialog", "feign_1", "Mak1_IGD_046A_SULL", "null");
  addnotetrack_dialogue("sullivan", "dialog", "feign_1", "Mak1_IGD_048A_SULL");
  addnotetrack_dialogue("sullivan", "dialog", "feign_2", "Mak1_IGD_079A_SULL");
  level.scr_anim["roebuck"]["feign_in"] = % ch_makinraid_feigning_death_roebuck_transition;
  level.scr_anim["roebuck"]["feign_1"] = % ch_makinraid_feigning_death_roebuck_a;
  level.scr_anim["roebuck"]["feign_2"] = % ch_makinraid_feigning_death_roebuck_b;
  addnotetrack_dialogue("roebuck", "dialog", "feign_1", "Mak1_IGD_047A_ROEB");
  addnotetrack_dialogue("roebuck", "dialog", "feign_1", "Mak1_IGD_050A_ROEB");
  level.scr_anim["feign_redshirt"]["feign_in"] = % ch_makinraid_feigning_death_redshirt_transition;
  level.scr_anim["feign_redshirt"]["feign_1"] = % ch_makinraid_feigning_death_redshirt_a;
  level.scr_anim["feign_redshirt"]["feign_2"] = % ch_makinraid_feigning_death_redshirt_b;
  addnotetrack_customfunction("feign_redshirt", "flare", ::event3_flare, "feign_1");
  if(is_mature()) {
    addnotetrack_fxontag("feign_redshirt", "feign_2", "slice1", "flesh_hit", "J_Knee_LE");
    addnotetrack_fxontag("feign_redshirt", "feign_2", "slice2", "flesh_hit", "J_SpineUpper");
  }
  level.scr_anim["feign_redshirt"]["death"] = % ch_makinraid_feigning_death_redshirt_dead;
  addnotetrack_dialogue("feign_redshirt", "dialog", "feign", "Mak1_IGD_049A_CORK");
  level.scr_anim["feign_officer"]["feign"][0] = % ch_makinraid_feigning_death_officer_play_dead;
  level.scr_anim["feign_officer"]["death"] = % ch_makinraid_feigning_death_officer_dead;
  level.scr_anim["feign_officer"]["feign_1"] = % ch_makinraid_feigning_death_officer_a;
  level.scr_anim["feign_officer"]["feign_2"] = % ch_makinraid_feigning_death_officer_b;
  addnotetrack_customfunction("feign_officer", "detach_sword", ::event3_leave_sword, "feign_2");
  if(is_mature()) {
    addnotetrack_fxontag("feign_officer", "feign_2", "shotgun_hit", "flesh_hit", "J_SpineUpper");
  }
  level.scr_anim["feign_guy1"]["feign"][0] = % ch_makinraid_feigning_death_jap01_dead;
  level.scr_anim["feign_guy1"]["death"] = % ch_makinraid_feigning_death_jap01_die;
  level.scr_anim["feign_guy1"]["getup"] = % ch_makinraid_feigning_death_jap01_getup;
  level.scr_anim["feign_guy2"]["feign"][0] = % ch_makinraid_feigning_death_jap02_dead;
  level.scr_anim["feign_guy2"]["death"] = % ch_makinraid_feigning_death_jap02_die;
  level.scr_anim["feign_guy2"]["getup"] = % ch_makinraid_feigning_death_jap02_getup;
  level.scr_anim["feign_guy3"]["feign"][0] = % ch_makinraid_feigning_death_jap03_dead;
  level.scr_anim["feign_guy3"]["death"] = % ch_makinraid_feigning_death_jap03_die;
  level.scr_anim["feign_guy3"]["getup"] = % ch_makinraid_feigning_death_jap03_getup;
  level.scr_anim["feign_guy4"]["feign"][0] = % ch_makinraid_feigning_death_jap04_dead;
  level.scr_anim["feign_guy4"]["death"] = % ch_makinraid_feigning_death_jap04_die;
  level.scr_anim["feign_guy4"]["getup"] = % ch_makinraid_feigning_death_jap04_getup;
}

event4() {
  level.scr_sound["sullivan"]["compound_ahead"] = "Mak1_IGD_121A_SULL";
  level.scr_sound["sullivan"]["undefined"] = undefined;
  level.scr_sound["sullivan"]["get_to_truck"] = "Mak1_IGD_055A_SULL";
  level.scr_anim["sullivan"]["open_tailgate"] = % ch_makinraid_truck_tailgate_open_sullivan;
  level.scr_sound["sullivan"]["open_tailgate"] = "Mak1_IGD_051A_SULL";
  level.scr_anim["sullivan"]["open_tailgate_hurry1"] = % ch_makinraid_truck_get_it_done_a;
  level.scr_sound["sullivan"]["open_tailgate_hurry1"] = "Mak1_IGD_122A_SULL";
  level.scr_anim["sullivan"]["open_tailgate_hurry2"] = % ch_makinraid_truck_get_it_done_b;
  level.scr_sound["sullivan"]["open_tailgate_hurry2"] = "Mak1_IGD_054A_SULL";
  level.scr_anim["sullivan"]["light_the_match"] = % ch_makinraid_ignite_gas;
  addnotetrack_attach("sullivan", "attach_zippo", "weapon_rus_zippo", "tag_inhand", "light_the_match");
  addnotetrack_detach("sullivan", "detach_zippo", "weapon_rus_zippo", "tag_inhand", "light_the_match");
  addNotetrack_flag("sullivan", "light_gas", "event4_light_fuel", "light_the_match");
  level.scr_sound["sullivan"]["event4_move_move"] = "Mak1_IGD_056A_SULL";
  level.scr_sound["sullivan"]["thats_extraction_point"] = "Mak1_IGD_207A_SULL";
  level.scr_sound["sullivan"]["c_squad"] = "Mak1_IGD_206A_SULL";
  level.scr_sound["roebuck"]["undefined"] = undefined;
  level.scr_anim["roebuck"]["truck_getin"] = % ch_makinraid_truck_jumpin;
  level.scr_anim["roebuck"]["truck_getout1"] = % ch_makinraid_truck_jumpout_a;
  level.scr_anim["roebuck"]["truck_getout2"] = % ch_makinraid_truck_jumpout_b;
  level.scr_anim["roebuck"]["truck_idle"][0] = % ch_makinraid_truck_jumpin_idle;
}

event5() {
  level.scr_anim["sullivan"]["plant_charges"] = % ch_makinraid_inner_compound_sullivan_directions;
  level.scr_sound["sullivan"]["plant_charges"] = "Mak1_IGD_057A_SULL";
  level.scr_sound["sullivan"]["plant_charges_now"] = "Mak1_IGD_301A_SULL";
  level.scr_sound["sullivan"]["clear_out_camp"] = "Mak1_IGD_123A_SULL";
  level.scr_sound["roebuck"]["miller_back_me_up"] = "Mak1_IGD_302A_ROEB";
  level.scr_sound["roebuck"]["cmon_lets_go"] = "Mak1_IGD_060A_ROEB";
  level.scr_anim["roebuck"]["bunkerdoor"] = % ch_makinraid_bunkerdoor_roebuck;
  level.scr_sound["roebuck"]["bunkerdoor"] = "Mak1_IGD_061A_ROEB";
  level.scr_sound["roebuck"]["bunkerdoor_back_me_up"] = "Mak1_IGD_302A_ROEB";
  level.scr_sound["roebuck"]["need_to_cover"] = "Mak1_IGD_304A_ROEB";
  level.scr_sound["roebuck"]["get_back_here"] = "Mak1_IGD_305A_ROEB";
  addnotetrack_dialogue("roebuck", "fire", "bunkerdoor", "Mak1_IGD_062A_ROEB");
  level.scr_sound["roebuck"]["cover_door"] = "Mak1_IGD_064A_ROEB";
  level.scr_sound["roebuck"]["player_plant_charges"] = "Mak1_IGD_209A_ROEB";
  level.scr_anim["roebuck"]["plant_charge_intro"] = % ch_makinraid_set_bunker_charges_intro;
  addnotetrack_attach("roebuck", "attach_charge", "weapon_satchel_charge", "tag_inhand", "plant_charge_intro");
  addnotetrack_detach("roebuck", "detach_charge", "weapon_satchel_charge", "tag_inhand", "plant_charge_intro");
  addnotetrack_customfunction("roebuck", "detach_charge", ::event5_leave_satchel, "plant_charge_intro");
  level.scr_anim["roebuck"]["plant_charge_loop"][0] = % ch_makinraid_set_bunker_charges_loop;
  level.scr_anim["roebuck"]["plant_charge_outro"] = % ch_makinraid_set_bunker_charges_outro;
  level.scr_sound["roebuck"]["plant_charge_outro2"] = "Mak1_IGD_071A_ROEB";
  level.scr_sound["roebuck"]["extraction_point"] = "Mak1_IGD_212A_ROEB";
  level.scr_sound["roebuck"]["jerry_rig_charges"] = "Mak1_IGD_211A_ROEB";
  level.scr_sound["roebuck"]["siren"] = "Mak1_IGD_066A_ROEB";
  level.scr_anim["bunkerdoor_japanese"]["bunkerdoor"] = % ch_makinraid_bunkerdoor_japanese;
  level.scr_anim["bunkerdoor_redshirt"]["bunkerdoor"] = % ch_makinraid_bunkerdoor_redshirt;
  level.scr_sound["bunkerdoor_redshirt"]["counter_attack"] = "Mak1_IGD_067A_JACK";
}

event5_leave_satchel(guy) {
  origin = guy GetTagOrigin("tag_inhand");
  angles = guy GetTagAngles("tag_inhand");
  satchel = spawn("script_model", origin);
  satchel.angles = angles;
  satchel setModel("weapon_satchel_charge");
  satchel playLoopSound("bomb_tick_loop");
}

event6() {
  level.scr_anim["sullivan"]["get_to_boats"] = % ch_makinraid_exit_bunker_sullivan;
  level.scr_sound["sullivan"]["get_to_boats"] = "Mak1_IGD_072A_SULL";
  level.scr_sound["sullivan"]["get_to_boats_b"] = "Mak1_IGD_213A_SULL";
  level.scr_sound["sullivan"]["get_to_boats1"] = "Mak1_IGD_074A_SULL";
  level.scr_sound["sullivan"]["get_to_boats2"] = "Mak1_IGD_075A_SULL";
  level.scr_sound["sullivan"]["get_to_boats3"] = "Mak1_IGD_076A_SULL";
  level.scr_sound["sullivan"]["get_to_boats4"] = "Mak1_IGD_078A_SULL";
  level.scr_sound["sullivan"]["get_to_boats5"] = "Mak1_IGD_079A_SULL";
  level.scr_sound["sullivan"]["get_to_boats6"] = "Mak1_IGD_080A_SULL";
  level.scr_sound["sullivan"]["get_to_boats7"] = "Mak1_IGD_081A_SULL";
  level.scr_anim["sullivan"]["outtro_start"] = % ch_makinraid_outro_sullivan_start;
  addnotetrack_customfunction("sullivan", "detach_shotgun", ::event6_outtro_detach_shotgun, "outtro_start");
  addnotetrack_customfunction("sullivan", "attach_pistol", ::switch_to_sidearm, "outtro_start");
  level.scr_sound["roebuck"]["stay_with_me"] = "Mak1_IGD_073A_ROEB";
  level.scr_sound["roebuck"]["all_around_us"] = "Mak1_IGD_077A_ROEB";
  level.scr_sound["roebuck"]["get_to_boats1"] = "Mak1_IGD_081A_ROEB";
  level.scr_sound["roebuck"]["get_to_boats2"] = "Mak1_IGD_404A_ROEB";
  level.scr_sound["roebuck"]["get_to_boats3"] = "Mak1_IGD_405A_ROEB";
  level.scr_sound["roebuck"]["get_to_boats4"] = "Mak1_IGD_406A_ROEB";
  level.scr_sound["roebuck"]["get_to_boats5"] = "Mak1_IGD_407A_ROEB";
  level.scr_sound["roebuck"]["cmon"] = "Mak1_OUT_101A_ROEB";
  level.scr_sound["roebuck"]["you_are_gonna_be_ok"] = "Mak1_OUT_002A_ROEB";
  level.scr_anim["sullivan"]["outtro_loop"] = % ch_makinraid_outro_sullivan_dragged;
  level.scr_anim["sullivan"]["boat_getin"] = % ch_makinraid_outro_raft_jumpin_sullivan;
  addnotetrack_customfunction("sullivan", "sullivan_boat_in", ::event6_outtro_sullivan_in_boat, "boat_getin");
  level.scr_sound["sullivan"]["i_got_you"] = "Mak1_IGD_308A_SULL";
  level.scr_sound["sullivan"]["boat_getin"] = "Mak1_OUT_000A_SULL";
  level.scr_anim["sullivan"]["boat_underfire"][0] = % ch_makinraid_outro_raft_jumpin_sullivan_underfire;
  level.scr_anim["sullivan"]["boat_reaction"] = % ch_makinraid_outro_raft_jumpin_sullivan_reaction;
  level.scr_anim["sullivan"]["boat_calm"][0] = % ch_makinraid_outro_raft_jumpin_sullivan_calm;
  level.scr_anim["roebuck"]["outtro_end"] = % ch_makinraid_outro_raft_jumpin_guy1_end;
  level.scr_sound["roebuck"]["going_to_be_ok"] = "Mak1_OUT_002A_ROEB";
  level.scr_sound["roebuck"]["no_duds"] = "Mak1_OUT_004A_ROEB";
  addnotetrack_dialogue("sullivan", "dialog", "boat_getin", "Mak1_OUT_003A_SULL");
  addnotetrack_dialogue("roebuck", "dialog", "outtro_end", "Mak1_OUT_004A_ROEB");
  addnotetrack_dialogue("sullivan", "dialog", "boat_getin", "Mak1_OUT_200A_SULL");
  addnotetrack_dialogue("roebuck", "dialog", "outtro_end", "Mak1_OUT_105A_ROEB");
  addnotetrack_dialogue("sullivan", "dialog", "boat_getin", "Mak1_OUT_201A_SULL");
  level.scr_anim["outtro_enemy"]["ambush"] = % ch_makinraid_outro_japanese;
  addnotetrack_customfunction("outtro_enemy", "strike", ::event6_outtro_strike, "ambush");
  addnotetrack_customfunction("outtro_enemy", "start_sullivan", ::event6_sullivan_outtro, "ambush");
  if(is_mature()) {
    addnotetrack_fxontag("outtro_enemy", "ambush", "headshot", "head_shot_big", "j_head");
  }
  level.scr_anim["boat_guy1"]["boat_getin"] = % ch_makinraid_outro_raft_jumpin_guy1;
  level.scr_anim["boat_guy1"]["boat_underfire"][0] = % ch_makinraid_outro_raft_jumpin_guy1_underfire;
  level.scr_anim["boat_guy1"]["boat_reaction"] = % ch_makinraid_outro_raft_jumpin_guy1_reaction;
  level.scr_anim["boat_guy1"]["boat_calm"][0] = % ch_makinraid_outro_raft_jumpin_guy1_calm;
  level.scr_anim["boat_guy2"]["boat_getin"] = % ch_makinraid_outro_raft_jumpin_guy2;
  level.scr_anim["boat_guy2"]["boat_underfire"][0] = % ch_makinraid_outro_raft_jumpin_guy2_underfire;
  level.scr_anim["boat_guy2"]["boat_reaction"] = % ch_makinraid_outro_raft_jumpin_guy2_reaction;
  level.scr_anim["boat_guy2"]["boat_calm"][0] = % ch_makinraid_outro_raft_jumpin_guy2_calm;
  level.scr_anim["boat_guy3"]["boat_getin"] = % ch_makinraid_outro_raft_jumpin_guy3;
  level.scr_anim["boat_guy3"]["boat_underfire"][0] = % ch_makinraid_outro_raft_jumpin_guy3_underfire;
  level.scr_anim["boat_guy3"]["boat_reaction"] = % ch_makinraid_outro_raft_jumpin_guy3_reaction;
  level.scr_anim["boat_guy3"]["boat_calm"][0] = % ch_makinraid_outro_raft_jumpin_guy3_calm;
  level.scr_anim["boat_guy4"]["boat_getin"] = % ch_makinraid_outro_raft_jumpin_guy4;
  level.scr_anim["boat_guy4"]["boat_underfire"][0] = % ch_makinraid_outro_raft_jumpin_guy4_underfire;
  level.scr_anim["boat_guy4"]["boat_reaction"] = % ch_makinraid_outro_raft_jumpin_guy4_reaction;
  level.scr_anim["boat_guy4"]["boat_calm"][0] = % ch_makinraid_outro_raft_jumpin_guy4_calm;
  level.scr_anim["boat_guy1"]["undefined"] = undefined;
  level.scr_anim["generic"]["death_explosion_forward"] = % death_explosion_forward13;
}

patrol_anims() {
  level.scr_anim["generic"]["patrol_walk"] = % patrol_bored_patrolwalk;
  level.scr_anim["generic"]["patrol_walk_twitch"] = % patrol_bored_patrolwalk_twitch;
  level.scr_anim["generic"]["patrol_stop"] = % patrol_bored_walk_2_bored;
  level.scr_anim["generic"]["patrol_start"] = % patrol_bored_2_walk;
  level.scr_anim["generic"]["patrol_turn180"] = % patrol_bored_2_walk_180turn;
  level.scr_anim["generic"]["patrol_idle_1"] = % patrol_bored_idle;
  level.scr_anim["generic"]["patrol_idle_2"] = % patrol_bored_idle_smoke;
  level.scr_anim["generic"]["patrol_idle_3"] = % patrol_bored_idle_cellphone;
  level.scr_anim["generic"]["patrol_idle_4"] = % patrol_bored_twitch_bug;
  level.scr_anim["generic"]["patrol_idle_5"] = % patrol_bored_twitch_checkphone;
  level.scr_anim["generic"]["patrol_idle_6"] = % patrol_bored_twitch_stretch;
  level.scr_anim["generic"]["patrol_idle_smoke"] = % patrol_bored_idle_smoke;
  level.scr_anim["generic"]["patrol_idle_checkphone"] = % patrol_bored_twitch_checkphone;
  level.scr_anim["generic"]["patrol_idle_stretch"] = % patrol_bored_twitch_stretch;
  level.scr_anim["generic"]["patrol_idle_phone"] = % patrol_bored_idle_cellphone;
}

remove_gun(guy) {
  if(!isDefined(guy)) {
    self gun_remove();
  } else {
    guy gun_remove();
  }
}

recall_gun(guy) {
  guy gun_recall();
}

holster_weapon_switch_to_sidearm(guy) {
  if(guy.gearModel == "char_usa_raider_gear1" || guy.gearModel == "char_usa_raider_gear4" || guy.gearModel == "char_usa_raider_gear5") {
    guy Detach(guy.gearModel);
    if(RandomInt(100) > 50) {
      guy.gearModel = "char_usa_raider_gear2";
    } else {
      guy.gearModel = "char_usa_raider_gear3";
    }
    guy Attach(guy.gearModel);
  }
  guy.og_weapon = guy.weapon;
  guy gun_switchto(guy.sidearm, "right");
  guy Attach(GetWeaponModel(guy.og_weapon), "tag_inhand");
}

holster_sidearm_switch_to_weapon(guy) {
  guy Detach(GetWeaponModel(guy.og_weapon), "tag_inhand");
  guy animscripts\shared::placeWeaponOn(guy.og_weapon, "right");
}

switch_to_sidearm(guy) {
  guy gun_switchto(guy.sidearm, "right");
}

mitch_beatstick_hit(guy) {
  struct = getstruct("event1_beatstick_target", "targetname");
  origin = guy GetTagOrigin("TAG_EYE");
  angles = VectorToAngles(struct.origin - origin);
  playFX(level._effect["beatstick_hit"], origin, anglesToForward(angles), AnglesToUp(angles));
}

follow_path(node) {
  while(1) {
    if(isDefined(node.radius)) {
      self.goalradius = node.radius;
    }
    self SetGoalNode(node);
    self waittill("goal");
    if(!isDefined(node.target)) {
      break;
    }
    if(isDefined(node.script_flag_wait)) {
      flag_wait(node.script_flag_wait);
    }
    node = GetNode(node.target, "targetname");
  }
  self notify("done_following_path");
}

event1_set_objective(guy) {
  if(!isDefined(level.event1_dialogue_count)) {
    level.event1_dialogue_count = 0;
  }
  level.event1_dialogue_count++;
  if(level.event1_dialogue_count == 4) {
    level.event1_dialogue_count = undefined;
    maps\mak::set_objective(0);
  }
}

event1_flashlight(guy) {
  guy endon("flashlight_off");
  for(i = 0; i < 2; i++) {
    light_ent = spawn("script_model", (0, 0, 0));
    light_ent setModel("tag_origin");
    light_ent LinkTo(guy, "tag_fx", (0, 0, 0), (0, 0, 0));
    playFXOnTag(level._effect["flash_light"], light_ent, "tag_origin");
    wait(0.4);
    light_ent Delete();
    wait(0.2);
  }
}

event1_flashlight_off(guy) {
  level thread maps\mak::event1_detonate_huts();
}

event1_give_nambo(guy) {
  players = get_players();
  if(players.size == 1) {
    return;
  }
  spawners = getEntArray("client_intro_guys", "targetname");
  j = 0;
  counter = spawnStruct();
  counter.count = 0;
  for(i = 0; i < players.size; i++) {
    if(players[i] GetEntityNumber() == 0) {
      player_0 = players[i];
      continue;
    }
    counter.count++;
    players[i] thread player_into_character(spawners[j]);
    counter thread player_into_character_counter(players[i]);
    counter thread player_disconnect_counter(players[i]);
    j++;
  }
  share_screen(get_host(), false);
  show_all_player_models();
  while(counter.count > 0) {
    counter waittill("count_up");
    counter.count--;
  }
  for(j = 0; j < 4; j++) {
    for(i = 0; i < players.size; i++) {
      level._player_breadcrumbs[j][i].pos = players[i].origin;
      level._player_breadcrumbs[j][i].ang = players[i].angles;
    }
  }
}

player_disconnect_counter(player) {
  player waittill("disconnect");
  self notify("count_up");
}

player_into_character_counter(player) {
  player endon("disconnect");
  player waittill("into_character_done");
  self notify("count_up");
}

event1_delete_helmet(guy) {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i].viewhands Show();
  }
  helmet = GetEnt("event1_helmet", "targetname");
  helmet Delete();
}

ragdoll_after_anim() {
  self thread death_after_anim(undefined, "ragdoll");
}

death_after_anim(notify_str, anime, notetrack, delay) {
  if(!isDefined(anime)) {
    anime = "death";
  }
  if(anime != "ragdoll" && anime != "no_deathanim") {
    self.deathanim = getanim(anime);
    self.nodeathragdoll = true;
  } else if(anime == "no_deathanim") {
    self.a.nodeath = true;
  } else {
    self.skipDeathAnim = true;
  }
  if(!isDefined(notify_str)) {
    notify_str = "single anim";
  }
  if(isDefined(self.magic_bullet_shield)) {
    self stop_magic_bullet_shield();
  }
  if(!isDefined(notetrack)) {
    notetrack = "end";
  }
  self waittillmatch(notify_str, notetrack);
  if(isDefined(delay)) {
    wait(delay);
  }
  self setCanDamage(true);
  self.allowdeath = true;
  self DoDamage(self.health + 50, (0, 0, 0));
}

kill_delay(delay, notify_str, anime, notetrack) {
  if(anime != "ragdoll" && anime != "no_deathanim") {
    self.deathanim = getanim(anime);
  } else if(anime == "no_deathanim") {
    self.a.nodeath = true;
  } else {
    self.skipDeathAnim = true;
  }
  if(isDefined(notify_str)) {
    if(!isDefined(notetrack)) {
      notetrack = "end";
    }
    self waittillmatch(notify_str, notetrack);
  }
  if(isDefined(delay)) {
    wait(delay);
  }
  self setCanDamage(true);
  self.allowdeath = true;
  self DoDamage(self.health + 50, (0, 0, 0));
}

delete_after_anim(notify_str) {
  if(!isDefined(notify_str)) {
    notify_str = "single anim";
  }
  self waittillmatch(notify_str, "end");
  self Delete();
}

loop_after_anim(anime, notify_str, node, stop_loop_notify) {
  if(!isDefined(notify_str)) {
    notify_str = "single anim";
  }
  self waittillmatch(notify_str, "end");
  self anim_loop_solo(self, anime, undefined, stop_loop_notify, node);
}

goalpos_after_anim(node, notify_str) {
  self endon("death");
  if(!isDefined(notify_str)) {
    notify_str = "single anim";
  }
  self waittillmatch(notify_str, "end");
  if(!isDefined(node)) {
    self SetGoalPos(self.origin);
  } else {
    self SetGoalNode(node);
  }
}

enable_color_after_anim(notify_str) {
  self endon("death");
  if(!isDefined(notify_str)) {
    notify_str = "single anim";
  }
  self waittillmatch(notify_str, "end");
  self enable_ai_color();
}

detach_after_anim(model, tag, notify_str) {
  if(!isDefined(notify_str)) {
    notify_str = "single anim";
  }
  self waittillmatch(notify_str, "end");
  self Detach(model, tag);
}

spawn_and_play_solo(spawner, anime, node, anim_reach, death_anim) {
  spawners[0] = spawner;
  spawn_and_play(spawners, anime, node, anim_reach, death_anim);
}

spawn_and_play(spawners, anime, node, anim_reach, death_anim) {
  guys = maps\mak::spawn_guys(spawners);
  if(isDefined(anim_reach) && anim_reach) {
    level anim_reach(guys, anime, undefined, node);
  }
  if(isDefined(death_anim)) {
    for(i = 0; i < guys.size; i++) {
      guys[i] thread death_after_anim(undefined, death_anim);
    }
  }
  level thread anim_single(guys, anime, undefined, node);
}

anim_under_hut_collapse(guy) {
  exploder(110);
  ents = getEntArray("hut4_collapse_debris", "targetname");
  parent = get_parent_by_tagname(ents, "plank1");
  for(i = 0; i < ents.size; i++) {
    ents[i] NotSolid();
  }
  level thread anim_ents(ents, "collapse", undefined, undefined, parent, "under_hut_debris");
}

anim_intro_shed_light(guy) {}

anim_guy_to_shed(guy) {
  exploder(109);
  pieces = getEntArray("event1_shed_boards", "targetname");
  parent = get_parent_by_tagname(pieces, "joint1");
  level thread anim_ents(pieces, "collapse", undefined, undefined, parent, "guy_2_shed_geo");
}

anim_hut4_pieces() {
  pieces = getEntArray("hut4_face_pieces", "targetname");
  parent = get_parent_by_tagname(pieces, "chunk1");
  pieces = array_randomize(pieces);
  level thread fx_on_pieces(pieces, "hut4_smoke_trail", undefined, 5);
  non_solid_pieces = getEntArray("hut4_piece_notsolid", "script_noteworthy");
  for(i = 0; i < non_solid_pieces.size; i++) {
    non_solid_pieces[i] NotSolid();
  }
  level thread anim_ents(pieces, "explode", undefined, undefined, parent, "hut4_pieces");
}

hut4_hit_hut(ent) {
  exploder(112);
}

hut1_splash(ent) {
  parent = GetEnt("hut1_parent", "targetname");
  if(!isDefined(parent.play_fx)) {
    parent.played_fx = true;
    playFX(level._effect["hut1_splash"], parent.origin);
    playsoundatposition("", parent.origin);
    WaterPlop(parent.origin, 2, 4);
  }
  pieces = getEntArray("hut1_pieces", "script_noteworthy");
  for(i = 0; i < pieces.size; i++) {
    if(isDefined(pieces[i].fx_models)) {
      for(q = 0; q < pieces[i].fx_models.size; q++) {
        if(!isDefined(pieces[i].fx_models[q])) {
          continue;
        }
        if(isDefined(pieces[i].upper)) {
          continue;
        }
        pieces[i].fx_models[q] Delete();
      }
    }
    if(isDefined(pieces[i].smoke_fx)) {
      pieces[i].smoke_fx Delete();
    }
    if(isDefined(pieces[i].big_fx)) {
      pieces[i].big_fx Delete();
    }
  }
  tag_names = [];
  tag_names[tag_names.size] = "hutchunk1_jnt";
  tag_names[tag_names.size] = "hutchunk2_jnt";
  tag_names[tag_names.size] = "hutchunk3_jnt";
  tag_names[tag_names.size] = "hutchunk4_jnt";
  tag_names[tag_names.size] = "hutchunk5_jnt";
  for(i = 0; i < tag_names.size; i++) {
    ent thread maps\mak::draw_tag_name(tag_names[i]);
  }
  ent waittillmatch("ent_anim", "end");
  for(i = 0; i < pieces.size; i++) {
    if(isDefined(pieces[i].fx_models)) {
      for(q = 0; q < pieces[i].fx_models.size; q++) {
        if(!isDefined(pieces[i].fx_models[q])) {
          continue;
        }
        if(isDefined(pieces[i].upper)) {
          pieces[i].fx_models[q] Unlink();
          pieces[i].fx_models[q].angles = (-90, 0, 0);
        }
      }
    }
  }
}

fx_on_pieces(pieces, effect, max, timeout) {
  if(!isDefined(max)) {
    max = pieces.size;
  }
  if(!isDefined(timeout)) {
    timeout = 10;
  }
  pieces = array_randomize(pieces);
  for(i = 0; i < pieces.size; i++) {
    fx_model = spawn("script_model", pieces[i].origin);
    fx_model setModel("tag_origin");
    fx_model.angles = (-90, 0, 0);
    fx_model LinkTo(pieces[i]);
    playsoundatposition("wood_pre_crack", fx_model.origin);
    playFXOnTag(level._effect[effect], fx_model, "tag_origin");
    fx_model thread fx_on_piece_timeout(pieces[i], timeout);
  }
}

fx_on_piece_timeout(parent, timeout) {
  timeout = timeout + RandomFloat(timeout * 0.25);
  parent waittill_notify_or_timeout("death", timeout);
  self Delete();
}

get_parent_by_tagname(pieces, tagname) {
  parent = undefined;
  for(i = 0; i < pieces.size; i++) {
    if(pieces[i].script_linkto == tagname) {
      parent = pieces[i];
      break;
    }
  }
  return parent;
}

showdown_fire(guy) {
  if(!isDefined(guy.fire_count)) {
    guy.fire_count = 0;
  }
  guy.fire_count++;
  enemy = GetEnt("axis_showdown", "targetname");
  if(guy.fire_count == 5) {
    enemy notify("stop_showdown_damage");
    enemy setCanDamage(false);
  }
  if(!isDefined(enemy.showdown_tag_num)) {
    enemy.showdown_tag_num = 0;
  } else {
    enemy.showdown_tag_num++;
  }
  tags[0] = "j_spine4";
  tags[1] = "j_shoulder_le";
  tags[2] = "j_shoulder_ri";
  tags[3] = "j_hip_ri";
  tags[4] = "j_spine4";
  tags[5] = "j_spine4";
  playFXOnTag(level._effect["head_shot"], enemy, tags[enemy.showdown_tag_num]);
}

showdown_hut_door(guy) {
  door = GetEnt("roundhut_door2", "targetname");
  door ConnectPaths();
  door RotateTo((0, 115, 0), 0.5, 0.1, 0);
}

showdown_water_splash(guy) {
  origin = guy GetTagOrigin("j_spine4");
  angles = (-90, 0, 0);
  wait(0.65);
  playFX(level._effect["showdown_splash"], (origin[0] - 24, origin[1] - 24, 10), anglesToForward(angles), AnglesToUp(angles));
}

beatdown_hut_door(guy) {
  door1 = GetEnt("makin_door3", "targetname");
  door1 RotateTo((0, 120, 0), 0.3, 0.1, 0);
  door2 = GetEnt("makin_door2", "targetname");
  door2 RotateTo((0, -105, 0), 0.5, 0.1, 0);
  wait(0.5);
  boards = getEntArray("event1_door_collapse", "targetname");
  parent = GetEnt("event1_door_collapse_parent", "script_noteworthy");
  level anim_ents(boards, "collapse", undefined, undefined, parent, "event1_door_collapse");
}

beatdown_break_apart(guy) {
  axis = GetEnt("event1_axis_fire_beatdown", "targetname");
  flag_set("beatdown_break_apart");
  if(isDefined(axis) && axis.health > 1) {
    guy thread death_after_anim(undefined, "ragdoll");
    guy maps\mak::torch_ai(0.4);
    return;
  }
  attacker = undefined;
  if(isDefined(level.beatdown_attacker)) {
    attacker = level.beatdown_attacker;
  }
  node = GetNode("event1_fire_beatdown_sync", "targetname");
  if(isDefined(axis)) {
    axis StopAnimScripted();
    level thread anim_single_solo(axis, "vignette2", undefined, node);
  }
  guy StopAnimScripted();
  level thread anim_single_solo(guy, "vignette2", undefined, node);
  tag = "J_Elbow_RI";
  playFXOnTag(level._effect["beatdown_arm_smoke"], guy, tag);
  wait(1);
  if(isDefined(attacker) && IsPlayer(attacker)) {
    attacker giveachievement_wrapper("MAK_ACHIEVEMENT_RYAN");
  }
}

event3_leave_sword(guy) {
  guy Detach("weapon_jap_katana_long", "tag_weapon_right");
  origin = guy GetTagOrigin("tag_weapon_right");
  angles = guy GetTagAngles("tag_weapon_right");
  sword = spawn("script_model", origin);
  sword.angles = angles;
  sword setModel("weapon_jap_katana_long");
}

event3_flare(guy) {
  level notify("stop_feign_interrupt");
  level thread maps\mak::event3_flare();
  node = GetNode("event3_feign_death_node", "targetname");
  axis = getEntArray("feign_enemy", "targetname");
  axis = get_array_of_closest(node.origin, axis);
  axis = array_removeundefined(axis);
  axis = array_removeDead(axis);
  feign_enemy = [];
  for(i = 0; i < axis.size; i++) {
    if((isDefined(axis[i])) && (axis[i].dontgetup == false)) {
      feign_enemy[feign_enemy.size] = axis[i];
      axis[i] thread event3_feign_getup(node);
      wait(0.5);
    }
  }
  feign_enemy = array_removeDead(feign_enemy);
  waittill_dead(feign_enemy, feign_enemy.size - 5);
  spawners = getEntArray("event3_backup_spawners", "targetname");
  maps\_spawner::flood_spawner_scripted(spawners);
  level thread event3_charge();
}

event3_charge() {
  trigger = GetEnt("event3_charge_trigger", "targetname");
  while(1) {
    trigger waittill("trigger", other);
    if(isDefined(other.script_noteworthy) && other.script_noteworthy == "event3_backup_guys") {
      break;
    }
    wait(0.1);
  }
  flag_set("event3_charge");
}

event3_feign_getup(node) {
  wait(2 + RandomFloat(2));
  self notify("stop_feign");
  if(self.animname != "feign_guy1" && self.animname != "feign_guy4") {
    self anim_single_solo(self, "getup", undefined, node);
  } else {
    self anim_single_solo(self, "getup");
  }
  self.ignoreall = false;
  self.ignoreme = false;
  self.activatecrosshair = true;
}

event4_tower_impact(ent) {
  exploder(600);
}

held_guy_blood_Fx(guy) {
  ally = GetEnt("ally_held_down", "targetname");;
  origin = ally GetTagOrigin("j_neck");
  playFX(level._effect["flesh_hit"], origin);
  axis = getEntArray("axis_held_down", "targetname");
  for(i = 0; i < axis.size; i++) {
    axis[i] disable_long_death();
    axis[i].skipDeathAnim = true;
    axis[i].allowdeath = true;
    axis[i].ignoreme = false;
    axis[i].ignoreall = false;
  }
}

event6_outtro_strike(guy) {
  players = get_players();
  if(players.size < 2) {
    level thread maps\mak::timescale_duration(0.2, 0.5, 0.75, 1, 1.0);
  }
  for(i = 0; i < players.size; i++) {
    player = players[i];
    player EnableInvulnerability();
    player thread keep_the_red_flash();
  }
}

keep_the_red_flash() {
  while(!flag("sullivan_at_boat")) {
    self player_flag_waitopen("player_has_red_flashing_overlay");
    self player_flag_set("player_has_red_flashing_overlay");
  }
}

event6_sullivan_outtro(guy) {
  level.sullivan.goalradius = 16;
  level.sullivan.ignoreall = true;
  level.sullivan.dontavoidplayer = true;
  level.sullivan disable_ai_color();
  level.sullivan maps\mak::disable_arrivals(true, true);
  node = GetNode("event6_ambush_node", "targetname");
  level anim_single_solo(level.sullivan, "outtro_start", undefined, node);
  level notify("link_player_to_sullivan");
  level.sullivan setCanDamage(false);
  level.sullivan set_run_anim("outtro_loop", true);
  level.sullivan thread anim_single_solo(level.sullivan, "i_got_you");
  node = GetNode("boat1_enter", "targetname");
  level.sullivan.goalradius = 16;
  level.sullivan SetGoalNode(node);
  level.sullivan waittill("goal");
  flag_set("sullivan_at_boat");
}

event6_outtro_sullivan_in_boat(guy) {
  flag_set("sullivan_boat_in");
}

event6_outtro_detach_shotgun(guy) {
  guy gun_remove();
}

#using_animtree("mak_models");

geo_hut1_collapse() {
  PrecacheModel("anim_makin_ewok_tower");
  level.scr_animtree["hut1"] = #animtree;
  level.scr_model["hut1"] = "anim_makin_ewok_tower";
  level.scr_anim["hut1"]["collapse"] = % o_makin_ewok_tower;
  addnotetrack_customfunction("hut1", "big_splash", ::hut1_splash, "collapse");
  addnotetrack_sound("hut1", "big_splash", "big_splash", "tower_splash");
}

geo_hut4_pieces() {
  level.scr_animtree["hut4_pieces"] = #animtree;
  level.scr_model["hut4_pieces"] = "anim_intro_hut_explosion";
  level.scr_anim["hut4_pieces"]["explode"] = % o_makin_mainhut_explosion;
  addnotetrack_customfunction("hut4_pieces", "hut_hit", ::hut4_hit_hut, "explode");
}

geo_intro_hut_light() {
  level.scr_animtree["intro_hut_light"] = #animtree;
  level.scr_model["intro_hut_light"] = "tag_origin_animate";
  level.scr_anim["intro_hut_light"]["knock_down"] = % o_makin_animlight_introhut;
}

geo_under_hut_collapse(guy) {
  level.scr_animtree["under_hut_debris"] = #animtree;
  level.scr_model["under_hut_debris"] = "anim_makin_hutbeamcollapse";
  level.scr_anim["under_hut_debris"]["collapse"] = % o_makin_mainhut_beamcollapse;
}

geo_guy_to_shed() {
  level.scr_animtree["guy_2_shed_geo"] = #animtree;
  level.scr_model["guy_2_shed_geo"] = "anim_peleliu_fly2shed";
  level.scr_anim["guy_2_shed_geo"]["collapse"] = % o_makinraid_shed_impact;
}

event1_mg_tarp() {
  level.scr_animtree["event1_mg_curtains"] = #animtree;
  level.scr_anim["event1_mg_curtains"]["intro"] = % o_clothblinders_flap_intro;
  level.scr_anim["event1_mg_curtains"]["loop"] = % o_clothblinders_flap_loop;
  level.scr_anim["event1_mg_curtains"]["outro"] = % o_clothblinders_flap_outro;
}

event2_mg_net() {
  level.scr_animtree["event2_mg_net"] = #animtree;
  level.scr_anim["event2_mg_net"]["intro"] = % o_makin_LMG_canopy_intro;
  level.scr_anim["event2_mg_net"]["loop"] = % o_makin_LMG_canopy_loop;
  level.scr_anim["event2_mg_net"]["outro"] = % o_makin_LMG_canopy_outtro;
}

geo_event4_gates() {
  level.scr_animtree["event4_gate1"] = #animtree;
  level.scr_model["event4_gate1"] = "tag_origin_animate";
  level.scr_anim["event4_gate1"]["crash"] = % o_makin_gate_burstopen_right;
  level.scr_animtree["event4_gate2"] = #animtree;
  level.scr_model["event4_gate2"] = "tag_origin_animate";
  level.scr_anim["event4_gate2"]["crash"] = % o_makin_gate_burstopen_left;
}

model_event4_tower() {
  level.scr_animtree["event4_tower"] = #animtree;
  level.scr_anim["event4_tower"]["intro"] = % o_makin_radiotower_dest_intro;
  level.scr_anim["event4_tower"]["loop"][0] = % o_makin_radiotower_dest_loop;
  level.scr_anim["event4_tower"]["outtro"] = % o_makin_radiotower_dest_outtro;
  addnotetrack_customfunction("event4_tower", "tower_impact", ::event4_tower_impact, "outtro");
}

geo_event5_bunkerdoor() {
  level.scr_animtree["event5_bunkerdoor"] = #animtree;
  level.scr_model["event5_bunkerdoor"] = "tag_origin_animate";
  level.scr_anim["event5_bunkerdoor"]["open"] = % o_makinraid_bunkerdoor_open;
  level.scr_animtree["event4_gate2"] = #animtree;
  level.scr_model["event4_gate2"] = "tag_origin_animate";
  level.scr_anim["event4_gate2"]["crash"] = % o_makin_gate_burstopen_left;
}

geo_event1_door_collapse() {
  level.scr_animtree["event1_door_collapse"] = #animtree;
  level.scr_model["event1_door_collapse"] = "anim_makin_firehut_fall";
  level.scr_anim["event1_door_collapse"]["collapse"] = % o_makin_firehut_fall;
}

#using_animtree("vehicles");

vehicle_anims() {
  level.scr_anim["event4_truck"]["getin_root"] = % makin_truck_other;
  level.scr_anim["event4_truck"]["getin"] = % v_makinraid_truck_jumpin;
  level.scr_anim["event4_truck"]["getout_root"] = % makin_truck_other;
  level.scr_anim["event4_truck"]["getout"] = % v_makinraid_truck_jumpout;
  level.scr_anim["event4_truck"]["hatch_open"] = % v_makinraid_hatch;
  level.scr_anim["event4_truck"]["init"] = % v_makinraid_hatch_barrel;
  level.scr_anim["event4_truck"]["drive_start"] = % v_makinraid_hatch_loop_start;
  level.scr_anim["event4_truck"]["drive_loop"] = % v_makinraid_hatch_loop;
}

play_vehicle_anim(anime) {
  self SetFlaggedAnimKnobRestart("blend_anim" + anime, level.scr_anim[self.animname][anime], 1, 0.2, 1);
  for(;;) {
    self waittill("blend_anim" + anime, notetrack);
    if(notetrack == "end") {
      return;
    } else if(notetrack == "fuel_spout") {
      self thread event4_start_fuel_spill();
    }
  }
}

play_vehicle_animloop(anime, end_on) {
  self endon(end_on);
  while(1) {
    self SetFlaggedAnimKnobRestart("blend_animloop" + anime, level.scr_anim[self.animname][anime], 1, 0.2, 1);
    self waittillmatch("blend_animloop" + anime, "end");
  }
}

#using_animtree("player");

player_anims() {
  level.scr_animtree["player_hands"] = #animtree;
  level.scr_model["player_hands"] = "viewmodel_usa_raider_player";
  level.scr_anim["player_hands"]["intro"] = % int_makinraid_intro;
  addnotetrack_attach("player_hands", "attach_helmet", "clutter_peleliu_us_helmet", "tag_weapon", "intro");
  addnotetrack_detach("player_hands", "detah_helmet", "clutter_peleliu_us_helmet", "tag_weapon", "intro");
  level.scr_model["player_hands"] = "viewmodel_usa_raider_player";
  level.scr_anim["player_hands"]["event4_truck"] = % int_makinraid_hatch;
  level.scr_model["player_hands"] = "viewmodel_usa_raider_player";
  level.scr_anim["player_hands"]["outtro"] = % int_makinraid_outro;
  level.scr_model["player_hands"] = "viewmodel_usa_raider_player";
  level.scr_anim["player_hands"]["outtro2"] = % int_makinraid_outro_raft_jumpin;
}

all_players_play_viewhands(anime, node, lerp, lerp_time, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo, targetname) {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] thread play_viewhands(anime, node, lerp, lerp_time, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo, targetname);
  }
}

play_viewhands(anime, node, lerp, lerp_time, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo, targetname, after_lerp_func) {
  self endon("disconnect");
  viewhands = spawn_anim_model("player_hands");
  if(anime == "event4_truck") {
    viewhands Attach("viewmodel_usa_kbar_knife", "tag_weapon");
  }
  viewhands Hide();
  self.viewhands = viewhands;
  if(isDefined(targetname)) {
    viewhands.targetname = targetname;
  }
  org = GetStartOrigin(node.origin, node.angles, level.scr_anim["player_hands"][anime]);
  angles = GetStartAngles(node.origin, node.angles, level.scr_anim["player_hands"][anime]);
  viewhands.origin = org;
  viewhands.angles = angles;
  viewhands SetVisibleToPlayer(self);
  if(anime == "intro") {
    angles = viewhands GetTagAngles("tag_player");
    self SetPlayerAngles(angles);
  }
  if(lerp) {
    self lerp_player_view_to_tag(viewhands, "tag_player", lerp_time, fraction, right_arc, left_arc, top_arc, bottom_arc);
    self notify("player_view_lerped");
  } else {
    if(anime == "intro" && !is_mature()) {
      self thread non_mature_intro(viewhands, fraction, right_arc, left_arc, top_arc, bottom_arc);
    } else {
      self PlayerLinkTo(viewhands, "tag_player", fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo);
    }
  }
  if(!isDefined(targetname) || targetname != "intro_hands") {
    viewhands Show();
  }
  if(isDefined(after_lerp_func)) {
    level thread[[after_lerp_func]]();
  }
  node anim_single_solo(viewhands, anime);
  self Unlink();
  viewhands Delete();
  level notify(anime + "_viewhands_anim_done");
  self notify(anime + "_viewhands_anim_done");
}

non_mature_intro(viewhands, fraction, right_arc, left_arc, top_arc, bottom_arc) {
  if(!isDefined(level.og_fov)) {
    level.og_fov = GetDvarInt("cg_fov");
  }
  wait(0.1);
  self PlayerLinkTo(viewhands, "tag_player", 0);
  self FreezeControls(true);
  wait(0.1);
  self thread lerp_fov(30, 0.1, 10);
  officer = GetEnt("intro_officer", "script_noteworthy");
  self thread lerp_player_view_at_ent(officer, 0.1, "j_neck", (-11, 14, 0));
  wait(10);
  self thread lerp_fov(22, 4, 20);
  ent = getstruct("event1_blood_spray_target", "targetname");
  self thread lerp_player_view_at_ent(ent, 4, undefined, (-2, 0, 0));
  wait(20);
  self thread lerp_player_view_at_ent(ent, 10, undefined, (-5, 0, 0));
  level waittill("intro_rejoin_player_to_hands");
  time = 2;
  self thread lerp_fov(level.og_fov, time);
  self lerp_player_view_to_angles(viewhands GetTagAngles("tag_player"), time, (-20, -20, 0));
  self Unlink();
  waittillframeend;
  self PlayerLinkTo(viewhands, "tag_player", fraction, right_arc, left_arc, top_arc, bottom_arc, false);
  self FreezeControls(false);
}

fov_thread(value, duration, time) {
  time = 0;
  while(time < duration) {
    self SetClientDvar("cg_fov", value);
    wait 0.3;
    time += 0.3;
  }
}

lerp_fov(new_fov, time, wait_time) {
  curr_fov = GetDvarInt("cg_fov");
  steps = time * 20;
  div = (curr_fov - new_fov) / steps;
  for(i = 0; i < steps; i++) {
    curr_fov -= div;
    if(curr_fov < 5) {
      curr_fov = 5;
    }
    self SetClientDvar("cg_fov", curr_fov);
    maps\mak::set_player_attrib("fov", curr_fov);
    wait(0.05);
  }
  if(isDefined(wait_time)) {
    self thread fov_thread(new_fov, wait_time);
  }
  self SetClientDvar("cg_fov", new_fov);
  maps\mak::set_player_attrib("fov", new_fov);
}

lerp_player_view_at_ent(ent, time, tag, offset) {
  eye_pos = self getEye();
  if(isDefined(tag)) {
    new_angles = VectorToAngles(ent GetTagOrigin(tag) - eye_pos);
  } else {
    new_angles = VectorToAngles(ent.origin - eye_pos);
  }
  self lerp_player_view_to_angles(new_angles, time, offset);
}

lerp_player_view_to_angles(new_angles, time, offset) {
  if(isDefined(offset)) {
    new_angles += offset;
  }
  new_angles = maps\mak::angles_normalize_180(new_angles);
  curr_angles = self GetPlayerAngles();
  steps = time * 20;
  diff = maps\mak::angles_normalize_180(curr_angles - new_angles);
  div = (diff) / steps;
  for(i = 0; i < steps; i++) {
    curr_angles -= div;
    self SetPlayerAngles(curr_angles);
    wait(0.05);
  }
  self SetPlayerAngles(new_angles);
}

print_tag_pos(tag_name, extra) {
  if(!isDefined(extra)) {
    extra = "";
  }
  wait(1);
  println(extra + " : " + tag_name + " origin = ", self GetTagOrigin(tag_name));
  println(extra + " : " + tag_name + " angles = ", self GetTagAngles(tag_name));
}

player_into_character(spawner) {
  guy = maps\mak::spawn_guy(spawner);
  spawner Delete();
  offset = (0, 0, 30);
  dist = 100;
  angle = (0, 180, 0);
  tag = "j_head";
  time = 4;
  view_height = self GetPlayerViewHeight();
  guy.dontavoidplayer = true;
  forward = anglesToForward(guy.angles + angle);
  start_pos = guy GetTagOrigin(tag) + vector_multiply(forward, dist);
  start_pos = start_pos + offset - (0, 0, view_height);
  org = spawn("script_origin", start_pos);
  org.angles = VectorToAngles((guy GetTagOrigin(tag) - (0, 0, view_height)) - org.origin);
  self PlayerLinkTo(org, "", 1, 5, 5, 5, 5);
  org MoveTo(guy GetTagOrigin(tag) - (0, 0, view_height), time, 0, time * 0.5);
  org RotateTo(guy.angles, time, 0, time * 0.5);
  while(DistanceSquared(org.origin, guy GetTagOrigin(tag) - (0, 0, view_height)) > 12 * 12) {
    wait(0.05);
  }
  guy Delete();
  org waittill("movedone");
  self Unlink();
  org Delete();
  self notify("into_character_done");
}

#using_animtree("generic_human");

anim_loop_blend(guy, anime, tag, ender, entity, blend_time) {
  guy endon("death");
  if(!isDefined(ender)) {
    ender = "stop_loop";
  }
  if(!isDefined(blend_time)) {
    blend_time = 0.2;
  }
  thread mak_endonRemoveAnimActive(ender, guy);
  self endon(ender);
  self thread looping_anim_ender(guy, ender);
  anim_string = "looping anim";
  base_animname = guy.animname;
  idleanim = 0;
  lastIdleanim = 0;
  while(1) {
    pos = get_anim_position(tag, entity);
    org = pos["origin"];
    angles = pos["angles"];
    entity = entity;
    if(!isDefined(org)) {
      org = guy.origin;
    }
    if(!isDefined(angles)) {
      angles = guy.angles;
    }
    doFacialanim = false;
    doDialogue = false;
    doAnimation = false;
    doText = false;
    facialAnim = undefined;
    dialogue = undefined;
    animname = guy.animname;
    if(isDefined(level.scr_face[animname]) && isDefined(level.scr_face[animname][anime]) && isDefined(level.scr_face[animname][anime][idleanim])) {
      doFacialanim = true;
      facialAnim = level.scr_face[animname][anime][idleanim];
    }
    if(is_mature() || !pg_loopanim_sound_exists(animname, anime, idleanim)) {
      if(loopanim_sound_exists(animname, anime, idleanim)) {
        doDialogue = true;
        dialogue = level.scr_sound[animname][anime][idleanim];
      }
    } else if(pg_loopanim_sound_exists(animname, anime, idleanim)) {
      doDialogue = true;
      dialogue = level.scr_sound[animname][anime + "_pg"][idleanim];
    }
    if(isDefined(level.scr_animSound[animname]) && isDefined(level.scr_animSound[animname][idleanim + anime])) {
      guy playSound(level.scr_animSound[animname][idleanim + anime]);
    }
    if(isDefined(level.scr_anim[animname]) && isDefined(level.scr_anim[animname][anime])) {
      doAnimation = true;
    }
    if(doAnimation) {
      guy SetFlaggedAnimKnobAllRestart(anim_string, level.scr_anim[animname][anime][idleanim], % body, 1, blend_time, 1);
      animtime = getanimlength(level.scr_anim[animname][anime][idleanim]);
      self thread start_notetrack_wait(guy, anim_string, anime, animname);
      self thread animscriptDoNoteTracksThread(guy, anim_string, anime);
    }
    if((doFacialanim) || (doDialogue)) {
      if(isai(guy)) {
        if(doAnimation) {
          guy animscripts\face::SaySpecificDialogue(facialAnim, dialogue, 1.0);
        } else {
          guy animscripts\face::SaySpecificDialogue(facialAnim, dialogue, 1.0, anim_string);
        }
      } else {
        guy play_sound_on_entity(dialogue);
      }
    }
    if(doAnimation) {
      guy waittillmatch(anim_string, "end");
    } else if(doDialogue) {
      guy waittill(anim_string);
    }
  }
}

mak_endonRemoveAnimActive(endonString, guy) {
  self endon("newAnimActive");
  self waittill(endonString);
  if(!isDefined(guy)) {
    return;
  }
  guy._animActive--;
  guy._lastAnimTime = getTime();
  assert(guy._animactive >= 0);
}

event4_start_fuel_spill() {
  self thread maps\mak::event4_fuel_trail();
}