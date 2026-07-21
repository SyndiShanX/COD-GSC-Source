/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\hometown\hometown_vo_util.gsc
*************************************************/

say(var_0, var_1, var_2) {
  if(!soundexists(var_0))
    return 0;

  if(is_dead_or_dying(self))
    return 0;

  self notify("started_speaking", var_0);
  self.lastspoketime = gettime();
  self.lastaliassaid = var_0;

  if(isPlayer(self) && isDefined(var_2)) {
    scripts\engine\sp\utility::player_gesture_force(var_2);
    var_3 = lookupsoundlength(var_0) / 1000;
    scripts\engine\utility::delaycall(var_3, ::stopgestureviewmodel);
  }

  if(istrue(var_1)) {
    if(isstruct(self))
      scripts\engine\sp\utility::smart_radio_dialogue_interrupt(var_0);
    else if(isPlayer(self))
      scripts\engine\sp\utility::smart_player_dialogue_interrupt(var_0);
    else if(isDefined(self.animname)) {
      self stopsounds();
      waitframe();
      scripts\engine\sp\utility::smart_dialogue(var_0);
    } else {
      if(issentient(self))
        self playsoundatviewheight(var_0);
      else
        self playSound(var_0);

      wait(lookupsoundlength(var_0) / 1000);
    }
  } else if(isstruct(self))
    scripts\engine\sp\utility::smart_radio_dialogue(var_0);
  else if(isPlayer(self))
    scripts\engine\sp\utility::smart_player_dialogue(var_0);
  else if(isDefined(self.animname))
    scripts\engine\sp\utility::smart_dialogue(var_0);
  else {
    if(issentient(self))
      self playsoundatviewheight(var_0);
    else
      self playSound(var_0);

    wait(lookupsoundlength(var_0) / 1000);
  }

  self notify("finished_speaking", var_0);
  return 1;
}

is_dead_or_dying(var_0) {
  if(!isDefined(var_0))
    return 1;

  if(isai(var_0))
    return !isalive(var_0) || var_0 scripts\engine\utility::doinglongdeath();
  else if(issentient(var_0))
    return !isalive(var_0);

  return 0;
}

is_speaking() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid))
    return 0;

  return scripts\engine\utility::time_has_passed(self.lastspoketime, lookupsoundlength(self.lastaliassaid) / 1000);
}

wait_finish_speaking() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid))
    return 0;

  var_0 = (gettime() - self.lastspoketime) / 1000;
  var_1 = lookupsoundlength(self.lastaliassaid) / 1000;

  if(var_0 < var_1)
    wait(var_1 - var_0);

  return 1;
}

time_since_spoke() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid))
    return undefined;

  var_0 = self.lastspoketime + lookupsoundlength(self.lastaliassaid);
  return (gettime() - var_0) / 1000;
}

say_sequence(var_0, var_1) {
  var_2 = self;

  if(!isarray(var_0))
    var_0 = [var_0];

  foreach(var_4 in var_0)
  var_2 = var_2 say_vo_item(var_4, var_1);
}

say_vo_item(var_0, var_1) {
  var_2 = self;

  if(isarray(var_0)) {
    if((isint(var_0[0]) || isfloat(var_0[0])) && isint(var_0[1]) || isfloat(var_0[1]))
      wait(randomfloatrange(var_0[0], var_0[1]));
    else if(isbuiltinfunction(var_0[0]) || isbuiltinmethod(var_0[0]) || isanimation(var_0[0]))
      var_2 call_with_params(var_0[0], var_0[1]);
    else {}

    return var_2;
  }

  if(isent(var_0) || isstruct(var_0))
    var_2 = var_0;
  else if(isstring(var_0))
    var_2 say(var_0, var_1);
  else if(isint(var_0) || isfloat(var_0))
    wait(var_0);
  else if(isbuiltinfunction(var_0) || isbuiltinmethod(var_0) || isanimation(var_0))
    var_2 call_with_params(var_0);
  else if(scripts\engine\sp\utility::is_deck(var_0))
    var_2 = var_2 say_vo_item(var_0 scripts\engine\sp\utility::deck_draw(), var_1);

  return var_2;
}

init_chatter() {
  level.vo_chatter = spawnStruct();
  level.vo_chatter.speaking = 0;
  level.vo_chatter.waiting = [];
}

terminate_chatter() {
  level.vo_chatter notify("terminate_chatter");
  level.vo_chatter = undefined;
}

say_as_chatter(var_0, var_1, var_2) {
  return do_as_chatter(::say, [var_0, var_1], var_1, var_2);
}

say_as_chatter_with_gesture(var_0, var_1, var_2, var_3) {
  return do_as_chatter(::say, [var_1, var_2, var_0], var_2, var_3);
}

say_sequence_as_chatter(var_0, var_1, var_2) {
  return do_as_chatter(::say_sequence, [var_0], var_1, var_2);
}

wait_for_break_in_chatter(var_0) {
  var_1 = spawnStruct();
  var_2 = 0;

  if(!isDefined(level.vo_chatter) || !level.vo_chatter.speaking)
    return 1;

  level.vo_chatter.waiting = scripts\engine\utility::array_add(level.vo_chatter.waiting, var_1);

  if(isDefined(var_0) && isstring(var_0))
    var_2 = scripts\engine\utility::waittill_any_ents_return(var_1, "proceed", self, var_0, level, var_0) == var_0;
  else if(isDefined(var_0))
    var_2 = var_1 scripts\engine\utility::waittill_notify_or_timeout_return("proceed", var_0) == "timeout";
  else
    var_1 waittill("proceed");

  level.vo_chatter.waiting = scripts\engine\utility::array_remove(level.vo_chatter.waiting, var_1);
  return var_2;
}

do_as_chatter(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.vo_chatter))
    thread init_chatter();

  level.vo_chatter endon("terminate_chatter");
  var_4 = spawnStruct();
  thread do_as_chatter_internal(var_0, var_1, var_2, var_3, var_4);
  var_4 waittill("done", var_5);
  return var_5;
}

do_as_chatter_internal(var_0, var_1, var_2, var_3, var_4) {
  level.vo_chatter endon("terminate_chatter");

  if(level.vo_chatter.speaking && (!istrue(var_2) || isDefined(var_3)))
    var_5 = wait_for_break_in_chatter(var_3);
  else
    var_5 = 0;

  var_6 = undefined;

  if(!level.vo_chatter.speaking || !var_5 || istrue(var_2)) {
    level.vo_chatter notify("started_speaking", self, var_0, var_1);
    level.vo_chatter.speaking++;
    var_6 = call_with_params(var_0, var_1);
    level.vo_chatter.speaking--;
    level.vo_chatter notify("done_speaking", self, var_0, var_1);
  }

  if(!level.vo_chatter.speaking && isDefined(level.vo_chatter.waiting[0]))
    level.vo_chatter.waiting[0] notify("proceed");

  var_4 notify("done", var_6);
}

call_with_params(var_0, var_1) {
  if(isbuiltinfunction(var_0))
    return call_with_params_script(var_0, var_1);
  else if(isbuiltinmethod(var_0) || isanimation(var_0))
    return call_with_params_builtin(var_0, var_1);
  else {}
}

