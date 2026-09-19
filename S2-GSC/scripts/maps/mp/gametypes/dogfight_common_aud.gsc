/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\dogfight_common_aud.gsc
*************************************************************/

init_dogfight_audio() {
  _id_02F0::_id_7FE7();
  _id_51D8();
  _id_02F2::_id_524C();
  _id_5C22();
  _id_7BD2();
  _id_02F0::_id_8014("sndentity");
}

init_plane_data() {
  self._id_11CB = spawnStruct();
  self._id_11CB._id_0CAC = 0;
  self._id_11CB._id_0863 = 0;
  self._id_11CB.p47_throttle_pitch = 1.0;
  self._id_11CB.p47_throttle_on = 0;
  self._id_11CB.p47_brake_on = 0;
  self._id_11CB.acceleration_vol_boost = 0;
}

_id_51D8() {
  level._id_9B88 = 0;
}

_id_5C22() {
  level thread init_dogfight_submix();
}

_id_7BD2() {
  _id_0378::_id_8DC7("aud_figher_spawn", ::fighter_spawn);
  _id_0378::_id_8DC7("p47_turret_plr", ::_id_6DD0);
  _id_0378::_id_8DC7("aud_fighter_start_death", ::fighter_start_death);
  _id_0378::_id_8DC7("aud_fighter_final_explosion", ::fighter_final_explosion);
  _id_0378::_id_8DC7("aud_fighter_damage_state_change", ::fighter_damage_state_change);
}

init_dogfight_submix() {
  _id_0380::_id_6840("amb_mp_husky_ext_dog_fight", undefined, 7.0);
}

fighter_spawn() {
  var_0 = self _meth_8251();
  var_0 _id_02F2::_id_8A9D("mp_dogfight");
  self._id_11CB = spawnStruct();
  self._id_11CB._id_0CAC = 0;
  self._id_11CB._id_0863 = 0;
  self._id_11CB.p47_throttle_pitch = 1.0;
  self._id_11CB.p47_throttle_on = 0;
  self._id_11CB.p47_brake_on = 0;
  self._id_11CB.acceleration_vol_boost = 0;
  self._id_11CB.hard_bank = 0;
  self._id_11CB.pitching = 0;
  common_scripts\utility::flag_init("damage_state_1");
  common_scripts\utility::flag_init("damage_state_2");
  thread _id_6DBE();
}

p47_watch_game_end(var_0, var_1) {
  level waittill("game_ended");
  var_0 endon("death");
  var_1 endon("death");
  var_1 notify("stop_p47_sounds");
}

_id_6DBE() {
  wait 0.4;
  var_0 = self _meth_8251();

  if(!isDefined(var_0)) {
    return;
  }
  self endon("death");
  var_0 endon("death");
  self notify("stop_p47_sounds");
  var_1 = _id_0380::_id_6847("blg_p47_engine_plr_lp", undefined, self, 1, 1, 0.5, self, "stop_p47_sounds");
  var_2 = _id_0380::_id_6847("blg_p47_turn_lp", var_0, self, 1, 1, 0.5, self, "stop_p47_sounds");
  var_3 = _id_0380::_id_6847("blg_p47_rattle_lp", var_0, self, 1, 1, 0.5, self, "stop_p47_sounds");
  var_4 = _id_0380::_id_6847("blg_wind_lp", var_0, self, 1, 1, 0.5, self, "stop_p47_sounds");
  thread main_engine_loop(var_1);
  thread _id_1585(var_2, var_3);
  thread _id_AA25(var_4);
  var_0 thread raid_flyby_watcher(var_0.team);
  thread dogfight_close_loop(var_0, var_0.team);
  thread p47_watch_game_end(var_0, self);
}

