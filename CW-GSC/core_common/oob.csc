/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\oob.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace oob;

function private autoexec __init__system__() {
  system::register(#"out_of_bounds", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(sessionmodeismultiplayergame()) {
    level.var_dcb68d74 = 1;
    level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 3000);
    level.oob_timekeep_ms = getdvarint(#"oob_timekeep_ms", 3000);
  } else if(sessionmodeiswarzonegame()) {
    level.var_dcb68d74 = 1;
    level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 10000);
    level.oob_timekeep_ms = getdvarint(#"oob_timekeep_ms", 3000);
  } else if(sessionmodeiscampaigngame()) {
    level.var_dcb68d74 = 0;
    level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 6000);
  } else {
    level.var_dcb68d74 = 1;
    level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 6000);
  }

  clientfield::register("toplayer", "out_of_bounds", 1, 5, "int", &onoutofboundschange, 0, 1);
  clientfield::register("toplayer", "nonplayer_oob_usage", 1, 1, "int", &function_95c61f07, 0, 1);
  callback::on_localclient_connect(&on_localplayer_connect);
  callback::on_localplayer_spawned(&on_localplayer_spawned);
  callback::on_localclient_shutdown(&on_localplayer_shutdown);
  callback::function_a880899e(&function_a880899e);
  level.var_5b8ec4d = [];
}

function on_localplayer_connect(localclientnum) {
  setuimodelvalue(createuimodel(function_1df4c3b0(localclientnum, #"hud_items"), "outOfBoundsEndTime"), 0);

  if(getdvarstring(#"hash_4e9b02559bacb944", "<dev string:x38>") == "<dev string:x3c>") {
    oobtriggers = function_29bda34d(localclientnum, "<dev string:x43>");

    foreach(oobtrigger in oobtriggers) {
      oobtrigger function_704c070e(localclientnum);
    }
  }

}

function on_localplayer_spawned(localclientnum) {}

function on_localplayer_shutdown(localclientnum) {
  localplayer = self;

  if(isDefined(localplayer)) {
    stopoutofboundseffects(localclientnum, localplayer);
  }
}

function function_a880899e(eventparams) {
  localplayer = function_5c10bd79(eventparams.localclientnum);

  if(!isDefined(localplayer.oob_effect_enabled)) {
    return;
  }

  if(eventparams.enabled) {
    function_d36db451(eventparams.localclientnum);
    return;
  }

  function_52b5ffe3(eventparams.localclientnum);
}

function function_95c61f07(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump > 0) {
    self.nonplayeroobusage = 1;
    return;
  }

  self.nonplayeroobusage = undefined;
}

function function_2fb8e4d4(localclientnum, localplayer) {
  if(function_3132f113(localplayer)) {
    return false;
  }

  return true;
}

function onoutofboundschange(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  localplayer = function_5c10bd79(binitialsnap);
  var_d66b86ee = function_2fb8e4d4(binitialsnap, localplayer);
  self callback::entity_callback(#"oob", binitialsnap, {
    #old_val: fieldname, #new_val: bwastimejump
  });

  if(var_d66b86ee && bwastimejump > 0) {
    if(!isDefined(localplayer.oob_effect_enabled)) {
      function_da2afac6(binitialsnap, localplayer);
    }

    return;
  }

  if(isDefined(level.oob_timekeep_ms) && isDefined(self.oob_start_time)) {
    self.oob_end_time = getservertime(0, 1);

    if(!isDefined(self.oob_active_duration)) {
      self.oob_active_duration = 0;
    }

    self.oob_active_duration += self.oob_end_time - self.oob_start_time;
  }

  if(is_true(self.nonplayeroobusage)) {
    self.oob_active_duration = undefined;
  }

  stopoutofboundseffects(binitialsnap, localplayer);
}

function function_52b5ffe3(localclientnum) {
  if(function_21dc7cf(localclientnum)) {
    return;
  }

  if(isDefined(level.var_5b8ec4d[localclientnum])) {
    return;
  }

  if(util::get_game_type() === # "zstandard") {
    level.var_5b8ec4d[localclientnum] = function_604c9983(localclientnum, #"hash_6da7ae12f538ef5e", 0.5);
    return;
  }

  level.var_5b8ec4d[localclientnum] = function_604c9983(localclientnum, #"uin_out_of_bounds_loop", 0.5);
}

function function_da2afac6(localclientnum, localplayer) {
  localplayer.oob_effect_enabled = 1;
  function_52b5ffe3(localclientnum);
  oobmodel = getoobuimodel(localclientnum);

  if(level.var_dcb68d74) {
    var_e09617 = localplayer function_54e69ee4();

    if(isDefined(self.oob_active_duration) && isDefined(self.var_4e1de06a) && self.var_4e1de06a > var_e09617) {
      var_5e38cdc6 = self.var_4e1de06a - var_e09617;
      var_b8883639 = self.oob_active_duration - var_5e38cdc6;
      self.oob_active_duration = int(max(var_b8883639, 0));
    }

    self.var_4e1de06a = var_e09617;

    if(isDefined(level.oob_timekeep_ms) && isDefined(self.oob_start_time) && isDefined(self.oob_active_duration) && getservertime(0) - self.oob_end_time < level.oob_timekeep_ms) {
      setuimodelvalue(oobmodel, getservertime(0, 1) + var_e09617 - self.oob_active_duration);
    } else {
      self.oob_active_duration = undefined;
      setuimodelvalue(oobmodel, getservertime(0, 1) + var_e09617);
    }
  }

  self.oob_start_time = getservertime(0, 1);
}

function function_d36db451(localclientnum) {
  if(isDefined(level.var_5b8ec4d) && isDefined(level.var_5b8ec4d[localclientnum])) {
    function_d48752e(localclientnum, level.var_5b8ec4d[localclientnum]);
    level.var_5b8ec4d[localclientnum] = undefined;
  }
}

function stopoutofboundseffects(localclientnum, localplayer) {
  if(!isDefined(localplayer)) {
    return;
  }

  function_d36db451(localclientnum);

  if(level.var_dcb68d74) {
    oobmodel = getoobuimodel(localclientnum);
    setuimodelvalue(oobmodel, 0);
  }

  if(isDefined(localplayer) && isDefined(localplayer.oob_effect_enabled)) {
    localplayer.oob_effect_enabled = 0;
    localplayer.oob_effect_enabled = undefined;
  }
}

function getoobuimodel(localclientnum) {
  return getuimodel(function_1df4c3b0(localclientnum, #"hud_items"), "outOfBoundsEndTime");
}

function function_93bd17f6(id, time) {
  if(!isDefined(self.var_2ae9ee7e)) {
    self.var_2ae9ee7e = [];
  } else if(!isarray(self.var_2ae9ee7e)) {
    self.var_2ae9ee7e = array(self.var_2ae9ee7e);
  }

  self.var_2ae9ee7e[id] = time;
}

function function_e2d18c01(id) {
  if(isarray(self.var_2ae9ee7e)) {
    arrayremoveindex(self.var_2ae9ee7e, id, 1);
  }
}

function function_54e69ee4() {
  if(!isarray(self.var_2ae9ee7e) || !self.var_2ae9ee7e.size) {
    return level.oob_timelimit_ms;
  }

  var_56afe472 = undefined;

  foreach(time in self.var_2ae9ee7e) {
    if(!isDefined(var_56afe472) || time < var_56afe472) {
      var_56afe472 = time;
    }
  }

  return int(var_56afe472 * 1000);
}