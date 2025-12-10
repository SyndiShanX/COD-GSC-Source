/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\audio_shared.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\music_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#namespace audio;

function autoexec __init__sytem__() {
  system::register("audio", &__init__, undefined, undefined);
}

function __init__() {
  snd_snapshot_init();
  callback::on_localclient_connect(&player_init);
  callback::on_localplayer_spawned(&local_player_spawn);
  level thread register_clientfields();
  level thread sndkillcam();
  level thread setpfxcontext();
  setsoundcontext("foley", "normal");
  setsoundcontext("plr_impact", "");
}

function register_clientfields() {
  clientfield::register("world", "sndMatchSnapshot", 1, 2, "int", &sndmatchsnapshot, 1, 0);
  clientfield::register("world", "sndFoleyContext", 1, 1, "int", &sndfoleycontext, 0, 0);
  clientfield::register("scriptmover", "sndRattle", 1, 1, "int", &sndrattle_server, 1, 0);
  clientfield::register("toplayer", "sndMelee", 1, 1, "int", &weapon_butt_sounds, 1, 1);
  clientfield::register("vehicle", "sndSwitchVehicleContext", 1, 3, "int", &sndswitchvehiclecontext, 0, 0);
  clientfield::register("toplayer", "sndCCHacking", 1, 2, "int", &sndcchacking, 1, 1);
  clientfield::register("toplayer", "sndTacRig", 1, 1, "int", &sndtacrig, 0, 1);
  clientfield::register("toplayer", "sndLevelStartSnapOff", 1, 1, "int", &sndlevelstartsnapoff, 0, 1);
  clientfield::register("world", "sndIGCsnapshot", 1, 4, "int", &sndigcsnapshot, 1, 0);
  clientfield::register("world", "sndChyronLoop", 1, 1, "int", &sndchyronloop, 0, 0);
  clientfield::register("world", "sndZMBFadeIn", 1, 1, "int", &sndzmbfadein, 1, 0);
}

function local_player_spawn(localclientnum) {
  if(self != getlocalplayer(localclientnum)) {
    return;
  }
  setsoundcontext("foley", "normal");
  if(!sessionmodeismultiplayergame()) {
    if(isDefined(level._lastmusicstate)) {
      soundsetmusicstate(level._lastmusicstate);
    }
    self thread sndmusicdeathwatcher();
  }
  self thread isplayerinfected();
  self thread snd_underwater(localclientnum);
  self thread clientvoicesetup(localclientnum);
}

function player_init(localclientnum) {
  if(issplitscreenhost(localclientnum)) {
    level thread bump_trigger_start(localclientnum);
    level thread init_audio_triggers(localclientnum);
    level thread sndrattle_grenade_client();
    startsoundrandoms(localclientnum);
    startsoundloops();
    startlineemitters();
    startrattles();
  }
}

function snddoublejump_watcher() {
  self endon("entityshutdown");
  while(true) {
    self waittill("doublejump_start");
    trace = tracepoint(self.origin, self.origin - vectorscale((0, 0, 1), 100000));
    trace_surface_type = trace["surfacetype"];
    trace_origin = trace["position"];
    if(!isDefined(trace) || !isDefined(trace_origin)) {
      continue;
    }
    if(!isDefined(trace_surface_type)) {
      trace_surface_type = "default";
    }
    playSound(0, "veh_jetpack_surface_" + trace_surface_type, trace_origin);
  }
}

function clientvoicesetup(localclientnum) {
  self endon("entityshutdown");
  if(isDefined(level.clientvoicesetup)) {
    [[level.clientvoicesetup]](localclientnum);
    return;
  }
  self.teamclientprefix = "vox_gen";
  self thread sndvonotify("playerbreathinsound", "sinper_hold");
  self thread sndvonotify("playerbreathoutsound", "sinper_exhale");
  self thread sndvonotify("playerbreathgaspsound", "sinper_gasp");
}

function sndvonotify(notifystring, dialog) {
  self endon("entityshutdown");
  for(;;) {
    self waittill(notifystring);
    soundalias = (self.teamclientprefix + "_") + dialog;
    self playSound(0, soundalias);
  }
}

