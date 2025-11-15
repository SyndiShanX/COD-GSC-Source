/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2919.gsc
***************************************/

func_DBCA() {
  precacheshader("hud_radar_background");
  precacheshader("hud_radar_background_yz");
  precacheshader("hud_radar_friendly");
  precacheshader("hud_radar_enemy");
  precacheshader("hud_radar_capital_ship");
}

func_DBC9() {
  self.func_DBC5 = spawnStruct();
  self.func_DBC5.func_26F0 = 0;
  self.func_DBC5.func_1D2C = 0;
  self.func_DBC5.func_26E3 = 0;
  self.func_DBC5.func_1CC7 = 0;
  self.func_DBC6 = [];
  setdvarifuninitialized("radar_color_dist_scaled", 1);
  setdvarifuninitialized("radar_yz", 1);
}

func_DBCC() {
  level.func_DBD5 = 1;

  if(!isDefined(self.func_DBC1)) {
    self.func_DBC1 = scripts\sp\hud_util::func_499B("hud_radar_background", 100, 100);
    self.func_DBC1 scripts\sp\hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -10, -10, 0);
    self.func_DBC1.sort = -10;
    self.func_DBC1.shader = "hud_radar_background";
  } else {
    self.func_DBC1.alpha = 1.0;

    foreach(var_01 in self.func_DBC6)
    var_1.func_DBC2.alpha = 1.0;
  }

  thread func_DBCD();
}

func_DBCD() {
  self endon("radar_remove");

  for(;;) {
    if(scripts\engine\utility::is_true(self.func_DBC5.func_26F0) || scripts\engine\utility::is_true(self.func_DBC5.func_1D2C)) {
      foreach(var_01 in scripts\sp\utility::maymovefrompointtopoint()) {
        var_02 = var_01 func_DBC7();

        if(isDefined(var_02) && (var_02 == "axis" && scripts\engine\utility::is_true(self.func_DBC5.func_26F0) || var_02 == "allies" && scripts\engine\utility::is_true(self.func_DBC5.func_1D2C)))
          func_DBC0(var_01);
      }
    }

    if(scripts\engine\utility::is_true(self.func_DBC5.func_26E3)) {
      foreach(var_05 in _getaiarray("axis"))
      func_DBC0(var_05);
    }

    if(scripts\engine\utility::is_true(self.func_DBC5.func_1CC7)) {
      foreach(var_05 in _getaiarray("allies"))
      func_DBC0(var_05);
    }

    var_09 = anglesToForward(self getplayerangles());
    var_10 = anglestoup(self getplayerangles());
    var_11 = anglestoright(self getplayerangles());
    var_12 = self getEye();

    if(isDefined(self _meth_8473()))
      var_12 = self _meth_8473() gettagorigin("tag_camera");

    foreach(var_14 in self.func_DBC6) {
      var_15 = var_14.origin - var_12;

      if(getdvarint("radar_yz") == 0) {
        func_DBC3(var_14, var_09, var_11, var_10, var_15);
        continue;
      }

      func_DBC4(var_14, var_09, var_11, var_10, var_15);
    }

    if(getdvarint("radar_yz") >= 1 && self.func_DBC1.shader != "hud_radar_background_yz") {
      self.func_DBC1 setshader("hud_radar_background_yz", 100, 100);
      self.func_DBC1.shader = "hud_radar_background_yz";
    } else if(getdvarint("radar_yz") == 0 && self.func_DBC1.shader != "hud_radar_background") {
      self.func_DBC1 setshader("hud_radar_background", 100, 100);
      self.func_DBC1.shader = "hud_radar_background";
    }

    wait 0.05;
  }
}

