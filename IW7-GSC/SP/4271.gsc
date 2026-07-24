/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4271.gsc
**************************************/

_id_10A42(var_0, var_1) {
  var_0 fadeovertime(var_1);
  var_0.alpha = 0;
  var_0 scripts\engine\utility::delaycall(var_1, ::destroy);
}

_id_A047() {
  level._id_111D0 = scripts\engine\utility::spawn_tag_origin();
  level._id_111D0._id_1120D = getmapsunangles();
  level._id_111D0.suncolor = getmapsuncolorandintensity();
  level._id_111D0._id_99E5 = level._id_111D0.suncolor[3];
  level._id_111D0.suncolor = (level._id_111D0.suncolor[0], level._id_111D0.suncolor[1], level._id_111D0.suncolor[2]);
  level._id_111D0._id_75AC = (0, 0, 0);
  scripts\engine\utility::flag_init("flag_pause_sun_fx_updates");

  for(;;) {
    if(scripts\engine\utility::flag("flag_pause_sun_fx_updates")) {
      wait 0.05;
      continue;
    }

    if(isDefined(level._id_D127) && level._id_D127 _id_0BDC::_id_A2A7()) {
      var_0 = level._id_D127.origin;
    } else {
      var_0 = level.player.origin;
    }

    var_1 = (200000, 0, 0);
    var_1 = rotatevector(var_1, level._id_111D0._id_1120D + level._id_111D0._id_75AC);
    level._id_111D0.origin = var_0 + var_1;
    wait 0.05;
  }
}

_id_F031(var_0) {
  if(isDefined(var_0) && var_0) {
    self waittill("ftl_complete");
  }

  var_1 = "cannon_missile_ca_hardpoint cannon_small_ca,3,1,amb_turret_sml_l_ts_1,amb_turret_sml_l_ts_5,amb_turret_sml_r_ts_1,amb_turret_sml_r_ts_5,amb_turret_sml_r_ts_6,amb_turret_sml_r_ts_7,amb_turret_sml_l_ts_6,amb_turret_sml_l_ts_7,amb_turret_sml_m_3,amb_turret_sml_m_4 cannon_flak_ca,3,1 cannon_phalanx,1,1,amb_turret_sml_m_1,amb_turret_sml_m_2";
  thread _id_0BAD::_id_F030(1, 1, var_1);
  self._id_BCDA = scripts\engine\utility::spawn_script_origin();
  self linkTo(self._id_BCDA);
  self notify("mover_spawned");
}

_id_F04C(var_0) {
  if(isDefined(var_0) && var_0) {
    self waittill("ftl_complete");
  }

  var_1 = [level._id_D127];
  var_2 = getEntArray("missileboat_volume", "targetname");
  var_3 = undefined;

  foreach(var_5 in var_2) {
    if(ispointinvolume(self.origin, var_5)) {
      var_3 = var_5;
      break;
    }
  }

  if(!isDefined(var_3)) {
    var_7 = undefined;

    foreach(var_5 in var_2) {
      var_9 = distance(var_5.origin, self.origin);

      if(!isDefined(var_7) || var_9 < var_7) {
        var_7 = var_9;
        var_3 = var_5;
      }
    }
  }

  thread _id_0BB1::_id_F486(var_3, var_1);
  wait 0.2;
  self notify("no_ftl_escape");
}

_id_1022E(var_0) {
  level._id_A3A8[var_0]._id_FE2D[level._id_A3A8[var_0]._id_FE2D.size] = self;
  level._id_A3A8[var_0]._id_10854 = level._id_A3A8[var_0]._id_10854 + 1;
  thread _id_A2A3(1);

  if(isDefined(self._id_A420)) {
    foreach(var_2 in self._id_A420) {
      level._id_A3A8[var_0]._id_FE2D[level._id_A3A8[var_0]._id_FE2D.size] = var_2;
      level._id_A3A8[var_0]._id_10854 = level._id_A3A8[var_0]._id_10854 + 1;
      var_2 thread _id_A2A3(1);
    }
  }
}

