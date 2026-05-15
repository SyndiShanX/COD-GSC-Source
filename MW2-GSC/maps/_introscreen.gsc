/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_introscreen.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {
  flag_init("pullup_weapon");
  flag_init("introscreen_complete");
  flag_init("safe_for_objectives");
  flag_init("introscreen_complete");
  delayThread(10, ::flag_set, "safe_for_objectives");
  level.linefeed_delay = 16;

  PreCacheShader("black");
  PreCacheShader("white");

  if(getDvar("introscreen") == "") {
    setDvar("introscreen", "1");
  }

  if(isDefined(level.credits_active)) {
    return;
  }
  switch (level.script) {
    case "roadkill":

      PreCacheString(&"ROADKILL_LINE_2");

      PreCacheString(&"ROADKILL_LINE_3");

      PreCacheString(&"ROADKILL_LINE_4");

      PreCacheString(&"ROADKILL_LINE_5");
      introscreen_delay();
      break;
    case "airport":

      PreCacheString(&"AIRPORT_LINE2");

      PreCacheString(&"AIRPORT_LINE3");

      PreCacheString(&"AIRPORT_LINE4");

      PreCacheString(&"AIRPORT_LINE5");
      introscreen_delay();
      break;
    case "invasion":

      PreCacheString(&"INVASION_LINE2");

      PreCacheString(&"INVASION_LINE3");

      PreCacheString(&"INVASION_LINE4");

      break;
    case "oilrig":

      PreCacheString(&"OILRIG_INTROSCREEN_LINE_2");

      PreCacheString(&"OILRIG_INTROSCREEN_LINE_3");

      PreCacheString(&"OILRIG_INTROSCREEN_LINE_4");

      PreCacheString(&"OILRIG_INTROSCREEN_LINE_5");
      introscreen_delay();
      break;
    case "gulag":

      PreCacheString(&"GULAG_INTROSCREEN_2");

      PreCacheString(&"GULAG_INTROSCREEN_3");

      PreCacheString(&"GULAG_INTROSCREEN_4");

      PreCacheString(&"GULAG_INTROSCREEN_5");
      introscreen_delay();
      break;
    case "dcburning":

      PreCacheString(&"DCBURNING_INTROSCREEN_2");

      PreCacheString(&"DCBURNING_INTROSCREEN_3");

      PreCacheString(&"DCBURNING_INTROSCREEN_4");

      PreCacheString(&"DCBURNING_INTROSCREEN_5");
      introscreen_delay();
      break;
    case "trainer":

      PreCacheString(&"TRAINER_INTROSCREEN_LINE_2");

      PreCacheString(&"TRAINER_INTROSCREEN_LINE_3");

      PreCacheString(&"TRAINER_INTROSCREEN_LINE_4");

      PreCacheString(&"TRAINER_INTROSCREEN_LINE_5");
      introscreen_delay();
      break;
    case "dcemp":

      PreCacheString(&"DCEMP_INTROSCREEN_2");

      PreCacheString(&"DCEMP_INTROSCREEN_3");

      PreCacheString(&"DCEMP_INTROSCREEN_4");

      PreCacheString(&"DCEMP_INTROSCREEN_5");
      introscreen_delay();
      break;
    case "dc_whitehouse":

      PreCacheString(&"DC_WHITEHOUSE_INTROSCREEN_1");

      PreCacheString(&"DC_WHITEHOUSE_INTROSCREEN_2");

      PreCacheString(&"DC_WHITEHOUSE_INTROSCREEN_3");

      PreCacheString(&"DC_WHITEHOUSE_INTROSCREEN_4");

      PreCacheString(&"DC_WHITEHOUSE_INTROSCREEN_5");
      introscreen_delay();
      break;
    case "killhouse":

      PreCacheString(&"KILLHOUSE_INTROSCREEN_LINE_1");

      PreCacheString(&"KILLHOUSE_INTROSCREEN_LINE_2");

      PreCacheString(&"KILLHOUSE_INTROSCREEN_LINE_3");

      PreCacheString(&"KILLHOUSE_INTROSCREEN_LINE_4");

      PreCacheString(&"KILLHOUSE_INTROSCREEN_LINE_5");

      introscreen_delay(&"KILLHOUSE_INTROSCREEN_LINE_1", &"KILLHOUSE_INTROSCREEN_LINE_3", &"KILLHOUSE_INTROSCREEN_LINE_4", &"KILLHOUSE_INTROSCREEN_LINE_5");
      break;
    case "favela":

      PreCacheString(&"FAVELA_INTROSCREEN_LINE_2");

      PreCacheString(&"FAVELA_INTROSCREEN_LINE_3");

      PreCacheString(&"FAVELA_INTROSCREEN_LINE_4");

      PreCacheString(&"FAVELA_INTROSCREEN_LINE_5");
      introscreen_delay();
      break;
    case "arcadia":

      PreCacheString(&"ARCADIA_INTROSCREEN_LINE_1");

      PreCacheString(&"ARCADIA_INTROSCREEN_LINE_2");

      PreCacheString(&"ARCADIA_INTROSCREEN_LINE_3");

      PreCacheString(&"ARCADIA_INTROSCREEN_LINE_4");

      PreCacheString(&"ARCADIA_INTROSCREEN_LINE_5");
      introscreen_delay();
      break;
    case "favela_escape":

      PreCacheString(&"FAVELA_ESCAPE_INTROSCREEN_LINE_1");

      PreCacheString(&"FAVELA_ESCAPE_INTROSCREEN_LINE_2");

      PreCacheString(&"FAVELA_ESCAPE_INTROSCREEN_LINE_3");

      PreCacheString(&"FAVELA_ESCAPE_INTROSCREEN_LINE_4");

      PreCacheString(&"FAVELA_ESCAPE_INTROSCREEN_LINE_5");
      introscreen_delay();
      break;
    case "estate":

      PreCacheString(&"ESTATE_INTROSCREEN_LINE_2");

      PreCacheString(&"ESTATE_INTROSCREEN_LINE_4");

      PreCacheString(&"ESTATE_INTROSCREEN_LINE_5");
      introscreen_delay();
      break;
    case "boneyard":

      PreCacheString(&"BONEYARD_INTROSCREEN_LINE_2");

      PreCacheString(&"BONEYARD_INTROSCREEN_LINE_3");

      PreCacheString(&"BONEYARD_INTROSCREEN_LINE_4");

      PreCacheString(&"BONEYARD_INTROSCREEN_LINE_5");
      introscreen_delay();
      break;

    case "af_caves":

      PreCacheString(&"AF_CAVES_LINE2");

      PreCacheString(&"AF_CAVES_LINE3");

      PreCacheString(&"AF_CAVES_LINE4");
      introscreen_delay();
      break;

    case "af_chase":

      PreCacheString(&"AF_CHASE_INTROSCREEN_LINE2");

      PreCacheString(&"AF_CHASE_INTROSCREEN_LINE3");

      PreCacheString(&"AF_CHASE_INTROSCREEN_LINE4");

      break;

    case "example":

      break;

    case "bridge":
      thread flying_intro();
      break;
    default:

      wait 0.05;
      level notify("finished final intro screen fadein");
      wait 0.05;
      level notify("starting final intro screen fadeout");
      wait 0.05;
      level notify("controls_active");
      wait 0.05;
      flag_set("introscreen_complete");
      break;
  }
}

