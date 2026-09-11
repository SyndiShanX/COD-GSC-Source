/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58279.gsc
***********************************************/

function activate_laser_trap_parent() {}

function init() {
  thread_endon_death();
  var_0 = spawnStruct();
  var_0.weight = getdvarfloat("scr_pe_bonus_point_crate_weight", 1);
  var_0.attackerswaittime = &attackerswaittime;
  var_0.ref_140cf = &ref_140cf;
  var_0.ref_14382 = &ref_14382;
  var_0.ref_11b78 = getdvarint("scr_pe_bonus_point_crate_max_times", 1);
  var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("hardpoint", "10 5 0 00 0 0 0");
  scripts\mp\gametypes\br_publicevents::ref_12b35(102, var_0);
  subtract_from_spawn_count_from_group();
}

function subtract_from_spawn_count_from_group() {
  game["dialog"]["bonus_point_crates_started"] = "bonus_point_crates_started";
}

function thread_endon_death() {
  if(!isDefined(level.current_safehouse_spawn_structs)) {
    level.current_safehouse_spawn_structs = spawnStruct();
  }

  level.current_safehouse_spawn_structs.spectatenumber = getdvarint("scr_pe_bonus_point_crate_incoming_warning_time", 20);
  level.current_safehouse_spawn_structs.parachute_spawn = getdvarint("scr_pe_bonus_point_crate_splash_duration", 3);
  level.current_safehouse_spawn_structs.specialistbr = getdvarint("scr_pe_bonus_point_crate_drops_total", 6);
  level.current_safehouse_spawn_structs.specialdayloadouts = getdvarint("scr_pe_bonus_point_crate_drops_first", 3);
  level.current_safehouse_spawn_structs.spectateprop = getdvarint("scr_pe_points_per_crate_capture", 10);
  level.current_safehouse_spawn_structs.parachutecancutautodeploy = getdvarfloat("scr_pe_delay_between_crate_drops", 30);
  level.current_safehouse_spawn_structs.spectatableprops = getdvarint("scr_pe_dogtags_accept_double_points", 0);
  level.current_safehouse_spawn_structs.spawnzombiedogtags = getdvarfloat("scr_pe_bonus_point_crate_capture_time", 5);
}

function ref_140cf() {
  return false;
}

function ref_14382() {
  level endon("game_ended");
  level endon("cancel_public_event");
  var_0 = forest_combat();
  wait var_0;
}

function forest_combat() {
  var_0 = getdvarfloat("scr_pe_bonus_point_crate_starttime_min", 795);
  var_1 = getdvarfloat("scr_pe_bonus_point_crate_starttime_max", 1110);

  if(var_1 > var_0) {
    return randomfloatrange(var_0, var_1);
  }

  return var_0;
}

function attackerswaittime() {
  level thread scripts\mp\gametypes\br_public::brleaderdialog("bonus_point_crates_started", 0);
  ref_12293();
}

function ref_12aee(var_0) {
  if(!isDefined(self.arena_bot_pickup_weapon)) {
    self.arena_bot_pickup_weapon = [];
  }

  self.arena_bot_pickup_weapon[self.arena_bot_pickup_weapon.size] = var_0;
}

function ref_12293() {
  level endon("game_ended");
  ref_12291();
  thread ref_12290(level);

  if(getdvarint("scr_rumble_skip_event_wait_times", 0) == 0) {
    _utilflare_lerpflare::ref_12424("br_rumble_pe_bonus_point_crates_incoming");
    wait level.current_safehouse_spawn_structs.spectatenumber;
  }

  _utilflare_lerpflare::ref_12424("br_rumble_pe_bonus_point_crates_online");
  wait level.current_safehouse_spawn_structs.parachute_spawn;
  thread ref_12292();
}

function ref_12291() {
  level.current_safehouse_spawn_structs.ref_12e29 = spawnStruct();
  level.current_safehouse_spawn_structs.ref_12e29.aq_ontimerupdate = [];
  level.current_safehouse_spawn_structs.ref_12e29.are_all_alive_players_touching_plane = [];

  if(!isDefined(level.current_safehouse_spawn_structs.ref_12e2c.arena_bot_pickup_weapon)) {
    var_0 = (0, 0, 0);

    if(isDefined(level.current_safehouse_spawn_structs.ref_12e2c.ground_detection_think)) {
      var_0 = level.current_safehouse_spawn_structs.ref_12e2c.ground_detection_think;
    }

    level.current_safehouse_spawn_structs.ref_12e2c.arena_bot_pickup_weapon = [var_0 + (0, 0, 0), var_0 + (1500, 1500, 0), var_0 + (1500, -1500, 0), var_0 + (-1500, 1500, 0), var_0 + (-1500, -1500, 0), var_0 + (3000, 3000, 0), var_0 + (3000, -3000, 0), var_0 + (-3000, 3000, 0), var_0 + (-3000, -3000, 0)];
  }

  level.current_safehouse_spawn_structs.ref_12e2c.arena_bot_pickup_weapon = scripts\engine\utility::array_randomize(level.current_safehouse_spawn_structs.ref_12e2c.arena_bot_pickup_weapon);
  var_1 = scripts\cp_mp\killstreaks\airdrop::getleveldata("ri_bonus_points_crate");
  var_1.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
  var_1.dummymodel = "military_carepackage_01_br_legendary";
  var_1.friendlymodel = undefined;
  var_1.enemymodel = undefined;
  var_1.mountmantlemodel = undefined;
  var_1.supportsownercapture = 0;
  var_1.headicon = undefined;
  var_1.minimapicon = undefined;
  var_1.usepriority = -1;
  var_1.usefov = 180;
  var_1.timeout = undefined;
  var_1.friendlyuseonly = 0;
  var_1.ownerusetime = level.current_safehouse_spawn_structs.spawnzombiedogtags;
  var_1.otherusetime = level.current_safehouse_spawn_structs.spawnzombiedogtags;
  var_1.activatecallback = &ref_1228a;
  var_1.capturecallback = &ref_1228b;
  var_1.destroyoncapture = 1;
}

