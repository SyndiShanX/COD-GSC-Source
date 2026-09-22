/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1371.gsc
**************************************/

init() {
  if(!isDefined(level.scaretable)) {
    level.scaretable = "mp/zombieJumpScareTable.csv";
  }

  var_0 = getEntArray("zombie_fall_ambush", "targetname");
  setdvarifuninitialized("drop_js_lead_time", -1);
  setdvarifuninitialized("drop_js_cam_jump", -1);
  setdvarifuninitialized("drop_js_cam_jump_need_look", -1);
  setdvarifuninitialized("drop_js_debug", -1);
  setdvarifuninitialized("drop_js_height", -1);
  setdvarifuninitialized("drop_js_affect_all_players", -1);
  setdvarifuninitialized("drop_js_fall_quicker", -1);
  setdvarifuninitialized("drop_js_dist", -1);

  foreach(var_2 in var_0) {
    var_2 thread _id_347E();
  }

  level._id_2F29 = 0;
  var_4 = getEntArray("valve", "script_noteworthy");
  _id_AA30(var_4);
}

_id_AA36(var_0) {
  self._id_75F0 = var_0;

  foreach(var_2 in self._id_75EF) {
    _func_32B(var_2, var_0);
  }
}

_id_AA35(var_0, var_1, var_2) {
  _id_AA36(1);
  var_3 = 10;
  var_4 = 30;
  var_5 = 0.5;
  var_6 = 15;
  var_7 = 75;
  var_8 = 1;
  var_9 = self._id_5978;

  if(isDefined(self._id_AA3B) || isDefined(self._id_AA39)) {
    if(isDefined(self._id_AA3B)) {
      var_8 = _isglassdestroyed(self._id_AA3B);
      var_9 = _getglassorigin(self._id_AA3B);
    } else if(isDefined(self._id_AA39))
      var_9 = self._id_AA39.origin;

    if(isDefined(self._id_AA39)) {
      self._id_AA39 delete();
      _physicsexplosionsphere(var_9, var_4, var_3, var_5);

      if(isDefined(self._id_AA3A)) {
        foreach(var_11 in self._id_AA3A) {
          var_11 delete();
        }
      }
    }

    _glassradiusdamage(var_9, var_4, var_7, var_6);
  }

  var_1 _id_0378::_id_8D74("window_jumpscare", var_0, self._id_5978, var_8);

  if(var_2) {
    var_1 thread _id_598A();
    var_1 setplayerangles(vectortoangles(self._id_5978 - var_1 getEye()));
  }
}

_id_AA33(var_0, var_1, var_2, var_3) {
  var_4 = self;

  switch (var_0) {
    case "breach":
      var_4._id_0186 _id_AA35(var_4, var_4._id_5979, var_4._id_597A);
      break;
  }
}

_id_AA34(var_0) {
  self endon("death");
  var_1 = 0.2;
  wait(var_0 - var_1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "ZomWindowScare");
  self scragentsetscripted(0);
  self scragentsetphysicsmode("gravity");
}

_id_AA2E(var_0, var_1) {
  _id_5976(var_0);
  var_2 = _id_054D::_id_90BA("zombie_generic", self, "window jumpscare", 0, 1, 1);
  var_3 = self.setflaggedanimknoball;
  var_4 = var_2 maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_3);
  var_2._id_5979 = var_0;
  var_2._id_597A = var_1;
  var_2 thread maps\mp\agents\humanoid\_humanoid_util::getcurrentoffhand(var_2.origin, var_2.angles, var_4, undefined, 1, ::_id_AA33, 1);
  var_5 = common_scripts\utility::_id_46B7("window_shatter", "targetname");
  var_6 = undefined;

  foreach(var_8 in var_5) {
    if(distance(var_2.origin, var_8.origin) <= 100) {
      if(isDefined(self._id_AA3B) && !_isglassdestroyed(self._id_AA3B)) {
        playFX(level._effect["zmb_window_shatter_01"], var_8.origin, anglesToForward(var_8.angles));
        var_6 = var_8.origin;
      }

      break;
    }
  }
}

_id_8CAA(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = anglesToForward(self.angles);
  var_2 = _vectorcross(var_1, var_0);

  if(var_2[2] > 0) {
    var_3 = 1;
  } else {
    var_3 = -1;
  }

  for(;;) {
    var_1 = _rotatevector(var_1, (0, 0, 5 * var_3));
    self setplayerangles(vectortoangles(var_1));
    waitframe();
  }
}

_id_5987() {
  if(isDefined(self._id_0117)) {
    self._id_0117._id_5986 = undefined;
  }

  self._id_0CA5 = 1;

  if(isDefined(self.targetname)) {
    if(self.targetname == "sewage_jumpscare") {
      self delete();
    }
  }

  if(isDefined(self._id_AA3B) || isDefined(self._id_AA39)) {
    wait 30;

    if(isDefined(self._id_AA3B)) {
      _deleteglass(self._id_AA3B);
      self._id_AA3B = undefined;
    }

    if(isDefined(self._id_AA39)) {
      self._id_AA39 delete();
      self._id_AA39 = undefined;
    }
  }
}

