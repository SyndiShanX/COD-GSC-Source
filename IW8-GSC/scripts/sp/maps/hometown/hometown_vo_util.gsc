/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\hometown\hometown_vo_util.gsc
*********************************************************/

function say(var0, var1, var2) {
  if(!soundexists(var0)) {
    return false;
  }

  if(is_dead_or_dying(self)) {
    return false;
  }

  self notify("started_speaking", var0);
  self.lastspoketime = gettime();
  self.lastaliassaid = var0;

  if(isPlayer(self) && isDefined(var2)) {
    scripts\engine\sp\utility::player_gesture_force(var2);
    var3 = lookupsoundlength(var0) / 1000;
    scripts\engine\utility::delaycall(var3, &stopgestureviewmodel);
  }

  if(istrue(var1)) {
    if(isstruct(self)) {
      scripts\engine\sp\utility::smart_radio_dialogue_interrupt(var0);
    } else if(isPlayer(self)) {
      scripts\engine\sp\utility::smart_player_dialogue_interrupt(var0);
    } else if(isDefined(self.animname)) {
      self stopsounds();
      waitframe();
      scripts\engine\sp\utility::smart_dialogue(var0);
    } else {
      if(issentient(self)) {
        self playsoundatviewheight(var0);
      } else {
        self playSound(var0);
      }

      wait lookupsoundlength(var0) / 1000;
    }
  } else if(isstruct(self)) {
    scripts\engine\sp\utility::smart_radio_dialogue(var0);
  } else if(isPlayer(self)) {
    scripts\engine\sp\utility::smart_player_dialogue(var0);
  } else if(isDefined(self.animname)) {
    scripts\engine\sp\utility::smart_dialogue(var0);
  } else {
    if(issentient(self)) {
      self playsoundatviewheight(var0);
    } else {
      self playSound(var0);
    }

    wait lookupsoundlength(var0) / 1000;
  }

  self notify("finished_speaking", var0);
  return true;
}

function is_dead_or_dying(var0) {
  if(!isDefined(var0)) {
    return true;
  }

  if(isai(var0)) {
    return (!isalive(var0) || var0 scripts\engine\utility::doinglongdeath());
  } else if(issentient(var0)) {
    return !isalive(var0);
  }

  return false;
}

function is_speaking() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid)) {
    return 0;
  }

  return scripts\engine\utility::time_has_passed(self.lastspoketime, lookupsoundlength(self.lastaliassaid) / 1000);
}

function wait_finish_speaking() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid)) {
    return false;
  }

  var0 = (gettime() - self.lastspoketime) / 1000;
  var1 = lookupsoundlength(self.lastaliassaid) / 1000;

  if(var0 < var1) {
    wait var1 - var0;
  }

  return true;
}

function time_since_spoke() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid)) {
    return undefined;
  }

  var0 = self.lastspoketime + lookupsoundlength(self.lastaliassaid);
  return (gettime() - var0) / 1000;
}

function say_sequence(var0, var1) {
  var2 = self;

  if(!isarray(var0)) {
    var0 = [var0];
  }

  foreach(var4 in var0) {
    var2 = say_vo_item(var2, var4, var1);
  }
}

function say_vo_item(var0, var1) {
  var2 = self;

  if(isarray(var0)) {
    if((isint(var0[0]) || isfloat(var0[0])) && isint(var0[1]) || isfloat(var0[1])) {
      wait randomfloatrange(var0[0], var0[1]);
    } else if(isbuiltinfunction(var0[0]) || isbuiltinmethod(var0[0]) || isanimation(var0[0])) {
      call_with_params(var2, var0[0], var0[1]);
    }

    return var2;
  }

  if(isent(var0) || isstruct(var0)) {
    var2 = var0;
  } else if(isstring(var0)) {
    say(var2, var0, var1);
  } else if(isint(var0) || isfloat(var0)) {
    wait var0;
  } else if(isbuiltinfunction(var0) || isbuiltinmethod(var0) || isanimation(var0)) {
    call_with_params(var2, var0);
  } else if(scripts\engine\sp\utility::is_deck(var0)) {
    var2 = say_vo_item(var2, var0 scripts\engine\sp\utility::deck_draw(), var1);
  }

  return var2;
}

function init_chatter() {
  level.vo_chatter = spawnStruct();
  level.vo_chatter.speaking = 0;
  level.vo_chatter.waiting = [];
}

function terminate_chatter() {
  level.vo_chatter notify("terminate_chatter");
  level.vo_chatter = undefined;
}

function say_as_chatter(var0, var1, var2) {
  return do_as_chatter(&say, [var0, var1], var1, var2);
}

function say_as_chatter_with_gesture(var0, var1, var2, var3) {
  return do_as_chatter(&say, [var1, var2, var0], var2, var3);
}

function say_sequence_as_chatter(var0, var1, var2) {
  return do_as_chatter(&say_sequence, [var0], var1, var2);
}

function wait_for_break_in_chatter(var0) {
  var1 = spawnStruct();
  var2 = 0;

  if(!isDefined(level.vo_chatter) || !level.vo_chatter.speaking) {
    return 1;
  }

  level.vo_chatter.waiting = scripts\engine\utility::array_add(level.vo_chatter.waiting, var1);

  if(isDefined(var0) && isstring(var0)) {
    var2 = scripts\engine\utility::waittill_any_ents_return(var1, "proceed", self, var0, level, var0) == var0;
  } else if(isDefined(var0)) {
    var2 = var1 scripts\engine\utility::waittill_notify_or_timeout_return("proceed", var0) == "timeout";
  } else {
    var1 waittill("proceed");
  }

  level.vo_chatter.waiting = scripts\engine\utility::array_remove(level.vo_chatter.waiting, var1);
  return var2;
}

function do_as_chatter(var0, var1, var2, var3) {
  if(!isDefined(level.vo_chatter)) {
    thread init_chatter();
  }

  level.vo_chatter endon("terminate_chatter");
  var4 = spawnStruct();
  thread do_as_chatter_internal(var0, var1, var2, var3, var4);
  var4 waittill("done", var5);
  return var5;
}

function do_as_chatter_internal(var0, var1, var2, var3, var4) {
  level.vo_chatter endon("terminate_chatter");

  if(level.vo_chatter.speaking && (!istrue(var2) || isDefined(var3))) {
    var5 = wait_for_break_in_chatter(var3);
  } else {
    var5 = 0;
  }

  var6 = undefined;

  if(!level.vo_chatter.speaking || !var5 || istrue(var3)) {
    level.vo_chatter notify("started_speaking", self, var1, var2);
    level.vo_chatter.speaking++;
    var6 = call_with_params(var1, var2);
    level.vo_chatter.speaking--;
    level.vo_chatter notify("done_speaking", self, var1, var2);
  }

  if(!level.vo_chatter.speaking && isDefined(level.vo_chatter.waiting[0])) {
    level.vo_chatter.waiting[0] notify("proceed");
  }

  var5 notify("done", var6);
}

function call_with_params(var0, var1) {
  if(isbuiltinfunction(var0)) {
    return call_with_params_script(var0, var1);
  }

  if(isbuiltinmethod(var0) || isanimation(var0)) {
    return call_with_params_builtin(var0, var1);
  }
}

