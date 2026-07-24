/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3819.gsc
**************************************/

_id_60F8(var_0) {
  self._id_6084 = newhudelem();
  self._id_6084.hidewheninmenu = 1;
  self._id_6084.alignx = "center";
  self._id_6084.foreground = 1;
  self._id_6084.font = "objective";
  self._id_6084.fontscale = 1.3;
  self._id_6084.alpha = 0;
  self._id_6084.x = 320;
  self._id_6084.y = 345;
  self._id_6084.color = (1, 1, 1);
}

#using_animtree("script_model");

_id_FD81() {
  level._effect["vfx_sc_elevator_hanging_dust_sml"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_elevator_hanging_dust_sml.vfx");
  var_0 = getEntArray("shipcrib_elevator", "script_noteworthy");
  var_0 = scripts\engine\utility::array_combine(var_0, getEntArray("shipcrib_elevator_flight", "script_noteworthy"));
  var_0 = scripts\engine\utility::array_combine(var_0, getEntArray("shipcrib_elevator_jackal", "script_noteworthy"));
  var_0 = scripts\engine\utility::array_combine(var_0, getEntArray("shipcrib_elevator_magazine_bay4", "script_noteworthy"));

  foreach(var_2 in var_0) {
    if(!isDefined(var_2._id_EE52) || var_2._id_EE52 != "model")
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
  }

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_parameters)) {
      var_5 = var_2.script_parameters;
      level.elevators[var_5] = var_2;
      var_6 = _id_0EFB::_id_7994(var_2.script_noteworthy, "script_noteworthy", var_5);
      var_2 _meth_83D0(#animtree);
      var_2.name = var_5;
      var_2._id_32D7 = 0;
      var_2._id_D1DC = 0;
      var_2._id_BC8B = undefined;
      var_2.doors = [];
      var_2._id_AEF3 = [];
      var_2.trigger = _id_7C38(var_6, "trigger");
      var_2._id_BE5F = _id_7C38(var_6, "nav_island");
      var_2._id_BE60 = _id_7C38(var_6, "nav_island_c12");
      var_2.collision = _id_7C39(var_6, "collision");
      var_2.lights = _id_7C37(var_6, "light");
      var_2._id_5A4C = "open";
      var_2.trigger enablelinkTo();
      var_2.trigger linkTo(var_2);
      var_2._id_BE5F linkTo(var_2);
      var_2._id_BE5F _meth_80AF(undefined);

      if(isDefined(var_2._id_BE60)) {
        var_2._id_BE60 linkTo(var_2);
        var_2._id_BE60 _meth_80AF(undefined);
      }

      if(var_2.collision.size > 0)
        scripts\engine\utility::array_call(var_2.collision, ::linkto, var_2);

      scripts\engine\utility::array_call(var_2.lights, ::linkto, var_2);
      var_2._id_6F68 = _id_0EFB::_id_7CC1("shipcrib_elevator_floor", "script_noteworthy", var_5);
      var_2._id_6F68 = scripts\engine\utility::array_sort_with_func(var_2._id_6F68, _id_0EE4::_id_9B41);
      var_2._id_6F67 = [];

      foreach(var_8 in var_2._id_6F68)
      var_2._id_6F67 = scripts\engine\utility::array_add(var_2._id_6F67, var_8._id_EE52);

      var_2._id_2C3F = _id_0EFB::_id_7994("shipcrib_elevator_bollards", "script_noteworthy", var_5);

      if(isDefined(var_2._id_2C3F) && var_2._id_2C3F.size > 0) {
        foreach(var_11 in var_2._id_2C3F) {
          if(isDefined(var_11._id_EE59) && var_11._id_EE59 == "collision_wall") {
            var_2._id_2C3E = var_11;
            continue;
          }

          var_11._id_5AF1 = var_11.origin;
          var_11._id_12D74 = var_11.origin + (0, 0, 42);
          var_11 thread _id_60ED(var_5);
        }
      }

      var_2._id_10F5A = _id_0EFB::_id_7CC1("shipcrib_elevator_steam", "script_noteworthy", var_5);

      if(isDefined(var_2._id_10F5A) && var_2._id_10F5A.size > 0) {
        foreach(var_14 in var_2._id_10F5A)
        var_14 thread _id_6104(var_2);
      }

      _id_FD80(var_5);
      var_2 thread _id_60F8(var_5);
      var_2 thread _id_6105();
      var_2 thread _id_60F4(var_5);
      continue;
    }
  }
}

