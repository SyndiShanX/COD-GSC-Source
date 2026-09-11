/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\lab\lab_vo_util.gsc
***********************************************/

function init_drone_vo() {
  scripts\engine\utility::flag_wait("allow_green_beam");
  level endon("allow_green_beam");
  var0 = ["dx_vom_pri_drone_tutorial_intro_30", "dx_vom_pri_drone_tutorial_intro_40", "dx_vom_pri_drone_tutorial_intro_50"];
  level.drone_nags = scripts\engine\sp\utility::create_deck(var0);
  GscBinSkip4(0x35);
}

function uninit_drone_vo() {
  scripts\engine\utility::flag_waitopen("allow_green_beam");
  level.drone_nags = undefined;
}

function vo_use_drone_nags(var0) {
  level endon("green_beam_target_confirmed");
  wait var0;
  var1 = 6.85;

  for(var2 = 0.8;; var2 = min(var2 * 1.2, 5)) {
    level.price waittill("weapon_fired");
    say_as_chatter(level.price, level.drone_nags scripts\engine\sp\utility::deck_draw(), 0, 1);
    scripts\engine\utility::flag_set("start_green_beam_instruct");
    wait randomfloatrange(var1 - var2, var1 + var2);
    var1 = min(var1 * 1.45, 20);
  }
}

function vo_drone_confirms() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_uavoperator_drone_tutorial_laseconf_10");
}

function vo_drone_hit() {
  var0 = [];
  var1 = [];
  GscBinSkip0(0x2e, var1.size, "dx_vom_pri_drone_tutorial_success_10");
}

function vo_drone_no_mark() {
  var0 = ["dx_vom_uavoperator_drone_tutorial_nomark_10", "dx_vom_uavoperator_drone_tutorial_nomark_20", "dx_vom_uavoperator_drone_tutorial_nomark_30"];
  var1 = scripts\engine\sp\utility::create_deck(var0);

  for(;;) {
    level waittill("green_beam_error");

    if(level.player.greenbeamerror == "hit_none") {
      say_as_chatter(level, var1 scripts\engine\sp\utility::deck_draw(), 0, 1);
    }
  }
}

function vo_drone_friendlies_neg() {
  var0 = ["dx_vom_uavoperator_drone_tutorial_noshot_10", "dx_vom_uavoperator_drone_tutorial_noshot_20", "dx_vom_uavoperator_drone_tutorial_noshot_30"];
  var1 = scripts\engine\sp\utility::create_deck(var0);

  for(;;) {
    level waittill("green_beam_error");

    if(level.player.greenbeamerror == "allies_too_close") {
      say_as_chatter(level, var1 scripts\engine\sp\utility::deck_draw(), 0, 1);
    }
  }
}

function vo_drone_negative() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_uavoperator_drone_tutorial_laseconf_notready_10");
}

function vo_drone_cooldown() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_uavoperator_drone_tutorial_laseconf_out_10");
}

function init_callout_vo() {
  level.vo_callouts = spawnStruct();
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_pri_hill_bottom_callout_helicopter_10");
}

