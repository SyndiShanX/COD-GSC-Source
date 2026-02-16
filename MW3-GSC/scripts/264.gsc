/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\264.gsc
**************************************/

#using_animtree("generic_human");

main(var_0) {
  if(!getdvarint("noder")) {
    return;
  }
  level._id_1B42 = [];
  level._id_0C59["generic"]["node_cover_left"][0] = % cornercrl_reloada;
  level._id_0C59["generic"]["node_cover_left"][1] = % cornercrl_look_fast;
  level._id_0C59["generic"]["node_cover_left"][2] = % corner_standl_grenade_b;
  level._id_0C59["generic"]["node_cover_left"][3] = % corner_standl_flinch;
  level._id_0C59["generic"]["node_cover_left"][4] = % corner_standl_look_idle;
  level._id_0C59["generic"]["node_cover_left"][5] = % corner_standl_look_2_alert;
  level._id_0C59["generic"]["node_cover_right"][0] = % cornercrr_reloada;
  level._id_0C59["generic"]["node_cover_right"][1] = % corner_standr_grenade_b;
  level._id_0C59["generic"]["node_cover_right"][2] = % corner_standr_flinch;
  level._id_0C59["generic"]["node_cover_right"][3] = % corner_standr_look_idle;
  level._id_0C59["generic"]["node_cover_right"][4] = % corner_standr_look_2_alert;
  level._id_0C59["generic"]["node_cover_crouch"][0] = % covercrouch_hide_idle;
  level._id_0C59["generic"]["node_cover_crouch"][1] = % covercrouch_twitch_1;
  level._id_0C59["generic"]["node_cover_crouch"][2] = % covercrouch_hide_2_aim;
  level._id_0C59["generic"]["node_cover_crouch"][3] = % covercrouch_hide_2_aim;
  level._id_0C59["generic"]["node_cover_crouch"][4] = % covercrouch_hide_2_aim;
  level._id_0C59["generic"]["node_cover_crouch"][5] = % covercrouch_hide_look;
  level._id_0C59["generic"]["node_cover_crouch_window"][0] = % covercrouch_hide_idle;
  level._id_0C59["generic"]["node_cover_crouch_window"][1] = % covercrouch_twitch_1;
  level._id_0C59["generic"]["node_cover_crouch_window"][2] = % covercrouch_hide_2_aim;
  level._id_0C59["generic"]["node_cover_crouch_window"][3] = % covercrouch_hide_2_aim;
  level._id_0C59["generic"]["node_cover_crouch_window"][4] = % covercrouch_hide_2_aim;
  level._id_0C59["generic"]["node_cover_crouch_window"][5] = % covercrouch_hide_look;
  level._id_0C59["generic"]["node_cover_prone"][0] = % crouch_2_prone_firing;
  level._id_0C59["generic"]["node_cover_prone"][1] = % prone_2_crouch;
  level._id_0C59["generic"]["node_cover_prone"][2] = % prone_reload;
  level._id_0C59["generic"]["node_cover_stand"][0] = % coverstand_reloada;
  level._id_0C59["generic"]["node_concealment_crouch"][0] = % covercrouch_hide_idle;
  level._id_0C59["generic"]["node_concealment_crouch"][1] = % covercrouch_twitch_1;
  level._id_0C59["generic"]["node_concealment_crouch"][2] = % covercrouch_hide_2_aim;
  level._id_0C59["generic"]["node_concealment_crouch"][3] = % covercrouch_hide_2_aim;
  level._id_0C59["generic"]["node_concealment_crouch"][4] = % covercrouch_hide_2_aim;
  level._id_0C59["generic"]["node_concealment_crouch"][5] = % covercrouch_hide_look;
  level._id_0C59["generic"]["node_concealment_prone"][0] = % crouch_2_prone_firing;
  level._id_0C59["generic"]["node_concealment_prone"][1] = % prone_2_crouch;
  level._id_0C59["generic"]["node_concealment_prone"][2] = % prone_reload;
  level._id_0C59["generic"]["node_concealment_stand"][0] = % coverstand_reloada;
  level._id_1B43 = [];
  level._id_1B43["node_cover_left"] = (0, 90, 0);
  level._id_1B43["node_cover_right"] = (0, -90, 0);
  level._id_1B43["node_pathnode"] = (0, 0, 0);
  level._id_1B43["node_cover_crouch"] = (0, 0, 0);
  level._id_1B43["node_cover_crouch_window"] = (0, 0, 0);
  level._id_1B43["node_cover_prone"] = (0, 0, 0);
  level._id_1B43["node_cover_stand"] = (0, 0, 0);
  level._id_1B43["node_concealment_crouch"] = (0, 0, 0);
  level._id_1B43["node_concealment_prone"] = (0, 0, 0);
  level._id_1B43["node_concealment_stand"] = (0, 0, 0);
  level._id_1B44 = 0;
  level._id_1B45 = [];
  var_1 = getspawnerarray();
  level._id_1B46 = 0;
  level._id_1B47 = [];

  if(var_1.size) {
    var_2 = var_1[0];
    var_2 maps\_spawner::_id_1B48();

    for(var_3 = 0; var_3 < 20; var_3++) {
      level._id_1B47[var_3] = maps\_spawner::_id_1B49(var_2);
      level._id_1B47[var_3] notsolid();
      level._id_1B47[var_3] hide();
      level._id_1B47[var_3]._id_11E5 = 1;
      level._id_1B47[var_3]._id_1B4A = var_3;
      level._id_1B4B[var_3] = spawn("script_origin", (0, 0, 0));
      level._id_1B4B[var_3]._id_1B4B = 1;
      level._id_1B46++;
    }
  }

  level._id_1B4C = 0;
  maps\_anim::init();
  var_4 = getEntArray();

  foreach(var_6 in var_4) {
    if(isDefined(var_6.classname) && var_6.classname == "player" || isDefined(var_6._id_11E5) || isDefined(var_6._id_1B4B)) {
      continue;
    }
    if(isDefined(var_6)) {
      var_6 delete();
    }
  }

  var_4 = undefined;
  level._id_1B4D = 64;
  level._id_1B4E = [];
  level._id_1B4F = "node_pathnode";
  level._id_1B50 = [];
  level._id_1B51 = (0, 0, 32);
  level._id_1B52 = 0;
  level._id_1B53 = 256;
  level._id_1B54 = undefined;
  level._id_1B55 = 0;
  level._id_1B56 = 1;
  _id_1B66("node_pathnode", undefined);
  _id_1B66("node_cover_crouch");
  _id_1B66("node_cover_crouch_window");
  _id_1B66("node_cover_left", -1);
  _id_1B66("node_cover_right", 1);
  _id_1B66("node_cover_prone");
  _id_1B66("node_cover_stand");
  _id_1B66("node_concealment_crouch");
  _id_1B66("node_concealment_prone");
  _id_1B66("node_concealment_stand");
  thread hack_start();
  thread _id_1B2C();
  thread _id_1B59();
  common_scripts\utility::flag_wait("user_hud_active");
  thread _id_1B93();
  thread _id_1BAF();
  level._id_1B42 = [];
  var_8 = getallnodes();

  if(var_8.size) {
    level.player setorigin(maps\_utility::_id_0AE9(level.player.origin, var_8).origin);
  }
  for(;;) {
    wait 0.05;
    level._id_1B57 = _id_1B57();
    _id_1B75(1);
  }
}