_id_1022D(var_0) {
  level._id_A3A8[var_0]._id_FE2D[level._id_A3A8[var_0]._id_FE2D.size] = self;
  level._id_A3A8[var_0]._id_10854 = level._id_A3A8[var_0]._id_10854 + 1;
  thread _id_A2A3(1);
  thread _id_1022F(var_0);
  wait 0.5;

  if(isDefined(self._id_A420)) {
    foreach(var_2 in self._id_A420) {
      level._id_A3A8[var_0]._id_FE2D[level._id_A3A8[var_0]._id_FE2D.size] = var_2;
      level._id_A3A8[var_0]._id_10854 = level._id_A3A8[var_0]._id_10854 + 1;
      var_2 thread _id_A2A3(1);
      var_2 thread _id_1022F(var_0);
    }
  }
}

_id_1022F(var_0) {
  self endon("constant_start");
  self waittill("death");

  if(!isDefined(self._id_4090) && isDefined(self._id_4B43) && isDefined(self._id_4B43.owner) && self._id_4B43.owner == level.player) {
    level._id_A3A8[var_0].kills = level._id_A3A8[var_0].kills + 1;
  }
}

_id_1022C(var_0) {
  foreach(var_2 in level._id_A3A8[var_0]._id_FE2D) {
    if(isDefined(var_2._id_A420)) {
      foreach(var_4 in var_2._id_A420) {
        level._id_A3A8[var_0]._id_FE2D[level._id_A3A8[var_0]._id_FE2D.size] = var_4;
      }
    }
  }

  level notify(var_0 + "added_squadmates");
}

