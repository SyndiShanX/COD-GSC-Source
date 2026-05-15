/*********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\alien_kraken\_alien_kraken_melee.gsc
*********************************************************************/

main() {
  self endon("killanimscript");
  self scragentsetphysicsmode("noclip");
  var_0 = gettime();
  self scragentsetorientmode("face angle abs", self.angles);

  switch (self.melee_type) {
    case "emerge":
      emerge();
      break;
    case "submerge":
      submerge();
      break;
    case "charge":
      charge();
      break;
    case "heat":
      heat();
      break;
    case "smash":
      smash();
      break;
    case "posture":
      posture();
      break;
    case "death":
      death();
      break;
    default:
      break;
  }

  if(var_0 == gettime()) {
    wait 0.05;
  }

  self notify("melee_complete");
}

endscript() {}

charge() {
  level notify("dlc_vo_notify", "kraken_vo", "kraken_weak");
  common_scripts\utility::flag_clear("fx_kraken_water");

  foreach(var_1 in self.tentacles) {
    var_1 thread maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::retract();
  }

  var_3 = getsideanimstate("charge_");
  var_4 = "charge_complete";
  thread play_kraken_charge_sfx();
  playanim(var_3, 0);
  var_5 = level.alien_types[self.alien_type].attributes[self.stage]["charge_phase_duration"] * 1000.0;
  var_6 = gettime() + var_5;
  thread playloopanim(var_3, var_4);
  self setscriptablepartstate("body", "heat_charge_body_fx_01");
  thread maps\mp\agents\alien\alien_kraken\_alien_kraken::play_kraken_eyeglow1_fx();

  while(gettime() < var_6) {
    wait 0.05;
  }

  self.damage_multiplier = maps\mp\agents\alien\alien_kraken\_alien_kraken::getkrakendamagemultiplier();
  self.kraken_heated = 1;
  self notify(var_4);
}

play_kraken_charge_sfx() {
  wait 4;
  level.kraken playLoopSound("kraken_charge_loop_sfx");
}

stop_kraken_charge_sfx() {
  wait 5;
  level.kraken stoploopsound("kraken_charge_loop_sfx");
}

playloopanim(var_0, var_1) {
  self endon(var_1);
  self endon("end_loop_anim");

  for(;;) {
    playanim(var_0, 1);
  }
}

playheatanims(var_0) {
  var_1 = getsideanimstate("heat_");
  playanim(var_1, 0);
  playloopanim(var_1, var_0);
}

heat() {
  common_scripts\utility::flag_clear("fx_kraken_water");
  var_0 = level.alien_types[self.alien_type].attributes[self.stage]["heated_phase_health_threshold"];
  var_1 = level.alien_types[self.alien_type].attributes[self.stage]["heated_phase_damage_per_second"];
  var_2 = getent("heated_deck_01", "targetname");
  var_3 = getent("heated_deck_vfx_01", "targetname");
  var_4 = "heat_complete";
  thread stop_kraken_charge_sfx();
  thread playheatanims(var_4);
  thread warn_heat();

  foreach(var_6 in self.tentacles) {
    var_6 maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::teleportside(self.stage);
    var_6 thread maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::heat();
  }

  var_4 = "heat_complete";
  var_8 = getsideanimstate("heat_");
  playanim(var_8, 0);
  thread playloopanim(var_8, var_4);
  maps\mp\agents\alien\alien_kraken\_alien_kraken::waitforextendedtentacles();
  maps\mp\agents\alien\alien_kraken\_alien_kraken::setupheatedsmashvolume();
  thread heatedsmashmonitor(var_4, var_8);
  var_9 = gettime();
  thread heat_deck_fx(var_4);

  while(maps\mp\agents\alien\alien_kraken\_alien_kraken::gethealthratio() > var_0) {
    var_10 = gettime();

    if(var_10 - var_9 > 1000.0) {
      var_11 = (var_10 - var_9) / 1000.0 * var_1;
      var_12 = [];

      foreach(var_14 in level.kraken_safe_spot_volumes) {
        var_15 = var_14 getistouchingentities(level.players);
        var_12 = common_scripts\utility::array_combine(var_12, var_15);
      }

      foreach(var_18 in level.players) {
        if(common_scripts\utility::array_contains(var_12, var_18)) {
          continue;
        }
        var_18 dodamage(var_11, var_18.origin, self, self);
      }

      var_9 = var_10;
    }

    common_scripts\utility::waitframe();
  }

  maps\mp\agents\alien\alien_kraken\_alien_kraken::waitforidletentacles();

  foreach(var_6 in self.tentacles) {
    var_6 notify(var_4);
  }

  self notify(var_4);
  thread reset_deck_fx(var_2, var_3);
  thread maps\mp\agents\alien\alien_kraken\_alien_kraken::stop_kraken_eyeglow1_fx();
}