_id_AA2F(var_0) {
  var_1 = self._id_5978 - var_0 getEye();
  var_2 = vectorNormalize((var_1[0], var_1[1], 0));
  var_3 = anglesToForward(var_0.angles);
  var_4 = vectorNormalize((var_3[0], var_3[1], 0));
  var_5 = vectordot(var_2, var_4);
  var_5 = clamp(var_5, -1, 1);
  var_6 = _acos(var_5);
  return var_6;
}

_id_AA31(var_0) {
  var_1 = var_0 < 40;
  return var_1;
}

_id_AA32(var_0) {
  var_1 = _id_AA2F(var_0);
  var_2 = _id_AA31(var_1);
  return var_2;
}

_id_AA30(var_0) {
  var_1 = common_scripts\utility::_id_46B7("jumpscare_spawner", "targetname");

  foreach(var_3 in var_1) {
    var_4 = common_scripts\utility::_id_4461(var_3.origin, var_0);

    if(isDefined(var_4)) {
      if(distance(var_4.origin, var_3.origin) > 100) {
        var_4 = undefined;
      } else {
        var_0 = common_scripts\utility::_id_0F93(var_0, var_3);
        var_4._id_5986 = var_3;
        var_3._id_0117 = var_4;
      }
    }

    var_5 = _getnodesinradius(var_3.origin, 90, 0, 90);
    var_3._id_75EF = [];

    foreach(var_7 in var_5) {
      if(_id_0547::_id_55C2(var_7)) {
        var_3._id_75EF[var_3._id_75EF.size] = var_7;
      }
    }

    var_3 _id_AA36(0);
    var_9 = _getEnt(var_3.target, "targetname");

    if(isDefined(var_9) && isDefined(var_9._id_0165) && var_9._id_0165 == "js_trigger") {
      var_3._id_597B = var_9;
    }

    var_10 = common_scripts\utility::_id_46B5(var_3.target, "targetname");

    if(isDefined(var_10)) {
      var_3._id_5978 = var_10.origin;
    } else {
      var_3._id_5978 = var_3.origin;
    }

    var_11 = _getglassarray("window_shatter");

    if(isDefined(var_11)) {
      foreach(var_13 in var_11) {
        var_14 = _getglassorigin(var_13);

        if(distancesquared(var_3.origin, var_14) <= 10000) {
          var_3._id_AA3B = var_13;
          break;
        }
      }
    }

    var_16 = getEntArray("window_shatter", "targetname");

    if(isDefined(var_16)) {
      foreach(var_18 in var_16) {
        if(var_18.classname == "script_model" && distancesquared(var_3.origin, var_18.origin) <= 10000) {
          var_3._id_AA39 = var_18;

          if(isDefined(var_18.target)) {
            var_3._id_AA3A = getEntArray(var_18.target, "targetname");
          }

          break;
        }
      }
    }

    if(isDefined(var_3._id_0117)) {
      var_3 thread _id_AA37();
      continue;
    }

    if(isDefined(var_3._id_597B)) {
      var_3 thread _id_681B();
    }
  }
}

_id_52E5(var_0, var_1) {
  if(!isDefined(var_0._id_5988)) {
    var_0._id_5988 = [];
  }

  if(!isDefined(var_0._id_5988[var_1])) {
    var_0._id_5988[var_1] = 0;
  }
}

_id_42A1(var_0, var_1) {
  _id_52E5(var_0, var_1);
  return var_0._id_5988[var_1];
}

is_jumpscare_playerdata_disabled() {
  var_0 = common_scripts\utility::_id_562E(level.disable_jumpscare_playerdata);
  return var_0;
}

_id_42A0(var_0, var_1) {
  if(is_jumpscare_playerdata_disabled()) {
    return 0;
  }

  var_2 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "jumpScareTimesSeen", var_1);
  return var_2;
}

_id_50F5(var_0, var_1) {
  _id_52E5(var_0, var_1);
  var_0._id_5988[var_1]++;
}

_id_50F4(var_0, var_1) {
  if(is_jumpscare_playerdata_disabled()) {
    return;
  }
  var_2 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "jumpScareTimesSeen", var_1);
  var_2++;
  var_0._id_598C++;

  if(var_2 <= 255) {
    var_0 setplayerdata(common_scripts\utility::_id_46A8(), "jumpScareTimesSeen", var_1, var_2);
  }
}

_id_178C(var_0, var_1, var_2, var_3) {
  return common_scripts\utility::_id_5D93(var_3, 0, var_1, var_0, var_2);
}

