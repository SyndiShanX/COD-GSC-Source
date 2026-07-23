/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\payback_main.gsc
*****************************************/

main() {
  _id_6484::main();
  maps\payback_fx::main();
  maps\payback_aud::main();
  _id_6847();
  _id_6848();
  maps\payback_anim::_id_683B();
  maps\_utility::add_hint_string("Payback_Dont_Abandon_Mission", &"PAYBACK_DONT_ABANDON_MISSION", maps\payback_1_script_a::hasplayerreturnedtocompound);
  maps\_utility::add_hint_string("chopper_zoom_hint", &"REMOTE_CHOPPER_GUNNER_ZOOM_HINT", maps\payback_1_script_d::should_break_available);
  level.cosine = [];
  level.cosine["5"] = cos(5);
  level.cosine["10"] = cos(10);
  level.cosine["15"] = cos(15);
  level.cosine["20"] = cos(20);
  level.cosine["25"] = cos(25);
  level.cosine["30"] = cos(30);
  level.cosine["35"] = cos(35);
  level.cosine["40"] = cos(40);
  level.cosine["45"] = cos(45);
  level.cosine["55"] = cos(55);
  maps\_utility::define_loadout("payback");
  maps\_utility::define_introscreen("payback");
  maps\_drone_ai::init();
  maps\_breach::main();
  _id_6843::main();
  maps\_load::main();
  maps/_flare::main("tag_flash");
  maps\payback_sandstorm_code::sandstorm_skybox_hide();
  level._id_6844 = 1;
  maps\_load::set_player_viewhand_model("viewhands_player_yuri");
  common_scripts\utility::flag_set("payback_stealth_ready");
  maps\payback_anim::main();

  if(!isDefined(level._id_6845)) {
    _id_663D::slowmo_breach_init();
  }
  common_scripts\utility::trigger_off("breach_save_trig_1", "targetname");
  common_scripts\utility::trigger_off("breach_save_trig_2", "targetname");
  common_scripts\utility::trigger_off("ready_to_pick_up_niko_save_trig", "targetname");
  var_0 = getEnt("compound_turret1", "targetname");
  var_0 makeunusable();
  var_1 = getEnt("militia_window_mg", "targetname");
  var_1 makeunusable();
  var_2 = getEnt("militia_window_mg2", "targetname");
  var_2 makeunusable();
  var_3 = getEntArray("street_run_anim_check_triggers", "script_noteworthy");

  foreach(var_5 in var_3) {}
  var_5 common_scripts\utility::trigger_off();

  var_7 = getEnt("sslight_01", "targetname");
  var_7 setlightintensity(0);
  var_8 = getEnt("street_light_gate", "targetname");
  var_8 setlightintensity(0);
  maps\payback_util::setup_spawn_funcs();
  maps\_utility::vision_set_fog_changes("payback", 0);
  var_9 = getEnt("price", "script_noteworthy");
  var_9 maps\_utility::add_spawn_function(::setup_price);
  var_10 = getEnt("soap", "script_noteworthy");
  var_10 maps\_utility::add_spawn_function(::setup_soap);
  var_11 = getEnt("nikolai", "script_noteworthy");
  var_11 maps\_utility::add_spawn_function(::setup_nikolai);
  var_12 = getEnt("hannibal", "script_noteworthy");
  var_12 maps\_utility::add_spawn_function(::_id_684E);
  var_13 = getEnt("barracus", "script_noteworthy");
  var_13 maps\_utility::add_spawn_function(::_id_684F);
  var_14 = getEnt("murdock", "script_noteworthy");
  var_14 maps\_utility::add_spawn_function(::_id_6850);
  level.friendly_startup_thread = ::assign_friendlies;
  _id_6846();
  var_15 = getEntArray("tv_trigger", "targetname");

  foreach(var_17 in var_15) {}
  var_17 thread maps\payback_util::tv_trigger_wait_enter(var_17.script_noteworthy, var_17.script_parameters);

  thread maps\payback_env_code::pip_test_init();
  var_19 = getEntArray("construction_roof_blocker_volume", "targetname");
  var_19[var_19.size] = getEnt("construction_roof_blocker_volume_during_anim", "targetname");

  foreach(var_21 in var_19) {
    var_21 notsolid();
    var_21 connectpaths();
  }

  getEnt("pb_end_vista", "targetname") hide();
  getEnt("compoundexit_vista", "targetname") hide();
  var_23 = getEntArray("so_asset", "targetname");

  foreach(var_25 in var_23) {}
  var_25 delete();
}

