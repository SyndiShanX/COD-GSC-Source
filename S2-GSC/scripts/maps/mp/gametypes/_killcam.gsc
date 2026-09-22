/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_killcam.gsc
**************************************************/

init() {
  level._id_5A29 = _id_0511::_id_46F7("game", "allowkillcam");
  setDvar("5364", 8);
}

_id_8649(var_0, var_1, var_2, var_3, var_4) {
  self setclientomnvar("cam_scene_name", var_0);
  self setclientomnvar("cam_scene_lead", var_1);
  self setclientomnvar("cam_scene_support", var_2);

  if(isDefined(var_3)) {
    self setclientomnvar("cam_scene_lead_alt", var_3);
  } else {
    self setclientomnvar("cam_scene_lead_alt", var_1);
  }

  if(isDefined(var_4)) {
    self setclientomnvar("cam_scene_support_alt", var_4);
  } else {
    self setclientomnvar("cam_scene_support_alt", var_2);
  }
}

_id_86B7(var_0, var_1, var_2, var_3, var_4) {
  self setclientomnvar("ui_killcam_drawTargetBox", 0);

  if(isDefined(var_3._id_1187) && var_1 >= 0) {
    if(var_3._id_1187 == "dog") {
      _id_8649("killcam_dog", var_1, self getentitynumber());
    } else if(var_3._id_1187 == "paratroopers") {
      _id_8649("killcam_agent", var_3._id_1186, self getentitynumber());
    } else {
      _id_8649("killcam_agent", var_1, self getentitynumber());
    }
  } else if(var_2 == "agent_mp" && isDefined(var_3._id_1186))
    _id_8649("killcam_agent", var_3._id_1186, self getentitynumber());
  else if(isDefined(var_3) && isDefined(var_2) && (var_2 == "turretweapon_plane_gunner_turret_mp" || var_2 == "turretweapon_plane_gunner_turret_grenadier_mp")) {
    _id_8649("unknown", -1, -1);
    self setclientomnvar("ui_killcam_drawTargetBox", 1);
    return 1;
  } else if(var_1 >= 0) {
    _id_8649("unknown", -1, -1);
    return 0;
  } else if(level._id_8C03)
    _id_8649("unknown", var_0, self getentitynumber());
  else {
    _id_8649("unknown", var_0, -1);
  }

  return 1;
}

_id_585A(var_0, var_1, var_2) {
  if(isDefined(var_0) && var_0 getentitynumber() == _worldentnumber() && isDefined(var_1) && isDefined(var_1._id_5A2C)) {
    return 1;
  }

  if(isDefined(var_2) && (var_2 == "turretweapon_tank_panzer_cannon_mp_left" || var_2 == "turretweapon_tank_panzer_cannon_mp_right" || var_2 == "magnifying_glass_mp")) {
    return 1;
  }

  return 0;
}

_id_7681(var_0, var_1, var_2, var_3) {
  if(isPlayer(self) && isDefined(var_1) && isPlayer(var_1)) {
    var_4 = maps\mp\gametypes\_playerlogic::_id_4006();
    var_5 = gettime();
    waittillframeend;

    if(isPlayer(self) && isDefined(var_1) && isPlayer(var_1)) {
      var_5 = (gettime() - var_5) / 1000;
      self._id_9459 = self loadcustomizationplayerview(var_1, var_2 + var_5, var_3, var_4);
      self precachekillcamiconforweapon(var_3);
    }
  }
}

