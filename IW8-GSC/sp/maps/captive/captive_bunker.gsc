/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\captive\captive_bunker.gsc
***********************************************/

bunker_flags() {
  scripts\engine\utility::flag_init("reached_gas_factory_start");
  scripts\engine\utility::flag_init("reached_gas_factory_mid");
  scripts\engine\utility::flag_init("reached_gas_factory_end");
  scripts\engine\utility::flag_init("looking_at_bunker_window");
  scripts\engine\utility::flag_init("reached_gas_lab_view");
  scripts\engine\utility::flag_init("has_entered_control_room");
  scripts\engine\utility::flag_init("looking_at_breach_door");
  scripts\engine\utility::flag_init("near_breach_door");
  scripts\engine\utility::flag_init("price_in_view_room");
  scripts\engine\utility::flag_init("started_breach");
  scripts\engine\utility::flag_init("bomb_detonated");
  scripts\engine\utility::flag_init("women_reached_windows");
  scripts\engine\utility::flag_init("gas_death_started");
  scripts\engine\utility::flag_init("end_hadir_window_scene");
  scripts\engine\utility::flag_init("reached_gas_lab_access");
  scripts\engine\utility::flag_init("started_pull_sequence");
  scripts\engine\utility::flag_init("rescue_failed");
  scripts\engine\utility::flag_init("spawn_breach_props");
}

bunker_start() {
  scripts\engine\utility::flag_set("saved_azadeh");
  scripts\engine\sp\utility::set_start_location("player_spawn_bunker", [level.player]);
  scripts\sp\player\teenagefarah::teenage_farah_combat_setup();
  scripts\sp\maps\captive\captive_util.gsc::spawn_prisoners();
  scripts\sp\maps\captive\captive_util.gsc::spawn_sas();
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("find_hadir_post");
  scripts\engine\sp\utility::set_start_location("bunker_price_start", [level.price]);
  scripts\engine\sp\utility::set_start_location("bunker_sas1_start", [level.sas1]);
  scripts\engine\sp\utility::set_start_location("bunker_sas2_start", [level.sas2]);
  scripts\engine\sp\utility::set_start_location("bunker_ayah_start", [level.ayah]);
  scripts\engine\sp\utility::set_start_location("bunker_nadia_start", [level.nadia]);
  scripts\engine\sp\utility::set_start_location("bunker_darine_start", [level.darine]);
  scripts\engine\sp\utility::set_start_location("bunker_ghalia_start", [level.ghalia]);

  if(isDefined(level.azadeh))
    scripts\engine\sp\utility::set_start_location("bunker_azadeh_start", [level.azadeh]);
}

