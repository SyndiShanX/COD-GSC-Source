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
  scripts\mp\gametypes\br_pickups::ref_12b33("brloot_blueprintextract_tablet", &controls_unlink_safe);
  scripts\mp\gametypes\br_pickups::ref_12b33("brloot_blueprintextract_tablet_easterevent", &controls_linkto_safe);
}

function convoy4_actively_hacking(var0, var1) {
  if(!convert_remaining_to_ai(var0, var1)) {
    return undefined;
  }

  if(level.convoy4_module_snipers >= level.control_room_button) {
    return undefined;
  }

  var2 = randomfloat(1);

  if(var2 <= level.convoy4_failed_extract) {
    level.convoy4_module_snipers += 1;
    return "brloot_blueprintextract_tablet";
  }

  level.convoy4_failed_extract += level.contributingplayers;
  return undefined;
}

function convert_remaining_to_ai(var0, var1) {
  if(scripts\mp\gametypes\br_public::turret_headicon()) {
    return false;
  }

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    return false;
  }

  if(istrue(level.convoy_handle_stuck_compromise)) {
    return false;
  }

  if(isDefined(var1) && var1 == "br_lep_quest_cache") {
    return false;
  }

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) && isDefined(level.br_level) && isDefined(level.br_level.br_circleclosetimes)) {
    var2 = level.br_circle.circleindex;
    var3 = level.br_level.br_circleclosetimes.size - 1;

    if(var3 - var2 < 4) {
      return false;
    }
  }

  if(!scripts\mp\gametypes\br_extract_quest::outofboundstriggersplanetrace(var0)) {
    return false;
  }

  return true;
}

function control_station_interact(var0, var1) {
  level.control_station = var0;
  level.control_room_button_green = var1;
}

function add_neurotoxin_damage_area(var0) {
  var1 = scripts\mp\gametypes\br_quest_util::risk_flagspawndebugobjicons(var0);
  controlslinked(var1);
  thread controlledcallbacksqueue();
  thread controlledcallbacks();
}

function controls_unlink_safe() {
  var0 = scripts\engine\utility::ter_op(getdvarint("scr_br_alt_mode_bblitz", 0), 2, 0);
  add_neurotoxin_damage_area(var0);
}

function controls_linkto_safe() {
  add_neurotoxin_damage_area(1);
}

function controlslinked(var0) {
  var1 = scripts\mp\gametypes\br_quest_util::riotshield_init_cp(var0);
  scripts\mp\gametypes\br_pickups::ref_119f5(self, var1);
  self.overwatch_soldiers_05_bombers = var0;
}

function controlledcallbacksqueue() {
  var0 = level.control_station;
  level.control_station = undefined;
  var1 = level.control_room_button_green;
  level.control_room_button_green = undefined;

  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var1) && istrue(var1.ref_11ff8)) {
    return;
  }

  var2 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var2 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var2, "invisible", (0, 0, 0), "ui_mp_br_mapmenu_icon_extraction_objective");
    scripts\mp\objidpoolmanager::objective_set_play_intro(var2, 1);
    scripts\mp\objidpoolmanager::update_objective_setbackground(var2, 1);

    foreach(var4 in scripts\mp\utility\teams::getteamdata(var0, "players")) {
      if(!var4 scripts\mp\gametypes\br_public::isplayeringulag()) {
        objective_addclienttomask(var2, var4);
      }
    }
  }

  var6 = gettime();

  while(isDefined(self) && gettime() - var6 < 15000) {
    var7 = self.origin + (0, 0, 10);
    scripts\mp\objidpoolmanager::update_objective_position(var2, var7);
    waitframe();
  }

  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var2);
  scripts\mp\objidpoolmanager::returnobjectiveid(var2);
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