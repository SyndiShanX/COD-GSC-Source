/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heistspace\heistspace_util.gsc
**********************************************************/

_id_10733(var_0, var_1, var_2, var_3, var_4) {
  level._id_8E42 = [];

  if(isDefined(var_0) && var_0 == 1) {
    level._id_6754 = scripts\sp\utility::_id_107EA("ethan", 1);
    level._id_6754._id_1FBB = "ethan";
    level._id_8E42 = scripts\engine\utility::add_to_array(level._id_8E42, level._id_6754);
    level._id_6754 thread isfirstarmageddonmeteorhit("iw7_fhr", "primary");
  }

  if(isDefined(var_1) && var_1 == 1) {
    level._id_EA2C = scripts\sp\utility::_id_107EA("salter", 1);
    level._id_EA2C._id_1FBB = "salter";
    level._id_EA2C scripts\sp\utility::_id_F3B5("r");
    level._id_8E42 = scripts\engine\utility::add_to_array(level._id_8E42, level._id_EA2C);
    level._id_EA2C thread isfirstarmageddonmeteorhit("iw7_m4", "primary");
  }

  if(isDefined(var_2) && var_2 == 1) {
    level._id_30F6 = scripts\sp\utility::_id_107EA("brooks", 1);
    level._id_30F6._id_1FBB = "brooks";
    level._id_8E42 = scripts\engine\utility::add_to_array(level._id_8E42, level._id_30F6);
    level._id_30F6 thread isfirstarmageddonmeteorhit("iw7_sdfar", "primary");
  }

  if(isDefined(var_3) && var_3 == 1) {
    level._id_EA2C = scripts\sp\utility::_id_107EA("salter_zerog", 1);
    level._id_EA2C._id_1FBB = "salter";
    level._id_EA2C scripts\sp\utility::_id_F3B5("r");
    level._id_8E42 = scripts\engine\utility::add_to_array(level._id_8E42, level._id_EA2C);
    level._id_EA2C thread isfirstarmageddonmeteorhit("iw7_m4", "primary");
  }

  if(isDefined(var_4) && var_4 == 1) {
    level._id_A54E = scripts\sp\utility::_id_107EA("kashima", 1);
    level._id_A54E._id_1FBB = "kashima";
    level._id_8E42 = scripts\engine\utility::add_to_array(level._id_8E42, level._id_A54E);
    level._id_A54E thread isfirstarmageddonmeteorhit("iw7_erad", "primary");
  }

  scripts\engine\utility::array_thread(level._id_8E42, ::_id_8E32);
}

_id_8E32() {
  thread scripts\sp\utility::_id_B14F();
  self.ignoreall = 1;
  self.ignoreme = 1;
  self._id_C065 = 1;
}

isfirstarmageddonmeteorhit(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    scripts\sp\utility::_id_72EC(var_2, "secondary");
    thread scripts\anim\shared::placeweaponon(var_2, "back");
  }

  scripts\sp\utility::_id_72EC(var_0, var_1);
}

_id_11685(var_0, var_1, var_2) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }
  if(!isDefined(level._id_545A))
    level._id_545A = [];

  var_3 = 0;

  for(;;) {
    if(!isDefined(level._id_545A[var_3])) {
      break;
    }

    var_3++;
  }

  var_4 = "^3";

  if(!isDefined(var_2))
    var_2 = 1;

  var_2 = max(1, var_2);
  level._id_545A[var_3] = 1;
  var_5 = scripts\sp\hud_util::createfontstring("default", 1.5);
  var_5.location = 0;
  var_5.alignx = "left";
  var_5.aligny = "top";
  var_5.foreground = 1;
  var_5.sort = 20;
  var_5.alpha = 0;
  var_5 fadeovertime(0.5);
  var_5.alpha = 1;
  var_5.x = 40;
  var_5.y = 260 + var_3 * 18;
  var_5.label = " " + var_4 + "< " + var_0 + " > ^7" + var_1;
  var_5.color = (1, 1, 1);
  wait(var_2);
  var_6 = 10.0;
  var_5 fadeovertime(0.5);
  var_5.alpha = 0;

  for(var_7 = 0; var_7 < var_6; var_7++) {
    var_5.color = (1, 1, 0 / (var_6 - var_7));
    wait 0.05;
  }

  wait 0.25;
  var_5 destroy();
  level._id_545A[var_3] = undefined;
}

