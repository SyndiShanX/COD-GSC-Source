/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\lab\lab_offices.gsc
***********************************************/

offices_start() {
  scripts\engine\utility::flag_set_delayed("screens_offices", 0.15);
  scripts\sp\maps\lab\lab_lighting.gsc::ambush_lighting_change();
  scripts\sp\maps\lab\lab_util.gsc::spawn_team_farah(1);
  level.rebel_1 scripts\engine\sp\utility::teleport_ent(getnode("offices_hold_rebel_1", "targetname"));
  level.rebel_1 scripts\sp\maps\lab\lab_util.gsc::magic_bullet_safe();
  level.rebel_2 scripts\engine\sp\utility::teleport_ent(getnode("offices_hold_rebel_2", "targetname"));
  level.rebel_2 scripts\sp\maps\lab\lab_util.gsc::magic_bullet_safe();
  level.heroes = scripts\engine\utility::array_remove(level.heroes, level.rebel_3);
  level.rebel_3 delete();
  var_0 = getEnt("jugg_dead_door", "script_noteworthy");
  var_0.struct = var_0 scripts\engine\sp\utility::get_linked_struct();
  scripts\sp\maps\lab\lab_util.gsc::assign_door_ents(var_0);
  var_0 rotateTo(var_0.struct.angles, 0.05);
  var_0.collision scripts\engine\utility::delaycall(0.1, ::connectpaths);
  scripts\engine\sp\utility::set_start_location("offices_start", [level.player, level.farah]);
  scripts\engine\utility::delaythread(1, scripts\sp\maps\lab\lab_util.gsc::player_gas_mask, 1);
  var_1 = getEntArray("turbine_sprocket", "targetname");
  scripts\engine\utility::array_thread(var_1, ::turbine_spin);
  scripts\engine\utility::flag_set("door_guy_dead");
}

offices_preload() {
  setdvarifuninitialized("scr_jugg_debug", 0);
  setdvarifuninitialized("scr_offices_ai", 0);
  precachestring(&"LAB/KYLE_INTRO_NAME");
  precachemodel("viewhands_kyle_sas_urban");
  scripts\engine\utility::flag_init("offices_finished");
  var_0["farah_gesture1"] = ::farah_gesture1;
  var_0["farah_gesture2"] = ::farah_gesture2;
  var_0["ai_gunpose_reset"] = ::ai_gunpose_reset;
  var_0["ai_gunpose_ads"] = ::ai_gunpose_ads;
  var_0["ahead_of_player"] = ::ahead_of_player;
  var_0["check_player_pos"] = ::check_player_pos;
  var_0["poi_start_struct"] = ::scripted_poi_start;
  var_0["rebel_2_catchup"] = ::rebel_2_catchup;
  var_0["plant_bomb"] = ::rebel_plant_bomb;
  add_scripted_movement_arrivefuncs("offices", var_0);
  var_1 = getEntArray("office_bomb", "script_noteworthy");
  scripts\engine\utility::array_call(var_1, ::hide);
}

offices_postload() {
  scripts\engine\utility::flag_init("alex_in_gas_room");
  scripts\engine\utility::flag_init("transition_bink_done");
  scripts\engine\utility::flag_init("office_check_1");
  scripts\engine\utility::flag_init("office_check_2");
  scripts\engine\utility::flag_init("office_check_3");
  scripts\engine\utility::flag_init("stop_offices_movement");
}

