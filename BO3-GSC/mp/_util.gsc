/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_util.gsc
*************************************************/

#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\sound_shared;
#using scripts\shared\util_shared;
#namespace util;

function error(msg) {
  println("", msg);
  wait(0.05);
  if(getdvarstring("") != "") {
    assertmsg("");
  }
}

function warning(msg) {
  println("" + msg);
}

function within_fov(start_origin, start_angles, end_origin, fov) {
  normal = vectornormalize(end_origin - start_origin);
  forward = anglesToForward(start_angles);
  dot = vectordot(forward, normal);
  return dot >= fov;
}

function get_player_height() {
  return 70;
}

function isbulletimpactmod(smeansofdeath) {
  return issubstr(smeansofdeath, "BULLET") || smeansofdeath == "MOD_HEAD_SHOT";
}

function waitrespawnbutton() {
  self endon("disconnect");
  self endon("end_respawn");
  while(self usebuttonpressed() != 1) {
    wait(0.05);
  }
}

function setlowermessage(text, time, combinemessageandtimer) {
  if(!isDefined(self.lowermessage)) {
    return;
  }
  if(isDefined(self.lowermessageoverride) && text != (&"")) {
    text = self.lowermessageoverride;
    time = undefined;
  }
  self notify("lower_message_set");
  self.lowermessage settext(text);
  if(isDefined(time) && time > 0) {
    if(!isDefined(combinemessageandtimer) || !combinemessageandtimer) {
      self.lowertimer.label = & "";
    } else {
      self.lowermessage settext("");
      self.lowertimer.label = text;
    }
    self.lowertimer settimer(time);
  } else {
    self.lowertimer settext("");
    self.lowertimer.label = & "";
  }
  if(self issplitscreen()) {
    self.lowermessage.fontscale = 1.4;
  }
  self.lowermessage fadeovertime(0.05);
  self.lowermessage.alpha = 1;
  self.lowertimer fadeovertime(0.05);
  self.lowertimer.alpha = 1;
}

function setlowermessagevalue(text, value, combinemessage) {
  if(!isDefined(self.lowermessage)) {
    return;
  }
  if(isDefined(self.lowermessageoverride) && text != (&"")) {
    text = self.lowermessageoverride;
    time = undefined;
  }
  self notify("lower_message_set");
  if(!isDefined(combinemessage) || !combinemessage) {
    self.lowermessage settext(text);
  } else {
    self.lowermessage settext("");
  }
  if(isDefined(value) && value > 0) {
    if(!isDefined(combinemessage) || !combinemessage) {
      self.lowertimer.label = & "";
    } else {
      self.lowertimer.label = text;
    }
    self.lowertimer setvalue(value);
  } else {
    self.lowertimer settext("");
    self.lowertimer.label = & "";
  }
  if(self issplitscreen()) {
    self.lowermessage.fontscale = 1.4;
  }
  self.lowermessage fadeovertime(0.05);
  self.lowermessage.alpha = 1;
  self.lowertimer fadeovertime(0.05);
  self.lowertimer.alpha = 1;
}

function clearlowermessage(fadetime) {
  if(!isDefined(self.lowermessage)) {
    return;
  }
  self notify("lower_message_set");
  if(!isDefined(fadetime) || fadetime == 0) {
    setlowermessage(&"");
  } else {
    self endon("disconnect");
    self endon("lower_message_set");
    self.lowermessage fadeovertime(fadetime);
    self.lowermessage.alpha = 0;
    self.lowertimer fadeovertime(fadetime);
    self.lowertimer.alpha = 0;
    wait(fadetime);
    self setlowermessage("");
  }
}

function printonteam(text, team) {
  assert(isDefined(level.players));
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    if(isDefined(player.pers["team"]) && player.pers["team"] == team) {
      player iprintln(text);
    }
  }
}

function printboldonteam(text, team) {
  assert(isDefined(level.players));
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    if(isDefined(player.pers["team"]) && player.pers["team"] == team) {
      player iprintlnbold(text);
    }
  }
}

function printboldonteamarg(text, team, arg) {
  assert(isDefined(level.players));
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    if(isDefined(player.pers["team"]) && player.pers["team"] == team) {
      player iprintlnbold(text, arg);
    }
  }
}

function printonteamarg(text, team, arg) {}

