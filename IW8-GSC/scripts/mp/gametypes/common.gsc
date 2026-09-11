/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\common.gsc
***********************************************/

function setupcommoncallbacks() {
  level.onnormaldeath = &oncommonnormaldeath;
  level.onsuicidedeath = &oncommonsuicidedeath;
  level.onteamchangedeath = &oncommonteamchangedeath;

  if(isusingmatchrulesdata()) {
    setdynamicdvar("scr_game_gunGameWeapons", getmatchrulesdata("commonOption", "gunGameWeapons"));
  }

  level.set_systems_init_flag = getdvarint("scr_game_gunGameWeapons", 0);

  if(level.set_systems_init_flag > 0) {
    ref_131c1();
    setomnvar("ui_gamemode_override", 1);
    thread ref_1439c();
  }

  var_0 = undefined;

  if(getDvar("MOLPOSLOMO") == "arena") {
    var_1 = 0;

    if(isusingmatchrulesdata()) {
      var_1 = getmatchrulesdata("arenaData", "objModifier");
    } else {
      var_1 = scripts\mp\utility\dvars::dvarintvalue("objModifier", 0, 0, 2);
    }

    if(var_1 == 2) {
      var_0 = 1;
    }
  }

  level.maxtagsvisible = 0;
  var_2 = getdvarint("LTSNLQNRKO") && !getdvarint("LSTLQTSSRM");

  if(var_2) {
    level.maxtagsvisible = getdvarint("scr_game_soccerevent", 0);

    if(getDvar("NSQLTTMRMP") == "mp_m_stadium" && getdvarint("scr_stadium_soccerball", 1)) {
      level.maxtagsvisible = 1;
    }
  } else if(getDvar("NSQLTTMRMP") == "mp_m_stadium" && !dotournamentendgame() && !isgamebattlematch()) {
    level.maxtagsvisible = 1;
  }

  if(level.maxtagsvisible || istrue(var_0)) {
    ref_11962();
    level.ref_1326e = &ref_1326e;
    level thread[[level.ref_1326e]]();
    level thread scripts\mp\utility\entity::global_physics_sound_monitor();

    if(getdvarint("scr_game_soccergoal", 1) == 1) {
      ref_13237();
      ref_13471(level);

      if(getdvarint("scr_game_soccermultiball", 3) > 0) {
        if(!isDefined(game["multiBall"])) {
          game["multiBall"] = 0;
        }
      }
    }
  } else {
    level.maxtagsvisible = undefined;
  }

  if(getdvarint("scr_game_specialEventObjs", 0) == 1) {
    level.select_stairway_spawners["gos_fireworks"] = loadfx("vfx/iw8_mp/gamemode/vfx_gos_firework.vfx");
    level.playinggulagbink = 1;
  }

  var_3 = scripts\mp\utility\game::matchmakinggame() && scripts\mp\utility\game::usequesttimer();

  if(var_3) {
    level.setplayerselfrevivingextrainfo = 1;
    level.spawnoffsettacinsertmax["vanish_hw_fr"] = loadfx("vfx/iw8_mp/gamemode/vfx_halloween_kc_capture_friendly.vfx");
    level.spawnoffsettacinsertmax["vanish_hw_en"] = loadfx("vfx/iw8_mp/gamemode/vfx_halloween_kc_capture_enemy.vfx");
    level.spawnoffsettacinsertmax["ghostcat_hw"] = loadfx("vfx/iw8_br/gameplay/hween/vfx_halloween_ghost_cat.vfx");
    level.spawnoffsettacinsertmax["bats_hw"] = loadfx("vfx/iw8_br/gameplay/hween/vfx_hween_bats.vfx");
    level.spawnoffsettacinsertmax["bats_fly_hw"] = loadfx("vfx/iw8_br/gameplay/hween/vfx_hween_bats_fly.vfx");
    level.spawnoffsettacinsertmax["blood_ceil_hw"] = loadfx("vfx/iw8_br/gameplay/hween/vfx_halloween_blood_ceiling_01.vfx");
    level.spawnoffsettacinsertmax["blood_floor_hw"] = loadfx("vfx/iw8_br/gameplay/hween/vfx_halloween_blood_floor_01.vfx");

    if(getdvarint("scr_player_event_models", 1) > 0) {
      var_4 = strtok(getDvar("scr_player_hwhead_killcount", "3 10"), " ");
      level.spawnoffsettacinsertmin = int(var_4[0]);
      level.spawnoutofboundstrigger = int(var_4[1]);
      level.ref_12070 = &ref_12070;
    }
  }

  level.ref_1368d = undefined;
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&onplayerjointeamcommon);
  scripts\mp\utility\game::registerdogtagsenableddvar(scripts\mp\utility\game::getgametype(), 0);
  level._effect["cranked_explode"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
}

function updatecommongametypedvars() {
  level.dogtagsenabled = scripts\mp\utility\dvars::dvarintvalue("dogtags", 0, 0, 1);
  level.showenemydeathloc = scripts\mp\utility\dvars::dvarintvalue("enemyDeathLoc", 0, 0, 3);

  if(level.dogtagsenabled) {
    scripts\mp\gametypes\obj_dogtag::init();
  }

  level.mpingamelootdrop = scripts\mp\utility\game::getgametype() == "hvt" || scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + scripts\mp\utility\game::getgametype() + "_inGameLoot", "scr_game_inGameLoot");

  if(level.mpingamelootdrop) {
    scripts\mp\gametypes\plunder::init();
    return;
  }
}

function oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0;

  if(scripts\mp\utility\game::isteamreviveenabled() && scripts\mp\flags::gameflag("prematch_done")) {
    level thread scripts\mp\teamrevive::spawnrevivetrigger(var_0, var_1, "new_trigger_spawned", var_3);
  }

  if(isbot(self) && isDefined(self.tutorial_lead_collected)) {
    self.tutorial_lead_collected = undefined;
  }

  if(istrue(level.flashpointactive)) {
    scripts\mp\flashpoint::flashpoint_processnewevent(var_1, var_0, gettime(), "kill_by_" + var_1.team);
  }

  var_7 = scripts\mp\utility\game::islaststandenabled() && istrue(var_0.ref_125b9);

  if(!var_7 && var_1.team != self.team) {
    var_8 = level.scoremod["death"] * -1;

    if(var_8 != 0) {
      if(level.teambased) {
        level scripts\mp\gamescore::giveteamscoreforobjective(var_0.pers["team"], var_8, 0);
      } else {
        var_1 scripts\mp\gamescore::giveplayerscore("kill", var_8);
      }
    }

    var_6 = level.scoremod["kill"];

    if(istrue(var_5)) {
      var_6 += level.scoremod["kskill"];
    }

    if(var_3 == "MOD_HEAD_SHOT") {
      var_6 += level.scoremod["headshot"];
    }

    if(level.dogtagsenabled && scripts\mp\flags::gameflag("prematch_done")) {
      level thread scripts\mp\gametypes\obj_dogtag::spawndogtags(var_0, var_1, "new_tag_spawned", var_3);
    }

    if(level.mpingamelootdrop) {
      level thread scripts\mp\gametypes\plunder::dropplayerstags(var_0, var_1);
    }
  }

  if(istrue(level.supportcranked)) {
    if(scripts\mp\utility\game::matchmakinggame() && isDefined(var_1.cranked)) {
      if(!var_7 && var_6 != 0) {
        var_6 += 1;
        var_1 thread scripts\mp\rank::scoreeventpopup("teamscore_notify_" + var_6);
      }
    }

    var_1 scripts\mp\cranked::oncranked(var_0, var_1, var_2);
  }

  if(var_6 != 0) {
    if(level.teambased) {
      level scripts\mp\gamescore::giveteamscoreforobjective(var_1.pers["team"], var_6, 0);
      return;
    }

    var_1 scripts\mp\gamescore::giveplayerscore("kill", var_6, var_0);
    return;
  }
}

