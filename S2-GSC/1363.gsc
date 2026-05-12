/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1363.gsc
*********************************************/

lib_0553::func_1E6E(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(isDefined(level.zmb_player_last_stand_protection)) {
    if([[level.zmb_player_last_stand_protection]](self)) {
      self.var_00BC = 1;
      return;
    }
  }

  self notify("enter_last_stand");
  lib_0553::func_7BEA(param_00, param_01, param_02, param_03, param_04, param_05, param_06);
  var_09 = lib_0547::func_AC4B(self.var_0116, "last_stand");
  var_09 lib_0547::func_AC47(self);
  var_09 lib_0547::func_AC4D();
  if(level.var_32CF < level.var_6082) {
    self.var_32CE = level.var_32CF;
    level.var_32CF = level.var_32CF + 1;
    setmatchdata("down_count", maps\mp\_utility::func_2315(level.var_32CF));
    setmatchdata("downs", self.var_32CE, "round_downed", maps\mp\_utility::func_2315(level.var_A980));
    setmatchdata("downs", self.var_32CE, "player_index", maps\mp\_utility::func_2314(self.var_2418));
    var_0A = maps\mp\_utility::func_467B();
    setmatchdata("downs", self.var_32CE, "down_time", maps\mp\_utility::func_2315(var_0A));
    setmatchdata("downs", self.var_32CE, "down_pos", 0, maps\mp\_utility::func_2315(int(self.var_0116[0])));
    setmatchdata("downs", self.var_32CE, "down_pos", 1, maps\mp\_utility::func_2315(int(self.var_0116[1])));
    setmatchdata("downs", self.var_32CE, "down_pos", 2, maps\mp\_utility::func_2315(int(self.var_0116[2])));
    if(!common_scripts\utility::func_562E(level.door_data_out_of_date)) {
      setmatchdata("downs", self.var_32CE, "down_zone_index", lib_0547::getplayerddlzonename());
    }

    if(function_012A("MeansOfDeath", param_03)) {
      setmatchdata("downs", self.var_32CE, "means_of_death", param_03);
    }

    if(isDefined(param_01.var_0A4B) && function_012A("ZombieType", param_01.var_0A4B)) {
      setmatchdata("downs", self.var_32CE, "attacker", param_01.var_0A4B);
    }
  } else {
    self.var_32CE = level.var_6082;
  }

  var_0B = self getcurrentprimaryweapon();
  if(maps\mp\_utility::func_4431(var_0B) == self.var_76D8) {
    self.var_A9BA[self.var_76D9].var_32D0 = self.var_A9BA[self.var_76D9].var_32D0 + 1;
  } else {
    var_0C = lib_0547::func_4837(self, var_0B);
    if(var_0C == -1) {
      self.var_76D8 = "";
      self.var_76D9 = -1;
    } else {
      self.var_A9BA[var_0C].var_32D0 = self.var_A9BA[var_0C].var_32D0 + 1;
      self.var_76D8 = maps\mp\_utility::func_4431(var_0B);
      self.var_76D9 = var_0C;
    }
  }

  if(laststandentergameshouldend(self, param_04, 1)) {
    self.var_A219 = 1;
    if(self.var_32CE < level.var_6082) {
      setmatchdata("downs", self.var_32CE, "died", 1);
    }

    self.var_6881++;
    maps\mp\_utility::func_0728();
    lib_0553::func_AC1F(undefined, param_04);
    return;
  }

  if(!lib_0553::func_60AD(self)) {
    self.var_A219 = 0;
    if(self.var_32CE < level.var_6082) {
      setmatchdata("downs", self.var_32CE, "died", 1);
    }

    self.var_6881++;
    maps\mp\_utility::func_0728();
    if(level.var_744A.size < 2) {
      lib_0553::func_AC1F(undefined, param_04);
    }

    return;
  }

  self notify("begin_last_stand");
  self.var_5378 = 1;
  self.var_00E8 = 1;
  lib_0547::func_8623(1);
  self.var_00BC = 1;
  self method_812A(0);
  self.var_6882++;
  if(lib_0586::func_72C3()) {
    lib_0586::func_0790("blimp_battery_zm");
    lib_0586::func_078E(self.var_6A54);
    self allowjump(1);
  }

  var_0D = self getweaponslist("combat_role");
  var_0E = self rolegetpower();
  foreach(var_10 in var_0D) {
    if(var_0E > 0) {
      self roleapplypowerchange(-1 * var_0E);
    }

    lib_0533::func_2F9E(var_10);
  }

  lib_0547::func_7ACD();
  if(isDefined(level.var_5F20)) {
    [[level.var_5F20]]();
  }

  self.var_479D = lib_0553::func_AC5F();
  lib_0553::func_806A();
  lib_0553::func_47AC(self.var_479D, 1);
  setlaststandweaponammo(self.var_479D);
  thread lib_0547::func_AC16(0, "laststand");
  common_scripts\utility::func_0601();
  self method_8326();
  common_scripts\utility::func_0600();
  if(isDefined(param_04) && param_04 == "MOD_SUICIDE") {
    self method_8555();
  }

  thread lib_0553::func_5BF1(param_01, param_02, param_05, param_08, param_04);
  if(!lib_0553::func_4B87()) {
    thread lib_0576::func_83C6();
  }

  thread lib_056A::func_5BFE();
  if(isDefined(level.var_5BEB)) {
    self thread[[level.var_5BEB]]();
  }

  if(maps\mp\agents\_agent_utility::func_45C7(self) > 0) {
    thread lib_0553::func_9E18(param_04);
  }

  level.var_400E[level.var_400E.size] = ["assassin_set 3 -1", self];
  level.var_400E[level.var_400E.size] = ["survivalist_set 0 -1", self];
  level.var_400E[level.var_400E.size] = ["mountain_man_set 1 -1", self];
  level.var_400E[level.var_400E.size] = ["mountain_man_set 3 -1", self];
  level.var_400E[level.var_400E.size] = ["bat_elite_set 3 -1", self];
}

