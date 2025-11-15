/***********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\doorpush.gsc
***********************************/

func_8FE0() {
  level.var_EC87["player_rig"] = #animtree;
  level.var_EC85["player_rig"]["right_push"] = % shipcrib_player_door_right_push;
  level.var_EC85["player_rig"]["right_pull"] = % shipcrib_player_door_right_pull;
  level.var_EC85["player_rig"]["left_push"] = % shipcrib_player_door_left_push;
  level.var_EC85["player_rig"]["left_pull"] = % shipcrib_player_door_left_pull;
  level.var_EC85["player_rig"]["left_push_long_open"] = % shipcrib_plr_door_left_push_long;
  level.var_EC85["player_rig"]["left_push_long_hold"][0] = % shipcrib_plr_door_left_push_long_hold;
  level.var_EC85["player_rig"]["left_push_long_close"] = % shipcrib_plr_door_left_push_long_close_bridge;
  level.var_EC85["player_rig"]["right_push_long_open"] = % shipcrib_plr_door_right_push_long;
  level.var_EC85["player_rig"]["right_push_long_hold"][0] = % shipcrib_plr_door_right_push_long_hold;
  level.var_EC85["player_rig"]["right_push_long_close"] = % shipcrib_plr_door_right_push_long_close;
  level.var_EC85["player_rig"]["armory_enter_open"] = % shipcrib_plr_door_right_push_long;
  level.var_EC85["player_rig"]["armory_enter_hold"][0] = % shipcrib_plr_door_right_push_long_hold;
  level.var_EC85["player_rig"]["armory_enter_close"] = % shipcrib_plr_door_right_push_long_close_armory;
}

func_8FDF() {
  level.var_EC87["door"] = #animtree;
  level.var_EC85["door"]["right_push"] = % shipcrib_door_right_push_open;
  level.var_EC85["door"]["right_pull"] = % shipcrib_door_right_pull_open;
  level.var_EC85["door"]["left_push"] = % shipcrib_door_left_push_open;
  level.var_EC85["door"]["left_pull"] = % shipcrib_door_left_pull_open;
  level.var_EC85["door"]["left_push_long_open"] = % shipcrib_door_left_push_long_open;
  level.var_EC85["door"]["left_push_long_hold"][0] = % shipcrib_door_left_push_long_hold;
  level.var_EC85["door"]["left_push_long_close"] = % shipcrib_door_left_push_long_close;
  level.var_EC85["door"]["right_push_long_open"] = % shipcrib_door_right_push_long_open;
  level.var_EC85["door"]["right_push_long_hold"][0] = % shipcrib_door_right_push_long_hold;
  level.var_EC85["door"]["right_push_long_close"] = % shipcrib_door_right_push_long_close;
  level.var_EC85["door"]["armory_enter_open"] = % shipcrib_door_right_push_long_open;
  level.var_EC85["door"]["armory_enter_hold"][0] = % shipcrib_door_right_push_long_hold;
  level.var_EC85["door"]["armory_enter_close"] = % shipcrib_door_right_push_long_close;
}