function oncommonsuicidedeath(var_0) {
  if(istrue(level.supportcranked)) {
    var_0 scripts\mp\cranked::cleanupcrankedplayertimer();
  }

  if(isDefined(level.scoremod)) {
    var_1 = level.scoremod["death"] * -1;

    if(var_1 != 0) {
      if(level.teambased) {
        level scripts\mp\gamescore::giveteamscoreforobjective(var_0.pers["team"], var_1, 0);
      }
    }
  }

  if(scripts\mp\utility\game::isteamreviveenabled() && scripts\mp\flags::gameflag("prematch_done")) {
    if(level.teambased) {
      level thread scripts\mp\teamrevive::spawnrevivetrigger(var_0, var_0, "new_trigger_spawned", "MOD_SUICIDE");
    }
  }

  if(level.mpingamelootdrop) {
    level thread scripts\mp\gametypes\plunder::dropplayerstags(var_0, undefined);
  }

  if(isDefined(level.modeonsuicidedeath)) {
    [[level.modeonsuicidedeath]](var_0);
    return;
  }
}

function oncommonteamchangedeath(var_0) {
  if(istrue(level.supportcranked)) {
    var_0 scripts\mp\cranked::cleanupcrankedplayertimer();
  }

  if(isDefined(level.modeonteamchangedeath)) {
    [[level.modeonteamchangedeath]](var_0);
    return;
  }
}

function dogtagcommonallyonusecb(var_0) {}

function dogtagcommonenemyonusecb(var_0) {}

function onspawnplayercommon() {
  if(istrue(game["inLiveLobby"])) {
    var_0 = istrue(level.allowprematchdamage) && istrue(level.spawnprotectiontimer);
    thread managespawnprotection(var_0);
  } else if(istrue(level.spawnprotectiontimer)) {
    if(isDefined(level.ref_1368d)) {
      if([[level.ref_1368d]]()) {
        thread managespawnprotection(1);
      }
    } else {
      thread managespawnprotection(1);
    }
  }

  if(scripts\mp\utility\game::isteamreviveenabled()) {
    thread scripts\mp\teamrevive::updaterevivetriggerspawnposition();
  }

  if(istrue(level.disablesupersprint)) {
    self allowsupersprint(0);
  }

  if(istrue(level.loadout_updateammo)) {
    self allowmountside(0);
    self allowmounttop(0);
  }

  if(isDefined(level.modeonspawnplayer)) {
    [[level.modeonspawnplayer]]();
  } else {
    thread updatematchstatushintonspawncommon();
  }

  if(scripts\mp\utility\game::getgametypenumlives() != 0) {
    updatealiveomnvars();
  }

  if(istrue(game["practiceRound"])) {
    if(istrue(level.ref_1343f)) {
      thread ref_13440();
    } else {
      self sethudtutorialmessage("MP_INGAME_ONLY/PRACTICE_ROUND");
    }
  } else if(!isagent(self)) {
    self clearhudtutorialmessage();
  }

  if(istrue(level.set_systems_init_flag)) {
    thread ref_1438c();
  }

  if(istrue(level.setplayerselfrevivingextrainfo)) {
    self.spawnloot = 0;

    if(scripts\mp\flags::gameflag("prematch_done")) {
      thread ref_1439b();
    }

    if(getdvarint("scr_player_event_models", 1) == 2) {
      thread ref_136b2();
      return;
    }

    return;
  }
}

function nvghintnotify(var_0) {
  self endon("disconnect");
  self notify("nvg_spawn_tutorial");
  self endon("nvg_spawn_tutorial");
  var_1 = 1;
  jumpiftrue(isDefined(var_0)) LOC_00000025;
  var_0 = 0;

  for(;;) {
    if(var_1) {
      self waittill("giveLoadout");
    } else {
      self waittill("spawned");
    }

    if(var_0 < 2) {
      if(self usinggamepad()) {
        var_2 = 32;
      } else {
        var_2 = 33;
      }

      if(scripts\mp\flags::gameflag("infil_will_run") && !scripts\mp\flags::gameflag("prematch_done")) {
        level waittill("prematch_done");
        wait 5;
        scripts\mp\utility\lower_message::setlowermessageomnvar(var_2);
        wait 5;
        scripts\mp\utility\lower_message::setlowermessageomnvar(0);
      } else {
        if(!var_0) {
          wait 5;
        }

        scripts\mp\utility\lower_message::setlowermessageomnvar(var_2);
        wait 5;
        scripts\mp\utility\lower_message::setlowermessageomnvar(0);
      }

      var_0++;
      continue;
    }

    break;
  }
}