contingency_black_screen_intro() {
  SetSavedDvar("hud_drawhud", "0");
  level.player FreezeControls(true);

  thread maps\_introscreen::introscreen_generic_black_fade_in(5.3, 1);

  lines = [];

  lines["date"] = &"CONTINGENCY_LINE2";

  lines[lines.size] = &"CONTINGENCY_LINE3";

  lines[lines.size] = &"CONTINGENCY_LINE4";

  lines[lines.size] = &"CONTINGENCY_LINE5";

  maps\_introscreen::introscreen_feed_lines(lines);

  wait 5;

  level.player FreezeControls(false);
  setSavedDvar("hud_drawhud", "1");
}

contingency_intro_text() {
  wait .2;

  lines = [];

  lines["date"] = &"CONTINGENCY_LINE2";

  lines[lines.size] = &"CONTINGENCY_LINE3";

  lines[lines.size] = &"CONTINGENCY_LINE4";

  lines[lines.size] = &"CONTINGENCY_LINE5";

  maps\_introscreen::introscreen_feed_lines(lines);
}

cliffhanger_intro_text() {
  wait 17;

  lines = [];

  lines["date"] = &"CLIFFHANGER_LINE2";

  lines[lines.size] = &"CLIFFHANGER_LINE4";

  lines[lines.size] = &"CLIFFHANGER_LINE5";

  maps\_introscreen::introscreen_feed_lines(lines);
}