bunker_main() {
  level.blackfade = scripts\sp\hud_util::create_client_overlay("black", 0);
  level.windowsceneref = scripts\engine\utility::getStruct("window_scene_ref", "targetname");
  level.controlroomenterref = scripts\engine\utility::getStruct("control_room_enter_ref", "targetname");
  level.controlroomenterref.arrivalcount = 0;
  level thread background_window_scene();
  level thread front_window_scene();
  level thread hadir_window_scene();
  var_0 = scripts\engine\utility::getStruct("lab_fire", "targetname");
  playFX(level._effect["vfx_lab_fire"], var_0.origin);
  scripts\engine\utility::exploder("vfx_glass_cracking");
  level thread allies_move_through_bunker();
  var_1 = [];
  var_1[var_1.size] = [level.ayah, "dx_vom_ayah_meet_sas_reveal_181"];
  var_1[var_1.size] = [level.darine, "dx_vom_drn_meet_sas_reveal_182"];
  level scripts\sp\maps\captive\captive_util.gsc::nagtill_delayed(8, "reached_gas_factory_start", var_1, 12, 1.35);
  thread scripts\sp\maps\captive\captive_vo.gsc::mus_factory_rescue();
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_bu_two_enemies();
  wait 1;
  var_2 = scripts\engine\sp\utility::array_spawn_targetname("gas_factory_mid_guards", 1);
  scripts\engine\utility::flag_wait("reached_gas_factory_end");
  level thread wait_update_hadir_objective();
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("find_hadir_objective_2", "targetname").origin);
  level.bunkerdoorleft = scripts\sp\maps\captive\captive_util.gsc::setup_scripted_door("gaslab_door_left");
  level.bunkerdoorleft.animname = "ldoor";
  level.bunkerdoorleft scripts\engine\sp\utility::assign_animtree("ldoor");
  level.bunkerdoorright = scripts\sp\maps\captive\captive_util.gsc::setup_scripted_door("gaslab_door_right");
  level.bunkerdoorright.animname = "rdoor";
  level.bunkerdoorright scripts\engine\sp\utility::assign_animtree("rdoor");
  level.controlroomenterref thread scripts\common\anim::anim_first_frame([level.bunkerdoorleft, level.bunkerdoorright], "door_breach_kill");
  level thread wait_spawn_clacker_and_bomb();

  while(level.controlroomenterref.arrivalcount < 3)
    waitframe();

  scripts\engine\utility::flag_wait("reached_gas_lab_view");
  level thread scripts\engine\sp\utility::autosave_by_name("bunker_control_room");
  scripts\engine\utility::flag_wait("done_breach_callout");

  if(scripts\engine\utility::flag("near_breach_door")) {
    level thread scripts\sp\maps\captive\captive_vo.gsc::vo_bu_step_back();
    scripts\engine\utility::flag_waitopen_or_timeout("near_breach_door", 10);
  }

  level.controlroomenterref notify("end_breach_idle");
  level thread smoke_death_timer();
  level thread rumble_on_breach();
  scripts\engine\utility::exploder("door_breach_2");
  level.controlroomenterref notify("end_sas_breach_idle");
  level thread breach_door_scene();
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_rescue_hadir_2", "targetname").origin);
  var_3 = getEnt("gas_lab_door", "targetname");
  var_4 = var_3 scripts\engine\utility::get_linked_ent();
  var_4 linkTo(var_3);
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_bu_post_breach();
  scripts\engine\utility::exploder("gas_start_hadir");
  scripts\engine\utility::flag_wait("reached_gas_lab_access");
  level.player clearsoundsubmix("sp_npc_steps_down", 10.0);

  if(!scripts\engine\utility::flag("rescue_failed")) {
    level.gaslabanimref = scripts\engine\utility::getStruct("gas_lab_ref", "targetname");
    level thread hadir_move_to_door();
    level thread lab_victims_move_to_door();
    level.gaslabdoorinteract = scripts\engine\utility::getStruct("interact_gas_lab_door", "targetname");
    level.gaslabdoorinteract thread scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"CAPTIVE/CURSOR_OPEN_LAB", 180, 220, 64, 1);
    level.gaslabdoorinteract waittill("trigger");
    scripts\sp\maps\captive\captive_lighting.gsc::lights_off("find_hadir_pre");
    scripts\sp\maps\captive\captive_lighting.gsc::lights_on("find_hadir_post");
    scripts\engine\utility::flag_set("done_bu_breach_vo");

    if(!scripts\engine\utility::flag("rescue_failed"))
      rescue_hadir_sequence();
  }

  level waittill("godot");
}

bunker_catchup() {}

