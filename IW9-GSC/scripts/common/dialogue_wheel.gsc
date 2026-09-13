/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\dialogue_wheel.gsc
***********************************************/

_id_306C305B8C51B11C(options, duration, active, _id_E4B7E99A96C8829F, _id_6B9A984D61C9FF12, player) {
  if(!isDefined(player._id_E6CD51FFFB91C08F))
    player _id_1D914778ED5E4032();

  if(scripts\common\utility::issp())
    player = level.player;

  player._id_E6CD51FFFB91C08F.options = options;
  player._id_E6CD51FFFB91C08F.result = undefined;
  setomnvar("ui_dialogue_prompts_option_a", "none");
  setomnvar("ui_dialogue_prompts_option_b", "none");
  setomnvar("ui_dialogue_prompts_option_c", "none");
  setomnvar("ui_dialogue_prompts_option_d", "none");
  player _id_544DB35A3301834F();

  if(isDefined(_id_E4B7E99A96C8829F)) {
    foreach(position in _id_E4B7E99A96C8829F)
    _id_E61AB3E2BDE6B663(options, position);
  } else {
    for(position = 0; position < options.size; position++) {
      if(!(isstring(options[position]) && options[position] == "none"))
        player _id_E61AB3E2BDE6B663(options, position);
    }
  }

  if(!isDefined(duration))
    duration = 0;

  player._id_E6CD51FFFB91C08F.duration = duration;

  if(!isDefined(_id_6B9A984D61C9FF12))
    _id_6B9A984D61C9FF12 = 0;

  player._id_E6CD51FFFB91C08F._id_6B9A984D61C9FF12 = _id_6B9A984D61C9FF12;
  setomnvar("ui_dialogue_prompts_duration", duration);

  if(!isDefined(active))
    active = 1;

  if(player._id_E6CD51FFFB91C08F.active && !active)
    _id_6F846E9519B4CFF2(player);

  player._id_E6CD51FFFB91C08F.active = active;

  if(active)
    _id_BA24DDB136CBAB67(player);
}

_id_E61AB3E2BDE6B663(options, position) {
  omnvar = _id_27CB1968E9F31A97(position);
  setomnvar(omnvar, options[position]);
  self._id_E6CD51FFFB91C08F._id_E096D9982BE6A83C[position]._id_B546524B3FD3D9C9 = 0;
}

_id_27CB1968E9F31A97(position) {
  omnvar = "ui_dialogue_prompts_option_";

  switch (position) {
    case 0:
      omnvar = omnvar + "a";
      break;
    case 1:
      omnvar = omnvar + "b";
      break;
    case 2:
      omnvar = omnvar + "c";
      break;
    case 3:
      omnvar = omnvar + "d";
      break;
  }

  return omnvar;
}

_id_544DB35A3301834F() {
  foreach(input in self._id_E6CD51FFFB91C08F._id_E096D9982BE6A83C)
  input._id_B546524B3FD3D9C9 = 1;
}

_id_20245CECF244D934(player) {
  if(!isDefined(player._id_E6CD51FFFB91C08F)) {
    return;
  }
  if(player._id_E6CD51FFFB91C08F.active)
    _id_6F846E9519B4CFF2(player);

  player._id_E6CD51FFFB91C08F = undefined;
}

_id_FFDCE2654EA23D5A() {
  if(!isDefined(self._id_E6CD51FFFB91C08F))
    return 0;

  return self._id_E6CD51FFFB91C08F.active;
}

