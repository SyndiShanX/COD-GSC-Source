/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\fr.gsc
*************************************************/

#using scripts\mp\_pickup_items;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_globallogic;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_globallogic_score;
#using scripts\mp\gametypes\_spawning;
#using scripts\mp\gametypes\_spawnlogic;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\popups_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace fr;

function main() {
  level.trackweaponstats = 0;
  globallogic::init();
  clientfield::register("world", "freerun_state", 1, 3, "int");
  clientfield::register("world", "freerun_retries", 1, 16, "int");
  clientfield::register("world", "freerun_faults", 1, 16, "int");
  clientfield::register("world", "freerun_startTime", 1, 31, "int");
  clientfield::register("world", "freerun_finishTime", 1, 31, "int");
  clientfield::register("world", "freerun_bestTime", 1, 31, "int");
  clientfield::register("world", "freerun_timeAdjustment", 1, 31, "int");
  clientfield::register("world", "freerun_timeAdjustmentNegative", 1, 1, "int");
  clientfield::register("world", "freerun_bulletPenalty", 1, 16, "int");
  clientfield::register("world", "freerun_pausedTime", 1, 31, "int");
  clientfield::register("world", "freerun_checkpointIndex", 1, 7, "int");
  util::registertimelimit(0, 1440);
  util::registerscorelimit(0, 50000);
  util::registerroundlimit(0, 10);
  util::registerroundwinlimit(0, 10);
  util::registernumlives(0, 100);
  globallogic::registerfriendlyfiredelay(level.gametype, 0, 0, 1440);
  level.scoreroundwinbased = getgametypesetting("cumulativeRoundScores") == 0;
  level.teamscoreperkill = getgametypesetting("teamScorePerKill");
  level.teamscoreperdeath = getgametypesetting("teamScorePerDeath");
  level.teamscoreperheadshot = getgametypesetting("teamScorePerHeadshot");
  level.onstartgametype = & onstartgametype;
  level.onspawnplayer = & onspawnplayer;
  level.givecustomloadout = & givecustomloadout;
  level.postroundtime = 0.5;
  level.doendgamescoreboard = 0;
  callback::on_connect( & on_player_connect);
  gameobjects::register_allowed_gameobject("dm");
  gameobjects::register_allowed_gameobject(level.gametype);
  if(!isdefined(level.fr_target_impact_fx)) {
    level.fr_target_impact_fx = "ui/fx_fr_target_impact";
  }
  if(!isdefined(level.fr_target_disable_fx)) {
    level.fr_target_disable_fx = "ui/fx_fr_target_demat";
  }
  if(!isdefined(level.fr_target_disable_sound)) {
    level.fr_target_disable_sound = "wpn_grenade_explode_default";
  }
  level.frgame = spawnstruct();
  level.frgame.activetrackindex = 0;
  level.frgame.tracks = [];
  for (i = 0; i < 1; i++) {
    level.frgame.tracks[i] = spawnstruct();
    level.frgame.tracks[i].starttrigger = getent("fr_start_0" + i, "targetname");
    assert(isdefined(level.frgame.tracks[i].starttrigger));
    level.frgame.tracks[i].goaltrigger = getent("fr_end_0" + i, "targetname");
    assert(isdefined(level.frgame.tracks[i].goaltrigger));
    level.frgame.tracks[i].highscores = [];
  }
  level.frgame.checkpointtriggers = getentarray("fr_checkpoint", "targetname");
  assert(level.frgame.checkpointtriggers.size);
  globallogic::setvisiblescoreboardcolumns("pointstowin", "kills", "deaths", "headshots", "score");
}

function setupteam(team) {
  util::setobjectivetext(team, & "OBJECTIVES_FR");
  if(level.splitscreen) {
    util::setobjectivescoretext(team, & "OBJECTIVES_FR");
  } else {
    util::setobjectivescoretext(team, & "OBJECTIVES_FR_SCORE");
  }
  util::setobjectivehinttext(team, & "OBJECTIVES_FR_SCORE");
  spawnlogic::add_spawn_points(team, "mp_dm_spawn");
}