introscreen_feed_lines(lines) {
  keys = GetArrayKeys(lines);

  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    interval = 1;
    time = (i * interval) + 1;
    delayThread(time, ::introscreen_corner_line, lines[key], (lines.size - i - 1), interval, key);
  }
}

introscreen_generic_black_fade_in(time, fade_time, fade_in_time) {
  introscreen_generic_fade_in("black", time, fade_time, fade_in_time);
}

introscreen_generic_white_fade_in(time, fade_time, fade_in_time) {
  introscreen_generic_fade_in("white", time, fade_time, fade_in_time);
}

introscreen_generic_fade_in(shader, pause_time, fade_out_time, fade_in_time) {
  if(!isDefined(fade_out_time)) {
    fade_out_time = 1.5;
  }

  introblack = NewHudElem();
  introblack.x = 0;
  introblack.y = 0;
  introblack.horzAlign = "fullscreen";
  introblack.vertAlign = "fullscreen";
  introblack.foreground = true;
  introblack SetShader(shader, 640, 480);

  if(isDefined(fade_in_time) && fade_in_time > 0) {
    introblack.alpha = 0;
    introblack FadeOverTime(fade_in_time);
    introblack.alpha = 1;
    wait(fade_in_time);
  }

  wait pause_time;

  if(fade_out_time > 0) {
    introblack FadeOverTime(fade_out_time);
  }

  introblack.alpha = 0;

  wait fade_out_time;
  SetSavedDvar("com_cinematicEndInWhite", 0);
}

introscreen_create_line(string) {
  index = level.introstring.size;
  yPos = (index * 30);

  if(level.console) {
    yPos -= 60;
  }

  level.introstring[index] = NewHudElem();
  level.introstring[index].x = 0;
  level.introstring[index].y = yPos;
  level.introstring[index].alignX = "center";
  level.introstring[index].alignY = "middle";
  level.introstring[index].horzAlign = "center";
  level.introstring[index].vertAlign = "middle";
  level.introstring[index].sort = 1;
  level.introstring[index].foreground = true;
  level.introstring[index].fontScale = 1.75;
  level.introstring[index] SetText(string);
  level.introstring[index].alpha = 0;
  level.introstring[index] FadeOverTime(1.2);
  level.introstring[index].alpha = 1;
}

introscreen_fadeOutText() {
  for(i = 0; i < level.introstring.size; i++) {
    level.introstring[i] FadeOverTime(1.5);
    level.introstring[i].alpha = 0;
  }

  wait 1.5;

  for(i = 0; i < level.introstring.size; i++) {
    level.introstring[i] Destroy();
  }
}

