/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_prop.gsc
*****************************************************/

function init() {
  level.ref_12315 = spawnStruct();
  level.ref_12315.settings = spawnStruct();
  level.ref_12315.settings.ref_128f2 = getdvarint("scr_br_prop_hide_time", 30);
  level.ref_12315.settings.ref_12924 = getdvarint("scr_br_prop_whistle_time", 30);
  level.ref_12315.settings.ref_128db = getdvarint("scr_br_prop_num_changes", 2);
  level.ref_12315.settings.ref_12904 = getdvarint("scr_br_prop_num_flahes", 1);
  level.ref_12315.settings.ref_12903 = getdvarint("scr_br_prop_num_clones", 3);
  level.ref_12315.settings.ref_12914 = getdvarfloat("scr_br_prop_speed_scale", 1.4);
  level.ref_12315.settings.ref_11c86 = getdvarint("scr_br_prop_mode", 0);
  level.ref_12315.settings.ref_11f3d = getdvarint("scr_br_prop_hunters", 20);
  level.ref_12315.settings.ref_11f42 = getdvarint("scr_br_prop_num_per_area", 30);

  if(level.ref_12315.settings.ref_11c86 == 1) {
    scripts\mp\utility\game::registerroundswitchdvar(level.gametype, 1, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(level.gametype, 4);
    scripts\mp\utility\game::registerscorelimitdvar(level.gametype, 0);
    scripts\mp\utility\game::registerroundlimitdvar(level.gametype, 4);
    scripts\mp\utility\game::registerwinlimitdvar(level.gametype, 3);
    scripts\mp\utility\game::registernumlivesdvar(level.gametype, 1);
    scripts\mp\utility\game::registerhalftimedvar(level.gametype, 0);
    level.objectivebased = 1;
    level.getintermissionspawnpointoverride = &ref_12316;
    level.remaining_enemies_aggro = &remapattachmentparentname;
    level.playoverwatch_dialogue_with_endon = &playoverwatch_dialogue_with_endon;
  }

  level.updatex1prematchloadoutarray = 1;
  level.allowlatecomers = 1;
  level.checkforlaststandfinish = 1;
  level.custom_death_sound = &ref_1245e;
  level.loadoutdrop = &loadoutdefaultperkdiscount;
  level.getrandompointincirclenearby = &getrandompointincirclenearby;
  scripts\mp\gametypes\br_gametypes::ref_12b11("onStartGameType", &onstartgametype);
  scripts\mp\gametypes\br_gametypes::ref_12b11("modifyPlayerDamage", &gamemodemodifyplayerdamage);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerConnect", &onplayerconnect);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerSkipLootPickup", &ref_1269c);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerKilled", &onplayerkilled);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerPreSpawnGulagJail", &ref_1263d);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerNakedDropLoadout", &ref_12604);
  scripts\mp\gametypes\br_gametypes::ref_12b11("getInfilPlayers", &remove_on_death);
  scripts\mp\gametypes\br_gametypes::ref_12b11("dropOnPlayerDeath", &droponplayerdeath);
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("plunderSites");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("drogBagLoadout");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("oneLife");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("waitLoadoutDone");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("armor");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("squadLeader");
  level.ref_12315.ref_11975 = [];
  level.ref_12315.ref_128f7 = [];
  level.ref_12315.armor_nag = ["FLASH", "CLONE"];
  thread ref_1217c();
  thread toggleusbstickinhand();
  level.teammaxfill = 0;
  game["attackers"] = "allies";
  game["defenders"] = "axis";
}

function toggleusbstickinhand() {
  waittillframeend();
  level.onsuicidedeath = &onsuicidedeath;
  level.onnormaldeath = &onnormaldeath;
  level.onspawnplayer = &onspawnplayer;
  level.ononeleftevent = &ononeleftevent;
  level.ontimelimit = &ontimelimit;
  level.ondeadevent = &ondeadevent;
  level.bypassclasschoicefunc = &ref_12321;
  level.onplayerjointeam = &onplayerjointeam;
  scripts\mp\tweakables::settweakablevalue("player", "healthregentime", 0);
  scripts\mp\tweakables::settweakablelastvalue("player", "healthregentime", 0);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
  scripts\mp\rank::registerscoreinfo("still_alive", "value", 50);
  scripts\mp\rank::registerscoreinfo("still_alive_medium_bonus", "value", 50);
  scripts\mp\rank::registerscoreinfo("still_alive_large_bonus", "value", 100);
  scripts\mp\rank::registerscoreinfo("still_alive_extra_large_bonus", "value", 150);
  scripts\mp\rank::registerscoreinfo("clone_destroyed", "value", 50);
  scripts\mp\rank::registerscoreinfo("clone_was_destroyed", "value", 10);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "onEnterVehicle", &vehicle_occupancy_mp_onentervehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "onExitVehicle", &vehicle_occupancy_mp_onexitvehicle);
  ref_127e9();
  toma_strike();
}

function ref_1217c() {
  while(!isDefined(game["music"]) || !isDefined(game["music"]["match_ending_soon"])) {
    waitframe();
  }

  game["music"]["match_ending_soon"] = "prop_countdown";
}

function onplayerconnect(var_0) {
  if(!isDefined(var_0.pers["propSeconds"])) {
    var_0.pers["propSeconds"] = 0;
    return;
  }
}

function onstartgametype() {
  if(level.ref_12315.settings.ref_11c86 == 1) {
    if([[level.getintermissionspawnpointoverride]]()) {
      game["status"] = "overtime";
      setDvar("ui_overtime", 1);
      setDvar("overtimeTimeLimit", 3.5);
    }

    if(!isDefined(game["switchedsides"])) {
      game["switchedsides"] = 0;
    }

    if(game["switchedsides"]) {
      var_0 = game["attackers"];
      var_1 = game["defenders"];
      game["attackers"] = var_1;
      game["defenders"] = var_0;
    } else {
      level.prematchperiod = 30;
    }
  }

  setspecialloadouts();
  setclientnamemode("manual_change");
  scripts\mp\utility\game::setobjectivetext(game["attackers"], &"OBJECTIVES_PH/ATTACKER");
  scripts\mp\utility\game::setobjectivetext(game["defenders"], &"OBJECTIVES_PH/DEFENDER");
  scripts\mp\utility\game::setobjectivescoretext(game["attackers"], &"OBJECTIVES_PH/ATTACKER_SCORE");
  scripts\mp\utility\game::setobjectivescoretext(game["defenders"], &"OBJECTIVES_PH/DEFENDER_SCORE");
  scripts\mp\utility\game::setobjectivehinttext(game["attackers"], &"OBJECTIVES_PH/ATTACKER_HINT");
  scripts\mp\utility\game::setobjectivehinttext(game["defenders"], &"OBJECTIVES_PH/DEFENDER_HINT");

  if(level.ref_12315.settings.ref_11c86 == 1) {
    var_2 = game["roundsPlayed"] % 4 == 2 || game["roundsPlayed"] % 4 == 3;

    if(var_2) {
      game["switchedsides"] = !game["switchedsides"];
      game["switchedsides"] = !game["switchedsides"];
    }
  }

  level._effect["propFlash"] = loadfx("vfx/core/mp/equipment/vfx_concussion_grenade");
  level._effect["propDeathFX"] = loadfx("vfx/iw8/weap/_explo/claymore/vfx_explo_claymore");

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
  thread ref_13269();
  thread ref_12913();
  level thread scripts\mp\gametypes\_prop_controls::spawn_carried_punchcard_if_player_down();
  thread ref_11d20();
  thread last_spawned_time();
  thread ref_13198();
  thread ref_138a9();
  thread ref_13c62();
  thread ref_1386d();
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  ref_128ed(var_1.pers["team"]);

  if(game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level.otherteam[var_1.team]]) {
    var_1.finalkill = 1;
    return;
  }
}

function onsuicidedeath(var_0) {
  if(var_0 scripts\mp\playerlogic::mayspawn()) {
    return;
  }

  var_1 = scripts\mp\utility\game::getotherteam(var_0.pers["team"]);

  foreach(var_3 in var_1) {
    ref_128ed(var_3);
  }
}

function ref_128ed(var_0) {
  if(var_0 != game["attackers"]) {
    return;
  }

  level scripts\mp\gamescore::giveteamscoreforobjective(var_0, 1, 1);
  game["propScore"][var_0] = game["propScore"][var_0] + 1;
}