function printonplayers(text, team) {
  players = level.players;
  for(i = 0; i < players.size; i++) {
    if(isDefined(team)) {
      if(isDefined(players[i].pers["team"]) && players[i].pers["team"] == team) {
        players[i] iprintln(text);
      }
      continue;
    }
    players[i] iprintln(text);
  }
}

function printandsoundoneveryone(team, enemyteam, printfriendly, printenemy, soundfriendly, soundenemy, printarg) {
  shoulddosounds = isDefined(soundfriendly);
  shoulddoenemysounds = 0;
  if(isDefined(soundenemy)) {
    assert(shoulddosounds);
    shoulddoenemysounds = 1;
  }
  if(!isDefined(printarg)) {
    printarg = "";
  }
  if(level.splitscreen || !shoulddosounds) {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      playerteam = player.pers["team"];
      if(isDefined(playerteam)) {
        if(playerteam == team && isDefined(printfriendly) && printfriendly != (&"")) {
          player iprintln(printfriendly, printarg);
          continue;
        }
        if(isDefined(printenemy) && printenemy != (&"")) {
          if(isDefined(enemyteam) && playerteam == enemyteam) {
            player iprintln(printenemy, printarg);
            continue;
          }
          if(!isDefined(enemyteam) && playerteam != team) {
            player iprintln(printenemy, printarg);
          }
        }
      }
    }
    if(shoulddosounds) {
      assert(level.splitscreen);
      level.players[0] playlocalsound(soundfriendly);
    }
  } else {
    assert(shoulddosounds);
    if(shoulddoenemysounds) {
      for(i = 0; i < level.players.size; i++) {
        player = level.players[i];
        playerteam = player.pers["team"];
        if(isDefined(playerteam)) {
          if(playerteam == team) {
            if(isDefined(printfriendly) && printfriendly != (&"")) {
              player iprintln(printfriendly, printarg);
            }
            player playlocalsound(soundfriendly);
            continue;
          }
          if(isDefined(enemyteam) && playerteam == enemyteam || (!isDefined(enemyteam) && playerteam != team)) {
            if(isDefined(printenemy) && printenemy != (&"")) {
              player iprintln(printenemy, printarg);
            }
            player playlocalsound(soundenemy);
          }
        }
      }
    } else {
      for(i = 0; i < level.players.size; i++) {
        player = level.players[i];
        playerteam = player.pers["team"];
        if(isDefined(playerteam)) {
          if(playerteam == team) {
            if(isDefined(printfriendly) && printfriendly != (&"")) {
              player iprintln(printfriendly, printarg);
            }
            player playlocalsound(soundfriendly);
            continue;
          }
          if(isDefined(printenemy) && printenemy != (&"")) {
            if(isDefined(enemyteam) && playerteam == enemyteam) {
              player iprintln(printenemy, printarg);
              continue;
            }
            if(!isDefined(enemyteam) && playerteam != team) {
              player iprintln(printenemy, printarg);
            }
          }
        }
      }
    }
  }
}

function _playlocalsound(soundalias) {
  if(level.splitscreen && !self ishost()) {
    return;
  }
  self playlocalsound(soundalias);
}

function getotherteam(team) {
  if(team == "allies") {
    return "axis";
  }
  if(team == "axis") {
    return "allies";
  }
  return "allies";
}

function getteammask(team) {
  if(!level.teambased || !isDefined(team) || !isDefined(level.spawnsystem.ispawn_teammask[team])) {
    return level.spawnsystem.ispawn_teammask_free;
  }
  return level.spawnsystem.ispawn_teammask[team];
}

function getotherteamsmask(skip_team) {
  mask = 0;
  foreach(team in level.teams) {
    if(team == skip_team) {
      continue;
    }
    mask = mask | getteammask(team);
  }
  return mask;
}

function wait_endon(waittime, endonstring, endonstring2, endonstring3, endonstring4) {
  self endon(endonstring);
  if(isDefined(endonstring2)) {
    self endon(endonstring2);
  }
  if(isDefined(endonstring3)) {
    self endon(endonstring3);
  }
  if(isDefined(endonstring4)) {
    self endon(endonstring4);
  }
  wait(waittime);
  return true;
}