_id_BA24DDB136CBAB67(player) {
  thread _id_8D81C892708A5D8E(player);
  player setclientomnvar("ui_dialogue_prompts_active", 1);
  setomnvar("ui_prompt_hold_progress", 0);
  player._id_DB68D53730879E4B = undefined;
  player._id_0A8F8B0C2350371B = undefined;
  player _id_279FB9D5F4A3D7B2();
  player._id_E6CD51FFFB91C08F.active = 1;
  player._id_E6CD51FFFB91C08F._id_CAF1E8E3CBE08856 = player._id_033A0B6852D7FF0D;
  player._id_033A0B6852D7FF0D = 275;
  player._id_E6CD51FFFB91C08F._id_4BDF439FFB1842C0 = 0;

  if(player._id_E6CD51FFFB91C08F._id_4BDF439FFB1842C0) {
    foreach(input in player._id_E6CD51FFFB91C08F._id_E096D9982BE6A83C)
    input thread _id_AFEAE0424199F820(player);
  } else
    thread _id_98936C4E24C0D9FA(player);

  thread _id_CFE381F310A0F174(player);
}

_id_8D81C892708A5D8E(player) {
  _id_B904048B1D6B6803 = undefined;

  if(scripts\common\utility::issp())
    player = level.player;

  while(_id_FFDCE2654EA23D5A()) {
    _id_8C66A4561E2A3B0D = _id_B904048B1D6B6803;
    _id_B904048B1D6B6803 = player usinggamepad();

    if(!scripts\engine\utility::is_equal(_id_8C66A4561E2A3B0D, _id_B904048B1D6B6803)) {
      player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("dialogue_wheel");

      if(_id_B904048B1D6B6803) {
        player _id_3B64EB40368C1450::set("dialogue_wheel", "action_slot_weapon", 0);
        player _id_3B64EB40368C1450::set("dialogue_wheel", "nvg", 0);
      } else {
        _id_89D71924CA01D6E4 = ["+usereload", "+reload", "+frag", "+smoke", "+melee", "+melee_zoom", "+sprint", "+sprint_zoom", "+breath_sprint", "+attack", "+attack_akimbo_accessible", "+toggleads_throw", "+speed_throw", "+ads_akimbo_accessible", "+stance", "+togglecrouch", "+movedown", "+gostand", "+stanceup", "+weapnext", "+weapprev", "selectweapon1", "selectweapon2", "selectweapon3", "+actionslot 1", "+actionslot 2", "+actionslot 3", "+actionslot 4", "armor", "nightvision"];

        foreach(_id_A5516703B3F7D1FF in _id_89D71924CA01D6E4) {
          if(_id_B7D7A703C13EB1DF(_id_A5516703B3F7D1FF)) {
            switch (_id_A5516703B3F7D1FF) {
              case "+usereload":
                player _id_3B64EB40368C1450::set("dialogue_wheel", "usability", 0);
              case "+reload":
                player _id_3B64EB40368C1450::set("dialogue_wheel", "reload", 0);
                break;
              case "+frag":
                player _id_3B64EB40368C1450::set("dialogue_wheel", "offhand_primary_weapons", 0);
                break;
              case "+smoke":
                player _id_3B64EB40368C1450::set("dialogue_wheel", "offhand_secondary_weapons", 0);
                break;
              case "+melee_zoom":
              case "+melee":
                player _id_3B64EB40368C1450::set("dialogue_wheel", "melee", 0);
                break;
              case "+breath_sprint":
              case "+sprint_zoom":
              case "+sprint":
                player _id_3B64EB40368C1450::set("dialogue_wheel", "sprint", 0);
                player _id_3B64EB40368C1450::set("dialogue_wheel", "supersprint", 0);
                break;
              case "+attack_akimbo_accessible":
              case "+attack":
                player _id_3B64EB40368C1450::set("dialogue_wheel", "fire", 0);
                break;
              case "+ads":
              case "+ads_akimbo_accessible":
              case "+speed_throw":
                player _id_3B64EB40368C1450::set("dialogue_wheel", "ads", 0);
                break;
              case "+stanceup":
              case "+gostand":
              case "+movedown":
              case "+togglecrouch":
              case "+stance":
                switch (player getstance()) {
                  case "stand":
                    player _id_3B64EB40368C1450::set("dialogue_wheel", "crouch", 0);
                    player _id_3B64EB40368C1450::set("dialogue_wheel", "prone", 0);
                    break;
                  case "crouch":
                    player _id_3B64EB40368C1450::set("dialogue_wheel", "stand", 0);
                    player _id_3B64EB40368C1450::set("dialogue_wheel", "prone", 0);
                    break;
                  case "prone":
                    player _id_3B64EB40368C1450::set("dialogue_wheel", "stand", 0);
                    player _id_3B64EB40368C1450::set("dialogue_wheel", "crouch", 0);
                    break;
                }

                break;
              case "+actionslot 4":
              case "+actionslot 3":
              case "+actionslot 2":
              case "+actionslot 1":
              case "selectweapon3":
              case "selectweapon2":
              case "selectweapon1":
              case "+weapprev":
              case "+weapnext":
                player _id_3B64EB40368C1450::set("dialogue_wheel", "weapon_switch", 0);
                break;
              case "armor":
                player _id_3B64EB40368C1450::set("dialogue_wheel", "armor", 0);
                break;
              case "nightvision":
                player _id_3B64EB40368C1450::set("dialogue_wheel", "nvg", 0);
                break;
            }
          }
        }
      }
    }

    waitframe();
  }
}