func_5A38() {
  scripts\sp\dooruse::func_5A4B();
  var_00 = [];
  var_00 = scripts\engine\utility::array_combine(var_00, scripts\engine\utility::getstructarray("doors_hinged", "targetname"));
  foreach(var_02 in var_00) {
    var_02 scripts\sp\utility::func_65E0("push_triggered");
    var_02 scripts\sp\utility::func_65E0("pull_triggered");
    var_02.var_5A3C = getent(var_02.target, "targetname");
    var_02.var_5A3C glinton(#animtree);
    var_02.var_5A3C.var_1FBB = "door";
    var_02.var_5A32 = "notbusy";
    var_02.var_5A39 = "normal";
    if(isDefined(var_02.script_parameters)) {
      var_03 = strtok(var_02.script_parameters, " ");
      var_02.var_5A33 = var_03[0];
      if(isDefined(var_03[1])) {
        var_02.var_5A50 = var_03[1];
        level.doors[var_02.var_5A50] = var_02;
      }
    } else {
      var_02.var_5A33 = "unlocked";
    }

    switch (var_02.script_noteworthy) {
      case "hinged_left":
        var_02.var_8FDD = "left";
        break;

      case "hinged_right":
        var_02.var_8FDD = "right";
        break;

      default:
        var_02.var_8FDD = "left";
        break;
    }

    var_02 func_8FE0();
    var_02 func_8FDF();
    var_02.var_DB15 = var_02.origin + anglestoright(var_02.angles) * 50;
    var_02.var_DB15 = var_02.var_DB15 + anglesToForward(var_02.angles) * -24;
    var_02.var_DB14 = var_02.angles;
    var_02.var_5A40 = scripts\engine\utility::spawn_tag_origin(var_02.var_5A3C gettagorigin("interact_push"), var_02.var_5A3C gettagangles("interact_push"));
    var_02.var_5A40 linkto(var_02.var_5A3C);
    var_02.var_5A3F = scripts\engine\utility::spawn_tag_origin(var_02.var_5A3C gettagorigin("interact_pull"), var_02.var_5A3C gettagangles("interact_pull"));
    var_02.var_5A3F linkto(var_02.var_5A3C);
    var_02 func_48C7();
    var_02.var_5A4F = squared(80);
    if(isDefined(var_02.var_5A3C.target)) {
      var_04 = getEntArray(var_02.var_5A3C.target, "targetname");
      foreach(var_06 in var_04) {
        if(var_06.classname == "script_brushmodel") {
          var_02.var_5A30 = var_06;
        }

        var_06 linkto(var_02.var_5A3C, "j_hinge1");
      }
    }

    if(isDefined(var_02.var_5A50)) {
      var_02.var_ECCE = lib_0EFB::func_7994("shipcrib_door_screen", "script_noteworthy", var_02.var_5A50);
    }

    var_02.var_ECCA = [];
    foreach(var_06 in var_02.var_ECCE) {
      if(var_06.classname != "script_model") {
        var_02.var_ECCE = scripts\engine\utility::array_remove(var_02.var_ECCE, var_06);
        var_02.var_ECCA = scripts\engine\utility::array_add(var_02.var_ECCA, var_06);
      }
    }

    var_02.var_5A40 thread func_9013(var_02, "push_triggered");
    var_02.var_5A3F thread func_9013(var_02, "pull_triggered");
    var_02 thread func_5A4E();
  }
}

func_5A55(param_00) {
  switch (param_00) {
    case "unlocked":
      self.var_5A3C giveperk("door_unlocked");
      self.var_5A3C hidepart("door_locked");
      self.var_5A3C hidepart("door_inactive");
      func_48C7();
      func_5A42(param_00);
      break;

    case "locked":
      self.var_5A3C giveperk("door_locked");
      self.var_5A3C hidepart("door_unlocked");
      self.var_5A3C hidepart("door_inactive");
      func_DFE5();
      func_5A42(param_00);
      break;

    case "automatic":
      self.var_5A3C hidepart("door_unlocked");
      self.var_5A3C hidepart("door_locked");
      self.var_5A3C hidepart("door_inactive");
      func_DFE5();
      func_5A42(param_00);
      break;

    case "open":
      self.var_5A3C giveperk("door_inactive");
      self.var_5A3C hidepart("door_unlocked");
      self.var_5A3C hidepart("door_locked");
      func_DFE5();
      func_5A42(param_00);
      break;
  }
}

func_5A42(param_00) {
  self endon("death");
  if(!isDefined(self.var_ECCE) || self.var_ECCE.size == 0) {
    return;
  }

  scripts\engine\utility::array_call(self.var_ECCE, ::_meth_8184);
  switch (param_00) {
    case "unlocked":
      scripts\engine\utility::array_call(self.var_ECCE, ::giveperk, "tag_unlocked");
      scripts\engine\utility::array_thread(self.var_ECCA, ::scripts\sp\lights::func_AB83, 0.009, 0.05);
      scripts\engine\utility::array_thread(self.var_ECCA, ::scripts\sp\lights::func_3C57, (0.26, 0.98, 0.18), 0.05);
      break;

    case "locked":
      scripts\engine\utility::array_call(self.var_ECCE, ::giveperk, "tag_locked");
      scripts\engine\utility::array_thread(self.var_ECCA, ::scripts\sp\lights::func_AB83, 0.009, 0.05);
      scripts\engine\utility::array_thread(self.var_ECCA, ::scripts\sp\lights::func_3C57, (0.98, 0.18, 0.26), 0.05);
      break;

    case "automatic":
      scripts\engine\utility::array_call(self.var_ECCE, ::giveperk, "tag_unlocked");
      break;

    case "open":
      scripts\engine\utility::array_call(self.var_ECCE, ::giveperk, "tag_unlocked");
      scripts\engine\utility::array_thread(self.var_ECCA, ::scripts\sp\lights::func_AB83, 0.009, 0.05);
      scripts\engine\utility::array_thread(self.var_ECCA, ::scripts\sp\lights::func_3C57, (0.26, 0.98, 0.18), 0.05);
      break;
  }
}

func_48C7() {
  switch (self.var_5A39) {
    case "aggressive":
      var_00 = 360;
      var_01 = 1;
      var_02 = distance2d(self.origin, level.player.origin) * 1.5;
      break;

    default:
      var_00 = 45;
      var_01 = undefined;
      var_02 = 200;
      break;
  }

  self.var_5A40 lib_0E46::func_48C4(undefined, undefined, undefined, var_00, var_02, 50, var_01, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  self.var_5A3F lib_0E46::func_48C4(undefined, undefined, undefined, var_00, var_02, 50, var_01, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  self.var_5A39 = "normal";
}

func_DFE5() {
  self.var_5A40 lib_0E46::func_DFE3();
  self.var_5A3F lib_0E46::func_DFE3();
}

func_9013(param_00, param_01) {
  param_00 endon("death");
  self endon("death");
  for(;;) {
    param_00 scripts\sp\utility::func_65DD("push_triggered");
    param_00 scripts\sp\utility::func_65DD("pull_triggered");
    self waittill("trigger");
    param_00 scripts\sp\utility::func_65E1(param_01);
    param_00 func_DFE5();
  }
}

func_5A4E() {
  self endon("death");
  self endon("other_side_triggered");
  thread func_5A55(self.var_5A33);
  for(;;) {
    if(self.var_5A33 == "open" && self.var_5A32 != "busy") {
      self.var_5A32 = "busy";
      thread func_5A55(self.var_5A33);
      func_5A34("open");
    } else if(self.var_5A33 == "unlocked" || self.var_5A33 == "automatic") {
      if((scripts\sp\utility::func_65DB("push_triggered") || scripts\sp\utility::func_65DB("pull_triggered")) && self.var_5A32 != "busy") {
        self.var_5A32 = "busy";
        if(isDefined(self.var_5A52)) {
          self.var_1212 = undefined;
          if(self.var_5A53 == "pushpull") {
            self.var_1212 = self.var_5A52;
          } else if(self.var_5A53 == "push") {
            if(scripts\sp\utility::func_65DB("push_triggered")) {
              self.var_1212 = self.var_5A52;
            }
          } else if(self.var_5A53 == "pull") {
            if(scripts\sp\utility::func_65DB("pull_triggered")) {
              self.var_1212 = self.var_5A52;
            }
          }

          func_DFE5();
          if(isDefined(self.var_1212)) {
            if(self.var_5A54) {
              self.var_5A52 = undefined;
            }

            self[[self.var_1212]]();
            self.var_1212 = undefined;
          }
        } else {
          func_DFE5();
          func_5A34();
        }

        thread func_48C7();
      } else if((!scripts\sp\utility::func_65DB("push_triggered") || !scripts\sp\utility::func_65DB("pull_triggered")) && self.var_5A32 != "notbusy") {
        self.var_5A32 = "notbusy";
        thread func_5A55(self.var_5A33);
        func_5A34("close");
      }
    } else if(self.var_5A33 == "locked" && self.var_5A32 != "notbusy") {
      self.var_5A32 = "notbusy";
      thread func_5A55(self.var_5A33);
      func_5A34("close");
    }

    scripts\engine\utility::waitframe();
  }
}

func_5A34(param_00) {
  if(func_5A3D(self)) {
    var_01 = "pull";
  } else {
    var_01 = "push";
  }

  var_02 = self.var_8FDD + "_" + var_01;
  if(isDefined(param_00)) {
    switch (param_00) {
      case "open":
        self.var_5A3C give_attacker_kill_rewards(self.var_5A3C scripts\sp\utility::func_7DC1(var_02));
        break;

      case "close":
        self.var_5A3C setanimknob(self.var_5A3C scripts\sp\utility::func_7DC1(var_02), 1, 0, 0);
        break;
    }
  }

  func_11EB(var_02);
}

func_5A3D(param_00) {
  var_01 = scripts\sp\utility::func_7951(param_00.origin, param_00.angles, level.player.origin);
  if(var_01 > 0) {
    return 1;
  }

  return 0;
}

func_5A2E(param_00, param_01, param_02) {
  if(isstring(param_00)) {
    var_03 = level.doors[param_00];
  } else {
    var_03 = param_01;
  }

  if(isDefined(param_02)) {
    var_03.var_5A39 = param_02;
  }

  var_03.var_5A33 = param_01;
  var_03.var_5A32 = "notbusy";
  var_03 thread func_5A55(var_03.var_5A33);
}

func_5A2C(param_00) {
  if(!isDefined(param_00)) {}

  self.var_5A3A = param_00;
}

func_5A52(param_00, param_01, param_02, param_03) {
  var_04 = level.doors[param_00];
  var_04 endon("death");
  if(!isDefined(param_03)) {
    param_03 = "pushpull";
  }

  var_04.var_5A53 = param_03;
  var_04.var_5A52 = param_01;
  if(!isDefined(param_02)) {
    var_04.var_5A54 = 1;
    return;
  }

  var_04.var_5A54 = param_02;
}

func_794A(param_00) {
  return level.doors[param_00];
}

func_AB71(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_00 endon("death");
  if(!isDefined(param_05)) {
    param_05 = 2;
  }

  var_06 = door_pcfov_disableweapons();
  param_00.var_5A30 connectpaths();
  param_00 thread scripts\sp\utility::func_C12D("safe_to_pass", 2.3);
  param_00 func_11EB(param_01, param_02, param_03, param_04, param_05);
  param_00.var_5A30 disconnectpaths();
  if(var_06) {
    level.player enableweapons();
  }
}

door_pcfov_disableweapons() {
  var_00 = 0;
  if(!level.console) {
    var_01 = getdvarfloat("com_fovUserScale");
    var_02 = level.player getcurrentweapon();
    if(var_01 > 1.25 && var_02 != "none" && var_02 != "iw7_gunless") {
      level.player getradiuspathsighttestnodes();
      var_00 = 1;
    }
  }

  return var_00;
}

func_5A2D(param_00, param_01) {
  param_00 = func_794A(param_00);
  param_00 endon("death");
  param_00.var_5A39 = param_01;
  param_00 func_DFE5();
  param_00 thread func_48C7();
}

func_5A2F(param_00) {}

func_5A4D(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = "push";
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(param_01) {
    func_794A(param_00) waittill("safe_to_pass");
  }

  lib_0B6A::func_EC04();
  switch (param_02) {
    case "push":
      self _meth_80F1(func_794A(param_00).var_DB15, func_794A(param_00).var_DB14);
      self give_mp_super_weapon(self.origin);
      break;

    case "pull":
      self _meth_80F1(func_794A(param_00).var_DB15, func_794A(param_00).var_DB14);
      self give_mp_super_weapon(self.origin);
      break;
  }
}

func_5A36(param_00, param_01) {
  var_02 = func_794A(param_00);
  var_02 endon("death");
  var_02 func_DFE5();
  if(isarray(param_01)) {
    foreach(var_04 in param_01) {
      scripts\engine\utility::flag_wait(var_04);
    }
  } else {
    scripts\engine\utility::flag_wait(param_01);
  }

  var_02 thread func_48C7();
}

func_11EB(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_01)) {
    param_01 = 0.4;
  }

  var_05 = scripts\sp\utility::func_10639("player_rig");
  var_06 = level.player _meth_84C6("currentViewModel");
  if(isDefined(var_06)) {
    var_05 setModel(var_06);
  }

  var_05 hide();
  var_07 = [];
  var_07["door"] = self.var_5A3C;
  var_07["player_rig"] = var_05;
  if(isDefined(param_03)) {
    scripts\sp\anim::func_1EC1(var_07, param_00 + "_open");
  } else {
    scripts\sp\anim::func_1EC1(var_07, param_00);
  }

  level.player playSound("shipcrib_door_plr_move_to_door");
  level.player playerlinktoblend(var_05, "tag_player", param_01, 0.2, 0.2);
  if(isDefined(param_02)) {
    self thread[[param_02]]();
  }

  wait(param_01);
  var_05 show();
  if(isDefined(param_03)) {
    switch (self.var_8FDD) {
      case "left":
        level.player playSound("shipcrib_door_left_hinge_push_long_handle_down_open");
        break;

      case "right":
        level.player playSound("shipcrib_door_right_hinge_push_long_handle_down_open");
        break;
    }

    scripts\sp\anim::func_1F2C(var_07, param_00 + "_open");
    thread scripts\sp\anim::func_1EE7(var_07, param_00 + "_hold", "stop_loop");
    wait(param_04);
    self notify("stop_loop");
    switch (self.var_8FDD) {
      case "left":
        self.var_5A3C thread scripts\sp\utility::play_sound_on_tag("shipcrib_door_left_hinge_push_long_release_and_close", "door_locked");
        level.player playSound("shipcrib_door_left_hinge_push_long_plr_move_finish");
        break;

      case "right":
        self.var_5A3C thread scripts\sp\utility::play_sound_on_tag("shipcrib_door_right_hinge_push_long_release_and_close", "door_locked");
        level.player playSound("shipcrib_door_right_hinge_push_long_plr_move_finish");
        break;
    }

    scripts\sp\anim::func_1F2C(var_07, param_00 + "_close");
  } else {
    switch (param_00) {
      case "left_push":
        level.player playSound("shipcrib_door_left_hinge_push_handle_down_open");
        self.var_5A3C scripts\engine\utility::delaythread(2.6, ::scripts\sp\utility::play_sound_on_tag, "shipcrib_door_left_hinge_push_release_and_close", "door_locked");
        break;

      case "left_pull":
        level.player playSound("shipcrib_door_left_hinge_pull_handle_down_open");
        self.var_5A3C scripts\engine\utility::delaythread(2.4, ::scripts\sp\utility::play_sound_on_tag, "shipcrib_door_left_hinge_pull_release_and_close", "door_locked");
        break;

      case "right_push":
        level.player playSound("shipcrib_door_right_hinge_push_handle_down_open");
        self.var_5A3C scripts\engine\utility::delaythread(2.6, ::scripts\sp\utility::play_sound_on_tag, "shipcrib_door_right_hinge_push_release_and_close", "door_locked");
        break;

      case "right_pull":
        level.player playSound("shipcrib_door_right_hinge_pull_handle_down_open");
        self.var_5A3C scripts\engine\utility::delaythread(2.4, ::scripts\sp\utility::play_sound_on_tag, "shipcrib_door_right_hinge_pull_release_and_close", "door_locked");
        break;
    }

    scripts\sp\anim::func_1F2C(var_07, param_00);
  }

  level notify("door_lerp_finished");
  var_05 delete();
  level.player unlink();
}