introscreen_delay(string1, string2, string3, string4, pausetime1, pausetime2, timebeforefade) {
  waittillframeend;
  waittillframeend;

  skipIntro = !is_default_start();
  if(GetDebugDvar("introscreen") == "0") {
    skipIntro = true;
  }

  if(skipIntro) {
    waittillframeend;
    level notify("finished final intro screen fadein");
    waittillframeend;
    level notify("starting final intro screen fadeout");
    waittillframeend;
    level notify("controls_active");
    waittillframeend;
    flag_set("introscreen_complete");
    flag_set("pullup_weapon");
    return;
  }

  if(flying_intro()) {
    return;
  }

  switch (level.script) {
    case "airport":
      airport_intro();
      return;
    case "favela":
      favela_intro();
      return;
    case "favela_escape":
      favela_escape_intro();
      return;
    case "arcadia":
      arcadia_intro();
      return;
    case "oilrig":
      oilrig_intro();
      return;
    case "dcburning":
      dcburning_intro();
      return;
    case "trainer":
      trainer_intro();
      return;
    case "dcemp":
      dcemp_intro();
      return;
    case "dc_whitehouse":
      dc_whitehouse_intro();
      return;
    case "gulag":
      flag_set("introscreen_complete");
      return;
    case "af_caves":
      af_caves_intro();
      return;
    case "roadkill":
      return;
  }

  level.introblack = NewHudElem();
  level.introblack.x = 0;
  level.introblack.y = 0;
  level.introblack.horzAlign = "fullscreen";
  level.introblack.vertAlign = "fullscreen";
  level.introblack.foreground = true;
  level.introblack SetShader("black", 640, 480);

  level.player FreezeControls(true);
  wait .05;

  level.introstring = [];

  if(isDefined(string1)) {
    introscreen_create_line(string1);
  }

  if(isDefined(pausetime1)) {
    wait pausetime1;
  } else {
    wait 2;
  }

  if(isDefined(string2)) {
    introscreen_create_line(string2);
  }
  if(isDefined(string3)) {
    introscreen_create_line(string3);
  }

  if(isDefined(string4)) {
    if(isDefined(pausetime2)) {
      wait pausetime2;
    } else {
      wait 2;
    }
  }

  if(isDefined(string4)) {
    introscreen_create_line(string4);
  }

  level notify("finished final intro screen fadein");

  if(isDefined(timebeforefade)) {
    wait timebeforefade;
  } else {
    wait 3;
  }

  level.introblack FadeOverTime(1.5);
  level.introblack.alpha = 0;

  level notify("starting final intro screen fadeout");

  level.player FreezeControls(false);
  level notify("controls_active");

  introscreen_fadeOutText();

  flag_set("introscreen_complete");
}

_CornerLineThread(string, size, interval, index_key) {
  level notify("new_introscreen_element");

  if(!isDefined(level.intro_offset)) {
    level.intro_offset = 0;
  } else {
    level.intro_offset++;
  }

  y = _CornerLineThread_height();

  hudelem = NewHudElem();
  hudelem.x = 20;
  hudelem.y = y;
  hudelem.alignX = "left";
  hudelem.alignY = "bottom";
  hudelem.horzAlign = "left";
  hudelem.vertAlign = "bottom";
  hudelem.sort = 1;
  hudelem.foreground = true;
  hudelem SetText(string);
  hudelem.alpha = 0;
  hudelem FadeOverTime(0.2);
  hudelem.alpha = 1;

  hudelem.hidewheninmenu = true;
  hudelem.fontScale = 2.0;
  hudelem.color = (0.8, 1.0, 0.8);
  hudelem.font = "objective";
  hudelem.glowColor = (0.3, 0.6, 0.3);
  hudelem.glowAlpha = 1;
  duration = Int((size * interval * 1000) + 4000);
  hudelem SetPulseFX(30, duration, 700);

  thread hudelem_destroy(hudelem);

  if(!isDefined(index_key)) {
    return;
  }
  if(!isstring(index_key)) {
    return;
  }
  if(index_key != "date") {
    return;
  }
}

_CornerLineThread_height() {
  return (((level.intro_offset) * 20) - 82);
}

introscreen_corner_line(string, size, interval, index_key) {
  thread _CornerLineThread(string, size, interval, index_key);
}

hudelem_destroy(hudelem) {
  wait(level.linefeed_delay);
  hudelem notify("destroying");
  level.intro_offset = undefined;

  time = .5;
  hudelem FadeOverTime(time);
  hudelem.alpha = 0;
  wait time;
  hudelem notify("destroy");
  hudelem Destroy();
}

cargoship_intro_dvars() {
  wait(0.05);
  SetSavedDvar("compass", 0);
  SetSavedDvar("ammoCounterHide", "1");
  SetSavedDvar("hud_showStance", 0);
  SetSavedDvar("hud_drawhud", "0");
}

favela_intro() {
  level.player FreezeControls(true);

  SaveGame("levelstart", &"AUTOSAVE_LEVELSTART", "whatever", true);

  thread introscreen_generic_black_fade_in(5.0);

  lines = [];

  lines[lines.size] = &"FAVELA_INTROSCREEN_LINE_1";

  lines["date"] = &"FAVELA_INTROSCREEN_LINE_2";

  lines[lines.size] = &"FAVELA_INTROSCREEN_LINE_3";

  lines[lines.size] = &"FAVELA_INTROSCREEN_LINE_4";

  lines[lines.size] = &"FAVELA_INTROSCREEN_LINE_5";

  introscreen_feed_lines(lines);

  wait(5.0);
  level notify("introscreen_complete");

  level.player FreezeControls(false);
}