function onstartgametype() {
  setclientnamemode("auto_change");
  level.usexcamsforendgame = 0;
  level.can_set_aar_stat = 0;
  level.disablebehaviortracker = 1;
  level.disablestattracking = 1;
  spawning::create_map_placed_influencers();
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  foreach(team in level.teams) {
    setupteam(team);
  }
  spawns = spawnlogic::get_spawnpoint_array("mp_dm_spawn");
  spawning::updateallspawnpoints();
  foreach(index, trigger in level.frgame.checkpointtriggers) {
    level.frgame.checkpointtimes[index] = 0;
    trigger.checkpointindex = index;
    trigger thread watchcheckpointtrigger();
    closest = 99999999;
    foreach(spawn in spawns) {
      dist = distancesquared(spawn.origin, trigger.origin);
      if(dist < closest) {
        closest = dist;
        trigger.spawnpoint = spawn;
      }
    }
    assert(isdefined(trigger.spawnpoint));
  }
  player_starts = spawnlogic::_get_spawnpoint_array("info_player_start");
  assert(player_starts.size);
  foreach(track in level.frgame.tracks) {
    closest = 99999999;
    foreach(start in player_starts) {
      dist = distancesquared(start.origin, track.starttrigger.origin);
      if(dist < closest) {
        closest = dist;
        track.playerstart = start;
      }
    }
    assert(isdefined(track.playerstart));
  }
  level.frgame.deathtriggers = getentarray("fr_die", "targetname");
  assert(level.frgame.deathtriggers.size);
  foreach(trigger in level.frgame.deathtriggers) {
    trigger thread watchdeathtrigger();
  }
  setup_tutorial();
  if(!isdefined(level.freerun)) {
    level.freerun = 1;
  }
  level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  spawnpoint = spawnlogic::get_random_intermission_point();
  setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
  level.usestartspawns = 0;
  level.displayroundendtext = 0;
  if(!util::isoneround()) {
    level.displayroundendtext = 1;
  }
  foreach(item in level.pickup_items) {
    closest = 99999999;
    foreach(trigger in level.frgame.checkpointtriggers) {
      dist = distancesquared(item.origin, trigger.origin);
      if(dist < closest) {
        closest = dist;
        item.checkpoint = trigger;
      }
    }
    assert(isdefined(item.checkpoint));
    item.checkpoint.weapon = item.visuals[0].items[0].weapon;
    item.checkpoint.weaponobject = item;
    item.checkpoint setup_weapon_targets();
  }
  thread watch_for_game_end();
  level.frgame.trackindex = getfreeruntrackindex();
  level.frgame.mapuniqueid = getmissionuniqueid();
  level.frgame.mapversion = getmissionversion();
}

function watch_for_game_end() {
  level waittill("game_ended");
  if(!end_game_state()) {
    level clientfield::set("freerun_finishTime", 0);
  }
  self stop_tutorial_vo();
  level clientfield::set("freerun_state", 4);
}

function on_player_connect() {
  self thread on_menu_response();
}

function on_menu_response() {
  self endon("disconnect");
  for (;;) {
    self waittill("menuresponse", menu, response);
    if(response == "fr_restart") {
      self playsoundtoplayer("uin_freerun_reset", self);
      self thread freerunmusic();
      activatetrack(level.frgame.activetrackindex);
    }
  }
}

function onspawnplayer(predictedspawn) {
  spawning::onspawnplayer(predictedspawn);
  if(predictedspawn) {
    return;
  }
  if(isdefined(self.frinited)) {
    self.body hide();
    faultdeath();
    return;
  }
  self.frinited = 1;
  self thread activate_tutorial_mode();
  self thread activatetrack(level.frgame.activetrackindex);
  self thread watchtrackswitch();
  self thread watchweaponfire();
  self thread freerunmusic();
  self thread trackplayerorigin();
  level.frgame.lastplayedfaultvotime = 0;
  self disableweaponcycling();
}

function on_player_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime) {
  if(idamage >= self.health) {
    self.health = self.maxhealth + 1;
    faultdeath();
    return 0;
  }
  return idamage;
}

function trackplayerorigin() {
  self endon("disconnect");
  while (true) {
    self.prev_origin = self.origin;
    self.prev_time = gettime();
    wait(0.05);
    waittillframeend();
  }
}

function readhighscores() {
  get_top_scores_stats();
  updatehighscores();
}

function updatehighscores() {
  self freerunsethighscores(level.frgame.activetrack.highscores[0].time, level.frgame.activetrack.highscores[1].time, level.frgame.activetrack.highscores[2].time);
  level clientfield::set("freerun_bestTime", level.frgame.activetrack.highscores[0].time);
}

function activatetrack(trackindex) {
  level notify("activate_track");
  if(level.frgame.tracks.size > 1) {
    iprintln("" + trackindex);
  }
  if(!isdefined(level.frgame.tutorials) || !level.frgame.tutorials) {
    self playlocalsound("vox_tuto_tutorial_sequence_27");
  }
  level.frgame.lastplayedfaultvocheckpoint = -1;
  level.frgame.activetrackindex = trackindex;
  level.frgame.activetrack = level.frgame.tracks[trackindex];
  level.frgame.activespawnpoint = level.frgame.activetrack.playerstart;
  level.frgame.activespawnlocation = level.frgame.activetrack.playerstart.origin;
  level.frgame.activespawnangles = level.frgame.activetrack.playerstart.angles;
  level.frgame.activetrack.goaltrigger thread watchgoaltrigger();
  level.frgame.activespawnpoint.checkpointindex = 0;
  level.frgame.faults = 0;
  level.frgame.userspawns = 0;
  level.frgame.checkpointtimes = [];
  foreach(index, trigger in level.frgame.checkpointtriggers) {
    level.frgame.checkpointtimes[index] = 0;
  }
  level clientfield::set("freerun_faults", 0);
  level clientfield::set("freerun_retries", 0);
  level clientfield::set("freerun_state", 0);
  level clientfield::set("freerun_bulletPenalty", 0);
  level clientfield::set("freerun_pausedTime", 0);
  level clientfield::set("freerun_checkpointIndex", 0);
  self readhighscores();
  self givecustomloadout();
  self setorigin(level.frgame.activetrack.playerstart.origin);
  self setplayerangles(level.frgame.activetrack.playerstart.angles);
  self setvelocity((0, 0, 0));
  self recordgameevent("start");
  resetglass();
  reset_all_targets();
  pickup_items::respawn_all_pickups();
  self unfreeze();
  self.respawn_position = undefined;
  enable_all_tutorial_triggers();
  take_players_out_of_tutorial_mode();
  level.frgame.activetrack.starttrigger thread watchstartrun(self);
}

