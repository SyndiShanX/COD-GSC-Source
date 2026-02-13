/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1743.gsc
*************************************************/

_id_7FF2() {
  level._id_0BA7._id_AC58 = [];
  _id_1107("string", "fxid", "FX id", "nil", "fx");
  _id_1107("float", "delay", "Repeat rate/start delay", 0.5, "fx");
  _id_1107("string", "flag", "Flag", "nil", "exploder");

  if(!level._id_A294) {
    _id_1107("string", "firefx", "2nd FX id", "nil", "exploder");
    _id_1107("float", "firefxdelay", "2nd FX id repeat rate", 0.5, "exploder");
    _id_1107("float", "firefxtimeout", "2nd FX timeout", 5, "exploder");
    _id_1107("string", "firefxsound", "2nd FX soundalias", "nil", "exploder");
    _id_1107("float", "damage", "Radius damage", 150, "exploder");
    _id_1107("float", "damage_radius", "Radius of radius damage", 250, "exploder");
    _id_1107("bool", "envonly", "Environment Pulse Only", 0, "exploder");
    _id_1107("bool", "dotraces", "Occlusion Trace", 1, "exploder");
    _id_1107("string", "earthquake", "Earthquake", "nil", "exploder");
    _id_1107("string", "ender", "Level notify for ending 2nd FX", "nil", "exploder");
  }

  _id_1107("float", "delay_min", "Minimimum time between repeats", 1, "soundfx_interval");
  _id_1107("float", "delay_max", "Maximum time between repeats", 2, "soundfx_interval");
  _id_1107("int", "repeat", "Number of times to repeat", 5, "exploder");
  _id_1107("string", "exploder", "Exploder", "1", "exploder");
  _id_1107("string", "soundalias", "Soundalias", "nil", "all");
  _id_1107("string", "loopsound", "Loopsound", "nil", "exploder");
  _id_1107("int", "reactive_radius", "Reactive Radius", 100, "reactive_fx", ::_id_82DC);

  if(!level._id_A294) {
    _id_1107("string", "rumble", "Rumble", "nil", "exploder");
    _id_1107("int", "stopable", "Can be stopped from script", "1", "all");
  }

  level._id_5107 = 0;
  level._id_5108 = 10;

  if(level._id_A294) {
    level._id_5108 = 6;
  }

  level._id_3FE6 = [];
  level._id_3FE6["all"] = [];
  level._id_3FE6["all"]["exploder"] = 1;
  level._id_3FE6["all"]["oneshotfx"] = 1;
  level._id_3FE6["all"]["loopfx"] = 1;
  level._id_3FE6["all"]["soundfx"] = 1;
  level._id_3FE6["all"]["soundfx_interval"] = 1;
  level._id_3FE6["all"]["reactive_fx"] = 1;
  level._id_3FE6["fx"] = [];
  level._id_3FE6["fx"]["exploder"] = 1;
  level._id_3FE6["fx"]["oneshotfx"] = 1;
  level._id_3FE6["fx"]["loopfx"] = 1;

  if(!level._id_A294) {
    level._id_3FE6["fx"]["reactive_fx"] = 1;
  }

  level._id_3FE6["exploder"] = [];
  level._id_3FE6["exploder"]["exploder"] = 1;
  level._id_3FE6["loopfx"] = [];
  level._id_3FE6["loopfx"]["loopfx"] = 1;
  level._id_3FE6["oneshotfx"] = [];
  level._id_3FE6["oneshotfx"]["oneshotfx"] = 1;
  level._id_3FE6["soundfx"] = [];
  level._id_3FE6["soundfx"]["soundalias"] = 1;
  level._id_3FE6["soundfx_interval"] = [];
  level._id_3FE6["soundfx_interval"]["soundfx_interval"] = 1;
  level._id_3FE6["reactive_fx"] = [];
  level._id_3FE6["reactive_fx"]["reactive_fx"] = 1;
  var_0 = [];
  var_0["creation"] = ::_id_9DBB;
  var_0["create_oneshot"] = ::_id_9DBA;
  var_0["create_loopfx"] = ::_id_9DBA;
  var_0["change_fxid"] = ::_id_9DBA;
  var_0["none"] = ::_id_9DCC;
  var_0["add_options"] = ::_id_9DB7;
  var_0["select_by_name"] = ::_id_9DCD;
  level._id_0BA7._id_9DD6 = var_0;
}

