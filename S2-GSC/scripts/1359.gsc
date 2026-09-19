/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1359.gsc
**************************************/

init() {
  level._id_24DC = [];
  var_12 = getEntArray("lore_primary", "script_noteworthy");

  foreach(var_14 in var_12) {
    var_15 = spawnStruct();
    var_15._id_378F = var_14;
    var_15._id_24D1 = var_14.setlookatent;
    var_15._id_9D64 = "use";
    _id_7BA2(var_15);
  }
}

_id_7BA2(var_0) {
  if(getdvarint("scr_zombieAllowNestCollectibles", 0) == 1) {
    var_0._id_24D2 = _id_0550::_id_24D3(var_0._id_24D1);
    var_1 = [];

    if(!isDefined(var_0._id_9D64))
      var_0._id_9D64 = "use";

    if(var_0._id_9D64 == "use") {
      var_1 = getEntArray(var_0._id_378F.target, "targetname");
      var_1[0]._id_378F = var_0._id_378F;
      var_1[0]._id_5F13 = var_0;
      thread maps\mp\_utility::_id_6F74(::_id_5F11, var_1[0]);
    }

    foreach(var_3 in var_1) {
      var_3 usetriggerrequirelookat(1);
      var_0 thread _id_5F10(var_3);
    }

    level._id_24DC[var_0._id_24D1] = var_0;
  } else {
    var_1 = getEntArray(var_0._id_378F.target, "targetname");
    var_1[0] makeunusable();
    var_0._id_378F hide();
  }
}

_id_86B3(var_0, var_1, var_2) {
  var_0 call[[common_scripts\utility::_id_98E7(var_2, ::showtoplayer, ::_meth_8006)]](var_1);
}

_id_86B2(var_0, var_1, var_2) {
  var_0 call[[common_scripts\utility::_id_98E7(var_2, ::enableplayeruse, ::disableplayeruse)]](var_1);
}

_id_5F0F(var_0) {
  var_1 = self;
}

_id_5F0E(var_0) {
  var_1 = self;
  var_0 _id_5F11(var_1);
}

_id_5F11(var_0) {
  var_1 = var_0._id_5F13;
  var_2 = var_1._id_24D2;
  var_3 = var_0._id_378F;
  var_4 = _id_0550::_id_415C(self, var_2);
  _id_86B3(var_3, self, !var_4);
  _id_86B2(var_0, self, !var_4);
}

_id_5F12(var_0) {
  var_1 = self;
  var_2 = var_1._id_24D2;

  if(isDefined(level.players)) {
    foreach(var_4 in level.players)
    var_4 _id_5F11(var_0);
  }

  for(;;) {
    level waittill("connected", var_4);
    var_4 _id_5F11(var_0);
  }
}

_id_5F10(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    self._id_378F _meth_8006(var_1);
    var_0 disableplayeruse(var_1);

    if(isDefined(self._id_6FC0))
      self thread[[self._id_6FC0]](var_1);

    if(_id_0550::_id_415C(var_1, self._id_24D2)) {
      continue;
    }
    _id_0550::visionsetpostapplyforplayer(var_1, self._id_24D2, 1);
    var_1 _id_0378::_id_8D74("found_collectible");
  }
}