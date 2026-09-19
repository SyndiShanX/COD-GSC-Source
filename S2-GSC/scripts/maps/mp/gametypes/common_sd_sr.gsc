/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\common_sd_sr.gsc
******************************************************/

_id_4CB0(var_0, var_1) {
  var_2 = 0;

  if(var_0 == "_a")
    var_2 = var_2 | 1;
  else
    var_2 = var_2 | 2;

  if(isDefined(var_1)) {
    if(var_1 == "ninja_defuse")
      var_2 = var_2 | 4;
    else if(var_1 == "last_man_defuse")
      var_2 = var_2 | 8;
  }

  return var_2;
}

_id_6B86() {
  game["bomb_dropped_sound"] = "mp_obj_notify_neg_sml";
  game["bomb_dropped_enemy_sound"] = "mp_obj_notify_pos_sml";
  game["bomb_recovered_sound"] = "mp_obj_notify_pos_sml";
  game["bomb_grabbed_sound"] = "mp_snd_bomb_pickup";
  game["bomb_planted_sound"] = "mp_obj_notify_pos_sml";
  game["bomb_planted_enemy_sound"] = "mp_obj_notify_neg_sml";
  game["bomb_disarm_sound"] = "mp_obj_notify_pos_sml";
  game["bomb_disarm_enemy_sound"] = "mp_obj_notify_neg_sml";
}

_id_A121() {
  level._id_7078 = maps\mp\_utility::dvarfloatvalue("planttime", 5, 0, 20);
  level._id_2CA9 = maps\mp\_utility::dvarfloatvalue("defusetime", 5, 0, 20);
  level._id_1909 = maps\mp\_utility::dvarfloatvalue("bombtimer", 45, 1, 300);
  level._id_6510 = maps\mp\_utility::dvarintvalue("multibomb", 0, 0, 1);
  level._id_8C56 = maps\mp\_utility::dvarintvalue("silentplant", 0, 0, 1);
}

_id_872D() {
  if(_func_133() && _func_132("defaultClasses", game["attackers"], "defaultClass", 5, "class", "inUse"))
    level._id_832B[game["attackers"]] = maps\mp\_utility::_id_4573(game["attackers"], 5);
}

_id_5782(var_0) {
  if(isDefined(level._id_1913)) {
    foreach(var_2 in level._id_1913) {
      if(distancesquared(self.origin, var_2._id_9D65.origin) < 16384)
        return 0;
    }
  }

  if(isDefined(level._id_832F)) {
    if(distancesquared(self.origin, level._id_832F._id_9D65.origin) < 16384)
      return 0;
  }

  return 1;
}

_id_6B5C(var_0, var_1, var_2) {
  if(game["state"] == "postgame" && (var_0.team == game["defenders"] || !level._id_18F9))
    var_1._id_3B4B = 1;

  if(_id_A870(var_0, var_1)) {
    var_3 = _id_5742(var_1);
    var_1 thread _id_047A::_id_35D2(var_3, var_0);
  }
}

_id_254C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(var_1)) {
    return;
  }
  if(isDefined(self._id_568D) && self._id_568D) {
    self._id_568D = 0;

    if(self.team == game["attackers"]) {
      var_10 = 0;

      foreach(var_12 in level.players) {
        if(var_12 != self && var_12.team == self.team && isalive(var_12))
          var_10++;
      }

      if(var_10 > 0)
        maps\mp\_utility::leaderdialog("bomb_lost", self.team);
    }
  }

  if(maps\mp\gametypes\_damage::_id_56FA(self, var_1)) {
    return;
  }
  if(var_1 == self) {
    return;
  }
  var_14 = self;

  if(var_14._id_5777 || var_14._id_56C2) {
    var_1 thread _id_047A::_id_2C80(var_14, var_9, var_4);
    var_1 thread maps\mp\gametypes\_missions::_id_80BB(var_4, var_3);

    if(var_14._id_5777)
      var_1 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_interrupt");

    if(var_14._id_56C2) {
      var_1 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_protector");
      maps\mp\_utility::_id_863E(13, var_1.team, var_1 getentitynumber());
    }
  }
}

_id_A870(var_0, var_1) {
  if(maps\mp\gametypes\_damage::_id_56FA(var_0, var_1))
    return 0;

  if(var_0 maps\mp\gametypes\_playerlogic::mayspawn())
    return 0;

  return 1;
}

