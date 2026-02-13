/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1961.gsc
*************************************************/

init() {
  setdvarifuninitialized("#x3ec2c78c164a901ed", 0);
  level._id_1767 = spawnStruct();
  level._id_1767._id_A4C2 = 0;
  level._id_1767._id_A4BB = 0;
  level._id_1767._id_A49B = 0;

  if(!_id_1763()) {
    return;
  }
  thread _id_10AFD();

  if(_id_1768()) {
    thread _id_97A6();
    thread _id_9753();
    thread _id_9775();
  }
}

_id_1763() {
  if(_id_176F()) {
    return 1;
  }

  if(_id_1768()) {
    return 1;
  }

  return 0;
}

_id_1768() {
  return getdvarint("#x3ec2c78c164a901ed") == 1;
}

_id_6E24() {
  var_0 = level._id_1767._id_A4BB;
  level._id_1767._id_A4BB++;
  return var_0;
}

_id_2EAA(var_0) {
  if(!isDefined(self._id_1767._id_2EA5)) {
    self._id_1767._id_2EA5 = 0;
  }

  self._id_1767._id_2EA5 = self._id_1767._id_2EA5 | var_0;
}

_id_10AFD() {
  if(!_id_1763()) {
    return;
  }
  for(;;) {
    level waittill("connected", var_0);
    var_0 _id_9779();
    var_0 thread _id_10AF4();
    var_0 thread _id_10B3E();
    var_0 thread _id_10B5A();
  }
}

_id_10AF4() {
  self endon("disconnect");

  if(!_id_1768()) {
    return;
  }
  for(;;) {
    var_0 = scripts\engine\utility::_id_108A2("adjustedStance", "jumped", "weapon_fired", "reload_start", "spawned_player");

    if(var_0 == "adjustedStance") {
      _id_3560();
      continue;
    }

    if(var_0 == "jumped") {
      _id_2EAA(4);
      continue;
    }

    if(var_0 == "weapon_fired") {
      _id_2EAA(8);
      continue;
    }

    if(var_0 == "reload_start") {
      _id_2EAA(16);
      continue;
    }

    if(var_0 == "spawned_player") {
      thread _id_977E();
      thread _id_9787();
    }
  }
}

_id_10B3E() {
  self endon("disconnect");

  if(!_id_1768()) {
    return;
  }
  for(;;) {
    var_0 = scripts\engine\utility::_id_108A0("doubleJumpBegin", "doubleJumpEnd", "sprint_slide_begin");

    if(var_0 == "doubleJumpBegin") {
      _id_2EAA(64);
      continue;
    }

    if(var_0 == "doubleJumpEnd") {
      _id_2EAA(128);
      continue;
    }

    if(var_0 == "sprint_slide_begin") {
      _id_2EAA(256);
    }
  }
}

_id_10B5A() {
  self endon("disconnect");

  if(isai(self)) {
    return;
  }
  if(getdvarint("#x3decf448ab3afab5f", 0) == 0) {
    return;
  }
  self notifyonplayercommand("log_user_event_start", "+actionslot 3");
  self notifyonplayercommand("log_user_event_end", "-actionslot 3");
  self notifyonplayercommand("log_user_event_generic_event", "+gostand");

  for(;;) {
    self waittill("log_user_event_start");
    var_0 = scripts\engine\utility::_id_10897("log_user_event_end", "log_user_event_generic_event");

    if(isDefined(var_0) && var_0 == "log_user_event_generic_event") {
      self iprintlnbold("Event Logged");
      _id_9774(self.name, self.origin, "Generic User Event");
    }
  }
}

_id_3560() {
  var_0 = self getstance();

  if(var_0 == "prone") {
    _id_2EAA(1);
  } else if(var_0 == "crouch") {
    _id_2EAA(2);
  }
}

_id_9753() {
  if(!_id_1768()) {
    return;
  }
  for(;;) {
    var_0 = gettime();
    var_1 = level.players;

    foreach(var_3 in var_1) {
      if(!_id_DB9E(var_3)) {
        continue;
      }
      if(isDefined(var_3) && scripts\mp\utility\player::isreallyalive(var_3)) {
        var_3 _id_9778();
        var_3 _id_9783();
        waitframe();
      }
    }

    wait(max(0.05, 1.5 - (gettime() - var_0) / 1000));
  }
}

