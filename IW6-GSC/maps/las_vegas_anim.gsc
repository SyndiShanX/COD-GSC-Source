/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\las_vegas_anim.gsc
*****************************************************/

main() {
  generic_anims();
  thread intro();
  bar();
  kitchen();
  main_hotel();
  hotel_room();
  entrance();
  creepwalk();
  player_anims();
  animated_props_anims();
  model_anims();
  vehicle_anims();
  run_cycles();
  init_wounded_archetype();
  thread after_transient();
  thread outside_animated_props();
}

intro() {
  if(!common_scripts\utility::flag("las_vegas_transient_hotel_tr_loaded"))
    common_scripts\utility::flag_wait("las_vegas_transient_hotel_tr_loaded");

  intro_ambush();
  drag();
  elias_death();
  rescue();
  player_intro();
}

after_transient() {
  common_scripts\utility::flag_wait("las_vegas_transient_crasharea_tr_loaded");
  player_dog_pickup();
  courtyard_dog();
  courtyard();
}

creepwalk() {
  var_0 = ["keegan", "hesh", "merrick", "elias"];

  foreach(var_2 in var_0)
  creepwalk_anims(var_2);
}

#using_animtree("generic_human");

generic_anims() {
  level.scr_anim["generic"]["active_patrolwalk_gundown"] = % active_patrolwalk_gundown;
  level.scr_anim["generic"]["doorkick_stand"] = % doorkick_2_stand;
  level.scr_anim["generic"]["patrol_bored_idle"][0] = % patrol_bored_idle;
  level.scr_anim["generic"]["patrol_bored_react_look1"] = % patrol_bored_react_look_v1;
  level.scr_anim["generic"]["patrol_bored_react_wave"] = % patrol_bored_react_wave;
  level.scr_anim["generic"]["stand_2_run_180L"] = % stand_2_run_180l;
  level.scr_anim["generic"]["search_walk_1"] = % payback_search_walk_1_noloop;
  level.scr_anim["generic"]["exposed_death"] = % exposed_death;
  level.scr_anim["generic"]["active_patrolwalk_v1"] = % active_patrolwalk_v1;
  level.scr_anim["generic"]["active_patrolwalk_v3"] = % active_patrolwalk_v3;
  level.scr_anim["generic"]["active_patrolwalk_v5"] = % active_patrolwalk_v5;
  level.scr_anim["generic"]["combatwalk_F_spin"] = % combatwalk_f_spin;
  level.scr_anim["generic"]["combat_jog"] = % combat_jog;
  level.scr_anim["keegan"]["combat_jog"] = % combat_jog;
  maps\_anim::addnotetrack_flag("generic", "door_open", "TRACKFLAG_kitchen_exit_double_doors_open", "vegas_guy_open_double_doors");
  level.scr_anim["generic"]["reaction_180"] = % run_reaction_180;
  level.scr_anim["generic"]["run_180"] = % run_turn_180;
  level.scr_anim["generic"]["run_duck"] = % run_react_duck;
  level.scr_anim["generic"]["run_flinch"] = % run_react_flinch;
  level.scr_anim["generic"]["run_stumble"] = % run_react_stumble;
  level.scr_anim["generic"]["patrol_jog"] = % patrol_jog;
  level.scr_anim["generic"]["patrol_jog_360_once"] = % patrol_jog_360_once;
  level.scr_anim["generic"]["patrol_jog_orders_once"] = % patrol_jog_orders_once;
  level.scr_anim["generic"]["patrol_jog_look_up_once"] = % patrol_jog_look_up_once;
  level.scr_anim["generic"]["patrol_walk_array"][0] = % active_patrolwalk_v1;
  level.scr_anim["generic"]["patrol_walk_array"][1] = % active_patrolwalk_v2;
  level.scr_anim["generic"]["patrol_walk_array"][2] = % active_patrolwalk_v3;
  level.scr_anim["generic"]["patrol_walk_array"][3] = % active_patrolwalk_v4;
  level.scr_anim["generic"]["patrol_walk_array"][4] = % active_patrolwalk_v5;
  level.scr_anim["generic"]["payback_sstorm_guard_shoot_reaction_1"] = % payback_sstorm_guard_shoot_reaction_1;
  level.scr_anim["generic"]["payback_sstorm_guard_shoot_reaction_2"] = % payback_sstorm_guard_shoot_reaction_2;
  level.scr_anim["generic"]["payback_sstorm_guard_shoot_reaction_3"] = % payback_sstorm_guard_shoot_reaction_3;
  level.scr_anim["generic"]["wave_halt"] = % stand_exposed_wave_halt;
  level.scr_anim["generic"]["casino_slow_patrol"] = % cqb_walk_iw6;
}

run_cycles() {
  level.scr_anim["hesh"]["readystand_idle"][0] = % readystand_idle;
  level.scr_anim["keegan"]["sprint_1hand_gunup"] = % vegas_reverse_1hand_gunup_sprint;
  level.scr_anim["keegan"]["sprint_1hand_gundown"] = % vegas_reverse_1hand_gundown_sprint;
  level.scr_anim["merrick"]["sprint_1hand_gunup"] = % vegas_reverse_1hand_gunup_sprint;
  level.scr_anim["merrick"]["sprint_1hand_gundown"] = % vegas_reverse_1hand_gundown_sprint;
  level.scr_anim["hesh"]["sprint_1hand_gunup"] = % vegas_reverse_1hand_gunup_sprint;
  level.scr_anim["hesh"]["sprint_1hand_gundown"] = % vegas_reverse_1hand_gundown_sprint;
}

intro_ambush() {
  level.scr_anim["generic"]["london_dock_soldier_walk"] = % london_dock_soldier_walk;
  level.scr_anim["generic"]["NML_vargas_idle"][0] = % nml_vargas_idle;
  level.scr_anim["merrick"]["ambush"] = % vegas_ambush_merrick;
  level.scr_anim["elias"]["ambush"] = % vegas_ambush_elias;
  level.scr_anim["hesh"]["ambush"] = % vegas_ambush_hesh;
}

drag() {
  level.scr_model["player_body"] = "body_elias_hostage";
  level.scr_animtree["player_body"] = #animtree;
  level.scr_anim["player_body"]["drag_loop"][0] = % vegas_drag_hesh;
  level.scr_anim["player_body"]["drag_single"] = % vegas_drag_hesh;
  level.scr_animtree["hesh"] = #animtree;
  level.scr_anim["hesh"]["drag"][0] = % vegas_drag_hesh;
  level.scr_animtree["enemy"] = #animtree;
  level.scr_anim["enemy"]["drag"][0] = % vegas_drag_guard;
  level.scr_animtree["merrick"] = #animtree;
  level.scr_anim["merrick"]["beatup"] = % vegas_beatup_merrick;
  level.scr_anim["enemy"]["beatup"] = % vegas_beatup_guard;
}

elias_death() {
  level.scr_anim["player_body"]["elias_death_start"] = % vegas_intro_start_player_body;
  level.scr_anim["hesh"]["elias_death_start"] = % vegas_intro_start_hesh;
  level.scr_anim["hesh"]["elias_death_start_b"] = % vegas_intro_start_hesh_b;
  level.scr_anim["elias"]["elias_death_start"] = % vegas_intro_start_elias;
  level.scr_anim["elias"]["elias_death_start_b"] = % vegas_intro_start_elias_b;
  level.scr_anim["rorke"]["elias_death_start"] = % vegas_intro_start_rorke;
  level.scr_anim["rorke"]["elias_death_start_b"] = % vegas_intro_start_rorke_b;
  level.scr_anim["rorke"]["elias_death_fail"] = % vegas_intro_fail_rorke;
  maps\_anim::addnotetrack_customfunction("rorke", "scripted_fire", ::rorke_scripted_fire, "elias_death_start");
  maps\_anim::addnotetrack_customfunction("rorke", "player_fail", ::elias_death_fail, "elias_death_start_b");
  maps\_anim::addnotetrack_flag("rorke", "rorke_fail", "elias_death_rorke_fail", "elias_death_start_b");
  maps\_anim::addnotetrack_customfunction("rorke", "scripted_fire", ::rorke_scripted_fire, "elias_death_fail");
  level.scr_anim["hesh"]["elias_death_struggle"] = % vegas_intro_struggle_hesh;
  level.scr_anim["elias"]["elias_death_struggle"] = % vegas_intro_struggle_elias;
  level.scr_anim["rorke"]["elias_death_struggle"] = % vegas_intro_struggle_rorke;
  maps\_anim::addnotetrack_customfunction("rorke", "scripted_fire", ::rorke_scripted_fire, "elias_death_struggle");
  maps\_anim::addnotetrack_customfunction("rorke", "vo_vegas_rke_theycouldgooff", ::rorke_shoot_dad, "elias_death_struggle");
  level.scr_anim["hesh"]["elias_death_end"] = % vegas_intro_end_hesh;
  level.scr_anim["elias"]["elias_death_end"] = % vegas_intro_end_elias;
  level.scr_anim["rorke"]["elias_death_end"] = % vegas_intro_end_rorke;
  maps\_anim::addnotetrack_customfunction("rorke", "scripted_fire", ::rorke_scripted_fire, "elias_death_end");
}