_id_5A33(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(getDvar("scr_killcam_time") == "") {
    if(!isDefined(var_1)) {
      var_1 = "";
    }

    if(isDefined(var_7) && var_7 == "replay") {
      var_8 = 5.0;
    } else if(isDefined(var_7) && var_7 == "playofthegame") {
      var_8 = _id_04F0::_id_4632();
    } else if(var_5 || var_1 == "artillery_mp" || var_1 == "firebomb_bomb_mp" || var_1 == "firebomb_bomb_axis_mp" || var_1 == "firebomb_bomb_grenadier_mp" || var_1 == "firebomb_bomb_axis_grenadier_mp" || var_1 == "airstrike_bomb_mp" || var_1 == "airstrike_bomb_axis_mp" || var_1 == "turretweapon_plane_gunner_turret_mp" || var_1 == "turretweapon_plane_gunner_turret_grenadier_mp" || var_1 == "fighter_strike_gun_mp") {
      var_8 = (gettime() - var_0) / 1000 - var_2 - 0.1;

      if((var_1 == "turretweapon_plane_gunner_turret_mp" || var_1 == "turretweapon_plane_gunner_turret_grenadier_mp") && var_8 > 5.0) {
        var_8 = 5.0;
      }
    } else if(var_1 == "missile_strike_projectile_mp" || var_1 == "missile_strike_projectile_axis_mp" || var_1 == "mortar_strike_projectile_mp" || var_1 == "mortar_strike_projectile_axis_mp") {
      var_8 = (gettime() - var_0) / 1000 - var_2 - 0.35;

      if(maps\mp\_utility::_id_4571() == "mp_gibraltar_02") {
        var_8 = var_8 - 0.35;
      }
    } else if(var_1 == "magnifying_glass_mp")
      var_8 = 3.0;
    else if(var_6 || var_1 == "agent_mp" || var_1 == "agent_raid_fighters_mp") {
      var_8 = 4.0;
    } else if(issubstr(var_1, "remotemissile_")) {
      var_8 = 5;
    } else if(!var_3 || var_3 > 5.0) {
      var_8 = 5.0;
    } else if(var_1 == "frag_grenade_mp" || var_1 == "frag_grenade_german_mp" || var_1 == "frag_grenade_short_mp" || var_1 == "semtex_mp" || var_1 == "semtexproj_mp" || var_1 == "thermobaric_grenade_mp") {
      var_8 = 4.25;
    } else {
      var_8 = 2.5;
    }
  } else
    var_8 = getdvarfloat("scr_killcam_time");

  if(var_5 && var_8 > 5) {
    var_8 = 5;
  }

  if(isDefined(var_4)) {
    if(var_8 > var_4) {
      var_8 = var_4;
    }

    if(var_8 < 0.05) {
      var_8 = 0.05;
    }
  }

  return var_8;
}

_id_5A2A(var_0, var_1, var_2, var_3) {
  if(var_0 > var_1) {
    var_0 = var_1;
  }

  var_4 = var_0 + var_2 + var_3;
  return var_4;
}

_id_5A34(var_0, var_1) {
  var_2 = 0;
  return var_1 && level._id_5A29 && !(isDefined(var_0._id_1F3F) && var_0._id_1F3F) && game["state"] == "playing" && !var_0 maps\mp\_utility::isusingremote() && !level._id_8C03 && (!_isagent(var_0) || var_2);
}