function startrun() {
  level.frgame.totalpausedtime = 0;
  level.frgame.pausedattime = 0;
  level.frgame.bulletpenalty = 0;
  level.frgame.hasbeenpaused = 0;
  level.frgame.trackstarttime = 0;
  level.frgame.trackstarttime = get_current_track_time(self);
  level clientfield::set("freerun_startTime", level.frgame.trackstarttime);
  level clientfield::set("freerun_state", 1);
  self playsoundtoplayer("uin_freerun_start", self);
  self thread watchuserrespawn();
}

function oncheckpointtrigger(player, endonstring) {
  self endon(endonstring);
  level.frgame.activespawnlocation = getgroundpointfororigin(player.origin);
  level.frgame.activespawnangles = player.angles;
  if(level.frgame.activespawnpoint != self) {
    level.frgame.activespawnpoint = self;
    player take_all_player_weapons(0, 0);
    if(isdefined(self.weaponobject)) {
      self.weaponobject reset_targets();
      self.weaponobject pickup_items::respawn_pickup();
    }
  }
}

function leavecheckpointtrigger(player) {
  self thread watchcheckpointtrigger();
}

function get_current_track_time(player) {
  curtime = gettime();
  dt = curtime - player.prev_time;
  frac = getfirsttouchfraction(player, self, player.prev_origin, player.origin);
  current_time = (curtime - level.frgame.trackstarttime) + (level.frgame.bulletpenalty * 1000) + (level.frgame.userspawns * 5000) - level.frgame.totalpausedtime;
  return int(current_time - (dt * (1 - frac)));
}

function watchcheckpointtrigger() {
  self waittill("trigger", player);
  if(isplayer(player)) {
    if(level.frgame.activespawnpoint != self) {
      checkpoint_index = self.checkpointindex;
      current_time = get_current_track_time(player);
      first_time = 0;
      if(!isdefined(level.frgame.checkpointtimes[checkpoint_index]) || level.frgame.checkpointtimes[checkpoint_index] == 0) {
        level.frgame.checkpointtimes[checkpoint_index] = current_time;
        first_time = 1;
      }
      if(first_time) {
        if(isdefined(level.frgame.activetrack.fastestruncheckpointtimes)) {
          if(isdefined(level.frgame.activetrack.fastestruncheckpointtimes[checkpoint_index]) && level.frgame.activetrack.fastestruncheckpointtimes[checkpoint_index]) {
            delta_time = current_time - level.frgame.activetrack.fastestruncheckpointtimes[checkpoint_index];
            if(delta_time < 0) {
              delta_time = delta_time * -1;
              sign = 1;
            } else {
              sign = 0;
            }
            level clientfield::set("freerun_timeAdjustment", delta_time);
            level clientfield::set("freerun_timeAdjustmentNegative", sign);
          }
        }
        level clientfield::set("freerun_checkpointIndex", checkpoint_index + 1);
        player playsoundtoplayer("uin_freerun_checkpoint", player);
      }
    }
    self thread util::trigger_thread(player, & oncheckpointtrigger, & leavecheckpointtrigger);
  }
}

function watchdeathtrigger() {
  while (true) {
    self waittill("trigger", player);
    if(isplayer(player)) {
      player faultdeath();
    }
  }
}

function add_current_run_to_high_scores(player) {
  active_track = level.frgame.activetrack;
  run_data = create_high_score_struct(get_current_track_time(player), level.frgame.faults, level.frgame.userspawns, level.frgame.bulletpenalty);
  push_score = 1;
  new_record = 0;
  if(active_track.highscores.size > 0) {
    for (i = 0; i < active_track.highscores.size; i++) {
      if(run_data.time < active_track.highscores[i].time || active_track.highscores[i].time == 0) {
        push_score = 0;
        arrayinsert(active_track.highscores, run_data, i);
        if(i == 0) {
          new_record = 1;
        }
        if(i < 3) {
          player write_high_scores_stats(i);
        }
        break;
      }
    }
  } else {
    new_record = 1;
  }
  if(push_score) {
    arrayinsert(active_track.highscores, run_data, active_track.highscores.size);
    player write_high_scores_stats(active_track.highscores.size - 1);
  }
  if(new_record) {
    player write_checkpoint_times();
  }
  return new_record;
}

