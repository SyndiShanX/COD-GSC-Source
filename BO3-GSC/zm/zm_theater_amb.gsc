/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_theater_amb.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_audio_zhd;
#namespace zm_theater_amb;

function autoexec __init__sytem__() {
  system::register("zm_theater_amb", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "player_dust_mote", 21000, 1, "int");
}

function main() {
  level thread setup_power_on_sfx();
  level thread play_projecter_loop();
  level thread play_projecter_soundtrack();
  level thread setup_meteor_audio();
  level thread setup_radio_egg_audio();
  level thread sndzhd_knocker();
  array::thread_all(getEntArray("portrait_egg", "targetname"), &portrait_egg_vox);
  array::thread_all(getEntArray("location_egg", "targetname"), &location_egg_vox);
  level thread function_8d1c7be1();
  level thread amb_0_zombie();
  var_3a067a8d = struct::get_array("trap_electric", "targetname");
  foreach(s_trap in var_3a067a8d) {
    e_trap = getent(s_trap.script_noteworthy, "target");
    e_trap thread function_57a1070b();
  }
  level thread function_71554606();
  level.sndtrapfunc = &function_448d83df;
  level.b_trap_start_custom_vo = 1;
}

function amb_0_zombie() {
  level endon("hash_993b920d");
  wait(50);
  var_64ab0444 = getent("amb_0_zombie", "targetname");
  var_64ab0444 playLoopSound(var_64ab0444.script_label);
  wait(35);
  while(true) {
    int = randomintrange(0, 40);
    if(int == 10) {
      var_64ab0444 thread function_ae3642b4();
      level notify("hash_993b920d");
    }
    wait(10);
  }
}

function function_ae3642b4() {
  self stoploopsound(0.5);
  playsoundatposition(self.script_sound, self.origin);
}

function setup_power_on_sfx() {
  wait(5);
  sound_emitters = struct::get_array("amb_power", "targetname");
  level flag::wait_till("power_on");
  level thread play_evil_generator_audio();
  for(i = 0; i < sound_emitters.size; i++) {
    sound_emitters[i] thread play_emitter();
  }
}

function play_emitter() {
  wait(randomintrange(1, 3));
  playsoundatposition("amb_circuit", self.origin);
  wait(1);
  soundloop = spawn("script_origin", self.origin);
  soundloop playLoopSound(self.script_sound);
}

function play_evil_generator_audio() {
  playsoundatposition("zmb_switch_flip", (-482, 1261, 44));
  playsoundatposition("evt_flip_sparks_left", (-544, 1320, 32));
  playsoundatposition("evt_flip_sparks_right", (-400, 1320, 32));
  wait(2);
  playsoundatposition("evt_crazy_power_left", (-304, 1120, 344));
  wait(13);
  level notify("generator_done");
}

function play_projecter_soundtrack() {
  level waittill("generator_done");
  wait(20);
  speaker = spawn("script_origin", (32, 1216, 592));
  speaker playLoopSound("amb_projecter_soundtrack");
}

function play_projecter_loop() {
  level waittill("generator_done");
  projecter = spawn("script_origin", (-72, -144, 384));
  projecter playLoopSound("amb_projecter");
}

function setup_meteor_audio() {
  level thread function_1da885f0();
  level thread zm_audio_zhd::function_e753d4f();
  level flag::wait_till("snd_song_completed");
  level thread zm_audio::sndmusicsystem_playstate("115");
  wait(4);
  a_e_players = getplayers();
  a_e_players = array::randomize(a_e_players);
  a_e_players[0] thread zm_audio::create_and_play_dialog("eggs", "music_activate");
}

function function_1da885f0() {
  while(true) {
    level waittill("hash_9b53c751", e_player);
    n_variant = level.var_2a0600f - 1;
    if(n_variant < 0) {
      n_variant = 0;
    }
    if(isDefined(e_player)) {
      e_player thread zm_audio::create_and_play_dialog("eggs", "meteors", n_variant);
    }
  }
}

function function_71554606() {
  level flag::wait_till("start_zombie_round_logic");
  for(i = 0; i < level.players.size; i++) {
    level.players[i] clientfield::set_to_player("player_dust_mote", 1);
  }
}

function portrait_egg_vox() {
  if(!isDefined(self)) {
    return;
  }
  self usetriggerrequirelookat();
  self setcursorhint("HINT_NOICON");
  while(true) {
    self waittill("trigger", player);
    if(!(isDefined(player.isspeaking) && player.isspeaking)) {
      break;
    }
  }
  type = "portrait_" + self.script_noteworthy;
  player zm_audio::create_and_play_dialog("eggs", type);
}

function location_egg_vox() {
  self waittill("trigger", player);
  if(randomintrange(0, 101) >= 90) {
    type = "room_" + self.script_noteworthy;
    player zm_audio::create_and_play_dialog("eggs", type);
  }
}

function play_radio_egg(delay) {
  if(isDefined(delay)) {
    wait(delay);
  }
  if(isDefined(self.target)) {
    s_target = struct::get(self.target, "targetname");
    playsoundatposition("vox_kino_radio_" + level.radio_egg_counter, s_target.origin);
  } else {
    self playSound("vox_kino_radio_" + level.radio_egg_counter);
  }
  level.radio_egg_counter++;
}

function setup_radio_egg_audio() {
  wait(1);
  level.radio_egg_counter = 0;
  array::thread_all(getEntArray("audio_egg_radio", "targetname"), &radio_egg_trigger);
}

