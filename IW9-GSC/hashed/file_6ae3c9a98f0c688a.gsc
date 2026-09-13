/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6ae3c9a98f0c688a.gsc
***********************************************/

_id_57923A2BA2D6847A() {
  if(isDefined(level._id_09D983CE78A43068)) {
    return;
  }
  level._id_09D983CE78A43068 = spawnStruct();
  level._id_09D983CE78A43068.interacts = [];
  level._id_09D983CE78A43068._id_C3C4C3CF42901562 = [];
  level._id_09D983CE78A43068._id_93474A026F85FBA8 = [];
  level thread _id_9FAB9A31F53D1794();
}

#using_animtree("script_model");

_id_9FAB9A31F53D1794() {
  if(isDefined(level.scr_animtree["plyr_generator"])) {
    return;
  }
  level.scr_animtree["plyr_generator"] = #animtree;
  level.scr_anim["plyr_generator"]["interact"] = % iw9_cp_raid_generator_start;
  level.scr_animname["plyr_generator"]["interact"] = "iw9_cp_raid_generator_start";
  level.scr_eventanim["plyr_generator"]["interact"] = "iw9_cp_raid_generator_start";
  level.scr_animtree["generator_prop"] = #animtree;
  level.scr_anim["generator_prop"]["interact"] = % iw9_cp_raid_generator_start_generator;
  level.scr_animname["generator_prop"]["interact"] = "iw9_cp_raid_generator_start_generator";
}

_id_E4D9CF45F9CB9AE1(_id_F3CF71E4E9C89BF5) {
  _id_57923A2BA2D6847A();

  if(isDefined(_id_F3CF71E4E9C89BF5)) {
    if(isarray(_id_F3CF71E4E9C89BF5)) {
      foreach(item in _id_F3CF71E4E9C89BF5)
      level._id_09D983CE78A43068._id_93474A026F85FBA8[level._id_09D983CE78A43068._id_93474A026F85FBA8.size] = item;
    } else
      level._id_09D983CE78A43068._id_93474A026F85FBA8[level._id_09D983CE78A43068._id_93474A026F85FBA8.size] = _id_F3CF71E4E9C89BF5;
  }
}

_id_CC433302DE7F5602(_id_1359FC06440FB162) {
  _id_57923A2BA2D6847A();

  if(isDefined(_id_1359FC06440FB162)) {
    if(isarray(_id_1359FC06440FB162)) {
      foreach(item in _id_1359FC06440FB162)
      level._id_09D983CE78A43068._id_93474A026F85FBA8 scripts\engine\utility::array_remove(level._id_09D983CE78A43068._id_93474A026F85FBA8, item);
    } else
      level._id_09D983CE78A43068._id_93474A026F85FBA8 scripts\engine\utility::array_remove(level._id_09D983CE78A43068._id_93474A026F85FBA8, _id_1359FC06440FB162);
  }
}

_id_E8E9FE071F1B7994() {
  foreach(interact in level._id_09D983CE78A43068.interacts)
  interact _id_B5A1E5FC47439627();
}

_id_B5A1E5FC47439627() {
  if(isDefined(self.fx_model))
    self.fx_model delete();

  self delete();
}

