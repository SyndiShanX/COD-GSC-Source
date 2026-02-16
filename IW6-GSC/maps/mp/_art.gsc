/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_art.gsc
*****************************************************/

#include common_scripts\utility;
#include common_scripts\_artCommon;
#include maps\mp\_utility;

main() {
  PrecacheMenu("dev_vision_noloc");
  PrecacheMenu("dev_vision_exec");

  setDevDvarIfUninitialized("scr_art_tweak", 0);
  setDevDvarIfUninitialized("scr_cmd_plr_sun", "0");
  SetDevDvarIfUninitialized("scr_cmd_plr_sunflare", "0");
  setDevDvarIfUninitialized("scr_art_visionfile", level.script);
  SetDevDvar("r_artUseTweaks", false);

  thread tweakart();

  tess_init();

  if(!isDefined(level.script))
    level.script = ToLower(getDvar("mapname"));
}

initTweaks() {
  SetDevDvar("r_artUseTweaks", true);

  if(isDefined(level.parse_fog_func))
    [[level.parse_fog_func]]();

  if(!isDefined(level.buttons))
    level.buttons = [];

  level._clearalltextafterhudelem = false;

  if(!isDefined(level.vision_set_names))
    level.vision_set_names = [];

  if(!isDefined(level.vision_set_fog)) {
    level.vision_set_fog = [];
    create_default_vision_set_fog(level.script);
    common_scripts\_artCommon::setfogsliders();
  }

  foreach(key, value in level.vision_set_fog) {
    common_scripts\_artCommon::add_vision_set_to_list(key);
  }

  add_vision_sets_from_triggers();

  update_current_vision_set_dvars();

  if(!isDefined(level.current_vision_set))
    level.current_vision_set = getDvar("r_artTweaksLastVisionSet", "");

  IPrintLnBold("ART TWEAK ENABLED");
  hud_init();

  last_vision_set = level.current_vision_set;
  if(!isDefined(last_vision_set) || last_vision_set == "")
    last_vision_set = level.script;

  setcurrentgroup(last_vision_set);
}

tweakart() {
  if(!isDefined(level.tweakfile))
    level.tweakfile = false;

  SetDevDvar("scr_fog_fraction", "1.0");
  SetDevDvar("scr_art_dump", "0");

  printed = false;

  last_vision_set = "";

  for(;;) {
    while(GetDvarInt("scr_art_tweak", 0) == 0)
      wait .05;

    if(!printed) {
      printed = true;
      initTweaks();
    }

    common_scripts\_artCommon::translateFogSlidersToScript();

    common_scripts\_artCommon::fogslidercheck();

    updateSunFlarePosition();

    updateFogFromScript();

    if(getdvarint("scr_select_art_next") || button_down("dpad_down", "kp_downarrow"))
      setgroup_down();
    else if(getdvarint("scr_select_art_prev") || button_down("dpad_up", "kp_uparrow"))
      setgroup_up();
    else if(level.current_vision_set != last_vision_set) {
      last_vision_set = level.current_vision_set;
      setcurrentgroup(last_vision_set);
    }

    wait .05;
  }
}

tess_init() {
  using_tessellation = getDvar("r_tessellation");
  if(using_tessellation == "") {
    return;
  }

  level.tess = spawnStruct();

  level.tess.cutoff_distance_current = GetDvarFloat("r_tessellationCutoffDistanceBase", 960.0);
  level.tess.cutoff_distance_goal = level.tess.cutoff_distance_current;
  level.tess.cutoff_falloff_current = GetDvarFloat("r_tessellationCutoffFalloffBase", 320.0);
  level.tess.cutoff_falloff_goal = level.tess.cutoff_falloff_current;
  level.tess.time_remaining = 0.0;
  setDvar("r_tessellationCutoffDistance", level.tess.cutoff_distance_current);
  setDvar("r_tessellationCutoffFalloff", level.tess.cutoff_falloff_current);

  thread tess_update();
}