main_engine_loop(var_0) {
  var_1 = self _meth_8251();

  if(!isDefined(var_1)) {
    return;
  }
  self endon("stop_p47_sounds");
  self endon("death");
  var_2 = ["blg_p47_accelerate_start1", "blg_p47_accelerate_start2", "blg_p47_accelerate_start3"];
  var_3 = ["blg_p47_brake1", "blg_p47_brake2", "blg_p47_brake3"];
  self._id_11CB.engine_pitch_multiplier = 1;
  self._id_11CB.engine_vol_multiplier = 0.5;
  var_4 = 0.5;
  var_5 = 0;

  while(isDefined(self) == 1) {
    var_6 = var_1 getnormalizedmovementx();

    if(var_6 <= -0.5 && self._id_11CB.pitching == 0) {
      if(self._id_11CB.p47_brake_on == 0) {
        self._id_11CB.p47_brake_on = 1;
        self notify("stop_accelerate_sound");
        var_7 = _id_02EF::_id_42DD(var_3, "brake_aliases", 3);
        var_8 = _id_0380::_id_6844(var_7, var_1, self, 0, 1);
      }

      self._id_11CB.engine_pitch_multiplier = self._id_11CB.engine_pitch_multiplier * 0.99;

      if(self._id_11CB.engine_pitch_multiplier < 0.8)
        self._id_11CB.engine_pitch_multiplier = 0.85;

      self._id_11CB.engine_vol_multiplier = self._id_11CB.engine_vol_multiplier * 1.1;

      if(self._id_11CB.engine_vol_multiplier > 1)
        self._id_11CB.engine_vol_multiplier = 1;
    } else if(var_6 < 0.5 && var_6 >= 0 && self._id_11CB.pitching == 0) {
      if(self._id_11CB.p47_throttle_on == 1 || self._id_11CB.p47_brake_on == 1) {
        self._id_11CB.p47_throttle_on = 0;
        self._id_11CB.p47_brake_on = 0;
      }

      if(self._id_11CB.engine_pitch_multiplier > 1)
        self._id_11CB.engine_pitch_multiplier = self._id_11CB.engine_pitch_multiplier * 0.99;
      else if(self._id_11CB.engine_pitch_multiplier < 1)
        self._id_11CB.engine_pitch_multiplier = self._id_11CB.engine_pitch_multiplier * 1.01;

      if(self._id_11CB.engine_vol_multiplier > var_4)
        self._id_11CB.engine_vol_multiplier = self._id_11CB.engine_vol_multiplier * 0.99;
      else if(self._id_11CB.engine_vol_multiplier < var_4)
        self._id_11CB.engine_vol_multiplier = self._id_11CB.engine_vol_multiplier * 1.01;
    } else if(var_6 >= 0.5 || self._id_11CB.pitching == 1) {
      if(self._id_11CB.p47_throttle_on == 0) {
        self._id_11CB.p47_throttle_on = 1;
        var_9 = _id_02EF::_id_42DD(var_2, "accelerate_start_aliases", 4);
        var_10 = _id_0380::_id_6844(var_9, var_1, self, 0, 1);
      }

      self._id_11CB.engine_pitch_multiplier = self._id_11CB.engine_pitch_multiplier * 1.01;

      if(self._id_11CB.engine_pitch_multiplier > 1.4)
        self._id_11CB.engine_pitch_multiplier = self._id_11CB.engine_pitch_multiplier * 0.998;

      if(self._id_11CB.engine_pitch_multiplier > 1.6)
        self._id_11CB.engine_pitch_multiplier = 1.6;

      self._id_11CB.engine_vol_multiplier = self._id_11CB.engine_vol_multiplier * 1.1;

      if(self._id_11CB.engine_vol_multiplier > 1)
        self._id_11CB.engine_vol_multiplier = 1;
    }

    _id_0380::_id_684D(var_0, self._id_11CB.engine_pitch_multiplier, 0.05);

    if(isDefined(self._id_11CB.duck_engine_for_turn) && self._id_11CB.duck_engine_for_turn == 1) {
      self._id_11CB.engine_vol_multiplier = self._id_11CB.engine_vol_multiplier * 0.98;

      if(self._id_11CB.engine_vol_multiplier < 0.1)
        self._id_11CB.engine_vol_multiplier = 0.1;
    }

    if(isDefined(self._id_11CB.duck_engine_for_turn) && self._id_11CB.duck_engine_for_turn == 0) {
      if(self._id_11CB.engine_vol_multiplier < var_4)
        self._id_11CB.engine_vol_multiplier = self._id_11CB.engine_vol_multiplier + 0.1;
    }

    if(self._id_11CB.engine_vol_multiplier > 1)
      self._id_11CB.engine_vol_multiplier = 1;

    _id_0380::_id_684E(var_0, self._id_11CB.engine_vol_multiplier, 0.05);
    waitframe();
  }
}