function onplayerkilledcommon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(scripts\mp\utility\game::getgametypenumlives() != 0) {
    updatealiveomnvars();
  }

  if(scripts\mp\utility\game::islaststandenabled() && istrue(self.inlaststand) && scripts\mp\utility\game::getgametype() != "br") {
    oncommonnormaldeath(self, var_1, var_9, var_3, var_4, var_10);
  }

  if(isDefined(level.onplayerkilled)) {
    [[level.onplayerkilled]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  if(isDefined(level.ref_12037)) {
    [[level.ref_12037]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  if(isDefined(level.ref_12070)) {
    [[level.ref_12070]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    return;
  }
}

function onplayerconnectcommon() {
  for(;;) {
    level waittill("connected", var_0);

    if(isDefined(level.onplayerconnect)) {
      level thread[[level.onplayerconnect]](var_0);
    }

    if(scripts\cp_mp\utility\game_utility::isnightmap()) {
      thread nvghintnotify();
    }

    var_0 setclientdvar("QTSPTNLOL", 65);
    var_0 setclientdvar("LTMOQONPQ", 0);

    if(level.set_systems_init_flag > 0) {
      var_0.pers["class"] = "custgamemode";
      var_0.pers["gamemodeLoadout"] = level.gun_loadouts["axis"];

      if(!isDefined(var_0.pers["gunGameGunIndex"])) {
        var_0.pers["gunGameGunIndex"] = 0;
        var_0.gungamegunindex = 0;
      } else {
        var_0.gungamegunindex = var_0.pers["gunGameGunIndex"];
      }

      if(!isDefined(var_0.pers["gunGamePrevGunIndex"])) {
        var_0.pers["gunGamePrevGunIndex"] = 0;
        var_0.gungameprevgunindex = 0;
      } else {
        var_0.gungameprevgunindex = var_0.pers["gunGamePrevGunIndex"];
      }

      scripts\mp\flags::gameflagwait("gungame_set");
      var_0 thread scripts\mp\gametypes\gun::keepweaponsloaded();
    }
  }
}

function onplayerdisconnectcommon(var_0) {
  if(scripts\mp\utility\game::getgametypenumlives() != 0) {
    updatealiveomnvars(var_0);
  }

  if(isDefined(level.onplayerdisconnect)) {
    var_0 thread[[level.onplayerdisconnect]](var_0);
    return;
  }
}

function onplayerjointeamcommon(var_0) {
  if(isDefined(level.onplayerjointeam)) {
    [[level.onplayerjointeam]](self);
  }

  if(istrue(level.dogtagsenabled)) {
    scripts\mp\gametypes\obj_dogtag::onplayerjoinedteam(var_0);
  }

  if(istrue(level.usezonecapture)) {
    scripts\mp\gametypes\obj_zonecapture::onplayerjoinedteam(var_0);
  }

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    thread nvghintnotify(var_0);
    return;
  }
}

function managespawnprotection(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("remove_spawn_protection");
  thread applyspawnprotection();

  if(!istrue(level.allowprematchdamage)) {
    scripts\mp\flags::gameflagwait("prematch_done");
  }

  if(var_0) {
    wait level.spawnprotectiontimer;
  }

  thread removespawnprotection();
}

function applyspawnprotection() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("remove_spawn_protection");
  self waittill("spawned_player");
  self.spawnprotection = 1;
  scripts\mp\lightarmor::setlightarmorvalue(self, 1000, undefined, 0);
}

function removespawnprotection() {
  self endon("disconnect");

  if(isDefined(self)) {
    self.spawnprotection = 0;
  }

  scripts\mp\lightarmor::lightarmor_unset(self);
  self notify("remove_spawn_protection");
}

function updatealiveomnvars() {
  if(scripts\mp\utility\game::getgametype() == "br") {
    var_0 = 0;

    foreach(var_2 in level.teamnamelist) {
      var_0 += scripts\mp\utility\teams::getteamdata(var_2, "aliveCount");
    }

    setomnvar("ui_allies_alive", 0);
    setomnvar("ui_axis_alive", var_0);
    return;
  }

  setomnvar("ui_allies_alive", scripts\mp\utility\teams::getteamdata("allies", "aliveCount"));
  setomnvar("ui_axis_alive", scripts\mp\utility\teams::getteamdata("axis", "aliveCount"));
}

function updatematchstatushintonspawncommon() {
  level endon("game_ended");
  self setclientomnvar("ui_match_status_hint_text", 0);
}

function ffmessageonspawn() {
  wait 1;

  if(isDefined(self)) {
    scripts\mp\hud_message::showerrormessage("MP/FRIENDLY_FIRE_WILL_NOT");
    return;
  }
}

function ref_13440() {
  self endon("death");

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    thread scripts\mp\utility\print::tutorialprint("MP_INGAME_ONLY/PRACTICE_ROUND", 5);
    wait 6;
    scripts\mp\flags::gameflagwait("prematch_done");
    thread scripts\mp\utility\print::tutorialprint("MP_INGAME_ONLY/SNOWBALL_FIGHT", 5);
    return;
  }

  thread scripts\mp\utility\print::tutorialprint("MP_INGAME_ONLY/SNOWBALL_FIGHT", 5);
}

function bearsred() {
  game["dialog"]["specialty_warhead"] = "perk_amped";
  game["dialog"]["specialty_tac_resist"] = "perk_amped";
  game["dialog"]["specialty_covert_ops"] = "perk_coldblooded";
  game["dialog"]["specialty_hustle"] = "perk_doubletime";
  game["dialog"]["specialty_eod"] = "perk_eod";
  game["dialog"]["specialty_guerrilla"] = "perk_ghost";
  game["dialog"]["specialty_surveillance"] = "perk_highalert";
  game["dialog"]["specialty_heavy_metal"] = "perk_killchain";
  game["dialog"]["specialty_munitions_2"] = "perk_overkill";
  game["dialog"]["specialty_strategist"] = "perk_pointman";
  game["dialog"]["specialty_quick_fix"] = "perk_quickfix";
  game["dialog"]["specialty_restock"] = "perk_restock";
  game["dialog"]["specialty_scavenger_plus"] = "perk_scavenger";
  game["dialog"]["specialty_extra_shrapnel"] = "perk_shrapnel";
  game["dialog"]["specialty_specialist_bonus"] = "perk_specialistbonus";
  game["dialog"]["specialty_tactical_recon"] = "perk_spotter";
  game["dialog"]["specialty_huntmaster"] = "perk_tracker";
  game["dialog"]["specialty_tune_up"] = "perk_tuneup";
}

function ref_12070(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(scripts\mp\utility\game::getgametype() == "infect" && isDefined(var_1) && isDefined(var_1.team) && var_1.team == "axis") {
    return;
  }

  self setscriptablepartstate("headVFX", "neutral", 0);

  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }

  if(var_1 == self) {
    return;
  }

  if(istrue(var_1.isjuggernaut)) {
    return;
  }

  self.spawnloot = 0;

  if(isDefined(var_1) && istrue(var_1.iszombie)) {
    return;
  }

  if(!var_1 scripts\mp\riotshield::riotshield_hasweapon()) {
    if(!isDefined(var_1.spawnloot)) {
      var_1.spawnloot = 1;
      return;
    }

    var_1.spawnloot++;

    if(var_1.spawnloot == level.spawnoffsettacinsertmin) {
      var_10 = var_1 getcustomizationbody();
      var_11 = var_1 getcustomizationhead();
      var_12 = var_1 getcustomizationviewmodel();
      var_1 detachall();
      var_1 setModel(var_10);
      var_1 setviewmodel(var_12);
      var_13 = scripts\engine\utility::ter_op(var_1.team == "allies", "head_mp_human_pumpkin_jackolantern_2_1", "head_mp_human_pumpkin_jackolantern_3_1");
      var_1 attach(var_13, "", 1);
      var_1.headmodel = var_13;
      return;
    }

    if(var_1.spawnloot == level.spawnoutofboundstrigger) {
      var_1 setscriptablepartstate("headVFX", "flames", 0);
      return;
    }

    return;
  }
}

function ref_1439b() {
  waitframe();
  self setscriptablepartstate("headVFX", "neutral", 0);
}

function ref_136b2() {
  self endon("death_or_disconnect");
  self waittill("spawned_player");

  if(scripts\mp\riotshield::riotshield_hasweapon()) {
    return;
  }

  var_0 = self getcustomizationbody();
  var_1 = self getcustomizationhead();
  var_2 = self getcustomizationviewmodel();
  self detachall();
  self setModel(var_0);
  self setviewmodel(var_2);
  var_3 = scripts\engine\utility::ter_op(self.team == "allies", "head_mp_human_pumpkin_jackolantern_2_1", "head_mp_human_pumpkin_jackolantern_3_1");
  self attach(var_3, "", 1);
  self.headmodel = var_3;
}

