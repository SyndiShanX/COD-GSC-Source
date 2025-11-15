/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2727.gsc
***************************************/

init() {
  var_00 = [];
  var_0["dm"] = 4;
  var_0["war"] = 5;
  var_0["sd"] = 6;
  var_0["dom"] = 7;
  var_0["conf"] = 8;
  var_0["sr"] = 9;
  var_0["grind"] = 10;
  var_0["ball"] = 11;
  var_0["infect"] = 12;
  var_0["aliens"] = 13;
  var_0["gun"] = 14;
  var_0["grnd"] = 15;
  var_0["siege"] = 16;
  var_0["koth"] = 17;
  var_0["mp_zomb"] = 18;
  var_0["ctf"] = 19;
  var_0["dd"] = 20;
  var_0["tdef"] = 21;
  var_0["front"] = 22;
  var_01 = level.gametype;

  if(!isDefined(var_01))
    var_01 = getdvar("g_gametype");

  var_02 = 0;

  for(;;) {
    var_03 = tablelookupbyrow("mp\score_event_table.csv", var_02, 0);

    if(!isDefined(var_03) || var_03 == "") {
      break;
    }
    var_04 = tablelookupbyrow("mp\score_event_table.csv", var_02, var_0[var_01]);

    if(!isDefined(var_04) || var_04 == "") {
      var_2++;
      continue;
    }

    if(var_03 == "win" || var_03 == "loss" || var_03 == "tie")
      var_04 = float(var_04);
    else
      var_04 = int(var_04);

    if(var_04 != -1)
      scripts\mp\rank::registerscoreinfo(var_03, "value", var_04);

    var_05 = tablelookuprownum("mp\score_event_table.csv", 0, var_03);
    scripts\mp\rank::registerscoreinfo(var_03, "eventID", var_05);
    var_05 = tablelookupbyrow("mp\score_event_table.csv", var_02, 1);
    scripts\mp\rank::registerscoreinfo(var_03, "text", var_05);
    var_06 = tablelookuprownum("mp\splashTable.csv", 0, var_03);

    if(isDefined(var_06) && var_06 != -1)
      scripts\mp\rank::registerscoreinfo(var_03, "splashID", var_06);

    var_07 = tablelookupbyrow("mp\score_event_table.csv", var_02, 3);
    scripts\mp\rank::registerscoreinfo(var_03, "group", var_07);
    var_08 = tablelookupbyrow("mp\score_event_table.csv", var_02, 2);

    if(isDefined(var_08) && tolower(var_08) == "true")
      scripts\mp\rank::registerscoreinfo(var_03, "allowBonus", 1);

    var_2++;
  }

  level._effect["money"] = loadfx("vfx\props\cash_player_drop");
  level.numkills = 0;
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_0.func_A653 = [];
    var_0.killedby = [];
    var_0.lastkilledby = undefined;
    var_0._meth_8549 = 0;
    var_0.func_DDC2 = 0;
    var_0.func_DDC1 = 0;
    var_0.lastkilltime = 0;
    var_0.lastkilldogtime = 0;
    var_0.damagedplayers = [];
    var_00 thread func_B9C5();
    var_00 thread func_B9DF();
    var_00 thread events_monitorslide();
  }
}

damagedplayer(var_00, var_01, var_02) {
  if(var_01 < 50 && var_01 > 10) {
    thread scripts\mp\utility\game::giveunifiedpoints("damage", var_02);
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_damaged_light", undefined, 0.1);
  } else {
    thread scripts\mp\utility\game::giveunifiedpoints("heavy_damage", var_02);
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_damaged_heavy", undefined, 0.1);
  }
}

func_A652(var_00, var_01, var_02, var_03) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("killedPlayerNotify");
  self endon("killedPlayerNotify");

  if(!isDefined(self.func_A67A))
    self.func_A67A = 0;

  self.func_A67A++;

  if(var_03 == "MOD_PISTOL_BULLET" || var_03 == "MOD_RIFLE_BULLET" || var_03 == "MOD_HEAD_SHOT") {
    if(!isDefined(self.func_3247))
      self.func_3247 = 1;
    else {
      self.func_3247++;

      if(self.func_3247 >= 2) {
        if(scripts\mp\utility\game::_hasperk("passive_collat_streak")) {
          var_04 = scripts\mp\perks\weaponpassives::getpassivevalue("passive_collat_streak");
          self[[var_04]]();
        }
      }

      if(self.func_3247 == 2) {
        level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_twofer", undefined, 0.75);
        thread scripts\mp\awards::givemidmatchaward("one_shot_two_kills");
        thread scripts\mp\missions::func_D995();
        var_05 = getweaponbasename(var_02);

        if(var_05 == "iw7_penetrationrail_mp")
          thread scripts\mp\missions::func_D991("ch_sniper_ballista_collateral");
      }

      if(self.func_3247 == 3)
        level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_threefer", undefined, 0.75);
    }
  }

  waittillframeend;
  thread func_C165(var_00, var_01, var_02, var_03, self.func_A67A);
  self.func_A67A = 0;
  self.func_3247 = 0;
}