_id_861DC23C52D31C41(_id_5C76167572FCE9C1, _id_8C791B0CE2679FBA) {
  if(!isDefined(_id_5C76167572FCE9C1) || !isDefined(_id_8C791B0CE2679FBA))
    return 1;

  return _id_8C791B0CE2679FBA == 0 || !isDefined(_id_5C76167572FCE9C1[_id_8C791B0CE2679FBA - 1]) || _id_5C76167572FCE9C1[_id_8C791B0CE2679FBA - 1] == "silent";
}

_id_6F846E9519B4CFF2(player) {
  if(scripts\common\utility::issp())
    player = level.player;

  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("dialogue_wheel");
  player setclientomnvar("ui_dialogue_prompts_choice", 0);
  player setclientomnvar("ui_dialogue_prompts_active", 0);
  setomnvar("ui_prompt_hold_progress", 0);
  player._id_DB68D53730879E4B = undefined;
  player._id_0A8F8B0C2350371B = undefined;
  player _id_279FB9D5F4A3D7B2();
  player._id_033A0B6852D7FF0D = player._id_E6CD51FFFB91C08F._id_CAF1E8E3CBE08856;
  player._id_E6CD51FFFB91C08F._id_CAF1E8E3CBE08856 = undefined;
  player._id_E6CD51FFFB91C08F.active = 0;
}

_id_3D548A32743DF49B(duration) {
  self._id_9837358C0745F890 = duration;
}

_id_64C637DD115FF678(duration) {
  self._id_E6CD51FFFB91C08F._id_6B9A984D61C9FF12 = duration;
}

_id_D92B8B076E34F82B(options, duration, _id_E4B7E99A96C8829F, player) {
  if(scripts\common\utility::issp())
    player = level.player;

  if(!isDefined(duration) && isDefined(player._id_9837358C0745F890))
    duration = player._id_9837358C0745F890;

  player _id_306C305B8C51B11C(options, duration, 1, _id_E4B7E99A96C8829F, undefined, player);
  return player _id_ABA526840F970CDA();
}

_id_DAD8B67B4A097168(options, funcs, duration, _id_E4B7E99A96C8829F, player) {
  if(scripts\common\utility::issp())
    player = level.player;

  _id_7E9CCC2D6DDB44DA = undefined;

  while(!isDefined(_id_7E9CCC2D6DDB44DA)) {
    _id_7E9CCC2D6DDB44DA = _id_D92B8B076E34F82B(options, duration, _id_E4B7E99A96C8829F, player);

    switch (_id_7E9CCC2D6DDB44DA) {
      case 0:
        if(isDefined(level._id_10CADAA85158716A))
          return [[level._id_10CADAA85158716A]]();
        else
          _id_7E9CCC2D6DDB44DA = undefined;

        break;
      case 5:
        if(isDefined(level._id_786EBB8C8449C873))
          return [[level._id_786EBB8C8449C873]]();
        else
          _id_7E9CCC2D6DDB44DA = undefined;

        break;
      default:
        return [[funcs[_id_7E9CCC2D6DDB44DA - 1]]]();
    }

    waitframe();
  }
}

