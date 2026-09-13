/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\conf.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 65);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerdogtagsenableddvar(scripts\mp\utility\game::getgametype(), 1);
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level._id_0952BD6E10104D8A = ::_id_0952BD6E10104D8A;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.modeonspawnplayer = ::onspawnplayer;

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    game["dialog"]["gametype"] = "iw9_conf_mode_uktl_kct1";
  else
    game["dialog"]["gametype"] = "iw9_conf_mode_uktl_name";

  game["dialog"]["boost"] = "iw9_conf_mode_uktl_bost";
  game["dialog"]["offense_obj"] = "iw9_conf_mode_uktl_bost";
  game["dialog"]["defense_obj"] = "iw9_conf_mode_uktl_bost";
  game["dialog"]["kill_confirmed"] = "iw9_conf_mode_uktl_kcnf";
  game["dialog"]["hint_tags"] = "iw9_conf_mode_uktl_htag";
  level.conf_fx["vanish"] = loadfx("vfx/core/impacts/small_snowhit");

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    _id_26508F2DE04C7A52::_id_47E2A0DE1D6B6115();
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_conf_pointsperconfirm", getmatchrulesdata("confData", "pointsPerConfirm"));
  setdynamicdvar("scr_conf_pointsperdeny", getmatchrulesdata("confData", "pointsPerDeny"));
  setdynamicdvar("dvar_BF39ADE48CF2D6C1", getmatchrulesdata("confData", "killstreakConfirmed"));
  setdynamicdvar("scr_conf_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("conf", 0);
  setdynamicdvar("scr_conf_promode", 0);
}

onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    _id_2B21F2FBE8DD5C6E = game["attackers"];
    _id_8D904E28CF14C8AE = game["defenders"];
    game["attackers"] = _id_8D904E28CF14C8AE;
    game["defenders"] = _id_2B21F2FBE8DD5C6E;
  }

  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/CONF");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/CONF");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/CONF_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/CONF_HINT");
  }

  initspawns();
  level.dogtagallyonusecb = ::dogtagallyonusecb;
  level.dogtagenemyonusecb = ::dogtagenemyonusecb;
}

_id_0952BD6E10104D8A() {
  if(istrue(level._id_9AF1FF512FC5D4BC))
    setDvar("dvar_CF1C084C7A6622F9", 0);
}

initspawns() {
  if(getdvarint("dvar_A464CB031C16EE87", 0) > 0)
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  else
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");

  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_tdm_spawn_axis_start");
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", _id_2FD93EA689E77097);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  _id_3A5288F40C8BE099 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", _id_29D9D2428185616D);
  scripts\mp\spawnlogic::registerspawnset("fallback", _id_3A5288F40C8BE099);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.scoreconfirm = scripts\mp\utility\dvars::dvarintvalue("pointsPerConfirm", 1, 0, 25);
  level.scoredeny = scripts\mp\utility\dvars::dvarintvalue("pointsPerDeny", 0, 0, 25);
  level._id_9AF1FF512FC5D4BC = scripts\mp\utility\dvars::dvarintvalue("killstreakConfirmed", 0, 0, 1);
}

getspawnpoint() {
  spawnteam = self.pers["team"];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(spawnteam == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
    }
  } else
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, "normal", "fallback");

  return spawnpoint;
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
}

onspawnplayer(_id_9156B53BCF7CE573) {
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("kill_collect_tags");

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    thread _id_26508F2DE04C7A52::_id_F9AE07213A0AF3DE();
}

dogtagallyonusecb(player) {
  if(isPlayer(player)) {
    player scripts\mp\utility\stats::setextrascore1(player.pers["denied"]);
    player scripts\mp\gamescore::giveteamscoreforobjective(player.pers["team"], level.scoredeny, 0);
  }
}

dogtagenemyonusecb(player) {
  if(isPlayer(player)) {
    player scripts\mp\utility\dialog::leaderdialogonplayer("kill_confirmed", undefined, undefined, undefined, 4);
    player scripts\mp\utility\stats::setextrascore0(player.pers["confirmed"]);

    if(istrue(level._id_9AF1FF512FC5D4BC)) {
      if(!player scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak"))
        player scripts\mp\killstreaks\killstreaks::givestreakpoints("stat_F4CD65EB4AA3FD61", 1, 0);
      else
        player scripts\mp\killstreaks\killstreaks::givestreakpoints("stat_F4CD65EB4AA3FD61", 1, 150);
    }

    player scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(15, 1);
  }

  player scripts\mp\gamescore::giveteamscoreforobjective(player.pers["team"], level.scoreconfirm, 0);
}