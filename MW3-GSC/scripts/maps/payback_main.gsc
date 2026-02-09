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
  maps\_utility::add_hint_string("Payback_Dont_Abandon_Mission", &"PAYBACK_DONT_ABANDON_MISSION", maps\payback_1_script_a::_id_6807);
  maps\_utility::add_hint_string("chopper_zoom_hint", &"REMOTE_CHOPPER_GUNNER_ZOOM_HINT", maps\payback_1_script_d::_id_65EC);
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
  maps\_utility::_id_2821("payback");
  maps\_drone_ai::init();
  maps\_breach::main();
  _id_6843::main();
  maps\_load::main();
  _id_6526::main("tag_flash");
  maps\payback_sandstorm_code::_id_5C02();
  level._id_6844 = 1;
  maps\_load::_id_1F5C("viewhands_player_yuri");
  common_scripts\utility::flag_set("payback_stealth_ready");
  maps\payback_anim::main();

  if(!isDefined(level._id_6845)) {
    _id_663D::_id_4CBC();
  }
  common_scripts\utility::trigger_off("breach_save_trig_1", "targetname");
  common_scripts\utility::trigger_off("breach_save_trig_2", "targetname");
  common_scripts\utility::trigger_off("ready_to_pick_up_niko_save_trig", "targetname");
  var_0 = getent("compound_turret1", "targetname");
  var_0 makeunusable();
  var_1 = getent("militia_window_mg", "targetname");
  var_1 makeunusable();
  var_2 = getent("militia_window_mg2", "targetname");
  var_2 makeunusable();
  var_3 = getEntArray("street_run_anim_check_triggers", "script_noteworthy");

  foreach(var_5 in var_3) {}
  var_5 common_scripts\utility::trigger_off();

  var_7 = getent("sslight_01", "targetname");
  var_7 setlightintensity(0);
  var_8 = getent("street_light_gate", "targetname");
  var_8 setlightintensity(0);
  maps\payback_util::_id_64AB();
  maps\_utility::vision_set_fog_changes("payback", 0);
  var_9 = getent("price", "script_noteworthy");
  var_9 maps\_utility::add_spawn_function(::_id_5296);
  var_10 = getent("soap", "script_noteworthy");
  var_10 maps\_utility::add_spawn_function(::_id_684A);
  var_11 = getent("nikolai", "script_noteworthy");
  var_11 maps\_utility::add_spawn_function(::_id_684C);
  var_12 = getent("hannibal", "script_noteworthy");
  var_12 maps\_utility::add_spawn_function(::_id_684E);
  var_13 = getent("barracus", "script_noteworthy");
  var_13 maps\_utility::add_spawn_function(::_id_684F);
  var_14 = getent("murdock", "script_noteworthy");
  var_14 maps\_utility::add_spawn_function(::_id_6850);
  level._id_139C = ::_id_6849;
  _id_6846();
  var_15 = getEntArray("tv_trigger", "targetname");

  foreach(var_17 in var_15) {}
  var_17 thread maps\payback_util::_id_64F7(var_17.script_noteworthy, var_17._id_164F);

  thread maps\payback_env_code::_id_6764();
  var_19 = getEntArray("construction_roof_blocker_volume", "targetname");
  var_19[var_19.size] = getent("construction_roof_blocker_volume_during_anim", "targetname");

  foreach(var_21 in var_19) {
    var_21 notsolid();
    var_21 connectpaths();
  }

  getent("pb_end_vista", "targetname") hide();
  getent("compoundexit_vista", "targetname") hide();
  var_23 = getEntArray("so_asset", "targetname");

  foreach(var_25 in var_23) {}
  var_25 delete();
}

_id_6846() {
  objective_add(maps\_utility::_id_2816("obj_kruger"), "invisible", &"PAYBACK_OBJ_KRUGER");
  objective_add(maps\_utility::_id_2816("obj_primary_lz"), "invisible", &"PAYBACK_OBJ_PRIMARY_LZ");
  objective_add(maps\_utility::_id_2816("obj_secondary_lz"), "invisible", &"PAYBACK_OBJ_SECONDARY_LZ");
  objective_add(maps\_utility::_id_2816("obj_find_chopper"), "invisible", &"PAYBACK_OBJ_FIND_CHOPPER");
  objective_add(maps\_utility::_id_2816("obj_rescue"), "invisible", &"PAYBACK_OBJ_RESCUE");
}

