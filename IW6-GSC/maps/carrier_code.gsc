/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\carrier_code.gsc
*****************************************************/

carrier_init() {
  precacheshader("white");
  precacheshader("overlay_rain");
  precacheshader("overlay_rain_large");
  precacheshader("overlay_rain_large_02");
  precacheshader("overlay_rain_small");
  precacheshader("overlay_rain_small_02");
  precacheshader("ac130_hud_friendly_ai_diamond_s_w");
  precacheshader("ac130_hud_enemy_ai_target_s_w");
  precacheshader("ac130_hud_enemy_vehicle_target_s_w");
  precacheturret("phalanx_turret");
  thread carrier_post_load();
  thread gameskill_settings();
  level.water_level = 720;
  level.cached_arcs = [];
}

carrier_post_load() {
  level waittill("load_finished");
}

setup_common(var_0) {
  thread setup_front_elevator();
  thread balcony_kill_trigger();
  thread water_kill_trigger();
  thread deck_tilt_water_kill_trigger();
  thread update_sun();
  thread update_deck_post_intro();
  thread setup_ocean_vista_tilt();
  thread vista_oil_slicks();
  thread run_destructibles();
  thread setup_island_flag();
  setup_player();

  if(!isDefined(var_0) || !var_0) {
    thread phalanx_gun_fire("crr_phalanx_01");
    thread phalanx_gun_fire("crr_phalanx_02");
    thread phalanx_gun_fire("crr_phalanx_03");
    thread phalanx_gun_fire("crr_phalanx_04");
    thread phalanx_gun_fire("crr_phalanx_05");
  }

  anim.fire_notetrack_functions["drone"] = maps\carrier_code_zodiac::drone_shoot;
}

setup_player() {
  var_0 = level.start_point + "_start";
  var_1 = common_scripts\utility::getstruct(var_0, "targetname");

  if(isDefined(var_1)) {
    level.player setorigin(var_1.origin);

    if(isDefined(var_1.angles))
      level.player setplayerangles(var_1.angles);
    else
      iprintlnbold("Your script_struct " + level.start_point + "_start has no angles! Set some.");
  } else {}
}

spawn_allies() {
  level.allies = [];
  level.allies[level.allies.size] = spawn_ally("hesh");
  level.allies[level.allies.size - 1].animname = "hesh";
  level.hesh = level.allies[level.allies.size - 1];
  level.hesh maps\_utility::make_hero();
}

spawn_ally(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(var_1))
    var_2 = level.start_point + "_" + var_0;
  else
    var_2 = var_1 + "_" + var_0;

  var_3 = spawn_targetname_at_struct_targetname(var_0, var_2);

  if(!isDefined(var_3))
    return undefined;

  var_3 maps\_utility::make_hero();

  if(!isDefined(var_3.magic_bullet_shield))
    var_3 maps\_utility::magic_bullet_shield();

  return var_3;
}

gameskill_settings() {
  level.difficultysettings["gunboat_aiSpread"]["easy"] = 4;
  level.difficultysettings["gunboat_aiSpread"]["normal"] = 3;
  level.difficultysettings["gunboat_aiSpread"]["hardened"] = 0.75;
  level.difficultysettings["gunboat_aiSpread"]["veteran"] = 0.2;
  level.difficultysettings["gunboat_convergenceTime"]["easy"] = 6;
  level.difficultysettings["gunboat_convergenceTime"]["normal"] = 3;
  level.difficultysettings["gunboat_convergenceTime"]["hardened"] = 1;
  level.difficultysettings["gunboat_convergenceTime"]["veteran"] = 0.33;
  level.difficultysettings["zodiac_rider_playerHitRatio"]["easy"] = 0.3;
  level.difficultysettings["zodiac_rider_playerHitRatio"]["normal"] = 0.4;
  level.difficultysettings["zodiac_rider_playerHitRatio"]["hardened"] = 0.45;
  level.difficultysettings["zodiac_rider_playerHitRatio"]["veteran"] = 0.75;
  level.difficultysettings["rappeler_playerHitRatio"]["easy"] = 3;
  level.difficultysettings["rappeler_playerHitRatio"]["normal"] = 5;
  level.difficultysettings["rappeler_playerHitRatio"]["hardened"] = 6;
  level.difficultysettings["rappeler_playerHitRatio"]["veteran"] = 12;
  level.difficultysettings["osprey_hitsToSucceed"]["easy"] = 0;
  level.difficultysettings["osprey_hitsToSucceed"]["normal"] = 1;
  level.difficultysettings["osprey_hitsToSucceed"]["hardened"] = 10;
  level.difficultysettings["osprey_hitsToSucceed"]["veteran"] = 20;
}

nag_until_flag(var_0, var_1, var_2, var_3, var_4) {
  if(common_scripts\utility::flag(var_1)) {
    return;
  }
  for(var_5 = -1; !common_scripts\utility::flag(var_1); var_3 = var_3 + var_4) {
    var_6 = randomfloatrange(var_2, var_3);
    wait(var_6);
    var_7 = randomint(var_0.size);

    if(var_7 == var_5) {
      var_7++;

      if(var_7 >= var_0.size)
        var_7 = 0;
    }

    var_8 = var_0[var_7];

    if(common_scripts\utility::flag(var_1)) {
      break;
    }

    thread maps\_utility::smart_radio_dialogue(var_8);
    var_5 = var_7;
    var_2 = var_2 + var_4;
  }
}

#using_animtree("generic_human");

carrier_life_jet_takeoff_guys(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = common_scripts\utility::getstruct("redshirt_forklift_stopper_ref", "targetname");
  var_7 = maps\_utility::spawn_targetname(var_0);
  var_7.animname = var_1;
  var_7.runanim = maps\_utility::getgenericanim("unarmed_run");
  var_7 maps\_utility::magic_bullet_shield(1);
  var_7 maps\_utility::gun_remove();
  var_8 = getanimlength(level.scr_anim[var_1][var_3]);
  var_9 = var_5 / var_8;
  var_6 thread maps\_anim::anim_single_solo(var_7, var_3);
  common_scripts\utility::waitframe();
  var_7 setanimtime(level.scr_anim[var_1][var_3], var_9);
  var_7 waittillmatch("single anim", "end");
  var_7.target = var_2;

  if(isDefined(var_4))
    var_7 maps\_utility::set_moveplaybackrate(var_4);
  else
    var_7 maps\_utility::set_moveplaybackrate(1);

  var_7.idleanim = % unarmed_cowercrouch_idle;
  var_7 thread maps\_drone::drone_move();
  var_7 thread safe_delete_drone(1500);
}

carrier_life_jet_takeoff_jet(var_0, var_1, var_2, var_3, var_4) {
  var_5 = common_scripts\utility::getstruct("redshirt_forklift_stopper_ref", "targetname");
  var_6 = maps\_vehicle::spawn_vehicle_from_targetname(var_0);
  var_6.animname = var_1;

  if(isDefined(var_4)) {
    var_5 thread maps\_anim::anim_first_frame_solo(var_6, var_2);
    wait(var_4);
  }

  var_6 thread maps\carrier_fx::handle_jet_launch_fx();
  var_7 = getanimlength(level.scr_anim[var_1][var_2]);
  var_8 = var_3 / var_7;
  var_5 thread maps\_anim::anim_single_solo(var_6, var_2);
  common_scripts\utility::waitframe();
  var_6 setanimtime(level.scr_anim[var_1][var_2], var_8);
  var_6 waittillmatch("single anim", "end");
  thread maps\_vehicle::gopath(var_6);
  var_9 = [var_6];
  thread maps\_utility::ai_delete_when_out_of_sight(var_9, 20000);
}

setup_jet_and_clip(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = getEntArray(var_0, "targetname");

  foreach(var_10 in var_8) {
    if(var_10.script_noteworthy == "item")
      var_4 = var_10;

    if(var_10.script_noteworthy == "clip")
      var_5 = var_10;

    if(var_10.script_noteworthy == "clip_l")
      var_6 = var_10;

    if(var_10.script_noteworthy == "clip_r")
      var_7 = var_10;
  }

  var_12 = var_4 gettagorigin("le_wing_fold_jnt");
  var_13 = var_4 gettagorigin("ri_wing_fold_jnt");
  var_5.origin = var_4.origin;
  var_6.origin = var_12;
  var_7.origin = var_13;
  var_5 linkto(var_4, "tag_body");
  var_6 linkto(var_4, "le_wing_fold_jnt");
  var_7 linkto(var_4, "ri_wing_fold_jnt");

  if(isDefined(var_1)) {
    var_5 thread maps\carrier_deck_tilt::player_hit_detect(var_1, var_2, var_3);
    var_6 thread maps\carrier_deck_tilt::player_hit_detect(var_1, var_2, var_3);
    var_7 thread maps\carrier_deck_tilt::player_hit_detect(var_1, var_2, var_3);
  }

  return var_4;
}

setup_island_flag() {
  var_0 = getent("island_flag", "targetname");
  var_0.animname = "flag";
  var_0 maps\_anim::setanimtree();
  var_1 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_1 thread maps\_anim::anim_loop_solo(var_0, "carrier_flag_idle", "stop_flag");
  common_scripts\utility::flag_wait("start_main_odin_strike");
  var_1 notify("stop_flag");
  var_1 maps\_anim::anim_single_solo(var_0, "carrier_deck_tilt_flag");
  var_0 delete();
}

clear_deck_props() {
  wait 0.1;

  if(level.start_point != "slow_intro" && level.start_point != "medbay" && level.start_point != "deck_combat" && level.start_point != "defend_zodiac") {
    var_0 = getent("anim_jet_launcher1", "targetname");
    var_0 hide();
    var_1 = getent("anim_jet_launcher2", "targetname");
    var_1 hide();
  }

  if(level.start_point != "slow_intro" && level.start_point != "medbay" && level.start_point != "deck_combat" && level.start_point != "deck_transition") {
    var_2 = getent("taxing_osprey_clip", "targetname");
    var_2 delete();
  }
}

