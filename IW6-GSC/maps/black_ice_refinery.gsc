/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\black_ice_refinery.gsc
***************************************/

start() {
  iprintln("Refinery");
  maps\black_ice_util::player_start("player_start_refinery");
  var_0 = ["struct_ally_start_refinery_01", "struct_ally_start_refinery_02"];
  level._allies maps\black_ice_util::teleport_allies(var_0);
  thread maps\black_ice_audio::audio_derrick_explode_logic("start");
  thread maps\black_ice_flarestack::event_pressure_buildup_start(0.0);
  thread maps\black_ice_audio::sfx_exited_flarestack();
  thread maps\black_ice::trains_periph_logic(0.0, 1);
  common_scripts\utility::exploder("flamestack_snow");
  common_scripts\utility::exploder("refinery_lights");
  common_scripts\utility::exploder("refinery_lights_b");
}

main() {
  common_scripts\utility::array_call(getEntArray("opt_hide_refinery", "script_noteworthy"), ::show);
  common_scripts\utility::array_call(getEntArray("opt_hide_swim", "script_noteworthy"), ::hide);
  common_scripts\utility::array_call(getEntArray("opt_hide_camp", "script_noteworthy"), ::hide);
  thread trigger_wait_flag_set("trig_refinery_ally_7", "flag_trig_refinery_ally_7");
  thread maps\black_ice_fx::turn_on_oil_derrick_lightsfx();
  common_scripts\utility::exploder("refinery_stack_smoke");
  common_scripts\utility::exploder("refinery_lights");
  common_scripts\utility::array_thread(level._allies, maps\_utility::disable_cqbwalk);
  setignoremegroup("ignore_allies", "allies");
  thread enemies();
  thread allies();
  thread event_derrick_explode();
  thread dialogue();
  thread event_elevator_door_open();
  thread player_tanks_foreshocks();
  level thread maps\black_ice_util::waittill_notify_flag_set("notify_refinery_explosion_start", "flag_refinery_explosion_start");
  thread maps\black_ice_fx::refinery_turn_on_buildup_fx_01();
  maps\_utility::vision_set_fog_changes("black_ice_refinery", 2.0);
  setsaveddvar("r_snowAmbientColor", (0.02, 0.02, 0.03));
  common_scripts\utility::flag_wait("flag_refinery_end");
}

section_flag_inits() {
  common_scripts\utility::flag_init("flag_refinery_explosion");
  common_scripts\utility::flag_init("flag_refinery_engagement_start");
  common_scripts\utility::flag_init("flag_refinery_advance_1");
  common_scripts\utility::flag_init("flag_refinery_advance_2");
  common_scripts\utility::flag_init("flag_refinery_advance_3");
  common_scripts\utility::flag_init("flag_refinery_gas_blowout_01");
  common_scripts\utility::flag_init("flag_refinery_gas_blowout_02");
  common_scripts\utility::flag_init("flag_refinery_gas_blowout_03");
  common_scripts\utility::flag_init("flag_retfinery_retreat");
  common_scripts\utility::flag_init("flag_refinery_done");
  common_scripts\utility::flag_init("flag_derrick_exploded");
  common_scripts\utility::flag_init("flag_tanks_catwalk_collapse");
  common_scripts\utility::flag_init("flag_ally_cqb");
  common_scripts\utility::flag_init("flag_refinery_foreshocks");
  common_scripts\utility::flag_init("deathflag_refinery");
}

section_precache() {
  precachestring(&"BLACK_ICE_REFINERY_DEBRIS_DEATH");
}

section_post_inits() {
  level._refinery = spawnStruct();
  level._refinery.destroyed_derrick_models = getEntArray("model_derrick_collapsed", "script_noteworthy");
  common_scripts\utility::array_call(level._refinery.destroyed_derrick_models, ::hide);
  level._refinery.derrick_struct = common_scripts\utility::getstruct("struct_derrick", "targetname");
  level._refinery.enemy_struct = common_scripts\utility::getstruct("struct_refinery_explosion_scene", "targetname");

  if(isDefined(level._refinery.enemy_struct)) {
    event_derrick_explode_debris_setup();
    common_scripts\utility::array_call(getEntArray("opt_hide_refinery", "script_noteworthy"), ::hide);
  } else
    iprintln("black_ice_refinery.gsc: Warning - Enemy struct missing (compiled out?)");
}

dialogue() {
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  level waittill("notify_baker_hold_dialogue");
  level._allies[0] maps\_utility::smart_dialogue("black_ice_bkr_waitforit");
  level waittill("notify_derrick_explode_done");
  level._allies[0] maps\_utility::delaythread(1, maps\_utility::smart_dialogue, "black_ice_bkr_getdown");
  level common_scripts\utility::waittill_either("notify_notetrack_debris_end", "flag_refinery_engagement_start");
  level._allies[0] maps\_utility::smart_dialogue("black_ice_bkr_weaponsfreeweaponsfree");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::battlechatter_on("axis");
}

