/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\316.gsc
**************************************/

main() {
  common_scripts\utility::flag_init("pullup_weapon");
  common_scripts\utility::flag_init("introscreen_complete");
  common_scripts\utility::flag_init("safe_for_objectives");
  common_scripts\utility::flag_init("introscreen_complete");
  maps\_utility::delaythread(10, common_scripts\utility::flag_set, "safe_for_objectives");
  level._id_1D94 = 16;
  precacheshader("black");
  precacheshader("white");

  if(getdvar("introscreen") == "") {
    setdvar("introscreen", "1");

  }
  if(isDefined(level._id_1D95)) {
    return;
  }
  _id_1DBA();

  switch (_id_1DB8()) {
    case "london":
      precachestring(&"LONDON_INTROSCREEN_LINE_1");
      precachestring(&"LONDON_INTROSCREEN_LINE_2");
      precachestring(&"LONDON_INTROSCREEN_LINE_3");
      precachestring(&"LONDON_INTROSCREEN_LINE_4");
      precachestring(&"LONDON_INTROSCREEN_LINE_5");
      _id_1D9D();
      break;
    case "castle":
      precachestring(&"CASTLE_INTROSCREEN_LINE_1");
      precachestring(&"CASTLE_INTROSCREEN_LINE_2");
      precachestring(&"CASTLE_INTROSCREEN_LINE_3");
      precachestring(&"CASTLE_INTROSCREEN_LINE_4");
      precachestring(&"CASTLE_INTROSCREEN_LINE_5");
      _id_1D9D();
      break;
    case "prague":
      precachestring(&"PRAGUE_INTROSCREEN_LINE_1");
      precachestring(&"PRAGUE_INTROSCREEN_LINE_2");
      precachestring(&"PRAGUE_INTROSCREEN_LINE_3");
      precachestring(&"PRAGUE_INTROSCREEN_LINE_4");
      precachestring(&"PRAGUE_INTROSCREEN_LINE_5");
      _id_1D9D();
      break;
    case "prague_escape":
      precachestring(&"PRAGUE_ESCAPE_INTROSCREEN_LINE_1");
      precachestring(&"PRAGUE_ESCAPE_INTROSCREEN_LINE_2");
      precachestring(&"PRAGUE_ESCAPE_INTROSCREEN_LINE_3");
      precachestring(&"PRAGUE_ESCAPE_INTROSCREEN_LINE_4");
      precachestring(&"PRAGUE_ESCAPE_INTROSCREEN_LINE_5");
      _id_1D9D();
      break;
    case "payback":
      precachestring(&"PAYBACK_INTROSCREEN_LINE_1");
      precachestring(&"PAYBACK_INTROSCREEN_LINE_2");
      precachestring(&"PAYBACK_INTROSCREEN_LINE_3");
      precachestring(&"PAYBACK_INTROSCREEN_LINE_4");
      precachestring(&"PAYBACK_INTROSCREEN_LINE_5");
      _id_1D9D();
      break;
    case "example":
      break;
    case "hamburg":
      precachestring(&"TANKCOMMANDER_INTROSCREEN_LINE_1");
      precachestring(&"TANKCOMMANDER_INTROSCREEN_LINE_2");
      precachestring(&"TANKCOMMANDER_INTROSCREEN_LINE_3");
      precachestring(&"TANKCOMMANDER_INTROSCREEN_LINE_4");
      _id_1D9D();
      break;
    case "rescue_2":
      precachestring(&"RESCUE_2_INTROSCREEN_LINE_1");
      precachestring(&"RESCUE_2_INTROSCREEN_LINE_2");
      precachestring(&"RESCUE_2_INTROSCREEN_LINE_3");
      precachestring(&"RESCUE_2_INTROSCREEN_LINE_4");
      _id_1D9D();
      break;
    default:
      wait 0.05;
      level notify("finished final intro screen fadein");
      wait 0.05;
      level notify("starting final intro screen fadeout");
      wait 0.05;
      level notify("controls_active");
      wait 0.05;
      common_scripts\utility::flag_set("introscreen_complete");
      break;
  }
}