move_deck_props() {
  wait 0.1;

  if(level.start_point != "deck_victory" && level.start_point != "deck_tilt")
    common_scripts\utility::flag_wait("defend_sparrow_start");

  level notify("deleting_ammo_refill");
  level.deck_damage = getEntArray("deck_damaged", "targetname");
  common_scripts\utility::array_thread(level.deck_damage, maps\_utility::show_entity);

  foreach(var_1 in level.deck_damage)
  var_1 movez(-4096, 0.05);

  var_3 = getEntArray("tower_damage", "targetname");

  foreach(var_1 in var_3)
  var_1 movez(-4096, 0.05);

  var_6 = getEntArray("tower_panel_clean", "targetname");
  common_scripts\utility::array_thread(var_6, maps\_utility::show_entity);

  foreach(var_1 in var_6)
  var_1 movez(-4096, 0.05);

  var_9 = getEntArray("deck_tilt_clip", "targetname");

  foreach(var_1 in var_9)
  var_1 movez(-4096, 0.05);

  var_12 = getent("blast_shield1", "targetname");
  var_12 rotateto((0, 0, -65), 0.5);
  level.deck_clean = getEntArray("deck_clean", "targetname");
  level.blast_shield = getent("blast_shield2", "targetname");
  maps\_utility::array_delete(level.deck_clean);
  level.blast_shield delete();
  var_13 = getent("deck_tilt_tugger_1", "targetname");
  var_14 = getent("deck_tilt_tugger_1_clip", "targetname");
  var_15 = getent("deck_tilt_tugger_1_mantle", "targetname");
  var_13 movez(120, 0.05);
  var_14 movez(120, 0.05);
  var_15 movez(120, 0.05);
  var_16 = getEntArray("sliding_crate_01b", "targetname");

  foreach(var_1 in var_16)
  var_1 movey(192, 0.05);

  var_19 = getweaponarray();
  maps\_utility::array_delete(var_19);
  var_20 = getEntArray("stern_corner_dmg", "targetname");

  foreach(var_1 in var_20) {
    if(var_1.classname == "script_model" && var_1.model == "crr_blastholes_01")
      var_1 delete();
  }

  var_23 = getent("blast_shield4", "targetname");
  var_24 = getent("blast_shield5", "targetname");
  var_25 = getent("blast_shield6", "targetname");
  var_23 delete();
  var_24 delete();
  var_25 delete();
  var_26 = getent("depth_charge_cart", "targetname");
  var_27 = getent("depth_charge_cart_clip", "targetname");
  var_26 delete();
  var_27 delete();
  var_28 = getEntArray("front_elevator_jet", "targetname");
  maps\_utility::array_delete(var_28);
  level.exploding_heli maps\_utility::show_entity();
  var_29 = getEntArray("rear_forklift1", "targetname");

  foreach(var_1 in var_29)
  var_1 delete();

  var_32 = getEntArray("anim_tugger", "targetname");
  maps\_utility::array_delete(var_32);

  foreach(var_34 in level.rear_elevator.attachments) {
    if(isDefined(var_34))
      var_34 delete();
  }

  var_36 = getEntArray("carrier_elevator_front_scripted_attachments", "targetname");

  foreach(var_34 in var_36) {
    if(isDefined(var_34))
      var_34 delete();
  }

  var_39 = getEntArray("deck_weapons", "script_noteworthy");
  maps\_utility::array_delete(var_39);
  var_40 = getEntArray("deck_props_delete", "targetname");
  maps\_utility::array_delete(var_40);
  var_41 = getEntArray("odin_carts", "targetname");
  maps\_utility::array_delete(var_41);
  maps\_utility::array_delete(level.deck_ac130_dmg);

  if(isDefined(level.deck_ac130_dmg_badplace_size)) {
    for(var_42 = 0; var_42 < level.deck_ac130_dmg_badplace_size; var_42++)
      badplace_delete("deck_ac130_dmg_badplace" + var_42);
  }

  maps\_utility::array_delete(level.deck_ac130_dmg_clip);
  maps\_utility::array_delete(level.dz_deck_explode_dmg);
  var_43 = getscriptablearray("scriptable_destructible_barrel", "targetname");

  foreach(var_1 in var_43)
  var_1 setscriptablepartstate(0, 2, 1);

  thread maps\carrier_deck_tilt::tilt_props_large();
  thread maps\carrier_deck_tilt::tilt_props_medium();
  thread maps\carrier_deck_tilt::tilt_props_odin_jet();
  thread maps\carrier_deck_tilt::tilt_props_elevator();
  thread maps\carrier_deck_tilt::tilt_props_impact_barrels();
  thread maps\carrier_deck_tilt::tilt_props_impact_x30();
  thread maps\carrier_deck_tilt::tilt_props_tugger_vault();
  thread maps\carrier_deck_tilt::tilt_props_tugger3();
  thread maps\carrier_deck_tilt::tilt_props_tugger4();
  thread maps\carrier_deck_tilt::tilt_props_barrels_x3("gp3_group_a", "carrier_deck_tilt_barrels1_gp_a");
  thread maps\carrier_deck_tilt::tilt_props_barrels_x3("gp3_group_b", "carrier_deck_tilt_barrels1_gp_b");
  thread maps\carrier_deck_tilt::tilt_props_barrels_x30();
  var_46 = getEntArray("ally_movement_triggers_deckcombat", "script_noteworthy");
  maps\_utility::array_delete(var_46);
  var_47 = getEntArray("kill_triggers", "script_noteworthy");
  maps\_utility::array_delete(var_47);
  thread tilt_ocean_fx_setup();
}

tilt_ocean_fx_setup() {}

setup_front_elevator() {
  var_0 = getent("carrier_elevator_front_scripted", "targetname");
  level.front_elevator_vol = getent("elevator_touching_vol", "targetname");
  var_1 = getEntArray("carrier_elevator_front_scripted_attachments", "targetname");

  foreach(var_3 in var_1)
  var_3 linkto(var_0);

  var_5 = common_scripts\utility::getstruct("redshirt_forklift_stopper_ref", "targetname");
  var_6 = maps\_utility::spawn_anim_model("front_elevator");
  var_5 maps\_anim::anim_first_frame_solo(var_6, "tugger_scene_enter");
  var_7 = var_6 gettagorigin("j_prop_1");
  var_8 = var_6 gettagangles("j_prop_1");
  var_0.origin = var_7;
  var_0.angles = var_8;
  var_0 linkto(var_6, "j_prop_1");

  if(level.start_point == "slow_intro" || level.start_point == "medbay" || level.start_point == "deck_combat") {
    common_scripts\utility::flag_wait("combat_1_kick");
    var_9 = level.front_elevator_vol maps\_utility::get_ai_touching_volume();

    foreach(var_11 in var_9)
    var_11 linkto(var_0);

    common_scripts\utility::waitframe();
    var_5 maps\_anim::anim_single_solo(var_6, "tugger_scene_enter");
    common_scripts\utility::flag_set("front_elevator_raised");

    foreach(var_11 in var_9) {
      if(isDefined(var_11) && isalive(var_11))
        var_11 unlink();
    }
  } else
    var_5 maps\_anim::anim_last_frame_solo(var_6, "tugger_scene_enter");
}

setup_rear_elevator() {
  level.rear_elevator = getent("carrier_elevator_rear_scripted", "targetname");
  level.rear_elevator.lowered = 1;
  level.rear_elevator.height = 342;
  level.rear_elevator.time = 25;
  level.rear_elevator_vol = getent("rear_elevator_touching_vol", "targetname");
  level.rear_elevator.attachments = getEntArray("carrier_elevator_rear_scripted_attachments", "targetname");

  foreach(var_1 in level.rear_elevator.attachments)
  var_1 linkto(level.rear_elevator);

  if(level.start_point != "slow_intro" && level.start_point != "medbay" && level.start_point != "deck_combat") {
    level.rear_elevator.lowered = 0;

    foreach(var_1 in level.rear_elevator.attachments) {
      if(isDefined(var_1)) {
        var_1 unlink();

        if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == "clip")
          var_1 disconnectpaths();
      }
    }

    common_scripts\utility::flag_set("rear_elevator_raised");
  } else
    reset_rear_elevator();
}

raise_rear_elevator() {
  if(level.rear_elevator.lowered) {
    var_0 = level.rear_elevator_vol maps\_utility::get_ai_touching_volume();

    foreach(var_2 in var_0)
    var_2 linkto(level.rear_elevator);

    var_4 = level.rear_elevator.height;
    var_5 = level.rear_elevator.time;
    level.rear_elevator moveto(level.rear_elevator.origin + (0, 0, var_4), var_5, 2, 2);
    thread maps\carrier_audio::aud_carr_elevator_rear();
    wait(var_5);
    level.rear_elevator.lowered = 0;

    foreach(var_2 in var_0) {
      if(isDefined(var_2) && isalive(var_2))
        var_2 unlink();
    }

    foreach(var_9 in level.rear_elevator.attachments) {
      if(isDefined(var_9)) {
        var_9 unlink();

        if(isDefined(var_9.script_noteworthy) && var_9.script_noteworthy == "clip")
          var_9 disconnectpaths();
      }
    }

    common_scripts\utility::flag_set("rear_elevator_raised");
    thread maps\carrier_audio::aud_carr_osprey_engines();
  }
}

reset_rear_elevator() {
  level.rear_elevator.lowered = 1;
  level.rear_elevator moveto(level.rear_elevator.origin - (0, 0, level.rear_elevator.height), 0.05, 0, 0);
}

raise_rear_elevator_intro() {
  if(level.rear_elevator.lowered) {
    var_0 = level.rear_elevator.height;
    var_1 = 15;
    level.rear_elevator moveto(level.rear_elevator.origin + (0, 0, var_0), var_1, 2, 2);
  }
}

balcony_kill_trigger() {
  common_scripts\utility::flag_wait("lower_balcony_kill_trigger");
  thread maps\_hud_util::fade_out(1.5, "black");
  level.player kill();
}

water_kill_trigger() {
  common_scripts\utility::flag_wait("fall_water_kill_trigger");
  thread maps\_hud_util::fade_out(1.5, "black");
  level.player kill();
}

deck_tilt_water_kill_trigger() {
  var_0 = getent("water_kill_clip", "targetname");

  for(;;) {
    if(level.player istouching(var_0) || common_scripts\utility::flag("tilt_water_kill_trigger")) {
      thread maps\_hud_util::fade_out(1.5, "black");
      level.player kill();
      return;
    } else
      common_scripts\utility::waitframe();
  }
}

setup_ocean_vista_tilt() {
  level.ocean_water = getent("ocean_water", "targetname");
  level.vista_rig = maps\_utility::spawn_anim_model("tilt_vista");
  level.vista_rig.origin = level.ocean_water.origin;
  level.vista_rig.angles = (0, 0, 0);
  level.vista_rig maps\_anim::anim_first_frame_solo(level.vista_rig, "carrier_deck_tilt_world");
  level.ocean_water linkto(level.vista_rig, "j_prop_1");
  var_0 = getent("tilt_water_death_trigger", "targetname");
  var_1 = getent("water_kill_clip", "targetname");
  var_0 enablelinkto();
  var_0 linkto(level.vista_rig, "j_prop_1");
  var_1 linkto(level.vista_rig, "j_prop_1");
  var_2 = getEntArray("vista_terrain", "targetname");

  foreach(var_4 in var_2)
  var_4 linkto(level.ocean_water);

  var_6 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  level.exfil_animnode = var_6 common_scripts\utility::spawn_tag_origin();
  level.tilt_sky = getent("carrier_tilt_sky", "targetname");
  level.tilt_sky linkto(level.ocean_water);
  level.tilt_sky hide();
  level.tilt_ground_ref = getent("player_ref_ent", "targetname");
  level.tilt_ground_ref linkto(level.ocean_water);

  if(level.start_point != "deck_tilt" && level.start_point != "deck_victory")
    common_scripts\utility::flag_wait("sparrow_hud_black");

  level.tilt_sky show();
  common_scripts\utility::flag_wait("start_main_odin_strike");
  level.player playersetgroundreferenceent(level.tilt_ground_ref);
}

vista_tilt() {
  level.sun_angles_deck_tilt_end = (-30.5, -73, 0);
  var_0 = (-16.5, 2, 0);
  var_1 = 400;
  var_2 = 30;
  level.vista_rig thread maps\_anim::anim_single_solo(level.vista_rig, "carrier_deck_tilt_world");
  level.exfil_animnode rotateto(var_0, 0.05);
  lerpsunangles(level.sun_angles_deck_tilt, level.sun_angles_deck_tilt_end, var_2);
}

