/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\ui\warning_message.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using scripts\core_common\util_shared;
#namespace warning_message;

function create(message, var_400e244b, pulse, endons) {
  if(namespace_61e6d095::exists(#"hash_71bae6f32cec8a8e")) {
    assertmsg("<dev string:x38>");
    return;
  }

  if(isDefined(endons)) {
    self endoncallback(&remove, endons);
  }

  namespace_61e6d095::create(#"hash_71bae6f32cec8a8e", #"hash_6e2caf9e3aa6b810");
  namespace_61e6d095::set_text(#"hash_71bae6f32cec8a8e", message);
  namespace_61e6d095::set_state(#"hash_71bae6f32cec8a8e", #"defaultstate");

  if(is_true(pulse)) {
    util::delay(float(function_60d95f53()) / 1000, endons, &function_b4af2e7, 1);
  }

  if(isint(var_400e244b) || isfloat(var_400e244b)) {
    wait var_400e244b;
  } else if(isstring(var_400e244b) || ishash(var_400e244b) || isarray(var_400e244b)) {
    self waittill(var_400e244b);
  } else {
    return;
  }

  remove();
}

function set_message(message) {
  if(namespace_61e6d095::exists(#"hash_71bae6f32cec8a8e")) {
    namespace_61e6d095::set_text(#"hash_71bae6f32cec8a8e", message);
  }
}

function function_b4af2e7(pulse) {
  if(namespace_61e6d095::exists(#"hash_71bae6f32cec8a8e")) {
    if(is_true(pulse)) {
      namespace_61e6d095::set_state(#"hash_71bae6f32cec8a8e", #"pulse");
      return;
    }

    namespace_61e6d095::set_state(#"hash_71bae6f32cec8a8e", #"defaultstate");
  }
}

function remove(params) {
  if(namespace_61e6d095::exists(#"hash_71bae6f32cec8a8e")) {
    namespace_61e6d095::remove(#"hash_71bae6f32cec8a8e");
  }
}