/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\jungle_ghosts_anim.gsc
***************************************/

main() {
  maps\_hand_signals::inithandsignals();
  maps\_patrol_anims::main();
  player_anims();
  generic_human_anims();
  vehicle_anims();
  script_model_anims();
  script_model();
  the_dog();
}

#using_animtree("generic_human");

generic_human_anims() {
  level.scr_anim["generic"]["active_patrolwalk_gundown"] = % active_patrolwalk_gundown;
  level.scr_anim["generic"]["ambush_react1"] = % cqb_stand_react_a;
  level.scr_anim["generic"]["ambush_react2"] = % cqb_stand_react_b;
  level.scr_anim["generic"]["ambush_react3"] = % cqb_stand_react_c;
  level.scr_anim["generic"]["ambush_react4"] = % cqb_stand_react_d;
  level.scr_anim["generic"]["ambush_react5"] = % cqb_stand_react_e;
  level.scr_anim["guy1"]["helpup_lookout"] = % jungle_ghost_lookout_helpup_guy1;
  level.scr_anim["guy2"]["helpup_lookout"] = % jungle_ghost_lookout_helpup_guy2;
  level.scr_anim["guy1"]["meeting"] = % jungle_ghost_patrol_meeting_guy1;
  level.scr_anim["guy2"]["meeting"] = % jungle_ghost_patrol_meeting_guy2;
  level.scr_anim["guy3"]["meeting"] = % jungle_ghost_patrol_meeting_guy3;
  level.scr_anim["generic"]["meeting_idle1"][0] = % jungle_ghost_patrol_meeting_idle_guy1;
  level.scr_anim["generic"]["meeting_idle2"][0] = % jungle_ghost_patrol_meeting_idle_guy2;
  level.scr_anim["generic"]["meeting_idle3"][0] = % jungle_ghost_patrol_meeting_idle_guy3;
  level.scr_anim["generic"]["cliff_look"][0] = % jungle_ghost_cliff_looker;
  level.scr_anim["generic"]["cliff_look_react"] = % exposed_idle_reacta;
  level.scr_anim["generic"]["chopper_crate_directing"][0] = % london_loader3_loading;
  level.scr_anim["generic"]["run_reaction_180"] = % run_reaction_180;
  level.scr_anim["generic"]["run_reaction_L_quick"] = % run_reaction_l_quick;
  level.scr_anim["generic"]["jungle_ghost_ai_slide1"] = % jungle_ghost_ai_slide_guy1;
  level.scr_anim["generic"]["jungle_ghost_ai_slide2"] = % jungle_ghost_ai_slide_guy2;
  level.scr_anim["generic"]["swim_idle"][0] = % prague_intro_swim_idle_01;
  level.scr_anim["generic"]["swim"] = % prague_intro_swim_breaststroke_01;
  level.scr_anim["generic"]["swim_fast"] = % prague_intro_swim_breaststroke_02;
  level.scr_anim["generic"]["signal_stop_swim"] = % prague_intro_swim_holdposition;
  level.scr_anim["generic"]["jungle_ghost_wf_escape_jumpoff_guy1"] = % jungle_ghost_wf_escape_jumpoff_guy1;
  level.scr_anim["generic"]["jungle_ghost_wf_escape_jumpoff_guy2"] = % jungle_ghost_wf_escape_jumpoff_guy2;
  level.scr_anim["generic"]["patrol_jog_360_once"] = % patrol_jog_360_once;
  level.scr_anim["generic"]["patrol_jog_orders_once"] = % patrol_jog_orders_once;
  level.scr_anim["generic"]["patrol_jog"] = % patrol_jog;
  level.scr_anim["generic"]["water_walk_1"] = % water_walk_01;
  level.scr_anim["generic"]["water_walk_2"] = % water_walk_02;
  level.scr_anim["generic"]["water_run_1"] = % water_run_01;
  level.scr_anim["generic"]["water_run_2"] = % water_run_02;
  level.scr_anim["pilot"]["new_crash"] = % jungle_ghost_helicrash_pilot;
  level.scr_anim["pilot"]["new_crash_idle"][0] = % jungle_ghost_helicrash_pilot_idle;
  level.scr_anim["dead_jungle_pilot"]["dead_idle"][0] = % paris_npc_dead_poses_v24_chair_sq;
  level.scr_anim["guard_a_1"]["water_walk_1"] = % water_walk_01;
  level.scr_anim["guard_a_2"]["water_walk_1"] = % water_walk_01;
  level.scr_anim["hostage_a"]["water_walk_1"] = % water_walk_01;
  level.scr_anim["guard_b_1"]["water_walk_1"] = % water_walk_01;
  level.scr_anim["guard_b_2"]["water_walk_1"] = % water_walk_01;
  level.scr_anim["hostage_b"]["water_walk_1"] = % water_walk_01;
  level.scr_anim["guard_a_1"]["rescue_a_idle"][0] = % jg_river_rescue_a_guard_1_idle;
  level.scr_anim["guard_a_2"]["rescue_a_idle"][0] = % jg_river_rescue_a_guard_2_idle;
  level.scr_anim["hostage_a"]["rescue_a_idle"][0] = % jg_river_rescue_a_hostage_idle;
  level.scr_anim["guard_b_1"]["rescue_b_idle"][0] = % jg_river_rescue_b_guard_1_idle;
  level.scr_anim["guard_b_2"]["rescue_b_idle"][0] = % jg_river_rescue_b_guard_2_idle;
  level.scr_anim["hostage_b"]["rescue_b_idle"][0] = % jg_river_rescue_b_hostage_idle;
  level.scr_anim["guard_a_1"]["rescue_a"] = % jg_river_rescue_a_guard_1;
  level.scr_anim["guard_a_2"]["rescue_a"] = % jg_river_rescue_a_guard_2;
  level.scr_anim["hostage_a"]["rescue_a"] = % jg_river_rescue_a_hostage;
  level.scr_anim["guard_a_1"]["rescue_a_shot"] = % jg_river_rescue_a_shot_guard_1;
  level.scr_anim["guard_a_2"]["rescue_a_shot"] = % jg_river_rescue_a_shot_guard_2;
  level.scr_anim["hostage_a"]["rescue_a_shot"] = % jg_river_rescue_a_shot_hostage;
  level.scr_anim["guard_b_1"]["rescue_b"] = % jg_river_rescue_b_guard_1;
  level.scr_anim["guard_b_2"]["rescue_b"] = % jg_river_rescue_b_guard_2;
  level.scr_anim["hostage_b"]["rescue_b"] = % jg_river_rescue_b_hostage;
  level.scr_anim["guard_b_1"]["rescue_b_shot"] = % jg_river_rescue_b_shot_guard_1;
  level.scr_anim["guard_b_2"]["rescue_b_shot"] = % jg_river_rescue_b_shot_guard_2;
  level.scr_anim["hostage_b"]["rescue_b_shot"] = % jg_river_rescue_b_shot_hostage;
  level.scr_anim["alpha1"]["elias_rescue"] = % jungleghost_waterfall_elias_rescue;
  maps\_anim::addnotetrack_customfunction("alpha1", "missle", ::set_missile_reaction, "elias_rescue");
  maps\_anim::addnotetrack_customfunction("alpha1", "jungleg_bkr_coughingcatchingbreath", ::set_missile_reply, "elias_rescue");
  maps\_anim::addnotetrack_customfunction("hostage_b", "fire", ::hostage_fire_single_left, "rescue_b");
  maps\_anim::addnotetrack_customfunction("hostage_b", "pistol_on", ::attach_pistol_left, "rescue_b");
  maps\_anim::addnotetrack_customfunction("hostage_b", "pistol_off", ::detach_pistol_left, "rescue_b");
  maps\_anim::addnotetrack_customfunction("hostage_b", "fire_spray", ::hostage_fire_spray, "rescue_b_shot");
  maps\_anim::addnotetrack_customfunction("hostage_a", "fire", ::hostage_fire_single_right, "rescue_a");
  maps\_anim::addnotetrack_customfunction("hostage_a", "pistol_on", ::attach_pistol_right, "rescue_a");
  maps\_anim::addnotetrack_customfunction("hostage_a", "pistol_off", ::detach_pistol_right, "rescue_a");
  maps\_anim::addnotetrack_customfunction("hostage_a", "swap_gun", ::swap_to_regular_gun, "rescue_a_shot");
  maps\_anim::addnotetrack_customfunction("hostage_a", "fire_spray", ::hostage_fire_spray, "rescue_a_shot");
  maps\_anim::addnotetrack_customfunction("guard_a_1", "bodyfall large", ::body_is_falling, "rescue_a");
  maps\_anim::addnotetrack_customfunction("guard_a_1", "bodyfall large", ::body_is_falling, "rescue_a_shot");
  maps\_anim::addnotetrack_customfunction("guard_a_2", "bodyfall large", ::body_is_falling, "rescue_a");
  maps\_anim::addnotetrack_customfunction("guard_a_2", "bodyfall large", ::body_is_falling, "rescue_a_shot");
  maps\_anim::addnotetrack_customfunction("guard_b_1", "bodyfall large", ::body_is_falling, "rescue_b");
  maps\_anim::addnotetrack_customfunction("guard_b_1", "bodyfall large", ::body_is_falling, "rescue_b_shot");
  maps\_anim::addnotetrack_customfunction("guard_b_2", "bodyfall large", ::body_is_falling, "rescue_b");
  maps\_anim::addnotetrack_customfunction("guard_b_2", "bodyfall large", ::body_is_falling, "rescue_b_shot");
  level.scr_animtree["waving_man"] = #animtree;
  level.scr_model["waving_man"] = "body_us_rangers_smg_a";
  level.scr_anim["waving_man"]["wave"] = % jungle_ghost_boat_wave_in;
}