_id_9DB6(var_0) {
  return level._id_3F1C == var_0;
}

_id_D5F8(var_0) {
  level._id_3F1C = var_0;
}

_id_3F1C() {
  if(_id_06CE::_id_2DC9("escape", "x")) {
    _id_5753();
    return;
  }

  if(isDefined(level._id_0BA7._id_9DD6[level._id_3F1C])) {
    [[level._id_0BA7._id_9DD6[level._id_3F1C]]]();
  }
}

_id_9DBB() {
  if(!isDefined(level._id_0BA7._id_9DBB)) {
    level._id_0BA7._id_9DBB = [];
    var_0 = [];
    var_0["1"] = ::_id_2DD9;

    if(!level._id_A294) {
      var_0["2"] = ::_id_2DD7;
      var_0["3"] = ::_id_2DD8;
      var_0["4"] = ::_id_2DD5;
      var_0["5"] = ::_id_2DD6;
      var_0["6"] = ::_id_2DDA;
    } else {
      var_0["2"] = ::_id_2DD8;
      var_0["3"] = ::_id_2DD5;
      var_0["4"] = ::_id_2DD6;
      var_0["5"] = ::_id_2DDA;
    }

    level._id_0BA7._id_9DBB = var_0;
  }

  foreach(var_3, var_2 in level._id_0BA7._id_9DBB) {
    if(_id_06CE::_id_2DC9(var_3)) {
      [[var_2]]();
      return;
    }
  }
}

_id_2DD9() {
  _id_D5F8("create_oneshot");
  _id_4F0A();
}

_id_2DD7() {
  _id_D5F8("create_loopfx");
  _id_4F0A();
}

_id_2DD8() {
  _id_D5F8("create_loopsound");
  var_0 = _id_06CE::_id_400F();
  _id_5B0E(var_0);
}

_id_2DD5() {
  _id_D5F8("create_exploder");
  var_0 = _id_06CE::_id_401C();
  _id_5B0E(var_0);
}

_id_2DD6() {
  _id_D5F8("create_interval_sound");
  var_0 = _id_06CE::_id_3FFE();
  _id_5B0E(var_0);
}

_id_2DDA() {
  var_0 = _id_06CE::_id_403B();
  _id_5B0E(var_0);
}

_id_9DBA() {
  if(_id_A466()) {
    _id_7DD8();
    _id_4F0A();
  } else if(_id_BC2B()) {
    _id_4550();
    _id_4F0A();
  }

  _id_9DC1();
}

_id_9DCC() {
  if(_id_06CE::_id_2DC9("m")) {
    _id_7DD8();
  }

  _id_9DB9();

  if(_id_54F0()) {
    var_0 = _id_6540();

    if(!isDefined(level._id_8F18) || var_0 != level._id_8F18) {
      _id_4B5C(var_0);
      level._id_8F18 = var_0;
    }

    if(_id_06CE::_id_2DC9("a")) {
      _id_06CE::_id_3904();
      _id_D5F8("add_options");
      return;
    }
  } else
    level._id_8F18 = undefined;
}

_id_9DB7() {
  if(!_id_54F0()) {
    _id_06CE::_id_38D5();
    _id_D5F8("none");
    return;
  }

  _id_4B5B(_id_6540());

  if(_id_A466()) {
    _id_7DD8();
  }
}

_id_9DCD() {
  if(_id_A466()) {
    _id_7DD8();
    _id_4F0A("Select by name");
  } else if(_id_BC2B()) {
    _id_4550();
    _id_4F0A("Select by name");
  }

  _id_D035();
}

_id_A466() {
  return _id_06CE::_id_2DC9("rightarrow");
}

_id_BC2B() {
  return _id_06CE::_id_2DC9("leftarrow");
}

_id_5753() {
  _id_06CE::_id_38D5();
  _id_06CE::_id_38CE();
  _id_06CE::_id_FBC5();
  _id_D5F8("none");
}