offices_main() {
  scripts\engine\sp\utility::remove_global_spawn_function("axis", scripts\sp\maps\lab\lab_util.gsc::laser_discipline);
  scripts\engine\sp\utility::remove_global_spawn_function("allies", scripts\sp\maps\lab\lab_util.gsc::laser_discipline);

  while(!isDefined(level.farah))
    waitframe();

  foreach(var_1 in level.heroes) {
    if(isDefined(var_1) && isalive(var_1))
      var_1 scripts\engine\sp\utility::clear_force_color();
  }

  scripts\sp\maps\lab\lab_lighting.gsc::detonator_hero_lighting_setup();
  scripts\sp\player::player_movement_state("cqb");
  level.farah thread offices_movement_farah();
  level.rebel_1 thread offices_movement_rebel_1();
  level.rebel_2 thread offices_movement_rebel_2();
  thread set_office_speeds();
  wait 1;

  if(!scripts\engine\utility::flag("door_guy_dead")) {
    scripts\engine\utility::flag_wait("door_guy_dead");
    wait 1;
  }

  thread setup_detonator_for_ges();
  thread offices_dialog();
  scripts\engine\utility::trigger_off("chem_hallway_color_trigs", "script_noteworthy");
  scripts\engine\utility::flag_wait("reached_final_room");
  thread offices_goal_dialog();

  if(scripts\engine\utility::flag("open_lab_door"))
    scripts\engine\utility::flag_clear("open_lab_door");
}

set_office_speeds() {}

offices_movement_farah() {
  level endon("stop_offices_movement");

  if(scripts\engine\utility::flag("stop_offices_movement")) {
    return;
  }
  var_0 = scripts\engine\utility::getStruct("office_route_farah", "targetname");
  scripts\engine\utility::delaythread(0.1, ::farah_drs_setup, var_0);
  scripted_movement(var_0);
  self.disablearrivals = undefined;
  var_0 = getnode("office_route2_farah_node", "targetname");
  check_drs(var_0, "office_check_1");
  var_0 = scripts\engine\utility::getStruct("office_route2_farah", "targetname");
  scripted_movement(var_0);
  self.disablearrivals = undefined;
  self notify("stop_office_check");
  var_0 = getnode("office_route3_farah_node", "targetname");
  check_drs(var_0, "office_check_2");
  var_0 = scripts\engine\utility::getStruct("office_route3_farah", "targetname");
  scripted_movement(var_0);
  self.disablearrivals = undefined;
  self notify("stop_office_check");
}

farah_drs_setup(var_0) {
  level.farah waittill_near_struct(var_0);
  level.farah scripts\engine\sp\utility::enable_dynamic_run_speed(level.player, 60, 140, 240, 100, -200, -400);
}

waittill_near_struct(var_0) {
  level endon("stop_offices_movement");
  var_1 = squared(40);

  for(;;) {
    var_2 = distancesquared(self.origin, var_0.origin);

    if(var_2 <= var_1) {
      break;
    }

    waitframe();
  }
}

check_drs(var_0, var_1) {
  self endon("stop_office_check");

  if(!scripts\engine\utility::flag(var_1)) {
    self.og_goalradius = self.goalradius;
    self.goalradius = 4;
    self setgoalnode(var_0);
    scripts\engine\sp\utility::disable_dynamic_run_speed(90);
    scripts\engine\utility::flag_wait(var_1);
    self.goalradius = self.og_goalradius;
    scripts\engine\sp\utility::enable_dynamic_run_speed(level.player, 60, 140, 240, 100, -200, -400);
  }
}

offices_movement_rebel_1() {
  level endon("stop_offices_movement");

  if(scripts\engine\utility::flag("stop_offices_movement")) {
    return;
  }
  var_0 = scripts\engine\utility::getStruct("office_route_rebel1", "targetname");
  scripts\engine\utility::delaythread(0.1, ::rebel_1_drs_setup, var_0);
  scripted_movement(var_0);
  self.disablearrivals = undefined;
  var_0 = getnode("office_route2_rebel1_node", "targetname");
  check_drs(var_0, "office_check_1");
  var_0 = scripts\engine\utility::getStruct("office_route2_rebel1", "targetname");
  scripted_movement(var_0);
  self.disablearrivals = undefined;
  self notify("stop_office_check");
  var_0 = getnode("office_route3_rebel1_node", "targetname");
  check_drs(var_0, "office_check_2");
  var_0 = scripts\engine\utility::getStruct("office_route3_rebel1", "targetname");
  scripted_movement(var_0);
  self.disablearrivals = undefined;
  self notify("stop_office_check");
  scripted_plant_bomb("rebel_1_plant1", "office_check_3");
  scripted_plant_bomb("rebel_1_plant2");
  var_0 = scripts\engine\utility::getStruct("office_route4_rebel1", "targetname");
  scripted_movement(var_0);
  self.disablearrivals = undefined;
}