_id_13E81() {
  scripts\engine\utility::flag_init("highlight_zero_g_ai");
  scripts\engine\utility::flag_set("highlight_zero_g_ai");
  _id_0F35::_id_FB24(1, level.player);
  scripts\sp\utility::_id_F3E4(0, 0);
  setsaveddvar("player_isInZeroGLevel", 1);
  _id_0F35::_id_FB25(1, 1);
  _id_0F31::_id_17A0();
  _id_0F31::_id_17A5();
  _id_0F31::_id_17A4();
  thread _id_0F35::_id_FAFD();
  level.player thread _id_0F35::_id_D385();
}

_id_E747() {
  var_0 = getEntArray("rotate_debris", "targetname");

  if(var_0.size > 0)
    scripts\engine\utility::array_thread(var_0, ::_id_E70E);
}

_id_E70E() {
  self endon("debris_cleanup");
  self endon("debris_done");
  var_0 = randomintrange(2, 5);
  var_1 = randomintrange(2, 5);
  var_2 = randomintrange(2, 5);

  for(;;) {
    if(isDefined(self.script_index))
      var_3 = self.script_index;
    else
      var_3 = 2;

    self rotateby((var_0, var_1, var_2), var_3);
    wait(var_3);
  }
}

_id_BC27(var_0) {
  var_1 = getEntArray("ext_bridge_models", "targetname");
  var_2 = getEnt("ext_bridge_geo", "targetname");
  var_3 = getEnt("ext_bridge_pos", "targetname");

  foreach(var_5 in var_1)
  var_5 linkTo(var_2);

  scripts\engine\utility::waitframe();
  var_2 moveTo(var_3.origin, 1);

  if(isDefined(var_0)) {
    scripts\engine\utility::flag_wait(var_0);
    scripts\sp\utility::_id_228A(var_1);
  }
}