func_C165(var_00, var_01, var_02, var_03, var_04) {
  for(var_05 = 0; var_05 < var_04; var_5++) {
    self notify("got_a_kill", var_01, var_02, var_03);
    wait 0.05;
  }
}

func_A651(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = var_1.guid;
  var_07 = self.guid;
  var_08 = gettime();
  thread func_A652(var_00, var_01, var_02, var_03);
  thread func_12EFE(var_00, var_01, var_02);
  thread func_12EF8(self);
  self.lastkilltime = gettime();
  self.func_A9A4 = var_01;

  if(self.deaths > 0) {
    var_09 = self.kills / self.deaths;

    if(var_09 > 3.0)
      level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_kd_high", undefined, 0.75);
  } else if(self.kills > 5)
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_kd_high", undefined, 0.75);

  self.modifiers = [];
  level.numkills++;
  self.damagedplayers[var_06] = undefined;
  func_3E24(var_02, var_03);
  var_10 = scripts\mp\utility\game::getweapongroup(var_02);
  var_11 = scripts\mp\utility\game::getweaponrootname(var_02);

  if(!scripts\mp\utility\game::iskillstreakweapon(var_02) && !scripts\mp\utility\game::isjuggernaut() && !scripts\mp\utility\game::_hasperk("specialty_explosivebullets")) {
    if(var_02 == "none")
      return 0;

    if(var_10 == "weapon_sniper" && var_03 != "MOD_MELEE" && gettime() == var_1.attackerdata[self.guid].firsttimedamaged && !(issubstr(var_02, "iw7_longshot_mp") && scripts\mp\weapons::isaltmodeweapon(var_02))) {
      if(!isDefined(self.pers["oneShotKills"]))
        self.pers["oneShotKills"] = 1;
      else
        self.pers["oneShotKills"]++;

      self.modifiers["oneshotkill"] = 1;
      thread scripts\mp\awards::givemidmatchaward("one_shot_kill");
    }

    if(var_10 == "weapon_shotgun" && var_03 != "MOD_MELEE" && gettime() == var_1.attackerdata[self.guid].firsttimedamaged)
      self.modifiers["oneshotkill_shotgun"] = 1;

    if(var_03 == "MOD_MELEE" && var_02 != "iw7_reaperblade_mp") {
      if(var_10 != "weapon_melee")
        thread scripts\mp\awards::givemidmatchaward("gun_butt");

      if(var_11 == "iw7_fists")
        thread scripts\mp\awards::givemidmatchaward("fist_kill");
    }

    var_12 = var_01 _meth_854D();

    if(var_12 == "frag_grenade_mp" || var_12 == "cluster_grenade_mp")
      self.modifiers["cooking"] = 1;

    if(isDefined(self.assistedsuicide) && self.assistedsuicide)
      assistedsuicide(var_00, var_02, var_03, var_01);

    if(level.numkills == 1) {
      func_6DE1(var_00, var_02, var_03, var_01);

      if(level.gametype == "sd")
        scripts\mp\utility\game::setmlgannouncement(21, self.team, self getentitynumber());
    }

    if(self.pers["cur_death_streak"] > 3)
      func_4417(var_00, var_02, var_03, var_01);

    if(var_03 == "MOD_HEAD_SHOT") {
      level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_headshot", undefined, 0.75);
      func_8C9B(var_00, var_02, var_03, var_01);
    }

    if(isDefined(self.wasti) && self.wasti && gettime() - self.spawntime <= 5000)
      self.modifiers["jackintheboxkill"] = 1;

    if(!scripts\mp\utility\game::isreallyalive(self) && isDefined(self.deathtime)) {
      var_13 = gettime() - self.deathtime;

      if(var_13 < 1500 && var_13 > 0)
        func_D6F7(var_00, var_01, var_02);

      if(scripts\mp\utility\game::issimultaneouskillenabled()) {
        if(var_13 == 0 && isDefined(self.lastattacker) && self.lastattacker == var_01) {
          thread scripts\mp\awards::givemidmatchaward("simultaneous_kill", undefined, undefined, 1);
          var_01 thread scripts\mp\awards::givemidmatchaward("simultaneous_kill", undefined, undefined, 1);
          thread events_playertracksimultaneouskill();
          var_01 thread events_playertracksimultaneouskill();
        }
      }
    }

    if(level.teambased && var_08 - var_1.lastkilltime < 1500) {
      if(var_1.func_A9A4 != self)
        func_26A5(var_00, var_02, var_03, var_01);
    }

    foreach(var_16, var_15 in var_1.damagedplayers) {
      if(var_16 == self.guid) {
        continue;
      }
      if(level.teambased && var_08 - var_15 < 1750)
        func_5082(var_00, var_02, var_03, var_01);
    }

    if(isDefined(var_1.attackerposition))
      var_17 = var_1.attackerposition;
    else
      var_17 = self.origin;

    var_18 = 1;

    if(isDefined(var_05))
      var_18 = var_05 == self;

    if(var_18) {
      if(func_9F03(self, var_02, var_03, var_17, var_01))
        thread func_D63F(var_00, var_02, var_03, var_01);
      else if(func_9E84(self, var_02, var_03, var_17, var_01))
        thread func_AFEA(var_00, var_02, var_03, var_01);
    }

    if(isbackkill(self, var_01, var_03)) {
      if(var_11 == "iw7_knife")
        thread scripts\mp\awards::givemidmatchaward("backstab");

      self.modifiers["backstab"] = 1;
    }

    if(var_18) {
      if(issurvivorkill(self))
        thread givekillreward("low_health_kill", var_00, var_02, var_03, var_01, "low_health_kill");

      if(scripts\mp\utility\game::func_9EE8())
        self.modifiers["ads"] = 1;
      else if(scripts\engine\utility::isbulletdamage(var_03))
        self.modifiers["hipfire"] = 1;

      if(!self isonground())
        self.modifiers["airborne"] = 1;

      if(level.teambased) {
        foreach(var_20 in level.players) {
          if(self.team != var_20.team || self == var_20) {
            continue;
          }
          if(!scripts\mp\utility\game::isreallyalive(var_20)) {
            continue;
          }
          if(distancesquared(self.origin, var_20.origin) < 90000) {
            self.modifiers["buddy_kill"] = 1;
            break;
          }
        }
      }
    } else if(var_10 == "weapon_projectile") {
      if(isDefined(var_05) && isDefined(var_5.adsfire)) {
        if(var_5.adsfire)
          self.modifiers["ads"] = 1;
        else
          self.modifiers["hipfire"] = 1;
      }
    }

    if(!var_01 isonground() && !var_01 iswallrunning() && (!self isonground() && !self iswallrunning())) {
      if(var_18)
        thread givekillreward("air_to_air_kill", var_00, var_02, var_03, var_01, "air_to_air_kill");
    } else {
      if(var_18) {
        if(self iswallrunning())
          thread givekillreward("wallkill", var_00, var_02, var_03, var_01, "wallrun_kill");
        else if(isdeathfromabove(self, var_02, var_03, var_17, var_01))
          thread givekillreward("jumpkill", var_00, var_02, var_03, var_01, "air_kill");
        else if(events_issliding()) {
          thread givekillreward("slidekill", var_00, var_02, var_03, var_01, "slide_kill");
          self.modifiers["sliding"] = 1;
        }

        var_22 = self getstance();

        switch (var_22) {
          case "prone":
            self.modifiers["prone_kill"] = 1;
            break;
          case "crouch":
            self.modifiers["crouch_kill"] = 1;
            break;
        }
      }

      if(var_01 iswallrunning())
        thread givekillreward("killonwall", var_00, var_02, var_03, var_01, "kill_wallrunner");
      else if(isskeetshooter(self, var_02, var_03, var_17, var_01))
        thread givekillreward("killinair", var_00, var_02, var_03, var_01, "kill_jumper");
    }

    if(var_18) {
      if(scripts\mp\weapons::_meth_85BE())
        self.modifiers["clutchkill"] = 1;
    }

    if(isDefined(var_1.func_A6AB)) {
      foreach(var_26, var_24 in var_1.func_A6AB) {
        var_25 = var_26 - var_1.score;

        if(var_25 > 0 && var_25 < 100)
          func_32FA(var_00, var_01, var_02, var_03, var_01);
      }
    }

    if(var_18) {
      if(self ismantling())
        thread scripts\mp\awards::givemidmatchaward("mantle_kill");

      if(scripts\mp\weapons::isstunnedorblinded())
        thread scripts\mp\awards::givemidmatchaward("stunned_kill");

      if(isDefined(self.tookweaponfrom[var_02]) && self.tookweaponfrom[var_02] == var_01)
        thread scripts\mp\awards::givemidmatchaward("backfire");
    }

    if(isDefined(var_1.func_1117F))
      level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_semtex", undefined, 0.75);

    if(scripts\mp\weapons::func_9FA9(var_02))
      thread scripts\mp\awards::givemidmatchaward("throwingknife_kill");

    if(level.teambased) {
      var_27 = 0;

      foreach(var_29 in level.teamlist[scripts\mp\utility\game::getotherteam(self.team)]) {
        if(var_29.score > 0) {
          var_27 = 1;
          break;
        }
      }

      if(var_27) {
        var_31 = scripts\engine\utility::array_sort_with_func(level.teamlist[scripts\mp\utility\game::getotherteam(self.team)], ::func_9CAE);

        if(isDefined(var_31[0]) && var_01 == var_31[0])
          thread scripts\mp\awards::givemidmatchaward("first_place_kill");
      }
    } else {
      var_27 = 0;

      foreach(var_29 in level.players) {
        if(var_29.score > 0) {
          var_27 = 1;
          break;
        }
      }

      if(var_27) {
        var_31 = scripts\engine\utility::array_sort_with_func(level.players, ::func_9CAE);

        if(isDefined(var_31[0]) && var_01 == var_31[0]) {
          thread scripts\mp\awards::givemidmatchaward("first_place_kill");

          if(level.gametype == "gun" && var_03 == "MOD_MELEE")
            thread scripts\mp\awards::givemidmatchaward("mode_gun_melee_1st_place");
        }
      }
    }

    var_34 = self.pers["cur_kill_streak"] + 1;

    if(!(var_34 % 5)) {
      if(!isDefined(self.lastkillsplash) || var_34 != self.lastkillsplash) {
        thread scripts\mp\utility\game::teamplayercardsplash("callout_kill_streaking", self, undefined, var_34);
        self.lastkillsplash = var_34;
      }

      if(var_34 <= 30)
        thread scripts\mp\awards::givemidmatchaward("streak_" + var_34);
    } else if(!(var_34 % 7))
      scripts\mp\utility\game::setmlgannouncement(17, self.team, self getentitynumber(), 7);

    if(var_34 > 30)
      thread scripts\mp\awards::givemidmatchaward("streak_max");

    if(isDefined(var_05) && scripts\mp\utility\game::istrue(var_5.func_9F07) && var_03 == "MOD_IMPACT" && !scripts\mp\weapons::func_9FA9(var_02))
      thread scripts\mp\awards::givemidmatchaward("item_impact");

    if(scripts\mp\utility\game::getgametypenumlives() >= 1) {
      if(var_1.pers["lives"] == 0)
        thread scripts\mp\awards::givemidmatchaward("mode_x_eliminate");

      var_35 = scripts\mp\utility\game::getpotentiallivingplayers();

      if(var_35.size == 1 && var_35[0] == self)
        thread scripts\mp\awards::givemidmatchaward("mode_x_last_alive");
    }

    if(var_02 == "groundpound_mp")
      level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_pound", undefined, 0.75);

    func_3E50(var_01, var_05, var_02, var_03);
    func_3E51(var_01, var_02, var_03);
    thread func_3E27(var_00, var_01, var_02, var_03, var_04);
  }

  if(!isDefined(self.func_A653[var_06]))
    self.func_A653[var_06] = 0;

  if(!isDefined(var_1.killedby[var_07]))
    var_1.killedby[var_07] = 0;

  self.func_A653[var_06]++;
  var_1.killedby[var_07]++;
  var_1.lastkilledby = self;
  scripts\mp\utility\game::bufferednotify("kill_event_buffered", var_01, var_02, var_03, self.modifiers);
}

