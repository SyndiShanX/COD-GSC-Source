/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_publicevent_firesale.gsc
***************************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\hud_util;
#namespace br_publicevent_firesale;

function autoexec main() {
  scripts\mp\gametypes\br_publicevents::function_dbc8f6cb3760cd82(%"firesale", &init);
}

function init(eventinfo) {
  eventinfo.canactivatefunc = &canactivatefunc;
  eventinfo.activatefunc = &activatefunc;
  eventinfo.waitfunc = &waitfunc;
  eventinfo.postinitfunc = &postinitfunc;
}

function postinitfunc() {
  game["dialog"]["public_events_firesale_start"] = "pblc_grav_frsc";
  game["dialog"]["public_events_firesale_end"] = "pblc_grav_frsn";
}

function canactivatefunc() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) && level.br_circle.circleindex <= 1) {
    return true;
  }

  var_35c1e70b1d29218 = scripts\mp\gametypes\br_armory_kiosk::function_8301ce82f0ae1be6();
  return var_35c1e70b1d29218 >= 1;
}

function waitfunc() {
  level endon("game_ended");
  level endon("cancel_public_event");
  eventstarttime = calculateeventstarttime();
  wait eventstarttime;
}

function activatefunc() {
  level endon("game_ended");
  scripts\mp\gametypes\br_publicevents::showsplashtoall("br_pe_firesale_start");
  scripts\mp\gametypes\br_public::brleaderdialog("public_events_firesale_start", undefined, undefined, undefined, 1.5);
  setomnvar("ui_minimap_pulse", 1);
  setomnvar("ui_publicevent_timer_type", 1);
  eventduration = getduration();
  eventendtime = gettime() + eventduration * 1000;
  setomnvar("ui_publicevent_timer", eventendtime);
  clockobject = spawn("script_origin", (0, 0, 0));
  clockobject hide();

  if(isDefined(level.var_a4078546548cb0a)) {
    [[level.var_a4078546548cb0a]]();
  }

  level notify("public_event_firesale_start");
  var_49978e5850a50d57 = 5;

  if(eventduration > var_49978e5850a50d57) {
    wait eventduration - var_49978e5850a50d57;
  } else {
    var_49978e5850a50d57 = int(eventduration);
  }

  for(i = 0; i < var_49978e5850a50d57; i++) {
    clockobject playSound("ui_mp_fire_sale_timer");
    wait 1;
  }

  if(isDefined(level.var_4fecf02c9241f7f0)) {
    [[level.var_4fecf02c9241f7f0]]();
  }

  scripts\mp\gametypes\br_publicevents::function_2907d01a7d692108(%"firesale");
  level notify("public_event_firesale_end");
  showsplashtoall("br_pe_firesale_end");
  scripts\mp\gametypes\br_public::brleaderdialog("public_events_firesale_end", undefined, undefined, undefined, 1.5);
  setomnvar("ui_minimap_pulse", 0);
  setomnvar("ui_publicevent_timer_type", 0);
  clockobject delete();
}

function getduration() {
  eventduration = getdvarfloat(@ "hash_104f9a52db6ef74", 90);
  var_cc5318567913f501 = isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) && level.br_circle.circleindex != -1;
  var_543c8e4d624ff7a3 = getdvarint(@ "hash_cc7fed1c42605966", 1) == 1;

  if(var_543c8e4d624ff7a3 && var_cc5318567913f501) {
    eventduration = min(eventduration, scripts\mp\gametypes\br_circle::function_abbfb4d18d1a9ca7());
  }

  var_8812000c33aed3c9 = getdvarint(@ "hash_18c9ea0970a9d3aa", 0) == 1;

  if(var_8812000c33aed3c9 && var_cc5318567913f501) {
    eventduration = scripts\mp\gametypes\br_circle::function_abbfb4d18d1a9ca7();
  }

  minduration = getdvarint(@ "hash_394bce38a6950030", 15);
  eventduration = max(eventduration, minduration);
  return eventduration;
}

function calculateeventstarttime() {
  minstarttime = getdvarfloat(@ "scr_br_pe_firesale_starttime_min", 795);
  maxstarttime = getdvarfloat(@ "scr_br_pe_firesale_starttime_max", 1110);

  if(maxstarttime > minstarttime) {
    return randomfloatrange(minstarttime, maxstarttime);
  }

  return minstarttime;
}