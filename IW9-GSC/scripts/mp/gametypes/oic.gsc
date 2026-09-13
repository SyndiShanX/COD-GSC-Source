/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\oic.gsc
***********************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(level.gametype, 10);
    scripts\mp\utility\game::registerscorelimitdvar(level.gametype, 0);
    scripts\mp\utility\game::registerroundlimitdvar(level.gametype, 1);
    scripts\mp\utility\game::registerwinlimitdvar(level.gametype, 1);
    scripts\mp\utility\game::registernumlivesdvar(level.gametype, 3);
    scripts\mp\utility\game::registerhalftimedvar(level.gametype, 0);
    level.matchrules_oneshotkill = 1;
    level.matchrules_initialammo = 1;
    level.matchrules_rewardammo = 1;
  }

  updategametypedvars();
  setteammode("ffa");
  level.ignorekdrstats = 1;
  level.teambased = 0;
  thread waitthensetstatgroupreadonly();
  level.onstartgametype = ::onstartgametype;
  level.onspawnplayer = ::onspawnplayer;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.onplayerkilled = ::onplayerkilled;
  level.ononeleftevent = ::ononeleftevent;
  level.modeonsuicidedeath = ::onsuicidedeath;
  level.onplayerscore = ::onplayerscore;
  level.bypassclasschoicefunc = scripts\mp\class::alwaysgamemodeclass;
  level.modifyplayerdamage = ::modifyplayerdamage;
  game["dialog"]["gametype"] = "gametype_oic";
  game["dialog"]["boost"] = "boost_oic";
  game["dialog"]["offense_obj"] = "boost_oic";
  game["dialog"]["defense_obj"] = "boost_oic";
  game["dialog"]["oic_enemy_eliminated"] = "oic_elimination";
  game["dialog"]["oic_lives_two"] = "oic_lives_two";
  game["dialog"]["oic_lives_last"] = "oic_lives_last";
  game["dialog"]["oic_lives_last_alt"] = "oic_dead";
}

waitthensetstatgroupreadonly() {
  self endon("game_ended");
  wait 1;

  if(isDefined(level.playerstats)) {
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("kdr");
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("losses");
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("winLoss");
  }
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata(1);
  setdynamicdvar("dvar_F35248CAD95D3E2C", getmatchrulesdata("oicData", "initialAmmoCount"));
  setdynamicdvar("dvar_2D2A85740CEF880B", getmatchrulesdata("oicData", "killRewardAmmoCount"));
  setdynamicdvar("dvar_6042D9E8BA77B563", getmatchrulesdata("oicData", "oneShotKill"));
  setdynamicdvar("dvar_C7A3E1481B27E9E5", getmatchrulesdata("oicData", "weapon"));
  setdynamicdvar("dvar_FE700867CF5C7FEF", 0);
}

