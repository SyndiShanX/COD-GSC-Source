/*********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\events.gsc
*********************************/

init() {
  var_00 = [];
  var_00["dm"] = 4;
  var_00["war"] = 5;
  var_00["sd"] = 6;
  var_00["dom"] = 7;
  var_00["conf"] = 8;
  var_00["sr"] = 9;
  var_00["grind"] = 10;
  var_00["ball"] = 11;
  var_00["infect"] = 12;
  var_00["aliens"] = 13;
  var_00["gun"] = 14;
  var_00["grnd"] = 15;
  var_00["siege"] = 16;
  var_00["koth"] = 17;
  var_00["mp_zomb"] = 18;
  var_00["ctf"] = 19;
  var_00["dd"] = 20;
  var_00["tdef"] = 21;
  var_00["front"] = 22;
  var_01 = level.gametype;
  if(!isDefined(var_01)) {
    var_01 = getdvar("g_gametype");
  }

  var_02 = 0;
  for(;;) {
    var_03 = tablelookupbyrow("mp\score_event_table.csv", var_02, 0);
    if(!isDefined(var_03) || var_03 == "") {
      break;
    }

    var_04 = tablelookupbyrow("mp\score_event_table.csv", var_02, var_00[var_01]);
    if(!isDefined(var_04) || var_04 == "") {
      var_02++;
      continue;
    }

    if(var_03 == "win" || var_03 == "loss" || var_03 == "tie") {
      var_04 = float(var_04);
    } else {
      var_04 = int(var_04);
    }

    if(var_04 != -1) {
      scripts\mp\rank::registerscoreinfo(var_03, "value", var_04);
    }

    var_05 = tablelookuprownum("mp\score_event_table.csv", 0, var_03);
    scripts\mp\rank::registerscoreinfo(var_03, "eventID", var_05);
    var_05 = tablelookupbyrow("mp\score_event_table.csv", var_02, 1);
    scripts\mp\rank::registerscoreinfo(var_03, "text", var_05);
    var_06 = tablelookuprownum("mp\splashTable.csv", 0, var_03);
    if(isDefined(var_06) && var_06 != -1) {
      scripts\mp\rank::registerscoreinfo(var_03, "splashID", var_06);
    }

    var_07 = tablelookupbyrow("mp\score_event_table.csv", var_02, 3);
    scripts\mp\rank::registerscoreinfo(var_03, "group", var_07);
    var_08 = tablelookupbyrow("mp\score_event_table.csv", var_02, 2);
    if(isDefined(var_08) && tolower(var_08) == "true") {
      scripts\mp\rank::registerscoreinfo(var_03, "allowBonus", 1);
    }

    var_02++;
  }

  level._effect["money"] = loadfx("vfx\props\cash_player_drop");
  level.numkills = 0;
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00.var_A653 = [];
    var_00.killedby = [];
    var_00.lastkilledby = undefined;
    var_00._meth_8549 = 0;
    var_00.var_DDC2 = 0;
    var_00.var_DDC1 = 0;
    var_00.lastkilltime = 0;
    var_00.lastkilldogtime = 0;
    var_00.damagedplayers = [];
    var_00 thread func_B9C5();
    var_00 thread func_B9DF();
    var_00 thread events_monitorslide();
  }
}

damagedplayer(param_00, param_01, param_02) {
  if(param_01 < 50 && param_01 > 10) {
    thread scripts\mp\utility::giveunifiedpoints("damage", param_02);
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_damaged_light", undefined, 0.1);
    return;
  }

  thread scripts\mp\utility::giveunifiedpoints("heavy_damage", param_02);
  level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_damaged_heavy", undefined, 0.1);
}

func_A652(param_00, param_01, param_02, param_03) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("killedPlayerNotify");
  self endon("killedPlayerNotify");
  if(!isDefined(self.var_A67A)) {
    self.var_A67A = 0;
  }

  self.var_A67A++;
  if(param_03 == "MOD_PISTOL_BULLET" || param_03 == "MOD_RIFLE_BULLET" || param_03 == "MOD_HEAD_SHOT") {
    if(!isDefined(self.var_3247)) {
      self.var_3247 = 1;
    } else {
      self.var_3247++;
      if(self.var_3247 >= 2) {
        if(scripts\mp\utility::_hasperk("passive_collat_streak")) {
          var_04 = scripts\mp\perks\_weaponpassives::getpassivevalue("passive_collat_streak");
          self[[var_04]]();
        }
      }

      if(self.var_3247 == 2) {
        level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_twofer", undefined, 0.75);
        thread scripts\mp\awards::givemidmatchaward("one_shot_two_kills");
        thread scripts\mp\missions::func_D995();
        var_05 = getweaponbasename(param_02);
        if(var_05 == "iw7_penetrationrail_mp") {
          thread scripts\mp\missions::func_D991("ch_sniper_ballista_collateral");
        }
      }

      if(self.var_3247 == 3) {
        level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_threefer", undefined, 0.75);
      }
    }
  }

  waittillframeend;
  thread func_C165(param_00, param_01, param_02, param_03, self.var_A67A);
  self.var_A67A = 0;
  self.var_3247 = 0;
}