call_with_params_script(var_0, var_1) {
  if(!isDefined(var_1))
    return self[[var_0]]();

  if(!isarray(var_1))
    return self[[var_0]](var_1);

  switch (var_1.size) {
    case 0:
      return self[[var_0]]();
    case 1:
      return self[[var_0]](var_1[0]);
    case 2:
      return self[[var_0]](var_1[0], var_1[1]);
    case 3:
      return self[[var_0]](var_1[0], var_1[1], var_1[2]);
    case 4:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3]);
    case 5:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4]);
    case 6:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5]);
    case 7:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6]);
    case 8:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7]);
    case 9:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8]);
    default:
      break;
  }
}

call_with_params_builtin(var_0, var_1) {
  if(!isDefined(var_1))
    return self[[var_0]]();

  if(!isarray(var_1))
    return self call[[var_0]](var_1);

  switch (var_1.size) {
    case 0:
      return self call[[var_0]]();
    case 1:
      return self call[[var_0]](var_1[0]);
    case 2:
      return self call[[var_0]](var_1[0], var_1[1]);
    case 3:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2]);
    case 4:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3]);
    case 5:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4]);
    case 6:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5]);
    case 7:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6]);
    case 8:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7]);
    case 9:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8]);
    default:
      break;
  }
}

nagtill_or_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = spawnStruct();
  var_9 endon("stop");
  var_9 scripts\engine\utility::delaythread(var_0, scripts\engine\utility::send_notify, "stop");
  nagtill(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

nagtill_delayed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1)) {
    if(!isarray(var_1))
      var_1 = [var_1];

    foreach(var_11 in var_1) {
      var_12 = scripts\engine\utility::flag_exist(var_11) && scripts\engine\utility::ter_op(istrue(var_9), !scripts\engine\utility::flag(var_11), scripts\engine\utility::flag(var_11));

      if(var_12) {
        return;
      }
      level endon(var_11);
      self endon(var_11);
    }
  }

  wait(var_0);
  nagtill(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

nagtill_open_delayed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(var_1)) {
    if(!isarray(var_1))
      var_1 = [var_1];

    foreach(var_10 in var_1) {
      if(scripts\engine\utility::flag_exist(var_10) && !scripts\engine\utility::flag(var_10)) {
        return;
      }
      level endon(var_10);
      self endon(var_10);
    }
  }

  wait(var_0);
  return nagtill(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 1);
}

nagtill_open(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return nagtill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 1);
}

nagtill_distance(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  return nagtill_delayed(var_0, var_1, [::alias_from_distance, var_2, var_3, var_4], var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

alias_from_distance(var_0, var_1, var_2) {
  if(get_player_progress_toward_self() > 0.5) {
    return;
  }
  if(distance2dsquared(self.origin, level.player.origin) > squared(var_2))
    return var_1 scripts\engine\sp\utility::deck_draw();
  else
    return var_0 scripts\engine\sp\utility::deck_draw();
}

nagtill_custom(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  return nagtill_delayed(var_3, var_0, scripts\engine\utility::array_combine([var_1], var_2), var_3 * var_4, var_4, var_5, var_6, var_7, var_8, var_9);
}

nagtill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_2 = default_if_undefined(var_2, 3);
  var_3 = default_if_undefined(var_3, 1.5);
  var_4 = default_if_undefined(var_4, 25);
  var_5 = default_if_undefined(var_5, var_2 / 4);
  var_6 = default_if_undefined(var_6, var_3);
  var_7 = default_if_undefined(var_7, var_4 / 4);
  var_9 = var_4 > var_2;
  var_10 = var_7 > var_5;

  if(isDefined(var_0)) {
    if(!isarray(var_0))
      var_0 = [var_0];

    foreach(var_12 in var_0) {
      var_13 = scripts\engine\utility::flag_exist(var_12) && scripts\engine\utility::ter_op(istrue(var_8), !scripts\engine\utility::flag(var_12), scripts\engine\utility::flag(var_12));

      if(var_13) {
        return;
      }
      level endon(var_12);
      self endon(var_12);
    }
  }

  if(isarray(var_1) && (isstring(var_1[0]) || isarray(var_1[0]))) {
    var_1 = scripts\engine\sp\utility::create_deck(var_1, 0);
    var_1.autoshuffle = 1;
  }

  for(;;) {
    var_15 = self;

    if(isarray(var_1) && isbuiltinfunction(var_1[0]))
      var_16 = var_15 call_with_params(var_1[0], scripts\engine\utility::array_remove_index(var_1, 0));
    else if(isbuiltinfunction(var_1))
      var_16 = var_15[[var_1]]();
    else
      var_16 = var_1 scripts\engine\sp\utility::deck_draw();

    if(!isDefined(var_16)) {
      wait(randomfloatrange(var_2 - var_5, var_2 + var_5));
      continue;
    }

    if(!isint(var_16) || var_16 != 0) {
      if(isarray(var_16)) {
        var_15 = var_16[0];
        var_16 = var_16[1];
      }

      var_15 thread notify_started_nag(var_16);
      var_15 say_as_chatter(var_16);
      level notify("said_nag", var_15, var_16);
    }

    wait(randomfloatrange(var_2 - var_5, var_2 + var_5));

    if(var_9)
      var_2 = min(var_2 * var_3, var_4);
    else
      var_2 = max(var_2 * var_3, var_4);

    if(var_10)
      var_5 = min(var_5 * var_6, var_7);
    else
      var_5 = max(var_5 * var_6, var_7);

    if(scripts\engine\sp\utility::is_deck(var_1) && var_1 scripts\engine\sp\utility::deck_is_empty())
      var_1 array_deck_shuffle();
  }
}

notify_started_nag(var_0) {
  if(!isDefined(self) || !isDefined(var_0)) {
    return;
  }
  self waittillmatch("started_speaking", var_0);
  self notify("started_nag", self, var_0);
  level notify("started_nag", self, var_0);
}

compare(var_0, var_1) {
  if(isarray(var_0)) {
    if(isarray(var_1))
      return compare_arrays(var_0, var_1);
    else
      return 0;
  } else if(isarray(var_1))
    return 0;
  else
    return var_0 == var_1;
}

compare_arrays(var_0, var_1) {
  if(var_0.size != var_1.size)
    return 0;

  foreach(var_5, var_3 in var_0) {
    if(!isDefined(var_1[var_5]))
      return 0;

    var_4 = var_1[var_5];

    if(compare(var_4, var_3))
      return 0;
  }

  return 1;
}

array_deck_shuffle() {
  var_0 = self;
  var_0.index = 0;
  var_0.items = scripts\engine\utility::array_randomize(var_0.items);

  if(!var_0.prevent_redraw || !isDefined(var_0.last_drawn) || var_0.items.size <= 1) {
    return;
  }
  var_1 = compare(var_0.items[0], var_0.last_drawn);

  if(var_1) {
    var_2 = randomintrange(1, var_0.items.size);
    var_3 = var_0.items[0];
    var_0.items[0] = var_0.items[var_2];
    var_0.items[var_2] = var_3;
  }
}

default_if_undefined(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = var_1;

  return var_0;
}

wait_combat_cooldown(var_0, var_1, var_2) {
  if(istrue(var_2))
    wait(var_0);

  while(!isDefined(var_1) || var_1 > 0) {
    if(!recently_in_combat(var_0))
      return 0;

    waitframe();

    if(isDefined(var_1))
      var_1 = var_1 - 0.05;
  }

  return 1;
}

recently_in_combat(var_0) {
  var_1 = isDefined(level.player.last_weapon_fire_time) && !scripts\engine\utility::time_has_passed(level.player.last_weapon_fire_time, var_0);
  var_2 = isDefined(level.player.last_damaged_time) && !scripts\engine\utility::time_has_passed(level.player.last_damaged_time, var_0);
  return level.player isfiring() || var_1 || var_2;
}

track_player_combat_time() {
  level.player endon("death");

  for(;;) {
    var_0 = level.player scripts\engine\utility::waittill_any_return("weapon_fired", "damage") == "weapon_fired";

    if(var_0) {
      level.player.last_weapon_fire_time = gettime();
      continue;
    }

    level.player.last_damaged_time = gettime();
  }
}

wait_lookat_or_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return scripts\sp\maps\hometown\hometown_util.gsc::wait_lookat(var_0, var_1, var_3, var_4, var_5, var_6, var_2, 1);
}