function watchgoaltrigger() {
  level notify("watch_goal_trigger");
  level endon("watch_goal_trigger");
  self waittill("trigger", player);
  if(isplayer(player)) {
    player playsoundtoplayer("uin_freerun_finish", player);
    player take_all_player_weapons(1, 0);
    new_record = add_current_run_to_high_scores(player);
    trackscompleted = player getdstat("freerunTracksCompleted");
    if(trackscompleted < level.frgame.trackindex) {
      player setdstat("freerunTracksCompleted", level.frgame.trackindex);
    }
    player recordgameevent("completion");
    player.respawn_position = self.origin;
    player thread freeze();
    player thread freerunmusic(0);
    player updatehighscores();
    level clientfield::set("freerun_finishTime", get_current_track_time(player));
    level clientfield::set("freerun_state", 2);
    level notify("finished_track");
    if(player ishost()) {
      level notify("stop_tutorials");
      take_players_out_of_tutorial_mode();
      level.frgame.tutorials = 0;
      setlocalprofilevar("com_firsttime_freerun", 1);
      highest_track = getlocalprofileint("freerunHighestTrack");
      if(highest_track < level.frgame.trackindex) {
        setlocalprofilevar("freerunHighestTrack", level.frgame.trackindex);
      }
    }
    dumphighscores();
    wait(1.5);
    uploadstats();
    player uploadleaderboards();
    level clientfield::set("freerun_state", 5);
  }
}

function freeze() {
  self util::freeze_player_controls(1);
}

function unfreeze() {
  self util::freeze_player_controls(0);
}

function setup_weapon_targets() {
  target_name = self.weaponobject.visuals[0].target;
  if(!isdefined(target_name)) {
    return;
  }
  self.weaponobject.targetshottime = 0;
  self.weaponobject.targets = [];
  self.weaponobject.target_visuals = [];
  targets = getentarray(target_name, "targetname");
  foreach(target in targets) {
    if(target.script_noteworthy == "fr_target") {
      self.weaponobject.targets[self.weaponobject.targets.size] = target;
    }
    if(target.script_noteworthy == "fr_target_visual") {
      self.weaponobject.target_visuals[self.weaponobject.target_visuals.size] = target;
    }
  }
  foreach(target in self.weaponobject.targets) {
    foreach(visual in self.weaponobject.target_visuals) {
      if(target.origin == visual.origin) {
        target.visual = visual;
      }
    }
  }
  foreach(target in self.weaponobject.targets) {
    target.blocker = getent(target.target, "targetname");
    if(isdefined(target.blocker)) {
      if(!isdefined(target.blocker.targetcount)) {
        target.blocker.targetcount = 0;
        target.blocker.activetargetcount = 0;
      }
      target.blocker.targetcount++;
      target.blocker.activetargetcount++;
      target.checkpoint = self;
      target.disabled = 0;
      target thread watch_target_trigger_thread(self.weaponobject);
    }
  }
}

function watch_target_trigger_thread(weaponobject) {
  self endon("death");
  while (true) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags);
    if(level.frgame.activespawnpoint != self.checkpoint) {
      continue;
    }
    if(weapon == level.weaponbasemeleeheld) {
      continue;
    }
    if(self.disabled) {
      continue;
    }
    self turn_off_target(weapon);
    playfx(level.fr_target_impact_fx, point, direction_vec);
    weaponobject.targetshottime = gettime();
  }
}

function turn_off_target(weapon) {
  self.disabled = 1;
  self.visual ghost();
  self.visual notsolid();
  self.blocker blocker_disable();
  playfx(level.fr_target_disable_fx, self.origin);
  playsoundatposition(level.fr_target_disable_sound, self.origin);
}

function blocker_enable() {
  self.activetargetcount = self.targetcount;
  self.disabled = 0;
  self show();
  self solid();
}

function blocker_disable() {
  self.activetargetcount--;
  if(self.activetargetcount == 0) {
    self.disabled = 1;
    self ghost();
    self notsolid();
  }
}

function reset_targets() {
  foreach(target in self.targets) {
    target.blocker blocker_enable();
    target.visual show();
    target.visual solid();
    target.disabled = 0;
  }
}

function reset_all_targets() {
  foreach(trigger in level.frgame.checkpointtriggers) {
    if(isdefined(trigger.weaponobject)) {
      trigger.weaponobject reset_targets();
    }
  }
}

function dumphighscores() {
  for (i = 0; i < level.frgame.activetrack.highscores.size; i++) {
    println(((i + 1) + "") + level.frgame.activetrack.highscores[i].time);
    if(i == 0) {
      for (j = 0; j < level.frgame.activetrack.fastestruncheckpointtimes.size; j++) {
        println((("" + j) + "") + level.frgame.activetrack.fastestruncheckpointtimes[j]);
      }
    }
  }
}

