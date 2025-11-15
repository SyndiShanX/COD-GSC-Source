/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_apache_player_raining_missile.gsc
**************************************************************/

_precache() {
  precacheitem("apache_lockon_raining_missile_phase_2");
  precacheitem("apache_raining_missile");
  precacheshader("apache_missile_icon");
  precacheshader("apache_missile_icon_lock");
  _fx();
}

_fx() {
  level._effect["FX_apache_raining_missile_spawn"] = loadfx("fx/_requests/apache/apache_raining_missile_spawn");
}

_init(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.owner = var_0;
  var_2.type = "raining_missile";
  var_2.masterhud = var_1;
  var_2.target = undefined;
  var_2.isactive = undefined;
  var_2 hud_init();
  return var_2;
}

hud_init() {
  var_0 = self.owner;
  var_1 = self.masterhud;
  var_2 = [];
  var_2["missile_name"] = var_0 maps\_hud_util::createclientfontstring("objective", 1.0);
  var_2["missile_name"] maps\_hud_util::setpoint("CENTER", undefined, 142, 92);
  var_2["missile_name"].alpha = 0.0;
  var_2["missile_name"].color = (0, 1, 0);
  var_2["missile_name"] settext("PREACHR:");
  var_2["missile_name"] maps\_hud_util::setparent(var_1["mg_reticle"]);
  var_2["missile"] = var_0 maps\_hud_util::createclienticon("apache_missile_icon", 16, 16);
  var_2["missile"] maps\_hud_util::setpoint("CENTER", undefined, 176, 92);
  var_2["missile"].alpha = 1.0;
  var_2["missile"].color = (0, 1, 0);
  var_2["missile"].isavailable = 1;
  var_2["missile"].islockedontarget = undefined;
  var_2["missile"] maps\_hud_util::setparent(var_1["mg_reticle"]);
  self.hud = var_2;
}

_start() {
  var_0 = self.owner;
  var_0 endon("LISTEN_end_raining_missile");
  hud_start();
  var_0 notifyonplayercommand("LISTEN_raining_missile_startLockOn", "+frag");
  var_0 notifyonplayercommand("LISTEN_raining_missile_startFire", "-frag");
  self.target = undefined;
  childthread monitorreloading();

  for(;;) {
    if(!isDefined(self.isactive)) {
      wait 0.05;
      continue;
    }

    var_0 waittill("LISTEN_raining_missile_startLockOn");

    if(!isDefined(self.isactive)) {
      wait 0.05;
      continue;
    }

    childthread lockontarget();
    var_0 waittill("LISTEN_raining_missile_startFire");
    childthread _fire();
  }
}

activate() {
  var_0 = self.hud;
  self.isactive = 1;

  if(isDefined(var_0["missile"].isavailable))
    var_0["missile"].alpha = 1.0;
  else
    var_0["missile"].alpha = 0;

  var_0["missile_name"].alpha = 1.0;
}

deactivate() {
  var_0 = self.hud;
  self.isactive = undefined;

  if(isDefined(var_0["missile"].isavailable))
    var_0["missile"].alpha = 0.2;
  else
    var_0["missile"].alpha = 0;

  var_0["missile_name"].alpha = 0.2;
}

hud_start() {
  var_0 = self.hud;

  if(isDefined(var_0["missile"].isavailable))
    var_0["missile"].alpha = common_scripts\utility::ter_op(isDefined(self.isactive), 1.0, 0.2);
  else
    var_0["missile"].alpha = 0;

  if(isDefined(var_0["missile"].islockedontarget))
    var_0["missile"] setshader("apache_missile_icon_lock", 16, 16);
  else
    var_0["missile"] setshader("apache_missile_icon", 16, 16);

  var_0["missile_name"].alpha = common_scripts\utility::ter_op(isDefined(self.isactive), 1.0, 0.2);
}

