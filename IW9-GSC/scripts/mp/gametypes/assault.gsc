/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\assault.gsc
***********************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  _id_9BBACB179DEA3237[1] = "sd";
  _id_9BBACB179DEA3237[2] = "bombzone";
  _id_9BBACB179DEA3237[3] = "blocker";
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 3.0);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 3);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  timelimit = scripts\mp\utility\dvars::getwatcheddvar("timelimit");
  scripts\mp\utility\dvars::registerwatchdvarint("addObjectiveTime", timelimit);
  updategametypedvars();
  level.objectivebased = 1;
  level.teambased = 1;
  level.nobuddyspawns = 1;
  level.onprecachegametype = ::onprecachegametype;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onplayerkilled = ::onplayerkilled;
  level.ontimelimit = ::ontimelimit;
  level.onnormaldeath = ::onnormaldeath;
  level.onobjectivecomplete = ::onobjectivecomplete;
  level.resetuiomnvargamemode = _id_0780CA0FF5944FCE::resetuiomnvargamemode;
  level.allowlatecomers = 0;
  game["dialog"]["offense_obj"] = "obj_destroy";
  game["dialog"]["defense_obj"] = "obj_defend";
  game["dialog"]["lead_lost"] = "null";
  game["dialog"]["lead_tied"] = "null";
  game["dialog"]["lead_taken"] = "null";
  game["dialog"]["lost_a"] = "lost_a";
  game["dialog"]["lost_b"] = "lost_b";
  game["dialog"]["lost_c"] = "lost_c";
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  _id_CA598F14648FA32F = getmatchrulesdata("assaultData", "roundLength");
  setdynamicdvar("scr_assault_timelimit", _id_CA598F14648FA32F);
  scripts\mp\utility\game::registertimelimitdvar("assault", _id_CA598F14648FA32F);
  roundswitch = getmatchrulesdata("assaultData", "roundSwitch");
  setdynamicdvar("scr_assault_roundswitch", roundswitch);
  scripts\mp\utility\game::registerroundswitchdvar("assault", roundswitch, 0, 9);
  winlimit = getmatchrulesdata("commonOption", "scoreLimit");
  setdynamicdvar("scr_assault_winlimit", winlimit);
  scripts\mp\utility\game::registerwinlimitdvar("assault", winlimit);
  setdynamicdvar("dvar_09AC09EC01293D68", getmatchrulesdata("assaultData", "bombTimer"));
  setdynamicdvar("scr_assault_planttime", getmatchrulesdata("assaultData", "plantTime"));
  setdynamicdvar("scr_assault_defusetime", getmatchrulesdata("assaultData", "defuseTime"));
  setdynamicdvar("scr_assault_multibomb", getmatchrulesdata("assaultData", "multiBomb"));
  setdynamicdvar("scr_assault_bombresettimer", getmatchrulesdata("assaultData", "bombResetTimer"));
  setdynamicdvar("scr_assault_roundlimit", 0);
  scripts\mp\utility\game::registerroundlimitdvar("assault", 0);
  setdynamicdvar("scr_assault_scorelimit", 1);
  scripts\mp\utility\game::registerscorelimitdvar("assault", 1);
  setdynamicdvar("scr_assault_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("assault", 0);
}

onprecachegametype() {
  game["bomb_dropped_sound"] = "iw9_mp_ui_objective_lost";
  game["bomb_recovered_sound"] = "iw9_mp_ui_objective_taken";
}

