/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3835.gsc
*********************************************/

func_FE05() {
  if(!isDefined(level.var_FD6E)) {
    level.var_FD6E = spawnStruct();
  }

  return level.var_FD6E;
}

func_E3F7() {
  if(!isDefined(level.var_E35D)) {
    level.var_E35D = spawnStruct();
  }

  return level.var_E35D;
}

func_118C1() {
  if(!isDefined(level.var_118A8)) {
    level.var_118A8 = spawnStruct();
  }

  return level.var_118A8;
}

func_7D7A(var_0, var_1) {
  if(!isDefined(level.var_877A)) {
    var_2 = getallvehiclenodes();
    level.var_877A = [];
    foreach(var_4 in var_2) {
      if(isDefined(var_4.var_336)) {
        level.var_877A = scripts\engine\utility::array_add(level.var_877A, var_4.var_336);
      }
    }
  }

  if(isvector(var_0)) {
    var_6 = scripts\engine\utility::spawn_tag_origin();
    var_6.var_8779 = 1;
    var_6.origin = var_0;
    return var_6;
  } else if(isstring(var_1)) {
    if(isstruct(scripts\engine\utility::getstruct(var_1, "targetname"))) {
      return scripts\engine\utility::getstruct(var_1, "targetname");
    } else if(isent(getent(var_1, "targetname"))) {
      return getent(var_1, "targetname");
    } else if(isnode(getnode(var_1, "targetname"))) {
      return getnode(var_1, "targetname");
    } else if(getsubstr(var_1, 0, 2) == "**") {
      return getsubstr(var_1, 2);
    } else if(isDefined(scripts\engine\utility::array_find(level.var_877A, var_1))) {
      return getvehiclenode(var_1, "targetname");
    } else if(isDefined(var_6) && var_6) {
      return undefined;
    } else {
      return;
    }
  } else {
    return var_1;
  }
}

func_7CBB(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getStructArray(var_0, var_1);
  foreach(var_6 in var_4) {
    if(isDefined(var_6.script_parameters)) {
      if(var_6.script_parameters == var_2) {
        return var_6;
      }
    }
  }
}

func_798D(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, var_1);
  foreach(var_5 in var_3) {
    if(isDefined(var_5.script_noteworthy)) {
      if(var_5.script_noteworthy == var_2) {
        return var_5;
      }
    }
  }
}

func_798E(var_0, var_1, var_2) {
  if(var_2 == "_ignore_last_sparam") {
    return getent(var_0, var_1);
  }

  var_3 = getEntArray(var_0, var_1);
  foreach(var_5 in var_3) {
    if(isDefined(var_5.script_parameters)) {
      if(var_5.script_parameters == var_2) {
        return var_5;
      }
    }
  }
}

func_7CBE(var_0, var_1, var_2) {
  if(var_2 == "_ignore_last_sparam") {
    return scripts\engine\utility::getstruct(var_0, var_1);
  }

  var_3 = scripts\engine\utility::getStructArray(var_0, var_1);
  foreach(var_5 in var_3) {
    if(isDefined(var_5.script_parameters)) {
      if(var_5.script_parameters == var_2) {
        return var_5;
      }
    }
  }
}

func_7CBC(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_0, var_1);
  foreach(var_5 in var_3) {
    if(isDefined(var_5.var_EE52)) {
      if(var_5.var_EE52 == var_2) {
        return var_5;
      }
    }
  }
}

func_798A(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, var_1);
  foreach(var_5 in var_3) {
    if(isDefined(var_5.var_EE52)) {
      if(var_5.var_EE52 == var_2) {
        return var_5;
      }
    }
  }
}

func_7CC0(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_0, var_1);
  foreach(var_5 in var_3) {
    if(isDefined(var_5.var_EE52)) {
      if(var_5.var_EE52 != var_2) {
        var_3 = scripts\engine\utility::array_remove(var_3, var_5);
      }

      continue;
    }

    var_3 = scripts\engine\utility::array_remove(var_3, var_5);
  }

  return var_3;
}

func_7991(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, var_1);
  foreach(var_5 in var_3) {
    if(isDefined(var_5.var_EE52)) {
      if(var_5.var_EE52 != var_2) {
        var_3 = scripts\engine\utility::array_remove(var_3, var_5);
      }

      continue;
    }

    var_3 = scripts\engine\utility::array_remove(var_3, var_5);
  }

  return var_3;
}

func_7992(var_0, var_1, var_2) {
  if(var_1 == "script_parameters") {
    var_3 = getEntArray();
    foreach(var_5 in var_3) {
      if(isDefined(var_5.script_parameters)) {
        if(var_5.script_parameters != var_0) {
          var_3 = scripts\engine\utility::array_remove(var_3, var_5);
        }

        continue;
      }

      var_3 = scripts\engine\utility::array_remove(var_3, var_5);
    }
  } else {
    var_3 = getEntArray(var_1, var_2);
  }

  foreach(var_5 in var_3) {
    if(isDefined(var_5.script_noteworthy)) {
      if(var_5.script_noteworthy != var_2) {
        var_3 = scripts\engine\utility::array_remove(var_3, var_5);
      }

      continue;
    }

    var_3 = scripts\engine\utility::array_remove(var_3, var_5);
  }

  return var_3;
}

