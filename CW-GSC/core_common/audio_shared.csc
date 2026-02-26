/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\audio_shared.csc
***********************************************/

#using script_59f62971655f7103;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#namespace audio;

function private autoexec __init__system__() {
  system::register(#"audio", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  snd_snapshot_init();
  callback::on_localclient_connect(&player_init);
  callback::on_localplayer_spawned(&local_player_spawn);
  callback::on_localplayer_spawned(&sndsprintbreath);
  callback::on_localplayer_spawned(&function_aa906715);
  callback::function_2870abef(&function_45e99595);
  callback::function_b27200db(&function_bc0a8bd8);
  level thread register_clientfields();
  level thread sndkillcam();
  setsoundcontext("plr_impact", "flesh");
  util::register_system(#"duckcmd", &function_c037c7cd);
  level.var_4fe1773a = getdvarint(#"hash_287dc342cd15a144", 1);
}

function function_d3790fe() {
  function_62ff8d93(1);
  level.var_4fe1773a = 1;
}

function function_21f8b7c3() {
  function_62ff8d93(0);
  level.var_4fe1773a = 0;
}

function function_843dc46a() {
  setDvar(#"hash_59c2aaedc958314d", 1);
}

function function_a022576e() {
  setDvar(#"hash_59c2aaedc958314d", 2);
}

function register_clientfields() {
  clientfield::register("world", "sndMatchSnapshot", 1, 2, "int", &sndmatchsnapshot, 1, 0);
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
  clientfield::register("world", "sndDeactivateSquadSpawnMusic", 1, 1, "int", &snddeactivatesquadspawnmusic, 0, 0);
  clientfield::register("toplayer", "sndVehicleDamageAlarm", 1, 1, "counter", &sndvehicledamagealarm, 0, 0);
  clientfield::register("toplayer", "sndCriticalHealth", 1, 1, "int", &sndcriticalhealth, 0, 1);
  clientfield::register("toplayer", "sndLastStand", 1, 1, "int", &sndlaststand, 0, 0);
}

function local_player_spawn(localclientnum) {
  if(!self function_21c0fa55()) {
    return;
  }

  if(!sessionmodeismultiplayergame() && !sessionmodeiswarzonegame()) {
    self thread sndmusicdeathwatcher();
  }

  self thread snd_underwater(localclientnum);
  self thread clientvoicesetup(localclientnum);
}

function player_init(localclientnum) {
  if(issplitscreenhost(localclientnum)) {
    level thread bump_trigger_start(localclientnum);
    level thread init_audio_triggers(localclientnum);
    startsoundrandoms(localclientnum);
    startsoundloops();
    startlineemitters();
    startrattles();
  }
}

function snddeactivatesquadspawnmusic(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    level.var_acf54eb7 = 1;
  }
}

function function_45e99595(localclientnum) {
  if(!isDefined(self.var_ef6eb2d4)) {
    self.var_ef6eb2d4 = self battlechatter::get_player_dialog_alias("exertMantLight");
  }

  if(isDefined(self.var_ef6eb2d4) && soundexists(self.var_ef6eb2d4)) {
    self playSound(0, self.var_ef6eb2d4);
  }
}

function function_bc0a8bd8(localclientnum) {
  if(!isDefined(self.var_3991ee40)) {
    self.var_3991ee40 = self battlechatter::get_player_dialog_alias("exertMantHeavy");
  }

  if(isDefined(self.var_3991ee40) && soundexists(self.var_3991ee40)) {
    self playSound(0, self.var_3991ee40);
  }
}

function function_c037c7cd(clientnum, state, oldstate) {
  snd_set_snapshot(oldstate);
}

function snddoublejump_watcher() {
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

function clientvoicesetup(localclientnum) {
  self endon(#"death");

  if(isDefined(level.clientvoicesetup)) {
    [[level.clientvoicesetup]](localclientnum);
    return;
  }

  self thread sndvonotify("playerbreathinsound", "exert_sniper_hold");
  self thread sndvonotify("playerbreathoutsound", "exert_sniper_exhale");
  self thread sndvonotify("playerbreathgaspsound", "exert_sniper_gasp");
}

function sndvonotify(notifystring, dialog) {
  self endon(#"death");

  for(;;) {
    self waittill(notifystring);

    if(!isDefined(self.voiceprefix)) {
      bundle = self getmpdialogname();
      playerbundle = getscriptbundle(bundle);

      if(!isDefined(playerbundle.voiceprefix)) {
        continue;
      }

      self.voiceprefix = playerbundle.voiceprefix;
    }

    soundalias = self.voiceprefix + dialog;
    self playSound(0, soundalias);
  }
}

function snd_snapshot_init() {
  level._sndactivesnapshot = "default";
  level._sndnextsnapshot = "default";

  if(!util::is_frontend_map()) {
    if(sessionmodeiscampaigngame() && !function_22a92b8b() && !function_c9705ad4()) {
      level._sndactivesnapshot = "cmn_level_start";
      level._sndnextsnapshot = "cmn_level_start";
      level thread sndlevelstartduck_shutoff();
    }

    if(sessionmodeiszombiesgame()) {
      level._sndactivesnapshot = "default";
      level._sndnextsnapshot = "default";
    }
  }

  setgroupsnapshot(level._sndactivesnapshot);
  thread snd_snapshot_think();
}

function sndlevelstartduck_shutoff() {
  level waittill(#"sndlevelstartduck_shutoff");
  snd_set_snapshot("default");
}

function function_22a92b8b() {
  ignore = 1;
  mapname = util::get_map_name();

  switch (mapname) {
    case # "hash_15642edd0e4376f1":
    case # "hash_5562580f1b903614":
    case # "hash_65a6e39408662d48":
    case # "hash_68bac554964f4148":
    case # "hash_7bdf016123a0147b":
      ignore = 0;
      break;
  }

  gametype = hash(util::get_game_type());

  switch (gametype) {
    case # "download":
      ignore = 1;
      break;
  }

  return ignore;
}

function function_c9705ad4() {
  ignore = 1;
  gametype = hash(util::get_game_type());

  switch (gametype) {
    case # "coop":
    case # "pvp":
      ignore = 0;
      break;
  }

  return ignore;
}

function snd_set_snapshot(state) {
  level._sndnextsnapshot = state;
  println("<dev string:x38>" + state + "<dev string:x57>");
  level notify(#"new_bus");
}

function snd_snapshot_think() {
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

  if(!isDefined(notify_name)) {
    if(isDefined(randsound.script_sound)) {
      createsoundrandom(randsound.origin, randsound.script_sound, randsound.script_wait_min, randsound.script_wait_max);
      return;
    }

    println("<dev string:x5c>" + randsound.origin[0] + "<dev string:x78>" + randsound.origin[1] + "<dev string:x78>" + randsound.origin[2] + "<dev string:x7e>");
    return;
  }

  randsound.playing = 1;

  if(isDefined(randsound.script_int)) {
    randsound.playing = randsound.script_int != 0;
  }

  level thread soundrandom_notifywait(notify_name, randsound);

  while(true) {
    wait randomfloatrange(randsound.script_wait_min, randsound.script_wait_max);

    if(isDefined(randsound.script_sound) && is_true(randsound.playing)) {
      playSound(localclientnum, randsound.script_sound, randsound.origin);
    }

    if(getdvarint(#"debug_audio", 0) > 0) {
      print3d(randsound.origin, function_9e72a96(randsound.script_sound), (0, 0.8, 0), 1, 3, 45);
    }
  }
}

function soundrandom_notifywait(notify_name, randsound) {
  while(true) {
    level waittill(notify_name);

    if(is_true(randsound.playing)) {
      randsound.playing = 0;
      continue;
    }

    randsound.playing = 1;
  }
}

function startsoundrandoms(localclientnum) {
  level.randoms = struct::get_array("random", "script_label");

  if(isDefined(level.randoms) && level.randoms.size > 0) {
    nscriptthreadedrandoms = 0;

    for(i = 0; i < level.randoms.size; i++) {
      if(isDefined(level.randoms[i].script_scripted)) {
        nscriptthreadedrandoms++;
      }
    }

    allocatesoundrandoms(level.randoms.size - nscriptthreadedrandoms);

    for(i = 0; i < level.randoms.size; i++) {
      level.randoms[i].angles = undefined;
      thread soundrandom_thread(localclientnum, level.randoms[i]);
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
  level waittill(#"save_restore");
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
  level waittill(#"save_restore");
  soundlineemitter(self.script_sound, self.origin, target.origin);
}

function startsoundloops() {
  level.loopers = struct::get_array("looper", "script_label");

  if(isDefined(level.loopers) && level.loopers.size > 0) {
    delay = 0;

    if(getdvarint(#"debug_audio", 0) > 0) {
      println("<dev string:xd0>" + level.loopers.size + "<dev string:xfe>");
    }

    for(i = 0; i < level.loopers.size; i++) {
      level.loopers[i].angles = undefined;
      level.loopers[i].script_label = undefined;
      level.loopers[i] thread soundloopthink();
      delay += 1;

      if(delay % 20 == 0) {
        waitframe(1);
      }
    }

    return;
  }

  if(getdvarint(#"debug_audio", 0) > 0) {
    println("<dev string:x10c>");
  }
}

function startlineemitters() {
  level.lineemitters = struct::get_array("line_emitter", "script_label");

  if(isDefined(level.lineemitters) && level.lineemitters.size > 0) {
    delay = 0;

    if(getdvarint(#"debug_audio", 0) > 0) {
      println("<dev string:x12e>" + level.lineemitters.size + "<dev string:xfe>");
    }

    for(i = 0; i < level.lineemitters.size; i++) {
      level.lineemitters[i].angles = undefined;
      level.lineemitters[i].script_label = undefined;
      level.lineemitters[i] thread soundlinethink();
      delay += 1;

      if(delay % 20 == 0) {
        waitframe(1);
      }
    }

    return;
  }

  if(getdvarint(#"debug_audio", 0) > 0) {
    println("<dev string:x162>");
  }
}

function startrattles() {
  rattles = struct::get_array("sound_rattle", "script_label");

  if(isDefined(rattles)) {
    println("<dev string:x18a>" + rattles.size + "<dev string:x194>");
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
    rattle struct::delete();
  }
}

function init_audio_triggers(localclientnum) {
  util::waitforclient(localclientnum);
  steptrigs = getEntArray(localclientnum, "audio_step_trigger", "targetname");
  materialtrigs = getEntArray(localclientnum, "audio_material_trigger", "targetname");

  if(getdvarint(#"debug_audio", 0) > 0) {
    println("<dev string:x1a0>" + steptrigs.size + "<dev string:x1ad>");
    println("<dev string:x1a0>" + materialtrigs.size + "<dev string:x1c6>");
  }

  array::thread_all(steptrigs, &audio_step_trigger, localclientnum);
  array::thread_all(materialtrigs, &audio_material_trigger, localclientnum);
}

function audio_step_trigger(localclientnum) {
  var_887fc615 = self getentitynumber();

  while(true) {
    waitresult = self waittill(#"trigger");

    if(!waitresult.activator trigger::ent_already_in(var_887fc615)) {
      self thread trigger::function_thread(waitresult.activator, &trig_enter_audio_step_trigger, &trig_leave_audio_step_trigger);
    }

    waitframe(1);
  }
}

function audio_material_trigger(trig) {
  for(;;) {
    waitresult = self waittill(#"trigger");
    self thread trigger::function_thread(waitresult.activator, &trig_enter_audio_material_trigger, &trig_leave_audio_material_trigger);
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

function trig_leave_audio_step_trigger(trigplayer) {
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
    println("<dev string:x1e3>");
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
    waitresult = self waittill(#"trigger");
    self thread trigger::function_thread(waitresult.activator, &trig_enter_bump, &trig_leave_bump);
  }
}

function trig_enter_bump(ent) {
  if(!isDefined(ent)) {
    return;
  }

  if(!isDefined(self.script_bump_volume_threshold)) {
    self.script_bump_volume_threshold = 0.75;
  }

  localclientnum = self._localclientnum;
  volume = get_vol_from_speed(ent);

  if(!sessionmodeiszombiesgame()) {
    if(isPlayer(ent) && ent hasperk(localclientnum, "specialty_quieter")) {
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

function mantle_wait(alias, localclientnum) {
  self endon(#"death");
  self endon(#"left_mantle");
  self waittill(#"traversesound");
  self playSound(localclientnum, alias, self.origin, 1);
}

function trig_leave_bump(ent) {
  wait 1;
  ent notify(#"left_mantle");
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
  w = n * dy + y1;
  return w;
}

function get_vol_from_speed(player) {
  min_speed = 20;
  max_speed = 200;
  max_vol = 1;
  min_vol = 0.1;
  speed = player getspeed();
  abs_speed = absolute_value(int(speed));
  volume = scale_speed(min_speed, max_speed, min_vol, max_vol, abs_speed);
  return volume;
}

function absolute_value(fowd) {
  if(fowd < 0) {
    return (fowd * -1);
  }

  return fowd;
}

function closest_point_on_line_to_point(point, linestart, lineend) {
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

function snd_play_auto_fx(fxid, alias, offsetx, offsety, offsetz, onground, area, threshold, alias_override) {
  soundplayautofx(fxid, alias, offsetx, offsety, offsetz, onground, area, threshold, alias_override);
}

function snd_print_fx_id(fxid, type, ent) {
  if(getdvarint(#"debug_audio", 0) > 0) {
    println("<dev string:x22d>" + type + "<dev string:x242>" + ent);
  }
}

function debug_line_emitter() {
  while(true) {
    if(getdvarint(#"debug_audio", 0) > 0) {
      line(self.start, self.end, (0, 1, 0));
      print3d(self.start, "<dev string:x24f>", (0, 0.8, 0), 1, 3, 1);
      print3d(self.end, "<dev string:x258>", (0, 0.8, 0), 1, 3, 1);
      print3d(self.origin, self.script_sound, (0, 0.8, 0), 1, 3, 1);
    }

    waitframe(1);
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

function playloopat(aliasname, origin) {
  soundloopemitter(aliasname, origin);
}

function stoploopat(aliasname, origin) {
  soundstoploopemitter(aliasname, origin);
}

function soundwait(id) {
  while(soundplaying(id)) {
    wait 0.1;
  }
}

function snd_underwater(localclientnum) {
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

    if(underwaternotify._notify == "swimming_end" && isPlayer(self) && isalive(self)) {
      self swimend(localclientnum);
    }
  }
}

function underwaterbegin() {
  level.audiosharedunderwater = 1;
  setsoundcontext("water_global", "under");
}

function underwaterend() {
  level.audiosharedunderwater = 0;
  setsoundcontext("water_global", "over");
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
      fake_ent playLoopSound(#"uin_notify_data_loop");
      wait float(playtimems) / 1000;
      fake_ent stopallloopsounds(0);
    }

    level.playinguidecodeloop = undefined;
  }
}

function setcurrentambientstate(ambientroom, ambientpackage, roomcollidercent, packagecollidercent, defaultroom) {}

function sndcriticalhealth(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::function_89a98f85();

  if(function_65b9eb0f(fieldname)) {
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

  if(bwastimejump) {
    playSound(fieldname, #"chr_health_lowhealth_enter", (0, 0, 0));
    playloopat("chr_health_lowhealth_loop", self.var_2f6077ac);
    return;
  }

  stoploopat("chr_health_lowhealth_loop", self.var_2f6077ac);
  self.var_2f6077ac = undefined;
}

function sndlaststand(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::function_89a98f85();

  if(function_65b9eb0f(fieldname)) {
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

  if(bwastimejump) {
    playSound(fieldname, #"chr_health_laststand_enter", (0, 0, 0));
    playloopat("chr_health_laststand_loop", self.sndlaststand);
    return;
  }

  stoploopat("chr_health_laststand_loop", self.sndlaststand);
  self.sndlaststand = undefined;
}

function sndtacrig(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.sndtacrigemergencyreserve = 1;
    return;
  }

  self.sndtacrigemergencyreserve = 0;
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
  if(bwastimejump) {
    if(isDefined(self.model) && self.model == # "wpn_t7_bouncing_betty_world") {
      betty = getweapon(#"bouncingbetty");
      level dorattle(self.origin, betty.soundrattlerangemin, betty.soundrattlerangemax);
      return;
    }

    level dorattle(self.origin, 25, 600);
  }
}

function event_handler[event_74314d75] function_b51c1cb9(eventstruct) {
  level dorattle(eventstruct.position, eventstruct.weapon.soundrattlerangemin, eventstruct.weapon.soundrattlerangemax);
}

function weapon_butt_sounds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.meleed = 1;
    level.mysnd = playSound(fieldname, #"chr_melee_tinitus", (0, 0, 0));
    return;
  }

  self.meleed = 0;

  if(isDefined(level.mysnd)) {
    stopsound(level.mysnd);
  }
}

function sndmatchsnapshot(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(sessionmodeiswarzonegame()) {
    return;
  }

  if(bwastimejump) {
    switch (bwastimejump) {
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

function sndkillcam() {
  level thread sndfinalkillcam_slowdown();
  level thread sndfinalkillcam_deactivate();
}

function snddeath_activate() {
  while(true) {
    level waittill(#"sndded");
    snd_set_snapshot("mpl_death");
  }
}

function snddeath_deactivate() {
  while(true) {
    level waittill(#"snddede");
    snd_set_snapshot("default");
  }
}

function sndfinalkillcam_activate() {
  while(true) {
    level waittill(#"sndfks");
  }
}

function sndfinalkillcam_slowdown() {
  while(true) {
    level waittill(#"sndfksl");
  }
}

function sndfinalkillcam_deactivate() {
  while(true) {
    level waittill(#"sndfke");
    snd_set_snapshot("default");
  }
}

function sndswitchvehiclecontext(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self)) {
    return;
  }

  if(self isvehicle() && self function_4add50a7()) {
    setsoundcontext("plr_impact", "vehicle");
    return;
  }

  setsoundcontext("plr_impact", "flesh");
}

function sndmusicdeathwatcher() {
  self waittill(#"death");
}

function sndcchacking(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    switch (bwastimejump) {
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

  if(fieldname == 1) {
    playSound(0, #"gdt_cybercore_hack_success_plr", (0, 0, 0));
    return;
  }

  if(fieldname == 2) {
    playSound(0, #"gdt_cybercore_activate_fail_plr", (0, 0, 0));
  }
}

function sndigcsnapshot(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    switch (bwastimejump) {
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

function sndlevelstartsnapoff(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(is_true(level.sndigcsnapshotoverride)) {}
  }
}

function sndzmbfadein(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    snd_set_snapshot("default");
  }
}

function sndchyronloop(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
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

function function_aa906715() {
  self endon(#"death", #"disconnect", #"game_ended");

  if(self function_21c0fa55() && sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    self.var_e4acdf73 = 0;
    var_1b0c36cc = self battlechatter::get_player_dialog_alias("exertGasCough");
    var_7f9cdb4f = self battlechatter::get_player_dialog_alias("exertGasGag");
    var_78ca4238 = self battlechatter::get_player_dialog_alias("exertGasGasp");

    if(!(isDefined(var_7f9cdb4f) && isDefined(var_1b0c36cc) && isDefined(var_78ca4238))) {
      return;
    }

    while(true) {
      self waittill(#"hash_59dc3b94303bbeac");
      self thread function_f041ffdb(var_1b0c36cc, var_7f9cdb4f);
      self waittill(#"hash_71bef43cb9e9e9f4");
      self thread function_deedd8d0(var_78ca4238);
      wait 0.1;
    }
  }
}

function function_f041ffdb(var_1b0c36cc, var_7f9cdb4f) {
  self endon(#"death", #"hash_71bef43cb9e9e9f4");

  if(isDefined(self)) {
    self.var_7c77614c = gettime();
    self thread function_5e73e105(var_1b0c36cc, var_7f9cdb4f);
  }
}

function function_5e73e105(var_1b0c36cc, var_7f9cdb4f) {
  self endon(#"death", #"disconnect", #"game_ended", #"hash_71bef43cb9e9e9f4");
  self.var_e4acdf73 = 1;

  while(true) {
    randomchance = randomfloatrange(0, 1);

    if(randomchance < 0.8) {
      self playSound(0, var_1b0c36cc);
    } else {
      self playSound(0, var_7f9cdb4f);
    }

    wait randomfloatrange(1.5, 3.5);
  }
}

function function_deedd8d0(var_78ca4238) {
  self endon(#"death", #"hash_59dc3b94303bbeac");

  if(self.var_e4acdf73 && self.var_7c77614c + float(3) / 1000 > gettime()) {
    self playSound(0, var_78ca4238);
    self.var_e4acdf73 = 0;
  }
}

function sndsprintbreath(localclientnum) {
  self endon(#"death");

  if(self function_21c0fa55() && sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    self.var_29054134 = 0;
    var_63112f76 = self battlechatter::get_player_dialog_alias("exertBreatheSprinting");
    var_dfb6f570 = self battlechatter::get_player_dialog_alias("exertBreatheSprintingEnd");

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

function sndbreathstart(sound) {
  self endon(#"hash_4e899fa9b2775b4d");
  self endon(#"death");
  self waittill(#"hash_1d827c5a5cd4a607");

  if(isDefined(self)) {
    self thread function_d6bc7279(sound);
  }
}

function function_d6bc7279(sound) {
  self endon(#"death");
  self endon(#"hash_4e899fa9b2775b4d");
  self.var_29054134 = 1;

  while(true) {
    self playSound(0, sound);
    wait 2.5;
  }
}

function function_ee6d1a7f(sound) {
  self endon(#"death");
  self waittill(#"hash_4e899fa9b2775b4d");

  if(self.var_29054134) {
    self playSound(0, sound);
    self.var_29054134 = 0;
  }
}

function function_5da61577(localclientnum) {
  self endon(#"death");

  if(isDefined(self)) {
    self thread function_bd07593a();
  }
}

function function_bd07593a() {
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

function sndvehicledamagealarm(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify(#"sndvehicledamagealarm");
  self thread function_350920b9();
}

function function_350920b9() {
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

function function_31468a30(scriptstruct) {
  soundloop = scriptstruct.var_b6ce262a;

  if(isDefined(level.loopers)) {
    for(i = 0; i < level.loopers.size; i++) {
      if(!isDefined(level.loopers[i].script_sound)) {
        level.loopers[i].origin = soundloop.origin;
        level.loopers[i].script_sound = soundloop.script_sound;
        level.loopers[i] thread soundloopthink();
        return;
      }
    }

    index = level.loopers.size;
    arrayinsert(level.loopers, soundloop, index);
    level.loopers[index].angles = undefined;
    level.loopers[index].script_label = undefined;
    level.loopers[index] thread soundloopthink();
  }
}

function event_handler[event_2df6ae0f] function_5470fa95(scriptstruct) {
  soundloop = scriptstruct.var_b6ce262a;

  if(isDefined(level.loopers)) {
    index = scriptstruct.index;

    if(index >= 0 && index < level.loopers.size) {
      soundstoploopemitter(soundloop.script_sound, soundloop.origin);
      level.loopers[index].origin = (0, 0, 0);
      level.loopers[index].script_sound = undefined;
    }
  }
}

function event_handler[event_7a92af95] function_3fda4bf4(scriptstruct) {
  soundloop = scriptstruct.var_b6ce262a;

  if(isDefined(level.loopers) && isDefined(soundloop) && isDefined(soundloop.script_sound) && isDefined(soundloop.script_looping)) {
    index = scriptstruct.index;

    if(index >= 0 && index < level.loopers.size) {
      level.loopers[index].origin = soundloop.origin;
      level.loopers[index].script_sound = soundloop.script_sound;
      level.loopers[index].script_looping = soundloop.script_looping;
      function_f03b7c11(index, level.loopers[index].script_sound, level.loopers[index].origin);
      return;
    }

    if(index == -2) {
      function_31468a30(scriptstruct);
    }
  }
}

function event_handler[event_5295e5ef] function_882b5910(scriptstruct) {
  soundloop = scriptstruct.var_b6ce262a;
  level.var_7acea05a = -1;

  if(isDefined(level.loopers)) {
    for(i = 0; i < level.loopers.size; i++) {
      if(distancesquared(level.loopers[i].origin, soundloop.origin) < 1) {
        level.var_7acea05a = i;
        return;
      }
    }
  }
}

function function_4fb7ec9c(scriptstruct) {
  var_2f7118b0 = scriptstruct.var_b6ce262a;

  if(isDefined(level.lineemitters)) {
    for(i = 0; i < level.lineemitters.size; i++) {
      if(!isDefined(level.lineemitters[i].script_sound)) {
        level.lineemitters[i].origin = var_2f7118b0.origin;
        level.lineemitters[i].script_sound = var_2f7118b0.script_sound;
        level.lineemitters[i].target = var_2f7118b0.target;
        level.lineemitters[i] thread soundlinethink();
        return;
      }
    }

    index = level.lineemitters.size;
    arrayinsert(level.lineemitters, var_2f7118b0, index);
    level.lineemitters[index].angles = undefined;
    level.lineemitters[index].script_label = undefined;
    level.lineemitters[index] thread soundlinethink();
  }
}

function event_handler[event_f61e7d0a] function_bbc6b84a(scriptstruct) {
  var_2f7118b0 = scriptstruct.var_b6ce262a;

  if(isDefined(level.lineemitters)) {
    index = scriptstruct.index;

    if(index >= 0 && index < level.lineemitters.size) {
      target = struct::get(level.lineemitters[index].target, "<dev string:x25f>");
      soundstoplineemitter(level.lineemitters[index].script_sound, level.lineemitters[index].origin, target.origin);
      level.lineemitters[index].origin = (0, 0, 0);
      level.lineemitters[index].script_sound = undefined;
    }
  }
}

function event_handler[event_70cd2720] function_4910c05b(scriptstruct) {
  var_2f7118b0 = scriptstruct.var_b6ce262a;

  if(isDefined(level.lineemitters) && isDefined(var_2f7118b0)) {
    index = scriptstruct.index;

    if(index >= 0 && index < level.lineemitters.size) {
      level.lineemitters[index].origin = var_2f7118b0.origin;
      level.lineemitters[index].script_sound = var_2f7118b0.script_sound;
      level.lineemitters[index].target = var_2f7118b0.target;
      target = struct::get(level.lineemitters[index].target, "<dev string:x25f>");

      if(isDefined(target)) {
        function_15b81494(index, level.lineemitters[index].script_sound, level.lineemitters[index].origin, target.origin);
      }

      return;
    }

    if(index == -2) {
      function_4fb7ec9c(scriptstruct);
    }
  }
}

function event_handler[event_edffbf97] function_ee6f0c88(scriptstruct) {
  var_2f7118b0 = scriptstruct.var_b6ce262a;
  level.var_7acea05a = -1;

  if(isDefined(level.lineemitters)) {
    for(i = 0; i < level.lineemitters.size; i++) {
      if(distancesquared(level.lineemitters[i].origin, var_2f7118b0.origin) < 1) {
        level.var_7acea05a = i;
        return;
      }
    }
  }
}

function function_abd4ca1(scriptstruct) {
  soundrandom = scriptstruct.var_b6ce262a;

  if(isDefined(level.randoms)) {
    for(i = 0; i < level.randoms.size; i++) {
      if(!isDefined(level.randoms[i].script_sound)) {
        level.randoms[i].origin = soundrandom.origin;
        level.randoms[i].script_sound = soundrandom.script_sound;
        level.randoms[i] thread soundrandom_thread(0, level.randoms[i]);
        return;
      }
    }

    index = level.randoms.size;
    arrayinsert(level.randoms, soundrandom, index);
    level.randoms[index].angles = undefined;
    level.randoms[index].script_label = undefined;
    level.randoms[index] thread soundrandom_thread(0, level.randoms[index]);
  }
}

function event_handler[event_bfb86175] function_464598c8(scriptstruct) {
  soundrandom = scriptstruct.var_b6ce262a;

  if(isDefined(level.randoms)) {
    index = scriptstruct.index;

    if(index >= 0 && index < level.randoms.size) {
      function_dac8758d(level.randoms[index].origin);
      level.randoms[index].origin = (0, 0, 0);
      level.randoms[index].script_sound = undefined;
    }
  }
}

function event_handler[event_43494658] function_12dface6(scriptstruct) {
  soundrandom = scriptstruct.var_b6ce262a;

  if(isDefined(level.randoms)) {
    index = scriptstruct.index;
    neworigin = scriptstruct.neworigin;

    if(index >= 0 && index < level.randoms.size) {
      if(isDefined(soundrandom.script_wait_min)) {
        level.randoms[index].script_wait_min = soundrandom.script_wait_min;
      }

      if(isDefined(soundrandom.script_wait_max)) {
        level.randoms[index].script_wait_max = soundrandom.script_wait_max;
      }

      level.randoms[index].script_sound = soundrandom.script_sound;
      function_12dface6(level.randoms[index].origin, neworigin, level.randoms[index].script_sound, level.randoms[index].script_wait_min, level.randoms[index].script_wait_max);
      level.randoms[index].origin = neworigin;
      return;
    }

    if(index == -2) {
      scriptstruct.var_b6ce262a.origin = neworigin;
      function_abd4ca1(scriptstruct);
    }
  }
}

function event_handler[event_8c00f89] function_8673317e(scriptstruct) {
  soundrandom = scriptstruct.var_b6ce262a;
  level.var_7acea05a = -1;

  if(isDefined(level.randoms)) {
    for(i = 0; i < level.randoms.size; i++) {
      if(distancesquared(level.randoms[i].origin, soundrandom.origin) < 1) {
        level.var_7acea05a = i;
        return;
      }
    }
  }
}