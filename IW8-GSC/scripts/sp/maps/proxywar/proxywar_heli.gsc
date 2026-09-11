/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\proxywar\proxywar_heli.gsc
******************************************************/

function bink_intro_start() {
  intro_setup();
}

function bink_intro_main() {
  thread scripts\sp\maps\proxywar\proxywar_lighting::lights_off("heli_scene_light");
  visionsetnaked("proxywar_bink_intro", 0);
  level.playerheli thread scripts\common\anim::anim_single_solo(level.player_rig, "bink_intro");
  level.infilheliplayerref scripts\common\anim::anim_single_solo(level.playerheli, "bink_intro");
}

function bink_intro_catchup() {}

function proxywar_heli_flags() {
  scripts\engine\utility::flag_init("player_anim_done");
  scripts\engine\utility::flag_init("started_intro_vectorfield");
}

function proxywar_heli_precache() {
  scripts\sp\player_rig::init_player_rig("viewhands_alex_fullbody");
}

function proxywar_heli_init() {}

function proxywar_heli_hints() {}

function intro_setup() {
  level.infilheliplayerref = scripts\engine\utility::getStruct("ap_infil_heli", "targetname");
  level.infilhelipartnerref = scripts\engine\utility::getStruct("ap_infil_heli_partner", "targetname");
  thread heli_letter_boxing();
  thread scripts\sp\maps\proxywar\proxywar_util::set_wind(3, 0.2, 3, 40, 1);
  setsaveddvar("NQQSKRQMTS", 0);
  level.playerheli = scripts\common\vehicle::spawn_vehicle_from_targetname("infil_heli_player");
  setup_heli(level.playerheli, "infil_heli_player");
  thread attach_player_to_heli();
}

function heli_approach_start() {
  intro_setup();
}

function disable_cinematic_skip() {
  wait 0.2;
  setomnvar("ui_is_bink_skipping_enabled", 0);
}

function heli_approach_main() {
  thread disable_cinematic_skip();
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_music_and_dx", 0.01);
  scripts\engine\sp\utility::autosave_by_name("heli_approach");
  scripts\engine\sp\objectives::objective_add("objective", "current", scripts\engine\utility::getStruct("obj_reach_overlook", "targetname").origin, &"PROXYWAR/OBJ_SCOUT_DSC", &"PROXYWAR/OBJ_SCOUT_LBL");
  level.partnerheli = scripts\common\vehicle::spawn_vehicle_from_targetname("infil_heli_partner");
  setup_heli(level.partnerheli, "infil_heli_partner");
  level.playerheli playrumblelooponentity("subtle_tank_rumble");
  level.partnerheli vehicle_turnengineoff();
  level.playerheli vehicle_turnengineoff();
  scripts\sp\maps\proxywar\proxywar_util::spawn_ally_teams();
  var0 = scripts\sp\maps\proxywar\proxywar_util::spawn_third_person_alex();
  var0 linkTo(level.playerheli);
  thread cine_settings(var0);
  level thread scripts\sp\maps\proxywar\proxywar_vo::vo_fo_heli_complete();
  thread wait_turn_off_rotor_wash();
  thread play_alex_anim();
  thread play_heli_scene(level.playerheli, level.infilheliplayerref);
  thread play_heli_scene(level.partnerheli, level.infilhelipartnerref);
  thread alpha_team_enter(level.alpha_team);
  scripts\engine\utility::array_thread(level.bravo_team, &allies_approach, level.partnerheli);
  thread wait_infil_player_anim();
  var1 = getDvar("OMNONNMOTP");
  setsaveddvar("OMNONNMOTP", "0.1 500 1.5 1000");
  level.player scripts\engine\utility::delaycall(0.388, &playsound, "scn_wp_intro_heli1_close_lr");
  level.playerheli scripts\engine\utility::delaycall(0.388, &playsound, "scn_wp_intro_heli1_lr");
  level.partnerheli scripts\engine\utility::delaycall(0.388, &playsound, "scn_wp_intro_hel2_lr");
  level scripts\engine\utility::delaythread(12, &audio_clear_audio_zone_heli);
  level.playerheli scripts\common\anim::anim_single_solo(level.player_rig, "infil_player");
  setsaveddvar("OMNONNMOTP", var1);
  level.player_rig unlink();
  scripts\sp\player_rig::unlink_player_from_rig();
  thread scripts\sp\player::player_movement_state("creep");
  thread scripts\sp\introscreen::introscreen(1);
}

function audio_clear_audio_zone_heli() {
  level.player clearclienttriggeraudiozone(5);
}

function attach_player_to_heli() {
  level.player dontinterpolate();
  level.playerheli scripts\sp\player_rig::link_player_to_rig("infil_player", undefined, 0, undefined, undefined, 0, 0, 0, 0, 1);
  level.player_rig linkTo(level.playerheli);
  level.player lerpfovscalefactor(0, 0);
  level.player modifybasefov(40, 0.05);
}