function plot_points(plotpoints, r, g, b, timer) {
  lastpoint = plotpoints[0];
  if(!isDefined(r)) {
    r = 1;
  }
  if(!isDefined(g)) {
    g = 1;
  }
  if(!isDefined(b)) {
    b = 1;
  }
  if(!isDefined(timer)) {
    timer = 0.05;
  }
  for(i = 1; i < plotpoints.size; i++) {
    line(lastpoint, plotpoints[i], (r, g, b), 1, timer);
    lastpoint = plotpoints[i];
  }
}

function getfx(fx) {
  assert(isDefined(level._effect[fx]), ("" + fx) + "");
  return level._effect[fx];
}

function set_dvar_if_unset(dvar, value, reset = 0) {
  if(reset || getdvarstring(dvar) == "") {
    setdvar(dvar, value);
    return value;
  }
  return getdvarstring(dvar);
}

function set_dvar_float_if_unset(dvar, value, reset = 0) {
  if(reset || getdvarstring(dvar) == "") {
    setdvar(dvar, value);
  }
  return getdvarfloat(dvar);
}

function set_dvar_int_if_unset(dvar, value, reset = 0) {
  if(reset || getdvarstring(dvar) == "") {
    setdvar(dvar, value);
    return int(value);
  }
  return getdvarint(dvar);
}

function add_trigger_to_ent(ent) {
  if(!isDefined(ent._triggers)) {
    ent._triggers = [];
  }
  ent._triggers[self getentitynumber()] = 1;
}

function remove_trigger_from_ent(ent) {
  if(!isDefined(ent)) {
    return;
  }
  if(!isDefined(ent._triggers)) {
    return;
  }
  if(!isDefined(ent._triggers[self getentitynumber()])) {
    return;
  }
  ent._triggers[self getentitynumber()] = 0;
}

function ent_already_in_trigger(trig) {
  if(!isDefined(self._triggers)) {
    return false;
  }
  if(!isDefined(self._triggers[trig getentitynumber()])) {
    return false;
  }
  if(!self._triggers[trig getentitynumber()]) {
    return false;
  }
  return true;
}

function trigger_thread_death_monitor(ent, ender) {
  ent waittill("death");
  self endon(ender);
  self remove_trigger_from_ent(ent);
}

function trigger_thread(ent, on_enter_payload, on_exit_payload) {
  ent endon("entityshutdown");
  ent endon("death");
  if(ent ent_already_in_trigger(self)) {
    return;
  }
  self add_trigger_to_ent(ent);
  ender = (("end_trig_death_monitor" + self getentitynumber()) + " ") + ent getentitynumber();
  self thread trigger_thread_death_monitor(ent, ender);
  endon_condition = "leave_trigger_" + self getentitynumber();
  if(isDefined(on_enter_payload)) {
    self thread[[on_enter_payload]](ent, endon_condition);
  }
  while(isDefined(ent) && ent istouching(self)) {
    wait(0.01);
  }
  ent notify(endon_condition);
  if(isDefined(ent) && isDefined(on_exit_payload)) {
    self thread[[on_exit_payload]](ent);
  }
  if(isDefined(ent)) {
    self remove_trigger_from_ent(ent);
  }
  self notify(ender);
}

function isstrstart(string1, substr) {
  return getsubstr(string1, 0, substr.size) == substr;
}

function iskillstreaksenabled() {
  return isDefined(level.killstreaksenabled) && level.killstreaksenabled;
}

function setusingremote(remotename, set_killstreak_delay_killcam = 1) {
  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 0;
  }
  assert(!self isusingremote());
  self.usingremote = remotename;
  if(set_killstreak_delay_killcam) {
    self.killstreak_delay_killcam = remotename;
  }
  self disableoffhandweapons();
  self clientfield::set_player_uimodel("hudItems.remoteKillstreakActivated", 1);
  self notify("using_remote");
}

function setobjectivetext(team, text) {
  game["strings"]["objective_" + team] = text;
}

function setobjectivescoretext(team, text) {
  game["strings"]["objective_score_" + team] = text;
}

function setobjectivehinttext(team, text) {
  game["strings"]["objective_hint_" + team] = text;
}

function getobjectivetext(team) {
  return game["strings"]["objective_" + team];
}

function getobjectivescoretext(team) {
  return game["strings"]["objective_score_" + team];
}

function getobjectivehinttext(team) {
  return game["strings"]["objective_hint_" + team];
}

function registerroundswitch(minvalue, maxvalue) {
  level.roundswitch = math::clamp(getgametypesetting("roundSwitch"), minvalue, maxvalue);
  level.roundswitchmin = minvalue;
  level.roundswitchmax = maxvalue;
}