hack_start() {
  common_scripts\utility::flag_init("user_alive");

  while(!isDefined(_id_1B78())) {
    wait 0.05;
  }
  wait 0.05;
  level._id_1B58 = _id_1B78();
  level._id_1B58 takeallweapons();
  level._id_1B58 allowcrouch(0);
  level._id_1B58 allowjump(0);
  level._id_1B58 allowprone(0);
  common_scripts\utility::flag_set("user_alive");
}

_id_1B59() {
  level._id_1B5A = spawn("script_model", (0, 0, 0));
  precachemodel("node_preview");
  level._id_1B5A setModel("node_preview");
  level._id_1B5A notsolid();
  level._id_1B5B = spawn("script_model", (0, 0, 0));
  level._id_1B5B setModel("node_select");
  level._id_1B5B notsolid();
  level._id_1B5B hide();
  level._id_1B5C = undefined;
  _id_1B3B(level._id_1B4F);
  level._id_1B4F = undefined;
  _id_1B41();
}

_id_1B5D() {
  level._id_1B5E["helppm"]._id_1B32 setvalue(level._id_1B50.size);
  var_0 = 256;

  if(level._id_1B50.size < var_0) {
    level._id_1B5E["helppm"]._id_1B32.color = (1, 1, 1);
    return;
  }

  var_1 = 1;
  var_2 = 1 - (level._id_1B50.size - var_0) / var_0;
  var_3 = var_2;
  level._id_1B5E["helppm"]._id_1B32.color = (var_1, var_2, var_3);
}

