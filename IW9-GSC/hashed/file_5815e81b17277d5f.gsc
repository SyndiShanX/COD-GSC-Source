/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5815e81b17277d5f.gsc
***********************************************/

_id_FE852F92145C24A6() {
  _id_5BC86A57086A4774::_id_AC97A4F2AB8C2D53("misc", "tryAssignTask", ::_id_1A86AFC387820604);
  _id_5BC86A57086A4774::_id_AC97A4F2AB8C2D53("misc", "checkTaskValid", ::_id_C3820063548EA9F4);
}

_id_C3820063548EA9F4(_id_BE80583079EC3E95, team) {
  if(_id_BE80583079EC3E95._id_1C9CB43BCF3EB16D == "equiped_full_armor") {
    foreach(player in level.teamdata[team]["players"]) {
      if(isDefined(player) && player _id_07C40FA80892A721::_id_AC266FC218266D08() < player._id_8790C077C95DB752)
        return 1;
    }

    return 0;
  } else if(_id_BE80583079EC3E95._id_1C9CB43BCF3EB16D == "picked_up_item_brloot_self_revive") {
    foreach(player in level.teamdata[team]["players"]) {
      if(isDefined(player) && !player _id_2CEDCC356F1B9FC8::hasselfrevivetoken())
        return 1;
    }

    return 0;
  } else if(_id_BE80583079EC3E95._id_1C9CB43BCF3EB16D == "picked_up_item_brloot_equip_gasmask") {
    foreach(player in level.teamdata[team]["players"]) {
      if(isDefined(player) && !scripts\cp_mp\gasmask::hasgasmask(player))
        return 1;
    }

    return 0;
  }

  return 0;
}

_id_1A86AFC387820604(_id_17953215DD7C5F9B) {
  flag = _id_17953215DD7C5F9B.info._id_1C9CB43BCF3EB16D + "_" + _id_17953215DD7C5F9B.team;

  if(_id_17953215DD7C5F9B.info._id_1C9CB43BCF3EB16D == "equiped_full_armor")
    thread _id_CA3B60F5F124D2AD(flag, _id_17953215DD7C5F9B);
  else if(_id_17953215DD7C5F9B.info._id_1C9CB43BCF3EB16D == "picked_up_item_brloot_self_revive")
    thread _id_473B169B28634AC0(flag, _id_17953215DD7C5F9B);
  else if(_id_17953215DD7C5F9B.info._id_1C9CB43BCF3EB16D == "picked_up_item_brloot_equip_gasmask")
    thread _id_A1E5492242DCF7E5(flag, _id_17953215DD7C5F9B);
}

_id_CA3B60F5F124D2AD(flag, _id_17953215DD7C5F9B) {
  level endon("game_ended");
  _id_17953215DD7C5F9B endon("task_end");

  for(;;) {
    level waittill(flag, player);
    _id_876D422C8206879C = 1;

    foreach(player in level.teamdata[_id_17953215DD7C5F9B.team]["players"]) {
      if(!isDefined(player) || player _id_07C40FA80892A721::_id_AC266FC218266D08() < player._id_8790C077C95DB752) {
        _id_876D422C8206879C = 0;
        break;
      }
    }

    if(_id_876D422C8206879C == 1 && isDefined(player))
      player _id_5BC86A57086A4774::_id_89B8BCE3BAA45EDC(_id_17953215DD7C5F9B, 1);
  }
}

_id_473B169B28634AC0(flag, _id_17953215DD7C5F9B) {
  level endon("game_ended");
  _id_17953215DD7C5F9B endon("task_end");

  for(;;) {
    level waittill(flag, player);
    _id_45B9B8130CDEA6A5 = 1;

    foreach(player in level.teamdata[_id_17953215DD7C5F9B.team]["players"]) {
      if(!isDefined(player) || !player _id_2CEDCC356F1B9FC8::hasselfrevivetoken()) {
        _id_45B9B8130CDEA6A5 = 0;
        break;
      }
    }

    if(_id_45B9B8130CDEA6A5 == 1 && isDefined(player))
      player _id_5BC86A57086A4774::_id_89B8BCE3BAA45EDC(_id_17953215DD7C5F9B, 1);
  }
}

_id_A1E5492242DCF7E5(flag, _id_17953215DD7C5F9B) {
  level endon("game_ended");
  _id_17953215DD7C5F9B endon("task_end");

  for(;;) {
    level waittill(flag, player);
    _id_F1700CA637A7710F = 1;

    foreach(player in level.teamdata[_id_17953215DD7C5F9B.team]["players"]) {
      if(!isDefined(player) || !scripts\cp_mp\gasmask::hasgasmask(player)) {
        _id_F1700CA637A7710F = 0;
        break;
      }
    }

    if(_id_F1700CA637A7710F == 1 && isDefined(player))
      player _id_5BC86A57086A4774::_id_89B8BCE3BAA45EDC(_id_17953215DD7C5F9B, 1);
  }
}