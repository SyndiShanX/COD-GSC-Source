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
  registerlaststandparameter(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  var_9 = _id_0547::_id_AC4B(self.origin, "last_stand");
  var_9 _id_0547::_id_AC47(self);
  var_9 _id_0547::_id_AC4D();

  if(level._id_32CF < level._id_6082) {
    self._id_32CE = level._id_32CF;
    level._id_32CF = level._id_32CF + 1;
    setmatchdata("down_count", maps\mp\_utility::clamptoshort(level._id_32CF));
    setmatchdata("downs", self._id_32CE, "round_downed", maps\mp\_utility::clamptoshort(level.wavecounter));
    setmatchdata("downs", self._id_32CE, "player_index", maps\mp\_utility::clamptobyte(self.clientid));
    var_10 = maps\mp\_utility::getsecondspassed();
    setmatchdata("downs", self._id_32CE, "down_time", maps\mp\_utility::clamptoshort(var_10));
    setmatchdata("downs", self._id_32CE, "down_pos", 0, maps\mp\_utility::clamptoshort(int(self.origin[0])));
    setmatchdata("downs", self._id_32CE, "down_pos", 1, maps\mp\_utility::clamptoshort(int(self.origin[1])));
    setmatchdata("downs", self._id_32CE, "down_pos", 2, maps\mp\_utility::clamptoshort(int(self.origin[2])));

    if(!common_scripts\utility::_id_562E(level.door_data_out_of_date)) {
      setmatchdata("downs", self._id_32CE, "down_zone_index", _id_0547::getplayerddlzonename());
    }

    if(_func_12A("MeansOfDeath", var_3)) {
      setmatchdata("downs", self._id_32CE, "means_of_death", var_3);
    }

    if(isDefined(var_1._id_0A4B) && _func_12A("ZombieType", var_1._id_0A4B)) {
      setmatchdata("downs", self._id_32CE, "attacker", var_1._id_0A4B);
    }
  } else
    self._id_32CE = level._id_6082;

  var_11 = self getcurrentprimaryweapon();

  if(maps\mp\_utility::_id_4431(var_11) == self._id_76D8) {
    self._id_A9BA[self._id_76D9]._id_32D0 = self._id_A9BA[self._id_76D9]._id_32D0 + 1;
  } else {
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
    self.uselaststandparams = 1;

    if(self._id_32CE < level._id_6082) {
      setmatchdata("downs", self._id_32CE, "died", 1);
    }

    self.numberofbleedouts++;
    maps\mp\_utility::_suicide();
    zombieendgame(undefined, var_3);
    return;
  }

  if(!_id_60AD(self)) {
    self.uselaststandparams = 0;

    if(self._id_32CE < level._id_6082) {
      setmatchdata("downs", self._id_32CE, "died", 1);
    }

    self.numberofbleedouts++;
    maps\mp\_utility::_suicide();

    if(level.players.size < 2) {
      zombieendgame(undefined, var_3);
    }

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
    if(var_14 > 0) {
      self _meth_85B9(-1 * var_14);
    }

    _id_0533::_id_2F9E(var_16);
  }

  _id_0547::_id_7ACD();

  if(isDefined(level._id_5F20)) {
    [[level._id_5F20]]();
  }

  self._id_479D = _id_AC5F();
  clearnightvisionfog();
  giveplayerweapon(self._id_479D, 1);
  setlaststandweaponammo(self._id_479D);
  thread _id_0547::zombieallowallboost(0, "laststand");
  common_scripts\utility::_id_0601();
  self disableweaponswitch();
  common_scripts\utility::_disableoffhandweapons();

  if(isDefined(var_3) && var_3 == "MOD_SUICIDE") {
    self _meth_8555();
  }

  thread laststandrevivezombie(var_0, var_1, var_4, var_7, var_3);

  if(!_id_4B87()) {
    thread _id_0576::lightsetforplayer();
  }

  thread _id_056A::_id_5BFE();

  if(isDefined(level._id_5BEB)) {
    self thread[[level._id_5BEB]]();
  }

  if(maps\mp\agents\_agent_utility::getnumownedactiveagents(self) > 0) {
    thread tryendgameafteragentsdie(var_3);
  }

  level._id_400E[level._id_400E.size] = ["assassin_set 3 -1", self];
  level._id_400E[level._id_400E.size] = ["survivalist_set 0 -1", self];
  level._id_400E[level._id_400E.size] = ["mountain_man_set 1 -1", self];
  level._id_400E[level._id_400E.size] = ["mountain_man_set 3 -1", self];
  level._id_400E[level._id_400E.size] = ["bat_elite_set 3 -1", self];
}