wait_lookat_ads_or_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return wait_lookat_ads(var_0, var_1, var_3, var_4, var_5, var_6, var_2);
}

wait_lookat_ads(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!istrue(var_5))
    var_5 = 0;

  return scripts\sp\maps\hometown\hometown_util.gsc::wait_lookat(var_0, var_1, var_2, var_3, var_4, var_5, var_6, 1);
}

wait_lookaway(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return scripts\sp\maps\hometown\hometown_util.gsc::wait_lookat(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 1);
}

say_on_enemy_radio(var_0, var_1, var_2) {
  var_3 = 0;

  if(!istrue(var_1) || isDefined(var_2))
    var_3 = wait_for_break_in_chatter(var_2);

  if(isDefined(var_1) && !var_1 && var_3) {
    return;
  }
  var_4 = getcorpsearrayinradius(level.player.origin, 1000);
  var_5 = scripts\engine\utility::array_combine(var_4, getaiarrayinradius(level.player.origin, 1000, "axis"));

  if(var_5.size == 0) {
    return;
  }
  var_6 = undefined;
  var_7 = undefined;

  foreach(var_9 in var_5) {
    if(getsubstr(var_9.classname, 0, 11) != "actor_enemy") {
      continue;
    }
    var_10 = distance2dsquared(level.player.origin, var_9 gettagorigin("j_chest"));

    if(!isDefined(var_7) || var_10 < var_7) {
      var_6 = var_9;
      var_7 = var_10;
    }
  }

  if(!isDefined(var_6)) {
    return;
  }
  var_12 = var_6 gettagorigin("j_chest");
  var_13 = var_6 gettagangles("j_chest");
  var_14 = scripts\engine\utility::spawn_script_origin(var_12, var_13);
  var_14 linkTo(var_6, "j_chest");
  var_14 thread scripts\engine\utility::call_on_notify("finished_speaking", ::delete);
  var_14 thread say(var_0, 1);
  var_14 waittill("finished_speaking");
}

call_nag_func(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isarray(var_0)) {
    var_2 = var_0;

    if(!isDefined(var_1))
      var_2 = scripts\engine\utility::array_remove_index(var_2, 0);
    else
      var_2[0] = var_1;

    return call_with_params(var_0[0], var_2);
  } else if(isDefined(var_1))
    return self[[var_0]](var_1);
  else
    return self[[var_0]]();
}

wait_any_delay_pausable(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  for(;;) {
    var_3 = wait_any_delay_type(var_0, var_1);

    if(!istrue(var_3) && isDefined(var_2)) {
      self waittill(var_2);
      continue;
    }

    return;
  }
}

wait_any_delay_type(var_0, var_1) {
  if(isDefined(var_1)) {
    self endon(var_1);
    level endon(var_1);
  }

  if(!isDefined(var_0)) {
    return;
  }
  if(isarray(var_0)) {
    if(isbuiltinfunction(var_0[0]))
      call_with_params(var_0[0], scripts\engine\utility::array_remove_index(var_0, 0));
    else if((isint(var_0[0]) || isfloat(var_0[0])) && (isint(var_0[1]) || isfloat(var_0[1])))
      wait(randomfloatrange(var_0[0], var_0[1]));
    else {}
  } else if(isbuiltinfunction(var_0))
    self[[var_0]]();
  else if(isstring(var_0))
    scripts\engine\utility::waittill_any_ents(level, var_0, self, var_0);
  else if(isint(var_0) || isfloat(var_0))
    wait(var_0);
  else {}

  return 1;
}

wait_progress_delay(var_0, var_1) {
  var_2 = var_0[0];
  var_3 = var_0[1];
  var_4 = var_3 - var_2;
  wait(var_2);
  var_5 = gettime();

  if(!isDefined(var_1))
    var_1 = ::get_player_progress_toward_self;

  for(;;) {
    if(isarray(var_1))
      var_6 = call_with_params(var_1[0], scripts\engine\utility::array_remove_index(var_1, 0));
    else
      var_6 = self[[var_1]]();

    if(var_6 > 0.7) {} else if(scripts\engine\utility::time_has_passed(var_5, var_4 * var_6)) {
      break;
    }

    waitframe();
  }
}

get_player_progress_toward_self() {
  var_0 = level.player getvelocity();

  if(length2dsquared(var_0) < 0.01)
    return 0.5;

  var_1 = self.origin - level.player.origin;
  var_2 = scripts\engine\math::anglebetweenvectors(var_0, var_1) / 180;
  return 1 - var_2;
}

state_goto(var_0) {
  self notify("state_change", var_0);
  self endon("state_change");
  self.state = var_0;
  self[[var_0]]();
}

call_continuous(var_0, var_1, var_2, var_3) {
  self endon(var_2);

  for(;;) {
    wait(var_0);

    if(isbuiltinfunction(var_1)) {
      call_with_params(var_1, var_3);
      continue;
    }

    call_with_params_builtin(var_1, var_3);
  }
}

statefunc1() {
  thread state_transitions();

  for(;;) {
    iprintlnbold("statefunc1");
    wait 1;
  }
}

state_transitions() {
  level waittill("state_test_1");
  state_goto(::statefunc1);
}

statefunc2() {
  for(;;) {
    iprintlnbold("statefunc2");
    wait 1;
  }
}

statefunc3() {
  for(;;) {
    iprintlnbold("statefunc3");
    wait 1;
  }
}

statefunc4() {
  for(;;) {
    iprintlnbold("statefunc4");
    wait 1;
  }
}

statefunc5() {
  for(;;) {
    iprintlnbold("statefunc5");
    wait 1;
  }
}

get_array_rule_token_value(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_0) {
    if(isDefined(var_3))
      var_2 = var_3.facts[var_5];

    if(is_fact_str(var_5))
      var_2 = var_1[fact_str_to_name(var_5)];

    if(!isDefined(var_2)) {
      return;
    }
    if(!is_ent_or_struct(var_2))
      return var_2;

    var_3 = var_2;
  }
}

fact_str_to_name(var_0) {
  return getsubstr(var_0, 1, var_0.size);
}

