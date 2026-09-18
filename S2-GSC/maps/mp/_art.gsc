/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_art.gsc
*********************************************/

main() {
  if(!isDefined(level.dofdefault)) {
    level.dofdefault["nearStart"] = 0;
    level.dofdefault["nearEnd"] = 0;
    level.dofdefault["farStart"] = 0;
    level.dofdefault["farEnd"] = 0;
    level.dofdefault["nearBlur"] = 6;
    level.dofdefault["farBlur"] = 1.8;
  }
}

setup_fog_tweak() {}

inittweaks() {}

tweaklightset() {}

tweakart() {}

fovslidercheck() {}

construct_vision_ents() {
  if(!isDefined(level.vision_set_fog)) {
    level.vision_set_fog = [];
  }

  var_00 = getEntArray("trigger_multiple_light_visionset", "classname");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.script_visionset)) {
      construct_vision_set(var_02.script_visionset);
    }

    if(isDefined(var_02.script_visionset_start)) {
      construct_vision_set(var_02.script_visionset_start);
    }

    if(isDefined(var_02.script_visionset_end)) {
      construct_vision_set(var_02.script_visionset_end);
    }
  }
}

construct_vision_set(param_00) {
  if(isDefined(level.vision_set_fog[param_00])) {
    return;
  }

  create_default_vision_set_fog(param_00);
  create_vision_set_vision(param_00);
  iprintlnbold("new vision: " + param_00);
}

create_vision_set_vision(param_00) {
  if(!isDefined(level.vision_set_vision)) {
    level.vision_set_vision = [];
  }

  var_01 = spawnStruct();
  var_01.name = param_00;
  level.vision_set_vision[param_00] = var_01;
  return var_01;
}

add_vision_sets_from_triggers() {}

add_vision_set(param_00) {}

create_default_vision_set_fog(param_00) {
  var_01 = create_vision_set_fog(param_00);
  var_01.startdist = 3764.17;
  var_01.halfwaydist = 19391;
  var_01.red = 0.661137;
  var_01.green = 0.554261;
  var_01.blue = 0.454014;
  var_01.maxopacity = 0.7;
  var_01.transitiontime = 0;
  var_01.skyfogintensity = 0;
  var_01.skyfogminangle = 0;
  var_01.skyfogmaxangle = 0;
  var_01.heightfogenabled = 0;
  var_01.heightfogbaseheight = 0;
  var_01.heightfoghalfplanedistance = 1000;
}

create_vision_set_fog(param_00) {
  if(!isDefined(level.vision_set_fog)) {
    level.vision_set_fog = [];
  }

  var_01 = spawnStruct();
  var_01.name = param_00;
  var_01.skyfogintensity = 0;
  var_01.skyfogminangle = 0;
  var_01.skyfogmaxangle = 0;
  var_01.heightfogenabled = 0;
  var_01.heightfogbaseheight = 0;
  var_01.heightfoghalfplanedistance = 1000;
  var_01.var_1105 = 0;
  var_01.var_110E = 0;
  var_01.var_110F = 0;
  var_01.var_1104 = 1;
  var_01.var_10FF = 0;
  var_01.var_1100 = 1;
  var_01.var_1101 = 0;
  var_01.var_111F = 0;
  var_01.var_1115 = 0;
  var_01.var_1116 = 0;
  var_01.var_1117 = 0;
  var_01.var_1120 = 0;
  var_01.var_111C = 0;
  var_01.var_111D = 0;
  var_01.var_111E = 0;
  var_01.var_1122 = 0;
  var_01.var_1125 = 0;
  var_01.var_1123 = (0, 0, 0);
  var_01.var_111B = 0;
  var_01.var_1124 = 0;
  var_01.var_1118 = 0;
  var_01.var_1119 = 0;
  var_01.var_111A = 0;
  var_01.var_1121 = 0;
  level.vision_set_fog[tolower(param_00)] = var_01;
  return var_01;
}