warn_heat() {
  wait 12;
  level notify("dlc_vo_notify", "kraken_vo", "warn_metal");
}

reset_deck_fx(var_0, var_1) {
  var_0 setscriptablepartstate("deck", "heated_deck_anim_out");
  wait 1.0;
  var_1 setscriptablepartstate("deck_steam", "normal");
}

heat_deck_fx(var_0) {
  self endon(var_0);
  var_1 = getent("heated_deck_01", "targetname");
  var_2 = getent("heated_deck_vfx_01", "targetname");
  var_1 setscriptablepartstate("deck", "heated_deck_anim_in");
  wait 1.0;
  thread heat_deck_sfx(var_0);

  for(;;) {
    var_2 setscriptablepartstate("deck_steam", "hot_1");
    wait 2.0;
    var_2 setscriptablepartstate("deck_steam", "hot_2");
    wait 2.0;
  }
}

heat_deck_sfx(var_0) {
  var_1 = common_scripts\utility::play_loopsound_in_space("krk_heat_loop", (-868, 7058, 1154));
  wait 0.02;
  var_2 = common_scripts\utility::play_loopsound_in_space("krk_heat_loop", (261, 8411, 1154));
  wait 0.02;
  var_3 = common_scripts\utility::play_loopsound_in_space("krk_heat_loop", (-788, 8388, 1154));
  wait 0.02;
  var_4 = common_scripts\utility::play_loopsound_in_space("krk_heat_loop", (330, 6988, 1154));
  self waittill(var_0);
  var_1 delete();
  wait 0.02;
  var_2 delete();
  wait 0.02;
  var_3 delete();
  wait 0.02;
  var_4 delete();
}

smash() {
  common_scripts\utility::flag_set("fx_kraken_water");
  var_0 = "smash";

  if(isDefined(level.kraken.anim_state_modifier)) {
    var_0 = var_0 + ("_" + level.kraken.anim_state_modifier);
  }

  level notify("dlc_vo_notify", "warn_kraken_attack");
  self.tentacles[self.smash_tentacle_name] thread maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::smash(self.smash_trigger);

  if(!self.posturing && !self.smashing) {
    var_1 = self getanimentrycount(var_0);
    var_2 = randomint(var_1);
    thread smashanimmonitor(var_0, var_2);
    playanim(var_0);
  }
}

smashanimmonitor(var_0, var_1) {
  self notify("smash_anim_monitor_start");
  self endon("smash_anim_monitor_start");
  self.smashing = 1;
  var_2 = self getanimentry(var_0, var_1);
  var_3 = getanimlength(var_2);
  wait(var_3);
  self.smashing = 0;
}

heatedsmashmonitor(var_0, var_1) {
  self endon(var_0);

  for(;;) {
    self waittill("smash_trigger_hit", var_2, var_3);
    attemptheatedsmashattack(var_2, var_3, var_0, var_1);
  }
}

attemptheatedsmashattack(var_0, var_1, var_2, var_3) {
  self.tentacles[var_1] thread runtentacleheatsmash(var_0, var_2);

  if(level.alien_types["kraken"].attributes[self.stage]["ship_side"] == "port") {
    self notify("end_loop_anim");
    playanim("heat_smash");
    thread playloopanim(var_3, var_2);
  }
}

runtentacleheatsmash(var_0, var_1) {
  self endon(var_1);
  maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::heatsmash(var_0);
}

playanim(var_0, var_1, var_2) {
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_0, var_1, var_0, "end", var_2);
}

posture() {
  common_scripts\utility::flag_set("fx_kraken_water");
  thread playpostureanim();
}

handleposturenotes(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "kra_posture":
      thread performroar();
      break;
    default:
      break;
  }
}

