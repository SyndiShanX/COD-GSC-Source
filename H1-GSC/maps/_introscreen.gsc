/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_introscreen.gsc
********************************/

main() {
  if(isdefined(level.credits_active))
    return 0;

  introscreen_init();

  if(!introscreen_should_activate()) {
    simple_intro();
    return;
  }

  initialize_strings();
  activate_intro();
}

introscreen_init() {
  common_scripts\utility::flag_init("pullup_weapon");
  common_scripts\utility::flag_init("introscreen_activate");
  common_scripts\utility::flag_init("introscreen_remove_submix");
  common_scripts\utility::flag_init("introscreen_complete");
  common_scripts\utility::flag_init("safe_for_objectives");
  maps\_utility::delaythread(10, common_scripts\utility::flag_set, "safe_for_objectives");
  level.linefeed_delay = 16;
  level.background_sort = 1000;
  level.intro_text_sort = 1001;
  precacheshader("black");
  precacheshader("white");

  if(getdvar("introscreen") == "")
    setdvar("introscreen", "1");

  waittillframeend;
  waittillframeend;
}

introscreen_should_activate() {
  if(!introscreen_is_enabled())
    return 0;

  if(!maps\_utility::is_h1_level())
    return 0;

  return 1;
}

introscreen_is_enabled() {
  if(getdvar("beautiful_corner") == "1")
    return 0;

  return 1;
}

activate_intro() {
  if(should_revive_ammo_counter())
    thread revive_ammo_counter();

  common_scripts\utility::flag_set("introscreen_activate");

  switch (level.script) {
    case "ac130":
      ac130_intro();
      break;
    case "aftermath":
      aftermath_intro();
      break;
    case "airlift":
      airlift_intro();
      break;
    case "ambush":
      ambush_intro();
      break;
    case "armada":
      armada_intro();
      break;
    case "cargoship":
      cargoship_intro();
      break;
    case "hunted":
      hunted_intro();
      break;
    case "jeepride":
      jeepride_intro();
      break;
    case "launchfacility_b":
      launchfacility_b_intro();
      break;
    case "scoutsniper":
      scoutsniper_intro();
      break;
    case "village_defend":
      village_defend_intro();
      break;
    case "village_assault":
    case "launchfacility_a":
    case "killhouse":
    case "icbm":
    case "bog_b":
    case "bog_a":
    case "blackout":
      flying_intro();
      break;
    case "simplecredits":
    case "sniperescape":
    case "coup":
    case "airplane":
      simple_intro();
      break;
  }
}

simple_intro() {
  waittillframeend;
  waittillframeend;
  waittillframeend;
  waittillframeend;
  common_scripts\utility::flag_set("introscreen_remove_submix");
  common_scripts\utility::flag_set("introscreen_complete");
}

flying_intro_dvars() {
  wait 0.05;
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("hud_showstance", 0);
  setsaveddvar("actionSlotsHide", 1);
}

