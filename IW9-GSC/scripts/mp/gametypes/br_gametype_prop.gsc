/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_prop.gsc
*****************************************************/

main() {
  if(!isDefined(level.brgametype) || level.brgametype.name != "prop") {
    return;
  }
  init();
}

init() {
  level.ph = spawnStruct();
  level.ph.settings = spawnStruct();
  level.ph.settings.prophidetime = getdvarint("dvar_8E4A062E9AF4EF42", 30);
  level.ph.settings.propwhistletime = getdvarint("dvar_8F11DD5F31D2B118", 30);
  level.ph.settings.propchangecount = getdvarint("dvar_924023CCB1DB8A0C", 2);
  level.ph.settings.propnumflashes = getdvarint("dvar_5435EBB8D269F904", 1);
  level.ph.settings.propnumclones = getdvarint("dvar_713207D4C9A03261", 3);
  level.ph.settings.propspeedscale = getdvarfloat("dvar_EA1DFD714873E898", 1.4);
  level.ph.settings.modetype = getdvarint("dvar_7C5E401A3ACC5CDD", 0);
  level.ph.settings.numhunters = getdvarint("dvar_DA976E06B127DADD", 20);
  level.ph.settings.numpropsperarea = getdvarint("dvar_77B7A4AD4851900A", 30);

  if(level.ph.settings.modetype == 1) {
    scripts\mp\utility\game::registerroundswitchdvar(level.gametype, 1, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(level.gametype, 4);
    scripts\mp\utility\game::registerscorelimitdvar(level.gametype, 0);
    scripts\mp\utility\game::registerroundlimitdvar(level.gametype, 4);
    scripts\mp\utility\game::registerwinlimitdvar(level.gametype, 3);
    scripts\mp\utility\game::registernumlivesdvar(level.gametype, 1);
    scripts\mp\utility\game::registerhalftimedvar(level.gametype, 0);
    level.objectivebased = 1;
    level.checkforovertime = ::ph_checkforovertime;
    level.getgamewinnerfunc = ::getgamewinnerprop;
    level.gametyperoundendscoresetomnvar = ::gametyperoundendscoresetomnvar;
  }

  level.isprophunt = 1;
  level.allowlatecomers = 1;
  level.autoassignlowteamconsistent = 1;
  level.custom_death_sound = ::playdeathsoundph;
  level.disablespawningforplayerfunc = ::disablespawningforplayer;
  level.checkunscoredspawnpoint = ::checkunscoredspawnpoint;
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onStartGameType", ::onstartgametype);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("modifyPlayerDamage", ::gamemodemodifyplayerdamage);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerConnect", ::onplayerconnect);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerSkipLootPickup", ::playerskiplootpickup);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerKilled", ::onplayerkilled);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerPreSpawnGulagJail", ::playerprespawngulagjail);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerNakedDropLoadout", ::playernakeddroploadout);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("getInfilPlayers", ::getinfilplayers);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("dropOnPlayerDeath", ::droponplayerdeath);
  _id_362C58E8BB39BCDA::disablefeature("plunderSites");
  _id_362C58E8BB39BCDA::disablefeature("drogBagLoadout");
  _id_362C58E8BB39BCDA::disablefeature("oneLife");
  _id_362C58E8BB39BCDA::disablefeature("waitLoadoutDone");
  _id_362C58E8BB39BCDA::disablefeature("armor");
  _id_362C58E8BB39BCDA::disablefeature("squadLeader");
  level.ph.locationcircles = [];
  level.ph.proplist = [];
  level.ph.abilities = ["FLASH", "CLONE"];
  level thread overridecountdownmusic();
  level thread initpostmain();
  level.teammaxfill = 0;
  game["attackers"] = "allies";
  game["defenders"] = "axis";
}

initpostmain() {
  waittillframeend;
  level.onsuicidedeath = ::onsuicidedeath;
  level.onnormaldeath = ::onnormaldeath;
  level.onspawnplayer = ::onspawnplayer;
  level.ononeleftevent = ::ononeleftevent;
  level.ontimelimit = ::ontimelimit;
  level.ondeadevent = ::ondeadevent;
  level.bypassclasschoicefunc = ::phclass;
  level.onplayerjointeam = ::onplayerjointeam;
  scripts\mp\tweakables::settweakablevalue("player", "healthregentime", 0);
  scripts\mp\tweakables::settweakablelastvalue("player", "healthregentime", 0);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
  scripts\mp\rank::registerscoreinfo("stat_2C1EE48B7E3AA323", "stat_7CE4FD9430E80CEA", 50);
  scripts\mp\rank::registerscoreinfo("stat_21351FB706B51643", "stat_7CE4FD9430E80CEA", 50);
  scripts\mp\rank::registerscoreinfo("stat_9EC4C165E5D5575B", "stat_7CE4FD9430E80CEA", 100);
  scripts\mp\rank::registerscoreinfo("stat_128C8E05D92EAD1A", "stat_7CE4FD9430E80CEA", 150);
  scripts\mp\rank::registerscoreinfo("stat_A75C210D54170EC6", "stat_7CE4FD9430E80CEA", 50);
  scripts\mp\rank::registerscoreinfo("stat_2F326C8FBA1662F4", "stat_7CE4FD9430E80CEA", 10);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "onEnterVehicle", ::vehicle_occupancy_mp_onentervehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "onExitVehicle", ::vehicle_occupancy_mp_onexitvehicle);
  populateproplist();
  initpropcircles();
}

overridecountdownmusic() {
  while(!isDefined(game["music"]) || !isDefined(game["music"]["match_ending_soon"]))
    waitframe();

  game["music"]["match_ending_soon"] = "prop_countdown";
}

onplayerconnect(player) {
  if(!isDefined(player.pers["propSeconds"]))
    player.pers["propSeconds"] = 0;
}

onstartgametype() {
  if(level.ph.settings.modetype == 1) {
    if([[level.checkforovertime]]()) {
      game["status"] = "overtime";
      setDvar("ui_overtime", 1);
      setDvar("overtimeTimeLimit", 3.5);
    }

    if(!isDefined(game["switchedsides"]))
      game["switchedsides"] = 0;

    if(game["switchedsides"]) {
      _id_2B21F2FBE8DD5C6E = game["attackers"];
      _id_8D904E28CF14C8AE = game["defenders"];
      game["attackers"] = _id_8D904E28CF14C8AE;
      game["defenders"] = _id_2B21F2FBE8DD5C6E;
    } else
      level.prematchperiod = 30;
  }

  setspecialloadouts();
  setclientnamemode("manual_change");
  scripts\mp\utility\game::setobjectivetext(game["attackers"], &"OBJECTIVES_PH/ATTACKER");
  scripts\mp\utility\game::setobjectivetext(game["defenders"], &"OBJECTIVES_PH/DEFENDER");
  scripts\mp\utility\game::setobjectivescoretext(game["attackers"], &"OBJECTIVES_PH/ATTACKER_SCORE");
  scripts\mp\utility\game::setobjectivescoretext(game["defenders"], &"OBJECTIVES_PH/DEFENDER_SCORE");
  scripts\mp\utility\game::setobjectivehinttext(game["attackers"], &"OBJECTIVES_PH/ATTACKER_HINT");
  scripts\mp\utility\game::setobjectivehinttext(game["defenders"], &"OBJECTIVES_PH/DEFENDER_HINT");

  if(level.ph.settings.modetype == 1) {
    _id_D283BD6AB5FF4BA3 = game["roundsPlayed"] % 4 == 2 || game["roundsPlayed"] % 4 == 3;

    if(_id_D283BD6AB5FF4BA3) {
      game["switchedsides"] = !game["switchedsides"];
      game["switchedsides"] = !game["switchedsides"];
    } else {}
  }

  level._effect["propFlash"] = loadfx("vfx/core/mp/equipment/vfx_concussion_grenade");
  level._effect["propDeathFX"] = loadfx("vfx/iw9/core/equipment/vfx_equip_claymore_trigger.vfx");

  if(!isDefined(game["propScore"])) {
    game["propScore"] = [];
    game["propScore"]["allies"] = 0;
    game["propScore"]["axis"] = 0;
  }

  if(!isDefined(game["propSurvivalTime"])) {
    game["propSurvivalTime"] = [];
    game["propSurvivalTime"]["allies"] = 0;
    game["propSurvivalTime"]["axis"] = 0;
  }

  if(!isDefined(game["hunterKillTime"])) {
    game["hunterKillTime"] = [];
    game["hunterKillTime"]["allies"] = 0;
    game["hunterKillTime"]["axis"] = 0;
  }

  scripts\mp\flags::gameflaginit("props_hide_over", 0);
  scripts\mp\flags::gameflaginit("props_hide_start", 0);
  level thread setuproundstarthud();
  level thread propspectating();
  level thread _id_5B1AF0B4DB421B9D::hidehudintermission();
  level thread monitortimers();
  level thread deleteallglass();
  level thread setphteamscores();
  level thread stillalivexp();
  level thread tracktimealive();
  level thread startpropcirclelogic();
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  propgiveteamscore(attacker.pers["team"]);

  if(game["state"] == "postgame" && game["teamScores"][attacker.team] > game["teamScores"][level.otherteam[attacker.team]])
    attacker.finalkill = 1;
}

onsuicidedeath(victim) {
  if(victim scripts\mp\playerlogic::mayspawn()) {
    return;
  }
  otherteam = scripts\mp\utility\game::getotherteam(victim.pers["team"]);

  foreach(team in otherteam)
  propgiveteamscore(team);
}

propgiveteamscore(team) {
  if(team != game["attackers"]) {
    return;
  }
  level scripts\mp\gamescore::giveteamscoreforobjective(team, 1, 1);
  game["propScore"][team] = game["propScore"][team] + 1;
}