function call_with_params_script(var0, var1) {
  if(!isDefined(var1)) {
    return self[[var0]]();
  }

  if(!isarray(var1)) {
    return self[[var0]](var1);
  }

  switch (var1.size) {
    case 0:
      return self[[var0]]();
    case 1:
      return self[[var0]](var1[0]);
    case 2:
      return self[[var0]](var1[0], var1[1]);
    case 3:
      return self[[var0]](var1[0], var1[1], var1[2]);
    case 4:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3]);
    case 5:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4]);
    case 6:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5]);
    case 7:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6]);
    case 8:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7]);
    case 9:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7], var1[8]);
    default:
      break;
  }
}

function call_with_params_builtin(var0, var1) {
  if(!isDefined(var1)) {
    return self[[var0]]();
  }

  if(!isarray(var1)) {
    return self builtin[[var0]](var1);
  }

  switch (var1.size) {
    case 0:
      return self builtin[[var0]]();
    case 1:
      return self builtin[[var0]](var1[0]);
    case 2:
      return self builtin[[var0]](var1[0], var1[1]);
    case 3:
      return self builtin[[var0]](var1[0], var1[1], var1[2]);
    case 4:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3]);
    case 5:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4]);
    case 6:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5]);
    case 7:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6]);
    case 8:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7]);
    case 9:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7], var1[8]);
    default:
      break;
  }
}

function nagtill_or_timeout(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = spawnStruct();
  var9 endon("stop");
  var9 scripts\engine\utility::delaythread(var0, &scripts\engine\utility::send_notify, "stop");
  nagtill(var1, var2, var3, var4, var5, var6, var7, var8);
}

function nagtill_delayed(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isDefined(var1)) {
    if(!isarray(var1)) {
      var1 = [var1];
    }

    foreach(var11 in var1) {
      var12 = scripts\engine\utility::flag_exist(var11) && scripts\engine\utility::ter_op(istrue(var9), !scripts\engine\utility::flag(var11), scripts\engine\utility::flag(var11));

      if(var12) {
        return;
      }

      level endon(var11);
      self endon(var11);
    }
  }

  wait var0;
  nagtill(var1, var2, var3, var4, var5, var6, var7, var8, var9);
}

function nagtill_open_delayed(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(isDefined(var1)) {
    if(!isarray(var1)) {
      var1 = [var1];
    }

    foreach(var10 in var1) {
      if(scripts\engine\utility::flag_exist(var10) && !scripts\engine\utility::flag(var10)) {
        return;
      }

      level endon(var10);
      self endon(var10);
    }
  }

  wait var0;
  return nagtill(var1, var2, var3, var4, var5, var6, var7, var8, 1);
}

function nagtill_open(var0, var1, var2, var3, var4, var5, var6, var7) {
  return nagtill(var0, var1, var2, var3, var4, var5, var6, var7, 1);
}

function nagtill_distance(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  return nagtill_delayed(var0, var1, [ &alias_from_distance, var2, var3, var4], var5, var6, var7, var8, var9, var10, var11);
}

function alias_from_distance(var0, var1, var2) {
  if(get_player_progress_toward_self() > 0.5) {
    return;
  }

  if(distance2dsquared(self.origin, level.player.origin) > squared(var2)) {
    return var1 scripts\engine\sp\utility::deck_draw();
  }

  return var0 scripts\engine\sp\utility::deck_draw();
}

function nagtill_custom(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  return nagtill_delayed(var3, var0, scripts\engine\utility::array_combine([var1], var2), var3 * var4, var4, var5, var6, var7, var8, var9);
}

function nagtill(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var2 = default_if_undefined(var2, 3);
  var3 = default_if_undefined(var3, 1.5);
  var4 = default_if_undefined(var4, 25);
  var5 = default_if_undefined(var5, var2 / 4);
  var6 = default_if_undefined(var6, var3);
  var7 = default_if_undefined(var7, var4 / 4);
  var9 = var4 > var2;
  var10 = var7 > var5;

  if(isDefined(var0)) {
    if(!isarray(var0)) {
      var0 = [var0];
    }

    foreach(var12 in var0) {
      var13 = scripts\engine\utility::flag_exist(var12) && scripts\engine\utility::ter_op(istrue(var8), !scripts\engine\utility::flag(var12), scripts\engine\utility::flag(var12));

      if(var13) {
        return;
      }

      level endon(var12);
      self endon(var12);
    }
  }

  jumpiffalse(isarray(var1) && (isstring(var1[0]) || isarray(var1[0]))) LOC_000000ef;
  var1 = scripts\engine\sp\utility::create_deck(var1, 0);
  var1.autoshuffle = 1;

  for(;;) {
    var15 = self;

    if(isarray(var1) && isbuiltinfunction(var1[0])) {
      var16 = call_with_params(var15, var1[0], scripts\engine\utility::array_remove_index(var1, 0));
    } else if(isbuiltinfunction(var1)) {
      var16 = var15[[var1]]();
    } else {
      var16 = var1 scripts\engine\sp\utility::deck_draw();
    }

    if(!isDefined(var16)) {
      wait randomfloatrange(var2 - var5, var2 + var5);
      continue;
    }

    if(!isint(var16) || var16 != 0) {
      if(isarray(var16)) {
        var15 = var16[0];
        var16 = var16[1];
      }

      thread notify_started_nag(var15);
      say_as_chatter(var15, var16);
      level notify("said_nag", var15, var16);
    }

    wait randomfloatrange(var2 - var5, var2 + var5);

    if(var9) {
      var2 = min(var2 * var3, var4);
    } else {
      var2 = max(var2 * var3, var4);
    }

    if(var10) {
      var5 = min(var5 * var6, var7);
    } else {
      var5 = max(var5 * var6, var7);
    }

    if(scripts\engine\sp\utility::is_deck(var1) && var1 scripts\engine\sp\utility::deck_is_empty()) {
      array_deck_shuffle(var1);
    }
  }
}

function notify_started_nag(var0) {
  if(!isDefined(self) || !isDefined(var0)) {
    return;
  }

  self waittillmatch("started_speaking", var0);
  self notify("started_nag", self, var0);
  level notify("started_nag", self, var0);
}

function compare(var0, var1) {
  if(isarray(var0)) {
    if(isarray(var1)) {
      return compare_arrays(var0, var1);
    }

    return 0;
  }

  if(isarray(var1)) {
    return 0;
  }

  return var0 == var1;
}

function compare_arrays(var0, var1) {
  if(var0.size != var1.size) {
    return false;
  }

  foreach(var3 in var0) {
    if(!isDefined(var1[var5])) {
      return false;
    }

    var4 = var1[var5];

    if(compare(var4, var3)) {
      return false;
    }
  }

  return true;
}

function array_deck_shuffle() {
  var0 = self;
  var0.index = 0;
  var0.items = scripts\engine\utility::array_randomize(var0.items);

  if(!var0.prevent_redraw || !isDefined(var0.last_drawn) || var0.items.size <= 1) {
    return;
  }

  var1 = compare(var0.items[0], var0.last_drawn);

  if(var1) {
    var2 = randomintrange(1, var0.items.size);
    var3 = var0.items[0];
    var0.items[0] = var0.items[var2];
    var0.items[var2] = var3;
    return;
  }
}