func_3E24(var_00, var_01) {
  var_02 = scripts\mp\utility\game::iskillstreakweapon(var_00);

  if(var_02) {
    var_03 = level.killstreakweildweapons[var_00];

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
        thread scripts\mp\utility\game::giveunifiedpoints("killstreak_full_score", var_00);
        break;
    }

    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_killstreak", undefined, 0.75);
  }
}

func_3E50(var_00, var_01, var_02, var_03) {
  var_04 = scripts\mp\supers::issuperinuse();
  var_05 = scripts\mp\supers::getcurrentsuperref();
  var_06 = scripts\mp\supers::getcurrentsuper();
  var_07 = scripts\mp\utility\game::issuperweapon(var_02);
  var_08 = undefined;

  if(!isDefined(var_05)) {
    return;
  }
  if(var_07 && var_02 != "iw7_reaperblade_mp") {
    thread func_A655(var_00, var_01, var_02, var_03);

    if(var_03 != "MOD_MELEE")
      scripts\mp\utility\game::bufferednotify("super_kill_buffered");

    var_09 = getweaponbasename(var_02);

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
    } else if(var_09 == "iw7_armmgs_mp")
      var_08 = "super_arm2_kill";

    if(isDefined(var_08))
      thread scripts\mp\utility\game::giveunifiedpoints(var_08);
  }

  var_10 = 0;

  if(isDefined(var_05)) {
    switch (var_05) {
      case "super_amplify":
        if(var_04 == 1) {
          var_08 = "super_combatfocus_kill";
          var_10 = 1;
        }

        break;
      case "super_overdrive":
        if(var_04 == 1) {
          var_08 = "super_overdrive_kill";
          var_10 = 1;
        }

        break;
      case "super_chargemode":
        if(var_04 == 1) {
          var_08 = "super_bullcharge_kill";
          level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_charge", undefined, 0.75);
          var_10 = 1;
        }

        break;
      case "super_armorup":
        if(var_04 == 1) {
          var_08 = "super_armorup_kill";
          level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_armor", undefined, 0.75);
          var_10 = 1;
        }

        break;
      case "super_reaper":
        if(var_04 == 1) {
          var_08 = "super_reaper_kill";
          level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_reaper", undefined, 0.75);
          var_10 = 1;
        }

        break;
      case "super_rewind":
        if(var_04 == 1 || isDefined(var_6.func_A986) && gettime() < var_6.func_A986 + 3000) {
          var_08 = "super_rewind_kill";
          var_10 = 1;
        }

        break;
      case "super_phaseshift":
        if(var_04 == 1 || isDefined(var_6.func_A986) && gettime() < var_6.func_A986 + 3000) {
          var_08 = "super_phaseshift_kill";
          level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_shift", undefined, 0.75);
          var_10 = 1;
        }

        break;
      case "super_teleport":
        if(var_04 == 1 || isDefined(var_6.func_A986) && gettime() < var_6.func_A986 + 3000) {
          var_08 = "super_teleport_kill";
          var_10 = 1;
        }

        break;
      case "super_microturret":
        if(var_02 == "micro_turret_gun_mp") {
          var_08 = "super_microturret_kill";
          level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_turret_kill", undefined, 0.75);
          var_10 = 1;
        }

        break;
      case "super_invisible":
        if(var_04 == 1 || isDefined(var_6.func_A986) && gettime() < var_6.func_A986 + 2000) {
          var_08 = "super_invisible_kill";
          level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_stealth", undefined, 0.75);
          var_10 = 1;
        }

        break;
      case "super_visionpulse":
        if(scripts\mp\supers\super_visionpulse::func_9EF9(var_00)) {
          var_08 = "super_wallhack_kill";
          var_10 = 1;
        }

        break;
      case "super_kineticpulse":
        if(scripts\mp\equipment\kinetic_pulse::isplayertaggedbykineticpulse(var_00)) {
          var_08 = "super_kineticpulse_kill";
          var_10 = 1;
        }

        break;
      default:
        break;
    }

    if(var_10) {
      thread superkill(var_05, var_03);
      scripts\mp\supers::combatrecordsuperkill(var_05);

      if(isDefined(var_08))
        thread scripts\mp\utility\game::giveunifiedpoints(var_08);

      scripts\mp\utility\game::bufferednotify("super_kill_buffered");
    }
  }
}