elias_death_fail(var_0) {
  thread maps\las_vegas_code::cleanup_hand_hint();
  level notify("stop_player_smash_use");
  var_1 = maps\las_vegas_code::grab_gun_smash_count();

  if(maps\las_vegas_code::player_smash_check(var_1)) {
    common_scripts\utility::flag_set("player_grabbed_gun");
    level.player common_scripts\utility::delaycall(0.5, ::playrumbleonentity, "vegas_brash");
    level.player thread maps\_utility::play_sound_on_entity("scn_vegas_torture_plr_rope_free_hand");
    level.player maps\_utility::delaythread(2.0, maps\_utility::play_sound_on_entity, "scn_vegas_torture_plr_grab_gun");
    maps\_utility::delaythread(2.0, maps\_utility::music_play, "mus_vegas_gun_wrestle");
    level.player common_scripts\utility::delaycall(2.5, ::playrumbleonentity, "damage_heavy");
    level.player common_scripts\utility::delaycall(3.0, ::playrumbleonentity, "grenade_rumble");
    level.player common_scripts\utility::delaycall(3.5, ::playrumbleonentity, "damage_heavy");
    level.player common_scripts\utility::delaycall(4.0, ::playrumbleonentity, "grenade_rumble");
    level.player common_scripts\utility::delaycall(4.5, ::playrumbleonentity, "damage_heavy");
    common_scripts\utility::noself_delaycall(5.0, ::playrumblelooponposition, "vegas_drag", level.player.origin + (0, 0, 150));
    level.player.rig show();
    level.player.body hide();
    return;
  }

  maps\_anim::anim_set_rate_single(level.player.rig, "elias_death_start", 0.01);
  common_scripts\utility::flag_wait("elias_death_rorke_fail");
  common_scripts\utility::flag_set("elias_death_player_failed");
  var_2 = common_scripts\utility::getstruct("elias_death_struct", "targetname");
  var_3 = var_2 maps\las_vegas_code::makestruct();
  var_4 = [level.elias, level.hesh];
  maps\_anim::anim_set_rate(var_4, "elias_death_start_b", 0.01);
  var_0 stopanimscripted();
  var_3 maps\_anim::anim_single_solo(var_0, "elias_death_fail");
}

rorke_scripted_fire(var_0) {
  if(!isDefined(var_0.scripted_fire_count))
    var_0.scripted_fire_count = 0;

  if(common_scripts\utility::flag("elias_death_end") && var_0.scripted_fire_count < 3)
    var_0.scripted_fire_count = 3;

  var_0.scripted_fire_count++;
  var_1 = var_0 gettagorigin("tag_flash");

  if(var_0.scripted_fire_count == 7)
    thread common_scripts\utility::play_sound_in_space("scn_weap_mp443_finale_rorke", var_1);
  else if(var_0.scripted_fire_count == 1)
    thread common_scripts\utility::play_sound_in_space("scn_weap_mp443_shoot_logan", var_1);
  else
    thread common_scripts\utility::play_sound_in_space("scn_weap_mp443_fire_rorke", var_1);

  var_2 = [];
  var_2[var_2.size] = [common_scripts\utility::getfx("close_muzzleflash"), "tag_flash"];
  var_2[var_2.size] = [common_scripts\utility::getfx("shell_eject"), "tag_brass"];

  foreach(var_4 in var_2) {
    var_1 = var_0 gettagorigin(var_4[1]);
    var_5 = var_0 gettagangles(var_4[1]);
    var_6 = anglesToForward(var_5);
    var_7 = anglestoup(var_5);
    playFX(var_4[0], var_1, var_6, var_7);
  }

  if(var_0.scripted_fire_count == 1)
    thread rorke_shoots_player();
  else if(var_0.scripted_fire_count == 2) {
    level.player.smash_use_count = 25;
    level.elias thread maps\_utility::play_sound_on_tag("vegas_els_death_efforts_2_1", "j_head");
  } else if(var_0.scripted_fire_count == 3)
    level.elias thread maps\_utility::play_sound_on_tag("vegas_els_death_efforts_2_2", "j_head");
  else if(var_0.scripted_fire_count == 4) {
    maps\_utility::music_play("mus_vegas_elias_shot");
    level.elias thread maps\_utility::play_sound_on_tag("vegas_els_death_efforts_3", "j_head");
  }

  if(var_0.scripted_fire_count > 1 && var_0.scripted_fire_count < 7) {
    var_1 = level.elias gettagorigin("j_spine4");
    var_9 = level.rorke gettagorigin("tag_flash");
    var_10 = distance(var_1, var_9);

    if(var_0.scripted_fire_count < 4)
      var_5 = vectortoangles(var_1 - var_9);
    else
      var_5 = level.rorke gettagangles("tag_flash");

    var_6 = anglesToForward(var_5);
    var_1 = var_9 + var_6 * var_10;
    var_6 = vectornormalize(var_9 - var_1);
    playFX(common_scripts\utility::getfx("blood_impact"), var_1, var_6);
  }

  if(common_scripts\utility::flag("elias_death_player_failed")) {
    maps\_hud_util::fade_out(0.1, "white");
    wait 0.1;
    level.player kill();
  }
}

end_shot_ringing() {
  common_scripts\utility::flag_wait("elias_death_done");
  wait 4;
}

rorke_shoot_dad(var_0) {
  level.player.smash_use_pause = 1;
  wait 3;
  level.player.smash_use_pause = undefined;
}

rorke_shoots_player() {
  maps\_utility::music_play("mus_vegas_player_shot");
  level.player thread maps\_utility::play_sound_on_entity("scn_vegas_torture_plr_shot");
  level.player thread maps\_gameskill::blood_splat_on_screen("bottom");
  level.player.hudstuff = [];
  var_0 = maps\_hud_util::create_client_overlay("dogcam_edge", 0, level.player);
  var_0.foreground = 0;
  var_0.color = (1, 0, 0);
  level.player.hudstuff[level.player.hudstuff.size] = var_0;
  var_1 = newclienthudelem(level.player);
  var_1.x = 0;
  var_1.y = 0;
  var_1 setshader("vfx_blood_screen_overlay", 640, 480);
  var_1.splatter = 1;
  var_1.alignx = "left";
  var_1.aligny = "top";
  var_1.sort = 1;
  var_1.foreground = 0;
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1.alpha = 0;
  var_1.enablehudlighting = 1;
  level.player.hudstuff[level.player.hudstuff.size] = var_1;
  maps\_utility::delaythread(0.1, ::player_hurt_overlay, 1);

  foreach(var_3 in level.player.hudstuff) {
    var_3 fadeovertime(0.1);
    var_3.alpha = 1;
  }

  level.player enableslowaim(0.6, 0.6);
  level.player lerpfov(25, 0.1);
  level.player common_scripts\utility::delaycall(10, ::lerpfov, 50, 15);
  maps\_utility::delaythread(10, ::blood_overlay_thread, var_1);
  level.player shellshock("vegas_chair_shot", 999);
  level.player playrumbleonentity("grenade_rumble");
  var_5 = level.player.origin + (0, 0, 50);
  var_6 = level.rorke gettagorigin("tag_flash");
  var_7 = vectornormalize(var_6 - var_5);
  playFX(common_scripts\utility::getfx("blood_impact"), var_5, var_7);
  common_scripts\utility::flag_wait("elias_death_done");

  foreach(var_3 in level.player.hudstuff)
  var_3 destroy();
}

blood_overlay_thread(var_0) {
  var_0 fadeovertime(10);
  var_0.alpha = 0.2;
}

player_hurt_overlay(var_0) {
  level endon("elias_death_done");
  level endon("stop_hurt_overlay");
  var_1 = maps\_hud_util::get_overlay("black");
  var_2 = 0;

  if(isDefined(var_0)) {
    var_3 = 0.2;
    var_1 fadeovertime(var_3);
    var_1.alpha = 1;
    wait(var_3);
  }

  for(var_4 = 0; var_4 < 3; var_4++) {
    thread maps\_art::dof_enable_script(0, 0, 10, 5, 10, 1, 3);
    var_1 fadeovertime(3);
    var_1.alpha = 0.5;
    wait 1.5;
    wait 2;
    var_2 = var_2 + 1;
    thread maps\_art::dof_enable_script(0, 0, 10, 95, 250, 3, 1);
    var_1 fadeovertime(2.5);
    var_1.alpha = 0;
    wait 2;
  }

  maps\_art::dof_disable_script(5);
}

