/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1363.gsc
**************************************/

_id_1E6E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(level.zmb_player_last_stand_protection)) {
    if([[level.zmb_player_last_stand_protection]](self)) {
      self.health = 1;
      return;
    }
  }

  self notify("enter_last_stand");
  _id_7BEA(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  var_9 = _id_0547::_id_AC4B(self.origin, "last_stand");
  var_9 _id_0547::_id_AC47(self);
  var_9 _id_0547::_id_AC4D();

  if(level._id_32CF < level._id_6082) {
    self._id_32CE = level._id_32CF;
    level._id_32CF = level._id_32CF + 1;
    setmatchdata("down_count", maps\mp\_utility::_id_2315(level._id_32CF));
    setmatchdata("downs", self._id_32CE, "round_downed", maps\mp\_utility::_id_2315(level._id_A980));
    setmatchdata("downs", self._id_32CE, "player_index", maps\mp\_utility::_id_2314(self.clientid));
    var_10 = maps\mp\_utility::getsecondspassed();
    setmatchdata("downs", self._id_32CE, "down_time", maps\mp\_utility::_id_2315(var_10));
    setmatchdata("downs", self._id_32CE, "down_pos", 0, maps\mp\_utility::_id_2315(int(self.origin[0])));
    setmatchdata("downs", self._id_32CE, "down_pos", 1, maps\mp\_utility::_id_2315(int(self.origin[1])));
    setmatchdata("downs", self._id_32CE, "down_pos", 2, maps\mp\_utility::_id_2315(int(self.origin[2])));

    if(!common_scripts\utility::_id_562E(level.door_data_out_of_date))
      setmatchdata("downs", self._id_32CE, "down_zone_index", _id_0547::getplayerddlzonename());

    if(_func_12A("MeansOfDeath", var_3))
      setmatchdata("downs", self._id_32CE, "means_of_death", var_3);

    if(isDefined(var_1._id_0A4B) && _func_12A("ZombieType", var_1._id_0A4B))
      setmatchdata("downs", self._id_32CE, "attacker", var_1._id_0A4B);
  } else
    self._id_32CE = level._id_6082;

  var_11 = self getcurrentprimaryweapon();

  if(maps\mp\_utility::_id_4431(var_11) == self._id_76D8)
    self._id_A9BA[self._id_76D9]._id_32D0 = self._id_A9BA[self._id_76D9]._id_32D0 + 1;
  else {
    var_12 = _id_0547::_id_4837(self, var_11);

    if(var_12 == -1) {
      self._id_76D8 = "";
      self._id_76D9 = -1;
    } else {
      self._id_A9BA[var_12]._id_32D0 = self._id_A9BA[var_12]._id_32D0 + 1;
      self._id_76D8 = maps\mp\_utility::_id_4431(var_11);
      self._id_76D9 = var_12;
    }
  }

  if(laststandentergameshouldend(self, var_3, 1)) {
    self._id_A219 = 1;

    if(self._id_32CE < level._id_6082)
      setmatchdata("downs", self._id_32CE, "died", 1);

    self._id_6881++;
    maps\mp\_utility::_suicide();
    _id_AC1F(undefined, var_3);
    return;
  }

  if(!_id_60AD(self)) {
    self._id_A219 = 0;

    if(self._id_32CE < level._id_6082)
      setmatchdata("downs", self._id_32CE, "died", 1);

    self._id_6881++;
    maps\mp\_utility::_suicide();

    if(level.players.size < 2)
      _id_AC1F(undefined, var_3);

    return;
  }

  self notify("begin_last_stand");
  self.inlaststand = 1;
  self._id_00E8 = 1;
  _id_0547::setclienttriggeraudiozonelerp(1);
  self.health = 1;
  self allowmelee(0);
  self._id_6882++;

  if(_id_0586::_id_72C3()) {
    _id_0586::_id_0790("blimp_battery_zm");
    _id_0586::_id_078E(self._id_6A54);
    self allowjump(1);
  }

  var_13 = self getweaponslist("combat_role");
  var_14 = self _meth_85BB();

  foreach(var_16 in var_13) {
    if(var_14 > 0)
      self _meth_85B9(-1 * var_14);

    _id_0533::_id_2F9E(var_16);
  }

  _id_0547::_id_7ACD();

  if(isDefined(level._id_5F20))
    [[level._id_5F20]]();

  self._id_479D = _id_AC5F();
  clearnightvisionfog();
  _id_47AC(self._id_479D, 1);
  setlaststandweaponammo(self._id_479D);
  thread _id_0547::_id_AC16(0, "laststand");
  common_scripts\utility::_id_0601();
  self disableweaponswitch();
  common_scripts\utility::_disableoffhandweapons();

  if(isDefined(var_3) && var_3 == "MOD_SUICIDE")
    self _meth_8555();

  thread _id_5BF1(var_0, var_1, var_4, var_7, var_3);

  if(!_id_4B87())
    thread _id_0576::lightsetforplayer();

  thread _id_056A::_id_5BFE();

  if(isDefined(level._id_5BEB))
    self thread[[level._id_5BEB]]();

  if(maps\mp\agents\_agent_utility::_id_45C7(self) > 0)
    thread _id_9E18(var_3);

  level._id_400E[level._id_400E.size] = ["assassin_set 3 -1", self];
  level._id_400E[level._id_400E.size] = ["survivalist_set 0 -1", self];
  level._id_400E[level._id_400E.size] = ["mountain_man_set 1 -1", self];
  level._id_400E[level._id_400E.size] = ["mountain_man_set 3 -1", self];
  level._id_400E[level._id_400E.size] = ["bat_elite_set 3 -1", self];
}