function remapattachmentparentname(var_0, var_1) {
  if(!isstring(var_0)) {
    return var_0;
  }

  var_2 = var_0;

  if(level.gameended) {
    var_3 = "roundsWon";

    if(isDefined(level.ref_145c0) && level.ref_145c0) {
      var_3 = "teamScores";
    }

    level.ref_12916 = "none";

    if(game[var_3]["allies"] == game[var_3]["axis"]) {
      level.ref_12916 = "kills";

      if(game["propScore"]["axis"] == game["propScore"]["allies"]) {
        level.ref_12916 = "time";

        if(game["hunterKillTime"]["axis"] == game["hunterKillTime"]["allies"]) {
          level.ref_12916 = "tie";
          var_2 = "tie";
        } else if(game["hunterKillTime"]["axis"] < game["hunterKillTime"]["allies"]) {
          var_2 = "axis";
        } else {
          var_2 = "allies";
        }
      } else if(game["propScore"]["axis"] > game["propScore"]["allies"]) {
        var_2 = "axis";
      } else {
        var_2 = "allies";
      }

      if(var_2 != "tie") {
        thread scriptgoalyaw(level);
      }
    } else if(game[var_3]["axis"] > game[var_3]["allies"]) {
      var_2 = "axis";
    } else {
      var_2 = "allies";
    }
  }

  if(var_1 && (var_2 == "allies" || var_2 == "axis")) {
    ref_12319(var_2);
  }

  return var_2;
}

function relic_squadlink_modifyplayerdamage() {
  var_0 = [];
  GscBinSkip0(0x2e, "loadoutArchetype", "archetype_assault");
}

function setspecialloadouts() {
  var_0 = game["defenders"];
  level.ref_12318[var_0] = relic_squadlink_modifyplayerdamage();
  var_1 = game["attackers"];
  level.ref_12318[var_1] = relic_squadlink_modifyplayerdamage();
  level.ref_12318[var_1]["loadoutPrimary"] = "iw8_ar_akilo47";
  level.ref_12318[var_1]["loadoutPrimaryAttachment"] = "xmags";
  level.ref_12318[var_1]["loadoutPrimaryAttachment2"] = "laser";
  level.ref_12318[var_1]["loadoutSecondary"] = "iw8_pi_mike1911";
  level.ref_12318[var_1]["loadoutEquipmentSecondary"] = "equip_concussion";
  level.ref_12318[var_1]["loadoutPerks"] = ["specialty_restock", "specialty_hustle"];
}

function ref_12321() {
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  self.pers["gamemodeLoadout"] = level.ref_12318[self.pers["team"]];
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
  return self.class;
}

function ref_12913() {
  level endon("game_ended");
  scripts\mp\spectating::updatespectatesettings();
}

function ref_145b9(var_0) {
  level notify("whistle_start_timer_beginning");
  var_1 = int(var_0);

  if(var_1 >= 0) {
    thread ref_145ba(var_1);
    return;
  }
}

function ref_145ba(var_0) {
  level endon("whistle_start_timer_beginning");
  waittillframeend();

  while(var_0 > 0 && !level.gameended) {
    setomnvar("ui_ph_whistle_countdown", var_0);
    var_0--;
    wait 1;
  }

  setomnvar("ui_ph_whistle_countdown", var_0);
}

function ref_1408e() {
  return true;
}

function ref_13269() {
  if(ref_1408e() && level.ref_12315.settings.ref_128f2 > 0) {
    level.ref_12315.implement_cointoss = scripts\mp\hud_util::createservertimer("default", 1.4);
    level.ref_12315.implement_cointoss scripts\mp\hud_util::setpoint("CENTER", undefined, 0, 50);
    level.ref_12315.implement_cointoss.label = &"MP_PH/STARTS_IN";
    level.ref_12315.implement_cointoss.alpha = 0;
    level.ref_12315.implement_cointoss.archived = 0;
    level.ref_12315.implement_cointoss.hidewheninmenu = 1;
    level.ref_12315.implement_cointoss.sort = 1;
  }

  if(ref_1408e()) {
    level.ref_12315.ref_145bb = scripts\mp\hud_util::createservertimer("default", 0.9);
    level.ref_12315.ref_145bb.x = -6;
    level.ref_12315.ref_145bb.y = 2;
    level.ref_12315.ref_145bb.alignx = "right";
    level.ref_12315.ref_145bb.aligny = "top";
    level.ref_12315.ref_145bb.horzalign = "right_adjustable";
    level.ref_12315.ref_145bb.vertalign = "top_adjustable";
    level.ref_12315.ref_145bb.label = &"MP_PH/WHISTLE_IN";
    level.ref_12315.ref_145bb.alpha = 0;
    level.ref_12315.ref_145bb.archived = 1;
    level.ref_12315.ref_145bb.hidewheninmenu = 1;
    level.ref_12315.ref_145bb settimer(120);
  } else {
    ref_145b9(120);
  }

  if(ref_1408e()) {
    level.ref_145bc = init_trap_room_obj("default", 1);
    level.ref_145bc.label = &"MP_PH/WHISTLING";
    level.ref_145bc.x = -5;
    level.ref_145bc.y = 2;
    level.ref_145bc.alignx = "right";
    level.ref_145bc.aligny = "top";
    level.ref_145bc.horzalign = "right_adjustable";
    level.ref_145bc.vertalign = "top_adjustable";
    level.ref_145bc.archived = 1;
    level.ref_145bc.alpha = 0;
    level.ref_145bc.glowalpha = 0.2;
    level.ref_145bc.hidewheninmenu = 0;
  }

  if(ref_1408e()) {
    if(!isDefined(level.monitor_player_plundercount)) {
      level.monitor_player_plundercount = [];
    }

    level.monitor_player_plundercount = init_trap_room_obj("default", 0.9);
    level.monitor_player_plundercount.label = &"MP_PH/ALIVE";
    level.monitor_player_plundercount setvalue(0);
    level.monitor_player_plundercount.x = -5;
    level.monitor_player_plundercount.y = 14;
    level.monitor_player_plundercount.alignx = "right";
    level.monitor_player_plundercount.aligny = "top";
    level.monitor_player_plundercount.horzalign = "right_adjustable";
    level.monitor_player_plundercount.vertalign = "top_adjustable";
    level.monitor_player_plundercount.archived = 1;
    level.monitor_player_plundercount.fontscale = 1;
    level.monitor_player_plundercount.alpha = 1;
    level.monitor_player_plundercount.glowalpha = 0;
    level.monitor_player_plundercount.hidewheninmenu = 0;
    thread monitor_truck_stuck();
    return;
  }
}

function init_trap_room_obj(var_0, var_1) {
  var_2 = newhudelem();
  var_2.elemtype = "font";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 scripts\mp\hud_util::setparent(level.uiparent);
  var_2.hidden = 0;
  var_2.archived = 0;
  return var_2;
}

function monitor_truck_stuck() {
  level endon("game_ended");

  for(;;) {
    var_0 = prematchspawnoriginteamcount(game["defenders"]);
    level.monitor_player_plundercount setvalue(var_0.size);
    level scripts\engine\utility::ref_143a8("player_spawned", "playerCountChanged", "propCountChanged", "playerDisconnected");
  }
}

function prematchspawnoriginteamcount(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isalive(var_3) && (!isDefined(var_3.sessionstate) || var_3.sessionstate == "playing")) {
      if(!isDefined(var_0) || var_3.team == var_0) {
        var_1 = var_3;
      }
    }
  }

  return var_1;
}

function onplayerdisconnect(var_0) {
  level notify("playerDisconnected");

  if(isDefined(var_0.ref_128f8)) {
    ref_12907(var_0);
    return;
  }

  if(isDefined(var_0.ref_128dd)) {
    ref_12906(var_0);
    return;
  }
}

function vehomn_fadeoutcontrolsforclient(var_0, var_1) {
  if(isbot(var_0)) {
    return;
  }

  kick(var_0 getentitynumber(), var_1);
}

function ref_145a4() {
  var_0 = scripts\engine\utility::ref_143af("weapon_fired", "sprint_begin", "specialGrenade", "end_weapon_check_usage");

  if(var_0 == "end_weapon_check_usage") {
    if(istrue(self.should_skip_default_intro_scene)) {
      return true;
    }

    vehomn_fadeoutcontrolsforclient(self, "EXE_PLAYERKICKED_INACTIVE");
    return false;
  }

  return true;
}

function ref_127ee(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!isDefined(var_0)) {
    var_0 = 45;
  }

  if(!isDefined(var_1)) {
    var_1 = 300;
  }

  var_2 = self.origin;
  var_3 = squared(var_1);
  var_4 = 0;

  for(var_5 = 0; var_5 < var_0; var_5++) {
    if(!var_4) {
      var_6 = distancesquared(var_2, self.origin);

      if(var_6 >= var_3) {
        var_4 = 1;
      }
    }

    wait 1;
  }

  if(var_4) {
    return true;
  }

  return false;
}