function cine_settings(var0) {
  level.playerheli scripts\engine\sp\utility::dof_enable_autofocus(1.4, 200, undefined, undefined, "tag_guy9", undefined, 1);
  wait 8;
  var0 scripts\engine\sp\utility::dof_enable_autofocus(1.4, 200, undefined, undefined, "tag_eye", undefined, 1);
  scripts\engine\utility::flag_wait("player_anim_done");
  var0 scripts\engine\sp\utility::dof_enable_autofocus(12, undefined, undefined, undefined, "tag_eye", undefined, 1);
  wait 1;
  level scripts\engine\sp\utility::dof_disable_autofocus();
}

function wait_infil_player_anim() {
  wait getanimlength(level.scr_anim["player_rig"]["infil_player"]) - 1;
  scripts\engine\utility::flag_set("player_anim_done");
}

function setup_heli(var0) {
  self.animname = var0;
  scripts\engine\sp\utility::assign_animtree();
  thread blima_spawn_pilot(var0 + "_pilot");
  thread adjust_vector_field();
}

function adjust_vector_field() {
  waitframe();
  self setscriptablepartstate("vector_field", "off");
  waitframe();

  if(!scripts\engine\utility::flag("started_intro_vectorfield")) {
    scripts\engine\utility::flag_set("started_intro_vectorfield");
    scripts\engine\utility::exploder("intro_vectorfield");
    return;
  }
}

function play_heli_scene(var0, var1) {
  thread fast_rope_approach(var0, self, var1);
  thread commander_approach(self, var1);
  var0 scripts\common\anim::anim_single_solo(self, "infil");
  wait 4;
  blima_delete();
}

function alpha_team_enter(var0) {
  level.alpha1 linkTo(var0);
  level.alpha2 linkTo(var0);
  var0 scripts\common\anim::anim_single(level.alpha_team, "infil");
  level.alpha1 unlink();
  level.alpha2 unlink();
  var0 notify("heli_leaving");
  level notify("helis_leaving");
  level thread scripts\sp\maps\proxywar\proxywar_forest::forest_trees_ally_alpha();
}

function allies_approach(var0) {
  self linkTo(var0);
  level.forestmoveref = scripts\engine\utility::getStruct("forest_move_ref", "targetname");
  var0 scripts\common\anim::anim_single_solo(self, "infil");
  self unlink();
  var0 notify("heli_leaving");
  level.forestmoveref thread scripts\common\anim::anim_loop_solo(self, "forest_move_enter_idle", "end_forest_enter_idle");
}

function fast_rope_approach(var0, var1, var2) {
  var3 = scripts\engine\sp\utility::spawn_anim_model("rope");
  var3 linkTo(var1);
  var1 scripts\common\anim::anim_single_solo(var3, var2);
  var3 unlink();
  var0 scripts\common\anim::anim_single_solo(var3, var2 + "_fall");
  scripts\engine\utility::flag_wait("move_to_patrol");
  var3 delete();
}

function commander_approach(var0, var1) {
  var2 = scripts\engine\sp\utility::spawn_targetname(var1 + "_commander", 1);
  var2.ignoreme = 1;
  var2.animname = "commander";
  level.commander = var2;
  var2 linkTo(var0);
  var0 scripts\common\anim::anim_single_solo(var2, var1);
  var2 unlink();
  var2 delete();
}

function play_alex_anim() {
  level.playerheli scripts\common\anim::anim_single_solo(self, "infil_player");
  self unlink();
  self delete();
}

function heli_letter_boxing() {
  setomnvar("ui_hide_hud", 1);
  hidecinematicletterboxing(0, 0);
  level.player scripts\common\utility::allow_cinematic_motion(0);
  level waittill("player_on_rope");
  getrandomnodedestination(1.5, 0);
  level.player scripts\common\utility::allow_cinematic_motion(1);
  wait 1.5;
  setomnvar("ui_hide_hud", 0);
}

function heli_volume() {
  self scalevolume(0, 0);
  waitframe();
  self scalevolume(0.15, 10);
  self waittill("heli_leaving");
  self scalevolume(0, 45);
}

function wait_turn_off_rotor_wash() {
  level waittill("helis_leaving");
  wait 8;
  scripts\engine\utility::stop_exploder("intro_vectorfield");
}

function heli_approach_catchup() {
  scripts\engine\sp\objectives::objective_add("objective", "current", scripts\engine\utility::getStruct("obj_reach_overlook", "targetname").origin, &"PROXYWAR/OBJ_SCOUT_DSC", &"PROXYWAR/OBJ_SCOUT_LBL");
}

function blima_spawn_pilot(var0) {
  var1 = scripts\engine\sp\utility::spawn_targetname(var0, 1);
  var1.ignoreme = 1;
  var1.script_startingposition = 0;
  scripts\common\vehicle_aianim::guy_enter(var1);
  self.pilot = var1;
}

function blima_delete() {
  if(isDefined(self.pilot)) {
    self.pilot delete();
  }

  self delete();
}