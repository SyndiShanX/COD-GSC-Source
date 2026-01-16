/*********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_hodgepodge.gsc
*********************************************/

init() {
  setdvarifuninitialized("scr_game_hodgepodgeMode", 0);
  setdvarifuninitialized("scr_game_pumpking", 0);

  if(maps\mp\_utility::invirtuallobby()) {
    level.hodgepodgemode = 0;
    return;
  }

  level.hodgepodgemode = getdvarint("scr_game_hodgepodgeMode", 0);
  level.madpropsmode = getdvarint("scr_game_madprops", 0);

  if(level.hodgepodgemode == 0) {
    return;
  }
  if(level.hodgepodgemode == 2 || level.hodgepodgemode == 6 || level.hodgepodgemode == 7)
    level.oldschool = 0;

  if(level.hodgepodgemode == 9) {
    level.oldschool = 0;
    level.onstartgametype = ::blank;
  }

  level.hodgepodgeonstartgametype = level.onstartgametype;
  level.onstartgametype = ::hodgepodgeonstartgametype;
  level thread hodgepodgeonconnect();
}

blank() {}

hodgepodgeonstartgametype() {
  [[level.hodgepodgeonstartgametype]]();

  if(level.hodgepodgemode == 2)
    initmmmode();
  else if(level.hodgepodgemode == 4)
    initsnipersonly();
  else if(level.hodgepodgemode == 6) {
    level.rpgonlyreload = 1;
    initrpgonly();
  } else if(level.hodgepodgemode == 7) {
    level.rpgonlyreload = 0;
    initrpgonly();
  } else if(level.hodgepodgemode == 9)
    initprophunt();
}

hodgepodgeonconnect() {
  for (;;) {
    level waittill("connected", var_0);

    if(level.hodgepodgemode == 9)
      var_0 thread maps\mp\gametypes\_hodgepodge_ph::onconnect();

    if(level.hodgepodgemode == 3)
      var_0 thread watchapplyloadout(::giveprimaryonly);

    if(level.hodgepodgemode == 4) {
      var_0 thread watchapplyloadout(::giveprimaryonlynomelee);
      var_0 thread killrangeindicator();
    }
  }
}

initmmmode() {
  level.ondeadevent = ::ondeadevent;
  level.callbackplayerdamage = ::mmcallbackplayerdamage;
  level.onplayerkilled = ::onmmplayerkilled;
  level.onspawnplayer = ::onmmspawnplayer;
  level.autoassign = ::mmautoassign;
  level.bypassclasschoicefunc = ::mmclass;
  level.getspawnpoint = ::getmmspawnpoint;
  level.ononeleftevent = ::mmononeleftevent;
  level.doprematch = 1;
  level.disableforfeit = 1;
  level.blockweapondrops = 1;
  level.bot_ignore_personality = 1;
  level.mm_allowsuicide = 0;
  level.mm_choseslasher = 0;
  level.mm_choosingslasher = 0;
  level.mm_countdowninprogress = 0;
  common_scripts\utility::flag_init("slasher_chosen");
  level.mm_teamscores["axis"] = 0;
  level.mm_teamscores["allies"] = 0;
  updateteamscores();
  level.spectateoverride["allies"].allowenemyspectate = 1;
  level.allowlatecomers = 0;
  setupdvarsmm();
  setspecialloadouts();
  setclientnamemode("auto_change");
  var_0 = & "OBJECTIVES_MM";
  maps\mp\_utility::setobjectivetext("allies", var_0);
  maps\mp\_utility::setobjectivetext("axis", var_0);

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", var_0);
    maps\mp\_utility::setobjectivescoretext("axis", var_0);
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", var_0);
    maps\mp\_utility::setobjectivescoretext("axis", var_0);
  }

  maps\mp\_utility::setobjectivehinttext("allies", & "OBJECTIVES_INFECT_HINT");
  maps\mp\_utility::setobjectivehinttext("axis", & "OBJECTIVES_INFECT_HINT");
  level thread mmawardxp();
  level thread watchhostmigrationmm();
}