_id_74C9() {
  self endon("disconnect");
  self endon("spawned");
  level endon("game_ended");
  level._id_689A++;
  self._id_5A29 = 1;
  var_0 = level._id_689A * 0.05;

  if(level._id_689A > 1) {
    wait(0.05 * (level._id_689A - 1));
  }

  waitframe();
  level._id_689A--;
  var_1 = 0.05;
  var_2 = _id_04F0::_id_4632();
  var_3 = "playofthegame";
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_killcam_killedby_weapon", -1);
  self setclientomnvar("ui_killcam_killedby_killstreak", -1);
  self setclientomnvar("ui_killcam_copycat", 0);
  self setclientomnvar("ui_killcam_paratrooperInsert", 0);
  self setclientomnvar("ui_killcam_killedby_weaponReputation", 0);
  self setclientomnvar("ui_killcam_action", 0);
  self setclientomnvar("ui_killcam_type", 3);
  self setclientomnvar("ui_killcam_killedby_id", level._id_74CA);
  maps\mp\_utility::_id_A165("spectator");
  self._id_0188 = 1;
  self onlystreamactiveweapon(0);
  _func_3B7(0);
  self.killcamentity = -1;
  self._id_0020 = var_2 + var_0;
  self.forcespectatorclient = level._id_74CA;
  self._id_5A2F = var_2;
  self._id_014A = 0;
  thread _id_04F0::_id_772D();
  self allowspectateteam("allies", 1);
  self allowspectateteam("axis", 1);
  self allowspectateteam("freelook", 1);
  self allowspectateteam("none", 1);

  if(level._id_6520) {
    foreach(var_5 in level._id_985B) {
      self allowspectateteam(var_5, 1);
    }
  }

  foreach(var_5 in level._id_985B) {
    self allowspectateteam(var_5, 1);
  }

  thread _id_36B5(var_3);
  thread _id_6164(var_3);
  waitframe();

  if(!isDefined(self)) {
    return;
  }
  self._id_5A2F = var_2 - 0.05;
  self setclientomnvar("ui_killcam_end_milliseconds", int(var_2 * 1000) + gettime());
  thread _id_9046(var_3);
  self._id_8C8A = 0;
  self._id_5A31 = maps\mp\_utility::_id_44FA();
  self notify("showing_final_killcam");
  thread _id_318D(_func_36B() + 0.5);
  thread switchkillcamentityovertime();
  _id_A784();

  if(level._id_8C03) {
    thread maps\mp\gametypes\_playerlogic::_id_9049();
    return;
  }

  thread _id_5A2B(1, var_3);
}

switchkillcamentityovertime() {
  self endon("abort_killcam");
  self endon("killcam_ended");
  var_0 = maps\mp\_utility::_id_44FA();
  var_1 = [];

  foreach(var_3 in level._id_74CB) {
    if(_id_047A::iskillevent(var_3._id_1458)) {
      var_4 = var_1.size;
      var_1[var_4] = spawnStruct();
      var_1[var_4]._id_1EB5 = var_3._id_1EB5;
      var_1[var_4].victimnum = var_3.victimnum;
      var_1[var_4]._id_3FD7 = var_3._id_3FD7;
      var_1[var_4]._id_A490 = var_3._id_A490;
      var_1[var_4]._id_01D0 = var_3._id_01D0;
    }
  }

  if(var_1.size > 1) {
    var_1 = common_scripts\utility::_id_0FA4(var_1, ::potgcomparekilltimes);
  }

  if(var_1.size < 1) {
    return;
  }
  var_4 = 0;
  var_6 = _id_04F0::_id_4632() * 1000;
  var_7 = _func_369() * 1000;
  var_8 = var_0 + var_6 - var_7;
  var_9 = level.playofthegamerecordtime - var_1[0]._id_3FD7;
  var_10 = var_8 - var_0;
  var_10 = var_10 - var_9;
  setpotgkillcamentity(var_1[var_4]);

  while(var_4 < var_1.size) {
    var_11 = maps\mp\_utility::_id_44FA() - var_0;

    if(var_11 > var_10) {
      var_4++;

      if(var_4 < var_1.size && isDefined(var_1[var_4 - 1])) {
        var_12 = var_1[var_4]._id_3FD7 - var_1[var_4 - 1]._id_3FD7;

        if(var_12 > 1000) {
          wait 0.5;
        }

        var_10 = var_12 + var_11;
        setpotgkillcamentity(var_1[var_4]);
      }
    }

    waitframe();
  }
}

potgcomparekilltimes() {
  if(!isDefined(self._id_3FD7)) {
    return 0;
  }

  return self._id_3FD7;
}