_id_B2E1(var_0, var_1) {
  level._id_A3A8[var_0] endon("stop_spawning_jackals");
  level._id_A3A8[var_0]._id_4B25 = floor(level._id_A3A8[var_0]._id_4B24 * 0.5);

  if(!isDefined(level._id_A3A8[var_0]._id_FE2D)) {
    level._id_A3A8[var_0]._id_FE2D = [];
  }

  level._id_A3A8[var_0]._id_FE32 = [];
  level._id_A3A8[var_0]._id_FE31 = [];
  var_2 = getEntArray(level._id_A3A8[var_0]._id_10879, "targetname");

  foreach(var_4 in level._id_A3A8[var_0]._id_FE2D) {
    _id_67E7(var_4, var_0, 0, 1);
  }

  if(var_1) {
    foreach(var_7 in var_2) {
      wait 0.05;

      if(level._id_A3A8[var_0]._id_FE2D.size >= level._id_A3A8[var_0]._id_4B24 || level._id_A056._id_1630.size >= 26) {
        continue;
      }
      var_8 = var_7 scripts\sp\utility::_id_10808();
      _id_67E7(var_8, var_0, 1, 1);

      if(level._id_A3A8[var_0]._id_FE32.size + level._id_A3A8[var_0]._id_FE31.size >= level._id_A3A8[var_0]._id_4B24) {
        break;
      }
    }
  }

  var_10 = 0;
  var_11 = 0;

  for(;;) {
    var_12 = _id_7C6C(var_0);
    wait 0.1;
    level._id_A3A8[var_0]._id_FE2D = scripts\engine\utility::array_removeundefined(level._id_A3A8[var_0]._id_FE2D);
    level._id_A3A8[var_0]._id_FE32 = scripts\engine\utility::array_removeundefined(level._id_A3A8[var_0]._id_FE32);
    level._id_A3A8[var_0]._id_FE31 = scripts\engine\utility::array_removeundefined(level._id_A3A8[var_0]._id_FE31);

    if(level._id_A3A8[var_0].kills >= level._id_A3A8[var_0]._id_A683) {
      if(level._id_A3A8[var_0]._id_A671) {
        foreach(var_14 in level._id_A3A8[var_0]._id_FE2D) {
          if(!isDefined(var_14._id_4090)) {
            var_14._id_4090 = 1;
            var_14 thread _id_50BF(randomfloatrange(0, 2.5));
          }
        }
      }

      level._id_A3A8[var_0] notify("stop_spawning_jackals");
    }

    level._id_A3A8[var_0]._id_4B24 = _id_7C6C(var_0);
    level._id_A3A8[var_0]._id_4B25 = floor(level._id_A3A8[var_0]._id_4B24 * 0.5);

    if(level._id_A3A8[var_0]._id_4B24 != var_12) {
      var_10 = gettime() + randomfloatrange(1.0, 4.0) * 1000.0;
      var_11 = gettime() + randomfloatrange(1.0, 4.0) * 1000.0;
    }

    if(level._id_A3A8[var_0]._id_FE2D.size < level._id_A3A8[var_0]._id_4B24 && level._id_A056._id_1630.size < 26 && gettime() >= var_11) {
      foreach(var_7 in var_2) {
        var_17 = vectordot(anglesToForward(level.player getplayerangles()), vectorNormalize(var_7.origin - _id_0BDC::_id_7BBA()));

        if(var_17 < 0.3) {
          var_8 = var_7 scripts\sp\utility::_id_10808();
          _id_67E7(var_8, var_0, 1, 1);
          var_11 = gettime() + randomfloatrange(1.0, 4.0) * 1000.0;
          break;
        }
      }

      continue;
    }

    if(level._id_A3A8[var_0]._id_FE2D.size > level._id_A3A8[var_0]._id_4B24 && gettime() >= var_10) {
      if(level._id_A3A8[var_0].kills < level._id_A3A8[var_0]._id_A683) {
        var_19 = scripts\engine\utility::random(level._id_A3A8[var_0]._id_FE2D);

        if(isDefined(var_19._id_4090)) {
          continue;
        }
        var_19._id_4090 = 1;
        var_19 thread _id_50BF(0);
        var_10 = gettime() + randomfloatrange(1.0, 4.0) * 1000.0;
      }
    }
  }
}

_id_B2C6(var_0) {
  self endon("stop_spawning_jackals");
  level._id_A3A8[var_0]._id_4B25 = floor(self._id_B479 * 0.5);

  if(!isDefined(level._id_A3A8[var_0]._id_FE2D)) {
    level._id_A3A8[var_0]._id_FE2D = [];
  }

  level._id_A3A8[var_0]._id_FE32 = [];
  level._id_A3A8[var_0]._id_FE31 = [];
  var_1 = getEntArray(level._id_A3A8[var_0]._id_10879, "targetname");

  foreach(var_3 in var_1) {
    wait 0.05;

    if(level._id_A056._id_1630.size >= 26) {
      continue;
    }
    var_4 = var_3 scripts\sp\utility::_id_10808();
    _id_67E7(var_4, var_0, 1, 0);

    if(level._id_A3A8[var_0]._id_FE32.size + level._id_A3A8[var_0]._id_FE31.size >= self._id_B479) {
      break;
    }
  }

  for(;;) {
    wait 0.1;
    level._id_A3A8[var_0]._id_FE2D = scripts\engine\utility::array_removeundefined(level._id_A3A8[var_0]._id_FE2D);
    level._id_A3A8[var_0]._id_FE32 = scripts\engine\utility::array_removeundefined(level._id_A3A8[var_0]._id_FE32);
    level._id_A3A8[var_0]._id_FE31 = scripts\engine\utility::array_removeundefined(level._id_A3A8[var_0]._id_FE31);

    if(level._id_A3A8[var_0]._id_FE2D.size < self._id_B479 && level._id_A056._id_1630.size < 26) {
      foreach(var_3 in var_1) {
        var_7 = vectordot(anglesToForward(level.player getplayerangles()), vectorNormalize(var_3.origin - _id_0BDC::_id_7BBA()));

        if(var_7 < 0.3) {
          var_4 = var_3 scripts\sp\utility::_id_10808();
          _id_67E7(var_4, var_0, 1, 0);
          break;
        }
      }
    }
  }
}