func_7994(var_0, var_1, var_2) {
  if(var_2 == "_ignore_last_sparam") {
    return getEntArray(var_0, var_1);
  }

  var_3 = getEntArray(var_0, var_1);
  foreach(var_5 in var_3) {
    if(isDefined(var_5.script_parameters)) {
      if(var_5.script_parameters != var_2) {
        var_3 = scripts\engine\utility::array_remove(var_3, var_5);
      }

      continue;
    }

    var_3 = scripts\engine\utility::array_remove(var_3, var_5);
  }

  return var_3;
}

func_7995(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, var_1);
  foreach(var_5 in var_3) {
    if(isDefined(var_5.isbotmatchmakingenabled)) {
      if(var_5.isbotmatchmakingenabled != var_2) {
        var_3 = scripts\engine\utility::array_remove(var_3, var_5);
      }

      continue;
    }

    var_3 = scripts\engine\utility::array_remove(var_3, var_5);
  }

  return var_3;
}

func_7993(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, var_1);
  foreach(var_5 in var_3) {
    if(isDefined(var_5.script_parameters)) {
      if(getsubstr(var_5.script_parameters, 0, var_2.size) != var_2) {
        var_3 = scripts\engine\utility::array_remove(var_3, var_5);
      }

      continue;
    }

    var_3 = scripts\engine\utility::array_remove(var_3, var_5);
  }

  return var_3;
}

func_799B(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_noteworthy)) {
      if(var_3.script_noteworthy != var_1) {
        var_0 = scripts\engine\utility::array_remove(var_0, var_3);
      }

      continue;
    }

    var_0 = scripts\engine\utility::array_remove(var_0, var_3);
  }

  return var_0;
}

func_7990(var_0) {
  var_1 = getEntArray();
  foreach(var_3 in var_1) {
    if(isDefined(var_3.var_336)) {
      if(getsubstr(var_3.var_336, 0, var_0.size) != var_0) {
        var_1 = scripts\engine\utility::array_remove(var_1, var_3);
      }

      continue;
    }

    var_1 = scripts\engine\utility::array_remove(var_1, var_3);
  }

  return var_1;
}

func_7CBF(var_0) {
  var_1 = level.struct_class_names["targetname"];
  var_2 = getarraykeys(level.struct_class_names["targetname"]);
  foreach(var_4 in var_2) {
    if(getsubstr(var_4, 0, var_0.size) != var_0) {
      var_1 = scripts\engine\utility::array_remove(var_1, var_1[var_4]);
    }
  }
}

func_798C(var_0, var_1, var_2, var_3) {
  var_4 = func_7991(var_0, var_1, var_2);
  foreach(var_6 in var_4) {
    if(isDefined(var_6.isbotmatchmakingenabled) && var_6.isbotmatchmakingenabled == var_3) {
      return var_6;
    }
  }
}

func_798B(var_0, var_1, var_2, var_3) {
  if(var_3 == "_ignore_last_sparam") {
    return func_798A(var_0, var_1, var_2);
  }

  var_4 = func_7991(var_0, var_1, var_2);
  foreach(var_6 in var_4) {
    if(isDefined(var_6.script_parameters) && var_6.script_parameters == var_3) {
      return var_6;
    }
  }
}

func_7CBD(var_0, var_1, var_2, var_3) {
  if(var_3 == "_ignore_last_sparam") {
    return func_7CBC(var_0, var_1, var_2);
  }

  var_4 = func_7CC0(var_0, var_1, var_2);
  foreach(var_6 in var_4) {
    if(isDefined(var_6.script_parameters) && var_6.script_parameters == var_3) {
      return var_6;
    }
  }
}

func_7CC1(var_0, var_1, var_2) {
  if(var_2 == "_ignore_last_sparam") {
    return scripts\engine\utility::getStructArray(var_0, var_1);
  }

  var_3 = scripts\engine\utility::getStructArray(var_0, var_1);
  foreach(var_5 in var_3) {
    if(isDefined(var_5.script_parameters)) {
      if(var_5.script_parameters != var_2) {
        var_3 = scripts\engine\utility::array_remove(var_3, var_5);
      }

      continue;
    }

    var_3 = scripts\engine\utility::array_remove(var_3, var_5);
  }

  return var_3;
}

func_7C34(var_0, var_1, var_2) {
  var_3 = getscriptablearray(var_0, var_1);
  foreach(var_5 in var_3) {
    if(isDefined(var_5.var_EE52)) {
      if(var_5.var_EE52 != var_2) {
        var_3 = scripts\engine\utility::array_remove(var_3, var_5);
      }

      continue;
    }

    var_3 = scripts\engine\utility::array_remove(var_3, var_5);
  }

  return var_3;
}