function ref_143f0() {
  scripts\mp\flags::gameflagwait("br_ready_to_jump");
}

function ref_1383c() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self.manageafktracking = 1;
  ref_143f0();
  GscBinSkip4(0x35);
}

function onspawnplayer() {
  scripts\mp\gametypes\br::onspawnplayer();
  self.breathingstoptime = 0;

  if(ref_125f0()) {
    self.ref_133c8 = 1;
    self.overrideweaponspeed_speedscale = level.ref_12315.settings.ref_12914;

    if(!isDefined(self.armor_target_vo)) {
      self.armor_target_vo = 0;
    }

    if(!isDefined(self.heli_boss_shoot)) {
      self.heli_boss_shoot = 0;
    }

    if(!isDefined(self.pers["ability"])) {
      self.pers["ability"] = 0;
    }

    self.initplayerplunderevents = level.ref_12315.armor_nag[self.pers["ability"]];

    if(ref_1408e()) {
      thread scripts\mp\gametypes\_prop_controls::ref_128e4();
    }

    self.turret_guncourse_think = 0;
    var_0 = int(level.ref_12315.settings.ref_128db);
    var_1 = undefined;
    var_2 = undefined;

    if(isDefined(self.ref_13640) && isDefined(self.getbrplayersnoteliminated)) {
      var_0 = self.getbrplayersnoteliminated;
      var_1 = self.armor_target_vo;
      var_2 = self.heli_boss_shoot;
    }

    scripts\mp\gametypes\_prop_controls::ref_1290a(var_0);
    scripts\mp\gametypes\_prop_controls::ref_13177(self.initplayerplunderevents, var_1);
    scripts\mp\gametypes\_prop_controls::ref_13177("CLONE", var_2);
    thread scripts\mp\gametypes\_prop_controls::has_keycard();
    thread setupextractnumhud();
  } else {
    self.ref_133c8 = undefined;
    self.armor_target_vo = undefined;
    self.heli_boss_shoot = undefined;
    self.overrideweaponspeed_speedscale = undefined;

    if(!isDefined(self.ref_13b5e)) {
      self.ref_13b5e = 0;
    }

    thread scriptcircleat();
    var_3 = 1;

    if(var_3 && !isDefined(self.manageafktracking)) {
      thread ref_1383c();
    }
  }

  self.ref_13640 = 1;
}

function ref_11d20() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("props_hide_start");

  if(ref_1408e()) {
    if(level.ref_12315.settings.ref_128f2 > 0) {
      level.ref_12315.implement_cointoss settimer(level.ref_12315.settings.ref_128f2);
      level.ref_12315.implement_cointoss.alpha = 1;
    }

    level.ref_12315.ref_145bb settimer(level.ref_12315.settings.ref_12924 + level.ref_12315.settings.ref_128f2);
    level.ref_12315.ref_145bb.alpha = 1;
  } else if(level.ref_12315.settings.ref_128f2 > 0 || level.ref_12315.settings.ref_12924 > 0) {
    ref_145b9(level.ref_12315.settings.ref_12924 + level.ref_12315.settings.ref_128f2);
  }

  if(level.ref_12315.settings.ref_128f2 > 0) {
    wait level.ref_12315.settings.ref_128f2;
  }

  scripts\mp\flags::gameflagset("props_hide_over");

  if(ref_1408e()) {
    level.ref_12315.ref_145bb.alpha = 1;

    if(level.ref_12315.settings.ref_128f2 > 0) {
      level.ref_12315.implement_cointoss.alpha = 0;
    }
  }

  if(level.ref_12315.settings.ref_12924 > 0) {
    ref_12923();
    return;
  }
}

function setupextractnumhud() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self waittill("giveLoadout");
  self allowprone(0);
  self allowsprint(0);
  scripts\mp\weapons::updatemovespeedscale();
  self disableweaponpickup();
  self takeallweapons();
  self allowspectateteam(game["attackers"], 1);
  self playerhide();
  scripts\mp\class::loadout_giveperk("specialty_quieter");
  thread ref_13266();
  thread scripts\mp\gametypes\_prop_controls::ref_13256();
  thread ref_13236();
  thread scripts\mp\gametypes\_prop_controls::ref_128f5();
  thread ref_12921();
  thread ref_1291f();
  thread ref_12920();
  thread ref_12922();
  thread spawn_exfil_techo(self.prop, game["defenders"], "outline_nodepth_cyan");
  self.hoopty_initomnvars = undefined;
}

function run_guards_spawner(var_0) {
  switch (var_0) {
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

function run_global_functions_for_relics(var_0) {
  switch (var_0) {
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

function calculateobjectivesheld() {
  if(!isDefined(self.prop.ref_1467e)) {
    return;
  }

  self.prop.angles = self.angles;
  var_0 = anglesToForward(self.prop.angles) * self.prop.ref_1467e[0];
  var_1 = anglestoright(self.prop.angles) * self.prop.ref_1467e[1];
  var_2 = anglestoup(self.prop.angles) * self.prop.ref_1467e[2];
  self.prop.origin += var_0;
  self.prop.origin += var_1;
  self.prop.origin += var_2;
}

function cache1_defender_after_spawn() {
  if(!isDefined(self.prop.building_roof_chopper_reenforce)) {
    return;
  }

  self.prop.angles = self.angles;
  self.prop.angles += self.prop.building_roof_chopper_reenforce;
  self.turret_guncourse_think = 1;
}

function gettimeremaining() {
  var_0 = 0;

  if(isDefined(level.br_level) && isDefined(level.br_level.default_class_chosen)) {
    for(var_1 = 0; var_1 < level.br_level.br_circledelaytimes.size; var_1++) {
      var_2 = level.br_level.br_circledelaytimes[var_1];
      var_3 = level.br_level.br_circleclosetimes[var_1];
      var_0 = var_0 + var_2 + var_3;
    }

    var_0 *= 1000;
    var_4 = gettime() - level.ref_12315.settings.ref_145b8;
    var_0 -= var_4;

    if(var_0 < 0) {
      var_0 = 0;
    }
  }

  return int(var_0);
}

function ref_12923() {
  level endon("game_ended");
  level.ref_12315.settings.ref_145b8 = gettime();
  var_0 = gettime();
  var_1 = level.ref_12315.settings.ref_12924 * 1000;
  var_2 = 20000;
  var_3 = var_2;
  var_4 = 500;
  var_5 = 5000;
  var_6 = 0;
  var_7 = getEntArray("minimap_corner", "targetname")[0].origin;
  wait level.ref_12315.settings.ref_12924;

  if(!ref_1408e()) {
    setomnvar("ui_war_active_sector", 0);
  }

  for(;;) {
    if(var_0 + var_1 - var_4 < gettime()) {
      var_6++;
      var_8 = sortbydistance(level.players, var_7);

      foreach(var_10 in var_8) {
        if(!isDefined(var_10)) {
          continue;
        }

        if(ref_1408e()) {
          level.ref_12315.ref_145bb.alpha = 0;
          level.ref_145bc.alpha = 0.6;
        }

        if(ref_125f0(var_10) && isalive(var_10)) {
          if(ref_1408e()) {
            level.ref_145bc.alpha = 1;
            level.ref_145bc fadeovertime(0.75);
            level.ref_145bc.alpha = 0.6;
          }

          playsoundatpos(var_10.origin + (0, 0, 60), "prop_whistle");
          wait 1.5;
        }
      }

      if(!ref_1408e()) {
        setomnvar("ui_war_active_sector", 2);
      }

      var_0 = gettime();

      if(var_6 % 2 == 0) {
        var_1 = max(var_1 - 5000, var_2);
      }

      if(var_3 >= gettimeremaining() - var_5) {
        if(ref_1408e()) {
          level.ref_145bc.alpha = 0;
        }

        return;
      } else {
        if(var_3 * 2 + getteamplayersalive(game["defenders"]) * 2500 >= gettimeremaining() - var_5) {
          if(ref_1408e()) {
            level.ref_12315.ref_145bb.label = &"MP_PH/FINAL_WHISTLE";
          } else {
            setomnvar("ui_war_active_sector", 1);
          }

          var_3 += getteamplayersalive(game["defenders"]) * 2500;
        }

        if(ref_1408e()) {
          level.ref_12315.ref_145bb settimer(int(var_1 / 1000));
        } else {
          ref_145b9(int(var_1 / 1000));
        }

        if(ref_1408e()) {
          level.ref_145bc.alpha = 0;
          level.ref_12315.ref_145bb.alpha = 1;
        }
      }
    }

    wait 0.5;
  }
}

function removematchingents_byclassname(var_0) {
  var_1 = [];

  foreach(var_3 in level.participants) {
    if(!isDefined(var_3.team)) {
      continue;
    }

    if(scripts\mp\utility\player::isreallyalive(var_3) && scripts\mp\utility\entity::isteamparticipant(var_3) && var_3.team == var_0) {
      var_1 = var_3;
    }
  }

  return var_1;
}

function init_swivelroom_variables() {
  self.ref_136d7 = removematchingents_byclassname(game["defenders"]);
}

function ref_13236() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  wait 0.5;
  self.prop.ref_133d4 = 1;
  self.prop thread scripts\mp\damage::monitordamage(self.prop.health, "standard", undefined, &damagewatch);
}

function damagewatch(var_0) {
  if(!isDefined(var_0.attacker)) {
    return false;
  }

  if(!isDefined(self.owner)) {
    return false;
  }

  if(isPlayer(var_0.attacker)) {
    if(var_0.attacker.pers["team"] == self.owner.pers["team"]) {
      return false;
    }

    var_0.attacker thread scripts\mp\damagefeedback::updatedamagefeedback("standard");

    if(var_0.objweapon.basename == "concussion_grenade_mp") {
      var_1 = spawnStruct();
      var_1.origin = var_0.point;
      self.owner thread scripts\mp\equipment\concussion_grenade::applyconcussion(var_1, var_0.attacker);

      if(istrue(self.owner.lock)) {
        self.owner scripts\mp\gametypes\_prop_controls::ref_13f1d();
      }
    }
  }

  self.owner dodamage(var_0.damage, var_0.point, var_0.attacker, var_0.inflictor, var_0.meansofdeath, var_0.objweapon);
  return false;
}

function ref_128df() {
  thread ref_128e0([self.prop, self.ref_128d7, self.ref_128ea]);
}

function ref_128e0(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 unlink();
    }
  }

  waitframe();

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 delete();
    }
  }
}