rebel_1_drs_setup(var_0) {
  level.rebel_1 waittill_near_struct(var_0);
  level.rebel_1 scripts\engine\sp\utility::enable_dynamic_run_speed(level.farah, 60, 150, 250, 165, 110, 50);
}

offices_movement_rebel_2() {
  level endon("stop_offices_movement");

  if(scripts\engine\utility::flag("stop_offices_movement")) {
    return;
  }
  var_0 = scripts\engine\utility::getStruct("office_route_rebel2", "targetname");
  scripts\engine\utility::delaythread(0.1, ::rebel_2_drs_setup, var_0);
  scripted_movement(var_0);
  self.disablearrivals = undefined;
  scripts\engine\sp\utility::disable_dynamic_run_speed();
  scripted_plant_bomb("rebel_2_plant1", "office_check_1");
  var_0 = scripts\engine\utility::getStruct("office_route2_rebel2", "targetname");
  check_drs(var_0, "office_check_1");
  scripted_movement(var_0);
  self.disablearrivals = undefined;
  self notify("stop_office_check");
  scripted_plant_bomb("rebel_2_plant2");
  var_0 = scripts\engine\utility::getStruct("office_route3_rebel2", "targetname");
  scripted_movement(var_0);
  self.disablearrivals = undefined;
  scripted_plant_bomb("rebel_2_plant3", "office_check_3");
  var_0 = scripts\engine\utility::getStruct("office_route4_rebel2", "targetname");
  scripted_movement(var_0);
  self.disablearrivals = undefined;
}

rebel_2_drs_setup(var_0) {
  level.rebel_2 waittill_near_struct(var_0);
  level.rebel_2 scripts\engine\sp\utility::enable_dynamic_run_speed(level.farah, 60, 150, 250, 265, 210, 150);
}

scripted_plant_bomb(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_2 scripts\sp\anim::anim_reach_and_approach_solo(self, "cp_4_plant", undefined, "Exposed");
  var_2 thread scripts\common\anim::anim_single_solo(self, "cp_4_plant");
  self.bombnode = var_2;
  self attach("offhand_wm_c4_bomb", "tag_accessory_right");

  if(isDefined(var_1) && !scripts\engine\utility::flag(var_1)) {
    var_3 = scripts\engine\utility::getanim("cp_4_plant");
    var_4 = getanimlength(var_3);
    wait(var_4 / 2);
    self setanimrate(var_3, 0);
    scripts\engine\utility::flag_wait(var_1);
    self setanimrate(var_3, 1);
  } else
    self waittillmatch("single anim", "end");
}

