/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\stealth\utility.gsc
***********************************************/

try_announce_sound(var_0, var_1, var_2) {
  if(isalive(self) && !should_sound_take_priority(var_0))
    return 0;

  self notify("try_announce_sound_" + var_0);
  self endon("try_announce_sound_" + var_0);
  self endon("death");
  self endon("long_death");

  if(isDefined(var_1) && var_1 > 0)
    wait(var_1);

  if(!can_announce_sound(var_0)) {
    self.stealth.current_requested_snd = undefined;
    return 0;
  }

  return play_stealth_vo(var_0, undefined, var_2);
}

should_sound_take_priority(var_0) {
  if(!isDefined(self.stealth.current_requested_snd)) {
    self.stealth.current_requested_snd = var_0;
    return 1;
  }

  if(get_snd_priority(var_0) < get_snd_priority(self.stealth.current_requested_snd)) {
    self.stealth.current_requested_snd = var_0;
    return 1;
  }

  return 0;
}

get_snd_priority(var_0) {
  switch (var_0) {
    case "gunshot_teammate":
    case "gunshot":
    case "ally_killed":
    case "ally_damaged":
    case "explosion":
      return 1;
    case "moving_up":
    case "backup_call":
    case "hunting":
    case "drone_spotted":
    case "spotted":
      return 2;
    case "keep_searching":
    case "enemysweep":
    case "start_seek":
    case "order_team_seek":
    case "lost_sight":
      return 3;
    case "inquiry":
    case "saw_corpse":
    case "found_corpse":
      return 4;
    case "patrol_update_low":
    case "patrol_update_high":
    case "hmph":
    case "acknowledgement":
    case "warning2":
    case "warning1":
      return 5;
    default:
      iprintln("Can't get priority for snd " + var_0);
      return undefined;
  }
}

can_announce_sound(var_0) {
  if(!isalive(self))
    return 0;

  if(istrue(self.in_melee_death))
    return 0;

  if(!isDefined(level.stealth.next_sound_time) || !isDefined(level.stealth.next_sound_time[var_0]))
    level.stealth.next_sound_time[var_0] = -10;

  var_1 = gettime();

  if(var_1 < level.stealth.next_sound_time[var_0])
    return 0;

  add_announce_debounce(var_0);
  return 1;
}

add_announce_debounce(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1) && var_1 > 0)
    wait(var_1);

  if(isarray(var_0)) {
    foreach(var_3 in var_0)
    level.stealth.next_sound_time[var_3] = gettime() + level.stealth.next_sound_wait;
  } else
    level.stealth.next_sound_time[var_0] = gettime() + level.stealth.next_sound_wait;
}