func_DBC3(var_00, var_01, var_02, var_03, var_04) {
  var_05 = vectordot(var_01, var_04);
  var_06 = vectordot(var_02, var_04);
  var_07 = vectordot(var_03, var_04);
  var_08 = (var_05, var_06, 0);
  var_09 = length(var_08);
  var_10 = vectornormalize(var_08);
  var_09 = _pow(min(var_09 / 63360, 1.0), 0.5);
  var_11 = var_09 * var_10[1] * (self.func_DBC1.width - var_0.func_DBC2.width * 2.0) / 2.0;
  var_12 = var_09 * var_10[0] * -1.0 * (self.func_DBC1.height - var_0.func_DBC2.height * 2.0) / 2.0;
  var_13 = clamp(scripts\engine\utility::sign(var_07) * abs(var_07) / 63360, -1.0, 1.0);
  var_0.func_DBC2 scripts\sp\hud_util::setpoint("", undefined, var_11, var_12, 0.05);

  if(getdvarint("radar_color_dist_scaled") >= 1)
    var_0.func_DBC2.color = (scripts\engine\utility::ter_op(var_13 >= 0, 1.0, _pow(1.0 + var_13, 4)), _pow(1.0 - abs(var_13), 1), scripts\engine\utility::ter_op(var_13 <= 0, 1.0, _pow(1.0 - var_13, 4))) * var_0.func_DBC2.func_439E;
  else
    var_0.func_DBC2.color = (1, 0, 0) * var_0.func_DBC2.func_439E;

  var_0.func_DBC2.alpha = 1.0;

  if(scripts\engine\utility::is_true(var_0.func_DBC2.func_EB9C)) {
    var_14 = _pow(0.75 * (1.0 - var_09) + 0.25, 0.5);
    var_0.func_DBC2.width = int(ceil(var_0.func_DBC2.func_13D1C * var_14));
    var_0.func_DBC2.height = int(ceil(var_0.func_DBC2.func_8D0C * var_14));
    var_0.func_DBC2 scaleovertime(0.25, var_0.func_DBC2.width, var_0.func_DBC2.height);
  }

  if(scripts\engine\utility::is_true(var_0.func_DBC2.func_E6F5)) {
    var_15 = anglesToForward(var_0.angles);
    var_16 = vectordot(var_15, var_01);
    var_17 = vectordot(var_15, var_03);
    var_18 = vectordot(var_15, var_02);
    var_19 = vectornormalize(var_01 * var_16 + var_01 * var_17 + var_02 * var_18);
    var_05 = vectordot(var_01, var_19);
    var_06 = vectordot(var_02, var_19);
    var_0.func_DBC2.rotation = acos(var_05) * scripts\engine\utility::sign(var_06);
  }
}

func_DBC4(var_00, var_01, var_02, var_03, var_04) {
  var_05 = length(var_04);
  var_06 = vectordot(var_01, var_04);

  if(var_06 > 0.0)
    var_04 = vectornormalize(var_04);

  var_07 = vectordot(var_02, var_04);
  var_08 = vectordot(var_03, var_04);
  var_09 = (var_07, var_08, 0);

  if(var_06 <= 0.0)
    var_09 = vectornormalize(var_09);

  var_10 = var_9[0] * (self.func_DBC1.width - var_0.func_DBC2.width * 2.0) / 2.0;
  var_11 = var_9[1] * -1.0 * (self.func_DBC1.height - var_0.func_DBC2.height * 2.0) / 2.0;
  var_12 = clamp(var_05 / 63360, 0.0, 1.0);
  var_0.func_DBC2 scripts\sp\hud_util::setpoint("", undefined, var_10, var_11, 0.05);

  if(getdvarint("radar_color_dist_scaled") >= 1)
    var_0.func_DBC2.color = (0.5 * (1.0 - _pow(var_12, 0.5)) + 0.5, 0.0, 0.0) * var_0.func_DBC2.func_439E;
  else
    var_0.func_DBC2.color = (1, 0, 0) * var_0.func_DBC2.func_439E;

  if(var_0.func_DBC2.shader == "hud_radar_capital_ship")
    var_0.func_DBC2.color = (var_0.func_DBC2.color[0], var_0.func_DBC2.color[0], var_0.func_DBC2.color[0]);

  if(var_06 <= 0.0)
    var_0.func_DBC2.alpha = clamp(1.0 + vectordot(var_01, vectornormalize(var_04)), 0.0, 1.0);

  if(scripts\engine\utility::is_true(var_0.func_DBC2.func_EB9C)) {
    var_13 = _pow(0.75 * (1.0 - _pow(var_12, 2.0)) + 0.25, 0.5);
    var_0.func_DBC2.width = int(ceil(var_0.func_DBC2.func_13D1C * var_13));
    var_0.func_DBC2.height = int(ceil(var_0.func_DBC2.func_8D0C * var_13));
    var_0.func_DBC2 scaleovertime(0.25, var_0.func_DBC2.width, var_0.func_DBC2.height);
  }

  if(scripts\engine\utility::is_true(var_0.func_DBC2.func_E6F5)) {
    var_14 = anglesToForward(var_0.angles);
    var_15 = vectordot(var_14, var_01);
    var_16 = vectordot(var_14, var_03);
    var_17 = vectordot(var_14, var_02);
    var_18 = vectornormalize(var_03 * var_15 + var_03 * var_16 + var_02 * var_17);
    var_06 = vectordot(var_03, var_18);
    var_07 = vectordot(var_02, var_18);
    var_0.func_DBC2.rotation = acos(clamp(var_06, -1.0, 1.0)) * scripts\engine\utility::sign(var_07);
  }
}