tryendgameafteragentsdie(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");

  while(maps\mp\agents\_agent_utility::getnumownedactiveagents(self) > 0) {
    waitframe();
  }

  if(_id_3FD3(self, 1)) {
    thread killplayerandendgameafteragentsdead(var_0);
  }
}

killplayerandendgameafteragentsdead(var_0) {
  level endon("game_ended");
  self.uselaststandparams = 1;

  if(self._id_32CE < level._id_6082) {
    setmatchdata("downs", self._id_32CE, "died", 1);
  }

  self.numberofbleedouts++;
  maps\mp\_utility::_suicide();
  zombieendgame(undefined, var_0);
}

clearnightvisionfog(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(_id_057A::_id_A260()) {
    _id_057A::_id_259D();
  }

  self.lastequippedweapon = self getcurrentprimaryweapon();
  var_1 = self getweaponlistprimaries();

  if(!isDefined(self.lastequippedweapon) || self.lastequippedweapon == "none" || _id_0547::_id_585B(self.lastequippedweapon) || !_id_0547::_id_5836(self.lastequippedweapon)) {
    self.lastequippedweapon = "none";

    foreach(var_3 in var_1) {
      var_4 = _getweaponbasename(var_3);

      if(_id_0547::_id_5836(var_4)) {
        self.lastequippedweapon = _id_0586::_id_0632(var_3);
        break;
      }
    }
  }

  self.primaryweapons = [];

  foreach(var_3 in var_1) {
    var_7 = _getweaponbasename(var_3);

    if(_id_0547::_id_5836(var_7)) {
      self.primaryweapons[self.primaryweapons.size] = _id_0586::_id_0632(var_3);
    }
  }

  if(self.lastequippedweapon == "search_dstry_bomb_defuse_mp" && isDefined(self.lastnonuseweapon) && isDefined(common_scripts\utility::_id_0F7E(self.primaryweapons, self.lastnonuseweapon))) {
    self.lastequippedweapon = self.lastnonuseweapon;
  }

  if(issubstr(self.lastequippedweapon, "killstreak")) {
    self.lastequippedweapon = self.primaryweapons[0];
  }

  foreach(var_3 in self.primaryweapons) {
    self.primaryweaponsammo[var_3]["ammoInfo"] = _id_0586::_id_4129(var_3);
  }

  self.tombstoneweapon = self.lastequippedweapon;
  self.tombstoneweaponlevel = _id_0547::getzombieweaponlevel(self, self.tombstoneweapon);

  if(issubstr(self.tombstoneweapon, "titan")) {
    self.tombstoneweaponlevel = 0;
  }

  foreach(var_12 in self.primaryweapons) {
    if(!issubstr(var_12, "titan")) {
      if(var_0) {
        _id_0586::_id_0790(var_12);
      }

      var_13 = _id_0547::getzombieweaponlevel(self, var_12);

      if(var_13 > self.tombstoneweaponlevel) {
        self.tombstoneweapon = var_12;
        self.tombstoneweaponlevel = var_13;
      }
    }
  }
}

refillstoredweaponammo() {
  foreach(var_1 in self.primaryweapons) {
    self.primaryweaponsammo[var_1]["fillMax"] = 1;
  }
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

    if(isDefined(var_9)) {
      return var_9;
    } else {
      return "m1911_pap_zm";
    }
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
    if(var_0 _id_4B87()) {
      return 0;
    }

    if(var_0 _id_0547::_id_73BF()) {
      return 0;
    }

    if(isDefined(var_1) && var_1 == "MOD_SUICIDE") {
      return 1;
    }
  }

  if(_id_0547::_id_0F51(var_0, 1)) {
    return 0;
  } else {
    if(isDefined(var_2) && var_2 && _id_0F50(var_0)) {
      return 0;
    }

    if(var_0 _id_0547::_id_73BF()) {
      return 0;
    }
  }

  var_0.deathtime = gettime();
  return 1;
}