func_FDE7(var_0) {
  if(isDefined(var_0)) {
    if(isai(var_0) || isDefined(var_0.var_9B89)) {
      return;
    }

    if(isDefined(level.var_FD6E) && isDefined(level.var_FD6E.var_7316) && scripts\engine\utility::array_contains(level.var_FD6E.var_7316, var_0)) {
      var_0 func_7304();
    } else {
      if(isDefined(var_0.var_9A62)) {
        scripts\engine\utility::array_call(var_0.var_9A62, ::delete);
      }

      var_0 delete();
    }

    func_FE0C();
  }
}

func_FDE8(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  foreach(var_2 in var_0) {
    func_FDE7(var_2);
  }
}

func_7304() {
  stopFXOnTag(scripts\engine\utility::getfx("forklift_red_flash"), self, "tag_light_top_red");
  if(isDefined(self.var_5BC8)) {
    self.var_5BC8 func_81D0();
    self.var_5BC8 delete();
  }

  self func_81D0();
  self delete();
}

func_FE0C() {
  if(!isDefined(level.var_FD6E)) {
    return;
  }

  if(isDefined(level.var_FD6E.var_5EE3)) {
    func_22B8(level.var_FD6E.var_5EE3);
  }

  if(isDefined(level.var_FD6E.jackals)) {
    func_22B8(level.var_FD6E.jackals);
  }

  if(isDefined(level.var_FD6E.var_7316)) {
    func_22B8(level.var_FD6E.var_7316);
  }

  if(isDefined(level.var_FD6E.var_11A55)) {
    func_22B8(level.var_FD6E.var_11A55);
  }
}

func_22B8(var_0) {
  foreach(var_3, var_2 in var_0) {
    if(!isDefined(var_2)) {
      var_0 = scripts\sp\utility::func_22B2(var_0, var_3);
    }
  }
}

func_EFDB(var_0) {
  return level.var_FD6E.var_454F[var_0];
}

func_FD9C(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  if(!isDefined(level.var_FD6E.var_1912[var_0])) {
    return [];
  }

  return level.var_FD6E.var_1912[var_0];
}

func_FD72(var_0) {
  var_0 endon("cleaned");
  var_0 waittill("death");
  level thread func_FD71();
}

func_FD71() {
  foreach(var_2, var_1 in level.var_FD6E.var_1912) {
    level.var_FD6E.var_1912[var_2] = ::scripts\engine\utility::array_removeundefined(level.var_FD6E.var_1912[var_2]);
    level.var_FD6E.var_1912[var_2] = ::scripts\sp\utility::func_22B9(level.var_FD6E.var_1912[var_2]);
  }
}

func_FD6F(var_0) {
  if(!isDefined(level.var_FD6E.var_1912[var_0])) {
    level.var_FD6E.var_1912[var_0] = [];
  }

  self.var_ECE7 = var_0;
  level.var_FD6E.var_1912[var_0] = ::scripts\engine\utility::add_to_array(level.var_FD6E.var_1912[var_0], self);
}

func_FDBB(var_0) {
  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  foreach(var_2 in var_0) {
    var_3 = func_FD9C(var_2);
    foreach(var_5 in var_3) {
      var_5 notify("cleaned");
      func_FDBA(var_5);
    }
  }

  func_FD71();
}

func_FDBA(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_0.var_EF = 1;
  var_0.noragdoll = 1;
  if(isDefined(var_0.var_1F1C)) {
    var_0.var_1F1C notify("ambient_idle_scene_end");
  }

  if(isDefined(var_0.var_B14F)) {
    var_0 scripts\sp\utility::func_1101B();
  }

  if(isai(var_0)) {
    var_0 func_81D0();
  }

  var_0 delete();
}

func_FE0B() {
  var_0 = getarraykeys(level.var_FD6E.var_10B32);
  if(scripts\engine\utility::array_contains(var_0, self.var_1FBB)) {
    self detach(self.headmodel);
    self.var_10B31 = level.var_FD6E.var_10B32[self.var_1FBB];
    self attach(self.var_10B31);
  }
}

func_FE0A() {
  self detach(self.var_10B31);
  self attach(self.headmodel);
}

func_CD3F(var_0) {
  func_11004();
  var_1 = level.var_C6AA["retribution"].var_EF67;
  while(!isDefined(var_1)) {
    scripts\engine\utility::waitframe();
  }

  var_2 = undefined;
  if(issubstr(var_0, "nav") || issubstr(var_0, "gator")) {
    var_2 = level.var_C6AA["retribution"].var_454F["nav"];
  } else if(issubstr(var_0, "xo") || issubstr(var_0, "salter")) {
    var_2 = level.var_C6AA["retribution"].var_454F["xo"];
  } else if(issubstr(var_0, "drop") || issubstr(var_0, "do")) {
    var_2 = level.var_C6AA["retribution"].var_454F["drop"];
  } else if(issubstr(var_0, "conn") || issubstr(var_0, "captain")) {
    var_2 = level.var_C6AA["retribution"].var_454F["captain"];
  }

  thread scripts\sp\interaction::func_CD50(var_0, var_1, var_2);
}