setupdvarsmm() {
  setdynamicdvar("scr_game_hardpoints", 0);
  setdynamicdvar("scr_war_timelimit", 10);
  setdynamicdvar("scr_war_numLives", 1);
  setdynamicdvar("g_oldschool", 1);
  setdynamicdvar("scr_game_mmUavTime", 30);
}

watchhostmigrationmm() {
  level endon("game_ended");

  for (;;) {
    level waittill("host_migration_begin");
    setupdvarsmm();
    level waittill("host_migration_end");
    setupdvarsmm();
  }
}

ondeadevent(var_0) {
  return;
}

mmautoassign() {
  thread maps\mp\gametypes\_menus::setteam("allies");
  self.slasher_team = "allies";
}

ontimelimit() {
  level.finalkillcam_winner = "allies";
  level thread maps\mp\gametypes\_gamelogic::endgame("allies", game["end_reason"]["time_limit_reached"]);
}

mmawardxp() {
  level endon("game_ended");
  level.xpeventinfo["kill"]["value"] = 300;
  common_scripts\utility::flag_wait("slasher_chosen");

  for (;;) {
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(10);

    foreach(var_1 in level.players) {
      if(maps\mp\_utility::is_true(var_1.isslasher)) {
        continue;
      }
      if(!maps\mp\_utility::isreallyalive(var_1)) {
        continue;
      }
      level thread maps\mp\gametypes\_rank::awardgameevent("still_alive", var_1);
    }
  }
}

onmmspawnplayer() {
  self allowmelee(0);

  if(isai(self))
    self allowfire(0);

  thread switchtostartweapon(self.team);
  self setplayerdata(common_scripts\utility::getstatsgroup_common(), "hasEverVisitedDepot", 0);

  if(!maps\mp\_utility::is_true(level.mm_choseslasher))
    maps\mp\_utility::giveperk("specialty_radarimmune", 0);

  level.mm_teamscores["allies"]++;
  updateteamscores();

  if(!level.mm_choosingslasher) {
    level.mm_choosingslasher = 1;
    level thread chooseslasher();
  }

  thread monitordisconnectmm();

  if(level.mm_choseslasher) {
    if(level.mm_teamscores["axis"] && level.mm_teamscores["allies"]) {
      if(level.mm_teamscores["allies"] == 1)
        thread onfinalsurvivordelayed();
    }
  }

  var_0 = self getweaponslistoffhands();

  foreach(var_2 in var_0)
  self setweaponammoclip(var_2, 0);

  if(isai(self))
    thread botmmlogic();
}

onfinalsurvivordelayed() {
  self endon("disconnect");
  waitframe();
  onfinalsurvivor();
}

chooseslasher() {
  level endon("game_ended");
  level endon("mm_stopCountdown");
  level.mm_allowsuicide = 0;
  maps\mp\_utility::gameflagwait("prematch_done");
  level.mm_countdowninprogress = 1;
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1.0);
  var_0 = 15;
  setomnvar("ui_match_countdown_title", 4);
  setomnvar("ui_match_countdown_toggle", 1);

  while (var_0 > 0 && !level.gameended) {
    var_0--;
    setomnvar("ui_match_countdown", var_0 + 1);
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1.0);
  }

  setomnvar("ui_match_countdown", 1);
  setomnvar("ui_match_countdown_title", 0);
  setomnvar("ui_match_countdown_toggle", 0);
  level.mm_countdowninprogress = 0;
  var_1 = [];
  var_2 = undefined;

  foreach(var_4 in level.players) {
    if(maps\mp\_utility::matchmakinggame() && level.players.size > 1 && var_4 ishost()) {
      var_2 = var_4;
      continue;
    }

    if(!maps\mp\_utility::isreallyalive(var_4)) {
      continue;
    }
    if(var_4.team == "axis") {
      continue;
    }
    if(!var_4.hasspawned) {
      continue;
    }
    var_1[var_1.size] = var_4;
  }

  if(!var_1.size && isdefined(var_2))
    var_1[var_1.size] = var_2;

  level.slasher = var_1[randomint(var_1.size)];
  level.slasher setasslasher();

  foreach(var_4 in level.players) {
    if(maps\mp\_utility::is_true(var_4.isslasher)) {
      continue;
    }
    var_4.issurvivor = 1;
    var_4.isslasher = 0;
    var_4 maps\mp\_utility::_clearperks();
  }

  level.gamehasstarted = 1;
  common_scripts\utility::flag_set("slasher_chosen");
  setnojiptime(1);
  var_9 = getaliveplayersonteam("allies");

  if(var_9.size <= 0)
    level thread maps\mp\gametypes\_gamelogic::endgame("axis", game["end_reason"]["allies_eliminated"]);

  if(level.mm_teamscores["axis"] && level.mm_teamscores["allies"]) {
    if(level.mm_teamscores["allies"] == 1)
      thread onfinalsurvivordelayed();
  }
}