function play_fault_vo() {
  current_time = gettime();
  fault_vo_interval = 20000;
  if((current_time - level.frgame.lastplayedfaultvotime) < fault_vo_interval) {
    return;
  }
  if(isdefined(self.lasttutorialvoplayed)) {
    return;
  }
  if(level.frgame.lastplayedfaultvocheckpoint == level.frgame.activespawnpoint.checkpointindex) {
    return;
  }
  level.frgame.lastplayedfaultvocheckpoint = level.frgame.activespawnpoint.checkpointindex;
  level.frgame.lastplayedfaultvotime = current_time;
  self playlocalsound("vox_tuto_tutorial_fail");
}

function faultdeath() {
  self play_fault_vo();
  level.frgame.faults++;
  self recordgameevent("fault");
  level clientfield::set("freerun_faults", level.frgame.faults);
  self playsoundtoplayer("uin_freerun_reset", self);
  self respawnatactivecheckpoint();
}

function dpad_up_pressed() {
  return self actionslotonebuttonpressed();
}

function dpad_down_pressed() {
  return self actionslottwobuttonpressed();
}

function dpad_right_pressed() {
  return self actionslotfourbuttonpressed();
}

function dpad_left_pressed() {
  return self actionslotthreebuttonpressed();
}

function end_game_state() {
  state = level clientfield::get("freerun_state");
  if(state == 2 || state == 4 || state == 5) {
    return true;
  }
  return false;
}

function watchtrackswitch() {
  track_count = level.frgame.tracks.size;
  while (true) {
    wait(0.05);
    switch_track = 0;
    if(end_game_state()) {
      continue;
    }
    if(self dpad_right_pressed() && track_count > 1) {
      switch_track = 1;
      curr_track_index = level.frgame.activetrackindex;
      curr_track_index++;
    } else if(self dpad_left_pressed() && track_count > 1) {
      switch_track = 1;
      curr_track_index = level.frgame.activetrackindex;
      curr_track_index--;
    }
    if(!switch_track && self dpad_up_pressed()) {
      switch_track = 1;
      curr_track_index = level.frgame.activetrackindex;
      self thread freerunmusic();
    }
    if(switch_track) {
      if(curr_track_index == 1) {
        curr_track_index = 0;
      } else if(curr_track_index < 0) {
        curr_track_index = 0;
      }
      self playsoundtoplayer("uin_freerun_reset", self);
      activatetrack(curr_track_index);
      while (true) {
        wait(0.05);
        if(!(self dpad_right_pressed() || self dpad_left_pressed() || self dpad_up_pressed())) {
          break;
        }
      }
    }
  }
}

function watchuserrespawn() {
  level endon("activate_track");
  level endon("finished_track");
  wasinnoclip = 0;
  while (true) {
    wait(0.05);
    if(end_game_state()) {
      continue;
    }
    if(self isinmovemode("")) {
      wasinnoclip = 1;
      continue;
    }
    if(wasinnoclip && self dpad_down_pressed()) {
      continue;
    }
    wasinnoclip = 0;
    if(self dpad_down_pressed()) {
      level.frgame.userspawns++;
      self recordgameevent("retry");
      level clientfield::set("freerun_retries", level.frgame.userspawns);
      self playsoundtoplayer("uin_freerun_reset", self);
      self respawnatactivecheckpoint();
      while (true) {
        wait(0.05);
        if(!self dpad_down_pressed()) {
          break;
        }
      }
    }
  }
}

function ignorebulletsfired(weapon) {
  if(!isdefined(level.frgame.activespawnpoint)) {
    return false;
  }
  if(!isdefined(level.frgame.activespawnpoint.weaponobject)) {
    return false;
  }
  grace_period = (weapon.firetime * 4) * 1000;
  if((level.frgame.activespawnpoint.weaponobject.targetshottime + grace_period) >= gettime()) {
    return true;
  }
  foreach(target in level.frgame.activespawnpoint.weaponobject.targets) {
    if(!target.disabled) {
      return false;
    }
  }
  return true;
}

function watchweaponfire() {
  self endon("disconnect");
  while (true) {
    self waittill("weapon_fired", weapon);
    if(weapon == level.weaponbasemeleeheld) {
      continue;
    }
    if(ignorebulletsfired(weapon)) {
      continue;
    }
    level.frgame.bulletpenalty++;
    level clientfield::set("freerun_bulletPenalty", level.frgame.bulletpenalty);
  }
}

function getgroundpointfororigin(position) {
  trace = bullettrace(position + vectorscale((0, 0, 1), 10), position - vectorscale((0, 0, 1), 1000), 0, undefined);
  return trace["position"];
}

function watchstartrun(player) {
  level endon("activate_track");
  self waittill("trigger", trigger_ent);
  if(trigger_ent == player) {
    player startrun();
  }
}