getgamewinnerprop(_id_5C24673A4292C14A, _id_11A9FC8279BF2A76) {
  if(!isstring(_id_5C24673A4292C14A))
    return _id_5C24673A4292C14A;

  _id_879B2EABB8C300C4 = _id_5C24673A4292C14A;

  if(level.gameended) {
    _id_3584E10C9B07FA77 = "roundsWon";

    if(isDefined(level.winbycaptures) && level.winbycaptures)
      _id_3584E10C9B07FA77 = "teamScores";

    level.proptiebreaker = "none";

    if(game[_id_3584E10C9B07FA77]["allies"] == game[_id_3584E10C9B07FA77]["axis"]) {
      level.proptiebreaker = "kills";

      if(game["propScore"]["axis"] == game["propScore"]["allies"]) {
        level.proptiebreaker = "time";

        if(game["hunterKillTime"]["axis"] == game["hunterKillTime"]["allies"]) {
          level.proptiebreaker = "tie";
          _id_879B2EABB8C300C4 = "tie";
        } else if(game["hunterKillTime"]["axis"] < game["hunterKillTime"]["allies"])
          _id_879B2EABB8C300C4 = "axis";
        else
          _id_879B2EABB8C300C4 = "allies";
      } else if(game["propScore"]["axis"] > game["propScore"]["allies"])
        _id_879B2EABB8C300C4 = "axis";
      else
        _id_879B2EABB8C300C4 = "allies";

      if(_id_879B2EABB8C300C4 != "tie")
        level thread givephteamscore(_id_879B2EABB8C300C4);
    } else if(game[_id_3584E10C9B07FA77]["axis"] > game[_id_3584E10C9B07FA77]["allies"])
      _id_879B2EABB8C300C4 = "axis";
    else
      _id_879B2EABB8C300C4 = "allies";
  }

  if(_id_11A9FC8279BF2A76 && (_id_879B2EABB8C300C4 == "allies" || _id_879B2EABB8C300C4 == "axis"))
    ph_setfinalkillcamwinner(_id_879B2EABB8C300C4);

  return _id_879B2EABB8C300C4;
}

getemptyloadout() {
  _id_25E4BC37C8E72A66 = [];
  _id_25E4BC37C8E72A66["loadoutArchetype"] = "archetype_assault";
  _id_25E4BC37C8E72A66["loadoutPrimary"] = "none";
  _id_25E4BC37C8E72A66["loadoutPrimaryAttachment"] = "none";
  _id_25E4BC37C8E72A66["loadoutPrimaryAttachment2"] = "none";
  _id_25E4BC37C8E72A66["loadoutPrimaryCamo"] = "none";
  _id_25E4BC37C8E72A66["loadoutPrimaryReticle"] = "none";
  _id_25E4BC37C8E72A66["loadoutSecondary"] = "none";
  _id_25E4BC37C8E72A66["loadoutSecondaryAttachment"] = "none";
  _id_25E4BC37C8E72A66["loadoutSecondaryAttachment2"] = "none";
  _id_25E4BC37C8E72A66["loadoutSecondaryCamo"] = "none";
  _id_25E4BC37C8E72A66["loadoutSecondaryReticle"] = "none";
  _id_25E4BC37C8E72A66["loadoutMeleeSlot"] = "iw9_me_fists_mp";
  _id_25E4BC37C8E72A66["loadoutEquipmentPrimary"] = "none";
  _id_25E4BC37C8E72A66["loadoutEquipmentSecondary"] = "none";
  _id_25E4BC37C8E72A66["loadoutStreakType"] = "assault";
  _id_25E4BC37C8E72A66["loadoutKillstreak1"] = "none";
  _id_25E4BC37C8E72A66["loadoutKillstreak2"] = "none";
  _id_25E4BC37C8E72A66["loadoutKillstreak3"] = "none";
  _id_25E4BC37C8E72A66["loadoutSuper"] = "super_br_extract";
  _id_25E4BC37C8E72A66["loadoutPerks"] = ["specialty_null"];
  _id_25E4BC37C8E72A66["loadoutGesture"] = "playerData";
  return _id_25E4BC37C8E72A66;
}

setspecialloadouts() {
  _id_69C48349D6151B37 = game["defenders"];
  level.ph_loadouts[_id_69C48349D6151B37] = getemptyloadout();
  attackerteam = game["attackers"];
  level.ph_loadouts[attackerteam] = getemptyloadout();
  level.ph_loadouts[attackerteam]["loadoutPrimary"] = "iw8_ar_akilo47";
  level.ph_loadouts[attackerteam]["loadoutPrimaryAttachment"] = "xmags";
  level.ph_loadouts[attackerteam]["loadoutPrimaryAttachment2"] = "laser";
  level.ph_loadouts[attackerteam]["loadoutSecondary"] = "iw8_pi_mike1911";
  level.ph_loadouts[attackerteam]["loadoutEquipmentSecondary"] = "equip_concussion";
  level.ph_loadouts[attackerteam]["loadoutPerks"] = ["specialty_restock", "specialty_hustle"];
}

phclass() {
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  self.pers["gamemodeLoadout"] = level.ph_loadouts[self.pers["team"]];
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
  return self.class;
}

propspectating() {
  level endon("game_ended");
  scripts\mp\spectating::updatespectatesettings();
}

whistlestarttimer(duration) {
  level notify("whistle_start_timer_beginning");
  _id_B710552E5D79A601 = int(duration);

  if(_id_B710552E5D79A601 >= 0)
    thread whistlestarttimer_internal(_id_B710552E5D79A601);
}

whistlestarttimer_internal(_id_B710552E5D79A601) {
  level endon("whistle_start_timer_beginning");
  waittillframeend;

  while(_id_B710552E5D79A601 > 0 && !level.gameended) {
    setomnvar("ui_ph_whistle_countdown", _id_B710552E5D79A601);
    _id_B710552E5D79A601--;
    wait 1;
  }

  setomnvar("ui_ph_whistle_countdown", _id_B710552E5D79A601);
}

useprophudserver() {
  return 1;
}

setuproundstarthud() {
  if(useprophudserver() && level.ph.settings.prophidetime > 0) {
    level.ph.countdowntimer = scripts\mp\hud_util::createservertimer("default", 1.4);
    level.ph.countdowntimer scripts\mp\hud_util::setpoint("CENTER", undefined, 0, 50);
    level.ph.countdowntimer.label = &"MP_PH/STARTS_IN";
    level.ph.countdowntimer.alpha = 0;
    level.ph.countdowntimer.archived = 0;
    level.ph.countdowntimer.hidewheninmenu = 1;
    level.ph.countdowntimer.sort = 1;
  }

  if(useprophudserver()) {
    level.ph.whistletimer = scripts\mp\hud_util::createservertimer("default", 0.9);
    level.ph.whistletimer.x = -6;
    level.ph.whistletimer.y = 2;
    level.ph.whistletimer.alignx = "right";
    level.ph.whistletimer.aligny = "top";
    level.ph.whistletimer.horzalign = "right_adjustable";
    level.ph.whistletimer.vertalign = "top_adjustable";
    level.ph.whistletimer.label = &"MP_PH/WHISTLE_IN";
    level.ph.whistletimer.alpha = 0;
    level.ph.whistletimer.archived = 1;
    level.ph.whistletimer.hidewheninmenu = 1;
    level.ph.whistletimer settimer(120);
  } else
    whistlestarttimer(120);

  if(useprophudserver()) {
    level.whistling = createserverfontstring("default", 1);
    level.whistling.label = &"MP_PH/WHISTLING";
    level.whistling.x = -5;
    level.whistling.y = 2;
    level.whistling.alignx = "right";
    level.whistling.aligny = "top";
    level.whistling.horzalign = "right_adjustable";
    level.whistling.vertalign = "top_adjustable";
    level.whistling.archived = 1;
    level.whistling.alpha = 0;
    level.whistling.glowalpha = 0.2;
    level.whistling.hidewheninmenu = 0;
  }

  if(useprophudserver()) {
    if(!isDefined(level.elim_hud))
      level.elim_hud = [];

    level.elim_hud = createserverfontstring("default", 0.9);
    level.elim_hud.label = &"MP_PH/ALIVE";
    level.elim_hud setvalue(0);
    level.elim_hud.x = -5;
    level.elim_hud.y = 14;
    level.elim_hud.alignx = "right";
    level.elim_hud.aligny = "top";
    level.elim_hud.horzalign = "right_adjustable";
    level.elim_hud.vertalign = "top_adjustable";
    level.elim_hud.archived = 1;
    level.elim_hud.fontscale = 1.0;
    level.elim_hud.alpha = 1;
    level.elim_hud.glowalpha = 0;
    level.elim_hud.hidewheninmenu = 0;
    level thread eliminatedhudmonitor();
  }
}

createserverfontstring(font, fontscale) {
  _id_372B658AEA9D2487 = newhudelem();
  _id_372B658AEA9D2487.elemtype = "font";
  _id_372B658AEA9D2487.font = font;
  _id_372B658AEA9D2487.fontscale = fontscale;
  _id_372B658AEA9D2487.basefontscale = fontscale;
  _id_372B658AEA9D2487.x = 0;
  _id_372B658AEA9D2487.y = 0;
  _id_372B658AEA9D2487.width = 0;
  _id_372B658AEA9D2487.height = int(level.fontheight * fontscale);
  _id_372B658AEA9D2487.xoffset = 0;
  _id_372B658AEA9D2487.yoffset = 0;
  _id_372B658AEA9D2487.children = [];
  _id_372B658AEA9D2487 scripts\mp\hud_util::setparent(level.uiparent);
  _id_372B658AEA9D2487.hidden = 0;
  _id_372B658AEA9D2487.archived = 0;
  return _id_372B658AEA9D2487;
}

eliminatedhudmonitor() {
  level endon("game_ended");

  for(;;) {
    _id_104F87CC51A1138D = get_alive_nonspecating_players(game["defenders"]);
    level.elim_hud setvalue(_id_104F87CC51A1138D.size);
    level scripts\engine\utility::waittill_any_5("player_spawned", "playerCountChanged", "propCountChanged", "playerDisconnected");
  }
}

get_alive_nonspecating_players(team) {
  _id_A558952AE98E6170 = [];

  foreach(player in level.players) {
    if(isDefined(player) && isalive(player) && (!isDefined(player.sessionstate) || player.sessionstate == "playing")) {
      if(!isDefined(team) || player.team == team)
        _id_A558952AE98E6170[_id_A558952AE98E6170.size] = player;
    }
  }

  return _id_A558952AE98E6170;
}

onplayerdisconnect(player) {
  level notify("playerDisconnected");

  if(isDefined(player.proplocationindex))
    player propremovefromlocation();
  else if(isDefined(player.propcircleindex))
    player propremovefromcircle();
}

kickplayer(player, _id_401C3A2E68AAB0FD) {
  if(isbot(player)) {
    return;
  }
  kick(player getentitynumber(), _id_401C3A2E68AAB0FD);
}

weaponusagecheck() {
  msg = scripts\engine\utility::waittill_any_return_4("weapon_fired", "sprint_begin", "specialGrenade", "end_weapon_check_usage");

  if(msg == "end_weapon_check_usage") {
    if(istrue(self.hashitplayer))
      return 1;

    kickplayer(self, "EXE_PLAYERKICKED_INACTIVE");
    return 0;
  }

  return 1;
}

