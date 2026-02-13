/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1998.gsc
*************************************************/

init() {
  var_0 = scripts\mp\utility\game::getgametype();

  if(!isDefined(var_0)) {
    var_0 = getDvar("#x315af23e89f368200");
  }

  scripts\engine\utility::_id_3F1B("vehicleDisabled", ::vehicledisabled);
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow("mp/score_event_table.csv", var_1, 0);

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow("mp/score_event_table.csv", var_1, level._id_33AE._id_60B1[var_0]);

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
      scripts\mp\rank::_id_C2AC(var_2, "value", var_3);
    }

    var_4 = tablelookuprownum("mp/splashTable.csv", 0, var_2);
    scripts\mp\rank::_id_C2AC(var_2, "eventID", var_4);
    var_4 = _func_0222("mp/splashTable.csv", 0, var_2, 2);
    scripts\mp\rank::_id_C2AC(var_2, "text", var_4);
    var_4 = int(_func_0222("mp/splashTable.csv", 0, var_2, 13));
    scripts\mp\rank::_id_C2AC(var_2, "priority", var_4);
    var_4 = int(_func_0222("mp/splashTable.csv", 0, var_2, 14));
    scripts\mp\rank::_id_C2AC(var_2, "alwaysShowSplash", var_4);
    var_5 = tablelookuprownum("mp/splashTable.csv", 0, var_2);

    if(isDefined(var_5) && var_5 != -1) {
      scripts\mp\rank::_id_C2AC(var_2, "splashID", var_5);
    }

    var_6 = tablelookupbyrow("mp/score_event_table.csv", var_1, 5);
    scripts\mp\rank::_id_C2AC(var_2, "group", var_6);
    var_7 = tablelookupbyrow("mp/score_event_table.csv", var_1, 4);

    if(isDefined(var_7) && tolower(var_7) == "true") {
      scripts\mp\rank::_id_C2AC(var_2, "allowBonus", 1);
    }

    var_8 = tablelookupbyrow("mp/score_event_table.csv", var_1, 2);

    if(isDefined(var_8)) {
      scripts\mp\rank::_id_C2AC(var_2, "dialogAlias", var_8);
    }

    var_1++;
  }

  level._effect["money"] = loadfx("vfx/props/cash_player_drop");
  level._id_A78D = 0;
  level._id_BC4A = 0;
  level._id_9000 = 0;
  level thread onplayerconnect();
  level thread _id_A116();

  if(!scripts\mp\utility\game::_id_CA4B()) {
    _id_0AA3::_id_C28D(::_id_AB76);
    _id_0A9E::_id_C29C(::_id_A0F2);
    _id_0A9E::_id_C29C(::monitorholdbreath);
    _id_0A9E::_id_C29C(::_id_FD41);
    _id_0A9E::_id_C29C(::_id_56BE);
  }
}

_id_AB76() {
  self._id_8C9B = 0;
  self._id_9A54 = 0;

  if(getdvarint("#x3c3ed409900cf4af", 1)) {
    _id_06CA::_id_8068();
  }

  thread _id_F42A();
  thread events_issupersprinting();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!scripts\mp\utility\game::_id_98D3()) {
      var_0._id_8D7E = [];
      var_0._id_8D78 = [];
    }

    var_0._id_8FFD = undefined;
    var_0._id_7120 = 0;
    var_0._id_C0F3 = 0;
    var_0._id_C0F1 = 0;
    var_0._id_C0EC = 0;
    var_0._id_9000 = 0;
    var_0._id_8FFB = 0;
    var_0._id_42F6 = [];
    var_0 _id_828C();
    var_0 _id_8225();
    var_0 initmonitorholdbreathtime();
    var_0 thread _id_A139();
    var_0._id_90C7 = 0;
    var_0 _id_829A();
  }
}

_id_42F5(var_0, var_1) {
  if(var_1 < 50 && var_1 > 10) {
    level thread scripts\mp\battlechatter_mp::_id_CB70(self, "plr_damaged_light", undefined, 0.1);
  } else {
    level thread scripts\mp\battlechatter_mp::_id_CB70(self, "plr_damaged_heavy", undefined, 0.1);
  }
}

_id_B823(var_0, var_1) {
  _id_0806::_id_B823(var_0, var_1);
}

_id_F42A() {
  level endon("game_ended");
  self endon("death");
  self endon(" disconnect");

  if(!isDefined(self.pers["timeNearAllies"]) || !isDefined(self.pers["timeNearEnemies"])) {
    self.pers["timeNearAllies"] = 0;
    self.pers["timeNearEnemies"] = 0;
  }

  for(;;) {
    wait 0.5;

    if(!isDefined(self)) {
      break;
    }

    if(!isDefined(level._id_EF6A[self.team])) {
      continue;
    }
    if(!isDefined(level._id_EF6A[self.team]["players"])) {
      continue;
    }
    foreach(var_1 in level._id_EF6A[self.team]["players"]) {
      if(var_1 == self) {
        continue;
      }
      if(distancesquared(self.origin, var_1.origin) < 90000) {
        self.pers["timeNearAllies"] = self.pers["timeNearAllies"] + 0.5;
        break;
      }
    }

    var_3 = scripts\mp\utility\game::_id_6BE2(self.team)[0];

    if(!isDefined(var_3) || !isDefined(level._id_EF6A[var_3])) {
      continue;
    }
    foreach(var_1 in level._id_EF6A[scripts\mp\utility\game::_id_6BE2(self.team)[0]]["players"]) {
      if(distancesquared(self.origin, var_1.origin) < 90000) {
        self.pers["timeNearEnemies"] = self.pers["timeNearEnemies"] + 0.5;
        break;
      }
    }
  }
}

_id_8D7D(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("killedPlayerNotify");
  self endon("killedPlayerNotify");

  if(!isDefined(self._id_8D9F)) {
    self._id_8D9F = 0;
  }

  self._id_8D9F++;

  if(weaponclass(var_2) == "spread") {
    if(!isDefined(self._id_DA59)) {
      self._id_DA59 = 1;
    } else {
      self._id_DA59++;

      if(self._id_DA59 >= 2) {
        _id_DA56(self._id_DA59);
      }
    }
  } else if(var_3 == "MOD_PISTOL_BULLET" || var_3 == "MOD_RIFLE_BULLET" || var_3 == "MOD_HEAD_SHOT") {
    if(!isDefined(self._id_2D30)) {
      self._id_2D30 = 1;
    } else {
      self._id_2D30++;

      if(self._id_2D30 >= 2) {
        _id_3A53(self._id_2D30);
      }
    }
  }

  waittillframeend;
  thread _id_A6A4(var_0, var_1, var_2, var_3, self._id_8D9F);
  self._id_8D9F = 0;
  self._id_2D30 = 0;
  self._id_DA59 = 0;
}

_id_A6A4(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getcompleteweaponname(var_2);

  for(var_6 = 0; var_6 < var_4; var_6++) {
    self notify("got_a_kill", var_1, var_5, var_3);
    waitframe();
  }
}