_id_9DC1() {
  var_0 = 0;
  var_1 = undefined;
  var_2 = _id_06CE::_id_601D();

  for(var_3 = level._id_5107; var_3 < var_2.size; var_3++) {
    var_0 = var_0 + 1;
    var_4 = var_0;

    if(var_4 == 10) {
      var_4 = 0;
    }

    if(_id_06CE::_id_2DC9(var_4 + "")) {
      var_1 = var_2[var_3];
      break;
    }

    if(var_0 > level._id_5108) {
      break;
    }
  }

  if(!isDefined(var_1)) {
    return;
  }
  if(_id_9DB6("change_fxid")) {
    _id_19C1(_id_661C("fxid"), var_1);
    level._id_5107 = 0;
    _id_06CE::_id_38D5();
    _id_D5F8("none");
    return;
  }

  var_5 = undefined;

  if(_id_9DB6("create_loopfx")) {
    var_5 = scripts\engine\utility::_id_400E(var_1);
  }

  if(_id_9DB6("create_oneshot")) {
    var_5 = scripts\engine\utility::_id_4027(var_1);
  }

  _id_5B0E(var_5);
}

_id_5B0E(var_0) {
  var_0.v["angles"] = vectortoangles(var_0.v["origin"] + (0, 0, 100) - var_0.v["origin"]);

  if(isDefined(level._effect) && isDefined(level._effect[var_0.v["fxid"]]) && _func_02DD(level._effect[var_0.v["fxid"]])) {
    var_0.v["angles"] = (0, 0, 0);
  }

  var_0 _id_06CE::_id_BA24();
  _id_06CE::_id_38CE();
  _id_06CE::_id_D042();
  _id_06CE::_id_A1F9();
  _id_06CE::_id_FBC5();
  _id_D5F8("none");
}

_id_54F0() {
  return level._id_0BA7._id_D057.size > 0;
}

_id_9DB9() {
  if(!level._id_0BA7._id_D057.size) {
    return;
  }
  var_0 = 0;
  var_1 = 0;
  var_2 = _id_6540();

  for(var_3 = 0; var_3 < level._id_0BA7._id_AC58.size; var_3++) {
    var_4 = level._id_0BA7._id_AC58[var_3];

    if(!isDefined(var_2.v[var_4["name"]])) {
      continue;
    }
    var_0++;

    if(var_0 < level._id_5107) {
      continue;
    }
    var_1++;
    var_5 = var_1;

    if(var_5 == 10) {
      var_5 = 0;
    }

    if(_id_06CE::_id_2DC9(var_5 + "")) {
      _id_BBBB(var_4, var_1);
      break;
    }

    if(var_1 > level._id_5108) {
      var_6 = 1;
      break;
    }
  }
}

_id_BBBB(var_0, var_1) {
  if(var_0["name"] == "fxid") {
    _id_D5F8("change_fxid");
    _id_4F0A();
    return;
  }

  level._id_3FDC = 1;
  level._id_0BA7._id_7B64[var_1 + 3][0].color = (1, 1, 0);

  if(isDefined(var_0["input_func"])) {
    thread[[var_0["input_func"]]](var_1 + 3);
  } else {
    _id_06CE::_id_3FD4("To change " + var_0["description"] + " on selected entities, type /fx newvalue");
  }

  _id_D2B1(var_0["name"]);
  setDvar("#x3f0af9f31c57ac67a", "nil");
}

_id_9DC2() {
  if(getDvar("#x3f0af9f31c57ac67a") == "nil") {
    return;
  }
  var_0 = _id_674D();
  var_1 = undefined;

  if(var_0["type"] == "string") {
    var_1 = getDvar("#x3f0af9f31c57ac67a");
  }

  if(var_0["type"] == "int") {
    var_1 = getdvarint("#x3f0af9f31c57ac67a");
  }

  if(var_0["type"] == "float") {
    var_1 = getdvarfloat("#x3f0af9f31c57ac67a");
  }

  if(var_0["type"] == "bool") {
    var_1 = getDvar("#x3f0af9f31c57ac67a");

    if(var_1 == "0" || var_1 == "false") {
      var_1 = 0;
    } else {
      var_1 = 1;
    }
  }

  _id_19C1(var_0, var_1);
}

_id_19C1(var_0, var_1) {
  for(var_2 = 0; var_2 < level._id_0BA7._id_D057.size; var_2++) {
    var_3 = level._id_0BA7._id_D057[var_2];

    if(_id_9B90(var_0["mask"], var_3.v["type"])) {
      var_3.v[var_0["name"]] = var_1;
    }
  }

  level._id_8F18 = undefined;
  _id_06CE::_id_FBC5();
  _id_06CE::_id_3904();
}

