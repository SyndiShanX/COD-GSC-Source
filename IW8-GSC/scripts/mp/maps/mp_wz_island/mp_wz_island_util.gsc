/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_wz_island\mp_wz_island_util.gsc
**************************************************************/

function ref_1326b() {
  var_0 = spawnStruct();
  var_0.playbattlechattersoundexpensive = getdvarint("scr_shallow_water_fire_extinguish_enabled", 1);
  var_0.playdeathsoundph = getdvarint("scr_shallow_water_fire_smoke_enabled", 1);
  var_0.ref_12abc = getdvarint("scr_shallow_water_reduced_lethal_damage_enabled", 1);
  var_0.ref_12abd = getdvarfloat("scr_shallow_water_reduced_lethal_damage_multiplier", 0.5);
  var_0.ref_11eb8 = getdvarint("scr_shallow_water_noprone_volumes_enabled", 1);
  var_0.ref_13c4d = getdvarint("scr_shallow_water_tracker_no_footprint_enabled", 1);
  var_0.helis_assault2 = getdvarint("scr_shallow_water_cold_blooded_enabled", 1);
  var_0.watch_for_owner_disconnect = getdvarint("scr_shallow_water_last_stand_water_suit_enabled", 1);
  var_1 = spawnStruct();
  var_1.getheliflyheight = &getquickdropammotype;
  var_1.gethelinextgroupafterwait = &getquickdroparmorcount;
  var_1.make_control_station_interaction = &maxtagradius;
  var_1.removelinkdamagemodifieronlaststand = &roof_enemy_groups;
  var_1.lowpopallowtweaks = &maxrangesq;
  var_1.setupbobbingboatmultiple = &setuphunters;
  var_1.setupmission = &setupinfectedairdroppositions;
  var_1.module_unpause_funcs = var_0;
  level.ref_132a4 = var_1;
  level.playerdatafield = &update_spot_limit;
  level.playerconnectwatcher = &unset_relic_vampire;
  level.playercleanupinfilondisconnect = &move_player_from_under_heli_and_kill;
  level.playercleargulagomnvars = &move_window_light;
  level.playerexitcombatarea = &ref_126d4;
  level.playerexecutionsenable = &ref_126d3;

  if(getdvarint("scr_shallow_water_use_trigger_volumes", 1)) {
    thread throwingknifemelee();
  }

  if(istrue(level.ref_132a4.module_unpause_funcs.ref_11eb8)) {
    thread throwingknife_fire_clear_fx();
  }

  thread getlootteamleader();
  ref_1326c();
}

function ref_1326c() {
  level._effect["shallow_water_molotov"] = loadfx("vfx/iw8_br/island/equip/vfx_molotov_shallow_water");
  level._effect["shallow_water_thermite"] = loadfx("vfx/iw8_br/island/equip/vfx_thermite_shallow_water");
}

function throwingknifemelee() {
  level.ref_132a5 = [];
  var_0 = getEntArray("triggers_water_knee", "script_noteworthy");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    level.ref_132a5[var_1] = var_2;
    level.ref_132a5[var_1].occupants = [];
    var_3 = var_2.origin[2];

    if(isDefined(var_2.target)) {
      var_4 = scripts\engine\utility::getStruct(var_2.target, "targetname");

      if(isDefined(var_4)) {
        var_3 = var_4.origin[2];
      }
    }

    level.ref_132a5[var_1].ref_14513 = var_3;
    scripts\mp\utility\trigger::makeenterexittrigger(var_2, &ref_132a0, &ref_132a3);
  }

  thread ref_1329f();
}

function throwingknife_fire_clear_fx() {
  level.ref_11eb7 = [];
  level.ref_11eb7 = getEntArray("trigger_multiple_water_shallow", "classname");

  foreach(var_1 in level.ref_11eb7) {
    scripts\mp\utility\trigger::makeenterexittrigger(var_1, &nuke_vault_oilfire_player_vision, &onprematchfadedone);
  }
}

function nuke_vault_oilfire_player_vision(var_0, var_1) {
  if(!isDefined(var_0) || !isPlayer(var_0)) {
    return;
  }

  var_0.unset_relic_vampire = 1;

  if(isDefined(var_0.vehicle)) {
    return;
  }

  ref_126d4(var_0);
}

