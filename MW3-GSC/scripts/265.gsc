/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\265.gsc
**************************************/

main(var_0) {
  var_1 = getEntArray("painter_setup", "targetname");

  if(!var_1.size) {
    return;
  }
  if(!getdvarint("painter")) {
    common_scripts\utility::array_thread(var_1, ::_id_1BB3);
    return;
  }

  _id_1BC4(var_0);
  var_2 = [];
  var_3 = _id_1BC3(var_1);

  foreach(var_5 in var_3) {}
  _id_1BBC(var_5);

  thread _id_1BD4();
  common_scripts\utility::array_thread(level._id_1BB1, ::_id_1BB4);
  level._id_1BB2 = 1;
  level waittill("forever");
}

_id_1BB3() {
  if(isDefined(self.target)) {
    var_0 = getent(self.target, "targetname");
    var_0 delete();
  }

  self delete();
}

_id_1BB4() {
  if(!isDefined(self._id_1BB5)) {
    self._id_1BB5 = 0;
  }
  if(!isDefined(self._id_1BB6)) {
    self._id_1BB6 = 0;
  }
  if(!isDefined(self._id_1BB7)) {
    self._id_1BB7 = 0;
  }
  if(!isDefined(self._id_1BB8)) {
    self._id_1BB8 = 0;
  }
  if(!isDefined(self._id_1BB9)) {
    self._id_1BB9 = 32;
  }
  if(!isDefined(self.radius)) {
    self.radius = 84;
  }
  if(!isDefined(self._id_1BBA)) {
    self._id_1BBA = 1000;
  }
  if(!isDefined(self._id_1BBB)) {
    self._id_1BBB = [];
  }
}

_id_1BBC(var_0) {
  var_1 = 100000001;
  var_2 = var_0;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;

  foreach(var_12 in var_0) {
    var_10 = _id_1BC1(var_12);
    var_7 = _id_1BC2(var_12);
    var_13 = isDefined(var_12._id_164F) && var_12._id_164F == "use_prefab_model";

    if(isDefined(var_12.radius)) {
      var_5 = var_12.radius;
    }
    if(isDefined(var_12._id_1BBD) && var_12._id_1BBD) {
      var_3 = 1;
    }
    if(isDefined(var_12._id_1BBE) && var_12._id_1BBE) {
      var_6 = var_12._id_1BBE;
    }
    if(isDefined(var_12._id_1BBF) && var_12._id_1BBF) {
      var_4 = 1;
    }
    foreach(var_15 in var_2) {
      if(var_12 == var_15) {
        continue;
      }
      var_16 = distance(var_12.origin, var_15.origin);

      if(var_16 < var_1) {
        var_1 = var_16;
      }
    }

    if(var_1 == 100000001) {
      var_1 = undefined;
    }
    _id_1BD7(var_12._id_1BC0, var_12.model, var_3, var_4, var_1, var_5, var_6, var_7, var_8, var_9, var_10, var_13);
  }
}

_id_1BC1(var_0) {
  if(!isDefined(var_0.target)) {
    return undefined;
  }
  var_1 = getent(var_0.target, "targetname");
  return var_1.angles - var_0.angles;
}

_id_1BC2(var_0) {
  if(!isDefined(var_0.target)) {
    return undefined;
  }
  var_1 = getent(var_0.target, "targetname");
  var_2 = var_1.origin[2] - var_0.origin[2];
  var_1 delete();
  return var_2;
}

_id_1BC3(var_0) {
  var_1 = [];
  var_2 = "";

  foreach(var_4 in var_0) {
    if(!isDefined(var_4._id_1BC0)) {
      var_4._id_1BC0 = var_4.model;
    }
    var_2 = var_4._id_1BC0;
    level._id_1B4F = var_2;

    if(!isDefined(var_1[var_2]) || !var_1[var_2].size) {
      var_1[var_2] = [];
    }
    var_1[var_2][var_1[var_2].size] = var_4;
  }

  return var_1;
}