_id_8D7C(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = gettime();
  level._id_A78D++;

  if(level._id_9000 != var_6) {
    level._id_BC4A = level._id_9000;
    level._id_9000 = var_6;
  }

  self._id_9FFB = [];
  self._id_9FFB["mask"] = 0;
  self._id_9FFB["mask2"] = 0;
  var_7 = var_5._id_0354;
  var_8 = var_5._id_2C4B;
  _id_3526(var_2, var_3, var_4, var_1);
  var_9 = var_1.guid;
  var_10 = self.guid;
  var_11 = getcompleteweaponname(var_2);
  thread _id_8D7D(var_0, var_1, var_2, var_3);
  thread _id_FD09(self, var_0);
  self._id_BC4A = self._id_9000;
  self._id_9000 = var_6;
  self._id_8FFE = var_1;
  self._id_9001 = var_1.origin;

  if(self._id_0157 > 0) {
    var_12 = self._id_0267 / self._id_0157;

    if(var_12 > 3.0) {
      level thread scripts\mp\battlechatter_mp::_id_CB70(self, "plr_kd_high", undefined, 0.75);
    }
  } else if(self._id_0267 > 5)
    level thread scripts\mp\battlechatter_mp::_id_CB70(self, "plr_kd_high", undefined, 0.75);

  if(istrue(self._id_9075)) {
    scripts\mp\utility\stats::_id_7DAE("clutch", 1);
  }

  self._id_42F6[var_9] = undefined;
  var_13 = scripts\mp\utility\weapon::getweapongroup(var_2.basename);

  if(level.codcasterenabled) {
    var_14 = self.pers["cur_kill_streak"] + 1;

    if(!(var_14 % 5)) {
      scripts\mp\utility\game::_id_D5FA(13, self.team, self getentitynumber(), var_14);
    }
  }

  if(!scripts\mp\utility\weapon::_id_88F6(var_2.basename) && !scripts\mp\utility\perk::_hasperk("specialty_explosivebullets")) {
    if(level._id_BC4A == 0 && self._id_BC4A == 0) {
      _id_5BC4(var_0);
    }

    if(var_3 == "MOD_EXECUTION") {
      _id_56F2(var_0);
    } else if(isDefined(var_4.cratetype) && var_4.cratetype == "killstreak" && var_3 == "MOD_CRUSH") {
      thread _id_07BC::createkillstreakchallengeevent(self, var_4, var_1, var_2, "killed_with_killstreak_crush");
    } else if(var_2.basename == "none") {
      return 0;
    }

    if(isDefined(var_1._id_1DDC)) {
      var_15 = var_1._id_1DDC;
    } else {
      var_15 = self.origin;
    }

    var_16 = 1;

    if(isDefined(var_4)) {
      var_16 = var_4 == self;

      if(!var_16 && isDefined(var_4.weapon_name) && issubstr(var_4.weapon_name, "s4_la_")) {
        var_16 = 1;
      }
    }

    var_17 = anglesToForward(self getplayerangles());
    var_18 = var_1.origin - var_15;
    var_19 = vectornormalize(var_18);
    var_20 = vectordot(var_17, var_19);
    var_21 = scripts\engine\utility::_id_8794(var_3);

    if(var_1._id_1DDE.size == 1 && !isDefined(var_1._id_1DDE[var_1.guid])) {
      if(var_13 != "other" && var_13 != "weapon_projectile" && var_3 != "MOD_MELEE" && var_6 == var_1._id_1DD4[self.guid]._id_5BE2 && !scripts\mp\utility\weapon::isthrownaxeweapon(var_2, var_4) && !(isDefined(var_1.vehicle) && istrue(var_1.vehicle.killoccupants))) {
        self._id_9FFB["oneshotkill"] = 1;
        self._id_9FFB["mask"] = self._id_9FFB["mask"] | 1;
        thread _id_8D83("one_shot_kill", 1);
        thread _id_07B1::_id_6FB9("one_shot_kill");
        level thread scripts\mp\battlechatter_mp::_id_F759(self, "flavor_oneshotkill");
        scripts\mp\utility\stats::_id_7DAE("oneShotOneKills", 1);
      }
    }

    if(isDefined(self._id_8FF7) && self._id_8FF7 + 1000 > gettime()) {
      _id_DE52(var_0);
    }

    if(isDefined(var_1._id_8FF7) && var_1._id_8FF7 + 1000 > gettime()) {
      self._id_9FFB["victimInsmoke"] = 1;
    }

    if(scripts\mp\utility\game::_id_CA4B()) {
      if(scripts\cp_mp\utility\killstreak_utility::_id_EF78(var_1.team)) {
        _id_5414(var_0);
      }
    } else if(scripts\cp_mp\utility\killstreak_utility::_id_EF77(var_1.team))
      _id_5414(var_0);

    if(isDefined(var_1._id_EA8E) && var_1._id_EA8E == self) {
      _id_717B(var_0);
    }

    if(scripts\mp\utility\game::_id_8768(var_1)) {
      _id_1CE7(var_0);
    }

    if(scripts\mp\utility\game::_id_87F6(var_1)) {
      _id_461D(var_0);
    }

    if(var_3 == "MOD_MELEE") {
      if(var_13 != "weapon_melee" && var_13 != "weapon_melee2") {
        _id_72AA(var_0);
      }

      if(var_2.basename == "s4_me_fists_mp") {
        thread _id_8D83("fist_kill", 1);
        thread _id_07B1::_id_6FB9("fist_kill");
      }

      level thread scripts\mp\battlechatter_mp::_id_F759(self, "flavor_melee");
    }

    var_26 = var_1 getheldoffhand();

    if(var_26.basename == "s4_frag_usa_mk2_mp" || var_26.basename == "cluster_grenade_mp") {
      self._id_9FFB["cooking"] = 1;
      self._id_9FFB["mask"] = self._id_9FFB["mask"] | 2;
    }

    if(isDefined(self._id_1D2B) && self._id_1D2B) {
      _id_1D2B(var_0, var_2);
    }

    if(self.pers["cur_death_streak"] > 3) {
      _id_3AD3(var_0);
    }

    if(var_3 == "MOD_HEAD_SHOT") {
      if(scripts\mp\s4_quips_mp::triggerhasquip("quiptrigger_003")) {
        thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_003");
      } else {
        level thread scripts\mp\battlechatter_mp::_id_CB70(self, "plr_killfirm_headshot", undefined, 0.75);
        thread _id_07A9::logevent_votriggered(self, "quiptrigger_003", "none");
      }

      _id_7617(var_0);
    }

    if(isDefined(self._id_10A22) && self._id_10A22 && var_6 - self._id_E393 <= 5000) {
      self._id_9FFB["jackintheboxkill"] = 1;
    }

    if(!scripts\mp\utility\player::isreallyalive(self) && isDefined(self._id_441F)) {
      var_27 = gettime() - self._id_441F;

      if(var_27 < 1500 && var_27 > 0) {
        _id_BA43(var_0);
      }

      if(scripts\mp\utility\game::_id_8A37()) {
        if(var_27 == 0 && isDefined(self._id_026E) && self._id_026E == var_1) {
          thread _id_8D83("simultaneous_kill", 0);
          thread _id_07B1::_id_6FB9("simultaneous_kill", undefined, undefined, 1);
          var_1 thread _id_8D83("simultaneous_kill", 0);
          var_1 thread _id_07B1::_id_6FB9("simultaneous_kill", undefined, undefined, 1);
        }
      }
    }

    if(level.teambased && var_6 - var_1._id_9000 < 1500) {
      if(var_1._id_8FFE != self) {
        _id_1F98(var_0, var_1._id_8FFE);
      }
    }

    var_28 = undefined;

    if(var_1 _meth_86C8()) {
      var_29 = scripts\common\utility::_id_B7C7(var_1.origin, 300);

      foreach(var_31 in var_29) {
        if(var_31.team == self.team && var_31 _meth_86C9()) {
          var_28 = var_31.guid;
          _id_4619(var_0, var_31.guid);
          break;
        }
      }
    }

    foreach(var_35, var_34 in var_1._id_42F6) {
      if(var_35 == self.guid || var_35 == var_1.guid) {
        continue;
      }
      if(isDefined(var_28) && var_35 == var_28) {
        continue;
      }
      if(level.teambased && var_6 - var_34 < 1750) {
        _id_4619(var_0, var_35);
      }
    }

    if(var_16 || isDefined(var_4) && istrue(var_4._id_8835) && isDefined(var_4._id_5562) && var_4._id_5562 == "equip_throwing_knife" || isDefined(var_4) && isDefined(var_4._id_10D0C) && scripts\mp\utility\weapon::isthrownaxeweapon(var_4._id_10D0C, var_4)) {
      var_36 = _id_6D29(self, var_2, var_3, var_15, var_1);

      switch (var_36) {
        case "pointblank":
          thread _id_B9B4(var_0);
          break;
        case "closeRange":
          self._id_9FFB["closeRange"] = 1;
          break;
        case "longshot":
          thread _id_97CE(var_0);
          break;
        case "very_longshot":
          thread _id_97CE(var_0);
          thread _id_103AE(var_0);
          break;
      }
    }

    if(_id_8775(self, var_1, var_3)) {
      if(scripts\mp\utility\weapon::_id_8798(var_2.basename) || scripts\engine\utility::is_equal(var_2.basename, "s4_knifestab_mp")) {
        thread _id_8D83("backstab", 1);
        thread _id_07B1::_id_6FB9("backstab");
      }

      self._id_9FFB["backstab"] = 1;
      self._id_9FFB["mask"] = self._id_9FFB["mask"] | 4;
    }

    if(var_16) {
      switch (weaponclass(var_2.basename)) {
        case "rifle":
          scripts\mp\utility\stats::_id_7DAE("arKills", 1);
          var_1 scripts\mp\utility\stats::_id_7DAE("arDeaths", 1);

          if(var_3 == "MOD_HEAD_SHOT") {
            scripts\mp\utility\stats::_id_7DAE("arHeadshots", 1);
          }

          break;
        case "smg":
          scripts\mp\utility\stats::_id_7DAE("smgKills", 1);
          var_1 scripts\mp\utility\stats::_id_7DAE("smgDeaths", 1);

          if(var_3 == "MOD_HEAD_SHOT") {
            scripts\mp\utility\stats::_id_7DAE("smgHeadshots", 1);
          }

          break;
        case "spread":
          scripts\mp\utility\stats::_id_7DAE("shotgunKills", 1);
          var_1 scripts\mp\utility\stats::_id_7DAE("shotgunDeaths", 1);

          if(var_3 == "MOD_HEAD_SHOT") {
            scripts\mp\utility\stats::_id_7DAE("shotgunHeadshots", 1);
          }

          break;
        case "mg":
          scripts\mp\utility\stats::_id_7DAE("lmgKills", 1);
          var_1 scripts\mp\utility\stats::_id_7DAE("lmgDeaths", 1);

          if(var_3 == "MOD_HEAD_SHOT") {
            scripts\mp\utility\stats::_id_7DAE("lmgHeadshots", 1);
          }

          break;
        case "sniper":
          scripts\mp\utility\stats::_id_7DAE("sniperKills", 1);
          var_1 scripts\mp\utility\stats::_id_7DAE("sniperDeaths", 1);

          if(var_3 == "MOD_HEAD_SHOT") {
            scripts\mp\utility\stats::_id_7DAE("sniperHeadshots", 1);
          }

          break;
        case "rocketlauncher":
          scripts\mp\utility\stats::_id_7DAE("launcherKills", 1);
          var_1 scripts\mp\utility\stats::_id_7DAE("launcherDeaths", 1);

          if(var_3 == "MOD_HEAD_SHOT") {
            scripts\mp\utility\stats::_id_7DAE("launcherHeadshots", 1);
          }

          break;
        case "pistol":
          scripts\mp\utility\stats::_id_7DAE("pistolKills", 1);
          var_1 scripts\mp\utility\stats::_id_7DAE("pistolPeaths", 1);

          if(var_3 == "MOD_HEAD_SHOT") {
            scripts\mp\utility\stats::_id_7DAE("pistolHeadshots", 1);
          }

          break;
      }

      if(var_3 == "MOD_MELEE") {
        scripts\mp\utility\stats::_id_7DAE("meleeKills", 1);
        var_1 scripts\mp\utility\stats::_id_7DAE("meleeDeaths", 1);
      }

      if(isDefined(level._id_EB9A) && level._id_EB9A.size > 0) {
        foreach(var_38 in level._id_EB9A) {
          if(var_38.owner == self && var_38._id_786F == "radar_drone_overwatch") {
            var_38.owner scripts\mp\utility\stats::_id_7DAE("killstreakPersonalUAVKills", 1);
            break;
          }
        }
      }

      if(_id_8A83(self)) {
        thread _id_6FAA("low_health_kill", var_0, var_2, "low_health_kill");
        level thread scripts\mp\battlechatter_mp::_id_F759(self, "flavor_neardeathkill", undefined, 1);
      }

      if(scripts\mp\utility\player::_id_8989()) {
        self._id_9FFB["ads"] = 1;
        self._id_9FFB["mask"] = self._id_9FFB["mask"] | 8;
        scripts\mp\utility\stats::_id_7DAE("adsKills", 1);
      } else if(var_21) {
        self._id_9FFB["hipfire"] = 1;
        self._id_9FFB["mask"] = self._id_9FFB["mask"] | 16;
        scripts\mp\utility\stats::_id_7DAE("hipfireKills", 1);
      }

      if(!self isonground()) {
        self._id_9FFB["airborne"] = 1;
      }

      if(!var_1 isonground()) {
        self._id_9FFB["victim_airborne"] = 1;
      }

      if(self _meth_826F() >= 0.5) {
        self._id_9FFB["mounted"] = 1;
        self._id_9FFB["mask"] = self._id_9FFB["mask"] | 32;
      }

      if(isDefined(self.stimactiveevent) && self.stimactiveevent) {
        self._id_9FFB["recentstim"] = 1;
      }

      if(self _meth_8271() == "mount_top" || self _meth_8271() == "mount_left" || self _meth_8271() == "mount_right") {
        self._id_9FFB["blindfire"] = 1;
      }

      if(var_2 _meth_8624("akimbo", 1)) {
        self._id_9FFB["akimbo_kill"] = 1;
      }

      if(var_21) {
        self._id_9FFB["bullet_damage"] = 1;
        var_40 = self getweaponammoclip(var_2);

        if(var_40 <= 0) {
          self._id_9FFB["last_bullet_kill"] = 1;
          self._id_9FFB["mask"] = self._id_9FFB["mask"] | 64;
        }
      }

      if(var_1 issprinting()) {
        self._id_9FFB["victim_sprinting"] = 1;
        self._id_9FFB["mask"] = self._id_9FFB["mask"] | 128;
      }

      if(self issprinting()) {
        self._id_9FFB["sprinting"] = 1;
      }

      if(level.teambased) {
        foreach(var_31 in level.players) {
          if(self.team != var_31.team || self == var_31) {
            continue;
          }
          if(!scripts\mp\utility\player::isreallyalive(var_31)) {
            continue;
          }
          if(distancesquared(self.origin, var_31.origin) < 90000) {
            self._id_9FFB["buddy_kill"] = 1;
            break;
          }
        }
      }
    } else if(var_13 == "weapon_projectile") {
      if(isDefined(var_4) && isDefined(var_4._id_11B6)) {
        if(var_4._id_11B6) {
          self._id_9FFB["ads"] = 1;
          self._id_9FFB["mask"] = self._id_9FFB["mask"] | 8;
        } else {
          self._id_9FFB["hipfire"] = 1;
          self._id_9FFB["mask"] = self._id_9FFB["mask"] | 16;
        }
      }
    }

    if(!var_1 isonground() && !var_1 _meth_8498() && (!self isonground() && !self _meth_8498())) {
      if(var_16) {
        thread _id_6FAA("air_to_air_kill", var_0, var_2, "air_to_air_kill");
      }
    } else {
      if(var_16) {
        if(self _meth_8498()) {
          thread _id_6FAA("wallkill", var_0, var_2, "wallrun_kill");
        } else if(_id_87F0(self, var_2, var_3, var_15, var_1)) {
          thread _id_6FAA("jumpkill", var_0, var_2, "air_kill");
        } else if(_id_56BD()) {
          thread _id_6FAA("slidekill", var_0, var_2, "slide_kill");
          self._id_9FFB["sliding"] = 1;
          self._id_9FFB["mask"] = self._id_9FFB["mask"] | 256;
        }

        var_43 = self getstance();

        switch (var_43) {
          case "prone":
            self._id_9FFB["prone_kill"] = 1;
            self._id_9FFB["mask"] = self._id_9FFB["mask"] | 512;
            break;
          case "crouch":
            self._id_9FFB["crouch_kill"] = 1;
            self._id_9FFB["mask"] = self._id_9FFB["mask"] | 1024;
            break;
        }
      }

      if(var_1 _meth_8498()) {
        thread _id_6FAA("killonwall", var_0, var_2, "kill_wallrunner");
      } else if(_id_8A3A(self, var_2, var_3, var_15, var_1)) {
        thread _id_6FAA("killinair", var_0, var_2, "kill_jumper");
      }
    }

    if(var_16) {
      if(scripts\mp\weapons::_id_7166()) {
        self._id_9FFB["clutchkill"] = 1;
      }
    }

    if(isDefined(var_1._id_E9FF)) {
      foreach(var_45 in var_1._id_E9FF._id_EA14) {
        var_46 = var_45._id_41BD - var_1._id_EA13;

        if(var_46 > 0 && var_46 <= 1) {
          _id_2DE6(var_0, var_1);
          break;
        }
      }
    }

    if(var_16) {
      if(self _meth_81CE()) {
        thread _id_8D83("mantle_kill", 1);
        thread _id_07B1::_id_6FB9("mantle_kill");
      }

      if(scripts\mp\weapons::_id_8A6E()) {
        thread _id_8D83("stunned_kill", 1);
        thread _id_07B1::_id_6FB9("stunned_kill");
        _id_7D5A(var_0);
        level thread scripts\mp\battlechatter_mp::_id_F759(self, "flavor_impaired");
      }

      if(var_1 scripts\mp\weapons::_id_8A6E()) {
        self._id_9FFB["victim_stunned"] = 1;
      }

      if(isDefined(self._id_F33C[var_11]) && self._id_F33C[var_11] == var_1) {
        _id_2095(var_0);
      }
    }

    if(isDefined(var_1._id_EA8D)) {
      level thread scripts\mp\battlechatter_mp::_id_CB70(self, "plr_killfirm_semtex", undefined, 0.75);
    }

    if(scripts\mp\utility\weapon::_id_8A9F(var_2.basename) || scripts\mp\utility\weapon::isthrownaxeweapon(var_2, var_4)) {
      thread _id_8D83("throwingknife_kill", 1);
      thread _id_07B1::_id_6FB9("throwingknife_kill");
    }

    if(scripts\mp\gamescore::_id_87F4(self, var_1, "s4_decoy_grenade_mp")) {
      scripts\mp\rank::_id_CC00("baited_kill");
    }

    if(isDefined(level._id_4541) && level._id_4541.size != 0) {
      var_48 = 0;

      foreach(var_50 in level._id_4541) {
        if(var_50.owner == self) {
          var_48 = 1;
        }
      }

      if(var_48) {
        self._id_9FFB["decoy_active"] = 1;
      }
    }

    if(!scripts\mp\utility\game::_id_CA4B()) {
      if(level.teambased) {
        var_52 = 0;
        var_53 = scripts\mp\utility\teams::_id_69FD(self.team);

        foreach(var_55 in var_53) {
          if(var_55._id_038F > 0) {
            var_52 = 1;
            break;
          }
        }

        if(var_52) {
          if(_id_85B7(var_1, var_53)) {
            _id_8DFA(var_0);
          }
        }
      } else {
        var_52 = 0;

        foreach(var_55 in level.players) {
          if(var_55._id_038F > 0) {
            var_52 = 1;
            break;
          }
        }

        if(var_52) {
          if(_id_85B7(var_1, level.players)) {
            _id_8DFA(var_0);

            if(scripts\mp\utility\game::getgametype() == "gun" && var_3 == "MOD_MELEE") {
              thread _id_8D83("mode_gun_melee_1st_place", 1);
              thread _id_07B1::_id_6FB9("mode_gun_melee_1st_place");
            }
          }
        }
      }
    }

    if(self._id_038F < var_1._id_038F) {
      scripts\mp\utility\stats::_id_7DAE("higherRankedKills", 1);
    } else {
      scripts\mp\utility\stats::_id_7DAE("lowerRankedKills", 1);
    }

    var_14 = self.pers["cur_kill_streak"] + 1;
    thread _id_07BC::createplayeronkillstreakchallengeevent(self, var_4, var_1, var_2, var_14);
    var_59 = 5;

    if(level.gametype == "arm") {
      var_59 = 10;
    }

    if(!(var_14 % var_59)) {
      if(!isDefined(self._id_8FFF) || var_14 != self._id_8FFF) {
        thread scripts\mp\hud_util::_id_EF8D("callout_kill_streaking", self, undefined, var_14);
        self._id_8FFF = var_14;
      }

      if(var_14 <= 30) {
        thread _id_8D83("streak_" + var_14, 1);
        thread _id_07B1::_id_6FB9("streak_" + var_14);
        level thread scripts\mp\battlechatter_mp::_id_F759(self, "flavor_" + var_14 + "streak");
      }
    }

    if(var_14 > 30) {
      thread _id_8D83("streak_max", 1);
      thread _id_07B1::_id_6FB9("streak_max");
    }

    if(isDefined(var_4) && istrue(var_4._id_8835) && var_3 == "MOD_IMPACT" && !scripts\mp\utility\weapon::_id_8A9F(var_2.basename) && !scripts\mp\utility\weapon::isthrownaxeweapon(var_2, var_4)) {
      thread _id_07B1::_id_6FB9("item_impact");
      self._id_9FFB["item_impact"] = 1;
    }

    if(_id_0A8B::_id_8905(var_2, var_3)) {
      thread _id_8D83("launcher_direct_hit", 1);
      thread _id_07B1::_id_6FB9("launcher_direct_hit");
      self._id_9FFB["launcher_impact"] = 1;
    }

    if(scripts\mp\utility\game::_id_6A65() >= 1) {
      if(var_1.pers["lives"] == 0) {
        thread _id_07B1::_id_6FB9("mode_x_eliminate", undefined, undefined, undefined, undefined, var_1);
      }

      var_60 = scripts\mp\utility\game::_id_F744();

      if(isDefined(var_60) && var_60 == self) {
        thread _id_07B1::_id_6FB9("mode_x_last_alive", undefined, undefined, undefined, undefined, var_1);
      }
    }

    if(var_20 >= 0.6428) {
      self._id_9FFB["victim_in_standard_view"] = 1;
    }

    if(isDefined(self._id_8F84) && var_6 - self._id_8F84 <= 500) {
      self._id_9FFB["quickscope"] = 1;
      self._id_9FFB["mask"] = self._id_9FFB["mask"] | 2048;
    }

    if(isDefined(self.lastholdingbreathtime) && var_6 - self.lastholdingbreathtime <= 5) {
      self._id_9FFB["holdbreath"] = 1;
    }

    if(self.health <= 50) {
      self._id_9FFB["low_health_kill"] = 1;
      self._id_9FFB["mask"] = self._id_9FFB["mask"] | 4096;
    }

    if(isDefined(self._id_90C7) && var_6 - self._id_90C7 <= 2500) {
      self._id_9FFB["weapon_change_kill"] = 1;
      self._id_9FFB["mask"] = self._id_9FFB["mask"] | 8192;
    }

    if(isDefined(self._id_F33C[var_11]) && self._id_F33C[var_11].team != self.team) {
      self._id_9FFB["weapon_pickup_kill"] = 1;
      self._id_9FFB["mask"] = self._id_9FFB["mask"] | 16384;
    }

    if(isDefined(self._id_9038) && var_6 - self._id_9038 <= 5000) {
      self._id_9FFB["reload_kill"] = 1;
      self._id_9FFB["mask"] = self._id_9FFB["mask"] | 65536;
    }

    var_61 = self getvelocity();
    var_62 = self getvelocity()[0] >= 0.1 || self getvelocity()[0] <= -0.1;
    var_63 = self getvelocity()[1] >= 0.1 || self getvelocity()[1] <= -0.1;
    var_64 = self getvelocity()[2] >= 0.1 || self getvelocity()[2] <= -0.1;

    if(var_62 || var_63 || var_64) {
      self._id_9FFB["attacker_moving"] = 1;
    }

    if(istrue(var_1._id_87F7)) {
      self._id_9FFB["killed_defuser"] = 1;
    }

    if(istrue(var_1._id_8986)) {
      self._id_9FFB["killed_planter"] = 1;
    }

    if(scripts\mp\utility\weapon::_id_879C(var_2) || scripts\mp\utility\perk::_hasperk("specialty_munitions_2") && isDefined(self.secondaryweaponobj) && var_2 == self.secondaryweaponobj) {
      self._id_9FFB["secondary_weapon"] = 1;
      self._id_9FFB["mask"] = self._id_9FFB["mask"] | 131072;
    }

    if(scripts\mp\utility\player::_id_88C8(self)) {
      self._id_9FFB["last_stand"] = 1;
      self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 1024;
    }

    if(scripts\mp\utility\player::_id_88C8(var_1) || istrue(var_8)) {
      self._id_9FFB["victim_last_stand"] = 1;
      self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 2048;
    }

    if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
      self._id_9FFB["in_vehicle"] = 1;
      self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 4096;

      if(var_3 == "MOD_CRUSH") {
        level thread scripts\mp\battlechatter_mp::_id_F759(self, "flavor_roadkill");
      }
    }

    if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      self._id_9FFB["victim_in_vehicle"] = 1;
      self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 8192;
    }

    if(isDefined(var_4) && isDefined(var_4._id_5562)) {
      if(var_4._id_5562 == "equip_c4" || var_4._id_5562 == "equip_claymore") {
        var_65 = var_4 _meth_8151();

        if(isDefined(var_65) && isDefined(var_65._id_786F) && var_65._id_786F == "radar_drone_recon") {
          self._id_9FFB["recon_drone_explosive"] = 1;
          self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 32768;
        } else if(isDefined(var_65) && var_65 scripts\cp_mp\vehicles\vehicle::_id_8AF5()) {
          self._id_9FFB["vehicle_explosive"] = 1;
          self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 65536;
        }
      }
    }

    _id_3563(var_1, var_4, var_2, var_3, var_11);
    _id_3564(var_1, var_2, var_3);
  }

  thread _id_FD0E(var_0, var_1, var_2, var_11, var_4);

  if(isDefined(self._id_8FFD) && self._id_8FFD == var_1) {
    self._id_8FFD = undefined;
    _id_C7B3(var_0, var_1);
  }

  if(isDefined(var_2.basename) && var_2.basename == "s4_ks_tw_ball_turret_gunner_mp") {
    self._id_9FFB["ballTurretGunner_kill"] = 1;
  }

  if(!scripts\mp\utility\game::_id_98D3()) {
    if(!isDefined(self._id_8D7E[var_9])) {
      self._id_8D7E[var_9] = 0;
    }

    if(!isDefined(var_1._id_8D78[var_10])) {
      var_1._id_8D78[var_10] = 0;
    }

    self._id_8D7E[var_9]++;
    var_1._id_8D78[var_10]++;
  }

  if(isDefined(var_5._id_7C97) && var_5._id_7C97 &level._id_7CA1) {
    self._id_9FFB["bulletpen"] = 1;
  }

  var_1._id_8FFD = self;

  if(istrue(var_1._id_88DF)) {
    level thread scripts\mp\battlechatter_mp::_id_F759(self, "flamethrower_ekia");
  }

  if(!scripts\mp\utility\game::_id_98D3() && !level._id_A2FC) {
    var_66 = 0;

    if(level.teambased) {
      var_66 = scripts\mp\utility\teams::_id_69FB(self.team);
    } else {
      var_66 = level.players.size - 1;
    }

    if(var_66 > 3 && self._id_8D7E.size == var_66) {
      var_67 = 0;

      if(isDefined(self.pers["killEnemyTeam"])) {
        var_67 = self.pers["killEnemyTeam"];
      }

      var_68 = 1;

      foreach(var_31, var_70 in self._id_8D7E) {
        if(var_70 <= var_67) {
          var_68 = 0;
          break;
        }
      }

      if(var_68) {
        _id_8D81(var_0);
      }
    }
  }

  var_71 = _id_6B74();

  if(var_71.size > 0) {
    foreach(var_35 in var_71) {
      if(var_9 == var_35) {
        _id_8D8C(var_0);
        break;
      }
    }
  }

  if(!var_1 scripts\mp\utility\player::_id_8ACE() && (!var_1 scripts\mp\utility\perk::_hasperk("specialty_survivor") || istrue(var_1.inlaststand))) {
    var_1 thread scripts\mp\utility\player::_id_D523();
  }

  scripts\mp\utility\script::_id_2C9F("kill_event_buffered", var_1, var_11, var_3, self._id_9FFB);
  thread _id_0806::_id_AB70(self, var_4, var_1, var_3, var_2, var_7);
  var_1 thread _id_07BC::_id_AB70(var_4, self, var_3, var_2, self._id_9FFB);
  var_1.lifecycle_modifiers = [];
}

