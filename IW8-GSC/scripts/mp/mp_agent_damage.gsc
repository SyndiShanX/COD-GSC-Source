/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\mp_agent_damage.gsc
***********************************************/

function init() {
  scripts\cp_mp\utility\game_utility::teamwipedobituary();
  var0 = scripts\cp\utility::getgametype();

  if(!isDefined(var0)) {
    var0 = getDvar("NKTMKRMSKR");
  }

  var1 = 0;
  var2 = ["cp/cp_score_event_table.csv", "mp/score_event_table.csv"];
  var3 = 0;

  for(;;) {
    var4 = tablelookupbyrow(var2[var3], var1, 0);

    if(!isDefined(var4) || var4 == "") {
      break;
    }

    var5 = tablelookupbyrow(var2[var3], var1, level.getallselectableattachments.game_type_col[var0]);

    if(!isDefined(var5) || var5 == "") {
      var1++;
      continue;
    }

    if(var4 == "win" || var4 == "loss" || var4 == "tie") {
      var5 = float(var5);
    } else {
      var5 = int(var5);
    }

    if(var5 != -1) {
      scripts\cp\drone\emp_drone::registerscoreinfo(var4, "value", var5);
    }

    var6 = tablelookuprownum("mp/splashTable.csv", 0, var4);
    scripts\cp\drone\emp_drone::registerscoreinfo(var4, "eventID", var6);
    var6 = tablelookup("mp/splashTable.csv", 0, var4, 2);
    scripts\cp\drone\emp_drone::registerscoreinfo(var4, "text", var6);
    var6 = int(tablelookup("mp/splashTable.csv", 0, var4, 13));
    scripts\cp\drone\emp_drone::registerscoreinfo(var4, "priority", var6);
    var6 = int(tablelookup("mp/splashTable.csv", 0, var4, 14));
    scripts\cp\drone\emp_drone::registerscoreinfo(var4, "alwaysShowSplash", var6);
    var7 = tablelookuprownum("mp/splashTable.csv", 0, var4);

    if(isDefined(var7) && var7 != -1) {
      scripts\cp\drone\emp_drone::registerscoreinfo(var4, "splashID", var7);
    }

    var8 = tablelookupbyrow(var2[var3], var1, 4);
    scripts\cp\drone\emp_drone::registerscoreinfo(var4, "group", var8);
    var9 = tablelookupbyrow(var2[var3], var1, 3);

    if(isDefined(var9) && tolower(var9) == "true") {
      scripts\cp\drone\emp_drone::registerscoreinfo(var4, "allowBonus", 1);
    }

    var1++;
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
    level waittill("connected", var0);
    var0.killedplayers = [];
    var0.killedby = [];
    var0.lastkilledby = undefined;
    var0.greatestuniqueplayerkills = 0;
    var0.recentkillcount = 0;
    var0.recentdefendcount = 0;
    var0.lastkilltime = 0;
    var0.lastkilldogtime = 0;
    var0.damagedplayers = [];

    if(!isDefined(var0.pers["cur_kill_streak"])) {
      var0.pers["cur_kill_streak"] = 0;
    }

    if(!isDefined(var0.pers["cur_death_streak"])) {
      var0.pers["cur_death_streak"] = 0;
    }

    initslidemonitor(var0);
    initmonitoradstime(var0);
    thread monitorreload();
    thread monitorweaponpickup();
    var0.lastweaponchangetime = 0;
    initstancetracking(var0);
  }
}

function damagedplayer(var0, var1) {
  if(var1 < 50 && var1 > 10) {
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_damaged_light", undefined, 0.1);
    return;
  }

  level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_damaged_heavy", undefined, 0.1);
}

function playerworlddeath(var0, var1) {}

function killedplayernotifysys(var0, var1, var2, var3) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("killedPlayerNotify");
  self endon("killedPlayerNotify");

  if(!isDefined(self.killsinaframecount)) {
    self.killsinaframecount = 0;
  }

  self.killsinaframecount++;

  if(weaponclass(var2) == "spread") {
    if(!isDefined(self.shotgunkillsinaframecount)) {
      self.shotgunkillsinaframecount = 1;
    } else {
      self.shotgunkillsinaframecount++;

      if(self.shotgunkillsinaframecount >= 2) {
        shotguncollateral(self.shotgunkillsinaframecount);
      }
    }
  } else if(var3 == "MOD_PISTOL_BULLET" || var3 == "MOD_RIFLE_BULLET" || var3 == "MOD_HEAD_SHOT") {
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
  thread notifykilledplayer(var0, var1, var2, var3, self.killsinaframecount);
  self.killsinaframecount = 0;
  self.bulletkillsinaframecount = 0;
  self.shotgunkillsinaframecount = 0;
}

function notifykilledplayer(var0, var1, var2, var3, var4) {
  var5 = createheadicon(var2);

  for(var6 = 0; var6 < var4; var6++) {
    self notify("got_a_kill", var1, var5, var3);
    waitframe();
  }
}