_id_C142() {
  level endon("game_ended");

  if(!_func_0437("dlog_event_breadcrumbs")) {
    return;
  }
  if(isDefined(scripts\mp\utility\game::getgametype()) && scripts\mp\utility\game::getgametype() == "br") {
    var_0 = getdvarfloat("#x32e648476cea761c9", 4.0);
  } else {
    var_0 = getdvarfloat("#x3ef49310374938e00", 2.0);
  }

  _id_07D1::_id_60C2("prematch_done");

  for(;;) {
    var_1 = level.players.size;
    var_2 = gettime();

    for(var_3 = 0; var_3 < var_1; var_3 = var_3 + 20) {
      for(var_4 = 0; var_4 < 20; var_4++) {
        var_5 = var_3 + var_4;
        var_6 = level.players[var_5];

        if(!isDefined(var_6)) {
          continue;
        }
        if(!isDefined(var_6.team)) {
          continue;
        }
        if(!scripts\mp\utility\player::isreallyalive(var_6)) {
          continue;
        }
        if(var_6.team == "spectator") {
          continue;
        }
        if(var_6.sessionstate != "playing") {
          continue;
        }
        if(!isDefined(var_6._id_9BC0)) {
          continue;
        }
        if(!_id_07EE::_id_3193(var_6)) {
          continue;
        }
        var_7 = var_6 scripts\mp\utility\player::_id_8989();
        var_8 = _id_07EE::_id_6DE4(gettime());
        var_6 _meth_858E(var_8, var_6._id_9BC0, var_7);
      }

      waitframe();
    }

    var_9 = (gettime() - var_2) * 0.001;
    var_10 = max(var_0 - var_9, level._id_5F3A);
    wait(var_10);
  }
}

_id_6C1A() {
  var_0 = scripts\engine\utility::ter_op(isDefined(self._id_1767._id_2EA5), self._id_1767._id_2EA5, 0);

  if(self _meth_8498()) {
    var_0 = var_0 | 32;
  }

  return var_0;
}

_id_3969() {
  self._id_1767._id_2EA5 = 0;
  _id_3560();
}

_id_2D02() {
  var_0 = 0;
  var_1 = self getstance();

  if(var_1 == "prone") {
    var_0 = var_0 | 1;
  } else if(var_1 == "crouch") {
    var_0 = var_0 | 2;
  }

  if(self _meth_846A()) {
    var_0 = var_0 | 4;
  }

  if(isDefined(self._id_9042) && gettime() - self._id_9042 < 500) {
    var_0 = var_0 | 8;
  }

  if(self _meth_81E0()) {
    var_0 = var_0 | 16;
  }

  return var_0;
}

_id_2D04() {
  var_0 = "archetype=" + self._id_965F + ";" + "powerPrimary=" + self._id_966A + ";" + "powerSecondary=" + self._id_966B + ";" + "weaponPrimary\t =" + self._id_034C + ";" + "weaponSecondary =" + self._id_03B5 + ";";
  return var_0;
}

_id_2D0C(var_0) {
  var_1 = "";

  if(isDefined(var_0._id_8F9D)) {
    if(isDefined(var_0._id_8F9D["allies"])) {
      var_1 = var_1 + ("alliesBucket=" + var_0._id_8F9D["allies"] + ";");
    }

    if(isDefined(var_0._id_8F9D["axis"])) {
      var_1 = var_1 + ("axisBucket=" + var_0._id_8F9D["axis"] + ";");
    }
  }

  return var_1;
}

_id_9778() {
  if(!_id_DB9E(self)) {
    return;
  }
  var_0 = anglesToForward(self getplayerangles());
  _func_03BF("gamemp_path", ["playerid", self._id_1767._id_B6DA, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var_0[0], "gun_orienty", var_0[1], "gun_orientz", var_0[2], "action", _id_6C1A(), "health", _id_6D05()]);
  _id_3969();
}

_id_977E() {
  if(!_id_DB9E(self)) {
    return;
  }
  var_0 = isDefined(self._id_904C) && isDefined(self._id_904C._id_2C93) && self._id_904C._id_2C93;
  var_1 = anglesToForward(self.angles);
  _func_03BF("gamemp_spawn_in", ["playerid", self._id_1767._id_B6DA, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "orientx", var_1[0], "orienty", var_1[1], "orientz", var_1[2], "loadout", _id_2D04(), "type", scripts\engine\utility::ter_op(var_0, "Buddy", "Normal"), "team", self.team]);
}

