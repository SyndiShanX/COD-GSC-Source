/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_42e295902050feb9.gsc
*****************************************************/

#using script_19163c4e4e504a5e;
#using script_53f4e6352b0b2425;
#using script_6bf6c8e2e1fdccaa;
#using scripts\engine\utility;
#using scripts\sp\audio;
#namespace snd_sp;

function autoexec function_8de69154c75d8b96() {
  snd::wait_init();
  snd::waitforplayers();
  waittillframeend();
  audio::set_timescale("!kk\t\xdb\xe5\x8c\xca\x94\rD\xb7\x13\x13");
  level.audio.level_fade_time = 0;
  level.player enableplayerbreathsystem(0);
  function_946cb62acc3f9388(level.player);
  function_c369b48887e5c2c2(1);
  snd::function_e52ba9e9b6015b34(1);
}

function private _music(track_name, delay_sec) {
  level notify("#\xce\xe6K\xa4Vn\\pK\x9b(\x7f\xde\x95X\x02\x05\xeeh");
  level endon("#\xce\xe6K\xa4Vn\\pK\x9b(\x7f\xde\x95X\x02\x05\xeeh");

  if(!isDefined(track_name)) {
    track_name = "";
  }

  if(!isDefined(delay_sec)) {
    delay_sec = 0;
  }

  if(delay_sec > 0) {
    wait delay_sec;
  }

  level.player setplayermusicstate(track_name);

  if(snd::function_1bf6b0f15d5c7e6()) {
    if(isstring(level.audio.music) && level.audio.music != "<dev string:x24>") {
      track_name = track_name == "<dev string:x24>" ? "<dev string:x28>" : track_name;
      snd::function_9c0efd22ee470aa6("<dev string:x34>" + track_name);
    }
  }

  track_length = snd::musiclength(track_name);
}

function music(track_name = "", delay_sec = 0) {
  isvalidmusicstate = 0;

  if(track_name == "") {
    isvalidmusicstate = 1;
  } else {
    isvalidmusicstate = snd::musicexists(track_name);
  }

  if(istrue(isvalidmusicstate)) {
    level.player thread _music(track_name, delay_sec);
  } else {
    snd::function_9c0efd22ee470aa6("<dev string:x3f>" + track_name);
  }

  level.audio.music = track_name;

  if(istrue(level.audio.music_suspense)) {
    level.audio.music_suspense = undefined;
    level notify("Oh\xf8\xd76\x13\xc2O\x11YS\xe5+\xe3\xc3\xcd4>");
  }

  if(istrue(level.audio.var_d2609204420553b5)) {
    level.audio.var_d2609204420553b5 = undefined;
  }

  if(istrue(level.audio.music_combat)) {
    level.audio.music_combat = undefined;
  }
}

function private function_217a5bb7e88feb4e(track_name = "", track_time = 60, delay_time = [45, 120], var_efcdc27070e2bb02 = 0) {
  level notify("Oh\xf8\xd76\x13\xc2O\x11YS\xe5+\xe3\xc3\xcd4>");
  level endon("Oh\xf8\xd76\x13\xc2O\x11YS\xe5+\xe3\xc3\xcd4>");
  track_deck = undefined;
  track_array = undefined;
  tracks = undefined;
  level.audio.var_3b7c927199294dfb = getthread();

  if(istrue(var_efcdc27070e2bb02) == 0) {
    wait_time = snd::randomhelper(delay_time);

    if(snd::function_1bf6b0f15d5c7e6()) {
      snd::function_9c0efd22ee470aa6("<dev string:x59>" + snd::printdecimalcount(wait_time, 2));
    }

    wait wait_time;
  }

  if(isstruct(track_name) && isarray(track_name.items) && isnumber(track_name.index)) {
    track_deck = track_name;
  } else if(isarray(track_name)) {
    track_array = track_name;
    tracks = track_array;
  }

  while(true) {
    if(isstruct(track_deck) && isarray(track_deck.items) && isnumber(track_deck.index)) {
      track_name = track_deck utility::deck_draw();

      if(!isstring(track_name)) {
        if(snd::function_1bf6b0f15d5c7e6()) {
          snd::function_9c0efd22ee470aa6("<dev string:x75>");
        }

        track_name = "";
      }
    } else if(isarray(track_array)) {
      if(isarray(tracks) && tracks.size == 0) {
        tracks = track_array;
      }

      track_name = tracks[0];
      tracks = utility::array_remove_index(tracks, 0);

      if(!isstring(track_name)) {
        if(snd::function_1bf6b0f15d5c7e6()) {
          snd::function_9c0efd22ee470aa6("<dev string:xaa>");
        }

        track_name = "";
      }
    }

    music(track_name);
    level.audio.music_suspense = 1;

    if(snd::function_1bf6b0f15d5c7e6()) {
      snd::function_9c0efd22ee470aa6("<dev string:xe0>" + track_name + "<dev string:xf5>");
    }

    wait_time = snd::randomhelper(track_time);
    wait wait_time;
    level.audio.music_suspense = undefined;
    music("");
    wait_time = snd::randomhelper(delay_time);

    if(snd::function_1bf6b0f15d5c7e6()) {
      snd::function_9c0efd22ee470aa6("<dev string:x59>" + snd::printdecimalcount(wait_time, 2));
    }

    wait wait_time;
  }
}