func_C165(param_00, param_01, param_02, param_03, param_04) {
  for(var_05 = 0; var_05 < param_04; var_05++) {
    self notify("got_a_kill", param_01, param_02, param_03);
    wait(0.05);
  }
}

func_A651(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = param_01.guid;
  var_07 = self.guid;
  var_08 = gettime();
  thread func_A652(param_00, param_01, param_02, param_03);
  thread func_12EFE(param_00, param_01, param_02);
  thread func_12EF8(self);
  self.lastkilltime = gettime();
  self.var_A9A4 = param_01;
  if(self.var_E9 > 0) {
    var_09 = self.setculldist / self.var_E9;
    if(var_09 > 3) {
      level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_kd_high", undefined, 0.75);
    }
  } else if(self.setculldist > 5) {
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_kd_high", undefined, 0.75);
  }

  self.modifiers = [];
  level.numkills++;
  self.damagedplayers[var_06] = undefined;
  func_3E24(param_02, param_03);
  var_0A = scripts\mp\utility::getweapongroup(param_02);
  var_0B = scripts\mp\utility::getweaponrootname(param_02);
  if(!scripts\mp\utility::iskillstreakweapon(param_02) && !scripts\mp\utility::isjuggernaut() && !scripts\mp\utility::_hasperk("specialty_explosivebullets")) {
    if(param_02 == "none") {
      return 0;
    }

    if(var_0A == "weapon_sniper" && param_03 != "MOD_MELEE" && gettime() == param_01.attackerdata[self.guid].firsttimedamaged && !issubstr(param_02, "iw7_longshot_mp") && scripts\mp\weapons::isaltmodeweapon(param_02)) {
      if(!isDefined(self.pers["oneShotKills"])) {
        self.pers["oneShotKills"] = 1;
      } else {
        self.pers["oneShotKills"]++;
      }

      self.modifiers["oneshotkill"] = 1;
      thread scripts\mp\awards::givemidmatchaward("one_shot_kill");
    }

    if(var_0A == "weapon_shotgun" && param_03 != "MOD_MELEE" && gettime() == param_01.attackerdata[self.guid].firsttimedamaged) {
      self.modifiers["oneshotkill_shotgun"] = 1;
    }

    if(param_03 == "MOD_MELEE" && param_02 != "iw7_reaperblade_mp") {
      if(var_0A != "weapon_melee") {
        thread scripts\mp\awards::givemidmatchaward("gun_butt");
      }

      if(var_0B == "iw7_fists") {
        thread scripts\mp\awards::givemidmatchaward("fist_kill");
      }
    }

    var_0C = param_01 _meth_854D();
    if(var_0C == "frag_grenade_mp" || var_0C == "cluster_grenade_mp") {
      self.modifiers["cooking"] = 1;
    }

    if(isDefined(self.assistedsuicide) && self.assistedsuicide) {
      assistedsuicide(param_00, param_02, param_03, param_01);
    }

    if(level.numkills == 1) {
      func_6DE1(param_00, param_02, param_03, param_01);
      if(level.gametype == "sd") {
        scripts\mp\utility::setmlgannouncement(21, self.team, self getentitynumber());
      }
    }

    if(self.pers["cur_death_streak"] > 3) {
      func_4417(param_00, param_02, param_03, param_01);
    }

    if(param_03 == "MOD_HEAD_SHOT") {
      level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_headshot", undefined, 0.75);
      func_8C9B(param_00, param_02, param_03, param_01);
    }

    if(isDefined(self.wasti) && self.wasti && gettime() - self.spawntime <= 5000) {
      self.modifiers["jackintheboxkill"] = 1;
    }

    if(!scripts\mp\utility::isreallyalive(self) && isDefined(self.deathtime)) {
      var_0D = gettime() - self.deathtime;
      if(var_0D < 1500 && var_0D > 0) {
        func_D6F7(param_00, param_01, param_02);
      }

      if(scripts\mp\utility::issimultaneouskillenabled()) {
        if(var_0D == 0 && isDefined(self.sethalfresparticles) && self.sethalfresparticles == param_01) {
          thread scripts\mp\awards::givemidmatchaward("simultaneous_kill", undefined, undefined, 1);
          param_01 thread scripts\mp\awards::givemidmatchaward("simultaneous_kill", undefined, undefined, 1);
          thread events_playertracksimultaneouskill();
          param_01 thread events_playertracksimultaneouskill();
        }
      }
    }

    if(level.teambased && var_08 - param_01.lastkilltime < 1500) {
      if(param_01.var_A9A4 != self) {
        func_26A5(param_00, param_02, param_03, param_01);
      }
    }

    foreach(var_10, var_0F in param_01.damagedplayers) {
      if(var_10 == self.guid) {
        continue;
      }

      if(level.teambased && var_08 - var_0F < 1750) {
        func_5082(param_00, param_02, param_03, param_01);
      }
    }

    if(isDefined(param_01.attackerposition)) {
      var_11 = param_01.attackerposition;
    } else {
      var_11 = self.origin;
    }

    var_12 = 1;
    if(isDefined(param_05)) {
      var_12 = param_05 == self;
    }

    if(var_12) {
      if(func_9F03(self, param_02, param_03, var_11, param_01)) {
        thread func_D63F(param_00, param_02, param_03, param_01);
      } else if(func_9E84(self, param_02, param_03, var_11, param_01)) {
        thread func_AFEA(param_00, param_02, param_03, param_01);
      }
    }

    if(isbackkill(self, param_01, param_03)) {
      if(var_0B == "iw7_knife") {
        thread scripts\mp\awards::givemidmatchaward("backstab");
      }

      self.modifiers["backstab"] = 1;
    }

    if(var_12) {
      if(issurvivorkill(self)) {
        thread givekillreward("low_health_kill", param_00, param_02, param_03, param_01, "low_health_kill");
      }

      if(scripts\mp\utility::func_9EE8()) {
        self.modifiers["ads"] = 1;
      } else if(scripts\engine\utility::isbulletdamage(param_03)) {
        self.modifiers["hipfire"] = 1;
      }

      if(!self isonground()) {
        self.modifiers["airborne"] = 1;
      }

      if(level.teambased) {
        foreach(var_14 in level.players) {
          if(self.team != var_14.team || self == var_14) {
            continue;
          }

          if(!scripts\mp\utility::isreallyalive(var_14)) {
            continue;
          }

          if(distancesquared(self.origin, var_14.origin) < 90000) {
            self.modifiers["buddy_kill"] = 1;
            break;
          }
        }
      }
    } else if(var_0A == "weapon_projectile") {
      if(isDefined(param_05) && isDefined(param_05.adsfire)) {
        if(param_05.adsfire) {
          self.modifiers["ads"] = 1;
        } else {
          self.modifiers["hipfire"] = 1;
        }
      }
    }

    if(!param_01 isonground() && !param_01 iswallrunning() && !self isonground() && !self iswallrunning()) {
      if(var_12) {
        thread givekillreward("air_to_air_kill", param_00, param_02, param_03, param_01, "air_to_air_kill");
      }
    } else {
      if(var_12) {
        if(self iswallrunning()) {
          thread givekillreward("wallkill", param_00, param_02, param_03, param_01, "wallrun_kill");
        } else if(isdeathfromabove(self, param_02, param_03, var_11, param_01)) {
          thread givekillreward("jumpkill", param_00, param_02, param_03, param_01, "air_kill");
        } else if(events_issliding()) {
          thread givekillreward("slidekill", param_00, param_02, param_03, param_01, "slide_kill");
          self.modifiers["sliding"] = 1;
        }

        var_16 = self getstance();
        switch (var_16) {
          case "prone":
            self.modifiers["prone_kill"] = 1;
            break;

          case "crouch":
            self.modifiers["crouch_kill"] = 1;
            break;
        }
      }

      if(param_01 iswallrunning()) {
        thread givekillreward("killonwall", param_00, param_02, param_03, param_01, "kill_wallrunner");
      } else if(isskeetshooter(self, param_02, param_03, var_11, param_01)) {
        thread givekillreward("killinair", param_00, param_02, param_03, param_01, "kill_jumper");
      }
    }

    if(var_12) {
      if(scripts\mp\weapons::_meth_85BE()) {
        self.modifiers["clutchkill"] = 1;
      }
    }

    if(isDefined(param_01.var_A6AB)) {
      foreach(var_1A, var_18 in param_01.var_A6AB) {
        var_19 = var_1A - param_01.destroynavrepulsor;
        if(var_19 > 0 && var_19 < 100) {
          func_32FA(param_00, param_01, param_02, param_03, param_01);
        }
      }
    }

    if(var_12) {
      if(self ismantling()) {
        thread scripts\mp\awards::givemidmatchaward("mantle_kill");
      }

      if(scripts\mp\weapons::isstunnedorblinded()) {
        thread scripts\mp\awards::givemidmatchaward("stunned_kill");
      }

      if(isDefined(self.tookweaponfrom[param_02]) && self.tookweaponfrom[param_02] == param_01) {
        thread scripts\mp\awards::givemidmatchaward("backfire");
      }
    }

    if(isDefined(param_01.var_1117F)) {
      level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_semtex", undefined, 0.75);
    }

    if(scripts\mp\weapons::func_9FA9(param_02)) {
      thread scripts\mp\awards::givemidmatchaward("throwingknife_kill");
    }

    if(level.teambased) {
      var_1B = 0;
      foreach(var_1D in level.teamlist[scripts\mp\utility::getotherteam(self.team)]) {
        if(var_1D.destroynavrepulsor > 0) {
          var_1B = 1;
          break;
        }
      }

      if(var_1B) {
        var_1F = scripts\engine\utility::array_sort_with_func(level.teamlist[scripts\mp\utility::getotherteam(self.team)], ::func_9CAE);
        if(isDefined(var_1F[0]) && param_01 == var_1F[0]) {
          thread scripts\mp\awards::givemidmatchaward("first_place_kill");
        }
      }
    } else {
      var_1B = 0;
      foreach(var_1D in level.players) {
        if(var_1D.destroynavrepulsor > 0) {
          var_1B = 1;
          break;
        }
      }

      if(var_1B) {
        var_1F = scripts\engine\utility::array_sort_with_func(level.players, ::func_9CAE);
        if(isDefined(var_1F[0]) && param_01 == var_1F[0]) {
          thread scripts\mp\awards::givemidmatchaward("first_place_kill");
          if(level.gametype == "gun" && param_03 == "MOD_MELEE") {
            thread scripts\mp\awards::givemidmatchaward("mode_gun_melee_1st_place");
          }
        }
      }
    }

    var_22 = self.pers["cur_kill_streak"] + 1;
    if(!var_22 % 5) {
      if(!isDefined(self.lastkillsplash) || var_22 != self.lastkillsplash) {
        thread scripts\mp\utility::teamplayercardsplash("callout_kill_streaking", self, undefined, var_22);
        self.lastkillsplash = var_22;
      }

      if(var_22 <= 30) {
        thread scripts\mp\awards::givemidmatchaward("streak_" + var_22);
      }
    } else if(!var_22 % 7) {
      scripts\mp\utility::setmlgannouncement(17, self.team, self getentitynumber(), 7);
    }

    if(var_22 > 30) {
      thread scripts\mp\awards::givemidmatchaward("streak_max");
    }

    if(isDefined(param_05) && scripts\mp\utility::istrue(param_05.var_9F07) && param_03 == "MOD_IMPACT" && !scripts\mp\weapons::func_9FA9(param_02)) {
      thread scripts\mp\awards::givemidmatchaward("item_impact");
    }

    if(scripts\mp\utility::getgametypenumlives() >= 1) {
      if(param_01.pers["lives"] == 0) {
        thread scripts\mp\awards::givemidmatchaward("mode_x_eliminate");
      }

      var_23 = scripts\mp\utility::getpotentiallivingplayers();
      if(var_23.size == 1 && var_23[0] == self) {
        thread scripts\mp\awards::givemidmatchaward("mode_x_last_alive");
      }
    }

    if(param_02 == "groundpound_mp") {
      level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_pound", undefined, 0.75);
    }

    func_3E50(param_01, param_05, param_02, param_03);
    func_3E51(param_01, param_02, param_03);
    thread func_3E27(param_00, param_01, param_02, param_03, param_04);
  }

  if(!isDefined(self.var_A653[var_06])) {
    self.var_A653[var_06] = 0;
  }

  if(!isDefined(param_01.killedby[var_07])) {
    param_01.killedby[var_07] = 0;
  }

  self.var_A653[var_06]++;
  param_01.killedby[var_07]++;
  param_01.lastkilledby = self;
  scripts\mp\utility::bufferednotify("kill_event_buffered", param_01, param_02, param_03, self.modifiers);
}