_id_1B30(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 520;
  var_6 = 120;
  var_7 = 18;
  var_8 = 0.8;
  var_9 = 20;
  var_10 = 1.4;

  if(!isDefined(level._id_1B5E) || !isDefined(level._id_1B5E[var_0])) {
    level._id_1B5E[var_0] = _id_1B34();
    var_11 = _id_1B34();
  } else {
    var_11 = level._id_1B5E[var_0]._id_1B32;
  }
  level._id_1B5E[var_0].location = 0;
  level._id_1B5E[var_0].alignx = "right";
  level._id_1B5E[var_0].aligny = "middle";
  level._id_1B5E[var_0].foreground = 1;
  level._id_1B5E[var_0].fontscale = 1.5;
  level._id_1B5E[var_0].sort = 20;
  level._id_1B5E[var_0].alpha = var_8;
  level._id_1B5E[var_0].x = var_5 + var_9;
  level._id_1B5E[var_0].y = var_6 + var_1 * var_7;
  level._id_1B5E[var_0] _id_1B36(var_2);
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
  level._id_1B5E[var_0]._id_1B32 = var_11;
}

_id_1B2C() {
  common_scripts\utility::flag_init("user_hud_active");
  common_scripts\utility::flag_wait("user_alive");
  var_0 = 17;
  var_1 = [];
  var_2 = 15;
  var_3 = int(var_0 / 2);
  var_4 = 240 + var_3 * var_2;
  var_5 = 0.7 / var_3;
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
    var_1[var_7].x = 0;
    var_1[var_7].y = var_4;
    var_1[var_7] _id_1B36(".");

    if(var_7 == var_3) {
      var_5 = var_5 * -1;
    }
    var_6 = var_6 + var_5;
    var_4 = var_4 - var_2;
  }

  level._id_1B5F = var_1;
  var_8 = _id_1B34();
  var_8.location = 0;
  var_8.alignx = "left";
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
  var_9 = _id_1B34();
  var_9.location = 0;
  var_9.alignx = "center";
  var_9.aligny = "bottom";
  var_9.foreground = 1;
  var_9.fontscale = 2;
  var_9.sort = 20;
  var_9.alpha = 1;
  var_9.x = 320;
  var_9.y = 300;
  var_9 _id_1B36("");
  level._id_1B60 = var_9;
  var_10 = _id_1B34();
  var_10.location = 0;
  var_10.alignx = "center";
  var_10.aligny = "bottom";
  var_10.foreground = 1;
  var_10.fontscale = 2;
  var_10.sort = 20;
  var_10.alpha = 1;
  var_10.x = 320;
  var_10.y = 300;
  var_10 _id_1B36("");
  level._id_1B61 = var_10;
  var_11 = 550;
  var_12 = 120;
  var_13 = 18;
  var_14 = 1;
  var_15 = 0.8;
  var_16 = 20;
  var_17 = 1.4;
  _id_1B30("helppm", 1, "^5Placed Nodes: ", undefined, level._id_1B50.size);
  _id_1B30("gridsize", 2, "^5Grid Size: ", undefined, level._id_1B53);
  _id_1B30("helpxy", 6, "^4X/^3Y: ", undefined, level._id_1B4D);
  _id_1B30("helpab", 7, "^2A/^1B^7: ", "-");
  _id_1B30("helplsrs", 8, "^8L^7/R Stick: ", "-");
  _id_1B30("helplbrb", 9, "^8L^7/R Shoulder: ", "-");
  _id_1B30("helpdpu", 10, "^8DPad U/^7D: ", "-");
  _id_1B30("helpdpl", 11, "^8DPad L/^7R: ", "-");
  _id_1B30("helpF", 17, "^8W: ", "-");
  level._id_1B5E["helpF"].x = var_11 - 450;
  level._id_1B5E["helpF"]._id_1B32.x = var_11 - 450;
  _id_1B9A();
  common_scripts\utility::flag_set("user_hud_active");
}

_id_1B62(var_0, var_1) {
  level._id_1B5E[var_0]._id_1B32 _id_1B36(var_1);
}

_id_1B63(var_0, var_1) {
  level._id_1B5E[var_0] _id_1B36(var_1);
}

_id_1B3B(var_0) {
  common_scripts\utility::flag_wait("user_hud_active");
  level._id_1B64 = var_0;
  var_1 = getarraykeys(level._id_1B4E);
  var_2 = 0;
  var_3 = int(level._id_1B5F.size / 2);

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(var_1[var_4] == var_0) {
      var_2 = var_4;
      break;
    }
  }

  for(var_4 = 0; var_4 < level._id_1B5F.size; var_4++) {
    level._id_1B5F[var_4] clearalltextafterhudelem();
  }
  level._id_1B5F[var_3] _id_1B36("^3" + _id_1B7F(var_1[var_2]));

  for(var_4 = 1; var_4 < level._id_1B5F.size - var_3; var_4++) {
    if(var_2 - var_4 < 0) {
      level._id_1B5F[var_3 + var_4] _id_1B36("-- --");
      continue;
    }

    level._id_1B5F[var_3 + var_4] _id_1B36(_id_1B7F(var_1[var_2 - var_4]));
  }

  for(var_4 = 1; var_4 < level._id_1B5F.size - var_3; var_4++) {
    if(var_2 + var_4 > var_1.size - 1) {
      level._id_1B5F[var_3 - var_4] _id_1B36("-- --");
      continue;
    }

    level._id_1B5F[var_3 - var_4] _id_1B36(_id_1B7F(var_1[var_2 + var_4]));
  }

  var_0 = _id_1B72();
  level._id_1B53 = var_0._id_1B65;
  _id_1B89();
}

