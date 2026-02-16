/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1560.gsc
**************************************/

_id_3E0E() {
  level._id_11BB["inv_hqr_fivenotenkills"] = "inv_hqr_fivenotenkills";
  level._id_11BB["inv_hqr_tenmoreconfirms"] = "inv_hqr_tenmoreconfirms";
  level._id_11BB["inv_hqr_tenpluskia"] = "inv_hqr_tenpluskia";
  level._id_11BB["inv_hqr_fiveplus"] = "inv_hqr_fiveplus";
  level._id_11BB["inv_hqr_another5plus"] = "inv_hqr_another5plus";
  level._id_11BB["inv_hqr_morethanfive"] = "inv_hqr_morethanfive";
  level._id_11BB["inv_hqr_yougotem"] = "inv_hqr_yougotem";
  level._id_11BB["inv_hqr_goodkills"] = "inv_hqr_goodkills";
  level._id_11BB["inv_hqr_directhit"] = "inv_hqr_directhit";
  level._id_11BB["inv_hqr_hesdown"] = "inv_hqr_hesdown";
}

_id_3E0F() {
  var_0 = [];
  var_0[var_0.size] = "inv_hqr_tenpluskia";
  var_0[var_0.size] = "inv_hqr_tenmoreconfirms";
  var_0[var_0.size] = "inv_hqr_fivenotenkills";
  var_1 = 0;
  var_2 = [];
  var_2[var_2.size] = "inv_hqr_fiveplus";
  var_2[var_2.size] = "inv_hqr_another5plus";
  var_2[var_2.size] = "inv_hqr_morethanfive";
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  level._id_3E10 = 0;
  var_6 = 0;

  for(;;) {
    level waittill("remote_missile_exploded");
    var_7 = level._id_3E10;
    wait 0.1;

    if(isDefined(level._id_3BF5["ai"])) {
      var_6 = level._id_3BF5["ai"];
    }
    if(var_6 == 0) {
      continue;
    }
    wait 0.5;

    if(isDefined(level._id_3BDD)) {
      return;
    }
    if(var_6 == 1) {
      if(var_4) {
        maps\_utility::_id_11F4("inv_hqr_yougotem");
        var_4 = 0;
      } else {
        maps\_utility::_id_11F4("inv_hqr_hesdown");
        var_4 = 1;
      }

      continue;
    }

    if(var_6 >= 10) {
      maps\_utility::_id_11F4(var_0[var_1]);
      var_1++;

      if(var_1 >= var_0.size) {
        var_1 = 0;
      }
      continue;
    }

    if(var_6 >= 5) {
      maps\_utility::_id_11F4(var_2[var_3]);
      var_3++;

      if(var_3 >= var_2.size) {
        var_3 = 0;
      }
      continue;
    } else {
      if(var_5) {
        maps\_utility::_id_11F4("inv_hqr_goodkills");
        var_5 = 0;
      } else {
        maps\_utility::_id_11F4("inv_hqr_directhit");
        var_5 = 1;
      }

      continue;
    }
  }
}

_id_3E11() {
  level._id_3C2C = maps\_vehicle::_id_2A99("remotemissile_uav");
  var_0 = getvehiclenode("vnode_remotemissile_uav_start", "targetname");
  level._id_3C2C attachpath(var_0);
  maps\_vehicle::_id_1FA6(level._id_3C2C);
  level._id_3C2C playLoopSound("uav_engine_loop");
  level.uavrig = spawn("script_model", level._id_3C2C.origin);
  level.uavrig setModel("tag_origin");
  level thread _id_3E12();
}

_id_3E12() {
  level._id_3C2C endon("death");
  var_0 = common_scripts\utility::getStructArray("uav_focus_point", "targetname");

  for(;;) {
    var_1 = level.player.origin;

    if(isDefined(level._id_3BF3)) {
      var_1 = level._id_3BF3.origin;
    }
    var_2 = maps\_utility::_id_0AE9(var_1, var_0);
    var_3 = var_2.origin;
    var_4 = vectortoangles(var_3 - level._id_3C2C.origin);
    level.uavrig moveto(level._id_3C2C.origin, 0.1, 0, 0);
    level.uavrig rotateto(var_4, 0.1, 0, 0);
    wait 0.05;
  }
}

_id_3E13() {
  if(!isai(self)) {
    return;
  }
  if(isDefined(self._id_0EF1)) {
    self endon("death");
    self waittill("jumpedout");
  }

  _id_0612::_id_3C49();
}

