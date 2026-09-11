/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\lab\lab_vo_util.gsc
***********************************************/

function init_drone_vo() {
  scripts\engine\utility::flag_wait("allow_green_beam");
  level endon("allow_green_beam");
  var_0 = ["dx_vom_pri_drone_tutorial_intro_30", "dx_vom_pri_drone_tutorial_intro_40", "dx_vom_pri_drone_tutorial_intro_50"];
  level.drone_nags = scripts\engine\sp\utility::create_deck(var_0);
  GscBinSkip4(0x35);
}

function uninit_drone_vo() {
  scripts\engine\utility::flag_waitopen("allow_green_beam");
  level.drone_nags = undefined;
}

function vo_use_drone_nags(var_0) {
  level endon("green_beam_target_confirmed");
  wait var_0;
  var_1 = 6.85;

  for(var_2 = 0.8;; var_2 = min(var_2 * 1.2, 5)) {
    level.price waittill("weapon_fired");
    say_as_chatter(level.price, level.drone_nags scripts\engine\sp\utility::deck_draw(), 0, 1);
    scripts\engine\utility::flag_set("start_green_beam_instruct");
    wait randomfloatrange(var_1 - var_2, var_1 + var_2);
    var_1 = min(var_1 * 1.45, 20);
  }
}

function vo_drone_confirms() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "dx_vom_uavoperator_drone_tutorial_laseconf_10");
}

function vo_drone_hit() {
  var_0 = [];
  var_1 = [];
  GscBinSkip0(0x2e, var_1.size, "dx_vom_pri_drone_tutorial_success_10");
}

function vo_drone_no_mark() {
  var_0 = ["dx_vom_uavoperator_drone_tutorial_nomark_10", "dx_vom_uavoperator_drone_tutorial_nomark_20", "dx_vom_uavoperator_drone_tutorial_nomark_30"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);

  for(;;) {
    level waittill("green_beam_error");

    if(level.player.greenbeamerror == "hit_none") {
      say_as_chatter(level, var_1 scripts\engine\sp\utility::deck_draw(), 0, 1);
    }
  }
}

function vo_drone_friendlies_neg() {
  var_0 = ["dx_vom_uavoperator_drone_tutorial_noshot_10", "dx_vom_uavoperator_drone_tutorial_noshot_20", "dx_vom_uavoperator_drone_tutorial_noshot_30"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);

  for(;;) {
    level waittill("green_beam_error");

    if(level.player.greenbeamerror == "allies_too_close") {
      say_as_chatter(level, var_1 scripts\engine\sp\utility::deck_draw(), 0, 1);
    }
  }
}

function vo_drone_negative() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "dx_vom_uavoperator_drone_tutorial_laseconf_notready_10");
}

function vo_drone_cooldown() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "dx_vom_uavoperator_drone_tutorial_laseconf_out_10");
}

function init_callout_vo() {
  level.vo_callouts = spawnStruct();
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "dx_vom_pri_hill_bottom_callout_helicopter_10");
}

function say(var_0, var_1) {
  if(!soundexists(var_0)) {
    return false;
  }

  if(is_dead_or_dying(self)) {
    return false;
  }

  self notify("started_speaking", var_0);
  self.lastspoketime = gettime();
  self.lastaliassaid = var_0;

  if(istrue(var_1)) {
    if(isstruct(self)) {
      scripts\engine\sp\utility::smart_radio_dialogue_interrupt(var_0);
    } else if(isPlayer(self)) {
      scripts\engine\sp\utility::smart_player_dialogue_interrupt(var_0);
    } else if(isDefined(self.animname)) {
      self stopsounds();
      waitframe();
      scripts\engine\sp\utility::smart_dialogue(var_0);
    } else {
      if(issentient(self)) {
        self playsoundatviewheight(var_0);
      } else {
        self playSound(var_0);
      }

      wait lookupsoundlength(var_0) / 1000;
    }
  } else if(isstruct(self)) {
    scripts\engine\sp\utility::smart_radio_dialogue(var_0);
  } else if(isPlayer(self)) {
    scripts\engine\sp\utility::smart_player_dialogue(var_0);
  } else if(isDefined(self.animname)) {
    scripts\engine\sp\utility::smart_dialogue(var_0);
  } else {
    if(issentient(self)) {
      self playsoundatviewheight(var_0);
    } else {
      self playSound(var_0);
    }

    wait lookupsoundlength(var_0) / 1000;
  }

  self notify("finished_speaking", var_0);
  return true;
}