_id_1B38() {
  var_0 = undefined;
  var_1 = getarraykeys(level._id_1B4E);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == level._id_1B64) {
      var_0 = var_2 + 1;
      break;
    }
  }

  if(var_0 == var_1.size) {
    var_0 = 0;
  }
  _id_1B3B(var_1[var_0]);
}

_id_1B39() {
  var_0 = undefined;
  var_1 = getarraykeys(level._id_1B4E);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == level._id_1B64) {
      var_0 = var_2 - 1;
      break;
    }
  }

  if(var_0 < 0) {
    var_0 = var_1.size - 1;
  }
  _id_1B3B(var_1[var_0]);
}

_id_1B66(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  precachemodel(var_0);

  if(!isDefined(level._id_1B4E[var_0])) {
    var_3 = spawnStruct();
    var_3._id_1B67 = var_1;
    var_3._id_1B65 = var_2;
    level._id_1B4E[var_0] = var_3;
  }

  level._id_1B4E[var_0].model = var_0;
}

_id_1B41() {
  level._id_1B68 = 950;
  common_scripts\utility::flag_wait("user_hud_active");
  level._id_1B58 takeallweapons();
  level._id_1B69 = [];
  level._id_1B6A = [];
  level._id_1B58 thread _id_1B6D();
  level._id_1B58 thread _id_1B6B();
  _id_1B96();
  _id_1B70(::_id_1BA5, ::_id_1BA6, "BUTTON_LSTICK");
}

_id_1B6B() {
  for(;;) {
    foreach(var_2, var_1 in level._id_1B69) {
      if(self buttonPressed(var_2)) {
        [[level._id_1B69[var_2]]]();

        while(self buttonPressed(var_2)) {
          wait 0.05;
        }
        [[level._id_1B6C[var_2]]]();
        wait 0.05;
      }
    }

    wait 0.05;
  }
}

_id_1B6D() {
  for(;;) {
    foreach(var_2, var_1 in level._id_1B6A) {
      if(self buttonPressed(var_2)) {
        [[level._id_1B6A[var_2]]]();

        if(!level._id_1B6E[var_2]) {
          while(self buttonPressed(var_2)) {
            wait 0.05;
          }
        }

        break;
      }
    }

    wait 0.05;
  }
}

_id_1B6F(var_0, var_1, var_2) {
  var_3 = [];
  level._id_1B6A[var_2] = var_0;
  level._id_1B6E[var_2] = var_1;
}

_id_1B70(var_0, var_1, var_2) {
  level._id_1B69[var_2] = var_0;
  level._id_1B6C[var_2] = var_1;
}

_id_1B71() {
  self delete();
}

_id_1B72() {
  return level._id_1B4E[level._id_1B64];
}

_id_1B73(var_0) {
  var_1 = level._id_1B57;
  var_2 = var_1["position"];
  var_3 = 16 * vectornormalize(var_1["normal"]);
  var_4 = var_2 + var_3;
  var_5 = _id_1B74(var_4, var_0);

  if(isDefined(var_5)) {
    var_4 = var_5;
  }
  return _id_1B82(var_4) + level._id_1B51;
}

_id_1B74(var_0, var_1) {
  var_2 = _id_1B72();
  var_3 = var_2._id_1B67;

  if(var_3 == 0) {
    return;
  }
  var_4 = var_0;
  var_5 = var_4;
  var_6 = 32;
  var_7 = 16 * var_3 * vectornormalize(anglestoright(var_1));

  for(var_8 = 1; var_8 < 15; var_8++) {
    var_4 = var_5;
    var_0 = var_4;
    var_9 = var_8 * var_6 * var_3 * vectornormalize(anglestoright(var_1));
    var_10 = _id_1B80(var_0, var_0 + var_9, 0);
    var_0 = var_0 + var_10["fraction"] * var_9;

    if(var_10["fraction"] < 1) {
      continue;
    } else {}

    var_4 = var_0;
    var_11 = 32 * vectornormalize(anglesToForward(var_1));
    var_10 = _id_1B80(var_0, var_0 + var_11, 0);
    var_12 = var_10["fraction"];

    if(var_10["fraction"] == 1) {
      var_12 = 0.51;
    }
    var_0 = var_0 + var_12 * var_11;

    if(var_10["fraction"] < var_12) {
      continue;
    } else {}

    var_4 = var_0;
    var_13 = var_9 * -1 - var_7;
    var_10 = _id_1B80(var_0, var_0 + var_13, 0);
    var_0 = var_0 + var_10["fraction"] * var_13;

    if(var_10["fraction"] > 0.99) {
      continue;
    } else {}

    var_14 = var_0;
    var_15 = var_14 + var_7 * -1 + var_11 * var_12 * -1;
    var_16 = var_15 + var_7 * 0.9;
    var_10 = _id_1B80(var_16, var_16 + var_11 * 0.5, 0);

    if(var_10["fraction"] < 1) {
      var_15 = var_10["position"] - var_11 * 0.5 + var_7 * -0.9;
    }
    return var_15;
  }

  return undefined;
}