monitorreloading() {
  var_0 = self.owner;
  var_1 = self.hud["missile"];

  for(;;) {
    if(!isDefined(var_1.isavailable)) {
      wait 10;
      var_1 setshader("apache_missile_icon", 16, 16);
      var_1.alpha = 1;
      var_1.color = (0, 1, 0);
      var_1.isavailable = 1;
      var_1.islockedontarget = undefined;
    }

    wait 0.05;
  }
}

lockontarget() {
  var_0 = self.owner;
  var_0 endon("LISTEN_raining_missile_startFire");
  self.target = undefined;

  for(;;) {
    var_1 = target_getarray();

    foreach(var_3 in var_1) {
      if(var_3 target_islockedon(var_0)) {
        if(!target_isincircle(var_3, var_0, 65, 128))
          removelockedontarget(var_3);
      }
    }

    if(hasammofortargets() && !hud_islockedontarget(self.hud["missile"])) {
      var_1 = sortbydistance(var_1, var_0 getEye());
      var_3 = gettargetclosesttoreticule(var_1);
      addlockedontarget(var_3);
    }

    wait 0.05;
  }
}

gettargetclosesttoreticule(var_0) {
  var_1 = self.owner;
  var_2 = 0;

  for(var_3 = 96; !var_2 && var_3 > 16; var_3 = var_3 * 0.75) {
    foreach(var_5 in var_0) {
      if(!var_5 maps\_vehicle::isvehicle() || var_5 target_islockedon(var_1) || !target_isincircle(var_5, var_1, 65, var_3))
        var_0 = common_scripts\utility::array_remove(var_0, var_5);
    }

    if(var_0.size <= 2)
      var_2 = 1;
  }

  return common_scripts\utility::array_randomize(var_0)[0];
}

hud_flashalpha(var_0, var_1, var_2) {
  self endon("death");
  self.alpha = var_0;

  for(;;) {
    self fadeovertime(var_1);
    self.alpha = 0;
    wait(var_1);

    if(isDefined(var_2) && var_2 > 0)
      wait(var_2);

    self fadeovertime(var_1);
    self.alpha = var_0;
    wait(var_1);
  }
}

target_islockedon(var_0) {
  return isDefined(self._target.weapon["lockOn_missile"].islockedon[var_0 getentitynumber()]);
}

islockedontarget(var_0) {
  return common_scripts\utility::array_contains(self.targets, var_0);
}

hasammofortargets() {
  return isDefined(self.hud["missile"].isavailable);
}

addlockedontarget(var_0) {
  var_1 = self.owner;
  self.target = var_0;

  if(!isDefined(var_0)) {
    return;
  }
  if(!isdummytarget(var_0)) {
    if(!var_0 target_islockedonbyanyweaponsystem(var_1))
      target_setcolor(var_0, (1, 0, 0));

    var_0 target_set_islockedon(var_1);
  }

  hud_markused_freemissileicon();
}

dummy_getrealtarget() {
  return self.realtarget;
}

target_set_islockedon(var_0) {
  self._target.weapon["raining_missile"].islockedon[var_0 getentitynumber()] = 1;
}

isdummytarget(var_0) {
  return isDefined(var_0.isdummytarget);
}

hud_markused_freemissileicon() {
  var_0 = self.hud["missile"];

  if(!hud_islockedontarget(var_0)) {
    var_0 setshader("apache_missile_icon_lock", 16, 16);
    var_0.islockedontarget = 1;
    var_0.color = (1, 0, 0);
  }
}

hud_islockedontarget(var_0) {
  return isDefined(var_0.islockedontarget);
}

removelockedontarget(var_0) {
  self.target = undefined;
  var_1 = self.owner;
  var_0 target_unset_islockedon(var_1);

  if(!var_0 target_islockedonbyanyweaponsystem(var_1))
    target_setcolor(var_0, (0, 1, 0));

  hud_markfree_usedmissileicon();
}