function music_suspense(track_name, track_time, delay_time, var_efcdc27070e2bb02) {
  level thread function_217a5bb7e88feb4e(track_name, track_time, delay_time, var_efcdc27070e2bb02);
}

function function_384752872e784343() {
  if(isDefined(level.audio.var_3b7c927199294dfb)) {
    level notify("Oh\xf8\xd76\x13\xc2O\x11YS\xe5+\xe3\xc3\xcd4>");
    level.audio.var_3b7c927199294dfb = undefined;

    if(snd::function_1bf6b0f15d5c7e6()) {
      snd::function_9c0efd22ee470aa6("<dev string:xfa>");
    }
  }

  if(istrue(level.audio.music_suspense)) {
    music("");
  }
}

function music_combat(track_name) {
  function_384752872e784343();

  if(isstring(track_name) && isstring(level.audio.music) && track_name == level.audio.music && istrue(level.audio.music_combat)) {
    return;
  }

  if(!isstring(track_name)) {
    states = ["\xbdm\x95\xbbp\x84\xc9\xac\xba\x01\x9c1(\x92;\xa6\x8f\xd7\x81\x89\xf0\nh\xac\xbe\x91\n", "\xaa<\xe3\xd7\xf1G\n\xd9\x10\xf8H\x85\xfb/\xb4\x82\xa5\x97\xdc|\xc3\x89\xc1Nr\x1f\xc2f", "\x84\xaa\xaf\xebi\x94R\x0f\xe3=1hv\x15\xaed\xe7\xedMnd\xf1\x8b\xd3\xc7\x93)~"];

    if(!isDefined(level.audio.var_6105af1f60a48b8f)) {
      level.audio.var_6105af1f60a48b8f = 0;
    }

    track_name = states[level.audio.var_6105af1f60a48b8f];
    level.audio.var_6105af1f60a48b8f = (level.audio.var_6105af1f60a48b8f + 1) % states.size;
  }

  music(track_name);
  level.audio.music_combat = 1;
}

function function_957912afc70a476b() {
  if(istrue(level.audio.music_combat)) {
    music("");
    level.audio.music_combat = undefined;
  }
}

function music_boost(db = 6, bpm = 120, attack_beats = 0, hold_beats = 16, release_beats = 16) {
  assert(isnumber(db));
  assert(isnumber(bpm));
  assert(isnumber(attack_beats));
  assert(isnumber(hold_beats));
  assert(isnumber(release_beats));

  if(db < 0) {
    snd::function_9c0efd22ee470aa6("<dev string:x115>");
  } else if(db > 10) {
    snd::function_9c0efd22ee470aa6("<dev string:x135>");
  }

  scale = clamp(db, 0, 10) * 0.1;
  var_50bbe2e91880fc82 = 60 / bpm * attack_beats;
  var_cce3084a68116391 = 60 / bpm * hold_beats;
  var_a63ccf6978ffd104 = 60 / bpm * release_beats;
  level.player setsoundsubmix("\rX\xb8!3\xc7M\xd0\x90QP", var_50bbe2e91880fc82, scale);
  level.player utility::delaycall(var_50bbe2e91880fc82 + var_cce3084a68116391, &clearsoundsubmix, "\rX\xb8!3\xc7M\xd0\x90QP", var_a63ccf6978ffd104);
}