function snd_snapshot_init() {
  level._sndactivesnapshot = "default";
  level._sndnextsnapshot = "default";
  mapname = getdvarstring("mapname");
  if(mapname !== "core_frontend") {
    if(sessionmodeiscampaigngame()) {
      level._sndactivesnapshot = "cmn_level_start";
      level._sndnextsnapshot = "cmn_level_start";
    }
    if(sessionmodeiszombiesgame()) {
      if(mapname !== "zm_cosmodrome" && mapname !== "zm_prototype" && mapname !== "zm_moon" && mapname !== "zm_sumpf" && mapname !== "zm_asylum" && mapname !== "zm_temple" && mapname !== "zm_theater" && mapname !== "zm_tomb") {
        level._sndactivesnapshot = "zmb_game_start_nofade";
        level._sndnextsnapshot = "zmb_game_start_nofade";
      } else {
        level._sndactivesnapshot = "zmb_hd_game_start_nofade";
        level._sndnextsnapshot = "zmb_hd_game_start_nofade";
      }
    }
  }
  setgroupsnapshot(level._sndactivesnapshot);
  thread snd_snapshot_think();
}

function sndonwait() {
  level endon("sndonoverride");
  level util::waittill_any_timeout(20, "sndOn", "sndOnOverride");
}

function snd_set_snapshot(state) {
  level._sndnextsnapshot = state;
  println(("" + state) + "");
  level notify("new_bus");
}

function snd_snapshot_think() {
  for(;;) {
    if(level._sndactivesnapshot == level._sndnextsnapshot) {
      level waittill("new_bus");
    }
    if(level._sndactivesnapshot == level._sndnextsnapshot) {
      continue;
    }
    assert(isDefined(level._sndnextsnapshot));
    assert(isDefined(level._sndactivesnapshot));
    setgroupsnapshot(level._sndnextsnapshot);
    level._sndactivesnapshot = level._sndnextsnapshot;
  }
}

function soundrandom_thread(localclientnum, randsound) {
  if(!isDefined(randsound.script_wait_min)) {
    randsound.script_wait_min = 1;
  }
  if(!isDefined(randsound.script_wait_max)) {
    randsound.script_wait_max = 3;
  }
  notify_name = undefined;
  if(isDefined(randsound.script_string)) {
    notify_name = randsound.script_string;
  }
  if(!isDefined(notify_name) && isDefined(randsound.script_sound)) {
    createsoundrandom(randsound.origin, randsound.script_sound, randsound.script_wait_min, randsound.script_wait_max);
    return;
  }
  randsound.playing = 1;
  level thread soundrandom_notifywait(notify_name, randsound);
  while(true) {
    wait(randomfloatrange(randsound.script_wait_min, randsound.script_wait_max));
    if(isDefined(randsound.script_sound) && (isDefined(randsound.playing) && randsound.playing)) {
      playSound(localclientnum, randsound.script_sound, randsound.origin);
    }
    if(getdvarint("") > 0) {
      print3d(randsound.origin, randsound.script_sound, vectorscale((0, 1, 0), 0.8), 1, 3, 45);
    }
  }
}

function soundrandom_notifywait(notify_name, randsound) {
  while(true) {
    level waittill(notify_name);
    if(isDefined(randsound.playing) && randsound.playing) {
      randsound.playing = 0;
    } else {
      randsound.playing = 1;
    }
  }
}

function startsoundrandoms(localclientnum) {
  randoms = struct::get_array("random", "script_label");
  if(isDefined(randoms) && randoms.size > 0) {
    nscriptthreadedrandoms = 0;
    for(i = 0; i < randoms.size; i++) {
      if(isDefined(randoms[i].script_scripted)) {
        nscriptthreadedrandoms++;
      }
    }
    allocatesoundrandoms(randoms.size - nscriptthreadedrandoms);
    for(i = 0; i < randoms.size; i++) {
      thread soundrandom_thread(localclientnum, randoms[i]);
    }
  }
}