_id_1585(var_0, var_1) {
  var_2 = self _meth_8251();

  if(!isDefined(var_2)) {
    return;
  }
  self endon("stop_p47_sounds");
  self endon("death");
  var_3 = 0.05;
  var_4 = 0;
  var_5 = 0;
  var_6 = 5;
  var_7 = 4;
  var_8 = 25;
  var_9 = 20;
  var_10 = 19;
  var_11 = undefined;
  var_12 = 0;
  var_13 = 0;
  var_14 = 0;
  var_15 = 0;
  var_16 = undefined;
  var_17 = 0;
  var_18 = 0;
  var_19 = 40;
  var_20 = 40;
  var_21 = 0;
  var_22 = 0;
  var_23 = 0.1;
  var_24 = 1;
  var_25 = 0.1;

  while(isDefined(self) == 1) {
    var_26 = self.angles[2];
    var_27 = _func_0AE(var_26);
    var_28 = _func_0AE(self.angles[0]);
    var_29 = var_2 getnormalizedmovementx();
    var_30 = _id_02EF::_id_8086(var_27, var_6, var_19, 0.0, 1);
    var_31 = var_30;

    if(isDefined(var_16))
      var_17 = _func_0AE(var_26 - var_16);

    if(isDefined(var_11))
      var_14 = _func_0AE(var_28 - var_11);

    var_32 = _id_02EF::_id_8086(var_14, 0, 1.5, 0, 1);

    if(var_27 >= var_6) {
      if(var_17 > 8 && var_18 > 20) {
        var_4 = 1;
        var_18 = 0;

        if(isDefined(self._id_11CB._id_05C4))
          _id_0380::_id_6850(self._id_11CB._id_05C4, 1.0);

        self._id_11CB._id_05C4 = _id_0380::_id_6844("blg_p47_banking", var_2, self);
      } else if(var_4 == 0) {
        var_4 = 1;
        var_18 = 0;

        if(isDefined(self._id_11CB._id_05C4))
          _id_0380::_id_6850(self._id_11CB._id_05C4, 1.0);

        self._id_11CB._id_05C4 = _id_0380::_id_6844("blg_p47_banking", var_2, self);
      }

      if(var_25 < 1)
        var_25 = var_25 + 0.03;
    }

    var_18 = var_18 + 1;

    if(var_27 < var_7) {
      if(var_4 == 1)
        var_4 = 0;

      if(var_25 > 0.05) {
        var_25 = var_25 - 0.03;
        var_4 = 0;
      }
    }

    if(var_27 > var_8) {
      var_22 = var_22 + 1;

      if(var_22 > 55) {
        self._id_11CB.duck_engine_for_turn = 1;
        var_15 = 1;

        if(var_23 < 1)
          var_23 = var_23 + 0.02;

        if(var_24 < 1.6)
          var_24 = var_24 + 0.004;
      }
    } else {
      var_22 = 0;
      self._id_11CB.duck_engine_for_turn = 0;

      if(var_23 > 0)
        var_23 = var_23 - 0.1;

      if(var_24 > 1)
        var_24 = var_24 - 0.01;

      if(var_15 == 1) {
        var_15 = 0;
        _id_0380::_id_6844("blg_p47_banking_end", var_2, self);
      }
    }

    if(var_14 > 1) {
      var_12 = var_12 + 1;

      if(var_12 > 3 && self._id_11CB.pitching == 0) {
        self._id_11CB.pitching = 1;
        var_13 = 0;

        if(var_4 == 0)
          _id_0380::_id_6844("blg_p47_pitching_start", var_2, self);
      }
    } else {
      var_13 = var_13 + 1;

      if(var_13 > 3 && self._id_11CB.pitching == 1) {
        var_12 = 0;
        self._id_11CB.pitching = 0;
      }
    }

    if(var_27 > var_8 && var_29 <= -0.9)
      self._id_11CB.hard_bank = 1;
    else
      self._id_11CB.hard_bank = 0;

    if(isDefined(self._id_11CB._id_05C4)) {
      var_33 = _id_02EF::_id_8086(var_30, 0, 1, 0.05, 1);
      _id_0380::_id_684E(self._id_11CB._id_05C4, var_33, 0.05);
      var_34 = _id_02EF::_id_8086(self._id_11CB.engine_pitch_multiplier, 0.8, 1.6, 0.9, 1.3);
      _id_0380::_id_684D(self._id_11CB._id_05C4, var_34, 0.05);
    }

    if(var_23 > 1)
      var_23 = 1;

    if(var_23 < 0)
      var_23 = 0;

    _id_0380::_id_684E(var_0, var_23, 0.05);
    _id_0380::_id_684D(var_0, var_24, 0.05);

    if(var_25 > 1)
      var_25 = 1;

    _id_0380::_id_684E(var_1, var_25, 0.05);
    var_11 = var_28;
    var_16 = var_26;
    wait(var_3);
  }
}