onstartgametype() {
  setclientnamemode("auto_change");
  scripts\mp\utility\game::setobjectivetext("allies", &"OBJECTIVES/OIC");
  scripts\mp\utility\game::setobjectivetext("axis", &"OBJECTIVES/OIC");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext("allies", &"OBJECTIVES/OIC");
    scripts\mp\utility\game::setobjectivescoretext("axis", &"OBJECTIVES/OIC");
  } else {
    scripts\mp\utility\game::setobjectivescoretext("allies", &"OBJECTIVES/OIC_SCORE");
    scripts\mp\utility\game::setobjectivescoretext("axis", &"OBJECTIVES/OIC_SCORE");
  }

  scripts\mp\utility\game::setobjectivehinttext("allies", &"OBJECTIVES/OIC_HINT");
  scripts\mp\utility\game::setobjectivehinttext("axis", &"OBJECTIVES/OIC_HINT");
  level.matchrules_oicweapon = spawnStruct();
  weapon = getDvar("dvar_C7A3E1481B27E9E5");
  level.matchrules_oicweapon.mpweapon = _id_2669878CF5A1B6BC::weaponassetnamemap(weapon);
  level.matchrules_oicweapon.weapon = weapon;
  level.matchrules_oicweapon.oicvariantid = 0;
  setgun();
  setspecialloadouts();
  scripts\mp\spawnlogic::setactivespawnlogic("FreeForAll", "Crit_Default");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dm_spawn_start", 1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn_secondary", 1, 1);
  _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn");
  _id_3A5288F40C8BE099 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("dm", _id_29D9D2428185616D);
  scripts\mp\spawnlogic::registerspawnset("dm_fallback", _id_3A5288F40C8BE099);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.blockweapondrops = 1;

  if(isDefined(level.modifyplayerdamage) && level.modifyplayerdamage != ::modifyplayerdamage) {
    level._id_52E8799C139F7B89 = level.modifyplayerdamage;
    level.modifyplayerdamage = ::modifyplayerdamage;
  }

  level thread oneoffuavsweeps();
  level thread finalthreeuav();
  level thread onplayerconnect();
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.matchrules_initialammo = scripts\mp\utility\dvars::dvarintvalue("initialAmmoCount", 1, 0, 15);
  level.matchrules_rewardammo = scripts\mp\utility\dvars::dvarintvalue("killRewardAmmoCount", 1, 0, 15);
  level.matchrules_oneshotkill = scripts\mp\utility\dvars::dvarintvalue("oneShotKill", 1, 0, 1);
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player scripts\mp\class::_id_A16868D4DCD81A4B();
    player.pers["gamemodeLoadout"] = level.oic_loadouts["axis"];
    player loadweaponsforplayer([level.matchrules_oicweapon.mpweapon], 1);
    player.oic_firstspawn = 1;
    player.oic_hasspawned = 0;
  }
}

getspawnpoint() {
  if(self.oic_firstspawn)
    thread movelatejoinerstospectators();

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    spawnpoint = undefined;
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");

    if(spawnpoints.size > 0) {
      if(!isDefined(level.requiresminstartspawns)) {}

      spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints, 1);
    }

    if(!isDefined(spawnpoint)) {
      spawnpoints = scripts\mp\spawnlogic::getteamspawnpoints(self.team);
      spawnpoint = scripts\mp\spawnscoring::getstartspawnpoint_freeforall(spawnpoints);
    }

    return spawnpoint;
  }

  spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, "none", "dm", "dm_fallback");
  return spawnpoint;
}

movelatejoinerstospectators() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("graceperiod_done");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(5);

  if(!self.oic_hasspawned)
    scripts\mp\menus::addtoteam("spectator", 1);
}

onspawnplayer(_id_9156B53BCF7CE573) {
  _id_0FD32F08E72B657F::onspawnplayercommon(_id_9156B53BCF7CE573);

  if(isDefined(self.oic_rewardammo) && self.oic_rewardammo)
    giveammo();
  else
    self.oic_rewardammo = 0;

  thread waitloadoutdone();
  level notify("spawned_player");

  if(scripts\mp\utility\game::getgametypenumlives() != 0)
    thread playernumlivesvo();
}