waittill_any_fact_update(var_0, var_1) {
  var_2 = [];
  var_3 = [];

  foreach(var_5 in var_0) {
    var_6 = undefined;
    var_7 = undefined;
    var_8 = undefined;

    foreach(var_10 in var_5) {
      if(isDefined(var_7))
        var_6 = var_7.facts[var_10];

      if(is_fact_str(var_10)) {
        var_6 = var_1[fact_str_to_name(var_10)];
        var_7 = var_6;
        var_2[var_2.size] = self;
        var_3[var_3.size] = fact_str_to_name(var_10);
        continue;
      }

      if(!isDefined(var_6)) {
        break;
      }

      var_2[var_2.size] = var_7;
      var_3[var_3.size] = var_10;
      var_7 = var_6;
    }
  }

  var_13 = spawnStruct();

  foreach(var_16, var_15 in var_2)
  var_15 childthread scripts\engine\utility::waittill_string("fact:" + var_3[var_16] + "_set", var_13);

  var_13 waittill("returned", var_17);
  var_13 notify("die");
}

is_valid_rule() {}

thread_end_test() {
  thread_end_func(thisthread, ::call_when_thread_ended);

  for(;;)
    waitframe();

  iprintlnbold("should never get here");
}

thread_end_func(var_0, var_1) {
  if(!isDefined(var_0)) {}

  if(!isDefined(var_0)) {}

  thread thread_on_end(var_0, var_1);
}

thread_on_end(var_0, var_1) {
  wait_thread_end(var_0);
  self thread[[var_1]]();
}

wait_thread_end(var_0) {
  if(!isDefined(var_0)) {}

  while(isDefined(var_0))
    waitframe();

  return 1;
}

call_when_thread_ended() {
  iprintlnbold("thread ended; func called; test successful");
}

find_and_register_vo_source(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2) || !isstring(var_2))
    var_2 = var_0;

  if(!isDefined(var_3) || !isstring(var_3))
    var_3 = "script_noteworthy";

  if(isDefined(var_4))
    var_5 = getEntArray(var_2, var_3)[var_4];
  else
    var_5 = getEnt(var_2, var_3);

  if(!isDefined(var_5)) {}

  var_5 register_vo_source(var_0, var_1);
  return var_5;
}

register_vo_source_at_pos(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", var_2);
  var_3.is_pos_vo_source = 1;
  var_3 register_vo_source(var_0, var_1);
  return var_3;
}

register_vo_source(var_0, var_1) {
  if(!isDefined(var_0) || !isstring(var_0)) {}

  if(!isDefined(level.vo_sources))
    level.vo_sources = [];

  if(isDefined(level.vo_sources[var_0]))
    unregister_vo_source(var_0);

  if(!isDefined(var_1) || !isstring(var_1))
    var_1 = var_0;

  self.source_name = var_0;
  self.display_name = var_1;
  self.is_speaking = 0;
  level.vo_sources[var_0] = self;
}

print_display_name_on_source(var_0) {
  self endon("death");

  for(;;)
    waitframe();
}

register_vo_source_attached(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_5 = var_4 gettagorigin(var_2);

  if(isDefined(var_3)) {
    var_6 = spawn("script_origin", var_5 + var_3);
    var_6 linkTo(var_4, var_2, var_3);
  } else {
    var_6 = spawn("script_origin", var_5);
    var_6 linkTo(var_4, var_2);
  }

  var_6.is_pos_vo_source = 1;
  var_6 register_vo_source(var_0, var_1);
}

unregister_vo_source(var_0) {
  if(!isDefined(level.vo_sources) || !isDefined(level.vo_sources[var_0])) {
    return;
  }
  var_1 = level.vo_sources[var_0].is_pos_vo_source;

  if(isDefined(var_1) && var_1)
    level.vo_sources[var_0] delete();

  level.vo_sources[var_0].line_queue = undefined;
  level.vo_sources[var_0].is_speaking = undefined;
  level.vo_sources[var_0].display_name = undefined;
  level.vo_sources[var_0] = undefined;
}

unregister_all_vo_sources() {
  if(!isDefined(level.vo_sources)) {
    return;
  }
  level.vo_sources = scripts\engine\utility::array_removedead(level.vo_sources);

  foreach(var_1 in level.vo_sources)
  unregister_vo_source(var_1.source_name);
}

get_vo_source(var_0) {
  if(!isDefined(level.vo_sources) || !isDefined(level.vo_sources[var_0]))
    return undefined;

  var_1 = level.vo_sources[var_0];
  return var_1;
}

get_any_vo_source_is_speaking() {
  return isDefined(get_any_speaking_vo_source());
}

get_any_speaking_vo_source() {
  foreach(var_1 in level.vo_sources) {
    if(var_1.is_speaking)
      return var_1;
  }

  return undefined;
}

wait_all_vo_sources_finish_speaking() {
  for(;;) {
    var_0 = get_any_speaking_vo_source();

    if(isDefined(var_0)) {
      wait_vo_source_finish_speaking(var_0.source_name);
      continue;
    }

    break;
  }
}

get_vo_source_is_speaking(var_0) {
  var_1 = level.vo_sources[var_0];
  return var_1.is_speaking;
}

wait_vo_source_finish_speaking(var_0) {
  if(!isDefined(level.vo_sources) || is_dead_or_dying(level.vo_sources[var_0])) {
    return;
  }
  var_1 = level.vo_sources[var_0];
  var_1 endon("death");

  if(!var_1.is_speaking) {
    return;
  }
  var_1 scripts\engine\utility::waittill_either("vo_interrupted", "vo_finished");
}

create_vo_bucket(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.lines = [];
  var_3.open_lines = [];
  var_3.groups = [];
  var_3.groups[0] = [];
  var_3.current_group = 0;
  var_3.fill_type = "single_group";

  if(isDefined(var_2))
    var_3.fill_type = var_2;

  var_3.name = var_0;
  var_3.selection = 0;
  var_3.sequential = 0;

  if(isDefined(var_1))
    var_3.sequential = var_1;

  var_3.is_playing = 0;
  return var_3;
}

set_vo_bucket_fills_all(var_0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var_1 = self;

  if(!isDefined(var_0))
    var_0 = 1;

  if(var_0)
    var_1.fill_type = "all_groups";
  else
    var_1.fill_type = "single_group";
}

set_vo_bucket_selection(var_0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var_1 = self;
  var_0 = tolower(var_0);

  switch (var_0) {
    case 0:
    case "weighted_random":
    case "weighted random":
    case "random":
      var_1.selection = 0;
      break;
    case 1:
    case "highest_weight":
    case "highest weight":
    case "highest":
      var_1.selection = 1;
      break;
    case 2:
    case "lowest_weight":
    case "lowest weight":
    case "lowest":
      var_1.selection = 2;
      break;
    default:
      break;
  }
}

set_vo_bucket_sequential(var_0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var_1 = self;
  var_1.sequential = !isDefined(var_0) || var_0;
}

get_vo_bucket_sequential(var_0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var_1 = self;
  var_2 = var_1.last_played;

  if(!isDefined(var_2))
    var_2 = var_0[0];

  if(!isDefined(var_2.sequential))
    return var_1.sequential;
  else
    return var_2.sequential;
}