_id_FD80(var_0) {
  switch (var_0) {
    case "magazine_flight":
    case "magazine":
    case "apc":
    case "dropship":
    case "jackal":
      return;
    default:
      break;
  }

  var_1["2_lower"] = % elevator_lift_ramp2_lower;
  var_1["4_lower"] = % elevator_lift_ramp4_lower;
  var_1["6_lower"] = % elevator_lift_ramp6_lower;
  var_1["8_lower"] = % elevator_lift_ramp8_lower;
  var_1["2_raise"] = % elevator_lift_ramp2_raise;
  var_1["4_raise"] = % elevator_lift_ramp4_raise;
  var_1["6_raise"] = % elevator_lift_ramp6_raise;
  var_1["8_raise"] = % elevator_lift_ramp8_raise;
  _id_6100(var_0, var_1);
}

_id_60ED(var_0) {
  self moveTo(self._id_12D74, 0.05);

  for(;;) {
    var_1 = level.elevators[var_0] scripts\engine\utility::waittill_any_return("doors_open", "doors_close");

    switch (var_1) {
      case "doors_open":
        if(level.elevators[var_0]._id_4B10 == self._id_EE52) {
          self moveTo(self._id_5AF1, 1.25);

          if(isDefined(level.elevators[var_0]._id_2C3E))
            level.elevators[var_0]._id_2C3E notsolid();
        }

        break;
      case "doors_close":
        self moveTo(self._id_12D74, 1.25);

        if(isDefined(level.elevators[var_0]._id_2C3E))
          level.elevators[var_0]._id_2C3E solid();

        break;
    }
  }
}

_id_6104(var_0) {
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_2 = "vfx_sc_steam_vent_elevator_lrg_01";

  switch (var_0.name) {
    case "apc":
      var_2 = "vfx_sc_steam_vent_elevator_med_01";
      break;
    case "jackal":
      var_2 = "vfx_sc_steam_vent_elevator_lrg_01";
      break;
    case "dropship":
      var_2 = "vfx_sc_steam_vent_elevator_lrg_01";
      break;
    case "flight":
      var_2 = "vfx_sc_steam_vent_elevator_lrg_01";
      break;
    case "gravity":
      var_2 = "vfx_sc_steam_vent_elevator_grav_01";
      break;
    case "magazine":
      var_2 = "vfx_sc_steam_vent_elevator_rect_01";
      break;
    case "magazine_flight":
      var_2 = "vfx_sc_steam_vent_elevator_rect_01";
      break;
  }

  while(!isDefined(var_0._id_4B10))
    scripts\engine\utility::waitframe();

  if(var_0._id_4B10 != self._id_EE52) {
    playFXOnTag(scripts\engine\utility::getfx(var_2), var_1, "tag_origin");
    self._id_75C2 = 1;
  }

  for(;;) {
    var_3 = var_0 scripts\engine\utility::waittill_any_return("doors_open", "doors_close");

    if(var_0._id_4B10 == self._id_EE52 && var_3 == "doors_open") {
      stopFXOnTag(scripts\engine\utility::getfx(var_2), var_1, "tag_origin");
      self._id_75C2 = undefined;
      continue;
    }

    if(!isDefined(self._id_75C2)) {
      scripts\engine\utility::noself_delaycall(2, ::playfxontag, scripts\engine\utility::getfx(var_2), var_1, "tag_origin");
      self._id_75C2 = 1;
    }
  }
}