waitloadoutdone() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned_player");
  clipsize = weaponclipsize(self.primaryweapon);

  if(level.matchrules_initialammo > clipsize) {
    self setweaponammoclip(self.primaryweapon, clipsize);
    self setweaponammostock(self.primaryweapon, level.matchrules_initialammo - clipsize);

    if(self.primaryweapons[0]._id_318338AA880DFAC6)
      self setweaponammoclip(self.primaryweapon, level.matchrules_initialammo - clipsize, "left");
  } else {
    self setweaponammoclip(self.primaryweapon, level.matchrules_initialammo);
    self setweaponammostock(self.primaryweapon, 0);

    if(self.primaryweapons[0]._id_318338AA880DFAC6)
      self setweaponammoclip(self.primaryweapon, level.matchrules_initialammo, "left");
  }

  burstcount = weaponburstcount(self.primaryweaponobj);

  if(burstcount > 1) {
    if(issubstr(self.primaryweaponobj.underbarrel, "selectsemi") || issubstr(self.primaryweaponobj.underbarrel, "selectauto")) {
      _id_BE014A8D5A4F68F4 = self.primaryweaponobj getaltweapon();

      if(isDefined(_id_BE014A8D5A4F68F4))
        self switchtoweaponimmediate(_id_BE014A8D5A4F68F4);
    }
  }

  scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe("iw9_me_fists_mp");
  _id_F968C960C23738E6 = scripts\cp_mp\utility\weapon_utility::_id_EEAA22F0CD1FF845("iw9_knifestab_mp");
  self giveweapon(_id_F968C960C23738E6);
  self assignweaponmeleeslot(_id_F968C960C23738E6);
  self.oic_hasspawned = 1;
  self setclientomnvar("ui_oic_lives", self.pers["lives"] + 1);
}

playernumlivesvo() {
  _id_76F0BC10A4B13CE2 = self.pers["lives"];

  if(_id_76F0BC10A4B13CE2 == 1)
    scripts\mp\utility\dialog::leaderdialogonplayer("oic_lives_two");
  else if(_id_76F0BC10A4B13CE2 == 0) {
    dialog = scripts\engine\utility::ter_op(randomint(100) < 30, "oic_lives_last_alt", "oic_lives_last");
    scripts\mp\utility\dialog::leaderdialogonplayer(dialog);
  }
}

modifyplayerdamage(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, _id_BE4285B26ED99AB1, _id_1DA1A66B5C6A06A7) {
  if(isDefined(level._id_52E8799C139F7B89))
    idamage = int([[level._id_52E8799C139F7B89]](einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, _id_BE4285B26ED99AB1));

  switch (smeansofdeath) {
    case "MOD_HEAD_SHOT":
    case "MOD_PISTOL_BULLET":
    case "MOD_RIFLE_BULLET":
      if(istrue(level.matchrules_oneshotkill))
        return victim.maxhealth;

      break;
    case "MOD_MELEE":
      return victim.maxhealth;
    default:
      break;
  }

  return idamage;
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
  level.timesincelastdeath = gettime();

  if(attacker.pers["cur_kill_streak"] > attacker scripts\mp\utility\stats::getpersstat("killChains")) {
    attacker.pers["killChains"] = attacker.pers["cur_kill_streak"];
    attacker scripts\mp\utility\stats::setextrascore1(attacker.pers["cur_kill_streak"]);
  }
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, lifeid) {
  if(isDefined(attacker) && isPlayer(attacker) && self != attacker) {
    if(isDefined(smeansofdeath) && smeansofdeath == "MOD_EXECUTION")
      attacker.oic_rewardammo = attacker.oic_rewardammo + (level.matchrules_rewardammo + 2);
    else
      attacker.oic_rewardammo = attacker.oic_rewardammo + level.matchrules_rewardammo;

    attacker giveammo();

    if(scripts\mp\utility\game::getgametypenumlives() && self.pers["deaths"] == scripts\mp\utility\game::getgametypenumlives())
      eliminateplayer(attacker);

    if(smeansofdeath == "MOD_MELEE") {
      attacker scripts\mp\utility\stats::incpersstat("stabs", 1);
      attacker scripts\mp\persistence::statsetchild("round", "stabs", attacker.pers["stabs"]);

      if(isPlayer(attacker))
        attacker scripts\mp\utility\stats::setextrascore0(attacker.pers["stabs"]);
    }

    if(scripts\mp\utility\game::matchmakinggame()) {
      foreach(player in level.players) {
        if(isDefined(player.sessionstate) && (player.sessionstate == "spectator" || player.sessionstate == "spectating")) {
          _id_13C5603D4BEEA2FC = player getspectatingplayer();

          if(isDefined(_id_13C5603D4BEEA2FC) && isDefined(attacker) && _id_13C5603D4BEEA2FC == attacker) {
            player playlocalsound("mp_bodycount_tick_positive");
            points = scripts\mp\rank::getscoreinfovalue("stat_764E78BD2752D4B5");
            player thread scripts\mp\rank::giverankxp("stat_764E78BD2752D4B5", points);
            player setclientomnvar("ui_oic_wager", gettime());
          }
        }
      }
    }
  }
}