_id_3526(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\utility\weapon::_id_88F6(var_0.basename) || scripts\mp\utility\weapon::_id_88F4(var_2);
  var_5 = _id_0A9F::_id_8868(var_0);

  if(var_4 && !var_5) {
    if(isDefined(var_0.basename) && var_0.basename == "s4_ks_tw_ball_turret_gunner_mp") {
      var_2.streakinfo = self.streakinfo;
    }

    if(isDefined(var_2) && isDefined(var_2.streakinfo)) {
      var_6 = 1;

      if(isDefined(var_2.streakinfo._id_A2B6)) {
        var_7 = var_2.streakinfo._id_A2B6._id_EA0F;
        var_8 = self._id_936C;

        if(!isDefined(var_7) || var_7 != var_8) {
          var_6 = 0;
        }

        if(var_2.streakinfo._id_A2B6._id_ADB5 != self getxuid()) {
          var_6 = 0;
        }
      }

      if(isDefined(var_2.streakinfo.streakname)) {
        var_9 = 0;
        var_10 = 0;
        var_11 = 0;
        var_12 = var_2.streakinfo.streakname;

        switch (var_12) {
          case "bradley":
            scripts\mp\utility\stats::_id_7DAE("killstreakTankKills", 1);
            var_9 = 1;
            var_11 = 1;
            break;
          case "chopper_gunner":
            scripts\mp\utility\stats::_id_7DAE("killstreakChopperGunnerKills", 1);
            var_9 = 1;
            var_10 = 1;
            break;
          case "chopper_support":
            scripts\mp\utility\stats::_id_7DAE("killstreakChopperSupportKills", 1);
            var_9 = 1;
            var_10 = 1;
            break;
          case "cruise_predator":
            scripts\mp\utility\stats::_id_7DAE("killstreakCruiseMissileKills", 1);
            var_9 = 1;
            var_10 = 1;
            break;
          case "fuel_airstrike":
            var_9 = 1;
            break;
          case "ball_turret_gunner":
            scripts\mp\utility\stats::_id_7DAE("killstreakGunshipKills", 1);
            var_9 = 1;
            var_10 = 1;
            break;
          case "hover_jet":
            scripts\mp\utility\stats::_id_7DAE("killstreakVTOLJetKills", 1);
            var_9 = 1;
            var_10 = 1;
            break;
          case "juggernaut":
            scripts\mp\utility\stats::_id_7DAE("killstreakJuggernautKills", 1);
            var_9 = 1;
            var_11 = 1;
            break;
          case "manual_turret":
            scripts\mp\utility\stats::_id_7DAE("killstreakShieldTurretKills", 1);
            var_9 = 1;
            var_11 = 1;
            break;
          case "multi_airstrike":
            var_9 = 1;
            break;
          case "pac_sentry":
            scripts\mp\utility\stats::_id_7DAE("killstreakWheelsonKills", 1);
            var_9 = 1;
            var_11 = 1;
            break;
          case "precision_airstrike":
            scripts\mp\utility\stats::_id_7DAE("killstreakAirstrikeKills", 1);
            var_9 = 1;
            var_10 = 1;
            break;
          case "sentry_gun":
            scripts\mp\utility\stats::_id_7DAE("killstreakSentryGunKills", 1);
            var_9 = 1;
            var_11 = 1;
            break;
          case "toma_strike":
            scripts\mp\utility\stats::_id_7DAE("killstreakCluserStrikeKills", 1);
            var_9 = 1;
            var_10 = 1;
            break;
          case "white_phosphorus":
            scripts\mp\utility\stats::_id_7DAE("killstreakWhitePhosphorousKillsAssists", 1);
            var_9 = 1;
            var_10 = 1;
            break;
          case "glide_bomb":
            scripts\mp\utility\stats::_id_7DAE("killstreakGlideBombKills", 1);
            var_9 = 1;
            var_10 = 1;
            break;
          case "lmg_streak":
            scripts\mp\utility\stats::_id_7DAE("killstreakExplosiveLmgKills", 1);
            var_9 = 1;
            var_11 = 1;
            break;
          case "mortar_barrage":
            scripts\mp\utility\stats::_id_7DAE("killstreakMortarBarrageKills", 1);
            var_9 = 1;
            var_11 = 1;
            break;
          case "warmachine":
            scripts\mp\utility\stats::_id_7DAE("killstreakWarmachineKills", 1);
            var_9 = 1;
            var_11 = 1;
            break;
          case "guard_dog":
            scripts\mp\utility\stats::_id_7DAE("killstreakGuardDogKills", 1);
            var_9 = 1;
            var_11 = 1;

            if(isDefined(self._id_C0F4) && isDefined(self._id_C0F4["s4_ks_dog_bite_mp"])) {
              break;
            }

            if(scripts\engine\utility::_id_1BA1(var_3._id_42F6, self.guid) && gettime() - var_3._id_42F6[self.guid] < 1750) {
              level thread scripts\mp\battlechatter_mp::_id_F759(self, "gdog_savior");
            } else {
              level thread scripts\mp\battlechatter_mp::_id_F759(self, "gdog_kill");
            }

            break;
          case "attack_dogs":
            scripts\mp\utility\stats::_id_7DAE("killstreakAttackDogKills", 1);
            var_9 = 1;
            var_11 = 1;

            if(isDefined(self._id_C0F4) && isDefined(self._id_C0F4["s4_ks_dog_bite_mp"])) {
              break;
            }

            level thread scripts\mp\battlechatter_mp::_id_F759(self, "adog_kill");
            break;
          default:
            thread _id_0A9F::_id_7003("killstreak_full_score", var_0);
            break;
        }

        if(isDefined(var_2.streakinfo._id_0267)) {
          var_2.streakinfo._id_0267++;
        }

        scripts\mp\utility\stats::_id_7DAE("killstreakKills", 1);

        if(var_10) {
          scripts\mp\utility\stats::_id_7DAE("killstreakAirKills", 1);
        }

        if(var_11) {
          scripts\mp\utility\stats::_id_7DAE("killstreakGroundKills", 1);
        }

        self notify("killstreak_kill", var_12);

        if(var_9) {
          var_13 = "ss_kill_" + var_12;
          var_14 = undefined;

          if(var_6 && scripts\mp\utility\perk::_hasperk("specialty_chain_killstreaks")) {
            var_15 = level._id_1FCC[var_13]._id_10FDA;
            var_14 = scripts\mp\rank::getscoreinfovalue(var_15);
          }

          var_16 = 1;
          thread _id_07B1::_id_6FB9(var_13, var_14, undefined, undefined, var_16, undefined, var_6, var_2);
        }

        level thread scripts\mp\battlechatter_mp::_id_CB70(self, "plr_killfirm_killstreak", undefined, 0.75);
      }
    }
  }
}

