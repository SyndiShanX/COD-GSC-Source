/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: common_scripts\_createfxmenu.gsc
*********************************************/

func_5205() {
  level.var_05ED.var_6C1E = [];
  func_09DD("vector", "origin", "Origin", (0, 0, 0), "fx", 1);
  func_09DD("vector", "angles", "Angles", (0, 0, 0), "fx", 1);
  func_09DD("string", "fxid", "FX id", "nil", "fx");
  func_09DD("float", "delay", "Repeat rate/start delay", 0.5, "fx");
  func_09DD("string", "flag", "Flag", "nil", "exploder");
  func_09DD("string", "platform", "Platform", "all", "all");
  if(!level.var_64F8) {
    func_09DD("string", "firefx", "2nd FX id", "nil", "exploder");
    func_09DD("float", "firefxdelay", "2nd FX id repeat rate", 0.5, "exploder");
    func_09DD("float", "firefxtimeout", "2nd FX timeout", 5, "exploder");
    func_09DD("string", "firefxsound", "2nd FX soundalias", "nil", "exploder");
    func_09DD("float", "damage", "Radius damage", 150, "exploder");
    func_09DD("float", "damage_radius", "Radius of radius damage", 250, "exploder");
    func_09DD("string", "earthquake", "Earthquake", "nil", "exploder");
    func_09DD("string", "ender", "Level notify for ending 2nd FX", "nil", "exploder");
  }

  func_09DD("float", "delay_min", "Minimimum time between repeats", 1, "soundfx_interval");
  func_09DD("float", "delay_max", "Maximum time between repeats", 2, "soundfx_interval");
  func_09DD("int", "repeat", "Number of times to repeat", 5, "exploder");
  func_09DD("string", "exploder", "Exploder", "1", "exploder");
  func_884C();
  func_09DD("string", "soundalias", "Soundalias", "nil", "all");
  func_09DD("string", "loopsound", "Loopsound", "nil", "exploder");
  func_09DD("int", "reactive_radius", "Reactive Radius", 100, "reactive_fx", undefined, ::func_53BD);
  func_09DD("string", "ambiencename", "Ambience Name", "nil", "soundfx_dynamic");
  func_09DD("int", "dynamic_distance", "Dynamic Max Distance", 1000, "soundfx_dynamic");
  if(!level.var_64F8) {
    func_09DD("string", "rumble", "Rumble", "nil", "exploder");
    func_09DD("int", "stoppable", "Can be stopped from script", "1", "all");
    func_09DD("string", "end_notify", "End notify", "nil", "all");
    func_09DD("int", "stopable", "Stopable", "0", "all");
  }

  level.var_359D = 0;
  level.var_359E = 8;
  level.var_359C = 0;
  level.var_4CAD = 0;
  level.var_4CAE = 12;
  level.var_27F9 = 0;
  level.var_27FE = 0;
  level.var_2809 = [];
  level.var_2809["all"] = [];
  level.var_2809["all"]["exploder"] = 1;
  level.var_2809["all"]["oneshotfx"] = 1;
  level.var_2809["all"]["loopfx"] = 1;
  level.var_2809["all"]["soundfx"] = 1;
  level.var_2809["all"]["soundfx_interval"] = 1;
  level.var_2809["all"]["reactive_fx"] = 1;
  level.var_2809["all"]["soundfx_dynamic"] = 1;
  level.var_2809["fx"] = [];
  level.var_2809["fx"]["exploder"] = 1;
  level.var_2809["fx"]["oneshotfx"] = 1;
  level.var_2809["fx"]["loopfx"] = 1;
  level.var_2809["exploder"] = [];
  level.var_2809["exploder"]["exploder"] = 1;
  level.var_2809["loopfx"] = [];
  level.var_2809["loopfx"]["loopfx"] = 1;
  level.var_2809["oneshotfx"] = [];
  level.var_2809["oneshotfx"]["oneshotfx"] = 1;
  level.var_2809["soundfx"] = [];
  level.var_2809["soundfx"]["soundalias"] = 1;
  level.var_2809["soundfx_interval"] = [];
  level.var_2809["soundfx_interval"]["soundfx_interval"] = 1;
  level.var_2809["reactive_fx"] = [];
  level.var_2809["reactive_fx"]["reactive_fx"] = 1;
  level.var_2809["soundfx_dynamic"] = [];
  level.var_2809["soundfx_dynamic"]["soundfx_dynamic"] = 1;
  var_00 = [];
  var_00["creation"] = ::func_610C;
  var_00["create_oneshot"] = ::func_610B;
  var_00["create_loopfx"] = ::func_610B;
  var_00["change_fxid"] = ::func_610B;
  var_00["none"] = ::func_610F;
  var_00["add_options"] = ::func_6109;
  var_00["select_by_name"] = ::func_6110;
  level.var_05ED.var_6115 = var_00;
}

