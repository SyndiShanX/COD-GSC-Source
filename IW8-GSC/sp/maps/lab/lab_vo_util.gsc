/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\lab\lab_vo_util.gsc
***********************************************/

init_drone_vo() {
  scripts\engine\utility::flag_wait("allow_green_beam");
  level endon("allow_green_beam");
  var_0 = ["dx_vom_pri_drone_tutorial_intro_30", "dx_vom_pri_drone_tutorial_intro_40", "dx_vom_pri_drone_tutorial_intro_50"];
  level.drone_nags = scripts\engine\sp\utility::create_deck(var_0);
  childthread vo_drone_confirms();
  childthread vo_drone_hit();
  childthread vo_drone_no_mark();
  childthread vo_drone_friendlies_neg();
  childthread vo_drone_negative();
  childthread vo_drone_cooldown();
  thread uninit_drone_vo();
}

uninit_drone_vo() {
  scripts\engine\utility::flag_waitopen("allow_green_beam");
  level.drone_nags = undefined;
}

vo_use_drone_nags(var_0) {
  level endon("green_beam_target_confirmed");
  wait(var_0);
  var_1 = 6.85;
  var_2 = 0.8;

  for(;;) {
    level.price waittill("weapon_fired");
    level.price say_as_chatter(level.drone_nags scripts\engine\sp\utility::deck_draw(), 0, 1);
    scripts\engine\utility::flag_set("start_green_beam_instruct");
    wait(randomfloatrange(var_1 - var_2, var_1 + var_2));
    var_1 = min(var_1 * 1.45, 20);
    var_2 = min(var_2 * 1.2, 5);
  }
}

vo_drone_confirms() {
  var_0 = [];
  var_0[var_0.size] = "dx_vom_uavoperator_drone_tutorial_laseconf_10";
  var_0[var_0.size] = "dx_vom_uavoperator_drone_tutorial_laseconf_20";
  var_0[var_0.size] = "dx_vom_uavoperator_drone_tutorial_laseconf_30";
  var_0[var_0.size] = "dx_vom_uavoperator_drone_tutorial_laseconf_close_10";
  var_0[var_0.size] = "dx_vom_uavoperator_drone_tutorial_laseconf_close_20";
  var_0[var_0.size] = "dx_vom_uavoperator_drone_tutorial_laseconf_close_30";
  var_0[var_0.size] = "dx_vom_uavoperator_drone_tutorial_laseconf_close_40";
  var_1 = scripts\engine\sp\utility::create_deck(var_0);

  for(;;) {
    level waittill("green_beam_target_confirmed");
    level say_as_chatter(var_1 scripts\engine\sp\utility::deck_draw(), 0, 0.5);
  }
}

vo_drone_hit() {
  var_0 = [];
  var_1 = [];
  var_1[var_1.size] = "dx_vom_pri_drone_tutorial_success_10";
  var_1[var_1.size] = "dx_vom_uavoperator_drone_tutorial_killcount_10";
  var_1[var_1.size] = "dx_vom_uavoperator_drone_tutorial_killcount_20";
  var_0[1] = scripts\engine\sp\utility::create_deck(var_1);
  var_1 = [];
  var_1[var_1.size] = "dx_vom_uavoperator_drone_tutorial_killcount_30";
  var_1[var_1.size] = "dx_vom_uavoperator_drone_tutorial_killcount_40";
  var_0[2] = scripts\engine\sp\utility::create_deck(var_1);
  var_1 = [];
  var_1[var_1.size] = "dx_vom_uavoperator_drone_tutorial_killcount_50";
  var_1[var_1.size] = "dx_vom_uavoperator_drone_tutorial_killcount_60";
  var_1[var_1.size] = "dx_vom_uavoperator_drone_tutorial_killcount_70";
  var_0[3] = scripts\engine\sp\utility::create_deck(var_1);
  var_1[var_1.size] = "dx_vom_fsa1_drone_tutorial_success_20";
  var_1[var_1.size] = "dx_vom_fsa2_drone_tutorial_success_30";
  var_1[var_1.size] = "dx_vom_fsa3_drone_tutorial_success_40";
  var_1[var_1.size] = "dx_vom_lff1_drone_tutorial_success_50";
  var_2 = scripts\engine\sp\utility::create_deck(var_1);
  var_1 = [];
  var_1[var_1.size] = "dx_vom_pri_drone_tutorial_laseconf_miss_20";
  var_1[var_1.size] = "dx_vom_pri_drone_tutorial_laseconf_miss_30";
  var_1[var_1.size] = "dx_vom_pri_drone_tutorial_laseconf_miss_40";
  var_3 = scripts\engine\sp\utility::create_deck(var_1);

  for(;;) {
    level waittill("hellfire_killcount", var_4, var_5, var_6, var_7);
    wait 1;

    if(var_7 > 0) {
      level.player say_as_chatter(level.vo_callouts.heli_destroyed scripts\engine\sp\utility::deck_draw(), 0, 2);
      continue;
    }

    if(var_4 > 3)
      var_4 = 3;

    if(var_4 > 0) {
      level.player say_as_chatter(var_0[var_4] scripts\engine\sp\utility::deck_draw(), 0, 1.5);
      continue;
    }

    if(var_6 > 0) {
      level.player say_as_chatter(var_2 scripts\engine\sp\utility::deck_draw(), 1, 0.5);
      continue;
    }

    level.player say_as_chatter(var_3 scripts\engine\sp\utility::deck_draw(), 0, 1);
  }
}