_id_6846() {
  objective_add(maps\_utility::obj("obj_kruger"), "invisible", &"PAYBACK_OBJ_KRUGER");
  objective_add(maps\_utility::obj("obj_primary_lz"), "invisible", &"PAYBACK_OBJ_PRIMARY_LZ");
  objective_add(maps\_utility::obj("obj_secondary_lz"), "invisible", &"PAYBACK_OBJ_SECONDARY_LZ");
  objective_add(maps\_utility::obj("obj_find_chopper"), "invisible", &"PAYBACK_OBJ_FIND_CHOPPER");
  objective_add(maps\_utility::obj("obj_rescue"), "invisible", &"PAYBACK_OBJ_RESCUE");
}

_id_6847() {
  common_scripts\utility::flag_init("payback_stealth_ready");
  maps\payback_compound::_id_6842();
  maps\payback_1_script_e::kruger_interrogation_init();
  maps\payback_streets_const::init_construction_flags();
  maps\payback_streets::init_flags_streets();
  maps\payback_rescue::init_flags_rescue();
}

_id_6848() {
  precacheitem("m4m203_acog_payback");
  precacheitem("deserteagle");
  precacheitem("remote_chopper_gunner");
  precacheitem("scuba_mask_on");
  precacheitem("scuba_mask_off");
  precacheitem("hind_12.7mm");
  precacheitem("zippy_rockets");
  precachemodel("prop_sas_gasmask");
  precachemodel("pb_gas_mask_prop");
  precachemodel("projectile_us_smoke_grenade");
  precachemodel("generic_prop_raven");
  precachemodel("weapon_beretta");
  precachemodel("weapon_desert_eagle_tactical");
  precachemodel("payback_vehicle_hind");
  precachemodel("payback_const_rappel_rope");
  precachemodel("payback_const_rappel_rope_obj");
  precachemodel("viewhands_player_yuri");
  precachemodel("viewhands_yuri");
  precachemodel("payback_escape_debris");
  precachemodel("pb_sstorm_chopper_rescue_propeller");
  precachemodel("pb_sstorm_chopper_rescue_tail_anim");
  precachemodel("viewlegs_generic");
  precachemodel("tag_flash");
  precachemodel("com_flashlight_on");
  precachemodel("com_flashlight_off");
  precachemodel("weapon_frame_charge_iw5_water");
  precachemodel("hjk_laptop_animated");
  precachemodel("pb_weapon_casing_closed");
  precachemodel("pb_weapon_casing_closed_splatter");
  precachemodel("com_clipboard_wpaper");
  precachemodel("hjk_cell_phone_off");
  precachemodel("pb_door_breach");
  precachemodel("pb_grenade_smoke");
  precachemodel("pb_door_breach_anim");
  precachemodel("pb_door_breach_hinge_anim");
  precachemodel("com_plasticcase_beige_big_us_dirt_animated");
  precachemodel("pb_heli_crash_rappel_debris");
  precachemodel("payback_sstorm_dwarf_palm");
  precachemodel("payback_foliage_tree_palm_med_1");
  precachemodel("pb_sstorm_tree_jungle");
  precachemodel("payback_sstorm_grass");
  precachemodel("com_square_flag_green");
  precachemodel("highrise_fencetarp_08");
  precachemodel("highrise_fencetarp_01");
  precachemodel("highrise_fencetarp_03");
  precachemodel("payback_const_crates");
  precachemodel("payback_studwall_collapse");
  precachemodel("pb_gate_chain");
  precachemodel("mil_emergency_flare");
  precachemodel("hat_price_africa");
  precachemodel("fullbody_price_africa_assault_a_nohat");
  precachemodel("vehicle_pickup_technical_pb_rusted");
  precacheshader("javelin_overlay_grain");
  precacheshader("nightvision_overlay_goggles");
  precacheshader("veh_hud_target_chopperfly");
  precacheshader("veh_hud_target_chopperfly_offscreen");
  precacheshader("veh_hud_target_offscreen");
  precacheshader("remote_chopper_hud_reticle");
  precacheshader("remote_chopper_hud_target_hit");
  precacheshader("remote_chopper_hud_target_enemy");
  precacheshader("remote_chopper_hud_target_e_vehicle");
  precacheshader("remote_chopper_hud_target_friendly");
  precacheshader("remote_chopper_hud_target_player");
  precacheshader("remote_chopper_hud_targeting_frame");
  precacheshader("remote_chopper_hud_targeting_bar");
  precacheshader("remote_chopper_hud_targeting_circle");
  precacheshader("remote_chopper_hud_targeting_rectangle");
  precacheshader("remote_chopper_hud_compass_bar");
  precacheshader("remote_chopper_hud_compass_bracket");
  precacheshader("remote_chopper_hud_compass_triangle");
  precacheshader("remote_chopper_overlay_scratches");
  precacheshader("dpad_remote_chopper_gunner");
  precacheshader("hud_dpad");
  precacheshader("hud_arrow_right");
  precacheshader("overlay_sandstorm");
  precacheshader("overlay_static");
  precacheshader("stance_carry");
  precacheshader("gfx_laser_light_bright");
  precacheshader("gfx_laser_bright");
  precachestring(&"PAYBACK_REMOTE_CHOPPER_TURRET");
  precachestring(&"PAYBACK_FAIL_ABANDONED");
  precachestring(&"REMOTE_CHOPPER_GUNNER_TADS");
  precachestring(&"REMOTE_CHOPPER_GUNNER_RCT_ACTIVE");
  precachestring(&"REMOTE_CHOPPER_GUNNER_X");
  precachestring(&"REMOTE_CHOPPER_GUNNER_Z");
  precachestring(&"REMOTE_CHOPPER_GUNNER_12_7MM");
  precachestring(&"REMOTE_CHOPPER_GUNNER_ROUNDS");
  precachestring(&"REMOTE_CHOPPER_GUNNER_63");
  precachestring(&"REMOTE_CHOPPER_GUNNER_N1_4");
  precachestring(&"REMOTE_CHOPPER_GUNNER_RECORDING");
  precachestring(&"PAYBACK_KRUGER_NEEDED_ALIVE");
  precachestring(&"PAYBACK_USE_THE_ROPE");
  precachestring(&"PAYBACK_JUMP");
  precachestring(&"PAYBACK_STAY_WITH_TEAM");
  precachestring(&"PAYBACK_CAPTURE_KRUGER");
  precachestring(&"PAYBACK_KEEP_UP");
  precachestring(&"PAYBACK_FAIL_GAS");
  precachestring(&"PAYBACK_JEEP_JUMP");
  precachestring(&"PAYBACK_RUN_TO_JEEP");
  precacherumble("heavy_3s");
  precacherumble("damage_heavy");
  precacherumble("crash_heli_rumble_rest");
  precacherumble("steady_rumble");
  precacherumble("light_1s");
  precacherumble("subtle_tank_rumble");
  precacherumble("viewmodel_large");
  precacherumble("grenade_rumble");

  if(getDvar("ps3Game") == "true") {
    precachemodel("fullbody_price_africa_assault_a_sandstorm");
    precachemodel("fullbody_soap_africa_assault_a_sandstorm");
  }

  maps\_treadfx::setallvehiclefx("script_vehicle_payback_hind", "treadfx/Heli_sand_pb");
}