_id_BE9B253BA2567A0E() {
  _id_57923A2BA2D6847A();
  _id_2639F6CD79A6BA22 = spawn("script_model", self.origin);
  _id_2639F6CD79A6BA22.angles = self.origin;
  _id_2639F6CD79A6BA22 setModel("tag_origin");
  _id_2639F6CD79A6BA22.targetname = "interact_gas_usable";

  if(isDefined(self.script_function))
    self._id_B6409F38A17887BC = int(self.script_function);

  level._id_09D983CE78A43068.interacts[level._id_09D983CE78A43068.interacts.size] = _id_2639F6CD79A6BA22;

  if(isDefined(self.target)) {
    _id_75A6A6329A99050B = scripts\engine\utility::getStruct(self.target, "targetname");
    self.fx_model = spawn("script_model", _id_75A6A6329A99050B.origin);
    self.fx_model.angles = _id_75A6A6329A99050B.angles;
    self.fx_model setModel("tag_origin_generator_cp_toggleable");
    _id_2639F6CD79A6BA22.fx_model = self.fx_model;
    level._id_09D983CE78A43068._id_C3C4C3CF42901562[level._id_09D983CE78A43068._id_C3C4C3CF42901562.size] = self.fx_model;
  }

  _id_2639F6CD79A6BA22 endon("death");
  _id_2639F6CD79A6BA22 makeusable();
  _id_2639F6CD79A6BA22 setHintString(&"CP_RAID_WATERMAZE/GAS_TEXT_PROMPT");
  _id_2639F6CD79A6BA22 setCursorHint("HINT_BUTTON");
  _id_2639F6CD79A6BA22 sethinticon("icon_electrical_box");
  _id_2639F6CD79A6BA22 sethintdisplayrange(265);
  _id_2639F6CD79A6BA22 sethintdisplayfov(80);
  _id_2639F6CD79A6BA22 setuserange(65);
  _id_2639F6CD79A6BA22 setusefov(50);
  _id_2639F6CD79A6BA22 setuseholdduration("duration_short");

  for(;;) {
    _id_2639F6CD79A6BA22 waittill("trigger", player);

    if(isDefined(player)) {
      if(!player scripts\cp\utility::is_valid_player()) {
        continue;
      }
      _id_2639F6CD79A6BA22 setHintString(&"CP_RAID_WATERMAZE/GAS_TEXT_PROMPT_DISABLED");
      _id_2639F6CD79A6BA22 setuseholdduration("duration_none");
      _id_2639F6CD79A6BA22 _meth_DFB78B3E724AD620(1);
      _id_CE15E68E59D99AE6 = getEnt("usable_generator", "script_noteworthy");
      _id_2639F6CD79A6BA22 _id_EB88D0E99B9E2FDE(player, _id_CE15E68E59D99AE6);

      if(isDefined(level._id_8ECC159BA05FA524))
        _id_2639F6CD79A6BA22 thread[[level._id_8ECC159BA05FA524]](player);

      _id_2639F6CD79A6BA22 notify("switch_used");

      if(getdvarint("dvar_CC49686A319AE9E4", 1) > 0) {
        level _id_DB5340FDE823F8DD(player, self);
        _id_B6409F38A17887BC = _id_86EB730E25B75A98();
        _id_B6409F38A17887BC = _id_B6409F38A17887BC + 2;
        wait(_id_B6409F38A17887BC);
      } else
        level _id_4500EB254FFE4241(player, self);

      _id_2639F6CD79A6BA22 setHintString(&"CP_RAID_WATERMAZE/GAS_TEXT_PROMPT");
      _id_2639F6CD79A6BA22 setuseholdduration("duration_short");
      _id_2639F6CD79A6BA22 _meth_DFB78B3E724AD620(1);
    }
  }
}

_id_EB88D0E99B9E2FDE(player, _id_CE15E68E59D99AE6) {
  self.scenenode = _id_CE15E68E59D99AE6;
  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "plyr_generator", 1, 1);
  _id_B548BD538F7474C3 = scripts\cp_mp\anim_scene::anim_scene_create_actor(_id_CE15E68E59D99AE6, "generator_prop", 0);
  started = self.scenenode scripts\cp_mp\anim_scene::anim_scene([actorplayer, _id_B548BD538F7474C3], "interact", 1, 1) && player scripts\cp_mp\utility\player_utility::_isalive();
}