allies_move_through_bunker() {
  level.price enableavoidance(0, 0);
  level.sas1 enableavoidance(0, 0);
  level.sas2 enableavoidance(0, 0);
  scripts\engine\sp\utility::activate_trigger_with_targetname("gas_corridor_move_1");
  level.price thread scripts\sp\maps\captive\captive_util.gsc::go_to_targetname("price_1");
  level.sas1 thread scripts\sp\maps\captive\captive_util.gsc::go_to_targetname("sas1_1");
  level.sas2 thread scripts\sp\maps\captive\captive_util.gsc::go_to_targetname("sas2_1");
  scripts\engine\utility::flag_wait("reached_gas_factory_start");
  scripts\engine\sp\utility::activate_trigger_with_targetname("gas_corridor_move_2");
  level.price scripts\engine\utility::delaythread(0.4, scripts\sp\maps\captive\captive_util.gsc::go_to_targetname, "price_2");
  level.sas1 thread scripts\sp\maps\captive\captive_util.gsc::go_to_targetname("sas1_2");
  level.sas2 scripts\engine\utility::delaythread(0.3, scripts\sp\maps\captive\captive_util.gsc::go_to_targetname, "sas2_2");
  scripts\engine\sp\utility::waittill_ai_group_dead("gas_factory_mid_guards");
  level.price scripts\engine\utility::set_movement_speed(110);
  level.sas1 scripts\engine\utility::set_movement_speed(130);
  level.sas2 scripts\engine\utility::set_movement_speed(120);
  level.price scripts\common\ai::set_gunpose("disable", 1);
  level.price scripts\engine\utility::delaythread(2, scripts\sp\maps\captive\captive_util.gsc::move_to_arrive_then_idle_with_path, "price_3_1", level.controlroomenterref, "door_breach_arrive", "door_breach_idle", "end_sas_breach_idle", "price_in_view_room", "started_breach");
  level.sas1 thread scripts\sp\maps\captive\captive_util.gsc::move_to_arrive_then_idle(level.controlroomenterref, "door_breach_arrive", "door_breach_idle", "end_sas_breach_idle", "spawn_breach_props");
  level.sas2 scripts\engine\utility::delaythread(1, scripts\sp\maps\captive\captive_util.gsc::move_to_arrive_then_idle_with_path, "sas2_3_1", level.controlroomenterref, "door_breach_arrive", "door_breach_idle", "end_sas_breach_idle");
  scripts\engine\utility::flag_wait("reached_gas_factory_mid");
  scripts\engine\sp\utility::activate_trigger_with_targetname("gas_corridor_move_3");
  scripts\engine\utility::flag_wait("reached_gas_factory_end");
  scripts\engine\sp\utility::activate_trigger_with_targetname("gas_corridor_move_4");
  scripts\engine\utility::flag_wait("reached_gas_lab_view");
  scripts\engine\sp\utility::activate_trigger_with_targetname("gas_corridor_move_5");
  scripts\engine\utility::flag_wait("bomb_detonated");
  var_0 = [level.ayah, level.darine];

  if(level.allprisoners.size > 2) {
    var_1 = [];
    level.allprisoners = scripts\engine\utility::array_removedead_or_dying(level.allprisoners);

    foreach(var_3 in level.allprisoners) {
      if(var_3 != level.ayah && var_3 != level.darine)
        var_1[var_1.size] = var_3;
    }

    if(var_1.size > 0)
      var_0[var_0.size] = scripts\engine\utility::getclosest(scripts\engine\utility::getStruct("stack_target_2", "targetname").origin, var_1);
  }

  foreach(var_6, var_3 in var_0)
  var_3 thread move_to_window(var_6);
}

move_to_window(var_0) {
  if(var_0 == 1)
    level waittill("woman_ended_0");
  else if(var_0 == 2) {
    level waittill("woman_ended_1");
    scripts\engine\sp\utility::activate_trigger_with_targetname("gas_corridor_move_6");
  }

  level.windowsceneref scripts\sp\anim::anim_reach_solo(self, "lab_arrive");
  scripts\engine\utility::flag_set("women_reached_windows");
  level notify("woman_ended_" + var_0);
  level.windowsceneref thread scripts\common\anim::anim_single_solo(self, "lab_arrive");
}

rumble_on_breach() {
  wait 1.1;
  playrumbleonposition("grenade_rumble", scripts\engine\utility::getStruct("looking_at_breach_door_target", "targetname").origin);
}

setup_gas_lab_door() {
  if(!isDefined(level.gaslabdoor)) {
    level.gaslabdoor = getEnt("gas_lab_door", "targetname");
    level.gaslabdoor.animname = "gas_lab_door";
    level.gaslabdoor useanimtree(level.scr_animtree["gas_lab_door"]);
    level.gaslabdoor.collision = level.gaslabdoor scripts\engine\utility::get_linked_ent();
    level.gaslabdoor.collision linkTo(level.gaslabdoor);
  }
}

background_window_scene() {
  level.labvictim4 = scripts\engine\sp\utility::spawn_anim_model("lab_victim4", level.windowsceneref.origin, level.windowsceneref.angles);
  level.labvictim4 attach("head_sc_m_bansal");
  level.labvictim4 scripts\sp\utility::enable_procedural_bones();
  level.labvictim5 = scripts\engine\sp\utility::spawn_anim_model("lab_victim5", level.windowsceneref.origin, level.windowsceneref.angles);
  level.labvictim5 attach("head_sc_m_ahmadzai");
  level.labvictim5 scripts\sp\utility::enable_procedural_bones();
  level.labvictim6 = scripts\engine\sp\utility::spawn_anim_model("lab_victim6", level.windowsceneref.origin, level.windowsceneref.angles);
  level.labvictim6 attach("head_sc_m_jimenez");
  level.labvictim6 scripts\sp\utility::enable_procedural_bones();
  level.labvictim7 = scripts\engine\sp\utility::spawn_anim_model("lab_victim7", level.windowsceneref.origin, level.windowsceneref.angles);
  level.labvictim7 attach("head_sc_m_karlin");
  level.labvictim7 scripts\sp\utility::enable_procedural_bones();
  level.labprisonersbackground = [level.labvictim4, level.labvictim5, level.labvictim6, level.labvictim7];

  foreach(var_1 in level.labprisonersbackground)
  var_1.anim_getrootfunc = ::get_anim_model_root;

  level.windowsceneref thread scripts\common\anim::anim_loop(level.labprisonersbackground, "lab_window_idle", "end_window_scene");
}