vo_drone_no_mark() {
  var_0 = ["dx_vom_uavoperator_drone_tutorial_nomark_10", "dx_vom_uavoperator_drone_tutorial_nomark_20", "dx_vom_uavoperator_drone_tutorial_nomark_30"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);

  for(;;) {
    level waittill("green_beam_error");

    if(level.player.greenbeamerror == "hit_none")
      level say_as_chatter(var_1 scripts\engine\sp\utility::deck_draw(), 0, 1);
  }
}

vo_drone_friendlies_neg() {
  var_0 = ["dx_vom_uavoperator_drone_tutorial_noshot_10", "dx_vom_uavoperator_drone_tutorial_noshot_20", "dx_vom_uavoperator_drone_tutorial_noshot_30"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);

  for(;;) {
    level waittill("green_beam_error");

    if(level.player.greenbeamerror == "allies_too_close")
      level say_as_chatter(var_1 scripts\engine\sp\utility::deck_draw(), 0, 1);
  }
}

vo_drone_negative() {
  var_0 = [];
  var_0[var_0.size] = "dx_vom_uavoperator_drone_tutorial_laseconf_notready_10";
  var_0[var_0.size] = "dx_vom_uavoperator_drone_tutorial_laseconf_notready_20";
  var_0[var_0.size] = "dx_vom_uavoperator_drone_tutorial_laseconf_notready_30";
  var_1 = scripts\engine\sp\utility::create_deck(var_0);

  for(;;) {
    level waittill("attempted_green_beam_while_reloading");
    level say_as_chatter(var_1 scripts\engine\sp\utility::deck_draw(), 0, 1);
  }
}

vo_drone_cooldown() {
  var_0 = [];
  var_0[var_0.size] = "dx_vom_uavoperator_drone_tutorial_laseconf_out_10";
  var_0[var_0.size] = "dx_vom_uavoperator_drone_tutorial_laseconf_out_20";
  var_0[var_0.size] = "dx_vom_uavoperator_drone_tutorial_laseconf_out_30";
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = [];
  var_0[var_0.size] = "dx_vom_uavoperator_drone_tutorial_laseconf_ready_10";
  var_0[var_0.size] = "dx_vom_uavoperator_drone_tutorial_laseconf_ready_20";
  var_0[var_0.size] = "dx_vom_uavoperator_drone_tutorial_laseconf_ready_30";
  var_2 = scripts\engine\sp\utility::create_deck(var_0);
  scripts\engine\utility::flag_wait("player_at_intro_checkpoint");
  scripts\engine\utility::flag_waitopen("beam_ammo_out");

  if(!isDefined(level.last_beam_time) || scripts\engine\utility::time_has_passed(level.last_beam_time, 10))
    childthread vo_use_drone_nags(0);
  else
    childthread vo_use_drone_nags(10);

  for(;;) {
    scripts\engine\utility::flag_wait("beam_down");
    wait 2.2;
    level say_as_chatter(var_1 scripts\engine\sp\utility::deck_draw());
    scripts\engine\utility::flag_waitopen("beam_down");
    level say_as_chatter(var_2 scripts\engine\sp\utility::deck_draw());
    childthread vo_use_drone_nags(10);
  }
}

