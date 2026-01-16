/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_audio.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;

audio_init(localclientnum) {
  if(localclientnum == 0) {
    snd_snapshot_init();
    thread snd_snapshot_level_fadein();
    setglobalfutz("no_gfutz", 0.0);
    startsoundrandoms(localclientnum);
    startsoundloops();
    startlineemitters();
    thread bump_trigger_start();
    thread init_audio_step_triggers();
    thread init_audio_material_triggers();
    thread start_player_health_system();
    thread swimmingaudioambientsetup();
    thread waittoenableswimming();
    thread waittodisableswimming();
    thread oldmanwoods();
    thread clientvoicesetup();

    if(!isDefined(level.watersoundent))
      level.watersoundent = [];

    init_after_save_restore();
  }
}

clientvoicesetup() {
  player = getlocalplayers()[0];
  player.teamclientprefix = "vox_gen";
  thread sndvonotify("playerbreathinsound", "sinper_hold");
  thread sndvonotify("playerbreathoutsound", "sinper_exhale");
  thread sndvonotify("playerbreathgaspsound", "sinper_gasp");
}

sndvonotify(notifystring, dialog) {
  player = getlocalplayers()[0];

  for(;;) {
    player waittill(notifystring);
    soundalias = player.teamclientprefix + "_" + dialog;
    player playsound(0, soundalias);
  }
}

init_after_save_restore() {
  level waittill("save_restore");
  level thread audio_init(0);
}

snd_snapshot_init() {
  level._sndactivesnapshot = "default";

  if(!isDefined(level._sndnextsnapshot))
    level._sndnextsnapshot = "default";

  setgroupsnapshot(level._sndactivesnapshot);
  thread snd_snapshot_think();
  thread snd_snapshot_save();
}

snd_snapshot_save() {
  level waittill("save_restore");
  setgroupsnapshot(level._sndactivesnapshot);
}

snd_set_snapshot(state) {
  level._sndnextsnapshot = state;

  println("snd duck debug: set state '" + state + "'");

  level notify("new_bus");
}

snd_snapshot_think() {
  level endon("save_restore");

  for(;;) {
    if(level._sndactivesnapshot == level._sndnextsnapshot)
      level waittill("new_bus");

    if(level._sndactivesnapshot == level._sndnextsnapshot) {
      continue;
    }
    assert(isDefined(level._sndnextsnapshot));
    assert(isDefined(level._sndactivesnapshot));
    setgroupsnapshot(level._sndnextsnapshot);
    level._sndactivesnapshot = level._sndnextsnapshot;
  }
}

snd_snapshot_level_fadein() {
  for(;;) {
    setlevelfadesnapshot("cod_fadein", 1.0);
    waitforclient(0);
    wait 0.5;
    snapshot_value = 1.0;

    while(snapshot_value > 0.0) {
      snapshot_value = snapshot_value - 0.05;
      setlevelfadesnapshot("cod_fadein", snapshot_value);
      wait 0.02;
    }

    setlevelfadesnapshot("cod_fadein", 0.0);
    player = getlocalplayer(0);
    player waittill("respawn");
  }
}

