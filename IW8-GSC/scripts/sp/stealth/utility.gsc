/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\stealth\utility.gsc
***********************************************/

function try_announce_sound(var0, var1, var2) {
  if(isalive(self) && !should_sound_take_priority(var0)) {
    return 0;
  }

  self notify("try_announce_sound_" + var0);
  self endon("try_announce_sound_" + var0);
  self endon("death");
  self endon("long_death");

  if(isDefined(var1) && var1 > 0) {
    wait var1;
  }

  if(!can_announce_sound(var0)) {
    self.stealth.current_requested_snd = undefined;
    return 0;
  }

  return play_stealth_vo(var0, undefined, var2);
}

function should_sound_take_priority(var0) {
  if(!isDefined(self.stealth.current_requested_snd)) {
    self.stealth.current_requested_snd = var0;
    return true;
  }

  if(get_snd_priority(var0) < get_snd_priority(self.stealth.current_requested_snd)) {
    self.stealth.current_requested_snd = var0;
    return true;
  }

  return false;
}

function get_snd_priority(var0) {
  switch (var0) {
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
      iprintln("Can't get priority for snd " + var0);
      return undefined;
  }
}

function can_announce_sound(var0) {
  if(!isalive(self)) {
    return false;
  }

  if(istrue(self.in_melee_death)) {
    return false;
  }

  if(!isDefined(level.stealth.next_sound_time) || !isDefined(level.stealth.next_sound_time[var0])) {
    level.stealth.next_sound_time[var0] = -10;
  }

  var1 = gettime();

  if(var1 < level.stealth.next_sound_time[var0]) {
    return false;
  }

  add_announce_debounce(var0);
  return true;
}

function add_announce_debounce(var0, var1) {
  self endon("death");

  if(isDefined(var1) && var1 > 0) {
    wait var1;
  }

  if(isarray(var0)) {
    foreach(var3 in var0) {
      level.stealth.next_sound_time[var3] = gettime() + level.stealth.next_sound_wait;
    }

    return;
  }

  level.stealth.next_sound_time[var0] = gettime() + level.stealth.next_sound_wait;
}