favela_escape_intro() {
  level.player FreezeControls(true);

  SaveGame("levelstart", &"AUTOSAVE_LEVELSTART", "whatever", true);

  blacktime = 6;
  thread introscreen_generic_black_fade_in(blacktime);
  thread flag_set_delayed("introscreen_start_dialogue", 1.0);

  lines = [];

  lines[lines.size] = &"FAVELA_ESCAPE_INTROSCREEN_LINE_1";

  lines["date"] = &"FAVELA_ESCAPE_INTROSCREEN_LINE_2";

  lines[lines.size] = &"FAVELA_ESCAPE_INTROSCREEN_LINE_3";

  lines[lines.size] = &"FAVELA_ESCAPE_INTROSCREEN_LINE_4";

  lines[lines.size] = &"FAVELA_ESCAPE_INTROSCREEN_LINE_5";

  introscreen_feed_lines(lines);

  wait(blacktime);
  level notify("introscreen_complete");

  level.player FreezeControls(false);
}

arcadia_intro() {
  level.player FreezeControls(true);

  SaveGame("levelstart", &"AUTOSAVE_LEVELSTART", "whatever", true);

  thread introscreen_generic_black_fade_in(5.0);

  lines = [];

  lines[lines.size] = &"ARCADIA_INTROSCREEN_LINE_1";

  lines["date"] = &"ARCADIA_INTROSCREEN_LINE_2";

  lines[lines.size] = &"ARCADIA_INTROSCREEN_LINE_3";

  lines[lines.size] = &"ARCADIA_INTROSCREEN_LINE_4";

  lines[lines.size] = &"ARCADIA_INTROSCREEN_LINE_5";

  introscreen_feed_lines(lines);

  wait(5.0);
  level notify("introscreen_complete");

  level.player FreezeControls(false);
}

boneyard_intro() {
  lines = [];

  lines[lines.size] = &"BONEYARD_INTROSCREEN_LINE_1";
  lines["date"] = &"BONEYARD_INTROSCREEN_LINE_2";

  lines[lines.size] = &"BONEYARD_INTROSCREEN_LINE_3";

  lines[lines.size] = &"BONEYARD_INTROSCREEN_LINE_4";

  lines[lines.size] = &"BONEYARD_INTROSCREEN_LINE_5";

  introscreen_feed_lines(lines);

  level notify("introscreen_complete");
}

estate_intro() {
  lines = [];

  lines[lines.size] = &"ESTATE_INTROSCREEN_LINE_1";

  lines["date"] = &"ESTATE_INTROSCREEN_LINE_2";

  lines[lines.size] = &"ESTATE_INTROSCREEN_LINE_4";

  lines[lines.size] = &"ESTATE_INTROSCREEN_LINE_5";

  introscreen_feed_lines(lines);

  level notify("introscreen_complete");
}

airport_intro() {
  level.player FreezeControls(true);

  SaveGame("levelstart", &"AUTOSAVE_LEVELSTART", "whatever", true);

  time = 21 + 5.5;

  lines = [];

  lines["date"] = &"AIRPORT_LINE2";

  lines[lines.size] = &"AIRPORT_LINE3";

  lines[lines.size] = &"AIRPORT_LINE4";

  lines[lines.size] = &"AIRPORT_LINE5";

  delayThread(10.25 + 5.5, ::introscreen_feed_lines, lines);

  wait(time);

  wait 1;

  if(!flag("do_not_save")) {
    thread autosave_now_silent();
  }

  level notify("introscreen_complete");

  level.player FreezeControls(false);
}

oilrig_intro_dvars() {
  SetSavedDvar("ui_hidemap", 1);
  SetSavedDvar("hud_showStance", "0");
  SetSavedDvar("compass", "0");

  SetSavedDvar("ammoCounterHide", "1");
  SetSavedDvar("g_friendlyNameDist", 0);
}

oilrig_intro() {
  if(!level.underwater) {
    return;
  }
  thread oilrig_intro_dvars();
  level.player FreezeControls(true);
  flag_wait("open_dds_door");
  wait(2);
  level.player FreezeControls(false);
}