_id_7C6C(var_0) {
  var_1 = level._id_A3A8[var_0]._id_B496;
  var_2 = level._id_A3A8[var_0]._id_B776;
  var_3 = min(level._id_A3A8[var_0].kills / (level._id_A3A8[var_0]._id_A683 - 1), 1.0);
  var_4 = var_1 - var_2;
  var_5 = int(var_2 + ceil(abs(var_3 - 1.0) * var_4));
  return var_5;
}

_id_67E7(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(isDefined(var_3) && var_3) {
    var_0 thread _id_6535(var_1);
  }

  if(!scripts\engine\utility::array_contains(level._id_A3A8[var_1]._id_FE2D, var_0)) {
    level._id_A3A8[var_1]._id_FE2D[level._id_A3A8[var_1]._id_FE2D.size] = var_0;
  }

  if(level._id_A3A8[var_1]._id_FE32.size < level._id_A3A8[var_1]._id_4B25) {
    level._id_A3A8[var_1]._id_FE32[level._id_A3A8[var_1]._id_FE32.size] = var_0;
    var_0 thread _id_A2A3(var_2);
  } else {
    level._id_A3A8[var_1]._id_FE31[level._id_A3A8[var_1]._id_FE31.size] = var_0;
    var_0 thread _id_A123(var_2);
  }
}

_id_A2A3(var_0) {
  self endon("death");
  self endon("entitydeleted");

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  while(isDefined(self._id_A42D)) {
    wait 0.05;
  }

  var_1 = "patrol_generic";
  var_2 = "evade_generic";

  if(var_0 && isDefined(self.target)) {
    self._id_A42D = 1;
    _id_0BDC::_id_19A9();
    var_3 = getcsplineidarray(self.target);
    thread _id_0BDC::_id_A1EF(var_3[randomint(var_3.size)]);
    self waittill("end_spline");
  }

  _id_0BDC::_id_19B3("patrol", var_1);
  var_3 = getcsplineidarray(var_2);

  if(var_3.size > 0) {
    _id_0BDC::_id_19B3("escape", var_2);
  }

  _id_0BDC::_id_1988();
  _id_0BDC::_id_1990(1);
  self._id_A42D = undefined;
}

_id_A123(var_0) {
  self endon("death");
  self endon("entitydeleted");

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  while(isDefined(self._id_A42D)) {
    wait 0.05;
  }

  if(var_0 && isDefined(self.target)) {
    self._id_A42D = 1;
    _id_0BDC::_id_19A9();
    var_1 = getcsplineidarray(self.target);
    thread _id_0BDC::_id_A1EF(var_1[randomint(var_1.size)]);
    self waittill("end_spline");
  }

  _id_0BDC::_id_1988();
  _id_0BDC::_id_1990(0);
  _id_0BDC::_id_19AE("shoot_at_will");
  self._id_A42D = undefined;
}

_id_6535(var_0) {
  self notify("enemy_track_death" + var_0);
  self endon("enemy_track_death" + var_0);
  self waittill("death");

  if(!isDefined(self._id_4090) && isDefined(self._id_4B43) && isDefined(self._id_4B43.owner) && self._id_4B43.owner == level.player) {
    level._id_A3A8[var_0].kills = level._id_A3A8[var_0].kills + 1;
  }
}

_id_50BF(var_0) {
  wait(var_0);

  if(isDefined(self) && isalive(self)) {
    self _meth_81D0();
  }
}

_id_E3DF(var_0) {
  level endon("retribution_kill_destroyer_hit");
  wait 7.0;
  level notify("retribution_kill_destroyer_timeout");
}