_id_1BC4(var_0) {
  level._id_1ADE = 0;
  level._id_1BB5 = 0;
  level._id_1BB6 = 0;
  level._id_1BC5 = 16;
  level._id_1BC6 = 0;
  level._id_1BB1 = [];
  level._id_1BC7 = [];
  level._id_1BC8 = 0.1;
  level._id_1BC9 = 31;
  level._id_1BCA = 1000;
  level._id_1BCB = [];
  level._id_1BCC = 0;
  level._id_1BCD = 0;
  level._id_1BCE = 0;
  level._id_1BCF = 0;
  level._id_1BD0 = 0;
  level._id_1BD1 = ::_id_1BD7;
  level.timelimitoverride = 1;
  thread hack_start(var_0);
  thread _id_1B2C();
}

hack_start(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "painter";
  }
  precachemenu(var_0);
  common_scripts\utility::flag_init("user_alive");

  while(!isDefined(get_player())) {
    wait 0.05;
  }
  level._id_1BD3 = get_player();
  wait 0.05;
  var_1 = "team_marinesopfor";
  var_2 = "autoassign";
  level._id_1BD3 notify("menuresponse", var_1, var_2);
  wait 0.05;
  var_1 = "changeclass_offline";
  var_2 = "offline_class1_mp, 0";
  level._id_1BD3 notify("menuresponse", var_1, var_2);
  level._id_1BD3 openpopupmenu(var_0);
  wait 0.05;
  level._id_1BD3 closepopupmenu();
  common_scripts\utility::flag_set("user_alive");
}

_id_1BD4() {
  common_scripts\utility::array_call(getEntArray("script_model", "classname"), ::delete);
  _id_1B3B(level._id_1B4F);
  level._id_1B4F = undefined;
  _id_1B41();
}

_id_1B5D() {
  level._id_1B31["helppm"]._id_1B32 setvalue(level._id_1BC7.size);
  var_0 = 256;

  if(level._id_1BC7.size < var_0) {
    level._id_1B31["helppm"]._id_1B32.color = (1, 1, 1);
    return;
  }

  var_1 = 1;
  var_2 = 1 - (level._id_1BC7.size - var_0) / var_0;
  var_3 = var_2;
  level._id_1B31["helppm"]._id_1B32.color = (var_1, var_2, var_3);
}

_id_1B2C() {
  common_scripts\utility::flag_init("user_hud_active");
  common_scripts\utility::flag_wait("user_alive");
  var_0 = 7;

  if(_id_1BF3()) {
    var_0 = 7;
  }
  var_1 = [];
  var_2 = 15;
  var_3 = int(var_0 / 2);
  var_4 = 240 + var_3 * var_2;
  var_5 = 0.5 / var_3;
  var_6 = var_5;

  for(var_7 = 0; var_7 < var_0; var_7++) {
    var_1[var_7] = _id_1B34();
    var_1[var_7].location = 0;
    var_1[var_7].alignx = "left";
    var_1[var_7].aligny = "middle";
    var_1[var_7].foreground = 1;
    var_1[var_7].fontscale = 2;
    var_1[var_7].sort = 20;

    if(var_7 == var_3) {
      var_1[var_7].alpha = 1;
    } else {
      var_1[var_7].alpha = var_6;
    }
    var_1[var_7].x = 20;
    var_1[var_7].y = var_4;
    var_1[var_7] _id_1B36(".");

    if(var_7 == var_3) {
      var_5 = var_5 * -1;
    }
    var_6 = var_6 + var_5;
    var_4 = var_4 - var_2;
  }

  level._id_1B2D = var_1;
  var_8 = _id_1B34();
  var_8.location = 0;
  var_8.alignx = "center";
  var_8.aligny = "bottom";
  var_8.foreground = 1;
  var_8.fontscale = 2;
  var_8.sort = 20;
  var_8.alpha = 1;
  var_8.x = 320;
  var_8.y = 244;
  var_8 _id_1B36(".");
  level._id_1B2E = var_8;
  var_8 = _id_1B34();
  var_8.location = 0;
  var_8.alignx = "center";
  var_8.aligny = "bottom";
  var_8.foreground = 1;
  var_8.fontscale = 2;
  var_8.sort = 20;
  var_8.alpha = 0;
  var_8.x = 320;
  var_8.y = 244;
  var_8 setvalue(0);
  level._id_1B2F = var_8;
  _id_1B30("helppm", 1, "^5Placed Models: ", undefined, level._id_1BC7.size);
  _id_1B30("helpdensity", 2, "^5Spacing: ", undefined, level._id_1BC5);
  _id_1B30("helpradius", 3, "^5Radius: ", undefined, level._id_1BC9);
  _id_1B30("helpxy", 6, "^4X / ^3Y: ", undefined, level._id_1BC9);
  _id_1B30("helpab", 7, "^2A / ^1B^7: ", " - ");
  _id_1B30("helplsrs", 8, "^8L^7 / R Stick: ", " - ");
  _id_1B30("helplbrb", 9, "^8L^7 / R Shoulder: ", " - ");
  _id_1B30("helpdpu", 10, "^8DPad U / ^7D: ", " - ");
  _id_1B30("helpdpl", 11, "^8DPad L / ^7R: ", " - ");
  _id_1B30("helpF", 17, "^8F: ^7( dump ) ^3map_source/" + level.script + "_modeldump.map", "");
  _id_1B9A();
  common_scripts\utility::flag_set("user_hud_active");
}

