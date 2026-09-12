/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametypes.gsc
*************************************************/

function init() {
  level.disable_super_in_turret = spawnStruct();
  level.disable_super_in_turret.funcs = [];
  level.disable_super_in_turret.lmg_guys = [];
  level.disable_super_in_turret.move_ent = [];
  level.disable_super_in_turret.data = [];
  level.disable_super_in_turret.name = getDvar("scr_br_gametype", "");
  level.disable_super_in_turret.ref_12E05 = &ref_12E05;
  level.disable_super_in_turret.unset_relic_aggressive_melee_params = &unset_relic_aggressive_melee_params;
  level.disable_super_in_turret.tutorial_showtext = &tutorial_showtext;

  if(level.disable_super_in_turret.name == "none") {
    level.disable_super_in_turret.name = "";
  }

  if(scripts\mp\utility\game::privatematch()) {
    ref_140D3();
  }

  switch (level.disable_super_in_turret.name) {
    case "control":
      scripts\mp\gametypes\br_gametype_control::init();
      break;
    case "gold_war":
    case "dmz":
      scripts\mp\gametypes\br_gametype_dmz::init();
      break;
    case "prop":
      scripts\mp\gametypes\br_gametype_prop::init();
      break;
    case "jugg":
      scripts\mp\gametypes\br_gametype_juggernaut::init();
      break;
    case "kingslayer":
      scripts\mp\gametypes\br_gametype_kingslayer::init();
      break;
    case "mini":
      scripts\mp\gametypes\br_gametype_mini::init();
      break;
    case "mmp":
      scripts\mp\gametypes\br_gametype_mmp::init();
      break;
    case "truckwar":
      scripts\mp\gametypes\br_gametype_truckwar::init();
      break;
    case "vov":
      scripts\mp\gametypes\br_gametype_vov::init();
      break;
    case "gxp":
      scripts\mp\gametypes\br_gametype_gxp::init();
      break;
    case "zxp":
      scripts\mp\gametypes\br_gametype_zxp::init();
      break;
    case "rebirth":
    case "rebirth_dbd":
      scripts\mp\gametypes\br_gametype_rebirth::init();
      break;
    case "payload":
      scripts\mp\gametypes\br_gametype_payload::init();
      break;
    case "dbd":
      scripts\mp\gametypes\br_gametype_dbd::init();
      break;
    case "tdbd":
      scripts\mp\gametypes\br_gametype_tdbd::init();
      break;
    case "x2":
      break;
    case "reveal":
      scripts\mp\gametypes\br_gametype_reveal::init();
      break;
    case "reveal_2":
      scripts\mp\gametypes\br_gametype_reveal_2::init();
      break;
    case "bodycount":
      scripts\mp\gametypes\br_gametype_bodycount::init();
      break;
    case "treasure_hunt":
      scripts\mp\gametypes\br_gametype_treasure_hunt::init();
      break;
    case "rumble":
      scripts\mp\gametypes\br_gametype_rumble::init();
      break;
    case "rumble_invasion":
      scripts\mp\gametypes\br_gametype_rumble_invasion::init();
      break;
    case "brz":
      scripts\mp\gametypes\br_gametype_brz::init();
      break;
    case "brdov":
      scripts\mp\gametypes\br_gametype_brdov::init();
      break;
    case "ter":
      scripts\mp\gametypes\br_gametype_ter::init();
      break;
    case "lep":
      scripts\mp\gametypes\br_gametype_lep::init();
      break;
    case "rebirth_reverse":
    case "rebirth_dbd_reverse":
      scripts\mp\gametypes\br_gametype_rebirth_reverse::init();
      break;
    case "blitz":
      scripts\mp\gametypes\br_gametype_blitz::init();
      break;
    case "respect":
      scripts\mp\gametypes\br_gametype_respect::init();
      break;
    case "rat_race":
      scripts\mp\gametypes\br_gametype_rat_race::init();
      break;
    case "mendota":
      scripts\mp\gametypes\br_gametype_mendota::init();
      break;
    case "olaride":
      scripts\mp\gametypes\br_gametype_olaride::init();
      break;
    case "multisquad_pve":
      scripts\mp\gametypes\br_gametype_multisquad_pve::init();
      break;
    case "":
      break;
    default:
      break;
  }
}