onstartgametype() {
  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    _id_2B21F2FBE8DD5C6E = game["attackers"];
    _id_8D904E28CF14C8AE = game["defenders"];
    game["attackers"] = _id_8D904E28CF14C8AE;
    game["defenders"] = _id_2B21F2FBE8DD5C6E;
  }

  setclientnamemode("manual_change");
  level._effect["bomb_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._effect["vehicle_explosion"] = loadfx("vfx/core/expl/small_vehicle_explosion_new.vfx");
  level._effect["building_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  scripts\mp\utility\game::setobjectivetext(game["attackers"], &"OBJECTIVES/SD_ATTACKER");
  scripts\mp\utility\game::setobjectivetext(game["defenders"], &"OBJECTIVES/SD_DEFENDER");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext(game["attackers"], &"OBJECTIVES/SD_ATTACKER");
    scripts\mp\utility\game::setobjectivescoretext(game["defenders"], &"OBJECTIVES/SD_DEFENDER");
  } else {
    scripts\mp\utility\game::setobjectivescoretext(game["attackers"], &"OBJECTIVES/SD_ATTACKER_SCORE");
    scripts\mp\utility\game::setobjectivescoretext(game["defenders"], &"OBJECTIVES/SD_DEFENDER_SCORE");
  }

  scripts\mp\utility\game::setobjectivehinttext(game["attackers"], &"OBJECTIVES/SD_ATTACKER_HINT");
  scripts\mp\utility\game::setobjectivehinttext(game["defenders"], &"OBJECTIVES/SD_DEFENDER_HINT");
  initspawns();
  setspecialloadout();
  thread initializeobjectives();
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_assault_spawn_attacker_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_assault_spawn_defender_start");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.assaultspawns = [];
  initbombsitespawns("attacker");
  initbombsitespawns("defender");
}

initbombsitespawns(_id_A66BA9B157533F5A) {
  level.assaultspawns[_id_A66BA9B157533F5A] = [];
  _id_700A871A46435669 = "mp_assault_spawn_" + _id_A66BA9B157533F5A;
  spawnpoints = scripts\mp\spawnlogic::getspawnpointarray(_id_700A871A46435669);

  foreach(point in spawnpoints) {
    _id_4655DA7A5E810735 = point.script_noteworthy;

    if(!isDefined(level.assaultspawns[_id_A66BA9B157533F5A][_id_4655DA7A5E810735]))
      level.assaultspawns[_id_A66BA9B157533F5A][_id_4655DA7A5E810735] = [];

    level.assaultspawns[_id_A66BA9B157533F5A][_id_4655DA7A5E810735][level.assaultspawns[_id_A66BA9B157533F5A][_id_4655DA7A5E810735].size] = point;
  }
}

getspawnpoint() {
  _id_A20AF37D85939806 = self.pers["team"];
  _id_A66BA9B157533F5A = "defender";

  if(_id_A20AF37D85939806 == game["attackers"])
    _id_A66BA9B157533F5A = "attacker";

  if(level.ingraceperiod) {
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_assault_spawn_" + _id_A66BA9B157533F5A + "_start");
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);
  } else {
    _id_99E78E0020363C33 = level.curobj.label;
    _id_EBB926478DDC1722 = level.assaultspawns[_id_A66BA9B157533F5A][_id_99E78E0020363C33];
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint_random(_id_EBB926478DDC1722);
  }

  return spawnpoint;
}

onspawnplayer(_id_9156B53BCF7CE573) {
  if(scripts\cp_mp\utility\game_utility::isgameparticipant(self)) {
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 0;
  }

  if(level.multibomb && self.pers["team"] == game["attackers"])
    self setclientomnvar("ui_carrying_bomb", 1);
  else
    self setclientomnvar("ui_carrying_bomb", 0);

  scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(self.pers["plants"]))
    scripts\mp\utility\stats::setextrascore0(self.pers["plants"]);

  level notify("spawned_player");
  setuppingwatcher();
  allowjump = getdvarint("scr_allow_highjump");
  self allowhighjump(allowjump);
  self allowhighjump(allowjump);
  self allowboostjump(allowjump);
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  self setclientomnvar("ui_carrying_bomb", 0);
  thread checkallowspectating();
}

checkallowspectating() {
  waitframe();
  update = 0;

  if(!scripts\mp\utility\teams::getteamdata(game["attackers"], "aliveCount")) {
    level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
    update = 1;
  }

  if(!scripts\mp\utility\teams::getteamdata(game["defenders"], "aliveCount")) {
    level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
    update = 1;
  }

  if(update)
    scripts\mp\spectating::updatespectatesettings();
}

