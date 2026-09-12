/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killcam.gsc
***********************************************/

function init() {
  level.killcam = scripts\mp\tweakables::gettweakablevalue("game", "allowkillcam");
  level.killcammiscitems = [];

  for(var_0 = 0;; var_0++) {
    var_1 = tablelookupbyrow("mp/miscKillcamItems.csv", var_0, 0);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_1 = int(var_1);
    var_2 = tablelookupbyrow("mp/miscKillcamItems.csv", var_0, 1);

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    level.killcammiscitems[var_2] = var_1;
  }
}

function setcinematiccamerastyle(var_0, var_1, var_2) {
  self setclientomnvar("cam_scene_name", var_0);
  self setclientomnvar("cam_scene_lead", var_1);
  self setclientomnvar("cam_scene_support", var_2);
}

function getkillcamentity(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0) || !isDefined(var_1) || var_0 == var_1 && !isagent(var_0)) {
    return undefined;
  }

  if(usesattackeraskillcamentity(var_0, var_1, var_2, var_3)) {
    return undefined;
  }

  if(usesvehiclekillcamentityrelay(var_0, var_1, var_2, var_3)) {
    return var_1.killcament;
  }

  switch (var_2.basename) {
    case "chopper_support_turret_mp":
    case "hover_jet_turret_mp":
    case "bouncing_betty_mp":
    case "lighttank_mp":
    case "trip_mine_mp":
    case "hover_jet_proj_mp":
    case "bomb_site_mp":
    case "player_trophy_system_mp":
    case "trophy_mp":
      return scripts\engine\utility::ter_op(isDefined(var_1.killcament), var_1.killcament, var_1);
    case "white_phosphorus_proj_mp":
    case "nuke_mp":
    case "artillery_mp":
    case "toma_proj_mp":
    case "none":
      if(isnoneweaponinflictor(var_1) || isenvironmentalinflictor(var_1)) {
        return var_1.killcament;
      }

      break;
  }

  if(scripts\common\utility::isdestructibleweapon(var_2.basename) || scripts\mp\utility\weapon::isbombsiteweapon(var_2.basename)) {
    if(isDefined(var_1.killcament) && !var_0 scripts\mp\utility\killstreak::attackerinremotekillstreak()) {
      return var_1.killcament;
    } else {
      return undefined;
    }
  }

  return var_1;
}

function usesattackeraskillcamentity(var_0, var_1, var_2, var_3) {
  switch (var_2.basename) {
    case "apache_turret_mp":
    case "semtex_xmike109_splash_mp":
    case "thermite_xmike109_radius_mp":
    case "semtex_bolt_splash_mp":
    case "thermite_bolt_radius_mp":
    case "tur_gun_carpoc_mp_pass":
    case "tur_gun_fd_mp_seeking":
    case "tur_gun_bt_mp":
    case "manual_turret_flak_mp":
    case "ac130_25mm_mp":
    case "ac130_40mm_mp":
    case "ac130_105mm_mp":
    case "cruise_proj_mp":
    case "apache_proj_mp":
    case "semtex_xmike109_mp":
    case "thermite_xmike109_mp":
    case "semtex_bolt_mp":
    case "thermite_bolt_mp":
    case "tur_apc_rus_mp":
    case "pac_sentry_turret_mp":
    case "tur_gun_little_bird_left_mp":
    case "tur_gun_little_bird_right_mp":
    case "lighttank_tur_ks_mp":
    case "lighttank_tur_mp":
      return true;
  }

  return false;
}

function usesvehiclekillcamentityrelay(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    return 0;
  }

  if(!var_1 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    return 0;
  }

  switch (var_3) {
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_PROJECTILE_SPLASH":
    case "MOD_PROJECTILE":
      return 1;
    default:
      return 0;
  }
}

function setkillcamerastyle(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_5.camerastyle = "unknown";

  if(isDefined(var_1) && isDefined(var_1.agent_type)) {
    setcinematiccamerastyle("killcam_agent", var_0 getentitynumber(), var_3 getentitynumber());
    var_5.camerastyle = "killcam_agent";
    return true;
  } else if(isDefined(var_6) && isDefined(var_6.basename)) {
    if(var_6.basename == "manual_turret_mp" || var_6.basename == "manual_turret_payload_mp" || var_6.basename == "tur_gun_payload_truck_mp") {
      return true;
    }
  } else if(var_4 > 0) {
    setcinematiccamerastyle("unknown", -1, -1);
    return false;
  } else {
    setcinematiccamerastyle("unknown", -1, -1);
    return false;
  }

  return false;
}