oilrig_intro2() {
  lines = [];

  lines[lines.size] = &"OILRIG_INTROSCREEN_LINE_1";

  lines[lines.size] = &"OILRIG_INTROSCREEN_LINE_3";

  lines[lines.size] = &"OILRIG_INTROSCREEN_LINE_4";

  lines[lines.size] = &"OILRIG_INTROSCREEN_LINE_5";

  introscreen_feed_lines(lines);
}

char_museum_intro() {
  lines = [];

  lines[lines.size] = &"CHAR_MUSEUM_LINE1";

  lines[lines.size] = &"CHAR_MUSEUM_LINE3";

  lines[lines.size] = &"CHAR_MUSEUM_LINE4";

  introscreen_feed_lines(lines);
}

estate_intro2() {
  lines = [];

  lines[lines.size] = &"ESTATE_INTROSCREEN_LINE_1";
  lines["date"] = &"ESTATE_INTROSCREEN_LINE_2";
  lines[lines.size] = &"ESTATE_INTROSCREEN_LINE_4";
  lines[lines.size] = &"ESTATE_INTROSCREEN_LINE_5";
}

dcburning_intro() {
  level.player DisableWeapons();
  thread dcburningIntroDvars();
  level.mortar_min_dist = 1;
  level.player FreezeControls(true);

  introblack = NewHudElem();
  introblack.x = 0;
  introblack.y = 0;
  introblack.horzAlign = "fullscreen";
  introblack.vertAlign = "fullscreen";
  introblack.foreground = true;
  introblack SetShader("black", 640, 480);
  wait 4.25;

  wait 3;

  level notify("black_fading");
  level.mortar_min_dist = undefined;
  introblack FadeOverTime(1.5);
  introblack.alpha = 0;

  wait(1.5);
  flag_set("introscreen_complete");

  level notify("introscreen_complete");
  level.player FreezeControls(false);
  level.player EnableWeapons();
  wait(.5);

  SetSavedDvar("compass", 1);
  SetSavedDvar("ammoCounterHide", "0");
  SetSavedDvar("hud_showStance", 1);

  flag_wait("player_exiting_start_trench");

  lines = [];

  lines[lines.size] = &"DCBURNING_INTROSCREEN_1";

  lines[lines.size] = &"DCBURNING_INTROSCREEN_3";

  lines[lines.size] = &"DCBURNING_INTROSCREEN_4";

  lines[lines.size] = &"DCBURNING_INTROSCREEN_5";

  introscreen_feed_lines(lines);
}

dcemp_intro() {
  flag_wait("player_crash_done");

  lines = [];

  lines[lines.size] = &"DCEMP_INTROSCREEN_1";

  lines[lines.size] = &"DCEMP_INTROSCREEN_2";

  lines[lines.size] = &"DCEMP_INTROSCREEN_3";

  lines[lines.size] = &"DCEMP_INTROSCREEN_4";

  lines[lines.size] = &"DCEMP_INTROSCREEN_5";

  wait 1;
  maps\_introscreen::introscreen_feed_lines(lines);

  flag_set("introscreen_complete");
}

dc_whitehouse_intro() {
  level.player DisableWeapons();
  level.player FreezeControls(true);

  SaveGame("levelstart", &"AUTOSAVE_LEVELSTART", "whatever", true);

  thread introscreen_generic_black_fade_in(5.0);

  lines = [];

  lines[lines.size] = &"DC_WHITEHOUSE_INTROSCREEN_1";

  lines["date"] = &"DC_WHITEHOUSE_INTROSCREEN_2";

  lines[lines.size] = &"DC_WHITEHOUSE_INTROSCREEN_3";

  lines[lines.size] = &"DC_WHITEHOUSE_INTROSCREEN_4";

  lines[lines.size] = &"DC_WHITEHOUSE_INTROSCREEN_5";

  introscreen_feed_lines(lines);

  wait(5.0);
  level notify("introscreen_complete");

  level.player FreezeControls(false);
  level.player EnableWeapons();
}

dcburningIntroDvars() {
  wait(0.05);
  SetSavedDvar("compass", 0);
  SetSavedDvar("ammoCounterHide", "1");
  SetSavedDvar("hud_showStance", 0);
}

trainerIntroDvars() {
  SetSavedDvar("compass", 0);
  SetSavedDvar("ammoCounterHide", "1");
  SetSavedDvar("hud_showStance", 0);
}