function default_if_undefined(var0, var1) {
  if(!isDefined(var0)) {
    var0 = var1;
  }

  return var0;
}

function wait_combat_cooldown(var0, var1, var2) {
  if(istrue(var2)) {
    wait var0;
  }

  while(!isDefined(var1) || var1 > 0) {
    if(!recently_in_combat(var0)) {
      return false;
    }

    waitframe();

    if(isDefined(var1)) {
      var1 -= 0.05;
    }
  }

  return true;
}

function recently_in_combat(var0) {
  var1 = isDefined(level.player.last_weapon_fire_time) && !scripts\engine\utility::time_has_passed(level.player.last_weapon_fire_time, var0);
  var2 = isDefined(level.player.last_damaged_time) && !scripts\engine\utility::time_has_passed(level.player.last_damaged_time, var0);
  return level.player isfiring() || var1 || var2;
}

function track_player_combat_time() {
  level.player endon("death");

  for(;;) {
    var0 = level.player scripts\engine\utility::waittill_any_return("weapon_fired", "damage") == "weapon_fired";

    if(var0) {
      level.player.last_weapon_fire_time = gettime();
      continue;
    }

    level.player.last_damaged_time = gettime();
  }
}

function wait_lookat_or_timeout(var0, var1, var2, var3, var4, var5, var6) {
  return scripts\sp\maps\hometown\hometown_util::wait_lookat(var0, var1, var3, var4, var5, var6, var2, 1);
}

function wait_lookat_ads_or_timeout(var0, var1, var2, var3, var4, var5, var6) {
  return wait_lookat_ads(var0, var1, var3, var4, var5, var6, var2);
}

function wait_lookat_ads(var0, var1, var2, var3, var4, var5, var6) {
  if(!istrue(var5)) {
    var5 = 0;
  }

  return scripts\sp\maps\hometown\hometown_util::wait_lookat(var0, var1, var2, var3, var4, var5, var6, 1);
}

function wait_lookaway(var0, var1, var2, var3, var4, var5, var6, var7) {
  return scripts\sp\maps\hometown\hometown_util::wait_lookat(var0, var1, var2, var3, var4, var5, var6, var7, 1);
}

function say_on_enemy_radio(var0, var1, var2) {
  var3 = 0;

  if(!istrue(var1) || isDefined(var2)) {
    var3 = wait_for_break_in_chatter(var2);
  }

  if(isDefined(var1) && !var1 && var3) {
    return;
  }

  var4 = getcorpsearrayinradius(level.player.origin, 1000);
  var5 = scripts\engine\utility::array_combine(var4, getaiarrayinradius(level.player.origin, 1000, "axis"));

  if(var5.size == 0) {
    return;
  }

  var6 = undefined;
  var7 = undefined;

  foreach(var9 in var5) {
    if(getsubstr(var9.classname, 0, 11) != "actor_enemy") {
      continue;
    }

    var10 = distance2dsquared(level.player.origin, var9 gettagorigin("j_chest"));

    if(!isDefined(var7) || var10 < var7) {
      var6 = var9;
      var7 = var10;
    }
  }

  if(!isDefined(var6)) {
    return;
  }

  var12 = var6 gettagorigin("j_chest");
  var13 = var6 gettagangles("j_chest");
  var14 = scripts\engine\utility::spawn_script_origin(var12, var13);
  var14 linkTo(var6, "j_chest");
  var14 thread scripts\engine\utility::call_on_notify("finished_speaking", &delete);
  thread say(var14, var0);
  var14 waittill("finished_speaking");
}

function call_nag_func(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  if(isarray(var0)) {
    var2 = var0;

    if(!isDefined(var1)) {
      var2 = scripts\engine\utility::array_remove_index(var2, 0);
    } else {
      GscBinSkip0(0x2e, 0, var1);
    }

    return call_with_params(var0[0], var2);
  }

  if(isDefined(var2)) {
    return self[[var1]](var2);
  }

  return self[[var1]]();
}

function wait_any_delay_pausable(var0, var1, var2) {
  jumpiftrue(isDefined(var0)) LOC_0000000b;
  return;
}

function wait_any_delay_type(var0, var1) {
  if(isDefined(var1)) {
    self endon(var1);
    level endon(var1);
  }

  if(!isDefined(var0)) {
    return;
  }

  if(isarray(var0)) {
    if(isbuiltinfunction(var0[0])) {
      call_with_params(var0[0], scripts\engine\utility::array_remove_index(var0, 0));
    } else if((isint(var0[0]) || isfloat(var0[0])) && (isint(var0[1]) || isfloat(var0[1]))) {
      wait randomfloatrange(var0[0], var0[1]);
    }
  } else if(isbuiltinfunction(var0)) {
    self[[var0]]();
  } else if(isstring(var0)) {
    scripts\engine\utility::waittill_any_ents(level, var0, self, var0);
  } else if(isint(var0) || isfloat(var0)) {
    wait var0;
  }

  return 1;
}

function wait_progress_delay(var0, var1) {
  var2 = var0[0];
  var3 = var0[1];
  var4 = var3 - var2;
  wait var2;
  var5 = gettime();
  jumpiftrue(isDefined(var1)) LOC_00000026;
  var1 = &get_player_progress_toward_self;

  for(;;) {
    if(isarray(var1)) {
      var6 = call_with_params(var1[0], scripts\engine\utility::array_remove_index(var1, 0));
    } else {
      var6 = self[[var1]]();
    }

    if(var6 > 0.7) {} else if(scripts\engine\utility::time_has_passed(var5, var4 * var6)) {
      break;
    }

    waitframe();
  }
}

function get_player_progress_toward_self() {
  var0 = level.player getvelocity();

  if(length2dsquared(var0) < 0.01) {
    return 0.5;
  }

  var1 = self.origin - level.player.origin;
  var2 = scripts\engine\math::anglebetweenvectors(var0, var1) / 180;
  return 1 - var2;
}

function state_goto(var0) {
  self notify("state_change", var0);
  self endon("state_change");
  self.state = var0;
  self[[var0]]();
}

function call_continuous(var0, var1, var2, var3) {
  self endon(var2);

  for(;;) {
    wait var0;

    if(isbuiltinfunction(var1)) {
      call_with_params(var1, var3);
      continue;
    }

    call_with_params_builtin(var1, var3);
  }
}

function statefunc1() {
  thread state_transitions();

  for(;;) {
    iprintlnbold("statefunc1");
    wait 1;
  }
}

function state_transitions() {
  level waittill("state_test_1");
  state_goto(&statefunc1);
}

function statefunc2() {
  for(;;) {
    iprintlnbold("statefunc2");
    wait 1;
  }
}

function statefunc3() {
  for(;;) {
    iprintlnbold("statefunc3");
    wait 1;
  }
}

function statefunc4() {
  for(;;) {
    iprintlnbold("statefunc4");
    wait 1;
  }
}

function statefunc5() {
  for(;;) {
    iprintlnbold("statefunc5");
    wait 1;
  }
}