positioncheck(time, radius) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!isDefined(time))
    time = 45;

  if(!isDefined(radius))
    radius = 300;

  _id_B3FF840AF360748D = self.origin;
  _id_AE43E5EE14ABFFB2 = squared(radius);
  _id_D67454CB6083B84D = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < time; _id_AC0E594AC96AA3A8++) {
    if(!_id_D67454CB6083B84D) {
      _id_936C20E04E851B47 = distancesquared(_id_B3FF840AF360748D, self.origin);

      if(_id_936C20E04E851B47 >= _id_AE43E5EE14ABFFB2)
        _id_D67454CB6083B84D = 1;
    }

    wait 1;
  }

  if(_id_D67454CB6083B84D)
    return 1;

  return 0;
}

waittillhuntersdrop() {
  scripts\mp\flags::gameflagwait("br_ready_to_jump");
}

startcheck() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self.doingcheck = 1;
  waittillhuntersdrop();
  childthread weaponusagecheck();

  if(!positioncheck(45, 300)) {
    if(istrue(self.hashitplayer)) {
      return;
    }
    kickplayer(self, "EXE_PLAYERKICKED_INACTIVE");
    return;
  }

  if(!positioncheck(75, 150)) {
    if(istrue(self.hashitplayer)) {
      return;
    }
    kickplayer(self, "EXE_PLAYERKICKED_INACTIVE");
    return;
  }

  wait 30;
  self notify("end_weapon_check_usage");
}

onspawnplayer(_id_9156B53BCF7CE573) {
  _id_1E4A61DB11011446::onspawnplayer();
  self.breathingstoptime = 0;

  if(playerisprop()) {
    self.skipcorpse = 1;
    self.overrideweaponspeed_speedscale = level.ph.settings.propspeedscale;

    if(!isDefined(self.abilityleft))
      self.abilityleft = 0;

    if(!isDefined(self.clonesleft))
      self.clonesleft = 0;

    if(!isDefined(self.pers["ability"]))
      self.pers["ability"] = 0;

    self.currentability = level.ph.abilities[self.pers["ability"]];

    if(useprophudserver())
      thread _id_5B1AF0B4DB421B9D::propcontrolshud();

    self.isangleoffset = 0;
    _id_F593B5B874AE0128 = int(level.ph.settings.propchangecount);
    _id_6B59783C7C0B2A84 = undefined;
    _id_F4224E0C07BA8435 = undefined;

    if(isDefined(self.spawnedonce) && isDefined(self.changesleft)) {
      _id_F593B5B874AE0128 = self.changesleft;
      _id_6B59783C7C0B2A84 = self.abilityleft;
      _id_F4224E0C07BA8435 = self.clonesleft;
    }

    _id_5B1AF0B4DB421B9D::propsetchangesleft(_id_F593B5B874AE0128);
    _id_5B1AF0B4DB421B9D::setnewabilitycount(self.currentability, _id_6B59783C7C0B2A84);
    _id_5B1AF0B4DB421B9D::setnewabilitycount("CLONE", _id_F4224E0C07BA8435);
    thread _id_5B1AF0B4DB421B9D::cleanuppropcontrolshudondeath();
    thread handleprop();
  } else {
    self.skipcorpse = undefined;
    self.abilityleft = undefined;
    self.clonesleft = undefined;
    self.overrideweaponspeed_speedscale = undefined;

    if(!isDefined(self.thrownspecialcount))
      self.thrownspecialcount = 0;

    thread givecustomloadout();
    _id_F22620FCF5A86187 = 1;

    if(_id_F22620FCF5A86187 && !isDefined(self.doingcheck))
      thread startcheck();
  }

  self.spawnedonce = 1;
}

monitortimers() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("props_hide_start");

  if(useprophudserver()) {
    if(level.ph.settings.prophidetime > 0) {
      level.ph.countdowntimer settimer(level.ph.settings.prophidetime);
      level.ph.countdowntimer.alpha = 1;
    }

    level.ph.whistletimer settimer(level.ph.settings.propwhistletime + level.ph.settings.prophidetime);
    level.ph.whistletimer.alpha = 1;
  } else if(level.ph.settings.prophidetime > 0 || level.ph.settings.propwhistletime > 0)
    whistlestarttimer(level.ph.settings.propwhistletime + level.ph.settings.prophidetime);

  if(level.ph.settings.prophidetime > 0)
    wait(level.ph.settings.prophidetime);

  scripts\mp\flags::gameflagset("props_hide_over");

  if(useprophudserver()) {
    level.ph.whistletimer.alpha = 1;

    if(level.ph.settings.prophidetime > 0)
      level.ph.countdowntimer.alpha = 0;
  }

  if(level.ph.settings.propwhistletime > 0)
    propwhistle();
}

handleprop() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self waittill("giveLoadout");
  self allowprone(0);
  self allowsprint(0);
  scripts\mp\weapons::updatemovespeedscale();
  self disableweaponpickup();
  self takeallweapons();
  self allowspectateteam(game["attackers"], 1);
  scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_gametype_prop::handleProp()");
  scripts\mp\class::loadout_giveperk("specialty_quieter");
  thread setupprop();
  thread _id_5B1AF0B4DB421B9D::setupkeybindings();
  thread setupdamage();
  thread _id_5B1AF0B4DB421B9D::propinputwatch();
  thread propwatchdeath();
  thread propwatchcleanupondisconnect();
  thread propwatchcleanuponroundend();
  thread propwatchprematchsettings();
  self.prop thread highlighttoteam(game["defenders"], "outline_nodepth_cyan", self);
  self.concussionimmune = undefined;
}

getthirdpersonrangeforsize(propsize) {
  switch (propsize) {
    case 50:
      return 120;
    case 100:
      return 150;
    case 250:
      return 180;
    case 450:
      return 260;
    case 550:
      return 320;
    default:
      break;
  }

  return 120;
}

getthirdpersonheightoffsetforsize(propsize) {
  switch (propsize) {
    case 50:
      return -30;
    case 100:
      return -20;
    case 250:
      return 0;
    case 450:
      return 20;
    case 550:
      return 40;
    default:
      break;
  }

  return 0;
}

applyxyzoffset() {
  if(!isDefined(self.prop.xyzoffset)) {
    return;
  }
  self.prop.angles = self.angles;
  forward = anglesToForward(self.prop.angles) * self.prop.xyzoffset[0];
  right = anglestoright(self.prop.angles) * self.prop.xyzoffset[1];
  up = anglestoup(self.prop.angles) * self.prop.xyzoffset[2];
  self.prop.origin = self.prop.origin + forward;
  self.prop.origin = self.prop.origin + right;
  self.prop.origin = self.prop.origin + up;
}

applyanglesoffset() {
  if(!isDefined(self.prop.anglesoffset)) {
    return;
  }
  self.prop.angles = self.angles;
  self.prop.angles = self.prop.angles + self.prop.anglesoffset;
  self.isangleoffset = 1;
}

gettimeremaining() {
  time = 0;

  if(isDefined(level.br_level) && isDefined(level.br_level.br_circlecenters)) {
    for(circleindex = 0; circleindex < level.br_level.br_circledelaytimes.size; circleindex++) {
      _id_3702CBA57F844507 = level.br_level.br_circledelaytimes[circleindex];
      _id_3D8565E2775A243C = level.br_level.br_circleclosetimes[circleindex];
      time = time + _id_3702CBA57F844507 + _id_3D8565E2775A243C;
    }

    time = time * 1000;
    _id_3B5803E733581858 = gettime() - level.ph.settings.whistlestarttime;
    time = time - _id_3B5803E733581858;

    if(time < 0)
      time = 0;
  }

  return int(time);
}

propwhistle() {
  level endon("game_ended");
  level.ph.settings.whistlestarttime = gettime();
  time = gettime();
  _id_0A51874BC1E6D85C = level.ph.settings.propwhistletime * 1000;
  _id_B490B088FBD2F569 = 20000;
  _id_76A578EF952D8334 = _id_B490B088FBD2F569;
  _id_F3EACD98426E2D77 = 500;
  _id_7877734EFD0DC2C5 = 5000;
  _id_6DDF936FD5C46EDC = 0;
  _id_11670E558F3EFDEB = getEntArray("minimap_corner", "targetname")[0].origin;
  wait(level.ph.settings.propwhistletime);

  if(!useprophudserver())
    setomnvar("ui_war_active_sector", 0);

  for(;;) {
    if(time + _id_0A51874BC1E6D85C - _id_F3EACD98426E2D77 < gettime()) {
      _id_6DDF936FD5C46EDC++;
      _id_D0A837FCF948CC7E = sortbydistance(level.players, _id_11670E558F3EFDEB);

      foreach(player in _id_D0A837FCF948CC7E) {
        if(!isDefined(player)) {
          continue;
        }
        if(useprophudserver()) {
          level.ph.whistletimer.alpha = 0;
          level.whistling.alpha = 0.6;
        }

        if(player playerisprop() && isalive(player)) {
          if(useprophudserver()) {
            level.whistling.alpha = 1;
            level.whistling fadeovertime(0.75);
            level.whistling.alpha = 0.6;
          }

          playsoundatpos(player.origin + (0, 0, 60), "prop_whistle");
          wait 1.5;
        }
      }

      if(!useprophudserver())
        setomnvar("ui_war_active_sector", 2);

      time = gettime();

      if(_id_6DDF936FD5C46EDC % 2 == 0)
        _id_0A51874BC1E6D85C = max(_id_0A51874BC1E6D85C - 5000, _id_B490B088FBD2F569);

      if(_id_76A578EF952D8334 >= gettimeremaining() - _id_7877734EFD0DC2C5) {
        if(useprophudserver())
          level.whistling.alpha = 0;

        return;
      } else {
        if(_id_76A578EF952D8334 * 2 + getteamplayersalive(game["defenders"]) * 2500 >= gettimeremaining() - _id_7877734EFD0DC2C5) {
          if(useprophudserver())
            level.ph.whistletimer.label = &"MP_PH/FINAL_WHISTLE";
          else
            setomnvar("ui_war_active_sector", 1);

          _id_76A578EF952D8334 = _id_76A578EF952D8334 + getteamplayersalive(game["defenders"]) * 2500;
        }

        if(useprophudserver())
          level.ph.whistletimer settimer(int(_id_0A51874BC1E6D85C / 1000));
        else
          whistlestarttimer(int(_id_0A51874BC1E6D85C / 1000));

        if(useprophudserver()) {
          level.whistling.alpha = 0;
          level.ph.whistletimer.alpha = 1;
        }
      }
    }

    wait 0.5;
  }
}

