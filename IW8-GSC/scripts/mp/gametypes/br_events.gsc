/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_events.gsc
***********************************************/

function disable_spawnpoints_in_hangar() {
  var0 = getdvarint("scr_br_events", 0);

  if(!var0 || var0 > 4) {
    return;
  }

  thread ref_12e04(var0);
}

function disable_spawner(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(istrue(var0.delay_enter_combat_after_investigating_grenade) || !isalive(var0) || istrue(var0.gulag)) {
    return false;
  }

  return true;
}

function ref_12e04(var0) {
  if(scripts\mp\gametypes\br_public::turret_headicon()) {
    return;
  }

  var1 = "scr_br_event" + var0;
  var2 = getdvarfloat(var1 + "_chance", 0.04);

  if(var2 <= randomfloat(1)) {
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  var3 = getdvarfloat(var1 + "_start_time_min", 180);
  var4 = getdvarfloat(var1 + "_start_time_max", 300);
  var5 = randomfloat(var4 - var3) + var3;
  wait var5;

  foreach(var7 in level.players) {
    if(!disable_spawner(var7)) {
      continue;
    }

    self setclientomnvar("ui_br_events", var0);
  }
}