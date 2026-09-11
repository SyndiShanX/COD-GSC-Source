/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_wz_island\mp_wz_island_util.gsc
**************************************************************/

function ref_1326b() {
  var0 = spawnStruct();
  var0.playbattlechattersoundexpensive = getdvarint("scr_shallow_water_fire_extinguish_enabled", 1);
  var0.playdeathsoundph = getdvarint("scr_shallow_water_fire_smoke_enabled", 1);
  var0.ref_12abc = getdvarint("scr_shallow_water_reduced_lethal_damage_enabled", 1);
  var0.ref_12abd = getdvarfloat("scr_shallow_water_reduced_lethal_damage_multiplier", 0.5);
  var0.ref_11eb8 = getdvarint("scr_shallow_water_noprone_volumes_enabled", 1);
  var0.ref_13c4d = getdvarint("scr_shallow_water_tracker_no_footprint_enabled", 1);
  var0.helis_assault2 = getdvarint("scr_shallow_water_cold_blooded_enabled", 1);
  var0.watch_for_owner_disconnect = getdvarint("scr_shallow_water_last_stand_water_suit_enabled", 1);
  var1 = spawnStruct();
  var1.getheliflyheight = &getquickdropammotype;
  var1.gethelinextgroupafterwait = &getquickdroparmorcount;
  var1.make_control_station_interaction = &maxtagradius;
  var1.removelinkdamagemodifieronlaststand = &roof_enemy_groups;
  var1.lowpopallowtweaks = &maxrangesq;
  var1.setupbobbingboatmultiple = &setuphunters;
  var1.setupmission = &setupinfectedairdroppositions;
  var1.module_unpause_funcs = var0;
  level.ref_132a4 = var1;
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
  var0 = getEntArray("triggers_water_knee", "script_noteworthy");

  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = var0[var1];
    level.ref_132a5[var1] = var2;
    level.ref_132a5[var1].occupants = [];
    var3 = var2.origin[2];

    if(isDefined(var2.target)) {
      var4 = scripts\engine\utility::getStruct(var2.target, "targetname");

      if(isDefined(var4)) {
        var3 = var4.origin[2];
      }
    }

    level.ref_132a5[var1].ref_14513 = var3;
    scripts\mp\utility\trigger::makeenterexittrigger(var2, &ref_132a0, &ref_132a3);
  }

  thread ref_1329f();
}

function throwingknife_fire_clear_fx() {
  level.ref_11eb7 = [];
  level.ref_11eb7 = getEntArray("trigger_multiple_water_shallow", "classname");

  foreach(var1 in level.ref_11eb7) {
    scripts\mp\utility\trigger::makeenterexittrigger(var1, &nuke_vault_oilfire_player_vision, &onprematchfadedone);
  }
}

function nuke_vault_oilfire_player_vision(var0, var1) {
  if(!isDefined(var0) || !isPlayer(var0)) {
    return;
  }

  var0.unset_relic_vampire = 1;

  if(isDefined(var0.vehicle)) {
    return;
  }

  ref_126d4(var0);
}

function onprematchfadedone(var0, var1) {
  if(!isDefined(var0) || !isPlayer(var0)) {
    return;
  }

  var0 notify("exited_shallow_water");
  var0.unset_relic_vampire = undefined;

  if(isDefined(var0.vehicle)) {
    return;
  }

  ref_126d3(var0);
}

function ref_126d4() {
  var0 = self;

  if(istrue(var0.inlaststand)) {
    move_player_from_under_heli_and_kill(var0, 1);
  }

  move_window_light(var0, 0);

  if(!isbot(var0)) {
    thread ref_144cc();
    var0 notifyonplayercommand("prone_in_water", "+prone");
    var0 notifyonplayercommand("prone_in_water", "goprone");
    var0 notifyonplayercommand("prone_in_water", "toggleprone");
    var0 notifyonplayercommand("prone_from_crouch_in_water", "+stance");
    var0 notifyonplayercommand("release_stance", "-stance");
    return;
  }
}

function ref_126d3() {
  var0 = self;

  if(istrue(var0.inlaststand)) {
    move_player_from_under_heli_and_kill(var0, 0);
  } else {
    move_window_light(var0, 1);
  }

  if(!isbot(var0)) {
    var0 notifyonplayercommandremove("prone_in_water", "+prone");
    var0 notifyonplayercommandremove("prone_in_water", "goprone");
    var0 notifyonplayercommandremove("prone_in_water", "toggleprone");
    var0 notifyonplayercommandremove("prone_from_crouch_in_water", "+stance");
    var0 notifyonplayercommandremove("release_stance", "-stance");
    return;
  }
}