vista_boats() {
  level.boats = getEntArray("all_boats", "script_noteworthy");
  thread setup_fed_destroyer_osprey();

  foreach(var_1 in level.boats)
  var_1 thread vista_boat_animate();
}

setup_fed_destroyer_osprey() {
  level.fed_destroyer_clip linkto(level.fed_destroyer_osprey);
  common_scripts\utility::array_call(level.fed_destroyer_fx_guns, ::linkto, level.fed_destroyer_osprey);
  common_scripts\utility::array_call(level.destroyer_guy_nodes, ::linkto, level.fed_destroyer_osprey);
}

vista_boat_animate() {
  thread attach_deck_gun();
  var_0 = maps\_utility::spawn_anim_model("boat", self.origin);
  self.rig = var_0;
  var_1 = 704;

  if(self.model == "crr_destroyer_01_left" || self.model == "crr_destroyer_01_right" || self.model == "crr_destroyer_01")
    var_0.origin = (var_0.origin[0], var_0.origin[1], var_1);
  else if(self.model == "crr_destroyer_02_fed")
    var_0.origin = (var_0.origin[0], var_0.origin[1], var_1 - 1236);
  else
    var_0.origin = (var_0.origin[0], var_0.origin[1], -64);

  var_0.angles = self.angles;
  self linkto(var_0, "j_prop_1", (0, 0, 0), (0, 0, 0));
  common_scripts\utility::waitframe();
  var_0 thread maps\_anim::anim_loop_solo(var_0, "carrier_destroyer_idle", "stop_loop");
  common_scripts\utility::waitframe();
  var_0 setanimtime(level.scr_anim["boat"]["carrier_destroyer_idle"][0], randomfloat(0.75));
  common_scripts\utility::flag_wait("start_main_odin_strike");
  var_0 linkto(level.ocean_water);
}

attach_deck_gun() {
  if(isDefined(self.target)) {
    self.gun = getent(self.target, "targetname");
    self.gun linkto(self);

    if(isDefined(self.gun.target)) {
      self.gun.fx = getent(self.gun.target, "targetname");
      self.gun.fx linkto(self.gun);
      level.fed_destroyer_fx_guns = common_scripts\utility::array_add(level.fed_destroyer_fx_guns, self.gun.fx);
    }
  }
}

vista_oil_slicks() {
  var_0 = getEntArray("ocean_water_slick", "targetname");

  if(level.start_point == "slow_intro") {
    common_scripts\utility::array_thread(var_0, maps\_utility::hide_entity);
    common_scripts\utility::flag_wait("slow_intro_finished");
    common_scripts\utility::array_thread(var_0, maps\_utility::show_entity);
  }

  if(level.start_point == "slow_intro" || level.start_point == "medbay")
    common_scripts\utility::flag_wait("medbay_finished");

  common_scripts\utility::array_thread(var_0, ::vista_element_move);
}

vista_element_move() {
  level endon("odin_strike_starting");
  var_0 = 67488;
  var_1 = 240;
  var_2 = var_0 - self.origin[1];
  var_3 = var_2 / var_1;
  thread vista_element_link();

  if(level.start_point == "defend_zodiac") {
    self movey(var_2 * 0.2, 0.05, 0, 0);
    wait 0.05;
    var_2 = var_0 - self.origin[1];
  }

  if(level.start_point == "defend_sparrow" || level.start_point == "deck_victory") {
    self movey(var_2 * 0.4, 0.05, 0, 0);
    wait 0.05;
    var_2 = var_0 - self.origin[1];
  }

  if(level.start_point == "deck_tilt") {
    self movey(var_2 * 0.7, 0.05, 0, 0);
    wait 0.05;
    var_2 = var_0 - self.origin[1];
  }

  if(isDefined(self))
    self movey(var_2, var_3, 0, 0);

  wait(var_3);

  if(isDefined(self))
    self delete();
}

vista_element_link() {
  level waittill("odin_strike_starting");

  if(isDefined(self))
    self linkto(level.ocean_water);
}

ocean_death() {
  level endon("death");
  level endon("no_water_death");

  for(;;) {
    if(level.player istouching(self)) {
      level.player dodamage(level.player.health + 100, level.player.origin);
      continue;
    }

    wait 0.05;
  }
}

rod_of_god_carrier() {
  var_0 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_1 = maps\_utility::spawn_anim_model("tilt_rog");
  var_0 thread maps\_anim::anim_single_solo(var_1, "carrier_deck_tilt_RoG_prop");
  level.player playrumbleonentity("carrier_rod_of_god");
  var_2 = common_scripts\utility::getstruct("rog_target_carrier", "targetname");
  playFXOnTag(level._effect["vfx_rog_trail"], var_1, "tag_origin");
  var_1 waittillmatch("single anim", "tower_impact");
  common_scripts\utility::exploder(90000);
  var_1 waittillmatch("single anim", "corner_impact");
  common_scripts\utility::flag_set("tower_corner_hit");
  var_1 waittillmatch("single anim", "deck_impact");
  common_scripts\utility::flag_set("rog_impacts_deck");
  screenshake(level.player.origin, 3, 2, 2, 2.5, 0, 2.0, 256, 8, 15, 12, 5.0);
  var_1 waittillmatch("single anim", "water_impact");
  var_3 = getent("carrier_odin_water_impact", "targetname");
  var_3 linkto(level.ocean_water);
  var_1 waittillmatch("single anim", "end");
  var_1 delete();
}

rod_of_god_carrier_front() {
  var_0 = common_scripts\utility::getstruct("deck_tilt_animnode", "targetname");
  var_1 = maps\_utility::spawn_anim_model("tilt_rog");
  var_0 thread maps\_anim::anim_single_solo(var_1, "carrier_exfil_2nd_RoG_GP");
  level.player playrumbleonentity("carrier_rod_of_god");
  var_2 = common_scripts\utility::getstruct("rog_front_impact", "targetname");
  playFXOnTag(level._effect["vfx_rog_trail"], var_1, "tag_origin");
  var_1 waittillmatch("single anim", "impact_deck");
  common_scripts\utility::flag_set("carrier_front_impact");
  stopFXOnTag(level._effect["vfx_rog_trail"], var_1, "tag_origin");
  thread maps\carrier_audio::aud_carr_exfil_rog();
  common_scripts\utility::exploder(6002);
  screenshake(level.player.origin, 4, 3, 3, 2.5, 0, 2.0, 256, 8, 15, 12, 1.8);
  var_1 waittillmatch("single anim", "end");
  var_1 delete();
}

player_slide_manager() {
  level.x_slide_incr = 0;
  level.damage_slide_incr = 0;
  level.damage_slide_time = 0;

  for(;;) {
    if(!common_scripts\utility::flag("damage_slide")) {
      level.player pushplayervector((level.x_slide_incr, 0, 0));
      wait 0.05;
      continue;
    }

    level.player pushplayervector((level.damage_slide_incr + level.x_slide_incr, 0, 0));
    wait(level.damage_slide_time);
    level.player pushplayervector((level.x_slide_incr, 0, 0));
    level.damage_slide_incr = 0;
    level.damage_slide_time = 0;
    common_scripts\utility::flag_clear("damage_slide");
  }
}

player_gravity_slide() {
  level endon("player_in_heli");

  while(abs(level.tilt_ground_ref.angles[0]) > 352) {
    var_0 = level.player getnormalizedmovement();

    if(abs(var_0[0]) > 0.1)
      level.x_slide_incr = 2;
    else
      level.x_slide_incr = 0;

    wait 0.05;
  }

  level.x_slide_incr = 2;

  while(abs(level.tilt_ground_ref.angles[0]) >= 343.5) {
    level.x_slide_incr = level.x_slide_incr + 0.1;
    wait 0.1;
    iprintln("Tilt angle is " + level.tilt_ground_ref.angles);
  }
}

player_gravity_slide_punish() {
  level endon("end_player_slide");

  while(abs(level.tilt_ground_ref.angles[0]) <= 17) {
    level.x_slide_incr = level.x_slide_incr + 0.15;
    wait 0.1;
  }
}

player_slide_fall() {
  level endon("player_in_heli");
  level.player setstance("stand");
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player disableweapons();
  level.player freezecontrols(1);
  var_0 = getent("touching_ladder", "targetname");

  if(!level.player istouching(var_0) && level.player.origin[2] < 1410 && level.player.origin[2] > 1390) {
    var_1 = maps\_utility::spawn_anim_model("player_rig", (level.player.origin[0], level.player.origin[1], 1400));
    var_1.angles = (0, 90, 0);
    var_1 thread player_fade_out_trace();
    level.player playerlinktoblend(var_1, "tag_player", 0.3);
    var_1 maps\_anim::anim_single_solo(var_1, "carrier_player_slide");
  } else {
    level.player dodamage(level.player.health * 0.9, level.player.origin + (0, 0, 72));
    setdvar("ui_deadquote", &"CARRIER_FAIL_DECK_TILT");
    maps\_utility::missionfailedwrapper();
  }
}

player_fade_out_trace() {
  while(!common_scripts\utility::flag("slide_fade_out")) {
    var_0 = self.origin + (16, 0, 8);
    var_1 = self.origin + (100, 0, 8);
    var_2 = playerphysicstrace(var_0, var_1);

    if(var_2 != var_1)
      common_scripts\utility::flag_set("slide_fade_out");

    common_scripts\utility::waitframe();
  }
}

ai_cleanup_fake_death(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");

  foreach(var_3 in var_1) {
    if(isai(var_3) && isalive(var_3)) {
      if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == var_0)
        var_3 thread maps\ss_util::fake_death_bullet(1.5);

      continue;
    }

    if(!isspawner(var_3) && isalive(var_3) && isDefined(var_3.script_drone) && var_3.script_drone)
      var_3 dodamage(var_3.health, var_3.origin);
  }
}

array_spawn_targetname_allow_fail(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");
  var_3 = array_spawn_allow_fail(var_2);
  return var_3;
}

array_spawn_allow_fail(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_4.count = 1;
    var_5 = var_4 maps\_utility::spawn_ai(var_1);

    if(isDefined(var_5))
      var_2[var_2.size] = var_5;
  }

  return var_2;
}

retreat_from_vol_to_vol(var_0, var_1, var_2, var_3) {
  var_4 = getent(var_0, "targetname");
  var_5 = var_4 maps\_utility::get_ai_touching_volume("axis");
  var_6 = getent(var_1, "targetname");
  var_7 = getnode(var_6.target, "targetname");

  foreach(var_9 in var_5) {
    if(isDefined(var_9) && isalive(var_9)) {
      if(issubstr(var_9.model, "shotgun")) {
        return;
      }
      var_9.forcegoal = 0;
      var_9.fixednode = 0;
      var_9.pathrandompercent = randomintrange(75, 100);
      var_9 setgoalnode(var_7);
      var_9 setgoalvolumeauto(var_6);
    }
  }
}

ai_array_killcount_flag_set(var_0, var_1, var_2, var_3) {
  maps\_utility::waittill_dead_or_dying(var_0, var_1, var_3);
  common_scripts\utility::flag_set(var_2);
}

