/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_loadoutdrop.gsc
***************************************************************/

function init() {
  var_0 = spawnStruct();
  var_0.attackerswaittime = &ascendermodelview;
  var_0.isfeaturedisabled = &deactivate;
  var_0.ref_14382 = &ref_14382;
  var_0.postinitfunc = &postinitfunc;
  var_0.weight = getdvarfloat("scr_br_pe_loadoutdrop_weight", 0);
  var_0.ref_11B78 = getdvarint("scr_br_pe_loadoutdrop_max_times", 2);
  var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("loadoutdrop", "01010100000000 10102025");
  var_0.pemetereventweights = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("loadoutdrop");
  scripts\mp\gametypes\br_publicevents::ref_12B35(8, var_0);
}

function postinitfunc() {
  if(getdvarint("scr_br_pe_loadout_event_only", 0)) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("drogBagLoadout");
    return;
  }
}

function ref_14382() {
  level endon("game_ended");
  level endon("cancel_public_event");

  if(getdvarint("scr_br_loadout_delay", 0) == 1 && level.br_circle.circleindex <= 1) {
    level waittill("br_circle_closing");
    return;
  }
}

function ascendermodelview() {
  if(getdvarint("scr_br_loadout_delay", 0) == 1 && level.br_circle.circleindex <= 1) {
    level waittill("br_circle_closing");
    wait 5;
  }

  thread scripts\mp\gametypes\br_rewards::initdropbagsystem();
  thread scripts\mp\gametypes\br::cleanupdropbagsoncircle();
  var_0 = 0;
  thread scripts\mp\gametypes\br_rewards::ref_1284D(var_0);
  var_1 = "supply_drop";
  scripts\mp\gametypes\br_armory_kiosk::ref_13169(var_1, 0);
}

function deactivate() {}