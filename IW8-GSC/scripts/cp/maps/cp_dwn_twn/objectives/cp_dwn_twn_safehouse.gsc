/**************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_safehouse.gsc
**************************************************************************/

function main() {
  level.safehouse_obj_func = &safehouse_obj_func;
}

function safehouse_obj_func() {
  level endon("game_ended");
  scripts\engine\utility::flag_init("ml_p3_done");
  scripts\engine\utility::flag_init("mission_ready");
  scripts\engine\utility::flag_init("safehouse_return_exit");
  scripts\engine\utility::flag_init("safehouse_door_open");
  scripts\engine\utility::flag_init("return_to_safehouse");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_downtown_cs_completed");
  scripts\cp\cp_objectives::registerobjective("safehouse_mnu", undefined, undefined, undefined, undefined, &debug_safehouse_start);
  scripts\cp\cp_objectives::registerobjective("safehouse", undefined, &start_safehouse, undefined, &debugbeatobjective, &debugbeatobjective);
  scripts\cp\cp_objectives::registerobjective("safehouse_gunshop", &tango_infil_radio_idle, &ref_137f6, undefined, &debugbeatobjective, &isprophunt);
  level.default_player_spawns = "safehouse_1_playerstart";
  level.initlocs_bunkertest = scripts\engine\utility::getStructArray("safehouse_1_playerstart", "targetname");
  level thread scripts\mp\vehicles\vehicle_damage_mp::ref_12e57();
}

function debugbeatobjective(var_0) {}

function debug_safehouse_start(var_0) {
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_downtown_cs_completed");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "safehouse_1_playerstart");
  thread start_safehouse_objective();
}

function debug_safehouse_return_start(var_0) {
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_downtown_cs_completed");
  scripts\engine\utility::flag_set("cp_dwn_twn_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_create_script_completed");
  scripts\engine\utility::flag_set("cp_dwn_twn_bank_vehicle_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_bank_vehicle_create_script_completed");
  scripts\engine\utility::flag_wait("objectives_registered");
  level.ref_12e58 = 1;
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_debug_start");
  scripts\engine\utility::flag_set("ml_p3_done");
  wait 3;
}

function isprophunt(var_0) {
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_downtown_cs_completed");
  scripts\engine\utility::flag_set("cp_dwn_twn_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_create_script_completed");
  scripts\engine\utility::flag_set("cp_dwn_twn_bank_vehicle_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_bank_vehicle_create_script_completed");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "safehouse_gunshop_playerstart");
}

function start_safehouse_objective() {
  wait 3;
  scripts\cp\cp_objectives::run_objective("safehouse", "primary");
}

function start_safehouse(var_0) {
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_downtown_cs_completed");
  level thread scripts\cp\intel\cp_intel::init_intel_pieces("launderer");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13bc2(1);
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  level.ref_139b5 = 1;
  thread scripts\mp\vehicles\vehicle_damage_mp::molotov_get_pool_level_data(scripts\engine\utility::getStruct("dwn_twn_safehouse_loadout", "targetname"));
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_12e56(getEntArray("dwn_twn_safehouse_loot", "targetname"));
  thread scripts\mp\brclientmatchdata::getnextrpgspawnmodule("justreward", "safehouse_door_open", 10, 1);

  if(getdvarint("vo_done") < 1) {
    ref_12e5f();
    setDvar("vo_done", 1);
  }

  wait 3;
  thread init_mission_select(var_0);
}

function tango_infil_radio_idle(var_0) {
  setDvar("scr_cp_map_part2", 1);
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_downtown_cs_completed");
  scripts\engine\utility::flag_set("ml_p3_done");
  level.default_player_spawns = "safehouse_gunshop_playerstart";
  level.initlocs_bunkertest = scripts\engine\utility::getStructArray("safehouse_gunshop_playerstart", "targetname");
  level thread scripts\cp\intel\cp_intel::init_intel_pieces("launderer2");
}

function ref_137f6(var_0) {
  thread scripts\cp\cp_objectives::run_objective("vault_assault_retrieve_saw", "primary");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13bc2(1);
  thread scripts\mp\brclientmatchdata::getnextrpgspawnmodule("strongbox", "toggle_safehouse_settings", 25);
  thread heli_counter();
  setDvar("restart_checkpoint", "");
  setDvar("cp_dwn_twn_2_start_obj", "safehouse_gunshop");
  scripts\engine\utility::flag_clear("safehouse_door_open");
  thread ref_12e5e();
  wait 7;
  scripts\cp\cp_objectives::lua_objective_complete("safehouse_gunshop");
  open_safehouse_door();
}

function init_mission_select(var_0) {
  thread scripts\cp\cp_objectives::run_objective("ml_p1_intel", "primary");
  level waittill("allow_safehouse_door");
  open_safehouse_door();
  scripts\engine\utility::flag_set("safehouse_door_open");
}