dialogue_baker_waitforit() {
  common_scripts\utility::flag_wait("flag_refinery_explosion");
  thread maps\black_ice_audio::sfx_pa_bursts();
  level notify("notify_baker_hold_dialogue");
}

dialogue_ally_pulling_back() {
  wait 2;
  level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_backpushforward");
}

allies() {
  common_scripts\utility::array_thread(level._allies, maps\_utility::disable_pain);
  common_scripts\utility::array_thread(level._allies, maps\black_ice_util::ignore_everything);
  level._allies[0] thread allies_baker_hold();
  level._allies thread maps\black_ice_util_ai::ally_advance_watcher("trig_refinery_color_start", "refinery_main");
  level common_scripts\utility::waittill_either("notify_notetrack_debris_end", "flag_refinery_engagement_start");
  level._allies[1] maps\black_ice_util::set_forcesuppression(0);
  wait 0.05;
  maps\_utility::activate_trigger_with_targetname("trig_refinery_color_start");
  level._allies[1] maps\black_ice_util::unignore_everything();
  common_scripts\utility::flag_wait("flag_refinery_advance_1");
  thread dialogue_ally_pulling_back();
  common_scripts\utility::flag_wait("flag_refinery_end");

  while(level._enemies["refinery_main"].size > 0)
    wait 0.05;

  common_scripts\utility::array_thread(level._allies, maps\_utility::enable_pain);
}

allies_baker_hold() {
  var_0 = common_scripts\utility::getstruct("struct_refinery_baker_hold", "targetname");
  maps\_utility::trigger_wait_targetname("trig_refinery_color_stairs");
  thread dialogue_baker_waitforit();
  level.player thread util_player_rubber_banding_solo(self);
  self.moveplaybackrate = 1.1;
  thread allies_baker_hold_approach_and_idle(var_0);
  common_scripts\utility::flag_wait("flag_refinery_explosion_start");
  level notify("notify_stop_rubber_banding");
  setsaveddvar("g_speed", 190);
  self.moveplaybackrate = 1;
  var_0 notify("stop_loop");
  var_0 maps\_anim::anim_single_solo(self, "refinery_hold_end");
  maps\black_ice_util::unignore_everything();
  maps\_utility::disable_pain();
  maps\_utility::enable_ai_color();
}

allies_baker_hold_approach_and_idle(var_0) {
  var_0 maps\_anim::anim_reach_solo(self, "refinery_hold_init");
  self.moveplaybackrate = 1;
  var_0 maps\_anim::anim_single_solo(self, "refinery_hold_init");

  if(common_scripts\utility::flag("flag_refinery_explosion_start")) {
    return;
  }
  var_0 maps\_anim::anim_loop_solo(self, "refinery_hold_idle");
}

enemies() {
  level.retreat_final = "vol_retreat_refinery_final";
  enemies_setup_explosion_scene_guys();
  maps\_utility::array_spawn_function_targetname("enemies_refinery_right", ::spawnfunc_enemy_right);
  maps\_utility::array_spawn_function_targetname("enemies_refinery_left", ::spawnfunc_enemy_generic);
  maps\_utility::array_spawn_function_targetname("enemies_refinery_left_fence", ::spawnfunc_enemy_generic);
  maps\_utility::array_spawn_function_targetname("enemies_refinery_back", ::spawnfunc_enemy_generic);
  maps\_utility::array_spawn_function_targetname("enemies_refinery_flood_1", ::spawnfunc_enemy_generic);
  maps\_utility::array_spawn_function_targetname("enemies_refinery_rpg", ::spawnfunc_enemy_rpg);
  maps\_utility::array_spawn_function_targetname("enemies_refinery_elevator", ::spawnfunc_enemy_elevator);
  maps\_utility::array_spawn_function_targetname("enemies_refinery_plan_b", ::spawnfunc_enemy_plan_b);
  thread maps\black_ice_util_ai::retreat_watcher("trig_refinery_retreat", "refinery_main", "vol_retreat_refinery_initial", 3);
  thread enemies_right_door();
  thread enemies_left_side();
  thread encounter_start();
  common_scripts\utility::flag_wait("flag_refinery_end");
  var_0 = maps\_utility::remove_dead_from_array(level._enemies["refinery_main"]);

  if(var_0.size > 3)
    maps\_utility::array_spawn_targetname("enemies_refinery_plan_b");

  maps\_utility::trigger_wait_targetname("trig_refinery_cleanup");

  if(isDefined(level._refinery.foreman) && isalive(level._refinery.foreman)) {
    if(isDefined(level._refinery.foreman.magic_bullet_shield) && level._refinery.foreman.magic_bullet_shield)
      level._refinery.foreman maps\_utility::stop_magic_bullet_shield();
  }

  maps\_utility::kill_deathflag("deathflag_refinery", 3);
  level._enemies["refinery_main"] = [];
  level.retreat_final = undefined;
}