target_islockedonbyanyweaponsystem(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_1))
    var_2 = var_1;
  else
    var_2 = var_0 getentitynumber();

  foreach(var_4 in self._target.weapon) {
    if(isDefined(var_4.islockedon[var_2]))
      return 1;
  }

  return 0;
}

target_unset_islockedon(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_1))
    var_2 = var_1;
  else
    var_2 = var_0 getentitynumber();

  if(isDefined(self._target))
    self._target.weapon["raining_missile"].islockedon[var_2] = undefined;
}

hud_markfree_usedmissileicon() {
  var_0 = self.hud["missile"];

  if(hud_islockedontarget(var_0)) {
    var_0.islockedontarget = undefined;
    var_0.color = (0, 1, 0);
  }
}

_fire() {
  var_0 = self.owner;

  if(!hasammofortargets()) {
    return;
  }
  var_1 = undefined;

  if(!isDefined(self.target)) {
    var_2 = var_0 getplayerangles();
    var_3 = anglesToForward(var_2);
    var_1 = spawn("script_model", var_0 getEye() + 6000 * var_3);
    var_1 setModel("tag_origin");
    var_1.isdummytarget = 1;
    addlockedontarget(var_1);
  }

  if(!isdummytarget(self.target)) {
    var_1 = spawn("script_model", self.target.origin);
    var_1 setModel("tag_origin");
    var_1 linkto(self.target);
    var_1.isdummytarget = 1;
  }

  hud_makenotavailable_availablemissileicon();
  var_4 = var_0 getEye() + (0, 0, -160);
  var_2 = var_0 getplayerangles();
  var_5 = var_4 + 10 * anglesToForward(var_2);
  var_6 = magicbullet("apache_lockon_raining_missile_phase_2", var_4, var_5, var_0);
  var_6.owner = var_0;
  var_7 = 0.000005 * distance(var_4, self.target.origin);

  if(var_7 < 0.05)
    var_6 common_scripts\utility::missile_settargetandflightmode(var_1, "top");
  else
    var_6 maps\_utility::delaythread(var_7, common_scripts\utility::missile_settargetandflightmode, var_1, "top");

  thread deployrainingmissiles(var_6, var_1, self.target);
  var_0 playrumbleonentity("heavygun_fire");
  earthquake(0.3, 0.6, var_0.origin, 5000);
  self.target thread target_monitorfreelockedon(var_0, var_6, var_1);
}

hud_makenotavailable_availablemissileicon() {
  var_0 = self.hud["missile"];

  if(isDefined(var_0.isavailable)) {
    var_0.isavailable = undefined;
    var_0.alpha = 0;
  }
}