function vip_playerdied(var0, var1, var2, var3, var4, var5, var6) {
  level.numkills++;
  checkkillstreakkillevents(var2, var3, var4);

  if(isai(var1) || isDefined(var1.classname) && var1.classname == "script_vehicle") {
    var1.guid = var1 getentitynumber();
  }

  var7 = var1.guid;
  var8 = self.guid;
  var9 = gettime();
  var10 = createheadicon(var2);
  thread killedplayernotifysys(var0, var1, var2, var3);
  thread updaterecentkills(var0, var1, var2, var10);
  thread updatequadfeedcounter(self, var0);
  self.prevlastkilltime = self.lastkilltime;
  self.lastkilltime = var9;
  self.lastkilledplayer = var1;
  self.lastkillvictimpos = var1.origin;

  if(isPlayer(self)) {
    if(self.deaths > 0) {
      var11 = self.kills / self.deaths;

      if(var11 > 3) {
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

  if(isDefined(self.damagedplayers) && isDefined(self.damagedplayers[var7])) {
    self.damagedplayers[var7] = undefined;
  }

  var12 = scripts\cp\cp_weapon::getweapongroup(var2.basename);

  if(!scripts\cp\utility::iskillstreakweapon(var2.basename) && !scripts\cp\utility::_hasperk("specialty_explosivebullets")) {
    if(var3 == "MOD_EXECUTION") {
      execution(var0);
    }

    if(var2.basename == "none" && !scripts\cp_mp\utility\player_utility::isinvehicle()) {
      return 0;
    }

    if(isDefined(var1.attackerposition)) {
      var13 = var1.attackerposition;
    } else {
      var13 = self.origin;
    }

    var14 = 1;

    if(isDefined(var5)) {
      var14 = var5 == self;
    }

    var15 = anglesToForward(self getplayerangles());
    var16 = var2.origin - var13;
    var17 = vectorNormalize(var16);
    var18 = vectordot(var15, var17);
    var19 = scripts\engine\utility::isbulletdamage(var4);

    if(var2.attackers.size == 1 && !isDefined(var2.attackers[var2.guid])) {
      if(var13 == "weapon_sniper" && var4 != "MOD_MELEE" && var10 == var2.attackerdata[self.guid].firsttimedamaged) {
        self.modifiers["oneshotkill"] = 1;
        self.modifiers["mask"] = self.modifiers["mask"] | 1;
        thread killeventtextpopup("one_shot_kill", 1);
        thread scripts\cp_mp\xmike109::givemidmatchaward("one_shot_kill");
        incpersstat("oneShotOneKills", 1);
      }

      if(var13 == "weapon_shotgun" && var4 != "MOD_MELEE" && var10 == var2.attackerdata[self.guid].firsttimedamaged) {
        self.modifiers["oneshotkill_shotgun"] = 1;
        incpersstat("oneShotOneKills", 1);
      }
    }

    if(var4 == "MOD_MELEE") {
      if(var13 != "weapon_melee" && var13 != "weapon_melee2") {
        thread killeventtextpopup("gun_butt", 1);
        thread scripts\cp_mp\xmike109::givemidmatchaward("gun_butt");
      }

      if(var3.basename == "iw8_fists_mp") {
        thread killeventtextpopup("fist_kill", 1);
        thread scripts\cp_mp\xmike109::givemidmatchaward("fist_kill");
      }
    }

    if(isPlayer(var2)) {
      var20 = var2 getheldoffhand();

      if(var20.basename == "frag_grenade_mp" || var20.basename == "cluster_grenade_mp") {
        self.modifiers["cooking"] = 1;
        self.modifiers["mask"] = self.modifiers["mask"] | 2;
      }
    }

    if(isDefined(self.assistedsuicide) && self.assistedsuicide) {
      assistedsuicide(var1, var3);
    }

    if(level.numkills == 1) {
      firstblood(var1);
    }

    if(isDefined(self.pers) && self.pers["cur_death_streak"] > 3) {
      comeback(var1);
    }

    if(var4 == "MOD_HEAD_SHOT" || isDefined(var7) && (var7 == "head" || var7 == "helmet" || var7 == "neck")) {
      level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_headshot", undefined, 0.75);
      headshot(var1);
    }

    if(isDefined(self.wasti) && self.wasti && var10 - self.spawntime <= 5000) {
      self.modifiers["jackintheboxkill"] = 1;
    }

    if(!scripts\cp\utility\player::isreallyalive(self) && isDefined(self.deathtime)) {
      var21 = gettime() - self.deathtime;

      if(var21 < 1500 && var21 > 0) {
        postdeathkill(var1);
      }

      if(scripts\cp\utility::issimultaneouskillenabled()) {
        if(var21 == 0 && isDefined(self.lastattacker) && self.lastattacker == var2) {
          thread killeventtextpopup("simultaneous_kill", 0);
          thread scripts\cp_mp\xmike109::givemidmatchaward("simultaneous_kill", undefined, undefined, 1);
          thread killeventtextpopup(var2, "simultaneous_kill");
          var2 thread scripts\cp_mp\xmike109::givemidmatchaward("simultaneous_kill", undefined, undefined, 1);
        }
      }
    }

    if(isDefined(var2.lastkilltime) && level.teambased && var10 - var2.lastkilltime < 1500) {
      if(isDefined(var2.lastkilledplayer) && var2.lastkilledplayer != self) {
        avengedplayer(var1, var2.lastkilledplayer);
      }
    }

    foreach(var24, var23 in var2.damagedplayers) {
      if(level.teambased && var10 - var23 < 1750) {
        defendedplayer(var1, var24);
        LOC_000005af:
      }
      LOC_000005af:
    }

    if(var14) {
      var25 = getshotdistancetype(self, var3, var4, var13, var2);

      switch (var25) {
        case "pointblank":
          thread pointblank(var1);
          break;
        case "longshot":
          thread longshot(var1);
          var26 = scripts\engine\math::round_float(distance(var13, var2.origin) / 39.37, 2);
          self setclientomnvar("ui_longshot_dist", var26);
          self setclientomnvar("ui_longshot_special", update_future_stations_track_timers(var13, var2, var3));
          break;
        case "very_longshot":
          thread longshot(var1);
          thread very_longshot(var1);
          var26 = scripts\engine\math::round_float(distance(var13, var2.origin) / 39.37, 2);
          self setclientomnvar("ui_longshot_dist", var26);
          self setclientomnvar("ui_longshot_special", update_future_stations_track_timers(var13, var2, var3));
          break;
      }
    }

    if(isbackkill(self, var2, var4)) {
      if(var3.basename == "iw8_knife_mp") {
        thread killeventtextpopup("backstab", 1);
        thread scripts\cp_mp\xmike109::givemidmatchaward("backstab");
      }

      self.modifiers["backstab"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 4;
    }

    if(var14) {
      switch (weaponclass(var3.basename)) {
        case "rifle":
          incpersstat("arKills", 1);
          incpersstat(var2, "arDeaths", 1);

          if(var4 == "MOD_HEAD_SHOT") {
            incpersstat("arHeadshots", 1);
          }

          break;
        case "smg":
          incpersstat("smgKills", 1);
          incpersstat(var2, "smgDeaths", 1);

          if(var4 == "MOD_HEAD_SHOT") {
            incpersstat("smgHeadshots", 1);
          }

          break;
        case "spread":
          incpersstat("shotgunKills", 1);
          incpersstat(var2, "shotgunDeaths", 1);

          if(var4 == "MOD_HEAD_SHOT") {
            incpersstat("shotgunHeadshots", 1);
          }

          break;
        case "mg":
          incpersstat("lmgKills", 1);
          incpersstat(var2, "lmgDeaths", 1);

          if(var4 == "MOD_HEAD_SHOT") {
            incpersstat("lmgHeadshots", 1);
          }

          break;
        case "sniper":
          incpersstat("sniperKills", 1);
          incpersstat(var2, "sniperDeaths", 1);

          if(var4 == "MOD_HEAD_SHOT") {
            incpersstat("sniperHeadshots", 1);
          }

          break;
        case "rocketlauncher":
          incpersstat("launcherKills", 1);
          incpersstat(var2, "launcherDeaths", 1);

          if(var4 == "MOD_HEAD_SHOT") {
            incpersstat("launcherHeadshots", 1);
          }

          break;
        case "pistol":
          incpersstat("pistolKills", 1);
          incpersstat(var2, "pistolDeaths", 1);

          if(var4 == "MOD_HEAD_SHOT") {
            incpersstat("pistolHeadshots", 1);
          }

          break;
      }

      if(var4 == "MOD_MELEE") {
        incpersstat("meleeKills", 1);
        incpersstat(var2, "meleeDeaths", 1);
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
        foreach(var28 in level.supportdrones) {
          if(var28.owner == self && var28.helperdronetype == "radar_drone_overwatch") {
            incpersstat(var28.owner, "killstreakPersonalUAVKills", 1);
            break;
          }
        }
      }

      if(issurvivorkill(self)) {
        thread givekillreward("low_health_kill", var1, var3, "low_health_kill");
      }

      if(scripts\cp\utility\player::isplayerads()) {
        self.modifiers["ads"] = 1;
        self.modifiers["mask"] = self.modifiers["mask"] | 8;
        incpersstat("adsKills", 1);
      } else if(var19) {
        self.modifiers["hipfire"] = 1;
        self.modifiers["mask"] = self.modifiers["mask"] | 16;
        incpersstat("hipfireKills", 1);
      }

      if(!self isonground()) {
        self.modifiers["airborne"] = 1;
      }

      if(isPlayer(var2) || isagent(var2)) {
        if(!var2 isonground()) {
          self.modifiers["victim_airborne"] = 1;
        }
      }

      if(self playermount() >= 0.5) {
        self.modifiers["mounted"] = 1;
        self.modifiers["mask"] = self.modifiers["mask"] | 32;
      }

      if(var19) {
        self.modifiers["bullet_damage"] = 1;
        var30 = self getweaponammoclip(var3);

        if(var30 <= 0) {
          self.modifiers["last_bullet_kill"] = 1;
          self.modifiers["mask"] = self.modifiers["mask"] | 64;
        }
      }

      if(isPlayer(var2) || isagent(var2)) {
        if(var2 issprinting()) {
          self.modifiers["victim_sprinting"] = 1;
          self.modifiers["mask"] = self.modifiers["mask"] | 128;
        }
      }

      if(level.teambased) {
        foreach(var32 in level.players) {
          if(!scripts\cp\utility\player::isreallyalive(var32)) {
            continue;
          }

          if(distancesquared(self.origin, var32.origin) < 90000) {
            self.modifiers["buddy_kill"] = 1;
            break;
          }
          LOC_00000bcb:
        }
      }
    } else if(var13 == "weapon_projectile") {
      if(isDefined(var5) && isDefined(var5.adsfire)) {
        if(var5.adsfire) {
          self.modifiers["ads"] = 1;
          self.modifiers["mask"] = self.modifiers["mask"] | 8;
        } else {
          self.modifiers["hipfire"] = 1;
          self.modifiers["mask"] = self.modifiers["mask"] | 16;
        }
      }
    }

    if(isPlayer(var2) || isagent(var2)) {
      if(!var2 isonground() && !var2 iswallrunning() && !self isonground() && !self iswallrunning()) {
        if(var14) {
          thread givekillreward("air_to_air_kill", var1, var3, "air_to_air_kill");
        }
      } else {
        if(var14) {
          if(self iswallrunning()) {
            thread givekillreward("wallkill", var1, var3, "wallrun_kill");
          } else if(isdeathfromabove(self, var3, var4, var13, var2)) {
            thread givekillreward("jumpkill", var1, var3, "air_kill");
          } else if(events_issliding()) {
            thread givekillreward("slidekill", var1, var3, "slide_kill");
            self.modifiers["sliding"] = 1;
            self.modifiers["mask"] = self.modifiers["mask"] | 256;
          }

          var34 = self getstance();

          switch (var34) {
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

        if(var2 iswallrunning()) {
          thread givekillreward("killonwall", var1, var3, "kill_wallrunner");
        } else if(isskeetshooter(self, var3, var4, var13, var2)) {
          thread givekillreward("killinair", var1, var3, "kill_jumper");
        }
      }
    }

    if(isDefined(var2.streakdata)) {
      foreach(var36 in var2.streakdata.streaks) {
        var37 = var36.currentcost - var2.streakpoints;

        if(var37 > 0 && var37 <= 1) {
          buzzkill(var1, var2);
          break;
        }
      }
    }

    if(var14 && isPlayer(self) && !isagent(self) && !isscriptedagent(self)) {
      if(self ismantling()) {
        thread killeventtextpopup("mantle_kill", 1);
        thread scripts\cp_mp\xmike109::givemidmatchaward("mantle_kill");
      }

      if(isDefined(self.tookweaponfrom) && isDefined(self.tookweaponfrom[var12]) && self.tookweaponfrom[var12] == var2) {
        thread killeventtextpopup("backfire", 1);
        thread scripts\cp_mp\xmike109::givemidmatchaward("backfire");
      }
    }

    if(isDefined(var2.stuckbygrenade)) {
      level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_semtex", undefined, 0.75);
    }

    if(scripts\cp\cp_weapons::isthrowingknife(var3.basename)) {
      thread killeventtextpopup("throwingknife_kill", 1);
      thread scripts\cp_mp\xmike109::givemidmatchaward("throwingknife_kill");
    }

    if(isDefined(var2.chopper_playfx) && isDefined(var2.chopper_playfx.owner)) {
      if(var2.chopper_playfx.owner != self) {
        thread killeventtextpopup("assist_decoy");
      }
    }

    var39 = self.pers["cur_kill_streak"] + 1;
    var40 = 5;

    if(level.gametype == "arm") {
      var40 = 10;
    }

    if(!(var39 % var40)) {
      if(!isDefined(self.lastkillsplash) || var39 != self.lastkillsplash) {
        thread scripts\cp\cp_hud_util::teamplayercardsplash("callout_kill_streaking", self, undefined, var39);
        self.lastkillsplash = var39;
      }

      if(var39 <= 30) {
        thread killeventtextpopup("streak_" + var39, 1);
        thread scripts\cp_mp\xmike109::givemidmatchaward("streak_" + var39);
      }
    }

    if(var39 % 5) {}

    if(var39 > 30) {
      thread killeventtextpopup("streak_max", 1);
      thread scripts\cp_mp\xmike109::givemidmatchaward("streak_max");
    }

    if(isDefined(var5) && istrue(var5.isequipment) && var4 == "MOD_IMPACT" && !scripts\cp\cp_weapons::isthrowingknife(var3.basename)) {
      thread scripts\cp_mp\xmike109::givemidmatchaward("item_impact");
      self.modifiers["item_impact"] = 1;
    }

    if(scripts\cp\cp_weapons::islauncherdirectimpactdamage(var3, var4)) {
      thread killeventtextpopup("launcher_direct_hit", 1);
      thread scripts\cp_mp\xmike109::givemidmatchaward("launcher_direct_hit");
      self.modifiers["launcher_impact"] = 1;
    }

    if(var18 >= 0.6428) {
      self.modifiers["victim_in_standard_view"] = 1;
    }

    if(isDefined(self.lastadsstarttime) && var10 - self.lastadsstarttime <= 500 && var13 == "weapon_sniper") {
      self.modifiers["quickscope"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 2048;
    }

    if(self.health <= 50) {
      self.modifiers["low_health_kill"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 4096;
    }

    if(isDefined(self.lastweaponchangetime) && var10 - self.lastweaponchangetime <= 1500) {
      self.modifiers["weapon_change_kill"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 8192;
    }

    if(isDefined(self.lastweaponpickuptime) && var10 - self.lastweaponpickuptime <= 1500) {
      self.modifiers["weapon_pickup_kill"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 16384;
    }

    if(isDefined(self.lastreloadtime) && var10 - self.lastreloadtime <= 1500) {
      self.modifiers["reload_kill"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 65536;
    }

    if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
      self.modifiers["in_vehicle"] = 1;
      self.modifiers["mask2"] = self.modifiers["mask2"] | 4096;
    }

    if(var2 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      self.modifiers["victim_in_vehicle"] = 1;
      self.modifiers["mask2"] = self.modifiers["mask2"] | 8192;
    }

    if(istrue(var2.isdefusing)) {
      self.modifiers["killed_defuser"] = 1;
    }

    if(scripts\cp\cp_weapon::iscacsecondaryweapon(var3)) {
      self.modifiers["secondary_weapon"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 131072;
    }

    thread checkmatchdatakills(var1, var2);
  }

  if(!isDefined(self.killedplayers[var8])) {
    self.killedplayers[var8] = 0;
  }

  if(!isDefined(var2.killedby[var9])) {
    var2.killedby[var9] = 0;
  }

  self.killedplayers[var8]++;
  var2.killedby[var9]++;
  var2.lastkilledby = self;

  if(isPlayer(var2)) {
    if(!var2 scripts\cp\utility::isusingremote() && (!var2 scripts\cp\utility::_hasperk("specialty_survivor") || istrue(var2.inlaststand))) {
      var2 thread scripts\cp\utility::setdof_killer();
    }
  }

  scripts\asm\soldier\mp\melee::bufferednotify("kill_event_buffered", var2, var12, var4, self.modifiers);
}

function unsetreduceregendelayonkills(var0) {
  return isDefined(var0) && isDefined(var0.vehiclename) && isDefined(var0.streakinfo);
}

function checkkillstreakkillevents(var0, var1, var2) {
  var3 = scripts\cp\utility::iskillstreakweapon(var0.basename) || unsetreduceregendelayonkills(var2);
  var4 = scripts\cp\agents\gametype_cp_wave_sv::unset_relic_doomslayer(var0);

  if(var3 && !var4) {
    var5 = level.killstreakweaponmap[var0.basename];
    var6 = 0;
    var7 = 0;
    var8 = 0;
    var9 = 0;

    if(!isDefined(var5)) {
      return;
    }

    switch (var5) {
      case "bradley":
        incpersstat("killstreakTankKills", 1);
        var7 = 1;
        var9 = 1;
        break;
      case "chopper_gunner":
        incpersstat("killstreakChopperGunnerKills", 1);
        var7 = 1;
        var8 = 1;
        break;
      case "chopper_support":
        incpersstat("killstreakChopperSupportKills", 1);
        var7 = 1;
        var8 = 1;
        break;
      case "cruise_predator":
        incpersstat("killstreakCruiseMissileKills", 1);
        var7 = 1;
        var8 = 1;
        break;
      case "fuel_airstrike":
        var7 = 1;
        break;
      case "gunship":
        incpersstat("killstreakGunshipKills", 1);
        var7 = 1;
        var8 = 1;
        break;
      case "hover_jet":
        incpersstat("killstreakVTOLJetKills", 1);
        var7 = 1;
        var8 = 1;
        break;
      case "juggernaut":
        incpersstat("killstreakJuggernautKills", 1);
        var7 = 1;
        var9 = 1;
        break;
      case "manual_turret":
        incpersstat("killstreakShieldTurretKills", 1);
        var7 = 1;
        var9 = 1;
        break;
      case "multi_airstrike":
        var7 = 1;
        break;
      case "pac_sentry":
        incpersstat("killstreakWheelsonKills", 1);
        var7 = 1;
        var9 = 1;
        break;
      case "precision_airstrike":
        incpersstat("killstreakAirstrikeKills", 1);
        var7 = 1;
        var8 = 1;
        break;
      case "sentry_gun":
        incpersstat("killstreakSentryGunKills", 1);
        var7 = 1;
        var9 = 1;
        break;
      case "toma_strike":
        incpersstat("killstreakCluserStrikeKills", 1);
        var7 = 1;
        var8 = 1;
        break;
      case "white_phosphorus":
        incpersstat("killstreakWhitePhosphorousKillsAssists", 1);
        var7 = 1;
        var8 = 1;
        break;
      default:
        thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("killstreak_full_score", var0);
        break;
    }

    if(isDefined(var2.streakinfo)) {
      if(!isDefined(var2.streakinfo.kills)) {
        var2.streakinfo.kills = 0;
      }

      var2.streakinfo.kills++;
    }

    incpersstat("killstreakKills", 1);

    if(var8) {
      incpersstat("killstreakAirKills", 1);
    }

    if(var9) {
      incpersstat("killstreakGroundKills", 1);
    }

    if(var7) {
      thread scripts\cp_mp\xmike109::givemidmatchaward("ss_kill_" + var5, undefined, undefined, undefined, undefined, undefined, var6);
    }

    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_killstreak", undefined, 0.75);
    return;
  }
}

function killedkillstreak(var0, var1, var2) {
  if(scripts\cp\utility::iskillstreakweapon(var2.basename)) {
    thread checkkillstreakkillevents(var2, undefined, var1);
  } else {
    var3 = "kill_ss_" + var0;
    var1 thread scripts\cp_mp\xmike109::givemidmatchaward(var3);
    incpersstat(var1, "destroyedKillstreaks", 1);
    level thread scripts\cp\cp_player_battlechatter::saytoself(var1, "plr_killstreak_destroy", undefined, 0.75);
  }

  if(isDefined(var1.perk_data) && var1 scripts\cp\utility::_hasperk("specialty_chain_killstreaks")) {
    var4 = 10;
    var5 = var4 * var1.perk_data["super_fill_scalar"];
    var1 scripts\cp\coop_super::increase_super_progress(var5);
    return;
  }
}

function is_enemy_highest_score(var0, var1) {
  foreach(var3 in var1) {
    if(var3.score > var0.score) {
      return false;
    }
  }

  return true;
}

function getshotdistancetype(var0, var1, var2, var3, var4) {
  if(isalive(var0) && !var0 scripts\cp\utility::isusingremote() && (var2 == "MOD_RIFLE_BULLET" || var2 == "MOD_PISTOL_BULLET" || var2 == "MOD_HEAD_SHOT") && !scripts\cp\utility::iskillstreakweapon(var1.basename) && !istrue(var0.assistedsuicide)) {
    var5 = distancesquared(var3, var4.origin);

    if(var5 < 9216) {
      return "pointblank";
    }

    if(var5 > 4000000) {
      return "very_longshot";
    }

    var6 = scripts\cp\cp_weapon::getweapongroup(var1.basename);
    var7 = undefined;

    switch (var6) {
      case "weapon_pistol":
        var7 = 800;
        break;
      case "weapon_beam":
      case "weapon_smg":
        var7 = 1200;
        break;
      case "weapon_assault":
      case "weapon_dmr":
      case "weapon_lmg":
        var7 = 1500;
        break;
      case "weapon_rail":
      case "weapon_sniper":
        var7 = 2000;
        break;
      case "weapon_shotgun":
        var7 = 500;
        break;
      case "weapon_projectile":
      default:
        var7 = 1536;
        break;
    }

    var8 = var7 * var7;

    if(var5 > var8) {
      return "longshot";
    }
  }

  return "none";
}

function update_future_stations_track_timers(var0, var1, var2) {
  var3 = distancesquared(var0, var1.origin);
  var4 = scripts\cp\cp_weapon::getweapongroup(var2.basename);
  var5 = undefined;

  switch (var4) {
    case "weapon_pistol":
      var5 = 1500;
      break;
    case "weapon_beam":
    case "weapon_smg":
      var5 = 2000;
      break;
    case "weapon_dmr":
      var5 = 4000;
      break;
    case "weapon_assault":
    case "weapon_lmg":
      var5 = 3000;
      break;
    case "weapon_rail":
    case "weapon_sniper":
      var5 = 8000;
      break;
    case "weapon_shotgun":
      var5 = 1000;
      break;
    case "weapon_projectile":
      var5 = 4000;
      break;
    default:
      var5 = 4000;
      break;
  }

  var6 = var5 * var5;
  return var3 > var6;
}

function isdeathfromabove(var0, var1, var2, var3, var4) {
  if(isalive(var0) && var0 isjumping() && scripts\engine\utility::isbulletdamage(var2)) {
    var5 = var0.origin[2] - var4.origin[2];
    return (var5 > 60);
  }

  return false;
}

function isskeetshooter(var0, var1, var2, var3, var4) {
  return isalive(var0) && var4 isjumping() && scripts\engine\utility::isbulletdamage(var2);
}

function isbackkill(var0, var1, var2) {
  if(!isPlayer(var0) || !isPlayer(var1)) {
    return false;
  }

  if(var2 != "MOD_RIFLE_BULLET" && var2 != "MOD_PISTOL_BULLET" && var2 != "MOD_MELEE" && var2 != "MOD_HEAD_SHOT") {
    return false;
  }

  var3 = var1 getplayerangles();
  var4 = var0 getplayerangles();
  var5 = angleclamp180(var3[1] - var4[1]);

  if(abs(var5) < 80) {
    return true;
  }

  return false;
}

function issurvivorkill(var0) {
  return var0.health > 0 && var0.health < var0.maxhealth * 0.2;
}

function checkmatchdatakills(var0, var1) {
  if(isDefined(self.lastkilledby) && self.lastkilledby == var1) {
    self.lastkilledby = undefined;
    revenge(var0, var1);
    return;
  }
}

function givekillreward(var0, var1, var2, var3) {
  self.modifiers[var0] = 1;

  if(isDefined(var3)) {
    thread scripts\cp_mp\xmike109::givemidmatchaward(var3);
    return;
  }

  thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints(var0, var2);
}

function proximityassist(var0) {
  self.modifiers["proximityAssist"] = 1;
  thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("proximityassist");
}

function proximitykill(var0) {
  self.modifiers["proximityKill"] = 1;
  thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("proximitykill");
}

function longshot(var0) {
  self.modifiers["longshot"] = 1;
  self.modifiers["mask"] = self.modifiers["mask"] | 262144;
  thread scripts\cp\agents\agents::logattackerkillevent(var0, "longshot");
  incpersstat("longshotKills", 1);
  thread killeventtextpopup("longshot", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("longshot");
}

function very_longshot(var0) {
  self.modifiers["very_longshot"] = 1;
}

function pointblank(var0) {
  self.modifiers["pointblank"] = 1;
  self.modifiers["mask"] = self.modifiers["mask"] | 524288;
  thread scripts\cp\agents\agents::logattackerkillevent(var0, "pointblank");
  thread killeventtextpopup("pointblank", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("pointblank");
  incpersstat("pointBlankKills", 1);
}

function headshot(var0) {
  self.modifiers["headshot"] = 1;
  self.modifiers["mask"] = self.modifiers["mask"] | 1048576;
  thread scripts\cp\agents\agents::logattackerkillevent(var0, "headshot");
  thread killeventtextpopup("headshot", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("headshot");
}

function avengedplayer(var0, var1) {
  self.modifiers["avenger"] = 1;
  self.modifiers["mask"] = self.modifiers["mask"] | 2097152;
  thread scripts\cp\agents\agents::logattackerkillevent(var0, "avenger");
  incpersstat("avengerKills", 1);
  thread killeventtextpopup("avenger", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("avenger");
}

function assistedsuicide(var0, var1) {
  self.modifiers["assistedsuicide"] = 1;
  thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("assistedsuicide", var1);
  thread scripts\cp\agents\agents::logattackerkillevent(var0, "assistedsuicide");
  thread killeventtextpopup("assistedsuicide", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("assistedsuicide");
}

function defendedplayer(var0, var1) {
  self.modifiers["defender"] = 1;
  self.modifiers["mask2"] = self.modifiers["mask2"] | 4194304;
  thread scripts\cp\agents\agents::logattackerkillevent(var0, "defender");
  incpersstat("defenderKills", 1);
  var2 = scripts\cp\utility::getplayerforguid(var1);
  thread killeventtextpopup("savior", 0);
  thread scripts\cp_mp\xmike109::givemidmatchaward("save_teammate");
}

function postdeathkill(var0) {
  self.modifiers["posthumous"] = 1;
  self.modifiers["mask"] = self.modifiers["mask"] | 8388608;
  thread scripts\cp\agents\agents::logattackerkillevent(var0, "posthumous");
  thread killeventtextpopup("posthumous", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("posthumous");
}

function revenge(var0, var1) {
  self.modifiers["revenge"] = 1;
  self.modifiers["mask"] = self.modifiers["mask"] | 16777216;
  thread scripts\cp\agents\agents::logattackerkillevent(var0, "revenge");
  incpersstat("revengeKills", 1);
  thread killeventtextpopup("revenge", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("revenge");
}

function multikill(var0, var1, var2, var3) {
  if(!isDefined(self.inneurotoxintimestamp)) {
    self.inneurotoxintimestamp = var1;
  }

  if(var1 < self.inneurotoxintimestamp) {
    return;
  }

  self notify("multiKill");
  self endon("multiKill");
  waitframe();
  var4 = undefined;
  var5 = undefined;

  switch (var1) {
    case 2:
      var4 = "double";
      break;
    case 3:
      var4 = "triple";
      var5 = "callout_3xkill";
      break;
    case 4:
      var4 = "four";
      var5 = "callout_4xkill";
      break;
    case 5:
      var4 = "five";
      var5 = "callout_5xkill";
      break;
    case 6:
      var4 = "six";
      var5 = "callout_6xkill";
      break;
    case 7:
      var4 = "seven";
      var5 = "callout_7xkill";
      break;
    case 8:
      var4 = "eight";
      var5 = "callout_8xkill";
      break;
    default:
      var4 = "multi";
      var5 = "callout_9xkill";
      break;
  }

  if(isDefined(self.pers["highestMultikill"]) && var1 > self.pers["highestMultikill"]) {
    self.pers["highestMultikill"] = var1;
  }

  thread scripts\cp\agents\agents::logmultikill(var0, var1);

  if(isDefined(var4)) {
    thread killeventtextpopup(var4, scripts\engine\utility::ter_op(isDefined(var2), var2, 1), istrue(var3));

    if(!istrue(var3)) {
      thread scripts\cp_mp\xmike109::givemidmatchaward(var4, undefined, undefined, undefined, undefined, undefined, undefined, undefined, self getcurrentweapon());
    }
  }

  if(isDefined(var5)) {
    if(!istrue(var3)) {
      thread playbattlechattersoundsplitscreen(self, var5, undefined, self);
      return;
    }

    thread scripts\cp\cp_hud_util::teamplayercardsplash(var5, self, self.team, undefined, 1);
    return;
  }
}

function playbattlechattersoundsplitscreen(var0, var1, var2, var3) {
  var0 thread scripts\cp\cp_hud_message::showsplash(var1, var2, var3);
}

function firstblood(var0) {
  self.modifiers["firstblood"] = 1;
  self.modifiers["mask"] = self.modifiers["mask"] | 33554432;
  thread scripts\cp\agents\agents::logattackerkillevent(var0, "firstblood");
  thread scripts\cp\cp_hud_util::teamplayercardsplash("callout_firstblood", self);
  thread killeventtextpopup("firstblood", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("firstblood");
}

function winningshot(var0) {}

function buzzkill(var0, var1) {
  self.modifiers["buzzkill"] = var1.pers["cur_kill_streak"];
  self.modifiers["mask"] = self.modifiers["mask"] | 67108864;
  thread scripts\cp\agents\agents::logattackerkillevent(var0, "buzzkill");
  thread killeventtextpopup("buzzkill", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("buzzkill");
}

function comeback(var0) {
  self.modifiers["comeback"] = 1;
  self.modifiers["mask"] = self.modifiers["mask"] | 134217728;
  thread scripts\cp\agents\agents::logattackerkillevent(var0, "comeback");
  thread killeventtextpopup("comeback", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("comeback");
  incpersstat("comebackKills", 1);
}

function collateral(var0) {
  if(var0 == 2) {
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_twofer", undefined, 0.75);
    thread killeventtextpopup("one_shot_two_kills", 1);
    thread scripts\cp_mp\xmike109::givemidmatchaward("one_shot_two_kills");
  }

  if(var0 == 3) {
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_threefer", undefined, 0.75);
    return;
  }
}

function shotguncollateral(var0) {}

function quadfeed(var0, var1) {
  self.modifiers["quadfeed"] = 1;
  self.modifiers["mask"] = self.modifiers["mask"] | 536870912;
  thread killeventtextpopup("quad_feed", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("quad_feed");
}

function disconnected() {
  var0 = self.guid;

  for(var1 = 0; var1 < level.players.size; var1++) {
    if(isDefined(level.players[var1].killedplayers[var0])) {
      level.players[var1].killedplayers[var0] = undefined;
    }

    if(isDefined(level.players[var1].killedby[var0])) {
      level.players[var1].killedby[var0] = undefined;
    }
  }
}

function monitorhealed() {
  level endon("end_game");

  for(;;) {
    level waittill("healed", var0);
    var0 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("healed");
  }
}

function updaterecentkills(var0, var1, var2, var3) {
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

  if(!isDefined(self.recentkillsperweapon[var3])) {
    self.recentkillsperweapon[var3] = 1;
  } else {
    self.recentkillsperweapon[var3]++;
  }

  var4 = scripts\cp\utility::getequipmenttype(var2.basename);

  if(isDefined(var4) && var4 == "lethal" && var2.basename != "throwingknife_mp") {
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_grenade", undefined, 0.75);
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_amf", undefined, 0.75);

    if(self.recentkillsperweapon[var3] > 0 && self.recentkillsperweapon[var3] % 2 == 0) {
      thread killeventtextpopup("grenade_double", 1);
      thread scripts\cp_mp\xmike109::givemidmatchaward("grenade_double");
    }
  }

  scripts\asm\soldier\mp\melee::bufferednotify("update_rapid_kill_buffered", self.recentkillcount, var3);

  if(self.recentkillcount > 1) {
    thread multikill(var0, self.recentkillcount, 0);
  }

  wait 2.5;

  if(self.recentkillcount > 1) {
    thread multikill(var0, self.recentkillcount, 1, 1);

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
    self waittill("hijacker", var0, var1);
    thread scripts\cp_mp\xmike109::givemidmatchaward("ss_use_enemy_dronedrop");
    var2 = "hijacked_airdrop";

    if(isDefined(var1)) {
      var1 scripts\cp\cp_hud_message::showsplash(var2, undefined, self);
    }
  }
}

function updatequadfeedcounter(var0, var1) {
  if(isDefined(level.quadfeedinfo) && gettime() - level.quadfeedinfo.starttime > 5000) {
    level.quadfeedinfo = undefined;
  }

  if(!isDefined(level.quadfeedinfo) || level.quadfeedinfo.player != var0) {
    var2 = spawnStruct();
    var2.player = var0;
    var2.starttime = gettime();
    var2.feedcount = 1;
    level.quadfeedinfo = var2;
    return;
  }

  var2 = level.quadfeedinfo;
  var2.feedcount++;

  if(var2.feedcount == 4) {
    quadfeed(var2.player, var2, var2);
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
    var0 = self issprintsliding();

    if(istrue(self.eventswassliding) && !var0) {
      self.eventsslideendtime = gettime();
    }

    self.eventswassliding = var0;
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

  var0 = self.mantlecur;
  self.mantlecur = self ismantling();

  if(!istrue(var0) && self.mantlecur) {}

  var1 = self.jumpcur;
  self.jumpcur = self isjumping();

  if(!istrue(var1) && self.jumpcur) {}

  var2 = self getstance();

  if(var2 != self.laststance) {
    if(self.laststance == "crouch") {
      var3 = self.laststancechangetime;
      var4 = (gettime() - var3) / 1000;
      incpersstat("timeCrouched", var4);
    }

    if(self.laststance == "prone") {
      var3 = self.laststancechangetime;
      var4 = (gettime() - var3) / 1000;
      incpersstat("timeProne", var4);
    }

    self.laststancechangetime = gettime();

    if(!isDefined(self.pers["stanceTracking"])) {
      self.pers["stanceTracking"] = [];
      self.pers["stanceTracking"]["prone"] = 0;
      self.pers["stanceTracking"]["crouch"] = 0;
      self.pers["stanceTracking"]["stand"] = 0;
    }

    if(var2 == "prone" || var2 == "crouch" || var2 == "stand") {
      self.pers["stanceTracking"][var2]++;
    }
  }

  self.laststancetimes[var2] = gettime();
  self.laststance = var2;
}

function predatormissileimpact(var0) {}

function largevehicleexplosion(var0) {}

function vehiclekilled(var0) {}

function missilefired(var0) {
  thread trackmissile(var0);
}

function trackmissile(var0) {
  level endon("game_ended");
  var0 endon("death");
  var0 endon("entitydeleted");
  var0.whizbyplayers = [];

  for(;;) {
    var1 = scripts\common\utility::playersnear(var0.origin, 220);

    foreach(var3 in var1) {
      if(isDefined(var0.owner) && var3 == var0.owner) {
        continue;
      }

      missilewhizby(var3, var0);
      var0.whizbyplayers[var3.guid] = 1;
    }

    wait 0.1;
  }
}

function missilewhizby(var0, var1) {}

function bombdefused(var0) {
  var1 = 0;
  var2 = 0;

  if(!var1) {
    var3 = scripts\cp\utility::getplayersinradius(var0.origin, 600);

    foreach(var5 in var3) {
      if(var5.team != var0.team) {
        var2 = 1;
        break;
      }
    }
  }

  if(var1) {
    var0 thread scripts\cp_mp\xmike109::givemidmatchaward("mode_sd_last_defuse");
  } else {
    var0 thread scripts\cp_mp\xmike109::givemidmatchaward("mode_sd_defuse");
  }

  incpersstat(var0, "defuses", 1);

  if(isPlayer(var0)) {
    var0 thread scripts\cp\agents\agents::loggameevent("defuse", var0.origin);
    return;
  }
}

function revivedplayer(var0, var1) {
  if(scripts\cp\utility::getgametype() == "cp_survival") {
    return;
  }
}

function doorused(var0, var1) {
  if(var1) {
    var0.lastdooropentime = gettime();
    return;
  }
}

function shothit() {}

function shotmissed() {}

function killeventtextpopup(var0, var1, var2) {
  self endon("death_or_disconnect");

  if(!scripts\cp\drone\emp_drone::scoreeventhastext(var0)) {
    return;
  }

  if(!scripts\cp\utility::turn_off_sniper_laser() && isDefined(self.totalxpearned) && isDefined(self.ref_11b7f)) {
    if(self.totalxpearned >= self.ref_11b7f) {
      return;
    }
  }

  if(!isDefined(self.killeventqueue)) {
    self.killeventqueue = [];
  }

  foreach(var4 in self.killeventqueue) {
    if(var4.scoreeventref == var0) {
      return;
    }
  }

  var6 = spawnStruct();
  var6.scoreeventref = var0;
  var6.showassplash = istrue(var1);
  var6.priority = scripts\cp\drone\emp_drone::getscoreeventpriority(var0);
  var6.alwaysshowsplash = scripts\cp\drone\emp_drone::scoreeventalwaysshowassplash(var0);
  var6.ref_128ac = 0;
  var6.ref_128ab = 0;
  var6.matchdata_logplayerlife = istrue(var2);
  self.killeventqueue[self.killeventqueue.size] = var6;
  self notify("killEventTextPopup");
  self endon("killEventTextPopup");
  waitframe();

  if(!isDefined(self.splashpriorityqueue)) {
    self.splashpriorityqueue = [];
  }

  foreach(var4 in self.killeventqueue) {
    insertbypriority(var4);
  }

  self.killeventqueue = undefined;
  var9 = 0;

  foreach(var4 in self.splashpriorityqueue) {
    if(var4.ref_128ac) {
      continue;
    }

    if(!istrue(level.removekilleventsplash) && istrue(var4.showassplash) && (!var9 || var4.alwaysshowsplash)) {
      var9 = 1;
      thread scripts\cp\cp_hud_message::showsplash(var4.scoreeventref);
    }

    var4.ref_128ac = 1;
  }

  foreach(var4 in self.splashpriorityqueue) {
    if(var4.ref_128ab || var4.matchdata_logplayerlife) {
      continue;
    }

    thread scripts\cp\drone\emp_drone::scoreeventpopup(var4.scoreeventref);
    var4.ref_128ab = 1;
    wait getdvarfloat("scr_splash_kill_buffer", 0.25);
  }

  self.splashpriorityqueue = undefined;
}

function insertbypriority(var0) {
  if(self.splashpriorityqueue.size == 0) {
    self.splashpriorityqueue[self.splashpriorityqueue.size] = var0;
    return;
  }

  foreach(var2 in self.splashpriorityqueue) {
    if(var2.scoreeventref == var0.scoreeventref) {
      return;
    }
  }

  for(var4 = 0; var4 < self.splashpriorityqueue.size; var4++) {
    if(var0.priority > self.splashpriorityqueue[var4].priority) {
      self.splashpriorityqueue = scripts\engine\utility::array_insert(self.splashpriorityqueue, var0, var4);
      return;
    }
  }

  self.splashpriorityqueue[self.splashpriorityqueue.size] = var0;
}

function initpersstat(var0) {
  if(!isDefined(self.pers[var0])) {
    self.pers[var0] = 0;
    return;
  }
}

function getpersstat(var0) {
  return self.pers[var0];
}

function incpersstat(var0, var1) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers[var0])) {
    self.pers[var0] += var1;
    return;
  }
}

function setextrascore0(var0) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore0 = var0;
  self.pers["extrascore0"] = var0;
}

function setextrascore1(var0) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore1 = var0;
  self.pers["extrascore1"] = var0;
}

function setextrascore2(var0) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore2 = var0;
  self.pers["extrascore2"] = var0;
}

function setextrascore3(var0) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore3 = var0;
  self.pers["extrascore3"] = var0;
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

function getstreakrecordtype(var0) {
  if(isenumvaluevalid("mp", "LethalScorestreakStatItems", var0)) {
    return "lethalScorestreakStats";
  }

  if(isenumvaluevalid("mp", "SupportScorestreakStatItems", var0)) {
    return "supportScorestreakStats";
  }

  return undefined;
}

function execution(var0) {
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
  thread ref_1445a();
}

function ref_1445a() {
  self endon("death");
  self waittill("long_death");

  if(isDefined(self.attackers) && self.attackers.size > 0) {
    foreach(var2, var1 in self.attackers) {
      if(isPlayer(var1)) {
        if(isDefined(self.attackerdata) && self.attackerdata.size > 0) {
          if(!isDefined(var1.ref_119d4)) {
            var1.ref_119d4 = [];
          }

          thread vip_playerdied(var1, undefined, self, self.attackerdata[var2].objweapon, self.attackerdata[var2].smeansofdeath, var1);
          thread scripts\mp\ammorestock::onplayerkilled(var1, var1, self.maxhealth, undefined, self.attackerdata[var2].smeansofdeath, self.attackerdata[var2].objweapon, self.attackerdata[var2].ref_13417, var1.modifiers);
          var1 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("kill", self.attackerdata[var2].objweapon);
          var1.ref_119d4[self getentitynumber()] = 1;
        }
      }
    }

    return;
  }
}