_id_3FD3(var_0, var_1, var_2) {
  if(level.players.size <= 1) {
    if(_id_0547::isplayerinlaststand(var_0) && var_0 _id_4B87()) {
      return 0;
    }

    if(_id_0547::_id_577A(var_0, 1)) {
      return 0;
    }

    if(isDefined(var_1) && var_1 == "MOD_SUICIDE") {
      return 1;
    }
  }

  if(_id_0547::_id_0F51(var_0, 1)) {
    return 0;
  } else if(isDefined(var_2) && var_2 && _id_0F50(var_0)) {
    return 0;
  }

  var_0.deathtime = gettime();
  return 1;
}

_id_0F50(var_0) {
  var_1 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

  foreach(var_3 in var_1) {
    if(!_isalliedsentient(var_3, var_0)) {
      continue;
    }
    if(_isalliedsentient(var_3, var_0) && common_scripts\utility::_id_562E(var_3.shouldnotpreventlaststand)) {
      continue;
    }
    if(_id_0547::isplayerinlaststand(var_3)) {
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
    var_2 = _id_0547::_id_4745(var_1, "totalTimePlayed") + var_1.timeplayed["total"];
    var_3 = _id_0547::_id_4745(var_1, "totalGames");
    setmatchdata("players", var_1.clientid, "end_total_time_played", var_2);
    setmatchdata("players", var_1.clientid, "end_zm_games_played", var_3 + 1);
    var_4 = _id_0547::_id_4745(var_1, "totalHeadshots") + var_1._id_4BF7;
    var_5 = _id_0547::_id_4745(var_1, "totalKills") + var_1._id_00E3;
    var_6 = _id_0547::_id_4745(var_1, "totalRevives") + var_1._id_0021;
    var_7 = _id_0547::_id_4745(var_1, "totalMoneyEarned") + var_1.moneyearnedtotal;
    var_8 = _id_0547::_id_4745(var_1, "totalRounds") + level.wavecounter;
    setmatchdata("players", var_1.clientid, "end_lifetime_headshots", var_4);
    setmatchdata("players", var_1.clientid, "end_lifetime_kills", var_5);
    setmatchdata("players", var_1.clientid, "end_lifetime_revives", var_6);
    setmatchdata("players", var_1.clientid, "end_lifetime_score", var_7);
    setmatchdata("players", var_1.clientid, "end_lifetime_waves", var_8);
    setmatchdata("players", var_1.clientid, "play_time", var_1.timeplayed["total"]);

    if(var_1._id_32CE < level._id_6082) {
      setmatchdata("downs", var_1._id_32CE, "died", 1);
    }
  }
}

zombieendgame(var_0, var_1, var_2) {
  if(!common_scripts\utility::_id_562E(var_2) && !_id_3FD3(self, var_1)) {
    return 0;
  }

  if(game["state"] == "postgame" || level.gameended) {
    return;
  }
  _id_7B38();
  level.finalkillcam_winner = level.enemyteam;

  if(!isDefined(var_0)) {
    var_0 = "survivors_eliminated";
  }

  if(common_scripts\utility::_id_562E(level.iszombiesshotgun)) {
    var_3 = common_scripts\utility::_id_562E(level.zmb_shotgun_game_won);
  } else {
    var_3 = isDefined(var_0) && var_0 == "zombies_completed";
  }

  if(var_3) {
    level.finalkillcam_winnter = level.playerteam;

    if(!_func_371()) {
      _func_3C1();
    }
  } else if(!_func_371())
    _func_3C2();

  level thread maps\mp\gametypes\_gamelogic::endgame(level.finalkillcam_winner, game["end_reason"][var_0]);
  setnojipscore(0);
  _setnojipscore(0);
  maps\mp\_utility::delaythread(0.05, _id_0554::changezombiemusic, "game_over");
}

_id_60AD(var_0) {
  if(var_0 maps\mp\_utility::touchingbadtrigger()) {
    return 0;
  }

  return 1;
}

registerlaststandparameter(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.einflictor = var_0;
  var_7.attacker = var_1;
  var_7.idamage = var_2;
  var_7.attackerposition = var_1.origin;
  var_7.smeansofdeath = var_3;
  var_7.sweapon = var_4;
  var_7.vdir = var_5;
  var_7.shitloc = var_6;
  var_7.laststandstarttime = gettime();

  if(isDefined(var_1) && isPlayer(var_1) && var_1 getcurrentprimaryweapon() != "none") {
    var_7.sprimaryweapon = var_1 getcurrentprimaryweapon();
  } else {
    var_7.sprimaryweapon = undefined;
  }

  self.laststandparams = var_7;
}

_id_4B86() {
  return isDefined(self._id_6F66) && isDefined(self._id_6F66["quickrevive"]);
}

_id_4B87() {
  return level.players.size <= 1 && _id_4B86();
}

_id_A233() {
  _id_0555::issprinting("blitz_revive", self);
  thread laststandselfrevive();
  level thread killnotification(self);
}

laststandrevivezombie(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  level notify("player_last_stand");
  self notify("force_cancel_placement");
  var_5 = _id_0634(self);
  _id_0555::issprinting("down", self);
  thread _id_054E::_id_741A();
  thread laststandwaittilldeathzombies();
  thread _id_5BED();
  thread _id_5BEE();
  thread laststandmonitordeath();
  var_6 = spawn("script_model", self.origin);
  var_6 setModel("tag_origin");
  var_6 setCursorHint("HINT_NOICON");
  var_6 setHintString(&"PLATFORM_REVIVE");
  var_6 makeusable();
  var_6.inuse = 0;
  var_6.curprogress = 0;
  var_6.usetime = level.laststandusetime;
  var_6.userate = 1;
  var_6.id = "last_stand";
  var_6.targetname = "revive_trigger";
  var_6._id_0117 = self;
  var_6 linkTo(self, "tag_origin", (0, 0, 20), (0, 0, 0));
  var_6 thread maps\mp\gametypes\_damage::deleteonreviveordeathordisconnect();
  self.reviveicon = createreviveicon("hint_health_zm", 8, 8, (0.5, 1, 0.99));
  thread laststandupdatereviveiconcolorzombies(var_6, var_5);
  thread laststandupdatereviveiconzombies(var_6);
  self hudoutlineenable(1, 0);
  var_6 thread reviveentmonitor();
  var_6 thread _id_7E65();
  var_6 thread laststandwaittilllifereceived();

  if(_id_581E()) {
    _id_A233();
    thread _id_5BE9();
  } else {
    _id_0F34(self);
    thread _id_5BF6(var_5, var_6);
  }

  var_6 endon("death");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_5);

  while(isDefined(var_6.inuse) && var_6.inuse) {
    waitframe();
  }

  if(isDefined(self.laststandlastmomentcallback)) {
    self[[self.laststandlastmomentcallback]]();
  }

  if(isDefined(self.linkedbubblefx)) {
    playFX(common_scripts\utility::getfx("force_zombie_bubble_pop"), self.origin);
    self.linkedbubblefx delete();
  }

  self hudoutlinedisable();
  self disableweapons();
  thread bleedout();
}