_id_3E14(var_0) {
  self endon("death");

  if(!isDefined(var_0.type)) {
    var_0.type = "";
  }
  var_1 = var_0.duration;
  var_2 = 0.15;
  self._id_12C6 = 1;
  self._id_3E15 transitionreset();
  self._id_3E16 transitionreset();
  self._id_3E17 transitionreset();
  self._id_3E18 transitionreset();
  self._id_3E19 transitionreset();
  self._id_3E1A transitionreset();
  self._id_3CEE transitionreset();
  self._id_3CED transitionreset();
  wait 0.05;
  setsaveddvar("cg_drawBreathHint", "0");
  var_3 = [];
  var_3[var_3.size] = self._id_3E15;
  self._id_3E15.label = var_0._id_3E1B;

  if(isDefined(var_0._id_3E1C)) {
    self._id_3E15 setvalue(var_0._id_3E1C);
  }
  self._id_3E15 setpulsefx(int(5 * var_1), int(var_1 * 1000), 1000);
  var_4 = self._id_3E15.font;

  if(isDefined(var_0._id_3E1D)) {
    self._id_3E15.font = var_0._id_3E1D;
  }
  var_5 = var_0._id_3E1B;

  if(isDefined(var_0._id_3E1E)) {
    self._id_3E15.label = var_0._id_3E1E;
  }
  var_6 = self._id_3E15.basefontscale;

  if(isDefined(var_0._id_3E1F)) {
    self._id_3E15.basefontscale = var_0._id_3E1F;
  }
  var_7 = self._id_3E15.glowcolor;
  var_8 = self._id_3E15.glowalpha;

  if(isDefined(var_0._id_3E20)) {
    self._id_3E15.glowcolor = var_0._id_3E20;
    self._id_3E15.glowalpha = 1.0;
  }

  var_9 = self._id_3E15.color;

  if(isDefined(var_0._id_3E21)) {
    var_9 = var_0._id_3E21;
    self._id_3E15.color = var_0._id_3E21;
  }

  var_10 = self._id_3CED.shader;

  if(isDefined(var_0.icon) && var_0.icon != "") {
    var_3[var_3.size] = self._id_3CED;
    self._id_3CED.shader = var_0.icon;
  }

  var_11 = undefined;
  var_12 = undefined;

  if(isDefined(var_0._id_189B) && (!isstring(var_0._id_189B) || var_0._id_189B != "")) {
    var_3[var_3.size] = self._id_3E16;
    self._id_3E16.label = var_0._id_189B;

    if(isDefined(var_0._id_3E22)) {
      self._id_3E16 setvalue(var_0._id_3E22);
    }
    var_11 = self._id_3E16.font;

    if(isDefined(var_0._id_3E23)) {
      self._id_3E16.font = var_0._id_3E23;
    }
    var_12 = self._id_3E16.basefontscale;

    if(isDefined(var_0._id_3E24)) {
      self._id_3E16.basefontscale = var_0._id_3E24;
    }
    if(isDefined(var_0._id_3E25) && (!isstring(var_0._id_3E25) || var_0._id_3E25 != "")) {
      var_3[var_3.size] = self._id_3E17;
      self._id_3E17.label = var_0._id_3E25;
      self._id_3E17.font = self._id_3E16.font;

      if(isDefined(var_0._id_3E26)) {
        self._id_3E17 setvalue(var_0._id_3E26);
      }
    }

    if(isDefined(var_0._id_3E27) && (!isstring(var_0._id_3E27) || var_0._id_3E27 != "")) {
      var_3[var_3.size] = self._id_3E18;
      self._id_3E18.label = var_0._id_3E27;
      self._id_3E18.font = self._id_3E16.font;

      if(isDefined(var_0._id_3E28)) {
        self._id_3E18 setvalue(var_0._id_3E28);
      }
    }

    if(isDefined(var_0._id_3E29) && (!isstring(var_0._id_3E29) || var_0._id_3E29 != "")) {
      var_3[var_3.size] = self._id_3E19;
      self._id_3E19.label = var_0._id_3E29;
      self._id_3E19.font = self._id_3E16.font;

      if(isDefined(var_0._id_3E2A)) {
        self._id_3E19 setvalue(var_0._id_3E2A);
      }
    }

    if(isDefined(var_0._id_3E2B) && (!isstring(var_0._id_3E2B) || var_0._id_3E2B != "")) {
      var_3[var_3.size] = self._id_3E1A;
      self._id_3E1A.label = var_0._id_3E2B;
      self._id_3E1A.font = self._id_3E16.font;

      if(isDefined(var_0._id_3E2C)) {
        self._id_3E1A setvalue(var_0._id_3E2C);
      }
    }
  }

  if(isDefined(var_0._id_27BB) && (!isstring(var_0._id_27BB) || var_0._id_27BB != "")) {
    var_3[var_3.size] = self._id_3CEE;
    self._id_3CEE.label = var_0._id_27BB;

    if(isDefined(var_0._id_3E2D)) {
      self._id_3CEE.label = var_0._id_3E2D;
    }
  }

  if(isDefined(var_0._id_15E0)) {
    foreach(var_14 in var_3) {}
    var_14 transitionfadein(var_2);
  }

  if(isDefined(var_0._id_3E2E)) {
    foreach(var_14 in var_3) {}
    var_14 transitionzoomin(var_2);
  }

  if(isDefined(var_0._id_3E2F)) {
    foreach(var_14 in var_3) {}
    var_14 transitionslidein(var_2, var_0._id_3E2F);
  }

  if(isDefined(var_0._id_3E30)) {
    foreach(var_14 in var_3) {}
    var_14 transitionpulsefxin(var_2, var_1);
  }

  if(isDefined(var_0.sound)) {
    if(isDefined(var_0._id_3E31)) {
      self playlocalsound(var_0.sound);
    } else {
      foreach(var_23 in level.players) {}
      var_23 playlocalsound(var_0.sound);
    }
  }

  if(isDefined(var_0._id_3E32)) {
    maps\_utility::_id_25E4(var_0._id_3E32, var_1);
  } else {
    wait(var_1);
  }
  if(isDefined(var_0._id_3E33)) {
    foreach(var_14 in var_3) {}
    var_14 transitionfadeout(var_2);
  }

  if(isDefined(var_0._id_3E34)) {
    foreach(var_14 in var_3) {}
    var_14 transitionzoomout(var_2);
  }

  if(isDefined(var_0._id_3E35)) {
    foreach(var_14 in var_3) {}
    var_14 transitionslideout(var_2, var_0._id_3E35);
  }

  wait(var_2);
  setsaveddvar("cg_drawBreathHint", "1");
  self._id_3E15.font = var_4;
  self._id_3E15.label = var_5;
  self._id_3E15.basefontscale = var_6;
  self._id_3E15.glowcolor = var_7;
  self._id_3E15.glowalpha = var_8;
  self._id_3E15.color = var_9;
  self._id_3CED.shader = var_10;

  if(isDefined(var_11)) {
    self._id_3E16.font = var_11;
  }
  if(isDefined(var_12)) {
    self._id_3E16.basefontscale = var_12;
  }
  self._id_12C6 = 0;
}