function onprematchfadedone(var_0, var_1) {
  if(!isDefined(var_0) || !isPlayer(var_0)) {
    return;
  }

  var_0 notify("exited_shallow_water");
  var_0.unset_relic_vampire = undefined;

  if(isDefined(var_0.vehicle)) {
    return;
  }

  ref_126d3(var_0);
}

function ref_126d4() {
  var_0 = self;

  if(istrue(var_0.inlaststand)) {
    move_player_from_under_heli_and_kill(var_0, 1);
  }

  move_window_light(var_0, 0);

  if(!isbot(var_0)) {
    thread ref_144cc();
    var_0 notifyonplayercommand("prone_in_water", "+prone");
    var_0 notifyonplayercommand("prone_in_water", "goprone");
    var_0 notifyonplayercommand("prone_in_water", "toggleprone");
    var_0 notifyonplayercommand("prone_from_crouch_in_water", "+stance");
    var_0 notifyonplayercommand("release_stance", "-stance");
    return;
  }
}

function ref_126d3() {
  var_0 = self;

  if(istrue(var_0.inlaststand)) {
    move_player_from_under_heli_and_kill(var_0, 0);
  } else {
    move_window_light(var_0, 1);
  }

  if(!isbot(var_0)) {
    var_0 notifyonplayercommandremove("prone_in_water", "+prone");
    var_0 notifyonplayercommandremove("prone_in_water", "goprone");
    var_0 notifyonplayercommandremove("prone_in_water", "toggleprone");
    var_0 notifyonplayercommandremove("prone_from_crouch_in_water", "+stance");
    var_0 notifyonplayercommandremove("release_stance", "-stance");
    return;
  }
}

function ref_144cc() {
  var_0 = self;
  var_0 endon("death_or_disconnect");
  var_0 endon("exited_shallow_water");
  level endon("game_ended");

  for(;;) {
    var_1 = var_0 scripts\engine\utility::ref_143ad("prone_in_water", "prone_from_crouch_in_water");

    if(var_1 == "prone_from_crouch_in_water") {
      if(var_0 getstance() != "prone") {
        var_1 = scripts\engine\utility::waittill_notify_or_timeout_return("release_stance", 0.5);

        if(var_1 == "release_stance") {
          continue;
        }
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("CGAME/PRONE_BLOCKED");
      wait 1;
    }
  }
}

function unset_relic_vampire() {
  var_0 = self;

  if(!isPlayer(var_0)) {
    return false;
  }

  return istrue(var_0.unset_relic_vampire);
}

function ref_1329f() {
  level endon("game_ended");
  var_0 = 1;
  var_1 = 100;

  for(;;) {
    var_2 = getdvarfloat("scr_shallow_water_delay", var_0);
    var_3 = getdvarfloat("scr_shallow_water_lower_bound_speed", var_1);

    foreach(var_5 in level.ref_132a5) {
      if(var_5.occupants.size == 0) {
        continue;
      }

      if(getdvarint("scr_shallow_water_debug", 0) == 1) {
        var_6 = "";

        foreach(var_8 in var_5.occupants) {
          if(!isDefined(var_8)) {
            continue;
          }

          var_6 += var_8.name + " ";
        }

        allsupportboxes(var_5.origin + " - Current occupant: " + var_6 + "Speed: " + length(var_5.occupants[0] getvelocity()));
      }

      foreach(var_8 in var_5.occupants) {
        if(!isDefined(var_8)) {
          continue;
        }

        var_11 = var_8 getvelocity();
        var_12 = length(var_11);

        if(var_12 >= var_3) {
          var_8 method_87d1(int(var_5.ref_14513));
        }
      }
    }

    wait var_2;
  }
}

function ref_132a0(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }

  var_2 = var_1.occupants.size;
  var_1.occupants[var_2] = var_0;
  allsupportboxes(var_1.origin + " - Incoming occupant: " + var_0.name);
}

function ref_132a3(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }

  var_1.occupants = scripts\engine\utility::array_remove(var_1.occupants, var_0);
  allsupportboxes(var_1.origin + " - Exiting occupant: " + var_0.name);
}

function getlootteamleader() {
  level endon("game_ended");

  for(;;) {
    var_0 = 0;

    if(!isDefined(level.players)) {
      level waittill("player_spawned");
    }

    foreach(var_2 in level.players) {
      if(!isDefined(var_2) || !isalive(var_2)) {
        continue;
      }

      if(var_0 > getdvarint("scr_shallow_water_players_per_frame", 25)) {
        waitframe();
        var_0 = 0;
      }

      if(!isDefined(var_2.ref_120ac) && update_restock_ui(var_2)) {
        ref_132a1(var_2);
      } else if(isDefined(var_2.ref_120ac) && !update_restock_ui(var_2)) {
        ref_132a2(var_2);
      }

      var_0++;
    }

    waitframe();
  }
}