function soundloopthink() {
  if(!isDefined(self.script_sound)) {
    return;
  }
  if(!isDefined(self.origin)) {
    return;
  }
  notifyname = "";
  assert(isDefined(notifyname));
  if(isDefined(self.script_string)) {
    notifyname = self.script_string;
  }
  assert(isDefined(notifyname));
  started = 1;
  if(isDefined(self.script_int)) {
    started = self.script_int != 0;
  }
  if(started) {
    soundloopemitter(self.script_sound, self.origin);
  }
  if(notifyname != "") {
    for(;;) {
      level waittill(notifyname);
      if(started) {
        soundstoploopemitter(self.script_sound, self.origin);
        self thread soundloopcheckpointrestore();
      } else {
        soundloopemitter(self.script_sound, self.origin);
      }
      started = !started;
    }
  }
}

function soundloopcheckpointrestore() {
  level waittill("save_restore");
  soundloopemitter(self.script_sound, self.origin);
}

function soundlinethink() {
  if(!isDefined(self.target)) {
    return;
  }
  target = struct::get(self.target, "targetname");
  if(!isDefined(target)) {
    return;
  }
  notifyname = "";
  if(isDefined(self.script_string)) {
    notifyname = self.script_string;
  }
  started = 1;
  if(isDefined(self.script_int)) {
    started = self.script_int != 0;
  }
  if(started) {
    soundlineemitter(self.script_sound, self.origin, target.origin);
  }
  if(notifyname != "") {
    for(;;) {
      level waittill(notifyname);
      if(started) {
        soundstoplineemitter(self.script_sound, self.origin, target.origin);
        self thread soundlinecheckpointrestore(target);
      } else {
        soundlineemitter(self.script_sound, self.origin, target.origin);
      }
      started = !started;
    }
  }
}

function soundlinecheckpointrestore(target) {
  level waittill("save_restore");
  soundlineemitter(self.script_sound, self.origin, target.origin);
}

function startsoundloops() {
  loopers = struct::get_array("looper", "script_label");
  if(isDefined(loopers) && loopers.size > 0) {
    delay = 0;
    if(getdvarint("") > 0) {
      println(("" + loopers.size) + "");
    }
    for(i = 0; i < loopers.size; i++) {
      loopers[i] thread soundloopthink();
      delay = delay + 1;
      if((delay % 20) == 0) {
        wait(0.016);
      }
    }
  } else {
    println("");
    if(getdvarint("") > 0) {}
  }
}

function startlineemitters() {
  lineemitters = struct::get_array("line_emitter", "script_label");
  if(isDefined(lineemitters) && lineemitters.size > 0) {
    delay = 0;
    if(getdvarint("") > 0) {
      println(("" + lineemitters.size) + "");
    }
    for(i = 0; i < lineemitters.size; i++) {
      lineemitters[i] thread soundlinethink();
      delay = delay + 1;
      if((delay % 20) == 0) {
        wait(0.016);
      }
    }
  } else {
    println("");
    if(getdvarint("") > 0) {}
  }
}

function startrattles() {
  rattles = struct::get_array("sound_rattle", "script_label");
  if(isDefined(rattles)) {
    println(("" + rattles.size) + "");
    delay = 0;
    for(i = 0; i < rattles.size; i++) {
      soundrattlesetup(rattles[i].script_sound, rattles[i].origin);
      delay = delay + 1;
      if((delay % 20) == 0) {
        wait(0.016);
      }
    }
  }
}

function init_audio_triggers(localclientnum) {
  util::waitforclient(localclientnum);
  steptrigs = getEntArray(localclientnum, "audio_step_trigger", "targetname");
  materialtrigs = getEntArray(localclientnum, "audio_material_trigger", "targetname");
  if(getdvarint("") > 0) {
    println(("" + steptrigs.size) + "");
    println(("" + materialtrigs.size) + "");
  }
  array::thread_all(steptrigs, &audio_step_trigger, localclientnum);
  array::thread_all(materialtrigs, &audio_material_trigger, localclientnum);
}

function audio_step_trigger(localclientnum) {
  self._localclientnum = localclientnum;
  for(;;) {
    self waittill("trigger", trigplayer);
    self thread trigger::function_d1278be0(trigplayer, &trig_enter_audio_step_trigger, &trig_leave_audio_step_trigger);
  }
}

function audio_material_trigger(trig) {
  for(;;) {
    self waittill("trigger", trigplayer);
    self thread trigger::function_d1278be0(trigplayer, &trig_enter_audio_material_trigger, &trig_leave_audio_material_trigger);
  }
}