_id_9E18(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");

  while(maps\mp\agents\_agent_utility::_id_45C7(self) > 0)
    waitframe();

  if(_id_3FD3(self, 1))
    thread _id_5A4D(var_0);
}

_id_5A4D(var_0) {
  level endon("game_ended");
  self._id_A219 = 1;

  if(self._id_32CE < level._id_6082)
    setmatchdata("downs", self._id_32CE, "died", 1);

  self._id_6881++;
  maps\mp\_utility::_suicide();
  _id_AC1F(undefined, var_0);
}

clearnightvisionfog(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(_id_057A::_id_A260())
    _id_057A::_id_259D();

  self._id_5B98 = self getcurrentprimaryweapon();
  var_1 = self getweaponlistprimaries();

  if(!isDefined(self._id_5B98) || self._id_5B98 == "none" || _id_0547::_id_585B(self._id_5B98) || !_id_0547::_id_5836(self._id_5B98)) {
    self._id_5B98 = "none";

    foreach(var_3 in var_1) {
      var_4 = _getweaponbasename(var_3);

      if(_id_0547::_id_5836(var_4)) {
        self._id_5B98 = _id_0586::_id_0632(var_3);
        break;
      }
    }
  }

  self._id_7707 = [];

  foreach(var_3 in var_1) {
    var_7 = _getweaponbasename(var_3);

    if(_id_0547::_id_5836(var_7))
      self._id_7707[self._id_7707.size] = _id_0586::_id_0632(var_3);
  }

  if(self._id_5B98 == "search_dstry_bomb_defuse_mp" && isDefined(self._id_5BC5) && isDefined(common_scripts\utility::_id_0F7E(self._id_7707, self._id_5BC5)))
    self._id_5B98 = self._id_5BC5;

  if(issubstr(self._id_5B98, "killstreak"))
    self._id_5B98 = self._id_7707[0];

  foreach(var_3 in self._id_7707)
  self._id_7708[var_3]["ammoInfo"] = _id_0586::_id_4129(var_3);

  self._id_9A8A = self._id_5B98;
  self._id_9A8B = _id_0547::_id_4747(self, self._id_9A8A);

  if(issubstr(self._id_9A8A, "titan"))
    self._id_9A8B = 0;

  foreach(var_12 in self._id_7707) {
    if(!issubstr(var_12, "titan")) {
      if(var_0)
        _id_0586::_id_0790(var_12);

      var_13 = _id_0547::_id_4747(self, var_12);

      if(var_13 > self._id_9A8B) {
        self._id_9A8A = var_12;
        self._id_9A8B = var_13;
      }
    }
  }
}

_id_7B86() {
  foreach(var_1 in self._id_7707)
  self._id_7708[var_1]["fillMax"] = 1;
}

_id_AC5F() {
  var_0 = self;
  var_1 = ["m1911_pap_zm", "luger_pap_zm", "m712_pap_zm", "m712_zm", "luger_auto_zm", "m1911_zm", "luger_zm"];
  var_2 = undefined;

  foreach(var_4 in var_0 getweaponlistprimaries()) {
    var_5 = var_0 _id_0586::_id_0632(var_4);
    var_6 = _id_0547::_id_AAF9(var_5);

    if(var_6 == "none" || weaponclass(var_6) != "pistol") {
      continue;
    }
    var_2 = var_5;

    if(_id_0547::_id_5868(var_5)) {
      break;
    }
  }

  if(!isDefined(var_2)) {
    var_8 = var_1[var_1.size - 1];
    var_2 = _id_0548::_id_454B(self, var_8);
  }

  if(_id_4B87()) {
    var_2 = _id_0548::_id_454B(self, "m1911_zm");
    var_9 = _id_0586::_id_078B(var_2);

    if(isDefined(var_9))
      return var_9;
    else
      return "m1911_pap_zm";
  }

  for(var_10 = 0; var_10 < var_1.size; var_10++) {
    if(_id_0547::_id_73F9(self, var_1[var_10], 1, 1, 0)) {
      var_11 = _id_0586::_id_078A(var_1[var_10]);

      if(isDefined(var_11)) {
        var_2 = _id_0586::_id_0632(var_11);
        break;
      }
    }
  }

  return var_2;
}