onplayerscore(event, player, _id_353F1E80E9476419, victim, _id_7EC7671A1E0C788F) {
  player scripts\mp\utility\stats::incpersstat("gamemodeScore", _id_353F1E80E9476419);
  _id_C82F49D7E44EB40D = int(player scripts\mp\utility\stats::getpersstat("gamemodeScore"));
  player scripts\mp\persistence::statsetchild("round", "gamemodeScore", _id_C82F49D7E44EB40D);

  if(isDefined(_id_7EC7671A1E0C788F)) {
    if(istrue(_id_7EC7671A1E0C788F._id_E0BADEC2B1517CA3))
      return 0;

    if(istrue(_id_7EC7671A1E0C788F._id_3A13C58C2A354968))
      return 0;
  }

  if(event == "stat_EF9582D72160F199") {
    _id_CC7886247A15DFDF = scripts\mp\rank::getscoreinfovalue("stat_CADE9C820001F3BF");
    return _id_CC7886247A15DFDF;
  } else if(event == "stat_FE68DFA78D19874E")
    player scripts\mp\utility\script::bufferednotify("earned_score_buffered", _id_353F1E80E9476419);
  else if(event == "stat_F228812C2D41927F")
    return _id_353F1E80E9476419;

  return 0;
}

onsuicidedeath(victim) {
  if(scripts\mp\utility\game::getgametypenumlives() && victim.pers["deaths"] == scripts\mp\utility\game::getgametypenumlives())
    victim eliminateplayer();
}

ononeleftevent(team) {
  _id_B0DFD912BE32D040 = scripts\mp\utility\game::getlastlivingplayer();
  logstring("last one alive, win: " + _id_B0DFD912BE32D040.name);
  level.finalkillcam_winner = "none";
  level thread _id_5EB4DACF5FBD3485(_id_B0DFD912BE32D040, game["end_reason"]["enemies_eliminated"], game["end_reason"]["br_eliminated"]);
}

_id_5EB4DACF5FBD3485(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE, nukedetonated, _id_8E4A26ED257A393B) {
  level endon("game_ended");
  waitframe();
  level thread scripts\mp\gamelogic::endgame(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE, nukedetonated, _id_8E4A26ED257A393B);
}

giveammo() {
  currentweapon = self.primaryweapon;
  stockammo = self getweaponammostock(currentweapon);
  clipammo = self getweaponammoclip(currentweapon);
  clipsize = weaponclipsize(currentweapon);

  if(clipsize == 1)
    self setweaponammostock(currentweapon, stockammo + self.oic_rewardammo);
  else if(clipammo + self.oic_rewardammo > clipsize) {
    self setweaponammoclip(currentweapon, clipsize);
    self setweaponammostock(currentweapon, stockammo + clipammo + self.oic_rewardammo - clipsize);

    if(isDefined(self.primaryweapons[0]) && self.primaryweapons[0]._id_318338AA880DFAC6) {
      _id_0DBF0BEDC278C4C0 = self getweaponammoclip(currentweapon, "left");
      self setweaponammoclip(currentweapon, stockammo + _id_0DBF0BEDC278C4C0 + self.oic_rewardammo - clipsize, "left");
    }
  } else {
    self setweaponammoclip(currentweapon, clipammo + self.oic_rewardammo);

    if(isDefined(self.primaryweapons[0]) && self.primaryweapons[0]._id_318338AA880DFAC6) {
      _id_0DBF0BEDC278C4C0 = self getweaponammoclip(currentweapon, "left");
      self setweaponammoclip(currentweapon, _id_0DBF0BEDC278C4C0 + self.oic_rewardammo, "left");
    }
  }

  self playlocalsound("br_pickup_ammo", undefined, undefined, 1);
  self.oic_rewardammo = 0;
}

