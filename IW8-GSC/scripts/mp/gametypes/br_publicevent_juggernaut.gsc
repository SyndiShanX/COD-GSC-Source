/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_juggernaut.gsc
**************************************************************/

function init() {
  var0 = spawnStruct();
  var0.weight = getdvarfloat("scr_br_pe_juggernaut_weight", 1);
  var0.attackerswaittime = &attackerswaittime;
  var0.ref_140cf = &ref_140cf;
  var0.ref_14382 = &ref_14382;
  var0.‹Á¿ ø {
    ÏXX;
    â # / = &postinitfunc;
    var0.ref_11b78 = getdvarint("scr_br_pe_juggernaut_max_times", 1);
    var0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("juggernaut", "10 5 0 0 0 0 0 0");
    var0.£¼#w]
  j‹ ƒ½ Ï‚ UÀíÌI¸ Û« = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("juggernaut");
  scripts\mp\gametypes\br_publicevents::ref_12b35(4, var0);
}

function postinitfunc() {
  game["dialog"]["public_events_juggernaut_start"] = "public_events_juggernaut_start";
  var0 = getdvarint("scr_br_pe_juggernaut_drop_on_death", 0);
  scripts\mp\gametypes\br_jugg_common::strafe_internal("drop_on_death", var0, "public_event");
}

function ref_140cf() {
  return level.disable_super_in_turret.name != "jugg";
}

function ref_14382() {
  level endon("game_ended");
  level endon("cancel_public_event");
  var0 = forest_combat();
  wait var0;
}

function attackerswaittime() {
  var0 = scripts\mp\gametypes\br_jugg_common::resetafkchecks(getdvarint("scr_br_pe_juggernaut_dropNumTeamBased", 1));
  level.vehicle_isneutraltoplayer = scripts\engine\utility::array_randomize(level.vehicle_isneutraltoplayer);
  var1 = scripts\mp\gametypes\br_jugg_common::ref_1334b(var0, 0);
  scripts\mp\gametypes\br_public::brleaderdialog("public_events_juggernaut_start");
  level scripts\mp\gametypes\br_jugg_common::ref_1383f(var1, "public_event");
  ref_1436c();
}

function ref_1436c() {
  for(;;) {
    wait 1;
    var0 = 0;

    foreach(var2 in level.focus_fire_attacker_timeout) {
      if(var2.cratetype == "battle_royale_juggernaut") {
        var0 = 1;
        break;
      }
    }

    if(!var0) {
      break;
    }
  }
}

function forest_combat() {
  var0 = getdvarfloat("scr_br_pe_juggernaut_starttime_min", 795);
  var1 = getdvarfloat("scr_br_pe_juggernaut_starttime_max", 1110);

  if(var1 > var0) {
    return randomfloatrange(var0, var1);
  }

  return var0;
}