tess_set_goal(cutoff_distance, cutoff_falloff, blend_time) {
  level.tess.cutoff_distance_goal = cutoff_distance;
  level.tess.cutoff_falloff_goal = cutoff_falloff;
  level.tess.time_remaining = blend_time;
}

tess_update() {
  while(1) {
    cutoff_distance_old = level.tess.cutoff_distance_current;
    cutoff_falloff_old = level.tess.cutoff_falloff_current;

    waitframe();
    if(level.tess.time_remaining > 0.0) {
      frames = level.tess.time_remaining * 20;
      distance_increment = (level.tess.cutoff_distance_goal - level.tess.cutoff_distance_current) / frames;
      falloff_increment = (level.tess.cutoff_falloff_goal - level.tess.cutoff_falloff_current) / frames;
      level.tess.cutoff_distance_current += distance_increment;
      level.tess.cutoff_falloff_current += falloff_increment;
      level.tess.time_remaining -= 0.05;
    } else {
      level.tess.cutoff_distance_current = level.tess.cutoff_distance_goal;
      level.tess.cutoff_falloff_current = level.tess.cutoff_falloff_goal;
    }

    if(cutoff_distance_old != level.tess.cutoff_distance_current) {
      setDvar("r_tessellationCutoffDistance", level.tess.cutoff_distance_current);
    }
    if(cutoff_falloff_old != level.tess.cutoff_falloff_current) {
      setDvar("r_tessellationCutoffFalloff", level.tess.cutoff_falloff_current);
    }
  }
}

updateSunFlarePosition() {
  if(GetDvarInt("scr_cmd_plr_sunflare")) {
    SetDevDvar("scr_cmd_plr_sunflare", 0);

    pos = level.players[0] GetPlayerAngles();

    pos_string = "Sun Flare = ( " + pos[0] + ", " + pos[1] + ", " + pos[2] + " )";
    IPrintLnBold(pos_string);
    Print(pos_string);
  }
}

add_vision_set(vision_set_name) {
  assert(vision_set_name == ToLower(vision_set_name));

  if(isDefined(level.vision_set_fog[vision_set_name])) {
    return;
  }
  create_default_vision_set_fog(vision_set_name);
  common_scripts\_artCommon::add_vision_set_to_list(vision_set_name);

  IPrintLnBold("new vision: " + vision_set_name);
}