_id_6B62(var_0) {
  var_0._id_568D = 1;

  if(var_0.team == "allies")
    var_0._id_0112 = 1;
  else
    var_0._id_0112 = 2;

  if(isPlayer(var_0)) {
    var_0 thread _id_0485::_id_5E93("pickup", var_0.origin);
    var_0 _meth_82FF("ui_carrying_bomb", 1);
    var_0 thread maps\mp\gametypes\_hud_message::_id_9102("bomb_pickedup");
    maps\mp\_utility::_id_863E(15, var_0.team, var_0 getentitynumber());
  }

  _id_04D1::_id_860A("friendly", "waypoint_escort");
  _id_04D1::_id_860E("friendly", "waypoint_escort", undefined, 1);

  if(isDefined(level._id_832B) && isDefined(level._id_832B[var_0.team])) {
    var_0._id_57A7 = 1;
    var_0 thread _id_0F2F();
  }

  if(!level._id_18D3) {
    maps\mp\_utility::teamplayercardsplash("callout_bombtaken", var_0, var_0.team);
    maps\mp\_utility::leaderdialog("bomb_taken", var_0.pers["team"]);
  }

  maps\mp\_utility::playsoundonplayers(game["bomb_recovered_sound"], game["attackers"]);
  var_0 playlocalsound(game["bomb_grabbed_sound"]);
  var_0 _meth_8608(1);
}

_id_18FD() {
  level._id_18F9 = 0;
  level._id_18D3 = 0;
  level._id_18EE = 0;
  level._id_7069 = undefined;
  level.iconbomb = "waypoint_caster_bomb";
  level.icontarget = "waypoint_caster_target";
  level.icondefuse = "waypoint_caster_defuse";
  var_0 = _func_18E("sd_bomb_pickup_trig", "targetname");

  if(!isDefined(var_0)) {
    common_scripts\utility::_id_3809("No sd_bomb_pickup_trig trigger found in map.");
    return;
  }

  var_1[0] = _func_18E("sd_bomb", "targetname");

  if(!isDefined(var_1[0])) {
    common_scripts\utility::_id_3809("No sd_bomb script_model found in map.");
    return;
  }

  var_1[0] setModel("npc_gen_s_and_d_bomb");

  if(!level._id_6510) {
    level._id_832F = _id_04D1::_id_27D6(game["attackers"], var_0, var_1, (0, 0, 32), 0, 0, 1);
    level._id_832F _id_04D1::_id_0C1D("friendly");
    level._id_832F _id_04D1::_id_860A("friendly", "waypoint_bomb");
    level._id_832F _id_04D1::_id_860E("friendly", "waypoint_bomb", undefined, 1);
    level._id_832F _id_04D1::_id_8A60("friendly");

    if(game["attackers"] == "axis")
      maps\mp\_utility::_id_863F(level._id_832F, level.iconbomb, 1, 1);
    else
      maps\mp\_utility::_id_863F(level._id_832F, level.iconbomb, 2, 1);

    level._id_832F._id_0C33 = 1;
    level._id_832F._id_6B62 = ::_id_6B62;
    level._id_832F._id_6AEF = ::_id_6AEF;
    level._id_832F._id_1F84 = ::_id_1F79;
  } else {
    var_0 delete();
    var_1[0] delete();
  }

  level._id_1913 = [];
  var_2 = getEntArray("bombzone", "targetname");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_0 = var_2[var_3];
    var_1 = getEntArray(var_2[var_3].target, "targetname");
    var_4 = _id_04D1::_id_2837(game["defenders"], var_0, var_1, (0, 0, 64));
    var_4 _id_04D1::_id_0C30("enemy");
    var_4 _id_04D1::_id_8A5A(level._id_7078);
    var_4 _id_04D1::_id_8A57(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");

    if(!level._id_6510)
      var_4 _id_04D1::_id_86B5(level._id_832F);

    var_5 = var_4 _id_04D1::_id_454C();
    var_4.label = var_5;
    var_4 _id_04D1::_id_860A("friendly", "waypoint_defend" + var_5);
    var_4 _id_04D1::_id_860E("friendly", "waypoint_defend" + var_5, undefined, 1);
    var_4 _id_04D1::_id_860A("enemy", "waypoint_target" + var_5);
    var_4 _id_04D1::_id_860E("enemy", "waypoint_target" + var_5, undefined, 1);
    var_4 _id_04D1::_id_8A60("any");

    if(game["attackers"] == "axis")
      maps\mp\_utility::_id_863F(var_4, level.icontarget + var_5, 2, 1);
    else
      maps\mp\_utility::_id_863F(var_4, level.icontarget + var_5, 1, 1);

    var_4._id_6ABC = ::_id_6ABC;
    var_4._id_6AFA = ::_id_6AFA;
    var_4._id_681A = 1;
    var_4._id_502A = "bombZone";
    var_4._id_6BBF = ::_id_6BC8;
    var_4._id_6AC9 = ::_id_6AC9;
    var_4._id_A248 = "search_dstry_bomb_mp";
    var_4._id_18F9 = 0;

    for(var_6 = 0; var_6 < var_1.size; var_6++) {
      if(isDefined(var_1[var_6]._id_8186)) {
        var_4._id_3947 = var_1[var_6]._id_8186;
        var_1[var_6] thread _id_8A29(var_4);
        break;
      }
    }

    level._id_1913[level._id_1913.size] = var_4;
    var_4._id_18D5 = _func_18E(var_1[0].target, "targetname");
    var_4._id_18D5.origin = var_4._id_18D5.origin + (0, 0, -10000);
    var_4._id_18D5.label = var_5;
    var_4._id_18D5 _meth_8532(1);
  }

  for(var_3 = 0; var_3 < level._id_1913.size; var_3++) {
    var_7 = [];

    for(var_8 = 0; var_8 < level._id_1913.size; var_8++) {
      if(var_8 != var_3)
        var_7[var_7.size] = level._id_1913[var_8];
    }

    level._id_1913[var_3]._id_6C61 = var_7;
  }

  _func_032("ui_broadcaster_game_mode_status_1", 0);
}

