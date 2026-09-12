/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_lootcratedrop.gsc
*****************************************************************/

function init() {
  var_0 = spawnStruct();
  var_0.ref_11B78 = getdvarint("scr_br_pe_plunder_crate_max_times", 2);
  var_0.isfeaturedisabled = &deactivate;
  var_0.ref_140CF = &ref_140D1;
  var_0.attackerswaittime = &atv_initdamage;
  var_0.postinitfunc = &postinitplundercrate;
  var_0.weight = getdvarfloat("scr_br_pe_plunder_crate_weight", 0);
  var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("plunder_crate", "20 15101010151010");
  var_0.pemetereventweights = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("plunder_crate");
  scripts\mp\gametypes\br_publicevents::ref_12B35(12, var_0);
  var_0 = spawnStruct();
  var_0.ref_11B78 = getdvarint("scr_br_pe_weapon_crate_max_times", 2);
  var_0.isfeaturedisabled = &deactivate;
  var_0.attackerswaittime = &aud_breached_exit_wind;
  var_0.ref_140CF = &ref_140D8;
  var_0.postinitfunc = &postinitweaponcrate;
  var_0.weight = getdvarfloat("scr_br_pe_weapon_crate_weight", 0);
  var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("weapon_crate", "20 15101010152025");
  var_0.pemetereventweights = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("weapon_crate");
  scripts\mp\gametypes\br_publicevents::ref_12B35(13, var_0);
  var_0 = spawnStruct();
  var_0.ref_11B78 = getdvarint("scr_br_pe_medical_crate_max_times", 2);
  var_0.isfeaturedisabled = &deactivate;
  var_0.ref_140CF = &validatemedicalcrate;
  var_0.attackerswaittime = &activatemedicalcrate;
  var_0.postinitfunc = &postinitmedicalcrate;
  var_0.weight = getdvarfloat("scr_br_pe_medical_crate_weight", 0);
  var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("medical_crate", "20 15101010152025");
  var_0.pemetereventweights = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("medical_crate");
  scripts\mp\gametypes\br_publicevents::ref_12B35(20, var_0);
}

function postinitplundercrate() {
  postinitfunc();
}

function postinitweaponcrate() {
  postinitfunc();
}

function postinitmedicalcrate() {
  postinitfunc();
}

function postinitfunc() {
  if(isDefined(level.lootcratepostinit)) {
    return;
  }

  level.lootcratepostinit = 1;
  game["dialog"]["cash_drop"] = "bm_event_airdrop";
  game["dialog"]["weapon_drop"] = "drop_resupply";
  game["dialog"]["medical_drop"] = "medical_announcement";
  level.conf_fx["vanish"] = loadfx("vfx/core/impacts/small_snowhit");

  if(istrue(level.ref_1406F)) {
    level.ref_11A1F = level.minigun_warning_time;
    level.ref_1395A = [];
    return;
  }
}

function ref_140D1() {
  var_0 = scripts\mp\gametypes\br_armory_kiosk::resetarenaomnvardata();
  return var_0 >= 1;
}

function ref_140D8() {
  return true;
}

function validatemedicalcrate() {
  return true;
}

function atv_initdamage() {
  attackpressed(3);
}

function aud_breached_exit_wind() {
  attackpressed(1);
}

function activatemedicalcrate() {
  attackpressed(2);
}

