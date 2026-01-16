/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\angola_jungle_ending.gsc
*****************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\angola_2_util;
#include maps\_music;
#include maps\_anim;
#include maps\createart\angola_art;
#include maps\_audio;
#include maps\_turret;

skipto_jungle_ending() {
  skipto_teleport_players("player_skipto_jungle_ending");
  load_gump("angola_2_gump_village");
  level.ai_woods = init_hero("woods");
  level.ai_hudson = init_hero("hudson");
  level.ai_hudson detach("c_usa_angola_hudson_glasses");
  level.ai_hudson detach("c_usa_angola_hudson_hat");
  level thread fxanim_beach_grass_logic();
  level thread exploder_after_wait(250);
  flag_init("enemy_vo_final_retreat");
  flag_init("jungle_ending_do_not_save");
}

init_flags() {
  flag_init("je_end_scene_started");
  flag_init("angola2_misssion_complete");
  flag_init("hudson_at_evacuation_point");
}

main() {
  level.player thread maps\createart\angola_art::jungle_escape();
  init_flags();
  level notify("end_of_jungle_escape");
  level thread angola_jungle_wave_spawning();
  level thread angola_jungle_ending_objectives();
  setdvar("footstep_sounds_cutoff", 3000);
}

angola_jungle_ending_objectives() {
  wait 0.25;
  flag_set("enemy_vo_final_retreat");
  defend_obj_struct = getstruct("defend_beach_obj_struct", "targetname");
  set_objective(level.obj_protect_hudson_and_woods_on_way_to_beach, undefined, "reactivate");
  set_objective(level.obj_protect_hudson_and_woods_on_way_to_beach, level.ai_hudson, "follow");
  wait 0.5;
  objective_setflag(level.obj_protect_hudson_and_woods_on_way_to_beach, "fadeoutonscreen", 0);
  level notify("mason_protect_nag_end");
  level.ai_hudson.badplaceawareness = 1;
  badplace_delete("badplace_woods");
  level thread run_scene("evac_to_beach_hudson");
  flag_wait("evac_to_beach_hudson_started");
  run_scene("evac_to_beach_woods");
  org = getstruct("org_final_objective_location", "targetname");
  set_objective(level.obj_protect_hudson_and_woods_on_way_to_beach, org.origin, "breadcrumb");
  level thread run_scene("hudson_and_woods_jungle_escape_beach_collapse");
  level thread final_scene_vo();
  level thread final_scene_nag();
  level.hudson_at_beach_evauation_point = 1;
  flag_set("hudson_at_evacuation_point");
  flag_wait("je_end_scene_started");
  level.player notify("mission_finished");
  level thread kill_spawnernum(6000);
  screen_message_delete();
  objective_state(level.obj_protect_hudson_and_woods_on_way_to_beach, "done");
  level notify("mason_protect_nag_end");
  wait 0.1;
  level waittill("end_dialog_finished");
  level clientnotify("fade_out");
  nextmission();
}

final_scene_nag() {
  level.player endon("death");
  level endon("je_end_scene_started");
  lines = array("huds_we_gotta_keep_moving_0", "huds_we_have_to_move_now_0", "huds_we_can_t_stay_here_0", "huds_come_on_mason_mov_0", "huds_we_can_t_stay_here_1", "huds_they_re_closing_fast_0", "huds_keep_running_mason_0");
  last_line = "";

  while(!flag("je_end_scene_started")) {
    wait 3;
    line = lines[randomint(lines.size)];

    if(line == last_line) {
      continue;
    }
    level.ai_hudson say_dialog(line);
    last_line = line;
    wait(randomfloatrange(3.0, 7.0));
  }
}

kill_player_if_linger(delay) {
  level.player endon("death");
  level endon("je_end_scene_started");

  if(isDefined(delay))
    wait(delay);

  flag_set("jungle_ending_do_not_save");
  guys = getaiarray("axis");
  guys[0] magicgrenade(guys[0] gettagorigin("tag_inhand"), level.player.origin, 2);

  foreach(guy in guys) {
    guy thread shoot_and_kill(level.player, 0);
    guy.accuracy = 1;
  }

  wait 2.1;
}

