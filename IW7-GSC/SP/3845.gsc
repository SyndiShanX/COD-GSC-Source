/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3845.gsc
**************************************/

_id_FCF3() {
  precachemodel("door_metal_double_sliding_keypad");
}

#using_animtree("script_model");

_id_95B6(var_0) {
  if(!level.player scripts\sp\utility::_id_65DF("zero_gravity"))
    level.player scripts\sp\utility::_id_65E0("zero_gravity");

  level thread _id_DE5A();
  level._id_E99C = getEntArray("sa_door_in_use_trigger", "script_noteworthy");
  level._id_E99D = [];
  level._id_E99E = [];
  level._id_E9CB = 99;
  level._id_E9E8 = 1;
  _id_5983();

  if(!isDefined(level._id_5A3E))
    level._id_5A3E = 0;

  var_1 = getEntArray("sa_door", "script_noteworthy");
  var_2 = [];

  foreach(var_4 in level._id_E99C) {
    foreach(var_6 in var_1) {
      if(var_6 istouching(var_4)) {
        var_6._id_E99B = var_4;
        var_4._id_5978 = var_6;
        var_2 = scripts\engine\utility::add_to_array(var_2, var_6);
        var_1 = scripts\engine\utility::array_remove(var_1, var_6);

        foreach(var_8 in level._id_E6E0) {
          if(isDefined(var_4.target)) {
            var_4._id_59BC = scripts\engine\utility::getStructArray(var_4.target, "targetname");

            foreach(var_10 in var_4._id_59BC) {
              if(ispointinvolume(var_10.origin, var_8)) {
                if(!isDefined(var_8.doors))
                  var_8.doors = [];

                var_8.doors = scripts\engine\utility::array_add(var_8.doors, var_6);

                if(isDefined(var_10.target)) {
                  var_11 = getEnt(var_10.target, "targetname");

                  if(!isDefined(var_6._id_C983))
                    var_6._id_C983 = [];

                  var_6._id_C983[var_8.targetname] = var_11;
                }
              }
            }
          }
        }
      }
    }
  }

  foreach(var_6 in var_1) {
    if(isDefined(var_6) && isDefined(var_6.target)) {
      var_6.right = _id_7987(var_6.target, "targetname", "right");

      if(isDefined(var_6.right)) {
        var_6.right _id_8ED3("tag_screen_open");
        var_6.right _id_8ED3("tag_screen_restricted");

        if(isDefined(var_6.right.target)) {
          var_6.right._id_C745 = getEnt(var_6.right.target, "targetname");

          if(isDefined(var_6.right._id_C745)) {
            var_6.right._id_C745 linkTo(var_6.right, "tag_origin", (0, 0, 0), (0, 0, 0));
            var_6.right._id_C745 _id_8ED3("tag_screen_open");
            var_6.right._id_C745 _id_8ED3("tag_screen_restricted");
          }
        }
      }
    }
  }

  foreach(var_6 in var_2) {
    var_6._id_5A57 = var_6.script_parameters;

    if(isDefined(var_6.model)) {
      var_6._id_1FBB = "door";
      var_6 _meth_83D0(#animtree);
    }

    var_6 scripts\sp\utility::_id_65E0("player_at_door");
    var_6 scripts\sp\utility::_id_65E0("begin_opening");
    var_6 scripts\sp\utility::_id_65E0("door_opened");
    var_6 scripts\sp\utility::_id_65E0("door_sequence_complete");
    var_6 scripts\sp\utility::_id_65E0("locked");
    var_19 = var_6 scripts\sp\utility::_id_7A8F();
    var_19 = scripts\engine\utility::array_combine(var_19, var_6 scripts\sp\utility::_id_7A97());
    var_19 = scripts\engine\utility::array_combine(var_19, var_6 _id_5996());

    foreach(var_21 in var_19) {
      if(isDefined(var_21.script_parameters)) {
        switch (var_21.script_parameters) {
          case "door_clip":
            var_6._id_5985 = var_21;
            break;
          case "sa_airlock_hack":
            var_6._id_C742 = var_21;
            break;
          case "sa_airlock_ext":
            var_6._id_C742 = var_21;
            break;
          case "sa_airlock_int":
            var_6._id_C742 = var_21;
            break;
          case "airlock_trigger":
            var_6._id_1ADF = var_21;
            break;
          case "lock_status_model":
            if(!isDefined(var_6._id_AEE1))
              var_6._id_AEE1 = [];

            var_21 linkTo(var_6, "door_jnt");
            var_6._id_AEE1 = scripts\engine\utility::array_add(var_6._id_AEE1, var_21);
            break;
          case "door_neg_begin":
            var_6._id_8B94 = 1;
            var_6._id_8B93 = 0;
            break;
          case "door_link_begin":
            var_6._id_8B93 = 1;
            var_6._id_8B94 = 0;

            if(!isDefined(var_6._id_BEA2))
              var_6._id_BEA2 = [];

            var_6._id_BEA2[var_6._id_BEA2.size] = var_21;
            break;
          case "door_nav_mod":
            if(level._id_E9E8)
              var_6._id_BE61 = var_21;
            else
              var_6._id_BE62 = var_21;

            break;
          default:
            break;
        }
      }
    }

    if(isDefined(var_6._id_E99B.script_parameters))
      var_6._id_E1B3 = var_6._id_E99B.script_parameters;

    var_6 thread door_think();
  }

  if(!isDefined(var_0) || isDefined(var_0) && var_0 == 0)
    thread _id_59AC();
}

_id_5996() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = strtok(self.script_linkto, " ");

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = getnode(var_1[var_2], "script_linkname");

      if(isDefined(var_3))
        var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

door_think() {
  if(isDefined(self._id_E99B) && isDefined(self._id_E99B.targetname))
    level._id_E99E[self._id_E99B.targetname] = self;

  if(!isDefined(level._id_E99D[self._id_5A57]))
    level._id_E99D[self._id_5A57] = spawnStruct();

  if(!isDefined(level._id_E99D[self._id_5A57].doors))
    level._id_E99D[self._id_5A57].doors = [];

  level._id_E99D[self._id_5A57].doors = scripts\engine\utility::array_add(level._id_E99D[self._id_5A57].doors, self);
  self._id_E99A = 1;

  if(isDefined(self._id_E99B._id_EF20) && isDefined(level._id_74D5[self._id_E99B._id_EF20])) {
    self thread[[level._id_74D5[self._id_E99B._id_EF20]]]();
    return;
  }

  switch (self._id_5A57) {
    case "sa_armory_loot_door":
      self._id_4386 = "j_hinge1";
      self._id_21E6 = ::_id_21E6;
      self._id_3856 = 0;
      self._id_12BD6 = _id_0B1F::_id_21E5;
      thread _id_0B1F::_id_21E0();
      self._id_4284 = 1;
      thread _id_FA68();
      break;
    case "sa_airlock_hack":
      self._id_BE88 = 1;
      thread _id_E97B();
      break;
    case "sa_airlock":
      thread _id_E97B();
      break;
    case "sa_airlock_ext":
      self._id_1ABD = 1;
      thread _id_E97B();
      break;
    case "sa_airlock_int":
      self._id_1AC2 = 1;
      thread _id_E97B();
      break;
    case "sa_bulkhead_right":
      self._id_3856 = 1;
      self._id_8FDD = "right";
      thread _id_E987();
      thread _id_FA68();
      break;
    case "sa_double_door_sliding_auto":
      self._id_262F = 1;
      self._id_3856 = 1;
      thread _id_E99F();
      break;
    case "sa_single_door_sliding_auto":
      self._id_262F = 1;
      self._id_3856 = 0;
      self._id_19CB = 1;
      self._id_12788 = 96;
      self._id_C5E0 = 0.25;
      thread _id_E99F();
      break;
  }
}

_id_21E6() {
  wait 0.05;
  self._id_4284 = undefined;
  self._id_C5D9 = 1;
  self.collision connectpaths();
  self.collision disconnectPaths();
  thread _id_5595();
}

_id_59AC() {
  if(!scripts\engine\utility::flag_exist("ship_in_lockdown"))
    scripts\engine\utility::flag_init("ship_in_lockdown");

  if(!scripts\engine\utility::flag_exist("ship_lock_doors"))
    scripts\engine\utility::flag_init("ship_lock_doors");

  for(;;) {
    scripts\engine\utility::flag_wait_any("ship_in_lockdown", "ship_lock_doors");
    _id_5A3B();

    while(scripts\engine\utility::flag("ship_in_lockdown") || scripts\engine\utility::flag("ship_lock_doors")) {
      scripts\engine\utility::flag_waitopen("ship_in_lockdown");
      scripts\engine\utility::flag_waitopen("ship_lock_doors");
    }

    _id_5A51();
  }
}

_id_5A3B() {
  var_0 = getarraykeys(level._id_E99D);

  foreach(var_2 in var_0) {
    for(var_3 = 0; var_3 < level._id_E99D[var_2].doors.size; var_3++) {
      if(isDefined(level._id_E99D[var_2].doors[var_3]._id_3856) && level._id_E99D[var_2].doors[var_3]._id_3856 == 1) {
        if(isDefined(level._id_E99D[var_2].doors[var_3]._id_E1B3)) {
          if(isDefined(level._id_E99D[var_2].doors[var_3]._id_AEE1)) {
            foreach(var_5 in level._id_E99D[var_2].doors[var_3]._id_AEE1) {}
          }

          continue;
        }

        level._id_E99D[var_2].doors[var_3] thread _id_AED6();
      }
    }
  }
}

_id_5A51() {
  var_0 = getarraykeys(level._id_E99D);

  foreach(var_2 in var_0) {
    for(var_3 = 0; var_3 < level._id_E99D[var_2].doors.size; var_3++) {
      if(isDefined(level._id_E99D[var_2].doors[var_3]._id_3856) && level._id_E99D[var_2].doors[var_3]._id_3856 == 1) {
        if(isDefined(level._id_E99D[var_2].doors[var_3]._id_E1B3)) {
          if(isDefined(level._id_E99D[var_2].doors[var_3]._id_AEE1)) {
            foreach(var_5 in level._id_E99D[var_2].doors[var_3]._id_AEE1) {}
          }

          continue;
        }

        if(!scripts\engine\utility::is_true(level._id_E99D[var_2].doors[var_3]._id_AEEC))
          level._id_E99D[var_2].doors[var_3] _id_12BD3();

        level._id_E99D[var_2].doors[var_3]._id_AEEC = undefined;
      }
    }
  }
}

_id_AED6(var_0) {
  if(isDefined(var_0))
    self._id_3856 = var_0;

  var_1 = 0;

  if(scripts\engine\utility::flag_exist("ship_in_lockdown") && scripts\engine\utility::flag("ship_in_lockdown") && scripts\engine\utility::is_true(self._id_10ED7) && scripts\engine\utility::is_true(self.opened))
    var_1 = 1;

  if(isDefined(self._id_AEDA))
    self[[self._id_AEDA]]();
  else if(!scripts\sp\utility::_id_65DB("locked")) {
    scripts\sp\utility::_id_65E1("locked");
    _id_5595();

    if(isDefined(self._id_BE61) && !var_1)
      self.collision disconnectPaths();

    if(isDefined(self._id_AEE1)) {
      if(isDefined(self._id_E1B3)) {
        foreach(var_3 in self._id_AEE1) {}
      } else {
        foreach(var_3 in self._id_AEE1) {}
      }
    }

    _id_F46F();
    _id_0E46::_id_DFE3();
  } else if(scripts\engine\utility::flag("ship_in_lockdown"))
    self._id_AEEC = 1;
}

_id_F2F6(var_0) {
  if(isDefined(var_0))
    self._id_3856 = var_0;
}

_id_F46F() {
  if(isDefined(self._id_E1B3)) {
    if(isDefined(self._id_AEF6)) {
      if(isDefined(self._id_AEF6._id_10144)) {
        foreach(var_1 in self._id_AEF6._id_10144) {
          if(isDefined(self.right)) {
            self.right _id_10145(var_1);

            if(isDefined(self.right._id_C745))
              self.right._id_C745 _id_10145(var_1);

            continue;
          }

          _id_10145(var_1);
        }
      }

      if(isDefined(self._id_AEF6._id_8ED2)) {
        foreach(var_1 in self._id_AEF6._id_8ED2) {
          if(isDefined(self.right)) {
            self.right _id_8ED3(var_1);

            if(isDefined(self.right._id_C745))
              self.right._id_C745 _id_8ED3(var_1);

            continue;
          }

          _id_8ED3(var_1);
        }
      }
    }
  } else if(isDefined(self._id_AEF9)) {
    if(isDefined(self._id_AEF9._id_10144)) {
      foreach(var_1 in self._id_AEF9._id_10144) {
        if(isDefined(self.right)) {
          self.right _id_10145(var_1);

          if(isDefined(self.right._id_C745))
            self.right._id_C745 _id_10145(var_1);

          continue;
        }

        _id_10145(var_1);
      }
    }

    if(isDefined(self._id_AEF9._id_8ED2)) {
      foreach(var_1 in self._id_AEF9._id_8ED2) {
        if(isDefined(self.right)) {
          self.right _id_8ED3(var_1);

          if(isDefined(self.right._id_C745))
            self.right._id_C745 _id_8ED3(var_1);

          continue;
        }

        _id_8ED3(var_1);
      }
    }
  }
}

_id_F5DF() {
  if(isDefined(self._id_12BDE)) {
    if(isDefined(self._id_12BDE._id_10144)) {
      foreach(var_1 in self._id_12BDE._id_10144) {
        if(isDefined(self.right)) {
          self.right _id_10145(var_1);

          if(isDefined(self.right._id_C745))
            self.right._id_C745 _id_10145(var_1);

          continue;
        }

        _id_10145(var_1);
      }
    }

    if(isDefined(self._id_12BDE._id_8ED2)) {
      foreach(var_1 in self._id_12BDE._id_8ED2) {
        if(isDefined(self.right)) {
          self.right _id_8ED3(var_1);

          if(isDefined(self.right._id_C745))
            self.right._id_C745 _id_8ED3(var_1);

          continue;
        }

        _id_8ED3(var_1);
      }
    }
  }
}

_id_8ED3(var_0) {
  if(self.classname != "script_model") {
    return;
  }
  if(isDefined(var_0)) {
    if(scripts\sp\utility::hastag(self.model, var_0))
      self hidepart(var_0, self.model);
  }
}

_id_10145(var_0) {
  if(self.classname != "script_model") {
    return;
  }
  if(isDefined(var_0)) {
    if(scripts\sp\utility::hastag(self.model, var_0))
      self showpart(var_0, self.model);
  }
}

_id_12BD3(var_0, var_1, var_2) {
  if(isDefined(var_0))
    self._id_3856 = var_0;

  self._id_10ED7 = undefined;

  if(isDefined(self._id_12BD6))
    self[[self._id_12BD6]]();
  else {
    if(!isDefined(var_1))
      var_1 = "tag_ui_front";

    if(isDefined(self._id_AEE1)) {
      foreach(var_4 in self._id_AEE1) {
        if(isDefined(self._id_E1B3)) {
          foreach(var_4 in self._id_AEE1) {}

          continue;
        }
      }
    }

    if(scripts\engine\utility::is_true(var_2))
      _id_F5DF();

    if(scripts\sp\utility::_id_65DB("locked")) {
      scripts\sp\utility::_id_65DD("locked");
      _id_6249();

      if(isDefined(self._id_BE61))
        self.collision connectpaths();

      _id_F5DF();
      thread scripts\sp\utility::play_sound_on_entity("sa_breach_door_open");

      if(!isDefined(self._id_262F))
        _id_0E46::_id_48C4(var_1);
    }
  }
}

_id_599E() {
  return scripts\sp\utility::_id_65DB("locked");
}

_id_F5B5() {
  if(isDefined(level._id_1640) && level._id_1640.size > 1) {
    var_0 = getEnt(level._id_1640[0], "targetname");
    var_1 = getEnt(level._id_1640[1], "targetname");

    if(isDefined(var_0.doors) && isDefined(var_1.doors)) {
      foreach(var_3 in var_0.doors) {
        var_4 = 1;

        if(isDefined(var_3._id_3856))
          var_4 = var_3._id_3856;

        if(var_4 && scripts\engine\utility::array_contains(var_0.doors, var_3) && scripts\engine\utility::array_contains(var_1.doors, var_3)) {
          var_3._id_10ED7 = 1;
          continue;
        }

        var_3._id_10ED7 = undefined;
      }
    }
  }
}

_id_FA68() {
  if(isDefined(self._id_BE61)) {
    self.collision connectpaths();
    _id_6249();
  } else if(isDefined(self._id_8B94) && self._id_8B94) {
    self._id_C02B = [];
    var_0 = getnodesinradius(self.origin, 96, 0, 48, "begin");

    foreach(var_2 in var_0) {
      if(isDefined(var_2.animscript) && var_2.animscript == "ship_assault_autotraverse") {
        var_2._id_A4DF = scripts\engine\utility::getStruct(var_2.target, "targetname");
        self._id_C02B[self._id_C02B.size] = var_2;
      }
    }

    if(self._id_C02B.size > 0) {
      _id_6249();
      return;
    }
  } else if(isDefined(self._id_8B93) && self._id_8B93) {
    self._id_AD01 = [];

    foreach(var_5 in self._id_BEA2) {
      var_5._id_A4DF = scripts\engine\utility::getStruct(var_5.target, "targetname");
      self._id_AD01[self._id_AD01.size] = var_5;
    }

    if(self._id_AD01.size > 0)
      _id_6249();
  }
}

_id_5595() {
  if(isDefined(self._id_AD38)) {
    foreach(var_1 in self._id_AD38)
    destroynavlink(var_1);

    self._id_AD38 = undefined;
  }
}

_id_6249() {
  if(scripts\sp\utility::_id_65DB("locked") && !isDefined(self._id_A598)) {
    return;
  }
  if(isDefined(self._id_BE61))
    self._id_428A = gettime();
  else if(!isDefined(self._id_AD38) && isDefined(self._id_C02B)) {
    self._id_AD38 = [];

    foreach(var_1 in self._id_C02B) {
      var_2 = "link" + level._id_E9CB;
      level._id_E9CB++;
      self._id_AD38[self._id_AD38.size] = var_2;
      var_3 = var_1._id_A4DF.origin;
      createnavlink(var_2, var_1.origin, var_3, var_1);
      self._id_428A = gettime();
    }
  } else if(!isDefined(self._id_AD38) && isDefined(self._id_AD01)) {
    self._id_AD38 = [];

    foreach(var_6 in self._id_AD01) {
      var_2 = "link" + level._id_E9CB;
      level._id_E9CB++;
      self._id_AD38[self._id_AD38.size] = var_2;
      var_3 = var_6._id_A4DF.origin;
      createnavlink(var_2, var_6.origin, var_3, "ship_assault_autotraverse", 2);
      self._id_428A = gettime();
    }
  }
}

_id_D0A5(var_0) {
  level notify("unlock_doorkey", var_0);
}

_id_137CC() {
  for(;;) {
    level waittill("unlock_doorkey", var_0);

    if(self._id_E1B3 == var_0) {
      self._id_A598 = 1;
      _id_6249();

      if(isDefined(self._id_BE61))
        self.collision connectpaths();

      return;
    }
  }
}

_id_E99F() {
  level.player endon("death");
  self._id_126C9 = [];
  self._id_126C9[0] = _id_7987(self.target, "targetname", "path_right");
  self._id_126C9[1] = _id_7987(self.target, "targetname", "path_left");
  self.left = _id_7987(self.target, "targetname", "left");

  if(isDefined(self.left)) {
    if(isDefined(self.left.target)) {
      self.left._id_C745 = getEnt(self.left.target, "targetname");

      if(isDefined(self.left._id_C745))
        self.left._id_C745 linkTo(self.left, "tag_origin", (0, 0, 0), (0, 0, 0));
    }
  }

  self.right = _id_7987(self.target, "targetname", "right");

  if(isDefined(self.right)) {
    self.right _id_8ED3("tag_screen_open");
    self.right _id_8ED3("tag_screen_restricted");
    self.right _id_8ED3("tag_screen_locked");

    if(isDefined(self.right.target)) {
      self.right._id_C745 = getEnt(self.right.target, "targetname");

      if(isDefined(self.right._id_C745)) {
        self.right._id_C745 linkTo(self.right, "tag_origin", (0, 0, 0), (0, 0, 0));
        self.right._id_C745 _id_8ED3("tag_screen_open");
        self.right._id_C745 _id_8ED3("tag_screen_restricted");
        self.right._id_C745 _id_8ED3("tag_screen_locked");
      }
    }
  }

  self.collision = _id_7987(self.target, "targetname", "collision");

  if(!isDefined(self.collision)) {}

  if(!isDefined(self._id_12788))
    self._id_12788 = 128;

  self._id_B46A = 64;

  if(!isDefined(self._id_C5E0))
    self._id_C5E0 = 0.5;

  self._id_C5DF = 62;
  self._id_4284 = 1;
  self._id_12BDE = spawnStruct();
  self._id_12BDE._id_10144 = [];
  self._id_12BDE._id_8ED2 = [];
  self._id_12BDE._id_10144 = scripts\engine\utility::array_add(self._id_12BDE._id_10144, "tag_screen_open");
  self._id_12BDE._id_8ED2 = scripts\engine\utility::array_add(self._id_12BDE._id_8ED2, "tag_screen_locked");
  self._id_12BDE._id_8ED2 = scripts\engine\utility::array_add(self._id_12BDE._id_8ED2, "tag_screen_restricted");
  self._id_AEF9 = spawnStruct();
  self._id_AEF9._id_10144 = [];
  self._id_AEF9._id_8ED2 = [];
  self._id_AEF9._id_10144 = scripts\engine\utility::array_add(self._id_AEF9._id_10144, "tag_screen_locked");
  self._id_AEF9._id_8ED2 = scripts\engine\utility::array_add(self._id_AEF9._id_8ED2, "tag_screen_open");
  self._id_AEF9._id_8ED2 = scripts\engine\utility::array_add(self._id_AEF9._id_8ED2, "tag_screen_restricted");
  self._id_AEF6 = spawnStruct();
  self._id_AEF6._id_10144 = [];
  self._id_AEF6._id_8ED2 = [];
  self._id_AEF6._id_10144 = scripts\engine\utility::array_add(self._id_AEF6._id_10144, "tag_screen_restricted");
  self._id_AEF6._id_8ED2 = scripts\engine\utility::array_add(self._id_AEF6._id_8ED2, "tag_screen_open");
  self._id_AEF6._id_8ED2 = scripts\engine\utility::array_add(self._id_AEF6._id_8ED2, "tag_screen_locked");
  _id_FA68();

  if(isDefined(self._id_E1B3)) {
    thread _id_137CC();
    _id_AED6();
  } else
    _id_12BD3(undefined, undefined, 1);

  for(;;) {
    level.player scripts\sp\utility::_id_65E8("zero_gravity");

    if(_id_FF71()) {
      _id_E9A2();

      if(scripts\engine\utility::is_true(self._id_C611)) {
        break;
      }
    }

    if(_id_FF1F())
      _id_E9A0();

    wait 0.05;
  }
}

_id_E9A1(var_0) {
  var_1 = var_0 scripts\sp\utility::_id_7A8F();

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_parameters)) {
      switch (var_3.script_parameters) {
        case "lock_status_model":
          if(!isDefined(self._id_AEE1))
            self._id_AEE1 = [];

          var_3 linkTo(var_0);
          self._id_AEE1 = scripts\engine\utility::array_add(self._id_AEE1, var_3);
          break;
        default:
          break;
      }
    }
  }
}