func_3E51(var_00, var_01, var_02) {
  var_03 = var_00 scripts\mp\supers::issuperinuse();
  var_04 = var_00 scripts\mp\supers::getcurrentsuperref();
  var_05 = var_00 scripts\mp\supers::getcurrentsuper();

  if(!isDefined(var_04)) {
    return;
  }
  switch (var_04) {
    case "super_armorup":
      if(var_03 == 1 || isDefined(var_5.func_A986) && gettime() - var_5.func_A986 < 1000) {
        if(isDefined(var_0.func_219F) && scripts\engine\utility::array_contains(var_0.func_219F, self))
          thread supershutdown(var_00);
      }

      break;
    case "super_visionpulse":
      if(var_00 scripts\mp\supers\super_visionpulse::func_9EF9(self))
        thread supershutdown(var_00);

      break;
    case "super_phaseshift":
      if(var_03 == 1 || isDefined(var_5.func_A986) && gettime() - var_5.func_A986 < 2000)
        thread supershutdown(var_00);

      break;
    case "super_teleport":
      if(var_03 == 1 || isDefined(var_5.func_A986) && gettime() - var_5.func_A986 < 2000)
        thread supershutdown(var_00);

      break;
    case "super_invisible":
      if(var_03 == 1 || isDefined(var_5.func_A986) && gettime() - var_5.func_A986 < 2000)
        thread supershutdown(var_00);

      break;
    case "super_kineticpulse":
      if(var_00 scripts\mp\equipment\kinetic_pulse::isplayertaggedbykineticpulse(self))
        thread supershutdown(var_00);

      break;
    case "super_rewind":
      if(var_03 == 1 || isDefined(var_5.func_A986) && gettime() - var_5.func_A986 < 2000)
        thread supershutdown(var_00);

      break;
    default:
      if(var_03 == 1)
        thread supershutdown(var_00);

      break;
  }
}