enemies_setup_explosion_scene_guys() {
  maps\_utility::array_spawn_function_targetname("enemies_refinery_02", ::spawnfunc_enemy_scene_scripted, "refinery_initial");
  var_0 = getEntArray("enemies_refinery_01", "targetname");
  var_1 = var_0[0];
  var_0 = maps\_utility::array_remove_index(var_0, 0);
  var_1 maps\_utility::add_spawn_function(::spawnfunc_enemy_scene_anim_controller);
  var_2 = ["refinery_guy1", "refinery_guy2", "refinery_guy3", "refinery_guy5", "refinery_guy6"];

  for(var_3 = 0; var_3 < var_0.size; var_3++)
    var_0[var_3] maps\_utility::add_spawn_function(::spawnfunc_enemy_scene_anim, "refinery_initial", var_2[var_3]);
}

spawnfunc_enemy_scene_anim(var_0, var_1) {
  maps\black_ice_util_ai::add_to_group(var_0, 0);
  self setthreatbiasgroup("ignore_allies");
  self.animname = var_1;
  self.a.disablelongdeath = 1;
  self.doing_reaction_anim = 0;
  self.v.interrupt_all_notifies = 1;

  if(issubstr(self.animname, "1") || issubstr(self.animname, "2"))
    self forcedeathfall(1);

  if(issubstr(self.animname, "4"))
    thread spawnfunc_enemy_scene_solo_auto_kill();

  if(issubstr(self.animname, "5")) {
    self.maxfaceenemydist = 384;
    thread spawnfunc_enemy_scene_solo_crate_guy();
  }

  if(issubstr(self.animname, "6"))
    thread spawnfunc_enemy_scene_solo_foreman_smash_end();

  thread spawnfunc_enemy_scene_solo();
}

spawnfunc_enemy_scene_scripted(var_0) {
  maps\black_ice_util_ai::add_to_group(var_0, 0);
  self setthreatbiasgroup("ignore_allies");
  self.a.disablelongdeath = 1;
  self.maxfaceenemydist = 384;
  self.animname = "generic";
  thread spawnfunc_enemy_scene_scripted_damage_interrupt();
  thread spawnfunc_enemy_scene_scripted_natural_interrupt();
}

spawnfunc_enemy_generic(var_0) {
  maps\black_ice_util_ai::add_to_group("refinery_main");
  self setthreatbiasgroup("axis");
  self.a.disablelongdeath = 1;
  self.maxfaceenemydist = 384;
}

spawnfunc_enemy_right(var_0) {
  maps\black_ice_util_ai::add_to_group("refinery_main");
  self setthreatbiasgroup("axis");
  self.a.disablelongdeath = 1;
  self.maxfaceenemydist = 384;
}

spawnfunc_enemy_rpg(var_0) {
  self endon("death");
  maps\black_ice_util_ai::add_to_group("refinery_rpg");
  self setthreatbiasgroup("axis");
  self.a.disablelongdeath = 1;
  self.goalradius = 8;
  self.ignoreall = 1;
  self.maxfaceenemydist = 384;
  self waittill("goal");
  self.ignoreall = 0;
  common_scripts\utility::flag_wait("flag_trig_refinery_ally_7");
  maps\_utility::kill_deathflag("deathflag_refinery_rpg");
}

spawnfunc_enemy_elevator(var_0) {
  maps\black_ice_util_ai::add_to_group("refinery_main");
  self setthreatbiasgroup("ignore_allies");
  self.a.disablelongdeath = 1;
  self.maxfaceenemydist = 384;
  thread spawnfunc_enemy_elevator_wait();
}

spawnfunc_enemy_plan_b() {
  self setthreatbiasgroup("axis");
  self.a.disablelongdeath = 1;
  maps\_utility::set_baseaccuracy(10);
  thread maps\_utility::player_seek_enable();
}

spawnfunc_enemy_scene_scripted_damage_interrupt() {
  level endon("flag_refinery_engagement_start");
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    level notify("notify_vignette_end", var_1);
  }
}

spawnfunc_enemy_scene_scripted_natural_interrupt() {
  self endon("death");
  maps\black_ice_util::ignore_everything();
  common_scripts\utility::flag_wait("flag_refinery_engagement_start");
  maps\black_ice_util::unignore_everything();
}

spawnfunc_enemy_scene_anim_controller() {
  self hide();
  self setthreatbiasgroup("ignore_allies");
  self.animname = "refinery_guy1";
  self.v.invincible = 1;
  self.a.disablelongdeath = 1;
  self.doing_reaction_anim = 0;
  common_scripts\utility::flag_wait("flag_refinery_explosion");
  level._refinery.enemy_struct maps\_anim::anim_single_solo(self, "derrick_explode_scene");
  level notify("notify_refinery_scene_complete");
  self delete();
}

spawnfunc_enemy_scene_solo() {
  self endon("death");
  level._refinery.enemy_struct thread maps\_anim::anim_first_frame_solo(self, "derrick_explode_scene");
  common_scripts\utility::flag_wait("flag_refinery_explosion");
  var_0 = undefined;
  level._refinery.enemy_struct thread maps\black_ice_vignette::vignette_single_solo(self, "derrick_explode_scene");
}

