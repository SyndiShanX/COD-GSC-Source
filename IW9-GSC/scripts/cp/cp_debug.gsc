/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_debug.gsc
***********************************************/

_id_27BBF9605C8354E8() {
  level thread scripts\cp\utility::_id_DE4D04211EF12E03("dvar_C021E81D04F69F38", ::_id_38888ABB0075B57B);
}

_id_EEF8FED381E4DEEC(dvar, _id_6E9C9009B1774F6E) {
  level notify("watchFor_" + _func_A1A5654DB94DBB07(dvar));
  level endon("watchFor_" + _func_A1A5654DB94DBB07(dvar));
  setdvarifuninitialized(dvar, "");

  for(;;) {
    _id_4F9DF27618277B1E = getDvar(dvar, "");

    if(_id_4F9DF27618277B1E != "") {
      level thread[[_id_6E9C9009B1774F6E]]();
      setDvar(dvar, "");
    }

    wait 0.1;
  }
}

_id_38888ABB0075B57B(_id_CB325DDB4A764623) {
  items = strtok(_id_CB325DDB4A764623, "_");
  _id_ED553C0E628507CB = strtok(_id_CB325DDB4A764623, "-");
  player = undefined;

  if(_id_ED553C0E628507CB.size > 1) {
    _id_992D4A4D67CE8BA5 = int(_id_ED553C0E628507CB[1]);
    player = level.players[_id_992D4A4D67CE8BA5];
  }
}

_id_C8CE49ADBBDFE59B() {
  teams = ["axis", "allies", "team3", "neutral", "dying", "lightweight", "total"];
  y = 70;

  foreach(team in teams) {
    count = 0;
    color = (0, 0, 0);

    if(team == "lightweight") {
      count = getaicount("all", "all", "lightweight");
      color = _id_A08C7D9BF42CA575(count, 10, 15);
    } else {
      ai_array = getaiarray();

      if(getdvarint("dvar_8BECA11D7B55550E")) {
        _id_27C1A387E7B386F0["allies"] = (0, 1, 0);
        _id_27C1A387E7B386F0["axis"] = (1, 0, 0);
        _id_27C1A387E7B386F0["default"] = (0, 1, 1);

        foreach(guy in ai_array)
        _id_45F3B3C1F250CD23 = scripts\engine\utility::_id_53C4C53197386572(_id_27C1A387E7B386F0[guy.team], _id_27C1A387E7B386F0["default"]);
      }

      if(team == "total") {
        count = ai_array.size;
        color = _id_A08C7D9BF42CA575(count, 10, 25);
      } else if(team == "dying") {
        alive = scripts\engine\utility::array_removedead_or_dying(ai_array);
        count = ai_array.size - alive.size;
        color = _id_A08C7D9BF42CA575(count, 5, 10);
      }
    }

    y = y + 15;
  }
}

_id_A08C7D9BF42CA575(count, _id_8D0FC73F82C3715C, _id_0D211EEA36B16B15) {
  if(count <= _id_8D0FC73F82C3715C)
    color = (0, 1, 0);
  else if(count <= _id_0D211EEA36B16B15)
    color = (1, 1, 0);
  else
    color = (1, 0, 0);

  return color;
}

_id_00695EDAC42CD3E5() {
  _id_D23FA40B14295F49 = [];

  foreach(player in level.players) {
    if(player == self) {
      continue;
    }
    if(isDefined(player.reviveent))
      _id_D23FA40B14295F49[_id_D23FA40B14295F49.size] = player.reviveent;

    if(isDefined(player.dogtag))
      _id_D23FA40B14295F49[_id_D23FA40B14295F49.size] = player.dogtag;
  }

  _id_24F7CC3775D28DF6 = getdvarint("dvar_A23E8F787D85F762");

  if(_id_24F7CC3775D28DF6 <= 0) {
    announcement("Enabling: Toggle Last Stand Tap Use");
    setdvarifuninitialized("dvar_A23E8F787D85F762", 1);
    wait 1;
  }

  if(_id_D23FA40B14295F49.size > 0)
    thread _id_6EAFD30D4E01BD76(1, _id_D23FA40B14295F49, 1);
}