function get_array_rule_token_value(var0, var1) {
  var2 = undefined;
  var3 = undefined;

  foreach(var5 in var0) {
    if(isDefined(var3)) {
      var2 = var3.facts[var5];
    }

    if(is_fact_str(var5)) {
      var2 = var1[fact_str_to_name(var5)];
    }

    if(!isDefined(var2)) {
      return;
    }

    if(!is_ent_or_struct(var2)) {
      return var2;
    }

    var3 = var2;
  }
}

function fact_str_to_name(var0) {
  return getsubstr(var0, 1, var0.size);
}

function waittill_any_fact_update(var0, var1) {
  var2 = [];
  var3 = [];

  foreach(var5 in var0) {
    var6 = undefined;
    var7 = undefined;
    var8 = undefined;

    foreach(var10 in var5) {
      if(isDefined(var7)) {
        var6 = var7.facts[var10];
      }

      if(is_fact_str(var10)) {
        var6 = var1[fact_str_to_name(var10)];
        var7 = var6;
        var2 = self;
        var3 = fact_str_to_name(var10);
        continue;
      }

      if(!isDefined(var6)) {
        break;
      }

      var2 = var7;
      var3 = var10;
      var7 = var6;
    }
  }

  var13 = spawnStruct();

  foreach(var15 in var2) {
    var15 childthread scripts\engine\utility::waittill_string("fact:" + var3[var16] + "_set", var13);
  }

  var13 waittill("returned", var17);
  var13 notify("die");
}

function is_valid_rule() {}

function thread_end_test() {
  thread_end_func(getthread(), &call_when_thread_ended);

  for(;;) {
    waitframe();
  }

  iprintlnbold("should never get here");
}

function thread_end_func(var0, var1) {
  if(isDefined(var0)) {}

  if(isDefined(var0)) {}

  thread thread_on_end(var0, var1);
}

function thread_on_end(var0, var1) {
  wait_thread_end(var0);
  self thread[[var1]]();
}

function wait_thread_end(var0) {
  if(isDefined(var0)) {}

  while(isDefined(var0)) {
    waitframe();
  }

  return true;
}

function call_when_thread_ended() {
  iprintlnbold("thread ended; func called; test successful");
}

function find_and_register_vo_source(var0, var1, var2, var3, var4) {
  if(!isDefined(var2) || !isstring(var2)) {
    var2 = var0;
  }

  if(!isDefined(var3) || !isstring(var3)) {
    var3 = "script_noteworthy";
  }

  if(isDefined(var4)) {
    var5 = getEntArray(var2, var3)[var4];
  } else {
    var5 = getEnt(var3, var4);
  }

  if(isDefined(var5)) {}

  register_vo_source(var5, var1, var2);
  return var5;
}

function register_vo_source_at_pos(var0, var1, var2) {
  var3 = spawn("script_origin", var2);
  var3.is_pos_vo_source = 1;
  register_vo_source(var3, var0, var1);
  return var3;
}

function register_vo_source(var0, var1) {
  if(!isDefined(var0) || !isstring(var0)) {}

  if(!isDefined(level.vo_sources)) {
    level.vo_sources = [];
  }

  if(isDefined(level.vo_sources[var0])) {
    unregister_vo_source(var0);
  }

  if(!isDefined(var1) || !isstring(var1)) {
    var1 = var0;
  }

  self.source_name = var0;
  self.display_name = var1;
  self.is_speaking = 0;
  level.vo_sources[var0] = self;
}

function print_display_name_on_source(var0) {
  self endon("death");

  for(;;) {
    waitframe();
  }
}

function register_vo_source_attached(var0, var1, var2, var3) {
  var4 = self;
  var5 = var4 gettagorigin(var2);

  if(isDefined(var3)) {
    var6 = spawn("script_origin", var5 + var3);
    var6 linkTo(var4, var2, var3);
  } else {
    var6 = spawn("script_origin", var6);
    var6 linkTo(var5, var3);
  }

  var6.is_pos_vo_source = 1;
  register_vo_source(var6, var1, var2);
}

function unregister_vo_source(var0) {
  if(!isDefined(level.vo_sources) || !isDefined(level.vo_sources[var0])) {
    return;
  }

  var1 = level.vo_sources[var0].is_pos_vo_source;

  if(isDefined(var1) && var1) {
    level.vo_sources[var0] delete();
  }

  level.vo_sources[var0].line_queue = undefined;
  level.vo_sources[var0].is_speaking = undefined;
  level.vo_sources[var0].display_name = undefined;
  level.vo_sources[var0] = undefined;
}

function unregister_all_vo_sources() {
  if(!isDefined(level.vo_sources)) {
    return;
  }

  level.vo_sources = scripts\engine\utility::array_removedead(level.vo_sources);

  foreach(var1 in level.vo_sources) {
    unregister_vo_source(var1.source_name);
  }
}

function get_vo_source(var0) {
  if(!isDefined(level.vo_sources) || !isDefined(level.vo_sources[var0])) {
    return undefined;
  }

  var1 = level.vo_sources[var0];
  return var1;
}

function get_any_vo_source_is_speaking() {
  return isDefined(get_any_speaking_vo_source());
}

function get_any_speaking_vo_source() {
  foreach(var1 in level.vo_sources) {
    if(var1.is_speaking) {
      return var1;
    }
  }

  return undefined;
}

function wait_all_vo_sources_finish_speaking() {
  for(;;) {
    var0 = get_any_speaking_vo_source();

    if(isDefined(var0)) {
      wait_vo_source_finish_speaking(var0.source_name);
      continue;
    }

    break;
  }
}

function get_vo_source_is_speaking(var0) {
  var1 = level.vo_sources[var0];
  return var1.is_speaking;
}

function wait_vo_source_finish_speaking(var0) {
  if(!isDefined(level.vo_sources) || is_dead_or_dying(level.vo_sources[var0])) {
    return;
  }

  var1 = level.vo_sources[var0];
  var1 endon("death");

  if(!var1.is_speaking) {
    return;
  }

  var1 scripts\engine\utility::waittill_either("vo_interrupted", "vo_finished");
}

function create_vo_bucket(var0, var1, var2) {
  var3 = spawnStruct();
  var3.lines = [];
  var3.open_lines = [];
  var3.groups = [];
  var3.groups[0] = [];
  var3.current_group = 0;
  var3.fill_type = "single_group";

  if(isDefined(var2)) {
    var3.fill_type = var2;
  }

  var3.name = var0;
  var3.selection = 0;
  var3.sequential = 0;

  if(isDefined(var1)) {
    var3.sequential = var1;
  }

  var3.is_playing = 0;
  return var3;
}

function set_vo_bucket_fills_all(var0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var1 = self;

  if(!isDefined(var0)) {
    var0 = 1;
  }

  if(var0) {
    var1.fill_type = "all_groups";
    return;
  }

  var1.fill_type = "single_group";
}

function set_vo_bucket_selection(var0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var1 = self;
  var0 = tolower(var0);

  switch (var0) {
    case 0:
    case "weighted_random":
    case "weighted random":
    case "random":
      var1.selection = 0;
      break;
    case 1:
    case "highest_weight":
    case "highest weight":
    case "highest":
      var1.selection = 1;
      break;
    case 2:
    case "lowest_weight":
    case "lowest weight":
    case "lowest":
      var1.selection = 2;
      break;
    default:
      break;
  }
}

