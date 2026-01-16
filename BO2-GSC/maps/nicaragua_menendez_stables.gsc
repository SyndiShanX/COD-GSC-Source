/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua_menendez_stables.gsc
***********************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\nicaragua_util;
#include maps\_anim;
#include maps\_horse;
#include maps\nicaragua_menendez_rage;
#include maps\_fxanim;
#include animscripts\shared;
#include maps\_vehicle;

skipto_menendez_stables() {
  skipto_teleport_players("player_skipto_menendez_stables");
  exploder(20);
  exploder(101);
  exploder(320);
  exploder(323);
  battlechatter_on("axis");
  level.player setclientdvar("cg_aggressiveCullRadius", 495);
  model_removal_through_model_convert_system("menendez_lower_village");
  model_restore_area("menendez_execution");
  model_restore_area("menendez_stables_and_upper_village");
  model_convert("destructible_cocaine_bundles", "script_noteworthy");
  run_scene_first_frame("barn_doors");
  maps\_fxanim::fxanim_reconstruct("fxanim_barn_explode_01");
  maps\_fxanim::fxanim_reconstruct("fxanim_barn_explode_02");
  destructibles_in_area("menendez_execution");
  destructibles_in_area("menendez_stables_and_upper_village");
}

init_flags() {
  flag_init("padlock_removed");
  flag_init("pdf_rage_attackers");
  flag_init("nicaragua_stables_complete");
  flag_init("player_grab_pitchfork");
  flag_init("pitchfork_decision_made");
}

init_spawn_functions() {
  createthreatbiasgroup("menendez");
  createthreatbiasgroup("stables_pdf_0");
  createthreatbiasgroup("stables_pdf_1");
  createthreatbiasgroup("stables_pdf_2");
  createthreatbiasgroup("stables_pdf_3");
  createthreatbiasgroup("stables_pdf_4");
  createthreatbiasgroup("stables_pdf_5");
  createthreatbiasgroup("stables_pdf_6");
  setignoremegroup("menendez", "stables_pdf_0");
  setignoremegroup("menendez", "stables_pdf_1");
  setignoremegroup("menendez", "stables_pdf_2");
  setignoremegroup("menendez", "stables_pdf_3");
  setignoremegroup("menendez", "stables_pdf_4");
  setignoremegroup("menendez", "stables_pdf_5");
  setignoremegroup("menendez", "stables_pdf_6");
  add_spawn_function_ai_group("stables_pdf_attacker", ::stables_pdf_logic);
  sp_stables_pdf = getent("stables_pdf_front", "targetname");
  sp_stables_pdf add_spawn_function(::stables_brutality_logic);
  sp_stables_pdf add_spawn_function(::stables_brutality_front_logic);
  sp_stables_pdf = getent("stables_pdf_back", "targetname");
  sp_stables_pdf add_spawn_function(::stables_brutality_logic);
  sp_stables_pdf = getent("stables_pdf_center", "script_noteworthy");
  sp_stables_pdf add_spawn_function(::stables_rage_get_to_goal, "stables_pdf_center", "stable_exposed_right");
  sp_stables_pdf = getent("stables_pdf_left", "script_noteworthy");
  sp_stables_pdf add_spawn_function(::stables_rage_get_to_goal, "stables_pdf_left", "stable_exposed_left");
  add_spawn_function_veh_by_type("horse_axis", ::horse_spawn_func);
}

main() {
  init_flags();
  init_spawn_functions();
  exploder(320);
  exploder(323);
  debug_print_line("Nicaragua Stables");
  level thread nicaragua_stables_spawning();
  level thread brutality_scene(2, "anim_brutality_stables_front", "generic_civ_female", "stables_pdf_front", undefined, "trig_stables_front_brutality_start", "vol_execution_civ");
  level thread brutality_scene(1, "anim_brutality_stables_back", "generic_civ_male", "stables_pdf_back", undefined, "trig_stables_back_brutality_start", "vol_execution_civ");
  level thread execution_enemies_chase_after_player();
  level thread nicaragua_stables_objectives();
  level thread nicaragua_stables_vo();
  level thread horses_in_stable();
  level thread shoot_lock_trigger();
  level thread nicaragua_stables_animations();
  maps\_fxanim::fxanim_reconstruct("fxanim_sunshade_reed");
  flag_wait("nicaragua_stables_complete");
  exploder(330);
  event_cleanup();
}