_id_6BC8(var_0) {
  if(!_id_04D1::_id_56FB(var_0.pers["team"])) {
    level thread _id_18F9(self, var_0);

    if(isDefined(var_0._id_568D) && var_0._id_568D)
      var_0._id_568D = 0;

    for(var_1 = 0; var_1 < level._id_1913.size; var_1++) {
      if(level._id_1913[var_1] == self) {
        var_2 = level._id_1913[var_1] _id_04D1::_id_454C();

        if(game["attackers"] == "axis")
          maps\mp\_utility::_id_863F(level._id_1913[var_1], level.icondefuse, 1, 1);
        else
          maps\mp\_utility::_id_863F(level._id_1913[var_1], level.icondefuse, 2, 1);

        continue;
      }

      level._id_1913[var_1] _id_04D1::_id_2F93();
      maps\mp\_utility::_id_863F(level._id_1913[var_1], undefined, undefined, 1);
    }

    self._id_18F9 = 1;
    var_0 notify("bomb_planted");
    var_3 = 2;

    if(self.label == "_a")
      var_3 = 1;

    maps\mp\_utility::_id_863E(3, var_0.team, var_0 getentitynumber(), var_3);
    var_4 = _id_4CB0(self.label);
    var_0 thread _id_047A::_id_18FC(var_4);
    maps\mp\_utility::leaderdialog("bomb_planted");
    maps\mp\_utility::playsoundonplayers(game["bomb_planted_sound"], game["attackers"]);
    maps\mp\_utility::playsoundonplayers(game["bomb_planted_enemy_sound"], game["defenders"]);

    if(isDefined(level._id_832B) && isDefined(level._id_832B[var_0.team]))
      var_0 thread _id_7CD2();

    level._id_18F8 = var_0;
    var_0._id_18FB = gettime();
  } else
    self._id_18F9 = 0;
}

_id_7156(var_0) {
  var_1 = common_scripts\utility::_id_0F93(level.players, var_0);

  if(var_1.size)
    var_0 maps\mp\_utility::_id_74C3("snd_bomb_wheels_lp", undefined, var_1);
}

_id_93D6(var_0) {
  var_0 common_scripts\utility::_id_93D5("snd_bomb_wheels_lp");
}

