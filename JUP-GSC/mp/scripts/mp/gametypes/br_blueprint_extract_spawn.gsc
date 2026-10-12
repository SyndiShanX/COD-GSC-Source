/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_blueprint_extract_spawn.gsc
***************************************************************/

#using scripts\cp_mp\utility\game_utility;
#using scripts\mp\gametypes\br_extract_quest;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace br_blueprint_extract_spawn;

function init() {
  level.blueprint_maxpermatch = undefined;
  level.blueprint_chancebase = undefined;
  level.blueprint_chancepercontract = undefined;
  brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

  if(brgametype == "plunder" || brgametype == "risk") {
    level.blueprint_maxpermatch = getdvarfloat(@ "scr_blueprint_plunder_maxpermatch", 4);
    level.blueprint_chancebase = getdvarfloat(@ "scr_blueprint_plunder_chancebase", 0.02);
    level.blueprint_chancepercontract = getdvarfloat(@ "scr_blueprint_plunder_chancepercontract", 0);
  } else {
    level.blueprint_maxpermatch = getdvarfloat(@ "scr_blueprint_br_maxpermatch", 4);
    level.blueprint_chancebase = getdvarfloat(@ "scr_blueprint_br_chancebase", 0.02);
    level.blueprint_chancepercontract = getdvarfloat(@ "scr_blueprint_br_chancepercontract", 0);
  }

  level.blueprintextractspawns = 0;
  level.blueprintextractchance = level.blueprint_chancebase;
  level.blueprintcreatingteam = undefined;

  foreach(unlockabledata in level.questinfo.unlockables) {
    registerpickupcreatedcallback("brloot_blueprintextract_tablet", &blueprintextract_onpickupcreated);
  }
}

function blueprintextract_trygetreward(rewardorigin) {
  if(!blueprintextract_shouldgivereward(rewardorigin)) {
    return undefined;
  }

  if(level.blueprintextractspawns >= level.blueprint_maxpermatch) {
    return undefined;
  }

  randomvalue = randomfloat(1);

  if(randomvalue <= level.blueprintextractchance) {
    level.blueprintextractspawns += 1;
    return "brloot_blueprintextract_tablet";
  }

  level.blueprintextractchance += level.blueprint_chancepercontract;
  return undefined;
}

function blueprintextract_shouldgivereward(rewardorigin) {
  if(scripts\mp\gametypes\br_public::isanytutorialorbotpracticematch()) {
    return false;
  }

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    return false;
  }

  if(istrue(level.bmoovertime)) {
    return false;
  }

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) && isDefined(level.br_level) && isDefined(level.br_level.br_circleclosetimes)) {
    currentcircleindex = level.br_circle.circleindex;
    finalcircleindex = level.br_level.br_circleclosetimes.size - 1;

    if(finalcircleindex - currentcircleindex < 4) {
      return false;
    }
  }

  if(!scripts\mp\gametypes\br_extract_quest::extractlocale_islocaleavailable(rewardorigin)) {
    return false;
  }

  return true;
}

function blueprintextract_beforepickupspawned(team) {
  level.blueprintcreatingteam = team;
}

function blueprintextract_onpickupcreated() {
  randomlootid = scripts\mp\gametypes\br_quest_util::getrandomextractunlockablelootid();
  blueprintextract_setunlockablelootid(randomlootid);
  thread blueprintextract_createtempobjective();
  thread blueprintextract_cleanupwhennoavailablelocales();
}

function blueprintextract_setunlockablelootid(unlockablelootid) {
  scripts\mp\gametypes\br_pickups::loot_setitemcount(self, unlockablelootid);
  self.extractunlockablelootid = unlockablelootid;
}

function blueprintextract_createtempobjective() {
  creatingteam = level.blueprintcreatingteam;
  level.blueprintcreatingteam = undefined;

  if(!isDefined(creatingteam)) {
    return;
  }

  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "invisible", (0, 0, 0), "ui_mp_br_mapmenu_icon_extraction_objective");
    scripts\mp\objidpoolmanager::objective_set_play_intro(objectiveiconid, 1);
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 1);

    foreach(player in getteamdata(creatingteam, "players")) {
      if(!player scripts\mp\gametypes\br_public::isplayeringulag()) {
        objective_addclienttomask(objectiveiconid, player);
      }
    }
  }

  starttime = gettime();

  while(isDefined(self) && gettime() - starttime < 15000) {
    newpos = self.origin + (0, 0, 10);
    scripts\mp\objidpoolmanager::update_objective_position(objectiveiconid, newpos);
    waitframe();
  }

  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objectiveiconid);
  scripts\mp\objidpoolmanager::returnobjectiveid(objectiveiconid);
}

function blueprintextract_cleanupwhennoavailablelocales() {
  while(isDefined(self)) {
    if(!scripts\mp\gametypes\br_extract_quest::extractlocale_islocaleavailable(self.origin)) {
      deletescriptableinstance();
      return;
    }

    waitframe();
  }
}