/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2b4b90647dc1d53d.gsc
*************************************************/

#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\trigger;
#namespace namespace_91faf49cc72f0b47;

function function_b8554b5efa2488b0() {
  var_45e51f698992d648 = self;
  var_b55fd7d854233d03 = getEnt(var_45e51f698992d648.target, "targetname");
  a_e_lights = getEntArray("security_light", "targetname");
  var_6a4f1cc271876221 = getEntArray("rollup_window_1", "targetname");
  function_b56c65359567813a(a_e_lights, 0);
  function_15e73138168942f(var_6a4f1cc271876221);

  if(isDefined(var_45e51f698992d648) && isDefined(var_b55fd7d854233d03)) {
    function_a67b8af5f3b9e6c8(var_45e51f698992d648, var_b55fd7d854233d03, var_6a4f1cc271876221, a_e_lights);
  }
}

function function_95e1d0440e05beae(var_5118606b880c9c9d) {
  switch (var_5118606b880c9c9d) {
    case #"hash_24337a349f9057f5":
      self function_dfb78b3e724ad620(1);
      self setHintString(&"MP/SECURITY_ACTIVATE");
      self setCursorHint("HINT_BUTTON");
      self sethintinoperable(0);
      break;
    case #"hash_e867cf0bf08fa2b0":
      self function_dfb78b3e724ad620(1);
      self setHintString(&"MP/SECURITY_REBOOTING");
      self setCursorHint("HINT_NOICON");
      self sethintinoperable(1);
      break;
    case #"hash_d9a7b65f9477385c":
      self function_dfb78b3e724ad620(1);
      self setHintString(&"MP/SECURITY_DEACTIVATE");
      self setCursorHint("HINT_BUTTON");
      self sethintinoperable(0);
      break;
    case #"hash_35bb36c485686365":
      self function_dfb78b3e724ad620(1);
      self setHintString(&"MP/SECURITY_DISABLED");
      self setCursorHint("HINT_NOICON");
      self sethintinoperable(1);
      break;
    default:
      break;
  }
}

function function_a67b8af5f3b9e6c8(var_45e51f698992d648, var_b55fd7d854233d03, var_6a4f1cc271876221, a_e_lights) {
  while(true) {
    var_45e51f698992d648 function_95e1d0440e05beae("deactivated");
    var_b55fd7d854233d03 function_95e1d0440e05beae("deactivated");
    var_45e51f698992d648 thread monitor_activate();
    var_b55fd7d854233d03 thread monitor_activate();
    level waittill("security_activated");
    var_45e51f698992d648 function_95e1d0440e05beae("rebooting");
    var_b55fd7d854233d03 function_95e1d0440e05beae("rebooting");
    e_alarm = spawn("script_model", var_45e51f698992d648.origin);
    e_alarm playLoopSound("evt_pent_shutter_alarm_loop");
    function_b56c65359567813a(a_e_lights, 1);
    function_1c486f0bbda89a7c(var_6a4f1cc271876221);
    wait max(2, -1);
    e_alarm stopsounds();
    wait 0.1;
    e_alarm delete();
    var_45e51f698992d648 function_95e1d0440e05beae("activated");
    var_45e51f698992d648 thread monitor_deactivate();
    var_b55fd7d854233d03 function_95e1d0440e05beae("activated");
    var_b55fd7d854233d03 add_waypoint();
    var_b55fd7d854233d03 thread monitor_deactivate();
    var_b55fd7d854233d03 thread auto_off();
    level waittill("security_deactivated");
    var_45e51f698992d648 function_95e1d0440e05beae("rebooting");
    var_b55fd7d854233d03 remove_waypoint();
    var_b55fd7d854233d03 function_95e1d0440e05beae("rebooting");
    function_b56c65359567813a(a_e_lights, 0);
    function_15e73138168942f(var_6a4f1cc271876221);
    wait max(2, 4);
  }
}

function function_b56c65359567813a(a_e_lights, b_turn_on) {
  foreach(e_light in a_e_lights) {
    if(b_turn_on) {
      e_light setlightintensity(0.6);
      continue;
    }

    e_light setlightintensity(0);
  }
}

function monitor_activate() {
  level endon("security_activated");
  self waittill("trigger", e_player);

  if(isPlayer(e_player)) {
    level notify("security_activated");
  }
}

