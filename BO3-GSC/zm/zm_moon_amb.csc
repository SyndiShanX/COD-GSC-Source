/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_moon_amb.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\zm\zm_moon_fx;
#namespace zm_moon_amb;

function main() {
  level._sndambientstatecallback = & function_93c8dd7;
  level.audio_zones_breached = [];
  level.audio_zones_breached["1"] = 0;
  level.audio_zones_breached["2a"] = 0;
  level.audio_zones_breached["2b"] = 0;
  level.audio_zones_breached["3a"] = 0;
  level.audio_zones_breached["3b"] = 0;
  level.audio_zones_breached["3c"] = 0;
  level.audio_zones_breached["4a"] = 0;
  level.audio_zones_breached["4b"] = 0;
  level.audio_zones_breached["5"] = 0;
  level.audio_zones_breached["6"] = 0;
  level thread setup_airless_ambient_packages();
  level thread teleporter_audio_sfx();
  level thread zone_alarms_setup();
  level thread ambience_randoms();
  level thread snd_start_autofx_audio();
  level thread function_c9207335();
  level thread function_d19cb2f8();
  clientfield::register("allplayers", "beam_fx_audio", 21000, 1, "counter", & beam_fx_audio, 0, 0);
  clientfield::register("world", "teleporter_audio_sfx", 21000, 1, "counter", & teleporter_audio_sfx, 0, 0);
}

function function_c9207335() {
  wait(3);
  level thread function_d667714e();
  var_13a52dfe = getEntArray(0, "sndMusicTrig", "targetname");
  array::thread_all(var_13a52dfe, & function_60a32834);
}

function function_60a32834() {
  while(true) {
    self waittill("trigger", trigplayer);
    if(trigplayer islocalplayer()) {
      level notify("hash_51d7bc7c", self.script_sound);
      while(isDefined(trigplayer) && trigplayer istouching(self)) {
        wait(0.016);
      }
    } else {
      wait(0.016);
    }
  }
}

function function_d667714e() {
  level.var_b6342abd = "";
  level.var_6d9d81aa = "";
  level.var_eb526c90 = spawn(0, (0, 0, 0), "script_origin");
  level.var_9433cf5a = level.var_eb526c90 playLoopSound(level.var_b6342abd, 2);
  while(true) {
    level waittill("hash_51d7bc7c", location);
    level.var_6d9d81aa = "mus_moon_underscore_" + location;
    if(level.var_6d9d81aa != level.var_b6342abd) {
      level thread function_b234849(level.var_6d9d81aa);
      level.var_b6342abd = level.var_6d9d81aa;
    }
  }
}

function function_b234849(var_6d9d81aa) {
  level endon("hash_51d7bc7c");
  level.var_eb526c90 stopallloopsounds(2);
  wait(1);
  level.var_9433cf5a = level.var_eb526c90 playLoopSound(var_6d9d81aa, 2);
}

function snd_start_autofx_audio() {
  audio::snd_play_auto_fx("fx_moon_floodlight_wide", "amb_lights");
  audio::snd_play_auto_fx("fx_moon_floodlight_narrow", "amb_lights");
}

function ambience_randoms() {
  level waittill("power_on");
  array::thread_all(struct::get_array("amb_random_beeps", "targetname"), & play_random_beeps);
}

function play_random_beeps() {
  while(true) {
    playSound(0, "amb_random_beeps", self.origin);
    wait(randomintrange(10, 30));
  }
}

function zone_alarms_setup() {
  wait(5);
  array1 = struct::get_array("zone_alarm", "targetname");
  array2 = struct::get_array("zone_shakes", "targetname");
  if(!isDefined(array1) || !isDefined(array2)) {
    return;
  }
  array::thread_all(array1, & play_zone_alarms);
  array::thread_all(array2, & play_zone_shakes);
}

function play_zone_alarms() {
  level endon(("Dz" + self.script_noteworthy) + "e");
  self thread reset_alarms();
  level waittill("Dz" + self.script_noteworthy);
  while(true) {
    playSound(0, "evt_zone_alarm", self.origin);
    wait(2.8);
  }
}

