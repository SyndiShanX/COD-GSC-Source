/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_armoredtruck.gsc
****************************************************************/

function init() {
  var_0 = spawnStruct();
  var_0.weight = getdvarfloat("scr_br_pe_armoredtruck_weight", 0);
  var_0.ref_140CF = &ref_140CF;
  var_0.attackerswaittime = &attackerswaittime;
  var_0.ref_14382 = &ref_14382;
  var_0.postinitfunc = &postinitfunc;
  var_0.ref_11B78 = getdvarint("scr_br_pe_armoredtruck_max_times", 1);
  var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("armoredtruck", "20 20151510101010");
  var_0.pemetereventweights = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("armoredtruck");
  scripts\mp\gametypes\br_publicevents::ref_12B35(11, var_0);
}

function postinitfunc() {
  game["dialog"]["pe_armoredtruck_announcement"] = "public_events_armtrk_name";
  game["dialog"]["pe_armoredtruck_start"] = "public_events_armtrk_desc";
  game["dialog"]["pe_armoredtruck_done"] = "public_events_armtrk_active";
}

function ref_140CF() {
  return true;
}

function ref_14382() {
  level endon("game_ended");
  level endon("cancel_public_event");
  var_0 = forest_combat();
  wait var_0;
}

function attackerswaittime() {
  level endon("game_ended");
  level.callouts = [];
  scripts\mp\gametypes\br_publicevents::ref_13371("br_pe_armoredtruck_incoming");
  scripts\mp\gametypes\br_public::brleaderdialog("pe_armoredtruck_announcement");
  wait 3.5;
  scripts\mp\gametypes\br_public::brleaderdialog("pe_armoredtruck_start");
  var_0 = getdvarfloat("scr_br_pe_armoredtruck_delay", 20);
  var_1 = getdvarfloat("scr_br_pe_armoredtruck_duration", 10);
  var_2 = gettime() + var_0 * 1000;
  setomnvar("ui_publicevent_timer_type", 7);
  setomnvar("ui_publicevent_timer", var_2);
  var_3 = run_post_module_actions();
  var_4 = run_spawnfuncs(var_3);
  var_5 = spawn("script_origin", (0, 0, 0));
  var_5 hide();

  if(var_0 > 5) {
    wait var_0 - 5;

    for(var_6 = 0; var_6 < 5; var_6++) {
      var_5 playSound("ui_mp_fire_sale_timer");
      wait 1;
    }
  }

  scripts\mp\gametypes\br_gametype_truckwar::stoppingpower_givehcrdata();
  scripts\mp\gametypes\br_gametype_truckwar::stoppingpower_loadoutchangeremovehcr();
  level thread scripts\mp\gametypes\br_gametype_truckwar::ref_13DF8();

  foreach(var_8 in level.players) {
    var_8 playsoundtoplayer("ui_armored_truck_active_lr", var_8);
  }

  setomnvar("ui_publicevent_timer_type", 0);
  var_5 delete();
  scripts\mp\gametypes\br_public::brleaderdialog("pe_armoredtruck_done");
  wait 1.5;
  var_4 = scripts\engine\utility::array_randomize(var_4);
  thread ref_1360C(var_4);
}

function run_post_module_actions() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, createspawnlocation((-1424, 10054, 656), (0.0420106, 279.996, -0.133641)));
}

function createspawnlocation(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.angles = var_1;
  return var_2;
}

function forest_combat() {
  var_0 = getdvarfloat("scr_br_pe_armoredtruck_starttime_min", 90);
  var_1 = getdvarfloat("scr_br_pe_armoredtruck_starttime_max", 395);

  if(var_1 > var_0) {
    return randomfloatrange(var_0, var_1);
  }

  return var_0;
}

function run_spawnfuncs(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = spawn("script_model", var_3.origin);
    var_4 setModel("ks_airdrop_crate_br");
    var_4 setscriptablepartstate("smoke_signal", "on", 0);
    var_4 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(11, 17, 2, var_3.origin);
    var_4 scripts\mp\gametypes\br_quest_util::ref_1316F(1150);
    var_4 scripts\mp\gametypes\br_quest_util::ref_13369();
    var_4.location = var_3;
    var_1 = var_4;
  }

  return var_1;
}

function ref_1360C(var_0) {
  foreach(var_2 in var_0) {
    ref_1360B(var_2);
    wait 2;
  }

  level notify("public_event_armoredtruck_spawned");
}

function ref_1360B(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.location.origin + (0, 0, 5000);
  var_2 = scripts\mp\gametypes\br_gametype_truckwar::ref_14263(var_1);

  if(isDefined(var_2)) {
    level thread scripts\mp\gametypes\br_gametype_truckwar::ref_13DE4(var_2, var_0.location.origin, var_0.location.angles, 1);
    level.callouts[level.callouts.size] = var_2;
  }

  thread ref_14235(var_2, var_0);
  thread ref_14248(var_0);
}

function ref_14235(var_0, var_1) {
  var_0 waittill("vehicle_owner_update");
  var_1 scripts\mp\gametypes\br_quest_util::spawn_double_cargo();
  var_1 setscriptablepartstate("smoke_signal", "off", 0);
  var_1 delete();
}

function ref_14248(var_0) {
  while(isDefined(var_0)) {
    if(!scripts\mp\gametypes\br_circle::updateprestreamrespawn(var_0.location.origin)) {
      var_0 scripts\mp\gametypes\br_quest_util::spawn_double_cargo();
      break;
    }

    wait 1;
  }
}