switchtostartweapon(var_0) {
  var_1 = maps\mp\gametypes\_class::buildweaponname("h1_meleeshovel");

  if(var_0 == "allies")
    var_1 = maps\mp\gametypes\_class::buildweaponname("h1_colt45");

  waittillframeend;
  self takeallweapons();
  self giveweapon(var_1);
  self setspawnweapon(var_1);
  self switchtoweapon(var_1);
  self setweaponammostock(var_1, 0);
  self setweaponammoclip(var_1, 8);
}

setasslasher() {
  self endon("disconnect");
  prepareforclasschange();
  self.mm_isbeingchosen = 1;
  maps\mp\gametypes\_menus::addtoteam("axis", undefined, 1);
  self.slasher_team = "axis";
  level.mm_choseslasher = 1;
  self.mm_isbeingchosen = undefined;
  level notify("update_game_time");
  level.mm_teamscores["axis"] = 1;
  level.mm_teamscores["allies"]--;
  updateteamscores();
  level.mm_allowsuicide = 1;
  slashersettings();
  thread slashermovespeedscale();
}

slashersettings() {
  self.isslasher = 1;
  self.issurvivor = 0;
  self notify("faux_spawn");
  self.pers["gamemodeLoadout"] = level.mm_loadouts["axis"];
  maps\mp\gametypes\_class::giveandapplyloadout("axis", "gamemode");
  thread switchtostartweapon("axis");
  self allowmelee(1);

  if(isai(self))
    self allowfire(1);

  thread slashermovespeedscale();
}

onslasherdamage(var_0) {
  self.slowmovetime = clamp(self.slowmovetime + 2500, gettime() + 2500, gettime() + 8000);
}

slashermovespeedscale() {
  self endon("death");
  self endon("disconnect");
  var_0 = 1.1;
  var_1 = 0.25;
  self.slowmovetime = 0;

  for (;;) {
    if(self.slowmovetime > gettime()) {
      self.slashermovespeedscale = var_1;
      self allowsprint(0);
    } else {
      self.slashermovespeedscale = var_0;
      self allowsprint(1);
    }

    self setmovespeedscale(self.slashermovespeedscale);
    waitframe();
  }
}

slasherdouav() {
  level endon("game_ended");
  self endon("disconnect");
  level notify("slasherDoUav");
  level endon("slasherDoUav");
  level.radarviewtime = 4;
  var_0 = getdvarfloat("scr_game_mmUavTime", 30);

  for (;;) {
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
    maps\mp\gametypes\_hardpoints::useradaritem();
  }
}

prepareforclasschange() {
  while (!maps\mp\_utility::isreallyalive(self) || maps\mp\_utility::isusingremote())
    wait 0.05;

  if(isdefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    wait 0.05;
  }

  while (self ismeleeing())
    wait 0.05;

  while (self ismantling())
    wait 0.05;

  while (!self isonground() && !self isonladder())
    wait 0.05;

  if(maps\mp\_utility::isjuggernaut()) {
    self notify("lost_juggernaut");
    wait 0.05;
  }

  wait 0.05;

  while (!maps\mp\_utility::isreallyalive(self))
    wait 0.05;
}