_id_D2B1(var_0) {
  for(var_1 = 0; var_1 < level._id_0BA7._id_AC58.size; var_1++) {
    if(level._id_0BA7._id_AC58[var_1]["name"] != var_0) {
      continue;
    }
    level._id_0BA7._id_D058 = var_1;
    return;
  }
}

_id_674D() {
  return level._id_0BA7._id_AC58[level._id_0BA7._id_D058];
}

_id_9B90(var_0, var_1) {
  return isDefined(level._id_3FE6[var_0][var_1]);
}

_id_1107(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];
  var_6["type"] = var_0;
  var_6["name"] = var_1;
  var_6["description"] = var_2;
  var_6["default"] = var_3;
  var_6["mask"] = var_4;

  if(isDefined(var_5)) {
    var_6["input_func"] = var_5;
  }

  level._id_0BA7._id_AC58[level._id_0BA7._id_AC58.size] = var_6;
}

_id_661C(var_0) {
  for(var_1 = 0; var_1 < level._id_0BA7._id_AC58.size; var_1++) {
    if(level._id_0BA7._id_AC58[var_1]["name"] == var_0) {
      return level._id_0BA7._id_AC58[var_1];
    }
  }
}

_id_82DC(var_0) {
  for(;;) {
    waitframe();

    if(level.player _meth_805E("escape") || level.player _meth_805E("x")) {
      break;
    }

    var_1 = 0;

    if(level.player _meth_805E("-")) {
      var_1 = -10;
    } else if(level.player _meth_805E("=")) {
      var_1 = 10;
    }

    if(var_1 != 0) {
      foreach(var_3 in level._id_0BA7._id_D057) {
        if(isDefined(var_3.v["reactive_radius"])) {
          var_3.v["reactive_radius"] = var_3.v["reactive_radius"] + var_1;
          var_3.v["reactive_radius"] = clamp(var_3.v["reactive_radius"], 10, 1000);
        }
      }
    }
  }

  level._id_8F18 = undefined;
  _id_06CE::_id_FBC5();
  _id_06CE::_id_3904();
}

_id_4B5B(var_0) {
  _id_06CE::_id_38D5();
  _id_06CE::_id_D21D("Name: " + var_0.v["fxid"]);
  _id_06CE::_id_D21D("Type: " + var_0.v["type"]);
  _id_06CE::_id_D21D("Origin: " + var_0.v["origin"]);
  _id_06CE::_id_D21D("Angles: " + var_0.v["angles"]);
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;

  if(level._id_5107 >= level._id_0BA7._id_AC58.size) {
    level._id_5107 = 0;
  }

  for(var_4 = 0; var_4 < level._id_0BA7._id_AC58.size; var_4++) {
    var_5 = level._id_0BA7._id_AC58[var_4];

    if(isDefined(var_0.v[var_5["name"]])) {
      continue;
    }
    if(!_id_9B90(var_5["mask"], var_0.v["type"])) {
      continue;
    }
    var_1++;

    if(var_1 < level._id_5107) {
      continue;
    }
    if(var_2 >= level._id_5108) {
      continue;
    }
    var_2++;
    var_6 = var_2;

    if(var_6 == 10) {
      var_6 = 0;
    }

    if(_id_06CE::_id_2DC9(var_6 + "")) {
      _id_1000(var_5);
      _id_9DD1();
      level._id_8F18 = undefined;
      return;
    }

    _id_06CE::_id_D21D(var_6 + ". " + var_5["description"]);
  }

  if(var_1 > level._id_5108) {
    _id_06CE::_id_D21D("(->) More >");
  }

  _id_06CE::_id_D21D("(x) Exit >");
}

_id_1000(var_0) {
  var_1 = undefined;

  for(var_2 = 0; var_2 < level._id_0BA7._id_D057.size; var_2++) {
    var_3 = level._id_0BA7._id_D057[var_2];

    if(_id_9B90(var_0["mask"], var_3.v["type"])) {
      var_3.v[var_0["name"]] = var_0["default"];
    }
  }
}

_id_9DD1() {
  level._id_5107 = 0;
  _id_06CE::_id_38D5();
  _id_D5F8("none");
}