set_missile_reaction(var_0) {
  common_scripts\utility::flag_set("second_distant_sat_launch");
}

set_missile_reply(var_0) {
  common_scripts\utility::flag_set("do_jungleg_bkr_coughingcatchingbreath");
}

body_is_falling(var_0) {
  var_0.ignoreme = 1;
  var_0.team = "neutral";
  var_0.deathfunction = ::do_rag_death;
  var_0.allowdeath = 1;
  var_0 kill();
}

do_rag_death() {
  self startragdoll();
  wait 0.05;
}

attach_pistol_left(var_0) {
  var_0 attach("weapon_p226", "tag_weapon_left");
}

detach_pistol_left(var_0) {
  var_0 detach("weapon_p226", "tag_weapon_left");
}

hostage_fire_single_left(var_0) {
  magicbullet("p226", var_0 gettagorigin("tag_weapon_left"), var_0 gettagorigin("tag_weapon_left"));
  playFXOnTag(common_scripts\utility::getfx("muzzle_flash_pistol"), var_0, "tag_weapon_left");
}

attach_pistol_right(var_0) {
  var_0 attach("weapon_p226", "tag_weapon_right");
}

detach_pistol_right(var_0) {
  var_0 detach("weapon_p226", "tag_weapon_right");
  var_0 maps\_utility::gun_recall();
}