_id_581E() {
  return _id_4B87();
}

createreviveicon(var_0, var_1, var_2, var_3) {
  if(isDefined(self.reviveicon)) {
    self.reviveicon destroy();
  }

  var_4 = _newteamhudelem(self.team);
  var_4 setshader(var_0, var_1, var_2);
  var_4 setwaypoint(1, 1);
  var_4 settargetEnt(self);
  var_4.color = var_3;
  return var_4;
}

_id_0F34(var_0) {
  var_1 = maps\mp\gametypes\zombies::getcurrentmoney(var_0);
  var_2 = int(var_1 * 0.1);
  var_3 = int(common_scripts\utility::mod(var_2, 10));
  var_2 = var_2 - var_3;
  var_0 maps\mp\gametypes\zombies::spendmoney(var_2);
  var_0.revivemoneyaward = var_2;
}

bleedout() {
  self notify("bleedout");
  level notify("player_bleedout", self);
  var_0 = _id_0547::_id_AC4B(self.origin, "bleedout");
  var_0 _id_0547::_id_AC47(self);
  var_0 _id_0547::_id_AC4D();

  if(isDefined(self.reviveicon)) {
    self.reviveicon destroy();
  }

  var_1 = "ui_zm_character_" + self.characterclientindex + "_alive";
  _setomnvar(var_1, 0);
  var_1 = "ui_zm_character_" + self.characterclientindex + "_bleedout_endtime";
  _setomnvar(var_1, 0);

  if(self._id_32CE < level._id_6082) {
    setmatchdata("downs", self._id_32CE, "died", 1);
  }

  self.numberofbleedouts++;
  self suicide();

  if(_id_3FD3(self)) {
    zombieendgame();
  } else {
    _id_0554::changezombiemusic("player_died", self);
    _id_0555::issprinting("dead", self);
  }
}

