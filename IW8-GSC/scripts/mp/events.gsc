/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\events.gsc
***********************************************/

function init() {
  var_0 = scripts\mp\utility\game::getgametype();

  if(!isDefined(var_0)) {
    var_0 = getDvar("g_gametype");
  }

  for(var_1 = 0;; var_1++) {
    var_2 = tablelookupbyrow("mp/score_event_table.csv", var_1, 0);

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow("mp/score_event_table.csv", var_1, level.getallselectableattachments.game_type_col[var_0]);

    if(!isDefined(var_3) || var_3 == "") {
      var_1++;
      continue;
    }

    if(var_2 == "win" || var_2 == "loss" || var_2 == "tie") {
      var_3 = float(var_3);
    } else {
      var_3 = int(var_3);
    }

    if(var_3 != -1) {
      scripts\mp\rank::registerscoreinfo(var_2, "value", var_3);
    }

    var_4 = tablelookuprownum("mp/splashTable.csv", 0, var_2);
    scripts\mp\rank::registerscoreinfo(var_2, "eventID", var_4);
    var_4 = tablelookup("mp/splashTable.csv", 0, var_2, 2);
    scripts\mp\rank::registerscoreinfo(var_2, "text", var_4);
    var_4 = int(tablelookup("mp/splashTable.csv", 0, var_2, 13));
    scripts\mp\rank::registerscoreinfo(var_2, "priority", var_4);
    var_4 = int(tablelookup("mp/splashTable.csv", 0, var_2, 14));
    scripts\mp\rank::registerscoreinfo(var_2, "alwaysShowSplash", var_4);
    var_5 = tablelookuprownum("mp/splashTable.csv", 0, var_2);

    if(isDefined(var_5) && var_5 != -1) {
      scripts\mp\rank::registerscoreinfo(var_2, "splashID", var_5);
    }

    var_6 = tablelookupbyrow("mp/score_event_table.csv", var_1, 4);
    scripts\mp\rank::registerscoreinfo(var_2, "group", var_6);
    var_7 = tablelookupbyrow("mp/score_event_table.csv", var_1, 3);

    if(isDefined(var_7) && tolower(var_7) == "true") {
      scripts\mp\rank::registerscoreinfo(var_2, "allowBonus", 1);
    }
  }

  if(scripts\mp\gametypes\br_public::shouldusegoldbarassets()) {
    level._effect["money"] = loadfx("vfx/iw8_br/gameplay/vfx_br_gold_backpack_death.vfx");
  } else {
    level._effect["money"] = loadfx("vfx/props/cash_player_drop");
  }

  level.numkills = 0;
  level.prevlastkilltime = 0;
  level.lastkilltime = 0;
  level.carnage_enemydummycleanup = 2097152;
  thread onplayerconnect();
  thread monitorhealed();

  if(!scripts\mp\utility\game::runleanthreadmode()) {
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawn);
    scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(&updatestancetracking);
    scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(&events_monitorslideupdate);
  }

  scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(&monitoradstime);

  if(scripts\mp\utility\game::getgametype() != "br") {
    thermite_laststand_effects();
    return;
  }
}

function onplayerspawn() {
  self.jumpcur = 0;
  self.mantlecur = 0;
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!scripts\mp\utility\game::lpcfeaturegated()) {
      var_0.killedplayers = [];
      var_0.killedby = [];
    }

    var_0.lastkilledby = undefined;
    var_0.greatestuniqueplayerkills = 0;
    var_0.recentkillcount = 0;
    var_0.recentdefendcount = 0;
    var_0.ref_12A82 = 0;
    var_0.lastkilltime = 0;
    var_0.prevlastkilltime = 0;
    var_0.lastkilldogtime = 0;

    if(!isDefined(var_0.pers["lethalEquipmentKillMask"])) {
      var_0.pers["lethalEquipmentKillMask"] = 0;
    }

    if(scripts\mp\utility\game::getgametype() != "br") {
      if(!isDefined(var_0.pers["headshotLongshotMask"])) {
        var_0.pers["headshotLongshotMask"] = 0;
      }
    }

    var_0.ref_11F87 = 0;
    var_0.damagedplayers = [];
    initslidemonitor(var_0);
    initmonitoradstime(var_0);
    thread monitorreload();
    var_0.lastweaponchangetime = 0;
    initstancetracking(var_0);
  }
}

function damagedplayer(var_0, var_1) {
  if(var_1 < 50 && var_1 > 10) {
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_damaged_light", undefined, 0.1);
    return;
  }

  level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_damaged_heavy", undefined, 0.1);
}

function playerworlddeath(var_0, var_1) {
  scripts\mp\potg_events::playerworlddeath(var_0, var_1);
}

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

function celebration_end(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  if(isDefined(var_1)) {
    if(isDefined(var_1.owner)) {
      var_4 = var_1.owner == var_0;
    } else if(cellspawns(var_2, var_1, var_3)) {} else {
      var_4 = var_1 == var_0;
    }
  }

  return var_4;
}

function cellspawns(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_0) && isDefined(var_1.classname) && var_1.classname == "worldspawn" && var_2 == "MOD_EXPLOSIVE") {
    var_4 = scripts\mp\utility\weapon::getweaponrootname(var_0);
    var_3 = var_4 == "iw8_sn_xmike109" || var_4 == "iw8_sn_crossbow";
  }

  return var_3;
}

