/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\dialogue_wheel.gsc
*********************************************/

#using scripts\anim\dialogue;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\utility;
#namespace dialogue_wheel;

function function_45fd562e8113af01(options, duration, active, positions, inputholdduration, player) {
  assert(options.size > 0, "<dev string:x24>");
  assert(options.size <= 4, "<dev string:x4f>");

  if(!isDefined(player.dialogue_wheel)) {
    player function_8ede08f3aab9d617();
  }

  if(utility::issp()) {
    player = level.player;
  }

  player.dialogue_wheel.options = options;
  player.dialogue_wheel.result = undefined;
  setomnvar("\xfe\x98\\W\x9df\x1b\xef\xae\x1e\xe2o\x9f/\xc5\xa2\x19\x14\xf6\x19\xb88\xe8\xc7\xdeLw\xa0", "\r+x5");
  setomnvar("\x19\xfd\xc2\xc0\xa6<\x83\xe8\xfa\xd0F\xe8\xbc\xe8t>q\xfc\xf2\xf8\xfd\x97@\x9b\xcb\xae<\xa2", "\r+x5");
  setomnvar("\xd6RE\xe52\x86\xd8>\nb\xa27\x859O\x89\x84\x170Wv:m\x04\x9aR\xaed", "\r+x5");
  setomnvar("\xd8d\xf5\x11\x1c>\x12\xc5\xff}i\xc1rP\xdbS\v\x92\xadJ$\f\x03\x0fi\x0e\a\xd3", "\r+x5");
  player bypass_enabled();

  if(isDefined(positions)) {
    foreach(position in positions) {
      function_44cd0b51b646b276(options, position);
    }
  } else {
    for(position = 0; position < options.size; position++) {
      if(!(isstring(options[position]) && options[position] == "\r+x5")) {
        player function_44cd0b51b646b276(options, position);
      }
    }
  }

  if(!isDefined(duration)) {
    duration = 0;
  }

  player.dialogue_wheel.duration = duration;

  if(!isDefined(inputholdduration)) {
    inputholdduration = 0;
  }

  player.dialogue_wheel.inputholdduration = inputholdduration;
  setomnvar("J\xa2\x8b\xbf\x1b\xa7\xf0\xbb\x98\x9d\xfc\xd3{\xf5w\xc5dgsQx\x04!\xf0\xfb\xf3h\xad", duration);

  if(!isDefined(active)) {
    active = 1;
  }

  if(player.dialogue_wheel.active && !active) {
    function_3ba8ea3b654aa003(player);
  }

  player.dialogue_wheel.active = active;

  if(active) {
    function_f7daaf63a4780842(player);
  }
}

function function_44cd0b51b646b276(options, position) {
  assert(position >= 0 && position <= 3, "<dev string:x81>");
  omnvar = function_5b52288f140cc55a(position);
  setomnvar(omnvar, options[position]);
  self.dialogue_wheel.inputs[position].bypass = 0;
}

function function_5b52288f140cc55a(position) {
  omnvar = "\xd2'\xcf{!:/\x17\x0f\xcd\x7f\xac\xf5\r\x15\f\x9a,\xdfD4\xb8\xe4\f\xec\xec\xa2";

  switch (position) {
    case 0:
      omnvar += "$";
      break;
    case 1:
      omnvar += "\xde";
      break;
    case 2:
      omnvar += "\xcc";
      break;
    case 3:
      omnvar += "2";
      break;
  }

  return omnvar;
}

function bypass_enabled() {
  foreach(input in self.dialogue_wheel.inputs) {
    input.bypass = 1;
  }
}

function function_c5bcd509293242b9(player) {
  if(!isDefined(player.dialogue_wheel)) {
    return;
  }

  if(player.dialogue_wheel.active) {
    function_3ba8ea3b654aa003(player);
  }

  player.dialogue_wheel = undefined;
}

function function_c8796e0b1940183b() {
  if(!isDefined(self.dialogue_wheel)) {
    return 0;
  }

  return self.dialogue_wheel.active;
}

