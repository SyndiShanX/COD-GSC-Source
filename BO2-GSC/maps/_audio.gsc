/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_audio.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_music;

main() {
  array_thread(getentarray("audio_sound_trigger", "targetname"), ::thread_sound_trigger);
  level.disablegenericdialog = 0;
  thread fadeinsound();
}

fadeinsound() {
  flag_wait("all_players_connected");
  get_players()[0] playsound("uin_transition_" + level.script);
  level thread battlechatter_on();
}

wait_until_first_player() {
  players = get_players();

  if(!isDefined(players[0]))
    level waittill("first_player_ready");
}

thread_sound_trigger() {
  self waittill("trigger");
  struct_targs = getstructarray(self.target, "targetname");
  ent_targs = getentarray(self.target, "targetname");

  if(isDefined(struct_targs)) {
    for(i = 0; i < struct_targs.size; i++) {
      if(!level.clientscripts) {
        if(!isDefined(struct_targs[i].script_sound)) {
          assertmsg("_audio::thread_sound_trigger(): script_sound is UNDEFINED! Aborting..." + struct_targs[i].origin);

          return;
        }

        struct_targs[i] thread spawn_line_sound(struct_targs[i].script_sound);
      }
    }
  }

  if(isDefined(ent_targs)) {
    for(i = 0; i < ent_targs.size; i++) {
      if(!isDefined(ent_targs[i].script_sound)) {
        assertmsg("_audio::thread_sound_trigger(): script_sound is UNDEFINED! Aborting... " + ent_targs[i].origin);

        return;
      }

      if(isDefined(ent_targs[i].script_label) && ent_targs[i].script_label == "random") {
        if(!level.clientscripts)
          ent_targs[i] thread static_sound_random_play(ent_targs[i]);

        continue;
      }

      if(isDefined(ent_targs[i].script_label) && ent_targs[i].script_label == "looper") {
        if(!level.clientscripts)
          ent_targs[i] thread static_sound_loop_play(ent_targs[i]);
      }
    }
  }
}

spawn_line_sound(sound) {
  startofline = self;

  if(!isDefined(startofline)) {
    assertmsg("_audio::spawn_line_sound(): Could not find start of line entity! Aborting...");

    return;
  }

  self.soundmover = [];
  endoflineentity = getstruct(startofline.target, "targetname");

  if(isDefined(endoflineentity)) {
    start = startofline.origin;
    end = endoflineentity.origin;
    soundmover = spawn("script_origin", start);
    soundmover.script_sound = sound;
    self.soundmover = soundmover;

    if(isDefined(self.script_looping))
      soundmover.script_looping = self.script_looping;

    if(isDefined(soundmover)) {
      soundmover.start = start;
      soundmover.end = end;
      soundmover line_sound_player();
      soundmover thread move_sound_along_line();
    } else {
      assertmsg("Unable to create line emitter script origin");

    }
  } else {
    assertmsg("_audio::spawn_line_sound(): Could not find end of line entity! Aborting...");

  }
}

line_sound_player() {
  self endon("end line sound");

  if(isDefined(self.script_looping))
    self playloopsound(self.script_sound);
  else
    self playsound(self.script_sound);
}

move_sound_along_line() {
  self endon("end line sound");
  wait_until_first_player();
  closest_dist = undefined;

  while(true) {
    self closest_point_on_line_to_point(get_players()[0].origin, self.start, self.end);

    if(getdvarint(#"_id_0AEB127D") > 0) {
      line(self.start, self.end, (0, 1, 0));
      print3d(self.start, "START", (1.0, 0.8, 0.5), 1, 3);
      print3d(self.end, "END", (1.0, 0.8, 0.5), 1, 3);
      print3d(self.origin, self.script_sound, (1.0, 0.8, 0.5), 1, 3);
    }

    closest_dist = distancesquared(get_players()[0].origin, self.origin);

    if(closest_dist > 1048576)
      wait 2;
    else if(closest_dist > 262144)
      wait 0.2;
    else
      wait 0.05;
  }
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

static_sound_random_play(soundpoint) {
  wait(randomintrange(1, 5));

  if(!isDefined(self.script_wait_min))
    self.script_wait_min = 1;

  if(!isDefined(self.script_wait_max))
    self.script_wait_max = 3;

  while(true) {
    wait(randomfloatrange(self.script_wait_min, self.script_wait_max));
    soundpoint playsound(self.script_sound);

    if(getdvarint(#"_id_0AEB127D") > 0)
      print3d(soundpoint.origin, self.script_sound, (1.0, 0.8, 0.5), 1, 3, 5);

  }
}

static_sound_loop_play(soundpoint) {
  self playloopsound(self.script_sound);

  if(getdvarint(#"_id_0AEB127D") > 0) {
    while(true) {
      print3d(soundpoint.origin, self.script_sound, (1.0, 0.8, 0.5), 1, 3, 5);
      wait 1;
    }
  }

}

get_number_variants(aliasprefix) {
  for(i = 0; i < 100; i++) {
    if(!soundexists(aliasprefix + "_" + i))
      return i;
  }
}

create_2d_sound_list(sound_alias) {
  player = getplayers();

  if(!isDefined(sound_alias)) {
    iprintlnbold("No Dialog Category Defined For This Action");

    return;
  }

  if(!isDefined(level.sound_alias)) {
    level.sound_alias = [];
    level.sound_alias_available = [];
    num_variants = get_number_variants(sound_alias);
    assert(num_variants > 0, "No variants found for category: " + sound_alias);

    for(i = 0; i < num_variants; i++)
      level.sound_alias[i] = sound_alias + "_" + i;
  }

  if(level.sound_alias_available.size <= 0)
    level.sound_alias_available = level.sound_alias;

  variation = random(level.sound_alias_available);
  arrayremovevalue(level.sound_alias_available, variation);
  player[0] playsound(variation, "sound_done");
  player[0] waittill("sound_done");
  level notify("2D_sound_finished");
}

switch_music_wait(music_state, waittime) {
  wait(waittime);
  setmusicstate(music_state);
}

missionfailwatcher() {
  level waittill("missionfailed");

  if(isDefined(level.missionfailsndspecial))
    [[level.missionfailsndspecial]]();

  self playsound("chr_death");
}

death_sounds() {
  self thread missionfailwatcher();
  self waittill("death");

  println("Sound : do death sound");

  self playsound("evt_player_death");
}

play_music_stinger_manual(alias, time) {
  wait(time);
  playsoundatposition(alias, (0, 0, 0));
}

playsoundatposition_wait(alias, position, time) {
  wait(time);
  playsoundatposition(alias, position);
}