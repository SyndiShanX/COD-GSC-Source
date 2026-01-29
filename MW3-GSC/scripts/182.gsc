/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\182.gsc
**************************************/

_id_13B6(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_3 * 20; var_4++) {
    wait 0.05;
  }
}

_id_13B7(var_0, var_1) {
  var_2 = var_0._id_13B8;
  var_3 = var_1._id_13B8;
  self._id_0C6D[var_3] = var_0;
  self._id_0C6D[var_2] = var_1;
  self._id_0C6D[var_2]._id_13B8 = var_2;
  self._id_0C6D[var_3]._id_13B8 = var_3;
}

_id_13B9(var_0, var_1) {
  waittillframeend;
  var_2 = [];

  if(level._id_13BA == 1) {
    var_2[0] = randomfloatrange(var_0, var_1);
    level._id_13BB = var_2;
    level._id_13BC = undefined;
    return;
  }

  var_2[0] = var_0;
  var_2[var_2.size] = var_1;

  for(var_3 = 1; var_3 < level._id_13BA - 1; var_3++) {
    var_2 = _id_13BD(var_2);

  }
  level._id_13BB = maps\_utility::_id_0B53(var_2);
  level._id_13BC = undefined;
}

_id_13BD(var_0) {
  var_1 = -1;
  var_2 = 0;

  for(var_3 = 0; var_3 < var_0.size - 1; var_3++) {
    var_4 = var_0[var_3 + 1] - var_0[var_3];

    if(var_4 <= var_2) {
      continue;
    }
    var_2 = var_4;
    var_1 = var_3;
  }

  var_5 = [];

  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    if(var_1 == var_6 - 1) {
      var_5[var_5.size] = randomfloatrange(var_0[var_1], var_0[var_1 + 1]);

    }
    var_5[var_5.size] = var_0[var_6];
  }

  return var_5;
}

_id_13BE(var_0) {
  while(level._id_13C0[self._id_13BF] > 0) {
    level waittill("spawner_expired" + self._id_13BF);

  }
  if(var_0) {
    self waittill("trigger");

  }
  var_1 = maps\_utility::_id_13C1();
  common_scripts\utility::flag_set(var_1);
}

_id_13C2() {
  self endon("death");

  while(self._id_0AC9) {
    wait 0.05;
  }
}

_id_13C3(var_0) {
  self endon("death");
  var_0 endon("trigger");
  self waittill("trigger");
  var_0 notify("trigger");
}

_id_13C4(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);
  var_3 = spawnStruct();
  common_scripts\utility::array_thread(var_2, ::_id_13C3, var_3);
  var_3 waittill("trigger");
}

_id_13C5(var_0) {
  level waittill(var_0);
  self notify("done");
}

_id_13C6(var_0, var_1) {
  var_0 waittill(var_1);
  self notify("done");
}

_id_13C7(var_0) {
  var_0 waittill("trigger");
  self notify("done");
}

_id_13C8(var_0) {
  wait(var_0);
  self notify("done");
}

_id_13C9() {
  self notify("debug_color_update");
  self endon("debug_color_update");
  var_0 = self.unique_id;
  self waittill("death");
  level._id_13CA[var_0] = undefined;
  level notify("updated_color_friendlies");
}

_id_13CB(var_0) {
  thread _id_13C9();

  if(isDefined(self._id_134B)) {
    level._id_13CA[var_0] = self._id_134B;
  } else {
    level._id_13CA[var_0] = undefined;

  }
  level notify("updated_color_friendlies");
}

_id_13CC() {}

_id_13CD(var_0) {
  self notify("new_color_being_set");
  self._id_13CE = 1;
  maps\_colors::_id_1396();
  self endon("new_color_being_set");
  self endon("death");
  waittillframeend;
  waittillframeend;

  if(isDefined(self._id_134B)) {
    self._id_134D = level._id_1346[maps\_colors::_id_13B5()][self._id_134B];

    if(isDefined(self._id_13CF)) {
      self._id_13CF = undefined;
    } else {
      thread maps\_colors::_id_134E();
    }
  }

  self._id_13CE = undefined;
  self notify("done_setting_new_color");
}

_id_13D0(var_0) {
  var_1 = gettime();

  for(;;) {
    if(!isDefined(self._id_13D1)) {
      break;
    }

    self waittill("finished_radio");

    if(gettime() > var_1 + 7500) {
      return;
    }
  }

  self._id_13D1 = 1;
  maps\_utility::_id_1254(level._id_13D2, 0.5);
  level.player maps\_utility::play_sound_on_entity(level._id_11BB[var_0]);
  self._id_13D1 = undefined;
  level._id_13D2 = gettime();
  self notify("finished_radio");
}

_id_13D3(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

_id_13D4(var_0, var_1, var_2) {
  var_0 endon("done");
  [[var_1]](var_2);
  var_0 notify("done");
}

_id_13D5(var_0, var_1) {
  if(!isDefined(var_1)) {
    wait(var_0);
    return;
  }

  var_2 = var_0 * 20;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    if([[var_1]]()) {
      break;
    }

    wait 0.05;
  }
}

