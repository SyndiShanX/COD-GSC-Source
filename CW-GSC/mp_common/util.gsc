/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\util.gsc
***********************************************/

#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#namespace util;

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
  self endon(#"disconnect", #"end_respawn");

  while(self useButtonPressed() != 1) {
    waitframe(1);
  }
}

function printonteam(text, team) {
  assert(isDefined(level.players));

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(isDefined(player.pers[#"team"]) && player.pers[#"team"] == team) {
      player iprintln(text);
    }
  }
}

function printboldonteam(text, team) {
  assert(isDefined(level.players));

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(isDefined(player.pers[#"team"]) && player.pers[#"team"] == team) {
      player iprintlnbold(text);
    }
  }
}

function printboldonteamarg(text, team, arg) {
  assert(isDefined(level.players));

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(isDefined(player.pers[#"team"]) && player.pers[#"team"] == team) {
      player iprintlnbold(text, arg);
    }
  }
}

function printonteamarg(text, team, arg) {}

function printonplayers(text, team) {
  players = level.players;

  for(i = 0; i < players.size; i++) {
    if(isDefined(team)) {
      if(isDefined(players[i].pers[#"team"]) && players[i].pers[#"team"] == team) {
        players[i] iprintln(text);
      }

      continue;
    }

    players[i] iprintln(text);
  }
}

function function_f0b75565(players, sound) {
  assert(isDefined(sound));

  if(level.splitscreen) {
    assert(level.splitscreen);
    assert(isDefined(players[0]));
    players[0] playlocalsound(sound);
    return;
  }

  foreach(player in players) {
    player playlocalsound(sound);
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
      playerteam = player.pers[#"team"];

      if(isDefined(playerteam)) {
        if(playerteam == team && isDefined(printfriendly) && printfriendly != # "") {
          player iprintln(printfriendly, printarg);
          continue;
        }

        if(isDefined(printenemy) && printenemy != # "") {
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

    return;
  }

  assert(shoulddosounds);

  if(shoulddoenemysounds) {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      playerteam = player.pers[#"team"];

      if(isDefined(playerteam)) {
        if(playerteam == team) {
          if(isDefined(printfriendly) && printfriendly != # "") {
            player iprintln(printfriendly, printarg);
          }

          player playlocalsound(soundfriendly);
          continue;
        }

        if(isDefined(enemyteam) && playerteam == enemyteam || !isDefined(enemyteam) && playerteam != team) {
          if(isDefined(printenemy) && printenemy != # "") {
            player iprintln(printenemy, printarg);
          }

          player playlocalsound(soundenemy);
        }
      }
    }

    return;
  }

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    playerteam = player.pers[#"team"];

    if(isDefined(playerteam)) {
      if(playerteam == team) {
        if(isDefined(printfriendly) && printfriendly != # "") {
          player iprintln(printfriendly, printarg);
        }

        player playlocalsound(soundfriendly);
        continue;
      }

      if(isDefined(printenemy) && printenemy != # "") {
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

function _playlocalsound(soundalias) {
  if(level.splitscreen && !self ishost()) {
    return;
  }

  self playlocalsound(soundalias);
}

function getotherteam(team) {
  if(team == # "allies") {
    return # "axis";
  } else if(team == # "axis") {
    return # "allies";
  } else {
    return # "allies";
  }

  assertmsg("<dev string:x38>" + team);
}

function getteamenum(team) {
  if(team == # "allies") {
    return 1;
  } else if(team == # "axis") {
    return 2;
  }

  assertmsg("<dev string:x57>" + team);
}

function getteammask(team) {
  if(!level.teambased || !isDefined(team) || !isDefined(level.spawnsystem.ispawn_teammask[team])) {
    return level.spawnsystem.var_c2989de;
  }

  return level.spawnsystem.ispawn_teammask[team];
}

function getotherteamsmask(skip_team) {
  mask = 0;

  foreach(team, _ in level.teams) {
    if(team == skip_team) {
      continue;
    }

    mask |= getteammask(team);
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

  wait waittime;
  return true;
}

function getfx(fx) {
  assert(isDefined(level._effect[fx]), "<dev string:x75>" + fx + "<dev string:x7c>");
  return level._effect[fx];
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
  ent waittill(#"death");
  self endon(ender);
  self remove_trigger_from_ent(ent);
}

function trigger_thread(ent, on_enter_payload, on_exit_payload) {
  ent endon(#"death");

  if(ent ent_already_in_trigger(self)) {
    return;
  }

  self add_trigger_to_ent(ent);
  ender = "end_trig_death_monitor" + self getentitynumber() + " " + ent getentitynumber();
  self thread trigger_thread_death_monitor(ent, ender);
  endon_condition = "leave_trigger_" + self getentitynumber();

  if(isDefined(on_enter_payload)) {
    self thread[[on_enter_payload]](ent, endon_condition);
  }

  while(isDefined(ent) && ent istouching(self)) {
    wait 0.01;
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

function private function_78e3e07b(team, index, objective_strings) {
  setobjectivetext(team, objective_strings.text);

  if(level.splitscreen) {
    setobjectivescoretext(team, objective_strings.score_text);
  } else {
    setobjectivescoretext(team, objective_strings.var_4687634f);
  }

  function_db4846b(team, index);
}

function function_e17a230f(team) {
  if(!isDefined(level.var_d1455682)) {
    return;
  }

  objective_strings = level.var_d1455682.var_e64a4485;

  if(!isDefined(objective_strings)) {
    setobjectivetext(team, "");
    return;
  }

  foreach(index, var_53c9b682 in objective_strings) {
    if(is_true(var_53c9b682.attacker) && team != game.attackers) {
      continue;
    }

    if(is_true(var_53c9b682.defender) && team != game.defenders) {
      continue;
    }

    if(is_true(var_53c9b682.overtime)) {
      if(!game.overtime_round) {
        continue;
      }

      if(is_true(var_53c9b682.overtime_round) && var_53c9b682.overtime_round != game.overtime_round) {
        continue;
      }

      if(is_true(var_53c9b682.var_47177317) && isDefined(game.overtime_first_winner) && team != game.overtime_first_winner) {
        continue;
      }

      if(is_true(var_53c9b682.var_76fa703c) && isDefined(game.overtime_first_winner) && team == game.overtime_first_winner) {
        continue;
      }
    }

    function_78e3e07b(team, index, var_53c9b682);
    return;
  }
}

function function_9540d9b6() {
  if(!isDefined(level.var_d1455682)) {
    return;
  }

  foreach(team, _ in level.teams) {
    function_e17a230f(team);
  }
}

function setobjectivetext(team, text) {
  if(!isDefined(level.teams[team])) {
    return;
  }

  game.strings["objective_" + level.teams[team]] = text;
}

function setobjectivescoretext(team, text) {
  if(!isDefined(level.teams[team])) {
    return;
  }

  game.strings["objective_score_" + level.teams[team]] = text;
}

function function_db4846b(team, text) {
  if(!isDefined(level.teams[team])) {
    return;
  }

  game.strings["objective_first_spawn_hint_" + level.teams[team]] = text;
}

function getobjectivetext(team) {
  if(!isDefined(level.teams[team])) {
    return;
  }

  return game.strings["objective_" + level.teams[team]];
}

function getobjectivescoretext(team) {
  assert(isDefined(level.teams[team]));
  assert(isDefined(game.strings["<dev string:xa1>" + level.teams[team]]));

  if(!isDefined(level.teams[team])) {
    return;
  }

  return game.strings["objective_score_" + level.teams[team]];
}

function function_4a118b30(team) {
  if(!isDefined(level.teams[team])) {
    return;
  }

  return game.strings["objective_first_spawn_hint_" + level.teams[team]];
}

function registerroundswitch(minvalue, maxvalue) {
  level.roundswitch = math::clamp(getgametypesetting(#"roundswitch"), minvalue, maxvalue);
  level.roundswitchmin = minvalue;
  level.roundswitchmax = maxvalue;
}

function registerroundlimit(minvalue, maxvalue) {
  level.roundlimit = math::clamp(getgametypesetting(#"roundlimit"), minvalue, maxvalue);
  level.roundlimitmin = minvalue;
  level.roundlimitmax = maxvalue;
}

function registerroundwinlimit(minvalue, maxvalue) {
  level.roundwinlimit = math::clamp(getgametypesetting(#"roundwinlimit"), minvalue, maxvalue);
  level.roundwinlimitmin = minvalue;
  level.roundwinlimitmax = maxvalue;
}

function registerscorelimit(minvalue, maxvalue) {
  level.scorelimit = math::clamp(getgametypesetting(#"scorelimit"), minvalue, maxvalue);
  level.scorelimitmin = minvalue;
  level.scorelimitmax = maxvalue;
}

function registerroundscorelimit(minvalue, maxvalue) {
  level.roundscorelimit = math::clamp(getgametypesetting(#"roundscorelimit"), minvalue, maxvalue);
  level.roundscorelimitmin = minvalue;
  level.roundscorelimitmax = maxvalue;
}

function registertimelimit(minvalue, maxvalue) {
  level.timelimit = math::clamp(getgametypesetting(#"timelimit"), minvalue, maxvalue);

  override_gts_timelimit();

  level.timelimitmin = minvalue;
  level.timelimitmax = maxvalue;
}

function registernumlives(minvalue, maxvalue, teamlivesminvalue = minvalue, teamlivesmaxvalue = maxvalue) {
  level.numlives = math::clamp(getgametypesetting(#"playernumlives"), minvalue, maxvalue);
  level.numlivesmin = minvalue;
  level.numlivesmax = maxvalue;
  level.numteamlives = math::clamp(getgametypesetting(#"teamnumlives"), teamlivesminvalue, teamlivesmaxvalue);
  level.numteamlivesmin = isDefined(teamlivesminvalue) ? teamlivesminvalue : level.numlivesmin;
  level.numteamlivesmax = isDefined(teamlivesmaxvalue) ? teamlivesmaxvalue : level.numlivesmax;
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
  buildtype = getdvarstring(#"buildtype");

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

function use_button_pressed() {
  assert(isPlayer(self), "<dev string:xb5>");
  return self useButtonPressed();
}

function waittill_use_button_pressed() {
  while(!self use_button_pressed()) {
    waitframe(1);
  }
}

function show_hint_text(str_text_to_show, b_should_blink = 0, str_turn_off_notify = "notify_turn_off_hint_text", n_display_time = 4) {
  self endon(#"notify_turn_off_hint_text", #"hint_text_removed");

  if(isDefined(self.hint_menu_handle)) {
    hide_hint_text(0);
  }

  self.hint_menu_handle = self openluimenu("MPHintText");
  self setluimenudata(self.hint_menu_handle, #"hint_text_line", str_text_to_show);

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
  self endon(#"hint_text_removed");

  if(isDefined(self.hint_menu_handle)) {
    if(b_fade_before_hiding) {
      lui::play_animation(self.hint_menu_handle, "fadeout");
      self waittilltimeout(0.75, #"kill_hint_text", #"death", #"hint_text_removed");
    }

    self closeluimenu(self.hint_menu_handle);
    self.hint_menu_handle = undefined;
  }

  self notify(#"hint_text_removed");
}

function fade_hint_text_after_time(n_display_time, str_turn_off_notify) {
  self endon(#"hint_text_removed", #"death", #"kill_hint_text");
  self waittilltimeout(n_display_time - 0.75, str_turn_off_notify, #"hint_text_removed", #"kill_hint_text");
  hide_hint_text(1);
}

function hide_hint_text_listener(n_time) {
  self endon(#"hint_text_removed", #"disconnect");
  self waittilltimeout(n_time, #"kill_hint_text", #"death", #"hint_text_removed", #"disconnect");
  hide_hint_text(0);
}

function set_team_radar(team, value) {
  if(team == # "allies") {
    setmatchflag("radar_allies", value);
    return;
  }

  if(team == # "axis") {
    setmatchflag("radar_axis", value);
  }
}

function is_objective_game(game_type) {
  switch (game_type) {
    case # "dm":
    case # "conf":
    case # "gun":
    case # "tdm":
    case # "clean":
      return 0;
    default:
      return 1;
  }
}

function isprophuntgametype() {
  return is_true(level.isprophunt);
}

function isprop() {
  return isDefined(self.pers[#"team"]) && self.pers[#"team"] == game.defenders;
}

function function_6f4ff113(team) {
  if(game.switchedsides) {
    return getotherteam(team);
  }

  return team;
}

function function_920dcdbf(item, var_3ec5ff40) {
  if(game.switchedsides) {
    return var_3ec5ff40;
  }

  return item;
}

function function_ff74bf7(team) {
  players = level.players;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(isDefined(player.pers[#"team"]) && player.pers[#"team"] == team && isDefined(player.pers[#"class"])) {
      if(player.sessionstate == "playing" && !player.afk) {
        return i;
      }
    }
  }

  return players.size;
}

function function_a3f7de13(var_e0dd85aa, s_team, n_clientnum, extradata = 0) {
  if(!isDefined(var_e0dd85aa)) {
    return;
  }

  switch (s_team) {
    case # "axis":
      var_dfc4aab4 = 2;
      break;
    case # "allies":
      var_dfc4aab4 = 1;
      break;
    default:
      var_dfc4aab4 = 0;
      break;
  }

  if(!isDefined(n_clientnum)) {
    n_clientnum = -1;
  }

  players = getplayers();

  foreach(player in players) {
    player luinotifyevent(#"announcement_event", 4, var_e0dd85aa, var_dfc4aab4, n_clientnum, extradata);
  }
}

function function_94a3be2() {
  if(is_true(level.var_903e2252)) {
    return true;
  }

  if((isDefined(getgametypesetting(#"drafttime")) ? getgametypesetting(#"drafttime") : 0) < 30) {
    return true;
  }

  if(!is_true(getgametypesetting(#"draftenabled"))) {
    return true;
  }

  return false;
}

function check_art_mode() {
  if(getdvarint(#"art_mode", 0) > 0) {
    adddebugcommand("<dev string:xe4>");
  }
}

function apply_dev_overrides() {
  override_gts_timelimit();
}

function override_gts_timelimit() {
  timelimitoverride = getdvarint(#"timelimitoverride", -1);

  if(timelimitoverride >= 0) {
    if(level.timelimit != timelimitoverride) {
      level.timelimit = timelimitoverride;
      setgametypesetting("<dev string:xf9>", timelimitoverride);
    }
  }
}