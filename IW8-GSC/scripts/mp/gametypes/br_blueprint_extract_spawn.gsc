/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_blueprint_extract_spawn.gsc
***************************************************************/

function init() {
  level.control_room_button = undefined;
  level.contract_death_cash_flag = undefined;
  level.contributingplayers = undefined;

  if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk") {
    level.control_room_button = getdvarfloat("scr_blueprint_dmz_maxPerMatch", 4);
    level.contract_death_cash_flag = getdvarfloat("scr_blueprint_dmz_chanceBase", 0.02);
    level.contributingplayers = getdvarfloat("scr_blueprint_dmz_chancePerContract", 0);
  } else {
    level.control_room_button = getdvarfloat("scr_blueprint_br_maxPerMatch", 4);
    level.contract_death_cash_flag = getdvarfloat("scr_blueprint_br_chanceBase", 0.02);
    level.contributingplayers = getdvarfloat("scr_blueprint_br_chancePerContract", 0);
  }

  level.convoy4_module_snipers = 0;
  level.convoy4_failed_extract = level.contract_death_cash_flag;
  level.control_station = undefined;
  scripts\mp\gametypes\br_pickups::ref_12B33("brloot_blueprintextract_tablet", &controls_unlink_safe);
  scripts\mp\gametypes\br_pickups::ref_12B33("brloot_blueprintextract_tablet_easterevent", &controls_linkto_safe);
}

function convoy4_actively_hacking(var_0, var_1) {
  if(!convert_remaining_to_ai(var_0, var_1)) {
    return undefined;
  }

  if(level.convoy4_module_snipers >= level.control_room_button) {
    return undefined;
  }

  var_2 = randomfloat(1);

  if(var_2 <= level.convoy4_failed_extract) {
    level.convoy4_module_snipers += 1;
    return "brloot_blueprintextract_tablet";
  }

  level.convoy4_failed_extract += level.contributingplayers;
  return undefined;
}

function convert_remaining_to_ai(var_0, var_1) {
  if(scripts\mp\gametypes\br_public::turret_headicon()) {
    return false;
  }

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    return false;
  }

  if(istrue(level.convoy_handle_stuck_compromise)) {
    return false;
  }

  if(isDefined(var_1) && var_1 == "br_lep_quest_cache") {
    return false;
  }

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) && isDefined(level.br_level) && isDefined(level.br_level.br_circleclosetimes)) {
    var_2 = level.br_circle.circleindex;
    var_3 = level.br_level.br_circleclosetimes.size - 1;

    if(var_3 - var_2 < 4) {
      return false;
    }
  }

  if(!scripts\mp\gametypes\br_extract_quest::outofboundstriggersplanetrace(var_0)) {
    return false;
  }

  return true;
}

function control_station_interact(var_0, var_1) {
  level.control_station = var_0;
  level.control_room_button_green = var_1;
}

function add_neurotoxin_damage_area(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::risk_flagspawndebugobjicons(var_0);
  controlslinked(var_1);
  thread controlledcallbacksqueue();
  thread controlledcallbacks();
}

function controls_unlink_safe() {
  var_0 = scripts\engine\utility::ter_op(getdvarint("scr_br_alt_mode_bblitz", 0), 2, 0);
  add_neurotoxin_damage_area(var_0);
}

function controls_linkto_safe() {
  add_neurotoxin_damage_area(1);
}

function controlslinked(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::riotshield_init_cp(var_0);
  scripts\mp\gametypes\br_pickups::ref_119F5(self, var_1);
  self.overwatch_soldiers_05_bombers = var_0;
}

function controlledcallbacksqueue() {
  var_0 = level.control_station;
  level.control_station = undefined;
  var_1 = level.control_room_button_green;
  level.control_room_button_green = undefined;

  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(var_1) && istrue(var_1.ref_11FF8)) {
    return;
  }

  var_2 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_2 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_2, "invisible", (0, 0, 0), "ui_mp_br_mapmenu_icon_extraction_objective");
    scripts\mp\objidpoolmanager::objective_set_play_intro(var_2, 1);
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_2, 1);

    foreach(var_4 in scripts\mp\utility\teams::getteamdata(var_0, "players")) {
      if(!var_4 scripts\mp\gametypes\br_public::isplayeringulag()) {
        objective_addclienttomask(var_2, var_4);
      }
    }
  }

  var_6 = gettime();

  while(isDefined(self) && gettime() - var_6 < 15000) {
    var_7 = self.origin + (0, 0, 10);
    scripts\mp\objidpoolmanager::update_objective_position(var_2, var_7);
    waitframe();
  }

  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_2);
  scripts\mp\objidpoolmanager::returnobjectiveid(var_2);
}

function controlledcallbacks() {
  while(isDefined(self)) {
    if(!scripts\mp\gametypes\br_extract_quest::outofboundstriggersplanetrace(self.origin)) {
      scripts\mp\gametypes\br_pickups::lastgoodjobplayer();
      return;
    }

    waitframe();
  }
}