_id_4500EB254FFE4241(player, _id_02DD49B127A649B3) {
  player _id_B03E025DFC2E0232(1);
  _id_02DD49B127A649B3._id_01D2F28029E15B4E = 0;
  _id_02DD49B127A649B3._id_F62D579BD8570941 = 1;
  _id_02DD49B127A649B3._id_E205224CDF17409E = spawnStruct();
  _id_02DD49B127A649B3._id_E205224CDF17409E.xoffset = 0;
  _id_02DD49B127A649B3._id_E205224CDF17409E.yoffset = 100;
  _id_02DD49B127A649B3._id_E205224CDF17409E._id_1508DE2F75BBBFF9 = 1.0;
  _id_02DD49B127A649B3._id_E205224CDF17409E._id_03A3B0DD3F5C5826 = player scripts\cp\utility::createprimaryprogressbar(_id_02DD49B127A649B3._id_E205224CDF17409E.xoffset, _id_02DD49B127A649B3._id_E205224CDF17409E.yoffset);
  _id_4C7D80B6C6063955 = player scripts\cp\utility::createprimaryprogressbartext(_id_02DD49B127A649B3._id_E205224CDF17409E.xoffset, _id_02DD49B127A649B3._id_E205224CDF17409E.yoffset - 5, 0.75);
  _id_4C7D80B6C6063955 settext(&"CP_RAID_WATERMAZE/GAS_TEXT");
  _id_02DD49B127A649B3._id_E205224CDF17409E._id_03A3B0DD3F5C5826.bar.alpha = 0.8;
  _id_02DD49B127A649B3._id_E205224CDF17409E._id_458732D7065D0BB9 = 3;

  if(getdvarint("dvar_88D2B7F20BC174AD"))
    _id_02DD49B127A649B3._id_E205224CDF17409E._id_458732D7065D0BB9 = getdvarint("dvar_88D2B7F20BC174AD");

  for(_id_02DD49B127A649B3._id_E205224CDF17409E.tier = 0; _id_02DD49B127A649B3._id_E205224CDF17409E.tier < _id_02DD49B127A649B3._id_E205224CDF17409E._id_458732D7065D0BB9; _id_02DD49B127A649B3._id_E205224CDF17409E.tier++) {
    _id_02DD49B127A649B3._id_E205224CDF17409E._id_CE9198CD204154A0 = 30;
    _id_02DD49B127A649B3._id_E205224CDF17409E._id_043404010BA46177 = int(level.primaryprogressbarheight * 0.9);
    _id_02DD49B127A649B3._id_E205224CDF17409E._id_FD9E77DD224FDD4F = randomintrange(25, 35);
    _id_02DD49B127A649B3._id_E205224CDF17409E.duration = 1.5;

    if(_id_02DD49B127A649B3._id_E205224CDF17409E.tier == 1) {
      _id_02DD49B127A649B3._id_E205224CDF17409E._id_CE9198CD204154A0 = 27;
      _id_02DD49B127A649B3._id_E205224CDF17409E._id_FD9E77DD224FDD4F = randomintrange(0, 15);
    } else if(_id_02DD49B127A649B3._id_E205224CDF17409E.tier == 2) {
      _id_02DD49B127A649B3._id_E205224CDF17409E._id_CE9198CD204154A0 = 25;
      _id_02DD49B127A649B3._id_E205224CDF17409E._id_FD9E77DD224FDD4F = randomintrange(15, 25);
    } else if(_id_02DD49B127A649B3._id_E205224CDF17409E.tier >= 3) {
      _id_02DD49B127A649B3._id_E205224CDF17409E._id_CE9198CD204154A0 = 25;
      _id_02DD49B127A649B3._id_E205224CDF17409E._id_FD9E77DD224FDD4F = randomintrange(0, 35);
    }

    _id_02DD49B127A649B3._id_E205224CDF17409E._id_10166126F2A2629F = player scripts\cp\utility::createbar((255, 255, 0), _id_02DD49B127A649B3._id_E205224CDF17409E._id_CE9198CD204154A0, _id_02DD49B127A649B3._id_E205224CDF17409E._id_043404010BA46177);
    _id_02DD49B127A649B3._id_E205224CDF17409E._id_10166126F2A2629F scripts\cp\utility::setpoint("CENTER", undefined, level.primaryprogressbarx + _id_02DD49B127A649B3._id_E205224CDF17409E.xoffset + _id_02DD49B127A649B3._id_E205224CDF17409E._id_FD9E77DD224FDD4F, level.primaryprogressbary + _id_02DD49B127A649B3._id_E205224CDF17409E.yoffset);
    _id_02DD49B127A649B3._id_E205224CDF17409E._id_10166126F2A2629F scripts\cp\utility::updatebar(1, 0.05);
    _id_02DD49B127A649B3._id_E205224CDF17409E._id_10166126F2A2629F.sort = -20;
    player thread _id_33E9FBCB37487569(_id_02DD49B127A649B3, _id_02DD49B127A649B3._id_E205224CDF17409E._id_03A3B0DD3F5C5826, _id_02DD49B127A649B3._id_E205224CDF17409E._id_FD9E77DD224FDD4F, _id_02DD49B127A649B3._id_E205224CDF17409E._id_CE9198CD204154A0);
    _id_02DD49B127A649B3._id_E205224CDF17409E.waitedtime = 0;

    if(getdvarint("dvar_A28AAC3A448CE2AF"))
      _id_02DD49B127A649B3._id_E205224CDF17409E._id_03A3B0DD3F5C5826 scripts\cp\utility::updatebar(0, 1 / _id_02DD49B127A649B3._id_E205224CDF17409E.duration);
    else
      level thread _id_47AADF7BC2BDDBCB(_id_02DD49B127A649B3);

    _id_02DD49B127A649B3._id_E205224CDF17409E._id_A90C378111E22B4F = gettime();

    for(_id_02DD49B127A649B3._id_E205224CDF17409E.waitedtime = 0; _id_02DD49B127A649B3._id_E205224CDF17409E.waitedtime < _id_02DD49B127A649B3._id_E205224CDF17409E.duration && isalive(player) && !level.gameended && !_id_02DD49B127A649B3._id_01D2F28029E15B4E; _id_02DD49B127A649B3._id_E205224CDF17409E.waitedtime = _id_02DD49B127A649B3._id_E205224CDF17409E.waitedtime + 0.05)
      wait 0.05;

    if(_id_02DD49B127A649B3._id_01D2F28029E15B4E || _id_02DD49B127A649B3._id_F62D579BD8570941) {
      wait(_id_02DD49B127A649B3._id_E205224CDF17409E._id_1508DE2F75BBBFF9);

      if(isDefined(_id_02DD49B127A649B3._id_E205224CDF17409E._id_10166126F2A2629F))
        _id_02DD49B127A649B3._id_E205224CDF17409E._id_10166126F2A2629F scripts\cp\utility::destroyelem();

      break;
    }

    if(_id_02DD49B127A649B3._id_E205224CDF17409E.tier < _id_02DD49B127A649B3._id_E205224CDF17409E._id_458732D7065D0BB9) {
      if(isDefined(_id_02DD49B127A649B3._id_E205224CDF17409E._id_10166126F2A2629F))
        _id_02DD49B127A649B3._id_E205224CDF17409E._id_10166126F2A2629F scripts\cp\utility::destroyelem();
    }

    wait 0.05;
  }

  _id_02DD49B127A649B3._id_E205224CDF17409E notify("clear_bars");

  if(isDefined(_id_02DD49B127A649B3._id_E205224CDF17409E._id_7EE72AB2C28218D7))
    _id_02DD49B127A649B3._id_E205224CDF17409E._id_7EE72AB2C28218D7 destroy();

  if(isDefined(_id_4C7D80B6C6063955))
    _id_4C7D80B6C6063955 scripts\cp\utility::destroyelem();

  if(!_id_02DD49B127A649B3._id_01D2F28029E15B4E && !_id_02DD49B127A649B3._id_F62D579BD8570941)
    _id_DB5340FDE823F8DD(player, _id_02DD49B127A649B3);

  if(isDefined(_id_02DD49B127A649B3._id_E205224CDF17409E._id_03A3B0DD3F5C5826))
    _id_02DD49B127A649B3._id_E205224CDF17409E._id_03A3B0DD3F5C5826 scripts\cp\utility::destroyelem();

  if(isDefined(_id_02DD49B127A649B3._id_E205224CDF17409E._id_10166126F2A2629F))
    _id_02DD49B127A649B3._id_E205224CDF17409E._id_10166126F2A2629F scripts\cp\utility::destroyelem();

  player _id_B03E025DFC2E0232(0);
}