function trimkillcamtime(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_2 + var_3;

  if(isDefined(var_5) && var_6 > var_5) {
    if(var_5 < 2) {
      return;
    }

    if(var_5 - var_2 >= 1) {
      var_3 = var_5 - var_2;
    } else {
      var_3 = 1;
      var_2 = var_5 - 1;
    }

    var_6 = var_2 + var_3;
  }

  var_7 = var_2 + var_4;

  if(isDefined(var_0) && isDefined(var_0.lastspawntime)) {
    var_8 = var_0.lastspawntime;
  } else {
    var_8 = var_2.lastspawntime;

    if(isDefined(var_2.deathtime)) {
      if(gettime() - var_2.deathtime < var_4 * 1000) {
        var_4 = 1;
        var_4 -= level.framedurationseconds;
        var_7 = var_3 + var_4;
      }
    }
  }

  var_9 = (gettime() - var_8) / 1000;

  if(var_8 > var_9 && var_9 > var_5) {
    var_10 = var_9 - var_5;

    if(var_3 > var_10) {
      var_3 = var_10;
      var_7 = var_3 + var_4;
      var_8 = var_3 + var_5;
    }
  }

  var_11 = spawnStruct();
  var_11.camtime = var_3;
  var_11.postdelay = var_4;
  var_11.killcamlength = var_7;
  var_11.killcamoffset = var_8;
  return var_11;
}

function prekillcamnotify(var_0) {
  if(isDefined(var_0) && !isagent(var_0)) {
    var_1 = [];

    if(isDefined(self.class) && isDefined(self.classstruct)) {
      var_2 = scripts\mp\playerlogic::getplayerassets(self.classstruct);
      var_1 = var_2;
    }

    if(isDefined(var_0.class) && isDefined(var_0.classstruct)) {
      var_3 = scripts\mp\playerlogic::getplayerassets(var_0.classstruct);
      var_1 = var_3;
    }

    if(var_1.size > 0) {
      scripts\mp\playerlogic::loadplayerassets(var_1, 1);
    }

    self predictstreampos(var_0 getEye(), 1);
    self loadcustomizationplayerview(var_0);
    return;
  }
}

function makekillcamdata(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15) {
  var_16 = spawnStruct();
  var_16.einflictor = var_0;
  var_16.inflictoragentinfo = var_1;
  var_16.attackernum = var_2;
  var_16.killcamentityindex = var_3;
  var_16.killcamentitystarttime = var_4;
  var_16.killcamlookatentityindex = var_5;
  var_16.killcamentstickstolookatent = var_6;
  var_16.objweapon = var_7;
  var_16.offsettime = var_8;
  var_16.maxtime = var_9;
  var_16.attacker = var_10;
  var_16.victim = var_11;
  var_16.smeansofdeath = var_12;
  var_16.attackerloadoutperks = var_13;
  var_16.skippable = var_14;
  var_16.doslowmo = var_15;

  if(var_12 == "MOD_EXECUTION") {
    var_16.executionref = scripts\cp_mp\execution::execution_getrefbyplayer(var_10);
  }

  return var_16;
}

function dokillcamfromstruct(var_0, var_1, var_2, var_3) {
  killcam(var_0.einflictor, var_0.inflictoragentinfo, var_0.attackernum, var_0.killcamentityindex, var_0.killcamentitystarttime, var_0.killcamlookatentityindex, var_0.killcamentstickstolookatent, var_0.objweapon, var_1, var_0.offsettime, var_2, var_0.maxtime, var_0.attacker, var_0.victim, var_0.smeansofdeath, var_0.attackerloadoutperks, var_0.skippable, var_0.doslowmo, var_3);
}