spawnfunc_enemy_scene_solo_crate_guy() {
  self endon("death");
  self endon("msg_vignette_interrupt");
  level waittill("notify_traveling_block_impact");
  maps\black_ice_vignette::vignette_stop_interrupt_scripts("other");
}

spawnfunc_enemy_scene_solo_foreman_smash_end() {
  self endon("death");
  self endon("msg_vignette_interrupt");
  level._refinery.foreman = self;
  level waittill("notify_traveling_block_impact");
  maps\black_ice_vignette::vignette_stop_interrupt_scripts();
  self.v.ignoreall_on_end = 1;
  self.v.invincible = 1;
  level._enemies["refinery_initial"] = common_scripts\utility::array_remove(level._enemies["refinery_initial"], self);
  self waittill("msg_vignette_start_anim_done");
  self.v.anim_node maps\_anim::anim_first_frame_solo(self, "death_pose");
  maps\_utility::magic_bullet_shield();
}

spawnfunc_enemy_scene_solo_auto_kill() {
  self endon("death");
  level waittill("notify_refinery_scene_complete");
  maps\black_ice_vignette::vignette_kill();
}

spawnfunc_enemy_elevator_wait() {
  self endon("death");
  thread spawnfunc_enemy_elevator_damage_interrupt();
  level waittill("notify_elevator_open");
  self setthreatbiasgroup("axis");
  maps\black_ice_util_ai::go_to_goal_vol(level._refinery.current_volumes);
}

spawnfunc_enemy_elevator_damage_interrupt() {
  self endon("death");
  self endon("notify_elevator_open");
  self waittill("damage");
  self setthreatbiasgroup("axis");
}

encounter_start() {
  level.player.ignoreme = 1;
  thread player_interrupt_watcher();
  var_0 = getent("trig_refinery_flood_1", "script_noteworthy");
  level common_scripts\utility::waittill_any("notify_refinery_scene_complete", "flag_refinery_player_started_encounter", "flag_refinery_engagement_start");
  common_scripts\utility::flag_set("flag_refinery_engagement_start");
  maps\_utility::delaythread(4, ::enemies_flood, var_0);
  setthreatbias("allies", "axis", 1000);
  setthreatbias("axis", "allies", 1000);
  level._enemies["refinery_initial"] = maps\_utility::remove_dead_from_array(level._enemies["refinery_initial"]);
  common_scripts\utility::array_thread(level._enemies["refinery_initial"], maps\black_ice_util_ai::add_to_group, "refinery_main", "vol_retreat_refinery_initial");
  common_scripts\utility::array_call(level._enemies["refinery_initial"], ::setthreatbiasgroup, "axis");
  level notify("notify_enemy_retreat_logic_start");

  if(!common_scripts\utility::flag("flag_refinery_player_started_encounter"))
    wait 3;

  level.player.ignoreme = 0;
}

player_interrupt_watcher() {
  level endon("flag_refinery_engagement_start");
  level waittill("msg_vignette_interrupt");
  common_scripts\utility::flag_set("flag_refinery_player_started_encounter");
}

enemies_flood(var_0) {
  if(isDefined(var_0))
    var_0 maps\_utility::activate_trigger();
}

enemies_left_side() {
  level common_scripts\utility::waittill_either("flag_refinery_engagement_start", "flag_refinery_player_started_encounter");
  maps\_utility::array_spawn_targetname("enemies_refinery_left");
}

enemies_right_door() {
  level common_scripts\utility::waittill_either("flag_refinery_engagement_start", "flag_refinery_player_started_encounter");

  if(!common_scripts\utility::flag("flag_refinery_player_started_encounter"))
    wait 3;

  var_0 = maps\black_ice_util::setup_door("model_refinery_right_door");
  var_0 thread maps\black_ice_util::open_door(90, 0.6, 0.05);
  maps\_utility::array_spawn_targetname("enemies_refinery_right");
}

event_derrick_explode() {
  var_0 = getent("origin_derrick_lookat", "targetname");
  thread event_derrick_explode_debris_bomb();
  thread event_derrick_explode_setup();
  thread vision_set_refinery_visionsets();
  common_scripts\utility::flag_wait("flag_refinery_explosion");
  level waittill("notify_refinery_explosion_start");

  if(isDefined(level._pipe_deck.boats_struct))
    thread event_derrick_explode_stack_setup();

  thread maps\black_ice_fx::turn_off_refinery_buildup_fx_01();
  common_scripts\utility::flag_set("flag_fx_screen_bokehdots_rain");
  wait 2;
  maps\_utility::autosave_by_name("refinery_2");
}

event_derrick_explode_stack_setup() {
  var_0 = 4;
  var_1 = [1.5, 1.5, 2.5, 2.5];
  var_2 = [4, 4, 3, 3];

  for(var_3 = 0; var_3 < var_0; var_3++) {
    var_4 = getEntArray("refinery_stack_anim_" + var_3, "targetname");
    var_5 = getent("refinery_stack_anim_node_" + var_3, "script_noteworthy");
    var_6 = var_5 common_scripts\utility::spawn_tag_origin();

    foreach(var_8 in var_4)
    var_8 linkto(var_6);

    thread event_derrick_explode_stack_motion(var_6, var_1[var_3], var_2[var_3]);
  }
}