_id_6EAFD30D4E01BD76(_id_21E04F94760CC4A5, _id_64BB45003E008DC3, _id_AF6C2D5E0B9350BB) {
  _id_E7D5B384ED1C7921 = undefined;
  dist = 80;

  if(istrue(_id_AF6C2D5E0B9350BB))
    dist = 1000;

  if(isDefined(_id_64BB45003E008DC3)) {
    _id_E7D5B384ED1C7921 = [];

    foreach(ent in _id_64BB45003E008DC3) {
      if(distance(ent.origin, self.origin) < dist)
        _id_E7D5B384ED1C7921[_id_E7D5B384ED1C7921.size] = ent;
    }
  } else {
    _id_E7D5B384ED1C7921 = getentarrayinradius(undefined, undefined, self.origin, 80);
    _id_98968CE377323415 = getscriptablearrayinradius(undefined, undefined, self.origin, 80);

    foreach(_id_5D33C2E80B851274 in _id_98968CE377323415) {
      success = _id_DDEA666BCE2423AC(_id_5D33C2E80B851274);

      if(success)
        _id_E7D5B384ED1C7921[_id_E7D5B384ED1C7921.size] = _id_5D33C2E80B851274;
    }
  }

  _id_E7D5B384ED1C7921 = scripts\engine\utility::array_remove(_id_E7D5B384ED1C7921, self);

  if(_id_E7D5B384ED1C7921.size == 0) {
    announcement("No nearby ents to use for Player" + (self getentitynumber() + 1));
    return;
  }

  if(istrue(_id_AF6C2D5E0B9350BB)) {
    _id_0DA9D76F5A9B4145 = scripts\engine\utility::getclosest(self.origin, _id_E7D5B384ED1C7921);
    _id_E7D5B384ED1C7921 = [_id_0DA9D76F5A9B4145];
    self setplayerangles(vectortoangles(_id_0DA9D76F5A9B4145.origin - self.origin));
    name = "";

    if(isDefined(_id_0DA9D76F5A9B4145.targetname))
      name = ":" + _id_0DA9D76F5A9B4145.targetname;

    announcement("P" + (self getentitynumber() + 1) + " used e" + _id_0DA9D76F5A9B4145 getentitynumber() + "" + name);
  } else
    announcement("Num ents for P" + (self getentitynumber() + 1) + ":" + _id_E7D5B384ED1C7921.size);

  duration = 0.05;

  if(isDefined(_id_21E04F94760CC4A5))
    duration = _id_21E04F94760CC4A5;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < duration; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 0.05) {
    foreach(_id_569C18B61E6E8B28 in _id_E7D5B384ED1C7921) {
      if(_id_569C18B61E6E8B28 == self) {
        continue;
      }
      if(!isent(_id_569C18B61E6E8B28)) {
        continue;
      }
      _id_569C18B61E6E8B28 useby(self);
      _id_569C18B61E6E8B28 notify("trigger", self);
    }

    wait 0.05;
  }
}

_id_DDEA666BCE2423AC(_id_5D33C2E80B851274) {
  if(_id_5D33C2E80B851274 getscriptableisusableonanypart()) {
    foreach(_id_1080D6BB12D6A0D6, _id_F74189B8ADFF2E79 in level.scriptable_used_by_part_funcs) {
      if(_id_5D33C2E80B851274 getscriptablehaspart(_id_1080D6BB12D6A0D6)) {
        foreach(_id_18D79FB049CED099 in _id_F74189B8ADFF2E79) {
          _id_C4A7436E4FBE926A = _id_5D33C2E80B851274 getlinkedscriptableinstance();
          thread[[_id_18D79FB049CED099]](_id_C4A7436E4FBE926A, _id_1080D6BB12D6A0D6, "usable", self, 1, undefined);
        }

        if(_id_F74189B8ADFF2E79.size > 0)
          return 1;
      }
    }
  }

  return 0;
}