lib_0553::func_9E18(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  while(maps\mp\agents\_agent_utility::func_45C7(self) > 0) {
    wait 0.05;
  }

  if(lib_0553::func_3FD3(self, 1)) {
    thread lib_0553::func_5A4D(param_00);
  }
}

lib_0553::func_5A4D(param_00) {
  level endon("game_ended");
  self.var_A219 = 1;
  if(self.var_32CE < level.var_6082) {
    setmatchdata("downs", self.var_32CE, "died", 1);
  }

  self.var_6881++;
  maps\mp\_utility::func_0728();
  lib_0553::func_AC1F(undefined, param_00);
}

lib_0553::func_806A(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  if(lib_057A::func_A260()) {
    lib_057A::func_259D();
  }

  self.var_5B98 = self getcurrentprimaryweapon();
  var_01 = self getweaponslistprimaries();
  if(!isDefined(self.var_5B98) || self.var_5B98 == "none" || lib_0547::func_585B(self.var_5B98) || !lib_0547::func_5836(self.var_5B98)) {
    self.var_5B98 = "none";
    foreach(var_03 in var_01) {
      var_04 = getweapondisplayname(var_03);
      if(lib_0547::func_5836(var_04)) {
        self.var_5B98 = lib_0586::func_0632(var_03);
        break;
      }
    }
  }

  self.var_7707 = [];
  foreach(var_03 in var_01) {
    var_07 = getweapondisplayname(var_03);
    if(lib_0547::func_5836(var_07)) {
      self.var_7707[self.var_7707.size] = lib_0586::func_0632(var_03);
    }
  }

  if(self.var_5B98 == "search_dstry_bomb_defuse_mp" && isDefined(self.var_5BC5) && isDefined(common_scripts\utility::func_0F7E(self.var_7707, self.var_5BC5))) {
    self.var_5B98 = self.var_5BC5;
  }

  if(issubstr(self.var_5B98, "killstreak")) {
    self.var_5B98 = self.var_7707[0];
  }

  foreach(var_03 in self.var_7707) {
    self.var_7708[var_03]["ammoInfo"] = lib_0586::func_4129(var_03);
  }

  self.var_9A8A = self.var_5B98;
  self.var_9A8B = lib_0547::func_4747(self, self.var_9A8A);
  if(issubstr(self.var_9A8A, "titan")) {
    self.var_9A8B = 0;
  }

  foreach(var_0C in self.var_7707) {
    if(!issubstr(var_0C, "titan")) {
      if(param_00) {
        lib_0586::func_0790(var_0C);
      }

      var_0D = lib_0547::func_4747(self, var_0C);
      if(var_0D > self.var_9A8B) {
        self.var_9A8A = var_0C;
        self.var_9A8B = var_0D;
      }
    }
  }
}

lib_0553::func_7B86() {
  foreach(var_01 in self.var_7707) {
    self.var_7708[var_01]["fillMax"] = 1;
  }
}

lib_0553::func_AC5F() {
  var_00 = self;
  var_01 = ["m1911_pap_zm", "luger_pap_zm", "m712_pap_zm", "m712_zm", "luger_auto_zm", "m1911_zm", "luger_zm"];
  var_02 = undefined;
  foreach(var_04 in var_00 getweaponslistprimaries()) {
    var_05 = var_00 lib_0586::func_0632(var_04);
    var_06 = lib_0547::func_AAF9(var_05);
    if(var_06 == "none" || function_01AA(var_06) != "pistol") {
      continue;
    }

    var_02 = var_05;
    if(lib_0547::func_5868(var_05)) {
      break;
    }
  }

  if(!isDefined(var_02)) {
    var_08 = var_01[var_01.size - 1];
    var_02 = maps\mp\zombies\_zombies_magicbox::func_454B(self, var_08);
  }

  if(lib_0553::func_4B87()) {
    var_02 = maps\mp\zombies\_zombies_magicbox::func_454B(self, "m1911_zm");
    var_09 = lib_0586::func_078B(var_02);
    if(isDefined(var_09)) {
      return var_09;
    } else {
      return "m1911_pap_zm";
    }
  }

  for(var_0A = 0; var_0A < var_02.size; var_0A++) {
    if(lib_0547::func_73F9(self, var_02[var_0A], 1, 1, 0)) {
      var_0B = lib_0586::func_078A(var_02[var_0A]);
      if(isDefined(var_0B)) {
        var_03 = lib_0586::func_0632(var_0B);
        break;
      }
    }
  }

  return var_03;
}