util_refinery_stack_cleanup() {
  var_0 = 4;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = getEntArray("refinery_stack_anim_" + var_1, "targetname");
    common_scripts\utility::array_call(var_2, ::delete);
  }

  maps\_utility::stop_exploder("refinery_stack_smoke");
}

event_derrick_explode_stack_motion(var_0, var_1, var_2) {
  var_3 = (1408, 3968, 0);
  var_4 = var_0.origin - var_3;
  var_4 = (var_4[0], var_4[1], 0);
  var_5 = length(var_4);
  var_4 = vectornormalize(var_4);
  var_6 = 3000.0;
  var_7 = 1.0;
  wait(var_5 / var_6 * var_7);
  var_0 vibrate(var_4, var_1, var_2, var_2);

  for(var_8 = 2; var_1 / var_8 > 0.5; var_8++) {
    wait(var_2);
    var_0 vibrate(var_4, var_1 / var_8, var_2, var_2);
  }

  wait(var_2);
  var_0 vibrate(var_4, 0.01, var_2, var_2);
}

event_derrick_explode_debris_bomb() {
  var_0 = getEntArray("model_refinery_container", "targetname");
  var_1 = getEntArray("model_refinery_container_destroyed", "targetname");

  foreach(var_3 in var_1)
  var_3 hide();

  var_5 = getent("origin_refinery_debris_explosion", "targetname");
  level waittill("notify_traveling_block_impact");

  foreach(var_7 in var_0)
  var_7 hide();

  foreach(var_3 in var_1)
  var_3 show();

  setsaveddvar("phys_gravity_ragdoll", -400);

  foreach(var_12 in level._enemies["refinery_initial"]) {
    if(isalive(var_12)) {
      var_13 = common_scripts\utility::spawn_tag_origin();
      var_13.origin = var_12.origin;
      var_13.angles = vectortoangles(var_12.origin - var_5.origin);

      if(distance(var_12.origin, var_5.origin) < 256) {
        var_12 maps\black_ice_vignette::vignette_end("debris_bomb");
        var_12 thread event_derrick_explode_debris_bomb_throw_enemy(var_13);
      }
    }
  }

  thread event_derrick_explode_debris_bomb_tank_player_quake();
  physicsexplosionsphere(var_5.origin, 1024, 1023, 3);
  var_15 = getent("refinery_tank_fire_1", "targetname");
  var_15 setlightintensity(2.0);
  thread maps\black_ice_util::black_ice_geyser_pulse();
  thread maps\black_ice_util::black_ice_geyser2_pulse();
  playFX(common_scripts\utility::getfx("refinery_debris_explosion"), var_5.origin);
  maps\_utility::stop_exploder("refinery_lights_b");
  wait 0.2;
  common_scripts\utility::flag_set("flag_fire_damage_on");
  common_scripts\utility::exploder("refinery_debris_fire_oiltank");
  thread maps\black_ice_util::exploder_damage_loop("refinery_debris_fire_oiltank", level._fire_damage_ent);
  level waittill("notify_derrick_vignette_done");
  setsaveddvar("phys_gravity_ragdoll", -800);
}

event_derrick_explode_debris_bomb_tank_player_quake() {
  wait 0.15;
  earthquake(0.21, 1.5, level.player.origin, 128);
}

event_derrick_explode_debris_bomb_throw_enemy(var_0) {
  self endon("death");
  maps\_utility::gun_remove();
  var_0 maps\_anim::anim_single_solo(self, "derrick_explode_death");
  self kill();
}

event_elevator_door_open() {
  var_0 = maps\black_ice_util::setup_door("model_refinery_lift_door_top");
  var_1 = maps\black_ice_util::setup_door("model_refinery_lift_door_bottom");
  var_2 = maps\black_ice_util::setup_door("model_refinery_lift_gate");
  maps\_utility::trigger_wait_targetname("trig_refinery_elevator_enemies");
  maps\_utility::array_spawn_targetname("enemies_refinery_elevator");
  var_0 thread maps\black_ice_util::open_gate(var_0.origin + (0, 0, 48), 6);
  var_1 thread maps\black_ice_util::open_gate(var_1.origin - (0, 0, 63), 6);
  wait 2;
  var_2 maps\black_ice_util::open_gate(var_2.origin + (0, 0, 88), 6, 4);
  level notify("notify_elevator_open");
}

util_derrick_destroy_quick() {
  if(isDefined(level.derrick_model))
    level.derrick_model delete();

  util_show_destroyed_derrick();
}

util_show_destroyed_derrick() {
  level notify("notify_remove_derrick_model");

  if(isDefined(level._refinery.derrick_model))
    level._refinery.derrick_model delete();

  var_0 = level._refinery.destroyed_derrick_models;
  maps\_utility::stop_exploder("oil_geyser_01");
  common_scripts\utility::exploder("oil_geyser_02");

  foreach(var_2 in var_0)
  var_2 show();
}