setup_detonator_for_ges() {
  level.player allowsprint(0);
  setsaveddvar("RMLOTKMMM", 0);
  var_0 = spawn("script_model", level.player.origin);
  var_0 hide();
  var_0 setModel("offhand_vm_clacker_tatical_sp_cinematic_destroyed");
  var_0 notsolid();
  var_0 linktoplayerview(level.player, "tag_accessory_left", (0, 0, 0), (0, 0, 0), 1, "view_jostle");
  var_1 = spawn("script_model", level.player.origin);
  var_1 hide();
  var_1 setModel("offhand_vm_clacker_tatical_sp_cinematic_destroyed_off");
  var_1 notsolid();
  var_1 linktoplayerview(level.player, "tag_accessory_left", (0, 0, 0), (0, 0, 0), 1, "view_jostle");
  var_0 thread scripts\sp\maps\lab\lab_lighting.gsc::detonator_hero_lighting_on();
  var_0 scripts\engine\utility::delaythread(0.3, scripts\sp\maps\lab\lab_turbines.gsc::det_sparks_vfx);
  var_0 scripts\engine\utility::delaycall(0.3, ::show);
  level.player scripts\engine\utility::delaycall(0.05, ::playsound, "scn_lab_juggernaut_detonator_malfunction_gesture");
  level.player scripts\engine\sp\utility::player_gesture_force("lab_vm_detonator_ges");
  var_0 thread fake_detonator_lights_off(var_0, var_1);
  wait(level.player getgestureanimlength("lab_vm_detonator_ges"));
  level notify("delete_detonator_light");
  level.player allowsprint(1);
  var_0 unlinkfromplayerview(level.player);
  var_0 delete();
  var_1 delete();
  setsaveddvar("RMLOTKMMM", 1);
}

fake_detonator_lights_off(var_0, var_1) {
  level endon("delete_detonator_light");
  var_2 = [0.3, 0.2, 0.2, 0.4, 0.2, 0.5, 0.3, 0.2, 0.4, 0.2, 0.3, 0.3, 0.3, 0.2, 0.2, 0.4];

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    wait(var_2[var_3]);
    var_1 show();
    var_0 hide();
    var_3++;
    wait(var_2[var_3]);
    var_0 show();
    var_1 hide();
  }
}