function private function_e59f96d48323eb0(player, submix_name, submix_scale, var_674809e939d2123f, var_c88c44c1529fba46) {
  self notify("_\xb3\xf9\xb5\x9f\x05,}Eu\xe7\x1b4\x11t\xc1");
  self endon("_\xb3\xf9\xb5\x9f\x05,}Eu\xe7\x1b4\x11t\xc1");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  level endon("\x1a\xda\xbf\x16\x1f& 2\x8e\xad\xff=\xbe\x91:\xa4d\xee|\xed\x86\x03X");

  if(!isDefined(player)) {
    player = level.player;
  }

  if(!isDefined(submix_name)) {
    submix_name = "\xa5J\xce\xd0[\x92%2I\x91\xe35\x1a\x1b\x12\x18\xe4\x90\x17k@\xc4\xd5;";
  }

  if(!isDefined(submix_scale)) {
    submix_scale = 1;
  }

  if(!isDefined(var_674809e939d2123f)) {
    var_674809e939d2123f = 8;
  }

  if(!isDefined(var_c88c44c1529fba46)) {
    var_c88c44c1529fba46 = 8;
  }

  if(!function_68aef517b5294bf9(submix_name)) {
    return;
  }

  while(true) {
    player waittill("\xdb\x9eV\x9a\x809X\x1d\xc1/\x8d\aeV\xe03\xd8\xfd\xfc\x1b", ai_actor, anim_struct);
    player setsoundsubmix(submix_name, var_674809e939d2123f, submix_scale);
    player waittill("\xdb:\xb1\x01\xc2\x90C\xf7\v>\xe0\xa3\x13\xcf>\xba\xda\xbc", ai_actor, anim_struct, var_c9c2a7e71f16d2fc);

    if(isnumber(var_c9c2a7e71f16d2fc) && var_c9c2a7e71f16d2fc < 0) {
      var_c9c2a7e71f16d2fc = var_c88c44c1529fba46;
    }

    player clearsoundsubmix(submix_name, var_c9c2a7e71f16d2fc);
  }
}

function function_946cb62acc3f9388(player, submix_name, submix_scale, var_674809e939d2123f, var_c88c44c1529fba46) {
  if(isPlayer(player)) {
    player thread function_e59f96d48323eb0(player, submix_name, submix_scale, var_674809e939d2123f, var_c88c44c1529fba46);
  }
}

function function_150689cf8c16bb90(player = level.player, submix_name = "\xa5J\xce\xd0[\x92%2I\x91\xe35\x1a\x1b\x12\x18\xe4\x90\x17k@\xc4\xd5;", var_c88c44c1529fba46 = 8) {
  if(isPlayer(player)) {
    player notify("\x1a\xda\xbf\x16\x1f& 2\x8e\xad\xff=\xbe\x91:\xa4d\xee|\xed\x86\x03X");
    player clearsoundsubmix(submix_name, var_c88c44c1529fba46);
  }
}

function private function_b3c160f0d1cea650(value) {
  color = (0.309804, 0.152941, 0.623529);

  if(value < 0.32) {
    frac = snd::scalerp(value, 0, 0.32, 0, 1);
    color = vectorlerp((0.309804, 0.152941, 0.623529), (0.937255, 0.309804, 0.309804), frac);
  } else if(value < 0.64) {
    frac = snd::scalerp(value, 0.32, 0.64, 0, 1);
    color = vectorlerp((0.937255, 0.309804, 0.309804), (0.937255, 0.623529, 0.309804), frac);
  } else if(value < 0.96) {
    frac = snd::scalerp(value, 0.64, 0.96, 0, 1);
    color = vectorlerp((0.937255, 0.623529, 0.309804), (0.937255, 0.937255, 0.309804), frac);
  } else {
    frac = snd::scalerp(value, 0.96, 1, 0, 1);
    color = vectorlerp((0.937255, 0.937255, 0.309804), (0.937255, 0.937255, 0.937255), frac);
  }

  return color;
}