laststandselfrevive() {
  self endon("disconnect");
  self setclientomnvar("ui_use_bar_text", 3);
  self setclientomnvar("ui_use_bar_start_time", int(gettime()));
  self.curprogress = 0;
  self.userate = 1;
  self.usetime = 8000;
  var_0 = -1;

  while(maps\mp\_utility::isreallyalive(self) && isDefined(self._id_00E8) && !level.gameended) {
    var_1 = int(gettime());
    self setclientomnvar("ui_use_bar_current_time", var_1);

    if(var_0 != self.userate) {
      if(self.curprogress > self.usetime) {
        self.curprogress = self.usetime;
      }

      if(self.userate > 0) {
        var_2 = gettime();
        var_3 = self.curprogress / self.usetime;
        var_4 = var_2 + (1 - var_3) * (self.usetime / self.userate);
        self setclientomnvar("ui_use_bar_end_time", int(var_4));
      }

      var_0 = self.userate;
    }

    waitframe();
  }

  self setclientomnvar("ui_use_bar_end_time", 0);
}

killnotification(var_0) {
  while(!level.gameended && maps\mp\_utility::isreallyalive(var_0) && var_0.curprogress < var_0.usetime) {
    var_0.curprogress = var_0.curprogress + 50 * var_0.userate;

    if(var_0.curprogress >= var_0.usetime) {
      var_0 notify("revive_trigger");
    }

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

    if(var_2 && var_3) {
      var_1 = 0;
    } else if(var_2) {
      var_1 = var_1 * 0.5;
    } else if(var_3) {
      var_1 = var_1 * 0.5;
    }

    if(var_1 > 0) {
      self.curprogress = 0;
      self.inuse = 1;
      self._id_0117.beingrevived = 1;
      self._id_0117 _id_0547::_id_7ACD();
      var_0 freezecontrols(1);
      var_0 common_scripts\utility::_id_0603();
      var_0 allowfire(0);
      var_0.isreviving = 1;
      thread revivetriggerthinkzombies_cleanup(var_0);
      var_4 = maps\mp\gametypes\_damage::reviveholdthink(var_0, var_1, 0);
      self.inuse = 0;

      if(isDefined(self._id_0117)) {
        self._id_0117.beingrevived = 0;
        self._id_0117 _id_0547::_id_7ACD();
      }

      if(isDefined(var_0) && maps\mp\_utility::isreallyalive(var_0)) {
        self notify("reviveTriggerThinkZombies_cleanup");

        if(!isDefined(var_4)) {
          var_0 _id_04D1::updateuiprogress(self, 0);
        }
      }
    } else
      var_4 = 1;

    if(isDefined(var_4) && var_4) {
      if(isDefined(self._id_0117)) {
        self._id_0117 notify("revive_trigger", var_0);
      }

      _id_476A(self._id_0117, var_0);
      break;
    }
  }
}

should_ignore_revive_attempt(var_0, var_1) {
  if(!isDefined(level.additional_player_revive_rules)) {
    return 0;
  }

  foreach(var_3 in level.additional_player_revive_rules) {
    if([[var_3]](var_0, var_1)) {
      return 1;
    }
  }

  return 0;
}