front_window_scene() {
  level.labvictim1 = scripts\engine\sp\utility::spawn_anim_model("lab_victim1", level.windowsceneref.origin, level.windowsceneref.angles);
  level.labvictim1 attach("head_sc_m_kargorgis_civ");
  level.labvictim1 scripts\sp\utility::enable_procedural_bones();
  level.labvictim2 = scripts\engine\sp\utility::spawn_anim_model("lab_victim2", level.windowsceneref.origin, level.windowsceneref.angles);
  level.labvictim2 attach("head_sc_m_bansal");
  level.labvictim2 scripts\sp\utility::enable_procedural_bones();
  level.labvictim3 = scripts\engine\sp\utility::spawn_anim_model("lab_victim3", level.windowsceneref.origin, level.windowsceneref.angles);
  level.labvictim3 attach("head_sc_m_jimenez");
  level.labvictim3 scripts\sp\utility::enable_procedural_bones();
  level.labprisoners = [level.labvictim1, level.labvictim2, level.labvictim3];

  foreach(var_1 in level.labprisoners)
  var_1.anim_getrootfunc = ::get_anim_model_root;

  level.windowsceneref thread scripts\common\anim::anim_first_frame(level.labprisoners, "lab_window_enter");
  scripts\engine\utility::flag_wait("looking_at_bunker_window");
  wait 0.5;

  foreach(var_4 in level.labprisoners)
  var_4 thread prisoner_loop_window_scene_till_dead();
}

#using_animtree("generic_human");

get_anim_model_root() {
  return % body;
}

prisoner_loop_window_scene_till_dead() {
  level endon("end_hadir_window_scene");
  level.windowsceneref scripts\common\anim::anim_single_solo(self, "lab_window_enter");

  while(!scripts\engine\utility::flag("rescue_failed"))
    level.windowsceneref scripts\common\anim::anim_single_solo(self, "lab_window_idle");

  level.windowsceneref scripts\common\anim::anim_single_solo(self, "lab_window_dead");
  level.windowsceneref scripts\common\anim::anim_last_frame_solo(self, "lab_window_dead");
}

hadir_window_scene() {
  level endon("end_hadir_window_scene");
  level.hadir = scripts\engine\sp\utility::spawn_targetname("hadir_lab", 1);
  level.hadir.ignoreme = 1;
  level.hadir.ignoreall = 1;
  level.windowsceneref thread scripts\common\anim::anim_first_frame_solo(level.hadir, "lab_window_enter");
  scripts\engine\utility::flag_wait("looking_at_bunker_window");
  level.hadir thread scripts\sp\maps\captive\captive_util.gsc::wait_clear_friendname(10);
  level.windowsceneref scripts\common\anim::anim_single_solo(level.hadir, "lab_window_enter");

  while(!scripts\engine\utility::flag("rescue_failed"))
    level.windowsceneref scripts\common\anim::anim_single_solo(level.hadir, "lab_window_idle");

  level.windowsceneref scripts\common\anim::anim_single_solo(level.hadir, "lab_window_dead");
  level.windowsceneref scripts\common\anim::anim_last_frame_solo(level.hadir, "lab_window_dead");
}

wait_update_hadir_objective() {
  scripts\engine\utility::flag_wait("reached_gas_lab_view");
  scripts\engine\sp\objectives::objective_update("objective", "current", scripts\engine\utility::getStruct("obj_rescue_hadir_1", "targetname").origin, &"CAPTIVE/OBJ_RESCUE_DESC", &"CAPTIVE/OBJ_RESCUE");
}

