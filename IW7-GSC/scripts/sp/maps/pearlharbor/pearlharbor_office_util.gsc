/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\pearlharbor\pearlharbor_office_util.gsc
*******************************************************************/

_id_721D(var_0, var_1) {
  self notify("follow_chain_end");
  self endon("follow_chain_end");

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = scripts\engine\utility::getStruct(var_0[var_2], "targetname");
    self _meth_8250(1);
    scripts\sp\utility::_id_F3DC(var_3.origin);
    self._id_136FA = 0;
    _id_1375D(var_3, 150);

    if(var_1) {
      if(distance2d(self.origin, level.player.origin) > 300 && level.player _id_9D65(self)) {
        _id_13860(var_3, "player_close");
        thread _id_CE8E(var_3, "player_close");
        thread _id_C153("player_close", level.player, 300);
        self waittill("player_close");
        thread _id_40DA();
      }
    }
  }

  self notify("follow_chain_complete");
}

_id_13860(var_0, var_1) {
  self endon(var_1);
  scripts\sp\anim::_id_1F12(self);
  var_2 = (0, 0, 0);

  if(isDefined(self._id_1359F)) {
    if(self._id_1359F == "left") {
      var_2 = (110, 110, 110);
    } else {
      var_2 = (-110, -110, -110);
    }
  }

  var_3 = var_0.angles + var_2;
  self._id_1359C = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_3);
  self._id_1359C scripts\sp\anim::_id_1ED0(self, "stand_idle", undefined, "Exposed");
  self._id_136FA = 1;
}

_id_C153(var_0, var_1, var_2) {
  _id_1375D(var_1, var_2);
  self notify(var_0);
  scripts\engine\utility::waitframe();
  self notify(var_0);
}

_id_1375D(var_0, var_1) {
  while(distance2d(self.origin, var_0.origin) > var_1) {
    scripts\engine\utility::waitframe();
  }
}

_id_CE8E(var_0, var_1) {
  self endon(var_1);
  _id_1375D(var_0, 8);
  scripts\sp\utility::_id_779C(level.player, 0.7);
  self waittill("forever");
}

_id_40DA() {
  scripts\sp\utility::_id_77BD(1.2);

  if(isDefined(self._id_1359C)) {
    self._id_1359C delete();
  }
}

_id_EC00(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  scripts\sp\utility::_id_F3DC(var_2.origin);
  var_3 = 150;
  _id_1375D(var_2, var_3);

  if(var_1) {
    if(distance2d(self.origin, level.player.origin) > 300 && level.player _id_9D65(self)) {
      _id_13860(var_2, "player_close");
      thread _id_CE8E(var_2, "player_close");
      thread _id_C153("player_close", level.player, 300);
      self waittill("player_close");
      thread _id_40DA();
    }
  }
}

_id_118E9(var_0, var_1, var_2, var_3) {
  wait(var_0);
  scripts\sp\utility::_id_13861("on", var_2, var_3);
  wait(var_1);
  scripts\sp\utility::_id_13861("off", var_2, var_3);
}

_id_DB85(var_0, var_1, var_2, var_3, var_4) {
  scripts\sp\anim::_id_17FC(self._id_1FBB, "anim_movement = walk", "smooth_anim", var_0);
  thread _id_CE1C(var_1, var_2, var_3, var_4);
}

_id_CE1C(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0) || !isnumber(var_0)) {
    var_0 = 200;
  }

  if(!isDefined(var_1) || !isnumber(var_1)) {
    var_1 = 2;
  }

  self _meth_8250(1);
  level waittill("smooth_anim");
  self orientmode("face angle", self.angles[1]);
  self.goalradius = 8;

  if(isDefined(var_2)) {
    if(!isvector(var_2)) {
      var_2 = var_2.origin;
    }

    scripts\sp\utility::_id_F3DC(var_2);
  } else {
    var_4 = self.origin + anglesToForward(self.angles) * var_0;
    scripts\sp\utility::_id_F3DC(var_4);
  }

  wait(var_1);

  if(!isDefined(var_3)) {
    var_3 = "smooth_anim_exit_complete";
  }

  self notify(var_3);
}

_id_AB77(var_0, var_1) {
  var_2 = scripts\asm\asm::asm_getmoveplaybackrate();
  var_3 = var_1 * 20;
  var_4 = (var_0 - var_2) / var_3;

  for(var_5 = 0; var_5 < var_3; var_5++) {
    var_2 = scripts\asm\asm::asm_getmoveplaybackrate();
    scripts\asm\asm::_id_237B(var_2 + var_4);
    scripts\engine\utility::waitframe();
  }

  scripts\asm\asm::_id_237B(var_0);
}

_id_9D65(var_0) {
  var_1 = scripts\sp\utility::_id_7951(var_0.origin, var_0.angles, self.origin);

  if(var_1 < 0) {
    return 1;
  } else {
    return 0;
  }
}