_id_1B75(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }
  var_1 = level._id_1B57;
  var_2 = common_scripts\utility::flat_angle(level.player getplayerangles());
  var_3 = var_1["position"] + level._id_1B51;

  if(var_1["fraction"] == 1 || level._id_1B50.size > level._id_1B68) {
    level._id_1B5A hide();
    return;
  }

  if(_id_1B7E()) {
    level._id_1B5A dontinterpolate();
    var_2 = vectortoangles(-1 * var_1["normal"]);
    var_3 = _id_1B73(var_2);
  } else if(level._id_1B53) {
    level._id_1B5A dontinterpolate();
    var_3 = _id_1B83(var_3);
    _id_1B85(var_3, var_0);
    var_2 = (0, 0, 0);
  }

  if(_id_1B87(var_3)) {
    level._id_1B5A hide();
    _id_1B91();
    return;
  } else if(_id_1B88(var_3)) {
    _id_1B91();
  } else {
    _id_1B92();
    level._id_1B5A show();
  }

  _id_1BAE(var_3);
  _id_1B76(var_3, var_2, var_0);
}

_id_1B76(var_0, var_1, var_2) {
  var_3 = _id_1B72();

  if(var_2) {
    var_4 = level._id_1B5A;
    var_4.origin = var_0;
  } else {
    var_4 = spawn("script_model", var_0);
  }
  var_4 notsolid();

  if(!var_2) {
    var_4 setModel(var_3.model);
  }
  var_4.angles = var_1;

  if(var_3.model == "node_pathnode") {
    var_4.angles = (0, 0, 0);
  }
  if(!var_2) {
    _id_1B8F(var_4);
    level._id_1B50[level._id_1B50.size] = var_4;
  }

  _id_1B5D();
}

_id_1B77() {
  var_0 = common_scripts\utility::flat_angle(level._id_1B58 getplayerangles());
  var_1 = _id_1B82(level._id_1B58.origin + (0, 0, 16)) + level._id_1B51;

  if(_id_1B87(var_1)) {
    return;
  }
  _id_1B76(var_1, var_0, 0);
  _id_1B5D();
}

_id_1B78() {
  return getEntArray("player", "classname")[0];
}

_id_1B79() {
  var_0 = undefined;

  if(isDefined(level._id_1B5C)) {
    var_0 = level._id_1B5C;
  }
  if(isDefined(level._id_1B57["entity"])) {
    var_0 = level._id_1B57["entity"];

    if(!issubstr(var_0.model, "node_")) {
      var_0 = undefined;
    }
  }

  if(!isDefined(var_0)) {
    return;
  }
  level._id_1B7A = common_scripts\utility::array_remove(level._id_1B7A, var_0);
  level._id_1B50 = common_scripts\utility::array_remove(level._id_1B50, var_0);

  if(isDefined(var_0._id_1B7B)) {
    var_0._id_1B7B hide();
    var_0._id_1B7B._id_1B7C = 1;
  }

  var_0 delete();
  level._id_1B44 = 1;
  _id_1B5D();
}

_id_1B7D() {}

_id_1B57() {
  var_0 = 2000;
  var_1 = level._id_1B58 getEye();
  return bulletTrace(var_1, var_1 + anglesToForward(level._id_1B58 getplayerangles()) * var_0, 0, level._id_1B5A);
}

_id_1B7E() {
  if(!isDefined(level._id_1B57["normal"])) {
    return 0;
  }
  if(_id_1B81(level._id_1B57)) {
    return 0;
  }
  var_0 = vectortoangles(level._id_1B57["normal"]);
  var_1 = common_scripts\utility::flat_angle(var_0);

  if(vectordot(anglesToForward(var_1), anglesToForward(var_0)) == 1) {
    return 1;
  } else {
    return 0;
  }
}