laststandentergameshouldend(param_00, param_01, param_02) {
  if(level.var_744A.size <= 1) {
    if(param_00 lib_0553::func_4B87()) {
      return 0;
    }

    if(param_00 lib_0547::func_73BF()) {
      return 0;
    }

    if(isDefined(param_01) && param_01 == "MOD_SUICIDE") {
      return 1;
    }
  }

  if(lib_0547::func_0F51(param_00, 1)) {
    return 0;
  } else {
    if(isDefined(param_02) && param_02 && lib_0553::func_0F50(param_00)) {
      return 0;
    }

    if(param_00 lib_0547::func_73BF()) {
      return 0;
    }
  }

  param_00.var_2AB8 = gettime();
  return 1;
}

lib_0553::func_3FD3(param_00, param_01, param_02) {
  if(level.var_744A.size <= 1) {
    if(lib_0547::func_577E(param_00) && param_00 lib_0553::func_4B87()) {
      return 0;
    }

    if(lib_0547::func_577A(param_00, 1)) {
      return 0;
    }

    if(isDefined(param_01) && param_01 == "MOD_SUICIDE") {
      return 1;
    }
  }

  if(lib_0547::func_0F51(param_00, 1)) {
    return 0;
  } else if(isDefined(param_02) && param_02 && lib_0553::func_0F50(param_00)) {
    return 0;
  }

  param_00.var_2AB8 = gettime();
  return 1;
}

lib_0553::func_0F50(param_00) {
  var_01 = maps\mp\agents\_agent_utility::func_43FD("all");
  foreach(var_03 in var_01) {
    if(!isalliedsentient(var_03, param_00)) {
      continue;
    }

    if(isalliedsentient(var_03, param_00) && common_scripts\utility::func_562E(var_03.shouldnotpreventlaststand)) {
      continue;
    }

    if(lib_0547::func_577E(var_03)) {
      continue;
    }

    return 1;
  }

  return 0;
}

lib_0553::func_7B38() {
  foreach(var_01 in level.var_744A) {
    setmatchdata("players", var_01.var_2418, "end_total_xp", var_01.var_AB46["xp"]);
    setmatchdata("players", var_01.var_2418, "end_prestige", 0);
    setmatchdata("players", var_01.var_2418, "end_rank", var_01.var_AB46["rank"]);
    setmatchdata("players", var_01.var_2418, "end_xp", var_01.var_AB46["xp"] - var_01.var_AB46["totalXP"]);
    var_02 = lib_0547::func_4745(var_01, "totalTimePlayed") + var_01.var_9A06["total"];
    var_03 = lib_0547::func_4745(var_01, "totalGames");
    setmatchdata("players", var_01.var_2418, "end_total_time_played", var_02);
    setmatchdata("players", var_01.var_2418, "end_zm_games_played", var_03 + 1);
    var_04 = lib_0547::func_4745(var_01, "totalHeadshots") + var_01.var_4BF7;
    var_05 = lib_0547::func_4745(var_01, "totalKills") + var_01.var_00E3;
    var_06 = lib_0547::func_4745(var_01, "totalRevives") + var_01.var_0021;
    var_07 = lib_0547::func_4745(var_01, "totalMoneyEarned") + var_01.var_62D7;
    var_08 = lib_0547::func_4745(var_01, "totalRounds") + level.var_A980;
    setmatchdata("players", var_01.var_2418, "end_lifetime_headshots", var_04);
    setmatchdata("players", var_01.var_2418, "end_lifetime_kills", var_05);
    setmatchdata("players", var_01.var_2418, "end_lifetime_revives", var_06);
    setmatchdata("players", var_01.var_2418, "end_lifetime_score", var_07);
    setmatchdata("players", var_01.var_2418, "end_lifetime_waves", var_08);
    setmatchdata("players", var_01.var_2418, "play_time", var_01.var_9A06["total"]);
    if(var_01.var_32CE < level.var_6082) {
      setmatchdata("downs", var_01.var_32CE, "died", 1);
    }
  }
}

lib_0553::func_AC1F(param_00, param_01, param_02) {
  if(!common_scripts\utility::func_562E(param_02) && !lib_0553::func_3FD3(self, param_01)) {
    return 0;
  }

  if(game["state"] == "postgame" || level.var_3F9D) {
    return;
  }

  lib_0553::func_7B38();
  level.var_3B5C = level.var_3772;
  if(!isDefined(param_00)) {
    param_00 = "survivors_eliminated";
  }

  if(common_scripts\utility::func_562E(level.iszombiesshotgun)) {
    var_03 = common_scripts\utility::func_562E(level.zmb_shotgun_game_won);
  } else {
    var_03 = isDefined(param_01) && param_01 == "zombies_completed";
  }

  if(var_03) {
    level.finalkillcam_winnter = level.var_746E;
    if(!function_0371()) {
      function_03C1();
    }
  } else if(!function_0371()) {
    function_03C2();
  }

  level thread maps\mp\gametypes\_gamelogic::func_36B9(level.var_3B5C, game["end_reason"][param_00]);
  setnojipscore(0);
  setnojipzombieswave(0);
  maps\mp\_utility::func_2CED(0.05, ::lib_0554::func_20CB, "game_over");
}

