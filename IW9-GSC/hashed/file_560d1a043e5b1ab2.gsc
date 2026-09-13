/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_560d1a043e5b1ab2.gsc
***********************************************/

_id_654D758C46E09DEE() {
  _id_2D9CC5FE77A75B8F::init();
  _id_2984155BACFD2B5B::_id_5FA1FE4DAE3FB84F();
  thread _id_9561DEDB5F8BBF6C();
}

_id_9561DEDB5F8BBF6C() {
  _id_FC18BC344E4250C5();
  _id_74C7047AA10E4C68();
}

_id_FC18BC344E4250C5() {
  level waittill("prematch_done");

  while(!isDefined(level.players))
    waitframe();
}

_id_74C7047AA10E4C68() {
  for(_id_EF50426720E1DBB8 = 0; _id_EF50426720E1DBB8 < level.players.size; _id_EF50426720E1DBB8++) {
    _id_4245ED6808EE4864 = level.players[_id_EF50426720E1DBB8];

    if(!isbot(_id_4245ED6808EE4864))
      _id_4245ED6808EE4864 _id_608A8D2B19A459F6();
  }
}

_id_608A8D2B19A459F6() {
  thread _id_D78B49F91129F242();
  thread _id_6DD7DAAACEB1EC5F();
  thread _id_56134FA5F2032E03();
  self _meth_918DFA7ADDEEF133();
}

_id_140DE1AB2CB1F718(_id_12461E617D024EF9, _id_0528CEAA1AE46251) {
  if(isDefined(_id_12461E617D024EF9._id_F1DCE14969593FAB)) {
    if(isarray(_id_12461E617D024EF9._id_F1DCE14969593FAB)) {
      for(_id_C4CF8C690C7FA81B = 0; _id_C4CF8C690C7FA81B < _id_12461E617D024EF9._id_F1DCE14969593FAB.size; _id_C4CF8C690C7FA81B++)
        self thread[[_id_0528CEAA1AE46251]](_id_12461E617D024EF9._id_29B3D4262D4B443C, _id_12461E617D024EF9._id_F1DCE14969593FAB[_id_C4CF8C690C7FA81B]);
    } else {
      _id_1CE10E7C1B770BA8 = getscriptbundle(_id_12461E617D024EF9._id_F1DCE14969593FAB);

      for(_id_C4CF8C690C7FA81B = 0; _id_C4CF8C690C7FA81B < _id_1CE10E7C1B770BA8.actions.size; _id_C4CF8C690C7FA81B++) {
        _id_03025C221CEBB150 = _id_1CE10E7C1B770BA8.actions[_id_C4CF8C690C7FA81B];
        _id_CE562B477898E690 = _id_03025C221CEBB150._id_CF0D4D8CC5AC99A4._id_D31D0B46475FD003;
        _id_C84F6CC0F6CF8E37 = _id_03025C221CEBB150._id_CF0D4D8CC5AC99A4.config;
        self thread[[_id_0528CEAA1AE46251]](_id_12461E617D024EF9._id_29B3D4262D4B443C, _id_CE562B477898E690, _id_C84F6CC0F6CF8E37);
      }
    }
  }
}

_id_D78B49F91129F242() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("entitydeleted");

  for(;;) {
    self waittill("quest_activate_quests", quests);

    for(_id_5E9B1036A4CAE82F = 0; _id_5E9B1036A4CAE82F < quests.size; _id_5E9B1036A4CAE82F++)
      _id_140DE1AB2CB1F718(quests[_id_5E9B1036A4CAE82F], ::_id_1244903F7A129388);
  }
}

_id_1244903F7A129388(_id_29B3D4262D4B443C, _id_CE562B477898E690, _id_C84F6CC0F6CF8E37) {
  _id_2984155BACFD2B5B::_id_89AEDD24EB702B29(_id_CE562B477898E690, _id_C84F6CC0F6CF8E37);
  wait 10;
  self _meth_ C437AAF40FC4699(_id_29B3D4262D4B443C, _id_CE562B477898E690, 1);
}

_id_6DD7DAAACEB1EC5F() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("entitydeleted");

  for(;;) {
    self waittill("quest_launch_trigger_script", _id_12461E617D024EF9);
    _id_140DE1AB2CB1F718(_id_12461E617D024EF9, ::_id_82B5439A3196C591);
  }
}

_id_82B5439A3196C591(_id_29B3D4262D4B443C, _id_CE562B477898E690, _id_C84F6CC0F6CF8E37) {
  wait 10;
  self _meth_5B2DCDED26F0CA2C(_id_29B3D4262D4B443C, _id_CE562B477898E690, 1);
}

_id_56134FA5F2032E03() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("entitydeleted");

  for(;;) {
    self waittill("quest_launch_action_script", _id_12461E617D024EF9);
    _id_140DE1AB2CB1F718(_id_12461E617D024EF9, ::_id_0F1708D128DBD5EB);
  }
}

_id_0F1708D128DBD5EB(_id_29B3D4262D4B443C, _id_CE562B477898E690, _id_C84F6CC0F6CF8E37) {
  wait 10;
  self _meth_ 9E4576 D51C9CD20(_id_29B3D4262D4B443C, _id_CE562B477898E690, 1);
}