function ref_12e5f() {
  scripts\mp\vehicles\vehicle_damage_mp::ref_12409("lass");
  wait 0.25;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_safehouse_search_for_intel_10", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_safehouse_search_for_intel_20", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_safehouse_search_for_intel_30", "allies");
}

function ref_12e5e() {
  thread scripts\cp\maps\cp_dwn_twn\objectives\cp_vault_assault::ref_123ca();
}

function ref_12e5d() {
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_intro_20");
  scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123cb("conv_generic_affirm");
}

function open_safehouse_door() {
  if(!scripts\engine\utility::flag("ml_p3_done")) {
    var_0 = scripts\engine\utility::getStruct("dwn_twn_safehouse_gate", "targetname");
    var_1 = spawn("script_model", var_0.origin);
    var_1 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/DOOR_OPEN", 25, "duration_short", "show", 512, 65, 64, 65);

    for(;;) {
      var_1 waittill("trigger", var_2);

      if(!var_2 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      break;
    }

    var_1 delete();
    scripts\mp\vehicles\vehicle_damage_mp::ref_13bc2(0);
    ref_12118();
    level notify("safehouse_door_open");
    return;
  }

  ref_120bd("gunshop_safehouse_clip_1");
  ref_120bd("gunshop_safehouse_clip_2");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(0, (25571, -12073.5, -180.25), 1024, "scriptable_door_wooden_office_01_mp", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(0, (25571, -12073.5, -180.25), 1024, "scriptable_door_glass_metal_01_mp", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13bc2(0);
}

function ref_12118() {
  var_0 = getEnt("dwn_twn_safehouse_door", "targetname");

  if(!isDefined(var_0.og_angles)) {
    var_0.og_angles = var_0.angles;
  }

  var_0 playSound("scrpt_door_wood_single_open");
  var_1 = getEnt("dwn_twn_safehouse_clip", "targetname");
  var_0 rotateTo((0, -57, 0), 0.5);
  var_1 connectpaths();
  var_1 notsolid();
}

function ref_1234e(var_0) {
  var_1 = getEnt("gun_shop_saw", "targetname");
  var_2 = getEnt("gun_shop_saw_2", "targetname");
  var_3 = getEnt("gun_shop_saw_3", "targetname");
  var_4 = getEnt("gun_shop_saw_4", "targetname");
  level.ref_12ebd = var_1.origin;
  level.ref_12eb9 = var_1.angles;
  level.ref_12eb4 = var_2.origin;
  level.ref_12eb3 = var_2.angles;
  level.ref_12eb6 = var_3.origin;
  level.ref_12eb5 = var_3.angles;
  level.ref_12eb8 = var_4.origin;
  level.ref_12eb7 = var_4.angles;
  level.ref_12eba = [];
  thread init_key(level, var_1, 1, undefined);
  thread init_key(level, var_2, 1, undefined);
  thread init_key(level, var_3, 1, undefined);
  thread init_key(level, var_4, 1, undefined);
  objective_setlabel(var_0.objectiveindex, &"CP_DWN_TWN_OBJECTIVES/SAW");
  objective_position(var_0.objectiveindex, var_1.origin + (0, 0, 70));
}

function ref_120bd(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_3 connectpaths();
    var_3 notsolid();
  }
}

function heli_counter() {
  heli_convert("gunshop_safehouse_clip_1");
  heli_convert("gunshop_safehouse_clip_2");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(1, (25571, -12073.5, -180.25), 1024, "scriptable_door_wooden_office_01_mp", "classname");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(1, (25571, -12073.5, -180.25), 1024, "scriptable_door_glass_metal_01_mp", "classname");
  wait 3;
}

function heli_convert(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_3 disconnectPaths();
    var_3 solid();
  }
}

function mission_select_think(var_0) {
  level waittill("saw_pickedup");
  level notify("mission_selected", var_0);
}

function show_document(var_0) {
  var_1 = scripts\engine\utility::getStruct(self.target, "targetname");
  self moveTo(var_1.origin, 0.25);
  wait 0.3;

  if(isDefined(var_0)) {
    wait var_0;
  }

  self moveTo(scripts\engine\utility::getStruct(var_1.target, "targetname").origin, 0.25);
  self rotateTo(scripts\engine\utility::getStruct(var_1.target, "targetname").angles, 0.25);
}

function return_to_safehouse_vo() {
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_ovl_safehouse_intel_gathered_10");
  wait 1;
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_ovl_safehouse_return_safehouse_10");
}

function init_key(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::flag("saws_have_been_used")) {
    return;
  }

  if(!isDefined(var_0)) {
    var_4 = getEnt("gun_shop_saw", "targetname");
  } else {
    var_4 = var_1;
  }

  var_4.pbexploitstarttime = var_4;
  var_4 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_DWN_TWN_OBJECTIVES/PICKUP_SAW", 25, "duration_short", "show", 4000, 65, 64, 65);
  ref_12ebb(var_4);
  thread ref_12ebe(var_4);
  thread ref_12ec0();
}