func_A655(var_00, var_01, var_02, var_03) {
  var_04 = scripts\mp\supers::_meth_8189(var_02);
  var_05 = self.func_DDC3[var_02];

  if(isDefined(var_05) && var_05 > 0 && var_05 % 2 == 0)
    superkill(var_04, var_03);
  else {
    var_06 = scripts\mp\supers::getcurrentsuper();
    var_6.numkills++;
  }

  scripts\mp\missions::func_12F33(var_02, var_01);
  scripts\mp\supers::combatrecordsuperkill(var_04);
}

superkill(var_00, var_01) {
  var_02 = scripts\mp\supers::getrootsuperref(var_00);
  var_03 = "super_kill_" + var_02;

  switch (var_03) {
    case "super_kill_chargemode":
      var_03 = "super_kill_bull_charge";
      break;
  }

  if(isDefined(level.awards[var_03]))
    thread scripts\mp\awards::givemidmatchaward(var_03);

  var_04 = scripts\mp\supers::getcurrentsuper();
  var_4.numkills++;
  scripts\mp\missions::updatesuperkills(var_00, var_01, var_4.numkills);
  self.modifiers["super_kill_medal"] = var_00;
}

killedkillstreak(var_00, var_01) {
  if(var_00 != "precision_airstrike") {
    var_02 = "kill_ss_" + var_00;
    var_01 thread scripts\mp\awards::givemidmatchaward(var_02);
  }

  var_1.func_A6B4[var_1.func_A6B4.size] = var_00;
  level thread scripts\mp\battlechatter_mp::saytoself(var_01, "plr_killstreak_destroy", undefined, 0.75);
}

