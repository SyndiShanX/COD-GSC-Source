/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_art.gsc
***************************************************/

#include common_scripts\utility;
#include common_scripts\_artCommon;

main() {
  if(!isDefined(level.dofDefault)) {
    level.dofDefault["nearStart"] = 0;
    level.dofDefault["nearEnd"] = 0;
    level.dofDefault["farStart"] = 0;
    level.dofDefault["farEnd"] = 0;
    level.dofDefault["nearBlur"] = 6;
    level.dofDefault["farBlur"] = 1.8;
  }
  /$
  if(!isDefined(level.script)) {
    level.script = ToLower(getDvar("mapname"));
  }

  setDevDvarIfUninitialized("scr_art_tweak", 0);
  setDevDvarIfUninitialized("scr_dof_enable", "1");
  setDevDvarIfUninitialized("scr_cmd_plr_sun", "0");
  setDevDvarIfUninitialized("scr_cmd_plr_sun_atmos_fog", "0");
  setDevDvarIfUninitialized("scr_cinematic_autofocus", "1");
  setDevDvarIfUninitialized("scr_art_visionfile", level.script);

  level.curDoF = (level.dofDefault["farStart"] - level.dofDefault["nearEnd"]) / 2;
  level._clearalltextafterhudelem = false;
  level.buttons = [];

  if(!isDefined(level.vision_set_vision)) {
    level.vision_set_vision = [];
  }

  if(!isDefined(level.vision_set_transition_ent)) {
    level.vision_set_transition_ent = spawnStruct();
    level.vision_set_transition_ent.vision_set = level.script;
    level.vision_set_transition_ent.time = 0;
  }

  thread tweaklightset();
  thread tweakart();

  $ /
}

setup_fog_tweak() {
  /$
  if(!isDefined(level.vision_set_fog)) {
    level.vision_set_fog = [];
    if(isDefined(level._art_fog_setup)) {
      [[level._art_fog_setup]]();
    }
    construct_vision_set("");
    construct_vision_set(level.script);
    set_fog(level.script);
    common_scripts\_artCommon::setfogsliders();
  }
  $ /
}

initTweaks() {
  /$
  setup_fog_tweak();

  construct_vision_ents();

  if(!isDefined(level.vision_set_names)) {
    level.vision_set_names = [];
  }

  foreach(key, value in level.vision_set_fog) {
    common_scripts\_artCommon::add_vision_set_to_list(key);
  }

  add_vision_sets_from_triggers();

  hud_init();

  playerInit();

  level.players[0] VisionSetNakedForPlayer(level.script, 0);
  $ /
}

tweaklightset() {
  /$
  SetDevDvar("scr_lightset_dump", "0");

  for(;;) {
    if(GetDvarInt("scr_lightset_dump") != 0) {
      SetDevDvar("scr_lightset_dump", "0");
      common_scripts\_artCommon::print_lightset(get_lightset_filename());
    }

    wait .05;
  }
  $ /
}

tweakart() {
  /$
  if(!isDefined(level.tweakfile)) {
    level.tweakfile = false;
  }

  SetDevDvar("scr_fog_fraction", "1.0");
  SetDevDvar("scr_art_dump", "0");

  SetDevDvar("scr_dof_nearStart", level.dofDefault["nearStart"]);
  SetDevDvar("scr_dof_nearEnd", level.dofDefault["nearEnd"]);
  SetDevDvar("scr_dof_farStart", level.dofDefault["farStart"]);
  SetDevDvar("scr_dof_farEnd", level.dofDefault["farEnd"]);
  SetDevDvar("scr_dof_nearBlur", level.dofDefault["nearBlur"]);
  SetDevDvar("scr_dof_farBlur", level.dofDefault["farBlur"]);

  level.fogfraction = 1.0;

  file = undefined;
  filename = undefined;
  last_vision_set = "";

  inited = false;

  for(;;) {
    while(GetDvarInt("scr_art_tweak", 0) == 0) {
      AssertEx(GetDvarInt("scr_art_dump", 0) == 0, "Must Enable Art Tweaks to export _art file.");
      wait .05;
      if(!GetDvarInt("scr_art_tweak", 0) == 0) {
        common_scripts\_artCommon::setfogsliders();
      }
    }

    if(GetDvarInt("scr_art_tweak_message")) {
      SetDevDvar("scr_art_tweak_message", "0");
      IPrintLnBold("ART TWEAK ENABLED");
    }
    if(!inited) {
      inited = true;
      initTweaks();
    }

    common_scripts\_artCommon::translateFogSlidersToScript();

    fovslidercheck();

    common_scripts\_artCommon::fogslidercheck();

    dump = dumpsettings();

    updateFogEntFromScript();

    if(getdvarint("scr_select_art_next") || button_down("dpad_up", "kp_uparrow")) {
      setgroup_down();
    } else if(getdvarint("scr_select_art_prev") || button_down("dpad_down", "kp_downarrow")) {
      setgroup_up();
    } else if(level.vision_set_transition_ent.vision_set != last_vision_set) {
      last_vision_set = level.vision_set_transition_ent.vision_set;
      setcurrentgroup(last_vision_set);
    }

    if(dump) {
      IPrintLnBold("Art settings dumped success!");
      SetdevDvar("scr_art_dump", "0");
    }
    wait .1;
  }
  $ /
}