function set_vo_bucket_sequential(var0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var1 = self;
  var1.sequential = !isDefined(var0) || var0;
}

function get_vo_bucket_sequential(var0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var1 = self;
  var2 = var1.last_played;

  if(!isDefined(var2)) {
    var2 = var0[0];
  }

  if(!isDefined(var2.sequential)) {
    return var1.sequential;
  }

  return var2.sequential;
}

function add_vo_line_linked(var0, var1, var2, var3) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var4 = self;
  var5 = var4.lines[var4.lines.size - 1];
  var6 = add_vo_line(var1, var2, var3);
  var5.next = var6.index;
  var5.wait_time = var0;
  var6.weight = 0;
}

function add_vo_line(var0, var1, var2) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  if(isDefined(level.vo_sources[var0])) {}

  var3 = self;
  var4 = spawnStruct();
  var4.alias = var1;
  var4.index = var3.lines.size;
  var4.weight = 1;
  var4.times_played = 0;
  var4.blocking_ratio = 1;
  var4.notifies = [];
  var4.rules = [];

  if(!isDefined(var3.group_end_index)) {
    var3.open_lines[var4.index] = var4;
  }

  var3.lines[var4.index] = var4;
  var4.group = var3.groups.size - 1;
  var5 = var3.groups[var4.group].size;
  var3.groups[var4.group][var5] = var4;

  if(isDefined(var0) && isstring(var0)) {
    var4.source_name = var0;
  } else {
    var4.source_name = undefined;
  }

  if(isDefined(var2) && isstring(var2)) {
    var4.text = var2;
  } else {
    var4.text = var1;
  }

  var4.duration = get_vo_duration(var1);
  var4.scaled_duration = var4.duration;
  var3 notify("line_added", var4);
  return var4;
}

function set_vo_line_weight(var0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var1 = self;
  var1.lines[var1.lines.size - 1].weight = var0;
}

function set_vo_line_scale(var0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var1 = self;
  var1.lines[var1.lines.size - 1].blocking_ratio = var0;
}

function add_vo_line_scaled(var0, var1, var2, var3) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var4 = self;
  var5 = add_vo_line(var1, var2, var3);
  var5.scaled_duration = var5.duration * var0;
}

function add_vo_rule(var0, var1) {
  if(!isDefined(self) || !is_vo_bucket(self) && !is_vo_line(self)) {}

  var2 = undefined;
  var3 = undefined;

  if(is_vo_bucket(self)) {
    var2 = self;
  } else {
    var3 = self;
  }

  if(isDefined(var2) && var2.groups[var2.groups.size - 1].size == 0 && var2.groups.size > 1) {
    foreach(var5, var3 in var2.groups[var2.groups.size - 2]) {
      add_vo_rule(var3, var0, var1);
    }

    return;
  }

  if(isDefined(var4)) {
    var5 = var4.lines[var4.lines.size - 1];
  }

  var5.rules[var5.rules.size] = strtok(var2, " ");
}

function add_vo_rules_all(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(self) || !is_vo_bucket(self) && !is_vo_line(self)) {}

  var6 = undefined;
  var7 = undefined;

  if(is_vo_bucket(self)) {
    var6 = self;
  } else {
    var7 = self;
  }

  if(isDefined(var6) && var6.groups[var6.groups.size - 1].size == 0 && var6.groups.size > 1) {
    foreach(var9, var7 in var6.groups[var6.groups.size - 2]) {
      add_vo_rules_any(var7, var0, var1, var2, var3, var4, var5);
    }

    return;
  }

  if(isDefined(var8)) {
    var9 = var8.lines[var8.lines.size - 1];
  }

  if(isDefined(var2)) {
    add_vo_rule(var9, var2);
  }

  if(isDefined(var3)) {
    add_vo_rule(var9, var3);
  }

  if(isDefined(var4)) {
    add_vo_rule(var9, var4);
  }

  if(isDefined(var5)) {
    add_vo_rule(var9, var5);
  }

  if(isDefined(var6)) {
    add_vo_rule(var9, var6);
  }

  if(isDefined(var7)) {
    add_vo_rule(var9, var7);
    return;
  }
}

function add_vo_rules_any(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(self) || !is_vo_bucket(self) && !is_vo_line(self)) {}

  var6 = undefined;
  var7 = undefined;

  if(is_vo_bucket(self)) {
    var6 = self;
  } else {
    var7 = self;
  }

  if(isDefined(var6) && var6.groups[var6.groups.size - 1].size == 0 && var6.groups.size > 1) {
    foreach(var9, var7 in var6.groups[var6.groups.size - 2]) {
      add_vo_rules_any(var7, var0, var1, var2, var3, var4, var5);
    }

    return;
  }

  if(isDefined(var8)) {
    var9 = var8.lines[var8.lines.size - 1];
  }

  if(isDefined(var2)) {
    add_vo_rule(var9, var2);
  }

  if(isDefined(var3)) {
    add_vo_rule(var9, var3);
  }

  if(isDefined(var4)) {
    add_vo_rule(var9, var4);
  }

  if(isDefined(var5)) {
    add_vo_rule(var9, var5);
  }

  if(isDefined(var6)) {
    add_vo_rule(var9, var6);
  }

  if(isDefined(var7)) {
    add_vo_rule(var9, var7);
  }

  var9.rule_type = "any";
}

function add_vo_wait(var0, var1) {
  if(!isDefined(self) || !is_vo_bucket(self) && !is_vo_line(self)) {}

  var2 = undefined;
  var3 = undefined;

  if(is_vo_bucket(self)) {
    var2 = self;
  } else {
    var3 = self;
  }

  if(isDefined(var2) && var2.groups[var2.groups.size - 1].size == 0 && var2.groups.size > 1) {
    foreach(var5, var3 in var2.groups[var2.groups.size - 2]) {
      add_vo_wait(var3, var0, var1);
    }

    return;
  }

  if(isDefined(var4)) {
    var5 = var4.lines[var4.lines.size - 1];
  }

  if(!isDefined(var3) || var3) {
    var5.pre_wait_time = var2;
    return;
  }

  var5.wait_time = var2;
}

function add_vo_notify(var0, var1, var2) {
  if(!isDefined(self) || !is_vo_bucket(self) && !is_vo_line(self)) {}

  var3 = undefined;
  var4 = undefined;

  if(is_vo_bucket(self)) {
    var3 = self;
  } else {
    var4 = self;
  }

  if(isDefined(var3) && var3.groups[var3.groups.size - 1].size == 0 && var3.groups.size > 1) {
    foreach(var6, var4 in var3.groups[var3.groups.size - 2]) {
      add_vo_notify(var4, var0, var1);
    }

    return;
  }

  if(isDefined(var5)) {
    var6 = var5.lines[var5.lines.size - 1];
  }

  var6.notifies[var6.notifies.size] = [var2, var3, var4];
}

function get_total_line_duration() {
  if(!isDefined(self) || !is_vo_line(self)) {}

  var0 = self;
  var1 = var0.duration;

  if(isDefined(var0.pre_wait_time)) {
    var1 += var0.pre_wait_time;
  }

  if(isDefined(var0.wait_time)) {
    var1 += var0.wait_time;
  }

  return var1;
}