rescue() {
  if(!common_scripts\utility::flag("las_vegas_transient_hotel_tr_loaded"))
    common_scripts\utility::flag_wait("las_vegas_transient_hotel_tr_loaded");

  level.scr_anim["merrick"]["rescue"] = % vegas_rescue_merrick_start;
  level.scr_anim["merrick"]["rescue_end"] = % vegas_rescue_merrick_end;
  level.scr_goaltime["merrick"]["rescue_end"] = 1;
  level.scr_anim["hesh"]["rescue"] = % vegas_rescue_hesh;
  maps\_anim::addnotetrack_customfunction("hesh", "detach gun", ::detach_gun_custom, "rescue");
  maps\_anim::addnotetrack_customfunction("hesh", "attach gun right", ::attach_gun_custom, "rescue");
  level.scr_anim["gunner1"]["rescue"] = % vegas_rescue_gunner;
  level.scr_anim["gunner2"]["rescue"] = % vegas_rescue_gunner2;
  level.scr_anim["enemy1"]["rescue"] = % vegas_rescue_enemy;
  level.scr_anim["enemy2"]["rescue"] = % vegas_rescue_enemy1;
  maps\_anim::addnotetrack_customfunction("gunner1", "kill", ::anim_kill, "rescue");
  maps\_anim::addnotetrack_customfunction("gunner2", "kill", ::anim_kill, "rescue");
  maps\_anim::addnotetrack_customfunction("enemy1", "kill", ::anim_kill, "rescue");
  maps\_anim::addnotetrack_customfunction("enemy2", "kill", ::anim_kill, "rescue");
  maps\_anim::addnotetrack_customfunction("gunner1", "drop_gun", ::rescue_drop_gun, "rescue");
  maps\_anim::addnotetrack_customfunction("gunner2", "drop_gun", ::rescue_drop_gun, "rescue");
  maps\_anim::addnotetrack_customfunction("gunner2", "pickup_gun", ::rescue_pickup_gun, "rescue");
  maps\_anim::addnotetrack_customfunction("hesh", "kick", ::rescue_kick_gun, "rescue");
  maps\_anim::addnotetrack_customfunction("hesh", "grab_rifle", ::rescue_grab_rifle, "rescue");
  maps\_anim::addnotetrack_flag("hesh", "catchup_time", "rescue_merrick_end", "rescue");
}

addnotetrack_attach_gun(var_0, var_1, var_2) {
  var_3 = maps\_anim::add_notetrack_and_get_index(var_0, var_1, var_2);
  var_4 = [];
  var_4["attach gun right"] = 1;
  level.scr_notetrack[var_0][var_2][var_1][var_3] = var_4;
}

leave_gun(var_0) {
  var_1["tag"] = "tag_weapon_right";
  var_0 maps\_anim::gun_leave_behind(var_1);
}

get_rescue_gun(var_0) {
  if(isDefined(level.rescue_gun))
    var_1 = level.rescue_gun.model;
  else
    var_1 = getweaponmodel(var_0.sidearm);

  return var_1;
}

rescue_drop_gun(var_0) {
  var_1 = var_0 gettagorigin("tag_weapon_right");
  var_2 = var_0 gettagangles("tag_weapon_right");
  var_3 = get_rescue_gun(var_0);
  var_4 = spawn("script_model", var_1);
  var_4.angles = var_2;
  var_4 setModel(var_3);

  if(!isDefined(level.rescue_gun)) {
    level.rescue_gun = spawnStruct();
    level.rescue_gun.model = var_3;
    level.rescue_gun.weapon = var_0.sidearm;
  }

  level.rescue_gun.ent = var_4;

  if(var_0.weapon == var_0.sidearm)
    var_0 animscripts\shared::placeweaponon(level.rescue_gun.weapon, "none");
  else
    var_0 detach(var_3, "tag_weapon_right");
}

rescue_pickup_gun(var_0) {
  level.rescue_gun.ent delete();
  var_1 = get_rescue_gun();
  var_0 attach(var_1, "tag_weapon_right");
}

rescue_grab_rifle(var_0) {
  var_1 = getent("rescue_enemy2", "targetname");
  var_2 = var_1.weapon;
  var_1 maps\_utility::gun_remove();
  var_0 maps\_utility::forceuseweapon(var_2, "primary");
}

rescue_kick_gun(var_0) {
  common_scripts\utility::flag_set("rescue_unlink_player");
  maps\_utility::array_spawn_targetname("rescue_extra_enemies");
  level.player enableweapons();
  maps\las_vegas_code::set_player_speed("bar", 2);
  var_1 = spawn("weapon_p226", level.rescue_gun.ent.origin);
  var_1 makeunusable();
  var_2 = getsubstr(var_1.classname, 7);
  var_3 = weaponclipsize(var_2);
  var_4 = weaponmaxammo(var_2);
  var_1 itemweaponsetammo(var_3, var_4, var_3, 0);
  var_1.angles = level.rescue_gun.ent.angles;
  var_5 = spawn("script_origin", var_1.origin);
  var_1 linkto(var_5);
  var_6 = vectornormalize(var_1.origin - level.player.origin);
  var_7 = level.player.origin + var_6 * 35;
  var_8 = 1;
  var_5 moveto(var_7, var_8, 0, var_8);
  var_5 rotateyaw(randomfloatrange(60, 130), var_8, 0, var_8);
  var_1 common_scripts\utility::delaycall(var_8 * 0.5, ::makeusable);
  level.rescue_gun.ent delete();
  level.rescue_gun = undefined;
  var_5 thread rescue_gun_player_pickup(var_1);
}

rescue_gun_player_pickup(var_0) {
  var_0 waittill("trigger");
  self delete();
}

bar() {
  level.scr_anim["merrick"]["limp_stepup"] = % vegas_baker_limp_step_up;
  level.scr_anim["merrick"]["limp_stepdown"] = % vegas_baker_limp_step_down;
  level.scr_anim["keegan"]["doorkick_stand"] = % doorkick_2_stand;
  level.scr_anim["hesh"]["humanshield_doorstack"] = % corner_standr_trans_in_1;
  level.scr_anim["hesh"]["humanshield_doorstack_idle"][0] = % corner_standr_alert_idle;
  level.scr_anim["hesh"]["humanshield_checkdoor"] = % vegas_keegan_door_check;
  maps\_anim::addnotetrack_customfunction("hesh", "door_attach", ::bar_link_door, "humanshield_checkdoor");
  maps\_anim::addnotetrack_customfunction("hesh", "door_detach", ::bar_unlink_door, "humanshield_checkdoor");
  level.scr_anim["merrick"]["humanshield_doorstack"] = % vegas_diaz_door_stack;
  level.scr_anim["merrick"]["humanshield_checkdoor"] = % vegas_diaz_door_check;
  level.scr_anim["hesh"]["vegas_humanshield_breach"] = % vegas_keegan_breach;
  level.scr_anim["hesh"]["vegas_humanshield_breach_loop"] = % vegas_keegan_breach_loop;
  level.scr_anim["hesh"]["vegas_humanshield_breach_ending"] = % vegas_keegan_breach_exit;
  maps\_anim::addnotetrack_customfunction("hesh", "gun_2_right", ::gun_2_right, "vegas_humanshield_breach_ending");
  level.scr_anim["sacrifice"]["vegas_humanshield_breach"] = % vegas_guy_shot_breach;
  level.scr_anim["hostage"]["vegas_humanshield_breach"] = % vegas_guy_hostage_breach;
  level.scr_anim["hostage"]["vegas_humanshield_breach_loop"] = % vegas_guy_hostage_breach_loop;
  level.scr_anim["hostage"]["vegas_humanshield_breach_ending"] = % vegas_guy_hostage_breach_exit;
  maps\_anim::addnotetrack_flag("sacrifice", "start_ragdoll", "TRACKFLAG_start_sacrifice_ragdoll", "vegas_humanshield_breach");
  maps\_anim::addnotetrack_customfunction("sacrifice", "guy_shot", ::bar_sacrifice_kill, "vegas_humanshield_breach");
  maps\_anim::addnotetrack_customfunction("hostage", "guy_death", ::ai_kill, "vegas_humanshield_breach_ending");
  level.scr_anim["box_guy"]["vegas_guy_1_box_carry_walk"] = % vegas_guy_1_box_carry_walk;
  level.scr_anim["box_guy"]["vegas_guy_2_box_carry_walk"] = % vegas_guy_2_box_carry_walk;
  level.scr_anim["box_guy"]["vegas_guy_1_box_carry_dead"] = % vegas_guy_1_box_carry_death;
  level.scr_anim["box_guy"]["vegas_guy_2_box_carry_dead"] = % vegas_guy_2_box_carry_death;
  level.scr_anim["box_guy"]["vegas_guy_1_box_carry_turn_shoot"] = % vegas_guy_1_box_carry_turn_shoot;
  level.scr_anim["box_guy"]["vegas_guy_2_box_carry_turn_shoot"] = % vegas_guy_2_box_carry_turn_shoot;
  level.scr_anim["radio_guy"]["bar_radioguy_idle"][0] = % parabolic_phoneguy_idle;
  level.scr_anim["radio_guy"]["bar_radioguy_react"] = % parabolic_phoneguy_reaction;
  level.scr_anim["radio_guy"]["bar_radioguy_death"] = % vegas_guy_radio_death;
  level.scr_anim["radio_guy"]["bar_radio_pickup"] = % vegas_guy_radio_pickup;
  level.scr_anim["hesh"]["bar_radio_pickup"] = % vegas_keegan_radio_pickup;
  maps\_anim::addnotetrack_customfunction("hesh", "grab_radio", ::radio_grab, "bar_radio_pickup");
  maps\_anim::addnotetrack_customfunction("hesh", "holster_radio", ::radio_holster, "bar_radio_pickup");
  level.scr_anim["hesh"]["double_doors_open"] = % vegas_keegan_open_double_doors;
  maps\_anim::addnotetrack_customfunction("hesh", "door_open", ::kitchen_entry_doors_open, "double_doors_open");
}

