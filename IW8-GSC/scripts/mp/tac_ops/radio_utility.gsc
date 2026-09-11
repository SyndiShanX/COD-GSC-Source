/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\tac_ops\radio_utility.gsc
************************************************/

function initialize_radio() {
  level.tacopsradio = [];
  thread radiowatchplayerjoin();
}

function radiowatchplayerjoin() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    level.tacopsradio[var_0 scripts\mp\utility\player::getuniqueid()] = spawn("script_model", (0, 0, 0));
  }
}

function queue_dialogue(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2)) {
    function_stack_clear(level.tacopsradio[var_1 scripts\mp\utility\player::getuniqueid()]);
  }

  var_4 = 0;

  if(!isDefined(var_3)) {
    var_4 = thread function_stack(level.tacopsradio[var_1 scripts\mp\utility\player::getuniqueid()], &play_mp_sound, var_0);
  } else {
    var_4 = thread function_stack_timeout(level.tacopsradio[var_1 scripts\mp\utility\player::getuniqueid()], var_3, &play_mp_sound, var_0);
  }

  return var_4;
}

function queue_dialogue_for_team(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2)) {
    foreach(var_5 in scripts\mp\utility\teams::getteamdata(var_1, "players")) {
      function_stack_clear(level.tacopsradio[var_5 scripts\mp\utility\player::getuniqueid()]);
    }
  }

  var_7 = 0;

  foreach(var_5 in scripts\mp\utility\teams::getteamdata(var_1, "players")) {
    if(!isDefined(var_3)) {
      var_7 = thread function_stack(level.tacopsradio[var_5 scripts\mp\utility\player::getuniqueid()], &play_mp_sound, var_0);
      continue;
    }

    var_7 = thread function_stack_timeout(level.tacopsradio[var_5 scripts\mp\utility\player::getuniqueid()], var_3, &play_mp_sound, var_0);
  }

  return var_7;
}

function play_mp_sound(var_0, var_1, var_2) {
  var_1 playlocalsound(var_0, var_2);
  var_3 = lookupsoundlength(var_0);
  wait 0.5 + var_3 / 1000;

  if(isDefined(var_2)) {
    self notify(var_2);
    return;
  }
}

function function_stack(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  thread function_stack_proc(var_6, self, var_0, var_1, var_2, var_3, var_4);
  return function_stack_wait_finish(var_6);
}

function function_stack_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  thread function_stack_proc(var_7, self, var_1, var_2, var_3, var_4, var_5);

  if(isDefined(var_7.function_stack_func_begun) || var_7 scripts\engine\utility::ref_143b9(var_0, "function_stack_func_begun") != "timeout") {
    return function_stack_wait_finish(var_7);
  }

  var_7 notify("death");
  return 0;
}

function function_stack_clear() {
  if(!isDefined(self.function_stack)) {
    return;
  }

  var_0 = [];

  if(isDefined(self.function_stack[0]) && isDefined(self.function_stack[0].function_stack_func_begun)) {
    GscBinSkip0(0x2e, 0, self.function_stack[0]);
  }

  self.function_stack = undefined;
  self notify("clear_function_stack");
  waittillframeend();

  if(!var_0.size) {
    return;
  }

  if(!var_0[0].function_stack_func_begun) {
    return;
  }

  self.function_stack = var_0;
}

function function_stack_wait(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::waittill_either("function_done", "death");
}

function function_stack_wait_finish(var_0) {
  function_stack_wait(var_0);

  if(!isDefined(self)) {
    return false;
  }

  if(!issentient(self)) {
    return true;
  }

  if(isalive(self)) {
    return true;
  }

  return false;
}

function function_stack_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");

  if(!isDefined(var_0.function_stack)) {
    var_0.function_stack = [];
  }

  var_0.function_stack[var_0.function_stack.size] = self;
  thread function_stack_self_death(var_0);
  function_stack_caller_waits_for_turn(var_0);

  if(isDefined(var_0) && isDefined(var_0.function_stack)) {
    self.function_stack_func_begun = 1;
    self notify("function_stack_func_begun");

    if(isDefined(var_6)) {
      var_0[[var_1]](var_2, var_3, var_4, var_5, var_6);
    } else if(isDefined(var_5)) {
      var_0[[var_1]](var_2, var_3, var_4, var_5);
    } else if(isDefined(var_4)) {
      var_0[[var_1]](var_2, var_3, var_4);
    } else if(isDefined(var_3)) {
      var_0[[var_1]](var_2, var_3);
    } else if(isDefined(var_2)) {
      var_0[[var_1]](var_2);
    } else {
      var_0[[var_1]]();
    }

    if(isDefined(var_0) && isDefined(var_0.function_stack)) {
      var_0.function_stack = scripts\engine\utility::array_remove(var_0.function_stack, self);
      var_0 notify("level_function_stack_ready");
    }
  }

  if(isDefined(self)) {
    self.function_stack_func_begun = 0;
    self notify("function_done");
    return;
  }
}

function function_stack_self_death(var_0) {
  self endon("function_done");
  self waittill("death");

  if(isDefined(var_0)) {
    var_0.function_stack = scripts\engine\utility::array_remove(var_0.function_stack, self);
    var_0 notify("level_function_stack_ready");
    return;
  }
}

function function_stack_caller_waits_for_turn(var_0) {
  var_0 endon("death");
  self endon("death");
  var_0 endon("clear_function_stack");

  while(var_0.function_stack[0] != self) {
    var_0 waittill("level_function_stack_ready");
  }
}

function bcs_scripted_dialogue_start() {
  anim.scripteddialoguestarttime = gettime();
}