sd_endgame(_id_EC15CE3E7A9D1D86, _id_F0500919D8C387B9) {
  foreach(player in level.players) {
    if(!isai(player))
      player setclientomnvar("ui_objective_pinned_text_param", 0);
  }

  level.finalkillcam_winner = _id_EC15CE3E7A9D1D86;

  if(_id_F0500919D8C387B9 == game["end_reason"]["target_destroyed"] || _id_F0500919D8C387B9 == game["end_reason"]["bomb_defused"]) {
    if(!isDefined(level.finalkillcam_killcamentityindex[_id_EC15CE3E7A9D1D86]) || level.finalkillcam_killcamentityindex[_id_EC15CE3E7A9D1D86] != level.curobj.killcamentnum)
      scripts\mp\final_killcam::erasefinalkillcam();
  }

  thread scripts\mp\gamelogic::endgame(_id_EC15CE3E7A9D1D86, _id_F0500919D8C387B9);
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  score = scripts\mp\rank::getscoreinfovalue("stat_EF9582D72160F199");
  team = victim.team;

  if(victim.isplanting) {
    thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, lifeid, "planting");
    attacker scripts\mp\utility\stats::incpersstat("defends", 1);
    attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
  } else if(victim.isbombcarrier)
    thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, lifeid, "carrying");
  else if(victim.isdefusing) {
    thread scripts\common\utility::trycall(level.matchdata_logvictimkillevent, lifeid, "defusing");
    attacker scripts\mp\utility\stats::incpersstat("defends", 1);
    attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
  }
}

ontimelimit() {
  sd_endgame(game["defenders"], game["end_reason"]["time_limit_reached"]);

  foreach(player in level.players) {
    if(isDefined(player.bombplantweapon)) {
      player scripts\cp_mp\utility\inventory_utility::_takeweapon(player.bombplantweapon);
      break;
    }
  }
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.planttime = scripts\mp\utility\dvars::dvarfloatvalue("planttime", 5, 0, 20);
  level.defusetime = scripts\mp\utility\dvars::dvarfloatvalue("defusetime", 5, 0, 20);
  level.bombtimer = scripts\mp\utility\dvars::dvarfloatvalue("bombtimer", 45, 1, 300);
  level.multibomb = scripts\mp\utility\dvars::dvarintvalue("multibomb", 0, 0, 1);
  level.bombresettimer = scripts\mp\utility\dvars::dvarintvalue("bombResetTimer", 60, 0, 180);
}

