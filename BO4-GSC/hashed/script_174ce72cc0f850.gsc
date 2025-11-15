/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_174ce72cc0f850.gsc
***********************************************/

#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\zm\zm_hms_util;
#include scripts\zm_common\zm_sq_modules;

#namespace namespace_bd74bbd2;

register(id, version, script_noteworthy, var_92f252fd, var_af245552) {
  zm_sq_modules::function_d8383812(id, version, script_noteworthy, &is_soul_capture, &soul_captured, 1);
  s_sc = struct::get(script_noteworthy, "script_noteworthy");
  s_sc.var_f929d531 = getent(s_sc.var_5ca82ce, "targetname");
  s_sc.var_f929d531.id = id;
  s_sc.var_92f252fd = var_92f252fd;
  s_sc.var_af245552 = var_af245552;
  level.var_345df07[id] = s_sc;
}

start(id) {
  if(level.var_d2540500[id].active !== 1) {
    s_sc = level.var_345df07[id];
    s_sc.var_7944be4a = 0;
    exploder::exploder(s_sc.fx_exp);
    zm_sq_modules::function_3f808d3d(id);
    s_sc.var_f929d531 thread function_fab8c488();
  }
}

end(id) {
  if(level.var_d2540500[id].active === 1) {
    s_sc = level.var_345df07[id];
    exploder::stop_exploder(s_sc.fx_exp);
    zm_sq_modules::function_2a94055d(id);
    s_sc.var_f929d531 notify(#"event_end");
  }
}

private is_soul_capture(var_88206a50, ent) {
  if(isDefined(ent)) {
    b_killed_by_player = 0;

    if(isDefined(ent.attacker) && isplayer(ent.attacker)) {
      e_player = ent.attacker;
      b_killed_by_player = 1;
    } else if(isDefined(ent.damageinflictor) && isplayer(ent.damageinflictor)) {
      e_player = ent.damageinflictor;
      b_killed_by_player = 1;
    }

    if(b_killed_by_player && e_player istouching(var_88206a50.var_f929d531)) {
      return true;
    }
  }

  return false;
}

private soul_captured(var_f0e6c7a2, ent) {
  n_souls_required = 12;

  if(getplayers().size > 2) {
    n_souls_required = 24;
  } else if(getplayers().size > 1) {
    n_souls_required = 18;
  }

  var_f0e6c7a2.var_7944be4a++;

  if(level flag::get(#"soul_fill")) {
    var_f0e6c7a2.var_7944be4a = n_souls_required;
  }

    if(var_f0e6c7a2.var_7944be4a >= n_souls_required) {
      var_f0e6c7a2 thread[[var_f0e6c7a2.var_92f252fd]]();
    }
}

private function_fab8c488() {
  self endon(#"death", #"event_end");

  while(self zm_hms_util::function_b8a27acc()) {
    wait 0.1;
  }

  self thread player_enter_watcher();
  self thread function_b1e6482f();
}

private player_enter_watcher() {
  self endon(#"death", #"event_end");

  while(!self zm_hms_util::function_b8a27acc()) {
    wait 0.1;
  }

  self notify(#"player_enter");
  self thread function_fab8c488();
}

private function_b1e6482f() {
  self endon(#"death", #"player_enter", #"event_end");
  wait 5;
  level thread[[level.var_345df07[self.id].var_af245552]]();
  end(self.id);
}