playpostureanim(var_0) {
  self notify("posture_anim_monitor_start");
  self endon("posture_anim_monitor_start");
  self.posturing = 1;
  playanim("posture", undefined, ::handleposturenotes);
  self.posturing = 0;
  maps\mp\alien\_utility::set_alien_emissive_default(1.0);
}

death() {
  thread kraken_death_music();

  foreach(var_1 in self.tentacles) {
    var_1 thread maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::death();
  }

  playanim("death", 0, ::handledeathnotetracks);
}

kraken_death_music() {
  wait 1;

  foreach(var_1 in level.players) {
    if(common_scripts\utility::flag("alien_music_playing")) {
      var_1 stoplocalsound("mp_suspense_01");
      var_1 stoplocalsound("mp_suspense_02");
      var_1 stoplocalsound("mp_suspense_03");
      var_1 stoplocalsound("mp_suspense_04");
      var_1 stoplocalsound("mp_suspense_05");
      var_1 stoplocalsound("mp_suspense_06");
      var_1 stoplocalsound("mus_alien_newwave");
      var_1 stoplocalsound("mus_alien_queen");
      common_scripts\utility::flag_clear("alien_music_playing");
    }

    if(!common_scripts\utility::flag("exfil_music_playing")) {
      level thread maps\mp\alien\_music_and_dialog::play_alien_music("mus_alien_dlc2_kraken_death");
    }
  }
}

handledeathnotetracks(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "fx_cleardeck_d":
      thread playeyedeathfx();
      maps\mp\alien\_utility::set_alien_emissive(1.0, 1.0);
      playFXOnTag(level._effect["kraken_blood_roar_emitter"], self, "TAG_EYE_throat");
      break;
    case "fx_roar_d":
      playFXOnTag(level._effect["kraken_blood_roar_gurgle"], self, "TAG_EYE_throat");
      break;
    case "fx_cough":
      break;
    case "fx_startfall":
      maps\mp\alien\_utility::set_alien_emissive(2.0, 0.0);
      break;
    case "fx_jawhit":
      break;
    case "fx_headhit":
      thread stopeyedeathfx();
      break;
    case "fx_startslide":
      break;
    case "tnt_lc_dth":
      level.kraken thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("tnt_lc_dth", "j_tentacle_08_ru", 16);
      break;
    case "tnt_rc_dth":
      level.kraken thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("tnt_rc_dth", "j_tentacle_08_lu", 7);
      break;
  }
}

playeyedeathfx() {
  wait 0.1;
  playFXOnTag(level._effect["kraken_eye_glow_01"], level.kraken, "tag_eye");
  wait 0.1;
  playFXOnTag(level._effect["kraken_back_glow_01"], level.kraken, "j_spineback_up");
}

stopeyedeathfx() {
  stopFXOnTag(level._effect["kraken_eye_glow_01"], level.kraken, "tag_eye");
  wait 0.1;
  stopFXOnTag(level._effect["kraken_back_glow_01"], level.kraken, "j_spineback_up");
}

emerge() {
  common_scripts\utility::flag_set("fx_kraken_water");
  var_0 = level.alien_types[self.alien_type].attributes[self.stage]["emerge_teleport_position"];
  var_1 = common_scripts\utility::getstruct(var_0, "targetname");
  self setorigin(var_1.origin);
  self setplayerangles(var_1.angles);
  self scragentsetorientmode("face angle abs", var_1.angles, var_1.angles);
  self show();

  if(self.stage == "stage_1") {
    level notify("dlc_vo_notify", "kraken_intro");
    playintroanim();
  } else {
    level notify("kraken_emerge_phase");
    playemergeanim();
  }

  self scragentsetgoalpos(self.origin);
  self scragentsetgoalradius(4096);
}

playintroanim() {
  var_0 = "intro";
  playanim(var_0, 0, ::handleemergenotetracks);
}

playemergeanim() {
  foreach(var_1 in self.tentacles) {
    thread extendtentacle(var_1, 1);
  }

  var_3 = "emerge_" + level.alien_types["kraken"].attributes[self.stage]["ship_side"];
  thread play_emerge_music();
  playanim(var_3, 0, ::handlereemergenotetracks);
}