fovslidercheck() {
  /$

  if(level.dofDefault["nearStart"] >= level.dofDefault["nearEnd"]) {
    level.dofDefault["nearStart"] = level.dofDefault["nearEnd"] - 1;
    SetDevDvar("scr_dof_nearStart", level.dofDefault["nearStart"]);
  }
  if(level.dofDefault["nearEnd"] <= level.dofDefault["nearStart"]) {
    level.dofDefault["nearEnd"] = level.dofDefault["nearStart"] + 1;
    SetDevDvar("scr_dof_nearEnd", level.dofDefault["nearEnd"]);
  }
  if(level.dofDefault["farStart"] >= level.dofDefault["farEnd"]) {
    level.dofDefault["farStart"] = level.dofDefault["farEnd"] - 1;
    SetDevDvar("scr_dof_farStart", level.dofDefault["farStart"]);
  }
  if(level.dofDefault["farEnd"] <= level.dofDefault["farStart"]) {
    level.dofDefault["farEnd"] = level.dofDefault["farStart"] + 1;
    SetDevDvar("scr_dof_farEnd", level.dofDefault["farEnd"]);
  }
  if(level.dofDefault["farBlur"] >= level.dofDefault["nearBlur"]) {
    level.dofDefault["farBlur"] = level.dofDefault["nearBlur"] - .1;
    SetDevDvar("scr_dof_farBlur", level.dofDefault["farBlur"]);
  }
  if(level.dofDefault["farStart"] <= level.dofDefault["nearEnd"]) {
    level.dofDefault["farStart"] = level.dofDefault["nearEnd"] + 1;
    SetDevDvar("scr_dof_farStart", level.dofDefault["farStart"]);
  }
  $ /
}

construct_vision_ents() {
  if(!isDefined(level.vision_set_fog)) {
    level.vision_set_fog = [];
  }
  trigger_multiple_visionsets = getEntArray("trigger_multiple_visionset", "classname");

  foreach(trigger in trigger_multiple_visionsets) {
    if(isDefined(trigger.script_visionset)) {
      construct_vision_set(trigger.script_visionset);
    }

    if(isDefined(trigger.script_visionset_start)) {
      construct_vision_set(trigger.script_visionset_start);
    }

    if(isDefined(trigger.script_visionset_end)) {
      construct_vision_set(trigger.script_visionset_end);
    }
  }
}

construct_vision_set(vision_set) {
  if(isDefined(level.vision_set_fog[vision_set])) {
    return;
  }

  create_default_vision_set_fog(vision_set);
  create_vision_set_vision(vision_set);

  IPrintLnBold("new vision: " + vision_set);
}

create_vision_set_vision(vision) {
  if(!isDefined(level.vision_set_vision)) {
    level.vision_set_vision = [];
  }
  ent = spawnStruct();
  ent.name = vision;

  level.vision_set_vision[vision] = ent;
  return ent;
}