_id_47AADF7BC2BDDBCB(_id_02DD49B127A649B3) {
  _id_02DD49B127A649B3._id_E205224CDF17409E endon("clear_bars");
  _id_02DD49B127A649B3._id_E205224CDF17409E endon("pause_bar_progress");

  while(_id_02DD49B127A649B3._id_E205224CDF17409E.waitedtime < _id_02DD49B127A649B3._id_E205224CDF17409E.duration) {
    if(isDefined(_id_02DD49B127A649B3._id_E205224CDF17409E._id_03A3B0DD3F5C5826))
      _id_02DD49B127A649B3._id_E205224CDF17409E._id_03A3B0DD3F5C5826 scripts\cp\utility::updatebar(_id_02DD49B127A649B3._id_E205224CDF17409E.waitedtime / _id_02DD49B127A649B3._id_E205224CDF17409E.duration);

    wait 0.05;
  }
}

_id_33E9FBCB37487569(_id_02DD49B127A649B3, barelem, _id_FD9E77DD224FDD4F, _id_CE9198CD204154A0) {
  _id_02DD49B127A649B3._id_F62D579BD8570941 = 1;
  thread _id_FDEFAC01300C1001(_id_02DD49B127A649B3);

  while(self useButtonPressed() && isDefined(_id_02DD49B127A649B3._id_E205224CDF17409E._id_03A3B0DD3F5C5826))
    wait 0.05;

  if(!isDefined(_id_02DD49B127A649B3._id_E205224CDF17409E._id_03A3B0DD3F5C5826)) {
    return;
  }
  _id_E5833A1D040F52A5 = 0;
  wait 0.25;
  _id_D2DD49D574F3D224 = _id_7EDBF100D0F22529(_id_02DD49B127A649B3);

  while(isDefined(barelem) && _id_D2DD49D574F3D224 < 1) {
    _id_D2DD49D574F3D224 = _id_7EDBF100D0F22529(_id_02DD49B127A649B3);

    if(self useButtonPressed() && !_id_E5833A1D040F52A5) {
      _id_E5833A1D040F52A5 = 1;
      _id_02DD49B127A649B3._id_E205224CDF17409E notify("pause_bar_progress");
      _id_02DD49B127A649B3._id_F62D579BD8570941 = 0;
      _id_8584638D433C38F0 = _id_FE846D6A171C6861(_id_02DD49B127A649B3);
      _id_8561598D4315DB3A = _id_FEA85F6A1744C44F(_id_02DD49B127A649B3);

      if(_id_D2DD49D574F3D224 >= _id_8584638D433C38F0 && _id_D2DD49D574F3D224 <= _id_8561598D4315DB3A) {
        if(_id_02DD49B127A649B3._id_E205224CDF17409E.tier + 1 >= _id_02DD49B127A649B3._id_E205224CDF17409E._id_458732D7065D0BB9)
          thread _id_F8811A708892F993(_id_02DD49B127A649B3, 1, 1);
        else
          thread _id_F8811A708892F993(_id_02DD49B127A649B3, 1, 0);

        _id_02DD49B127A649B3._id_01D2F28029E15B4E = 0;
      } else {
        thread _id_F8811A708892F993(_id_02DD49B127A649B3, 0);
        _id_02DD49B127A649B3._id_01D2F28029E15B4E = 1;
      }
    }

    wait 0.05;
  }

  if(!_id_E5833A1D040F52A5) {
    thread _id_F8811A708892F993(_id_02DD49B127A649B3, 0);
    _id_02DD49B127A649B3._id_01D2F28029E15B4E = 1;
  }
}