wait_spawn_clacker_and_bomb() {
  scripts\engine\utility::flag_wait("spawn_breach_props");
  level.clacker = scripts\engine\sp\utility::spawn_anim_model("clacker", (0, 0, 0), (0, 0, 0));
  level.clacker hide();
  level.bomb = scripts\engine\sp\utility::spawn_anim_model("c4_bomb", (0, 0, 0), (0, 0, 0));
  level.bomb hide();
  level thread wait_show_bomb();
  level.controlroomenterref scripts\common\anim::anim_single([level.clacker, level.bomb], "door_breach_arrive");
  level.controlroomenterref thread scripts\common\anim::anim_loop([level.clacker, level.bomb], "door_breach_idle", "end_sas_breach_idle");
}

wait_show_bomb() {
  level waittill("show_bomb");
  level.bomb show();
}

clacker_play_and_remove() {
  level.controlroomenterref scripts\common\anim::anim_single_solo(level.clacker, "door_breach_kill");
  level.clacker delete();
}

bomb_play_and_remove() {
  scripts\engine\utility::flag_set("bomb_detonated");
  scripts\engine\utility::delaythread(1.2, ::sfx_bunker_breach);
  level.controlroomenterref scripts\common\anim::anim_single_solo(level.bomb, "door_breach_kill");
  level.bomb delete();
}

sfx_bunker_breach() {
  var_0 = spawn("script_origin", level.bomb.origin);
  var_0 playexplosionsound("scn_captive_breach_charge_expl", "exp");
  wait 6;
  var_0 delete();
}

check_nag_open_door() {
  level endon("started_pry_attempt");
  wait 5;
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_bu_try_open_gas_door_nag();
}

breach_door_scene() {
  level.backgroundguards = scripts\engine\sp\utility::array_spawn_targetname("gas_lab_guards");
  level thread clacker_play_and_remove();
  level thread bomb_play_and_remove();
  level thread price_breach_door();
  level.controlroomenterref thread scripts\common\anim::anim_single([level.bunkerdoorleft, level.bunkerdoorright], "door_breach_kill");
  level.backgroundguards thread scripts\sp\maps\captive\captive_util.gsc::play_group_single_anim_into_kill(level.controlroomenterref, "door_breach_kill");
  [level.sas1, level.sas2] scripts\sp\maps\captive\captive_util.gsc::play_group_single_anim_into_idle_anim(level.controlroomenterref, "door_breach_kill", "door_breach_kill_idle", "end_door_breach_kill_idle");
}

price_breach_door() {
  level endon("started_pull_sequence");
  level.controlroomenterref scripts\common\anim::anim_single_solo(level.price, "door_breach_kill");
  level.controlroomenterref thread scripts\common\anim::anim_loop_solo(level.price, "door_breach_kill_idle", "end_price_valve_idle");
}

hadir_move_to_door() {
  level endon("gas_lab_open");
  scripts\engine\utility::flag_set("end_hadir_window_scene");
  level.gaslabanimref thread scripts\common\anim::anim_first_frame_solo(level.hadir, "lab_door_approach");
  level.gaslabanimref scripts\common\anim::anim_single_solo(level.hadir, "lab_door_approach");

  for(level.loopcount = 0; level.loopcount <= 1; level.loopcount++)
    level.gaslabanimref scripts\common\anim::anim_single_solo(level.hadir, "lab_door_idle");

  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_bu_smoke_fail();
  level.gaslabanimref thread scripts\common\anim::anim_single_solo(level.hadir, "lab_door_death");
  smoke_death_fail(0);
}

lab_victims_move_to_door() {
  level endon("gas_lab_open");
  level endon("rescue_failed");
  var_0 = 0;

  for(;;) {
    level.gaslabanimref scripts\common\anim::anim_single(level.labprisoners, "lab_door_idle");
    var_0++;
  }
}

smoke_death_timer() {
  level endon("started_pull_sequence");
  scripts\engine\utility::flag_wait("women_reached_windows");
  wait 22;
  scripts\engine\utility::flag_set("rescue_failed");
  wait 3;
  smoke_death_fail();
}

smoke_death_fail(var_0) {
  scripts\engine\utility::flag_set("rescue_failed");

  if(isDefined(level.gaslabdoorinteract))
    level.gaslabdoorinteract scripts\sp\player\cursor_hint::remove_cursor_hint();

  if(isDefined(level.pullinteract))
    level.pullinteract scripts\sp\player\cursor_hint::remove_cursor_hint();

  if(isalive(level.hadir))
    level.hadir stopsounds();

  thread scripts\sp\player_death::set_custom_death_quote(46);
  scripts\sp\utility::missionfailedwrapper();
}