_id_102F0(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_2 = getEntArray("sa_door", "script_noteworthy");
  var_3 = undefined;
  level._id_E9CB = 99;

  foreach(var_5 in var_2) {
    if(var_5 istouching(var_1))
      var_3 = var_5;
  }

  if(!isDefined(var_3)) {
    return;
  }
  var_3 scripts\sp\utility::_id_65E0("player_at_door");
  var_3 scripts\sp\utility::_id_65E0("begin_opening");
  var_3 scripts\sp\utility::_id_65E0("door_opened");
  var_3 scripts\sp\utility::_id_65E0("door_sequence_complete");
  var_3 scripts\sp\utility::_id_65E0("locked");
  var_7 = var_3 scripts\sp\utility::_id_7A8F();
  var_7 = scripts\engine\utility::array_combine(var_7, var_3 scripts\sp\utility::_id_7A97());
  var_7 = scripts\engine\utility::array_combine(var_7, var_3 _id_5996());

  foreach(var_9 in var_7) {
    if(isDefined(var_9.script_parameters)) {
      switch (var_9.script_parameters) {
        case "door_clip":
          var_3._id_5985 = var_9;
          break;
        case "door_neg_begin":
          var_3._id_8B94 = 1;
          var_3._id_8B93 = 0;
          break;
        case "door_link_begin":
          var_3._id_8B93 = 1;
          var_3._id_8B94 = 0;

          if(!isDefined(var_3._id_BEA2))
            var_3._id_BEA2 = [];

          var_3._id_BEA2[var_3._id_BEA2.size] = var_9;
          break;
        case "door_nav_mod":
          if(scripts\engine\utility::is_true(level._id_E9E8))
            var_3._id_BE61 = var_9;
          else
            var_3._id_BE62 = var_9;

          break;
        default:
          break;
      }
    }
  }

  var_3._id_262F = 1;
  var_3 thread _id_E99F();
  return var_3;
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

_id_E99F() {
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
  _id_12BD3(undefined, 1);

  for(;;) {
    if(_id_FF71())
      _id_E9A2();

    if(_id_FF1F())
      _id_E9A0();

    wait 0.05;
  }
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

_id_AED6(var_0) {
  if(isDefined(var_0))
    self._id_3856 = var_0;

  if(isDefined(self._id_AEDA))
    self[[self._id_AEDA]]();
  else if(!scripts\sp\utility::_id_65DB("locked")) {
    scripts\sp\utility::_id_65E1("locked");
    _id_5595();

    if(isDefined(self._id_AEE1)) {
      if(isDefined(self._id_E1B3)) {
        foreach(var_2 in self._id_AEE1) {}
      } else {
        foreach(var_2 in self._id_AEE1) {}
      }
    }

    _id_F46F();
    thread scripts\sp\utility::play_sound_on_entity("generic_door_close");
    _id_0E46::_id_DFE3();
  }
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

_id_12BD3(var_0, var_1) {
  if(isDefined(self._id_12BD6))
    self[[self._id_12BD6]]();
  else {
    if(!isDefined(var_0))
      var_0 = "tag_ui_front";

    if(scripts\engine\utility::is_true(var_1))
      _id_F5DF();

    if(scripts\sp\utility::_id_65DB("locked")) {
      scripts\sp\utility::_id_65DD("locked");
      _id_6249();
      _id_F5DF();
      thread scripts\sp\utility::play_sound_on_entity("generic_door_open");

      if(!isDefined(self._id_262F))
        _id_0E46::_id_48C4(var_0);
    }
  }
}

_id_599E() {
  return scripts\sp\utility::_id_65DB("locked");
}

_id_FA68() {
  if(isDefined(self._id_8B94)) {
    self._id_C02B = [];
    var_0 = getnodesinradius(self.origin, 96, 0, 48, "begin");

    foreach(var_2 in var_0) {
      if(isDefined(var_2.animscript) && var_2.animscript == "ship_assault_autotraverse") {
        var_2._id_A4DF = scripts\engine\utility::getStruct(var_2.target, "targetname");
        self._id_C02B[self._id_C02B.size] = var_2;
      }
    }

    if(self._id_C02B.size > 0)
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
  if(!isDefined(self._id_AD38) && isDefined(self._id_C02B)) {
    self._id_AD38 = [];

    foreach(var_1 in self._id_C02B) {
      var_2 = "link" + level._id_E9CB;
      level._id_E9CB++;
      self._id_AD38[self._id_AD38.size] = var_2;
      var_3 = var_1._id_A4DF.origin;
      createnavlink(var_2, var_1.origin, var_3, var_1);
      self._id_428A = gettime();
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

  if(scripts\engine\utility::is_true(self._id_19CB)) {
    if(_id_1D2E())
      return 1;

    return 0;
  }

  if(distance2dsquared(self.origin, level.player.origin) < self._id_12788 * self._id_12788 && _id_3DA3(self.origin, level.player.origin, self._id_B46A)) {
    if(isDefined(self._id_4284) && self._id_4284 == 1) {
      if(!isDefined(self._id_E1B3)) {
        if(scripts\sp\utility::_id_65DB("locked"))
          return 0;

        return 1;
      }
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

  if(scripts\engine\utility::is_true(self._id_19CB)) {
    if(isDefined(self.opened) && self.opened == 1) {
      if(_id_1D2E())
        return 0;

      return 1;
    }

    return 0;
  }

  if(scripts\sp\utility::_id_65DB("locked"))
    return 1;

  if(distance2dsquared(self.origin, level.player.origin) > self._id_12788 * self._id_12788 || !_id_3DA3(self.origin, level.player.origin, self._id_B46A)) {
    if(isDefined(self.opened) && self.opened == 1) {
      if(_id_1D2E())
        return 0;

      return 1;
    }
  }

  return 0;
}

_id_1D2E() {
  var_0 = self._id_12788;
  var_1 = self.origin;
  var_2 = getaiarray("allies", "axis", "team3");
  var_2 = sortbydistance(var_2, self.origin);

  if(isDefined(var_2) && var_2.size > 0) {
    var_3 = var_0 * var_0;

    if(distancesquared(var_1, var_2[0].origin) < var_3)
      return 1;
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
  self.collision notsolid();
  self.collision connectpaths();
  setumbraportalstate(self.target, 1);
  _id_5595();
  level notify("update_objective_path_now");
  self.left moveTo(self.left.origin + anglesToForward(self.angles) * self._id_C5DF * -1, self._id_C5E0);

  if(isDefined(self.right))
    self.right moveTo(self.right.origin + anglesToForward(self.angles) * self._id_C5DF, self._id_C5E0);

  thread scripts\sp\utility::play_sound_on_entity("generic_door_open");
  wait(self._id_C5E0 + 0.05);
  self.opened = 1;
  self._id_C62C = undefined;
}

_id_E9A0() {
  self.opened = undefined;
  self._id_C62C = undefined;
  self._id_42AF = 1;
  self.collision solid();
  self.collision disconnectPaths();
  self.left moveTo(self.left.origin + anglesToForward(self.angles) * self._id_C5DF, self._id_C5E0);

  if(isDefined(self.right))
    self.right moveTo(self.right.origin + anglesToForward(self.angles) * self._id_C5DF * -1, self._id_C5E0);

  thread scripts\sp\utility::play_sound_on_entity("generic_door_close");
  wait(self._id_C5E0 + 0.05);
  setumbraportalstate(self.target, 0);
  self._id_4284 = 1;
  self._id_42AF = undefined;
  _id_6249();
}

_id_1919(var_0, var_1, var_2, var_3) {
  scripts\sp\utility::_id_13754(var_0, var_1, var_3);
  scripts\engine\utility::flag_set(var_2);
}

_id_E352(var_0, var_1, var_2, var_3) {
  var_4 = getEnt(var_0, "targetname");
  var_5 = var_4 scripts\sp\utility::_id_77E3("axis");
  var_6 = getEnt(var_1, "targetname");

  foreach(var_8 in var_5) {
    if(isDefined(var_8) && isalive(var_8)) {
      if(isDefined(var_2) && isDefined(var_3))
        wait(randomfloatrange(var_2, var_3));

      var_8._id_72C7 = 0;
      var_8.fixednode = 0;
      var_8.pathrandompercent = randomintrange(75, 100);
      var_8 _meth_82F1(var_6);
    }
  }
}

_id_E9FD(var_0) {
  var_1 = 64;
  var_2 = getEnt(var_0, "targetname");

  if(isDefined(var_2) && !isDefined(var_2.trigger_off)) {
    var_2 scripts\sp\utility::_id_15F1();

    if(isDefined(var_2.spawnflags) && var_2.spawnflags &var_1)
      var_2 scripts\engine\utility::trigger_off();
  }
}

_id_3DD8(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1 waittill("trigger");

  if(isDefined(var_1._id_ED9E))
    scripts\engine\utility::flag_set(var_1._id_ED9E);
}

_id_F051() {
  var_0 = self getlinkedchildren(0);
  self._id_129D9 = 1;
  _id_0BB6::_id_39E1();
  self.script_team = "allies";
  self.team = "allies";
  self._id_B904 = "veh_mil_air_ca_olympus_mons";
  thread _id_0B53::_id_B909();
  var_1 = [];

  for(var_2 = 1; var_2 < 26; var_2++) {
    var_3 = "amb_missile_l_" + var_2;
    var_1 = scripts\engine\utility::add_to_array(var_1, var_3);
  }

  var_4 = [];

  for(var_2 = 1; var_2 < 26; var_2++) {
    var_3 = "amb_missile_r_" + var_2;
    var_4 = scripts\engine\utility::add_to_array(var_4, var_3);
  }

  var_5 = [];

  for(var_2 = 1; var_2 < 7; var_2++) {
    var_3 = "amb_turret_l_" + var_2;
    var_5 = scripts\engine\utility::add_to_array(var_5, var_3);
  }

  var_6 = [];

  for(var_2 = 1; var_2 < 7; var_2++) {
    var_3 = "amb_turret_r_" + var_2;
    var_6 = scripts\engine\utility::add_to_array(var_6, var_3);
  }

  var_7 = [];

  for(var_2 = 1; var_2 < 19; var_2++) {
    var_3 = "amb_turret_sml_l_" + var_2;
    var_7 = scripts\engine\utility::add_to_array(var_7, var_3);
  }

  var_8 = [];

  for(var_2 = 1; var_2 < 19; var_2++) {
    var_3 = "amb_turret_sml_r_" + var_2;
    var_8 = scripts\engine\utility::add_to_array(var_8, var_3);
  }

  var_9 = [];
  var_9[0] = var_1;
  var_9[1] = var_4;
  var_9[2] = var_5;
  var_9[3] = var_6;
  var_9[4] = var_7;
  var_9[5] = var_8;
  self._id_24C4 = scripts\engine\utility::array_combine_multiple(var_9);

  if(level._id_10CDA != "mars_arrival" && level._id_10CDA != "mons_130" && level._id_10CDA != "mons_guns_down") {
    return;
  }
  _id_1078C();
  wait 0.1;
  var_0 = self getlinkedchildren(0);
  _id_0BB8::_id_39CD("off");
  _id_0BB8::_id_39D0("off");
}

_id_1078B(var_0) {
  if(scripts\engine\utility::is_true(var_0))
    scripts\engine\utility::flag_wait("olympus_mons_fully_spawned");

  level._id_C416 = [];

  foreach(var_2 in level._id_C413.turrets) {
    foreach(var_4 in var_2) {
      if(isDefined(var_4)) {
        var_4 cleartargetentity();
        var_5 = spawn("script_model", var_4.origin);
        var_5.angles = var_4.angles;
        var_5 setModel(var_4.model);
        level._id_C416 = scripts\engine\utility::add_to_array(level._id_C416, var_5);
        var_4 delete();
      }
    }
  }

  level._id_C413.turrets = [];
}

_id_1078C() {
  var_0 = "cannon_small_ca_mons,1,1,";
  var_1 = ["amb_turret_sml_l_2", "amb_turret_sml_l_3", "amb_turret_sml_l_12", "amb_turret_sml_l_13", "amb_turret_sml_l_14", "amb_turret_sml_l_15", "amb_turret_sml_l_18", "amb_turret_sml_r_2", "amb_turret_sml_r_3", "amb_turret_sml_r_12", "amb_turret_sml_r_13", "amb_turret_sml_r_14", "amb_turret_sml_r_15", "amb_turret_sml_r_18"];
  var_2 = "cannon_flak_ca,1,1,";
  var_3 = ["amb_turret_l_1", "amb_turret_l_2", "amb_turret_l_3", "amb_turret_r_1", "amb_turret_r_2", "amb_turret_r_3"];
  var_4 = "cannon_phalanx,1,1,";
  var_5 = ["amb_turret_sml_l_4", "amb_turret_sml_l_11", "amb_turret_sml_l_16", "amb_turret_sml_l_17", "amb_turret_sml_r_4", "amb_turret_sml_r_11", "amb_turret_sml_r_16", "amb_turret_sml_r_17"];
  var_6 = "cannon_missile_ca_hardpoint";
  var_7 = "";
  var_7 = var_7 + var_0 + _id_4496(var_1);
  var_7 = var_7 + " " + var_2 + _id_4496(var_3);
  var_7 = var_7 + " " + var_6;
  var_7 = var_7 + " " + var_4 + _id_4496(var_5);
  self._id_EEF9 = var_7;
  _id_0BB6::_id_39E8();
  wait 0.05;
  thread _id_0BB6::_id_39EF();
  thread _id_FA6D(var_1, var_3, var_5);
  scripts\engine\utility::flag_set("olympus_mons_fully_spawned");
}

_id_FA6D(var_0, var_1, var_2) {
  self._id_129F5["cannon_left"] = [];
  self._id_129F5["cannon_right"] = [];
  self._id_129F5["flak_left"] = [];
  self._id_129F5["flak_right"] = [];
  self._id_129F5["phalanx_left"] = [];
  self._id_129F5["phalanx_right"] = [];

  foreach(var_4 in self.turrets) {
    if(var_4[0].type == "cap_turret_small_constant") {
      foreach(var_6 in var_4) {
        if(isDefined(var_6)) {
          if(scripts\engine\utility::array_contains(var_0, var_6._id_AD42) && issubstr(var_6._id_AD42, "_l_")) {
            self._id_129F5["cannon_left"][self._id_129F5["cannon_left"].size] = var_6._id_AD42;
            continue;
          }

          if(scripts\engine\utility::array_contains(var_0, var_6._id_AD42) && issubstr(var_6._id_AD42, "_r_"))
            self._id_129F5["cannon_right"][self._id_129F5["cannon_right"].size] = var_6._id_AD42;
        }
      }

      continue;
    }

    if(var_4[0].type == "cap_turret_med_flak") {
      foreach(var_6 in var_4) {
        if(isDefined(var_6)) {
          if(scripts\engine\utility::array_contains(var_1, var_6._id_AD42) && issubstr(var_6._id_AD42, "_l_")) {
            self._id_129F5["flak_left"][self._id_129F5["flak_left"].size] = var_6._id_AD42;
            continue;
          }

          if(scripts\engine\utility::array_contains(var_1, var_6._id_AD42) && issubstr(var_6._id_AD42, "_r_"))
            self._id_129F5["flak_right"][self._id_129F5["flak_right"].size] = var_6._id_AD42;
        }
      }

      continue;
    }

    if(var_4[0].type == "cap_turret_phalanx") {
      foreach(var_6 in var_4) {
        if(isDefined(var_6)) {
          if(scripts\engine\utility::array_contains(var_2, var_6._id_AD42) && issubstr(var_6._id_AD42, "_l_")) {
            self._id_129F5["phalanx_left"][self._id_129F5["phalanx_left"].size] = var_6._id_AD42;
            continue;
          }

          if(scripts\engine\utility::array_contains(var_2, var_6._id_AD42) && issubstr(var_6._id_AD42, "_r_"))
            self._id_129F5["phalanx_right"][self._id_129F5["phalanx_right"].size] = var_6._id_AD42;
        }
      }
    }
  }
}

_id_4496(var_0) {
  var_1 = "";

  foreach(var_3 in var_0)
  var_1 = var_1 + "," + var_3;

  return var_1;
}

_id_BA6C(var_0) {
  if(self._id_114FB == level._id_D127 || self._id_1DF8 == level._id_D127) {
    if(soundexists("capitalship_cannon_fire"))
      self playSound("capitalship_cannon_fire");

    self shootturret(var_0);
  } else {
    var_1 = level._id_39DD["cannon_small_ca_mons"];
    var_2 = _id_0BB6::_id_12A36(var_0);
    var_3 = _id_0BB6::_id_12A37(var_0, var_2);
    var_2 = anglesToForward(var_2);
    self thread[[var_1._id_10241._id_AF57]](var_3, var_2, var_0);
    var_4 = var_1._id_4D1E.fx;
  }
}

_id_FD45() {
  self endon("death");
  self endon("stop_idle_listing_motion");
  level endon("jackal_crash_begin");
  var_0 = 15;
  var_1 = var_0 / 3;
  var_2 = var_0 / 3;
  wait 0.2;
  var_3 = spawn("script_origin", self.origin);
  var_3.angles = self.angles;
  self linkTo(var_3);

  for(;;) {
    var_4 = randomfloatrange(400, 800);
    var_5 = randomfloatrange(200, 600);
    var_6 = randomfloatrange(200, 600);

    if(scripts\engine\utility::cointoss())
      var_4 = var_4 * -1;

    if(scripts\engine\utility::cointoss())
      var_5 = var_5 * -1;

    if(scripts\engine\utility::cointoss())
      var_6 = var_6 * -1;

    var_3 moveTo(var_3.origin + (var_4, var_5, var_6), var_0, var_1, var_2);
    var_3 waittill("movedone");
    wait 0.2;
    var_3 moveTo(var_3.origin - (var_4, var_5, var_6), var_0, var_1, var_2);
    var_3 waittill("movedone");
    wait 0.2;
  }
}

_id_B2DA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_6))
    level endon(var_6);

  if(!isDefined(self._id_FE2D))
    self._id_FE2D = [];

  var_8 = getEntArray(var_0, "targetname");

  if(!isDefined(self._id_E87D))
    self._id_E87D = 0;

  if(!isDefined(level._id_C072))
    level._id_C072 = 0;

  while(self._id_E87D != var_1) {
    foreach(var_10 in var_8) {
      if(isDefined(var_7))
        wait(var_7);

      scripts\engine\utility::waitframe();

      if(self._id_E87D >= var_1) {
        break;
      }

      var_10 scripts\sp\utility::_id_1747(_id_0BDC::_id_19AB, 250);
      var_11 = var_10 scripts\sp\utility::_id_10808();
      scripts\engine\utility::waitframe();
      self._id_FE2D = scripts\engine\utility::array_add(self._id_FE2D, var_11);
      self._id_E87D++;
    }
  }

  if(var_2 == -1)
    self._id_E87D = -2;

  while(var_2 < 0 || self._id_E87D < var_2 && self._id_FE2D.size > 0) {
    self._id_FE2D = scripts\engine\utility::array_removeundefined(self._id_FE2D);

    if(isDefined(level._id_B74A))
      _id_13796(self._id_FE2D, level._id_B74A);
    else
      _id_13796(self._id_FE2D, self._id_FE2D.size);

    self._id_FE2D = scripts\engine\utility::array_removeundefined(self._id_FE2D);

    if(self._id_FE2D.size < var_1 && self._id_E87D < var_2) {
      foreach(var_10 in var_8) {
        var_10 scripts\sp\utility::_id_1747(_id_0BDC::_id_19AB, 250);
        var_11 = var_10 scripts\sp\utility::_id_10808();

        if(var_2 != -1)
          self._id_E87D++;

        self._id_FE2D = scripts\engine\utility::array_add(self._id_FE2D, var_11);
        scripts\engine\utility::waitframe();
      }
    }

    wait 1;
  }

  if(isDefined(var_3))
    level notify(var_3);
}

_id_13796(var_0, var_1, var_2) {
  var_10 = spawnStruct();

  if(isDefined(var_2)) {
    var_10 endon("thread_timed_out");
    var_10 thread scripts\sp\utility_code::_id_13758(var_2);
  }

  var_10.count = var_0.size;

  if(isDefined(var_1) && var_1 < var_10.count)
    var_10.count = var_1;

  scripts\engine\utility::array_thread(var_0, scripts\sp\utility_code::_id_13757, var_10);

  while(var_10.count > 0)
    var_10 waittill("waittill_dead guy died");
}

_id_FA47(var_0) {
  if(!isDefined(var_0))
    var_0 = "rotating_roid";

  var_1 = getEntArray(var_0, "script_noteworthy");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.target)) {
      var_4 = getEnt(var_3.target, "targetname");
      var_4 linkTo(var_3);
    }

    var_3 thread _id_6F40();
  }
}

_id_6F40() {
  self endon("stop_float_in_space");
  level endon("death");
  level endon("stop_space_debris");
  var_0 = 0.1;

  if(isDefined(self.script_parameters) && float(self.script_parameters) > 0)
    var_0 = float(self.script_parameters);

  var_1 = var_0 * 10;
  var_2 = 180 / var_1;

  if(var_2 > 20)
    var_2 = var_2 - randomfloatrange(1.0, 20.0);

  var_3 = (randomfloatrange(-1 * var_0, var_0), randomfloatrange(-1 * var_0, var_0), 0);
  var_3 = var_3 * 50;

  for(;;) {
    self rotateby(var_3 * var_2, var_2);
    self waittill("rotatedone");
  }
}

_id_8D2A(var_0) {
  level notify("stage_change");
  level endon("stage_change");
  var_1 = getEntArray("heistspace_stage1", "targetname");
  var_2 = getEntArray("heistspace_stage2", "targetname");
  var_3 = getEntArray("heistspace_stage3", "targetname");
  scripts\engine\utility::waitframe();

  if(isDefined(var_0)) {
    if(var_0 == "stage1") {
      scripts\engine\utility::array_call(var_2, ::hide);
      scripts\engine\utility::array_call(var_3, ::hide);
    }

    if(var_0 == "stage2") {
      scripts\engine\utility::array_call(var_1, ::delete);
      scripts\engine\utility::array_call(var_2, ::show);
      scripts\engine\utility::array_call(var_3, ::hide);
    }

    if(var_0 == "stage3") {
      if(var_1.size != 0)
        scripts\engine\utility::array_call(var_1, ::delete);

      foreach(var_5 in var_2) {
        if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == "mars") {
          var_5 show();
          continue;
        }

        var_5 delete();
      }

      scripts\engine\utility::array_call(var_3, ::show);
    }
  }
}

_id_1076D(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0 gettagorigin(var_2));
  var_3.angles = var_0 gettagangles(var_2);
  var_3 setModel(var_1);
  var_3 linkTo(var_0, var_2, (0, 0, 0), (0, 0, 0));
  scripts\engine\utility::flag_wait("crash_script_model_clean_up");
  var_3 delete();
}

_id_D32A(var_0, var_1, var_2) {
  level endon(var_1);
  scripts\engine\utility::flag_wait(var_0);
  var_3 = scripts\engine\utility::getStruct(var_2, "targetname");

  for(;;) {
    if(level.player scripts\sp\utility::_id_D1DF(var_3.origin, 0.8))
      scripts\engine\utility::flag_set(var_1);

    wait 0.5;
  }
}

_id_30C8() {
  setsaveddvar("bg_cinematicfullscreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  wait 1;
  cinematicingameloopresident("heistspace_bridge_screen");
  scripts\engine\utility::flag_wait("ethan_hall_2_vo");
  stopcinematicingame();
}

_id_FD3C() {
  self endon("death");
  _id_F350();

  for(var_0 = level._id_FD4A; var_0 > 0; var_0 = var_0 - var_1) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(var_2 != level._id_D127) {
      var_1 = var_1 / 20;
      continue;
    }

    if(var_2 == level._id_D127)
      var_1 = var_1 * level._id_CFF0;
  }

  self _meth_81D0();
}

_id_F350() {
  var_0 = scripts\sp\utility::_id_7E72();

  switch (var_0) {
    case "easy":
      level._id_FD4A = 70000;
      level._id_CFF0 = 1.4;
      break;
    case "medium":
      level._id_FD4A = 80000;
      level._id_CFF0 = 1.33;
      break;
    case "hard":
      level._id_FD4A = 90000;
      level._id_CFF0 = 1.2;
      break;
    case "fu":
      level._id_FD4A = 100000;
      level._id_CFF0 = 1.0;
      break;
  }
}

_id_9A71(var_0) {
  if(scripts\engine\utility::flag("ordnance_player_anim_started")) {
    return;
  }
  if(!scripts\engine\utility::flag("flag_c6allies_mbs_off"))
    _id_9A6B("vfx_dmg_firsthall", var_0);
  else if(!scripts\engine\utility::flag("ethan_hall_3_vo"))
    _id_9A6B("vfx_dmg_nav", var_0);
  else if(!scripts\engine\utility::flag("ordnance_player_anim_started"))
    _id_9A6B("vfx_dmg_dmg_hall", var_0);
}

_id_9A6B(var_0, var_1) {
  scripts\engine\utility::exploder(var_0);

  if(isDefined(var_1))
    var_2 = var_1;
  else
    var_2 = randomfloatrange(1.25, 2.75);

  var_3 = scripts\sp\utility::_id_7C23();
  var_3 thread scripts\sp\utility::_id_E7C8(0.1);
  var_3 scripts\engine\utility::delaythread(var_2 * 0.5, scripts\sp\utility::_id_E7C7, var_2 * 0.5);
  var_3 scripts\engine\utility::delaycall(7.0, ::delete);
}

_id_7657() {
  var_0 = getDvar("player_itemUseRadius");
  var_1 = getDvar("player_itemUseFOV");
  setsaveddvar("player_itemUseRadius", 100);
  setsaveddvar("player_itemUseFOV", 90);
  level waittill("end_gambit_weapon_pickup");
  setsaveddvar("player_itemUseRadius", var_0);
  setsaveddvar("player_itemUseFOV", var_1);
}