function ref_1439c() {
  scripts\mp\flags::initgameflags();
  scripts\mp\flags::gameflaginit("gungame_set", 0);

  while(!isDefined(level.weaponmapdata)) {
    waitframe();
  }

  wait 0.1;
  level.blockweapondrops = 1;
  level.setback = 1;
  level.setbackstreak = 0;
  level.killsperweapon = 1;
  level.ladderindex = level.set_systems_init_flag;
  scripts\mp\gametypes\gun::setgunladder();
  scripts\mp\gametypes\gun::setgunsfinal();

  if(turret_enemy_watcher_internal()) {
    level.ref_12037 = &ref_12038;
  } else {
    level.ref_12037 = &ref_12037;
  }

  scripts\mp\flags::gameflagset("gungame_set");
  level.gun_loadouts["axis"]["loadoutPrimary"] = getnextgun(0);
}

function ref_12037(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isPlayer(var_1)) {
    if(isDefined(self.pers["classCache"]) && self.pers["classCache"].size > 0) {
      self.pers["classCache"] = [];
    }

    if(isDefined(var_1.pers["classCache"]) && var_1.pers["classCache"].size > 0) {
      var_1.pers["classCache"] = [];
    }
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(var_4) && var_1 != self) {
    return;
  }

  if(var_3 == "MOD_FALLING" || isDefined(var_1) && isPlayer(var_1)) {
    var_10 = scripts\mp\riotshield::isriotshield(var_4.basename);
    var_11 = scripts\mp\utility\weapon::isknifeonly(var_4.basename) || scripts\mp\utility\weapon::turret_aimed_at_last_known(var_4.basename) || scripts\mp\utility\weapon::isaxeweapon(var_4.basename) || scripts\mp\utility\weapon::update_health_bar_to_player(var_4);
    var_12 = isDefined(var_3) && var_3 == "MOD_EXECUTION";

    if(!isDefined(self.ladderdeathsthisweapon)) {
      self.ladderdeathsthisweapon = 1;
    } else {
      self.ladderdeathsthisweapon++;
    }

    if(var_3 == "MOD_FALLING" || var_1 == self || var_3 == "MOD_MELEE" && var_11 || self.ladderdeathsthisweapon == level.setbackstreak || var_12) {
      self.ladderdeathsthisweapon = 0;
      self playlocalsound("mp_war_objective_lost");
      self notify("update_loadweapons");
      self.gungameprevgunindex = self.gungamegunindex;
      self.gungamegunindex = int(max(0, self.gungamegunindex - level.setback));

      if(self.gungameprevgunindex > self.gungamegunindex) {
        if(level.teambased) {
          scripts\mp\gamescore::giveplayerscore("dropped_gun_rank", 0);
        } else {
          scripts\mp\gamescore::giveplayerscore("dropped_gun_rank", 0);
        }

        thread scripts\mp\rank::scoreeventpopup("dropped_gun_rank");
        var_13 = getnextgun();
        var_13 = scripts\mp\weapons::updatesavedaltstate(var_13);
        self.pers["gamemodeLoadout"]["loadoutPrimary"] = var_13;
        self.preloadedclassstruct = undefined;
      }

      if(var_3 == "MOD_MELEE") {
        if(self.gungameprevgunindex) {
          var_1 thread scripts\mp\utility\points::giveunifiedpoints("dropped_enemy_gun_rank");
        }

        var_1 scripts\mp\awards::givemidmatchaward("mode_gun_melee");
      }

      if(var_1 == self) {
        return;
      }
    }

    if(var_1 != self && var_3 == "MOD_PISTOL_BULLET" || var_3 == "MOD_RIFLE_BULLET" || var_3 == "MOD_HEAD_SHOT" || var_3 == "MOD_PROJECTILE" || var_3 == "MOD_PROJECTILE_SPLASH" || var_3 == "MOD_IMPACT" || var_3 == "MOD_GRENADE" || var_3 == "MOD_GRENADE_SPLASH" || var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_FIRE" || var_3 == "MOD_MELEE" && update_readings(var_1) && (var_11 || var_10 || var_12) || var_3 == "MOD_MELEE" && !var_11 || var_12) {
      var_14 = getweaponbasename(var_1.primaryweapon);

      if(!get_available_unique_id(var_1, var_4, var_14, var_12, var_10, var_11)) {
        return;
      }

      if(!isDefined(var_1.ladderkillsthisweapon)) {
        var_1.ladderkillsthisweapon = 1;
      } else {
        var_1.ladderkillsthisweapon++;
      }

      if(var_1.ladderkillsthisweapon != level.killsperweapon) {
        return;
      }

      var_1.ladderkillsthisweapon = 0;
      var_1.ladderdeathsthisweapon = 0;
      var_1.gungameprevgunindex = var_1.gungamegunindex;
      var_1.gungamegunindex++;
      var_1.pers["gunGamePrevGunIndex"] = var_1.gungamegunindex;
      var_1.pers["gunGameGunIndex"]++;
      var_1 notify("update_loadweapons");

      if(level.teambased) {
        var_1 scripts\mp\gamescore::giveplayerscore("gained_gun_rank", 0);
      } else {
        var_1 scripts\mp\gamescore::giveplayerscore("gained_gun_rank", 0);
      }

      if(var_1.gungamegunindex < level.gun_guns.size) {
        var_15 = scripts\mp\rank::getscoreinfovalue("gained_gun_rank");
        var_1 thread scripts\mp\rank::scorepointspopup(var_15);
        var_1 thread scripts\mp\rank::scoreeventpopup("gained_gun_rank");
        var_1 playlocalsound("mp_war_objective_taken");
        var_13 = getnextgun(var_1);
        var_13 = scripts\mp\weapons::updatesavedaltstate(var_13);
        var_1.pers["gamemodeLoadout"]["loadoutPrimary"] = var_13;
        var_1.preloadedclassstruct = undefined;
        thread givenextgun(var_1);
      } else if(var_1.gungamegunindex >= level.gun_guns.size) {
        var_1.gungamegunindex = 0;
        var_1.gungameprevgunindex = 0;
        var_1.pers["gunGamePrevGunIndex"] = 0;
        var_1.pers["gunGameGunIndex"] = 0;
        var_15 = scripts\mp\rank::getscoreinfovalue("gained_gun_rank");
        var_1 thread scripts\mp\rank::scorepointspopup(var_15);
        var_1 thread scripts\mp\rank::scoreeventpopup("gained_gun_rank");
        var_1 playlocalsound("mp_war_objective_taken");
        var_13 = getnextgun(var_1);
        var_13 = scripts\mp\weapons::updatesavedaltstate(var_13);
        var_1.pers["gamemodeLoadout"]["loadoutPrimary"] = var_13;
        var_1.preloadedclassstruct = undefined;
        thread givenextgun(var_1);
      }

      var_1.lastgunrankincreasetime = gettime();
      return;
    }

    return;
  }
}