eliminateplayer(attacker) {
  thread scripts\mp\hud_message::showsplash("out_of_lives");
  thread scripts\mp\hud_util::teamplayercardsplash("callout_eliminated", self);

  if(isDefined(attacker)) {
    attacker thread scripts\mp\hud_message::showsplash("target_eliminated");
    attacker thread scripts\mp\events::killeventtextpopup("stat_5F87B176EF1A152D", 0);
  }

  _id_5AAB9D85460F9E87 = [];

  foreach(player in level.players) {
    if(player.pers["deaths"] < scripts\mp\utility\game::getgametypenumlives() && player.oic_hasspawned) {
      _id_5AAB9D85460F9E87[_id_5AAB9D85460F9E87.size] = player;
      player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_F228812C2D41927F");
    }
  }

  if(_id_5AAB9D85460F9E87.size > 2)
    scripts\mp\utility\sound::playsoundonplayers("iw9_mp_oitc_eliminate_player");
  else if(_id_5AAB9D85460F9E87.size == 2) {
    thread scripts\mp\music_and_dialog::stopsuspensemusic();
    scripts\mp\utility\sound::playsoundonplayers("iw9_mp_oitc_last_players");
    setmusicstate("mp_timesup_general");
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastenemyalive", _id_5AAB9D85460F9E87[0], _id_5AAB9D85460F9E87[1].team);
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastenemyalive", _id_5AAB9D85460F9E87[1], _id_5AAB9D85460F9E87[0].team);
  }

  scripts\mp\utility\dialog::leaderdialogonplayers("oic_enemy_eliminated", level.players);
}

playerwager(dowait) {
  level endon("game_ended");
  self endon("disconnect");

  while(scripts\mp\utility\player::isinkillcam())
    waitframe();

  self notifyonplayercommand("selected_player", "+usereload");
  self notifyonplayercommand("selected_player", "+activate");

  for(;;) {
    self waittill("selected_player");
    player = self getspectatingplayer();

    if(isDefined(player)) {
      self.wagingplayer = player.name;
      self playlocalsound("recondrone_tag_plr");
    }
  }
}

finalthreeuav() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("graceperiod_done");
  _id_D643B02A0F8A1CBA = undefined;

  if(scripts\mp\utility\game::matchmakinggame())
    _id_D643B02A0F8A1CBA = getdvarint("dvar_7F1035B67920CE04", 5);

  for(;;) {
    _id_FA666EC667543B59 = [];

    foreach(player in level.players) {
      if(player.pers["deaths"] < scripts\mp\utility\game::getgametypenumlives() && player.oic_hasspawned)
        _id_FA666EC667543B59[_id_FA666EC667543B59.size] = player;
    }

    if(_id_FA666EC667543B59.size < 4) {
      level notify("end_one_off_sweeps");

      foreach(player in level.players) {
        if(scripts\mp\utility\player::isreallyalive(player))
          triggeroneoffradarsweep(player);
      }

      wait(scripts\engine\utility::ter_op(isDefined(_id_D643B02A0F8A1CBA), _id_D643B02A0F8A1CBA, 5));
    }

    wait 0.5;
  }
}