setpotgkillcamentity(var_0) {
  var_1 = 0;

  if(isDefined(var_0._id_1EB5) && isDefined(var_0._id_A490)) {
    var_1 = _id_86B7(level._id_74CA, var_0._id_1EB5, var_0._id_01D0, var_0._id_A490, 0);
  }

  if(!var_1 && isDefined(var_0._id_1EB5)) {
    if(var_0._id_1EB5 != level._id_74CA) {
      self.killcamentity = var_0._id_1EB5;

      if(isDefined(var_0.victimnum)) {
        self._id_00E2 = var_0.victimnum;
      }

      return;
    }
  }

  self.killcamentity = -1;
  self.forcespectatorclient = level._id_74CA;
}

canincludeattachmentsforweapon(var_0) {
  switch (var_0) {
    case "combatknife_mp":
    case "riotshield_mp":
      return 0;
  }

  return 1;
}

_id_5A29(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  self endon("disconnect");
  self endon("spawned");
  level endon("game_ended");
  var_15 = _id_585A(var_0, var_9, var_4);

  if((var_1 < 0 || !isDefined(var_9)) && !var_15) {
    return;
  }
  level._id_689A++;
  var_16 = level._id_689A * 0.05;

  if(level._id_689A > 1) {
    wait(0.05 * (level._id_689A - 1));
  }

  waitframe();
  level._id_689A--;

  if(isDefined(level.hostmigrationtimer)) {
    return;
  }
  var_17 = _id_5A33(var_3, var_4, var_5, var_7, var_8, var_14, level._id_8C03, var_12);

  if(getDvar("scr_killcam_posttime") == "") {
    var_18 = 2;
  } else {
    var_18 = getdvarfloat("scr_killcam_posttime");

    if(var_18 < 0.05) {
      var_18 = 0.05;
    }
  }

  var_19 = var_17 + var_18;

  if(isDefined(var_8) && var_19 > var_8) {
    if(var_8 < 2) {
      return;
    }
    if(var_8 - var_17 >= 1) {
      var_18 = var_8 - var_17;
    } else {
      var_18 = 1;
      var_17 = var_8 - 1;
    }

    var_19 = var_17 + var_18;
  }

  if(isDefined(var_9._id_2AB8)) {
    if(gettime() - var_9._id_2AB8 < var_18 * 1000.0) {
      var_18 = 1.0;
      var_19 = var_17 + var_18;
    }
  }

  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_show_overview_map_icons", 0);

  if(_isagent(var_9) && !isDefined(var_9._id_565F)) {
    return;
  }
  if(isPlayer(var_9)) {
    self setclientomnvar("ui_killcam_killedby_id", var_9 getentitynumber());
  } else if(_isagent(var_9) || var_15) {
    self setclientomnvar("ui_killcam_killedby_id", -1);
  }

  if(isDefined(var_4)) {
    if(maps\mp\_utility::iskillstreakweapon(var_4)) {
      var_20 = maps\mp\_utility::_id_4545(level._id_5A7D[var_4]);
      self setclientomnvar("ui_killcam_killedby_killstreak", var_20);
      self setclientomnvar("ui_killcam_killedby_weapon", -1);
      self setclientomnvar("ui_killcam_killedby_attachment1", -1);
      self setclientomnvar("ui_killcam_killedby_attachment2", -1);
      self setclientomnvar("ui_killcam_killedby_attachment3", -1);
      self setclientomnvar("ui_killcam_killedby_attachment4", -1);
      self setclientomnvar("ui_killcam_copycat", 0);
      self setclientomnvar("ui_killcam_killedby_weaponReputation", 0);
    } else if(var_15) {
      self setclientomnvar("ui_killcam_killedby_killstreak", -1);
      self setclientomnvar("ui_killcam_killedby_weapon", -1);
      self setclientomnvar("ui_killcam_killedby_attachment1", -1);
      self setclientomnvar("ui_killcam_killedby_attachment2", -1);
      self setclientomnvar("ui_killcam_killedby_attachment3", -1);
      self setclientomnvar("ui_killcam_killedby_attachment4", -1);
      self setclientomnvar("ui_killcam_copycat", 0);
      self setclientomnvar("ui_killcam_killedby_weaponReputation", 0);
    } else {
      var_21 = [];
      var_22 = _getweaponbasename(var_4);
      var_4 = _id_04CB::_id_7CCD(var_4);

      if(isDefined(var_22)) {
        var_23 = maps\mp\_utility::_id_472B(var_4);
        var_24 = maps\mp\_utility::_id_452A(var_22);
        var_25 = -1;

        if(isDefined(var_24) && var_24 != 0) {
          if(var_23 == "cond2" || var_23 == "cond1") {
            var_26 = maps\mp\_utility::_id_4431(var_22);
            var_27 = maps\mp\_utility::_id_452A(var_26);

            if(isDefined(var_27) && var_27 != 0) {
              var_28 = tablelookup("mp/statstable.csv", 18, maps\mp\_utility::unsignedint_to_hexstring_fixed(var_27), 34);

              if(var_28 == "0") {
                if(var_23 == "cond1") {
                  var_24 = var_27 + 1;
                } else if(var_23 == "cond2") {
                  var_24 = var_27 + 2;
                }
              } else if(var_28 == "1") {
                if(var_23 == "cond2") {
                  var_24 = var_27 + 1;
                }
              }
            }
          }

          var_29 = maps\mp\_utility::unsignedint_to_hexstring_fixed(var_24);
          var_25 = _tablelookuprownum("mp/statstable.csv", 18, var_29);
        } else
          var_25 = _tablelookuprownum("mp/statstable.csv", 2, var_22);

        self setclientomnvar("ui_killcam_killedby_weapon", var_25);
        self setclientomnvar("ui_killcam_killedby_killstreak", -1);
        self setclientomnvar("ui_killcam_killedby_weaponReputation", 0);

        if(canincludeattachmentsforweapon(var_22)) {
          var_21 = _getweaponattachments(var_4);
        }

        var_21 = common_scripts\utility::_id_0F93(var_21, "special_grip");

        if(!level._id_8C03 && maps\mp\_utility::_id_761E() && isPlayer(var_9) && !isbot(self) && !_isagent(self) && maps\mp\gametypes\_class::_id_5E0A(var_9)) {
          self setclientomnvar("ui_killcam_copycat", 1);
          thread _id_A68A(var_9);
        } else
          self setclientomnvar("ui_killcam_copycat", 0);
      } else {
        self setclientomnvar("ui_killcam_killedby_weapon", -1);
        self setclientomnvar("ui_killcam_killedby_killstreak", -1);
        self setclientomnvar("ui_killcam_copycat", 0);
      }

      for(var_30 = 0; var_30 < 4; var_30++) {
        if(isDefined(var_21[var_30])) {
          var_31 = _tablelookuprownum("mp/attachmenttable.csv", 3, maps\mp\_utility::_id_1150(var_21[var_30]));
          self setclientomnvar("ui_killcam_killedby_attachment" + (var_30 + 1), var_31);
          continue;
        }

        self setclientomnvar("ui_killcam_killedby_attachment" + (var_30 + 1), -1);
      }
    }
  } else {
    self setclientomnvar("ui_killcam_killedby_weapon", -1);
    self setclientomnvar("ui_killcam_killedby_killstreak", -1);
    self setclientomnvar("ui_killcam_copycat", 0);
    self setclientomnvar("ui_killcam_killedby_weaponReputation", 0);
  }

  if(!var_15 && isDefined(var_9._id_5DFA) && var_9._id_5DFA.size > 4) {
    var_32 = var_9._id_5DFA[0];
    var_33 = var_9._id_5DFA[3];

    if(var_32 != 0) {
      var_34 = maps\mp\_utility::_id_452B(var_32);
      var_35 = int(tablelookup(maps\mp\_utility::_id_4604(), 1, var_34, 0));
      self setclientomnvar("ui_killcam_killedby_perk_1", var_35);
    } else
      self setclientomnvar("ui_killcam_killedby_perk_1", -1);

    var_36 = maps\mp\_utility::_id_452B(var_33);
    var_37 = int(tablelookup(maps\mp\_utility::_id_4604(), 1, var_36, 0));
    self setclientomnvar("ui_killcam_killedby_perk_2", var_37);

    for(var_30 = 3; var_30 <= 9; var_30++) {
      self setclientomnvar("ui_killcam_killedby_perk_" + var_30, -1);
    }

    self setclientomnvar("ui_killcam_killedby_division", var_9._id_0079);
  } else if(!var_15) {
    for(var_30 = 1; var_30 <= 9; var_30++) {
      self setclientomnvar("ui_killcam_killedby_perk_" + var_30, -1);
    }

    self setclientomnvar("ui_killcam_killedby_division", var_9._id_0079);
  } else if(var_15) {
    for(var_30 = 1; var_30 <= 9; var_30++) {
      self setclientomnvar("ui_killcam_killedby_perk_" + var_30, -1);
    }

    self setclientomnvar("ui_killcam_killedby_division", -1);
  }

  if(!level.gameended && var_12 != "replay" && var_12 != "playofthegame") {
    if(var_7) {
      self setclientomnvar("ui_killcam_action", 2);
    } else {
      self setclientomnvar("ui_killcam_action", 1);
    }
  } else
    self setclientomnvar("ui_killcam_action", 0);

  switch (var_12) {
    case "replay":
      self setclientomnvar("ui_killcam_type", 2);
      break;
    case "playofthegame":
      self setclientomnvar("ui_killcam_type", 3);
      break;
    case "score":
      self setclientomnvar("ui_killcam_type", 1);
      break;
    case "normal":
    default:
      self setclientomnvar("ui_killcam_type", 0);
      break;
  }

  var_38 = var_17 + var_5 + var_16;
  var_39 = gettime();
  self notify("begin_killcam", var_39);

  if(!var_15 && !_isagent(var_9) && isDefined(var_9) && isPlayer(var_10)) {
    var_9 visionsyncwithplayer(var_10);
  }

  maps\mp\_utility::_id_A165("spectator");
  self._id_0188 = 1;

  if(_isagent(var_9) && var_12 != "replay" && var_12 != "playofthegame") {
    var_1 = var_10 getentitynumber();
  }

  self onlystreamactiveweapon(0);

  if(var_15) {
    self.forcespectatorclient = var_10 getentitynumber();
  } else {
    self.forcespectatorclient = var_1;
  }

  self._id_00E2 = var_10 getentitynumber();
  self.killcamentity = -1;
  var_40 = _id_86B7(var_1, var_2, var_4, var_10, var_17);

  if(!var_40) {
    thread _id_86B6(var_2, var_38, var_3);
  }

  if(var_15) {
    if(var_38 > gettime() / 1000.0) {
      var_38 = gettime() / 1000.0;
    }
  } else if(var_38 > var_13)
    var_38 = var_13;

  self._id_0020 = var_38;
  self._id_5A2F = var_19;
  self._id_014A = var_6;
  self allowspectateteam("allies", 1);
  self allowspectateteam("axis", 1);
  self allowspectateteam("freelook", 1);
  self allowspectateteam("none", 1);

  if(level._id_6520) {
    foreach(var_42 in level._id_985B) {
      self allowspectateteam(var_42, 1);
    }
  }

  foreach(var_42 in level._id_985B) {
    self allowspectateteam(var_42, 1);
  }

  thread _id_36B5(var_12, var_9);
  thread _id_6164(var_12, var_9);
  waitframe();

  if(!isDefined(self)) {
    return;
  }
  if(self._id_0020 < var_38) {}

  var_17 = self._id_0020 - 0.05 - var_5;
  var_19 = var_17 + var_18;
  self._id_5A2F = var_19;

  if(var_17 <= 0) {
    if(var_12 != "replay" && var_12 != "playofthegame") {
      maps\mp\_utility::_id_A165("dead");
    }

    maps\mp\_utility::clearkillcamstate();
    self notify("killcam_ended");
    return;
  }

  self setclientomnvar("ui_killcam_end_milliseconds", int(var_19 * 1000) + gettime());

  if(level._id_8C03) {
    thread _id_318D(var_17);
  }

  self._id_5A29 = 1;
  thread _id_9046(var_12, var_9);
  self._id_8C8A = 0;
  self._id_5A31 = maps\mp\_utility::_id_44FA();

  if(!level._id_8C03) {
    thread _id_A6FB(var_7);
  } else {
    self notify("showing_final_killcam");
  }

  thread _id_36D6();
  _id_A784();

  if(level._id_8C03) {
    if(self == var_9) {
      var_9 maps\mp\gametypes\_missions::processchallenge("ch_precision_moviestar");
    }

    if(level._id_74CA < 0 || var_12 != "playofthegame") {
      thread maps\mp\gametypes\_playerlogic::_id_9049();
      return;
    }
  }

  thread _id_5A2B(1, var_12, var_9);
}