function ref_1208a() {
  self endon("disconnect");

  while(update_restock_ui(self)) {
    var_0 = self getstance();

    if(!isDefined(self.ui_damage_num_elems) && (var_0 == "crouch" || self issprintsliding())) {
      ref_12088();
    }

    if(isDefined(self.ui_damage_num_elems) && var_0 != "crouch" && !self issprintsliding()) {
      ref_12089();
    }

    waitframe();
  }

  if(isDefined(self.ui_damage_num_elems)) {
    ref_12089();
    return;
  }
}

function ref_12088() {
  if(istrue(level.ref_132a4.module_unpause_funcs.helis_assault2)) {
    scripts\mp\utility\perk::giveperk("specialty_coldblooded");
  }

  self.ui_damage_num_elems = 1;

  if(istrue(level.ref_132a4.module_unpause_funcs.playbattlechattersoundexpensive)) {
    if(scripts\mp\equipment\molotov::molotov_is_burning()) {
      scripts\mp\equipment\molotov::molotov_clear_burning();
      return;
    }

    return;
  }
}

function ref_12089() {
  if(istrue(level.ref_132a4.module_unpause_funcs.helis_assault2)) {
    scripts\mp\utility\perk::removeperk("specialty_coldblooded");
  }

  self.ui_damage_num_elems = undefined;
}

function ref_132a1(var_0) {
  if(!isPlayer(var_0)) {
    return;
  }

  if(isDefined(var_0.ref_120ac)) {
    var_0.ref_120ac++;
    return;
  }

  var_0.ref_120ac = 1;

  if(istrue(level.ref_132a4.module_unpause_funcs.ref_13c4d)) {
    var_0 scripts\mp\utility\perk::giveperk("specialty_tracker_jammer");
  }

  thread ref_1208a();
}

function ref_132a2(var_0) {
  if(!isPlayer(var_0)) {
    return;
  }

  if(isDefined(var_0.ref_120ac)) {
    var_0.ref_120ac--;

    if(var_0.ref_120ac == 0) {
      var_0.ref_120ac = undefined;

      if(istrue(level.ref_132a4.module_unpause_funcs.ref_13c4d) && var_0 hasperk("specialty_tracker_jammer")) {
        var_0 scripts\mp\utility\perk::removeperk("specialty_tracker_jammer");
        return;
      }

      return;
    }

    return;
  }
}

function update_restock_ui(var_0) {
  var_1 = 0;

  if(isPlayer(var_0)) {
    var_2 = var_0 method_87cb();
    var_1 = var_2 == 49 || var_2 == 50 || var_2 == 51 || var_2 == 21 || function_0437(var_0.origin);
  } else if(isDefined(var_0.surfacetype)) {
    var_2 = var_0.surfacetype;
    var_1 = var_2 == "water" || var_2 == "water_knee" || var_2 == "water_ankle" || var_2 == "mud_riverbed" || function_0437(var_0.origin);
  }

  return var_1;
}

function maxtagradius(var_0) {
  return level.ref_132a4.module_unpause_funcs.playdeathsoundph && update_restock_ui(var_0);
}

function setuphunters(var_0) {
  playFX(scripts\engine\utility::getfx("shallow_water_molotov"), var_0.origin, anglestoup((0, 90, 0)));
  var_0 delete();
}

function setupinfectedairdroppositions(var_0) {
  playFX(scripts\engine\utility::getfx("shallow_water_thermite"), var_0.origin, anglestoup((0, 90, 0)));
  var_0 delete();
}

function maxrangesq(var_0) {
  return update_restock_ui(var_0);
}

function getquickdropammotype(var_0) {
  return level.ref_132a4.module_unpause_funcs.playbattlechattersoundexpensive && istrue(var_0.ui_damage_num_elems);
}

function getquickdroparmorcount(var_0) {
  return level.ref_132a4.module_unpause_funcs.playbattlechattersoundexpensive && update_restock_ui(var_0);
}

function roof_enemy_groups(var_0) {
  if(!level.ref_132a4.module_unpause_funcs.ref_12abc || !isDefined(var_0) || !function_0437(var_0.origin)) {
    return 1;
  }

  return level.ref_132a4.module_unpause_funcs.ref_12abd;
}