func_3E24(param_00, param_01) {
  var_02 = scripts\mp\utility::iskillstreakweapon(param_00);
  if(var_02) {
    var_03 = level.killstreakweildweapons[param_00];
    switch (var_03) {
      case "sentry_shock":
        thread scripts\mp\awards::givemidmatchaward("ss_kill_sentry_shock");
        break;

      case "ball_drone_backup":
        thread scripts\mp\awards::givemidmatchaward("ss_kill_ball_drone_backup");
        break;

      case "drone_hive":
        thread scripts\mp\awards::givemidmatchaward("ss_kill_trinity");
        break;

      case "precision_airstrike":
        thread scripts\mp\awards::givemidmatchaward("ss_kill_precision_airstrike");
        break;

      case "minijackal":
        thread scripts\mp\awards::givemidmatchaward("ss_kill_minijackal");
        break;

      case "thor":
        thread scripts\mp\awards::givemidmatchaward("ss_kill_thor");
        break;

      case "bombardment":
        thread scripts\mp\awards::givemidmatchaward("ss_kill_bombardment");
        break;

      case "remote_c8":
        thread scripts\mp\awards::givemidmatchaward("ss_kill_remote_c8");
        break;

      case "venom":
        thread scripts\mp\awards::givemidmatchaward("ss_kill_venom");
        break;

      case "jackal":
        thread scripts\mp\awards::givemidmatchaward("ss_kill_jackal");
        break;

      default:
        thread scripts\mp\utility::giveunifiedpoints("killstreak_full_score", param_00);
        break;
    }

    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_killstreak", undefined, 0.75);
  }
}