_id_318D(var_0) {
  if(common_scripts\utility::_id_562E(level.skipfinalkillcamfx)) {
    return;
  }
  if(isDefined(level._id_3200)) {
    return;
  }
  level._id_3200 = 1;
  var_1 = var_0;

  if(var_1 > 1.0) {
    var_1 = 1.0;
    wait(var_0 - 1.0);
  }

  _setslowmotion(1.0, 0.25, var_1);
  wait(var_1 + 1.0);
  _setslowmotion(0.25, 1, 0.5);
  level._id_3200 = undefined;
}

_id_A784() {
  self endon("abort_killcam");
  var_0 = maps\mp\gametypes\_playerlogic::_id_9A1C(0);

  if(var_0 > 0) {
    self setclientomnvar("ui_killcam_time_until_spawn", gettime() + var_0 * 1000);
  }

  wait(self._id_5A2F - 0.05);
}

_id_86B6(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("killcam_ended");
  var_3 = gettime() - var_1 * 1000;

  if(var_2 > var_3) {
    waitframe();
    var_1 = self._id_0020;
    var_3 = gettime() - var_1 * 1000;

    if(var_2 > var_3) {
      wait((var_2 - var_3) / 1000);
    }
  }

  self.killcamentity = var_0;
}

_id_A6FB(var_0) {
  self endon("disconnect");
  self endon("killcam_ended");

  while(self useButtonPressed()) {
    waitframe();
  }

  while(!self useButtonPressed()) {
    waitframe();
  }

  self._id_8C8A = 1;

  if(isDefined(self.pers["totalKillcamsSkipped"])) {
    self.pers["totalKillcamsSkipped"]++;
  }

  if(var_0 <= 0) {
    maps\mp\_utility::clearlowermessage("kc_info");
  }

  self notify("abort_killcam");
}