lib_0553::func_60AD(param_00) {
  if(param_00 maps\mp\_utility::func_9AC1()) {
    return 0;
  }

  return 1;
}

lib_0553::func_7BEA(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = spawnStruct();
  var_07.var_35A9 = param_00;
  var_07.var_1180 = param_01;
  var_07.var_502C = param_02;
  var_07.var_1192 = param_01.var_0116;
  var_07.var_8CD7 = param_03;
  var_07.var_953E = param_04;
  var_07.var_A2B1 = param_05;
  var_07.var_8B0A = param_06;
  var_07.var_5BF4 = gettime();
  if(isDefined(param_01) && isPlayer(param_01) && param_01 getcurrentprimaryweapon() != "none") {
    var_07.var_912F = param_01 getcurrentprimaryweapon();
  } else {
    var_07.var_912F = undefined;
  }

  self.var_5BEF = var_07;
}

lib_0553::func_4B86() {
  return isDefined(self.var_6F66) && isDefined(self.var_6F66["quickrevive"]);
}

lib_0553::func_4B87() {
  return level.var_744A.size <= 1 && lib_0553::func_4B86();
}

lib_0553::func_A233() {
  lib_0555::func_83DD("blitz_revive", self);
  thread lib_0553::func_5BF2();
  level thread lib_0553::func_83CB(self);
}

lib_0553::func_5BF1(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  level notify("player_last_stand");
  self notify("force_cancel_placement");
  var_05 = lib_0553::func_0634(self);
  lib_0555::func_83DD("down", self);
  thread lib_054E::func_741A();
  thread lib_0553::func_5BFC();
  thread lib_0553::func_5BED();
  thread lib_0553::func_5BEE();
  thread laststandmonitordeath();
  var_06 = spawn("script_model", self.var_0116);
  var_06 setModel("tag_origin");
  var_06 setcursorhint("HINT_NOICON");
  var_06 sethintstring(&"PLATFORM_REVIVE");
  var_06 makeusable();
  var_06.var_54F5 = 0;
  var_06.var_28D5 = 0;
  var_06.var_A23F = level.var_5BFA;
  var_06.var_A22B = 1;
  var_06.var_502A = "last_stand";
  var_06.var_01A5 = "revive_trigger";
  var_06.var_0117 = self;
  var_06 linkto(self, "tag_origin", (0, 0, 20), (0, 0, 0));
  var_06 thread maps\mp\gametypes\_damage::func_2D44();
  self.var_7E5D = lib_0553::func_2826("hint_health_zm", 8, 8, (0.5, 1, 0.99));
  thread lib_0553::func_5BF7(var_06, var_05);
  thread lib_0553::func_5BF8(var_06);
  self hudoutlineenable(1, 0);
  var_06 thread lib_0553::func_7E58();
  var_06 thread lib_0553::func_7E65();
  var_06 thread lib_0553::func_5BFD();
  if(lib_0553::func_581E()) {
    lib_0553::func_A233();
    thread lib_0553::func_5BE9();
  } else {
    lib_0553::func_0F34(self);
    thread lib_0553::func_5BF6(var_05, var_06);
  }

  var_06 endon("death");
  maps\mp\gametypes\_hostmigration::func_A6F5(var_05);
  while(isDefined(var_06.var_54F5) && var_06.var_54F5) {
    wait 0.05;
  }

  if(isDefined(self.laststandlastmomentcallback)) {
    self[[self.laststandlastmomentcallback]]();
  }

  if(isDefined(self.linkedbubblefx)) {
    playFX(common_scripts\utility::func_44F5("force_zombie_bubble_pop"), self.var_0116);
    self.linkedbubblefx delete();
  }

  self hudoutlinedisable();
  self method_8322();
  thread lib_0553::func_1788();
}

lib_0553::func_581E() {
  return lib_0553::func_4B87();
}

lib_0553::func_2826(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_7E5D)) {
    self.var_7E5D destroy();
  }

  var_04 = newteamhudelem(self.var_01A7);
  var_04 setshader(param_00, param_01, param_02);
  var_04 setwaypoint(1, 1);
  var_04 settargetent(self);
  var_04.var_0056 = param_03;
  return var_04;
}

lib_0553::func_0F34(param_00) {
  var_01 = maps\mp\gametypes\zombies::func_4480(param_00);
  var_02 = int(var_01 * 0.1);
  var_03 = int(common_scripts\utility::func_627D(var_02, 10));
  var_02 = var_02 - var_03;
  param_00 maps\mp\gametypes\zombies::func_90F5(var_02);
  param_00.var_7E5E = var_02;
}