function ref_12921() {
  level endon("game_ended");
  self endon("disconnect");
  self.iskingofthehillactive = "prop_death";
  self.ref_128e5 = "propDeathFX";
  self waittill("death");
  var_0 = self.body;
  playsoundatpos(self.prop.origin + (0, 0, 4), self.iskingofthehillactive);
  playFX(scripts\engine\utility::getfx(self.ref_128e5), self.prop.origin + (0, 0, 4));

  if(isDefined(var_0)) {
    var_0 delete();
  }

  ref_128df();
  self setcamerathirdperson(0, 0);
  ref_12680(0);
}

function ref_1291f() {
  self notify("propWatchDeleteDisconnect");
  self endon("propWatchDeleteDisconnect");
  level endon("game_ended");
  self waittill("disconnect");

  foreach(var_1 in level.players) {
    if(istrue(var_1.ref_12913) && isDefined(var_1.ref_136df) && self == var_1.ref_136df) {
      var_1 notify("endPropSpectate");
    }
  }

  ref_128df();
  ref_128e1();
}

function ref_12920() {
  self notify("propWatchDeleteRoundEnd");
  self endon("propWatchDeleteRoundEnd");
  self endon("disconnect");
  level waittill("game_ended");
  scripts\engine\utility::waittill_notify_or_timeout("end_killcam", 5);
  ref_128df();
  ref_128e1();
}

function ref_128e1() {
  if(isDefined(self.ref_128e3)) {
    foreach(var_1 in self.ref_128e3) {
      if(isDefined(var_1)) {
        var_1 delete();
      }
    }

    return;
  }
}

function handleriotshielddamage() {
  foreach(var_1 in level.players) {
    ref_128e1(var_1);
  }
}

function ref_12922() {
  self endon("death_or_disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self allowprone(0);
  self allowsprint(0);
}

function last_spawned_time() {
  level endon("game_ended");
  level waittill("prematch_over");
}

function ref_1213e() {
  foreach(var_5, var_1 in level.ref_12315.ref_128f7) {
    if(var_5 != "any") {
      foreach(var_3 in level.ref_12315.ref_128f7["any"]) {
        level.ref_12315.ref_128f7[var_5][var_4] = scripts\engine\utility::array_combine(level.ref_12315.ref_128f7[var_5][var_4], var_3);
      }
    }
  }
}

function ref_129f3(var_0) {
  var_1 = level.ref_12315.ref_128f7[var_0];
  var_2 = 10 * isDefined(var_1[50]);
  var_3 = 30 * isDefined(var_1[100]);
  var_4 = 40 * isDefined(var_1[250]);
  var_5 = 20 * isDefined(var_1[450]);
  var_6 = 10 * isDefined(var_1[550]);
  var_7 = var_2 + var_3 + var_4 + var_5 + var_6;
  var_8 = randomint(var_7);

  if(var_8 < var_2) {
    return 50;
  }

  var_8 -= var_2;

  if(var_8 < var_3) {
    return 100;
  }

  var_8 -= var_3;

  if(var_8 < var_4) {
    return 250;
  }

  var_8 -= var_4;

  if(var_8 < var_5) {
    return 450;
  }

  var_8 -= var_5;
  return 550;
}

function reset_search_spot_light_nodes(var_0) {
  var_1 = ref_128ec(var_0);
  var_2 = level.ref_12315.ref_128f7[var_1];
  var_3 = ref_129f3(var_1);
  var_4 = scripts\engine\utility::array_randomize(getarraykeys(var_2));
  var_5 = [var_3];

  foreach(var_7 in var_4) {
    if(var_7 != var_3) {
      var_5 = var_7;
    }
  }

  var_9 = undefined;

  for(var_10 = 0; var_10 < var_5.size; var_10++) {
    var_7 = var_5[var_10];

    if(!isDefined(var_2[var_7]) || !var_2[var_7].size) {
      continue;
    }

    var_11 = scripts\engine\utility::array_randomize(var_2[var_7]);

    for(var_12 = 0; var_12 < var_11.size; var_12++) {
      var_9 = var_11[var_12];
      var_13 = 0;

      if(isDefined(var_0.ref_1406d) && var_0.ref_1406d.size) {
        for(var_14 = 0; var_14 < var_0.ref_1406d.size; var_14++) {
          if(var_9.modelname == var_0.ref_1406d[var_14].modelname) {
            var_13 = 1;
            break;
          }
        }
      }

      if(!var_13) {
        return var_9;
      }
    }
  }

  return var_9;
}

function ref_127e9() {
  var_0 = scripts\cp_mp\utility\game_utility::getmapname();
  var_1 = "mp/" + var_0 + "_ph.csv";
  var_2 = 0;

  if(tableexists(var_1)) {
    var_2 = tablelookupgetnumrows(var_1);

    for(var_3 = 0; var_3 < var_2; var_3++) {
      var_4 = tablelookupbyrow(var_1, var_3, 0);

      if(var_4 == "prop") {
        var_5 = tablelookupbyrow(var_1, var_3, 1);
        var_6 = tablelookupbyrow(var_1, var_3, 2);
        var_7 = int(tablelookupbyrow(var_1, var_3, 3));
        var_8 = int(tablelookupbyrow(var_1, var_3, 4));
        var_9 = int(tablelookupbyrow(var_1, var_3, 5));
        var_10 = int(tablelookupbyrow(var_1, var_3, 6));
        var_11 = int(tablelookupbyrow(var_1, var_3, 7));
        var_12 = int(tablelookupbyrow(var_1, var_3, 8));
        var_13 = tablelookupbyrow(var_1, var_3, 9);
        var_14 = tablelookupbyrow(var_1, var_3, 10);
        var_15 = tablelookupbyrow(var_1, var_3, 11);

        if(var_15 == "") {
          var_15 = "any";
        }

        var_16 = undefined;

        if(isDefined(var_7) && isDefined(var_8) && isDefined(var_9)) {
          var_16 = (var_7, var_8, var_9);
        }

        var_17 = undefined;

        if(isDefined(var_10) && isDefined(var_11) && isDefined(var_12)) {
          var_17 = (var_10, var_11, var_12);
        }

        var_18 = revive_vo_time(var_6);

        if(!isDefined(var_13) || var_13 == "") {
          var_13 = run_global_functions_for_relics(var_18);
        } else {
          var_13 = int(var_13);
        }

        if(!isDefined(var_14) || var_14 == "") {
          var_14 = run_guards_spawner(var_18);
        } else {
          var_14 = int(var_14);
        }

        battletracksidstandingonvehicle(var_5, var_18, var_16, var_17, var_6, var_13, var_14, var_15);
        continue;
      }

      if(var_4 == "loc") {
        var_15 = tablelookupbyrow(var_1, var_3, 11);
        var_19 = int(tablelookupbyrow(var_1, var_3, 12));
        var_20 = int(tablelookupbyrow(var_1, var_3, 13));
        var_21 = int(tablelookupbyrow(var_1, var_3, 14));
        timeoutplunderextractionsites(var_15, var_19, var_20, var_21);
      }
    }
  }

  if(var_2 == 0) {
    battletracksidstandingonvehicle("tag_origin", 250, (0, 0, 0), (0, 0, 0), "medium", run_global_functions_for_relics(250), run_guards_spawner(250), "any");
  }

  ref_1213e();
}

function ref_13266() {
  var_0 = self.ref_128f4;

  if(!isDefined(var_0)) {
    var_0 = reset_search_spot_light_nodes(self);
  }

  self.ref_128d7 = spawn("script_model", self.origin);
  self.ref_128d7.targetname = "propAnchor";
  self.ref_128d7 linkTo(self);
  self.ref_128ea = spawn("script_model", self.origin);
  self.ref_128ea setModel("generic_prop_raven_x3");
  self.ref_128ea.targetname = "propEnt";
  self.ref_128ea linkTo(self.ref_128d7);
  self.prop = spawn("script_model", self.ref_128ea.origin);
  self.prop.targetname = "prop";
  self.prop setModel(var_0.modelname);
  self.prop setCanDamage(1);
  self.prop.ref_1467e = var_0.ref_1467e;
  self.prop.building_roof_chopper_reenforce = var_0.building_roof_chopper_reenforce;
  self.prop.angles = self.angles;
  calculateobjectivesheld();
  cache1_defender_after_spawn();
  self.prop linkTo(self.ref_128ea, "J_prop_1");
  self.prop.owner = self;
  self.prop.health = 10000;
  self.ref_128ea scriptmodelplayanim("prop_hunt_prop_spin", "propSpinAnim", undefined, 1.5);
  self.ref_128ea scriptmodelpauseanim(1);
  self.ref_13b30 = var_0.ref_12905;
  self.ref_13b2f = var_0.ref_128f1;
  self setcamerathirdperson(1, self.ref_13b30, self.ref_13b2f);
  ref_12680(1);
  self.prop.info = var_0;
  self.ref_128f4 = var_0;

  if(!isDefined(self.ref_13640)) {
    self.ref_1406d = [];
  }

  self.maxhealth = revive_stim(var_0);
  self.health = self.maxhealth;
}

function ref_12680(var_0) {}

function revive_stim(var_0) {
  return int(var_0.ref_1290d);
}

function revive_vo_time(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "xsmall":
      var_1 = 50;
      break;
    case "small":
      var_1 = 100;
      break;
    case "medium":
      var_1 = 250;
      break;
    case "large":
      var_1 = 450;
      break;
    case "xlarge":
      var_1 = 550;
      break;
    default:
      var_2 = scripts\cp_mp\utility\game_utility::getmapname();
      var_3 = "mp/" + var_2 + "_ph.csv";
      var_1 = 100;
      break;
  }

  return var_1;
}

