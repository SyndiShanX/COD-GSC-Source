/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_32d93a194074fa6a.gsc
*************************************************/

#using script_4a6760982b403bad;
#using script_6981400abfcd765c;
#using scripts\engine\utility;
#namespace ftue_tip;

function function_a6ca80cf4f22e262(var_8dceeda8be90dd95) {
  if(function_94b952789d039abb()) {
    var_1c32a202e5e6e499 = getscriptbundle(var_8dceeda8be90dd95);

    if(isDefined(var_1c32a202e5e6e499)) {
      function_495a84d8124ff118(var_1c32a202e5e6e499);
    }
  }
}

function function_5135b05917b91c1b() {
  self.var_45e9d104c0a834c7 = spawnStruct();
  function_60994558e6d2f494(0);
}

function private function_495a84d8124ff118(list_bundle) {
  level.var_cf6b53e10210d950 = [];
  level.var_e88f11422f545fe2 = [];
  index = 1;

  foreach(bundle in list_bundle.var_a43c3448b149524) {
    var_2fb2aed4c21ba3b0 = bundle.ref;

    if(isDefined(var_2fb2aed4c21ba3b0)) {
      tip = spawnStruct();
      tip.id = index;
      tip.bundle = bundle.bundle;
      level.var_cf6b53e10210d950[var_2fb2aed4c21ba3b0] = tip;
      level.var_e88f11422f545fe2[index] = var_2fb2aed4c21ba3b0;
    }

    index++;
  }
}

function function_e4d0f9efe9c2bca1() {
  assert(isPlayer(self));
  return istrue(self.var_fa35b4a136b27acd);
}

function function_9e0151baa208fe9e(ref, params) {
  if(!isDefined(params)) {
    params = spawnStruct();
  }

  if(!isDefined(level.var_cf6b53e10210d950)) {
    return;
  }

  assert(isPlayer(self));

  if(isDefined(params.sound) && params.sound) {
    self playlocalsound("uin_tip_appearance");
  }

  if(isDefined(params.waittimeoverride)) {
    self.waittimeoverride = params.waittimeoverride;
  }

  function_34d38a99558eb2a2(ref, params.callback, params.duration);
}

function private function_34d38a99558eb2a2(ref, callback, duration) {
  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }

  var_4202e8261e8725f2 = function_388a7f4b869568cc(ref);

  if(!isDefined(var_4202e8261e8725f2)) {
    assertmsg("<dev string:x1c>" + ref + "<dev string:x4c>");
    return;
  }

  function_60994558e6d2f494(var_4202e8261e8725f2);
  self function_45af0f78c1d76035(var_4202e8261e8725f2);
  thread function_3a1f121991c200e3(ref, 0);
  self notify("newtip");

  if(isDefined(duration)) {
    wait duration;
    function_7fd621b8ba80e652();
  }
}

function function_f339c5c73d11ea20(ref, issucceed, params) {
  if(!isDefined(ref)) {
    assertmsg("<dev string:x7f>" + ref + "<dev string:xaa>" + level.var_cf6b53e10210d950);
    return;
  }

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(params)) {
    params = spawnStruct();
  }

  if(!function_4352a63d3925798b()) {
    function_9e0151baa208fe9e(ref);
    function_d9f9951c566c97e1(1, params.duration);
  }

  if(isDefined(params.sound) && params.sound) {
    sound = "uin_tip_complete";

    if(!issucceed) {
      sound = "uin_tip_failed";
    }

    self playlocalsound(sound);
  }

  function_508d3de0ee3046dd(ref, issucceed);
  result = "SUCCESS";

  if(!issucceed) {
    result = "FAILED";
  }

  thread function_3a1f121991c200e3(ref, 1, result);
  function_d9f9951c566c97e1(0.8, params.duration);
  function_7fd621b8ba80e652(params.duration);
}

function function_6fba31415caeee6e(issucceeded, params) {
  tipid = function_91e510bcc622bfd0();

  if(tipid == 0) {
    return;
  }

  tipref = function_bf44b38db65d0bf9(tipid);
  assert(isDefined(tipref));
  function_f339c5c73d11ea20(tipref, issucceeded, params);
}

