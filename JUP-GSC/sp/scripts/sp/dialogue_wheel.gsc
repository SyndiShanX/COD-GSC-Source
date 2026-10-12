/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\dialogue_wheel.gsc
***********************************************/



#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#namespace dialogue_wheel;

function function_306c305b8c51b11c(options, duration, active, positions, inputholdduration) {
  assert(options.size > 0, "Need at least one dialogue wheel option");
  assert(options.size <= 4, "Cannot have more than 4 dialogue wheel options");

  if(!isDefined(level.dialogue_wheel)) {
    function_1d914778ed5e4032();
  }

  level.dialogue_wheel.options = options;
  level.dialogue_wheel.result = undefined;
  setomnvar("ui_dialogue_prompts_option_a", "none");
  setomnvar("ui_dialogue_prompts_option_b", "none");
  setomnvar("ui_dialogue_prompts_option_c", "none");
  setomnvar("ui_dialogue_prompts_option_d", "none");
  bypass_enabled();

  if(isDefined(positions)) {
    foreach(position in positions) {
      function_e61ab3e2bde6b663(options, position);
    }
  } else {
    for(position = 0; position < options.size; position++) {
      if(!(isstring(options[position]) && options[position] == "none")) {
        function_e61ab3e2bde6b663(options, position);
      }
    }
  }

  if(!isDefined(duration)) {
    duration = 0;
  }

  level.dialogue_wheel.duration = duration;

  if(!isDefined(inputholdduration)) {
    inputholdduration = 0;
  }

  level.dialogue_wheel.inputholdduration = inputholdduration;
  setomnvar("ui_dialogue_prompts_duration", duration);

  if(!isDefined(active)) {
    active = 1;
  }

  if(level.dialogue_wheel.active && !active) {
    function_6f846e9519b4cff2();
  }

  level.dialogue_wheel.active = active;

  if(active) {
    function_ba24ddb136cbab67();
  }
}

function function_e61ab3e2bde6b663(options, position) {
  assert(position >= 0 && position <= 3, "Position must be 0-3");
  omnvar = function_27cb1968e9f31a97(position);
  setomnvar(omnvar, options[position]);
  level.dialogue_wheel.inputs[position].bypass = 0;
}

function function_27cb1968e9f31a97(position) {
  omnvar = "ui_dialogue_prompts_option_";

  switch (position) {
    case 0:
      omnvar += "a";
      break;
    case 1:
      omnvar += "b";
      break;
    case 2:
      omnvar += "c";
      break;
    case 3:
      omnvar += "d";
      break;
  }

  return omnvar;
}

function bypass_enabled() {
  foreach(input in level.dialogue_wheel.inputs) {
    input.bypass = 1;
  }
}

function function_20245cecf244d934() {
  if(!isDefined(level.dialogue_wheel)) {
    return;
  }

  if(level.dialogue_wheel.active) {
    function_6f846e9519b4cff2();
  }

  level.dialogue_wheel = undefined;
}

function function_ffdce2654ea23d5a() {
  if(!isDefined(level.dialogue_wheel)) {
    return 0;
  }

  return level.dialogue_wheel.active;
}

function function_ba24ddb136cbab67() {
  thread function_8d81c892708a5d8e();
  setomnvar("ui_dialogue_prompts_active", 1);
  setomnvar("ui_prompt_hold_progress", 0);
  level.var_db68d53730879e4b = undefined;
  level.var_a8f8b0c2350371b = undefined;
  function_279fb9d5f4a3d7b2();
  level.dialogue_wheel.active = 1;
  level.dialogue_wheel.var_caf1e8e3cbe08856 = level.var_33a0b6852d7ff0d;
  level.var_33a0b6852d7ff0d = 275;
  level.dialogue_wheel.var_4bdf439ffb1842c0 = 0;

  if(level.dialogue_wheel.var_4bdf439ffb1842c0) {
    foreach(input in level.dialogue_wheel.inputs) {
      input thread function_afeae0424199f820();
    }
  } else {
    thread function_98936c4e24c0d9fa();
  }

  thread function_cfe381f310a0f174();
}