gun_2_right(var_0) {
  var_0 maps\_utility::place_weapon_on(var_0.primaryweapon, "right");
}

bar_link_door(var_0) {
  var_1 = getent("bar_left_entry_door", "targetname");
  var_1 linkto(var_0, "tag_inhand", (0, 12, -2), (0, -90, 0));
}

bar_unlink_door(var_0) {
  var_1 = getent("bar_left_entry_door", "targetname");
  var_1 unlink();
}

radio_grab(var_0) {
  level.enemy_radio linkto(var_0, "tag_inhand", (0, 0, 0), (0, 0, 0));
}

radio_holster(var_0) {
  level.enemy_radio linkto(var_0, "tag_stowed_hip_rear", (6, -8, 10), (90, 20, -5));
}

kitchen_entry_doors_open(var_0) {
  var_1 = getEntArray("kitchen_entry_doors", "targetname");

  foreach(var_3 in var_1)
  var_3.og_angles = var_3.angles;

  thread maps\las_vegas_code::doors_open(var_1, 1.4, "double_door_wood_creeky", -110, 0, 0.5);
  common_scripts\utility::flag_set("kitchen_doors_open");
}

kitchen() {
  level.scr_anim["merrick"]["kitchen_stumble"] = % vegas_diaz_kitchen_stumble;
  level.scr_anim["merrick"]["kitchen_stumble_idle"][0] = % vegas_diaz_kitchen_idle;
  level.scr_anim["merrick"]["kitchen_stumble_idle_exit"] = % vegas_diaz_kitchen_idle_exit;
  level.scr_anim["keegan"]["kitchen_hide_enter"] = % vegas_keegan_kitchen_enter_start;
  level.scr_anim["keegan"]["kitchen_hide_wave_loop"][0] = % vegas_keegan_kitchen_enter_loop;
  level.scr_anim["keegan"]["kitchen_hide_wave_exit"] = % vegas_keegan_kitchen_enter_end;
  level.scr_anim["keegan"]["kitchen_hide_loop"][0] = % vegas_keegan_kitchen_wait_loop;
  level.scr_anim["keegan"]["kitchen_ambush_start"] = % vegas_keegan_ambush_start;
  maps\_anim::addnotetrack_customfunction("keegan", "detach_gun", ::detach_gun_custom, "kitchen_ambush_start");
  maps\_anim::addnotetrack_customfunction("keegan", "knife_on", ::knife_on, "kitchen_ambush_start");
  maps\_anim::addnotetrack_flag("keegan", "friendlies_exit", "kitchen_hide_everyone_up", "kitchen_ambush_end");
  level.scr_anim["keegan"]["kitchen_ambush_loop"][0] = % vegas_keegan_ambush_loop;
  level.scr_anim["keegan"]["kitchen_ambush_end"] = % vegas_keegan_ambush_end;
  maps\_anim::addnotetrack_customfunction("keegan", "attatch_gun_right", ::attach_gun_custom, "kitchen_ambush_end");
  level.scr_anim["flashlight_guy"]["kitchen_ambush_start"] = % vegas_guy_ambush_start;
  maps\_anim::addnotetrack_notify("flashlight_guy", "flashlight_unlink", "unlink_flashlight", "kitchen_ambush_start");
  level.scr_anim["flashlight_guy"]["kitchen_ambush_loop"][0] = % vegas_guy_ambush_loop;
  level.scr_anim["flashlight_guy"]["kitchen_ambush_end"] = % vegas_guy_ambush_end;
  level.scr_sound["flashlight_guy"]["kitchen_ambush_end"] = "scn_vegas_stealthkill_enemy_02";
  level.scr_anim["hesh"]["kitchen_hide_approach"] = % cqb_trans_2_readystand_6;
  level.scr_anim["hesh"]["kitchen_hide_enter"] = % vegas_baker_kitchen_enter;
  level.scr_anim["hesh"]["kitchen_hide_loop"][0] = % vegas_baker_kitchen_wait_loop;
  level.scr_anim["hesh"]["kitchen_hide_exit"] = % vegas_baker_kitchen_ambush;
  level.scr_anim["merrick"]["kitchen_hide_enter"] = % vegas_diaz_kitchen_enter;
  level.scr_anim["merrick"]["kitchen_hide_loop"][0] = % vegas_diaz_kitchen_wait_loop;
  level.scr_anim["merrick"]["kitchen_hide_exit"] = % vegas_diaz_kitchen_ambush;
  level.scr_anim["merrick"]["kitchen_alert_exit"] = % vegas_kitchen_ambush_getup_diaz;
  level.scr_anim["hesh"]["kitchen_alert_exit"] = % vegas_kitchen_ambush_getup_baker;
  level.scr_anim["keegan"]["kitchen_ambush"] = % vegas_baker_kitchen_ambush;
  level.scr_anim["flashlight_guy"]["kitchen_ambush"] = % vegas_guy_flashlight_kitchen_ambush;
  level.scr_anim["keegan"]["open_door_flathand"] = % hunted_open_barndoor_flathand;
  level.scr_anim["keegan"]["open_door_flathand_idle"][0] = % hunted_open_barndoor_idle;
  level.scr_anim["merrick"]["diaz_hallway_inject"] = % run_pain_stumble;
  level.scr_anim["generic"]["so_hijack_search_flashlight_high_loop"][0] = % so_hijack_search_flashlight_high_loop;
  level.scr_anim["rappeler"]["temp_rappel_over_rail"] = % oilrig_rappel_over_rail_r;
  level.scr_anim["keegan"]["tactical_open_door"] = % intro_tactical_open_door_push_a;
  level.scr_anim["generic"]["kitchen_enemy_doors_open"] = % vegas_guy_open_double_doors;
  maps\_anim::addnotetrack_customfunction("generic", "door_open", ::kitchen_enemy_doors_open, "kitchen_enemy_doors_open");
}

knife_on(var_0) {
  var_0.has_knife = 1;
  var_0 attach("weapon_commando_knife_bloody", "tag_inhand");
}

kitchen_enemy_doors_open(var_0) {
  if(common_scripts\utility::flag("kitchen_enemy_doors_open")) {
    return;
  }
  common_scripts\utility::flag_set("kitchen_enemy_doors_open");
  var_1 = getEntArray("casino_kitchen_doors02", "targetname");
  maps\las_vegas_code::doors_open(var_1, 1.2, "double_door_wood_creeky", undefined, 0, 0.4);
  maps\las_vegas_code::doors_open(var_1, 1.2, undefined, [-9, -1], 0, 0.4);
}

main_hotel() {
  level.scr_anim["keegan"]["open_casino_door"] = % vegas_corner_door_enter;
  level.scr_anim["hesh"]["traverse_jumpdown_130"] = % traverse_jumpdown_130;
  level.scr_anim["keegan"]["sandstorm_walk"] = % payback_pmc_sandstorm_stumble_1;
  level.scr_anim["hesh"]["sandstorm_walk"] = % payback_pmc_sandstorm_stumble_2;
  level.scr_anim["merrick"]["sandstorm_walk"] = % payback_pmc_sandstorm_stumble_3;
  level.scr_anim["gate_guy"]["rununder_casino_gate"] = % unarmed_runinto_garage;
  level.scr_anim["gate_guy"]["close_casino_gate"] = % unarmed_close_garage;
  level.scr_anim["keegan"]["gate_lift"] = % vegas_keegan_gate_lift;
  level.scr_anim["keegan"]["gate_idle"][0] = % vegas_keegan_gate_idle;
  level.scr_anim["keegan"]["under_gate"] = % vegas_keegan_gate_thru;
  level.scr_anim["keegan"]["vegas_keegan_gate_approach"] = % vegas_keegan_gate_lift;
  level.scr_anim["hesh"]["under_gate"] = % vegas_baker_gate_lift_thru;
  level.scr_anim["merrick"]["under_gate"] = % vegas_diaz_gate_thru;
  level.scr_anim["hesh"]["help_player"] = % vegas_baker_gate_thru;
  level.scr_anim["keegan"]["door_react"] = % vegas_baker_reverse_door_react;
  level.scr_anim["hesh"]["door_react"] = % vegas_keegan_reverse_door_react;
  level.scr_anim["merrick"]["door_react"] = % vegas_diaz_reverse_door_react;
  level.scr_anim["generic"]["straight_back01"] = % stand_death_head_straight_back;
  level.scr_anim["generic"]["straight_back00"] = % death_stand_sniper_spin1;
  level.scr_anim["generic"]["react_retreat00"] = % patrol_bored_react_look_retreat;
  level.scr_anim["generic"]["react_retreat01"] = % patrol_bored_react_look_v2;
  level.scr_anim["generic"]["react_retreat02"] = % patrol_bored_react_look_v1;
  level.scr_anim["generic"]["check_body"] = % hunted_woundedhostage_check_soldier;
}

