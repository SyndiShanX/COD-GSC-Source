/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_audio.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\music_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#namespace zm_audio;

function autoexec __init__sytem__() {
  system::register("zm_audio", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("allplayers", "charindex", 1, 3, "int");
  clientfield::register("toplayer", "isspeaking", 1, 1, "int");
  println("");
  level.audio_get_mod_type = &get_mod_type;
  level zmbvox();
  callback::on_connect(&init_audio_functions);
  level thread sndannouncer_init();
}

function setexertvoice(exert_id) {
  self.player_exert_id = exert_id;
  self clientfield::set("charindex", self.player_exert_id);
}

function playerexert(exert, notifywait = 0) {
  if(isDefined(self.isspeaking) && self.isspeaking || (isDefined(self.isexerting) && self.isexerting)) {
    return;
  }
  if(isDefined(self.beastmode) && self.beastmode) {
    return;
  }
  id = level.exert_sounds[0][exert];
  if(isDefined(self.player_exert_id)) {
    if(!isDefined(level.exert_sounds) || !isDefined(level.exert_sounds[self.player_exert_id]) || !isDefined(level.exert_sounds[self.player_exert_id][exert])) {
      return;
    }
    if(isarray(level.exert_sounds[self.player_exert_id][exert])) {
      id = array::random(level.exert_sounds[self.player_exert_id][exert]);
    } else {
      id = level.exert_sounds[self.player_exert_id][exert];
    }
  }
  if(isDefined(id)) {
    self.isexerting = 1;
    if(notifywait) {
      self playsoundwithnotify(id, "done_exerting");
      self waittill("done_exerting");
      self.isexerting = 0;
    } else {
      self thread exert_timer();
      self playSound(id);
    }
  }
}

function exert_timer() {
  self endon("disconnect");
  wait(randomfloatrange(1.5, 3));
  self.isexerting = 0;
}

function zmbvox() {
  level.votimer = [];
  level.vox = zmbvoxcreate();
  if(isDefined(level._zmbvoxlevelspecific)) {
    level thread[[level._zmbvoxlevelspecific]]();
  }
  if(isDefined(level._zmbvoxgametypespecific)) {
    level thread[[level._zmbvoxgametypespecific]]();
  }
  announcer_ent = spawn("script_origin", (0, 0, 0));
  level.vox zmbvoxinitspeaker("announcer", "vox_zmba_", announcer_ent);
  level.exert_sounds[0]["burp"] = "evt_belch";
  level.exert_sounds[0]["hitmed"] = "null";
  level.exert_sounds[0]["hitlrg"] = "null";
  if(isDefined(level.setupcustomcharacterexerts)) {
    [[level.setupcustomcharacterexerts]]();
  }
}

function init_audio_functions() {
  self thread zombie_behind_vox();
  self thread player_killstreak_timer();
  if(isDefined(level._custom_zombie_oh_shit_vox_func)) {
    self thread[[level._custom_zombie_oh_shit_vox_func]]();
  } else {
    self thread oh_shit_vox();
  }
}

function zombie_behind_vox() {
  level endon("unloaded");
  self endon("death_or_disconnect");
  if(!isDefined(level._zbv_vox_last_update_time)) {
    level._zbv_vox_last_update_time = 0;
    level._audio_zbv_shared_ent_list = zombie_utility::get_zombie_array();
  }
  while(true) {
    wait(1);
    t = gettime();
    if(t > (level._zbv_vox_last_update_time + 1000)) {
      level._zbv_vox_last_update_time = t;
      level._audio_zbv_shared_ent_list = zombie_utility::get_zombie_array();
    }
    zombs = level._audio_zbv_shared_ent_list;
    played_sound = 0;
    for(i = 0; i < zombs.size; i++) {
      if(!isDefined(zombs[i])) {
        continue;
      }
      if(zombs[i].isdog) {
        continue;
      }
      dist = 150;
      z_dist = 50;
      alias = level.vox_behind_zombie;
      if(isDefined(zombs[i].zombie_move_speed)) {
        switch (zombs[i].zombie_move_speed) {
          case "walk": {
            dist = 150;
            break;
          }
          case "run": {
            dist = 175;
            break;
          }
          case "sprint": {
            dist = 200;
            break;
          }
        }
      }
      if(distancesquared(zombs[i].origin, self.origin) < (dist * dist)) {
        yaw = self zm_utility::getyawtospot(zombs[i].origin);
        z_diff = self.origin[2] - zombs[i].origin[2];
        if(yaw < -95 || yaw > 95 && abs(z_diff) < 50) {
          zombs[i] notify("bhtn_action_notify", "behind");
          played_sound = 1;
          break;
        }
      }
    }
    if(played_sound) {
      wait(3.5);
    }
  }
}

function oh_shit_vox() {
  self endon("death_or_disconnect");
  while(true) {
    wait(1);
    players = getplayers();
    zombs = zombie_utility::get_round_enemy_array();
    if(players.size >= 1) {
      close_zombs = 0;
      for(i = 0; i < zombs.size; i++) {
        if(isDefined(zombs[i].favoriteenemy) && zombs[i].favoriteenemy == self || !isDefined(zombs[i].favoriteenemy)) {
          if(distancesquared(zombs[i].origin, self.origin) < 62500) {
            close_zombs++;
          }
        }
      }
      if(close_zombs > 4) {
        self create_and_play_dialog("general", "oh_shit");
        wait(4);
      }
    }
  }
}

function player_killstreak_timer() {
  self endon("disconnect");
  self endon("death");
  if(getdvarstring("zombie_kills") == "") {
    setDvar("zombie_kills", "7");
  }
  if(getdvarstring("zombie_kill_timer") == "") {
    setDvar("zombie_kill_timer", "5");
  }
  kills = getdvarint("zombie_kills");
  time = getdvarint("zombie_kill_timer");
  if(!isDefined(self.timerisrunning)) {
    self.timerisrunning = 0;
    self.killcounter = 0;
  }
  while(true) {
    self waittill("zom_kill", zomb);
    if(isDefined(zomb._black_hole_bomb_collapse_death) && zomb._black_hole_bomb_collapse_death == 1) {
      continue;
    }
    if(isDefined(zomb.microwavegun_death) && zomb.microwavegun_death) {
      continue;
    }
    self.killcounter++;
    if(self.timerisrunning != 1) {
      self.timerisrunning = 1;
      self thread timer_actual(kills, time);
    }
  }
}

function player_zombie_kill_vox(hit_location, player, mod, zombie) {
  weapon = player getcurrentweapon();
  dist = distancesquared(player.origin, zombie.origin);
  if(!isDefined(level.zombie_vars[player.team]["zombie_insta_kill"])) {
    level.zombie_vars[player.team]["zombie_insta_kill"] = 0;
  }
  instakill = level.zombie_vars[player.team]["zombie_insta_kill"];
  death = [[level.audio_get_mod_type]](hit_location, mod, weapon, zombie, instakill, dist, player);
  if(!isDefined(death)) {
    return undefined;
  }
  if(!(isDefined(player.force_wait_on_kill_line) && player.force_wait_on_kill_line)) {
    player.force_wait_on_kill_line = 1;
    player create_and_play_dialog("kill", death);
    wait(2);
    if(isDefined(player)) {
      player.force_wait_on_kill_line = 0;
    }
  }
}

function get_response_chance(event) {
  if(!isDefined(level.response_chances[event])) {
    return 0;
  }
  return level.response_chances[event];
}

function get_mod_type(impact, mod, weapon, zombie, instakill, dist, player) {
  close_dist = 4096;
  med_dist = 15376;
  far_dist = 160000;
  if(weapon.name == "hero_annihilator") {
    return "annihilator";
  }
  if(zm_utility::is_placeable_mine(weapon)) {
    if(!instakill) {
      return "betty";
    }
    return "weapon_instakill";
  }
  if(zombie.damageweapon.name == "cymbal_monkey") {
    if(instakill) {
      return "weapon_instakill";
    }
    return "monkey";
  }
  if(weapon.name == "ray_gun" && dist > far_dist) {
    if(!instakill) {
      return "raygun";
    }
    return "weapon_instakill";
  }
  if(zm_utility::is_headshot(weapon, impact, mod) && dist >= far_dist) {
    return "headshot";
  }
  if(mod == "MOD_MELEE" || mod == "MOD_UNKNOWN" && dist < close_dist) {
    if(!instakill) {
      return "melee";
    }
    return "melee_instakill";
  }
  if(zm_utility::is_explosive_damage(mod) && weapon.name != "ray_gun" && (!(isDefined(zombie.is_on_fire) && zombie.is_on_fire))) {
    if(!instakill) {
      return "explosive";
    }
    return "weapon_instakill";
  }
  if(weapon.doesfiredamage && (mod == "MOD_BURNED" || mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH")) {
    if(!instakill) {
      return "flame";
    }
    return "weapon_instakill";
  }
  if(!isDefined(impact)) {
    impact = "";
  }
  if(mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET") {
    if(!instakill) {
      return "bullet";
    }
    return "weapon_instakill";
  }
  if(instakill) {
    return "default";
  }
  if(mod != "MOD_MELEE" && zombie.missinglegs) {
    return "crawler";
  }
  if(mod != "MOD_BURNED" && dist < close_dist) {
    return "close";
  }
  return "default";
}

function timer_actual(kills, time) {
  self endon("disconnect");
  self endon("death");
  timer = gettime() + (time * 1000);
  while(gettime() < timer) {
    if(self.killcounter > kills) {
      self create_and_play_dialog("kill", "streak");
      wait(1);
      self.killcounter = 0;
      timer = -1;
    }
    wait(0.1);
  }
  wait(10);
  self.killcounter = 0;
  self.timerisrunning = 0;
}

function zmbvoxcreate() {
  vox = spawnStruct();
  vox.speaker = [];
  return vox;
}

function zmbvoxinitspeaker(speaker, prefix, ent) {
  ent.zmbvoxid = speaker;
  if(!isDefined(self.speaker[speaker])) {
    self.speaker[speaker] = spawnStruct();
    self.speaker[speaker].alias = [];
  }
  self.speaker[speaker].prefix = prefix;
  self.speaker[speaker].ent = ent;
}

function custom_kill_damaged_vo(player) {
  self notify("sound_damage_player_updated");
  self endon("death");
  self endon("sound_damage_player_updated");
  self.sound_damage_player = player;
  wait(2);
  self.sound_damage_player = undefined;
}

function loadplayervoicecategories(table) {
  level.votimer = [];
  level.sndplayervox = [];
  index = 0;
  row = tablelookuprow(table, index);
  while(isDefined(row)) {
    category = checkstringvalid(row[0]);
    subcategory = checkstringvalid(row[1]);
    suffix = checkstringvalid(row[2]);
    percentage = int(row[3]);
    if(percentage <= 0) {
      percentage = 100;
    }
    response = checkstringtrue(row[4]);
    if(isDefined(response) && response) {
      for(i = 0; i < 4; i++) {
        zmbvoxadd(category, (subcategory + "_resp_") + i, (suffix + "_resp_") + i, 50, 0);
      }
    }
    delaybeforeplayagain = checkintvalid(row[5]);
    zmbvoxadd(category, subcategory, suffix, percentage, response, delaybeforeplayagain);
    index++;
    row = tablelookuprow(table, index);
  }
}

function checkstringvalid(str) {
  if(str != "") {
    return str;
  }
  return undefined;
}

function checkstringtrue(str) {
  if(!isDefined(str)) {
    return false;
  }
  if(str != "") {
    if(tolower(str) == "true") {
      return true;
    }
  }
  return false;
}

function checkintvalid(value, defaultvalue = 0) {
  if(!isDefined(value)) {
    return defaultvalue;
  }
  if(value == "") {
    return defaultvalue;
  }
  return int(value);
}

function zmbvoxadd(category, subcategory, suffix, percentage, response, delaybeforeplayagain = 0) {
  assert(isDefined(category));
  assert(isDefined(subcategory));
  assert(isDefined(suffix));
  assert(isDefined(percentage));
  assert(isDefined(response));
  assert(isDefined(delaybeforeplayagain));
  vox = level.sndplayervox;
  if(!isDefined(vox[category])) {
    vox[category] = [];
  }
  vox[category][subcategory] = spawnStruct();
  vox[category][subcategory].suffix = suffix;
  vox[category][subcategory].percentage = percentage;
  vox[category][subcategory].response = response;
  vox[category][subcategory].delaybeforeplayagain = delaybeforeplayagain;
  zm_utility::create_vox_timer(subcategory);
}

function create_and_play_dialog(category, subcategory, force_variant) {
  if(!isDefined(level.sndplayervox)) {
    return;
  }
  if(!isDefined(level.sndplayervox[category])) {
    return;
  }
  if(!isDefined(level.sndplayervox[category][subcategory])) {
    if(getdvarint("") > 0) {
      println(((("" + category) + "") + subcategory) + "");
    }
    return;
  }
  if(isDefined(level.sndvoxoverride) && level.sndvoxoverride || (isDefined(self.isspeaking) && self.isspeaking && (!(isDefined(self.b_wait_if_busy) && self.b_wait_if_busy)))) {
    return;
  }
  suffix = level.sndplayervox[category][subcategory].suffix;
  percentage = level.sndplayervox[category][subcategory].percentage;
  prefix = shouldplayerspeak(self, category, subcategory, percentage);
  if(!isDefined(prefix)) {
    return;
  }
  sound_to_play = self zmbvoxgetlinevariant(prefix, suffix, force_variant);
  if(isDefined(sound_to_play)) {
    self thread do_player_or_npc_playvox(sound_to_play, category, subcategory);
  } else {
    iprintln("");
    if(getdvarint("") > 0) {}
  }
}

function do_player_or_npc_playvox(sound_to_play, category, subcategory) {
  self endon("death_or_disconnect");
  if(self flag::exists("in_beastmode") && self flag::get("in_beastmode")) {
    return;
  }
  if(!isDefined(self.isspeaking)) {
    self.isspeaking = 0;
  }
  if(self.isspeaking) {
    return;
  }
  waittime = 1;
  if(!self arenearbyspeakersactive() || (isDefined(self.ignorenearbyspkrs) && self.ignorenearbyspkrs)) {
    self.speakingline = sound_to_play;
    self.isspeaking = 1;
    if(isPlayer(self)) {
      self clientfield::set_to_player("isspeaking", 1);
    }
    playbacktime = soundgetplaybacktime(sound_to_play);
    if(!isDefined(playbacktime)) {
      return;
    }
    if(playbacktime >= 0) {
      playbacktime = playbacktime * 0.001;
    } else {
      playbacktime = 1;
    }
    if(isDefined(level._do_player_or_npc_playvox_override)) {
      self thread[[level._do_player_or_npc_playvox_override]](sound_to_play, playbacktime);
      wait(playbacktime);
    } else if(!self istestclient()) {
      self playsoundontag(sound_to_play, "J_Head");
      wait(playbacktime);
    }
    if(isPlayer(self) && isDefined(self.last_vo_played_time)) {
      if(gettime() < (self.last_vo_played_time + 5000)) {
        self.last_vo_played_time = gettime();
        waittime = 7;
      }
    }
    wait(waittime);
    self.isspeaking = 0;
    if(isPlayer(self)) {
      self clientfield::set_to_player("isspeaking", 0);
    }
    if(!level flag::get("solo_game") && (isDefined(level.sndplayervox[category][subcategory].response) && level.sndplayervox[category][subcategory].response)) {
      if(isDefined(level.vox_response_override) && level.vox_response_override) {
        level thread setup_response_line_override(self, category, subcategory);
      } else {
        level thread setup_response_line(self, category, subcategory);
      }
    }
  }
}

function setup_response_line_override(player, category, subcategory) {
  if(isDefined(level._audio_custom_response_line)) {
    self thread[[level._audio_custom_response_line]](player, category, subcategory);
  } else {
    switch (player.characterindex) {
      case 0: {
        level setup_hero_rival(player, 1, 2, category, subcategory);
        break;
      }
      case 1: {
        level setup_hero_rival(player, 2, 3, category, subcategory);
        break;
      }
      case 3: {
        level setup_hero_rival(player, 0, 1, category, subcategory);
        break;
      }
      case 2: {
        level setup_hero_rival(player, 3, 0, category, subcategory);
        break;
      }
    }
  }
}

function setup_hero_rival(player, hero, rival, category, type) {
  players = getplayers();
  hero_player = undefined;
  rival_player = undefined;
  foreach(ent in players) {
    if(ent.characterindex == hero) {
      hero_player = ent;
      continue;
    }
    if(ent.characterindex == rival) {
      rival_player = ent;
    }
  }
  if(isDefined(hero_player) && isDefined(rival_player)) {
    if(randomint(100) > 50) {
      hero_player = undefined;
    } else {
      rival_player = undefined;
    }
  }
  if(isDefined(hero_player) && distancesquared(player.origin, hero_player.origin) < 250000) {
    if(isDefined(player.issamantha) && player.issamantha) {
      hero_player create_and_play_dialog(category, type + "_s");
    } else {
      hero_player create_and_play_dialog(category, type + "_hr");
    }
  } else if(isDefined(rival_player) && distancesquared(player.origin, rival_player.origin) < 250000) {
    if(isDefined(player.issamantha) && player.issamantha) {
      rival_player create_and_play_dialog(category, type + "_s");
    } else {
      rival_player create_and_play_dialog(category, type + "_riv");
    }
  }
}

function setup_response_line(player, category, subcategory) {
  players = array::get_all_closest(player.origin, level.activeplayers);
  players_that_can_respond = array::exclude(players, player);
  if(players_that_can_respond.size == 0) {
    return;
  }
  player_to_respond = players_that_can_respond[0];
  if(distancesquared(player.origin, player_to_respond.origin) < 250000) {
    player_to_respond create_and_play_dialog(category, (subcategory + "_resp_") + player.characterindex);
  }
}

function shouldplayerspeak(player, category, subcategory, percentage) {
  if(!isDefined(player)) {
    return undefined;
  }
  if(!player zm_utility::is_player()) {
    return undefined;
  }
  if(player zm_utility::is_player()) {
    if(player.sessionstate != "playing") {
      return undefined;
    }
    if(player laststand::player_is_in_laststand() && (subcategory != "revive_down" || subcategory != "revive_up")) {
      return undefined;
    }
    if(player isplayerunderwater()) {
      return undefined;
    }
  }
  if(isDefined(player.dontspeak) && player.dontspeak) {
    return undefined;
  }
  if(percentage < randomintrange(1, 101)) {
    return undefined;
  }
  if(isvoxoncooldown(player, category, subcategory)) {
    return undefined;
  }
  index = zm_utility::get_player_index(player);
  if(isDefined(player.issamantha) && player.issamantha) {
    index = 4;
  }
  return ("vox_plr_" + index) + "_";
}

function isvoxoncooldown(player, category, subcategory) {
  if(level.sndplayervox[category][subcategory].delaybeforeplayagain <= 0) {
    return false;
  }
  fullname = category + subcategory;
  if(!isDefined(player.voxtimer)) {
    player.voxtimer = [];
  }
  if(!isDefined(player.voxtimer[fullname])) {
    player.voxtimer[fullname] = gettime();
    return false;
  }
  time = gettime();
  if((time - player.voxtimer[fullname]) <= (level.sndplayervox[category][subcategory].delaybeforeplayagain * 1000)) {
    return true;
  }
  player.voxtimer[fullname] = time;
  return false;
}

function zmbvoxgetlinevariant(prefix, suffix, force_variant) {
  if(!isDefined(self.sound_dialog)) {
    self.sound_dialog = [];
    self.sound_dialog_available = [];
  }
  if(!isDefined(self.sound_dialog[suffix])) {
    num_variants = zm_spawner::get_number_variants(prefix + suffix);
    if(num_variants <= 0) {
      if(getdvarint("") > 0) {
        println(("" + prefix) + suffix);
      }
      return undefined;
    }
    for(i = 0; i < num_variants; i++) {
      self.sound_dialog[suffix][i] = i;
    }
    self.sound_dialog_available[suffix] = [];
  }
  if(self.sound_dialog_available[suffix].size <= 0) {
    for(i = 0; i < self.sound_dialog[suffix].size; i++) {
      self.sound_dialog_available[suffix][i] = self.sound_dialog[suffix][i];
    }
  }
  variation = array::random(self.sound_dialog_available[suffix]);
  arrayremovevalue(self.sound_dialog_available[suffix], variation);
  if(isDefined(force_variant)) {
    variation = force_variant;
  }
  return ((prefix + suffix) + "_") + variation;
}

function arenearbyspeakersactive(radius = 1000) {
  nearbyspeakeractive = 0;
  speakers = getplayers();
  foreach(person in speakers) {
    if(self == person) {
      continue;
    }
    if(person zm_utility::is_player()) {
      if(person.sessionstate != "playing") {
        continue;
      }
      if(person laststand::player_is_in_laststand()) {
        continue;
      }
    }
    if(isDefined(person.isspeaking) && person.isspeaking && (!(isDefined(person.ignorenearbyspkrs) && person.ignorenearbyspkrs))) {
      if(distancesquared(self.origin, person.origin) < (radius * radius)) {
        nearbyspeakeractive = 1;
      }
    }
  }
  return nearbyspeakeractive;
}

function musicstate_create(statename, playtype = 1, musname1, musname2, musname3, musname4, musname5, musname6) {
  if(!isDefined(level.musicsystem)) {
    level.musicsystem = spawnStruct();
    level.musicsystem.queue = 0;
    level.musicsystem.currentplaytype = 0;
    level.musicsystem.currentset = undefined;
    level.musicsystem.states = [];
  }
  level.musicsystem.states[statename] = spawnStruct();
  level.musicsystem.states[statename].playtype = playtype;
  level.musicsystem.states[statename].musarray = array();
  if(isDefined(musname1)) {
    array::add(level.musicsystem.states[statename].musarray, musname1);
  }
  if(isDefined(musname2)) {
    array::add(level.musicsystem.states[statename].musarray, musname2);
  }
  if(isDefined(musname3)) {
    array::add(level.musicsystem.states[statename].musarray, musname3);
  }
  if(isDefined(musname4)) {
    array::add(level.musicsystem.states[statename].musarray, musname4);
  }
  if(isDefined(musname5)) {
    array::add(level.musicsystem.states[statename].musarray, musname5);
  }
  if(isDefined(musname6)) {
    array::add(level.musicsystem.states[statename].musarray, musname6);
  }
}

function sndmusicsystem_createstate(state, statename, playtype = 1, delay = 0) {
  if(!isDefined(level.musicsystem)) {
    level.musicsystem = spawnStruct();
    level.musicsystem.ent = spawn("script_origin", (0, 0, 0));
    level.musicsystem.queue = 0;
    level.musicsystem.currentplaytype = 0;
    level.musicsystem.currentstate = undefined;
    level.musicsystem.states = [];
  }
  m = level.musicsystem;
  if(!isDefined(m.states[state])) {
    m.states[state] = spawnStruct();
    m.states[state] = array();
  }
  m.states[state][m.states[state].size].statename = statename;
  m.states[state][m.states[state].size].playtype = playtype;
}

function sndmusicsystem_playstate(state) {
  if(!isDefined(level.musicsystem)) {
    return;
  }
  m = level.musicsystem;
  if(!isDefined(m.states[state])) {
    return;
  }
  s = level.musicsystem.states[state];
  playtype = s.playtype;
  if(m.currentplaytype > 0) {
    if(playtype == 1) {
      return;
    } else {
      if(playtype == 2) {
        level thread sndmusicsystem_queuestate(state);
      } else if(playtype > m.currentplaytype || (playtype == 3 && m.currentplaytype == 3)) {
        if(isDefined(level.musicsystemoverride) && level.musicsystemoverride && playtype != 5) {
          return;
        }
        level sndmusicsystem_stopandflush();
        level thread playstate(state);
      }
    }
  } else if(!(isDefined(level.musicsystemoverride) && level.musicsystemoverride) || playtype == 5) {
    level thread playstate(state);
  }
}

function playstate(state) {
  level endon("sndstatestop");
  m = level.musicsystem;
  musarray = level.musicsystem.states[state].musarray;
  if(musarray.size <= 0) {
    return;
  }
  mustoplay = musarray[randomintrange(0, musarray.size)];
  m.currentplaytype = m.states[state].playtype;
  m.currentstate = state;
  wait(0.1);
  if(isDefined(level.sndplaystateoverride)) {
    perplayer = level[[level.sndplaystateoverride]](state);
    if(!(isDefined(perplayer) && perplayer)) {
      music::setmusicstate(mustoplay);
    }
  } else {
    music::setmusicstate(mustoplay);
  }
  aliasname = ("mus_" + mustoplay) + "_intro";
  playbacktime = soundgetplaybacktime(aliasname);
  if(!isDefined(playbacktime) || playbacktime <= 0) {
    waittime = 1;
  } else {
    waittime = playbacktime * 0.001;
  }
  wait(waittime);
  m.currentplaytype = 0;
  m.currentstate = undefined;
}

function sndmusicsystem_queuestate(state) {
  level endon("sndqueueflush");
  m = level.musicsystem;
  count = 0;
  if(isDefined(m.queue) && m.queue) {
    return;
  }
  m.queue = 1;
  while(m.currentplaytype > 0) {
    wait(0.5);
    count++;
    if(count >= 25) {
      m.queue = 0;
      return;
    }
  }
  level thread playstate(state);
  m.queue = 0;
}

function sndmusicsystem_stopandflush() {
  level notify("sndqueueflush");
  level.musicsystem.queue = 0;
  level notify("sndstatestop");
  level.musicsystem.currentplaytype = 0;
  level.musicsystem.currentstate = undefined;
}

function sndmusicsystem_isabletoplay() {
  if(!isDefined(level.musicsystem)) {
    return false;
  }
  if(!isDefined(level.musicsystem.currentplaytype)) {
    return false;
  }
  if(level.musicsystem.currentplaytype >= 4) {
    return false;
  }
  return true;
}

function sndmusicsystem_locationsinit(locationarray) {
  if(!isDefined(locationarray) || locationarray.size <= 0) {
    return;
  }
  level.musicsystem.locationarray = locationarray;
  level thread sndmusicsystem_locations(locationarray);
}

function sndmusicsystem_locations(locationarray) {
  numcut = 0;
  level.sndlastzone = undefined;
  m = level.musicsystem;
  while(true) {
    level waittill("newzoneactive", activezone);
    wait(0.1);
    if(!sndlocationshouldplay(locationarray, activezone)) {
      continue;
    }
    level thread sndmusicsystem_playstate(activezone);
    locationarray = sndcurrentlocationarray(locationarray, activezone, numcut, 3);
    level.sndlastzone = activezone;
    if(numcut >= 3) {
      numcut = 0;
    } else {
      numcut++;
    }
    level waittill("between_round_over");
  }
}

function sndlocationshouldplay(array, activezone) {
  shouldplay = 0;
  if(level.musicsystem.currentplaytype >= 3) {
    level thread sndlocationqueue(activezone);
    return shouldplay;
  }
  foreach(place in array) {
    if(place == activezone) {
      shouldplay = 1;
    }
  }
  if(shouldplay == 0) {
    return shouldplay;
  }
  if(zm_zonemgr::any_player_in_zone(activezone)) {
    shouldplay = 1;
  } else {
    shouldplay = 0;
  }
  return shouldplay;
}

function sndcurrentlocationarray(current_array, activezone, numcut, num) {
  if(numcut >= num) {
    current_array = level.musicsystem.locationarray;
  }
  foreach(place in current_array) {
    if(place == activezone) {
      arrayremovevalue(current_array, place);
      break;
    }
  }
  return current_array;
}

function sndlocationqueue(zone) {
  level endon("newzoneactive");
  while(level.musicsystem.currentplaytype >= 3) {
    wait(0.5);
  }
  level notify("newzoneactive", zone);
}

function sndmusicsystem_eesetup(state, origin1, origin2, origin3, origin4, origin5) {
  sndeearray = array();
  if(isDefined(origin1)) {
    if(!isDefined(sndeearray)) {
      sndeearray = [];
    } else if(!isarray(sndeearray)) {
      sndeearray = array(sndeearray);
    }
  }
  sndeearray[sndeearray.size] = origin1;
  if(isDefined(origin2)) {
    if(!isDefined(sndeearray)) {
      sndeearray = [];
    } else if(!isarray(sndeearray)) {
      sndeearray = array(sndeearray);
    }
  }
  sndeearray[sndeearray.size] = origin2;
  if(isDefined(origin3)) {
    if(!isDefined(sndeearray)) {
      sndeearray = [];
    } else if(!isarray(sndeearray)) {
      sndeearray = array(sndeearray);
    }
  }
  sndeearray[sndeearray.size] = origin3;
  if(isDefined(origin4)) {
    if(!isDefined(sndeearray)) {
      sndeearray = [];
    } else if(!isarray(sndeearray)) {
      sndeearray = array(sndeearray);
    }
  }
  sndeearray[sndeearray.size] = origin4;
  if(isDefined(origin5)) {
    if(!isDefined(sndeearray)) {
      sndeearray = [];
    } else if(!isarray(sndeearray)) {
      sndeearray = array(sndeearray);
    }
  }
  sndeearray[sndeearray.size] = origin5;
  if(sndeearray.size > 0) {
    level.sndeemax = sndeearray.size;
    level.sndeecount = 0;
    foreach(origin in sndeearray) {
      level thread sndmusicsystem_eewait(origin, state);
    }
  }
}

function sndmusicsystem_eewait(origin, state) {
  temp_ent = spawn("script_origin", origin);
  temp_ent playLoopSound("zmb_meteor_loop");
  temp_ent thread secretuse("main_music_egg_hit", vectorscale((0, 1, 0), 255), &sndmusicsystem_eeoverride);
  temp_ent waittill("main_music_egg_hit", player);
  temp_ent stoploopsound(1);
  player playSound("zmb_meteor_activate");
  level.sndeecount++;
  if(level.sndeecount >= level.sndeemax) {
    level notify("hash_a1b1dadb");
    level thread sndmusicsystem_playstate(state);
  }
  temp_ent delete();
}

function sndmusicsystem_eeoverride(arg1, arg2) {
  if(isDefined(level.musicsystem.currentplaytype) && level.musicsystem.currentplaytype >= 4) {
    return false;
  }
  return true;
}

function secretuse(notify_string, color, qualifier_func, arg1, arg2) {
  waittillframeend();
  while(true) {
    if(!isDefined(self)) {
      return;
    }
    print3d(self.origin, "", color, 1);
    players = level.players;
    foreach(player in players) {
      qualifier_passed = 1;
      if(isDefined(qualifier_func)) {
        qualifier_passed = player[[qualifier_func]](arg1, arg2);
      }
      if(qualifier_passed && distancesquared(self.origin, player.origin) < 4096) {
        if(player laststand::is_facing(self)) {
          if(player useButtonPressed()) {
            self notify(notify_string, player);
            return;
          }
        }
      }
    }
    wait(0.1);
  }
}

function sndannouncer_init() {
  if(!isDefined(level.zmannouncerprefix)) {
    level.zmannouncerprefix = ("vox_" + "zmba") + "_";
  }
  sndannouncervoxadd("carpenter", "powerup_carpenter_0");
  sndannouncervoxadd("insta_kill", "powerup_instakill_0");
  sndannouncervoxadd("double_points", "powerup_doublepoints_0");
  sndannouncervoxadd("nuke", "powerup_nuke_0");
  sndannouncervoxadd("full_ammo", "powerup_maxammo_0");
  sndannouncervoxadd("fire_sale", "powerup_firesale_0");
  sndannouncervoxadd("minigun", "powerup_death_machine_0");
  sndannouncervoxadd("boxmove", "event_magicbox_0");
  sndannouncervoxadd("dogstart", "event_dogstart_0");
}

function sndannouncervoxadd(type, suffix) {
  if(!isDefined(level.zmannouncervox)) {
    level.zmannouncervox = array();
  }
  level.zmannouncervox[type] = suffix;
}

function sndannouncerplayvox(type, player) {
  if(!isDefined(level.zmannouncervox[type])) {
    return;
  }
  prefix = level.zmannouncerprefix;
  suffix = level.zmannouncervox[type];
  if(!(isDefined(level.zmannouncertalking) && level.zmannouncertalking)) {
    if(!isDefined(player)) {
      level.zmannouncertalking = 1;
      temp_ent = spawn("script_origin", (0, 0, 0));
      temp_ent playsoundwithnotify(prefix + suffix, (prefix + suffix) + "wait");
      temp_ent waittill((prefix + suffix) + "wait");
      wait(0.05);
      temp_ent delete();
      level.zmannouncertalking = 0;
    } else {
      player playsoundtoplayer(prefix + suffix, player);
    }
  }
}

function zmbaivox_notifyconvert() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self thread zmbaivox_playdeath();
  self thread zmbaivox_playelectrocution();
  while(true) {
    self waittill("bhtn_action_notify", notify_string);
    switch (notify_string) {
      case "pain": {
        level thread zmbaivox_playvox(self, notify_string, 1, 9);
        break;
      }
      case "death": {
        if(isDefined(self.bgb_tone_death) && self.bgb_tone_death) {
          level thread zmbaivox_playvox(self, "death_whimsy", 1, 10);
        } else {
          level thread zmbaivox_playvox(self, notify_string, 1, 10);
        }
        break;
      }
      case "behind": {
        level thread zmbaivox_playvox(self, notify_string, 1, 9);
        break;
      }
      case "attack_melee": {
        if(!isDefined(self.animname) || (self.animname != "zombie" && self.animname != "quad_zombie")) {
          level thread zmbaivox_playvox(self, notify_string, 1, 8, 1);
        }
        break;
      }
      case "attack_melee_zhd": {
        level thread zmbaivox_playvox(self, "attack_melee", 1, 8, 1);
        break;
      }
      case "electrocute": {
        level thread zmbaivox_playvox(self, notify_string, 1, 7);
        break;
      }
      case "close": {
        level thread zmbaivox_playvox(self, notify_string, 1, 6);
        break;
      }
      case "ambient":
      case "crawler":
      case "sprint":
      case "taunt":
      case "teardown": {
        level thread zmbaivox_playvox(self, notify_string, 0);
        break;
      }
      default: {
        if(isDefined(level._zmbaivox_specialtype)) {
          if(isDefined(level._zmbaivox_specialtype[notify_string])) {
            level thread zmbaivox_playvox(self, notify_string, 0);
          }
        }
        break;
      }
    }
  }
}

function zmbaivox_playvox(zombie, type, override, priority, delayambientvox = 0) {
  zombie endon("death");
  if(!isDefined(zombie)) {
    return;
  }
  if(!isDefined(zombie.voiceprefix)) {
    return;
  }
  if(!isDefined(priority)) {
    priority = 1;
  }
  if(!isDefined(zombie.currentvoxpriority)) {
    zombie.currentvoxpriority = 1;
  }
  if(!isDefined(self.delayambientvox)) {
    self.delayambientvox = 0;
  }
  if(type == "ambient" || type == "sprint" || type == "crawler" && (isDefined(self.delayambientvox) && self.delayambientvox)) {
    return;
  }
  if(delayambientvox) {
    self.delayambientvox = 1;
    self thread zmbaivox_ambientdelay();
  }
  alias = (("zmb_vocals_" + zombie.voiceprefix) + "_") + type;
  if(sndisnetworksafe()) {
    if(isDefined(override) && override) {
      if(isDefined(zombie.currentvox) && priority > zombie.currentvoxpriority) {
        zombie stopsound(zombie.currentvox);
      }
      if(type == "death" || type == "death_whimsy") {
        zombie playSound(alias);
        return;
      }
    }
    if(zombie.talking === 1 && priority < zombie.currentvoxpriority) {
      return;
    }
    zombie.talking = 1;
    if(zombie is_last_zombie() && type == "ambient") {
      alias = alias + "_loud";
    }
    zombie.currentvox = alias;
    zombie.currentvoxpriority = priority;
    zombie playsoundontag(alias, "j_head");
    playbacktime = soundgetplaybacktime(alias);
    if(!isDefined(playbacktime)) {
      playbacktime = 1;
    }
    if(playbacktime >= 0) {
      playbacktime = playbacktime * 0.001;
    } else {
      playbacktime = 1;
    }
    wait(playbacktime);
    zombie.talking = 0;
    zombie.currentvox = undefined;
    zombie.currentvoxpriority = 1;
  }
}

function zmbaivox_playdeath() {
  self endon("disconnect");
  self waittill("death", attacker, meansofdeath);
  if(isDefined(self)) {
    if(isDefined(self.bgb_tone_death) && self.bgb_tone_death) {
      level thread zmbaivox_playvox(self, "death_whimsy", 1);
    } else {
      level thread zmbaivox_playvox(self, "death", 1);
    }
  }
}

function zmbaivox_playelectrocution() {
  self endon("disconnect");
  self endon("death");
  while(true) {
    self waittill("damage", amount, attacker, direction_vec, point, type, tagname, modelname, partname, weapon);
    if(weapon.name == "zombie_beast_lightning_dwl" || weapon.name == "zombie_beast_lightning_dwl2" || weapon.name == "zombie_beast_lightning_dwl3") {
      self notify("bhtn_action_notify", "electrocute");
    }
  }
}

function zmbaivox_ambientdelay() {
  self notify("sndambientdelay");
  self endon("sndambientdelay");
  self endon("death");
  self endon("disconnect");
  wait(2);
  self.delayambientvox = 0;
}

function networksafereset() {
  while(true) {
    level._numzmbaivox = 0;
    util::wait_network_frame();
  }
}

function sndisnetworksafe() {
  if(!isDefined(level._numzmbaivox)) {
    level thread networksafereset();
  }
  if(level._numzmbaivox >= 2) {
    return false;
  }
  level._numzmbaivox++;
  return true;
}

function is_last_zombie() {
  if(zombie_utility::get_current_zombie_count() <= 1) {
    return true;
  }
  return false;
}

function sndradiosetup(alias_prefix, is_sequential = 0, origin1, origin2, origin3, origin4, origin5) {
  radio = spawnStruct();
  radio.counter = 1;
  radio.alias_prefix = alias_prefix;
  radio.isplaying = 0;
  radio.array = array();
  if(isDefined(origin1)) {
    if(!isDefined(radio.array)) {
      radio.array = [];
    } else if(!isarray(radio.array)) {
      radio.array = array(radio.array);
    }
  }
  radio.array[radio.array.size] = origin1;
  if(isDefined(origin2)) {
    if(!isDefined(radio.array)) {
      radio.array = [];
    } else if(!isarray(radio.array)) {
      radio.array = array(radio.array);
    }
  }
  radio.array[radio.array.size] = origin2;
  if(isDefined(origin3)) {
    if(!isDefined(radio.array)) {
      radio.array = [];
    } else if(!isarray(radio.array)) {
      radio.array = array(radio.array);
    }
  }
  radio.array[radio.array.size] = origin3;
  if(isDefined(origin4)) {
    if(!isDefined(radio.array)) {
      radio.array = [];
    } else if(!isarray(radio.array)) {
      radio.array = array(radio.array);
    }
  }
  radio.array[radio.array.size] = origin4;
  if(isDefined(origin5)) {
    if(!isDefined(radio.array)) {
      radio.array = [];
    } else if(!isarray(radio.array)) {
      radio.array = array(radio.array);
    }
  }
  radio.array[radio.array.size] = origin5;
  if(radio.array.size > 0) {
    for(i = 0; i < radio.array.size; i++) {
      level thread sndradiowait(radio.array[i], radio, is_sequential, i + 1);
    }
  }
}

function sndradiowait(origin, radio, is_sequential, num) {
  temp_ent = spawn("script_origin", origin);
  temp_ent thread secretuse("sndRadioHit", vectorscale((0, 0, 1), 255), &sndradio_override, radio);
  temp_ent waittill("sndradiohit", player);
  if(!(isDefined(is_sequential) && is_sequential)) {
    radionum = num;
  } else {
    radionum = radio.counter;
  }
  radioalias = radio.alias_prefix + radionum;
  radiolinecount = zm_spawner::get_number_variants(radioalias);
  if(radiolinecount > 0) {
    radio.isplaying = 1;
    for(i = 0; i < radiolinecount; i++) {
      temp_ent playSound((radioalias + "_") + i);
      playbacktime = soundgetplaybacktime((radioalias + "_") + i);
      if(!isDefined(playbacktime)) {
        playbacktime = 1;
      }
      if(playbacktime >= 0) {
        playbacktime = playbacktime * 0.001;
      } else {
        playbacktime = 1;
      }
      wait(playbacktime);
    }
  }
  radio.counter++;
  radio.isplaying = 0;
  temp_ent delete();
}

function sndradio_override(arg1, arg2) {
  if(isDefined(arg1) && arg1.isplaying == 1) {
    return false;
  }
  return true;
}

function sndperksjingles_timer() {
  self endon("death");
  if(isDefined(self.sndjinglecooldown)) {
    self.sndjinglecooldown = 0;
  }
  while(true) {
    wait(randomfloatrange(30, 60));
    if(randomintrange(0, 100) <= 10 && (!(isDefined(self.sndjinglecooldown) && self.sndjinglecooldown))) {
      self thread sndperksjingles_player(0);
    }
  }
}

function sndperksjingles_player(type) {
  self endon("death");
  if(!isDefined(self.sndjingleactive)) {
    self.sndjingleactive = 0;
  }
  alias = self.script_sound;
  if(type == 1) {
    alias = self.script_label;
  }
  if(isDefined(level.musicsystem) && level.musicsystem.currentplaytype >= 4) {
    return;
  }
  self.str_jingle_alias = alias;
  if(!(isDefined(self.sndjingleactive) && self.sndjingleactive)) {
    self.sndjingleactive = 1;
    self playsoundwithnotify(alias, "sndDone");
    playbacktime = soundgetplaybacktime(alias);
    if(!isDefined(playbacktime) || playbacktime <= 0) {
      waittime = 1;
    } else {
      waittime = playbacktime * 0.001;
    }
    wait(waittime);
    if(type == 0) {
      self.sndjinglecooldown = 1;
      self thread sndperksjingles_cooldown();
    }
    self.sndjingleactive = 0;
  }
}

function sndperksjingles_cooldown() {
  self endon("death");
  if(isDefined(self.var_1afc1154)) {
    while(isDefined(self.var_1afc1154) && self.var_1afc1154) {
      wait(1);
    }
  }
  wait(45);
  self.sndjinglecooldown = 0;
}

function sndconversation_init(name, specialendon = undefined) {
  if(!isDefined(level.sndconversations)) {
    level.sndconversations = array();
  }
  level.sndconversations[name] = spawnStruct();
  level.sndconversations[name].specialendon = specialendon;
}

function sndconversation_addline(name, line, player_or_random, ignoreplayer = 5) {
  thisconvo = level.sndconversations[name];
  if(!isDefined(thisconvo.line)) {
    thisconvo.line = array();
  }
  if(!isDefined(thisconvo.player)) {
    thisconvo.player = array();
  }
  if(!isDefined(thisconvo.ignoreplayer)) {
    thisconvo.ignoreplayer = array();
  }
  if(!isDefined(thisconvo.line)) {
    thisconvo.line = [];
  } else if(!isarray(thisconvo.line)) {
    thisconvo.line = array(thisconvo.line);
  }
  thisconvo.line[thisconvo.line.size] = line;
  if(!isDefined(thisconvo.player)) {
    thisconvo.player = [];
  } else if(!isarray(thisconvo.player)) {
    thisconvo.player = array(thisconvo.player);
  }
  thisconvo.player[thisconvo.player.size] = player_or_random;
  if(!isDefined(thisconvo.ignoreplayer)) {
    thisconvo.ignoreplayer = [];
  } else if(!isarray(thisconvo.ignoreplayer)) {
    thisconvo.ignoreplayer = array(thisconvo.ignoreplayer);
  }
  thisconvo.ignoreplayer[thisconvo.ignoreplayer.size] = ignoreplayer;
}

function sndconversation_play(name) {
  thisconvo = level.sndconversations[name];
  level endon("sndconvointerrupt");
  if(isDefined(thisconvo.specialendon)) {
    level endon(thisconvo.specialendon);
  }
  while(isanyonetalking()) {
    wait(0.5);
  }
  while(isDefined(level.sndvoxoverride) && level.sndvoxoverride) {
    wait(0.5);
  }
  level.sndvoxoverride = 1;
  for(i = 0; i < thisconvo.line.size; i++) {
    if(thisconvo.player[i] == 4) {
      speaker = getrandomcharacter(thisconvo.ignoreplayer[i]);
    } else {
      speaker = getspecificcharacter(thisconvo.player[i]);
    }
    if(!isDefined(speaker)) {
      continue;
    }
    if(iscurrentspeakerabletotalk(speaker)) {
      level.currentconvoplayer = speaker;
      if(isDefined(level.vox_name_complete)) {
        level.currentconvoline = thisconvo.line[i];
      } else {
        level.currentconvoline = (("vox_plr_" + speaker.characterindex) + "_") + thisconvo.line[i];
        speaker thread sndconvointerrupt();
      }
      speaker playsoundontag(level.currentconvoline, "J_Head");
      waitplaybacktime(level.currentconvoline);
      level notify("sndconvolinedone");
    }
  }
  level.sndvoxoverride = 0;
  level notify("sndconversationdone");
  level.currentconvoline = undefined;
  level.currentconvoplayer = undefined;
}

function sndconvostopcurrentconversation() {
  level notify("sndconvointerrupt");
  level notify("sndconversationdone");
  level.sndvoxoverride = 0;
  if(isDefined(level.currentconvoplayer) && isDefined(level.currentconvoline)) {
    level.currentconvoplayer stopsound(level.currentconvoline);
    level.currentconvoline = undefined;
    level.currentconvoplayer = undefined;
  }
}

function waitplaybacktime(alias) {
  playbacktime = soundgetplaybacktime(alias);
  if(!isDefined(playbacktime)) {
    playbacktime = 1;
  }
  if(playbacktime >= 0) {
    playbacktime = playbacktime * 0.001;
  } else {
    playbacktime = 1;
  }
  wait(playbacktime);
}

function iscurrentspeakerabletotalk(player) {
  if(!isDefined(player)) {
    return false;
  }
  if(player.sessionstate != "playing") {
    return false;
  }
  if(isDefined(player.laststand) && player.laststand) {
    return false;
  }
  return true;
}

function getrandomcharacter(ignore) {
  array = level.players;
  array::randomize(array);
  foreach(guy in array) {
    if(guy.characterindex == ignore) {
      continue;
    }
    return guy;
  }
  return undefined;
}

function getspecificcharacter(charindex) {
  foreach(guy in level.players) {
    if(guy.characterindex == charindex) {
      return guy;
    }
  }
  return undefined;
}

function isanyonetalking() {
  foreach(player in level.players) {
    if(isDefined(player.isspeaking) && player.isspeaking) {
      return true;
    }
  }
  return false;
}

function sndconvointerrupt() {
  level endon("sndconvolinedone");
  while(true) {
    if(!isDefined(self)) {
      return;
    }
    max_dist_squared = 0;
    check_pos = self.origin;
    count = 0;
    foreach(player in level.players) {
      if(self == player) {
        continue;
      }
      if(distance2dsquared(player.origin, self.origin) >= 810000) {
        count++;
      }
    }
    if(count == (level.players.size - 1)) {
      break;
    }
    wait(0.25);
  }
  level thread sndconvostopcurrentconversation();
}

function water_vox() {
  self endon("death");
  self endon("disconnect");
  level endon("end_game");
  self.voxunderwatertime = 0;
  self.voxemergebreath = 0;
  self.voxdrowning = 0;
  while(true) {
    if(self isplayerunderwater()) {
      if(!self.voxunderwatertime && !self.voxemergebreath) {
        self vo_clear_underwater();
        self.voxunderwatertime = gettime();
      } else if(self.voxunderwatertime) {
        if(gettime() > (self.voxunderwatertime + 3000)) {
          self.voxunderwatertime = 0;
          self.voxemergebreath = 1;
        }
      }
    } else {
      if(self.voxdrowning) {
        self playerexert("underwater_gasp");
        self.voxdrowning = 0;
        self.voxemergebreath = 0;
      }
      if(self.voxemergebreath) {
        self playerexert("underwater_emerge");
        self.voxemergebreath = 0;
      } else {
        self.voxunderwatertime = 0;
      }
    }
    wait(0.05);
  }
}

function vo_clear_underwater() {
  if(level flag::exists("abcd_speaking")) {
    if(level flag::get("abcd_speaking")) {
      return;
    }
  }
  if(level flag::exists("shadowman_speaking")) {
    if(level flag::get("shadowman_speaking")) {
      return;
    }
  }
  self stopsounds();
  self notify("stop_vo_convo");
  self.str_vo_being_spoken = "";
  self.n_vo_priority = 0;
  self.isspeaking = 0;
  level.sndvoxoverride = 0;
  b_in_a_e_speakers = 0;
  foreach(e_checkme in level.a_e_speakers) {
    if(e_checkme == self) {
      b_in_a_e_speakers = 1;
      break;
    }
  }
  if(isDefined(b_in_a_e_speakers) && b_in_a_e_speakers) {
    arrayremovevalue(level.a_e_speakers, self);
  }
}

function sndplayerhitalert(e_victim, str_meansofdeath, e_inflictor, weapon) {
  if(!(isDefined(level.sndzhdaudio) && level.sndzhdaudio)) {
    return;
  }
  if(!isPlayer(self)) {
    return;
  }
  if(!checkforvalidmod(str_meansofdeath)) {
    return;
  }
  if(!checkforvalidweapon(weapon)) {
    return;
  }
  if(!checkforvalidaitype(e_victim)) {
    return;
  }
  str_alias = "zmb_hit_alert";
  self thread sndplayerhitalert_playSound(str_alias);
}

function sndplayerhitalert_playSound(str_alias) {
  self endon("disconnect");
  if(self.hitsoundtracker) {
    self.hitsoundtracker = 0;
    self playsoundtoplayer(str_alias, self);
    wait(0.05);
    self.hitsoundtracker = 1;
  }
}

function checkforvalidmod(str_meansofdeath) {
  if(!isDefined(str_meansofdeath)) {
    return false;
  }
  switch (str_meansofdeath) {
    case "MOD_CRUSH":
    case "MOD_GRENADE_SPLASH":
    case "MOD_HIT_BY_OBJECT":
    case "MOD_MELEE":
    case "MOD_MELEE_ASSASSINATE":
    case "MOD_MELEE_WEAPON_BUTT": {
      return false;
    }
  }
  return true;
}

function checkforvalidweapon(weapon) {
  return true;
}

function checkforvalidaitype(e_victim) {
  return true;
}