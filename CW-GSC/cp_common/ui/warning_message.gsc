/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\ui\warning_message.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using scripts\core_common\util_shared;
#namespace warning_message;

function create(message, var_400e244b, pulse, endons) {
  if(scripted_widgets::exists(#"hash_71bae6f32cec8a8e")) {
    assertmsg("<dev string:x38>");
    return;
  }

  if(isDefined(endons)) {
    self endoncallback(&remove, endons);
  }

  scripted_widgets::create(#"hash_71bae6f32cec8a8e", #"hash_6e2caf9e3aa6b810");
  scripted_widgets::set_text(#"hash_71bae6f32cec8a8e", message);
  scripted_widgets::set_state(#"hash_71bae6f32cec8a8e", #"defaultstate");

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
  if(scripted_widgets::exists(#"hash_71bae6f32cec8a8e")) {
    scripted_widgets::set_text(#"hash_71bae6f32cec8a8e", message);
  }
}

function function_b4af2e7(pulse) {
  if(scripted_widgets::exists(#"hash_71bae6f32cec8a8e")) {
    if(is_true(pulse)) {
      scripted_widgets::set_state(#"hash_71bae6f32cec8a8e", #"pulse");
      return;
    }

    scripted_widgets::set_state(#"hash_71bae6f32cec8a8e", #"defaultstate");
  }
}

function remove(params) {
  if(scripted_widgets::exists(#"hash_71bae6f32cec8a8e")) {
    scripted_widgets::remove(#"hash_71bae6f32cec8a8e");
  }
}