_id_5977(var_0) {
  var_1 = _id_41E1();
  var_2 = level.scaretable;
  var_3 = _float(tablelookup(var_2, 0, var_1, 1));
  var_4 = _float(tablelookup(var_2, 0, var_1, 2));
  var_5 = _float(tablelookup(var_2, 0, var_1, 3));
  var_6 = _float(tablelookup(var_2, 0, var_1, 4));
  var_7 = _float(tablelookup(var_2, 0, var_1, 5));
  var_8 = _id_42A0(var_0, var_1);
  var_9 = _id_42A1(var_0, var_1);
  var_10 = _id_178C(var_3, var_6, var_7, var_8);
  var_11 = _id_178C(var_10, var_4, var_5, var_9);
  var_12 = _randomfloat(1);

  if(var_12 < var_3) {
    var_13 = 1;
  } else {
    var_13 = 0;
  }

  var_14 = 0;

  if(isDefined(level.zmb_jumpscares_optional_cooldown_override)) {
    var_15 = level.zmb_jumpscares_optional_cooldown_override;
  } else {
    var_15 = 10;
  }

  if(isDefined(level._id_5B2D) && gettime() - level._id_5B2D < 1000 * var_15) {
    var_14 = 1;
    var_13 = 0;
  }

  if(isDefined(self._id_8FA9) && self._id_8FA9 == "force_scare_always") {
    var_13 = 1;
  }

  if(common_scripts\utility::_id_562E(var_0._id_569F)) {
    var_13 = 0;
  }

  var_17 = _id_0547::_id_AC4B(var_0.origin, "jumpscare_roll");
  var_17 _id_0547::_id_AC47(var_0);
  var_17 _id_0547::_id_AC48("type", var_1);
  var_17 _id_0547::_id_AC43("chance", var_11);
  var_17 _id_0547::_id_AC42("execute", var_13);
  var_17 _id_0547::_id_AC4D();
  return var_13;
}

set_optional_new_cooldown() {
  if(!isDefined(level.zmb_jumpscares_optional_cooldown_override_range)) {
    return;
  }
  level.zmb_jumpscares_optional_cooldown_override = 60 * _randomintrange(level.zmb_jumpscares_optional_cooldown_override_range[0], level.zmb_jumpscares_optional_cooldown_override_range[1]);
}

_id_5976(var_0) {
  level._id_5B2D = gettime();
  set_optional_new_cooldown();
  var_1 = _id_41E1();
  _id_50F5(var_0, var_1);
  _id_50F4(var_0, var_1);
  var_2 = _id_0547::_id_AC4B(var_0.origin, "jumpscare");
  var_2 _id_0547::_id_AC47(var_0);
  var_2 _id_0547::_id_AC48("type", var_1);
  var_2 _id_0547::_id_AC4D();
}

_id_681B() {
  level endon("game_ended");
  loadcostumemodels("window_no_valve");
  var_0 = 0;

  for(;;) {
    self._id_597B waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    var_2 = _id_5977(var_1);

    if(!var_2) {
      wait 1;
      continue;
    }

    if(_id_AA32(var_1)) {
      thread _id_AA2E(var_1, 0);

      if(var_0 == 0) {
        _id_5987();
      } else {
        wait(var_0);
      }
    }

    if(common_scripts\utility::_id_562E(self._id_0CA5)) {
      break;
    }

    waitframe();
  }
}

_id_AA37() {
  self endon("valve_complete");
  loadcostumemodels("window_valve");
  var_0 = 0;

  for(;;) {
    self waittill("valve_start", var_1);
    self._id_6DB0 = "started";
    var_2 = _id_5977(var_1);
    wait 1.5;

    for(;;) {
      if(self._id_6DB0 == "stopped") {
        break;
      }

      if(var_2 && _id_AA32(var_1)) {
        thread _id_AA2E(var_1, 1);

        if(var_0 == 0) {
          _id_5987();
        } else {
          wait(var_0);
        }
      }

      if(common_scripts\utility::_id_562E(self._id_0CA5)) {
        break;
      }

      waitframe();
    }

    if(common_scripts\utility::_id_562E(self._id_0CA5)) {
      break;
    }
  }
}

_id_5989() {
  self._id_6DB0 = "stopped";
}

_id_598A() {
  self playRumbleOnEntity("grenade_rumble");
  _earthquake(0.2, 1.5, self.origin, 850, self);
}

_id_8A74() {
  self endon("end_jumpscare");
  loadcostumemodels("sewer_grate");
  thread _id_8A71();
  self._id_0CA5 = 0;
  var_0 = 0;
  var_1 = common_scripts\utility::_id_44BE(self.target, "targetname");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3._id_0165)) {
      var_3._id_0165 = "spawner";
    }

    switch (var_3._id_0165) {
      case "spawner":
        self._id_0186 = var_3;
        break;
      case "lookat_pos":
        self._id_5EC8 = var_3;
        break;
    }
  }

  if(isDefined(self._id_5EC8)) {
    self._id_5978 = self._id_5EC8.origin;
  } else {
    self._id_5978 = self.origin;
  }

  if(!isDefined(self._id_0186)) {
    return;
  }
  for(;;) {
    self waittill("trigger", var_5);

    if(!isPlayer(var_5)) {
      continue;
    }
    if(!_id_5977(var_5)) {
      wait 1;
      continue;
    }

    var_6 = var_5 getEye();
    var_7 = var_5 _meth_8566();
    var_8 = anglesToForward(var_7);
    var_9 = vectorNormalize(self._id_5978 - var_6);

    if(vectordot(var_8, var_9) > 0.766) {
      thread _id_8A72(var_5, self.origin, self.angles);

      if(var_0 == 0) {
        self notify("end_jumpscare");
        break;
      } else
        wait(var_0);

      continue;
    }

    waitframe();
  }
}