hotel_room() {
  level.scr_anim["generic"]["vegas_raid_enemy_aware1"] = % vegas_raid_enemy_aware1;
  level.scr_anim["generic"]["vegas_raid_enemy_aware2"] = % vegas_raid_enemy_aware2;
  level.scr_anim["generic"]["vegas_raid_enemy_scout_aware1"] = % vegas_raid_enemy_scout_aware1;
  level.scr_anim["generic"]["vegas_raid_enemy_scout_aware2"] = % vegas_raid_enemy_scout_aware2;
  level.scr_anim["hesh"]["vegas_raid_enter"] = % vegas_keegan_raid_enter;
  level.scr_anim["hesh"]["vegas_raid_enter_jump2"] = % vegas_baker_raid_run_enter;
  level.scr_anim["merrick"]["vegas_raid_enter_jump2"] = % vegas_diaz_raid_enter;
  level.scr_anim["merrick"]["vegas_raid_enter"] = % vegas_diaz_raid_enter;
  level.scr_anim["hesh"]["vegas_raid_enter_idle"][0] = % vegas_keegan_raid_enter_idle;
  level.scr_anim["keegan"]["vegas_raid_lookaround"] = % vegas_keegan_raid_lookaround;
  level.scr_anim["hesh"]["vegas_raid_lookaround"] = % vegas_baker_raid_lookaround;
  level.scr_anim["merrick"]["vegas_raid_lookaround"] = % vegas_diaz_raid_lookaround;
  level.scr_anim["keegan"]["combatwalk_F_spin"] = % combatwalk_f_spin;
  level.scr_anim["keegan"]["vegas_raid_jump"] = % vegas_keegan_raid_run_jump;
  maps\_anim::addnotetrack_flag("keegan", "jump", "TRACKFLAG_KEEGAN_JUMP", "vegas_raid_jump");
  level.scr_anim["hesh"]["vegas_raid_jump"] = % vegas_baker_raid_window_jump;
  level.scr_anim["merrick"]["vegas_raid_jump"] = % vegas_baker_raid_window_jump;
  level.scr_anim["keegan"]["vegas_raid_jump_tarp_fall"] = % vegas_keegan_raid_jump_tarp_fall;
}

entrance() {
  level.scr_anim["keegan"]["raid_getup"] = % vegas_keegan_raid_getup;
  level.scr_anim["hesh"]["raid_getup"] = % vegas_baker_raid_getup;
  level.scr_anim["merrick"]["raid_getup"] = % vegas_diaz_raid_getup;
}

courtyard() {
  level.scr_anim["keegan"]["creepwalk_traverse_under"] = % creepwalk_traverse_under;
  level.scr_anim["hesh"]["creepwalk_traverse_over_small"] = % creepwalk_traverse_over_small;
  level.scr_anim["generic"]["creepwalk_traverse_under"] = % creepwalk_traverse_under;
  level.scr_anim["generic"]["creepwalk_traverse_over_small"] = % creepwalk_traverse_over_small;
  level.scr_anim["dog_guy"]["dog_kill"] = % iw6_dog_kill_back_long_guy_1;
  level.scr_anim["hesh"]["dog_hurt_enter"] = % vegas_dog_hurt_guy1_enter;
  level.scr_anim["hesh"]["dog_hurt_loop"] = % vegas_dog_hurt_guy1_loop;
  level.scr_anim["hesh"]["dog_hurt_exit"] = % vegas_dog_hurt_guy1_exit;
}

#using_animtree("dog");

courtyard_dog() {
  level.scr_animtree["dog"] = #animtree;
  level.scr_anim["dog"]["hurt_idle"][0] = % vegas_dog_hurt_dog;
  level.scr_anim["dog"]["hurt_idle_single"] = level.scr_anim["dog"]["hurt_idle"][0];
  level.scr_anim["dog"]["dog_kill"] = % iw6_dog_kill_back_long_1;
  level.scr_anim["dog"]["dog_pain"] = % vegas_dog_shot;
  level.scr_anim["dog"]["dog_pickup"] = % vegas_dog_pickup_dog;
}

#using_animtree("generic_human");

creepwalk_anims(var_0) {
  level.scr_anim[var_0]["creepwalk"][0] = % creepwalk_f;
  level.scr_anim[var_0]["creepwalk"][1] = % creepwalk_twitch_a_1;
  level.scr_anim[var_0]["creepwalk"][2] = % creepwalk_twitch_a_2;
  level.scr_anim[var_0]["creepwalk"][3] = % creepwalk_twitch_a_3;
  level.scr_anim[var_0]["creepwalk"][4] = % creepwalk_twitch_a_4;
  var_1 = [4, 1, 1, 1, 1];
  level.scr_anim[var_0]["creepwalk_weights"] = common_scripts\utility::get_cumulative_weights(var_1);
  level.scr_anim[var_0]["creepwalk_stop"] = % creepwalk_2_readystand;
  level.scr_anim[var_0]["creepwalk_start"] = % readystand_2_creepwalk;
  level.scr_anim[var_0]["creepwalk_2_run"] = % creepwalk_2_run;
}

#using_animtree("script_model");

model_anims() {
  level.scr_animtree["tag_origin"] = #animtree;
  level.scr_model["tag_origin"] = "tag_origin";
  level.scr_anim["tag_origin"]["kitchen_stumble"] = % vegas_cart_kitchen_stumble;
  level.scr_anim["tag_origin"]["kitchen_hide_enter"] = % vegas_kitchen_cart_fall;
  level.scr_animtree["cart"] = #animtree;
  level.scr_anim["cart"]["kitchen_stumble"] = % vegas_cart_kitchen_stumble;
  level.scr_anim["cart"]["kitchen_hide_enter"] = % vegas_kitchen_cart_fall;
  level.scr_anim["rappel_rope_rail"]["temp_rappel_over_rail"] = % oilrig_rappelrope_over_rail_r;
  level.scr_animtree["rappel_rope_rail"] = #animtree;
  level.scr_model["rappel_rope_rail"] = "oilrig_rappelrope_50ft";
  level.scr_animtree["window"] = #animtree;
  level.scr_model["window"] = "lv_windowshatter";
  level.scr_anim["window"]["raid_window_shatter"] = % vegas_window_shatter;
  level.scr_animtree["gate"] = #animtree;
  level.scr_model["gate"] = "lv_rolling_gate";
  level.scr_anim["gate"]["gate_lift"] = % vegas_gate_lift;
  level.scr_anim["gate"]["gate_idle"][0] = % vegas_gate_idle;
  level.scr_animsound["gate"]["gate_idle"][0] = "scn_vegas_gate_hold_lp";
  level.scr_anim["gate"]["under_gate"] = % vegas_gate_thru;
  level.scr_anim["train1"]["vegas_train_fall_idle"][0] = % vegas_train_idle;
  level.scr_anim["train1"]["vegas_train_fall"] = % vegas_train_fall_car1;
  level.scr_sound["train1"]["vegas_train_fall"] = "scn_vegas_train_fall";
  level.scr_anim["train2"]["vegas_train_fall"] = % vegas_train_fall_car2;
  level.scr_anim["track"]["vegas_train_fall"] = % vegas_train_fall_track;
  level.scr_anim["missile1"] = % vegas_missle1_heliride;
  level.scr_anim["missile2"]["missle2_heliride"] = % vegas_missle2_heliride;
  level.scr_anim["missile3"] = % vegas_missle3_heliride;
  level.scr_anim["missile4"] = % vegas_missle4_heliride;
  level.scr_anim["missile5"] = % vegas_missle5_heliride;
}

#using_animtree("player");

player_intro() {
  level.scr_anim["player_rig"]["ambush_fall"] = % vegas_ambush_player;
  level.scr_anim["player_rig"]["elias_death_start"] = % vegas_intro_start_player;
  level.scr_anim["player_rig"]["elias_death_struggle"] = % vegas_intro_struggle_player;
  level.scr_anim["player_rig"]["elias_death_end"] = % vegas_intro_end_player;
}