getlivingplayersonteam(team) {
  players = [];

  foreach(player in level.participants) {
    if(!isDefined(player.team)) {
      continue;
    }
    if(scripts\cp_mp\utility\player_utility::isreallyalive(player) && scripts\mp\utility\entity::isteamparticipant(player) && player.team == team)
      players[players.size] = player;
  }

  return players;
}

createpropspeclist() {
  self.spectatableprops = getlivingplayersonteam(game["defenders"]);
}

setupdamage() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  wait 0.5;
  self.prop.skipignoredamage = 1;
  self.prop thread scripts\mp\damage::monitordamage(self.prop.health, "standard", undefined, ::damagewatch);
}

damagewatch(damagedata) {
  if(!isDefined(damagedata.attacker))
    return 0;

  if(!isDefined(self.owner))
    return 0;

  if(isPlayer(damagedata.attacker)) {
    if(damagedata.attacker.pers["team"] == self.owner.pers["team"])
      return 0;

    damagedata.attacker thread _id_5762AC2F22202BA2::updatedamagefeedback("standard");

    if(damagedata.objweapon.basename == "concussion_grenade_mp") {
      inflictor = spawnStruct();
      inflictor.origin = damagedata.point;
      self.owner thread scripts\mp\equipment\concussion_grenade::applyconcussion(inflictor, damagedata.attacker);

      if(istrue(self.owner.lock))
        self.owner _id_5B1AF0B4DB421B9D::unlockprop();
    }
  }

  self.owner dodamage(damagedata.damage, damagedata.point, damagedata.attacker, damagedata.inflictor, damagedata.meansofdeath, damagedata.objweapon);
  return 0;
}

propcleanup() {
  thread propcleanupdelayed([self.prop, self.propanchor, self.propent]);
}

propcleanupdelayed(_id_6C49AE5C99A12E66) {
  foreach(prop in _id_6C49AE5C99A12E66) {
    if(isDefined(prop))
      prop unlink();
  }

  waitframe();

  foreach(prop in _id_6C49AE5C99A12E66) {
    if(isDefined(prop))
      prop delete();
  }
}

propwatchdeath() {
  level endon("game_ended");
  self endon("disconnect");
  self.deathnoise = "prop_death";
  self.propdeathfx = "propDeathFX";
  self waittill("death");
  corpse = self.body;
  playsoundatpos(self.prop.origin + (0, 0, 4), self.deathnoise);
  playFX(scripts\engine\utility::getfx(self.propdeathfx), self.prop.origin + (0, 0, 4));

  if(isDefined(corpse))
    corpse delete();

  propcleanup();
  self setcamerathirdperson(0, 0);
  playersetispropgameextrainfo(0);
}

propwatchcleanupondisconnect() {
  self notify("propWatchDeleteDisconnect");
  self endon("propWatchDeleteDisconnect");
  level endon("game_ended");
  self waittill("disconnect");

  foreach(player in level.players) {
    if(istrue(player.propspectating) && isDefined(player.spectatingthisplayer) && self == player.spectatingthisplayer)
      player notify("endPropSpectate");
  }

  propcleanup();
  propclonecleanup();
}

propwatchcleanuponroundend() {
  self notify("propWatchDeleteRoundEnd");
  self endon("propWatchDeleteRoundEnd");
  self endon("disconnect");
  level waittill("game_ended");
  scripts\engine\utility::waittill_notify_or_timeout("end_killcam", 5);
  propcleanup();
  propclonecleanup();
}

propclonecleanup() {
  if(isDefined(self.propclones)) {
    foreach(clone in self.propclones) {
      if(isDefined(clone))
        clone delete();
    }
  }
}

cleanupallclones() {
  foreach(player in level.players)
  player propclonecleanup();
}

propwatchprematchsettings() {
  self endon("death_or_disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self allowprone(0);
  self allowsprint(0);
}

deleteallglass() {
  level endon("game_ended");
  level waittill("prematch_over");
}

organizeproplist() {
  foreach(_id_21C4D87583EBB2E1, _id_423A45E655392086 in level.ph.proplist) {
    if(_id_21C4D87583EBB2E1 != "any") {
      foreach(_id_921DFF268D0950BF, _id_0435B2DA7F892448 in level.ph.proplist["any"])
      level.ph.proplist[_id_21C4D87583EBB2E1][_id_921DFF268D0950BF] = scripts\engine\utility::array_combine(level.ph.proplist[_id_21C4D87583EBB2E1][_id_921DFF268D0950BF], _id_0435B2DA7F892448);
    }
  }
}

randgetpropsizetoallocate(_id_9A1612BF33A317B1) {
  proplist = level.ph.proplist[_id_9A1612BF33A317B1];
  _id_BDE9BAC11A4EA5D1 = 10 * isDefined(proplist[50]);
  _id_B3DB878D55C5832D = 30 * isDefined(proplist[100]);
  _id_9D433B0AA28E7E65 = 40 * isDefined(proplist[250]);
  _id_0BD98EEF901F2929 = 20 * isDefined(proplist[450]);
  _id_1FCA58FADF5CD30D = 10 * isDefined(proplist[550]);
  _id_2390DA28FA1AEC9B = _id_BDE9BAC11A4EA5D1 + _id_B3DB878D55C5832D + _id_9D433B0AA28E7E65 + _id_0BD98EEF901F2929 + _id_1FCA58FADF5CD30D;
  _id_73C0BD15F57DB725 = randomint(_id_2390DA28FA1AEC9B);

  if(_id_73C0BD15F57DB725 < _id_BDE9BAC11A4EA5D1)
    return 50;

  _id_73C0BD15F57DB725 = _id_73C0BD15F57DB725 - _id_BDE9BAC11A4EA5D1;

  if(_id_73C0BD15F57DB725 < _id_B3DB878D55C5832D)
    return 100;

  _id_73C0BD15F57DB725 = _id_73C0BD15F57DB725 - _id_B3DB878D55C5832D;

  if(_id_73C0BD15F57DB725 < _id_9D433B0AA28E7E65)
    return 250;

  _id_73C0BD15F57DB725 = _id_73C0BD15F57DB725 - _id_9D433B0AA28E7E65;

  if(_id_73C0BD15F57DB725 < _id_0BD98EEF901F2929)
    return 450;

  _id_73C0BD15F57DB725 = _id_73C0BD15F57DB725 - _id_0BD98EEF901F2929;
  return 550;
}

getnextprop(player) {
  _id_9A1612BF33A317B1 = player propgetlocation();
  proplist = level.ph.proplist[_id_9A1612BF33A317B1];
  _id_1C997AD3FAFC39EE = randgetpropsizetoallocate(_id_9A1612BF33A317B1);
  _id_219810E78CC11981 = scripts\engine\utility::array_randomize(getarraykeys(proplist));
  _id_F0F529FE48DAC762 = [_id_1C997AD3FAFC39EE];

  foreach(_id_A61C75B156FC1EE0 in _id_219810E78CC11981) {
    if(_id_A61C75B156FC1EE0 != _id_1C997AD3FAFC39EE)
      _id_F0F529FE48DAC762[_id_F0F529FE48DAC762.size] = _id_A61C75B156FC1EE0;
  }

  prop = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F0F529FE48DAC762.size; _id_AC0E594AC96AA3A8++) {
    _id_A61C75B156FC1EE0 = _id_F0F529FE48DAC762[_id_AC0E594AC96AA3A8];

    if(!isDefined(proplist[_id_A61C75B156FC1EE0]) || !proplist[_id_A61C75B156FC1EE0].size) {
      continue;
    }
    _id_47185C13F2C43EAC = scripts\engine\utility::array_randomize(proplist[_id_A61C75B156FC1EE0]);

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_47185C13F2C43EAC.size; _id_AC0E5C4AC96AAA41++) {
      prop = _id_47185C13F2C43EAC[_id_AC0E5C4AC96AAA41];
      _id_CC50B1CFABB2F8F9 = 0;

      if(isDefined(player.usedprops) && player.usedprops.size) {
        for(index = 0; index < player.usedprops.size; index++) {
          if(prop.modelname == player.usedprops[index].modelname) {
            _id_CC50B1CFABB2F8F9 = 1;
            break;
          }
        }
      }

      if(!_id_CC50B1CFABB2F8F9)
        return prop;
    }
  }

  return prop;
}

populateproplist() {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();
  _id_3EF92CFB93C67BC7 = "mp/" + mapname + "_ph.csv";
  _id_977F24E61599CBBA = 0;

  if(tableexists(_id_3EF92CFB93C67BC7)) {
    _id_977F24E61599CBBA = tablelookupgetnumrows(_id_3EF92CFB93C67BC7);

    for(_id_43F004CCE557F835 = 0; _id_43F004CCE557F835 < _id_977F24E61599CBBA; _id_43F004CCE557F835++) {
      type = tablelookupbyrow(_id_3EF92CFB93C67BC7, _id_43F004CCE557F835, 0);

      if(type == "prop") {
        modelname = tablelookupbyrow(_id_3EF92CFB93C67BC7, _id_43F004CCE557F835, 1);
        propsizetext = tablelookupbyrow(_id_3EF92CFB93C67BC7, _id_43F004CCE557F835, 2);
        offsetx = int(tablelookupbyrow(_id_3EF92CFB93C67BC7, _id_43F004CCE557F835, 3));
        offsety = int(tablelookupbyrow(_id_3EF92CFB93C67BC7, _id_43F004CCE557F835, 4));
        _id_2DEFF046A09A621C = int(tablelookupbyrow(_id_3EF92CFB93C67BC7, _id_43F004CCE557F835, 5));
        _id_6150EE186B6BD8F1 = int(tablelookupbyrow(_id_3EF92CFB93C67BC7, _id_43F004CCE557F835, 6));
        _id_6150ED186B6BD6BE = int(tablelookupbyrow(_id_3EF92CFB93C67BC7, _id_43F004CCE557F835, 7));
        _id_6150EC186B6BD48B = int(tablelookupbyrow(_id_3EF92CFB93C67BC7, _id_43F004CCE557F835, 8));
        propheight = tablelookupbyrow(_id_3EF92CFB93C67BC7, _id_43F004CCE557F835, 9);
        proprange = tablelookupbyrow(_id_3EF92CFB93C67BC7, _id_43F004CCE557F835, 10);
        location = tablelookupbyrow(_id_3EF92CFB93C67BC7, _id_43F004CCE557F835, 11);

        if(location == "")
          location = "any";

        offset = undefined;

        if(isDefined(offsetx) && isDefined(offsety) && isDefined(_id_2DEFF046A09A621C))
          offset = (offsetx, offsety, _id_2DEFF046A09A621C);

        rotation = undefined;

        if(isDefined(_id_6150EE186B6BD8F1) && isDefined(_id_6150ED186B6BD6BE) && isDefined(_id_6150EC186B6BD48B))
          rotation = (_id_6150EE186B6BD8F1, _id_6150ED186B6BD6BE, _id_6150EC186B6BD48B);

        propsize = getpropsize(propsizetext);

        if(!isDefined(propheight) || propheight == "")
          propheight = getthirdpersonheightoffsetforsize(propsize);
        else
          propheight = int(propheight);

        if(!isDefined(proprange) || proprange == "")
          proprange = getthirdpersonrangeforsize(propsize);
        else
          proprange = int(proprange);

        addproptolist(modelname, propsize, offset, rotation, propsizetext, propheight, proprange, location);
        continue;
      }

      if(type == "loc") {
        location = tablelookupbyrow(_id_3EF92CFB93C67BC7, _id_43F004CCE557F835, 11);
        _id_F170FD5DC0D73B90 = int(tablelookupbyrow(_id_3EF92CFB93C67BC7, _id_43F004CCE557F835, 12));
        _id_FE8A571070DDCCC9 = int(tablelookupbyrow(_id_3EF92CFB93C67BC7, _id_43F004CCE557F835, 13));
        radius = int(tablelookupbyrow(_id_3EF92CFB93C67BC7, _id_43F004CCE557F835, 14));
        initlocationcircle(location, _id_F170FD5DC0D73B90, _id_FE8A571070DDCCC9, radius);
        continue;
      }
    }
  }

  if(_id_977F24E61599CBBA == 0)
    addproptolist("tag_origin", 250, (0, 0, 0), (0, 0, 0), "medium", getthirdpersonheightoffsetforsize(250), getthirdpersonrangeforsize(250), "any");

  organizeproplist();
}

