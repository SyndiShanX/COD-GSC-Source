/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_fear_in_headlights.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_fear_in_headlights;

function autoexec __init__sytem__() {
  system::register("zm_bgb_fear_in_headlights", & __init__, undefined, "bgb");
}

function __init__() {
  if(!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_fear_in_headlights", "activated", 1, undefined, undefined, & validation, & activation);
}

function private function_b13c2f15() {
  self endon("hash_4e7f43fc");
  self waittill("death");
  if(isdefined(self) && self ispaused()) {
    self setentitypaused(0);
    if(!self isragdoll()) {
      self startragdoll();
    }
  }
}

function private function_b8eb33c5(ai) {
  ai notify("hash_4e7f43fc");
  ai thread function_b13c2f15();
  ai setentitypaused(1);
  ai.var_70a58794 = ai.b_ignore_cleanup;
  ai.b_ignore_cleanup = 1;
  ai.var_7f7a0b19 = ai.is_inert;
  ai.is_inert = 1;
}

function private function_31a2964e(ai) {
  ai notify("hash_4e7f43fc");
  ai setentitypaused(0);
  if(isdefined(ai.var_7f7a0b19)) {
    ai.is_inert = ai.var_7f7a0b19;
  }
  if(isdefined(ai.var_70a58794)) {
    ai.b_ignore_cleanup = ai.var_70a58794;
  } else {
    ai.b_ignore_cleanup = 0;
  }
}

function private function_723d94f5(allai, trace, degree = 45) {
  var_f1649153 = allai;
  players = getplayers();
  var_445b9352 = cos(degree);
  foreach(player in players) {
    var_f1649153 = player cantseeentities(var_f1649153, var_445b9352, trace);
  }
  foreach(ai in var_f1649153) {
    if(isalive(ai)) {
      function_31a2964e(ai);
    }
  }
}

function validation() {
  if(bgb::is_team_active("zm_bgb_fear_in_headlights")) {
    return false;
  }
  return true;
}

function activation() {
  self endon("disconnect");
  self thread function_deeb696f();
  self playsound("zmb_bgb_fearinheadlights_start");
  self playloopsound("zmb_bgb_fearinheadlights_loop");
  self thread kill_fear_in_headlights();
  self bgb::run_timer(120);
  self notify("kill_fear_in_headlights");
}

function function_deeb696f() {
  self endon("disconnect");
  self endon("kill_fear_in_headlights");
  var_bd6badee = 1200 * 1200;
  while (true) {
    allai = getaiarray();
    foreach(ai in allai) {
      if(isdefined(ai.var_48cabef5) && ai[[ai.var_48cabef5]]()) {
        continue;
      }
      if(isalive(ai) && !ai ispaused() && ai.team == level.zombie_team && !ai ishidden() && (!(isdefined(ai.bgbignorefearinheadlights) && ai.bgbignorefearinheadlights))) {
        function_b8eb33c5(ai);
      }
    }
    var_e4760c66 = [];
    var_e37fbbbd = [];
    foreach(ai in allai) {
      if(isdefined(ai.aat_turned) && ai.aat_turned && ai ispaused()) {
        function_31a2964e(ai);
        continue;
      }
      if(distance2dsquared(ai.origin, self.origin) >= var_bd6badee) {
        var_e4760c66[var_e4760c66.size] = ai;
        continue;
      }
      var_e37fbbbd[var_e37fbbbd.size] = ai;
    }
    function_723d94f5(var_e4760c66, 1);
    function_723d94f5(var_e37fbbbd, 0, 75);
    wait(0.05);
  }
}

function kill_fear_in_headlights() {
  str_notify = self util::waittill_any_return("death", "kill_fear_in_headlights");
  if(str_notify == "kill_fear_in_headlights") {
    self stoploopsound();
    self playsound("zmb_bgb_fearinheadlights_end");
  }
  allai = getaiarray();
  foreach(ai in allai) {
    function_31a2964e(ai);
  }
}