_id_1B7F(var_0) {
  var_1 = "";

  for(var_2 = 5; var_2 < var_0.size; var_2++) {
    var_1 = var_1 + var_0[var_2];
  }
  return var_1;
}

_id_1B80(var_0, var_1, var_2, var_3) {
  var_4 = bulletTrace(var_0, var_1, var_2, var_3);

  if(_id_1B81(var_4)) {
    var_4 = bulletTrace(var_0, var_1, var_2, var_4["entity"]);
  }
  return var_4;
}

_id_1B81(var_0) {
  return isDefined(var_0["entity"]) && isDefined(var_0["entity"].model) && issubstr(var_0["entity"].model, "node_");
}

_id_1B82(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = -100000;
  }
  return _id_1B80(var_0, var_0 + (0, 0, var_1), 0, self)["position"];
}

_id_1B83(var_0) {
  var_1 = level._id_1B53;
  var_2 = _id_1B84(var_0[0], var_1);
  var_3 = _id_1B84(var_0[1], var_1);
  return _id_1B82((var_2, var_3, var_0[2] + 32)) + level._id_1B51;
}

_id_1B84(var_0, var_1) {
  var_2 = var_0 / var_1;
  var_3 = int(var_2);
  var_4 = var_2 - var_3;

  if(var_4 < -0.5) {
    var_3--;
  } else if(var_4 > 0.5) {
    var_3++;
  }
  return var_3 * var_1;
}

_id_1B85(var_0, var_1) {
  var_2 = 1;
  var_3 = (0, 1, 0);
  var_0 = _id_1B82(var_0);
  var_4 = var_0 + (0, 0, level._id_1B53);

  for(var_5 = var_2 * -1; var_5 < var_2 + 1; var_5++) {
    for(var_6 = var_2 * -1; var_6 < var_2 + 1; var_6++) {
      if(var_5 != var_2) {}

      if(var_6 != var_2) {}
    }
  }
}

_id_1B86(var_0, var_1, var_2, var_3) {
  var_4 = level._id_1B53 * -2;
  var_0 = _id_1B82(var_0, var_4);
  var_1 = _id_1B82(var_1, var_4);
}

_id_1B87(var_0) {
  var_1 = 0;
  var_2 = 68;
  var_3 = undefined;

  foreach(var_5 in level._id_1B50) {
    var_6 = distance(var_0, var_5.origin);

    if(var_6 < 32) {
      var_1++;

      if(var_6 < 0.05) {
        var_1 = 6;
      }
      if(var_6 < var_2) {
        var_3 = var_5;
      }
    }
  }

  if(!isDefined(var_3)) {
    return 0;
  }
  level._id_1B54 = var_3;

  if(var_1 >= 2) {
    return 1;
  }
  return 0;
}

_id_1B88(var_0) {
  foreach(var_2 in level._id_1B50) {
    if(distance(var_0, var_2.origin) < 32) {
      level._id_1B54 = var_2;
      return 1;
    }
  }

  return 0;
}

_id_1B89() {
  var_0 = "^7";

  if(level._id_1B53 != 0) {
    var_0 = "^1";
  }
  level._id_1B5E["gridsize"]._id_1B32 _id_1B36(var_0 + level._id_1B53);
}

_id_1B8A() {
  if(!level._id_1B53) {
    level._id_1B53 = 64;
  }
  level._id_1B53 = level._id_1B53 * 2;

  if(level._id_1B53 > 256) {
    level._id_1B53 = 256;
  }
  _id_1B89();
}

_id_1B8B() {
  if(!level._id_1B53) {
    return;
  }
  level._id_1B53 = level._id_1B53 * 0.5;

  if(level._id_1B53 < 64) {
    level._id_1B53 = 0;
  }
  _id_1B89();
}

_id_1B8C() {
  if(level._id_1B53 == 256) {
    level._id_1B53 = 0;
  } else {
    level._id_1B53 = 256;
  }
  _id_1B89();
}

_id_1B8D(var_0) {
  _id_1B8E(var_0["entity"]);
}

_id_1B8E(var_0) {
  if(level._id_1B55 && isDefined(level._id_1B5C)) {
    return;
  }
  _id_1B8F(var_0);
  level._id_1B5B dontinterpolate();
  level._id_1B5B.origin = var_0.origin;
  level._id_1B5B.angles = var_0.angles;
  level._id_1B5B show();
  level._id_1B5C = var_0;
}

_id_1B8F(var_0) {
  if(!level._id_1B47.size || isDefined(var_0._id_1B7B) || !_id_1BAA(var_0)) {
    return;
  }
  var_1 = _id_1BA9();

  if(isDefined(var_1._id_1B90)) {
    var_1._id_1B90._id_1B7B = undefined;
  }
  var_1 thread _id_1BA8(var_0);
}