function ref_1450c() {
  waitframe();
  level.arena_turret_op = getEntArray("script_model_water_wheel", "targetname");
  scripts\engine\utility::array_thread(level.arena_turret_op, &ref_1450d);
}

function ref_1450d() {
  level endon("game_ended");
  var_0 = (0, 0, -90);
  var_1 = (10, 0, 0);
  var_2 = 0.5;

  if(isDefined(self.script_rotation_amount)) {
    var_0 = self.script_rotation_amount;
  }

  if(isDefined(self.script_rotation_speed)) {
    var_1 = self.script_rotation_speed;
  }

  if(isDefined(self.target)) {
    var_3 = getEnt(self.target, "targetname");

    if(isDefined(var_3) && var_3.classname == "script_brushmodel") {
      var_3 linkTo(self);
    }
  }

  for(;;) {
    self rotateby(var_0, var_1[0], var_1[1], var_1[2]);
    wait var_1[0];

    if(!cargo_truck_mg_cp_init("water_wheel_rotation_loop()", self)) {
      return;
    }
  }
}

function cargo_truck_mg_cp_init(var_0, var_1) {
  if(!isDefined(var_1)) {
    return false;
  }

  return true;
}

function allsupportboxes(var_0) {
  if(getdvarint("scr_shallow_water_debug", 0) == 1) {
    iprintlnbold("Shallow Water: " + var_0);
    return;
  }
}

function ref_14510() {
  level.update2v2progress = getEntArray("waterfall_triggers", "script_noteworthy");

  if(!isDefined(level.update2v2progress) || level.update2v2progress.size == 0) {
    return;
  }

  foreach(var_1 in level.update2v2progress) {
    scripts\mp\utility\trigger::makeenterexittrigger(var_1, &ref_14511, &ref_14512);
  }
}

function ref_14511(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }

  var_0 notify("waterfall_enter");
  thread ref_12534();

  if(var_0 getscriptablehaspart("headVFX") && var_0 getscriptableparthasstate("headVFX", "waterVision")) {
    var_0 setscriptablepartstate("headVFX", "waterVision");
    return;
  }
}

function ref_14512(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }

  if(var_0 getscriptablehaspart("headVFX")) {
    var_0 setscriptablepartstate("headVFX", "neutral");
    return;
  }
}

function ref_12534(var_0) {
  var_1 = self;

  if(!isPlayer(var_1)) {
    return;
  }

  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 endon("waterfall_enter");
  var_1 waittill("death");

  if(!isPlayer(var_1)) {
    return;
  }

  if(var_1 getscriptablehaspart("headVFX")) {
    var_1 setscriptablepartstate("headVFX", "neutral");
    return;
  }
}

function update_spot_limit() {
  var_0 = level.mapname;
  return var_0 == "mp_wz_island" || var_0 == "mp_br_mechanics" || var_0 == "mp_wz_set_water" || var_0 == "mp_sm_island_1";
}

function move_player_from_under_heli_and_kill(var_0) {
  if(!isDefined(level.ref_132a4) || !isDefined(level.ref_132a4.module_unpause_funcs) || !level.ref_132a4.module_unpause_funcs.watch_for_owner_disconnect) {
    return;
  }

  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }

  var_1 = self;

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(var_0 && !unset_relic_vampire(var_1)) {
    return;
  }

  if(var_0) {
    var_1.circleclosing = var_1.operatorcustomization.suit;

    if(!isDefined(var_1.circleclosing)) {
      var_1.circleclosing = "iw8_defaultsuit_mp";
    }

    var_1 setsuit("iw8_laststand_water_br");
    return;
  }

  if(!isDefined(var_1.circleclosing)) {
    return;
  }

  var_1 setsuit(var_1.circleclosing);
  var_1.circleclosing = undefined;
}

function move_window_light(var_0) {
  var_1 = self;

  if(!var_0 && !unset_relic_vampire(var_1)) {
    return;
  }

  if(var_1 scripts\common\utility::is_prone_allowed() != var_0) {
    var_1 scripts\common\utility::allow_prone(var_0);
  }

  if(var_1 scripts\common\utility::is_slide_allowed() != var_0) {
    if(!var_0 && var_1 issprintsliding()) {
      var_1 setstance("crouch");
    }

    var_1 scripts\common\utility::allow_slide(var_0);
    return;
  }
}