offices_dialog() {
  wait 1.8;
  level.player scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_alx_juggernaut_outro_50", 1, 0.5);
  level.farah scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_far_juggernaut_outro_52");
  level scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_juggernaut_outro_60");
  level.player scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_alx_juggernaut_outro_70");
  level scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_juggernaut_outro_80");
  level scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_alx_juggernaut_outro_90");
  level scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_juggernaut_outro_100");

  if(scripts\engine\utility::flag("reached_final_room")) {
    return;
  }
  level endon("reached_final_room");
  level.player scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_alx_juggernaut_outro_110");
  wait 0.3;
  level.player scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_alx_juggernaut_outro_120");
  wait 5;
  level.farah waittill("goal");
  wait 8;
  var_0 = ["dx_vom_far_juggernaut_outro_41", "dx_vom_far_juggernaut_outro_42", "dx_vom_far_juggernaut_outro_43"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  level.farah scripts\sp\maps\lab\lab_vo_util.gsc::nagtill("office_check_1", var_1, 12);
  wait 5;
  level.farah waittill("goal");
  wait 8;
  level.farah scripts\sp\maps\lab\lab_vo_util.gsc::nagtill("office_check_2", var_1, 12);
  wait 5;
  level.farah waittill("goal");
  wait 8;
  var_0 = ["dx_vom_far_offices_outro_20", "dx_vom_far_offices_outro_30", "dx_vom_far_offices_outro_40"];
  level.farah scripts\sp\maps\lab\lab_vo_util.gsc::nagtill("reached_final_room", var_0, 12);
}

offices_goal_dialog() {
  level endon("switch_to_kyle");
  wait 2;
  level.farah thread scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_far_offices_outro_10");
  var_0 = scripts\engine\utility::getStruct("lab_entrance_interact", "targetname");
  var_1 = squared(400);

  while(distance2dsquared(var_0.origin, level.farah.origin) > var_1)
    waitframe();

  level.farah scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_far_offices_outro_50");
  level.player scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_alx_offices_outro_60");
}

offices_door_dialog(var_0) {
  level endon("switch_to_kyle");

  while(!level.farah nearnode(var_0))
    wait 0.2;

  wait 8;
  var_1 = ["dx_vom_far_offices_outro_70", "dx_vom_far_offices_outro_80", "dx_vom_far_offices_outro_90"];
  level.farah thread scripts\sp\maps\lab\lab_vo_util.gsc::nagtill("stop_offices_movement", var_1);
}

turbine_spin() {
  level endon("switch_to_kyle");
  var_0 = 0.1 + randomfloatrange(0.5, 1.5);

  for(;;) {
    self rotatepitch(360, var_0);
    wait(var_0);
  }
}

offices_catchup() {
  scripts\engine\utility::flag_set("price_containment_wait");

  if(scripts\engine\utility::flag("open_lab_door"))
    scripts\engine\utility::flag_clear("open_lab_door");
}

gas_chambers_start() {
  scripts\sp\maps\lab\lab_util.gsc::spawn_team_farah();
  scripts\engine\sp\utility::set_start_location("gas_chambers_start", [level.player, level.farah, level.rebel_1, level.rebel_2, level.rebel_3]);
  scripts\engine\utility::delaythread(1, scripts\sp\maps\lab\lab_util.gsc::player_gas_mask, 1);
  var_0 = getEntArray("turbine_sprocket", "targetname");
  scripts\engine\utility::array_thread(var_0, ::turbine_spin);
  scripts\engine\utility::delaythread(0.1, scripts\engine\sp\utility::transient_load, "lab_turbine2_tr");
}

gas_chambers_main() {
  scripts\engine\utility::trigger_on("chem_hallway_color_trigs", "script_noteworthy");
  thread scripts\engine\sp\utility::transient_load("lab_pipes_tr");
  lab_entrance_door();
}

lab_entrance_door() {
  var_0 = scripts\engine\utility::getStruct("lab_entrance_interact", "targetname");
  var_0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (5, 0, -3), &"LAB/CURSOR_PUSH", undefined, undefined, undefined, 1);
  var_1 = getEnt("gas_button", "targetname");
  var_1 scripts\engine\sp\utility::assign_animtree("gas_button");
  var_0 waittill("trigger");
  level.gas_mask_overlay fadeovertime(1.5);
  level.gas_mask_overlay.alpha = 0;
  level.gas_mask_overlay.sort = -2;
  thread scripts\sp\maps\lab\lab_util.gsc::cine_letterboxing_up(1.5);
  var_0 scripts\engine\utility::delaythread(0.0, scripts\sp\maps\lab\lab_turbines.gsc::play_button_sound, "lab_vm_button_push_plr");
  thread scripts\engine\utility::play_sound_in_space("scn_lab_furnace_door_open", (-119, 572, 36));
  level.player scripts\engine\utility::delaycall(3.0, ::setclienttriggeraudiozone, "fade_to_black", 2.0);
  scripts\sp\utility::delete_live_grenades();
  scripts\engine\utility::flag_set("stop_offices_movement");
  level.player.movespeedscale = 0;
  level.player setmovespeedscale(0);
  level.player thread remove_mask();
  level.farah thread reset_gasmask();
  var_2 = spawn("script_model", level.farah getEye());
  var_2 setModel("prop_gasmask");
  var_2 dontinterpolate();
  var_2 scripts\engine\sp\utility::assign_animtree("gas_button_mask");
  var_0 scripts\sp\player_rig::link_player_to_rig("chem_room_pad", undefined, 1, 0.3, 1, 0, 0, 0, 0);
  var_0 thread scripts\common\anim::anim_single_solo(var_1, "chem_room_pad");
  var_0 thread scripts\common\anim::anim_single_solo(level.farah, "chem_room_pad");
  var_0 thread scripts\common\anim::anim_single_solo(var_2, "chem_room_pad");
  var_0 scripts\common\anim::anim_single_solo(level.player_rig, "chem_room_pad");
  var_2 delete();
  level.player_rig show();
  scripts\sp\player_rig::unlink_player_from_rig();
  thread scripts\engine\sp\utility::transient_unload_array(["lab_turbine1_tr", "lab_turbine2_tr", "lab_office_tr"]);
  turbine_cleanup();
  scripts\sp\player::player_movement_state();
  scripts\engine\sp\utility::blend_movespeedscale(1, 1);
  pov_switch_bink();
}