assign_friendlies() {
  self endon("death");

  if(isDefined(self.script_noteworthy)) {
    switch (self.script_noteworthy) {
      case "hannibal":
        if(!isDefined(level.hannibal) && !isalive(level.hannibal)) {
          _id_684E();
          return;
        }

        break;
      case "murdock":
        if(!isDefined(level.murdock) && !isalive(level.murdock)) {
          _id_6850();
          return;
        }

        break;
      case "barracus":
        if(!isDefined(level.barracus) && !isalive(level.barracus)) {
          _id_684F();
          return;
        }

        break;
    }
  }

  for(;;) {
    if(!isDefined(level.hannibal) && !isalive(level.hannibal)) {
      level.hannibal = self;
      self.script_noteworthy = "hannibal";
      self.animname = "hannibal";
      turretdoshootanims();
      level notify("hannibal_spawned");
      return;
    } else if(!isDefined(level.murdock) && !isalive(level.murdock)) {
      level.murdock = self;
      self.script_noteworthy = "murdock";
      turretdoshootanims();
      level notify("murdock_spawned");
      return;
    } else if(!isDefined(level.barracus) && !isalive(level.barracus)) {
      level.barracus = self;
      self.script_noteworthy = "barracus";
      turretdoshootanims();
      level notify("barracus_spawned");
      return;
    }

    wait 0.1;

    if(!isDefined(self) || !isalive(self)) {
      break;
    }
  }
}