lib_0553::func_1788() {
  self notify("bleedout");
  level notify("player_bleedout", self);
  var_00 = lib_0547::func_AC4B(self.var_0116, "bleedout");
  var_00 lib_0547::func_AC47(self);
  var_00 lib_0547::func_AC4D();
  if(isDefined(self.var_7E5D)) {
    self.var_7E5D destroy();
  }

  var_01 = "ui_zm_character_" + self.characterclientindex + "_alive";
  setomnvar(var_01, 0);
  var_01 = "ui_zm_character_" + self.characterclientindex + "_bleedout_endtime";
  setomnvar(var_01, 0);
  if(self.var_32CE < level.var_6082) {
    setmatchdata("downs", self.var_32CE, "died", 1);
  }

  self.var_6881++;
  self suicide();
  if(lib_0553::func_3FD3(self)) {
    lib_0553::func_AC1F();
    return;
  }

  lib_0554::func_20CB("player_died", self);
  lib_0555::func_83DD("dead", self);
}

lib_0553::func_5BF2() {
  self endon("disconnect");
  self setclientomnvar("ui_use_bar_text", 3);
  self setclientomnvar("ui_use_bar_start_time", int(gettime()));
  self.var_28D5 = 0;
  self.var_A22B = 1;
  self.var_A23F = 8000;
  var_00 = -1;
  while(maps\mp\_utility::func_57A0(self) && isDefined(self.var_00E8) && !level.var_3F9D) {
    var_01 = int(gettime());
    self setclientomnvar("ui_use_bar_current_time", var_01);
    if(var_00 != self.var_A22B) {
      if(self.var_28D5 > self.var_A23F) {
        self.var_28D5 = self.var_A23F;
      }

      if(self.var_A22B > 0) {
        var_02 = gettime();
        var_03 = self.var_28D5 / self.var_A23F;
        var_04 = var_02 + 1 - var_03 * self.var_A23F / self.var_A22B;
        self setclientomnvar("ui_use_bar_end_time", int(var_04));
      }

      var_00 = self.var_A22B;
    }

    wait 0.05;
  }

  self setclientomnvar("ui_use_bar_end_time", 0);
}

lib_0553::func_83CB(param_00) {
  while(!level.var_3F9D && maps\mp\_utility::func_57A0(param_00) && param_00.var_28D5 < param_00.var_A23F) {
    param_00.var_28D5 = param_00.var_28D5 + 50 * param_00.var_A22B;
    if(param_00.var_28D5 >= param_00.var_A23F) {
      param_00 notify("revive_trigger");
    }

    wait 0.05;
  }
}

lib_0553::func_7E65() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self makeusable();
    self waittill("trigger", var_00);
    if(should_ignore_revive_attempt(self.var_0117, var_00)) {
      continue;
    }

    self makeunusable();
    var_01 = getdvarint("scr_reviveTime", 3000);
    var_02 = var_00 lib_0553::func_4B86();
    var_03 = common_scripts\utility::func_562E(var_00.var_569F) && var_00 lib_0547::func_4BA7("specialty_class_recon_medic_zm");
    if(var_02 && var_03) {
      var_01 = 0;
    } else if(var_02) {
      var_01 = var_01 * 0.5;
    } else if(var_03) {
      var_01 = var_01 * 0.5;
    }

    if(var_01 > 0) {
      self.var_28D5 = 0;
      self.var_54F5 = 1;
      self.var_0117.var_172C = 1;
      self.var_0117 lib_0547::func_7ACD();
      var_00 freezecontrols(1);
      var_00 common_scripts\utility::func_0603();
      var_00 method_812B(0);
      var_00.var_57AB = 1;
      thread lib_0553::func_7E66(var_00);
      var_04 = maps\mp\gametypes\_damage::func_7E5A(var_00, var_01, 0);
      self.var_54F5 = 0;
      if(isDefined(self.var_0117)) {
        self.var_0117.var_172C = 0;
        self.var_0117 lib_0547::func_7ACD();
      }

      if(isDefined(var_00) && maps\mp\_utility::func_57A0(var_00)) {
        self notify("reviveTriggerThinkZombies_cleanup");
        if(!isDefined(var_04)) {
          var_00 maps\mp\gametypes\_gameobjects::func_A18A(self, 0);
        }
      }
    } else {
      var_04 = 1;
    }

    if(isDefined(var_04) && var_04) {
      if(isDefined(self.var_0117)) {
        self.var_0117 notify("revive_trigger", var_00);
      }

      lib_0553::func_476A(self.var_0117, var_00);
      break;
    }
  }
}

should_ignore_revive_attempt(param_00, param_01) {
  if(!isDefined(level.additional_player_revive_rules)) {
    return 0;
  }

  foreach(var_03 in level.additional_player_revive_rules) {
    if([[var_03]](param_00, param_01)) {
      return 1;
    }
  }

  return 0;
}