func_3E50(param_00, param_01, param_02, param_03) {
  var_04 = scripts\mp\supers::issuperinuse();
  var_05 = scripts\mp\supers::getcurrentsuperref();
  var_06 = scripts\mp\supers::getcurrentsuper();
  var_07 = scripts\mp\utility::issuperweapon(param_02);
  var_08 = undefined;
  if(!isDefined(var_05)) {
    return;
  }

  if(var_07 && param_02 != "iw7_reaperblade_mp") {
    thread func_A655(param_00, param_01, param_02, param_03);
    if(param_03 != "MOD_MELEE") {
      scripts\mp\utility::bufferednotify("super_kill_buffered");
    }

    var_09 = getweaponbasename(param_02);
    if(var_09 == "iw7_claw_mp") {
      var_08 = "super_claw_kill";
      level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_super", undefined, 0.75);
    } else if(var_09 == "iw7_atomizer_mp") {
      var_08 = "super_eraser_kill";
      level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_super", undefined, 0.75);
    } else if(var_09 == "iw7_blackholegun_mp") {
      var_08 = "super_blackholegun_kill";
      level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_super_kill", undefined, 0.75);
    } else if(var_09 == "iw7_penetrationrail_mp") {
      var_08 = "super_railgun_kill";
      level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_railgun", undefined, 0.75);
    } else if(var_09 == "iw7_steeldragon_mp") {
      var_08 = "super_steeldragon_kill";
      level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_dragon", undefined, 0.75);
    } else if(var_09 == "iw7_armmgs_mp") {
      var_08 = "super_arm2_kill";
    }

    if(isDefined(var_08)) {
      thread scripts\mp\utility::giveunifiedpoints(var_08);
    }
  }

  var_0A = 0;
  if(isDefined(var_05)) {
    switch (var_05) {
      case "super_amplify":
        if(var_04 == 1) {
          var_08 = "super_combatfocus_kill";
          var_0A = 1;
        }
        break;

      case "super_overdrive":
        if(var_04 == 1) {
          var_08 = "super_overdrive_kill";
          var_0A = 1;
        }
        break;

      case "super_chargemode":
        if(var_04 == 1) {
          var_08 = "super_bullcharge_kill";
          level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_charge", undefined, 0.75);
          var_0A = 1;
        }
        break;

      case "super_armorup":
        if(var_04 == 1) {
          var_08 = "super_armorup_kill";
          level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_armor", undefined, 0.75);
          var_0A = 1;
        }
        break;

      case "super_reaper":
        if(var_04 == 1) {
          var_08 = "super_reaper_kill";
          level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_reaper", undefined, 0.75);
          var_0A = 1;
        }
        break;

      case "super_rewind":
        if(var_04 == 1 || isDefined(var_06.var_A986) && gettime() < var_06.var_A986 + 3000) {
          var_08 = "super_rewind_kill";
          var_0A = 1;
        }
        break;

      case "super_phaseshift":
        if(var_04 == 1 || isDefined(var_06.var_A986) && gettime() < var_06.var_A986 + 3000) {
          var_08 = "super_phaseshift_kill";
          level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_shift", undefined, 0.75);
          var_0A = 1;
        }
        break;

      case "super_teleport":
        if(var_04 == 1 || isDefined(var_06.var_A986) && gettime() < var_06.var_A986 + 3000) {
          var_08 = "super_teleport_kill";
          var_0A = 1;
        }
        break;

      case "super_microturret":
        if(param_02 == "micro_turret_gun_mp") {
          var_08 = "super_microturret_kill";
          level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_turret_kill", undefined, 0.75);
          var_0A = 1;
        }
        break;

      case "super_invisible":
        if(var_04 == 1 || isDefined(var_06.var_A986) && gettime() < var_06.var_A986 + 2000) {
          var_08 = "super_invisible_kill";
          level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_stealth", undefined, 0.75);
          var_0A = 1;
        }
        break;

      case "super_visionpulse":
        if(scripts\mp\supers\super_visionpulse::func_9EF9(param_00)) {
          var_08 = "super_wallhack_kill";
          var_0A = 1;
        }
        break;

      case "super_kineticpulse":
        if(scripts\mp\equipment\kinetic_pulse::isplayertaggedbykineticpulse(param_00)) {
          var_08 = "super_kineticpulse_kill";
          var_0A = 1;
        }
        break;

      default:
        break;
    }

    if(var_0A) {
      thread superkill(var_05, param_03);
      scripts\mp\supers::combatrecordsuperkill(var_05);
      if(isDefined(var_08)) {
        thread scripts\mp\utility::giveunifiedpoints(var_08);
      }

      scripts\mp\utility::bufferednotify("super_kill_buffered");
    }
  }
}