laststandentergameshouldend(var_0, var_1, var_2) {
  if(level.players.size <= 1) {
    if(var_0 _id_4B87())
      return 0;

    if(var_0 _id_0547::_id_73BF())
      return 0;

    if(isDefined(var_1) && var_1 == "MOD_SUICIDE")
      return 1;
  }

  if(_id_0547::_id_0F51(var_0, 1))
    return 0;
  else {
    if(isDefined(var_2) && var_2 && _id_0F50(var_0))
      return 0;

    if(var_0 _id_0547::_id_73BF())
      return 0;
  }

  var_0._id_2AB8 = gettime();
  return 1;
}

_id_3FD3(var_0, var_1, var_2) {
  if(level.players.size <= 1) {
    if(_id_0547::_id_577E(var_0) && var_0 _id_4B87())
      return 0;

    if(_id_0547::_id_577A(var_0, 1))
      return 0;

    if(isDefined(var_1) && var_1 == "MOD_SUICIDE")
      return 1;
  }

  if(_id_0547::_id_0F51(var_0, 1))
    return 0;
  else if(isDefined(var_2) && var_2 && _id_0F50(var_0))
    return 0;

  var_0._id_2AB8 = gettime();
  return 1;
}

_id_0F50(var_0) {
  var_1 = maps\mp\agents\_agent_utility::_id_43FD("all");

  foreach(var_3 in var_1) {
    if(!_isalliedsentient(var_3, var_0)) {
      continue;
    }
    if(_isalliedsentient(var_3, var_0) && common_scripts\utility::_id_562E(var_3.shouldnotpreventlaststand)) {
      continue;
    }
    if(_id_0547::_id_577E(var_3)) {
      continue;
    }
    return 1;
  }

  return 0;
}

_id_7B38() {
  foreach(var_1 in level.players) {
    setmatchdata("players", var_1.clientid, "end_total_xp", var_1._id_AB46["xp"]);
    setmatchdata("players", var_1.clientid, "end_prestige", 0);
    setmatchdata("players", var_1.clientid, "end_rank", var_1._id_AB46["rank"]);
    setmatchdata("players", var_1.clientid, "end_xp", var_1._id_AB46["xp"] - var_1._id_AB46["totalXP"]);
    var_2 = _id_0547::_id_4745(var_1, "totalTimePlayed") + var_1._id_9A06["total"];
    var_3 = _id_0547::_id_4745(var_1, "totalGames");
    setmatchdata("players", var_1.clientid, "end_total_time_played", var_2);
    setmatchdata("players", var_1.clientid, "end_zm_games_played", var_3 + 1);
    var_4 = _id_0547::_id_4745(var_1, "totalHeadshots") + var_1._id_4BF7;
    var_5 = _id_0547::_id_4745(var_1, "totalKills") + var_1._id_00E3;
    var_6 = _id_0547::_id_4745(var_1, "totalRevives") + var_1._id_0021;
    var_7 = _id_0547::_id_4745(var_1, "totalMoneyEarned") + var_1._id_62D7;
    var_8 = _id_0547::_id_4745(var_1, "totalRounds") + level._id_A980;
    setmatchdata("players", var_1.clientid, "end_lifetime_headshots", var_4);
    setmatchdata("players", var_1.clientid, "end_lifetime_kills", var_5);
    setmatchdata("players", var_1.clientid, "end_lifetime_revives", var_6);
    setmatchdata("players", var_1.clientid, "end_lifetime_score", var_7);
    setmatchdata("players", var_1.clientid, "end_lifetime_waves", var_8);
    setmatchdata("players", var_1.clientid, "play_time", var_1._id_9A06["total"]);

    if(var_1._id_32CE < level._id_6082)
      setmatchdata("downs", var_1._id_32CE, "died", 1);
  }
}