check_trigger_flagset(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 waittill("trigger");

  if(isDefined(var_1.script_flag_set))
    common_scripts\utility::flag_set(var_1.script_flag_set);
}

run_to_volume_and_delete(var_0) {
  self endon("death");

  if(isDefined(self)) {
    self setgoalvolumeauto(getent(var_0, "targetname"));
    self waittill("goal");
    waittill_player_not_looking();
    self delete();
  }
}

ignore_everything(var_0) {
  self endon("death");
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.grenadeawareness = 0;
  self.ignoreexplosionevents = 1;
  self.ignorerandombulletdamage = 1;
  self.ignoresuppression = 1;
  self.disablebulletwhizbyreaction = 1;
  maps\_utility::disable_pain();
  self.dontavoidplayer = 1;
  self.og_newenemyreactiondistsq = self.newenemyreactiondistsq;
  self.newenemyreactiondistsq = 0;

  if(isDefined(var_0) && var_0 != 0.0) {
    wait(var_0);
    clear_ignore_everything();
  }
}

clear_ignore_everything() {
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.grenadeawareness = 1;
  self.ignoreexplosionevents = 0;
  self.ignorerandombulletdamage = 0;
  self.ignoresuppression = 0;
  self.disablebulletwhizbyreaction = 0;
  maps\_utility::enable_pain();
  self.dontavoidplayer = 0;
  self.script_dontpeek = 0;

  if(isDefined(self.og_newenemyreactiondistsq))
    self.newenemyreactiondistsq = self.og_newenemyreactiondistsq;
}

anim_fake_loop_endon(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 endon("endon_flag");

  while(isDefined(var_0))
    maps\_anim::anim_single_solo(var_0, var_1);
}

stop_anim_fake_loop(var_0, var_1) {
  var_0 endon("death");
  common_scripts\utility::flag_wait(var_1);

  if(isDefined(var_0))
    var_0 stopanimscripted();
}

safe_kill() {
  self endon("death");
  self kill();
}

spawn_targetname_at_struct_targetname(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_3 = common_scripts\utility::getstruct(var_1, "targetname");

  if(isDefined(var_2) && isDefined(var_3)) {
    var_2.origin = var_3.origin;

    if(isDefined(var_3.angles))
      var_2.angles = var_3.angles;

    var_4 = var_2 maps\_utility::spawn_ai();
    return var_4;
  }

  if(isDefined(var_2)) {
    var_4 = var_2 maps\_utility::spawn_ai();
    iprintlnbold("Add a script struct called: " + var_1 + " to spawn him in the correct location.");
    var_4 teleport(level.player.origin, level.player.angles);
    return var_4;
  }

  iprintlnbold("failed to spawn " + var_0 + " at " + var_1);
  return undefined;
}

targetname_spawn(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::spawn_ai);
}

array_combine_unique(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(!isDefined(common_scripts\utility::array_find(var_2, var_4)))
      var_2[var_2.size] = var_4;
  }

  foreach(var_4 in var_1) {
    if(!isDefined(common_scripts\utility::array_find(var_2, var_4)))
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

set_black_fade(var_0, var_1) {
  level notify("set_black_fade", var_0, var_1);
  level endon("set_black_fade");

  if(!isDefined(var_0))
    var_0 = 1;

  var_0 = max(0.0, min(1.0, var_0));

  if(!isDefined(var_1))
    var_1 = 1;

  var_1 = max(0.01, var_1);

  if(!isDefined(level.hud_black)) {
    level.hud_black = newhudelem();
    level.hud_black.x = 0;
    level.hud_black.y = 0;
    level.hud_black.horzalign = "fullscreen";
    level.hud_black.vertalign = "fullscreen";
    level.hud_black.foreground = 1;
    level.hud_black.sort = -999;
    level.hud_black setshader("black", 650, 490);
    level.hud_black.alpha = 0.0;
  }

  level.hud_black fadeovertime(var_1);
  level.hud_black.alpha = max(0.0, min(1.0, var_0));

  if(var_0 <= 0) {
    wait(var_1);
    level.hud_black destroy();
    level.hud_black = undefined;
  }
}

lerp_player_to_position_accurate(var_0, var_1) {
  var_2 = spawn("script_model", level.player getorigin());
  var_2 setModel("tag_origin");
  level.player playerlinkto(var_2, "tag_origin");
  var_2 moveto(var_0, var_1);
  wait(var_1 + 0.05);
  var_2 delete();
}

move_arc_dist(var_0, var_1, var_2) {
  var_3 = self.origin + anglesToForward(self.angles) * var_0;
  move_arc(self.origin, var_3, var_1, var_2);
}

move_arc(var_0, var_1, var_2, var_3, var_4) {
  self endon("deleted");
  self endon("destroyed");

  if(!isDefined(var_4))
    var_4 = (0, 0, 0);

  var_5 = ceil(min(var_3 * 3, 20));
  var_6 = calculate_arc(var_0, var_1, var_2, var_5);
  self.angles = vectortoangles(var_6[1] - self.origin) + var_4;

  foreach(var_9, var_8 in var_6) {
    if(var_9 < 1) {
      continue;
    }
    self rotateto(vectortoangles(var_8 - self.origin) + var_4, var_3 / var_5);
    self moveto(var_8, var_3 / var_5);
    wait(var_3 / var_5);
  }
}

calculate_arc(var_0, var_1, var_2, var_3) {
  var_4 = arc_cached(var_0, var_1);

  if(isDefined(var_4))
    return var_4;

  var_5 = var_0[0];
  var_6 = var_0[1];
  var_7 = var_0[2];
  var_8 = var_1[0];
  var_9 = var_1[1];
  var_10 = var_1[2];
  var_11 = [var_0, var_1];
  var_12 = get_midpoint_arc(var_11, var_2);
  var_13 = var_12[0];
  var_14 = var_12[1];
  var_15 = var_12[2];
  var_16 = [];

  for(var_17 = 1; var_17 <= var_3; var_17++) {
    var_18 = var_17 / var_3;
    var_19 = int((1 - var_18) * (1 - var_18) * var_5 + 2 * (1 - var_18) * var_18 * var_13 + var_18 * var_18 * var_8);
    var_20 = int((1 - var_18) * (1 - var_18) * var_6 + 2 * (1 - var_18) * var_18 * var_14 + var_18 * var_18 * var_9);
    var_21 = int((1 - var_18) * (1 - var_18) * var_7 + 2 * (1 - var_18) * var_18 * var_15 + var_18 * var_18 * var_10);
    var_16[var_17] = (var_19, var_20, var_21);
  }

  cache_arc(var_0, var_1, var_16);
  return var_16;
}

get_midpoint_arc(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_2 = var_2 + var_0[var_5][0];
    var_3 = var_3 + var_0[var_5][1];
    var_4 = var_4 + var_0[var_5][2];
  }

  return (var_2 / var_0.size, var_3 / var_0.size, var_4 / var_0.size + var_1);
}

arc_cached(var_0, var_1) {
  foreach(var_3 in level.cached_arcs) {
    if(var_0 == var_3.startorigin && var_1 == var_3.endorigin)
      return var_3.array;
  }

  return undefined;
}

cache_arc(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.startorigin = var_0;
  var_3.endorigin = var_1;
  var_3.array = var_2;
  level.cached_arcs = common_scripts\utility::array_add(level.cached_arcs, var_3);
}

cinematic_on() {
  level.player disableweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowjump(0);
  level.player allowfire(0);
}

cinematic_off() {
  level.player enableweapons();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowjump(1);
  level.player allowfire(1);
}

setup_mantle_hint() {
  level.strings["mantle"] = &"SCRIPT_MANTLE";
  maps\_hud_util::create_mantle();
}

show_mantle_hint() {
  level.player allowjump(0);
  level.hud_mantle["text"].alpha = 1;
  level.hud_mantle["icon"].alpha = 1;
}

hide_mantle_hint() {
  level.player allowjump(1);
  level.hud_mantle["text"].alpha = 0;
  level.hud_mantle["icon"].alpha = 0;
}

player_check_jump() {
  self endon("left_volume");
  self endon("player_vaulted");
  self endon("not_looking_at_mantle");
  level endon("stop_player_vault");
  self notifyonplayercommand("player_vaulted", "+gostand");
  self waittill("player_vaulted");
}

player_volume_check(var_0) {
  if(isDefined(var_0))
    self endon(var_0);

  level.player endon("player_vaulted");
  level endon("stop_player_vault");

  for(;;) {
    if(!level.player istouching(self)) {
      level.player notify("left_volume");

      if(isDefined(var_0))
        self notify(var_0);
    }

    wait 0.05;
  }
}

player_check_mantle_lookat() {
  level.player endon("stop_mantle_lookat");
  level endon("stop_player_vault");

  for(;;) {
    var_0 = abs(angleclamp(level.player getplayerangles()[1]) - self.angles[1]);
    level.player.looking_at_mantle = var_0 < 60;

    if(!level.player.looking_at_mantle)
      level.player notify("not_looking_at_mantle");

    wait 0.05;
  }
}

do_notetracks(var_0, var_1) {
  self endon("death");
  self endon("new_anim");
  var_2 = getanimlength(var_0);
  var_3 = getnotetracktimes(var_0, var_1);
  var_4 = 0;

  for(;;) {
    var_5 = self getanimtime(var_0);

    if(var_4 < var_3.size && var_5 >= var_3[var_4]) {
      self notify(var_1);
      var_4++;
    } else if(var_4 >= var_3.size && var_5 < var_3[0])
      var_4 = 0;

    wait 0.05;
  }
}

hide_and_drop_entity() {
  maps\_utility::hide_entity();
  self.dropped = 1;
  self.origin = maps\_utility::set_z(self.origin, self.origin[2] - 5000);
}

show_and_raise_entity() {
  maps\_utility::show_entity();

  if(eval(self.dropped))
    self.origin = maps\_utility::set_z(self.origin, self.origin[2] + 5000);
}

fast_jog(var_0) {
  if(var_0 == 1) {
    self.animname = "generic";
    maps\_utility::set_run_anim("clock_jog", 1);
    self.moveplaybackrate = 1;
  } else {
    maps\_utility::clear_run_anim();
    self.moveplaybackrate = 1;
  }
}

setup_blackhawk(var_0) {
  level.player_blackhawk = maps\_vehicle::spawn_vehicle_from_targetname(var_0);
  level.player_blackhawk.dont_crush_player = 1;
  level.player_blackhawk.path_gobbler = 1;
  level.player_blackhawk maps\_vehicle::godon();
  level.player_blackhawk.lookat_ent = spawn("script_origin", level.player_blackhawk.origin);
  level.player_blackhawk setmaxpitchroll(0, 10);
  level.player_blackhawk maps\_vehicle_code::kill_lights();
  var_1 = level.player_blackhawk common_scripts\utility::spawn_tag_origin();
  var_1.origin = level.player_blackhawk gettagorigin("tag_light_cargo01");
  var_1.angles = level.player_blackhawk gettagangles("tag_light_cargo01");
  var_1 linkto(level.player_blackhawk);
  playFXOnTag(common_scripts\utility::getfx("aircraft_light_cockpit_white_300"), var_1, "tag_origin");
  common_scripts\utility::waitframe();
  thread maps\_vehicle::gopath(level.player_blackhawk);
  init_player_on_blackhawk(level.player, var_0 + "_seat");
}

