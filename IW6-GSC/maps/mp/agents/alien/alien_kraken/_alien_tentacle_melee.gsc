/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\alien_kraken\_alien_tentacle_melee.gsc
***********************************************************************/

main() {
  self endon("killanimscript");
  self scragentsetphysicsmode("noclip");
  var_0 = gettime();
  self scragentsetorientmode("face angle abs", self.angles);

  switch (self.melee_type) {
    case "emerge":
      emerge();
      break;
    case "retract":
      retract();
      break;
    case "heat":
      heat();
      break;
    case "smash":
      smash();
      break;
    case "heat_smash":
      heat_smash();
      break;
    case "spawn":
      spawnattack();
      break;
    case "emp":
      emp();
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

endscript() {
  self.performing_melee = undefined;
  self.spawning = undefined;

  if(isDefined(self.spawn_count) && self.spawn_count > 0) {
    maps\mp\alien\_spawn_director::release_custom_spawn_space(self.spawn_count);
  }
}

emerge() {
  var_0 = getsideanimstate("emerge_");
  playanim(var_0);
}

handleheatenternotetracks(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "ten_hit":
      playheatenterquake();
      break;
    case "tnt_chrg_pt_l1":
      thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("tnt_chrg_pt_l1", "tag_hole", 8);
      break;
    case "tnt_chrg_pt_l2":
      thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("tnt_chrg_pt_l2", "tag_hole", 5);
      break;
    case "tnt_chrg_pt_r1":
      thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("tnt_chrg_pt_r1", "tag_hole", 5);
      break;
    case "tnt_chrg_pt_r2":
      thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("tnt_chrg_pt_r2", "tag_hole", 8);
      break;
    case "tnt_chrg_sb_l1":
      thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("tnt_chrg_sb_l1", "tag_hole", 4.5);
      break;
    case "tnt_chrg_sb_l2":
      thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("tnt_chrg_sb_l2", "tag_hole", 2);
      break;
    case "tnt_chrg_sb_r1":
      thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("tnt_chrg_sb_r1", "tag_hole", 3.5);
      break;
    case "tnt_chrg_sb_r2":
      thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("tnt_chrg_sb_r2", "tag_hole", 4);
      break;
  }
}

playheatenterquake() {
  var_0 = 0.5;
  var_1 = 0.5;
  var_2 = 2500;
  var_3 = self gettagorigin("TAG_HOLE");
  earthquake(var_0, var_1, var_3, var_2);
}

retract() {
  var_0 = getsideanimstate("retract_");
  playanim(var_0);
}

emp() {
  var_0 = getsideanimstate("emp_");
  playanim(var_0);
}

death() {
  playanim("death");
  self suicide();
}

heat() {
  self endon("heat_complete");
  var_0 = level.alien_types["kraken"].attributes[level.kraken.stage]["ship_side"];
  var_1 = getsideanimstate("slam_");
  playanim(var_1, undefined, ::handleheatenternotetracks);
  self.extended = 1;
}

getsmashanimlength(var_0) {
  var_1 = getsmashanimname(var_0);
  var_2 = level.alien_types["kraken"].attributes[self.tentacle_name]["anim_index"];
  var_3 = self getanimentry(var_1, var_2);
  return getanimlength(var_3);
}

getsmashanimname(var_0) {
  var_0 = var_0 + "_";

  if(isDefined(level.kraken.anim_state_modifier)) {
    var_0 = var_0 + (level.kraken.anim_state_modifier + "_");
  }

  var_1 = getsideanimstate(var_0);
  return var_1;
}

smash() {
  var_0 = getsmashanimname("smash");
  dosmash(var_0);
}

getsmashtriggerorigin() {
  if(!isDefined(self.smash_trigger) || !isDefined(self.smash_trigger.target)) {
    return undefined;
  }

  var_0 = common_scripts\utility::getstruct(self.smash_trigger.target, "targetname");

  if(!isDefined(var_0)) {
    return undefined;
  }

  return var_0.origin;
}

smashlerp(var_0, var_1, var_2) {
  self endon("death");
  self endon("smash_complete");
  var_3 = 1.0;
  var_4 = getanimlength(var_0);

  if(!errorchecksmashlerp(var_0, var_1, var_4, var_3)) {
    return;
  }
  var_5 = gettime();
  self waittill("start_smash_lerp");
  performsmashlerp(var_2, var_0, var_5, var_4, var_3);
  self waittill("start_smash_reverse_lerp");
  performsmashlerp(var_2 * -1, var_0, var_5, var_4, var_3);
}

errorchecksmashlerp(var_0, var_1, var_2, var_3) {
  var_4 = 1.0;
  return var_2 >= var_3 * 2 + var_4;
}

getsmashanimdelta(var_0, var_1, var_2) {
  var_3 = getmovedelta(var_0, var_1, var_2);
  return rotatevector(var_3, self.angles);
}

performsmashlerp(var_0, var_1, var_2, var_3, var_4) {
  var_5 = (gettime() - var_2) * 0.001;
  var_6 = var_5 / var_3;
  var_7 = (var_5 + var_4) / var_3;

  if(var_6 >= 1.0) {
    return;
  }
  var_7 = clamp(var_7, var_6, 1.0);
  var_8 = getsmashanimdelta(var_1, var_6, var_7);
  self scragentdoanimlerp(self.origin, self.origin + var_0 + var_8, var_4);
  wait(var_4);
  self scragentsetanimmode("anim deltas");
}

getclosestsmashtarget(var_0) {
  var_1 = undefined;
  var_2 = 1410065408;
  var_3 = self.smash_trigger getistouchingentities(level.players);

  foreach(var_5 in var_3) {
    var_6 = distance2dsquared(var_5.origin, var_0);

    if(var_6 < var_2) {
      var_1 = var_5;
      var_2 = var_6;
    }
  }

  return var_1;
}

heat_smash() {
  var_0 = getsmashanimname("heat_smash");
  dosmash(var_0);
}

dosmash(var_0) {
  var_1 = getsmashtriggerorigin();
  var_2 = self.origin;

  if(isDefined(var_1)) {
    var_3 = getclosestsmashtarget(var_1);

    if(isDefined(var_3)) {
      var_4 = 400;
      var_5 = (var_3.origin - var_1) * (1, 1, 0);
      var_6 = length(var_5);

      if(var_6 > var_4) {
        var_5 = vectornormalize(var_5) * var_4;
      }

      var_7 = level.alien_types["kraken"].attributes[self.tentacle_name]["anim_index"];
      var_8 = self getanimentry(var_0, var_7);
      var_9 = self getanimentryname(var_0, var_7);
      thread smashlerp(var_8, var_9, var_5);
    }
  }

  playanim(var_0, undefined, ::handlesmashnotetracks);
  self setorigin(var_2, 0);
  self notify("smash_complete");
}

handlesmashnotetracks(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "smash":
      smashdamage();
      break;
    case "heat_smash":
      smashdamage();
      thread heat_smash_fx();
      break;
    case "pre_smash":
      smashplayersback();
      break;
    case "smash_sfx":
      thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("kraken_tent_smash", "tag_hole", 6);
      break;
    case "lerp":
      self notify("start_smash_lerp");
      break;
    case "reverse_lerp":
      self notify("start_smash_reverse_lerp");
      break;
  }
}