function calckillcamtimes(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(getDvar("scr_killcam_time") == "") {
    if(level.showingfinalkillcam) {
      if(var_10 == "MOD_EXECUTION") {
        var_11 = 4;
      } else if(scripts\mp\utility\game::getgametype() == "arena") {
        if(isDefined(var_3.recentkillcount) && var_3.recentkillcount > 1) {
          var_11 = 4 + level.maxkillcamdelay - var_10;
        } else {
          var_11 = 1.5 + level.maxkillcamdelay - var_11;
        }
      } else {
        var_11 = 4 + level.maxkillcamdelay - var_11;
      }
    } else if(var_11.basename == "artillery_mp") {
      var_11 = 2.25;
    } else if(var_11.basename == "hover_jet_proj_mp") {
      var_11 = 3;
    } else if(var_11.basename == "hover_jet_turret_mp" || var_11.basename == "chopper_support_turret_mp") {
      var_11 = 1.5;
    } else if(var_11.basename == "toma_proj_mp") {
      var_11 = 2.5;
    } else if(var_11.basename == "cruise_proj_mp") {
      var_11 = 3;
    } else if(var_11.basename == "javelin_mp") {
      var_11 = 8;
    } else if(issubstr(var_11.basename, "remotemissile_")) {
      var_11 = 5;
    } else if(isDefined(var_11.sentrytype) && var_11.sentrytype == "multiturret") {
      var_11 = 2;
    } else if(!var_11 || var_11 > 5) {
      var_11 = 5;
    } else if(var_11.basename == "frag_grenade_mp" || var_11.basename == "frag_grenade_short_mp" || var_11.basename == "semtex_mp" || var_11.basename == "semtexproj_mp" || var_11.basename == "mortar_shell__mp" || var_11.basename == "cluster_grenade_mp") {
      var_11 = 4.25;
    } else {
      var_11 = 2.5;
    }
  } else {
    var_11 = getdvarfloat("scr_killcam_time");
  }

  if(isDefined(var_11)) {
    if(var_11 > var_11) {
      var_11 = var_11;
    }

    if(var_11 < level.framedurationseconds) {
      var_11 = level.framedurationseconds;
    }
  }

  if(scripts\mp\utility\game::getgametype() == "arena") {
    var_12 = 1;

    if(var_11 == "MOD_EXECUTION") {
      var_12 = 3;
    }
  } else if(getDvar("scr_killcam_posttime") == "") {
    var_12 = 2;
  } else {
    var_12 = getdvarfloat("scr_killcam_posttime");

    if(var_12 < level.framedurationseconds) {
      var_12 = level.framedurationseconds;
    }
  }

  if(var_11 < 0 || !isDefined(var_11)) {
    return undefined;
  }

  if(isagent(var_11) || isagent(var_11)) {
    var_11 = var_11 getentitynumber();
  }

  var_13 = trimkillcamtime(var_11, var_11, var_12, var_12, var_11, var_11);

  if(!isDefined(var_13)) {
    return undefined;
  }

  return var_13;
}

function setkilledbyuiomnvar(var_0) {
  self setclientomnvar("ui_killcam_killedby_id", var_0 getentitynumber());
}

function setkillcamuitimer(var_0) {
  self setclientomnvar("ui_killcam_end_milliseconds", int(var_0 * 1000) + gettime());
}

function setupkillcamui(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isPlayer(var_0)) {
    setkilledbyuiomnvar(var_0);
    self setclientomnvar("ui_killcam_victim_id", var_1 getentitynumber());
    self loadcustomizationplayerview(var_0);
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(var_2.basename)) {
    setkillcamkillstreaktypeomnvars(var_2);
  } else if(istrue(level.allowperks)) {
    scripts\mp\perks\perks::setomnvarsforperklist("ui_killcam_killedby_perk", var_5);
  }

  var_6 = getdvarint("scr_player_forcerespawn");

  if(var_4 && !level.gameended || isDefined(self) && !level.gameended || var_6 == 0 && !level.gameended) {
    self setclientomnvar("ui_killcam_text", "skip");
  } else if(!level.gameended) {
    self setclientomnvar("ui_killcam_text", "respawn");
  } else {
    self setclientomnvar("ui_killcam_text", "none");
  }

  setkillcamuitimer(var_3.killcamlength);
}