_id_FDEFAC01300C1001(_id_02DD49B127A649B3) {
  _id_02DD49B127A649B3._id_E205224CDF17409E endon("clear_bars");
  _id_02DD49B127A649B3._id_E205224CDF17409E endon("pause_bar_progress");
  self endon("death_or_disconnect");
  _id_02DD49B127A649B3._id_E205224CDF17409E notify("new_gas_countdown_display");
  _id_02DD49B127A649B3._id_E205224CDF17409E endon("new_gas_countdown_display");

  if(isDefined(_id_02DD49B127A649B3._id_E205224CDF17409E._id_7EE72AB2C28218D7))
    _id_02DD49B127A649B3._id_E205224CDF17409E._id_7EE72AB2C28218D7 destroy();

  wait 0.05;
  _id_02DD49B127A649B3._id_E205224CDF17409E._id_7EE72AB2C28218D7 = newclienthudelem(self);
  _id_02DD49B127A649B3._id_E205224CDF17409E._id_7EE72AB2C28218D7.x = 240;
  _id_02DD49B127A649B3._id_E205224CDF17409E._id_7EE72AB2C28218D7.y = 290;
  _id_02DD49B127A649B3._id_E205224CDF17409E._id_7EE72AB2C28218D7.color = (0.9, 0.9, 0.2);
  _id_02DD49B127A649B3._id_E205224CDF17409E._id_7EE72AB2C28218D7.alpha = 1.0;
  _id_02DD49B127A649B3._id_E205224CDF17409E._id_7EE72AB2C28218D7.hidden = 0;
  _id_02DD49B127A649B3._id_E205224CDF17409E._id_7EE72AB2C28218D7._id_9E76FE13C19DA9A3 = 0;
  _id_02DD49B127A649B3._id_E205224CDF17409E._id_7EE72AB2C28218D7._id_95EF0E28E73E593C = 0;
  _id_02DD49B127A649B3._id_E205224CDF17409E._id_7EE72AB2C28218D7.fontscale = 1.0;
  _id_D2DD49D574F3D224 = _id_7EDBF100D0F22529(_id_02DD49B127A649B3);
  _id_8584638D433C38F0 = _id_FE846D6A171C6861(_id_02DD49B127A649B3);
  _id_8561598D4315DB3A = _id_FEA85F6A1744C44F(_id_02DD49B127A649B3);

  while(_id_D2DD49D574F3D224 <= _id_8561598D4315DB3A) {
    _id_D2DD49D574F3D224 = _id_7EDBF100D0F22529(_id_02DD49B127A649B3);
    _id_F114F9AD9CAF7825 = scripts\engine\math::round_float(_id_8561598D4315DB3A - 0.1 - _id_D2DD49D574F3D224, 2);

    if(_id_F114F9AD9CAF7825 >= 0)
      text = "Pull Time: " + _id_F114F9AD9CAF7825;

    wait 0.05;
  }
}