add_vo_line_linked(var_0, var_1, var_2, var_3) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var_4 = self;
  var_5 = var_4.lines[var_4.lines.size - 1];
  var_6 = add_vo_line(var_1, var_2, var_3);
  var_5.next = var_6.index;
  var_5.wait_time = var_0;
  var_6.weight = 0;
}

add_vo_line(var_0, var_1, var_2) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  if(!isDefined(level.vo_sources[var_0])) {}

  var_3 = self;
  var_4 = spawnStruct();
  var_4.alias = var_1;
  var_4.index = var_3.lines.size;
  var_4.weight = 1;
  var_4.times_played = 0;
  var_4.blocking_ratio = 1;
  var_4.notifies = [];
  var_4.rules = [];

  if(!isDefined(var_3.group_end_index))
    var_3.open_lines[var_4.index] = var_4;

  var_3.lines[var_4.index] = var_4;
  var_4.group = var_3.groups.size - 1;
  var_5 = var_3.groups[var_4.group].size;
  var_3.groups[var_4.group][var_5] = var_4;

  if(isDefined(var_0) && isstring(var_0))
    var_4.source_name = var_0;
  else
    var_4.source_name = undefined;

  if(isDefined(var_2) && isstring(var_2))
    var_4.text = var_2;
  else
    var_4.text = var_1;

  var_4.duration = get_vo_duration(var_1);
  var_4.scaled_duration = var_4.duration;
  var_3 notify("line_added", var_4);
  return var_4;
}

set_vo_line_weight(var_0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var_1 = self;
  var_1.lines[var_1.lines.size - 1].weight = var_0;
}

set_vo_line_scale(var_0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var_1 = self;
  var_1.lines[var_1.lines.size - 1].blocking_ratio = var_0;
}

add_vo_line_scaled(var_0, var_1, var_2, var_3) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var_4 = self;
  var_5 = add_vo_line(var_1, var_2, var_3);
  var_5.scaled_duration = var_5.duration * var_0;
}

add_vo_rule(var_0, var_1) {
  if(!isDefined(self) || !is_vo_bucket(self) && !is_vo_line(self)) {}

  var_2 = undefined;
  var_3 = undefined;

  if(is_vo_bucket(self))
    var_2 = self;
  else
    var_3 = self;

  if(isDefined(var_2) && var_2.groups[var_2.groups.size - 1].size == 0 && var_2.groups.size > 1) {
    foreach(var_3 in var_2.groups[var_2.groups.size - 2])
    var_3 add_vo_rule(var_0, var_1);

    return;
  }

  if(isDefined(var_2))
    var_3 = var_2.lines[var_2.lines.size - 1];

  var_3.rules[var_3.rules.size] = strtok(var_0, " ");
}

add_vo_rules_all(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(self) || !is_vo_bucket(self) && !is_vo_line(self)) {}

  var_6 = undefined;
  var_7 = undefined;

  if(is_vo_bucket(self))
    var_6 = self;
  else
    var_7 = self;

  if(isDefined(var_6) && var_6.groups[var_6.groups.size - 1].size == 0 && var_6.groups.size > 1) {
    foreach(var_7 in var_6.groups[var_6.groups.size - 2])
    var_7 add_vo_rules_any(var_0, var_1, var_2, var_3, var_4, var_5);

    return;
  }

  if(isDefined(var_6))
    var_7 = var_6.lines[var_6.lines.size - 1];

  if(isDefined(var_0))
    var_7 add_vo_rule(var_0);

  if(isDefined(var_1))
    var_7 add_vo_rule(var_1);

  if(isDefined(var_2))
    var_7 add_vo_rule(var_2);

  if(isDefined(var_3))
    var_7 add_vo_rule(var_3);

  if(isDefined(var_4))
    var_7 add_vo_rule(var_4);

  if(isDefined(var_5))
    var_7 add_vo_rule(var_5);
}

add_vo_rules_any(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(self) || !is_vo_bucket(self) && !is_vo_line(self)) {}

  var_6 = undefined;
  var_7 = undefined;

  if(is_vo_bucket(self))
    var_6 = self;
  else
    var_7 = self;

  if(isDefined(var_6) && var_6.groups[var_6.groups.size - 1].size == 0 && var_6.groups.size > 1) {
    foreach(var_7 in var_6.groups[var_6.groups.size - 2])
    var_7 add_vo_rules_any(var_0, var_1, var_2, var_3, var_4, var_5);

    return;
  }

  if(isDefined(var_6))
    var_7 = var_6.lines[var_6.lines.size - 1];

  if(isDefined(var_0))
    var_7 add_vo_rule(var_0);

  if(isDefined(var_1))
    var_7 add_vo_rule(var_1);

  if(isDefined(var_2))
    var_7 add_vo_rule(var_2);

  if(isDefined(var_3))
    var_7 add_vo_rule(var_3);

  if(isDefined(var_4))
    var_7 add_vo_rule(var_4);

  if(isDefined(var_5))
    var_7 add_vo_rule(var_5);

  var_7.rule_type = "any";
}

add_vo_wait(var_0, var_1) {
  if(!isDefined(self) || !is_vo_bucket(self) && !is_vo_line(self)) {}

  var_2 = undefined;
  var_3 = undefined;

  if(is_vo_bucket(self))
    var_2 = self;
  else
    var_3 = self;

  if(isDefined(var_2) && var_2.groups[var_2.groups.size - 1].size == 0 && var_2.groups.size > 1) {
    foreach(var_3 in var_2.groups[var_2.groups.size - 2])
    var_3 add_vo_wait(var_0, var_1);
  } else {
    if(isDefined(var_2))
      var_3 = var_2.lines[var_2.lines.size - 1];

    if(!isDefined(var_1) || var_1) {
      var_3.pre_wait_time = var_0;
      return;
    }

    var_3.wait_time = var_0;
  }
}

add_vo_notify(var_0, var_1, var_2) {
  if(!isDefined(self) || !is_vo_bucket(self) && !is_vo_line(self)) {}

  var_3 = undefined;
  var_4 = undefined;

  if(is_vo_bucket(self))
    var_3 = self;
  else
    var_4 = self;

  if(isDefined(var_3) && var_3.groups[var_3.groups.size - 1].size == 0 && var_3.groups.size > 1) {
    foreach(var_4 in var_3.groups[var_3.groups.size - 2])
    var_4 add_vo_notify(var_0, var_1);

    return;
  }

  if(isDefined(var_3))
    var_4 = var_3.lines[var_3.lines.size - 1];

  var_4.notifies[var_4.notifies.size] = [var_0, var_1, var_2];
}

get_total_line_duration() {
  if(!isDefined(self) || !is_vo_line(self)) {}

  var_0 = self;
  var_1 = var_0.duration;

  if(isDefined(var_0.pre_wait_time))
    var_1 = var_1 + var_0.pre_wait_time;

  if(isDefined(var_0.wait_time))
    var_1 = var_1 + var_0.wait_time;

  return var_1;
}