_id_3E36() {
  var_0 = 15;

  if(issplitscreen()) {
    var_1 = "objective";
    var_2 = 2.25;

    if(getdvarint("survival_chaos") == 1) {
      if(self == level.player) {
        var_3 = 10;
      } else {
        var_3 = 37;
      }
    } else {
      var_3 = 10;
    }
    var_4 = 0;
    var_5 = "objective";
    var_6 = 1;
    var_7 = 57;
    var_8 = 0;
    var_9 = "small";
    var_10 = 1.4;
    var_11 = 72;
    var_12 = 0;
    var_13 = 24;
    var_14 = 5;
    var_15 = 0;
    var_16 = "TOP";
    var_17 = "BOTTOM";
  } else {
    var_1 = "objective";
    var_2 = 2.5;
    var_3 = 10;
    var_4 = 0;
    var_5 = "objective";
    var_6 = 1.1;
    var_7 = 42;
    var_8 = 0;
    var_9 = "small";
    var_10 = 1.5;
    var_11 = 300;
    var_12 = 0;
    var_13 = 42;
    var_14 = 250;
    var_15 = 0;
    var_16 = "TOP";
    var_17 = "BOTTOM";
  }

  var_18 = _id_3E37(var_1, var_2);
  var_18 maps\_hud_util::setpoint(var_16, undefined, var_4, var_3);
  var_18.glowcolor = (0.3, 0.6, 0.3);
  var_18.glowalpha = 1;
  var_18.hidewheninmenu = 1;
  var_18.archived = 0;
  var_18.alpha = 0;
  self._id_3E15 = var_18;
  var_18 = undefined;
  var_18 = _id_3E37(var_5, var_6);
  var_18 maps\_hud_util::setparent(self._id_3E15);
  var_18 maps\_hud_util::setpoint(var_16, var_17, var_8, var_7);
  var_18.glowcolor = (0, 0, 0);
  var_18.glowalpha = 0;
  var_18.hidewheninmenu = 1;
  var_18.archived = 0;
  var_18.alpha = 0;
  self._id_3E16 = var_18;
  var_18 = undefined;
  var_18 = _id_3E37(var_5, var_6);
  var_18 maps\_hud_util::setparent(self._id_3E15);
  var_18 maps\_hud_util::setpoint(var_16, var_17, var_8, var_7 + 1 * var_0);
  var_18.glowcolor = (0, 0, 0);
  var_18.glowalpha = 0;
  var_18.hidewheninmenu = 1;
  var_18.archived = 0;
  var_18.alpha = 0;
  self._id_3E17 = var_18;
  var_18 = undefined;
  var_18 = _id_3E37(var_5, var_6);
  var_18 maps\_hud_util::setparent(self._id_3E15);
  var_18 maps\_hud_util::setpoint(var_16, var_17, var_8, var_7 + 2 * var_0);
  var_18.glowcolor = (0, 0, 0);
  var_18.glowalpha = 0;
  var_18.hidewheninmenu = 1;
  var_18.archived = 0;
  var_18.alpha = 0;
  self._id_3E18 = var_18;
  var_18 = undefined;
  var_18 = _id_3E37(var_5, var_6);
  var_18 maps\_hud_util::setparent(self._id_3E15);
  var_18 maps\_hud_util::setpoint(var_16, var_17, var_8, var_7 + 3 * var_0);
  var_18.glowcolor = (0, 0, 0);
  var_18.glowalpha = 0;
  var_18.hidewheninmenu = 1;
  var_18.archived = 0;
  var_18.alpha = 0;
  self._id_3E19 = var_18;
  var_18 = undefined;
  var_18 = _id_3E37(var_5, var_6);
  var_18 maps\_hud_util::setparent(self._id_3E15);
  var_18 maps\_hud_util::setpoint(var_16, var_17, var_8, var_7 + 4 * var_0);
  var_18.glowcolor = (0, 0, 0);
  var_18.glowalpha = 0;
  var_18.hidewheninmenu = 1;
  var_18.archived = 0;
  var_18.alpha = 0;
  self._id_3E1A = var_18;
  var_18 = undefined;
  var_18 = _id_3E37("hudbig", 0.75);
  var_18 maps\_hud_util::setparent(self._id_3E16);
  var_18 maps\_hud_util::setpoint(var_16, var_17, var_12, var_11);
  var_18.glowcolor = (0, 0, 0);
  var_18.glowalpha = 0;
  var_18.hidewheninmenu = 1;
  var_18.archived = 0;
  var_18.alpha = 0;
  var_18.color = (0.75, 1, 0.75);
  self._id_3CEE = var_18;
  var_18 = undefined;
  var_18 = _id_3E38("white", var_13, var_13);
  var_18 maps\_hud_util::setparent(self._id_3E15);
  var_18 _id_0614::setpoint(var_16, var_17, var_15, var_14);
  var_18.hidewheninmenu = 1;
  var_18.archived = 0;
  var_18.alpha = 0;
  self._id_3CED = var_18;
}

