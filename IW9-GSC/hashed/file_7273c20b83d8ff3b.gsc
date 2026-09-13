/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7273c20b83d8ff3b.gsc
***********************************************/

_id_FE852F92145C24A6() {
  _id_5BC86A57086A4774::_id_AC97A4F2AB8C2D53("kfe", "tryAssignTask", ::_id_36F7C6B5BF8AD6F4);
  _id_5BC86A57086A4774::_id_AC97A4F2AB8C2D53("kfe", "tryBindObjective", ::_id_F06F2A906262B65C);
}

_id_36F7C6B5BF8AD6F4(_id_17953215DD7C5F9B) {
  flag = _id_87E60ED6830D13BC(_id_17953215DD7C5F9B.info._id_1C9CB43BCF3EB16D);
  thread _id_CF75AC38FDBDA3F6(_id_17953215DD7C5F9B, flag);
}

_id_87E60ED6830D13BC(_id_1C9CB43BCF3EB16D) {
  switch (_id_1C9CB43BCF3EB16D) {
    case "fieldUpgrade":
      return "fieldUpgrade_used_";
    case "equipment":
      return "equipment_used_";
    case "killstreak":
      return "killstreak_used_";
    default:
      return undefined;
  }
}

_id_CF75AC38FDBDA3F6(_id_17953215DD7C5F9B, flag) {
  level endon("game_ended");
  _id_17953215DD7C5F9B endon("task_end");

  for(;;) {
    level waittill(flag + _id_17953215DD7C5F9B.team, itemname);

    if(isDefined(itemname) && (itemname == _id_17953215DD7C5F9B.info.ref || issubstr(_id_17953215DD7C5F9B.info.ref, "any")))
      _id_5BC86A57086A4774::_id_89B8BCE3BAA45EDC(_id_17953215DD7C5F9B, 1);
  }
}

_id_59C1DBDC2AD03AD6(_id_17953215DD7C5F9B, loot) {
  partname = loot _meth_EC5F4851431F3382();
  state = loot getscriptablepartstate(partname, 1);

  if(!isDefined(state) || state == "hidden")
    return 0;

  if(isDefined(self._id_AD30CE892002A2B2) && self._id_AD30CE892002A2B2 == loot)
    return 0;

  scriptablename = _id_7E52B56769FA7774::_id_155B1A2C8879BDA5(loot);

  if(!isDefined(scriptablename))
    return 0;

  _id_A0CE8000D303764C = level.br_pickups._id_14BD11727C4B6629[scriptablename];

  if(isDefined(_id_A0CE8000D303764C) && _id_A0CE8000D303764C == _id_17953215DD7C5F9B.info.ref)
    return 1;

  if(issubstr(_id_17953215DD7C5F9B.info.ref, "any")) {
    switch (_id_17953215DD7C5F9B.info._id_1C9CB43BCF3EB16D) {
      case "fieldUpgrade":
        return _id_7E52B56769FA7774::issuperpickup(scriptablename);
      case "equipment":
        return _id_7E52B56769FA7774::_id_B989EDD9AF4F42C7(scriptablename) || _id_7E52B56769FA7774::_id_D7C5786A0C42EF6C(scriptablename);
      case "killstreak":
        return _id_7E52B56769FA7774::iskillstreak(scriptablename);
      default:
        return 0;
    }
  }

  return 0;
}

_id_F06F2A906262B65C(_id_17953215DD7C5F9B) {
  items = getlootscriptablearrayinradius(undefined, undefined, self.origin, 20000);
  _id_5BC86A57086A4774::_id_2E55101FFD0D483C(_id_17953215DD7C5F9B, items, ::_id_59C1DBDC2AD03AD6);
}