_id_3563(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\supers::_id_8A79();
  var_6 = scripts\mp\supers::_id_69B0();
  var_7 = scripts\mp\supers::getcurrentsuper();
  var_8 = scripts\mp\utility\weapon::_id_8A7D(var_2.basename);
  var_9 = undefined;

  if(!isDefined(var_6)) {
    return;
  }
  if(var_8) {
    thread _id_8D7F(var_0, var_1, var_2, var_3, var_4);

    if(var_3 != "MOD_MELEE") {
      scripts\mp\utility\script::_id_2C9F("super_kill_buffered");
    }
  }

  var_10 = 0;

  if(isDefined(var_6)) {
    switch (var_6) {
      default:
        break;
    }

    if(var_10) {
      thread _id_EB34(var_6, var_3);
      scripts\mp\supers::_id_3AC0(var_6);

      if(isDefined(var_9)) {
        thread _id_0A9F::_id_7003(var_9);
      }

      scripts\mp\utility\script::_id_2C9F("super_kill_buffered");
    }
  }
}

_id_3564(var_0, var_1, var_2) {
  var_3 = var_0 scripts\mp\supers::_id_8A79();
  var_4 = var_0 scripts\mp\supers::_id_69B0();
  var_5 = var_0 scripts\mp\supers::getcurrentsuper();

  if(!isDefined(var_4)) {
    return;
  }
  switch (var_4) {
    default:
      if(var_3 == 1) {
        thread _id_EB45(var_0);
      }

      break;
  }
}