_id_E3DE(var_0) {
  level endon("retribution_kill_destroyer_timeout");
  var_1 = 0;

  while(var_1 < 2) {
    var_0 waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(var_6 == "MOD_EXPLOSIVE" && var_3 == level._id_E35D) {
      var_1 = var_1 + 1;
    }

    wait 0.05;
  }

  level notify("retribution_kill_destroyer_hit");
}

_id_52EF(var_0, var_1) {
  if(var_0 && scripts\sp\utility::_id_D123()) {
    self._id_54CD = 0;

    if(var_1 > 0) {
      thread _id_52F0(var_1);
    }

    var_2 = 0.8;
    var_3 = 1.0;
    var_4 = undefined;

    for(;;) {
      if(!isDefined(self) || !isalive(self)) {
        break;
      }

      if(self._id_54CD) {
        break;
      }

      var_5 = anglesToForward(level._id_D127.angles);
      var_6 = self.origin - level._id_D127.origin;
      var_7 = vectorNormalize(var_6);
      var_8 = length(var_6);
      var_9 = vectordot(var_7, var_5);

      if(var_9 >= var_2) {
        if(isDefined(var_4)) {
          if(gettime() - var_3 * 1000 >= var_4) {
            break;
          }
        } else
          var_4 = gettime();
      } else
        var_4 = undefined;

      wait 0.05;
    }
  }

  if(isDefined(self) && isalive(self)) {
    level notify("retribution_killed_destroyer");
    self notify("retribution_killed_destroyer");
    self._id_10250 = 0;
    self _meth_81D0();
  }
}

_id_52F0(var_0) {
  self endon("retribution_killed_destroyer");
  wait(var_0);
  self._id_54CD = 1;
}

_id_A7BD(var_0, var_1, var_2, var_3, var_4) {
  level notify("land_on_retribution");
  level._id_E35D _id_0BB6::_id_3966(0, 0);
  level._id_E35D _id_0BDC::_id_A16B(3);
  scripts\engine\utility::flag_set("jackal_hint_ret_return");
  scripts\sp\utility::_id_56BE("jackal_return_to_ret", 3);
  level._id_FD6E._id_E35D thread _id_E3C5();
  scripts\engine\utility::flag_waitopen("jackal_assault_vo_playing");

  if(isDefined(var_4)) {
    thread _id_A7BE(var_4);
  }

  thread _id_A7BF(var_0);
  level endon("player_jackal_drone_dock");
  var_5 = 0;
  var_6 = 1;
  var_7 = 0;
  var_8 = 0;

  for(;;) {
    if(!var_5 && distance(level._id_E35D.origin, level._id_D127.origin) > 48000) {
      thread _id_A7BC();
      var_5 = 1;
      var_6 = 0;
      wait 0.05;
      continue;
    }

    while(distance(level._id_E35D.origin, level._id_D127.origin) <= 48000) {
      if(!var_7) {
        if(!var_6) {
          if(isDefined(var_1) && _id_0B76::_id_7A60(level._id_E35D.origin) >= 0.7) {
            thread _id_10B0::_id_CE83(var_1);
            var_7 = 1;
          }
        } else if(isDefined(var_2) && _id_0B76::_id_7A60(level._id_E35D.origin) >= 0.7) {
          thread _id_10B0::_id_CE83(var_2);
          var_7 = 1;
        }
      }

      level notify("land_on_ret_near_ret");
      var_5 = 0;
      var_6 = 1;

      if(!var_8) {
        if(scripts\engine\utility::flag("jackal_landing_active")) {
          thread _id_10B0::_id_CE85(var_3);
          var_8 = 1;
        }
      }

      wait 0.05;
    }

    wait 0.05;
  }
}

_id_A7BE(var_0) {
  level.player endon("death");
  level waittill("player_jackal_drone_dock");
  thread _id_10B0::_id_CE85(var_0);
}