function registerroundlimit(minvalue, maxvalue) {
  level.roundlimit = math::clamp(getgametypesetting("roundLimit"), minvalue, maxvalue);
  level.roundlimitmin = minvalue;
  level.roundlimitmax = maxvalue;
}

function registerroundwinlimit(minvalue, maxvalue) {
  level.roundwinlimit = math::clamp(getgametypesetting("roundWinLimit"), minvalue, maxvalue);
  level.roundwinlimitmin = minvalue;
  level.roundwinlimitmax = maxvalue;
}

function registerscorelimit(minvalue, maxvalue) {
  level.scorelimit = math::clamp(getgametypesetting("scoreLimit"), minvalue, maxvalue);
  level.scorelimitmin = minvalue;
  level.scorelimitmax = maxvalue;
  setdvar("ui_scorelimit", level.scorelimit);
}

function registerroundscorelimit(minvalue, maxvalue) {
  level.roundscorelimit = math::clamp(getgametypesetting("roundScoreLimit"), minvalue, maxvalue);
  level.roundscorelimitmin = minvalue;
  level.roundscorelimitmax = maxvalue;
}

function registertimelimit(minvalue, maxvalue) {
  level.timelimit = math::clamp(getgametypesetting("timeLimit"), minvalue, maxvalue);
  level.timelimitmin = minvalue;
  level.timelimitmax = maxvalue;
  setdvar("ui_timelimit", level.timelimit);
}

function registernumlives(minvalue, maxvalue, teamlivesminvalue = minvalue, teamlivesmaxvalue = maxvalue) {
  level.numlives = math::clamp(getgametypesetting("playerNumLives"), minvalue, maxvalue);
  level.numlivesmin = minvalue;
  level.numlivesmax = maxvalue;
  level.numteamlives = math::clamp(getgametypesetting("teamNumLives"), teamlivesminvalue, teamlivesmaxvalue);
  level.numteamlivesmin = teamlivesminvalue;
  level.numteamlivesmax = teamlivesmaxvalue;
}

function getplayerfromclientnum(clientnum) {
  if(clientnum < 0) {
    return undefined;
  }
  for(i = 0; i < level.players.size; i++) {
    if(level.players[i] getentitynumber() == clientnum) {
      return level.players[i];
    }
  }
  return undefined;
}

function ispressbuild() {
  buildtype = getdvarstring("buildType");
  if(isDefined(buildtype) && buildtype == "press") {
    return true;
  }
  return false;
}

function isflashbanged() {
  return isDefined(self.flashendtime) && gettime() < self.flashendtime;
}

function domaxdamage(origin, attacker, inflictor, headshot, mod) {
  if(isDefined(self.damagedtodeath) && self.damagedtodeath) {
    return;
  }
  if(isDefined(self.maxhealth)) {
    damage = self.maxhealth + 1;
  } else {
    damage = self.health + 1;
  }
  self.damagedtodeath = 1;
  self dodamage(damage, origin, attacker, inflictor, headshot, mod);
}

function self_delete() {
  if(isDefined(self)) {
    self delete();
  }
}