_id_13D6(var_0) {
  wait(var_0);
  self._id_13D7 = 1;
}

_id_13D8(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isalive(self)) {
    return;
  }
  var_6 = 1.0;
  var_7 = 0.75;
  var_8 = 0.95;
  var_9 = 0.4;
  var_10 = 2;

  if(isDefined(level._id_13D9)) {
    var_10 = level._id_13D9;

  }
  if(isDefined(self._id_13DA)) {
    if(self._id_13DA == var_0) {
      return;
    }
  }

  maps\_utility::_id_13DB("global_hint_in_use");

  if(isDefined(self._id_13DA)) {
    if(self._id_13DA == var_0) {
      return;
    }
  }

  maps\_utility::_id_13DC("global_hint_in_use");
  self._id_13DA = var_0;
  var_11 = maps\_hud_util::createserverclientfontstring("default", var_10);
  level._id_13DD = var_11;
  thread _id_13DF(var_11);
  level endon("friendlyfire_mission_fail");
  var_11.alpha = 0.9;
  var_11.x = 0;
  var_11.y = -68;
  var_11.alignx = "center";
  var_11.aligny = "middle";
  var_11.horzalign = "center";
  var_11.vertalign = "middle";
  var_11.foreground = 0;
  var_11.hidewhendead = 1;
  var_11.hidewheninmenu = 1;
  var_11 settext(var_0);
  var_11.alpha = 0;
  var_11 fadeovertime(var_6);
  var_11.alpha = var_8;
  _id_13D5(var_6, var_1);
  var_12 = 0;

  if(isDefined(var_4)) {
    var_12 = 3;
  } else if(isDefined(var_3)) {
    var_12 = 2;
  } else if(isDefined(var_2)) {
    var_12 = 1;

  }
  var_13 = spawnStruct();
  var_13._id_13D7 = 0;

  if(isDefined(var_5)) {
    var_13 thread _id_13D6(var_5);

  }
  if(isDefined(var_1)) {
    for(;;) {
      var_11 fadeovertime(var_7);
      var_11.alpha = var_9;
      _id_13D5(var_7, var_1);

      if(var_12 == 3) {
        if([
            [var_1]
          ](var_2, var_3, var_4)) {
          break;
        }
      } else if(var_12 == 2) {
        if([
            [var_1]
          ](var_2, var_3)) {
          break;
        }
      } else if(var_12 == 1) {
        if([
            [var_1]
          ](var_2)) {
          break;
        }
      } else if([[var_1]]()) {
        break;
      }

      var_11 fadeovertime(var_7);
      var_11.alpha = var_8;
      _id_13D5(var_7, var_1);

      if(var_13._id_13D7) {
        break;
      }

      if(var_12 == 3) {
        if([
            [var_1]
          ](var_2, var_3, var_4)) {
          break;
        }
      } else if(var_12 == 2) {
        if([
            [var_1]
          ](var_2, var_3)) {
          break;
        }
      } else if(var_12 == 1) {
        if([
            [var_1]
          ](var_2)) {
          break;
        }
      } else if([[var_1]]()) {
        break;
      }
    }
  } else {
    for(var_14 = 0; var_14 < 1; var_14++) {
      var_11 fadeovertime(var_7);
      var_11.alpha = var_9;
      _id_13D5(var_7, var_1);
      var_11 fadeovertime(var_7);
      var_11.alpha = var_8;
      _id_13D5(var_7, var_1);
    }
  }

  var_11 notify("destroying");
  self._id_13DA = undefined;
  var_11 destroy();
  level._id_13DD = undefined;
  maps\_utility::_id_13DE("global_hint_in_use");
}

_id_13DF(var_0) {
  var_0 endon("destroying");
  level waittill("friendlyfire_mission_fail");

  if(!isDefined(var_0)) {
    return;
  }
  self._id_13DA = undefined;
  var_0 destroy();
  maps\_utility::_id_13DE("global_hint_in_use");
}

_id_13E0(var_0) {
  var_0._id_13D7 = 0;

  if(!isalive(self)) {
    return;
  }
  var_1 = 1.0;
  var_2 = 0.75;
  var_3 = 0.95;
  var_4 = 0.4;
  maps\_utility::_id_13DB("global_hint_in_use");
  maps\_utility::_id_13DC("global_hint_in_use");

  if(var_0._id_13D7) {
    return;
  }
  if(isDefined(var_0.timeout)) {
    var_0 thread _id_13D6(var_0.timeout);

  }
  var_5 = maps\_hud_util::createserverclientfontstring("objective", 2);
  var_5.alpha = 0.9;
  var_5.x = 0;
  var_5.y = -38;
  var_5.alignx = "center";
  var_5.aligny = "middle";
  var_5.horzalign = "center";
  var_5.vertalign = "middle";
  var_5.foreground = 0;
  var_5.hidewhendead = 1;
  var_5 settext(var_0.string);
  var_5.alpha = 0;
  var_5 fadeovertime(var_1);
  var_5.alpha = var_3;
  _id_13D5(var_1);

  for(;;) {
    var_5 fadeovertime(var_2);
    var_5.alpha = var_4;
    _id_13D5(var_2);

    if(var_0._id_13D7) {
      break;
    }

    var_5 fadeovertime(var_2);
    var_5.alpha = var_3;
    _id_13D5(var_2);

    if(var_0._id_13D7) {
      break;
    }
  }

  var_5 destroy();
  maps\_utility::_id_13DE("global_hint_in_use");
}