_id_6847() {
  common_scripts\utility::flag_init("payback_stealth_ready");
  maps\payback_compound::_id_6842();
  maps\payback_1_script_e::_id_663B();
  maps\payback_streets_const::_id_66FC();
  maps\payback_streets::_id_6698();
  maps\payback_rescue::_id_650B();
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

  maps\_treadfx::_id_28F1("script_vehicle_payback_hind", "treadfx/Heli_sand_pb");
}

_id_6849() {
  self endon("death");

  if(isDefined(self.script_noteworthy)) {
    switch (self.script_noteworthy) {
      case "hannibal":
        if(!isDefined(level._id_6493) && !isalive(level._id_6493)) {
          _id_684E();
          return;
        }

        break;
      case "murdock":
        if(!isDefined(level._id_6491) && !isalive(level._id_6491)) {
          _id_6850();
          return;
        }

        break;
      case "barracus":
        if(!isDefined(level._id_6492) && !isalive(level._id_6492)) {
          _id_684F();
          return;
        }

        break;
    }
  }

  for(;;) {
    if(!isDefined(level._id_6493) && !isalive(level._id_6493)) {
      level._id_6493 = self;
      self.script_noteworthy = "hannibal";
      self._id_1032 = "hannibal";
      _id_6851();
      level notify("hannibal_spawned");
      return;
    } else if(!isDefined(level._id_6491) && !isalive(level._id_6491)) {
      level._id_6491 = self;
      self.script_noteworthy = "murdock";
      _id_6851();
      level notify("murdock_spawned");
      return;
    } else if(!isDefined(level._id_6492) && !isalive(level._id_6492)) {
      level._id_6492 = self;
      self.script_noteworthy = "barracus";
      _id_6851();
      level notify("barracus_spawned");
      return;
    }

    wait 0.1;

    if(!isDefined(self) || !isalive(self)) {
      break;
    }
  }
}

_id_5296() {
  level._id_4877 = self;
  level._id_4877 maps\_utility::_id_0D04();
  level._id_4877._id_1032 = "price";
  level._id_4877 thread maps\_utility::_id_26C7();
  level._id_4877.voice = "taskforce";
  level._id_4877._id_0AB4 = "TF";
  level._id_4877 _id_6852();
  level._id_4877._id_20AF = 0.5;
}

_id_684A() {
  level._id_54E0 = self;
  level._id_54E0 maps\_utility::_id_0D04();
  level._id_54E0._id_1032 = "soap";
  level._id_54E0._id_0D0D = 1;
  level._id_54E0.voice = "taskforce";
  level._id_54E0._id_0AB4 = "TF";
  level._id_54E0 _id_6852();
  level._id_54E0._id_20AF = 0.5;
}

_id_684B() {
  level._id_663E = self;
  level._id_663E maps\_utility::_id_0D04();
  level._id_663E._id_1032 = "kruger";
  level._id_663E._id_59C3 = 1;
}

_id_684C() {
  level._id_64A5 = self;
  level._id_64A5.ignoreall = 1;
  level._id_64A5._id_59C3 = 1;
  level._id_64A5 maps\_utility::_id_0D04();
  level._id_64A5._id_1032 = "nikolai";
  level._id_64A5.ignoreme = 1;
  level._id_64A5._id_20AF = 0.5;
}

_id_684D(var_0, var_1) {
  var_2 = getEntArray(var_0, "script_noteworthy");

  foreach(var_4 in var_2) {
    if(isspawner(var_4)) {
      var_4 maps\_utility::_id_26BD(var_1);
    }
  }
}

_id_684E() {
  level._id_6493 = self;
  _id_6851();
  self._id_1032 = "hannibal";
  _id_684D("hannibal", ::_id_684E);
  level notify(self.script_noteworthy + "_spawned");
}

_id_684F() {
  level._id_6492 = self;
  _id_6851();
  _id_684D("barracus", ::_id_684F);
  level notify(self.script_noteworthy + "_spawned");
}

_id_6850() {
  level._id_6491 = self;
  _id_6851();
  _id_684D("murdock", ::_id_6850);
  level notify(self.script_noteworthy + "_spawned");
}

_id_6851() {
  thread maps\_utility::_id_139E();
  _id_6852();
  self._id_20AF = 0.5;
}

_id_6852() {}

_id_6853() {
  if(isDefined(self._id_134B)) {
    maps\_utility::_id_13A4(self._id_134B);
    self.fixednode = 1;
  }
}