trainer_intro() {
  thread trainerIntroDvars();
  level.player FreezeControls(true);

  introblack = NewHudElem();
  introblack.x = 0;
  introblack.y = 0;
  introblack.horzAlign = "fullscreen";
  introblack.vertAlign = "fullscreen";
  introblack.foreground = true;
  introblack SetShader("black", 640, 480);
  lines = [];

  lines[lines.size] = &"TRAINER_INTROSCREEN_LINE_2";

  lines[lines.size] = &"TRAINER_INTROSCREEN_LINE_3";

  lines[lines.size] = &"TRAINER_INTROSCREEN_LINE_4";

  lines[lines.size] = &"TRAINER_INTROSCREEN_LINE_5";

  introscreen_feed_lines(lines);

  wait(10);

  level notify("black_fading");
  introblack FadeOverTime(2);
  introblack.alpha = 0;
  flag_set("start_anims");
  wait(2);
  flag_set("introscreen_complete");

  level notify("introscreen_complete");
  level.player FreezeControls(false);
  wait(.5);

  SetSavedDvar("compass", 1);
  SetSavedDvar("ammoCounterHide", "0");
  SetSavedDvar("hud_showStance", 1);
}

af_caves_intro() {
  SetSavedDvar("compass", 0);

  level.introblack = NewHudElem();
  level.introblack.x = 0;
  level.introblack.y = 0;
  level.introblack.horzAlign = "fullscreen";
  level.introblack.vertAlign = "fullscreen";
  level.introblack.foreground = false;
  level.introblack SetShader("black", 640, 480);

  wait(0.05);

  flag_set("intro_dialogue_start");

  flag_wait("intro_fade_in");

  fadeTime = 3;
  level.introblack FadeOverTime(fadeTime);
  level.introblack.alpha = 0;
  wait(fadeTime);
  level.introblack Destroy();

  SetSavedDvar("compass", 1);

  flag_set("intro_faded_in");

  thread autosave_by_name("intro");

  flag_wait("introscreen_feed_lines");

  lines = [];

  lines["date"] = &"AF_CAVES_LINE2";

  lines[lines.size] = &"AF_CAVES_LINE3";

  lines[lines.size] = &"AF_CAVES_LINE4";

  level thread maps\_introscreen::introscreen_feed_lines(lines);
}

af_chase_intro() {
  lines = [];

  lines["date"] = &"AF_CHASE_INTROSCREEN_LINE2";

  lines[lines.size] = &"AF_CHASE_INTROSCREEN_LINE3";

  lines[lines.size] = &"AF_CHASE_INTROSCREEN_LINE4";

  introscreen_feed_lines(lines);

  thread autosave_by_name("intro");
}

bog_intro_sound() {
  wait(0.05);

  SetSavedDvar("compass", 0);
  SetSavedDvar("ammoCounterHide", "1");
  SetSavedDvar("hud_showstance", "0");
  SetSavedDvar("actionSlotsHide", "1");
}

feedline_delay() {
  wait(2);
}