event_cleanup() {
  kill_spawnernum(3);
}

execution_enemies_chase_after_player() {
  a_enemies = getaiarray("axis");

  while(a_enemies.size) {
    ai_enemy = get_farthest(level.player.origin, a_enemies);

    if(isalive(ai_enemy) && ai_enemy.origin[0] < -4096) {
      ai_enemy fake_rush();
      ai_enemy thread force_goal();
      ai_enemy waittill("death");
    } else
      arrayremovevalue(a_enemies, ai_enemy);

    a_enemies = array_removedead(a_enemies);
    wait 0.05;
  }
}

nicaragua_stables_objectives() {
  level notify("strt_hrs");
  s_barn_door = getstruct("obj_barn_door", "targetname");
  set_objective(level.obj_menendez_save_josefina, s_barn_door, "");
  flag_wait("padlock_removed");
  e_trigger = getent("objective_exit_stables_trigger", "targetname");
  str_struct_name = e_trigger.target;
  s_struct = getstruct(str_struct_name, "targetname");
  set_objective(level.obj_menendez_save_josefina, s_struct, "");
  e_trigger waittill("trigger");
  set_objective(level.obj_menendez_save_josefina, undefined, "remove");
  flag_set("nicaragua_stables_complete");
}

nicaragua_stables_vo() {
  scene_wait("barn_door_player");
  level thread stables_brutality_front_vo();
  level waittill("rage_on");
  ai_pdf = get_closest_living(level.player.origin, getaiarray("axis"));
  ai_pdf say_dialog("pdf2_kill_him_0");
}

stables_brutality_front_vo() {
  ai_civ = getent("generic_civ_female_ai", "targetname");
  ai_civ endon("death");
  ai_pdf = getent("stables_pdf_front_ai", "targetname");
  ai_pdf endon("death");
  ai_civ say_dialog("cf7_nooooo_0");
  wait 1;
  ai_pdf say_dialog("pdf3_stay_still_you_stup_0");
  wait 1;
  ai_civ say_dialog("cf7_get_off_0");
  flag_wait("brutality_pdf_react_2_started");
  ai_pdf say_dialog("pdf3_this_does_not_concer_0");
}

shoot_lock_trigger() {
  trigger_wait("trig_barn_door");
  level.player playsound("evt_stable_doors");
  level notify("hrsx");
  m_barn_door_clip = getent("clip_barn_door", "targetname");
  m_barn_door_clip connectpaths();
  autosave_by_name("player_opens_stables");
  delay_thread(1, ::rage_mode_important_vo, "mene_aaaaarrgh_0");
  level thread run_scene("barn_doors");
  level thread run_scene("barn_door_player");
  level thread delete_execution_enemies();
  scene_wait("barn_door_player");
  level.player thread menendez_cleanup_after_anim();
  m_barn_door_clip delete();
  exploder(310);
  flag_set("padlock_removed");
}

delete_execution_enemies() {
  a_enemies = getaiarray("axis");

  foreach(ai_enemy in a_enemies) {
    if(isalive(ai_enemy) && ai_enemy.origin[0] < -4096)
      ai_enemy delete();
  }
}

horses_in_stable() {
  level waittill("strt_hrs");

  while(true) {
    level endon("hrsx");
    playsoundatposition("chr_horse_whinny_loud_npc", (-4543, 2818, 1521));
    wait(randomintrange(1, 2));
  }
}

