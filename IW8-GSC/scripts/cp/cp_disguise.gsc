/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_disguise.gsc
***********************************************/

function create_state_machine_for_ai(var_0, var_1) {
  var_0.i_current_state = 0;
  var_0.i_previous_state = 69;

  if(istrue(var_1)) {
    thread run_scripted_state_machine_nonarc();
    return;
  }

  thread run_scripted_state_machine();
}

function run_scripted_anim(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_1)) {}

  if(istrue(var_3)) {
    if(istrue(var_4)) {}

    if(istrue(var_5)) {}

    if(istrue(var_6)) {}
  } else if(istrue(var_4)) {
    if(istrue(var_3)) {}

    if(istrue(var_5)) {}

    if(istrue(var_6)) {}
  } else if(istrue(var_5)) {
    if(istrue(var_3)) {}

    if(istrue(var_4)) {}

    if(istrue(var_6)) {}
  } else if(istrue(var_6)) {
    if(istrue(var_3)) {}

    if(istrue(var_4)) {}

    if(istrue(var_5)) {}
  }

  var_7 = spawnStruct();
  var_7.animalias = var_0;
  var_7.early_return = var_1;
  var_7.looped = var_2;
  var_8 = 69;

  if(istrue(var_3)) {
    var_8 = 3;
  } else if(istrue(var_4)) {
    var_8 = 2;
  } else if(istrue(var_5)) {
    var_8 = 1;
  } else if(istrue(var_6)) {
    var_8 = 0;
  }

  self notify("change_state", var_8, var_7);
}

function run_scripted_state_machine() {
  for(;;) {
    self waittill("change_state", var_0, var_1);
    var_2 = var_1.animalias;
    var_3 = var_1.early_return;
    var_4 = var_1.looped;

    if(self.i_current_state == var_0 && var_0 != 0) {
      continue;
    }

    self.i_previous_state = self.i_current_state;
    self.i_current_state = var_0;

    switch (var_0) {
      case 0:
        thread run_ai_anim(var_2);
        break;
      case 1:
        thread run_ai_anim(var_2);
        break;
      case 2:
        thread run_ai_anim(var_2);
        break;
      case 3:
        run_ai_anim(var_2);
        break;
    }
  }
}

function run_scripted_state_machine_nonarc() {
  for(;;) {
    self waittill("change_state", var_0, var_1);
    var_2 = var_1.animalias;
    var_3 = var_1.early_return;
    var_4 = var_1.looped;

    if(self.i_current_state == var_0 && var_0 != 0) {
      continue;
    }

    self.i_previous_state = self.i_current_state;
    self.i_current_state = var_0;

    switch (var_0) {
      case 0:
        thread run_ai_anim_nonarc(var_2);
        break;
      case 1:
        thread run_ai_anim_nonarc(var_2);
        break;
      case 2:
        thread run_ai_anim_nonarc(var_2);
        break;
      case 3:
        run_ai_anim_nonarc(var_2);
        break;
    }
  }
}

function run_ai_anim_nonarc(var_0, var_1, var_2) {
  if(isDefined(var_1)) {}

  if(var_0 == "") {
    return;
  }

  if(!istrue(var_2)) {
    return;
  }
}

function run_ai_anim(var_0, var_1, var_2) {
  if(isDefined(var_1)) {}

  if(var_0 == "") {
    return;
  }

  if(!istrue(var_2)) {
    if(isDefined(var_1)) {
      scripts\asm\shared\mp\utility::burningdown(var_0, var_1);
      return;
    }

    scripts\asm\shared\mp\utility::burndowntime(var_0);
    return;
  }

  self endon("change_state");

  if(isDefined(var_1)) {
    scripts\asm\shared\mp\utility::bunkermusicstarted(var_0, var_1);
    return;
  }

  scripts\asm\shared\mp\utility::bunkerinteriorkeypads(var_0);
}

function clear_scripted_anim() {
  self.allowpain = 1;
  scripts\asm\shared\mp\utility::bunkercounteruav();
  self unlink();

  if(isDefined(self.scripted_anim_settings)) {
    self[[self.scripted_anim_settings]]();
  }

  if(isDefined(self.anchor)) {
    self.anchor delete();
    return;
  }
}