_id_13E1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(self._id_11D3) && self._id_11D3 == gettime()) {
    wait 0.1;

  }
  var_9 = self gettagorigin(var_1);
  var_10 = self gettagangles(var_1);
  var_0 maps\_utility::_id_13E2(var_9, var_10, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  if(var_8) {
    return;
  }
  var_0 playerlinkto(self, var_1, var_3, var_4, var_5, var_6, var_7, 0);
}

_id_13E3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(self._id_11D3) && self._id_11D3 == gettime()) {
    wait 0.1;

  }
  var_9 = self gettagorigin(var_1);
  var_10 = self gettagangles(var_1);
  var_0 maps\_utility::_id_13E4(var_9, var_10, var_2, var_3, var_4, var_5, var_6, var_7, 1);

  if(var_8) {
    return;
  }
  var_0 playerlinktodelta(self, var_1, var_3, var_4, var_5, var_6, var_7, 0);
}

_id_13E5(var_0) {
  self endon("death");
  var_0 common_scripts\utility::waittill_either("function_done", "death");
}

_id_13E6(var_0) {
  _id_13E5(var_0);

  if(!isDefined(self)) {
    return 0;

  }
  if(!issentient(self)) {
    return 1;

  }
  if(isalive(self)) {
    return 1;

  }
  return 0;
}

_id_13E7(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");

  if(!isDefined(var_0._id_1255)) {
    var_0._id_1255 = [];

  }
  var_0._id_1255[var_0._id_1255.size] = self;
  thread _id_13E9(var_0);
  _id_13EA(var_0);

  if(isDefined(var_0) && isDefined(var_0._id_1255)) {
    self._id_13E8 = 1;
    self notify("function_stack_func_begun");

    if(isDefined(var_6)) {
      var_0[[var_1]](var_2, var_3, var_4, var_5, var_6);
    } else if(isDefined(var_5)) {
      var_0[[var_1]](var_2, var_3, var_4, var_5);
    } else if(isDefined(var_4)) {
      var_0[[var_1]](var_2, var_3, var_4);
    } else if(isDefined(var_3)) {
      var_0[[var_1]](var_2, var_3);
    } else if(isDefined(var_2)) {
      var_0[[var_1]](var_2);
    } else {
      var_0[[var_1]]();

    }
    if(isDefined(var_0) && isDefined(var_0._id_1255)) {
      var_0._id_1255 = common_scripts\utility::array_remove(var_0._id_1255, self);
      var_0 notify("level_function_stack_ready");
    }
  }

  if(isDefined(self)) {
    self._id_13E8 = 0;
    self notify("function_done");
  }
}

_id_13E9(var_0) {
  self endon("function_done");
  self waittill("death");

  if(isDefined(var_0)) {
    var_0._id_1255 = common_scripts\utility::array_remove(var_0._id_1255, self);
    var_0 notify("level_function_stack_ready");
  }
}

_id_13EA(var_0) {
  var_0 endon("death");
  self endon("death");
  var_0 endon("clear_function_stack");

  while(var_0._id_1255[0] != self) {
    var_0 waittill("level_function_stack_ready");
  }
}

_id_13EB(var_0) {
  level endon("player_flashed");
  wait(var_0);
  common_scripts\utility::flag_clear("player_flashed");
}

_id_13EC(var_0) {
  self endon("death");
  var_0 waittill("sounddone");
  return 1;
}

_id_13ED(var_0) {
  level._id_13EE = var_0;

  if(!isDefined(level._id_13EF)) {
    level._id_13EF = 0;

  }
  return level._id_13EF;
}

_id_13F0(var_0, var_1, var_2) {
  _id_13F2(var_0, var_1, var_2);
  self._id_13F1 = 0;
  self notify("_array_wait");
}

_id_13F2(var_0, var_1, var_2) {
  var_0 endon(var_1);
  var_0 endon("death");

  if(isDefined(var_2)) {
    wait(var_2);
  } else {
    var_0 waittill(var_1);
  }
}