_id_E6ACDF1A7626587E(options, nodes, duration, player) {
  if(scripts\common\utility::issp())
    player = level.player;

  _id_7E9CCC2D6DDB44DA = undefined;

  while(!isDefined(_id_7E9CCC2D6DDB44DA)) {
    _id_7E9CCC2D6DDB44DA = _id_D92B8B076E34F82B(options, duration, undefined, player);

    switch (_id_7E9CCC2D6DDB44DA) {
      case 0:
        if(isDefined(level._id_1B2599094F1AA7A3.nodes["silence"]))
          return level._id_1B2599094F1AA7A3.nodes["silence"];

        _id_7E9CCC2D6DDB44DA = undefined;
        break;
      case 5:
        if(isDefined(level._id_1B2599094F1AA7A3.nodes["attack"]))
          return level._id_1B2599094F1AA7A3.nodes["attack"];

        _id_7E9CCC2D6DDB44DA = undefined;
        break;
      default:
        return nodes[_id_7E9CCC2D6DDB44DA - 1];
    }

    waitframe();
  }
}

_id_B7D7A703C13EB1DF(binding) {
  return 1;
}

play_dialogue(aliases, _id_8434387BBF43985A, _id_085AEDCD1AAF0A83, _id_AE7EFD102FC19BB5, _id_BB81DD63C26DF58D) {
  _id_5C76167572FCE9C1 = [];

  foreach(alias in aliases)
  _id_5C76167572FCE9C1[_id_5C76167572FCE9C1.size] = _id_8434387BBF43985A + alias;

  _id_E4B7E99A96C8829F = undefined;

  if(_id_5C76167572FCE9C1.size < 3) {
    _id_E4B7E99A96C8829F = [2, 3];
    _id_5C76167572FCE9C1 = scripts\engine\utility::array_combine(["", ""], _id_5C76167572FCE9C1);
    aliases = scripts\engine\utility::array_combine(["", ""], aliases);
  }

  _id_8C791B0CE2679FBA = _id_D92B8B076E34F82B(_id_5C76167572FCE9C1, 6, _id_E4B7E99A96C8829F, self);

  if(isDefined(aliases) && !_id_861DC23C52D31C41(_id_5C76167572FCE9C1, _id_8C791B0CE2679FBA)) {
    _id_AE7EFD102FC19BB5 = scripts\engine\utility::_id_53C4C53197386572(_id_AE7EFD102FC19BB5, _id_5D265B4FCA61F070::_id_88357F565D1BADF5);
    alias = aliases[_id_8C791B0CE2679FBA - 1];

    if(isDefined(_id_BB81DD63C26DF58D)) {
      if(!isarray(_id_BB81DD63C26DF58D))
        _id_BB81DD63C26DF58D = [_id_BB81DD63C26DF58D];

      _id_BB81DD63C26DF58D = scripts\engine\utility::array_combine([0, alias], _id_BB81DD63C26DF58D);
    } else
      _id_BB81DD63C26DF58D = [0, alias];

    if(istrue(_id_085AEDCD1AAF0A83))
      thread _id_5D265B4FCA61F070::call_with_params(_id_AE7EFD102FC19BB5, _id_BB81DD63C26DF58D);
    else
      _id_5D265B4FCA61F070::call_with_params(_id_AE7EFD102FC19BB5, _id_BB81DD63C26DF58D);
  }

  return _id_8C791B0CE2679FBA;
}