player_anims() {
  level.scr_animtree["player_tag"] = #animtree;
  level.scr_model["player_tag"] = "tag_origin";
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewhands_player_gs_hostage";
  level.scr_animtree["player_legs"] = #animtree;
  level.scr_model["player_legs"] = "viewlegs_generic";
  level.scr_anim["player_rig"]["under_gate"] = % vegas_player_gate_thru;
  level.scr_anim["player_rig"]["casino_player_slide"] = % vegas_player_building_slide;
  maps\_anim::addnotetrack_flag("player_rig", "scn_vegas_slide_catch", "TRACKFLAG_player_fall_grab", "casino_player_slide");
  maps\_anim::addnotetrack_flag("player_rig", "keegan_start_fall", "TRACKFLAG_start_keegan_fall", "casino_player_slide");
  maps\_anim::addnotetrack_customfunction("player_rig", "scn_vegas_slide_catch", ::stop_music, "casino_player_slide");
  maps\_anim::addnotetrack_customfunction("player_rig", "slomo_start", ::slide_slowmo, "casino_player_slide");
  maps\_anim::addnotetrack_flag("player_rig", "scn_vegas_slide_grabs", "TRACKFLAG_slide_stop_dirt_screen", "casino_player_slide");
  maps\_anim::addnotetrack_flag("player_rig", "slomo_end", "TRACKFLAG_fall_slomo_end", "casino_player_slide");
  level.scr_anim["player_legs"]["casino_player_slide"] = % vegas_player_building_slide_legs;
  maps\_anim::addnotetrack_playersound("player_rig", "scn_vegas_slide_fronts", "casino_player_slide", "scn_vegas_slide_fronts");
  maps\_anim::addnotetrack_playersound("player_rig", "scn_vegas_slide_catch", "casino_player_slide", "scn_vegas_slide_catch");
  maps\_anim::addnotetrack_playersound("player_rig", "scn_vegas_slide_grabs", "casino_player_slide", "scn_vegas_slide_grabs");
  maps\_anim::addnotetrack_playersound("player_rig", "scn_vegas_slide_hitground", "casino_player_slide", "scn_vegas_slide_hitground");
  level.scr_anim["player_rig"]["vegas_player_littlebird_lean_out"] = % vegas_player_littlebird_lean_out;
  level.scr_anim["player_rig"]["vegas_player_littlebird_lean_in"] = % vegas_player_littlebird_lean_in;
  level.scr_anim["player_rig"]["vegas_player_littlebird_lean_out_b"] = % vegas_player_littlebird_lean_out_b;
  level.scr_anim["player_rig"]["vegas_player_littlebird_lean_in_b"] = % vegas_player_littlebird_lean_in_b;
  level.scr_anim["player_rig"]["vegas_player_raid_jump_tarp_fall"] = % vegas_player_raid_jump_tarp_fall;
  level.scr_anim["player_rig"]["raid_getup"] = % vegas_player_raid_getup;
  level.scr_anim["player_rig"]["vegas_player_crash_getup"] = % vegas_player_crash_getup;
  level.scr_anim["player_rig"]["under_gate"] = % vegas_player_legs_gate_thru;
  maps\_anim::addnotetrack_customfunction("player_rig", "hand_raise", ::entrance_getup_hand_fx, "raid_getup");
  maps\_anim::addnotetrack_customfunction("player_rig", "hand_grab", ::entrance_getup_hand_grab, "raid_getup");
  maps\_anim::addnotetrack_customfunction("player_rig", "right_hand_lift", ::fx_right_hand_getup, "raid_getup");
  maps\_anim::addnotetrack_playersound("player_rig", "scn_vegas_getup_fronts", "raid_getup", "scn_vegas_getup_fronts");
  maps\_anim::addnotetrack_playersound("player_rig", "scn_vegas_getup_armup", "raid_getup", "scn_vegas_getup_armup");
  maps\_anim::addnotetrack_playersound("player_rig", "scn_vegas_getup_armdown", "raid_getup", "scn_vegas_getup_armdown");
  maps\_anim::addnotetrack_playersound("player_rig", "scn_vegas_getup_grab", "raid_getup", "scn_vegas_getup_grab");
}

player_dog_pickup() {
  level.scr_anim["player_rig"]["dog_pickup"] = % vegas_dog_pickup_player;
}

entrance_getup_hand_fx(var_0, var_1) {
  if(isDefined(level.entrance_fx_on_hand)) {
    return;
  }
  level.entrance_fx_on_hand = 1;
  var_2 = ["thumb", "index", "mid", "ring", "pinky"];

  foreach(var_4 in var_2) {
    for(var_5 = 0; var_5 < 3; var_5++)
      level thread fx_on_hand_thread("J_" + var_4 + "_LE_" + var_5, "fx_on_hand_" + var_5);
  }

  var_7 = ["j_sleave_reshape_top_le_1", "j_pinkypalm_le", "j_ringpalm_le", "j_webbing_le", "j_sleave_reshape_bottom_le_1", "j_sleave_reshape_bottom_le_2"];

  foreach(var_9 in var_7)
  level thread fx_on_hand_thread(var_9, "fx_on_wrist");

  thread fx_forearm_thread("fx_on_wrist", "le");
  common_scripts\utility::flag_set("fx_on_wrist");
  common_scripts\utility::flag_set("fx_on_hand_0");
  wait 1;
  common_scripts\utility::flag_set("fx_on_hand_1");
  wait 1;
  level notify("buried_sand_screen_increase");
  common_scripts\utility::flag_set("fx_on_hand_2");
  wait 0.5;
  level notify("stop_hand_sand_stream");
  wait 0.5;
  common_scripts\utility::flag_clear("fx_on_hand_2");
  wait 0.5;
  common_scripts\utility::flag_clear("fx_on_hand_1");
  wait 0.25;
  common_scripts\utility::flag_clear("fx_on_hand_0");
  common_scripts\utility::flag_clear("fx_on_wrist");
  wait 0.5;
  level notify("buried_sand_screen_remove");
}

fx_right_hand_getup(var_0) {
  thread fx_forearm_thread(undefined, "ri", 2);
}

fx_forearm_thread(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_2))
    var_3 = gettime() + var_2 * 1000;

  if(isDefined(var_0))
    common_scripts\utility::flag_wait(var_0);

  for(;;) {
    if(isDefined(var_0) && !common_scripts\utility::flag(var_0)) {
      return;
    }
    if(isDefined(var_3) && gettime() > var_3) {
      return;
    }
    wait(randomfloatrange(0.1, 0.2));
    var_4 = level.player_rig gettagorigin("j_wrist_" + var_1);
    var_5 = level.player_rig gettagorigin("j_wrist_" + var_1);
    var_6 = level.player_rig gettagorigin("j_elbow_" + var_1);
    var_7 = vectortoangles(var_6 - var_5);
    var_8 = anglestoright(var_7 + (0, 180, 0));
    var_4 = var_4 + var_8 * 2 + (0, 0, -3);
    var_7 = var_7 + (0, 13, 0);
    var_7 = anglesToForward(var_7);
    var_9 = anglestoup(var_7);
    playFX(common_scripts\utility::getfx("vfx_sand_forearm"), var_4, var_7, var_9);
  }
}

fx_on_hand_thread(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    if(!common_scripts\utility::flag_exist(var_1))
      common_scripts\utility::flag_init(var_1);

    common_scripts\utility::flag_wait(var_1);
  }

  var_3 = (1, 0, 0);
  var_4 = -4;

  while(common_scripts\utility::flag(var_1)) {
    wait(randomfloatrange(0.1, 0.3));
    var_5 = level.player_rig gettagorigin(var_0);
    playFX(common_scripts\utility::getfx("vfx_sand_hand"), var_5, var_3);
  }
}

entrance_getup_hand_grab(var_0) {
  maps\_utility::delaythread(0.5, maps\las_vegas_code::sun_direction, "courtyard");
  playFX(common_scripts\utility::getfx("vfx_hand_clap"), level.player_rig gettagorigin("tag_knife_attach2"));
}

#using_animtree("vehicles");

vehicle_anims() {
  level.scr_animtree["chopper"] = #animtree;
  level.scr_anim["chopper"]["vegas_littlebird_take_off"] = % vegas_littlebird_take_off;
  level.scr_anim["chopper"]["vegas_littlebird_crash"] = % vegas_littlebird_crash;
  level.scr_anim["chopper"]["vegas_littlebird_shimmy"] = % vegas_littlebird_shimmy;
  level.scr_anim["chopper"]["vegas_littlebird_fishtail"] = % vegas_littlebird_fishtail;
  level.scr_anim["chopper"]["vegas_littlebird_dip"] = % vegas_littlebird_dip;
  level.scr_anim["chopper"]["vegas_littlebird_impact_left"] = % vegas_littlebird_impact_left;
  level.scr_anim["chopper"]["vegas_strip_aas_72x_crash"] = % vegas_strip_aas_72x_crash;
  level.scr_anim["chopper"]["littlebird_idle"] = % vegas_littlebird_idle;
}