remove_mask() {
  wait 3.67;

  if(isDefined(level.gas_mask_overlay))
    level.gas_mask_overlay destroy();
}

reset_gasmask() {
  wait 0.3;

  if(isDefined(self.hatmodel))
    self detach(self.hatmodel);

  if(isDefined(self.gas_mask) && !self.gas_mask)
    scripts\sp\maps\lab\lab_util.gsc::gasmask_on_belt("TAG_STOWED_BACK2", 0);
}

turbine_cleanup() {
  delete_allies();
  scripts\engine\utility::flag_set("switch_to_kyle");
  var_0 = getEntArray("turbine_sprocket", "targetname");
  scripts\engine\utility::array_delete(var_0);
  var_1 = getEntArray("turbines_triggers", "script_noteworthy");
  scripts\engine\utility::delaythread(0.5, scripts\engine\utility::array_delete, var_1);
}

delete_allies() {
  scripts\engine\sp\utility::remove_global_spawn_function("allies", scripts\sp\maps\lab\lab_util.gsc::allies_molotov_toggle);
  level.farah scripts\sp\maps\lab\lab_util.gsc::disable_magic_bullet_delete();
  level.rebel_1.spawner notify("stop_rebel_flood");
  level.rebel_1 scripts\sp\maps\lab\lab_util.gsc::disable_magic_bullet_delete();
  level.rebel_2.spawner notify("stop_rebel_flood");
  level.rebel_2 scripts\sp\maps\lab\lab_util.gsc::disable_magic_bullet_delete();

  if(isDefined(level.rebel_3) && isalive(level.rebel_3)) {
    level.rebel_3.spawner notify("stop_rebel_flood");
    level.rebel_3 scripts\sp\maps\lab\lab_util.gsc::disable_magic_bullet_delete();
  }

  if(isDefined(level.jugg_allies) && level.jugg_allies.size > 0) {
    level.jugg_allies = scripts\engine\utility::array_removedead(level.jugg_allies);
    level.jugg_allies = scripts\engine\utility::array_removeundefined(level.jugg_allies);

    if(level.jugg_allies.size > 0)
      scripts\engine\utility::array_delete(level.jugg_allies);
  }
}

pov_switch_bink() {
  level notify("office_bink");
  hidecinematicletterboxing(0, 0);
  scripts\engine\utility::delaythread(0.2, scripts\sp\maps\lab\lab_pipes.gsc::setup_post_cinematic);
  level.player scripts\sp\utility::play_skippable_cinematic("sp_lab_cine_sacrifice", "post_bink_setup_finished");
  scripts\engine\utility::flag_set("transition_bink_done");
}

gas_chambers_catchup() {
  scripts\engine\utility::flag_set("lab_finished");
  scripts\engine\utility::flag_set("transition_bink_done");
  var_0 = getEntArray("turbines_triggers", "script_noteworthy");
  scripts\engine\utility::array_delete(var_0);
}

scripted_movement(var_0, var_1) {
  self endon("stop_scripted_movement");

  if(isDefined(var_1) && var_1)
    self forceteleport(var_0.origin, var_0.angles);

  self.post_wait_func = ::scripted_movement_post_wait;
  scripts\sp\spawner::go_to_node(var_0, ::scripted_movement_arrival);
}

scripted_movement_post_wait() {
  if(isDefined(self.scripted_movement_idle))
    self.scripted_animnode notify("stop_" + self.scripted_anime + "_idle_" + self.animname);
}