function ref_144cc() {
  var0 = self;
  var0 endon("death_or_disconnect");
  var0 endon("exited_shallow_water");
  level endon("game_ended");

  for(;;) {
    var1 = var0 scripts\engine\utility::ref_143ad("prone_in_water", "prone_from_crouch_in_water");

    if(var1 == "prone_from_crouch_in_water") {
      if(var0 getstance() != "prone") {
        var1 = scripts\engine\utility::waittill_notify_or_timeout_return("release_stance", 0.5);

        if(var1 == "release_stance") {
          continue;
        }
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("CGAME/PRONE_BLOCKED");
      wait 1;
    }
  }
}

function unset_relic_vampire() {
  var0 = self;

  if(!isPlayer(var0)) {
    return false;
  }

  return istrue(var0.unset_relic_vampire);
}

function ref_1329f() {
  level endon("game_ended");
  var0 = 1;
  var1 = 100;

  for(;;) {
    var2 = getdvarfloat("scr_shallow_water_delay", var0);
    var3 = getdvarfloat("scr_shallow_water_lower_bound_speed", var1);

    foreach(var5 in level.ref_132a5) {
      if(var5.occupants.size == 0) {
        continue;
      }

      if(getdvarint("scr_shallow_water_debug", 0) == 1) {
        var6 = "";

        foreach(var8 in var5.occupants) {
          if(!isDefined(var8)) {
            continue;
          }

          var6 += var8.name + " ";
        }

        allsupportboxes(var5.origin + " - Current occupant: " + var6 + "Speed: " + length(var5.occupants[0] getvelocity()));
      }

      foreach(var8 in var5.occupants) {
        if(!isDefined(var8)) {
          continue;
        }

        var11 = var8 getvelocity();
        var12 = length(var11);

        if(var12 >= var3) {
          var8 method_87d1(int(var5.ref_14513));
        }
      }
    }

    wait var2;
  }
}

function ref_132a0(var0, var1) {
  if(!isPlayer(var0)) {
    return;
  }

  var2 = var1.occupants.size;
  var1.occupants[var2] = var0;
  allsupportboxes(var1.origin + " - Incoming occupant: " + var0.name);
}

function ref_132a3(var0, var1) {
  if(!isPlayer(var0)) {
    return;
  }

  var1.occupants = scripts\engine\utility::array_remove(var1.occupants, var0);
  allsupportboxes(var1.origin + " - Exiting occupant: " + var0.name);
}

function getlootteamleader() {
  level endon("game_ended");

  for(;;) {
    var0 = 0;

    if(!isDefined(level.players)) {
      level waittill("player_spawned");
    }

    foreach(var2 in level.players) {
      if(!isDefined(var2) || !isalive(var2)) {
        continue;
      }

      if(var0 > getdvarint("scr_shallow_water_players_per_frame", 25)) {
        waitframe();
        var0 = 0;
      }

      if(!isDefined(var2.ref_120ac) && update_restock_ui(var2)) {
        ref_132a1(var2);
      } else if(isDefined(var2.ref_120ac) && !update_restock_ui(var2)) {
        ref_132a2(var2);
      }

      var0++;
    }

    waitframe();
  }
}

function ref_1208a() {
  self endon("disconnect");

  while(update_restock_ui(self)) {
    var0 = self getstance();

    if(!isDefined(self.ui_damage_num_elems) && (var0 == "crouch" || self issprintsliding())) {
      ref_12088();
    }

    if(isDefined(self.ui_damage_num_elems) && var0 != "crouch" && !self issprintsliding()) {
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

function ref_132a1(var0) {
  if(!isPlayer(var0)) {
    return;
  }

  if(isDefined(var0.ref_120ac)) {
    var0.ref_120ac++;
    return;
  }

  var0.ref_120ac = 1;

  if(istrue(level.ref_132a4.module_unpause_funcs.ref_13c4d)) {
    var0 scripts\mp\utility\perk::giveperk("specialty_tracker_jammer");
  }

  thread ref_1208a();
}

function ref_132a2(var0) {
  if(!isPlayer(var0)) {
    return;
  }

  if(isDefined(var0.ref_120ac)) {
    var0.ref_120ac--;

    if(var0.ref_120ac == 0) {
      var0.ref_120ac = undefined;

      if(istrue(level.ref_132a4.module_unpause_funcs.ref_13c4d) && var0 hasperk("specialty_tracker_jammer")) {
        var0 scripts\mp\utility\perk::removeperk("specialty_tracker_jammer");
        return;
      }

      return;
    }

    return;
  }
}

function update_restock_ui(var0) {
  var1 = 0;

  if(isPlayer(var0)) {
    var2 = var0 method_87cb();
    var1 = var2 == 49 || var2 == 50 || var2 == 51 || var2 == 21 || function_0437(var0.origin);
  } else if(isDefined(var0.surfacetype)) {
    var2 = var0.surfacetype;
    var1 = var2 == "water" || var2 == "water_knee" || var2 == "water_ankle" || var2 == "mud_riverbed" || function_0437(var0.origin);
  }

  return var1;
}

function maxtagradius(var0) {
  return level.ref_132a4.module_unpause_funcs.playdeathsoundph && update_restock_ui(var0);
}

function setuphunters(var0) {
  playFX(scripts\engine\utility::getfx("shallow_water_molotov"), var0.origin, anglestoup((0, 90, 0)));
  var0 delete();
}

function setupinfectedairdroppositions(var0) {
  playFX(scripts\engine\utility::getfx("shallow_water_thermite"), var0.origin, anglestoup((0, 90, 0)));
  var0 delete();
}

function maxrangesq(var0) {
  return update_restock_ui(var0);
}

function getquickdropammotype(var0) {
  return level.ref_132a4.module_unpause_funcs.playbattlechattersoundexpensive && istrue(var0.ui_damage_num_elems);
}

function getquickdroparmorcount(var0) {
  return level.ref_132a4.module_unpause_funcs.playbattlechattersoundexpensive && update_restock_ui(var0);
}

function roof_enemy_groups(var0) {
  if(!level.ref_132a4.module_unpause_funcs.ref_12abc || !isDefined(var0) || !function_0437(var0.origin)) {
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
  var0 = (0, 0, -90);
  var1 = (10, 0, 0);
  var2 = 0.5;

  if(isDefined(self.script_rotation_amount)) {
    var0 = self.script_rotation_amount;
  }

  if(isDefined(self.script_rotation_speed)) {
    var1 = self.script_rotation_speed;
  }

  if(isDefined(self.target)) {
    var3 = getEnt(self.target, "targetname");

    if(isDefined(var3) && var3.classname == "script_brushmodel") {
      var3 linkTo(self);
    }
  }

  for(;;) {
    self rotateby(var0, var1[0], var1[1], var1[2]);
    wait var1[0];

    if(!cargo_truck_mg_cp_init("water_wheel_rotation_loop()", self)) {
      return;
    }
  }
}

function cargo_truck_mg_cp_init(var0, var1) {
  if(!isDefined(var1)) {
    return false;
  }

  return true;
}

function allsupportboxes(var0) {
  if(getdvarint("scr_shallow_water_debug", 0) == 1) {
    iprintlnbold("Shallow Water: " + var0);
    return;
  }
}

function ref_14510() {
  level.update2v2progress = getEntArray("waterfall_triggers", "script_noteworthy");

  if(!isDefined(level.update2v2progress) || level.update2v2progress.size == 0) {
    return;
  }

  foreach(var1 in level.update2v2progress) {
    scripts\mp\utility\trigger::makeenterexittrigger(var1, &ref_14511, &ref_14512);
  }
}

function ref_14511(var0, var1) {
  if(!isPlayer(var0)) {
    return;
  }

  var0 notify("waterfall_enter");
  thread ref_12534();

  if(var0 getscriptablehaspart("headVFX") && var0 getscriptableparthasstate("headVFX", "waterVision")) {
    var0 setscriptablepartstate("headVFX", "waterVision");
    return;
  }
}

function ref_14512(var0, var1) {
  if(!isPlayer(var0)) {
    return;
  }

  if(var0 getscriptablehaspart("headVFX")) {
    var0 setscriptablepartstate("headVFX", "neutral");
    return;
  }
}

function ref_12534(var0) {
  var1 = self;

  if(!isPlayer(var1)) {
    return;
  }

  level endon("game_ended");
  var1 endon("disconnect");
  var1 endon("waterfall_enter");
  var1 waittill("death");

  if(!isPlayer(var1)) {
    return;
  }

  if(var1 getscriptablehaspart("headVFX")) {
    var1 setscriptablepartstate("headVFX", "neutral");
    return;
  }
}

function update_spot_limit() {
  var0 = level.mapname;
  return var0 == "mp_wz_island" || var0 == "mp_br_mechanics" || var0 == "mp_wz_set_water" || var0 == "mp_sm_island_1";
}

function move_player_from_under_heli_and_kill(var0) {
  if(!isDefined(level.ref_132a4) || !isDefined(level.ref_132a4.module_unpause_funcs) || !level.ref_132a4.module_unpause_funcs.watch_for_owner_disconnect) {
    return;
  }

  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }

  var1 = self;

  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(var0 && !unset_relic_vampire(var1)) {
    return;
  }

  if(var0) {
    var1.circleclosing = var1.operatorcustomization.suit;

    if(!isDefined(var1.circleclosing)) {
      var1.circleclosing = "iw8_defaultsuit_mp";
    }

    var1 setsuit("iw8_laststand_water_br");
    return;
  }

  if(!isDefined(var1.circleclosing)) {
    return;
  }

  var1 setsuit(var1.circleclosing);
  var1.circleclosing = undefined;
}

function move_window_light(var0) {
  var1 = self;

  if(!var0 && !unset_relic_vampire(var1)) {
    return;
  }

  if(var1 scripts\common\utility::is_prone_allowed() != var0) {
    var1 scripts\common\utility::allow_prone(var0);
  }

  if(var1 scripts\common\utility::is_slide_allowed() != var0) {
    if(!var0 && var1 issprintsliding()) {
      var1 setstance("crouch");
    }

    var1 scripts\common\utility::allow_slide(var0);
    return;
  }
}