ai_kill(var_0) {
  if(!isalive(var_0)) {
    return;
  }
  if(isDefined(var_0.magic_bullet_shield) && var_0.magic_bullet_shield == 1)
    var_0 maps\_utility::stop_magic_bullet_shield();

  var_0.allowdeath = 1;
  var_0.a.nodeath = 1;
  var_0 maps\_utility::set_battlechatter(0);

  if(isDefined(var_0.headshotfx))
    playFX(common_scripts\utility::getfx("headshot_blood"), var_0 gettagorigin("j_head") + (0, 0, 5));

  var_0 kill();
}

anim_kill(var_0) {
  if(!isalive(var_0)) {
    return;
  }
  var_0.a.nodeath = 1;
  var_0.allowdeath = 1;
  var_0 maps\_utility::set_battlechatter(0);
  var_0 kill();
}

bar_sacrifice_kill(var_0) {
  var_0 maps\_utility::set_battlechatter(0);
  playFX(common_scripts\utility::getfx("headshot_blood"), var_0 gettagorigin("j_head") + (0, 0, 5));
  common_scripts\utility::flag_wait("TRACKFLAG_start_sacrifice_ragdoll");
  var_0 startragdoll();
  common_scripts\utility::waitframe();

  if(isDefined(var_0.magic_bullet_shield) && var_0.magic_bullet_shield == 1)
    var_0 maps\_utility::stop_magic_bullet_shield();

  var_0.allowdeath = 1;
  var_0.a.nodeath = 1;
  var_0 maps\_utility::set_battlechatter(0);

  if(isDefined(var_0.headshotfx))
    playFX(common_scripts\utility::getfx("headshot_blood"), var_0 gettagorigin("j_head") + (0, 0, 5));

  var_0 kill();
}

ai_startragdoll(var_0) {
  var_0 startragdoll();
}

ai_dropweapon(var_0) {
  var_0 maps\_utility::gun_remove();
  var_0 dropweapon(var_0.weapon, "right", 0.05);
}

rappelers_stop(var_0) {
  var_0 endon("death");
  var_0 stopanimscripted();
  var_0 notify("rappel_done");
}

hallway_roll_flash(var_0) {
  var_1 = var_0 gettagorigin("tag_weapon_left");
  var_2 = common_scripts\utility::getstruct("hallway_flash_end", "targetname");
  var_2.origin = var_2.origin + (0, -50, 0);
  var_3 = var_2.origin - var_1;
  var_4 = vectortoangles(var_3);
  var_5 = anglesToForward(var_4);
  var_6 = var_5 * 2000;
  var_7 = 1.5;

  foreach(var_9 in level.heroes)
  var_9 maps\_utility::setflashbangimmunity(1);

  var_11 = magicgrenademanual("flash_grenade", var_1, var_6, var_7);
  wait 0.5;
  level notify("stealth_event_notify");
  wait 0.5;
  playFX(level._effect["grenade_flash"], var_11.origin);
  var_12 = maps\_hud_util::create_client_overlay("white", 0.5, level.player);
  var_12 thread maps\_hud_util::fade_over_time(0, 0.5);
  thread common_scripts\utility::play_sound_in_space("flashbang_explode_default", var_11.origin);
  common_scripts\utility::flag_set("hallway_flashbang_banged");
  common_scripts\utility::waitframe();
  var_11 delete();
  wait 1;

  foreach(var_9 in level.heroes)
  var_9 maps\_utility::setflashbangimmunity(0);
}

stop_music(var_0) {}

slide_slowmo(var_0) {
  maps\_utility::music_play("mus_vegas_fall_hit_ground");
  setslowmotion(1, 0.25, 0.05);
  common_scripts\utility::flag_wait("TRACKFLAG_fall_slomo_end");
  setslowmotion(0.25, 1, 0.05);
}

hide_clip(var_0) {
  var_0 endon("wounded_ai_clip_twitch_complete");
  var_0 hidepart("tag_clip");
  var_0 attach("weapon_ak47_clip", "tag_inhand");
  var_0 maps\_utility::ent_flag_wait("wounded_ai_twitch_interrupted");
  var_0 detach("weapon_ak47_clip", "tag_inhand");
  var_0 showpart("tag_clip");
}

show_clip(var_0) {
  if(var_0 maps\_utility::ent_flag("wounded_ai_twitch_interrupted")) {
    return;
  }
  var_0 detach("weapon_ak47_clip", "tag_inhand");
  var_0 showpart("tag_clip");
  var_0 notify("wounded_ai_clip_twitch_complete");
}

radio_to_hand(var_0) {
  var_0.radio unlink();
  var_0.radio linkto(level.keegan, "tag_inhand", (0, 0, 0), (0, 0, 0));
}

radio_to_hip(var_0) {
  var_0.radio unlink();
  var_0.radio linkto(level.keegan, "tag_stowed_hip_rear", (0, 0, 0), (0, 0, 0));
}

#using_animtree("animated_props");

animated_props_anims() {
  level.scr_anim["foliage"]["palmtree_mp_bushy1_sway"] = % palmtree_mp_bushy1_sway;
  level.scr_anim["foliage"]["vegas_palmtree_straight_windy"] = % vegas_palmtree_straight_windy;
  level.scr_anim["foliage"]["vegas_palmtree_dead1_windy"] = % vegas_palmtree_dead1_windy;
  level.scr_anim["foliage"]["vegas_palmtree_dead2_windy"] = % vegas_palmtree_dead2_windy;
  level.scr_anim["foliage"]["foliage_pacific_tropic_shrub01_sway"] = % foliage_pacific_tropic_shrub01_sway;
  level.scr_anim["foliage"]["payback_sstorm_palm_bushy_windy_med"] = % payback_sstorm_palm_bushy_windy_med;
  level.scr_anim["foliage"]["payback_sstorm_dwarf_palm_light"] = % payback_sstorm_dwarf_palm_light;
  level.scr_anim["foliage"]["foliage_desertbrush_1_sway"] = % foliage_desertbrush_1_sway;
  level.scr_anim["foliage"]["foliage_pacific_fern02_sway"] = % foliage_pacific_fern02_sway;
}

outside_animated_props() {
  common_scripts\utility::flag_wait("start_outside_animated_props");
  var_0 = maps\_utility::getstructarray_delete("casino_entrance_foliage", "targetname", 0.05);
  var_1 = structs_to_animated_models(var_0);
  var_1 = common_scripts\utility::array_sort_by_handler(var_1, ::get_x);

  foreach(var_3 in var_1) {
    var_3 setanim(var_3 maps\_utility::getanim(var_3.animation), 1, 1, 0.1);
    var_3 thread tree_random_rotate();
  }

  var_5 = var_1[0].origin[0] - 10;
  var_6 = var_1[var_1.size - 1].origin[0] + 10;
  var_7 = var_6 - var_5;
  var_8 = 500;
  var_9 = 100;
  var_10 = var_7 / (var_8 * 10);
  var_11 = var_7 / (var_9 * 10);
  var_12 = 0;
  var_13 = spawnStruct();
  var_13.thread_count = 0;

  for(;;) {
    var_14 = randomfloatrange(3, 4);
    wait(var_14);
    var_15 = randomintrange(var_9, var_8);
    var_16 = var_7 / (var_15 * 10);
    var_17 = gettime() + var_16 * 1000;

    if(var_17 < var_12)
      wait((var_12 - var_17 + 100) * 0.001);

    var_18 = randomfloatrange(0.5, 1);

    if(var_13.thread_count < 3) {
      var_12 = gettime() + var_16 * 1000;
      var_13 thread fake_wind_line(var_1, var_5, var_6, var_15, var_18);
    }
  }
}

fake_wind_line(var_0, var_1, var_2, var_3, var_4) {
  self.thread_count++;
  var_5 = var_1;

  while(var_5 < var_2) {
    var_5 = var_5 + var_3;

    foreach(var_8, var_7 in var_0) {
      if(var_7.origin[0] < var_5) {
        var_7 setanim(var_7 maps\_utility::getanim(var_7.animation), 1, 3, var_4);
        var_0[var_8] = undefined;
      }
    }

    wait 0.1;
  }

  self.thread_count--;
}

tree_random_rotate() {
  var_0 = self.angles;
  var_1 = 0;
  self.is_solid = 1;

  for(;;) {
    wait 0.1;

    if(distance2dsquared(level.player.origin, self.origin) < 1048576) {
      if(!self.is_solid) {
        self solid();
        self.is_solid = 1;
      }
    } else if(self.is_solid) {
      self notsolid();
      self.is_solid = 0;
    }

    if(gettime() < var_1) {
      var_2 = randomfloatrange(-15, 15);
      var_3 = randomfloatrange(-10, 10);
      var_4 = randomfloatrange(8, 15);
      self rotateto(var_0 + (var_3, var_2, 0), var_4, var_4 * 0.4, var_4 * 0.5);
      var_1 = gettime() + var_4 * 1000;
    }
  }
}