function private function_dc108dd022665c55(state) {
  switch (state) {
    default:
      break;
    case #"hash_1c39674e5b0de0f3":
      return (0.937255, 0.937255, 0.937255);
    case #"hash_186d745a92c317d9":
      return (0.937255, 0.937255, 0.309804);
    case #"hash_3015d6b4c9f55525":
      return (0.937255, 0.623529, 0.309804);
    case #"hash_9e02cd4a0f3ca981":
      return (0.937255, 0.309804, 0.309804);
    case #"hash_7b6614415d1b2e48":
      return (0.309804, 0.623529, 0.937255);
  }

  return (1, 1, 1);
}

function private function_ef657ac92f1a5d15(ai) {
  if(issentient(ai)) {
    if(istrue(ai.stealth_enabled) && isnumber(ai.stealth_bsmstate)) {
      switch (ai.stealth_bsmstate) {
        case 0:
          return "<dev string:x156>";
        case 1:
          return "<dev string:x187>";
        case 2:
          return "<dev string:x196>";
        case 3:
          return "<dev string:x171>";
        case 4:
        default:
          return "<dev string:x19e>";
      }
    } else {
      return (ai.alertlevel == "<dev string:x1a5>" ? "<dev string:x156>" : ai.alertlevel);
    }
  }

  return "<dev string:x19e>";
}

function private function_704f141c49839b8a(state) {
  if(!isDefined(state)) {
    state = "<dev string:x24>";
  }

  color = undefined;
  assert(isstring(state), "<dev string:x1b2>");

  switch (state) {
    case #"hash_d2a4c56b6b9ff274":
    default:
      color = (randomfloatrange(0.5, 1), randomfloatrange(0.5, 1), randomfloatrange(0.5, 1));
      break;
    case #"hash_1c39674e5b0de0f3":
    case #"hash_4d6a329017fe1bd0":
    case #"hash_9128327eb51e0b7b":
    case #"hash_c6076a90d1a76064":
      color = (0.72974, 0.72974, 0.72974);
      break;
    case #"hash_186d745a92c317d9":
    case #"hash_21c69ec47c409a66":
    case #"hash_37bb23543c319104":
    case #"hash_e21b072df2b47f94":
      color = (0.937255, 0.937255, 0.309804);
      break;
    case #"hash_2d1406e602f0875d":
    case #"hash_9e02cd4a0f3ca981":
      color = (0.937255, 0.309804, 0.309804);
      break;
  }

  return color;
}

function private function_e3746bc4e1355264(origin, text, color, height, radius) {
  if(!isvector(origin)) {
    return;
  }

  if(!isDefined(color)) {
    color = (0.72974, 0.72974, 0.72974);
  }

  if(!isDefined(height)) {
    height = 72;
  }

  if(!isDefined(radius)) {
    radius = 24;
  }

  cylinder_end = origin + (0, 0, 6);
  origin_hi = origin + (0, 0, height);
  var_9e35aae81aee631a = origin + (0, 0, height + 16);
  var_ccbd5bd6ada4391 = origin + (0, 0, height + 32);
  cylinder(origin, cylinder_end, radius, color, 0, 1);
  line(origin, origin_hi, color, 1, 0, 1);
  snd::print3dplus(text, origin_hi, 1, "<dev string:x209>", color);
}

