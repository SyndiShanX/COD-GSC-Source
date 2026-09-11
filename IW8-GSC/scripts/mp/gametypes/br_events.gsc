/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_events.gsc
***********************************************/

function disable_spawnpoints_in_hangar() {
  var_0 = getdvarint("scr_br_events", 0);

  if(!var_0 || var_0 > 4) {
    return;
  }

  thread ref_12e04(var_0);
}

function disable_spawner(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(istrue(var_0.delay_enter_combat_after_investigating_grenade) || !isalive(var_0) || istrue(var_0.gulag)) {
    return false;
  }

  return true;
}

function ref_12e04(var_0) {
  if(scripts\mp\gametypes\br_public::turret_headicon()) {
    return;
  }

  var_1 = "scr_br_event" + var_0;
  var_2 = getdvarfloat(var_1 + "_chance", 0.04);

  if(var_2 <= randomfloat(1)) {
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  var_3 = getdvarfloat(var_1 + "_start_time_min", 180);
  var_4 = getdvarfloat(var_1 + "_start_time_max", 300);
  var_5 = randomfloat(var_4 - var_3) + var_3;
  wait var_5;

  foreach(var_7 in level.players) {
    if(!disable_spawner(var_7)) {
      continue;
    }

    self setclientomnvar("ui_br_events", var_0);
  }
}