_id_1D914778ED5E4032() {
  if(isDefined(self._id_E6CD51FFFB91C08F)) {
    return;
  }
  self._id_E6CD51FFFB91C08F = spawnStruct();
  self._id_E6CD51FFFB91C08F._id_E096D9982BE6A83C = [_id_53E4805C5404E4BB(["DPAD_LEFT", "1"], 1), _id_53E4805C5404E4BB(["DPAD_RIGHT", "2"], 2), _id_53E4805C5404E4BB(["DPAD_UP", "3"], 3), _id_53E4805C5404E4BB(["DPAD_DOWN", "4"], 4)];
  self._id_E6CD51FFFB91C08F.active = 0;
}

_id_53E4805C5404E4BB(buttons, result) {
  struct = spawnStruct();
  struct.buttons = buttons;
  struct.result = result;
  struct.pressed = 0;
  struct._id_B546524B3FD3D9C9 = 0;
  struct.running = 0;
  struct.reset = 0;
  struct.progress = 0;
  return struct;
}

_id_98936C4E24C0D9FA(player) {
  if(scripts\common\utility::issp())
    player = level.player;

  player endon("death");

  while(player _id_FFDCE2654EA23D5A()) {
    player notifyonplayercommand("option1", "+actionslot 3");
    player notifyonplayercommand("option1", "killstreak3");
    player notifyonplayercommand("option2", "+actionslot 4");
    player notifyonplayercommand("option2", "killstreak1");
    player notifyonplayercommand("option3", "+actionslot 1");
    player notifyonplayercommand("option3", "killstreak2");
    player notifyonplayercommand("option4", "+actionslot 2");
    player notifyonplayercommand("option4", "killstreak4");

    if(!istrue(player._id_0A8F8B0C2350371B)) {
      input = player scripts\engine\utility::waittill_any_return_4("option1", "option2", "option3", "option4");
      _id_49BF6CFBB891ABED = player scripts\engine\utility::is_player_gamepad_enabled();
      selection = 0;

      switch (input) {
        case "option1":
          selection = scripts\engine\utility::ter_op(_id_49BF6CFBB891ABED, 1, 3);
          break;
        case "option2":
          selection = scripts\engine\utility::ter_op(_id_49BF6CFBB891ABED, 2, 1);
          break;
        case "option3":
          selection = scripts\engine\utility::ter_op(_id_49BF6CFBB891ABED, 3, 2);
          break;
        case "option4":
          selection = 4;
          break;
        default:
          selection = 0;
          break;
      }

      if(selection > 0) {
        index = selection - 1;

        if(player._id_E6CD51FFFB91C08F._id_E096D9982BE6A83C[index]._id_B546524B3FD3D9C9) {
          continue;
        }
        player._id_E6CD51FFFB91C08F._id_E096D9982BE6A83C[index].pressed = 1;

        if(_id_49BF6CFBB891ABED)
          setomnvar("ui_prompt_hold_progress", 1);
      }

      player setclientomnvar("ui_dialogue_prompts_choice", selection);
      player._id_0A8F8B0C2350371B = 1;
      continue;
    }

    waitframe();
  }
}