getaliveplayersonteam(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(isdefined(var_3) && isalive(var_3) && (!isdefined(var_3.sessionstate) || var_3.sessionstate == "playing")) {
      if(!isdefined(var_0) || var_3.team == var_0)
        var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

monitordisconnectmm() {
  level endon("game_ended");
  self endon("eliminated");
  self notify("mm_monitor_disconnect");
  self endon("mm_monitor_disconnect");
  self waittill("disconnect");
  var_0 = self.slasher_team;
  var_1 = getaliveplayersonteam(var_0);
  level.mm_teamscores[var_0] = var_1.size;
  updateteamscores();

  if(isdefined(self.mm_isbeingchosen) || level.mm_choseslasher) {
    if(level.mm_teamscores["axis"] && level.mm_teamscores["allies"]) {
      if(var_0 == "allies" && level.mm_teamscores["allies"] == 1)
        onfinalsurvivor();
      else if(var_0 == "axis" && level.mm_teamscores["axis"] == 1) {
        foreach(var_3 in level.players) {
          if(var_3 != self && var_3.team == "axis")
            var_3 setasslasher();
        }
      }
    } else if(level.mm_teamscores["allies"] == 0)
      onsurvivorseliminated();
    else if(level.mm_teamscores["axis"] == 0) {
      if(level.mm_teamscores["allies"] == 1)
        onslashereliminated();
      else if(level.mm_teamscores["allies"] > 1) {
        level.mm_choseslasher = 0;
        level thread chooseslasher();
      }
    }
  } else if(level.mm_countdowninprogress && level.mm_teamscores["allies"] == 0 && level.mm_teamscores["axis"] == 0) {
    level notify("mm_stopCountdown");
    level.mm_choosingslasher = 0;
    setomnvar("ui_match_start_countdown", 0);
  }
}

onsurvivorseliminated() {
  level.finalkillcam_winner = "axis";
  level thread maps\mp\gametypes\_gamelogic::endgame("axis", game["end_reason"]["allies_eliminated"]);
}

onslashereliminated() {
  level.finalkillcam_winner = "allies";
  level thread maps\mp\gametypes\_gamelogic::endgame("allies", game["end_reason"]["axis_eliminated"]);
}

onfinalsurvivor() {
  foreach(var_1 in level.players) {
    if(!isdefined(var_1)) {
      continue;
    }
    if(var_1.team != "allies") {
      continue;
    }
    if(!maps\mp\_utility::isreallyalive(var_1)) {
      continue;
    }
    var_1 slashersettings();
    break;
  }
}

updateteamscores() {
  game["teamScores"]["allies"] = level.mm_teamscores["allies"];
  setteamscore("allies", level.mm_teamscores["allies"]);
  game["teamScores"]["axis"] = level.mm_teamscores["axis"];
  setteamscore("axis", level.mm_teamscores["axis"]);
}

slasherreducesprint() {
  self notify("slasherReduceSprint");
  self endon("slasherReduceSprint");
  self allowsprint(0);
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(3);
  self allowsprint(1);
}

mmcallbackplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(maps\mp\_utility::is_true(self.isslasher)) {
    if(isdefined(var_1) && maps\mp\_utility::isbulletdamage(var_4))
      thread onslasherdamage(var_2);

    if(!isdefined(var_1) || level.mm_teamscores["allies"] > 1)
      return;
  }

  maps\mp\gametypes\_damage::callback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

onmmplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isdefined(var_1)) {
    return;
  }
  var_10 = var_1 == self || !isplayer(var_1);

  if(var_10 && !level.mm_allowsuicide) {
    return;
  }
  level notify("update_game_time");
  level.mm_teamscores[self.team]--;
  updateteamscores();

  if(self.team == "allies") {
    maps\mp\_utility::playsoundonplayers("mp_enemy_obj_captured", "allies");
    maps\mp\_utility::playsoundonplayers("mp_war_objective_taken", "axis");
  }

  level thread maps\mp\_utility::teamplayercardsplash("callout_eliminated", self, self.team);

  if(level.mm_teamscores["allies"] == 0) {
    onsurvivorseliminated();
    return;
  }

  if(level.mm_teamscores["axis"] == 0) {
    onslashereliminated();
    return;
  }

  if(level.mm_teamscores["allies"] == 1) {
    onfinalsurvivor();
    return;
  }
}

getmmspawnpoint() {
  if(level.ingraceperiod)
    var_0 = maps\mp\gametypes\_spawnlogic::getstartspawnffa(self.team);
  else {
    var_1 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(self.team);
    var_0 = maps\mp\gametypes\_spawnscoring::getspawnpoint_freeforall(var_1);
  }

  maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_0);
  return var_0;
}