function battletracksidstandingonvehicle(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(level.ref_12315.ref_128f7[var_7])) {
    level.ref_12315.ref_128f7[var_7] = [];
  }

  if(!isDefined(level.ref_12315.ref_128f7[var_7][var_1])) {
    level.ref_12315.ref_128f7[var_7][var_1] = [];
  }

  var_8 = spawnStruct();
  var_8.modelname = var_0;
  var_8.ref_1290d = int(var_1);
  var_8.ref_1290e = var_4;
  var_8.location = var_7;

  if(isDefined(var_2)) {
    var_8.ref_1467e = var_2;
  }

  if(isDefined(var_3)) {
    var_8.building_roof_chopper_reenforce = var_3;
  }

  var_8.ref_12905 = var_6;
  var_8.ref_128f1 = var_5;
  var_10 = level.ref_12315.ref_128f7[var_7][var_1].size;
  level.ref_12315.ref_128f7[var_7][var_1][var_10] = var_8;
}

function ref_12317(var_0, var_1) {
  if(istrue(level.need_respawn)) {
    return;
  }

  level.need_respawn = 1;
  ref_12319(var_0);
  thread scripts\mp\gamelogic::endgame(var_0, var_1);
  thread scriptgoalyaw(level);
}

function ref_12319(var_0) {
  level.finalkillcam_winner = var_0;

  if(level.finalkillcam_winner == game["defenders"]) {
    level.ref_133cf = 1;
    return;
  }
}

function scriptgoalyaw(var_0) {
  level endon("game_ended");
  var_1 = game["roundsWon"][var_0] + 1;
  setteamscore(var_0, var_1);
}

function ref_13198() {
  level endon("game_ended");
  var_0 = game["roundsWon"][game["defenders"]];
  var_1 = game["roundsWon"][game["attackers"]];
  setteamscore(game["defenders"], var_0);
  setteamscore(game["attackers"], var_1);
}

function ononeleftevent(var_0) {
  if(istrue(level.gameended)) {
    return;
  }

  if(var_0 == game["attackers"]) {
    return;
  }

  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(isDefined(var_0) && var_3.team != var_0) {
      continue;
    }

    if(!scripts\mp\utility\player::isreallyalive(var_3) && !var_3 scripts\mp\playerlogic::mayspawn()) {
      continue;
    }

    if(isDefined(var_1)) {
      return;
    }

    var_1 = var_3;
  }

  if(!isDefined(var_1)) {
    return;
  }

  thread givelastonteamwarning();
}

function givelastonteamwarning() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\player::waittillrecoveredhealth(3);
  var_0 = scripts\mp\utility\game::getotherteam(self.pers["team"]);
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastenemyalive", self, var_0);

  if(ref_125f0()) {
    level notify("noPropsToSpectate");
    level.ref_11eb9 = 1;
  }

  level notify("last_alive", self);
}

function ontimelimit() {
  if(!istrue(level.playerzombiethermal)) {
    var_0 = scripts\mp\utility\game::gettimepassed();
    game["propSurvivalTime"][game["defenders"]] = game["propSurvivalTime"][game["defenders"]] + var_0;
    game["hunterKillTime"][game["attackers"]] = game["hunterKillTime"][game["attackers"]] + var_0;
    give_and_switch_to_primary_weapon();
    ref_12317(game["defenders"], game["end_reason"]["time_limit_reached"]);
    return;
  }
}

function give_and_switch_to_primary_weapon() {
  var_0 = removematchingents_byclassname(game["defenders"]);

  if(var_0.size < 1) {
    return;
  }

  var_1 = removematchingents_byclassname(game["attackers"]);

  if(var_1.size < 1) {
    return;
  }

  var_2 = getweaponvariantids(var_0, var_1);

  if(scripts\mp\utility\entity::isgameparticipant(var_2)) {
    var_3 = var_2 getentitynumber();
  } else {
    var_3 = -1;
  }

  var_4 = var_2[0];
  var_4.deathtime = gettime() - 1000;
  scripts\mp\final_killcam::recordfinalkillcam(5, var_4, var_3, var_3, -1, 0, "none", 0, 0, "none", "normal", 0);
}

function getweaponvariantids(var_0, var_1) {
  var_2 = undefined;
  var_3 = 1073741824;

  foreach(var_5 in var_0) {
    var_6 = undefined;
    var_7 = 1073741824;

    foreach(var_9 in var_1) {
      var_10 = getpathdist(var_5.origin, var_9.origin, 999999);

      if(var_10 < var_7) {
        var_7 = var_10;
        var_6 = var_9;
      }
    }

    if(var_7 < var_3) {
      var_3 = var_7;
      var_2 = var_5;
    }
  }

  if(!isDefined(var_2)) {
    var_2 = scripts\engine\utility::random(var_0);
  }

  return var_2;
}

function ref_12316() {
  if(game["roundsWon"]["allies"] == scripts\mp\utility\dvars::getwatcheddvar("winlimit") - 1 && game["roundsWon"]["axis"] == scripts\mp\utility\dvars::getwatcheddvar("winlimit") - 1) {
    return true;
  }

  return false;
}

function ref_125df() {
  scripts\mp\equipment::incrementequipmentammo("equip_concussion");
  scripts\mp\class::loadout_removeperk("specialty_selectivehearing");
}

function scriptcircleat() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self waittill("giveLoadout");

  if(!istrue(self.gulag)) {
    ref_125df();
  }

  self.ref_13b30 = undefined;
  self setcamerathirdperson(0, 0);
  ref_12680(0);
  self allowprone(1);
  self allowsprint(1);
  scripts\mp\weapons::updatemovespeedscale();
  self enableweaponpickup();
  self playershow();
  self.hoopty_initomnvars = 1;
  cdlgametuning();
  thread center_struct();
}