deployrainingmissiles(var_0, var_1, var_2) {
  var_3 = 2048;
  var_0 thread missile_trackrealtarget(var_2);
  waittill_ent_moving_dir_world_relative(var_0, (0, 0, 1), 0.707107);

  if(isDefined(var_0))
    waittill_ent_moving_dir_world_relative(var_0, (0, 0, -1));

  if(isDefined(var_0))
    waittill_ent1_in_z_range_of_ent2(var_0, var_1, var_3);

  if(!isDefined(var_0)) {
    return;
  }
  var_4 = var_0.origin;
  var_5 = var_0.angles;
  var_6 = var_0.realtargetorigin;
  var_7 = var_0.owner;
  var_0 delete();
  var_8 = anglesToForward(var_5);
  playFX(common_scripts\utility::getfx("FX_apache_raining_missile_spawn"), var_4, -1 * var_8);
  var_7 playrumbleonentity("heavygun_fire");
  earthquake(0.2, 0.4, var_7.origin, 5000);
  var_9 = (0, 0, 1);
  var_5 = vectortoangles(var_9);
  var_10 = anglestoup(var_5);
  var_11 = vectorcross(var_9, var_10);
  var_12 = 16;
  var_13 = 360 / var_12;
  var_14 = [];
  var_15 = [];
  var_16 = [];

  for(var_17 = 0; var_17 < var_12; var_17++) {
    var_18 = randomfloatrange(256, 292);
    var_19 = randomfloatrange(-3, 3);
    var_14[var_17] = cos(var_13 * var_17 + var_19);
    var_15[var_17] = sin(var_13 * var_17 + var_19);
    var_16[var_17] = var_4 + var_18 * var_14[var_17] * var_10 + var_18 * var_15[var_17] * var_11;
  }

  var_20 = [];
  var_21 = -256;

  for(var_17 = 0; var_17 < var_12; var_17++) {
    var_18 = randomfloatrange(5120, 6400);
    var_20[var_17] = var_4 + (0, 0, var_21) + var_18 * var_14[var_17] * var_10 + var_18 * var_15[var_17] * var_11;
  }

  var_22 = [];
  var_4 = var_6;

  for(var_17 = 0; var_17 < var_12; var_17++) {
    var_18 = randomfloatrange(0, 640);
    var_22[var_17] = var_4 + var_18 * var_14[var_17] * var_10 + var_18 * var_15[var_17] * var_11;
  }

  var_23 = [];

  for(var_17 = 0; var_17 < var_12; var_17++)
    var_23[var_17] = var_17;

  var_23 = common_scripts\utility::array_randomize(var_23);

  for(var_17 = 0; var_17 < var_12; var_17++) {
    var_24 = randomfloatrange(0, 0.5);
    var_25 = randomfloatrange(0.5, 4);
    var_26 = var_23[var_17];
    var_27 = spawn("script_model", var_22[var_17]);
    var_27 setModel("tag_origin");
    thread missile_spawnandlockontotarget(var_24, var_16[var_26], var_20[var_26], var_7, var_25, var_27);
  }
}

missile_trackrealtarget(var_0) {
  self endon("death");

  while(isDefined(var_0)) {
    self.realtargetorigin = var_0.origin;
    wait 0.05;
  }
}

missile_spawnandlockontotarget(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_0 > 0.05)
    wait(var_0);

  var_6 = magicbullet("apache_raining_missile", var_1, var_2, var_3);
  var_6.owner = var_3;
  var_6 common_scripts\utility::missile_settargetandflightmode(var_5, "direct");
  var_6 thread missile_ondeathdeletetarget(var_5);
}

missile_ondeathdeletetarget(var_0) {
  var_1 = self.owner;
  self waittill("death");
  var_0 delete();
  var_1 playrumbleonentity("heavygun_fire");
  earthquake(0.15, 0.3, var_1.origin, 5000);
}

waittill_ent_moving_dir_world_relative(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_0 endon("death");
  var_3 = var_0.origin;

  for(;;) {
    wait 0.05;

    if(!isDefined(var_0)) {
      return;
    }
    var_4 = vectornormalize(var_0.origin - var_3);

    if(vectordot(var_1, var_4) > 0) {
      break;
    }

    var_3 = var_0.origin;
  }
}

target_monitorfreelockedon(var_0, var_1, var_2) {
  var_3 = var_0 getentitynumber();
  var_1 waittill("death");

  if(isDefined(self)) {
    if(!isdummytarget(self)) {
      target_unset_islockedon(var_0, var_3);

      if(target_istarget(self) && !target_islockedonbyanyweaponsystem(var_0, var_3))
        target_setcolor(self, (0, 1, 0));
    }
  }

  var_2 delete();
}

_end() {
  var_0 = self.owner;
  var_0 notify("LISTEN_end_raining_missile");
  override_array_thread(self.hud, ::set_key, [0, "alpha"]);
}

_destroy() {
  _end();
  override_array_call(self.hud, ::destroy);
}

set_key(var_0, var_1) {
  if(!isDefined(self) || !isDefined(var_1)) {
    return;
  }
  switch (var_1) {
    case "alpha":
      self.alpha = var_0;
      break;
  }
}