init_player_on_blackhawk(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2 linkto(level.player_blackhawk, "tag_player", (0, -11, -6), (0, -75, 0));
  level.player playerlinktodelta(var_2, "tag_origin", 1.0, 10, 50, 5, 25, 0);
  level.player setplayerangles((0, level.player_blackhawk.angles[1] - 30, 0));
  var_0 allowjump(0);
  var_0 allowsprint(0);
  var_0 allowprone(0);
  var_0 allowcrouch(0);
  var_0 disableweapons();
  var_0.is_on_heli = 1;
}

update_sun() {
  level.sun_angles_default = getmapsunangles();
  level.sun_angles_intro = (-35, -36, 0);
  level.sun_angles_intro_deck = (-35, -36, 0);
  level.sun_angles_deck_combat = (-35, -36, 0);
  level.sun_angles_deck_tilt = (-19, -116, 0);

  if(level.start_point == "slow_intro") {
    lerpsunangles(level.sun_angles_default, level.sun_angles_intro, 0.05);
    common_scripts\utility::exploder(8002);

    if(maps\_utility::is_gen4())
      var_0 = 2.8;
    else
      var_0 = 1.1;

    setsunlight(1.0 * var_0, 0.8 * var_0, 0.57 * var_0);
    maps\_utility::setsaveddvar_cg_ng("r_specularcolorscale", 3.0, 2.0);
    maps\_utility::setsaveddvar_cg_ng("r_diffusecolorscale", 1.5, 1.5);
    common_scripts\utility::flag_wait("slow_intro_finished");
    lerpsunangles(level.sun_angles_default, level.sun_angles_deck_combat, 0.05);

    if(maps\_utility::is_gen4())
      var_0 = 2.8;
    else
      var_0 = 1.1;

    setsunlight(1.0 * var_0, 0.8 * var_0, 0.57 * var_0);
    maps\_utility::setsaveddvar_cg_ng("r_specularcolorscale", 3.0, 2.0);
    maps\_utility::setsaveddvar_cg_ng("r_diffusecolorscale", 1.5, 1.5);
    common_scripts\utility::flag_wait("defend_sparrow_start");
    lerpsunangles(level.sun_angles_deck_combat, level.sun_angles_deck_tilt, 45, 5, 5);
    maps\_utility::stop_exploder(8002);
    common_scripts\utility::exploder(8001);
  } else if(level.start_point == "medbay" || level.start_point == "deck_combat" || level.start_point == "deck_transition" || level.start_point == "defend_zodiac" || level.start_point == "run_to_sparrow" || level.start_point == "defend_sparrow") {
    lerpsunangles(level.sun_angles_default, level.sun_angles_deck_combat, 0.05);
    common_scripts\utility::exploder(8002);

    if(maps\_utility::is_gen4())
      var_0 = 2.8;
    else
      var_0 = 1.1;

    setsunlight(1.0 * var_0, 0.8 * var_0, 0.57 * var_0);
    maps\_utility::setsaveddvar_cg_ng("r_specularcolorscale", 3.0, 2.0);
    maps\_utility::setsaveddvar_cg_ng("r_diffusecolorscale", 1.5, 1.5);
    common_scripts\utility::flag_wait("defend_sparrow_start");
    lerpsunangles(level.sun_angles_deck_combat, level.sun_angles_deck_tilt, 45, 5, 5);
    maps\_utility::stop_exploder(8002);
    common_scripts\utility::exploder(8001);
  } else {
    if(maps\_utility::is_gen4())
      var_0 = 2.8;
    else
      var_0 = 1.1;

    setsunlight(1.0 * var_0, 0.8 * var_0, 0.57 * var_0);
    maps\_utility::setsaveddvar_cg_ng("r_specularcolorscale", 2.0, 1.5);
    maps\_utility::setsaveddvar_cg_ng("r_diffusecolorscale", 1.5, 1.5);
    lerpsunangles(level.sun_angles_deck_combat, level.sun_angles_deck_tilt, 0.05);
    maps\_utility::stop_exploder(8002);
    common_scripts\utility::exploder(8001);
  }
}

update_deck_post_intro() {
  level.sliding_jet2 hide();
  level.sliding_jet3 hide();
  common_scripts\utility::flag_wait("slow_intro_finished");
  level.sliding_jet2 show();
  level.sliding_jet3 show();
}

generic_prop_raven_anim(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;
  var_13 = undefined;
  var_14 = undefined;
  var_15 = undefined;

  if(!isDefined(var_5))
    var_5 = 1;

  var_16 = maps\_utility::spawn_anim_model(var_1);

  if(isDefined(var_3)) {
    var_8 = getEntArray(var_3, "targetname");

    foreach(var_18 in var_8) {
      if(var_18.script_noteworthy == "item") {
        var_9 = var_18;
        continue;
      }

      if(var_18.script_noteworthy == "clip") {
        var_10 = var_18;
        continue;
      }

      var_11 = var_18;
    }

    if(isDefined(var_10))
      var_10 linkto(var_9);

    if(isDefined(var_11))
      var_11 linkto(var_9);
  }

  if(isDefined(var_4)) {
    var_12 = getEntArray(var_4, "targetname");

    foreach(var_18 in var_12) {
      if(var_18.script_noteworthy == "item") {
        var_13 = var_18;
        continue;
      }

      if(var_18.script_noteworthy == "clip") {
        var_14 = var_18;
        continue;
      }

      var_15 = var_18;
    }

    if(isDefined(var_14))
      var_14 linkto(var_13);

    if(isDefined(var_15))
      var_15 linkto(var_13);
  }

  var_0 maps\_anim::anim_first_frame_solo(var_16, var_2);
  var_22 = var_16 gettagorigin("J_prop_1");
  var_23 = var_16 gettagangles("J_prop_1");
  var_24 = var_16 gettagorigin("J_prop_2");
  var_25 = var_16 gettagangles("J_prop_2");
  common_scripts\utility::waitframe();

  if(isDefined(var_3) && var_9.classname == "script_model") {
    var_9.origin = var_22;

    if(var_5 == 1)
      var_9.angles = var_23;
  }

  if(isDefined(var_4) && var_13.classname == "script_model") {
    var_13.origin = var_24;

    if(var_5 == 1)
      var_13.angles = var_25;
  }

  common_scripts\utility::waitframe();

  if(isDefined(var_3))
    var_9 linkto(var_16, "J_prop_1");

  if(isDefined(var_4))
    var_13 linkto(var_16, "J_prop_2");

  common_scripts\utility::flag_wait(var_6);

  if(isDefined(self.script_delay))
    wait(self.script_delay);

  var_0 maps\_anim::anim_single_solo(var_16, var_2);

  if(isDefined(var_7) && var_7 == 1) {
    if(isDefined(var_3))
      var_9 delete();

    if(isDefined(var_4))
      var_13 delete();

    var_16 delete();
  } else {
    if(isDefined(var_3))
      var_9 unlink();

    if(isDefined(var_4))
      var_13 unlink();

    var_16 delete();
  }
}

player_animate(var_0) {
  level.player setstance("stand");
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player disableweapons();
  level.player freezecontrols(1);
  var_1 = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  var_1.angles = (0, 90, 0);
  level.player playerlinktoblend(var_1, "tag_player", 0.3);
  maps\_anim::anim_single_solo(var_1, var_0);
  var_1 delete();
}

spawn_animate_delete(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_3 = var_2 maps\_utility::spawn_ai(1, 0);
  var_3.animname = "generic";
  maps\_anim::anim_single_solo(var_3, var_1);
  var_3 delete();
}

eval(var_0) {
  return isDefined(var_0) && var_0;
}

safe_deleteent(var_0) {
  if(isDefined(var_0))
    maps\_utility::deleteent(var_0);
}

#using_animtree("vehicles");

init_gunboats() {
  level.vttype = "gunboat";
  level.vtmodel = "vehicle_gun_boat_iw6";
  level.vtclassname = "script_vehicle_gunboat";
  maps\_vehicle::build_drive( % carrier_rappel_defend_gun_boat_moving, % carrier_rappel_defend_gun_boat_moving, 17);
}

spawn_gunboat(var_0, var_1) {
  foreach(var_3 in level.gunboats) {
    if(isalive(var_3) && isDefined(var_3.saved_targetname) && var_3.saved_targetname == var_0)
      return;
  }

  level.gunboats = maps\_utility::array_removedead(level.gunboats);

  if(level.gunboats.size >= 4) {
    return;
  }
  maps\_utility::array_spawn_function_targetname(var_0, ::setup_target_on_vehicle);
  var_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(var_0);
  var_3.saved_targetname = var_0;
  var_3.health = 25000;
  var_3.currenthealth = var_3.health;
  var_3 thread gunboat_treadfx();
  level.gunboats = common_scripts\utility::array_add(level.gunboats, var_3);
  var_3.mgturret[0] setaispread(level.difficultysettings["gunboat_aiSpread"][maps\_gameskill::get_skill_from_index(level.gameskill)]);
  var_3.mgturret[0] setconvergencetime(level.difficultysettings["gunboat_convergenceTime"][maps\_gameskill::get_skill_from_index(level.gameskill)]);

  if(eval(var_1) && maps\_gameskill::get_skill_from_index(level.gameskill) != "easy")
    var_3.mgturret[0] settargetentity(level.player);

  var_3 thread gunboat_think();
}

gunboat_treadfx() {
  stopFXOnTag(common_scripts\utility::getfx("gunboat_wake"), self, "j_bodymid");
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0 linkto(self, "tag_origin", anglesToForward((0, self.angles[1], 0)) * (450, 0, 0) + (0, 0, 15), (0, 0, 0));
  playFXOnTag(common_scripts\utility::getfx("gunboat_wake"), var_0, "tag_origin");
  self waittill("death");
  stopFXOnTag(common_scripts\utility::getfx("gunboat_wake"), var_0, "tag_origin");
  var_0 delete();
}

gunboat_think() {
  self endon("death");
  thread gunboat_dumbfire();
  maps\_utility::ent_flag_init("end");
  maps\_utility::ent_flag_wait("end");
  self kill();
}

gunboat_dumbfire() {
  self endon("death");
  common_scripts\utility::flag_wait("osprey_intermission");
  self.mgturret[0] setaispread(level.difficultysettings["gunboat_aiSpread"]["easy"]);
  self.mgturret[0] setconvergencetime(level.difficultysettings["gunboat_convergenceTime"]["easy"]);
  wait 4;
  self.mgturret[0] setaispread(level.difficultysettings["gunboat_aiSpread"][maps\_gameskill::get_skill_from_index(level.gameskill)]);
  self.mgturret[0] setconvergencetime(level.difficultysettings["gunboat_convergenceTime"][maps\_gameskill::get_skill_from_index(level.gameskill)]);
  common_scripts\utility::flag_wait("gunship_attack");
  self.mgturret[0] setaispread(100);
  self.mgturret[0] setconvergencetime(100);
}