hostage_fire_single_right(var_0) {
  level.fire_notetracks++;

  if(var_0.name == "Merrick" && !level.execution_guy_dead || level.fire_notetracks == 3) {
    magicbullet("p226", var_0 gettagorigin("tag_flash"), var_0 gettagorigin("tag_flash"));
    playFXOnTag(common_scripts\utility::getfx("muzzle_flash_pistol"), var_0, "tag_flash");
  }
}

swap_to_regular_gun(var_0) {
  var_0 maps\_utility::gun_recall();
}

hostage_fire_spray(var_0) {
  var_1 = 3;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    magicbullet("honeybadger", var_0 gettagorigin("tag_flash"), var_0 gettagorigin("tag_flash"));
    playFXOnTag(common_scripts\utility::getfx("muzzle_flash_pistol"), var_0, "tag_flash");
    wait 0.1;
  }
}

vfx_hostage1_dunk(var_0) {
  playFXOnTag(common_scripts\utility::getfx("drowned_dunk_in"), var_0, "j_wrist_ri");
}

vfx_hostage1_lift(var_0) {
  playFXOnTag(common_scripts\utility::getfx("drowned_dunk_out"), var_0, "j_wrist_ri");
}

vfx_hostage1_waterboard_start(var_0) {
  playFXOnTag(common_scripts\utility::getfx("drowned_waterboarding_loop"), var_0, "j_wrist_ri");
}

vfx_hostage1_waterboard_stop(var_0) {
  stopFXOnTag(common_scripts\utility::getfx("drowned_waterboarding_loop"), var_0, "j_wrist_ri");
}

vfx_hostage1_push_splash(var_0) {
  playFXOnTag(common_scripts\utility::getfx("drowned_push_splash"), var_0, "j_wrist_ri");
}

vfx_hostage1_wateridle_start(var_0) {
  playFXOnTag(common_scripts\utility::getfx("drowned_underwater_loop"), var_0, "j_wrist_ri");
}

vfx_hostage1_wateridle_stop(var_0) {
  stopFXOnTag(common_scripts\utility::getfx("drowned_underwater_loop"), var_0, "j_wrist_ri");
}