_id_A7BC() {
  level endon("land_on_ret_near_ret");

  for(;;) {
    wait(randomfloatrange(11.0, 15.0));
    thread _id_10B0::_id_CE83(_id_10B0::_id_13501, 1);
  }
}

_id_A7BF(var_0) {
  level waittill("player_jackal_drone_dock");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264(level._id_A3A8[var_0]._id_C288));
  _id_0B76::_id_4474(level._id_A3A8[var_0]._id_C27F);
  wait 2.0;
}

_id_E383() {
  level waittill("stop_retribution_circling");
  thread _id_E3E5();
}

_id_E3E5() {
  while(level._id_FD6E._id_E35D._id_E720 > 0.001) {
    level._id_FD6E._id_E35D._id_E720 = level._id_FD6E._id_E35D._id_E720 * 0.99;
    wait 0.05;
  }

  level notify("stop_retribution_circling");
}

_id_E3C5() {
  level notify("stop jackal landing");
  level endon("stop jackal landing");
  _id_0BDC::_id_137CF();
  level._id_FD6E._id_E35D thread _id_0BDB::_id_A2F2();
  level waittill("player_jackal_drone_dock");
  level waittill("jackal_taxi_complete");
  scripts\sp\utility::_id_BF95();
}

_id_96A4(var_0, var_1) {
  scripts\engine\utility::flag_init(var_0 + "start");
  scripts\engine\utility::flag_init(var_0 + "complete");
  scripts\engine\utility::flag_init(var_0 + "complete_vo_finished");

  if(var_1 > 1) {
    for(var_2 = var_1 - 1; var_2 > 0; var_2--) {
      scripts\engine\utility::flag_init(var_0 + var_2 + "_left");
    }
  }
}

_id_F9ED() {
  var_0 = level._id_A3AA;
  level._id_A3AA++;
  return var_0;
}

_id_11AAC(var_0, var_1) {
  scripts\engine\utility::flag_set(var_0 + "start");

  for(var_2 = level._id_A3A8[var_0]._id_C224; var_2 > 0; var_2--) {
    if(var_2 == 1) {
      level._id_A3A8[var_0]._id_1354E = level._id_A3A8[var_0]._id_1354F;
    }

    for(;;) {
      level._id_A3A8[var_0]._id_FE2D = scripts\engine\utility::array_removeundefined(level._id_A3A8[var_0]._id_FE2D);

      if(level._id_A3A8[var_0]._id_FE2D.size < var_2) {
        break;
      }

      wait 0.05;
    }

    if(var_2 > 1) {
      scripts\engine\utility::flag_set(var_0 + (var_2 - 1) + "_left");
    }

    level notify("player_killed_enemy");
    level notify("player_killed_enemy" + var_1);
  }

  _id_4478(var_0, var_1);
}

_id_4478(var_0, var_1) {
  level notify("player_completed_objective");
  scripts\engine\utility::flag_set(var_0 + "complete");
  level._id_A3A8[var_0]._id_4469 = 1;

  if(isDefined(level._id_A3A8[var_0]._id_C27F)) {
    _id_0B76::_id_4474(level._id_A3A8[var_0]._id_C27F);
    scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264(level._id_A3A8[var_0]._id_C288));
  }

  if(isDefined(level._id_A3A8[var_0]._id_13522)) {
    var_2 = 1.7;

    if(isDefined(var_1) && var_1 == "destroyer") {
      var_2 = 3.0;
    } else if(isDefined(var_1) && var_1 == "missileboat") {
      var_2 = 2.5;
    }

    _id_10B0::_id_CE83(level._id_A3A8[var_0]._id_13522, 0, var_2);
  }

  scripts\engine\utility::flag_set(var_0 + "complete_vo_finished");
}