mmclass() {
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  self.pers["gamemodeLoadout"] = level.mm_loadouts[self.pers["team"]];
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
}

setspecialloadouts() {
  level.mm_loadouts["allies"] = maps\mp\gametypes\_class::getemptyloadout();
  level.mm_loadouts["allies"]["loadoutSecondary"] = "h1_colt45";
  level.mm_loadouts["allies"]["loadoutPrimary"] = "h1_ak47";
  level.mm_loadouts["allies"]["loadoutEquipment"] = "h1_fraggrenade_mp";
  level.mm_loadouts["allies"]["loadoutOffhand"] = "h1_smokegrenade_mp";
  level.mm_loadouts["axis"] = maps\mp\gametypes\_class::getemptyloadout();
  level.mm_loadouts["axis"]["loadoutMelee"] = "h1_meleeshovel";
  level.mm_loadouts["axis"]["loadoutPrimary"] = "h1_ak47";
  level.mm_loadouts["axis"]["loadoutEquipment"] = "h1_fraggrenade_mp";
  level.mm_loadouts["axis"]["loadoutOffhand"] = "h1_smokegrenade_mp";
}

mmononeleftevent(var_0) {
  if(var_0 == "axis") {
    return;
  }
  var_1 = maps\mp\_utility::getlastlivingplayer(var_0);
  var_1 thread givelastonteamwarning();
}

givelastonteamwarning() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  maps\mp\_utility::waittillrecoveredhealth(3);
  level thread maps\mp\_utility::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level notify("last_alive", self);
}

botslasheristargetingme() {
  if(isdefined(level.slasher)) {
    if(isai(level.slasher))
      return isdefined(level.slasher.enemy) && level.slasher.enemy == self && level.slasher botcanseeentity(self);
    else
      return common_scripts\utility::within_fov(level.slasher geteye(), level.slasher getplayerangles(), self geteye(), 0.422618) && sighttracepassed(level.slasher geteye(), self geteye(), 0, self);
  }

  return 0;
}

botmmlogic() {
  self notify("botMMLogic");
  self endon("botMMLogic");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self.next_hide_time = 0;
  self.next_bad_place_time = 0;
  var_0 = 1;
  var_1 = 300;
  var_2 = 1000;
  var_3 = 30000;

  for (;;) {
    wait 0.05;

    if(self.health <= 0) {
      continue;
    }
    if(maps\mp\_utility::is_true(self.isslasher) || level.mm_teamscores["allies"] == 1) {
      if(self botgetscriptgoaltype() == "critical")
        self botclearscriptgoal();

      continue;
    }

    if(botslasheristargetingme()) {
      if(self bothasscriptgoal())
        self botclearscriptgoal();

      self.ignoreall = 1;

      if(gettime() > self.next_bad_place_time) {
        badplace_cylinder("slasher", var_2 / 1000, level.slasher.origin, var_1, 75, "allies");
        self.next_bad_place_time = gettime() + var_2;
      }

      continue;
    }

    if(gettime() > self.next_hide_time) {
      self.ignoreall = 0;
      var_4 = getnodesinradius(self.origin, 900, 0, 300);
      var_5 = self botnodepick(var_4, var_4.size * 0.15, "node_hide_anywhere");

      if(!isdefined(var_5))
        var_5 = self getnearestnode();

      if(isdefined(var_5)) {
        var_6 = self botsetscriptgoalnode(var_5, "critical");

        if(var_6)
          self.next_hide_time = gettime() + var_3;
      }
    }
  }
}

watchapplyloadout(var_0) {
  self endon("disconnect");

  for (;;) {
    self waittill("applyLoadout");
    self thread[[var_0]]();
  }
}

giveprimaryweapon(var_0, var_1, var_2) {
  var_3 = self.primaryweapon;

  if(isdefined(var_2))
    var_3 = var_2;

  var_4 = self.secondaryweapon;
  var_5 = maps\mp\_utility::is_true(var_1) && maps\mp\_utility::_hasperk("specialty_twoprimaries") && var_4 != "none";

  if(maps\mp\_utility::is_true(var_0))
    self allowmelee(0);

  self takeallweapons();
  self giveweapon(var_3);
  self setspawnweapon(var_3);
  self switchtoweapon(var_3);

  if(var_5)
    self giveweapon(var_4);

  if(maps\mp\_utility::_hasperk("specialty_extraammo")) {
    self givemaxammo(var_3);

    if(var_5)
      self givemaxammo(var_4);
  }
}

