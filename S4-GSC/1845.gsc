/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1845.gsc
*************************************************/

_id_A2BA(var_0) {
  return self getplayerdata("cp", "meritProgress", var_0);
}

_id_A2BB(var_0) {
  return self getplayerdata("cp", "meritState", var_0);
}

_id_A2BE(var_0, var_1) {
  if(var_0 == "mt_highest_round") {
    var_2 = _id_A2BB("mt_highest_round");
    var_3 = _id_A2BC("mt_highest_round", var_2);

    if(level._id_10C9F >= var_3) {
      return self setplayerdata("cp", "meritProgress", var_0, var_3);
    }
  } else
    return self setplayerdata("cp", "meritProgress", var_0, var_1);
}

_id_A2BF(var_0, var_1) {
  return self setplayerdata("cp", "meritState", var_0, var_1);
}

_id_A2BC(var_0, var_1) {
  return int(_func_0222("cp/allMeritsTable.csv", 0, var_0, 10 + var_1 * 3));
}

_id_B8B4(var_0, var_1, var_2) {
  if(scripts\cp\utility::_id_8ACE() && istrue(self._id_FFBB)) {
    return;
  }
  var_3 = _id_6432(var_2);

  if(_id_86CB(var_1)) {
    _id_B2E4(var_3);
  } else if(_id_86CA(var_1)) {
    _id_B2E4("center");
  } else {
    _id_B1FA(var_3);
  }
}

_id_6432(var_0) {
  var_1 = 0.965;
  var_2 = ["left", "center", "right"];

  if(!isDefined(var_0)) {
    return var_2[randomint(var_2.size)];
  }

  var_0 = var_0 * -1;
  var_3 = anglesToForward(self.angles);
  var_4 = vectordot(var_0, var_3);

  if(var_4 > var_1) {
    return "center";
  }

  var_5 = anglestoright(self.angles);
  var_6 = vectordot(var_0, var_5);

  if(var_6 > 0) {
    return "right";
  } else {
    return "left";
  }
}

_id_86CB(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return var_0 == "alienspit_mp";
}

_id_86CA(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return var_0 == "alienspit_gas_mp";
}

_id_85B0(var_0) {
  if(!isDefined(var_0) || !var_0 _id_06FE::_id_8551()) {
    return 0;
  }

  return _id_06FE::_id_6305(var_0) == "elite";
}

_id_B2E4(var_0) {
  if(!scripts\cp\utility::_id_7526(self.model, "tag_eye")) {
    return;
  }
  if(var_0 == "left") {
    _func_019D(level._effect["vfx_alien_spitter_hit_left"], self, "tag_eye", self);
  } else if(var_0 == "center") {
    _func_019D(level._effect["vfx_alien_spitter_hit_center"], self, "tag_eye", self);
  } else if(var_0 == "right") {
    _func_019D(level._effect["vfx_alien_spitter_hit_right"], self, "tag_eye", self);
  } else {}
}

_id_B1FA(var_0) {
  var_1 = self;

  if(!isDefined(self.model) || self.model == "") {
    return;
  }
  if(!scripts\cp\utility::_id_7526(self.model, "tag_eye")) {
    return;
  }
}

_id_B400() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self setclientomnvar("ui_damage_event", self._id_42FB);
}

_id_11014() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  var_0 = 0;
  var_1 = 1;

  for(;;) {
    if(self.health <= 45 && var_0 == 0) {
      if(!self _meth_81E2()) {
        self _meth_82FD("painvision", 0.02, "mix", "reverb", "filter");

        if(_func_0205("sys_deaths_door_exit_cp")) {
          self _meth_83EF("sys_deaths_door_exit_cp");
        }

        if(_func_0205("sys_deaths_door_intro_impact_cp")) {
          self playlocalsound("sys_deaths_door_intro_impact_cp");
        }

        self setscriptablepartstate("deathsDoor", "active");
      }

      var_0 = 1;
    }

    if(var_0 && var_1) {
      if(!_id_073B::_id_B4EF(self)) {}

      var_1 = 0;
    }

    if(var_0 && self.health > 45) {
      self _meth_8078(0.3);

      if(_func_0205("sys_deaths_door_exit_cp")) {
        self playlocalsound("sys_deaths_door_exit_cp");
      }

      if(_func_0205("sys_deaths_door_intro_impact_cp")) {
        self _meth_83EF("sys_deaths_door_intro_impact_cp");
      }

      self setscriptablepartstate("deathsDoor", "inactive");
      var_0 = 0;
      var_1 = 1;
    }

    wait 0.05;
  }
}

_id_84D8(var_0, var_1) {
  if(!isDefined(level._id_8483)) {
    level._id_8483 = 0;
  } else {
    level._id_8483++;
  }

  var_2 = _id_3D72();
  var_3 = 1.6;

  if(level.splitscreen) {
    var_3 = 2;
  }

  var_4 = newhudelem();
  var_4.x = 20;
  var_4.y = var_2;
  var_4.alignx = "left";
  var_4.aligny = "bottom";
  var_4.horzalign = "left";
  var_4.vertalign = "bottom";
  var_4.sort = 3;
  var_4._id_01D6 = 1;
  var_4 settext(var_0);
  var_4.alpha = 1;
  var_4.hidewheninmenu = 1;
  var_4.fontscale = var_3;
  var_4.color = (0.8, 1, 0.8);
  var_4.font = "default";
  var_4._id_01F9 = (0.3, 0.6, 0.3);
  var_4._id_01F8 = 1;
  return var_4;
}

_id_3D72() {
  var_0 = -92;

  if(level.splitscreen) {
    var_0 = -110;
  }

  return level._id_8483 * 20 - 92;
}

_id_EF8D(var_0, var_1, var_2, var_3, var_4) {
  if(level._id_74C4) {
    return;
  }
  foreach(var_6 in level.players) {
    if(isDefined(var_2) && var_6.team != var_2) {
      continue;
    }
    if(!isPlayer(var_6)) {
      continue;
    }
    if(!isDefined(var_4)) {
      var_6 thread scripts\cp\cp_hud_message::showsplash(var_0, var_3, var_1);
    }
  }
}