function ref_138a9() {
  level endon("game_ended");
  level.scoreinfo["kill"]["value"] = 300;
  scripts\mp\flags::gameflagwait("props_hide_over");

  for(;;) {
    wait 10;

    foreach(var_1 in level.players) {
      if(!isDefined(var_1.team)) {
        continue;
      }

      if(!ref_125f0(var_1)) {
        continue;
      }

      if(!scripts\mp\utility\player::isreallyalive(var_1)) {
        continue;
      }

      thread scriptablesmax(var_1);

      switch (var_1.prop.info.ref_1290d) {
        case 250:
          thread scriptablesmax(var_1);
          break;
        case 450:
          thread scriptablesmax(var_1);
          break;
        case 550:
          thread scriptablesmax(var_1);
          break;
        default:
          break;
      }
    }
  }
}

function ref_13c62() {
  level endon("game_ended");
  ref_143f0();

  for(;;) {
    foreach(var_1 in level.players) {
      if(!isDefined(var_1.team)) {
        continue;
      }

      if(var_1.team == game["attackers"]) {
        continue;
      }

      if(!scripts\mp\utility\player::isreallyalive(var_1)) {
        continue;
      }

      if(isDefined(var_1.pers["propSeconds"])) {
        var_1.pers["propSeconds"]++;
      }
    }

    wait 1;
  }
}

function gamemodemodifyplayerdamage(var_0) {
  var_1 = var_0.damage;

  if(istrue(self.ref_12913)) {
    self notify("endPropSpectate");

    if(var_0.meansofdeath == "MOD_TRIGGER_HURT") {
      return 0;
    }
  }

  if(isDefined(var_0.victim.team)) {
    if(ref_125f0(var_0.victim)) {
      var_1 = ref_11c99(var_0);
    } else {
      var_1 = ref_11c98(var_0);
    }

    if(var_1 == 0) {
      return 0;
    }
  }

  if(isDefined(var_0.attacker) && isPlayer(var_0.attacker) && isalive(var_0.attacker)) {
    if(!isDefined(var_0.attacker.should_skip_default_intro_scene)) {
      var_0.attacker.should_skip_default_intro_scene = 1;
    }

    if(level.matchrules_damagemultiplier) {
      var_1 *= level.matchrules_damagemultiplier;
    }

    if(level.matchrules_vampirism) {
      var_0.attacker.health = int(min(float(var_0.attacker.maxhealth), float(var_0.attacker.health + 20)));
    }
  }

  return var_1;
}

function ref_11c99(var_0) {
  if(isDefined(var_0.meansofdeath) && var_0.meansofdeath == "MOD_FALLING") {
    return 0;
  }

  return var_0.damage;
}

function ref_11c98(var_0) {
  if(isDefined(var_0.meansofdeath) && var_0.meansofdeath == "MOD_FALLING") {
    return 0;
  }

  if(var_0.objweapon.basename == "concussion_grenade_mp") {
    return 0;
  }

  if(issubstr(var_0.objweapon.basename, "destructible")) {
    return 0;
  }

  return var_0.damage;
}

function cdlgametuning() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    self givemaxammo(var_2);
  }

  var_4 = self getweaponammostock("concussion_grenade_mp");
  var_4 -= self.ref_13b5e;
  var_4 = int(max(var_4, 0));
  self setweaponammostock("concussion_grenade_mp", var_4);

  if(var_4 > 0) {
    thread scripts\mp\gametypes\_prop_controls::ref_144f6();
    return;
  }
}

function center_struct() {
  self endon("death_or_disconnect");
  self notify("attackerRegenAmmo");
  self endon("attackerRegenAmmo");
  level endon("game_ended");

  for(;;) {
    self waittill("reload");
    var_0 = self getcurrentprimaryweapon();
    var_1 = weaponmaxammo(var_0);

    if(self getweaponammostock(var_0) < var_1) {
      self setweaponammostock(var_0, var_1);
    }
  }
}

function getkeypadstatefromomnvar() {
  self endon("disconnect");
  level endon("game_ended");
  wait 0.1;

  if(self.pers["lives"] == 1) {
    self.pers["lives"]--;
    level.zombiejumpbartext[self.team]--;
    scripts\mp\gamelogic::updategameevents();
    level notify("propCountChanged");
    return;
  }
}

function ref_126bf() {
  var_0 = game["attackers"];

  if(self.team == game["attackers"]) {
    var_0 = game["defenders"];
  }

  scripts\mp\menus::addtoteam(var_0);
}

function onplayerkilled(var_0) {
  var_1 = 0;
  level notify("playerCountChanged");

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    ref_126bf();
    return;
  }

  if(!ref_125f0(var_0.victim)) {
    thread ref_12cac();
  } else if(!scripts\mp\flags::gameflag("props_hide_over")) {
    thread ref_12cac();
    return;
  }

  if(isDefined(var_0.attacker) && isPlayer(var_0.attacker) && var_0.attacker != var_0.victim && var_0.victim.team != var_0.attacker.team) {
    var_1 = 1;
  }

  if(var_1) {
    thread ref_12558(var_0.attacker);
  }

  foreach(var_3 in level.players) {
    if(istrue(var_3.ref_12913) && isDefined(var_3.ref_136df) && var_0.victim == var_3.ref_136df) {
      var_3 notify("endPropSpectate");
    }

    if(var_3 != var_0.attacker && ref_125f0(var_3) && isalive(var_3) && ref_125f0(var_0.victim)) {
      thread ref_12558(var_3);
    }
  }
}

function ref_12558(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "still_alive":
      var_1 = &"SPLASHES_PH/SCORE_STILL_ALIVE";
      break;
    case "still_alive_medium_bonus":
      var_1 = &"SPLASHES_PH/SCORE_STILL_ALIVE_MED_BONUS";
      break;
    case "still_alive_large_bonus":
      var_1 = &"SPLASHES_PH/SCORE_STILL_ALIVE_LARGE_BONUS";
      break;
    case "still_alive_extra_large_bonus":
      var_1 = &"SPLASHES_PH/SCORE_STILL_ALIVE_EXTRA_LARGE_BONUS";
      break;
    case "clone_destroyed":
      var_1 = &"SPLASHES_PH/SCORE_DECOY_KILLED";
      break;
    case "clone_was_destroyed":
      var_1 = &"SPLASHES_PH/SCORE_DECOY_WAS_KILLED";
      break;
    case "prop_finalblow":
      var_1 = &"SPLASHES_PH/PROP_FINALBLOW";
      break;
    case "prop_survived":
      var_1 = &"SPLASHES_PH/PROP_SURVIVED";
      break;
    default:
      return;
  }

  self iprintlnbold(var_1);
}

function ref_12cac() {
  thread ref_14384();
}

function ref_14384() {
  self endon("started_spawnPlayer");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    wait 0.05;

    if(isDefined(self) && (self.sessionstate == "spectator" || !scripts\mp\utility\player::isreallyalive(self))) {
      self.pers["lives"] = 1;
      scripts\mp\playerlogic::spawnclient();
      continue;
    }

    return;
  }
}

function ondeadevent(var_0) {
  if(var_0 == game["defenders"]) {
    thread ref_128f6();
    return;
  }
}

function onplayerjointeam(var_0) {
  if(level.teambased) {
    var_0 scripts\mp\gametypes\br::ref_131a8(1);
  }

  if(!ref_125f0(var_0)) {
    if(isDefined(var_0.ref_128f8)) {
      ref_12907(var_0);
      return;
    }

    if(isDefined(var_0.ref_128dd)) {
      ref_12906(var_0);
      return;
    }

    return;
  }
}

