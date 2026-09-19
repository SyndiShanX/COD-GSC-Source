/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_audio_submixes.gsc
***********************************************/

_id_524C() {
  _id_02EF::_id_524B();
  level._id_7FF7 = ::_id_06B6;
}

_id_1E76(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  foreach(var_12 in level.players) {
    if(_issplitscreen() == 1) {
      if(var_12 issplitscreenplayer() == 1 && var_12 issplitscreenplayerprimary() == 0)
        continue;
    }

    if(isDefined(var_0) == 1 && isDefined(var_12.pers["team"]) == 1 && var_12.pers["team"] != var_0) {
      continue;
    }
    var_12 _id_02EF::_id_1E74(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }
}

submixexistsquick(var_0) {
  if(!isDefined(level._id_94CA))
    level._id_94CA = [];

  if(isDefined(level._id_94CA[var_0]))
    return level._id_94CA[var_0];

  var_1 = _id_02EF::_id_94CA(var_0);
  level._id_94CA[var_0] = var_1;
  return var_1;
}

_sfx_player_submix_init() {
  var_0 = self;

  if(isDefined(var_0) == 0) {
    return;
  }
  if(isDefined(var_0._audiosubmixes) == 0)
    var_0._audiosubmixes = [];
}

_id_8A9D(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(_isremovedentity(var_4) == 1) {
    return;
  }
  var_4 _sfx_player_submix_init();

  if(submixexistsquick(var_0) == 0) {
    return;
  }
  if(isDefined(var_1) == 0)
    var_1 = 0.1;

  if(isDefined(var_2) == 0)
    var_2 = 1.0;

  if(isDefined(var_3) == 1)
    var_4 clientaddsoundsubmix(var_0, var_1, var_2, var_3);
  else
    var_4 clientaddsoundsubmix(var_0, var_1, var_2);

  var_4._audiosubmixes[var_0] = var_2;
  var_4 _id_8A9E(var_0, var_2, var_1);
}

_sfx_player_submix_blend_calc(var_0, var_1, var_2) {
  var_3 = self;
  var_3 notify("sfx_player_submix_blend_calc_stop");
  var_3 endon("sfx_player_submix_blend_calc_stop");
  var_3 endon("disconnect");

  if(var_2 > 0) {
    var_4 = var_3._audiosubmixes[var_0];
    var_5 = var_1 - var_4;
    var_6 = int(var_2 / 0.05);
    var_7 = var_5 / (var_2 / 0.05);

    while(var_6 > 0) {
      if(!isDefined(var_3._audiosubmixes[var_0])) {
        return;
      }
      var_3._audiosubmixes[var_0] = var_3._audiosubmixes[var_0] + var_7;
      var_6--;
      waitframe();
    }
  }

  var_3._audiosubmixes[var_0] = var_1;
}

_id_8A9E(var_0, var_1, var_2) {
  var_3 = self;

  if(_isremovedentity(var_3) == 1) {
    return;
  }
  var_3 _sfx_player_submix_init();

  if(submixexistsquick(var_0) == 0) {
    return;
  }
  if(isDefined(var_3._audiosubmixes[var_0]) == 0)
    var_3 _id_8A9D(var_0, 0.0, 0.0);

  if(isDefined(var_2) == 1) {
    var_3 clientblendsoundsubmix(var_0, var_1, var_2);
    var_3 thread _sfx_player_submix_blend_calc(var_0, var_1, var_2);
  } else if(isDefined(var_1) == 1) {
    var_3 clientblendsoundsubmix(var_0, var_1);
    var_3._audiosubmixes[var_0] = var_1;
  } else {
    var_3 clientblendsoundsubmix(var_0);
    var_3._audiosubmixes[var_0] = var_1;
  }
}

_id_8A9F(var_0, var_1) {
  var_2 = self;

  if(_isremovedentity(var_2) == 1) {
    return;
  }
  var_2 _sfx_player_submix_init();

  if(submixexistsquick(var_0) == 0) {
    return;
  }
  if(isDefined(var_1) == 1 && var_1 > 0.0) {
    var_2 _id_8A9E(var_0, 0.0, var_1);
    var_2 common_scripts\utility::_id_2CBE(var_1 + 0.05, ::clientclearsoundsubmix, var_0, 0.0);
  } else {
    var_2 clientclearsoundsubmix(var_0);
    var_2._audiosubmixes[var_0] = undefined;
  }
}

sfx_player_submix_exists(var_0) {
  var_1 = self;
  return isDefined(var_1._audiosubmixes) && isDefined(var_1._audiosubmixes[var_0]);
}

_id_8ABB(var_0, var_1, var_2, var_3, var_4) {
  thread _id_1E76(var_0, ::_id_8A9D, var_1, var_2, var_3, var_4);
}

_id_8ABC(var_0, var_1, var_2, var_3) {
  thread _id_1E76(var_0, ::_id_8A9E, var_1, var_2, var_3);
}

_id_8ABD(var_0, var_1, var_2) {
  thread _id_1E76(var_0, ::_id_8A9F, var_1, var_2);
}

_id_06B6(var_0, var_1, var_2, var_3) {
  var_4 = "" + var_0;
  self scriptmodelplayanim(var_4, var_2, 0.0, var_3, 0);
}

_id_7A39(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 0.5;

  if(!isDefined(var_2))
    var_2 = "shared_default";

  if(!isDefined(level._id_05AB)) {
    level._id_05AB = spawnStruct();
    level._id_05AB.label = 0;
  }

  var_3 = clamp(var_3, 0, 1);
  var_3 = common_scripts\utility::_id_7F03(var_3, 1);
  var_3 = var_3 * 5;
  var_4 = 0;

  for(var_5 = 0; var_5 < var_3; var_5++)
    var_4 = var_4 + _randomfloatrange(var_0, var_1);

  var_6 = var_4 / var_3;

  if(var_6 > var_1 * 0.5)
    var_6 = var_6 - var_1;

  var_6 = var_6 + var_1 * 0.5;
  var_7 = level._id_05AB.label;
  var_8 = var_1 - var_0;
  var_9 = var_8 * 0.5;

  if(_abs(var_7 - var_6) < var_8 * 0.2) {
    var_6 = _id_02EF::startignoringspotlight(var_6, var_0, var_1, var_1 - _randomfloatrange(0, var_8 * 0.35), var_0 + _randomfloatrange(0, var_8 * 0.35));
    var_6 = clamp(var_6, var_0, var_1);
  }

  level._id_05AB.label = var_6;
  return var_6;
}

_id_06C6(var_0, var_1, var_2) {
  if(isDefined(self) == 0) {
    return;
  }
  if(_isremovedentity(self) == 1) {
    return;
  }
  self endon("death");

  if(isDefined(self._id_8F45) == 1) {
    self._id_8F45 endon("death");
    _id_02F0::disableammogeneration(self, self._id_8F45);
  }

  if(isDefined(var_0) == 0) {
    return;
  }
  var_3 = self;

  if(isDefined(var_2))
    var_2 waittill(var_0);
  else
    level waittill(var_0);

  _id_02F0::enableammogeneration(var_3, var_1);
}

setturretdismountorg(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = self;
  var_9 = _id_02F0::_id_800B(var_0, var_8, var_6, var_5, var_2, var_7);

  if(isDefined(var_9) == 1) {
    if(isDefined(var_4) == 1)
      _id_02F0::disableplayeruse(var_9, var_4, 0.0);

    var_9 thread _id_06C6(var_1, var_3, var_8);
  }

  return var_9;
}

_id_7FFA(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = _id_02F0::_id_800A(var_0, var_1, var_3, var_6);

  if(isDefined(var_7) == 1) {
    if(isDefined(var_5) == 1)
      _id_02F0::disableplayeruse(var_7, var_5, 0.0);

    var_7 thread _id_06C6(var_2, var_4);
  }

  return var_7;
}

_id_7FF9(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_02F0::_id_800A(var_0, undefined, var_2, var_5);

  if(isDefined(var_6) == 1) {
    if(isDefined(var_4) == 1)
      _id_02F0::disableplayeruse(var_6, var_4, 0.0);

    var_6 thread _id_06C6(var_1, var_3);
  }

  return var_6;
}

playershow(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = self;
  var_9 = _id_02F0::_id_800B(var_0, var_8, var_6, var_5, var_2, var_7);

  if(isDefined(var_9) == 1) {
    if(isDefined(var_4) == 1)
      _id_02F0::disableplayeruse(var_9, var_4, 0.0);

    var_9 thread _id_06C6(var_1, var_3, var_8);
  }

  return var_9;
}

_id_8002(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_02F0::_id_800A(var_0, undefined, var_2, var_5);

  if(isDefined(var_6) == 1) {
    if(isDefined(var_4) == 1)
      _id_02F0::disableplayeruse(var_6, var_4, 0.0);

    var_6 thread _id_06C6(var_1, var_3);
  }

  return var_6;
}

_id_6262(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_4) == 1 && var_4 > 0.0)
    wait(var_4);

  _id_02EF::_id_8AB8(var_0, var_1, var_2, var_3, var_5);
}