setspecialloadout() {
  if(isusingmatchrulesdata() && scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", game["attackers"], 5, "class", "inUse"))
    level.sd_loadout[game["attackers"]] = scripts\mp\utility\game::getmatchrulesspecialclass(game["attackers"], 5);
}

isplayeroutsideofcurbombsite(weaponname) {
  if(isDefined(level.curbombzone))
    return self istouching(level.curbombzone.trigger);

  return 0;
}

initializeobjectives() {
  level.firsttimebomb = 1;
  _id_A554E9B93A45F42F = getEntArray("bombzone", "targetname");
  level.objectives = _id_A554E9B93A45F42F;
  level.curobjectiveindex = 0;
  level.curobj = setupnextobjective(level.curobjectiveindex);
}

setupnextobjective(index) {
  objectiveent = level.objectives[index];
  _id_3985F515E9F06D2C = objectiveent.script_noteworthy;

  if(!isDefined(_id_3985F515E9F06D2C))
    _id_3985F515E9F06D2C = "bombzone";

  objective = undefined;

  switch (_id_3985F515E9F06D2C) {
    case "bombzone":
      if(isDefined(level.firsttimebomb)) {
        _id_0780CA0FF5944FCE::bombzone_setupbombcase("sd_bomb");
        level.firsttimebomb = undefined;
      } else
        _id_0780CA0FF5944FCE::advancebombcase();

      objective = _id_0780CA0FF5944FCE::setupobjective(index);
      scripts\mp\utility\dialog::leaderdialog("offense_obj", game["attackers"]);
      scripts\mp\utility\dialog::leaderdialog("defense_obj", game["defenders"]);
      break;
    case "dompoint":
      objective = _id_6663215F917210AE::setupobjective(level.objectives[index]);
      break;
    case "payload":
      break;
    case "ctf":
      break;
  }

  return objective;
}

onobjectivecomplete(_id_3985F515E9F06D2C, _id_31A28435DF609F42, _id_58E8D1412BC688CD, _id_EF310DDD2BA0F321, _id_35ABECBEEEE613A1) {
  switch (_id_3985F515E9F06D2C) {
    case "dompoint":
      ondompointobjectivecomplete(_id_31A28435DF609F42, _id_58E8D1412BC688CD, _id_EF310DDD2BA0F321, _id_35ABECBEEEE613A1);
      break;
    case "bombzone":
      onbombzoneobjectivecomplete(_id_31A28435DF609F42, _id_58E8D1412BC688CD, _id_EF310DDD2BA0F321, _id_35ABECBEEEE613A1);
      break;
  }

  if(_id_EF310DDD2BA0F321 == game["attackers"]) {
    level.curobjectiveindex++;

    if(level.curobjectiveindex < level.objectives.size) {
      _id_0F001ED7D3B4F0F1 = scripts\mp\utility\dvars::getwatcheddvar("addObjectiveTime");
      scripts\mp\utility\dvars::setoverridewatchdvar("timelimit", scripts\mp\utility\game::gettimelimit() + _id_0F001ED7D3B4F0F1);
      restarttimer();
      level.curobj = setupnextobjective(level.curobjectiveindex);
    } else {
      setgameendtime(0);
      wait 3;
      sd_endgame(game["attackers"], game["end_reason"]["target_destroyed"]);
    }
  }
}

ondompointobjectivecomplete(_id_31A28435DF609F42, _id_58E8D1412BC688CD, _id_EF310DDD2BA0F321, _id_8A04AA0E0755E7E3) {
  team = _id_58E8D1412BC688CD.team;

  if(_id_8A04AA0E0755E7E3 == "neutral") {
    otherteam = scripts\mp\utility\game::getotherteam(team)[0];
    thread scripts\mp\utility\print::printandsoundoneveryone(team, otherteam, undefined, undefined, "mp_dom_flag_captured", undefined, _id_58E8D1412BC688CD);
    scripts\mp\utility\dialog::statusdialog("secured" + self.label, team, 1);
    scripts\mp\utility\dialog::statusdialog("lost_" + self.label, otherteam, 1);
  }
}

onbombzoneobjectivecomplete(_id_31A28435DF609F42, _id_58E8D1412BC688CD, _id_EF310DDD2BA0F321, _id_35ABECBEEEE613A1) {
  if(_id_EF310DDD2BA0F321 == game["defenders"]) {
    restarttimer();
    thread _id_0780CA0FF5944FCE::respawnbombcase();
    level.curobj = _id_0780CA0FF5944FCE::setupobjective(level.curobjectiveindex);
  }
}

restarttimer() {
  scripts\mp\gamelogic::resumetimer();
  level.timepaused = gettime() - level.timepausestart;
  level.timelimitoverride = 0;
}

setuppingwatcher() {
  if(isai(self)) {
    return;
  }
  self notifyonplayercommand("playerPing", "+breath_sprint");
  thread waitforplayerping();
}

waitforplayerping() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("playerPing");

    if(scripts\mp\utility\player::isreallyalive(self) && !scripts\mp\utility\player::isusingremote()) {
      if(self adsButtonPressed()) {
        doping();
        wait 0.5;
      }
    }

    wait 0.1;
  }
}

doping() {
  self endon("disconnect");
  level endon("game_ended");
  tracestart = self getEye();
  _id_8B39E5984DA1FFAF = tracestart + anglesToForward(self getplayerangles()) * 2000;
  result = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, self);
  _id_1D9FB21B4F3023F3 = result["entity"];
  message = "WAYPOINT";
  _id_308F6F17AAF703FF = (1, 1, 1);

  if(isDefined(_id_1D9FB21B4F3023F3)) {
    if(isDefined(_id_1D9FB21B4F3023F3.team) && _id_1D9FB21B4F3023F3.team != self.team) {
      _id_308F6F17AAF703FF = (1, 0, 0);

      if(isPlayer(_id_1D9FB21B4F3023F3)) {
        message = "KILL";
        self notify("enemy_sighted");
      } else
        message = "DESTROY";
    } else if(isDefined(_id_1D9FB21B4F3023F3.script_gameobjectname)) {
      if(_id_1D9FB21B4F3023F3.script_gameobjectname == "bombzone") {
        if(self.team == game["attackers"]) {
          message = "ATTACK";
          _id_308F6F17AAF703FF = (1, 1, 0);
        } else {
          message = "DEFEND";
          _id_308F6F17AAF703FF = (0, 0, 1);
        }
      } else if(_id_1D9FB21B4F3023F3.script_gameobjectname == "sd") {
        if(self.team == game["attackers"]) {
          message = "OBJECTIVE";
          _id_308F6F17AAF703FF = (1, 1, 0);
        }
      }
    }
  }
}