override_array_thread(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    foreach(var_4 in var_0) {
      if(isDefined(var_4)) {
        if(isDefined(var_4) && isarray(var_4)) {
          override_array_thread(var_4, var_1);
          continue;
        }

        var_4 thread[[var_1]]();
      }
    }
  } else {
    switch (var_2.size) {
      case 0:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(isarray(var_4)) {
              override_array_thread(var_4, var_1, var_2);
              continue;
            }

            var_4 thread[[var_1]]();
          }
        }

        break;
      case 1:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(isarray(var_4)) {
              override_array_thread(var_4, var_1, var_2);
              continue;
            }

            var_4 thread[[var_1]](var_2[0]);
          }
        }

        break;
      case 2:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(isarray(var_4)) {
              override_array_thread(var_4, var_1, var_2);
              continue;
            }

            var_4 thread[[var_1]](var_2[0], var_2[1]);
          }
        }

        break;
      case 3:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(isarray(var_4)) {
              override_array_thread(var_4, var_1, var_2);
              continue;
            }

            var_4 thread[[var_1]](var_2[0], var_2[1], var_2[2]);
          }
        }

        break;
      case 4:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(isarray(var_4)) {
              override_array_thread(var_4, var_1, var_2);
              continue;
            }

            var_4 thread[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3]);
          }
        }

        break;
      case 5:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(isarray(var_4)) {
              override_array_thread(var_4, var_1, var_2);
              continue;
            }

            var_4 thread[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
          }
        }

        break;
    }
  }
}

override_array_call(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    foreach(var_4 in var_0) {
      if(isDefined(var_4)) {
        if(isarray(var_4)) {
          override_array_call(var_4, var_1);
          continue;
        }

        var_4 call[[var_1]]();
      }
    }
  } else {
    switch (var_2.size) {
      case 0:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(isarray(var_4)) {
              override_array_call(var_4, var_1, var_2);
              continue;
            }

            var_4 call[[var_1]]();
          }
        }

        break;
      case 1:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(isarray(var_4)) {
              override_array_call(var_4, var_1, var_2);
              continue;
            }

            var_4 call[[var_1]](var_2[0]);
          }
        }

        break;
      case 2:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(isarray(var_4)) {
              override_array_call(var_4, var_1, var_2);
              continue;
            }

            var_4 call[[var_1]](var_2[0], var_2[1]);
          }
        }

        break;
      case 3:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(isarray(var_4)) {
              override_array_call(var_4, var_1, var_2);
              continue;
            }

            var_4 call[[var_1]](var_2[0], var_2[1], var_2[2]);
          }
        }

        break;
      case 4:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(isarray(var_4)) {
              override_array_call(var_4, var_1, var_2);
              continue;
            }

            var_4 call[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3]);
          }
        }

        break;
      case 5:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(isarray(var_4)) {
              override_array_call(var_4, var_1, var_2);
              continue;
            }

            var_4 call[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
          }
        }

        break;
    }
  }
}

gt_op(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_1))
    return common_scripts\utility::ter_op(var_0 > var_1, var_0, var_1);

  if(isDefined(var_0) && !isDefined(var_1))
    return var_0;

  if(!isDefined(var_0) && isDefined(var_1))
    return var_1;

  return var_2;
}

waittill_ent1_in_z_range_of_ent2(var_0, var_1, var_2) {
  var_2 = gt_op(var_2, 0);

  while(dsq_z_ents_gt(var_0, var_1, var_2))
    wait 0.05;
}

dsq_z_ents(var_0, var_1) {
  return lengthsquared((0, 0, var_0.origin[2] - var_1.origin[2]));
}

dsq_z_ents_gt(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2))
    return common_scripts\utility::ter_op(dsq_z_ents(var_0, var_1) > squared(var_2), 1, 0);

  return common_scripts\utility::ter_op(isDefined(var_3), var_3, 0);
}