func_3E51(param_00, param_01, param_02) {
  var_03 = param_00 scripts\mp\supers::issuperinuse();
  var_04 = param_00 scripts\mp\supers::getcurrentsuperref();
  var_05 = param_00 scripts\mp\supers::getcurrentsuper();
  if(!isDefined(var_04)) {
    return;
  }

  switch (var_04) {
    case "super_armorup":
      if(var_03 == 1 || isDefined(var_05.var_A986) && gettime() - var_05.var_A986 < 1000) {
        if(isDefined(param_00.var_219F) && scripts\engine\utility::array_contains(param_00.var_219F, self)) {
          thread supershutdown(param_00);
        }
      }
      break;

    case "super_visionpulse":
      if(param_00 scripts\mp\supers\super_visionpulse::func_9EF9(self)) {
        thread supershutdown(param_00);
      }
      break;

    case "super_phaseshift":
      if(var_03 == 1 || isDefined(var_05.var_A986) && gettime() - var_05.var_A986 < 2000) {
        thread supershutdown(param_00);
      }
      break;

    case "super_teleport":
      if(var_03 == 1 || isDefined(var_05.var_A986) && gettime() - var_05.var_A986 < 2000) {
        thread supershutdown(param_00);
      }
      break;

    case "super_invisible":
      if(var_03 == 1 || isDefined(var_05.var_A986) && gettime() - var_05.var_A986 < 2000) {
        thread supershutdown(param_00);
      }
      break;

    case "super_kineticpulse":
      if(param_00 scripts\mp\equipment\kinetic_pulse::isplayertaggedbykineticpulse(self)) {
        thread supershutdown(param_00);
      }
      break;

    case "super_rewind":
      if(var_03 == 1 || isDefined(var_05.var_A986) && gettime() - var_05.var_A986 < 2000) {
        thread supershutdown(param_00);
      }
      break;

    default:
      if(var_03 == 1) {
        thread supershutdown(param_00);
      }
      break;
  }
}