func_9CAE(var_00, var_01) {
  return var_0.score > var_1.score;
}

func_9E84(var_00, var_01, var_02, var_03, var_04) {
  if(isalive(var_00) && !var_00 scripts\mp\utility\game::isusingremote() && (var_02 == "MOD_RIFLE_BULLET" || var_02 == "MOD_PISTOL_BULLET" || var_02 == "MOD_HEAD_SHOT") && !scripts\mp\utility\game::iskillstreakweapon(var_01) && !isDefined(var_0.assistedsuicide)) {
    var_05 = scripts\mp\utility\game::getweapongroup(var_01);

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

    if(distancesquared(var_03, var_4.origin) > var_07)
      return 1;
  }

  return 0;
}

func_9F03(var_00, var_01, var_02, var_03, var_04) {
  if(isalive(var_00) && !var_00 scripts\mp\utility\game::isusingremote() && (var_02 == "MOD_RIFLE_BULLET" || var_02 == "MOD_PISTOL_BULLET" || var_02 == "MOD_HEAD_SHOT") && !scripts\mp\utility\game::iskillstreakweapon(var_01) && !isDefined(var_0.assistedsuicide)) {
    var_05 = 9216;

    if(distancesquared(var_03, var_4.origin) < var_05)
      return 1;
  }

  return 0;
}

isdeathfromabove(var_00, var_01, var_02, var_03, var_04) {
  if(isalive(var_00) && var_00 isjumping() && scripts\engine\utility::isbulletdamage(var_02)) {
    var_05 = var_0.origin[2] - var_4.origin[2];
    return var_05 > 60;
  }

  return 0;
}

isskeetshooter(var_00, var_01, var_02, var_03, var_04) {
  return isalive(var_00) && var_04 isjumping() && scripts\engine\utility::isbulletdamage(var_02);
}

isbackkill(var_00, var_01, var_02) {
  if(!isplayer(var_00) || !isplayer(var_01))
    return 0;

  if(var_02 != "MOD_RIFLE_BULLET" && var_02 != "MOD_PISTOL_BULLET" && var_02 != "MOD_MELEE" && var_02 != "MOD_HEAD_SHOT")
    return 0;

  var_03 = var_01 getplayerangles();
  var_04 = var_00 getplayerangles();
  var_05 = angleclamp180(var_3[1] - var_4[1]);

  if(abs(var_05) < 80)
    return 1;

  return 0;
}

issurvivorkill(var_00) {
  return var_0.health > 0 && var_0.health < var_0.maxhealth * 0.2;
}

func_3E27(var_00, var_01, var_02, var_03, var_04) {
  if(isDefined(self.lastkilledby) && self.lastkilledby == var_01) {
    self.lastkilledby = undefined;
    func_E48D(var_00, var_02);
  }
}