function beginarchiveplayback(var_0, var_1, var_2, var_3) {
  scripts\mp\utility\player::updatesessionstate("spectator");
  self.spectatekillcam = 1;
  self.forcespectatorclient = var_0;
  self.killcamentity = -1;
  self.archivetime = var_1;
  self.killcamlength = var_2;
  self.psoffsettime = var_3;
  self allowspectateteam("freelook", 1);
  self allowspectateteam("none", 1);

  foreach(var_5 in level.teamnamelist) {
    self allowspectateteam(var_5, 1);
  }
}

function checkkillcamtruncation(var_0) {
  if(self.archivetime + 0.015 < var_0) {
    var_1 = var_0 - self.archivetime;

    if(game["truncated_killcams"] < 32) {
      game["truncated_killcams"]++;
    }

    return;
  }
}

function queueforkillcam() {
  level.numplayerswaitingtoenterkillcam++;
  var_0 = 1;

  if(istrue(level.showingfinalkillcam) && scripts\mp\utility\game::getgametype() == "br") {
    var_0 = 5;
  }

  var_1 = level.framedurationseconds * int(floor((level.numplayerswaitingtoenterkillcam - 1) / var_0));
  level.maxkillcamdelay = var_1;

  if(var_1 > 0) {
    wait var_1;
  }

  waitframe();
  level.numplayerswaitingtoenterkillcam--;
  return var_1;
}

function killcam(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18) {
  self endon("disconnect");
  self endon("spawned");
  level endon("game_ended");
  scripts\mp\utility\player::ref_12898("killcam::killcam() START");
  resetplayeromnvarsonkillcam();

  if(var_2 < 0 || !isDefined(var_12)) {
    self notify("killcam_canceled");

    if(istrue(var_18)) {
      self setclientomnvar("post_game_state", 1);
    }

    return;
  }

  var_19 = queueforkillcam();
  var_20 = calckillcamtimes(var_0, var_1, var_12, var_2, var_13, var_11, var_8, var_7, var_10, var_19, var_14);

  if(!isDefined(var_20)) {
    self notify("killcam_canceled");

    if(istrue(var_18)) {
      self setclientomnvar("post_game_state", 1);
    }

    return;
  }

  setupkillcamui(var_12, var_13, var_7, var_20, var_10, var_15);

  if(isPlayer(var_12)) {
    self loadcustomizationplayerview(var_12);
  }

  beginarchiveplayback(var_2, var_20.killcamoffset, var_20.killcamlength, var_9);
  var_21 = setkillcamerastyle(var_0, var_1, var_2, var_13, var_3, var_20, var_7);

  if(!var_21) {
    thread setkillcamentity(var_3, var_20.killcamoffset, var_4, var_5, var_6);
  }

  thread endedkillcamcleanup(var_18);
  waitframe();

  if(!isDefined(self)) {
    return;
  }

  checkkillcamtruncation(var_20.killcamoffset);
  var_20.camtime = self.archivetime - level.framedurationseconds - var_8;
  var_20.killcamlength = var_20.camtime + var_20.postdelay;
  self.killcamlength = var_20.killcamlength;

  if(var_20.camtime <= 0) {
    killcamcleanup(1, undefined, var_18);
    return;
  }

  self.killcam = 1;
  thread spawnedkillcamcleanup(var_18);

  if(istrue(var_17)) {
    thread dokillcamslowmo(var_20.camtime);
  }

  if(!isDefined(var_16) || var_16) {
    thread waitskipkillcambutton(var_10);
    thread waitskipkillcamkbm();
  }

  if(istrue(var_18)) {
    thread scripts\mp\final_killcam::play_patrol_sequence_based_on_first_vehicle();
  }

  thread endkillcamifnothingtoshow();

  if(!isbot(self)) {
    thread ref_12C7F();
  }

  self.killcamwatchtime = gettime();
  waittillkillcamover();
  self.killcamwatchtime = (gettime() - self.killcamwatchtime) / 1000;
  scripts\mp\utility\stats::incpersstat("timeWatchingKillcams", self.killcamwatchtime);
  killcamcleanup(1, undefined, var_18);
  scripts\mp\utility\player::ref_12898("killcam::killcam() COMPLETE");
}

function ref_12C7F() {
  self endon("disconnect");
  scripts\engine\utility::ref_143BA(0.15, "killcam_canceled", "spawned");
  self clearpredictedstreampos();

  if(istrue(level.showingfinalkillcam)) {
    scripts\mp\gamelogic::ref_1284E();
    return;
  }
}