function get_available_unique_id(var_0, var_1, var_2, var_3, var_4) {
  if(var_0.basename == var_1) {
    return true;
  }

  if(var_1 == "iw8_sn_crossbow_mp") {
    if(issubstr(var_0.basename, "bolt")) {
      return true;
    }
  }

  if(var_0.basename == "dragonsbreath_mp") {
    return true;
  }

  if(update_readings()) {
    if(var_2 || var_3 || var_4) {
      return true;
    }
  }

  return false;
}

function update_readings() {
  return self.gungamegunindex == level.gun_guns.size - 1;
}

function ref_12038(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isPlayer(var_1)) {
    if(isDefined(self.pers["classCache"]) && self.pers["classCache"].size > 0) {
      self.pers["classCache"] = [];
    }

    if(isDefined(var_1.pers["classCache"]) && var_1.pers["classCache"].size > 0) {
      var_1.pers["classCache"] = [];
    }
  }

  var_10 = isDefined(var_3) && var_3 == "MOD_EXECUTION";

  if(var_3 == "MOD_FALLING" || isDefined(var_1) && isPlayer(var_1)) {
    if(!isDefined(self.ladderdeathsthisweapon)) {
      self.ladderdeathsthisweapon = 1;
    } else {
      self.ladderdeathsthisweapon++;
    }

    if(var_3 == "MOD_FALLING" || var_1 == self || var_3 == "MOD_MELEE" || self.ladderdeathsthisweapon == level.setbackstreak || var_10) {
      self.ladderdeathsthisweapon = 0;
      self playlocalsound("mp_war_objective_lost");
      self notify("update_loadweapons");
      self.gungameprevgunindex = self.gungamegunindex;
      self.gungamegunindex = int(max(0, self.gungamegunindex - level.setback));

      if(self.gungameprevgunindex > self.gungamegunindex) {
        if(level.teambased) {
          scripts\mp\gamescore::giveplayerscore("dropped_gun_rank", 0);
        } else {
          scripts\mp\gamescore::giveplayerscore("dropped_gun_rank", 0);
        }

        thread scripts\mp\rank::scoreeventpopup("dropped_gun_rank");
        var_11 = getnextgun();
        var_11 = scripts\mp\weapons::updatesavedaltstate(var_11);
        self.pers["gamemodeLoadout"]["loadoutPrimary"] = var_11;
        self.preloadedclassstruct = undefined;
      }

      if(var_3 == "MOD_MELEE") {
        if(self.gungameprevgunindex) {
          var_1 thread scripts\mp\utility\points::giveunifiedpoints("dropped_enemy_gun_rank");
        }

        var_1 scripts\mp\awards::givemidmatchaward("mode_gun_melee");
      }

      if(var_1 == self) {
        return;
      }
    }

    if(isDefined(var_1.lastgunrankincreasetime) && var_1.lastgunrankincreasetime + 500 > gettime()) {
      return;
    }

    if(!isDefined(var_1.ladderkillsthisweapon)) {
      var_1.ladderkillsthisweapon = 1;
    } else {
      var_1.ladderkillsthisweapon++;
    }

    if(var_1.ladderkillsthisweapon != level.killsperweapon) {
      return;
    }

    var_1.ladderkillsthisweapon = 0;
    var_1.ladderdeathsthisweapon = 0;
    var_1.gungameprevgunindex = var_1.gungamegunindex;
    var_1.gungamegunindex++;
    var_1.pers["gunGamePrevGunIndex"] = var_1.gungamegunindex;
    var_1.pers["gunGameGunIndex"]++;
    var_1 notify("update_loadweapons");

    if(level.teambased) {
      var_1 scripts\mp\gamescore::giveplayerscore("gained_gun_rank", 0);
    } else {
      var_1 scripts\mp\gamescore::giveplayerscore("gained_gun_rank", 0);
    }

    if(var_1.gungamegunindex < level.gun_guns.size) {
      var_12 = scripts\mp\rank::getscoreinfovalue("gained_gun_rank");
      var_1 thread scripts\mp\rank::scorepointspopup(var_12);
      var_1 thread scripts\mp\rank::scoreeventpopup("gained_gun_rank");
      var_1 playlocalsound("mp_war_objective_taken");
      var_11 = getnextgun(var_1);
      var_11 = scripts\mp\weapons::updatesavedaltstate(var_11);
      var_1.pers["gamemodeLoadout"]["loadoutPrimary"] = var_11;
      var_1.preloadedclassstruct = undefined;
      thread givenextgun(var_1, 0, undefined);
    } else if(var_1.gungamegunindex >= level.gun_guns.size) {
      var_1.gungamegunindex = 0;
      var_1.gungameprevgunindex = 0;
      var_1.pers["gunGamePrevGunIndex"] = 0;
      var_1.pers["gunGameGunIndex"] = 0;
      var_12 = scripts\mp\rank::getscoreinfovalue("gained_gun_rank");
      var_1 thread scripts\mp\rank::scorepointspopup(var_12);
      var_1 thread scripts\mp\rank::scoreeventpopup("gained_gun_rank");
      var_1 playlocalsound("mp_war_objective_taken");
      var_11 = getnextgun(var_1);
      var_11 = scripts\mp\weapons::updatesavedaltstate(var_11);
      var_1.pers["gamemodeLoadout"]["loadoutPrimary"] = var_11;
      var_1.preloadedclassstruct = undefined;
      thread givenextgun(var_1, 0, undefined);
    }

    var_1.lastgunrankincreasetime = gettime();
    return;
  }
}

function ref_1438c() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned_player");

  if(self.gungamegunindex == level.gun_guns.size) {
    self.gungamegunindex = self.gungameprevgunindex;
  }

  thread givenextgun(1);
}

function givenextgun(var_0, var_1, var_2) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notify("giveGunGameWeapon");
  self endon("giveGunGameWeapon");

  if(isDefined(self.infil)) {
    scripts\mp\flags::gameflagwait("prematch_done");
  }

  if(istrue(var_2)) {
    while(scripts\cp_mp\utility\player_utility::isusingremote()) {
      wait 0.05;
    }

    wait 1;
  }

  if(!var_0) {
    scripts\common\utility::allow_weapon_switch(0);
  }

  var_3 = getnextgun();
  var_3 = scripts\mp\weapons::updatesavedaltstate(var_3);

  if(!var_0 && !istrue(var_1) || isbot(self)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3, undefined, undefined, 1);
  }

  if(var_0 && isbot(self)) {
    self setspawnweapon(var_3);

    foreach(var_5 in self.weaponlist) {
      if(var_5 != var_3) {
        thread scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe(var_5);
      }
    }
  }

  if(!var_0 && !istrue(var_1) || isbot(self)) {
    self.pers["primaryWeapon"] = var_3.basename;
    self.primaryweapon = var_3.basename;
    self.primaryweaponobj = var_3;
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_3);
  }

  if(!var_0 && !istrue(var_1)) {
    var_7 = self.lastdroppableweaponobj;
    thread takeweaponwhensafegungame(var_7, 1);
  }

  scripts\mp\weapons::updatetogglescopestate(var_3);
  self.gungameprevgunindex = self.gungamegunindex;

  if(!isDefined(self.lastgunpromotiontime)) {
    self.lastgunpromotiontime = gettime();
  }

  var_8 = (gettime() - self.lastgunpromotiontime) / 1000;
  self.lastgunpromotiontime = gettime();

  if(isDefined(self.pers["longestTimeSpentOnWeapon"]) && var_8 > self.pers["longestTimeSpentOnWeapon"]) {
    self.pers["longestTimeSpentOnWeapon"] = var_8;
    return;
  }
}

