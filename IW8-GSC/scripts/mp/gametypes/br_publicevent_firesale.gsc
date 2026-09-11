/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_firesale.gsc
************************************************************/

function init() {
  var0 = spawnStruct();
  var0.ref_140cf = &ref_140cf;
  var0.weight = getdvarfloat("scr_br_pe_firesale_weight", 1);
  var0.attackerswaittime = &attackerswaittime;
  var0.ref_14382 = &ref_14382;
  var0.‹Á¿ ø {
    ÏXX;
    â # / = &postinitfunc;
    var0.ref_11b78 = getdvarint("scr_br_pe_firesale_max_times", 1);
    var0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("firesale", "05 101010101010");
    var0.£¼#w]
  j‹ ƒ½ Ï‚ UÀíÌI¸ Û« = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("firesale");
  scripts\mp\gametypes\br_publicevents::ref_12b35(2, var0);
}

function postinitfunc() {
  game["dialog"]["public_events_firesale_start"] = "public_events_fire_sale_start";
  game["dialog"]["public_events_firesale_end"] = "public_events_fire_sale_end";
}

function ref_140cf() {
  if(!isDefined(level.br_circle)) {
    return false;
  }

  if(isDefined(level.br_circle.circleindex) && level.br_circle.circleindex <= 1) {
    return true;
  }

  var0 = scripts\mp\gametypes\br_armory_kiosk::resetarenaomnvardata();
  return var0 >= 1;
}

function ref_14382() {
  level endon("game_ended");
  level endon("cancel_public_event");
  var0 = forest_combat();
  wait var0;
}

function relic_squadlink_add_visionset() {
  var0 = getdvarfloat("scr_br_pe_firesale_duration", 90);
  var1 = isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) && level.br_circle.circleindex != -1;
  var2 = getdvarint("scr_br_pe_firesale_bound_under_circleduration", 1) == 1;

  if(var2 && var1) {
    var0 = min(var0, scripts\mp\gametypes\br_circle::inithelirepository());
  }

  var3 = getdvarint("scr_br_pe_firesale_override_with_circleduration", 0) == 1;

  if(var3 && var1) {
    var0 = scripts\mp\gametypes\br_circle::inithelirepository();
  }

  var4 = getdvarint("scr_br_pe_firesale_minDuration", 15);
  var0 = max(var0, var4);
  return var0;
}

function attackerswaittime() {
  level endon("game_ended");
  level notify("public_event_firesale_start");
  scripts\mp\gametypes\br_publicevents::ref_13371("br_pe_firesale_start");
  scripts\mp\gametypes\br_public::brleaderdialog("public_events_firesale_start");
  setomnvar("ui_publicevent_minimap_pulse", 1);
  setomnvar("ui_publicevent_timer_type", 1);
  var0 = relic_squadlink_add_visionset();
  var1 = gettime() + var0 * 1000;
  setomnvar("ui_publicevent_timer", var1);
  var2 = spawn("script_origin", (0, 0, 0));
  var2 hide();
  var3 = 5;

  if(var0 > var3) {
    wait var0 - var3;
  } else {
    var3 = int(var0);
  }

  for(var4 = 0; var4 < var3; var4++) {
    var2 playSound("ui_mp_fire_sale_timer");
    wait 1;
  }

  scripts\mp\gametypes\br_publicevents::neurotoxin_mask_monitor(2);
  level notify("public_event_firesale_end");
  scripts\mp\gametypes\br_publicevents::ref_13371("br_pe_firesale_end");
  scripts\mp\gametypes\br_public::brleaderdialog("public_events_firesale_end");
  setomnvar("ui_publicevent_minimap_pulse", 0);
  setomnvar("ui_publicevent_timer_type", 0);
  var2 delete();
}

function forest_combat() {
  var0 = getdvarfloat("scr_br_pe_firesale_starttime_min", 795);
  var1 = getdvarfloat("scr_br_pe_firesale_starttime_max", 1110);

  if(var1 > var0) {
    return randomfloatrange(var0, var1);
  }

  return var0;
}