final_scene_vo() {
  flag_wait("je_end_scene_started");
  level.player say_dialog("maso_come_on_frank_we_0");
}

nag_mason_to_get_to_the_beach() {
  level endon("je_end_scene_started");
  add_vo_to_nag_group("get_to_beach_nag", level.ai_hudson, "huds_follow_me_0");
  add_vo_to_nag_group("get_to_beach_nag", level.ai_hudson, "huds_mason_where_you_go_0");
  add_vo_to_nag_group("get_to_beach_nag", level.ai_hudson, "huds_come_on_we_re_movin_0");
  level thread start_vo_nag_group_flag("get_to_beach_nag", "je_end_scene_started", 16);
}

angola_jungle_wave_spawning() {
  str_category = "jungle_beach_attack_guys";
  level thread je_trigger_hind_beach_evacuation(str_category);
}

je_trigger_hind_beach_evacuation(str_category) {
  flag_wait("hudson_at_evacuation_point");
  badplace_cylinder("badplace_final_scene", 0, level.ai_hudson.origin, 1024, 256, "axis");
  level.ai_hudson.ignoreme = 1;
  level.ai_woods.ignoreme = 1;
  trigger_wait("trig_end_scene");
  exploder(551);
  setmusicstate("ANGOLA_END");
  level clientnotify("heli_context_switch");
  flag_set("je_end_scene_started");
  badplace_delete("badplace_final_scene");
  level.player magic_bullet_shield();
  level.player.ignoreme = 1;
  enemy_spawn_time = 12.5;
  level thread enemy_run_from_forest_to_beach(undefined, str_category, 7);
  level.player startcameratween(0.5);
  level thread run_scene("hind_attack_end_scene");
  level thread handle_hind_interior();
  level thread make_ai_ignore_all_to_stop_firing();
  flag_wait("hind_attack_end_scene_started");
  level.woods_weapon = spawn_model("t6_wpn_pistol_browninghp_prop_view", level.ai_woods gettagorigin("TAG_WEAPON_LEFT"), level.ai_woods gettagangles("TAG_WEAPON_LEFT"));
  level.woods_weapon linkto(level.ai_woods, "TAG_WEAPON_LEFT");
  ai_enemy = getent("hind_dummy_pilot_ai", "targetname");
  ai_enemy.health = 666666;

  if(!level.ai_hudson is_model_attached("c_usa_angola_hudson_glasses"))
    level.ai_hudson attach("c_usa_angola_hudson_glasses");

  level thread maps\_audio::switch_music_wait("ANGOLA_HUDSON_SHOT", 37);
  level thread maps\_audio::switch_music_wait("ANGOLA_END_RESOLVE", 40);
  scene_wait("hind_attack_end_scene");
  level.woods_weapon delete();
  flag_set("angola2_misssion_complete");
}

handle_hind_interior() {
  wait 0.05;
  hind = getent("hind_end_level", "targetname");
  interior = spawn_anim_model("hind_interior", hind gettagorigin("tag_body"), hind gettagangles("tag_body"));
  interior linkto(hind, "tag_body");
  hind anim_loop_aligned(interior, "hind_interior_loop", "tag_body");
}

make_ai_ignore_all_to_stop_firing() {
  axis = getaiarray("axis");

  foreach(ai in axis) {
    if(isDefined(ai) && isalive(ai))
      ai set_ignoreall(1);
  }

  foreach(ai in axis) {
    if(!level.player is_player_looking_at(ai.origin, 0.6))
      ai delete();
  }
}

is_model_attached(str_model) {
  n_attached = self getattachsize();

  for(i = 0; i < n_attached; i++) {
    str_attach_model = self getattachmodelname(i);

    if(str_attach_model == str_model)
      return true;
  }

  return false;
}