_id_8A29(var_0) {
  var_1 = spawn("script_origin", self.origin);
  var_1.angles = self.angles;
  var_1 _meth_82BA(-45, 0.05);
  waitframe();
  var_2 = self.origin + (0, 0, 5);
  var_3 = self.origin + anglesToForward(var_1.angles) * 100 + (0, 0, 160);
  var_4 = bulletTrace(var_2, var_3, 0, self);
  self._id_5A2C = spawn("script_model", var_4["position"]);
  self._id_5A2C _meth_834D("explosive");
  var_0._id_5A2D = self._id_5A2C getentitynumber();
  var_1 delete();
}

_id_6ABC(var_0) {
  var_0 _meth_812A(0);

  if(_id_04D1::_id_56FB(var_0.pers["team"])) {
    if(!level._id_8C56 && !var_0 maps\mp\_utility::_hasperk("specialty_improvedobjectives")) {
      var_0 maps\mp\_utility::_id_67F4("defuse");
      level thread _id_7156(var_0);
    }

    var_0._id_56C2 = 1;
    var_1 = _id_4CB0(self.label);
    var_0 thread _id_0485::_id_5E93("bomb_defuse_start", var_0.origin, var_1);
    var_0 _meth_8608(1);
    maps\mp\_utility::_id_863E(4, var_0.team, var_0 getentitynumber());

    if(isDefined(level._id_8330)) {
      level._id_8330 _meth_805C();
      _func_148(common_scripts\utility::_id_44F5("search_dstry_bomb_arming_light"), level._id_8330, "tag_fx");
    }
  } else {
    var_2 = 2;

    if(self.label == "_a")
      var_2 = 1;

    maps\mp\_utility::_id_863E(14, var_0.team, var_0 getentitynumber(), var_2);

    if(!level._id_8C56 && !var_0 maps\mp\_utility::_hasperk("specialty_improvedobjectives")) {
      var_0 maps\mp\_utility::_id_67F4("plant");
      level thread _id_7156(var_0);
    }

    var_0._id_5777 = 1;
    var_1 = _id_4CB0(self.label);
    var_0 thread _id_0485::_id_5E93("bomb_plant_start", var_0.origin, var_1);

    if(level._id_6510) {
      for(var_3 = 0; var_3 < self._id_6C61.size; var_3++) {
        self._id_6C61[var_3] _id_04D1::_id_0C30("none");
        self._id_6C61[var_3] _id_04D1::_id_8A60("friendly");
      }
    }
  }

  _func_226(&"broadcaster_start_use_bomb", 1, var_0 getentitynumber());
}

_id_6AFA(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return;
  }
  var_1 _meth_8608(0);
  var_1 _meth_812A(1);

  if(isalive(var_1)) {
    var_1._id_56C2 = 0;
    var_1._id_5777 = 0;
  }

  level thread _id_93D6(var_1);

  if(_id_04D1::_id_56FB(var_1.pers["team"])) {
    if(isDefined(level._id_8330) && !var_2)
      level._id_8330 thread common_scripts\utility::_id_2CB7();
  } else if(level._id_6510 && !var_2) {
    for(var_3 = 0; var_3 < self._id_6C61.size; var_3++) {
      self._id_6C61[var_3] _id_04D1::_id_0C30("enemy");
      self._id_6C61[var_3] _id_04D1::_id_8A60("any");
    }
  }

  _func_226(&"broadcaster_start_use_bomb", 1, -1);
}

_id_18FA(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 _meth_8077(level._id_8330);

  while(var_0 getcurrentweapon() == self._id_A248)
    waitframe();

  var_0 _meth_8057();
}