_id_8A71() {
  self waittill("end_jumpscare");
  _id_5987();
}

_id_8A72(var_0, var_1, var_2) {
  _id_5976(var_0);
  var_3 = 100;
  var_4 = _id_054D::_id_90BA("zombie_generic", undefined, "sewage jumpscare", 0, 1, 1);
  var_5 = "s2_grate_jumpscare";
  var_6 = var_4 getanimentry(var_5, 0);
  var_7 = _getanimlength(var_6);
  var_8 = _getstartorigin(var_1, var_2, var_6);
  var_9 = _getstartangles(var_1, var_2, var_6);
  var_4 setOrigin(var_8);
  var_4.maxhealth = int(var_4.maxhealth * var_3);
  var_4.health = var_4.maxhealth;
  var_4 childthread _id_0547::_id_AB18(var_7, 1);
  var_4 thread maps\mp\agents\humanoid\_humanoid_util::getcurrentoffhand(var_8, var_9, var_5, undefined, 0, undefined, 1);
  var_10 = var_1 + (0, 0, -30);
  var_0 _id_0378::_id_8D74("sewage_jumpscare", var_4, var_10);
  var_4 maps\mp\agents\_scripted_agent_anim_util::_id_A79F("scripted_anim", "cam_shake");
  var_11 = var_10 - var_0 getEye();
  var_0 setplayerangles(vectortoangles(var_11));
  var_0 thread _id_598A();
}

_id_8A73() {
  self endon("end_jumpscare");
  self hide();

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    var_1 = getEntArray(self.targetname, "script_noteworthy");

    foreach(var_3 in var_1) {
      var_3 notify("end_jumpscare");
    }

    break;
  }
}

_id_9053(var_0, var_1) {
  loadcostumemodels(var_0);

  foreach(var_3 in common_scripts\utility::_id_44BE(self.target, "targetname")) {
    if(!isDefined(var_3._id_0165)) {
      var_3._id_0165 = "spawner";
    }

    switch (var_3._id_0165) {
      case "spawner":
        self._id_0873 = var_3.setlookatent;
        self._id_8FA9 = var_3._id_81C7;
        self._id_0186 = var_3;
        self._id_606E = var_3.stopuseturret;
        break;
      case "breach_destructible":
        self._id_1B83 = var_3;
        break;
      case "ideal_player_pos":
        self._id_502E = var_3;
        break;
      case "ideal_zombie_pos":
        self._id_502F = var_3;
        break;
      case "lookat_pos":
        self._id_5EC8 = var_3;
        break;
    }
  }

  if(!isDefined(self._id_0873) || !isDefined(self._id_0186) || !isDefined(self._id_502E) || !isDefined(self._id_502E.scriptmodelplayanim) || !isDefined(self._id_502E._id_82E5) || !isDefined(self._id_502F) || !isDefined(self._id_5EC8) || !isDefined(self._id_5EC8.scriptmodelplayanim)) {
    return;
  }
  if(!isDefined(self._id_606E)) {
    self._id_606E = 0;
  }

  self._id_0CA5 = 0;

  for(;;) {
    if(isDefined(self.setgoalnode)) {
      common_scripts\utility::_id_3C9F(self.setgoalnode);
    }

    self waittill("trigger", var_5);

    if(!isPlayer(var_5)) {
      continue;
    }
    if(isDefined(self.setgoalnode) && !common_scripts\utility::_id_3C77(self.setgoalnode)) {
      continue;
    }
    while(isDefined(var_5) && var_5 istouching(self)) {
      var_6 = var_5 getvelocity();
      var_7 = var_5 getEye() + self._id_502E._id_82E5 * var_6;

      if(self._id_606E > 0) {
        var_8 = vectortoangles(self._id_502E.origin - self._id_0186.origin)[1];
        var_9 = vectortoangles(var_7 - self._id_0186.origin)[1];
        var_10 = _angleclamp180(var_9 - var_8);
        var_10 = clamp(var_10, 0 - self._id_606E, self._id_606E);
        var_11 = _transformmove(self._id_0186.origin, (0, var_10, 0), self._id_0186.origin, (0, 0, 0), self._id_5EC8.origin, self._id_5EC8.angles)["origin"];
        var_12 = _transformmove(self._id_0186.origin, (0, var_10, 0), self._id_0186.origin, (0, 0, 0), self._id_502E.origin, self._id_502E.angles)["origin"];
      } else {
        var_10 = 0;
        var_11 = self._id_5EC8.origin;
        var_12 = self._id_502E.origin;
      }

      var_13 = _distance2d(var_7, var_12);

      if(var_13 < self._id_502E.scriptmodelplayanim && vectordot(vectorNormalize(var_6), vectorNormalize(var_11 - var_12)) > 0.5) {
        var_16 = var_5 getEye() + (self._id_502E._id_82E5 + 0.05) * var_6;
        var_17 = _distance2d(var_16, var_12);

        if(var_13 <= var_17) {
          var_18 = anglesToForward(var_5 _meth_8566());

          if(_id_0547::_id_3048(var_11, var_7, var_7 + 9999 * var_18) < self._id_5EC8.scriptmodelplayanim && vectordot(var_18, var_11 - var_7) > 0) {
            var_19 = 0;

            foreach(var_21 in level.players) {
              if(var_21 != var_5) {
                var_22 = var_21 getEye();

                if(distance(var_22, var_12) < 195 || vectordot(vectorNormalize(var_12 - var_22), anglesToForward(var_21 _meth_8566())) > 0 && (_sighttracepassed(var_22, var_12 + (0, 0, 60), 0, undefined) || _sighttracepassed(var_22, self._id_0186.origin, 0, undefined))) {
                  var_19 = 1;
                  break;
                }
              }
            }

            if(!var_19 && _id_5977(var_5)) {
              thread _id_9052(var_1, var_5, var_10);
              var_24 = 0;

              if(var_24) {
                wait(var_24);
              } else {
                self._id_0CA2 = 1;
                return;
              }
            } else {
              while(isDefined(var_5) && var_5 istouching(self)) {
                wait 1;
              }
            }
          }
        }
      }

      waitframe();
    }
  }
}