func_6108(param_00) {
  return level.var_279D == param_00;
}

func_86C9(param_00) {
  level.var_279D = param_00;
}

func_279D() {
  if(common_scripts\_createfx::func_1DCE("escape", "x")) {
    func_0624();
    return;
  }

  if(isDefined(level.var_05ED.var_6115[level.var_279D])) {
    [[level.var_05ED.var_6115[level.var_279D]]]();
  }
}

func_610C() {
  if(common_scripts\_createfx::func_1DCE("1")) {
    func_86C9("create_oneshot");
    func_33B6();
    return;
  }

  if(common_scripts\_createfx::func_1DCE("2")) {
    func_86C9("create_loopfx");
    func_33B6();
    return;
  }

  if(common_scripts\_createfx::func_1DCE("3")) {
    func_86C9("create_loopsound");
    var_00 = common_scripts\_createfx::func_2815();
    func_3B9F(var_00);
    return;
  }

  if(common_scripts\_createfx::func_1DCE("4")) {
    func_86C9("create_exploder");
    var_00 = common_scripts\_createfx::func_281A();
    func_3B9F(var_00);
    return;
  }

  if(common_scripts\_createfx::func_1DCE("5")) {
    func_86C9("create_interval_sound");
    var_00 = common_scripts\_createfx::func_280F();
    func_3B9F(var_00);
    return;
  }

  if(common_scripts\_createfx::func_1DCE("6")) {
    var_00 = common_scripts\_createfx::func_2824();
    func_3B9F(var_00);
    return;
  }

  if(common_scripts\_createfx::func_1DCE("7")) {
    var_00 = common_scripts\_createfx::func_27E4();
    func_3B9F(var_00);
    return;
  }
}

func_610B() {
  level.var_27FE = 1;
  if(func_66A4()) {
    func_50F2();
    func_33B6();
  } else if(func_76D5()) {
    func_2B75();
    func_33B6();
  }

  func_610D();
}

func_610F() {
  if(common_scripts\_createfx::func_1DCE("m")) {
    func_50F2();
  }

  func_610A();
  if(func_37C4()) {
    var_00 = func_41E4();
    if(!isDefined(level.var_5B1E) || var_00 != level.var_5B1E || level.var_05ED.var_5991 == 1) {
      func_2FF6(var_00);
      level.var_5B1E = var_00;
      level.var_05ED.var_5991 = 0;
    }

    if(common_scripts\_createfx::func_1DCE("a")) {
      common_scripts\_createfx::func_23CB();
      func_86C9("add_options");
      return;
    }

    return;
  }

  level.var_5B1E = undefined;
}

func_6109() {
  if(!func_37C4()) {
    common_scripts\_createfx::func_23BA();
    func_86C9("none");
    return;
  }

  func_2FF5(func_41E4());
  if(func_66A4()) {
    func_50F2();
  }
}

func_6110() {
  if(func_66A4()) {
    func_50F2();
    func_33B6("Select by name");
  } else if(func_76D5()) {
    func_2B75();
    func_33B6("Select by name");
  }

  func_838D();
}

func_66A4() {
  return common_scripts\_createfx::func_1DCE("rightarrow");
}

func_76D5() {
  return common_scripts\_createfx::func_1DCE("leftarrow");
}

func_0624() {
  common_scripts\_createfx::func_23BA();
  common_scripts\_createfx::func_23B6();
  common_scripts\_createfx::func_A0CA();
  func_86C9("none");
}