_id_FF71() {
  if(isDefined(self.scripted) && self.scripted == 1)
    return 0;

  if(isDefined(self._id_C62C) && self._id_C62C == 1)
    return 0;

  if(isDefined(self.opened) && self.opened == 1)
    return 0;

  if(isDefined(self._id_10ED7) && self._id_10ED7 == 1)
    return 1;

  if(scripts\engine\utility::is_true(self._id_19CB)) {
    if(_id_1D2E())
      return 1;

    return 0;
  }

  if(scripts\engine\utility::flag("ship_in_lockdown"))
    return 0;

  if(distance2dsquared(self.origin, level.player.origin) < self._id_12788 * self._id_12788 && _id_3DA3(self.origin, level.player.origin, self._id_B46A)) {
    if(isDefined(self._id_4284) && self._id_4284 == 1) {
      if(level.player _id_0E29::_id_87BA())
        return 0;

      if(!isDefined(self._id_E1B3)) {
        if(scripts\sp\utility::_id_65DB("locked"))
          return 0;

        return 1;
      }

      if(!_id_0F10::_id_E1B4())
        return 0;
    }
  }

  if(scripts\sp\utility::_id_65DB("locked"))
    return 0;

  if(_id_1D2E())
    return 1;

  return 0;
}

_id_FF1F() {
  if(isDefined(self.scripted) && self.scripted == 1)
    return 0;

  if(isDefined(self._id_42AF) && self._id_42AF == 1)
    return 0;

  if(isDefined(self._id_4284) && self._id_4284 == 1)
    return 0;

  if(isDefined(self._id_10ED7) && self._id_10ED7 == 1)
    return 0;

  if(scripts\engine\utility::is_true(self._id_19CB)) {
    if(isDefined(self.opened) && self.opened == 1) {
      if(_id_1D2E(1))
        return 0;

      return 1;
    }

    return 0;
  }

  if(scripts\sp\utility::_id_65DB("locked")) {
    thread _id_415A();
    return 1;
  }

  if(distance2dsquared(self.origin, level.player.origin) > self._id_12788 * self._id_12788 || !_id_3DA3(self.origin, level.player.origin, self._id_B46A)) {
    if(isDefined(self.opened) && self.opened == 1) {
      if(_id_1D2E(1))
        return 0;

      return 1;
    }
  }

  return 0;
}