function end_vo_group(var0, var1, var2, var3) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var4 = self;

  if(var4.groups[var4.groups.size - 1].size == 0) {}

  var4 = self;

  if(isDefined(var0)) {
    foreach(var6 in var4.groups[var4.groups.size - 1]) {
      var6.sequential = var0;
    }
  }

  if(isDefined(var1)) {
    var8 = strtok(var1, " ");

    foreach(var6 in var4.groups[var4.groups.size - 1]) {
      var6.rules[var6.rules.size] = var8;
    }
  }

  if(isDefined(var2)) {
    foreach(var6 in var4.groups[var4.groups.size - 1]) {
      var6.wait_time = var2;
    }
  }

  if(isDefined(var3)) {
    foreach(var6 in var4.groups[var4.groups.size - 1]) {
      var6.weight = min(var6.weight, var3);
    }
  }

  var4.groups[var4.groups.size] = [];
  var4 notify("group_end_added");
}

function play_vo_bucket(var0, var1) {
  if(is_vo_bucket(self)) {}

  var2 = self;

  if(var2.lines.size == 0) {}

  var2 notify("started_playing");

  if(isDefined(var1)) {
    var3 = get_vo_line(var2, var1);
  } else {
    var3 = get_line_to_play(var3, var1);
  }

  var3.is_playing = 1;
  thread bucket_terminator(getthread());

  while(isDefined(var3)) {
    var3 notify("line_started", var3);
    var3.last_played = var3;
    var3.times_played++;
    remove_line_from_open(var3, var3);

    if(var3.open_lines.size == 0 && !isDefined(var3.group_end_index)) {
      var3 notify("bucket_emptied");
    }

    var4 = get_total_line_duration(var3);

    foreach(var6 in var3.notifies) {
      thread notify_after_time(var6[0] * var4, var6[1], var6[2]);
    }

    if(isDefined(var3.pre_wait_time)) {
      wait var3.pre_wait_time;
    }

    var8 = undefined;

    if(isDefined(var3.source_name)) {
      var8 = get_vo_source_from_line(var3);
      var9 = var8.is_speaking;
      thread play_vo_line(var3.source_name, var3.alias, var3.text);

      if(var9) {
        var8 waittill("vo_interrupted");
      }

      var10 = wait_vo_bucket_finish_or_interrupt(var3, var8);

      if(isDefined(var10)) {
        if(var10 == "stop") {
          var8 notify("stop_vo");
        }

        var3.endedby = var10;
        var3 notify("interrupted");
        return;
      }
    }

    var11 = var3;

    if(isDefined(var11.wait_time)) {
      wait var11.wait_time;
    }

    var3 = get_next(var3, var11);
    var3 notify("line_finished", var11);
    var3.last_finished = var11;
  }

  var3.endedby = "finish";
  var3 notify("finished");
}

function notify_after_time(var0, var1, var2) {
  wait var0;

  if(isDefined(var2)) {
    var2 notify(var1);
    return;
  }

  self notify(var1);
}

function get_next(var0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  if(!isDefined(var0) || !is_vo_line(var0)) {}

  var1 = self;

  if(!isDefined(var0.next)) {
    return;
  }

  return var1.lines[var0.next];
}

function call_func_set(var0) {
  if(var0[1]) {
    if(isDefined(var0[0])) {
      var0[0] thread[[var0[2]]]();
      return;
    }

    GscBinSkip1(0x74, var0[2]);
  }

  if(isDefined(var0[0])) {
    var0[0][[var0[2]]]();
    return;
  }

  [[var0[2]]]();
}

function wait_vo_bucket_finish_or_interrupt(var0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var1 = self;
  var0 endon("vo_finished");
  return scripts\engine\utility::waittill_any_ents_return(var1, "death", var1, "stop", var0, "death", var0, "vo_interrupted");
}

function bucket_terminator(var0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  if(isDefined(var0)) {}

  var1 = self;
  var1 endon("cancel_terminator");
  wait_thread_end(var0);
  var1.is_playing = 0;
  var1 notify("play_terminated");
  var1.endedby = undefined;
}

function get_vo_source_from_line(var0) {
  if(isDefined(var0)) {}

  if(isDefined(level.vo_sources)) {
    return level.vo_sources[var0.source_name];
  }
}

function play_vo_bucket_looping(var0, var1, var2) {
  if(is_vo_bucket(self)) {}

  var3 = self;
  var1 = isDefined(var1) && var1;
  var3 endon("death");
  var3 endon("stop");

  while(!isDefined(var2) || var2 > 0) {
    play_vo_bucket(var3);

    if(var1 && var3.open_lines.size == 0) {
      break;
    }

    if(isarray(var0)) {
      wait randomfloatrange(var0[0], var0[1]);
    } else {
      wait var0;
    }

    if(isDefined(var2)) {
      var2--;
    }
  }
}

function stop_vo_bucket() {
  if(is_vo_bucket(self)) {}

  var0 = self;
  var0 notify("stop");
}

function stop_all_vo_sources() {
  if(!isDefined(level.vo_sources)) {
    return;
  }

  foreach(var1 in level.vo_sources) {
    var1 notify("stop_vo");
  }
}

function stop_vo_source(var0) {
  var1 = undefined;

  if(isDefined(level.vo_sources) && isDefined(level.vo_sources[var0])) {
    var1 = level.vo_sources[var0];
  } else {
    return;
  }

  var1 notify("stop_vo");
}

function play_vo_line_delayed(var0, var1, var2, var3, var4) {
  wait var0;
  play_vo_line(var1, var2, var3, var4);
}

function play_vo_line(var0, var1, var2, var3) {
  var4 = undefined;

  if(isDefined(level.vo_sources) && isDefined(level.vo_sources[var0])) {
    var4 = level.vo_sources[var0];
  } else {
    return 0;
  }

  if(is_dead_or_dying(var4)) {
    return 0;
  }

  if(!soundexists(var1)) {
    return;
  }

  var4 endon("death");
  var4 notify("start_vo");

  if(var4.is_speaking) {
    var4 waittill("vo_interrupted");
  }

  thread playsound_vo(var4);
  return var4 scripts\engine\utility::waittill_any("vo_finished", "vo_interrupted");
}

function create_sound_origin_at_eye() {
  var0 = self;
  var1 = spawn("script_origin", var0.origin);
  var2 = var0 gettagorigin("tag_eye", 1);

  if(isDefined(var2)) {
    var1 linkTo(var0, "tag_eye");
  } else {
    var1 linkTo(var0);
  }

  return var1;
}

function get_vo_duration(var0) {
  var1 = lookupsoundlength(var0) / 1000;
  var1 = round_up_to_nearest_twentieth(var1 + 0.1);
  return var1;
}

function playsound_vo(var0) {
  var1 = self;
  var2 = 1;
  var2 = scripts\common\utility::issp() && isai(self) && isDefined(var2) && var2 && isDefined(var1.animname);

  if(var2) {
    thread play_smart_vo_interrupt(var1);
  } else if(issentient(var1)) {
    var1 playsoundatviewheight(var0);
  } else {
    var1 playSound(var0);
  }

  var3 = get_vo_duration(var0);
  var1.is_speaking = 1;
  wait_vo_line_finish(var1, var3);
}