play_stealth_vo(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = undefined;

  if(!isDefined(self.stealth.voiceid))
    return 0;

  var_5 = "dx_bcs_";

  if(istrue(var_1))
    var_5 = get_country_prefix();

  switch (var_0) {
    case "moving_up":
      var_0 = "_movein_" + randomintrange(1, 4);
      break;
    case "keep_searching":
      var_0 = "_searchcont_" + randomintrange(1, 5);
      break;
    case "lost_sight":
      if(distance(self.origin, level.player.origin) < 450)
        var_6 = "low";
      else
        var_6 = "high";

      if(scripts\engine\utility::cointoss())
        var_0 = "_losloss_" + var_6 + "_" + randomintrange(1, 4);
      else
        var_0 = "_enemylost_" + randomintrange(1, 7) + "_" + var_6;

      break;
    case "drone_spotted":
      var_0 = "_dronefound_" + randomintrange(1, 4);
      break;
    case "warning1":
      var_0 = "_enemyalerted";
      break;
    case "hmph":
      var_0 = "_backtopatrol";
      break;
    case "warning2":
      var_0 = "_enemysearch";
      break;
    case "backup_call":
      var_0 = "_enemybackup";
      break;
    case "hunting":
      var_0 = "_hunting_" + randomintrange(1, 5);
      break;
    case "acknowledgement":
      if(self.stealth.voiceid == "sf1") {
        var_0 = "_reinforcements_" + randomintrange(1, 7);

        if(isDefined(var_2) && isDefined(var_2.entity) && isai(var_2.entity) && isalive(var_2.entity) && distance2d(self.origin, var_2.entity.origin) >= 350)
          var_4 = var_2.entity;
      } else
        var_0 = "_reinforcements";

      break;
    case "spotted":
      if(scripts\engine\utility::cointoss())
        var_0 = "_targetfound";
      else
        var_0 = "_contact";

      break;
    case "start_seek":
    case "order_team_seek":
      if(self.alertlevelint > 2) {
        self.stealth.current_requested_snd = undefined;
        return 0;
      }

      var_0 = "_enemyfindplayer";

      if(isDefined(level.stealth.candidatesvoice) && level.stealth.candidatesvoice.size > 1) {
        foreach(var_8 in level.stealth.candidatesvoice) {
          if(isalive(var_8) && distance(self.origin, var_8.origin) > 550) {
            var_4 = var_8;
            break;
          }
        }
      }

      break;
    case "saw_corpse":
      var_0 = "_enemyalerted";
      break;
    case "found_corpse":
      var_0 = "_corpsefound";
      break;
    case "explosion":
      if(scripts\engine\utility::cointoss())
        var_0 = "_noisealert";
      else
        var_0 = "_suprised";

      break;
    case "enemysweep":
      var_0 = "_enemysweep";
      break;
    case "gunshot":
    case "ally_damaged":
      if(scripts\engine\utility::cointoss() && isDefined(var_2.origin))
        var_0 = try_cardinal_gunshot(var_2);
      else
        var_0 = scripts\engine\utility::random(["_gunshot_4", "_gunshot_7", "_gunshot_9", "_gunshot_10"]);

      break;
    case "gunshot_teammate":
      if(scripts\engine\utility::cointoss() && isDefined(var_2.origin))
        var_0 = try_cardinal_gunshot(var_2);
      else
        var_0 = scripts\engine\utility::random(["_gunshot_1", "_gunshot_2", "_gunshot_3", "_gunshot_5", "_gunshot_6", "_gunshot_8"]);

      break;
    case "patrol_update_low":
      var_0 = try_cardinal_patrol_update("low");

      if(!isDefined(var_0))
        var_0 = scripts\engine\utility::random(["_areasecure_n_1_low", "_areasecure_s_1_low", "_areasecure_e_1_low", "_areasecure_w_1_low"]);

      if(isDefined(level.stealth.candidatesvoice) && level.stealth.candidatesvoice.size > 1) {
        foreach(var_8 in level.stealth.candidatesvoice) {
          if(isalive(var_8) && distance(self.origin, var_8.origin) > 550) {
            var_4 = var_8;
            break;
          }
        }
      }

      break;
    case "patrol_update_high":
      var_0 = try_cardinal_patrol_update("high");

      if(!isDefined(var_0))
        var_0 = scripts\engine\utility::random(["_areasecure_n_1_high", "_areasecure_s_1_high", "_areasecure_e_1_high", "_areasecure_w_1_high"]);

      break;
    case "inquiry":
      if(isDefined(var_2) && isDefined(var_2.typeorig) && var_2.typeorig == "unresponsive_teammate" && isDefined(var_2.origin)) {
        var_0 = "_searchreport_" + randomintrange(1, 7);
        var_4 = var_2.origin;
      } else
        var_0 = "_searchreport";

      break;
    case "ally_killed":
      var_0 = "_mandown";
      break;
  }

  var_12 = var_5 + self.stealth.voiceid + var_0;
  var_3 = play_stealth_vo_alias(var_12, var_4);
  return var_3;
}

get_country_prefix() {
  if(!isDefined(anim.countryids))
    return "";

  if(!isDefined(self.voice) || !isDefined(anim.countryids[self.voice]))
    return "";

  return anim.countryids[self.voice] + "_";
}