_id_6105() {
  self endon("death");
  self._id_BC6E = 150;

  for(;;) {
    if(level.player istouching(self.trigger) && !self._id_D1DC || isDefined(self._id_BC8B)) {
      var_0 = scripts\engine\utility::array_find(self._id_6F67, self._id_4B10);

      if(var_0 == 0) {
        if(self._id_6084.alpha == 0)
          self._id_6084.alpha = 1;
      } else if(var_0 == self._id_6F67.size - 1) {
        if(self._id_6084.alpha == 0)
          self._id_6084.alpha = 1;
      } else if(self._id_6084.alpha == 0)
        self._id_6084.alpha = 1;

      if(_id_60EF() || _id_60EE() || isDefined(self._id_BC8B)) {
        var_1 = undefined;

        if(!isDefined(self._id_BC8B))
          var_1 = self._id_32DB;
        else
          var_1 = scripts\engine\utility::array_find(self._id_6F67, self._id_BC8B);

        self._id_BC8B = undefined;
        self._id_32DB = undefined;
        self notify("doors_close");
        self._id_6084.alpha = 0;
        self waittill("doors_finished");
        self._id_BE5F _meth_83C9();

        if(isDefined(self._id_BE60))
          self._id_BE60 _meth_83C9();

        thread _id_60FF("start");
        thread _id_60FC();
        self._id_528D = self._id_6F67[var_1];
        _id_0EE4::_id_EFEB(self._id_6F68[var_1].origin - self.origin[2], self._id_BC6E);
        thread _id_60FC();
        thread _id_60FF("stop");
        self._id_4B10 = self._id_6F67[var_1];
        self notify("doors_open");
        self waittill("doors_finished");
        self._id_BE5F _meth_80AF(undefined);

        if(isDefined(self._id_BE60))
          self._id_BE60 _meth_80AF(undefined);

        self notify("move_finished");
        level notify("elevator_finished");
      } else
        scripts\engine\utility::waitframe();

      scripts\engine\utility::waitframe();
    } else
      self._id_6084.alpha = 0;

    scripts\engine\utility::waitframe();
  }
}

_id_60EF() {
  var_0 = 200;
  var_1 = gettime();

  if(level.player secondaryoffhandbuttonPressed()) {
    while(level.player secondaryoffhandbuttonPressed()) {
      if(gettime() - var_1 >= var_0) {
        var_2 = scripts\engine\utility::array_find(self._id_6F67, self._id_4B10);

        if(var_2 > 0) {
          self._id_32DB = var_2 - 1;
          return 1;
        }
      }

      scripts\engine\utility::waitframe();
    }
  }

  return 0;
}

_id_60EE() {
  var_0 = 200;
  var_1 = gettime();

  if(level.player fragButtonPressed()) {
    while(level.player fragButtonPressed()) {
      if(gettime() - var_1 >= var_0) {
        var_2 = scripts\engine\utility::array_find(self._id_6F67, self._id_4B10);

        if(var_2 < self._id_6F67.size - 1) {
          self._id_32DB = var_2 + 1;
          return 1;
        }
      }

      scripts\engine\utility::waitframe();
    }
  }

  return 0;
}

_id_60FC() {
  self endon("death");

  if(level.player istouching(self.trigger))
    screenshake(level.player.origin, 0.2, 0.2, 0.2, 0.2, 0, 0, 0, 12, 12, 12);
}