_id_7B74(var_0, var_1, var_2) {
  var_3 = level._id_EC85[var_1._id_1FBB][var_2];
  var_4 = getstartorigin(var_0.origin, var_0.angles, var_3);
  var_5 = getstartangles(var_0.origin, var_0.angles, var_3);
  var_6 = scripts\engine\utility::spawn_tag_origin(var_4, var_5);
  return var_6;
}

_id_11015() {
  level.player notify("end_movement_lerp");
  scripts\engine\utility::waitframe();
  level.player._id_5F86 = 180;
}

_id_AB86(var_0) {
  self notify("end_lerp_movementspeed_onDistToActor");
  self endon("end_lerp_movementspeed_onDistToActor");
  var_0 endon("death");
  var_1 = 150;
  var_2 = 70;
  var_3 = 300;
  var_4 = 115;
  var_5 = 700;
  var_6 = 130;
  var_7 = 150;
  var_8 = 0;
  level.player._id_5F86 = 100;
  level.player thread _id_AB87();
  level.player endon("end_movement_lerp");

  while(isDefined(var_0)) {
    var_9 = distance2d(level.player.origin, var_0.origin);
    var_10 = level.player _id_9D65(var_0);
    var_11 = 0;

    if(isDefined(var_0._id_136FA)) {
      var_11 = var_0._id_136FA;
    }

    if(var_9 < var_1) {
      var_8 = var_2;
    } else if(var_9 < var_3 && (var_10 || var_11)) {
      var_8 = var_4;
    } else if(var_9 < var_5 && (var_10 || var_11)) {
      var_8 = var_6;
    } else if(var_10 || var_11) {
      var_8 = var_7;
    }

    if(level.player._id_5F86 != var_8) {
      level.player._id_5F86 = var_8;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_AB87() {
  self notify("end_dynamic_movementspeed");
  self endon("end_dynamic_movementspeed");

  while(isDefined(level.player._id_5F86)) {
    var_0 = int(getDvar("g_speed"));

    if(var_0 > level.player._id_5F86) {
      setsaveddvar("g_speed", var_0 - 1);
    }

    if(var_0 < level.player._id_5F86) {
      setsaveddvar("g_speed", var_0 + 1);
    }

    scripts\engine\utility::waitframe();
  }
}

_id_C8D0(var_0, var_1, var_2) {
  thread _id_C33D();

  if(isDefined(var_1) && var_1) {
    setsaveddvar("bg_cinematicFullScreen", "0");
    setsaveddvar("bg_cinematicCanPause", "1");
  } else {
    setsaveddvar("bg_cinematicFullScreen", "1");
    setsaveddvar("bg_cinematicCanPause", "0");
    setomnvar("ui_hide_hud", 1);
  }

  cinematicingame(var_0);

  while(!iscinematicplaying()) {
    scripts\engine\utility::waitframe();
  }

  while(iscinematicplaying()) {
    if(level.player buttonPressed("BUTTON_LSTICK") && level.player buttonPressed("BUTTON_RSTICK") && isDefined(var_2) && var_2) {
      break;
    }

    if(level.player buttonPressed("BUTTON_X") && isDefined(var_2) && var_2) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  stopcinematicingame();
  setomnvar("ui_hide_hud", 0);
  level notify("sc_bink_done");
  thread _id_C33C();
}

_id_C33D() {
  level.player _meth_82C0("phparade_opening_bink", 0.05);
}

_id_C33C() {
  level.player clearclienttriggeraudiozone(0.05);
}

_id_C8D9(var_0, var_1, var_2) {
  _id_3DC0();
  var_3 = _id_7B66(var_0);
  var_1 = _id_0EFB::_id_7D7A(var_1);

  if(!isDefined(var_3)) {
    return;
  }
  if(isDefined(var_2) && var_2 == 1) {
    var_4 = _id_C8DA(var_3);
  } else {
    var_4 = _id_C8DB(var_3);
  }

  var_4 _id_C8DD(var_1);
  return var_4;
}

_id_7B66(var_0) {
  if(isDefined(level._id_C8DC[var_0])) {
    for(;;) {
      foreach(var_2 in level._id_C8DC[var_0]) {
        if(_id_9D24(var_2)) {
          var_2._id_A90C = gettime();
          return var_2;
        }
      }

      scripts\engine\utility::waitframe();
    }
  } else
    return undefined;
}

_id_9D24(var_0) {
  if(!isDefined(var_0._id_A90C) || gettime() - var_0._id_A90C >= 50) {
    return 1;
  } else {
    return 0;
  }
}

_id_C8DB(var_0) {
  var_1 = var_0 scripts\sp\utility::_id_10619(1);
  var_1._id_1FBB = "generic";
  var_1 scripts\sp\utility::_id_51E1("casual");

  if(isDefined(var_1.weapon) && var_1.weapon != "none") {
    var_1 scripts\sp\utility::_id_86E4();
  }

  return var_1;
}

_id_C8DA(var_0) {
  var_1 = scripts\sp\utility::_id_5CC9(var_0);
  var_1._id_1FBB = "generic";
  var_1._id_9B89 = 1;
  var_1._id_6B14 = 1;

  if(isDefined(var_1.weapon) && var_1.weapon != "none") {
    var_1 scripts\sp\utility::_id_86E4();
  }

  return var_1;
}

_id_C8DD(var_0) {
  if(!isDefined(self._id_9B89)) {
    self _meth_80F1(var_0.origin, var_0.angles);
    self orientmode("face angle", var_0.angles[1]);
    scripts\engine\utility::waitframe();
    self setgoalpos(var_0.origin);
  } else {
    self.origin = var_0.origin;
    self.angles = var_0.angles;
  }
}

_id_3DC0() {
  if(!isDefined(level._id_C8DC)) {
    _id_96AC();
  }
}

_id_96AC() {
  var_0 = getspawnerarray("parade_spawner_system");
  level._id_C8DC = [];

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy)) {
      if(!isDefined(level._id_C8DC[var_2.script_noteworthy])) {
        level._id_C8DC[var_2.script_noteworthy] = [];
      }

      level._id_C8DC[var_2.script_noteworthy] = ::scripts\engine\utility::array_add(level._id_C8DC[var_2.script_noteworthy], var_2);
    }
  }
}

_id_E692() {
  if(!isDefined(level._id_E6C2)) {
    return;
  }
  foreach(var_1 in level._id_E6C2) {
    var_1 delete();
  }

  level notify("rooftop_cleanup");
}

_id_E693() {
  level._id_E6C2 = scripts\engine\utility::array_add(level._id_E6C2, self);
}

_id_E68C() {
  if(!isDefined(level._id_E6C2)) {
    level._id_E6C2 = [];
  }

  var_0 = getEntArray("rooftop_ambient_spawner", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\sp\utility::_id_10619(1);
    var_3._id_1FBB = "generic";
    var_3.script_pushable = 0;

    if(isDefined(var_3.script_parameters) && var_3.script_parameters == "tablet") {
      var_3._id_247B = spawn("script_model", var_3.origin);
      var_3._id_247B setModel("p7_desk_metal_military_03_tablet");
      var_3._id_247B linkTo(var_3, "tag_inhand", (0, 0, 0), (0, 0, 0));
    }

    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "delete") {
      var_3 _id_E693();
    }

    if(!isDefined(var_3.target)) {
      var_3 thread scripts\sp\anim::_id_1EEA(var_3, var_3.animation);
      continue;
    }

    var_3 thread _id_E6B3(var_2);
  }
}