function trig_enter_audio_material_trigger(player) {
  if(!isDefined(player.inmaterialoverridetrigger)) {
    player.inmaterialoverridetrigger = 0;
  }
  if(isDefined(self.script_label)) {
    player.inmaterialoverridetrigger++;
    player.audiomaterialoverride = self.script_label;
    player setmaterialoverride(self.script_label);
  }
}

function trig_leave_audio_material_trigger(player) {
  if(isDefined(self.script_label)) {
    player.inmaterialoverridetrigger--;
    /
    #
    assert(player.inmaterialoverridetrigger >= 0);
    if(player.inmaterialoverridetrigger <= 0) {
      player.audiomaterialoverride = undefined;
      player.inmaterialoverridetrigger = 0;
      player clearmaterialoverride();
    }
  }
}

function trig_enter_audio_step_trigger(trigplayer) {
  localclientnum = self._localclientnum;
  if(!isDefined(trigplayer.insteptrigger)) {
    trigplayer.insteptrigger = 0;
  }
  suffix = "_npc";
  if(trigplayer islocalplayer()) {
    suffix = "_plr";
  }
  if(isDefined(self.script_label)) {
    trigplayer.step_sound = self.script_label;
    trigplayer.insteptrigger = trigplayer.insteptrigger + 1;
    trigplayer setsteptriggersound(self.script_label + suffix);
  }
  if(isDefined(self.script_sound) && trigplayer getmovementtype() == "sprint") {
    volume = get_vol_from_speed(trigplayer);
    trigplayer playSound(localclientnum, self.script_sound + suffix, self.origin, volume);
  }
}

function trig_leave_audio_step_trigger(trigplayer) {
  localclientnum = self._localclientnum;
  suffix = "_npc";
  if(trigplayer islocalplayer()) {
    suffix = "_plr";
  }
  if(isDefined(self.script_noteworthy) && trigplayer getmovementtype() == "sprint") {
    volume = get_vol_from_speed(trigplayer);
    trigplayer playSound(localclientnum, self.script_noteworthy + suffix, self.origin, volume);
  }
  if(isDefined(self.script_label)) {
    trigplayer.insteptrigger = trigplayer.insteptrigger - 1;
  }
  if(trigplayer.insteptrigger < 0) {
    println("");
    trigplayer.insteptrigger = 0;
  }
  if(trigplayer.insteptrigger == 0) {
    trigplayer.step_sound = "none";
    trigplayer clearsteptriggersound();
  }
}

function bump_trigger_start(localclientnum) {
  bump_trigs = getEntArray(localclientnum, "audio_bump_trigger", "targetname");
  for(i = 0; i < bump_trigs.size; i++) {
    bump_trigs[i] thread thread_bump_trigger(localclientnum);
  }
}

function thread_bump_trigger(localclientnum) {
  self thread bump_trigger_listener();
  if(!isDefined(self.script_activated)) {
    self.script_activated = 1;
  }
  self._localclientnum = localclientnum;
  for(;;) {
    self waittill("trigger", trigplayer);
    self thread trigger::function_d1278be0(trigplayer, &trig_enter_bump, &trig_leave_bump);
  }
}

function trig_enter_bump(ent) {
  if(!isDefined(ent)) {
    return;
  }
  localclientnum = self._localclientnum;
  volume = get_vol_from_speed(ent);
  if(!sessionmodeiszombiesgame()) {
    if(ent isplayer() && ent hasperk(localclientnum, "specialty_quieter")) {
      volume = volume / 2;
    }
  }
  if(isDefined(self.script_sound) && self.script_activated) {
    if(isDefined(self.script_noteworthy) && self.script_wait > volume) {
      test_id = ent playSound(localclientnum, self.script_noteworthy, self.origin, volume);
    }
    if(isDefined(self.script_parameters)) {
      test_id = ent playSound(localclientnum, self.script_parameters, self.origin, volume);
    }
    if(!isDefined(self.script_wait) || self.script_wait <= volume) {
      test_id = ent playSound(localclientnum, self.script_sound, self.origin, volume);
    }
  }
  if(isDefined(self.script_location) && self.script_activated) {
    ent thread mantle_wait(self.script_location, localclientnum);
  }
}