func_610D() {
  var_00 = 0;
  var_01 = undefined;
  var_02 = common_scripts\_createfx::func_3F06();
  for(var_03 = level.var_359D; var_03 < var_02.size; var_03++) {
    var_00 = var_00 + 1;
    var_04 = var_00;
    if(var_04 == 10) {
      var_04 = 0;
    }

    if(common_scripts\_createfx::func_1DCE(var_04 + "")) {
      var_01 = var_02[var_03];
      break;
    }

    if(var_00 > level.var_359E) {
      break;
    }
  }

  if(!isDefined(var_01)) {
    return;
  }

  if(func_6108("change_fxid")) {
    func_0F2A(func_4265("fxid"), var_01);
    level.var_359D = 0;
    common_scripts\_createfx::func_23BA();
    func_86C9("none");
    level.var_27FE = 0;
    level.var_27FC = 0;
    return;
  }

  var_05 = undefined;
  if(func_6108("create_loopfx")) {
    var_05 = common_scripts\utility::func_2814(var_01);
  }

  if(func_6108("create_oneshot")) {
    var_05 = common_scripts\utility::func_281B(var_01);
  }

  func_3B9F(var_05);
}

func_3B9F(param_00) {
  param_00.var_A265["angles"] = vectortoangles(param_00.var_A265["origin"] + (0, 0, 100) - param_00.var_A265["origin"]);
  param_00 common_scripts\_createfx::func_75BE();
  common_scripts\_createfx::func_23B6();
  common_scripts\_createfx::func_8392();
  common_scripts\_createfx::func_648C();
  common_scripts\_createfx::func_A0CA();
  func_86C9("none");
  level.var_27FE = 0;
}

func_37C4() {
  return level.var_05ED.var_83A3.size > 0;
}

func_610A() {
  if(!level.var_05ED.var_83A3.size) {
    return;
  }

  var_00 = 0;
  var_01 = 0;
  var_02 = func_41E4();
  for(var_03 = 0; var_03 < level.var_05ED.var_6C1E.size; var_03++) {
    var_04 = level.var_05ED.var_6C1E[var_03];
    if(!isDefined(var_02.var_A265[var_04["name"]])) {
      continue;
    }

    var_00++;
    if(var_00 < level.var_359D) {
      continue;
    }

    var_01++;
    var_05 = var_01;
    if(var_05 == 10) {
      var_05 = 0;
    }

    if(common_scripts\_createfx::func_1DCE(var_05 + "")) {
      func_769E(var_04, var_01);
      break;
    }

    if(var_01 > level.var_359E) {
      var_06 = 1;
      break;
    }
  }
}

func_769E(param_00, param_01) {
  if(param_00["name"] == "fxid") {
    func_86C9("change_fxid");
    func_33B6();
    return;
  }

  level.var_27FB = 1;
  level.var_05ED.var_4F6E[param_01 + 1].var_0056 = (1, 1, 0);
  if(isDefined(param_00["input_func"])) {
    thread[[param_00["input_func"]]](param_01 + 1);
  } else {
    common_scripts\_createfx::func_27F1("To set " + param_00["description"] + ", type /fx newvalue. To remove " + param_00["description"] + ", type /fx del");
  }

  func_8542(param_00["name"]);
  setDvar("fx", "nil");
}

func_610E() {
  if(getDvar("fx") == "nil") {
    return;
  }

  if(getDvar("fx") == "del") {
    common_scripts\_createfx::func_7CB4();
    return;
  }

  var_00 = func_431E();
  var_01 = undefined;
  if(var_00["type"] == "string") {
    var_01 = getDvar("fx");
  }

  if(var_00["type"] == "int") {
    var_01 = getdvarint("fx");
  }

  if(var_00["type"] == "float") {
    var_01 = getdvarfloat("fx");
  }

  if(var_00["type"] == "vector") {
    var_01 = getdvarvector("fx");
  }

  if(isDefined(var_01)) {
    func_0F2A(var_00, var_01);
    return;
  }

  setDvar("fx", "nil");
}

func_0F2A(param_00, param_01) {
  common_scripts\_createfx::func_805C();
  for(var_02 = 0; var_02 < level.var_05ED.var_83A3.size; var_02++) {
    var_03 = level.var_05ED.var_83A3[var_02];
    if(func_6015(param_00["mask"], var_03.var_A265["type"])) {
      var_03.var_A265[param_00["name"]] = param_01;
    }
  }

  level.var_5B1E = undefined;
  common_scripts\_createfx::func_A0CA();
  common_scripts\_createfx::func_23CB();
  if(param_00["name"] == "origin") {
    level.var_27FC = 0;
    common_scripts\_createfx::func_3E70();
  }

  if(param_00["name"] == "angles") {
    level.var_27FC = 0;
  }

  common_scripts\_createfx::func_805A();
}