add_vision_sets_from_triggers() {
  /$
  assert(isDefined(level.vision_set_fog));

  triggers = getEntArray("trigger_multiple_visionset", "classname");

  foreach(trigger in triggers) {
    name = undefined;

    if(isDefined(trigger.script_visionset)) {
      name = ToLower(trigger.script_visionset);
    } else if(isDefined(trigger.script_visionset_start)) {
      name = ToLower(trigger.script_visionset_start);
    } else if(isDefined(trigger.script_visionset_end)) {
      name = ToLower(trigger.script_visionset_end);
    }
    if(isDefined(name)) {
      add_vision_set(name);
    }
  }
  $ /
}

add_vision_set(vision_set_name) {
  /$
  assert(vision_set_name == ToLower(vision_set_name));

  if(isDefined(level.vision_set_fog[vision_set_name])) {
    return;
  }

  create_default_vision_set_fog(vision_set_name);
  common_scripts\_artCommon::add_vision_set_to_list(vision_set_name);

  IPrintLnBold("new vision: " + vision_set_name);
  $ /
}

create_default_vision_set_fog(name) {
  ent = create_vision_set_fog(name);
  ent.startDist = 3764.17;
  ent.halfwayDist = 19391;
  ent.red = 0.661137;
  ent.green = 0.554261;
  ent.blue = 0.454014;
  ent.maxOpacity = 0.7;
  ent.transitionTime = 0;
  ent.skyFogIntensity = 0;
  ent.skyFogMinAngle = 0;
  ent.skyFogMaxAngle = 0;
  ent.heightFogEnabled = 0;
  ent.heightFogBaseHeight = 0;
  ent.heightFogHalfPlaneDistance = 1000;
}

create_vision_set_fog(fogset) {
  if(!isDefined(level.vision_set_fog)) {
    level.vision_set_fog = [];
  }
  ent = spawnStruct();
  ent.name = fogset;

  ent.skyFogIntensity = 0;
  ent.skyFogMinAngle = 0;
  ent.skyFogMaxAngle = 0;
  ent.heightFogEnabled = 0;
  ent.heightFogBaseHeight = 0;
  ent.heightFogHalfPlaneDistance = 1000;

  level.vision_set_fog[ToLower(fogset)] = ent;
  return ent;
}

set_fog(fogname, transition_time) {
  level.vision_set_transition_ent.vision_set = fogname;
  level.vision_set_transition_ent.time = transition_time;
  ent = get_fog(fogname);
  if(GetDvarInt("scr_art_tweak") != 0) {
    translateEntTosliders(ent);

    transition_time = 0;
  }
  set_fog_to_ent_values(ent, transition_time);
}