givekillreward(var_00, var_01, var_02, var_03, var_04, var_05) {
  self.modifiers[var_00] = 1;

  if(isDefined(var_05))
    thread scripts\mp\awards::givemidmatchaward(var_05);
  else
    thread scripts\mp\utility\game::giveunifiedpoints(var_00, var_02);
}

proximityassist(var_00) {
  self.modifiers["proximityAssist"] = 1;
  thread scripts\mp\utility\game::giveunifiedpoints("proximityassist");
}

proximitykill(var_00) {
  self.modifiers["proximityKill"] = 1;
  thread scripts\mp\utility\game::giveunifiedpoints("proximitykill");
}

func_AFEA(var_00, var_01, var_02, var_03) {
  self.modifiers["longshot"] = 1;
  thread scripts\mp\matchdata::loginitialstats(var_00, "longshot");
  thread scripts\mp\awards::givemidmatchaward("longshot");
}

func_D63F(var_00, var_01, var_02, var_03) {
  self.modifiers["pointblank"] = 1;
  thread scripts\mp\matchdata::loginitialstats(var_00, "pointblank");
  thread scripts\mp\awards::givemidmatchaward("pointblank");
}

func_8C9B(var_00, var_01, var_02, var_03) {
  self.modifiers["headshot"] = 1;
  thread scripts\mp\matchdata::loginitialstats(var_00, "headshot");
  thread scripts\mp\awards::givemidmatchaward("headshot");
}

func_26A5(var_00, var_01, var_02, var_03) {
  self.modifiers["avenger"] = 1;
  thread scripts\mp\matchdata::loginitialstats(var_00, "avenger");
  thread scripts\mp\awards::givemidmatchaward("avenger");
}

assistedsuicide(var_00, var_01, var_02, var_03) {
  self.modifiers["assistedsuicide"] = 1;
  thread scripts\mp\utility\game::giveunifiedpoints("assistedsuicide", var_01);
  thread scripts\mp\matchdata::loginitialstats(var_00, "assistedsuicide");
  thread scripts\mp\awards::givemidmatchaward("assistedsuicide");
}

func_5082(var_00, var_01, var_02, var_03) {
  self.modifiers["defender"] = 1;
  thread scripts\mp\matchdata::loginitialstats(var_00, "defender");
  thread scripts\mp\awards::givemidmatchaward("save_teammate");
}

func_D6F7(var_00, var_01, var_02) {
  self.modifiers["posthumous"] = 1;
  thread scripts\mp\matchdata::loginitialstats(var_00, "posthumous");
  thread scripts\mp\awards::givemidmatchaward("posthumous");
}

func_E48D(var_00, var_01, var_02) {
  self.modifiers["revenge"] = 1;
  thread scripts\mp\matchdata::loginitialstats(var_00, "revenge");
  thread scripts\mp\awards::givemidmatchaward("revenge");
}

func_BDC2(var_00, var_01, var_02) {
  var_03 = undefined;

  switch (var_01) {
    case 2:
      var_03 = "double";
      break;
    case 3:
      var_03 = "triple";
      thread scripts\mp\utility\game::teamplayercardsplash("callout_3xkill", self);
      break;
    case 4:
      var_03 = "four";
      thread scripts\mp\utility\game::teamplayercardsplash("callout_4xkill", self);
      scripts\mp\utility\game::setmlgannouncement(18, self.team, self getentitynumber(), 4);
      break;
    case 5:
      var_03 = "five";
      thread scripts\mp\utility\game::teamplayercardsplash("callout_5xkill", self);
      break;
    case 6:
      var_03 = "six";
      thread scripts\mp\utility\game::teamplayercardsplash("callout_6xkill", self);
      break;
    case 7:
      var_03 = "seven";
      thread scripts\mp\utility\game::teamplayercardsplash("callout_7xkill", self);
      break;
    case 8:
      var_03 = "eight";
      thread scripts\mp\utility\game::teamplayercardsplash("callout_8xkill", self);
      break;
    default:
      var_03 = "multi";
      thread scripts\mp\utility\game::teamplayercardsplash("callout_9xkill", self);
      break;
  }

  thread scripts\mp\matchdata::func_AFCB(var_00, var_01);

  if(isDefined(var_03))
    thread scripts\mp\awards::givemidmatchaward(var_03);
}

func_6DE1(var_00, var_01, var_02, var_03) {
  self.modifiers["firstblood"] = 1;
  thread scripts\mp\matchdata::loginitialstats(var_00, "firstblood");
  thread scripts\mp\utility\game::teamplayercardsplash("callout_firstblood", self);
  scripts\mp\missions::processchallenge("ch_bornready");
  thread scripts\mp\awards::givemidmatchaward("firstblood");
}

func_13D8C(var_00) {}