function attackpressed(var_0) {
  level.br_pe_crate_usetimeoverride = getdvarfloat("scr_br_pe_crate_use_time", 5);
  var_1 = spawnStruct();

  switch (var_0) {
    case 1:
      if(!isDefined(level.shutdownattractionicontrigger)) {
        level thread scripts\mp\gametypes\br_heavy_weapon_drop::init();
      }

      var_1.delayeddetachbreak = "heavy_weapon_crate";
      var_1.delaydropbags = "heavy_weapon_public";
      var_1.delayed_depositing = "pe_chopper_crate";
      var_1.delayedattach = "pe_chopper_on";
      var_1.delayeddetach = "br_pe_weapon_crate_start";
      var_1.delaydestroyhudelem = "weapon_drop";
      level.delete_ai = 1;
      break;
    case 2:
      if(!isDefined(level.medical_crates)) {
        level thread scripts\mp\gametypes\br_medical_crate_drop::init();
      }

      var_1.delayeddetachbreak = "medical_crate";
      var_1.delaydropbags = "medical_supplies";
      var_1.delayed_depositing = "pe_chopper_crate";
      var_1.delayedattach = "pe_chopper_on";
      var_1.delayeddetach = "br_pe_medical_crate_start";
      var_1.delaydestroyhudelem = "medical_drop";
      level.delete_ai = 0;
      level.br_pe_crate_usetimeoverride = scripts\mp\gametypes\br_medical_crate_drop::getusetimeoverride();
      break;
    case 3:
      level.delayed_explosion_things = getdvarint("scr_br_pe_loadoutdrop_amount", 15000);
      level thread scripts\mp\gametypes\br_lootchopper::init();
      level thread scripts\cp_mp\killstreaks\airdrop::teamplunderexfil();
      var_1.delayeddetachbreak = "battle_royale_chopper_loot";
      var_1.delaydropbags = "active";
      var_1.delayed_depositing = "cashdrop_common_world";
      var_1.delayedattach = "on";
      var_1.delayeddetach = "br_pe_cash_crate_start";
      var_1.delaydestroyhudelem = "cash_drop";
      level.delete_ai = 0;
      break;
  }

  var_2 = scripts\cp_mp\killstreaks\airdrop::getleveldata(var_1.delayeddetachbreak);
  var_2.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
  var_2.minimapicon = undefined;

  if(isDefined(var_2.objectiveiconoverride)) {
    var_1.delaydropbags = var_2.objectiveiconoverride;
  }

  if(!istrue(var_2.disablesplash)) {
    scripts\mp\gametypes\br_publicevents::ref_13371(var_1.delayeddetach);
  }

  scripts\mp\gametypes\br_public::brleaderdialog(var_1.delaydestroyhudelem, 1);
  var_3 = scripts\mp\utility\teams::resetchallengetimer();
  var_4 = getdvarint("scr_br_pe_loadoutdrop_numTeamsPerCrates", 3);

  if(var_0 == 2) {
    var_5 = getdvarint("scr_br_pe_medicaldrop_minCrates", 5);
  } else {
    var_5 = getdvarint("scr_br_pe_loadoutdrop_minCrates", 10);
  }

  var_6 = int(max(var_5, var_4 / var_5));
  var_7 = [];
  var_8 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var_9 = scripts\mp\gametypes\br_circle::getdangercircleradius();

  for(var_10 = 0; var_10 < var_6; var_10++) {
    if(istrue(level.ref_1406F)) {
      var_7 = return_same_module_as_next_module(var_8, var_9);
      continue;
    }

    var_7 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var_8, var_9, 0.1, 0.9, 1);
  }

  level.delete_covernodes = [];

  foreach(var_12 in var_7) {
    if(isDefined(var_12)) {
      var_13 = undefined;
      var_14 = undefined;
      var_15 = var_2.delayeddetachbreak;
      var_16 = (var_12[0], var_12[1], var_12[2] + 10000);
      var_17 = (0, randomfloat(360), 0);
      var_18 = var_12;
      var_19 = scripts\cp_mp\killstreaks\airdrop::dropcrate(var_13, var_14, var_15, var_16, var_17, var_18);

      if(!isDefined(var_19)) {
        continue;
      }

      if(!istrue(var_3.disablecratedropvfx)) {
        var_19 setscriptablepartstate("trail", "active", 0);
        var_19.ref_13428 = spawn("script_model", var_16 + (0, 0, 58));
        var_19.ref_13428 setModel("ks_airdrop_crate_br");
        var_19.ref_13428 linkTo(var_19);
        var_19.ref_13428 setscriptablepartstate("smoke_trail", "on");
      }

      if(isDefined(var_2.delaydropbags)) {
        var_19 setscriptablepartstate("objective", var_2.delaydropbags);
      }

      if(isDefined(var_2.delayed_depositing)) {
        var_19 setscriptablepartstate("objective_map", var_2.delayed_depositing);
      }

      var_20 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var_19);
      var_20.ref_140A0 = level.br_pe_crate_usetimeoverride;
      level.delete_covernodes[level.delete_covernodes.size] = var_19;
    }
  }
}