function respawnatactivecheckpoint() {
  resetglass();
  reset_all_targets();
  pickup_items::respawn_all_pickups();
  take_players_out_of_tutorial_mode();
  self playsoundtoplayer("evt_freerun_respawn", self);
  if(isdefined(self.respawn_position)) {
    self setorigin(self.respawn_position);
    self setvelocity((0, 0, 0));
  } else {
    if(isdefined(level.frgame.activespawnpoint.spawnpoint)) {
      self setorigin(level.frgame.activespawnpoint.spawnpoint.origin);
      self setplayerangles(level.frgame.activespawnpoint.spawnpoint.angles);
      self setvelocity((0, 0, 0));
    } else {
      spawn_origin = level.frgame.activespawnlocation;
      spawn_origin = spawn_origin + vectorscale((0, 0, 1), 5);
      self setorigin(spawn_origin);
      self setplayerangles(level.frgame.activespawnangles);
      self setvelocity((0, 0, 0));
    }
  }
  self setdoublejumpenergy(1);
  self take_all_player_weapons(1, 1);
}

function givecustomloadout() {
  self takeallweapons();
  self clearperks();
  self setperk("specialty_fallheight");
  self giveweapon(level.weaponbasemeleeheld);
  self setspawnweapon(level.weaponbasemeleeheld);
  return level.weaponbasemeleeheld;
}

function set_high_score_stat(trackindex, slot, stat, value) {
  self setdstat("freerunTrackTimes", "track", trackindex, "topTimes", slot, stat, value);
}

function write_high_scores_stats(start_index) {
  active_track = level.frgame.activetrack;
  self setdstat("freerunTrackTimes", "track", level.frgame.trackindex, "mapUniqueId", level.frgame.mapuniqueid);
  self setdstat("freerunTrackTimes", "track", level.frgame.trackindex, "mapVersion", level.frgame.mapversion);
  for (slot = start_index; slot < 3; slot++) {
    set_high_score_stat(level.frgame.trackindex, slot, "time", active_track.highscores[slot].time);
    set_high_score_stat(level.frgame.trackindex, slot, "faults", active_track.highscores[slot].faults);
    set_high_score_stat(level.frgame.trackindex, slot, "retries", active_track.highscores[slot].retries);
    set_high_score_stat(level.frgame.trackindex, slot, "bulletPenalty", active_track.highscores[slot].bulletpenalty);
  }
}

function write_checkpoint_times() {
  level.frgame.activetrack.fastestruncheckpointtimes = level.frgame.checkpointtimes;
  for (i = 0; i < level.frgame.checkpointtriggers.size; i++) {
    self setdstat("freerunTrackTimes", "track", level.frgame.trackindex, "checkPointTimes", "time", i, level.frgame.checkpointtimes[i]);
  }
}

function get_high_score_stat(trackindex, slot, stat) {
  return self getdstat("freerunTrackTimes", "track", trackindex, "topTimes", slot, stat);
}

function create_high_score_struct(time, faults, retries, bulletpenalty) {
  score_set = spawnstruct();
  score_set.time = time;
  score_set.faults = faults;
  score_set.retries = retries;
  score_set.bulletpenalty = bulletpenalty;
  return score_set;
}

function get_stats_for_track(trackindex, slot) {
  time = self get_high_score_stat(trackindex, slot, "time");
  faults = self get_high_score_stat(trackindex, slot, "faults");
  retries = self get_high_score_stat(trackindex, slot, "retries");
  bulletpenalty = self get_high_score_stat(trackindex, slot, "bulletPenalty");
  return create_high_score_struct(time, faults, retries, bulletpenalty);
}

function get_checkpoint_times_for_track(trackindex) {
  for (i = 0; i < level.frgame.checkpointtriggers.size; i++) {
    level.frgame.activetrack.fastestruncheckpointtimes[i] = self getdstat("freerunTrackTimes", "track", trackindex, "checkPointTimes", "time", i);
  }
}

function get_top_scores_stats() {
  if(isdefined(level.frgame.activetrack.statsread)) {
    return;
  }
  mapid = self getdstat("freerunTrackTimes", "track", level.frgame.trackindex, "mapUniqueId");
  mapversion = self getdstat("freerunTrackTimes", "track", level.frgame.trackindex, "mapVersion");
  if(level.frgame.mapuniqueid != mapid || level.frgame.mapversion != mapversion) {
    for (i = 0; i < 3; i++) {
      level.frgame.activetrack.highscores[i] = create_high_score_struct(0, 0, 0, 0);
    }
    for (i = 0; i < level.frgame.checkpointtriggers.size; i++) {
      level.frgame.activetrack.fastestruncheckpointtimes[i] = 0;
    }
  } else {
    for (i = 0; i < 3; i++) {
      level.frgame.activetrack.highscores[i] = get_stats_for_track(level.frgame.trackindex, i);
    }
    get_checkpoint_times_for_track(level.frgame.trackindex);
  }
  level.frgame.activetrack.statsread = 1;
}