_id_9779() {
  if(!_id_1763()) {
    return;
  }
  if(!isDefined(self._id_1767)) {
    self._id_1767 = spawnStruct();
  }

  self._id_1767._id_B6DA = level._id_1767._id_A4C2;
  level._id_1767._id_A4C2++;

  if(!_id_1768()) {
    return;
  }
  var_0 = undefined;

  if(isDefined(self._id_33DA)) {
    var_0 = self._id_33DA._id_EB09;
  } else {
    var_0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypeSuper");
  }

  var_1 = self getxuid();
  _func_03BF("gamemp_player_connect", ["playerid", self._id_1767._id_B6DA, "player_name", self.name, "player_xuid", var_1, "player_super_name", var_0]);
}

_id_977A(var_0, var_1, var_2) {
  if(!_id_DB9E(self) || !isPlayer(self)) {
    return;
  }
  var_3 = anglesToForward(self getplayerangles());
  var_4 = -1;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = "s";
  var_12 = 0;

  if(isDefined(var_0) && isPlayer(var_0)) {
    var_4 = var_0._id_1767._id_B6DA;

    if(isDefined(var_0.team)) {
      if(var_0.team == "axis") {
        var_11 = "a";
      } else {
        var_11 = "l";
      }
    }

    if(isDefined(var_0.origin)) {
      var_5 = var_0.origin[0];
      var_6 = var_0.origin[1];
      var_7 = var_0.origin[2];
    }

    if(isDefined(var_0._id_936C)) {
      var_12 = var_0._id_936C;
    }

    var_13 = anglesToForward(var_0 getplayerangles());

    if(isDefined(var_13)) {
      var_8 = var_13[0];
      var_9 = var_13[1];
      var_10 = var_13[2];
    }
  }

  var_14 = level._id_1767._id_A49B;
  level._id_1767._id_A49B++;
  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, "None");
  var_15 = "s";

  if(self.team == "axis") {
    var_15 = "a";
  } else {
    var_15 = "l";
  }

  _func_03BF("134death", ["playerid", self._id_1767._id_B6DA, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var_3[0], "gun_orienty", var_3[1], "gun_orientz", var_3[2], "weapon", var_2, "mean_of_death", scripts\engine\utility::ter_op(isDefined(var_1), var_1, "None"), "attackerid", var_4, "action", _id_2D02(), "server_death_id", var_14, "victim_life_index", self._id_936C, "attacker_life_index", var_12, "victim_team", var_15, "attacker_team", var_11, "attacker_pos_x", var_5, "attacker_pos_y", var_6, "attacker_pos_z", var_7, "attacker_gun_orientx", var_8, "attacker_gun_orienty", var_9, "attacker_gun_orientz", var_10, "victim_weapon", self._id_034C]);

  if(getdvarint("#x34cdd3d1e6c709199")) {
    var_16 = "NO_ATTACKER";

    if(isDefined(var_0) && isPlayer(var_0)) {
      var_16 = var_0 _meth_8270();
    }

    var_17 = self _meth_8270();
    _func_03BF("dlog_event_gamemp_death_mount", ["playerid", self._id_1767._id_B6DA, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var_3[0], "gun_orienty", var_3[1], "gun_orientz", var_3[2], "weapon", var_2, "mean_of_death", scripts\engine\utility::ter_op(isDefined(var_1), var_1, "None"), "attackerid", var_4, "action", _id_2D02(), "server_death_id", var_14, "victim_life_index", self._id_936C, "attacker_life_index", var_12, "victim_team", var_15, "attacker_team", var_11, "attacker_pos_x", var_5, "attacker_pos_y", var_6, "attacker_pos_z", var_7, "attacker_gun_orientx", var_8, "attacker_gun_orienty", var_9, "attacker_gun_orientz", var_10, "victim_weapon", self._id_034C, "attacker_mount_type", var_16, "victim_mount_type", var_17]);
  }

  if(isDefined(var_1) && _func_010F(var_1)) {
    _id_9765(scripts\engine\utility::ter_op(isDefined(var_2), var_2, "generic"), self.origin, var_0, 1.0);
  }

  if(isDefined(self._id_1DDE)) {
    foreach(var_19 in self._id_1DDE) {
      if(isDefined(var_19) && isPlayer(var_19) && var_19 != var_0) {
        _id_9762(var_19._id_1767._id_B6DA, var_14, var_2);
      }
    }
  }
}

