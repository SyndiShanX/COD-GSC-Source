/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\mp_agent_damage.gsc
***********************************************/

function init() {
  scripts\cp_mp\utility\game_utility::teamwipedobituary();
  var_0 = scripts\cp\utility::getgametype();

  if(!isDefined(var_0)) {
    var_0 = getDvar("g_gametype");
  }

  var_1 = 0;
  var_2 = ["cp/cp_score_event_table.csv", "mp/score_event_table.csv"];
  var_3 = 0;

  for(;;) {
    var_4 = tablelookupbyrow(var_2[var_3], var_1, 0);

    if(!isDefined(var_4) || var_4 == "") {
      break;
    }

    var_5 = tablelookupbyrow(var_2[var_3], var_1, level.getallselectableattachments.game_type_col[var_0]);

    if(!isDefined(var_5) || var_5 == "") {
      var_1++;
      continue;
    }

    if(var_4 == "win" || var_4 == "loss" || var_4 == "tie") {
      var_5 = float(var_5);
    } else {
      var_5 = int(var_5);
    }

    if(var_5 != -1) {
      scripts\cp\drone\emp_drone::registerscoreinfo(var_4, "value", var_5);
    }

    var_6 = tablelookuprownum("mp/splashTable.csv", 0, var_4);
    scripts\cp\drone\emp_drone::registerscoreinfo(var_4, "eventID", var_6);
    var_6 = tablelookup("mp/splashTable.csv", 0, var_4, 2);
    scripts\cp\drone\emp_drone::registerscoreinfo(var_4, "text", var_6);
    var_6 = int(tablelookup("mp/splashTable.csv", 0, var_4, 13));
    scripts\cp\drone\emp_drone::registerscoreinfo(var_4, "priority", var_6);
    var_6 = int(tablelookup("mp/splashTable.csv", 0, var_4, 14));
    scripts\cp\drone\emp_drone::registerscoreinfo(var_4, "alwaysShowSplash", var_6);
    var_7 = tablelookuprownum("mp/splashTable.csv", 0, var_4);

    if(isDefined(var_7) && var_7 != -1) {
      scripts\cp\drone\emp_drone::registerscoreinfo(var_4, "splashID", var_7);
    }

    var_8 = tablelookupbyrow(var_2[var_3], var_1, 4);
    scripts\cp\drone\emp_drone::registerscoreinfo(var_4, "group", var_8);
    var_9 = tablelookupbyrow(var_2[var_3], var_1, 3);

    if(isDefined(var_9) && tolower(var_9) == "true") {
      scripts\cp\drone\emp_drone::registerscoreinfo(var_4, "allowBonus", 1);
    }

    var_1++;
  }

  level._effect["money"] = loadfx("vfx/props/cash_player_drop");
  level.numkills = 0;
  thread onplayerconnect();
  thread monitorhealed();
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawn);
  scripts\cp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(&monitoradstime);
  scripts\cp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(&updatestancetracking);
  scripts\cp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(&events_monitorslideupdate);
  scripts\cp\cp_modular_spawning::add_global_spawn_function("axis", &stoppingpower_clearhcrdata);
}

function onplayerspawn() {
  self.jumpcur = 0;
  self.mantlecur = 0;
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.killedplayers = [];
    var_0.killedby = [];
    var_0.lastkilledby = undefined;
    var_0.greatestuniqueplayerkills = 0;
    var_0.recentkillcount = 0;
    var_0.recentdefendcount = 0;
    var_0.lastkilltime = 0;
    var_0.lastkilldogtime = 0;
    var_0.damagedplayers = [];

    if(!isDefined(var_0.pers["cur_kill_streak"])) {
      var_0.pers["cur_kill_streak"] = 0;
    }

    if(!isDefined(var_0.pers["cur_death_streak"])) {
      var_0.pers["cur_death_streak"] = 0;
    }

    initslidemonitor(var_0);
    initmonitoradstime(var_0);
    thread monitorreload();
    thread monitorweaponpickup();
    var_0.lastweaponchangetime = 0;
    initstancetracking(var_0);
  }
}

function damagedplayer(var_0, var_1) {
  if(var_1 < 50 && var_1 > 10) {
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_damaged_light", undefined, 0.1);
    return;
  }

  level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_damaged_heavy", undefined, 0.1);
}

function playerworlddeath(var_0, var_1) {}

function killedplayernotifysys(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("killedPlayerNotify");
  self endon("killedPlayerNotify");

  if(!isDefined(self.killsinaframecount)) {
    self.killsinaframecount = 0;
  }

  self.killsinaframecount++;

  if(weaponclass(var_2) == "spread") {
    if(!isDefined(self.shotgunkillsinaframecount)) {
      self.shotgunkillsinaframecount = 1;
    } else {
      self.shotgunkillsinaframecount++;

      if(self.shotgunkillsinaframecount >= 2) {
        shotguncollateral(self.shotgunkillsinaframecount);
      }
    }
  } else if(var_3 == "MOD_PISTOL_BULLET" || var_3 == "MOD_RIFLE_BULLET" || var_3 == "MOD_HEAD_SHOT") {
    if(!isDefined(self.bulletkillsinaframecount)) {
      self.bulletkillsinaframecount = 1;
    } else {
      self.bulletkillsinaframecount++;

      if(self.bulletkillsinaframecount >= 2) {
        collateral(self.bulletkillsinaframecount);
      }
    }
  }

  waittillframeend();
  thread notifykilledplayer(var_0, var_1, var_2, var_3, self.killsinaframecount);
  self.killsinaframecount = 0;
  self.bulletkillsinaframecount = 0;
  self.shotgunkillsinaframecount = 0;
}

function notifykilledplayer(var_0, var_1, var_2, var_3, var_4) {
  var_5 = createheadicon(var_2);

  for(var_6 = 0; var_6 < var_4; var_6++) {
    self notify("got_a_kill", var_1, var_5, var_3);
    waitframe();
  }
}