function take_all_player_weapons(only_default, immediate) {
  self endon("disconnect");
  self endon("death");
  keep_weapon = level.weaponnone;
  if(isdefined(level.frgame.activespawnpoint.weapon) && !only_default) {
    keep_weapon = level.frgame.activespawnpoint.weapon;
  }
  if(immediate) {
    self switchtoweaponimmediate(level.weaponbasemeleeheld);
  } else {
    while (self isswitchingweapons()) {
      wait(0.05);
    }
    current_weapon = self getcurrentweapon();
    if(current_weapon != level.weaponbasemeleeheld && keep_weapon != current_weapon) {
      self switchtoweapon(level.weaponbasemeleeheld);
      while (self getcurrentweapon() != level.weaponbasemeleeheld) {
        wait(0.05);
      }
    }
  }
  weaponslist = self getweaponslist();
  foreach(weapon in weaponslist) {
    if(weapon != level.weaponbasemeleeheld && keep_weapon != weapon) {
      self takeweapon(weapon);
    }
  }
}

function freerunmusic(start = 1) {
  player = self;
  if(start && (!(isdefined(player.musicstart) && player.musicstart))) {
    mapname = getdvarstring("mapname");
    player globallogic_audio::set_music_on_player(mapname);
    player.musicstart = 1;
  } else if(!start) {
    player globallogic_audio::set_music_on_player("mp_freerun_finish");
    player.musicstart = 0;
  }
}

function _tutorial_mode(b_tutorial_mode) {}

function take_players_out_of_tutorial_mode() {
  if(level.frgame.tutorials) {
    foreach(player in level.players) {
      player _tutorial_mode(0);
    }
  }
}

function put_players_in_tutorial_mode() {
  if(level.frgame.tutorials) {
    foreach(player in level.players) {
      player _tutorial_mode(1);
    }
  }
}

function enable_all_tutorial_triggers() {
  if(level.frgame.tutorials) {
    foreach(trigger in level.frgame.tutorialtriggers) {
      trigger triggerenable(1);
    }
  }
}

function activate_tutorial_mode() {
  if(!self ishost() || getlocalprofileint("com_firsttime_freerun") && !getdvarint("freerun_tutorial")) {
    return;
  }
  level.frgame.tutorials = 1;
  wait(1);
  foreach(trigger in level.frgame.tutorialtriggers) {
    trigger thread watchtutorialtrigger();
  }
}

function setup_tutorial() {
  level.frgame.tutorials = 0;
  level.frgame.tutorialtriggers = getentarray("fr_tutorial", "targetname");
  level.frgame.tutorialfunctions = [];
  register_tutorials();
}

function watchtutorialtrigger() {
  level endon("stop_tutorials");
  while (true) {
    self waittill("trigger", player);
    if(isplayer(player)) {
      player thread start_tutorial(self.script_noteworthy);
      self triggerenable(0);
    }
  }
}

function stop_tutorial_when_restarting_track() {
  self notify("stop_tutorial_when_restarting_track");
  self waittill("stop_tutorial_when_restarting_track");
  level waittill("activate_track");
  take_players_out_of_tutorial_mode();
  self util::hide_hint_text(0);
  self stop_tutorial_vo();
  self stopsounds();
}

function start_tutorial(tutorial) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  level endon("activate_track");
  if(!isdefined(level.frgame.tutorialfunctions[tutorial])) {
    return;
  }
  level notify("playing_tutorial");
  level endon("playing_tutorial");
  self thread stop_tutorial_when_restarting_track();
  put_players_in_tutorial_mode();
  wait(0.5);
  [[level.frgame.tutorialfunctions[tutorial]]]();
  take_players_out_of_tutorial_mode();
}

function stop_tutorial_vo() {
  if(isdefined(self.lasttutorialvoplayed)) {
    self stopsound(self.lasttutorialvoplayed);
    self.lasttutorialvoplayed = undefined;
  }
}

function play_tutorial_vo(aliasstring) {
  self stop_tutorial_vo();
  self.lasttutorialvoplayed = aliasstring;
  self playsoundwithnotify(aliasstring, "sounddone");
  self waittill("sounddone");
  wait(1);
}

function play_tutorial_vo_with_hint(aliasstring, text) {
  self stop_tutorial_vo();
  self thread _show_tutorial_hint_with_vo(text);
  self.lasttutorialvoplayed = aliasstring;
  self playsoundwithnotify(aliasstring, "sounddone");
  self waittill("sounddone");
  wait(1);
}

function _show_tutorial_hint_with_vo(text, time, unlock_player) {
  wait(0.5);
  show_tutorial_hint(text, time, unlock_player);
}