_id_1D96(var_0) {
  var_1 = getarraykeys(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = 1;
    var_5 = var_2 * var_4 + 1;
    maps\_utility::delaythread(var_5, ::_id_1DA2, var_0[var_3], var_0.size - var_2 - 1, var_4, var_3);
  }
}

_id_1D97(var_0, var_1, var_2) {
  _id_1D99("black", var_0, var_1, var_2);
}

_id_1D98(var_0, var_1, var_2) {
  _id_1D99("white", var_0, var_1, var_2);
}

_id_1D99(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 1.5;

  }
  var_4 = newhudelem();
  var_4.x = 0;
  var_4.y = 0;
  var_4.horzalign = "fullscreen";
  var_4.vertalign = "fullscreen";
  var_4.foreground = 1;
  var_4 setshader(var_0, 640, 480);

  if(isDefined(var_3) && var_3 > 0) {
    var_4.alpha = 0;
    var_4 fadeovertime(var_3);
    var_4.alpha = 1;
    wait(var_3);
  }

  wait(var_1);

  if(var_2 > 0) {
    var_4 fadeovertime(var_2);

  }
  var_4.alpha = 0;
  wait(var_2);
  setsaveddvar("com_cinematicEndInWhite", 0);
}

_id_1D9A(var_0) {
  var_1 = level._id_1D9B.size;
  var_2 = var_1 * 30;

  if(level.console) {
    var_2 = var_2 - 60;

  }
  level._id_1D9B[var_1] = newhudelem();
  level._id_1D9B[var_1].x = 0;
  level._id_1D9B[var_1].y = var_2;
  level._id_1D9B[var_1].alignx = "center";
  level._id_1D9B[var_1].aligny = "middle";
  level._id_1D9B[var_1].horzalign = "center";
  level._id_1D9B[var_1].vertalign = "middle";
  level._id_1D9B[var_1].sort = 1;
  level._id_1D9B[var_1].foreground = 1;
  level._id_1D9B[var_1].fontscale = 1.75;
  level._id_1D9B[var_1] settext(var_0);
  level._id_1D9B[var_1].alpha = 0;
  level._id_1D9B[var_1] fadeovertime(1.2);
  level._id_1D9B[var_1].alpha = 1;
}

_id_1D9C() {
  for(var_0 = 0; var_0 < level._id_1D9B.size; var_0++) {
    level._id_1D9B[var_0] fadeovertime(1.5);
    level._id_1D9B[var_0].alpha = 0;
  }

  wait 1.5;

  for(var_0 = 0; var_0 < level._id_1D9B.size; var_0++) {
    level._id_1D9B[var_0] destroy();
  }
}

_id_1D9D(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  waittillframeend;
  waittillframeend;

  if(_id_1DAE()) {
    return;
  }
  if(_id_1DC0()) {
    return;
  }
  switch (_id_1DB8()) {
    case "london":
      _id_1DA5();
      return;
    case "castle":
      _id_1DA4();
      return;
    case "prague":
      _id_1DA7();
      return;
    case "prague_escape":
      _id_1DA8();
      return;
    case "payback":
      _id_1DA9();
      return;
    case "rescue_2":
      _id_1DBF();
      return;
    case "hamburg":
      _id_1DA6();
      return;
  }

  level._id_1D9E = newhudelem();
  level._id_1D9E.x = 0;
  level._id_1D9E.y = 0;
  level._id_1D9E.horzalign = "fullscreen";
  level._id_1D9E.vertalign = "fullscreen";
  level._id_1D9E.foreground = 1;
  level._id_1D9E setshader("black", 640, 480);
  level.player freezecontrols(1);
  wait 0.05;
  level._id_1D9B = [];

  if(isDefined(var_0)) {
    _id_1D9A(var_0);

  }
  if(isDefined(var_4)) {
    wait(var_4);
  } else {
    wait 2;

  }
  if(isDefined(var_1)) {
    _id_1D9A(var_1);

  }
  if(isDefined(var_2)) {
    _id_1D9A(var_2);

  }
  if(isDefined(var_3)) {
    if(isDefined(var_5)) {
      wait(var_5);
    } else {
      wait 2;
    }
  }

  if(isDefined(var_3)) {
    _id_1D9A(var_3);

  }
  level notify("finished final intro screen fadein");

  if(isDefined(var_6)) {
    wait(var_6);
  } else {
    wait 3;

  }
  level._id_1D9E fadeovertime(1.5);
  level._id_1D9E.alpha = 0;
  level notify("starting final intro screen fadeout");
  level.player freezecontrols(0);
  level notify("controls_active");
  _id_1D9C();
  common_scripts\utility::flag_set("introscreen_complete");
}