func_A655(param_00, param_01, param_02, param_03) {
  var_04 = scripts\mp\supers::_meth_8189(param_02);
  var_05 = self.var_DDC3[param_02];
  if(isDefined(var_05) && var_05 > 0 && var_05 % 2 == 0) {
    superkill(var_04, param_03);
  } else {
    var_06 = scripts\mp\supers::getcurrentsuper();
    var_06.numkills++;
  }

  scripts\mp\missions::func_12F33(param_02, param_01);
  scripts\mp\supers::combatrecordsuperkill(var_04);
}

superkill(param_00, param_01) {
  var_02 = scripts\mp\supers::getrootsuperref(param_00);
  var_03 = "super_kill_" + var_02;
  switch (var_03) {
    case "super_kill_chargemode":
      var_03 = "super_kill_bull_charge";
      break;
  }

  if(isDefined(level.awards[var_03])) {
    thread scripts\mp\awards::givemidmatchaward(var_03);
  }

  var_04 = scripts\mp\supers::getcurrentsuper();
  var_04.numkills++;
  scripts\mp\missions::updatesuperkills(param_00, param_01, var_04.numkills);
  self.modifiers["super_kill_medal"] = param_00;
}

killedkillstreak(param_00, param_01) {
  if(param_00 != "precision_airstrike") {
    var_02 = "kill_ss_" + param_00;
    param_01 thread scripts\mp\awards::givemidmatchaward(var_02);
  }

  param_01.var_A6B4[param_01.var_A6B4.size] = param_00;
  level thread scripts\mp\battlechatter_mp::saytoself(param_01, "plr_killstreak_destroy", undefined, 0.75);
}

func_9CAE(param_00, param_01) {
  return param_00.destroynavrepulsor > param_01.destroynavrepulsor;
}

func_9E84(param_00, param_01, param_02, param_03, param_04) {
  if(isalive(param_00) && !param_00 scripts\mp\utility::isusingremote() && param_02 == "MOD_RIFLE_BULLET" || param_02 == "MOD_PISTOL_BULLET" || param_02 == "MOD_HEAD_SHOT" && !scripts\mp\utility::iskillstreakweapon(param_01) && !isDefined(param_00.assistedsuicide)) {
    var_05 = scripts\mp\utility::getweapongroup(param_01);
    switch (var_05) {
      case "weapon_pistol":
        var_06 = 800;
        break;

      case "weapon_beam":
      case "weapon_smg":
        var_06 = 1200;
        break;

      case "weapon_lmg":
      case "weapon_dmr":
      case "weapon_assault":
        var_06 = 1500;
        break;

      case "weapon_rail":
      case "weapon_sniper":
        var_06 = 2000;
        break;

      case "weapon_shotgun":
        var_06 = 500;
        break;

      case "weapon_projectile":
      default:
        var_06 = 1536;
        break;
    }

    var_07 = var_06 * var_06;
    if(distancesquared(param_03, param_04.origin) > var_07) {
      return 1;
    }
  }

  return 0;
}

func_9F03(param_00, param_01, param_02, param_03, param_04) {
  if(isalive(param_00) && !param_00 scripts\mp\utility::isusingremote() && param_02 == "MOD_RIFLE_BULLET" || param_02 == "MOD_PISTOL_BULLET" || param_02 == "MOD_HEAD_SHOT" && !scripts\mp\utility::iskillstreakweapon(param_01) && !isDefined(param_00.assistedsuicide)) {
    var_05 = 9216;
    if(distancesquared(param_03, param_04.origin) < var_05) {
      return 1;
    }
  }

  return 0;
}

isdeathfromabove(param_00, param_01, param_02, param_03, param_04) {
  if(isalive(param_00) && param_00 isjumping() && scripts\engine\utility::isbulletdamage(param_02)) {
    var_05 = param_00.origin[2] - param_04.origin[2];
    return var_05 > 60;
  }

  return 0;
}

isskeetshooter(param_00, param_01, param_02, param_03, param_04) {
  return isalive(param_00) && param_04 isjumping() && scripts\engine\utility::isbulletdamage(param_02);
}

isbackkill(param_00, param_01, param_02) {
  if(!isplayer(param_00) || !isplayer(param_01)) {
    return 0;
  }

  if(param_02 != "MOD_RIFLE_BULLET" && param_02 != "MOD_PISTOL_BULLET" && param_02 != "MOD_MELEE" && param_02 != "MOD_HEAD_SHOT") {
    return 0;
  }

  var_03 = param_01 getplayerangles();
  var_04 = param_00 getplayerangles();
  var_05 = angleclamp180(var_03[1] - var_04[1]);
  if(abs(var_05) < 80) {
    return 1;
  }

  return 0;
}

issurvivorkill(param_00) {
  return param_00.health > 0 && param_00.health < param_00.maxhealth * 0.2;
}

func_3E27(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(self.lastkilledby) && self.lastkilledby == param_01) {
    self.lastkilledby = undefined;
    func_E48D(param_00, param_02);
  }
}

givekillreward(param_00, param_01, param_02, param_03, param_04, param_05) {
  self.modifiers[param_00] = 1;
  if(isDefined(param_05)) {
    thread scripts\mp\awards::givemidmatchaward(param_05);
    return;
  }

  thread scripts\mp\utility::giveunifiedpoints(param_00, param_02);
}