function private function_8b6771c22f77d68(enemy_targets, team, alert_distance) {
  ai = [];

  if(isarray(enemy_targets) && enemy_targets.size > 0) {
    var_9f71273efb853203 = enemy_targets[0].origin;

    if(isnumber(alert_distance) && alert_distance > 0) {
      ai["\\*\xe3\xec\x10"] = snd::function_5f2c0a5466e89c2("\\*\xe3\xec\x10", var_9f71273efb853203, alert_distance, team);
    }

    ai["\xe3\xd0\xc3e\x85h"] = snd::function_92b3b053e3273e2d("\xe3\xd0\xc3e\x85h", enemy_targets, team);
  } else {
    ai["\xe3\xd0\xc3e\x85h"] = [];
  }

  return ai;
}

function private function_6e9cfd416968cd9e(var_46b0b5addde049c0, callback_func, enemy_targets, team, var_72440fec533dbe18, var_ab8e9875b2210b02, alert_distance) {
  level notify("\xb3a\xf5\xa5\xcen\x9e\x10a\xb2O\x83-\xad\v\x95\x1a=\xcf\x8c\xd6\xe1\x11\xa0");
  level endon("\xb3a\xf5\xa5\xcen\x9e\x10a\xb2O\x83-\xad\v\x95\x1a=\xcf\x8c\xd6\xe1\x11\xa0");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  if(!isDefined(var_46b0b5addde049c0)) {
    var_46b0b5addde049c0 = &function_8b6771c22f77d68;
  }

  if(!isDefined(enemy_targets)) {
    enemy_targets = [level.player];
  }

  if(!isDefined(team)) {
    team = "\x9a\x1f\x83\x1bs=\x13\xf8";
  }

  if(!isDefined(var_72440fec533dbe18)) {
    var_72440fec533dbe18 = 1.5;
  }

  if(!isDefined(var_ab8e9875b2210b02)) {
    var_ab8e9875b2210b02 = 2.5;
  }

  if(!isDefined(alert_distance)) {
    alert_distance = 0;
  }

  assert(isstruct(level.snd), "<dev string:x213>");
  assert(snd::isscriptfunction(var_46b0b5addde049c0), "<dev string:x22f>");
  assert(snd::isscriptfunction(callback_func), "<dev string:x26f>");
  var_f4f81276a258babe = 0;
  var_761f3704e1682394 = 0;
  state = "\x91\x88\xc2*";
  ai_count = 0;
  did_change = 1;
  ai_array = [];

  while(true) {
    now = gettime();
    ai_array = [[var_46b0b5addde049c0]](enemy_targets, team, alert_distance);
    alert_ents = ai_array["\\*\xe3\xec\x10"];
    combat_ents = ai_array["\xe3\xd0\xc3e\x85h"];
    is_alert = isarray(alert_ents) && alert_ents.size > 0;
    is_combat = isarray(combat_ents) && combat_ents.size > 0;
    ents = combat_ents;

    if(is_combat && state != "\xe3\xd0\xc3e\x85h") {
      if(var_f4f81276a258babe == 0 && state == "\x91\x88\xc2*") {
        var_f4f81276a258babe = now;
      }

      var_2c9bfa8935d48b15 = (now - var_f4f81276a258babe) * 0.001;

      if(var_2c9bfa8935d48b15 < var_72440fec533dbe18 && state == "\x91\x88\xc2*") {
        state = "\x90\xe0\xb5\x10\r\xca";
        did_change = 1;
      } else if(var_2c9bfa8935d48b15 >= var_72440fec533dbe18 && state != "\xe3\xd0\xc3e\x85h") {
        var_f4f81276a258babe = 0;
        state = "\xe3\xd0\xc3e\x85h";
        did_change = 1;
      }
    } else if(is_combat && state == "\xe3\xd0\xc3e\x85h" && combat_ents.size > ai_count) {
      ents = combat_ents;
      did_change = 1;
    } else if(!is_combat && state != "\x91\x88\xc2*") {
      if(var_761f3704e1682394 == 0 && state == "\xe3\xd0\xc3e\x85h") {
        var_761f3704e1682394 = now;
      }

      var_5c3915b8e00943b7 = (now - var_761f3704e1682394) * 0.001;

      if(var_5c3915b8e00943b7 < var_ab8e9875b2210b02 && state != "F0\xaa8^\xb0q\xb8") {
        state = "F0\xaa8^\xb0q\xb8";
        did_change = 1;
      } else if(is_alert && var_5c3915b8e00943b7 >= var_ab8e9875b2210b02 && state != "\\*\xe3\xec\x10") {
        state = "\\*\xe3\xec\x10";
        ents = alert_ents;
        did_change = 1;
      } else if(!is_alert && var_5c3915b8e00943b7 >= var_ab8e9875b2210b02 && state != "\x91\x88\xc2*") {
        var_761f3704e1682394 = 0;
        state = "\x91\x88\xc2*";
        did_change = 1;
      }
    }

    if(!is_combat && is_alert && var_761f3704e1682394 == 0 && state == "\x91\x88\xc2*") {
      state = "\\*\xe3\xec\x10";
      ents = alert_ents;
      did_change = 1;
    }

    if(istrue(did_change)) {
      level thread[[callback_func]](state, enemy_targets, ents);
      did_change = 0;
    }

    if(snd::function_8c35a6f99f836040() > 0) {
      threat = 0;

      foreach(target in enemy_targets) {
        if(isPlayer(target)) {
          target_threat = function_d04b7ed3ce995a49(target);

          if(target_threat > threat) {
            threat = target_threat;
          }
        }
      }

      scale = 2;
      alpha = 1;
      threat_color = function_b3c160f0d1cea650(threat);
      state_color = function_dc108dd022665c55(state);
      threat = snd::printdecimalcount(threat, 4);
      ai_count = state == "<dev string:x15e>" && istrue(is_alert) ? alert_ents.size : combat_ents.size;
      snd::function_f2aaa10b4546fafb("<dev string:x2b1>", 0, 48, scale, "<dev string:x2bf>", (0.72974, 0.72974, 0.72974), alpha, (0, 0, 0), 0.72974, (1, 1, 1), 0.72974);
      snd::function_f2aaa10b4546fafb("<dev string:x2c4>", 0, 80, scale, "<dev string:x2bf>", (0.72974, 0.72974, 0.72974), alpha, (0, 0, 0), 0.72974, (1, 1, 1), 0.72974);
      snd::function_f2aaa10b4546fafb("<dev string:x2d2>", 0, 112, scale, "<dev string:x2bf>", (0.72974, 0.72974, 0.72974), alpha, (0, 0, 0), 0.72974, (1, 1, 1), 0.72974);
      snd::function_f2aaa10b4546fafb("<dev string:x2e0>" + threat, 0, 48, scale, "<dev string:x2bf>", threat_color, alpha, (0, 0, 0), 0.72974, (1, 1, 1), 0.72974);
      snd::function_f2aaa10b4546fafb("<dev string:x2e0>" + state, 0, 80, scale, "<dev string:x2bf>", state_color, alpha, (0, 0, 0), 0.72974, (1, 1, 1), 0.72974);
      snd::function_f2aaa10b4546fafb("<dev string:x2e0>" + ai_count, 0, 112, scale, "<dev string:x2bf>", (1, 1, 1), alpha, (0, 0, 0), 0.72974, (1, 1, 1), 0.72974);

      if(snd::function_8c35a6f99f836040() > 1) {
        player = level.player;
        playervieworg = player snd::getplayervieworigin();
        playerangles = player snd::getplayerviewangles();
        playerforward = anglesToForward(playerangles);
        playerfov = player snd::getplayerfov();
        all_ai = getaiarray(team);
        visible_ai = snd::function_bee53ee78849b6ea(all_ai, playervieworg, playerforward, playerfov);

        foreach(ent in visible_ai) {
          alertlevel = function_ef657ac92f1a5d15(ent);
          state_color = function_704f141c49839b8a(alertlevel);
          function_e3746bc4e1355264(ent.origin, alertlevel, state_color);
        }
      }
    }

    ai_count = combat_ents.size;
    waitframe();
  }
}

