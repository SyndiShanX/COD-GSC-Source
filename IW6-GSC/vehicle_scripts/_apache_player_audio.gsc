/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_apache_player_audio.gsc
****************************************************/

_precache() {
  _audio();
}

_init(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.owner = var_1;
  var_2.apache = var_0;
  return var_2;
}

_start() {
  thread start_player_apache_engine_audio();
}

_end() {
  var_0 = self.owner;
  var_0 notify("LISTEN_end_audio");
}

_destroy() {
  _end();
  common_scripts\utility::array_call(self.audio_entities, ::delete);
}

start_player_apache_engine_audio() {
  var_0 = self.owner;
  var_1 = self.apache;
  var_0 endon("LISTEN_end_audio");
  self.lowspeed_start_crossfade = 29.0;
  self.lowspeed_end_crossfade = 55.0;
  self.low_speed_mult = 1.0;
  self.highspeed_start_crossfade = 18.0;
  self.highspeed_end_crossfade = 65.0;
  self.high_speed_mult = 1.0;
  self.overall_pitch_min = 0.9661;
  self.overall_pitch_max = 1.0299;
  self.overall_pitch = 1.0;
  self.overall_pitch_roll_modifier = 1.0;
  self.overall_pitch_roll_modifier_max = 0.023;
  self.roll_start_crossfade = 3.0;
  self.roll_end_crossfade = 30.0;
  self.roll_max_roll = 35.0;
  self.roll_mult = 1.0;
  self.roll_other_mult = 1.0;
  self.audio_entities = [];
  self.audio_entities["low_front"] = spawn("script_origin", var_0.origin);
  self.audio_entities["low_front"] linkto(var_0);
  self.audio_entities["low_front"] playLoopSound("apache_int_slow_fronts");
  self.audio_entities["low_rear"] = spawn("script_origin", var_0.origin);
  self.audio_entities["low_rear"] linkto(var_0);
  self.audio_entities["high_front"] = spawn("script_origin", var_0.origin);
  self.audio_entities["high_front"] linkto(var_0);
  self.audio_entities["high_front"] playLoopSound("apache_int_fast_fronts");
  self.audio_entities["high_rear"] = spawn("script_origin", var_0.origin);
  self.audio_entities["high_rear"] linkto(var_0);
  self.audio_entities["high_bank_front"] = spawn("script_origin", var_0.origin);
  self.audio_entities["high_bank_front"] linkto(var_0);
  self.audio_entities["high_bank_front"] playLoopSound("apache_int_bank_fronts");
  self.audio_entities["high_bank_rear"] = spawn("script_origin", var_0.origin);
  self.audio_entities["high_bank_rear"] linkto(var_0);

  for(;;) {
    self.audio_speed = var_1 vehicle_getspeed();
    self.audio_roll = abs(var_1.angles[2]);
    adjust_overall_apache_pitches();
    childthread adjust_helo_sound_roll();
    childthread adjust_helo_sound_low();
    childthread adjust_helo_sound_high();
    wait 0.1;
  }
}

adjust_overall_apache_pitches() {
  self.overall_pitch_roll_modifier = 1.0 - abs(self.audio_speed) / 115.0 * (abs(self.audio_roll) / 35.0) * self.overall_pitch_roll_modifier_max;

  if(abs(self.audio_speed) < self.highspeed_end_crossfade) {
    self.overall_pitch = self.overall_pitch_roll_modifier * (abs(self.audio_speed) / self.highspeed_end_crossfade * (self.overall_pitch_max - self.overall_pitch_min) + self.overall_pitch_min);
  } else {
    self.overall_pitch = self.overall_pitch_max * self.overall_pitch_roll_modifier;
  }
}

adjust_helo_sound_low() {
  if(abs(self.audio_speed) <= self.lowspeed_start_crossfade) {
    self.low_speed_mult = self.roll_other_mult * 1.0;
  } else if(abs(self.audio_speed) < self.lowspeed_end_crossfade) {
    self.low_speed_mult = self.roll_other_mult * (1.0 - (abs(self.audio_speed) - self.lowspeed_start_crossfade) / (self.lowspeed_end_crossfade - self.lowspeed_start_crossfade));
  } else {
    self.low_speed_mult = 0.005;
  }

  self.audio_entities["low_front"] scalepitch(self.overall_pitch, 0.1);
  self.audio_entities["low_front"] scalevolume(self.low_speed_mult, 0.1);
}

adjust_helo_sound_high() {
  if(abs(self.audio_speed) >= self.highspeed_end_crossfade) {
    self.high_speed_mult = self.roll_other_mult * 1.0;
  } else if(abs(self.audio_speed) > self.highspeed_start_crossfade) {
    self.high_speed_mult = self.roll_other_mult * (1.0 - (self.highspeed_end_crossfade - abs(self.audio_speed)) / (self.highspeed_end_crossfade - self.highspeed_start_crossfade));
  } else {
    self.high_speed_mult = 0.005;
  }

  self.audio_entities["high_front"] scalepitch(self.overall_pitch, 0.1);
  self.audio_entities["high_front"] scalevolume(self.high_speed_mult, 0.1);
}

adjust_helo_sound_roll() {
  if(abs(self.audio_roll) >= self.roll_end_crossfade) {
    self.roll_mult = 1.0;
    self.roll_other_mult = 0.001;
  } else if(abs(self.audio_roll) >= self.roll_start_crossfade) {
    self.roll_mult = 1.0 - (self.roll_end_crossfade - abs(self.audio_roll)) / (self.roll_end_crossfade - self.roll_start_crossfade);
    self.roll_other_mult = 1.0 * ((self.roll_end_crossfade - abs(self.audio_roll)) / (self.roll_end_crossfade - self.roll_start_crossfade));
  } else {
    self.roll_mult = 0.001;
    self.roll_other_mult = 1.0;
  }

  self.audio_entities["high_bank_front"] scalepitch(self.overall_pitch, 0.1);
  self.audio_entities["high_bank_front"] scalevolume(self.roll_mult, 0.1);
}