function deactivate() {
  foreach(var_1 in level.delete_covernodes) {
    if(!isDefined(var_1)) {
      continue;
    }

    playFX(level.conf_fx["vanish"], var_1.origin);

    if(isDefined(var_1.ref_13428)) {
      var_1.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
      var_1.ref_13428 delete();
    }

    var_1 scripts\cp_mp\killstreaks\airdrop::lastactivateinstruct();
    level.delete_covernodes = scripts\engine\utility::array_remove(level.delete_covernodes, var_1);
  }
}

function return_same_module_as_next_module(var_0, var_1) {
  var_2 = undefined;
  var_3 = [];

  foreach(var_5 in level.ref_11A1F) {
    if(scripts\mp\gametypes\br_circle::updateprestreamrespawn(var_5.origin)) {
      var_3 = scripts\engine\utility::array_add(var_3, var_5);
    }
  }

  level.ref_11A1F = var_3;
  var_7 = freight_lift_dogtag_revive(level.ref_11A1F);
  var_8 = 5;

  while(var_8 >= 0) {
    var_9 = randomfloat(var_7);
    var_10 = play_scramble_for_player_until_cleared(level.ref_11A1F, var_9);

    if(isDefined(var_10)) {
      var_11 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var_10.origin, var_10.radius, 0.1, 0.85, 1, 1);

      if(!scripts\mp\gametypes\br_circle::updateprestreamrespawn(var_11)) {
        var_11 = riskspawn_flagcaptured(var_0, var_10.origin, var_10.radius);
      }

      if(!istrue(update_objective_mlgicon(var_11))) {
        var_2 = var_11;
      }

      if(var_8 == 0) {
        var_2 = var_11;
      }

      if(isDefined(var_2)) {
        break;
      }
    }

    var_7--;
  }

  if(!isDefined(var_1)) {
    var_1 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent( < error > , var_0, 0.1, 0.85, 1, 1);
  }

  level.ref_1395A[level.ref_1395A.size] = var_1;
  return var_1;
}

function update_objective_mlgicon(var_0) {
  var_1 = getdvarint("scr_br_pe_lootcrate_min_dist", 2500);
  var_2 = var_1 * var_1;

  foreach(var_4 in level.ref_1395A) {
    if(distance2dsquared(var_0, var_4) < var_2) {
      return true;
    }
  }

  return false;
}

function freight_lift_dogtag_revive(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    var_1 += var_3.radius;
  }

  return var_1;
}

function play_scramble_for_player_until_cleared(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_2 += var_4.radius;

    if(var_1 <= var_2) {
      return var_4;
    }
  }

  return undefined;
}

function riskspawn_flagcaptured(var_0, var_1, var_2) {
  var_3 = init_silo_platforms(var_0, var_1, var_2);
  var_4 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var_3.origin, var_3.radius, 0, 0.85, 1, 1);
  return var_4;
}

function init_silo_platforms(var_0, var_1, var_2) {
  var_3 = distance2d(var_0, var_1);
  var_4 = int(var_2 / 2);

  if(var_3 != 0) {
    var_5 = int(var_1[0] - var_4 / var_3 * (var_1[0] - var_0[0]));
    var_6 = int(var_1[1] - var_4 / var_3 * (var_1[1] - var_0[1]));
  } else {
    var_5 = int(var_2[0]);
    var_6 = int(var_2[1]);
  }

  var_7 = 0;
  var_8 = spawnStruct();
  var_8.origin = (var_5, var_6, var_7);
  var_8.radius = var_6;
  return var_8;
}