function play_zone_shakes() {
  level endon(("Dz" + self.script_noteworthy) + "e");
  self thread reset_shakes();
  level waittill("Dz" + self.script_noteworthy);
  while(true) {
    playSound(0, "evt_digger_rattles_random", self.origin);
    wait(randomfloatrange(1.2, 2.3));
  }
}

function reset_alarms() {
  level waittill(("Dz" + self.script_noteworthy) + "e");
  wait(2);
  self thread play_zone_alarms();
}

function reset_shakes() {
  level waittill(("Dz" + self.script_noteworthy) + "e");
  wait(2);
  self thread play_zone_shakes();
}

function beam_fx_audio(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playSound(0, "evt_teleporter_beam_sfx", (0, 0, 0));
  exploder::exploder(122);
  exploder::exploder(132);
}

function teleporter_audio_sfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.click_array)) {
    level.click_array = struct::get_array("teleporter_click_sfx", "targetname");
  }
  if(!isDefined(level.warmup_array)) {
    level.warmup_array = struct::get_array("teleporter_warmup_sfx", "targetname");
  }
  array::thread_all(level.click_array, & play_teleporter_sounds);
  array::thread_all(level.warmup_array, & play_warmup_cooldown);
  exploder::exploder(121);
  exploder::exploder(131);
}

function play_teleporter_sounds() {
  level endon("cafx");
  wait(0.5);
  if(isDefined(self.script_int) && isDefined(self.script_noteworthy)) {
    val = int(self.script_noteworthy) / 2;
    wait(val);
    playSound(0, "evt_teleporter_click_" + self.script_noteworthy, self.origin);
  }
}

function play_warmup_cooldown() {
  level endon("cafx");
  playSound(0, "evt_teleporter_warmup", self.origin);
  wait(2);
  playSound(0, "evt_teleporter_cooldown", self.origin);
}

function setup_zone_1_special() {
  level waittill("power_on");
  level reset_ambient_packages("1", 1);
  level reset_ambient_packages("2a", 1);
  level reset_ambient_packages("2b", 1);
  level reset_ambient_packages("3a", 1);
  level reset_ambient_packages("3b", 1);
  level reset_ambient_packages("3c", 1);
  level reset_ambient_packages("4a", 1);
  level reset_ambient_packages("4b", 1);
  level reset_ambient_packages("5", 1);
  level reset_ambient_packages("6", 1);
}

function setup_airless_ambient_packages() {
  wait(5);
  trigs = getEntArray(0, "ambient_package", "targetname");
  for(i = 0; i < trigs.size; i++) {
    if(isDefined(trigs[i].script_ambientroom)) {
      trigs[i] remember_old_verb(trigs[i].script_ambientroom);
    }
    trigs[i].first_time = 1;
  }
  level thread setup_zone_1_special();
}

function function_6ce4d731(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    level notify(fieldname);
    switch (fieldname) {
      case "Az1": {
        level thread reset_ambient_packages("1");
        level thread zm_moon_fx::breach_receiving_fx();
        break;
      }
      case "Az2a": {
        level thread reset_ambient_packages("2a");
        break;
      }
      case "Az2b": {
        level thread reset_ambient_packages("2b");
        break;
      }
      case "Az3a": {
        level thread reset_ambient_packages("3a");
        break;
      }
      case "Az3b": {
        level thread reset_ambient_packages("3b");
        break;
      }
      case "Az3c": {
        level thread reset_ambient_packages("3c");
        break;
      }
      case "Az4a": {
        level thread reset_ambient_packages("4a");
        level thread zm_moon_fx::breach_labs_lower_fx();
        break;
      }
      case "Az4b": {
        level thread reset_ambient_packages("4b");
        level thread zm_moon_fx::breach_labs_upper_fx();
        break;
      }
      case "Az5": {
        level thread reset_ambient_packages("5");
        break;
      }
    }
  }
}