function play_smart_vo_interrupt(var0) {
  self endon("vo_finished");
  self endon("vo_interrupted");

  if(self == level.player) {
    scripts\engine\sp\utility::smart_player_dialogue_interrupt(var0);
    return;
  }

  if(!isDefined(self.unittype)) {
    self.unittype = "none";
  }

  self stopsounds();
  waitframe();
  scripts\engine\sp\utility::smart_dialogue(var0);
}

function wait_vo_line_finish(var0) {
  var1 = self;
  var2 = waittill_any_or_timeout(var1, var0, ["start_vo", "stop_vo", "long_death", "death"]);

  if(isDefined(var1)) {
    var1.is_speaking = 0;

    if(istrue(var2)) {
      var1 notify("vo_finished");
      return;
    }

    if(var1 != level.player) {
      var1 stopsounds();
    }

    var1 notify("vo_interrupted");
    return;
  }
}

function mark_speaker(var0) {
  var1 = self;
  var1 endon("vo_finished");
  var1 endon("vo_interrupted");
  var2 = gettime();
  var3 = ".";

  for(;;) {
    if(issentient(var1)) {
      var4 = var1 getEye();
    } else {
      var4 = var1.origin;
    }

    if(scripts\engine\utility::time_has_passed(var2, var0 / 3)) {
      var2 = gettime();
      var3 += ".";
    }

    waitframe();
  }
}

function waittill_any_or_timeout(var0, var1) {
  foreach(var3 in var1) {
    self endon(var3);
  }

  wait var0;
  return true;
}

function round_up_to_nearest_twentieth(var0) {
  return scripts\engine\math::round_float(var0 * 2, 1, 0) / 2;
}

function is_vo_bucket(var0) {
  return isDefined(var0.lines);
}

function is_vo_line(var0) {
  return isDefined(var0.text) || isDefined(var0.alias);
}

function is_ent_or_struct(var0) {
  return isent(var0) || isstruct(var0);
}

function remove_line_from_open(var0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  if(isDefined(var0)) {}

  var1 = self;
  var2 = [];
  var3 = 0;

  foreach(var5 in var1.open_lines) {
    if(var5 != var0 && var3 == 0) {
      var2 = var5;
    }

    var3 = isDefined(var5.next);
  }

  var1.open_lines = var2;
}

function vo_bucket_is_empty() {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var0 = self;
  return var0.open_lines.size == 0;
}

function refill(var0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var1 = self;

  if(var1.fill_type == "single_group") {
    if(!isDefined(var0)) {
      var0 = 1;
    }

    if(var0 && var1.groups.size > 1) {
      var1.current_group = clamp_looping(var1.current_group + 1, 0, var1.groups.size - 1);
    }

    var1.open_lines = var1.groups[var1.current_group];
  } else {
    var1.open_lines = var1.lines;
  }

  var1 notify("bucket_filled");
}

function clamp_looping(var0, var1, var2) {
  if(var2 <= var1) {}

  var3 = var2 - var1;

  while(var0 > var2) {
    var0 %= var2;
  }

  while(var0 < var1) {
    var0 += var3;
  }

  return var0;
}

function get_valid_lines(var0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  if(!isDefined(var0) || !isarray(var0)) {}

  var1 = self;
  var2 = [];

  foreach(var4 in var1.open_lines) {
    if(var4.weight == 0 || evaluate_rules(var4, var0) == 0) {
      continue;
    }

    var2 = var4;
  }

  return var2;
}

function evaluate_rules(var0) {
  if(!isDefined(self) || !is_vo_line(self)) {}

  var1 = self;

  if(isDefined(var1.rule_type) && var1.rule_type == "any") {
    foreach(var3 in var1.rules) {
      if(eval(var3, var0) == 1) {
        return 1;
      }
    }

    return 0;
  }

  foreach(var3 in var4.rules) {
    if(eval(var3, var3) == 0) {
      return 0;
    }
  }

  return 1;
}

function eval(var0, var1) {
  if(var0.size == 1) {
    return get_rule_token_value(var0[0], var1);
  }

  var0 = get_rule_token_value(var0[0], var1);
  var0 = get_rule_token_value(var0[2], var1);

  if(!isDefined(var0[0]) || !isDefined(var0[2])) {
    return 0;
  }

  var2 = compare_values(var0[0], var0[1], var0[2]);

  if(var0.size == 5) {
    var3 = [var0[2], var0[3], var0[4]];
    return (var2 && eval(var3));
  } else if(var1.size > 5) {}

  return var3;
}

function get_rule_result(var0, var1, var2) {
  var0 = strtok(var0, "|");
  var2 = strtok(var2, "|");

  foreach(var4 in var0) {
    foreach(var6 in var2) {
      if(compare_values(var4, var1, var6)) {
        return true;
      }
    }
  }

  return false;
}

function compare_values(var0, var1, var2) {
  if(isarray(var1)) {
    var1 = var1[0];
  }

  switch (var1) {
    case "<":
      var3 = var0 < var2;
      break;
    case ">":
      var3 = var1 > var3;
      break;
    case ">=":
      var3 = var2 >= var3;
      break;
    case "<=":
      var3 = var3 <= var3;
      break;
    case "==":
    case "=":
      var3 = var3 == var3;
      break;
    case "!=":
      var3 = var3 != var3;
      break;
    default:
      var3 = 0;
      break;
  }

  return var3;
}

function get_rule_token_value(var0, var1) {
  if(isarray(var0)) {
    if(var0.size == 1) {
      var0 = var0[0];
    } else {
      return get_array_rule_token_value(var0, var1);
    }
  }

  if(!isstring(var0)) {
    return var0;
  }

  if(is_fact_str(var0)) {
    return get_fact_value_from_context(var0, var1);
  }

  if(var0 == "0") {
    return 0;
  }

  if(float(var0)) {
    return float(var0);
  }

  if(var0 == "true") {
    return 1;
  }

  if(var0 == "false") {
    return 0;
  }

  return var0;
}

function is_fact_str(var0) {
  return var0[0] == "'";
}

function get_fact_value_from_context(var0, var1) {
  var0 = getsubstr(var0, 1, var0.size);
  var2 = var1[var0];

  if(isDefined(var2)) {}

  return var2;
}

function get_line_to_play(var0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var1 = self;

  if(isDefined(var0)) {
    var2 = get_valid_lines(var0);
  } else {
    var2 = var2.open_lines;
  }

  if(var2.fill_type == "single_group") {
    var3 = var2.current_group;

    while(var2.size == 0) {
      refill(var2);

      if(isDefined(var1)) {
        var2 = get_valid_lines(var1);
      } else {
        var2 = var2.open_lines;
      }

      if(var2.current_group == var3) {
        break;
      }
    }
  } else if(var2.size == 0) {
    refill(var2);

    if(isDefined(var1)) {
      var2 = get_valid_lines(var1);
    } else {
      var2 = var2.open_lines;
    }
  }

  if(var2.size == 0) {
    return;
  }

  if(get_vo_bucket_sequential(var2, var2)) {
    return var2[0];
  }

  return get_random_line(var2, var2);
}