func_11004() {
  if(scripts\sp\utility::func_65DF("hold_simple_idles")) {
    scripts\sp\utility::func_65DD("hold_simple_idles");
  }

  thread scripts\sp\interaction::func_9A0F();
  if(isDefined(self.var_C6B7)) {
    if(isDefined(self.var_C6B7.var_4B31)) {
      self.var_C6B7 clearanim(self.var_C6B7.var_4B31, 0.2);
    }
  }

  self.var_C6B7 = undefined;
  self.var_C6B9 = undefined;
  self.var_C6B8 = undefined;
  thread lib_0C4C::func_19BE();
}

func_906D() {
  scripts\sp\utility::func_65E1("hold_simple_idles");
}

func_45A5() {
  scripts\sp\utility::func_65DD("hold_simple_idles");
}

func_F59B(var_0) {
  level.var_FDFA = var_0;
  scripts\sp\loadout::func_F56D(level.var_FDFA);
  setsaveddvar("missionSelected", "1");
  setomnvar("ui_opsmap_selected_mission", var_0);
}

func_7C60() {
  if(isDefined(level.var_FDFA)) {
    return level.var_FDFA;
  }

  return undefined;
}

func_7C5F() {
  if(!isDefined(level.var_FDBC)) {
    level.var_FDBC = level.player func_84C6("lastCompletedMission");
    if(!scripts\sp\utility::func_9BB5()) {
      if(isDefined(func_4EDF())) {
        level.var_FDBC = func_4EDF();
      }
    }
  }

  return level.var_FDBC;
}

func_9DB9() {
  var_0 = 0;
  switch (level.var_10CDA) {
    case "prisoner start":
    case "rogue start":
    case "titan start":
    case "europa start":
    case "moon start":
      var_0 = 1;
      break;
  }

  return var_0;
}

func_4EDF() {
  var_0 = func_4EE1();
  if(!isDefined(var_0)) {
    var_0 = func_4EE0();
  }

  return var_0;
}

func_4EE0() {
  var_0 = undefined;
  switch (level.script) {
    case "shipcrib_europa":
      level.player func_84C7("lastCompletedMission", "sa_moon");
      var_0 = "sa_moon";
      break;

    case "shipcrib_titan":
      level.player func_84C7("scTitanFirstPlay", 0);
      level.player func_84C7("lastCompletedMission", "sa_assassination");
      var_0 = "sa_assassination";
      break;

    case "shipcrib_rogue":
      level.player func_84C7("lastCompletedMission", "titanjackal");
      var_0 = "titan";
      break;

    case "shipcrib_prisoner":
      level.player func_84C7("lastCompletedMission", "rogue");
      var_0 = "rogue";
      break;
  }

  return var_0;
}

func_4EE1() {
  var_0 = undefined;
  switch (level.var_10CDA) {
    case "sc_sa_assa":
      var_0 = "sa_assassination";
      level.player func_84C7("scTitanFirstPlay", 1);
      level.player func_84C7("lastCompletedMission", "sa_assassination");
      break;

    case "sc_sa_emp":
      var_0 = "sa_empambush";
      level.player func_84C7("scTitanFirstPlay", 1);
      level.player func_84C7("lastCompletedMission", "sa_empambush");
      break;

    case "sc_sa_vips":
      var_0 = "sa_vips";
      level.player func_84C7("scTitanFirstPlay", 1);
      level.player func_84C7("lastCompletedMission", "sa_vips");
      break;

    case "sc_sa_wound":
      var_0 = "sa_wounded";
      level.player func_84C7("scTitanFirstPlay", 1);
      level.player func_84C7("lastCompletedMission", "sa_wounded");
      break;

    case "sc_ja_asteroid":
      var_0 = "ja_asteroid";
      level.player func_84C7("scTitanFirstPlay", 1);
      level.player func_84C7("lastCompletedMission", "ja_asteroid");
      break;

    case "sc_ja_mining":
      var_0 = "ja_mining";
      level.player func_84C7("scTitanFirstPlay", 1);
      level.player func_84C7("lastCompletedMission", "ja_mining");
      break;

    case "sc_ja_spacestation":
      var_0 = "ja_spacestation";
      level.player func_84C7("scTitanFirstPlay", 1);
      level.player func_84C7("lastCompletedMission", "ja_spacestation");
      break;

    case "sc_ja_titan":
      var_0 = "ja_titan";
      level.player func_84C7("scTitanFirstPlay", 1);
      level.player func_84C7("lastCompletedMission", "ja_titan");
      break;

    case "sc_ja_wreckage":
      var_0 = "ja_wreckage";
      level.player func_84C7("scTitanFirstPlay", 1);
      level.player func_84C7("lastCompletedMission", "ja_wreckage");
      break;
  }

  return var_0;
}