button_down(btn, btn2) {
  pressed = level.players[0] buttonPressed(btn);

  if(!pressed) {
    pressed = level.players[0] buttonPressed(btn2);
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

updateFogFromScript() {
  if(GetDvarInt("scr_cmd_plr_sun")) {
    SetDevDvar("scr_sunFogDir", anglesToForward(level.players[0] GetPlayerAngles()));
    SetDevDvar("scr_cmd_plr_sun", 0);
  }

  ent = get_fog_ent_for_vision_set(level.current_vision_set);

  if(isDefined(ent) && isDefined(ent.name)) {
    ent.startDist = level.fognearplane;
    ent.halfwayDist = level.fogexphalfplane;
    ent.red = level.fogcolor[0];
    ent.green = level.fogcolor[1];
    ent.blue = level.fogcolor[2];
    ent.HDRColorIntensity = level.fogHDRColorIntensity;
    ent.maxOpacity = level.fogmaxopacity;

    ent.sunFogEnabled = level.sunFogEnabled;
    ent.sunRed = level.sunFogColor[0];
    ent.sunGreen = level.sunFogColor[1];
    ent.sunBlue = level.sunFogColor[2];
    ent.HDRSunColorIntensity = level.sunFogHDRColorIntensity;
    ent.sunDir = level.sunFogDir;
    ent.sunBeginFadeAngle = level.sunFogBeginFadeAngle;
    ent.sunEndFadeAngle = level.sunFogEndFadeAngle;
    ent.normalFogScale = level.sunFogScale;

    ent.skyFogIntensity = level.skyFogIntensity;
    ent.skyFogMinAngle = level.skyFogMinAngle;
    ent.skyFogMaxAngle = level.skyFogMaxAngle;

    if(GetDvarInt("scr_fog_disable")) {
      ent.startDist = 2000000000;
      ent.halfwayDist = 2000000001;
      ent.red = 0;
      ent.green = 0;
      ent.blue = 0;
      ent.HDRSunColorIntensity = 1;
      ent.maxOpacity = 0;
      ent.skyFogIntensity = 0;
    }

    if(isDefined(level.parse_fog_func))
      set_fog_to_ent_values(ent, 0);
  }
}

update_current_vision_set_dvars() {
  level.players[0] openpopupmenu("dev_vision_exec");
  wait(0.05);
  level.players[0] closepopupmenu();
}

vision_set_changes(vision_set) {
  VisionSetNaked(vision_set, 0);
  update_current_vision_set_dvars();
  level.current_vision_set = vision_set;
}

vision_set_fog_changes(vision_set, transition_time) {
  vision_set_changes(vision_set);
  fog_ent = get_fog_ent_for_vision_set(vision_set);
  if(isDefined(fog_ent)) {
    translateFogEntTosliders(fog_ent);
    if(isDefined(level.parse_fog_func))
      set_fog_to_ent_values(fog_ent, transition_time);
  }
}

get_fog_ent_for_vision_set(vision_set) {
  fog_ent = level.vision_set_fog[ToLower(vision_set)];
  if(using_hdr_fog() && isDefined(fog_ent) && isDefined(fog_ent.HDROverride))
    fog_ent = level.vision_set_fog[ToLower(fog_ent.HDROverride)];

  return fog_ent;
}

using_hdr_fog() {
  if(!isDefined(level.console))
    set_console_status();
  AssertEx(isDefined(level.console) && isDefined(level.xb3) && isDefined(level.ps4), "Expected platform defines to be complete.");

  return is_gen4();
}

translateFogEntTosliders(ent) {
  SetDevDvar("scr_fog_exp_halfplane", ent.halfwayDist);
  SetDevDvar("scr_fog_nearplane", ent.startDist);
  SetDevDvar("scr_fog_color", (ent.red, ent.green, ent.blue));
  SetDevDvar("scr_fog_color_intensity", ent.HDRColorIntensity);
  SetDevDvar("scr_fog_max_opacity", ent.maxOpacity);

  SetDevDvar("scr_skyFogIntensity", ent.skyFogIntensity);
  SetDevDvar("scr_skyFogMinAngle", ent.skyFogMinAngle);
  SetDevDvar("scr_skyFogMaxAngle", ent.skyFogMaxAngle);

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
}

set_fog_to_ent_values(ent, transition_time) {
  if(isDefined(ent.sunFogEnabled) && ent.sunFogEnabled) {
    if(!isPlayer(self)) {
      SetExpFog(ent.startDist, ent.halfwayDist, ent.red, ent.green, ent.blue, ent.HDRColorIntensity, ent.maxOpacity, transition_time, ent.sunRed, ent.sunGreen, ent.sunBlue, ent.HDRSunColorIntensity, ent.sunDir, ent.sunBeginFadeAngle, ent.sunEndFadeAngle, ent.normalFogScale, ent.skyFogIntensity, ent.skyFogMinAngle, ent.skyFogMaxAngle);
    } else {
      self PlayerSetExpFog(ent.startDist, ent.halfwayDist, ent.red, ent.green, ent.blue, ent.HDRColorIntensity, ent.maxOpacity, transition_time, ent.sunRed, ent.sunGreen, ent.sunBlue, ent.HDRSunColorIntensity, ent.sunDir, ent.sunBeginFadeAngle, ent.sunEndFadeAngle, ent.normalFogScale, ent.skyFogIntensity, ent.skyFogMinAngle, ent.skyFogMaxAngle);
    }
  } else {
    if(!isPlayer(self)) {
      SetExpFog(ent.startDist, ent.halfwayDist, ent.red, ent.green, ent.blue, ent.HDRColorIntensity, ent.maxOpacity, transition_time, ent.skyFogIntensity, ent.skyFogMinAngle, ent.skyFogMaxAngle);
    } else {
      self PlayerSetExpFog(ent.startDist, ent.halfwayDist, ent.red, ent.green, ent.blue, ent.HDRColorIntensity, ent.maxOpacity, transition_time, ent.skyFogIntensity, ent.skyFogMinAngle, ent.skyFogMaxAngle);
    }
  }
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
}

hud_init() {
  listsize = 7;

  hudelems = [];
  spacer = 15;
  div = int(listsize / 2);
  org = 240 - div * spacer;
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
    if(i == div)
      hudelems[i].alpha = 1;
    else
      hudelems[i].alpha = alpha;

    hudelems[i].x = 20;
    hudelems[i].y = org;
    hudelems[i] _settext(".");

    if(i == div)
      alphainc *= -1;

    alpha += alphainc;

    org += spacer;
  }

  level.spam_group_hudelems = hudelems;
}

_newhudelem() {
  if(!isDefined(level.scripted_elems))
    level.scripted_elems = [];
  elem = newhudelem();
  level.scripted_elems[level.scripted_elems.size] = elem;
  return elem;
}

_settext(text) {
  self.realtext = text;
  self setDevText("_");
  self thread _clearalltextafterhudelem();
  sizeofelems = 0;
  foreach(elem in level.scripted_elems) {
    if(isDefined(elem.realtext)) {
      sizeofelems += elem.realtext.size;
      elem setDevText(elem.realtext);
    }
  }
  println("Size of elems: " + sizeofelems);
}

_clearalltextafterhudelem() {
  if(level._clearalltextafterhudelem)
    return;
  level._clearalltextafterhudelem = true;
  self clearalltextafterhudelem();
  wait .05;
  level._clearalltextafterhudelem = false;
}

setgroup_up() {
  reset_cmds();

  current_vision_set_name = level.current_vision_set;

  index = array_find(level.vision_set_names, current_vision_set_name);
  if(!isDefined(index)) {
    return;
  }
  index -= 1;

  if(index < 0) {
    return;
  }
  setcurrentgroup(level.vision_set_names[index]);
}

setgroup_down() {
  reset_cmds();

  current_vision_set_name = level.current_vision_set;

  index = array_find(level.vision_set_names, current_vision_set_name);
  if(!isDefined(index)) {
    return;
  }
  index += 1;

  if(index >= level.vision_set_names.size) {
    return;
  }
  setcurrentgroup(level.vision_set_names[index]);
}

reset_cmds() {
  SetDevDvar("scr_select_art_next", 0);
  SetDevDvar("scr_select_art_prev", 0);
}

setcurrentgroup(group) {
  level.spam_model_current_group = group;

  index = array_find(level.vision_set_names, group);
  if(!isDefined(index))
    index = -1;

  hud_list_size = level.spam_group_hudelems.size;
  hud_start_index = index - int(hud_list_size / 2);

  for(i = 0; i < hud_list_size; i++) {
    hud_index = hud_start_index + i;
    if(hud_index < 0 || hud_index >= level.vision_set_names.size) {
      level.spam_group_hudelems[i] _settext(".");
      continue;
    }

    level.spam_group_hudelems[i] _settext(level.vision_set_names[hud_index]);
  }

  group_name = "";
  if(index >= 0)
    group_name = level.vision_set_names[index];

  vision_set_fog_changes(group_name, 0);
}

create_vision_set_fog(fogsetName) {
  if(!isDefined(level.vision_set_fog))
    level.vision_set_fog = [];

  ent = spawnStruct();
  ent.name = fogsetName;

  ent.HDRColorIntensity = 1;
  ent.HDRSunColorIntensity = 1;
  ent.skyFogIntensity = 0;
  ent.skyFogMinAngle = 0;
  ent.skyFogMaxAngle = 0;

  level.vision_set_fog[ToLower(fogsetName)] = ent;
  return ent;
}