/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3658.gsc
**************************************/

_id_84BB() {
  precachemodel("tag_origin");
  setDvar("grapple_recharge_time", 7);
}

_id_84B9() {
  self takeweapon("grappling_hook");

  if(self._id_110B5 != "none") {
    scripts\engine\utility::waitframe();
    self giveweapon(self._id_110B5);
    self setweaponammostock(self._id_110B5, self._id_110B6);
  }

  level.player scripts\engine\utility::allow_offhand_secondary_weapons(1);

  if(isDefined(self.marker))
    self.marker delete();

  if(isDefined(self.icon))
    self.icon destroy();

  self notify("disable_grappling_hook");
  self._id_849A = undefined;
  self._id_4B7C = undefined;
}

_id_84BA() {
  self endon("death");
  setDvar("analog_grapple", "off");

  if(!_id_8B80()) {
    scripts\engine\utility::allow_offhand_secondary_weapons(0);
    self._id_110B5 = self getcurrentoffhand();
    self._id_110B6 = self getweaponammostock(self._id_110B5);
    self takeweapon(self._id_110B5);
    self giveweapon("grappling_hook");
  }

  self._id_9BF5 = 0;
  self._id_4610 = 0;
  self notifyonplayercommand("grapple_prep", "+frag");
  thread _id_11A9F();

  if(isDefined(self._id_849A)) {
    return;
  }
  self._id_849A = 1;
  thread _id_11A9E();
  thread _id_11A9D();
  thread _id_DDD0();

  while(_id_0E4F::_id_9C7B()) {
    var_0 = undefined;
    var_1 = scripts\engine\utility::waittill_any_return("grapple", "disable_grappling_hook");

    if(scripts\sp\utility::_id_65DB("player_gravity_off") && var_1 == "grapple") {
      var_2 = 1;

      if(!isDefined(self._id_4B7C)) {
        var_3 = anglesToForward(self getplayerangles());
        var_4 = self getEye();
        var_5 = var_4 + var_3 * 3000;
        var_6 = scripts\common\trace::ray_trace(var_4, var_5, self);
        self._id_A8C5 = var_6;

        if(var_6["fraction"] < 1) {
          var_2 = 0;
          self._id_4B7C = spawnStruct();
          self._id_4B7C.origin = var_6["position"];
          self._id_4B7C.angles = vectortoangles(-1 * var_6["normal"]);
        }
      }

      if(!isDefined(self._id_4B7C)) {
        wait 0.1;
        self notify("replenish_ammo");
        continue;
      }

      self notify("start_grappling");
      var_7 = self._id_4B7C;
      var_8 = max(0, vectordot((0, 0, 1), anglesToForward(self._id_4B7C.angles)));
      self allowads(0);
      self _meth_80D8(0.6, 0.6);
      var_9 = scripts\engine\utility::spawn_tag_origin();
      var_9.origin = self.origin + (0, 0, 32);
      var_9.angles = vectortoangles(var_7.origin - var_9.origin);
      var_10 = scripts\engine\utility::spawn_tag_origin();
      var_10.origin = self.origin;
      var_10.angles = var_9.angles;
      var_10 linkTo(var_9);
      var_11 = spawn("script_model", self getEye() + (0, 0, 32));
      var_11 setModel("tag_origin");
      var_11.angles = self getplayerangles() - (90, 0, 0);

      if(isDefined(var_7._id_84A4)) {
        var_12 = self[[var_7._id_84A4]](var_9, var_11, var_2);

        if(!isDefined(var_12) || !var_12)
          continue;
      }

      var_13 = 600;
      var_14 = distance(var_9.origin, var_7.origin);
      var_15 = min(var_14 / var_13, 1.0);
      var_16 = max(var_15 - 0.24, 0);
      var_17 = var_9.angles;
      self._id_9BF5 = 1;
      var_11 thread _id_5B7B(self);
      var_11 moveTo(var_7.origin, 0.12);
      var_18 = var_15 * 0.8;
      self _meth_823C(var_10, "tag_origin", var_18);
      var_11 rotateTo(var_7.angles - (90, 0, 0), 0.1);
      _id_CD2F(var_11);
      var_11 waittill("movedone");

      if(isDefined(self._id_84A4)) {
        self[[self._id_84A4]](var_9, var_11, var_15, var_10);
        continue;
      }

      var_3 = anglesToForward(var_7.angles) * (16 + var_8 * 96);
      var_19 = scripts\common\trace::ray_trace(var_7.origin - var_3, var_7.origin - var_3 + (0, 0, 96), self);
      var_20 = (0, 0, 96) * (1 - var_19["fraction"]);
      var_3 = var_3 + var_20;

      if(!scripts\sp\utility::_id_D0F4())
        var_3 = var_3 + (0, 0, 32);

      self _meth_81DE(80, var_15 * 0.4);
      var_21 = var_7;
      var_9 thread _id_BCDC(self);
      var_22 = 10;
      var_23 = scripts\common\trace::sphere_trace(level.player.origin + (0, 0, 32), var_21.origin + (0, 0, 34), var_22, level.player);
      var_24 = var_23["position"];
      var_25 = 0;

      while(var_25 < 10) {
        if(!scripts\common\trace::capsule_trace_passed(var_24 - (0, 0, 34), var_24 - (0, 0, 34), 70, 140, level.player.angles, level.player)) {
          var_26 = vectortoangles(var_24 - level.player.origin);
          var_27 = anglesToForward(var_26);
          var_24 = var_24 - var_27 * 30;
        } else {
          var_0 = var_24;
          break;
        }

        var_25++;
        wait 0.05;
      }

      if(isDefined(var_0)) {
        var_9 moveTo(var_0, var_15, var_15, 0);

        if(!scripts\sp\utility::_id_D0F4()) {
          var_9 rotateTo(var_17, var_15 * 0.4, var_15 * 0.4, 0);
          var_9 waittill("rotatedone");
          var_9 rotateTo(var_21.angles, var_15 * 0.4, var_15 * 0.4, 0);
        }

        thread scripts\sp\utility::_id_C12D("grapple_land", var_16);
        thread _id_3D62(var_9, var_21.origin - var_3);
        var_28 = var_9 scripts\engine\utility::waittill_any_return("movedone", "cancel");

        if(var_28 == "movedone")
          self notify("grapple_complete");
      }

      self _meth_81DE(65, 0.3);
      self enableweapons();
      self _meth_80A6();
      var_11 stopsounds();
      _id_CD2E(var_11);

      while(self adsButtonPressed() && !self buttonPressed("BUTTON_A") && !self buttonPressed("BUTTON_B") && !_id_9C5A() && (!isDefined(self._id_13E84) || !self._id_13E84)) {
        self notify("stop_damage");
        scripts\engine\utility::waitframe();
      }

      self allowads(1);

      if(var_2 && !self buttonPressed("BUTTON_B")) {
        var_3 = anglesToForward(var_7.angles) * 32;
        var_9 moveTo(var_7.origin + (0, 0, 8) + var_3, 0.3);
        var_9 waittill("movedone");
      }

      var_29 = self getlinkedparent();

      if(isDefined(var_29) && var_29 == var_10)
        self unlink();

      scripts\engine\utility::waitframe();
      var_11 delete();
      self._id_9BF5 = 0;
      var_9 delete();
      var_10 delete();
    }
  }
}