_id_977C(var_0, var_1, var_2) {
  if(!_id_DB9E(self)) {
    return;
  }
  var_3 = anglesToForward(self getplayerangles());
  _func_03BF("gamemp_kill", ["playerid", self._id_1767._id_B6DA, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var_3[0], "gun_orienty", var_3[1], "gun_orientz", var_3[2], "weapon", scripts\engine\utility::ter_op(isDefined(var_2), var_2, "None"), "mean_of_kill", scripts\engine\utility::ter_op(isDefined(var_1), var_1, "None"), "victimid", scripts\engine\utility::ter_op(isDefined(var_0) && isPlayer(var_0), var_0._id_1767._id_B6DA, "-1"), "action", _id_2D02(), "attacker_health", _id_6D05(), "victim_pixel_count", 0]);
}

_id_9765(var_0, var_1, var_2, var_3, var_4) {
  if(!_id_1768()) {
    return;
  }
  if(!isDefined(var_4)) {
    var_4 = (1, 0, 0);
  }

  _func_03BF("gamemp_explosion", ["playerid", var_2._id_1767._id_B6DA, "x", var_1[0], "y", var_1[1], "z", var_1[2], "orientx", var_4[0], "orienty", var_4[1], "orientz", var_4[2], "duration", var_3, "type", var_0]);
}

_id_9787() {
  if(!_id_1768()) {
    return;
  }
  if(!isDefined(level._id_E34D)) {
    return;
  }
  foreach(var_1 in level._id_E34D) {
    _func_03BF("gamemp_spawn_point", ["x", var_1.origin[0], "y", var_1.origin[1], "z", var_1.origin[2], "allies_score", scripts\engine\utility::ter_op(isDefined(var_1._id_903B["allies"]), var_1._id_903B["allies"], 0), "axis_score", scripts\engine\utility::ter_op(isDefined(var_1._id_903B["axis"]), var_1._id_903B["axis"], 0), "allies_max_score", scripts\engine\utility::ter_op(isDefined(var_1._id_F37D), var_1._id_F37D, 0), "axis_max_score", scripts\engine\utility::ter_op(isDefined(var_1._id_F37D), var_1._id_F37D, 0), "state", _id_2D0C(var_1)]);
  }
}

_id_9769(var_0, var_1, var_2, var_3, var_4) {
  if(!_id_1768()) {
    return;
  }
  _func_03BF("gamemp_front_line", ["startx", var_0[0], "starty", var_0[1], "endx", var_1[0], "endy", var_1[1], "axis_centerx", var_3[0], "axis_centery", var_3[1], "allies_centerx", var_2[0], "allies_centery", var_2[1], "state", var_4]);
}

_id_976A(var_0, var_1, var_2, var_3, var_4) {
  if(!_id_1768()) {
    return;
  }
  _func_03BF("gamemp_object", ["uniqueid", var_1, "x", var_2[0], "y", var_2[1], "z", var_2[2], "ownerid", var_3, "type", var_0, "state", var_4]);
}

_id_9774(var_0, var_1, var_2) {
  if(!_id_1768()) {
    return;
  }
  _func_03BF("gamemp_message", ["ownerid", var_0, "x", var_1[0], "y", var_1[1], "z", var_1[2], "message", var_2]);
}

_id_978F(var_0) {
  if(!_id_1768()) {
    return;
  }
  bbPrint("gamemp_matchtags", "message %s", var_0);
}

_id_977F(var_0, var_1) {
  if(!_id_DB9E(self)) {
    return;
  }
  var_2 = anglesToForward(self.angles);
  _func_03BF("gamemp_power", ["ownerid", self._id_1767._id_B6DA, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "orientx", var_2[0], "orienty", var_2[1], "orientz", var_2[2], "type", var_0, "state", var_1]);
}

_id_9783() {
  if(!_id_DB9E(self)) {
    return;
  }
  var_0 = anglesToForward(self.angles);
  _func_03BF("gamemp_scoreboard", ["ownerid", self._id_1767._id_B6DA, "score", self._id_038F]);
}

_id_9775() {
  if(!_id_1768()) {
    return;
  }
  var_0 = getEntArray("minimap_corner", "targetname");

  if(!isDefined(var_0) || var_0.size != 2) {
    return;
  }
  _func_03BF("gamemp_map", ["cornera_x", var_0[0].origin[0], "cornera_y", var_0[0].origin[1], "cornerb_x", var_0[1].origin[0], "cornerb_y", var_0[1].origin[1], "north", _func_00B9()]);
}

