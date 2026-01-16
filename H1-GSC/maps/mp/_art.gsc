/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_art.gsc
********************************/

main() {
  if(!isdefined(level.dofdefault)) {
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
  if(!isdefined(level.vision_set_fog))
    level.vision_set_fog = [];

  var_0 = getentarray("trigger_multiple_visionset", "classname");

  foreach(var_2 in var_0) {
    if(isdefined(var_2.script_visionset))
      construct_vision_set(var_2.script_visionset);

    if(isdefined(var_2.script_visionset_start))
      construct_vision_set(var_2.script_visionset_start);

    if(isdefined(var_2.script_visionset_end))
      construct_vision_set(var_2.script_visionset_end);
  }
}

construct_vision_set(var_0) {
  if(isdefined(level.vision_set_fog[var_0])) {
    return;
  }
  create_default_vision_set_fog(var_0);
  create_vision_set_vision(var_0);
  iprintlnbold("new vision: " + var_0);
}

create_vision_set_vision(var_0) {
  if(!isdefined(level.vision_set_vision))
    level.vision_set_vision = [];

  var_1 = spawnstruct();
  var_1.name = var_0;
  level.vision_set_vision[var_0] = var_1;
  return var_1;
}

add_vision_sets_from_triggers() {}

add_vision_set(var_0) {}

create_default_vision_set_fog(var_0) {
  var_1 = create_vision_set_fog(var_0);
  var_1.startdist = 3764.17;
  var_1.halfwaydist = 19391;
  var_1.red = 0.661137;
  var_1.green = 0.554261;
  var_1.blue = 0.454014;
  var_1.maxopacity = 0.7;
  var_1.transitiontime = 0;
  var_1.skyfogintensity = 0;
  var_1.skyfogminangle = 0;
  var_1.skyfogmaxangle = 0;
  var_1.heightfogenabled = 0;
  var_1.heightfogbaseheight = 0;
  var_1.heightfoghalfplanedistance = 1000;
}

create_vision_set_fog(var_0) {
  if(!isdefined(level.vision_set_fog))
    level.vision_set_fog = [];

  var_1 = spawnstruct();
  var_1.name = var_0;
  var_1.skyfogintensity = 0;
  var_1.skyfogminangle = 0;
  var_1.skyfogmaxangle = 0;
  var_1.heightfogenabled = 0;
  var_1.heightfogbaseheight = 0;
  var_1.heightfoghalfplanedistance = 1000;
  level.vision_set_fog[tolower(var_0)] = var_1;
  return var_1;
}

set_fog(var_0, var_1) {
  level.vision_set_transition_ent.vision_set = var_0;
  level.vision_set_transition_ent.time = var_1;
  var_2 = get_fog(var_0);

  if(getdvarint("scr_art_tweak") != 0) {
    translateenttosliders(var_2);
    var_1 = 0;
  }

  common_scripts\utility::set_fog_to_ent_values(var_2, var_1);
}

translateenttosliders(var_0) {}

hud_init() {
  var_0 = 7;
  var_1 = [];
  var_2 = 15;
  var_3 = int(var_0 / 2);
  var_4 = 240 + var_3 * var_2;
  var_5 = 0.5 / var_3;
  var_6 = var_5;

  for (var_7 = 0; var_7 < var_0; var_7++) {
    var_1[var_7] = _newhudelem();
    var_1[var_7].location = 0;
    var_1[var_7].alignx = "left";
    var_1[var_7].aligny = "middle";
    var_1[var_7].foreground = 1;
    var_1[var_7].fontscale = 2;
    var_1[var_7].sort = 20;

    if(var_7 == var_3)
      var_1[var_7].alpha = 1;
    else
      var_1[var_7].alpha = var_6;

    var_1[var_7].x = 20;
    var_1[var_7].y = var_4;
    var_1[var_7] _settext(".");

    if(var_7 == var_3)
      var_5 = var_5 * -1;

    var_6 = var_6 + var_5;
    var_4 = var_4 - var_2;
  }

  level.spam_group_hudelems = var_1;
}

_newhudelem() {
  if(!isdefined(level.scripted_elems))
    level.scripted_elems = [];

  var_0 = newhudelem();
  level.scripted_elems[level.scripted_elems.size] = var_0;
  return var_0;
}

_settext(var_0) {
  self.realtext = var_0;
  self settext("_");
  thread _clearalltextafterhudelem();
  var_1 = 0;

  foreach(var_3 in level.scripted_elems) {
    if(isdefined(var_3.realtext)) {
      var_1 = var_1 + var_3.realtext.size;
      var_3 settext(var_3.realtext);
    }
  }
}

_clearalltextafterhudelem() {
  if(getdvar("netconststrings_enabled") != "0") {
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
  var_0 = undefined;
  var_1 = getarraykeys(level.vision_set_fog);

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == level.vision_set_transition_ent.vision_set) {
      var_0 = var_2 + 1;
      break;
    }
  }

  if(var_0 == var_1.size) {
    return;
  }
  setcurrentgroup(var_1[var_0]);
}