vfx_hostage1_liftup(var_0) {
  playFXOnTag(common_scripts\utility::getfx("drowned_lift_out"), var_0, "j_wrist_ri");
}

vfx_hostage1_body_ripple(var_0) {
  playFXOnTag(common_scripts\utility::getfx("drowned_body_ripple"), var_0, "j_wrist_ri");
}

vfx_hostage1_arm_l_splash(var_0) {
  playFXOnTag(common_scripts\utility::getfx("drowned_splash_hand_in"), var_0, "j_wrist_ri");
}

vfx_hostage1_arm_r_splash(var_0) {
  playFXOnTag(common_scripts\utility::getfx("drowned_splash_hand_in"), var_0, "j_wrist_ri");
}

vfx_hostage1_arm_l_liftout(var_0) {
  playFXOnTag(common_scripts\utility::getfx("drowned_splash_hand_out"), var_0, "j_wrist_ri");
}

vfx_hostage1_arm_r_liftout(var_0) {
  playFXOnTag(common_scripts\utility::getfx("drowned_splash_hand_out"), var_0, "j_wrist_ri");
}

vfx_hostage1_arm_r_pushsplash(var_0) {
  playFXOnTag(common_scripts\utility::getfx("drowned_limb_push_splash"), var_0, "j_wrist_ri");
}

vfx_hostage1_leg_l_pushsplash(var_0) {
  playFXOnTag(common_scripts\utility::getfx("drowned_limb_push_splash"), var_0, "j_wrist_ri");
}

vfx_hostage1_leg_l_splash(var_0) {
  playFXOnTag(common_scripts\utility::getfx("drowned_splash_hand_in"), var_0, "j_wrist_ri");
}

vfx_hostage1_leg_r_lift(var_0) {
  playFXOnTag(common_scripts\utility::getfx("drowned_splash_hand_out"), var_0, "j_wrist_ri");
}

vfx_hostage1_leg_r_pushsplash(var_0) {
  playFXOnTag(common_scripts\utility::getfx("drowned_limb_push_splash"), var_0, "j_wrist_ri");
}

intro_takedown_knife_notetrack_func(var_0) {
  var_0 maps\_utility::die();
}

#using_animtree("vehicles");

vehicle_anims() {
  level.scr_animtree["aas"] = #animtree;
  level.scr_model["aas"] = "vehicle_aas_72x_destructible";
  level.scr_anim["aas"]["new_crash"] = % jungle_ghost_helicrash_helicopter;
  level.scr_anim["aas"]["new_crash_idle"][0] = % jungle_ghost_helicrash_helicopter_idle;
  maps\_anim::addnotetrack_customfunction("aas", "heli_killed", ::heli_crash_heli_killed, "new_crash");
  maps\_anim::addnotetrack_customfunction("aas", "box_hit_1", ::heli_crash_box_hit_1, "new_crash");
  maps\_anim::addnotetrack_customfunction("aas", "blade_hit_1", ::heli_crash_blade_hit_1, "new_crash");
  maps\_anim::addnotetrack_customfunction("aas", "engine_fail", ::heli_crash_engine_fail, "new_crash");
  maps\_anim::addnotetrack_customfunction("aas", "box_hit_2", ::heli_crash_box_hit_2, "new_crash");
  maps\_anim::addnotetrack_customfunction("aas", "blade_hit_2", ::heli_crash_blade_hit_2, "new_crash");
  maps\_anim::addnotetrack_customfunction("aas", "blade_swap", ::heli_blade_swap, "new_crash");
  maps\_anim::addnotetrack_customfunction("aas", "chopper_impact", ::heli_chopper_impact, "new_crash");
  maps\_anim::addnotetrack_customfunction("aas", "blade_hit_water", ::heli_crash_blade_hit_water, "new_crash");
  maps\_anim::addnotetrack_customfunction("aas", "tail_rotor_hit", ::heli_crash_tail_rotor_hit, "new_crash");
  maps\_anim::addnotetrack_customfunction("aas", "body_hit_water", ::heli_crash_body_hit_water, "new_crash");
}

heli_crash_heli_killed(var_0) {
  var_0 thread maps\_utility::play_sound_on_entity("scn_jungle_chopper_crash");

  if(common_scripts\utility::flag("do_stream_chopper_fx")) {
    playFXOnTag(common_scripts\utility::getfx("vfx_helicrash_helibodyfire"), var_0, "TAG_ENGINE_LEFT");
    playFXOnTag(common_scripts\utility::getfx("vfx_helicrash_rpg_explosion"), var_0, "TAG_ENGINE_LEFT");
    var_0 playSound("scn_jungle_chopper_hit");
  }
}

