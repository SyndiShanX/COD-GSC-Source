/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_restock.gsc
***********************************************************/

function init() {
  var0 = spawnStruct();
  var0.weight = getdvarfloat("scr_br_pe_restock_weight", 0);
  var0.ref_140cf = &ref_140cf;
  var0.ref_14382 = &ref_14382;
  var0.attackerswaittime = &attackerswaittime;
  var0.isfeaturedisabled = &isfeaturedisabled;
  var0.‹Á¿ ø {
    ÏXX;
    â # / = &postinitfunc;
    var0.ref_11b78 = getdvarint("scr_br_pe_restock_max_times", 2);
    var0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("restock", "00 5 5 10151513");
    var0.£¼#w]
  j‹ ƒ½ Ï‚ UÀíÌI¸ Û« = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("restock");
  scripts\mp\gametypes\br_publicevents::ref_12b35(6, var0);
}

function postinitfunc() {
  game["dialog"]["power_up_field_resupply"] = "power_up_field_resupply";
  level.ref_12129 = [];
}

function ref_140cf() {
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

  foreach(var1 in level.ref_12129) {
    if(var1.type == "br_reusable_loot_cache") {
      var1 setscriptablepartstate("body", "vfx9");
      var2 = getdvarint("scr_reusable_cache_loot_sets", 3);
      var1.intel_collected = (var1.intel_collected + 1) % var2;
      var1 notify("closed");
      var3 = "closing";
    } else {
      var3 = "set_to_closed";
    }

    var1 setscriptablepartstate("body", var3);
  }
}

function isfeaturedisabled() {}

function ref_12cc0() {
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

function ref_12c00() {
  if(scripts\engine\utility::array_contains(level.ref_12129, self)) {
    level.ref_12129 = scripts\engine\utility::array_remove(level.ref_12129, self);
    return;
  }
}