function setuppotgui(var_0, var_1) {
  setkilledbyuiomnvar(var_0);
  setkillcamuitimer(var_1);
}

function potg_killcam(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  prekillcamnotify(var_0);
  resetplayeromnvarsonkillcam();
  var_4 = var_0 getentitynumber();
  queueforkillcam();

  if(isPlayer(var_0)) {
    self loadcustomizationplayerview(var_0);
  }

  var_5 = gettime();
  var_6 = (var_5 - var_2) / 1000;
  var_7 = (var_5 - var_3) / 1000;
  var_8 = (var_3 - var_2) / 1000;
  setuppotgui(var_0, var_8);
  self.archiveusepotg = 1;
  beginarchiveplayback(var_4, var_6, var_8, var_1);
  waitframe();

  if(!isDefined(self)) {
    return;
  }

  checkkillcamtruncation(var_6);
  self.killcamlength = self.archivetime - var_7;
  self.killcam = 1;
  self notify("begin_killcam");
  waittillkillcamover();
  potgkillcamcleanup();
}

function potgkillcamcleanup() {
  self.killcam = undefined;
  scripts\mp\spectating::setspectatepermissions();
  scripts\mp\utility\player::updatesessionstate("dead");
  scripts\mp\utility\player::clearkillcamstate();
  self notify("killcam_ended");
}

function dokillcamslowmo(var_0) {
  self endon("killcam_ended");

  if(isDefined(level.doingkillcamslowmo)) {
    return;
  }

  level.doingkillcamslowmo = 1;
  var_1 = 0;
  var_2 = var_0;

  if(var_2 > 1) {
    var_2 = 1;
    var_1 += 1;
    wait var_0 - var_1;
  }

  if(!isDefined(level.vip_freeze_link)) {
    createheadiconatorigin("killcam");
    level.vip_freeze_link = 1;
  }

  setslowmotion(1, 0.25, var_2);
  wait var_2 + 0.5;
  setslowmotion(0.25, 1, 1);
  level.doingkillcamslowmo = undefined;
}

function setkillcamnormalweaponomnvars(var_0, var_1, var_2, var_3) {
  if(var_1 == "MOD_EXECUTION") {
    setkillcamexecutiontypeomnvars(var_3);
    return;
  }

  if(!isDefined(var_0) || var_0.basename == "none") {
    clearkillcamattachmentomnvars();
    return;
  }

  if(isDefined(var_2.see_killstreak_dist)) {
    var_4 = undefined;
    var_0 = var_2.see_killstreak_dist;
    var_2 = undefined;
  } else {
    var_4 = scripts\mp\utility\weapon::getequipmenttype(var_1.basename);
  }

  if(isDefined(scripts\mp\supers::getsuperrefforsuperweapon(var_1))) {
    setkillcamsupertypeomnvars(var_1);
    return;
  }

  if(isDefined(var_4) && (var_4 == "lethal" || var_4 == "tactical")) {
    setkillcamequipmenttypeomnvars(var_1);
    return;
  }

  if(isDefined(level.killcammiscitems[var_1.basename])) {
    setkillcammisctypeomnvars(level.killcammiscitems[var_1.basename]);
    return;
  }

  setkillcamweapontypeomnvars(var_1, var_3);
}

function waittillkillcamover() {
  self endon("abort_killcam");
  scripts\mp\utility\player::ref_12898("killcam::waittillKillcamOver() START");
  wait self.killcamlength - level.frameduration / 1000;
  scripts\mp\utility\player::ref_12898("killcam::waittillKillcamOver() COMPLETE");
}

function setkillcamentity(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  self endon("killcam_ended");
  var_5 = gettime() - var_1 * 1000;

  if(var_2 > var_5) {
    waitframe();
    var_1 = self.archivetime;
    var_5 = gettime() - var_1 * 1000;

    if(var_2 > var_5) {
      wait(var_2 - var_5) / 1000;
    }
  }

  self.killcamentity = var_0;

  if(isDefined(var_3)) {
    self.killcamentitylookat = var_3;
  }

  if(isDefined(var_4)) {
    self setkillcamentstickstolookatent(var_4);
    return;
  }
}