handlereemergenotetracks(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "fx_cleardeck_star":
    case "fx_cleardeck_port":
      thread playjawwaterfx();
      thread playhelmetwaterfx();
      thread playpincerswaterfx();
      break;
    case "fx_roar_star":
    case "fx_roar_port":
      thread posture_emissive();
      break;
  }
}

play_emerge_music() {
  wait 1;

  foreach(var_1 in level.players) {
    if(common_scripts\utility::flag("alien_music_playing")) {
      var_1 stoplocalsound("mp_suspense_01");
      var_1 stoplocalsound("mp_suspense_02");
      var_1 stoplocalsound("mp_suspense_03");
      var_1 stoplocalsound("mp_suspense_04");
      var_1 stoplocalsound("mp_suspense_05");
      var_1 stoplocalsound("mp_suspense_06");
      var_1 stoplocalsound("mus_alien_newwave");
      var_1 stoplocalsound("mus_alien_queen");
      common_scripts\utility::flag_clear("alien_music_playing");
    }

    level thread maps\mp\alien\_music_and_dialog::play_alien_music("mus_alien_dlc2_kraken_reemerge");
  }
}

posture_emissive() {
  self endon("killanimscript");
  maps\mp\alien\_utility::set_alien_emissive(0.85, 1.0);

  foreach(var_1 in level.players) {
    if(isalive(var_1)) {
      var_1 shellshock("alien_kraken_emp", 3.0);
      earthquake(0.75, 1.0, var_1.origin, 100);
    }
  }

  wait 3.0;
  maps\mp\alien\_utility::set_alien_emissive_default(1.0);
}

handleemergenotetracks(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "fx_cleardeck":
      thread playpincerswaterfx();
      break;
    case "fx_breakright":
      break;
    case "fx_startsweepleft":
      playFXOnTag(level._effect["kraken_water_sweep_rt_emitter"], self, "TAG_EYE_SweepRight004");
      playFXOnTag(level._effect["kraken_water_sweep_rt_emitter"], self, "TAG_EYE_SweepRight005");
      break;
    case "fx_breakleft":
      break;
    case "fx_startsweepmiddle":
      playFXOnTag(level._effect["kraken_water_spray_emitter"], self, "TAG_EYE");
      break;
    case "fx_breakmiddle":
      playFXOnTag(level._effect["kraken_water_roar_emitter1"], self, "TAG_EYE_breakMiddle");
      break;
    case "fx_roar":
      thread emerge_shock();
      break;
    case "intro_ten_emerge_start":
      foreach(var_5 in self.tentacles) {
        var_5 show();
        thread extendtentacle(var_5, 0);
      }
  }
}

emerge_shock() {
  wait 1.5;
  performroar();
}

playjawwaterfx() {
  playFXOnTag(level._effect["kraken_water_stream_emitter"], self, "j_jaw_fx_front_lf");
  wait 0.02;
  playFXOnTag(level._effect["kraken_water_stream_emitter"], self, "j_jaw_fx_front_rt");
  wait 0.02;
  playFXOnTag(level._effect["kraken_water_stream_emitter"], self, "j_jaw_fx_side_lf");
  wait 0.02;
  playFXOnTag(level._effect["kraken_water_stream_emitter"], self, "j_jaw_fx_side_rt");
}

playhelmetwaterfx() {
  playFXOnTag(level._effect["kraken_water_stream_e_lite"], self, "TAG_EYE_helmet_lf_001");
  wait 0.02;
  playFXOnTag(level._effect["kraken_water_stream_e_lite"], self, "TAG_EYE_helmet_lf_003");
  wait 0.02;
  playFXOnTag(level._effect["kraken_water_stream_e_lite"], self, "TAG_EYE_helmet_lf_005");
  wait 0.02;
  playFXOnTag(level._effect["kraken_water_stream_e_lite"], self, "TAG_EYE_helmet_rt_002");
  wait 0.02;
  playFXOnTag(level._effect["kraken_water_stream_e_lite"], self, "TAG_EYE_helmet_rt_004");
  wait 0.02;
  playFXOnTag(level._effect["kraken_water_stream_e_lite"], self, "TAG_EYE_helmet_rt_005");
}