oneoffuavsweeps() {
  level endon("game_ended");
  level endon("end_one_off_sweeps");
  scripts\mp\flags::gameflagwait("prematch_done");
  level.timesincelastdeath = gettime();
  _id_078D5D35856B8FCC = undefined;
  _id_0FA9ECE409C7CB6F = undefined;

  if(scripts\mp\utility\game::matchmakinggame()) {
    _id_078D5D35856B8FCC = getdvarint("dvar_DF2B2C6F95FD821C", 15);
    _id_0FA9ECE409C7CB6F = getdvarint("dvar_ED1F8A6AEC967A91", 5);
  }

  _id_FFBB4AB56E0FC823 = scripts\engine\utility::ter_op(isDefined(_id_078D5D35856B8FCC), _id_078D5D35856B8FCC, 30);
  _id_FFBB4AB56E0FC823 = _id_FFBB4AB56E0FC823 * 1000;
  _id_B0B479E267E5ECF9 = scripts\engine\utility::ter_op(isDefined(_id_0FA9ECE409C7CB6F), _id_0FA9ECE409C7CB6F, 15);

  for(;;) {
    if(gettime() > level.timesincelastdeath + _id_FFBB4AB56E0FC823) {
      foreach(player in level.players) {
        if(scripts\mp\utility\player::isreallyalive(player))
          triggeroneoffradarsweep(player);
      }

      wait(_id_B0B479E267E5ECF9);
    }

    wait 1;
  }
}

setgun() {
  if(scripts\mp\utility\game::matchmakinggame() && getdvarint("dvar_EE08029F3A79CD66", 2) > 0) {
    _id_BAE77D8848F4D84D = getrandomweapon(getdvarint("dvar_EE08029F3A79CD66", 2));
    level.matchrules_oicweapon.weapon = _id_BAE77D8848F4D84D["weapon"];
    level.matchrules_oicweapon.oicvariantid = _id_BAE77D8848F4D84D["variantID"];
  }

  if(!isDefined(level.matchrules_oicweapon.weapon) || level.matchrules_oicweapon.weapon == "none")
    level.matchrules_oicweapon.weapon = "iw9_pi_golf17";
}

getrandomweapon(_id_39DC7F7CA8C1F20E) {
  level.oic_guns = spawnStruct();
  level.oic_guns.weaponclassweights = [];
  level.oic_guns.weaponclassweights["rand_pistol"] = 80;
  level.oic_guns.weaponclassweights["rand_smg"] = 40;
  level.oic_guns.weaponclassweights["rand_assault"] = 40;
  level.oic_guns.weaponclassweights["rand_lmg"] = 25;
  level.oic_guns.weaponclassweights["rand_sniper"] = 40;
  _id_8F08D343C26D5683();

  if(_id_39DC7F7CA8C1F20E == 2) {
    level.oic_guns.weaponclassweights["rand_pistol"] = 100;
    level.oic_guns.weaponclassweights["rand_smg"] = 0;
    level.oic_guns.weaponclassweights["rand_assault"] = 0;
    level.oic_guns.weaponclassweights["rand_lmg"] = 0;
    level.oic_guns.weaponclassweights["rand_sniper"] = 0;
  } else if(_id_39DC7F7CA8C1F20E == 3) {
    level.oic_guns.weaponclassweights["rand_pistol"] = 0;
    level.oic_guns.weaponclassweights["rand_smg"] = 0;
    level.oic_guns.weaponclassweights["rand_assault"] = 0;
    level.oic_guns.weaponclassweights["rand_lmg"] = 0;
    level.oic_guns.weaponclassweights["rand_sniper"] = 100;
  } else if(_id_39DC7F7CA8C1F20E == 4) {
    level.oic_guns.weaponclassweights["rand_pistol"] = 0;
    level.oic_guns.weaponclassweights["rand_smg"] = 100;
    level.oic_guns.weaponclassweights["rand_assault"] = 0;
    level.oic_guns.weaponclassweights["rand_lmg"] = 0;
    level.oic_guns.weaponclassweights["rand_sniper"] = 0;
  } else if(_id_39DC7F7CA8C1F20E == 5) {
    level.oic_guns.weaponclassweights["rand_pistol"] = 0;
    level.oic_guns.weaponclassweights["rand_smg"] = 0;
    level.oic_guns.weaponclassweights["rand_assault"] = 100;
    level.oic_guns.weaponclassweights["rand_lmg"] = 0;
    level.oic_guns.weaponclassweights["rand_sniper"] = 0;
  } else if(_id_39DC7F7CA8C1F20E == 6) {
    level.oic_guns.weaponclassweights["rand_pistol"] = 0;
    level.oic_guns.weaponclassweights["rand_smg"] = 0;
    level.oic_guns.weaponclassweights["rand_assault"] = 0;
    level.oic_guns.weaponclassweights["rand_lmg"] = 100;
    level.oic_guns.weaponclassweights["rand_sniper"] = 0;
  } else if(_id_39DC7F7CA8C1F20E == 7) {
    level.oic_guns.weaponclassweights["rand_pistol"] = 0;
    level.oic_guns.weaponclassweights["rand_smg"] = 0;
    level.oic_guns.weaponclassweights["rand_assault"] = 0;
    level.oic_guns.weaponclassweights["rand_lmg"] = 100;
    level.oic_guns.weaponclassweights["rand_sniper"] = 50;
  }

  _id_B70D1952B9AB92C0 = getrandomkeyfromweaponweightsarray(level.oic_guns.weaponclassweights);
  _id_BAE77D8848F4D84D = _id_DABBFBBD80941F29(_id_B70D1952B9AB92C0);
  return _id_BAE77D8848F4D84D;
}