function ref_128f6() {
  if(istrue(level.spawnedasspectator)) {
    return;
  }

  if(istrue(level.playerzombiethermal)) {
    return;
  }

  level.spawnedasspectator = 1;
  var_0 = scripts\mp\utility\game::gettimepassed();
  game["propSurvivalTime"][game["defenders"]] = game["propSurvivalTime"][game["defenders"]] + var_0;
  game["hunterKillTime"][game["attackers"]] = game["hunterKillTime"][game["attackers"]] + var_0;
  level.playerzombiethermal = 1;
  wait 3;
  thread ref_12317(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
}

function ref_1245e(var_0, var_1, var_2) {
  if(var_1 == "MOD_EXECUTION") {
    return;
  }

  if(ref_125f0()) {
    return;
  }

  var_3 = randomintrange(1, 8);
  var_4 = "generic";

  if(scripts\mp\utility\player::isfemale()) {
    var_4 = "female";
  }

  if(var_1 == "MOD_FALLING" || var_1 == "MOD_SUICIDE" && isPlayer(self)) {
    if(self.team == "axis") {
      scripts\mp\utility\sound::playplayerandnpcsounds(self, "plr_death_explosion", var_4 + "_death_russian_" + var_3);
      return;
    }

    scripts\mp\utility\sound::playplayerandnpcsounds(self, "plr_death_explosion", var_4 + "_death_american_" + var_3);
    return;
  }

  if(isPlayer(self)) {
    if(self.team == "axis") {
      scripts\mp\utility\sound::playplayerandnpcsounds(self, "plr_death_generic", var_4 + "_death_russian_" + var_3);
      return;
    }

    scripts\mp\utility\sound::playplayerandnpcsounds(self, "plr_death_generic", var_4 + "_death_american_" + var_3);
    return;
  }

  if(self.team == "axis") {
    self playSound(var_4 + "_death_russian_" + var_3);
    return;
  }

  self playSound(var_4 + "_death_american_" + var_3);
}

function playoverwatch_dialogue_with_endon(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_3) && isDefined(level.ref_12916)) {
    if(level.ref_12916 == "kills") {
      self setclientomnvar("ui_round_end_reason", game["end_reason"]["prop_tiebreaker_kills"]);
      self setclientomnvar("ui_round_end_friendly_score", game["propScore"][var_4]);
      self setclientomnvar("ui_round_end_enemy_score", game["propScore"][level.otherteam[var_4]]);
    } else if(level.ref_12916 == "time") {
      var_5 = game["hunterKillTime"][var_4] / 1000;
      var_6 = game["hunterKillTime"][level.otherteam[var_4]] / 1000;
      var_7 = int(scripts\engine\math::round_float(var_5));
      var_8 = int(scripts\engine\math::round_float(var_6));

      if(var_7 == var_8) {
        if(var_5 > var_6) {
          var_7++;
        } else {
          var_8++;
        }
      }

      self setclientomnvar("ui_round_end_reason", game["end_reason"]["prop_tiebreaker_time"]);
      self setclientomnvar("ui_round_end_friendly_score", var_7);
      self setclientomnvar("ui_round_end_enemy_score", var_8);
    }

    return true;
  }

  return false;
}

function ref_126f0() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    var_0 = scripts\engine\utility::ref_143ae("joined_spectators", "spectating_cycle", "death");

    if(var_0 == "death") {
      continue;
    }

    waittillframeend();
    var_1 = self getspectatingplayer();

    if(!isDefined(var_1)) {}
  }
}

function spawn_fake_digit_pool(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  self hudoutlinedisable();

  foreach(var_5 in level.players) {
    if(isDefined(var_2) && var_2 == var_5) {
      continue;
    }

    var_6 = var_5.sessionstate == "spectator";

    if(var_5.team == var_0 && !var_6) {
      self hudoutlineenableforclient(var_5, var_1);
    }

    if(var_3 && (var_5.team == "spectator" || var_6)) {
      self hudoutlineenableforclient(var_5, var_1);
    }
  }
}

function spawn_exfil_techo(var_0, var_1, var_2, var_3) {
  self notify("showToTeam");
  self endon("showToTeam");
  self endon("clear");
  self endon("death");
  self endon("maxDelete");

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  spawn_fake_digit_pool(var_0, var_1, var_2, var_3);

  for(;;) {
    level waittill("add_to_team");
    spawn_fake_digit_pool(var_0, var_1, var_2, var_3);
  }
}

function getrandompointincirclenearby(var_0) {
  foreach(var_2 in level.players) {
    if(ref_125f0(var_2)) {
      if(isDefined(var_2.ref_13665) && isDefined(var_2.ref_13665.spawnpoint) && var_2.ref_13665.spawnpoint == var_0) {
        return false;
      }
    }
  }

  return true;
}

function loadoutdefaultperkdiscount(var_0) {
  if(scripts\mp\flags::gameflag("prematch_done")) {
    return false;
  }

  if(!scripts\mp\utility\game::gamehasstarted()) {
    return false;
  }

  if(ref_125f0(var_0)) {
    return !level.ingraceperiod;
  }

  return false;
}

function ref_125f0() {
  return isDefined(self.team) && self.team == game["defenders"];
}

function ref_1269c(var_0) {
  return ref_125f0() || level.stop_end_breach_fx;
}

function scriptablesmax(var_0) {
  var_1 = scripts\mp\rank::getscoreinfovalue(var_0);
  scripts\mp\rank::giverankxp(var_0, var_1);
  scripts\mp\utility\points::giveunifiedpoints(var_0, undefined, undefined, 1);

  if(isDefined(self.awardsthislife[var_0])) {
    self.awardsthislife[var_0]++;
  } else {
    self.awardsthislife[var_0] = 1;
  }

  ref_12558(var_0);
}

function ref_1263d() {
  if(ref_125f0()) {
    ref_126bf();
    return;
  }
}

function ref_12604() {
  ref_12321();
  self.prevweaponobj = undefined;
  var_0 = scripts\mp\class::loadout_getclassstruct();
  var_0 = scripts\mp\class::loadout_updateclass(var_0, "gamemode");
  scripts\mp\class::preloadandqueueclassstruct(var_0, 1, 1);
  self takeallweapons();
  scripts\mp\class::giveloadout(self.team, "gamemode", 1, 1);
  self givestartammo(var_0.loadoutprimaryobject);
  self givestartammo(var_0.loadoutsecondaryobject);
  scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
  scripts\mp\gametypes\br_weapons::br_ammo_give_type(self, "brloot_ammo_762", 200, 0);
  scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);
  self notify("ammo_update");
  ref_125df();
}

function vehicle_occupancy_mp_onentervehicle(var_0, var_1, var_2, var_3) {
  scripts\mp\vehicles\vehicle_occupancy_mp::vehicle_occupancy_mp_onentervehicle(var_0, var_1, var_2, var_3);

  if(ref_125f0(var_2)) {
    var_2 setcamerathirdperson(0);
    return;
  }
}

function vehicle_occupancy_mp_onexitvehicle(var_0, var_1, var_2, var_3) {
  scripts\mp\vehicles\vehicle_occupancy_mp::vehicle_occupancy_mp_onexitvehicle(var_0, var_1, var_2, var_3);

  if(!istrue(var_3.playerdisconnect) && !istrue(var_3.playerdeath) && ref_125f0(var_2)) {
    var_2 setcamerathirdperson(1, var_2.ref_13b30, var_2.ref_13b2f);
    return;
  }
}

function droponplayerdeath(var_0) {
  if(istrue(level.usegulag) && scripts\mp\gametypes\br_public::isplayeringulag()) {
    return true;
  }

  if(ref_125f0()) {
    return true;
  }

  return false;
}

function remove_on_death() {
  var_0 = scripts\engine\utility::array_randomize(level.players);
  var_1 = level.ref_12315.settings.ref_11f3d;

  if(level.players.size < var_1) {
    var_1 = 1;
  }

  var_2 = 0;
  var_3 = [];
  var_4 = [];

  foreach(var_6 in var_0) {
    if(var_2 < var_1) {
      var_3 = var_6;
    } else {
      var_4 = var_6;
    }

    var_2++;
  }

  thread ref_13253(var_3);
  thread ref_13267(var_4);
  return var_3;
}

function ref_12562() {
  self endon("disconnect");
  self notify("death_or_disconnect");
  self notify("death");
  waittillframeend();
  scripts\mp\gametypes\br_infils::stop_player_trigger_monitor();
}

function ref_13253(var_0) {
  if(!istrue(level.br_infils_disabled)) {
    scripts\mp\flags::gameflagwait("prematch_fade_done");
    waitframe();
  }

  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }

    if(ref_125f0(var_2)) {
      ref_126bf(var_2);
      ref_12321(var_2);
      var_2.forcespawnorigin = var_2.origin;
      var_2.forcespawnangles = var_2.angles;
      thread ref_12562();
    }

    if(istrue(level.br_infils_disabled)) {
      var_2 scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
      var_2 scripts\mp\gametypes\br_weapons::br_ammo_give_type(var_2, "brloot_ammo_762", 200, 0);
      scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(var_2);
      var_2 notify("ammo_update");
    }
  }
}

function revive_txt_hint() {
  if(!isDefined(level.ref_12315.settings.ref_12a08)) {
    level.ref_12315.settings.ref_12a08 = randomint(level.ref_12315.ref_11975.size);
  } else {
    level.ref_12315.settings.ref_12a08 = (level.ref_12315.settings.ref_12a08 + 1) % level.ref_12315.ref_11975.size;
  }

  var_0 = level.ref_12315.ref_11975[level.ref_12315.settings.ref_12a08];
  return var_0;
}

