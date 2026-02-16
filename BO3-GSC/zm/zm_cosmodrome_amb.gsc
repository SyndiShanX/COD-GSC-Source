/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_cosmodrome_amb.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_audio_zhd;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#namespace zm_cosmodrome_amb;

function main() {
  level._blackhole_bomb_valid_area_check = &function_a0f14d15;
  level thread function_5b4692c9();
  level thread monkey_round_announcer();
  level thread radio_easter_eggs();
  level thread function_7624a208();
  level thread init_redphone_eggs();
  level thread function_337aada8();
  level thread init_doll_eggs();
  level thread play_intro_music();
}

function play_intro_music() {
  level waittill("hash_fd9adc1e");
  level thread zm_audio::sndmusicsystem_playstate("round_start_first_lander");
}

function power_clangs() {
  clangs = struct::get_array("amb_power_clang", "targetname");
  for(i = 0; i < clangs.size; i++) {
    playsoundatposition("zmb_circuit", clangs[i].origin);
    wait(randomfloatrange(0.25, 0.7));
  }
}

function play_cosmo_announcer_vox(alias, alarm_override, wait_override) {
  if(!isDefined(alias)) {
    return;
  }
  if(!isDefined(level.cosmann_is_speaking)) {
    level.cosmann_is_speaking = 0;
  }
  if(!isDefined(alarm_override)) {
    alarm_override = 0;
  }
  if(!isDefined(wait_override)) {
    wait_override = 0;
  }
  if(level.cosmann_is_speaking == 0 && wait_override == 0) {
    level.cosmann_is_speaking = 1;
    if(!alarm_override) {
      level play_initial_alarm();
    }
    level zm_utility::really_play_2d_sound(alias);
    level.cosmann_is_speaking = 0;
  } else if(wait_override == 1) {
    level zm_utility::really_play_2d_sound(alias);
  }
}

function play_gersh_vox(alias) {
  if(!isDefined(alias)) {
    return;
  }
  if(!isDefined(level.gersh_is_speaking)) {
    level.gersh_is_speaking = 0;
  }
  if(level.gersh_is_speaking == 0) {
    level.gersh_is_speaking = 1;
    level zm_utility::really_play_2d_sound(alias);
    level.gersh_is_speaking = 0;
  }
}

function play_initial_alarm() {
  structs = struct::get_array("amb_warning_siren", "targetname");
  wait(1);
  for(i = 0; i < structs.size; i++) {
    playsoundatposition("evt_cosmo_alarm_single", structs[i].origin);
  }
  wait(0.5);
}

function monkey_round_announcer() {
  wait(3);
  while(true) {
    level flag::wait_till("monkey_round");
    level thread play_cosmo_announcer_vox("vox_ann_monkey_begin");
    level waittill("between_round_over");
    level thread play_cosmo_announcer_vox("vox_ann_monkey_end");
    wait(10);
  }
}

function radio_easter_eggs() {
  var_385d0c76 = struct::get_array("radio_egg", "targetname");
  array::thread_all(var_385d0c76, &function_5fd10b57);
}

function function_5fd10b57() {
  self zm_unitrigger::create_unitrigger();
  self waittill("trigger_activated");
  playsoundatposition("vox_radio_egg_" + self.script_int, self.origin);
}

function function_7624a208() {
  level thread zm_audio_zhd::function_e753d4f();
  level flag::wait_till("snd_song_completed");
  level thread zm_audio::sndmusicsystem_playstate("abracadavre");
}

function function_337aada8() {
  level.var_568da27 = 0;
  var_85d06ae4 = struct::get_array("egg_phone", "targetname");
  while(true) {
    level waittill("hash_b524a8eb");
    level.var_568da27++;
    if(level.var_568da27 == var_85d06ae4.size) {
      break;
    }
  }
  level notify("hash_2d7a77fa");
  level thread zm_audio::sndmusicsystem_playstate("not_ready_to_die");
}

function function_10544d8() {
  self endon("phone_activated");
  self endon("timeout");
  self.t_damage = spawn("trigger_damage", self.origin, 0, 5, 5);
  while(true) {
    self.t_damage waittill("damage", n_amount, e_attacker, dir, point, str_means_of_death);
    if(!zm_audio_zhd::function_8090042c()) {
      continue;
    }
    if(!isPlayer(e_attacker)) {
      continue;
    }
    if(str_means_of_death != "MOD_MELEE") {
      continue;
    }
    if(distancesquared(e_attacker.origin, self.origin) > 4225) {
      continue;
    }
    break;
  }
  self.broken = 1;
  self notify("hash_b524a8eb");
  if(isDefined(self.var_48df29fd)) {
    self.var_48df29fd delete();
  }
  level notify("hash_b524a8eb");
  playsoundatposition("zmb_redphone_destroy", self.origin);
  self.t_damage delete();
}