print_rate(var_0) {
  self notify("print_rate");
  self endon("print_rate");

  for(;;)
    wait 0.05;
}

get_x() {
  return self.origin[0];
}

structs_to_animated_models(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = spawn("script_model", var_3.origin);
    var_4.angles = (0, 0, 0);

    if(isDefined(var_3.angles))
      var_4.angles = var_3.angles;

    var_4 setModel(var_3.script_modelname);
    var_4.animation = var_3.animation;
    var_4.targetname = var_3.targetname;
    var_4.animname = "foliage";
    var_4 useanimtree(#animtree);
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

#using_animtree("generic_human");

init_wounded_archetype() {
  var_0 = [];
  var_0["run"]["move_f"] = % vegas_baker_limp;
  var_0["run"]["straight"] = % vegas_baker_limp;
  var_0["run"]["straight_twitch"] = [%vegas_baker_limp_twitch_1, %vegas_baker_limp_twitch_2, %vegas_baker_limp_twitch_3];
  var_0["idle"]["stand"][0] = [%vegas_baker_stand_idle, %vegas_baker_stand_idle_twitch_1, %vegas_baker_stand_idle_twitch_2];
  var_0["idle_weights"]["stand"][0] = [1, 1, 1];
  var_0["default_stand"]["exposed_idle"] = [%vegas_baker_stand_idle, %vegas_baker_stand_idle_twitch_1, %vegas_baker_stand_idle_twitch_2];
  var_1["right"][1] = % vegas_baker_pillar_stand_approach_1_r;
  var_1["right"][2] = % vegas_baker_pillar_stand_approach_2_r;
  var_1["right"][3] = % vegas_baker_pillar_stand_approach_3_r;
  var_1["left"][1] = % vegas_baker_pillar_stand_approach_1_l;
  var_1["left"][2] = % vegas_baker_pillar_stand_approach_2_l;
  var_1["left"][3] = % vegas_baker_pillar_stand_approach_3_l;
  var_1["exposed"][1] = % vegas_baker_limp_to_stand_idle;
  var_1["exposed"][2] = % vegas_baker_limp_to_stand_idle;
  var_1["exposed"][3] = % vegas_baker_limp_to_stand_idle;
  var_1["exposed"][4] = % vegas_baker_limp_to_stand_idle;
  var_1["exposed"][6] = % vegas_baker_limp_to_stand_idle;
  var_1["exposed"][7] = % vegas_baker_limp_to_stand_idle;
  var_1["exposed"][8] = % vegas_baker_limp_to_stand_idle;
  var_1["exposed"][9] = % vegas_baker_limp_to_stand_idle;
  var_0["cover_trans"] = var_1;
  var_2["right"][1] = % vegas_baker_pillar_exit_8_r;
  var_2["right"][2] = % vegas_baker_pillar_exit_8_r;
  var_2["right"][3] = % vegas_baker_pillar_exit_8_r;
  var_2["right"][4] = % vegas_baker_pillar_exit_4_r;
  var_2["right"][6] = % vegas_baker_pillar_exit_6_r;
  var_2["right"][9] = % vegas_baker_pillar_exit_9_r;
  var_2["left"][1] = % vegas_baker_pillar_exit_8_l;
  var_2["left"][2] = % vegas_baker_pillar_exit_8_l;
  var_2["left"][3] = % vegas_baker_pillar_exit_8_l;
  var_2["left"][4] = % vegas_baker_pillar_exit_4_l;
  var_2["left"][6] = % vegas_baker_pillar_exit_6_l;
  var_2["left"][7] = % vegas_baker_pillar_exit_7_l;
  var_2["exposed"][1] = % vegas_baker_stand_idle_to_limp;
  var_2["exposed"][2] = % vegas_baker_stand_idle_to_limp;
  var_2["exposed"][3] = % vegas_baker_stand_idle_to_limp;
  var_2["exposed"][4] = % vegas_baker_stand_idle_to_limp;
  var_2["exposed"][6] = % vegas_baker_stand_idle_to_limp;
  var_2["exposed"][7] = % vegas_baker_stand_idle_to_limp;
  var_2["exposed"][8] = % vegas_baker_stand_idle_to_limp;
  var_2["exposed"][9] = % vegas_baker_stand_idle_to_limp;
  var_0["cover_exit"] = var_2;
  var_3["alert_idle"] = % vegas_baker_pillar_stand_idle_r;
  var_3["alert_idle_twitch"] = [%vegas_baker_pillar_stand_idle_twitch_pain_r];
  var_3["alert_idle_flinch"] = undefined;
  var_3["alert_to_look"] = % vegas_baker_pillar_stand_idle_look_r_in;
  var_3["look_idle"] = % vegas_baker_pillar_stand_idle_look_r_loop;
  var_3["look_to_alert"] = % vegas_baker_pillar_stand_idle_look_r_out;
  var_0["cover_right_stand"] = var_3;
  var_4["alert_idle"] = % vegas_baker_pillar_stand_idle_l;
  var_4["alert_idle_twitch"] = [%vegas_baker_pillar_stand_idle_twitch_pain_l];
  var_4["alert_idle_flinch"] = undefined;
  var_4["alert_to_look"] = % vegas_baker_pillar_stand_idle_look_l_in;
  var_4["look_idle"] = % vegas_baker_pillar_stand_idle_look_l_loop;
  var_4["look_to_alert"] = % vegas_baker_pillar_stand_idle_look_l_out;
  var_0["cover_left_stand"] = var_4;
  maps\_utility::register_archetype("wounded", var_0);
  var_5["left"] = 1;
  var_5["right"] = 1;

  for(var_6 = 1; var_6 <= 6; var_6++) {
    if(var_6 == 5) {
      continue;
    }
    foreach(var_9, var_8 in var_5)
    set_trans_dist_angles("wounded", var_9, var_6);
  }
}

set_trans_dist_angles(var_0, var_1, var_2) {
  if(isDefined(anim.archetypes[var_0]["cover_trans"][var_1])) {
    if(isDefined(anim.archetypes[var_0]["cover_trans"][var_1][var_2])) {
      anim.archetypes[var_0]["cover_trans_dist"][var_1][var_2] = getmovedelta(anim.archetypes[var_0]["cover_trans"][var_1][var_2], 0, 1);
      anim.archetypes[var_0]["cover_trans_angles"][var_1][var_2] = getangledelta(anim.archetypes[var_0]["cover_trans"][var_1][var_2], 0, 1);
      anim.covertranslongestdist[var_1] = 0;
      var_3 = lengthsquared(anim.archetypes[var_0]["cover_trans_dist"][var_1][var_2]);

      if(anim.covertranslongestdist[var_1] < var_3)
        anim.covertranslongestdist[var_1] = sqrt(var_3);
    }
  }

  if(isDefined(anim.archetypes[var_0]["cover_exit"][var_1])) {
    if(isDefined(anim.archetypes[var_0]["cover_exit"][var_1][var_2])) {
      if(animhasnotetrack(anim.archetypes[var_0]["cover_exit"][var_1][var_2], "code_move"))
        var_4 = getnotetracktimes(anim.archetypes[var_0]["cover_exit"][var_1][var_2], "code_move")[0];
      else
        var_4 = 1;

      anim.archetypes[var_0]["cover_exit_dist"][var_1][var_2] = getmovedelta(anim.archetypes[var_0]["cover_exit"][var_1][var_2], 0, var_4);
      anim.archetypes[var_0]["cover_exit_angles"][var_1][var_2] = getangledelta(anim.archetypes[var_0]["cover_exit"][var_1][var_2], 0, 1);
    }
  }
}

detach_gun_custom(var_0) {
  var_1 = "tag_weapon_right";
  var_2 = var_0 gettagorigin(var_1);
  var_3 = var_0 gettagangles(var_1);
  var_4 = spawn("script_model", var_2);
  var_4.angles = var_3;

  if(isDefined(var_0.detach_gun_angles))
    var_4.angles = var_0.detach_gun_angles;

  if(isDefined(var_0.detach_gun_origin))
    var_4.origin = var_0.detach_gun_origin;

  var_5 = getweaponmodel(var_0.weapon);
  var_4 setModel(var_5);
  var_0.dropped_gun = var_4;
  var_0 animscripts\shared::placeweaponon(var_0.weapon, "none");
  var_0.dropweapon = 0;
}

attach_gun_custom(var_0) {
  if(!isDefined(var_0.dropped_gun)) {
    return;
  }
  var_0.dropped_gun delete();
  var_0.dropweapon = 1;
  var_0 animscripts\shared::placeweaponon(var_0.weapon, "right");

  if(isDefined(var_0.detach_gun_angles))
    var_0.detach_gun_angles = undefined;

  if(isDefined(var_0.detach_gun_origin))
    var_0.detach_gun_origin = undefined;
}