_id_1D9F(var_0, var_1, var_2, var_3) {
  level notify("new_introscreen_element");

  if(!isDefined(level._id_1DA0)) {
    level._id_1DA0 = 0;
  } else {
    level._id_1DA0++;

  }
  var_4 = _id_1DA1();
  var_5 = newhudelem();
  var_5.x = 20;
  var_5.y = var_4;
  var_5.alignx = "left";
  var_5.aligny = "bottom";
  var_5.horzalign = "left";
  var_5.vertalign = "bottom";
  var_5.sort = 1;
  var_5.foreground = 1;
  var_5 settext(var_0);
  var_5.alpha = 0;
  var_5 fadeovertime(0.2);
  var_5.alpha = 1;
  var_5.hidewheninmenu = 1;
  var_5.fontscale = 2.0;
  var_5.color = (0.8, 1, 0.8);
  var_5.font = "objective";
  var_5.glowcolor = (0.3, 0.6, 0.3);
  var_5.glowalpha = 1;
  var_6 = int(var_1 * var_2 * 1000 + 4000);
  var_5 setpulsefx(30, var_6, 700);
  thread _id_1DA3(var_5);

  if(!isDefined(var_3)) {
    return;
  }
  if(!isstring(var_3)) {
    return;
  }
  if(var_3 != "date") {
    return;
  }
}

_id_1DA1() {
  return level._id_1DA0 * 20 - 82;
}

_id_1DA2(var_0, var_1, var_2, var_3) {
  thread _id_1D9F(var_0, var_1, var_2, var_3);
}

_id_1DA3(var_0) {
  wait(level._id_1D94);
  var_0 notify("destroying");
  level._id_1DA0 = undefined;
  var_1 = 0.5;
  var_0 fadeovertime(var_1);
  var_0.alpha = 0;
  wait(var_1);
  var_0 notify("destroy");
  var_0 destroy();
}

_id_1DA4() {
  level.player freezecontrols(1);
  savegame("levelstart", &"AUTOSAVE_LEVELSTART", "whatever", 1);
  thread _id_1D97(5.0);
  var_0 = [];
  var_0[var_0.size] = &"CASTLE_INTROSCREEN_LINE_1";
  var_0[var_0.size] = &"CASTLE_INTROSCREEN_LINE_2";
  var_0[var_0.size] = &"CASTLE_INTROSCREEN_LINE_3";
  var_0[var_0.size] = &"CASTLE_INTROSCREEN_LINE_4";
  var_0[var_0.size] = &"CASTLE_INTROSCREEN_LINE_5";
  _id_1D96(var_0);
  wait 5.0;
  common_scripts\utility::flag_set("introscreen_complete");
  level.player freezecontrols(0);
}

_id_1DA5() {
  level.player freezecontrols(1);
  savegame("levelstart", &"AUTOSAVE_LEVELSTART", "whatever", 1);
  thread _id_1D97(5.0);
  var_0 = [];
  var_0[var_0.size] = &"LONDON_INTROSCREEN_LINE_1";
  var_0[var_0.size] = &"LONDON_INTROSCREEN_LINE_2";
  var_0[var_0.size] = &"LONDON_INTROSCREEN_LINE_3";
  var_0[var_0.size] = &"LONDON_INTROSCREEN_LINE_4";
  var_0[var_0.size] = &"LONDON_INTROSCREEN_LINE_5";
  _id_1D96(var_0);
  wait 5.0;
  common_scripts\utility::flag_set("introscreen_complete");
  level.player freezecontrols(0);
}