setupprop() {
  propinfo = self.propinfo;

  if(!isDefined(propinfo))
    propinfo = getnextprop(self);

  self.propanchor = spawn("script_model", self.origin);
  self.propanchor.targetname = "propAnchor";
  self.propanchor linkTo(self);
  self.propent = spawn("script_model", self.origin);
  self.propent setModel("generic_prop_raven_x3");
  self.propent.targetname = "propEnt";
  self.propent linkTo(self.propanchor);
  self.prop = spawn("script_model", self.propent.origin);
  self.prop.targetname = "prop";
  self.prop setModel(propinfo.modelname);
  self.prop setCanDamage(1);
  self.prop.xyzoffset = propinfo.xyzoffset;
  self.prop.anglesoffset = propinfo.anglesoffset;
  self.prop.angles = self.angles;
  applyxyzoffset();
  applyanglesoffset();
  self.prop linkTo(self.propent, "J_prop_1");
  self.prop.owner = self;
  self.prop.health = 10000;
  self.propent scriptmodelplayanim("prop_hunt_prop_spin", "propSpinAnim", undefined, 1.5);
  self.propent scriptmodelpauseanim(1);
  self.thirdpersonrange = propinfo.proprange;
  self.thirdpersonheightoffset = propinfo.propheight;
  self setcamerathirdperson(1, self.thirdpersonrange, self.thirdpersonheightoffset);
  playersetispropgameextrainfo(1);
  self.prop.info = propinfo;
  self.propinfo = propinfo;

  if(!isDefined(self.spawnedonce))
    self.usedprops = [];

  self.maxhealth = getprophealth(propinfo);
  self.health = self.maxhealth;
}

playersetispropgameextrainfo(value) {}

getprophealth(propinfo) {
  return int(propinfo.propsize);
}

getpropsize(propsizetext) {
  propsize = 0;

  switch (propsizetext) {
    case "xsmall":
      propsize = 50;
      break;
    case "small":
      propsize = 100;
      break;
    case "medium":
      propsize = 250;
      break;
    case "large":
      propsize = 450;
      break;
    case "xlarge":
      propsize = 550;
      break;
    default:
      mapname = scripts\cp_mp\utility\game_utility::getmapname();
      _id_3EF92CFB93C67BC7 = "mp/" + mapname + "_ph.csv";
      propsize = 100;
      break;
  }

  return propsize;
}

addproptolist(modelname, propsize, xyzoffset, anglesoffset, propsizetext, propheight, proprange, location) {
  if(!isDefined(level.ph.proplist[location]))
    level.ph.proplist[location] = [];

  if(!isDefined(level.ph.proplist[location][propsize]))
    level.ph.proplist[location][propsize] = [];

  propinfo = spawnStruct();
  propinfo.modelname = modelname;
  propinfo.propsize = int(propsize);
  propinfo.propsizetext = propsizetext;
  propinfo.location = location;

  if(isDefined(xyzoffset))
    propinfo.xyzoffset = xyzoffset;

  if(isDefined(anglesoffset))
    propinfo.anglesoffset = anglesoffset;

  propinfo.proprange = proprange;
  propinfo.propheight = propheight;
  _id_94E49A1D99BFD258 = level.ph.proplist[location][propsize].size;
  level.ph.proplist[location][propsize][_id_94E49A1D99BFD258] = propinfo;
}

ph_endgame(_id_EC15CE3E7A9D1D86, _id_F0500919D8C387B9) {
  if(istrue(level.endingph)) {
    return;
  }
  level.endingph = 1;
  ph_setfinalkillcamwinner(_id_EC15CE3E7A9D1D86);
  thread scripts\mp\gamelogic::endgame(_id_EC15CE3E7A9D1D86, _id_F0500919D8C387B9);
  level thread givephteamscore(_id_EC15CE3E7A9D1D86);
}

ph_setfinalkillcamwinner(_id_EC15CE3E7A9D1D86) {
  level.finalkillcam_winner = _id_EC15CE3E7A9D1D86;

  if(level.finalkillcam_winner == game["defenders"])
    level.skipfinalkillcamfx = 1;
}

givephteamscore(team) {
  level endon("game_ended");
  _id_9126D9430AEDDFEC = game["roundsWon"][team] + 1;
  setteamscore(team, _id_9126D9430AEDDFEC);
}

setphteamscores() {
  level endon("game_ended");
  _id_EDFAE24780398CF7 = game["roundsWon"][game["defenders"]];
  _id_F29BF0620577C49F = game["roundsWon"][game["attackers"]];
  setteamscore(game["defenders"], _id_EDFAE24780398CF7);
  setteamscore(game["attackers"], _id_F29BF0620577C49F);
}

ononeleftevent(team) {
  if(istrue(level.gameended)) {
    return;
  }
  if(team == game["attackers"]) {
    return;
  }
  _id_B0DFD912BE32D040 = undefined;

  foreach(player in level.players) {
    if(isDefined(team) && player.team != team) {
      continue;
    }
    if(!scripts\cp_mp\utility\player_utility::isreallyalive(player) && !player scripts\mp\playerlogic::mayspawn()) {
      continue;
    }
    if(isDefined(_id_B0DFD912BE32D040)) {
      return;
    }
    _id_B0DFD912BE32D040 = player;
  }

  if(!isDefined(_id_B0DFD912BE32D040)) {
    return;
  }
  _id_B0DFD912BE32D040 thread givelastonteamwarning();
}

givelastonteamwarning() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\cp_mp\utility\player_utility::waittillrecoveredhealth(3);
  otherteam = scripts\mp\utility\game::getotherteam(self.pers["team"]);
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastenemyalive", self, otherteam);

  if(playerisprop()) {
    level notify("noPropsToSpectate");
    level.nopropsspectate = 1;
  }

  level notify("last_alive", self);
}

ontimelimit() {
  if(!istrue(level.gameending)) {
    _id_3B5803E733581858 = scripts\mp\utility\game::gettimepassed();
    game["propSurvivalTime"][game["defenders"]] = game["propSurvivalTime"][game["defenders"]] + _id_3B5803E733581858;
    game["hunterKillTime"][game["attackers"]] = game["hunterKillTime"][game["attackers"]] + _id_3B5803E733581858;
    choosefinalkillcam();
    ph_endgame(game["defenders"], game["end_reason"]["time_limit_reached"]);
  }
}

choosefinalkillcam() {
  _id_AFCD266A00D815AA = getlivingplayersonteam(game["defenders"]);

  if(_id_AFCD266A00D815AA.size < 1) {
    return;
  }
  _id_98F98F1BC6B2F353 = getlivingplayersonteam(game["attackers"]);

  if(_id_98F98F1BC6B2F353.size < 1) {
    return;
  }
  _id_1FE42ED83529B4D5 = choosebestpropforkillcam(_id_AFCD266A00D815AA, _id_98F98F1BC6B2F353);

  if(scripts\cp_mp\utility\game_utility::isgameparticipant(_id_1FE42ED83529B4D5))
    attackernum = _id_1FE42ED83529B4D5 getentitynumber();
  else
    attackernum = -1;

  victim = _id_98F98F1BC6B2F353[0];
  victim.deathtime = gettime() - 1000;
  scripts\mp\final_killcam::recordfinalkillcam(5.0, victim, _id_1FE42ED83529B4D5, attackernum, -1, 0, "none", 0, 0, "none", "normal", 0);
}

choosebestpropforkillcam(_id_AFCD266A00D815AA, _id_98F98F1BC6B2F353) {
  _id_E68C03716992D57E = undefined;
  _id_EA5C6284AB19C2C5 = 1073741824;

  foreach(prop in _id_AFCD266A00D815AA) {
    _id_867B4B27436CF35E = undefined;
    _id_38A356FF022A6F14 = 1073741824;

    foreach(_id_A9FF06560DA3D11F in _id_98F98F1BC6B2F353) {
      pathdist = getpathdist(prop.origin, _id_A9FF06560DA3D11F.origin, 999999);

      if(pathdist < _id_38A356FF022A6F14) {
        _id_38A356FF022A6F14 = pathdist;
        _id_867B4B27436CF35E = _id_A9FF06560DA3D11F;
      }
    }

    if(_id_38A356FF022A6F14 < _id_EA5C6284AB19C2C5) {
      _id_EA5C6284AB19C2C5 = _id_38A356FF022A6F14;
      _id_E68C03716992D57E = prop;
    }
  }

  if(!isDefined(_id_E68C03716992D57E))
    _id_E68C03716992D57E = scripts\engine\utility::random(_id_AFCD266A00D815AA);

  return _id_E68C03716992D57E;
}