playpincerswaterfx() {
  playFXOnTag(level._effect["kraken_water_stream_pincers"], self, "J_Jaw_Leg_R_01");
  wait 0.02;
  playFXOnTag(level._effect["kraken_water_stream_pincers"], self, "J_Jaw_Leg_L_01");
  wait 0.02;
  playFXOnTag(level._effect["kraken_water_stream_pincers"], self, "J_Jaw_Leg_R_02");
  wait 0.02;
  playFXOnTag(level._effect["kraken_water_stream_pincers"], self, "J_Jaw_Leg_L_02");
  wait 0.02;
}

extendtentacle(var_0, var_1) {
  if(var_1) {
    var_0 maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::teleportside(self.stage);
    wait 0.05;
  }

  var_0 maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::emerge(self.stage);
}

submerge() {
  common_scripts\utility::flag_set("fx_kraken_water");
  var_0 = getsideanimstate("emp_attack_");

  foreach(var_2 in self.tentacles) {
    var_2 thread maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::emp();
  }

  level notify("dlc_vo_notify", "kraken_vo", "warn_emp");
  playanim(var_0, 0, ::handleempnotetracks);
  thread performempdamage();
  var_4 = level.alien_types[self.alien_type].attributes[self.stage]["emp_loop_duration"] * 1000.0;
  var_5 = gettime() + var_4;
  var_6 = "emp_loop_complete";
  thread playloopanim(var_0, var_6);

  while(gettime() < var_5) {
    wait 0.05;
  }

  self notify(var_6);
  thread kraken_submerge_music();
  playanim(var_0, 2);
  level notify("dlc_vo_notify", "kraken_vo", "kraken_gone");
  self hide();
  wait(level.alien_types[self.alien_type].attributes[self.stage]["transition_submerge_time"]);
}

performroar() {
  self endon("death");
  var_0 = self gettagorigin("tag_breath");

  foreach(var_2 in level.players) {
    if(isalive(var_2) && bullettracepassed(var_0, var_2 getEye(), 0, undefined)) {
      var_2 shellshock("alien_kraken_emp", 3.0);
      earthquake(0.5, 1.0, var_2.origin, 100);
    }

    wait 0.05;
  }
}

kraken_submerge_music() {
  foreach(var_1 in level.players) {
    if(common_scripts\utility::flag("alien_music_playing")) {
      var_1 stoplocalsound("mp_suspense_01");
      var_1 stoplocalsound("mp_suspense_02");
      var_1 stoplocalsound("mp_suspense_03");
      var_1 stoplocalsound("mp_suspense_04");
      var_1 stoplocalsound("mp_suspense_05");
      var_1 stoplocalsound("mp_suspense_06");
      var_1 stoplocalsound("mus_alien_newwave");
      var_1 stoplocalsound("mus_alien_queen");
      common_scripts\utility::flag_clear("alien_music_playing");
    }

    level thread maps\mp\alien\_music_and_dialog::play_alien_music("mus_alien_dlc2_kraken_submerge");
  }
}

performempdamage() {
  self endon("death");
  var_0 = level.alien_types[self.alien_type].attributes[self.stage]["emp_damage_location"];
  var_1 = common_scripts\utility::getstruct(var_0, "targetname");
  var_2 = level.alien_types[self.alien_type].attributes[self.stage]["emp_damage"];
  var_3 = level.alien_types[self.alien_type].attributes[self.stage]["emp_shock_duration"];
  self.emp_traces_this_frame = 0;

  foreach(var_5 in level.players) {
    if(!isalive(var_5)) {
      continue;
    }
    registeremptrace();

    if(!isalive(var_5)) {
      continue;
    }
    if(bullettracepassed(var_1.origin, var_5 getEye(), 0, undefined)) {
      var_5 dodamage(var_2, self.origin, self, self, "MOD_MELEE");
      var_5 shellshock("alien_kraken_emp", var_3);
      var_5 playlocalsound("kraken_emp_hit");
      thread doempdisables(var_5);
      earthquake(0.55, 1.0, var_5.origin, 100);
      playfxontagforclients(level._effect["player_emp_scrn_fx"], var_5, "tag_eye", var_5);
    }

    if(!isDefined(var_5.crafted_items)) {
      continue;
    }
    if(isDefined(var_5.crafted_items["alien_crafting_hypno_trap"])) {
      empattempttodestroydeployable(var_5.crafted_items["alien_crafting_hypno_trap"], var_1.origin);
    }

    if(isDefined(var_5.crafted_items["alien_crafting_tesla_trap"])) {
      empattempttodestroydeployable(var_5.crafted_items["alien_crafting_tesla_trap"], var_1.origin);
    }
  }

  empprocessdeployablesarray(level.turrets, var_1.origin);
  empprocessdeployablesarray(level.placedims, var_1.origin);
  empprocessdeployablesarray(level.balldrones, var_1.origin);

  if(isDefined(level.alien_types[self.alien_type].attributes[self.stage]["emp_notify"])) {
    self notify(level.alien_types[self.alien_type].attributes[self.stage]["emp_notify"]);
  }
}

