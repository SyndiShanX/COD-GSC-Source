/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\tac_ops\radio_utility.gsc
***********************************************/

initialize_radio() {
  level.tacopsradio = [];
  level thread radiowatchplayerjoin();
}

radiowatchplayerjoin() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    level.tacopsradio[var_0 scripts\mp\utility\player::getuniqueid()] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  }
}

queue_dialogue(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2))
    level.tacopsradio[var_1 scripts\mp\utility\player::getuniqueid()] function_stack_clear();

  var_4 = 0;

  if(!isDefined(var_3))
    var_4 = level.tacopsradio[var_1 scripts\mp\utility\player::getuniqueid()] thread function_stack(::play_mp_sound, var_0, var_1);
  else
    var_4 = level.tacopsradio[var_1 scripts\mp\utility\player::getuniqueid()] thread function_stack_timeout(var_3, ::play_mp_sound, var_0, var_1);

  return var_4;
}

queue_dialogue_for_team(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2)) {
    foreach(var_5 in scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B"))
    level.tacopsradio[var_5 scripts\mp\utility\player::getuniqueid()] function_stack_clear();
  }

  var_7 = 0;

  foreach(var_5 in scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B")) {
    if(!isDefined(var_3)) {
      var_7 = level.tacopsradio[var_5 scripts\mp\utility\player::getuniqueid()] thread function_stack(::play_mp_sound, var_0, var_5);
      continue;
    }

    var_7 = level.tacopsradio[var_5 scripts\mp\utility\player::getuniqueid()] thread function_stack_timeout(var_3, ::play_mp_sound, var_0, var_5);
  }

  return var_7;
}

play_mp_sound(var_0, var_1, var_2) {
  var_1 playlocalsound(var_0, var_2);
  var_3 = lookupsoundlength(var_0);
  wait(0.5 + var_3 / 1000.0);

  if(isDefined(var_2))
    self notify(var_2);
}

function_stack(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6 thread function_stack_proc(self, var_0, var_1, var_2, var_3, var_4, var_5);
  return function_stack_wait_finish(var_6);
}

function_stack_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7 thread function_stack_proc(self, var_1, var_2, var_3, var_4, var_5, var_6);

  if(isDefined(var_7.function_stack_func_begun) || var_7 scripts\engine\utility::_id_143B9(var_0, "_encstr_91E71A33AEDC8D472DED73D7E68EB0D8D6F533AB9B6CEB262BD9EA73") != "_encstr_995408F398012F656821")
    return function_stack_wait_finish(var_7);
  else {
    var_7 notify("_encstr_AD75063D571AE108");
    return 0;
  }
}

function_stack_clear() {
  if(!isDefined(self.function_stack)) {
    return;
  }
  var_0 = [];

  if(isDefined(self.function_stack[0]) && isDefined(self.function_stack[0].function_stack_func_begun))
    var_0[0] = self.function_stack[0];

  self.function_stack = undefined;
  self notify("_encstr_A3BD15413555380EC9DBA38DD723DB7BE641CB3B9EBBB0");
  waittillframeend;

  if(!var_0.size) {
    return;
  }
  if(!var_0[0].function_stack_func_begun) {
    return;
  }
  self.function_stack = var_0;
}

function_stack_wait(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 scripts\engine\utility::waittill_either("_encstr_B2FC0EDE53C86613732032296958435F", "_encstr_AD75063D571AE108");
}

function_stack_wait_finish(var_0) {
  function_stack_wait(var_0);

  if(!isDefined(self))
    return 0;

  if(!issentient(self))
    return 1;

  if(isalive(self))
    return 1;

  return 0;
}

function_stack_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_0.function_stack))
    var_0.function_stack = [];

  var_0.function_stack[var_0.function_stack.size] = self;
  thread function_stack_self_death(var_0);
  function_stack_caller_waits_for_turn(var_0);

  if(isDefined(var_0) && isDefined(var_0.function_stack)) {
    self.function_stack_func_begun = 1;
    self notify("_encstr_91E71A33AEDC8D472DED73D7E68EB0D8D6F533AB9B6CEB262BD9EA73");

    if(isDefined(var_6))
      var_0[[var_1]](var_2, var_3, var_4, var_5, var_6);
    else if(isDefined(var_5))
      var_0[[var_1]](var_2, var_3, var_4, var_5);
    else if(isDefined(var_4))
      var_0[[var_1]](var_2, var_3, var_4);
    else if(isDefined(var_3))
      var_0[[var_1]](var_2, var_3);
    else if(isDefined(var_2))
      var_0[[var_1]](var_2);
    else
      var_0[[var_1]]();

    if(isDefined(var_0) && isDefined(var_0.function_stack)) {
      var_0.function_stack = scripts\engine\utility::array_remove(var_0.function_stack, self);
      var_0 notify("_encstr_B4CF1BD895B3CA8DF5CCD5371B1D2DEDDCD7E6D1858DB67D4EAC5823F2");
    }
  }

  if(isDefined(self)) {
    self.function_stack_func_begun = 0;
    self notify("_encstr_B2FC0EDE53C86613732032296958435F");
  }
}

function_stack_self_death(var_0) {
  self endon("_encstr_B2FC0EDE53C86613732032296958435F");
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(var_0)) {
    var_0.function_stack = scripts\engine\utility::array_remove(var_0.function_stack, self);
    var_0 notify("_encstr_B4CF1BD895B3CA8DF5CCD5371B1D2DEDDCD7E6D1858DB67D4EAC5823F2");
  }
}

function_stack_caller_waits_for_turn(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_A3BD15413555380EC9DBA38DD723DB7BE641CB3B9EBBB0");

  while(var_0.function_stack[0] != self)
    var_0 waittill("_encstr_B4CF1BD895B3CA8DF5CCD5371B1D2DEDDCD7E6D1858DB67D4EAC5823F2");
}

bcs_scripted_dialogue_start() {
  anim.scripteddialoguestarttime = gettime();
}