translateEntTosliders(ent) {
  /$
  ConvertLegacyFog(ent);
  SetDevDvar("scr_fog_exp_halfplane", ent.halfwayDist);
  SetDevDvar("scr_fog_nearplane", ent.startDist);
  SetDevDvar("scr_fog_color", (ent.red, ent.green, ent.blue));
  SetDevDvar("scr_fog_color_intensity", ent.HDRColorIntensity);
  SetDevDvar("scr_fog_max_opacity", ent.maxOpacity);
  SetDevDvar("scr_skyFogIntensity", ent.skyFogIntensity);
  SetDevDvar("scr_skyFogMinAngle", ent.skyFogMinAngle);
  SetDevDvar("scr_skyFogMaxAngle", ent.skyFogMaxAngle);
  SetDevDvar("scr_heightFogEnabled", ent.heightFogEnabled);
  SetDevDvar("scr_heightFogBaseHeight", ent.heightFogBaseHeight);
  SetDevDvar("scr_heightFogHalfPlaneDistance", ent.heightFogHalfPlaneDistance);

  if(isDefined(ent.sunFogEnabled) && ent.sunFogEnabled) {
    SetDevDvar("scr_sunFogEnabled", 1);
    SetDevDvar("scr_sunFogColor", (ent.sunRed, ent.sunGreen, ent.sunBlue));
    SetDevDvar("scr_sunFogColorIntensity", ent.HDRSunColorIntensity);
    SetDevDvar("scr_sunFogDir", ent.sunDir);
    SetDevDvar("scr_sunFogBeginFadeAngle", ent.sunBeginFadeAngle);
    SetDevDvar("scr_sunFogEndFadeAngle", ent.sunEndFadeAngle);
    SetDevDvar("scr_sunFogScale", ent.normalFogScale);
  } else {
    SetDevDvar("scr_sunFogEnabled", 0);
  }

  if(isDefined(ent.atmosFogEnabled)) {
    AssertEx(isDefined(ent.atmosFogSunFogColor));
    AssertEx(isDefined(ent.atmosFogHazeColor));
    AssertEx(isDefined(ent.atmosFogHazeStrength));
    AssertEx(isDefined(ent.atmosFogHazeSpread));
    AssertEx(isDefined(ent.atmosFogExtinctionStrength));
    AssertEx(isDefined(ent.atmosFogInScatterStrength));
    AssertEx(isDefined(ent.atmosFogHalfPlaneDistance));
    AssertEx(isDefined(ent.atmosFogStartDistance));
    AssertEx(isDefined(ent.atmosFogDistanceScale));
    AssertEx(isDefined(ent.atmosFogSkyDistance));
    AssertEx(isDefined(ent.atmosFogSkyAngularFalloffEnabled));
    AssertEx(isDefined(ent.atmosFogSkyFalloffStartAngle));
    AssertEx(isDefined(ent.atmosFogSkyFalloffAngleRange));
    AssertEx(isDefined(ent.atmosFogSunDirection));
    AssertEx(isDefined(ent.atmosFogHeightFogEnabled));
    AssertEx(isDefined(ent.atmosFogHeightFogBaseHeight));
    AssertEx(isDefined(ent.atmosFogHeightFogHalfPlaneDistance));

    SetDevDvar("scr_atmosFogEnabled", ent.atmosFogEnabled);
    SetDevDvar("scr_atmosFogSunFogColor", ent.atmosFogSunFogColor);
    SetDevDvar("scr_atmosFogHazeColor", ent.atmosFogHazeColor);
    SetDevDvar("scr_atmosFogHazeStrength", ent.atmosFogHazeStrength);
    SetDevDvar("scr_atmosFogHazeSpread", ent.atmosFogHazeSpread);
    SetDevDvar("scr_atmosFogExtinctionStrength", ent.atmosFogExtinctionStrength);
    SetDevDvar("scr_atmosFogInScatterStrength", ent.atmosFogInScatterStrength);
    SetDevDvar("scr_atmosFogHalfPlaneDistance", ent.atmosFogHalfPlaneDistance);
    SetDevDvar("scr_atmosFogStartDistance", ent.atmosFogStartDistance);
    SetDevDvar("scr_atmosFogDistanceScale", ent.atmosFogDistanceScale);
    SetDevDvar("scr_atmosFogSkyDistance", int(ent.atmosFogSkyDistance));
    SetDevDvar("scr_atmosFogSkyAngularFalloffEnabled", ent.atmosFogSkyAngularFalloffEnabled);
    SetDevDvar("scr_atmosFogSkyFalloffStartAngle", ent.atmosFogSkyFalloffStartAngle);
    SetDevDvar("scr_atmosFogSkyFalloffAngleRange", ent.atmosFogSkyFalloffAngleRange);
    SetDevDvar("scr_atmosFogSunDirection", ent.atmosFogSunDirection);
    SetDevDvar("scr_atmosFogHeightFogEnabled", ent.atmosFogHeightFogEnabled);
    SetDevDvar("scr_atmosFogHeightFogBaseHeight", ent.atmosFogHeightFogBaseHeight);
    SetDevDvar("scr_atmosFogHeightFogHalfPlaneDistance", ent.atmosFogHeightFogHalfPlaneDistance);
  } else {
    SetDevDvar("scr_atmosFogEnabled", false);
  }
  $ /
}