_id_6D0A(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  var_7 = scripts\engine\utility::random(var_0);

  if(!isDefined(var_7)) {
    return;
  }
  var_8 = _id_0B76::_id_A26D(0.25, 0.5, 1000, 0.15, 0.3, 1000);
  var_9 = 2000;
  var_10 = 3000;
  var_11 = 3500;
  var_12 = 0.75;
  var_13 = (0, 0, 0);
  var_14 = 0;

  foreach(var_16 in var_1) {
    var_17 = self gettagangles(var_16.tag);
    var_17 = invertangles(var_17);
    var_18 = scripts\engine\utility::spawn_tag_origin();
    var_18.origin = self gettagorigin(var_16.tag);
    var_18.angles = var_17;
    var_19 = (0, 0, 0);

    if(isDefined(var_7._id_24C4)) {
      var_20 = scripts\engine\utility::random(var_7._id_24C4);
      var_21 = var_7 gettagorigin(var_20);
      var_19 = var_7.origin - var_21;
    }

    var_22 = 0;

    if(isDefined(var_5) && !var_5) {
      var_22 = 1;
    }

    var_23 = 0;

    if(isDefined(var_6) && !var_6) {
      var_23 = 1;
    }

    if(isDefined(level._id_39B6) && !level._id_39B6) {
      var_23 = 1;
    }

    if(var_14 == 0) {
      self playSound("capitalship_missile_salvo_mixed");
    }

    var_24 = var_9;
    var_25 = var_10;
    var_26 = var_11;

    if(isDefined(self._id_12FB8) && self._id_12FB8) {
      var_18._id_C180 = 1;
    }

    var_18._id_AA99 = "capitalship_missile_launch";
    var_18._id_69E9 = "capitalship_missile_impact";
    var_18._id_BFEC = var_23;
    var_18 thread _id_0B76::_id_A332(var_7, 0, self, var_3, var_25, var_13, 0, var_4, var_24, 1, var_12, var_22, var_19, var_8, var_26);
    var_14 = var_14 + 1;

    if(var_14 >= var_2._id_B46E) {
      break;
    }

    wait(var_2._id_6D20);
  }

  wait(randomfloatrange(var_2._id_13535[0], var_2._id_13535[1]));
}

_id_A042() {
  var_0 = 100;
  var_1 = 20;
  var_2 = 34;
  var_3 = 0;

  for(;;) {
    var_4 = ["player_completed_objective", "player_killed_enemyskelter", "player_killed_enemymissileboat", "player_killed_enemyace", "player_killed_enemydestroyer"];
    var_5 = scripts\engine\utility::waittill_any_in_array_return(var_4);
    var_6 = 0;

    if(var_5 == "player_completed_objective") {
      var_6 = 1;
    } else if(var_5 == "player_killed_enemydestroyer") {
      var_6 = 1;
    } else if(var_5 == "player_killed_enemyskelter") {
      var_3 = var_3 + var_1;
    } else if(var_5 == "player_killed_enemyace") {
      var_3 = var_3 + var_2;
    } else if(var_5 == "player_killed_enemymissileboat") {
      var_6 = 1;
    }

    if(var_3 >= var_0) {
      var_6 = 1;
    }

    if(var_6) {
      thread scripts\sp\utility::_id_2669("ja_autosave");
      var_3 = 0;
    }
  }
}

_id_56B4(var_0) {
  var_1 = level._id_A3A8[var_0]._id_A683;
  var_2 = 0;

  for(var_3 = var_1 - 1; var_3 > 0; var_3--) {
    scripts\engine\utility::flag_wait(level._id_A3A8[var_0]._id_68B1 + var_3 + "_left");
    var_2++;
    _id_0B76::_id_F432(level._id_A3A8[var_0]._id_C27F, var_2);
  }

  scripts\engine\utility::flag_wait(level._id_A3A8[var_0]._id_68B1 + "complete");
  var_2++;
  _id_0B76::_id_F432(level._id_A3A8[var_0]._id_C27F, var_2);
}