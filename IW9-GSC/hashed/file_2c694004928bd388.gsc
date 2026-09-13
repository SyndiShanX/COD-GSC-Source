/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2c694004928bd388.gsc
***********************************************/

init() {
  level._id_37AA0062320EBD1A.traversals = _id_C85C46CE3B5439CE(getallnodes());
  level._id_37AA0062320EBD1A._id_C5E2C99115B2C8DF = [];
}

_id_C85C46CE3B5439CE(_id_5836C6D53A5F99A2) {
  _id_BBEE5A437D741FB6 = [];
  endnode = [];

  foreach(node in _id_5836C6D53A5F99A2) {
    if(!isDefined(node.type)) {
      continue;
    }
    _id_03007C5B5FC67992 = _id_DF46390FFCC4D8F8(node);

    if(!isDefined(_id_03007C5B5FC67992)) {
      continue;
    }
    if(node.type == "Begin") {
      if(isDefined(_id_BBEE5A437D741FB6[_id_03007C5B5FC67992])) {
        _id_183BC29D2DAB9FDF("duplicated name: " + _id_03007C5B5FC67992 + ", node1:" + node.origin + ", node2:" + _id_BBEE5A437D741FB6[_id_03007C5B5FC67992].origin);
        continue;
      }

      _id_BBEE5A437D741FB6[_id_03007C5B5FC67992] = node;
      continue;
    }

    if(node.type == "End") {
      if(isDefined(endnode[_id_03007C5B5FC67992])) {
        _id_183BC29D2DAB9FDF("duplicated name: " + _id_03007C5B5FC67992 + ", node1:" + node.origin + ", node2:" + endnode[_id_03007C5B5FC67992].origin);
        continue;
      }

      endnode[_id_03007C5B5FC67992] = node;
    }
  }

  _id_66B7A5F6F62447B6 = getarraykeys(_id_BBEE5A437D741FB6);
  result = [];

  foreach(name in _id_66B7A5F6F62447B6) {
    if(isDefined(endnode[name])) {
      _id_A61C75B156FC1EE0 = result.size;
      result[_id_A61C75B156FC1EE0] = [];
      result[_id_A61C75B156FC1EE0][0] = _id_BBEE5A437D741FB6[name];
      result[_id_A61C75B156FC1EE0][1] = endnode[name];
      _id_BBEE5A437D741FB6[name] = undefined;
      endnode[name] = undefined;
    }
  }

  if(_id_BBEE5A437D741FB6.size > 0) {
    foreach(key, value in _id_BBEE5A437D741FB6)
    _id_183BC29D2DAB9FDF("unpaired begin node: " + key + ", " + value.origin);
  }

  if(endnode.size > 0) {
    foreach(key, value in endnode)
    _id_183BC29D2DAB9FDF("unpaired end node: " + key + ", " + value.origin);
  }

  return result;
}

_id_183BC29D2DAB9FDF(_id_0889F3D7E1C1EA6B, bot, position, _id_FDE6CF296EB26748, _id_EA742470751D2E85) {
  _id_11217A46EE62DF5C = "";

  if(isDefined(bot))
    _id_11217A46EE62DF5C = bot getentitynumber();

  _id_DABF4CF09B2C06CA = "";

  if(isDefined(position))
    _id_DABF4CF09B2C06CA = position;

  _id_6BEC857A97EAADE6 = "";
  _id_99B287B76F4B63A5 = "";
  _id_F37EF469027DCFA1 = "";

  if(isDefined(_id_FDE6CF296EB26748)) {
    _id_6BEC857A97EAADE6 = _id_DF46390FFCC4D8F8(_id_FDE6CF296EB26748[0]);
    _id_99B287B76F4B63A5 = _id_FDE6CF296EB26748[0].origin;
    _id_F37EF469027DCFA1 = _id_FDE6CF296EB26748[1].origin;
  }

  _id_CD3F2A2AD8CB3364 = "";

  if(isDefined(_id_EA742470751D2E85))
    _id_CD3F2A2AD8CB3364 = _id_EA742470751D2E85;

  _id_444A5451F436094A = "situation: " + _id_0889F3D7E1C1EA6B + "; " + "bot: " + _id_11217A46EE62DF5C + "; " + "lastPosition: " + _id_DABF4CF09B2C06CA + "; " + "traversal name: " + _id_6BEC857A97EAADE6 + "; " + "trversal begin: " + _id_99B287B76F4B63A5 + "; " + "traversl end: " + _id_F37EF469027DCFA1 + "; " + "isPassed: " + _id_CD3F2A2AD8CB3364 + "; ";
  _id_0A661C5FAD6BEDD8::_id_9A0A24DE119B078A("Traversal", _id_444A5451F436094A);
}