_id_E6B3(var_0) {
  scripts\sp\utility::_id_51E1("casual");
  scripts\sp\utility::_id_F3DD(8);
  var_1 = var_0 scripts\engine\utility::get_target_ent();

  if(isDefined(self.script_noteworthy)) {
    if(isDefined(self.animation)) {
      thread scripts\sp\anim::_id_1EEA(self, self.animation, "stop_guy_loop");
    }

    level waittill(self.script_noteworthy);
  }

  while(isDefined(var_1)) {
    self notify("stop_going_to_node");
    self notify("stop_guy_loop");
    var_1 notify("stop_guy_loop");
    _id_0B6A::_id_EC0B(var_1, var_1.animation, undefined, undefined, undefined, undefined, undefined, 1);

    if(isDefined(var_1.script_delay)) {
      wait(var_1.script_delay);
    } else {
      wait(randomfloatrange(4, 8));
    }

    if(!isDefined(var_1.target)) {
      var_1 = undefined;
      continue;
    }

    var_1 = var_1 scripts\engine\utility::get_target_ent();
  }
}

_id_6A2C() {
  var_0 = getEntArray("exterior_blocker_guy", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\sp\utility::_id_10619(1);
    var_4._id_1FBB = var_3.script_noteworthy;
    var_5 = scripts\engine\utility::getStruct(var_3.target, "targetname");
    var_4 thread _id_6A2D(var_5);
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

_id_6A2D(var_0) {
  level endon("stop_rail_anims");
  scripts\sp\utility::_id_51E1("casual");
  var_0 thread scripts\sp\anim::_id_1EEA(self, var_0.animation, "stop_blocking");
  scripts\engine\utility::flag_wait("un_vignette_3_end");
  var_0 notify("stop_blocking");
  var_0 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  self _meth_83A1();
  var_0 scripts\sp\anim::_id_1F0D(self, var_0.animation);
  var_0 thread scripts\sp\anim::_id_1EEA(self, var_0.animation, "stop_blocking");
}