function ref_12ebb(var_0) {
  if(!isDefined(level.ref_12ebc)) {
    level.ref_12ebc = [];
  }

  var_0.head_icon = deleteheadicon(var_0);
  setheadiconfriendlyimage(var_0.head_icon, "cp_tac_waypoint_buzzsaw");
  setheadiconsnaptoedges(var_0.head_icon, 0);
  setheadicondrawthroughgeo(var_0.head_icon, 1);
  addclienttoheadiconmask(var_0.head_icon, 10);
  objective_sethideelevation(var_0.head_icon, 1);
  level.ref_12ebc[level.ref_12ebc.size] = var_0.head_icon;
}

function ref_12ebf() {
  if(isDefined(self.head_icon)) {
    if(scripts\engine\utility::array_contains(level.ref_12ebc, self.head_icon)) {
      if(isDefined(self.head_icon)) {
        level.ref_12ebc = scripts\engine\utility::array_remove(level.ref_12ebc, self.head_icon);
        setheadiconimage(self.head_icon);
        return;
      }

      return;
    }

    return;
  }
}

function ref_12ec0() {
  level endon("game_ended");
  self endon("trigger");
  scripts\engine\utility::flag_wait("saws_have_been_used");
  ref_12ebf();
  self makeunusable();
}

function ref_12ebe(var_0) {
  level endon("saws_have_been_used");

  for(;;) {
    self waittill("trigger", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(istrue(var_1.shoot_vehicle)) {
      var_1 scripts\cp\utility::setlowermessage("havesaw", &"CP_DWN_TWN_OBJECTIVES/ALREADY_HAVE_SAW", 5);
      continue;
    }

    var_1 playlocalsound("cp_generic_pickup");
    script_struct_add(var_1, self);
    level notify("saw_pickedup");
    ref_12ebf();

    if(istrue(var_0)) {
      self hide();
      return;
    }
  }
}

function script_struct_add(var_0, var_1) {
  var_2 = var_0 gettagorigin("tag_shield_back");
  var_3 = var_0 gettagangles("tag_shield_back");
  var_4 = spawn("script_model", var_2);
  var_4.angles = var_3;
  var_4 setModel("tool_portable_gas_cutter_01_cp");
  var_4 linkTo(var_0, "tag_shield_back", (5, 10, 0), (0, 0, 90));
  var_4.pbexploitstarttime = var_1.pbexploitstarttime;
  var_0.shoot_vehicle = 1;
  var_0.x1circletime = var_4;

  if(isDefined(var_1)) {
    var_1 makeunusable();
  }

  thread minigun_model();
}

function minigun_model() {
  var_0 = scripts\engine\utility::ref_143af("death", "disconnect", "drop_saw", "last_stand");

  if(!isDefined(self.x1circletime)) {
    return;
  }

  var_1 = self.x1circletime;
  self.shoot_vehicle = undefined;
  self.x1circletime = undefined;
  var_1 unlink();

  if(!scripts\engine\utility::flag("saws_have_been_used")) {
    var_1 makeusable();
  }

  if(isDefined(self.oobendtime) || ref_1213d()) {
    switch (var_1.pbexploitstarttime) {
      case 3:
        var_1.origin = level.ref_12eb8;
        var_1.angles = level.ref_12eb7;
        break;
      case 2:
        var_1.origin = level.ref_12eb6;
        var_1.angles = level.ref_12eb5;
        break;
      case 1:
        var_1.origin = level.ref_12eb4;
        var_1.angles = level.ref_12eb3;
        break;
      case 0:
        var_1.origin = level.ref_12ebd;
        var_1.angles = level.ref_12eb9;
        break;
      default:
        break;
    }
  } else {
    var_1 physicslaunchserver(var_1.origin + (0, 0, 10), (0, 0, -10));
  }

  init_key(var_1, 1, 1, var_1.pbexploitstarttime);
}

function ref_1213d() {
  var_0 = scripts\engine\utility::getStructArray("saw_bad_place", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.radius)) {
      var_3 = var_2.radius;
    } else {
      var_3 = 100;
    }

    var_4 = var_3 * var_3;

    if(isDefined(var_2.height)) {
      var_5 = var_2.height;
    } else {
      var_5 = 100;
    }

    if(distance2dsquared(self.origin, var_2.origin) < var_4) {
      if(self.origin[2] <= var_2.origin[2] + var_5) {
        if(self.origin[2] >= var_2.origin[2]) {
          return true;
        }
      }
    }
  }

  return false;
}