scripted_movement_arrival(var_0) {
  if(isDefined(self.scripted_movement_idle))
    self.scripted_animnode notify("stop_" + self.scripted_anime + "_idle_" + self.animname);

  if(isDefined(var_0.script_ent_flag_set))
    scripts\engine\utility::ent_flag_set(var_0.script_ent_flag_set);

  if(isDefined(var_0.script_flag_set))
    scripts\engine\utility::flag_set(var_0.script_flag_set);

  if(isDefined(var_0.animation))
    script_movement_anim(var_0);

  if(!isDefined(var_0.script_function)) {
    return;
  }
  var_1 = get_scripted_movement_arrivefuncs();

  if(!isDefined(var_1[var_0.script_function])) {
    return;
  }
  self[[var_1[var_0.script_function]]](var_0);
}

script_movement_anim(var_0) {
  var_1 = var_0.animation;
  var_0.origin = scripts\engine\utility::drop_to_ground(var_0.origin, 10, -100);
  var_2 = var_0;
  var_3 = 0;

  if(isDefined(var_0.script_parameters)) {
    if(var_0.script_parameters == "no_anim_reach")
      var_3 = 1;
  }

  if(isDefined(var_0.script_animnode))
    var_2 = scripts\engine\utility::getStruct(var_0.script_animnode, "targetname");

  var_4 = 0;

  if(isDefined(level.scr_anim["generic"][var_1]))
    var_4 = 1;

  if(!var_3) {
    if(var_4)
      var_2 scripts\sp\anim::anim_generic_reach(self, var_1);
    else
      var_2 scripts\sp\anim::anim_reach_solo(self, var_1);
  }

  var_5 = undefined;

  if(var_4) {
    if(isDefined(level.scr_anim["generic"][var_1 + "_idle"]))
      var_5 = 1;
  } else if(isDefined(level.scr_anim[self.animname][var_1 + "_idle"]))
    var_5 = 1;

  self.scripted_movement_idle = undefined;
  self.scripted_anime = undefined;
  self.scripted_animnode = undefined;

  if(isDefined(var_5)) {
    self.scripted_movement_idle = 1;
    self.scripted_anime = var_1;
    self.scripted_animnode = var_2;
  }

  if(var_4) {
    if(isDefined(var_5))
      var_2 thread anim_then_loop_solo(self, var_1, var_1 + "_idle", "stop_" + var_1 + "_idle_" + self.animname, 1);
    else
      var_2 thread scripts\common\anim::anim_generic(self, var_1);
  } else if(isDefined(var_5))
    var_2 thread anim_then_loop_solo(self, var_1, var_1 + "_idle", "stop_" + var_1 + "_idle_" + self.animname);
  else
    var_2 thread scripts\common\anim::anim_single_solo(self, var_1);

  if(isDefined(var_0.script_type)) {
    if(var_0.script_type == "anim_wait")
      self waittillmatch("single anim", "end");
  }
}