function takeweaponwhensafegungame(var_0, var_1) {
  self endon("death_or_disconnect");

  for(;;) {
    if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(var_0)) {
      break;
    }

    waitframe();
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);

  if(var_1) {
    scripts\common\utility::allow_weapon_switch(1);
    return;
  }
}

function getnextgun(var_0) {
  var_1 = self.gungamegunindex;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  var_2 = level.gun_guns[var_1];
  return var_2;
}

function ref_131c1() {
  level.gun_loadouts["axis"]["loadoutPrimary"] = "iw8_pi_cpapa";
  level.gun_loadouts["axis"]["loadoutPrimaryAttachment"] = "none";
  level.gun_loadouts["axis"]["loadoutPrimaryAttachment2"] = "none";
  level.gun_loadouts["axis"]["loadoutPrimaryAttachment3"] = "none";
  level.gun_loadouts["axis"]["loadoutPrimaryAttachment4"] = "none";
  level.gun_loadouts["axis"]["loadoutPrimaryAttachment5"] = "none";
  level.gun_loadouts["axis"]["loadoutPrimaryCamo"] = "none";
  level.gun_loadouts["axis"]["loadoutPrimaryCosmeticAttachment"] = "none";
  level.gun_loadouts["axis"]["loadoutPrimaryReticle"] = "none";
  level.gun_loadouts["axis"]["loadoutPrimarySticker"] = "none";
  level.gun_loadouts["axis"]["loadoutPrimarySticker1"] = "none";
  level.gun_loadouts["axis"]["loadoutPrimarySticker2"] = "none";
  level.gun_loadouts["axis"]["loadoutPrimarySticker3"] = "none";
  level.gun_loadouts["axis"]["loadoutPrimaryVariantID"] = 0;
  level.gun_loadouts["axis"]["loadoutSecondary"] = "none";
  level.gun_loadouts["axis"]["loadoutSecondaryAttachment"] = "none";
  level.gun_loadouts["axis"]["loadoutSecondaryAttachment2"] = "none";
  level.gun_loadouts["axis"]["loadoutSecondaryCamo"] = "none";
  level.gun_loadouts["axis"]["loadoutSecondaryReticle"] = "none";
  level.gun_loadouts["axis"]["loadoutSecondaryVariantID"] = 0;
  level.gun_loadouts["allies"] = level.gun_loadouts["axis"];
}

function tv_station_infil_enemy_combat_logic() {
  return level.set_systems_init_flag == 1;
}

function tv_station_infil_enemies_attack_logic() {
  return level.set_systems_init_flag == 2;
}

function tv_station_global_stealth_broken() {
  return level.set_systems_init_flag == 3;
}

function turret_enemy_watcher_internal() {
  return level.set_systems_init_flag == 7 || level.set_systems_init_flag == 8 || level.set_systems_init_flag == 9 || level.set_systems_init_flag == 10;
}

function ref_1326e() {
  level.ref_1346d = [];
  var_0 = [];
  var_1 = undefined;

  if(scripts\mp\utility\game::getgametype() == "arena") {
    var_2 = getEntArray("flag_arena", "targetname");
    var_1 = var_2[0].origin + (0, 0, 30);
  } else {
    var_0 = [];
    var_3 = getEntArray("flag_primary", "targetname");

    foreach(var_5 in var_3) {
      if(var_5.script_label == "_b") {
        var_0 = var_5.origin;
        break;
      }
    }

    if(var_0.size == 0) {
      return;
    }

    var_0 = scripts\engine\utility::array_randomize(var_0);
    var_1 = var_0[0];

    if(getDvar("NSQLTTMRMP") == "mp_firingrange") {
      var_1 = (-194, -858, 90);
    }
  }

  var_7 = [];
  var_8 = getEntArray("cyber_emp_pickup_trig", "targetname");

  foreach(var_10 in var_8) {
    var_7 = var_10.origin;
  }

  level.ref_11e00 = var_7;
  var_12 = undefined;

  if(getdvarint("scr_soccer_randomSpawnLoc", 0) == 1 && var_7.size > 0) {
    var_12 = 1;
    var_0 = scripts\engine\utility::array_combine(var_0, var_7);
    var_0 = scripts\engine\utility::array_randomize(var_0);
    var_1 = var_0[0];
  }

  thread init_reach_exhaust_waste(level, var_1);
}

function init_reach_exhaust_waste(var_0, var_1) {
  if(isDefined(var_1)) {
    wait var_1;
  }

  var_2 = var_0 + (0, 0, 64);
  var_3 = var_0 + (0, 0, -64);
  var_4 = scripts\engine\trace::ray_trace(var_2, var_3, undefined, scripts\engine\trace::create_default_contents(1));
  var_0 = var_4["position"] + (0, 0, 30);
  var_5 = spawnStruct();
  var_5.angles = (0, 0, 0);
  var_5.visuals = spawn("script_model", var_0);
  var_5.visuals setModel("art_stadium_ball");
  var_5.visuals dontinterpolate();
  var_5.ref_12c7b = var_0;
  var_5.usemilestonephases = 1;
  var_5.onreset = &ref_1208b;
  var_5.ref_1203a = &ref_1203a;
  var_5.ref_13472 = &ref_13789;
  var_6 = (0, 30, 0);
  var_7 = anglestoup(var_6);
  var_8 = anglesToForward(var_6);

  if(getDvar("NSQLTTMRMP") == "mp_m_stadium") {
    var_9 = var_7 * 500 + (0, 0, 80);
  } else {
    var_9 = var_8 * 50 + (0, 0, 80);
  }

  waittillframeend();
  scripts\mp\flags::gameflagwait("prematch_done");
  var_6.visuals physicslaunchserver(var_6.visuals.origin, var_9);
  thread ref_12167();
  thread ref_12168();

  if(getdvarint("scr_game_soccergoal", 1) == 1) {
    thread ref_13470();
  }

  if(isDefined(var_6.ref_13472)) {
    var_6[[var_6.ref_13472]]();
  }

  level.ref_1346d[level.ref_1346d.size] = var_6;
}

function ref_13789() {
  self.visuals thread scripts\mp\utility\entity::register_physics_collisions();
  self.visuals physics_registerforcollisioncallback();
  scripts\mp\utility\entity::register_physics_collision_func(self.visuals, &ball_impact_sounds);
}

function ball_impact_sounds(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = var_0 physics_getbodyid(0);
  var_10 = physics_getbodylinvel(var_9);
  var_11 = length(var_10);

  if(isDefined(var_0.playing_sound) || var_11 < 70) {
    return;
  }

  var_0 endon("death");
  var_0.playing_sound = 1;
  var_12 = physics_getsurfacetypefromflags(var_4);
  var_13 = getsubstr(var_12["name"], 9);

  if(var_13 == "user_terrain1") {
    var_0 playSound("soc_ball_bounce_small");
  } else if(var_11 < 180) {
    var_0 playsurfacesound("soc_ball_bounce_small", var_13);
  } else if(var_11 < 260) {
    var_0 playsurfacesound("soc_ball_bounce_med", var_13);
  } else {
    var_0 playsurfacesound("soc_ball_bounce_large", var_13);
  }

  wait 0.1;
  var_0.playing_sound = undefined;
}

