/*******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: soundscripts\_snd_playsound.gsc
*******************************************/

snd_play_linked(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = "oneshot";
  var_7 = undefined;
  var_8 = "3d";
  return sndx_play_alias(var_0, var_6, var_7, var_8, var_1, var_2, var_3, var_4, var_5);
}

snd_play_at(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = "oneshot";
  var_7 = var_1;
  var_8 = "3d";
  return sndx_play_alias(var_0, var_6, var_7, var_8, var_2, var_3, var_4, var_5);
}

snd_play_2d(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "oneshot";
  var_6 = undefined;
  var_7 = "2d";
  return sndx_play_alias(var_0, var_5, var_6, var_7, var_1, var_2, var_3, var_4);
}

snd_play_loop_linked(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = "loop";
  var_7 = undefined;
  var_8 = "3d";
  return sndx_play_alias(var_0, var_6, var_7, var_8, var_1, var_2, var_3, var_4, var_5);
}

snd_play_loop_at(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = "loop";
  var_7 = var_1;
  var_8 = "3d";
  return sndx_play_alias(var_0, var_6, var_7, var_8, var_2, var_3, var_4, var_5);
}

snd_play_loop_2d(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "loop";
  var_6 = undefined;
  var_7 = "2d";
  return sndx_play_alias(var_0, var_5, var_6, var_7, var_1, var_2, var_3, var_4);
}

snd_play_delayed_linked(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = "oneshot";
  var_9 = undefined;
  var_10 = "3d";
  return sndx_play_alias(var_0, var_8, var_9, var_10, var_3, var_4, var_5, var_6, var_7, var_1, var_2);
}

snd_play_delayed_at(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = "oneshot";
  var_9 = var_1;
  var_10 = "3d";
  return sndx_play_alias(var_0, var_8, var_9, var_10, var_4, var_5, var_6, var_7, (0, 0, 0), var_2, var_3);
}

snd_play_delayed_2d(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = "oneshot";
  var_8 = undefined;
  var_9 = "2d";
  return sndx_play_alias(var_0, var_7, var_8, var_9, var_3, var_4, var_5, var_6, (0, 0, 0), var_1, var_2);
}

snd_play_delayed_loop_linked(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = "loop";
  var_9 = undefined;
  var_10 = "3d";
  return sndx_play_alias(var_0, var_8, var_9, var_10, var_3, var_4, var_5, var_6, var_7, var_1, var_2);
}

snd_play_delayed_loop_at(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = "loop";
  var_9 = var_3;
  var_10 = "3d";
  return sndx_play_alias(var_0, var_8, var_9, var_10, var_4, var_5, var_6, var_7, (0, 0, 0), var_1, var_2);
}

snd_play_delayed_loop_2d(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = "loop";
  var_8 = undefined;
  var_9 = "2d";
  return sndx_play_alias(var_0, var_7, var_8, var_9, var_3, var_4, var_5, var_6, (0, 0, 0), var_1, var_2);
}

snd_play_set_cleanup_msg(var_0) {}

sndx_play_alias(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!soundexists(var_0)) {
    return;
  }
  var_12 = var_3 == "3d" && !isdefined(var_2);
  var_13 = self;

  if(!var_12)
    var_13 = level.player;

  if(!isdefined(var_13)) {
    return;
  }
  var_14 = var_13.origin;

  if(isdefined(var_2))
    var_14 = var_2;

  var_15 = spawn("script_origin", var_14);
  var_13 thread sndx_play_alias_thread(var_0, var_1, var_12, var_2, var_3, var_15, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  return var_15;
}