function play_stealth_vo(var0, var1, var2) {
  var3 = 0;
  var4 = undefined;

  if(!isDefined(self.stealth.voiceid)) {
    return 0;
  }

  var5 = "dx_bcs_";

  if(istrue(var1)) {
    var5 = get_country_prefix();
  }

  switch (var0) {
    case "moving_up":
      var0 = "_movein_" + randomintrange(1, 4);
      break;
    case "keep_searching":
      var0 = "_searchcont_" + randomintrange(1, 5);
      break;
    case "lost_sight":
      if(distance(self.origin, level.player.origin) < 450) {
        var6 = "low";
      } else {
        var6 = "high";
      }

      if(scripts\engine\utility::cointoss()) {
        var1 = "_losloss_" + var6 + "_" + randomintrange(1, 4);
      } else {
        var1 = "_enemylost_" + randomintrange(1, 7) + "_" + var6;
      }

      break;
    case "drone_spotted":
      var1 = "_dronefound_" + randomintrange(1, 4);
      break;
    case "warning1":
      var1 = "_enemyalerted";
      break;
    case "hmph":
      var1 = "_backtopatrol";
      break;
    case "warning2":
      var1 = "_enemysearch";
      break;
    case "backup_call":
      var1 = "_enemybackup";
      break;
    case "hunting":
      var1 = "_hunting_" + randomintrange(1, 5);
      break;
    case "acknowledgement":
      if(self.stealth.voiceid == "sf1") {
        var1 = "_reinforcements_" + randomintrange(1, 7);

        if(isDefined(var3) && isDefined(var3.entity) && isai(var3.entity) && isalive(var3.entity) && distance2d(self.origin, var3.entity.origin) >= 350) {
          var5 = var3.entity;
        }
      } else {
        var1 = "_reinforcements";
      }

      break;
    case "spotted":
      if(scripts\engine\utility::cointoss()) {
        var1 = "_targetfound";
      } else {
        var1 = "_contact";
      }

      break;
    case "start_seek":
    case "order_team_seek":
      if(self.alertlevelint > 2) {
        self.stealth.current_requested_snd = undefined;
        return 0;
      }

      var1 = "_enemyfindplayer";

      if(isDefined(level.stealth.candidatesvoice) && level.stealth.candidatesvoice.size > 1) {
        foreach(var8 in level.stealth.candidatesvoice) {
          if(isalive(var8) && distance(self.origin, var8.origin) > 550) {
            var5 = var8;
            break;
          }
        }
      }

      break;
    case "saw_corpse":
      var1 = "_enemyalerted";
      break;
    case "found_corpse":
      var1 = "_corpsefound";
      break;
    case "explosion":
      if(scripts\engine\utility::cointoss()) {
        var1 = "_noisealert";
      } else {
        var1 = "_suprised";
      }

      break;
    case "enemysweep":
      var1 = "_enemysweep";
      break;
    case "gunshot":
    case "ally_damaged":
      if(scripts\engine\utility::cointoss() && isDefined(var3.origin)) {
        var1 = try_cardinal_gunshot(var3);
      } else {
        var1 = scripts\engine\utility::random(["_gunshot_4", "_gunshot_7", "_gunshot_9", "_gunshot_10"]);
      }

      break;
    case "gunshot_teammate":
      if(scripts\engine\utility::cointoss() && isDefined(var3.origin)) {
        var1 = try_cardinal_gunshot(var3);
      } else {
        var1 = scripts\engine\utility::random(["_gunshot_1", "_gunshot_2", "_gunshot_3", "_gunshot_5", "_gunshot_6", "_gunshot_8"]);
      }

      break;
    case "patrol_update_low":
      var1 = try_cardinal_patrol_update("low");

      if(!isDefined(var1)) {
        var1 = scripts\engine\utility::random(["_areasecure_n_1_low", "_areasecure_s_1_low", "_areasecure_e_1_low", "_areasecure_w_1_low"]);
      }

      if(isDefined(level.stealth.candidatesvoice) && level.stealth.candidatesvoice.size > 1) {
        foreach(var8 in level.stealth.candidatesvoice) {
          if(isalive(var8) && distance(self.origin, var8.origin) > 550) {
            var5 = var8;
            break;
          }
        }
      }

      break;
    case "patrol_update_high":
      var1 = try_cardinal_patrol_update("high");

      if(!isDefined(var1)) {
        var1 = scripts\engine\utility::random(["_areasecure_n_1_high", "_areasecure_s_1_high", "_areasecure_e_1_high", "_areasecure_w_1_high"]);
      }

      break;
    case "inquiry":
      if(isDefined(var3) && isDefined(var3.typeorig) && var3.typeorig == "unresponsive_teammate" && isDefined(var3.origin)) {
        var1 = "_searchreport_" + randomintrange(1, 7);
        var5 = var3.origin;
      } else {
        var1 = "_searchreport";
      }

      break;
    case "ally_killed":
      var1 = "_mandown";
      break;
  }

  var12 = var6 + self.stealth.voiceid + var1;
  var4 = play_stealth_vo_alias(var12, var5);
  return var4;
}

function get_country_prefix() {
  if(!isDefined(anim.countryids)) {
    return "";
  }

  if(!isDefined(self.voice) || !isDefined(anim.countryids[self.voice])) {
    return "";
  }

  return anim.countryids[self.voice] + "_";
}