_id_13F3(var_0) {
  if(var_0._id_13F4.size == 0) {
    var_0._id_13F5 call[[var_0.func]]();
  } else if(var_0._id_13F4.size == 1) {
    var_0._id_13F5 call[[var_0.func]](var_0._id_13F4[0]);
  } else if(var_0._id_13F4.size == 2) {
    var_0._id_13F5 call[[var_0.func]](var_0._id_13F4[0], var_0._id_13F4[1]);
  } else if(var_0._id_13F4.size == 3) {
    var_0._id_13F5 call[[var_0.func]](var_0._id_13F4[0], var_0._id_13F4[1], var_0._id_13F4[2]);

  }
  if(var_0._id_13F4.size == 4) {
    var_0._id_13F5 call[[var_0.func]](var_0._id_13F4[0], var_0._id_13F4[1], var_0._id_13F4[2], var_0._id_13F4[3]);

  }
  if(var_0._id_13F4.size == 5) {
    var_0._id_13F5 call[[var_0.func]](var_0._id_13F4[0], var_0._id_13F4[1], var_0._id_13F4[2], var_0._id_13F4[3], var_0._id_13F4[4]);
  }
}

_id_13F6(var_0) {
  if(var_0._id_13F4.size == 0) {
    call[[var_0.func]]();
  } else if(var_0._id_13F4.size == 1) {
    call[[var_0.func]](var_0._id_13F4[0]);
  } else if(var_0._id_13F4.size == 2) {
    call[[var_0.func]](var_0._id_13F4[0], var_0._id_13F4[1]);
  } else if(var_0._id_13F4.size == 3) {
    call[[var_0.func]](var_0._id_13F4[0], var_0._id_13F4[1], var_0._id_13F4[2]);

  }
  if(var_0._id_13F4.size == 4) {
    call[[var_0.func]](var_0._id_13F4[0], var_0._id_13F4[1], var_0._id_13F4[2], var_0._id_13F4[3]);

  }
  if(var_0._id_13F4.size == 5) {
    call[[var_0.func]](var_0._id_13F4[0], var_0._id_13F4[1], var_0._id_13F4[2], var_0._id_13F4[3], var_0._id_13F4[4]);
  }
}

_id_13F7(var_0, var_1) {
  if(!isDefined(var_0._id_13F5)) {
    return;
  }
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_1[var_2]._id_13F5 endon(var_1[var_2]._id_13F8);

  }
  if(var_0._id_13F4.size == 0) {
    var_0._id_13F5[[var_0.func]]();
  } else if(var_0._id_13F4.size == 1) {
    var_0._id_13F5[[var_0.func]](var_0._id_13F4[0]);
  } else if(var_0._id_13F4.size == 2) {
    var_0._id_13F5[[var_0.func]](var_0._id_13F4[0], var_0._id_13F4[1]);
  } else if(var_0._id_13F4.size == 3) {
    var_0._id_13F5[[var_0.func]](var_0._id_13F4[0], var_0._id_13F4[1], var_0._id_13F4[2]);

  }
  if(var_0._id_13F4.size == 4) {
    var_0._id_13F5[[var_0.func]](var_0._id_13F4[0], var_0._id_13F4[1], var_0._id_13F4[2], var_0._id_13F4[3]);

  }
  if(var_0._id_13F4.size == 5) {
    var_0._id_13F5[[var_0.func]](var_0._id_13F4[0], var_0._id_13F4[1], var_0._id_13F4[2], var_0._id_13F4[3], var_0._id_13F4[4]);
  }
}

_id_13F9(var_0, var_1) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  _id_13F7(var_0, var_1);
  self.count--;
  self notify("func_ended");
}

_id_13FA(var_0, var_1) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  _id_13F7(var_0, var_1);
  self._id_13FB--;
  self notify("abort_func_ended");
}

_id_13FC(var_0) {
  self endon("all_funcs_ended");

  if(!var_0.size) {
    return;
  }
  var_1 = 0;
  self._id_13FB = var_0.size;
  var_2 = [];
  common_scripts\utility::array_levelthread(var_0, ::_id_13FA, var_2);

  for(;;) {
    if(self._id_13FB <= var_1) {
      break;
    }

    self waittill("abort_func_ended");
  }

  self notify("any_funcs_aborted");
}

_id_13FD(var_0) {
  if(isDefined(self.forward)) {
    var_1 = anglesToForward(var_0.angles);
    var_0.origin = var_0.origin + var_1 * self.forward;
  }

  if(isDefined(self.right)) {
    var_2 = anglestoright(var_0.angles);
    var_0.origin = var_0.origin + var_2 * self.right;
  }

  if(isDefined(self.up)) {
    var_3 = anglestoup(var_0.angles);
    var_0.origin = var_0.origin + var_3 * self.up;
  }

  if(isDefined(self._id_13FE)) {
    var_0 addyaw(self._id_13FE);

  }
  if(isDefined(self._id_13FF)) {
    var_0 addpitch(self._id_13FF);

  }
  if(isDefined(self._id_1400)) {
    var_0 addroll(self._id_1400);
  }
}