_id_1B9A() {
  _id_1B62("helpxy", "^4Select Set Up ^7 / ^3Down");
  _id_1B62("helpab", "^2Spacing Down ^7 / ^1up ");
  _id_1B62("helplsrs", "^8Radius Down ^7 / Up");
  _id_1B62("helplbrb", "^8Remove ^7 / Place");
  _id_1B62("helpdpl", "^8zOffset Clear ^7 / Set");
  _id_1B62("helpdpu", "^8Rotation Clear ^7 / Set");
}

_id_1BD5() {
  _id_1B62("helpxy", "^4 - ^7 / ^3 - ");
  _id_1B62("helpab", "^2Height Down ^7 / ^1Up ");
  _id_1B62("helplsrs", "^8 - ^7 / - ");
  _id_1B62("helplbrb", "^8 - ^7 / - ");
  _id_1B62("helpdpl", "^8 - ^7 / Set");
  _id_1B62("helpdpu", "^8 - ^7 / - ");
  _id_1B62("helpF", " - ");
}

_id_1BD6() {
  _id_1B62("helpxy", "^4 - ^7 / ^3 - ");
  _id_1B62("helpab", "^2RotateOther Up ^7 / ^1Down ");
  _id_1B62("helplsrs", "^8 - ^7 / - ");
  _id_1B62("helplbrb", "^8 - ^7 / - ");
  _id_1B62("helpdpl", "^8 - ^7 / - ");
  _id_1B62("helpdpu", "^8Set ^7 / - ");
  _id_1B62("helpF", " - ");
}

_id_1B3B(var_0) {
  common_scripts\utility::flag_wait("user_hud_active");
  level._id_1B3C = var_0;
  var_1 = getarraykeys(level._id_1BB1);
  var_2 = 0;
  var_3 = int(level._id_1B2D.size / 2);

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(var_1[var_4] == var_0) {
      var_2 = var_4;
      break;
    }
  }

  level._id_1B2D[var_3] _id_1B36(var_1[var_2]);

  for(var_4 = 1; var_4 < level._id_1B2D.size - var_3; var_4++) {
    if(var_2 - var_4 < 0) {
      level._id_1B2D[var_3 + var_4] _id_1B36(".");
      continue;
    }

    level._id_1B2D[var_3 + var_4] _id_1B36(var_1[var_2 - var_4]);
  }

  for(var_4 = 1; var_4 < level._id_1B2D.size - var_3; var_4++) {
    if(var_2 + var_4 > var_1.size - 1) {
      level._id_1B2D[var_3 - var_4] _id_1B36(".");
      continue;
    }

    level._id_1B2D[var_3 - var_4] _id_1B36(var_1[var_2 + var_4]);
  }

  var_0 = _id_1B72();
  level._id_1BB6 = var_0._id_1BB6;
  level._id_1BB5 = var_0._id_1BB5;
  level._id_1BCA = var_0._id_1BBA;
  level._id_1BC9 = var_0.radius;
  level._id_1B31["helpradius"]._id_1B32 setvalue(level._id_1BC9);
  level._id_1BC5 = var_0._id_1BB9;
  level._id_1B31["helpdensity"]._id_1B32 setvalue(level._id_1BC5);
}