_id_AC1F(var_0, var_1, var_2) {
  if(!common_scripts\utility::_id_562E(var_2) && !_id_3FD3(self, var_1))
    return 0;

  if(game["state"] == "postgame" || level.gameended) {
    return;
  }
  _id_7B38();
  level._id_3B5C = level._id_3772;

  if(!isDefined(var_0))
    var_0 = "survivors_eliminated";

  if(common_scripts\utility::_id_562E(level.iszombiesshotgun))
    var_3 = common_scripts\utility::_id_562E(level.zmb_shotgun_game_won);
  else
    var_3 = isDefined(var_0) && var_0 == "zombies_completed";

  if(var_3) {
    level.finalkillcam_winnter = level._id_746E;

    if(!_func_371())
      _func_3C1();
  } else if(!_func_371())
    _func_3C2();

  level thread maps\mp\gametypes\_gamelogic::_id_36B9(level._id_3B5C, game["end_reason"][var_0]);
  _func_246(0);
  _setnojipscore(0);
  maps\mp\_utility::_id_2CED(0.05, _id_0554::_id_20CB, "game_over");
}

_id_60AD(var_0) {
  if(var_0 maps\mp\_utility::touchingbadtrigger())
    return 0;

  return 1;
}

_id_7BEA(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7._id_35A9 = var_0;
  var_7._id_1180 = var_1;
  var_7._id_502C = var_2;
  var_7._id_1192 = var_1.origin;
  var_7._id_8CD7 = var_3;
  var_7._id_953E = var_4;
  var_7._id_A2B1 = var_5;
  var_7._id_8B0A = var_6;
  var_7._id_5BF4 = gettime();

  if(isDefined(var_1) && isPlayer(var_1) && var_1 getcurrentprimaryweapon() != "none")
    var_7._id_912F = var_1 getcurrentprimaryweapon();
  else
    var_7._id_912F = undefined;

  self._id_5BEF = var_7;
}

_id_4B86() {
  return isDefined(self._id_6F66) && isDefined(self._id_6F66["quickrevive"]);
}

_id_4B87() {
  return level.players.size <= 1 && _id_4B86();
}

_id_A233() {
  _id_0555::issprinting("blitz_revive", self);
  thread _id_5BF2();
  level thread killnotification(self);
}

_id_5BF1(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  level notify("player_last_stand");
  self notify("force_cancel_placement");
  var_5 = _id_0634(self);
  _id_0555::issprinting("down", self);
  thread _id_054E::_id_741A();
  thread _id_5BFC();
  thread _id_5BED();
  thread _id_5BEE();
  thread laststandmonitordeath();
  var_6 = spawn("script_model", self.origin);
  var_6 setModel("tag_origin");
  var_6 setcursorhint("HINT_NOICON");
  var_6 sethintstring(&"PLATFORM_REVIVE");
  var_6 makeusable();
  var_6._id_54F5 = 0;
  var_6._id_28D5 = 0;
  var_6._id_A23F = level._id_5BFA;
  var_6._id_A22B = 1;
  var_6._id_502A = "last_stand";
  var_6.targetname = "revive_trigger";
  var_6._id_0117 = self;
  var_6 linkto(self, "tag_origin", (0, 0, 20), (0, 0, 0));
  var_6 thread maps\mp\gametypes\_damage::_id_2D44();
  self._id_7E5D = _id_2826("hint_health_zm", 8, 8, (0.5, 1, 0.99));
  thread _id_5BF7(var_6, var_5);
  thread _id_5BF8(var_6);
  self hudoutlineenable(1, 0);
  var_6 thread _id_7E58();
  var_6 thread _id_7E65();
  var_6 thread _id_5BFD();

  if(_id_581E()) {
    _id_A233();
    thread _id_5BE9();
  } else {
    _id_0F34(self);
    thread _id_5BF6(var_5, var_6);
  }

  var_6 endon("death");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_5);

  while(isDefined(var_6._id_54F5) && var_6._id_54F5)
    waitframe();

  if(isDefined(self.laststandlastmomentcallback))
    self[[self.laststandlastmomentcallback]]();

  if(isDefined(self.linkedbubblefx)) {
    playFX(common_scripts\utility::_id_44F5("force_zombie_bubble_pop"), self.origin);
    self.linkedbubblefx delete();
  }

  self hudoutlinedisable();
  self disableweapons();
  thread _id_1788();
}

_id_581E() {
  return _id_4B87();
}

_id_2826(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_7E5D))
    self._id_7E5D destroy();

  var_4 = _newteamhudelem(self.team);
  var_4 setshader(var_0, var_1, var_2);
  var_4 setwaypoint(1, 1);
  var_4 settargetent(self);
  var_4.color = var_3;
  return var_4;
}

_id_0F34(var_0) {
  var_1 = maps\mp\gametypes\zombies::_id_4480(var_0);
  var_2 = int(var_1 * 0.1);
  var_3 = int(common_scripts\utility::_id_627D(var_2, 10));
  var_2 = var_2 - var_3;
  var_0 maps\mp\gametypes\zombies::_id_90F5(var_2);
  var_0._id_7E5E = var_2;
}