function ref_1208b(var_0) {
  self.stage3accradius = 1;

  if(!istrue(var_0)) {
    wait 0.5;
    self.visuals playSound("soc_ball_vanish");
    playFX(level.ref_1346c["vanish"], self.visuals.origin);
  } else {
    wait 0.1;
    playFX(level.ref_1346c["vanish"], self.visuals.origin);
  }

  self.visuals hide();
  wait 1;
  self.visuals.origin = self.ref_12c7b;
  var_1 = (0, 30, 0);
  var_2 = anglestoup(var_1);
  var_3 = anglesToForward(var_1);

  if(level.mapname == "mp_m_stadium") {
    var_4 = var_2 * 500 + (0, 0, 80);
  } else {
    var_4 = var_3 * 50 + (0, 0, 80);
  }

  self.visuals show();
  self.visuals physicslaunchserver(self.visuals.origin, var_4);
  self.stage3accradius = 0;

  if(isDefined(self.ref_13472)) {
    self[[self.ref_13472]]();
    return;
  }
}

function ref_1203a(var_0) {
  if(istrue(self.stage3accradius)) {
    self.stage3accradius = 0;
    return;
  }

  if(game["switchedsides"]) {
    var_1 = scripts\mp\utility\game::getotherteam(var_0.team)[0];

    if(var_1 == "allies") {
      game["axisGoals"]++;
      var_2 = "goal_1";
    } else {
      game["alliesGoals"]++;
      var_2 = "goal_2";
    }
  } else {
    var_1 = var_2.team;

    if(var_1 == "allies") {
      game["alliesGoals"]++;
      var_2 = "goal_2";
    } else {
      game["axisGoals"]++;
      var_2 = "goal_1";
    }
  }

  if(isDefined(var_2)) {
    scripts\engine\utility::exploder(var_2);
  }

  var_3 = "tv_goal";

  if(isDefined(var_3)) {
    scripts\engine\utility::exploder(var_3);
  }

  var_1.select_low_roof_spawners++;
  ref_14017(level, var_1);
  thread select_lobby_door_two_spawners();
  jumpiffalse(scripts\mp\utility\game::getgametype() == "arena") LOC_000001d0;

  foreach(var_5 in level.players) {
    if(var_5.team == var_2) {
      if(var_5.team == "allies") {
        thread ref_12736(var_5, "dx_mpa_rutl_summer_game_goal" + scripts\engine\utility::random(level.select_lobby_door_one_spawners), "summer_game_goal", 2);
      } else {
        thread ref_12736(var_5, "dx_mpa_uktl_summer_game_goal" + scripts\engine\utility::random(level.select_lobby_door_one_spawners), "summer_game_goal", 2);
      }

      continue;
    }

    if(var_5.team == "allies") {
      thread ref_12736(var_5, "dx_mpa_uktl_summer_game_goal" + scripts\engine\utility::random(level.select_lobby_door_one_spawners), "summer_game_goal", 2);
      continue;
    }

    thread ref_12736(var_5, "dx_mpa_rutl_summer_game_goal" + scripts\engine\utility::random(level.select_lobby_door_one_spawners), "summer_game_goal", 2);
  }

  goto LOC_00000252;
}

function ref_12737() {
  self playSound("soc_ball_explode");
  wait 1.5;
  self playSound("soc_ball_goal_music");
}

function select_lobby_door_two_spawners(var_0, var_1) {
  for(var_2 = 0; var_2 < min(self.select_low_roof_spawners, 10); var_2++) {
    playFX(level.select_stairway_spawners["gos_fireworks"], self.trigger.origin + (randomintrange(-100, 100), randomintrange(-100, 100), randomintrange(-25, 60)), anglesToForward(self.trigger.angles + (randomintrange(int(max(clamp(0 - var_2 * 5, -19, 0), -20)), int(min(20, 1 + var_2 * 5))), randomintrange(int(max(clamp(0 - var_2 * 5, -19, 0), -20)), int(min(20, 1 + var_2 * 5))), 0)), anglestoup(self.trigger.angles + (randomintrange(int(max(clamp(0 - var_2 * 5, -19, 0), -20)), int(min(20, 1 + var_2 * 5))), randomintrange(int(max(clamp(0 - var_2 * 5, -19, 0), -20)), int(min(20, 1 + var_2 * 5))), 0)));

    if(istrue(var_0)) {
      thread ref_14397(level);
    }

    if(isDefined(var_1)) {
      wait var_1;
    }
  }
}

function ref_14017(var_0) {
  foreach(var_2 in level.brking_playerwelcomesplashes) {
    if(var_2.ref_12f11 == var_0.team) {
      if(var_0.select_low_roof_spawners >= 10) {
        var_2.scriptable setscriptablepartstate("score", "10");
        continue;
      }

      var_2.scriptable setscriptablepartstate("score", "0" + scripts\engine\utility::string(var_0.select_low_roof_spawners));
    }
  }
}

function ref_12167() {
  level endon("game_ended");

  for(;;) {
    wait 0.5;

    if(istrue(self.stage3accradius)) {
      continue;
    }

    if(isDefined(self.resetnow)) {
      self.resetnow = undefined;

      if(isDefined(self.onreset)) {
        self thread[[self.onreset]]();
      }

      continue;
    }

    for(var_0 = 0; var_0 < level.radtriggers.size; var_0++) {
      if(!self.visuals istouching(level.radtriggers[var_0])) {
        continue;
      }

      if(isDefined(self.onreset)) {
        self thread[[self.onreset]]();
      }
    }

    for(var_0 = 0; var_0 < level.minetriggers.size; var_0++) {
      if(!self.visuals istouching(level.minetriggers[var_0])) {
        continue;
      }

      if(isDefined(self.onreset)) {
        self thread[[self.onreset]]();
      }
    }

    for(var_0 = 0; var_0 < level.hurttriggers.size; var_0++) {
      if(!self.visuals istouching(level.hurttriggers[var_0])) {
        continue;
      }

      if(isDefined(self.onreset)) {
        self thread[[self.onreset]]();
      }
    }

    if(istrue(level.ballallowedtriggers.size)) {
      self.allowedintrigger = 0;

      foreach(var_2 in level.ballallowedtriggers) {
        if(self.visuals istouching(var_2)) {
          self.allowedintrigger = 1;
          break;
        }
      }
    }

    if(isDefined(level.outofboundstriggers)) {
      foreach(var_2 in level.outofboundstriggers) {
        if(istrue(self.allowedintrigger)) {
          break;
        }

        if(!self.visuals istouching(var_2)) {
          continue;
        }

        if(isDefined(self.onreset)) {
          self thread[[self.onreset]]();
        }
      }
    }

    if(isDefined(self.autoresettime)) {
      wait self.autoresettime;

      if(!isDefined(self.carrier)) {
        if(isDefined(self.onreset)) {
          self thread[[self.onreset]]();
        }
      }
    }
  }
}