ph_checkforovertime() {
  if(game["roundsWon"]["allies"] == scripts\mp\utility\dvars::getwatcheddvar("winlimit") - 1 && game["roundsWon"]["axis"] == scripts\mp\utility\dvars::getwatcheddvar("winlimit") - 1)
    return 1;

  return 0;
}

playerhunterpostloadout() {
  scripts\mp\equipment::incrementequipmentammo("equip_concussion");
  scripts\mp\class::loadout_removeperk("specialty_selectivehearing");
}

givecustomloadout() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self waittill("giveLoadout");

  if(!istrue(self.gulag))
    playerhunterpostloadout();

  self.thirdpersonrange = undefined;
  self setcamerathirdperson(0, 0);
  playersetispropgameextrainfo(0);
  self allowprone(1);
  self allowsprint(1);
  scripts\mp\weapons::updatemovespeedscale();
  self enableweaponpickup();
  scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
  scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("br_gametype_prop::giveCustomLoadout()");
  self.concussionimmune = 1;
  attackerinitammo();
  thread attackerregenammo();
}

stillalivexp() {
  level endon("game_ended");
  level.scoreinfo["kill"]["value"] = 300;
  scripts\mp\flags::gameflagwait("props_hide_over");

  for(;;) {
    wait 10;

    foreach(player in level.players) {
      if(!isDefined(player.team)) {
        continue;
      }
      if(!player playerisprop()) {
        continue;
      }
      if(!scripts\cp_mp\utility\player_utility::isreallyalive(player)) {
        continue;
      }
      player thread giveawardfake("stat_2C1EE48B7E3AA323");

      switch (player.prop.info.propsize) {
        case 250:
          player thread giveawardfake("stat_21351FB706B51643");
          break;
        case 450:
          player thread giveawardfake("stat_9EC4C165E5D5575B");
          break;
        case 550:
          player thread giveawardfake("stat_128C8E05D92EAD1A");
          break;
        default:
          break;
      }
    }
  }
}

tracktimealive() {
  level endon("game_ended");
  waittillhuntersdrop();

  for(;;) {
    foreach(player in level.players) {
      if(!isDefined(player.team)) {
        continue;
      }
      if(player.team == game["attackers"]) {
        continue;
      }
      if(!scripts\cp_mp\utility\player_utility::isreallyalive(player)) {
        continue;
      }
      if(isDefined(player.pers["propSeconds"]))
        player.pers["propSeconds"]++;
    }

    wait 1;
  }
}

gamemodemodifyplayerdamage(damagedata) {
  idamage = damagedata.damage;

  if(istrue(self.propspectating)) {
    self notify("endPropSpectate");

    if(damagedata.meansofdeath == "MOD_TRIGGER_HURT")
      return 0;
  }

  if(isDefined(damagedata.victim.team)) {
    if(damagedata.victim playerisprop())
      idamage = modifydamagetoprop(damagedata);
    else
      idamage = modifydamagetohunter(damagedata);

    if(idamage == 0)
      return 0;
  }

  if(isDefined(damagedata.attacker) && isPlayer(damagedata.attacker) && isalive(damagedata.attacker)) {
    if(!isDefined(damagedata.attacker.hashitplayer))
      damagedata.attacker.hashitplayer = 1;

    if(level.matchrules_damagemultiplier)
      idamage = idamage * level.matchrules_damagemultiplier;

    if(level.matchrules_vampirism)
      damagedata.attacker.health = int(min(float(damagedata.attacker.maxhealth), float(damagedata.attacker.health + 20)));
  }

  return idamage;
}

modifydamagetoprop(damagedata) {
  if(isDefined(damagedata.meansofdeath) && damagedata.meansofdeath == "MOD_FALLING")
    return 0;

  return damagedata.damage;
}

modifydamagetohunter(damagedata) {
  if(isDefined(damagedata.meansofdeath) && damagedata.meansofdeath == "MOD_FALLING")
    return 0;

  if(damagedata.objweapon.basename == "concussion_grenade_mp")
    return 0;

  if(issubstr(damagedata.objweapon.basename, "destructible"))
    return 0;

  return damagedata.damage;
}

attackerinitammo() {
  primaryweapons = self getweaponslistprimaries();

  foreach(weapon in primaryweapons)
  self givemaxammo(weapon);

  _id_5A1C0736D318AF97 = self getweaponammostock("concussion_grenade_mp");
  _id_5A1C0736D318AF97 = _id_5A1C0736D318AF97 - self.thrownspecialcount;
  _id_5A1C0736D318AF97 = int(max(_id_5A1C0736D318AF97, 0));
  self setweaponammostock("concussion_grenade_mp", _id_5A1C0736D318AF97);

  if(_id_5A1C0736D318AF97 > 0)
    thread _id_5B1AF0B4DB421B9D::watchspecialgrenadethrow();
}

attackerregenammo() {
  self endon("death_or_disconnect");
  self notify("attackerRegenAmmo");
  self endon("attackerRegenAmmo");
  level endon("game_ended");

  for(;;) {
    self waittill("reload");
    primaryweapon = self getcurrentprimaryweapon();
    maxammo = weaponmaxammo(primaryweapon);

    if(self getweaponammostock(primaryweapon) < maxammo)
      self setweaponammostock(primaryweapon, maxammo);
  }
}

checkkillrespawn() {
  self endon("disconnect");
  level endon("game_ended");
  wait 0.1;

  if(self.pers["lives"] == 1) {
    self.pers["lives"]--;
    level.livescount[self.team]--;
    scripts\mp\gamelogic::updategameevents();
    level notify("propCountChanged");
    return;
  }
}

playerswapteam() {
  _id_EB06B338608EF354 = game["attackers"];

  if(self.team == game["attackers"])
    _id_EB06B338608EF354 = game["defenders"];

  scripts\mp\menus::addtoteam(_id_EB06B338608EF354);
}

onplayerkilled(damagedata) {
  _id_F5F021C1642A1807 = 0;
  level notify("playerCountChanged");

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    playerswapteam();
    return;
  }

  if(!damagedata.victim playerisprop())
    thread respawnplayer();
  else if(!scripts\mp\flags::gameflag("props_hide_over")) {
    thread respawnplayer();
    return;
  }

  if(isDefined(damagedata.attacker) && isPlayer(damagedata.attacker) && damagedata.attacker != damagedata.victim && damagedata.victim.team != damagedata.attacker.team)
    _id_F5F021C1642A1807 = 1;

  if(_id_F5F021C1642A1807)
    damagedata.attacker thread playerfakesplash("prop_finalblow");

  foreach(player in level.players) {
    if(istrue(player.propspectating) && isDefined(player.spectatingthisplayer) && damagedata.victim == player.spectatingthisplayer)
      player notify("endPropSpectate");

    if(player != damagedata.attacker && player playerisprop() && isalive(player) && damagedata.victim playerisprop())
      player thread playerfakesplash("prop_survived");
  }
}

playerfakesplash(_id_F7B6CC6C062A7A43) {
  _id_195FB71001F87BC5 = undefined;

  switch (_id_F7B6CC6C062A7A43) {
    case "still_alive":
      _id_195FB71001F87BC5 = &"SPLASHES_PH/SCORE_STILL_ALIVE";
      break;
    case "still_alive_medium_bonus":
      _id_195FB71001F87BC5 = &"SPLASHES_PH/SCORE_STILL_ALIVE_MED_BONUS";
      break;
    case "still_alive_large_bonus":
      _id_195FB71001F87BC5 = &"SPLASHES_PH/SCORE_STILL_ALIVE_LARGE_BONUS";
      break;
    case "still_alive_extra_large_bonus":
      _id_195FB71001F87BC5 = &"SPLASHES_PH/SCORE_STILL_ALIVE_EXTRA_LARGE_BONUS";
      break;
    case "clone_destroyed":
      _id_195FB71001F87BC5 = &"SPLASHES_PH/SCORE_DECOY_KILLED";
      break;
    case "clone_was_destroyed":
      _id_195FB71001F87BC5 = &"SPLASHES_PH/SCORE_DECOY_WAS_KILLED";
      break;
    case "prop_finalblow":
      _id_195FB71001F87BC5 = &"SPLASHES_PH/PROP_FINALBLOW";
      break;
    case "prop_survived":
      _id_195FB71001F87BC5 = &"SPLASHES_PH/PROP_SURVIVED";
      break;
    default:
      return;
  }

  self iprintlnbold(_id_195FB71001F87BC5);
}

respawnplayer() {
  thread waitillcanspawnclient();
}

waitillcanspawnclient() {
  self endon("started_spawnPlayer");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    wait 0.05;

    if(isDefined(self) && (self.sessionstate == "spectator" || !scripts\cp_mp\utility\player_utility::isreallyalive(self))) {
      self.pers["lives"] = 1;
      scripts\mp\playerlogic::spawnclient();
      continue;
    }

    return;
  }
}

ondeadevent(team) {
  if(team == game["defenders"])
    level thread propkilledend();
}

onplayerjointeam(player) {
  if(level.teambased)
    player _id_1E4A61DB11011446::setplayersquadindex(1);

  if(!player playerisprop()) {
    if(isDefined(player.proplocationindex))
      player propremovefromlocation();
    else if(isDefined(player.propcircleindex))
      player propremovefromcircle();
  }
}