_id_415A() {
  var_0 = 128;
  var_1 = var_0 * var_0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  while(!(isDefined(self._id_4284) && self._id_4284 == 1)) {
    if(scripts\engine\utility::is_true(self._id_10ED7)) {
      break;
    }

    var_5 = getaiarray("allies", "axis", "team3");
    var_5[var_5.size] = level.player;
    var_5 = sortbydistance(var_5, self.origin);
    var_6 = 0;

    foreach(var_8 in var_5) {
      if(distance2dsquared(var_8.origin, self.origin) > var_1) {
        break;
      }

      if(var_8 istouching(self.collision)) {
        var_9 = anglestoright(self.angles);
        var_10 = vectorNormalize(var_9);
        var_11 = 1;

        if(distance2dsquared(var_8.origin, self.origin + var_10) > distance2dsquared(var_8.origin, self.origin - var_10))
          var_10 = var_10 * -1;

        if(!var_4 && isPlayer(var_8)) {
          var_10 = var_10 * 70;
          var_10 = var_10 + (0, 0, 1);
          var_6 = 1;
          var_8 _meth_8251(var_10, 1);
          waittillframeend;
          level.player setvelocity(var_10);
          var_3 = 1;
          self.collision notsolid();
        } else if(!isPlayer(var_8)) {
          var_14 = var_8.origin + var_10 * 8;
          var_8 _meth_80F1(var_14, var_8.angles, 64);
        }
      }
    }

    if(!var_4 && var_3 && !var_6) {
      level.player _meth_8251((0, 0, 0));
      var_3 = 0;
      self.collision solid();
      var_4 = 1;
      level.player setvelocity((0, 0, 0));
    }

    wait 0.05;
  }

  if(var_3) {
    level.player _meth_8251((0, 0, 0));
    self.collision solid();
  }

  if(scripts\engine\utility::is_true(self._id_10ED7))
    self.collision notsolid();
}