_id_1788() {
  self notify("bleedout");
  level notify("player_bleedout", self);
  var_0 = _id_0547::_id_AC4B(self.origin, "bleedout");
  var_0 _id_0547::_id_AC47(self);
  var_0 _id_0547::_id_AC4D();

  if(isDefined(self._id_7E5D))
    self._id_7E5D destroy();

  var_1 = "ui_zm_character_" + self.characterclientindex + "_alive";
  _setomnvar(var_1, 0);
  var_1 = "ui_zm_character_" + self.characterclientindex + "_bleedout_endtime";
  _setomnvar(var_1, 0);

  if(self._id_32CE < level._id_6082)
    setmatchdata("downs", self._id_32CE, "died", 1);

  self._id_6881++;
  self suicide();

  if(_id_3FD3(self))
    _id_AC1F();
  else {
    _id_0554::_id_20CB("player_died", self);
    _id_0555::issprinting("dead", self);
  }
}

_id_5BF2() {
  self endon("disconnect");
  self setclientomnvar("ui_use_bar_text", 3);
  self setclientomnvar("ui_use_bar_start_time", int(gettime()));
  self._id_28D5 = 0;
  self._id_A22B = 1;
  self._id_A23F = 8000;
  var_0 = -1;

  while(maps\mp\_utility::isreallyalive(self) && isDefined(self._id_00E8) && !level.gameended) {
    var_1 = int(gettime());
    self setclientomnvar("ui_use_bar_current_time", var_1);

    if(var_0 != self._id_A22B) {
      if(self._id_28D5 > self._id_A23F)
        self._id_28D5 = self._id_A23F;

      if(self._id_A22B > 0) {
        var_2 = gettime();
        var_3 = self._id_28D5 / self._id_A23F;
        var_4 = var_2 + (1 - var_3) * (self._id_A23F / self._id_A22B);
        self setclientomnvar("ui_use_bar_end_time", int(var_4));
      }

      var_0 = self._id_A22B;
    }

    waitframe();
  }

  self setclientomnvar("ui_use_bar_end_time", 0);
}

killnotification(var_0) {
  while(!level.gameended && maps\mp\_utility::isreallyalive(var_0) && var_0._id_28D5 < var_0._id_A23F) {
    var_0._id_28D5 = var_0._id_28D5 + 50 * var_0._id_A22B;

    if(var_0._id_28D5 >= var_0._id_A23F)
      var_0 notify("revive_trigger");

    waitframe();
  }
}

_id_7E65() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self makeusable();
    self waittill("trigger", var_0);

    if(should_ignore_revive_attempt(self._id_0117, var_0)) {
      continue;
    }
    self makeunusable();
    var_1 = getdvarint("scr_reviveTime", 3000);
    var_2 = var_0 _id_4B86();
    var_3 = common_scripts\utility::_id_562E(var_0._id_569F) && var_0 _id_0547::_id_4BA7("specialty_class_recon_medic_zm");

    if(var_2 && var_3)
      var_1 = 0;
    else if(var_2)
      var_1 = var_1 * 0.5;
    else if(var_3)
      var_1 = var_1 * 0.5;

    if(var_1 > 0) {
      self._id_28D5 = 0;
      self._id_54F5 = 1;
      self._id_0117._id_172C = 1;
      self._id_0117 _id_0547::_id_7ACD();
      var_0 freezecontrols(1);
      var_0 common_scripts\utility::_id_0603();
      var_0 allowfire(0);
      var_0._id_57AB = 1;
      thread _id_7E66(var_0);
      var_4 = maps\mp\gametypes\_damage::_id_7E5A(var_0, var_1, 0);
      self._id_54F5 = 0;

      if(isDefined(self._id_0117)) {
        self._id_0117._id_172C = 0;
        self._id_0117 _id_0547::_id_7ACD();
      }

      if(isDefined(var_0) && maps\mp\_utility::isreallyalive(var_0)) {
        self notify("reviveTriggerThinkZombies_cleanup");

        if(!isDefined(var_4))
          var_0 _id_04D1::_id_A18A(self, 0);
      }
    } else
      var_4 = 1;

    if(isDefined(var_4) && var_4) {
      if(isDefined(self._id_0117))
        self._id_0117 notify("revive_trigger", var_0);

      _id_476A(self._id_0117, var_0);
      break;
    }
  }
}

should_ignore_revive_attempt(var_0, var_1) {
  if(!isDefined(level.additional_player_revive_rules))
    return 0;

  foreach(var_3 in level.additional_player_revive_rules) {
    if([[var_3]](var_0, var_1))
      return 1;
  }

  return 0;
}