_id_1401(var_0, var_1, var_2, var_3, var_4) {
  self notify("start_dynamic_run_speed");
  self endon("death");
  self endon("stop_dynamic_run_speed");
  self endon("start_dynamic_run_speed");
  level endon("_stealth_spotted");

  if(maps\_utility::_id_133C("_stealth_custom_anim")) {
    maps\_utility::_id_13DB("_stealth_custom_anim");

  }
  if(!maps\_utility::_id_133C("dynamic_run_speed_stopped")) {
    maps\_utility::_id_1402("dynamic_run_speed_stopped");
    maps\_utility::_id_1402("dynamic_run_speed_stopping");
  } else {
    maps\_utility::_id_13DE("dynamic_run_speed_stopping");
    maps\_utility::_id_13DE("dynamic_run_speed_stopped");
  }

  self._id_1403 = "";
  self._id_1404 = self._id_0FC6;
  thread _id_1409();
  var_5 = var_0 * var_0;
  var_6 = var_1 * var_1;
  var_7 = var_2 * var_2;
  var_8 = var_3 * var_3;

  for(;;) {
    wait 0.05;
    var_9 = level.players[0];

    foreach(var_11 in level.players) {
      if(distancesquared(var_9.origin, self.origin) > distancesquared(var_11.origin, self.origin)) {
        var_9 = var_11;
      }
    }

    var_13 = anglesToForward(self.angles);
    var_14 = vectornormalize(var_9.origin - self.origin);
    var_15 = vectordot(var_13, var_14);
    var_16 = distancesquared(self.origin, var_9.origin);
    var_17 = var_16;

    if(isDefined(var_4)) {
      var_18 = maps\_utility::_id_0AE9(var_9.origin, var_4);
      var_17 = distancesquared(var_18.origin, var_9.origin);
    }

    var_19 = 0;

    if(isDefined(self._id_1405)) {
      var_19 = [[level._id_1406]](self._id_1405, var_1);
    } else if(isDefined(self._id_1407)) {
      var_19 = [[level._id_1406]](self._id_1407, var_1);

    }
    if(isDefined(self._id_109A) && self._id_109A && !self._id_1408) {
      self._id_0FC6 = 1;

    }
    if(var_16 < var_6 || var_15 > -0.25 || var_19) {
      _id_1413("sprint");
      wait 0.5;
      continue;
    } else if(var_16 < var_5 || var_15 > -0.25) {
      _id_1413("run");
      wait 0.5;
      continue;
    } else if(var_17 > var_7) {
      if(self.a._id_0D2B != "stop") {
        _id_1413("stop");
        wait 0.5;
      }

      continue;
    } else if(var_16 > var_8) {
      _id_1413("jog");
      wait 0.5;
      continue;
    }
  }
}

_id_1409() {
  self endon("start_dynamic_run_speed");
  self endon("death");
  _id_140D();

  if(!self._id_1408) {
    self._id_0FC6 = self._id_1404;

  }
  if(isDefined(level._id_0C59["generic"]["DRS_run"])) {
    if(isarray(level._id_0C59["generic"]["DRS_run"])) {
      maps\_utility::_id_140A("DRS_run");
    } else {
      maps\_utility::_id_140B("DRS_run");
    }
  } else {
    maps\_utility::_id_140C();

  }
  self notify("stop_loop");
  maps\_utility::_id_13DE("dynamic_run_speed_stopping");
  maps\_utility::_id_13DE("dynamic_run_speed_stopped");
}

_id_140D() {
  level endon("_stealth_spotted");
  self waittill("stop_dynamic_run_speed");
}

_id_140E(var_0, var_1) {
  if(!isDefined(var_0.classname)) {
    if(!isDefined(var_0.type)) {
      var_2 = maps\_spawner::_id_140F;
    } else {
      var_2 = maps\_spawner::_id_1410;
    }
  } else {
    var_2 = maps\_spawner::_id_1411;

  }
  return maps\_spawner::_id_1412(var_0, var_2, var_1);
}

_id_1413(var_0) {
  if(self._id_1403 == var_0) {
    return;
  }
  self._id_1403 = var_0;

  switch (var_0) {
    case "sprint":
      if(isDefined(self._id_109A) && self._id_109A && !self._id_1408) {
        self._id_0FC6 = 1;
      } else if(!self._id_1408) {
        self._id_0FC6 = 1.15;

      }
      if(isarray(level._id_0C59["generic"]["DRS_sprint"])) {
        maps\_utility::_id_140A("DRS_sprint");
      } else {
        maps\_utility::_id_140B("DRS_sprint");

      }
      self notify("stop_loop");
      maps\_utility::_id_1414();
      maps\_utility::_id_13DE("dynamic_run_speed_stopped");
      break;
    case "run":
      if(!self._id_1408) {
        self._id_0FC6 = self._id_1404;

      }
      if(isDefined(level._id_0C59["generic"]["DRS_run"])) {
        if(isarray(level._id_0C59["generic"]["DRS_run"])) {
          maps\_utility::_id_140A("DRS_run");
        } else {
          maps\_utility::_id_140B("DRS_run");
        }
      } else {
        maps\_utility::_id_140C();

      }
      self notify("stop_loop");
      maps\_utility::_id_1414();
      maps\_utility::_id_13DE("dynamic_run_speed_stopped");
      break;
    case "stop":
      thread _id_1415();
      break;
    case "jog":
      if(!self._id_1408) {
        self._id_0FC6 = self._id_1404;

      }
      if(isDefined(level._id_0C59["generic"]["DRS_combat_jog"])) {
        if(isarray(level._id_0C59["generic"]["DRS_combat_jog"])) {
          maps\_utility::_id_140A("DRS_combat_jog");
        } else {
          maps\_utility::_id_140B("DRS_combat_jog");
        }
      } else {
        maps\_utility::_id_140C();

      }
      self notify("stop_loop");
      maps\_utility::_id_1414();
      maps\_utility::_id_13DE("dynamic_run_speed_stopped");
      break;
    case "crouch":
      break;
  }
}