_id_1DA6() {
  savegame("levelstart", &"AUTOSAVE_LEVELSTART", "whatever", 1);
  thread _id_1D97(3.5);
  var_0 = [];
  var_0[var_0.size] = &"TANKCOMMANDER_INTROSCREEN_LINE_1";
  var_0[var_0.size] = &"TANKCOMMANDER_INTROSCREEN_LINE_15";
  var_0[var_0.size] = &"TANKCOMMANDER_INTROSCREEN_LINE_2";
  var_0[var_0.size] = &"TANKCOMMANDER_INTROSCREEN_LINE_3";
  var_0[var_0.size] = &"TANKCOMMANDER_INTROSCREEN_LINE_4";
  _id_1D96(var_0);
  wait 3.0;
  common_scripts\utility::flag_set("introscreen_complete");
}

_id_1DA7() {
  level.player freezecontrols(1);
  common_scripts\utility::flag_wait("fade_up");
  thread _id_1D97(4, 5);
  var_0 = [];
  var_0[var_0.size] = &"PRAGUE_INTROSCREEN_LINE_1";
  var_0[var_0.size] = &"PRAGUE_INTROSCREEN_LINE_2";
  var_0[var_0.size] = &"PRAGUE_INTROSCREEN_LINE_3";
  var_0[var_0.size] = &"PRAGUE_INTROSCREEN_LINE_4";
  var_0[var_0.size] = &"PRAGUE_INTROSCREEN_LINE_5";
  level.player common_scripts\utility::delaycall(4.0, ::freezecontrols, 0);
  common_scripts\utility::flag_wait("city_reveal");
  maps\_utility::delaythread(9.25, ::_id_1D96, var_0);
}

_id_1DA8() {
  level.player freezecontrols(1);
  thread _id_1D97(8.0, 0.5);
  var_0 = [];
  var_0[var_0.size] = &"PRAGUE_ESCAPE_INTROSCREEN_LINE_1";
  var_0[var_0.size] = &"PRAGUE_ESCAPE_INTROSCREEN_LINE_2";
  var_0[var_0.size] = &"PRAGUE_ESCAPE_INTROSCREEN_LINE_3";
  var_0[var_0.size] = &"PRAGUE_ESCAPE_INTROSCREEN_LINE_4";
  var_0[var_0.size] = &"PRAGUE_ESCAPE_INTROSCREEN_LINE_5";
  _id_1D96(var_0);
  wait 8;
  common_scripts\utility::flag_set("introscreen_complete");
  level.player freezecontrols(0);
}

_id_1DA9() {
  level.player freezecontrols(1);
  savegame("levelstart", &"AUTOSAVE_LEVELSTART", "whatever", 1);
  level notify("introscreen_prime_audio");
  level notify("introscreen_fade_start");
  wait 2.0;
  level.player freezecontrols(0);
  var_0 = 9;
  var_1 = 30;
  var_2 = 10;
  level._id_1DAB = var_0 * 60 * 60 + var_1 * 60 + var_2;
  level._id_1DAC = gettime();
  var_3 = [];
  var_3[var_3.size] = &"PAYBACK_INTROSCREEN_LINE_1";
  var_3[var_3.size] = &"PAYBACK_INTROSCREEN_LINE_2";
  var_3[var_3.size] = &"PAYBACK_INTROSCREEN_LINE_3";
  var_3[var_3.size] = &"PAYBACK_INTROSCREEN_LINE_4";
  var_3[var_3.size] = &"PAYBACK_INTROSCREEN_LINE_5";
  _id_1D96(var_3);
  wait 2.0;
}

_id_1DAD() {
  wait 2;
}