_id_3E37(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.hidden = 0;
  var_2.elemtype = "font";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.basefontscale = var_2.fontscale;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_2.fontscale);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 maps\_hud_util::setparent(level.uiparent);
  return var_2;
}

_id_3E38(var_0, var_1, var_2) {
  var_3 = newclienthudelem(self);
  var_3.elemtype = "icon";
  var_3.x = 0;
  var_3.y = 0;
  var_3.width = var_1;
  var_3.height = var_2;
  var_3.basewidth = var_3.width;
  var_3.baseheight = var_3.height;
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_3 maps\_hud_util::setparent(level.uiparent);
  var_3.hidden = 0;

  if(isDefined(var_0)) {
    var_3 setshader(var_0, var_1, var_2);
    var_3.shader = var_0;
  }

  return var_3;
}

_id_3E39(var_0) {
  var_1 = gettime() + _id_3E43(var_0);

  for(;;) {
    if(gettime() >= var_1) {
      break;
    }

    var_2 = 0;

    foreach(var_4 in level.players) {
      if(var_4._id_12C6 || var_4._id_3B10) {
        var_2 = 1;
        break;
      }
    }

    if(var_2) {
      wait 0.1;
      continue;
    }

    break;
  }
}

transitionreset() {
  self settext("");
  self.x = self.xoffset;
  self.y = self.yoffset;

  if(self.elemtype == "font") {
    self.fontscale = self.basefontscale;
    self.label = &"";
  } else if(self.elemtype == "icon") {
    self setshader(self.shader, self.width, self.height);
  }
  self.alpha = 0;
}

