/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_art.gsc
**************************************/

main() {
  if(!isDefined(level._id_3189)) {
    level._id_3189["nearStart"] = 0;
    level._id_3189["nearEnd"] = 0;
    level._id_3189["farStart"] = 0;
    level._id_3189["farEnd"] = 0;
    level._id_3189["nearBlur"] = 6;
    level._id_3189["farBlur"] = 1.8;
  }
}

_id_882C() {}

_id_5365() {}

_id_9FC8() {}

_id_9FC6() {}

_id_3E57() {}

_id_2597() {
  if(!isDefined(level._id_A565)) {
    level._id_A565 = [];
  }

  var_0 = getEntArray("trigger_multiple_light_visionset", "classname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.canmantle)) {
      _id_2598(var_2.canmantle);
    }

    if(isDefined(var_2.ismantling)) {
      _id_2598(var_2.ismantling);
    }

    if(isDefined(var_2.forcemantle)) {
      _id_2598(var_2.forcemantle);
    }
  }
}

_id_2598(var_0) {
  if(isDefined(level._id_A565[var_0])) {
    return;
  }
  _id_278D(var_0);
  _id_27C7(var_0);
  _iprintlnbold("new vision: " + var_0);
}

_id_27C7(var_0) {
  if(!isDefined(level._id_A56A)) {
    level._id_A56A = [];
  }

  var_1 = spawnStruct();
  var_1.name = var_0;
  level._id_A56A[var_0] = var_1;
  return var_1;
}

_id_0988() {}

_id_0987(var_0) {}

_id_278D(var_0) {
  var_1 = _id_27C6(var_0);
  var_1._id_92C6 = 3764.17;
  var_1._id_497B = 19391;
  var_1._id_7B4C = 0.661137;
  var_1._id_4848 = 0.554261;
  var_1._id_180C = 0.454014;
  var_1._id_608F = 0.7;
  var_1._id_9C83 = 0;
  var_1._id_8C98 = 0;
  var_1._id_8C9A = 0;
  var_1._id_8C99 = 0;
  var_1._id_4C37 = 0;
  var_1._id_4C36 = 0;
  var_1._id_4C38 = 1000;
}

_id_27C6(var_0) {
  if(!isDefined(level._id_A565)) {
    level._id_A565 = [];
  }

  var_1 = spawnStruct();
  var_1.name = var_0;
  var_1._id_8C98 = 0;
  var_1._id_8C9A = 0;
  var_1._id_8C99 = 0;
  var_1._id_4C37 = 0;
  var_1._id_4C36 = 0;
  var_1._id_4C38 = 1000;
  var_1._id_1105 = 0.0;
  var_1._id_110E = 0.0;
  var_1._id_110F = 0.0;
  var_1._id_1104 = 1.0;
  var_1._id_10FF = 0;
  var_1._id_1100 = 1.0;
  var_1._id_1101 = 0.0;
  var_1._id_111F = 0;
  var_1._id_1115 = 0.0;
  var_1._id_1116 = 0.0;
  var_1._id_1117 = 0.0;
  var_1._id_1120 = 0.0;
  var_1._id_111C = 0.0;
  var_1._id_111D = 0.0;
  var_1._id_111E = 0.0;
  var_1._id_1122 = 0.0;
  var_1._id_1125 = 0;
  var_1._id_1123 = (0, 0, 0);
  var_1._id_111B = 0;
  var_1._id_1124 = 0.0;
  var_1._id_1118 = 0.0;
  var_1._id_1119 = 0.0;
  var_1._id_111A = 0.0;
  var_1._id_1121 = 0.0;
  level._id_A565[_tolower(var_0)] = var_1;
  return var_1;
}

_id_849E(var_0, var_1) {
  level._id_A569._id_A563 = var_0;
  level._id_A569.time = var_1;
  var_2 = _id_419B(var_0);

  if(getdvarint("scr_art_tweak") != 0) {
    _id_9C8B(var_2);
    var_1 = 0;
  }

  common_scripts\utility::finishentitydamage(var_2, var_1);
}

_id_9C8B(var_0) {}

_id_4F63() {
  var_0 = 7;
  var_1 = [];
  var_2 = 15;
  var_3 = int(var_0 / 2);
  var_4 = 240 + var_3 * var_2;
  var_5 = 0.5 / var_3;
  var_6 = var_5;

  for(var_7 = 0; var_7 < var_0; var_7++) {
    var_1[var_7] = _id_0681();
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
    var_1[var_7] _id_06DC(".");

    if(var_7 == var_3) {
      var_5 = var_5 * -1;
    }

    var_6 = var_6 + var_5;
    var_4 = var_4 - var_2;
  }

  level._id_8F65 = var_1;
}

_id_0681() {
  if(!isDefined(level._id_8309)) {
    level._id_8309 = [];
  }

  var_0 = newhudelem();
  level._id_8309[level._id_8309.size] = var_0;
  return var_0;
}

_id_06DC(var_0) {
  self._id_7AC5 = var_0;
  self settext("_");
  thread _id_05E3();
  var_1 = 0;

  foreach(var_3 in level._id_8309) {
    if(isDefined(var_3._id_7AC5)) {
      var_1 = var_1 + var_3._id_7AC5.size;
      var_3 settext(var_3._id_7AC5);
    }
  }
}

