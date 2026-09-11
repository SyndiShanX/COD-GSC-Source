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
    level waittill("connected", var0);
    level.tacopsradio[var0 scripts\mp\utility\player::getuniqueid()] = spawn("script_model", (0, 0, 0));
  }
}

function queue_dialogue(var0, var1, var2, var3) {
  if(isDefined(var2)) {
    function_stack_clear(level.tacopsradio[var1 scripts\mp\utility\player::getuniqueid()]);
  }

  var4 = 0;

  if(!isDefined(var3)) {
    var4 = thread function_stack(level.tacopsradio[var1 scripts\mp\utility\player::getuniqueid()], &play_mp_sound, var0);
  } else {
    var4 = thread function_stack_timeout(level.tacopsradio[var1 scripts\mp\utility\player::getuniqueid()], var3, &play_mp_sound, var0);
  }

  return var4;
}

function queue_dialogue_for_team(var0, var1, var2, var3) {
  if(isDefined(var2)) {
    foreach(var5 in scripts\mp\utility\teams::getteamdata(var1, "players")) {
      function_stack_clear(level.tacopsradio[var5 scripts\mp\utility\player::getuniqueid()]);
    }
  }

  var7 = 0;

  foreach(var5 in scripts\mp\utility\teams::getteamdata(var1, "players")) {
    if(!isDefined(var3)) {
      var7 = thread function_stack(level.tacopsradio[var5 scripts\mp\utility\player::getuniqueid()], &play_mp_sound, var0);
      continue;
    }

    var7 = thread function_stack_timeout(level.tacopsradio[var5 scripts\mp\utility\player::getuniqueid()], var3, &play_mp_sound, var0);
  }

  return var7;
}

function play_mp_sound(var0, var1, var2) {
  var1 playlocalsound(var0, var2);
  var3 = lookupsoundlength(var0);
  wait 0.5 + var3 / 1000;

  if(isDefined(var2)) {
    self notify(var2);
    return;
  }
}

function function_stack(var0, var1, var2, var3, var4, var5) {
  var6 = spawnStruct();
  thread function_stack_proc(var6, self, var0, var1, var2, var3, var4);
  return function_stack_wait_finish(var6);
}

function function_stack_timeout(var0, var1, var2, var3, var4, var5, var6) {
  var7 = spawnStruct();
  thread function_stack_proc(var7, self, var1, var2, var3, var4, var5);

  if(isDefined(var7.function_stack_func_begun) || var7 scripts\engine\utility::ref_143b9(var0, "function_stack_func_begun") != "timeout") {
    return function_stack_wait_finish(var7);
  }

  var7 notify("death");
  return 0;
}

function function_stack_clear() {
  if(!isDefined(self.function_stack)) {
    return;
  }

  var0 = [];

  if(isDefined(self.function_stack[0]) && isDefined(self.function_stack[0].function_stack_func_begun)) {
    GscBinSkip0(0x2e, 0, self.function_stack[0]);
  }

  self.function_stack = undefined;
  self notify("clear_function_stack");
  waittillframeend();

  if(!var0.size) {
    return;
  }

  if(!var0[0].function_stack_func_begun) {
    return;
  }

  self.function_stack = var0;
}

function function_stack_wait(var0) {
  self endon("death");
  var0 scripts\engine\utility::waittill_either("function_done", "death");
}

function function_stack_wait_finish(var0) {
  function_stack_wait(var0);

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

function function_stack_proc(var0, var1, var2, var3, var4, var5, var6) {
  self endon("death");

  if(!isDefined(var0.function_stack)) {
    var0.function_stack = [];
  }

  var0.function_stack[var0.function_stack.size] = self;
  thread function_stack_self_death(var0);
  function_stack_caller_waits_for_turn(var0);

  if(isDefined(var0) && isDefined(var0.function_stack)) {
    self.function_stack_func_begun = 1;
    self notify("function_stack_func_begun");

    if(isDefined(var6)) {
      var0[[var1]](var2, var3, var4, var5, var6);
    } else if(isDefined(var5)) {
      var0[[var1]](var2, var3, var4, var5);
    } else if(isDefined(var4)) {
      var0[[var1]](var2, var3, var4);
    } else if(isDefined(var3)) {
      var0[[var1]](var2, var3);
    } else if(isDefined(var2)) {
      var0[[var1]](var2);
    } else {
      var0[[var1]]();
    }

    if(isDefined(var0) && isDefined(var0.function_stack)) {
      var0.function_stack = scripts\engine\utility::array_remove(var0.function_stack, self);
      var0 notify("level_function_stack_ready");
    }
  }

  if(isDefined(self)) {
    self.function_stack_func_begun = 0;
    self notify("function_done");
    return;
  }
}

function function_stack_self_death(var0) {
  self endon("function_done");
  self waittill("death");

  if(isDefined(var0)) {
    var0.function_stack = scripts\engine\utility::array_remove(var0.function_stack, self);
    var0 notify("level_function_stack_ready");
    return;
  }
}

function function_stack_caller_waits_for_turn(var0) {
  var0 endon("death");
  self endon("death");
  var0 endon("clear_function_stack");

  while(var0.function_stack[0] != self) {
    var0 waittill("level_function_stack_ready");
  }
}

function bcs_scripted_dialogue_start() {
  anim.scripteddialoguestarttime = gettime();
}