lib_0553::func_476A(param_00, param_01) {
  var_02 = param_01;
  if(!isPlayer(var_02) && isPlayer(var_02.var_0117)) {
    var_02 = var_02.var_0117;
  }

  if(isDefined(param_00) && isDefined(param_00.var_7E5E)) {
    var_02 maps\mp\gametypes\zombies::func_4798(param_00.var_7E5E);
  }

  lib_0553::func_145A(var_02);
  if(isDefined(level.zmb_events_player_on_teammate_revived)) {
    [[level.zmb_events_player_on_teammate_revived]](param_00, param_01);
  }
}

lib_0553::func_145A(param_00) {
  if(!isDefined(param_00.var_7E62) || !isDefined(param_00.var_A986) || param_00.var_A986 != level.var_A980) {
    param_00.var_7E62 = 0;
  }

  param_00.var_7E62 = param_00.var_7E62 + 1;
  param_00.var_A986 = level.var_A980;
  if(param_00.var_7E62 < 3) {
    param_00 maps\mp\zombies\_zombies_rank::func_AC23("revive");
  }
}

lib_0553::func_7E66(param_00) {
  common_scripts\utility::func_A70C(self, "death", self, "reviveTriggerThinkZombies_cleanup");
  param_00 freezecontrols(0);
  param_00 method_812B(1);
  param_00 common_scripts\utility::func_0617();
  param_00.var_57AB = 0;
}

lib_0553::func_5BFD() {
  level endon("game_ended");
  var_00 = self.var_0117;
  var_00 endon("becameSpectator");
  var_00 endon("death");
  var_00 endon("disconnect");
  var_00 waittill("revive_trigger", var_01);
  var_02 = 0;
  if(var_00 lib_0553::func_581E()) {
    var_02 = 1;
    if(!isDefined(var_00.numselfrevivedowns)) {
      var_00.numselfrevivedowns = 0;
    }

    var_00.numselfrevivedowns++;
    setmatchdata("downs", var_00.var_32CE, "reviver_player_index", maps\mp\_utility::func_2314(var_00.var_2418));
    var_00 lib_056A::func_95F0();
    var_01 = var_00;
  }

  if(isDefined(var_01) && isPlayer(var_01)) {
    var_01 maps\mp\_utility::func_50EA("assists", 1);
    var_01 maps\mp\_utility::func_50E9("assists", 1);
    var_01.var_0021 = var_01 maps\mp\_utility::func_4607("assists");
    if(var_01 != var_00) {
      var_00 thread lib_054E::func_7448(var_01);
      var_00 thread maps\mp\gametypes\_hud_message::func_73C2("revived", var_01);
      lib_0555::func_83DD("revived", var_01, var_00 getentitynumber());
      setmatchdata("downs", var_00.var_32CE, "reviver_player_index", maps\mp\_utility::func_2314(var_01.var_2418));
      var_01 maps\mp\gametypes\_persistence::func_933A("round", "assists", var_01.var_0021);
      if(lib_0547::func_577E(var_01)) {
        var_01.var_801C++;
      }
    }
  }

  var_03 = lib_0547::func_AC4B(var_00.var_0116, "revived");
  var_03 lib_0547::func_AC47(var_00);
  var_03 lib_0547::func_AC42("self_revive", var_02);
  var_03 lib_0547::func_AC4D();
  var_04 = "ui_zm_character_" + var_00.characterclientindex + "_bleedout_endtime";
  setomnvar(var_04, 0);
  if(var_00 isreloading()) {
    while(var_00 isreloading()) {
      wait 0.05;
    }

    wait 0.05;
  }

  var_00 lib_0553::func_7DB4(1);
  var_00 thread lib_0537::func_6B7E(var_01);
}

lib_0553::func_7E58() {
  self endon("death");
  if(isDefined(self.var_0117.var_7E5D)) {
    var_00 = self.var_0117.var_7E5D;
  } else {
    var_00 = undefined;
  }

  self.var_0117 common_scripts\utility::func_A70A("revive_trigger", "disconnect", "becameSpectator");
  if(isDefined(self.var_0117) && isDefined(self.var_0117.var_7E5D)) {
    self.var_0117.var_7E5D destroy();
  } else if(isDefined(var_00)) {
    var_00 destroy();
  }

  self delete();
}

lib_0553::func_4777() {
  self.var_7708[self.var_479D]["lastStandAmmoInfo"] = lib_0586::func_4129(self.var_479D);
  lib_0586::func_0790(self.var_479D);
  self.var_479D = undefined;
  var_00 = undefined;
  if(issubstr(self.var_5B98, "turrethead")) {
    var_01 = -1;
    for(var_02 = 0; var_02 < self.var_7707.size; var_02++) {
      var_03 = maps\mp\zombies\_zombies_magicbox::func_454B(self, self.var_7707[var_02]);
      var_04 = lib_0547::func_4747(self, self.var_7707[var_02]);
      if(var_04 > var_01) {
        var_00 = var_03;
        var_01 = var_04;
      }
    }
  }

  if(!isDefined(var_00)) {
    var_00 = self.var_5B98;
  }

  foreach(var_06 in self.var_7707) {
    lib_0553::func_47BC(var_06, 0);
  }

  lib_0586::func_078E(var_00, 1);
}