_id_9762(var_0, var_1, var_2) {
  if(!_id_1768()) {
    return;
  }
  _func_03BF("gamemp_assists", ["playerid", var_0, "server_death_id", var_1, "weapon", var_2]);
}

_id_6D05() {
  return int(clamp(self.health, 0, 100000));
}

_id_DB9E(var_0) {
  if(!_id_1768()) {
    return 0;
  }

  if(!isDefined(var_0.team) || var_0.team == "spectator" || var_0.sessionstate != "playing" && var_0.sessionstate != "dead") {
    return 0;
  }

  return 1;
}

_id_97A6() {
  var_0 = getDvar("#x3a508f500ec367b3c", "");

  if(var_0 != "") {
    _id_978F(var_0);
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    _id_978F("OnlineMatch");
  } else if(getdvarint("#x310c28bb5d64c8c6d")) {
    _id_978F("PrivateMatch");
  } else if(!getdvarint("#x34e9ab8c76756925d")) {
    _id_978F("OfflineMatch");
  }
}

_id_978D(var_0, var_1, var_2, var_3) {
  if(!_id_1768()) {
    return;
  }
  var_4 = -1;

  if(isDefined(self._id_1767) && isDefined(self._id_1767._id_B6DA)) {
    var_4 = self._id_1767._id_B6DA;
  }

  _func_03BF("analytics_mp_supers", ["super_name", var_0, "time_to_use", var_1, "num_hits", var_2, "num_kills", var_3, "player_id", var_4]);
}

_id_978C(var_0) {
  if(!_id_1768()) {
    return;
  }
  var_1 = -1;

  if(isDefined(self._id_1767) && isDefined(self._id_1767._id_B6DA)) {
    var_1 = self._id_1767._id_B6DA;
  }

  _func_03BF("analytics_mp_super_earned", ["match_time", var_0, "player_id", var_1]);
}

_id_9763(var_0) {
  if(!_id_1768()) {
    return;
  }
  _func_03BF("analytics_mp_awards", ["award_message", var_0]);
}

_id_976D(var_0, var_1, var_2, var_3) {
  if(!_id_1768()) {
    return;
  }
  var_4 = -1;

  if(isDefined(self._id_1767) && isDefined(self._id_1767._id_B6DA)) {
    var_4 = self._id_1767._id_B6DA;
  }

  _func_03BF("analytics_mp_player_xp", ["current_prestige", var_0, "current_level", var_1, "xp_gained", var_2, "xp_source", var_3, "player_id", var_4]);
}

_id_976C(var_0, var_1, var_2, var_3, var_4) {
  if(!_id_1768()) {
    return;
  }
  var_5 = -1;

  if(isDefined(self._id_1767) && isDefined(self._id_1767._id_B6DA)) {
    var_5 = self._id_1767._id_B6DA;
  }

  var_6 = getcompleteweaponname(var_0);
  _func_03BF("analytics_mp_weapon_xp", ["weapon", var_6, "current_prestige", var_1, "current_level", var_2, "xp_gained", var_3, "xp_source", var_4, "player_id", var_5]);
}

_id_9784() {
  if(!_id_1768()) {
    return;
  }
  var_0 = [];
  var_1 = [];
  var_2 = 0;

  for(var_2 = 0; var_2 < 12; var_2++) {
    var_0[var_2] = 0;
    var_1[var_2] = "";
  }

  var_2 = 0;

  foreach(var_4 in level.players) {
    if(!isai(var_4)) {
      var_0[var_2] = var_4._id_1767._id_B6DA;
      var_1[var_2] = var_4 getxuid();
    }

    var_2 = var_2 + 1;
  }

  _func_03BF("analytics_match_player_index_init", ["player1_index", var_0[0], "player1_xuid", var_1[0], "player2_index", var_0[1], "player2_xuid", var_1[1], "player3_index", var_0[2], "player3_xuid", var_1[2], "player4_index", var_0[3], "player4_xuid", var_1[3], "player5_index", var_0[4], "player5_xuid", var_1[4], "player6_index", var_0[5], "player6_xuid", var_1[5], "player7_index", var_0[6], "player7_xuid", var_1[6], "player8_index", var_0[7], "player8_xuid", var_1[7], "player9_index", var_0[8], "player9_xuid", var_1[8], "player10_index", var_0[9], "player10_xuid", var_1[9], "player11_index", var_0[10], "player11_xuid", var_1[10], "player12_index", var_0[11], "player12_xuid", var_1[11]]);
}