propkilledend() {
  if(istrue(level.hunterswonending)) {
    return;
  }
  if(istrue(level.gameending)) {
    return;
  }
  level.hunterswonending = 1;
  _id_3B5803E733581858 = scripts\mp\utility\game::gettimepassed();
  game["propSurvivalTime"][game["defenders"]] = game["propSurvivalTime"][game["defenders"]] + _id_3B5803E733581858;
  game["hunterKillTime"][game["attackers"]] = game["hunterKillTime"][game["attackers"]] + _id_3B5803E733581858;
  level.gameending = 1;
  wait 3;
  thread ph_endgame(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
}

playdeathsoundph(victim, meansofdeath, inflictor) {
  if(meansofdeath == "MOD_EXECUTION") {
    return;
  }
  if(playerisprop()) {
    return;
  }
  _id_00AE14C5A8B1B582 = randomintrange(1, 8);
  type = "generic";

  if(scripts\cp_mp\utility\player_utility::isfemale())
    type = "female";

  if(meansofdeath == "MOD_FALLING" || meansofdeath == "MOD_SUICIDE" && isPlayer(self)) {
    if(self.team == "axis")
      scripts\cp_mp\utility\player_utility::playplayerandnpcsounds(self, "plr_death_explosion", type + "_death_russian_" + _id_00AE14C5A8B1B582);
    else
      scripts\cp_mp\utility\player_utility::playplayerandnpcsounds(self, "plr_death_explosion", type + "_death_american_" + _id_00AE14C5A8B1B582);
  } else if(isPlayer(self)) {
    if(self.team == "axis")
      scripts\cp_mp\utility\player_utility::playplayerandnpcsounds(self, "plr_death_generic", type + "_death_russian_" + _id_00AE14C5A8B1B582);
    else
      scripts\cp_mp\utility\player_utility::playplayerandnpcsounds(self, "plr_death_generic", type + "_death_american_" + _id_00AE14C5A8B1B582);
  } else if(self.team == "axis")
    self playSound(type + "_death_russian_" + _id_00AE14C5A8B1B582);
  else
    self playSound(type + "_death_american_" + _id_00AE14C5A8B1B582);
}

gametyperoundendscoresetomnvar(winner, _id_83C9459B644DC44F, _id_F0500919D8C387B9, _id_724203E355A3B999, team) {
  if(istrue(_id_724203E355A3B999) && isDefined(level.proptiebreaker)) {
    if(level.proptiebreaker == "kills") {
      self setclientomnvar("ui_round_end_reason", game["end_reason"]["prop_tiebreaker_kills"]);
      self setclientomnvar("ui_round_end_friendly_score", game["propScore"][team]);
      self setclientomnvar("ui_round_end_enemy_score", game["propScore"][level.otherteam[team]]);
    } else if(level.proptiebreaker == "time") {
      _id_653C01DE2D4B9BAD = game["hunterKillTime"][team] / 1000;
      _id_01A63A2F4254D6ED = game["hunterKillTime"][level.otherteam[team]] / 1000;
      _id_EB05C69461F1CC52 = int(scripts\engine\math::round_float(_id_653C01DE2D4B9BAD));
      _id_CEDF38A5227E6C92 = int(scripts\engine\math::round_float(_id_01A63A2F4254D6ED));

      if(_id_EB05C69461F1CC52 == _id_CEDF38A5227E6C92) {
        if(_id_653C01DE2D4B9BAD > _id_01A63A2F4254D6ED)
          _id_EB05C69461F1CC52++;
        else
          _id_CEDF38A5227E6C92++;
      }

      self setclientomnvar("ui_round_end_reason", game["end_reason"]["prop_tiebreaker_time"]);
      self setclientomnvar("ui_round_end_friendly_score", _id_EB05C69461F1CC52);
      self setclientomnvar("ui_round_end_enemy_score", _id_CEDF38A5227E6C92);
    }

    return 1;
  }

  return 0;
}

playerwatchspectate() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    msg = scripts\engine\utility::waittill_any_return_3("joined_spectators", "spectating_cycle", "death");

    if(msg == "death") {
      continue;
    }
    waittillframeend;
    _id_28493EC3B9D0BBEF = self getspectatingplayer();

    if(!isDefined(_id_28493EC3B9D0BBEF))
      continue;
  }
}

highlighttoteamonce(team, color, _id_DF1B054C1838D0DE, _id_CAE2F25FB463C45D) {
  if(!isDefined(_id_CAE2F25FB463C45D))
    _id_CAE2F25FB463C45D = 1;

  self hudoutlinedisable();

  foreach(player in level.players) {
    if(isDefined(_id_DF1B054C1838D0DE) && _id_DF1B054C1838D0DE == player) {
      continue;
    }
    _id_56F2275B04FBA40E = player.sessionstate == "spectator";

    if(player.team == team && !_id_56F2275B04FBA40E)
      self hudoutlineenableforclient(player, color);

    if(_id_CAE2F25FB463C45D && (player.team == "spectator" || _id_56F2275B04FBA40E))
      self hudoutlineenableforclient(player, color);
  }
}

highlighttoteam(team, color, _id_DF1B054C1838D0DE, _id_CAE2F25FB463C45D) {
  self notify("showToTeam");
  self endon("showToTeam");
  self endon("clear");
  self endon("death");
  self endon("maxDelete");

  if(!isDefined(_id_CAE2F25FB463C45D))
    _id_CAE2F25FB463C45D = 1;

  highlighttoteamonce(team, color, _id_DF1B054C1838D0DE, _id_CAE2F25FB463C45D);

  for(;;) {
    level waittill("add_to_team");
    highlighttoteamonce(team, color, _id_DF1B054C1838D0DE, _id_CAE2F25FB463C45D);
  }
}

checkunscoredspawnpoint(spawnpoint) {
  foreach(player in level.players) {
    if(player playerisprop()) {
      if(isDefined(player.spawninfo) && isDefined(player.spawninfo.spawnpoint) && player.spawninfo.spawnpoint == spawnpoint)
        return 0;
    }
  }

  return 1;
}

disablespawningforplayer(player) {
  if(scripts\mp\flags::gameflag("prematch_done"))
    return 0;

  if(!scripts\mp\utility\game::gamehasstarted())
    return 0;

  if(player playerisprop())
    return !level.ingraceperiod;

  return 0;
}

playerisprop() {
  return isDefined(self.team) && self.team == game["defenders"];
}

playerskiplootpickup(instance, _id_B2635DB617B09ABD) {
  return playerisprop() || level.infilcinematicactive;
}

giveawardfake(event) {
  xp = scripts\mp\rank::_id_D06C3CBB904AE29B(event);
  scripts\mp\rank::giverankxp(event, xp);
  scripts\mp\utility\points::giveunifiedpoints(event, undefined, undefined, -1);

  if(isDefined(self.awardsthislife[event]))
    self.awardsthislife[event]++;
  else
    self.awardsthislife[event] = 1;

  playerfakesplash(event);
}

playerprespawngulagjail() {
  if(playerisprop())
    playerswapteam();
}

playernakeddroploadout() {
  phclass();
  self.prevweaponobj = undefined;
  struct = scripts\mp\class::loadout_getclassstruct();
  struct = scripts\mp\class::loadout_updateclass(struct, "gamemode");
  scripts\mp\class::preloadandqueueclassstruct(struct, 1, 1);
  self takeallweapons();
  scripts\mp\class::giveloadout(self.team, "gamemode", 1, 1);
  self givestartammo(struct.loadoutprimaryobject);
  self givestartammo(struct.loadoutsecondaryobject);
  _id_724736FCF0FB6604::br_ammo_player_clear();
  _id_724736FCF0FB6604::br_ammo_give_type(self, "brloot_ammo_762", 200, 0);
  _id_724736FCF0FB6604::br_ammo_update_weapons(self);
  self notify("ammo_update");
  playerhunterpostloadout();
}

vehicle_occupancy_mp_onentervehicle(vehicle, _id_7558F98F3236963D, player, data) {
  scripts\mp\vehicles\vehicle_occupancy_mp::vehicle_occupancy_mp_onentervehicle(vehicle, _id_7558F98F3236963D, player, data);

  if(player playerisprop())
    player setcamerathirdperson(0);
}

vehicle_occupancy_mp_onexitvehicle(vehicle, _id_FC7C7A874B43A31A, player, data) {
  scripts\mp\vehicles\vehicle_occupancy_mp::vehicle_occupancy_mp_onexitvehicle(vehicle, _id_FC7C7A874B43A31A, player, data);

  if(!istrue(data.playerdisconnect) && !istrue(data.playerdeath) && player playerisprop())
    player setcamerathirdperson(1, player.thirdpersonrange, player.thirdpersonheightoffset);
}

droponplayerdeath(attacker) {
  if(istrue(level.usegulag) && _id_2CEDCC356F1B9FC8::isplayeringulag())
    return 1;

  if(playerisprop())
    return 1;

  return 0;
}

getinfilplayers() {
  _id_CAB92D84EE489A10 = scripts\engine\utility::array_randomize(level.players);
  numhunters = level.ph.settings.numhunters;

  if(level.players.size < numhunters)
    numhunters = 1;

  count = 0;
  _id_7FAC5B3FFF459084 = [];
  _id_104F87CC51A1138D = [];

  foreach(player in _id_CAB92D84EE489A10) {
    if(count < numhunters)
      _id_7FAC5B3FFF459084[_id_7FAC5B3FFF459084.size] = player;
    else
      _id_104F87CC51A1138D[_id_104F87CC51A1138D.size] = player;

    count++;
  }

  thread setuphunters(_id_7FAC5B3FFF459084);
  thread setupprops(_id_104F87CC51A1138D);
  return _id_7FAC5B3FFF459084;
}

playerforcespawn() {
  self endon("disconnect");
  self notify("death_or_disconnect");
  self notify("death");
  waittillframeend;
  _id_7933519955F32C4E::c130forcespawnplayer();

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
    _id_16C2D930984F2FEF = self isreloading();

    if(_id_16C2D930984F2FEF) {
      _id_5814D27874B48E54 = spawnStruct();
      _id_5814D27874B48E54.player = self;
      _id_5814D27874B48E54._id_C739BA1EB6635B73 = getsystemtimeinmicroseconds();
      _id_5814D27874B48E54._id_C198F7CA473378FB = "DISCONNECT";
      _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_reload_cancel", _id_5814D27874B48E54);
    }
  }
}

setuphunters(players) {
  if(!istrue(level.br_infils_disabled)) {
    scripts\mp\flags::gameflagwait("prematch_fade_done");
    waitframe();
  }

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    if(player playerisprop()) {
      player playerswapteam();
      player phclass();
      player.forcespawnorigin = player.origin;
      player.forcespawnangles = player.angles;
      player thread playerforcespawn();
    }

    if(istrue(level.br_infils_disabled)) {
      player _id_724736FCF0FB6604::br_ammo_player_clear();
      player _id_724736FCF0FB6604::br_ammo_give_type(player, "brloot_ammo_762", 200, 0);
      _id_724736FCF0FB6604::br_ammo_update_weapons(player);
      player notify("ammo_update");
    }
  }
}

getpropnextstartlocation() {
  if(!isDefined(level.ph.settings.randomstartindex))
    level.ph.settings.randomstartindex = randomint(level.ph.locationcircles.size);
  else
    level.ph.settings.randomstartindex = (level.ph.settings.randomstartindex + 1) % level.ph.locationcircles.size;

  location = level.ph.locationcircles[level.ph.settings.randomstartindex];
  return location;
}