lib_0553::func_7DB4(param_00) {
  self notify("revive");
  level notify("player_revived", self);
  self method_812A(1);
  self.var_00E8 = undefined;
  self.var_5378 = 0;
  self.var_00BA = "";
  self.var_00BC = self.var_00FB;
  self.var_00CE = 0;
  self.var_509C = undefined;
  self.var_AC5B = 0;
  self.var_AC5C = undefined;
  self.var_172C = 0;
  self.var_5BD7 = gettime();
  if(self.var_32CE < level.var_6082) {
    var_01 = maps\mp\_utility::func_467B();
    setmatchdata("downs", self.var_32CE, "spawn_time", maps\mp\_utility::func_2315(var_01));
    var_02 = self.var_0116;
    setmatchdata("downs", self.var_32CE, "spawn_pos", 0, maps\mp\_utility::func_2315(int(var_02[0])));
    setmatchdata("downs", self.var_32CE, "spawn_pos", 1, maps\mp\_utility::func_2315(int(var_02[1])));
    setmatchdata("downs", self.var_32CE, "spawn_pos", 2, maps\mp\_utility::func_2315(int(var_02[2])));
    setmatchdata("downs", self.var_32CE, "round_spawned", level.var_A980);
    self.var_32CE = level.var_32CF;
  }

  self hudoutlinedisable();
  self laststandrevive();
  if(isDefined(self.var_7E5D)) {
    self.var_7E5D destroy();
  }

  if(common_scripts\utility::func_562E(param_00)) {
    self setstance("stand");
    lib_0553::func_4777();
    common_scripts\utility::func_0614();
    if(isDefined(level.var_5F1D)) {
      [[level.var_5F1D]]();
    }
  } else {
    self notify("spectator_revive");
  }

  self method_8327();
  thread lib_0547::func_AC16(1, "laststand");
  self method_8323();
  common_scripts\utility::func_0615();
  lib_0547::func_7ACD();
  maps\mp\_utility::func_2401("last_stand");
  maps\mp\_utility::func_47A2("specialty_pistoldeath");
  self method_8308(1);
  checktemporaryperks();
  if(!canspawn(self.var_0116)) {
    maps\mp\_movers::func_A047(self, 0);
  }
}

lib_0553::func_1925() {
  return common_scripts\utility::func_562E(level.var_1CBA);
}

lib_0553::func_1926() {
  var_00 = common_scripts\utility::func_7A33(level.var_1CBB);
  return var_00.var_0116;
}

checktemporaryperks() {
  if(lib_0547::func_4BA7("specialty_class_aftertaste_zm")) {
    self luinotifyeventextraplayer(&"trigger_mod_proc_and_remove", 1, "specialty_class_aftertaste_zm");
  }
}

lib_0553::func_7E59() {
  self endon("disconnect");
  if(common_scripts\utility::func_562E(self.is_reviving_from_spectate_mode)) {
    return;
  }

  if(common_scripts\utility::func_562E(self.var_A6F0)) {
    return;
  }

  if(common_scripts\utility::func_562E(self.var_A6F1)) {
    return;
  }

  if(common_scripts\utility::func_562E(self.var_5DED)) {
    return;
  }

  var_00 = self.var_0178;
  self.is_reviving_from_spectate_mode = 1;
  wait(1);
  if(!common_scripts\utility::func_562E(self.var_0CA4)) {
    maps\mp\gametypes\_playerlogic::func_50F8(self.var_01A7, "reviveFromSpectateMode");
  }

  self.var_0CA4 = 1;
  self.var_012C["lives"] = 1;
  thread maps\mp\gametypes\_playerlogic::func_9035();
  thread lib_0547::func_865A(self.var_20D8, 0);
  wait(0.1);
  lib_0553::func_7DB4(0);
  self.is_reviving_from_spectate_mode = 0;
}

lib_0553::func_47BC(param_00, param_01) {
  lib_0553::func_47AC(param_00, param_01);
  if(isDefined(self.var_7708[param_00]["fillMax"])) {
    self givemaxammo(param_00);
    self.var_7708[param_00]["fillMax"] = undefined;
    return;
  }

  lib_0586::func_0F21(param_00, self.var_7708[param_00]["ammoInfo"]);
}

lib_0553::func_47AC(param_00, param_01) {
  lib_0586::func_078C(param_00);
  if(param_01) {
    lib_0586::func_078E(param_00, 1);
  }
}

setlaststandweaponammo(param_00) {
  if(!isDefined(self.givenlaststandammoround) || isDefined(self.givenlaststandammoround) && self.givenlaststandammoround < level.var_A980) {
    var_01 = weaponclipsize(param_00, self);
    self method_82FA(param_00, var_01, "right");
    if(issubstr(param_00, "akimbo")) {
      self method_82FA(param_00, var_01, "left");
    }

    self setweaponammostock(param_00, var_01 * 3);
    self.givenlaststandammoround = level.var_A980;
    return;
  }

  if(isDefined(self.givenlaststandammoround) && self.givenlaststandammoround >= level.var_A980 && isDefined(self.var_7708) && isDefined(self.var_7708[param_00]) && isDefined(self.var_7708[param_00]["lastStandAmmoInfo"])) {
    lib_0586::func_0F21(param_00, self.var_7708[param_00]["lastStandAmmoInfo"]);
  }
}

