/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_restock.gsc
***********************************************************/

function init() {
  var_0 = spawnStruct();
  var_0.weight = getdvarfloat("scr_br_pe_restock_weight", 0);
  var_0.ref_140CF = &ref_140CF;
  var_0.ref_14382 = &ref_14382;
  var_0.attackerswaittime = &attackerswaittime;
  var_0.isfeaturedisabled = &isfeaturedisabled;
  var_0.postinitfunc = &postinitfunc;
  var_0.ref_11B78 = getdvarint("scr_br_pe_restock_max_times", 2);
  var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("restock", "00 5 5 10151513");
  var_0.pemetereventweights = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("restock");
  scripts\mp\gametypes\br_publicevents::ref_12B35(6, var_0);
}

function postinitfunc() {
  game["dialog"]["power_up_field_resupply"] = "power_up_field_resupply";
  level.ref_12129 = [];
}

function ref_140CF() {
  return true;
}

function ref_14382() {
  level endon("game_ended");
  level endon("cancel_public_event");
}

function attackerswaittime() {
  level endon("game_ended");
  scripts\mp\gametypes\br_publicevents::ref_13371("br_pe_restock_start");
  scripts\mp\gametypes\br_public::brleaderdialog("power_up_field_resupply", 1);

  foreach(var_1 in level.ref_12129) {
    if(var_1.type == "br_reusable_loot_cache") {
      var_1 setscriptablepartstate("body", "vfx9");
      var_2 = getdvarint("scr_reusable_cache_loot_sets", 3);
      var_1.intel_collected = (var_1.intel_collected + 1) % var_2;
      var_1 notify("closed");
      var_3 = "closing";
    } else {
      var_3 = "set_to_closed";
    }

    var_1 setscriptablepartstate("body", var_3);
  }
}

function isfeaturedisabled() {}

function ref_12CC0() {
  level endon("game_ended");
  self endon("death");

  switch (self.type) {
    case "br_loot_cache_reddoor":
    case "br_loot_cache_rogue":
    case "br_reusable_loot_cache":
    case "br_loot_cache":
    case "br_loot_cache_lege":
      level.ref_12129[level.ref_12129.size] = self;
      break;
    default:
      return;
  }
}

function use_dropkit_marker() {
  return istrue(level.delayeventfired) && getdvarfloat("scr_br_pe_restock_weight", 0) || istrue(level.delete_crate_objectives);
}

function ref_12C00() {
  if(scripts\engine\utility::array_contains(level.ref_12129, self)) {
    level.ref_12129 = scripts\engine\utility::array_remove(level.ref_12129, self);
    return;
  }
}