sndx_play_alias_thread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = self;
  var_14 = "sndx_play_alias_" + soundscripts\_snd::snd_new_guid();
  level endon(var_14);
  var_5 endon("death");
  var_6 = soundscripts\_audio::aud_get_optional_param(undefined, var_6);
  var_7 = soundscripts\_audio::aud_get_optional_param(0.0, var_7);
  var_8 = soundscripts\_audio::aud_get_optional_param(0.1, var_8);
  var_9 = soundscripts\_audio::aud_get_optional_param(1.0, var_9);
  var_10 = soundscripts\_audio::aud_get_optional_param((0, 0, 0), var_10);
  var_11 = soundscripts\_audio::aud_get_optional_param(0, var_11);
  var_12 = soundscripts\_audio::aud_get_optional_param(0, var_12);

  if(var_2) {
    var_15 = "tag_origin";

    if(isdefined(var_13.model) || var_13.model != "" || var_13 gettagindex(var_15) < 0)
      var_15 = "";

    var_5 linkto(var_13, var_15, var_10, (0, 0, 0));
    var_5 thread sndx_play_alias_monitor_linkdeath(var_8, var_14, var_13);
  }

  if(var_11 > 0) {
    if(var_12)
      soundscripts\_audio::aud_slomo_wait(var_11);
    else
      wait(var_11);
  }

  if(var_1 == "oneshot") {
    var_16 = "sounddone";
    var_17 = var_7;
    var_5 snd_play(var_0, var_16, var_17);
    var_5 thread sndx_play_alias_monitor_sounddone(0.05, var_14, var_16);
  } else
    var_5 snd_play_loop(var_0);

  var_5 scalevolume(0, 0);

  if(isstring(var_6))
    var_5 thread sndx_play_alias_monitor_stopnotify(var_8, var_14, var_6);

  var_5 scalevolume(var_9, var_7);
}

sndx_play_alias_monitor_linkdeath(var_0, var_1, var_2) {
  level endon(var_1);
  self endon("death");
  var_3 = self;
  var_2 waittill("death");
  var_3 thread sndx_play_alias_fade_delete(var_0, var_1);
}

sndx_play_alias_monitor_sounddone(var_0, var_1, var_2) {
  level endon(var_1);
  self endon("death");
  var_3 = self;
  var_3 waittill(var_2);
  var_3 thread sndx_play_alias_fade_delete(undefined, var_1);
}

sndx_play_alias_monitor_stopnotify(var_0, var_1, var_2) {
  level endon(var_1);
  self endon("death");
  var_3 = self;
  level waittill(var_2);
  var_3 thread sndx_play_alias_fade_delete(var_0, var_1);
}

sndx_play_alias_fade_delete(var_0, var_1) {
  level notify(var_1);
  var_2 = self;

  if(isdefined(var_2)) {
    if(isdefined(var_0)) {
      var_2 scalevolume(0, var_0);
      wait(var_0);
      waittillframeend;
    }

    if(isdefined(var_2))
      var_2 delete();
  }
}

snd_play(var_0, var_1, var_2) {
  if(soundexists(var_0)) {
    self.guid = soundscripts\_snd::snd_new_guid();
    self.snd_is_one_shot = 1;
    var_1 = soundscripts\_audio::aud_get_optional_param(undefined, var_1);
    var_2 = soundscripts\_audio::aud_get_optional_param(0, var_2);
    self playsound(var_0, var_1, 0, var_2);
  } else {}
}

snd_play_loop(var_0) {
  if(soundexists(var_0)) {
    if(!isdefined(self.snd_is_loop)) {
      self playloopsound(var_0);
      self.guid = soundscripts\_snd::snd_new_guid();
      self.snd_is_loop = 1;
    } else {

    }
  } else {}
}

snd_stop_sound() {
  if(isdefined(self.snd_is_one_shot)) {
    self.snd_is_one_shot = undefined;
    self stopsounds();
  } else if(isdefined(self.snd_is_loop)) {
    self.snd_is_loop = undefined;
    self stoploopsound();
    self notify("sounddone");
  }
}

snd_play_amb_loop(var_0, var_1, var_2, var_3) {
  if(soundexists(var_0)) {
    var_4 = 0.1;
    var_5 = spawn("script_origin", var_1);
    var_5 playloopsound(var_0);
    level waittill(var_2);

    if(isdefined(var_3))
      var_4 = var_3;

    if(isdefined(var_5)) {
      var_5 scalevolume(0, var_4);
      wait 0.05;
      var_5 delete();
      return;
    }
  } else {}
}