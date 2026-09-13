/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_hud_util.gsc
***********************************************/

mt_getprogress(_id_3BBEDEB9EB59D6A7) {
  return self getplayerdata("cp", "meritProgress", _id_3BBEDEB9EB59D6A7);
}

mt_getstate(_id_3BBEDEB9EB59D6A7) {
  return self getplayerdata("cp", "meritState", _id_3BBEDEB9EB59D6A7);
}

mt_setprogress(_id_3BBEDEB9EB59D6A7, value) {
  if(_id_3BBEDEB9EB59D6A7 == "mt_highest_round") {
    currentstate = mt_getstate("mt_highest_round");
    currenttarget = mt_gettarget("mt_highest_round", currentstate);

    if(level.wave_num >= currenttarget)
      return self setplayerdata("cp", "meritProgress", _id_3BBEDEB9EB59D6A7, currenttarget);
  } else
    return self setplayerdata("cp", "meritProgress", _id_3BBEDEB9EB59D6A7, value);
}

mt_setstate(_id_3BBEDEB9EB59D6A7, value) {
  return self setplayerdata("cp", "meritState", _id_3BBEDEB9EB59D6A7, value);
}

mt_gettarget(_id_3BBEDEB9EB59D6A7, state) {
  return int(tablelookup("cp/allMeritsTable.csv", 0, _id_3BBEDEB9EB59D6A7, 10 + state * 3));
}

playpainoverlay(attacker, weapon_name, direction) {
  if(scripts\cp\utility::isusingremote() && istrue(self.vanguard_num)) {
    return;
  }
  _id_B91D516B7915493E = get_damage_direction(direction);

  if(is_spitter_spit(weapon_name))
    play_spitter_pain_overlay(_id_B91D516B7915493E);
  else if(is_spitter_gas(weapon_name))
    play_spitter_pain_overlay("center");
  else
    play_basic_pain_overlay(_id_B91D516B7915493E);
}

get_damage_direction(direction) {
  _id_94271DD22D0D180B = 0.965;
  _id_6558E6F3F0D145AD = ["left", "center", "right"];

  if(!isDefined(direction))
    return _id_6558E6F3F0D145AD[randomint(_id_6558E6F3F0D145AD.size)];

  direction = direction * -1;
  _id_D9F8AEF6E417EE61 = anglesToForward(self.angles);
  _id_7BC816F59EE5DAFA = vectordot(direction, _id_D9F8AEF6E417EE61);

  if(_id_7BC816F59EE5DAFA > _id_94271DD22D0D180B)
    return "center";

  _id_4E5F3799E80AFAC6 = anglestoright(self.angles);
  _id_564763ABF7C8DA61 = vectordot(direction, _id_4E5F3799E80AFAC6);

  if(_id_564763ABF7C8DA61 > 0)
    return "right";
  else
    return "left";
}

is_spitter_spit(weapon_name) {
  if(!isDefined(weapon_name))
    return 0;

  return weapon_name == "alienspit_mp";
}

is_spitter_gas(weapon_name) {
  if(!isDefined(weapon_name))
    return 0;

  return weapon_name == "alienspit_gas_mp";
}

is_elite_attack(attacker) {
  if(!isDefined(attacker) || !attacker scripts\cp\cp_agent_utils::is_alien_agent())
    return 0;

  return scripts\cp\cp_agent_utils::get_agent_type(attacker) == "elite";
}

play_spitter_pain_overlay(_id_B91D516B7915493E) {
  if(!scripts\cp\utility::has_tag(self.model, "tag_eye")) {
    return;
  }
  if(_id_B91D516B7915493E == "left")
    playfxontagforclients(level._effect["vfx_alien_spitter_hit_left"], self, "tag_eye", self);
  else if(_id_B91D516B7915493E == "center")
    playfxontagforclients(level._effect["vfx_alien_spitter_hit_center"], self, "tag_eye", self);
  else if(_id_B91D516B7915493E == "right")
    playfxontagforclients(level._effect["vfx_alien_spitter_hit_right"], self, "tag_eye", self);
  else {}
}

play_basic_pain_overlay(_id_B91D516B7915493E) {
  ent = self;

  if(!isDefined(self.model) || self.model == "") {
    return;
  }
  if(!scripts\cp\utility::has_tag(self.model, "tag_eye"))
    return;
}

player_damage_blood() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self setclientomnvar("ui_damage_event", self.damageeventcount);
}