function is_speaking() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid)) {
    return 0;
  }

  return scripts\engine\utility::time_has_passed(self.lastspoketime, lookupsoundlength(self.lastaliassaid) / 1000);
}

function time_since_spoke() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid)) {
    return undefined;
  }

  var_0 = self.lastspoketime + lookupsoundlength(self.lastaliassaid);
  return (gettime() - var_0) / 1000;
}

function say_sequence(var_0, var_1) {
  var_2 = self;

  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  foreach(var_4 in var_0) {
    var_2 = say_vo_item(var_2, var_4, var_1);
  }
}

function say_vo_item(var_0, var_1) {
  var_2 = self;

  if(isarray(var_0)) {
    if((isint(var_0[0]) || isfloat(var_0[0])) && isint(var_0[1]) || isfloat(var_0[1])) {
      wait randomfloatrange(var_0[0], var_0[1]);
    } else if(isbuiltinfunction(var_0[0]) || isbuiltinmethod(var_0[0]) || isanimation(var_0[0])) {
      call_with_params(var_2, var_0[0], var_0[1]);
    }

    return var_2;
  }

  if(isent(var_0) || isstruct(var_0)) {
    var_2 = var_0;
  } else if(isstring(var_0)) {
    say(var_2, var_0, var_1);
  } else if(isint(var_0) || isfloat(var_0)) {
    wait var_0;
  } else if(isbuiltinfunction(var_0) || isbuiltinmethod(var_0) || isanimation(var_0)) {
    call_with_params(var_2, var_0);
  } else if(scripts\engine\sp\utility::is_deck(var_0)) {
    var_2 = say_vo_item(var_2, var_0 scripts\engine\sp\utility::deck_draw(), var_1);
  }

  return var_2;
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

function say_as_chatter(var_0, var_1, var_2) {
  return do_as_chatter(&say, [var_0, var_1], var_1, var_2);
}

function say_sequence_as_chatter(var_0, var_1, var_2) {
  return do_as_chatter(&say_sequence, [var_0], var_1, var_2);
}

function wait_for_break_in_chatter(var_0) {
  var_1 = spawnStruct();
  var_2 = 0;

  if(!level.vo_chatter.speaking) {
    return 1;
  }

  level.vo_chatter.waiting = scripts\engine\utility::array_add(level.vo_chatter.waiting, var_1);

  if(isDefined(var_0)) {
    var_2 = var_1 scripts\engine\utility::waittill_notify_or_timeout_return("proceed", var_0) == "timeout";
  } else {
    var_1 waittill("proceed");
  }

  level.vo_chatter.waiting = scripts\engine\utility::array_remove(level.vo_chatter.waiting, var_1);
  return var_2;
}

function do_as_chatter(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.vo_chatter)) {
    thread init_chatter();
  }

  level.vo_chatter endon("terminate_chatter");
  var_4 = spawnStruct();
  thread do_as_chatter_internal(var_0, var_1, var_2, var_3, var_4);
  var_4 waittill("done", var_5);
  return var_5;
}

function do_as_chatter_internal(var_0, var_1, var_2, var_3, var_4) {
  level.vo_chatter endon("terminate_chatter");

  if(level.vo_chatter.speaking && (!istrue(var_2) || isDefined(var_3))) {
    var_5 = wait_for_break_in_chatter(var_3);
  } else {
    var_5 = 0;
  }

  var_6 = undefined;

  if(!level.vo_chatter.speaking || !var_5 || istrue(var_3)) {
    level.vo_chatter notify("started_speaking", self, var_1, var_2);
    level.vo_chatter.speaking++;
    var_6 = call_with_params(var_1, var_2);
    level.vo_chatter.speaking--;
    level.vo_chatter notify("done_speaking", self, var_1, var_2);
  }

  if(!level.vo_chatter.speaking && isDefined(level.vo_chatter.waiting[0])) {
    level.vo_chatter.waiting[0] notify("proceed");
  }

  var_5 notify("done", var_6);
}

function compare(var_0, var_1) {
  if(isarray(var_0)) {
    if(isarray(var_1)) {
      return compare_arrays(var_0, var_1);
    }

    return 0;
  }

  if(isarray(var_1)) {
    return 0;
  }

  return var_0 == var_1;
}

function compare_arrays(var_0, var_1) {
  if(var_0.size != var_1.size) {
    return false;
  }

  foreach(var_3 in var_0) {
    if(!isDefined(var_1[var_5])) {
      return false;
    }

    var_4 = var_1[var_5];

    if(compare(var_4, var_3)) {
      return false;
    }
  }

  return true;
}