end_vo_group(var_0, var_1, var_2, var_3) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var_4 = self;

  if(var_4.groups[var_4.groups.size - 1].size == 0) {}

  var_4 = self;

  if(isDefined(var_0)) {
    foreach(var_6 in var_4.groups[var_4.groups.size - 1])
    var_6.sequential = var_0;
  }

  if(isDefined(var_1)) {
    var_8 = strtok(var_1, " ");

    foreach(var_6 in var_4.groups[var_4.groups.size - 1])
    var_6.rules[var_6.rules.size] = var_8;
  }

  if(isDefined(var_2)) {
    foreach(var_6 in var_4.groups[var_4.groups.size - 1])
    var_6.wait_time = var_2;
  }

  if(isDefined(var_3)) {
    foreach(var_6 in var_4.groups[var_4.groups.size - 1])
    var_6.weight = min(var_6.weight, var_3);
  }

  var_4.groups[var_4.groups.size] = [];
  var_4 notify("group_end_added");
}

play_vo_bucket(var_0, var_1) {
  if(!is_vo_bucket(self)) {}

  var_2 = self;

  if(var_2.lines.size == 0) {}

  var_2 notify("started_playing");

  if(isDefined(var_1))
    var_3 = var_2 get_vo_line(var_1);
  else
    var_3 = var_2 get_line_to_play(var_0);

  var_2.is_playing = 1;
  thread bucket_terminator(thisthread);

  while(isDefined(var_3)) {
    var_2 notify("line_started", var_3);
    var_2.last_played = var_3;
    var_3.times_played++;
    var_2 remove_line_from_open(var_3);

    if(var_2.open_lines.size == 0 && !isDefined(var_2.group_end_index))
      var_2 notify("bucket_emptied");

    var_4 = var_3 get_total_line_duration();

    foreach(var_6 in var_3.notifies)
    thread notify_after_time(var_6[0] * var_4, var_6[1], var_6[2]);

    if(isDefined(var_3.pre_wait_time))
      wait(var_3.pre_wait_time);

    var_8 = undefined;

    if(isDefined(var_3.source_name)) {
      var_8 = get_vo_source_from_line(var_3);
      var_9 = var_8.is_speaking;
      thread play_vo_line(var_3.source_name, var_3.alias, var_3.text);

      if(var_9)
        var_8 waittill("vo_interrupted");

      var_10 = var_2 wait_vo_bucket_finish_or_interrupt(var_8);

      if(isDefined(var_10)) {
        if(var_10 == "stop")
          var_8 notify("stop_vo");

        var_2.endedby = var_10;
        var_2 notify("interrupted");
        return;
      }
    }

    var_11 = var_3;

    if(isDefined(var_11.wait_time))
      wait(var_11.wait_time);

    var_3 = var_2 get_next(var_11);
    var_2 notify("line_finished", var_11);
    var_2.last_finished = var_11;
  }

  var_2.endedby = "finish";
  var_2 notify("finished");
}

notify_after_time(var_0, var_1, var_2) {
  wait(var_0);

  if(isDefined(var_2))
    var_2 notify(var_1);
  else
    self notify(var_1);
}

get_next(var_0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  if(!isDefined(var_0) || !is_vo_line(var_0)) {}

  var_1 = self;

  if(!isDefined(var_0.next)) {
    return;
  }
  return var_1.lines[var_0.next];
}

call_func_set(var_0) {
  if(var_0[1]) {
    if(isDefined(var_0[0]))
      var_0[0] thread[[var_0[2]]]();
    else
      thread[[var_0[2]]]();
  } else if(isDefined(var_0[0]))
    var_0[0][[var_0[2]]]();
  else
    [[var_0[2]]]();
}

wait_vo_bucket_finish_or_interrupt(var_0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var_1 = self;
  var_0 endon("vo_finished");
  return scripts\engine\utility::waittill_any_ents_return(var_1, "death", var_1, "stop", var_0, "death", var_0, "vo_interrupted");
}

bucket_terminator(var_0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  if(!isDefined(var_0)) {}

  var_1 = self;
  var_1 endon("cancel_terminator");
  wait_thread_end(var_0);
  var_1.is_playing = 0;
  var_1 notify("play_terminated");
  var_1.endedby = undefined;
}

get_vo_source_from_line(var_0) {
  if(!isDefined(var_0)) {}

  if(isDefined(level.vo_sources))
    return level.vo_sources[var_0.source_name];
}

play_vo_bucket_looping(var_0, var_1, var_2) {
  if(!is_vo_bucket(self)) {}

  var_3 = self;
  var_1 = isDefined(var_1) && var_1;
  var_3 endon("death");
  var_3 endon("stop");

  while(!isDefined(var_2) || var_2 > 0) {
    var_3 play_vo_bucket();

    if(var_1 && var_3.open_lines.size == 0) {
      break;
    }

    if(isarray(var_0))
      wait(randomfloatrange(var_0[0], var_0[1]));
    else
      wait(var_0);

    if(isDefined(var_2))
      var_2--;
  }
}

stop_vo_bucket() {
  if(!is_vo_bucket(self)) {}

  var_0 = self;
  var_0 notify("stop");
}

stop_all_vo_sources() {
  if(!isDefined(level.vo_sources)) {
    return;
  }
  foreach(var_1 in level.vo_sources)
  var_1 notify("stop_vo");
}

stop_vo_source(var_0) {
  var_1 = undefined;

  if(isDefined(level.vo_sources) && isDefined(level.vo_sources[var_0]))
    var_1 = level.vo_sources[var_0];
  else
    return;

  var_1 notify("stop_vo");
}

play_vo_line_delayed(var_0, var_1, var_2, var_3, var_4) {
  wait(var_0);
  play_vo_line(var_1, var_2, var_3, var_4);
}

play_vo_line(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(level.vo_sources) && isDefined(level.vo_sources[var_0]))
    var_4 = level.vo_sources[var_0];
  else
    return 0;

  if(is_dead_or_dying(var_4))
    return 0;

  if(!soundexists(var_1)) {
    return;
  }
  var_4 endon("death");
  var_4 notify("start_vo");

  if(var_4.is_speaking)
    var_4 waittill("vo_interrupted");

  var_4 thread playsound_vo(var_1);
  return var_4 scripts\engine\utility::waittill_any("vo_finished", "vo_interrupted");
}

create_sound_origin_at_eye() {
  var_0 = self;
  var_1 = spawn("script_origin", var_0.origin);
  var_2 = var_0 gettagorigin("tag_eye", 1);

  if(isDefined(var_2))
    var_1 linkTo(var_0, "tag_eye");
  else
    var_1 linkTo(var_0);

  return var_1;
}

get_vo_duration(var_0) {
  var_1 = lookupsoundlength(var_0) / 1000;
  var_1 = round_up_to_nearest_twentieth(var_1 + 0.1);
  return var_1;
}

playsound_vo(var_0) {
  var_1 = self;
  var_2 = 1;
  var_2 = scripts\common\utility::issp() && isai(self) && isDefined(var_2) && var_2 && isDefined(var_1.animname);

  if(var_2)
    var_1 thread play_smart_vo_interrupt(var_0);
  else if(issentient(var_1))
    var_1 playsoundatviewheight(var_0);
  else
    var_1 playSound(var_0);

  var_3 = get_vo_duration(var_0);
  var_1.is_speaking = 1;
  var_1 wait_vo_line_finish(var_3);
}

play_smart_vo_interrupt(var_0) {
  self endon("vo_finished");
  self endon("vo_interrupted");

  if(self == level.player) {
    scripts\engine\sp\utility::smart_player_dialogue_interrupt(var_0);
    return;
  }

  if(!isDefined(self.unittype))
    self.unittype = "none";

  self stopsounds();
  waitframe();
  scripts\engine\sp\utility::smart_dialogue(var_0);
}