_id_8D7F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\supers::_id_6DA7(var_2);
  var_6 = undefined;

  if(isDefined(self._id_C0F4)) {
    var_6 = self._id_C0F4[var_4];
  }

  if(isDefined(var_6) && var_6 > 0 && var_6 % 2 == 0) {
    _id_EB34(var_5, var_3);
  } else {
    var_7 = scripts\mp\supers::getcurrentsuper();
    var_7._id_A78D++;
  }

  _id_07BC::_id_FD4D(var_2, var_1);
  scripts\mp\supers::_id_3AC0(var_5);
}

_id_EB34(var_0, var_1) {
  var_2 = scripts\mp\supers::_id_6CFD(var_0);
  var_3 = "super_kill_" + var_2;

  switch (var_3) {
    case "super_kill_chargemode":
      var_3 = "super_kill_bull_charge";
      break;
  }

  if(isDefined(level._id_1FCC[var_3])) {
    thread _id_07B1::_id_6FB9(var_3);
  }

  var_4 = scripts\mp\supers::getcurrentsuper();
  var_4._id_A78D++;
  _id_07BC::_id_FD49(var_0, var_1, var_4._id_A78D);
  self._id_9FFB["super_kill_medal"] = var_0;
}

_id_8D7B(var_0, var_1, var_2) {
  if(var_0 == "attack_dog") {
    var_0 = "attack_dogs";
  }

  var_3 = "kill_ss_" + var_0;

  if(isDefined(var_2) && weaponclass(var_2) != "rocketlauncher") {
    var_2 = undefined;
  }

  var_1 thread _id_8D83(var_3, 1);
  var_1 thread _id_07B1::_id_6FB9(var_3, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_2);
  var_1 scripts\mp\utility\stats::_id_7DAE("destroyedKillstreaks", 1);
  level thread scripts\mp\battlechatter_mp::_id_CB70(var_1, "plr_killstreak_destroy", undefined, 0.75);
}

_id_BD7D(var_0) {
  var_1 = scripts\mp\killstreaks\killstreaks::_id_6D13(var_0);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_3 thread _id_0A9F::_id_700C("scrap_assist");
  }
}

_id_85B7(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(var_3._id_038F > var_0._id_038F) {
      return 0;
    }
  }

  return 1;
}