init_callout_vo() {
  level.vo_callouts = spawnStruct();
  var_0 = [];
  var_0[var_0.size] = "dx_vom_pri_hill_bottom_callout_helicopter_10";
  var_0[var_0.size] = "dx_vom_pri_hill_bottom_callout_helicopter_20";
  var_0[var_0.size] = "dx_vom_far_hill_bottom_callout_helicopter_80";
  var_0[var_0.size] = "dx_vom_kyle_hill_bottom_callout_helicopter_90";
  level.vo_callouts.heli = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = [];
  var_0[var_0.size] = "dx_vom_alx_hill_bottom_callout_helidestroyed_10";
  var_0[var_0.size] = "dx_vom_alx_hill_bottom_callout_helidestroyed_20";
  var_0[var_0.size] = "dx_vom_alx_hill_bottom_callout_helidestroyed_30";
  level.vo_callouts.heli_destroyed = scripts\engine\sp\utility::create_deck(var_0);
}

say(var_0, var_1) {
  if(!soundexists(var_0))
    return 0;

  if(is_dead_or_dying(self))
    return 0;

  self notify("started_speaking", var_0);
  self.lastspoketime = gettime();
  self.lastaliassaid = var_0;

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

is_speaking() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid))
    return 0;

  return scripts\engine\utility::time_has_passed(self.lastspoketime, lookupsoundlength(self.lastaliassaid) / 1000);
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

say_sequence_as_chatter(var_0, var_1, var_2) {
  return do_as_chatter(::say_sequence, [var_0], var_1, var_2);
}

wait_for_break_in_chatter(var_0) {
  var_1 = spawnStruct();
  var_2 = 0;

  if(!level.vo_chatter.speaking)
    return 1;

  level.vo_chatter.waiting = scripts\engine\utility::array_add(level.vo_chatter.waiting, var_1);

  if(isDefined(var_0))
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

is_dead_or_dying(var_0) {
  if(!isDefined(var_0))
    return 1;

  if(isai(var_0))
    return !isalive(var_0) || var_0 scripts\engine\utility::doinglongdeath();
  else if(issentient(var_0))
    return !isalive(var_0);

  return 0;
}

nagtill_open(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return nagtill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 1);
}

nagtill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_2 = default_if_undefined(var_2, 8);
  var_3 = default_if_undefined(var_3, 2);
  var_4 = default_if_undefined(var_4, 1.2);
  var_5 = default_if_undefined(var_5, 1.2);
  var_6 = default_if_undefined(var_6, 45);
  var_7 = default_if_undefined(var_7, 5);

  if(isDefined(var_0)) {
    if(isarray(var_0))
      var_0[0] endon(var_0[1]);
    else {
      var_9 = scripts\engine\utility::flag_exist(var_0) && scripts\engine\utility::ter_op(istrue(var_8), !scripts\engine\utility::flag(var_0), scripts\engine\utility::flag(var_0));

      if(var_9) {
        return;
      }
      level endon(var_0);
    }
  }

  if(isarray(var_1))
    var_1 = scripts\engine\sp\utility::create_deck(var_1);

  for(;;) {
    if(var_1 scripts\engine\sp\utility::deck_is_empty())
      var_1 array_deck_shuffle();

    var_10 = var_1 scripts\engine\sp\utility::deck_draw();

    if(isarray(var_10))
      var_10[0] say_as_chatter(var_10[1]);
    else
      say_as_chatter(var_10);

    wait(randomfloatrange(var_2 - var_3, var_2 + var_3));
    var_2 = min(var_2 * var_4, var_6);
    var_3 = min(var_3 * var_5, var_7);
  }
}

default_if_undefined(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = var_1;

  return var_0;
}

hill_pa_say(var_0, var_1) {
  var_2 = get_closest_pa_object("hill");
  var_2 say(var_0, var_1);
}

turbines_pa_say(var_0, var_1) {
  var_2 = get_closest_pa_object("turbines");
  var_2 say(var_0, var_1);
}

hill_pa_chatter_say(var_0, var_1, var_2) {
  var_3 = get_closest_pa_object("hill");
  var_3 say_as_chatter(var_0, var_1, var_2);
}

turbines_pa_chatter_say(var_0, var_1, var_2) {
  var_3 = get_closest_pa_object("turbines");
  var_3 say_as_chatter(var_0, var_1, var_2);
}

get_closest_pa_object(var_0) {
  if(!isDefined(var_0))
    var_1 = scripts\engine\utility::array_combine(getEntArray("hill_speakers", "script_noteworthy"), getEntArray("turbines_speakers", "script_noteworthy"));
  else
    var_1 = getEntArray(var_0 + "_speakers", "script_noteworthy");

  if(var_1.size == 0)
    return level.player;

  return sortbydistance(var_1, level.player.origin)[0];
}

say_on_kill_ai_type(var_0, var_1, var_2) {
  for(;;) {
    level waittill("ai_killed", var_3, var_4, var_5, var_6);

    if(var_4 != self) {
      continue;
    }
    if(var_3 get_ai_type() != var_1) {
      continue;
    }
    say_as_chatter(var_0);
    break;
  }
}