_id_A38DF45AB16839F3(_id_0889F3D7E1C1EA6B, bot) {
  if(!_id_B9B4E6815C62B52F(bot._id_37AA0062320EBD1A._id_A0F72E651FD6A385, _id_0889F3D7E1C1EA6B))
    _id_183BC29D2DAB9FDF(_id_0889F3D7E1C1EA6B, bot, bot.origin, bot._id_37AA0062320EBD1A._id_A0F72E651FD6A385);
}

_id_DF46390FFCC4D8F8(node) {
  if(isDefined(node.target))
    return node.target;

  if(isDefined(node.targetname))
    return node.targetname;

  return undefined;
}

_id_FFD4129F1032E796() {
  self botsetdifficultysetting("slideChance", 0);
  self._id_37AA0062320EBD1A._id_A0F72E651FD6A385 = _id_B5224992BFB5B100();

  if(!isDefined(self._id_37AA0062320EBD1A._id_A0F72E651FD6A385)) {
    return;
  }
  self._id_37AA0062320EBD1A.onplayerkilled = ::onplayerkilled;
  _id_0D22FDCA158E266E = 25;
  _id_07D2294C58A5C346 = 50;
  _id_FC77E2B383D17EC9 = _id_0A661C5FAD6BEDD8::_id_721588AE374756B5(self._id_37AA0062320EBD1A._id_A0F72E651FD6A385[0].origin, _id_0D22FDCA158E266E, _id_07D2294C58A5C346);

  if(isDefined(_id_FC77E2B383D17EC9)) {
    _id_A38DF45AB16839F3("teleport failed/" + _id_FC77E2B383D17EC9, self);
    return;
  }

  _id_1A0A33A029775B11 = _id_84686FD03BA0AA2B(self._id_37AA0062320EBD1A._id_A0F72E651FD6A385);
  _id_F3F364499C3A6ECC(self, self._id_37AA0062320EBD1A._id_A0F72E651FD6A385, _id_1A0A33A029775B11);
}

_id_B5224992BFB5B100() {
  for(index = 0; index < level._id_37AA0062320EBD1A.traversals.size; index++) {
    current = level._id_37AA0062320EBD1A.traversals[index];

    if(_id_25EB6FEE59A46E3A(current)) {
      level._id_37AA0062320EBD1A.traversals = scripts\engine\utility::array_remove_index(level._id_37AA0062320EBD1A.traversals, index);
      return current;
    }
  }

  return undefined;
}

_id_25EB6FEE59A46E3A(_id_A0F72E651FD6A385) {
  _id_92C13C6437A38A60 = 64;

  foreach(player in level.players) {
    if(!isbot(player) || !_id_59FF79D681BB860C::_id_DED80385EA7471DB(player)) {
      continue;
    }
    if(isDefined(player._id_37AA0062320EBD1A) && isDefined(player._id_37AA0062320EBD1A._id_A0F72E651FD6A385)) {
      _id_7F56B9D87F5452AF = distance(_id_A0F72E651FD6A385[0].origin, player._id_37AA0062320EBD1A._id_A0F72E651FD6A385[1].origin) < _id_92C13C6437A38A60 || distance(_id_A0F72E651FD6A385[1].origin, player._id_37AA0062320EBD1A._id_A0F72E651FD6A385[0].origin) < _id_92C13C6437A38A60;

      if(_id_7F56B9D87F5452AF)
        return 0;
    }
  }

  return 1;
}

_id_F3F364499C3A6ECC(bot, _id_A0F72E651FD6A385, _id_1A0A33A029775B11) {
  _id_CBEF341A3AEEF001 = 40;
  _id_F37EF469027DCFA1 = scripts\engine\utility::ter_op(isDefined(_id_1A0A33A029775B11), _id_1A0A33A029775B11, bot._id_37AA0062320EBD1A._id_A0F72E651FD6A385[1].origin);
  _id_4112BB19CC3C6A26 = 60;
  _id_B297F3AF414EA41B = gettime();
  dist = distance(bot._id_37AA0062320EBD1A._id_A0F72E651FD6A385[0].origin, _id_F37EF469027DCFA1);
  _id_068291B1086BFF85 = (dist / _id_4112BB19CC3C6A26 + 1) * 1000;
  bot _id_59FF79D681BB860C::_id_9E400058EF021B03(_id_F37EF469027DCFA1, _id_CBEF341A3AEEF001);
  _id_172FFC4A18F645A9 = 15000;

  for(;;) {
    result = _id_0A661C5FAD6BEDD8::_id_B564050A363F08EC(bot, 0.25);

    if(result == "goal") {
      _id_23B90B34FECC58CD = gettime() - _id_B297F3AF414EA41B;
      _id_EC553BE653A5BBAA = _id_23B90B34FECC58CD / 1000 + "/" + _id_068291B1086BFF85 / 1000;

      if(_id_23B90B34FECC58CD > _id_068291B1086BFF85)
        _id_A38DF45AB16839F3("timeout " + _id_EC553BE653A5BBAA, bot);
      else
        _id_C6794B6366F34CE2(bot._id_37AA0062320EBD1A._id_A0F72E651FD6A385, "goal " + _id_EC553BE653A5BBAA);

      break;
    } else {
      _id_23B90B34FECC58CD = gettime() - _id_B297F3AF414EA41B;

      if(_id_23B90B34FECC58CD > _id_172FFC4A18F645A9) {
        _id_A38DF45AB16839F3(result, bot);
        break;
      }
    }
  }
}