function setup_vehicle_wave_by_player_count() {
  exitlevel(0);
}

function ref_140D3() {
  if(!getdvarint("scr_br_pr_validate_gametypes", 1)) {
    return;
  }

  var_0 = getDvar("scr_br_pr_valid_gametypes", "");
  var_1 = getDvar("scr_br_pr_invalid_gametypes", "");
  var_2 = strtok(var_0, " ");
  var_3 = strtok(var_1, " ");

  foreach(var_5 in var_2) {
    if(level.disable_super_in_turret.name == var_5) {
      return;
    }
  }

  foreach(var_5 in var_3) {
    if(level.disable_super_in_turret.name == var_5) {
      setup_vehicle_wave_by_player_count();
      return;
    }
  }

  switch (level.disable_super_in_turret.name) {
    case "dbd":
    case "rebirth_dbd_reverse":
    case "rebirth_dbd":
    case "rebirth_reverse":
    case "rebirth":
    case "mini":
    case "gold_war":
    case "rat_race":
    case "dmz":
    case "":
      return;
  }

  setup_vehicle_wave_by_player_count();
}

function ref_12B11(var_0, var_1) {
  if(isDefined(level.disable_super_in_turret.funcs[var_0])) {
    scripts\mp\utility\script::laststand_dogtags("registerBrGametypeFunc already has " + var_0 + " defined.");
  }

  level.disable_super_in_turret.funcs[var_0] = var_1;
}

function ref_12E08(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return [[level.disable_super_in_turret.funcs[var_0]]](var_1, var_2, var_3, var_4, var_5, var_6);
}

function ref_12E05(var_0, var_1, var_2) {
  if(isDefined(level.disable_super_in_turret.funcs[var_0])) {
    if(isDefined(var_2)) {
      return [[level.disable_super_in_turret.funcs[var_0]]](var_1, var_2);
    }

    if(isDefined(var_1)) {
      return [[level.disable_super_in_turret.funcs[var_0]]](var_1);
    }

    return [[level.disable_super_in_turret.funcs[var_0]]]();
  }
}

function ref_12E06(var_0, var_1, var_2, var_3) {
  if(isDefined(level.disable_super_in_turret.funcs[var_0])) {
    return [[level.disable_super_in_turret.funcs[var_0]]](var_1, var_2, var_3);
  }
}

function ref_12E07(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level.disable_super_in_turret.funcs[var_0])) {
    return [[level.disable_super_in_turret.funcs[var_0]]](var_1, var_2, var_3, var_4);
  }
}

function ref_13F25(var_0) {
  level.disable_super_in_turret.funcs[var_0] = undefined;
}

function tutorial_showtext(var_0) {
  return isDefined(level.disable_super_in_turret.funcs[var_0]);
}

function load_sequence_3_vfx(var_0) {
  level.disable_super_in_turret.lmg_guys[var_0] = 1;
}

function unset_relic_aggressive_melee(var_0) {
  return isDefined(level.disable_super_in_turret) && istrue(level.disable_super_in_turret.lmg_guys[var_0]);
}

function move_molotov_mortar(var_0) {
  level.disable_super_in_turret.move_ent[var_0] = 1;
}

function unset_relic_aggressive_melee_params(var_0) {
  return isDefined(level.disable_super_in_turret) && istrue(level.disable_super_in_turret.move_ent[var_0]);
}

function ref_12B10(var_0, var_1) {
  level.disable_super_in_turret.data[var_0] = var_1;
}

function reinforcement_manager(var_0) {
  return level.disable_super_in_turret.data[var_0];
}

function tutorial_pullchute(var_0) {
  return isDefined(level.disable_super_in_turret.data[var_0]);
}