_id_1B91() {
  _id_1B8E(level._id_1B54);
}

_id_1B92() {
  if(level._id_1B55 && isDefined(level._id_1B5C)) {
    return;
  }
  level._id_1B5B hide();
  level._id_1B5C = undefined;
}

_id_1B93() {
  for(;;) {
    if(!isDefined(level._id_1B5C)) {
      wait 0.05;
      continue;
    }

    var_0 = level._id_1B5C.model;
    var_1 = anglestoright(level.player getplayerangles()) * var_0.size * -3;
    thread maps\_utility::_id_1B94(var_0, level._id_1B5C.origin + var_1, 0.05);
    wait 0.05;
  }
}

_id_1B95() {
  if(level._id_1B55) {
    level._id_1B60 _id_1B36("");
    level._id_1B55 = 0;
  } else {
    level._id_1B60 _id_1B36("^1Selection Lock On");
    level._id_1B55 = 1;
  }
}

_id_1B96() {
  _id_1B97();
  _id_1B6F(::_id_1B7D, 0, "w");
  _id_1B6F(::_id_1B79, 0, "BUTTON_LSHLDR");
  _id_1B6F(::_id_1B75, 0, "BUTTON_RSHLDR");
  _id_1B6F(::_id_1B77, 0, "BUTTON_RSTICK");
  _id_1B6F(::_id_1B39, 0, "BUTTON_X");
  _id_1B6F(::_id_1B38, 0, "BUTTON_Y");
  _id_1B6F(::_id_1B39, 0, "DPAD_UP");
  _id_1B6F(::_id_1B38, 0, "DPAD_DOWN");
  _id_1B6F(::_id_1B8C, 0, "BUTTON_A");
  _id_1B6F(::_id_1BAB, 0, "BUTTON_B");
}

_id_1B97() {
  level._id_1B6A = [];
  level._id_1B6E = [];
}

_id_1B98() {
  _id_1B97();
  _id_1B6F(::_id_1B7D, 0, "w");
  _id_1B6F(::_id_1BA3, 0, "BUTTON_LSHLDR");
  _id_1B6F(::_id_1BA4, 0, "BUTTON_RSHLDR");
  _id_1B6F(::_id_1B9C, 0, "BUTTON_LTRIG");
  _id_1B6F(::_id_1B9C, 0, "BUTTON_RTRIG");
  _id_1B6F(::_id_1B9C, 0, "BUTTON_RSTICK");
  _id_1B6F(::_id_1B9D, 0, "BUTTON_X");
  _id_1B6F(::_id_1B9E, 0, "BUTTON_Y");
  _id_1B6F(::_id_1BA2, 0, "DPAD_UP");
  _id_1B6F(::_id_1BA1, 0, "DPAD_DOWN");
  _id_1B6F(::_id_1BA0, 0, "DPAD_RGIHT");
  _id_1B6F(::_id_1B9F, 0, "BUTTON_A");
  _id_1B6F(::_id_1B9B, 0, "BUTTON_B");
}

_id_1B99() {
  _id_1B62("helpxy", "^4Cover Crouch Window ^7/ ^3Prone");
  _id_1B62("helpab", "^2Cover Stand ^7/ ^1Crouch");
  _id_1B62("helplsrs", "^8 - ^7/ Pathnode");
  _id_1B62("helplbrb", "^8Cover Left ^7/ Right");
  _id_1B62("helpdpl", "^8Conceal - ^7/ Crouch");
  _id_1B62("helpdpu", "^8Conceal Stand ^7/ Prone");
}

_id_1B9A() {
  _id_1B62("helpxy", "^4Node Type Up ^7/ ^3Down");
  _id_1B62("helpab", "^2Toggle Grid ^7/ ^1Anim Preview ");
  _id_1B62("helplsrs", "^8Quick Pick ^7/ Place at Player");
  _id_1B62("helplbrb", "^8Remove ^7/ Place");
  _id_1B62("helpdpl", "^8- ^7/ -");
  _id_1B62("helpdpu", "^8Node Type Up ^7/ Down");
  var_0 = "( dump ) ^3map_source / xenon_export/" + level.script + "_nodedump.map";
  _id_1B62("helpF", var_0);
}

_id_1B9B() {
  _id_1B3B("node_cover_crouch");
}

_id_1B9C() {
  _id_1B3B("node_pathnode");
}

_id_1B9D() {
  _id_1B3B("node_cover_crouch_window");
}

_id_1B9E() {
  _id_1B3B("node_cover_prone");
}

_id_1B9F() {
  _id_1B3B("node_cover_stand");
}