_id_A6F7(var_0) {
  self endon("disconnect");
  self endon("killcam_ended");
  self notifyonplayercommand("KillCamParatrooperInsert", "+weapnext");
  self waittill("KillCamParatrooperInsert");
  self setclientomnvar("ui_killcam_paratrooperInsert", 0);
  thread _id_0513::_id_A931();
}

_id_A68A(var_0) {
  self endon("disconnect");
  self endon("killcam_ended");
  self notifyonplayercommand("KillCamCopyCat", "+weapnext");
  self waittill("KillCamCopyCat");
  self setclientomnvar("ui_killcam_copycat", 0);
  self playSound("copycat_steal_class");
  maps\mp\gametypes\_class::_id_8657(var_0);
}

_id_36D6() {
  self endon("disconnect");
  self endon("killcam_ended");

  for(;;) {
    if(self._id_0020 <= 0) {
      break;
    }

    waitframe();
  }

  self notify("abort_killcam");
}

_id_9046(var_0, var_1) {
  self endon("disconnect");
  self endon("killcam_ended");
  self waittill("spawned");
  thread _id_5A2B(0, var_0, var_1);
}

_id_36B5(var_0, var_1) {
  self endon("disconnect");
  self endon("killcam_ended");
  level waittill("game_ended");
  thread _id_5A2B(1, var_0, var_1);
}