giveprimaryonly() {
  giveprimaryweapon(0, 1);
}

giveprimaryonlynomelee() {
  giveprimaryweapon(1, 1);
}

initrpgonly() {
  level.onspawnplayer = ::onrpgspawnplayer;
  level.bypassclasschoicefunc = ::rpgonlyclass;
  level.modifyplayerdamage = ::rpgonlymodifyplayerdamage;
  level.rpg_loadout = maps\mp\gametypes\_class::getemptyloadout();
  level.rpg_loadout["loadoutSecondary"] = "h1_rpg";
  level.rpg_loadout["loadoutEquipment"] = "h1_fraggrenade_mp";
  level.rpg_loadout["loadoutOffhand"] = "h1_smokegrenade_mp";
  setupdvarsrpg();
  level thread watchhostmigrationrpg();
}

setupdvarsrpg() {
  setdynamicdvar("g_oldschool", 1);
}

watchhostmigrationrpg() {
  level endon("game_ended");

  for (;;) {
    level waittill("host_migration_begin");
    setupdvarsrpg();
    level waittill("host_migration_end");
    setupdvarsrpg();
  }
}

rpgonlyclass() {
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  self.pers["gamemodeLoadout"] = level.rpg_loadout;
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
}

onrpgspawnplayer() {
  thread refillrpgammo();
  thread onrpgspawnplayerwait();
}

onrpgspawnplayerwait() {
  self endon("disconnect");
  waittillframeend;
  giverpgperks();
  giveprimaryweapon(0, 0, "h1_rpg_mp");
}

giverpgperks() {
  maps\mp\_utility::giveperk("specialty_fastreload", 0);
}

refillrpgammo() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("refillRPGAmmo");
  self endon("refillRPGAmmo");

  if(level.rpgonlyreload) {
    for (;;) {
      self setweaponammostock("h1_rpg_mp", 2);
      self waittill("reload");
    }
  } else {
    for (;;) {
      self waittill("weapon_fired", var_0);

      if(var_0 == "h1_rpg_mp")
        self setweaponammoclip("h1_rpg_mp", 1);
    }
  }
}

rpgonlymodifyplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_4 == "h1_rpg_mp" && isdefined(var_0)) {
    var_8 = 50;
    var_9 = 200;
    var_10 = 500;
    var_11 = 100;
    var_12 = length(var_6);
    var_13 = 1.0 - clamp((var_12 - var_8) / (var_9 - var_8), 0.0, 1.0);
    var_14 = (var_10 - var_11) * var_13 + var_11;

    if(var_6[2] < 0.0)
      var_6 = (var_6[0], var_6[1], 0.0);

    var_15 = vectornormalize(var_6);
    var_16 = var_0 getvelocity();
    var_0 setvelocity(var_16 + var_15 * var_14);

    if(isdefined(var_1) && var_1 == var_0) {
      var_17 = 50;
      var_18 = 300;
      var_19 = 100;
      var_20 = 0;
      var_13 = 1.0 - clamp((var_12 - var_17) / (var_18 - var_17), 0.0, 1.0);
      var_21 = (var_19 - var_20) * var_13 + var_20;
      var_2 = int(var_21);
    }
  }

  return var_2;
}

initprophunt() {
  level.bot_ignore_personality = 1;
  maps\mp\gametypes\_hodgepodge_ph::ph_init();
}

flashkillindicator() {
  self notify("newKillIndicator");
  self endon("newKillIndicator");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self.killindicator.alpha = 1;
  self.killindicator fadeovertime(3);
  self.killindicator.alpha = 0;
}