get_ai_type() {
  var_0 = strtok(self.classname, "_");
  return var_0[var_0.size - 1];
}

wait_combat_cooldown(var_0, var_1) {
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

display_all_last_anims() {
  for(;;) {
    var_0 = getEntArray();

    foreach(var_2 in var_0) {
      if(!isDefined(var_2) || !isDefined(var_2.animname) || !isDefined(var_2._lastanime))
        continue;
    }

    waitframe();
  }
}

get_last_anim_name() {
  return self._lastanime;
}

get_last_anim_frame() {
  return (gettime() - self.last_anim_time) / 1000 * 30;
}

easy_position_creator() {
  for(;;) {
    while(!level.player useButtonPressed())
      waitframe();

    iprintlnbold("Position Created");
    self notify("position_created");
    thread new_position("position_created");

    while(level.player useButtonPressed())
      waitframe();
  }
}

new_position(var_0) {
  if(isDefined(var_0))
    self endon(var_0);

  var_1 = anglesToForward(level.player getplayerangles());
  var_2 = scripts\engine\trace::ray_trace_detail(level.player getEye(), level.player getEye() + var_1 * 1000, level.player);
  var_3 = var_2["position"];
  var_4 = 40;
  var_5 = 0;
  level.player notifyonplayercommand("left_resize", "+actionslot 2");
  level.player notifyonplayercommand("right_resize", "+actionslot 4");

  for(;;) {
    iprintlnbold(var_3 + ", " + var_4);
    scripts\engine\utility::launcher_write_clipboard("( " + var_3 + ", " + var_4 + " );");
    level notify("cool_circle_resize");
    thread draw_cool_circle_til_notify(var_3, var_4, "cool_circle_resize", var_5);
    var_6 = level.player scripts\engine\utility::waittill_any_return("right_resize", "left_resize");

    if(var_6 == "right_resize") {
      var_4 = var_4 + 2;
      continue;
    }

    var_4 = var_4 - 2;
  }
}

draw_cool_circle_til_notify(var_0, var_1, var_2, var_3) {
  level endon(var_2);

  for(;;) {
    draw_cool_circle(var_0, var_1);
    waitframe();
  }
}

draw_cool_circle_for_time(var_0, var_1, var_2, var_3) {
  while(!isDefined(var_2) || var_2 > 0) {
    draw_cool_circle();
    waitframe();

    if(isDefined(var_2))
      var_2 = var_2 - 0.05;
  }
}

draw_cool_circle(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = 50;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    scripts\engine\utility::draw_circle(var_0 + (0, 0, var_2), var_1, (1, 1, 1), 1 - var_4 / var_3, 1, 1);
    var_2 = var_2 + 0.5 * (var_1 / 80);
  }
}

label_rebels() {
  for(;;) {
    if(isalive(level.rebel_1)) {}

    if(isalive(level.rebel_2)) {}

    if(isalive(level.rebel_3)) {}

    waitframe();
  }
}

ambush_is_looking_left() {
  return level.player.angles[1] < -60 && level.player.angles[1] > -125;
}

ambush_is_looking_forward() {
  return level.player.angles[1] < -135 || level.player.angles[1] > 135;
}

simple_dialogue(var_0) {
  self notify("stop_simple_dialogue");
  self playsoundatviewheight(var_0);

  if(isDefined(level.scr_face[self.animname][var_0]))
    childthread scripts\common\anim::anim_single_solo(self, var_0);

  wait(lookupsoundlength(var_0) / 1000);
}

simple_dialogue_on_tag(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = "j_head";

  self stopsounds();
  self notify("stop_simple_dialogue");
  var_3 = spawn("script_origin", self gettagorigin(var_1));
  var_3 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  var_3 playSound(var_0, "sounddone");

  if(isDefined(level.scr_face[self.animname][var_0]))
    childthread scripts\common\anim::anim_single_solo(self, var_0);

  thread delete_org_on_finish(var_3, var_2);
  var_3 waittill("finish");
}

delete_org_on_finish(var_0, var_1) {
  if(istrue(var_1))
    scripts\engine\utility::waittill_any_ents(self, "stop_simple_dialogue", var_0, "sounddone", self, "death");
  else
    scripts\engine\utility::waittill_any_ents(self, "stop_simple_dialogue", var_0, "sounddone");

  var_0 notify("finish");
  var_0 stopsounds();
  wait 0.05;
  var_0 delete();
}