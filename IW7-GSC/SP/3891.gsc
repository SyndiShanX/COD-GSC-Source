/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3891.gsc
**************************************/

_id_258C() {
  if(!isDefined(level._id_2571))
    level._id_2571 = spawnStruct();

  if(!isDefined(level._id_2571._id_5A61))
    level._id_2571._id_5A61 = [];

  _id_25B4();
  _id_260A();
}

_id_25B4() {
  if(!isDefined(level._id_2571._id_8492))
    level._id_2571._id_8492 = spawn("script_origin", (0, 0, 0));

  if(!isDefined(level._id_2571._id_8491))
    level._id_2571._id_8491 = spawn("script_origin", (0, 0, 0));

  if(!isDefined(level._id_2571._id_8490))
    level._id_2571._id_8490 = spawn("script_origin", (0, 0, 0));
}

_id_260A() {
  if(!isDefined(level._id_2571._id_13ED7)) {
    level._id_2571._id_13ED7 = spawn("script_origin", (0, 0, 0));
    level._id_2571._id_13ED7 _meth_8278(0.0, 0.0);
  }

  if(!isDefined(level._id_2571._id_13ED9)) {
    level._id_2571._id_13ED9 = spawn("script_origin", (0, 0, 0));
    level._id_2571._id_13ED9 _meth_8278(0.2, 0.0);
  }
}

_id_260B() {
  _id_258C();
  level._id_2571._id_13EDB = 0.2;
  level._id_2571._id_13EC7 = 0;
  level._id_2571._id_13ED6 = 0;
  thread _id_DE98();
  thread _id_D35A();
}

_id_DE98() {
  anim.notetracks["sound_boost_start"] = ::_id_C190;
  anim.notetracks["sound_boost_end"] = ::_id_C18F;
}

_id_25B5() {
  _id_258C();
}

_id_260C() {
  level.player endon("playerZeroGravityEnabled");
  _id_D048();
  _id_D35B();
}

_id_25B6() {
  level.player notify("stop_grapple_audio");
  _id_D0A9();
}

_id_D0A9() {
  if(isDefined(level._id_2571._id_8492)) {
    level._id_2571._id_8492 stopsounds();
    level._id_2571._id_8492 _meth_8278(1.0, 0.0);
    level._id_2571._id_8492 _meth_8277(1.0, 0.0);
    level._id_2571._id_8492 delete();
    level._id_2571._id_8492 = undefined;
  }

  if(isDefined(level._id_2571._id_8490)) {
    level._id_2571._id_8490 stoploopsound();
    level._id_2571._id_8490 _meth_8278(1.0, 0.0);
    level._id_2571._id_8490 _meth_8277(1.0, 0.0);
    level._id_2571._id_8490 delete();
    level._id_2571._id_8490 = undefined;
  }

  if(isDefined(level._id_2571._id_8491)) {
    level._id_2571._id_8491 stopsounds();
    level._id_2571._id_8491 _meth_8278(1.0, 0.0);
    level._id_2571._id_8491 _meth_8277(1.0, 0.0);
    level._id_2571._id_8491 delete();
    level._id_2571._id_8491 = undefined;
  }
}

_id_D35B() {
  if(isDefined(level._id_2571._id_13ED7)) {
    level._id_2571._id_13ED7 stoploopsound();
    level._id_2571._id_13ED7 _meth_8278(1.0, 0.0);
    level._id_2571._id_13ED7 _meth_8277(1.0, 0.0);
    level._id_2571._id_13ED7 delete();
    level._id_2571._id_13ED7 = undefined;
  }

  if(isDefined(level._id_2571._id_13ED9)) {
    level._id_2571._id_13ED9 stopsounds();
    level._id_2571._id_13ED9 _meth_8278(1.0, 0.0);
    level._id_2571._id_13ED9 _meth_8277(1.0, 0.0);
    level._id_2571._id_13ED9 delete();
    level._id_2571._id_13ED9 = undefined;
  }
}

_id_D0AF() {
  level.player endon("stop_grapple_audio");
  level._id_2571._id_13ED6 = 1;
  thread _id_D049();
  level._id_2571._id_8490 _meth_8278(0.0, 0.0);
  level.player playSound("zg_grapple_start_01");
  wait 0.3;
  level.player playSound("zg_grapple_attach_01");
}