function ref_12292() {
  level endon("game_ended");
  var_0 = level.current_safehouse_spawn_structs.specialdayloadouts;
  var_1 = level.current_safehouse_spawn_structs.specialistbr - var_0;
  ref_12294(var_0);

  if(level.current_safehouse_spawn_structs.parachutecancutautodeploy > level.current_safehouse_spawn_structs.spectatenumber) {
    wait level.current_safehouse_spawn_structs.parachutecancutautodeploy - level.current_safehouse_spawn_structs.spectatenumber;
  }

  thread ref_12290(level, var_1);
  wait level.current_safehouse_spawn_structs.spectatenumber;
  _utilflare_lerpflare::ref_12424("br_rumble_pe_bonus_point_crates_online");
  wait level.current_safehouse_spawn_structs.parachute_spawn;
  ref_12294(var_1, var_0);
}

function ref_12294(var_0, var_1) {
  level endon("game_ended");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_3 = level.current_safehouse_spawn_structs.ref_12e2c.arena_bot_pickup_weapon[var_2 + var_1];
    var_3 += (0, 0, 2000);
    var_4 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "ri_bonus_points_crate", var_3, (0, randomint(360), 0));
    level.current_safehouse_spawn_structs.ref_12e29.aq_ontimerupdate[level.current_safehouse_spawn_structs.ref_12e29.aq_ontimerupdate.size] = var_4;
    thread ref_1228d();
    thread ref_1228e();
    wait 2.5;
  }
}

function ref_1228d() {
  var_0 = scripts\engine\utility::drop_to_ground(self.origin, 50, -3000, (0, 0, 1));
  self.molotov_delete_oldest_trigger = spawn("script_model", var_0 + (0, 0, 3));
  self.molotov_delete_oldest_trigger setModel("scr_smoke_grenade");
  wait 1;
  self.molotov_delete_oldest_trigger setscriptablepartstate("smoke", "on");
  self.molotov_delete_oldest_trigger setscriptablepartstate("br_rumble_bonus_point_audio", "smoke_sfx");
}

function ref_1228e() {
  var_0 = scripts\engine\utility::ter_op(level.current_safehouse_spawn_structs.spectateprop == 10, "bonus_points_10", "bonus_points");

  if(isDefined(level.current_safehouse_spawn_structs.specialistperk)) {
    var_0 = level.current_safehouse_spawn_structs.specialistperk;
  }

  self setscriptablepartstate("objective", var_0);
}

function ref_12290(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  for(var_2 = 0; var_2 < var_0; var_2++) {
    if(!isDefined(level.current_safehouse_spawn_structs.ref_12e2c.arena_bot_pickup_weapon[var_2 + var_1])) {
      return;
    }

    thread ref_1228f(level);
    wait 2;
  }
}

function ref_1228f(var_0) {
  var_1 = level.current_safehouse_spawn_structs.ref_12e2c.arena_bot_pickup_weapon[var_0];
  scripts\mp\gametypes\br_quest_util::ref_140b1(var_1, "dom");
}

function ref_1228a(var_0) {
  if(istrue(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
      return;
    }

    return;
  }
}

function ref_1228b(var_0) {
  level.current_safehouse_spawn_structs.ref_12e29.aq_ontimerupdate = scripts\engine\utility::array_remove(level.current_safehouse_spawn_structs.ref_12e29.aq_ontimerupdate, self);
  self setscriptablepartstate("jugg_drop_beacon", "off");
  self setscriptablepartstate("bonus_points_audio", "expl_sfx");
  thread ref_1228c(level);
  self notify("captured");
  playFX(scripts\engine\utility::getfx("vfx_golden_loot_explosion_flare"), self.origin);
  var_1 = randomintrange(3, 5);
  level thread _handlevehiclerepair::ref_13673("bonus_points_crate", self.origin, var_1, 0);
  level scripts\mp\gamescore::giveteamscoreforobjective(var_0.pers["team"], level.current_safehouse_spawn_structs.spectateprop, 0);

  if(isDefined(self.objectiveiconid)) {
    objective_delete(self.objectiveiconid);
  }

  playFX(level.conf_fx["vanish"], self.molotov_delete_oldest_trigger.origin);
  self.molotov_delete_oldest_trigger delete();
}

function ref_1228c(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2) && isDefined(var_2.team) && var_2.team == var_0) {
      var_2 thread scripts\mp\hud_message::showsplash("br_rumble_pe_bonus_point_crate_captured_ally");
    }
  }
}