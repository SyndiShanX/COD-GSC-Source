/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\proxywar\proxywar_heli.gsc
***********************************************/

bink_intro_start() {
  intro_setup();
}

bink_intro_main() {
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("heli_scene_light");
  visionsetnaked("proxywar_bink_intro", 0);
  level.playerheli thread scripts\common\anim::anim_single_solo(level.player_rig, "bink_intro");
  level.infilheliplayerref scripts\common\anim::anim_single_solo(level.playerheli, "bink_intro");
}

bink_intro_catchup() {}

proxywar_heli_flags() {
  scripts\engine\utility::flag_init("player_anim_done");
  scripts\engine\utility::flag_init("started_intro_vectorfield");
}

proxywar_heli_precache() {
  scripts\sp\player_rig::init_player_rig("viewhands_alex_fullbody");
}

proxywar_heli_init() {}

proxywar_heli_hints() {}

intro_setup() {
  level.infilheliplayerref = scripts\engine\utility::getStruct("ap_infil_heli", "targetname");
  level.infilhelipartnerref = scripts\engine\utility::getStruct("ap_infil_heli_partner", "targetname");
  thread heli_letter_boxing();
  thread scripts\sp\maps\proxywar\proxywar_util.gsc::set_wind(3, 0.2, 3, 40, 1);
  setsaveddvar("NQQSKRQMTS", 0);
  level.playerheli = scripts\common\vehicle::spawn_vehicle_from_targetname("infil_heli_player");
  level.playerheli setup_heli("infil_heli_player");
  level thread attach_player_to_heli();
}

heli_approach_start() {
  intro_setup();
}

disable_cinematic_skip() {
  wait 0.2;
  setomnvar("ui_is_bink_skipping_enabled", 0);
}

heli_approach_main() {
  thread disable_cinematic_skip();
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_music_and_dx", 0.01);
  scripts\engine\sp\utility::autosave_by_name("heli_approach");
  scripts\engine\sp\objectives::objective_add("objective", "current", scripts\engine\utility::getStruct("obj_reach_overlook", "targetname").origin, &"PROXYWAR/OBJ_SCOUT_DSC", &"PROXYWAR/OBJ_SCOUT_LBL");
  level.partnerheli = scripts\common\vehicle::spawn_vehicle_from_targetname("infil_heli_partner");
  level.partnerheli setup_heli("infil_heli_partner");
  level.playerheli playrumblelooponentity("subtle_tank_rumble");
  level.partnerheli vehicle_turnengineoff();
  level.playerheli vehicle_turnengineoff();
  scripts\sp\maps\proxywar\proxywar_util.gsc::spawn_ally_teams();
  var_0 = scripts\sp\maps\proxywar\proxywar_util.gsc::spawn_third_person_alex();
  var_0 linkTo(level.playerheli);
  thread cine_settings(var_0);
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fo_heli_complete();
  level thread wait_turn_off_rotor_wash();
  var_0 thread play_alex_anim();
  level.playerheli thread play_heli_scene(level.infilheliplayerref, "infil_heli_player");
  level.partnerheli thread play_heli_scene(level.infilhelipartnerref, "infil_heli_partner");
  level.alpha_team thread alpha_team_enter(level.playerheli);
  scripts\engine\utility::array_thread(level.bravo_team, ::allies_approach, level.partnerheli);
  thread wait_infil_player_anim();
  var_1 = getDvar("OMNONNMOTP");
  setsaveddvar("OMNONNMOTP", "0.1 500 1.5 1000");
  level.player scripts\engine\utility::delaycall(0.388, ::playsound, "scn_wp_intro_heli1_close_lr");
  level.playerheli scripts\engine\utility::delaycall(0.388, ::playsound, "scn_wp_intro_heli1_lr");
  level.partnerheli scripts\engine\utility::delaycall(0.388, ::playsound, "scn_wp_intro_hel2_lr");
  level scripts\engine\utility::delaythread(12, ::audio_clear_audio_zone_heli);
  level.playerheli scripts\common\anim::anim_single_solo(level.player_rig, "infil_player");
  setsaveddvar("OMNONNMOTP", var_1);
  level.player_rig unlink();
  scripts\sp\player_rig::unlink_player_from_rig();
  thread scripts\sp\player::player_movement_state("creep");
  thread scripts\sp\introscreen::introscreen(1);
}

audio_clear_audio_zone_heli() {
  level.player clearclienttriggeraudiozone(5.0);
}

attach_player_to_heli() {
  level.player dontinterpolate();
  level.playerheli scripts\sp\player_rig::link_player_to_rig("infil_player", undefined, 0, undefined, undefined, 0, 0, 0, 0, 1);
  level.player_rig linkTo(level.playerheli);
  level.player lerpfovscalefactor(0, 0);
  level.player modifybasefov(40, 0.05);
}