_id_9052(var_0, var_1, var_2) {
  _id_5976(var_1);
  var_3 = _id_054D::_id_90BA("zombie_generic", self._id_0186, "jumpscare: " + _id_41E1(), 0, 1, 1);
  var_1 _id_0378::_id_8D74("simple_jump_scare", var_3);
  var_3._id_5979 = var_1;
  var_3._id_597A = 0;
  level notify("jumpscare_triggered", var_1, var_3);
  var_3 thread _id_4A11(self, var_1, var_2);
  var_1 thread _id_598A();

  if(isDefined(var_0)) {
    var_3 thread[[var_0]]();
  }

  if(isDefined(self._id_1B83)) {
    var_3 thread _id_4A12(self._id_1B83);
  }
}

_id_4A11(var_0, var_1, var_2) {
  self.origin = var_0._id_0186.origin;
  self.angles = var_0._id_0186.angles + (0, var_2, 0);
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "handle_js_lerp");
  self._id_53D9 = 1;
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", var_0._id_0186.angles);
  self scragentsetanimscale(1, 1);
  self scragentsetphysicsmode("noclip");
  var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_0._id_0873);
  var_4 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_3);
  var_5 = self getanimentry(var_3, var_4);
  maps\mp\agents\_scripted_agent_anim_util::isenemyaware(var_3, var_4);
  var_6 = _getanimlength(var_5);
  var_7 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_5, "lerp_origin_begin", 2);
  var_8 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_5, "lerp_origin_end", 2);
  var_9 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_5, "lerp_angles_begin", 2);
  var_10 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_5, "lerp_angles_end", 2);
  var_11 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_5, "code_move", clamp((var_6 - 0.2) / var_6, 0, 1)) * var_6;
  var_12 = undefined;
  var_13 = 0;
  var_14 = 0;
  var_15 = var_0._id_502E.origin;
  var_16 = var_0._id_502E.angles;

  for(var_17 = 0; var_17 < var_11 && isalive(self); var_17 = var_17 + 0.05) {
    waittillframeend;
    var_18 = clamp((var_17 - 0.05) / var_6, 0, 1);
    var_19 = var_17 / var_6;

    if(isalive(var_1)) {
      var_15 = var_1.origin;
      var_16 = var_1.angles;
    }

    var_20 = _transformmove(var_0._id_0186.origin, var_0._id_0186.angles, (0, 0, 0), (0, 0, 0), _getmovedelta(var_5, 0, var_19), _getangledelta3d(var_5, 0, var_19));
    var_21 = _transformmove(var_1.origin, var_1.angles, var_0._id_502E.origin, var_0._id_502E.angles, var_20["origin"], var_20["angles"]);

    if(!isDefined(var_12)) {
      var_12 = var_0._id_0186 common_scripts\utility::_id_8FFC();
      var_12 hide();
    }

    var_12.origin = var_21["origin"];
    var_12.angles = var_21["angles"];

    if(!self._id_00D7) {
      var_13 = 1;
    }

    var_22 = var_19 >= var_7 && var_19 < var_8 && var_13 && isalive(var_1);
    var_23 = var_19 >= var_9 && var_19 < var_10 && var_13 && isalive(var_1);

    if(var_13 && _abs(_getmovedelta(var_5, var_18, var_19)[2]) < 1 && (var_22 || var_23)) {
      self scragentsetphysicsmode("gravity");
      var_14 = 1;
    }

    if(!var_14) {
      var_22 = 0;
      var_23 = 0;
    }

    if(var_22) {
      var_24 = 1;
    } else {
      var_24 = 9999;
    }

    if(var_23) {
      var_25 = 0.1;
    } else {
      var_25 = 9999;
    }

    self scragentsynchronizeanims(var_24, var_25, var_12, "tag_origin", "tag_origin");
    waitframe();
  }

  if(isalive(self)) {
    maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "handle_js_lerp");
    self._id_53D9 = undefined;
    _id_0547::disableoffhandsecondaryweapons();
    self scragentsetscripted(0);
  }

  var_12 delete();
}