_id_AA25(var_0) {
  waitframe();
  var_1 = 0.3;

  while(isDefined(self) == 1) {
    if(self._id_11CB.p47_throttle_on == 1 || self._id_11CB.hard_bank == 1)
      var_1 = var_1 + 0.02;
    else if(var_1 > 0.3)
      var_1 = var_1 - 0.02;

    if(var_1 > 1)
      var_1 = 1;

    _id_0380::_id_684E(var_0, var_1, 0.05);
    waitframe();
  }
}

_id_6DD0() {
  var_0 = self _meth_8251();

  if(_func_1EF(var_0)) {
    return;
  }
  self notify("handle_p47_firing_loop");
  self endon("handle_p47_firing_loop");
  level endon("dogfight_done");
  var_0 endon("death");
  self endon("death");
  var_1 = 0;
  var_2 = undefined;
  var_3 = 1;
}

raid_flyby_watcher(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("stop_p47_sounds");
  level endon("dogfight_done");
  var_1 = 15000;
  var_2 = 200;
  var_3 = 150;
  var_4 = 9500;
  var_5 = 160;
  var_6 = 100;
  var_7 = 5000;
  var_8 = 80;
  var_9 = 120;
  var_10 = 75;
  var_11 = 1;
  var_12 = 0.75;
  var_13 = 0.3;
  var_14 = 1;
  self.plane_data = [];
  var_15 = ["husky_dogfight_flyby_close_02", "husky_dogfight_flyby_close_04", "husky_dogfight_flyby_close_07", "husky_dogfight_flyby_close_13", "husky_dogfight_flyby_close_15", "husky_dogfight_flyby_close_16", "husky_dogfight_flyby_close_23", "husky_dogfight_flyby_close_25", "husky_dogfight_flyby_close_26", "husky_dogfight_flyby_close_27", "husky_dogfight_flyby_close_28", "husky_dogfight_flyby_close_29", "husky_dogfight_flyby_close_30", "husky_dogfight_flyby_close_31", "husky_dogfight_flyby_close_32"];
  var_16 = ["blg_dogfight_flyby_swt1", "blg_dogfight_flyby_swt2", "blg_dogfight_flyby_swt3", "blg_dogfight_flyby_swt4", "blg_dogfight_flyby_swt5", "blg_dogfight_flyby_swt6"];
  var_17 = ["blg_dogfight_flyby_mid_01", "blg_dogfight_flyby_mid_02", "blg_dogfight_flyby_mid_03", "blg_dogfight_flyby_mid_04", "blg_dogfight_flyby_mid_05", "blg_dogfight_flyby_mid_06", "blg_dogfight_flyby_mid_07", "blg_dogfight_flyby_mid_08", "blg_dogfight_flyby_mid_09", "blg_dogfight_flyby_mid_10", "blg_dogfight_flyby_mid_11", "blg_dogfight_flyby_mid_12", "blg_dogfight_flyby_mid_13", "blg_dogfight_flyby_mid_14"];
  var_18 = ["blg_dogfight_flyby_far_01", "blg_dogfight_flyby_far_02", "blg_dogfight_flyby_far_03", "blg_dogfight_flyby_far_04", "blg_dogfight_flyby_far_05", "blg_dogfight_flyby_far_06", "blg_dogfight_flyby_far_07", "blg_dogfight_flyby_far_08", "blg_dogfight_flyby_far_09", "blg_dogfight_flyby_far_10", "blg_dogfight_flyby_far_11", "blg_dogfight_flyby_far_12", "blg_dogfight_flyby_far_13", "blg_dogfight_flyby_far_14", "blg_dogfight_flyby_far_15", "blg_dogfight_flyby_far_16", "blg_dogfight_flyby_far_17"];

  for(;;) {
    foreach(var_20 in level.players) {
      var_21 = var_20.clientid;
      var_22 = var_20 _meth_85E2();

      if(var_20 == self || !isDefined(var_22)) {
        continue;
      }
      if(var_20.team == self.team)
        var_11 = var_12;
      else
        var_11 = 1;

      if(!isDefined(self.plane_data[var_21])) {
        self.plane_data[var_21] = spawnStruct();
        self.plane_data[var_21]._id_3018 = 20001;
        self.plane_data[var_21].distantloopstarted = 0;
        self.plane_data[var_21].closeloopstarted = 0;
        self.plane_data[var_21].closeoneshotstarted = 0;
        self.plane_data[var_21].midoneshotstarted = 0;
        self.plane_data[var_21].faroneshotstarted = 0;
        self.plane_data[var_21].closetimer = 200;
        self.plane_data[var_21].midtimer = 200;
        self.plane_data[var_21].fartimer = 200;
      }

      self.plane_data[var_21].lastdistance = self.plane_data[var_21]._id_3018;
      self.plane_data[var_21]._id_3018 = distance(self.origin, var_20.origin);
      self.plane_data[var_21].approachspeed = self.plane_data[var_21].lastdistance - self.plane_data[var_21]._id_3018;

      if(self.plane_data[var_21]._id_3018 < var_7) {
        if(self.plane_data[var_21].approachspeed > var_8 && self.plane_data[var_21].closeoneshotstarted == 0 && self.plane_data[var_21].closetimer >= var_10) {
          self.plane_data[var_21].closeoneshotstarted = 1;
          self.plane_data[var_21].closetimer = 0;
          var_14 = common_scripts\utility::within_fov(self.origin, self.angles, var_22.origin, _func_0A7(45));

          if(isDefined(var_14) && var_14 == 0)
            var_11 = var_11 * var_13;

          var_23 = _id_02EF::_id_42DD(var_15, "dogfight_close_flybys", 7);
          self.plane_data[var_21].close_flybysound = _id_0380::_id_288E(var_23, self, var_22, 0, var_11, 3, "stop_damage_engine_loop");
        } else {
          self.plane_data[var_21].closeoneshotstarted = 0;
          self.plane_data[var_21].closetimer = self.plane_data[var_21].closetimer + 1;
          continue;
        }
      } else if(self.plane_data[var_21].closetimer < var_10) {
        self.plane_data[var_21].closeoneshotstarted = 0;
        self.plane_data[var_21].closetimer = self.plane_data[var_21].closetimer + 1;
      }

      if(self.plane_data[var_21]._id_3018 < var_4 && self.plane_data[var_21].closeoneshotstarted == 0) {
        if(self.plane_data[var_21].approachspeed > var_5 && self.plane_data[var_21].midoneshotstarted == 0 && self.plane_data[var_21].midtimer >= var_6) {
          self.plane_data[var_21].midoneshotstarted = 1;
          self.plane_data[var_21].midtimer = 0;
          var_24 = _id_02EF::_id_42DD(var_17, "dogfight_mid_flybys", 7);
          self.plane_data[var_21].mid_flybysound = _id_0380::_id_288E(var_24, self, var_22, 0, 1, 3, "stop_damage_engine_loop");
        } else {
          self.plane_data[var_21].midoneshotstarted = 0;
          self.plane_data[var_21].midtimer = self.plane_data[var_21].midtimer + 1;
          continue;
        }
      } else if(self.plane_data[var_21].midtimer < var_6) {
        self.plane_data[var_21].midoneshotstarted = 0;
        self.plane_data[var_21].midtimer = self.plane_data[var_21].midtimer + 1;
      }

      if(self.plane_data[var_21]._id_3018 < var_1 && self.plane_data[var_21].closeoneshotstarted == 0 && self.plane_data[var_21].midoneshotstarted == 0) {
        if(self.plane_data[var_21].approachspeed > 120 && self.plane_data[var_21].faroneshotstarted == 0 && self.plane_data[var_21].fartimer >= var_3) {
          self.plane_data[var_21].faroneshotstarted = 1;
          self.plane_data[var_21].fartimer = 0;
          var_25 = _id_02EF::_id_42DD(var_18, "dogfight_far_flybys", 9);
          self.plane_data[var_21].far_flybysound = _id_0380::_id_288E(var_25, undefined, var_22, 0, 1, 3, "stop_damage_engine_loop");
        } else {
          self.plane_data[var_21].faroneshotstarted = 0;
          self.plane_data[var_21].fartimer = self.plane_data[var_21].fartimer + 1;
          continue;
        }

        continue;
      }

      if(self.plane_data[var_21].fartimer < var_3) {
        self.plane_data[var_21].faroneshotstarted = 0;
        self.plane_data[var_21].fartimer = self.plane_data[var_21].fartimer + 1;
      }
    }

    waitframe();
  }
}