_id_476A(var_0, var_1) {
  var_2 = var_1;

  if(!isPlayer(var_2) && isPlayer(var_2._id_0117))
    var_2 = var_2._id_0117;

  if(isDefined(var_0) && isDefined(var_0._id_7E5E))
    var_2 maps\mp\gametypes\zombies::_id_4798(var_0._id_7E5E);

  _id_145A(var_2);

  if(isDefined(level.zmb_events_player_on_teammate_revived))
    [[level.zmb_events_player_on_teammate_revived]](var_0, var_1);
}

_id_145A(var_0) {
  if(!isDefined(var_0._id_7E62) || !isDefined(var_0._id_A986) || var_0._id_A986 != level._id_A980)
    var_0._id_7E62 = 0;

  var_0._id_7E62 = var_0._id_7E62 + 1;
  var_0._id_A986 = level._id_A980;

  if(var_0._id_7E62 < 3)
    var_0 _id_054C::_id_AC23("revive");
  else {}
}

_id_7E66(var_0) {
  common_scripts\utility::_id_A70C(self, "death", self, "reviveTriggerThinkZombies_cleanup");
  var_0 freezecontrols(0);
  var_0 allowfire(1);
  var_0 common_scripts\utility::_id_0617();
  var_0._id_57AB = 0;
}

_id_5BFD() {
  level endon("game_ended");
  var_0 = self._id_0117;
  var_0 endon("becameSpectator");
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 waittill("revive_trigger", var_1);
  var_2 = 0;

  if(var_0 _id_581E()) {
    var_2 = 1;

    if(!isDefined(var_0.numselfrevivedowns))
      var_0.numselfrevivedowns = 0;

    var_0.numselfrevivedowns++;
    setmatchdata("downs", var_0._id_32CE, "reviver_player_index", maps\mp\_utility::_id_2314(var_0.clientid));
    var_0 _id_056A::_id_95F0();
    var_1 = var_0;
  }

  if(isDefined(var_1) && isPlayer(var_1)) {
    var_1 maps\mp\_utility::incplayerstat("assists", 1);
    var_1 maps\mp\_utility::incpersstat("assists", 1);
    var_1._id_0021 = var_1 maps\mp\_utility::getpersstat("assists");

    if(var_1 != var_0) {
      var_0 thread _id_054E::_id_7448(var_1);
      var_0 thread maps\mp\gametypes\_hud_message::playercardsplashnotify("revived", var_1);
      _id_0555::issprinting("revived", var_1, var_0 getentitynumber());
      setmatchdata("downs", var_0._id_32CE, "reviver_player_index", maps\mp\_utility::_id_2314(var_1.clientid));
      var_1 maps\mp\gametypes\_persistence::statsetchild("round", "assists", var_1._id_0021);

      if(_id_0547::_id_577E(var_1))
        var_1._id_801C++;
    }
  }

  var_3 = _id_0547::_id_AC4B(var_0.origin, "revived");
  var_3 _id_0547::_id_AC47(var_0);
  var_3 _id_0547::_id_AC42("self_revive", var_2);
  var_3 _id_0547::_id_AC4D();
  var_4 = "ui_zm_character_" + var_0.characterclientindex + "_bleedout_endtime";
  _setomnvar(var_4, 0);

  if(var_0 isreloading()) {
    while(var_0 isreloading())
      waitframe();

    waitframe();
  }

  var_0 _id_7DB4(1);
  var_0 thread _id_0537::_id_6B7E(var_1);
}

_id_7E58() {
  self endon("death");

  if(isDefined(self._id_0117._id_7E5D))
    var_0 = self._id_0117._id_7E5D;
  else
    var_0 = undefined;

  self._id_0117 common_scripts\utility::_id_A70A("revive_trigger", "disconnect", "becameSpectator");

  if(isDefined(self._id_0117) && isDefined(self._id_0117._id_7E5D))
    self._id_0117._id_7E5D destroy();
  else if(isDefined(var_0))
    var_0 destroy();

  self delete();
}

_id_4777() {
  self._id_7708[self._id_479D]["lastStandAmmoInfo"] = _id_0586::_id_4129(self._id_479D);
  _id_0586::_id_0790(self._id_479D);
  self._id_479D = undefined;
  var_0 = undefined;

  if(issubstr(self._id_5B98, "turrethead")) {
    var_1 = -1;

    for(var_2 = 0; var_2 < self._id_7707.size; var_2++) {
      var_3 = _id_0548::_id_454B(self, self._id_7707[var_2]);
      var_4 = _id_0547::_id_4747(self, self._id_7707[var_2]);

      if(var_4 > var_1) {
        var_0 = var_3;
        var_1 = var_4;
      }
    }
  }

  if(!isDefined(var_0))
    var_0 = self._id_5B98;

  foreach(var_6 in self._id_7707)
  _id_47BC(var_6, 0);

  _id_0586::_id_078E(var_0, 1);
}