setgroup_down() {
  reset_cmds();
  var_0 = undefined;
  var_1 = getarraykeys(level.vision_set_fog);

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == level.vision_set_transition_ent.vision_set) {
      var_0 = var_2 - 1;
      break;
    }
  }

  if(var_0 < 0) {
    return;
  }
  setcurrentgroup(var_1[var_0]);
}

reset_cmds() {}

vision_set_fog_changes_mp(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_3 visionsetnakedforplayer(var_0, var_1);
    var_3 openpopupmenu("dev_vision_exec");
    wait 0.05;
    var_3 closepopupmenu("dev_vision_exec");
  }

  set_fog(var_0, var_1);
}

setcurrentgroup(var_0) {
  var_1 = getarraykeys(level.vision_set_fog);

  if(level.currentgen) {
    var_2 = var_0 + "_cg";
    var_3 = common_scripts\utility::array_find(var_1, var_2);

    if(isdefined(var_3))
      var_0 = var_2;
  }

  level.spam_model_current_group = var_0;
  var_4 = 0;
  var_5 = int(level.spam_group_hudelems.size / 2);

  for (var_6 = 0; var_6 < var_1.size; var_6++) {
    if(var_1[var_6] == var_0) {
      var_4 = var_6;
      break;
    }
  }

  level.spam_group_hudelems[var_5] _settext(var_1[var_4]);

  for (var_6 = 1; var_6 < level.spam_group_hudelems.size - var_5; var_6++) {
    if(var_4 - var_6 < 0) {
      level.spam_group_hudelems[var_5 + var_6] _settext(".");
      continue;
    }

    level.spam_group_hudelems[var_5 + var_6] _settext(var_1[var_4 - var_6]);
  }

  for (var_6 = 1; var_6 < level.spam_group_hudelems.size - var_5; var_6++) {
    if(var_4 + var_6 > var_1.size - 1) {
      level.spam_group_hudelems[var_5 - var_6] _settext(".");
      continue;
    }

    level.spam_group_hudelems[var_5 - var_6] _settext(var_1[var_4 + var_6]);
  }

  vision_set_fog_changes_mp(var_1[var_4], 0);
}

get_fog(var_0) {
  if(!isdefined(level.vision_set_fog))
    level.vision_set_fog = [];

  var_1 = level.vision_set_fog[var_0];
  return var_1;
}

init_fog_transition() {
  if(!isdefined(level.fog_transition_ent)) {
    level.fog_transition_ent = spawnstruct();
    level.fog_transition_ent.fogset = "";
    level.fog_transition_ent.time = 0;
  }
}

playerinit() {
  var_0 = level.vision_set_transition_ent.vision_set;
  level.vision_set_transition_ent.vision_set = "";
  level.vision_set_transition_ent.time = "";
  init_fog_transition();
  level.fog_transition_ent.fogset = "";
  level.fog_transition_ent.time = "";
  setcurrentgroup(var_0);
}

button_down(var_0, var_1) {
  var_2 = level.player buttonpressed(var_0);

  if(!var_2)
    var_2 = level.player buttonpressed(var_1);

  if(!isdefined(level.buttons[var_0]))
    level.buttons[var_0] = 0;

  if(gettime() < level.buttons[var_0])
    return 0;

  level.buttons[var_0] = gettime() + 400;
  return var_2;
}

dumpsettings() {}

artstartvisionfileexport() {
  common_scripts\utility::fileprint_launcher_start_file();
}

artendvisionfileexport() {
  return common_scripts\utility::fileprint_launcher_end_file("\\share\\raw\\vision\\" + level.script + ".vision", 1);
}

artstartfogfileexport() {
  common_scripts\utility::fileprint_launcher_start_file();
}

artendfogfileexport() {
  return common_scripts\utility::fileprint_launcher_end_file("\\share\\raw\\maps\\createart\\" + level.script + "_art.gsc", 1);
}

artfxprintlnfog() {
    common_scripts\utility::fileprint_launcher("");
    common_scripts\utility::fileprint_launcher("\t\/* Fog section * ");
    common_scripts\utility::fileprint_launcher("");
    common_scripts\utility::fileprint_launcher("\tsetDevDvar(\"scr_fog_disable\", \"" + getdvarint("scr_fog_disable") + "\"" + ");");
    common_scripts\utility::fileprint_launcher("");
    common_scripts\utility::fileprint_launcher("\t\$");

    if(isusinghdr())
      common_scripts\utility::fileprint_launcher("\tlevel._art_fog_setup = maps\\createart\\" + level.script + "_fog_hdr::main;");
    else
      common_scripts\utility::fileprint_launcher("\tlevel._art_fog_setup = maps\\createart\\" + level.script + "_fog::main;");

    common_scripts\utility::fileprint_launcher("\t$\");
    }

    art_print_fog() {}

    create_light_set(var_0) {
      if(!isdefined(level.light_set))
        level.light_set = [];

      var_1 = spawnstruct();
      var_1.name = var_0;
      level.light_set[var_0] = var_1;
      return var_1;
    }