flying_intro() {
  thread flying_intro_dvars();
  thread weapon_pullout();
  level.player freezecontrols(1);
  var_0 = 16000;
  var_1 = 1;
  var_2 = 0;
  var_3 = 0;

  if(var_1) {
    switch (level.script) {
      case "bog_a":
        cinematicingamesync("bog_a_fade");
        break;
      case "bog_b":
        var_2 = 2.0;
        var_0 = 6500;
        cinematicingamesync("bog_b_fade");
        break;
      case "blackout":
        var_0 = 4000;
        cinematicingamesync("blackout_fade");
        break;
      case "killhouse":
        var_0 = 0;
        var_3 = 1;
        cinematicingamesync("killhouse_fade");
        break;
      case "icbm":
        var_2 = 0.6;
        cinematicingamesync("icbm_fade");
        break;
      case "launchfacility_a":
        cinematicingamesync("launchfacility_a_fade");
        break;
      case "village_assault":
        cinematicingamesync("village_assault_fade");
        break;
    }

    introscreen_feed_lines(level.introscreen_lines);
  }

  thread flying_intro_force_streaming_center(level.player.origin);
  var_4 = level.player.origin;
  level.player.origin = var_4 + (0, 0, var_0);
  var_5 = spawn("script_model", (69, 69, 69));
  var_5.origin = level.player.origin;
  var_5 setmodel("tag_origin");
  var_5.angles = level.player.angles;
  level.player playerlinktoabsolute(var_5);
  var_5.angles = (var_5.angles[0] + 89, var_5.angles[1], 0);
  wait(var_2);
  var_5 moveto(var_4 + (0, 0, 0), 2, 0, 2);
  common_scripts\utility::flag_set("introscreen_remove_submix");
  wait 1.2;
  wait 0.3;
  var_5 rotateto((var_5.angles[0] - 89, var_5.angles[1], 0), 0.5, 0.3, 0.2);

  if(!var_3)
    savegame("levelstart", & "AUTOSAVE_LEVELSTART", "whatever", 1);

  wait 0.5;
  common_scripts\utility::flag_set("pullup_weapon");
  wait 0.2;
  level.player unlink();
  level.player freezecontrols(0);
  thread common_scripts\utility::play_sound_in_space("ui_screen_trans_in", level.player.origin);
  wait 0.2;
  thread common_scripts\utility::play_sound_in_space("ui_screen_trans_out", level.player.origin);
  wait 0.2;
  common_scripts\utility::flag_set("introscreen_complete");
  wait 2;
  var_5 delete();
}

flying_intro_force_streaming_center(var_0) {
  self endon("introscreen_complete");

  for (;;) {
    level.player playersetstreamorigin(var_0);
    wait 0.01;
  }
}

cargoship_intro_dvars() {
  wait 0.05;
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", "1");
  setsaveddvar("hud_showStance", 0);
  setsaveddvar("hud_drawhud", "0");
}

cargoship_intro() {
  thread cargoship_intro_dvars();
  level.player freezecontrols(1);
  cinematicingamesync("cargoship_fade");
  wait 0.4;
  level notify("intro_movie_done");
  savegame("levelstart", & "AUTOSAVE_LEVELSTART", "whatever", 1);
  common_scripts\utility::flag_set("introscreen_remove_submix");
  introscreen_generic_white_fade_in(1.75);
  introscreen_feed_lines(level.introscreen_lines);
  wait 1;
  level.player freezecontrols(0);
  common_scripts\utility::flag_set("introscreen_complete");
  level.player freezecontrols(0);
}

jeepride_intro() {
  level.player freezecontrols(1);
  cinematicingamesync("jeepride_fade");
  introscreen_feed_lines(level.introscreen_lines);
  savegame("levelstart", & "AUTOSAVE_LEVELSTART", "whatever", 1);
  common_scripts\utility::flag_set("introscreen_complete");
  level.player freezecontrols(0);
}

airlift_intro_dvars() {
  wait 0.05;
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", "1");
}

airlift_intro() {
  thread airlift_intro_dvars();
  level.player freezecontrols(1);
  cinematicingamesync("airlift_fade");
  introscreen_feed_lines(level.introscreen_lines);
  wait 2;
  savegame("levelstart", & "AUTOSAVE_LEVELSTART", "whatever", 1);
  level notify("introscreen_black");
  var_0 = newhudelem();
  var_0.x = 0;
  var_0.y = 0;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.foreground = 1;
  var_0.sort = level.background_sort;
  var_0 setshader("white", 640, 480);
  wait 1;
  var_0 fadeovertime(1.5);
  var_0.alpha = 0;
  common_scripts\utility::flag_set("introscreen_remove_submix");
  wait 1;
  common_scripts\utility::flag_set("introscreen_complete");
  thread maps\_utility::autosave_now(1);
  level.player freezecontrols(0);
}

village_defend_intro_dvars() {
  wait 0.05;
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", "1");
}