_id_1D2E(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  var_1 = self._id_12788;
  var_2 = self.origin;

  if(var_0)
    var_1 = var_1 * 2;

  var_3 = getaiarray("allies", "axis", "team3");
  var_3 = sortbydistance(var_3, self.origin);
  var_4 = 0;

  if(isDefined(var_3) && var_3.size > 0) {
    for(var_5 = var_1 * var_1; var_4 < var_3.size && distancesquared(var_2, var_3[var_4].origin) < var_5; var_4++) {
      if(var_0 || level._id_5A3E || _id_9C60(var_3[var_4]))
        return 1;
    }
  }

  return 0;
}

_id_9C60(var_0) {
  if(!level._id_E9E8)
    return 1;

  if(isDefined(var_0._id_A8AE) && var_0._id_A8AE == self && var_0._id_A8B0 > gettime())
    return 1;

  if(!isDefined(var_0.pathgoalpos))
    return 0;

  var_1 = undefined;
  var_1 = var_0 _meth_855B("door", 256);

  if(!isDefined(var_1))
    return 0;

  var_2 = _id_0F16::_id_7B0D(var_1);

  if(isDefined(var_2)) {
    if(var_2 == self) {
      var_0._id_A8AE = var_2;
      var_0._id_A8B0 = gettime() + 3000;
      return 1;
    }
  }

  return 0;
}