func_32FA(var_00, var_01, var_02, var_03, var_02) {
  self.modifiers["buzzkill"] = var_2.pers["cur_kill_streak"];
  thread scripts\mp\matchdata::loginitialstats(var_01, "buzzkill");
  thread scripts\mp\awards::givemidmatchaward("buzzkill");
}

func_4417(var_00, var_01, var_02, var_03) {
  self.modifiers["comeback"] = 1;
  thread scripts\mp\matchdata::loginitialstats(var_00, "comeback");
  thread scripts\mp\awards::givemidmatchaward("comeback");
}

supershutdown(var_00) {
  var_01 = scripts\mp\supers::getrootsuperref(var_0.super.staticdata.ref);
  self.modifiers["superShutdown"] = var_0.super.staticdata.ref;
  var_02 = "super_shutdown_" + var_01;

  switch (var_01) {
    case "chargemode":
      var_02 = "super_shutdown_bull_charge";
      break;
  }

  if(isDefined(level.awards[var_02]))
    thread scripts\mp\awards::givemidmatchaward(var_02);
}

disconnected() {
  var_00 = self.guid;

  for(var_01 = 0; var_01 < level.players.size; var_1++) {
    if(isDefined(level.players[var_01].func_A653[var_00]))
      level.players[var_01].func_A653[var_00] = undefined;

    if(isDefined(level.players[var_01].killedby[var_00]))
      level.players[var_01].killedby[var_00] = undefined;
  }
}

func_B9DF() {
  level endon("end_game");
  self endon("disconnect");

  for(;;) {
    self waittill("healed");
    thread scripts\mp\utility\game::giveunifiedpoints("healed");
  }
}

func_12EFE(var_00, var_01, var_02) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");
  self.func_DDC2++;

  if(scripts\mp\missions::func_9DBA(var_1.origin)) {
    self.func_DDC1++;

    if(scripts\mp\missions::func_9EBC(self.func_DDC1, 2))
      thread scripts\mp\awards::givemidmatchaward("mode_x_wipeout");
  }

  if(!isDefined(self.func_DDC3))
    self.func_DDC3 = [];

  if(!isDefined(self.func_DDC3[var_02]))
    self.func_DDC3[var_02] = 1;
  else
    self.func_DDC3[var_02]++;

  var_03 = scripts\mp\utility\game::getequipmenttype(var_02);

  if(isDefined(var_03) && var_03 == "lethal") {
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_grenade", undefined, 0.75);
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_amf", undefined, 0.75);

    if(self.func_DDC3[var_02] > 0 && self.func_DDC3[var_02] % 2 == 0)
      thread scripts\mp\awards::givemidmatchaward("grenade_double");
  }

  scripts\mp\utility\game::bufferednotify("update_rapid_kill_buffered", self.func_DDC2);
  wait 4.0;

  if(self.func_DDC2 > 1)
    func_BDC2(var_00, self.func_DDC2, var_01);

  self.func_DDC2 = 0;
  self.func_DDC1 = 0;
  self.func_DDC3 = undefined;
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

    if(isDefined(var_01))
      var_01 scripts\mp\hud_message::showsplash(var_02, undefined, self);

    self notify("process", var_03);
  }
}

func_12EF8(var_00) {
  if(isDefined(level.func_DB50) && gettime() - level.func_DB50.starttime > 5000)
    level.func_DB50 = undefined;

  if(!isDefined(level.func_DB50) || level.func_DB50.player != var_00) {
    var_01 = spawnStruct();
    var_1.player = var_00;
    var_1.starttime = gettime();
    var_1.func_6BC5 = 1;
    level.func_DB50 = var_01;
  } else {
    var_01 = level.func_DB50;
    var_1.func_6BC5++;

    if(var_1.func_6BC5 == 4) {
      var_1.player thread scripts\mp\awards::givemidmatchaward("quad_feed");
      level.func_DB50 = undefined;
    }
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
    wait 0.05;
  }
}

events_monitorslideupdate() {
  if(scripts\mp\utility\game::isreallyalive(self)) {
    var_00 = self issprintsliding();

    if(self.eventswassliding && !var_00)
      self.eventsslideendtime = gettime();

    self.eventswassliding = var_00;
  } else {
    self.eventswassliding = 0;
    self.eventsslideendtime = undefined;
  }
}

events_issliding() {
  if(self issprintsliding())
    return 1;

  events_monitorslideupdate();

  if(isDefined(self.eventsslideendtime)) {
    if(gettime() - self.eventsslideendtime <= 150)
      return 1;
  }

  return 0;
}

events_playertracksimultaneouskill() {
  self endon("disconnect");
  self.simultaneouskill = 1;
  scripts\engine\utility::waitframe();
  self.simultaneouskill = undefined;
}