function function_f7daaf63a4780842(player) {
  thread function_1f0af92b7e5f2413(player);
  player setclientomnvar("C\xe0\\@\xca\xf1\x94\x03i\xca?\x91lZ\x97\xf5p\x8c\"D\xb3\xf4\xfa\xc5\xce\xc8", 1);
  setomnvar("\x05\xee\xaf\xe8z\x90\x10.R\xf4\xedntU\xe5\x9555UjdA\x8f", 0);
  player.var_892918b995da855e = undefined;
  player.var_162972566407c6f6 = undefined;
  player function_c7dc068919e75cb7();
  player.dialogue_wheel.active = 1;
  player.dialogue_wheel.var_e5bcff930effbe5b = player.var_ab5108c7ff74df68;
  player.var_ab5108c7ff74df68 = 275;
  player.dialogue_wheel.var_17a7592acadf3c8d = 0;

  if(player.dialogue_wheel.var_17a7592acadf3c8d) {
    foreach(input in player.dialogue_wheel.inputs) {
      input thread function_f2551b599ebe2e15(player);
    }
  } else {
    thread function_a88779b6c9afca33(player);
  }

  thread function_3d0323b6a53bf039(player);
}

function private function_1f0af92b7e5f2413(player) {
  playerusinggamepad = undefined;

  if(utility::issp()) {
    player = level.player;
  }

  while(function_c8796e0b1940183b()) {
    wasusinggamepad = playerusinggamepad;
    playerusinggamepad = player usinggamepad();

    if(wasusinggamepad != playerusinggamepad) {
      player val::reset_all("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN");

      if(playerusinggamepad) {
        player val::set("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN", "\xc2\xb4B\x81\a\xba|>M\xf8\x87\x04@n\xddy\a_", 0);
        player val::set("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN", "\x18\xaa\b", 0);
      } else {
        cmds = ["\x1b\xe8=\xd7,d\x1b\xef\x9e<", "\xa1\xae0\x8aJ4\xcf", "n-\xa2\xff\xb9", "?s\x87\xf6\xa0\xc0", "\xa8\x94\xb5Ls\x10", "\x18\xf77d\x8e\\\x1fjq\xbd(", "\xecp(\xbe\x95\xc9=", "\xa0>\xc2\x9f\x1a\x82\xb6\x96EF\xd2R", "\xc2&]\x85h<\x8f\x06\xd6j\xc5\xed\xdc", "\xaaQ\xf1{\xf3\x97\xba", "\xefAm\x17\x93\xa4\xb5\x91`\xb9\x80t\x10\x9a\x86\xad\xad\xe1\x8f\x94\xbbZ\x9a\x0fA", "\x18\xa9`\x13\x97\x9f\x1e\"?E[\xdb\xe4m\x9e;", "\xcf\xa0Tt\xdc\x99\x95q\x96U2u", "\xfa{\\\xcfik\xb7\x8d\xdb\xc8\x98\x99x\\\xb7\xb9\x8d\xbaZ>P\x9a", "\xe88-\x97\xb82a", "b\x06\xaa`]\xbc\xf5>\xa5\xb5\xff*p", "z\xf5\xbaH \x13\xbeo\x87", "\x1d\x93\x85]\b\x86\xbb5", "\xb5\xd0\xc2*A\xad\xfe\xcan", "cc'\x93{\x1d.X\xdf", "\xfa\xfd\xaf\x10\x1f\xce=\x14\xca", "\x9c\x96\x81^\xcf\x96X|\xdd\xa0\x9fQ\xa1", "\xe4\xcd~5/S\x88l\xa6R\x19\xd9F", "{\xcf\xa0E\x01a\xfe\xaa\xda\x8e\xd0\xf5\"", "T\x8c\xa2\xf1\xc1\xbf\x9d1\x89\xf4\xc9;\xec", "\xca\xc2c\x1dZ\xf6s\xcd6o\xa3\x01\xc8", "\x13KI\xd7\x9b\xd1\xabpnj]+\xe1", "F\x8c\xae\xa5bx*'\xed#y\x9cn", "\xf7~{\xb1\x14", "\x11\xac !5B5kw\xb5b"];

        foreach(cmd in cmds) {
          if(function_3d11550e986608fe(cmd)) {
            switch (cmd) {
              case #"hash_c1922905c1b7c5d4":
                player val::set("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN", "`\x16\xae\xa2\xe4t\x187\xe7", 0);
              case #"hash_d354393c6fd7832f":
                player val::set("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN", "\xc9\xca\x1boX\x8c", 0);
                break;
              case #"hash_203d8ea2bf3b5dda":
                player val::set("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN", "K\x80\xde\x10\xf9l\xa7u\xe0\xb3\x18\xd5\xe8\xd2\x83e\xfa(\xdd\xe9\xfe\xc3\xf4", 0);
                break;
              case #"hash_5b56a4ba0edb6e23":
                player val::set("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN", "{\xe0U\x19:$\x9d\\RI\x9e\xb5\xea\x7fs\x81^t\x84\xba\x1ff.:", 0);
                break;
              case #"hash_32bc9ead4c5a2ac8":
              case #"hash_5e7d90c630bf02a2":
                player val::set("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN", "mV\x8d+e", 0);
                break;
              case #"hash_74d3c6a203d8ce69":
              case #"hash_c5e1746b311608aa":
              case #"hash_fa9515aca385fed0":
                player val::set("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN", "\x05\xb1\x1c\x86\x11\xc7", 0);
                player val::set("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN", "\xe7\x1aM\x85+z\x1b\x89\x0fU9", 0);
                break;
              case #"hash_145d147f72c3e226":
              case #"hash_5c976cabc05a3229":
                player val::set("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN", "\xcciN\xca", 0);
                break;
              case #"hash_515c29a15bc6fb56":
              case #"hash_9ea184d2a4d36334":
              case #"hash_a078229a756faf6f":
                player val::set("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN", "\xe4\xf1G", 0);
                break;
              case #"hash_121ff0782562a716":
              case #"hash_23a4afdda8018a0b":
              case #"hash_5cb36fb3342c2813":
              case #"hash_63d4756e06dd0968":
              case #"hash_e2df384de99a55d8":
                switch (player getstance()) {
                  case #"hash_c6775c88e38f7803":
                    player val::set("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN", "1x\xc5\xb4\xabx", 0);
                    player val::set("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN", "GX\xa9]\x82", 0);
                    break;
                  case #"hash_3fed0cbd303639eb":
                    player val::set("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN", "\x8b\x90\xb5\xc4W", 0);
                    player val::set("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN", "GX\xa9]\x82", 0);
                    break;
                  case #"hash_d91940431ed7c605":
                    player val::set("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN", "\x8b\x90\xb5\xc4W", 0);
                    player val::set("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN", "1x\xc5\xb4\xabx", 0);
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
                player val::set("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN", "\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e", 0);
                break;
              case #"hash_25789111b74943b4":
                player val::set("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN", "\xf7~{\xb1\x14", 0);
                break;
              case #"hash_b4b26057ca84210d":
                player val::set("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN", "\x18\xaa\b", 0);
                break;
            }
          }
        }
      }
    }

    waitframe();
  }
}

function function_8073638938ebdbe0(playerdialoguelines, var_3851585883df6573) {
  if(!(isDefined(playerdialoguelines) && isDefined(var_3851585883df6573))) {
    return true;
  }

  return var_3851585883df6573 == 0 || !isDefined(playerdialoguelines[var_3851585883df6573 - 1]) || playerdialoguelines[var_3851585883df6573 - 1] == "^Q/\xb8\x8d\\";
}

function function_3ba8ea3b654aa003(player) {
  if(utility::issp()) {
    player = level.player;
  }

  player val::reset_all("J\x10\x9d\xec\xcfc\xcd\x06?\xc7\xc6=\xbdN");
  player setclientomnvar("\x01\xea\xc1\xfc\xebY&\x831\x9f0\v\x8eo\xa7\xb0lK\t\x9b\xbcP\x83fi\xe9", 0);
  player setclientomnvar("C\xe0\\@\xca\xf1\x94\x03i\xca?\x91lZ\x97\xf5p\x8c\"D\xb3\xf4\xfa\xc5\xce\xc8", 0);
  setomnvar("\x05\xee\xaf\xe8z\x90\x10.R\xf4\xedntU\xe5\x9555UjdA\x8f", 0);
  player.var_892918b995da855e = undefined;
  player.var_162972566407c6f6 = undefined;
  player function_c7dc068919e75cb7();
  player.var_ab5108c7ff74df68 = player.dialogue_wheel.var_e5bcff930effbe5b;
  player.dialogue_wheel.var_e5bcff930effbe5b = undefined;
  player.dialogue_wheel.active = 0;
}

function function_658b3a764a0b0e6a(duration) {
  self.var_2e00bb6dd1f9cbc9 = duration;
}

function function_631c08b52113807d(duration) {
  self.dialogue_wheel.inputholdduration = duration;
}

function function_c0fe2a956788c2aa(options, duration, positions, player) {
  if(utility::issp()) {
    player = level.player;
  }

  if(!isDefined(duration) && isDefined(player.var_2e00bb6dd1f9cbc9)) {
    duration = player.var_2e00bb6dd1f9cbc9;
  }

  player function_45fd562e8113af01(options, duration, 1, positions, undefined, player);
  return player function_13fb6456fb6cf763();
}

function function_8367c857c34f7e69(options, funcs, duration, positions, player) {
  if(utility::issp()) {
    player = level.player;
  }

  response = undefined;

  while(!isDefined(response)) {
    response = function_c0fe2a956788c2aa(options, duration, positions, player);

    switch (response) {
      case 0:
        if(isDefined(level.var_47739c9492194417)) {
          return [[level.var_47739c9492194417]]();
        } else {
          response = undefined;
        }

        break;
      case 5:
        if(isDefined(level.var_b0c0e1c88b8fd7da)) {
          return [[level.var_b0c0e1c88b8fd7da]]();
        } else {
          response = undefined;
        }

        break;
      default:
        assert(funcs.size >= response, "<dev string:x99>" + response);
        return [[funcs[response - 1]]]();
    }

    waitframe();
  }
}

function function_d687bed5051751df(options, nodes, duration, player) {
  if(utility::issp()) {
    player = level.player;
  }

  response = undefined;

  while(!isDefined(response)) {
    response = function_c0fe2a956788c2aa(options, duration, undefined, player);

    switch (response) {
      case 0:
        if(isDefined(level.dialoguetree.nodes["\x0f\xfc\x80\x9c\xde\x9a\xf0"])) {
          return level.dialoguetree.nodes["\x0f\xfc\x80\x9c\xde\x9a\xf0"];
        }

        response = undefined;
        break;
      case 5:
        if(isDefined(level.dialoguetree.nodes["\x11\xf9\x9b\x01\xb2\xf4"])) {
          return level.dialoguetree.nodes["\x11\xf9\x9b\x01\xb2\xf4"];
        }

        response = undefined;
        break;
      default:
        assert(options.size >= response, "<dev string:xc1>" + response);
        return nodes[response - 1];
    }

    waitframe();
  }
}

function function_3d11550e986608fe(binding) {
  return true;
}

function play_dialogue(aliases, stringfile, threaddialogue, dialoguefuncoverride, dialogueparams) {
  playerdialoguelines = [];

  foreach(alias in aliases) {
    playerdialoguelines[playerdialoguelines.size] = stringfile + alias;
  }

  positions = undefined;

  if(playerdialoguelines.size < 3) {
    positions = [2, 3];
    playerdialoguelines = utility::array_combine(["", ""], playerdialoguelines);
    aliases = utility::array_combine(["", ""], aliases);
  }

  var_3851585883df6573 = function_c0fe2a956788c2aa(playerdialoguelines, 6, positions, self);

  if(isDefined(aliases) && !function_8073638938ebdbe0(playerdialoguelines, var_3851585883df6573)) {
    if(!isDefined(dialoguefuncoverride)) {
      dialoguefuncoverride = &dialogue::say_delayed;
    }

    alias = aliases[var_3851585883df6573 - 1];

    if(isDefined(dialogueparams)) {
      if(!isarray(dialogueparams)) {
        dialogueparams = [dialogueparams];
      }

      dialogueparams = utility::array_combine([0, alias], dialogueparams);
    } else {
      dialogueparams = [0, alias];
    }

    if(istrue(threaddialogue)) {
      thread dialogue::call_with_params(dialoguefuncoverride, dialogueparams);
    } else {
      dialogue::call_with_params(dialoguefuncoverride, dialogueparams);
    }
  }

  return var_3851585883df6573;
}

function function_8ede08f3aab9d617() {
  if(isDefined(self.dialogue_wheel)) {
    return;
  }

  self.dialogue_wheel = spawnStruct();
  self.dialogue_wheel.inputs = [function_b4f72003b3ba4cf6(["\x11\xa0(\"\xfa\x98\xa2\x8c*", "\x87"], 1), function_b4f72003b3ba4cf6(["\x98S@\xc7\xf6\xf8C\x82\x15\xfe", "\x19"], 2), function_b4f72003b3ba4cf6([",\xac\xc2\xa4g\xe6\xf4", "?"], 3), function_b4f72003b3ba4cf6(["\x96I\x12H\xa5\xf0z\xe8\x11", "P"], 4)];
  self.dialogue_wheel.active = 0;
}

function function_b4f72003b3ba4cf6(buttons, result) {
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

function function_a88779b6c9afca33(player) {
  if(utility::issp()) {
    player = level.player;
  }

  player endon("\x1e\xfd\xd1\xa2\a");

  while(player function_c8796e0b1940183b()) {
    player notifyonplayercommand("\x10E\xfe\xda\x85{\xe6", "\x13KI\xd7\x9b\xd1\xabpnj]+\xe1");
    player notifyonplayercommand("\x10E\xfe\xda\x85{\xe6", "\xa1u\r\xe9#\x1al&f*\a");
    player notifyonplayercommand("(T\xfa\x83$\xacb", "F\x8c\xae\xa5bx*'\xed#y\x9cn");
    player notifyonplayercommand("(T\xfa\x83$\xacb", "\x82\x97#B\xdd\x9f!W>c\x9b");
    player notifyonplayercommand("\xd1\x9c\x17-\a\xc6\xb9", "T\x8c\xa2\xf1\xc1\xbf\x9d1\x89\xf4\xc9;\xec");
    player notifyonplayercommand("\xd1\x9c\x17-\a\xc6\xb9", "]@\xa3G~\xe6\xce\xcab\xa9\x9c");
    player notifyonplayercommand("+\x18P\x16\x8b\xacn", "\xca\xc2c\x1dZ\xf6s\xcd6o\xa3\x01\xc8");
    player notifyonplayercommand("+\x18P\x16\x8b\xacn", "b\x88B\xae\x85\x19\vv[$I");

    if(!istrue(player.var_162972566407c6f6)) {
      input = player utility::waittill_any_return("\x10E\xfe\xda\x85{\xe6", "(T\xfa\x83$\xacb", "\xd1\x9c\x17-\a\xc6\xb9", "+\x18P\x16\x8b\xacn");
      is_gamepad = player utility::is_player_gamepad_enabled();
      selection = 0;

      switch (input) {
        case #"hash_cd4f55d4aa6a4b1f":
          selection = is_gamepad ? 1 : 3;
          break;
        case #"hash_cd4f56d4aa6a4cb2":
          selection = is_gamepad ? 2 : 1;
          break;
        case #"hash_cd4f57d4aa6a4e45":
          selection = is_gamepad ? 3 : 2;
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

        if(player.dialogue_wheel.inputs[index].bypass) {
          continue;
        }

        player.dialogue_wheel.inputs[index].pressed = 1;

        if(is_gamepad) {
          setomnvar("\x05\xee\xaf\xe8z\x90\x10.R\xf4\xedntU\xe5\x9555UjdA\x8f", 1);
        }
      }

      player setclientomnvar("\x01\xea\xc1\xfc\xebY&\x831\x9f0\v\x8eo\xa7\xb0lK\t\x9b\xbcP\x83fi\xe9", selection);
      player.var_162972566407c6f6 = 1;
      continue;
    }

    waitframe();
  }
}

function function_f2551b599ebe2e15(player) {
  if(self.running) {
    return;
  }

  self.running = 1;

  while(isDefined(player.dialogue_wheel)) {
    if(self.reset) {
      self.pressed = 0;

      while(true) {
        should_break = 1;

        foreach(button in self.buttons) {
          if(player buttonPressed(button)) {
            should_break = 0;
            setomnvar("\x05\xee\xaf\xe8z\x90\x10.R\xf4\xedntU\xe5\x9555UjdA\x8f", 0);
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
    is_gamepad = player utility::is_player_gamepad_enabled();

    foreach(button in self.buttons) {
      if(player buttonPressed(button) && !self.bypass) {
        if(is_gamepad && !istrue(player.var_162972566407c6f6)) {
          if(player.dialogue_wheel.inputholdduration > 0) {
            if(!isDefined(player.var_892918b995da855e) || player.var_892918b995da855e == button) {
              self.progress += player.framedurationseconds / player.dialogue_wheel.inputholdduration;
              player setclientomnvar("\x01\xea\xc1\xfc\xebY&\x831\x9f0\v\x8eo\xa7\xb0lK\t\x9b\xbcP\x83fi\xe9", self.result);
            } else {
              self.progress = 0;
            }
          } else {
            player setclientomnvar("\x01\xea\xc1\xfc\xebY&\x831\x9f0\v\x8eo\xa7\xb0lK\t\x9b\xbcP\x83fi\xe9", self.result);
            self.progress = 1;
          }

          setomnvar("\x05\xee\xaf\xe8z\x90\x10.R\xf4\xedntU\xe5\x9555UjdA\x8f", self.progress);

          if(self.progress >= 1) {
            player.var_162972566407c6f6 = 1;
            pressed = 1;
            break;
          }
        } else {
          pressed = 1;
          break;
        }

        player.var_892918b995da855e = button;
        continue;
      }

      if(isDefined(player.var_892918b995da855e) && player.var_892918b995da855e == button && is_gamepad) {
        if(!isDefined(player.var_162972566407c6f6) && self.progress > 0) {
          self.progress -= player.framedurationseconds;
          setomnvar("\x05\xee\xaf\xe8z\x90\x10.R\xf4\xedntU\xe5\x9555UjdA\x8f", self.progress);
        }
      }
    }

    self.pressed = pressed;
    waitframe();
  }

  self.running = 0;
}

function function_4ab6d0cfe8a1a45c(result) {
  foreach(input in self.dialogue_wheel.inputs) {
    if(input.result == result) {
      if(input.bypass) {
        return 0;
      }

      return input.pressed;
    }
  }
}

function function_5d6a8ac9917c3488() {
  foreach(input in self.dialogue_wheel.inputs) {
    input.reset = 1;
    input.pressed = 0;
    input.progress = 0;
  }
}

function function_3d0323b6a53bf039(player) {
  end_time = undefined;

  if(player.dialogue_wheel.duration > 0) {
    end_time = gettime() + player.dialogue_wheel.duration * 1000;
  }

  player function_5d6a8ac9917c3488();
  result = 0;

  while(player.dialogue_wheel.active && (!isDefined(end_time) || gettime() < end_time)) {
    for(i = 1; i <= player.dialogue_wheel.options.size; i++) {
      if(player function_4ab6d0cfe8a1a45c(i)) {
        result = i;
        break;
      }
    }

    if(istrue(player.var_262ee044a568450b) && (player attackButtonPressed() || player meleeButtonPressed())) {
      result = 5;

      if(istrue(player.var_3c767cfc4cf30a01)) {
        result = 0;
      }
    }

    if(result > 0) {
      break;
    }

    waitframe();
  }

  if(!player.dialogue_wheel.active) {
    return;
  }

  if(result > 0 && result <= 4) {
    setomnvar("\x01\xea\xc1\xfc\xebY&\x831\x9f0\v\x8eo\xa7\xb0lK\t\x9b\xbcP\x83fi\xe9", result);
    wait 1.5;
  }

  player.dialogue_wheel.result = result;
  function_3ba8ea3b654aa003(player);
}

function function_13fb6456fb6cf763() {
  while(self.dialogue_wheel.active && !isDefined(self.dialogue_wheel.result)) {
    waitframe();
  }

  return self.dialogue_wheel.result;
}

function function_c7dc068919e75cb7() {
  if(isDefined(self.dialogue_wheel) && isDefined(self.dialogue_wheel.inputs)) {
    function_5d6a8ac9917c3488();
  }
}