func_7AF0() {
  var_0 = func_7C60();
  if(!isDefined(var_0)) {
    var_0 = func_7C5F();
  }

  var_1 = func_45F0(var_0);
  return var_1;
}

func_7C51() {
  var_0 = func_7C60();
  var_1 = func_45F0(var_0);
  return var_1;
}

func_7A73() {
  var_0 = func_7C5F();
  var_1 = func_45F0(var_0);
  return var_1;
}

func_45F0(var_0) {
  var_1 = undefined;
  if(isDefined(var_0)) {
    switch (var_0) {
      case "sa_vips":
        var_1 = "sa_vips";
        break;

      case "sa_empambush":
        var_1 = "sa_empambush";
        break;

      case "sa_assassination":
        var_1 = "sa_assassination";
        break;

      case "sa_wounded":
        var_1 = "sa_wounded";
        break;

      case "sa_jackalarena":
        var_1 = "sa_jackalarena";
        break;

      case "sa_moon":
        var_1 = "ml_moon";
        break;

      case "titan":
        var_1 = "ml_titan";
        break;

      case "titanjackal":
        var_1 = "ml_titan";
        break;

      case "rogue":
        var_1 = "ml_rogue";
        break;

      case "prisoner":
        var_1 = "ml_prisoner";
        break;

      case "ja_asteroid":
        var_1 = "ja_asteroid";
        break;

      case "ja_mining":
        var_1 = "ja_mining";
        break;

      case "ja_spacestation":
        var_1 = "ja_spacestation";
        break;

      case "ja_titan":
        var_1 = "ja_titan";
        break;

      case "ja_wreckage":
        var_1 = "ja_wreckage";
        break;
    }
  }

  return var_1;
}

func_9CB4() {
  if(!isDefined(level.var_EFF6)) {
    func_9870();
  }

  return level.var_EFF6;
}

func_9870() {
  var_0 = level.player func_84C6("scTitanFirstPlay");
  if((!isDefined(var_0) || var_0 == 0) && level.script == "shipcrib_titan") {
    var_1 = 1;
  } else {
    var_1 = 0;
  }

  level.var_EFF6 = var_1;
}

func_986C() {
  level.var_EFF2 = level.player func_84C6("scTaughtOpsmap");
}

func_FD77(var_0) {
  var_1 = [var_0 + "_prime_tr", var_0 + "_prime_in_tr", var_0 + "_bridge_tr", var_0 + "_bridgee_tr", var_0 + "_halore_tr", var_0 + "_exterior_tr"];
  if(var_0 != "shipcrib_moon" && var_0 != "shipcrib_europa") {
    var_2 = [var_0 + "_bridgem_tr"];
    var_1 = scripts\engine\utility::array_combine(var_1, var_2);
  }

  func_FE05();
  level.var_FD6E.var_30B8 = var_1;
  return var_1;
}

func_FD73(var_0) {
  var_1 = [var_0 + "_prime_tr", var_0 + "_prime_in_tr", var_0 + "_hangar_tr", var_0 + "_halore_tr", var_0 + "_mezz_tr", var_0 + "_ambient_tr", var_0 + "_vr_tr"];
  if(var_0 != "shipcrib_moon") {
    var_2 = [var_0 + "_dropship_tr", var_0 + "_ambientml_tr"];
    var_1 = scripts\engine\utility::array_combine(var_1, var_2);
  }

  func_FE05();
  level.var_FD6E.var_224C = var_1;
  return var_1;
}

func_FDAE(var_0) {
  var_1 = [var_0 + "_prime_tr", var_0 + "_prime_in_tr", var_0 + "_hangar_tr", var_0 + "_halore_tr", var_0 + "_mezz_tr", var_0 + "_ambient_tr"];
  if(var_0 != "shipcrib_moon") {
    var_2 = [var_0 + "_dropship_tr", var_0 + "_ambientml_tr"];
    var_1 = scripts\engine\utility::array_combine(var_1, var_2);
  }

  func_FE05();
  level.var_FD6E.var_8ACB = var_1;
  return var_1;
}

func_FDDC(var_0) {
  var_1 = [var_0 + "_prime_tr", var_0 + "_prime_in_tr", var_0 + "_jackal_tr", var_0 + "_hangar_tr", var_0 + "_mezz_tr", var_0 + "_halore_tr", var_0 + "_ambient_tr"];
  if(var_0 != "shipcrib_moon") {
    var_2 = [var_0 + "_dropship_tr", var_0 + "_ambientmr_tr"];
    var_1 = scripts\engine\utility::array_combine(var_1, var_2);
  }

  func_FE05();
  level.var_FD6E.var_E46F = var_1;
  return var_1;
}