function try_cardinal_patrol_update(var0) {
  var1 = scripts\anim\battlechatter::getdirectioncompass(self.origin, (0, 0, 0));

  if(isDefined(var1) && var1 == "impossible") {
    return undefined;
  }

  var0 = scripts\engine\utility::ter_op(isDefined(var0), "_" + var0, "_low");
  var2 = randomintrange(1, 5);

  switch (var1) {
    case "north":
      var3 = "_areasecure_n_" + var2 + var0;
      break;
    case "northwest":
      if(scripts\engine\utility::cointoss()) {
        var3 = "_areasecure_n_" + var3 + var1;
      } else {
        var3 = "_areasecure_w_" + var3 + var2;
      }

      break;
    case "northeast":
      if(scripts\engine\utility::cointoss()) {
        var3 = "_areasecure_n_" + var3 + var3;
      } else {
        var3 = "_areasecure_e_" + var3 + var3;
      }

      break;
    case "south":
      var3 = "_areasecure_s_" + var3 + var3;
      break;
    case "southwest":
      if(scripts\engine\utility::cointoss()) {
        var3 = "_areasecure_s_" + var3 + var3;
      } else {
        var3 = "_areasecure_w_" + var3 + var3;
      }

      break;
    case "southeast":
      if(scripts\engine\utility::cointoss()) {
        var3 = "_areasecure_s_" + var3 + var3;
      } else {
        var3 = "_areasecure_e_" + var3 + var3;
      }

      break;
    case "east":
      var3 = "_areasecure_e_" + var3 + var3;
      break;
    case "west":
      var3 = "_areasecure_w_" + var3 + var3;
      break;
    default:
      iprintln("No cardinal direction returned");
      var3 = undefined;
      break;
  }

  return var3;
}

function play_stealth_vo_alias(var0, var1) {
  var2 = 0;
  self.stealth.current_requested_snd = undefined;

  if(soundexists(var0)) {
    if(!isDefined(self.stealth_vo_ent)) {
      self.stealth_vo_ent = spawn("script_origin", self.origin);
    }

    if(isDefined(self.stealth_vo_ent)) {
      if(isDefined(self.model) && scripts\engine\utility::hastag(self.model, "j_head")) {
        self.stealth_vo_ent linkTo(self, "j_head", (0, 0, 0), (0, 0, 0));
      }

      self.stealth_vo_ent playSound(var0, "stealth_vo", 1);

      if(isDefined(var1)) {
        scripts\engine\utility::delaythread(0.3, &playradiotransmission, var0, var1);
      }

      if(should_try_generic_radio_confirmation(var0) && !isDefined(var1)) {
        thread generic_radio_confrimation();
      }
    }

    if(isDefined(self.stealth)) {
      self.stealth.last_sound_time = gettime();
    }

    var2 = 1;
  }

  return var2;
}