event_derrick_explode_setup() {
  var_0 = level._refinery.derrick_struct;
  var_1 = level._refinery.derrick_model;
  var_2 = level._refinery.barrel_model_1;
  var_3 = level._refinery.barrel_model_2;
  var_4 = level._refinery.barrel_model_3;
  var_5 = level._refinery.barrel_model_4;
  var_6 = level._refinery.barrel_model_5;
  thread event_derrick_explode_large(var_0);
  thread event_derrick_explode_impact_rig(var_0);
  thread event_derrick_explode_debris_oiltank(var_0);
  thread event_derrick_explode_debris_main(var_0);
  thread event_derrick_explode_catwalk_break(var_0);
  thread event_derrick_explode_debris_show_and_damage();
  thread fx_refinery_ceiling_fire();
  level waittill("notify_refinery_explosion_start");
  var_0 thread maps\_anim::anim_single_solo(var_2, "barrel_crush_1");
  var_0 thread maps\_anim::anim_single_solo(var_3, "barrel_crush_2");
  var_0 thread maps\_anim::anim_single_solo(var_4, "barrel_crush_3");
  var_0 thread maps\_anim::anim_single_solo(var_5, "barrel_crush_4");
  var_0 thread maps\_anim::anim_single_solo(var_6, "barrel_crush_5");
  var_0 maps\_anim::anim_single_solo(var_1, "collapse");
  level notify("notify_derrick_vignette_done");
  level waittill("notify_remove_derrick_model");
  var_2 delete();
  var_3 delete();
  var_4 delete();
  var_5 delete();
  var_6 delete();
}

event_derrick_explode_large(var_0) {
  level waittill("notify_derrick_large_explosion");
  maps\_utility::stop_exploder("flamestack_snow");
  common_scripts\utility::exploder("derrick_explode_large");
  common_scripts\utility::exploder("oil_geyser_01");
  common_scripts\utility::exploder("oil_spots_01");
  thread maps\black_ice_fx::turn_off_oil_derrick_lightsfx();
  thread maps\black_ice_fx::turn_on_bokeh_fieryflash_player_fx();
  thread maps\black_ice_audio::audio_derrick_explode_logic("stop");
  wait 0.5;
  common_scripts\utility::exploder("derrick_shockwave");
  thread fx_snow_shockwave();
  wait 1.0;
  earthquake(0.35, 2, level.player.origin, 128);
  var_1 = vectornormalize(level.player.origin - var_0.origin);
  thread maps\black_ice_util::push_player_impulse(var_1, 21, 0.9);
  level.player playrumbleonentity("grenade_rumble");
  level notify("notify_derrick_explode_done");
}

fx_snow_shockwave() {
  wait 0.82;
  common_scripts\utility::exploder("shockwave_snow");
}

event_derrick_explode_debris_oiltank(var_0) {
  var_1 = ["oiltank_debris_1_1", "oiltank_debris_1_2", "oiltank_debris_1_3", "oiltank_debris_3"];
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = maps\_utility::spawn_anim_model(var_4);
    var_0 maps\_anim::anim_first_frame_solo(var_5, "derrick_explosion");
    var_2 = common_scripts\utility::array_add(var_2, var_5);
  }

  foreach(var_8 in level._refinery.scripted)
  var_8 show();

  level waittill("notify_refinery_explosion_start");
  var_10 = common_scripts\utility::array_combine(level._refinery.scripted, var_2);
  var_10 = common_scripts\utility::array_remove(var_10, level._refinery.scripted["traveling_block"]);
  var_10 = common_scripts\utility::array_remove(var_10, level._refinery.scripted["derrick_chunk"]);
  var_0 thread maps\_anim::anim_single(var_10, "derrick_explosion");
  level waittill("notify_notetrack_debris_end");

  foreach(var_8 in level._refinery.scripted) {
    foreach(var_13 in var_8._col)
    var_13 disconnectpaths();
  }

  level waittill("notify_remove_derrick_model");

  foreach(var_5 in var_2)
  var_5 delete();
}

event_derrick_explode_catwalk_break(var_0) {
  var_1 = maps\_utility::spawn_anim_model("oiltank_catwalk");
  var_2 = getent("model_refinery_tank_catwalk", "targetname");
  level waittill("notify_derrick_large_explosion");
  var_0 thread maps\_anim::anim_single_solo(var_1, "oiltank_catwalk");
  var_1 hide();
  level waittill("notify_swap_catwalk");
  var_1 show();
  var_2 hide();
}

event_derrick_explode_impact_rig(var_0) {
  level waittill("notify_derrick_impact_rig");
  thread maps\black_ice_audio::sfx_blackice_derrick_exp4_ss();
  wait 0.65;
  earthquake(0.17, 2, level.player.origin, 128);
}