function private function_8d81c892708a5d8e() {
  playerusinggamepad = undefined;

  while(function_ffdce2654ea23d5a()) {
    wasusinggamepad = playerusinggamepad;
    playerusinggamepad = level.player usinggamepad();

    if(!is_equal(wasusinggamepad, playerusinggamepad)) {
      level.player val::reset_all("dialogue_wheel");

      if(playerusinggamepad) {
        level.player val::set("dialogue_wheel", "action_slot_weapon", 0);
        level.player val::set("dialogue_wheel", "weapon_alt_mode", 0);
        level.player val::set("dialogue_wheel", "nvg", 0);
      } else {
        cmds = ["+usereload", "+reload", "+frag", "+smoke", "+melee", "+melee_zoom", "+sprint", "+sprint_zoom", "+breath_sprint", "+attack", "+attack_akimbo_accessible", "+toggleads_throw", "+speed_throw", "+ads_akimbo_accessible", "+stance", "+togglecrouch", "+movedown", "+gostand", "+stanceup", "+weapnext", "+weapprev", "selectweapon1", "selectweapon2", "selectweapon3", "+actionslot 1", "+actionslot 2", "+actionslot 3", "+actionslot 4", "armor", "nightvision"];

        foreach(cmd in cmds) {
          if(function_b7d7a703c13eb1df(cmd)) {
            switch (cmd) {
              case #"hash_c1922905c1b7c5d4":
                level.player val::set("dialogue_wheel", "usability", 0);
              case #"hash_d354393c6fd7832f":
                level.player val::set("dialogue_wheel", "reload", 0);
                break;
              case #"hash_203d8ea2bf3b5dda":
                level.player val::set("dialogue_wheel", "offhand_primary_weapons", 0);
                break;
              case #"hash_5b56a4ba0edb6e23":
                level.player val::set("dialogue_wheel", "offhand_secondary_weapons", 0);
                break;
              case #"hash_32bc9ead4c5a2ac8":
              case #"hash_5e7d90c630bf02a2":
                level.player val::set("dialogue_wheel", "melee", 0);
                break;
              case #"hash_74d3c6a203d8ce69":
              case #"hash_c5e1746b311608aa":
              case #"hash_fa9515aca385fed0":
                level.player val::set("dialogue_wheel", "sprint", 0);
                level.player val::set("dialogue_wheel", "supersprint", 0);
                break;
              case #"hash_145d147f72c3e226":
              case #"hash_5c976cabc05a3229":
                level.player val::set("dialogue_wheel", "fire", 0);
                break;
              case #"hash_515c29a15bc6fb56":
              case #"hash_9ea184d2a4d36334":
              case #"hash_a078229a756faf6f":
                level.player val::set("dialogue_wheel", "ads", 0);
                break;
              case #"hash_121ff0782562a716":
              case #"hash_23a4afdda8018a0b":
              case #"hash_5cb36fb3342c2813":
              case #"hash_63d4756e06dd0968":
              case #"hash_e2df384de99a55d8":
                switch (level.player getstance()) {
                  case #"hash_c6775c88e38f7803":
                    level.player val::set("dialogue_wheel", "crouch", 0);
                    level.player val::set("dialogue_wheel", "prone", 0);
                    break;
                  case #"hash_3fed0cbd303639eb":
                    level.player val::set("dialogue_wheel", "stand", 0);
                    level.player val::set("dialogue_wheel", "prone", 0);
                    break;
                  case #"hash_d91940431ed7c605":
                    level.player val::set("dialogue_wheel", "stand", 0);
                    level.player val::set("dialogue_wheel", "crouch", 0);
                    break;
                }

                break;
              case #"hash_a727710e67c210ae":
              case #"hash_adbd970961b37388":
              case #"hash_adbd990961b376ae":
              case #"hash_adbd9a0961b37841":
              case #"hash_b382e36ce00ac638":
              case #"hash_b382e86ce00ace17":
              case #"hash_b382e96ce00acfaa":
              case #"hash_b382ea6ce00ad13d":
              case #"hash_f2c2aac8d326354a":
                level.player val::set("dialogue_wheel", "weapon_switch", 0);
                break;
              case #"hash_25789111b74943b4":
                level.player val::set("dialogue_wheel", "armor", 0);
                break;
              case #"hash_b4b26057ca84210d":
                level.player val::set("dialogue_wheel", "nvg", 0);
                break;
            }
          }
        }
      }
    }

    waitframe();
  }
}

function function_6f846e9519b4cff2() {
  level.player val::reset_all("dialogue_wheel");
  setomnvar("ui_dialogue_prompts_choice", 0);
  setomnvar("ui_dialogue_prompts_active", 0);
  setomnvar("ui_prompt_hold_progress", 0);
  level.var_db68d53730879e4b = undefined;
  level.var_a8f8b0c2350371b = undefined;
  function_279fb9d5f4a3d7b2();
  level.var_33a0b6852d7ff0d = level.dialogue_wheel.var_caf1e8e3cbe08856;
  level.dialogue_wheel.var_caf1e8e3cbe08856 = undefined;
  level.dialogue_wheel.active = 0;

  if(isDefined(level.dialogue_wheel.var_fa4193e691fa32c2)) {
    function_ddb9b7389886bcf2(level.dialogue_wheel.var_fa4193e691fa32c2);
    level.dialogue_wheel.var_fa4193e691fa32c2 = undefined;
  }
}

