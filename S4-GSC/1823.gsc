/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1823.gsc
*************************************************/

_id_7F58() {
  if(istrue(level._id_48D7)) {
    return;
  }
  level._id_48D7 = 1;
  level._id_7B64 = [];
  level._id_7B62 = 16;
  var_0 = [];
  var_1 = [];
  var_0[0] = 0;
  var_1[0] = 0;
  var_0[1] = 1;
  var_1[1] = 1;
  var_0[2] = -2;
  var_1[2] = 1;
  var_0[3] = 1;
  var_1[3] = -1;
  var_0[4] = -2;
  var_1[4] = -1;
  level._id_398E = newhudelem();
  level._id_398E.alpha = 0;
  level._id_398E.archived = 0;

  for(var_2 = 0; var_2 < level._id_7B62; var_2++) {
    var_3 = [];

    for(var_4 = 0; var_4 < 1; var_4++) {
      var_5 = newhudelem();
      var_5.alignx = "left";
      var_5.aligny = "middle";
      var_5.archived = 0;
      var_5._id_96CF = 0;
      var_5._id_01D6 = 1;
      var_5.fontscale = 0.75;
      var_5.sort = 20 - var_4;
      var_5.alpha = 1;
      var_5.x = -70 + var_0[var_4];
      var_5.y = 30 + var_1[var_4] + var_2 * 10;

      if(var_4 > 0) {
        var_5.color = (0, 0, 0);
      }

      var_3[var_3.size] = var_5;
    }

    level._id_7B64[var_2] = var_3;
  }

  var_6 = newhudelem();
  var_6.archived = 0;
  var_6.alignx = "center";
  var_6._id_96CF = 0;
  var_6._id_01D6 = 1;
  var_6.fontscale = 1.4;
  var_6.sort = 20;
  var_6.alpha = 1;
  var_6.x = 320;
  var_6.y = 40;
  level._id_3391 = var_6;
}

_id_7934(var_0, var_1) {
  var_0 notify("highlight_current_selection");
  var_0 endon("highlight_current_selection");
  var_0 endon("disconnect");
  level endon("game_ended");

  if(!isDefined(level._id_DDEF)) {
    level._id_DDEF = 0;
  }

  if(!isDefined(level._id_DDF1)) {
    level._id_DDF1 = 14;
  }

  setDvar("#x393c36bd21fb8b8cc", "");
  var_0 notifyonplayercommand("B", "+stance");
  var_0 notifyonplayercommand("LT", "+speed_throw");
  var_0 notifyonplayercommand("A", "+goStand");
  var_0 notifyonplayercommand("X", "+usereload");
  var_0 notifyonplayercommand("X", "+activate");
  var_0 notifyonplayercommand("RS", "+melee_zoom");
  var_0 notifyonplayercommand("LS", "+breath_sprint");
  var_0 notifyonplayercommand("RT", "+attack");
  var_0 notifyonplayercommand("RB", "+frag");
  var_0 notifyonplayercommand("LB", "+smoke");
  var_0 notifyonplayercommand("Y", "+weapnext");
  var_0 notifyonplayercommand("UP", "+actionslot 1");
  var_0 notifyonplayercommand("DOWN", "+actionslot 2");
  var_0 notifyonplayercommand("LEFT", "+actionslot 3");
  var_0 notifyonplayercommand("RIGHT", "+actionslot 4");
  var_0 notifyonplayercommand("BACK", "+focus");
  var_0 notifyonplayercommand("START", "pause");
  level thread _id_DC6B(level._id_DDEF, var_1);

  for(;;) {
    var_2 = var_0 scripts\engine\utility::_id_10892(["A", "B", "Y", "X", "LB", "RB", "RT", "LT", "RS", "LS", "UP", "DOWN", "LEFT", "RIGHT", "BACK"]);

    if(!isDefined(var_2)) {
      continue;
    }
    switch (var_2) {
      case "Y":
      case "B":
        _id_38DB();
        return;
      case "A":
        _id_38DB();
        return level._id_9DBC;
      case "DOWN":
        level._id_DDEF++;
        level._id_DDEF = scripts\engine\math::_id_10FA2(0, var_1.size - 1, level._id_DDEF);
        thread _id_DC6B(level._id_DDEF, var_1);
        break;
      case "UP":
        level._id_DDEF--;
        level._id_DDEF = scripts\engine\math::_id_10FA2(0, var_1.size - 1, level._id_DDEF);
        thread _id_DC6B(level._id_DDEF, var_1);
        break;
      case "RIGHT":
        break;
      case "LEFT":
        break;
    }
  }
}

_id_DC6B(var_0, var_1) {
  _id_38DB();
  var_2 = [];
  var_3 = clamp(var_1.size, 0, level._id_DDF1);
  var_4 = var_1.size - 1;
  var_5 = scripts\engine\math::_id_10FA2(0, var_4, var_0);
  var_6 = var_1[var_5];
  var_7 = min(level._id_DDF1, var_1.size);
  var_8 = int(var_7 / 2);
  var_9 = var_0 - var_8;
  var_9 = scripts\engine\math::_id_10FA2(0, var_4, var_9);

  for(var_10 = 0; var_10 < var_7; var_10++) {
    if(!isDefined(var_1[var_9])) {
      continue;
    }
    var_2[var_2.size] = var_1[var_9];
    var_9++;
    var_9 = scripts\engine\math::_id_10FA2(0, var_4, var_9);
  }

  for(var_10 = 0; var_10 < var_2.size; var_10++) {
    var_11 = var_2[var_10];

    if(var_10 == var_8) {
      level._id_9DBC = var_11;
      var_11 = "->" + var_11;
      var_12 = (1, 1, 0);
    } else
      var_12 = (1, 1, 1);

    _id_D24C(var_11, var_12);
  }
}

_id_D24C(var_0, var_1) {
  for(var_2 = 0; var_2 < 1; var_2++) {
    if(isDefined(var_1)) {
      level._id_7B64[level._id_B170][var_2].color = var_1;
    }
  }

  level._id_B170++;
}

_id_38DB() {
  level._id_398E _meth_8076();

  for(var_0 = 0; var_0 < level._id_7B62; var_0++) {
    for(var_1 = 0; var_1 < 1; var_1++) {
      level._id_7B64[var_0][var_1].color = (1, 1, 1);
    }
  }

  level._id_B170 = 0;
}