heli_crash_box_hit_1(var_0) {
  common_scripts\utility::exploder("box_hit_1");
}

heli_crash_blade_hit_1(var_0) {
  var_0 setModel("vehicle_aas_72x_destructible");
  common_scripts\utility::exploder("blade_hit_1");
}

heli_crash_engine_fail(var_0) {
  common_scripts\utility::exploder("engine_fail");
}

heli_crash_box_hit_2(var_0) {
  common_scripts\utility::exploder("box_hit_2");
  var_1 = 5;
  var_2 = [];

  for(var_3 = 0; var_3 < 20; var_3++) {
    var_2[var_3] = spawn("script_model", (1534 + randomintrange(-100, 100), 5236 + randomintrange(-50, 50), 650 + randomintrange(-20, 20)));
    var_2[var_3].angles = (randomintrange(0, 360), randomintrange(0, 360), randomintrange(0, 360));
    var_2[var_3] setModel("weapon_honeybadger");
    var_2[var_3] movegravity((randomintrange(-300, -100), randomintrange(-200, 200), randomintrange(200, 400)), 5);
    var_2[var_3] rotateby((randomintrange(0, 3000), randomintrange(0, 3000), randomintrange(0, 3000)), var_1, var_1);
  }

  wait 2;
  var_4 = common_scripts\utility::getStructArray("weapon_spawn", "targetname");

  for(var_3 = 0; var_3 < 4; var_3++) {
    foreach(var_6 in var_4) {
      var_7 = "weapon_honeybadger+acog_sp";

      if(common_scripts\utility::cointoss())
        var_7 = "weapon_honeybadger+reflex_sp";

      spawn(var_7, var_6.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0));
      spawn("weapon_p226_tactical+silencerpistol_sp+tactical_sp", var_6.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0));
    }
  }

  wait 3;

  foreach(var_10 in var_2)
  var_10 delete();
}

heli_crash_blade_hit_2(var_0) {
  common_scripts\utility::exploder("blade_hit_2");
}

heli_blade_swap(var_0) {
  var_0 hidepart("tag_blade");
  common_scripts\utility::exploder("blade_swap");
}

heli_chopper_impact(var_0) {
  common_scripts\utility::flag_set("chopper_impact");
  common_scripts\utility::exploder("chopper_impact");
}

heli_crash_blade_hit_water(var_0) {
  common_scripts\utility::exploder("blade_hit_water");
}

heli_crash_tail_rotor_hit(var_0) {
  common_scripts\utility::exploder("tail_rotor_hit");
}

heli_crash_body_hit_water(var_0) {
  var_0 vehicle_turnengineoff();
  common_scripts\utility::exploder("body_hit_water");
  thread downed_chopper_fire();
}

downed_chopper_fire() {
  var_0 = spawn("trigger_radius", (999, 5147, 527), 0, 32, 64);
  var_0 thread maps\jungle_ghosts::world_fire_damage("s");
  var_0 = spawn("trigger_radius", (1076, 5387, 527), 0, 64, 128);
  var_0 thread maps\jungle_ghosts::world_fire_damage("m");
  var_0 = spawn("trigger_radius", (1057, 5512, 715), 0, 64, 128);
  var_0 thread maps\jungle_ghosts::world_fire_damage("m");
}

#using_animtree("animated_props");

script_model_anims() {
  level.scr_animtree["pristine_crate"] = #animtree;
  level.scr_model["pristine_crate"] = "jungle_crate_01";
  level.scr_anim["pristine_crate"]["new_crash"] = % jungle_ghost_helicrash_crate;
  level.scr_anim["pristine_crate"]["new_crash_idle"][0] = % jungle_ghost_helicrash_crate_idle;
  level.scr_animtree["damaged_crate"] = #animtree;
  level.scr_model["damaged_crate"] = "jungle_crate_01_dmg";
  level.scr_anim["damaged_crate"]["new_crash"] = % jungle_ghost_helicrash_crate;
  level.scr_anim["damaged_crate"]["new_crash_idle"][0] = % jungle_ghost_helicrash_crate_idle;
  maps\_anim::addnotetrack_customfunction("pristine_crate", "crate_impact", ::hide_me, "new_crash");
  maps\_anim::addnotetrack_customfunction("damaged_crate", "crate_impact", ::show_me, "new_crash");
  level.scr_animtree["player_harness"] = #animtree;
  level.scr_model["player_harness"] = "jungle_player_parachute_rope";
  level.scr_anim["player_harness"]["para_crash"] = % jungle_ghost_parachute_crash_falling_harness;
  level.scr_anim["player_harness"]["para_cut"] = % jungle_ghost_parachute_crash_cutharness_harness;
  level.scr_anim["player_harness"]["para_idle"][0] = % jungle_ghost_parachute_crash_cutharness_harness_idle;
}