function waitskipkillcambutton(var_0) {
  self endon("disconnect");
  self endon("killcam_ended");

  if(!isai(self)) {
    self notifyonplayercommand("kc_respawn", "+usereload");
    self notifyonplayercommand("kc_respawn", "+activate");
    self waittill("kc_respawn");
    scripts\mp\utility\stats::incpersstat("skippedKillcams", 1);
    scripts\mp\utility\player::ref_12898("killcam::waitSkipKillcamButton() Killcam SKIPPED");
    self notify("abort_killcam");
    return;
  }
}

function waitskipkillcamkbm() {
  self endon("disconnect");
  self endon("killcam_ended");
  self endon("abort_killcam");

  while(self usinggamepad() || !self jumpbuttonPressed()) {
    waitframe();
  }

  scripts\mp\utility\stats::incpersstat("skippedKillcams", 1);
  scripts\mp\utility\player::ref_12898("killcam::waitSkipKillcamKBM() Killcam SKIPPED");
  self notify("abort_killcam");
}

function endkillcamifnothingtoshow() {
  self endon("disconnect");
  self endon("killcam_ended");

  for(;;) {
    if(self.archivetime <= 0) {
      break;
    }

    waitframe();
  }

  scripts\mp\utility\player::ref_12898("killcam::endKillcamIfNothingToShow() Killcam SKIPPED");
  self notify("abort_killcam");
}

function spawnedkillcamcleanup(var_0) {
  self endon("disconnect");
  self endon("killcam_ended");
  self waittill("spawned");
  killcamcleanup(0, undefined, var_0);
}

function endedkillcamcleanup(var_0) {
  self endon("disconnect");
  self endon("killcam_ended");
  level waittill("game_ended");
  killcamcleanup(1, 1, var_0);
}

function clearkillcamomnvars() {
  clearkillcamkilledbyitemomnvars();
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_killcam_killedby_id", -1);
  self setclientomnvar("ui_killcam_victim_id", -1);
  self setclientomnvar("ui_killcam_killedby_loot_variant_id", -1);
  self setclientomnvar("ui_killcam_killedby_weapon_rarity", -1);
  clearkillcamattachmentomnvars();

  for(var_0 = 0; var_0 < 6; var_0++) {
    self setclientomnvar("ui_killcam_killedby_perk" + var_0, -1);
  }
}

function killcamcleanup(var_0, var_1, var_2) {
  clearkillcamomnvars();
  self.killcam = undefined;
  setcinematiccamerastyle("unknown", -1, -1);
  scripts\mp\spectating::setspectatepermissions(var_1);
  scripts\mp\utility\player::clearkillcamstate();

  if(istrue(var_0) && !istrue(var_1)) {
    scripts\mp\utility\player::updatesessionstate("dead");
  }

  self notify("killcam_ended");

  if(istrue(var_2)) {
    self setclientomnvar("post_game_state", 1);
    return;
  }
}

function clearlootweaponomnvars() {
  self setclientomnvar("ui_killcam_killedby_loot_variant_id", -1);
  self setclientomnvar("ui_killcam_killedby_weapon_rarity", -1);
}

function clearkillcamkilledbyitemomnvars() {
  self setclientomnvar("ui_killcam_killedby_item_type", -1);
  self setclientomnvar("ui_killcam_killedby_item_id", -1);
}

function setkillcamkilledbyitemomnvars(var_0, var_1) {
  self setclientomnvar("ui_killcam_killedby_item_type", var_0);
  self setclientomnvar("ui_killcam_killedby_item_id", var_1);
}