function array_deck_shuffle() {
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
    return;
  }
}

function call_with_params(var_0, var_1) {
  if(isbuiltinfunction(var_0)) {
    return call_with_params_script(var_0, var_1);
  }

  if(isbuiltinmethod(var_0) || isanimation(var_0)) {
    return call_with_params_builtin(var_0, var_1);
  }
}

function call_with_params_script(var_0, var_1) {
  if(!isDefined(var_1)) {
    return self[[var_0]]();
  }

  if(!isarray(var_1)) {
    return self[[var_0]](var_1);
  }

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

function call_with_params_builtin(var_0, var_1) {
  if(!isDefined(var_1)) {
    return self[[var_0]]();
  }

  if(!isarray(var_1)) {
    return self builtin[[var_0]](var_1);
  }

  switch (var_1.size) {
    case 0:
      return self builtin[[var_0]]();
    case 1:
      return self builtin[[var_0]](var_1[0]);
    case 2:
      return self builtin[[var_0]](var_1[0], var_1[1]);
    case 3:
      return self builtin[[var_0]](var_1[0], var_1[1], var_1[2]);
    case 4:
      return self builtin[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3]);
    case 5:
      return self builtin[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4]);
    case 6:
      return self builtin[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5]);
    case 7:
      return self builtin[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6]);
    case 8:
      return self builtin[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7]);
    case 9:
      return self builtin[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8]);
    default:
      break;
  }
}

function is_dead_or_dying(var_0) {
  if(!isDefined(var_0)) {
    return true;
  }

  if(isai(var_0)) {
    return (!isalive(var_0) || var_0 scripts\engine\utility::doinglongdeath());
  } else if(issentient(var_0)) {
    return !isalive(var_0);
  }

  return false;
}

function nagtill_open(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return nagtill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 1);
}

function nagtill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_2 = default_if_undefined(var_2, 8);
  var_3 = default_if_undefined(var_3, 2);
  var_4 = default_if_undefined(var_4, 1.2);
  var_5 = default_if_undefined(var_5, 1.2);
  var_6 = default_if_undefined(var_6, 45);
  var_7 = default_if_undefined(var_7, 5);

  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      var_0[0] endon(var_0[1]);
    } else {
      var_9 = scripts\engine\utility::flag_exist(var_0) && scripts\engine\utility::ter_op(istrue(var_8), !scripts\engine\utility::flag(var_0), scripts\engine\utility::flag(var_0));

      if(var_9) {
        return;
      }

      level endon(var_0);
    }
  }

  jumpiffalse(isarray(var_1)) LOC_000000a8;
  var_1 = scripts\engine\sp\utility::create_deck(var_1);

  for(;;) {
    if(var_1 scripts\engine\sp\utility::deck_is_empty()) {
      array_deck_shuffle(var_1);
    }

    var_10 = var_1 scripts\engine\sp\utility::deck_draw();

    if(isarray(var_10)) {
      say_as_chatter(var_10[0], var_10[1]);
    } else {
      say_as_chatter(var_10);
    }

    wait randomfloatrange(var_2 - var_3, var_2 + var_3);
    var_2 = min(var_2 * var_4, var_6);
    var_3 = min(var_3 * var_5, var_7);
  }
}

function default_if_undefined(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = var_1;
  }

  return var_0;
}

function hill_pa_say(var_0, var_1) {
  var_2 = get_closest_pa_object("hill");
  say(var_2, var_0, var_1);
}

function turbines_pa_say(var_0, var_1) {
  var_2 = get_closest_pa_object("turbines");
  say(var_2, var_0, var_1);
}

function hill_pa_chatter_say(var_0, var_1, var_2) {
  var_3 = get_closest_pa_object("hill");
  say_as_chatter(var_3, var_0, var_1, var_2);
}

function turbines_pa_chatter_say(var_0, var_1, var_2) {
  var_3 = get_closest_pa_object("turbines");
  say_as_chatter(var_3, var_0, var_1, var_2);
}

function get_closest_pa_object(var_0) {
  if(!isDefined(var_0)) {
    var_1 = scripts\engine\utility::array_combine(getEntArray("hill_speakers", "script_noteworthy"), getEntArray("turbines_speakers", "script_noteworthy"));
  } else {
    var_1 = getEntArray(var_1 + "_speakers", "script_noteworthy");
  }

  if(var_1.size == 0) {
    return level.player;
  }

  return sortbydistance(var_1, level.player.origin)[0];
}