rescue_hadir_sequence() {
  level endon("rescue_failed");
  scripts\engine\utility::flag_set("started_pull_sequence");
  level.loopcount = 0;
  level.player lerpfovscalefactor(0, 1);
  scripts\sp\maps\captive\captive_lighting.gsc::find_hadir_dof();
  visionsetnaked("captive_hero", 2);
  level.windowsceneref notify("end_window_scene");

  foreach(var_1 in level.labprisonersbackground)
  var_1 delete();

  level.gaslabanimref scripts\sp\player_rig::link_player_to_rig("rescue_start", "stand", 1, 0.2, undefined, undefined, undefined, undefined, undefined, 1);
  level.price attach("misc_vm_halligan_tool", "tag_accessory_right");
  level.pullinteract = scripts\engine\utility::spawn_script_origin();
  level.pullinteract linkTo(level.price, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  level.player springcamenabled(1, 5, 5);
  level.controlroomenterref notify("end_price_valve_idle");
  var_3 = [level.player_rig, level.price];
  level.gaslabanimref scripts\common\anim::anim_single(var_3, "rescue_start");
  level.gaslabanimref thread scripts\common\anim::anim_loop(var_3, "rescue_start_idle", "end_rescue_start_main_idle");
  scripts\sp\maps\captive\captive_vo.gsc::vo_bu_try_open_gas_lab(1);
  level.pullinteract thread scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"CAPTIVE/CURSOR_PULL", 128, 96, 64, 1, undefined, undefined, undefined, "duration_none");
  level.pullinteract waittill("trigger");
  level notify("started_pry_attempt");
  level.gaslabanimref notify("end_rescue_start_main_idle");
  level.gaslabanimref scripts\common\anim::anim_single(var_3, "rescue_pull");
  level.gaslabanimref thread scripts\common\anim::anim_loop(var_3, "rescue_pull_idle", "end_rescue_pull_main_idle");
  scripts\sp\maps\captive\captive_vo.gsc::vo_bu_try_open_gas_lab(2);
  level thread check_nag_open_door();
  level.pullinteract thread scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"CAPTIVE/CURSOR_PULL", 128, 96, 64, 1, undefined, undefined, undefined, "duration_none");
  level.pullinteract waittill("trigger");
  level.player lerpviewangleclamp(1, 0.25, 0.5, 0, 0, 0, 0);
  level thread wait_open_view();
  level notify("started_pry_attempt");
  level notify("gas_lab_open");
  level.hadir stopsounds();
  level.gaslabanimref notify("end_rescue_pull_main_idle");
  thread scripts\sp\maps\captive\captive_vo.gsc::mus_save_hadir();
  scripts\engine\utility::exploder("chamber_door_breach");
  scripts\engine\utility::stop_exploder("gas_start_hadir");
  level.pullinteract delete();
  setup_gas_lab_door();
  var_4 = [level.hadir, level.labvictim1, level.labvictim2, level.labvictim3];
  level thread wait_end_transition();
  level thread wait_lock_view_to_hadir();
  level.gaslabanimref notify("end_rescue_start_idle");
  level.gaslabanimref thread scripts\common\anim::anim_single_solo(level.gaslabdoor, "rescue_pull_final");
  level.gaslabanimref thread scripts\common\anim::anim_single(var_4, "rescue_pull_final");
  level.gaslabanimref scripts\common\anim::anim_single(var_3, "rescue_pull_final");
  thread scripts\sp\analytics::analytics_kleenex_update("Meet sas to bunker end");
  wait 3;
  scripts\engine\sp\utility::nextmission();
}

wait_open_view() {
  wait 2;
  level.player lerpviewangleclamp(1, 0.25, 0.5, 20, 20, 20, 20);
}

wait_end_transition() {
  level waittill("show_cinematic_bars");
  hidecinematicletterboxing(2, 0);
  level waittill("fade_out");
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_music_and_dx", 5.0);
  level.blackfade fadeovertime(1);
  level.blackfade.alpha = 1;
  wait 2;
  level.player scripts\sp\anim::play_sound_at_viewheight("dx_vom_far_bunker_rescue_140");
}

wait_lock_view_to_hadir() {
  level waittill("lock_view_to_hadir");
  level.player lerpviewangleclamp(2, 0.25, 0.5, 0, 0, 0, 0);
}