flying_intro() {
  flying_levels = [];
  flying_levels["killhouse"] = true;
  flying_levels["cliffhanger"] = true;

  flying_levels["estate"] = true;

  if(!getdvarint("newintro")) {
    flying_levels["roadkill"] = true;
  }

  flying_levels["boneyard"] = true;

  override_angles = isDefined(level.customIntroAngles);

  if(!isDefined(flying_levels[level.script])) {
    return false;
  }

  if(!isDefined(level.dontReviveHud)) {
    thread revive_ammo_counter();
  }

  thread bog_intro_sound();
  thread weapon_pullout();

  level.player FreezeControls(true);
  feedline_delay_func = ::feedline_delay;

  zoomHeight = 16000;
  slamzoom = true;

  if(getDvar("slamzoom") != "") {
    slamzoom = false;
  }

  extra_delay = 0;
  special_save = false;

  if(slamzoom) {
    lines = [];
    switch (level.script) {
      case "killhouse":
        special_save = true;

        CinematicInGameSync("killhouse_fade");
        lines = [];

        lines[lines.size] = &"KILLHOUSE_INTROSCREEN_LINE_1";

        lines[lines.size] = &"KILLHOUSE_INTROSCREEN_LINE_3";

        lines[lines.size] = &"KILLHOUSE_INTROSCREEN_LINE_4";

        lines[lines.size] = &"KILLHOUSE_INTROSCREEN_LINE_5";
        break;

      case "estate":

        cinematicingamesync("estate_fade");
        lines = [];

        zoomHeight = 3500;
        SetSavedDvar("sm_sunSampleSizeNear", 0.6);
        delayThread(0.5, ::ramp_out_sunsample_over_time, 0.9);
        break;

      case "boneyard":

        cinematicingamesync("boneyard_fade");
        lines = [];
        SetSavedDvar("sm_sunSampleSizeNear", 0.6);
        delayThread(0.5, ::ramp_out_sunsample_over_time, 0.9);
        zoomHeight = 4000;
        break;

      case "roadkill":
        thread introscreen_generic_black_fade_in(0.05);
        lines = [];

        lines[lines.size] = &"ROADKILL_LINE_1";

        lines[lines.size] = &"ROADKILL_LINE_2";

        lines[lines.size] = &"ROADKILL_LINE_3";

        lines[lines.size] = &"ROADKILL_LINE_4";

        lines[lines.size] = &"ROADKILL_LINE_5";
        feedline_delay = 21;

        feedline_delay_func = level.roadkill_feedline_delay;
        SetSavedDvar("sm_sunSampleSizeNear", 2.0);
        delayThread(0.6, ::ramp_out_sunsample_over_time, 1.4);
        break;
    }

    add_func(feedline_delay_func);
    add_func(::introscreen_feed_lines, lines);
    thread do_funcs();
  }

  origin = level.player.origin;

  level.player PlayerSetStreamOrigin(origin);

  level.player.origin = origin + (0, 0, zoomHeight);
  ent = spawn("script_model", (69, 69, 69));
  ent.origin = level.player.origin;

  ent setModel("tag_origin");

  if(override_angles) {
    ent.angles = (0, level.customIntroAngles[1], 0);
  } else {
    ent.angles = level.player.angles;
  }

  level.player PlayerLinkTo(ent, undefined, 1, 0, 0, 0, 0);
  ent.angles = (ent.angles[0] + 89, ent.angles[1], 0);

  wait(extra_delay);
  ent MoveTo(origin + (0, 0, 0), 2, 0, 2);

  wait(1.00);
  wait(0.5);

  if(override_angles) {
    ent RotateTo(level.customIntroAngles, 0.5, 0.3, 0.2);
  } else {
    ent RotateTo((ent.angles[0] - 89, ent.angles[1], 0), 0.5, 0.3, 0.2);
  }

  if(!special_save) {}
  SaveGame("levelstart", &"AUTOSAVE_LEVELSTART", "whatever", true);
  wait(0.5);
  flag_set("pullup_weapon");

  wait(0.2);
  level.player Unlink();
  level.player FreezeControls(false);

  level.player PlayerClearStreamOrigin();

  thread play_sound_in_space("ui_screen_trans_in", level.player.origin);

  wait(0.2);

  thread play_sound_in_space("ui_screen_trans_out", level.player.origin);

  wait(0.2);

  flag_set("introscreen_complete");

  wait(2);

  ent Delete();

  return true;
}

weapon_pullout() {
  weap = level.player GetWeaponsListAll()[0];
  level.player DisableWeapons();
  flag_wait("pullup_weapon");
  level.player EnableWeapons();
}

revive_ammo_counter() {
  flag_wait("safe_for_objectives");
  if(!isDefined(level.nocompass)) {
    SetSavedDvar("compass", 1);
  }
  SetSavedDvar("ammoCounterHide", "0");
  SetSavedDvar("actionSlotsHide", "0");
  SetSavedDvar("hud_showstance", "1");
}

ramp_out_sunsample_over_time(time, base_sample_size) {
  sample_size = GetDvarFloat("sm_sunSampleSizeNear");
  if(!isDefined(base_sample_size)) {
    base_sample_size = 0.25;
  }

  range = sample_size - base_sample_size;

  frames = time * 20;
  for(i = 0; i <= frames; i++) {
    dif = i / frames;
    dif = 1 - dif;
    current_range = dif * range;
    current_sample_size = base_sample_size + current_range;
    SetSavedDvar("sm_sunSampleSizeNear", current_sample_size);
    wait(0.05);
  }
}