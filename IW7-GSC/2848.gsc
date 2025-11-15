/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2848.gsc
***************************************/

#using_animtree("player");

func_8FE0() {
  level.func_EC87["player_rig"] = #animtree;
  level.func_EC85["player_rig"]["right_push"] = % shipcrib_player_door_right_push;
  level.func_EC85["player_rig"]["right_pull"] = % shipcrib_player_door_right_pull;
  level.func_EC85["player_rig"]["left_push"] = % shipcrib_player_door_left_push;
  level.func_EC85["player_rig"]["left_pull"] = % shipcrib_player_door_left_pull;
  level.func_EC85["player_rig"]["left_push_long_open"] = % shipcrib_plr_door_left_push_long;
  level.func_EC85["player_rig"]["left_push_long_hold"][0] = % shipcrib_plr_door_left_push_long_hold;
  level.func_EC85["player_rig"]["left_push_long_close"] = % shipcrib_plr_door_left_push_long_close_bridge;
  level.func_EC85["player_rig"]["right_push_long_open"] = % shipcrib_plr_door_right_push_long;
  level.func_EC85["player_rig"]["right_push_long_hold"][0] = % shipcrib_plr_door_right_push_long_hold;
  level.func_EC85["player_rig"]["right_push_long_close"] = % shipcrib_plr_door_right_push_long_close;
  level.func_EC85["player_rig"]["armory_enter_open"] = % shipcrib_plr_door_right_push_long;
  level.func_EC85["player_rig"]["armory_enter_hold"][0] = % shipcrib_plr_door_right_push_long_hold;
  level.func_EC85["player_rig"]["armory_enter_close"] = % shipcrib_plr_door_right_push_long_close_armory;
}

#using_animtree("script_model");

func_8FDF() {
  level.func_EC87["door"] = #animtree;
  level.func_EC85["door"]["right_push"] = % shipcrib_door_right_push_open;
  level.func_EC85["door"]["right_pull"] = % shipcrib_door_right_pull_open;
  level.func_EC85["door"]["left_push"] = % shipcrib_door_left_push_open;
  level.func_EC85["door"]["left_pull"] = % shipcrib_door_left_pull_open;
  level.func_EC85["door"]["left_push_long_open"] = % shipcrib_door_left_push_long_open;
  level.func_EC85["door"]["left_push_long_hold"][0] = % shipcrib_door_left_push_long_hold;
  level.func_EC85["door"]["left_push_long_close"] = % shipcrib_door_left_push_long_close;
  level.func_EC85["door"]["right_push_long_open"] = % shipcrib_door_right_push_long_open;
  level.func_EC85["door"]["right_push_long_hold"][0] = % shipcrib_door_right_push_long_hold;
  level.func_EC85["door"]["right_push_long_close"] = % shipcrib_door_right_push_long_close;
  level.func_EC85["door"]["armory_enter_open"] = % shipcrib_door_right_push_long_open;
  level.func_EC85["door"]["armory_enter_hold"][0] = % shipcrib_door_right_push_long_hold;
  level.func_EC85["door"]["armory_enter_close"] = % shipcrib_door_right_push_long_close;
}