proximityassist(param_00) {
  self.modifiers["proximityAssist"] = 1;
  thread scripts\mp\utility::giveunifiedpoints("proximityassist");
}

proximitykill(param_00) {
  self.modifiers["proximityKill"] = 1;
  thread scripts\mp\utility::giveunifiedpoints("proximitykill");
}

func_AFEA(param_00, param_01, param_02, param_03) {
  self.modifiers["longshot"] = 1;
  thread scripts\mp\matchdata::loginitialstats(param_00, "longshot");
  thread scripts\mp\awards::givemidmatchaward("longshot");
}

func_D63F(param_00, param_01, param_02, param_03) {
  self.modifiers["pointblank"] = 1;
  thread scripts\mp\matchdata::loginitialstats(param_00, "pointblank");
  thread scripts\mp\awards::givemidmatchaward("pointblank");
}

func_8C9B(param_00, param_01, param_02, param_03) {
  self.modifiers["headshot"] = 1;
  thread scripts\mp\matchdata::loginitialstats(param_00, "headshot");
  thread scripts\mp\awards::givemidmatchaward("headshot");
}

func_26A5(param_00, param_01, param_02, param_03) {
  self.modifiers["avenger"] = 1;
  thread scripts\mp\matchdata::loginitialstats(param_00, "avenger");
  thread scripts\mp\awards::givemidmatchaward("avenger");
}

assistedsuicide(param_00, param_01, param_02, param_03) {
  self.modifiers["assistedsuicide"] = 1;
  thread scripts\mp\utility::giveunifiedpoints("assistedsuicide", param_01);
  thread scripts\mp\matchdata::loginitialstats(param_00, "assistedsuicide");
  thread scripts\mp\awards::givemidmatchaward("assistedsuicide");
}

func_5082(param_00, param_01, param_02, param_03) {
  self.modifiers["defender"] = 1;
  thread scripts\mp\matchdata::loginitialstats(param_00, "defender");
  thread scripts\mp\awards::givemidmatchaward("save_teammate");
}

func_D6F7(param_00, param_01, param_02) {
  self.modifiers["posthumous"] = 1;
  thread scripts\mp\matchdata::loginitialstats(param_00, "posthumous");
  thread scripts\mp\awards::givemidmatchaward("posthumous");
}

func_E48D(param_00, param_01, param_02) {
  self.modifiers["revenge"] = 1;
  thread scripts\mp\matchdata::loginitialstats(param_00, "revenge");
  thread scripts\mp\awards::givemidmatchaward("revenge");
}

func_BDC2(param_00, param_01, param_02) {
  var_03 = undefined;
  switch (param_01) {
    case 2:
      var_03 = "double";
      break;

    case 3:
      var_03 = "triple";
      thread scripts\mp\utility::teamplayercardsplash("callout_3xkill", self);
      break;

    case 4:
      var_03 = "four";
      thread scripts\mp\utility::teamplayercardsplash("callout_4xkill", self);
      scripts\mp\utility::setmlgannouncement(18, self.team, self getentitynumber(), 4);
      break;

    case 5:
      var_03 = "five";
      thread scripts\mp\utility::teamplayercardsplash("callout_5xkill", self);
      break;

    case 6:
      var_03 = "six";
      thread scripts\mp\utility::teamplayercardsplash("callout_6xkill", self);
      break;

    case 7:
      var_03 = "seven";
      thread scripts\mp\utility::teamplayercardsplash("callout_7xkill", self);
      break;

    case 8:
      var_03 = "eight";
      thread scripts\mp\utility::teamplayercardsplash("callout_8xkill", self);
      break;

    default:
      var_03 = "multi";
      thread scripts\mp\utility::teamplayercardsplash("callout_9xkill", self);
      break;
  }

  thread scripts\mp\matchdata::func_AFCB(param_00, param_01);
  if(isDefined(var_03)) {
    thread scripts\mp\awards::givemidmatchaward(var_03);
  }
}

func_6DE1(param_00, param_01, param_02, param_03) {
  self.modifiers["firstblood"] = 1;
  thread scripts\mp\matchdata::loginitialstats(param_00, "firstblood");
  thread scripts\mp\utility::teamplayercardsplash("callout_firstblood", self);
  scripts\mp\missions::processchallenge("ch_bornready");
  thread scripts\mp\awards::givemidmatchaward("firstblood");
}

func_13D8C(param_00) {}

func_4417(param_00, param_01, param_02, param_03) {
  self.modifiers["comeback"] = 1;
  thread scripts\mp\matchdata::loginitialstats(param_00, "comeback");
  thread scripts\mp\awards::givemidmatchaward("comeback");
}

supershutdown(param_00) {
  var_01 = scripts\mp\supers::getrootsuperref(param_00.super.staticdata.ref);
  self.modifiers["superShutdown"] = param_00.super.staticdata.ref;
  var_02 = "super_shutdown_" + var_01;
  switch (var_01) {
    case "chargemode":
      var_02 = "super_shutdown_bull_charge";
      break;
  }

  if(isDefined(level.awards[var_02])) {
    thread scripts\mp\awards::givemidmatchaward(var_02);
  }
}