_id_1DAE() {
  var_0 = [];
  var_0["killhouse"] = 1;
  var_0["cliffhanger"] = 1;
  var_0["estate"] = 1;
  var_0["boneyard"] = 1;

  if(!getdvarint("newintro")) {
    var_0["roadkill"] = 1;

  }
  var_1 = isDefined(level._id_1DAF);

  if(!isDefined(var_0[_id_1DB8()])) {
    return 0;

  }
  if(!isDefined(level._id_1DB0)) {
    thread _id_1DB5();

  }
  thread _id_1DB3();
  thread _id_1DB4();
  level.player freezecontrols(1);
  var_2 = ::_id_1DAD;
  var_3 = 16000;
  var_4 = 1;
  var_5 = 0;
  var_6 = 0;

  if(var_4) {
    var_7 = [];

    switch (_id_1DB8()) {
      case "london":
        cinematicingamesync("estate_fade");
        var_7 = [];
        var_7[var_7.size] = &"LONDON_INTROSCREEN_LINE_1";
        var_7[var_7.size] = &"LONDON_INTROSCREEN_LINE_2";
        var_7[var_7.size] = &"LONDON_INTROSCREEN_LINE_3";
        var_7[var_7.size] = &"LONDON_INTROSCREEN_LINE_4";
        var_3 = 4000;
        setsaveddvar("sm_sunSampleSizeNear", 0.6);
        maps\_utility::delaythread(0.5, ::_id_1DB7, 0.9);
        break;
    }

    maps\_utility::_id_1DB1(var_2);
    maps\_utility::_id_1DB1(::_id_1D96, var_7);
    thread maps\_utility::_id_1DB2();
  }

  var_8 = level.player.origin;
  level.player playersetstreamorigin(var_8);
  level.player.origin = var_8 + (0, 0, var_3);
  var_9 = spawn("script_model", (69, 69, 69));
  var_9.origin = level.player.origin;
  var_9 setModel("tag_origin");

  if(var_1) {
    var_9.angles = (0, level._id_1DAF[1], 0);
  } else {
    var_9.angles = level.player.angles;

  }
  level.player playerlinkto(var_9, undefined, 1, 0, 0, 0, 0);
  var_9.angles = (var_9.angles[0] + 89, var_9.angles[1], 0);
  wait(var_5);
  var_9 moveto(var_8 + (0, 0, 0), 2, 0, 2);
  wait 1.0;
  wait 0.5;

  if(var_1) {
    var_9 rotateto(level._id_1DAF, 0.5, 0.3, 0.2);
  } else {
    var_9 rotateto((var_9.angles[0] - 89, var_9.angles[1], 0), 0.5, 0.3, 0.2);

  }
  if(!var_6) {
    savegame("levelstart", &"AUTOSAVE_LEVELSTART", "whatever", 1);

  }
  wait 0.5;
  common_scripts\utility::flag_set("pullup_weapon");
  wait 0.2;
  level.player unlink();
  level.player freezecontrols(0);
  level.player playerclearstreamorigin();
  thread common_scripts\utility::play_sound_in_space("ui_screen_trans_in", level.player.origin);
  wait 0.2;
  thread common_scripts\utility::play_sound_in_space("ui_screen_trans_out", level.player.origin);
  wait 0.2;
  common_scripts\utility::flag_set("introscreen_complete");
  wait 2;
  var_9 delete();
  return 1;
}

_id_1DB3() {
  wait 0.05;
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", "1");
  setsaveddvar("hud_showstance", "0");
  setsaveddvar("actionSlotsHide", "1");
}

_id_1DB4() {
  var_0 = level.player getweaponslistall()[0];
  level.player disableweapons();
  common_scripts\utility::flag_wait("pullup_weapon");
  level.player enableweapons();
}

_id_1DB5() {
  common_scripts\utility::flag_wait("safe_for_objectives");

  if(!isDefined(level._id_1DB6)) {
    setsaveddvar("compass", 1);

  }
  setsaveddvar("ammoCounterHide", "0");
  setsaveddvar("actionSlotsHide", "0");
  setsaveddvar("hud_showstance", "1");
}