func_8542(param_00) {
  for(var_01 = 0; var_01 < level.var_05ED.var_6C1E.size; var_01++) {
    if(level.var_05ED.var_6C1E[var_01]["name"] != param_00) {
      continue;
    }

    level.var_05ED.var_83A4 = var_01;
    return;
  }
}

func_431E() {
  return level.var_05ED.var_6C1E[level.var_05ED.var_83A4];
}

func_6015(param_00, param_01) {
  return isDefined(level.var_2809[param_00][param_01]);
}

func_09DD(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = [];
  var_07["type"] = param_00;
  var_07["name"] = param_01;
  var_07["description"] = param_02;
  var_07["default"] = param_03;
  var_07["mask"] = param_04;
  if(isDefined(param_05) && param_05) {
    var_07["nowrite"] = 1;
  } else {
    var_07["nowrite"] = 0;
  }

  if(isDefined(param_06)) {
    var_07["input_func"] = param_06;
  }

  level.var_05ED.var_6C1E[level.var_05ED.var_6C1E.size] = var_07;
}

func_4265(param_00) {
  for(var_01 = 0; var_01 < level.var_05ED.var_6C1E.size; var_01++) {
    if(level.var_05ED.var_6C1E[var_01]["name"] == param_00) {
      return level.var_05ED.var_6C1E[var_01];
    }
  }
}

func_53BD(param_00) {
  for(;;) {
    wait 0.05;
    if(level.var_721C buttonpresseddevonly("escape") || level.var_721C buttonpresseddevonly("x")) {
      break;
    }

    var_01 = 0;
    if(level.var_721C buttonpresseddevonly("-")) {
      var_01 = -10;
    } else if(level.var_721C buttonpresseddevonly("=")) {
      var_01 = 10;
    }

    if(var_01 != 0) {
      foreach(var_03 in level.var_05ED.var_83A3) {
        if(isDefined(var_03.var_A265["reactive_radius"])) {
          var_03.var_A265["reactive_radius"] = var_03.var_A265["reactive_radius"] + var_01;
          var_03.var_A265["reactive_radius"] = clamp(var_03.var_A265["reactive_radius"], 10, 1000);
        }
      }
    }
  }

  level.var_5B1E = undefined;
  common_scripts\_createfx::func_A0CA();
  common_scripts\_createfx::func_23CB();
}

func_2FF5(param_00) {
  level.var_27FE = 1;
  common_scripts\_createfx::func_23BA();
  common_scripts\_createfx::func_84AD("Name: " + param_00.var_A265["fxid"]);
  common_scripts\_createfx::func_84AD("Type: " + param_00.var_A265["type"]);
  common_scripts\_createfx::func_84AD("Origin: " + param_00.var_A265["origin"]);
  common_scripts\_createfx::func_84AD("Angles: " + param_00.var_A265["angles"]);
  var_01 = 0;
  var_02 = 0;
  var_03 = 0;
  if(level.var_359D >= level.var_05ED.var_6C1E.size) {
    level.var_359D = 0;
  }

  for(var_04 = 0; var_04 < level.var_05ED.var_6C1E.size; var_04++) {
    var_05 = level.var_05ED.var_6C1E[var_04];
    if(isDefined(param_00.var_A265[var_05["name"]])) {
      continue;
    }

    if(!func_6015(var_05["mask"], param_00.var_A265["type"])) {
      continue;
    }

    var_01++;
    if(var_01 < level.var_359D) {
      continue;
    }

    if(var_02 >= level.var_359E) {
      continue;
    }

    var_02++;
    var_06 = var_02;
    if(var_06 == 10) {
      var_06 = 0;
    }

    if(common_scripts\_createfx::func_1DCE(var_06 + "")) {
      func_0952(var_05);
      func_6114();
      level.var_5B1E = undefined;
      return;
    }

    common_scripts\_createfx::func_84AD(var_06 + ". " + var_05["description"]);
  }

  if(var_01 > level.var_359E) {
    level.var_359C = var_01;
    common_scripts\_createfx::func_84AD("(->) More >");
  }

  common_scripts\_createfx::func_84AD("(x) Exit >");
}