func_DBC7() {
  if(isDefined(self.team))
    return self.team;
  else if(isDefined(self.script_team))
    return self.script_team;

  return undefined;
}

func_DBC8() {
  self.func_DBC1.alpha = 0.0;

  foreach(var_01 in self.func_DBC6)
  var_1.func_DBC2.alpha = 0;
}

func_DBCB() {
  self notify("radar_remove");
  level.func_DBD5 = undefined;

  foreach(var_01 in self.func_DBC6)
  func_DBD0(var_01);

  self.func_DBC1 destroy();
  self.func_DBC1 = undefined;
  self.func_DBC6 = [];
}

func_DBC0(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(scripts\engine\utility::array_contains(self.func_DBC6, var_00)) {
    return;
  }
  var_07 = "hud_radar_enemy";
  var_08 = 3;
  var_09 = 3;
  var_10 = 1.0;

  if(isDefined(var_02))
    var_07 = var_02;
  else if(issubstr(var_0.classname, "capitalship")) {
    var_07 = "hud_radar_capital_ship";
    var_08 = 20;
    var_09 = 20;
    var_10 = 0.5;

    if(!isDefined(var_05))
      var_05 = 1;

    if(!isDefined(var_06))
      var_06 = 1;
  } else if(isDefined(var_01) && isenemyteam(var_01, self.team) || isDefined(var_00 func_DBC7()) && isenemyteam(var_00 func_DBC7(), self.team))
    var_07 = "hud_radar_friendly";

  if(isDefined(var_03))
    var_08 = var_03;

  if(isDefined(var_04))
    var_09 = var_04;

  if(!isDefined(self.func_DBC1))
    func_DBCC();

  self.func_DBC6[self.func_DBC6.size] = var_00;
  var_0.func_DBC2 = scripts\sp\hud_util::createicon(var_07, var_08, var_09);
  var_0.func_DBC2 scripts\sp\hud_util::setpoint("", undefined, 0, 0);
  var_0.func_DBC2 scripts\sp\hud_util::setparent(self.func_DBC1);
  var_0.func_DBC2.color = (1, 1, 1);
  var_0.func_DBC2.sort = 10;
  var_0.func_DBC2.shader = var_07;
  var_0.func_DBC2.func_E6F5 = var_05;
  var_0.func_DBC2.func_EB9C = var_06;
  var_0.func_DBC2.func_13D1C = var_08;
  var_0.func_DBC2.func_8D0C = var_09;
  var_0.func_DBC2.func_439E = var_10;

  if(var_08 > 3)
    var_0.func_DBC2.sort = var_0.func_DBC2.sort - 1;

  thread func_DBCF(var_00);
}

func_DBD0(var_00) {
  if(isDefined(var_0.func_DBC2)) {
    var_0.func_DBC2 destroy();
    var_0.func_DBC2 = undefined;
  }

  self.func_DBC6 = scripts\engine\utility::array_remove(self.func_DBC6, var_00);
  var_00 notify("radar_ent_removed");
}

func_DBD3(var_00, var_01) {
  self.func_DBC5.func_26F0 = var_00;
  self.func_DBC5.func_1D2C = var_01;
}

func_DBD2(var_00, var_01) {
  self.func_DBC5.func_26E3 = var_00;
  self.func_DBC5.func_1CC7 = var_01;
}

func_DBCF(var_00) {
  var_00 endon("radar_ent_removed");
  self endon("radar_remove");
  var_00 scripts\engine\utility::waittill_any("death", "entitydeleted");
  thread func_DBD0(var_00);
}