_id_F8811A708892F993(_id_02DD49B127A649B3, _id_B13A9085444751C4, _id_490109E3A0E3DA1E) {
  color = (0, 0, 0);

  if(istrue(_id_B13A9085444751C4))
    color = (0, 1, 0);
  else
    color = (1, 0, 0);

  _id_D2DD49D574F3D224 = _id_7EDBF100D0F22529(_id_02DD49B127A649B3);
  _id_3EF139924AC441A6 = scripts\cp\utility::createbar(color, level.primaryprogressbarwidth, level.primaryprogressbarheight);
  _id_3EF139924AC441A6 scripts\cp\utility::setpoint("CENTER", undefined, level.primaryprogressbarx + _id_02DD49B127A649B3._id_E205224CDF17409E.xoffset, level.primaryprogressbary + _id_02DD49B127A649B3._id_E205224CDF17409E.yoffset);
  _id_8BCCFB2C3F35E3E0 = _id_D2DD49D574F3D224 + 0.05;

  if(_id_8BCCFB2C3F35E3E0 > 1)
    _id_8BCCFB2C3F35E3E0 = 1;

  _id_3EF139924AC441A6 scripts\cp\utility::updatebar(_id_8BCCFB2C3F35E3E0);
  _id_3EF139924AC441A6.bar.sort = 5;

  if(istrue(_id_490109E3A0E3DA1E)) {
    if(isDefined(_id_02DD49B127A649B3._id_E205224CDF17409E._id_03A3B0DD3F5C5826))
      _id_02DD49B127A649B3._id_E205224CDF17409E._id_03A3B0DD3F5C5826 scripts\cp\utility::destroyelem();

    _id_02DD49B127A649B3._id_E205224CDF17409E waittill("clear_bars");

    if(isDefined(_id_3EF139924AC441A6))
      _id_3EF139924AC441A6 scripts\cp\utility::destroyelem();
  } else {
    if(!istrue(_id_B13A9085444751C4)) {
      if(isDefined(_id_02DD49B127A649B3._id_E205224CDF17409E._id_03A3B0DD3F5C5826))
        _id_02DD49B127A649B3._id_E205224CDF17409E._id_03A3B0DD3F5C5826 scripts\cp\utility::destroyelem();

      wait(_id_02DD49B127A649B3._id_E205224CDF17409E._id_1508DE2F75BBBFF9);
    } else
      wait(_id_02DD49B127A649B3._id_E205224CDF17409E._id_1508DE2F75BBBFF9 * 0.25);

    if(isDefined(_id_3EF139924AC441A6))
      _id_3EF139924AC441A6 scripts\cp\utility::destroyelem();
  }
}

_id_DB5340FDE823F8DD(player, _id_02DD49B127A649B3) {
  _id_B6409F38A17887BC = _id_86EB730E25B75A98(_id_02DD49B127A649B3);
  level thread _id_D642155DC0A1C85A(player, _id_B6409F38A17887BC, _id_02DD49B127A649B3);
}

_id_86EB730E25B75A98(_id_02DD49B127A649B3) {
  _id_B6409F38A17887BC = 20;

  if(getdvarint("dvar_BF0B93C18A87DBD0"))
    _id_B6409F38A17887BC = getdvarint("dvar_BF0B93C18A87DBD0");
  else if(isDefined(_id_02DD49B127A649B3) && isDefined(_id_02DD49B127A649B3._id_B6409F38A17887BC))
    _id_B6409F38A17887BC = _id_02DD49B127A649B3._id_B6409F38A17887BC;

  return _id_B6409F38A17887BC;
}