function ai_enemy_target(var_46b0b5addde049c0, callback_func, enemy_targets, ai_team, var_d9b117152a04fc51, var_ab8e9875b2210b02, alert_distance) {
  if(!isarray(enemy_targets) && isent(enemy_targets)) {
    enemy_targets = [enemy_targets];
  }

  level thread function_6e9cfd416968cd9e(var_46b0b5addde049c0, callback_func, enemy_targets, ai_team, var_d9b117152a04fc51, var_ab8e9875b2210b02, alert_distance);
}

function function_ab748d07724d74d4() {
  level notify("\xb3a\xf5\xa5\xcen\x9e\x10a\xb2O\x83-\xad\v\x95\x1a=\xcf\x8c\xd6\xe1\x11\xa0");
}

function function_c369b48887e5c2c2(var_62002b7244c0136f) {
  if(istrue(var_62002b7244c0136f)) {
    level.var_d64be07e00a9dbda = &function_689eea3089180f61;
    level.var_b65cc1ff436ac977 = &function_cb1cd2c2b71239cf;
    return;
  }

  level.var_d64be07e00a9dbda = undefined;
  level.var_b65cc1ff436ac977 = undefined;

  if(istrue(level.audio.var_5f83dc3c9f3b6e32)) {
    level.player notify("\xe3\xe5y1\xb8\xc4\xf7U\x12B\x13`\xc4\x1d\r\xf8\xba\xfb\x95\xc1`\xb0\x12\xfa6\x970\x04\xb2\xac)\x14?");
    level.player notify("\xb9\xb9\x19\xf5\x95\xe6do\xe6_\xcd\x8d\xdb\xddm\xed\xeb\xeeY\x16\xe0\xf6\xcd\xfa\xb6\xed\xd9V\xb6Vst\xfa\xdco\xea\xcd\x19\xb9");
    level.player clearsoundsubmix("\xfe\x8c[\r\x8d \xed\x9e\x84\xa6\x0e\xa9m\x1da\xff\x87\x19|", 0.1);
    level.player clearsoundsubmix("|L\xfe\xf2{\xd8\xa7\xcb\x9b\x92\x8dG\r\x80|\x9c\xeb\x15\"\xaa\x11\x92Y\xa5\x83x", 0.1);
    soundsettimescalefactorfromtable("!kk\t\xdb\xe5\x8c\xca\x94\rD\xb7\x13\x13");
    level.audio.var_5f83dc3c9f3b6e32 = undefined;
  }
}