updatekillindicator(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_1 = var_0;

  if(var_0 >= 150)
    self.killindicator.color = (0, 1, 0);
  else {
    var_1 = 0.01 * (100 - 0.67 * var_1);
    self.killindicator.color = (var_1, 1, var_1);
  }

  self.killindicator setvalue(var_0);

  if(!isdefined(self.maxkillrange) || self.maxkillrange < var_0) {
    self.maxkillrange = var_0;
    self.maxkillindicator.color = (var_1, 1, var_1);
    self.maxkillindicator setvalue(self.maxkillrange);
    self.maxkillindicator.alpha = 1;

    if(var_0 >= 150) {
      self.maxkillindicator.color = (0, 1, 0);
      self.maxkillindicator.glowalpha = 0.5;
    }

    if(!isdefined(level.maxmatchrange) || level.maxmatchrange < var_0) {
      level.maxmatchrange = var_0;
      level.maxmatchindicator.color = (var_1, 1, var_1);
      level.maxmatchindicator setvalue(level.maxmatchrange);
      level.maxmatchindicator.alpha = 1;

      if(var_0 >= 150) {
        level.maxmatchindicator.color = (0, 1, 0);
        level.maxmatchindicator.glowalpha = 0.5;
      }
    }
  }

  thread flashkillindicator();
}

hidekillindicator() {
  self endon("disconnect");

  for (;;) {
    level waittill("game_ended");
    self.killindicator.alpha = 0;
    self.maxkillindicator.alpha = 0;
  }
}

killrangeindicator() {
  self endon("disconnect");
  self.killindicator = maps\mp\gametypes\_hud_util::createfontstring("objective", 1);
  self.killindicator.label = & "MP_RANGE_KILL_INDICATOR";
  self.killindicator setvalue(0);
  self.killindicator.x = 0;
  self.killindicator.y = 20;
  self.killindicator.alignx = "center";
  self.killindicator.aligny = "middle";
  self.killindicator.horzalign = "center_adjustable";
  self.killindicator.vertalign = "middle";
  self.killindicator.archived = 1;
  self.killindicator.fontscale = 1;
  self.killindicator.alpha = 0;
  self.killindicator.glowalpha = 0.5;
  self.killindicator.hidewheninmenu = 0;
  self.maxkillindicator = maps\mp\gametypes\_hud_util::createfontstring("objective", 1);
  self.maxkillindicator.x = -6;
  self.maxkillindicator.y = 2;
  self.maxkillindicator.alignx = "right";
  self.maxkillindicator.aligny = "top";
  self.maxkillindicator.horzalign = "right_adjustable";
  self.maxkillindicator.vertalign = "top_adjustable";
  self.maxkillindicator.label = & "MP_MAX_KILL_INDICATOR";
  self.maxkillindicator setvalue(0);
  self.maxkillindicator.alpha = 0;
  self.maxkillindicator.archived = 0;
  self.maxkillindicator.hidewheninmenu = 1;
  thread hidekillindicator();
}

onsniperonlyplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = self;

  if(!isdefined(var_1)) {
    return;
  }
  var_11 = var_1 == self || !isplayer(var_1);

  if(var_11) {
    return;
  }
  if(isdefined(var_1) && isdefined(var_10) && isdefined(var_1.origin) && isdefined(var_10.origin)) {
    var_12 = int(exp(distance(var_1.origin, var_10.origin) * 0.0254));

    if(var_12 <= 0)
      var_12 = 1;
  } else
    return;

  var_1 thread updatekillindicator(var_12);
}

matchbestkillrangeindicator() {
  level.maxmatchindicator = maps\mp\gametypes\_hud_util::createserverfontstring("objective", 1);
  level.maxmatchindicator.x = -6;
  level.maxmatchindicator.y = 14;
  level.maxmatchindicator.alignx = "right";
  level.maxmatchindicator.aligny = "top";
  level.maxmatchindicator.horzalign = "right_adjustable";
  level.maxmatchindicator.vertalign = "top_adjustable";
  level.maxmatchindicator.label = & "MP_MAX_MATCH_INDICATOR";
  level.maxmatchindicator setvalue(0);
  level.maxmatchindicator.alpha = 0;
  level.maxmatchindicator.archived = 0;
  level.maxmatchindicator.hidewheninmenu = 1;
}

initsnipersonly() {
  level.onplayerkilled = ::onsniperonlyplayerkilled;
  level matchbestkillrangeindicator();
}