_id_8497(var_0, var_1) {
  level.player endon("disable_grappling_hook");
  level._id_84A6 = [];
  var_2 = scripts\common\trace::player_trace_get_all_results(var_0, var_1);

  for(;;) {}
}

_id_4EC9(var_0, var_1, var_2) {
  for(;;) {
    scripts\sp\utility::draw_line(level.player.origin, var_2.origin, 1, 0, 0);
    scripts\engine\utility::waitframe();
  }
}

_id_3D62(var_0, var_1) {
  var_0 endon("movedone");

  for(;;) {
    if(self buttonPressed("BUTTON_B") || self buttonPressed("BUTTON_A")) {
      var_0 notify("cancel");
      var_2 = vectorNormalize(var_1 - var_0.origin);
      level notify("player_SwimWaterCurrent_lerp_savedDvar");
      setsaveddvar("player_SwimWaterCurrent", var_2 * 15000);
      thread _id_AB9C("player_SwimWaterCurrent", (0, 0, 0), 2);
      return;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_D124() {
  if(scripts\sp\utility::_id_65DF("player_indoors") && scripts\sp\utility::_id_65DB("player_indoors"))
    return 0;

  return 1;
}

_id_BCDC(var_0) {
  self endon("death");
  self endon("stop_damage");

  for(;;)
    scripts\engine\utility::waitframe();
}

_id_11A9F() {
  self endon("disable_grappling_hook");
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_1 = newhudelem();
  var_1 setshader("grappling_hook_target", 15, 15);
  var_1 setwaypoint(1, 1, 0);
  var_1 settargetEnt(var_0);
  var_1.alpha = 0;
  self.marker = var_0;
  self.icon = var_1;
  level._id_84AA = scripts\engine\utility::getStructArray("grapple_point", "targetname");

  for(;;) {
    self._id_4B7C = undefined;

    if(self._id_9BF5 || !_id_8B80()) {
      var_1.alpha = 0;
      scripts\engine\utility::waitframe();
      continue;
    }

    var_2 = level._id_84AA;
    var_2 = sortbydistance(var_2, self.origin);
    var_3 = [];

    foreach(var_5 in var_2) {
      var_6 = 0;

      if(isDefined(var_5._id_8494))
        var_6 = var_5[[var_5._id_8494]](self);

      if(!var_6 && (distance2d(var_5.origin, self.origin) > 400 || abs(var_5.origin[2] - self.origin[2]) > 256)) {
        break;
      }

      var_7 = 0.8;

      if(isDefined(var_5._id_84A1))
        var_7 = var_5._id_84A1;

      var_8 = var_5.origin - (0, 0, var_5.origin[2]);
      var_9 = self getEye();
      var_9 = var_9 - (0, 0, var_9[2]);
      var_10 = vectortoangles(var_8 - var_9);
      var_11 = anglesToForward(var_10);
      var_11 = (var_11[0], var_11[1], 0);
      var_12 = self.angles;
      var_13 = anglesToForward(var_12);
      var_14 = vectordot(var_11, var_13);
      var_5.dot = var_14;

      if(var_14 > var_7)
        var_3 = scripts\engine\utility::array_add(var_3, var_5);
    }

    var_2 = [];

    foreach(var_5 in var_3) {
      var_7 = 0.5;

      if(isDefined(var_5._id_84A2))
        var_7 = var_5._id_84A2;

      var_8 = var_5.origin;
      var_11 = anglesToForward(var_5.angles);
      var_12 = self.angles;
      var_13 = anglesToForward(var_12);
      var_14 = vectordot(var_11, var_13);

      if(var_14 > var_7)
        var_2 = scripts\engine\utility::array_add(var_2, var_5);
    }

    for(var_18 = 0; var_18 < var_2.size; var_18++) {
      for(var_19 = var_18 + 1; var_19 < var_2.size; var_19++) {
        if(var_2[var_19].dot > var_2[var_18].dot) {
          var_20 = var_2[var_18];
          var_2[var_18] = var_2[var_19];
          var_2[var_19] = var_20;
        }
      }
    }

    foreach(var_5 in var_2) {
      var_22 = scripts\common\trace::ray_trace(self getEye(), var_5.origin, self);
      var_23 = 0.9;

      if(isDefined(var_5._id_84A3))
        var_23 = var_5._id_84A3;

      if(var_22["fraction"] > var_23) {
        self._id_4B7C = var_5;
        break;
      }
    }

    if(isDefined(self._id_4B7C)) {
      var_25 = (0, 0, 0);

      if(isDefined(self._id_4B7C._id_84A5))
        var_25 = self._id_4B7C._id_84A5;

      var_0.origin = self._id_4B7C.origin + var_25;
      var_1.alpha = 1;
    } else
      var_1.alpha = 0;

    scripts\engine\utility::waitframe();
  }
}

_id_11A9E() {
  level.player endon("disable_grappling_hook");

  while(level.player scripts\sp\utility::_id_65DB("player_gravity_off")) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 != "grappling_hook") {
      continue;
    }
    var_0 delete();
    self notify("grapple");
    self._id_4610 = 0;
  }
}

_id_11A9D() {
  level.player endon("disable_grappling_hook");

  while(level.player scripts\sp\utility::_id_65DB("player_gravity_off")) {
    self waittill("grapple_prep");
    self._id_4610 = 1;
  }
}

_id_5B7B(var_0) {
  self endon("death");

  while(level.player scripts\sp\utility::_id_65DB("player_gravity_off")) {
    var_1 = var_0 getEye();
    var_2 = var_1 - anglestoup(var_0.angles) * 15;
    scripts\engine\utility::waitframe();
  }
}

_id_9C5A() {
  var_0 = scripts\common\trace::ray_trace(self.origin + (0, 0, 1), self.origin - (0, 0, 64), self);
  var_1 = var_0["fraction"] < 0.9;
  return var_1;
}

_id_AB9C(var_0, var_1, var_2) {
  var_3 = getdvarvector(var_0);
  var_4 = var_3;
  level notify(var_0 + "_lerp_savedDvar");
  level endon(var_0 + "_lerp_savedDvar");
  var_5 = 0.0;
  var_6 = var_1 - var_3;
  var_7 = 0.05 / var_2;

  while(var_5 < 1.0) {
    var_4 = var_3 + var_5 * var_6;
    setsaveddvar(var_0, var_4);
    var_5 = var_5 + var_7;
    scripts\engine\utility::waitframe();
  }

  setsaveddvar(var_0, var_1);
}

_id_8B80() {
  var_0 = self getweaponslistall();

  foreach(var_2 in var_0) {
    if(var_2 == "grappling_hook" && self getweaponammostock(var_2) > 0)
      return 1;
  }

  return 0;
}

_id_DDD0() {
  self endon("death");

  while(level.player scripts\sp\utility::_id_65DB("player_gravity_off")) {
    var_0 = scripts\engine\utility::waittill_any_return("start_grappling", "replenish_ammo");
    var_1 = getdvarint("grapple_recharge_time", 15);

    if(var_0 == "start_grappling")
      _id_13658(2);

    self givemaxammo("grappling_hook");
    self notify("give_ammo", "grappling_hook", 1);
  }
}

_id_13658(var_0) {
  var_1 = 0.05;
  var_2 = 0;

  if(var_0 <= 0) {
    return;
  }
  var_3 = 0;
  level.player disableoffhandweapons();

  for(;;) {
    var_2 = var_2 + var_1;

    if(var_2 >= var_0) {
      var_3 = 1;
      break;
    }

    wait(var_1);
  }

  level.player enableoffhandweapons();
}

_id_10DE1(var_0) {
  self._id_84A7 = _id_4A0D();
}

_id_F80E(var_0) {
  if(var_0 > 1)
    var_0 = 1;

  self._id_84A7 scripts\sp\hud_util::updatebar(var_0);
}

_id_6379() {
  self notify("progress_bar_ended");
  self._id_84A7 scripts\sp\hud_util::destroyelem();
}

_id_4A0D() {
  var_0 = scripts\sp\hud_util::_id_4997("white", "black", 45, 5, 0, 0, 0);
  var_0 scripts\sp\hud_util::setpoint("LEFT BOTTOM", "LEFT BOTTOM", 0, -28);
  return var_0;
}

_id_CD2F(var_0) {
  var_1 = "grapple_start";

  if(_id_D124())
    var_1 = var_1 + "_space";

  var_0 playSound(var_1);
}

_id_CD2E(var_0) {
  var_1 = "grapple_end";

  if(_id_D124())
    var_1 = var_1 + "_space";

  self playSound(var_1);
}