zom_player_health_overlay_watcher() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  _id_74A1EC8A1FFD6414 = 0;
  _id_C1163AF12016E3A0 = 1;

  for(;;) {
    if(self.health <= 45 && _id_74A1EC8A1FFD6414 == 0) {
      if(!self issplitscreenplayer()) {
        self setclienttriggeraudiozonepartialwithfade("painvision", 0.02, "mix", "reverb", "filter");
        self stoplocalsound("deaths_door_out");
        self playlocalsound("deaths_door_in");
      }

      _id_74A1EC8A1FFD6414 = 1;
    }

    if(_id_74A1EC8A1FFD6414 && _id_C1163AF12016E3A0) {
      if(!_id_0AFB7E332AEE4BF2::player_in_laststand(self)) {}

      _id_C1163AF12016E3A0 = 0;
    }

    if(_id_74A1EC8A1FFD6414 && self.health > 45) {
      self clearclienttriggeraudiozone(0.3);
      self playlocalsound("deaths_door_out");
      self stoplocalsound("deaths_door_in");
      _id_74A1EC8A1FFD6414 = 0;
      _id_C1163AF12016E3A0 = 1;
    }

    wait 0.05;
  }
}

introscreen_corner_line(string, _id_30CB22B65D96DAB7) {
  if(!isDefined(level.intro_offset))
    level.intro_offset = 0;
  else
    level.intro_offset++;

  y = cornerline_height();
  _id_EE08218F9C4900ED = 1.6;

  if(level.splitscreen)
    _id_EE08218F9C4900ED = 2;

  _id_94480E1669B7FF0D = newhudelem();
  _id_94480E1669B7FF0D.x = 20;
  _id_94480E1669B7FF0D.y = y;
  _id_94480E1669B7FF0D.alignx = "left";
  _id_94480E1669B7FF0D.aligny = "bottom";
  _id_94480E1669B7FF0D.horzalign = "left";
  _id_94480E1669B7FF0D.vertalign = "bottom";
  _id_94480E1669B7FF0D.sort = 3;
  _id_94480E1669B7FF0D.foreground = 1;
  _id_94480E1669B7FF0D settext(string);
  _id_94480E1669B7FF0D.alpha = 1;
  _id_94480E1669B7FF0D.hidewheninmenu = 1;
  _id_94480E1669B7FF0D.fontscale = _id_EE08218F9C4900ED;
  _id_94480E1669B7FF0D.color = (0.8, 1, 0.8);
  _id_94480E1669B7FF0D.font = "default";
  _id_94480E1669B7FF0D.glowcolor = (0.3, 0.6, 0.3);
  _id_94480E1669B7FF0D.glowalpha = 1;
  return _id_94480E1669B7FF0D;
}

cornerline_height() {
  offset = -92;

  if(level.splitscreen)
    offset = -110;

  return level.intro_offset * 20 - 92;
}

teamplayercardsplash(_id_1B4ADA49A21B51CA, owner, team, optionalnumber, _id_B7ABC0284E13CA7A) {
  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924()) {
    return;
  }
  _id_B7ABC0284E13CA7A = istrue(_id_B7ABC0284E13CA7A);

  foreach(player in level.players) {
    if(!isPlayer(player)) {
      continue;
    }
    if(isDefined(team) && player.team != team) {
      continue;
    }
    if(_id_B7ABC0284E13CA7A && isPlayer(owner) && player == owner) {
      continue;
    }
    player thread scripts\cp\cp_hud_message::showsplash(_id_1B4ADA49A21B51CA, optionalnumber, owner);
  }
}

add_hint_string(name, string, _id_4C4AB07DFD5327FF) {
  if(!isDefined(level.trigger_hint_string)) {
    level.trigger_hint_string = [];
    level.trigger_hint_func = [];
  }

  level.trigger_hint_string[name] = string;
  precachestring(string);

  if(isDefined(_id_4C4AB07DFD5327FF))
    level.trigger_hint_func[name] = _id_4C4AB07DFD5327FF;
}

fade_over_time(_id_6B214C71049955E7, fade_time) {
  if(isDefined(fade_time) && fade_time > 0)
    self fadeovertime(fade_time);

  self.alpha = _id_6B214C71049955E7;

  if(isDefined(fade_time) && fade_time > 0)
    wait(fade_time);
}

fade_in(time, shader) {
  if(level.missionfailed) {
    return;
  }
  if(!isDefined(time))
    time = 0.3;

  overlay = get_optional_overlay(shader);

  if(time > 0)
    overlay fadeovertime(time);

  overlay.alpha = 0;

  if(time > 0)
    wait(time);
}

get_optional_overlay(shader) {
  if(!isDefined(shader))
    shader = "black";

  return get_overlay(shader);
}

get_overlay(shader) {
  if(isPlayer(self))
    guy = self;
  else
    guy = level.player;

  if(!isDefined(guy.overlay))
    guy.overlay = [];

  if(!isDefined(guy.overlay[shader]))
    guy.overlay[shader] = scripts\cp\utility::create_client_overlay(shader, 0, guy);

  guy.overlay[shader].sort = 0;
  guy.overlay[shader].foreground = 1;
  return guy.overlay[shader];
}

fade_out(time, shader) {
  if(!isDefined(time))
    time = 0.3;

  overlay = get_optional_overlay(shader);

  if(time > 0)
    overlay fadeovertime(time);

  overlay.alpha = 1;

  if(time > 0)
    wait(time);
}