_id_D0AA() {
  level.player endon("stop_grapple_audio");
  level._id_2571._id_8492 _meth_8278(1.0, 0.0);
  level._id_2571._id_8492 playSound("sa_grapple_reel_start_01");
  level._id_2571._id_8490 _meth_8277(1.0, 0.0);
  level._id_2571._id_8491 playSound("zg_grapple_retract_01", "interrupt_grapple_retract_sound", 1);
  wait 0.5;

  if(isDefined(level._id_2571._id_8490) && isDefined(level._id_2571._id_8492)) {
    level._id_2571._id_8490 playLoopSound("sa_grapple_reel_lp_01");
    level._id_2571._id_8490 _meth_8277(1.7, 5.0);
    level._id_2571._id_8492 _meth_8278(0.0, 0.1);
    level._id_2571._id_8490 _meth_8278(1.0, 0.1);
  }
}

_id_D0AB() {
  thread _id_D0B0();
  level.player playSound("sa_grapple_stop_melee_01");
}

_id_D0AC() {
  self playSound("sa_ss1_grapplepain");
}

_id_D0AD() {
  thread _id_D0B0();
}

_id_D0AE() {
  thread _id_D0B0();
  level.player playSound("zg_grapple_stop_land_magboots");
}

_id_D0B0() {
  level.player notify("stop_grapple_audio");
  level._id_2571._id_8490 _meth_8278(0.0, 0.1);
  level._id_2571._id_8492 _meth_8278(0.0, 0.1);
  level._id_2571._id_13ED6 = 0;
  level._id_2571._id_8491 stopsounds();
  wait 0.2;

  if(isDefined(level._id_2571._id_8490))
    level._id_2571._id_8490 stoploopsound();

  if(isDefined(level._id_2571._id_8492))
    level._id_2571._id_8492 stopsounds();
}

_id_D35A() {
  level.player endon("end_zerog_movement");
  level._id_2571._id_13EBD = 0;

  if(!isDefined(level._id_2571._id_13ED7))
    level._id_2571._id_13ED7 = spawn("script_origin", (0, 0, 0));

  if(!isDefined(level._id_2571._id_13ED9))
    level._id_2571._id_13ED9 = spawn("script_origin", (0, 0, 0));

  level._id_2571._id_13ED7 _meth_8278(0.0, 0.0);
  level._id_2571._id_13ED7 _meth_8277(1.0, 0.0);
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  scripts\engine\utility::waitframe();
  level._id_2571._id_13ED7 playLoopSound("zero_g_mvmt_loop");

  for(;;) {
    var_3 = lengthsquared(level.player getnormalizedmovement());

    if(!level._id_2571._id_13ED6) {
      if((level.player _meth_8439() || level.player issprinting()) && var_3 > 0.2 && !level.player isonground()) {
        level._id_2571._id_13EDB = 0.3;

        if(var_0) {
          level._id_2571._id_13ED7 _meth_8278(1.0, 0.2);
          var_0 = 0;
          var_1 = 0;
        } else if(!var_1) {
          wait 0.2;
          level._id_2571._id_13ED7 _meth_8278(0.3, 4.0);
          var_1 = 1;
        }
      } else if(!level.player isonground()) {
        level._id_2571._id_13EDB = 0.1;
        var_0 = 1;
        var_1 = 0;
      } else {
        var_0 = 1;
        var_1 = 0;
      }

      if(!level._id_2571._id_13EBD) {
        if(!level.player isonground() && !scripts\engine\utility::player_is_in_jackal() && (var_3 > 0.2 || level.player _meth_81CE() || level.player _meth_843B()))
          thread _id_D2DA();
        else if((level.player buttonPressed("DPAD_LEFT") || level.player buttonPressed("DPAD_RIGHT") || level.player buttonPressed("DPAD_UP")) && !var_2) {
          thread _id_D2DA();
          var_2 = 1;
        } else if(!level.player buttonPressed("DPAD_LEFT") && !level.player buttonPressed("DPAD_RIGHT") && !level.player buttonPressed("DPAD_UP") && var_2)
          var_2 = 0;
      } else if(level._id_2571._id_13EBD && (var_3 == 0 || level.player isonground() || scripts\engine\utility::player_is_in_jackal()) && level.player _meth_81CE() == 0 && level.player _meth_843B() == 0)
        thread _id_D049();
    }

    scripts\engine\utility::waitframe();
  }
}