onplayerkilled(_id_642470E1ABC1BBF9) {
  if(isDefined(self._id_37AA0062320EBD1A) && isDefined(self._id_37AA0062320EBD1A._id_A0F72E651FD6A385)) {
    _id_A38DF45AB16839F3("death", self);
    self._id_37AA0062320EBD1A._id_A0F72E651FD6A385 = undefined;
  }
}

_id_60524DE5341E2666() {
  if(isDefined(self)) {
    self botsetflag("disable_movement", 0);
    self._id_37AA0062320EBD1A._id_A0F72E651FD6A385 = undefined;
  }
}

_id_3113F44EBAFE71B1() {
  return level._id_37AA0062320EBD1A.traversals.size > 0 || isDefined(self._id_37AA0062320EBD1A._id_A0F72E651FD6A385);
}

_id_84686FD03BA0AA2B(_id_A0F72E651FD6A385) {
  _id_D0EB1456103AB1E3 = distance2d(_id_A0F72E651FD6A385[0].origin, _id_A0F72E651FD6A385[1].origin);
  _id_5357ACDB76B0BD75 = _id_A0F72E651FD6A385[0].origin[2] - _id_A0F72E651FD6A385[1].origin[2];
  _id_490C45926CE2C1A7 = abs(_id_5357ACDB76B0BD75);
  _id_4EE4120D40F7E78D = _id_A0F72E651FD6A385[0].animscript;
  _id_053D58498A1F5F08 = _func_767CEA82B001F645(anglesToForward(_id_A0F72E651FD6A385[1].angles));
  _id_981AADBE91DD9543 = _id_4EE4120D40F7E78D == "traverse_warp_over" && _id_490C45926CE2C1A7 < 40 && _id_D0EB1456103AB1E3 < 120;
  _id_63CB3D9A58303C89 = _id_5357ACDB76B0BD75 > 40 && _id_4EE4120D40F7E78D != "ascender_down";

  if(_id_981AADBE91DD9543 || _id_63CB3D9A58303C89) {
    _id_F37EF469027DCFA1 = getclosestpointonnavmesh(_id_A0F72E651FD6A385[1].origin + _id_053D58498A1F5F08 * 60);
    return _id_F37EF469027DCFA1;
  }

  return undefined;
}

_id_B9B4E6815C62B52F(_id_A0F72E651FD6A385, str) {
  _id_C6794B6366F34CE2(_id_A0F72E651FD6A385, str);
  _id_95B4C05A30E3944A = level._id_37AA0062320EBD1A._id_C5E2C99115B2C8DF[_id_DF46390FFCC4D8F8(_id_A0F72E651FD6A385[0])].size;

  if(_id_95B4C05A30E3944A < 3) {
    level._id_37AA0062320EBD1A.traversals = scripts\engine\utility::array_add(level._id_37AA0062320EBD1A.traversals, _id_A0F72E651FD6A385);
    return 1;
  }

  return 0;
}

_id_C6794B6366F34CE2(_id_A0F72E651FD6A385, str) {
  name = _id_DF46390FFCC4D8F8(_id_A0F72E651FD6A385[0]);

  if(!isDefined(level._id_37AA0062320EBD1A._id_C5E2C99115B2C8DF[name]))
    level._id_37AA0062320EBD1A._id_C5E2C99115B2C8DF[name] = [];

  _id_46F432042B3473D8 = level._id_37AA0062320EBD1A._id_C5E2C99115B2C8DF[name].size;
  level._id_37AA0062320EBD1A._id_C5E2C99115B2C8DF[name][_id_46F432042B3473D8] = str;
}