function screen_message_create(string_message_1, string_message_2, string_message_3, n_offset_y, n_time) {
  level notify("screen_message_create");
  level endon("screen_message_create");
  if(isDefined(level.missionfailed) && level.missionfailed) {
    return;
  }
  if(getdvarint("hud_missionFailed") == 1) {
    return;
  }
  if(!isDefined(n_offset_y)) {
    n_offset_y = 0;
  }
  if(!isDefined(level._screen_message_1)) {
    level._screen_message_1 = newhudelem();
    level._screen_message_1.elemtype = "font";
    level._screen_message_1.font = "objective";
    level._screen_message_1.fontscale = 1.8;
    level._screen_message_1.horzalign = "center";
    level._screen_message_1.vertalign = "middle";
    level._screen_message_1.alignx = "center";
    level._screen_message_1.aligny = "middle";
    level._screen_message_1.y = -60 + n_offset_y;
    level._screen_message_1.sort = 2;
    level._screen_message_1.color = (1, 1, 1);
    level._screen_message_1.alpha = 1;
    level._screen_message_1.hidewheninmenu = 1;
  }
  level._screen_message_1 settext(string_message_1);
  if(isDefined(string_message_2)) {
    if(!isDefined(level._screen_message_2)) {
      level._screen_message_2 = newhudelem();
      level._screen_message_2.elemtype = "font";
      level._screen_message_2.font = "objective";
      level._screen_message_2.fontscale = 1.8;
      level._screen_message_2.horzalign = "center";
      level._screen_message_2.vertalign = "middle";
      level._screen_message_2.alignx = "center";
      level._screen_message_2.aligny = "middle";
      level._screen_message_2.y = -33 + n_offset_y;
      level._screen_message_2.sort = 2;
      level._screen_message_2.color = (1, 1, 1);
      level._screen_message_2.alpha = 1;
      level._screen_message_2.hidewheninmenu = 1;
    }
    level._screen_message_2 settext(string_message_2);
  } else if(isDefined(level._screen_message_2)) {
    level._screen_message_2 destroy();
  }
  if(isDefined(string_message_3)) {
    if(!isDefined(level._screen_message_3)) {
      level._screen_message_3 = newhudelem();
      level._screen_message_3.elemtype = "font";
      level._screen_message_3.font = "objective";
      level._screen_message_3.fontscale = 1.8;
      level._screen_message_3.horzalign = "center";
      level._screen_message_3.vertalign = "middle";
      level._screen_message_3.alignx = "center";
      level._screen_message_3.aligny = "middle";
      level._screen_message_3.y = -6 + n_offset_y;
      level._screen_message_3.sort = 2;
      level._screen_message_3.color = (1, 1, 1);
      level._screen_message_3.alpha = 1;
      level._screen_message_3.hidewheninmenu = 1;
    }
    level._screen_message_3 settext(string_message_3);
  } else if(isDefined(level._screen_message_3)) {
    level._screen_message_3 destroy();
  }
  if(isDefined(n_time) && n_time > 0) {
    wait(n_time);
    screen_message_delete();
  }
}

function screen_message_delete(delay) {
  if(isDefined(delay)) {
    wait(delay);
  }
  if(isDefined(level._screen_message_1)) {
    level._screen_message_1 destroy();
  }
  if(isDefined(level._screen_message_2)) {
    level._screen_message_2 destroy();
  }
  if(isDefined(level._screen_message_3)) {
    level._screen_message_3 destroy();
  }
}

function ghost_wait_show(wait_time = 0.1) {
  self endon("death");
  self ghost();
  wait(wait_time);
  self show();
}

function ghost_wait_show_to_player(player, wait_time = 0.1, self_endon_string1) {
  if(!isDefined(self)) {
    return;
  }
  self endon("death");
  self.abort_ghost_wait_show_to_player = undefined;
  if(isDefined(player)) {
    player endon("death");
    player endon("disconnect");
    player endon("joined_team");
    player endon("joined_spectators");
  }
  if(isDefined(self_endon_string1)) {
    self endon(self_endon_string1);
  }
  self ghost();
  self setinvisibletoall();
  self setvisibletoplayer(player);
  wait(wait_time);
  if(!isDefined(self.abort_ghost_wait_show_to_player)) {
    self showtoplayer(player);
  }
}

function ghost_wait_show_to_others(player, wait_time = 0.1, self_endon_string1) {
  if(!isDefined(self)) {
    return;
  }
  self endon("death");
  self.abort_ghost_wait_show_to_others = undefined;
  if(isDefined(player)) {
    player endon("death");
    player endon("disconnect");
    player endon("joined_team");
    player endon("joined_spectators");
  }
  if(isDefined(self_endon_string1)) {
    self endon(self_endon_string1);
  }
  self ghost();
  self setinvisibletoplayer(player);
  wait(wait_time);
  if(!isDefined(self.abort_ghost_wait_show_to_others)) {
    self show();
    self setinvisibletoplayer(player);
  }
}

function use_button_pressed() {
  assert(isplayer(self), "");
  return self usebuttonpressed();
}

function waittill_use_button_pressed() {
  while(!self use_button_pressed()) {
    wait(0.05);
  }
}