_id_3DA3(var_0, var_1, var_2) {
  var_3 = var_0 - var_1;

  if(var_3[2] * var_3[2] <= var_2 * var_2)
    return 1;
  else
    return 0;
}

_id_E9A2() {
  self._id_4284 = undefined;
  self._id_42AF = undefined;
  self._id_C62C = 1;
  _id_5595();
  level notify("update_objective_path_now");
  setumbraportalstate(self.target, 1);
  self.left moveTo(self.left.origin + anglesToForward(self.angles) * self._id_C5DF * -1, self._id_C5E0);

  if(isDefined(self.right))
    self.right moveTo(self.right.origin + anglesToForward(self.angles) * self._id_C5DF, self._id_C5E0);

  thread scripts\sp\utility::play_sound_on_entity("sa_breach_door_open");
  wait(self._id_C5E0 / 2);
  self.collision notsolid();
  self.collision connectpaths();
  wait(self._id_C5E0 / 2);
  wait 0.05;
  self.opened = 1;
  self._id_C62C = undefined;
}

_id_E9A0() {
  self.opened = undefined;
  self._id_C62C = undefined;
  self._id_42AF = 1;
  self.collision solid();

  if(!isDefined(self._id_BE61))
    self.collision disconnectPaths();

  self.left moveTo(self.left.origin + anglesToForward(self.angles) * self._id_C5DF, self._id_C5E0);

  if(isDefined(self.right))
    self.right moveTo(self.right.origin + anglesToForward(self.angles) * self._id_C5DF * -1, self._id_C5E0);

  thread scripts\sp\utility::play_sound_on_entity("sa_breach_door_close");
  wait(self._id_C5E0 + 0.05);
  setumbraportalstate(self.target, 0);
  self._id_4284 = 1;
  self._id_42AF = undefined;
  _id_6249();
}