_id_476A(var_0, var_1) {
  var_2 = var_1;

  if(!isPlayer(var_2) && isPlayer(var_2._id_0117)) {
    var_2 = var_2._id_0117;
  }

  if(isDefined(var_0) && isDefined(var_0.revivemoneyaward)) {
    var_2 maps\mp\gametypes\zombies::_id_4798(var_0.revivemoneyaward);
  }

  _id_145A(var_2);

  if(isDefined(level.zmb_events_player_on_teammate_revived)) {
    [[level.zmb_events_player_on_teammate_revived]](var_0, var_1);
  }
}

_id_145A(var_0) {
  if(!isDefined(var_0._id_7E62) || !isDefined(var_0._id_A986) || var_0._id_A986 != level.wavecounter) {
    var_0._id_7E62 = 0;
  }

  var_0._id_7E62 = var_0._id_7E62 + 1;
  var_0._id_A986 = level.wavecounter;

  if(var_0._id_7E62 < 3) {
    var_0 _id_054C::_id_AC23("revive");
  } else {}
}

revivetriggerthinkzombies_cleanup(var_0) {
  common_scripts\utility::waittill_any_ents(self, "death", self, "reviveTriggerThinkZombies_cleanup");
  var_0 freezecontrols(0);
  var_0 allowfire(1);
  var_0 common_scripts\utility::_id_0617();
  var_0.isreviving = 0;
}

laststandwaittilllifereceived() {
  level endon("game_ended");
  var_0 = self._id_0117;
  var_0 endon("becameSpectator");
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 waittill("revive_trigger", var_1);
  var_2 = 0;

  if(var_0 _id_581E()) {
    var_2 = 1;

    if(!isDefined(var_0.numselfrevivedowns)) {
      var_0.numselfrevivedowns = 0;
    }

    var_0.numselfrevivedowns++;
    setmatchdata("downs", var_0._id_32CE, "reviver_player_index", maps\mp\_utility::clamptobyte(var_0.clientid));
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
      setmatchdata("downs", var_0._id_32CE, "reviver_player_index", maps\mp\_utility::clamptobyte(var_1.clientid));
      var_1 maps\mp\gametypes\_persistence::statsetchild("round", "assists", var_1._id_0021);

      if(_id_0547::isplayerinlaststand(var_1)) {
        var_1._id_801C++;
      }
    }
  }

  var_3 = _id_0547::_id_AC4B(var_0.origin, "revived");
  var_3 _id_0547::_id_AC47(var_0);
  var_3 _id_0547::_id_AC42("self_revive", var_2);
  var_3 _id_0547::_id_AC4D();
  var_4 = "ui_zm_character_" + var_0.characterclientindex + "_bleedout_endtime";
  _setomnvar(var_4, 0);

  if(var_0 isreloading()) {
    while(var_0 isreloading()) {
      waitframe();
    }

    waitframe();
  }

  var_0 respawnplayerzombies(1);
  var_0 thread _id_0537::_id_6B7E(var_1);
}

reviveentmonitor() {
  self endon("death");

  if(isDefined(self._id_0117.reviveicon)) {
    var_0 = self._id_0117.reviveicon;
  } else {
    var_0 = undefined;
  }

  self._id_0117 common_scripts\utility::waittill_any("revive_trigger", "disconnect", "becameSpectator");

  if(isDefined(self._id_0117) && isDefined(self._id_0117.reviveicon)) {
    self._id_0117.reviveicon destroy();
  } else if(isDefined(var_0)) {
    var_0 destroy();
  }

  self delete();
}