_id_1B38() {
  var_0 = undefined;
  var_1 = getarraykeys(level._id_1BB1);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == level._id_1B3C) {
      var_0 = var_2 + 1;
      break;
    }
  }

  if(var_0 == var_1.size) {
    return;
  }
  _id_1B3B(var_1[var_0]);

  while(level._id_1BD3 buttonPressed("BUTTON_Y")) {
    wait 0.05;
  }
}

_id_1B39() {
  var_0 = undefined;
  var_1 = getarraykeys(level._id_1BB1);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == level._id_1B3C) {
      var_0 = var_2 - 1;
      break;
    }
  }

  if(var_0 < 0) {
    return;
  }
  _id_1B3B(var_1[var_0]);

  while(level._id_1BD3 buttonPressed("BUTTON_X")) {
    wait 0.05;
  }
}

_id_1BD7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(level._id_1BB1[var_0])) {
    var_12 = spawnStruct();
    level._id_1BB1[var_0] = var_12;
    level._id_1BB1[var_0]._id_1BD8 = [];
  }

  if(!isDefined(var_10)) {
    var_10 = (0, 0, 0);
  }
  level._id_1BB1[var_0]._id_1BB8 = var_3;
  level._id_1BB1[var_0]._id_1BB7 = var_2;
  level._id_1BB1[var_0]._id_1BB9 = var_4;
  level._id_1BB1[var_0].radius = var_5;
  level._id_1BB1[var_0]._id_1BBA = var_6;
  level._id_1BB1[var_0]._id_1BB5 = var_8;
  level._id_1BB1[var_0]._id_1BB6 = var_9;

  if(!isDefined(level._id_1BB1[var_0]._id_1BBB)) {
    level._id_1BB1[var_0]._id_1BBB = [];
  }
  level._id_1BB1[var_0]._id_1BBB[var_1] = var_10;

  if(!isDefined(level._id_1BB1[var_0]._id_1BD9)) {
    level._id_1BB1[var_0]._id_1BD9 = [];
  }
  level._id_1BB1[var_0]._id_1BD9[var_1] = var_7;

  if(!isDefined(level._id_1BB1[var_0]._id_1BDA)) {
    level._id_1BB1[var_0]._id_1BDA = [];
  }
  level._id_1BB1[var_0]._id_1BDA[var_1] = var_11;
  level._id_1BB1[var_0]._id_1BD8[level._id_1BB1[var_0]._id_1BD8.size] = var_1;
}

_id_1B41() {
  level._id_1BDB = 700;
  level._id_1BD3 takeallweapons();
  common_scripts\utility::flag_wait("user_hud_active");

  for(;;) {
    var_0 = _id_1B57();
    _id_1BE7(var_0);

    if(level._id_1BD3 buttonPressed("f")) {
      _id_1BF2();
    }
    if(level._id_1BD3 buttonPressed("DPAD_UP")) {
      _id_1BE1(var_0, "DPAD_UP");
    } else if(level._id_1BD3 buttonPressed("DPAD_DOWN")) {
      _id_1BE0();
    } else if(level._id_1BD3 buttonPressed("DPAD_RIGHT")) {
      _id_1BDD(var_0, "DPAD_RIGHT");
    } else if(level._id_1BD3 buttonPressed("DPAD_LEFT")) {
      _id_1BDC();
    } else if(level._id_1BD3 buttonPressed("BUTTON_X")) {
      _id_1B39();
    } else if(level._id_1BD3 buttonPressed("BUTTON_Y")) {
      _id_1B38();
    } else if(level._id_1BD3 buttonPressed("BUTTON_LSTICK")) {
      _id_1BE5(var_0, -1);
    } else if(level._id_1BD3 buttonPressed("BUTTON_RSTICK")) {
      _id_1BE5(var_0, 1);
    } else if(level._id_1BD3 buttonPressed("BUTTON_A")) {
      _id_1BE6(var_0, -1);
    } else if(level._id_1BD3 buttonPressed("BUTTON_B")) {
      _id_1BE6(var_0, 1);
    } else {
      if(level._id_1BD3 buttonPressed("BUTTON_LSHLDR")) {
        _id_1BF1(var_0);
      }
      if(level._id_1BD3 buttonPressed("BUTTON_RSHLDR")) {
        thread _id_1BEA(var_0);
      }
    }

    level notify("clear_previews");
    wait 0.05;
    _id_1B5D();
  }
}