_id_7DB4(var_0) {
  self notify("revive");
  level notify("player_revived", self);
  self allowmelee(1);
  self._id_00E8 = undefined;
  self.inlaststand = 0;
  self._id_00BA = "";
  self.health = self.maxhealth;
  self._id_00CE = 0;
  self._id_509C = undefined;
  self._id_AC5B = 0;
  self._id_AC5C = undefined;
  self._id_172C = 0;
  self._id_5BD7 = gettime();

  if(self._id_32CE < level._id_6082) {
    var_1 = maps\mp\_utility::getsecondspassed();
    setmatchdata("downs", self._id_32CE, "spawn_time", maps\mp\_utility::_id_2315(var_1));
    var_2 = self.origin;
    setmatchdata("downs", self._id_32CE, "spawn_pos", 0, maps\mp\_utility::_id_2315(int(var_2[0])));
    setmatchdata("downs", self._id_32CE, "spawn_pos", 1, maps\mp\_utility::_id_2315(int(var_2[1])));
    setmatchdata("downs", self._id_32CE, "spawn_pos", 2, maps\mp\_utility::_id_2315(int(var_2[2])));
    setmatchdata("downs", self._id_32CE, "round_spawned", level._id_A980);
    self._id_32CE = level._id_32CF;
  }

  self hudoutlinedisable();
  self laststandrevive();

  if(isDefined(self._id_7E5D))
    self._id_7E5D destroy();

  if(common_scripts\utility::_id_562E(var_0)) {
    self setstance("stand");
    _id_4777();
    common_scripts\utility::_id_0614();

    if(isDefined(level._id_5F1D))
      [[level._id_5F1D]]();
  } else
    self notify("spectator_revive");

  self enableweaponswitch();
  thread _id_0547::_id_AC16(1, "laststand");
  self enableweapons();
  common_scripts\utility::_id_0615();
  _id_0547::_id_7ACD();
  maps\mp\_utility::clearlowermessage("last_stand");
  maps\mp\_utility::giveperk("specialty_pistoldeath");
  self allowsprint(1);
  checktemporaryperks();

  if(!_canspawn(self.origin))
    _id_0488::_id_A047(self, 0);
}

_id_1925() {
  return common_scripts\utility::_id_562E(level._id_1CBA);
}

_id_1926() {
  var_0 = common_scripts\utility::random(level._id_1CBB);
  return var_0.origin;
}

checktemporaryperks() {
  if(_id_0547::_id_4BA7("specialty_class_aftertaste_zm"))
    self _meth_866C(&"trigger_mod_proc_and_remove", 1, "specialty_class_aftertaste_zm");
}

_id_7E59() {
  self endon("disconnect");

  if(common_scripts\utility::_id_562E(self.is_reviving_from_spectate_mode)) {
    return;
  }
  if(common_scripts\utility::_id_562E(self._id_A6F0)) {
    return;
  }
  if(common_scripts\utility::_id_562E(self._id_A6F1)) {
    return;
  }
  if(common_scripts\utility::_id_562E(self._id_5DED)) {
    return;
  }
  var_0 = self.sessionstate;
  self.is_reviving_from_spectate_mode = 1;
  wait 1.0;

  if(!common_scripts\utility::_id_562E(self._id_0CA4))
    maps\mp\gametypes\_playerlogic::_id_50F8(self.team, "reviveFromSpectateMode");

  self._id_0CA4 = 1;
  self.pers["lives"] = 1;
  thread maps\mp\gametypes\_playerlogic::_id_9035();
  thread _id_0547::_id_865A(self._id_20D8, 0);
  wait 0.1;
  _id_7DB4(0);
  self.is_reviving_from_spectate_mode = 0;
}

_id_47BC(var_0, var_1) {
  _id_47AC(var_0, var_1);

  if(isDefined(self._id_7708[var_0]["fillMax"])) {
    self givemaxammo(var_0);
    self._id_7708[var_0]["fillMax"] = undefined;
  } else
    _id_0586::_id_0F21(var_0, self._id_7708[var_0]["ammoInfo"]);
}

_id_47AC(var_0, var_1) {
  _id_0586::_id_078C(var_0);

  if(var_1)
    _id_0586::_id_078E(var_0, 1);
}

setlaststandweaponammo(var_0) {
  if(!isDefined(self.givenlaststandammoround) || isDefined(self.givenlaststandammoround) && self.givenlaststandammoround < level._id_A980) {
    var_1 = _weaponclipsize(var_0, self);
    self setweaponammoclip(var_0, var_1, "right");

    if(issubstr(var_0, "akimbo"))
      self setweaponammoclip(var_0, var_1, "left");

    self setweaponammostock(var_0, var_1 * 3);
    self.givenlaststandammoround = level._id_A980;
  } else if(isDefined(self.givenlaststandammoround) && self.givenlaststandammoround >= level._id_A980 && isDefined(self._id_7708) && isDefined(self._id_7708[var_0]) && isDefined(self._id_7708[var_0]["lastStandAmmoInfo"]))
    _id_0586::_id_0F21(var_0, self._id_7708[var_0]["lastStandAmmoInfo"]);
}