hud_init() {
  listsize = 7;

  hudelems = [];
  spacer = 15;
  div = int(listsize / 2);
  org = 240 + div * spacer;
  alphainc = .5 / div;
  alpha = alphainc;

  for(i = 0; i < listsize; i++) {
    hudelems[i] = _newhudelem();
    hudelems[i].location = 0;
    hudelems[i].alignX = "left";
    hudelems[i].alignY = "middle";
    hudelems[i].foreground = 1;
    hudelems[i].fontScale = 2;
    hudelems[i].sort = 20;
    if(i == div) {
      hudelems[i].alpha = 1;
    } else {
      hudelems[i].alpha = alpha;
    }

    hudelems[i].x = 20;
    hudelems[i].y = org;
    hudelems[i] _settext(".");

    if(i == div) {
      alphainc *= -1;
    }

    alpha += alphainc;

    org -= spacer;
  }

  level.spam_group_hudelems = hudelems;
}

_newhudelem() {
  if(!isDefined(level.scripted_elems)) {
    level.scripted_elems = [];
  }
  elem = newhudelem();
  level.scripted_elems[level.scripted_elems.size] = elem;
  return elem;
}

_settext(text) {
  self.realtext = text;
  self settext("_");
  self thread _clearalltextafterhudelem();
  sizeofelems = 0;
  foreach(elem in level.scripted_elems) {
    if(isDefined(elem.realtext)) {
      sizeofelems += elem.realtext.size;
      elem settext(elem.realtext);
    }
  }
  println("Size of elems: " + sizeofelems);
}

_clearalltextafterhudelem() {
  if(getDvar("netconststrings_enabled") != "0") {
    return;
  }
  if(level._clearalltextafterhudelem) {
    return;
  }
  level._clearalltextafterhudelem = true;
  self clearalltextafterhudelem();
  wait .05;
  level._clearalltextafterhudelem = false;
}

setgroup_up() {
  reset_cmds();
  index = undefined;
  keys = getarraykeys(level.vision_set_fog);
  for(i = 0; i < keys.size; i++) {
    if(keys[i] == level.vision_set_transition_ent.vision_set) {}
    index = i + 1;
    break;
  }
  if(index == keys.size) {
    return;
  }

  setcurrentgroup(keys[index]);
}

setgroup_down() {
  reset_cmds();
  index = undefined;
  keys = getarraykeys(level.vision_set_fog);
  for(i = 0; i < keys.size; i++) {
    if(keys[i] == level.vision_set_transition_ent.vision_set) {}
    index = i - 1;
    break;
  }
  if(index < 0) {
    return;
  }

  setcurrentgroup(keys[index]);
}

reset_cmds() {
  SetDevDvar("scr_select_art_next", 0);
  SetDevDvar("scr_select_art_prev", 0);
}

setcurrentgroup(group) {
  keys = getarraykeys(level.vision_set_fog);

  if(level.currentgen) {
    group_cg = group + "_cg";
    index_cg = array_find(keys, group_cg);
    if(isDefined(index_cg)) {
      group = group_cg;
    }
  }

  level.spam_model_current_group = group;
  index = 0;
  div = int(level.spam_group_hudelems.size / 2);
  for(i = 0; i < keys.size; i++) {
    if(keys[i] == group) {}
    index = i;
    break;
  }

  level.spam_group_hudelems[div] _settext(keys[index]);

  for(i = 1; i < level.spam_group_hudelems.size - div; i++) {
    if(index - i < 0) {
      level.spam_group_hudelems[div + i] _settext(".");
      continue;
    }
    level.spam_group_hudelems[div + i] _settext(keys[index - i]);
  }

  for(i = 1; i < level.spam_group_hudelems.size - div; i++) {
    if(index + i > keys.size - 1) {
      level.spam_group_hudelems[div - i] _settext(".");
      continue;
    }
    level.spam_group_hudelems[div - i] _settext(keys[index + i]);
  }

  set_fog(keys[index], 0);
}

get_fog(fogset) {
  if(!isDefined(level.vision_set_fog)) {
    level.vision_set_fog = [];
  }

  ent = level.vision_set_fog[fogset];

  return ent;
}

init_fog_transition() {
  if(!isDefined(level.fog_transition_ent)) {
    level.fog_transition_ent = spawnStruct();
    level.fog_transition_ent.fogset = "";
    level.fog_transition_ent.time = 0;
  }
}

playerInit() {
  last_vision_set = level.vision_set_transition_ent.vision_set;

  level.vision_set_transition_ent.vision_set = "";
  level.vision_set_transition_ent.time = "";

  init_fog_transition();
  level.fog_transition_ent.fogset = "";
  level.fog_transition_ent.time = "";

  setcurrentgroup(last_vision_set);
}