_id_176F() {
  return getdvarint("#x39b14953cc5f8daf5") != 0;
}

_id_86C5(var_0, var_1) {
  return var_0 < var_1;
}

_id_1770() {
  if(isDefined(level._id_E28F) && isDefined(level._id_E300) && isDefined(level._id_A4D5)) {
    game["spawnCount"] = level._id_E28F;
    game["spawnIdsToBeInstrumented"] = level._id_E300;
    game["nextSpawnToBeInstrumented"] = level._id_A4D5;
  }
}

_id_1764() {
  if(isDefined(level._id_E28F) && isDefined(level._id_E300) && isDefined(level._id_A4D5)) {
    return 1;
  }

  return 0;
}

_id_1766() {
  var_0 = game["spawnCount"];
  var_1 = game["spawnIdsToBeInstrumented"];
  var_2 = game["nextSpawnToBeInstrumented"];

  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2)) {
    level._id_E28F = var_0;
    level._id_E300 = var_1;
    level._id_A4D5 = var_2;
  } else {
    level._id_E28F = 0;
    level._id_E300 = [];
    level._id_A4D5 = 0;
    var_3 = getdvarint("#x3903dd55eb1913172");
    var_4 = _id_1759();
    var_5 = [];

    for(var_6 = 0; var_6 < var_3; var_6++) {
      var_7 = randomintrange(20, var_4);

      if(isDefined(var_5[var_7])) {
        level._id_E300[var_6] = -1;
        continue;
      }

      var_5[var_7] = 1;
      level._id_E300[var_6] = var_7;
    }

    level._id_E300 = scripts\engine\utility::_id_1BD6(level._id_E300, ::_id_86C5);
  }
}

_id_176B(var_0) {
  if(isDefined(level._id_A4D5) && isDefined(level._id_E300)) {
    if(level._id_A4D5 < level._id_E300.size) {
      if(level._id_E300[level._id_A4D5] == -1) {
        level._id_A4D5++;
      }

      if(level._id_E300[level._id_A4D5] == var_0) {
        level._id_A4D5++;
        return 1;
      }
    }
  }

  return 0;
}

_id_176E(var_0, var_1, var_2, var_3) {
  var_4 = _id_6A70();
  var_5 = var_4._id_9E8B;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;

  if(isDefined(var_5)) {
    var_6 = var_5[0];
    var_7 = var_5[1];
    var_8 = var_5[2];
  }

  var_9 = 0;

  if(isDefined(var_4._id_EF6C)) {
    var_9 = var_4._id_EF6C;
  }

  var_10 = var_4.isactive[var_1];
  var_11 = 0;

  if(isDefined(var_4._id_4AA7) && isDefined(var_4._id_4AA7[var_1])) {
    var_11 = var_4._id_4AA7[var_1];
  }

  var_12 = level._id_E2F4._id_979B;
  var_13 = 0;

  if(isDefined(level._id_E2F4._id_2C92)) {
    var_13 = level._id_E2F4._id_2C92;
    level._id_E2F4._id_2C92 = 0;
  }

  _func_0332(var_6, var_7, var_8, var_9, var_3, var_10, var_11, var_2, var_12, var_13);
}

_id_176D(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(scripts\mp\utility\player::isreallyalive(var_4)) {
      var_5 = var_4 getplayerangles();
      var_6 = _func_0261(var_5);
      var_7 = var_4.origin[0];
      var_8 = var_4.origin[1];
      var_9 = var_4.origin[2];
      var_10 = 0;

      if(var_4 == var_0) {
        var_10 = 1;
      }

      var_11 = 0;

      if(isDefined(var_0._id_026E) && var_0._id_026E == var_4) {
        var_11 = 1;
      }

      var_12 = 0;

      if(var_4.team == "axis") {
        var_12 = 1;
      } else if(var_4.team == "allies") {
        var_12 = 2;
      }

      var_13 = 0;

      if(isDefined(var_4._id_1767._id_B6DA)) {
        var_13 = var_4._id_1767._id_B6DA;
      }

      _func_0333(var_2, var_6, var_7, var_8, var_9, var_13, var_12, var_10, var_11);
    }
  }
}