_id_1DB7(var_0, var_1) {
  var_2 = getdvarfloat("sm_sunSampleSizeNear");

  if(!isDefined(var_1)) {
    var_1 = 0.25;

  }
  var_3 = var_2 - var_1;
  var_4 = var_0 * 20;

  for(var_5 = 0; var_5 <= var_4; var_5++) {
    var_6 = var_5 / var_4;
    var_6 = 1 - var_6;
    var_7 = var_6 * var_3;
    var_8 = var_1 + var_7;
    setsaveddvar("sm_sunSampleSizeNear", var_8);
    wait 0.05;
  }
}

_id_1DB8() {
  if(isDefined(level._id_1DB9)) {
    return level._id_1DB9;

  }
  return level.script;
}

_id_1DBA() {
  switch (_id_1DB8()) {
    case "dcburning":
      precachestring(&"DCBURNING_INTROSCREEN_1");
      precachestring(&"DCBURNING_INTROSCREEN_2");
      precachestring(&"DCBURNING_INTROSCREEN_3");
      precachestring(&"DCBURNING_INTROSCREEN_4");
      precachestring(&"DCBURNING_INTROSCREEN_5");
      _id_1D9D();
      break;
  }
}

_id_1DBB() {
  wait 17;
  var_0 = [];
  var_0[var_0.size] = &"CLIFFHANGER_LINE1";
  var_0["date"] = &"CLIFFHANGER_LINE2";
  var_0[var_0.size] = &"CLIFFHANGER_LINE3";
  var_0[var_0.size] = &"CLIFFHANGER_LINE4";
  var_0[var_0.size] = &"CLIFFHANGER_LINE5";
  _id_1D96(var_0);
}

_id_1DBC() {
  level.player disableweapons();
  thread _id_1DBE();
  level._id_1DBD = 1;
  level.player freezecontrols(1);
  var_0 = newhudelem();
  var_0.x = 0;
  var_0.y = 0;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.foreground = 1;
  var_0 setshader("black", 640, 480);
  wait 4.25;
  wait 3;
  level notify("black_fading");
  level._id_1DBD = undefined;
  var_0 fadeovertime(1.5);
  var_0.alpha = 0;
  wait 1.5;
  common_scripts\utility::flag_set("introscreen_complete");
  level notify("introscreen_complete");
  level.player freezecontrols(0);
  level.player enableweapons();
  wait 0.5;
  setsaveddvar("compass", 1);
  setsaveddvar("ammoCounterHide", "0");
  setsaveddvar("hud_showStance", 1);
  common_scripts\utility::flag_wait("player_exiting_start_trench");
  var_1 = [];
  var_1[var_1.size] = &"DCBURNING_INTROSCREEN_1";
  var_1[var_1.size] = &"DCBURNING_INTROSCREEN_2";
  var_1[var_1.size] = &"DCBURNING_INTROSCREEN_3";
  var_1[var_1.size] = &"DCBURNING_INTROSCREEN_4";
  var_1[var_1.size] = &"DCBURNING_INTROSCREEN_5";
  _id_1D96(var_1);
}

_id_1DBE() {
  wait 0.05;
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", "1");
  setsaveddvar("hud_showStance", 0);
}

_id_1DBF() {
  var_0 = [];
  thread _id_1D97(5.4, 8);
  var_0[var_0.size] = &"RESCUE_2_INTROSCREEN_LINE_1";
  var_0[var_0.size] = &"RESCUE_2_INTROSCREEN_LINE_2";
  var_0[var_0.size] = &"RESCUE_2_INTROSCREEN_LINE_3";
  var_0[var_0.size] = &"RESCUE_2_INTROSCREEN_LINE_4";
  var_0[var_0.size] = &"RESCUE_2_INTROSCREEN_LINE_5";
  _id_1D96(var_0);
}

_id_1DC0() {
  switch (_id_1DB8()) {
    case "dcburning":
      _id_1DBC();
      return 1;
  }

  return 0;
}