_id_18F9(var_0, var_1) {
  level notify("bomb_planted", var_0);
  maps\mp\gametypes\_gamelogic::_id_6F27();
  level._id_18F9 = 1;
  level._id_7069 = var_0;
  var_1._id_0112 = 0;

  if(isPlayer(var_1))
    var_1 _meth_82FF("ui_carrying_bomb", 0);

  var_0._id_A582[0] thread maps\mp\gametypes\_gamelogic::_id_74E5();
  level._id_99C0 = var_0._id_A582[0];
  level._id_99F5 = 1;
  level._id_2CA0 = int(gettime() + level._id_1909 * 1000);
  _func_137(level._id_2CA0);

  if(!level._id_6510) {
    level._id_832F _id_04D1::_id_0C1D("none");
    level._id_832F _id_04D1::_id_8A60("none");
    maps\mp\_utility::_id_863F(level._id_832F, undefined, undefined, 1);
    level._id_832F _id_04D1::_id_866E(0.6);
    level._id_8330 = level._id_832F._id_A582[0];
    var_1 _id_0468::_id_0A22("sdPlant");
  } else {
    level._id_8330 = spawn("script_model", var_1.origin);
    level._id_8330.angles = var_1.angles;
    level._id_8330 setModel("npc_gen_s_and_d_bomb");
  }

  level.bomboutlineactive = 1;
  var_2 = maps\mp\_utility::_id_46D4(game["attackers"]);
  level._id_8330 _meth_86CC(level.players, var_2, 0);

  foreach(var_4 in level.broadcasters) {
    if(var_4._id_1E99._id_A4A8 == "third_person") {
      level._id_8330 _meth_8427(var_4, var_2, 0);
      continue;
    }

    level._id_8330 _meth_8428(var_4);
  }

  _func_147(common_scripts\utility::_id_44F5("search_dstry_bomb_arming_light"), level._id_8330, "tag_fx");
  var_0 _id_04D1::_id_0C30("none");
  var_0 _id_04D1::_id_8A60("none");
  var_6 = var_0 _id_04D1::_id_454C();
  _func_032("ui_bomb" + var_6 + "_state", 1);
  var_7 = var_0._id_18D5;
  var_7.origin = level._id_8330.origin;
  var_8 = [];
  var_9 = _id_04D1::_id_2837(game["defenders"], var_7, var_8, (0, 0, 32));
  var_9 _id_04D1::_id_0C30("friendly");
  var_9 _id_04D1::_id_8A5A(level._id_2CA9);
  var_9 _id_04D1::_id_8A57(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
  var_9 _id_04D1::_id_8A60("any");
  var_9 _id_04D1::_id_860A("friendly", "waypoint_defuse" + var_6);
  var_9 _id_04D1::_id_860A("enemy", "waypoint_defend" + var_6);
  var_9 _id_04D1::_id_860E("friendly", "waypoint_defuse" + var_6, undefined, 1);
  var_9 _id_04D1::_id_860E("enemy", "waypoint_defend" + var_6, undefined, 1);
  var_9.label = var_6;
  var_9._id_6ABC = ::_id_6ABC;
  var_9._id_6AFA = ::_id_6AFA;
  var_9._id_6BBF = ::_id_6BC3;
  var_9._id_681A = 1;
  var_9._id_502A = "defuseObject";
  var_9._id_A248 = "search_dstry_bomb_defuse_mp";

  if(var_6 == "_a" || var_6 == "_A")
    _func_032("ui_broadcaster_game_mode_status_1", 1);
  else if(var_6 == "_b" || var_6 == "_B")
    _func_032("ui_broadcaster_game_mode_status_1", 2);

  maps\mp\_utility::playsoundinspace("mp_snd_bomb_drop", level._id_8330.origin + (0, 0, 1));
  _id_190B(var_6);
  var_0._id_A582[0] maps\mp\gametypes\_gamelogic::_id_9415();
  level.bomboutlineactive = 0;
  level._id_8330 _meth_83FF();

  if(level.gameended || level._id_18D3) {
    return;
  }
  level._id_18EE = 1;
  _func_032("ui_broadcaster_game_mode_status_1", 0);
  _func_032("ui_bomb" + var_6 + "_state", 2);

  if(isDefined(level._id_832C))
    level thread[[level._id_832C]]();
  else {
    var_10 = level._id_8330.origin;
    var_11 = var_10;
    var_10 = var_10 + (0, 0, 10);
    level._id_8330 _meth_805C();
    _func_148(common_scripts\utility::_id_44F5("search_dstry_bomb_arming_light"), level._id_8330, "tag_fx");

    if(isDefined(var_1)) {
      var_0._id_A582[0] _meth_81D5(var_10, 512, 300, 20, var_1, "MOD_EXPLOSIVE", "bomb_site_mp");
      var_0._id_A582[0] _meth_81D5(var_0._id_A582[0].origin + (0, 0, 75), 512, 300, 20, var_1, "MOD_EXPLOSIVE", "bomb_site_mp");
      var_12 = _id_4CB0(var_6);
      var_1 thread _id_047A::_id_18D6(var_12);
    } else {
      var_0._id_A582[0] _meth_81D5(var_10, 512, 300, 20, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
      var_0._id_A582[0] _meth_81D5(var_0._id_A582[0].origin + (0, 0, 75), 512, 300, 20, var_1, "MOD_EXPLOSIVE", "bomb_site_mp");
    }

    var_13 = "bomb_explosion";

    if(isDefined(var_0._id_9D65._id_359B))
      var_13 = var_0._id_9D65._id_359B;

    var_14 = _func_0A3(360);
    var_15 = _func_14B(level._effect[var_13], var_11, (0, 0, 1), (_func_0A7(var_14), _func_0A6(var_14), 0));
    _func_14C(var_15);
    _func_175(var_11, 200, 100, 3);
    _func_1BB("grenade_rumble", var_10);
    _func_17F(0.75, 2.0, var_10, 2000);
    thread maps\mp\_utility::playsoundinspace("mp_snd_bomb_detonated", var_10);

    if(isDefined(var_0._id_3947))
      common_scripts\_exploder::exploder(var_0._id_3947);
  }

  for(var_16 = 0; var_16 < level._id_1913.size; var_16++)
    level._id_1913[var_16] _id_04D1::_id_2F93();

  var_9 _id_04D1::_id_2F93();
  _func_137(0);
  wait 3;

  if(common_scripts\utility::_id_562E(level._id_5677))
    level._id_832F._id_9D65 notify("obj_complete");
  else
    _id_832A(game["attackers"], game["end_reason"]["target_destroyed"]);
}

_id_190B(var_0) {
  level endon("game_ended");
  level endon("bomb_defused");
  var_1 = int(level._id_1909 * 1000 + gettime());
  _func_032("ui_bomb" + var_0 + "_timer_endtime", var_1);
  level thread _id_4ACC(var_0, var_1);
  maps\mp\gametypes\_hostmigration::_id_A6F4(level._id_1909);
}

_id_4ACC(var_0, var_1) {
  level endon("game_ended");
  level endon("bomb_defused");
  level endon("game_ended");
  level endon("disconnect");
  level waittill("host_migration_begin");
  _func_032("ui_bomb" + var_0 + "_timer_endtime", 0);
  var_2 = maps\mp\gametypes\_hostmigration::_id_A782();

  if(var_2 > 0)
    _func_032("ui_bomb" + var_0 + "_timer_endtime", var_1 + var_2);
}

_id_6AEF(var_0) {
  if(isDefined(var_0))
    var_0 _meth_8608(0);

  _id_04D1::_id_860A("friendly", "waypoint_bomb");
  _id_04D1::_id_860E("friendly", "waypoint_bomb", undefined, 1);
  maps\mp\_utility::playsoundonplayers(game["bomb_dropped_sound"], game["attackers"]);
  maps\mp\_utility::playsoundonplayers(game["bomb_dropped_enemy_sound"], game["defenders"]);

  if(isDefined(var_0) && isDefined(var_0._id_568D) && var_0._id_568D)
    var_0._id_568D = 0;
}

_id_1F79(var_0) {
  if(!isDefined(var_0))
    return 0;

  return 1;
}

_id_6BC3(var_0) {
  var_0 notify("bomb_defused");
  level thread _id_18D3();
  _id_04D1::_id_2F93();
  _func_032("ui_bomb" + self.label + "_state", 0);
  maps\mp\_utility::leaderdialog("bomb_defused_attackers", game["attackers"]);
  maps\mp\_utility::leaderdialog("bomb_defused_defenders", game["defenders"]);
  maps\mp\_utility::playsoundonplayers(game["bomb_disarm_enemy_sound"], game["attackers"]);
  maps\mp\_utility::playsoundonplayers(game["bomb_disarm_sound"], game["defenders"]);
  var_1 = "defuse";

  if(isDefined(level._id_18F8) && maps\mp\_utility::isreallyalive(level._id_18F8))
    var_1 = "ninja_defuse";

  if(_id_5742(var_0) && isDefined(self) && isDefined(self._id_6DB2) && _func_159(maps\mp\_utility::getotherteam(self._id_6DB2)) > 0)
    var_1 = "last_man_defuse";

  var_2 = _id_4CB0(self.label, var_1);
  var_0 thread _id_047A::_id_18D4(var_1, var_2);
}

_id_5742(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      continue;
    }
    if(var_2.team != var_0.team) {
      continue;
    }
    if(var_2 maps\mp\gametypes\_playerlogic::mayspawn())
      return 0;

    if(maps\mp\_utility::isreallyalive(var_2))
      return 0;
  }

  return 1;
}