_id_6164(var_0, var_1) {
  self endon("disconnect");
  self endon("killcam_ended");
  level waittill("host_migration_begin");
  _id_5A2B(1, var_0, var_1);
}

_id_5A2B(var_0, var_1, var_2) {
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  _id_8649("unknown", -1, -1);
  self._id_5A29 = undefined;

  if(isDefined(self._id_5A31) && isPlayer(self) && _id_0485::_id_1F59(self._id_5CC6)) {
    var_3 = maps\mp\_utility::_id_44FA();
    setmatchdata("lives", self._id_5CC6, "killcam_watch_duration", maps\mp\_utility::_id_2314(var_3 - self._id_5A31));
  }

  if(!level.gameended) {
    maps\mp\_utility::clearlowermessage("kc_info");
  }

  thread _id_050F::_id_872F();
  self notify("killcam_ended");

  if(!var_0) {
    return;
  }
  if(var_1 != "replay" && var_1 != "playofthegame") {
    maps\mp\_utility::_id_A165("dead");
  }

  if(isPlayer(self) && isDefined(var_2) && (var_2 maps\mp\_utility::_hasperk("specialty_perception") || var_2 maps\mp\_utility::_hasperk("specialty_class_perception"))) {
    thread _id_238F(var_2);
  }

  if(isPlayer(self) && isDefined(var_2) && isDefined(var_2._id_0079)) {
    thread _id_237D(var_2);
  }

  maps\mp\_utility::clearkillcamstate();
}