function setkillcamweapontypeomnvars(var_0, var_1) {
  if(isDefined(var_0.ref_121D9)) {
    var_0 = var_0.ref_121D9;
  }

  var_0 = scripts\mp\utility\weapon::mapweapon(var_0, var_1);
  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_0.basename);
  var_3 = tablelookuprownum("mp/statstable.csv", 4, var_2);
  self setclientomnvar("ui_weapon_pickup", 0);

  if(!isDefined(var_3) || var_3 < 0) {
    setkillcamkilledbyitemomnvars(-1, -1);
    return;
  }

  var_4 = scripts\mp\loot::getlootinfoforweapon(var_0.basename, var_0.variantid);

  if(isDefined(var_4)) {
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", var_4.variantid);
    self setclientomnvar("ui_killcam_killedby_weapon_rarity", var_4.quality - 1);
  } else {
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", -1);
    self setclientomnvar("ui_killcam_killedby_weapon_rarity", -1);
  }

  self setclientomnvar("ui_killcam_killedby_weapon_rarity_notify", gettime());
  setkillcamkilledbyitemomnvars(0, var_3);

  if(var_2 != "iw8_knife") {
    var_5 = getweaponattachments(var_0);

    if(!isDefined(var_5)) {
      var_5 = [];
    }

    var_6 = 0;

    for(var_7 = 0; var_7 < var_5.size; var_7++) {
      var_8 = var_5[var_7];
      var_9 = scripts\mp\utility\weapon::attachmentmap_tobase(var_8);

      if(scripts\mp\utility\weapon::carriedpunchcard(var_2, var_9)) {
        if(var_6 >= 8) {
          break;
        }

        var_10 = tablelookuprownum("dynamic_weapon_attachment_icon_table.csv", 0, var_8);

        if(isDefined(var_10) && var_10 >= 0) {
          self setclientomnvar("ui_killcam_killedby_attachment" + var_6 + 1, var_10);
          var_6++;
        }
      }
    }

    for(var_7 = var_6; var_7 < 8; var_7++) {
      self setclientomnvar("ui_killcam_killedby_attachment" + var_7 + 1, -1);
    }

    return;
  }
}

function setkillcamsupertypeomnvars(var_0) {
  var_1 = scripts\mp\supers::getsuperrefforsuperweapon(var_0);
  var_2 = scripts\mp\supers::getsuperid(var_1);
  setkillcamkilledbyitemomnvars(2, var_2);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

function setkillcamkillstreaktypeomnvars(var_0) {
  var_1 = scripts\mp\utility\killstreak::getkillstreakindex(level.killstreakweaponmap[var_0.basename]);

  if(isDefined(self.scorestreakvariantattackerinfo)) {
    var_1 = self.scorestreakvariantattackerinfo.id;
    var_2 = self.scorestreakvariantattackerinfo.rarity;
    self setclientomnvar("ui_killcam_killedby_item_type", 1);
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", var_1);
    self setclientomnvar("ui_killcam_killedby_weapon_rarity", var_2 - 1);
  } else {
    setkillcamkilledbyitemomnvars(1, var_1);
    clearlootweaponomnvars();
  }

  clearkillcamattachmentomnvars();
}

function setkillcamequipmenttypeomnvars(var_0) {
  var_1 = scripts\mp\equipment::getequipmentreffromweapon(var_0);
  var_2 = scripts\mp\equipment::getequipmenttableinfo(var_1);
  setkillcamkilledbyitemomnvars(3, var_2.id);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

function setkillcamexecutiontypeomnvars(var_0) {
  if(!isDefined(var_0)) {
    var_1 = 0;
  } else {
    var_1 = scripts\cp_mp\execution::execution_getidbyref(var_1);
  }

  setkillcamkilledbyitemomnvars(4, var_1);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

function setkillcammisctypeomnvars(var_0) {
  setkillcamkilledbyitemomnvars(5, var_0);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

function clearkillcamattachmentomnvars() {
  for(var_0 = 0; var_0 < 8; var_0++) {
    self setclientomnvar("ui_killcam_killedby_attachment" + var_0 + 1, -1);
  }
}

function isnoneweaponinflictor(var_0) {
  var_1 = 0;

  if(isDefined(var_0) && isDefined(var_0.targetname)) {
    switch (var_0.targetname) {
      case "remote_tank":
      case "care_package":
        var_1 = 1;
        break;
    }
  }

  return var_1;
}

function isenvironmentalinflictor(var_0) {
  var_1 = 0;

  if(isDefined(var_0.killcament) && isDefined(var_0.classname)) {
    switch (var_0.classname) {
      case "script_brushmodel":
      case "script_model":
      case "trigger_multiple":
        var_1 = 1;
        break;
    }
  }

  return var_1;
}

function resetplayeromnvarsonkillcam() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_clearall(self);
}