function init_redphone_eggs() {
  level endon("hash_2d7a77fa");
  var_85d06ae4 = struct::get_array("egg_phone", "targetname");
  var_a008170d = array(0, 1, 2, 3, 4, 5, 6, 7, 8);
  if(var_85d06ae4.size <= 0) {
    return;
  }
  var_693fabd9 = undefined;
  while(true) {
    wait(randomintrange(90, 240));
    while(true) {
      var_9d999891 = array::random(var_85d06ae4);
      arrayremovevalue(var_85d06ae4, var_9d999891);
      if(var_85d06ae4.size <= 0) {
        var_85d06ae4 = struct::get_array("egg_phone", "targetname");
      }
      if(isDefined(var_9d999891.broken) && var_9d999891.broken) {
        continue;
      }
      break;
    }
    activation = var_9d999891 function_de8ef595();
    if(isDefined(activation) && activation) {
      var_f1b4932d = array::random(var_a008170d);
      arrayremovevalue(var_a008170d, var_f1b4932d);
      if(var_a008170d.size <= 0) {
        var_a008170d = array(0, 1, 2, 3, 4, 5, 6, 7, 8);
      }
      playsoundatposition("vox_egg_redphone_" + var_f1b4932d, var_9d999891.origin);
      var_693fabd9 = var_f1b4932d;
      wait(30);
    }
  }
}

function function_de8ef595() {
  level endon("hash_2d7a77fa");
  self endon("hash_b524a8eb");
  self thread function_99199901();
  self thread function_d772340();
  self thread function_10544d8();
  self.var_a3f075d6 = 1;
  str_notify = self util::waittill_any_return("phone_activated", "timeout");
  self.var_a3f075d6 = 0;
  if(isDefined(self.t_damage)) {
    self.t_damage delete();
  }
  if(str_notify === "timeout") {
    return false;
  }
  return true;
}

function function_99199901() {
  level endon("hash_2d7a77fa");
  self endon("timeout");
  self endon("hash_b524a8eb");
  self.var_7f6e3a35 = spawn("trigger_radius", self.origin - vectorscale((0, 0, 1), 200), 0, 75, 400);
  self.var_48df29fd = spawn("script_origin", self.origin);
  self.var_48df29fd playLoopSound("zmb_egg_phone_loop", 0.05);
  while(true) {
    self.var_7f6e3a35 waittill("trigger", who);
    if(!isPlayer(who)) {
      wait(0.05);
      continue;
    }
    while(who istouching(self.var_7f6e3a35)) {
      if(who useButtonPressed()) {
        self notify("phone_activated");
        self.var_7f6e3a35 delete();
        self.var_48df29fd delete();
        return;
      }
      wait(0.05);
    }
  }
}

function function_d772340() {
  level endon("hash_2d7a77fa");
  self endon("phone_activated");
  self endon("hash_b524a8eb");
  wait(10);
  self notify("timeout");
  self.var_7f6e3a35 delete();
  self.var_48df29fd delete();
}

function init_doll_eggs() {
  wait(10);
  for(i = 0; i < 4; i++) {
    ent = getent("doll_egg_" + i, "targetname");
    if(!isDefined(ent)) {
      return;
    }
    ent thread doll_egg(i);
  }
}

function doll_egg(num) {
  if(!isDefined(self)) {
    return;
  }
  self usetriggerrequirelookat();
  self setcursorhint("HINT_NOICON");
  alias = undefined;
  while(true) {
    self waittill("trigger", player);
    index = zm_utility::get_player_index(player);
    switch (index) {
      case 0: {
        alias = ("vox_egg_doll_response_" + num) + "_0";
        break;
      }
      case 1: {
        alias = ("vox_egg_doll_response_" + num) + "_1";
        break;
      }
      case 3: {
        alias = ("vox_egg_doll_response_" + num) + "_2";
        break;
      }
      case 2: {
        alias = ("vox_egg_doll_response_" + num) + "_3";
        break;
      }
    }
    self playsoundwithnotify(alias, "sounddone" + alias);
    self waittill("sounddone" + alias);
    player zm_audio::create_and_play_dialog("weapon_pickup", "dolls");
    wait(8);
  }
}

function function_a0f14d15(grenade, model, player) {
  var_7d5605b7 = getent("sndzhdeggtrig", "targetname");
  if(!isDefined(var_7d5605b7)) {
    return false;
  }
  if(model istouching(var_7d5605b7)) {
    model clientfield::set("toggle_black_hole_deployed", 1);
    level thread function_61c7f9a3(grenade, model, var_7d5605b7);
    return true;
  }
  return false;
}

function function_5b4692c9() {
  var_7533f11 = struct::get_array("s_ballerina_bhb", "targetname");
  if(var_7533f11.size <= 0) {
    return;
  }
  var_ead6e450 = array::sort_by_script_int(var_7533f11, 1);
  foreach(var_6d450235 in var_ead6e450) {
    var_6d450235 function_2e4843da();
  }
  level flag::set("snd_zhdegg_activate");
  level._blackhole_bomb_valid_area_check = undefined;
}

function function_2e4843da() {
  self.var_ac086ffb = util::spawn_model(self.model, self.origin, self.angles);
  e_trig = spawn("trigger_radius", self.origin + (vectorscale((0, 0, -1), 120)), 0, 175, 200);
  e_trig.targetname = "sndzhdeggtrig";
  e_trig.s_target = self;
  e_trig waittill("hash_de264026");
  self.var_ac086ffb delete();
  e_trig delete();
}

function function_61c7f9a3(grenade, model, var_7d5605b7) {
  wait(1);
  time = 3;
  var_7d5605b7.s_target.var_ac086ffb moveto(grenade.origin + vectorscale((0, 0, 1), 50), time, time - 0.05);
  wait(time);
  playsoundatposition("zmb_gersh_teleporter_out", grenade.origin + vectorscale((0, 0, 1), 50));
  model delete();
  var_7d5605b7 notify("hash_de264026");
}