function revive_wounded_in_handler(var_0, var_1) {
  var_2 = 10;
  var_3 = 200;
  var_4 = 100;
  var_5 = 10;
  var_6 = 360 / var_2;
  var_7 = int(var_0 / var_2);
  var_8 = var_0 - var_7 * var_2;
  var_9 = var_8 * var_6 + var_7 * var_5;
  var_10 = var_3 + var_7 * var_4;
  var_11 = (0, var_9, 0);
  var_12 = anglesToForward(var_11);
  var_13 = var_1 + var_12 * var_10;
  var_13 = getgroundposition(var_13, 15, 12000, 12000);
  return var_13;
}

function ref_126c4(var_0) {
  self cancelmantle();
  self setOrigin(var_0, 1);
}

function ref_14362(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }

    var_2 scripts\mp\gametypes\br_infils::neurotoxin_damage_loop();

    if(!ref_125f0(var_2)) {
      ref_126bf(var_2);
      var_2.forcespawnorigin = var_2.ref_1290f;
      thread ref_12562();
    } else if(!isalive(var_2)) {
      var_2.forcespawnorigin = var_2.ref_1290f;
      var_2 scripts\mp\gametypes\br_infils::stop_player_trigger_monitor();
    } else {
      ref_126c4(var_2, var_2.ref_1290f);
      var_2.br_infilstarted = 1;
      var_2 scripts\mp\gametypes\_prop_controls::ref_128da(1);
      var_2 scripts\mp\gametypes\_prop_controls::ref_1290a(int(level.ref_12315.settings.ref_128db));
      var_2 scripts\mp\gametypes\_prop_controls::ref_13177(var_2.initplayerplunderevents);
      var_2 scripts\mp\gametypes\_prop_controls::ref_13177("CLONE");
    }

    var_2 notify("beginC130");
  }
}

function ref_13267(var_0) {
  var_1 = revive_txt_hint();
  var_2 = 0;

  foreach(var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_4 scripts\mp\utility\player::hidehudenable();
    var_5 = revive_wounded_in_handler(var_2, var_1.origin);
    var_4.ref_1290f = var_5;
    var_2++;

    if(var_2 >= level.ref_12315.settings.ref_11f42) {
      var_1 = revive_txt_hint();
      var_2 = 0;
    }
  }

  var_7 = 1;
  var_8 = 1.5;
  var_9 = 1;
  thread scripts\mp\gametypes\br_infils::infilallfadetoblack(var_7, var_8, var_9, "prop_respawn_finished", var_0, 1);

  foreach(var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_4 predictstreampos(var_4.ref_1290f, 1);
  }

  wait var_7;
  waitframe();
  handleriotshielddamage();
  ref_14362(var_0);
  level notify("prop_respawn_finished");
  wait var_8;

  foreach(var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_4 clearpredictedstreampos();
    var_4 scripts\mp\gametypes\br_infils::neurotoxin_damage_loop();

    if(scripts\mp\gametypes\br::get_int_or_0(var_4.hidehudenabled) > 0) {
      var_4 scripts\mp\utility\player::hidehuddisable();
    }

    var_4.delay_explosion_fx = 1;
  }

  scripts\mp\flags::gameflagset("props_hide_start");
}

function timeoutplunderextractionsites(var_0, var_1, var_2, var_3) {
  var_4 = getmaxobjectivecount(var_1, var_2, var_3);
  var_4 setmapcirclecolorindex(4);
  var_4 hide(1);
  var_4.inuse = 0;
  var_4.count = 0;
  var_4.name = var_0;
  var_4.radius = var_3;
  var_4.ref_129e5 = var_3 * var_3;
  var_5 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  var_4.objectiveiconid = var_5;

  if(var_5 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_5, "active", (0, 0, 0), "ui_mp_br_compass_icon_quest_assassin");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_5, 1);
    objective_showtoplayersinmask(var_5);
    scripts\mp\objidpoolmanager::update_objective_position(var_5, (var_1, var_2, 0));
  }

  level.ref_12315.ref_11975[level.ref_12315.ref_11975.size] = var_4;
}

function toma_strike() {
  level.ref_12315.ref_128de = [];
  var_0 = level.maxteamsize - level.ref_12315.settings.ref_11f3d;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    level.ref_12315.ref_128de[var_1] = getmaxobjectivecount(0, 0, 500);
    level.ref_12315.ref_128de[var_1] setmapcirclecolorindex(1);
    level.ref_12315.ref_128de[var_1] hide(1);
    level.ref_12315.ref_128de[var_1].inuse = 0;
    level.ref_12315.ref_128de[var_1].count = 0;
    level.ref_12315.ref_128de[var_1].radius = 500;
    level.ref_12315.ref_128de[var_1].ref_129e5 = 250000;
  }
}

function ref_1386d() {
  var_0 = game["defenders"];

  for(;;) {
    jumpiffalse(level.teamdata[var_0]["players"].size == 0) LOC_00000021;
    waitframe();
  }

  for(;;) {
    var_1 = level.teamdata[var_0]["players"];

    if(isDefined(level.ref_12315.payload)) {
      var_1 = level.ref_12315.payload;
    }

    foreach(var_3 in var_1) {
      if(isDefined(var_3.ref_128f8)) {
        var_4 = level.ref_12315.ref_11975[var_3.ref_128f8];
        var_5 = distance2dsquared(var_4.origin, var_3.origin);

        if(var_5 <= var_4.ref_129e5) {
          continue;
        } else {
          ref_12907(var_3);
        }
      } else if(isDefined(var_3.ref_128dd)) {
        var_6 = level.ref_12315.ref_128de[var_3.ref_128dd];
        var_5 = distance2dsquared(var_6.origin, var_3.origin);

        if(var_5 > var_6.ref_129e5) {
          ref_12906(var_3);
        }
      }

      var_7 = undefined;
      var_8 = undefined;

      for(var_9 = 0; var_9 < level.ref_12315.ref_11975.size; var_9++) {
        var_4 = level.ref_12315.ref_11975[var_9];
        var_5 = distance2dsquared(var_4.origin, var_3.origin);

        if(var_5 <= var_4.ref_129e5 && (!isDefined(var_8) || var_5 < var_8)) {
          var_8 = var_5;
          var_7 = var_9;
        }
      }

      if(isDefined(var_7)) {
        if(isDefined(var_3.ref_128dd)) {
          ref_12906(var_3);
        }

        ref_128d6(var_3, var_7);
        continue;
      }

      if(!isDefined(var_3.ref_128dd)) {
        ref_128d5(var_3);
      }
    }

    waitframe();
  }
}

function ref_128ec() {
  if(isDefined(self.ref_128f8)) {
    return level.ref_12315.ref_11975[self.ref_128f8].name;
  }

  return "any";
}

function ref_128d6(var_0) {
  self.ref_128f8 = var_0;
  var_1 = level.ref_12315.ref_11975[var_0];
  var_1.count++;

  if(var_1.count == 1) {
    var_1.inuse = 1;
    var_1 show();
    scripts\mp\objidpoolmanager::update_objective_ownerteam(var_1.objectiveiconid, game["defenders"]);
    return;
  }
}

function ref_12907() {
  var_0 = self.ref_128f8;
  var_1 = level.ref_12315.ref_11975[var_0];
  var_1.count--;

  if(var_1.count == 0) {
    var_1.inuse = 0;
    var_1 hide(1);
    scripts\mp\objidpoolmanager::update_objective_ownerteam(var_1.objectiveiconid, undefined);
  }

  self.ref_128f8 = undefined;
}

function ref_128d5() {
  var_0 = reset_motionblur();
  self.ref_128dd = var_0;
  var_1 = level.ref_12315.ref_128de[var_0];
  var_1.count++;

  if(var_1.count == 1) {
    var_1.inuse = 1;
    var_1 show();
    var_1.ref_129e5 = 250000;
  }

  var_2 = (self.origin[0], self.origin[1], 500);
  var_2 += scripts\engine\math::random_vector_2d() * randomfloatrange(0, 500);
  var_1.origin = var_2;
}

function reset_motionblur() {
  for(var_0 = 0; var_0 < level.ref_12315.ref_128de.size; var_0++) {
    var_1 = level.ref_12315.ref_128de[var_0];

    if(!var_1.inuse) {
      return var_0;
    }
  }
}

function ref_12906() {
  var_0 = self.ref_128dd;
  var_1 = level.ref_12315.ref_128de[var_0];
  var_1.count--;

  if(var_1.count == 0) {
    var_1.inuse = 0;
    var_1 hide(1);
  }

  self.ref_128dd = undefined;
}