transitionzoomin(var_0) {
  switch (self.elemtype) {
    case "timer":
    case "font":
      self.fontscale = 6.3;
      self changefontscaleovertime(var_0);
      self.fontscale = self.basefontscale;
      break;
    case "icon":
      self setshader(self.shader, self.width * 6, self.height * 6);
      self scaleovertime(var_0, self.width, self.height);
      break;
  }
}

transitionpulsefxin(var_0, var_1) {
  var_2 = int(var_0) * 1000;
  var_3 = int(var_1) * 1000;

  switch (self.elemtype) {
    case "timer":
    case "font":
      self setpulsefx(var_2 + 250, var_3 + var_2, var_2 + 250);
      break;
    default:
      break;
  }
}

transitionslidein(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "left";
  }
  switch (var_1) {
    case "left":
      self.x = self.x + 1000;
      break;
    case "right":
      self.x = self.x - 1000;
      break;
    case "up":
      self.y = self.y - 1000;
      break;
    case "down":
      self.y = self.y + 1000;
      break;
  }

  self moveovertime(var_0);
  self.x = self.xoffset;
  self.y = self.yoffset;
}

transitionslideout(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "left";
  }
  var_2 = self.xoffset;
  var_3 = self.yoffset;

  switch (var_1) {
    case "left":
      var_2 = var_2 + 1000;
      break;
    case "right":
      var_2 = var_2 - 1000;
      break;
    case "up":
      var_3 = var_3 - 1000;
      break;
    case "down":
      var_3 = var_3 + 1000;
      break;
  }

  self.alpha = 1;
  self moveovertime(var_0);
  self.x = var_2;
  self.y = var_3;
}

transitionzoomout(var_0) {
  switch (self.elemtype) {
    case "timer":
    case "font":
      self changefontscaleovertime(var_0);
      self.fontscale = 6.3;
    case "icon":
      self scaleovertime(var_0, self.width * 6, self.height * 6);
      break;
  }
}

transitionfadein(var_0) {
  self fadeovertime(var_0);

  if(isDefined(self.maxalpha)) {
    self.alpha = self.maxalpha;
  } else {
    self.alpha = 1;
  }
}

transitionfadeout(var_0) {
  self fadeovertime(0.15);
  self.alpha = 0;
}

_id_3E3A(var_0) {
  var_1 = getEntArray(var_0, "classname");
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isspawner(var_4)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_3DCA(var_0) {
  var_1 = getspawnerarray();
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4.targetname) && var_4.targetname == var_0) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_3DBE(var_0, var_1, var_2) {
  var_2 = common_scripts\utility::ter_op(isDefined(var_2), var_2, 1);
  var_2 = max(1, var_2);

  while(var_0.size > var_2) {
    foreach(var_4 in var_1) {
      var_5 = maps\_utility::_id_0AE9(var_4.origin, var_0);

      if(var_0.size > var_2) {
        var_0 = common_scripts\utility::array_remove(var_0, var_5);
        continue;
      }

      var_5 = var_0[0];
      thread _id_0610::_id_3B9A(var_5.origin, (1, 1, 1));
      break;
    }
  }

  return var_0[randomint(var_0.size)];
}

_id_3E3B(var_0) {
  self endon("death");
  var_0 endon("stopped camping");

  if(common_scripts\utility::cointoss()) {
    self.grenadeweapon = "flash_grenade";
  } else {
    self.grenadeweapon = "fraggrenade";
  }
  self.grenadeammo = 2;
  self._id_20B5 = 1;
  wait 8;
  self._id_20B5 = 0;
  self.grenadeweapon = "fraggrenade";
}