village_defend_intro() {
  thread village_defend_intro_dvars();
  level.player freezecontrols(1);
  var_0 = newhudelem();
  var_0.x = 0;
  var_0.y = 0;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.foreground = 1;
  var_0.sort = level.background_sort;
  var_0 setshader("black", 640, 480);
  wait 0.25;
  var_1 = newhudelem();
  var_1.x = 0;
  var_1.y = 0;
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.horzalign = "center";
  var_1.vertalign = "middle";
  var_1.sort = level.intro_text_sort;
  var_1.foreground = 1;
  var_1 settext(&"VILLAGE_DEFEND_PRESENT_DAY");
  var_1.fontscale = 1.6;
  var_1.color = (0.8, 1, 0.8);
  var_1.font = "objective";
  var_1.glowcolor = (0.26, 0.65, 0.32);
  var_1.glowalpha = 0.2;
  var_1 setpulsefx(30, 8000, 700);
  wait 8.8;
  introscreen_feed_lines(level.introscreen_lines);
  wait 10;
  savegame("levelstart", & "AUTOSAVE_LEVELSTART", "whatever", 1);
  common_scripts\utility::flag_set("introscreen_remove_submix");
  var_0 fadeovertime(1.5);
  var_0.alpha = 0;
  wait 1;
  level.player freezecontrols(0);
  setsaveddvar("compass", 1);
  setsaveddvar("ammoCounterHide", "0");
  setsaveddvar("hud_showStance", 1);
  common_scripts\utility::flag_set("introscreen_complete");
  level.player freezecontrols(0);
}

scoutsniper_intro() {
  thread scoutsniperintrodvars();
  thread scoutsniperintroplayer();
  cinematicingamesync("scoutsniper_fade");
  wait 4;
  maps\_utility::set_vision_set("grayscale");
  savegame("levelstart", & "AUTOSAVE_LEVELSTART", "whatever", 1);
  var_0 = newhudelem();
  var_0.x = 0;
  var_0.y = 0;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.foreground = 1;
  var_0.sort = level.background_sort;
  var_0 setshader("black", 640, 480);
  wait 0.25;
  var_1 = newhudelem();
  var_1.x = 0;
  var_1.y = 0;
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.horzalign = "center";
  var_1.vertalign = "middle";
  var_1.sort = level.intro_text_sort;
  var_1.foreground = 1;
  var_1 settext(&"SCOUTSNIPER_15_YEARS_AGO");
  var_1.fontscale = 1.6;
  var_1.color = (0.8, 1, 0.8);
  var_1.font = "objective";
  var_1.glowcolor = (0.26, 0.65, 0.32);
  var_1.glowalpha = 0.2;
  var_1 setpulsefx(30, 2000, 700);
  wait 2;
  introscreen_feed_lines(level.introscreen_lines);
  wait 1;
  var_0 fadeovertime(1.5);
  var_0.alpha = 0;
  common_scripts\utility::flag_set("introscreen_remove_submix");
  wait 4.5;
  maps\_utility::set_vision_set("scoutsniper_start", 1);
  wait 8.0;
  common_scripts\utility::flag_set("introscreen_complete");
  level.player freezecontrols(0);
  wait 0.5;
  setsaveddvar("compass", 1);
  setsaveddvar("ammoCounterHide", "0");
  setsaveddvar("hud_showStance", 1);
}

scoutsniperintroplayer() {
  var_0 = level.player getplayerangles();
  wait 1;
  level.player setstance("crouch");
  level.player freezecontrols(1);
  level.player setplayerangles(var_0);
}

scoutsniperintrodvars() {
  wait 0.05;
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", "1");
  setsaveddvar("hud_showStance", 0);
}

ac130_intro() {
  level.player freezecontrols(1);
  introscreen_feed_lines(level.introscreen_lines);
  level notify("introscreen_black");
  savegame("levelstart", & "AUTOSAVE_LEVELSTART", "whatever", 1);
  var_0 = newhudelem();
  var_0.x = 0;
  var_0.y = 0;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.foreground = 1;
  var_0.sort = level.background_sort;
  var_0 setshader("black", 640, 480);
  wait 4.0;
  level notify("introscreen_almost_complete");
  wait 1.5;
  level notify("introscreen_fading_out");
  var_0 fadeovertime(1.5);
  var_0.alpha = 0;
  wait 1;
  level.player freezecontrols(0);
  setsaveddvar("hud_showStance", 0);
  common_scripts\utility::flag_set("introscreen_complete");
  level.player freezecontrols(0);
}

