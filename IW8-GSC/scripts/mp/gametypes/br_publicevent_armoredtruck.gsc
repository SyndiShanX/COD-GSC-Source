/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_armoredtruck.gsc
****************************************************************/

function init() {
  var0 = spawnStruct();
  var0.weight = getdvarfloat("scr_br_pe_armoredtruck_weight", 0);
  var0.ref_140cf = &ref_140cf;
  var0.attackerswaittime = &attackerswaittime;
  var0.ref_14382 = &ref_14382;
  var0.‹Á¿ ø {
    ÏXX;
    â # / = &postinitfunc;
    var0.ref_11b78 = getdvarint("scr_br_pe_armoredtruck_max_times", 1);
    var0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("armoredtruck", "20 20151510101010");
    var0.£¼#w]
  j‹ ƒ½ Ï‚ UÀíÌI¸ Û« = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("armoredtruck");
  scripts\mp\gametypes\br_publicevents::ref_12b35(11, var0);
}

function postinitfunc() {
  game["dialog"]["pe_armoredtruck_announcement"] = "public_events_armtrk_name";
  game["dialog"]["pe_armoredtruck_start"] = "public_events_armtrk_desc";
  game["dialog"]["pe_armoredtruck_done"] = "public_events_armtrk_active";
}

function ref_140cf() {
  return true;
}

function ref_14382() {
  level endon("game_ended");
  level endon("cancel_public_event");
  var0 = forest_combat();
  wait var0;
}

function attackerswaittime() {
  level endon("game_ended");
  level.callouts = [];
  scripts\mp\gametypes\br_publicevents::ref_13371("br_pe_armoredtruck_incoming");
  scripts\mp\gametypes\br_public::brleaderdialog("pe_armoredtruck_announcement");
  wait 3.5;
  scripts\mp\gametypes\br_public::brleaderdialog("pe_armoredtruck_start");
  var0 = getdvarfloat("scr_br_pe_armoredtruck_delay", 20);
  var1 = getdvarfloat("scr_br_pe_armoredtruck_duration", 10);
  var2 = gettime() + var0 * 1000;
  setomnvar("ui_publicevent_timer_type", 7);
  setomnvar("ui_publicevent_timer", var2);
  var3 = run_post_module_actions();
  var4 = run_spawnfuncs(var3);
  var5 = spawn("script_origin", (0, 0, 0));
  var5 hide();

  if(var0 > 5) {
    wait var0 - 5;

    for(var6 = 0; var6 < 5; var6++) {
      var5 playSound("ui_mp_fire_sale_timer");
      wait 1;
    }
  }

  scripts\mp\gametypes\br_gametype_truckwar::stoppingpower_givehcrdata();
  scripts\mp\gametypes\br_gametype_truckwar::stoppingpower_loadoutchangeremovehcr();
  level thread scripts\mp\gametypes\br_gametype_truckwar::ref_13df8();

  foreach(var8 in level.players) {
    var8 playsoundtoplayer("ui_armored_truck_active_lr", var8);
  }

  setomnvar("ui_publicevent_timer_type", 0);
  var5 delete();
  scripts\mp\gametypes\br_public::brleaderdialog("pe_armoredtruck_done");
  wait 1.5;
  var4 = scripts\engine\utility::array_randomize(var4);
  thread ref_1360c(var4);
}

function run_post_module_actions() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, createspawnlocation((-1424, 10054, 656), (0.0420106, 279.996, -0.133641)));
}

function createspawnlocation(var0, var1) {
  var2 = spawnStruct();
  var2.origin = var0;
  var2.angles = var1;
  return var2;
}

function forest_combat() {
  var0 = getdvarfloat("scr_br_pe_armoredtruck_starttime_min", 90);
  var1 = getdvarfloat("scr_br_pe_armoredtruck_starttime_max", 395);

  if(var1 > var0) {
    return randomfloatrange(var0, var1);
  }

  return var0;
}

function run_spawnfuncs(var0) {
  var1 = [];

  foreach(var3 in var0) {
    var4 = spawn("script_model", var3.origin);
    var4 setModel("ks_airdrop_crate_br");
    var4 setscriptablepartstate("smoke_signal", "on", 0);
    var4 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(11, 17, 2, var3.origin);
    var4 scripts\mp\gametypes\br_quest_util::ref_1316f(1150);
    var4 scripts\mp\gametypes\br_quest_util::ref_13369();
    var4.location = var3;
    var1 = var4;
  }

  return var1;
}

function ref_1360c(var0) {
  foreach(var2 in var0) {
    ref_1360b(var2);
    wait 2;
  }

  level notify("public_event_armoredtruck_spawned");
}

function ref_1360b(var0) {
  var1 = spawnStruct();
  var1.origin = var0.location.origin + (0, 0, 5000);
  var2 = scripts\mp\gametypes\br_gametype_truckwar::ref_14263(var1);

  if(isDefined(var2)) {
    level thread scripts\mp\gametypes\br_gametype_truckwar::ref_13de4(var2, var0.location.origin, var0.location.angles, 1);
    level.callouts[level.callouts.size] = var2;
  }

  thread ref_14235(var2, var0);
  thread ref_14248(var0);
}

function ref_14235(var0, var1) {
  var0 waittill("vehicle_owner_update");
  var1 scripts\mp\gametypes\br_quest_util::spawn_double_cargo();
  var1 setscriptablepartstate("smoke_signal", "off", 0);
  var1 delete();
}

function ref_14248(var0) {
  while(isDefined(var0)) {
    if(!scripts\mp\gametypes\br_circle::updateprestreamrespawn(var0.location.origin)) {
      var0 scripts\mp\gametypes\br_quest_util::spawn_double_cargo();
      break;
    }

    wait 1;
  }
}