function reset_ambient_packages(zone, poweron = 0) {
  if(isDefined(zone)) {
    trigs = getEntArray(0, "ambient_package", "targetname");
    zone_array = [];
    z = 0;
    for(i = 0; i < trigs.size; i++) {
      if(isDefined(trigs[i].script_noteworthy) && isDefined(trigs[i].script_ambientroom)) {
        if(trigs[i].script_noteworthy == zone) {
          if(poweron && !level.audio_zones_breached[zone]) {
            level.var_8aa493c0[trigs[i].script_ambientroom].var_b33e0a6 = trigs[i].script_string;
            zone_array[z] = trigs[i];
            z++;
            continue;
          }
          level.var_8aa493c0[trigs[i].script_ambientroom].var_b33e0a6 = "zmb_moon_bg_airless";
          zone_array[z] = trigs[i];
          z++;
        }
      }
    }
    players = getlocalplayers();
    for(i = 0; i < players.size; i++) {
      for(a = 0; a < zone_array.size; a++) {
        if(players[i] istouching(zone_array[a])) {
          if(!level.audio_zones_breached[zone]) {
            if(poweron) {
              players[i] playSound(0, "evt_air_repressurize");
              if(players[i] islocalplayer()) {
                level thread function_6b9d0090(zone_array[a].script_ambientroom);
              }
            } else if(!zone_array[a].first_time) {
              if(zone == "5") {
                players[i] playSound(0, "evt_dig_wheel_breakthrough_bio");
                if(players[i] islocalplayer()) {
                  level thread function_6b9d0090(zone_array[a].script_ambientroom);
                }
              } else if(zone == "2a" || zone == "2b" && !level.audio_zones_breached["2b"] || (zone == "3a" || zone == "3b" || zone == "3c" && !level.audio_zones_breached["3b"])) {
                players[i] playSound(0, "evt_dig_wheel_breakthrough");
                if(players[i] islocalplayer()) {
                  level thread function_6b9d0090(zone_array[a].script_ambientroom);
                }
              }
              players[i] playSound(0, "evt_air_release");
              if(players[i] islocalplayer()) {
                level thread function_6b9d0090(zone_array[a].script_ambientroom);
              }
            }
          }
        }
        zone_array[a].first_time = 0;
      }
    }
    if(!poweron) {
      level.audio_zones_breached[zone] = 1;
    }
  }
}

function remember_old_verb(name) {}

function function_93c8dd7(ambientroom, ambientpackage, roomcollidercent) {
  if(!isDefined(level.var_8aa493c0)) {
    level function_52553b46();
  }
  if(!isDefined(level.var_8aa493c0[ambientroom])) {
    return;
  }
  level thread function_6b9d0090(ambientroom);
}

function function_52553b46(ambientroom, e_trigger) {
  level.var_8aa493c0 = [];
  level.var_8aa493c0["space"] = spawnStruct();
  level.var_8aa493c0["space"].var_b33e0a6 = "zmb_moon_bg_airless";
  e_triggers = getEntArray(0, "ambient_package", "targetname");
  foreach(e_trigger in e_triggers) {
    level.var_8aa493c0[e_trigger.script_ambientroom] = spawnStruct();
    if(isDefined(e_trigger.script_string)) {
      if(isDefined(e_trigger.script_noteworthy)) {
        level.var_8aa493c0[e_trigger.script_ambientroom].var_b33e0a6 = "zmb_moon_bg_airless";
      } else {
        level.var_8aa493c0[e_trigger.script_ambientroom].var_b33e0a6 = e_trigger.script_string;
      }
      continue;
    }
    level.var_8aa493c0[e_trigger.script_ambientroom].var_b33e0a6 = undefined;
  }
}

function function_6b9d0090(ambientroom) {}

function function_d19cb2f8() {
  loopers = struct::get_array("exterior_goal", "targetname");
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

function soundloopthink() {
  if(!isDefined(self.origin)) {
    return;
  }
  if(!isDefined(self.script_sound)) {
    self.script_sound = "zmb_spawn_walla";
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
      } else {
        soundloopemitter(self.script_sound, self.origin);
      }
      started = !started;
    }
  }
}