_id_1415() {
  self endon("death");

  if(maps\_utility::_id_1008("dynamic_run_speed_stopped")) {
    return;
  }
  if(maps\_utility::_id_1008("dynamic_run_speed_stopping")) {
    return;
  }
  self endon("stop_dynamic_run_speed");
  maps\_utility::_id_13DC("dynamic_run_speed_stopping");
  maps\_utility::_id_13DC("dynamic_run_speed_stopped");
  self endon("dynamic_run_speed_stopped");
  var_0 = "DRS_run_2_stop";
  maps\_anim::_id_11CC(self, "gravity", var_0);
  maps\_utility::_id_13DE("dynamic_run_speed_stopping");

  if(isDefined(self._id_1416) && self._id_1416 > 0) {
    return;
  }
  while(maps\_utility::_id_1008("dynamic_run_speed_stopped")) {
    var_1 = "DRS_stop_idle";
    thread maps\_anim::_id_11C8(self, var_1);

    if(isDefined(level._id_0C59["generic"]["signal_go"])) {
      maps\_utility::_id_1417("go");

    }
    wait(randomfloatrange(12, 20));

    if(maps\_utility::_id_133C("_stealth_stance_handler")) {
      maps\_utility::_id_13DB("_stealth_stance_handler");

    }
    self notify("stop_loop");

    if(!maps\_utility::_id_1008("dynamic_run_speed_stopped")) {
      return;
    }
    if(isDefined(level._id_1418)) {
      var_2 = common_scripts\utility::random(level._id_1418);
      level thread maps\_utility::_id_1419(var_2);
    }

    if(isDefined(level._id_0C59["generic"]["signal_go"])) {
      maps\_utility::_id_1417("go");
    }
  }
}

_id_141A() {
  return int(getdvar("g_speed"));
}

_id_141B(var_0) {
  setsaveddvar("g_speed", int(var_0));
}

_id_141C() {
  return self._id_141D;
}

_id_141E(var_0) {
  self._id_141D = var_0;
  self setmovespeedscale(var_0);
}

_id_141F() {
  if(common_scripts\utility::flag_exist("autosave_tactical_player_nade")) {
    return;
  }
  common_scripts\utility::flag_init("autosave_tactical_player_nade");
  level._id_1420 = 0;
  notifyoncommand("autosave_player_nade", "+frag");
  notifyoncommand("autosave_player_nade", "-smoke");
  notifyoncommand("autosave_player_nade", "+smoke");
  common_scripts\utility::array_thread(level.players, ::_id_1421);
}

_id_1421() {
  for(;;) {
    self waittill("autosave_player_nade");
    common_scripts\utility::flag_set("autosave_tactical_player_nade");
    self waittill("grenade_fire", var_0);
    thread _id_1422(var_0);
  }
}

_id_1422(var_0) {
  level._id_1420++;
  var_0 common_scripts\utility::waittill_notify_or_timeout("death", 10);
  level._id_1420--;
  waittillframeend;

  if(!level._id_1420) {
    common_scripts\utility::flag_clear("autosave_tactical_player_nade");
  }
}

_id_1423() {
  level notify("autosave_tactical_proc");
  level endon("autosave_tactical_proc");
  level thread maps\_utility::_id_1424("kill_save", 5);
  level endon("kill_save");
  level endon("autosave_tactical_player_nade");

  if(common_scripts\utility::flag("autosave_tactical_player_nade")) {
    common_scripts\utility::flag_waitopen_or_timeout("autosave_tactical_player_nade", 4);

    if(common_scripts\utility::flag("autosave_tactical_player_nade")) {
      return;
    }
  }

  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.enemy) && isplayer(var_2.enemy)) {
      return;
    }
  }

  waittillframeend;
  maps\_utility::_id_1425();
}

_id_1426(var_0, var_1, var_2, var_3) {
  maps\_utility::_id_1427(var_1);
  level endon("stop_music");
  wait(var_1);
  thread maps\_utility::_id_1428(var_0, undefined, var_2, var_3);
}

_id_1429(var_0, var_1, var_2, var_3, var_4, var_5) {
  maps\_utility::_id_1427(var_2);
  level endon("stop_music");
  wait(var_2);
  thread _id_142A(var_0, var_1, undefined, var_3, var_4, var_5);
}