function show_tutorial_hint(text, time, unlock_player) {
  if(isdefined(unlock_player)) {
    take_players_out_of_tutorial_mode();
  }
  if(!isdefined(time)) {
    time = 4;
  }
  self util::show_hint_text(text, 0, "activate_track", 4);
  wait(4.5);
}

function show_tutorial_hint_with_full_movement(text, time) {
  show_tutorial_hint(text, time, 1);
}

function register_tutorials() {
  level.frgame.tutorialfunctions["tutorial_01"] = & tutorial_01;
  level.frgame.tutorialfunctions["tutorial_02"] = & tutorial_02;
  level.frgame.tutorialfunctions["tutorial_03"] = & tutorial_03;
  level.frgame.tutorialfunctions["tutorial_06"] = & tutorial_06;
  level.frgame.tutorialfunctions["tutorial_08"] = & tutorial_08;
  level.frgame.tutorialfunctions["tutorial_09"] = & tutorial_09;
  level.frgame.tutorialfunctions["tutorial_10"] = & tutorial_10;
  level.frgame.tutorialfunctions["tutorial_10a"] = & tutorial_10a;
  level.frgame.tutorialfunctions["tutorial_12"] = & tutorial_12;
  level.frgame.tutorialfunctions["tutorial_12a"] = & tutorial_12a;
  level.frgame.tutorialfunctions["tutorial_13"] = & tutorial_13;
  level.frgame.tutorialfunctions["tutorial_14"] = & tutorial_14;
  level.frgame.tutorialfunctions["tutorial_15"] = & tutorial_15;
  level.frgame.tutorialfunctions["tutorial_16"] = & tutorial_16;
  level.frgame.tutorialfunctions["tutorial_17"] = & tutorial_17;
  level.frgame.tutorialfunctions["tutorial_17a"] = & tutorial_17a;
  level.frgame.tutorialfunctions["tutorial_18"] = & tutorial_18;
  level.frgame.tutorialfunctions["tutorial_19"] = & tutorial_19;
  level.frgame.tutorialfunctions["tutorial_20"] = & tutorial_20;
}

function tutorial_01() {
  self play_tutorial_vo("vox_tuto_tutorial_sequence_1");
  self play_tutorial_vo("vox_tuto_tutorial_sequence_2");
  self play_tutorial_vo("vox_tuto_tutorial_sequence_6");
}

function tutorial_02() {
  self show_tutorial_hint_with_full_movement(&"FREERUN_TUTORIAL_02");
}

function tutorial_03() {
  self show_tutorial_hint_with_full_movement(&"FREERUN_TUTORIAL_03");
}

function tutorial_06() {
  self thread play_tutorial_vo("vox_tuto_tutorial_sequence_11");
  self show_tutorial_hint_with_full_movement(&"FREERUN_TUTORIAL_09");
}

function tutorial_08() {
  self show_tutorial_hint_with_full_movement(&"FREERUN_TUTORIAL_11");
}

function tutorial_09() {
  self play_tutorial_vo_with_hint("vox_tuto_tutorial_sequence_28", & "FREERUN_TUTORIAL_12");
}

function tutorial_10() {
  self play_tutorial_vo("vox_tuto_tutorial_sequence_10");
}

function tutorial_10a() {
  self show_tutorial_hint_with_full_movement(&"FREERUN_TUTORIAL_13");
}

function tutorial_12() {
  self play_tutorial_vo("vox_tuto_tutorial_sequence_16");
}

function tutorial_12a() {
  self show_tutorial_hint_with_full_movement(&"FREERUN_TUTORIAL_14");
}

function tutorial_13() {
  self play_tutorial_vo_with_hint("vox_tuto_tutorial_sequence_17", & "FREERUN_TUTORIAL_14a");
  self play_tutorial_vo("vox_tuto_tutorial_sequence_18");
  self show_tutorial_hint_with_full_movement(&"FREERUN_TUTORIAL_16");
}

function tutorial_14() {
  self play_tutorial_vo("vox_tuto_tutorial_sequence_19");
  self show_tutorial_hint_with_full_movement(&"FREERUN_TUTORIAL_18");
}

function tutorial_15() {
  self play_tutorial_vo("vox_tuto_tutorial_sequence_20");
}

function tutorial_16() {
  self play_tutorial_vo("vox_tuto_tutorial_sequence_29");
}

function tutorial_17() {
  self play_tutorial_vo("vox_tuto_tutorial_sequence_21");
}

function tutorial_17a() {
  self show_tutorial_hint_with_full_movement(&"FREERUN_TUTORIAL_22");
}

function tutorial_18() {
  self play_tutorial_vo_with_hint("vox_tuto_tutorial_sequence_23", & "FREERUN_TUTORIAL_23");
  self show_tutorial_hint_with_full_movement(&"FREERUN_TUTORIAL_22a");
}

function tutorial_19() {
  self play_tutorial_vo("vox_tuto_tutorial_sequence_25");
}

function tutorial_20() {
  self play_tutorial_vo("vox_tuto_tutorial_sequence_26");
}