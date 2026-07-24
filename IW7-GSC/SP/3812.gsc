/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3812.gsc
**************************************/

_id_EFDD() {
  level.player endon("death");

  for(;;) {
    if(level.player adsButtonPressed()) {
      if(isDefined(level.player._id_BCF5) && level.player._id_BCF5 != 2.5)
        level.player scripts\sp\utility::_id_2B78(250, 0.1);
    } else if(isDefined(level.player._id_BCF5) && level.player._id_BCF5 != level.player._id_EFEA * 0.01)
      level.player scripts\sp\utility::_id_2B78(level.player._id_EFEA, 0.1);

    scripts\engine\utility::waitframe();
  }
}

_id_FDD8() {
  if(level.script != "shipcrib_epilogue") {
    [[level._id_C67F]]();
    _id_0F2F::_id_1355F();
  }

  precachemodel("axis_guide");
  precachemodel("head_hero_xo_qss");
  precachemodel("head_hero_gator_ss");
  precachemodel("head_hero_drop_officer_ss");

  if(level.script == "shipcrib_titan") {
    precachemodel("head_hero_mco_dirty_hqss");
    precachemodel("head_hero_marine_1_hqss");
    precachemodel("head_hero_marine_2_hqss");
  }

  level._effect["vfx_sc_armory_terminal_camo_change_scan"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_armory_terminal_camo_change_scan.vfx");
  precachemodel("viewmodel_base_viewhands_iw7_naval");
  precachemodel("body_hero_protagonist_vm_legs");
  precachemodel("body_hero_protagonist_vm_legs_naval");
  precachemodel("nopack_nohelmet_shadow");
  precachemodel("veh_mil_air_un_dropship_periph_interior");
  precacheshader("intel_hint_icon");
  level._id_FD6E._id_10B32 = [];
  level._id_FD6E._id_10B32["salter"] = "head_hero_xo_qss";
  level._id_FD6E._id_10B32["gator"] = "head_hero_gator_ss";
  level._id_FD6E._id_10B32["drop_officer"] = "head_hero_drop_officer_ss";
  level._id_FD6E._id_10B32["mco"] = "head_hero_mco_dirty_hqss";
  level._id_FD6E._id_10B32["brooks"] = "head_hero_marine_1_hqss";
  level._id_FD6E._id_10B32["kash"] = "head_hero_marine_2_hqss";
  level._id_FD6E._id_10B32["mac"] = "head_hero_engineer_hqss";

  if(level.script != "shipcrib_epilogue") {
    precachemodel("veh_mil_air_un_jackal_02_clear");
    _id_FDA1();
    thread _id_0BDC::_id_A15B(1);
  }
}

_id_FDAF(var_0) {
  thread _id_FDFB();
  _id_0EFB::_id_FE05();
  level _id_FDD8();
  level.player _meth_80D1();
  setsaveddvar("sm_sunDynamics", 0);
  setsaveddvar("r_umbraMinObjectContribution", 0);
  setsaveddvar("r_offloadPrimaryLights", 1);
  setsaveddvar("sm_sunSampleSizeNear", 0.8);
  setsaveddvar("r_tessellationOverride", 0);
  setsaveddvar("sm_spotUpdateLimit", 8);
  setsaveddvar("sm_roundRobinPrioritySpotShadows", 8);
  scripts\engine\utility::flag_init("jackal_elevator_finished");
  scripts\engine\utility::flag_init("skybox_stop_rotating");
  level thread _id_D28E();

  if(getdvarint("jkudebug") == 1)
    level thread _id_EFDD();

  level _id_0B20::_id_5A38();
  level _id_0B21::_id_5A45();
  level _id_0EEA::_id_EF96();
  level _id_0EEB::_id_FD81();
  var_1 = ["col_dropship1", "col_dropship2", "col_dropship3"];

  foreach(var_3 in var_1) {
    foreach(var_5 in getEntArray(var_3, "targetname")) {
      if(isDefined(var_5._id_EE52) && issubstr(var_5._id_EE52, "col_seat"))
        var_5 castspotshadows(0);
    }
  }

  if(!isDefined(var_0))
    level thread _id_E3B6();

  var_8 = getEntArray("shipcrib_sky_base", "targetname");
  level._id_FD6E._id_10288 = var_8[0];

  foreach(var_10 in var_8) {
    var_10 dontcastshadows();
    var_10 dontcastdistantshadows();
    var_10 castspotshadows(0);
  }

  level._effect["vfx_sc_steam_vent_elevator_grav_01"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_steam_vent_elevator_grav_01.vfx");
  level._effect["vfx_sc_steam_vent_elevator_rect_01"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_steam_vent_elevator_rect_01.vfx");
  level._effect["vfx_sc_steam_vent_elevator_med_01"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_steam_vent_elevator_med_01.vfx");
  level._effect["vfx_sc_steam_vent_elevator_lrg_01"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_steam_vent_elevator_lrg_01.vfx");
  level._effect["vfx_sc_steam_vent_lrg_01"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_sc_steam_vent_lrg_01.vfx");
  level thread _id_D21E();
}

_id_FDFB() {
  var_0 = level.script;

  switch (var_0) {
    case "shipcrib_moon":
      setaudiotriggerstate("shipcrib_audio_zone_id", "sc_moon_audio_state", 10.0);
      break;
    case "shipcrib_europa":
      setaudiotriggerstate("shipcrib_audio_zone_id", "sc_europa_audio_state", 10.0);
      break;
    case "shipcrib_titan":
      setaudiotriggerstate("shipcrib_audio_zone_id", "sc_titan_audio_state", 10.0);
      break;
    case "shipcrib_rogue":
      setaudiotriggerstate("shipcrib_audio_zone_id", "sc_rogue_audio_state", 10.0);
      break;
    case "shipcrib_prisoner":
      setaudiotriggerstate("shipcrib_audio_zone_id", "sc_prisoner_audio_state", 10.0);
      break;
    case "shipcrib_epilogue":
      break;
  }
}

_id_FDDB() {}

_id_FD79(var_0, var_1) {
  if(getdvarint("fastload", 1) != 0) {
    while(!ispreloadzonescomplete())
      scripts\engine\utility::waitframe();
  }

  cinematicingame(var_1);
  changelevel(var_0, 1, 0);
}

_id_FDDF(var_0) {
  if(!isDefined(level._id_FD6E._id_10288)) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = 0;

  while(!scripts\engine\utility::flag("skybox_stop_rotating")) {
    level._id_FD6E._id_10288 rotateTo(level._id_FD6E._id_10288.angles + (-90, 0, -90), 400);
    scripts\engine\utility::waitframe();
  }

  if(var_0)
    level._id_FD6E._id_10288 rotateTo(level._id_FD6E._id_10288.angles, 0.5);
  else
    level._id_FD6E._id_10288 rotateTo(level._id_FD6E._id_10288.angles, 2);
}

_id_FDC0() {
  _id_0EEB::_id_60FE("return", 1);
  _id_0EEB::_id_60FE("bridge", 1);
  _id_0EEB::_id_60FE("jackal", 1);
  _id_0EEB::_id_60FE("dropship", 1);
  _id_0EEB::_id_60FE("dropship_top", 1);
  _id_0EEB::_id_60FE("apc", 1);
  _id_0EEB::_id_60FE("flight", 1);
  _id_0EEB::_id_60FE("gravity", 1);
  _id_0EEB::_id_60FE("magazine", 1);
  _id_0EEB::_id_60FE("magazine_flight", 1);
  level thread _id_0B21::_id_5A43("bridge_exit", "open");
  level thread _id_0B21::_id_5A43("return_elevator", "locked");
  level thread _id_0B21::_id_5A43("mezzanine_elevator", "locked");
  level thread _id_0B20::_id_5A2E("armory_exit", "locked");
  level thread _id_0EEB::_id_60FD("return", "Flight Deck", 1);
  level thread _id_0EEB::_id_60FD("bridge", "Bridge Level", 1);
  level thread _id_0EEB::_id_60FD("apc", "Flight Deck", 1);
  level thread _id_0EEB::_id_60FD("flight", "Flight Deck", 1);
  level thread _id_0EEB::_id_60FD("gravity", "Mezzanine", 1);
  level thread _id_0EEB::_id_60FD("jackal", "Flight Deck", 1);
  level thread _id_0EEB::_id_60FD("dropship", "Return Deck", 1);
  level thread _id_0EEB::_id_60FD("dropship_top", "Exterior", 1);
  level thread _id_0EEB::_id_60FD("magazine", "Flight Deck", 1);
  level thread _id_0EEB::_id_60FD("magazine_flight", "Flight Deck", 1);
  level thread _id_E399(level._id_E35D._id_AA5F["dropship_bay_1"]._id_5979, 0.05);
  level thread _id_E399(level._id_E35D._id_AA5F["dropship_bay_2"]._id_5979, 0.05);
  level._id_E35D._id_B147 = _id_0EFB::_id_798A("magazine_collision", "targetname", "jackal");

  if(isDefined(level._id_E35D._id_B147))
    level._id_E35D._id_B147 notsolid();

  level._id_E35D._id_B146 = _id_0EFB::_id_798A("magazine_collision", "targetname", "flight_control");

  if(isDefined(level._id_E35D._id_B146))
    level._id_E35D._id_B146 notsolid();
}

_id_E3B6() {
  _id_0EFB::_id_E3F7();
  precachemodel("veh_mil_air_un_retribution_ftl_a");
  precachemodel("veh_mil_air_un_retribution_ftl_a_r");
  precachemodel("veh_mil_air_un_retribution_ftl_b");
  precachemodel("veh_mil_air_un_retribution_ftl_b_r");
  level._id_E35D._id_3BB6 = getEnt("retribution_exterior_model", "targetname");
  level._id_E35D._id_6A38 = spawn("script_model", level._id_E35D._id_3BB6.origin);
  level._id_E35D._id_6A38 setModel("veh_mil_air_un_retribution_rig");
  level._id_E35D._id_6A38 notsolid();
  level._id_E35D._id_6A38 thread _id_0B51::_id_10635();
  level._id_E35D._id_0039 = [];

  if(isDefined(level._id_E366))
    level thread[[level._id_E366]]();

  level._effect["red_light"] = loadfx("vfx/_requests/shipcrib/vfx_light_flash_red.vfx");
  level thread _id_0EE8::_id_2252(undefined, undefined, undefined, level.script + "_vr_tr_loaded");
  level _id_0EDD::_id_B0B5();
  level _id_0EE6::main();
  level _id_E39A();
  level _id_0EDF::_id_E38C();
  level _id_0EEF::_id_E3AD();
  level _id_0EF5::_id_FDF3();
  level _id_0EF3::_id_E362();
  level _id_0EF6::_id_E3F4();
  level _id_0EE1::_id_E3D8();
  level _id_0EEE::_id_FD90();
  level thread _id_FD88();

  if(level.script != "shipcrib_moon")
    level _id_0EE0::_id_E3BC();

  level _id_E385();
  var_0 = [];
  var_0["start"] = "shipcrib_sm_elevator_start";
  var_0["start_loop"] = "shipcrib_sm_elevator_loop";
  var_0["stop"] = "shipcrib_sm_elevator_stop";
  var_0["close"] = "shipcrib_sm_elevator_close_flap";
  var_0["open"] = "shipcrib_sm_elevator_stop_flap_down";
  var_0["stop_beep"] = "shipcrib_elevator_floor_indicator_arrived_beep";
  _id_0EEB::_id_6101("bridge", ["4", "6"]);
  _id_0EEB::_id_6102("bridge", var_0);
  _id_0EEB::_id_6103("bridge", "shipcrib_screen_heavy_duty_monitor", "tag_screen");
  _id_0EEB::_id_60FB("bridge", "Bridge Level", "6");
  _id_0EEB::_id_60FB("bridge", "Mezzanine", "4");
  _id_0EEB::_id_7976("bridge") thread _id_0EEB::_id_60F6();
  var_0 = [];
  var_0["start"] = "shipcrib_sm_elevator_start";
  var_0["start_loop"] = "shipcrib_sm_elevator_loop";
  var_0["stop"] = "shipcrib_sm_elevator_stop";
  var_0["close"] = "shipcrib_sm_elevator_close_flap";
  var_0["open"] = "shipcrib_sm_elevator_stop_flap_down";
  var_0["stop_beep"] = "shipcrib_elevator_floor_indicator_arrived_beep";
  _id_0EEB::_id_6101("return", ["4", "6"]);
  _id_0EEB::_id_6102("return", var_0);
  _id_0EEB::_id_6103("return", "shipcrib_screen_heavy_duty_monitor", "tag_screen");
  _id_0EEB::_id_60FB("return", "Moon Emergency", "4");
  _id_0EEB::_id_60FB("return", "Bridge Level", "4");
  _id_0EEB::_id_60FB("return", "Flight Deck", "6");
  _id_0EEB::_id_60FB("return", "Moon Stop", "4,6");
  _id_0EEB::_id_60FB("return", "Ship Assault", "4,6");
  _id_0EEB::_id_7976("return") thread _id_0EEB::_id_60F6();
  var_0 = [];
  var_0["start"] = "shipcrib_lg_elevator_start";
  var_0["start_loop"] = "shipcrib_lg_elevator_loop";
  var_0["stop"] = "shipcrib_lg_elevator_stop";
  var_0["close"] = "shipcrib_lg_elevator_close_flap";
  var_0["open"] = "shipcrib_lg_elevator_stop_flap_down";
  _id_0EEB::_id_6101("gravity", ["2", "4", "6", "8"]);
  _id_0EEB::_id_6102("gravity", var_0);
  _id_0EEB::_id_60FB("gravity", "Flight Deck", "8");
  _id_0EEB::_id_60FB("gravity", "Ship Assault", "2,4,6,8");
  _id_0EEB::_id_60FB("gravity", "Vehicle Deck", "4,6,8");
  _id_0EEB::_id_6101("flight", ["2", "4", "6", "8"]);
  _id_0EEB::_id_6102("flight", var_0);
  var_1 = var_0;
  _id_0EEB::_id_6102("apc", var_0);
  _id_0EEB::_id_6101("apc", ["1"]);
  _id_0EEB::_id_6102("jackal", var_1);
  _id_0EEB::_id_6101("jackal", ["1"]);
  _id_0EEB::_id_6102("dropship", var_0);
  _id_0EEB::_id_6101("dropship", ["1"]);
  _id_0EEB::_id_6102("magazine", var_0);
  _id_0EEB::_id_6101("magazine", ["1"]);
  level._id_E35D._id_2FE1 = getEnt("retribution_bridge_cic_bink", "targetname");
  level._id_E35D._id_2FE1 hide();
  level._id_E35D._id_2FE2 = level._id_FD6E._id_ECCE["cic"].ent;
  level._id_E35D._id_3056 = getEnt("retribution_bridge_speaker_monitor_opsmap", "targetname");
  level._id_E35D._id_3054 = getEnt("retribution_bridge_speaker_monitor_main", "targetname");
  level._id_E35D._id_3052 = getEnt("retribution_bridge_speaker_monitor_cic", "targetname");
}

_id_E37A(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 1;

  if(var_0) {
    level thread _id_0B20::_id_5A2E("captains_quarters", "locked");
    level scripts\engine\utility::delaythread(0.15, scripts\engine\utility::play_sound_in_space, "shipcrib_bridge_capops_door_lock_mechanism", _id_0B20::_id_794A("captains_quarters").origin);
  }

  if(var_1) {
    level thread _id_0B20::_id_5A2E("bridge", "locked");
    level scripts\engine\utility::delaythread(0.05, scripts\engine\utility::play_sound_in_space, "shipcrib_bridge_hallway_door_lock_mechanism", _id_0B20::_id_794A("bridge").origin);
  }

  if(var_2) {
    level thread _id_0B21::_id_5A43("bridge_exit", "locked");
    level scripts\engine\utility::delaythread(0.25, scripts\engine\utility::play_sound_in_space, "shipcrib_bridge_sliding_door_lock_mechanism", _id_0B21::_id_7950("bridge_exit").origin);
  }

  if(var_3)
    level thread _id_0B21::_id_5A43("return_elevator", "locked");
}

_id_E378() {
  level thread _id_0B20::_id_5A2E("bridge", "unlocked");
  level thread _id_0B20::_id_5A2E("captains_quarters", "unlocked");
  level thread _id_0B21::_id_5A43("bridge_exit", "unlocked");
  level thread _id_0B21::_id_5A43("return_elevator", "unlocked");
  level scripts\engine\utility::delaythread(0.05, scripts\engine\utility::play_sound_in_space, "shipcrib_bridge_hallway_door_unlock_mechanism", _id_0B20::_id_794A("bridge").origin);
  level scripts\engine\utility::delaythread(0.15, scripts\engine\utility::play_sound_in_space, "shipcrib_bridge_capops_door_unlock_mechanism", _id_0B20::_id_794A("captains_quarters").origin);
  level scripts\engine\utility::delaythread(0.25, scripts\engine\utility::play_sound_in_space, "shipcrib_bridge_sliding_door_unlock_mechanism", _id_0B21::_id_7950("bridge_exit").origin);
}

_id_E381(var_0, var_1) {
  cinematicingame(var_0, 1);
  var_2 = spawn("script_origin", level._id_E35D._id_2FE2.origin);
  level waittill("shipcrib_play_cic_briefing");
  var_2 playSound("bink3d_shipcrib_cic");
  level._id_E35D._id_2FE1 show();
  level._id_E35D._id_2FE2 hide();
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  pausecinematicingame(0);

  if(isDefined(var_1))
    level thread[[var_1]]();

  while(iscinematicplaying())
    scripts\engine\utility::waitframe();

  level._id_E35D._id_2FE1 hide();
  level notify("cic_done");
  var_2 stopsounds();
  scripts\engine\utility::waitframe();
  var_2 delete();
}

_id_E380(var_0) {
  level endon("stop_cic_rewatch");
  level.player endon("death");

  for(;;) {
    var_1 = scripts\engine\utility::getStruct("retribution_bridge_cic_interact", "targetname");
    var_1 thread _id_0E46::_id_48C4(undefined, undefined, undefined, 15, 120, 70, 0);
    var_1 waittill("trigger");
    _id_E381(var_0);
  }
}

_id_118B8() {
  _id_0EFB::_id_118C1();
  _id_EFD4("tigris_bridge", "Bridge Level", "8");
  _id_EFD4("tigris_bridge", "Mezzanine", "2");
  var_0["start"] = "shipcrib_lg_elevator_start";
  var_0["start_loop"] = "shipcrib_lg_elevator_loop";
  var_0["stop"] = "shipcrib_lg_elevator_stop";
  _id_EFD8("tigris_bridge", var_0);
  level._id_118A8._id_3053 = getEnt("tigris_bridge_monitor_main", "targetname");
  level._id_118A8._id_3053 hide();
  level._id_118A8._id_3051 = getEnt("tigris_bridge_monitor_cic", "targetname");
  level._id_118A8._id_3051 hide();
  level._id_118A8._id_3055 = getEnt("tigris_bridge_monitor_opsmap", "targetname");
  level._id_118A8._id_3055 hide();
  level._id_118A8._id_2FE0 = getEnt("tigris_bridge_cic", "targetname");
  level._id_118A8._id_2FE0 hide();
  level._id_118A8._id_2FE1 = getEnt("tigris_bridge_cic_bink", "targetname");
  level._id_118A8._id_2FE1 hide();
  level._id_118A8._id_3056 = getEnt("tigris_bridge_speaker_monitor_opsmap", "targetname");
  level._id_118A8._id_3054 = getEnt("tigris_bridge_speaker_monitor_main", "targetname");
  level._id_118A8._id_3052 = getEnt("tigris_bridge_speaker_monitor_cic", "targetname");
}

_id_D28B(var_0, var_1) {
  level.player endon("death");
  level.player._id_EFA8 = var_0;

  switch (var_0) {
    case "inside":
      setsaveddvar("mantle_enable", 0);
      setsaveddvar("cg_drawCrosshair", 0);
      setomnvar("ui_hide_weapon_info", 1);

      if(level.player _meth_846D() != "safe")
        _id_D28D();

      level.player._id_EFEA = 85;
      level.player thread scripts\sp\utility::_id_2B78(85, 0.5);
      _id_D28C(var_1);
      break;
    case "inside_slow":
      setsaveddvar("mantle_enable", 0);
      setsaveddvar("cg_drawCrosshair", 0);
      setomnvar("ui_hide_weapon_info", 1);

      if(level.player _meth_846D() != "safe")
        _id_D28D();

      level.player._id_EFEA = 65;
      level.player thread scripts\sp\utility::_id_2B78(65, 0.5);
      _id_D28C(var_1);
      break;
    case "inside_normal":
      setsaveddvar("mantle_enable", 0);
      setsaveddvar("cg_drawCrosshair", 0);
      setomnvar("ui_hide_weapon_info", 1);

      if(level.player _meth_846D() != "normal") {
        level.player scripts\sp\utility::_id_11428();
        level.player giveweapon("iw7_gunless");
        level.player switchtoweaponimmediate("iw7_gunless");
        level.player scripts\sp\utility::_id_F526("normal");
      }

      level.player._id_EFEA = 85;
      level.player thread scripts\sp\utility::_id_2B78(85, 0.5);
      level.player allowmelee(0);
      level.player allowdoublejump(0);
      level.player allowwallrun(0);
      level.player disableoffhandweapons();
      _id_D28C(var_1);
      break;
    case "combat_vr":
      setsaveddvar("mantle_enable", 1);
      setsaveddvar("cg_drawCrosshair", 1);
      setomnvar("ui_hide_weapon_info", 0);
      setomnvar("ui_hide_hud", 0);
      level.player scripts\sp\utility::_id_F526("normal");
      level.player._id_EFEA = 100;
      level.player thread scripts\sp\utility::_id_2B77(0.5);

      switch (var_1) {
        case "inside_slow":
        case "inside":
          level.player scripts\engine\utility::allow_weapon_switch(1);
          level.player scripts\engine\utility::allow_crouch(1);
          level.player scripts\engine\utility::allow_prone(1);
          level.player scripts\engine\utility::allow_jump(1);
          level.player scripts\engine\utility::allow_slide(1);
          level.player scripts\engine\utility::allow_lean(1);
          level.player scripts\engine\utility::allow_doublejump(0);
          level.player scripts\engine\utility::allow_wallrun(0);
          break;
        case "inside_normal":
          level.player scripts\engine\utility::allow_weapon_switch(1);
          level.player scripts\engine\utility::allow_crouch(1);
          level.player scripts\engine\utility::allow_prone(1);
          level.player scripts\engine\utility::allow_jump(1);
          level.player scripts\engine\utility::allow_slide(1);
          level.player scripts\engine\utility::allow_lean(1);
          level.player allowmelee(1);
          level.player allowdoublejump(0);
          level.player allowwallrun(0);
          level.player enableoffhandweapons();
          break;
        case "safe":
          level.player scripts\engine\utility::allow_weapon_switch(1);
          level.player scripts\engine\utility::allow_prone(1);
          level.player scripts\engine\utility::allow_slide(1);
          level.player scripts\engine\utility::allow_lean(1);
          level.player scripts\engine\utility::allow_doublejump(0);
          level.player scripts\engine\utility::allow_wallrun(0);
          break;
      }

      level.player _meth_80A1();
      level.player _meth_80CB(1);
      level.player switchtoweaponimmediate(level.player getcurrentprimaryweapon());
      break;
    case "safe":
      setsaveddvar("mantle_enable", 0);
      setsaveddvar("cg_drawCrosshair", 0);
      setomnvar("ui_hide_weapon_info", 0);
      var_2 = undefined;
      var_3 = level.player _meth_84C6("selectedLoadout");

      if(!isDefined(game["shipcrib_loadout"]) || !isDefined(var_3))
        var_2 = level.player _meth_84C6("loadouts", 0, "weaponSetups", 0, "weapon");
      else
        var_2 = level.player _meth_84C6("loadouts", var_3, "weaponSetups", 0, "weapon");

      if(level.player getcurrentweapon() == "iw7_gunless" || level.player getcurrentweapon() == "none") {
        if(!isDefined(var_2) || var_2 == "") {
          level.player scripts\sp\utility::_id_11428();
          level.player giveweapon("iw7_m4+acogm4");
          level.player giveweapon("seeker");
          level.player giveweapon("offhandshield");
          level.player switchtoweaponimmediate("iw7_m4+acogm4");
          level.player assignweaponoffhandprimary("seeker");
          level.player assignweaponoffhandsecondary("offhandshield");
        } else
          thread _id_0EE8::_id_8311();
      }

      level.player scripts\sp\utility::_id_F526("safe");
      level.player._id_EFEA = 100;
      level.player thread scripts\sp\utility::_id_2B77(0.5);

      switch (var_1) {
        case "":
          level.player scripts\engine\utility::allow_weapon_switch(0);
          level.player scripts\engine\utility::allow_prone(0);
          level.player scripts\engine\utility::allow_slide(0);
          level.player scripts\engine\utility::allow_lean(0);
          level.player _meth_80D1();
          break;
        case "inside_normal":
        case "inside_slow":
        case "inside":
          level.player _meth_80D1();
          level.player scripts\engine\utility::allow_crouch(1);
          level.player scripts\engine\utility::allow_jump(1);
          break;
        case "combat_vr":
          level.player scripts\engine\utility::allow_weapon_switch(0);
          level.player scripts\engine\utility::allow_prone(0);
          level.player scripts\engine\utility::allow_slide(0);
          level.player scripts\engine\utility::allow_lean(0);
          level.player scripts\engine\utility::allow_doublejump(1);
          level.player scripts\engine\utility::allow_wallrun(1);
          level.player _meth_80CB(0);
          level.player _meth_80D1();
          break;
      }

      break;
  }
}

_id_D28D() {
  level.player scripts\sp\utility::_id_11428();
  level.player giveweapon("iw7_gunless");
  level.player switchtoweaponimmediate("iw7_gunless");
  level.player scripts\sp\utility::_id_F526("safe");
}

_id_D28C(var_0) {
  switch (var_0) {
    case "":
      level.player scripts\engine\utility::allow_weapon_switch(0);
      level.player scripts\engine\utility::allow_crouch(0);
      level.player scripts\engine\utility::allow_prone(0);
      level.player scripts\engine\utility::allow_jump(0);
      level.player scripts\engine\utility::allow_slide(0);
      level.player scripts\engine\utility::allow_lean(0);
      level.player _meth_80D1();
      break;
    case "combat_vr":
      level.player scripts\engine\utility::allow_weapon_switch(0);
      level.player scripts\engine\utility::allow_crouch(0);
      level.player scripts\engine\utility::allow_prone(0);
      level.player scripts\engine\utility::allow_jump(0);
      level.player scripts\engine\utility::allow_slide(0);
      level.player scripts\engine\utility::allow_lean(0);
      level.player scripts\engine\utility::allow_doublejump(1);
      level.player scripts\engine\utility::allow_wallrun(1);
      level.player _meth_80CB(0);
      level.player _meth_80D1();
      break;
    case "safe":
      level.player _meth_80D1();
      level.player scripts\engine\utility::allow_crouch(0);
      level.player scripts\engine\utility::allow_jump(0);
      break;
  }
}

_id_D28E() {
  level.player endon("death");
  level endon("stop_scs_player_movement");
  level._id_EFED = "inside";
  var_0 = "";

  for(;;) {
    if(level._id_EFED == "inside") {
      if(var_0 != "inside") {
        _id_D28B("inside", var_0);
        var_0 = "inside";
      }
    } else if(level._id_EFED == "inside_slow") {
      if(var_0 != "inside_slow") {
        _id_D28B("inside_slow", var_0);
        var_0 = "inside_slow";
      }
    } else if(level._id_EFED == "combat") {
      if(var_0 != "combat") {
        _id_D28B("combat", var_0);
        var_0 = "combat";
      }
    } else if(level._id_EFED == "combat_vr") {
      if(var_0 != "combat_vr") {
        _id_D28B("combat_vr", var_0);
        var_0 = "combat_vr";
      }
    } else if(level._id_EFED == "safe") {
      if(var_0 != "safe") {
        _id_D28B("safe", var_0);
        var_0 = "safe";
      }
    } else if(level._id_EFED == "stop") {
      if(var_0 != "stop") {
        _id_D28B("stop", var_0);
        var_0 = "stop";
      }
    }

    scripts\engine\utility::waitframe();
  }
}

_id_EFEF() {
  level._id_13CEB = newhudelem();
  level._id_13CEB.hidewheninmenu = 1;
  level._id_13CEB.alignx = "left";
  level._id_13CEB.foreground = 1;
  level._id_13CEB.fontscale = 1;
  level._id_13CEB.alpha = 0;
  level._id_13CEB.x = 300;
  level._id_13CEB.y = 416;
  level._id_13CEB.color = (0, 0.6, 0.6);
  level._id_13CE9 = newhudelem();
  level._id_13CE9.hidewheninmenu = 1;
  level._id_13CE9.alignx = "left";
  level._id_13CE9.foreground = 1;
  level._id_13CE9.fontscale = 1;
  level._id_13CE9.alpha = 0;
  level._id_13CE9.x = 332;
  level._id_13CE9.y = 404;
  level._id_13CE9.color = (0, 0.6, 0.6);
  level._id_13CEA = newhudelem();
  level._id_13CEA.hidewheninmenu = 1;
  level._id_13CEA.alignx = "left";
  level._id_13CEA.foreground = 1;
  level._id_13CEA.fontscale = 1;
  level._id_13CEA.alpha = 0;
  level._id_13CEA.x = 300;
  level._id_13CEA.y = 404;
  level._id_13CEA.color = (0, 0.6, 0.6);
  var_0 = getEntArray("welcome", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_EFF0();
}

_id_EFF0() {
  for(;;) {
    self waittill("trigger");

    switch (self.script_noteworthy) {
      case "BRIDGE":
        break;
      case "CREW LEVEL 1":
        break;
      case "READY LEVEL":
        break;
      case "FLIGHT DECK":
        break;
      default:
        level._id_13CEB.alpha = 0.75;
        break;
    }

    while(level.player istouching(self))
      scripts\engine\utility::waitframe();

    level._id_13CEB.alpha = 0;
  }
}

_id_EF9F() {}

_id_EF9B() {}

_id_EFA1() {}

_id_EF9E() {
  level _id_EF9D();
  level _id_EF9F();
  level _id_EF9B();
  level _id_EFA1();

  if(!isDefined(level.player._id_EFA8))
    level.player._id_EFA8 = "outdoor";

  var_0 = scripts\engine\utility::getStructArray("scs_door2", "targetname");
  var_0 = scripts\engine\utility::array_combine(var_0, scripts\engine\utility::getStructArray("scs_door2_sliding", "targetname"));
  var_0 = scripts\engine\utility::array_combine(var_0, scripts\engine\utility::getStructArray("scs_door2_hinged_left", "targetname"));
  var_0 = scripts\engine\utility::array_combine(var_0, scripts\engine\utility::getStructArray("scs_door2_hinged_right", "targetname"));

  foreach(var_2 in var_0) {
    switch (var_2.targetname) {
      case "scs_door_hinged_left":
        var_2._id_EFB3 = 1;
        var_2._id_EFB0 = "left";
        var_2._id_EFBA = -80;
        break;
      case "scs_door_hinged_right":
        var_2._id_EFB3 = 1;
        var_2._id_EFB0 = "right";
        var_2._id_EFBA = 80;
        break;
      default:
        var_2._id_EFB3 = 0;
        break;
    }

    if(isDefined(var_2.script_parameters)) {
      var_3 = strtok(var_2.script_parameters, " ");

      switch (var_3[0]) {
        case "locked":
          var_2._id_EFAC = "locked";
          break;
        case "open":
          var_2._id_EFAC = "open";
          break;
        case "automatic":
          var_2._id_EFAC = "automatic";
          break;
        case "unlocked":
          var_2._id_EFAC = "unlocked";
          break;
        default:
          var_2._id_EFAC = "unlocked";
          break;
      }

      if(isDefined(var_3[1])) {
        var_2._id_EFC5 = var_3[1];
        level._id_EFA6[var_2._id_EFC5] = var_2;
      }
    } else
      var_2._id_EFAC = "unlocked";

    var_2._id_EFAB = "";

    if(var_2._id_EFB3) {
      var_2._id_EFC4 = squared(80);
      var_2._id_EFC2 = 0.8;
    } else {
      var_2._id_EFC4 = squared(160);
      var_2._id_EFC2 = 0.2;
    }

    var_2._id_EFB9 = 0;
    var_2._id_EFBF = undefined;
    var_2._id_EFAA = var_2.origin;
    var_2._id_EFAE = "[{+activate}] Open";
    var_2._id_EFB8 = "[{+activate}] Open";
    var_2._id_EFB7 = 51;
    var_4 = getEntArray(var_2.target, "targetname");

    foreach(var_6 in var_4) {
      if(isDefined(var_6.target)) {
        var_7 = getEntArray(var_6.target, "targetname");

        foreach(var_6 in var_7) {
          if(var_6.classname == "script_model")
            var_7 = scripts\engine\utility::array_remove(var_7, var_6);
        }

        var_4 = scripts\engine\utility::array_combine(var_4, var_7);
      }
    }

    var_11 = var_4;

    foreach(var_6 in var_11) {
      if(isDefined(var_6.script_noteworthy)) {
        switch (var_6.script_noteworthy) {
          case "inactive":
          case "auto":
          case "off":
          case "on":
            var_11 = scripts\engine\utility::array_remove(var_11, var_6);
            break;
        }
      }
    }

    foreach(var_6 in var_11)
    var_6 connectpaths();

    var_2._id_C4B1 = [];
    var_2._id_C325 = [];
    var_2._id_2633 = [];
    var_2._id_93B0 = [];

    foreach(var_6 in var_4) {
      if(isDefined(var_6.script_noteworthy)) {
        switch (var_6.script_noteworthy) {
          case "left":
            var_17 = var_6;
            var_6._id_101AD = "left";

            if(isDefined(var_17.target)) {
              var_18 = getEntArray(var_17.target, "targetname");

              foreach(var_20 in var_18)
              var_20 linkTo(var_17);
            }

            break;
          case "right":
            var_22 = var_6;
            var_6._id_101AD = "right";

            if(isDefined(var_22.target)) {
              var_18 = getEntArray(var_22.target, "targetname");

              foreach(var_20 in var_18)
              var_20 linkTo(var_22);
            }

            break;
          case "on":
            var_2._id_C4B1[var_2._id_C4B1.size] = var_6;
            var_4 = scripts\engine\utility::array_remove(var_4, var_6);
            break;
          case "off":
            var_2._id_C325[var_2._id_C325.size] = var_6;
            var_4 = scripts\engine\utility::array_remove(var_4, var_6);
            break;
          case "auto":
            var_2._id_2633[var_2._id_2633.size] = var_6;
            var_4 = scripts\engine\utility::array_remove(var_4, var_6);
            break;
          case "inactive":
            var_2._id_93B0[var_2._id_93B0.size] = var_6;
            var_4 = scripts\engine\utility::array_remove(var_4, var_6);
            break;
        }
      }
    }

    if(var_2._id_EFB3) {
      var_18 = getEntArray(var_4[0].target, "targetname");

      foreach(var_20 in var_18)
      var_20 linkTo(var_4[0]);
    }

    var_2._id_EF99 = var_4;
    var_2 thread _id_EFA3(var_4);
  }
}

_id_EFA5(var_0) {
  switch (var_0) {
    case "unlocked":
      foreach(var_2 in self._id_C4B1)
      var_2 show();

      foreach(var_2 in self._id_C325)
      var_2 hide();

      foreach(var_2 in self._id_2633)
      var_2 hide();

      foreach(var_2 in self._id_93B0)
      var_2 hide();

      break;
    case "locked":
      foreach(var_2 in self._id_C325)
      var_2 show();

      foreach(var_2 in self._id_C4B1)
      var_2 hide();

      foreach(var_2 in self._id_2633)
      var_2 hide();

      foreach(var_2 in self._id_93B0)
      var_2 hide();

      break;
    case "automatic":
      foreach(var_2 in self._id_2633)
      var_2 show();

      foreach(var_2 in self._id_C325)
      var_2 hide();

      foreach(var_2 in self._id_C4B1)
      var_2 hide();

      foreach(var_2 in self._id_93B0)
      var_2 hide();

      break;
    case "open":
      foreach(var_2 in self._id_93B0)
      var_2 show();

      foreach(var_2 in self._id_C325)
      var_2 hide();

      foreach(var_2 in self._id_2633)
      var_2 hide();

      foreach(var_2 in self._id_C4B1)
      var_2 hide();

      break;
  }
}

_id_EFA3(var_0) {
  self endon("death");
  thread _id_EFA5(self._id_EFAC);

  for(;;) {
    if(self._id_EFAC == "open" && self._id_EFAB != "open") {
      self._id_EFAB = "open";
      thread _id_EFA5(self._id_EFAC);

      foreach(var_2 in var_0) {
        if(self._id_EFB3) {
          var_2 rotateYaw(self._id_EFBA, self._id_EFC2);
          continue;
        }

        if(var_2._id_101AD == "left") {
          var_2 moveTo(self._id_EFAA + anglestoright(self.angles) * self._id_EFB7, self._id_EFC2);
          continue;
        }

        var_2 moveTo(self._id_EFAA + anglestoright(self.angles) * self._id_EFB7 * -1, self._id_EFC2);
      }

      if(!self._id_EFB3)
        wait(self._id_EFC2);
    } else if(self._id_EFAC == "unlocked" || self._id_EFAC == "automatic") {
      if(_id_EFA2(self) && self._id_EFAB != "open") {
        self._id_EFAB = "open";

        if(isDefined(self._id_EFC6)) {
          self[[self._id_EFC6]]();
          self._id_EFC6 = undefined;
        } else {
          thread _id_EFA5(self._id_EFAC);

          foreach(var_2 in var_0) {
            if(self._id_EFB3) {
              if(_id_EFA0(self))
                _id_EF9C(var_2, 1);
              else
                _id_EF9C(var_2, 0);

              continue;
            }

            if(var_2._id_101AD == "left") {
              var_2 moveTo(self._id_EFAA + anglestoright(self.angles) * self._id_EFB7, self._id_EFC2);
              continue;
            }

            var_2 moveTo(self._id_EFAA + anglestoright(self.angles) * self._id_EFB7 * -1, self._id_EFC2);
          }

          if(!self._id_EFB3)
            wait(self._id_EFC2);
        }
      } else if(!_id_EFA2(self) && self._id_EFAB != "closed") {
        self._id_EFAB = "closed";
        thread _id_EFA5(self._id_EFAC);

        foreach(var_2 in var_0) {
          if(self._id_EFB3) {
            var_2 rotateTo((0, 0, 0), 0.01);
            self._id_EFB9 = 0;
            continue;
          }

          var_2 moveTo(self._id_EFAA, self._id_EFC2);
        }

        if(!self._id_EFB3)
          wait(self._id_EFC2);
      }
    } else if(self._id_EFAC == "locked" && self._id_EFAB != "closed") {
      self._id_EFAB = "closed";
      thread _id_EFA5(self._id_EFAC);

      foreach(var_2 in var_0) {
        if(self._id_EFB3) {
          var_2 rotateTo((0, 0, 0), 0.01);
          self._id_EFB9 = 0;
          continue;
        }

        var_2 moveTo(self._id_EFAA, self._id_EFC2);
      }

      if(!self._id_EFB3)
        wait(self._id_EFC2);
    }

    scripts\engine\utility::waitframe();
  }
}

_id_EF9C(var_0, var_1) {
  if(var_1) {
    if(self._id_EFB0 == "left")
      var_2 = "door_hinged_left_enter";
    else
      var_2 = "door_hinged_right_enter";
  } else if(self._id_EFB0 == "left")
    var_2 = "door_hinged_left_exit";
  else
    var_2 = "door_hinged_right_exit";

  var_3 = [];
  var_3 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(var_5 in var_3)
  var_3 = scripts\engine\utility::array_remove(var_3, var_5);

  var_7 = [];

  foreach(var_5 in var_3) {
    switch (var_5.script_noteworthy) {
      case "front_lerp_start":
        var_7["front_lerp_start"] = var_5;
        break;
      case "front_lerp_end":
        var_7["front_lerp_end"] = var_5;
        break;
      case "rear_lerp_start":
        var_7["rear_lerp_start"] = var_5;
        break;
      case "rear_lerp_mid":
        var_7["rear_lerp_mid"] = var_5;
        break;
      case "rear_lerp_end":
        var_7["rear_lerp_end"] = var_5;
        break;
    }
  }

  if(!isDefined(var_1) || !var_1) {
    var_1 = 0;
    var_10 = var_7["front_lerp_start"];
    var_11 = undefined;
    var_12 = var_7["front_lerp_end"];
  } else {
    var_10 = var_7["rear_lerp_start"];
    var_11 = var_7["rear_lerp_mid"];
    var_12 = var_7["rear_lerp_end"];
  }

  var_13 = scripts\sp\utility::_id_10639("scs_doors_player_rig");
  var_13 hide();
  self._id_EFB9 = 0;

  if(level.player._id_EFA8 != "inside")
    level.player disableweapons();

  var_10 _id_D1D1(var_13, var_2, 0.4);
  var_13 show();
  var_10 scripts\sp\anim::_id_1F35(var_13, var_2);
  var_13 hide();

  if(isDefined(var_11)) {
    var_11 thread _id_D1D1(var_13, var_2, 0.5);
    var_0 rotateYaw(self._id_EFBA, self._id_EFC2);
    wait 0.8;
    var_12 _id_D1D1(var_13, var_2, 1.2);
  } else {
    var_0 rotateYaw(self._id_EFBA, self._id_EFC2);
    var_12 _id_D1D1(var_13, var_2, 1.2);
  }

  self._id_EFB9 = 1;
  var_13 delete();
  level.player unlink();

  if(level.player._id_EFA8 != "inside")
    level.player scripts\engine\utility::allow_weapon(1);
}

_id_EFA2(var_0) {
  if(self._id_EFB3 && self._id_EFB9)
    return 0;

  if(distance2dsquared(level.player.origin, var_0.origin) < var_0._id_EFC4 && var_0._id_EFAB == "open")
    return 1;

  if(distance2dsquared(level.player.origin, var_0.origin) < var_0._id_EFC4 && scripts\sp\utility::_id_D1DF(var_0.origin + (0, 0, 45), 0.85)) {
    if(var_0._id_EFAC == "unlocked") {
      if(!isDefined(var_0._id_EFBF)) {
        var_0._id_EFBF = 1;
        level._id_EF98.alpha = 1;

        if(_id_EFA0(var_0)) {} else {}
      }

      if(_id_EFEE("BUTTON_X", 4)) {
        var_0._id_EFBF = undefined;
        level._id_EF98.alpha = 0;
        return 1;
      }
    } else
      return 1;
  } else if(isDefined(var_0._id_EFBF) && var_0._id_EFBF) {
    var_0._id_EFBF = undefined;
    level._id_EF98.alpha = 0;
  }

  var_1 = getaiarray();

  if(var_1.size > 0) {
    var_1 = sortbydistance(var_1, var_0.origin);

    if(isDefined(var_1[0]._id_EFB4) && var_1[0]._id_EFB4) {
      if(distance2dsquared(var_1[0].origin, var_0.origin) < var_0._id_EFC4 * 0.3)
        return 1;
    }
  }

  return 0;
}

_id_EFA0(var_0) {
  var_1 = scripts\sp\utility::_id_7951(var_0.origin, var_0.angles, level.player.origin);

  if(var_1 > 0)
    return 1;
  else
    return 0;
}

_id_EF9D() {
  level._id_EF98 = newhudelem();
  level._id_EF98.hidewheninmenu = 1;
  level._id_EF98.alignx = "center";
  level._id_EF98.foreground = 1;
  level._id_EF98.font = "objective";
  level._id_EF98.fontscale = 1.3;
  level._id_EF98.alpha = 0;
  level._id_EF98.x = 320;
  level._id_EF98.y = 345;
  level._id_EF98.color = (1, 1, 1);
}

_id_EF9A(var_0, var_1) {
  var_2 = level._id_EFA6[var_0];
  var_2._id_EFAC = var_1;
  var_2._id_EFAB = "";
  var_2 thread _id_EFA5(var_2._id_EFAC);
}

_id_EFA4(var_0, var_1) {
  var_2 = level._id_EFA6[var_0];
  var_2 endon("death");
  var_2._id_EFC6 = var_1;
}

_id_D1D1(var_0, var_1, var_2) {
  scripts\sp\anim::_id_1EC3(var_0, var_1);
  var_3 = level.player scripts\engine\utility::spawn_tag_origin();
  level.player _meth_823B(var_3, "tag_origin");
  var_3 moveTo(var_0 gettagorigin("tag_player"), var_2, 0.2, 0.2);
  var_3 rotateTo(var_0 gettagangles("tag_player"), var_2, 0.2, 0.2);
  var_3 waittill("movedone");
  var_3 delete();
  level.player _meth_823B(var_0, "tag_player");
}

_id_EFE5() {
  foreach(var_1 in level._id_EFE6)
  precacheshader(level._id_EFE2[var_1]._id_B416);

  foreach(var_1 in level._id_EFE6) {
    level._id_EFE2[var_1].script_noteworthy = "scs_locations_cleanup";

    if(isDefined(level._id_EFE2[var_1]._id_3935)) {
      level._id_EFE2[var_1]._id_D386 = level._id_EFE2[var_1] scripts\engine\utility::spawn_tag_origin();
      level._id_EFE2[var_1]._id_D386.origin = level._id_EFE2[var_1].origin + anglesToForward(level._id_EFE2[var_1].angles) * -32;
      waittillframeend;
      level._id_EFE2[var_1]._id_D386.origin = (level._id_EFE2[var_1]._id_D386.origin[0], level._id_EFE2[var_1]._id_D386.origin[1], level.player.origin[2]);
      level._id_EFE2[var_1]._id_D386.script_noteworthy = "scs_locations_cleanup";
      level._id_EFE2[var_1].trigger = spawn("trigger_radius", level._id_EFE2[var_1].origin, 0, 48, 48);
      level._id_EFE2[var_1].trigger.script_noteworthy = "scs_locations_cleanup";
      level._id_EFE2[var_1] thread _id_EFE9();
    }

    level._id_EFE2[var_1].active = 0;
    level._id_EFE2[var_1].icon = newhudelem();
    level._id_EFE2[var_1].icon setshader(level._id_EFE2[var_1]._id_B416, 1, 1);
    level._id_EFE2[var_1].icon setwaypoint(0, 1, 1);
    level._id_EFE2[var_1].icon settargetEnt(level._id_EFE2[var_1]);
    level._id_EFE2[var_1].icon.sort = 1;
    level._id_EFE2[var_1].icon.alpha = 0;
  }

  level notify("scs_locations_set");
}

_id_EFE3(var_0, var_1) {
  foreach(var_3 in level._id_EFE6) {
    if(var_3 == var_1) {
      if(var_0) {
        level._id_EFE2[var_3].active = 1;
        level._id_EFE2[var_3].icon.alpha = 0.5;
        continue;
      }

      level._id_EFE2[var_3].active = 0;
      level._id_EFE2[var_3].icon.alpha = 0;
    }
  }
}

_id_EFE9() {
  self endon("scs_locations_use_kill");

  for(;;) {
    while(isDefined(self.active) && self.active) {
      self.trigger waittill("trigger");
      self makeusable();
      thread _id_EFE7();
      self.icon.alpha = 0;

      while(level.player istouching(self.trigger))
        scripts\engine\utility::waitframe();

      if(isDefined(self.active) && self.active) {
        self makeunusable();
        self notify("scs_locations_use_enter_kill");
        self.icon.alpha = 0.5;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

_id_EFE7() {
  self endon("scs_locations_use_kill");
  self endon("scs_locations_use_enter_kill");
  self waittill("trigger");
  self makeunusable();
  level.player._id_C677 = self._id_D386 scripts\engine\utility::spawn_tag_origin();
  level.player._id_C677.origin = self._id_D386.origin + anglesToForward(self._id_D386.angles) * -24;
  level.player _meth_823C(self._id_D386, undefined, 0.5);
  wait 0.5;

  if(isDefined(self.usefunc))
    self[[self.usefunc]]();
}

_id_EFE8() {
  level.player _meth_823C(level.player._id_C677, undefined, 0.5);
  wait 0.5;
  level.player unlink();
  level.player._id_C677 delete();
}

_id_EFE4() {
  var_0 = getEntArray("scs_locations_cleanup", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 notify("scs_locations_use_kill");

  scripts\sp\utility::_id_228A(var_0);
}

_id_EFD0(var_0) {
  self._id_6084 = newhudelem();
  self._id_6084.hidewheninmenu = 1;
  self._id_6084.alignx = "center";
  self._id_6084.foreground = 1;
  self._id_6084.font = "objective";
  self._id_6084.fontscale = 1.3;
  self._id_6084.alpha = 0;
  self._id_6084.x = 320;
  self._id_6084.y = 345;
  self._id_6084.color = (1, 1, 1);
}

_id_EFD1() {
  level thread _id_EFEF();
  var_0 = getEntArray("scs_elevator", "script_noteworthy");

  if(var_0.size == 0) {
    return;
  }
  foreach(var_2 in var_0) {
    switch (var_2.classname) {
      case "script_brushmodel":
        if(isDefined(var_2._id_EE52) && var_2._id_EE52 == "elevator") {
          level._id_EFC8[var_2.script_parameters] = var_2;
          level._id_EFC8[var_2.script_parameters]._id_32D7 = 0;
          level._id_EFC8[var_2.script_parameters].locked = 0;
          level._id_EFC8[var_2.script_parameters]._id_D1DC = 0;
          level._id_EFC8[var_2.script_parameters]._id_BC8B = undefined;
          level._id_EFC8[var_2.script_parameters].doors = [];
        }

        break;
    }
  }

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_EE52) && var_2._id_EE52 == "collision") {
      level._id_EFC8[var_2.script_parameters].collision = var_2;
      level._id_EFC8[var_2.script_parameters].collision linkTo(level._id_EFC8[var_2.script_parameters]);
    }

    switch (var_2.classname) {
      case "trigger_multiple":
        level._id_EFC8[var_2.script_parameters].trigger = var_2;
        level._id_EFC8[var_2.script_parameters].trigger enablelinkTo();
        level._id_EFC8[var_2.script_parameters].trigger linkTo(level._id_EFC8[var_2.script_parameters]);
        var_5 = getEntArray("scs_elevator", "script_noteworthy");

        foreach(var_7 in var_5) {
          if(!isDefined(var_7._id_EE52)) {
            var_5 = scripts\engine\utility::array_remove(var_5, var_7);
            continue;
          }

          if(var_7._id_EE52 == "nav_island") {
            var_5 = scripts\engine\utility::array_remove(var_5, var_7);
            continue;
          }

          if(var_7._id_EE52 == "elevator") {
            var_5 = scripts\engine\utility::array_remove(var_5, var_7);
            continue;
          }

          if(var_7._id_EE52 == "trigger") {
            var_5 = scripts\engine\utility::array_remove(var_5, var_7);
            continue;
          }

          if(var_7._id_EE52 == "collision") {
            var_5 = scripts\engine\utility::array_remove(var_5, var_7);
            continue;
          }

          if(var_7._id_EE52 == "light")
            var_5 = scripts\engine\utility::array_remove(var_5, var_7);
        }

        foreach(var_7 in var_5) {
          if(var_7.script_parameters != var_2.script_parameters)
            var_5 = scripts\engine\utility::array_remove(var_5, var_7);
        }

        foreach(var_7 in var_5) {
          if(var_7.classname == "script_origin") {
            level._id_EFC8[var_2.script_parameters].doors[var_7._id_EE52] = var_7;
            level._id_EFC8[var_2.script_parameters].doors[var_7._id_EE52]._id_4284 = 0;
            var_5 = scripts\engine\utility::array_remove(var_5, var_7);
          }
        }

        foreach(var_7 in var_5)
        var_7 linkTo(level._id_EFC8[var_2.script_parameters].doors[var_7._id_EE52]);

        break;
      case "script_origin":
        if(!isDefined(var_2._id_EE52)) {
          level._id_EFC8[var_2.script_parameters].origin_ent = var_2;
          level._id_EFC8[var_2.script_parameters].origin_ent linkTo(level._id_EFC8[var_2.script_parameters]);
        }

        break;
      case "script_model":
        var_2 linkTo(level._id_EFC8[var_2.script_parameters]);
        break;
      case "light_spot":
        var_2 linkTo(level._id_EFC8[var_2.script_parameters]);
        break;
      default:
        break;
    }

    var_15 = getEntArray("scs_elevator", "script_noteworthy");

    foreach(var_17 in var_15) {
      if(!isDefined(var_17._id_EE52) || var_17._id_EE52 != "nav_island")
        var_15 = scripts\engine\utility::array_remove(var_15, var_17);
    }

    foreach(var_17 in var_15) {
      if(var_17.script_parameters != var_2.script_parameters)
        var_15 = scripts\engine\utility::array_remove(var_15, var_17);
    }

    var_15[0] linkTo(level._id_EFC8[var_2.script_parameters]);
    level._id_EFC8[var_2.script_parameters]._id_BE5F = var_15[0];
  }

  level._id_EFD2 = getarraykeys(level._id_EFC8);

  foreach(var_23 in level._id_EFD2) {
    if(isDefined(level._id_EFC8[var_23].doors)) {
      var_24 = getarraykeys(level._id_EFC8[var_23].doors);

      foreach(var_26 in var_24)
      level._id_EFC8[var_23].doors[var_26] thread _id_EFCE(var_23, var_26);
    }

    level._id_EFC8[var_23]._id_6F68 = scripts\engine\utility::getStructArray("scs_elevator_floor", "targetname");

    foreach(var_29 in level._id_EFC8[var_23]._id_6F68) {
      if(var_29.script_parameters != var_23)
        level._id_EFC8[var_23]._id_6F68 = scripts\engine\utility::array_remove(level._id_EFC8[var_23]._id_6F68, var_29);
    }

    level._id_EFC8[var_23]._id_6F68 = scripts\engine\utility::array_sort_with_func(level._id_EFC8[var_23]._id_6F68, ::_id_9B41);
    level._id_EFC8[var_23]._id_6F67 = [];

    foreach(var_32 in level._id_EFC8[var_23]._id_6F68)
    level._id_EFC8[var_23]._id_6F67 = scripts\engine\utility::array_add(level._id_EFC8[var_23]._id_6F67, var_32.script_noteworthy);

    level._id_EFC8[var_23]._id_2C3F = _id_0EFB::_id_7994("scs_elevator_bollards", "targetname", var_23);

    if(isDefined(level._id_EFC8[var_23]._id_2C3F) && level._id_EFC8[var_23]._id_2C3F.size > 0) {
      foreach(var_35 in level._id_EFC8[var_23]._id_2C3F) {
        var_35._id_5AF1 = var_35.origin;
        var_35._id_12D74 = var_35.origin + (0, 0, 42);
        var_35 thread _id_EFC9(var_23);
      }
    }

    _id_EFD5(var_23, level._id_EFC8[var_23]._id_6F67[0], 1, 0);
    level._id_EFC8[var_23] thread _id_EFD0(var_23);
    level._id_EFC8[var_23] thread _id_EFD9();
  }
}

_id_EFC9(var_0) {
  self moveTo(self._id_12D74, 0.05);

  for(;;) {
    var_1 = level._id_EFC8[var_0] scripts\engine\utility::waittill_any_return("doors_open", "doors_close");

    switch (var_1) {
      case "doors_open":
        if(level._id_EFC8[var_0]._id_4B10 == self.script_noteworthy)
          self moveTo(self._id_5AF1, 1.25);

        break;
      case "doors_close":
        self moveTo(self._id_12D74, 1.25);
        break;
    }
  }
}

_id_EFCE(var_0, var_1) {
  self linkTo(level._id_EFC8[var_0]);

  if(!isDefined(level._id_EFC8[var_0]._id_5A16))
    level._id_EFC8[var_0]._id_5A16 = 46;

  if(!isDefined(level._id_EFC8[var_0]._id_AEF5))
    level._id_EFC8[var_0]._id_AEF5 = [];

  for(;;) {
    self._id_AEF4 = 0;
    var_2 = level._id_EFC8[var_0] scripts\engine\utility::waittill_any_return("doors_open", "doors_close");
    level._id_EFC8[var_0]._id_32D7 = 1;

    switch (var_2) {
      case "doors_open":
        var_3 = getarraykeys(level._id_EFC8[var_0]._id_AEF5);

        foreach(var_5 in var_3) {
          var_6 = strtok(level._id_EFC8[var_0]._id_AEF5[var_5], ",");

          foreach(var_8 in var_6) {
            if(var_8 == getsubstr(var_1, 0, 1) && var_5 == level._id_EFC8[var_0]._id_4B10) {
              self._id_AEF4 = 1;
              self._id_9EC7 = 1;
            }
          }
        }

        if(!self._id_AEF4) {
          switch (var_1) {
            case "8":
            case "6":
            case "4":
            case "2":
              self _meth_826F((0, 0, 0), 0.4);
              break;
          }

          self._id_9EC7 = 0;
        }

        break;
      case "doors_close":
        if(!self._id_9EC7) {
          switch (var_1) {
            case "8":
            case "6":
            case "4":
            case "2":
              if(!self._id_4284)
                self _meth_826F((-89.99, 0, 0), 0.4);

              break;
          }
        }

        break;
    }

    wait 0.4;
    scripts\engine\utility::waitframe();
    level._id_EFC8[var_0]._id_32D7 = 0;
  }
}

_id_EFD9() {
  self._id_BC6E = 150;

  for(;;) {
    if(level.player istouching(self.trigger) && !self._id_D1DC || isDefined(self._id_BC8B)) {
      var_0 = scripts\engine\utility::array_find(self._id_6F67, self._id_4B10);

      if(var_0 == 0) {
        if(self._id_6084.alpha == 0)
          self._id_6084.alpha = 1;
      } else if(var_0 == self._id_6F67.size - 1) {
        if(self._id_6084.alpha == 0)
          self._id_6084.alpha = 1;
      } else if(self._id_6084.alpha == 0)
        self._id_6084.alpha = 1;

      if(_id_0EEB::_id_60EF() || _id_0EEB::_id_60EE() || isDefined(self._id_BC8B)) {
        var_1 = undefined;

        if(!isDefined(self._id_BC8B))
          var_1 = self._id_32DB;
        else
          var_1 = scripts\engine\utility::array_find(self._id_6F67, self._id_BC8B);

        self._id_BC8B = undefined;
        self._id_32DB = undefined;
        self notify("doors_close");
        self._id_6084.alpha = 0;
        self.collision show();
        self._id_BE5F _meth_83C9();
        thread _id_EFD7("start");
        _id_EFEB(self._id_6F68[var_1].origin - self.origin[2], self._id_BC6E);
        thread _id_EFD7("stop");
        self._id_4B10 = self._id_6F67[var_1];
        scripts\engine\utility::waitframe();
        self notify("doors_open");
        wait 0.4;
        self.collision hide();
        self._id_BE5F _meth_80AF(undefined);
        self notify("move_finished");
        level notify("elevator_finished");
      } else
        scripts\engine\utility::waitframe();

      scripts\engine\utility::waitframe();
    } else
      self._id_6084.alpha = 0;

    scripts\engine\utility::waitframe();
  }
}

_id_EFCD(var_0, var_1) {
  foreach(var_3 in level._id_EFC8[var_0].doors) {
    if(!var_3._id_4284)
      var_3 _meth_826F((-89.99, 0, 0), 0.01);
  }
}

_id_EFD8(var_0, var_1) {
  _id_EFDC(var_0)._id_FB2F = var_1;
}

_id_EFD7(var_0) {
  if(!isDefined(self._id_FB2F)) {
    return;
  }
  switch (var_0) {
    case "start":
      self playSound(self._id_FB2F["start"]);
      self playLoopSound(self._id_FB2F["start_loop"]);
      break;
    case "stop":
      self playSound(self._id_FB2F["stop"]);
      self stoploopsound();
      break;
  }
}

_id_EFD5(var_0, var_1, var_2, var_3) {
  var_4 = level._id_EFC8[var_0];

  while(!isDefined(var_4) || !isDefined(var_4._id_32D7) || var_4._id_32D7)
    scripts\engine\utility::waitframe();

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 1;

  if(var_2) {
    foreach(var_6 in var_4._id_6F68) {
      if(var_6.script_noteworthy == var_1) {
        _id_EFCD(var_0);

        if(var_3) {
          var_4.collision show();
          var_4._id_BE5F _meth_83C9();
        }

        var_4.origin = var_6.origin;
        var_4.collision hide();
        var_4._id_BE5F scripts\engine\utility::delaycall(0.05, ::_meth_80AF, undefined);
        var_4._id_4B10 = var_6.script_noteworthy;

        if(!var_4.locked)
          var_4 scripts\engine\utility::delaythread(0.05, scripts\sp\utility::_id_F225, "doors_open");
      }
    }
  } else
    var_4._id_BC8B = var_1;
}

_id_EFCA(var_0, var_1) {
  var_2 = level._id_EFC8[var_0];
  var_2._id_C38A = var_2._id_BC6E;
  var_2._id_BC6E = var_1;
}

_id_EFCB(var_0) {
  var_1 = level._id_EFC8[var_0];
  var_1._id_BC6E = var_1._id_C38A;
}

_id_EFDC(var_0) {
  return level._id_EFC8[var_0];
}

_id_EFD4(var_0, var_1, var_2) {
  _id_EFDC(var_0)._id_AEF5[var_1] = var_2;
}

_id_EFD6(var_0, var_1) {
  _id_EFDC(var_0)._id_D1DC = var_1;
}

_id_EFD3(var_0, var_1) {}

_id_EFEE(var_0, var_1) {
  var_1 = var_1 * 50;
  var_2 = gettime();

  if(var_0 == "BUTTON_X") {
    while(level.player useButtonPressed()) {
      if(gettime() - var_2 >= var_1)
        return 1;

      scripts\engine\utility::waitframe();
    }
  } else {
    while(level.player buttonPressed(var_0)) {
      if(gettime() - var_2 >= var_1)
        return 1;

      scripts\engine\utility::waitframe();
    }
  }

  return 0;
}

_id_EFCC() {
  foreach(var_1 in level._id_EFD2) {}
}

_id_9B41(var_0, var_1) {
  return var_0.origin[2] > var_1.origin[2];
}

_id_EFEB(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5 = abs(var_0 / var_1);
  self movez(var_0, var_5, var_5 * 0.1, var_5 * 0.3);
  wait(var_5);
}

_id_EFE1() {
  scripts\engine\utility::waitframe();
  var_0 = undefined;
  var_1 = getEntArray("script_model", "classname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_parameters) && var_3.script_parameters == "skel") {
      var_0 = var_3;
      break;
    }
  }

  var_5 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_5.origin = self gettagorigin("hydrolics_3");
  var_5.origin = var_5.origin + (0, 0, 154);
  var_5.origin = var_5.origin + anglesToForward(var_5.angles) * 180;
  var_0.origin = var_5.origin;
  var_5 linkTo(self, "hydrolics_3");
  var_0 linkTo(var_5);
  var_6 = scripts\engine\utility::getStruct("aurora_launch_bay_1_move", "targetname");
  var_7 = scripts\engine\utility::getStruct("aurora_launch_bay_1_look", "targetname");
  scripts\sp\anim::_id_1F35(self, "launch_sequence_platform_to_board");

  for(;;) {
    level thread _id_EFD5("return", "Service Level", 1);
    thread scripts\sp\anim::_id_1F35(self, "launch_sequence_platform_to_tube");
    wait 7;
    wait 1;
    level waittill("foo");
    level waittill("notify_return_control");
  }
}

_id_EF90(var_0, var_1) {
  level._id_EF8D[var_0] = spawnStruct();
  var_2 = _id_0EFB::_id_7994("scs_bink_fit", "targetname", var_0);
  var_3 = _id_0EFB::_id_7994("scs_bink_grid", "targetname", var_0);
  level._id_EF8D[var_0]._id_ECCF = scripts\engine\utility::array_combine(var_2, var_3);
  level thread _id_EF8F(var_0, "grid");
  setsaveddvar("bg_cinematicFullScreen", "0");

  if(!isDefined(var_1))
    cinematicingameloopresident("default");
  else
    cinematicingameloopresident(var_1);
}

_id_EF8E(var_0, var_1, var_2, var_3) {
  _id_EF8F(var_0, var_1);
  setsaveddvar("bg_cinematicFullScreen", "0");
  wait 2;

  if(isDefined(var_3) && var_3)
    cinematicingameloopresident(var_2);
  else {
    cinematicingame(var_2);

    while(iscinematicplaying())
      scripts\engine\utility::waitframe();

    stopcinematicingame();
  }
}

_id_EF8F(var_0, var_1) {
  foreach(var_3 in level._id_EF8D[var_0]._id_ECCF)
  var_3 hide();

  foreach(var_3 in level._id_EF8D[var_0]._id_ECCF) {
    if(var_3.targetname == "scs_bink_" + var_1)
      var_3 show();
  }
}

_id_EFEC(var_0) {
  level._id_C37A = getDvar("bg_cinematicCanPause");
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame(var_0);

  while(!iscinematicplaying())
    scripts\engine\utility::waitframe();

  while(iscinematicplaying())
    scripts\engine\utility::waitframe();

  stopcinematicingame();
  setsaveddvar("bg_cinematicCanPause", level._id_C37A);
}

_id_68D3(var_0, var_1) {
  _id_0BDC::_id_A153(1);
  _id_0BDB::_id_BBD0(1, var_0, var_1, var_0, var_1);
  level.player _meth_8391(0);
}

_id_F93C(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  _id_5545();
  _id_BC55(self, "tag_player");
  self _meth_848E(1);
  _id_FA0C(var_2);
  _id_F93D(var_0, var_1);
  level.player _meth_8391(0.05);
  thread _id_5541();
}

_id_68D1(var_0, var_1) {
  _id_68D2(var_0, var_1);
  _id_620D();
}

_id_BC55(var_0, var_1) {
  var_2 = self gettagorigin("tag_player");
  var_3 = self gettagangles("tag_player");
  level.player setOrigin(var_2);
  level.player setplayerangles(var_3);
}

_id_FA0C(var_0) {
  _id_0BDB::_id_107A1();
  level.player _meth_823C(self._id_AD34, "tag_origin", 0);
  scripts\engine\utility::waitframe();

  if(isDefined(var_0) && var_0)
    level.player _meth_823B(self._id_AD34, "tag_origin");
  else {
    level.player playerlinktodelta(self._id_AD34, "tag_origin", 1, 40, 40, 20, 15, 1);
    level.player _meth_8392(1, 2.2, 0.6);
  }
}

_id_5545() {
  level.player freezecontrols(1);
  level.player _meth_818A();
}

_id_620D() {
  level.player unlink();
  level.player showviewmodel();
  level.player freezecontrols(0);
}

_id_F93D(var_0, var_1) {
  _id_0BDC::_id_A2DE(1, 0.2);
  _id_F760(var_0, var_1);
}

_id_F760(var_0, var_1) {
  self setanimknob(var_0, 1, 0);
  self _meth_82A2(var_1, 1, 0);
  self _meth_82B1(var_0, 0);
  self _meth_82B1(var_1, 0);
}

_id_5541() {
  _id_0BDC::_id_104A6(0);
  scripts\engine\utility::waitframe();
  self waittill("end_jackal_interact");
  scripts\engine\utility::waitframe();
  _id_0BDC::_id_104A6(0);
}

_id_68D2(var_0, var_1) {
  _id_A13C(var_0);
  thread _id_CE74(var_1);
  _id_CDC3(var_0);
}

_id_CE74(var_0) {
  _id_CD5F(var_0);
  _id_F763(var_0);
}

_id_CDC3(var_0) {
  thread _id_5694();
  _id_CD5D(var_0);
}

_id_A13C(var_0) {
  var_1 = _id_0BDB::_id_A2C1;
  var_2 = _id_0BDB::_id_A2C2;
  var_3 = _id_0BDB::_id_BBDF;
  var_4 = _id_0BDB::_id_568F;
  var_5 = _id_0BDC::_id_A226;
  var_6 = _id_0BDC::_id_A10F;
  thread _id_0BDB::_id_1EC6(var_0, "hud_off", var_6, 1);
  thread _id_0BDB::_id_1EC6(var_0, "hud_off", var_5, 1);
  thread _id_0BDB::_id_1EC6(var_0, "lights_off", var_3, 1);
  thread _id_0BDB::_id_1EC6(var_0, "engine_off", var_4, 1);
}

_id_CDC6(var_0, var_1, var_2, var_3) {
  _id_CDC5(var_1, var_2);
  scripts\engine\utility::flag_set(var_3);
}

_id_CDC5(var_0, var_1) {
  _id_CD5D(var_0);
  thread _id_CD5D(var_1);
}

#using_animtree("jackal");

_id_CD5D(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = % shipcrib_pilot;

  if(!isDefined(var_2))
    var_2 = 0.2;

  self clearanim(var_1, var_2);
  var_3 = "single anim";
  self _meth_82E2(var_3, var_0, 10, var_2, 1);
  thread scripts\sp\anim::_id_10CBF(self, var_3);
  var_4 = getanimlength(var_0);
  wait(var_4);
}

_id_CD5F(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0.2;

  self _meth_82A2(var_0, 1, var_1, 1);
  var_2 = getanimlength(var_0);
  wait(var_2);
}

_id_F763(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0.2;

  self _meth_82A2(var_0, 1, var_1, 1);
  self _meth_82B0(var_0, 0.8);
  self _meth_82B1(var_0, 0);
}

_id_CC6B(var_0, var_1) {
  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      if(var_3 _id_1FA3(var_1))
        thread scripts\sp\anim::_id_1F35(var_3, var_1);
    }
  }
}

_id_5694() {
  if(isDefined(scripts\engine\utility::getStruct("jackal_return_a_exit", "targetname"))) {
    var_0 = 4.5;
    var_1 = undefined;

    switch (level.script) {
      case "shipcrib_moon":
        var_0 = undefined;
        break;
      case "shipcrib_europa":
        var_0 = undefined;
        break;
      case "shipcrib_titan":
        var_0 = undefined;
        break;
      case "shipcrib_gravity":
        var_0 = 14;
        var_1 = 48;
        break;
      default:
        break;
    }

    if(isDefined(var_0)) {
      var_2 = scripts\engine\utility::getStruct("jackal_return_a_exit", "targetname");
      wait(var_0);
      level.player unlink();

      if(isDefined(var_1)) {
        level.player setOrigin(var_2.origin + anglesToForward(var_2.angles) * var_1);
        level.player setplayerangles(var_2.angles);
      } else
        scripts\sp\utility::_id_11633(var_2);
    }
  }
}

_id_CE73(var_0, var_1, var_2) {
  self endon("death");

  if(!scripts\engine\utility::flag_exist("load_valet_anims")) {
    _id_AE0F();
    scripts\engine\utility::flag_init("load_valet_anims");
  }

  if(!isDefined(var_0))
    var_0 = _id_0EE1::_id_7C10("a");

  if(!isDefined(var_1))
    var_1 = "entrance";

  var_3 = var_0._id_A056;
  self._id_A071 = scripts\engine\utility::spawn_tag_origin(var_3.origin, var_3.angles);
  self._id_A071 linkTo(var_3, "tag_origin", (-20, -2, -7), (0, 0, 0));
  var_4 = _id_7D36(var_0);

  switch (var_1) {
    case "entrance":
      self linkTo(self._id_A071);
      var_5 = scripts\sp\utility::_id_7ECF(var_4["enter"]);
      scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_5, 0.57);
      self._id_A071 scripts\sp\anim::_id_1EC7(self, var_4["enter"]);
    case "idle":
      self._id_A071 thread scripts\sp\anim::_id_1ECC(self, var_4["idle"], "stop_loop");
      scripts\engine\utility::flag_wait(var_2);
      var_0 _id_B0D6();
  }
}

_id_7D36(var_0) {
  var_1 = [];
  var_2 = _id_0EE1::_id_7C10("a");
  var_3 = _id_0EE1::_id_7C10("b");

  if(var_0 == var_2) {
    var_1["enter"] = "service_jackal_enter_left";
    var_1["idle"] = "service_jackal_idle_left";
  } else if(var_0 == var_3) {
    var_1["enter"] = "service_jackal_enter_right";
    var_1["idle"] = "service_jackal_idle_right";
  }

  return var_1;
}

_id_B0D6() {
  self movez(-118, 20, 1, 5);
  self playSound("scn_ship_titan_jackal_lower_start");
  self playLoopSound("scn_ship_titan_jackal_lower_lp");
  scripts\engine\utility::delaycall(20, ::stoploopsound);
  scripts\engine\utility::delaycall(20, ::playsound, "scn_ship_titan_jackal_lower_stop");
}

_id_AE0F() {}

#using_animtree("script_model");

_id_A25C(var_0, var_1) {
  thread _id_A25F();
  thread _id_A25D(var_1);

  switch (var_0) {
    case "unload":
      self moveTo(self._id_12BC9, var_1);
      self _meth_82AB(%jackal_loading_gantry_raised, 1, var_1);
      self _meth_82AB(%jackal_loading_gantry_jackal_load_center, 1, var_1);
      break;
    case "unload_ground":
      self moveTo(self._id_B450, var_1);
      self _meth_82AB(%jackal_loading_gantry_lowered, 1, var_1);
      self _meth_82AB(%jackal_loading_gantry_jackal_load_center, 1, var_1);
      break;
    case "max_lowered":
      self _meth_82AB(%jackal_loading_gantry_lowered, 1, var_1);
      break;
    case "max_raised":
      self _meth_82AB(%jackal_loading_gantry_raised, 1, var_1);
      break;
    case "jackal_load_left":
      self moveTo(self._id_A2CA, var_1);
      self _meth_82AB(%jackal_loading_gantry_lowered_load, 1, var_1);
      self _meth_82AB(%jackal_loading_gantry_jackal_load_left, 1, var_1);
      break;
    case "jackal_load_right":
      self moveTo(self._id_A2CA, var_1);
      self _meth_82AB(%jackal_loading_gantry_lowered_load, 1, var_1);
      self _meth_82AB(%jackal_loading_gantry_jackal_load_right, 1, var_1);
      break;
    case "jackal_load_center":
      self moveTo(self._id_A2CA, var_1);
      self _meth_82AB(%jackal_loading_gantry_lowered_load, 1, var_1);
      self _meth_82AB(%jackal_loading_gantry_jackal_load_center, 1, var_1);
      break;
  }

  wait(var_1);
}

_id_A25E() {
  level endon("jackal_loading_gantries_stop");
  self endon("jackal_loading_gantry_stop_random");
  self endon("death");
  var_0 = ["unload", "max_raised", "jackal_load_left", "jackal_load_right", "jackal_load_center"];
  self._id_7692 = "";

  for(;;) {
    var_1 = randomfloatrange(7, 12);
    var_2 = randomfloatrange(1, 2);
    var_3 = var_0[randomint(var_0.size)];

    if(var_3 == self._id_7692) {
      continue;
    }
    self._id_7692 = var_3;
    _id_A25C(var_3, var_1);
    wait(var_1 + var_2);
  }
}

_id_A25D(var_0) {
  self endon("death");
  self playSound("ship_titan_sm_crane_start");
  self playLoopSound("ship_titan_sm_crane_loop");
  wait(var_0);
  self stoploopsound();
  self playSound("ship_titan_sm_crane_stop");
}

_id_A25F() {
  self endon("death");

  if(isDefined(self._id_13352)) {
    return;
  }
  self._id_13352 = 1;
  var_0 = getnumparts(self.model);

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = getpartname(self.model, var_1);

    if(getsubstr(var_2, 0, 9) == "tag_light")
      scripts\engine\utility::noself_delaycall(randomfloatrange(0, 0.3), ::playfxontag, scripts\engine\utility::getfx("red_light"), self, var_2);
  }
}

_id_E39A() {
  _id_0EFB::_id_E3F7();
  var_0 = ["dropship_bay_1", "dropship_bay_2"];

  foreach(var_2 in var_0) {
    level._id_E35D._id_AA5F[var_2] = spawnStruct();
    var_3 = _id_0EFB::_id_7991(var_2, "script_noteworthy", "door_1");
    level._id_E35D._id_AA5F[var_2]._id_5979 = var_3[0];
    var_3 = scripts\engine\utility::array_remove(var_3, var_3[0]);
    scripts\engine\utility::array_call(var_3, ::linkto, level._id_E35D._id_AA5F[var_2]._id_5979);
    level._id_E35D._id_AA5F[var_2]._id_597A = _id_0EFB::_id_798A(var_2, "script_noteworthy", "door_2");
    level._id_E35D._id_AA5F[var_2]._id_597C = _id_0EFB::_id_798A(var_2, "script_noteworthy", "door_3");
    level._id_E35D._id_AA5F[var_2]._id_5979._id_4291 = level._id_E35D._id_AA5F[var_2]._id_5979.origin;
    level._id_E35D._id_AA5F[var_2]._id_597A._id_4291 = level._id_E35D._id_AA5F[var_2]._id_597A.origin;
    level._id_E35D._id_AA5F[var_2]._id_597C._id_4291 = level._id_E35D._id_AA5F[var_2]._id_597C.origin;
    level._id_E35D._id_AA5F[var_2]._id_5979._id_C630 = level._id_E35D._id_AA5F[var_2]._id_5979._id_4291 + (0, 0, -320);
    level._id_E35D._id_AA5F[var_2]._id_597A._id_C630 = level._id_E35D._id_AA5F[var_2]._id_597A._id_4291 + (0, 0, -320);
    level._id_E35D._id_AA5F[var_2]._id_597C._id_C630 = level._id_E35D._id_AA5F[var_2]._id_597C._id_4291 + (0, 0, -320);
  }
}

_id_E399(var_0, var_1) {
  var_0 endon("death");

  if(!isDefined(var_1))
    var_1 = 5;

  var_0 moveTo(var_0._id_C630, var_1);
  wait(var_1);
}

_id_E398(var_0, var_1) {
  var_0 endon("death");

  if(!isDefined(var_1))
    var_1 = 5;

  var_0 moveTo(var_0._id_4291, var_1);
  wait(var_1);
}

_id_E3B4(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_0EFB::_id_7994(var_0, "targetname", var_1);

  foreach(var_8 in var_6) {
    var_8._id_BCDA = getEnt(var_8.target, "targetname");
    var_8 linkTo(var_8._id_BCDA);
  }

  if(var_3 == "rotate") {
    foreach(var_8 in var_6) {
      switch (var_8.script_noteworthy) {
        case "top":
          var_8._id_BCDA rotateTo(var_8._id_BCDA.angles + (var_4, 0, 0), var_5);
          break;
        case "bottom":
          var_8._id_BCDA rotateTo(var_8._id_BCDA.angles + (var_4 * -1, 0, 0), var_5);
          break;
      }
    }
  } else {
    foreach(var_8 in var_6) {
      switch (var_8.script_noteworthy) {
        case "top":
          var_8._id_BCDA moveTo(var_8._id_BCDA.origin + (0, 0, var_4), var_5);
          break;
        case "bottom":
          var_8._id_BCDA moveTo(var_8._id_BCDA.origin + (0, 0, var_4 * -1), var_5);
          break;
      }
    }
  }

  wait(var_5);

  switch (var_2) {
    case "open":
      scripts\engine\utility::array_call(var_6, ::connectpaths);
      break;
    case "close":
      scripts\engine\utility::array_call(var_6, ::disconnectpaths);
      break;
  }
}

_id_E385() {
  level _id_0EFB::_id_E3F7();
  level._id_E35D._id_4020 = [];
  var_0 = getEntArray("shipcrib_claxon_model_on", "targetname");

  foreach(var_2 in var_0) {
    var_2 _meth_83D0(#animtree);
    var_2.lights = [];
    var_3 = getEntArray(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      if(var_5._id_EE52 == "light") {
        var_5 linkTo(var_2, "j_spin");

        if(level.script == "shipcrib_moon")
          var_5 _meth_8300(200);

        var_2.lights[var_2.lights.size] = var_5;
      }

      if(var_5._id_EE52 == "model_off")
        var_2._id_B917 = var_5;
    }

    if(!isDefined(level._id_E35D._id_4020[var_2.script_noteworthy])) {
      level._id_E35D._id_4020[var_2.script_noteworthy] = spawnStruct();
      level._id_E35D._id_4020[var_2.script_noteworthy]._id_B927 = [];
    }

    var_7 = level._id_E35D._id_4020[var_2.script_noteworthy]._id_B927;
    var_7[var_7.size] = var_2;
    level._id_E35D._id_4020[var_2.script_noteworthy]._id_B927 = var_7;
  }

  var_9 = getarraykeys(level._id_E35D._id_4020);

  foreach(var_11 in var_9)
  level thread _id_E388(var_11, 0);
}

_id_E389(var_0) {
  foreach(var_2 in level._id_E35D._id_4020[var_0]._id_B927) {
    var_2 show();
    var_2._id_B917 hide();

    if(isDefined(var_2.script_fxid))
      playFXOnTag(scripts\engine\utility::getfx(var_2.script_fxid), var_2, "j_spin");

    foreach(var_4 in var_2.lights) {
      var_4 _meth_82FC((1, 0.085294, 0.03137));
      var_4 thread scripts\sp\lights::_id_AB83(var_4.script_intensity_01, 1);
    }

    var_2 _meth_82A2(%claxon_spin_loop);
  }
}

_id_E388(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  foreach(var_3 in level._id_E35D._id_4020[var_0]._id_B927)
  var_3 thread _id_401F(var_1);
}

_id_401F(var_0) {
  self clearanim(%claxon_spin_loop, 0.5);

  if(var_0)
    wait 0.5;

  if(isDefined(self.script_fxid))
    killfxontag(scripts\engine\utility::getfx(self.script_fxid), self, "j_spin");

  self hide();
  self._id_B917 show();

  foreach(var_2 in self.lights)
  var_2 thread scripts\sp\lights::_id_AB83(0, 1);
}

_id_86E8(var_0) {
  if(self._id_1FBB == "player_rig") {
    self detach(getweaponmodel(level.player getcurrentprimaryweapon()), "tag_weapon_right");
    var_1 = spawn("script_model", self gettagorigin("tag_weapon_right"));
    var_1.angles = self gettagangles("tag_weapon_right");
    var_1 setModel(getweaponmodel(level.player getcurrentprimaryweapon()));
    self._id_110C9 = var_1;

    if(isDefined(var_0))
      var_1 linkTo(var_0);
  } else {
    self._id_86E9 = 1;
    scripts\sp\utility::_id_86E4();
    var_1 = spawn("script_model", self gettagorigin("tag_weapon_right"));
    var_1.angles = self gettagangles("tag_weapon_right");
    self._id_110C9 = var_1;
    var_1 setModel(getweaponmodel(self.weapon));

    if(isDefined(var_0))
      var_1 linkTo(var_0);
  }
}

_id_86D3(var_0) {
  if(self._id_1FBB == "player_rig")
    self attach(getweaponmodel(level.player getcurrentprimaryweapon()), "tag_weapon_right");
  else {
    self._id_110C9 delete();
    scripts\sp\utility::_id_86E2();
  }
}

_id_FE0D(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_3 = 16384;
  else
    var_3 = var_0 * var_0;

  if(!isDefined(var_1))
    var_1 = (0, 0, 50);

  if(!isDefined(var_2))
    var_2 = 0.85;

  for(;;) {
    var_4 = distance2dsquared(self.origin, level.player.origin);
    var_5 = self.origin + (0, 0, -60);

    if(var_4 < var_3 || scripts\sp\utility::_id_D1DF(var_5, 0.85, 1)) {
      break;
    } else
      scripts\engine\utility::waitframe();
  }
}

_id_8ADE(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1))
    scripts\sp\utility::_id_F492(var_1);

  scripts\sp\utility::_id_F3E0(128);
  self setgoalpos(var_0.origin);
  self waittill("goal");
  scripts\engine\utility::waitframe();

  for(var_2 = _id_0EFB::_id_7D7A(var_0.target); isDefined(var_2); var_2 = _id_0EFB::_id_7D7A(var_2.target)) {
    if(!isDefined(_id_0EFB::_id_7D7A(var_2.target))) {
      _id_0B6A::_id_EC0A(var_2);
      break;
    }

    scripts\sp\utility::_id_F3E0(128);
    self setgoalpos(var_2.origin);
    self waittill("goal");
    scripts\engine\utility::waitframe();
  }

  wait(randomfloatrange(5, 10));
  thread _id_FE0F();
}

_id_8ADF() {
  self endon("death");
  self endon("stop_gesture");

  for(;;)
    wait 1;
}

_id_FE0F() {
  if(!isDefined(level._id_FD6E._id_138D9)) {
    _id_0EFB::_id_FE05();
    level._id_FD6E._id_138D9 = [];

    foreach(var_1 in level.struct) {
      if(isDefined(var_1.script_parameters) && var_1.script_parameters == "shipcrib_wanderer")
        level._id_FD6E._id_138D9 = scripts\engine\utility::array_add(level._id_FD6E._id_138D9, var_1);
    }

    var_3 = getEntArray();

    foreach(var_5 in var_3) {
      if(isDefined(var_5.script_parameters) && var_5.script_parameters == "shipcrib_wanderer")
        level._id_FD6E._id_138D9 = scripts\engine\utility::array_add(level._id_FD6E._id_138D9, var_5);
    }

    foreach(var_8 in level._id_FD6E._id_138D9)
    var_8._id_FE0E = 0;
  }

  thread _id_FE10();
}

_id_FE10() {
  self endon("death");

  for(;;) {
    var_0 = _id_7C61(self, 1024);
    _id_0B6A::_id_EC0A(var_0);
    wait(randomfloatrange(15, 30));
    var_0._id_FE0E = 0;
  }
}

_id_7C61(var_0, var_1) {
  var_0 endon("death");

  if(isDefined(var_1))
    var_1 = squared(var_1);

  for(;;) {
    var_2 = level._id_FD6E._id_138D9[randomint(level._id_FD6E._id_138D9.size)];

    if(!var_2._id_FE0E) {
      if(isDefined(var_1) && distance2dsquared(self.origin, var_2.origin) > var_1) {
        if(randomint(20) != 1)
          continue;
      }

      var_2._id_FE0E = 1;
      return var_2;
    } else
      scripts\engine\utility::waitframe();
  }
}

_id_984E() {
  level._id_A18C = [];
  var_0 = getEntArray("jackal_bridge", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy)) {
      level._id_A18C[var_2.script_noteworthy] = var_2;
      level._id_A18C[var_2.script_noteworthy]._id_9F14 = 0;
      level._id_A18C[var_2.script_noteworthy]._id_CFCC = getEnt(var_2.script_noteworthy + "_clip", "targetname");
      level._id_A18C[var_2.script_noteworthy]._id_CFCC hide();

      if(isDefined(var_2.script_index))
        level._id_A18C[var_2.script_noteworthy]._id_00F2 = var_2.script_index;
      else
        level._id_A18C[var_2.script_noteworthy]._id_00F2 = 1;

      _id_AD07(var_2.script_noteworthy);
    }
  }
}

_id_B0D7(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = _id_7A61(var_0);

  if(var_2._id_9F14)
    var_2 _id_CCAF(var_1);
}

_id_DC44(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = _id_7A61(var_0);

  if(!var_2._id_9F14)
    var_2 _id_CCB0(var_1);
}

_id_7A61(var_0) {
  return level._id_A18C[var_0];
}

_id_AD07(var_0) {
  var_1 = getEnt(var_0, "script_noteworthy");
  var_2 = getEnt(var_0 + "_brushes", "targetname");
  var_3 = getEnt(var_0 + "_joint", "targetname");
  var_4 = getEnt(var_0 + "_rail", "targetname");
  var_2 linkTo(var_1);
  var_3 linkTo(var_1);
  var_4 linkTo(var_1);
  var_1._id_CFCC hide();
}

_id_CCB0(var_0) {
  var_1 = 10;

  if(var_0)
    var_1 = 0.05;

  self._id_CFCC show();
  self rotateroll(self._id_00F2 * 90, var_1, var_1 * 0.05, var_1 * 0.05);

  if(!var_0) {
    self playSound("shipcrib_catwalk_flap_start");
    thread scripts\engine\utility::play_loop_sound_on_entity("shipcrib_catwalk_flap_loop");
    wait(var_1);
    thread scripts\engine\utility::stop_loop_sound_on_entity("shipcrib_catwalk_flap_loop");
    self playSound("shipcrib_catwalk_flap_stop");
  }
}

_id_CCAF(var_0) {
  var_1 = 5;

  if(var_0)
    var_1 = 0.05;

  self._id_CFCC hide();
  self rotateroll(self._id_00F2 * -90, var_1, 0.5, 0.5);

  if(!var_0) {
    self playSound("shipcrib_catwalk_flap_start");
    thread scripts\engine\utility::play_loop_sound_on_entity("shipcrib_catwalk_flap_loop");
    wait(var_1);
    thread scripts\engine\utility::stop_loop_sound_on_entity("shipcrib_catwalk_flap_loop");
    self playSound("shipcrib_catwalk_flap_stop");
  }
}

_id_5B63() {
  var_0 = 60;

  for(var_1 = 0; var_1 < var_0; var_1 = var_1 + 0.5) {
    scripts\engine\utility::draw_angles(self.angles, self.origin, (0, 0, 255), 60);
    wait 0.5;
  }
}

_id_6E5D(var_0) {
  while(scripts\engine\utility::flag(var_0) || scripts\engine\utility::flag("in_vr_mode") || scripts\engine\utility::flag("at_terminal") || scripts\engine\utility::flag("at_fullscreen_opsmap")) {
    scripts\engine\utility::waitframe();
    scripts\engine\utility::flag_waitopen(var_0);
  }
}

_id_6E5E(var_0) {
  while(scripts\engine\utility::flag(var_0) || scripts\engine\utility::flag("in_vr_mode") || scripts\engine\utility::flag("at_terminal") || scripts\engine\utility::flag("at_fullscreen_opsmap"))
    level scripts\engine\utility::waittill_any(var_0, "in_vr_mode", "at_terminal", "at_fullscreen_opsmap");
}

_id_86E3() {
  scripts\anim\shared::placeweaponon(self.secondaryweapon, "back");
}

_id_1FA3(var_0) {
  if(isDefined(level._id_EC85[self._id_1FBB][var_0]))
    return 1;
  else
    return 0;
}

_id_FD88() {
  level.player endon("death");
  _id_0EFB::_id_FE05();

  if(!isDefined(level._id_FD6E._id_111D6))
    level._id_FD6E._id_111D6 = 4;

  level thread _id_0EFB::_id_FDBD(0, 0.05);
  scripts\engine\utility::waitframe();

  for(;;) {
    scripts\engine\utility::flag_wait(level.script + "_exterior_tr_loaded");
    level thread _id_0EFB::_id_FDBD(level._id_FD6E._id_111D6, 0.05);
    level._id_E35D._id_6A38 thread _id_0B51::_id_100DD();
    scripts\engine\utility::flag_waitopen(level.script + "_exterior_tr_loaded");
    level thread _id_0EFB::_id_FDBD(0, 0.05);
    level._id_E35D._id_6A38 thread _id_0B51::_id_8E84();
  }
}

_id_A919() {
  var_0 = level.player _meth_84C6("lastCompletedMission");

  if(isDefined(var_0)) {
    var_1 = strtok(var_0, "_");

    if(var_1.size > 0) {
      if(var_1[0] == "sa" || var_1[0] == "ja")
        return var_0;
      else {
        level.player _meth_84C7("lastCompletedMission", "sa_assassination");
        return "sa_assassination";
      }
    }
  } else
    return "sa_assassination";
}

_id_FDD5() {}

_id_FDA1() {
  var_0 = spawnStruct();
  var_0._id_D375 = "veh_mil_air_un_jackal_02_player";
  var_0._id_13DCB = "veh_mil_air_un_jackal_02";
  level.vehicle._id_116CE._id_13265["script_vehicle_jackal_fake_friendly"] = var_0;
  level.vehicle._id_116CE._id_13265["script_vehicle_jackal_friendly"] = var_0;
  precachemodel("veh_mil_air_un_jackal_02_player");
}

_id_D21E() {
  var_0 = getEntArray("player_kill", "targetname");
  var_1 = getEntArray("kill_player", "targetname");

  foreach(var_3 in var_0) {
    if(isDefined(var_3))
      var_3 thread _id_12FD();
  }

  foreach(var_3 in var_1) {
    if(isDefined(var_3))
      var_3 thread _id_12FD();
  }
}

_id_12FD() {
  level.player endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(isPlayer(var_0)) {
      level.player _meth_80A1();
      level.player _meth_81D0();
    }
  }
}