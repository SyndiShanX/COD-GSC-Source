/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_util.gsc
*************************************************/

#using scripts\cp\_oed;
#using scripts\cp\_skipto;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\cp\gametypes\coop;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\load_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\sound_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\string_shared;
#using scripts\shared\util_shared;
#namespace util;

function add_gametype(gt) {}

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
  while(self useButtonPressed() != 1) {
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
      self.lowertimer.label = &"";
    } else {
      self.lowermessage settext("");
      self.lowertimer.label = text;
    }
    self.lowertimer settimer(time);
  } else {
    self.lowertimer settext("");
    self.lowertimer.label = &"";
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
      self.lowertimer.label = &"";
    } else {
      self.lowertimer.label = text;
    }
    self.lowertimer setvalue(value);
  } else {
    self.lowertimer settext("");
    self.lowertimer.label = &"";
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

function plot_points(plotpoints, r = 1, g = 1, b = 1, server_frames = 1) {
  lastpoint = plotpoints[0];
  server_frames = int(server_frames);
  for(i = 1; i < plotpoints.size; i++) {
    line(lastpoint, plotpoints[i], (r, g, b), 1, server_frames);
    lastpoint = plotpoints[i];
  }
}

function getfx(fx) {
  assert(isDefined(level._effect[fx]), ("" + fx) + "");
  return level._effect[fx];
}

function set_dvar_if_unset(dvar, value, reset = 0) {
  if(reset || getdvarstring(dvar) == "") {
    setDvar(dvar, value);
    return value;
  }
  return getdvarstring(dvar);
}

function set_dvar_float_if_unset(dvar, value, reset = 0) {
  if(reset || getdvarstring(dvar) == "") {
    setDvar(dvar, value);
  }
  return getdvarfloat(dvar);
}

function set_dvar_int_if_unset(dvar, value, reset = 0) {
  if(reset || getdvarstring(dvar) == "") {
    setDvar(dvar, value);
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

function setusingremote(remotename) {
  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 0;
  }
  assert(!self isusingremote());
  self.usingremote = remotename;
  self disableoffhandweapons();
  self notify("using_remote");
}

function getremotename() {
  assert(self isusingremote());
  return self.usingremote;
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
  setDvar("ui_scorelimit", level.scorelimit);
}

function registertimelimit(minvalue, maxvalue) {
  level.timelimit = math::clamp(getgametypesetting("timeLimit"), minvalue, maxvalue);
  level.timelimitmin = minvalue;
  level.timelimitmax = maxvalue;
  setDvar("ui_timelimit", level.timelimit);
}

function registernumlives(minvalue, maxvalue) {
  level.numlives = math::clamp(getgametypesetting("playerNumLives"), minvalue, maxvalue);
  level.numlivesmin = minvalue;
  level.numlivesmax = maxvalue;
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

function isentstunned() {
  time = gettime();
  if(isDefined(self.stunned) && self.stunned) {
    return true;
  }
  if(self isflashbanged()) {
    return true;
  }
  if(isDefined(self.stun_fx)) {
    return true;
  }
  if(isDefined(self.laststunnedtime) && (self.laststunnedtime + 5000) > time) {
    return true;
  }
  if(isDefined(self.concussionendtime) && self.concussionendtime > time) {
    return true;
  }
  return false;
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

function screen_message_create_client(string_message_1, string_message_2, string_message_3, n_offset_y, n_time) {
  self notify("screen_message_create");
  self endon("screen_message_create");
  self endon("death");
  if(isDefined(level.missionfailed) && level.missionfailed) {
    return;
  }
  if(getdvarint("hud_missionFailed") == 1) {
    return;
  }
  if(!isDefined(n_offset_y)) {
    n_offset_y = 0;
  }
  if(!isDefined(self._screen_message_1)) {
    self._screen_message_1 = newclienthudelem(self);
    self._screen_message_1.elemtype = "font";
    self._screen_message_1.font = "objective";
    self._screen_message_1.fontscale = 1.8;
    self._screen_message_1.horzalign = "center";
    self._screen_message_1.vertalign = "middle";
    self._screen_message_1.alignx = "center";
    self._screen_message_1.aligny = "middle";
    self._screen_message_1.y = -60 + n_offset_y;
    self._screen_message_1.sort = 2;
    self._screen_message_1.color = (1, 1, 1);
    self._screen_message_1.alpha = 1;
    self._screen_message_1.hidewheninmenu = 1;
  }
  self._screen_message_1 settext(string_message_1);
  if(isDefined(string_message_2)) {
    if(!isDefined(self._screen_message_2)) {
      self._screen_message_2 = newclienthudelem(self);
      self._screen_message_2.elemtype = "font";
      self._screen_message_2.font = "objective";
      self._screen_message_2.fontscale = 1.8;
      self._screen_message_2.horzalign = "center";
      self._screen_message_2.vertalign = "middle";
      self._screen_message_2.alignx = "center";
      self._screen_message_2.aligny = "middle";
      self._screen_message_2.y = -33 + n_offset_y;
      self._screen_message_2.sort = 2;
      self._screen_message_2.color = (1, 1, 1);
      self._screen_message_2.alpha = 1;
      self._screen_message_2.hidewheninmenu = 1;
    }
    self._screen_message_2 settext(string_message_2);
  } else if(isDefined(self._screen_message_2)) {
    self._screen_message_2 destroy();
  }
  if(isDefined(string_message_3)) {
    if(!isDefined(self._screen_message_3)) {
      self._screen_message_3 = newclienthudelem(self);
      self._screen_message_3.elemtype = "font";
      self._screen_message_3.font = "objective";
      self._screen_message_3.fontscale = 1.8;
      self._screen_message_3.horzalign = "center";
      self._screen_message_3.vertalign = "middle";
      self._screen_message_3.alignx = "center";
      self._screen_message_3.aligny = "middle";
      self._screen_message_3.y = -6 + n_offset_y;
      self._screen_message_3.sort = 2;
      self._screen_message_3.color = (1, 1, 1);
      self._screen_message_3.alpha = 1;
      self._screen_message_3.hidewheninmenu = 1;
    }
    self._screen_message_3 settext(string_message_3);
  } else if(isDefined(self._screen_message_3)) {
    self._screen_message_3 destroy();
  }
  if(isDefined(n_time) && n_time > 0) {
    wait(n_time);
    self screen_message_delete_client();
  }
}

function screen_message_delete_client(delay) {
  self endon("death");
  if(isDefined(delay)) {
    wait(delay);
  }
  if(isDefined(self._screen_message_1)) {
    self._screen_message_1 destroy();
  }
  if(isDefined(self._screen_message_2)) {
    self._screen_message_2 destroy();
  }
  if(isDefined(self._screen_message_3)) {
    self._screen_message_3 destroy();
  }
}

function screen_fade_out(n_time, str_shader, str_menu_id) {
  level lui::screen_fade_out(n_time, str_shader, str_menu_id);
}

function screen_fade_in(n_time, str_shader, str_menu_id) {
  level lui::screen_fade_in(n_time, str_shader, str_menu_id);
}

function screen_fade_to_alpha_with_blur(n_alpha, n_fade_time, n_blur, str_shader) {
  assert(isDefined(n_alpha), "");
  assert(isPlayer(self), "");
  level notify("_screen_fade");
  level endon("_screen_fade");
  hud_fade = get_fade_hud(str_shader);
  hud_fade fadeovertime(n_fade_time);
  hud_fade.alpha = n_alpha;
  if(isDefined(n_blur) && n_blur >= 0) {
    self setblur(n_blur, n_fade_time);
  }
  wait(n_fade_time);
}

function screen_fade_to_alpha(n_alpha, n_fade_time, str_shader) {
  screen_fade_to_alpha_with_blur(n_alpha, n_fade_time, 0, str_shader);
}

function get_fade_hud(str_shader = "black") {
  if(!isDefined(level.fade_hud)) {
    level.fade_hud = newhudelem();
    level.fade_hud.x = 0;
    level.fade_hud.y = 0;
    level.fade_hud.horzalign = "fullscreen";
    level.fade_hud.vertalign = "fullscreen";
    level.fade_hud.sort = 0;
    level.fade_hud.alpha = 0;
  }
  level.fade_hud setshader(str_shader, 640, 480);
  return level.fade_hud;
}

function missionfailedwrapper(fail_reason, fail_hint, shader, iwidth, iheight, fdelay, x, y, b_count_as_death = 1) {
  if(level.missionfailed) {
    return;
  }
  if(isDefined(level.nextmission)) {
    return;
  }
  if(getdvarstring("failure_disabled") == "1") {
    return;
  }
  screen_message_delete();
  if(isDefined(fail_hint)) {
    setDvar("ui_deadquote", fail_hint);
  }
  if(isDefined(shader)) {
    getplayers()[0] thread load::special_death_indicator_hudelement(shader, iwidth, iheight, fdelay, x, y);
  }
  level.missionfailed = 1;
  level thread coop::function_5ed5738a(fail_reason, fail_hint);
}

function missionfailedwrapper_nodeath(fail_reason, fail_hint, shader, iwidth, iheight, fdelay, x, y) {
  missionfailedwrapper(fail_reason, fail_hint, shader, iwidth, iheight, fdelay, x, y, 0);
}

function helper_message(message, delay, str_abort_flag) {
  level notify("kill_helper_message");
  level endon("kill_helper_message");
  helper_message_delete();
  level.helper_message = message;
  screen_message_create(message);
  if(!isDefined(delay)) {
    delay = 5;
  }
  start_time = gettime();
  while(true) {
    time = gettime();
    dt = (time - start_time) / 1000;
    if(dt >= delay) {
      break;
    }
    if(isDefined(str_abort_flag) && level flag::get(str_abort_flag) == 1) {
      break;
    }
    wait(0.01);
  }
  if(isDefined(level.helper_message)) {
    screen_message_delete();
  }
  level.helper_message = undefined;
}

function helper_message_delete() {
  if(isDefined(level.helper_message)) {
    screen_message_delete();
  }
  level.helper_message = undefined;
}

function show_hit_marker() {
  if(isDefined(self) && isDefined(self.hud_damagefeedback)) {
    self.hud_damagefeedback setshader("damage_feedback", 24, 48);
    self.hud_damagefeedback.alpha = 1;
    self.hud_damagefeedback fadeovertime(1);
    self.hud_damagefeedback.alpha = 0;
  }
}

function init_hero(name, func_init, arg1, arg2, arg3, arg4, arg5, b_show_in_ev = 1) {
  if(!isDefined(level.heroes)) {
    level.heroes = [];
  }
  name = tolower(name);
  ai_hero = getent(name + "_ai", "targetname", 1);
  if(!isalive(ai_hero)) {
    ai_hero = getent(name, "targetname", 1);
    if(!isalive(ai_hero)) {
      spawner = getent(name, "targetname");
      if(!(isDefined(spawner.spawning) && spawner.spawning)) {
        spawner.count++;
        ai_hero = spawner::simple_spawn_single(spawner);
        assert(isDefined(ai_hero), ("" + name) + "");
        spawner notify("hero_spawned", ai_hero);
      } else {
        spawner waittill("hero_spawned", ai_hero);
      }
    }
  }
  level.heroes[name] = ai_hero;
  ai_hero.animname = name;
  ai_hero.is_hero = 1;
  ai_hero.enableterrainik = 1;
  ai_hero settmodeprovider(1);
  ai_hero magic_bullet_shield();
  ai_hero thread _hero_death(name);
  if(isDefined(func_init)) {
    single_thread(ai_hero, func_init, arg1, arg2, arg3, arg4, arg5);
  }
  if(isDefined(level.customherospawn)) {
    ai_hero[[level.customherospawn]]();
  }
  if(b_show_in_ev) {
    ai_hero thread oed::enable_thermal();
  }
  return ai_hero;
}

function init_heroes(a_hero_names, func, arg1, arg2, arg3, arg4, arg5) {
  a_heroes = [];
  foreach(str_hero in a_hero_names) {
    if(!isDefined(a_heroes)) {
      a_heroes = [];
    } else if(!isarray(a_heroes)) {
      a_heroes = array(a_heroes);
    }
    a_heroes[a_heroes.size] = init_hero(str_hero, func, arg1, arg2, arg3, arg4, arg5);
  }
  return a_heroes;
}

function _hero_death(str_name) {
  self endon("unmake_hero");
  self waittill("death");
  if(isDefined(self)) {
    assertmsg(("" + str_name) + "");
  }
  unmake_hero(str_name);
}

function unmake_hero(str_name) {
  ai_hero = level.heroes[str_name];
  level.heroes = array::remove_index(level.heroes, str_name, 1);
  if(isalive(ai_hero)) {
    ai_hero settmodeprovider(0);
    ai_hero stop_magic_bullet_shield();
    ai_hero notify("unmake_hero");
  }
}

function get_heroes() {
  return level.heroes;
}

function get_hero(str_name) {
  if(!isDefined(level.heroes)) {
    level.heroes = [];
  }
  if(isDefined(level.heroes[str_name])) {
    return level.heroes[str_name];
  }
  return init_hero(str_name);
}

function is_hero() {
  return isDefined(self.is_hero) && self.is_hero;
}

function init_streamer_hints(number_of_zones) {
  clientfield::register("world", "force_streamer", 1, getminbitcountfornum(number_of_zones), "int");
}

function clear_streamer_hint() {
  level flag::wait_till("all_players_connected");
  level clientfield::set("force_streamer", 0);
}

function set_streamer_hint(n_zone, b_clear_previous = 1) {
  level thread _set_streamer_hint(n_zone, b_clear_previous);
}

function _set_streamer_hint(n_zone, b_clear_previous = 1) {
  level notify("set_streamer_hint");
  level endon("set_streamer_hint");
  assert(n_zone > 0, "");
  level flagsys::set("streamer_loading");
  level flag::wait_till("all_players_connected");
  if(b_clear_previous) {
    level clientfield::set("force_streamer", 0);
    wait_network_frame();
  }
  level clientfield::set("force_streamer", n_zone);
  if(!isDefined(level.b_wait_for_streamer_default)) {
    level.b_wait_for_streamer_default = 1;
    level.b_wait_for_streamer_default = 0;
  }
  foreach(player in level.players) {
    player thread _streamer_hint_wait(n_zone);
  }
  n_timeout = gettime() + 15000;
  array::wait_till(level.players, "streamer" + n_zone, 15);
  level flagsys::clear("streamer_loading");
  level streamer_wait();
  if(gettime() >= n_timeout) {
    printtoprightln("" + string::rfill(gettime(), 6, ""), (1, 0, 0));
  } else {
    printtoprightln("" + string::rfill(gettime(), 6, ""), (1, 1, 1));
  }
}

function _streamer_hint_wait(n_zone) {
  self endon("disconnect");
  level endon("set_streamer_hint");
  self waittillmatch("streamer");
  self notify("streamer" + n_zone, n_zone);
}

function teleport_players_igc(str_spots, coop_sort) {
  if(level.players.size <= 1) {
    return;
  }
  a_spots = skipto::get_spots(str_spots, coop_sort);
  assert(a_spots.size >= (level.players.size - 1), "");
  for(i = 0; i < (level.players.size - 1); i++) {
    level.players[i + 1] setorigin(a_spots[i].origin);
    if(isDefined(a_spots[i].angles)) {
      level.players[i + 1] delay_network_frames(2, "disconnect", &setplayerangles, a_spots[i].angles);
    }
  }
}

function set_low_ready(b_lowready) {
  self setlowready(b_lowready);
  self setclientuivisibilityflag("weapon_hud_visible", !b_lowready);
  self allowjump(!b_lowready);
  self allowsprint(!b_lowready);
  self allowdoublejump(!b_lowready);
  if(b_lowready) {
    self disableoffhandweapons();
  } else {
    self enableoffhandweapons();
  }
  oed::enable_ev(!b_lowready);
  oed::enable_tac_mode(!b_lowready);
}

function cleanupactorcorpses() {
  foreach(corpse in getcorpsearray()) {
    if(isactorcorpse(corpse)) {
      corpse delete();
    }
  }
}

function set_level_start_flag(str_flag) {
  level.str_level_start_flag = str_flag;
  if(!flag::exists(str_flag)) {
    level flag::init(level.str_level_start_flag);
  }
}

function set_player_start_flag(str_flag) {
  level.str_player_start_flag = str_flag;
}

function set_rogue_controlled(b_state = 1) {
  if(b_state) {
    self cybercom::cybercom_aioptout("cybercom_hijack");
    self cybercom::cybercom_aioptout("cybercom_iffoverride");
    self.rogue_controlled = 1;
  } else {
    self cybercom::cybercom_aiclearoptout("cybercom_hijack");
    self cybercom::cybercom_aiclearoptout("cybercom_iffoverride");
    self.rogue_controlled = undefined;
  }
}

function init_breath_fx() {
  clientfield::register("toplayer", "player_cold_breath", 1, 1, "int");
  clientfield::register("actor", "ai_cold_breath", 1, 1, "counter");
}

function player_frost_breath(b_true) {
  self clientfield::set_to_player("player_cold_breath", b_true);
}

function ai_frost_breath() {
  self endon("death");
  if(self.archetype === "human") {
    wait(randomfloatrange(1, 3));
    self clientfield::increment("ai_cold_breath");
  }
}

function show_hint_text(str_text_to_show, b_should_blink = 0, str_turn_off_notify = "notify_turn_off_hint_text", n_display_time = 4) {
  self endon("notify_turn_off_hint_text");
  self endon("hint_text_removed");
  if(isDefined(self.hint_menu_handle)) {
    hide_hint_text(0);
  }
  self.hint_menu_handle = self openluimenu("CPHintText");
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
      waittill_any_timeout(0.75, "kill_hint_text", "death");
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
  waittill_any_timeout(n_display_time - 0.75, str_turn_off_notify);
  hide_hint_text(1);
}

function hide_hint_text_listener(n_time) {
  self endon("hint_text_removed");
  self endon("disconnect");
  waittill_any_timeout(n_time, "kill_hint_text", "death");
  hide_hint_text(0);
}

function show_event_message(player_handle, str_message) {
  player_handle luinotifyevent(&"comms_event_message", 1, str_message);
}

function init_interactive_gameobject(trigger, str_objective, str_hint_text, func_on_use, a_keyline_objects) {
  trigger sethintstring(str_hint_text);
  trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
  if(!isDefined(a_keyline_objects)) {
    a_keyline_objects = [];
  } else {
    if(!isDefined(a_keyline_objects)) {
      a_keyline_objects = [];
    } else if(!isarray(a_keyline_objects)) {
      a_keyline_objects = array(a_keyline_objects);
    }
    foreach(mdl in a_keyline_objects) {
      mdl oed::enable_keyline(1);
    }
  }
  game_object = gameobjects::create_use_object("any", trigger, a_keyline_objects, (0, 0, 0), str_objective);
  game_object gameobjects::allow_use("any");
  game_object gameobjects::set_use_time(0.35);
  game_object gameobjects::set_owner_team("allies");
  game_object gameobjects::set_visible_team("any");
  game_object.single_use = 0;
  game_object.origin = game_object.origin;
  game_object.angles = game_object.angles;
  if(isDefined(func_on_use)) {
    game_object.onuse = func_on_use;
  }
  return game_object;
}