function monitor_deactivate() {
  level endon("security_deactivated");
  self waittill("trigger", e_player);

  if(isPlayer(e_player)) {
    level notify("security_deactivated");
  }
}

function auto_off() {
  level endon("security_deactivated");
  wait 30;
  level notify("security_deactivated");
}

function function_15e73138168942f(var_6a4f1cc271876221) {
  foreach(e_window in var_6a4f1cc271876221) {
    e_window thread function_ec8a822eb48b5e54();
  }

  wait 6;
}

function function_ec8a822eb48b5e54() {
  self movez(175, 6);
  wait 6;
  self hide();
}

function function_1c486f0bbda89a7c(var_6a4f1cc271876221) {
  foreach(e_window in var_6a4f1cc271876221) {
    e_window show();
    e_window movez(-175, 6);
  }

  wait 6;
}

function add_waypoint() {
  var_657e98da077c31ce = 200;
  var_1406c49029c3803b = 300;
  var_e260cabe9157b975 = (0, 0, -64);
  var_31038865a09f1f70 = self.origin + var_e260cabe9157b975;
  self.var_e61c947dd774e8f = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  objective_setlabel(self.var_e61c947dd774e8f, &"MP_INGAME_ONLY/SECURITY_DEACTIVATE");
  objective_position(self.var_e61c947dd774e8f, var_31038865a09f1f70);
  objective_setzoffset(self.var_e61c947dd774e8f, 90);
  objective_setbackground(self.var_e61c947dd774e8f, 1);
  objective_icon(self.var_e61c947dd774e8f, "icon_waypoint_locked");
  objective_setplayoutro(self.var_e61c947dd774e8f, 0);
  objective_setplayintro(self.var_e61c947dd774e8f, 0);
  objective_state(self.var_e61c947dd774e8f, "current");
  function_c047d7ffe7a83501(self.var_e61c947dd774e8f, var_657e98da077c31ce, var_1406c49029c3803b, 1);
}

function remove_waypoint() {
  objective_state(self.var_e61c947dd774e8f, "done");
  scripts\mp\objidpoolmanager::returnobjectiveid(self.var_e61c947dd774e8f);
}

function function_b52b870c97ccf5c4() {
  var_206de6eee20933a = getEntArray("sliding_bookshelf_trig", "script_noteworthy");
  var_75b351416918d890 = getEnt("sliding_bookshelf", "script_noteworthy");

  if(isDefined(var_206de6eee20933a) && isDefined(var_75b351416918d890)) {
    var_75b351416918d890 thread function_42da2f31f927060c(var_206de6eee20933a);
  }
}

function function_42da2f31f927060c(var_206de6eee20933a) {
  if(isDefined(self.target)) {
    var_f09a304ba855fb33 = getEnt(self.target, "targetname");
    var_f09a304ba855fb33 linkTo(self);
  }

  while(true) {
    foreach(var_6f78735e2fb5eb7e in var_206de6eee20933a) {
      var_6f78735e2fb5eb7e function_dfb78b3e724ad620(1);
      var_6f78735e2fb5eb7e setHintString(&"MP/DOOR_USE_OPEN");
      var_6f78735e2fb5eb7e setCursorHint("HINT_BUTTON");
      var_6f78735e2fb5eb7e thread function_3e107c8da951fc4c(self);
    }

    self waittill("bookshelf_used");

    foreach(var_6f78735e2fb5eb7e in var_206de6eee20933a) {
      var_6f78735e2fb5eb7e function_dfb78b3e724ad620(0);
    }

    self movex(100, 1);
    wait 11;
    self movex(-100, 1);
    wait 1;
  }
}

function function_3e107c8da951fc4c(var_75b351416918d890) {
  var_75b351416918d890 endon("bookshelf_used");
  self waittill("trigger", e_player);
  var_75b351416918d890 notify("bookshelf_used");
}

function function_a26f592a97bf14d0() {
  var_39725c38968e8ea2 = function_f159c10d5cf8f0b4("no_prone_trigger", "script_noteworthy");

  foreach(var_14746754a0f92b39 in var_39725c38968e8ea2) {
    scripts\mp\utility\trigger::makeenterexittrigger(var_14746754a0f92b39, &function_cb60cd4afb884862, &function_df2a2bf55e01b1f4);
  }
}

function private function_cb60cd4afb884862(e_player, trigger) {
  e_player allowprone(0);
}

function private function_df2a2bf55e01b1f4(e_player, trigger) {
  e_player allowprone(1);
}