function mantle_wait(alias, localclientnum) {
  self endon("death");
  self endon("left_mantle");
  self waittill("traversesound");
  self playSound(localclientnum, alias, self.origin, 1);
}

function trig_leave_bump(ent) {
  wait(1);
  ent notify("left_mantle");
}

function bump_trigger_listener() {
  if(isDefined(self.script_label)) {
    level waittill(self.script_label);
    self.script_activated = 0;
  }
}

function scale_speed(x1, x2, y1, y2, z) {
  if(z < x1) {
    z = x1;
  }
  if(z > x2) {
    z = x2;
  }
  dx = x2 - x1;
  n = (z - x1) / dx;
  dy = y2 - y1;
  w = (n * dy) + y1;
  return w;
}

function get_vol_from_speed(player) {
  min_speed = 21;
  max_speed = 285;
  max_vol = 1;
  min_vol = 0.1;
  speed = player getspeed();
  abs_speed = absolute_value(int(speed));
  volume = scale_speed(min_speed, max_speed, min_vol, max_vol, abs_speed);
  return volume;
}

function absolute_value(fowd) {
  if(fowd < 0) {
    return fowd * -1;
  }
  return fowd;
}

function closest_point_on_line_to_point(point, linestart, lineend) {
  self endon("hash_18e2bbbb");
  linemagsqrd = lengthsquared(lineend - linestart);
  t = (point[0] - linestart[0]) * (lineend[0] - linestart[0]) + (point[1] - linestart[1]) * (lineend[1] - linestart[1]) + (point[2] - linestart[2]) * (lineend[2] - linestart[2]) / linemagsqrd;
  if(t < 0) {
    self.origin = linestart;
  } else {
    if(t > 1) {
      self.origin = lineend;
    } else {
      start_x = linestart[0] + (t * (lineend[0] - linestart[0]));
      start_y = linestart[1] + (t * (lineend[1] - linestart[1]));
      start_z = linestart[2] + (t * (lineend[2] - linestart[2]));
      self.origin = (start_x, start_y, start_z);
    }
  }
}

function snd_play_auto_fx(fxid, alias, offsetx, offsety, offsetz, onground, area, threshold, alias_override) {
  soundplayautofx(fxid, alias, offsetx, offsety, offsetz, onground, area, threshold, alias_override);
}

function snd_print_fx_id(fxid, type, ent) {
  if(getdvarint("") > 0) {
    println((("" + fxid) + "") + type);
  }
}

function debug_line_emitter() {
  while(true) {
    if(getdvarint("") > 0) {
      line(self.start, self.end, (0, 1, 0));
      print3d(self.start, "", vectorscale((0, 1, 0), 0.8), 1, 3, 1);
      print3d(self.end, "", vectorscale((0, 1, 0), 0.8), 1, 3, 1);
      print3d(self.origin, self.script_sound, vectorscale((0, 1, 0), 0.8), 1, 3, 1);
    }
    wait(0.016);
  }
}

function move_sound_along_line() {
  closest_dist = undefined;
  self thread debug_line_emitter();
  while(true) {
    self closest_point_on_line_to_point(getlocalclientpos(0), self.start, self.end);
    if(isDefined(self.fake_ent)) {
      self.fake_ent.origin = self.origin;
    }
    closest_dist = distancesquared(getlocalclientpos(0), self.origin);
    if(closest_dist > 1048576) {
      wait(2);
    } else {
      if(closest_dist > 262144) {
        wait(0.2);
      } else {
        wait(0.05);
      }
    }
  }
}

function playloopat(aliasname, origin) {
  soundloopemitter(aliasname, origin);
}

function stoploopat(aliasname, origin) {
  soundstoploopemitter(aliasname, origin);
}

function soundwait(id) {
  while(soundplaying(id)) {
    wait(0.1);
  }
}