_id_142A(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_2) && var_2 > 0) {
    thread _id_1429(var_0, var_1, var_2, var_3, var_4, var_5);
    return;
  }

  maps\_utility::_id_1427();
  level endon("stop_music");
  maps\_utility::_id_142B(var_0, var_3, var_4);

  if(isDefined(var_5) && var_5 == 1 && common_scripts\utility::flag_exist("_stealth_spotted")) {
    level endon("_stealth_spotted");
    thread _id_142E(var_0, var_1, var_2);
  }

  var_6 = maps\_utility::_id_142C(var_0);

  if(!isDefined(var_1)) {
    var_1 = 1;

  }
  if(var_1 <= 10) {
    var_6 = var_6 + var_1;

  }
  wait(var_6);
  maps\_utility::_id_142D(var_0, var_1, var_2, var_3, var_4);
}

_id_142E(var_0, var_1, var_2) {
  level endon("stop_music");
  common_scripts\utility::flag_wait("_stealth_spotted");
  musicstop(0.5);

  while(common_scripts\utility::flag("_stealth_spotted")) {
    common_scripts\utility::flag_waitopen("_stealth_spotted");
    wait 1;
  }

  thread maps\_utility::_id_142D(var_0, var_1, var_2);
}

_id_142F(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_sliding");
  var_3 = self;
  var_4 = undefined;

  for(;;) {
    var_5 = var_3 getnormalizedmovement();
    var_6 = anglesToForward(var_3.angles);
    var_7 = anglestoright(var_3.angles);
    var_5 = (var_5[1] * var_7[0] + var_5[0] * var_6[0], var_5[1] * var_7[1] + var_5[0] * var_6[1], 0);
    var_0.slidevelocity = var_0.slidevelocity + var_5 * var_1;
    wait 0.05;
    var_0.slidevelocity = var_0.slidevelocity * (1 - var_2);
  }
}

_id_1430(var_0) {
  self endon("death");

  if(isDefined(var_0)) {
    wait(randomfloat(var_0));

  }
  playFXOnTag(common_scripts\utility::getfx("flesh_hit"), self, "tag_eye");
  self kill(level.player.origin);
}

_id_1431(var_0, var_1) {
  self endon("death");
  var_2 = 0;

  for(;;) {
    if(self.intensity > 0.0001 && gettime() > 300) {
      if(!var_2) {
        self playrumblelooponentity(var_1);
        var_2 = 1;
      }
    } else if(var_2) {
      self stoprumble(var_1);
      var_2 = 0;
    }

    var_3 = 1 - self.intensity;
    var_3 = var_3 * 1000;
    self.origin = var_0 getEye() + (0, 0, var_3);
    wait 0.05;
  }
}

_id_1433(var_0) {
  var_1 = spawn("script_model", self.origin);
  self._id_1434 = var_1;
  var_1.angles = self.angles;
  var_1 setModel(var_0);
  var_1 endon("death");
  self waittill("death");
  var_1 delete();
}

_id_1435(var_0, var_1, var_2) {
  foreach(var_5, var_4 in level._id_1436) {}
  level._id_1436[var_5] = var_1[var_5] * (1 - var_0) + var_2[var_5] * var_0;
}

_id_1437(var_0, var_1, var_2, var_3, var_4) {
  waittillframeend;

  if(!isDefined(self.start)) {
    self.start = 0;

  }
  if(!isDefined(self.end)) {
    self.end = 1;

  }
  if(!isDefined(self._id_143A)) {
    self._id_143A = 0;

  }
  var_5 = self.time * 20;
  var_6 = self.end - self.start;

  if(isDefined(var_4)) {
    for(var_7 = 0; var_7 <= var_5; var_7++) {
      var_8 = self._id_143A + var_7 * var_6 / var_5;
      var_1 thread[[var_0]](var_8, var_2, var_3, var_4);
      wait 0.05;
    }
  } else if(isDefined(var_3)) {
    for(var_7 = 0; var_7 <= var_5; var_7++) {
      var_8 = self._id_143A + var_7 * var_6 / var_5;
      var_1 thread[[var_0]](var_8, var_2, var_3);
      wait 0.05;
    }
  } else if(isDefined(var_2)) {
    for(var_7 = 0; var_7 <= var_5; var_7++) {
      var_8 = self._id_143A + var_7 * var_6 / var_5;
      var_1 thread[[var_0]](var_8, var_2);
      wait 0.05;
    }
  } else {
    for(var_7 = 0; var_7 <= var_5; var_7++) {
      var_8 = self._id_143A + var_7 * var_6 / var_5;
      var_1 thread[[var_0]](var_8);
      wait 0.05;
    }
  }
}

_id_143C(var_0) {
  waittillframeend;

  if(!isDefined(level._id_143D)) {
    level._id_143D = [];

  }
  if(!isDefined(level._id_143D)) {
    level._id_143D[var_0] = [];

  }
  if(isDefined(self.fx)) {
    level._id_143D[var_0][self._id_143F]["fx"] = self.fx;

  }
  if(isDefined(self._id_1440)) {
    level._id_143D[var_0][self._id_143F]["fx_array"] = self._id_1440;

  }
  if(isDefined(self.sound)) {
    level._id_143D[var_0][self._id_143F]["sound"] = self.sound;

  }
  if(isDefined(self._id_1441)) {
    level._id_143D[var_0][self._id_143F]["rumble"] = self._id_1441;

  }
  if(!isDefined(level._id_143D[var_0]["default"])) {
    level._id_143D[var_0]["default"] = level._id_143D[var_0][self._id_143F];
  }
}