function say(var0, var1) {
  if(!soundexists(var0)) {
    return false;
  }

  if(is_dead_or_dying(self)) {
    return false;
  }

  self notify("started_speaking", var0);
  self.lastspoketime = gettime();
  self.lastaliassaid = var0;

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

function say_sequence_as_chatter(var0, var1, var2) {
  return do_as_chatter(&say_sequence, [var0], var1, var2);
}

function wait_for_break_in_chatter(var0) {
  var1 = spawnStruct();
  var2 = 0;

  if(!level.vo_chatter.speaking) {
    return 1;
  }

  level.vo_chatter.waiting = scripts\engine\utility::array_add(level.vo_chatter.waiting, var1);

  if(isDefined(var0)) {
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

function nagtill_open(var0, var1, var2, var3, var4, var5, var6, var7) {
  return nagtill(var0, var1, var2, var3, var4, var5, var6, var7, 1);
}

function nagtill(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var2 = default_if_undefined(var2, 8);
  var3 = default_if_undefined(var3, 2);
  var4 = default_if_undefined(var4, 1.2);
  var5 = default_if_undefined(var5, 1.2);
  var6 = default_if_undefined(var6, 45);
  var7 = default_if_undefined(var7, 5);

  if(isDefined(var0)) {
    if(isarray(var0)) {
      var0[0] endon(var0[1]);
    } else {
      var9 = scripts\engine\utility::flag_exist(var0) && scripts\engine\utility::ter_op(istrue(var8), !scripts\engine\utility::flag(var0), scripts\engine\utility::flag(var0));

      if(var9) {
        return;
      }

      level endon(var0);
    }
  }

  jumpiffalse(isarray(var1)) LOC_000000a8;
  var1 = scripts\engine\sp\utility::create_deck(var1);

  for(;;) {
    if(var1 scripts\engine\sp\utility::deck_is_empty()) {
      array_deck_shuffle(var1);
    }

    var10 = var1 scripts\engine\sp\utility::deck_draw();

    if(isarray(var10)) {
      say_as_chatter(var10[0], var10[1]);
    } else {
      say_as_chatter(var10);
    }

    wait randomfloatrange(var2 - var3, var2 + var3);
    var2 = min(var2 * var4, var6);
    var3 = min(var3 * var5, var7);
  }
}

function default_if_undefined(var0, var1) {
  if(!isDefined(var0)) {
    var0 = var1;
  }

  return var0;
}

function hill_pa_say(var0, var1) {
  var2 = get_closest_pa_object("hill");
  say(var2, var0, var1);
}

function turbines_pa_say(var0, var1) {
  var2 = get_closest_pa_object("turbines");
  say(var2, var0, var1);
}

function hill_pa_chatter_say(var0, var1, var2) {
  var3 = get_closest_pa_object("hill");
  say_as_chatter(var3, var0, var1, var2);
}

function turbines_pa_chatter_say(var0, var1, var2) {
  var3 = get_closest_pa_object("turbines");
  say_as_chatter(var3, var0, var1, var2);
}

function get_closest_pa_object(var0) {
  if(!isDefined(var0)) {
    var1 = scripts\engine\utility::array_combine(getEntArray("hill_speakers", "script_noteworthy"), getEntArray("turbines_speakers", "script_noteworthy"));
  } else {
    var1 = getEntArray(var1 + "_speakers", "script_noteworthy");
  }

  if(var1.size == 0) {
    return level.player;
  }

  return sortbydistance(var1, level.player.origin)[0];
}

function say_on_kill_ai_type(var0, var1, var2) {
  for(;;) {
    level waittill("ai_killed", var3, var4, var5, var6);

    if(var4 != self) {
      continue;
    }

    if(get_ai_type(var3) != var1) {
      continue;
    }

    say_as_chatter(var0);
    break;
  }
}

function get_ai_type() {
  var0 = strtok(self.classname, "_");
  return var0[var0.size - 1];
}

function wait_combat_cooldown(var0, var1) {
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

function display_all_last_anims() {
  for(;;) {
    var0 = getEntArray();

    foreach(var2 in var0) {
      if(!isDefined(var2) || !isDefined(var2.animname) || !isDefined(var2._lastanime)) {}
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

function new_position(var0) {
  if(isDefined(var0)) {
    self endon(var0);
  }

  var1 = anglesToForward(level.player getplayerangles());
  var2 = scripts\engine\trace::ray_trace_detail(level.player getEye(), level.player getEye() + var1 * 1000, level.player);
  var3 = var2["position"];
  var4 = 40;
  var5 = 0;
  level.player notifyonplayercommand("left_resize", "+actionslot 2");
  level.player notifyonplayercommand("right_resize", "+actionslot 4");

  for(;;) {
    iprintlnbold(var3 + ", " + var4);
    scripts\engine\utility::launcher_write_clipboard("( " + var3 + ", " + var4 + " );");
    level notify("cool_circle_resize");
    thread draw_cool_circle_til_notify(var3, var4, "cool_circle_resize", var5);
    var6 = level.player scripts\engine\utility::waittill_any_return("right_resize", "left_resize");

    if(var6 == "right_resize") {
      var4 += 2;
      continue;
    }

    var4 -= 2;
  }
}

function draw_cool_circle_til_notify(var0, var1, var2, var3) {
  level endon(var2);

  for(;;) {
    draw_cool_circle(var0, var1);
    waitframe();
  }
}

function draw_cool_circle_for_time(var0, var1, var2, var3) {
  while(!isDefined(var2) || var2 > 0) {
    draw_cool_circle();
    waitframe();

    if(isDefined(var2)) {
      var2 -= 0.05;
    }
  }
}

function draw_cool_circle(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 0;
  }

  var3 = 50;

  for(var4 = 0; var4 < var3; var4++) {
    scripts\engine\utility::draw_circle(var0 + (0, 0, var2), var1, (1, 1, 1), 1 - var4 / var3, 1, 1);
    var2 += 0.5 * var1 / 80;
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

function simple_dialogue(var0) {
  self notify("stop_simple_dialogue");
  self playsoundatviewheight(var0);

  if(isDefined(level.scr_face[self.animname][var0])) {
    childthread scripts\common\anim::anim_single_solo(self, var0);
  }

  wait lookupsoundlength(var0) / 1000;
}

function simple_dialogue_on_tag(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = "j_head";
  }

  self stopsounds();
  self notify("stop_simple_dialogue");
  var3 = spawn("script_origin", self gettagorigin(var1));
  var3 linkTo(self, var1, (0, 0, 0), (0, 0, 0));
  var3 playSound(var0, "sounddone");

  if(isDefined(level.scr_face[self.animname][var0])) {
    childthread scripts\common\anim::anim_single_solo(self, var0);
  }

  thread delete_org_on_finish(var3, var2);
  var3 waittill("finish");
}

function delete_org_on_finish(var0, var1) {
  if(istrue(var1)) {
    scripts\engine\utility::waittill_any_ents(self, "stop_simple_dialogue", var0, "sounddone", self, "death");
  } else {
    scripts\engine\utility::waittill_any_ents(self, "stop_simple_dialogue", var0, "sounddone");
  }

  var0 notify("finish");
  var0 stopsounds();
  wait 0.05;
  var0 delete();
}