function snd_underwater(localclientnum) {
  level endon("demo_jump");
  self endon("entityshutdown");
  level endon("killcam_begin" + localclientnum);
  level endon("killcam_end" + localclientnum);
  self endon("sndenduwwatcher");
  if(!isDefined(level.audiosharedswimming)) {
    level.audiosharedswimming = 0;
  }
  if(!isDefined(level.audiosharedunderwater)) {
    level.audiosharedunderwater = 0;
  }
  if(level.audiosharedswimming != isswimming(localclientnum)) {
    level.audiosharedswimming = isswimming(localclientnum);
    if(level.audiosharedswimming) {
      swimbegin();
    } else {
      swimcancel(localclientnum);
    }
  }
  if(level.audiosharedunderwater != isunderwater(localclientnum)) {
    level.audiosharedunderwater = isunderwater(localclientnum);
    if(level.audiosharedunderwater) {
      self underwaterbegin();
    } else {
      self underwaterend();
    }
  }
  while(true) {
    underwaternotify = self util::waittill_any_ex("underwater_begin", "underwater_end", "swimming_begin", "swimming_end", "death", "entityshutdown", "sndEndUWWatcher", level, "demo_jump", "killcam_begin" + localclientnum, "killcam_end" + localclientnum);
    if(underwaternotify == "death") {
      self underwaterend();
      self swimend(localclientnum);
    }
    if(underwaternotify == "underwater_begin") {
      self underwaterbegin();
    } else {
      if(underwaternotify == "underwater_end") {
        self underwaterend();
      } else {
        if(underwaternotify == "swimming_begin") {
          self swimbegin();
        } else if(underwaternotify == "swimming_end" && self isplayer() && isalive(self)) {
          self swimend(localclientnum);
        }
      }
    }
  }
}

function underwaterbegin() {
  level.audiosharedunderwater = 1;
}

function underwaterend() {
  level.audiosharedunderwater = 0;
}

function setpfxcontext() {
  level waittill("pfx_igc_on");
  setsoundcontext("igc", "on");
  level waittill("pfx_igc_off");
  setsoundcontext("igc", "");
  return;
}

function swimbegin() {
  self.audiosharedswimming = 1;
}

function swimend(localclientnum) {
  self.audiosharedswimming = 0;
}

function swimcancel(localclientnum) {
  self.audiosharedswimming = 0;
}

function soundplayuidecodeloop(decodestring, playtimems) {
  if(!isDefined(level.playinguidecodeloop) || !level.playinguidecodeloop) {
    level.playinguidecodeloop = 1;
    fake_ent = spawn(0, (0, 0, 0), "script_origin");
    if(isDefined(fake_ent)) {
      fake_ent playLoopSound("uin_notify_data_loop");
      wait(playtimems / 1000);
      fake_ent stopallloopsounds(0);
    }
    level.playinguidecodeloop = undefined;
  }
}

function setcurrentambientstate(ambientroom, ambientpackage, roomcollidercent, packagecollidercent, defaultroom) {
  if(isDefined(level._sndambientstatecallback)) {
    level thread[[level._sndambientstatecallback]](ambientroom, ambientpackage, roomcollidercent);
  }
}

function isplayerinfected() {
  self endon("entityshutdown");
  mapname = getdvarstring("mapname");
  if(!isDefined(mapname)) {
    mapname = "cp_mi_eth_prologue";
  }
  if(isDefined(self)) {
    switch (mapname) {
      case "cp_mi_eth_prologue": {
        self.isinfected = 0;
        setsoundcontext("healthstate", "human");
        break;
      }
      case "cp_mi_cairo_infection2": {
        self.isinfected = 1;
        setsoundcontext("healthstate", "infected");
        break;
      }
      case "cp_mi_cairo_infection3": {
        self.isinfected = 1;
        setsoundcontext("healthstate", "infected");
        break;
      }
      case "cp_mi_cairo_aquifer": {
        self.isinfected = 1;
        setsoundcontext("healthstate", "infected");
        break;
      }
      case "cp_mi_cairo_lotus": {
        self.isinfected = 1;
        setsoundcontext("healthstate", "infected");
        break;
      }
      case "cp_mi_cairo_lotus2": {
        self.isinfected = 1;
        setsoundcontext("healthstate", "infected");
        break;
      }
      case "cp_mi_cairo_lotus3": {
        self.isinfected = 1;
        setsoundcontext("healthstate", "infected");
        break;
      }
      case "cp_mi_zurich_coalescence": {
        self.isinfected = 1;
        setsoundcontext("healthstate", "infected");
        break;
      }
      case "zm_zod": {
        self.isinfected = 0;
        setsoundcontext("healthstate", "human");
        break;
      }
      case "zm_factory": {
        self.isinfected = 0;
        setsoundcontext("healthstate", "human");
        break;
      }
      default: {
        self.isinfected = 0;
        setsoundcontext("healthstate", "cyber");
        break;
      }
    }
  }
}