wait_vo_line_finish(var_0) {
  var_1 = self;
  var_2 = var_1 waittill_any_or_timeout(var_0, ["start_vo", "stop_vo", "long_death", "death"]);

  if(isDefined(var_1)) {
    var_1.is_speaking = 0;

    if(istrue(var_2))
      var_1 notify("vo_finished");
    else {
      if(var_1 != level.player)
        var_1 stopsounds();

      var_1 notify("vo_interrupted");
    }
  }
}

mark_speaker(var_0) {
  var_1 = self;
  var_1 endon("vo_finished");
  var_1 endon("vo_interrupted");
  var_2 = gettime();
  var_3 = ".";

  for(;;) {
    if(issentient(var_1))
      var_4 = var_1 getEye();
    else
      var_4 = var_1.origin;

    if(scripts\engine\utility::time_has_passed(var_2, var_0 / 3)) {
      var_2 = gettime();
      var_3 = var_3 + ".";
    }

    waitframe();
  }
}

waittill_any_or_timeout(var_0, var_1) {
  foreach(var_3 in var_1)
  self endon(var_3);

  wait(var_0);
  return 1;
}

round_up_to_nearest_twentieth(var_0) {
  return scripts\engine\math::round_float(var_0 * 2, 1, 0) / 2;
}

is_vo_bucket(var_0) {
  return isDefined(var_0.lines);
}

is_vo_line(var_0) {
  return isDefined(var_0.text) || isDefined(var_0.alias);
}

is_ent_or_struct(var_0) {
  return isent(var_0) || isstruct(var_0);
}

remove_line_from_open(var_0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  if(!isDefined(var_0)) {}

  var_1 = self;
  var_2 = [];
  var_3 = 0;

  foreach(var_5 in var_1.open_lines) {
    if(var_5 != var_0 && var_3 == 0)
      var_2[var_2.size] = var_5;

    var_3 = isDefined(var_5.next);
  }

  var_1.open_lines = var_2;
}

vo_bucket_is_empty() {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var_0 = self;
  return var_0.open_lines.size == 0;
}

refill(var_0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var_1 = self;

  if(var_1.fill_type == "single_group") {
    if(!isDefined(var_0))
      var_0 = 1;

    if(var_0 && var_1.groups.size > 1)
      var_1.current_group = clamp_looping(var_1.current_group + 1, 0, var_1.groups.size - 1);

    var_1.open_lines = var_1.groups[var_1.current_group];
  } else
    var_1.open_lines = var_1.lines;

  var_1 notify("bucket_filled");
}

clamp_looping(var_0, var_1, var_2) {
  if(var_2 <= var_1) {}

  for(var_3 = var_2 - var_1; var_0 > var_2; var_0 = var_0 % var_2) {}

  while(var_0 < var_1)
    var_0 = var_0 + var_3;

  return var_0;
}