getpropspawnlocation(index, baseorigin) {
  _id_A9D5AD9414F5ECB7 = 10;
  _id_057716496F9F490F = 200.0;
  _id_E0CC897878C28778 = 100.0;
  _id_AC72A33C0ED48603 = 10.0;
  _id_3385F93167B49AA1 = 360.0 / _id_A9D5AD9414F5ECB7;
  ring = int(index / _id_A9D5AD9414F5ECB7);
  slot = index - ring * _id_A9D5AD9414F5ECB7;
  yaw = slot * _id_3385F93167B49AA1 + ring * _id_AC72A33C0ED48603;
  dist = _id_057716496F9F490F + ring * _id_E0CC897878C28778;
  angles = (0.0, yaw, 0.0);
  dir = anglesToForward(angles);
  origin = baseorigin + dir * dist;
  origin = getgroundposition(origin, 15, 12000, 12000);
  return origin;
}

playerteleportprop(origin) {
  self cancelmantle();
  self setOrigin(origin, 1);
}

waitandspawnprops(players) {
  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    player _id_0930A1E7BD882C1D::endprematchskydiving();

    if(!player playerisprop()) {
      player playerswapteam();
      player.forcespawnorigin = player.propspawnorigin;
      player thread playerforcespawn();
    } else if(!isalive(player)) {
      player.forcespawnorigin = player.propspawnorigin;
      player _id_7933519955F32C4E::c130forcespawnplayer();
    } else {
      player playerteleportprop(player.propspawnorigin);
      player.br_infilstarted = 1;
      player _id_5B1AF0B4DB421B9D::propchange(1);
      player _id_5B1AF0B4DB421B9D::propsetchangesleft(int(level.ph.settings.propchangecount));
      player _id_5B1AF0B4DB421B9D::setnewabilitycount(player.currentability);
      player _id_5B1AF0B4DB421B9D::setnewabilitycount("CLONE");
    }

    player notify("beginC130");
  }
}

setupprops(players) {
  startlocation = getpropnextstartlocation();
  index = 0;

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    player scripts\cp_mp\utility\player_utility::hidehudenable();
    spawnorigin = getpropspawnlocation(index, startlocation.origin);
    player.propspawnorigin = spawnorigin;
    index++;

    if(index >= level.ph.settings.numpropsperarea) {
      startlocation = getpropnextstartlocation();
      index = 0;
    }
  }

  fade_in_time = 1;
  _id_DC150B610C5D5CAC = 1.5;
  fade_out_time = 1;
  thread _id_7933519955F32C4E::infilallfadetoblack(fade_in_time, _id_DC150B610C5D5CAC, fade_out_time, "prop_respawn_finished", players, 1);

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    player _meth_BC667001F9DD3808(player.propspawnorigin);
  }

  wait(fade_in_time);
  waitframe();
  cleanupallclones();
  waitandspawnprops(players);
  level notify("prop_respawn_finished");
  wait(_id_DC150B610C5D5CAC);

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    player clearpredictedstreampos();
    player _id_0930A1E7BD882C1D::endprematchskydiving();

    if(_id_1E4A61DB11011446::get_int_or_0(player.hidehudenabled) > 0)
      player scripts\cp_mp\utility\player_utility::hidehuddisable();

    player.br_isininfil = 1;
  }

  scripts\mp\flags::gameflagset("props_hide_start");
}

initlocationcircle(location, _id_F170FD5DC0D73B90, _id_FE8A571070DDCCC9, radius) {
  _id_2998891B2242E102 = spawnStruct();
  _id_2998891B2242E102 scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Prop_Br", (_id_F170FD5DC0D73B90, _id_FE8A571070DDCCC9, 0), radius);
  _id_2998891B2242E102 scripts\cp_mp\utility\game_utility::_id_04EAF685BC40A3B9();
  _id_2998891B2242E102.inuse = 0;
  _id_2998891B2242E102.count = 0;
  _id_2998891B2242E102.name = location;
  _id_2998891B2242E102.radius = radius;
  _id_2998891B2242E102.radiussq = radius * radius;
  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  _id_2998891B2242E102.objectiveiconid = objectiveiconid;

  if(objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "active", (0, 0, 0), "ui_mp_br_compass_icon_quest_assassin");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 1);
    objective_showtoplayersinmask(objectiveiconid);
    scripts\mp\objidpoolmanager::update_objective_position(objectiveiconid, (_id_F170FD5DC0D73B90, _id_FE8A571070DDCCC9, 0));
  }

  level.ph.locationcircles[level.ph.locationcircles.size] = _id_2998891B2242E102;
}

initpropcircles() {
  level.ph.propcircles = [];
  _id_E50870C785A93BA7 = level.maxteamsize - level.ph.settings.numhunters;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E50870C785A93BA7; _id_AC0E594AC96AA3A8++) {
    level.ph.propcircles[_id_AC0E594AC96AA3A8] = spawnStruct();
    level.ph.propcircles[_id_AC0E594AC96AA3A8] scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Prop_Circle_Br", (0, 0, 0), 500);
    level.ph.propcircles[_id_AC0E594AC96AA3A8] scripts\cp_mp\utility\game_utility::_id_04EAF685BC40A3B9();
    level.ph.propcircles[_id_AC0E594AC96AA3A8].inuse = 0;
    level.ph.propcircles[_id_AC0E594AC96AA3A8].count = 0;
    level.ph.propcircles[_id_AC0E594AC96AA3A8].radius = 500;
    level.ph.propcircles[_id_AC0E594AC96AA3A8].radiussq = 250000;
  }
}

startpropcirclelogic() {
  _id_3E397ABBF061BFDD = game["defenders"];

  while(level.teamdata[_id_3E397ABBF061BFDD]["players"].size == 0)
    waitframe();

  for(;;) {
    proplist = level.teamdata[_id_3E397ABBF061BFDD]["players"];

    if(isDefined(level.ph.fakeprops))
      proplist = level.ph.fakeprops;

    foreach(player in proplist) {
      if(isDefined(player.proplocationindex)) {
        _id_2998891B2242E102 = level.ph.locationcircles[player.proplocationindex];
        distsq = distance2dsquared(_id_2998891B2242E102.origin, player.origin);

        if(distsq <= _id_2998891B2242E102.radiussq)
          continue;
        else
          player propremovefromlocation();
      } else if(isDefined(player.propcircleindex)) {
        _id_3B412A7D896E0020 = level.ph.propcircles[player.propcircleindex];
        distsq = distance2dsquared(_id_3B412A7D896E0020 scripts\cp_mp\utility\game_utility::_id_D9583306C5A171E4(), player.origin);

        if(distsq > _id_3B412A7D896E0020.radiussq)
          player propremovefromcircle();
      }

      _id_F87759503756F1E0 = undefined;
      _id_A52892DFFB2F5A53 = undefined;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.ph.locationcircles.size; _id_AC0E594AC96AA3A8++) {
        _id_2998891B2242E102 = level.ph.locationcircles[_id_AC0E594AC96AA3A8];
        distsq = distance2dsquared(_id_2998891B2242E102.origin, player.origin);

        if(distsq <= _id_2998891B2242E102.radiussq && (!isDefined(_id_A52892DFFB2F5A53) || distsq < _id_A52892DFFB2F5A53)) {
          _id_A52892DFFB2F5A53 = distsq;
          _id_F87759503756F1E0 = _id_AC0E594AC96AA3A8;
        }
      }

      if(isDefined(_id_F87759503756F1E0)) {
        if(isDefined(player.propcircleindex))
          player propremovefromcircle();

        player propaddtolocation(_id_F87759503756F1E0);
        continue;
      }

      if(!isDefined(player.propcircleindex))
        player propaddtocircle();
    }

    waitframe();
  }
}

propgetlocation() {
  if(isDefined(self.proplocationindex))
    return level.ph.locationcircles[self.proplocationindex].name;

  return "any";
}

propaddtolocation(index) {
  self.proplocationindex = index;
  _id_2998891B2242E102 = level.ph.locationcircles[index];
  _id_2998891B2242E102.count++;

  if(_id_2998891B2242E102.count == 1) {
    _id_2998891B2242E102.inuse = 1;
    _id_2998891B2242E102 scripts\cp_mp\utility\game_utility::_id_6988310081DE7B45();
    scripts\mp\objidpoolmanager::update_objective_ownerteam(_id_2998891B2242E102.objectiveiconid, game["defenders"]);
  }
}

propremovefromlocation() {
  index = self.proplocationindex;
  _id_2998891B2242E102 = level.ph.locationcircles[index];
  _id_2998891B2242E102.count--;

  if(_id_2998891B2242E102.count == 0) {
    _id_2998891B2242E102.inuse = 0;
    _id_2998891B2242E102 scripts\cp_mp\utility\game_utility::_id_04EAF685BC40A3B9();
    scripts\mp\objidpoolmanager::update_objective_ownerteam(_id_2998891B2242E102.objectiveiconid, undefined);
  }

  self.proplocationindex = undefined;
}

propaddtocircle() {
  index = getnextcircleindex();

  if(!isDefined(index)) {
    return;
  }
  self.propcircleindex = index;
  _id_3B412A7D896E0020 = level.ph.propcircles[index];
  _id_3B412A7D896E0020.count++;

  if(_id_3B412A7D896E0020.count == 1) {
    _id_3B412A7D896E0020.inuse = 1;
    _id_3B412A7D896E0020 scripts\cp_mp\utility\game_utility::_id_6988310081DE7B45();
    _id_3B412A7D896E0020.radiussq = 250000;
  }

  _id_337938150A4FA2F8 = (self.origin[0], self.origin[1], 500);
  _id_337938150A4FA2F8 = _id_337938150A4FA2F8 + scripts\engine\math::random_vector_2d() * randomfloatrange(0, 500);
  _id_3B412A7D896E0020 scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(_id_337938150A4FA2F8);
}

getnextcircleindex() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.ph.propcircles.size; _id_AC0E594AC96AA3A8++) {
    _id_3B412A7D896E0020 = level.ph.propcircles[_id_AC0E594AC96AA3A8];

    if(!_id_3B412A7D896E0020.inuse)
      return _id_AC0E594AC96AA3A8;
  }
}

propremovefromcircle() {
  index = self.propcircleindex;
  _id_3B412A7D896E0020 = level.ph.propcircles[index];
  _id_3B412A7D896E0020.count--;

  if(_id_3B412A7D896E0020.count == 0) {
    _id_3B412A7D896E0020.inuse = 0;
    _id_3B412A7D896E0020 scripts\cp_mp\utility\game_utility::_id_04EAF685BC40A3B9();
  }

  self.propcircleindex = undefined;
}