_id_1BA0() {
  _id_1B3B("node_concealment_crouch");
}

_id_1BA1() {
  _id_1B3B("node_concealment_prone");
}

_id_1BA2() {
  _id_1B3B("node_concealment_stand");
}

_id_1BA3() {
  _id_1B3B("node_cover_left");
}

_id_1BA4() {
  _id_1B3B("node_cover_right");
}

_id_1BA5() {
  _id_1B97();
  _id_1B98();
  _id_1B99();
}

_id_1BA6() {
  _id_1B96();
  _id_1B9A();
}

_id_1B34() {
  if(!isDefined(level._id_1BA7)) {
    level._id_1BA7 = [];
  }
  var_0 = newhudelem();
  level._id_1BA7[level._id_1BA7.size] = var_0;
  return var_0;
}

_id_1B36(var_0) {
  self._id_1B37 = var_0;

  foreach(var_2 in level._id_1BA7) {
    if(isDefined(var_2._id_1B37)) {
      var_2 settext(var_2._id_1B37);
    }
  }
}

_id_1BA8(var_0) {
  var_1 = var_0.origin + (0, 0, -32);
  var_2 = var_0.angles + level._id_1B43[var_0.model];
  var_0._id_1B7B = self;
  self._id_1B90 = var_0;
  level._id_1B4B[self._id_1B4A] notify("stop_loop");
  level._id_1B4B[self._id_1B4A].origin = var_1;
  level._id_1B4B[self._id_1B4A].angles = var_2;
  level._id_1B4B[self._id_1B4A] dontinterpolate();
  self dontinterpolate();
  self show();
  self._id_1B7C = 0;
  level._id_1B4B[self._id_1B4A] maps\_anim::_id_11C8(self, var_0.model);
}

_id_1BA9() {
  level._id_1B4C++;

  if(level._id_1B4C == level._id_1B46) {
    level._id_1B4C = 0;
  }
  var_0 = level._id_1B47[level._id_1B4C];
  return var_0;
}

_id_1BAA(var_0) {
  if(isDefined(level._id_0C59["generic"][var_0.model])) {
    return 1;
  }
  return 0;
}

_id_1BAB() {
  if(level._id_1B56) {
    level._id_1B61 _id_1B36("^1Anim Preview Off");
    level._id_1B56 = 0;
    _id_1BAC();
  } else {
    level._id_1B61 _id_1B36("");
    level._id_1B56 = 1;
    _id_1BAD();
  }
}

_id_1BAC() {
  foreach(var_1 in level._id_1B47) {
    if(!isDefined(var_1._id_1B7C) || !var_1._id_1B7C) {
      var_1 hide();
    }
  }
}

_id_1BAD() {
  foreach(var_1 in level._id_1B47) {
    if(!isDefined(var_1._id_1B7C) || !var_1._id_1B7C) {
      var_1 show();
    }
  }
}

_id_1BAE(var_0) {
  foreach(var_2 in level._id_1B7A) {
    if(!isDefined(var_2.classname)) {
      continue;
    }
  }
}

_id_1BAF() {
  level endon("dump_nodes");
  level._id_1B7A = [];
  var_0 = getallnodes();
  var_1 = 0;
  var_2 = 1000;
  var_3 = [];
  level._id_1BB0 = 0;
  wait 0.05;

  for(;;) {
    var_4 = var_0;

    foreach(var_6 in level._id_1B50) {}
    var_4[var_4.size] = var_6;

    var_8 = level._id_1B50.size;

    foreach(var_6 in var_4) {
      var_3[var_3.size] = var_6;
      var_1++;

      if(level._id_1B50.size != var_8) {
        var_3 = [];
        var_1 = 0;
        break;
      }

      if(var_1 > var_2) {
        var_10 = [];

        foreach(var_12 in level._id_1B7A) {
          if(distancesquared((level._id_1B5A.origin[0], level._id_1B5A.origin[1], 0), (var_12.origin[0], var_12.origin[1], 0)) <= 65536) {
            var_10[var_10.size] = var_12;
          }
        }

        var_14 = [];

        foreach(var_16 in var_3) {
          if(distancesquared((level._id_1B5A.origin[0], level._id_1B5A.origin[1], 0), (var_16.origin[0], var_16.origin[1], 0)) <= 65536) {
            var_14[var_14.size] = var_16;
          }
        }

        level._id_1B7A = maps\_utility::_id_1843(var_14, var_10);
        var_3 = [];
        var_1 = 0;
        wait 0.05;
        waittillframeend;
      }

      if(level._id_1B44) {
        level._id_1B44 = 0;
        var_3 = [];
        var_1 = 0;
        break;
      }
    }

    wait 0.05;
  }
}