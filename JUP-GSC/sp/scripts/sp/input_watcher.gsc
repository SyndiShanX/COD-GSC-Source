/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\input_watcher.gsc
***********************************************/



#namespace input_watcher;

function function_f65d06cca9dfed8e() {
  wait 1;

  if(getdvarint(@ "hash_4ea76fb42f494e7c", 0) == 0) {
    return;
  }

  level.player notifyonplayercommand("reload_released", "-usereload");
  level.player notifyonplayercommand("weapon_switch_released", "-weapnext");
  level.player notifyonplayercommand("stance_released", "-stance");
  level.player notifyonplayercommand("jump_released", "-gostand");
  x = -20;
  y = 300;
  elem = function_7eac7ed595472c9c(x, 300, "+weapnext");
  elem = function_7eac7ed595472c9c(x, 310, "+usereload");
  elem = function_7eac7ed595472c9c(x, 320, "+stance");
  elem = function_7eac7ed595472c9c(x, 330, "+gostand");
  elem = function_6606195a237494eb(x, 340, "FWD");
  elem = function_6606195a237494eb(x, 350, "BWD");
  elem = function_7eac7ed595472c9c(x, 360, "+attack");
  elem = function_7eac7ed595472c9c(x, 370, "+speed_throw");
  elem = function_7eac7ed595472c9c(x, 380, "+frag");
  elem = function_7eac7ed595472c9c(x, 390, "+smoke");
  elem = function_7eac7ed595472c9c(x, 400, "+actionslot 1");
  elem = function_7eac7ed595472c9c(x, 410, "+actionslot 2");
  elem = function_7eac7ed595472c9c(x, 420, "+actionslot 3");
  elem = function_7eac7ed595472c9c(x, 430, "+actionslot 4");
}

function elem_used(elem) {
  level.player endon("death");
  msg = "empty";
  msg_released = undefined;
  special_watcher = undefined;

  switch (elem.command) {
    case #"hash_a727710e67c210ae":
      msg = "weapon_switch_pressed";
      msg_released = "weapon_switch_released";
      break;
    case #"hash_c1922905c1b7c5d4":
      msg = "reload_pressed";
      msg_released = "reload_released";
      break;
    case #"hash_121ff0782562a716":
      msg = "stance_pressed";
      msg_released = "stance_released";
      break;
    case #"hash_e2df384de99a55d8":
      msg = "jump_pressed";
      msg_released = "jump_released";
      break;
    case #"hash_74d3c6a203d8ce69":
      msg = "jump_pressed";
      msg_released = "jump_released";
      break;
    case #"hash_145d147f72c3e226":
      msg = "attack_pressed";
      msg_released = "attack_released";
      break;
    case #"hash_515c29a15bc6fb56":
      msg = "ads_pressed";
      msg_released = "ads_released";
      break;
    case #"hash_b382e86ce00ace17":
      msg = "actionslot1";
      break;
    case #"hash_b382e96ce00acfaa":
      msg = "actionslot2";
      break;
    case #"hash_b382ea6ce00ad13d":
      msg = "actionslot3";
      break;
    case #"hash_b382e36ce00ac638":
      msg = "actionslot4";
      break;
    case #"hash_203d8ea2bf3b5dda":
      msg = "frag_pressed";
      msg_released = "frag_released";
      break;
    case #"hash_5b56a4ba0edb6e23":
      msg = "smoke_pressed";
      msg_released = "smoke_released";
      break;
    default:
      break;
  }

  while(true) {
    level.player waittill(msg);
    elem.alpha = 0.8;

    if(isDefined(msg_released)) {
      level.player waittill(msg_released);
    } else {
      wait 0.2;
    }

    elem.alpha = 0.2;
  }
}

function function_e35f3577f69d85c5(elem) {
  level.player endon("death");
  msg = "empty";
  msg_released = undefined;
  special_watcher = undefined;

  switch (elem.str) {
    case #"hash_f0cbcf6c87f7254a":
      thread function_3d932d2039e4023e(elem);
      break;
    case #"hash_1066c36c9909cab6":
      thread function_7b62e26ca7fbb3cc(elem);
      break;
    default:
      break;
  }
}

function function_3d932d2039e4023e(elem) {
  while(true) {
    if(level.player moving_forward()) {
      elem.alpha = 0.8;

      while(level.player moving_forward()) {
        waitframe();
      }

      elem.alpha = 0.2;
    }

    waitframe();
  }
}

function function_7b62e26ca7fbb3cc(elem) {
  while(true) {
    if(level.player moving_backward()) {
      elem.alpha = 0.8;

      while(level.player moving_backward()) {
        waitframe();
      }

      elem.alpha = 0.2;
    }

    waitframe();
  }
}

function function_7eac7ed595472c9c(x, y, command) {
  elem = newhudelem();
  elem.x = x;
  elem.y = y;
  elem.color = (1, 1, 1);
  elem.alpha = 0.2;
  elem.fontscale = 0.75;
  elem.command = command;
  binding = getkeybinding(elem.command);

  if(level.player usinggamepad() || !binding["<dev string:x1c>"]) {
    elem setdevtext("<dev string:x22>" + elem.command + "<dev string:x25>");
  }

  thread elem_used(elem);
  return elem;
}

function function_6606195a237494eb(x, y, str) {
  elem = newhudelem();
  elem.x = x;
  elem.y = y;
  elem.color = (1, 1, 1);
  elem.alpha = 0.2;
  elem.fontscale = 0.75;
  elem.str = str;

  elem setdevtext(str);

  thread function_e35f3577f69d85c5(elem);
  return elem;
}

function moving_forward() {
  return self getnormalizedmovement()[0] > 0.1;
}

function moving_backward() {
  return self getnormalizedmovement()[0] < -0.1;
}