soundrandom_thread(localclientnum, randsound) {
  level endon("save_restore");
  level.soundrandomsplay = 1;

  if(!isDefined(randsound.script_wait_min))
    randsound.script_wait_min = 1;

  if(!isDefined(randsound.script_wait_max))
    randsound.script_wait_max = 3;

  if(getdvarint(#"_id_0AEB127D") > 0)
    println("*** Client : SR ( " + randsound.script_wait_min + " - " + randsound.script_wait_max + ")");

  if(!isDefined(randsound.script_string) && isDefined(randsound.script_sound)) {
    createsoundrandom(randsound.origin, randsound.script_sound, randsound.script_wait_min, randsound.script_wait_max);
    return;
  }

  while(true) {
    wait(randomfloatrange(randsound.script_wait_min, randsound.script_wait_max));

    if(!isDefined(randsound.script_sound)) {
      println("ambient sound at " + randsound.origin + " has undefined script_sound");

    } else if(level.soundrandomsplay)
      playsound(localclientnum, randsound.script_sound, randsound.origin);

    if(getdvarint(#"_id_0AEB127D") > 0)
      print3d(randsound.origin, randsound.script_sound, vectorscale((0, 1, 0), 0.8), 1, 3, 45);

  }
}

create_sound_random(origin, alias, min_delay, max_delay) {
  if(isDefined(level.soundrandomsstarted)) {
    println(" *** : Soundrandom at " + origin + " playing " + alias + " cannot be added after audio has been inited.Skipping.");

    return;
  }

  if(!isDefined(level.user_created_soundrandoms))
    level.user_created_soundrandoms = [];

  sr = spawnstruct();
  sr.origin = origin;
  sr.script_sound = alias;
  sr.script_wait_min = min_delay;
  sr.script_wait_max = max_delay;
  level.user_created_soundrandoms[level.user_created_soundrandoms.size] = sr;
}

startsoundrandoms(localclientnum) {
  level.soundrandomsstarted = 1;
  randoms = getstructarray("random", "script_label");

  if(isDefined(level.user_created_soundrandoms))
    randoms = arraycombine(randoms, level.user_created_soundrandoms, 1, 0);

  if(isDefined(randoms) && randoms.size > 0) {
    println("*** Client : Initialising random sounds - " + randoms.size + " emitters.");

    nscriptthreadedrandoms = 0;

    for(i = 0; i < randoms.size; i++) {
      if(isDefined(randoms[i].script_scripted))
        nscriptthreadedrandoms++;
    }

    allocatesoundrandoms(randoms.size - nscriptthreadedrandoms);

    for(i = 0; i < randoms.size; i++)
      thread soundrandom_thread(localclientnum, randoms[i]);
  }
}

soundloopthink() {
  if(!isDefined(self.script_sound)) {
    return;
  }
  if(!isDefined(self.origin)) {
    return;
  }
  level endon("save_restore");
  notifyname = "";
  assert(isDefined(notifyname));

  if(isDefined(self.script_string))
    notifyname = self.script_string;

  assert(isDefined(notifyname));
  started = 1;

  if(isDefined(self.script_int))
    started = self.script_int != 0;

  if(started)
    soundloopemitter(self.script_sound, self.origin);

  if(notifyname != "") {
    println("starting loop notify");

    for(;;) {
      level waittill(notifyname);

      if(started) {
        soundstoploopemitter(self.script_sound, self.origin);
        level.soundrandomsplay = 0;
      } else {
        soundloopemitter(self.script_sound, self.origin);
        level.soundrandomsplay = 1;
      }

      started = !started;
    }
  } else {
  }
}

soundlinethink() {
  level endon("save_restore");

  if(!isDefined(self.target)) {
    return;
  }
  target = getstruct(self.target, "targetname");

  if(!isDefined(target)) {
    return;
  }
  notifyname = "";

  if(isDefined(self.script_string))
    notifyname = self.script_string;

  started = 1;

  if(isDefined(self.script_int))
    started = self.script_int != 0;

  if(started)
    soundlineemitter(self.script_sound, self.origin, target.origin);

  if(notifyname != "") {
    println("starting line notify");

    for(;;) {
      level waittill(notifyname);

      if(started)
        soundstoplineemitter(self.script_sound, self.origin, target.origin);
      else
        soundlineemitter(self.script_sound, self.origin, target.origin);

      started = !started;
    }
  } else {
  }
}

startsoundloops() {
  loopers = getstructarray("looper", "script_label");

  if(isDefined(loopers) && loopers.size > 0) {
    delay = 0;

    for(i = 0; i < loopers.size; i++) {
      loopers[i] thread soundloopthink();
      delay = delay + 1;

      if(delay % 20 == 0)
        wait 0.01;
    }
  }
}

startlineemitters() {
  lineemitters = getstructarray("line_emitter", "script_label");

  if(isDefined(lineemitters) && lineemitters.size > 0) {
    delay = 0;

    for(i = 0; i < lineemitters.size; i++) {
      lineemitters[i] thread soundlinethink();
      delay = delay + 1;

      if(delay % 20 == 0)
        wait 0.01;
    }
  }
}

init_audio_material_triggers() {
  waitforclient(0);
  materialtrigs = getentarray(0, "audio_material_trigger", "targetname");

  println("Client : " + materialtrigs.size + " audio_material_triggers.");

  array_thread(materialtrigs, ::audio_material_trigger);
}

audio_material_trigger(trig) {
  for(;;) {
    self waittill("trigger", trigplayer);
    self thread trigger_thread(trigplayer, ::trig_enter_audio_material_trigger, ::trig_leave_audio_material_trigger);
  }
}

trig_enter_audio_material_trigger(player) {
  if(!isDefined(player.inmaterialoverridetrigger))
    player.inmaterialoverridetrigger = 0;

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

init_audio_step_triggers() {
  waitforclient(0);
  trigs = getentarray(0, "audio_step_trigger", "targetname");

  println("Client : " + trigs.size + " audio_step_triggers.");

  array_thread(trigs, ::audio_step_trigger);
}

audio_step_trigger(trig) {
  level endon("save_restore");

  for(;;) {
    self waittill("trigger", trigplayer);
    self thread trigger_thread(trigplayer, ::trig_enter_audio_step_trigger, ::trig_leave_audio_step_trigger);
  }
}

trig_enter_audio_step_trigger(trigplayer) {
  if(isDefined(self.script_label)) {
    trigplayer.step_sound = self.script_label;
    trigplayer setsteptriggersound(self.script_label);
  }

  if(isDefined(self.script_sound) && trigplayer getmovementtype() == "sprint")
    self playsound(0, self.script_sound, self.origin, 9);
}

trig_leave_audio_step_trigger(trigplayer) {
  if(isDefined(self.script_noteworthy) && trigplayer getmovementtype() == "sprint")
    self playsound(0, self.script_noteworthy, self.origin, 9);

  trigplayer.step_sound = "null";
  trigplayer clearsteptriggersound();
}

bump_trigger_start() {
  bump_trigs = getentarray(0, "audio_bump_trigger", "targetname");

  for(i = 0; i < bump_trigs.size; i++)
    bump_trigs[i] thread thread_bump_trigger();
}

thread_bump_trigger() {
  self thread bump_trigger_listener();

  if(!isDefined(self.script_activated))
    self.script_activated = 1;

  for(;;) {
    self waittill("trigger", trigplayer);
    self thread trigger_thread(trigplayer, ::trig_enter_bump, ::trig_leave_bump);
  }
}

trig_enter_bump(ent) {
  volume = get_vol_from_speed(ent);

  if(isDefined(self.script_sound) && self.script_activated) {
    if(isDefined(self.script_noteworthy) && self.script_wait > volume)
      test_id = self playsound(0, self.script_noteworthy, self.origin, volume);

    if(!isDefined(self.script_wait) || self.script_wait <= volume)
      test_id = self playsound(0, self.script_sound, self.origin, volume);
  }
}

trig_leave_bump(ent) {
}

bump_trigger_listener() {
  if(isDefined(self.script_label)) {
    level waittill(self.script_label);
    self.script_activated = 0;
  }
}

start_player_health_system() {
  level endon("save_restore");
  wait 1;
  level setup_room_and_context();
  level.health_ambient_room_change = 0;
  max_health = getlocalclientmaxhealth(0);
  last_health = 0;
  health_snapshot = "cmn_dying_plr";
  level.tst_health = 0.0;
  level.tst_last_health = 0.0;
  level.tst_snap_value = 0;

  if(isDefined(level.playerhealthsystemoverride)) {
    level thread[[level.playerhealthsystemoverride]](0);
    return;
  }

  setsoundcontext("health", "full");
  sethealthsnapshot(health_snapshot, 1);

  for(;;) {
    wait 0.02;
    health = getlocalclienthealth(0);

    if(health > 40) {
      if(level.health_ambient_room_change) {
        setsoundcontext("health", "full");
        playsound(0, "chr_health_out", (0, 0, 0));
        deactivateambientroom(0, "health", 100);
        level.health_ambient_room_change = 0;
        level notify("pain_out");
      }

      health_scale = 0;
    } else {
      if(!level.health_ambient_room_change) {
        setsoundcontext("health", "half");
        playsound(0, "chr_health_in", (0, 0, 0));
        activateambientroom(0, "health", 100);
        level.health_ambient_room_change = 1;
      }

      health_scale = scale_speed(40, 0, 0, 1, health);
    }

    sethealthsnapshot(health_snapshot, health_scale);

    level.tst_health = health;
    level.tst_last_health = last_health;
    level.tst_snap_value = health_scale;
    last_health = health;

  }
}

setup_room_and_context() {
  declareambientroom("health");
  declareambientpackage("health");
  setambientroomtone("health", "chr_health_loop", 0.25, 1.5);
  setambientroomreverb("health", "shock_flashbang", 1, 1);
  setambientroomcontext("health", "ringoff_plr", "indoor");

  if(getlocalclienthealth(0) > 40)
    setsoundcontext("health", "full");
  else
    setsoundcontext("health", "half");
}

pain_pulse() {
  level endon("pain_out");

  while(true) {
    playsound(0, "chr_pain_pulse", (0, 0, 0));
    wait 0.3;
  }
}

print_health() {
  while(true) {
    wait 0.5;
    iprintlnbold("health_tst player last_health: " + level.tst_last_health + " player health: " + level.tst_health);
    iprintlnbold("health_tst value: " + level.tst_snap_value);
  }

}

scale_speed(x1, x2, y1, y2, z) {
  if(z < x1)
    z = x1;

  if(z > x2)
    z = x2;

  dx = x2 - x1;
  n = (z - x1) / dx;
  dy = y2 - y1;
  w = n * dy + y1;
  return w;
}

get_vol_from_speed(player) {
  min_vol = 0.1;
  speed = player getspeed();

  if(speed == 0)
    speed = 175;

  if(isDefined(level.footstep_vol_override))
    min_vol = 0.5;

  abs_speed = abs(int(speed));
  volume = scale_speed(21, 285, min_vol, 1, abs_speed);
  return volume;
}

closest_point_on_line_to_point(point, linestart, lineend) {
  self endon("end line sound");
  linemagsqrd = lengthsquared(lineend - linestart);
  t = ((point[0] - linestart[0]) * (lineend[0] - linestart[0]) + (point[1] - linestart[1]) * (lineend[1] - linestart[1]) + (point[2] - linestart[2]) * (lineend[2] - linestart[2])) / linemagsqrd;

  if(t < 0.0)
    self.origin = linestart;
  else if(t > 1.0)
    self.origin = lineend;
  else {
    start_x = linestart[0] + t * (lineend[0] - linestart[0]);
    start_y = linestart[1] + t * (lineend[1] - linestart[1]);
    start_z = linestart[2] + t * (lineend[2] - linestart[2]);
    self.origin = (start_x, start_y, start_z);
  }
}

playloopat(aliasname, origin) {
  soundloopemitter(aliasname, origin);
}

stoploopat(aliasname, origin, stopsoundalias) {
  soundstoploopemitter(aliasname, origin);

  if(isDefined(stopsoundalias))
    playsound(0, stopsoundalias, origin);
}

snd_add_exploder_alias(num, alias) {
  for(i = 0; i < level.createfxent.size; i++) {
    if(isDefined(level.createfxent[i].v["exploder"])) {
      if(level.createfxent[i].v["exploder"] == num)
        level.createfxent[i].v["soundalias"] = alias;
    }
  }
}

snd_play_auto_fx(fxid, alias, offsetx, offsety, offsetz, onground, area, threshold, alias_override) {
  if(isDefined(area)) {
    assert(isDefined(threshold), "must pass in a threshold when area is defined");
    assert(isDefined(alias_override), "must pass in alias_override when area is defined");
  }

  a_fx_id = [];
  a_fx_result_origin = [];

  for(i = 0; i < level.createfxent.size; i++) {
    if(level.createfxent[i].v["fxid"] == fxid) {
      if(isDefined(area))
        level.createfxent[i].soundentarea = area;

      a_fx_id[a_fx_id.size] = level.createfxent[i];
    }
  }

  if(isDefined(area)) {
    for(i = 0; i < a_fx_id.size; i++) {
      for(j = i + 1; j < a_fx_id.size; j++) {
        distance_square = distancesquared(a_fx_id[i].v["origin"], a_fx_id[j].v["origin"]);

        if(distance_square < area * area) {
          if(getdvarint(#"_id_0AEB127D") > 0) {
            n_dist = distance(a_fx_id[i].v["origin"], a_fx_id[j].v["origin"]);
            line(a_fx_id[i].v["origin"], a_fx_id[j].v["origin"], (1, 1, 1), 1, 0, 100000000);
            print3d(((a_fx_id[i].v["origin"][0] + a_fx_id[j].v["origin"][0]) / 2, (a_fx_id[i].v["origin"][1] + a_fx_id[j].v["origin"][1]) / 2, 10), n_dist, (1, 1, 1), 1, 1, 1000000000);
          }

          if(isDefined(a_fx_id[j].adjacent) && !isDefined(a_fx_id[i].adjacent)) {
            a_fx_id[i].adjacent = a_fx_id[j].adjacent;
            continue;
          }

          if(!isDefined(a_fx_id[i].adjacent)) {
            a_fx_id[i].adjacent = i;
            a_fx_id[j].adjacent = i;
            continue;
          }

          a_fx_id[j].adjacent = a_fx_id[i].adjacent;
        }
      }

      if(getdvarint(#"_id_0AEB127D") > 0) {
        if(isDefined(a_fx_id[i].adjacent)) {
          print3d(a_fx_id[i].v["origin"], a_fx_id[i].adjacent, (1, 1, 1), 1, 1, 100000000);
          continue;
        }

        print3d(a_fx_id[i].v["origin"], "single", (1, 1, 1), 1, 1, 100000000);
      }

    }

    size = a_fx_id.size;

    for(i = 0; i < size; i++) {
      a_temp_array = [];

      if(!isDefined(a_fx_id[i])) {
        continue;
      }
      if(!isDefined(a_fx_id[i].adjacent)) {
        n_new_array_index = a_fx_result_origin.size;
        a_fx_result_origin[n_new_array_index] = a_fx_id[i];
        a_fx_result_origin[n_new_array_index].origin = a_fx_id[i].v["origin"];
        a_fx_id[i] = undefined;
        continue;
      } else {
        a_temp_array[a_temp_array.size] = a_fx_id[i];
        a_fx_id[i] = undefined;
      }

      for(j = i + 1; j < size; j++) {
        if(!isDefined(a_fx_id[j])) {
          continue;
        }
        if(isDefined(a_fx_id[j].adjacent)) {
          if(a_fx_id[j].adjacent == a_temp_array[a_temp_array.size - 1].adjacent) {
            a_temp_array[a_temp_array.size] = a_fx_id[j];
            a_fx_id[j] = undefined;
          }
        }
      }

      if(a_temp_array.size > threshold) {
        x = 0;
        y = 0;
        z = 0;

        for(k = 0; k < a_temp_array.size; k++) {
          x = x + a_temp_array[k].v["origin"][0];
          y = y + a_temp_array[k].v["origin"][1];
          z = z + a_temp_array[k].v["origin"][2];
        }

        x = x / a_temp_array.size;
        y = y / a_temp_array.size;
        z = z / a_temp_array.size;
        n_new_array_index = a_fx_result_origin.size;
        a_fx_result_origin[n_new_array_index] = spawnstruct();
        a_fx_result_origin[n_new_array_index].origin = (x, y, z);
        a_fx_result_origin[n_new_array_index].alias_override = 1;
        continue;
      }

      for(k = 0; k < a_temp_array.size; k++) {
        n_new_array_index = a_fx_result_origin.size;
        a_fx_result_origin[n_new_array_index] = spawnstruct();
        a_fx_result_origin[n_new_array_index].origin = a_temp_array[k].v["origin"];
      }
    }
  } else {
    for(i = 0; i < a_fx_id.size; i++) {
      n_new_array_index = a_fx_result_origin.size;
      a_fx_result_origin[n_new_array_index] = a_fx_id[i];
      a_fx_result_origin[n_new_array_index].origin = a_fx_id[i].v["origin"];
    }
  }

  for(i = 0; i < a_fx_result_origin.size; i++) {
    v_origin = a_fx_result_origin[i].origin;

    if(isDefined(offsetx) && offsetx != 0)
      v_origin = v_origin + (offsetx, 0, 0);

    if(isDefined(offsety) && offsety != 0)
      v_origin = v_origin + (0, offsety, 0);

    if(isDefined(offsetz) && offsetz != 0)
      v_origin = v_origin + (0, 0, offsetz);

    if(isDefined(onground) && onground) {
      trace = undefined;
      d = undefined;
      v_fxorigin = v_origin;
      trace = bullettrace(v_fxorigin, v_fxorigin - vectorscale((0, 0, 1), 100000.0), 0, undefined);
      d = distance(v_fxorigin, trace["position"]);
      v_origin = trace["position"];
    }

    if(!isDefined(a_fx_result_origin[i].alias_override)) {
      soundloopemitter(alias, v_origin);
      continue;
    }

    soundloopemitter(alias_override, v_origin);
  }
}

snd_delete_auto_fx(fxid) {
  for(i = 0; i < level.createfxent.size; i++) {
    if(level.createfxent[i].v["fxid"] == fxid && isDefined(level.createfxent[i].soundent)) {
      deletefakeent(0, level.createfxent[i].soundent);
      level.createfxent[i].soundent = undefined;
    }
  }
}

snd_print_fx_id(fxid, type, ent) {
  println("^5******* fxid; " + fxid + "^5 type; " + type);
}

debug_line_emitter() {
  while(true) {
    if(getdvarint(#"_id_0AEB127D") > 0) {
      line(self.start, self.end, (0, 1, 0));
      print3d(self.start, "START", vectorscale((0, 1, 0), 0.8), 1, 3, 1);
      print3d(self.end, "END", vectorscale((0, 1, 0), 0.8), 1, 3, 1);
      print3d(self.origin, self.script_sound, vectorscale((0, 1, 0), 0.8), 1, 3, 1);
    }

    wait 0.01;
  }

}

move_sound_along_line() {
  closest_dist = undefined;

  self thread debug_line_emitter();

  while(true) {
    self closest_point_on_line_to_point(getlocalclientpos(0), self.start, self.end);

    if(isDefined(self.fake_ent))
      setfakeentorg(self.localclientnum, self.fake_ent, self.origin);

    closest_dist = distancesquared(getlocalclientpos(0), self.origin);

    if(closest_dist > 1048576)
      wait 2;
    else if(closest_dist > 262144)
      wait 0.2;
    else
      wait 0.05;
  }
}

line_sound_player() {
  if(isDefined(self.script_looping)) {
    self.fake_ent = spawnfakeent(self.localclientnum);
    setfakeentorg(self.localclientnum, self.fake_ent, self.origin);
    playloopsound(self.localclientnum, self.fake_ent, self.script_sound);
  } else
    playsound(self.localclientnum, self.script_sound, self.origin);
}

soundwait(id) {
  while(soundplaying(id))
    wait 0.1;
}

waittoenableswimming() {
  while(true) {
    level waittill("aS_on");
    level thread enableswimmingaudio();
  }
}

waittodisableswimming() {
  while(true) {
    level waittill("aS_off");
    level thread disableswimmingaudio();
  }
}

enableswimmingaudio() {
  level thread enableswimmingaudioonplayer();
}

enableswimmingaudioonplayer() {
  player = getlocalplayers()[0];
  player thread swimmingaudiodepthcheck();
  player thread swimmingaudiodivesurface();
}

disableswimmingaudio() {
  level notify("disableSwimmingAudio");
  deactivateambientroom(0, "underwater", 50);
}

swimmingaudiodepthcheck() {
  self notify("aS_redundancy_depth");
  self endon("aS_redundancy_depth");
  self endon("death");
  level endon("disableSwimmingAudio");
  self._audioswim_dryland = 1;
  self._audioswim_underwater = 0;

  while(isDefined(self)) {
    depth = swimmingaudiogetdepth_eye();
    foot = swimmingaudiogetdepth_foot() + 12;

    if(foot < 0) {
      if(self._audioswim_dryland == 1) {
        self._audioswim_dryland = 0;
        self notify("aS_wetland");
      }
    } else if(self._audioswim_dryland == 0) {
      self._audioswim_dryland = 1;
      self notify("aS_dryland");
    }

    if(depth < 0) {
      if(self._audioswim_underwater == 0) {
        self._audioswim_underwater = 1;
        self notify("aS_underwater");
      }
    } else if(self._audioswim_underwater == 1) {
      self._audioswim_underwater = 0;
      self notify("aS_surface");
    }

    wait 0.25;
  }
}

swimmingaudiogetdepth_eye() {
  if(!isDefined(self)) {
    return;
  }
  eye_height = self get_eye()[2];
  water_height = getwaterheight(self.origin);
  return eye_height - water_height;
}

swimmingaudiogetdepth_foot() {
  if(!isDefined(self)) {
    return;
  }
  foot_height = self.origin[2];
  water_height = getwaterheight(self.origin);
  return foot_height - water_height;
}

swimmingaudiodivesurface() {
  self endon("death");
  level endon("disableSwimmingAudio");
  self notify("aS_redundancy_dive");
  self endon("aS_redundancy_dive");

  while(true) {
    self waittill("aS_underwater");
    activateambientroom(0, "underwater", 50);
    snd_set_snapshot("spl_cmn_underwater");
    self playsound(0, "chr_swimming_dive_start_plr");
    self playsound(0, "chr_ear_fill");
    self waittill("aS_surface");
    deactivateambientroom(0, "underwater", 50);
    snd_set_snapshot("default");
    self playsound(0, "chr_swimming_surface_plr");
    self playsound(0, "chr_ear_drain");
  }
}

swimmingaudioambientsetup() {
  declareambientroom("underwater");
  setambientroomtone("underwater", "chr_swimming_underwater_amb", 0.25, 0.1);
  setambientroomreverb("underwater", "gen_underwater", 1, 1, 1);
}

oldmanwoods() {
  level thread oldmanwoodsambientpackage();
  level thread oldmanwoodssnapshot_on();
  level thread oldmanwoodssnapshot_off();
}

oldmanwoodsambientpackage() {
  declareambientroom("omw_room");
  setambientroomtone("omw_room", "amb_omw_hospital__bg", 2, 2);
  setambientroomreverb("omw_room", "cmn_omw", 1, 1);
  setambientroomcontext("omw_room", "ringoff_plr", "indoor");
  declareambientpackage("omw_room");
}

oldmanwoodssnapshot_on() {
  while(true) {
    level waittill("omw_on");
    snd_set_snapshot("spl_oldmanwoods");
    activateambientpackage(0, "omw_room", 100);
    activateambientroom(0, "omw_room", 100);
  }
}

oldmanwoodssnapshot_off(string, snapshot) {
  while(true) {
    level waittill("omw_off");
    snd_set_snapshot("default");
    deactivateambientpackage(0, "omw_room", 100);
    deactivateambientroom(0, "omw_room", 100);
  }
}

rpgwhizbywatcher(rpg) {
  self endon("entityshutdown");
  self endon("death");
  level endon("save_restore");
  wait 0.2;
  self thread projectilewhizbydistancecheck(self, "wpn_rpg_whizby", 300);
}

projectilewhizbydistancecheck(projectile, alais, distance) {
  self endon("entityshutdown");
  self endon("death");
  level endon("save_restore");
  players = level.localplayers;

  while(isDefined(projectile)) {
    projectiledistance = distancesquared(projectile.origin, players[0].origin);

    if(projectiledistance <= distance * distance) {
      projectile playsound(0, alais);
      return;
    }

    wait 0.2;
  }
}

play_death_fire_loop() {
  level endon("save_restore");
  self waittill("death");
  playloopat("veh_onfire_fire_loop", self.origin);
  self thread stop_death_fire_loop(self.origin);
}

stop_death_fire_loop(origin) {
  level endon("save_restore");
  self waittill("entity_shutdown");
  stoploopat("veh_onfire_fire_loop", origin);
}

play_water_loop(loop, splash, maxspeed) {
  self endon("death");
  self endon("entityshutdown");
  self endon("exit_vehicle");
  newsoundent = spawn(0, self.origin, "script_origin");
  newsoundent linkto(self, "tag_origin", (0, 100, 100));
  level.watersoundent[level.watersoundent.size] = newsoundent;
  volume = 0.0;
  id = newsoundent playloopsound(loop);
  setsoundvolume(id, volume);

  while(true) {
    if(!isDefined(self)) {
      return;
    }
    wait 0.1;
    setsoundvolumerate(id, 0.75);
    self.cur_speed = abs(self getspeed() / 17.6);
    volume = scale_speed(0, maxspeed, 0.0, 1.0, self.cur_speed);

    if(self isvehicleinwater()) {
      if(isDefined(self.shouldplaysplash)) {
        self playsound(0, splash, self.origin, volume);
        self.shouldplaysplash = undefined;
      }

      setsoundvolume(id, volume);
    } else {
      setsoundvolume(id, 0);
      self.shouldplaysplash = 1;
    }
  }
}

cmnlevelfadeout(num) {
  if(isDefined(num))
    wait(num);

  snd_set_snapshot("cmn_fade_out");
}

timescaleon(num) {
  if(!isDefined(num))
    num = 1;

  soundtimescale(num);
}

timescaleoff() {
  soundtimescale(0);
}