_id_4777() {
  self.primaryweaponsammo[self._id_479D]["lastStandAmmoInfo"] = _id_0586::_id_4129(self._id_479D);
  _id_0586::_id_0790(self._id_479D);
  self._id_479D = undefined;
  var_0 = undefined;

  if(issubstr(self.lastequippedweapon, "turrethead")) {
    var_1 = -1;

    for(var_2 = 0; var_2 < self.primaryweapons.size; var_2++) {
      var_3 = _id_0548::_id_454B(self, self.primaryweapons[var_2]);
      var_4 = _id_0547::getzombieweaponlevel(self, self.primaryweapons[var_2]);

      if(var_4 > var_1) {
        var_0 = var_3;
        var_1 = var_4;
      }
    }
  }

  if(!isDefined(var_0)) {
    var_0 = self.lastequippedweapon;
  }

  foreach(var_6 in self.primaryweapons) {
    givestoredweapon(var_6, 0);
  }

  _id_0586::_id_078E(var_0, 1);
}

respawnplayerzombies(var_0) {
  self notify("revive");
  level notify("player_revived", self);
  self allowmelee(1);
  self._id_00E8 = undefined;
  self.inlaststand = 0;
  self._id_00BA = "";
  self.health = self.maxhealth;
  self._id_00CE = 0;
  self.ignoremecount = undefined;
  self.zombiesignoreme = 0;
  self.zombiesignoremecount = undefined;
  self.beingrevived = 0;
  self.lastrevivetime = gettime();

  if(self._id_32CE < level._id_6082) {
    var_1 = maps\mp\_utility::getsecondspassed();
    setmatchdata("downs", self._id_32CE, "spawn_time", maps\mp\_utility::clamptoshort(var_1));
    var_2 = self.origin;
    setmatchdata("downs", self._id_32CE, "spawn_pos", 0, maps\mp\_utility::clamptoshort(int(var_2[0])));
    setmatchdata("downs", self._id_32CE, "spawn_pos", 1, maps\mp\_utility::clamptoshort(int(var_2[1])));
    setmatchdata("downs", self._id_32CE, "spawn_pos", 2, maps\mp\_utility::clamptoshort(int(var_2[2])));
    setmatchdata("downs", self._id_32CE, "round_spawned", level.wavecounter);
    self._id_32CE = level._id_32CF;
  }

  self hudoutlinedisable();
  self laststandrevive();

  if(isDefined(self.reviveicon)) {
    self.reviveicon destroy();
  }

  if(common_scripts\utility::_id_562E(var_0)) {
    self setstance("stand");
    _id_4777();
    common_scripts\utility::_id_0614();

    if(isDefined(level._id_5F1D)) {
      [[level._id_5F1D]]();
    }
  } else
    self notify("spectator_revive");

  self enableweaponswitch();
  thread _id_0547::zombieallowallboost(1, "laststand");
  self enableweapons();
  common_scripts\utility::_id_0615();
  _id_0547::_id_7ACD();
  maps\mp\_utility::clearlowermessage("last_stand");
  maps\mp\_utility::giveperk("specialty_pistoldeath");
  self allowsprint(1);
  checktemporaryperks();

  if(!_canspawn(self.origin)) {
    _id_0488::unresolved_collision_nearest_node(self, 0);
  }
}

_id_1925() {
  return common_scripts\utility::_id_562E(level._id_1CBA);
}

_id_1926() {
  var_0 = common_scripts\utility::random(level._id_1CBB);
  return var_0.origin;
}

checktemporaryperks() {
  if(_id_0547::_id_4BA7("specialty_class_aftertaste_zm")) {
    self setdot_radius(&"trigger_mod_proc_and_remove", 1, "specialty_class_aftertaste_zm");
  }
}

revivefromspectatemode() {
  self endon("disconnect");

  if(common_scripts\utility::_id_562E(self.is_reviving_from_spectate_mode)) {
    return;
  }
  if(common_scripts\utility::_id_562E(self.waitingtospawn)) {
    return;
  }
  if(common_scripts\utility::_id_562E(self.waitingtospawnamortize)) {
    return;
  }
  if(common_scripts\utility::_id_562E(self.loadingplayerweapons)) {
    return;
  }
  var_0 = self.sessionstate;
  self.is_reviving_from_spectate_mode = 1;
  wait 1.0;

  if(!common_scripts\utility::_id_562E(self._id_0CA4)) {
    maps\mp\gametypes\_playerlogic::incrementalivecount(self.team, "reviveFromSpectateMode");
  }

  self._id_0CA4 = 1;
  self.pers["lives"] = 1;
  thread maps\mp\gametypes\_playerlogic::spawnclient();
  thread _id_0547::setcustomcharacter(self.characterindex, 0);
  wait 0.1;
  respawnplayerzombies(0);
  self.is_reviving_from_spectate_mode = 0;
}