lib_0553::func_5BFC() {
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  self waittill("death");
  self.var_00E8 = undefined;
  self.var_5378 = 0;
  self.var_00CE = 0;
  self.var_509C = undefined;
  self.var_AC5B = 0;
  self.var_AC5C = undefined;
}

lib_0553::func_5BED() {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  for(;;) {
    self.var_00BC = 2;
    wait 0.05;
    self.var_00BC = 1;
    wait 0.05;
  }
}

laststandmonitordeath() {
  self endon("disconnect");
  self endon("revive");
  self endon("player_bleedout");
  level endon("game_ended");
  self waittill("death");
  var_00 = "ui_zm_character_" + self.characterclientindex + "_alive";
  setomnvar(var_00, 0);
  var_00 = "ui_zm_character_" + self.characterclientindex + "_bleedout_endtime";
  setomnvar(var_00, 0);
}

lib_0553::func_5BEE() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("revive_trigger");
  self endon("horde_end_spectate");
  self notify("monitor_abandonment");
  for(;;) {
    level waittill("player_disconnected");
    if(lib_0553::func_3FD3(self)) {
      self.var_A219 = 1;
      if(self.var_32CE < level.var_6082) {
        setmatchdata("downs", self.var_32CE, "died", 1);
      }

      maps\mp\_utility::func_0728();
      lib_0553::func_AC1F();
      return;
    }

    wait 0.05;
  }
}

deathmonitorabandonment() {
  self notify("monitor_abandonment");
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned_player");
  self endon("monitor_abandonment");
  for(;;) {
    level waittill("player_disconnected");
    if(lib_0553::func_3FD3(self)) {
      lib_0553::func_AC1F();
      return;
    }

    wait 0.05;
  }
}

lib_0553::func_5BF8(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  param_00 endon("death");
  var_01 = (1, 1, 1);
  for(;;) {
    while(!param_00.var_54F5) {
      wait 0.05;
    }

    var_02 = self.var_7E5D.var_0056;
    self.var_7E5D = lib_0553::func_2826("hint_health_zm", 8, 8, var_01);
    while(param_00.var_54F5) {
      wait 0.05;
    }

    if(self.var_7E5D.var_0056 != var_01) {
      var_02 = self.var_7E5D.var_0056;
    }

    self.var_7E5D = lib_0553::func_2826("hint_health_zm", 8, 8, var_02);
  }
}

lib_0553::func_5BF7(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  param_00 endon("death");
  maps\mp\_utility::func_7210();
  wait(param_01 / 3);
  while(param_00.var_54F5) {
    wait 0.05;
  }

  self.var_7E5D.var_0056 = (1, 0.5, 0);
  maps\mp\_utility::func_7210();
  wait(param_01 / 3);
  while(param_00.var_54F5) {
    wait 0.05;
  }

  self.var_7E5D.var_0056 = (0.99, 0.19, 0.22);
  maps\mp\_utility::func_7210();
}

laststandwatchfordisconnectzombies(param_00, param_01) {
  param_00 endon("death");
  param_00 endon("revive");
  level endon("game_ended");
  param_00 waittill("disconnect");
  setomnvar(param_01, 0);
}

lib_0553::func_5BF6(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  var_02 = gettime() + param_00 * 1000;
  var_03 = undefined;
  var_03 = "ui_zm_character_" + self.characterclientindex + "_bleedout_endtime";
  thread laststandwatchfordisconnectzombies(self, var_03);
  for(;;) {
    setomnvar(var_03, var_02);
    level waittill("host_migration_begin");
    setomnvar(var_03, 0);
    var_04 = maps\mp\gametypes\_hostmigration::func_A782();
    var_02 = var_02 + var_04;
  }
}

lib_0553::func_5BE9() {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  var_00 = 1;
  for(;;) {
    wait(var_00);
    var_01 = self getcurrentweapon();
    var_02 = self method_817F(var_01);
    if(var_02 == 0) {
      var_03 = weaponclipsize(var_01);
      self setweaponammostock(var_01, var_03);
    }
  }
}

lib_0553::func_0634(param_00) {
  var_01 = 30;
  if(lib_0547::func_0F0F("specialty_class_preventative_medicine_zm")) {
    var_01 = var_01 * 2;
  }

  if(isDefined(level.var_744A) && isDefined(param_00)) {
    foreach(var_03 in level.var_744A) {
      if(var_03 != param_00 && var_03 lib_0547::func_4BA7("specialty_class_preventative_medicine_zm")) {
        param_00 luinotifyeventextraplayer(&"add_teammate_mod_buffs", 3, "specialty_class_preventative_medicine_zm", 1, var_03);
        break;
      }
    }
  }

  return int(var_01);
}

lib_0553::func_53E2(param_00) {
  if(maps\mp\_utility::func_57A0(self)) {
    self notify("revive_trigger", param_00);
    lib_0553::func_476A(self, param_00);
  }
}