function function_3d548a32743df49b(duration) {
  level.var_9837358c0745f890 = duration;
}

function function_64c637dd115ff678(duration) {
  level.dialogue_wheel.inputholdduration = duration;
}

function function_d92b8b076e34f82b(options, duration, positions) {
  if(!isDefined(duration) && isDefined(level.var_9837358c0745f890)) {
    duration = level.var_9837358c0745f890;
  }

  function_306c305b8c51b11c(options, duration, 1, positions);
  return function_aba526840f970cda();
}

function function_dad8b67b4a097168(options, funcs, duration, positions) {
  response = undefined;

  while(!isDefined(response)) {
    response = function_d92b8b076e34f82b(options, duration, positions);

    switch (response) {
      case 0:
        if(isDefined(level.var_10cadaa85158716a)) {
          return [[level.var_10cadaa85158716a]]();
        } else {
          response = undefined;
        }

        break;
      case 5:
        if(isDefined(level.var_786ebb8c8449c873)) {
          return [[level.var_786ebb8c8449c873]]();
        } else {
          response = undefined;
        }

        break;
      default:
        assert(funcs.size >= response, "No associated function for response " + response);
        return [[funcs[response - 1]]]();
    }

    waitframe();
  }
}

function function_e6acdf1a7626587e(options, nodes, duration) {
  response = undefined;

  while(!isDefined(response)) {
    response = function_d92b8b076e34f82b(options, duration);

    switch (response) {
      case 0:
        if(isDefined(level.dialoguetree.nodes["silence"])) {
          return level.dialoguetree.nodes["silence"];
        }

        response = undefined;
        break;
      case 5:
        if(isDefined(level.dialoguetree.nodes["attack"])) {
          return level.dialoguetree.nodes["attack"];
        }

        response = undefined;
        break;
      default:
        assert(options.size >= response, "No associated node for response " + response);
        return nodes[response - 1];
    }

    waitframe();
  }
}

function function_b7d7a703c13eb1df(binding) {
  keys = getkeybinding(binding);

  foreach(key in keys) {
    if(index == "count") {
      continue;
    }

    if(key == &"1") {
      return true;
    }

    if(key == &"2") {
      return true;
    }

    if(key == &"3") {
      return true;
    }

    if(key == &"4") {
      return true;
    }
  }

  return false;
}

function function_1d914778ed5e4032() {
  if(isDefined(level.dialogue_wheel)) {
    return;
  }

  level.dialogue_wheel = spawnStruct();
  level.dialogue_wheel.inputs = [function_53e4805c5404e4bb(["DPAD_LEFT", "1"], 1), function_53e4805c5404e4bb(["DPAD_RIGHT", "2"], 2), function_53e4805c5404e4bb(["DPAD_UP", "3"], 3), function_53e4805c5404e4bb(["DPAD_DOWN", "4"], 4)];
  level.dialogue_wheel.active = 0;
  setDvar(@ "hash_d399211bf046a75f", 0.5);
}

function function_53e4805c5404e4bb(buttons, result) {
  struct = spawnStruct();
  struct.buttons = buttons;
  struct.result = result;
  struct.pressed = 0;
  struct.bypass = 0;
  struct.running = 0;
  struct.reset = 0;
  struct.progress = 0;
  return struct;
}

function function_98936c4e24c0d9fa() {
  level.player endon("death");

  while(function_ffdce2654ea23d5a()) {
    level.player notifyonplayercommand("option1", "+actionslot 3");
    level.player notifyonplayercommand("option2", "+actionslot 4");
    level.player notifyonplayercommand("option3", "+actionslot 1");
    level.player notifyonplayercommand("option4", "+actionslot 2");

    if(!istrue(level.var_a8f8b0c2350371b)) {
      input = level.player waittill_any_return("option1", "option2", "option3", "option4");
      is_gamepad = level.player is_player_gamepad_enabled();
      selection = 0;

      switch (input) {
        case #"hash_cd4f55d4aa6a4b1f":
          selection = ter_op(is_gamepad, 1, 3);
          break;
        case #"hash_cd4f56d4aa6a4cb2":
          selection = ter_op(is_gamepad, 2, 1);
          break;
        case #"hash_cd4f57d4aa6a4e45":
          selection = ter_op(is_gamepad, 3, 2);
          break;
        case #"hash_cd4f50d4aa6a4340":
          selection = 4;
          break;
        default:
          selection = 0;
          break;
      }

      if(selection > 0) {
        index = selection - 1;

        if(level.dialogue_wheel.inputs[index].bypass) {
          continue;
        }

        level.dialogue_wheel.inputs[index].pressed = 1;

        if(is_gamepad) {
          setomnvar("ui_prompt_hold_progress", 1);
        }
      }

      setomnvar("ui_dialogue_prompts_choice", selection);
      level.var_a8f8b0c2350371b = 1;
      continue;
    }

    waitframe();
  }
}