_id_6D29(var_0, var_1, var_2, var_3, var_4) {
  if(isalive(var_0) && !var_0 scripts\mp\utility\player::_id_8ACE() && (var_2 == "MOD_RIFLE_BULLET" || var_2 == "MOD_PISTOL_BULLET" || var_2 == "MOD_HEAD_SHOT" || var_2 == "MOD_IMPACT" || var_2 == "MOD_GRENADE_SPLASH" || var_2 == "MOD_GRENADE" || var_2 == "MOD_PROJECTILE" || var_2 == "MOD_PROJECTILE_SPLASH" || var_2 == "MOD_FIRE") && !scripts\mp\utility\weapon::_id_88F6(var_1.basename) && !istrue(var_0._id_1D2B)) {
    var_5 = distancesquared(var_3, var_4.origin);

    if(var_5 < 9216) {
      return "pointblank";
    }

    if(var_5 > 4000000) {
      return "very_longshot";
    }

    if(var_5 < 250000) {
      return "closeRange";
    }

    var_6 = scripts\mp\utility\weapon::getweapongroup(var_1.basename);
    var_7 = undefined;

    switch (var_6) {
      case "weapon_melee2":
      case "weapon_pistol":
      case "other":
        var_7 = 800;
        break;
      case "weapon_beam":
      case "weapon_smg":
        var_7 = 1200;
        break;
      case "weapon_lmg":
      case "weapon_dmr":
      case "weapon_assault":
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
        var_7 = 800;
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

_id_87F0(var_0, var_1, var_2, var_3, var_4) {
  if(isalive(var_0) && var_0 _meth_846A() && scripts\engine\utility::_id_8794(var_2)) {
    var_5 = var_0.origin[2] - var_4.origin[2];
    return var_5 > 60;
  }

  return 0;
}

_id_8A3A(var_0, var_1, var_2, var_3, var_4) {
  return isalive(var_0) && var_4 _meth_846A() && scripts\engine\utility::_id_8794(var_2);
}

_id_8775(var_0, var_1, var_2) {
  if(!isPlayer(var_0) || !isPlayer(var_1)) {
    return 0;
  }

  if(var_2 != "MOD_RIFLE_BULLET" && var_2 != "MOD_PISTOL_BULLET" && var_2 != "MOD_MELEE" && var_2 != "MOD_HEAD_SHOT") {
    return 0;
  }

  var_3 = var_1 getplayerangles();
  var_4 = var_0 getplayerangles();
  var_5 = _func_000B(var_3[1] - var_4[1]);

  if(abs(var_5) < 80) {
    return 1;
  }

  return 0;
}

_id_8A83(var_0) {
  return var_0.health > 0 && var_0.health < var_0.maxhealth * 0.2;
}

_id_6FAA(var_0, var_1, var_2, var_3) {
  self._id_9FFB[var_0] = 1;

  if(isDefined(var_3)) {
    thread _id_07B1::_id_6FB9(var_3);
  } else {
    thread _id_0A9F::_id_7003(var_0, var_2);
  }
}

_id_BDD5(var_0) {
  self._id_9FFB["proximityAssist"] = 1;
  thread _id_0A9F::_id_7003("proximityassist");
}

_id_BDD7(var_0) {
  self._id_9FFB["proximityKill"] = 1;
  thread _id_0A9F::_id_7003("proximitykill");
}

_id_97CE(var_0) {
  self._id_9FFB["longshot"] = 1;
  self._id_9FFB["mask"] = self._id_9FFB["mask"] | 262144;
  scripts\mp\utility\stats::_id_7DAE("longshotKills", 1);
  thread _id_8D83("longshot", 1);
  thread _id_07B1::_id_6FB9("longshot");

  if(self._id_0133 _meth_8624("gunperk_acquisition")) {
    thread _id_0A6B::_id_D45C();
  }
}

_id_103AE(var_0) {
  self._id_9FFB["very_longshot"] = 1;
  level thread scripts\mp\battlechatter_mp::_id_F759(self, "flavor_headshotlong", undefined, 1);
}

_id_B9B4(var_0) {
  self._id_9FFB["pointblank"] = 1;
  self._id_9FFB["mask"] = self._id_9FFB["mask"] | 524288;
  thread _id_8D83("pointblank", 1);
  thread _id_07B1::_id_6FB9("pointblank");
  scripts\mp\utility\stats::_id_7DAE("pointBlankKills", 1);
  level thread scripts\mp\battlechatter_mp::_id_F759(self, "flavor_pointblank");
}

_id_7617(var_0) {
  self._id_9FFB["headshot"] = 1;
  self._id_9FFB["mask"] = self._id_9FFB["mask"] | 1048576;
  thread _id_8D83("headshot", 1);
  thread _id_07B1::_id_6FB9("headshot");
}

_id_1F98(var_0, var_1) {
  self._id_9FFB["avenger"] = 1;
  self._id_9FFB["mask"] = self._id_9FFB["mask"] | 2097152;
  scripts\mp\utility\stats::_id_7DAE("avengerKills", 1);
  thread _id_8D83("avenger", 1);
  thread _id_07B1::_id_6FB9("avenger");
}

_id_1D2B(var_0, var_1) {
  self._id_9FFB["assistedsuicide"] = 1;
  thread _id_0A9F::_id_7003("assistedsuicide", var_1);
  thread _id_8D83("assistedsuicide", 1);
  thread _id_07B1::_id_6FB9("assistedsuicide");
}

_id_4619(var_0, var_1) {
  scripts\mp\utility\stats::_id_7DAE("defenderKills", 1);
  self._id_9FFB["savior"] = 1;
  var_2 = scripts\mp\utility\player::_id_6C4D(var_1);
  var_3 = "save_teammate";
  thread _id_8D83(var_3, 1);
  thread _id_07B1::_id_6FB9(var_3);

  if(scripts\mp\s4_quips_mp::triggerhasquip("quiptrigger_008")) {
    thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_008");
  } else {
    level thread scripts\mp\battlechatter_mp::_id_F759(self, "flavor_save", undefined, 1);
    thread _id_07A9::logevent_votriggered(self, "quiptrigger_008", "none");
  }

  if(isDefined(var_2)) {
    var_2 thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_009");
  }
}

_id_BA43(var_0) {
  self._id_9FFB["posthumous"] = 1;
  self._id_9FFB["mask"] = self._id_9FFB["mask"] | 8388608;
  thread _id_8D83("posthumous", 1);
  thread _id_07B1::_id_6FB9("posthumous");
}

_id_C7B3(var_0, var_1) {
  self._id_9FFB["revenge"] = 1;
  self._id_9FFB["mask"] = self._id_9FFB["mask"] | 16777216;
  scripts\mp\utility\stats::_id_7DAE("revengeKills", 1);
  thread _id_8D83("revenge", 1);
  thread _id_07B1::_id_6FB9("revenge");
  level thread scripts\mp\battlechatter_mp::_id_F759(self, "flavor_revenge", undefined, 1);
}

_id_A2F8(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(self._id_41D6)) {
    self._id_41D6 = var_1;
  }

  if(var_1 < self._id_41D6) {
    return;
  }
  self notify("multiKill");
  self endon("multiKill");
  waitframe();
  var_5 = undefined;
  var_6 = undefined;

  switch (var_1) {
    case 2:
      var_5 = "double";

      if(!istrue(var_3)) {
        level thread scripts\mp\battlechatter_mp::_id_F759(self, "flavor_multi2");
      }

      break;
    case 3:
      var_5 = "triple";
      var_6 = "callout_3xkill";
      break;
    case 4:
      var_5 = "four";
      var_6 = "callout_4xkill";

      if(!istrue(var_3)) {
        level thread scripts\mp\battlechatter_mp::_id_F759(self, "flavor_multi4");
      }

      break;
    case 5:
      var_5 = "five";
      var_6 = "callout_5xkill";
      break;
    case 6:
      var_5 = "six";
      var_6 = "callout_6xkill";

      if(!istrue(var_3)) {
        level thread scripts\mp\battlechatter_mp::_id_F759(self, "flavor_multi6");
      }

      break;
    case 7:
      var_5 = "seven";
      var_6 = "callout_7xkill";
      break;
    case 8:
      var_5 = "eight";
      var_6 = "callout_8xkill";
      break;
    default:
      var_5 = "multi";
      var_6 = "callout_9xkill";
      break;
  }

  var_7 = undefined;

  if(!istrue(var_3)) {
    if(isDefined(var_4) && scripts\engine\utility::is_equal(var_4.basename, "pac_sentry_turret_mp") && isDefined(self._id_C0F4["pac_sentry_turret_mp"])) {
      switch (self._id_C0F4["pac_sentry_turret_mp"]) {
        case 1:
          break;
        case 3:
        case 2:
          var_7 = "goliath_kill_" + self._id_C0F4["pac_sentry_turret_mp"];
          break;
      }

      if(self._id_C0F4["pac_sentry_turret_mp"] > 3) {
        var_7 = "goliath_kill_3";
      }
    }
  }

  if(istrue(var_3)) {
    if(scripts\mp\s4_quips_mp::triggerhasquip("quiptrigger_002")) {
      thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_002");
    } else {
      thread _id_07A9::logevent_votriggered(self, "quiptrigger_002", "none");

      if(isDefined(var_4) && scripts\engine\utility::is_equal(var_4.basename, "s4_ks_dog_bite_mp")) {
        level thread scripts\mp\battlechatter_mp::_id_F759(self, "gdog_multikill");
      }
    }
  }

  if(isDefined(self.pers["totalMultikills"])) {
    scripts\mp\utility\stats::_id_7DAE("totalMultikills", 1);
  }

  if(isDefined(self.pers["highestMultikill"]) && var_1 > self.pers["highestMultikill"]) {
    self.pers["highestMultikill"] = var_1;
  }

  if(isDefined(var_5)) {
    thread _id_8D83(var_5, scripts\engine\utility::ter_op(isDefined(var_2), var_2, 1), istrue(var_3), var_7);

    if(!istrue(var_3)) {
      thread _id_07B1::_id_6FB9(var_5);
    }
  }

  if(isDefined(var_6)) {
    thread scripts\mp\hud_util::_id_EF8D(var_6, self);
  }
}

_id_5BC4(var_0) {
  scripts\mp\utility\game::_id_D5FA(11, self.team, self getentitynumber());
  self._id_9FFB["firstblood"] = 1;
  self._id_9FFB["mask"] = self._id_9FFB["mask"] | 33554432;
  thread scripts\mp\hud_util::_id_EF8D("callout_firstblood", self);
  thread _id_8D83("firstblood", 1);
  thread _id_07B1::_id_6FB9("firstblood");
  level thread scripts\mp\battlechatter_mp::_id_F759(self, "flavor_firstblood");
}

_id_10E5F(var_0) {}

_id_2DE6(var_0, var_1) {
  self._id_9FFB["buzzkill"] = var_1.pers["cur_kill_streak"];
  self._id_9FFB["mask"] = self._id_9FFB["mask"] | 67108864;
  thread _id_8D83("buzzkill", 1);
  thread _id_07B1::_id_6FB9("buzzkill");
}

_id_3AD3(var_0) {
  self._id_9FFB["comeback"] = 1;
  self._id_9FFB["mask"] = self._id_9FFB["mask"] | 134217728;
  thread _id_8D83("comeback", 1);
  thread _id_07B1::_id_6FB9("comeback");
  level thread scripts\mp\battlechatter_mp::_id_F759(self, "flavor_comeback");
  scripts\mp\utility\stats::_id_7DAE("comebackKills", 1);
}

_id_EB45(var_0) {
  var_1 = scripts\mp\supers::_id_6CFD(var_0._id_EB09._id_E76B._id_C189);
  self._id_9FFB["superShutdown"] = var_0._id_EB09._id_E76B._id_C189;
  var_2 = "super_shutdown_" + var_1;

  switch (var_1) {
    case "chargemode":
      var_2 = "super_shutdown_bull_charge";
      break;
  }

  if(isDefined(level._id_1FCC[var_2])) {
    thread _id_07B1::_id_6FB9(var_2);
  }
}

_id_3A53(var_0) {
  if(var_0 == 2) {
    level thread scripts\mp\battlechatter_mp::_id_CB70(self, "plr_killfirm_twofer", undefined, 0.75);
    thread _id_8D83("one_shot_two_kills", 1);
    thread _id_07B1::_id_6FB9("one_shot_two_kills");
  }

  if(var_0 == 3) {
    level thread scripts\mp\battlechatter_mp::_id_CB70(self, "plr_killfirm_threefer", undefined, 0.75);
  }

  if(var_0 > 1) {
    self._id_9FFB["collateral"] = 1;
  }

  thread _id_0806::_id_3A53(self, var_0);
}

_id_DA56(var_0) {
  thread _id_0806::_id_DA56(self, var_0);
}

_id_2095(var_0) {
  self._id_9FFB["backfire"] = 1;
  self._id_9FFB["mask"] = self._id_9FFB["mask"] | 32768;
  thread _id_8D83("backfire", 1);
  thread _id_07B1::_id_6FB9("backfire");
}

_id_BE93(var_0, var_1) {
  self._id_9FFB["quadfeed"] = 1;
  self._id_9FFB["mask"] = self._id_9FFB["mask"] | 536870912;
  thread _id_8D83("quad_feed", 1);
  thread _id_07B1::_id_6FB9("quad_feed");
  thread _id_0806::_id_BE93(self, var_1._id_E72D, gettime());
}

_id_1CE7(var_0) {
  self._id_9FFB["assault"] = 1;
  self._id_9FFB["mask"] = self._id_9FFB["mask"] | 1073741824;
}

_id_461D(var_0) {
  self._id_9FFB["defender"] = 1;
  self._id_9FFB["mask"] = self._id_9FFB["mask"] | 4194304;
}

_id_DE52(var_0) {
  self._id_9FFB["attackerInsmoke"] = 1;
  self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 512;
}

_id_5414(var_0) {
  self._id_9FFB["enemyHasUAV"] = 1;
  self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 1;
}

_id_8D81(var_0) {
  self._id_9FFB["killEnemyTeam"] = 1;
  self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 2;
  scripts\mp\utility\stats::_id_7DAE("killEnemyTeam", 1);
}

_id_8D8C(var_0) {
  self._id_9FFB["killedNemesis"] = 1;
  self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 16;
}

_id_8DFA(var_0) {
  self._id_9FFB["kingslayer"] = 1;
  self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 4;
  thread _id_8D83("first_place_kill", 1);
  thread _id_07B1::_id_6FB9("first_place_kill");
  scripts\mp\utility\stats::_id_7DAE("highestRankedKills", 1);
}

_id_717B(var_0) {
  self._id_9FFB["grenadestuck"] = 1;
  self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 8;
}

_id_7D5A(var_0) {
  self._id_9FFB["impaired"] = 1;
  self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 64;
}

_id_72AA(var_0) {
  self._id_9FFB["gunbutt"] = 1;
  self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 128;
  thread _id_8D83("gun_butt", 1);
  thread _id_07B1::_id_6FB9("gun_butt");
}

_id_F645(var_0) {
  self._id_9FFB["tripledefenderkill"] = 1;
  self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 32;
}

_id_56F2(var_0) {
  self._id_9FFB["execution"] = 1;
  self._id_9FFB["mask2"] = self._id_9FFB["mask2"] | 256;
  scripts\mp\utility\stats::_id_7DAE("executions", 1);
  thread _id_0A9F::_id_7003("execution");
}

_id_4B17() {
  var_0 = self.guid;

  if(!scripts\mp\utility\game::_id_98D3()) {
    for(var_1 = 0; var_1 < level.players.size; var_1++) {
      if(isDefined(level.players[var_1]._id_8D7E[var_0])) {
        level.players[var_1]._id_8D7E[var_0] = undefined;
      }

      if(isDefined(level.players[var_1]._id_8D78[var_0])) {
        level.players[var_1]._id_8D78[var_0] = undefined;
      }
    }
  }
}

_id_A116() {
  level endon("end_game");

  for(;;) {
    level waittill("healed", var_0);
    var_0 thread _id_0A9F::_id_7003("healed");
  }
}

updaterecentkillmodifier(var_0) {
  if(!isDefined(self._id_9FFB)) {
    return;
  }
  if(!isDefined(self.recentkill_modifiers)) {
    self.recentkill_modifiers = [];
  }

  if(isDefined(self._id_9FFB[var_0]) && self._id_9FFB[var_0]) {
    if(isDefined(self.recentkill_modifiers[var_0]) && self.recentkill_modifiers[var_0] && self._id_C0F3 > 1) {
      self.multikill_modifiers[var_0] = 1;
    }

    self.recentkill_modifiers[var_0] = 1;
  } else
    self.recentkill_modifiers[var_0] = undefined;
}

_id_FD0E(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");
  self._id_C0F3++;
  thread updaterecentkillmodifier("mounted");
  thread updaterecentkillmodifier("hipfire");

  if(scripts\mp\utility\game::_id_87F6(var_1)) {
    self._id_C0F1++;

    if(scripts\mp\utility\script::_id_8956(self._id_C0F1, 2)) {
      thread _id_07B1::_id_6FB9("mode_x_wipeout");
    }
  }

  if(scripts\mp\utility\game::_id_8768(var_1)) {
    self._id_C0EC++;

    if(scripts\mp\utility\script::_id_8956(self._id_C0EC, 3)) {
      _id_F645(var_0);
    }
  }

  if(!isDefined(self._id_C0F4)) {
    self._id_C0F4 = [];
  }

  if(!isDefined(self._id_C0F4[var_3])) {
    self._id_C0F4[var_3] = 1;
  } else {
    self._id_C0F4[var_3]++;
  }

  var_5 = scripts\mp\utility\weapon::_id_6A18(var_2.basename);

  if(scripts\engine\utility::is_equal(var_5, "lethal")) {
    self._id_9FFB["lethal"] = 1;

    if(!isDefined(var_1.pers["lethalDeaths"])) {
      var_1.pers["lethalDeaths"] = 1;
    }
  }

  if(isDefined(var_5) && var_5 == "lethal" && var_2.basename != "s4_throwing_knife_mp") {
    level thread scripts\mp\battlechatter_mp::_id_CB70(self, "plr_killfirm_grenade", undefined, 0.75);
    level thread scripts\mp\battlechatter_mp::_id_CB70(self, "plr_killfirm_amf", undefined, 0.75);

    if(self._id_C0F4[var_3] > 0 && self._id_C0F4[var_3] % 2 == 0) {
      thread _id_8D83("grenade_double", 1);
      thread _id_07B1::_id_6FB9("grenade_double");
      self._id_9FFB["popcorn"] = 1;
    }
  }

  scripts\mp\utility\script::_id_2C9F("update_rapid_kill_buffered", self._id_C0F3, var_3);

  if(!isDefined(self._id_C0F3)) {
    self._id_C0F3 = 0;
  }

  if(self._id_C0F3 > 1) {
    thread _id_A2F8(var_0, self._id_C0F3, 0, 0, var_2);
    thread _id_07BC::createmultikillchallengeevent(self, self.multikill_modifiers, var_2, self._id_C0F3, var_4);
  }

  wait 4.0;

  if(self._id_C0F3 > 1) {
    thread _id_A2F8(var_0, self._id_C0F3, 1, 1, var_2);

    if(self._id_C0F3 > 2) {
      scripts\mp\utility\game::_id_D5FA(12, self.team, self getentitynumber(), self._id_C0F3);
    }
  }

  scripts\mp\utility\stats::_id_7DAE("mostMultikills", 1);
  self._id_C0F3 = 0;
  self._id_C0F1 = 0;
  self._id_C0F4 = undefined;
  self.recentkill_modifiers = [];
  self.multikill_modifiers = [];
}

_id_A0FE() {
  level endon("end_game");
  self endon("disconnect");

  for(;;) {
    self waittill("hijacker", var_0, var_1);
    thread _id_07B1::_id_6FB9("ss_use_enemy_dronedrop");
    var_2 = "hijacked_airdrop";

    if(isDefined(var_1)) {
      var_1 scripts\mp\hud_message::showsplash(var_2, undefined, self);
    }
  }
}

_id_FD09(var_0, var_1) {
  if(isDefined(level._id_BE94) && gettime() - level._id_BE94._id_E72D > 5000) {
    level._id_BE94 = undefined;
  }

  if(!isDefined(level._id_BE94) || level._id_BE94.player != var_0) {
    var_2 = spawnStruct();
    var_2.player = var_0;
    var_2._id_E72D = gettime();
    var_2._id_5A02 = 1;
    level._id_BE94 = var_2;
  } else {
    var_2 = level._id_BE94;
    var_2._id_5A02++;

    if(var_2._id_5A02 == 4) {
      var_2.player _id_BE93(var_1, var_2);
      level._id_BE94 = undefined;
    }
  }
}

_id_828C() {
  self._id_56C2 = self issprintsliding();
  self._id_56C0 = undefined;
}

_id_56BE() {
  if(scripts\mp\utility\player::isreallyalive(self)) {
    var_0 = self issprintsliding();

    if(istrue(self._id_56C2) && !var_0) {
      self._id_56C0 = gettime();
      _id_0805::_id_BD6C("recent_slide");
    }

    self._id_56C2 = var_0;
  } else {
    self._id_56C2 = 0;
    self._id_56C0 = undefined;
  }
}

_id_56BD() {
  if(self issprintsliding()) {
    return 1;
  }

  _id_56BE();

  if(isDefined(self._id_56C0)) {
    if(gettime() - self._id_56C0 <= 500) {
      return 1;
    }
  }

  return 0;
}

events_issupersprinting() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  for(;;) {
    wait 0.5;

    if(self _meth_86CF()) {
      return 1;
    }

    events_monitorsupersprintingdistanceupdate();
  }
}

events_monitorsupersprintingdistanceupdate() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  for(;;) {
    wait 0.1;
    self.eventsissupersprinting = self _meth_86CF();

    if(self.eventsissupersprinting) {
      break;
    }
  }

  var_0 = self.origin;

  for(var_1 = 0; self _meth_86CF(); var_0 = var_2) {
    wait 0.1;
    var_2 = self.origin;
    var_1 = var_1 + distance(var_2, var_0);
  }

  var_3 = int(_func_0438(var_1 / 39.3701));
  _id_07BC::createmisceventchallengeevent("superSprintDistance", var_3);
}