_id_1BDC() {
  level._id_1BCD = 0;
  _id_1B9A();
}

_id_1BDD(var_0, var_1) {
  if(var_0["fraction"] == 1) {
    return;
  }
  while(level._id_1BD3 buttonPressed(var_1)) {
    wait 0.05;
  }
  level._id_1BCD = 1;
  _id_1BD5();
  var_2 = [];
  var_2 = _id_1BEC(var_0, 0, 1);
  var_3 = 2;
  var_4 = 1;
  var_5 = var_0["position"];

  while(!level._id_1BD3 buttonPressed(var_1)) {
    var_6 = level._id_1BCE;

    if(level._id_1BD3 buttonPressed("BUTTON_A")) {
      var_4 = -1;
    } else if(level._id_1BD3 buttonPressed("BUTTON_B")) {
      var_4 = 1;
    } else {
      var_4 = 0;
    }
    var_6 = var_6 + var_4 * var_3;

    if(var_6 == 0) {
      var_6 = var_6 + var_4 * var_3;
    }
    level._id_1BCE = var_6;
    common_scripts\utility::array_thread(var_2, ::_id_1BDE, var_0);
    _id_1BE7(var_0, (1, 1, 1));
    wait 0.05;
  }

  common_scripts\utility::array_thread(var_2, ::_id_1B71);
  _id_1B9A();

  while(level._id_1BD3 buttonPressed(var_1)) {
    wait 0.05;
  }
}

_id_1BDE(var_0) {
  self.origin = self._id_1BDF + var_0["normal"] * level._id_1BCE;
}

_id_1BE0() {
  level._id_1BCC = 0;
  _id_1B9A();
}

_id_1BE1(var_0, var_1) {
  if(var_0["fraction"] == 1) {
    return;
  }
  while(level._id_1BD3 buttonPressed(var_1)) {
    wait 0.05;
  }
  _id_1BD6();
  level._id_1BCC = 1;
  level._id_1BE2 = level._id_1BD3 getplayerangles();
  var_2 = [];
  var_2 = _id_1BEC(var_0, 1, 1);
  var_3 = 0;
  var_4 = 1;
  var_5 = 0;

  while(!level._id_1BD3 buttonPressed(var_1)) {
    var_5 = 0;

    if(level._id_1BD3 buttonPressed("BUTTON_A")) {
      var_5 = -1;
    } else if(level._id_1BD3 buttonPressed("BUTTON_B")) {
      var_5 = 1;
    }
    var_3 = var_3 + var_5 * var_4;

    if(var_3 > 360) {
      var_3 = 1;
    }
    if(var_3 < 0) {
      var_3 = 359;
    }
    _id_1BE7(var_0, (0, 0, 1));
    level._id_1BE2 = level._id_1BD3 getplayerangles();
    level._id_1BE2 = level._id_1BE2 + (0, 0, var_3);

    for(var_6 = 0; var_6 < var_2.size; var_6++) {
      var_2[var_6].angles = level._id_1BE2;
    }
    wait 0.05;
  }

  _id_1B9A();

  while(level._id_1BD3 buttonPressed(var_1)) {
    wait 0.05;
  }
  for(var_6 = 0; var_6 < var_2.size; var_6++) {
    var_2[var_6] thread _id_1B71();
  }
}

_id_1B71() {
  self delete();
}

_id_1BE3() {
  self endon("death");
  level waittill("clear_previews");
  level._id_1BCB = common_scripts\utility::array_remove(level._id_1BCB, self);
  self delete();
}

_id_1BE4() {
  level notify("crosshair_fadetopoint");
  level endon("crosshair_fadetopoint");
  wait 2;
  level._id_1B2F.alpha = 0;
  level._id_1B2E.alpha = 1;
}