_id_3DC8() {
  self waittill("death");
  var_0 = [];

  foreach(var_2 in level._id_3D64) {
    if(isDefined(var_2) && (!isDefined(self) || self != var_2)) {
      var_0[var_0.size] = var_2;
    }
  }

  level._id_3D64 = var_0;
}

_id_3E3C() {
  self waittill("death");
  var_0 = [];

  foreach(var_2 in level._id_3D71) {
    if(isalive(var_2)) {
      var_0[var_0.size] = var_2;
    }
  }

  level._id_3D71 = var_0;
}

_id_0A32() {
  if(isDefined(self._id_0A33) && self._id_0A33) {
    return 1;
  }
  if(!isDefined(self.damagelocation)) {
    return 0;
  }
  return self.damagelocation == "helmet" || self.damagelocation == "head" || self.damagelocation == "neck";
}

_id_3DCB(var_0, var_1, var_2) {
  var_3 = "passed start struct without targetname: " + var_0;
  var_2._id_3D0B = 1;
  var_4 = _id_3DE1(var_0, var_1);
  var_4._id_3D0A = var_2;
  var_4 thread maps\_vehicle::_id_26A1(var_2);
  return var_4;
}

_id_3DE1(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_3 = _id_061C::_id_3DFA(var_0);

  if(isDefined(var_3)) {
    var_2._id_2189 = var_3;
  }
  while(isDefined(var_2._id_2973)) {
    wait 0.05;
  }
  if(isDefined(var_1)) {
    var_2.origin = var_1;
  }
  var_4 = maps\_vehicle::_id_2A99(var_0);
  return var_4;
}

_id_3DCD(var_0, var_1) {
  var_2 = getspawnerarray();
  var_3 = undefined;

  foreach(var_3 in var_2) {
    if(isDefined(var_3.targetname) && var_3.targetname == var_0) {
      break;
    }
  }

  var_6 = _id_3DCE(var_3, var_1, 1);
  var_6.health = 9999;
  return var_6;
}

_id_3DCE(var_0, var_1, var_2) {
  var_3 = undefined;

  for(;;) {
    var_0.count = 1;

    if(isDefined(var_2) && var_2) {
      var_3 = maps\_utility::_id_212D(var_0);
      break;
    } else {
      var_3 = var_0 maps\_utility::_id_166F(1);

      if(!maps\_utility::_id_13AF(var_3)) {
        break;
      }
    }

    wait 0.5;
  }

  if(isDefined(var_1)) {
    var_3._id_2511 = var_1;
  }
  maps\_utility::_id_2683(var_3);
  return var_3;
}

_id_3DCC() {
  self endon("death");
  self waittill("unloading");
  var_0 = self.origin - vectornormalize(anglesToForward(self.angles)) * 145;
  var_1 = maps\_utility::_id_1277(var_0);
  magicgrenademanual("smoke_grenade_fast", var_1, (0, 0, -1), 0);
}

_id_3E3D(var_0, var_1, var_2) {
  var_3 = undefined;

  for(;;) {
    var_3 = _id_3E3E(var_0, var_1, var_2);

    if(isDefined(var_3)) {
      break;
    }

    wait 0.25;
  }

  return var_3;
}

_id_3E3E(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::getStructArray(var_1, "targetname");
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;

  foreach(var_8 in var_3) {
    if(isDefined(var_8._id_3D0B)) {
      continue;
    }
    var_9 = var_8;

    switch (var_2) {
      case "script_unload":
        while(!isDefined(var_9._id_2954)) {
          var_9 = common_scripts\utility::getstruct(var_9.target, "targetname");
        }
        if(!isDefined(var_9._id_2954)) {
          continue;
        }
        break;
      case "script_stopnode":
        while(!isDefined(var_9._id_295D)) {
          var_9 = common_scripts\utility::getstruct(var_9.target, "targetname");
        }
        if(!isDefined(var_9._id_295D)) {
          continue;
        }
        break;
      default:
        break;
    }

    if(!isDefined(var_6)) {
      var_6 = var_9;
      var_5 = distance2d(var_0, var_9.origin);
      var_4 = var_8;
      continue;
    }

    var_10 = distance2d(var_0, var_9.origin);

    if(var_10 < var_5) {
      var_6 = var_9;
      var_5 = distance2d(var_0, var_6.origin);
      var_4 = var_8;
    }
  }

  return var_4;
}