_id_E97B() {
  self._id_12BDE = spawnStruct();
  self._id_12BDE._id_10144 = [];
  self._id_12BDE._id_8ED2 = [];
  self._id_12BDE._id_10144 = scripts\engine\utility::array_add(self._id_12BDE._id_10144, "tag_screen_open");
  self._id_12BDE._id_8ED2 = scripts\engine\utility::array_add(self._id_12BDE._id_8ED2, "tag_screen_locked");
  self._id_AEF9 = spawnStruct();
  self._id_AEF9._id_10144 = [];
  self._id_AEF9._id_8ED2 = [];
  self._id_AEF9._id_10144 = scripts\engine\utility::array_add(self._id_AEF9._id_10144, "tag_screen_locked");
  self._id_AEF9._id_8ED2 = scripts\engine\utility::array_add(self._id_AEF9._id_8ED2, "tag_screen_open");
  _id_AED6();

  if(isDefined(self._id_BE88) && self._id_BE88 == 1)
    thread _id_E97D();

  if(isDefined(self._id_1ABD) && self._id_1ABD == 1)
    thread _id_E97C();

  self setanimknob(scripts\sp\utility::_id_7DC1("airlock_open_player"), 1, 0, 0);
  self._id_AD29 = scripts\sp\utility::_id_7A97();
  self._id_1EF7 = [];

  foreach(var_1 in self._id_AD29) {
    if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == "anim_org")
      self._id_1EF7 = scripts\engine\utility::add_to_array(self._id_1EF7, var_1);
  }

  for(;;) {
    scripts\sp\utility::_id_65E8("locked");
    self waittill("trigger", var_3);

    if(isDefined(self.useperbullethitmarkers)) {
      [[self.useperbullethitmarkers]]();
      return;
    }

    self._id_1EF7 = sortbydistance(self._id_1EF7, var_3.origin);
    var_4 = undefined;
    var_5 = self;

    if(!isDefined(self._id_1EF7[0].animation)) {
      var_4 = 1;
      var_5 = self._id_1EF7[0];
    }

    var_6 = _id_D0A6(self._id_1EF7[0].animation, var_5, var_3, var_4);
    scripts\sp\utility::_id_65E1("begin_opening");
    scripts\engine\utility::delaythread(1.0, _id_0F00::_id_FC1B);

    if(isDefined(level._id_3965)) {
      switch (self.script_parameters) {
        case "sa_airlock_hack":
          if(!isDefined(level.isexposed_crouch))
            level._id_3965 notify("hide_hull");
          else
            level._id_3965 notify("show_hull");

          break;
        default:
          break;
      }
    }

    if(isDefined(var_4) && var_4 == 1) {
      if(soundexists("sa_vip_hatch_open"))
        var_3 scripts\engine\utility::delaythread(0.6, scripts\sp\utility::play_sound_on_entity, "sa_vip_hatch_open");

      self movez(88, 0.5);
      var_6 moveTo(var_6.origin + anglesToForward(var_6.angles) * 64, 2.0);
      wait 2.05;
      self.origin = self.origin + (0, 0, -88);
    } else {
      var_7 = [self, var_6];

      if(soundexists("sa_vip_hatch_open"))
        var_3 scripts\engine\utility::delaythread(0.6, scripts\sp\utility::play_sound_on_entity, "sa_vip_hatch_open");

      scripts\sp\anim::_id_1F2C(var_7, self._id_1EF7[0].animation);

      if(self._id_1EF7[0].animation == "airlock_open_pull_player") {
        wait 0.5;
        var_6 moveTo(self._id_1EF7[1].origin, 1.0);
        wait 1.05;
      }

      scripts\sp\utility::anim_stopanimScripted();
      self clearanim(scripts\sp\utility::_id_7DC1(self._id_1EF7[0].animation), 0);
    }

    var_3 _id_5990();
    var_3 unlink();
    var_6 delete();
    _id_AED6();

    switch (self.script_parameters) {
      case "sa_airlock_int":
        if(isDefined(level.isexposed_crouch) && level.isexposed_crouch) {
          self setanimknob(scripts\sp\utility::_id_7DC1("airlock_open_pull_player"), 1, 0, 0);
          level.isexposed_crouch = undefined;
        } else {
          self setanimknob(scripts\sp\utility::_id_7DC1("airlock_open_player"), 1, 0, 0);
          level.isexposed_crouch = 0;

          if(!isDefined(level._id_FE13))
            _id_10B65();
          else
            self[[level._id_FE13]]();

          if(isDefined(self._id_C742))
            self._id_C742 _id_12BD3();
        }

        break;
      case "sa_airlock_hack":
        if(isDefined(level.isexposed_crouch) && !level.isexposed_crouch) {
          level.isexposed_crouch = undefined;
          self setanimknob(scripts\sp\utility::_id_7DC1("airlock_open_player"), 1, 0, 0);
        } else {
          level.isexposed_crouch = 1;
          self setanimknob(scripts\sp\utility::_id_7DC1("airlock_open_pull_player"), 1, 0, 0);

          if(!isDefined(level._id_FE15))
            _id_10B66();
          else
            self[[level._id_FE15]]();

          if(isDefined(self._id_C742))
            self._id_C742 _id_12BD3();
        }

        break;
      case "sa_airlock_ext":
        if(isDefined(level.isexposed_crouch) && !level.isexposed_crouch) {
          level.isexposed_crouch = undefined;
          self setanimknob(scripts\sp\utility::_id_7DC1("airlock_open_player"), 1, 0, 0);
        } else {
          level.isexposed_crouch = 1;
          self setanimknob(scripts\sp\utility::_id_7DC1("airlock_open_pull_player"), 1, 0, 0);

          if(!isDefined(level._id_FE15))
            _id_10B66();
          else
            self[[level._id_FE15]]();

          if(isDefined(self._id_C742))
            self._id_C742 _id_12BD3();
        }

        break;
      default:
        break;
    }

    scripts\sp\utility::_id_65E1("door_sequence_complete");
    wait 0.05;
    scripts\sp\utility::_id_65DD("begin_opening");
    scripts\sp\utility::_id_65DD("door_sequence_complete");
  }
}

_id_10B66() {
  if(isDefined(self._id_1ADF))
    self._id_1ADF _id_D870();

  scripts\engine\utility::delaythread(1.0, _id_0F00::_id_FC1B);
}

_id_10B65(var_0) {
  scripts\engine\utility::flag_set("hack_life_support_cooling");
  scripts\engine\utility::flag_set("hack_life_support_active");
  self._id_1ADF _id_5253(var_0);
  thread scripts\sp\utility::_id_BDEC(5);
}