event_derrick_explode_debris_main(var_0) {
  var_1 = level._refinery.scripted["derrick_chunk"];
  var_2 = level._refinery.scripted["traveling_block"];
  var_3 = maps\_utility::spawn_anim_model("derrick_debris_1");
  var_4 = maps\_utility::spawn_anim_model("derrick_debris_1");
  var_5 = maps\_utility::spawn_anim_model("derrick_debris_2");
  var_6 = maps\_utility::spawn_anim_model("derrick_debris_2");
  var_7 = maps\_utility::spawn_anim_model("derrick_debris_3");
  var_8 = maps\_utility::spawn_anim_model("derrick_debris_3");
  var_9 = maps\_utility::spawn_anim_model("derrick_debris_4");
  var_10 = maps\_utility::spawn_anim_model("derrick_debris_4");
  var_11 = maps\_utility::spawn_anim_model("derrick_debris_5");
  var_12 = maps\_utility::spawn_anim_model("derrick_debris_5");
  var_13 = maps\_utility::spawn_anim_model("derrick_debris_6");
  var_14 = maps\_utility::spawn_anim_model("derrick_debris_6");
  level waittill("notify_derrick_large_explosion");
  var_1 thread event_derrick_explode_debris_main_fx_runner(var_1, "refinery_debris_trail_large", "refinery_debris_smolder_large");
  var_2 thread event_derrick_explode_debris_main_fx_runner(var_2, "refinery_debris_trail_large", "refinery_debris_smolder_large");
  thread maps\black_ice_fx::refinery_travelling_block_impact_fx();
  var_15 = [var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14];

  foreach(var_17 in var_15)
  var_17 thread event_derrick_explode_debris_main_fx_runner(var_17, "refinery_debris_trail_small", "refinery_debris_smolder_small");

  var_0 thread maps\_anim::anim_single_solo(var_1, "derrick_explosion");
  var_0 thread maps\_anim::anim_single_solo(var_2, "derrick_explosion");
  var_0 thread maps\_anim::anim_single_solo(var_3, "derrick_debris_1");
  var_0 thread maps\_anim::anim_single_solo(var_4, "derrick_debris_2");
  var_0 thread maps\_anim::anim_single_solo(var_5, "derrick_debris_1");
  var_0 thread maps\_anim::anim_single_solo(var_6, "derrick_debris_2");
  var_0 thread maps\_anim::anim_single_solo(var_7, "derrick_debris_1");
  var_0 thread maps\_anim::anim_single_solo(var_8, "derrick_debris_2");
  var_0 thread maps\_anim::anim_single_solo(var_9, "derrick_debris_1");
  var_0 thread maps\_anim::anim_single_solo(var_10, "derrick_debris_2");
  var_0 thread maps\_anim::anim_single_solo(var_11, "derrick_debris_1");
  var_0 thread maps\_anim::anim_single_solo(var_12, "derrick_debris_2");
  var_0 thread maps\_anim::anim_single_solo(var_13, "derrick_debris_1");
  var_0 thread maps\_anim::anim_single_solo(var_14, "derrick_debris_2");
}

event_derrick_explode_debris_main_fx_runner(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_3.origin = var_0.origin;
  var_3 linkto(var_0);
  playFXOnTag(common_scripts\utility::getfx(var_1), var_3, "tag_origin");
  self waittill("hitground");
  stopFXOnTag(common_scripts\utility::getfx(var_1), var_3, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx(var_2), var_3, "tag_origin");
}

event_derrick_explode_debris_setup() {
  var_0 = level._refinery.derrick_struct;
  level._refinery.derrick_model = getent("model_blackice_derrick", "targetname");
  level._refinery.derrick_model maps\_utility::assign_animtree("derrick");
  var_0 maps\_anim::anim_first_frame_solo(level._refinery.derrick_model, "collapse");
  level._refinery.barrel_model_1 = maps\_utility::spawn_anim_model("barrel_crush", var_0.origin);
  var_0 maps\_anim::anim_first_frame_solo(level._refinery.barrel_model_1, "barrel_crush_1");
  level._refinery.barrel_model_2 = maps\_utility::spawn_anim_model("barrel_crush", var_0.origin);
  var_0 maps\_anim::anim_first_frame_solo(level._refinery.barrel_model_2, "barrel_crush_2");
  level._refinery.barrel_model_3 = maps\_utility::spawn_anim_model("barrel_crush", var_0.origin);
  var_0 maps\_anim::anim_first_frame_solo(level._refinery.barrel_model_3, "barrel_crush_3");
  level._refinery.barrel_model_4 = maps\_utility::spawn_anim_model("barrel_crush", var_0.origin);
  var_0 maps\_anim::anim_first_frame_solo(level._refinery.barrel_model_4, "barrel_crush_4");
  level._refinery.barrel_model_5 = maps\_utility::spawn_anim_model("barrel_crush", var_0.origin);
  var_0 maps\_anim::anim_first_frame_solo(level._refinery.barrel_model_5, "barrel_crush_5");
  level._refinery.scripted = [];
  var_1 = getEntArray("models_derrick_explosion", "targetname");

  foreach(var_3 in var_1) {
    var_3 maps\_utility::assign_animtree(var_3.script_parameters);
    var_3 event_derrick_explode_debris_setup_collision(var_3.script_parameters);
    var_0 maps\_anim::anim_first_frame_solo(var_3, "derrick_explosion");
    var_3 hide();
    level._refinery.scripted[var_3.script_parameters] = var_3;
  }
}