_id_176C(var_0, var_1, var_2, var_3) {
  foreach(var_5 in level._id_E2F4._id_E350) {
    var_6 = var_5._id_0497;
    var_7 = var_5._id_1755._id_1622;
    var_8 = var_5._id_1755._id_5405;
    var_9 = var_5._id_1755._id_F272;
    var_10 = 0;

    if(isDefined(var_0._id_904C) && var_0._id_904C == var_5) {
      var_10 = 1;
    }

    var_11 = 0;

    if(var_3 == var_5) {
      var_11 = 1;
    }

    var_12 = var_5._id_1755._id_9C6A;
    var_13 = var_5._id_1755._id_C016;
    var_14 = var_5._id_1755._id_E39F;
    var_15 = 0;

    if(isDefined(var_5._id_904E) && var_5._id_904E == "axis") {
      var_15 = 1;
    } else if(isDefined(var_5._id_904E) && var_5._id_904E == "allies") {
      var_15 = 2;
    }

    var_16 = var_5._id_904F;
    var_17 = var_5._id_1755._id_9C7C;
    var_18 = 0;

    if(isDefined(var_5.index) && var_5.index <= 1023) {
      var_18 = var_5.index;
    }

    var_19 = 0;

    if(isDefined(var_5._id_1755) && isDefined(var_5._id_1755.spawntype)) {
      var_19 = var_5._id_1755.spawntype;
    }

    var_20 = 0;

    if(isDefined(var_5._id_20F7)) {
      var_20 = var_5._id_20F7;
    }

    _func_0331(2, var_6, var_12, var_17, var_13, var_2, var_7, var_8, var_11, var_10, var_15, var_18, var_14, var_9, var_19, var_20);
  }
}

_id_1759() {
  var_0 = 120;

  if(isDefined(scripts\mp\utility\game::getgametype())) {
    if(scripts\mp\utility\game::getgametype() == "war") {
      var_0 = 120;
    } else if(scripts\mp\utility\game::getgametype() == "dom") {
      var_0 = 120;
    } else if(scripts\mp\utility\game::getgametype() == "conf") {
      var_0 = 120;
    } else if(scripts\mp\utility\game::getgametype() == "front") {
      var_0 = 40;
    } else if(scripts\mp\utility\game::getgametype() == "sd") {
      var_0 = 50;
    } else if(scripts\mp\utility\game::getgametype() == "dm") {
      var_0 = 50;
    } else if(scripts\mp\utility\game::getgametype() == "koth") {
      var_0 = 125;
    } else if(scripts\mp\utility\game::getgametype() == "ctf") {
      var_0 = 50;
    } else if(scripts\mp\utility\game::getgametype() == "tdef") {
      var_0 = 75;
    } else if(scripts\mp\utility\game::getgametype() == "siege") {
      var_0 = 25;
    } else if(scripts\mp\utility\game::getgametype() == "gun") {
      var_0 = 50;
    } else if(scripts\mp\utility\game::getgametype() == "sr") {
      var_0 = 25;
    } else if(scripts\mp\utility\game::getgametype() == "grind") {
      var_0 = 75;
    } else if(scripts\mp\utility\game::getgametype() == "pill") {
      var_0 = 75;
    } else if(scripts\mp\utility\game::getgametype() == "ball") {
      var_0 = 50;
    }
  }

  return var_0;
}

_id_9780(var_0, var_1, var_2) {
  if(!_id_1768()) {
    return;
  }
  var_3 = 1;

  if(!isDefined(var_2)) {
    var_2 = -1;
  }

  _func_03BF("analytics_mp_score_event", ["score_type", var_3, "score_points", var_0, "score_eventid", var_2, "game_time", var_1, "player_id", self._id_1767._id_B6DA]);
}

_id_9781(var_0, var_1, var_2) {
  if(!_id_1768()) {
    return;
  }
  var_3 = 2;

  if(!isDefined(var_2)) {
    var_2 = -1;
  }

  _func_03BF("analytics_mp_score_event", ["score_type", var_3, "score_points", var_0, "score_eventid", var_2, "game_time", var_1, "player_id", self._id_1767._id_B6DA]);
}

_id_9782(var_0, var_1) {
  if(!_id_1768()) {
    return;
  }
  var_2 = 3;
  _func_03BF("analytics_mp_score_event", ["score_type", var_2, "score_points", var_0, "game_time", var_1, "player_id", self._id_1767._id_B6DA]);
}