_id_E987() {
  self._id_4284 = 1;
  _id_FA68();
  self._id_AD29 = scripts\sp\utility::_id_7A97();
  self._id_1EF7 = [];

  foreach(var_1 in self._id_AD29) {
    if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == "anim_org")
      self._id_1EF7 = scripts\engine\utility::add_to_array(self._id_1EF7, var_1);
  }

  self._id_12BDE = spawnStruct();
  self._id_12BDE._id_10144 = [];
  self._id_12BDE._id_8ED2 = [];
  self._id_12BDE._id_10144 = scripts\engine\utility::array_add(self._id_12BDE._id_10144, "door_unlocked");
  self._id_12BDE._id_8ED2 = scripts\engine\utility::array_add(self._id_12BDE._id_8ED2, "door_locked");
  self._id_12BDE._id_8ED2 = scripts\engine\utility::array_add(self._id_12BDE._id_8ED2, "door_inactive");
  self._id_AEF9 = spawnStruct();
  self._id_AEF9._id_10144 = [];
  self._id_AEF9._id_8ED2 = [];
  self._id_AEF9._id_10144 = scripts\engine\utility::array_add(self._id_AEF9._id_10144, "door_locked");
  self._id_AEF9._id_8ED2 = scripts\engine\utility::array_add(self._id_AEF9._id_8ED2, "door_unlocked");
  self._id_AEF9._id_8ED2 = scripts\engine\utility::array_add(self._id_AEF9._id_8ED2, "door_inactive");
  self._id_5A40 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("interact_push"), self gettagangles("interact_push"));
  self._id_5A40 linkTo(self, "interact_push", (0, 0, 0), (0, 0, 0));
  self._id_5A3F = scripts\engine\utility::spawn_tag_origin(self gettagorigin("interact_pull"), self gettagangles("interact_pull"));
  self._id_5A3F linkTo(self, "interact_pull", (0, 0, 0), (0, 0, 0));
  self._id_AEDA = ::_id_E988;
  self._id_12BD6 = ::_id_E989;
  _id_12BD3();

  for(;;) {
    if(!_id_599E()) {
      if(!isDefined(self._id_5A40._id_4C1F)) {
        self._id_5A40 _id_0E46::_id_48C4("interact_push");
        self._id_5A40 thread _id_9013(self);
      }

      if(!isDefined(self._id_5A3F._id_4C1F)) {
        self._id_5A3F _id_0E46::_id_48C4("interact_pull");
        self._id_5A3F thread _id_9013(self);
      }
    }

    self waittill("trigger", var_3);
    self._id_4284 = undefined;
    self._id_5A40 _id_0E46::_id_DFE3();
    self._id_5A3F _id_0E46::_id_DFE3();
    self._id_1EF7 = sortbydistance(self._id_1EF7, var_3.origin);
    var_4 = _id_D0A6(self._id_1EF7[0].animation, self, var_3);
    scripts\sp\utility::_id_65E1("begin_opening");
    var_5 = [self, var_4];

    if(soundexists("zerog_breach_airlock_door_open"))
      var_3 thread scripts\sp\utility::play_sound_on_entity("zerog_breach_airlock_door_open");

    scripts\sp\anim::_id_1F2C(var_5, self._id_1EF7[0].animation);
    var_3 _id_5990();
    var_3 unlink();
    var_4 delete();
    scripts\sp\utility::_id_65E1("door_sequence_complete");
    waittillframeend;
    scripts\sp\utility::_id_65DD("begin_opening");
    scripts\sp\utility::_id_65DD("door_sequence_complete");
    self._id_4284 = 1;
  }
}

_id_E989() {
  scripts\sp\utility::_id_65DD("locked");
  _id_6249();

  if(isDefined(self._id_BE61))
    self.collision connectpaths();

  _id_F5DF();

  if(!isDefined(self._id_5A40._id_4C1F)) {
    self._id_5A40 _id_0E46::_id_48C4("interact_push");
    self._id_5A40 thread _id_9013(self);
  }

  if(!isDefined(self._id_5A3F._id_4C1F)) {
    self._id_5A3F _id_0E46::_id_48C4("interact_pull");
    self._id_5A3F thread _id_9013(self);
  }
}

_id_E988() {
  if(!scripts\sp\utility::_id_65DB("locked")) {
    scripts\sp\utility::_id_65E1("locked");
    _id_5595();

    if(isDefined(self._id_BE61))
      self.collision disconnectPaths();

    _id_F46F();
    self._id_5A40 _id_0E46::_id_DFE3();
    self._id_5A3F _id_0E46::_id_DFE3();
  }
}

_id_9013(var_0) {
  var_0 endon("death");
  self endon("death");
  self waittill("trigger", var_1);
  var_0 notify("trigger", var_1);
}

_id_D0A6(var_0, var_1, var_2, var_3) {
  var_4 = scripts\sp\utility::_id_10639("door_player_rig");
  var_4 hide();
  var_2 _id_598D();

  if(isDefined(var_3) && var_3 == 1) {
    var_4.origin = var_1.origin;
    var_4.angles = var_1.angles;
  } else {
    var_5 = [var_4, self];

    foreach(var_7 in var_5) {
      if(!var_7 _id_1FA3(var_0)) {
        continue;
      }
      var_1 thread scripts\sp\anim::_id_1EC3(var_7, var_0);
    }
  }

  var_9 = scripts\engine\utility::spawn_tag_origin();
  var_9.origin = var_2.origin;
  var_9.angles = var_2 getplayerangles();
  var_2 _meth_823B(var_9, "tag_origin");
  var_10 = 0.5;
  var_2 _meth_823C(var_4, "tag_player", var_10, var_10 * 0.25, var_10 * 0.25);
  wait(var_10);
  var_2 playerlinktodelta(var_4, "tag_player", 0, 5, 5, 5, 5);
  var_2 setviewangleresistance(30, 30, 30, 30);
  var_4 show();
  var_9 delete();
  return var_4;
}

_id_598D() {
  self disableweapons();
  self freezecontrols(1);
  self setstance("stand");
  self allowprone(0);
  self allowcrouch(0);
  self allowsprint(0);
  self _meth_80D1();
}

_id_5990() {
  self enableweapons();
  self allowsprint(1);
  self freezecontrols(0);
  self allowprone(1);
  self allowcrouch(1);
  self _meth_80A1();
}

_id_1FA3(var_0) {
  var_1 = level._id_EC85[self._id_1FBB][var_0];

  if(isDefined(var_1))
    return 1;

  return 0;
}