_id_5BFC() {
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  self waittill("death");
  self._id_00E8 = undefined;
  self.inlaststand = 0;
  self._id_00CE = 0;
  self._id_509C = undefined;
  self._id_AC5B = 0;
  self._id_AC5C = undefined;
}

_id_5BED() {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");

  for(;;) {
    self.health = 2;
    waitframe();
    self.health = 1;
    waitframe();
  }
}

laststandmonitordeath() {
  self endon("disconnect");
  self endon("revive");
  self endon("player_bleedout");
  level endon("game_ended");
  self waittill("death");
  var_0 = "ui_zm_character_" + self.characterclientindex + "_alive";
  _setomnvar(var_0, 0);
  var_0 = "ui_zm_character_" + self.characterclientindex + "_bleedout_endtime";
  _setomnvar(var_0, 0);
}

_id_5BEE() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("revive_trigger");
  self endon("horde_end_spectate");
  self notify("monitor_abandonment");

  for(;;) {
    level waittill("player_disconnected");

    if(_id_3FD3(self)) {
      self._id_A219 = 1;

      if(self._id_32CE < level._id_6082)
        setmatchdata("downs", self._id_32CE, "died", 1);

      maps\mp\_utility::_suicide();
      _id_AC1F();
      return;
    }

    waitframe();
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

    if(_id_3FD3(self)) {
      _id_AC1F();
      return;
    }

    waitframe();
  }
}

_id_5BF8(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  var_0 endon("death");
  var_1 = (1, 1, 1);

  for(;;) {
    while(!var_0._id_54F5)
      waitframe();

    var_2 = self._id_7E5D.color;
    self._id_7E5D = _id_2826("hint_health_zm", 8, 8, var_1);

    while(var_0._id_54F5)
      waitframe();

    if(self._id_7E5D.color != var_1)
      var_2 = self._id_7E5D.color;

    self._id_7E5D = _id_2826("hint_health_zm", 8, 8, var_2);
  }
}

_id_5BF7(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  var_0 endon("death");
  maps\mp\_utility::_id_7210();
  wait(var_1 / 3);

  while(var_0._id_54F5)
    waitframe();

  self._id_7E5D.color = (1, 0.5, 0);
  maps\mp\_utility::_id_7210();
  wait(var_1 / 3);

  while(var_0._id_54F5)
    waitframe();

  self._id_7E5D.color = (0.99, 0.19, 0.22);
  maps\mp\_utility::_id_7210();
}

laststandwatchfordisconnectzombies(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("revive");
  level endon("game_ended");
  var_0 waittill("disconnect");
  _setomnvar(var_1, 0);
}

_id_5BF6(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  var_2 = gettime() + var_0 * 1000;
  var_3 = undefined;
  var_3 = "ui_zm_character_" + self.characterclientindex + "_bleedout_endtime";
  thread laststandwatchfordisconnectzombies(self, var_3);

  for(;;) {
    _setomnvar(var_3, var_2);
    level waittill("host_migration_begin");
    _setomnvar(var_3, 0);
    var_4 = maps\mp\gametypes\_hostmigration::_id_A782();
    var_2 = var_2 + var_4;
  }
}

_id_5BE9() {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  var_0 = 1.0;

  for(;;) {
    wait(var_0);
    var_1 = self getcurrentweapon();
    var_2 = self getammocount(var_1);

    if(var_2 == 0) {
      var_3 = _weaponclipsize(var_1);
      self setweaponammostock(var_1, var_3);
    }
  }
}

_id_0634(var_0) {
  var_1 = 30;

  if(_id_0547::_id_0F0F("specialty_class_preventative_medicine_zm"))
    var_1 = var_1 * 2.0;

  if(isDefined(level.players) && isDefined(var_0)) {
    foreach(var_3 in level.players) {
      if(var_3 != var_0 && var_3 _id_0547::_id_4BA7("specialty_class_preventative_medicine_zm")) {
        var_0 _meth_866C(&"add_teammate_mod_buffs", 3, "specialty_class_preventative_medicine_zm", 1, var_3);
        break;
      }
    }
  }

  return int(var_1);
}

_id_53E2(var_0) {
  if(maps\mp\_utility::isreallyalive(self)) {
    self notify("revive_trigger", var_0);
    _id_476A(self, var_0);
  }
}