function should_try_generic_radio_confirmation(var0) {
  if(randomint(100) > 60) {
    return 0;
  }

  var1 = strtok(var0, "_");

  switch (var1[2]) {
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

function generic_radio_confrimation() {
  self endon("death");
  self notify("generic_radio_confrimation");
  self endon("generic_radio_confrimation");
  self.stealth_vo_ent waittill("stealth_vo");
  wait randomfloatrange(0.2, 0.4);
  var0 = "dx_bcs_sf1_radioconf";
  scripts\engine\sp\utility::play_sound_on_entity(var0);
}

function announce_spotted_acknowledge(var0) {
  var1 = var0.origin;
  var2 = get_country_prefix(var0);
  wait 1.5;

  if(isDefined(var0) && isDefined(var0.stealth.voiceid)) {
    var3 = var0.stealth.voiceid;
    var1 = var0.origin + (0, 0, 45);
  } else {
    var3 = randomint(3);
  }

  var4 = var3 + var3 + "_stealth_alert_r";
}

function try_cardinal_gunshot(var0) {
  var1 = scripts\anim\battlechatter::getdirectioncompass(self.origin, var0.origin);

  if(isDefined(var1) && var1 == "impossible") {
    return;
  }

  var2 = randomintrange(1, 4);

  switch (var1) {
    case "north":
      var3 = "_gunshot_n_" + var2;
      break;
    case "northwest":
      if(scripts\engine\utility::cointoss()) {
        var3 = "_gunshot_n_" + var3;
      } else {
        var3 = "_gunshot_w_" + var3;
      }

      break;
    case "northeast":
      if(scripts\engine\utility::cointoss()) {
        var3 = "_gunshot_n_" + var3;
      } else {
        var3 = "_gunshot_e_" + var3;
      }

      break;
    case "south":
      var3 = "_gunshot_s_" + var3;
      break;
    case "southwest":
      if(scripts\engine\utility::cointoss()) {
        var3 = "_gunshot_s_" + var3;
      } else {
        var3 = "_gunshot_w_" + var3;
      }

      break;
    case "southeast":
      if(scripts\engine\utility::cointoss()) {
        var3 = "_gunshot_s_" + var3;
      } else {
        var3 = "_gunshot_e_" + var3;
      }

      break;
    case "east":
      var3 = "_gunshot_e_" + var3;
      break;
    case "west":
      var3 = "_gunshot_w_" + var3;
      break;
    default:
      iprintln("No cardinal direction returned");
      var3 = undefined;
      break;
  }

  return var3;
}

function play_commander_response() {
  self endon("death");
  self.stealth_vo_ent waittill("stealth_vo");
  var0 = scripts\engine\utility::random(scripts\engine\utility::array_randomize(["dx_bcs_rul_contsweep_1", "dx_bcs_rul_contsweep_2", "dx_bcs_rul_contsweep_3", "dx_bcs_rul_contsweep_n_1", "dx_bcs_rul_contsweep_e_1", "dx_bcs_rul_contsweep_s_1", "dx_bcs_rul_contsweep_w_1"]));
  wait randomfloatrange(0.15, 0.25);
  thread scripts\engine\sp\utility::play_sound_on_entity(var0);
}

function playradiotransmission(var0, var1) {
  if(isai(var1)) {
    if(!isalive(var1)) {
      return;
    }

    var2 = var1 scripts\engine\utility::spawn_script_origin();
    var1 thread scripts\engine\utility::delete_on_death(var2);
    var1 endon("death");
    var2 linkTo(var1, "tag_eye", (0, 0, 0), (0, 0, 0));
    var2 setentitysoundcontext("atmosphere", "helmet");
    var2 playSound(var0, "sound_done");
    var2 waittill("sound_done");
    var2 delete();
    return;
  }

  if(isvector(var1)) {
    var2 = scripts\engine\utility::spawn_script_origin(var1, (0, 0, 0));
    var2 setentitysoundcontext("atmosphere", "helmet");
    var2 playSound(var0, "sound_done");
    var2 waittill("sound_done");
    var2 delete();
    return;
  }
}

function stealth_music_transition_sp(var0) {
  self notify("stealth_music_transition");
  self endon("stealth_music_transition");
  self endon("disconnect");

  if(!isDefined(self.stealth)) {
    thread scripts\stealth\player::main();
  }

  var1 = 1;
  var2 = 0.05;

  if(!isDefined(self.stealth.music_ent)) {
    self.stealth.music_ent = [];
  }

  var3 = var0;
  jumpiffalse(isDefined(var3) && !isDefined(self.stealth.music_ent[var3])) LOC_000000da;
  self.stealth.music_ent[var3] = spawn("script_model", self.origin);
  self.stealth.music_ent[var3] linkTo(self);
  self.stealth.music_ent[var3].cur_vol = 0;
  self.stealth.music_ent[var3] scalevolume(0);
  self.stealth.music_ent[var3] playLoopSound(var3);

  for(;;) {
    wait var2;
    var4 = 0;

    foreach(var3, var6 in self.stealth.music_ent) {
      var7 = undefined;

      if(isDefined(var0) && var3 == var0) {
        var6.cur_vol = min(1, var6.cur_vol + var2 / var1);
        var7 = 1;
      } else {
        var6.cur_vol = max(0, var6.cur_vol - var2 / var1);
        var7 = 0;
      }

      var6 scalevolume(var6.cur_vol);

      if(var6.cur_vol == var7) {
        var4++;
      }
    }

    if(var4 == self.stealth.music_ent.size) {
      foreach(var3, var6 in self.stealth.music_ent) {
        if(!isDefined(var0) || var3 != var0) {
          self.stealth.music_ent[var3] delete();
          self.stealth.music_ent[var3] = undefined;
        }
      }

      return;
    }
  }
}