get_valid_lines(var_0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  if(!isDefined(var_0) || !isarray(var_0)) {}

  var_1 = self;
  var_2 = [];

  foreach(var_4 in var_1.open_lines) {
    if(var_4.weight == 0 || var_4 evaluate_rules(var_0) == 0) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

evaluate_rules(var_0) {
  if(!isDefined(self) || !is_vo_line(self)) {}

  var_1 = self;

  if(isDefined(var_1.rule_type) && var_1.rule_type == "any") {
    foreach(var_3 in var_1.rules) {
      if(eval(var_3, var_0) == 1)
        return 1;
    }

    return 0;
  } else {
    foreach(var_3 in var_1.rules) {
      if(eval(var_3, var_0) == 0)
        return 0;
    }

    return 1;
  }
}

eval(var_0, var_1) {
  if(var_0.size == 1)
    return get_rule_token_value(var_0[0], var_1);

  var_0[0] = get_rule_token_value(var_0[0], var_1);
  var_0[2] = get_rule_token_value(var_0[2], var_1);

  if(!isDefined(var_0[0]) || !isDefined(var_0[2]))
    return 0;

  var_2 = compare_values(var_0[0], var_0[1], var_0[2]);

  if(var_0.size == 5) {
    var_3 = [var_0[2], var_0[3], var_0[4]];
    return var_2 && eval(var_3);
  } else if(var_0.size > 5) {}

  return var_2;
}

get_rule_result(var_0, var_1, var_2) {
  var_0 = strtok(var_0, "|");
  var_2 = strtok(var_2, "|");

  foreach(var_4 in var_0) {
    foreach(var_6 in var_2) {
      if(compare_values(var_4, var_1, var_6))
        return 1;
    }
  }

  return 0;
}

compare_values(var_0, var_1, var_2) {
  if(isarray(var_1))
    var_1 = var_1[0];

  switch (var_1) {
    case "<":
      var_3 = var_0 < var_2;
      break;
    case ">":
      var_3 = var_0 > var_2;
      break;
    case ">=":
      var_3 = var_0 >= var_2;
      break;
    case "<=":
      var_3 = var_0 <= var_2;
      break;
    case "==":
    case "=":
      var_3 = var_0 == var_2;
      break;
    case "!=":
      var_3 = var_0 != var_2;
      break;
    default:
      var_3 = 0;
      break;
  }

  return var_3;
}

get_rule_token_value(var_0, var_1) {
  if(isarray(var_0)) {
    if(var_0.size == 1)
      var_0 = var_0[0];
    else
      return get_array_rule_token_value(var_0, var_1);
  }

  if(!isstring(var_0))
    return var_0;

  if(is_fact_str(var_0))
    return get_fact_value_from_context(var_0, var_1);
  else if(var_0 == "0")
    return 0;
  else if(float(var_0))
    return float(var_0);
  else if(var_0 == "true")
    return 1;
  else if(var_0 == "false")
    return 0;
  else
    return var_0;
}

is_fact_str(var_0) {
  return var_0[0] == "'";
}

get_fact_value_from_context(var_0, var_1) {
  var_0 = getsubstr(var_0, 1, var_0.size);
  var_2 = var_1[var_0];

  if(!isDefined(var_2)) {}

  return var_2;
}

get_line_to_play(var_0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var_1 = self;

  if(isDefined(var_0))
    var_2 = get_valid_lines(var_0);
  else
    var_2 = var_1.open_lines;

  if(var_1.fill_type == "single_group") {
    var_3 = var_1.current_group;

    while(var_2.size == 0) {
      var_1 refill();

      if(isDefined(var_0))
        var_2 = get_valid_lines(var_0);
      else
        var_2 = var_1.open_lines;

      if(var_1.current_group == var_3) {
        break;
      }
    }
  } else if(var_2.size == 0) {
    var_1 refill();

    if(isDefined(var_0))
      var_2 = get_valid_lines(var_0);
    else
      var_2 = var_1.open_lines;
  }

  if(var_2.size == 0) {
    return;
  }
  if(var_1 get_vo_bucket_sequential(var_2))
    return var_2[0];
  else
    return var_1 get_random_line(var_2);
}

get_random_line(var_0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var_1 = self;
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_5 = isDefined(var_1.last_finished) && var_4 == var_1.last_finished;
    var_6 = get_vo_source_from_line(var_4);

    if(!var_5 && !is_dead_or_dying(var_6))
      var_2 = var_2 + abs(var_4.weight);
  }

  if(var_2 == 0)
    return;
  else
    var_8 = randomfloatrange(0, var_2);

  foreach(var_4 in var_0) {
    var_6 = get_vo_source_from_line(var_4);
    var_5 = isDefined(var_1.last_finished) && var_4 == var_1.last_finished;
    var_10 = is_dead_or_dying(var_6);

    if(var_5 || var_10) {
      continue;
    }
    if(var_4.weight >= var_8)
      return var_4;
    else
      var_8 = var_8 - abs(var_4.weight);
  }
}

get_vo_line(var_0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var_1 = self;

  foreach(var_3 in var_1.lines) {
    if(var_3.alias == var_0)
      return var_3;
  }
}

display_ai_keys(var_0) {
  level notify("started_displaying_keys");
  level endon("started_displaying_keys");

  for(;;) {
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;

    if(!isDefined(var_0))
      var_0 = getaispeciesarray();

    foreach(var_8, var_5 in var_0) {
      if(!isDefined(var_5) || distance2dsquared(var_5.origin, level.player.origin) > 1000000) {
        continue;
      }
      var_6 = level.player worldpointtoscreenpos(var_5.origin + (0, 0, 40), getdvarint("MRNKTKLLKP"));

      if(!isDefined(var_6) || !var_5 scripts\engine\utility::hastag(var_5.model, "j_head")) {
        continue;
      }
      var_7 = distance2dsquared((0, 0, 0), var_6);

      if(!isDefined(var_2) || var_7 < var_2) {
        var_1 = var_5;
        var_2 = var_7;
        var_3 = var_8;
      }
    }

    if(isDefined(var_1))
      var_1 print_key_strings(var_3);

    waitframe();
  }
}

print_key_strings(var_0) {
  var_1 = 0;
  var_2 = self;
  var_3 = var_2 gettagorigin("j_head");

  if(isDefined(self.script_noteworthy)) {
    var_4 = getEntArray(self.script_noteworthy, "script_noteworthy");
    var_0 = undefined;

    if(var_4.size > 1) {
      foreach(var_7, var_6 in var_4) {
        if(var_6 == self)
          var_0 = var_7;
      }
    }

    if(isDefined(var_0)) {} else {}

    var_1++;
  }

  if(isDefined(self.targetname))
    var_1++;

  if(isDefined(self.target))
    var_1++;

  if(isDefined(self.script_linkname))
    var_1++;

  if(isDefined(self.code_classname))
    var_1++;

  if(isDefined(self.classname))
    var_1++;

  if(isDefined(self.script_friendname))
    var_1++;

  if(isDefined(self.animname))
    var_1++;

  if(isDefined(self.bcname))
    var_1++;

  var_1++;

  if(isDefined(var_0))
    var_1++;
}

print_position_values() {
  var_0 = get_nice_text_elem(100);
  var_1 = get_nice_text_elem(84);
  var_2 = -100000;
  var_3 = (0, 0, 0);

  for(;;) {
    var_4 = level.player.origin;

    if(!isDefined(var_4))
      var_4 = "undefined";

    if(level.player meleeButtonPressed()) {
      var_2 = gettime();
      scripts\engine\utility::launcher_write_clipboard(var_4);
      var_3 = var_4;
    }

    if(scripts\engine\utility::time_has_passed(var_2, 1.2))
      var_0.label = "^3PLAYER POS: ^7" + var_4;
    else
      var_0.label = "^2POS COPIED: ^7" + var_3;

    var_4 = distance2d(level.player.origin, var_3);
    var_1.label = "^3COPY DIST: ^7" + var_4;
    waitframe();
  }
}

get_nice_text_elem(var_0) {
  var_1 = newhudelem();
  var_1.elemtype = "font";
  var_1.fontscale = 0.8;
  var_1.sort = 10;
  var_1.label = "";
  var_1.alpha = 0;
  var_1 fadeovertime(0.2);
  var_1.alpha = 1;
  var_1.alignx = "left";
  var_1.aligny = "bottom";
  var_1.x = -80;
  var_1.y = var_0;
  var_2 = newhudelem();
  var_2.x = -85;
  var_2.y = var_0 - 5;
  var_2.alignx = "left";
  var_2.aligny = "middle";
  var_2.sort = 9;
  var_2.alpha = 0.4;
  var_2 setshader("black", 200, 15);
  var_1.bg = var_2;
  return var_1;
}

string_remove(var_0, var_1) {
  if(!isDefined(var_0) || !isstring(var_0) || !isDefined(var_1) || !isstring(var_1))
    return undefined;

  var_2 = "";

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(var_4 != var_1)
      var_2 = var_2 + var_4;
  }

  return var_2;
}

wrap_text(var_0, var_1) {
  var_2 = strtok(var_0, " ");
  var_3 = "";
  var_4 = [];
  var_5 = 0;
  var_6 = 0;

  foreach(var_8 in var_2) {
    if(var_6 > var_1) {
      var_4[var_4.size] = var_3;
      var_3 = "";
      var_6 = 0;
    }

    var_6 = var_6 + var_8.size;
    var_3 = var_3 + var_8;

    if(var_5 != var_2.size - 1)
      var_3 = var_3 + " ";
    else
      var_4[var_4.size] = var_3;

    var_5++;
  }

  return var_4;
}

int_min(var_0, var_1) {
  if(!isDefined(var_0))
    return var_1;

  if(!isDefined(var_1))
    return var_0;

  if(var_0 < var_1)
    return int(var_0);
  else
    return int(var_1);
}

average_velocity(var_0) {
  var_1 = (0, 0, 0);

  for(var_2 = 0; var_2 < var_0.size - 1; var_2++)
    var_1 = var_1 + (var_0[var_2 + 1] - var_0[var_2]);

  return var_1 / var_0.size - 1;
}

array_add_size_limited(var_0, var_1, var_2) {
  var_0[var_0.size] = var_1;

  if(var_0.size <= var_2)
    return var_0;

  var_3 = var_0.size - var_2;
  var_4 = [];

  for(var_5 = 0; var_5 < var_2; var_5++) {
    var_6[var_5] = var_0[var_3];
    var_3++;
  }
}

get_at_goalpos(var_0, var_1) {
  if(!isai(self)) {}

  if(!isDefined(var_0))
    var_0 = self.goalpos;

  if(!isDefined(var_1))
    var_1 = self.goalradius;

  return distance2dsquared(self.origin, var_0) < var_1 * var_1;
}

wait_goalpos(var_0, var_1, var_2) {
  if(!isai(self)) {}

  if(isDefined(var_1)) {
    self endon(var_1);
    level endon(var_1);
  }

  while(!get_at_goalpos(var_0, var_2))
    self waittill("goal");

  return 1;
}

wait_goalpos_or_msg(var_0, var_1, var_2) {
  if(scripts\engine\utility::flag_exist(var_0) && scripts\engine\utility::flag(var_0))
    return 0;

  return wait_goalpos(var_1, var_0, var_2);
}

goalpos_and_nagtill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = wait_goalpos_or_msg(var_1, undefined, 40);
  nagtill_delayed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  return istrue(var_10);
}