_id_8F08D343C26D5683() {
  level.weaponcategories = [];
  _id_CB89110314447B2F = 0;

  for(;;) {
    _id_22E2935C86B3B88E = tablelookupbyrow("mp/gunGameWeapons.csv", _id_CB89110314447B2F, 0);

    if(_id_22E2935C86B3B88E == "") {
      break;
    }

    if(!isDefined(level.weaponcategories[_id_22E2935C86B3B88E]))
      level.weaponcategories[_id_22E2935C86B3B88E] = [];

    data = [];
    data["weapon"] = tablelookupbyrow("mp/gunGameWeapons.csv", _id_CB89110314447B2F, 1);
    data["min"] = int(tablelookupbyrow("mp/gunGameWeapons.csv", _id_CB89110314447B2F, 2));
    data["max"] = int(tablelookupbyrow("mp/gunGameWeapons.csv", _id_CB89110314447B2F, 3));
    data["allowed"] = int(tablelookupbyrow("mp/gunGameWeapons.csv", _id_CB89110314447B2F, 8));

    if(!data["allowed"]) {
      _id_CB89110314447B2F++;
      continue;
    }

    level.weaponcategories[_id_22E2935C86B3B88E][level.weaponcategories[_id_22E2935C86B3B88E].size] = data;
    _id_CB89110314447B2F++;
  }
}

_id_DABBFBBD80941F29(_id_22E2935C86B3B88E) {
  selectedweapons = [];
  weaponlist = level.weaponcategories[_id_22E2935C86B3B88E];

  if(isDefined(weaponlist) && weaponlist.size > 0) {
    _id_DD515FCF025B2E79 = "";
    data = undefined;
    loopcount = 0;

    for(;;) {
      index = randomintrange(0, weaponlist.size);
      data = weaponlist[index];
      _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(data["weapon"]);

      if(!isDefined(selectedweapons[_id_AB501F397D3CD312]) || loopcount > weaponlist.size) {
        selectedweapons[_id_AB501F397D3CD312] = 1;

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.weaponcategories[_id_22E2935C86B3B88E].size; _id_AC0E594AC96AA3A8++) {
          if(level.weaponcategories[_id_22E2935C86B3B88E][_id_AC0E594AC96AA3A8]["weapon"] == data["weapon"]) {
            level.weaponcategories[_id_22E2935C86B3B88E] = scripts\engine\utility::array_remove_index(level.weaponcategories[_id_22E2935C86B3B88E], _id_AC0E594AC96AA3A8);
            break;
          }
        }

        break;
      }

      loopcount++;
    }

    return data;
  } else
    return "none";
}