function cargo_truck_mg_initoccupancy(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isPlayer(self)) {
    return;
  }

  self.modifiers = [];
  self.modifiers["mask"] = 0;
  self.modifiers["mask2"] = 0;
  self.modifiers["mask3"] = 0;
  var_6 = gettime();
  var_7 = scripts\mp\utility\weapon::getweapongroup(var_2.basename);
  var_8 = createheadicon(var_2);
  var_9 = var_1.guid;
  var_10 = scripts\cp\vehicles\vehicle_compass_cp::resetstuckthermite();
  var_11 = var_1 scripts\cp\vehicles\vehicle_compass_cp::resetstuckthermite();

  if(!scripts\mp\utility\weapon::iskillstreakweapon(var_2.basename) && !scripts\mp\utility\perk::_hasperk("specialty_explosivebullets")) {
    var_12 = celebration_end(self, var_4, var_2, var_3);

    if(isDefined(var_1.attackerposition)) {
      var_13 = var_1.attackerposition;
    } else {
      var_13 = self.origin;
    }

    var_14 = anglesToForward(self getplayerangles());
    var_15 = var_2.origin - var_13;
    var_16 = vectorNormalize(var_15);
    var_17 = vectordot(var_14, var_16);
    var_18 = scripts\engine\utility::isbulletdamage(var_4);
    var_19 = scripts\mp\supers::getcurrentsuper();

    if(isDefined(var_19) && scripts\mp\supers::issuperinuse()) {
      self.modifiers["active_field_upgrade"] = var_19.staticdata.ref;
    }

    if(var_4 == "MOD_EXECUTION") {
      self.modifiers["execution"] = 1;
      self.modifiers["mask2"] = self.modifiers["mask2"] | 256;
    }

    if(level.prevlastkilltime == 0 && self.prevlastkilltime == 0) {
      self.modifiers["firstblood"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 33554432;
    }

    if(var_3.basename == "none" && var_4 != "MOD_EXECUTION") {
      return;
    }

    if(isDefined(var_2.attackers) && var_2.attackers.size == 1 && !isDefined(var_2.attackers[var_2.guid])) {
      if(var_8 != "other" && var_8 != "weapon_projectile" && var_4 != "MOD_MELEE" && isDefined(var_2.attackerdata) && isDefined(var_2.attackerdata[self.guid].firsttimedamaged) && var_7 == var_2.attackerdata[self.guid].firsttimedamaged) {
        self.modifiers["oneshotkill"] = 1;
        self.modifiers["mask"] = self.modifiers["mask"] | 1;

        if(!isDefined(self.pers["oneshotkills"])) {
          self.pers["oneshotkills"] = 1;
        } else {
          self.pers["oneshotkills"]++;
        }

        if(self.pers["oneshotkills"] == 6) {
          self.modifiers["mask3"] = self.modifiers["mask3"] | 8;
        }
      }
    }

    if(isDefined(self.lastinsmoketime) && self.lastinsmoketime + 5000 > gettime() || isDefined(var_2.lastinsmoketime) && var_2.lastinsmoketime + 5000 > gettime()) {
      self.modifiers["insmoke"] = 1;
      self.modifiers["mask2"] = self.modifiers["mask2"] | 512;
    }

    if(scripts\mp\utility\game::runleanthreadmode()) {
      if(isDefined(var_2.radarstrength) && var_2.radarstrength > 3) {
        self.modifiers["enemyHasUAV"] = 1;
        self.modifiers["mask2"] = self.modifiers["mask2"] | 1;
      }
    } else if(scripts\cp_mp\utility\killstreak_utility::teamhasuav(var_2.team)) {
      self.modifiers["enemyHasUAV"] = 1;
      self.modifiers["mask2"] = self.modifiers["mask2"] | 1;
    }

    if(isDefined(var_2.ref_13935) && var_2.ref_13935 == self) {
      self.modifiers["grenadestuck"] = 1;
      self.modifiers["mask2"] = self.modifiers["mask2"] | 8;
    }

    if(scripts\mp\utility\game::turret_outline_watcher(var_2)) {
      self.modifiers["assault"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 1073741824;
      start_puzzle();
    }

    if(scripts\mp\utility\game::isdefending(var_2)) {
      self.modifiers["defender"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 4194304;
      start_puzzle();
    }

    if(var_4 == "MOD_MELEE") {
      if(var_8 != "weapon_melee" && var_8 != "weapon_melee2") {
        self.modifiers["gunbutt"] = 1;
        self.modifiers["mask2"] = self.modifiers["mask2"] | 128;
      }
    }

    if((var_8 == "weapon_melee" || var_8 == "weapon_melee2") && !issubstr(var_8, "fists")) {
      self.modifiers["melee"] = 1;
      self.modifiers["mask2"] = self.modifiers["mask2"] | 1073741824;
    }

    var_24 = var_2 getheldoffhand();

    if(var_24.basename == "frag_grenade_mp" || var_24.basename == "cluster_grenade_mp") {
      self.modifiers["cooking"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 2;
    }

    if(isDefined(self.assistedsuicide) && self.assistedsuicide) {
      self.modifiers["assistedsuicide"] = 1;
    }

    if(self.pers["cur_death_streak"] > 3) {
      self.modifiers["comeback"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 134217728;
    }

    if(var_4 == "MOD_HEAD_SHOT" || vehicle_collision_handlemultievent(var_3, var_6) || turn_on_laser_vfx(var_3, var_6)) {
      self.modifiers["headshot"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 1048576;

      if(self.pers["headshots"] == 7) {
        self.modifiers["mask3"] = self.modifiers["mask3"] | 16;
      }
    }

    if(isDefined(self.wasti) && self.wasti && var_7 - self.spawntime <= 5000) {
      self.modifiers["jackintheboxkill"] = 1;
    }

    if(!scripts\mp\utility\player::isreallyalive(self) && isDefined(self.deathtime)) {
      var_25 = gettime() - self.deathtime;

      if(var_25 < 1500 && var_25 > 0) {
        self.modifiers["posthumous"] = 1;
        self.modifiers["mask"] = self.modifiers["mask"] | 8388608;
      }
    }

    if(level.teambased && isDefined(var_2.lastkilltime) && var_7 - var_2.lastkilltime < 1500) {
      if(var_2.lastkilledplayer != self) {
        self.modifiers["avenger"] = 1;
        self.modifiers["mask"] = self.modifiers["mask"] | 2097152;
      }
    }

    if(isbackkill(self, var_2, var_4)) {
      self.modifiers["backstab"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 4;
    }

    var_26 = isDefined(var_5) && istrue(var_5.isequipment) && isDefined(var_5.equipmentref) && var_5.equipmentref == "equip_throwing_knife";
    var_27 = isDefined(var_5) && isDefined(var_5.weapon_object) && scripts\mp\utility\weapon::validatefuelstability(var_5.weapon_object, var_5);

    if(var_13 || var_26 || var_27) {
      var_28 = getshotdistancetype(self, var_3, var_4, var_13, var_2);

      switch (var_28) {
        case "pointblank":
          self.modifiers["pointblank"] = 1;
          self.modifiers["mask"] = self.modifiers["mask"] | 524288;
          break;
        case "longshot":
          self.modifiers["longshot"] = 1;
          self.modifiers["mask"] = self.modifiers["mask"] | 262144;
          var_29 = scripts\engine\math::round_float(distance(var_13, var_2.origin) / 39.37, 2);
          self setclientomnvar("ui_longshot_dist", var_29);
          self setclientomnvar("ui_longshot_special", update_future_stations_track_timers(var_13, var_2, var_3));
          break;
        case "very_longshot":
          self.modifiers["longshot"] = 1;
          self.modifiers["mask"] = self.modifiers["mask"] | 262144;
          self.modifiers["very_longshot"] = 1;
          var_29 = scripts\engine\math::round_float(distance(var_13, var_2.origin) / 39.37, 2);
          self setclientomnvar("ui_longshot_dist", var_29);
          self setclientomnvar("ui_longshot_special", update_future_stations_track_timers(var_13, var_2, var_3));
          break;
      }

      if(self method_87ba()) {
        self.modifiers["holdingbreath"] = 1;
        self.modifiers["mask"] = self.modifiers["mask"] | 268435456;
      }

      if(scripts\mp\class::vehicle_checkpiggybackexploit(var_3)) {
        self.modifiers["silencedkill"] = 1;
        self.modifiers["mask2"] = self.modifiers["mask2"] | 131072;
      }

      if(var_2 scripts\mp\weapons::isstunnedorblinded()) {
        self.modifiers["victimimpairedkill"] = 1;
        self.modifiers["mask2"] = self.modifiers["mask2"] | 1048576;
        self.modifiers["detectedimpairedkill"] = 1;
        self.modifiers["mask2"] = self.modifiers["mask2"] | 524288;
      }

      if(underbridge_reinforce_enemy_monitor(self, var_2)) {
        self.modifiers["detectedimpairedkill"] = 1;
        self.modifiers["detectedkill"] = 1;
        self.modifiers["mask2"] = self.modifiers["mask2"] | 524288;
      }

      if(isDefined(var_2.lastsnapshotgrenadetime) && var_2.lastsnapshotgrenadetime + scripts\mp\equipment\snapshot_grenade::removespawnselections() > gettime()) {
        self.modifiers["mask2"] = self.modifiers["mask2"] | 67108864;
      }

      if(isDefined(self.radarstrength) && self.radarstrength > 3 && !var_2 scripts\mp\utility\perk::_hasperk("specialty_br_ghost")) {
        self.modifiers["uavkill"] = 1;
        self.modifiers["mask2"] = self.modifiers["mask2"] | 4194304;
      }

      if(isDefined(var_6.damageflags) && var_6.damageflags &level.idflags_penetration && !(var_6.damageflags &level.ss_respawn)) {
        self.modifiers["coverkill"] = 1;
        self.modifiers["mask2"] = self.modifiers["mask2"] | 262144;
      }

      if(scripts\mp\equipment\gas_grenade::plunder_playerspawnedcallback(self, var_2)) {
        self.modifiers["gasimpairedkill"] = 1;
        self.modifiers["mask2"] = self.modifiers["mask2"] | 16777216;
      }

      if(scripts\mp\gametypes\br_public::updatelootleadersonfixedinterval(var_2)) {
        self.modifiers["mostwantedkill"] = 1;
        self.modifiers["mask2"] = self.modifiers["mask2"] | 33554432;
      }

      if(scripts\mp\weapons::grenadeheldatdeath()) {
        self.modifiers["clutchkill"] = 1;
      }

      if(issurvivorkill(self)) {
        self.modifiers["low_health_kill"] = 1;
        self.modifiers["mask"] = self.modifiers["mask"] | 4096;
      }

      if(!self isonground()) {
        self.modifiers["airborne"] = 1;
      }

      if(!var_2 isonground()) {
        self.modifiers["victim_airborne"] = 1;
      }

      if(self playermount() >= 0.5) {
        self.modifiers["mounted"] = 1;
        self.modifiers["mask"] = self.modifiers["mask"] | 32;
      }

      if(istrue(self.ref_138AC)) {
        self.modifiers["mask3"] = self.modifiers["mask3"] | 4;
      }

      if(var_18) {
        self.modifiers["bullet_damage"] = 1;
        var_30 = self getweaponammoclip(var_3);

        if(var_30 <= 0) {
          self.modifiers["last_bullet_kill"] = 1;
          self.modifiers["mask"] = self.modifiers["mask"] | 64;
        }
      }

      if(scripts\mp\utility\weapon::iscacprimaryorsecondary(var_3) && var_4 != "MOD_MELEE") {
        if(scripts\mp\utility\player::isplayerads()) {
          self.modifiers["ads"] = 1;
          self.modifiers["mask"] = self.modifiers["mask"] | 8;
        } else {
          self.modifiers["hipfire"] = 1;
          self.modifiers["mask"] = self.modifiers["mask"] | 16;
        }
      }

      if(var_2 issprinting()) {
        self.modifiers["victim_sprinting"] = 1;
        self.modifiers["mask"] = self.modifiers["mask"] | 128;
      }

      if(level.teambased) {
        foreach(var_32 in level.players) {
          if(self.team != var_32.team || self == var_32) {
            continue;
          }

          if(!scripts\mp\utility\player::isreallyalive(var_32)) {
            continue;
          }

          if(distancesquared(self.origin, var_32.origin) < 90000) {
            self.modifiers["buddy_kill"] = 1;
            break;
          }
        }
      }

      if(scripts\mp\weapons::isstunnedorblinded()) {
        self.modifiers["impaired"] = 1;
        self.modifiers["mask2"] = self.modifiers["mask2"] | 64;
      }

      if(var_2 scripts\mp\weapons::isstunned()) {
        self.modifiers["victimstunnedkill"] = 1;
        self.modifiers["mask3"] = self.modifiers["mask3"] | 1;
      }

      if(var_2 scripts\mp\weapons::isblinded()) {
        self.modifiers["victimblindedkill"] = 1;
        self.modifiers["mask2"] = self.modifiers["mask2"] | 8388608;
      }

      if(isDefined(self.tookweaponfrom[var_9]) && self.tookweaponfrom[var_9] == var_2) {
        self.modifiers["backfire"] = 1;
        self.modifiers["mask"] = self.modifiers["mask"] | 32768;
      }
    } else if(var_8 == "weapon_projectile") {
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

    if(!var_2 isonground() && !var_2 iswallrunning() && !self isonground() && !self iswallrunning()) {
      if(var_13) {
        self.modifiers["air_to_air_kill"] = 1;
      }
    } else {
      if(var_13) {
        if(self iswallrunning()) {
          self.modifiers["wallkill"] = 1;
        } else if(isdeathfromabove(self, var_3, var_4, var_13, var_2)) {
          self.modifiers["jumpkill"] = 1;
        } else if(events_issliding()) {
          self.modifiers["slidekill"] = 1;
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
        self.modifiers["killonwall"] = 1;
      } else if(isskeetshooter(self, var_3, var_4, var_13, var_2)) {
        self.modifiers["killinair"] = 1;
      }
    }

    if(isDefined(var_2.streakdata)) {
      foreach(var_36 in var_2.streakdata.streaks) {
        var_37 = var_36.currentcost - var_2.streakpoints;

        if(var_37 > 0 && var_37 <= 1) {
          self.modifiers["buzzkill"] = var_2.pers["cur_kill_streak"];
          self.modifiers["mask"] = self.modifiers["mask"] | 67108864;
          break;
        }
      }
    }

    if(!scripts\mp\utility\game::runleanthreadmode()) {
      if(level.teambased) {
        var_39 = 0;
        var_40 = scripts\mp\utility\teams::getenemyplayers(self.team);

        foreach(var_42 in var_40) {
          if(var_42.score > 0) {
            var_39 = 1;
            break;
          }
        }

        if(var_39) {
          if(is_enemy_highest_score(var_2, var_40)) {
            self.modifiers["kingslayer"] = 1;
            self.modifiers["mask2"] = self.modifiers["mask2"] | 4;
          }
        }
      } else {
        var_39 = 0;

        foreach(var_42 in level.players) {
          if(var_42.score > 0) {
            var_39 = 1;
            break;
          }
        }

        if(var_39) {
          if(is_enemy_highest_score(var_4, level.players)) {
            self.modifiers["kingslayer"] = 1;
            self.modifiers["mask2"] = self.modifiers["mask2"] | 4;
          }
        }
      }
    }

    if(isDefined(var_7) && istrue(var_7.isequipment) && var_6 == "MOD_IMPACT" && !scripts\mp\utility\weapon::isthrowingknife(var_5.basename)) {
      self.modifiers["item_impact"] = 1;
      self.modifiers["mask3"] = self.modifiers["mask3"] | 32;
    }

    if(scripts\mp\utility\damage::islauncherdirectimpactdamage(var_5, var_6)) {
      self.modifiers["launcher_impact"] = 1;
    }

    if(var_19 >= 0.6428) {
      self.modifiers["victim_in_standard_view"] = 1;
    }

    if(isDefined(self.lastadsstarttime) && var_9 - self.lastadsstarttime <= 500 && (var_10 == "weapon_sniper" || var_10 == "weapon_dmr")) {
      self.modifiers["quickscope"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 2048;
    }

    if(isDefined(self.lastweaponchangetime) && var_9 - self.lastweaponchangetime <= 2500) {
      self.modifiers["weapon_change_kill"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 8192;
    }

    if(isDefined(self.tookweaponfrom[var_11]) && self.tookweaponfrom[var_11].team != self.team || scripts\mp\utility\weapon::ispickedupweapon(var_5)) {
      self.modifiers["weapon_pickup_kill"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 16384;
    }

    if(isDefined(self.lastreloadtime) && var_9 - self.lastreloadtime <= 5000) {
      self.modifiers["reload_kill"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 65536;
    }

    var_46 = self getvelocity();
    var_47 = var_46[0] >= 0.1 || var_46[0] <= -0.1;
    var_48 = var_46[1] >= 0.1 || var_46[1] <= -0.1;
    var_49 = var_46[2] >= 0.1 || var_46[2] <= -0.1;

    if(var_47 || var_48 || var_49) {
      self.modifiers["moving_kill"] = 1;
      self.modifiers["mask3"] = self.modifiers["mask3"] | 2;
    }

    if(istrue(var_4.isdefusing)) {
      self.modifiers["killed_defuser"] = 1;
    }

    if(scripts\mp\utility\weapon::iscacsecondaryweapon(var_5) || scripts\mp\utility\perk::_hasperk("specialty_munitions_2") && isDefined(self.secondaryweaponobj) && var_5 == self.secondaryweaponobj) {
      self.modifiers["secondary_weapon"] = 1;
      self.modifiers["mask"] = self.modifiers["mask"] | 131072;
    }

    if(scripts\mp\utility\player::unset_relic_trex(self)) {
      self.modifiers["last_stand"] = 1;
      self.modifiers["mask2"] = self.modifiers["mask2"] | 1024;
    }

    if(scripts\mp\utility\player::unset_relic_trex(var_4) || istrue(var_8.enemy_monitor_trialending)) {
      self.modifiers["victim_last_stand"] = 1;
      self.modifiers["mask2"] = self.modifiers["mask2"] | 2048;
    }

    if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
      self.modifiers["in_vehicle"] = 1;
      self.modifiers["mask2"] = self.modifiers["mask2"] | 4096;
    }

    if(var_4 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      self.modifiers["victim_in_vehicle"] = 1;
      self.modifiers["mask2"] = self.modifiers["mask2"] | 8192;
    }

    if(isDefined(var_7) && isDefined(var_7.equipmentref)) {
      if(var_7.equipmentref == "equip_c4" || var_7.equipmentref == "equip_claymore") {
        var_50 = var_7 getlinkedparent();

        if(isDefined(var_50) && isDefined(var_50.helperdronetype) && var_50.helperdronetype == "radar_drone_recon") {
          self.modifiers["recon_drone_explosive"] = 1;
          self.modifiers["mask2"] = self.modifiers["mask2"] | 32768;

          if(level.challengesallowed && isDefined(var_50.owner)) {
            self.ref_12A9A = var_50.owner;
          }
        } else if(isDefined(var_50) && var_50 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
          self.modifiers["vehicle_explosive"] = 1;
          self.modifiers["mask2"] = self.modifiers["mask2"] | 65536;
        }
      } else if(var_7.equipmentref == "equip_supportBox") {
        self.modifiers["mask3"] = self.modifiers["mask3"] | 2048;
      }
    }

    var_51 = scripts\cp\vehicles\vehicle_compass_cp::getoperatorfavoriteweapon(var_13[0]);

    if(var_51 != "") {
      if(scripts\mp\utility\weapon::getweaponrootname(var_5.basename) == var_51) {
        self.modifiers["mask3"] = self.modifiers["mask3"] | 512;
      }
    }

    if(scripts\mp\utility\perk::_hasperk("specialty_quieter") && scripts\mp\utility\perk::_hasperk("specialty_no_battle_chatter") && scripts\mp\utility\perk::_hasperk("specialty_lightweight")) {
      self.modifiers["mask3"] = self.modifiers["mask3"] | 1024;
    }

    if((var_13[0] == "s4_palmer" || var_13[0] == "s4_doggett") && (var_13[0] == "s4_palmer" || var_13[0] == "s4_doggett")) {
      self.modifiers["mask3"] = self.modifiers["mask3"] | 4096;
    }
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(var_5.basename) || scripts\mp\utility\weapon::unsetreduceregendelayonkills(var_7)) {
    self.modifiers["killstreak"] = 1;
  }

  if(isDefined(self.lastkilledby) && self.lastkilledby == var_4) {
    self.modifiers["revenge"] = 1;
    self.modifiers["mask"] = self.modifiers["mask"] | 16777216;
  }

  var_52 = 1;
  var_53 = 0;
  var_54 = 0;

  if(isDefined(var_4.damagedplayers)) {
    var_55 = scripts\mp\utility\teams::getteamdata(self.team, "players");

    foreach(var_61, var_57 in var_4.damagedplayers) {
      if(!istrue(var_54) || !istrue(var_53)) {
        foreach(var_59 in var_55) {
          if(isDefined(var_59) && isDefined(var_59.guid) && var_59.guid == var_61) {
            if(isalive(var_59) && var_59.team == self.team && var_9 - var_57 < 1750) {
              self.modifiers["savior"] = 1;
              self.modifiers["mask3"] = self.modifiers["mask3"] | 8192;
              var_53 = 1;

              if(var_10 == "weapon_sniper") {
                self.modifiers["mask2"] = self.modifiers["mask2"] | 134217728;
                var_54 = 1;
              }

              break;
            }
          }
        }
      }

      if(self.guid == var_61) {
        var_52 = 0;
      }
    }
  }

  if(self.health == self.maxhealth && istrue(var_52)) {
    self.modifiers["mask2"] = self.modifiers["mask2"] | 268435456;
  }

  foreach(var_63 in level.decoygrenades) {
    if(isDefined(var_63.playersdebuffed)) {
      foreach(var_65 in var_63.playersdebuffed) {
        if(var_4 == var_65) {
          self.modifiers["mask2"] = self.modifiers["mask2"] | 536870912;
        }
      }
    }
  }

  var_68 = reset_map_dvars();

  if(var_68.size > 0) {
    foreach(var_61 in var_68) {
      if(var_12 == var_61) {
        self.modifiers["killedNemesis"] = 1;
        self.modifiers["mask2"] = self.modifiers["mask2"] | 16;
        break;
      }
    }
  }

  if(scripts\mp\utility\game::getgametype() != "br") {
    if(self.modifiers["mask"] & 1048576 && self.modifiers["mask"] & 262144) {
      getjuggdamagescale(var_5);
    }
  }

  if(var_10 == "other") {
    getkillstreakairstrikeheightent(var_5);
    return;
  }
}

function registerhints(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;
  return var_5;
}

function registerleveldataforvehicle(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(scripts\mp\class::vehicle_checkpiggybackexploit(var_2)) {
    var_5 |= 131072;
  }

  if(scripts\mp\equipment\gas_grenade::plunder_playerspawnedcallback(self, var_1)) {
    var_5 |= 16777216;
  }

  if(var_1 scripts\mp\weapons::isblinded()) {
    var_5 |= 8388608;
  }

  if(scripts\mp\utility\player::unset_relic_trex(var_1)) {
    var_5 |= 2048;
  }

  if(scripts\cp_mp\utility\killstreak_utility::teamhasuav(var_1.team)) {
    var_5 |= 1;
  }

  if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
    var_5 |= 4096;
  }

  if(isDefined(self.radarstrength) && self.radarstrength > 3 && !var_1 scripts\mp\utility\perk::_hasperk("specialty_br_ghost")) {
    var_5 |= 4194304;
  }

  return var_5;
}

function killedplayer(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = gettime();

  if(isDefined(var_2.ref_121D9)) {
    var_2 = var_2.ref_121D9;
  }

  level.numkills++;

  if(level.lastkilltime != var_6) {
    level.prevlastkilltime = level.lastkilltime;
    level.lastkilltime = var_6;
  }

  cargo_truck_mg_initoccupancy(var_0, var_1, var_2, var_3, var_4, var_5);
  checkkillstreakkillevents(var_2, var_3, var_4);
  thread getgulagclosedcircleindex(var_1);
  var_7 = var_1.guid;
  var_8 = self.guid;
  var_9 = createheadicon(var_2);
  thread killedplayernotifysys(var_0, var_1, var_2, var_3);
  thread updaterecentkills(var_0, var_1, var_2, var_9);
  thread ref_13FE5(var_3, var_4, var_1);
  thread updatequadfeedcounter(self, var_0);
  self.prevlastkilltime = self.lastkilltime;
  self.lastkilltime = var_6;
  self.lastkilledplayer = var_1;
  self.lastkillvictimpos = var_1.origin;

  if(self.deaths > 0) {
    var_10 = self.kills / self.deaths;

    if(var_10 > 3) {
      level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_kd_high", undefined, 0.75);
    }
  } else if(self.kills > 5) {
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_kd_high", undefined, 0.75);
  }

  if(istrue(self.laststanding)) {
    scripts\mp\utility\stats::incpersstat("clutch", 1);
  }

  self.damagedplayers[var_7] = undefined;
  var_11 = scripts\mp\utility\weapon::getweapongroup(var_2.basename);

  if(istrue(self.modifiers["firstblood"])) {
    firstblood(var_0);
  }

  if(istrue(self.modifiers["execution"])) {
    execution(var_0);
  }

  if(!scripts\mp\utility\weapon::iskillstreakweapon(var_2.basename) && !scripts\mp\utility\perk::_hasperk("specialty_explosivebullets")) {
    if(var_2.basename == "none" && var_3 != "MOD_EXECUTION") {
      return 0;
    }

    var_12 = celebration_end(self, var_4, var_2, var_3);

    if(istrue(self.modifiers["oneshotkill"])) {
      thread killeventtextpopup("one_shot_kill", 1);
      thread scripts\mp\awards::givemidmatchaward("one_shot_kill");
      scripts\mp\utility\stats::incpersstat("oneShotOneKills", 1);
    }

    if(istrue(self.modifiers["gunbutt"])) {
      thread killeventtextpopup("gun_butt", 1);
      thread scripts\mp\awards::givemidmatchaward("gun_butt");
    }

    if(var_3 == "MOD_MELEE") {
      if(var_2.basename == "iw8_fists_mp") {
        thread killeventtextpopup("fist_kill", 1);
        thread scripts\mp\awards::givemidmatchaward("fist_kill");
      }
    }

    if(istrue(self.modifiers["assistedsuicide"])) {
      assistedsuicide(var_0, var_2);
    }

    if(istrue(self.modifiers["comeback"])) {
      comeback(var_0);
    }

    if(istrue(self.modifiers["headshot"])) {
      level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_headshot", undefined, 0.75);
      headshot(var_0);
    }

    if(istrue(self.modifiers["posthumous"])) {
      postdeathkill(var_0);
    }

    if(!scripts\mp\utility\player::isreallyalive(self) && isDefined(self.deathtime)) {
      var_13 = gettime() - self.deathtime;

      if(scripts\mp\utility\game::issimultaneouskillenabled()) {
        if(var_13 == 0 && isDefined(self.lastattacker) && self.lastattacker == var_1) {
          thread killeventtextpopup("simultaneous_kill", 0);
          thread scripts\mp\awards::givemidmatchaward("simultaneous_kill", undefined, undefined, 1);
          thread killeventtextpopup(var_1, "simultaneous_kill");
          var_1 thread scripts\mp\awards::givemidmatchaward("simultaneous_kill", undefined, undefined, 1);
        }
      }
    }

    if(istrue(self.modifiers["avenger"])) {
      avengedplayer(var_0, var_1.lastkilledplayer);
    }

    var_14 = undefined;

    if(var_1 isinexecutionattack()) {
      var_15 = scripts\common\utility::playersnear(var_1.origin, 300);

      foreach(var_17 in var_15) {
        if(var_17.team == self.team && var_17 isinexecutionvictim()) {
          var_14 = var_17.guid;
          defendedplayer(var_0, var_17.guid);
          break;
        }
      }
    }

    foreach(var_21, var_20 in var_1.damagedplayers) {
      if(isDefined(var_14) && var_21 == var_14) {
        continue;
      }

      if(level.teambased && var_6 - var_20 < 1750) {
        defendedplayer(var_0, var_21);
        LOC_00000432:
      }
      LOC_00000432:
    }

    if(istrue(self.modifiers["pointblank"])) {
      thread pointblank(var_0);
    }

    if(istrue(self.modifiers["longshot"])) {
      thread longshot(var_0);
    }

    if(istrue(self.modifiers["very_longshot"])) {
      thread very_longshot(var_0);
    }

    if(istrue(self.modifiers["backstab"])) {
      if(var_2.basename == "iw8_knife_mp") {
        thread killeventtextpopup("backstab", 1);
        thread scripts\mp\awards::givemidmatchaward("backstab");
      }
    }

    if(var_12) {
      switch (weaponclass(var_2.basename)) {
        case "rifle":
          scripts\mp\utility\stats::incpersstat("arKills", 1);
          var_1 scripts\mp\utility\stats::incpersstat("arDeaths", 1);

          if(var_3 == "MOD_HEAD_SHOT") {
            scripts\mp\utility\stats::incpersstat("arHeadshots", 1);
          }

          break;
        case "smg":
          scripts\mp\utility\stats::incpersstat("smgKills", 1);
          var_1 scripts\mp\utility\stats::incpersstat("smgDeaths", 1);

          if(var_3 == "MOD_HEAD_SHOT") {
            scripts\mp\utility\stats::incpersstat("smgHeadshots", 1);
          }

          if(istrue(self.modifiers["ads"])) {
            if(!isDefined(self.pers["smgADSKills"])) {
              self.pers["smgADSKills"] = 1;
            } else {
              self.pers["smgADSKills"]++;
            }
          }

          break;
        case "spread":
          scripts\mp\utility\stats::incpersstat("shotgunKills", 1);
          var_1 scripts\mp\utility\stats::incpersstat("shotgunDeaths", 1);

          if(var_3 == "MOD_HEAD_SHOT") {
            scripts\mp\utility\stats::incpersstat("shotgunHeadshots", 1);
          }

          break;
        case "mg":
          scripts\mp\utility\stats::incpersstat("lmgKills", 1);
          var_1 scripts\mp\utility\stats::incpersstat("lmgDeaths", 1);

          if(var_3 == "MOD_HEAD_SHOT") {
            scripts\mp\utility\stats::incpersstat("lmgHeadshots", 1);
          }

          break;
        case "sniper":
          scripts\mp\utility\stats::incpersstat("sniperKills", 1);
          var_1 scripts\mp\utility\stats::incpersstat("sniperDeaths", 1);

          if(var_3 == "MOD_HEAD_SHOT") {
            scripts\mp\utility\stats::incpersstat("sniperHeadshots", 1);
          }

          if(istrue(self.modifiers["oneshotkill"])) {
            if(!isDefined(self.pers["sniperOneShotKills"])) {
              self.pers["sniperOneShotKills"] = 1;
            } else {
              self.pers["sniperOneShotKills"]++;
            }
          }

          break;
        case "rocketlauncher":
          scripts\mp\utility\stats::incpersstat("launcherKills", 1);
          var_1 scripts\mp\utility\stats::incpersstat("launcherDeaths", 1);

          if(var_3 == "MOD_HEAD_SHOT") {
            scripts\mp\utility\stats::incpersstat("launcherHeadshots", 1);
          }

          break;
        case "pistol":
          scripts\mp\utility\stats::incpersstat("pistolKills", 1);
          var_1 scripts\mp\utility\stats::incpersstat("pistolPeaths", 1);

          if(var_3 == "MOD_HEAD_SHOT") {
            scripts\mp\utility\stats::incpersstat("pistolHeadshots", 1);
          }

          break;
      }

      if(var_2 hasattachment("akimbo", 1)) {
        self.modifiers["mask3"] = self.modifiers["mask3"] | 256;
      }

      if(var_3 == "MOD_MELEE") {
        scripts\mp\utility\stats::incpersstat("meleeKills", 1);
        var_1 scripts\mp\utility\stats::incpersstat("meleeDeaths", 1);
      } else if(var_3 == "MOD_FIRE" || isDefined(var_2) && isDefined(var_2.basename) && var_2.basename == "molotov_mp") {
        if(!isDefined(self.pers["fireKills"])) {
          self.pers["fireKills"] = 1;
        } else {
          self.pers["fireKills"]++;
        }

        self.modifiers["mask3"] = self.modifiers["mask3"] | 128;
      }

      if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
        foreach(var_23 in level.supportdrones) {
          if(var_23.owner == self && var_23.helperdronetype == "radar_drone_overwatch") {
            var_23.owner scripts\mp\utility\stats::incpersstat("killstreakPersonalUAVKills", 1);
            break;
          }
        }
      }

      if(istrue(self.modifiers["low_health_kill"])) {
        thread givekillreward("low_health_kill", var_0, var_2, "low_health_kill");
        level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "flavor_neardeathkill", undefined, 1);
      }

      if(istrue(self.modifiers["ads"])) {
        scripts\mp\utility\stats::incpersstat("adsKills", 1);
      } else if(istrue(self.modifiers["hipfire"])) {
        scripts\mp\utility\stats::incpersstat("hipfireKills", 1);
      }

      if(istrue(self.modifiers["moving_kill"])) {
        if(!isDefined(self.pers["movingKills"])) {
          self.pers["movingKills"] = 1;
        } else {
          self.pers["movingKills"]++;
        }
      }

      if(self ismantling()) {
        ref_11ABE(var_0);
      }

      if(istrue(self.modifiers["backfire"])) {
        chopper_boss_players_connect_monitor(var_0);
      }
    }

    if(istrue(self.modifiers["air_to_air_kill"])) {
      thread givekillreward("air_to_air_kill", var_0, var_2, "air_to_air_kill");
    }

    if(istrue(self.modifiers["wallkill"])) {
      thread givekillreward("wallkill", var_0, var_2, "wallrun_kill");
    }

    if(istrue(self.modifiers["jumpkill"])) {
      thread givekillreward("jumpkill", var_0, var_2, "air_kill");
    }

    if(istrue(self.modifiers["sliding"])) {
      thread givekillreward("slidekill", var_0, var_2, "slide_kill");
      thread killeventtextpopup("slide_kill", 1);

      if(!isDefined(self.pers["slideKills"])) {
        self.pers["slideKills"] = 1;
      } else {
        self.pers["slideKills"]++;
      }
    }

    if(istrue(self.modifiers["killonwall"])) {
      thread givekillreward("killonwall", var_0, var_2, "kill_wallrunner");
    }

    if(istrue(self.modifiers["killinair"])) {
      thread givekillreward("killinair", var_0, var_2, "kill_jumper");
    }

    if(istrue(self.modifiers["buzzkill"])) {
      buzzkill(var_0, var_1);
    }

    if(istrue(self.modifiers["impaired"])) {
      start_conceal_add(var_0);
    }

    if(isDefined(var_1.stuckbygrenade)) {
      level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_semtex", undefined, 0.75);
    }

    if(scripts\mp\utility\weapon::isthrowingknife(var_2.basename) || scripts\mp\utility\weapon::isaxeweapon(var_2) && isDefined(var_4.classname) && var_4.classname == "grenade") {
      thread killeventtextpopup("throwingknife_kill", 1);
      thread scripts\mp\awards::givemidmatchaward("throwingknife_kill");
    }

    if(scripts\mp\gamescore::isdebuffedbyweaponandplayer(self, var_1, "decoy_grenade_mp")) {
      scripts\mp\rank::scoreeventpopup("baited_kill");
    }

    if(istrue(self.modifiers["kingslayer"])) {
      voting(var_0);

      if(scripts\mp\utility\game::getgametype() == "gun" && var_3 == "MOD_MELEE") {
        thread killeventtextpopup("mode_gun_melee_1st_place", 1);
        thread scripts\mp\awards::givemidmatchaward("mode_gun_melee_1st_place");
      }
    }

    if(self.score < var_1.score) {
      scripts\mp\utility\stats::incpersstat("higherRankedKills", 1);
    } else {
      scripts\mp\utility\stats::incpersstat("lowerRankedKills", 1);
    }

    var_25 = self.pers["cur_kill_streak"] + 1;
    var_26 = 5;

    if(level.gametype == "arm" || level.gametype == "brtdm") {
      var_26 = 10;
    }

    if(!(var_25 % var_26)) {
      if(!isDefined(self.lastkillsplash) || var_25 != self.lastkillsplash) {
        thread scripts\mp\hud_util::teamplayercardsplash("callout_kill_streaking", self, undefined, var_25);
        self.lastkillsplash = var_25;
      }

      if(var_25 <= 30) {
        thread killeventtextpopup("streak_" + var_25, 1);
        thread scripts\mp\awards::givemidmatchaward("streak_" + var_25);
      }
    }

    if(!(var_25 % 5)) {
      scripts\mp\utility\game::setmlgannouncement(13, self.team, self getentitynumber(), var_25);
    }

    if(var_25 > 30) {
      thread killeventtextpopup("streak_max", 1);
      thread scripts\mp\awards::givemidmatchaward("streak_max");
    }

    if(istrue(self.modifiers["item_impact"])) {
      thread scripts\mp\awards::givemidmatchaward("item_impact");
    }

    if(istrue(self.modifiers["launcher_impact"])) {
      linkedsaw(var_0);
    }

    if(scripts\mp\utility\game::getgametypenumlives() >= 1) {
      if(var_1.pers["lives"] == 0) {
        thread scripts\mp\awards::givemidmatchaward("mode_x_eliminate", undefined, undefined, undefined, undefined, var_1);
      }

      var_27 = scripts\mp\utility\game::ref_13E13();

      if(isDefined(var_27) && var_27 == self) {
        thread scripts\mp\awards::givemidmatchaward("mode_x_last_alive", undefined, undefined, undefined, undefined, var_1);
      }
    }

    if(scripts\mp\utility\game::getgametype() == "br" && scripts\mp\flags::gameflag("prematch_done")) {
      if(self ispcplayer()) {
        self setclientomnvar("nVidiaHighlights_events", 25);
      }

      if(var_1 ispcplayer()) {
        var_1 setclientomnvar("nVidiaHighlights_events", 26);
      }
    }

    checksuperkillevents(var_1, var_4, var_2, var_3, var_9);
    checksupershutdownevents(var_1, var_2, var_3);
  }

  if(istrue(self.modifiers["revenge"])) {
    self.lastkilledby = undefined;
    revenge(var_0, var_1);
  }

  if(!scripts\mp\utility\game::lpcfeaturegated()) {
    if(!isDefined(self.killedplayers[var_7])) {
      self.killedplayers[var_7] = 0;
    }

    if(!isDefined(var_1.killedby[var_8])) {
      var_1.killedby[var_8] = 0;
    }

    self.killedplayers[var_7]++;
    var_1.killedby[var_8]++;
  }

  var_1.lastkilledby = self;

  if(!scripts\mp\utility\game::lpcfeaturegated() && !level.multiteambased) {
    var_28 = 0;

    if(level.teambased) {
      var_28 = scripts\mp\utility\teams::getenemycount(self.team);
    } else {
      var_28 = level.players.size - 1;
    }

    if(var_28 > 3 && self.killedplayers.size == var_28) {
      var_29 = 0;

      if(isDefined(self.pers["killEnemyTeam"])) {
        var_29 = self.pers["killEnemyTeam"];
      }

      var_30 = 1;

      foreach(var_17, var_32 in self.killedplayers) {
        if(var_32 <= var_29) {
          var_30 = 0;
          break;
        }
      }

      if(var_30) {
        viphud_deletehud(var_0);
      }
    }
  }

  if(!var_1 scripts\mp\utility\player::isusingremote() && (!var_1 scripts\mp\utility\perk::_hasperk("specialty_survivor") || istrue(var_1.inlaststand))) {
    var_1 thread scripts\mp\utility\player::setdof_killer();
  }

  scripts\mp\utility\script::bufferednotify("kill_event_buffered", var_1, var_9, var_3, self.modifiers);
  thread scripts\mp\potg_events::onplayerkilled(self, var_4, var_1, var_3, var_2, var_5.psoffsettime);
}

function checkkillstreakkillevents(var_0, var_1, var_2) {
  var_3 = scripts\mp\utility\weapon::iskillstreakweapon(var_0.basename) || scripts\mp\utility\weapon::unsetreduceregendelayonkills(var_2);
  var_4 = scripts\mp\utility\points::unset_relic_doomslayer(var_0);

  if(var_3 && !var_4) {
    if(isDefined(var_2) && isDefined(var_2.streakinfo)) {
      var_5 = 1;

      if(isDefined(var_2.streakinfo.mpstreaksysteminfo)) {
        var_6 = var_2.streakinfo.mpstreaksysteminfo.streaklifeid;
        var_7 = self.lifeid;

        if(!isDefined(var_6) || var_6 != var_7) {
          var_5 = 0;
        }

        if(var_2.streakinfo.mpstreaksysteminfo.ref_121B0 != self getxuid()) {
          var_5 = 0;
        }
      }

      if(isDefined(var_2.streakinfo.streakname)) {
        var_8 = 0;
        var_9 = 0;
        var_10 = 0;
        var_11 = var_2.streakinfo.streakname;

        switch (var_11) {
          case "bradley":
            scripts\mp\utility\stats::incpersstat("killstreakTankKills", 1);
            var_8 = 1;
            var_10 = 1;
            break;
          case "chopper_gunner":
            scripts\mp\utility\stats::incpersstat("killstreakChopperGunnerKills", 1);
            var_8 = 1;
            var_9 = 1;
            break;
          case "chopper_support":
            scripts\mp\utility\stats::incpersstat("killstreakChopperSupportKills", 1);
            var_8 = 1;
            var_9 = 1;
            break;
          case "cruise_predator":
            scripts\mp\utility\stats::incpersstat("killstreakCruiseMissileKills", 1);
            var_8 = 1;
            var_9 = 1;
            break;
          case "fuel_airstrike":
            var_8 = 1;
            break;
          case "gunship":
            scripts\mp\utility\stats::incpersstat("killstreakGunshipKills", 1);
            var_8 = 1;
            var_9 = 1;
            break;
          case "hover_jet":
            scripts\mp\utility\stats::incpersstat("killstreakVTOLJetKills", 1);
            var_8 = 1;
            var_9 = 1;
            break;
          case "juggernaut":
            scripts\mp\utility\stats::incpersstat("killstreakJuggernautKills", 1);
            var_8 = 1;
            var_10 = 1;
            break;
          case "manual_turret":
            scripts\mp\utility\stats::incpersstat("killstreakShieldTurretKills", 1);
            var_8 = 1;
            var_10 = 1;
            break;
          case "multi_airstrike":
            var_8 = 1;
            break;
          case "pac_sentry":
            scripts\mp\utility\stats::incpersstat("killstreakWheelsonKills", 1);
            var_8 = 1;
            var_10 = 1;
            break;
          case "precision_airstrike":
            scripts\mp\utility\stats::incpersstat("killstreakAirstrikeKills", 1);
            var_8 = 1;
            var_9 = 1;
            break;
          case "sentry_gun":
            scripts\mp\utility\stats::incpersstat("killstreakSentryGunKills", 1);
            var_8 = 1;
            var_10 = 1;
            break;
          case "toma_strike":
            scripts\mp\utility\stats::incpersstat("killstreakCluserStrikeKills", 1);
            var_8 = 1;
            var_9 = 1;
            break;
          case "white_phosphorus":
            scripts\mp\utility\stats::incpersstat("killstreakWhitePhosphorousKillsAssists", 1);
            var_8 = 1;
            var_9 = 1;
            break;
          case "assault_drone":
            scripts\mp\utility\stats::incpersstat("killstreakAssaultDroneKills", 1);
            var_8 = 1;
            var_9 = 1;
            break;
          default:
            thread scripts\mp\utility\points::giveunifiedpoints("killstreak_full_score", var_0);
            break;
        }

        if(isDefined(var_2.streakinfo.kills)) {
          var_2.streakinfo.kills++;

          if(!istrue(var_2.streakinfo.ref_11E04) && var_2.streakinfo.kills > 1) {
            scripts\cp\vehicles\vehicle_compass_cp::ref_12C3F("t9_ch_global_scorestreak_kill_two_or_more_s1", 1);
            var_2.streakinfo.ref_11E04 = 1;
          }
        }

        scripts\mp\utility\stats::incpersstat("killstreakKills", 1);

        if(var_9) {
          scripts\mp\utility\stats::incpersstat("killstreakAirKills", 1);
        }

        if(var_10) {
          scripts\mp\utility\stats::incpersstat("killstreakGroundKills", 1);
        }

        if(var_8) {
          var_12 = "ss_kill_" + var_11;
          var_13 = undefined;

          if(var_5 && scripts\mp\utility\perk::_hasperk("specialty_chain_killstreaks")) {
            var_14 = level.awards[var_12].xpscoreevent;
            var_13 = scripts\mp\rank::getscoreinfovalue(var_14);
          }

          var_15 = 1;
          thread scripts\mp\awards::givemidmatchaward(var_12, var_13, undefined, undefined, var_15, undefined, var_5, var_2);
        }

        level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_killstreak", undefined, 0.75);
        return;
      }

      return;
    }

    return;
  }
}

function checksuperkillevents(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\supers::issuperinuse();
  var_6 = scripts\mp\supers::getcurrentsuperref();
  var_7 = scripts\mp\supers::getcurrentsuper();
  var_8 = scripts\mp\utility\weapon::issuperweapon(var_2.basename);
  var_9 = undefined;

  if(!isDefined(var_6)) {
    return;
  }

  if(var_8) {
    thread killedplayerwithsuperweapon(var_0, var_1, var_2, var_3, var_4);

    if(var_3 != "MOD_MELEE") {
      scripts\mp\utility\script::bufferednotify("super_kill_buffered");
    }
  }

  var_10 = 0;

  if(isDefined(var_6)) {
    switch (var_6) {
      default:
        break;
    }

    if(var_10) {
      thread superkill(var_6, var_3);
      scripts\mp\supers::combatrecordsuperkill(var_6);

      if(isDefined(var_9)) {
        thread scripts\mp\utility\points::giveunifiedpoints(var_9);
      }

      scripts\mp\utility\script::bufferednotify("super_kill_buffered");
      return;
    }

    return;
  }
}

function checksupershutdownevents(var_0, var_1, var_2) {
  var_3 = var_0 scripts\mp\supers::issuperinuse();
  var_4 = var_0 scripts\mp\supers::getcurrentsuperref();
  var_5 = var_0 scripts\mp\supers::getcurrentsuper();

  if(!isDefined(var_4)) {
    return;
  }

  switch (var_4) {
    default:
      if(var_3 == 1) {
        thread supershutdown(var_0);
      }

      break;
  }
}

function killedplayerwithsuperweapon(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\supers::getsuperrefforsuperweapon(var_2);
  var_6 = self.recentkillsperweapon[var_4];

  if(isDefined(var_6) && var_6 > 0 && var_6 % 2 == 0) {
    superkill(var_5, var_3);
  } else {
    var_7 = scripts\mp\supers::getcurrentsuper();
    var_7.numkills++;
  }

  scripts\cp\vehicles\vehicle_compass_cp::updatesuperweaponkills(var_2, var_1);
  scripts\mp\supers::combatrecordsuperkill(var_5);
}

function superkill(var_0, var_1) {
  var_2 = scripts\mp\supers::getrootsuperref(var_0);
  var_3 = "super_kill_" + var_2;

  switch (var_3) {
    case "super_kill_chargemode":
      var_3 = "super_kill_bull_charge";
      break;
  }

  if(isDefined(level.awards[var_3])) {
    thread scripts\mp\awards::givemidmatchaward(var_3);
  }

  var_4 = scripts\mp\supers::getcurrentsuper();
  var_4.numkills++;
  scripts\cp\vehicles\vehicle_compass_cp::updatesuperkills(var_0, var_1, var_4.numkills);
  self.modifiers["super_kill_medal"] = var_0;
}

function killedkillstreak(var_0, var_1, var_2) {
  var_3 = "kill_ss_" + var_0;

  if(isDefined(var_2) && weaponclass(var_2) != "rocketlauncher" && var_2.basename != "iw8_la_kgolf_mp") {
    var_2 = undefined;
  }

  thread killeventtextpopup(var_1, var_3);
  var_1 thread scripts\mp\awards::givemidmatchaward(var_3, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_2);
  var_1 scripts\mp\utility\stats::incpersstat("destroyedKillstreaks", 1);
  level thread scripts\mp\battlechatter_mp::saytoself(var_1, "plr_killstreak_destroy", undefined, 0.75);
}

function ref_128B3(var_0) {
  var_1 = scripts\mp\killstreaks\killstreaks::rocket_internal(var_0);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_3 thread scripts\mp\utility\points::giveunifiedpoints("scrap_assist");
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
  if(isalive(var_0) && var_2 != "MOD_MELEE" && !var_0 scripts\mp\utility\player::isusingremote() && (scripts\mp\utility\weapon::isprimaryweapon(var_1) || scripts\mp\utility\weapon::iscacsecondaryweapon(var_1)) && !scripts\mp\utility\weapon::iskillstreakweapon(var_1.basename) && !istrue(var_0.assistedsuicide)) {
    var_5 = distancesquared(var_3, var_4.origin);

    if(var_5 < 9216) {
      return "pointblank";
    }

    if(var_5 > 4000000) {
      return "very_longshot";
    }

    var_6 = scripts\mp\utility\weapon::getweapongroup(var_1.basename);
    var_7 = undefined;

    switch (var_6) {
      case "weapon_pistol":
        var_7 = 800;
        break;
      case "weapon_beam":
      case "weapon_smg":
        var_7 = 1200;
        break;
      case "weapon_lmg":
      case "weapon_dmr":
      case "weapon_assault":
      case "weapon_tactical":
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
        var_7 = 1200;
        break;
      case "weapon_melee2":
      case "other":
        var_7 = 1969;
        break;
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
  var_4 = scripts\mp\utility\weapon::getweapongroup(var_2.basename);
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
    case "weapon_lmg":
    case "weapon_assault":
    case "weapon_tactical":
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
  return var_0.health > 0 && var_0.health < var_0.maxhealth * 0.5;
}

function underbridge_reinforce_enemy_monitor(var_0, var_1) {
  var_2 = isDefined(var_1.lastsnapshotgrenadetime) && var_1.lastsnapshotgrenadetime + scripts\mp\equipment\snapshot_grenade::removespawnselections() > gettime();
  var_3 = isDefined(var_0.radarstrength) && var_0.radarstrength > 3 && !var_1 scripts\mp\utility\perk::_hasperk("specialty_br_ghost");
  var_4 = istrue(var_1.update_bomb_vest_lua);
  return var_2 || var_3 || var_4;
}

function givekillreward(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    thread scripts\mp\awards::givemidmatchaward(var_3);
    return;
  }

  thread scripts\mp\utility\points::giveunifiedpoints(var_0, var_2);
}

function proximityassist(var_0) {
  self.modifiers["proximityAssist"] = 1;
  thread scripts\mp\utility\points::giveunifiedpoints("proximityassist");
}

function proximitykill(var_0) {
  self.modifiers["proximityKill"] = 1;
  thread scripts\mp\utility\points::giveunifiedpoints("proximitykill");
}

function longshot(var_0) {
  thread scripts\common\utility::ref_13E0A(level.ref_11B26, var_0, "longshot");
  scripts\mp\utility\stats::incpersstat("longshotKills", 1);
  thread killeventtextpopup("longshot", 1);
  thread scripts\mp\awards::givemidmatchaward("longshot");

  if(self.currentweapon hasattachment("gunperk_acquisition") || self.currentweapon hasattachment("gunperk_acquisition_ch2")) {
    thread scripts\mp\perks\perkfunctions::ref_13121();
    return;
  }
}

function very_longshot(var_0) {
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "flavor_headshotlong", undefined, 1);
}

function pointblank(var_0) {
  thread scripts\common\utility::ref_13E0A(level.ref_11B26, var_0, "pointblank");
  thread killeventtextpopup("pointblank", 1);
  thread scripts\mp\awards::givemidmatchaward("pointblank");
  scripts\mp\utility\stats::incpersstat("pointBlankKills", 1);
}

function headshot(var_0) {
  thread scripts\common\utility::ref_13E0A(level.ref_11B26, var_0, "headshot");
  thread killeventtextpopup("headshot", 1);
  thread scripts\mp\awards::givemidmatchaward("headshot");
}

function avengedplayer(var_0, var_1) {
  thread scripts\common\utility::ref_13E0A(level.ref_11B26, var_0, "avenger");
  scripts\mp\utility\stats::incpersstat("avengerKills", 1);
  thread killeventtextpopup("avenger", 1);
  thread scripts\mp\awards::givemidmatchaward("avenger");
}

function assistedsuicide(var_0, var_1) {
  thread scripts\mp\utility\points::giveunifiedpoints("assistedsuicide", var_1);
  thread scripts\common\utility::ref_13E0A(level.ref_11B26, var_0, "assistedsuicide");
  thread killeventtextpopup("assistedsuicide", 1);
  thread scripts\mp\awards::givemidmatchaward("assistedsuicide");
}

function defendedplayer(var_0, var_1) {
  thread scripts\common\utility::ref_13E0A(level.ref_11B26, var_0, "defender");
  scripts\mp\utility\stats::incpersstat("defenderKills", 1);
  thread killeventtextpopup("savior", 0);
  thread scripts\mp\awards::givemidmatchaward("save_teammate");
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "flavor_save", undefined, 1);
}

function postdeathkill(var_0) {
  thread scripts\common\utility::ref_13E0A(level.ref_11B26, var_0, "posthumous");
  thread killeventtextpopup("posthumous", 1);
  thread scripts\mp\awards::givemidmatchaward("posthumous");
}

function revenge(var_0, var_1) {
  thread scripts\common\utility::ref_13E0A(level.ref_11B26, var_0, "revenge");
  scripts\mp\utility\stats::incpersstat("revengeKills", 1);
  thread killeventtextpopup("revenge", 1);
  thread scripts\mp\awards::givemidmatchaward("revenge");
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "flavor_revenge", undefined, 1);
  playFX(scripts\engine\utility::getfx("money"), var_1.origin + (0, 0, 64));
}

function multikill(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.inneurotoxintimestamp)) {
    self.inneurotoxintimestamp = var_1;
  }

  if(var_1 < self.inneurotoxintimestamp) {
    return;
  }

  self endon("disconnect");
  level endon("game_ended");
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

  thread scripts\common\utility::ref_13E0A(level.ref_11B2B, var_0, var_1);

  if(isDefined(var_4)) {
    thread killeventtextpopup(var_4, scripts\engine\utility::ter_op(isDefined(var_2), var_2, 1), istrue(var_3));

    if(!istrue(var_3)) {
      thread scripts\mp\awards::givemidmatchaward(var_4);
    }
  }

  if(isDefined(var_5)) {
    thread scripts\mp\hud_util::teamplayercardsplash(var_5, self);
    return;
  }
}

function firstblood(var_0) {
  scripts\mp\utility\game::setmlgannouncement(11, self.team, self getentitynumber());
  thread scripts\common\utility::ref_13E0A(level.ref_11B26, var_0, "firstblood");
  thread scripts\mp\hud_util::teamplayercardsplash("callout_firstblood", self);
  thread killeventtextpopup("firstblood", 1);
  thread scripts\mp\awards::givemidmatchaward("firstblood");
}

function buzzkill(var_0, var_1) {
  thread scripts\common\utility::ref_13E0A(level.ref_11B26, var_0, "buzzkill");
  thread killeventtextpopup("buzzkill", 1);
  thread scripts\mp\awards::givemidmatchaward("buzzkill");
}

function start_conceal_add(var_0) {
  thread killeventtextpopup("stunned_kill", 1);
  thread scripts\mp\awards::givemidmatchaward("stunned_kill");
}

function comeback(var_0) {
  thread scripts\common\utility::ref_13E0A(level.ref_11B26, var_0, "comeback");
  thread killeventtextpopup("comeback", 1);
  thread scripts\mp\awards::givemidmatchaward("comeback");
  scripts\mp\utility\stats::incpersstat("comebackKills", 1);
}

function supershutdown(var_0) {
  var_1 = scripts\mp\supers::getrootsuperref(var_0.super.staticdata.ref);
  self.modifiers["superShutdown"] = var_0.super.staticdata.ref;
  var_2 = "super_shutdown_" + var_1;

  switch (var_1) {
    case "chargemode":
      var_2 = "super_shutdown_bull_charge";
      break;
  }

  if(isDefined(level.awards[var_2])) {
    thread scripts\mp\awards::givemidmatchaward(var_2);
    return;
  }
}

function collateral(var_0) {
  if(var_0 == 2) {
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_twofer", undefined, 0.75);
    thread killeventtextpopup("one_shot_two_kills", 1);
    thread scripts\mp\awards::givemidmatchaward("one_shot_two_kills");
  }

  if(var_0 == 3) {
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_threefer", undefined, 0.75);
  }

  if(var_0 > 1) {
    self.modifiers["collateral"] = 1;
    self.modifiers["mask3"] = self.modifiers["mask3"] | 64;
  }

  thread scripts\mp\potg_events::collateral(self, var_0);
}

function shotguncollateral(var_0) {
  thread scripts\mp\potg_events::shotguncollateral(self, var_0);
}

function ref_11ABE(var_0) {
  thread killeventtextpopup("mantle_kill", 1);
  thread scripts\mp\awards::givemidmatchaward("mantle_kill");
}

function chopper_boss_players_connect_monitor(var_0) {
  thread killeventtextpopup("backfire", 1);
  thread scripts\mp\awards::givemidmatchaward("backfire");
}

function quadfeed(var_0, var_1) {
  self.modifiers["quadfeed"] = 1;
  self.modifiers["mask"] = self.modifiers["mask"] | 536870912;
  thread killeventtextpopup("quad_feed", 1);
  thread scripts\mp\awards::givemidmatchaward("quad_feed");
  thread scripts\mp\potg_events::quadfeed(self, var_1.starttime, gettime());
}

function viphud_deletehud(var_0) {
  self.modifiers["killEnemyTeam"] = 1;
  self.modifiers["mask2"] = self.modifiers["mask2"] | 2;
  scripts\mp\utility\stats::incpersstat("killEnemyTeam", 1);
}

function voting(var_0) {
  thread killeventtextpopup("first_place_kill", 1);
  thread scripts\mp\awards::givemidmatchaward("first_place_kill");
  scripts\mp\utility\stats::incpersstat("highestRankedKills", 1);
}

function linkedsaw(var_0) {
  thread killeventtextpopup("launcher_direct_hit", 1);
  thread scripts\mp\awards::givemidmatchaward("launcher_direct_hit");
}

function ref_13DD1(var_0) {
  self.modifiers["tripledefenderkill"] = 1;
  self.modifiers["mask2"] = self.modifiers["mask2"] | 32;
}

function execution(var_0) {
  scripts\mp\utility\stats::incpersstat("executions", 1);
  thread scripts\mp\utility\points::giveunifiedpoints("execution");
}

function disconnected() {
  var_0 = self.guid;

  if(!scripts\mp\utility\game::lpcfeaturegated()) {
    for(var_1 = 0; var_1 < level.players.size; var_1++) {
      if(isDefined(level.players[var_1].killedplayers[var_0])) {
        level.players[var_1].killedplayers[var_0] = undefined;
      }

      if(isDefined(level.players[var_1].killedby[var_0])) {
        level.players[var_1].killedby[var_0] = undefined;
      }
    }

    return;
  }
}

function monitorhealed() {
  level endon("end_game");

  for(;;) {
    level waittill("healed", var_0);
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("healed");
  }
}

function ref_1400F(var_0) {
  if(!isDefined(self.modifiers)) {
    return;
  }

  if(!isDefined(self.ref_12A85)) {
    self.ref_12A85 = [];
  }

  if(istrue(self.modifiers[var_0])) {
    if(istrue(self.ref_12A85[var_0]) && self.recentkillcount > 1) {
      self.ref_11E03[var_0] = 1;
    }

    self.ref_12A85[var_0] = 1;
    return;
  }

  self.ref_12A85[var_0] = undefined;
}

function updaterecentkills(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");
  var_4 = weaponclass(var_2.basename);
  self.recentkillcount++;
  ref_1400F("mounted");

  if(var_4 == "smg") {
    if(!isDefined(self.ref_12A89)) {
      self.ref_12A89 = 1;
    } else {
      self.ref_12A89++;
    }
  }

  var_5 = scripts\mp\utility\weapon::getweapongroup(var_2.basename);

  if(isDefined(self.radarstrength) && self.radarstrength > 3 && !var_1 scripts\mp\utility\perk::_hasperk("specialty_br_ghost")) {
    if(!isDefined(self.ref_12A8B)) {
      self.ref_12A8B = 1;
    } else {
      self.ref_12A8B++;
    }
  }

  if(scripts\mp\utility\game::isdefending(var_1)) {
    self.recentdefendcount++;

    if(scripts\mp\utility\script::isnumbermultipleof(self.recentdefendcount, 2)) {
      thread scripts\mp\awards::givemidmatchaward("mode_x_wipeout");
    }
  }

  if(scripts\mp\utility\game::turret_outline_watcher(var_1)) {
    self.ref_12A82++;

    if(scripts\mp\utility\script::isnumbermultipleof(self.ref_12A82, 3)) {
      ref_13DD1(var_0);
    }
  }

  if(!isDefined(self.recentkillsperweapon)) {
    self.recentkillsperweapon = [];
  }

  if(!isDefined(self.ref_12A86)) {
    self.ref_12A86 = [];
  }

  if(!isDefined(self.recentkillsperweapon[var_3])) {
    self.recentkillsperweapon[var_3] = 1;
  } else {
    self.recentkillsperweapon[var_3]++;
  }

  if(!isDefined(self.ref_12A86[var_2.basename])) {
    self.ref_12A86[var_2.basename] = 1;
  } else {
    self.ref_12A86[var_2.basename]++;
  }

  var_6 = scripts\mp\utility\weapon::getequipmenttype(var_2.basename);

  if(isDefined(var_6) && var_6 == "lethal" && !scripts\mp\utility\weapon::isthrowingknife(var_2)) {
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_grenade", undefined, 0.75);
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_amf", undefined, 0.75);

    if(self.recentkillsperweapon[var_3] > 0 && self.recentkillsperweapon[var_3] % 2 == 0) {
      thread killeventtextpopup("grenade_double", 1);
      thread scripts\mp\awards::givemidmatchaward("grenade_double");
    }
  }

  scripts\mp\utility\script::bufferednotify("update_rapid_kill_buffered", self.recentkillcount, var_3);

  if(!isDefined(self.recentkillcount)) {
    self.recentkillcount = 0;
  }

  if(self.recentkillcount > 1) {
    thread multikill(var_0, self.recentkillcount, 0);
    scripts\cp\vehicles\vehicle_compass_cp::init_silo_elevator(self, self.ref_11E03, var_2, self.recentkillcount);
  }

  wait 4;

  if(self.recentkillcount > 1) {
    thread multikill(var_0, self.recentkillcount, 1, 1);

    if(self.recentkillcount > 2) {
      scripts\mp\utility\game::setmlgannouncement(12, self.team, self getentitynumber(), self.recentkillcount);
    }
  }

  scripts\mp\utility\stats::incpersstat("mostMultikills", 1);
  self.recentkillcount = 0;
  self.recentdefendcount = 0;
  self.ref_12A89 = 0;
  self.ref_12A8A = undefined;
  self.recentkillsperweapon = undefined;
  self.ref_12A86 = undefined;
  self.ref_11E04 = 0;
  self.ref_12A85 = [];
  self.ref_11E03 = [];
}

function ref_13FE5(var_0, var_1, var_2) {
  if(scripts\mp\utility\game::getgametype() != "br" || !isDefined(level.br_challengeevaluatorfunc)) {
    return;
  }

  var_3 = spawnStruct();
  var_3.meansofdeath = var_0;
  var_3.inflictor = var_1;
  var_3.victim = var_2;
  var_3.ref_11A6C = 1;
  self[[level.br_challengeevaluatorfunc]]("br_mastery_travelogue", var_3);
  self[[level.br_challengeevaluatorfunc]]("br_mastery_c4VehicleMultKill", var_3);
  self[[level.br_challengeevaluatorfunc]]("br_mastery_ghostRideWhip", var_3);
}

function monitorcratejacking() {
  level endon("end_game");
  self endon("disconnect");

  for(;;) {
    self waittill("hijacker", var_0, var_1);
    thread scripts\mp\awards::givemidmatchaward("ss_use_enemy_dronedrop");
    var_2 = "hijacked_airdrop";

    if(isDefined(var_1)) {
      var_1 scripts\mp\hud_message::showsplash(var_2, undefined, self);
    }
  }
}

function updatequadfeedcounter(var_0, var_1) {
  if(isDefined(level.quadfeedinfo) && gettime() - level.quadfeedinfo.starttime > 10000) {
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
  if(scripts\mp\utility\player::isreallyalive(self)) {
    var_0 = self issprintsliding();

    if(istrue(self.eventswassliding) && !var_0) {
      self.eventsslideendtime = gettime();
      scripts\mp\potg::processevent("recent_slide");
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
  self.wasads = scripts\mp\utility\player::isplayerads();
  self.lastadsstarttime = 0;
}

function monitoradstime() {
  if(scripts\mp\utility\player::isplayerads()) {
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
    scripts\mp\utility\stats::incpersstat("reloads", 1);
  }
}

function monitorweaponpickup() {
  level endon("game_ended");
  self endon("disconnect");
  self.lastweaponpickuptime = 0;

  for(;;) {
    self waittill("weapon_pickup");
    self.lastweaponpickuptime = gettime();
    scripts\mp\utility\stats::incpersstat("weaponPickups", 1);
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

  if(!istrue(var_0) && self.mantlecur) {
    scripts\mp\potg::processevent("recent_mantle");
  }

  var_1 = self.jumpcur;
  self.jumpcur = self isjumping();

  if(!istrue(var_1) && self.jumpcur) {
    scripts\mp\potg::processevent("recent_jump");
  }

  var_2 = self getstance();

  if(var_2 != self.laststance) {
    scripts\mp\potg_events::playerstancechanged(var_2);

    if(self.laststance == "crouch") {
      var_3 = self.laststancechangetime;
      var_4 = (gettime() - var_3) / 1000;
      scripts\mp\utility\stats::incpersstat("timeCrouched", var_4);
    }

    if(self.laststance == "prone") {
      var_3 = self.laststancechangetime;
      var_4 = (gettime() - var_3) / 1000;
      scripts\mp\utility\stats::incpersstat("timeProne", var_4);
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

function predatormissileimpact(var_0) {
  scripts\mp\potg_events::predatormissileimpact(var_0);
}

function largevehicleexplosion(var_0) {
  scripts\mp\potg_events::largevehicleexplosion(var_0);
}

function vehiclekilled(var_0) {
  scripts\mp\potg_events::vehiclekilled(var_0);
}

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

function missilewhizby(var_0, var_1) {
  scripts\mp\potg_events::missilewhizby(var_0);
}

function bombdefused(var_0) {
  var_1 = 0;

  if(scripts\mp\utility\game::getgametypenumlives() >= 1) {
    var_2 = scripts\mp\utility\game::getpotentiallivingplayers();

    if(var_2.size == 1 && var_2[0] == var_0) {
      var_1 = 1;
    }
  }

  var_3 = 0;

  if(!var_1 && scripts\mp\utility\game::getgametype() != "dd") {
    var_4 = scripts\mp\utility\player::getplayersinradius(var_0.origin, 600);

    foreach(var_6 in var_4) {
      if(var_6.team != var_0.team) {
        var_3 = 1;
        break;
      }
    }
  }

  if(isDefined(level.bombowner) && level.bombowner.bombplantedtime + 3000 + level.defusetime * 1000 > gettime() && scripts\mp\utility\player::isreallyalive(level.bombowner)) {
    var_0 thread scripts\mp\rank::scoreeventpopup("ninja_defuse");
    var_0 thread scripts\mp\hud_message::showsplash("ninja_defuse", scripts\mp\rank::getscoreinfovalue("defuse"));

    if(scripts\mp\utility\game::getgametype() != "dd") {
      var_3 = 1;
    }
  } else {
    var_0 thread scripts\mp\hud_message::showsplash("emp_defuse", scripts\mp\rank::getscoreinfovalue("defuse"));
    var_0 thread scripts\mp\rank::scoreeventpopup("defuse");
  }

  if(var_1) {
    var_0 thread scripts\mp\awards::givemidmatchaward("mode_sd_last_defuse");
  } else {
    var_0 thread scripts\mp\awards::givemidmatchaward("mode_sd_defuse");
  }

  var_0 scripts\mp\utility\stats::incpersstat("defuses", 1);
  var_0 scripts\mp\persistence::statsetchild("round", "defuses", var_0.pers["defuses"]);

  if(scripts\mp\utility\game::getgametype() != "sr") {
    var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["defuses"]);
  }

  if(isPlayer(var_0)) {
    var_0 thread scripts\common\utility::ref_13E0A(level.ref_11B29, "defuse", var_0.origin);
  }

  if(var_1) {
    scripts\mp\utility\game::ref_119AC(var_0, undefined, "Bomb Defused", var_0.origin, "last_alive");
  } else {
    scripts\mp\utility\game::ref_119AC(var_0, undefined, "Bomb Defused", var_0.origin);
  }

  scripts\mp\potg_events::bombdefused(var_0, var_1, var_3);
}

function revivedplayer(var_0, var_1) {
  if(var_0 == var_1) {
    return;
  }

  scripts\mp\potg_events::revivedplayer(var_0, var_1);
  var_0 scripts\cp\vehicles\vehicle_compass_cp::ref_12C3F("t9_ch_global_revived_teammate_for_operator_mission", 1);

  if(scripts\mp\utility\game::getgametype() == "br" && isDefined(level.º: ] û© ý] oe°„)¡˜ jÃ) û3 #Èû’¨—)) {
  self[[level.º: ] û© ý] oe°„)¡˜ jÃ) û3 #Èû’¨—]](var_0, var_1);

if(getdvarint("OMSQPMNQLS", 0) && var_0 scripts\mp\utility\game::onlinestatsenabled()) {
  var_0 setplayerdata("mp", "use_revive_history", 0, 1);
  return;
}

return;
}
}

function doorused(var_0, var_1) {
  scripts\mp\potg_events::doorused(var_0, var_1);

  if(var_1) {
    var_0.lastdooropentime = gettime();
    return;
  }
}

function shothit() {
  if(!isDefined(self.pers["shotsHit"])) {
    scripts\mp\utility\stats::initpersstat("shotsHit");
  }

  scripts\mp\utility\stats::incpersstat("shotsHit", 1);
  scripts\mp\potg_events::shothit();
}

function shotmissed() {
  scripts\mp\potg_events::shotmissed();
}

function killeventtextpopup(var_0, var_1, var_2) {
  self endon("death_or_disconnect");

  if(!scripts\mp\rank::scoreeventhastext(var_0)) {
    return;
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
  var_6.priority = scripts\mp\rank::getscoreeventpriority(var_0);
  var_6.alwaysshowsplash = scripts\mp\rank::scoreeventalwaysshowassplash(var_0);
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
  thread ref_128B4();
}

function ref_128B4() {
  self notify("processSplashPriorityQueue");
  self endon("processSplashPriorityQueue");
  self.ref_12464 = 1;

  if(!isDefined(self.splashpriorityqueue)) {
    self.ref_12464 = 0;
  }

  foreach(var_1 in self.splashpriorityqueue) {
    if(var_1.ref_128AC) {
      continue;
    }

    if(!istrue(level.removekilleventsplash) && istrue(var_1.showassplash) && (!self.ref_12464 || var_1.alwaysshowsplash)) {
      var_2 = 1;
      thread scripts\mp\hud_message::showsplash(var_1.scoreeventref);
    }

    var_1.ref_128AC = 1;
  }

  foreach(var_1 in self.splashpriorityqueue) {
    if(var_1.ref_128AB || var_1.matchdata_logplayerlife) {
      continue;
    }

    thread scripts\mp\rank::scoreeventpopup(var_1.scoreeventref);
    var_1.ref_128AB = 1;
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

function reset_map_dvars() {
  var_0 = [];

  if(!scripts\mp\utility\game::lpcfeaturegated() && isDefined(self.killedby)) {
    var_1 = 0;

    foreach(var_3 in self.killedby) {
      if(var_3 > var_1) {
        var_0 = [];
        var_0 = var_4;
      }

      if(var_3 == var_1) {
        var_0 = var_4;
      }
    }
  }

  return var_0;
}

function vehicle_collision_handlemultievent(var_0, var_1) {
  if(isDefined(var_0) && scripts\mp\utility\weapon::getweaponrootname(var_0.basename) == "iw8_sn_xmike109" && isDefined(var_1.hitloc) && (var_1.hitloc == "head" || var_1.hitloc == "helmet")) {
    return 1;
  }

  return 0;
}

function turn_on_laser_vfx(var_0, var_1) {
  if(isDefined(var_0) && scripts\mp\utility\weapon::getweaponrootname(var_0.basename) == "iw8_sh_aalpha12" && isDefined(var_1.hitloc) && (var_1.hitloc == "head" || var_1.hitloc == "helmet")) {
    return 1;
  }

  return 0;
}

function getkillstreakairstrikeheightent(var_0) {
  if(!level.challengesallowed) {
    return;
  }

  var_1 = scripts\mp\equipment::getequipmentreffromweapon(var_0);

  if(!isDefined(var_1) || !isDefined(level.weapon_xp_iw8_pi_papa320[var_1])) {
    return;
  }

  if(self.pers["lethalEquipmentKillMask"] &level.weapon_xp_iw8_pi_papa320[var_1]) {
    return;
  } else {
    self.pers["lethalEquipmentKillMask"] = self.pers["lethalEquipmentKillMask"] | level.weapon_xp_iw8_pi_papa320[var_1];
  }

  var_2 = 0;

  foreach(var_4 in level.weapon_xp_iw8_pi_papa320) {
    if(self.pers["lethalEquipmentKillMask"] &var_4) {
      var_2++;

      if(var_2 >= 6) {
        self reportchallengeuserevent("collect_item", "lethal_achievement");
        break;
      }
    }
  }
}

function thermite_laststand_effects() {
  level.showquestcircletoall = [];
  var_0 = ["weapon_pistol", "weapon_smg", "weapon_assault", "weapon_dmr", "weapon_sniper", "weapon_shotgun", "weapon_lmg", "weapon_tactical"];
  var_1 = 0;

  foreach(var_3 in var_0) {
    level.showquestcircletoall[var_3] = 1 << var_1;
    var_1++;
  }
}

function getjuggdamagescale(var_0) {
  if(!level.challengesallowed) {
    return;
  }

  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  if(!isDefined(var_1) || !isDefined(level.showquestcircletoall[var_1])) {
    return;
  }

  if(self.pers["headshotLongshotMask"] &level.showquestcircletoall[var_1]) {
    return;
  } else {
    self.pers["headshotLongshotMask"] = self.pers["headshotLongshotMask"] | level.showquestcircletoall[var_1];
  }

  var_2 = 0;

  foreach(var_4 in level.showquestcircletoall) {
    if(self.pers["headshotLongshotMask"] &var_4) {
      var_2++;

      if(var_2 >= 5) {
        self reportchallengeuserevent("collect_item", "hsls_achievement");
        break;
      }
    }
  }
}

function start_puzzle() {
  if(!level.challengesallowed) {
    return;
  }

  if(self.ref_11F87 == -1) {
    return;
  }

  self.ref_11F87++;
  var_0 = undefined;

  switch (level.mapname) {
    case "mp_m_speed":
    case "mp_shipment":
      var_0 = 50;
      break;
    default:
      var_0 = 30;
      break;
  }

  if(self.ref_11F87 >= var_0) {
    self reportchallengeuserevent("collect_item", "objective_player_achievement");
    self.ref_11F87 = -1;
    return;
  }
}

function getgulagclosedcircleindex(var_0) {
  self endon("disconnect");
  var_1 = 0;

  if(!level.challengesallowed || !isDefined(var_0)) {
    self.ref_12A9A = undefined;
    return;
  }

  if(isPlayer(var_0) && isDefined(self.ref_12A9A)) {
    if(self.modifiers["mask2"] & 32768) {
      var_1 = 1;
    }
  }

  level scripts\engine\utility::ref_143B9(1, "game_ended");

  if(level.gameended) {
    if(var_1) {
      self reportchallengeuserevent("collect_item", "recon_drone_achievement");

      if(isDefined(self.ref_12A9A)) {
        self.ref_12A9A reportchallengeuserevent("collect_item", "recon_drone_achievement");
      }
    }

    if(scripts\mp\utility\game::getgametype() == "br" && isDefined(level.br_challengeevaluatorfunc)) {
      var_2 = spawnStruct();
      var_2.player = self;
      self[[level.br_challengeevaluatorfunc]]("br_mastery_roundKillExecute", var_2);
    }
  }

  self.ref_12A9A = undefined;
}