explode_gunboats(var_0, var_1, var_2) {
  wait 0.2;

  foreach(var_4 in level.gunboats) {
    if(isDefined(var_4)) {
      var_5 = distance(var_4.origin, var_0);

      if(var_5 <= var_1) {
        level.osprey_hit_gunboats++;
        level.osprey_total_hits++;
        var_4 kill();
        wait 0.1;
      }
    }
  }
}

kill_remaining_gunboats() {
  foreach(var_1 in level.gunboats) {
    if(isDefined(var_1)) {
      var_1 kill();
      wait 0.1;
    }
  }
}

vehicles_loop_until_endon(var_0, var_1, var_2, var_3, var_4) {
  level endon(var_1);

  for(;;) {
    var_5 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive(var_0);

    if(eval(var_4))
      level.vista_vehicles = common_scripts\utility::array_combine(level.vista_vehicles, var_5);

    foreach(var_7 in var_5) {
      if(isDefined(var_7) && isalive(var_7))
        var_7 common_scripts\utility::waittill_any("reached_dynamic_path_end", "death");
    }

    if(eval(var_4))
      level.vista_vehicles = common_scripts\utility::array_remove_array(level.vista_vehicles, var_5);

    if(!isDefined(var_2))
      var_2 = 3;

    if(!isDefined(var_3))
      var_3 = 7;

    wait(randomfloatrange(var_2, var_3));
  }
}

vehicles_loop_and_unload_until_endon(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon(var_1);
  maps\_utility::array_spawn_function_targetname(var_0, ::vehicle_unload_drones, var_2, var_3);

  for(;;) {
    var_6 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive(var_0);

    foreach(var_8 in var_6) {
      if(isDefined(var_8) && isalive(var_8))
        var_8 common_scripts\utility::waittill_any("reached_dynamic_path_end", "death");
    }

    if(!isDefined(var_4))
      var_4 = 3;

    if(!isDefined(var_5))
      var_5 = 7;

    wait(randomfloatrange(var_4, var_5));
  }
}

vehicle_unload_drones(var_0, var_1) {
  self endon("death");
  self waittill("unloading");
  var_2 = 1;
  var_3 = getEntArray(self.script_parameters, "script_noteworthy");

  foreach(var_5 in var_3) {
    if(isDefined(var_5) && var_5.classname == "script_model") {
      var_5 thread drone_unload(var_0, var_2);
      var_2++;

      if(var_2 > var_1)
        var_2 = 1;
    }
  }
}

setup_target_on_vehicle() {
  self endon("death");
  thread clear_target_on_vehicle_death();

  for(;;) {
    if(!eval(level.player.in_osprey))
      level.player waittill("using_depth_charge");

    if(target_getarray().size >= 63) {
      return;
    }
    if(!isDefined(level.target_count))
      level.target_count = 0;

    while(level.target_count > 5) {
      wait 0.05;

      if(!isDefined(level.target_time) || level.target_time != gettime()) {
        level.target_count = 0;
        level.target_time = gettime();
      }
    }

    if(target_getarray().size >= 63) {
      return;
    }
    var_0 = "ac130_hud_enemy_ai_target_s_w";
    var_1 = (0, 0, 32);
    var_2 = 0;
    var_3 = 1;
    var_4 = 0;
    var_5 = 60;
    var_6 = (1, 0, 0);

    if((isai(self) || is_drone()) && isDefined(self.team) && self.team == "allies") {
      var_0 = "ac130_hud_friendly_ai_diamond_s_w";
      var_6 = (0.3, 1, 0.3);
      var_2 = 1;
    } else if(maps\_vehicle::isvehicle() && maps\_vehicle::ishelicopter()) {
      var_0 = "ac130_hud_enemy_vehicle_target_s_w";
      var_6 = (1, 0, 0);
      var_4 = 1;
      var_5 = 150;
    } else if(issubstr(self.classname, "vehicle") && isDefined(self.script_team) && self.script_team != "allies" || eval(self.fake) && issubstr(self.model, "zodiac")) {
      var_0 = "ac130_hud_enemy_vehicle_target_s_w";
      var_6 = (1, 0, 0);
      var_4 = 1;
      var_5 = 150;
    } else if(isDefined(self.script_noteworthy) && self.script_noteworthy == "big") {
      var_0 = "ac130_hud_enemy_vehicle_target_s_w";
      var_6 = (1, 0, 0);
      var_5 = 200;
    }

    target_alloc(self, var_1);
    target_setshader(self, var_0);
    target_setscaledrendermode(self, 1);

    if(var_2)
      target_drawsingle(self);

    if(var_3)
      target_drawsquare(self, var_5);

    if(var_4)
      target_drawcornersonly(self, 1);

    target_setcolor(self, var_6);
    target_showtoplayer(self, level.player);
    target_flush(self);
    level.target_count++;
    level.player waittill("depth_charge_exit");
  }
}

clear_target_on_vehicle_death() {
  level.player endon("depth_charge_exit");
  self waittill("death");

  if(isDefined(self) && target_istarget(self))
    target_remove(self);
}

fake_vehicles_loop_until_endon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon(var_3);
  var_8 = 17.6;

  if(var_0 == 0) {}

  var_9 = common_scripts\utility::getstructarray(var_1, "targetname");
  var_10 = [];

  foreach(var_12 in var_9) {
    var_13 = spawn("script_model", var_12.origin);
    var_13 setModel(var_2);
    var_13.angles = var_12.angles;
    var_13.target = var_12.target;
    var_14 = common_scripts\utility::getstruct(var_13.target, "targetname");

    if(isDefined(var_14) && isDefined(var_14.target))
      var_13.target2 = var_14.target;

    var_13 hide();
    var_10 = common_scripts\utility::array_add(var_10, var_13);
  }

  if(eval(var_6))
    level.vista_vehicles = common_scripts\utility::array_combine(level.vista_vehicles, var_10);

  for(;;) {
    foreach(var_13 in var_10) {
      if(!isDefined(var_13.start_origin))
        var_13.start_origin = var_13.origin;

      var_13.origin = var_13.start_origin;
    }

    if(!eval(var_7))
      fake_vehicles_waittill_not_looking(var_10);

    var_18 = 0;
    var_19 = 0;

    foreach(var_13 in var_10) {
      var_13 show();
      var_21 = common_scripts\utility::getstruct(var_13.target, "targetname");
      var_13.angles = vectortoangles(var_21.origin - var_13.origin);
      var_22 = distance(var_13.origin, var_21.origin);
      var_23 = var_22 / (var_0 * var_8);
      var_24 = var_23;
      var_13 moveto(var_21.origin, var_23);

      if(isDefined(var_13.target2)) {
        var_25 = common_scripts\utility::getstruct(var_13.target2, "targetname");
        var_26 = distance(var_21.origin, var_25.origin);
        var_19 = var_26 / (var_0 * var_8) / 2;
        var_13 maps\_utility::delaythread(var_23, ::goto_dest2, var_25, var_19);
        var_24 = var_24 + var_19;
      }

      var_18 = max(var_18, var_23);
    }

    wait(var_18);
    fake_vehicles_waittill_not_looking(var_10);
    common_scripts\utility::array_call(var_10, ::hide);

    foreach(var_13 in var_10)
    var_13 notify("stop_goto_dest2");

    if(eval(var_7)) {
      common_scripts\utility::array_call(var_10, ::delete);
      return;
    }

    if(!isDefined(var_4))
      var_4 = 3;

    if(!isDefined(var_5))
      var_5 = 7;

    wait(randomfloatrange(var_4, var_5));
  }
}

goto_dest2(var_0, var_1) {
  self endon("death");
  self endon("stop_goto_dest2");
  self moveto(var_0.origin, var_1, 0, var_1 / 2);
  wait(var_1);
  self hide();
}

fake_vehicles_waittill_not_looking(var_0) {
  var_1 = 1;

  while(var_1) {
    wait 0.5;
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(maps\_utility::either_player_looking_at(var_3.origin, cos(65), 1)) {
        var_1 = 1;
        break;
      }
    }
  }
}

drone_unload(var_0, var_1) {
  self waittill("jumpedout");
  self.target = var_0 + var_1;
  maps\_drone::drone_init();
  thread randomly_kill_drone();
  self waittill("death");
  maps\_drone::drone_drop_real_weapon_on_death();
}

randomly_kill_drone() {
  self endon("death");
  wait(randomfloatrange(8, 16));
  self dodamage(self.health, self.origin);
}

drone_respawner(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1))
    var_1 = 8;

  if(!isDefined(var_2))
    var_2 = 20;

  if(!isDefined(var_3))
    var_3 = 8;

  if(!isDefined(var_4))
    var_4 = 20;

  waittill_player_not_looking(1);
  var_5 = maps\_utility::spawn_ai(1);
  var_5.ignoreme = 1;
  var_5.noragdoll = undefined;
  var_5 thread kill_drone_respawner(var_0);
  level endon(var_0);

  for(;;) {
    wait(randomfloatrange(var_1, var_2));

    if(isDefined(var_5)) {
      var_5 dodamage(var_5.health, var_5.origin);
      level.dead_ally_drones = common_scripts\utility::array_add(level.dead_ally_drones, var_5);
    }

    wait(randomfloatrange(var_3, var_4));

    while(eval(self.inhibit_respawn))
      common_scripts\utility::waitframe();

    waittill_player_not_looking(1);
    var_5 = maps\_utility::spawn_ai(0);
    var_5 thread kill_drone_respawner(var_0);
  }
}

kill_drone_respawner(var_0) {
  self endon("death");
  common_scripts\utility::flag_wait(var_0);

  if(isDefined(self))
    self dodamage(self.health, self.origin);
}

waittill_player_not_looking(var_0) {
  self endon("death");

  if(eval(var_0)) {
    var_1 = cos(65);

    while(maps\_utility::either_player_looking_at(self.origin, var_1, 1))
      wait 1;
  } else {
    while(maps\_utility::either_player_looking_at(self.origin))
      wait 1;
  }
}

inhibit_respawn(var_0) {
  self.inhibit_respawn = var_0;
}

heli_fast_explode(var_0) {
  wait 0.1;

  if(maps\_vehicle::isvehicle() && maps\_vehicle::ishelicopter() && (isDefined(self.script_parameters) && self.script_parameters == "fast_explode" || isDefined(var_0) && randomint(100) <= var_0)) {
    self waittill("death");

    if(isDefined(self)) {
      playFX(common_scripts\utility::getfx("vfx_x_mphnd_primary"), self.origin, anglesToForward(self.angles));
      self delete();
    }
  }
}

drone_delete_on_unload() {
  if(isDefined(self.riders)) {
    foreach(var_1 in self.riders)
    var_1.drone_delete_on_unload = 1;
  }
}

is_drone() {
  return self.classname == "script_model";
}

safe_delete_drone(var_0) {
  self endon("death");

  if(!isDefined(var_0))
    var_0 = 500;

  thread maps\_utility::ai_delete_when_out_of_sight([self], var_0);
}

run_destructibles() {
  thread carrier_liferaft();
}

carrier_liferaft() {
  var_0 = getEntArray("liferaft_trigger", "targetname");

  foreach(var_2 in var_0)
  var_2 thread carrier_liferaft_think();
}