stables_connect_paths() {
  nd_exterior_left = getnode("stables_exterior_left", "targetname");
  nd_exterior_right = getnode("stables_exterior_right", "targetname");
  nd_interior_left = getnode("stables_interior_left", "targetname");
  nd_interior_right = getnode("stables_interior_right", "targetname");
  linknodes(nd_exterior_left, nd_interior_left);
  linknodes(nd_interior_left, nd_exterior_left);
  linknodes(nd_exterior_left, nd_interior_right);
  linknodes(nd_interior_right, nd_exterior_left);
  linknodes(nd_exterior_right, nd_interior_left);
  linknodes(nd_interior_left, nd_exterior_right);
  linknodes(nd_exterior_right, nd_interior_right);
  linknodes(nd_interior_right, nd_exterior_right);
}

nicaragua_stables_animations() {
  trigger_wait("trig_barn_door");
  level.player rage_medium();
  level.player setthreatbiasgroup("menendez");
  simple_spawn("stables_pdf");
  trigger_wait("trig_stables_rage");
  level thread rage_mode_important_vo("mene_die_for_your_sins_0");
  level.player rage_high();
  level thread rage_high_logic("stables_pdf_attacker", 1);
}

stables_brutality_logic() {
  level endon("rage_on");
  self waittill("death");
  t_pdf_enter = getent("trig_stables_pdf_enter", "targetname");

  if(isDefined(t_pdf_enter))
    t_pdf_enter useby(level.player);

  t_brutality_start = getent("trig_stables_front_brutality_start", "targetname");

  if(isDefined(t_brutality_start))
    t_brutality_start useby(level.player);

  wait 3;
  t_rage = getent("trig_stables_rage", "targetname");

  if(isDefined(t_rage))
    t_rage useby(level.player);
}

stables_brutality_front_logic() {
  self endon("death");
  scene_wait("brutality_pdf_react_2");
  self fake_rush();
  clear_threatbias("menendez", self.script_string);
}

player_grab_pitchfork() {
  level endon("pitchfork_decision_made");
  level.player waittill_use_button_pressed();
  flag_set("player_grab_pitchfork");
  flag_set("pitchfork_decision_made");
}

stables_attacker_stabbed_with_pitchfork(ai_attacker) {
  wait 1.6;
  playfxontag(level._effect["pitchfork_blood"], ai_attacker, "j_spinelower");
  wait 1.0;
  playfxontag(level._effect["pitchfork_blood"], ai_attacker, "j_spinelower");
}

_stables_attack_woman_idle() {
  scene_wait("attacked_woman_react_to_player");
  str_scene = "attacked_woman_react_idle";
  level thread run_scene(str_scene);
  flag_wait("nicaragua_stables_complete");
  end_scene(str_scene);
}

pitchfork_think() {
  level endon("pitchfork_logic_done");

  while(!flag("player_grabbed_pitchfork")) {
    if(self usebuttonpressed())
      flag_set("player_grabbed_pitchfork");

    wait 0.05;
  }

  flag_set("pitchfork_logic_done");
}

stables_triggers_player_rage(delay) {
  wait(delay);
  flag_set("pdf_rage_attackers");
}

nicaragua_stables_spawning() {
  level thread charging_horse_spawners();
  level thread stables_trapped_horses();
  level thread collapse_roof();
}

horse_spawn_func() {
  level.vehicle_death_thread["horse_axis"] = ::horse_death_nicaragua;
  self makevehicleunusable();
}

#using_animtree("horse");

