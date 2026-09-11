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

function onplayerconnect(var0) {
  if(!isDefined(var0.pers["propSeconds"])) {
    var0.pers["propSeconds"] = 0;
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
      var0 = game["attackers"];
      var1 = game["defenders"];
      game["attackers"] = var1;
      game["defenders"] = var0;
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
    var2 = game["roundsPlayed"] % 4 == 2 || game["roundsPlayed"] % 4 == 3;

    if(var2) {
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

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  ref_128ed(var1.pers["team"]);

  if(game["state"] == "postgame" && game["teamScores"][var1.team] > game["teamScores"][level.otherteam[var1.team]]) {
    var1.finalkill = 1;
    return;
  }
}

function onsuicidedeath(var0) {
  if(var0 scripts\mp\playerlogic::mayspawn()) {
    return;
  }

  var1 = scripts\mp\utility\game::getotherteam(var0.pers["team"]);

  foreach(var3 in var1) {
    ref_128ed(var3);
  }
}

function ref_128ed(var0) {
  if(var0 != game["attackers"]) {
    return;
  }

  level scripts\mp\gamescore::giveteamscoreforobjective(var0, 1, 1);
  game["propScore"][var0] = game["propScore"][var0] + 1;
}

function remapattachmentparentname(var0, var1) {
  if(!isstring(var0)) {
    return var0;
  }

  var2 = var0;

  if(level.gameended) {
    var3 = "roundsWon";

    if(isDefined(level.ref_145c0) && level.ref_145c0) {
      var3 = "teamScores";
    }

    level.ref_12916 = "none";

    if(game[var3]["allies"] == game[var3]["axis"]) {
      level.ref_12916 = "kills";

      if(game["propScore"]["axis"] == game["propScore"]["allies"]) {
        level.ref_12916 = "time";

        if(game["hunterKillTime"]["axis"] == game["hunterKillTime"]["allies"]) {
          level.ref_12916 = "tie";
          var2 = "tie";
        } else if(game["hunterKillTime"]["axis"] < game["hunterKillTime"]["allies"]) {
          var2 = "axis";
        } else {
          var2 = "allies";
        }
      } else if(game["propScore"]["axis"] > game["propScore"]["allies"]) {
        var2 = "axis";
      } else {
        var2 = "allies";
      }

      if(var2 != "tie") {
        thread scriptgoalyaw(level);
      }
    } else if(game[var3]["axis"] > game[var3]["allies"]) {
      var2 = "axis";
    } else {
      var2 = "allies";
    }
  }

  if(var1 && (var2 == "allies" || var2 == "axis")) {
    ref_12319(var2);
  }

  return var2;
}

function relic_squadlink_modifyplayerdamage() {
  var0 = [];
  GscBinSkip0(0x2e, "loadoutArchetype", "archetype_assault");
}

function setspecialloadouts() {
  var0 = game["defenders"];
  level.ref_12318[var0] = relic_squadlink_modifyplayerdamage();
  var1 = game["attackers"];
  level.ref_12318[var1] = relic_squadlink_modifyplayerdamage();
  level.ref_12318[var1]["loadoutPrimary"] = "iw8_ar_akilo47";
  level.ref_12318[var1]["loadoutPrimaryAttachment"] = "xmags";
  level.ref_12318[var1]["loadoutPrimaryAttachment2"] = "laser";
  level.ref_12318[var1]["loadoutSecondary"] = "iw8_pi_mike1911";
  level.ref_12318[var1]["loadoutEquipmentSecondary"] = "equip_concussion";
  level.ref_12318[var1]["loadoutPerks"] = ["specialty_restock", "specialty_hustle"];
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

function ref_145b9(var0) {
  level notify("whistle_start_timer_beginning");
  var1 = int(var0);

  if(var1 >= 0) {
    thread ref_145ba(var1);
    return;
  }
}

function ref_145ba(var0) {
  level endon("whistle_start_timer_beginning");
  waittillframeend();

  while(var0 > 0 && !level.gameended) {
    setomnvar("ui_ph_whistle_countdown", var0);
    var0--;
    wait 1;
  }

  setomnvar("ui_ph_whistle_countdown", var0);
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

function init_trap_room_obj(var0, var1) {
  var2 = newhudelem();
  var2.elemtype = "font";
  var2.font = var0;
  var2.fontscale = var1;
  var2.basefontscale = var1;
  var2.x = 0;
  var2.y = 0;
  var2.width = 0;
  var2.height = int(level.fontheight * var1);
  var2.xoffset = 0;
  var2.yoffset = 0;
  var2.children = [];
  var2 scripts\mp\hud_util::setparent(level.uiparent);
  var2.hidden = 0;
  var2.archived = 0;
  return var2;
}

function monitor_truck_stuck() {
  level endon("game_ended");

  for(;;) {
    var0 = prematchspawnoriginteamcount(game["defenders"]);
    level.monitor_player_plundercount setvalue(var0.size);
    level scripts\engine\utility::ref_143a8("player_spawned", "playerCountChanged", "propCountChanged", "playerDisconnected");
  }
}

function prematchspawnoriginteamcount(var0) {
  var1 = [];

  foreach(var3 in level.players) {
    if(isDefined(var3) && isalive(var3) && (!isDefined(var3.sessionstate) || var3.sessionstate == "playing")) {
      if(!isDefined(var0) || var3.team == var0) {
        var1 = var3;
      }
    }
  }

  return var1;
}

function onplayerdisconnect(var0) {
  level notify("playerDisconnected");

  if(isDefined(var0.ref_128f8)) {
    ref_12907(var0);
    return;
  }

  if(isDefined(var0.ref_128dd)) {
    ref_12906(var0);
    return;
  }
}

function vehomn_fadeoutcontrolsforclient(var0, var1) {
  if(isbot(var0)) {
    return;
  }

  kick(var0 getentitynumber(), var1);
}

function ref_145a4() {
  var0 = scripts\engine\utility::ref_143af("weapon_fired", "sprint_begin", "specialGrenade", "end_weapon_check_usage");

  if(var0 == "end_weapon_check_usage") {
    if(istrue(self.should_skip_default_intro_scene)) {
      return true;
    }

    vehomn_fadeoutcontrolsforclient(self, "EXE_PLAYERKICKED_INACTIVE");
    return false;
  }

  return true;
}

function ref_127ee(var0, var1) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!isDefined(var0)) {
    var0 = 45;
  }

  if(!isDefined(var1)) {
    var1 = 300;
  }

  var2 = self.origin;
  var3 = squared(var1);
  var4 = 0;

  for(var5 = 0; var5 < var0; var5++) {
    if(!var4) {
      var6 = distancesquared(var2, self.origin);

      if(var6 >= var3) {
        var4 = 1;
      }
    }

    wait 1;
  }

  if(var4) {
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
    var0 = int(level.ref_12315.settings.ref_128db);
    var1 = undefined;
    var2 = undefined;

    if(isDefined(self.ref_13640) && isDefined(self.getbrplayersnoteliminated)) {
      var0 = self.getbrplayersnoteliminated;
      var1 = self.armor_target_vo;
      var2 = self.heli_boss_shoot;
    }

    scripts\mp\gametypes\_prop_controls::ref_1290a(var0);
    scripts\mp\gametypes\_prop_controls::ref_13177(self.initplayerplunderevents, var1);
    scripts\mp\gametypes\_prop_controls::ref_13177("CLONE", var2);
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
    var3 = 1;

    if(var3 && !isDefined(self.manageafktracking)) {
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

function run_guards_spawner(var0) {
  switch (var0) {
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

function run_global_functions_for_relics(var0) {
  switch (var0) {
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
  var0 = anglesToForward(self.prop.angles) * self.prop.ref_1467e[0];
  var1 = anglestoright(self.prop.angles) * self.prop.ref_1467e[1];
  var2 = anglestoup(self.prop.angles) * self.prop.ref_1467e[2];
  self.prop.origin += var0;
  self.prop.origin += var1;
  self.prop.origin += var2;
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
  var0 = 0;

  if(isDefined(level.br_level) && isDefined(level.br_level.default_class_chosen)) {
    for(var1 = 0; var1 < level.br_level.br_circledelaytimes.size; var1++) {
      var2 = level.br_level.br_circledelaytimes[var1];
      var3 = level.br_level.br_circleclosetimes[var1];
      var0 = var0 + var2 + var3;
    }

    var0 *= 1000;
    var4 = gettime() - level.ref_12315.settings.ref_145b8;
    var0 -= var4;

    if(var0 < 0) {
      var0 = 0;
    }
  }

  return int(var0);
}

function ref_12923() {
  level endon("game_ended");
  level.ref_12315.settings.ref_145b8 = gettime();
  var0 = gettime();
  var1 = level.ref_12315.settings.ref_12924 * 1000;
  var2 = 20000;
  var3 = var2;
  var4 = 500;
  var5 = 5000;
  var6 = 0;
  var7 = getEntArray("minimap_corner", "targetname")[0].origin;
  wait level.ref_12315.settings.ref_12924;

  if(!ref_1408e()) {
    setomnvar("ui_war_active_sector", 0);
  }

  for(;;) {
    if(var0 + var1 - var4 < gettime()) {
      var6++;
      var8 = sortbydistance(level.players, var7);

      foreach(var10 in var8) {
        if(!isDefined(var10)) {
          continue;
        }

        if(ref_1408e()) {
          level.ref_12315.ref_145bb.alpha = 0;
          level.ref_145bc.alpha = 0.6;
        }

        if(ref_125f0(var10) && isalive(var10)) {
          if(ref_1408e()) {
            level.ref_145bc.alpha = 1;
            level.ref_145bc fadeovertime(0.75);
            level.ref_145bc.alpha = 0.6;
          }

          playsoundatpos(var10.origin + (0, 0, 60), "prop_whistle");
          wait 1.5;
        }
      }

      if(!ref_1408e()) {
        setomnvar("ui_war_active_sector", 2);
      }

      var0 = gettime();

      if(var6 % 2 == 0) {
        var1 = max(var1 - 5000, var2);
      }

      if(var3 >= gettimeremaining() - var5) {
        if(ref_1408e()) {
          level.ref_145bc.alpha = 0;
        }

        return;
      } else {
        if(var3 * 2 + getteamplayersalive(game["defenders"]) * 2500 >= gettimeremaining() - var5) {
          if(ref_1408e()) {
            level.ref_12315.ref_145bb.label = &"MP_PH/FINAL_WHISTLE";
          } else {
            setomnvar("ui_war_active_sector", 1);
          }

          var3 += getteamplayersalive(game["defenders"]) * 2500;
        }

        if(ref_1408e()) {
          level.ref_12315.ref_145bb settimer(int(var1 / 1000));
        } else {
          ref_145b9(int(var1 / 1000));
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

function removematchingents_byclassname(var0) {
  var1 = [];

  foreach(var3 in level.participants) {
    if(!isDefined(var3.team)) {
      continue;
    }

    if(scripts\mp\utility\player::isreallyalive(var3) && scripts\mp\utility\entity::isteamparticipant(var3) && var3.team == var0) {
      var1 = var3;
    }
  }

  return var1;
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

function damagewatch(var0) {
  if(!isDefined(var0.attacker)) {
    return false;
  }

  if(!isDefined(self.owner)) {
    return false;
  }

  if(isPlayer(var0.attacker)) {
    if(var0.attacker.pers["team"] == self.owner.pers["team"]) {
      return false;
    }

    var0.attacker thread scripts\mp\damagefeedback::updatedamagefeedback("standard");

    if(var0.objweapon.basename == "concussion_grenade_mp") {
      var1 = spawnStruct();
      var1.origin = var0.point;
      self.owner thread scripts\mp\equipment\concussion_grenade::applyconcussion(var1, var0.attacker);

      if(istrue(self.owner.lock)) {
        self.owner scripts\mp\gametypes\_prop_controls::ref_13f1d();
      }
    }
  }

  self.owner dodamage(var0.damage, var0.point, var0.attacker, var0.inflictor, var0.meansofdeath, var0.objweapon);
  return false;
}

function ref_128df() {
  thread ref_128e0([self.prop, self.ref_128d7, self.ref_128ea]);
}

function ref_128e0(var0) {
  foreach(var2 in var0) {
    if(isDefined(var2)) {
      var2 unlink();
    }
  }

  waitframe();

  foreach(var2 in var0) {
    if(isDefined(var2)) {
      var2 delete();
    }
  }
}

function ref_12921() {
  level endon("game_ended");
  self endon("disconnect");
  self.iskingofthehillactive = "prop_death";
  self.ref_128e5 = "propDeathFX";
  self waittill("death");
  var0 = self.body;
  playsoundatpos(self.prop.origin + (0, 0, 4), self.iskingofthehillactive);
  playFX(scripts\engine\utility::getfx(self.ref_128e5), self.prop.origin + (0, 0, 4));

  if(isDefined(var0)) {
    var0 delete();
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

  foreach(var1 in level.players) {
    if(istrue(var1.ref_12913) && isDefined(var1.ref_136df) && self == var1.ref_136df) {
      var1 notify("endPropSpectate");
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
    foreach(var1 in self.ref_128e3) {
      if(isDefined(var1)) {
        var1 delete();
      }
    }

    return;
  }
}

function handleriotshielddamage() {
  foreach(var1 in level.players) {
    ref_128e1(var1);
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
  foreach(var5, var1 in level.ref_12315.ref_128f7) {
    if(var5 != "any") {
      foreach(var3 in level.ref_12315.ref_128f7["any"]) {
        level.ref_12315.ref_128f7[var5][var4] = scripts\engine\utility::array_combine(level.ref_12315.ref_128f7[var5][var4], var3);
      }
    }
  }
}

function ref_129f3(var0) {
  var1 = level.ref_12315.ref_128f7[var0];
  var2 = 10 * isDefined(var1[50]);
  var3 = 30 * isDefined(var1[100]);
  var4 = 40 * isDefined(var1[250]);
  var5 = 20 * isDefined(var1[450]);
  var6 = 10 * isDefined(var1[550]);
  var7 = var2 + var3 + var4 + var5 + var6;
  var8 = randomint(var7);

  if(var8 < var2) {
    return 50;
  }

  var8 -= var2;

  if(var8 < var3) {
    return 100;
  }

  var8 -= var3;

  if(var8 < var4) {
    return 250;
  }

  var8 -= var4;

  if(var8 < var5) {
    return 450;
  }

  var8 -= var5;
  return 550;
}

function reset_search_spot_light_nodes(var0) {
  var1 = ref_128ec(var0);
  var2 = level.ref_12315.ref_128f7[var1];
  var3 = ref_129f3(var1);
  var4 = scripts\engine\utility::array_randomize(getarraykeys(var2));
  var5 = [var3];

  foreach(var7 in var4) {
    if(var7 != var3) {
      var5 = var7;
    }
  }

  var9 = undefined;

  for(var10 = 0; var10 < var5.size; var10++) {
    var7 = var5[var10];

    if(!isDefined(var2[var7]) || !var2[var7].size) {
      continue;
    }

    var11 = scripts\engine\utility::array_randomize(var2[var7]);

    for(var12 = 0; var12 < var11.size; var12++) {
      var9 = var11[var12];
      var13 = 0;

      if(isDefined(var0.ref_1406d) && var0.ref_1406d.size) {
        for(var14 = 0; var14 < var0.ref_1406d.size; var14++) {
          if(var9.modelname == var0.ref_1406d[var14].modelname) {
            var13 = 1;
            break;
          }
        }
      }

      if(!var13) {
        return var9;
      }
    }
  }

  return var9;
}

function ref_127e9() {
  var0 = scripts\cp_mp\utility\game_utility::getmapname();
  var1 = "mp/" + var0 + "_ph.csv";
  var2 = 0;

  if(tableexists(var1)) {
    var2 = tablelookupgetnumrows(var1);

    for(var3 = 0; var3 < var2; var3++) {
      var4 = tablelookupbyrow(var1, var3, 0);

      if(var4 == "prop") {
        var5 = tablelookupbyrow(var1, var3, 1);
        var6 = tablelookupbyrow(var1, var3, 2);
        var7 = int(tablelookupbyrow(var1, var3, 3));
        var8 = int(tablelookupbyrow(var1, var3, 4));
        var9 = int(tablelookupbyrow(var1, var3, 5));
        var10 = int(tablelookupbyrow(var1, var3, 6));
        var11 = int(tablelookupbyrow(var1, var3, 7));
        var12 = int(tablelookupbyrow(var1, var3, 8));
        var13 = tablelookupbyrow(var1, var3, 9);
        var14 = tablelookupbyrow(var1, var3, 10);
        var15 = tablelookupbyrow(var1, var3, 11);

        if(var15 == "") {
          var15 = "any";
        }

        var16 = undefined;

        if(isDefined(var7) && isDefined(var8) && isDefined(var9)) {
          var16 = (var7, var8, var9);
        }

        var17 = undefined;

        if(isDefined(var10) && isDefined(var11) && isDefined(var12)) {
          var17 = (var10, var11, var12);
        }

        var18 = revive_vo_time(var6);

        if(!isDefined(var13) || var13 == "") {
          var13 = run_global_functions_for_relics(var18);
        } else {
          var13 = int(var13);
        }

        if(!isDefined(var14) || var14 == "") {
          var14 = run_guards_spawner(var18);
        } else {
          var14 = int(var14);
        }

        battletracksidstandingonvehicle(var5, var18, var16, var17, var6, var13, var14, var15);
        continue;
      }

      if(var4 == "loc") {
        var15 = tablelookupbyrow(var1, var3, 11);
        var19 = int(tablelookupbyrow(var1, var3, 12));
        var20 = int(tablelookupbyrow(var1, var3, 13));
        var21 = int(tablelookupbyrow(var1, var3, 14));
        timeoutplunderextractionsites(var15, var19, var20, var21);
      }
    }
  }

  if(var2 == 0) {
    battletracksidstandingonvehicle("tag_origin", 250, (0, 0, 0), (0, 0, 0), "medium", run_global_functions_for_relics(250), run_guards_spawner(250), "any");
  }

  ref_1213e();
}

function ref_13266() {
  var0 = self.ref_128f4;

  if(!isDefined(var0)) {
    var0 = reset_search_spot_light_nodes(self);
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
  self.prop setModel(var0.modelname);
  self.prop setCanDamage(1);
  self.prop.ref_1467e = var0.ref_1467e;
  self.prop.building_roof_chopper_reenforce = var0.building_roof_chopper_reenforce;
  self.prop.angles = self.angles;
  calculateobjectivesheld();
  cache1_defender_after_spawn();
  self.prop linkTo(self.ref_128ea, "J_prop_1");
  self.prop.owner = self;
  self.prop.health = 10000;
  self.ref_128ea scriptmodelplayanim("prop_hunt_prop_spin", "propSpinAnim", undefined, 1.5);
  self.ref_128ea scriptmodelpauseanim(1);
  self.ref_13b30 = var0.ref_12905;
  self.ref_13b2f = var0.ref_128f1;
  self setcamerathirdperson(1, self.ref_13b30, self.ref_13b2f);
  ref_12680(1);
  self.prop.info = var0;
  self.ref_128f4 = var0;

  if(!isDefined(self.ref_13640)) {
    self.ref_1406d = [];
  }

  self.maxhealth = revive_stim(var0);
  self.health = self.maxhealth;
}

function ref_12680(var0) {}

function revive_stim(var0) {
  return int(var0.ref_1290d);
}

function revive_vo_time(var0) {
  var1 = 0;

  switch (var0) {
    case "xsmall":
      var1 = 50;
      break;
    case "small":
      var1 = 100;
      break;
    case "medium":
      var1 = 250;
      break;
    case "large":
      var1 = 450;
      break;
    case "xlarge":
      var1 = 550;
      break;
    default:
      var2 = scripts\cp_mp\utility\game_utility::getmapname();
      var3 = "mp/" + var2 + "_ph.csv";
      var1 = 100;
      break;
  }

  return var1;
}

function battletracksidstandingonvehicle(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!isDefined(level.ref_12315.ref_128f7[var7])) {
    level.ref_12315.ref_128f7[var7] = [];
  }

  if(!isDefined(level.ref_12315.ref_128f7[var7][var1])) {
    level.ref_12315.ref_128f7[var7][var1] = [];
  }

  var8 = spawnStruct();
  var8.modelname = var0;
  var8.ref_1290d = int(var1);
  var8.ref_1290e = var4;
  var8.location = var7;

  if(isDefined(var2)) {
    var8.ref_1467e = var2;
  }

  if(isDefined(var3)) {
    var8.building_roof_chopper_reenforce = var3;
  }

  var8.ref_12905 = var6;
  var8.ref_128f1 = var5;
  var10 = level.ref_12315.ref_128f7[var7][var1].size;
  level.ref_12315.ref_128f7[var7][var1][var10] = var8;
}

function ref_12317(var0, var1) {
  if(istrue(level.need_respawn)) {
    return;
  }

  level.need_respawn = 1;
  ref_12319(var0);
  thread scripts\mp\gamelogic::endgame(var0, var1);
  thread scriptgoalyaw(level);
}

function ref_12319(var0) {
  level.finalkillcam_winner = var0;

  if(level.finalkillcam_winner == game["defenders"]) {
    level.ref_133cf = 1;
    return;
  }
}

function scriptgoalyaw(var0) {
  level endon("game_ended");
  var1 = game["roundsWon"][var0] + 1;
  setteamscore(var0, var1);
}

function ref_13198() {
  level endon("game_ended");
  var0 = game["roundsWon"][game["defenders"]];
  var1 = game["roundsWon"][game["attackers"]];
  setteamscore(game["defenders"], var0);
  setteamscore(game["attackers"], var1);
}

function ononeleftevent(var0) {
  if(istrue(level.gameended)) {
    return;
  }

  if(var0 == game["attackers"]) {
    return;
  }

  var1 = undefined;

  foreach(var3 in level.players) {
    if(isDefined(var0) && var3.team != var0) {
      continue;
    }

    if(!scripts\mp\utility\player::isreallyalive(var3) && !var3 scripts\mp\playerlogic::mayspawn()) {
      continue;
    }

    if(isDefined(var1)) {
      return;
    }

    var1 = var3;
  }

  if(!isDefined(var1)) {
    return;
  }

  thread givelastonteamwarning();
}

function givelastonteamwarning() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\player::waittillrecoveredhealth(3);
  var0 = scripts\mp\utility\game::getotherteam(self.pers["team"]);
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastenemyalive", self, var0);

  if(ref_125f0()) {
    level notify("noPropsToSpectate");
    level.ref_11eb9 = 1;
  }

  level notify("last_alive", self);
}

function ontimelimit() {
  if(!istrue(level.playerzombiethermal)) {
    var0 = scripts\mp\utility\game::gettimepassed();
    game["propSurvivalTime"][game["defenders"]] = game["propSurvivalTime"][game["defenders"]] + var0;
    game["hunterKillTime"][game["attackers"]] = game["hunterKillTime"][game["attackers"]] + var0;
    give_and_switch_to_primary_weapon();
    ref_12317(game["defenders"], game["end_reason"]["time_limit_reached"]);
    return;
  }
}

function give_and_switch_to_primary_weapon() {
  var0 = removematchingents_byclassname(game["defenders"]);

  if(var0.size < 1) {
    return;
  }

  var1 = removematchingents_byclassname(game["attackers"]);

  if(var1.size < 1) {
    return;
  }

  var2 = getweaponvariantids(var0, var1);

  if(scripts\mp\utility\entity::isgameparticipant(var2)) {
    var3 = var2 getentitynumber();
  } else {
    var3 = -1;
  }

  var4 = var2[0];
  var4.deathtime = gettime() - 1000;
  scripts\mp\final_killcam::recordfinalkillcam(5, var4, var3, var3, -1, 0, "none", 0, 0, "none", "normal", 0);
}

function getweaponvariantids(var0, var1) {
  var2 = undefined;
  var3 = 1073741824;

  foreach(var5 in var0) {
    var6 = undefined;
    var7 = 1073741824;

    foreach(var9 in var1) {
      var10 = getpathdist(var5.origin, var9.origin, 999999);

      if(var10 < var7) {
        var7 = var10;
        var6 = var9;
      }
    }

    if(var7 < var3) {
      var3 = var7;
      var2 = var5;
    }
  }

  if(!isDefined(var2)) {
    var2 = scripts\engine\utility::random(var0);
  }

  return var2;
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

    foreach(var1 in level.players) {
      if(!isDefined(var1.team)) {
        continue;
      }

      if(!ref_125f0(var1)) {
        continue;
      }

      if(!scripts\mp\utility\player::isreallyalive(var1)) {
        continue;
      }

      thread scriptablesmax(var1);

      switch (var1.prop.info.ref_1290d) {
        case 250:
          thread scriptablesmax(var1);
          break;
        case 450:
          thread scriptablesmax(var1);
          break;
        case 550:
          thread scriptablesmax(var1);
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
    foreach(var1 in level.players) {
      if(!isDefined(var1.team)) {
        continue;
      }

      if(var1.team == game["attackers"]) {
        continue;
      }

      if(!scripts\mp\utility\player::isreallyalive(var1)) {
        continue;
      }

      if(isDefined(var1.pers["propSeconds"])) {
        var1.pers["propSeconds"]++;
      }
    }

    wait 1;
  }
}

function gamemodemodifyplayerdamage(var0) {
  var1 = var0.damage;

  if(istrue(self.ref_12913)) {
    self notify("endPropSpectate");

    if(var0.meansofdeath == "MOD_TRIGGER_HURT") {
      return 0;
    }
  }

  if(isDefined(var0.victim.team)) {
    if(ref_125f0(var0.victim)) {
      var1 = ref_11c99(var0);
    } else {
      var1 = ref_11c98(var0);
    }

    if(var1 == 0) {
      return 0;
    }
  }

  if(isDefined(var0.attacker) && isPlayer(var0.attacker) && isalive(var0.attacker)) {
    if(!isDefined(var0.attacker.should_skip_default_intro_scene)) {
      var0.attacker.should_skip_default_intro_scene = 1;
    }

    if(level.matchrules_damagemultiplier) {
      var1 *= level.matchrules_damagemultiplier;
    }

    if(level.matchrules_vampirism) {
      var0.attacker.health = int(min(float(var0.attacker.maxhealth), float(var0.attacker.health + 20)));
    }
  }

  return var1;
}

function ref_11c99(var0) {
  if(isDefined(var0.meansofdeath) && var0.meansofdeath == "MOD_FALLING") {
    return 0;
  }

  return var0.damage;
}

function ref_11c98(var0) {
  if(isDefined(var0.meansofdeath) && var0.meansofdeath == "MOD_FALLING") {
    return 0;
  }

  if(var0.objweapon.basename == "concussion_grenade_mp") {
    return 0;
  }

  if(issubstr(var0.objweapon.basename, "destructible")) {
    return 0;
  }

  return var0.damage;
}

function cdlgametuning() {
  var0 = self getweaponslistprimaries();

  foreach(var2 in var0) {
    self givemaxammo(var2);
  }

  var4 = self getweaponammostock("concussion_grenade_mp");
  var4 -= self.ref_13b5e;
  var4 = int(max(var4, 0));
  self setweaponammostock("concussion_grenade_mp", var4);

  if(var4 > 0) {
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
    var0 = self getcurrentprimaryweapon();
    var1 = weaponmaxammo(var0);

    if(self getweaponammostock(var0) < var1) {
      self setweaponammostock(var0, var1);
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
  var0 = game["attackers"];

  if(self.team == game["attackers"]) {
    var0 = game["defenders"];
  }

  scripts\mp\menus::addtoteam(var0);
}

function onplayerkilled(var0) {
  var1 = 0;
  level notify("playerCountChanged");

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    ref_126bf();
    return;
  }

  if(!ref_125f0(var0.victim)) {
    thread ref_12cac();
  } else if(!scripts\mp\flags::gameflag("props_hide_over")) {
    thread ref_12cac();
    return;
  }

  if(isDefined(var0.attacker) && isPlayer(var0.attacker) && var0.attacker != var0.victim && var0.victim.team != var0.attacker.team) {
    var1 = 1;
  }

  if(var1) {
    thread ref_12558(var0.attacker);
  }

  foreach(var3 in level.players) {
    if(istrue(var3.ref_12913) && isDefined(var3.ref_136df) && var0.victim == var3.ref_136df) {
      var3 notify("endPropSpectate");
    }

    if(var3 != var0.attacker && ref_125f0(var3) && isalive(var3) && ref_125f0(var0.victim)) {
      thread ref_12558(var3);
    }
  }
}

function ref_12558(var0) {
  var1 = undefined;

  switch (var0) {
    case "still_alive":
      var1 = &"SPLASHES_PH/SCORE_STILL_ALIVE";
      break;
    case "still_alive_medium_bonus":
      var1 = &"SPLASHES_PH/SCORE_STILL_ALIVE_MED_BONUS";
      break;
    case "still_alive_large_bonus":
      var1 = &"SPLASHES_PH/SCORE_STILL_ALIVE_LARGE_BONUS";
      break;
    case "still_alive_extra_large_bonus":
      var1 = &"SPLASHES_PH/SCORE_STILL_ALIVE_EXTRA_LARGE_BONUS";
      break;
    case "clone_destroyed":
      var1 = &"SPLASHES_PH/SCORE_DECOY_KILLED";
      break;
    case "clone_was_destroyed":
      var1 = &"SPLASHES_PH/SCORE_DECOY_WAS_KILLED";
      break;
    case "prop_finalblow":
      var1 = &"SPLASHES_PH/PROP_FINALBLOW";
      break;
    case "prop_survived":
      var1 = &"SPLASHES_PH/PROP_SURVIVED";
      break;
    default:
      return;
  }

  self iprintlnbold(var1);
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

function ondeadevent(var0) {
  if(var0 == game["defenders"]) {
    thread ref_128f6();
    return;
  }
}

function onplayerjointeam(var0) {
  if(level.teambased) {
    var0 scripts\mp\gametypes\br::ref_131a8(1);
  }

  if(!ref_125f0(var0)) {
    if(isDefined(var0.ref_128f8)) {
      ref_12907(var0);
      return;
    }

    if(isDefined(var0.ref_128dd)) {
      ref_12906(var0);
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
  var0 = scripts\mp\utility\game::gettimepassed();
  game["propSurvivalTime"][game["defenders"]] = game["propSurvivalTime"][game["defenders"]] + var0;
  game["hunterKillTime"][game["attackers"]] = game["hunterKillTime"][game["attackers"]] + var0;
  level.playerzombiethermal = 1;
  wait 3;
  thread ref_12317(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
}

function ref_1245e(var0, var1, var2) {
  if(var1 == "MOD_EXECUTION") {
    return;
  }

  if(ref_125f0()) {
    return;
  }

  var3 = randomintrange(1, 8);
  var4 = "generic";

  if(scripts\mp\utility\player::isfemale()) {
    var4 = "female";
  }

  if(var1 == "MOD_FALLING" || var1 == "MOD_SUICIDE" && isPlayer(self)) {
    if(self.team == "axis") {
      scripts\mp\utility\sound::playplayerandnpcsounds(self, "plr_death_explosion", var4 + "_death_russian_" + var3);
      return;
    }

    scripts\mp\utility\sound::playplayerandnpcsounds(self, "plr_death_explosion", var4 + "_death_american_" + var3);
    return;
  }

  if(isPlayer(self)) {
    if(self.team == "axis") {
      scripts\mp\utility\sound::playplayerandnpcsounds(self, "plr_death_generic", var4 + "_death_russian_" + var3);
      return;
    }

    scripts\mp\utility\sound::playplayerandnpcsounds(self, "plr_death_generic", var4 + "_death_american_" + var3);
    return;
  }

  if(self.team == "axis") {
    self playSound(var4 + "_death_russian_" + var3);
    return;
  }

  self playSound(var4 + "_death_american_" + var3);
}

function playoverwatch_dialogue_with_endon(var0, var1, var2, var3, var4) {
  if(istrue(var3) && isDefined(level.ref_12916)) {
    if(level.ref_12916 == "kills") {
      self setclientomnvar("ui_round_end_reason", game["end_reason"]["prop_tiebreaker_kills"]);
      self setclientomnvar("ui_round_end_friendly_score", game["propScore"][var4]);
      self setclientomnvar("ui_round_end_enemy_score", game["propScore"][level.otherteam[var4]]);
    } else if(level.ref_12916 == "time") {
      var5 = game["hunterKillTime"][var4] / 1000;
      var6 = game["hunterKillTime"][level.otherteam[var4]] / 1000;
      var7 = int(scripts\engine\math::round_float(var5));
      var8 = int(scripts\engine\math::round_float(var6));

      if(var7 == var8) {
        if(var5 > var6) {
          var7++;
        } else {
          var8++;
        }
      }

      self setclientomnvar("ui_round_end_reason", game["end_reason"]["prop_tiebreaker_time"]);
      self setclientomnvar("ui_round_end_friendly_score", var7);
      self setclientomnvar("ui_round_end_enemy_score", var8);
    }

    return true;
  }

  return false;
}

function ref_126f0() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    var0 = scripts\engine\utility::ref_143ae("joined_spectators", "spectating_cycle", "death");

    if(var0 == "death") {
      continue;
    }

    waittillframeend();
    var1 = self getspectatingplayer();

    if(!isDefined(var1)) {}
  }
}

function spawn_fake_digit_pool(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = 1;
  }

  self hudoutlinedisable();

  foreach(var5 in level.players) {
    if(isDefined(var2) && var2 == var5) {
      continue;
    }

    var6 = var5.sessionstate == "spectator";

    if(var5.team == var0 && !var6) {
      self hudoutlineenableforclient(var5, var1);
    }

    if(var3 && (var5.team == "spectator" || var6)) {
      self hudoutlineenableforclient(var5, var1);
    }
  }
}

function spawn_exfil_techo(var0, var1, var2, var3) {
  self notify("showToTeam");
  self endon("showToTeam");
  self endon("clear");
  self endon("death");
  self endon("maxDelete");

  if(!isDefined(var3)) {
    var3 = 1;
  }

  spawn_fake_digit_pool(var0, var1, var2, var3);

  for(;;) {
    level waittill("add_to_team");
    spawn_fake_digit_pool(var0, var1, var2, var3);
  }
}

function getrandompointincirclenearby(var0) {
  foreach(var2 in level.players) {
    if(ref_125f0(var2)) {
      if(isDefined(var2.ref_13665) && isDefined(var2.ref_13665.spawnpoint) && var2.ref_13665.spawnpoint == var0) {
        return false;
      }
    }
  }

  return true;
}

function loadoutdefaultperkdiscount(var0) {
  if(scripts\mp\flags::gameflag("prematch_done")) {
    return false;
  }

  if(!scripts\mp\utility\game::gamehasstarted()) {
    return false;
  }

  if(ref_125f0(var0)) {
    return !level.ingraceperiod;
  }

  return false;
}

function ref_125f0() {
  return isDefined(self.team) && self.team == game["defenders"];
}

function ref_1269c(var0) {
  return ref_125f0() || level.stop_end_breach_fx;
}

function scriptablesmax(var0) {
  var1 = scripts\mp\rank::getscoreinfovalue(var0);
  scripts\mp\rank::giverankxp(var0, var1);
  scripts\mp\utility\points::giveunifiedpoints(var0, undefined, undefined, 1);

  if(isDefined(self.awardsthislife[var0])) {
    self.awardsthislife[var0]++;
  } else {
    self.awardsthislife[var0] = 1;
  }

  ref_12558(var0);
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
  var0 = scripts\mp\class::loadout_getclassstruct();
  var0 = scripts\mp\class::loadout_updateclass(var0, "gamemode");
  scripts\mp\class::preloadandqueueclassstruct(var0, 1, 1);
  self takeallweapons();
  scripts\mp\class::giveloadout(self.team, "gamemode", 1, 1);
  self givestartammo(var0.loadoutprimaryobject);
  self givestartammo(var0.loadoutsecondaryobject);
  scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
  scripts\mp\gametypes\br_weapons::br_ammo_give_type(self, "brloot_ammo_762", 200, 0);
  scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);
  self notify("ammo_update");
  ref_125df();
}

function vehicle_occupancy_mp_onentervehicle(var0, var1, var2, var3) {
  scripts\mp\vehicles\vehicle_occupancy_mp::vehicle_occupancy_mp_onentervehicle(var0, var1, var2, var3);

  if(ref_125f0(var2)) {
    var2 setcamerathirdperson(0);
    return;
  }
}

function vehicle_occupancy_mp_onexitvehicle(var0, var1, var2, var3) {
  scripts\mp\vehicles\vehicle_occupancy_mp::vehicle_occupancy_mp_onexitvehicle(var0, var1, var2, var3);

  if(!istrue(var3.playerdisconnect) && !istrue(var3.playerdeath) && ref_125f0(var2)) {
    var2 setcamerathirdperson(1, var2.ref_13b30, var2.ref_13b2f);
    return;
  }
}

function droponplayerdeath(var0) {
  if(istrue(level.usegulag) && scripts\mp\gametypes\br_public::isplayeringulag()) {
    return true;
  }

  if(ref_125f0()) {
    return true;
  }

  return false;
}

function remove_on_death() {
  var0 = scripts\engine\utility::array_randomize(level.players);
  var1 = level.ref_12315.settings.ref_11f3d;

  if(level.players.size < var1) {
    var1 = 1;
  }

  var2 = 0;
  var3 = [];
  var4 = [];

  foreach(var6 in var0) {
    if(var2 < var1) {
      var3 = var6;
    } else {
      var4 = var6;
    }

    var2++;
  }

  thread ref_13253(var3);
  thread ref_13267(var4);
  return var3;
}

function ref_12562() {
  self endon("disconnect");
  self notify("death_or_disconnect");
  self notify("death");
  waittillframeend();
  scripts\mp\gametypes\br_infils::stop_player_trigger_monitor();
}

function ref_13253(var0) {
  if(!istrue(level.br_infils_disabled)) {
    scripts\mp\flags::gameflagwait("prematch_fade_done");
    waitframe();
  }

  foreach(var2 in var0) {
    if(!isDefined(var2)) {
      continue;
    }

    if(ref_125f0(var2)) {
      ref_126bf(var2);
      ref_12321(var2);
      var2.forcespawnorigin = var2.origin;
      var2.forcespawnangles = var2.angles;
      thread ref_12562();
    }

    if(istrue(level.br_infils_disabled)) {
      var2 scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
      var2 scripts\mp\gametypes\br_weapons::br_ammo_give_type(var2, "brloot_ammo_762", 200, 0);
      scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(var2);
      var2 notify("ammo_update");
    }
  }
}

function revive_txt_hint() {
  if(!isDefined(level.ref_12315.settings.ref_12a08)) {
    level.ref_12315.settings.ref_12a08 = randomint(level.ref_12315.ref_11975.size);
  } else {
    level.ref_12315.settings.ref_12a08 = (level.ref_12315.settings.ref_12a08 + 1) % level.ref_12315.ref_11975.size;
  }

  var0 = level.ref_12315.ref_11975[level.ref_12315.settings.ref_12a08];
  return var0;
}

function revive_wounded_in_handler(var0, var1) {
  var2 = 10;
  var3 = 200;
  var4 = 100;
  var5 = 10;
  var6 = 360 / var2;
  var7 = int(var0 / var2);
  var8 = var0 - var7 * var2;
  var9 = var8 * var6 + var7 * var5;
  var10 = var3 + var7 * var4;
  var11 = (0, var9, 0);
  var12 = anglesToForward(var11);
  var13 = var1 + var12 * var10;
  var13 = getgroundposition(var13, 15, 12000, 12000);
  return var13;
}

function ref_126c4(var0) {
  self cancelmantle();
  self setOrigin(var0, 1);
}

function ref_14362(var0) {
  foreach(var2 in var0) {
    if(!isDefined(var2)) {
      continue;
    }

    var2 scripts\mp\gametypes\br_infils::neurotoxin_damage_loop();

    if(!ref_125f0(var2)) {
      ref_126bf(var2);
      var2.forcespawnorigin = var2.ref_1290f;
      thread ref_12562();
    } else if(!isalive(var2)) {
      var2.forcespawnorigin = var2.ref_1290f;
      var2 scripts\mp\gametypes\br_infils::stop_player_trigger_monitor();
    } else {
      ref_126c4(var2, var2.ref_1290f);
      var2.br_infilstarted = 1;
      var2 scripts\mp\gametypes\_prop_controls::ref_128da(1);
      var2 scripts\mp\gametypes\_prop_controls::ref_1290a(int(level.ref_12315.settings.ref_128db));
      var2 scripts\mp\gametypes\_prop_controls::ref_13177(var2.initplayerplunderevents);
      var2 scripts\mp\gametypes\_prop_controls::ref_13177("CLONE");
    }

    var2 notify("beginC130");
  }
}

function ref_13267(var0) {
  var1 = revive_txt_hint();
  var2 = 0;

  foreach(var4 in var0) {
    if(!isDefined(var4)) {
      continue;
    }

    var4 scripts\mp\utility\player::hidehudenable();
    var5 = revive_wounded_in_handler(var2, var1.origin);
    var4.ref_1290f = var5;
    var2++;

    if(var2 >= level.ref_12315.settings.ref_11f42) {
      var1 = revive_txt_hint();
      var2 = 0;
    }
  }

  var7 = 1;
  var8 = 1.5;
  var9 = 1;
  thread scripts\mp\gametypes\br_infils::infilallfadetoblack(var7, var8, var9, "prop_respawn_finished", var0, 1);

  foreach(var4 in var0) {
    if(!isDefined(var4)) {
      continue;
    }

    var4 predictstreampos(var4.ref_1290f, 1);
  }

  wait var7;
  waitframe();
  handleriotshielddamage();
  ref_14362(var0);
  level notify("prop_respawn_finished");
  wait var8;

  foreach(var4 in var0) {
    if(!isDefined(var4)) {
      continue;
    }

    var4 clearpredictedstreampos();
    var4 scripts\mp\gametypes\br_infils::neurotoxin_damage_loop();

    if(scripts\mp\gametypes\br::get_int_or_0(var4.hidehudenabled) > 0) {
      var4 scripts\mp\utility\player::hidehuddisable();
    }

    var4.delay_explosion_fx = 1;
  }

  scripts\mp\flags::gameflagset("props_hide_start");
}

function timeoutplunderextractionsites(var0, var1, var2, var3) {
  var4 = getmaxobjectivecount(var1, var2, var3);
  var4 setmapcirclecolorindex(4);
  var4 hide(1);
  var4.inuse = 0;
  var4.count = 0;
  var4.name = var0;
  var4.radius = var3;
  var4.ref_129e5 = var3 * var3;
  var5 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  var4.objectiveiconid = var5;

  if(var5 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var5, "active", (0, 0, 0), "ui_mp_br_compass_icon_quest_assassin");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var5, 1);
    objective_showtoplayersinmask(var5);
    scripts\mp\objidpoolmanager::update_objective_position(var5, (var1, var2, 0));
  }

  level.ref_12315.ref_11975[level.ref_12315.ref_11975.size] = var4;
}

function toma_strike() {
  level.ref_12315.ref_128de = [];
  var0 = level.maxteamsize - level.ref_12315.settings.ref_11f3d;

  for(var1 = 0; var1 < var0; var1++) {
    level.ref_12315.ref_128de[var1] = getmaxobjectivecount(0, 0, 500);
    level.ref_12315.ref_128de[var1] setmapcirclecolorindex(1);
    level.ref_12315.ref_128de[var1] hide(1);
    level.ref_12315.ref_128de[var1].inuse = 0;
    level.ref_12315.ref_128de[var1].count = 0;
    level.ref_12315.ref_128de[var1].radius = 500;
    level.ref_12315.ref_128de[var1].ref_129e5 = 250000;
  }
}

function ref_1386d() {
  var0 = game["defenders"];

  for(;;) {
    jumpiffalse(level.teamdata[var0]["players"].size == 0) LOC_00000021;
    waitframe();
  }

  for(;;) {
    var1 = level.teamdata[var0]["players"];

    if(isDefined(level.ref_12315.payload)) {
      var1 = level.ref_12315.payload;
    }

    foreach(var3 in var1) {
      if(isDefined(var3.ref_128f8)) {
        var4 = level.ref_12315.ref_11975[var3.ref_128f8];
        var5 = distance2dsquared(var4.origin, var3.origin);

        if(var5 <= var4.ref_129e5) {
          continue;
        } else {
          ref_12907(var3);
        }
      } else if(isDefined(var3.ref_128dd)) {
        var6 = level.ref_12315.ref_128de[var3.ref_128dd];
        var5 = distance2dsquared(var6.origin, var3.origin);

        if(var5 > var6.ref_129e5) {
          ref_12906(var3);
        }
      }

      var7 = undefined;
      var8 = undefined;

      for(var9 = 0; var9 < level.ref_12315.ref_11975.size; var9++) {
        var4 = level.ref_12315.ref_11975[var9];
        var5 = distance2dsquared(var4.origin, var3.origin);

        if(var5 <= var4.ref_129e5 && (!isDefined(var8) || var5 < var8)) {
          var8 = var5;
          var7 = var9;
        }
      }

      if(isDefined(var7)) {
        if(isDefined(var3.ref_128dd)) {
          ref_12906(var3);
        }

        ref_128d6(var3, var7);
        continue;
      }

      if(!isDefined(var3.ref_128dd)) {
        ref_128d5(var3);
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

function ref_128d6(var0) {
  self.ref_128f8 = var0;
  var1 = level.ref_12315.ref_11975[var0];
  var1.count++;

  if(var1.count == 1) {
    var1.inuse = 1;
    var1 show();
    scripts\mp\objidpoolmanager::update_objective_ownerteam(var1.objectiveiconid, game["defenders"]);
    return;
  }
}

function ref_12907() {
  var0 = self.ref_128f8;
  var1 = level.ref_12315.ref_11975[var0];
  var1.count--;

  if(var1.count == 0) {
    var1.inuse = 0;
    var1 hide(1);
    scripts\mp\objidpoolmanager::update_objective_ownerteam(var1.objectiveiconid, undefined);
  }

  self.ref_128f8 = undefined;
}

function ref_128d5() {
  var0 = reset_motionblur();
  self.ref_128dd = var0;
  var1 = level.ref_12315.ref_128de[var0];
  var1.count++;

  if(var1.count == 1) {
    var1.inuse = 1;
    var1 show();
    var1.ref_129e5 = 250000;
  }

  var2 = (self.origin[0], self.origin[1], 500);
  var2 += scripts\engine\math::random_vector_2d() * randomfloatrange(0, 500);
  var1.origin = var2;
}

function reset_motionblur() {
  for(var0 = 0; var0 < level.ref_12315.ref_128de.size; var0++) {
    var1 = level.ref_12315.ref_128de[var0];

    if(!var1.inuse) {
      return var0;
    }
  }
}

function ref_12906() {
  var0 = self.ref_128dd;
  var1 = level.ref_12315.ref_128de[var0];
  var1.count--;

  if(var1.count == 0) {
    var1.inuse = 0;
    var1 hide(1);
  }

  self.ref_128dd = undefined;
}