function sndhealthsystem(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  lowhealthenteralias = "chr_health_lowhealth_enter";
  lowhealthexitalias = "chr_health_lowhealth_exit";
  laststandexitalias = "chr_health_laststand_exit";
  dnireparalais = "chr_health_dni_repair";
  if(newval) {
    switch (newval) {
      case 1: {
        self.lowhealth = 1;
        playSound(localclientnum, lowhealthenteralias, (0, 0, 0));
        forceambientroom("sndHealth_LowHealth");
        self thread snddnirepair(localclientnum, dnireparalais, 0.4, 0.8);
        break;
      }
      case 2: {
        playSound(localclientnum, lowhealthexitalias, (0, 0, 0));
        forceambientroom("sndHealth_LastStand");
        self notify("snddnirepairdone");
        setsoundcontext("laststand", "active");
        break;
      }
    }
  } else {
    self.lowhealth = 0;
    setsoundcontext("laststand", "");
    if(sessionmodeiscampaigngame() && (isDefined(level.audiosharedunderwater) && level.audiosharedunderwater)) {
      mapname = getdvarstring("mapname");
      if(mapname == "cp_mi_sing_sgen") {
        forceambientroom("");
      } else {
        forceambientroom("");
      }
    } else {
      forceambientroom("");
    }
    if(oldval == 1) {
      playSound(localclientnum, lowhealthexitalias, (0, 0, 0));
      self notify("snddnirepairdone");
    } else {
      if(isalive(self)) {
        playSound(localclientnum, laststandexitalias, (0, 0, 0));
        if(isDefined(self.sndtacrigemergencyreserve) && self.sndtacrigemergencyreserve) {
          playSound(localclientnum, "gdt_cybercore_regen_complete", (0, 0, 0));
        }
      }
      self notify("snddnirepairdone");
    }
    return;
  }
}

function snddnirepair(localclientnum, alais, min, max) {
  self endon("snddnirepairdone");
  wait(0.5);
  if(isDefined(self) && isDefined(self.isinfected)) {
    if(self.isinfected) {
      playSound(localclientnum, "vox_dying_infected_after", (0, 0, 0));
    }
    while(isDefined(self)) {
      playSound(localclientnum, alais, (0, 0, 0));
      wait(randomfloatrange(min, max));
    }
  }
}

function sndtacrig(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.sndtacrigemergencyreserve = 1;
  } else {
    self.sndtacrigemergencyreserve = 0;
  }
}

function dorattle(origin, min, max) {
  if(isDefined(min) && min > 0) {
    if(isDefined(max) && max <= 0) {
      max = undefined;
    }
    soundrattle(origin, min, max);
  }
}

function sndrattle_server(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(self.model == "wpn_t7_bouncing_betty_world") {
      betty = getweapon("bouncingbetty");
      level thread dorattle(self.origin, betty.soundrattlerangemin, betty.soundrattlerangemax);
    } else {
      level thread dorattle(self.origin, 25, 600);
    }
  }
}

function sndrattle_grenade_client() {
  while(true) {
    level waittill("explode", localclientnum, position, mod, weapon, owner_cent);
    level thread dorattle(position, weapon.soundrattlerangemin, weapon.soundrattlerangemax);
  }
}

function weapon_butt_sounds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.meleed = 1;
    level.mysnd = playSound(localclientnum, "chr_melee_tinitus", (0, 0, 0));
    forceambientroom("sndHealth_Melee");
  } else {
    self.meleed = 0;
    forceambientroom("");
    if(isDefined(level.mysnd)) {
      stopsound(level.mysnd);
    }
  }
}

function set_sound_context_defaults() {
  wait(2);
  setsoundcontext("foley", "normal");
}