setup_price() {
  level.price = self;
  level.price maps\_utility::magic_bullet_shield();
  level.price.animname = "price";
  level.price thread maps\_utility::make_hero();
  level.price.voice = "taskforce";
  level.price.countryid = "TF";
  level.price turretdoaimanims();
  level.price.baseaccuracy = 0.5;
}

setup_soap() {
  level.soap = self;
  level.soap maps\_utility::magic_bullet_shield();
  level.soap.animname = "soap";
  level.soap.disable_sniper_glint = 1;
  level.soap.voice = "taskforce";
  level.soap.countryid = "TF";
  level.soap turretdoaimanims();
  level.soap.baseaccuracy = 0.5;
}

_id_684B() {
  level.kruger = self;
  level.kruger maps\_utility::magic_bullet_shield();
  level.kruger.animname = "kruger";
  level.kruger.notarget = 1;
}

setup_nikolai() {
  level.nikolai = self;
  level.nikolai.ignoreall = 1;
  level.nikolai.notarget = 1;
  level.nikolai maps\_utility::magic_bullet_shield();
  level.nikolai.animname = "nikolai";
  level.nikolai.ignoreme = 1;
  level.nikolai.baseaccuracy = 0.5;
}

_id_684D(var_0, var_1) {
  var_2 = getEntArray(var_0, "script_noteworthy");

  foreach(var_4 in var_2) {
    if(isspawner(var_4)) {
      var_4 maps\_utility::remove_spawn_function(var_1);
    }
  }
}

_id_684E() {
  level.hannibal = self;
  turretdoshootanims();
  self.animname = "hannibal";
  _id_684D("hannibal", ::_id_684E);
  level notify(self.script_noteworthy + "_spawned");
}

_id_684F() {
  level.barracus = self;
  turretdoshootanims();
  _id_684D("barracus", ::_id_684F);
  level notify(self.script_noteworthy + "_spawned");
}

_id_6850() {
  level.murdock = self;
  turretdoshootanims();
  _id_684D("murdock", ::_id_6850);
  level notify(self.script_noteworthy + "_spawned");
}

turretdoshootanims() {
  thread maps\_utility::replace_on_death();
  turretdoaimanims();
  self.baseaccuracy = 0.5;
}

turretdoaimanims() {}

_id_6853() {
  if(isDefined(self.script_forcecolor)) {
    maps\_utility::set_force_color(self.script_forcecolor);
    self.fixednode = 1;
  }
}