function break_out_of_disguise_loop() {
  self notify("break_out_of_disguise_loop");
  self endon("break_out_of_disguise_loop");
  self endon("delete_disguise_threads_on_player");
  self notifyonplayercommand("ads", "+speed_throw");
  self notifyonplayercommand("fire", "+attack");
  self notifyonplayercommand("lethal", "+frag");
  self notifyonplayercommand("tactical", "+smoke");
  self.fired_commands = [];
  add_command_to_action_tracker("ads");
  add_command_to_action_tracker("fire");
  add_command_to_action_tracker("lethal");
  add_command_to_action_tracker("tactical");

  for(;;) {
    var_0 = scripts\engine\utility::ref_143af("ads", "fire", "lethal", "tactical");

    if(scripts\engine\utility::array_contains(level.technicals[0].occupants, self)) {
      continue;
    }

    commands_requested_recently(var_0);
  }
}

function add_command_to_action_tracker(var_0) {
  self.fired_commands[var_0] = 0;
}

function commands_requested_recently(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("commands_registered_recently");
  self endon("commands_registered_recently");
  self.fired_commands[var_0]++;

  if(self.fired_commands["fire"] > 4 || self.fired_commands["ads"] > 4 || self.fired_commands["lethal"] > 4 || self.fired_commands["tactical"] > 4) {}

  thread reduce_command_count_after_duration(3.5, var_0);
}

function reduce_command_count_after_duration(var_0, var_1) {
  self endon("disconnect");
  self endon("delete_disguise_threads_on_player");
  wait var_0;
  self.fired_commands[var_1]--;

  if(self.fired_commands[var_1] <= 0) {
    self.fired_commands[var_1] = 0;

    if(self.fired_commands["fire"] <= 0) {
      set_demeanor("relaxed");
      return;
    }

    return;
  }
}

function set_demeanor_func() {
  set_demeanor("normal");
}

function set_demeanor_for_duration(var_0) {
  self notify("set_demeanor_for_duration");
  self endon("set_demeanor_for_duration");
  self endon("delete_disguise_threads_on_player");
  set_demeanor("normal");
  wait var_0;
  set_demeanor("relaxed");
}

function set_demeanor(var_0) {
  switch (var_0) {
    case "normal":
      enter_demeanor_normal();
      break;
    case "safe":
      enter_demeanor_safe();
      break;
    case "relaxed":
      enter_demeanor_relaxed();
      break;
  }
}

function enter_demeanor_safe() {
  thread set_demeanor_code_think("safe", "iw8_ges_demeanor_safe");
  thread demeanor_exit_func_wait(&exit_demeanor_safe);
}

function exit_demeanor_safe() {}

function enter_demeanor_relaxed() {
  thread set_demeanor_code_think("relaxed", "iw8_ges_demeanor_relaxed");
  thread demeanor_exit_func_wait(&exit_demeanor_relaxed);
}

function exit_demeanor_relaxed() {}

function demeanor_exit_func_wait(var_0) {
  self waittill("entering_new_demeanor");
  self[[var_0]]();
}

function set_demeanor_code_think(var_0, var_1) {
  self endon("entering_new_demeanor");
  self endon("death");
  var_2 = 0;

  for(;;) {
    if(isDefined(var_1)) {
      var_2 = self setdemeanorviewmodel(var_0, var_1);
    } else {
      var_2 = self setdemeanorviewmodel(var_0);
    }

    if(var_2) {
      break;
    }

    wait 0.05;
  }
}

function enter_demeanor_normal() {
  thread set_demeanor_code_think("normal");
  thread demeanor_exit_func_wait(&exit_demeanor_normal);
}

function exit_demeanor_normal() {}

function disable_features_for_disguised_player(var_0) {
  var_0 scripts\common\utility::allow_ads(0);
  var_0 scripts\common\utility::allow_fire(0);
}

function enable_features_for_disguised_player(var_0) {
  var_0 scripts\common\utility::allow_ads(1);
  var_0 scripts\common\utility::allow_fire(1);
}