_id_D048() {
  level.player notify("end_zerog_movement");

  if(isDefined(level._id_2571._id_13ED7)) {
    level._id_2571._id_13ED7 _meth_8278(0.0, 1.0);
    level._id_2571._id_13ED7 _meth_8277(1.0, 1.0);
    level._id_2571._id_13EDB = 0;
    wait 1;

    if(isDefined(level._id_2571._id_13ED7))
      level._id_2571._id_13ED7 stoploopsound();
  }

  level._id_2571._id_13EBD = 0;
}

_id_D2DA() {
  level.player endon("end_zerog_movement");
  level.player endon("thrusters_stop");

  if(!isDefined(level._id_2571._id_13ED7)) {
    return;
  }
  level._id_2571._id_13EBD = 1;
  level._id_2571._id_13ED9 _meth_8278(0.2, 0.0);

  if(isDefined(level._id_2571._id_13ED9))
    level._id_2571._id_13ED9 playSound("zero_g_mvmt_start");

  wait 0.3;
  level._id_2571._id_13ED7 _meth_8277(1.0, 0.0);
  level._id_2571._id_13ED7 _meth_8278(level._id_2571._id_13EDB, 2);
  level._id_2571._id_13ED7 _meth_8277(1.5, 3.0);

  if(isDefined(level._id_2571._id_13ED9)) {
    if(level.player _meth_8439() || level.player issprinting())
      level._id_2571._id_13ED9 _meth_8278(0.8, 0.2);
    else
      level._id_2571._id_13ED9 _meth_8278(0.2, 0.2);
  }

  wait 0.1;

  if(isDefined(level._id_2571._id_13ED7))
    level._id_2571._id_13ED7 _meth_8278(level._id_2571._id_13EDB, 3);
}

_id_D049() {
  level.player endon("end_zerog_movement");
  level.player notify("thrusters_stop");

  if(scripts\engine\utility::is_true(level._id_2571._id_13EC7)) {
    level.player playSound("zero_g_mvmt_end");
    level._id_2571._id_13EC7 = 0;
  }

  level._id_2571._id_13EBD = 0;

  if(isDefined(level._id_2571)) {
    if(isDefined(level._id_2571._id_13ED7)) {
      level._id_2571._id_13ED7 _meth_8278(0.0, 0.5);
      level._id_2571._id_13ED7 _meth_8277(1.0, 2.0);
      level._id_2571._id_13EDB = 0;
    }
  }
}

_id_C190(var_0, var_1) {
  self playSound("zero_g_npc_mvmt_boost_start");

  if(!isDefined(self._id_13E79)) {
    self._id_13E79 = spawn("script_origin", self.origin);
    self._id_13E79 linkTo(self);
    self._id_13E79._id_AD32 = self;
  }

  if(isDefined(self._id_13E79) && !isDefined(self._id_13E79._id_9E87)) {
    self._id_13E79 playLoopSound("zero_g_npc_mvmt_loop");
    self._id_13E79._id_9E87 = 1;
    self._id_13E79 thread _id_0F00::_id_FB6F(256, 1.25992, 1.0666);
  }

  thread _id_C191();
}

_id_C191() {
  self notify("zero_g_waiting_on_stop");
  self endon("zero_g_waiting_on_stop");
  scripts\engine\utility::waittill_any("zero_g_movement_end", "death");
  var_0 = self.origin;

  if(isDefined(self)) {
    if(isDefined(self._id_13E79)) {
      self._id_13E79 notify("stop_doppler");

      if(isDefined(self._id_13E79._id_9E87)) {
        self._id_13E79 stoploopsound();
        self._id_13E79._id_9E87 = undefined;
      }

      self._id_13E79 _meth_8278(1.0, 0.0);
      self._id_13E79 _meth_8277(1.0, 0.0);
      self._id_13E79 delete();
      self._id_13E79 = undefined;
    }

    if(isDefined(var_0))
      thread scripts\engine\utility::play_sound_in_space("zero_g_npc_mvmt_boost_end", var_0);
  }
}

_id_C18F(var_0, var_1) {
  self notify("zero_g_movement_end");
}