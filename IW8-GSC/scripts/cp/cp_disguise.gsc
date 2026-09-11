/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_disguise.gsc
***********************************************/

function create_state_machine_for_ai(var0, var1) {
  var0.i_current_state = 0;
  var0.i_previous_state = 69;

  if(istrue(var1)) {
    thread run_scripted_state_machine_nonarc();
    return;
  }

  thread run_scripted_state_machine();
}

function run_scripted_anim(var0, var1, var2, var3, var4, var5, var6) {
  if(isDefined(var1)) {}

  if(istrue(var3)) {
    if(istrue(var4)) {}

    if(istrue(var5)) {}

    if(istrue(var6)) {}
  } else if(istrue(var4)) {
    if(istrue(var3)) {}

    if(istrue(var5)) {}

    if(istrue(var6)) {}
  } else if(istrue(var5)) {
    if(istrue(var3)) {}

    if(istrue(var4)) {}

    if(istrue(var6)) {}
  } else if(istrue(var6)) {
    if(istrue(var3)) {}

    if(istrue(var4)) {}

    if(istrue(var5)) {}
  }

  var7 = spawnStruct();
  var7.animalias = var0;
  var7.early_return = var1;
  var7.looped = var2;
  var8 = 69;

  if(istrue(var3)) {
    var8 = 3;
  } else if(istrue(var4)) {
    var8 = 2;
  } else if(istrue(var5)) {
    var8 = 1;
  } else if(istrue(var6)) {
    var8 = 0;
  }

  self notify("change_state", var8, var7);
}

function run_scripted_state_machine() {
  for(;;) {
    self waittill("change_state", var0, var1);
    var2 = var1.animalias;
    var3 = var1.early_return;
    var4 = var1.looped;

    if(self.i_current_state == var0 && var0 != 0) {
      continue;
    }

    self.i_previous_state = self.i_current_state;
    self.i_current_state = var0;

    switch (var0) {
      case 0:
        thread run_ai_anim(var2);
        break;
      case 1:
        thread run_ai_anim(var2);
        break;
      case 2:
        thread run_ai_anim(var2);
        break;
      case 3:
        run_ai_anim(var2);
        break;
    }
  }
}

function run_scripted_state_machine_nonarc() {
  for(;;) {
    self waittill("change_state", var0, var1);
    var2 = var1.animalias;
    var3 = var1.early_return;
    var4 = var1.looped;

    if(self.i_current_state == var0 && var0 != 0) {
      continue;
    }

    self.i_previous_state = self.i_current_state;
    self.i_current_state = var0;

    switch (var0) {
      case 0:
        thread run_ai_anim_nonarc(var2);
        break;
      case 1:
        thread run_ai_anim_nonarc(var2);
        break;
      case 2:
        thread run_ai_anim_nonarc(var2);
        break;
      case 3:
        run_ai_anim_nonarc(var2);
        break;
    }
  }
}

function run_ai_anim_nonarc(var0, var1, var2) {
  if(isDefined(var1)) {}

  if(var0 == "") {
    return;
  }

  if(!istrue(var2)) {
    return;
  }
}

function run_ai_anim(var0, var1, var2) {
  if(isDefined(var1)) {}

  if(var0 == "") {
    return;
  }

  if(!istrue(var2)) {
    if(isDefined(var1)) {
      scripts\asm\shared\mp\utility::burningdown(var0, var1);
      return;
    }

    scripts\asm\shared\mp\utility::burndowntime(var0);
    return;
  }

  self endon("change_state");

  if(isDefined(var1)) {
    scripts\asm\shared\mp\utility::bunkermusicstarted(var0, var1);
    return;
  }

  scripts\asm\shared\mp\utility::bunkerinteriorkeypads(var0);
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
    var0 = scripts\engine\utility::ref_143af("ads", "fire", "lethal", "tactical");

    if(scripts\engine\utility::array_contains(level.technicals[0].occupants, self)) {
      continue;
    }

    commands_requested_recently(var0);
  }
}

function add_command_to_action_tracker(var0) {
  self.fired_commands[var0] = 0;
}

function commands_requested_recently(var0) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("commands_registered_recently");
  self endon("commands_registered_recently");
  self.fired_commands[var0]++;

  if(self.fired_commands["fire"] > 4 || self.fired_commands["ads"] > 4 || self.fired_commands["lethal"] > 4 || self.fired_commands["tactical"] > 4) {}

  thread reduce_command_count_after_duration(3.5, var0);
}

function reduce_command_count_after_duration(var0, var1) {
  self endon("disconnect");
  self endon("delete_disguise_threads_on_player");
  wait var0;
  self.fired_commands[var1]--;

  if(self.fired_commands[var1] <= 0) {
    self.fired_commands[var1] = 0;

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

function set_demeanor_for_duration(var0) {
  self notify("set_demeanor_for_duration");
  self endon("set_demeanor_for_duration");
  self endon("delete_disguise_threads_on_player");
  set_demeanor("normal");
  wait var0;
  set_demeanor("relaxed");
}

function set_demeanor(var0) {
  switch (var0) {
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

function demeanor_exit_func_wait(var0) {
  self waittill("entering_new_demeanor");
  self[[var0]]();
}

function set_demeanor_code_think(var0, var1) {
  self endon("entering_new_demeanor");
  self endon("death");
  var2 = 0;

  for(;;) {
    if(isDefined(var1)) {
      var2 = self setdemeanorviewmodel(var0, var1);
    } else {
      var2 = self setdemeanorviewmodel(var0);
    }

    if(var2) {
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

function disable_features_for_disguised_player(var0) {
  var0 scripts\common\utility::allow_ads(0);
  var0 scripts\common\utility::allow_fire(0);
}

function enable_features_for_disguised_player(var0) {
  var0 scripts\common\utility::allow_ads(1);
  var0 scripts\common\utility::allow_fire(1);
}