_id_60F4(var_0) {
  self endon("death");

  for(;;) {
    var_1 = level.elevators[var_0] scripts\engine\utility::waittill_any_return("doors_open", "doors_close");
    var_2 = [];
    var_3 = self.doors;

    if(isDefined(self._id_AEF3[self._id_4B10])) {
      var_2 = self._id_AEF3[self._id_4B10];

      foreach(var_5 in self._id_AEF3[self._id_4B10]) {
        var_6 = scripts\engine\utility::array_find(var_3, var_5);
        var_3 = scripts\sp\utility::array_remove_index(var_3, var_6);
      }
    }

    if(_id_582A(var_0, self._id_4B10))
      wait 0.5;

    switch (var_1) {
      case "doors_open":
        if(!isDefined(self._id_BFEA)) {
          foreach(var_5 in var_3) {
            if(isDefined(self.anims))
              self setanimknob(self.anims[var_5 + "_lower"], 1);

            if(isDefined(self._id_5989))
              self._id_5989[var_5] notsolid();
          }

          thread _id_60FF("open");

          if(isDefined(self.anims)) {
            wait(getanimlength(self.anims["2_lower"]));
            self._id_5A4C = "open";
          }
        }

        self notify("doors_finished");
        break;
      case "doors_close":
        if(!isDefined(self._id_BFEA)) {
          if(isDefined(self._id_5989))
            scripts\engine\utility::array_call(self._id_5989, ::solid);

          foreach(var_5 in var_3) {
            if(isDefined(self.anims))
              self setanimknob(self.anims[var_5 + "_raise"], 1);
          }

          thread _id_60FF("close");

          if(isDefined(self.anims)) {
            wait(getanimlength(self.anims["2_raise"]));
            self._id_5A4C = "closed";
          }
        }

        self notify("doors_finished");
        break;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_60F3(var_0) {
  var_1 = _id_7976(var_0);

  if(isDefined(var_1.anims)) {
    foreach(var_3 in var_1.doors) {
      var_1 _meth_82A2(var_1.anims[var_3 + "_raise"], 1);
      var_1 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_1.anims[var_3 + "_raise"], 1);
    }
  }
}

_id_6102(var_0, var_1) {
  _id_7976(var_0)._id_FB2F = var_1;
}

_id_60FF(var_0) {
  if(!isDefined(self._id_FB2F)) {
    return;
  }
  switch (var_0) {
    case "start":
      self playSound(self._id_FB2F["start"]);
      self playLoopSound(self._id_FB2F["start_loop"]);
      break;
    case "stop":
      if(isDefined(self._id_FB2F["stop_beep"])) {}

      self playSound(self._id_FB2F["stop"]);
      self stoploopsound();
      break;
    case "close":
      if(self._id_5A4C != "closed")
        self playSound(self._id_FB2F["close"]);

      break;
    case "open":
      if(self._id_5A4C != "open") {
        if(isDefined(self._id_FB2F["open"]))
          thread scripts\engine\utility::play_sound_in_space(self._id_FB2F["open"], self.origin - (100, 100, 0));
      }

      break;
  }
}

_id_60FD(var_0, var_1, var_2, var_3) {
  var_4 = _id_7976(var_0);

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 1;

  if(var_2) {
    foreach(var_6 in var_4._id_6F68) {
      if(!isDefined(var_6._id_EE52)) {
        return;
      }
      if(var_6._id_EE52 == var_1) {
        while(var_4._id_32D7)
          scripts\engine\utility::waitframe();

        var_4._id_32D7 = 1;

        if(var_3) {
          var_4._id_BE5F _meth_83C9();

          if(isDefined(var_4._id_BE60))
            var_4._id_BE60 _meth_83C9();
        }

        var_4.origin = var_6.origin;
        var_4._id_4B10 = var_6._id_EE52;
        var_4._id_BE5F scripts\engine\utility::delaycall(0.05, ::_meth_80AF);

        if(isDefined(var_4._id_BE60))
          var_4._id_BE60 scripts\engine\utility::delaycall(0.05, ::_meth_80AF);

        var_4 scripts\engine\utility::delaythread(0.05, scripts\sp\utility::_id_F225, "doors_open");
        var_4 scripts\engine\utility::delaythread(0.05, ::_id_60F2, var_0);
        break;
      }
    }
  } else
    var_4._id_BC8B = var_1;
}

_id_60F2(var_0) {
  var_1 = _id_7976(var_0);
  var_1._id_32D7 = 0;
}

_id_60F0(var_0, var_1) {
  var_2 = _id_7976(var_0);
  var_2._id_C38A = var_2._id_BC6E;
  var_2._id_BC6E = var_1;
}

_id_60F1(var_0) {
  var_1 = _id_7976(var_0);
  var_1._id_BC6E = var_1._id_C38A;
}

_id_7976(var_0) {
  return level.elevators[var_0];
}

_id_60FB(var_0, var_1, var_2) {
  var_3 = _id_7976(var_0);
  var_3._id_AEF3[var_1] = strtok(var_2, ",");
}

_id_60FE(var_0, var_1) {
  _id_7976(var_0)._id_D1DC = var_1;
}

_id_60FA(var_0, var_1) {
  var_2 = _id_7976(var_0);
}

_id_6103(var_0, var_1, var_2) {
  precachemodel("shipcrib_screen_heavy_duty_monitor");
  var_3 = _id_7976(var_0);
  var_4 = getnumparts(var_3.model);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    var_6 = getpartname(var_3.model, var_5);

    if(getsubstr(var_6, 0, var_2.size) == var_2) {
      var_7 = spawn("script_model", var_3 gettagorigin(var_6));
      var_7.angles = var_3 gettagangles(var_6);
      var_7 setModel(var_1);
      var_7 dontcastshadows();
      var_7 linkTo(var_3);
      var_7 _meth_8184();
      var_7 _id_0EF5::_id_FDF2();
      var_7 thread _id_0EF5::_id_FDF8();
    }
  }
}

_id_7873(var_0, var_1) {
  var_2 = _id_7976(var_0);

  if(!isDefined(var_2._id_2C3F))
    return undefined;

  var_3 = [];

  foreach(var_5 in var_2._id_2C3F) {
    if(var_5._id_EE52 == var_1)
      var_3 = scripts\engine\utility::array_add(var_3, var_5);
  }

  if(var_3.size > 0)
    return var_3;
  else
    return undefined;
}

_id_60EC(var_0, var_1, var_2) {
  var_3 = _id_7873(var_0, var_1);

  if(!isDefined(var_3)) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = 1.25;

  foreach(var_5 in var_3) {
    if(isDefined(var_5._id_EE59) && var_5._id_EE59 == "collision_wall") {
      var_5 solid();
      continue;
    }

    var_5 moveTo(var_5._id_12D74, var_2);
  }

  wait(var_2);
}

_id_60EB(var_0, var_1, var_2) {
  var_3 = _id_7873(var_0, var_1);

  if(!isDefined(var_3)) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = 1.25;

  foreach(var_5 in var_3) {
    if(isDefined(var_5._id_EE59) && var_5._id_EE59 == "collision_wall") {
      var_5 solid();
      continue;
    }

    var_5 moveTo(var_5._id_5AF1, var_2);
  }

  wait(var_2);
}

_id_7C38(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(isDefined(var_3._id_EE52)) {
      if(var_3._id_EE52 == var_1)
        return var_3;
    }
  }
}