func_FDB2(var_0) {
  var_1 = [var_0 + "_prime_tr", var_0 + "_prime_in_tr", var_0 + "_jackal_tr", var_0 + "_jackale_tr", var_0 + "_hangar_tr", var_0 + "_mezz_tr", var_0 + "_ambient_tr"];
  func_FE05();
  level.var_FD6E.var_A248 = var_1;
  return var_1;
}

func_FDBD(var_0, var_1) {
  func_FE05();
  if(!isDefined(level.var_FD6E.var_111D7)) {
    level.var_FD6E.var_111D7 = getmapsuncolorandintensity()[3];
  }

  var_2 = var_1 / 0.05;
  var_3 = var_0 - level.var_FD6E.var_111D7;
  var_4 = var_3 / var_2;
  for(var_5 = 0; var_5 < var_2; var_5++) {
    if(var_2 == 1) {
      break;
    }

    level.var_FD6E.var_111D7 = level.var_FD6E.var_111D7 + var_4;
    setsuncolorandintensity(level.var_FD6E.var_111D7);
    scripts\engine\utility::waitframe();
  }

  setsuncolorandintensity(var_0);
  level.var_FD6E.var_111D7 = var_0;
}

func_FDCD() {
  if(isDefined(level.var_C6AA) && isDefined(level.var_C6AA["retribution"]) && isDefined(level.var_C6AA["retribution"].var_BA11) && isDefined(level.var_C6AA["retribution"].var_BA11["nav_screen"])) {
    level.var_C6AA["retribution"].var_BA11["nav_screen"] unlink();
  }
}

func_25ED() {
  var_0 = randomintrange(0, 3);
  if(var_0 == 0) {
    setglobalsoundcontext("vr_fire_speed", "", 0);
  }

  if(var_0 == 1) {
    setglobalsoundcontext("vr_fire_speed", "1", 0);
  }

  if(var_0 == 2) {
    setglobalsoundcontext("vr_fire_speed", "2", 0);
  }
}

func_EB8E(var_0, var_1, var_2) {
  level notify("shipcrib_loadout_heroes");
  level endon("shipcrib_loadout_heroes");
  if(!isDefined(var_0)) {
    var_0 = [level.var_EA2C, level.var_6754, level.var_C47F, level.var_30F6, level.var_A538];
  }

  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  scripts\engine\utility::array_thread(var_0, ::func_EB8D, var_1, var_2);
}

func_EB8D(var_0, var_1) {
  self notify("loadout_hero");
  self endon("loadout_hero");
  self endon("death");
  level endon("shipcrib_loadout_heroes");
  if(!isDefined(level.var_FDFA) && !isDefined(var_0)) {
    return 0;
  }

  if(isDefined(level.var_FDFA)) {
    var_0 = level.var_FDFA;
  }

  switch (self.var_1FBB) {
    case "salter":
      thread func_AE40(var_0, var_1);
      break;

    case "ethan":
      thread func_AE2D(var_0, var_1);
      break;

    case "omar":
      thread func_AE3C(var_0, var_1);
      break;

    case "brooks":
      thread func_AE25(var_0, var_1);
      break;

    case "kash":
      thread func_AE37(var_0, var_1);
      break;

    case "nunez":
      thread func_AE3B(var_0, var_1);
      break;

    case "goodwin":
      thread func_AE34(var_0, var_1);
      break;

    case "private":
      thread func_AE3D(var_0, var_1);
      break;

    case "admiral":
      thread func_AE22(var_0, var_1);
      break;

    case "sipes":
      thread func_AE43(var_0, var_1);
      break;

    default:
      scripts\sp\utility::func_86E2();
      break;
  }

  if(isDefined(var_1) && var_1) {
    if(isDefined(self.var_13C4D)) {
      self.var_13C4D delete();
    }

    scripts\sp\utility::func_CC06(self.weapon, "back");
  }
}

func_AE40(var_0, var_1) {
  self endon("death");
  self endon("loadout_hero");
  level endon("shipcrib_loadout_heroes");
  var_2 = undefined;
  var_3 = undefined;
  switch (var_0) {
    case "phparade":
      var_2 = "iw7_m8";
      var_3 = "iw7_m4";
      break;

    case "moon_port":
      var_3 = "iw7_m4";
      break;

    case "sa_wounded":
      var_3 = "iw7_devastator";
      break;

    case "sa_empambush":
      var_3 = "iw7_m8+m8scope_sp+silencersniperhidee";
      break;

    case "sa_assassination":
      var_3 = "iw7_crb+silencersmg";
      break;

    case "sa_vips":
      var_2 = "iw7_m8+m8scope_sp+silencersniperhidee";
      var_3 = "iw7_m4+silencer";
      break;

    case "titan":
      var_3 = "iw7_devastator";
      break;

    case "rogue":
      var_3 = "iw7_devastator";
      break;

    case "heist":
      var_3 = "iw7_m4";
      break;

    case "prisoner":
      var_3 = "iw7_m4";
      break;
  }

  thread func_AE45(var_1, var_3);
}