_id_8225() {
  self._id_10A07 = scripts\mp\utility\player::_id_8989();
  self._id_8F84 = 0;
}

_id_A0F2() {
  if(scripts\mp\utility\player::_id_8989()) {
    if(!self._id_10A07) {
      self._id_8F84 = gettime();
      self._id_10A07 = 1;
    }
  } else
    self._id_10A07 = 0;
}

initmonitorholdbreathtime() {
  self.lastholdingbreathtime = 0;
}

monitorholdbreath() {
  if(self _meth_8798()) {
    self.lastholdingbreathtime = gettime();
  }
}

_id_A139() {
  level endon("game_ended");
  self endon("disconnect");
  self._id_9038 = 0;

  for(;;) {
    self waittill("reload");
    self._id_9038 = gettime();
    scripts\mp\utility\stats::_id_7DAE("reloads", 1);
  }
}

_id_A150() {
  level endon("game_ended");
  self endon("disconnect");
  self._id_90CC = 0;

  for(;;) {
    self waittill("weapon_pickup");
    self._id_90CC = gettime();
    scripts\mp\utility\stats::_id_7DAE("weaponPickups", 1);
  }
}

_id_A152() {
  level endon("game_ended");
  self endon("disconnect");
  self._id_90C7 = 0;

  for(;;) {
    self waittill("weapon_change");
    self._id_90C7 = gettime();
  }
}