_id_1BE5(var_0, var_1) {
  if(gettime() - level._id_1BCF > 60) {
    level._id_1BD0 = 0;
  }
  level._id_1BD0 = level._id_1BD0 + 0.05;

  if(level._id_1BD0 < 0.5) {
    var_2 = 2;
  } else {
    var_2 = level._id_1BD0 / 0.3;
  }
  var_3 = level._id_1BC9;
  var_3 = var_3 + var_1 * var_2;

  if(var_3 > 0) {
    level._id_1BC9 = var_3;
  }
  level._id_1B31["helpradius"]._id_1B32 setvalue(level._id_1BC9);
  level._id_1BCF = gettime();
}

_id_1BE6(var_0, var_1) {
  var_2 = 2;
  var_3 = level._id_1BC5;
  var_3 = var_3 + var_1 * var_2;

  if(var_3 > 0) {
    level._id_1BC5 = var_3;
  }
  level._id_1B2F.alpha = 1;
  level._id_1B2E.alpha = 0;
  level._id_1B2F setvalue(level._id_1BC5);
  level._id_1B31["helpdensity"]._id_1B32 setvalue(level._id_1BC5);
  thread _id_1BE4();
}

_id_1BE7(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = (0, 1, 0);
  }
  if(var_0["fraction"] == 1) {
    return;
  }
  var_2 = vectortoangles(var_0["normal"]);
  var_3 = var_0["position"];
  var_4 = level._id_1BC9;
  _id_1BF0(var_3, var_4, var_2, var_1, 40, level._id_1BC9);

  if(level._id_1BCC) {
    draw_axis(var_3, level._id_1BE2);
  }
  if(level._id_1BCD) {
    common_scripts\utility::draw_arrow(var_3, var_3 + var_0["normal"] * level._id_1BCE, (1, 1, 1));
  }
}

_id_1B57() {
  var_0 = level._id_1BCA;
  var_1 = level._id_1BD3 getEye();
  return bulletTrace(var_1, var_1 + anglesToForward(level._id_1BD3 getplayerangles()) * var_0, 0, self);
}

_id_1BE8() {
  self addyaw(level._id_1BD3 getplayerangles()[1] - common_scripts\utility::flat_angle(self.angles)[1]);
}

_id_1B72() {
  return level._id_1BB1[level._id_1B3C];
}

_id_1BE9() {
  var_0 = _id_1B72();

  if(level._id_1BCC) {
    self.angles = level._id_1BE2;
    return;
  }

  if(level._id_1BB5) {
    self.angles = level._id_1BD3 getplayerangles();
  }
  if(level._id_1BB6) {
    _id_1BE8();
  }
  if(var_0._id_1BB7) {
    self.angles = common_scripts\utility::flat_angle(self.angles);
  }
  if(!level._id_1BB6 && !level._id_1BB5) {
    self addyaw(randomint(360));
  }
  if(var_0._id_1BB8) {
    self.angles = common_scripts\utility::flat_angle(vectortoangles(self.origin - level._id_1BD3 getEye()));
    self addyaw(90);
  }

  self addroll(var_0._id_1BBB[self.model][0]);
  self addpitch(var_0._id_1BBB[self.model][1]);
  self addyaw(var_0._id_1BBB[self.model][2]);
}

_id_1BEA(var_0) {
  if(level._id_1BC6) {
    return;
  }
  if(var_0["fraction"] == 1 && !level._id_1BB5) {
    return;
  }
  level._id_1BC6 = 1;
  var_1 = _id_1BEC(var_0, 1);
  level._id_1BC7 = common_scripts\utility::array_combine(level._id_1BC7, var_1);
  level._id_1BC6 = 0;
}

_id_1BEB() {
  var_0 = level._id_1BB1[level._id_1B3C]._id_1BD8;
  return var_0[randomint(var_0.size)];
}