givestoredweapon(var_0, var_1) {
  giveplayerweapon(var_0, var_1);

  if(isDefined(self.primaryweaponsammo[var_0]["fillMax"])) {
    self givemaxammo(var_0);
    self.primaryweaponsammo[var_0]["fillMax"] = undefined;
  } else
    _id_0586::_id_0F21(var_0, self.primaryweaponsammo[var_0]["ammoInfo"]);
}

giveplayerweapon(var_0, var_1) {
  _id_0586::_id_078C(var_0);

  if(var_1) {
    _id_0586::_id_078E(var_0, 1);
  }
}

setlaststandweaponammo(var_0) {
  if(!isDefined(self.givenlaststandammoround) || isDefined(self.givenlaststandammoround) && self.givenlaststandammoround < level.wavecounter) {
    var_1 = _weaponclipsize(var_0, self);
    self setweaponammoclip(var_0, var_1, "right");

    if(issubstr(var_0, "akimbo")) {
      self setweaponammoclip(var_0, var_1, "left");
    }

    self setweaponammostock(var_0, var_1 * 3);
    self.givenlaststandammoround = level.wavecounter;
  } else if(isDefined(self.givenlaststandammoround) && self.givenlaststandammoround >= level.wavecounter && isDefined(self.primaryweaponsammo) && isDefined(self.primaryweaponsammo[var_0]) && isDefined(self.primaryweaponsammo[var_0]["lastStandAmmoInfo"]))
    _id_0586::_id_0F21(var_0, self.primaryweaponsammo[var_0]["lastStandAmmoInfo"]);
}

laststandwaittilldeathzombies() {
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  self waittill("death");
  self._id_00E8 = undefined;
  self.inlaststand = 0;
  self._id_00CE = 0;
  self.ignoremecount = undefined;
  self.zombiesignoreme = 0;
  self.zombiesignoremecount = undefined;
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
      self.uselaststandparams = 1;

      if(self._id_32CE < level._id_6082) {
        setmatchdata("downs", self._id_32CE, "died", 1);
      }

      maps\mp\_utility::_suicide();
      zombieendgame();
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
      zombieendgame();
      return;
    }

    waitframe();
  }
}

laststandupdatereviveiconzombies(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  var_0 endon("death");
  var_1 = (1, 1, 1);

  for(;;) {
    while(!var_0.inuse) {
      waitframe();
    }

    var_2 = self.reviveicon.color;
    self.reviveicon = createreviveicon("hint_health_zm", 8, 8, var_1);

    while(var_0.inuse) {
      waitframe();
    }

    if(self.reviveicon.color != var_1) {
      var_2 = self.reviveicon.color;
    }

    self.reviveicon = createreviveicon("hint_health_zm", 8, 8, var_2);
  }
}

laststandupdatereviveiconcolorzombies(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  var_0 endon("death");
  maps\mp\_utility::playdeathsound();
  wait(var_1 / 3);

  while(var_0.inuse) {
    waitframe();
  }

  self.reviveicon.color = (1, 0.5, 0);
  maps\mp\_utility::playdeathsound();
  wait(var_1 / 3);

  while(var_0.inuse) {
    waitframe();
  }

  self.reviveicon.color = (0.99, 0.19, 0.22);
  maps\mp\_utility::playdeathsound();
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
    var_4 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
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

  if(_id_0547::_id_0F0F("specialty_class_preventative_medicine_zm")) {
    var_1 = var_1 * 2.0;
  }

  if(isDefined(level.players) && isDefined(var_0)) {
    foreach(var_3 in level.players) {
      if(var_3 != var_0 && var_3 _id_0547::_id_4BA7("specialty_class_preventative_medicine_zm")) {
        var_0 setdot_radius(&"add_teammate_mod_buffs", 3, "specialty_class_preventative_medicine_zm", 1, var_3);
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