_id_1442(var_0) {
  var_1 = spawnStruct();
  precachemodel(var_0.model);
  var_1._id_1443 = var_0.model;
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.script_noteworthy = var_0.script_noteworthy;
  var_1.target = var_0.target;
  var_1.targetname = var_0.targetname;
  self._id_1444[self._id_1444.size] = var_1;
  var_0 delete();
}

_id_1445(var_0) {
  var_1 = spawnStruct();
  precachemodel(var_0.model);
  var_1._id_1443 = var_0.model;
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.script_noteworthy = var_0.script_noteworthy;
  var_1.script_linkto = var_0.script_linkto;
  var_1.targetname = var_0.targetname;
  var_1.target = var_0.target;
  var_1.destructible_type = var_0.destructible_type;
  var_1.script_noflip = var_0.script_noflip;
  var_0 maps\_utility::_id_1446(var_0.destructible_type);
  self.destructibles[self.destructibles.size] = var_1;
  var_0 notify("masking_destructible");
  var_0 delete();
}

_id_1447() {
  var_0 = "allies";

  if(isDefined(self._id_1342)) {
    var_0 = "axis";

  }
  var_0 = maps\_colors::_id_13B5(var_0);
  var_1 = [];

  if(var_0 == "allies") {
    var_2 = maps\_colors::_id_1354(self._id_1341, "allies");
    var_1 = var_2["colorCodes"];
  } else {
    var_2 = maps\_colors::_id_1354(self._id_1342, "axis");
    var_1 = var_2["colorCodes"];
  }

  var_3 = [];
  var_3["team"] = var_0;
  var_3["codes"] = var_1;
  return var_3;
}

delaythread_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  wait(var_1);

  if(!isDefined(var_2)) {
    thread[[var_0]]();
  } else if(!isDefined(var_3)) {
    thread[[var_0]](var_2);
  } else if(!isDefined(var_4)) {
    thread[[var_0]](var_2, var_3);
  } else if(!isDefined(var_5)) {
    thread[[var_0]](var_2, var_3, var_4);
  } else if(!isDefined(var_6)) {
    thread[[var_0]](var_2, var_3, var_4, var_5);
  } else if(!isDefined(var_7)) {
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6);
  } else {
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  }
}

_id_1449() {
  level notify("kill_add_wait_asserter");
  level endon("kill_add_wait_asserter");

  for(var_0 = 0; var_0 < 20; var_0++) {
    waittillframeend;
  }
}

_id_144A() {}

_id_144B(var_0, var_1, var_2, var_3) {
  if(!var_1.size) {
    return undefined;

  }
  if(isDefined(var_2)) {
    var_4 = undefined;
    var_5 = getarraykeys(var_1);

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      var_7 = distance(var_1[var_5[var_6]].v["origin"], var_0);

      if([[var_3]](var_7, var_2)) {
        continue;
      }
      var_2 = var_7;
      var_4 = var_1[var_5[var_6]];
    }

    return var_4;
  }

  var_5 = getarraykeys(var_1);
  var_4 = var_1[var_5[0]];
  var_2 = distance(var_4.v["origin"], var_0);

  for(var_6 = 1; var_6 < var_5.size; var_6++) {
    var_7 = distance(var_1[var_5[var_6]].v["origin"], var_0);

    if([[var_3]](var_7, var_2)) {
      continue;
    }
    var_2 = var_7;
    var_4 = var_1[var_5[var_6]];
  }

  return var_4;
}

_id_144C() {
  for(;;) {
    self waittill("trigger", var_0);
    waittillframeend;

    if(var_0.currentnode == self) {
      return var_0;
    }
  }
}

_id_144E() {
  self._id_144F = [];
  self waittill("trigger", var_0);
  var_1 = self._id_144F;
  self._id_144F = undefined;

  foreach(var_3 in var_1) {}
  thread[[var_3]](var_0);
}

_id_1450(var_0) {
  if(!maps\_utility::_id_1451()) {
    return;
  }
  var_1 = _id_1454();
  var_2 = var_1;

  if(isDefined(level._id_1452)) {
    var_2 = var_1 - level._id_1452;

  }
  level._id_1452 = var_1;
  reconevent("script_objective: objective %d, leveltime %d, deltatime %d", var_0, var_1, var_2);
}

_id_1453(var_0) {
  if(maps\_utility::_id_1451()) {
    if(!isDefined(var_0)) {
      var_0 = 1;

    }
    var_1 = _id_1454();
    var_2 = var_1;
    reconevent("script_level: leveltime %d, deltatime %d, success %d", var_2, var_1, var_0);
  }
}

_id_1454() {
  return getlevelticks() * 0.05;
}