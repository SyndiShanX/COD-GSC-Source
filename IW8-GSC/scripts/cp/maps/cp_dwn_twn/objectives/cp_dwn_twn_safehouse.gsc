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

function debugbeatobjective(var0) {}

function debug_safehouse_start(var0) {
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_downtown_cs_completed");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "safehouse_1_playerstart");
  thread start_safehouse_objective();
}

function debug_safehouse_return_start(var0) {
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

function isprophunt(var0) {
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

function start_safehouse(var0) {
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
  thread init_mission_select(var0);
}

function tango_infil_radio_idle(var0) {
  setDvar("scr_cp_map_part2", 1);
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_downtown_cs_completed");
  scripts\engine\utility::flag_set("ml_p3_done");
  level.default_player_spawns = "safehouse_gunshop_playerstart";
  level.initlocs_bunkertest = scripts\engine\utility::getStructArray("safehouse_gunshop_playerstart", "targetname");
  level thread scripts\cp\intel\cp_intel::init_intel_pieces("launderer2");
}

function ref_137f6(var0) {
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

function init_mission_select(var0) {
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
    var0 = scripts\engine\utility::getStruct("dwn_twn_safehouse_gate", "targetname");
    var1 = spawn("script_model", var0.origin);
    var1 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/DOOR_OPEN", 25, "duration_short", "show", 512, 65, 64, 65);

    for(;;) {
      var1 waittill("trigger", var2);

      if(!var2 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      break;
    }

    var1 delete();
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
  var0 = getEnt("dwn_twn_safehouse_door", "targetname");

  if(!isDefined(var0.og_angles)) {
    var0.og_angles = var0.angles;
  }

  var0 playSound("scrpt_door_wood_single_open");
  var1 = getEnt("dwn_twn_safehouse_clip", "targetname");
  var0 rotateTo((0, -57, 0), 0.5);
  var1 connectpaths();
  var1 notsolid();
}

function ref_1234e(var0) {
  var1 = getEnt("gun_shop_saw", "targetname");
  var2 = getEnt("gun_shop_saw_2", "targetname");
  var3 = getEnt("gun_shop_saw_3", "targetname");
  var4 = getEnt("gun_shop_saw_4", "targetname");
  level.ref_12ebd = var1.origin;
  level.ref_12eb9 = var1.angles;
  level.ref_12eb4 = var2.origin;
  level.ref_12eb3 = var2.angles;
  level.ref_12eb6 = var3.origin;
  level.ref_12eb5 = var3.angles;
  level.ref_12eb8 = var4.origin;
  level.ref_12eb7 = var4.angles;
  level.ref_12eba = [];
  thread init_key(level, var1, 1, undefined);
  thread init_key(level, var2, 1, undefined);
  thread init_key(level, var3, 1, undefined);
  thread init_key(level, var4, 1, undefined);
  objective_setlabel(var0.objectiveindex, &"CP_DWN_TWN_OBJECTIVES/SAW");
  objective_position(var0.objectiveindex, var1.origin + (0, 0, 70));
}

function ref_120bd(var0) {
  var1 = getEntArray(var0, "targetname");

  foreach(var3 in var1) {
    var3 connectpaths();
    var3 notsolid();
  }
}

function heli_counter() {
  heli_convert("gunshop_safehouse_clip_1");
  heli_convert("gunshop_safehouse_clip_2");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(1, (25571, -12073.5, -180.25), 1024, "scriptable_door_wooden_office_01_mp", "classname");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(1, (25571, -12073.5, -180.25), 1024, "scriptable_door_glass_metal_01_mp", "classname");
  wait 3;
}

function heli_convert(var0) {
  var1 = getEntArray(var0, "targetname");

  foreach(var3 in var1) {
    var3 disconnectPaths();
    var3 solid();
  }
}

function mission_select_think(var0) {
  level waittill("saw_pickedup");
  level notify("mission_selected", var0);
}

function show_document(var0) {
  var1 = scripts\engine\utility::getStruct(self.target, "targetname");
  self moveTo(var1.origin, 0.25);
  wait 0.3;

  if(isDefined(var0)) {
    wait var0;
  }

  self moveTo(scripts\engine\utility::getStruct(var1.target, "targetname").origin, 0.25);
  self rotateTo(scripts\engine\utility::getStruct(var1.target, "targetname").angles, 0.25);
}

function return_to_safehouse_vo() {
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_ovl_safehouse_intel_gathered_10");
  wait 1;
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_ovl_safehouse_return_safehouse_10");
}

function init_key(var0, var1, var2, var3) {
  if(scripts\engine\utility::flag("saws_have_been_used")) {
    return;
  }

  if(!isDefined(var0)) {
    var4 = getEnt("gun_shop_saw", "targetname");
  } else {
    var4 = var1;
  }

  var4.pbexploitstarttime = var4;
  var4 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_DWN_TWN_OBJECTIVES/PICKUP_SAW", 25, "duration_short", "show", 4000, 65, 64, 65);
  ref_12ebb(var4);
  thread ref_12ebe(var4);
  thread ref_12ec0();
}

function ref_12ebb(var0) {
  if(!isDefined(level.ref_12ebc)) {
    level.ref_12ebc = [];
  }

  var0.head_icon = deleteheadicon(var0);
  setheadiconfriendlyimage(var0.head_icon, "cp_tac_waypoint_buzzsaw");
  setheadiconsnaptoedges(var0.head_icon, 0);
  setheadicondrawthroughgeo(var0.head_icon, 1);
  addclienttoheadiconmask(var0.head_icon, 10);
  objective_sethideelevation(var0.head_icon, 1);
  level.ref_12ebc[level.ref_12ebc.size] = var0.head_icon;
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

function ref_12ebe(var0) {
  level endon("saws_have_been_used");

  for(;;) {
    self waittill("trigger", var1);

    if(!var1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(istrue(var1.shoot_vehicle)) {
      var1 scripts\cp\utility::setlowermessage("havesaw", &"CP_DWN_TWN_OBJECTIVES/ALREADY_HAVE_SAW", 5);
      continue;
    }

    var1 playlocalsound("cp_generic_pickup");
    script_struct_add(var1, self);
    level notify("saw_pickedup");
    ref_12ebf();

    if(istrue(var0)) {
      self hide();
      return;
    }
  }
}

function script_struct_add(var0, var1) {
  var2 = var0 gettagorigin("tag_shield_back");
  var3 = var0 gettagangles("tag_shield_back");
  var4 = spawn("script_model", var2);
  var4.angles = var3;
  var4 setModel("tool_portable_gas_cutter_01_cp");
  var4 linkTo(var0, "tag_shield_back", (5, 10, 0), (0, 0, 90));
  var4.pbexploitstarttime = var1.pbexploitstarttime;
  var0.shoot_vehicle = 1;
  var0.x1circletime = var4;

  if(isDefined(var1)) {
    var1 makeunusable();
  }

  thread minigun_model();
}

function minigun_model() {
  var0 = scripts\engine\utility::ref_143af("death", "disconnect", "drop_saw", "last_stand");

  if(!isDefined(self.x1circletime)) {
    return;
  }

  var1 = self.x1circletime;
  self.shoot_vehicle = undefined;
  self.x1circletime = undefined;
  var1 unlink();

  if(!scripts\engine\utility::flag("saws_have_been_used")) {
    var1 makeusable();
  }

  if(isDefined(self.oobendtime) || ref_1213d()) {
    switch (var1.pbexploitstarttime) {
      case 3:
        var1.origin = level.ref_12eb8;
        var1.angles = level.ref_12eb7;
        break;
      case 2:
        var1.origin = level.ref_12eb6;
        var1.angles = level.ref_12eb5;
        break;
      case 1:
        var1.origin = level.ref_12eb4;
        var1.angles = level.ref_12eb3;
        break;
      case 0:
        var1.origin = level.ref_12ebd;
        var1.angles = level.ref_12eb9;
        break;
      default:
        break;
    }
  } else {
    var1 physicslaunchserver(var1.origin + (0, 0, 10), (0, 0, -10));
  }

  init_key(var1, 1, 1, var1.pbexploitstarttime);
}

function ref_1213d() {
  var0 = scripts\engine\utility::getStructArray("saw_bad_place", "targetname");

  foreach(var2 in var0) {
    if(isDefined(var2.radius)) {
      var3 = var2.radius;
    } else {
      var3 = 100;
    }

    var4 = var3 * var3;

    if(isDefined(var2.height)) {
      var5 = var2.height;
    } else {
      var5 = 100;
    }

    if(distance2dsquared(self.origin, var2.origin) < var4) {
      if(self.origin[2] <= var2.origin[2] + var5) {
        if(self.origin[2] >= var2.origin[2]) {
          return true;
        }
      }
    }
  }

  return false;
}