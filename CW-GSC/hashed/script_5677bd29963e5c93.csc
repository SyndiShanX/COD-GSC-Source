/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5677bd29963e5c93.csc
***********************************************/

#using scripts\core_common\animation_shared;
#using scripts\core_common\system_shared;
#namespace namespace_80c07c34;

function private autoexec __init__system__() {
  system::register(#"hash_75bfc88140adb680", &_preload, &function_fa076c68, undefined, undefined);
}

function private _preload() {
  function_ad272ef4();
  function_90ceecf8();
  function_7c9b0132();
  function_bc948200();
}

function private function_fa076c68() {}

function private function_ad272ef4() {
  if(!isDefined(level._fx)) {
    level._fx = {};
  }
}

function private function_90ceecf8() {
  animation::add_notetrack_func("vfx_cp_util::fire_weapon", &fire_weapon);
  animation::add_notetrack_func("vfx_cp_util::start_firing_weapon", &function_7b038ec3);
  animation::add_notetrack_func("vfx_cp_util::stop_firing_weapon", &function_e6084ba1);
}

function private function_7c9b0132() {}

function private function_bc948200() {}

function private function_5da462f3(startpos, angles) {
  forward = anglesToForward(angles);
  right = anglestoright(angles);
  up = anglestoup(angles);
  endpos = startpos + vectorscale(forward, 1000);
  line(startpos, endpos, (1, 0, 0), 1, 1, 10);
  endpos = startpos + vectorscale(right, 250);
  line(startpos, endpos, (0, 1, 0), 1, 1, 10);
  endpos = startpos + vectorscale(up, 250);
  line(startpos, endpos, (0, 0, 1), 1, 1, 10);
}

function fire_weapon(parms) {
  self endon(#"death");

  if(!isDefined(self.localclientnum) || !isDefined(self.weapon)) {
    println("<dev string:x38>");
    return;
  }

  startpos = self gettagorigin("tag_flash");
  angles = self gettagangles("tag_flash");

  if(isDefined(startpos) && isDefined(self.weapon.name) && isDefined(angles) && self.weapon.name != # "none") {
    self magicbullet(self.weapon, startpos, angles);
  }
}

function function_7b038ec3(parms) {
  self notify("cc0866372ca2bf9");
  self endon("cc0866372ca2bf9");
  self endon(#"death", #"hash_53fdcb0020b4588c");

  if(!isDefined(self.localclientnum) || !isDefined(self.weapon)) {
    println("<dev string:xa8>");
    return;
  }

  delay = isDefined(self.weapon.firetime) ? self.weapon.firetime : 0.09;

  while(true) {
    self fire_weapon(parms);
    wait delay;
  }
}

function function_e6084ba1(parms) {
  self notify(#"hash_53fdcb0020b4588c");
}