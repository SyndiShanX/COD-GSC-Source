/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1995c213b05b278.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\hint_tutorial;
#namespace namespace_9b5aa273;

function private autoexec __init__system__() {
  system::register(#"hash_2b0f887705d6f3e", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  serverfield::register("can_show_hold_breath_hint", 1, 1, "int", &function_b58b73b6);
  callback::function_c046382d(&function_93f6c83b);
}

function private function_b58b73b6(oldval, newval) {
  if(oldval == newval) {
    return;
  }

  player = getplayers()[0];

  if(newval) {
    if(!isDefined(level.var_5f632232)) {
      if(self function_82f2f066()) {
        hint_tutorial::function_4c2d4fc4(#"hash_5b44c3504ac0a01e", #"", 0, #"", 2);
      } else {
        hint_tutorial::function_4c2d4fc4(#"hash_5b4b0dc5da9b211d", #"", 0, #"", 2);
      }

      player val::set(#"hold_breath", "disable_usability", 1);
    }

    return;
  }

  if(level.var_5f632232 === # "hash_5b4b0dc5da9b211d" || level.var_5f632232 === # "hash_5b44c3504ac0a01e") {
    hint_tutorial::function_9f427d88(0);
  }

  player val::reset_all(#"hold_breath");
}

function event_handler[checkpoint_restore] function_d49b3ac5() {
  if(level.var_5f632232 === # "hash_5b4b0dc5da9b211d" || level.var_5f632232 === # "hash_5b44c3504ac0a01e") {
    hint_tutorial::function_9f427d88(0);
    player = getplayers()[0];
    player val::reset_all(#"hold_breath");
  }
}

function event_handler[event_6aa1189e] function_c6a7519f() {
  player = self;
  player.var_35ee6252 = 1;
  setslowmotion(1, 0.2, 0.5);
}

function event_handler[event_822128d0] function_255956d5() {
  player = self;
  player function_9220f819();
}

function private function_9220f819() {
  player = self;

  if(is_true(player.var_35ee6252)) {
    player.var_35ee6252 = undefined;
    setslowmotion(0.2, 1, 0.1);
  }
}

function private function_93f6c83b(s_params) {
  self function_9220f819();
}