aftermath_intro() {
  cinematicingamesync("black");
  common_scripts\utility::flag_set("introscreen_complete");
}

hunted_intro_dvars() {
  wait 0.05;
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", "1");
}

hunted_intro() {
  thread hunted_intro_dvars();
  level.player freezecontrols(1);
  introscreen_feed_lines(level.introscreen_lines);
  cinematicingamesync("hunted_fade");
  wait 1;
  savegame("levelstart", & "AUTOSAVE_LEVELSTART", "whatever", 1);
  common_scripts\utility::flag_set("introscreen_remove_submix");
  introscreen_generic_white_fade_in(2);
  savegame("levelstart", & "AUTOSAVE_LEVELSTART", "whatever", 1);
  wait 1;
  level.player freezecontrols(0);
  common_scripts\utility::flag_set("introscreen_complete");
  level.player freezecontrols(0);
}

launchfacility_b_intro_dvars() {
  wait 0.05;
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", "1");
  setsaveddvar("actionSlotsHide", "1");
  setsaveddvar("hud_showstance", "0");
  thread revive_ammo_counter();
}

launchfacility_b_intro() {
  thread launchfacility_b_intro_dvars();
  level.player freezecontrols(1);
  introscreen_feed_lines(level.introscreen_lines);
  introscreen_generic_white_fade_in(1);
  common_scripts\utility::flag_set("introscreen_remove_submix");
  savegame("levelstart", & "AUTOSAVE_LEVELSTART", "whatever", 1);
  wait 1;
  level.player freezecontrols(0);
  common_scripts\utility::flag_set("introscreen_complete");
  level.player freezecontrols(0);
}

ambush_intro_dvars() {
  wait 0.05;
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", "1");
}

ambush_intro() {
  thread ambush_intro_dvars();
  level.player freezecontrols(1);
  introscreen_feed_lines(level.introscreen_lines);
  cinematicingamesync("ambush_fade");
  wait 2;
  savegame("levelstart", & "AUTOSAVE_LEVELSTART", "whatever", 1);
  introscreen_generic_white_fade_in(2);
  common_scripts\utility::flag_set("introscreen_remove_submix");
  thread maps\_utility::autosave_now(1);
  setsaveddvar("compass", 1);
  setsaveddvar("ammoCounterHide", "0");
  setsaveddvar("hud_showStance", 1);
  wait 1;
  level.player freezecontrols(0);
  common_scripts\utility::flag_set("introscreen_complete");
  level.player freezecontrols(0);
}

armada_intro() {
  setsaveddvar("hud_drawhud", "0");
  level.player disableweapons();
  introscreen_generic_black_fade_in(0.2, 0.2);
  introscreen_feed_lines(level.introscreen_lines);
  wait 3;
  level.player freezecontrols(0);
  wait 2;
  common_scripts\utility::flag_set("introscreen_complete");
  wait 2;
  maps\_utility::autosave_by_name("levelstart");
  wait 4;
  level.player enableweapons();
}

introscreen_feed_lines(var_0) {
  var_1 = getarraykeys(var_0);

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = 1;
    var_5 = var_2 * var_4 + 1;
    maps\_utility::delaythread(var_5, ::introscreen_corner_line, var_0[var_3], var_0.size - var_2 - 1, var_4, var_3);
  }
}

introscreen_generic_black_fade_in(var_0, var_1) {
  introscreen_generic_fade_in("black", var_0, var_1);
}

introscreen_generic_white_fade_in(var_0, var_1) {
  introscreen_generic_fade_in("white", var_0, var_1);
}

