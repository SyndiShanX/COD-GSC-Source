/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2919.gsc
**************************************/

func_DBCA() {
  precacheshader("hud_radar_background");
  precacheshader("hud_radar_background_yz");
  precacheshader("hud_radar_friendly");
  precacheshader("hud_radar_enemy");
  precacheshader("hud_radar_capital_ship");
}

func_DBC9() {
  self.var_DBC5 = spawnStruct();
  self.var_DBC5.var_26F0 = 0;
  self.var_DBC5.var_1D2C = 0;
  self.var_DBC5.var_26E3 = 0;
  self.var_DBC5.var_1CC7 = 0;
  self.var_DBC6 = [];
  setdvarifuninitialized("radar_color_dist_scaled", 1);
  setdvarifuninitialized("radar_yz", 1);
}

func_DBCC() {
  level.var_DBD5 = 1;

  if(!isDefined(self.var_DBC1)) {
    self.var_DBC1 = scripts\sp\hud_util::func_499B("hud_radar_background", 100, 100);
    self.var_DBC1 scripts\sp\hud_util::setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", -10, -10, 0);
    self.var_DBC1.sort = -10;
    self.var_DBC1.shader = "hud_radar_background";
  } else {
    self.var_DBC1.alpha = 1.0;

    foreach(var_1 in self.var_DBC6) {
      var_1.var_DBC2.alpha = 1.0;
    }
  }

  thread func_DBCD();
}

func_DBCD() {
  self endon("radar_remove");

  for(;;) {
    if(scripts\engine\utility::is_true(self.var_DBC5.var_26F0) || scripts\engine\utility::is_true(self.var_DBC5.var_1D2C)) {
      foreach(var_1 in scripts\sp\utility::maymovefrompointtopoint()) {
        var_2 = var_1 func_DBC7();

        if(isDefined(var_2) && (var_2 == "axis" && scripts\engine\utility::is_true(self.var_DBC5.var_26F0) || var_2 == "allies" && scripts\engine\utility::is_true(self.var_DBC5.var_1D2C))) {
          func_DBC0(var_1);
        }
      }
    }

    if(scripts\engine\utility::is_true(self.var_DBC5.var_26E3)) {
      foreach(var_5 in _getaiarray("axis")) {
        func_DBC0(var_5);
      }
    }

    if(scripts\engine\utility::is_true(self.var_DBC5.var_1CC7)) {
      foreach(var_5 in _getaiarray("allies")) {
        func_DBC0(var_5);
      }
    }

    var_9 = anglesToForward(self getplayerangles());
    var_10 = anglestoup(self getplayerangles());
    var_11 = anglestoright(self getplayerangles());
    var_12 = self getEye();

    if(isDefined(self func_8473())) {
      var_12 = self func_8473() gettagorigin("tag_camera");
    }

    foreach(var_14 in self.var_DBC6) {
      var_15 = var_14.origin - var_12;

      if(getdvarint("radar_yz") == 0) {
        func_DBC3(var_14, var_9, var_11, var_10, var_15);
        continue;
      }

      func_DBC4(var_14, var_9, var_11, var_10, var_15);
    }

    if(getdvarint("radar_yz") >= 1 && self.var_DBC1.shader != "hud_radar_background_yz") {
      self.var_DBC1 setshader("hud_radar_background_yz", 100, 100);
      self.var_DBC1.shader = "hud_radar_background_yz";
    } else if(getdvarint("radar_yz") == 0 && self.var_DBC1.shader != "hud_radar_background") {
      self.var_DBC1 setshader("hud_radar_background", 100, 100);
      self.var_DBC1.shader = "hud_radar_background";
    }

    wait 0.05;
  }
}

