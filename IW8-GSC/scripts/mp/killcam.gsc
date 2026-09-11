/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killcam.gsc
***********************************************/

function init() {
  level.killcam = scripts\mp\tweakables::gettweakablevalue("game", "allowkillcam");
  level.killcammiscitems = [];

  for(var0 = 0;; var0++) {
    var1 = tablelookupbyrow("mp/miscKillcamItems.csv", var0, 0);

    if(!isDefined(var1) || var1 == "") {
      break;
    }

    var1 = int(var1);
    var2 = tablelookupbyrow("mp/miscKillcamItems.csv", var0, 1);

    if(!isDefined(var2) || var2 == "") {
      break;
    }

    level.killcammiscitems[var2] = var1;
  }
}

function setcinematiccamerastyle(var0, var1, var2) {
  self setclientomnvar("cam_scene_name", var0);
  self setclientomnvar("cam_scene_lead", var1);
  self setclientomnvar("cam_scene_support", var2);
}

function getkillcamentity(var0, var1, var2, var3) {
  if(!isDefined(var0) || !isDefined(var1) || var0 == var1 && !isagent(var0)) {
    return undefined;
  }

  if(usesattackeraskillcamentity(var0, var1, var2, var3)) {
    return undefined;
  }

  if(usesvehiclekillcamentityrelay(var0, var1, var2, var3)) {
    return var1.killcament;
  }

  switch (var2.basename) {
    case "chopper_support_turret_mp":
    case "hover_jet_turret_mp":
    case "bouncing_betty_mp":
    case "lighttank_mp":
    case "trip_mine_mp":
    case "hover_jet_proj_mp":
    case "bomb_site_mp":
    case "player_trophy_system_mp":
    case "trophy_mp":
      return scripts\engine\utility::ter_op(isDefined(var1.killcament), var1.killcament, var1);
    case "white_phosphorus_proj_mp":
    case "nuke_mp":
    case "artillery_mp":
    case "toma_proj_mp":
    case "none":
      if(isnoneweaponinflictor(var1) || isenvironmentalinflictor(var1)) {
        return var1.killcament;
      }

      break;
  }

  if(scripts\common\utility::isdestructibleweapon(var2.basename) || scripts\mp\utility\weapon::isbombsiteweapon(var2.basename)) {
    if(isDefined(var1.killcament) && !var0 scripts\mp\utility\killstreak::attackerinremotekillstreak()) {
      return var1.killcament;
    } else {
      return undefined;
    }
  }

  return var1;
}