_id_FD89() {
  self._id_90C7 = gettime();
}

_id_829A() {
  self._id_9054 = self getstance();
  self._id_9055 = gettime();
  self._id_9056 = [];
  self._id_9056["prone"] = 0;
  self._id_9056["crouch"] = 0;
  self._id_9056["stand"] = 0;
}

_id_FD41() {
  if(!isalive(self)) {
    return;
  }
  var_0 = self._id_9A54;
  self._id_9A54 = self _meth_81CE();

  if(!istrue(var_0) && self._id_9A54) {
    _id_0805::_id_BD6C("recent_mantle");
  }

  var_1 = self._id_8C9B;
  self._id_8C9B = self _meth_846A();

  if(!istrue(var_1) && self._id_8C9B) {
    _id_0805::_id_BD6C("recent_jump");
  }

  var_2 = self getstance();

  if(var_2 != self._id_9054) {
    _id_0806::_id_B7DB(var_2);

    if(self._id_9054 == "crouch") {
      var_3 = self._id_9055;
      var_4 = (gettime() - var_3) / 1000;
      scripts\mp\utility\stats::_id_7DAE("timeCrouched", var_4);
    }

    if(self._id_9054 == "prone") {
      var_3 = self._id_9055;
      var_4 = (gettime() - var_3) / 1000;
      scripts\mp\utility\stats::_id_7DAE("timeProne", var_4);
    }

    self._id_9055 = gettime();

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

  self._id_9056[var_2] = gettime();
  self._id_9054 = var_2;
}

_id_BB7B(var_0) {
  _id_0806::_id_BB7B(var_0);
}

_id_8EE6(var_0) {
  _id_0806::_id_8EE6(var_0);
}

_id_10316(var_0) {
  _id_0806::_id_10316(var_0);
}

vehicledisabled(var_0, var_1) {
  if(isDefined(level._id_6016["createGameTypeChallenegeEvent"])) {
    if(var_0.attacker.team != var_0._id_103C2._id_ADAE) {
      scripts\engine\utility::_id_CD61("createGameTypeChallenegeEvent", "disabled_vehicle");
    }
  }
}

_id_9F6E(var_0) {
  thread _id_F425(var_0);
}

_id_F425(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_0._id_10E15 = [];

  for(;;) {
    var_1 = scripts\common\utility::_id_B7C7(var_0.origin, 220);

    foreach(var_3 in var_1) {
      if(isDefined(var_0.owner) && var_3 == var_0.owner) {
        continue;
      }
      _id_9F81(var_3, var_0);
      var_0._id_10E15[var_3.guid] = 1;
    }

    wait 0.1;
  }
}

_id_9F81(var_0, var_1) {
  _id_0806::_id_9F81(var_0);
}

_id_2635(var_0) {
  var_1 = 0;

  if(scripts\mp\utility\game::_id_6A65() >= 1) {
    var_2 = scripts\mp\utility\game::_id_6C7B();

    if(var_2.size == 1 && var_2[0] == var_0) {
      var_1 = 1;
    }
  }

  var_3 = 0;

  if(!var_1) {
    var_4 = scripts\mp\utility\player::_id_6C5F(var_0.origin, 600);

    foreach(var_6 in var_4) {
      if(var_6.team != var_0.team) {
        var_3 = 1;
        break;
      }
    }
  }

  if(isDefined(level._id_2661) && level._id_2661._id_2666 + 3000 + level._id_4644 * 1000 > gettime() && scripts\mp\utility\player::isreallyalive(level._id_2661)) {
    var_0 thread scripts\mp\rank::_id_CC00("ninja_defuse");
    var_0 thread scripts\mp\hud_message::showsplash("ninja_defuse", scripts\mp\rank::getscoreinfovalue("defuse"));
  } else {
    var_0 thread scripts\mp\hud_message::showsplash("emp_defuse", scripts\mp\rank::getscoreinfovalue("defuse"));
    var_0 thread scripts\mp\rank::_id_CC00("defuse");
  }

  if(var_1) {
    var_0 thread _id_07B1::_id_6FB9("mode_sd_last_defuse");
  } else {
    var_0 thread _id_07B1::_id_6FB9("mode_sd_defuse");
  }

  var_0 scripts\mp\utility\stats::_id_7DAE("defuses", 1);
  var_0 scripts\mp\persistence::_id_E770("round", "defuses", var_0.pers["defuses"]);
  var_0 _id_07BF::_id_7D94(4, 1);

  if(isDefined(var_0.pers["sneakDefuses"])) {
    var_8 = scripts\mp\utility\teams::_id_69FD(var_0.team, 1).size > 0;

    if(var_8) {
      var_0 scripts\mp\utility\stats::_id_7DAE("sneakDefuses", 1);
    }
  }

  if(scripts\mp\utility\game::getgametype() != "sr") {
    var_0 scripts\mp\utility\stats::_id_D551(var_0.pers["defuses"]);
  }

  if(isPlayer(var_0)) {
    var_9 = spawnStruct();
    var_9.player = var_0;
    var_9._id_56B9 = "defuse";
    var_9._id_033E = var_0.origin;
    _id_06E2::_id_4C2A("callback_on_game_event", var_9);
  }

  _id_0806::_id_2635(var_0, var_1, var_3);
}

_id_C7E1(var_0, var_1) {
  if(var_0 == var_1) {
    return;
  }
  _id_0806::_id_C7E1(var_0, var_1);

  if(scripts\mp\utility\game::getgametype() == "br") {
    scripts\mp\gametypes\br_analytics::_id_2B06(var_0, var_1);
  }
}

_id_4E60(var_0, var_1) {
  _id_0806::_id_4E60(var_0, var_1);

  if(var_1) {
    var_0._id_8FC0 = gettime();
  }
}

_id_DA5E() {
  _id_0806::_id_DA5E();
}

_id_DA61() {
  _id_0806::_id_DA61();
}

_id_8D83(var_0, var_1, var_2, var_3) {
  self endon("death_or_disconnect");

  if(!scripts\mp\rank::_id_CBFC(var_0)) {
    return;
  }
  if(!isDefined(self._id_8D82)) {
    self._id_8D82 = [];
  }

  foreach(var_5 in self._id_8D82) {
    if(var_5._id_CC02 == var_0) {
      return;
    }
  }

  var_7 = spawnStruct();
  var_7._id_CC02 = var_0;
  var_7._id_DC87 = istrue(var_1);
  var_7._id_BD27 = scripts\mp\rank::_id_6D0B(var_0);
  var_7._id_165D = scripts\mp\rank::_id_CBF9(var_0);
  var_7._id_BD68 = 0;
  var_7._id_BD67 = 0;
  var_7._id_4DAF = istrue(var_2);

  if(!istrue(var_7._id_4DAF)) {
    var_8 = scripts\mp\rank::_id_CBFB(var_7._id_CC02);

    if(isDefined(var_3)) {
      var_8 = var_3;
    }

    if(var_8 != "") {
      _id_0A8D::_id_9137(var_8);
    }
  }

  self._id_8D82[self._id_8D82.size] = var_7;
  self notify("killEventTextPopup");
  self endon("killEventTextPopup");
  waitframe();

  if(!isDefined(self._id_E41A)) {
    self._id_E41A = [];
  }

  foreach(var_5 in self._id_8D82) {
    _id_82E7(var_5);
  }

  self._id_8D82 = undefined;
  thread _id_BD80();
}

_id_BD80() {
  self notify("processSplashPriorityQueue");
  self endon("processSplashPriorityQueue");
  self._id_B399 = 1;

  if(!isDefined(self._id_E41A)) {
    self._id_B399 = 0;
  }

  foreach(var_1 in self._id_E41A) {
    if(var_1._id_BD68) {
      continue;
    }
    if(!istrue(level._id_C4DB) && istrue(var_1._id_DC87) && (!self._id_B399 || var_1._id_165D)) {
      var_2 = 1;
      thread scripts\mp\hud_message::showsplash(var_1._id_CC02);
    }

    var_1._id_BD68 = 1;
  }

  foreach(var_1 in self._id_E41A) {
    if(var_1._id_BD67 || var_1._id_4DAF) {
      continue;
    }
    thread scripts\mp\rank::_id_CC00(var_1._id_CC02);
    var_1._id_BD67 = 1;
    wait(getdvarfloat("#x34b79232251f0b4ce", 0.25));
  }

  self._id_E41A = undefined;
}

_id_82E7(var_0) {
  if(self._id_E41A.size == 0) {
    self._id_E41A[self._id_E41A.size] = var_0;
    return;
  }

  foreach(var_2 in self._id_E41A) {
    if(var_2._id_CC02 == var_0._id_CC02) {
      return;
    }
  }

  for(var_4 = 0; var_4 < self._id_E41A.size; var_4++) {
    if(var_0._id_BD27 > self._id_E41A[var_4]._id_BD27) {
      self._id_E41A = scripts\engine\utility::_id_1BB3(self._id_E41A, var_0, var_4);
      return;
    }
  }

  self._id_E41A[self._id_E41A.size] = var_0;
}

_id_6B74() {
  var_0 = [];

  if(!scripts\mp\utility\game::_id_98D3() && isDefined(self._id_8D78)) {
    var_1 = 0;

    foreach(var_4, var_3 in self._id_8D78) {
      if(var_3 > var_1) {
        var_0 = [];
        var_0[var_0.size] = var_4;
      }

      if(var_3 == var_1) {
        var_0[var_0.size] = var_4;
      }
    }
  }

  return var_0;
}