_id_4A12(var_0) {
  self endon("death");
  self waittillmatch("scripted_anim", "breach");
  var_0 setModel(var_0.setlookatent);
  waitframe();
  _physicsexplosionsphere(self.origin + (0, 0, 32), 128, 64, 0.0001, 0);
}

_id_3D86() {
  _id_9053("floor", ::_id_3D87);
}

_id_3D87() {
  playFX(level._effect["zmb_jump_scare_ground_snow"], self.origin + (0, 0, 64));
}

_id_3266() {
  _id_9053("door", undefined);
}

_id_1D91() {
  _id_9053("bunker_drop", undefined);
}

_id_1DA1() {
  _id_9053("bunker_window", undefined);
}

sidestep_js_thinker() {
  _id_9053("sidestep", undefined);
}

sidestep_left_js_thinker() {
  _id_9053("sidestep_left", undefined);
}

_id_347E() {
  loadcostumemodels("drop");
  self._id_72E2 = undefined;
  self._id_3A14 = [];
  self._id_3A10 = 300;
  self._id_5C38 = 0.8;
  self._id_61A4 = 120;
  self._id_1E8F = 0;
  self._id_1E90 = 1;
  self._id_5974 = 150;
  self._id_0A30 = 1;
  self._id_3A13 = 1;
  var_0 = common_scripts\utility::_id_46B7(self.target, "targetname");
  var_1 = undefined;

  foreach(var_3 in var_0) {
    var_4 = 0;

    if(isDefined(var_3._id_0165)) {
      switch (var_3._id_0165) {
        case "zombie_sky_spawner":
          if(isDefined(var_3.setmovespeedscale)) {
            self._id_3A14[var_3.setmovespeedscale] = var_3;
            var_1 = 1;
            var_3._id_8FCA = var_3.setmovespeedscale;
          } else {
            var_1 = 0;
            var_3._id_8FCA = self._id_3A14.size;
            self._id_3A14[self._id_3A14.size] = var_3;
          }

          var_5 = _id_0547::_id_4282(var_3);
          var_6 = var_5["height"];

          if(isDefined(var_6)) {
            var_3._id_3A10 = int(var_6);
          }

          var_6 = var_5["impact_delay"];

          if(isDefined(var_6)) {
            var_3._id_50B1 = _float(var_6);
          }

          var_3._id_0873 = var_3.setflaggedanimknoball;
          var_4 = 1;
          break;
        case "player_line":
          self._id_72E2 = var_3;
          var_4 = 1;
          break;
        case "lookat_target":
          self._id_5ECA = var_3;
          self._id_5978 = var_3.origin;
          var_4 = 1;
          break;
      }
    }
  }

  if(!isDefined(self._id_72E2) || self._id_3A14.size == 0) {
    return;
  }
  thread _id_0547::_id_AC0D(self._id_3A14, "Drop Jumpscare");
  thread _id_347F();
}

_id_347F() {
  var_0 = _anglestoaxis(self._id_72E2.angles);

  for(;;) {
    if(isDefined(self.setgoalnode)) {
      common_scripts\utility::_id_3C9F(self.setgoalnode);
    }

    self waittill("trigger", var_1);

    if(isDefined(self.setgoalnode) && !common_scripts\utility::_id_3C77(self.setgoalnode)) {
      continue;
    }
    if(!isDefined(var_1) || !isPlayer(var_1)) {
      continue;
    }
    var_5 = 0;
    var_6 = var_1 getvelocity();
    var_7 = self._id_72E2.origin - var_1.origin;
    var_8 = undefined;
    var_13 = vectordot(var_7, var_0["forward"]);

    if(var_13 < 0) {
      continue;
    }
    if(var_13 < self._id_61A4) {
      var_5 = 1;
    }

    var_14 = vectordot(var_6, var_0["forward"]);

    if(var_14 > 0) {
      var_15 = var_13 / var_14;

      if(var_15 < self._id_5C38) {
        var_8 = gettime() + var_15 * 1000;
        var_5 = 1;
      }
    }

    if(var_5) {
      if(_id_5977(var_1) && isDefined(level._id_2F29) && level._id_2F29 != 1) {
        _id_347D(var_1, var_8);
      }

      return;
    }
  }
}