cine_settings(var_0) {
  level.playerheli scripts\engine\sp\utility::dof_enable_autofocus(1.4, 200, undefined, undefined, "tag_guy9", undefined, 1);
  wait 8;
  var_0 scripts\engine\sp\utility::dof_enable_autofocus(1.4, 200, undefined, undefined, "tag_eye", undefined, 1);
  scripts\engine\utility::flag_wait("player_anim_done");
  var_0 scripts\engine\sp\utility::dof_enable_autofocus(12, undefined, undefined, undefined, "tag_eye", undefined, 1);
  wait 1;
  level scripts\engine\sp\utility::dof_disable_autofocus();
}

wait_infil_player_anim() {
  wait(getanimlength(level.scr_anim["player_rig"]["infil_player"]) - 1);
  scripts\engine\utility::flag_set("player_anim_done");
}

setup_heli(var_0) {
  self.animname = var_0;
  scripts\engine\sp\utility::assign_animtree();
  thread blima_spawn_pilot(var_0 + "_pilot");
  thread adjust_vector_field();
}

adjust_vector_field() {
  waitframe();
  self setscriptablepartstate("vector_field", "off");
  waitframe();

  if(!scripts\engine\utility::flag("started_intro_vectorfield")) {
    scripts\engine\utility::flag_set("started_intro_vectorfield");
    scripts\engine\utility::exploder("intro_vectorfield");
  }
}

play_heli_scene(var_0, var_1) {
  thread fast_rope_approach(var_0, self, var_1);
  thread commander_approach(self, var_1);
  var_0 scripts\common\anim::anim_single_solo(self, "infil");
  wait 4;
  blima_delete();
}

alpha_team_enter(var_0) {
  level.alpha1 linkTo(var_0);
  level.alpha2 linkTo(var_0);
  var_0 scripts\common\anim::anim_single(level.alpha_team, "infil");
  level.alpha1 unlink();
  level.alpha2 unlink();
  var_0 notify("heli_leaving");
  level notify("helis_leaving");
  level thread scripts\sp\maps\proxywar\proxywar_forest.gsc::forest_trees_ally_alpha();
}

allies_approach(var_0) {
  self linkTo(var_0);
  level.forestmoveref = scripts\engine\utility::getStruct("forest_move_ref", "targetname");
  var_0 scripts\common\anim::anim_single_solo(self, "infil");
  self unlink();
  var_0 notify("heli_leaving");
  level.forestmoveref thread scripts\common\anim::anim_loop_solo(self, "forest_move_enter_idle", "end_forest_enter_idle");
}

fast_rope_approach(var_0, var_1, var_2) {
  var_3 = scripts\engine\sp\utility::spawn_anim_model("rope");
  var_3 linkTo(var_1);
  var_1 scripts\common\anim::anim_single_solo(var_3, var_2);
  var_3 unlink();
  var_0 scripts\common\anim::anim_single_solo(var_3, var_2 + "_fall");
  scripts\engine\utility::flag_wait("move_to_patrol");
  var_3 delete();
}

commander_approach(var_0, var_1) {
  var_2 = scripts\engine\sp\utility::spawn_targetname(var_1 + "_commander", 1);
  var_2.ignoreme = 1;
  var_2.animname = "commander";
  level.commander = var_2;
  var_2 linkTo(var_0);
  var_0 scripts\common\anim::anim_single_solo(var_2, var_1);
  var_2 unlink();
  var_2 delete();
}

play_alex_anim() {
  level.playerheli scripts\common\anim::anim_single_solo(self, "infil_player");
  self unlink();
  self delete();
}

heli_letter_boxing() {
  setomnvar("ui_hide_hud", 1);
  hidecinematicletterboxing(0, 0);
  level.player scripts\common\utility::allow_cinematic_motion(0);
  level waittill("player_on_rope");
  getrandomnodedestination(1.5, 0);
  level.player scripts\common\utility::allow_cinematic_motion(1);
  wait 1.5;
  setomnvar("ui_hide_hud", 0);
}

heli_volume() {
  self scalevolume(0.0, 0.0);
  waitframe();
  self scalevolume(0.15, 10.0);
  self waittill("heli_leaving");
  self scalevolume(0.0, 45.0);
}

wait_turn_off_rotor_wash() {
  level waittill("helis_leaving");
  wait 8;
  scripts\engine\utility::stop_exploder("intro_vectorfield");
}

heli_approach_catchup() {
  scripts\engine\sp\objectives::objective_add("objective", "current", scripts\engine\utility::getStruct("obj_reach_overlook", "targetname").origin, &"PROXYWAR/OBJ_SCOUT_DSC", &"PROXYWAR/OBJ_SCOUT_LBL");
}

blima_spawn_pilot(var_0) {
  var_1 = scripts\engine\sp\utility::spawn_targetname(var_0, 1);
  var_1.ignoreme = 1;
  var_1.script_startingposition = 0;
  scripts\common\vehicle_aianim::guy_enter(var_1);
  self.pilot = var_1;
}

blima_delete() {
  if(isDefined(self.pilot))
    self.pilot delete();

  self delete();
}