carrier_liferaft_think() {
  level endon("deck_tilt_start");
  var_0 = 0;
  var_1 = randomintrange(2000, 5000);

  for(;;) {
    self waittill("damage", var_2);
    var_0 = var_0 + var_2;

    if(var_0 >= var_1) {
      var_3 = getEntArray(self.target, "targetname");
      var_3 = common_scripts\utility::array_reverse(var_3);
      var_4 = var_3[0];

      if(isDefined(var_4.target)) {
        var_5 = getent(var_4.target, "targetname");
        var_5 delete();
      }

      var_4 physicslaunchserver(var_4.origin, (randomfloatrange(0, 500), 0, 0));
      var_4 thread liferaft_splash_on_hit_water();
      wait(randomfloatrange(0.2, 0.3));
      var_4 = var_3[1];

      if(isDefined(var_4.target)) {
        var_5 = getent(var_4.target, "targetname");
        var_5 delete();
      }

      var_4 physicslaunchserver(var_4.origin, (randomfloatrange(2500, 4000), 0, 0));
      var_4 thread liferaft_splash_on_hit_water();
      return;
    }
  }
}

liferaft_splash_on_hit_water() {
  while(isDefined(self) && self.origin[2] > level.water_level)
    wait 0.05;

  if(isDefined(self)) {
    var_0 = (self.origin[0], self.origin[1], level.water_level);
    playFX(common_scripts\utility::getfx("body_splash"), var_0);
  }

  wait 0.1;
  self delete();
}

setup_edge_lean() {
  var_0 = getEntArray("edge_lean", "targetname");

  foreach(var_2 in var_0)
  var_2 thread edge_lean_natural();
}

edge_lean_natural() {
  level.player endon("death");
  self.player_in = 0;
  level.player.in_lean_vol = 0;
  thread bump_player();

  if(level.gameskill < 2)
    level.player thread edge_lean_shield();

  for(;;) {
    self waittill("trigger");
    level.player.in_lean_vol = 1;
    level.player_view_pitch_down = getdvar("player_view_pitch_down");
    setsaveddvar("player_view_pitch_down", 89);

    while(level.player istouching(self)) {
      self.player_in = 1;
      common_scripts\utility::waitframe();
    }

    self.player_in = 0;
    level.player.in_lean_vol = 0;
    setsaveddvar("player_view_pitch_down", level.player_view_pitch_down);
  }
}

bump_player() {
  var_0 = 7;
  var_1 = 90;
  var_2 = 10;
  var_3 = -10;
  var_4 = var_1 - var_2;
  var_5 = common_scripts\utility::getstruct(self.target, "targetname");
  var_6 = undefined;

  if(isDefined(var_5.target))
    var_6 = getent(var_5.target, "targetname");
  else
    return;

  var_7 = var_6.origin;
  var_8 = -1 * anglesToForward(var_5.angles);
  var_9 = vectornormalize((var_8[0], var_8[1], 0));
  var_10 = -1 * var_9;
  var_11 = vectortoangles(var_10);
  var_12 = 0;

  for(;;) {
    if(!self.player_in) {
      common_scripts\utility::waitframe();
      continue;
    }

    var_13 = level.player getplayerangles();
    var_14 = anglesToForward(var_13);
    var_14 = vectornormalize((var_14[0], var_14[1], 0));
    var_15 = vectordot(var_14, var_10);
    var_16 = acos(var_15);
    var_16 = round_num(var_16, 2);

    if(var_16 < var_4) {
      if(var_6.origin != var_7) {
        var_6 moveto(var_7, 0.1);
        wait 0.1;
      } else
        common_scripts\utility::waitframe();

      continue;
    }

    var_17 = min((var_16 - var_4) / (var_2 - var_3), 1);
    var_18 = var_7 + var_9 * var_0 * var_17;

    if(var_17 != var_12)
      var_6 moveto(var_18, 0.1);

    wait 0.1;

    if(!self.player_in && var_6.origin != var_7) {
      var_6 moveto(var_7, 0.1);
      wait 0.1;
    }

    var_12 = var_17;
  }
}

round_num(var_0, var_1) {
  var_2 = 10 * var_1;

  if(var_1 == 0)
    var_2 = 1;

  var_3 = int(var_0 * var_2);
  var_4 = var_3 / var_2;
  return var_4;
}

edge_lean_shield() {
  self endon("death");
  var_0 = 60;

  for(;;) {
    var_1 = level.player getplayerangles();
    var_2 = angleclamp180(var_1[0]);

    if(self.in_lean_vol && var_2 >= var_0)
      level.player enabledeathshield(1);
    else
      level.player enabledeathshield(0);

    wait 0.5;
  }
}

player_rain_drops() {
  level.rain_overlay = [];
  level.rain_overlay[level.rain_overlay.size] = "overlay_rain_large";
  level.rain_overlay[level.rain_overlay.size] = "overlay_rain_large_02";
  level.rain_overlay[level.rain_overlay.size] = "overlay_rain_small";
  level.rain_overlay[level.rain_overlay.size] = "overlay_rain_small_02";
  level.rain_overlay[level.rain_overlay.size] = "overlay_rain_large";
  level.rain_overlay[level.rain_overlay.size] = "overlay_rain_large_02";
  level.rain_overlay[level.rain_overlay.size] = "overlay_rain_small";
  level.rain_overlay[level.rain_overlay.size] = "overlay_rain_small_02";
  level.rain_overlay[level.rain_overlay.size] = "overlay_rain_large";
  level.rain_overlay[level.rain_overlay.size] = "overlay_rain_large_02";
  level.rain_overlay[level.rain_overlay.size] = "overlay_rain_small";
  level.rain_overlay[level.rain_overlay.size] = "overlay_rain_small_02";
}

rain_overlay_alpha(var_0, var_1) {
  var_2 = self;

  if(!isplayer(var_2))
    var_2 = level.player;

  if(!isDefined(var_1))
    var_1 = 1;

  var_3 = get_rain_overlay(var_2);
  var_3[0].x = 0;
  var_3[0].y = 0;
  var_3[0] setshader("overlay_rain", 640, 480);
  var_3[0].sort = 50;
  var_3[0].lowresbackground = 0;
  var_3[0].alignx = "left";
  var_3[0].aligny = "top";
  var_3[0].alpha = 0.85;
  var_3[0].horzalign = "fullscreen";
  var_3[0].vertalign = "fullscreen";
  var_3[0] fadeovertime(var_0);
  var_3[0].alpha = var_1;

  for(var_4 = 1; var_4 < var_3.size; var_4++) {
    var_5 = common_scripts\utility::random(level.rain_overlay);
    var_3[var_4].x = 0 + randomint(360);
    var_3[var_4].y = 0 + randomint(360);
    var_3[var_4] setshader(var_5, 256, 256);
    var_3[var_4].sort = 50;
    var_3[var_4].lowresbackground = 0;
    var_3[var_4].alignx = "left";
    var_3[var_4].aligny = "top";
    var_3[var_4].horzalign = "fullscreen";
    var_3[var_4].vertalign = "fullscreen";
    var_3[var_4].alpha = randomfloatrange(0.15, 0.3);
    var_3[var_4] fadeovertime(var_0);
    var_3[var_4].alpha = var_1;
    wait 0.8;
  }
}

get_rain_overlay(var_0) {
  if(!isDefined(var_0.overlay_frozen)) {
    var_0.overlay_frozen = [];
    var_0.overlay_frozen[0] = newclienthudelem(var_0);
    var_0.overlay_frozen[1] = newclienthudelem(var_0);
    var_0.overlay_frozen[2] = newclienthudelem(var_0);
    var_0.overlay_frozen[3] = newclienthudelem(var_0);
    var_0.overlay_frozen[4] = newclienthudelem(var_0);
  }

  return var_0.overlay_frozen;
}