horse_death_nicaragua() {
  self.script_crashtypeoverride = "horse";
  self.ignore_death_jolt = 1;
  self notsolid();
  self setvehicleavoidance(0);

  if(isDefined(self.delete_on_death) && self.delete_on_death) {
    return;
  }
  self.dontfreeme = 1;
  death_anim = undefined;
  death_ai_anim = undefined;

  if(isDefined(self.current_anim_speed)) {
    if(self.current_anim_speed == level.idle) {
      if(randomintrange(1, 100) < 50)
        death_anim = level.horse_deaths[2].animation;
      else
        death_anim = level.horse_deaths[3].animation;
    } else if(randomintrange(1, 100) < 50)
      death_anim = level.horse_deaths[0].animation;
    else
      death_anim = level.horse_deaths[1].animation;
  }

  if(isDefined(self.death_anim))
    death_anim = self.death_anim;

  if(isDefined(death_anim)) {
    self setflaggedanimknoball("horse_death", death_anim, % root, 1, 0.2, 1);
    self animscripts\shared::donotetracks("horse_death", ::handle_horse_death_fx);
    self waittillmatch("horse_death", "stop");

    if(self.classname == "script_vehicle")
      self vehicle_setspeed(0, 25, "Dead");
  }

  self.dontfreeme = undefined;
}

charging_horse_spawners() {
  flag_wait("padlock_removed");
  level thread start_charging_horse("stables_charging_horse1_spawner", "horse1_charging_path_start_node");
  level thread start_charging_horse("stables_charging_horse2_spawner", "horse2_charging_path_start_node", 0.5);
  level thread start_charging_horse("stables_charging_horse3_spawner", "horse3_charging_path_start_node", 0.65, undefined, 1);
  level thread start_charging_horse("stables_charging_horse4_spawner", "horse4_charging_path_start_node", 0.25);
  level thread start_charging_horse("stables_charging_horse5_spawner", "horse4_charging_path_start_node", 3);
  level thread start_charging_horse("stables_charging_horse6_spawner", "back_righ_horse_start", undefined, undefined, 1);
}

stables_trapped_horses() {
  a_horses_trapped = maps\_vehicle::spawn_vehicles_from_targetname("trapped_horse");

  foreach(vh_horse in a_horses_trapped)
  vh_horse thread trapped_horse_update();

  vh_horse = maps\_vehicle::spawn_vehicle_from_targetname("stables_charging_horse3_spawner");
  vh_horse thread trapped_horse_update();
  vh_horse = maps\_vehicle::spawn_vehicle_from_targetname("stables_charging_horse6_spawner");
  vh_horse thread trapped_horse_update();
}

trapped_horse_update() {
  self endon("death");
  self endon("start_running");
  self horse_panic();

  while(!flag("nicaragua_stables_complete")) {
    wait(randomfloat(1.1));
    self horse_rearback();
    self playsound("chr_horse_whinny_loud_npc");
  }

  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

collapse_roof() {
  flag_wait("padlock_removed");
  level notify("fxanim_barn_explode_01_start");
  playsoundatposition("evt_stable_collapse_a", (-4207, 2816, 1575));
  trigger_wait("trig_2nd_stables_fxanim");
  level notify("fxanim_barn_explode_02_start");
  playsoundatposition("evt_stable_collapse_b", (-4207, 2816, 1575));
}

stables_pdf_logic() {
  self endon("death");
  self setthreatbiasgroup(self.script_string);
  wait 0.5;
  self.goalradius = 16;
  self.b_not_part_of_rage = 1;
  level waittill("rage_on");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "stables_pdf_center")
    self waittill("goal");

  self.b_not_part_of_rage = 0;

  while(!(isDefined(self.b_picked_rage_fake_rush) && self.b_picked_rage_fake_rush) && !flag("rage_off") && !flag("stables_about_to_exit"))
    wait 0.05;

  clear_threatbias("menendez", self.script_string);

  while(!flag("rage_off"))
    wait 0.05;

  self.goalradius = 2048;
}

stables_rage_get_to_goal(str_pdf, str_node) {
  self endon("death");
  trigger_wait("trig_stables_pdf_enter");
  nd_target = getnode(str_node, "targetname");
  self setgoalnode(nd_target);
  clear_threatbias("menendez", self.script_string);
  self.ignoreall = 0;
}