set_fog(param_00, param_01) {
  level.vision_set_transition_ent.vision_set = param_00;
  level.vision_set_transition_ent.time = param_01;
  var_02 = get_fog(param_00);
  if(getdvarint("scr_art_tweak") != 0) {
    translateenttosliders(var_02);
    param_01 = 0;
  }

  common_scripts\utility::set_fog_to_ent_values(var_02, param_01);
}

translateenttosliders(param_00) {}

hud_init() {
  var_00 = 7;
  var_01 = [];
  var_02 = 15;
  var_03 = int(var_00 / 2);
  var_04 = 240 + var_03 * var_02;
  var_05 = 0.5 / var_03;
  var_06 = var_05;
  for(var_07 = 0; var_07 < var_00; var_07++) {
    var_01[var_07] = _newhudelem();
    var_01[var_07].location = 0;
    var_01[var_07].alignx = "left";
    var_01[var_07].aligny = "middle";
    var_01[var_07].foreground = 1;
    var_01[var_07].fontscale = 2;
    var_01[var_07].sort = 20;
    if(var_07 == var_03) {
      var_01[var_07].alpha = 1;
    } else {
      var_01[var_07].alpha = var_06;
    }

    var_01[var_07].x = 20;
    var_01[var_07].y = var_04;
    var_01[var_07] _settext(".");
    if(var_07 == var_03) {
      var_05 = var_05 * -1;
    }

    var_06 = var_06 + var_05;
    var_04 = var_04 - var_02;
  }

  level.spam_group_hudelems = var_01;
}

_newhudelem() {
  if(!isDefined(level.scripted_elems)) {
    level.scripted_elems = [];
  }

  var_00 = newhudelem();
  level.scripted_elems[level.scripted_elems.size] = var_00;
  return var_00;
}

_settext(param_00) {
  self.realtext = param_00;
  self settext("_");
  thread _clearalltextafterhudelem();
  var_01 = 0;
  foreach(var_03 in level.scripted_elems) {
    if(isDefined(var_03.realtext)) {
      var_01 = var_01 + var_03.realtext.size;
      var_03 settext(var_03.realtext);
    }
  }
}

_clearalltextafterhudelem() {
  if(getDvar("netconststrings_enabled") != "0") {
    return;
  }

  if(level._clearalltextafterhudelem) {
    return;
  }

  level._clearalltextafterhudelem = 1;
  self clearalltextafterhudelem();
  wait 0.05;
  level._clearalltextafterhudelem = 0;
}

setgroup_up() {
  reset_cmds();
  var_00 = undefined;
  var_01 = getarraykeys(level.vision_set_fog);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(var_01[var_02] == level.vision_set_transition_ent.vision_set) {
      var_00 = var_02 + 1;
      break;
    }
  }

  if(var_00 == var_01.size) {
    return;
  }

  setcurrentgroup(var_01[var_00]);
}

setgroup_down() {
  reset_cmds();
  var_00 = undefined;
  var_01 = getarraykeys(level.vision_set_fog);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(var_01[var_02] == level.vision_set_transition_ent.vision_set) {
      var_00 = var_02 - 1;
      break;
    }
  }

  if(var_00 < 0) {
    return;
  }

  setcurrentgroup(var_01[var_00]);
}

reset_cmds() {}

func_A567(param_00, param_01) {
  foreach(var_03 in level.players) {
    var_03 visionsetnakedforplayer(param_00, param_01);
    function_0226(&"dev_vision_exec");
    wait 0.05;
  }

  set_fog(param_00, param_01);
}