func_DBC3(var_0, var_1, var_2, var_3, var_4) {
  var_5 = vectordot(var_1, var_4);
  var_6 = vectordot(var_2, var_4);
  var_7 = vectordot(var_3, var_4);
  var_8 = (var_5, var_6, 0);
  var_9 = length(var_8);
  var_10 = vectornormalize(var_8);
  var_9 = _pow(min(var_9 / 63360, 1.0), 0.5);
  var_11 = var_9 * var_10[1] * (self.var_DBC1.width - var_0.var_DBC2.width * 2.0) / 2.0;
  var_12 = var_9 * var_10[0] * -1.0 * (self.var_DBC1.height - var_0.var_DBC2.height * 2.0) / 2.0;
  var_13 = clamp(scripts\engine\utility::sign(var_7) * abs(var_7) / 63360, -1.0, 1.0);
  var_0.var_DBC2 scripts\sp\hud_util::setpoint("", undefined, var_11, var_12, 0.05);

  if(getdvarint("radar_color_dist_scaled") >= 1) {
    var_0.var_DBC2.color = (scripts\engine\utility::ter_op(var_13 >= 0, 1.0, _pow(1.0 + var_13, 4)), _pow(1.0 - abs(var_13), 1), scripts\engine\utility::ter_op(var_13 <= 0, 1.0, _pow(1.0 - var_13, 4))) * var_0.var_DBC2.var_439E;
  } else {
    var_0.var_DBC2.color = (1, 0, 0) * var_0.var_DBC2.var_439E;
  }

  var_0.var_DBC2.alpha = 1.0;

  if(scripts\engine\utility::is_true(var_0.var_DBC2.var_EB9C)) {
    var_14 = _pow(0.75 * (1.0 - var_9) + 0.25, 0.5);
    var_0.var_DBC2.width = int(ceil(var_0.var_DBC2.var_13D1C * var_14));
    var_0.var_DBC2.height = int(ceil(var_0.var_DBC2.var_8D0C * var_14));
    var_0.var_DBC2 scaleovertime(0.25, var_0.var_DBC2.width, var_0.var_DBC2.height);
  }

  if(scripts\engine\utility::is_true(var_0.var_DBC2.var_E6F5)) {
    var_15 = anglesToForward(var_0.angles);
    var_16 = vectordot(var_15, var_1);
    var_17 = vectordot(var_15, var_3);
    var_18 = vectordot(var_15, var_2);
    var_19 = vectornormalize(var_1 * var_16 + var_1 * var_17 + var_2 * var_18);
    var_5 = vectordot(var_1, var_19);
    var_6 = vectordot(var_2, var_19);
    var_0.var_DBC2.rotation = acos(var_5) * scripts\engine\utility::sign(var_6);
  }
}

func_DBC4(var_0, var_1, var_2, var_3, var_4) {
  var_5 = length(var_4);
  var_6 = vectordot(var_1, var_4);

  if(var_6 > 0.0) {
    var_4 = vectornormalize(var_4);
  }

  var_7 = vectordot(var_2, var_4);
  var_8 = vectordot(var_3, var_4);
  var_9 = (var_7, var_8, 0);

  if(var_6 <= 0.0) {
    var_9 = vectornormalize(var_9);
  }

  var_10 = var_9[0] * (self.var_DBC1.width - var_0.var_DBC2.width * 2.0) / 2.0;
  var_11 = var_9[1] * -1.0 * (self.var_DBC1.height - var_0.var_DBC2.height * 2.0) / 2.0;
  var_12 = clamp(var_5 / 63360, 0.0, 1.0);
  var_0.var_DBC2 scripts\sp\hud_util::setpoint("", undefined, var_10, var_11, 0.05);

  if(getdvarint("radar_color_dist_scaled") >= 1) {
    var_0.var_DBC2.color = (0.5 * (1.0 - _pow(var_12, 0.5)) + 0.5, 0.0, 0.0) * var_0.var_DBC2.var_439E;
  } else {
    var_0.var_DBC2.color = (1, 0, 0) * var_0.var_DBC2.var_439E;
  }

  if(var_0.var_DBC2.shader == "hud_radar_capital_ship") {
    var_0.var_DBC2.color = (var_0.var_DBC2.color[0], var_0.var_DBC2.color[0], var_0.var_DBC2.color[0]);
  }

  if(var_6 <= 0.0) {
    var_0.var_DBC2.alpha = clamp(1.0 + vectordot(var_1, vectornormalize(var_4)), 0.0, 1.0);
  }

  if(scripts\engine\utility::is_true(var_0.var_DBC2.var_EB9C)) {
    var_13 = _pow(0.75 * (1.0 - _pow(var_12, 2.0)) + 0.25, 0.5);
    var_0.var_DBC2.width = int(ceil(var_0.var_DBC2.var_13D1C * var_13));
    var_0.var_DBC2.height = int(ceil(var_0.var_DBC2.var_8D0C * var_13));
    var_0.var_DBC2 scaleovertime(0.25, var_0.var_DBC2.width, var_0.var_DBC2.height);
  }

  if(scripts\engine\utility::is_true(var_0.var_DBC2.var_E6F5)) {
    var_14 = anglesToForward(var_0.angles);
    var_15 = vectordot(var_14, var_1);
    var_16 = vectordot(var_14, var_3);
    var_17 = vectordot(var_14, var_2);
    var_18 = vectornormalize(var_3 * var_15 + var_3 * var_16 + var_2 * var_17);
    var_6 = vectordot(var_3, var_18);
    var_7 = vectordot(var_2, var_18);
    var_0.var_DBC2.rotation = acos(clamp(var_6, -1.0, 1.0)) * scripts\engine\utility::sign(var_7);
  }
}

