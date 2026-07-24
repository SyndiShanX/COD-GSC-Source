/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2849.gsc
**************************************/

_id_102F7() {}

#using_animtree("script_model");

_id_102EF() {
  self.anims["open"] = % door_metal_double_sliding_open;
  self.anims["close"] = % door_metal_double_sliding_close;
  self.anims["opened"] = % door_metal_double_sliding_opened;
  self.anims["closed"] = % door_metal_double_sliding_closed;
}

_id_5A45() {
  level _id_5A44();
  var_0 = scripts\engine\utility::getStructArray("doors_sliding", "targetname");

  foreach(var_2 in var_0) {
    var_2 _id_102EF();

    if(isDefined(var_2.script_parameters)) {
      var_3 = strtok(var_2.script_parameters, " ");

      switch (var_3[0]) {
        case "locked":
          var_2._id_5A33 = "locked";
          break;
        case "open":
          var_2._id_5A33 = "open";
          break;
        case "automatic":
          var_2._id_5A33 = "automatic";
          break;
        case "unlocked":
          var_2._id_5A33 = "unlocked";
          break;
        case "static":
          var_2._id_5A33 = "static";
          break;
        default:
          var_2._id_5A33 = "unlocked";
          break;
      }

      if(isDefined(var_3[1])) {
        var_2._id_EFC5 = var_3[1];
        level._id_EFA6[var_2._id_EFC5] = var_2;
      }
    } else
      var_2._id_5A33 = "unlocked";

    var_2.left = _id_0EFB::_id_798A(var_2.target, "targetname", "left");
    var_2.right = _id_0EFB::_id_798A(var_2.target, "targetname", "right");
    var_2._id_AB39 = _id_0EFB::_id_798A(var_2.target, "targetname", "left_col");
    var_2._id_E516 = _id_0EFB::_id_798A(var_2.target, "targetname", "right_col");

    if(!isDefined(var_2.left))
      continue;
    else if(!isDefined(var_2.right))
      continue;
    else if(!isDefined(var_2._id_AB39))
      continue;
    else if(!isDefined(var_2._id_E516)) {
      continue;
    }
    var_2._id_AB39 linkTo(var_2.left);
    var_2._id_E516 linkTo(var_2.right);
    var_2._id_AB39 connectpaths();
    var_2._id_E516 connectpaths();
    var_2.left _meth_83D0(#animtree);
    var_2.right _meth_83D0(#animtree);
    var_2._id_5A32 = "closed";
    var_2._id_EFC4 = squared(160);
    var_2._id_EFBF = undefined;
    var_2._id_EFAE = "[{+activate}] Open";
    var_2._id_EFB8 = "[{+activate}] Open";

    if(isDefined(var_2._id_EFC5))
      var_2._id_ECCE = _id_0EFB::_id_7994("shipcrib_door_screen", "script_noteworthy", var_2._id_EFC5);

    var_2._id_ECCA = [];

    foreach(var_5 in var_2._id_ECCE) {
      if(var_5.classname != "script_model") {
        var_2._id_ECCE = scripts\engine\utility::array_remove(var_2._id_ECCE, var_5);
        var_2._id_ECCA = scripts\engine\utility::array_add(var_2._id_ECCA, var_5);
      }
    }

    if(var_2._id_5A33 == "static") {
      var_2 thread _id_5A4A("locked");
      continue;
    }

    var_2 thread _id_5A49();
  }
}

_id_5A4A(var_0) {
  switch (var_0) {
    case "unlocked":
      self.left showpart("door_unlocked");
      self.left hidepart("door_locked");
      self.left hidepart("door_inactive");
      self.left hidepart("door_automatic");
      self.right showpart("door_unlocked");
      self.right hidepart("door_locked");
      self.right hidepart("door_inactive");
      self.right hidepart("door_automatic");
      _id_5A47(var_0);
      break;
    case "locked":
      self.left showpart("door_locked");
      self.left hidepart("door_unlocked");
      self.left hidepart("door_inactive");
      self.left hidepart("door_automatic");
      self.right showpart("door_locked");
      self.right hidepart("door_unlocked");
      self.right hidepart("door_inactive");
      self.right hidepart("door_automatic");
      _id_5A47(var_0);
      break;
    case "automatic":
      self.left showpart("door_automatic");
      self.left hidepart("door_unlocked");
      self.left hidepart("door_locked");
      self.left hidepart("door_inactive");
      self.right showpart("door_automatic");
      self.right hidepart("door_unlocked");
      self.right hidepart("door_locked");
      self.right hidepart("door_inactive");
      _id_5A47(var_0);
      break;
    case "open":
      self.left showpart("door_inactive");
      self.left hidepart("door_unlocked");
      self.left hidepart("door_locked");
      self.left hidepart("door_automatic");
      self.right showpart("door_inactive");
      self.right hidepart("door_unlocked");
      self.right hidepart("door_locked");
      self.right hidepart("door_automatic");
      _id_5A47(var_0);
      break;
  }
}

_id_5A47(var_0) {
  self endon("death");

  if(!isDefined(self._id_ECCE) || self._id_ECCE.size == 0) {
    return;
  }
  scripts\engine\utility::array_call(self._id_ECCE, ::_meth_8184);

  switch (var_0) {
    case "unlocked":
      scripts\engine\utility::array_call(self._id_ECCE, ::showpart, "tag_unlocked");
      scripts\engine\utility::array_thread(self._id_ECCA, scripts\sp\lights::_id_AB83, 0.009, 0.05);
      scripts\engine\utility::array_thread(self._id_ECCA, scripts\sp\lights::_id_3C57, (0.26, 0.98, 0.18), 0.05);
      break;
    case "locked":
      scripts\engine\utility::array_call(self._id_ECCE, ::showpart, "tag_locked");
      scripts\engine\utility::array_thread(self._id_ECCA, scripts\sp\lights::_id_AB83, 0.009, 0.05);
      scripts\engine\utility::array_thread(self._id_ECCA, scripts\sp\lights::_id_3C57, (0.98, 0.18, 0.26), 0.05);
      break;
    case "automatic":
      scripts\engine\utility::array_call(self._id_ECCE, ::showpart, "tag_unlocked");
      break;
    case "open":
      scripts\engine\utility::array_call(self._id_ECCE, ::showpart, "tag_unlocked");
      scripts\engine\utility::array_thread(self._id_ECCA, scripts\sp\lights::_id_AB83, 0.009, 0.05);
      scripts\engine\utility::array_thread(self._id_ECCA, scripts\sp\lights::_id_3C57, (0.26, 0.98, 0.18), 0.05);
      break;
  }
}

_id_5A49() {
  self endon("death");
  thread _id_5A4A(self._id_5A33);

  for(;;) {
    if(self._id_5A33 == "open" && self._id_5A32 != "open") {
      self._id_5A32 = "open";
      thread _id_5A4A(self._id_5A33);
      self.left setanimknob(self.anims["open"]);
      self.right setanimknob(self.anims["open"]);
      self.left thread scripts\engine\utility::play_sound_in_space("shipcrib_elevator_door_open", self.left gettagorigin("door_locked"));
      wait(getanimlength(self.anims["open"]));
    } else if(self._id_5A33 == "unlocked" || self._id_5A33 == "automatic") {
      if(_id_5A48(self) && self._id_5A32 != "open") {
        self._id_5A32 = "open";

        if(isDefined(self._id_EFC6)) {
          self[[self._id_EFC6]]();
          self._id_EFC6 = undefined;
        } else {
          thread _id_5A4A(self._id_5A33);
          self.left setanimknob(self.anims["open"]);
          self.right setanimknob(self.anims["open"]);
          self.left thread scripts\engine\utility::play_sound_in_space("shipcrib_elevator_door_open", self.left gettagorigin("door_locked"));
          wait(getanimlength(self.anims["open"]));
        }
      } else if(!_id_5A48(self) && self._id_5A32 != "closed") {
        self._id_5A32 = "closed";
        thread _id_5A4A(self._id_5A33);
        self.left setanimknob(self.anims["close"]);
        self.right setanimknob(self.anims["close"]);
        self.left thread scripts\engine\utility::play_sound_in_space("shipcrib_elevator_door_close", self.left gettagorigin("door_locked"));
        wait(getanimlength(self.anims["close"]));
      }
    } else if(self._id_5A33 == "locked" && self._id_5A32 != "closed") {
      self._id_5A32 = "closed";
      thread _id_5A4A(self._id_5A33);
      self.left setanimknob(self.anims["close"]);
      self.right setanimknob(self.anims["close"]);
      self.left thread scripts\engine\utility::play_sound_in_space("shipcrib_elevator_door_close", self.left gettagorigin("door_locked"));
      wait(getanimlength(self.anims["close"]));
    }

    scripts\engine\utility::waitframe();
  }
}

_id_5A48(var_0) {
  if(distance2dsquared(level.player.origin, var_0.origin) < var_0._id_EFC4 && var_0._id_5A32 == "open")
    return 1;

  if(distance2dsquared(level.player.origin, var_0.origin) < var_0._id_EFC4 && scripts\sp\utility::_id_D1DF(var_0.origin + (0, 0, 45), 0.85)) {
    if(var_0._id_5A33 == "unlocked") {
      if(!isDefined(var_0._id_EFBF)) {
        var_0._id_EFBF = 1;
        level._id_EF98.alpha = 1;

        if(_id_5A46(var_0)) {} else {}
      }

      if(_id_0EE4::_id_EFEE("BUTTON_X", 4)) {
        var_0._id_EFBF = undefined;
        level._id_EF98.alpha = 0;
        return 1;
      }
    } else
      return 1;
  } else if(isDefined(var_0._id_EFBF) && var_0._id_EFBF) {
    var_0._id_EFBF = undefined;
    level._id_EF98.alpha = 0;
  }

  var_1 = getaiarray();

  if(var_1.size > 0) {
    var_1 = sortbydistance(var_1, var_0.origin);

    if(isDefined(var_1[0]._id_EFB4) && var_1[0]._id_EFB4) {
      if(distance2dsquared(var_1[0].origin, var_0.origin) < var_0._id_EFC4 * 0.3)
        return 1;
    }
  }

  return 0;
}

_id_5A46(var_0) {
  var_1 = scripts\sp\utility::_id_7951(var_0.origin, var_0.angles, level.player.origin);

  if(var_1 > 0)
    return 1;
  else
    return 0;
}

_id_5A44() {
  level._id_EF98 = newhudelem();
  level._id_EF98.hidewheninmenu = 1;
  level._id_EF98.alignx = "center";
  level._id_EF98.foreground = 1;
  level._id_EF98.font = "objective";
  level._id_EF98.fontscale = 1.3;
  level._id_EF98.alpha = 0;
  level._id_EF98.x = 320;
  level._id_EF98.y = 345;
  level._id_EF98.color = (1, 1, 1);
}

_id_5A43(var_0, var_1) {
  var_2 = level._id_EFA6[var_0];
  var_2._id_5A33 = var_1;
  var_2 thread _id_5A4A(var_2._id_5A33);
}

_id_7950(var_0) {
  var_1 = level._id_EFA6[var_0];
  return var_1;
}