function usesattackeraskillcamentity(var0, var1, var2, var3) {
  switch (var2.basename) {
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

function usesvehiclekillcamentityrelay(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    return 0;
  }

  if(!var1 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    return 0;
  }

  switch (var3) {
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_PROJECTILE_SPLASH":
    case "MOD_PROJECTILE":
      return 1;
    default:
      return 0;
  }
}

function setkillcamerastyle(var0, var1, var2, var3, var4, var5, var6) {
  var5.camerastyle = "unknown";

  if(isDefined(var1) && isDefined(var1.agent_type)) {
    setcinematiccamerastyle("killcam_agent", var0 getentitynumber(), var3 getentitynumber());
    var5.camerastyle = "killcam_agent";
    return true;
  } else if(isDefined(var6) && isDefined(var6.basename)) {
    if(var6.basename == "manual_turret_mp" || var6.basename == "manual_turret_payload_mp" || var6.basename == "tur_gun_payload_truck_mp") {
      return true;
    }
  } else if(var4 > 0) {
    setcinematiccamerastyle("unknown", -1, -1);
    return false;
  } else {
    setcinematiccamerastyle("unknown", -1, -1);
    return false;
  }

  return false;
}

function trimkillcamtime(var0, var1, var2, var3, var4, var5) {
  var6 = var2 + var3;

  if(isDefined(var5) && var6 > var5) {
    if(var5 < 2) {
      return;
    }

    if(var5 - var2 >= 1) {
      var3 = var5 - var2;
    } else {
      var3 = 1;
      var2 = var5 - 1;
    }

    var6 = var2 + var3;
  }

  var7 = var2 + var4;

  if(isDefined(var0) && isDefined(var0.lastspawntime)) {
    var8 = var0.lastspawntime;
  } else {
    var8 = var2.lastspawntime;

    if(isDefined(var2.deathtime)) {
      if(gettime() - var2.deathtime < var4 * 1000) {
        var4 = 1;
        var4 -= level.framedurationseconds;
        var7 = var3 + var4;
      }
    }
  }

  var9 = (gettime() - var8) / 1000;

  if(var8 > var9 && var9 > var5) {
    var10 = var9 - var5;

    if(var3 > var10) {
      var3 = var10;
      var7 = var3 + var4;
      var8 = var3 + var5;
    }
  }

  var11 = spawnStruct();
  var11.camtime = var3;
  var11.postdelay = var4;
  var11.killcamlength = var7;
  var11.killcamoffset = var8;
  return var11;
}

function prekillcamnotify(var0) {
  if(isDefined(var0) && !isagent(var0)) {
    var1 = [];

    if(isDefined(self.class) && isDefined(self.classstruct)) {
      var2 = scripts\mp\playerlogic::getplayerassets(self.classstruct);
      var1 = var2;
    }

    if(isDefined(var0.class) && isDefined(var0.classstruct)) {
      var3 = scripts\mp\playerlogic::getplayerassets(var0.classstruct);
      var1 = var3;
    }

    if(var1.size > 0) {
      scripts\mp\playerlogic::loadplayerassets(var1, 1);
    }

    self predictstreampos(var0 getEye(), 1);
    self loadcustomizationplayerview(var0);
    return;
  }
}

function makekillcamdata(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14, var15) {
  var16 = spawnStruct();
  var16.einflictor = var0;
  var16.inflictoragentinfo = var1;
  var16.attackernum = var2;
  var16.killcamentityindex = var3;
  var16.killcamentitystarttime = var4;
  var16.killcamlookatentityindex = var5;
  var16.killcamentstickstolookatent = var6;
  var16.objweapon = var7;
  var16.offsettime = var8;
  var16.maxtime = var9;
  var16.attacker = var10;
  var16.victim = var11;
  var16.smeansofdeath = var12;
  var16.attackerloadoutperks = var13;
  var16.skippable = var14;
  var16.doslowmo = var15;

  if(var12 == "MOD_EXECUTION") {
    var16.executionref = scripts\cp_mp\execution::execution_getrefbyplayer(var10);
  }

  return var16;
}

function dokillcamfromstruct(var0, var1, var2, var3) {
  killcam(var0.einflictor, var0.inflictoragentinfo, var0.attackernum, var0.killcamentityindex, var0.killcamentitystarttime, var0.killcamlookatentityindex, var0.killcamentstickstolookatent, var0.objweapon, var1, var0.offsettime, var2, var0.maxtime, var0.attacker, var0.victim, var0.smeansofdeath, var0.attackerloadoutperks, var0.skippable, var0.doslowmo, var3);
}

function calckillcamtimes(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  if(getDvar("scr_killcam_time") == "") {
    if(level.showingfinalkillcam) {
      if(var10 == "MOD_EXECUTION") {
        var11 = 4;
      } else if(scripts\mp\utility\game::getgametype() == "arena") {
        if(isDefined(var3.recentkillcount) && var3.recentkillcount > 1) {
          var11 = 4 + level.maxkillcamdelay - var10;
        } else {
          var11 = 1.5 + level.maxkillcamdelay - var11;
        }
      } else {
        var11 = 4 + level.maxkillcamdelay - var11;
      }
    } else if(var11.basename == "artillery_mp") {
      var11 = 2.25;
    } else if(var11.basename == "hover_jet_proj_mp") {
      var11 = 3;
    } else if(var11.basename == "hover_jet_turret_mp" || var11.basename == "chopper_support_turret_mp") {
      var11 = 1.5;
    } else if(var11.basename == "toma_proj_mp") {
      var11 = 2.5;
    } else if(var11.basename == "cruise_proj_mp") {
      var11 = 3;
    } else if(var11.basename == "javelin_mp") {
      var11 = 8;
    } else if(issubstr(var11.basename, "remotemissile_")) {
      var11 = 5;
    } else if(isDefined(var11.sentrytype) && var11.sentrytype == "multiturret") {
      var11 = 2;
    } else if(!var11 || var11 > 5) {
      var11 = 5;
    } else if(var11.basename == "frag_grenade_mp" || var11.basename == "frag_grenade_short_mp" || var11.basename == "semtex_mp" || var11.basename == "semtexproj_mp" || var11.basename == "mortar_shell__mp" || var11.basename == "cluster_grenade_mp") {
      var11 = 4.25;
    } else {
      var11 = 2.5;
    }
  } else {
    var11 = getdvarfloat("scr_killcam_time");
  }

  if(isDefined(var11)) {
    if(var11 > var11) {
      var11 = var11;
    }

    if(var11 < level.framedurationseconds) {
      var11 = level.framedurationseconds;
    }
  }

  if(scripts\mp\utility\game::getgametype() == "arena") {
    var12 = 1;

    if(var11 == "MOD_EXECUTION") {
      var12 = 3;
    }
  } else if(getDvar("scr_killcam_posttime") == "") {
    var12 = 2;
  } else {
    var12 = getdvarfloat("scr_killcam_posttime");

    if(var12 < level.framedurationseconds) {
      var12 = level.framedurationseconds;
    }
  }

  if(var11 < 0 || !isDefined(var11)) {
    return undefined;
  }

  if(isagent(var11) || isagent(var11)) {
    var11 = var11 getentitynumber();
  }

  var13 = trimkillcamtime(var11, var11, var12, var12, var11, var11);

  if(!isDefined(var13)) {
    return undefined;
  }

  return var13;
}

function setkilledbyuiomnvar(var0) {
  self setclientomnvar("ui_killcam_killedby_id", var0 getentitynumber());
}

function setkillcamuitimer(var0) {
  self setclientomnvar("ui_killcam_end_milliseconds", int(var0 * 1000) + gettime());
}

function setupkillcamui(var0, var1, var2, var3, var4, var5) {
  if(isPlayer(var0)) {
    setkilledbyuiomnvar(var0);
    self setclientomnvar("ui_killcam_victim_id", var1 getentitynumber());
    self loadcustomizationplayerview(var0);
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(var2.basename)) {
    setkillcamkillstreaktypeomnvars(var2);
  } else if(istrue(level.allowperks)) {
    scripts\mp\perks\perks::setomnvarsforperklist("ui_killcam_killedby_perk", var5);
  }

  var6 = getdvarint("scr_player_forcerespawn");

  if(var4 && !level.gameended || isDefined(self) && !level.gameended || var6 == 0 && !level.gameended) {
    self setclientomnvar("ui_killcam_text", "skip");
  } else if(!level.gameended) {
    self setclientomnvar("ui_killcam_text", "respawn");
  } else {
    self setclientomnvar("ui_killcam_text", "none");
  }

  setkillcamuitimer(var3.killcamlength);
}

function beginarchiveplayback(var0, var1, var2, var3) {
  scripts\mp\utility\player::updatesessionstate("spectator");
  self.spectatekillcam = 1;
  self.forcespectatorclient = var0;
  self.killcamentity = -1;
  self.archivetime = var1;
  self.killcamlength = var2;
  self.psoffsettime = var3;
  self allowspectateteam("freelook", 1);
  self allowspectateteam("none", 1);

  foreach(var5 in level.teamnamelist) {
    self allowspectateteam(var5, 1);
  }
}

function checkkillcamtruncation(var0) {
  if(self.archivetime + 0.015 < var0) {
    var1 = var0 - self.archivetime;

    if(game["truncated_killcams"] < 32) {
      game["truncated_killcams"]++;
    }

    return;
  }
}

function queueforkillcam() {
  level.numplayerswaitingtoenterkillcam++;
  var0 = 1;

  if(istrue(level.showingfinalkillcam) && scripts\mp\utility\game::getgametype() == "br") {
    var0 = 5;
  }

  var1 = level.framedurationseconds * int(floor((level.numplayerswaitingtoenterkillcam - 1) / var0));
  level.maxkillcamdelay = var1;

  if(var1 > 0) {
    wait var1;
  }

  waitframe();
  level.numplayerswaitingtoenterkillcam--;
  return var1;
}

function killcam(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14, var15, var16, var17, var18) {
  self endon("disconnect");
  self endon("spawned");
  level endon("game_ended");
  scripts\mp\utility\player::ref_12898("killcam::killcam() START");
  resetplayeromnvarsonkillcam();

  if(var2 < 0 || !isDefined(var12)) {
    self notify("killcam_canceled");

    if(istrue(var18)) {
      self setclientomnvar("post_game_state", 1);
    }

    return;
  }

  var19 = queueforkillcam();
  var20 = calckillcamtimes(var0, var1, var12, var2, var13, var11, var8, var7, var10, var19, var14);

  if(!isDefined(var20)) {
    self notify("killcam_canceled");

    if(istrue(var18)) {
      self setclientomnvar("post_game_state", 1);
    }

    return;
  }

  setupkillcamui(var12, var13, var7, var20, var10, var15);

  if(isPlayer(var12)) {
    self loadcustomizationplayerview(var12);
  }

  beginarchiveplayback(var2, var20.killcamoffset, var20.killcamlength, var9);
  var21 = setkillcamerastyle(var0, var1, var2, var13, var3, var20, var7);

  if(!var21) {
    thread setkillcamentity(var3, var20.killcamoffset, var4, var5, var6);
  }

  thread endedkillcamcleanup(var18);
  waitframe();

  if(!isDefined(self)) {
    return;
  }

  checkkillcamtruncation(var20.killcamoffset);
  var20.camtime = self.archivetime - level.framedurationseconds - var8;
  var20.killcamlength = var20.camtime + var20.postdelay;
  self.killcamlength = var20.killcamlength;

  if(var20.camtime <= 0) {
    killcamcleanup(1, undefined, var18);
    return;
  }

  self.killcam = 1;
  thread spawnedkillcamcleanup(var18);

  if(istrue(var17)) {
    thread dokillcamslowmo(var20.camtime);
  }

  if(!isDefined(var16) || var16) {
    thread waitskipkillcambutton(var10);
    thread waitskipkillcamkbm();
  }

  if(istrue(var18)) {
    thread scripts\mp\final_killcam::play_patrol_sequence_based_on_first_vehicle();
  }

  thread endkillcamifnothingtoshow();

  if(!isbot(self)) {
    thread ref_12c7f();
  }

  self.killcamwatchtime = gettime();
  waittillkillcamover();
  self.killcamwatchtime = (gettime() - self.killcamwatchtime) / 1000;
  scripts\mp\utility\stats::incpersstat("timeWatchingKillcams", self.killcamwatchtime);
  killcamcleanup(1, undefined, var18);
  scripts\mp\utility\player::ref_12898("killcam::killcam() COMPLETE");
}

function ref_12c7f() {
  self endon("disconnect");
  scripts\engine\utility::ref_143ba(0.15, "killcam_canceled", "spawned");
  self clearpredictedstreampos();

  if(istrue(level.showingfinalkillcam)) {
    scripts\mp\gamelogic::ref_1284e();
    return;
  }
}

function setuppotgui(var0, var1) {
  setkilledbyuiomnvar(var0);
  setkillcamuitimer(var1);
}

function potg_killcam(var0, var1, var2, var3) {
  self endon("disconnect");
  prekillcamnotify(var0);
  resetplayeromnvarsonkillcam();
  var4 = var0 getentitynumber();
  queueforkillcam();

  if(isPlayer(var0)) {
    self loadcustomizationplayerview(var0);
  }

  var5 = gettime();
  var6 = (var5 - var2) / 1000;
  var7 = (var5 - var3) / 1000;
  var8 = (var3 - var2) / 1000;
  setuppotgui(var0, var8);
  self.archiveusepotg = 1;
  beginarchiveplayback(var4, var6, var8, var1);
  waitframe();

  if(!isDefined(self)) {
    return;
  }

  checkkillcamtruncation(var6);
  self.killcamlength = self.archivetime - var7;
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

function dokillcamslowmo(var0) {
  self endon("killcam_ended");

  if(isDefined(level.doingkillcamslowmo)) {
    return;
  }

  level.doingkillcamslowmo = 1;
  var1 = 0;
  var2 = var0;

  if(var2 > 1) {
    var2 = 1;
    var1 += 1;
    wait var0 - var1;
  }

  if(!isDefined(level.vip_freeze_link)) {
    createheadiconatorigin("killcam");
    level.vip_freeze_link = 1;
  }

  setslowmotion(1, 0.25, var2);
  wait var2 + 0.5;
  setslowmotion(0.25, 1, 1);
  level.doingkillcamslowmo = undefined;
}

function setkillcamnormalweaponomnvars(var0, var1, var2, var3) {
  if(var1 == "MOD_EXECUTION") {
    setkillcamexecutiontypeomnvars(var3);
    return;
  }

  if(!isDefined(var0) || var0.basename == "none") {
    clearkillcamattachmentomnvars();
    return;
  }

  if(isDefined(var2.see_killstreak_dist)) {
    var4 = undefined;
    var0 = var2.see_killstreak_dist;
    var2 = undefined;
  } else {
    var4 = scripts\mp\utility\weapon::getequipmenttype(var1.basename);
  }

  if(isDefined(scripts\mp\supers::getsuperrefforsuperweapon(var1))) {
    setkillcamsupertypeomnvars(var1);
    return;
  }

  if(isDefined(var4) && (var4 == "lethal" || var4 == "tactical")) {
    setkillcamequipmenttypeomnvars(var1);
    return;
  }

  if(isDefined(level.killcammiscitems[var1.basename])) {
    setkillcammisctypeomnvars(level.killcammiscitems[var1.basename]);
    return;
  }

  setkillcamweapontypeomnvars(var1, var3);
}

function waittillkillcamover() {
  self endon("abort_killcam");
  scripts\mp\utility\player::ref_12898("killcam::waittillKillcamOver() START");
  wait self.killcamlength - level.frameduration / 1000;
  scripts\mp\utility\player::ref_12898("killcam::waittillKillcamOver() COMPLETE");
}

function setkillcamentity(var0, var1, var2, var3, var4) {
  self endon("disconnect");
  self endon("killcam_ended");
  var5 = gettime() - var1 * 1000;

  if(var2 > var5) {
    waitframe();
    var1 = self.archivetime;
    var5 = gettime() - var1 * 1000;

    if(var2 > var5) {
      wait(var2 - var5) / 1000;
    }
  }

  self.killcamentity = var0;

  if(isDefined(var3)) {
    self.killcamentitylookat = var3;
  }

  if(isDefined(var4)) {
    self setkillcamentstickstolookatent(var4);
    return;
  }
}

function waitskipkillcambutton(var0) {
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

function spawnedkillcamcleanup(var0) {
  self endon("disconnect");
  self endon("killcam_ended");
  self waittill("spawned");
  killcamcleanup(0, undefined, var0);
}

function endedkillcamcleanup(var0) {
  self endon("disconnect");
  self endon("killcam_ended");
  level waittill("game_ended");
  killcamcleanup(1, 1, var0);
}

function clearkillcamomnvars() {
  clearkillcamkilledbyitemomnvars();
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_killcam_killedby_id", -1);
  self setclientomnvar("ui_killcam_victim_id", -1);
  self setclientomnvar("ui_killcam_killedby_loot_variant_id", -1);
  self setclientomnvar("ui_killcam_killedby_weapon_rarity", -1);
  clearkillcamattachmentomnvars();

  for(var0 = 0; var0 < 6; var0++) {
    self setclientomnvar("ui_killcam_killedby_perk" + var0, -1);
  }
}

function killcamcleanup(var0, var1, var2) {
  clearkillcamomnvars();
  self.killcam = undefined;
  setcinematiccamerastyle("unknown", -1, -1);
  scripts\mp\spectating::setspectatepermissions(var1);
  scripts\mp\utility\player::clearkillcamstate();

  if(istrue(var0) && !istrue(var1)) {
    scripts\mp\utility\player::updatesessionstate("dead");
  }

  self notify("killcam_ended");

  if(istrue(var2)) {
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

function setkillcamkilledbyitemomnvars(var0, var1) {
  self setclientomnvar("ui_killcam_killedby_item_type", var0);
  self setclientomnvar("ui_killcam_killedby_item_id", var1);
}

function setkillcamweapontypeomnvars(var0, var1) {
  if(isDefined(var0.ref_121d9)) {
    var0 = var0.ref_121d9;
  }

  var0 = scripts\mp\utility\weapon::mapweapon(var0, var1);
  var2 = scripts\mp\utility\weapon::getweaponrootname(var0.basename);
  var3 = tablelookuprownum("mp/statstable.csv", 4, var2);
  self setclientomnvar("ui_weapon_pickup", 0);

  if(!isDefined(var3) || var3 < 0) {
    setkillcamkilledbyitemomnvars(-1, -1);
    return;
  }

  var4 = scripts\mp\loot::getlootinfoforweapon(var0.basename, var0.variantid);

  if(isDefined(var4)) {
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", var4.variantid);
    self setclientomnvar("ui_killcam_killedby_weapon_rarity", var4.quality - 1);
  } else {
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", -1);
    self setclientomnvar("ui_killcam_killedby_weapon_rarity", -1);
  }

  self setclientomnvar("ui_killcam_killedby_weapon_rarity_notify", gettime());
  setkillcamkilledbyitemomnvars(0, var3);

  if(var2 != "iw8_knife") {
    var5 = getweaponattachments(var0);

    if(!isDefined(var5)) {
      var5 = [];
    }

    var6 = 0;

    for(var7 = 0; var7 < var5.size; var7++) {
      var8 = var5[var7];
      var9 = scripts\mp\utility\weapon::attachmentmap_tobase(var8);

      if(scripts\mp\utility\weapon::carriedpunchcard(var2, var9)) {
        if(var6 >= 8) {
          break;
        }

        var10 = tablelookuprownum("dynamic_weapon_attachment_icon_table.csv", 0, var8);

        if(isDefined(var10) && var10 >= 0) {
          self setclientomnvar("ui_killcam_killedby_attachment" + var6 + 1, var10);
          var6++;
        }
      }
    }

    for(var7 = var6; var7 < 8; var7++) {
      self setclientomnvar("ui_killcam_killedby_attachment" + var7 + 1, -1);
    }

    return;
  }
}

function setkillcamsupertypeomnvars(var0) {
  var1 = scripts\mp\supers::getsuperrefforsuperweapon(var0);
  var2 = scripts\mp\supers::getsuperid(var1);
  setkillcamkilledbyitemomnvars(2, var2);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

function setkillcamkillstreaktypeomnvars(var0) {
  var1 = scripts\mp\utility\killstreak::getkillstreakindex(level.killstreakweaponmap[var0.basename]);

  if(isDefined(self.scorestreakvariantattackerinfo)) {
    var1 = self.scorestreakvariantattackerinfo.id;
    var2 = self.scorestreakvariantattackerinfo.rarity;
    self setclientomnvar("ui_killcam_killedby_item_type", 1);
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", var1);
    self setclientomnvar("ui_killcam_killedby_weapon_rarity", var2 - 1);
  } else {
    setkillcamkilledbyitemomnvars(1, var1);
    clearlootweaponomnvars();
  }

  clearkillcamattachmentomnvars();
}

function setkillcamequipmenttypeomnvars(var0) {
  var1 = scripts\mp\equipment::getequipmentreffromweapon(var0);
  var2 = scripts\mp\equipment::getequipmenttableinfo(var1);
  setkillcamkilledbyitemomnvars(3, var2.id);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

function setkillcamexecutiontypeomnvars(var0) {
  if(!isDefined(var0)) {
    var1 = 0;
  } else {
    var1 = scripts\cp_mp\execution::execution_getidbyref(var1);
  }

  setkillcamkilledbyitemomnvars(4, var1);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

function setkillcammisctypeomnvars(var0) {
  setkillcamkilledbyitemomnvars(5, var0);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

function clearkillcamattachmentomnvars() {
  for(var0 = 0; var0 < 8; var0++) {
    self setclientomnvar("ui_killcam_killedby_attachment" + var0 + 1, -1);
  }
}

function isnoneweaponinflictor(var0) {
  var1 = 0;

  if(isDefined(var0) && isDefined(var0.targetname)) {
    switch (var0.targetname) {
      case "remote_tank":
      case "care_package":
        var1 = 1;
        break;
    }
  }

  return var1;
}

function isenvironmentalinflictor(var0) {
  var1 = 0;

  if(isDefined(var0.killcament) && isDefined(var0.classname)) {
    switch (var0.classname) {
      case "script_brushmodel":
      case "script_model":
      case "trigger_multiple":
        var1 = 1;
        break;
    }
  }

  return var1;
}

function resetplayeromnvarsonkillcam() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_clearall(self);
}