func_5A38() {
  func_0B1F::func_5A4B();
  var_00 = [];
  var_00 = scripts\engine\utility::array_combine(var_00, scripts\engine\utility::getstructarray("doors_hinged", "targetname"));

  foreach(var_02 in var_00) {
    var_02 scripts\sp\utility::func_65E0("push_triggered");
    var_02 scripts\sp\utility::func_65E0("pull_triggered");
    var_2.func_5A3C = getent(var_2.target, "targetname");
    var_2.func_5A3C glinton(#animtree);
    var_2.func_5A3C.func_1FBB = "door";
    var_2.func_5A32 = "notbusy";
    var_2.func_5A39 = "normal";

    if(isDefined(var_2.script_parameters)) {
      var_03 = strtok(var_2.script_parameters, " ");
      var_2.func_5A33 = var_3[0];

      if(isDefined(var_3[1])) {
        var_2.func_5A50 = var_3[1];
        level.doors[var_2.func_5A50] = var_02;
      }
    } else
      var_2.func_5A33 = "unlocked";

    switch (var_2.script_noteworthy) {
      case "hinged_left":
        var_2.func_8FDD = "left";
        break;
      case "hinged_right":
        var_2.func_8FDD = "right";
        break;
      default:
        var_2.func_8FDD = "left";
        break;
    }

    var_02 func_8FE0();
    var_02 func_8FDF();
    var_2.func_DB15 = var_2.origin + anglestoright(var_2.angles) * 50;
    var_2.func_DB15 = var_2.func_DB15 + anglesToForward(var_2.angles) * -24;
    var_2.func_DB14 = var_2.angles;
    var_2.func_5A40 = scripts\engine\utility::spawn_tag_origin(var_2.func_5A3C gettagorigin("interact_push"), var_2.func_5A3C gettagangles("interact_push"));
    var_2.func_5A40 linkto(var_2.func_5A3C);
    var_2.func_5A3F = scripts\engine\utility::spawn_tag_origin(var_2.func_5A3C gettagorigin("interact_pull"), var_2.func_5A3C gettagangles("interact_pull"));
    var_2.func_5A3F linkto(var_2.func_5A3C);
    var_02 func_48C7();
    var_2.func_5A4F = squared(80);

    if(isDefined(var_2.func_5A3C.target)) {
      var_04 = getEntArray(var_2.func_5A3C.target, "targetname");

      foreach(var_06 in var_04) {
        if(var_6.classname == "script_brushmodel")
          var_2.func_5A30 = var_06;

        var_06 linkto(var_2.func_5A3C, "j_hinge1");
      }
    }

    if(isDefined(var_2.func_5A50))
      var_2.func_ECCE = func_0EFB::func_7994("shipcrib_door_screen", "script_noteworthy", var_2.func_5A50);

    var_2.func_ECCA = [];

    foreach(var_06 in var_2.func_ECCE) {
      if(var_6.classname != "script_model") {
        var_2.func_ECCE = scripts\engine\utility::array_remove(var_2.func_ECCE, var_06);
        var_2.func_ECCA = scripts\engine\utility::array_add(var_2.func_ECCA, var_06);
      }
    }

    var_2.func_5A40 thread func_9013(var_02, "push_triggered");
    var_2.func_5A3F thread func_9013(var_02, "pull_triggered");
    var_02 thread func_5A4E();
  }
}

func_5A55(var_00) {
  switch (var_00) {
    case "unlocked":
      self.func_5A3C giveperk("door_unlocked");
      self.func_5A3C hidepart("door_locked");
      self.func_5A3C hidepart("door_inactive");
      func_48C7();
      func_5A42(var_00);
      break;
    case "locked":
      self.func_5A3C giveperk("door_locked");
      self.func_5A3C hidepart("door_unlocked");
      self.func_5A3C hidepart("door_inactive");
      func_DFE5();
      func_5A42(var_00);
      break;
    case "automatic":
      self.func_5A3C hidepart("door_unlocked");
      self.func_5A3C hidepart("door_locked");
      self.func_5A3C hidepart("door_inactive");
      func_DFE5();
      func_5A42(var_00);
      break;
    case "open":
      self.func_5A3C giveperk("door_inactive");
      self.func_5A3C hidepart("door_unlocked");
      self.func_5A3C hidepart("door_locked");
      func_DFE5();
      func_5A42(var_00);
      break;
  }
}

func_5A42(var_00) {
  self endon("death");

  if(!isDefined(self.func_ECCE) || self.func_ECCE.size == 0) {
    return;
  }
  scripts\engine\utility::array_call(self.func_ECCE, ::_meth_8184);

  switch (var_00) {
    case "unlocked":
      scripts\engine\utility::array_call(self.func_ECCE, ::giveperk, "tag_unlocked");
      scripts\engine\utility::array_thread(self.func_ECCA, scripts\sp\lights::func_AB83, 0.009, 0.05);
      scripts\engine\utility::array_thread(self.func_ECCA, scripts\sp\lights::func_3C57, (0.26, 0.98, 0.18), 0.05);
      break;
    case "locked":
      scripts\engine\utility::array_call(self.func_ECCE, ::giveperk, "tag_locked");
      scripts\engine\utility::array_thread(self.func_ECCA, scripts\sp\lights::func_AB83, 0.009, 0.05);
      scripts\engine\utility::array_thread(self.func_ECCA, scripts\sp\lights::func_3C57, (0.98, 0.18, 0.26), 0.05);
      break;
    case "automatic":
      scripts\engine\utility::array_call(self.func_ECCE, ::giveperk, "tag_unlocked");
      break;
    case "open":
      scripts\engine\utility::array_call(self.func_ECCE, ::giveperk, "tag_unlocked");
      scripts\engine\utility::array_thread(self.func_ECCA, scripts\sp\lights::func_AB83, 0.009, 0.05);
      scripts\engine\utility::array_thread(self.func_ECCA, scripts\sp\lights::func_3C57, (0.26, 0.98, 0.18), 0.05);
      break;
  }
}

func_48C7() {
  switch (self.func_5A39) {
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

  self.func_5A40 func_0E46::func_48C4(undefined, undefined, undefined, var_00, var_02, 50, var_01, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  self.func_5A3F func_0E46::func_48C4(undefined, undefined, undefined, var_00, var_02, 50, var_01, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  self.func_5A39 = "normal";
}

func_DFE5() {
  self.func_5A40 func_0E46::func_DFE3();
  self.func_5A3F func_0E46::func_DFE3();
}

func_9013(var_00, var_01) {
  var_00 endon("death");
  self endon("death");

  for(;;) {
    var_00 scripts\sp\utility::func_65DD("push_triggered");
    var_00 scripts\sp\utility::func_65DD("pull_triggered");
    self waittill("trigger");
    var_00 scripts\sp\utility::func_65E1(var_01);
    var_00 func_DFE5();
  }
}

func_5A4E() {
  self endon("death");
  self endon("other_side_triggered");
  thread func_5A55(self.func_5A33);

  for(;;) {
    if(self.func_5A33 == "open" && self.func_5A32 != "busy") {
      self.func_5A32 = "busy";
      thread func_5A55(self.func_5A33);
      func_5A34("open");
    } else if(self.func_5A33 == "unlocked" || self.func_5A33 == "automatic") {
      if((scripts\sp\utility::func_65DB("push_triggered") || scripts\sp\utility::func_65DB("pull_triggered")) && self.func_5A32 != "busy") {
        self.func_5A32 = "busy";

        if(isDefined(self.func_5A52)) {
          self.func_1212 = undefined;

          if(self.func_5A53 == "pushpull")
            self.func_1212 = self.func_5A52;
          else if(self.func_5A53 == "push") {
            if(scripts\sp\utility::func_65DB("push_triggered"))
              self.func_1212 = self.func_5A52;
          } else if(self.func_5A53 == "pull") {
            if(scripts\sp\utility::func_65DB("pull_triggered"))
              self.func_1212 = self.func_5A52;
          }

          func_DFE5();

          if(isDefined(self.func_1212)) {
            if(self.func_5A54)
              self.func_5A52 = undefined;

            self[[self.func_1212]]();
            self.func_1212 = undefined;
          }
        } else {
          func_DFE5();
          func_5A34();
        }

        thread func_48C7();
      } else if((!scripts\sp\utility::func_65DB("push_triggered") || !scripts\sp\utility::func_65DB("pull_triggered")) && self.func_5A32 != "notbusy") {
        self.func_5A32 = "notbusy";
        thread func_5A55(self.func_5A33);
        func_5A34("close");
      }
    } else if(self.func_5A33 == "locked" && self.func_5A32 != "notbusy") {
      self.func_5A32 = "notbusy";
      thread func_5A55(self.func_5A33);
      func_5A34("close");
    }

    scripts\engine\utility::waitframe();
  }
}

func_5A34(var_00) {
  if(func_5A3D(self))
    var_01 = "pull";
  else
    var_01 = "push";

  var_02 = self.func_8FDD + "_" + var_01;

  if(isDefined(var_00)) {
    switch (var_00) {
      case "open":
        self.func_5A3C give_attacker_kill_rewards(self.func_5A3C scripts\sp\utility::func_7DC1(var_02));
        return;
      case "close":
        self.func_5A3C setanimknob(self.func_5A3C scripts\sp\utility::func_7DC1(var_02), 1, 0, 0);
        return;
    }
  }

  func_11EB(var_02);
}

func_5A3D(var_00) {
  var_01 = scripts\sp\utility::func_7951(var_0.origin, var_0.angles, level.player.origin);

  if(var_01 > 0)
    return 1;
  else
    return 0;
}

func_5A2E(var_00, var_01, var_02) {
  if(isstring(var_00))
    var_03 = level.doors[var_00];
  else
    var_03 = var_00;

  if(isDefined(var_02))
    var_3.func_5A39 = var_02;

  var_3.func_5A33 = var_01;
  var_3.func_5A32 = "notbusy";
  var_03 thread func_5A55(var_3.func_5A33);
}

func_5A2C(var_00) {
  if(!isDefined(var_00)) {}

  self.func_5A3A = var_00;
}

func_5A52(var_00, var_01, var_02, var_03) {
  var_04 = level.doors[var_00];
  var_04 endon("death");

  if(!isDefined(var_03))
    var_03 = "pushpull";

  var_4.func_5A53 = var_03;
  var_4.func_5A52 = var_01;

  if(!isDefined(var_02))
    var_4.func_5A54 = 1;
  else
    var_4.func_5A54 = var_02;
}

func_794A(var_00) {
  return level.doors[var_00];
}

func_AB71(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_00 endon("death");

  if(!isDefined(var_05))
    var_05 = 2;

  var_06 = door_pcfov_disableweapons();
  var_0.func_5A30 connectpaths();
  var_00 thread scripts\sp\utility::func_C12D("safe_to_pass", 2.3);
  var_00 func_11EB(var_01, var_02, var_03, var_04, var_05);
  var_0.func_5A30 disconnectpaths();

  if(var_06)
    level.player enableweapons();
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

func_5A2D(var_00, var_01) {
  var_00 = func_794A(var_00);
  var_00 endon("death");
  var_0.func_5A39 = var_01;
  var_00 func_DFE5();
  var_00 thread func_48C7();
}

func_5A2F(var_00) {}

func_5A4D(var_00, var_01, var_02) {
  if(!isDefined(var_02))
    var_02 = "push";

  if(!isDefined(var_01))
    var_01 = 0;

  if(var_01)
    func_794A(var_00) waittill("safe_to_pass");

  func_0B6A::func_EC04();

  switch (var_02) {
    case "push":
      self _meth_80F1(func_794A(var_00).func_DB15, func_794A(var_00).func_DB14);
      self give_mp_super_weapon(self.origin);
      break;
    case "pull":
      self _meth_80F1(func_794A(var_00).func_DB15, func_794A(var_00).func_DB14);
      self give_mp_super_weapon(self.origin);
      break;
  }
}

func_5A36(var_00, var_01) {
  var_02 = func_794A(var_00);
  var_02 endon("death");
  var_02 func_DFE5();

  if(isarray(var_01)) {
    foreach(var_04 in var_01)
    scripts\engine\utility::flag_wait(var_04);
  } else
    scripts\engine\utility::flag_wait(var_01);

  var_02 thread func_48C7();
}

func_11EB(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_01))
    var_01 = 0.4;

  var_05 = scripts\sp\utility::func_10639("player_rig");
  var_06 = level.player _meth_84C6("currentViewModel");

  if(isDefined(var_06))
    var_05 setModel(var_06);

  var_05 hide();
  var_07 = [];
  var_7["door"] = self.func_5A3C;
  var_7["player_rig"] = var_05;

  if(isDefined(var_03))
    scripts\sp\anim::func_1EC1(var_07, var_00 + "_open");
  else
    scripts\sp\anim::func_1EC1(var_07, var_00);

  level.player playSound("shipcrib_door_plr_move_to_door");
  level.player getweaponweight(var_05, "tag_player", var_01, 0.2, 0.2);

  if(isDefined(var_02))
    self thread[[var_02]]();

  wait(var_01);
  var_05 show();

  if(isDefined(var_03)) {
    switch (self.func_8FDD) {
      case "left":
        level.player playSound("shipcrib_door_left_hinge_push_long_handle_down_open");
        break;
      case "right":
        level.player playSound("shipcrib_door_right_hinge_push_long_handle_down_open");
        break;
    }

    scripts\sp\anim::func_1F2C(var_07, var_00 + "_open");
    thread scripts\sp\anim::func_1EE7(var_07, var_00 + "_hold", "stop_loop");
    wait(var_04);
    self notify("stop_loop");

    switch (self.func_8FDD) {
      case "left":
        self.func_5A3C thread scripts\sp\utility::play_sound_on_tag("shipcrib_door_left_hinge_push_long_release_and_close", "door_locked");
        level.player playSound("shipcrib_door_left_hinge_push_long_plr_move_finish");
        break;
      case "right":
        self.func_5A3C thread scripts\sp\utility::play_sound_on_tag("shipcrib_door_right_hinge_push_long_release_and_close", "door_locked");
        level.player playSound("shipcrib_door_right_hinge_push_long_plr_move_finish");
        break;
    }

    scripts\sp\anim::func_1F2C(var_07, var_00 + "_close");
  } else {
    switch (var_00) {
      case "left_push":
        level.player playSound("shipcrib_door_left_hinge_push_handle_down_open");
        self.func_5A3C scripts\engine\utility::delaythread(2.6, scripts\sp\utility::play_sound_on_tag, "shipcrib_door_left_hinge_push_release_and_close", "door_locked");
        break;
      case "left_pull":
        level.player playSound("shipcrib_door_left_hinge_pull_handle_down_open");
        self.func_5A3C scripts\engine\utility::delaythread(2.4, scripts\sp\utility::play_sound_on_tag, "shipcrib_door_left_hinge_pull_release_and_close", "door_locked");
        break;
      case "right_push":
        level.player playSound("shipcrib_door_right_hinge_push_handle_down_open");
        self.func_5A3C scripts\engine\utility::delaythread(2.6, scripts\sp\utility::play_sound_on_tag, "shipcrib_door_right_hinge_push_release_and_close", "door_locked");
        break;
      case "right_pull":
        level.player playSound("shipcrib_door_right_hinge_pull_handle_down_open");
        self.func_5A3C scripts\engine\utility::delaythread(2.4, scripts\sp\utility::play_sound_on_tag, "shipcrib_door_right_hinge_pull_release_and_close", "door_locked");
        break;
    }

    scripts\sp\anim::func_1F2C(var_07, var_00);
  }

  level notify("door_lerp_finished");
  var_05 delete();
  level.player unlink();
}