function private function_689eea3089180f61() {
  player = self;
  assert(isPlayer(player), "<dev string:x2ee>");
  player notify("\xe3\xe5y1\xb8\xc4\xf7U\x12B\x13`\xc4\x1d\r\xf8\xba\xfb\x95\xc1`\xb0\x12\xfa6\x970\x04\xb2\xac)\x14?");
  level.audio.var_5f83dc3c9f3b6e32 = 1;
  soundsettimescalefactorfromtable("\xfe\x8c[\r\x8d \xed\x9e\x84\xa6\x0e\xa9m\x1da\xff\x87\x19|");
  player setsoundsubmix("\xfe\x8c[\r\x8d \xed\x9e\x84\xa6\x0e\xa9m\x1da\xff\x87\x19|", 1);

  if(isPlayer(player) && isstring(player.stealth.combatstate.name) && isstring(player.stealth.combatstate.type) && player.stealth.combatstate.name == "\xe3\xd0\xc3e\x85h" && player.stealth.combatstate.type != "\xff\xdb\xba\xa7\xd5\x8d\xe1") {
    player setsoundsubmix("|L\xfe\xf2{\xd8\xa7\xcb\x9b\x92\x8dG\r\x80|\x9c\xeb\x15\"\xaa\x11\x92Y\xa5\x83x", 0.25);
  }

  snd::play("\xb0\x829\xe0A]\x1cT\xd2\xa4\xa7n{\x18Gv\x8ds\x96\x9e\xb6\x88\xaf\xff\x98\xe8\xb6\xe6");
  player thread slowmo_weapon_movement_sounds();
}