func_DBC7() {
  if(isDefined(self.team)) {
    return self.team;
  } else if(isDefined(self.script_team)) {
    return self.script_team;
  }

  return undefined;
}

func_DBC8() {
  self.var_DBC1.alpha = 0.0;

  foreach(var_1 in self.var_DBC6) {
    var_1.var_DBC2.alpha = 0;
  }
}

func_DBCB() {
  self notify("radar_remove");
  level.var_DBD5 = undefined;

  foreach(var_1 in self.var_DBC6) {
    func_DBD0(var_1);
  }

  self.var_DBC1 destroy();
  self.var_DBC1 = undefined;
  self.var_DBC6 = [];
}

func_DBC0(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(scripts\engine\utility::array_contains(self.var_DBC6, var_0)) {
    return;
  }
  var_7 = "hud_radar_enemy";
  var_8 = 3;
  var_9 = 3;
  var_10 = 1.0;

  if(isDefined(var_2)) {
    var_7 = var_2;
  } else if(issubstr(var_0.classname, "capitalship")) {
    var_7 = "hud_radar_capital_ship";
    var_8 = 20;
    var_9 = 20;
    var_10 = 0.5;

    if(!isDefined(var_5)) {
      var_5 = 1;
    }

    if(!isDefined(var_6)) {
      var_6 = 1;
    }
  } else if(isDefined(var_1) && isenemyteam(var_1, self.team) || isDefined(var_0 func_DBC7()) && isenemyteam(var_0 func_DBC7(), self.team)) {
    var_7 = "hud_radar_friendly";
  }

  if(isDefined(var_3)) {
    var_8 = var_3;
  }

  if(isDefined(var_4)) {
    var_9 = var_4;
  }

  if(!isDefined(self.var_DBC1)) {
    func_DBCC();
  }

  self.var_DBC6[self.var_DBC6.size] = var_0;
  var_0.var_DBC2 = scripts\sp\hud_util::createicon(var_7, var_8, var_9);
  var_0.var_DBC2 scripts\sp\hud_util::setpoint("", undefined, 0, 0);
  var_0.var_DBC2 scripts\sp\hud_util::setparent(self.var_DBC1);
  var_0.var_DBC2.color = (1, 1, 1);
  var_0.var_DBC2.sort = 10;
  var_0.var_DBC2.shader = var_7;
  var_0.var_DBC2.var_E6F5 = var_5;
  var_0.var_DBC2.var_EB9C = var_6;
  var_0.var_DBC2.var_13D1C = var_8;
  var_0.var_DBC2.var_8D0C = var_9;
  var_0.var_DBC2.var_439E = var_10;

  if(var_8 > 3) {
    var_0.var_DBC2.sort = var_0.var_DBC2.sort - 1;
  }

  thread func_DBCF(var_0);
}

func_DBD0(var_0) {
  if(isDefined(var_0.var_DBC2)) {
    var_0.var_DBC2 destroy();
    var_0.var_DBC2 = undefined;
  }

  self.var_DBC6 = scripts\engine\utility::array_remove(self.var_DBC6, var_0);
  var_0 notify("radar_ent_removed");
}

func_DBD3(var_0, var_1) {
  self.var_DBC5.var_26F0 = var_0;
  self.var_DBC5.var_1D2C = var_1;
}

func_DBD2(var_0, var_1) {
  self.var_DBC5.var_26E3 = var_0;
  self.var_DBC5.var_1CC7 = var_1;
}

func_DBCF(var_0) {
  var_0 endon("radar_ent_removed");
  self endon("radar_remove");
  var_0 scripts\engine\utility::waittill_any("death", "entitydeleted");
  thread func_DBD0(var_0);
}