dogfight_close_loop(var_0, var_1) {
  var_2 = undefined;

  switch (var_1) {
    case "axis":
      var_2 = _id_0380::_id_6845("blg_dogfight_axis_close_lp", undefined, var_0, self, 0.5);
      break;
    case "allies":
      var_2 = _id_0380::_id_6845("blg_dogfight_ally_close_lp", undefined, var_0, self, 0.5);
      break;
    default:
  }

  close_loop_death_watcher(var_2);
}

close_loop_death_watcher(var_0) {
  common_scripts\utility::_id_A70A("death", "stop_p47_sounds", "stop_damage_engine_loop");
  _id_0380::_id_6850(var_0, 0.5);
  var_0 = undefined;
}

fighter_start_death(var_0) {
  self notify("stop_damage_engine_loop");
  var_0 _id_02F2::_id_8001("husky_player_death_pop");
  var_0 _id_02F2::_id_8001("husky_player_death_spin", "final_explosion");
}

fighter_final_explosion(var_0) {
  self notify("stop_damage_alarm_loop");
  self notify("stop_p47_sounds");
  _id_02F2::_id_7FFA("husky_plane_destruct_exp_close", var_0);
}

fighter_damage_state_change(var_0) {
  var_1 = self _meth_8251();

  if(var_0 == 0) {
    common_scripts\utility::_id_3C7B("damage_state_1");
    self notify("stop_damage_engine_loop");
  }

  if(var_0 == 1) {
    if(!common_scripts\utility::_id_3C77("damage_state_1")) {
      common_scripts\utility::flag_set("damage_state_1");
      _id_02F2::_id_8001("husky_player_damage_oneshot");
      self._id_11CB.engine_damage_loop = _id_02F2::_id_8004("blg_p47_engine_damage_plr_lp", "stop_damage_engine_loop", 0, 0);
    }

    if(common_scripts\utility::_id_3C77("damage_state_2")) {
      common_scripts\utility::_id_3C7B("damage_state_2");
      self notify("stop_damage_alarm_loop");
    }
  }

  if(var_0 == 2 && !common_scripts\utility::_id_3C77("damage_state_2")) {
    common_scripts\utility::flag_set("damage_state_2");
    _id_02F2::_id_8001("husky_player_damage_oneshot");
  }
}

getnormalizedmovementx() {
  if(_func_1EF(self)) {
    var_0 = self _meth_85E2();

    if(!isDefined(var_0))
      return 0;

    var_1 = var_0 _meth_8283();

    if(!isDefined(self.mph_upper) || var_1 > self.mph_upper)
      self.mph_upper = var_1;

    if(!isDefined(self.mph_lower) || var_1 < self.mph_lower)
      self.mph_lower = var_1;

    var_2 = self.mph_upper - self.mph_lower;

    if(var_2 == 0) {
      return 0;
      return;
    }

    var_3 = self.mph_lower + var_2 * 0.5;
    var_4 = (var_1 - var_3) / (var_2 * 0.5);
    return var_4;
    return;
  } else
    return self _meth_82F9()[0];
}