event_derrick_explode_debris_setup_collision(var_0) {
  self._col = getEntArray(self.target, "targetname");

  if(var_0 == "traveling_block") {
    foreach(var_2 in self._col) {
      if(issubstr(var_2.script_noteworthy, "hook")) {
        var_2 linkto(self, "tag_hook");
        continue;
      }

      if(issubstr(var_2.script_noteworthy, "block")) {
        var_2 linkto(self, "tag_base");
        continue;
      }
    }
  } else {
    foreach(var_2 in self._col)
    var_2 linkto(self);
  }
}

event_derrick_explode_debris_show_and_damage() {
  level waittill("notify_derrick_large_explosion");

  foreach(var_1 in level._refinery.scripted) {
    foreach(var_3 in var_1._col)
    var_3 thread event_derrick_explode_debris_damage();
  }
}

fx_refinery_ceiling_fire() {
  level waittill("notify_refinery_scene_complete");
  common_scripts\utility::exploder("refinery_ceiling_fire");
}

event_derrick_explode_debris_damage() {
  level endon("notify_notetrack_debris_end");

  for(;;) {
    var_0 = maps\_utility::remove_dead_from_array(level._enemies["refinery_initial"]);

    foreach(var_2 in var_0) {
      if(self istouching(var_2)) {
        if(common_scripts\utility::flag("flag_refinery_player_started_encounter")) {
          if(var_2.v.active)
            var_2 maps\black_ice_vignette::vignette_kill();
          else
            var_2 kill();

          continue;
        }

        if(!issubstr(var_2.animname, "1") && !issubstr(var_2.animname, "2") && !issubstr(var_2.animname, "5") && !issubstr(var_2.animname, "6")) {
          if(var_2.v.active) {
            var_2 maps\black_ice_vignette::vignette_kill();
            continue;
          }

          var_2 kill();
        }
      }
    }

    if(self istouching(level.player)) {
      level.player kill();
      setdvar("ui_deadquote", &"BLACK_ICE_REFINERY_DEBRIS_DEATH");
      maps\_utility::missionfailedwrapper();
    }

    wait 0.05;
  }
}

player_tanks_foreshocks() {
  common_scripts\utility::flag_wait("flag_trig_refinery_ally_7");
  common_scripts\utility::exploder("tanks_oil_rain");
  common_scripts\utility::exploder("tanks_lights");
  maps\_utility::trigger_wait_targetname("trig_tanks_foreshock");
  var_0 = 0.07;
  var_1 = 0.18;
  var_2 = 0.7;
  var_3 = 1.3;
  var_4 = 0.3;
  var_5 = 1.8;

  for(var_6 = 6; !common_scripts\utility::flag("flag_tanks_catwalk_collapse") && var_6 > 0; var_6 = var_6 - 1) {
    thread maps\black_ice_audio::sfx_black_ice_tanks_rumble();
    var_7 = randomfloatrange(var_0, var_1);
    var_8 = randomfloatrange(var_4, var_5);
    var_9 = randomfloatrange(var_2, var_3);
    earthquake(var_7, var_9, level.player.origin, 3000);
    thread maps\black_ice_audio::sfx_screenshake();
    wait(var_8);
  }
}

util_debris_remove() {
  if(isDefined(level._refinery.scripted)) {
    foreach(var_1 in level._refinery.scripted) {
      if(isDefined(var_1)) {
        foreach(var_3 in var_1._col)
        var_3 delete();

        var_1 delete();
      }
    }
  }
}

vision_set_refinery_visionsets() {
  level waittill("notify_derrick_large_explosion");
  maps\_utility::vision_set_changes("black_ice_refinery_burn", 2.0);
  maps\_art::sunflare_changes("refinery", 1.5);
}

util_player_rubber_banding_solo(var_0) {
  level endon("notify_stop_rubber_banding");
  var_1 = 120;
  var_2 = 190;
  var_3 = 64;

  for(;;) {
    var_4 = distance(self.origin, var_0.origin);

    if(var_4 > var_3)
      var_4 = var_3;
    else if(var_4 < 0)
      var_4 = 0;

    var_5 = var_4 / var_3;
    var_6 = var_2 - (var_2 - var_1) * var_5;
    setsaveddvar("g_speed", var_6);
    wait 0.05;
  }

  level notify("notify_stop_rubber_banding");
}

trigger_wait_flag_set(var_0, var_1) {
  if(!common_scripts\utility::flag_exist(var_1))
    common_scripts\utility::flag_init(var_1);

  maps\_utility::trigger_wait_targetname(var_0);
  common_scripts\utility::flag_set(var_1);
}