function ref_12168() {
  level endon("game_ended");

  for(;;) {
    wait 0.25;

    if(istrue(self.stage3accradius)) {
      continue;
    }

    if(distancesquared(self.visuals.origin, self.ref_12c7b) > 9000000) {
      if(isDefined(self.onreset)) {
        self thread[[self.onreset]]();
      }
    }
  }
}

function ref_13471() {
  var_0 = getEntArray("allies_goal", "targetname");
  var_1 = getEntArray("axis_goal", "targetname");

  if(var_0.size > 0 && var_1.size > 0) {
    level.briotshieldinitialized = spawnStruct();
    level.briotshieldinitialized.team = "allies";
    level.briotshieldinitialized.trigger = var_0[0];
    level.briotshieldinitialized.entsinside = [];
    level.chooseanim_vehicleturretdeath = spawnStruct();
    level.chooseanim_vehicleturretdeath.team = "axis";
    level.chooseanim_vehicleturretdeath.trigger = var_1[0];
    level.chooseanim_vehicleturretdeath.entsinside = [];
    level.chooseanim_vehicleturretdeath.select_low_roof_spawners = 0;

    if(!isDefined(game["roundsPlayed"]) || isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
      game["alliesGoals"] = 0;
      level.briotshieldinitialized.select_low_roof_spawners = 0;
      game["axisGoals"] = 0;
      level.chooseanim_vehicleturretdeath.select_low_roof_spawners = 0;
    } else if(game["switchedsides"]) {
      level.chooseanim_vehicleturretdeath.select_low_roof_spawners = game["alliesGoals"];
      level.briotshieldinitialized.select_low_roof_spawners = game["axisGoals"];
    } else {
      level.briotshieldinitialized.select_low_roof_spawners = game["alliesGoals"];
      level.chooseanim_vehicleturretdeath.select_low_roof_spawners = game["axisGoals"];
    }

    level.ref_1346e = [level.chooseanim_vehicleturretdeath, level.briotshieldinitialized];
    thread ref_1439a();
    return;
  }

  level notify("stop_soccer_goal");
}

function ref_1439a() {
  wait 1;
  level.brjugg_dropfunc = scripts\engine\utility::getStructArray("home", "targetname");
  level.choosedropbagmodel = scripts\engine\utility::getStructArray("away", "targetname");
  level.brking_playerwelcomesplashes = scripts\engine\utility::array_combine(level.brjugg_dropfunc, level.choosedropbagmodel);

  foreach(var_1 in level.brjugg_dropfunc) {
    var_1.scriptable = spawn("script_model", var_1.origin);
    var_1.scriptable.angles = var_1.angles;
    var_1.scriptable setModel("vfx_stadium_scoreboard_scriptable");
    var_1.ref_12f11 = "allies";
  }

  foreach(var_1 in level.choosedropbagmodel) {
    var_1.scriptable = spawn("script_model", var_1.origin);
    var_1.scriptable.angles = var_1.angles;
    var_1.scriptable setModel("vfx_stadium_scoreboard_scriptable");
    var_1.ref_12f11 = "axis";
  }

  ref_14017(level, level.briotshieldinitialized);
  ref_14017(level, level.chooseanim_vehicleturretdeath);
}

function ref_13470(var_0) {
  level endon("game_ended");
  level endon("stop_soccer_goal");

  for(;;) {
    jumpiftrue(isDefined(level.ref_1346e)) LOC_0000001e;
    waitframe();
  }

  for(;;) {
    wait 0.05;

    if(istrue(self.stage3accradius)) {
      continue;
    }

    for(var_1 = 0; var_1 < level.ref_1346e.size; var_1++) {
      if(!validatefunc(level.ref_1346e[var_1], self.visuals)) {
        continue;
      }

      if(!ref_132e7(level.ref_1346e[var_1], self.visuals)) {
        continue;
      }

      var_2 = self.visuals getentitynumber();
      level.ref_1346e[var_1].entsinside[var_2] = self.visuals;
      self.visuals.ref_1346f = level.ref_1346e[var_1];

      if(isDefined(self.ref_1203a)) {
        [[self.ref_1203a]](level.ref_1346e[var_1]);
      }
    }
  }
}

function ref_132e7(var_0, var_1) {
  var_2 = var_1 getentitynumber();

  if(isDefined(var_0.entsinside[var_2])) {
    return false;
  }

  return true;
}

function validatefunc(var_0, var_1) {
  if(!var_1 istouching(var_0.trigger)) {
    var_2 = var_1 getentitynumber();
    var_0.entsinside[var_2] = undefined;

    if(isDefined(var_1.ref_1346f) && var_1.ref_1346f == var_0) {
      var_1.ref_1346f = undefined;
    }

    return false;
  }

  return true;
}

function ref_14397(var_0) {
  var_1 = "gos_firework_scream_sfx";
  playsoundatpos(var_0, var_1);
  var_2 = lookupsoundlength(var_1);
  wait 1.5;
  playsoundatpos(var_0 + (0, 0, 600), "gos_firework_explo_sfx");
}

function ref_11962() {
  level.select_stairway_spawners["gos_fireworks"] = loadfx("vfx/iw8_mp/gamemode/vfx_gos_firework.vfx");
  level.ref_1346c["vanish"] = loadfx("vfx/iw8_mp/gamemode/vfx_soccer_ball_burst.vfx");
  level.ref_1346c["score_00"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_00.vfx");
  level.ref_1346c["score_01"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_01.vfx");
  level.ref_1346c["score_02"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_02.vfx");
  level.ref_1346c["score_03"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_03.vfx");
  level.ref_1346c["score_04"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_04.vfx");
  level.ref_1346c["score_05"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_05.vfx");
  level.ref_1346c["score_06"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_06.vfx");
  level.ref_1346c["score_07"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_07.vfx");
  level.ref_1346c["score_08"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_08.vfx");
  level.ref_1346c["score_09"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_09.vfx");
  level.ref_1346c["score_10"] = loadfx("vfx/iw8_mp/level/stadium/vfx_stad_score_10.vfx");
}

function ref_13237() {
  game["dialog"]["summer_game_goal_1"] = "summer_game_goal_1";
  game["dialog"]["summer_game_goal_2"] = "summer_game_goal_2";
  game["dialog"]["summer_game_goal_3"] = "summer_game_goal_3";
  level.select_lobby_door_one_spawners = ["_1", "_2", "_3"];
}

function ref_12736(var_0, var_1, var_2, var_3) {
  self notify("goal_scored");
  self endon("goal_scored");

  if(!isDefined(level.lastteamstatustime["allies"][var_1])) {
    level.lastteamstatustime["allies"][var_1] = 0;
  }

  if(gettime() < level.lastteamstatustime["allies"][var_1] + var_2 * 1000) {
    return;
  }

  self queuedialogforplayer(var_0, var_1, var_2);
  level.lastteamstatustime["allies"][var_1] = gettime();
  thread scripts\mp\hud_message::showsplash(var_3);
}