func_AE2D(var_0, var_1) {
  self endon("death");
  self endon("loadout_hero");
  level endon("shipcrib_loadout_heroes");
  var_2 = undefined;
  var_3 = undefined;
  switch (var_0) {
    case "phparade":
      var_3 = "iw7_fhr";
      break;

    case "moon_port":
      var_3 = "iw7_m4";
      break;

    case "sa_vips":
      var_3 = "iw7_crb+silencersmg";
      break;

    case "titan":
      var_3 = "iw7_crb+silencersmg";
      break;

    case "prisoner":
      var_3 = "iw7_fhr";
      break;

    case "heist":
      var_3 = "iw7_fmg";
      break;
  }

  thread func_AE45(var_1, var_3);
}

func_AE3C(var_0, var_1) {
  self endon("death");
  self endon("loadout_hero");
  level endon("shipcrib_loadout_heroes");
  var_2 = undefined;
  var_3 = undefined;
  switch (var_0) {
    case "moon_port":
      var_3 = "iw7_m4";
      break;

    case "titan":
      var_3 = "iw7_fhr+silencersmg";
      break;

    case "rogue":
      var_3 = "iw7_sdfshotty";
      break;
  }

  thread func_AE45(var_1, var_3);
}

func_AE25(var_0, var_1) {
  self endon("death");
  self endon("loadout_hero");
  level endon("shipcrib_loadout_heroes");
  var_2 = undefined;
  var_3 = undefined;
  switch (var_0) {
    case "moon_port":
      var_3 = "iw7_m4";
      break;

    case "sa_wounded":
      var_3 = "iw7_erad";
      break;

    case "sa_empambush":
      var_3 = "iw7_kbs+kbsscope+silencersniperhide";
      break;

    case "sa_vips":
      var_3 = "iw7_m4+silencer";
      break;

    case "titan":
      var_3 = "iw7_ar57+silencer";
      break;

    case "rogue":
      var_3 = "iw7_ake";
      break;

    case "heist":
      var_3 = "iw7_ar57";
      break;

    case "prisoner":
      var_3 = "iw7_ar57";
      break;
  }

  thread func_AE45(var_1, var_3);
}

func_AE37(var_0, var_1) {
  self endon("death");
  self endon("loadout_hero");
  level endon("shipcrib_loadout_heroes");
  var_2 = undefined;
  var_3 = undefined;
  switch (var_0) {
    case "moon_port":
      var_3 = "iw7_m4";
      break;

    case "sa_empambush":
      var_3 = "iw7_kbs+kbsscope+silencersniperhide";
      break;

    case "sa_vips":
      var_3 = "iw7_erad+silencersmge";
      break;

    case "titan":
      var_3 = "iw7_fmg+silencerefmg";
      break;

    case "rogue":
      var_3 = "iw7_ripper";
      break;

    case "heist":
      var_3 = "iw7_erad";
      break;
  }

  thread func_AE45(var_1, var_3);
}

func_AE3B(var_0, var_1) {
  self endon("death");
  self endon("loadout_hero");
  level endon("shipcrib_loadout_heroes");
  var_2 = undefined;
  var_3 = undefined;
  switch (var_0) {
    case "moon_port":
      var_3 = "iw7_m4";
      break;
  }

  thread func_AE45(var_1, var_3);
}

func_AE34(var_0, var_1) {
  self endon("death");
  self endon("loadout_hero");
  level endon("shipcrib_loadout_heroes");
  var_2 = undefined;
  var_3 = undefined;
  switch (var_0) {
    case "moon_port":
      var_3 = "iw7_m4";
      break;
  }

  thread func_AE45(var_1, var_3);
}

func_AE3D(var_0, var_1) {
  self endon("death");
  self endon("loadout_hero");
  level endon("shipcrib_loadout_heroes");
  var_2 = undefined;
  var_3 = undefined;
  switch (var_0) {
    case "moon_port":
      var_3 = "iw7_m4";
      break;
  }

  thread func_AE45(var_1, var_3);
}

func_AE22(var_0, var_1) {
  self endon("death");
  self endon("loadout_hero");
  level endon("shipcrib_loadout_heroes");
  var_2 = undefined;
  var_3 = undefined;
  switch (var_0) {
    case "phparade":
      var_3 = "iw7_ake";
      break;
  }

  thread func_AE45(var_1, var_3);
}

func_AE43(var_0, var_1) {
  self endon("death");
  self endon("loadout_hero");
  level endon("shipcrib_loadout_heroes");
  var_2 = undefined;
  var_3 = undefined;
  switch (var_0) {
    case "europa":
      var_3 = "iw7_fhr+silencersmg";
      break;
  }

  thread func_AE45(var_1, var_3);
}

func_AE45(var_0, var_1) {
  self endon("death");
  if(isDefined(var_0)) {
    level func_3DDE(var_1);
    scripts\sp\utility::func_192C(var_1);
  }

  if(isDefined(var_1)) {
    level func_3DDE(var_1);
    scripts\sp\utility::func_72EC(var_1, "primary");
    return;
  }

  level func_3DDE(self.weapon);
  scripts\sp\utility::func_86E2();
}