_id_7C37(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_4._id_EE52)) {
      if(var_4._id_EE52 == var_1)
        var_2 = scripts\engine\utility::array_add(var_2, var_4);
    }
  }

  return var_2;
}

_id_7C39(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(isDefined(var_3._id_EE52)) {
      if(getsubstr(var_3._id_EE52, 0, var_1.size) != var_1)
        var_0 = scripts\engine\utility::array_remove(var_0, var_3);
    }
  }

  return var_0;
}

_id_6100(var_0, var_1) {
  _id_7976(var_0).anims = var_1;
}

_id_6101(var_0, var_1) {
  var_2 = _id_7976(var_0);
  var_2.doors = var_1;

  foreach(var_4 in var_2.doors)
  var_2._id_5989[var_4] = _id_7C38(var_2.collision, "collision_" + var_4);

  var_2 thread _id_60F3(var_0);
}

_id_582A(var_0, var_1) {
  self endon("death");

  foreach(var_3 in self._id_2C3F) {
    if(level.elevators[var_0]._id_4B10 == var_3._id_EE52)
      return 1;
  }

  return 0;
}

_id_60F6() {
  self endon("death");

  if(scripts\engine\utility::flag_exist(level.script + "_prime_in_tr_loaded"))
    scripts\engine\utility::flag_wait(level.script + "_prime_in_tr_loaded");
  else if(scripts\engine\utility::flag_exist(level.script + "_prime_tr_loaded"))
    scripts\engine\utility::flag_wait(level.script + "_prime_tr_loaded");

  _id_60F5();
  self showpart("tag_bridge_deck", self.model);
  var_0 = getEnt("bridge_elevator_floor_level_04", "targetname");
  var_1 = getEnt("bridge_elevator_floor_level_03", "targetname");
  var_2 = getEnt("bridge_elevator_floor_level_02", "targetname");
  var_3 = getEnt("bridge_elevator_floor_level_01", "targetname");
  var_4 = getEnt("bridge_elevator_floor_bridge_deck", "targetname");
  var_5 = getEnt("return_elevator_floor_spar_deck", "targetname");
  var_6 = getEnt("return_elevator_floor_quarter_deck", "targetname");
  var_7 = getEnt("return_elevator_floor_level_04", "targetname");
  var_8 = getEnt("return_elevator_floor_level_03", "targetname");
  var_9 = getEnt("return_elevator_floor_level_02", "targetname");
  var_10 = getEnt("return_elevator_floor_level_01", "targetname");
  var_11 = getEnt("return_elevator_floor_flight_deck", "targetname");
  var_12 = getEnt("return_elevator_floor_bridge_deck", "targetname");

  for(;;) {
    if(self istouching(var_11)) {
      _id_60F5();
      self showpart("tag_flight_deck", self.model);
      _id_60F7(var_11);
    } else if(self istouching(var_10)) {
      _id_60F5();
      self showpart("tag_level_01", self.model);
      _id_60F7(var_10);
    } else if(self istouching(var_9)) {
      _id_60F5();
      self showpart("tag_level_02", self.model);
      _id_60F7(var_9);
    } else if(self istouching(var_8)) {
      _id_60F5();
      self showpart("tag_level_03", self.model);
      _id_60F7(var_8);
    } else if(self istouching(var_7)) {
      _id_60F5();
      self showpart("tag_level_04", self.model);
      _id_60F7(var_7);
    } else if(self istouching(var_6)) {
      _id_60F5();
      self showpart("tag_quarter_deck", self.model);
      _id_60F7(var_6);
    } else if(self istouching(var_5)) {
      _id_60F5();
      self showpart("tag_spar_deck", self.model);
      _id_60F7(var_5);
    } else if(self istouching(var_12)) {
      _id_60F5();
      self showpart("tag_bridge_deck", self.model);
      _id_60F7(var_12);
    } else if(self istouching(var_3)) {
      _id_60F5();
      self showpart("tag_level_01", self.model);
      _id_60F7(var_3);
    } else if(self istouching(var_2)) {
      _id_60F5();
      self showpart("tag_level_02", self.model);
      _id_60F7(var_2);
    } else if(self istouching(var_1)) {
      _id_60F5();
      self showpart("tag_level_03", self.model);
      _id_60F7(var_1);
    } else if(self istouching(var_0)) {
      _id_60F5();
      self showpart("tag_level_04", self.model);
      _id_60F7(var_0);
    }

    scripts\engine\utility::waitframe();
  }
}