func_0952(param_00) {
  var_01 = undefined;
  for(var_02 = 0; var_02 < level.var_05ED.var_83A3.size; var_02++) {
    var_03 = level.var_05ED.var_83A3[var_02];
    if(func_6015(param_00["mask"], var_03.var_A265["type"])) {
      var_03.var_A265[param_00["name"]] = param_00["default"];
    }
  }
}

func_6114() {
  level.var_359D = 0;
  common_scripts\_createfx::func_23BA();
  func_86C9("none");
}

func_2FF6(param_00) {
  if(!func_6108("none")) {
    return;
  }

  if(level.var_27F9) {
    return;
  }

  common_scripts\_createfx::func_23BA();
  common_scripts\_createfx::func_84AD("Name: " + param_00.var_A265["fxid"]);
  common_scripts\_createfx::func_84AD("Type: " + param_00.var_A265["type"]);
  if(func_37C4()) {
    var_01 = 0;
    var_02 = 0;
    var_03 = 0;
    for(var_04 = 0; var_04 < level.var_05ED.var_6C1E.size; var_04++) {
      var_05 = level.var_05ED.var_6C1E[var_04];
      if(!isDefined(param_00.var_A265[var_05["name"]])) {
        continue;
      }

      var_01++;
      if(var_01 < level.var_359D) {
        continue;
      }

      var_02++;
      common_scripts\_createfx::func_84AD(var_02 + ". " + var_05["description"] + ": " + param_00.var_A265[var_05["name"]]);
      if(var_02 > level.var_359E) {
        var_03 = 1;
        break;
      }
    }

    if(var_01 > level.var_359E) {
      level.var_359C = var_01;
      common_scripts\_createfx::func_84AD("(->) More >");
    }

    common_scripts\_createfx::func_84AD("(a) Add >");
    common_scripts\_createfx::func_84AD("(x) Exit >");
    return;
  }

  var_01 = 0;
  var_03 = 0;
  for(var_04 = 0; var_04 < level.var_05ED.var_6C1E.size; var_04++) {
    var_05 = level.var_05ED.var_6C1E[var_04];
    if(!isDefined(param_00.var_A265[var_05["name"]])) {
      continue;
    }

    var_01++;
    common_scripts\_createfx::func_84AD(var_05["description"] + ": " + param_00.var_A265[var_05["name"]]);
    if(var_01 > level.var_05ED.var_4F6C) {
      break;
    }
  }
}

func_2FF2() {
  var_00 = func_41E4();
  if(isDefined(var_00)) {
    func_2FF6(var_00);
  }
}

func_33B6(param_00) {
  common_scripts\_createfx::func_23BA();
  var_01 = 0;
  var_02 = 0;
  var_03 = common_scripts\_createfx::func_3F06();
  level.var_359C = var_03.size;
  if(!isDefined(param_00)) {
    param_00 = "Pick an effect";
  }

  common_scripts\_createfx::func_84AD(param_00 + " [" + level.var_359D + " - " + var_03.size + "]:");
  for(var_04 = level.var_359D; var_04 < var_03.size; var_04++) {
    var_01 = var_01 + 1;
    common_scripts\_createfx::func_84AD(var_01 + ". " + var_03[var_04]);
    if(var_01 >= level.var_359E) {
      var_02 = 1;
      break;
    }
  }

  if(var_03.size > level.var_359E) {
    common_scripts\_createfx::func_84AD("(<-) Previous ... More(->)");
  }
}

func_50F2() {
  if(level.var_359D >= level.var_359C - level.var_359E) {
    level.var_359D = 0;
    return;
  }

  level.var_359D = level.var_359D + level.var_359E;
}

func_2B75() {
  if(level.var_359C < level.var_359E) {
    level.var_359D = 0;
    return;
  }

  level.var_359D = level.var_359D - level.var_359E;
  if(level.var_359D < 0) {
    level.var_359D = level.var_359C - level.var_359E;
  }
}