phalanx_gun_fire(var_0) {
  var_1 = getent(var_0, "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  var_1 endon("stop_firing");

  if(!isDefined(var_1.turret)) {
    var_1.turret = spawnturret("misc_turret", var_1.origin, "phalanx_turret");
    var_1.turret.angles = var_1.angles;
    var_1.turret maketurretinoperable();
    var_1.turret setCanDamage(0);
    var_1.turret setModel("crr_weapon_phalanx_01");
    var_1.turret setturretteam("allies");
    var_1.turret setdefaultdroppitch(-20);
    var_1.turret setmode("manual");
    var_1.turret.weaponinfo = "phalanx_turret";
    var_1.turret.weaponname = "phalanx_turret";
    var_1.turret_target = common_scripts\utility::spawn_tag_origin();
    var_1.turret settargetentity(var_1.turret_target);
    var_1 hide();
    var_1.turret_target.on_target = 0;
    var_1 thread phalanx_gun_fire_at_missiles();
  }

  var_2 = 0;

  for(;;) {
    var_3 = randomfloatrange(15, 45);
    var_4 = randomfloatrange(-60, 60);
    var_5 = randomfloatrange(2.0, 3.0);
    var_6 = var_5 * randomfloatrange(0.333, 0.666);
    var_1.turret_target moveto(var_1.origin + anglesToForward((var_1.angles[0] - var_3, var_1.angles[1] + var_4, 0)) * 2000, var_6);

    while(var_5 > 0 && !var_1.turret_target.on_target && (!isDefined(level.player.using_depth_charge) || !level.player.using_depth_charge)) {
      if(!var_2 && var_6 < randomfloat(0.5))
        var_1 phalanx_shoot();
      else
        var_1 phalanx_stop_shoot();

      wait 0.05;
      var_5 = var_5 - 0.05;
      var_6 = var_6 - 0.05;
    }

    var_2 = 0;
    var_1 phalanx_stop_shoot();
    wait(randomfloat(1.0));

    if(isDefined(level.player.using_depth_charge) && level.player.using_depth_charge)
      level.player waittill("depth_charge_exit");

    if(var_1.turret_target.on_target) {
      var_1 waittill("off_target");
      var_2 = 1;
    }
  }
}

phalanx_gun_fire_target(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getent(var_0, "targetname");
  var_6 endon("stop_firing");

  if(!isDefined(var_6) || !isDefined(var_6.turret_target) || var_6.turret_target.on_target) {
    return;
  }
  if(!isDefined(var_4))
    var_4 = (0, 0, 0);

  if(!isDefined(var_5))
    var_5 = "tag_origin";

  if(!isDefined(var_1.ent_flag) || !isDefined(var_1.ent_flag[var_2])) {
    var_1 maps\_utility::ent_flag_init(var_2);
    var_1 maps\_utility::ent_flag_init(var_3);
  }

  var_1 maps\_utility::ent_flag_wait(var_2);
  var_6.turret_target.on_target = 1;

  for(var_7 = vectornormalize(var_1 gettagorigin(var_5) + var_1 vehicle_getvelocity() * 0.25 - var_6.turret_target.origin); vectordot(var_7, anglesToForward(var_1.angles)) < 0 && (!isDefined(level.player.using_depth_charge) || !level.player.using_depth_charge); var_7 = vectornormalize(var_1 gettagorigin(var_5) + var_1 vehicle_getvelocity() * 0.25 - var_6.turret_target.origin)) {
    var_6.turret_target moveto(var_6.turret_target.origin + var_7 * 8000, 1);

    if(vectordot(anglesToForward(var_6.turret gettagangles("tag_flash")), vectornormalize(var_1.origin - var_6.origin)) > 0.9)
      var_6 phalanx_shoot();

    wait 0.05;
  }

  var_8 = randomfloat(0.25);
  var_9 = -0.05;

  while(isDefined(var_1) && !var_1 maps\_utility::ent_flag(var_3) && abs(angleclamp180(var_6.turret gettagangles("tag_flash")[1] - var_6.angles[1])) < 70 && (!isDefined(level.player.using_depth_charge) || !level.player.using_depth_charge)) {
    var_6.turret_target moveto(var_1 gettagorigin(var_5) + (randomfloatrange(-800, 800), randomfloatrange(-800, 800), randomfloatrange(-800, 800)) + var_1 vehicle_getvelocity() * (var_8 + 0.5), 0.5);
    var_6 phalanx_shoot();
    var_8 = var_8 + var_9;

    if(randomfloat(1) > 0.9 || var_8 <= 0.25 && var_9 < 0 || var_8 >= 0.25 && var_9 > 0)
      var_9 = var_9 * -1;

    wait 0.05;
  }

  var_6 phalanx_stop_shoot();
  var_6.turret_target.on_target = 0;
  var_6 notify("off_target");
}

phalanx_gun_fire_at_missiles() {
  self endon("stop_firing");

  for(;;) {
    while(self.turret_target.on_target || !isDefined(level.land_missiles))
      wait 0.05;

    var_0 = undefined;
    var_1 = -1;

    foreach(var_3 in level.land_missiles) {
      if(angleclamp180(var_3.angles[0]) < randomfloatrange(45, 60) && abs(angleclamp180(vectortoangles(var_3.origin - self.origin)[1] - self.angles[1])) < 45) {
        var_4 = vectordot(anglesToForward(self.turret gettagangles("tag_flash")), vectornormalize(var_3.origin - self.origin));

        if(var_4 > var_1) {
          var_1 = var_4;
          var_0 = var_3;
        }
      }
    }

    if(!isDefined(var_0)) {
      wait 0.05;
      continue;
    }

    level.land_missiles = common_scripts\utility::array_remove(level.land_missiles, var_0);
    var_6 = var_0.origin;
    wait 0.05;
    var_7 = distance(var_6, var_0.origin) / 0.05;
    self.turret_target.on_target = 1;
    var_8 = var_0.origin - anglesToForward(var_0.angles) * var_7 * 0.5;
    var_9 = vectornormalize(var_8 - self.turret_target.origin);

    for(var_10 = var_9; isDefined(var_0) && distancesquared(var_8, self.turret_target.origin) > 160000 && vectordot(var_9, var_10) >= 0.0; var_9 = vectornormalize(var_8 - self.turret_target.origin)) {
      self.turret_target moveto(self.turret_target.origin + var_9 * 10000, 0.5);

      if(vectordot(anglesToForward(self.turret gettagangles("tag_flash")), vectornormalize(var_0.origin - self.origin)) > 0.996)
        phalanx_shoot();

      wait 0.05;

      if(isDefined(var_0))
        var_8 = var_0.origin - anglesToForward(var_0.angles) * var_7 * 0.5;

      var_10 = var_9;
    }

    var_11 = 0;
    var_12 = 0;

    while(isDefined(var_0) && var_11 < 2 && abs(angleclamp180(self.turret gettagangles("tag_flash")[1] - self.angles[1])) < 70) {
      self.turret_target moveto(var_0.origin - anglesToForward(var_0.angles) * var_7 * 0.5 - (0, 0, randomfloatrange(-50, 100)), 0.25);
      phalanx_shoot();
      var_11 = var_11 + 0.05;
      var_12 = var_12 + 0.05;

      if(var_11 > 1 && var_12 >= 0.2) {
        playFX(common_scripts\utility::getfx("vfx_phalanx_missile_impact"), var_0.origin);
        var_12 = 0;
      }

      if(var_11 >= 2)
        var_0 notify("destroyed");

      wait 0.05;
    }

    if(var_11 >= 2) {
      for(var_13 = 0; var_13 < randomintrange(5, 10); var_13++) {
        phalanx_shoot();
        wait 0.05;
      }
    }

    phalanx_stop_shoot();
    self.turret_target.on_target = 0;
    self notify("off_target");
  }
}

phalanx_gun_fire_stop(var_0) {
  var_1 = getent(var_0, "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  var_1 notify("stop_firing");
  var_1 phalanx_stop_shoot();

  if(isDefined(var_1.turret_target))
    var_1.turret_target.origin = var_1.origin + anglesToForward(var_1.angles) * 2000;
}

phalanx_gun_offline(var_0) {
  var_1 = getent(var_0, "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  var_1 notify("stop_firing");

  if(isDefined(var_1.turret)) {
    var_1.turret stopfiring();
    var_1.turret turretsetbarrelspinenabled(0);
    var_1.turret_target.origin = var_1.origin + anglesToForward(var_1.angles + (20, 0, 0)) * 2000;
    var_1 stoploopsound("amb_carr_phalanx_loop");
  }
}

phalanx_shoot() {
  self.turret shootturret();

  if(isDefined(self.turret) && !self.turret isfiringturret()) {
    self.turret startfiring();
    self playLoopSound("amb_carr_phalanx_loop");
  }
}

phalanx_stop_shoot() {
  if(isDefined(self.turret) && self.turret isfiringturret()) {
    self.turret stopfiring();
    self playSound("amb_carr_phalanx_stop");
    self stoploopsound("amb_carr_phalanx_loop");
  }
}

modulus(var_0, var_1) {
  var_2 = int(var_0 / var_1);
  return var_0 - var_2 * var_1;
}

ac130_magic_bullet(var_0, var_1) {
  level endon("defend_sparrow_finished");
  var_2 = get_gun_tag();

  if(!isDefined(var_1)) {
    var_3 = self gettagangles("tag_flash_" + var_0 + "_" + var_2);
    var_3 = var_3 + (32, 0, 0);
    var_1 = self gettagorigin("tag_flash_" + var_0 + "_" + var_2) + anglesToForward(var_3) * 10000;
  }

  var_4 = self gettagorigin("tag_flash_" + var_0 + "_" + var_2);
  var_5 = magicbullet("ac130_" + var_0 + "_carrier", var_4, var_1);
  var_6 = "tag_flash_" + var_0 + "_" + var_2;
  playFXOnTag(common_scripts\utility::getfx("ac130_40mm_muzzle"), self, var_6);
  var_5 thread ac130_magic_bullet_splash(var_0);
}

ac130_magic_bullet_fake(var_0, var_1, var_2) {
  var_3 = magicbullet("ac130_" + var_0 + "_carrier", var_1, var_2);
  var_3 thread ac130_magic_bullet_splash(var_0);
}

ac130_magic_bullet_splash(var_0) {
  while(isDefined(self)) {
    if(self.origin[2] < level.water_level + 100) {
      break;
    }

    wait 0.05;
  }

  if(isDefined(self))
    playFX(common_scripts\utility::getfx("ac130_" + var_0 + "_impact_water"), (self.origin[0], self.origin[1], level.water_level));
}

ac130_magic_105(var_0) {
  level endon("defend_sparrow_finished");
  var_1 = get_gun_tag();
  var_2 = magicbullet("ac130_105mm_carrier", self gettagorigin("tag_flash_105mm_" + var_1), var_0);
  playFXOnTag(common_scripts\utility::getfx("ac130_105mm_muzzle"), self, "tag_flash_105mm_" + var_1);
  var_2 ac130_magic_105_impact(var_0);
}

ac130_magic_105_fake(var_0, var_1) {
  var_2 = magicbullet("ac130_105mm_carrier", var_0, var_1);
  var_2 ac130_magic_105_impact(var_1);
}

ac130_magic_105_impact(var_0) {
  var_1 = 0;

  while(isDefined(self)) {
    if(distancesquared(self.origin, var_0) < squared(50)) {
      break;
    }

    wait 0.05;
  }

  if(isDefined(self)) {
    playFX(common_scripts\utility::getfx("ac130_105mm_impact"), var_0);
    thread maps\carrier_audio::aud_carr_sparrow_105_hit(var_0);
  }
}

get_gun_tag() {
  if(is_player_right())
    return "ri";

  return "le";
}

is_player_right() {
  var_0 = 0.707;
  var_1 = vectornormalize(level.player.origin - self.origin);
  var_2 = anglestoright(self.angles);
  var_3 = vectordot(var_1, var_2);

  if(var_3 > var_0)
    return 1;

  return 0;
}

gunship_line_attack(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct(var_0, "targetname");
  var_3 = common_scripts\utility::getstruct(var_2.target, "targetname");
  var_4 = 3;

  if(isDefined(var_1))
    var_4 = var_1;

  var_5 = common_scripts\utility::spawn_tag_origin();
  var_5.origin = var_2.origin;
  var_5 moveto(var_3.origin, var_4);
  var_6 = gettime() + var_4 * 1000;
  var_7 = level.ac_130 common_scripts\utility::spawn_tag_origin();
  var_8 = level.ac_130 get_gun_tag();
  var_9 = level.ac_130 gettagorigin("tag_flash_25mm_" + var_8);
  var_7.origin = var_9;
  var_7 linkto(level.ac_130, "tag_flash_25mm_" + var_8);

  while(gettime() < var_6) {
    level.ac_130 thread ac130_magic_bullet("25mm", var_5.origin);
    var_7 maps\_utility::play_sound_on_entity("ac130_25mm_fire_npc");
    wait 0.05;
  }

  var_5 delete();
  var_7 delete();
}

gunship_line_attack_death() {
  var_0 = level.player.origin + anglesToForward(level.player getplayerangles()) * 1000;
  var_1 = level.player.origin + anglesToForward(level.player getplayerangles()) * -100;
  var_2 = 3;
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_3.origin = var_0;
  var_3 moveto(var_1, var_2);
  var_4 = gettime() + var_2 * 1000;
  var_5 = level.ac_130 common_scripts\utility::spawn_tag_origin();
  var_6 = level.ac_130 get_gun_tag();
  var_7 = level.ac_130 gettagorigin("tag_flash_25mm_" + var_6);
  var_5.origin = var_7;
  var_5 linkto(level.ac_130, "tag_flash_25mm_" + var_6);

  while(gettime() < var_4) {
    level.ac_130 thread ac130_magic_bullet("25mm", var_3.origin);
    var_5 maps\_utility::play_sound_on_entity("ac130_25mm_fire_npc");
    wait 0.05;
  }

  var_3 delete();
  var_5 delete();
}

gunship_line_attack_fake(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::getstruct(var_0, "targetname");
  var_4 = common_scripts\utility::getstruct(var_3.target, "targetname");
  var_5 = 3;
  var_6 = common_scripts\utility::spawn_tag_origin();
  var_6.origin = var_1;

  if(isDefined(var_2))
    var_5 = var_2;

  var_7 = common_scripts\utility::spawn_tag_origin();
  var_7.origin = var_3.origin;
  var_7 moveto(var_4.origin, var_5);
  var_8 = gettime() + var_5 * 1000;

  while(gettime() < var_8) {
    thread ac130_magic_bullet_fake("25mm", var_1, var_7.origin);
    var_6 maps\_utility::play_sound_on_entity("ac130_25mm_fire_npc");
    wait 0.05;
  }

  var_7 delete();
  var_6 delete();
}