button_down(btn, btn2) {
  pressed = level.player ButtonPressed(btn);

  if(!pressed) {
    pressed = level.player ButtonPressed(btn2);
  }

  if(!isDefined(level.buttons[btn])) {
    level.buttons[btn] = 0;
  }

  if(GetTime() < level.buttons[btn]) {
    return false;
  }

  level.buttons[btn] = GetTime() + 400;
  return pressed;
}

dumpsettings() {
  /$
  if((GetDvarInt("scr_art_dump") == 0)) {
    return false;
  }

  dump_art = GetDvarInt("scr_art_dump");

  SetDevDvar("scr_art_dump", "0");

  artStartFogFileExport();
  fileprint_launcher( "fileprint_launcher( "main()" );
  fileprint_launcher( "{" );

  fileprint_launcher( "" );
  fileprint_launcher( "\tlevel.tweakfile = true;" );
  fileprint_launcher( " " );

  fogpath = "maps\\createart\\" + getDvar("scr_art_visionfile") + "_fog";
  fileprint_launcher( "\tif(IsUsingHDR())" );
  fileprint_launcher( "\t\t" + fogpath + "_hdr::SetupFog( );" );
  fileprint_launcher( "\telse" );
  fileprint_launcher( "\t\t" + fogpath + "::SetupFog( );" );

  fileprint_launcher( "\tVisionSetNaked( \"" + level.script + "\", 0 );" );

  fileprint_launcher( "" );
  fileprint_launcher( "}" );
  artEndFogFileExport();

  art_print_fog();

  if(dump_art) {
    if(!common_scripts\_artCommon::print_vision(level.vision_set_transition_ent.vision_set)) {
      return false;
    }
  }

  IPrintLnBold("ART DUMPED SUCCESSFULLY");
  return true;
  $ /
}

artStartVisionFileExport() {
  fileprint_launcher_start_file();
}

artEndVisionFileExport() {
  return fileprint_launcher_end_file( "\\share\\raw\\vision\\"+level.script+ ".vision", true );
}

artStartFogFileExport() {
  fileprint_launcher_start_file();
}

artEndFogFileExport() {
  return fileprint_launcher_end_file( "\\share\\raw\\maps\\createart\\"+level.script+ "_art.gsc", true );
}

artfxprintlnFog() {
  fileprint_launcher( "" );
  fileprint_launcher( "\t
  fileprint_launcher( "" );

  fileprint_launcher( "\tsetDevDvar( \"scr_fog_disable\"" + ", " + "\"" + GetDvarInt( "scr_fog_disable" ) + "\"" + " );" );

  fileprint_launcher( "" );

  fileprint_launcher( "\t/$" );
  if(IsUsingHDR()) {
    fileprint_launcher( "\tlevel._art_fog_setup = maps\\createart\\" + level.script + "_fog_hdr::main;" );
  } else {
    fileprint_launcher( "\tlevel._art_fog_setup = maps\\createart\\" + level.script + "_fog::main;" );
  }
  fileprint_launcher( "\t$/" );
}

art_print_fog() {
  /$
  default_name = get_template_level();
  fileprint_launcher_start_file();
  fileprint_launcher( "fileprint_launcher( "main()" );
  fileprint_launcher( "{" );

  common_scripts\_artCommon::print_fog_ents(true);

  fileprint_launcher( "}" );

  fileprint_launcher( " " );
  fileprint_launcher( "setupfog()" );
  fileprint_launcher( "{" );

  artfxprintlnFog();

  fileprint_launcher( "}" );

  if(IsUsingHDR()) {
    fileprint_launcher_end_file( "\\share\\raw\\maps\\createart\\" + default_name + "_fog_hdr.gsc", true );
  } else {
    fileprint_launcher_end_file( "\\share\\raw\\maps\\createart\\" + default_name + "_fog.gsc", true );
  }
  $ /
}

create_light_set(name) {
  if(!isDefined(level.light_set)) {
    level.light_set = [];
  }
  ent = spawnStruct();
  ent.name = name;

  level.light_set[name] = ent;
  return ent;
}