_id_4B5C(var_0) {
  if(!_id_9DB6("none")) {
    return;
  }
  _id_06CE::_id_38D5();
  _id_06CE::_id_D21D("Name: " + var_0.v["fxid"]);
  _id_06CE::_id_D21D("Type: " + var_0.v["type"]);
  _id_06CE::_id_D21D("Origin: " + var_0.v["origin"]);
  _id_06CE::_id_D21D("Angles: " + var_0.v["angles"]);

  if(_id_54F0()) {
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;

    for(var_4 = 0; var_4 < level._id_0BA7._id_AC58.size; var_4++) {
      var_5 = level._id_0BA7._id_AC58[var_4];

      if(!isDefined(var_0.v[var_5["name"]])) {
        continue;
      }
      var_1++;

      if(var_1 < level._id_5107) {
        continue;
      }
      var_2++;
      _id_06CE::_id_D21D(var_2 + ". " + var_5["description"] + ": " + var_0.v[var_5["name"]]);

      if(var_2 > level._id_5108) {
        var_3 = 1;
        break;
      }
    }

    if(var_1 > level._id_5108) {
      _id_06CE::_id_D21D("(->) More >");
    }

    _id_06CE::_id_D21D("(a) Add >");
    _id_06CE::_id_D21D("(x) Exit >");
  } else {
    var_1 = 0;
    var_3 = 0;

    for(var_4 = 0; var_4 < level._id_0BA7._id_AC58.size; var_4++) {
      var_5 = level._id_0BA7._id_AC58[var_4];

      if(!isDefined(var_0.v[var_5["name"]])) {
        continue;
      }
      var_1++;
      _id_06CE::_id_D21D(var_5["description"] + ": " + var_0.v[var_5["name"]]);

      if(var_1 > level._id_0BA7._id_7B62) {
        break;
      }
    }
  }
}

_id_4F0A(var_0) {
  _id_06CE::_id_38D5();
  var_1 = 0;
  var_2 = 0;
  var_3 = _id_06CE::_id_601D();

  if(!isDefined(var_0)) {
    var_0 = "Pick an effect";
  }

  _id_06CE::_id_D21D(var_0 + " [" + level._id_5107 + " - " + var_3.size + "]:");

  for(var_4 = level._id_5107; var_4 < var_3.size; var_4++) {
    var_1 = var_1 + 1;
    _id_06CE::_id_D21D(var_1 + ". " + var_3[var_4]);

    if(var_1 >= level._id_5108) {
      var_2 = 1;
      break;
    }
  }

  if(var_3.size > level._id_5108) {
    _id_06CE::_id_D21D("(->) More >");
    _id_06CE::_id_D21D("(<-) Previous >");
  }
}

_id_7DD8() {
  var_0 = _id_06CE::_id_601D();

  if(level._id_5107 >= var_0.size - level._id_5108) {
    level._id_5107 = 0;
  } else {
    level._id_5107 = level._id_5107 + level._id_5108;
  }
}

_id_4550() {
  level._id_5107 = level._id_5107 - level._id_5108;

  if(level._id_5107 < 0) {
    var_0 = _id_06CE::_id_601D();
    level._id_5107 = var_0.size - level._id_5108;
  }
}

_id_D035() {
  var_0 = 0;
  var_1 = undefined;
  var_2 = _id_06CE::_id_601D();

  for(var_3 = level._id_5107; var_3 < var_2.size; var_3++) {
    var_0 = var_0 + 1;
    var_4 = var_0;

    if(var_4 == 10) {
      var_4 = 0;
    }

    if(_id_06CE::_id_2DC9(var_4 + "")) {
      var_1 = var_2[var_3];
      break;
    }

    if(var_0 > level._id_5108) {
      break;
    }
  }

  if(!isDefined(var_1)) {
    return;
  }
  var_5 = [];

  foreach(var_3, var_7 in level._id_3FE3) {
    if(issubstr(var_7.v["fxid"], var_1)) {
      var_5[var_5.size] = var_3;
    }
  }

  _id_06CE::_id_480F();
  _id_06CE::_id_D03F(var_5);
  level._id_0BA7._id_D035 = 1;
}

_id_6540() {
  return level._id_0BA7._id_D057[level._id_0BA7._id_D057.size - 1];
}