_id_18D3() {
  level._id_99C0 maps\mp\gametypes\_gamelogic::_id_9415();
  level._id_18D3 = 1;
  _func_032("ui_broadcaster_game_mode_status_1", 0);
  level notify("bomb_defused");
  wait 1.5;
  _func_137(0);
  _id_832A(game["defenders"], game["end_reason"]["bomb_defused"]);
}

_id_6AC9(var_0) {
  var_0 iprintlnbold(&"MP_CANT_PLANT_WITHOUT_BOMB");
}

_id_6BB6() {
  _id_832A(game["defenders"], game["end_reason"]["time_limit_reached"]);
}

_id_832A(var_0, var_1) {
  level._id_3B5C = var_0;

  if(var_1 == game["end_reason"]["target_destroyed"] || var_1 == game["end_reason"]["bomb_defused"]) {
    var_2 = 1;

    foreach(var_4 in level._id_1913) {
      if(isDefined(level._id_3B52[var_0]) && level._id_3B52[var_0] == var_4._id_5A2D) {
        var_2 = 0;
        break;
      }
    }

    if(var_2)
      _id_04CE::_id_3801();
  }

  _id_04D2::_id_47BD(var_0, 1, 1);
  thread maps\mp\gametypes\_gamelogic::_id_36B9(var_0, var_1);
}