anim_then_loop_solo(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("stop_anim_then_loop");

  if(!isDefined(var_2)) {
    var_2 = var_1 + "_idle";

    if(!isDefined(level.scr_anim[var_0.animname][var_2]))
      var_2 = var_1 + "_loop";
  }

  var_5 = spawnStruct();
  var_5.loopendernotified = 0;

  if(isDefined(var_3))
    var_5 thread anim_then_loopender_thread(self, var_3);

  if(istrue(var_4))
    scripts\common\anim::anim_generic(var_0, var_1);
  else
    scripts\common\anim::anim_single_solo(var_0, var_1);

  waittillframeend;

  if(var_5.loopendernotified) {
    return;
  }
  var_5 notify("stop_thread");

  if(isai(var_0) && !isalive(var_0)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(istrue(var_4))
    thread scripts\common\anim::anim_generic_loop(var_0, var_2, var_3);
  else
    thread scripts\common\anim::anim_loop_solo(var_0, var_2, var_3);
}

anim_then_loopender_thread(var_0, var_1) {
  self endon("stop_thread");
  var_0 waittill(var_1);
  self.loopendernotified = 1;
}

add_scripted_movement_arrivefuncs(var_0, var_1) {
  if(!isDefined(level.scripted_movement_arrivefuncs))
    level.scripted_movement_arrivefuncs = [];

  level.scripted_movement_arrivefuncs[var_0] = var_1;
}

get_scripted_movement_arrivefuncs() {
  var_0 = [];

  if(isDefined(level.scripted_movement_arrivefuncs)) {
    foreach(var_2 in level.scripted_movement_arrivefuncs) {
      foreach(var_5, var_4 in var_2)
      var_0[var_5] = var_4;
    }
  }

  return var_0;
}

farah_gesture1(var_0) {
  thread farah_gesture_timing(var_0, "offices_farah_gesture1");
}

farah_gesture2(var_0) {
  thread farah_gesture_timing(var_0, "offices_farah_gesture2");
}

farah_gesture_timing(var_0, var_1) {
  scripts\engine\utility::set_movement_speed(125);
  wait 0.1;
  var_2 = scripts\engine\utility::getStruct(var_1, "targetname");
  scripts\asm\gesture::ai_request_gesture("casual_point", var_2, 3000);
  wait 3;
  scripts\common\utility::clear_movement_speed();
}

ahead_of_player(var_0) {
  scripts\engine\sp\utility::enable_dynamic_run_speed(level.player, 125, 205, 250);
}

scripted_poi_start(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0.targetname + "_poi", "targetname");
  scripts\common\ai::poi_enable(1, var_1);
  var_2 = get_poi_total_time(var_1);
  wait(var_2);
  scripts\common\ai::poi_enable(0);
}

get_poi_total_time(var_0) {
  var_1 = 0;
  var_1 = var_0 has_script_time_min(var_1);

  if(isDefined(var_0.target)) {
    var_0 = scripts\engine\utility::getStruct(var_0.target, "targetname");
    var_1 = var_0 has_script_time_min(var_1);
  }

  return var_1;
}

has_script_time_min(var_0) {
  if(isDefined(self.script_time_min))
    var_0 = var_0 + self.script_time_min;
  else
    var_0 = var_0 + 1.2;

  return var_0;
}

ai_gunpose_ads(var_0) {
  scripts\common\ai::set_gunpose("ads");
}

ai_gunpose_reset(var_0) {
  scripts\common\ai::reset_gunpose();
}

rebel_2_catchup(var_0) {
  scripts\engine\sp\utility::enable_dynamic_run_speed(level.farah, 60, 150, 250, 165, 110, 50);
}

rebel_plant_bomb(var_0) {
  var_1 = getEnt(var_0.targetname + "_bomb", "targetname");
  var_1 show();
  wait 0.5;
  playFXOnTag(scripts\engine\utility::getfx("vfx_c4_light"), var_1, "tag_fx");
}

rebel_plant_bomb_wait(var_0, var_1) {
  var_2 = getEnt(var_0.targetname + "_bomb", "targetname");
  var_2 show();
  scripts\engine\utility::flag_wait(var_1);
  wait 0.5;
  playFXOnTag(scripts\engine\utility::getfx("vfx_c4_light"), var_2, "tag_fx");
}

check_player_pos(var_0) {
  thread check_player_pos_flag(var_0);
}

check_player_pos_flag(var_0) {
  self endon("death");
  scripts\common\ai::reset_gunpose();
  level.farah notify("stop_going_to_node");
  var_0 = getnode("office_end_farah_idle", "targetname");
  self setgoalnode(var_0);
  scripts\engine\utility::flag_wait("reached_final_room");
  var_0 = getnode("offices_endnode_farah", "targetname");
  self setgoalnode(var_0);
  wait 0.5;
  scripts\common\ai::enable_arrivals();
  scripts\common\ai::enable_exits();
  scripts\engine\sp\utility::disable_dynamic_run_speed();
  thread offices_door_dialog(var_0);
}