_id_9777(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!_id_1768()) {
    return;
  }
  var_6 = -1;

  if(isDefined(self._id_1767) && isDefined(self._id_1767._id_B6DA)) {
    var_6 = self._id_1767._id_B6DA;
  }

  _func_03BF("dlog_event_gamemp_nvg_toggle", ["playerid", var_6, "game_time", var_0, "player_life_index", var_1, "x", var_2[0], "y", var_2[1], "z", var_2[2], "enabled", var_3, "duration", var_4, "disable_reason", var_5]);
}

_id_6A70() {
  if(!isDefined(level._id_5FDF)) {
    level._id_5FDF = spawnStruct();
    level._id_5FDF.isactive = [];
    level._id_5FDF.isactive["allies"] = 0;
    level._id_5FDF.isactive["axis"] = 0;
    level._id_5FDF._id_FDAC = 0.0;
    level._id_5FDF._id_4EBB = 0.0;
  }

  return level._id_5FDF;
}

_id_977B(var_0, var_1, var_2) {
  var_3 = isDefined(var_2);

  if(!var_3) {
    var_2 = var_0;
  }

  var_0 _meth_870F("dlog_event_player_heal", ["reviver", var_2, "player_life_index", var_0._id_9BC0, "pos_x", var_0.origin[0], "pos_y", var_0.origin[1], "pos_z", var_0.origin[2], "heal_ammount", var_1, "was_revived", var_3]);
}

_id_9767(var_0, var_1) {
  var_0 _meth_870F("dlog_event_player_field_upgrade_earned", ["player_life_index", var_0._id_9BC0, "pos_x", var_0.origin[0], "pos_y", var_0.origin[1], "pos_z", var_0.origin[2], "field_upgrade_index", var_1]);
}

_id_9766(var_0, var_1) {
  var_0 _meth_870F("dlog_event_player_field_upgrade_activated", ["player_life_index", var_0._id_9BC0, "pos_x", var_0.origin[0], "pos_y", var_0.origin[1], "pos_z", var_0.origin[2], "field_upgrade_index", var_1]);
}

_id_9768(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_0 _meth_870F("dlog_event_player_field_upgrade_expired", ["player_life_index", var_0._id_9BC0, "pos_x", var_0.origin[0], "pos_y", var_0.origin[1], "pos_z", var_0.origin[2], "field_upgrade_index", var_1, "efficacy", var_2, "was_destroyed", var_3]);
}

_id_9771(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 _meth_870F("dlog_event_kill_streak_available", ["lifeindex", var_1, "killstreak_name", var_2, "killstreak_pickedup", var_3, "time_msfrommatchstart", var_4, "playerposx", var_5[0], "playerposy", var_5[1], "playerposz", var_5[2]]);
}

_id_9770(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 _meth_870F("dlog_event_kill_streak_activated", ["lifeindex", var_1, "killstreak_name", var_2, "killstreak_pickedup", var_3, "time_msfrommatchstart", var_4, "playerposx", var_5[0], "playerposy", var_5[1], "playerposz", var_5[2]]);
}

_id_9773(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_0)) {
    return;
  }
  var_11 = -1;

  if(isDefined(var_1)) {
    var_11 = var_1;
  }

  var_12 = _id_07EE::_id_6DE4(var_4);
  var_0 _meth_870F("dlog_event_kill_streak_expired", ["lifeindex", var_11, "killstreak_name", var_2, "killstreak_pickedup", var_3, "expiration_thru_death", var_6, "shots", var_7, "hits", var_8, "kills", var_9, "score", var_10, "time_msfrommatchstart", var_12, "playerposx", var_5[0], "playerposy", var_5[1], "playerposz", var_5[2]]);
}

_id_9790(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = "";
  }

  var_0 _meth_870F("dlog_event_player_xp_earned", ["player_life_index", var_0._id_9BC0, "player_xp_earned", var_1, "weapon_s", var_2, "weapon_xp_earned", var_3, "xp_event", var_4]);
}

_id_9788(var_0, var_1) {
  var_0 _meth_870F("dlog_event_player_spawnselection_choice", ["player_life_index", var_0._id_9BC0, "selection", var_1]);
}

logevent_votriggered(var_0, var_1, var_2) {
  var_0 _meth_870F("dlog_event_player_vo_triggered", ["trigger", var_1, "vo", var_2]);
}