_id_1BEC(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  var_3 = [];
  var_4 = level._id_1BC5;
  var_5 = level._id_1BC9;
  var_6 = int(var_5 / var_4) * 2;
  var_7 = 0;
  var_8 = var_0["position"];
  var_9 = vectortoangles(var_0["normal"]);

  if(var_1) {
    var_9 = var_9 + (0, randomfloat(360), 0);
  }
  var_10 = vectornormalize(anglestoright(var_9));
  var_11 = vectornormalize(anglestoup(var_9));
  var_12 = var_8;
  var_12 = var_12 - var_10 * var_5;
  var_12 = var_12 - var_11 * var_5;
  var_12 = var_12 + var_10 * var_4;
  var_12 = var_12 + var_11 * var_4;
  var_13 = var_12;

  if(var_6 == 0 || level._id_1BB5) {
    if(!var_2) {
      if(_id_1BED(var_8)) {
        return var_3;
      }
    }

    if(!var_2) {
      if(level._id_1BC7.size + var_3.size > level._id_1BDB) {
        return var_3;
      }
    }

    var_14 = _id_1BEB();
    var_3[0] = _id_1BEE(var_0, var_14);
    var_3[0] _id_1BE9();
    return var_3;
  }

  var_15 = [];

  for(var_16 = var_7; var_16 < var_6; var_16++) {
    for(var_17 = var_7; var_17 < var_6; var_17++) {
      if(!var_2) {
        if(level._id_1BC7.size + var_3.size > level._id_1BDB) {
          return var_3;
        }
      }

      var_13 = var_12;
      var_13 = var_13 + var_10 * var_16 * var_4;
      var_13 = var_13 + var_11 * var_17 * var_4;

      if(distance(var_13, var_8) > var_5) {
        continue;
      }
      var_15 = _id_1BEF(var_13, var_9, level._id_1BC9);

      if(var_15["fraction"] == 1) {
        continue;
      }
      if(_id_1BED(var_15["position"])) {
        continue;
      }
      var_14 = _id_1BEB();
      var_18 = _id_1BEE(var_15, var_14);
      var_18 _id_1BE9();
      var_3[var_3.size] = var_18;
    }
  }

  return var_3;
}

_id_1BED(var_0) {
  for(var_1 = level._id_1BC7.size - 1; var_1 >= 0; var_1--) {
    if(distance(level._id_1BC7[var_1]._id_1BDF, var_0) < level._id_1BC5 - 1) {
      return 1;
    }
  }

  return 0;
}

get_player() {
  return getEntArray("player", "classname")[0];
}

_id_1BEE(var_0, var_1) {
  var_2 = spawn("script_model", level._id_1BD3.origin);
  var_2 setModel(var_1);
  var_2 notsolid();
  var_2.origin = var_0["position"];
  var_2.angles = vectortoangles(var_0["normal"]);
  var_2 addpitch(90);
  var_2._id_1BDF = var_2.origin;
  var_3 = _id_1B72();

  if(level._id_1BCD) {
    var_2.origin = var_2.origin + var_0["normal"] * level._id_1BCE;
  }
  var_3 = _id_1B72();

  if(isDefined(var_3._id_1BD9[var_1])) {
    var_2.origin = var_2.origin + var_0["normal"] * var_3._id_1BD9[var_1];
  }
  if(isDefined(var_3._id_1BDA[var_1])) {
    var_2._id_1BDA = var_3._id_1BDA[var_1];
  }
  return var_2;
}

_id_1BEF(var_0, var_1, var_2) {
  var_3 = var_2;
  var_4 = anglesToForward(var_1);
  var_5 = var_0 + var_4 * var_3;
  var_6 = var_0 + var_4 * -1 * var_3;
  return bulletTrace(var_5, var_6, 0, level._id_1BD3);
}

_id_1BF0(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3)) {
    var_3 = (0, 1, 0);
  }
  if(!isDefined(var_4)) {
    var_4 = 16;
  }
  var_6 = var_4 / 2;
  var_7 = 360 / var_4;
  var_4++;
  var_8 = [];
  var_9 = 0;
  var_8 = [];
  var_9 = 0.0;

  for(var_10 = 0; var_10 < var_4; var_10++) {
    var_11 = var_0 + anglestoup(var_2 + (0, 0, var_9)) * var_1;
    var_12 = _id_1BEF(var_11, var_2, level._id_1BC9);

    if(var_12["fraction"] != 1) {
      var_8[var_8.size] = var_12["position"];
    }
    var_9 = var_9 + var_7;
  }

  common_scripts\utility::plot_points(var_8, var_3[0], var_3[1], var_3[2]);
  var_8 = [];
}

