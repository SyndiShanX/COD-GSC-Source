/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_blueprint_extract_spawn.gsc
***************************************************************/

init() {
  level.blueprint_maxpermatch = undefined;
  level.blueprint_chancebase = undefined;
  level.blueprint_chancepercontract = undefined;

  if(getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk") {
    level.blueprint_maxpermatch = getdvarfloat("dvar_D8044C322F6B5042", 4);
    level.blueprint_chancebase = getdvarfloat("dvar_13B736C9BA95D40D", 0.02);
    level.blueprint_chancepercontract = getdvarfloat("dvar_8A876E2C4B13F819", 0.0);
  } else {
    level.blueprint_maxpermatch = getdvarfloat("dvar_412E34085BCD2B1A", 4);
    level.blueprint_chancebase = getdvarfloat("dvar_AA3250E2CE395B55", 0.02);
    level.blueprint_chancepercontract = getdvarfloat("dvar_09C3219408286E11", 0.0);
  }

  level.blueprintextractspawns = 0;
  level.blueprintextractchance = level.blueprint_chancebase;
  level.blueprintcreatingteam = undefined;

  foreach(_id_A03D4FE1F134DB01 in level.questinfo.unlockables)
  _id_7E52B56769FA7774::registerpickupcreatedcallback("brloot_blueprintextract_tablet", ::blueprintextract_onpickupcreated);
}

blueprintextract_trygetreward(rewardorigin) {
  if(!blueprintextract_shouldgivereward(rewardorigin))
    return undefined;

  if(level.blueprintextractspawns >= level.blueprint_maxpermatch)
    return undefined;

  _id_908FFEB2459E73AF = randomfloat(1);

  if(_id_908FFEB2459E73AF <= level.blueprintextractchance) {
    level.blueprintextractspawns = level.blueprintextractspawns + 1;
    return "brloot_blueprintextract_tablet";
  } else {
    level.blueprintextractchance = level.blueprintextractchance + level.blueprint_chancepercontract;
    return undefined;
  }
}

blueprintextract_shouldgivereward(rewardorigin) {
  if(_id_2CEDCC356F1B9FC8::isanytutorialorbotpracticematch())
    return 0;

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    return 0;

  if(istrue(level.bmoovertime))
    return 0;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) && isDefined(level.br_level) && isDefined(level.br_level.br_circleclosetimes)) {
    _id_D280129509A08F5A = level.br_circle.circleindex;
    _id_F117FDD931AE78A1 = level.br_level.br_circleclosetimes.size - 1;

    if(_id_F117FDD931AE78A1 - _id_D280129509A08F5A < 4)
      return 0;
  }

  if(!_id_4ACBD920A4F5A24D::extractlocale_islocaleavailable(rewardorigin))
    return 0;

  return 1;
}

blueprintextract_beforepickupspawned(team) {
  level.blueprintcreatingteam = team;
}

blueprintextract_onpickupcreated() {
  _id_2DB7BA1634ABC375 = _id_3ACF1C0EBAF602F2::getrandomextractunlockablelootid();
  blueprintextract_setunlockablelootid(_id_2DB7BA1634ABC375);
  thread blueprintextract_createtempobjective();
  thread blueprintextract_cleanupwhennoavailablelocales();
}

blueprintextract_setunlockablelootid(_id_26F195548422121E) {
  _id_7E52B56769FA7774::loot_setitemcount(self, _id_26F195548422121E);
  self.extractunlockablelootid = _id_26F195548422121E;
}

blueprintextract_createtempobjective() {
  _id_8F90F73D25E925E3 = level.blueprintcreatingteam;
  level.blueprintcreatingteam = undefined;

  if(!isDefined(_id_8F90F73D25E925E3)) {
    return;
  }
  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "invisible", (0, 0, 0), "ui_mp_br_mapmenu_icon_extraction_objective");
    scripts\mp\objidpoolmanager::objective_set_play_intro(objectiveiconid, 1);
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 1);

    foreach(player in scripts\mp\utility\teams::getteamdata(_id_8F90F73D25E925E3, "players")) {
      if(!player _id_2CEDCC356F1B9FC8::isplayeringulag())
        objective_addclienttomask(objectiveiconid, player);
    }
  }

  starttime = gettime();

  while(isDefined(self) && gettime() - starttime < 15000) {
    _id_6C53D859D582A421 = self.origin + (0, 0, 10);
    scripts\mp\objidpoolmanager::update_objective_position(objectiveiconid, _id_6C53D859D582A421);
    waitframe();
  }

  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objectiveiconid);
  scripts\mp\objidpoolmanager::returnobjectiveid(objectiveiconid);
}

blueprintextract_cleanupwhennoavailablelocales() {
  while(isDefined(self)) {
    if(!_id_4ACBD920A4F5A24D::extractlocale_islocaleavailable(self.origin)) {
      _id_7E52B56769FA7774::deletescriptableinstance();
      return;
    }

    waitframe();
  }
}