function say_on_kill_ai_type(var_0, var_1, var_2) {
  for(;;) {
    level waittill("ai_killed", var_3, var_4, var_5, var_6);

    if(var_4 != self) {
      continue;
    }

    if(get_ai_type(var_3) != var_1) {
      continue;
    }

    say_as_chatter(var_0);
    break;
  }
}

function get_ai_type() {
  var_0 = strtok(self.classname, "_");
  return var_0[var_0.size - 1];
}

function wait_combat_cooldown(var_0, var_1) {
  while(!isDefined(var_1) || var_1 > 0) {
    if(!recently_in_combat(var_0)) {
      return false;
    }

    waitframe();

    if(isDefined(var_1)) {
      var_1 -= 0.05;
    }
  }

  return true;
}

function recently_in_combat(var_0) {
  var_1 = isDefined(level.player.last_weapon_fire_time) && !scripts\engine\utility::time_has_passed(level.player.last_weapon_fire_time, var_0);
  var_2 = isDefined(level.player.last_damaged_time) && !scripts\engine\utility::time_has_passed(level.player.last_damaged_time, var_0);
  return level.player isfiring() || var_1 || var_2;
}

function track_player_combat_time() {
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

function display_all_last_anims() {
  for(;;) {
    var_0 = getEntArray();

    foreach(var_2 in var_0) {
      if(!isDefined(var_2) || !isDefined(var_2.animname) || !isDefined(var_2._lastanime)) {}
    }

    waitframe();
  }
}

function get_last_anim_name() {
  return self._lastanime;
}

function get_last_anim_frame() {
  return (gettime() - self.last_anim_time) / 1000 * 30;
}

function easy_position_creator() {
  for(;;) {
    while(!level.player useButtonPressed()) {
      waitframe();
    }

    iprintlnbold("Position Created");
    self notify("position_created");
    thread new_position("position_created");

    while(level.player useButtonPressed()) {
      waitframe();
    }
  }
}

function new_position(var_0) {
  if(isDefined(var_0)) {
    self endon(var_0);
  }

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
      var_4 += 2;
      continue;
    }

    var_4 -= 2;
  }
}

function draw_cool_circle_til_notify(var_0, var_1, var_2, var_3) {
  level endon(var_2);

  for(;;) {
    draw_cool_circle(var_0, var_1);
    waitframe();
  }
}

function draw_cool_circle_for_time(var_0, var_1, var_2, var_3) {
  while(!isDefined(var_2) || var_2 > 0) {
    draw_cool_circle();
    waitframe();

    if(isDefined(var_2)) {
      var_2 -= 0.05;
    }
  }
}

function draw_cool_circle(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = 50;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    scripts\engine\utility::draw_circle(var_0 + (0, 0, var_2), var_1, (1, 1, 1), 1 - var_4 / var_3, 1, 1);
    var_2 += 0.5 * var_1 / 80;
  }
}

function label_rebels() {
  for(;;) {
    if(isalive(level.rebel_1)) {}

    if(isalive(level.rebel_2)) {}

    if(isalive(level.rebel_3)) {}

    waitframe();
  }
}

function ambush_is_looking_left() {
  return level.player.angles[1] < -60 && level.player.angles[1] > -125;
}

function ambush_is_looking_forward() {
  return level.player.angles[1] < -135 || level.player.angles[1] > 135;
}

function simple_dialogue(var_0) {
  self notify("stop_simple_dialogue");
  self playsoundatviewheight(var_0);

  if(isDefined(level.scr_face[self.animname][var_0])) {
    childthread scripts\common\anim::anim_single_solo(self, var_0);
  }

  wait lookupsoundlength(var_0) / 1000;
}

function simple_dialogue_on_tag(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "j_head";
  }

  self stopsounds();
  self notify("stop_simple_dialogue");
  var_3 = spawn("script_origin", self gettagorigin(var_1));
  var_3 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  var_3 playSound(var_0, "sounddone");

  if(isDefined(level.scr_face[self.animname][var_0])) {
    childthread scripts\common\anim::anim_single_solo(self, var_0);
  }

  thread delete_org_on_finish(var_3, var_2);
  var_3 waittill("finish");
}

function delete_org_on_finish(var_0, var_1) {
  if(istrue(var_1)) {
    scripts\engine\utility::waittill_any_ents(self, "stop_simple_dialogue", var_0, "sounddone", self, "death");
  } else {
    scripts\engine\utility::waittill_any_ents(self, "stop_simple_dialogue", var_0, "sounddone");
  }

  var_0 notify("finish");
  var_0 stopsounds();
  wait 0.05;
  var_0 delete();
}