_id_3E3F() {
  var_0 = getEntArray();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1].script_gameobjectname)) {
      var_0[var_1] delete();
    }
  }
}

_id_3D24(var_0) {
  if(isDefined(var_0) && var_0 != "") {
    precacheitem(var_0);
  }
}

_id_3E40(var_0, var_1, var_2) {
  return int(max(var_1, min(var_2, var_0)));
}

_id_3E41(var_0, var_1, var_2) {
  return max(var_1, min(var_2, var_0));
}

_id_3E42() {
  var_0 = getEntArray("delete", "targetname");

  foreach(var_2 in var_0) {}
  var_2 delete();
}

_id_3E43(var_0) {
  return var_0 * 1000;
}

_id_3E44(var_0) {
  return var_0 / 1000;
}

_id_3E45() {
  return level.players[randomint(level.players.size)].origin;
}

_id_3D31() {
  var_0 = -1;

  foreach(var_2 in level.players) {
    var_3 = var_2 maps\_rank::getrank();

    if(var_3 > var_0) {
      var_0 = var_3;
    }
  }

  return var_0;
}

_id_3D82() {
  self endon("death");
  self unlink();
  wait 0.05;

  if(isDefined(self)) {
    self delete();
  }
}

_id_3DA5(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    if(isDefined(var_1) && isDefined(var_2)) {
      self notify("death", var_0, var_1, var_2);
      self kill();
    } else {
      self kill(var_0.origin, var_0);
    }
  } else {
    self kill();
  }
}

_id_6F52() {
  var_0 = common_scripts\utility::getStructArray("struct_break_glass", "targetname");

  foreach(var_2 in var_0) {}
  glassradiusdamage(var_2.origin, 64, 100, 99);
}

_id_3E46() {
  var_0 = getEntArray("armory_script_brushmodel", "targetname");

  foreach(var_2 in var_0) {}
  var_2 notsolid();

  var_4 = (0, 0, 0);
  var_5 = 60.0;
  var_6 = 60.0;
  var_7 = [];
  var_7[var_7.size] = getent("armory_weapon", "targetname");
  var_7[var_7.size] = getent("armory_equipment", "targetname");
  var_7[var_7.size] = getent("armory_airsupport", "targetname");
  var_7 = common_scripts\utility::array_combine(var_7, common_scripts\utility::getStructArray("so_claymore_loc", "targetname"));
  var_7 = common_scripts\utility::array_combine(var_7, common_scripts\utility::getStructArray("leader", "script_noteworthy"));
  var_7 = common_scripts\utility::array_combine(var_7, common_scripts\utility::getStructArray("follower", "script_noteworthy"));

  foreach(var_9 in var_7) {}
  var_9 _id_3E48(var_4, var_5, var_6);

  foreach(var_2 in var_0) {}
  var_2 solid();

  wait 2.0;

  if(isDefined(level._id_3E47) && level._id_3E47.size) {
    foreach(var_14 in level._id_3E47) {}
  }
}

_id_3E48(var_0, var_1, var_2) {
  if(!isDefined(level._id_3E47)) {
    level._id_3E47 = [];
  }
  if(!isDefined(level._id_3E49)) {
    level._id_3E49 = [];
  }
  var_3 = self.origin + var_0 + (0, 0, var_1);
  var_4 = self.origin + var_0;
  var_5 = physicstrace(var_3, var_4);

  if(distance(var_5, var_4) > 0.1) {
    level._id_3E47[level._id_3E47.size] = "Error: Survival Entity may be in solid at: " + self.origin;
    level._id_3E49[level._id_3E49.size] = self.origin;
    return;
  }

  var_3 = self.origin + var_0;
  var_4 = self.origin + var_0 - (0, 0, var_2);
  var_5 = physicstrace(var_3, var_4);

  if(distance(var_5, var_4) < 0.1) {
    level._id_3E47[level._id_3E47.size] = "Error: Survival Entity floating or under floor: " + self.origin;
    level._id_3E49[level._id_3E49.size] = self.origin;
    return;
  }
}

_id_3E4A() {
  if(!isDefined(level._id_3E49) || !level._id_3E49.size) {
    return;
  }
  level endon("special_op_terminated");

  for(;;) {
    foreach(var_1 in level._id_3E49) {}

    wait 10.0;
  }
}