function private slowmo_weapon_movement_sounds() {
  self notify("f4b\xed\xbfuPGK\x06\xe8\xde\x0ed\xacM");
  self endon("f4b\xed\xbfuPGK\x06\xe8\xde\x0ed\xacM");
  player = self;
  assert(isPlayer(player), "<dev string:x2ee>");
  player endon("\x1e\xfd\xd1\xa2\a");
  player endon("\xb9\xb9\x19\xf5\x95\xe6do\xe6_\xcd\x8d\xdb\xddm\xed\xeb\xeeY\x16\xe0\xf6\xcd\xfa\xb6\xed\xd9V\xb6Vst\xfa\xdco\xea\xcd\x19\xb9");
  var_917bb5c83332d494 = 1;
  var_f2dad8b17adce1a = 15;
  var_e6d69e768c78747e = 30;
  angle_prev = 0;
  wait 0.5;
  slowmotimescale = gettimescale();

  while(istrue(level.audio.var_5f83dc3c9f3b6e32)) {
    angle_now = length(player getplayerangles());
    angle_delta = abs(angle_now - angle_prev);
    angle_thresh = float(angle_delta / slowmotimescale);

    if(angle_thresh >= var_e6d69e768c78747e) {
      snd::play("FL7\xa9\xc6\x10\x85H\xb4s\xa9$z\x12N\x15C\xf3\xa9\xa8\xad3R3uRO,\xd4");
    } else if(angle_thresh >= var_f2dad8b17adce1a) {
      snd::play("\x17\x8e\xc7\xd1\x16\x80\x953\x11\x8e\x88*\xd0\xc3z\xbd(\xd2\xce\x92X\xf1-\x10\xb4&\x81>\xa7");
    } else if(angle_thresh >= var_917bb5c83332d494) {
      snd::play("\xd6\x81\x81\aU!2\xb0)\r\x9b\xe7\xd7IB\xc5\xcbN\x92(\x10\xab\x91\xc4\xccb\xae2N");
    }

    if(snd::function_8c35a6f99f836040() > 1) {
      xx = 120;
      yy = 240;
      color = (1, 1, 1);
      alpha = 1;
      scale = 1.5;
      dur = 1;
      snd::print2d(xx, yy, "<dev string:x320>" + angle_now, color, alpha, scale, dur);
      yy += 16 * scale;
      snd::print2d(xx, yy, "<dev string:x332>" + angle_delta, color, alpha, scale, dur);
      yy += 16 * scale;
      snd::print2d(xx, yy, "<dev string:x344>" + angle_thresh, color, alpha, scale, dur);
    }

    angle_prev = angle_now;
    waitframe();
  }
}

function private function_cb1cd2c2b71239cf() {
  player = self;
  assert(isPlayer(player), "<dev string:x2ee>");
  player endon("\xe3\xe5y1\xb8\xc4\xf7U\x12B\x13`\xc4\x1d\r\xf8\xba\xfb\x95\xc1`\xb0\x12\xfa6\x970\x04\xb2\xac)\x14?");
  player notify("\xb9\xb9\x19\xf5\x95\xe6do\xe6_\xcd\x8d\xdb\xddm\xed\xeb\xeeY\x16\xe0\xf6\xcd\xfa\xb6\xed\xd9V\xb6Vst\xfa\xdco\xea\xcd\x19\xb9");
  player clearsoundsubmix("\xfe\x8c[\r\x8d \xed\x9e\x84\xa6\x0e\xa9m\x1da\xff\x87\x19|", 1.25);
  player clearsoundsubmix("|L\xfe\xf2{\xd8\xa7\xcb\x9b\x92\x8dG\r\x80|\x9c\xeb\x15\"\xaa\x11\x92Y\xa5\x83x", 0.25);
  snd::play("\x9fi{\x9cx#O\x8c\xd8T0\x1d\x90*5_\xef1Z\x90\x19\x87y\x90\xf4I7\xf9N");
  wait 2;
  level.audio.var_5f83dc3c9f3b6e32 = undefined;
  soundsettimescalefactorfromtable("!kk\t\xdb\xe5\x8c\xca\x94\rD\xb7\x13\x13");
}