setspecialloadouts() {
  level.oic_loadouts["allies"]["loadoutPrimary"] = level.matchrules_oicweapon.weapon;
  level.oic_loadouts["allies"]["loadoutPrimaryAttachment"] = "none";
  level.oic_loadouts["allies"]["loadoutPrimaryAttachment2"] = "none";
  level.oic_loadouts["allies"]["loadoutPrimaryCamo"] = "none";
  level.oic_loadouts["allies"]["loadoutPrimaryReticle"] = "none";
  level.oic_loadouts["allies"]["loadoutPrimaryAddBlueprintAttachments"] = scripts\engine\utility::ter_op(level.matchrules_oicweapon.oicvariantid != 0, 1, 0);
  level.oic_loadouts["allies"]["loadoutPrimaryVariantID"] = level.matchrules_oicweapon.oicvariantid;
  level.oic_loadouts["allies"]["loadoutSecondary"] = "none";
  level.oic_loadouts["allies"]["loadoutSecondaryAttachment"] = "none";
  level.oic_loadouts["allies"]["loadoutSecondaryAttachment2"] = "none";
  level.oic_loadouts["allies"]["loadoutSecondaryCamo"] = "none";
  level.oic_loadouts["allies"]["loadoutSecondaryReticle"] = "none";
  level.oic_loadouts["allies"]["loadoutSecondaryVariantID"] = 0;
  level.oic_loadouts["allies"]["loadoutEquipmentPrimary"] = "none";
  level.oic_loadouts["allies"]["loadoutEquipmentSecondary"] = "none";
  level.oic_loadouts["allies"]["loadoutStreakType"] = "assault";
  level.oic_loadouts["allies"]["loadoutKillstreak1"] = "none";
  level.oic_loadouts["allies"]["loadoutKillstreak2"] = "none";
  level.oic_loadouts["allies"]["loadoutKillstreak3"] = "none";
  level.aon_loadouts["allies"]["loadoutPerks"] = ["specialty_hustle"];
  level.oic_loadouts["allies"]["loadoutGesture"] = "playerData";
  level.oic_loadouts["allies"]["loadoutFieldUpgrade1"] = "super_deadsilence";
  level.oic_loadouts["allies"]["loadoutFieldUpgrade2"] = "none";
  level.oic_loadouts["axis"] = level.oic_loadouts["allies"];
}

getrandomkeyfromweaponweightsarray(_id_8B462903A1F84F9C) {
  _id_4094287FF08E6D28 = [];
  _id_6FB7DAF6138D07D0 = [];
  _id_B8A569BEF8F3AC2C = 0;

  foreach(key, weight in _id_8B462903A1F84F9C) {
    if(weight > 0) {
      isexcluded = 0;

      if(!isexcluded) {
        _id_B8A569BEF8F3AC2C = _id_B8A569BEF8F3AC2C + weight;
        _id_4094287FF08E6D28[_id_4094287FF08E6D28.size] = key;
        _id_6FB7DAF6138D07D0[_id_6FB7DAF6138D07D0.size] = _id_B8A569BEF8F3AC2C;
      }
    }
  }

  _id_F4CAE9D2914CC11B = randomint(_id_B8A569BEF8F3AC2C);
  key = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4094287FF08E6D28.size; _id_AC0E594AC96AA3A8++) {
    _id_B8A569BEF8F3AC2C = _id_6FB7DAF6138D07D0[_id_AC0E594AC96AA3A8];

    if(_id_F4CAE9D2914CC11B < _id_B8A569BEF8F3AC2C) {
      key = _id_4094287FF08E6D28[_id_AC0E594AC96AA3A8];
      break;
    }
  }

  return key;
}