smashdamage() {
  var_0 = 0.5;
  var_1 = 0.5;
  var_2 = self gettagorigin("TAG_HOLE");
  var_3 = level.alien_types["kraken"].attributes[level.kraken.stage]["smash_radius"];
  radiusdamage(var_2, var_3, level.alien_types["kraken"].attributes[level.kraken.stage]["smash_inner_damage"], level.alien_types["kraken"].attributes[level.kraken.stage]["smash_outer_damage"], level.kraken, "MOD_MELEE");
}

heat_smash_fx() {
  var_0 = self gettagorigin("TAG_HOLE");
  playFX(level._effect["tentacle_hit_heat"], var_0);
}

smashplayersback() {
  var_0 = 1500.0;
  var_1 = 122500;
  var_2 = 1750;
  var_3 = 1.0;
  var_4 = 0.75;
  var_5 = self gettagorigin("TAG_HOLE");
  var_6 = level.alien_types["kraken"].attributes[level.kraken.stage]["smash_radius"];
  earthquake(var_3, var_4, var_5, var_6 * 4);

  foreach(var_8 in level.players) {
    if(distance2dsquared(var_8.origin, var_5) > var_1) {
      continue;
    }
    var_9 = var_8 getvelocity();
    var_10 = vectornormalize((var_8.origin - var_5) * (1, 1, 0)) * var_2;
    var_11 = (var_9 + var_10) * (1, 1, 0);
    var_12 = length(var_11);

    if(var_12 >= var_0) {
      var_11 = vectornormalize(var_11) * var_0;
    }

    var_8 setvelocity(var_11);
    var_8 shellshock("alien_kraken_emp", 2.0);
  }

  thread maps\mp\agents\alien\alien_kraken\_alien_kraken_melee::performempdamage_on_smash(var_5);
}

