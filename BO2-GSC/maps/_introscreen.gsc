/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_introscreen.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_skipto;

main() {
  flag_init("pullup_weapon");
  flag_init("starting final intro screen fadeout");
  flag_init("introscreen_complete");
  precacheshader("black");
  precachestring(&"hud_close_title_card");
  precachestring(&"hud_add_title_line");

  if(getdvar(#"_id_CCAFCC91") == "")
    setdvar("introscreen", "1");

  level.splitscreen = getdvarint(#"splitscreen");
  level.hidef = getdvarint(#"hiDef");
  level thread introscreen_report_disconnected_clients();

  switch (level.script) {
    case "example":
      break;
    case "angola":
      precachestring(&"ANGOLA");
      introscreen_lui_typewriter_delay("ANGOLA", 5, 10, 0, 0);
      break;
    case "haiti":
      level.introscreen_shader_fadeout_time = 1.0;
      level.introscreen_shader = "black";
      precachestring(&"HAITI");
      introscreen_lui_typewriter_delay("HAITI", 5, 10, 0, 0);
      break;
    case "nicaragua":
      level.introscreen_shader = "none";
      level.introscreen_dontfreezcontrols = 1;
      precachestring(&"NICARAGUA");
      precachestring(&"NICARAGUA_MENENDEZ");
      introscreen_lui_typewriter_delay("NICARAGUA", 5, 10, 0, 0);
      break;
    case "monsoon":
      precachestring(&"MONSOON");
      introscreen_lui_typewriter_delay("MONSOON", 5, 10, 0, 0);
      break;
    case "so_cmp_afghanistan":
      level.introscreen_shader = "black";
      precachestring(&"AFGHANISTAN");
      introscreen_lui_typewriter_delay("AFGHANISTAN", 5, 10, 0, 1);
      break;
    case "pakistan":
      level.introscreen_shader = "none";
      level.introscreen_dontfreezcontrols = 1;
      precachestring(&"PAKISTAN_SHARED");
      introscreen_lui_typewriter_delay("PAKISTAN_SHARED", 5, 10, 0, 0);
      break;
    case "karma":
      precachestring(&"KARMA");
      introscreen_lui_typewriter_delay("KARMA", 5, 10, 0, 1);
      break;
    case "blackout":
      level.introscreen_shader_fadeout_time = 0.05;
      level.introscreen_shader = "black";
      precachestring(&"BLACKOUT");
      introscreen_lui_typewriter_delay("BLACKOUT", 5, 10, 0, 0);
      break;
    case "la_1":
      level.introscreen_waitontext_flag = "end_intro_screen";
      level.introscreen_shader_fadeout_time = 0.05;
      level.introscreen_shader = "black";
      precachestring(&"LA_SHARED");
      introscreen_lui_typewriter_delay("LA_SHARED", 5, 10, 0, 0);
      break;
    case "panama":
      precachestring(&"PANAMA");
      introscreen_lui_typewriter_delay("PANAMA", 5, 10, 0, 0);
      break;
    case "yemen":
      level.introscreen_shader_fadeout_time = 0.05;
      level.introscreen_shader = "black";
      precachestring(&"YEMEN");
      precachestring(&"YEMEN_MASON");
      introscreen_lui_typewriter_delay("YEMEN", 5, 10, 0, 0);
      break;
    case "so_rts_mp_dockside":
      precachestring(&"SO_RTS_MP_DOCKSIDE");
      introscreen_lui_typewriter_delay("SO_RTS_MP_DOCKSIDE", 4, 10, 0, 0);
      break;
    case "so_rts_mp_socotra":
      precachestring(&"SO_RTS_MP_SOCOTRA");
      introscreen_lui_typewriter_delay("SO_RTS_MP_SOCOTRA", 4, 10, 0, 0);
      break;
    case "so_rts_afghanistan":
      precachestring(&"SO_RTS_AFGHANISTAN");
      introscreen_lui_typewriter_delay("SO_RTS_AFGHANISTAN", 4, 10, 0, 0);
      break;
    case "so_rts_mp_overflow":
      precachestring(&"SO_RTS_MP_OVERFLOW");
      introscreen_lui_typewriter_delay("SO_RTS_MP_OVERFLOW", 4, 10, 0, 0);
      break;
    case "so_rts_mp_drone":
      precachestring(&"SO_RTS_MP_DRONE");
      introscreen_lui_typewriter_delay("SO_RTS_MP_DRONE", 4, 10, 0, 0);
      break;
    case "so_tut_mp_drone":
      precachestring(&"SO_TUT_MP_DRONE");
      introscreen_lui_typewriter_delay("SO_TUT_MP_DRONE", 4, 10, 0, 0);
      break;
    default:
      wait 0.05;
      level notify("finished final intro screen fadein");
      wait 0.05;
      flag_set("starting final intro screen fadeout");
      wait 0.05;
      level notify("controls_active");
      wait 0.05;
      flag_set("introscreen_complete");
      break;
  }
}

introscreen_lui_typewriter_delay(level_prefix, number_of_lines, totaltime, delay_after_text, text_color) {
  waittillframeend;
  waittillframeend;
  skipintro = 0;

  if(isDefined(level.start_point))
    skipintro = level.start_point != "default";

  if(isDefined(level.skipto_point))
    skipintro = !maps\_skipto::is_default_skipto();

  if(getdvar(#"_id_CCAFCC91") == "0" || level.createfx_enabled)
    skipintro = 1;

  if(skipintro) {
    if(isDefined(level.introblackbacking))
      level.introblackbacking destroy();

    flag_wait("all_players_connected");

    if(isDefined(level.custom_introscreen)) {
      [
        [level.custom_introscreen]
      ](istring(level_prefix), number_of_lines, totaltime, text_color);

      if(!isDefined(level.texture_wait_was_called))
        iprintlnbold("ERROR: need to call waittill_textures_loaded(); in your custom introscreen");

      return;
    }

    waittillframeend;
    level notify("finished final intro screen fadein");
    waittillframeend;
    flag_set("starting final intro screen fadeout");
    waittillframeend;
    level notify("controls_active");
    waittillframeend;
    flag_set("introscreen_complete");
    flag_set("pullup_weapon");
    return;
  }

  if(isDefined(level.custom_introscreen)) {
    [
      [level.custom_introscreen]
    ](istring(level_prefix), number_of_lines, totaltime, text_color);

    if(!isDefined(level.texture_wait_was_called))
      iprintlnbold("ERROR: need to call waittill_textures_loaded(); in your custom introscreen");

    return;
  }

  if(!isDefined(level.introblackbacking)) {
    level.introblackbacking = newhudelem();
    level.introblackbacking.x = 0;
    level.introblackbacking.y = 0;
    level.introblackbacking.horzalign = "fullscreen";
    level.introblackbacking.vertalign = "fullscreen";

    if(!isDefined(level.introscreen_shader)) {
      level.introblackbacking setshader("white", 640, 480);
      level.introblackbacking.color = vectorscale((1, 1, 1), 0.94);
    } else if(level.introscreen_shader != "none")
      level.introblackbacking setshader(level.introscreen_shader, 640, 480);
  }

  flag_wait("all_players_connected");

  if(!isDefined(level.introscreen_dontfreezcontrols))
    freezecontrols_all(1);

  level._introscreen = 1;
  wait 0.5;
  level.introstring = [];

  if(!isDefined(totaltime))
    totaltime = 14.25;

  decay_start = int(1000 * totaltime);
  totalpausetime = 0;
  luinotifyevent(&"hud_add_title_line", 4, istring(level_prefix), number_of_lines, totaltime, text_color);
  level notify("finished final intro screen fadein");

  if(isDefined(level.introscreen_waitontext_flag)) {
    level notify("introscreen_blackscreen_waiting_on_flag");
    flag_wait(level.introscreen_waitontext_flag);
  } else {
    wait(totaltime - totalpausetime);

    if(isDefined(delay_after_text))
      wait(delay_after_text);
    else
      wait 2.5;
  }

  waittill_textures_loaded();

  if(isDefined(level.introscreen_shader_fadeout_time))
    level.introblackbacking fadeovertime(level.introscreen_shader_fadeout_time);
  else
    level.introblackbacking fadeovertime(1.5);

  level.introblackbacking.alpha = 0;
  flag_set("starting final intro screen fadeout");
  level thread freezecontrols_all(0, 0.75);
  level._introscreen = 0;
  level notify("controls_active");
  introscreen_fadeouttext();
  flag_set("introscreen_complete");
}

introscreen_create_redacted_line(string, redacted_line_time, start_rubout_time, rubout_time, color, type, scale, font) {
  index = level.introstring.size;
  ypos = index * 30;

  if(level.console) {
    ypos = ypos - 90;
    xpos = 0;
  } else {
    ypos = ypos - 120;
    xpos = 10;
  }

  align_x = "center";
  align_y = "middle";
  horz_align = "center";
  vert_align = "middle";

  if(!isDefined(type))
    type = "lower_left";

  if(isDefined(type)) {
    switch (type) {
      case "lower_left":
        ypos = ypos - 30;
        align_x = "left";
        align_y = "bottom";
        horz_align = "left";
        vert_align = "bottom";
        break;
    }
  }

  if(!isDefined(scale)) {
    if(level.splitscreen && !level.hidef)
      fontscale = 2.5;
    else
      fontscale = 1.5;
  } else
    fontscale = scale;

  level.introstring[index] = newhudelem();
  level.introstring[index].x = xpos;
  level.introstring[index].y = ypos;
  level.introstring[index].alignx = align_x;
  level.introstring[index].aligny = align_y;
  level.introstring[index].horzalign = horz_align;
  level.introstring[index].vertalign = vert_align;
  level.introstring[index].sort = 1;
  level.introstring[index].foreground = 1;
  level.introstring[index].hidewheninmenu = 1;
  level.introstring[index].fontscale = fontscale;
  level.introstring[index].color = (0, 0, 0);
  level.introstring[index] settext(string);
  level.introstring[index] setredactfx(redacted_line_time, 700, start_rubout_time, rubout_time);
  level.introstring[index].alpha = 0;
  level.introstring[index] fadeovertime(1.2);
  level.introstring[index].alpha = 1;

  if(isDefined(font))
    level.introstring[index].font = font;

  if(isDefined(color))
    level.introstring[index].color = color;

  if(isDefined(level.introstring_text_color))
    level.introstring[index].color = level.introstring_text_color;
}

introscreen_create_typewriter_line(string, letter_time, decay_start_time, decay_duration, color, type, font) {
  index = level.introstring.size;

  if(index <= 1) {
    scale = 2;
    ypos = index * 20;
  } else if(index == 4) {
    scale = 1.2;
    ypos = index * 15;
  } else {
    scale = 1.5;
    ypos = index * 15 + 5;
  }

  if(level.console) {
    ypos = ypos - 60;
    xpos = 0;
  } else {
    ypos = ypos - 90;
    xpos = 20;
  }

  align_x = "center";
  align_y = "middle";
  horz_align = "center";
  vert_align = "middle";

  if(!isDefined(type))
    type = "lower_left";

  if(isDefined(type)) {
    switch (type) {
      case "lower_left":
        ypos = ypos - 30;
        align_x = "left";
        align_y = "bottom";
        horz_align = "left";
        vert_align = "bottom";
        break;
    }
  }

  if(!isDefined(scale)) {
    if(level.splitscreen && !level.hidef)
      fontscale = 2.5;
    else
      fontscale = 1.5;
  } else
    fontscale = scale;

  level.introstring[index] = newhudelem();
  level.introstring[index].x = xpos;
  level.introstring[index].y = ypos;
  level.introstring[index].alignx = align_x;
  level.introstring[index].aligny = align_y;
  level.introstring[index].horzalign = horz_align;
  level.introstring[index].vertalign = vert_align;
  level.introstring[index].sort = 1;
  level.introstring[index].foreground = 1;
  level.introstring[index].hidewheninmenu = 1;
  level.introstring[index].fontscale = fontscale;
  level.introstring[index].color = (0, 0, 0);
  level.introstring[index] settext(string);
  level.introstring[index] settypewriterfx(letter_time, decay_start_time, decay_duration);
  level.introstring[index].alpha = 0;
  level.introstring[index] fadeovertime(1.2);
  level.introstring[index].alpha = 1;

  if(isDefined(font))
    level.introstring[index].font = font;

  if(isDefined(color))
    level.introstring[index].color = color;

  if(isDefined(level.introstring_text_color))
    level.introstring[index].color = level.introstring_text_color;
}

introscreen_create_line(string, type, scale, font, color) {
  index = level.introstring.size;
  ypos = index * 30;

  if(level.console) {
    ypos = ypos - 90;
    xpos = 0;
  } else {
    ypos = ypos - 120;
    xpos = 10;
  }

  align_x = "center";
  align_y = "middle";
  horz_align = "center";
  vert_align = "middle";

  if(!isDefined(type))
    type = "lower_left";

  if(isDefined(type)) {
    switch (type) {
      case "lower_left":
        ypos = ypos - 30;
        align_x = "left";
        align_y = "bottom";
        horz_align = "left";
        vert_align = "bottom";
        break;
    }
  }

  if(!isDefined(scale)) {
    if(level.splitscreen && !level.hidef)
      fontscale = 2.75;
    else
      fontscale = 1.75;
  } else
    fontscale = scale;

  level.introstring[index] = newhudelem();
  level.introstring[index].x = xpos;
  level.introstring[index].y = ypos;
  level.introstring[index].alignx = align_x;
  level.introstring[index].aligny = align_y;
  level.introstring[index].horzalign = horz_align;
  level.introstring[index].vertalign = vert_align;
  level.introstring[index].sort = 1;
  level.introstring[index].foreground = 1;
  level.introstring[index].hidewheninmenu = 1;
  level.introstring[index].fontscale = fontscale;
  level.introstring[index] settext(string);
  level.introstring[index].alpha = 0;
  level.introstring[index] fadeovertime(1.2);
  level.introstring[index].alpha = 1;

  if(isDefined(font))
    level.introstring[index].font = font;

  if(isDefined(color))
    level.introstring[index].color = color;
}

introscreen_fadeouttext() {
  for(i = 0; i < level.introstring.size; i++) {
    level.introstring[i] fadeovertime(1.5);
    level.introstring[i].alpha = 0;
  }

  wait 1.5;

  for(i = 0; i < level.introstring.size; i++)
    level.introstring[i] destroy();

  wait 0.25;
}

introscreen_redact_delay(string1, string2, string3, string4, string5, pausetime, totaltime, time_to_redact, delay_after_text, rubout_time, color) {
  waittillframeend;
  waittillframeend;
  skipintro = 0;

  if(isDefined(level.start_point))
    skipintro = level.start_point != "default";

  if(isDefined(level.skipto_point))
    skipintro = !maps\_skipto::is_default_skipto();

  if(getdvar(#"_id_CCAFCC91") == "0" || level.createfx_enabled)
    skipintro = 1;

  if(skipintro) {
    if(isDefined(level.introblackbacking))
      level.introblackbacking destroy();

    flag_wait("all_players_connected");

    if(isDefined(level.custom_introscreen)) {
      [
        [level.custom_introscreen]
      ](string1, string2, string3, string4, string5);

      if(!isDefined(level.texture_wait_was_called))
        iprintlnbold("ERROR: need to call waittill_textures_loaded(); in your custom introscreen");

      return;
    }

    waittillframeend;
    level notify("finished final intro screen fadein");
    waittillframeend;
    flag_set("starting final intro screen fadeout");
    waittillframeend;
    level notify("controls_active");
    waittillframeend;
    flag_set("introscreen_complete");
    flag_set("pullup_weapon");
    return;
  }

  if(isDefined(level.custom_introscreen)) {
    [
      [level.custom_introscreen]
    ](string1, string2, string3, string4, string5);

    if(!isDefined(level.texture_wait_was_called))
      iprintlnbold("ERROR: need to call waittill_textures_loaded(); in your custom introscreen");

    return;
  }

  if(!isDefined(level.introblackbacking)) {
    level.introblackbacking = newhudelem();
    level.introblackbacking.x = 0;
    level.introblackbacking.y = 0;
    level.introblackbacking.horzalign = "fullscreen";
    level.introblackbacking.vertalign = "fullscreen";

    if(!isDefined(level.introscreen_shader))
      level.introblackbacking setshader("white", 640, 480);
    else if(level.introscreen_shader != "none")
      level.introblackbacking setshader(level.introscreen_shader, 640, 480);
  }

  flag_wait("all_players_connected");

  if(!isDefined(level.introscreen_dontfreezcontrols))
    freezecontrols_all(1);

  level._introscreen = 1;
  wait 0.5;
  level.introstring = [];

  if(!isDefined(pausetime))
    pausetime = 0.75;

  if(!isDefined(totaltime))
    totaltime = 14.25;

  if(!isDefined(time_to_redact))
    time_to_redact = 0.525 * totaltime;

  if(!isDefined(rubout_time))
    rubout_time = 1;

  start_rubout_time = int(time_to_redact * 1000);
  totalpausetime = 0;
  rubout_time = int(rubout_time * 1000);
  redacted_line_time = int(1000 * (totaltime - totalpausetime));

  if(isDefined(string1)) {
    level thread introscreen_create_redacted_line(string1, redacted_line_time, start_rubout_time, rubout_time, color, undefined, undefined, "objective");
    wait(pausetime);
    totalpausetime = totalpausetime + pausetime;
  }

  if(isDefined(string2)) {
    start_rubout_time = int(start_rubout_time + rubout_time - pausetime * 1000) + randomintrange(350, 500);
    redacted_line_time = int(1000 * (totaltime - totalpausetime));
    level thread introscreen_create_redacted_line(string2, redacted_line_time, start_rubout_time, rubout_time, color, undefined, undefined, "objective");
    wait(pausetime);
    totalpausetime = totalpausetime + pausetime;
  }

  if(isDefined(string3)) {
    start_rubout_time = int(start_rubout_time + rubout_time - pausetime * 1000) + randomintrange(350, 500);
    redacted_line_time = int(1000 * (totaltime - totalpausetime));
    level thread introscreen_create_redacted_line(string3, redacted_line_time, start_rubout_time, rubout_time, color, undefined, undefined, "objective");
    wait(pausetime);
    totalpausetime = totalpausetime + pausetime;
  }

  if(isDefined(string4)) {
    start_rubout_time = int(start_rubout_time + rubout_time - pausetime * 1000) + randomintrange(350, 500);
    redacted_line_time = int(1000 * (totaltime - totalpausetime));
    level thread introscreen_create_redacted_line(string4, redacted_line_time, start_rubout_time, rubout_time, color, undefined, undefined, "objective");
    wait(pausetime);
    totalpausetime = totalpausetime + pausetime;
  }

  if(isDefined(string5)) {
    start_rubout_time = int(start_rubout_time + rubout_time - pausetime * 1000) + randomintrange(350, 500);
    redacted_line_time = int(1000 * (totaltime - totalpausetime));
    level thread introscreen_create_redacted_line(string5, redacted_line_time, start_rubout_time, rubout_time, color, undefined, undefined, "objective");
    wait(pausetime);
    totalpausetime = totalpausetime + pausetime;
  }

  level notify("finished final intro screen fadein");

  if(isDefined(level.introscreen_waitontext_flag)) {
    level notify("introscreen_blackscreen_waiting_on_flag");
    flag_wait(level.introscreen_waitontext_flag);
  } else {
    wait(totaltime - totalpausetime);

    if(isDefined(delay_after_text))
      wait(delay_after_text);
    else
      wait 2.5;
  }

  waittill_textures_loaded();

  if(isDefined(level.introscreen_shader_fadeout_time))
    level.introblackbacking fadeovertime(level.introscreen_shader_fadeout_time);
  else
    level.introblackbacking fadeovertime(1.5);

  level.introblackbacking.alpha = 0;
  flag_set("starting final intro screen fadeout");
  level thread freezecontrols_all(0, 0.75);
  level._introscreen = 0;
  level notify("controls_active");
  introscreen_fadeouttext();
  flag_set("introscreen_complete");
}

introscreen_typewriter_delay(string1, string2, string3, string4, string5, letter_time, decay_duration, pausetime, totaltime, delay_after_text, color) {
  waittillframeend;
  waittillframeend;
  skipintro = 0;

  if(isDefined(level.start_point))
    skipintro = level.start_point != "default";

  if(isDefined(level.skipto_point))
    skipintro = !maps\_skipto::is_default_skipto();

  if(getdvar(#"_id_CCAFCC91") == "0" || level.createfx_enabled)
    skipintro = 1;

  if(skipintro) {
    if(isDefined(level.introblackbacking))
      level.introblackbacking destroy();

    flag_wait("all_players_connected");

    if(isDefined(level.custom_introscreen)) {
      [
        [level.custom_introscreen]
      ](string1, string2, string3, string4, string5);

      if(!isDefined(level.texture_wait_was_called))
        iprintlnbold("ERROR: need to call waittill_textures_loaded(); in your custom introscreen");

      return;
    }

    waittillframeend;
    level notify("finished final intro screen fadein");
    waittillframeend;
    flag_set("starting final intro screen fadeout");
    waittillframeend;
    level notify("controls_active");
    waittillframeend;
    flag_set("introscreen_complete");
    flag_set("pullup_weapon");
    return;
  }

  if(isDefined(level.custom_introscreen)) {
    [
      [level.custom_introscreen]
    ](string1, string2, string3, string4, string5);

    if(!isDefined(level.texture_wait_was_called))
      iprintlnbold("ERROR: need to call waittill_textures_loaded(); in your custom introscreen");

    return;
  }

  if(!isDefined(level.introblackbacking)) {
    level.introblackbacking = newhudelem();
    level.introblackbacking.x = 0;
    level.introblackbacking.y = 0;
    level.introblackbacking.horzalign = "fullscreen";
    level.introblackbacking.vertalign = "fullscreen";

    if(!isDefined(level.introscreen_shader)) {
      level.introblackbacking setshader("white", 640, 480);
      level.introblackbacking.color = vectorscale((1, 1, 1), 0.94);
    } else if(level.introscreen_shader != "none")
      level.introblackbacking setshader(level.introscreen_shader, 640, 480);
  }

  flag_wait("all_players_connected");

  if(!isDefined(level.introscreen_dontfreezcontrols))
    freezecontrols_all(1);

  level._introscreen = 1;
  wait 0.5;
  level.introstring = [];

  if(!isDefined(letter_time))
    letter_time = 0.1;

  if(!isDefined(decay_duration))
    decay_duration = 0.5;

  if(!isDefined(pausetime))
    pausetime = 1.5;

  if(!isDefined(totaltime))
    totaltime = 14.25;

  letter_time = int(1000 * letter_time);
  decay_duration = int(1000 * decay_duration);
  decay_start = int(1000 * totaltime);
  totalpausetime = 0;

  if(isDefined(string1)) {
    level thread introscreen_create_typewriter_line(string1, letter_time, decay_start, decay_duration, color, undefined, "objective");
    wait(pausetime);
    totalpausetime = totalpausetime + pausetime;
  }

  if(isDefined(string2)) {
    decay_start = int(1000 * (totaltime - totalpausetime));
    level thread introscreen_create_typewriter_line(string2, letter_time, decay_start, decay_duration, color, undefined, "objective");
    wait(pausetime);
    totalpausetime = totalpausetime + pausetime;
  }

  if(isDefined(string3)) {
    decay_start = int(1000 * (totaltime - totalpausetime));
    level thread introscreen_create_typewriter_line(string3, letter_time, decay_start, decay_duration, color, undefined, "objective");
    wait(pausetime);
    totalpausetime = totalpausetime + pausetime;
  }

  if(isDefined(string4)) {
    decay_start = int(1000 * (totaltime - totalpausetime));
    level thread introscreen_create_typewriter_line(string4, letter_time, decay_start, decay_duration, color, undefined, "objective");
    wait(pausetime);
    totalpausetime = totalpausetime + pausetime;
  }

  if(isDefined(string5)) {
    decay_start = int(1000 * (totaltime - totalpausetime));
    level thread introscreen_create_typewriter_line(string5, letter_time, decay_start, decay_duration, color, undefined, "objective");
    wait(pausetime);
    totalpausetime = totalpausetime + pausetime;
  }

  level notify("finished final intro screen fadein");

  if(isDefined(level.introscreen_waitontext_flag)) {
    level notify("introscreen_blackscreen_waiting_on_flag");
    flag_wait(level.introscreen_waitontext_flag);
  } else {
    wait(totaltime - totalpausetime);

    if(isDefined(delay_after_text))
      wait(delay_after_text);
    else
      wait 2.5;
  }

  waittill_textures_loaded();

  if(isDefined(level.introscreen_shader_fadeout_time))
    level.introblackbacking fadeovertime(level.introscreen_shader_fadeout_time);
  else
    level.introblackbacking fadeovertime(1.5);

  level.introblackbacking.alpha = 0;
  flag_set("starting final intro screen fadeout");
  level thread freezecontrols_all(0, 0.75);
  level._introscreen = 0;
  level notify("controls_active");
  introscreen_fadeouttext();
  flag_set("introscreen_complete");
}

introscreen_delay(string1, string2, string3, string4, string5, pausetime1, pausetime2, timebeforefade, skipwait) {
  waittillframeend;
  waittillframeend;
  skipintro = 0;

  if(isDefined(level.start_point))
    skipintro = level.start_point != "default";

  if(isDefined(level.skipto_point))
    skipintro = !maps\_skipto::is_default_skipto();

  if(getdvar(#"_id_CCAFCC91") == "0" || level.createfx_enabled)
    skipintro = 1;

  if(skipintro) {
    flag_wait("all_players_connected");

    if(isDefined(level.custom_introscreen)) {
      [
        [level.custom_introscreen]
      ](string1, string2, string3, string4, string5);

      if(!isDefined(level.texture_wait_was_called))
        iprintlnbold("ERROR: need to call waittill_textures_loaded(); in your custom introscreen");

      return;
    }

    waittillframeend;
    level notify("finished final intro screen fadein");
    waittillframeend;
    flag_set("starting final intro screen fadeout");
    waittillframeend;
    level notify("controls_active");
    waittillframeend;
    flag_set("introscreen_complete");
    flag_set("pullup_weapon");
    return;
  }

  if(isDefined(level.custom_introscreen)) {
    [
      [level.custom_introscreen]
    ](string1, string2, string3, string4, string5);

    if(!isDefined(level.texture_wait_was_called))
      iprintlnbold("ERROR: need to call waittill_textures_loaded(); in your custom introscreen");

    return;
  }

  level.introblackbacking = newhudelem();
  level.introblackbacking.x = 0;
  level.introblackbacking.y = 0;
  level.introblackbacking.horzalign = "fullscreen";
  level.introblackbacking.vertalign = "fullscreen";

  if(!isDefined(level.introscreen_shader))
    level.introblackbacking setshader("black", 640, 480);
  else if(level.introscreen_shader != "none")
    level.introblackbacking setshader(level.introscreen_shader, 640, 480);

  if(!isDefined(skipwait))
    flag_wait("all_players_connected");

  if(!isDefined(level.introscreen_dontfreezcontrols))
    freezecontrols_all(1);

  level._introscreen = 1;

  if(isDefined(skipwait))
    flag_wait("all_players_connected");

  wait 0.5;
  level.introstring = [];

  if(isDefined(string1))
    introscreen_create_line(string1);

  if(isDefined(pausetime1))
    wait(pausetime1);
  else
    wait 2;

  if(isDefined(string2))
    introscreen_create_line(string2);

  if(isDefined(string3))
    introscreen_create_line(string3);

  if(isDefined(string4)) {
    if(isDefined(pausetime2))
      wait(pausetime2);
    else
      wait 2;

    introscreen_create_line(string4);
  }

  if(isDefined(string5)) {
    if(isDefined(pausetime2))
      wait(pausetime2);
    else
      wait 2;

    introscreen_create_line(string5);
  }

  level notify("finished final intro screen fadein");

  if(isDefined(level.introscreen_waitontext_flag)) {
    level notify("introscreen_blackscreen_waiting_on_flag");
    flag_wait(level.introscreen_waitontext_flag);
  }

  if(isDefined(timebeforefade))
    wait(timebeforefade);
  else
    wait 3;

  waittill_textures_loaded();
  level.introblackbacking fadeovertime(1.5);
  level.introblackbacking.alpha = 0;
  flag_set("starting final intro screen fadeout");
  level thread freezecontrols_all(0, 0.75);
  level._introscreen = 0;
  level notify("controls_active");
  introscreen_fadeouttext();
  flag_set("introscreen_complete");
}

introscreen_player_connect() {
  if(isDefined(level._introscreen) && level._introscreen)
    self freezecontrols(1);
}

introscreen_report_disconnected_clients() {
  flag_wait("introscreen_complete");

  if(isDefined(level._disconnected_clients)) {
    for(i = 0; i < level._disconnected_clients.size; i++)
      reportclientdisconnected(level._disconnected_clients[i]);
  }
}

introscreen_clear_redacted_flags() {
  flag_clear("introscreen_complete");
  flag_clear("starting final intro screen fadeout");
}