function function_afeae0424199f820() {
  if(self.running) {
    return;
  }

  self.running = 1;

  while(isDefined(level.dialogue_wheel)) {
    if(self.reset) {
      self.pressed = 0;

      while(true) {
        should_break = 1;

        foreach(button in self.buttons) {
          if(level.player buttonPressed(button)) {
            should_break = 0;
            setomnvar("ui_prompt_hold_progress", 0);
            break;
          }
        }

        if(should_break) {
          break;
        }

        waitframe();
      }

      self.reset = 0;
    }

    pressed = 0;
    is_gamepad = level.player is_player_gamepad_enabled();

    foreach(button in self.buttons) {
      if(level.player buttonPressed(button) && !self.bypass) {
        if(is_gamepad && !istrue(level.var_a8f8b0c2350371b)) {
          if(level.dialogue_wheel.inputholdduration > 0) {
            if(!isDefined(level.var_db68d53730879e4b) || level.var_db68d53730879e4b == button) {
              self.progress += level.framedurationseconds / level.dialogue_wheel.inputholdduration;
              setomnvar("ui_dialogue_prompts_choice", self.result);
            } else {
              self.progress = 0;
            }
          } else {
            setomnvar("ui_dialogue_prompts_choice", self.result);
            self.progress = 1;
          }

          setomnvar("ui_prompt_hold_progress", self.progress);

          if(self.progress >= 1) {
            level.var_a8f8b0c2350371b = 1;
            pressed = 1;
            break;
          }
        } else {
          pressed = 1;
          break;
        }

        level.var_db68d53730879e4b = button;
        continue;
      }

      if(isDefined(level.var_db68d53730879e4b) && level.var_db68d53730879e4b == button && is_gamepad) {
        if(!isDefined(level.var_a8f8b0c2350371b) && self.progress > 0) {
          self.progress -= level.framedurationseconds;
          setomnvar("ui_prompt_hold_progress", self.progress);
        }
      }
    }

    self.pressed = pressed;
    waitframe();
  }

  self.running = 0;
}

function function_98a2a3001f683ec5(result) {
  foreach(input in level.dialogue_wheel.inputs) {
    if(input.result == result) {
      if(input.bypass) {
        return 0;
      }

      return input.pressed;
    }
  }
}

function function_dc4eb1cb90de68ed() {
  foreach(input in level.dialogue_wheel.inputs) {
    input.reset = 1;
    input.pressed = 0;
    input.progress = 0;
  }
}

function function_cfe381f310a0f174() {
  end_time = undefined;

  if(level.dialogue_wheel.duration > 0) {
    end_time = gettime() + level.dialogue_wheel.duration * 1000;
  }

  function_dc4eb1cb90de68ed();
  result = 0;

  while(level.dialogue_wheel.active && (!isDefined(end_time) || gettime() < end_time)) {
    for(i = 1; i <= level.dialogue_wheel.options.size; i++) {
      if(function_98a2a3001f683ec5(i)) {
        result = i;
        break;
      }
    }

    if(istrue(level.var_51c2c290dfe4ada) && (level.player attackButtonPressed() || level.player meleeButtonPressed())) {
      result = 5;

      if(istrue(level.var_c5104c6853ea5de4)) {
        result = 0;
      }
    }

    if(result > 0) {
      break;
    }

    waitframe();
  }

  if(!level.dialogue_wheel.active) {
    return;
  }

  if(result > 0 && result <= 4) {
    setomnvar("ui_dialogue_prompts_choice", result);
    wait getdvarfloat(@ "hash_d399211bf046a75f", 0.5);
  }

  level.dialogue_wheel.result = result;
  function_6f846e9519b4cff2();
}

function function_aba526840f970cda() {
  while(level.dialogue_wheel.active && !isDefined(level.dialogue_wheel.result)) {
    waitframe();
  }

  return level.dialogue_wheel.result;
}

function function_279fb9d5f4a3d7b2() {
  if(isDefined(level.dialogue_wheel) && isDefined(level.dialogue_wheel.inputs)) {
    function_dc4eb1cb90de68ed();
  }
}