spawnattack() {
  buildspawnwave();
  self.spawn_count = int(maps\mp\alien\_spawn_director::reserve_custom_spawn_space(self.current_spawn_wave.size, 1));

  if(self.spawn_count == 0) {
    return;
  }
  self.current_spawn_index = 0;
  var_0 = getsideanimstate("spawn_");
  var_1 = "spawn_complete";
  playanim(var_0, var_1, ::spawnnotetrackhandler);
}

buildspawnwave() {
  var_0 = level.kraken_spawn_waves[self.wave_name];
  self.current_spawn_wave = [];

  foreach(var_2 in var_0) {
    var_3 = strtok(var_2, "-");
    var_4 = int(var_3[1]);

    if(var_3.size > 2 && int(var_3[2]) > var_4) {
      var_5 = int(var_3[2]);
      var_6 = randomintrange(var_4, var_5);
    } else
      var_6 = var_4;

    for(var_7 = 0; var_7 < var_6; var_7++) {
      self.current_spawn_wave[self.current_spawn_wave.size] = var_3[0];
    }
  }
}

spawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "ten_spawn":
      if(self.spawn_count > 0) {
        var_4 = getspawnpoint();
        var_5 = self.current_spawn_wave[self.current_spawn_index];
        var_6 = getspawnaniminfo();
        maps\mp\alien\_spawn_director::process_custom_spawn(var_5, var_4, var_6);
        self.spawn_count--;
        self.current_spawn_index++;
        var_4 delete();
      }

      break;
    case "spawn_sfx1":
      thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("krk_tnt_spwn01", "tag_hole", 7.5);
      break;
    case "spawn_sfx2":
      thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("krk_tnt_spwn02", "tag_hole", 7.5);
      break;
    case "spawn_sfx3":
      thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("krk_tnt_spwn03", "tag_hole", 7.5);
      break;
    case "spawn_sfx4":
      thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("krk_tnt_spwn04", "tag_hole", 7.5);
      break;
    case "spawn_sfx5":
      thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("krk_tnt_spwn05", "tag_hole", 7.5);
      break;
    case "spawn_sfx6":
      thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("krk_tnt_spwn06", "tag_hole", 7.5);
      break;
  }
}

play_tentacle_vomit_spawn_fx() {
  self endon("death");
  playFXOnTag(level._effect["tentacle_vomit"], self, "tag_hole");
}

getspawnaniminfo() {
  var_0 = ";";
  var_1 = "flexible_height_spawn";
  var_2 = 0;
  var_3 = "NONE";
  var_4 = "end";
  var_5 = "queen_dirt_1";
  return var_1 + var_0 + var_2 + var_0 + var_1 + var_0 + var_4 + var_0 + var_3 + var_0 + var_3 + var_0 + var_3 + var_0 + var_5;
}

getspawnpoint() {
  var_0 = "Tag_hole";
  var_1 = self gettagorigin(var_0);
  var_2 = (0, 0, 0);
  var_3 = spawn("script_origin", var_1);
  var_3.angles = var_2;
  return var_3;
}

getsideanimstate(var_0) {
  var_1 = level.alien_types["kraken"].attributes[level.kraken.stage]["ship_side"];
  return var_0 + var_1;
}

playanim(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  var_4 = level.alien_types["kraken"].attributes[self.tentacle_name]["anim_index"];

  if(!isDefined(var_3) || var_3) {
    self scragentsetanimmode("anim deltas");
  }

  self scragentsetorientmode("face angle abs", self.angles);
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_0, var_4, var_0, "end", var_2);
}