_id_05E3() {
  if(getDvar("netconststrings_enabled") != "0") {
    return;
  }
  if(level._id_05E3) {
    return;
  }
  level._id_05E3 = 1;
  self clearalltextafterhudelem();
  waitframe();
  level._id_05E3 = 0;
}

_id_869A() {
  _id_7D2D();
  var_0 = undefined;
  var_1 = getarraykeys(level._id_A565);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == level._id_A569._id_A563) {
      var_0 = var_2 + 1;
      break;
    }
  }

  if(var_0 == var_1.size) {
    return;
  }
  _id_8659(var_1[var_0]);
}

_id_8699() {
  _id_7D2D();
  var_0 = undefined;
  var_1 = getarraykeys(level._id_A565);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == level._id_A569._id_A563) {
      var_0 = var_2 - 1;
      break;
    }
  }

  if(var_0 < 0) {
    return;
  }
  _id_8659(var_1[var_0]);
}

_id_7D2D() {}

_id_A567(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_3 visionsetnakedforplayer(var_0, var_1);
    _luinotifyevent(&"dev_vision_exec");
    waitframe();
  }

  _id_849E(var_0, var_1);
}

_id_8659(var_0) {
  var_1 = getarraykeys(level._id_A565);
  level._id_8F66 = var_0;
  var_2 = 0;
  var_3 = int(level._id_8F65.size / 2);

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(var_1[var_4] == var_0) {
      var_2 = var_4;
      break;
    }
  }

  level._id_8F65[var_3] _id_06DC(var_1[var_2]);

  for(var_4 = 1; var_4 < level._id_8F65.size - var_3; var_4++) {
    if(var_2 - var_4 < 0) {
      level._id_8F65[var_3 + var_4] _id_06DC(".");
      continue;
    }

    level._id_8F65[var_3 + var_4] _id_06DC(var_1[var_2 - var_4]);
  }

  for(var_4 = 1; var_4 < level._id_8F65.size - var_3; var_4++) {
    if(var_2 + var_4 > var_1.size - 1) {
      level._id_8F65[var_3 - var_4] _id_06DC(".");
      continue;
    }

    level._id_8F65[var_3 - var_4] _id_06DC(var_1[var_2 + var_4]);
  }

  _id_A567(var_1[var_2], 0);
}

_id_419B(var_0) {
  if(!isDefined(level._id_A565)) {
    level._id_A565 = [];
  }

  var_1 = level._id_A565[var_0];
  return var_1;
}

_id_51D3() {
  if(!isDefined(level._id_3DA9)) {
    level._id_3DA9 = spawnStruct();
    level._id_3DA9._id_3DAC = "";
    level._id_3DA9.time = 0;
  }
}

_id_7406() {
  var_0 = level._id_A569._id_A563;
  level._id_A569._id_A563 = "";
  level._id_A569.time = "";
  _id_51D3();
  level._id_3DA9._id_3DAC = "";
  level._id_3DA9.time = "";
  _id_8659(var_0);
}

_id_1DCA(var_0, var_1) {
  var_2 = level.player buttonPressed(var_0);

  if(!var_2) {
    var_2 = level.player buttonPressed(var_1);
  }

  if(!isDefined(level._id_1DDF[var_0])) {
    level._id_1DDF[var_0] = 0;
  }

  if(gettime() < level._id_1DDF[var_0]) {
    return 0;
  }

  level._id_1DDF[var_0] = gettime() + 400;
  return var_2;
}

_id_34DB() {}

_id_1002() {
  common_scripts\utility:: fileprint_launcher();
}

_id_0FD0() {
  return common_scripts\utility:: fileprint_launcher_end_file( "\\share\\raw\\vision\\" + level._id_015D + ".vision", 1 );
}

_id_1001() {
  common_scripts\utility:: fileprint_launcher();
}

_id_0FCF() {
  return common_scripts\utility:: fileprint_launcher_end_file( "\\share\\raw\\maps\\createart\\" + level._id_015D + "_art.gsc", 1 );
}

_id_0FD1() {
  common_scripts\utility:: fileprint_launcher_start_file( "" );
    common_scripts\utility:: fileprint_launcher_start_file( "\t
    common_scripts\utility:: fileprint_launcher_start_file( "" );
    common_scripts\utility:: fileprint_launcher_start_file( "\tsetDevDvar( \"scr_fog_disable\", \"" + getdvarint( "scr_fog_disable" ) + "\"" + " );" );
    common_scripts\utility:: fileprint_launcher_start_file( "" );
    common_scripts\utility:: fileprint_launcher_start_file( "\t/$" );
    common_scripts\utility:: fileprint_launcher_start_file( "\tlevel._art_fog_setup = maps\\createart\\" + level._id_015D + "_fog_hdr::main;" );
    common_scripts\utility:: fileprint_launcher_start_file( "\t$/" );
}

_id_0FCE() {}

_id_27A5(var_0) {
  if(!isDefined(level._id_5D21)) {
    level._id_5D21 = [];
  }

  var_1 = spawnStruct();
  var_1.name = var_0;
  level._id_5D21[var_0] = var_1;
  return var_1;
}

getvisionsetindexfromname(var_0) {
  if(!isDefined(level._id_A565)) {
    return;
  }
  var_1 = 0;

  foreach(var_4, var_3 in level._id_A565) {
    if(var_4 == var_0) {
      return var_1;
    }

    var_1++;
  }

  var_5 = "";

  foreach(var_4, var_3 in level._id_A565) {
    var_5 = var_5 + "'" + var_4 + "'";
  }
}