_id_238F(var_0) {
  wait 0.1;
  var_1 = common_scripts\utility::_id_44F5("perception_glow");

  if(isDefined(var_1)) {
    _killfxontagforclient(var_1, var_0, "j_head", self);
  }
}

_id_237D(var_0) {
  wait 0.1;
  _id_04CB::_id_2F7B(var_0._id_0079, var_0 _id_04CA::_id_461C(var_0._id_0079), var_0);
}

_id_1F41() {
  self._id_1F3F = 0;
  thread _id_1F42(::_id_1F45, ::_id_1F40);
}

_id_1F45() {
  return self useButtonPressed();
}

_id_1F43() {
  return self fragButtonPressed();
}

_id_1F40() {
  self setclientomnvar("ui_show_skip_killcam", 0);
  self._id_1F3F = 1;

  if(isDefined(self.pers["totalKillcamsInterrupted"])) {
    self.pers["totalKillcamsInterrupted"]++;
  }
}

_id_1F44() {
  self._id_1F3F = 1;
  self._id_A7F5 = 1;

  if(isDefined(self.pers["totalKillcamsInterrupted"])) {
    self.pers["totalKillcamsInterrupted"]++;
  }
}

_id_1F42(var_0, var_1) {
  self endon("death_delay_finished");
  self endon("disconnect");
  level endon("game_ended");

  while(self[[var_0]]()) {
    waitframe();
  }

  while(!self[[var_0]]()) {
    waitframe();
  }

  self[[var_1]]();
}

_id_92E1(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_0._id_5BE2)) {
    var_3 = (gettime() - var_0._id_5BE2) / 1000.0;
  } else {
    var_3 = 0;
  }

  _id_5A29(var_0, var_1, -1, 0, undefined, 0, var_2, 1, maps\mp\gametypes\_gamelogic::_id_9A1B(), var_0, undefined, undefined, "replay", var_3, 0);
}