function vip_playerdied(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level.numkills++;
  checkkillstreakkillevents(var_2, var_3, var_4);

  if(isai(var_1) || isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
    var_1.guid = var_1 getentitynumber();
  }

  var_7 = var_1.guid;
  var_8 = self.guid;
  var_9 = gettime();
  var_10 = createheadicon(var_2);
  thread killedplayernotifysys(var_0, var_1, var_2, var_3);
  thread updaterecentkills(var_0, var_1, var_2, var_10);
  thread updatequadfeedcounter(self, var_0);
  self.prevlastkilltime = self.lastkilltime;
  self.lastkilltime = var_9;
  self.lastkilledplayer = var_1;
  self.lastkillvictimpos = var_1.origin;

  if(isPlayer(self)) {
    if(self.deaths > 0) {
      var_11 = self.kills / self.deaths;

      if(var_11 > 3) {
        level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_kd_high", undefined, 0.75);
      }
    } else if(self.kills > 5) {
      level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_kd_high", undefined, 0.75);
    }
  }

  if(istrue(self.laststanding)) {
    incpersstat("clutch", 1);
  }

  self.modifiers = [];
  self.modifiers["mask"] = 0;
  self.modifiers["mask2"] = 0;

  if(isDefined(self.damagedplayers) && isDefined(self.damagedplayers[var_7])) {
    self.damagedplayers[var_7] = undefined;
  }

  var_12 = scripts\cp\cp_weapon::getweapongroup(var_2.basename);

  if(!scripts\cp\utility::iskillstreakweapon(var_2.basename) && !scripts\cp\utility::_hasperk("specialty_explosivebullets")) {
    if(var_3 == "MOD_EXECUTION") {
      execution(var_0);
    }

    if(var_2.basename == "none" && !scripts\cp_mp\utility\player_utility::isinvehicle()) {
      return 0;
    }

    if(isDefined(var_1.attackerposition)) {
      var_13 = var_1.attackerposition;
    } else {
      var_13 = self.origin;
    }

    var_14 = 1;

    if(isDefined(var_5)) {
      var_14 = var_5 == self;
    }

    var_15 = anglesToForward(self getplayerangles());
    var_16 = var_2.origin - var_13;
    var_17 = vectorNormalize(var_16);
    var_18 = vectordot(var_15, var_17);
    var_19 = scripts\engine\utility::isbulletdamage(var_4);

    if(var_2.attackers.size == 1 && !isDefined(var_2.attackers[var_2.guid])) {
      if(var_13 == "weapon_sniper" && var_4 != "MOD_MELEE" && var_10 == var_2.attackerdata[self.guid].firsttimedamaged) {
        self.modifiers["oneshotkill"] = 1;
        self.modifiers["mask"] = self.modifiers["mask"] | 1;
        thread killeventtextpopup("one_shot_kill", 1);
        thread scripts\cp_mp\xmike109::givemidmatchaward("one_shot_kill");
        incpersstat("oneShotOneKills", 1);
      }

      if(var_13 == "weapon_shotgun" && var_4 != "MOD_MELEE" && var_10 == var_2.attackerdata[self.guid].firsttimedamaged) {
        self.modifiers["oneshotkill_shotgun"] = 1;
        incpersstat("oneShotOneKills", 1);
      }
    }

    if(var_4 == "MOD_MELEE") {
      if(var_13 != "weapon_melee" && var_13 != "weapon_melee2") {
        thread killeventtextpopup("gun_butt", 1);
        thread scripts\cp_mp\xmike109::givemidmatchaward("gun_butt");
      }

      if(var_3.basename == "iw8_fists_mp") {
        thread killeventtextpopup("fist_kill", 1);
        thread scripts\cp_mp\xmike109::givemidmatchaward("fist_kill");
      }
    }

    if(isPlayer(var_2)) {
      var_20 = var_2 getheldoffhand();

      if(var_20.basename == "frag_grenade_mp" || var_20.basename == "cluster_grenade_mp") {
        self.modifiers["cooking"] = 1;
        self.modifiers["mask"] = self.modifiers["mask"] | 2;
      }
    }

    if(isDefined(self.assistedsuicide) && self.assistedsuicide) {
      assistedsuicide(var_1, var_3);
    }

    if(level.numkills == 1) {
      firstblood(var_1);
    }

    if(isDefined(self.pers) && self.pers["cur_death_streak"] > 3) {
      comeback(var_1);
    }

    if(var_4 == "MOD_HEAD_SHOT" || isDefined(var_7) && (var_7 == "head" || var_7 == "helmet" || var_7 == "neck")) {
      level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_headshot", undefined, 0.75);
      headshot(var_1);
    }

    if(isDefined(self.wasti) && self.wasti && var_10 - self.spawntime <= 5000) {
      self.modifiers["jackintheboxkill"] = 1;
    }

    if(!scripts\cp\utility\player::isreallyalive(self) && isDefined(self.deathtime)) {
      var_21 = gettime() - self.deathtime;

      if(var_21 < 1500 && var_21 > 0) {
        postdeathkill(var_1);
      }

      if(scripts\cp\utility::issimultaneouskillenabled()) {
        if(var_21 == 0 && isDefined(self.lastattacker) && self.lastattacker == var_2) {
          thread killeventtextpopup("simultaneous_kill", 0);
          thread scripts\cp_mp\xmike109::givemidmatchaward("simultaneous_kill", undefined, undefined, 1);
          thread killeventtextpopup(var_2, "simultaneous_kill");
          var_2 thread scripts\cp_mp\xmike109::givemidmatchaward("simultaneous_kill", undefined, undefined, 1);
        }
      }
    }

    if(isDefined(var_2.lastkilltime) && level.teambased && var_10 - var_2.lastkilltime < 1500) {
      if(isDefined(var_2.lastkilledplayer) && var_2.lastkilledplayer != self) {
        avengedplayer(var_1, var_2.lastkilledplayer);
      }
    }

    foreach(var_24, var_23 in var_2.damagedplayers) {
      if(level.teambased && var_10 - var_23 < 1750) {
        defendedplayer(var_1, var_24);
        LOC_000005af:
      }
      LOC_000005af:
    }

    if(var_14) {
      var_25 = getshotdistancetype(self, var_3, var_4, var_13, var_2);

      switch (var_25) {
        case "pointblank":
          thread pointblank(var_1);
          break;
        case "longshot":
          thread longshot(var_1);
          var_26 = scripts\engine\math::round_float(distance(var_13, var_2.origin) / 39.37, 2);
          self setclientomnvar("ui_longshot_dist", var_26);
          self setclientomnvar("ui_longshot_special", update_future_stations_track_timers(var_13, var_2, var_3));
          break;
        case "very_longshot":
          thread longshot(var_1);
          thread very_longshot(var_1);
          var_26 = scripts\engine\math::round_float(distance(var_13, var_2.origin) / 39.37, 2);
          self setclientomnvar("ui_longshot_dist", var_26);
          self setclientomnvar("ui_longshot_special", update_future_stations_track_timers(var_13, var_2, var_3));
          break;
      }
    }

    if(isbackkill(self, var_2, var_4)) {
      if(var_3.basename == "iw8_knife_mp") {
        thread killeventtextpopup("backstab", 1);
        thread scripts\cp_mp\xmike109::givemidmatchaward("backstab");
      }

      self.modifiers["backstab"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 4;
    }

    if(var_14) {
      switch (weaponclass(var_3.basename)) {
        case "rifle":
          incpersstat("arKills", 1);
          incpersstat(var_2, "arDeaths", 1);

          if(var_4 == "MOD_HEAD_SHOT") {
            incpersstat("arHeadshots", 1);
          }

          break;
        case "smg":
          incpersstat("smgKills", 1);
          incpersstat(var_2, "smgDeaths", 1);

          if(var_4 == "MOD_HEAD_SHOT") {
            incpersstat("smgHeadshots", 1);
          }

          break;
        case "spread":
          incpersstat("shotgunKills", 1);
          incpersstat(var_2, "shotgunDeaths", 1);

          if(var_4 == "MOD_HEAD_SHOT") {
            incpersstat("shotgunHeadshots", 1);
          }

          break;
        case "mg":
          incpersstat("lmgKills", 1);
          incpersstat(var_2, "lmgDeaths", 1);

          if(var_4 == "MOD_HEAD_SHOT") {
            incpersstat("lmgHeadshots", 1);
          }

          break;
        case "sniper":
          incpersstat("sniperKills", 1);
          incpersstat(var_2, "sniperDeaths", 1);

          if(var_4 == "MOD_HEAD_SHOT") {
            incpersstat("sniperHeadshots", 1);
          }

          break;
        case "rocketlauncher":
          incpersstat("launcherKills", 1);
          incpersstat(var_2, "launcherDeaths", 1);

          if(var_4 == "MOD_HEAD_SHOT") {
            incpersstat("launcherHeadshots", 1);
          }

          break;
        case "pistol":
          incpersstat("pistolKills", 1);
          incpersstat(var_2, "pistolDeaths", 1);

          if(var_4 == "MOD_HEAD_SHOT") {
            incpersstat("pistolHeadshots", 1);
          }

          break;
      }

      if(var_4 == "MOD_MELEE") {
        incpersstat("meleeKills", 1);
        incpersstat(var_2, "meleeDeaths", 1);
      }

      if(scripts\cp\utility::_hasperk("specialty_bulletdamage")) {
        incpersstat("stoppingPowerKills", 1);

        if(!isDefined(self.stoppingpowerkills)) {
          self.stoppingpowerkills = 0;
        }

        self.stoppingpowerkills++;
      }

      if(scripts\cp\utility::_hasperk("specialty_quieter")) {
        incpersstat("deadSilenceKills", 1);

        if(!isDefined(self.deadsilencekills)) {
          self.deadsilencekills = 0;
        }

        self.deadsilencekills++;
      }

      if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
        foreach(var_28 in level.supportdrones) {
          if(var_28.owner == self && var_28.helperdronetype == "radar_drone_overwatch") {
            incpersstat(var_28.owner, "killstreakPersonalUAVKills", 1);
            break;
          }
        }
      }

      if(issurvivorkill(self)) {
        thread givekillreward("low_health_kill", var_1, var_3, "low_health_kill");
      }

      if(scripts\cp\utility\player::isplayerads()) {
        self.modifiers["ads"] = 1;
        self.modifiers["mask"] = self.modifiers["mask"] | 8;
        incpersstat("adsKills", 1);
      } else if(var_19) {
        self.modifiers["hipfire"] = 1;
        self.modifiers["mask"] = self.modifiers["mask"] | 16;
        incpersstat("hipfireKills", 1);
      }

      if(!self isonground()) {
        self.modifiers["airborne"] = 1;
      }

      if(isPlayer(var_2) || isagent(var_2)) {
        if(!var_2 isonground()) {
          self.modifiers["victim_airborne"] = 1;
        }
      }

      if(self playermount() >= 0.5) {
        self.modifiers["mounted"] = 1;
        self.modifiers["mask"] = self.modifiers["mask"] | 32;
      }

      if(var_19) {
        self.modifiers["bullet_damage"] = 1;
        var_30 = self getweaponammoclip(var_3);

        if(var_30 <= 0) {
          self.modifiers["last_bullet_kill"] = 1;
          self.modifiers["mask"] = self.modifiers["mask"] | 64;
        }
      }

      if(isPlayer(var_2) || isagent(var_2)) {
        if(var_2 issprinting()) {
          self.modifiers["victim_sprinting"] = 1;
          self.modifiers["mask"] = self.modifiers["mask"] | 128;
        }
      }

      if(level.teambased) {
        foreach(var_32 in level.players) {
          if(!scripts\cp\utility\player::isreallyalive(var_32)) {
            continue;
          }

          if(distancesquared(self.origin, var_32.origin) < 90000) {
            self.modifiers["buddy_kill"] = 1;
            break;
          }
          LOC_00000bcb:
        }
      }
    } else if(var_13 == "weapon_projectile") {
      if(isDefined(var_5) && isDefined(var_5.adsfire)) {
        if(var_5.adsfire) {
          self.modifiers["ads"] = 1;
          self.modifiers["mask"] = self.modifiers["mask"] | 8;
        } else {
          self.modifiers["hipfire"] = 1;
          self.modifiers["mask"] = self.modifiers["mask"] | 16;
        }
      }
    }

    if(isPlayer(var_2) || isagent(var_2)) {
      if(!var_2 isonground() && !var_2 iswallrunning() && !self isonground() && !self iswallrunning()) {
        if(var_14) {
          thread givekillreward("air_to_air_kill", var_1, var_3, "air_to_air_kill");
        }
      } else {
        if(var_14) {
          if(self iswallrunning()) {
            thread givekillreward("wallkill", var_1, var_3, "wallrun_kill");
          } else if(isdeathfromabove(self, var_3, var_4, var_13, var_2)) {
            thread givekillreward("jumpkill", var_1, var_3, "air_kill");
          } else if(events_issliding()) {
            thread givekillreward("slidekill", var_1, var_3, "slide_kill");
            self.modifiers["sliding"] = 1;
            self.modifiers["mask"] = self.modifiers["mask"] | 256;
          }

          var_34 = self getstance();

          switch (var_34) {
            case "prone":
              self.modifiers["prone_kill"] = 1;
              self.modifiers["mask"] = self.modifiers["mask"] | 512;
              break;
            case "crouch":
              self.modifiers["crouch_kill"] = 1;
              self.modifiers["mask"] = self.modifiers["mask"] | 1024;
              break;
          }
        }

        if(var_2 iswallrunning()) {
          thread givekillreward("killonwall", var_1, var_3, "kill_wallrunner");
        } else if(isskeetshooter(self, var_3, var_4, var_13, var_2)) {
          thread givekillreward("killinair", var_1, var_3, "kill_jumper");
        }
      }
    }

    if(isDefined(var_2.streakdata)) {
      foreach(var_36 in var_2.streakdata.streaks) {
        var_37 = var_36.currentcost - var_2.streakpoints;

        if(var_37 > 0 && var_37 <= 1) {
          buzzkill(var_1, var_2);
          break;
        }
      }
    }

    if(var_14 && isPlayer(self) && !isagent(self) && !isscriptedagent(self)) {
      if(self ismantling()) {
        thread killeventtextpopup("mantle_kill", 1);
        thread scripts\cp_mp\xmike109::givemidmatchaward("mantle_kill");
      }

      if(isDefined(self.tookweaponfrom) && isDefined(self.tookweaponfrom[var_12]) && self.tookweaponfrom[var_12] == var_2) {
        thread killeventtextpopup("backfire", 1);
        thread scripts\cp_mp\xmike109::givemidmatchaward("backfire");
      }
    }

    if(isDefined(var_2.stuckbygrenade)) {
      level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_semtex", undefined, 0.75);
    }

    if(scripts\cp\cp_weapons::isthrowingknife(var_3.basename)) {
      thread killeventtextpopup("throwingknife_kill", 1);
      thread scripts\cp_mp\xmike109::givemidmatchaward("throwingknife_kill");
    }

    if(isDefined(var_2.chopper_playfx) && isDefined(var_2.chopper_playfx.owner)) {
      if(var_2.chopper_playfx.owner != self) {
        thread killeventtextpopup("assist_decoy");
      }
    }

    var_39 = self.pers["cur_kill_streak"] + 1;
    var_40 = 5;

    if(level.gametype == "arm") {
      var_40 = 10;
    }

    if(!(var_39 % var_40)) {
      if(!isDefined(self.lastkillsplash) || var_39 != self.lastkillsplash) {
        thread scripts\cp\cp_hud_util::teamplayercardsplash("callout_kill_streaking", self, undefined, var_39);
        self.lastkillsplash = var_39;
      }

      if(var_39 <= 30) {
        thread killeventtextpopup("streak_" + var_39, 1);
        thread scripts\cp_mp\xmike109::givemidmatchaward("streak_" + var_39);
      }
    }

    if(var_39 % 5) {}

    if(var_39 > 30) {
      thread killeventtextpopup("streak_max", 1);
      thread scripts\cp_mp\xmike109::givemidmatchaward("streak_max");
    }

    if(isDefined(var_5) && istrue(var_5.isequipment) && var_4 == "MOD_IMPACT" && !scripts\cp\cp_weapons::isthrowingknife(var_3.basename)) {
      thread scripts\cp_mp\xmike109::givemidmatchaward("item_impact");
      self.modifiers["item_impact"] = 1;
    }

    if(scripts\cp\cp_weapons::islauncherdirectimpactdamage(var_3, var_4)) {
      thread killeventtextpopup("launcher_direct_hit", 1);
      thread scripts\cp_mp\xmike109::givemidmatchaward("launcher_direct_hit");
      self.modifiers["launcher_impact"] = 1;
    }

    if(var_18 >= 0.6428) {
      self.modifiers["victim_in_standard_view"] = 1;
    }

    if(isDefined(self.lastadsstarttime) && var_10 - self.lastadsstarttime <= 500 && var_13 == "weapon_sniper") {
      self.modifiers["quickscope"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 2048;
    }

    if(self.health <= 50) {
      self.modifiers["low_health_kill"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 4096;
    }

    if(isDefined(self.lastweaponchangetime) && var_10 - self.lastweaponchangetime <= 1500) {
      self.modifiers["weapon_change_kill"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 8192;
    }

    if(isDefined(self.lastweaponpickuptime) && var_10 - self.lastweaponpickuptime <= 1500) {
      self.modifiers["weapon_pickup_kill"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 16384;
    }

    if(isDefined(self.lastreloadtime) && var_10 - self.lastreloadtime <= 1500) {
      self.modifiers["reload_kill"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 65536;
    }

    if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
      self.modifiers["in_vehicle"] = 1;
      self.modifiers["mask2"] = self.modifiers["mask2"] | 4096;
    }

    if(var_2 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      self.modifiers["victim_in_vehicle"] = 1;
      self.modifiers["mask2"] = self.modifiers["mask2"] | 8192;
    }

    if(istrue(var_2.isdefusing)) {
      self.modifiers["killed_defuser"] = 1;
    }

    if(scripts\cp\cp_weapon::iscacsecondaryweapon(var_3)) {
      self.modifiers["secondary_weapon"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 131072;
    }

    thread checkmatchdatakills(var_1, var_2);
  }

  if(!isDefined(self.killedplayers[var_8])) {
    self.killedplayers[var_8] = 0;
  }

  if(!isDefined(var_2.killedby[var_9])) {
    var_2.killedby[var_9] = 0;
  }

  self.killedplayers[var_8]++;
  var_2.killedby[var_9]++;
  var_2.lastkilledby = self;

  if(isPlayer(var_2)) {
    if(!var_2 scripts\cp\utility::isusingremote() && (!var_2 scripts\cp\utility::_hasperk("specialty_survivor") || istrue(var_2.inlaststand))) {
      var_2 thread scripts\cp\utility::setdof_killer();
    }
  }

  scripts\asm\soldier\mp\melee::bufferednotify("kill_event_buffered", var_2, var_12, var_4, self.modifiers);
}

function unsetreduceregendelayonkills(var_0) {
  return isDefined(var_0) && isDefined(var_0.vehiclename) && isDefined(var_0.streakinfo);
}

function checkkillstreakkillevents(var_0, var_1, var_2) {
  var_3 = scripts\cp\utility::iskillstreakweapon(var_0.basename) || unsetreduceregendelayonkills(var_2);
  var_4 = scripts\cp\agents\gametype_cp_wave_sv::unset_relic_doomslayer(var_0);

  if(var_3 && !var_4) {
    var_5 = level.killstreakweaponmap[var_0.basename];
    var_6 = 0;
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;

    if(!isDefined(var_5)) {
      return;
    }

    switch (var_5) {
      case "bradley":
        incpersstat("killstreakTankKills", 1);
        var_7 = 1;
        var_9 = 1;
        break;
      case "chopper_gunner":
        incpersstat("killstreakChopperGunnerKills", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      case "chopper_support":
        incpersstat("killstreakChopperSupportKills", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      case "cruise_predator":
        incpersstat("killstreakCruiseMissileKills", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      case "fuel_airstrike":
        var_7 = 1;
        break;
      case "gunship":
        incpersstat("killstreakGunshipKills", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      case "hover_jet":
        incpersstat("killstreakVTOLJetKills", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      case "juggernaut":
        incpersstat("killstreakJuggernautKills", 1);
        var_7 = 1;
        var_9 = 1;
        break;
      case "manual_turret":
        incpersstat("killstreakShieldTurretKills", 1);
        var_7 = 1;
        var_9 = 1;
        break;
      case "multi_airstrike":
        var_7 = 1;
        break;
      case "pac_sentry":
        incpersstat("killstreakWheelsonKills", 1);
        var_7 = 1;
        var_9 = 1;
        break;
      case "precision_airstrike":
        incpersstat("killstreakAirstrikeKills", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      case "sentry_gun":
        incpersstat("killstreakSentryGunKills", 1);
        var_7 = 1;
        var_9 = 1;
        break;
      case "toma_strike":
        incpersstat("killstreakCluserStrikeKills", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      case "white_phosphorus":
        incpersstat("killstreakWhitePhosphorousKillsAssists", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      default:
        thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("killstreak_full_score", var_0);
        break;
    }

    if(isDefined(var_2.streakinfo)) {
      if(!isDefined(var_2.streakinfo.kills)) {
        var_2.streakinfo.kills = 0;
      }

      var_2.streakinfo.kills++;
    }

    incpersstat("killstreakKills", 1);

    if(var_8) {
      incpersstat("killstreakAirKills", 1);
    }

    if(var_9) {
      incpersstat("killstreakGroundKills", 1);
    }

    if(var_7) {
      thread scripts\cp_mp\xmike109::givemidmatchaward("ss_kill_" + var_5, undefined, undefined, undefined, undefined, undefined, var_6);
    }

    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_killstreak", undefined, 0.75);
    return;
  }
}

function killedkillstreak(var_0, var_1, var_2) {
  if(scripts\cp\utility::iskillstreakweapon(var_2.basename)) {
    thread checkkillstreakkillevents(var_2, undefined, var_1);
  } else {
    var_3 = "kill_ss_" + var_0;
    var_1 thread scripts\cp_mp\xmike109::givemidmatchaward(var_3);
    incpersstat(var_1, "destroyedKillstreaks", 1);
    level thread scripts\cp\cp_player_battlechatter::saytoself(var_1, "plr_killstreak_destroy", undefined, 0.75);
  }

  if(isDefined(var_1.perk_data) && var_1 scripts\cp\utility::_hasperk("specialty_chain_killstreaks")) {
    var_4 = 10;
    var_5 = var_4 * var_1.perk_data["super_fill_scalar"];
    var_1 scripts\cp\coop_super::increase_super_progress(var_5);
    return;
  }
}

function is_enemy_highest_score(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(var_3.score > var_0.score) {
      return false;
    }
  }

  return true;
}

function getshotdistancetype(var_0, var_1, var_2, var_3, var_4) {
  if(isalive(var_0) && !var_0 scripts\cp\utility::isusingremote() && (var_2 == "MOD_RIFLE_BULLET" || var_2 == "MOD_PISTOL_BULLET" || var_2 == "MOD_HEAD_SHOT") && !scripts\cp\utility::iskillstreakweapon(var_1.basename) && !istrue(var_0.assistedsuicide)) {
    var_5 = distancesquared(var_3, var_4.origin);

    if(var_5 < 9216) {
      return "pointblank";
    }

    if(var_5 > 4000000) {
      return "very_longshot";
    }

    var_6 = scripts\cp\cp_weapon::getweapongroup(var_1.basename);
    var_7 = undefined;

    switch (var_6) {
      case "weapon_pistol":
        var_7 = 800;
        break;
      case "weapon_beam":
      case "weapon_smg":
        var_7 = 1200;
        break;
      case "weapon_assault":
      case "weapon_dmr":
      case "weapon_lmg":
        var_7 = 1500;
        break;
      case "weapon_rail":
      case "weapon_sniper":
        var_7 = 2000;
        break;
      case "weapon_shotgun":
        var_7 = 500;
        break;
      case "weapon_projectile":
      default:
        var_7 = 1536;
        break;
    }

    var_8 = var_7 * var_7;

    if(var_5 > var_8) {
      return "longshot";
    }
  }

  return "none";
}

function update_future_stations_track_timers(var_0, var_1, var_2) {
  var_3 = distancesquared(var_0, var_1.origin);
  var_4 = scripts\cp\cp_weapon::getweapongroup(var_2.basename);
  var_5 = undefined;

  switch (var_4) {
    case "weapon_pistol":
      var_5 = 1500;
      break;
    case "weapon_beam":
    case "weapon_smg":
      var_5 = 2000;
      break;
    case "weapon_dmr":
      var_5 = 4000;
      break;
    case "weapon_assault":
    case "weapon_lmg":
      var_5 = 3000;
      break;
    case "weapon_rail":
    case "weapon_sniper":
      var_5 = 8000;
      break;
    case "weapon_shotgun":
      var_5 = 1000;
      break;
    case "weapon_projectile":
      var_5 = 4000;
      break;
    default:
      var_5 = 4000;
      break;
  }

  var_6 = var_5 * var_5;
  return var_3 > var_6;
}

function isdeathfromabove(var_0, var_1, var_2, var_3, var_4) {
  if(isalive(var_0) && var_0 isjumping() && scripts\engine\utility::isbulletdamage(var_2)) {
    var_5 = var_0.origin[2] - var_4.origin[2];
    return (var_5 > 60);
  }

  return false;
}

function isskeetshooter(var_0, var_1, var_2, var_3, var_4) {
  return isalive(var_0) && var_4 isjumping() && scripts\engine\utility::isbulletdamage(var_2);
}

function isbackkill(var_0, var_1, var_2) {
  if(!isPlayer(var_0) || !isPlayer(var_1)) {
    return false;
  }

  if(var_2 != "MOD_RIFLE_BULLET" && var_2 != "MOD_PISTOL_BULLET" && var_2 != "MOD_MELEE" && var_2 != "MOD_HEAD_SHOT") {
    return false;
  }

  var_3 = var_1 getplayerangles();
  var_4 = var_0 getplayerangles();
  var_5 = angleclamp180(var_3[1] - var_4[1]);

  if(abs(var_5) < 80) {
    return true;
  }

  return false;
}

function issurvivorkill(var_0) {
  return var_0.health > 0 && var_0.health < var_0.maxhealth * 0.2;
}

function checkmatchdatakills(var_0, var_1) {
  if(isDefined(self.lastkilledby) && self.lastkilledby == var_1) {
    self.lastkilledby = undefined;
    revenge(var_0, var_1);
    return;
  }
}

function givekillreward(var_0, var_1, var_2, var_3) {
  self.modifiers[var_0] = 1;

  if(isDefined(var_3)) {
    thread scripts\cp_mp\xmike109::givemidmatchaward(var_3);
    return;
  }

  thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints(var_0, var_2);
}

function proximityassist(var_0) {
  self.modifiers["proximityAssist"] = 1;
  thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("proximityassist");
}

function proximitykill(var_0) {
  self.modifiers["proximityKill"] = 1;
  thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("proximitykill");
}

function longshot(var_0) {
  self.modifiers["longshot"] = 1;
  self.modifiers["mask"] = self.modifiers["mask"] | 262144;
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "longshot");
  incpersstat("longshotKills", 1);
  thread killeventtextpopup("longshot", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("longshot");
}

function very_longshot(var_0) {
  self.modifiers["very_longshot"] = 1;
}

function pointblank(var_0) {
  self.modifiers["pointblank"] = 1;
  self.modifiers["mask"] = self.modifiers["mask"] | 524288;
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "pointblank");
  thread killeventtextpopup("pointblank", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("pointblank");
  incpersstat("pointBlankKills", 1);
}

function headshot(var_0) {
  self.modifiers["headshot"] = 1;
  self.modifiers["mask"] = self.modifiers["mask"] | 1048576;
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "headshot");
  thread killeventtextpopup("headshot", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("headshot");
}

function avengedplayer(var_0, var_1) {
  self.modifiers["avenger"] = 1;
  self.modifiers["mask"] = self.modifiers["mask"] | 2097152;
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "avenger");
  incpersstat("avengerKills", 1);
  thread killeventtextpopup("avenger", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("avenger");
}

function assistedsuicide(var_0, var_1) {
  self.modifiers["assistedsuicide"] = 1;
  thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("assistedsuicide", var_1);
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "assistedsuicide");
  thread killeventtextpopup("assistedsuicide", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("assistedsuicide");
}

function defendedplayer(var_0, var_1) {
  self.modifiers["defender"] = 1;
  self.modifiers["mask2"] = self.modifiers["mask2"] | 4194304;
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "defender");
  incpersstat("defenderKills", 1);
  var_2 = scripts\cp\utility::getplayerforguid(var_1);
  thread killeventtextpopup("savior", 0);
  thread scripts\cp_mp\xmike109::givemidmatchaward("save_teammate");
}

function postdeathkill(var_0) {
  self.modifiers["posthumous"] = 1;
  self.modifiers["mask"] = self.modifiers["mask"] | 8388608;
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "posthumous");
  thread killeventtextpopup("posthumous", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("posthumous");
}

function revenge(var_0, var_1) {
  self.modifiers["revenge"] = 1;
  self.modifiers["mask"] = self.modifiers["mask"] | 16777216;
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "revenge");
  incpersstat("revengeKills", 1);
  thread killeventtextpopup("revenge", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("revenge");
}

function multikill(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.inneurotoxintimestamp)) {
    self.inneurotoxintimestamp = var_1;
  }

  if(var_1 < self.inneurotoxintimestamp) {
    return;
  }

  self notify("multiKill");
  self endon("multiKill");
  waitframe();
  var_4 = undefined;
  var_5 = undefined;

  switch (var_1) {
    case 2:
      var_4 = "double";
      break;
    case 3:
      var_4 = "triple";
      var_5 = "callout_3xkill";
      break;
    case 4:
      var_4 = "four";
      var_5 = "callout_4xkill";
      break;
    case 5:
      var_4 = "five";
      var_5 = "callout_5xkill";
      break;
    case 6:
      var_4 = "six";
      var_5 = "callout_6xkill";
      break;
    case 7:
      var_4 = "seven";
      var_5 = "callout_7xkill";
      break;
    case 8:
      var_4 = "eight";
      var_5 = "callout_8xkill";
      break;
    default:
      var_4 = "multi";
      var_5 = "callout_9xkill";
      break;
  }

  if(isDefined(self.pers["highestMultikill"]) && var_1 > self.pers["highestMultikill"]) {
    self.pers["highestMultikill"] = var_1;
  }

  thread scripts\cp\agents\agents::logmultikill(var_0, var_1);

  if(isDefined(var_4)) {
    thread killeventtextpopup(var_4, scripts\engine\utility::ter_op(isDefined(var_2), var_2, 1), istrue(var_3));

    if(!istrue(var_3)) {
      thread scripts\cp_mp\xmike109::givemidmatchaward(var_4, undefined, undefined, undefined, undefined, undefined, undefined, undefined, self getcurrentweapon());
    }
  }

  if(isDefined(var_5)) {
    if(!istrue(var_3)) {
      thread playbattlechattersoundsplitscreen(self, var_5, undefined, self);
      return;
    }

    thread scripts\cp\cp_hud_util::teamplayercardsplash(var_5, self, self.team, undefined, 1);
    return;
  }
}

function playbattlechattersoundsplitscreen(var_0, var_1, var_2, var_3) {
  var_0 thread scripts\cp\cp_hud_message::showsplash(var_1, var_2, var_3);
}

function firstblood(var_0) {
  self.modifiers["firstblood"] = 1;
  self.modifiers["mask"] = self.modifiers["mask"] | 33554432;
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "firstblood");
  thread scripts\cp\cp_hud_util::teamplayercardsplash("callout_firstblood", self);
  thread killeventtextpopup("firstblood", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("firstblood");
}

function winningshot(var_0) {}

function buzzkill(var_0, var_1) {
  self.modifiers["buzzkill"] = var_1.pers["cur_kill_streak"];
  self.modifiers["mask"] = self.modifiers["mask"] | 67108864;
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "buzzkill");
  thread killeventtextpopup("buzzkill", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("buzzkill");
}

function comeback(var_0) {
  self.modifiers["comeback"] = 1;
  self.modifiers["mask"] = self.modifiers["mask"] | 134217728;
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "comeback");
  thread killeventtextpopup("comeback", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("comeback");
  incpersstat("comebackKills", 1);
}

function collateral(var_0) {
  if(var_0 == 2) {
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_twofer", undefined, 0.75);
    thread killeventtextpopup("one_shot_two_kills", 1);
    thread scripts\cp_mp\xmike109::givemidmatchaward("one_shot_two_kills");
  }

  if(var_0 == 3) {
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_threefer", undefined, 0.75);
    return;
  }
}

function shotguncollateral(var_0) {}

function quadfeed(var_0, var_1) {
  self.modifiers["quadfeed"] = 1;
  self.modifiers["mask"] = self.modifiers["mask"] | 536870912;
  thread killeventtextpopup("quad_feed", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("quad_feed");
}

function disconnected() {
  var_0 = self.guid;

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(isDefined(level.players[var_1].killedplayers[var_0])) {
      level.players[var_1].killedplayers[var_0] = undefined;
    }

    if(isDefined(level.players[var_1].killedby[var_0])) {
      level.players[var_1].killedby[var_0] = undefined;
    }
  }
}

function monitorhealed() {
  level endon("end_game");

  for(;;) {
    level waittill("healed", var_0);
    var_0 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("healed");
  }
}

function updaterecentkills(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");

  if(!isDefined(self.recentkillcount)) {
    self.recentkillcount = 0;
  }

  self.recentkillcount++;

  if(!isDefined(self.recentkillsperweapon)) {
    self.recentkillsperweapon = [];
  }

  if(!isDefined(self.recentkillsperweapon[var_3])) {
    self.recentkillsperweapon[var_3] = 1;
  } else {
    self.recentkillsperweapon[var_3]++;
  }

  var_4 = scripts\cp\utility::getequipmenttype(var_2.basename);

  if(isDefined(var_4) && var_4 == "lethal" && var_2.basename != "throwingknife_mp") {
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_grenade", undefined, 0.75);
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_amf", undefined, 0.75);

    if(self.recentkillsperweapon[var_3] > 0 && self.recentkillsperweapon[var_3] % 2 == 0) {
      thread killeventtextpopup("grenade_double", 1);
      thread scripts\cp_mp\xmike109::givemidmatchaward("grenade_double");
    }
  }

  scripts\asm\soldier\mp\melee::bufferednotify("update_rapid_kill_buffered", self.recentkillcount, var_3);

  if(self.recentkillcount > 1) {
    thread multikill(var_0, self.recentkillcount, 0);
  }

  wait 2.5;

  if(self.recentkillcount > 1) {
    thread multikill(var_0, self.recentkillcount, 1, 1);

    if(self.recentkillcount > 2) {}
  }

  incpersstat("mostMultikills", 1);
  self.recentkillcount = 0;
  self.recentdefendcount = 0;
  self.recentkillsperweapon = undefined;
}

function monitorcratejacking() {
  level endon("end_game");
  self endon("disconnect");

  for(;;) {
    self waittill("hijacker", var_0, var_1);
    thread scripts\cp_mp\xmike109::givemidmatchaward("ss_use_enemy_dronedrop");
    var_2 = "hijacked_airdrop";

    if(isDefined(var_1)) {
      var_1 scripts\cp\cp_hud_message::showsplash(var_2, undefined, self);
    }
  }
}

function updatequadfeedcounter(var_0, var_1) {
  if(isDefined(level.quadfeedinfo) && gettime() - level.quadfeedinfo.starttime > 5000) {
    level.quadfeedinfo = undefined;
  }

  if(!isDefined(level.quadfeedinfo) || level.quadfeedinfo.player != var_0) {
    var_2 = spawnStruct();
    var_2.player = var_0;
    var_2.starttime = gettime();
    var_2.feedcount = 1;
    level.quadfeedinfo = var_2;
    return;
  }

  var_2 = level.quadfeedinfo;
  var_2.feedcount++;

  if(var_2.feedcount == 4) {
    quadfeed(var_2.player, var_2, var_2);
    level.quadfeedinfo = undefined;
    return;
  }
}

function initslidemonitor() {
  self.eventswassliding = self issprintsliding();
  self.eventsslideendtime = undefined;
}

function events_monitorslideupdate() {
  if(scripts\cp\utility\player::isreallyalive(self)) {
    var_0 = self issprintsliding();

    if(istrue(self.eventswassliding) && !var_0) {
      self.eventsslideendtime = gettime();
    }

    self.eventswassliding = var_0;
    return;
  }

  self.eventswassliding = 0;
  self.eventsslideendtime = undefined;
}

function events_issliding() {
  if(self issprintsliding()) {
    return true;
  }

  events_monitorslideupdate();

  if(isDefined(self.eventsslideendtime)) {
    if(gettime() - self.eventsslideendtime <= 150) {
      return true;
    }
  }

  return false;
}

function initmonitoradstime() {
  self.wasads = scripts\cp\utility\player::isplayerads();
  self.lastadsstarttime = 0;
}

function monitoradstime() {
  if(scripts\cp\utility\player::isplayerads()) {
    if(!self.wasads) {
      self.lastadsstarttime = gettime();
      self.wasads = 1;
      return;
    }

    return;
  }

  self.wasads = 0;
}

function monitorreload() {
  level endon("game_ended");
  self endon("disconnect");
  self.lastreloadtime = 0;

  for(;;) {
    self waittill("reload");
    self.lastreloadtime = gettime();
    incpersstat("reloads", 1);
  }
}

function monitorweaponpickup() {
  level endon("game_ended");
  self endon("disconnect");
  self.lastweaponpickuptime = 0;

  for(;;) {
    self waittill("weapon_pickup");
    self.lastweaponpickuptime = gettime();
    incpersstat("weaponPickups", 1);
  }
}

function monitorweaponswitch() {
  level endon("game_ended");
  self endon("disconnect");
  self.lastweaponchangetime = 0;

  for(;;) {
    self waittill("weapon_change");
    self.lastweaponchangetime = gettime();
  }
}

function updateweaponchangetime() {
  self.lastweaponchangetime = gettime();
}

function initstancetracking() {
  self.laststance = self getstance();
  self.laststancechangetime = gettime();
  self.laststancetimes = [];
  self.laststancetimes["prone"] = 0;
  self.laststancetimes["crouch"] = 0;
  self.laststancetimes["stand"] = 0;
}

function updatestancetracking() {
  if(!isalive(self)) {
    return;
  }

  var_0 = self.mantlecur;
  self.mantlecur = self ismantling();

  if(!istrue(var_0) && self.mantlecur) {}

  var_1 = self.jumpcur;
  self.jumpcur = self isjumping();

  if(!istrue(var_1) && self.jumpcur) {}

  var_2 = self getstance();

  if(var_2 != self.laststance) {
    if(self.laststance == "crouch") {
      var_3 = self.laststancechangetime;
      var_4 = (gettime() - var_3) / 1000;
      incpersstat("timeCrouched", var_4);
    }

    if(self.laststance == "prone") {
      var_3 = self.laststancechangetime;
      var_4 = (gettime() - var_3) / 1000;
      incpersstat("timeProne", var_4);
    }

    self.laststancechangetime = gettime();

    if(!isDefined(self.pers["stanceTracking"])) {
      self.pers["stanceTracking"] = [];
      self.pers["stanceTracking"]["prone"] = 0;
      self.pers["stanceTracking"]["crouch"] = 0;
      self.pers["stanceTracking"]["stand"] = 0;
    }

    if(var_2 == "prone" || var_2 == "crouch" || var_2 == "stand") {
      self.pers["stanceTracking"][var_2]++;
    }
  }

  self.laststancetimes[var_2] = gettime();
  self.laststance = var_2;
}

function predatormissileimpact(var_0) {}

function largevehicleexplosion(var_0) {}

function vehiclekilled(var_0) {}

function missilefired(var_0) {
  thread trackmissile(var_0);
}

function trackmissile(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_0.whizbyplayers = [];

  for(;;) {
    var_1 = scripts\common\utility::playersnear(var_0.origin, 220);

    foreach(var_3 in var_1) {
      if(isDefined(var_0.owner) && var_3 == var_0.owner) {
        continue;
      }

      missilewhizby(var_3, var_0);
      var_0.whizbyplayers[var_3.guid] = 1;
    }

    wait 0.1;
  }
}

function missilewhizby(var_0, var_1) {}

function bombdefused(var_0) {
  var_1 = 0;
  var_2 = 0;

  if(!var_1) {
    var_3 = scripts\cp\utility::getplayersinradius(var_0.origin, 600);

    foreach(var_5 in var_3) {
      if(var_5.team != var_0.team) {
        var_2 = 1;
        break;
      }
    }
  }

  if(var_1) {
    var_0 thread scripts\cp_mp\xmike109::givemidmatchaward("mode_sd_last_defuse");
  } else {
    var_0 thread scripts\cp_mp\xmike109::givemidmatchaward("mode_sd_defuse");
  }

  incpersstat(var_0, "defuses", 1);

  if(isPlayer(var_0)) {
    var_0 thread scripts\cp\agents\agents::loggameevent("defuse", var_0.origin);
    return;
  }
}

function revivedplayer(var_0, var_1) {
  if(scripts\cp\utility::getgametype() == "cp_survival") {
    return;
  }
}

function doorused(var_0, var_1) {
  if(var_1) {
    var_0.lastdooropentime = gettime();
    return;
  }
}

function shothit() {}

function shotmissed() {}

function killeventtextpopup(var_0, var_1, var_2) {
  self endon("death_or_disconnect");

  if(!scripts\cp\drone\emp_drone::scoreeventhastext(var_0)) {
    return;
  }

  if(!scripts\cp\utility::turn_off_sniper_laser() && isDefined(self.totalxpearned) && isDefined(self.ref_11B7F)) {
    if(self.totalxpearned >= self.ref_11B7F) {
      return;
    }
  }

  if(!isDefined(self.killeventqueue)) {
    self.killeventqueue = [];
  }

  foreach(var_4 in self.killeventqueue) {
    if(var_4.scoreeventref == var_0) {
      return;
    }
  }

  var_6 = spawnStruct();
  var_6.scoreeventref = var_0;
  var_6.showassplash = istrue(var_1);
  var_6.priority = scripts\cp\drone\emp_drone::getscoreeventpriority(var_0);
  var_6.alwaysshowsplash = scripts\cp\drone\emp_drone::scoreeventalwaysshowassplash(var_0);
  var_6.ref_128AC = 0;
  var_6.ref_128AB = 0;
  var_6.matchdata_logplayerlife = istrue(var_2);
  self.killeventqueue[self.killeventqueue.size] = var_6;
  self notify("killEventTextPopup");
  self endon("killEventTextPopup");
  waitframe();

  if(!isDefined(self.splashpriorityqueue)) {
    self.splashpriorityqueue = [];
  }

  foreach(var_4 in self.killeventqueue) {
    insertbypriority(var_4);
  }

  self.killeventqueue = undefined;
  var_9 = 0;

  foreach(var_4 in self.splashpriorityqueue) {
    if(var_4.ref_128AC) {
      continue;
    }

    if(!istrue(level.removekilleventsplash) && istrue(var_4.showassplash) && (!var_9 || var_4.alwaysshowsplash)) {
      var_9 = 1;
      thread scripts\cp\cp_hud_message::showsplash(var_4.scoreeventref);
    }

    var_4.ref_128AC = 1;
  }

  foreach(var_4 in self.splashpriorityqueue) {
    if(var_4.ref_128AB || var_4.matchdata_logplayerlife) {
      continue;
    }

    thread scripts\cp\drone\emp_drone::scoreeventpopup(var_4.scoreeventref);
    var_4.ref_128AB = 1;
    wait getdvarfloat("scr_splash_kill_buffer", 0.25);
  }

  self.splashpriorityqueue = undefined;
}

function insertbypriority(var_0) {
  if(self.splashpriorityqueue.size == 0) {
    self.splashpriorityqueue[self.splashpriorityqueue.size] = var_0;
    return;
  }

  foreach(var_2 in self.splashpriorityqueue) {
    if(var_2.scoreeventref == var_0.scoreeventref) {
      return;
    }
  }

  for(var_4 = 0; var_4 < self.splashpriorityqueue.size; var_4++) {
    if(var_0.priority > self.splashpriorityqueue[var_4].priority) {
      self.splashpriorityqueue = scripts\engine\utility::array_insert(self.splashpriorityqueue, var_0, var_4);
      return;
    }
  }

  self.splashpriorityqueue[self.splashpriorityqueue.size] = var_0;
}

function initpersstat(var_0) {
  if(!isDefined(self.pers[var_0])) {
    self.pers[var_0] = 0;
    return;
  }
}

function getpersstat(var_0) {
  return self.pers[var_0];
}

function incpersstat(var_0, var_1) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers[var_0])) {
    self.pers[var_0] += var_1;
    return;
  }
}

function setextrascore0(var_0) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore0 = var_0;
  self.pers["extrascore0"] = var_0;
}

function setextrascore1(var_0) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore1 = var_0;
  self.pers["extrascore1"] = var_0;
}

function setextrascore2(var_0) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore2 = var_0;
  self.pers["extrascore2"] = var_0;
}

function setextrascore3(var_0) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore3 = var_0;
  self.pers["extrascore3"] = var_0;
}

function getplayerdataloadoutgroup() {
  if(level.rankedmatch) {
    return "rankedloadouts";
  }

  return "privateloadouts";
}

function setplayerdatagroups() {
  level.loadoutsgroup = getplayerdataloadoutgroup();
}

function canrecordcombatrecordstats() {
  return level.rankedmatch && !istrue(level.ignorescoring) && scripts\cp\utility::getgametype() != "infect";
}

function getstreakrecordtype(var_0) {
  if(isenumvaluevalid("mp", "LethalScorestreakStatItems", var_0)) {
    return "lethalScorestreakStats";
  }

  if(isenumvaluevalid("mp", "SupportScorestreakStatItems", var_0)) {
    return "supportScorestreakStats";
  }

  return undefined;
}

function execution(var_0) {
  self.modifiers["execution"] = 1;
  self.modifiers["mask2"] = self.modifiers["mask2"] | 256;
  thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("execution");
}

function stoppingpower_clearhcrdata() {
  self.killedplayers = [];
  self.killedby = [];
  self.lastkilledby = undefined;
  self.greatestuniqueplayerkills = 0;
  self.damagedplayers = [];
  self.lastkilltime = 0;
  self.lastkilldogtime = 0;
  self.recentkillcount = 0;
  self.recentdefendcount = 0;
  self.kills = 0;
  self.deaths = 0;
  self.pers["cur_kill_streak"] = 0;
  self.pers["cur_death_streak"] = 0;
  self.pers["cur_kill_streak_for_nuke"] = 0;
  self.tookweaponfrom = [];
  self.guid = scripts\cp\utility\player::getuniqueid();
  thread ref_1445A();
}

function ref_1445A() {
  self endon("death");
  self waittill("long_death");

  if(isDefined(self.attackers) && self.attackers.size > 0) {
    foreach(var_2, var_1 in self.attackers) {
      if(isPlayer(var_1)) {
        if(isDefined(self.attackerdata) && self.attackerdata.size > 0) {
          if(!isDefined(var_1.ref_119D4)) {
            var_1.ref_119D4 = [];
          }

          thread vip_playerdied(var_1, undefined, self, self.attackerdata[var_2].objweapon, self.attackerdata[var_2].smeansofdeath, var_1);
          thread scripts\mp\ammorestock::onplayerkilled(var_1, var_1, self.maxhealth, undefined, self.attackerdata[var_2].smeansofdeath, self.attackerdata[var_2].objweapon, self.attackerdata[var_2].ref_13417, var_1.modifiers);
          var_1 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("kill", self.attackerdata[var_2].objweapon);
          var_1.ref_119D4[self getentitynumber()] = 1;
        }
      }
    }

    return;
  }
}