func_3DDE(var_0, var_1) {
  var_0 = getweaponbasename(var_0);
  var_2 = "weapon_" + var_0 + "_tr";
  if(!istransientloaded(var_2)) {
    scripts\sp\utility::func_13705();
    scripts\sp\utility::func_12641(var_2);
    if(!scripts\engine\utility::array_contains(level.var_D9E5["loaded_weapons"], var_0)) {
      level.var_D9E5["loaded_weapons"] = ::scripts\engine\utility::array_add(level.var_D9E5["loaded_weapons"], var_0);
      level.player func_84C7("weaponsLoaded", var_0, 1);
    }
  }
}

func_7B87(var_0) {
  return level.var_EC85["player_rig"][var_0];
}

func_FDD6(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "Urban";
  }

  switch (var_1) {
    case "Urban":
      level thread func_37D0(var_0, var_1, "viewmodel_base_viewhands_iw7");
      level thread scripts\sp\utility::func_9145("fluff_messages_camo_urban");
      break;

    case "Naval":
      level thread func_37D0(var_0, var_1, "viewmodel_base_viewhands_iw7_naval");
      level thread scripts\sp\utility::func_9145("fluff_messages_camo_naval");
      break;

    case "Desert":
      level thread func_37D0(var_0, var_1, "viewmodel_base_viewhands_iw7_desert");
      level thread scripts\sp\utility::func_9145("fluff_messages_camo_desert");
      break;
  }
}

func_37D0(var_0, var_1, var_2) {
  level.player playSound("sc_armory_player_hand_camo_change");
  var_0 setotherent(level.player);
  var_0 func_854E();
  var_3 = var_0 gettagorigin("j_elbow_le");
  var_4 = var_0 gettagangles("j_elbow_le");
  var_3 = var_3 + anglesToForward(var_4) * 8;
  var_5 = var_3 + anglesToForward(var_4) * -24;
  var_6 = scripts\engine\utility::spawn_tag_origin(var_3, var_4);
  playFXOnTag(scripts\engine\utility::getfx("vfx_sc_armory_terminal_camo_change_scan"), var_6, "tag_origin");
  var_6 moveto(var_5, 1, 0.125, 0.125);
  var_6 scripts\engine\utility::delaycall(1, ::moveto, var_3, 1, 0.125, 0.125);
  wait(0.5);
  var_0 setscriptablepartstate("camouflage", "camouflageOn", 1);
  wait(0.5);
  level.player func_84C7("currentViewModel", var_2);
  var_0 func_FDD7(1);
  var_0 setscriptablepartstate("camouflage", "camouflageOnInstant", 1);
  scripts\engine\utility::waitframe();
  var_0 setscriptablepartstate("camouflage", "camouflageOff", 1);
  wait(1.25);
  killfxontag(scripts\engine\utility::getfx("vfx_sc_armory_terminal_camo_change_scan"), var_6, "tag_origin");
  var_6 delete();
}

func_FDD7(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = func_FD9D();
  switch (var_1) {
    case "viewmodel_base_viewhands_iw7_naval":
      var_2 = "body_hero_protagonist_vm_legs_naval";
      break;

    case "viewmodel_base_viewhands_iw7_desert":
      var_2 = "body_hero_protagonist_vm_legs_desert";
      break;

    default:
      var_2 = "body_hero_protagonist_vm_legs";
      break;
  }

  if(var_0) {
    self setModel(var_1);
  }

  level.player givegoproattachments(var_1);
  level.player func_8574(var_2);
}

func_FE02(var_0, var_1, var_2) {
  var_3 = scripts\sp\utility::func_10639(var_0, var_1, var_2);
  var_4 = func_FD9D();
  var_3 setModel(var_4);
  return var_3;
}

func_FD9D() {
  var_0 = level.player func_84C6("currentViewModel");
  if(!isDefined(var_0)) {
    var_0 = "viewmodel_base_viewhands_iw7";
  } else if(var_0 == "") {
    var_0 = "viewmodel_base_viewhands_iw7";
  }

  return var_0;
}

func_FDD9() {
  scripts\sp\utility::func_13C3C(level.var_FDFA);
  scripts\sp\utility::func_13C60();
}

shipcrib_autosave_now_silent() {
  level notify("try_new_autosave");
  for(;;) {
    var_0 = shipcrib_autosave_now_silent_internal();
    if(!isDefined(var_0)) {
      if(scripts\engine\utility::flag("game_saving")) {
        scripts\engine\utility::flag_clear("game_saving");
      }

      return;
    }

    if(var_0) {
      return;
    }
  }
}

shipcrib_autosave_now_silent_internal() {
  level endon("try_new_autosave");
  while(!scripts\sp\autosave::func_1190(1, 1)) {
    wait(1);
  }

  return 1;
}