_id_60F5() {
  self endon("death");
  self hidepart("tag_spar_deck", self.model);
  self hidepart("tag_quarter_deck", self.model);
  self hidepart("tag_level_04", self.model);
  self hidepart("tag_level_03", self.model);
  self hidepart("tag_level_02", self.model);
  self hidepart("tag_level_01", self.model);
  self hidepart("tag_flight_deck", self.model);
  self hidepart("tag_bridge_deck", self.model);
}

_id_60F7(var_0) {
  self endon("death");

  switch (var_0.targetname) {
    case "bridge_elevator_floor_bridge_deck":
      if(isDefined(self._id_528D) && self._id_528D == "Bridge Level") {
        scripts\sp\utility::play_sound_on_tag(self._id_FB2F["stop_beep"], "tag_bridge_deck");
        break;
      }
    case "bridge_elevator_floor_level_01":
      if(isDefined(self._id_528D) && self._id_528D == "Mezzanine") {
        scripts\sp\utility::play_sound_on_tag(self._id_FB2F["stop_beep"], "tag_bridge_deck");
        break;
      }
    case "return_elevator_floor_bridge_deck":
      if(isDefined(self._id_528D) && self._id_528D == "Bridge Level") {
        scripts\sp\utility::play_sound_on_tag(self._id_FB2F["stop_beep"], "tag_bridge_deck");
        break;
      }
    case "return_elevator_floor_flight_deck":
      if(isDefined(self._id_528D) && self._id_528D == "Flight Deck") {
        scripts\sp\utility::play_sound_on_tag(self._id_FB2F["stop_beep"], "tag_bridge_deck");
        break;
      }
    default:
      scripts\sp\utility::play_sound_on_tag("shipcrib_elevator_floor_indicator_beep", "tag_bridge_deck");
      break;
  }

  while(self istouching(var_0))
    scripts\engine\utility::waitframe();
}