_id_AFEAE0424199F820(player) {
  if(self.running) {
    return;
  }
  self.running = 1;

  while(isDefined(player._id_E6CD51FFFB91C08F)) {
    if(self.reset) {
      self.pressed = 0;

      for(;;) {
        _id_00E0A884D37E9A9E = 1;

        foreach(button in self.buttons) {
          if(player buttonPressed(button)) {
            _id_00E0A884D37E9A9E = 0;
            setomnvar("ui_prompt_hold_progress", 0);
            break;
          }
        }

        if(_id_00E0A884D37E9A9E) {
          break;
        }

        waitframe();
      }

      self.reset = 0;
    }

    pressed = 0;
    _id_49BF6CFBB891ABED = player scripts\engine\utility::is_player_gamepad_enabled();

    foreach(button in self.buttons) {
      if(player buttonPressed(button) && !self._id_B546524B3FD3D9C9) {
        if(_id_49BF6CFBB891ABED && !istrue(player._id_0A8F8B0C2350371B)) {
          if(player._id_E6CD51FFFB91C08F._id_6B9A984D61C9FF12 > 0) {
            if(!isDefined(player._id_DB68D53730879E4B) || player._id_DB68D53730879E4B == button) {
              self.progress = self.progress + player.framedurationseconds / player._id_E6CD51FFFB91C08F._id_6B9A984D61C9FF12;
              player setclientomnvar("ui_dialogue_prompts_choice", self.result);
            } else
              self.progress = 0;
          } else {
            player setclientomnvar("ui_dialogue_prompts_choice", self.result);
            self.progress = 1;
          }

          setomnvar("ui_prompt_hold_progress", self.progress);

          if(self.progress >= 1) {
            player._id_0A8F8B0C2350371B = 1;
            pressed = 1;
            break;
          }
        } else {
          pressed = 1;
          break;
        }

        player._id_DB68D53730879E4B = button;
        continue;
      }

      if(isDefined(player._id_DB68D53730879E4B) && player._id_DB68D53730879E4B == button && _id_49BF6CFBB891ABED) {
        if(!isDefined(player._id_0A8F8B0C2350371B) && self.progress > 0) {
          self.progress = self.progress - player.framedurationseconds;
          setomnvar("ui_prompt_hold_progress", self.progress);
        }
      }
    }

    self.pressed = pressed;
    waitframe();
  }

  self.running = 0;
}

_id_98A2A3001F683EC5(result) {
  foreach(input in self._id_E6CD51FFFB91C08F._id_E096D9982BE6A83C) {
    if(input.result == result) {
      if(input._id_B546524B3FD3D9C9)
        return 0;
      else
        return input.pressed;
    }
  }
}

_id_DC4EB1CB90DE68ED() {
  foreach(input in self._id_E6CD51FFFB91C08F._id_E096D9982BE6A83C) {
    input.reset = 1;
    input.pressed = 0;
    input.progress = 0;
  }
}

_id_CFE381F310A0F174(player) {
  end_time = undefined;

  if(player._id_E6CD51FFFB91C08F.duration > 0)
    end_time = gettime() + player._id_E6CD51FFFB91C08F.duration * 1000;

  player _id_DC4EB1CB90DE68ED();
  result = 0;

  while(player._id_E6CD51FFFB91C08F.active && (!isDefined(end_time) || gettime() < end_time)) {
    for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= player._id_E6CD51FFFB91C08F.options.size; _id_AC0E594AC96AA3A8++) {
      if(player _id_98A2A3001F683EC5(_id_AC0E594AC96AA3A8)) {
        result = _id_AC0E594AC96AA3A8;
        break;
      }
    }

    if(istrue(player._id_051C2C290DFE4ADA) && (player attackButtonPressed() || player meleeButtonPressed())) {
      result = 5;

      if(istrue(player._id_C5104C6853EA5DE4))
        result = 0;
    }

    if(result > 0) {
      break;
    }

    waitframe();
  }

  if(!player._id_E6CD51FFFB91C08F.active) {
    return;
  }
  if(result > 0 && result <= 4) {
    setomnvar("ui_dialogue_prompts_choice", result);
    wait 1.5;
  }

  player._id_E6CD51FFFB91C08F.result = result;
  _id_6F846E9519B4CFF2(player);
}

_id_ABA526840F970CDA() {
  while(self._id_E6CD51FFFB91C08F.active && !isDefined(self._id_E6CD51FFFB91C08F.result))
    waitframe();

  return self._id_E6CD51FFFB91C08F.result;
}

_id_279FB9D5F4A3D7B2() {
  if(isDefined(self._id_E6CD51FFFB91C08F) && isDefined(self._id_E6CD51FFFB91C08F._id_E096D9982BE6A83C))
    _id_DC4EB1CB90DE68ED();
}