function radio_egg_trigger() {
  if(!isDefined(self)) {
    return;
  }
  self waittill("trigger", who);
  self thread play_radio_egg(undefined);
}

function function_8d1c7be1() {
  var_1e717ab1 = getent("alley_door2", "target");
  exploder::stop_exploder("lgt_exploder_crematorium_door");
  var_1e717ab1 waittill("door_opened");
  exploder::exploder("lgt_exploder_crematorium_door");
}

function function_57a1070b() {
  level flag::wait_till("power_on");
  str_exploder_name = self.target + "_flashes";
  while(true) {
    self waittill("trap_done");
    exploder::exploder(str_exploder_name);
  }
}

function function_448d83df(trap, b_start) {
  if(!(isDefined(b_start) && b_start)) {
    return;
  }
  player = trap.activated_by_player;
  if(isDefined(trap._trap_type) && trap._trap_type == "fire") {
    return;
  }
  player zm_audio::create_and_play_dialog("trap", "start");
}

function sndzhd_knocker() {
  var_8e7ce497 = getent("sndzhd_knocker", "targetname");
  if(!isDefined(var_8e7ce497)) {
    return;
  }
  while(true) {
    wait(randomintrange(60, 180));
    var_adc6a71a = level function_57f2b10e(var_8e7ce497);
    if(!(isDefined(var_adc6a71a) && var_adc6a71a)) {
      continue;
    }
    wait(1);
    var_adc6a71a = level function_57f2b10e(var_8e7ce497);
    if(!(isDefined(var_adc6a71a) && var_adc6a71a)) {
      continue;
    }
    wait(1);
    var_adc6a71a = level function_57f2b10e(var_8e7ce497);
    if(!(isDefined(var_adc6a71a) && var_adc6a71a)) {
      continue;
    }
    break;
  }
  level flag::set("snd_zhdegg_activate");
}

function function_57f2b10e(var_8e7ce497) {
  var_6140b6dd = level function_314be731();
  level function_5c13c705(var_6140b6dd, var_8e7ce497);
  success = level function_7f30e34a(var_6140b6dd, var_8e7ce497);
  return success;
}

function function_5c13c705(var_6140b6dd, var_8e7ce497) {
  for(var_918879b9 = 0; var_918879b9 < 3; var_918879b9++) {
    wait(1.5);
    for(n_count = 0; n_count < var_6140b6dd[var_918879b9]; n_count++) {
      var_8e7ce497 playSound("zmb_zhd_knocker_door");
      wait(0.75);
    }
  }
}

function function_7f30e34a(var_6140b6dd, var_8e7ce497) {
  level thread function_47cc6622(var_6140b6dd, var_8e7ce497);
  str_notify = util::waittill_any_return("zhd_knocker_success", "zhd_knocker_timeout");
  if(str_notify == "zhd_knocker_timeout") {
    var_8e7ce497 thread function_702e84d0();
    return false;
  }
  return true;
}

function function_47cc6622(var_6140b6dd, var_8e7ce497) {
  level endon("zhd_knocker_timeout");
  for(var_918879b9 = 0; var_918879b9 < 3; var_918879b9++) {
    level thread function_e497b291(3000);
    n_count = 0;
    while(n_count < var_6140b6dd[var_918879b9]) {
      var_8e7ce497 waittill("damage", damage, attacker, dir, loc, str_type, model, tag, part, weapon, flags);
      if(!isDefined(attacker) || !isplayer(attacker)) {
        continue;
      }
      if(isDefined(str_type) && str_type != "MOD_MELEE") {
        continue;
      }
      var_8e7ce497 playSound("zmb_zhd_knocker_plr");
      level notify("hash_a5e68e5c");
      n_count++;
      level thread function_e497b291(1000);
    }
    level thread function_4f9527ef(1000);
  }
  wait(0.05);
  level notify("zhd_knocker_success");
}

function function_e497b291(n_max) {
  level notify("hash_165b5152");
  level endon("hash_165b5152");
  level endon("hash_a5e68e5c");
  level endon("zhd_knocker_timeout");
  level endon("zhd_knocker_success");
  var_c9cd8e88 = gettime();
  n_max = n_max + var_c9cd8e88;
  while(gettime() < n_max) {
    wait(0.05);
  }
  level notify("zhd_knocker_timeout");
}

function function_4f9527ef(n_min) {
  level notify("hash_b0b21488");
  level endon("hash_b0b21488");
  level endon("zhd_knocker_timeout");
  level endon("zhd_knocker_success");
  var_c9cd8e88 = gettime();
  n_min = n_min + var_c9cd8e88;
  level waittill("hash_a5e68e5c");
  if(gettime() < n_min) {
    level notify("zhd_knocker_timeout");
  }
}

function function_314be731() {
  var_6140b6dd = array((1, 1, 5), (9, 3, 5), vectorscale((1, 1, 1), 6), (2, 4, 1), (1, 2, 1), (5, 3, 4), (3, 2, 1), (5, 1, 2), (1, 4, 3), (6, 2, 4));
  var_6140b6dd = array::randomize(var_6140b6dd);
  return var_6140b6dd[0];
}

function function_702e84d0() {
  for(n_count = 0; n_count < 6; n_count++) {
    self playSound("zmb_zhd_knocker_door");
    wait(0.25);
  }
}