_id_5983() {
  level._id_EC85["door"]["airlock_open_player"] = % airlock_open_door;
  level._id_EC85["door"]["airlock_open_pull_player"] = % airlock_open_pull_door;
  level._id_EC85["door"]["door_right_push_player"] = % shipcrib_door_right_push_open;
  level._id_EC85["door"]["door_right_pull_player"] = % shipcrib_door_right_pull_open;
  level._id_EC87["door_hack_device"] = #animtree;
  level._id_EC8C["door_hack_device"] = "door_metal_double_sliding_keypad";
  _id_59DF();
}

#using_animtree("player");

_id_59DF() {
  level._id_EC87["door_player_rig"] = #animtree;
  level._id_EC8C["door_player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["door_player_rig"]["airlock_open_player"] = % airlock_open_player;
  level._id_EC85["door_player_rig"]["airlock_open_pull_player"] = % airlock_open_pull_player;
  level._id_EC85["door_player_rig"]["door_right_push_player"] = % shipcrib_player_door_right_push;
  level._id_EC85["door_player_rig"]["door_right_pull_player"] = % shipcrib_player_door_right_pull;
}

_id_E97D() {
  if(isDefined(self._id_E99B) && isDefined(self._id_E99B._id_EDA0))
    scripts\engine\utility::flag_wait(self._id_E99B._id_EDA0);

  _id_0E46::_id_48C4("handle_jnt", (0, -26, 0), undefined, undefined, 20000);
  self waittill("trigger", var_0);
  self._id_8797 = scripts\sp\utility::_id_10639("door_hack_device");
  self._id_8797 linkTo(self, "handle_jnt", (0, -26, 0), (0, 270, 0));
  level.player playSound("sa_found_system");
  wait 1.0;
  _id_599A(5.0, 0, 0.05, "generic");
  _id_12BD3(undefined, "tag_ui_back");
}

_id_E97C() {
  if(isDefined(self._id_E99B) && isDefined(self._id_E99B._id_EDA0))
    scripts\engine\utility::flag_wait(self._id_E99B._id_EDA0);

  _id_12BD3(undefined, "tag_ui_back");
}

_id_599A(var_0, var_1, var_2, var_3) {
  level.player playSound("sa_hack_start");
  level.player _id_0F14::_id_10DE1(var_0);
  level.player._id_DA58 settext("Hacking...");
  level.player._id_DA58.y = level.player._id_DA58.y + 15;
  var_4 = scripts\engine\utility::play_loopsound_in_space("sa_hack_robotics_lp", level.player.origin);
  var_4 linkTo(level.player);

  for(;;) {
    var_1 = var_1 + var_2;
    level.player._id_D9E1.bar.color = (1, 1, 1);
    var_5 = var_1 / var_0;
    level.player _id_0F14::_id_F80E(var_5);

    if(var_5 >= 1.0) {
      var_4 stoploopsound();
      var_4 delete();
      level.player playSound("sa_hack_finish");
      level.player._id_DA58 settext("HACK COMPLETE");
      wait 0.5;
      level.player._id_DA58 scripts\sp\hud_util::destroyelem();
      level.player._id_D9E1 scripts\sp\hud_util::destroyelem();
      break;
    } else
      wait(var_2);
  }
}

_id_D870() {
  var_0 = [];
  level.player playSound("sa_ability_lifesupport_on_lr");
  var_1 = scripts\sp\utility::_id_7A97();

  foreach(var_3 in var_1) {
    switch (var_3.script_noteworthy) {
      case "fxspot":
        var_0 = scripts\engine\utility::array_add(var_0, var_3);
        break;
    }
  }

  var_5 = [];

  foreach(var_3 in var_0) {
    var_7 = var_3 scripts\engine\utility::spawn_tag_origin();
    playFXOnTag(scripts\engine\utility::getfx("breach_wind"), var_7, "tag_origin");
    var_7 playSound("window_breach_wind_start");
    var_5 = scripts\engine\utility::array_add(var_5, var_7);
  }

  foreach(var_10 in var_5)
  playworldsound("window_breach_wind_stop", var_10.origin);

  thread _id_0F00::_id_CC79(5);
  wait 4.0;
  _id_0F35::_id_FB24(0, level.player);
  _id_0F35::_id_FB25(0, 0);
  _id_0F31::_id_E0C8();
  _id_0F31::_id_E0CE();
  _id_0F31::_id_E0CD();
  scripts\sp\utility::_id_228A(var_5);
}

_id_5253(var_0) {
  var_1 = [];
  level.player playSound("sa_ability_lifesupport_off_lr");
  var_2 = scripts\sp\utility::_id_7A97();

  foreach(var_4 in var_2) {
    switch (var_4.script_noteworthy) {
      case "fxspot":
        var_1 = scripts\engine\utility::array_add(var_1, var_4);
        break;
    }
  }

  var_6 = [];

  foreach(var_4 in var_1) {
    var_8 = var_4 scripts\engine\utility::spawn_tag_origin();

    if(!isDefined(var_0))
      playFXOnTag(scripts\engine\utility::getfx("breach_wind"), var_8, "tag_origin");

    var_8 playSound("window_breach_wind_start");
    var_6 = scripts\engine\utility::array_add(var_6, var_8);
  }

  foreach(var_11 in var_6)
  playworldsound("window_breach_wind_stop", var_11.origin);

  wait 4.0;
  _id_0F35::_id_FB24(1, level.player);
  _id_0F35::_id_FB25(1, 1);
  _id_0F31::_id_17A0();
  _id_0F31::_id_17A5();
  _id_0F31::_id_17A4();
  scripts\sp\utility::_id_228A(var_6);
  level notify("airlock_depressurize_complete");

  if(isDefined(level._id_3965) && !level._id_3965 scripts\sp\utility::_id_65DF("player_inside_ship"))
    level._id_3965 scripts\sp\utility::_id_65E0("player_inside_ship");

  level._id_3965 scripts\sp\utility::_id_65DD("player_inside_ship");

  if(!level.player scripts\sp\utility::_id_65DF("player_inside_ship"))
    level.player scripts\sp\utility::_id_65E0("player_inside_ship");

  level.player scripts\sp\utility::_id_65DD("player_inside_ship");
}

_id_7987(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, var_1);

  foreach(var_5 in var_3) {
    if(isDefined(var_5._id_EE52)) {
      if(var_5._id_EE52 == var_2)
        return var_5;
    }
  }
}

_id_DE5A() {
  var_0 = getEntArray("reflection_probe_door", "targetname");

  if(isDefined(var_0))
    scripts\sp\utility::_id_228A(var_0);
}