performempdamage_on_smash(var_0) {
  self endon("death");
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isalive(var_3)) {
      continue;
    }
    if(!isDefined(var_3.crafted_items)) {
      continue;
    }
    if(isDefined(var_3.crafted_items["alien_crafting_hypno_trap"])) {
      var_4 = var_3.crafted_items["alien_crafting_hypno_trap"];

      if(!isarray(var_4)) {
        var_1 = common_scripts\utility::add_to_array(var_1, var_4);
      } else {
        var_1 = common_scripts\utility::array_combine(var_1, var_4);
      }
    }

    if(isDefined(var_3.crafted_items["alien_crafting_tesla_trap"])) {
      var_4 = var_3.crafted_items["alien_crafting_tesla_trap"];

      if(!isarray(var_4)) {
        var_1 = common_scripts\utility::add_to_array(var_1, var_4);
      } else {
        var_1 = common_scripts\utility::array_combine(var_1, var_4);
      }
    }
  }

  var_1 = common_scripts\utility::array_combine(var_1, level.turrets);
  var_1 = common_scripts\utility::array_combine(var_1, level.placedims);
  var_1 = common_scripts\utility::array_combine(var_1, level.balldrones);

  if(var_1.size > 0) {
    empsmash_processdeployablesarray(var_1, var_0);
  }
}

empsmash_processdeployablesarray(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(isDefined(var_3) && isDefined(var_3.origin)) {
      if(distance2dsquared(var_3.origin, var_1) < 40000) {
        if(!isDefined(var_3.carriedby)) {
          var_3 notify("death");
        }
      }
    }
  }
}

doempdisables(var_0) {
  var_0 endon("disconnect");
  var_1 = level.alien_types[self.alien_type].attributes[self.stage]["emp_disable_duration"];
  var_0.turn_off_class_skill_activation = 1;
  var_0.player_action_disabled = 1;
  var_0 setclientomnvar("ui_alien_quick_shop_disabled", 1);
  wait(var_1);

  if(!isDefined(var_0)) {
    return;
  }
  var_0.turn_off_class_skill_activation = undefined;
  var_0.player_action_disabled = undefined;
  var_0 setclientomnvar("ui_alien_quick_shop_disabled", 0);
}

empprocessdeployablesarray(var_0, var_1) {
  foreach(var_3 in var_0) {
    empattempttodestroydeployable(var_3, var_1);
  }
}

empattempttodestroydeployable(var_0, var_1) {
  registeremptrace();

  if(isDefined(var_0) && !isDefined(var_0.carriedby) && bullettracepassed(var_1, var_0.origin + (0, 0, 20), 0, var_0)) {
    var_0 notify("death");
  }
}

registeremptrace() {
  var_0 = 1;

  if(self.emp_traces_this_frame >= var_0) {
    wait 0.05;
    self.emp_traces_this_frame = 0;
  }

  self.emp_traces_this_frame++;
}

empdestroydeployables(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(bullettracepassed(var_1, var_3.origin, 0, var_3)) {
      var_3 dodamage(1000000, var_1, self, self, "MOD_EXPLOSIVE");
    }
  }
}

getsideanimstate(var_0) {
  var_1 = level.alien_types["kraken"].attributes[self.stage]["ship_side"];
  return var_0 + var_1;
}

handleempnotetracks(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "kra_scream_int":
      if(level.alien_types["kraken"].attributes[self.stage]["ship_side"] == "port") {
        common_scripts\utility::exploder(3);
      } else {
        common_scripts\utility::exploder(4);
      }

      break;
    case "kra_scream":
  }
}