function function_508d3de0ee3046dd(ref, issucceed) {
  if(!isDefined(level.var_cf6b53e10210d950)) {
    return;
  }

  assert(isPlayer(self));
  function_ff85bc42d440477b(ref, function_63e0c93eb50543f(issucceed));
}

function private function_ff85bc42d440477b(ref, newstate) {
  if(!isPlayer(self)) {
    return;
  }

  self function_1807967ea2130c2d(newstate);
}

function private function_63e0c93eb50543f(issucceed) {
  newstate = 0;

  if(isDefined(issucceed)) {
    if(issucceed) {
      newstate = 1;
    } else {
      newstate = 2;
    }
  }

  return newstate;
}

function function_7fd621b8ba80e652(overridewaittime) {
  function_60994558e6d2f494(0);
  self function_4eb77980affdbefb();
  function_d9f9951c566c97e1(0.5, overridewaittime);
}

function private function_d9f9951c566c97e1(defaultwaittime, overridewaittime) {
  waittime = defaultwaittime;

  if(isDefined(overridewaittime)) {
    waittime = overridewaittime;
  }

  if(waittime > 0) {
    wait waittime;
  }
}

function function_36939d27ae6df257(callback) {
  if(isDefined(callback)) {
    thread function_ff3f2188762b9896(callback);
  }
}

function private function_ff3f2188762b9896(callback) {
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(self.var_45e9d104c0a834c7)) {
    return;
  }

  if(!isDefined(callback)) {
    return;
  }

  while(true) {
    self waittill("luinotifyserver", event, value);

    if(isDefined(event) && event == "ftuetip_completed") {
      if(isDefined(value) && value == function_91e510bcc622bfd0()) {
        tipref = function_bf44b38db65d0bf9(value);

        if(isDefined(tipref)) {
          self[[callback]](tipref);
          return;
        }
      }
    }
  }
}

function private function_bf44b38db65d0bf9(index) {
  return level.var_e88f11422f545fe2[index];
}

function private function_388a7f4b869568cc(tip_ref) {
  id = level.var_cf6b53e10210d950[tip_ref].id;
  return id;
}

function function_7052cffee37e6327(tip_ref) {
  id = level.var_cf6b53e10210d950[tip_ref].bundle;
  return id;
}

function private function_4352a63d3925798b() {
  return self.var_45e9d104c0a834c7.var_1624b445a428c297 != 0;
}

function private function_91e510bcc622bfd0() {
  return self.var_45e9d104c0a834c7.var_1624b445a428c297;
}

function private function_60994558e6d2f494(newid) {
  self.var_45e9d104c0a834c7.var_1624b445a428c297 = newid;
}

function private function_3a1f121991c200e3(ref, finished, result) {
  tipid = function_7052cffee37e6327(ref);
  var_1656b06379e3e9d8 = [#"stepname", #"stepnumber", #"issingle", #"hash_a8be9518a2a9868", #"hash_80f6033e24a2bf4"];
  var_5814d27874b48e54 = function_50f8a8f765bad85e(hashcat(%"hash_6b016976aff9ae9f", tipid), var_1656b06379e3e9d8);
  assertex(isDefined(var_5814d27874b48e54), "<dev string:xc9>" + tipid);

  if(!function_acbac8f30b95d690(var_5814d27874b48e54)) {
    return;
  }

  var_5814d27874b48e54.player = self;
  callback = "mobile_ftue_step_start";

  if(istrue(var_5814d27874b48e54.issingle)) {
    var_5814d27874b48e54.result = "SUCCESS";
    callback = "mobile_ftue_step_single";
  } else if(finished) {
    var_5814d27874b48e54.result = result;
    callback = "mobile_ftue_step_finished";
  }

  namespace_de6e6777b0937bd7::function_80820d6d364c1836(callback, var_5814d27874b48e54);
}

function private function_acbac8f30b95d690(var_5814d27874b48e54) {
  return isDefined(var_5814d27874b48e54.stepname) && var_5814d27874b48e54.stepname != "";
}