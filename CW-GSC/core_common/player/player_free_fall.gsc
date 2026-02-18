/***************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\player\player_free_fall.gsc
***************************************************/

#using script_1d29de500c266470;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_insertion;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#namespace player_free_fall;

function private autoexec __init__system__() {
  system::register(#"player_free_fall", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.var_7abaaef1 = getdvarint(#"player_freefall", 0);

  if(is_true(level.var_7abaaef1)) {
    function_7c19fac2();
    return;
  }

  callback::add_callback(#"debug_movement", &function_a7e644f6);
  callback::add_callback(#"freefall", &function_a0950b54);
  callback::add_callback(#"parachute", &function_c75bd5cb);
  callback::add_callback(#"skydive_end", &function_f99c2453);

  level thread function_1fc427dc();
}

function function_a0950b54(var_23c2e47f) {
  self val::set(#"player_free_fall", "show_weapon_hud", 0);
  self callback::function_d8abfc3d(#"death", &function_c76a70ab);
  self callback::function_d8abfc3d(#"on_player_laststand", &function_18e58cf4);
}

function function_c75bd5cb(var_23c2e47f) {
  self val::set(#"player_free_fall", "show_weapon_hud", 0);
}

function function_f99c2453(var_23c2e47f) {
  self val::reset(#"player_free_fall", "show_weapon_hud");
  self callback::function_52ac9652(#"death", &function_c76a70ab);
  self callback::function_52ac9652(#"on_player_laststand", &function_18e58cf4);
}

function function_c76a70ab(var_23c2e47f) {
  self val::reset(#"player_free_fall", "show_weapon_hud");
  self callback::function_52ac9652(#"death", &function_c76a70ab);
  self callback::function_52ac9652(#"on_player_laststand", &function_18e58cf4);
}

function function_18e58cf4(var_23c2e47f) {
  self val::reset(#"player_free_fall", "show_weapon_hud");
  self callback::function_52ac9652(#"death", &function_c76a70ab);
  self callback::function_52ac9652(#"on_player_laststand", &function_18e58cf4);
}

function allow_player_basejumping(bool) {
  if(!isDefined(self.enabledbasejumping)) {
    self.enabledbasejumping = 0;
  }

  if(bool) {
    self.enabledbasejumping++;
    self function_8b8a321a(1);
    self function_8a945c0e(1);
    return;
  }

  self.enabledbasejumping--;

  if(self.enabledbasejumping < 0) {
    self.enabledbasejumping = 0;
  }

  if(!self.enabledbasejumping) {
    self function_8b8a321a(0);
    self function_8a945c0e(0);
  }
}

function function_2979b1be(waitsec) {
  self endon(#"death", #"disconnect");

  if(isDefined(waitsec) && waitsec > 0) {
    self function_8a945c0e(0);
    self function_8b8a321a(0);
    wait waitsec;
  }

  if(isDefined(self)) {
    if(self player_insertion::function_b9370594()) {
      return;
    }

    self function_8a945c0e(1);
    self function_8b8a321a(1);
  }
}

function function_7705a7fc(fall_time, velocity) {
  if(is_true(level.var_7abaaef1)) {
    self forcefreefall(1, velocity, 1);
    return;
  }

  self function_8cf53a19();

  if(isDefined(velocity)) {
    self setvelocity(velocity);
  }

  self function_b02c52b();
  wait fall_time;
  self thread function_a1fa2219();
}

function parachutemidairdeathwatcher() {}

function function_a1fa2219() {
  self endon(#"death", #"disconnect");
  self thread function_2979b1be(3);
  self waittill(#"skydive_deployparachute");
  self function_8a945c0e(0);
  self notify(#"freefall_complete");

  if(!is_true(level.dontshootwhileparachuting) && isDefined(level.parachuteopencb)) {
    self[[level.parachuteopencb]]();
  }

  self thread function_156d91ef();
}

function function_156d91ef() {
  self endon(#"death", #"disconnect");

  if(getdvarint(#"scr_parachute_camera_transition_mode", 1) == 1) {
    self function_41170420(0);
  }

  self waittill(#"skydive_end");
  waitframe(1);

  if(isDefined(level.parachuterestoreweaponscb)) {
    self[[level.parachuterestoreweaponscb]]();
  }

  if(is_true(level.dontshootwhileparachuting) && isDefined(level.parachutecompletecb)) {
    self[[level.parachutecompletecb]]();
  }

  self notify(#"parachute_landed");
  self function_41170420(0);
  self notify(#"parachute_complete");

  if(isDefined(level.onfirstlandcallback)) {
    self[[level.onfirstlandcallback]](self);
  }
}

function function_5352af94() {
  player = self;
  player function_8cf53a19();

  if(isDefined(player.parachute)) {
    player.parachute delete();
  }
}

function private function_a7e644f6(eventstruct) {
  if(!eventstruct.debug_movement) {
    if(getdvarint(#"hash_bfa71d08f383550", 0)) {
      speed = 17.6 * getdvarint(#"hash_3d4ce3a554eac78", 100);
      velocity = anglesToForward(self getplayerangles()) * speed;
      self function_7705a7fc(getdvarint(#"hash_bfa71d08f383550", 0) == 1, velocity);
    }
  }
}

function private function_1fc427dc() {
  waitframe(1);
  waitframe(1);
  adddebugcommand("<dev string:x38>");
  adddebugcommand("<dev string:x65>");
}

function private function_7c19fac2() {
  callback::add_callback(#"freefall", &function_6a663396);
  callback::add_callback(#"parachute", &function_bd421742);
  callback::add_callback(#"debug_movement", &function_a7e644f6);

  level thread function_1fc427dc();
}

function function_d2a1520c() {
  wingsuit = self namespace_eb06e24d::get_wingsuit();

  if(self util::is_female()) {
    return wingsuit.var_5677bd3d;
  }

  return wingsuit.var_94166112;
}

function function_27f21242(freefall) {
  model = function_d2a1520c();

  if(freefall) {
    if(!self isattached(model)) {
      self attach(model);
    }

    return;
  }

  if(self isattached(model)) {
    self detach(model);
  }
}

function private function_6a663396(eventstruct) {
  if(eventstruct.freefall) {
    if(!isDefined(eventstruct.var_695a7111) || eventstruct.var_695a7111) {
      parachute = self namespace_eb06e24d::get_parachute();
      parachute_weapon = parachute.("parachute");

      if(isDefined(parachute_weapon)) {
        if(!self hasweapon(parachute_weapon)) {
          self giveweapon(parachute_weapon);
        }

        self switchtoweaponimmediate(parachute_weapon);
        self thread function_b6e83203(0.5);
      }
    }

    return;
  }

  if(!self function_9a0edd92()) {
    parachute = self namespace_eb06e24d::get_parachute();
    parachute_weapon = parachute.("parachute");

    if(isDefined(parachute_weapon)) {
      if(self hasweapon(parachute_weapon)) {
        self takeweapon(parachute_weapon);
      }
    }
  }

  self setclientuivisibilityflag("weapon_hud_visible", 1);
}

function private function_6aac1790(var_dbb94a) {
  if(isDefined(var_dbb94a) && !self isattached(var_dbb94a, "tag_weapon_right")) {}
}

function private function_b6e83203(delay) {
  if(isDefined(delay)) {
    self endon(#"death", #"disconnect");
    wait delay;
  }

  parachute = self namespace_eb06e24d::get_parachute();
  var_dbb94a = parachute.("parachuteLit");
  function_6aac1790(var_dbb94a);
}

function private function_bd421742(eventstruct) {
  if(eventstruct.parachute) {
    self function_b6e83203();
    return;
  }

  parachute = self namespace_eb06e24d::get_parachute();
  parachute_weapon = parachute.("parachute");
  var_dbb94a = parachute.("parachuteLit");

  if(isDefined(parachute_weapon)) {
    self takeweapon(parachute_weapon);
  }

  if(isDefined(var_dbb94a)) {}

  self setclientuivisibilityflag("weapon_hud_visible", 1);
}

function private function_a2b7e8a1() {
  mapname = util::get_map_name();
  waitframe(1);
  waitframe(1);
  adddebugcommand("<dev string:x38>");
  adddebugcommand("<dev string:x65>");
  adddebugcommand("<dev string:x9b>");
  adddebugcommand("<dev string:xc1>");
  adddebugcommand("<dev string:xe6>" + mapname + "<dev string:xf5>");
  adddebugcommand("<dev string:x12d>" + mapname + "<dev string:x13f>");
  adddebugcommand("<dev string:x12d>" + mapname + "<dev string:x176>");
  adddebugcommand("<dev string:x12d>" + mapname + "<dev string:x1b8>");
  waitframe(1);
  adddebugcommand("<dev string:x202>" + mapname + "<dev string:x213>");
}