try_cardinal_patrol_update(var_0) {
  var_1 = scripts\anim\battlechatter.gsc::getdirectioncompass(self.origin, (0, 0, 0));

  if(isDefined(var_1) && var_1 == "impossible")
    return undefined;

  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), "_" + var_0, "_low");
  var_2 = randomintrange(1, 5);

  switch (var_1) {
    case "north":
      var_3 = "_areasecure_n_" + var_2 + var_0;
      break;
    case "northwest":
      if(scripts\engine\utility::cointoss())
        var_3 = "_areasecure_n_" + var_2 + var_0;
      else
        var_3 = "_areasecure_w_" + var_2 + var_0;

      break;
    case "northeast":
      if(scripts\engine\utility::cointoss())
        var_3 = "_areasecure_n_" + var_2 + var_0;
      else
        var_3 = "_areasecure_e_" + var_2 + var_0;

      break;
    case "south":
      var_3 = "_areasecure_s_" + var_2 + var_0;
      break;
    case "southwest":
      if(scripts\engine\utility::cointoss())
        var_3 = "_areasecure_s_" + var_2 + var_0;
      else
        var_3 = "_areasecure_w_" + var_2 + var_0;

      break;
    case "southeast":
      if(scripts\engine\utility::cointoss())
        var_3 = "_areasecure_s_" + var_2 + var_0;
      else
        var_3 = "_areasecure_e_" + var_2 + var_0;

      break;
    case "east":
      var_3 = "_areasecure_e_" + var_2 + var_0;
      break;
    case "west":
      var_3 = "_areasecure_w_" + var_2 + var_0;
      break;
    default:
      iprintln("No cardinal direction returned");
      var_3 = undefined;
      break;
  }

  return var_3;
}

play_stealth_vo_alias(var_0, var_1) {
  var_2 = 0;
  self.stealth.current_requested_snd = undefined;

  if(soundexists(var_0)) {
    if(!isDefined(self.stealth_vo_ent))
      self.stealth_vo_ent = spawn("script_origin", self.origin);

    if(isDefined(self.stealth_vo_ent)) {
      if(isDefined(self.model) && scripts\engine\utility::hastag(self.model, "j_head"))
        self.stealth_vo_ent linkTo(self, "j_head", (0, 0, 0), (0, 0, 0));

      self.stealth_vo_ent playSound(var_0, "stealth_vo", 1);

      if(isDefined(var_1))
        scripts\engine\utility::delaythread(0.3, ::playradiotransmission, var_0, var_1);

      if(should_try_generic_radio_confirmation(var_0) && !isDefined(var_1))
        thread generic_radio_confrimation();
    }

    if(isDefined(self.stealth))
      self.stealth.last_sound_time = gettime();

    var_2 = 1;
  } else {}

  return var_2;
}

should_try_generic_radio_confirmation(var_0) {
  if(randomint(100) > 60)
    return 0;

  var_1 = strtok(var_0, "_");

  switch (var_1[2]) {
    case "targetfound":
    case "enemyfindplayer":
    case "start_seek":
    case "moving_up":
    case "gunshot_teammate":
      return 1;
    default:
      return 0;
  }
}

generic_radio_confrimation() {
  self endon("death");
  self notify("generic_radio_confrimation");
  self endon("generic_radio_confrimation");
  self.stealth_vo_ent waittill("stealth_vo");
  wait(randomfloatrange(0.2, 0.4));
  var_0 = "dx_bcs_sf1_radioconf";
  scripts\engine\sp\utility::play_sound_on_entity(var_0);
}

announce_spotted_acknowledge(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0 get_country_prefix();
  wait 1.5;

  if(isDefined(var_0) && isDefined(var_0.stealth.voiceid)) {
    var_3 = var_0.stealth.voiceid;
    var_1 = var_0.origin + (0, 0, 45);
  } else
    var_3 = randomint(3);

  var_4 = var_2 + var_3 + "_stealth_alert_r";
}