hind_fires_into_forest(vh_hind) {
  level notify("spawn_end_scene_enemies");
  vh_hind maps\_turret::fire_turret_for_time(2, 0);
  vh_hind maps\_turret::fire_turret_for_time(2, 1);
  vh_hind maps\_turret::fire_turret_for_time(2, 2);
  wait 4;
  vh_hind maps\_turret::disable_turret(0);
  vh_hind maps\_turret::disable_turret(1);
  vh_hind maps\_turret::disable_turret(2);
}

jungle_explosions(vh_hind) {
  exploder(10000);
  level thread tree_explosions();
  wait 1.6;
  radius_big = 300;
  radius_small = 200;
  mindamage = 100;
  maxdamage = 300;
  s_exp1 = getstruct("je_end_explosion1", "targetname");
  pos = s_exp1.origin;
  playfx(level._effect["def_explosion"], pos);
  playsoundatposition("exp_heli_rocket", s_exp1.origin);
  radiusdamage(pos, radius_big, maxdamage, mindamage);
  level.player playrumbleonentity("explosion_generic");
  earthquake(0.5, 0.5, level.player.origin, 128);
  wait 1.3;
  s_exp2 = getstruct("je_end_explosion2", "targetname");
  pos = s_exp2.origin;
  playfx(level._effect["def_explosion"], pos);
  playsoundatposition("exp_heli_rocket", s_exp2.origin);
  radiusdamage(pos, radius_big, maxdamage, mindamage);
  level.player playrumbleonentity("explosion_generic");
  earthquake(0.5, 0.5, level.player.origin, 128);
  wait 0.5;
  s_exp3 = getstruct("je_end_explosion3", "targetname");
  pos = s_exp3.origin;
  playfx(level._effect["def_explosion"], pos);
  playsoundatposition("exp_heli_rocket", s_exp3.origin);
  radiusdamage(pos, radius_small, maxdamage, mindamage);
  level.player playrumbleonentity("explosion_generic");
  earthquake(0.5, 0.5, level.player.origin, 128);
}

tree_explosions() {
  wait 1;
  level notify("fxanim_palm_grp01_start");
  wait 1.5;
  level notify("fxanim_palm_grp02_start");
}

enemy_run_from_forest_to_beach(delay, str_category, alive_time) {
  level waittill("spawn_end_scene_enemies");
  cleanup_ents("jungle_battle_3");

  if(isDefined(delay))
    wait(delay);

  a_spawners = getentarray("ae_end_attack_spawner", "targetname");

  if(isDefined(a_spawners))
    a_ai = simple_spawn(a_spawners, ::spawn_fn_ai_run_to_target, 0, str_category, 0, 0, 0);

  for(i = 0; i < a_ai.size; i++) {
    e_ai = a_ai[i];
    e_ai.overrideactordamage = ::forest_enemy_damage_override_func;
  }

  wait(alive_time);
  cleanup_ents(str_category);
}

forest_enemy_damage_override_func(einflictor, e_attacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
  if(!isDefined(smeansofdeath) || smeansofdeath == "MOD_UNKNOWN")
    return 0;
  else if(!isDefined(self.alreadylaunched)) {
    self.alreadylaunched = 1;
    self startragdoll(1);
    v_launch = vectorscale((0, 0, 1), 100.0);

    if(randomint(100) < 40)
      v_launch = v_launch + anglestoforward(einflictor.angles) * 300;

    self launchragdoll(v_launch, "J_SpineUpper");
  }

  return idamage;
}

play_outro_vo() {
  hind = getent("hind_end_level", "targetname");
  hind vehicle_toggle_sounds(0);
  guys = getaiarray("axis");

  foreach(guy in guys)
  guy delete();

  wait 1;
  level.player say_dialog("wood_you_can_t_kill_me_1");
  wait 1;
  level.player say_dialog("wood_thanks_to_your_da_0");
  wait 1;
  level thread screen_fade_out(1);
  level.player say_dialog("wood_for_honor_and_frien_0");
  wait 1;
  level.player say_dialog("wood_yeah_he_s_just_like_0");
  level notify("end_dialog_finished");
}