_id_1BF1(var_0) {
  var_1 = var_0["position"];
  var_2 = [];
  var_3 = [];

  for(var_4 = 0; var_4 < level._id_1BC7.size; var_4++) {
    if(distance(level._id_1BC7[var_4]._id_1BDF, var_1) > level._id_1BC9) {
      var_2[var_2.size] = level._id_1BC7[var_4];
      continue;
    }

    var_3[var_3.size] = level._id_1BC7[var_4];
  }

  level._id_1BC7 = var_2;

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_3[var_4] delete();
  }
}

_id_1BF2() {}

draw_axis(var_0, var_1) {
  var_2 = 32;
  var_3 = var_2 * anglesToForward(var_1);
  var_4 = var_2 * anglestoright(var_1);
  var_5 = var_2 * anglestoup(var_1);
}

_id_1B34() {
  if(!isDefined(level._id_1B35)) {
    level._id_1B35 = [];
  }
  var_0 = newhudelem();
  level._id_1B35[level._id_1B35.size] = var_0;
  return var_0;
}

_id_1B36(var_0) {
  self._id_1B37 = var_0;
  self settext("_");
  thread _id_1ADE();
  var_1 = 0;

  foreach(var_3 in level._id_1B35) {
    if(isDefined(var_3._id_1B37)) {
      var_1 = var_1 + var_3._id_1B37.size;
      var_3 settext(var_3._id_1B37);
    }
  }
}

_id_1B30(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 520;

  if(_id_1BF3()) {
    var_5 = 630;
  }
  var_6 = 120;
  var_7 = 18;
  var_8 = 0.8;
  var_9 = 20;
  var_10 = 1.4;

  if(!isDefined(var_2)) {
    var_2 = "";
  }
  if(!isDefined(level._id_1B31) || !isDefined(level._id_1B31[var_0])) {
    level._id_1B31[var_0] = _id_1B34();
    var_11 = _id_1B34();
  } else {
    var_11 = level._id_1B31[var_0]._id_1B32;
  }
  level._id_1B31[var_0].location = 0;
  level._id_1B31[var_0].alignx = "right";
  level._id_1B31[var_0].aligny = "middle";
  level._id_1B31[var_0].foreground = 1;
  level._id_1B31[var_0].fontscale = 1.5;
  level._id_1B31[var_0].sort = 20;
  level._id_1B31[var_0].alpha = var_8;
  level._id_1B31[var_0].x = var_5 + var_9;
  level._id_1B31[var_0].y = var_6 + var_1 * var_7;
  level._id_1B31[var_0] _id_1B36(var_2);
  level._id_1B31[var_0]._id_1B33 = var_2;
  var_11.location = 0;
  var_11.alignx = "left";
  var_11.aligny = "middle";
  var_11.foreground = 1;
  var_11.fontscale = var_10;
  var_11.sort = 20;
  var_11.alpha = var_8;
  var_11.x = var_5 + var_9;
  var_11.y = var_6 + var_1 * var_7;

  if(isDefined(var_4)) {
    var_11 setvalue(var_4);
  }
  if(isDefined(var_3)) {
    var_11 _id_1B36(var_3);
  }
  level._id_1B31[var_0]._id_1B32 = var_11;
}

_id_1B62(var_0, var_1) {
  if(_id_1BF3()) {
    level._id_1B31[var_0] _id_1B36(level._id_1B31[var_0]._id_1B33 + var_1);
    level._id_1B31[var_0]._id_1B32 _id_1B36("");
  } else {
    level._id_1B31[var_0]._id_1B32 _id_1B36(var_1);
  }
}

_id_1B63(var_0, var_1) {
  level._id_1B31[var_0] _id_1B36(var_1);
}

_id_1ADE() {
  if(level._id_1ADE) {
    return;
  }
  level._id_1ADE = 1;
  self clearalltextafterhudelem();
  wait 0.05;
  level._id_1ADE = 0;
}

_id_1BF3() {
  return issubstr(level.script, "mp_");
}