func_33B8(param_00) {
  common_scripts\_createfx::func_23BA();
  var_01 = 0;
  var_02 = level.var_27FA;
  if(!isDefined(param_00)) {
    param_00 = "Help";
  }

  common_scripts\_createfx::func_84AD("[" + param_00 + "]");
  for(var_03 = level.var_4CAD; var_03 < var_02.size; var_03++) {
    var_01 = var_01 + 1;
    common_scripts\_createfx::func_84AD(var_02[var_03]);
    if(var_01 >= level.var_4CAE) {
      var_04 = 1;
      break;
    }
  }

  if(var_02.size > level.var_4CAE) {
    level.var_359C = var_02.size;
    common_scripts\_createfx::func_84AD("(<-) Previous ... More(->)");
  }
}

func_50EE() {
  var_00 = level.var_27FA;
  if(level.var_4CAD >= var_00.size - level.var_4CAE) {
    level.var_4CAD = 0;
    return;
  }

  level.var_4CAD = level.var_4CAD + level.var_4CAE;
}

func_2B74() {
  level.var_4CAD = level.var_4CAD - level.var_4CAE;
  if(level.var_4CAD < 0) {
    var_00 = level.var_27FA;
    level.var_4CAD = var_00.size - level.var_4CAE;
  }
}

func_4CAF() {
  while(level.var_27F9 == 1) {
    if(func_66A4()) {
      func_50EE();
      func_33B8();
      wait(0.1);
      continue;
    }

    if(func_76D5()) {
      func_2B74();
      func_33B8();
      wait(0.1);
    }

    wait 0.05;
  }
}

func_884C() {
  level.var_27FA = ["Insert Insert entity", "F2 Toggle createfx dot and text drawing", "F5 SAVES your work", "ZUndo", "Shift-ZRedo", "FFrames currently selected entities in camera view", "JJumps to next placed instance of selected entity", "Shift-JJumps to previous placed instance of selected entity", "ENDDrop selected entities to the ground", "AAdd option to the selected entities", "BDraw bounding box of valid placeable FX area (MP only)", "PReset the rotation of the selected entities", "ICopy the angles from the most recently selected fx onto all selected fx.", "OOrient all selected fx to point at most recently selected fx.", "SToggle Snap2Normal mode.", "LToggle 90deg Snap mode.", "GSelect all exploders with same exploder num or flag.Select all oneshots of same fxid", "USelect by name list.", "CConvert between One-Shot and Exploder.", "Shift-RRandomize delay for all selected entities", "Delete Kill the selected entities", "ESCAPE Cancel out of option-modify-mode, must have console open", "SPACE or ->Turn on exploders", "<- Turn off exploders", "Dpad Move selected entities on X/Y or rotate pitch/yaw", "A button Toggle the selection of the current entity", "X button Toggle entity rotation mode", "Y button Move selected entites up or rotate roll", "B button Move selected entites down or rotate roll", "R Shoulder Move selected entities to the cursor", "L Shoulder Hold to select multiple entites", "L JoyClick Copy", "R JoyClick Paste", "Ctrl-C Copy", "Ctrl-V Paste", "NUFO", "TToggle Timescale FAST", "YToggle Timescale SLOW", "[Toggle FX Visibility", "]Toggle ShowTris", "VToggle Vector Fields Debug Draw", "F11Toggle FX Profile"];
}

func_838D() {
  var_00 = 0;
  var_01 = undefined;
  var_02 = common_scripts\_createfx::func_3F06();
  for(var_03 = level.var_359D; var_03 < var_02.size; var_03++) {
    var_00 = var_00 + 1;
    var_04 = var_00;
    if(var_04 == 10) {
      var_04 = 0;
    }

    if(common_scripts\_createfx::func_1DCE(var_04 + "")) {
      var_01 = var_02[var_03];
      break;
    }

    if(var_00 > level.var_359E) {
      break;
    }
  }

  if(!isDefined(var_01)) {
    return;
  }

  var_05 = [];
  foreach(var_03, var_07 in level.var_2804) {
    if(issubstr(var_07.var_A265["fxid"], var_01)) {
      var_05[var_05.size] = var_03;
    }
  }

  common_scripts\_createfx::func_2D93();
  common_scripts\_createfx::func_8391(var_05);
  level.var_05ED.var_838D = 1;
}

func_41E4() {
  return level.var_05ED.var_83A3[level.var_05ED.var_83A3.size - 1];
}