_id_347D(var_0, var_1) {
  _id_5976(var_0);

  for(var_3 = 0; var_3 < self._id_3A14.size; var_3++) {
    var_4 = self._id_3A14[var_3];
    thread _id_347C(var_4, var_1, var_0);
  }
}

_id_347C(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = 0.2 * var_0._id_8FCA;
  wait(var_4);

  if(self._id_3A13 && isDefined(var_1)) {
    if(isDefined(var_0._id_50B1)) {
      var_3 = var_1 + var_0._id_50B1 * 1000;
    } else {
      var_3 = var_1 + var_4;
    }
  }

  var_5 = _id_054D::_id_90BA("zombie_generic", var_0, "drop scare", 0, 1, 1);

  if(var_0._id_8FCA == 0) {
    thread _id_347B(var_5, var_2);
  }

  var_6 = self._id_3A10;

  if(isDefined(var_0._id_3A10)) {
    var_6 = max(var_6, var_0._id_3A10);
  }

  var_5 thread _id_0540::_id_ABA4(var_0.origin, var_0.angles, var_6, var_0._id_0873, var_0, var_3);
}

_id_347B(var_0, var_1) {
  var_0 endon("death");
  var_0 waittill("zombie_fall_impact");
  var_2 = [var_1];

  if(common_scripts\utility::_id_562E(self._id_0A30)) {
    var_2 = level.players;
  }

  if(!isDefined(self._id_5ECA)) {
    self._id_5978 = var_0 gettagorigin("J_Knee_RI");
  }

  foreach(var_5 in var_2) {
    if(!maps\mp\_utility::isreallyalive(var_5) || !self istouching(var_5) && _distance2d(var_5.origin, self._id_5978) > self._id_5974) {
      continue;
    }
    var_5 _id_0378::_id_8D74("fall_jumpscare", var_0, self);

    if(self._id_1E8F) {
      var_8 = 1;

      if(self._id_1E90) {
        var_8 = _id_AA32(var_5);
      }

      if(var_8) {
        var_9 = self._id_5978 - var_5 getEye();
        var_5 setplayerangles(vectortoangles(var_9));
        var_5 thread _id_598A();
      }
    }
  }
}

waittill_jumpscare_initialized() {
  while(!isDefined(level.scaretable)) {
    waitframe();
  }
}

loadcostumemodels(var_0) {
  var_1 = level.scaretable;
  self._id_598B = var_0;
}

_id_41E1() {
  var_0 = level.scaretable;
  return self._id_598B;
}

_id_3DB1() {
  var_0 = common_scripts\utility::_id_46B7("fol_incubator_spawn", "targetname");
  var_1 = common_scripts\utility::_id_46B7("fol_incubator_dormant", "targetname");
  var_2 = common_scripts\utility::_id_0F73(var_0, var_1);
  common_scripts\utility::flag_init("flag_first_fol_inc_selected");
  common_scripts\utility::flag_init("flag_fol_inc_armed");

  foreach(var_4 in var_2) {
    var_5 = common_scripts\utility::_id_44BE(var_4.target, "targetname");

    foreach(var_7 in var_5) {
      var_8 = var_7._id_0165;

      if(!isDefined(var_8)) {
        continue;
      }
      switch (var_8) {
        case "inc_js_trig":
          var_4._id_9D5E = var_7;
          break;
        case "inc_js_head_pos":
          var_4._id_4BDE = var_7;
          break;
        case "inc_js_door":
          var_4._id_3255 = var_7;
          break;
        case "inc_js_door_dest":
          var_4._id_325B = var_7;
          break;
        case "inc_js_door_exp_fx":
          if(!isDefined(var_4.fx)) {
            var_4.fx = [];
          }

          var_4.fx[var_4.fx.size] = var_7;
          break;
      }
    }

    if(isDefined(var_4._id_9D5E)) {
      var_4._id_0CA6 = 0;
      var_4._id_5975 = 0;
      var_4._id_5973 = 0;
      var_4._id_5972 = 0;
      var_4._id_5971 = 0;
    }

    if(isDefined(var_4._id_4BDE)) {
      var_4._id_39F8 = spawn("script_model", var_4._id_4BDE.origin);
      var_4._id_39F8 setModel("zom_follower_justhead");
      var_4._id_39F8.angles = var_4._id_4BDE.angles;
      var_4._id_39F8 scriptmodelplayanim("s2_zom_fol_pass_idle_1");
    }
  }
}

_id_3DB0() {
  return common_scripts\utility::_id_46B7("fol_incubator_spawn", "targetname");
}

_id_3DAF() {
  return common_scripts\utility::_id_46B7("fol_incubator_dormant", "targetname");
}