function sndmatchsnapshot(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    switch (newval) {
      case 1: {
        snd_set_snapshot("mpl_prematch");
        break;
      }
      case 2: {
        snd_set_snapshot("mpl_postmatch");
        break;
      }
      case 3: {
        snd_set_snapshot("mpl_endmatch");
        break;
      }
    }
  } else {
    snd_set_snapshot("default");
  }
}

function sndfoleycontext(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  setsoundcontext("foley", "normal");
}

function sndkillcam() {
  level thread sndfinalkillcam_slowdown();
  level thread sndfinalkillcam_deactivate();
}

function snddeath_activate() {
  while(true) {
    level waittill("sndded");
    snd_set_snapshot("mpl_death");
  }
}

function snddeath_deactivate() {
  while(true) {
    level waittill("snddede");
    snd_set_snapshot("default");
  }
}

function sndfinalkillcam_activate() {
  while(true) {
    level waittill("sndfks");
    playSound(0, "mpl_final_killcam_enter", (0, 0, 0));
    snd_set_snapshot("mpl_final_killcam");
  }
}

function sndfinalkillcam_slowdown() {
  while(true) {
    level waittill("sndfksl");
    playSound(0, "mpl_final_killcam_enter", (0, 0, 0));
    playSound(0, "mpl_final_killcam_slowdown", (0, 0, 0));
    snd_set_snapshot("mpl_final_killcam_slowdown");
  }
}

function sndfinalkillcam_deactivate() {
  while(true) {
    level waittill("sndfke");
    snd_set_snapshot("default");
  }
}

function sndswitchvehiclecontext(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self islocalclientdriver(localclientnum)) {
    setsoundcontext("plr_impact", "veh");
  } else {
    setsoundcontext("plr_impact", "");
  }
}

function sndmusicdeathwatcher() {
  self waittill("death");
  soundsetmusicstate("death");
}

function sndcchacking(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    switch (newval) {
      case 1: {
        playSound(0, "gdt_cybercore_hack_start_plr", (0, 0, 0));
        self.hsnd = self playLoopSound("gdt_cybercore_hack_lp_plr", 0.5);
        break;
      }
      case 2: {
        playSound(0, "gdt_cybercore_prime_upg_plr", (0, 0, 0));
        self.hsnd = self playLoopSound("gdt_cybercore_prime_loop_plr", 0.5);
        break;
      }
    }
  } else {
    if(isDefined(self.hsnd)) {
      self stoploopsound(self.hsnd, 0.5);
    }
    if(oldval == 1) {
      playSound(0, "gdt_cybercore_hack_success_plr", (0, 0, 0));
    } else if(oldval == 2) {
      playSound(0, "gdt_cybercore_activate_fail_plr", (0, 0, 0));
    }
  }
}

function sndigcsnapshot(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    switch (newval) {
      case 1: {
        snd_set_snapshot("cmn_igc_bg_lower");
        level.sndigcsnapshotoverride = 0;
        break;
      }
      case 2: {
        snd_set_snapshot("cmn_igc_amb_silent");
        level.sndigcsnapshotoverride = 1;
        break;
      }
      case 3: {
        snd_set_snapshot("cmn_igc_foley_lower");
        level.sndigcsnapshotoverride = 0;
        break;
      }
      case 4: {
        snd_set_snapshot("cmn_level_fadeout");
        level.sndigcsnapshotoverride = 0;
        break;
      }
      case 5: {
        snd_set_snapshot("cmn_level_fade_immediate");
        level.sndigcsnapshotoverride = 0;
        break;
      }
    }
  } else {
    level.sndigcsnapshotoverride = 0;
    snd_set_snapshot("default");
  }
}

function sndlevelstartsnapoff(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(!(isDefined(level.sndigcsnapshotoverride) && level.sndigcsnapshotoverride)) {
      snd_set_snapshot("default");
    }
  }
}

function sndzmbfadein(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    snd_set_snapshot("default");
  }
}

function sndchyronloop(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(!isDefined(level.chyronloop)) {
      level.chyronloop = spawn(0, (0, 0, 0), "script_origin");
      level.chyronloop playLoopSound("uin_chyron_loop");
    }
  } else if(isDefined(level.chyronloop)) {
    level.chyronloop delete();
  }
}