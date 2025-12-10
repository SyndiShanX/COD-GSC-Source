/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_introscreen.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {
  flag_init("pullup_weapon");
  flag_init("starting final intro screen fadeout");
  flag_init("introscreen_complete");
  PrecacheShader("black");
  if(getDvar(#"introscreen") == "") {
    SetDvar("introscreen", "1");
  }
  level.splitscreen = GetDvarInt(#"splitscreen");
  level.hidef = GetDvarInt(#"hidef");
  level thread introscreen_report_disconnected_clients();
  switch (level.script) {
    case "example":
      break;
    case "so_narrative1_frontend":
    case "so_narrative2_frontend":
    case "so_narrative3_frontend":
    case "so_narrative4_frontend":
    case "so_narrative5_frontend":
    case "so_narrative6_frontend":
    case "int_escape":
      introscreen_delay(undefined, undefined, undefined, undefined, undefined, 1, 0, 0, true);
      break;
    case "cuba":
      break;
    case "vorkuta":
      introscreen_delay(&"VORKUTA_INTROSCREEN_EXTRA", &"VORKUTA_INTROSCREEN_TITLE", &"VORKUTA_INTROSCREEN_PLACE", &"VORKUTA_INTROSCREEN_DATE");
      break;
    case "quagmire":
    case "creek_1":
      introscreen_delay("", "", "", "", undefined, undefined, undefined, 4 + 7);
      break;
    case "kowloon":
      introscreen_redact_delay(&"KOWLOON_INTROSCREEN_TITLE", &"KOWLOON_INTROSCREEN_PLACE", &"KOWLOON_INTROSCREEN_NAME", &"KOWLOON_INTROSCREEN_DATE", undefined, 1.0, undefined, undefined, undefined, 0.8);
      break;
    case "hue_city":
      break;
    case "khe_sanh":
      introscreen_redact_delay(&"KHE_SANH_INTRO_LINE_ONE", &"KHE_SANH_INTRO_LINE_TWO", &"KHE_SANH_INTRO_LINE_THREE", &"KHE_SANH_INTRO_LINE_FOUR", &"KHE_SANH_INTRO_LINE_FIVE", 1, undefined, undefined, undefined, 0.8);
      break;
    case "flashpoint":
      introscreen_redact_delay(&"FLASHPOINT_INTROSCREEN_TITLE", &"FLASHPOINT_INTROSCREEN_PLACE", &"FLASHPOINT_INTROSCREEN_INFO", &"FLASHPOINT_INTROSCREEN_DATE", undefined);
      break;
    case "pow":
      level.introscreen_shader = "none";
      introscreen_redact_delay(&"POW_REDACTED_ONE", &"POW_REDACTED_TWO", &"POW_REDACTED_THREE", &"POW_REDACTED_FOUR", &"POW_REDACTED_FIVE", undefined, undefined, undefined, undefined, undefined, (1, 1, 1));
      break;
    case "nazi_zombie_prototype":
      introscreen_delay();
      break;
    case "pentagon":
      introscreen_redact_delay(&"PENTAGON_INTROSCREEN_0", &"PENTAGON_INTROSCREEN_1", &"PENTAGON_INTROSCREEN_2", &"PENTAGON_INTROSCREEN_3");
      break;
    case "fullahead":
      introscreen_delay();
      break;
    case "rebirth":
      if(!isDefined(level.start_point))
        introscreen_redact_delay(&"REBIRTH_MASON_INTROSCREEN_1", &"REBIRTH_MASON_INTROSCREEN_2", &"REBIRTH_MASON_INTROSCREEN_3", &"REBIRTH_MASON_INTROSCREEN_4", &"REBIRTH_MASON_INTROSCREEN_5");
      else {
        if(level.start_point == "default" || level.start_point == "mason_stealth" || level.start_point == "mason_lab")
          introscreen_redact_delay(&"REBIRTH_MASON_INTROSCREEN_1", &"REBIRTH_MASON_INTROSCREEN_2", &"REBIRTH_MASON_INTROSCREEN_3", &"REBIRTH_MASON_INTROSCREEN_4", &"REBIRTH_MASON_INTROSCREEN_5");
        else {
          if(level.start_point != "btr_rail")
            introscreen_redact_delay(&"REBIRTH_MASON_INTROSCREEN_1", &"REBIRTH_HUDSON_INTROSCREEN_2", &"REBIRTH_HUDSON_INTROSCREEN_3", &"REBIRTH_HUDSON_INTROSCREEN_4");
        }
      }
      break;
    case "river":
      introscreen_redact_delay(&"RIVER_INTROSCREEN_1", &"RIVER_INTROSCREEN_3", &"RIVER_INTROSCREEN_4", &"RIVER_INTROSCREEN_5", undefined);
      break;
    case "wmd_sr71":
      introscreen_redact_delay(&"WMD_SR71_INTRO_LEVELNAME", &"WMD_SR71_INTRO_DATE", &"WMD_SR71_INTRO_EXTRA", &"WMD_SR71_INTRO_NAME", &"WMD_SR71_INTRO_LOCATION");
      break;
    case "wmd":
      introscreen_redact_delay(&"WMD_INTRO_LEVELNAME", &"WMD_INTRO_LOCATION", &"WMD_INTRO_EXTRA", &"WMD_INTRO_NAME", &"WMD_INTRO_DATE");
      break;
    case "underwaterbase":
      introscreen_redact_delay(&"UNDERWATERBASE_INTROSCREEN_1", &"UNDERWATERBASE_INTROSCREEN_2", &"UNDERWATERBASE_INTROSCREEN_3", &"UNDERWATERBASE_INTROSCREEN_4", &"UNDERWATERBASE_INTROSCREEN_5");
      break;
    default:
      wait(0.05);
      level notify("finished final intro screen fadein");
      wait(0.05);
      flag_set("starting final intro screen fadeout");
      wait(0.05);
      level notify("controls_active");
      wait(0.05);
      flag_set("introscreen_complete");
      break;
  }
}

introscreen_create_redacted_line(string, redacted_line_time, start_rubout_time, rubout_time, color, type, scale, font) {
  index = level.introstring.size;
  yPos = (index * 30);
  if(level.console) {
    yPos -= 90;
    xPos = 0;
  } else {
    yPos -= 120;
    xPos = 10;
  }
  align_x = "center";
  align_y = "middle";
  horz_align = "center";
  vert_align = "middle";
  if(!isDefined(type)) {
    type = "lower_left";
  }
  if(isDefined(type)) {
    switch (type) {
      case "lower_left":
        yPos -= 30;
        align_x = "left";
        align_y = "bottom";
        horz_align = "left";
        vert_align = "bottom";
        break;
    }
  }
  if(!isDefined(scale)) {
    if(level.splitscreen && !level.hidef)
      fontScale = 2.5;
    else
      fontScale = 1.5;
  } else
    fontScale = scale;
  level.introstring[index] = NewHudElem();
  level.introstring[index].x = xPos;
  level.introstring[index].y = yPos;
  level.introstring[index].alignX = align_x;
  level.introstring[index].alignY = align_y;
  level.introstring[index].horzAlign = horz_align;
  level.introstring[index].vertAlign = vert_align;
  level.introstring[index].sort = 1;
  level.introstring[index].foreground = true;
  level.introstring[index].fontScale = fontScale;
  level.introstring[index].color = (0, 0, 0);
  level.introstring[index] SetText(string);
  level.introstring[index] SetRedactFX(redacted_line_time, 700, start_rubout_time, rubout_time);
  level.introstring[index].alpha = 0;
  level.introstring[index] FadeOverTime(1.2);
  level.introstring[index].alpha = 1;
  if(isDefined(font)) {
    level.introstring[index].font = font;
  }
  if(isDefined(color)) {
    level.introstring[index].color = color;
  }
  if(isDefined(level.introstring_text_color)) {
    level.introstring[index].color = level.introstring_text_color;
  }
}

introscreen_create_line(string, type, scale, font, color) {
  index = level.introstring.size;
  yPos = (index * 30);
  if(level.console) {
    yPos -= 90;
    xPos = 0;
  } else {
    yPos -= 120;
    xPos = 10;
  }
  align_x = "center";
  align_y = "middle";
  horz_align = "center";
  vert_align = "middle";
  if(!isDefined(type)) {
    type = "lower_left";
  }
  if(isDefined(type)) {
    switch (type) {
      case "lower_left":
        yPos -= 30;
        align_x = "left";
        align_y = "bottom";
        horz_align = "left";
        vert_align = "bottom";
        break;
    }
  }
  if(!isDefined(scale)) {
    if(level.splitscreen && !level.hidef)
      fontScale = 2.75;
    else
      fontScale = 1.75;
  } else
    fontScale = scale;
  level.introstring[index] = NewHudElem();
  level.introstring[index].x = xPos;
  level.introstring[index].y = yPos;
  level.introstring[index].alignX = align_x;
  level.introstring[index].alignY = align_y;
  level.introstring[index].horzAlign = horz_align;
  level.introstring[index].vertAlign = vert_align;
  level.introstring[index].sort = 1;
  level.introstring[index].foreground = true;
  level.introstring[index].fontScale = fontScale;
  level.introstring[index] SetText(string);
  level.introstring[index].alpha = 0;
  level.introstring[index] FadeOverTime(1.2);
  level.introstring[index].alpha = 1;
  if(isDefined(font)) {
    level.introstring[index].font = font;
  }
  if(isDefined(color)) {
    level.introstring[index].color = color;
  }
}

introscreen_fadeOutText() {
  for(i = 0; i < level.introstring.size; i++) {
    level.introstring[i] FadeOverTime(1.5);
    level.introstring[i].alpha = 0;
  }
  wait(1.5);
  for(i = 0; i < level.introstring.size; i++) {
    level.introstring[i] Destroy();
  }
  wait(0.25);
}

introscreen_redact_delay(string1, string2, string3, string4, string5, pausetime, totaltime, time_to_redact, delay_after_text, rubout_time, color) {
  if(isDefined(level.custom_introscreen)) {
    [[level.custom_introscreen]](string1, string2, string3, string4, string5);
    return;
  }
  level.introblack = NewHudElem();
  level.introblack.x = 0;
  level.introblack.y = 0;
  level.introblack.horzAlign = "fullscreen";
  level.introblack.vertAlign = "fullscreen";
  level.introblack.foreground = true;
  if(!isDefined(level.introscreen_shader)) {
    level.introblack SetShader("white", 640, 480);
  } else if(level.introscreen_shader != "none") {
    level.introblack SetShader(level.introscreen_shader, 640, 480);
  }
  flag_wait("all_players_connected");
  if(!isDefined(level.introscreen_dontfreezcontrols))
    freezecontrols_all(true);
  level._introscreen = true;
  wait(0.5);
  level.introstring = [];
  if(!isDefined(pausetime)) {
    pausetime = 0.75;
  }
  if(!isDefined(totaltime)) {
    totaltime = 14.25;
  }
  if(!isDefined(time_to_redact)) {
    time_to_redact = (0.525 * totaltime);
  }
  if(!isDefined(rubout_time)) {
    rubout_time = 1;
  }
  delay_between_redacts_min = 350;
  delay_between_redacts_max = 500;
  start_rubout_time = Int(time_to_redact * 1000);
  totalpausetime = 0;
  rubout_time = Int(rubout_time * 1000);
  redacted_line_time = Int(1000 * (totaltime - totalpausetime));
  if(isDefined(string1)) {
    level thread introscreen_create_redacted_line(string1, redacted_line_time, start_rubout_time, rubout_time, color);
    wait(pausetime);
    totalpausetime += pausetime;
  }
  if(isDefined(string2)) {
    start_rubout_time = Int((start_rubout_time + rubout_time) - (pausetime * 1000)) + randomInt(delay_between_redacts_min, delay_between_redacts_max);
    redacted_line_time = int(1000 * (totaltime - totalpausetime));
    level thread introscreen_create_redacted_line(string2, redacted_line_time, start_rubout_time, rubout_time, color);
    wait(pausetime);
    totalpausetime += pausetime;
  }
  if(isDefined(string3)) {
    start_rubout_time = Int((start_rubout_time + rubout_time) - (pausetime * 1000)) + randomInt(delay_between_redacts_min, delay_between_redacts_max);
    redacted_line_time = int(1000 * (totaltime - totalpausetime));
    level thread introscreen_create_redacted_line(string3, redacted_line_time, start_rubout_time, rubout_time, color);
    wait(pausetime);
    totalpausetime += pausetime;
  }
  if(isDefined(string4)) {
    start_rubout_time = Int((start_rubout_time + rubout_time) - (pausetime * 1000)) + randomInt(delay_between_redacts_min, delay_between_redacts_max);
    redacted_line_time = int(1000 * (totaltime - totalpausetime));
    level thread introscreen_create_redacted_line(string4, redacted_line_time, start_rubout_time, rubout_time, color);
    wait(pausetime);
    totalpausetime += pausetime;
  }
  if(isDefined(string5)) {
    start_rubout_time = Int((start_rubout_time + rubout_time) - (pausetime * 1000)) + randomInt(delay_between_redacts_min, delay_between_redacts_max);
    redacted_line_time = int(1000 * (totaltime - totalpausetime));
    level thread introscreen_create_redacted_line(string5, redacted_line_time, start_rubout_time, rubout_time, color);
    wait(pausetime);
    totalpausetime += pausetime;
  }
  level notify("finished final intro screen fadein");
  if(isDefined(level.introscreen_waitontext_flag)) {
    level notify("introscreen_blackscreen_waiting_on_flag");
    flag_wait(level.introscreen_waitontext_flag);
  }
  wait(totaltime - totalpausetime);
  if(isDefined(delay_after_text)) {
    wait delay_after_text;
  } else {
    wait 2.5;
  }
  if(isDefined(level.introscreen_shader_fadeout_time))
    level.introblack FadeOverTime(level.introscreen_shader_fadeout_time);
  else
    level.introblack FadeOverTime(1.5);
  level.introblack.alpha = 0;
  flag_set("starting final intro screen fadeout");
  level thread freezecontrols_all(false, 0.75);
  level._introscreen = false;
  level notify("controls_active");
  introscreen_fadeOutText();
  flag_set("introscreen_complete");
}

introscreen_delay(string1, string2, string3, string4, string5, pausetime1, pausetime2, timebeforefade, skipwait) {
  if(isDefined(level.custom_introscreen)) {
    [[level.custom_introscreen]](string1, string2, string3, string4, string5);
    return;
  }
  level.introblack = NewHudElem();
  level.introblack.x = 0;
  level.introblack.y = 0;
  level.introblack.horzAlign = "fullscreen";
  level.introblack.vertAlign = "fullscreen";
  level.introblack.foreground = true;
  if(!isDefined(level.introscreen_shader)) {
    level.introblack SetShader("black", 640, 480);
  } else {
    level.introblack SetShader(level.introscreen_shader, 640, 480);
  }
  if(!isDefined(skipwait)) {
    flag_wait("all_players_connected");
  }
  if(!isDefined(level.introscreen_dontfreezcontrols))
    freezecontrols_all(true);
  level._introscreen = true;
  if(isDefined(skipwait)) {
    flag_wait("all_players_connected");
  }
  wait(0.5);
  level.introstring = [];
  if(isDefined(string1)) {
    introscreen_create_line(string1);
  }
  if(isDefined(pausetime1)) {
    wait(pausetime1);
  } else {
    wait(2);
  }
  if(isDefined(string2)) {
    introscreen_create_line(string2);
  }
  if(isDefined(string3)) {
    introscreen_create_line(string3);
  }
  if(isDefined(string4)) {
    if(isDefined(pausetime2)) {
      wait(pausetime2);
    } else {
      wait(2);
    }
    introscreen_create_line(string4);
  }
  if(isDefined(string5)) {
    if(isDefined(pausetime2)) {
      wait(pausetime2);
    } else {
      wait(2);
    }
    introscreen_create_line(string5);
  }
  level notify("finished final intro screen fadein");
  if(isDefined(level.introscreen_waitontext_flag)) {
    level notify("introscreen_blackscreen_waiting_on_flag");
    flag_wait(level.introscreen_waitontext_flag);
  }
  if(isDefined(timebeforefade)) {
    wait(timebeforefade);
  } else {
    wait(3);
  }
  level.introblack FadeOverTime(1.5);
  level.introblack.alpha = 0;
  flag_set("starting final intro screen fadeout");
  level thread freezecontrols_all(false, 0.75);
  level._introscreen = false;
  level notify("controls_active");
  introscreen_fadeOutText();
  flag_set("introscreen_complete");
}

introscreen_player_connect() {
  if(isDefined(level._introscreen) && level._introscreen) {
    self FreezeControls(true);
  }
}

introscreen_report_disconnected_clients() {
  flag_wait("introscreen_complete");
  if(isDefined(level._disconnected_clients)) {
    for(i = 0; i < level._disconnected_clients.size; i++) {
      ReportClientDisconnected(level._disconnected_clients[i]);
    }
  }
}

introscreen_clear_redacted_flags() {
  flag_clear("introscreen_complete");
  flag_clear("starting final intro screen fadeout");
}