setcurrentgroup(param_00) {
  var_01 = getarraykeys(level.vision_set_fog);
  level.spam_model_current_group = param_00;
  var_02 = 0;
  var_03 = int(level.spam_group_hudelems.size / 2);
  for(var_04 = 0; var_04 < var_01.size; var_04++) {
    if(var_01[var_04] == param_00) {
      var_02 = var_04;
      break;
    }
  }

  level.spam_group_hudelems[var_03] _settext(var_01[var_02]);
  for(var_04 = 1; var_04 < level.spam_group_hudelems.size - var_03; var_04++) {
    if(var_02 - var_04 < 0) {
      level.spam_group_hudelems[var_03 + var_04] _settext(".");
      continue;
    }

    level.spam_group_hudelems[var_03 + var_04] _settext(var_01[var_02 - var_04]);
  }

  for(var_04 = 1; var_04 < level.spam_group_hudelems.size - var_03; var_04++) {
    if(var_02 + var_04 > var_01.size - 1) {
      level.spam_group_hudelems[var_03 - var_04] _settext(".");
      continue;
    }

    level.spam_group_hudelems[var_03 - var_04] _settext(var_01[var_02 + var_04]);
  }

  func_A567(var_01[var_02], 0);
}

get_fog(param_00) {
  if(!isDefined(level.vision_set_fog)) {
    level.vision_set_fog = [];
  }

  var_01 = level.vision_set_fog[param_00];
  return var_01;
}

init_fog_transition() {
  if(!isDefined(level.fog_transition_ent)) {
    level.fog_transition_ent = spawnStruct();
    level.fog_transition_ent.fogset = "";
    level.fog_transition_ent.time = 0;
  }
}

playerinit() {
  var_00 = level.vision_set_transition_ent.vision_set;
  level.vision_set_transition_ent.vision_set = "";
  level.vision_set_transition_ent.time = "";
  init_fog_transition();
  level.fog_transition_ent.fogset = "";
  level.fog_transition_ent.time = "";
  setcurrentgroup(var_00);
}

button_down(param_00, param_01) {
  var_02 = level.player buttonpresseddevonly(param_00);
  if(!var_02) {
    var_02 = level.player buttonpresseddevonly(param_01);
  }

  if(!isDefined(level.buttons[param_00])) {
    level.buttons[param_00] = 0;
  }

  if(gettime() < level.buttons[param_00]) {
    return 0;
  }

  level.buttons[param_00] = gettime() + 400;
  return var_02;
}

dumpsettings() {}

artstartvisionfileexport() {
  common_scripts\utility:: fileprint_launcher_start_file();
}

artendvisionfileexport() {
  return common_scripts\utility:: fileprint_launcher_end_file("\\share\\raw\\vision\\" + level.script + ".vision",1);
}

artstartfogfileexport() {
  common_scripts\utility:: fileprint_launcher_start_file();
}

artendfogfileexport() {
  return common_scripts\utility:: fileprint_launcher_end_file("\\share\\raw\\maps\\createart\\" + level.script + "_art.gsc",1);
}

artfxprintlnfog() {
  common_scripts\utility:: fileprint_launcher("");
    common_scripts\utility:: fileprint_launcher("\t
    common_scripts\utility:: fileprint_launcher("");
    common_scripts\utility:: fileprint_launcher("\tsetDevDvar( \"scr_fog_disable\", \" + getdvarint("scr_fog_disable") + "\" + " );");
    common_scripts\utility:: fileprint_launcher("");
    common_scripts\utility:: fileprint_launcher("\t/$");
    common_scripts\utility:: fileprint_launcher("\tlevel._art_fog_setup = maps\\createart\\" + level.script + "_fog_hdr::main;");
    common_scripts\utility:: fileprint_launcher("\t$/");
}

art_print_fog() {}

create_light_set(param_00) {
  if(!isDefined(level.light_set)) {
    level.light_set = [];
  }

  var_01 = spawnStruct();
  var_01.name = param_00;
  level.light_set[param_00] = var_01;
  return var_01;
}

getvisionsetindexfromname(param_00) {
  if(!isDefined(level.vision_set_fog)) {
    return;
  }

  var_01 = 0;
  foreach(var_04, var_03 in level.vision_set_fog) {
    if(var_04 == param_00) {
      return var_01;
    }

    var_01++;
  }

  var_05 = "";
  foreach(var_04, var_03 in level.vision_set_fog) {
    var_05 = var_05 + "\'" + var_04 + "\'";
  }
}