introscreen_generic_fade_in(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = 1.5;

  var_3 = newhudelem();
  var_3.x = 0;
  var_3.y = 0;
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  var_3.foreground = 1;
  var_3.sort = level.background_sort;
  var_3 setshader(var_0, 640, 480);
  wait(var_1);
  var_3 fadeovertime(1.5);
  var_3.alpha = 0;
}

introscreen_create_line(var_0) {
  var_1 = level.introstring.size;
  var_2 = var_1 * 30;

  if(level.console)
    var_2 = var_2 - 60;

  var_3 = newhudelem();
  var_3.x = 0;
  var_3.y = var_2;
  var_3.alignx = "center";
  var_3.aligny = "middle";
  var_3.horzalign = "center";
  var_3.vertalign = "middle";
  var_3.sort = level.intro_text_sort;
  var_3.foreground = 1;
  var_3.fontscale = 1.75;
  var_3 settext(var_0);
  var_3.alpha = 0;
  var_3 fadeovertime(1.2);
  var_3.alpha = 1;
  common_scripts\utility::array_insert(level.introstring, var_3, 0);
}

introscreen_fadeouttext() {
  for (var_0 = 0; var_0 < level.introstring.size; var_0++) {
    level.introstring[var_0] fadeovertime(1.5);
    level.introstring[var_0].alpha = 0;
  }

  wait 1.5;

  for (var_0 = 0; var_0 < level.introstring.size; var_0++)
    level.introstring[var_0] destroy();
}

_cornerlinethread(var_0, var_1, var_2, var_3) {
  level notify("new_introscreen_element");

  if(!isdefined(level.intro_offset))
    level.intro_offset = 0;
  else
    level.intro_offset++;

  var_4 = _cornerlinethread_height();
  var_5 = newhudelem();
  var_5.x = 30.7;
  var_5.y = var_4 - 8.7;
  var_5.alignx = "left";
  var_5.aligny = "bottom";
  var_5.horzalign = "left_adjustable";
  var_5.vertalign = "bottom_adjustable";
  var_5.sort = level.intro_text_sort;
  var_5.foreground = 1;
  var_5 settext(var_0);
  var_5.alpha = 0;
  var_5 fadeovertime(0.2);
  var_5.alpha = 1;
  var_5.hidewheninmenu = 1;
  var_5.fontscale = 1.25;
  var_5.color = (0.8, 1, 0.8);
  var_5.font = "objective";
  var_5.glowcolor = (0.26, 0.65, 0.32);
  var_5.glowalpha = 0.2;
  var_6 = int(var_1 * var_2 * 1000 + 4000);
  var_5 setpulsefx(30, var_6, 700);
  thread hudelem_destroy(var_5);

  if(!isdefined(var_3)) {
    return;
  }
  if(!isstring(var_3)) {
    return;
  }
  if(var_3 != "date")
    return;
}

_cornerlinethread_height() {
  return level.intro_offset * 18 - 82;
}

introscreen_corner_line(var_0, var_1, var_2, var_3) {
  thread _cornerlinethread(var_0, var_1, var_2, var_3);
}

hudelem_destroy(var_0) {
  wait(level.linefeed_delay);
  var_0 notify("destroying");
  level.intro_offset = undefined;
  var_1 = 0.5;
  var_0 fadeovertime(var_1);
  var_0.alpha = 0;
  wait(var_1);
  var_0 notify("destroy");
  var_0 destroy();
}

weapon_pullout() {
  var_0 = level.player getweaponslistall()[0];
  level.player disableweapons();
  common_scripts\utility::flag_wait("pullup_weapon");
  level.player enableweapons();
}

revive_ammo_counter() {
  common_scripts\utility::flag_wait("safe_for_objectives");

  if(!isdefined(level.nocompass))
    setsaveddvar("compass", 1);

  setsaveddvar("ammoCounterHide", "0");
  setsaveddvar("actionSlotsHide", "0");
  setsaveddvar("hud_showstance", "1");
}

introscreen_add_line(var_0) {
  if(!isdefined(level.introscreen_lines))
    level.introscreen_lines = [];

  precachestring(var_0);
  level.introscreen_lines[level.introscreen_lines.size] = var_0;
}