try_cardinal_gunshot(var_0) {
  var_1 = scripts\anim\battlechatter.gsc::getdirectioncompass(self.origin, var_0.origin);

  if(isDefined(var_1) && var_1 == "impossible") {
    return;
  }
  var_2 = randomintrange(1, 4);

  switch (var_1) {
    case "north":
      var_3 = "_gunshot_n_" + var_2;
      break;
    case "northwest":
      if(scripts\engine\utility::cointoss())
        var_3 = "_gunshot_n_" + var_2;
      else
        var_3 = "_gunshot_w_" + var_2;

      break;
    case "northeast":
      if(scripts\engine\utility::cointoss())
        var_3 = "_gunshot_n_" + var_2;
      else
        var_3 = "_gunshot_e_" + var_2;

      break;
    case "south":
      var_3 = "_gunshot_s_" + var_2;
      break;
    case "southwest":
      if(scripts\engine\utility::cointoss())
        var_3 = "_gunshot_s_" + var_2;
      else
        var_3 = "_gunshot_w_" + var_2;

      break;
    case "southeast":
      if(scripts\engine\utility::cointoss())
        var_3 = "_gunshot_s_" + var_2;
      else
        var_3 = "_gunshot_e_" + var_2;

      break;
    case "east":
      var_3 = "_gunshot_e_" + var_2;
      break;
    case "west":
      var_3 = "_gunshot_w_" + var_2;
      break;
    default:
      iprintln("No cardinal direction returned");
      var_3 = undefined;
      break;
  }

  return var_3;
}

play_commander_response() {
  self endon("death");
  self.stealth_vo_ent waittill("stealth_vo");
  var_0 = scripts\engine\utility::random(scripts\engine\utility::array_randomize(["dx_bcs_rul_contsweep_1", "dx_bcs_rul_contsweep_2", "dx_bcs_rul_contsweep_3", "dx_bcs_rul_contsweep_n_1", "dx_bcs_rul_contsweep_e_1", "dx_bcs_rul_contsweep_s_1", "dx_bcs_rul_contsweep_w_1"]));
  wait(randomfloatrange(0.15, 0.25));
  thread scripts\engine\sp\utility::play_sound_on_entity(var_0);
}

playradiotransmission(var_0, var_1) {
  if(isai(var_1)) {
    if(!isalive(var_1)) {
      return;
    }
    var_2 = var_1 scripts\engine\utility::spawn_script_origin();
    var_1 thread scripts\engine\utility::delete_on_death(var_2);
    var_1 endon("death");
    var_2 linkTo(var_1, "tag_eye", (0, 0, 0), (0, 0, 0));
    var_2 setentitysoundcontext("atmosphere", "helmet");
    var_2 playSound(var_0, "sound_done");
    var_2 waittill("sound_done");
    var_2 delete();
  } else if(isvector(var_1)) {
    var_2 = scripts\engine\utility::spawn_script_origin(var_1, (0, 0, 0));
    var_2 setentitysoundcontext("atmosphere", "helmet");
    var_2 playSound(var_0, "sound_done");
    var_2 waittill("sound_done");
    var_2 delete();
  }
}

stealth_music_transition_sp(var_0) {
  self notify("stealth_music_transition");
  self endon("stealth_music_transition");
  self endon("disconnect");

  if(!isDefined(self.stealth))
    thread scripts\stealth\player::main();

  var_1 = 1.0;
  var_2 = 0.05;

  if(!isDefined(self.stealth.music_ent))
    self.stealth.music_ent = [];

  var_3 = var_0;

  if(isDefined(var_3) && !isDefined(self.stealth.music_ent[var_3])) {
    self.stealth.music_ent[var_3] = spawn("script_model", self.origin);
    self.stealth.music_ent[var_3] linkTo(self);
    self.stealth.music_ent[var_3].cur_vol = 0.0;
    self.stealth.music_ent[var_3] scalevolume(0.0);
    self.stealth.music_ent[var_3] playLoopSound(var_3);
  }

  for(;;) {
    wait(var_2);
    var_4 = 0;

    foreach(var_3, var_6 in self.stealth.music_ent) {
      var_7 = undefined;

      if(isDefined(var_0) && var_3 == var_0) {
        var_6.cur_vol = min(1.0, var_6.cur_vol + var_2 / var_1);
        var_7 = 1.0;
      } else {
        var_6.cur_vol = max(0.0, var_6.cur_vol - var_2 / var_1);
        var_7 = 0.0;
      }

      var_6 scalevolume(var_6.cur_vol);

      if(var_6.cur_vol == var_7)
        var_4++;
    }

    if(var_4 == self.stealth.music_ent.size) {
      foreach(var_3, var_6 in self.stealth.music_ent) {
        if(!isDefined(var_0) || var_3 != var_0) {
          self.stealth.music_ent[var_3] delete();
          self.stealth.music_ent[var_3] = undefined;
        }
      }

      return;
    }
  }
}