_id_3DB3() {
  loadcostumemodels("follower_incubator");

  if(common_scripts\utility::_id_562E(self._id_5972) || common_scripts\utility::_id_562E(self._id_0CA6)) {
    return;
  }
  self._id_5978 = self._id_9D5E.origin;
  var_0 = 1;
  var_1 = undefined;

  while(!common_scripts\utility::_id_3C77("flag_first_fol_inc_selected")) {
    var_2 = 0;

    if(isDefined(self.setgoalnode)) {
      common_scripts\utility::_id_3C9F(self.setgoalnode);
    }

    self._id_9D5E waittill("trigger", var_1);

    if(isDefined(self.setgoalnode) && !common_scripts\utility::_id_3C77(self.setgoalnode)) {
      wait(var_0);
      continue;
    }

    if(!isDefined(var_1) || !isPlayer(var_1)) {
      wait(var_0);
      continue;
    }

    if(self._id_5973) {
      var_2 = 1;
    } else {
      if(!_sighttracepassed(var_1.origin, self._id_5978, 0, self._id_3255)) {
        wait(var_0);
        continue;
      }

      var_3 = var_1 getEye();
      var_4 = var_1 _meth_8566();
      var_5 = anglesToForward(var_4);
      var_6 = vectorNormalize(self._id_5978 - var_3);

      if(vectordot(var_5, var_6) > 0.766) {
        var_2 = 1;
      } else {}
    }

    if(var_2) {
      if(self._id_5971) {
        break;
      } else if(!self._id_5975) {
        if(isDefined(var_1) && isPlayer(var_1)) {
          var_7 = _id_5977(var_1);

          if(var_7) {
            _id_3DB2(var_1);
            self._id_5975 = 1;
          }
        }
      }
    }

    wait(var_0);
  }

  var_7 = 0;

  if(self._id_5971) {
    if(self._id_5973) {
      var_7 = 1;
    } else if(isDefined(var_1) && isPlayer(var_1)) {
      var_7 = _id_5977(var_1);
    }

    if(var_7) {
      _id_3DAE(var_1);
    } else {
      self._id_5972 = 1;
      thread _id_3DAD();
    }
  }
}

_id_3DB2(var_0) {
  _earthquake(0.1, 0.2, self._id_3255.origin, 250);
  var_1 = common_scripts\utility::_id_4461(self.origin, level.players, 250);
  _id_0378::_id_8D74("fol_tube_jumpscare_rattle", var_1);

  if(!common_scripts\utility::_id_562E(var_1._id_3067)) {
    var_2 = var_1 _id_0367::_id_8E3D("followertanklook");

    if(isDefined(var_2)) {
      var_1._id_3067 = 1;
    }
  }

  self._id_3255 vibrate(anglesToForward(self._id_3255.angles), 0.3, 0.4, 0.2);
}

_id_3DAE(var_0) {
  if(common_scripts\utility::_id_3C77("flag_first_fol_inc_selected")) {
    return;
  } else {
    common_scripts\utility::flag_set("flag_first_fol_inc_selected");
  }

  self._id_0CA5 = 1;

  if(!isDefined(self._id_3255)) {
    return;
  }
  _id_0378::_id_8D74("fol_tube_jumpscare_execute");
  var_1 = 3.8;
  var_2 = 1.93333;

  if(isDefined(self._id_3255)) {
    self._id_3255 scriptmodelplayanim("zmb_incubator_panel_fol_intro_spawn");
    _id_0378::_id_8D74("fol_tube_jumpscare_door_fall");
  }

  if(isDefined(var_0)) {
    _id_5976(var_0);
  }

  var_3 = _id_054D::_id_90BA("zombie_heavy", self, "follower incubator spawn", 0, 1, 0, undefined, 0);

  if(!isDefined(var_3)) {
    return;
  }
  var_3 hide();
  wait(var_2);

  if(isDefined(self._id_39F8)) {
    self._id_39F8 delete();
  }

  var_3 show();

  if(isDefined(self._id_3255)) {
    self._id_3255 hide();
  }

  foreach(var_5 in self.fx) {
    var_6 = anglesToForward(var_5.angles);
    var_7 = anglestoup(var_5.angles);
    playFX(common_scripts\utility::_id_44F5("zmb_incubator_js_explosion"), var_5.origin, var_6, var_7);
  }

  if(!isDefined(var_0) && isDefined(self._id_3255)) {
    var_0 = common_scripts\utility::_id_4461(self._id_3255.origin, level.players);
  }

  if(isDefined(self._id_3255)) {
    self._id_3255 scriptmodelclearanim();
    self._id_3255 delete();
  }

  if(isDefined(var_0)) {
    var_0 thread _id_0367::_id_8E3C("followersurprise");
  }
}

_id_3DAD() {
  var_0 = _id_055A::_id_4562(self.origin);

  for(;;) {
    var_1 = 1;

    foreach(var_3 in level.players) {
      if(_id_055A::_id_7413(var_3, var_0)) {
        var_1 = 0;
      }
    }

    if(var_1) {
      break;
    }

    wait 10;
  }

  if(common_scripts\utility::_id_562E(self._id_0CA6)) {
    return;
  }
  if(isDefined(self._id_9D5E)) {
    self._id_9D5E delete();
  }

  if(isDefined(self._id_3255)) {
    self._id_3255 delete();
  }

  if(isDefined(self._id_39F8)) {
    self._id_39F8 delete();
  }

  self._id_0CA6 = 1;
}