should_revive_ammo_counter() {
  switch (level.script) {
    case "simplecredits":
    case "sniperescape":
    case "coup":
    case "airplane":
    case "aftermath":
    case "ac130":
    case "airlift":
      return 0;
  }

  return 1;
}

initialize_strings() {
  switch (level.script) {
    case "ac130":
      introscreen_add_line(&"AC130_INTROSCREEN_LINE_1");
      introscreen_add_line(&"AC130_INTROSCREEN_LINE_2");
      introscreen_add_line(&"AC130_INTROSCREEN_LINE_3");
      introscreen_add_line(&"AC130_INTROSCREEN_LINE_4");
      introscreen_add_line(&"AC130_INTROSCREEN_LINE_5");
      break;
    case "airlift":
      introscreen_add_line(&"AIRLIFT_INTROSCREEN_LINE_1");
      introscreen_add_line(&"AIRLIFT_INTROSCREEN_LINE_2");
      introscreen_add_line(&"AIRLIFT_INTROSCREEN_LINE_3");
      introscreen_add_line(&"AIRLIFT_INTROSCREEN_LINE_4");
      break;
    case "ambush":
      introscreen_add_line(&"AMBUSH_INTROSCREEN_LINE_1");
      introscreen_add_line(&"AMBUSH_INTROSCREEN_LINE_2");
      introscreen_add_line(&"AMBUSH_INTROSCREEN_LINE_3");
      introscreen_add_line(&"AMBUSH_INTROSCREEN_LINE_4");
      introscreen_add_line(&"AMBUSH_INTROSCREEN_LINE_5");
      break;
    case "armada":
      introscreen_add_line(&"ARMADA_INTRO");
      introscreen_add_line(&"ARMADA_DATE");
      introscreen_add_line(&"ARMADA_PLACE");
      introscreen_add_line(&"ARMADA_INFO");
      break;
    case "blackout":
      introscreen_add_line(&"BLACKOUT_INTRO_1");
      introscreen_add_line(&"BLACKOUT_INTRO_2");
      introscreen_add_line(&"BLACKOUT_INTRO_3");
      introscreen_add_line(&"BLACKOUT_INTRO_4");
      introscreen_add_line(&"BLACKOUT_INTRO_5");
      break;
    case "bog_a":
      introscreen_add_line(&"BOG_A_INTRO_1");
      introscreen_add_line(&"BOG_A_INTRO_2");
      introscreen_add_line(&"BOG_A_SGT_PAUL_JACKSON");
      introscreen_add_line(&"BOG_A_1ST_FORCE_RECON_CO_USMC");
      break;
    case "bog_b":
      introscreen_add_line(&"BOG_B_INTROSCREEN_LINE_1");
      introscreen_add_line(&"BOG_B_INTROSCREEN_LINE_2");
      introscreen_add_line(&"BOG_B_INTROSCREEN_LINE_3");
      introscreen_add_line(&"BOG_B_INTROSCREEN_LINE_4");
      break;
    case "cargoship":
      introscreen_add_line(&"CARGOSHIP_LINE1");
      introscreen_add_line(&"CARGOSHIP_LINE2");
      introscreen_add_line(&"CARGOSHIP_LINE3");
      introscreen_add_line(&"CARGOSHIP_LINE4");
      introscreen_add_line(&"CARGOSHIP_LINE5");
      break;
    case "hunted":
      introscreen_add_line(&"HUNTED_INTROSCREEN_LINE_1");
      introscreen_add_line(&"HUNTED_INTROSCREEN_LINE_2");
      introscreen_add_line(&"HUNTED_INTROSCREEN_LINE_3");
      introscreen_add_line(&"HUNTED_INTROSCREEN_LINE_4");
      introscreen_add_line(&"HUNTED_INTROSCREEN_LINE_5");
      break;
    case "icbm":
      introscreen_add_line(&"ICBM_INTROSCREEN_LINE_1");
      introscreen_add_line(&"ICBM_INTROSCREEN_LINE_2");
      introscreen_add_line(&"ICBM_INTROSCREEN_LINE_3");
      introscreen_add_line(&"ICBM_INTROSCREEN_LINE_4");
      introscreen_add_line(&"ICBM_INTROSCREEN_LINE_5");
      break;
    case "jeepride":
      introscreen_add_line(&"JEEPRIDE_INTROSCREEN_LINE1");
      introscreen_add_line(&"JEEPRIDE_INTROSCREEN_LINE2");
      introscreen_add_line(&"JEEPRIDE_INTROSCREEN_LINE3");
      introscreen_add_line(&"JEEPRIDE_INTROSCREEN_LINE4");
      introscreen_add_line(&"JEEPRIDE_INTROSCREEN_LINE5");
      break;
    case "killhouse":
      introscreen_add_line(&"KILLHOUSE_INTROSCREEN_LINE_1");
      introscreen_add_line(&"KILLHOUSE_INTROSCREEN_LINE_2");
      introscreen_add_line(&"KILLHOUSE_INTROSCREEN_LINE_3");
      introscreen_add_line(&"KILLHOUSE_INTROSCREEN_LINE_4");
      introscreen_add_line(&"KILLHOUSE_INTROSCREEN_LINE_5");
      break;
    case "launchfacility_a":
      introscreen_add_line(&"LAUNCHFACILITY_A_INTROSCREEN_LINE_1");
      introscreen_add_line(&"LAUNCHFACILITY_A_INTROSCREEN_LINE_2");
      introscreen_add_line(&"LAUNCHFACILITY_A_INTROSCREEN_LINE_3");
      introscreen_add_line(&"LAUNCHFACILITY_A_INTROSCREEN_LINE_4");
      introscreen_add_line(&"LAUNCHFACILITY_A_INTROSCREEN_LINE_5");
      break;
    case "launchfacility_b":
      introscreen_add_line(&"LAUNCHFACILITY_B_INTROSCREEN_LINE_1");
      introscreen_add_line(&"LAUNCHFACILITY_B_INTROSCREEN_LINE_2");
      introscreen_add_line(&"LAUNCHFACILITY_B_INTROSCREEN_LINE_3");
      introscreen_add_line(&"LAUNCHFACILITY_B_INTROSCREEN_LINE_4");
      introscreen_add_line(&"LAUNCHFACILITY_B_INTROSCREEN_LINE_5");
      break;
    case "scoutsniper":
      introscreen_add_line(&"SCOUTSNIPER_INTRO_1");
      introscreen_add_line(&"SCOUTSNIPER_INTRO_2");
      introscreen_add_line(&"SCOUTSNIPER_INTRO_3");
      introscreen_add_line(&"SCOUTSNIPER_INTRO_4");
      precachestring(&"SCOUTSNIPER_15_YEARS_AGO");
      break;
    case "village_assault":
      introscreen_add_line(&"VILLAGE_ASSAULT_INTROSCREEN_LINE_1");
      introscreen_add_line(&"VILLAGE_ASSAULT_INTROSCREEN_LINE_2");
      introscreen_add_line(&"VILLAGE_ASSAULT_INTROSCREEN_LINE_3");
      introscreen_add_line(&"VILLAGE_ASSAULT_INTROSCREEN_LINE_4");
      introscreen_add_line(&"VILLAGE_ASSAULT_INTROSCREEN_LINE_5");
      break;
    case "village_defend":
      introscreen_add_line(&"VILLAGE_DEFEND_INTRO_1");
      introscreen_add_line(&"VILLAGE_DEFEND_INTRO_2");
      introscreen_add_line(&"VILLAGE_DEFEND_INTRO_3");
      introscreen_add_line(&"VILLAGE_DEFEND_INTRO_4");
      introscreen_add_line(&"VILLAGE_DEFEND_INTRO_5");
      precachestring(&"VILLAGE_DEFEND_PRESENT_DAY");
      break;
  }
}