function show_hint_text(str_text_to_show, b_should_blink = 0, str_turn_off_notify = "notify_turn_off_hint_text", n_display_time = 4) {
  self endon("notify_turn_off_hint_text");
  self endon("hint_text_removed");
  if(isDefined(self.hint_menu_handle)) {
    hide_hint_text(0);
  }
  self.hint_menu_handle = self openluimenu("MPHintText");
  self setluimenudata(self.hint_menu_handle, "hint_text_line", str_text_to_show);
  if(b_should_blink) {
    lui::play_animation(self.hint_menu_handle, "blinking");
  } else {
    lui::play_animation(self.hint_menu_handle, "display_noblink");
  }
  if(n_display_time != -1) {
    self thread hide_hint_text_listener(n_display_time);
    self thread fade_hint_text_after_time(n_display_time, str_turn_off_notify);
  }
}

function hide_hint_text(b_fade_before_hiding = 1) {
  self endon("hint_text_removed");
  if(isDefined(self.hint_menu_handle)) {
    if(b_fade_before_hiding) {
      lui::play_animation(self.hint_menu_handle, "fadeout");
      waittill_any_timeout(0.75, "kill_hint_text", "death", "hint_text_removed");
    }
    self closeluimenu(self.hint_menu_handle);
    self.hint_menu_handle = undefined;
  }
  self notify("hint_text_removed");
}

function fade_hint_text_after_time(n_display_time, str_turn_off_notify) {
  self endon("hint_text_removed");
  self endon("death");
  self endon("kill_hint_text");
  waittill_any_timeout(n_display_time - 0.75, str_turn_off_notify, "hint_text_removed", "kill_hint_text");
  hide_hint_text(1);
}

function hide_hint_text_listener(n_time) {
  self endon("hint_text_removed");
  self endon("disconnect");
  waittill_any_timeout(n_time, "kill_hint_text", "death", "hint_text_removed", "disconnect");
  hide_hint_text(0);
}

function set_team_radar(team, value) {
  if(team == "allies") {
    setmatchflag("radar_allies", value);
  } else if(team == "axis") {
    setmatchflag("radar_axis", value);
  }
}

function init_player_contract_events() {
  if(!isDefined(level.player_contract_events)) {
    level.player_contract_events = [];
  }
}

function register_player_contract_event(event_name, event_func, max_param_count = 0) {
  if(!isDefined(level.player_contract_events[event_name])) {
    level.player_contract_events[event_name] = spawnStruct();
    level.player_contract_events[event_name].param_count = max_param_count;
    level.player_contract_events[event_name].events = [];
  }
  assert(max_param_count == level.player_contract_events[event_name].param_count);
  level.player_contract_events[event_name].events[level.player_contract_events[event_name].events.size] = event_func;
}

function player_contract_event(event_name, param1 = undefined, param2 = undefined, param3 = undefined) {
  if(!isDefined(level.player_contract_events[event_name])) {
    return;
  }
  param_count = (isDefined(level.player_contract_events[event_name].param_count) ? level.player_contract_events[event_name].param_count : 0);
  switch (param_count) {
    case 0:
    default: {
      foreach(event_func in level.player_contract_events[event_name].events) {
        if(isDefined(event_func)) {
          self[[event_func]]();
        }
      }
      break;
    }
    case 1: {
      foreach(event_func in level.player_contract_events[event_name].events) {
        if(isDefined(event_func)) {
          self[[event_func]](param1);
        }
      }
      break;
    }
    case 2: {
      foreach(event_func in level.player_contract_events[event_name].events) {
        if(isDefined(event_func)) {
          self[[event_func]](param1, param2);
        }
      }
      break;
    }
    case 3: {
      foreach(event_func in level.player_contract_events[event_name].events) {
        if(isDefined(event_func)) {
          self[[event_func]](param1, param2, param3);
        }
      }
      break;
    }
  }
}

function debug_slow_heli_speed() {
  if(getdvarint("", 0) > 0) {
    self setspeed(getdvarint(""));
  }
}

function is_objective_game(game_type) {
  switch (game_type) {
    case "conf":
    case "dm":
    case "gun":
    case "tdm": {
      return false;
      break;
    }
    default: {
      return true;
    }
  }
}

function isprophuntgametype() {
  return isDefined(level.isprophunt) && level.isprophunt;
}

function isprop() {
  return isDefined(self.pers["team"]) && self.pers["team"] == game["defenders"];
}

function function_a7d853be(amount) {
  if(getdvarint("ui_enablePromoTracking", 0)) {
    function_a4c90358("cwl_thermometer", amount);
  }
}

function function_938b1b6b() {
  return isDefined(level.var_f817b02b) && level.var_f817b02b;
}