function get_random_line(var0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var1 = self;
  var2 = 0;

  foreach(var4 in var0) {
    var5 = isDefined(var1.last_finished) && var4 == var1.last_finished;
    var6 = get_vo_source_from_line(var4);

    if(!var5 && !is_dead_or_dying(var6)) {
      var2 += abs(var4.weight);
    }
  }

  if(var2 == 0) {
    return;
  } else {
    var8 = randomfloatrange(0, var2);
  }

  foreach(var4 in var0) {
    var6 = get_vo_source_from_line(var4);
    var5 = isDefined(var1.last_finished) && var4 == var1.last_finished;
    var10 = is_dead_or_dying(var6);

    if(var5 || var10) {
      continue;
    }

    if(var4.weight >= var8) {
      return var4;
    }

    var8 -= abs(var4.weight);
  }
}

function get_vo_line(var0) {
  if(!isDefined(self) || !is_vo_bucket(self)) {}

  var1 = self;

  foreach(var3 in var1.lines) {
    if(var3.alias == var0) {
      return var3;
    }
  }
}

function display_ai_keys(var0) {
  level notify("started_displaying_keys");
  level endon("started_displaying_keys");

  for(;;) {
    var1 = undefined;
    var2 = undefined;
    var3 = undefined;

    if(!isDefined(var0)) {
      var0 = getaispeciesarray();
    }

    foreach(var5 in var0) {
      if(!isDefined(var5) || distance2dsquared(var5.origin, level.player.origin) > 1000000) {
        continue;
      }

      var6 = level.player worldpointtoscreenpos(var5.origin + (0, 0, 40), getdvarint("MRNKTKLLKP"));

      if(!isDefined(var6) || !var5 scripts\engine\utility::hastag(var5.model, "j_head")) {
        continue;
      }

      var7 = distance2dsquared((0, 0, 0), var6);

      if(!isDefined(var2) || var7 < var2) {
        var1 = var5;
        var2 = var7;
        var3 = var8;
      }
    }

    if(isDefined(var1)) {
      print_key_strings(var1, var3);
    }

    waitframe();
  }
}

function print_key_strings(var0) {
  var1 = 0;
  var2 = self;
  var3 = var2 gettagorigin("j_head");

  if(isDefined(self.script_noteworthy)) {
    var4 = getEntArray(self.script_noteworthy, "script_noteworthy");
    var0 = undefined;

    if(var4.size > 1) {
      foreach(var6 in var4) {
        if(var6 == self) {
          var0 = var7;
        }
      }
    }

    if(isDefined(var0)) {}

    var1++;
  }

  if(isDefined(self.targetname)) {
    var1++;
  }

  if(isDefined(self.target)) {
    var1++;
  }

  if(isDefined(self.script_linkname)) {
    var1++;
  }

  if(isDefined(self.code_classname)) {
    var1++;
  }

  if(isDefined(self.classname)) {
    var1++;
  }

  if(isDefined(self.script_friendname)) {
    var1++;
  }

  if(isDefined(self.animname)) {
    var1++;
  }

  if(isDefined(self.bcname)) {
    var1++;
  }

  var1++;

  if(isDefined(var0)) {
    var1++;
    return;
  }
}

function print_position_values() {
  var0 = get_nice_text_elem(100);
  var1 = get_nice_text_elem(84);
  var2 = -100000;
  var3 = (0, 0, 0);

  for(;;) {
    var4 = level.player.origin;

    if(!isDefined(var4)) {
      var4 = "undefined";
    }

    if(level.player meleeButtonPressed()) {
      var2 = gettime();
      scripts\engine\utility::launcher_write_clipboard(var4);
      var3 = var4;
    }

    if(scripts\engine\utility::time_has_passed(var2, 1.2)) {
      var0.label = "^3PLAYER POS: ^7" + var4;
    } else {
      var0.label = "^2POS COPIED: ^7" + var3;
    }

    var4 = distance2d(level.player.origin, var3);
    var1.label = "^3COPY DIST: ^7" + var4;
    waitframe();
  }
}

function get_nice_text_elem(var0) {
  var1 = newhudelem();
  var1.elemtype = "font";
  var1.fontscale = 0.8;
  var1.sort = 10;
  var1.label = "";
  var1.alpha = 0;
  var1 fadeovertime(0.2);
  var1.alpha = 1;
  var1.alignx = "left";
  var1.aligny = "bottom";
  var1.x = -80;
  var1.y = var0;
  var2 = newhudelem();
  var2.x = -85;
  var2.y = var0 - 5;
  var2.alignx = "left";
  var2.aligny = "middle";
  var2.sort = 9;
  var2.alpha = 0.4;
  var2 setshader("black", 200, 15);
  var1.bg = var2;
  return var1;
}

function string_remove(var0, var1) {
  if(!isDefined(var0) || !isstring(var0) || !isDefined(var1) || !isstring(var1)) {
    return undefined;
  }

  var2 = "";

  for(var3 = 0; var3 < var0.size; var3++) {
    var4 = var0[var3];

    if(var4 != var1) {
      var2 += var4;
    }
  }

  return var2;
}

function wrap_text(var0, var1) {
  var2 = strtok(var0, " ");
  var3 = "";
  var4 = [];
  var5 = 0;
  var6 = 0;

  foreach(var8 in var2) {
    if(var6 > var1) {
      var4 = var3;
      var3 = "";
      var6 = 0;
    }

    var6 += var8.size;
    var3 += var8;

    if(var5 != var2.size - 1) {
      var3 += " ";
    } else {
      var4 = var3;
    }

    var5++;
  }

  return var4;
}

function int_min(var0, var1) {
  if(!isDefined(var0)) {
    return var1;
  }

  if(!isDefined(var1)) {
    return var0;
  }

  if(var0 < var1) {
    return int(var0);
  }

  return int(var1);
}

function average_velocity(var0) {
  var1 = (0, 0, 0);

  for(var2 = 0; var2 < var0.size - 1; var2++) {
    var1 += var0[var2 + 1] - var0[var2];
  }

  return var1 / var0.size - 1;
}

function array_add_size_limited(var0, var1, var2) {
  var0 = var1;

  if(var0.size <= var2) {
    return var0;
  }

  var3 = var0.size - var2;
  var4 = [];
  var5 = 0;

  if(var5 < var2) {
    GscBinSkip0(0x2e, var5, var0[var3]);
  }
}

function get_at_goalpos(var0, var1) {
  if(isai(self)) {}

  if(!isDefined(var0)) {
    var0 = self.goalpos;
  }

  if(!isDefined(var1)) {
    var1 = self.goalradius;
  }

  return distance2dsquared(self.origin, var0) < var1 * var1;
}

function wait_goalpos(var0, var1, var2) {
  if(isai(self)) {}

  if(isDefined(var1)) {
    self endon(var1);
    level endon(var1);
  }

  while(!get_at_goalpos(var0, var2)) {
    self waittill("goal");
  }

  return true;
}

function wait_goalpos_or_msg(var0, var1, var2) {
  if(scripts\engine\utility::flag_exist(var0) && scripts\engine\utility::flag(var0)) {
    return false;
  }

  return wait_goalpos(var1, var0, var2);
}

function goalpos_and_nagtill(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = wait_goalpos_or_msg(var1, undefined, 40);
  nagtill_delayed(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
  return istrue(var10);
}