hide_me(var_0) {
  var_0 hide();
  var_1 = common_scripts\utility::get_target_ent("dest_crate");
  var_1 notsolid();
  var_1 connectpaths();
  wait 0.5;
  var_2 = getent("dest_crate", "targetname");

  if(level.player istouching(var_2)) {
    level.player enabledeathshield(0);
    level.player enablehealthshield(0);
    level.player kill();
    return;
  }

  var_2 solid();
  var_2 disconnectpaths();
}

show_me(var_0) {
  common_scripts\utility::flag_set("box_swap");
  var_0 show();
  level.player playrumbleonentity("damage_heavy");
  var_1 = common_scripts\utility::getstruct("crate_do_damage", "targetname");
  wait 0.25;
  radiusdamage(var_1.origin, 80, 1000, 1000);
}

executor_kill_hostage_notetrack(var_0) {
  var_1 = var_0.scene_struct;
  var_1 notify("hostage_shot", var_0.script_noteworthy);
}

#using_animtree("player");

player_anims() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewhands_player_gs_jungle_b";
  level.scr_anim["player_rig"]["waterfall_jump"] = % jungle_ghost_wf_escape_jumpoff_player;
  level.scr_anim["player_rig"]["para_cut"] = % jungle_ghost_parachute_crash_cutharness;
  level.scr_anim["player_rig"]["para_crash"] = % jungle_ghost_parachute_crash_falling;
  level.scr_anim["player_rig"]["para_idle"][0] = % jungle_ghost_parachute_crash_cutharness_idle;
  level.scr_anim["player_rig"]["crawl_intro"] = % dubai_finale_crawl03_player_nosound;
  maps\_anim::addnotetrack_customfunction("player_rig", "impact", ::falling_impact, "para_crash");
  maps\_anim::addnotetrack_customfunction("player_rig", "impact", ::final_impact, "para_cut");
}

falling_impact(var_0) {
  level.impact_tree++;

  if(level.impact_tree == 2)
    common_scripts\utility::flag_set("kill_face_fx");

  if(common_scripts\utility::cointoss())
    level.player thread maps\_gameskill::blood_splat_on_screen("left");

  if(common_scripts\utility::cointoss())
    level.player thread maps\_gameskill::blood_splat_on_screen("right");

  if(common_scripts\utility::cointoss())
    level.player thread maps\_gameskill::blood_splat_on_screen("bottom");

  if(common_scripts\utility::cointoss())
    level.player thread maps\_gameskill::grenade_dirt_on_screen("left");

  if(common_scripts\utility::cointoss())
    level.player thread maps\_gameskill::grenade_dirt_on_screen("right");

  if(common_scripts\utility::cointoss())
    level.player thread maps\_gameskill::grenade_dirt_on_screen("bottom");

  earthquake(randomfloatrange(0.4, 0.45), randomfloatrange(1, 1.25), level.player.origin, 200);
  level.player playrumbleonentity("grenade_rumble");
}

final_impact(var_0) {
  common_scripts\utility::flag_set("player_landed");
}

#using_animtree("script_model");

script_model() {
  level.scr_animtree["seal_boat1"] = #animtree;
  level.scr_animtree["seal_boat2"] = #animtree;
  level.scr_anim["seal_boat1"]["outro"] = % jungle_ghost_boat_1;
  level.scr_anim["seal_boat2"]["outro"] = % jungle_ghost_boat_2;
}

#using_animtree("dog");

the_dog() {
  level.scr_animtree["riley"] = #animtree;
  level.scr_model["riley"] = "fullbody_dog_a";
  level.scr_anim["riley"]["idle"][0] = % iw6_dog_casualidle;
  level.scr_anim["riley"]["sniff"][0] = % iw6_dog_sniff_idle;
  level.scr_anim["riley"]["sniff_once"] = % iw6_dog_sniff_idle;
}