_id_21AB() {
  waitframe();
  var_0 = 0;

  if(!level._id_0BC3[game["attackers"]]) {
    level._id_90E2[game["attackers"]]._id_0C22 = 1;
    var_0 = 1;
  }

  if(!level._id_0BC3[game["defenders"]]) {
    level._id_90E2[game["defenders"]]._id_0C22 = 1;
    var_0 = 1;
  }

  if(var_0)
    _id_050F::_id_A16A();
}

_id_6AE2(var_0) {
  if(level._id_18EE || level._id_18D3) {
    return;
  }
  if(var_0 == "all") {
    if(level._id_18F9)
      _id_832A(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
    else
      _id_832A(game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"]);
  } else if(var_0 == game["attackers"]) {
    if(level._id_18F9) {
      return;
    }
    level thread _id_832A(game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"]);
  } else if(var_0 == game["defenders"])
    level thread _id_832A(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
}

_id_6B5E(var_0) {
  if(level._id_18EE || level._id_18D3) {
    return;
  }
  var_1 = maps\mp\_utility::getlastlivingplayer(var_0);
  var_1 thread _id_478F();
}

_id_478F() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  maps\mp\_utility::waittillrecoveredhealth(3);
  var_0 = maps\mp\_utility::getotherteam(self.pers["team"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_lastenemyalive", self, var_0);
  level notify("last_alive", self);
  maps\mp\_utility::_id_863E(16, self.team, self getentitynumber());
  maps\mp\gametypes\_missions::_id_5BBD();
}

_id_6B93() {}

_id_0F2F() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(self._id_56A3) && self._id_56A3 == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self _meth_82E4())
    waitframe();

  while(!self _meth_8346())
    waitframe();

  self.pers["gamemodeLoadout"] = level._id_832B[self.team];
  self._id_3FC5 = self.class;
  self._id_3FC4 = 1;
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "gamemode";
  self.class = "gamemode";
  self.lastclass = "gamemode";
  self notify("faux_spawn");
  maps\mp\gametypes\_class::_id_4773(self.team, "gamemode");

  if(self._id_5DF6)
    _id_051E::_id_A129(1);

  _id_7B84();
}

_id_7B84() {
  var_0 = self _meth_82D1();

  foreach(var_2 in var_0)
  self _meth_84AF(var_2);
}

_id_7CD2() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(self._id_56A3) && self._id_56A3 == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self _meth_82E4())
    waitframe();

  while(!self _meth_8346())
    waitframe();

  self.pers["gamemodeLoadout"] = undefined;
  self notify("faux_spawn");
  maps\mp\gametypes\_class::_id_4773(self.team, self.class);

  if(self._id_5DF6)
    _id_051E::_id_A129(1);

  _id_7B84();
}