_id_D642155DC0A1C85A(player, duration, _id_02DD49B127A649B3) {
  if(isDefined(_id_02DD49B127A649B3.fx_model))
    _id_02DD49B127A649B3.fx_model setscriptablepartstate("vfx", "on");

  level._id_8C72BF435B00B44A = 1;
  level notify("maze_power_enabled", 1, player, _id_02DD49B127A649B3.fx_model);

  foreach(_id_90BA8F7DF548FDCB in level._id_09D983CE78A43068._id_93474A026F85FBA8)
  level thread[[_id_90BA8F7DF548FDCB]](1);

  for(_id_AC0E594AC96AA3A8 = duration; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--)
    wait 1;

  if(isDefined(_id_02DD49B127A649B3.fx_model))
    _id_02DD49B127A649B3.fx_model setscriptablepartstate("vfx", "off");

  foreach(_id_90BA8F7DF548FDCB in level._id_09D983CE78A43068._id_93474A026F85FBA8)
  level thread[[_id_90BA8F7DF548FDCB]](0);

  level._id_8C72BF435B00B44A = 0;
  level notify("maze_power_enabled", 0);
  level notify("maze_power_disabled");
}

_id_7EDBF100D0F22529(_id_02DD49B127A649B3) {
  currenttime = gettime();
  _id_D2DD49D574F3D224 = (currenttime - _id_02DD49B127A649B3._id_E205224CDF17409E._id_A90C378111E22B4F) / 1000 / _id_02DD49B127A649B3._id_E205224CDF17409E.duration;

  if(!getdvarint("dvar_A28AAC3A448CE2AF"))
    _id_D2DD49D574F3D224 = _id_D2DD49D574F3D224 - 0.05;

  if(_id_D2DD49D574F3D224 > 1)
    _id_D2DD49D574F3D224 = 1;

  if(_id_D2DD49D574F3D224 < 0)
    _id_D2DD49D574F3D224 = 0;

  return _id_D2DD49D574F3D224;
}

_id_FE846D6A171C6861(_id_02DD49B127A649B3) {
  _id_C857130CC1C67673 = level.primaryprogressbarwidth / 2 + level.primaryprogressbarx + _id_02DD49B127A649B3._id_E205224CDF17409E.xoffset + _id_02DD49B127A649B3._id_E205224CDF17409E._id_FD9E77DD224FDD4F - _id_02DD49B127A649B3._id_E205224CDF17409E._id_CE9198CD204154A0 * 0.5;
  _id_DB85E7B6B9FB517E = level.primaryprogressbarwidth;
  _id_8584638D433C38F0 = _id_C857130CC1C67673 / _id_DB85E7B6B9FB517E;

  if(_id_8584638D433C38F0 > 1)
    _id_8584638D433C38F0 = 1;

  return _id_8584638D433C38F0;
}

_id_FEA85F6A1744C44F(_id_02DD49B127A649B3) {
  _id_82FE8169BABE9146 = level.primaryprogressbarwidth / 2 + level.primaryprogressbarx + _id_02DD49B127A649B3._id_E205224CDF17409E.xoffset + _id_02DD49B127A649B3._id_E205224CDF17409E._id_FD9E77DD224FDD4F + _id_02DD49B127A649B3._id_E205224CDF17409E._id_CE9198CD204154A0 * 0.5;
  _id_DB85E7B6B9FB517E = level.primaryprogressbarwidth;
  _id_8561598D4315DB3A = _id_82FE8169BABE9146 / _id_DB85E7B6B9FB517E;

  if(_id_8561598D4315DB3A > 1)
    _id_8561598D4315DB3A = 1;

  return _id_8561598D4315DB3A;
}

_id_B03E025DFC2E0232(_id_41D8BF229CF29051) {
  if(istrue(_id_41D8BF229CF29051)) {
    _id_3B64EB40368C1450::set("gas_mechanic", "freezecontrols", 1);
    _id_3B64EB40368C1450::set("gas_mechanic", "weapon", 0);
    self disableusability();
  } else {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("gas_mechanic");
    self enableusability();
  }
}