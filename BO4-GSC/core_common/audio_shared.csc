/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\audio_shared.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\dialog_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;

#namespace audio;

autoexec __init__system__() {
  system::register(#"audio", &__init__, undefined, undefined);
}

__init__() {
  snd_snapshot_init();
  callback::on_localclient_connect(&player_init);
  callback::on_localplayer_spawned(&local_player_spawn);
  callback::on_localplayer_spawned(&sndsprintbreath);
  level thread register_clientfields();
  level thread sndkillcam();
  setsoundcontext("foley", "normal");
  setsoundcontext("plr_impact", "");
}

register_clientfields() {
  clientfield::register("world", "sndMatchSnapshot", 1, 2, "int", &sndmatchsnapshot, 1, 0);
  clientfield::register("world", "sndFoleyContext", 1, 1, "int", &sndfoleycontext, 0, 0);
  clientfield::register("scriptmover", "sndRattle", 1, 1, "counter", &sndrattle_server, 1, 0);
  clientfield::register("allplayers", "sndRattle", 1, 1, "counter", &sndrattle_server, 1, 0);
  clientfield::register("toplayer", "sndMelee", 1, 1, "int", &weapon_butt_sounds, 1, 1);
  clientfield::register("vehicle", "sndSwitchVehicleContext", 1, 3, "int", &sndswitchvehiclecontext, 0, 0);
  clientfield::register("toplayer", "sndCCHacking", 1, 2, "int", &sndcchacking, 1, 1);
  clientfield::register("toplayer", "sndTacRig", 1, 1, "int", &sndtacrig, 0, 1);
  clientfield::register("toplayer", "sndLevelStartSnapOff", 1, 1, "int", &sndlevelstartsnapoff, 0, 1);
  clientfield::register("world", "sndIGCsnapshot", 1, 4, "int", &sndigcsnapshot, 1, 0);
  clientfield::register("world", "sndChyronLoop", 1, 1, "int", &sndchyronloop, 0, 0);
  clientfield::register("world", "sndZMBFadeIn", 1, 1, "int", &sndzmbfadein, 1, 0);
  clientfield::register("toplayer", "sndVehicleDamageAlarm", 1, 1, "counter", &sndvehicledamagealarm, 0, 0);
  clientfield::register("toplayer", "sndCriticalHealth", 1, 1, "int", &sndcriticalhealth, 0, 1);
  clientfield::register("toplayer", "sndLastStand", 1, 1, "int", &sndlaststand, 0, 0);
}

local_player_spawn(localclientnum) {
  if(!self function_21c0fa55()) {
    return;
  }

  setsoundcontext("foley", "normal");

  if(!sessionmodeismultiplayergame() && !sessionmodeiswarzonegame()) {
    self thread sndmusicdeathwatcher();
  }

  self thread isplayerinfected();
  self thread snd_underwater(localclientnum);
  self thread clientvoicesetup(localclientnum);
}

player_init(localclientnum) {
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

snddoublejump_watcher() {
  self endon(#"death");

  while(true) {
    self waittill(#"doublejump_start");
    trace = tracepoint(self.origin, self.origin - (0, 0, 100000));
    trace_surface_type = trace[#"surfacetype"];
    trace_origin = trace[#"position"];

    if(!isDefined(trace) || !isDefined(trace_origin)) {
      continue;
    }

    if(!isDefined(trace_surface_type)) {
      trace_surface_type = "default";
    }

    playSound(0, #"veh_jetpack_surface_" + trace_surface_type, trace_origin);
  }
}

clientvoicesetup(localclientnum) {
  self endon(#"death");

  if(isDefined(level.clientvoicesetup)) {
    [[level.clientvoicesetup]](localclientnum);
    return;
  }

  self.teamclientprefix = "vox_gen";
  self thread sndvonotify("playerbreathinsound", "sniper_hold");
  self thread sndvonotify("playerbreathoutsound", "sniper_exhale");
  self thread sndvonotify("playerbreathgaspsound", "sniper_gasp");
}

sndvonotify(notifystring, dialog) {
  self endon(#"death");

  for(;;) {
    self waittill(notifystring);
    soundalias = self.teamclientprefix + "_" + dialog;
    self playSound(0, soundalias);
  }
}

snd_snapshot_init() {
  level._sndactivesnapshot = "default";
  level._sndnextsnapshot = "default";

  if(!util::is_frontend_map()) {
    if(sessionmodeiscampaigngame() && !function_22a92b8b() && !function_c9705ad4()) {
      level._sndactivesnapshot = "cmn_level_start";
      level._sndnextsnapshot = "cmn_level_start";
      level thread sndlevelstartduck_shutoff();
    }

    if(sessionmodeiszombiesgame()) {
      level._sndactivesnapshot = "zmb_game_start_nofade";
      level._sndnextsnapshot = "zmb_game_start_nofade";
    }
  }

  setgroupsnapshot(level._sndactivesnapshot);
  thread snd_snapshot_think();
}

sndlevelstartduck_shutoff() {
  level waittill(#"sndlevelstartduck_shutoff");
  snd_set_snapshot("default");
}

function_22a92b8b() {
  ignore = 1;
  mapname = util::get_map_name();

  switch (mapname) {
    case #"hash_15642edd0e4376f1":
    case #"hash_5562580f1b903614":
    case #"hash_65a6e39408662d48":
    case #"hash_68bac554964f4148":
    case #"hash_7bdf016123a0147b":
      ignore = 0;
      break;
  }

  gametype = hash(util::get_game_type());

  switch (gametype) {
    case #"download":
      ignore = 1;
      break;
  }

  return ignore;
}

function_c9705ad4() {
  ignore = 1;
  gametype = hash(util::get_game_type());

  switch (gametype) {
    case #"coop":
    case #"pvp":
      ignore = 0;
      break;
  }

  return ignore;
}

snd_set_snapshot(state) {
  level._sndnextsnapshot = state;
  println("<dev string:x38>" + state + "<dev string:x56>");
  level notify(#"new_bus");
}

snd_snapshot_think() {
  for(;;) {
    if(level._sndactivesnapshot == level._sndnextsnapshot) {
      level waittill(#"new_bus");
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

soundrandom_thread(localclientnum, randsound) {
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
    wait randomfloatrange(randsound.script_wait_min, randsound.script_wait_max);

    if(isDefined(randsound.script_sound) && isDefined(randsound.playing) && randsound.playing) {
      playSound(localclientnum, randsound.script_sound, randsound.origin);
    }

    if(getdvarint(#"debug_audio", 0) > 0) {
      print3d(randsound.origin, randsound.script_sound, (0, 0.8, 0), 1, 3, 45);
    }

  }
}

soundrandom_notifywait(notify_name, randsound) {
  while(true) {
    level waittill(notify_name);

    if(isDefined(randsound.playing) && randsound.playing) {
      randsound.playing = 0;
      continue;
    }

    randsound.playing = 1;
  }
}

startsoundrandoms(localclientnum) {
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
      randoms[i].angles = undefined;
      thread soundrandom_thread(localclientnum, randoms[i]);
    }
  }
}

soundloopthink() {
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

soundloopcheckpointrestore() {
  level waittill(#"save_restore");
  soundloopemitter(self.script_sound, self.origin);
}

soundlinethink() {
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

soundlinecheckpointrestore(target) {
  level waittill(#"save_restore");
  soundlineemitter(self.script_sound, self.origin, target.origin);
}

startsoundloops() {
  loopers = struct::get_array("looper", "script_label");

  if(isDefined(loopers) && loopers.size > 0) {
    delay = 0;

    if(getdvarint(#"debug_audio", 0) > 0) {
      println("<dev string:x5a>" + loopers.size + "<dev string:x87>");
    }

    for(i = 0; i < loopers.size; i++) {
      loopers[i].angles = undefined;
      loopers[i].script_label = undefined;
      loopers[i] thread soundloopthink();
      delay += 1;

      if(delay % 20 == 0) {
        waitframe(1);
      }
    }

    return;
  }

  if(getdvarint(#"debug_audio", 0) > 0) {
    println("<dev string:x94>");
  }

}

startlineemitters() {
  lineemitters = struct::get_array("line_emitter", "script_label");

  if(isDefined(lineemitters) && lineemitters.size > 0) {
    delay = 0;

    if(getdvarint(#"debug_audio", 0) > 0) {
      println("<dev string:xb5>" + lineemitters.size + "<dev string:x87>");
    }

    for(i = 0; i < lineemitters.size; i++) {
      lineemitters[i].angles = undefined;
      lineemitters[i].script_label = undefined;
      lineemitters[i] thread soundlinethink();
      delay += 1;

      if(delay % 20 == 0) {
        waitframe(1);
      }
    }

    return;
  }

  if(getdvarint(#"debug_audio", 0) > 0) {
    println("<dev string:xe8>");
  }

}

startrattles() {
  rattles = struct::get_array("sound_rattle", "script_label");

  if(isDefined(rattles)) {
    println("<dev string:x10f>" + rattles.size + "<dev string:x118>");
    delay = 0;

    for(i = 0; i < rattles.size; i++) {
      soundrattlesetup(rattles[i].script_sound, rattles[i].origin);
      delay += 1;

      if(delay % 20 == 0) {
        waitframe(1);
      }
    }
  }

  foreach(rattle in rattles) {
    arrayremovevalue(level.struct, rattle, 1);
  }

  arrayremovevalue(level.struct, undefined, 0);
}

init_audio_triggers(localclientnum) {
  util::waitforclient(localclientnum);
  steptrigs = getEntArray(localclientnum, "audio_step_trigger", "targetname");
  materialtrigs = getEntArray(localclientnum, "audio_material_trigger", "targetname");

  if(getdvarint(#"debug_audio", 0) > 0) {
    println("<dev string:x123>" + steptrigs.size + "<dev string:x12f>");
    println("<dev string:x123>" + materialtrigs.size + "<dev string:x147>");
  }

  array::thread_all(steptrigs, &audio_step_trigger, localclientnum);
  array::thread_all(materialtrigs, &audio_material_trigger, localclientnum);
}

function_a3010aae(ent, on_enter_payload, on_exit_payload) {
  ent endon(#"death");

  if(!isDefined(self)) {
    return;
  }

  myentnum = self getentitynumber();
  wait_time = getdvarfloat(#"hash_497642044cfae073", 1);

  if(ent trigger::ent_already_in(myentnum)) {
    return;
  }

  trigger::add_to_ent(ent, myentnum);

  if(isDefined(on_enter_payload)) {
    [[on_enter_payload]](ent);
  }

  while(isDefined(ent) && isDefined(self) && ent istouching(self)) {
    wait wait_time;
  }

  if(isDefined(ent)) {
    if(isDefined(on_exit_payload)) {
      [
        [on_exit_payload]
      ](ent);
    }

    trigger::remove_from_ent(ent, myentnum);
  }
}

audio_step_trigger(localclientnum) {
  var_887fc615 = self getentitynumber();

  while(true) {
    waitresult = self waittill(#"trigger");

    if(!waitresult.activator trigger::ent_already_in(var_887fc615)) {
      self thread function_a3010aae(waitresult.activator, &trig_enter_audio_step_trigger, &trig_leave_audio_step_trigger);
    }

    waitframe(1);
  }
}

audio_material_trigger(trig) {
  for(;;) {
    waitresult = self waittill(#"trigger");
    self thread function_a3010aae(waitresult.activator, &trig_enter_audio_material_trigger, &trig_leave_audio_material_trigger);
  }
}

trig_enter_audio_material_trigger(player) {
  if(!isDefined(player.inmaterialoverridetrigger)) {
    player.inmaterialoverridetrigger = 0;
  }

  if(isDefined(self.script_label)) {
    player.inmaterialoverridetrigger++;
    player.audiomaterialoverride = self.script_label;
    player setmaterialoverride(self.script_label);
  }
}

trig_leave_audio_material_trigger(player) {
  if(isDefined(self.script_label)) {
    player.inmaterialoverridetrigger--;
    assert(player.inmaterialoverridetrigger >= 0);

    if(player.inmaterialoverridetrigger <= 0) {
      player.audiomaterialoverride = undefined;
      player.inmaterialoverridetrigger = 0;
      player clearmaterialoverride();
    }
  }
}

trig_enter_audio_step_trigger(trigplayer) {
  localclientnum = self._localclientnum;

  if(!isDefined(trigplayer.insteptrigger)) {
    trigplayer.insteptrigger = 0;
  }

  suffix = "_npc";

  if(trigplayer function_21c0fa55()) {
    suffix = "_plr";
  }

  if(isDefined(self.script_step_alias)) {
    trigplayer.step_sound = self.script_step_alias;
    trigplayer.insteptrigger += 1;
    trigplayer setsteptriggersound(self.script_step_alias + suffix);
  }

  if(isDefined(self.script_step_alias_enter) && trigplayer getmovementtype() == "sprint") {
    volume = get_vol_from_speed(trigplayer);
    trigplayer playSound(localclientnum, self.script_step_alias_enter + suffix, self.origin, volume);
  }
}

trig_leave_audio_step_trigger(trigplayer) {
  localclientnum = self._localclientnum;
  suffix = "_npc";

  if(trigplayer function_21c0fa55()) {
    suffix = "_plr";
  }

  if(isDefined(self.script_step_alias_exit) && trigplayer getmovementtype() == "sprint") {
    volume = get_vol_from_speed(trigplayer);
    trigplayer playSound(localclientnum, self.script_step_alias_exit + suffix, self.origin, volume);
  }

  if(isDefined(self.script_step_alias)) {
    trigplayer.insteptrigger -= 1;
  }

  if(trigplayer.insteptrigger < 0) {
    println("<dev string:x163>");
    trigplayer.insteptrigger = 0;
  }

  if(trigplayer.insteptrigger == 0) {
    trigplayer.step_sound = "none";
    trigplayer clearsteptriggersound();
  }
}

bump_trigger_start(localclientnum) {
  bump_trigs = getEntArray(localclientnum, "audio_bump_trigger", "targetname");

  for(i = 0; i < bump_trigs.size; i++) {
    bump_trigs[i] thread thread_bump_trigger(localclientnum);
  }
}

thread_bump_trigger(localclientnum) {
  self thread bump_trigger_listener();

  if(!isDefined(self.script_activated)) {
    self.script_activated = 1;
  }

  self._localclientnum = localclientnum;

  for(;;) {
    waitresult = self waittill(#"trigger");
    self thread trigger::function_thread(waitresult.activator, &trig_enter_bump, &trig_leave_bump);
  }
}

trig_enter_bump(ent) {
  if(!isDefined(ent)) {
    return;
  }

  if(!isDefined(self.script_bump_volume_threshold)) {
    self.script_bump_volume_threshold = 0.75;
  }

  localclientnum = self._localclientnum;
  volume = get_vol_from_speed(ent);

  if(!sessionmodeiszombiesgame()) {
    if(isplayer(ent) && ent hasperk(localclientnum, "specialty_quieter")) {
      volume /= 2;
    }
  }

  if(isDefined(self.script_bump_alias) && self.script_activated) {
    self playSound(localclientnum, self.script_bump_alias, self.origin, volume);
  }

  if(isDefined(self.script_bump_alias_soft) && self.script_bump_volume_threshold > volume && self.script_activated) {
    self playSound(localclientnum, self.script_bump_alias_soft, self.origin, volume);
  }

  if(isDefined(self.script_bump_alias_hard) && self.script_bump_volume_threshold <= volume && self.script_activated) {
    self playSound(localclientnum, self.script_bump_alias_hard, self.origin, volume);
  }

  if(isDefined(self.script_mantle_alias) && self.script_activated) {
    ent thread mantle_wait(self.script_mantle_alias, localclientnum);
  }
}

mantle_wait(alias, localclientnum) {
  self endon(#"death");
  self endon(#"left_mantle");
  self waittill(#"traversesound");
  self playSound(localclientnum, alias, self.origin, 1);
}

trig_leave_bump(ent) {
  wait 1;
  ent notify(#"left_mantle");
}

bump_trigger_listener() {
  if(isDefined(self.script_label)) {
    level waittill(self.script_label);
    self.script_activated = 0;
  }
}

scale_speed(x1, x2, y1, y2, z) {
  if(z < x1) {
    z = x1;
  }

  if(z > x2) {
    z = x2;
  }

  dx = x2 - x1;
  n = (z - x1) / dx;
  dy = y2 - y1;
  w = n * dy + y1;
  return w;
}

get_vol_from_speed(player) {
  min_speed = 20;
  max_speed = 200;
  max_vol = 1;
  min_vol = 0.1;
  speed = player getspeed();
  abs_speed = absolute_value(int(speed));
  volume = scale_speed(min_speed, max_speed, min_vol, max_vol, abs_speed);
  return volume;
}

absolute_value(fowd) {
  if(fowd < 0) {
    return (fowd * -1);
  }

  return fowd;
}

closest_point_on_line_to_point(point, linestart, lineend) {
  self endon(#"end line sound");
  linemagsqrd = lengthsquared(lineend - linestart);
  t = ((point[0] - linestart[0]) * (lineend[0] - linestart[0]) + (point[1] - linestart[1]) * (lineend[1] - linestart[1]) + (point[2] - linestart[2]) * (lineend[2] - linestart[2])) / linemagsqrd;

  if(t < 0) {
    self.origin = linestart;
    return;
  }

  if(t > 1) {
    self.origin = lineend;
    return;
  }

  start_x = linestart[0] + t * (lineend[0] - linestart[0]);
  start_y = linestart[1] + t * (lineend[1] - linestart[1]);
  start_z = linestart[2] + t * (lineend[2] - linestart[2]);
  self.origin = (start_x, start_y, start_z);
}

snd_play_auto_fx(fxid, alias, offsetx, offsety, offsetz, onground, area, threshold, alias_override) {
  soundplayautofx(fxid, alias, offsetx, offsety, offsetz, onground, area, threshold, alias_override);
}

snd_print_fx_id(fxid, type, ent) {
  if(getdvarint(#"debug_audio", 0) > 0) {
    println("<dev string:x1ac>" + fxid + "<dev string:x1c0>" + type);
  }
}

debug_line_emitter() {
  while(true) {
    if(getdvarint(#"debug_audio", 0) > 0) {
      line(self.start, self.end, (0, 1, 0));
      print3d(self.start, "<dev string:x1cc>", (0, 0.8, 0), 1, 3, 1);
      print3d(self.end, "<dev string:x1d4>", (0, 0.8, 0), 1, 3, 1);
      print3d(self.origin, self.script_sound, (0, 0.8, 0), 1, 3, 1);
    }

    waitframe(1);

  }
}

move_sound_along_line() {
  closest_dist = undefined;

  self thread debug_line_emitter();

  while(true) {
    self closest_point_on_line_to_point(getlocalclientpos(0), self.start, self.end);

    if(isDefined(self.fake_ent)) {
      self.fake_ent.origin = self.origin;
    }

    closest_dist = distancesquared(getlocalclientpos(0), self.origin);

    if(closest_dist > 1048576) {
      wait 2;
      continue;
    }

    if(closest_dist > 262144) {
      wait 0.2;
      continue;
    }

    wait 0.05;
  }
}

playloopat(aliasname, origin) {
  soundloopemitter(aliasname, origin);
}

stoploopat(aliasname, origin) {
  soundstoploopemitter(aliasname, origin);
}

soundwait(id) {
  while(soundplaying(id)) {
    wait 0.1;
  }
}

snd_underwater(localclientnum) {
  level endon(#"demo_jump");
  self endon(#"death");
  level endon("killcam_begin" + localclientnum);
  level endon("killcam_end" + localclientnum);
  self endon(#"sndenduwwatcher");

  if(!isDefined(level.audiosharedswimming)) {
    level.audiosharedswimming = 0;
  }

  if(!isDefined(level.audiosharedunderwater)) {
    level.audiosharedunderwater = 0;
  }

  setsoundcontext("water_global", "over");

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
    underwaternotify = self waittill(#"underwater_begin", #"underwater_end", #"swimming_begin", #"swimming_end", #"death", #"sndenduwwatcher");

    if(underwaternotify._notify == "death") {
      self underwaterend();
      self swimend(localclientnum);
    }

    if(underwaternotify._notify == "underwater_begin") {
      self underwaterbegin();
      continue;
    }

    if(underwaternotify._notify == "underwater_end") {
      self underwaterend();
      continue;
    }

    if(underwaternotify._notify == "swimming_begin") {
      self swimbegin();
      continue;
    }

    if(underwaternotify._notify == "swimming_end" && isplayer(self) && isalive(self)) {
      self swimend(localclientnum);
    }
  }
}

underwaterbegin() {
  level.audiosharedunderwater = 1;
  setsoundcontext("water_global", "under");
}

underwaterend() {
  level.audiosharedunderwater = 0;
  setsoundcontext("water_global", "over");
}

swimbegin() {
  self.audiosharedswimming = 1;
}

swimend(localclientnum) {
  self.audiosharedswimming = 0;
}

swimcancel(localclientnum) {
  self.audiosharedswimming = 0;
}

soundplayuidecodeloop(decodestring, playtimems) {
  if(!isDefined(level.playinguidecodeloop) || !level.playinguidecodeloop) {
    level.playinguidecodeloop = 1;
    fake_ent = spawn(0, (0, 0, 0), "script_origin");

    if(isDefined(fake_ent)) {
      fake_ent playLoopSound(#"uin_notify_data_loop");
      wait float(playtimems) / 1000;
      fake_ent stopallloopsounds(0);
    }

    level.playinguidecodeloop = undefined;
  }
}

setcurrentambientstate(ambientroom, ambientpackage, roomcollidercent, packagecollidercent, defaultroom) {}

isplayerinfected() {
  self endon(#"death");
  self.isinfected = 0;
  setsoundcontext("healthstate", "human");
}

sndcriticalhealth(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::function_89a98f85();

  if(function_65b9eb0f(localclientnum)) {
    return;
  }

  if(!isDefined(self)) {
    return;
  }

  if(!self function_21c0fa55()) {
    return;
  }

  if(!isDefined(self.var_2f6077ac)) {
    self.var_2f6077ac = self.origin;
  }

  if(newval) {
    playSound(localclientnum, #"chr_health_lowhealth_enter", (0, 0, 0));
    playloopat("chr_health_lowhealth_loop", self.var_2f6077ac);
    return;
  }

  stoploopat("chr_health_lowhealth_loop", self.var_2f6077ac);
  self.var_2f6077ac = undefined;
}

sndlaststand(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::function_89a98f85();

  if(function_65b9eb0f(localclientnum)) {
    return;
  }

  if(!isDefined(self)) {
    return;
  }

  if(!self function_21c0fa55()) {
    return;
  }

  if(!isDefined(self.sndlaststand)) {
    self.sndlaststand = self.origin;
  }

  if(newval) {
    playSound(localclientnum, #"chr_health_laststand_enter", (0, 0, 0));
    playloopat("chr_health_laststand_loop", self.sndlaststand);
    return;
  }

  stoploopat("chr_health_laststand_loop", self.sndlaststand);
  self.sndlaststand = undefined;
}

sndtacrig(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.sndtacrigemergencyreserve = 1;
    return;
  }

  self.sndtacrigemergencyreserve = 0;
}

dorattle(origin, min, max) {
  if(isDefined(min) && min > 0) {
    if(isDefined(max) && max <= 0) {
      max = undefined;
    }

    soundrattle(origin, min, max);
  }
}

sndrattle_server(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(isDefined(self.model) && self.model == #"wpn_t7_bouncing_betty_world") {
      betty = getweapon(#"bouncingbetty");
      level thread dorattle(self.origin, betty.soundrattlerangemin, betty.soundrattlerangemax);
      return;
    }

    level thread dorattle(self.origin, 25, 600);
  }
}

sndrattle_grenade_client() {
  while(true) {
    waitresult = level waittill(#"explode");
    level thread dorattle(waitresult.position, waitresult.weapon.soundrattlerangemin, waitresult.weapon.soundrattlerangemax);
  }
}

weapon_butt_sounds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.meleed = 1;
    level.mysnd = playSound(localclientnum, #"chr_melee_tinitus", (0, 0, 0));
    return;
  }

  self.meleed = 0;

  if(isDefined(level.mysnd)) {
    stopsound(level.mysnd);
  }
}

set_sound_context_defaults() {
  wait 2;
  setsoundcontext("foley", "normal");
}

sndmatchsnapshot(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(sessionmodeiswarzonegame()) {
    return;
  }

  if(newval) {
    switch (newval) {
      case 1:
        snd_set_snapshot("mpl_prematch");
        break;
      case 2:
        snd_set_snapshot("mpl_postmatch");
        break;
      case 3:
        snd_set_snapshot("mpl_endmatch");
        break;
    }

    return;
  }

  snd_set_snapshot("default");
}

sndfoleycontext(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  setsoundcontext("foley", "normal");
}

sndkillcam() {
  level thread sndfinalkillcam_slowdown();
  level thread sndfinalkillcam_deactivate();
}

snddeath_activate() {
  while(true) {
    level waittill(#"sndded");
    snd_set_snapshot("mpl_death");
  }
}

snddeath_deactivate() {
  while(true) {
    level waittill(#"snddede");
    snd_set_snapshot("default");
  }
}

sndfinalkillcam_activate() {
  while(true) {
    level waittill(#"sndfks");
  }
}

sndfinalkillcam_slowdown() {
  while(true) {
    level waittill(#"sndfksl");
  }
}

sndfinalkillcam_deactivate() {
  while(true) {
    level waittill(#"sndfke");
    snd_set_snapshot("default");
  }
}

sndswitchvehiclecontext(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self)) {
    return;
  }

  if(self isvehicle() && self function_4add50a7()) {
    setsoundcontext("plr_impact", "veh");
    return;
  }

  setsoundcontext("plr_impact", "");
}

sndmusicdeathwatcher() {
  self waittill(#"death");
}

sndcchacking(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    switch (newval) {
      case 1:
        playSound(0, #"gdt_cybercore_hack_start_plr", (0, 0, 0));
        self.hsnd = self playLoopSound(#"gdt_cybercore_hack_lp_plr", 0.5);
        break;
      case 2:
        playSound(0, #"gdt_cybercore_prime_upg_plr", (0, 0, 0));
        self.hsnd = self playLoopSound(#"gdt_cybercore_prime_loop_plr", 0.5);
        break;
    }

    return;
  }

  if(isDefined(self.hsnd)) {
    self stoploopsound(self.hsnd, 0.5);
  }

  if(oldval == 1) {
    playSound(0, #"gdt_cybercore_hack_success_plr", (0, 0, 0));
    return;
  }

  if(oldval == 2) {
    playSound(0, #"gdt_cybercore_activate_fail_plr", (0, 0, 0));
  }
}

sndigcsnapshot(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    switch (newval) {
      case 1:
        snd_set_snapshot("cmn_igc_bg_lower");
        level.sndigcsnapshotoverride = 0;
        break;
      case 2:
        snd_set_snapshot("cmn_igc_amb_silent");
        level.sndigcsnapshotoverride = 1;
        break;
      case 3:
        snd_set_snapshot("cmn_igc_foley_lower");
        level.sndigcsnapshotoverride = 0;
        break;
      case 4:
        snd_set_snapshot("cmn_level_fadeout");
        level.sndigcsnapshotoverride = 0;
        break;
      case 5:
        snd_set_snapshot("cmn_level_fade_immediate");
        level.sndigcsnapshotoverride = 0;
        break;
    }

    return;
  }

  level.sndigcsnapshotoverride = 0;
}

sndlevelstartsnapoff(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(isDefined(level.sndigcsnapshotoverride) && level.sndigcsnapshotoverride) {}
  }
}

sndzmbfadein(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    snd_set_snapshot("default");
  }
}

sndchyronloop(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(!isDefined(level.chyronloop)) {
      level.chyronloop = spawn(0, (0, 0, 0), "script_origin");
      level.chyronloop playLoopSound(#"uin_chyron_loop");
    }

    return;
  }

  if(isDefined(level.chyronloop)) {
    level.chyronloop delete();
  }
}

sndsprintbreath(localclientnum) {
  self endon(#"death");

  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    self.var_29054134 = 0;
    var_63112f76 = self dialog_shared::get_player_dialog_alias("exertBreatheSprinting");
    var_dfb6f570 = self dialog_shared::get_player_dialog_alias("exertBreatheSprintingEnd");

    if(!isDefined(var_63112f76) || !isDefined(var_dfb6f570)) {
      return;
    }

    while(true) {
      if(isDefined(self)) {
        if(self isplayersprinting()) {
          self thread sndbreathstart(var_63112f76);
          self thread function_ee6d1a7f(var_dfb6f570);
          waitresult = self waittill(#"hash_4e899fa9b2775b4d", #"death");

          if(waitresult._notify == "death") {
            return;
          }
        }
      }

      wait 0.1;
    }
  }
}

sndbreathstart(sound) {
  self endon(#"hash_4e899fa9b2775b4d");
  self endon(#"death");
  self waittill(#"hash_1d827c5a5cd4a607");

  if(isDefined(self)) {
    self thread function_d6bc7279(sound);
  }
}

function_d6bc7279(sound) {
  self endon(#"death");
  self endon(#"hash_4e899fa9b2775b4d");
  self.var_29054134 = 1;

  while(true) {
    self playSound(0, sound);
    wait 2.5;
  }
}

function_ee6d1a7f(sound) {
  self endon(#"death");
  self waittill(#"hash_4e899fa9b2775b4d");

  if(self.var_29054134) {
    self playSound(0, sound);
    self.var_29054134 = 0;
  }
}

function_5da61577(localclientnum) {
  self endon(#"death");

  if(isDefined(self)) {
    self thread function_bd07593a();
  }
}

function_bd07593a() {
  self endon(#"death");

  while(true) {
    if(self util::is_on_side(#"allies")) {
      if(self isplayersprinting()) {
        self playSound(0, #"hash_2dc9c76844261d06");
        wait 1;
      } else {
        self playSound(0, #"hash_70b507d0e243536d");
        wait 2.5;
      }
    }

    wait 0.1;
  }
}

sndvehicledamagealarm(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify(#"sndvehicledamagealarm");
  self thread function_350920b9();
}

function_350920b9() {
  self endon(#"death");
  self endon(#"disconnect");
  self endon(#"sndvehicledamagealarm");

  if(!isDefined(self.var_5730fa36)) {
    self.var_5730fa36 = self playLoopSound(#"hash_7a6b427867364957");
  }

  wait 2;

  if(isDefined(self.var_5730fa36)) {
    self stoploopsound(self.var_5730fa36);
    self.var_5730fa36 = undefined;
  }

  self playSound(0, #"hash_26a4334032c725cb");
}