disconnected() {
  var_00 = self.guid;
  for(var_01 = 0; var_01 < level.players.size; var_01++) {
    if(isDefined(level.players[var_01].var_A653[var_00])) {
      level.players[var_01].var_A653[var_00] = undefined;
    }

    if(isDefined(level.players[var_01].killedby[var_00])) {
      level.players[var_01].killedby[var_00] = undefined;
    }
  }
}

func_B9DF() {
  level endon("end_game");
  self endon("disconnect");
  for(;;) {
    self waittill("healed");
    thread scripts\mp\utility::giveunifiedpoints("healed");
  }
}

func_12EFE(param_00, param_01, param_02) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");
  self.var_DDC2++;
  if(scripts\mp\missions::func_9DBA(param_01.origin)) {
    self.var_DDC1++;
    if(scripts\mp\missions::func_9EBC(self.var_DDC1, 2)) {
      thread scripts\mp\awards::givemidmatchaward("mode_x_wipeout");
    }
  }

  if(!isDefined(self.var_DDC3)) {
    self.var_DDC3 = [];
  }

  if(!isDefined(self.var_DDC3[param_02])) {
    self.var_DDC3[param_02] = 1;
  } else {
    self.var_DDC3[param_02]++;
  }

  var_03 = scripts\mp\utility::getequipmenttype(param_02);
  if(isDefined(var_03) && var_03 == "lethal") {
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_grenade", undefined, 0.75);
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_amf", undefined, 0.75);
    if(self.var_DDC3[param_02] > 0 && self.var_DDC3[param_02] % 2 == 0) {
      thread scripts\mp\awards::givemidmatchaward("grenade_double");
    }
  }

  scripts\mp\utility::bufferednotify("update_rapid_kill_buffered", self.var_DDC2);
  wait(4);
  if(self.var_DDC2 > 1) {
    func_BDC2(param_00, self.var_DDC2, param_01);
  }

  self.var_DDC2 = 0;
  self.var_DDC1 = 0;
  self.var_DDC3 = undefined;
}

func_B9C5() {
  level endon("end_game");
  self endon("disconnect");
  for(;;) {
    self waittill("hijacker", var_00, var_01);
    thread scripts\mp\awards::givemidmatchaward("ss_use_enemy_dronedrop");
    var_02 = "hijacked_airdrop";
    var_03 = "ch_hijacker";
    switch (var_00) {
      case "sentry_shock":
        var_02 = "hijacked_sentry";
        break;

      case "juggernaut":
        var_02 = "hijacked_juggernaut";
        break;

      case "maniac":
        var_02 = "hijacked_maniac";
        break;

      case "juggernaut_swamp_slasher":
        var_02 = "hijacked_juggernaut_swamp_slasher";
        break;

      case "juggernaut_predator":
        var_02 = "hijacked_juggernaut_predator";
        break;

      case "juggernaut_death_mariachi":
        var_02 = "hijacked_juggernaut_death_mariachi";
        break;

      case "remote_tank":
        var_02 = "hijacked_remote_tank";
        break;

      case "emergency_airdrop":
      case "mega":
        var_02 = "hijacked_emergency_airdrop";
        var_03 = "ch_newjack";
        break;

      default:
        break;
    }

    if(isDefined(var_01)) {
      var_01 scripts\mp\hud_message::showsplash(var_02, undefined, self);
    }

    self notify("process", var_03);
  }
}

func_12EF8(param_00) {
  if(isDefined(level.var_DB50) && gettime() - level.var_DB50.starttime > 5000) {
    level.var_DB50 = undefined;
  }

  if(!isDefined(level.var_DB50) || level.var_DB50.player != param_00) {
    var_01 = spawnStruct();
    var_01.player = param_00;
    var_01.starttime = gettime();
    var_01.var_6BC5 = 1;
    level.var_DB50 = var_01;
    return;
  }

  var_01 = level.var_DB50;
  var_01.var_6BC5++;
  if(var_01.var_6BC5 == 4) {
    var_01.player thread scripts\mp\awards::givemidmatchaward("quad_feed");
    level.var_DB50 = undefined;
  }
}

events_monitorslide() {
  self endon("disconnect");
  self notify("events_monitorSlide");
  self endon("events_monitorSlide");
  self.eventswassliding = self issprintsliding();
  self.eventsslideendtime = undefined;
  for(;;) {
    events_monitorslideupdate();
    wait(0.05);
  }
}

events_monitorslideupdate() {
  if(scripts\mp\utility::isreallyalive(self)) {
    var_00 = self issprintsliding();
    if(self.eventswassliding && !var_00) {
      self.eventsslideendtime = gettime();
    }

    self.eventswassliding = var_00;
    return;
  }

  self.eventswassliding = 0;
  self.eventsslideendtime = undefined;
}

events_issliding() {
  if(self issprintsliding()) {
    return 1;
  }

  events_monitorslideupdate();
  if(isDefined(self.eventsslideendtime)) {
    if(gettime() - self.eventsslideendtime <= 150) {
      return 1;
    }
  }

  return 0;
}

events_playertracksimultaneouskill() {
  self endon("disconnect");
  self.simultaneouskill = 1;
  scripts\engine\utility::waitframe();
  self.simultaneouskill = undefined;
}