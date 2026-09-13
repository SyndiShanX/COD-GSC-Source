/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\animselector.gsc
***********************************************/

getanimselectorfilenames() {
  _id_055BE9AD4F064AA9 = [];

  if(scripts\common\utility::iscp()) {
    _id_055BE9AD4F064AA9["traverse_warp_up"] = [[0, "animselectortables/soldier/soldier_traverse_warp_up.csv"], [1, "animselectortables/civilian/civilian_traverse_warp_up.csv"], [2, "animselectortables/bomber/bomber_traverse_warp_up.csv"]];
    _id_055BE9AD4F064AA9["traverse_warp_down"] = [[0, "animselectortables/soldier/soldier_traverse_warp_down.csv"], [1, "animselectortables/civilian/civilian_traverse_warp_down.csv"], [2, "animselectortables/bomber/bomber_traverse_warp_down.csv"]];
    _id_055BE9AD4F064AA9["traverse_warp_over"] = [[0, "animselectortables/soldier/soldier_traverse_warp_over.csv"], [1, "animselectortables/civilian/civilian_traverse_warp_over.csv"], [2, "animselectortables/bomber/bomber_traverse_warp_over.csv"]];
    _id_055BE9AD4F064AA9["traverse_warp_across"] = [[0, "animselectortables/soldier/soldier_traverse_warp_across.csv"], [1, "animselectortables/civilian/civilian_traverse_warp_across.csv"], [2, "animselectortables/bomber/bomber_traverse_warp_across.csv"]];
    _id_055BE9AD4F064AA9["traverse_warp_external"] = [[0, "animselectortables/soldier/soldier_traverse_warp_external.csv"], [1, "animselectortables/civilian/civilian_traverse_warp_external.csv"], [2, "animselectortables/bomber/bomber_traverse_warp_external.csv"]];
  } else {
    _id_055BE9AD4F064AA9["traverse_warp_up"] = [[0, "animselectortables/soldier/soldier_traverse_warp_up.csv"], [1, "animselectortables/civilian/civilian_traverse_warp_up.csv"], [2, "animselectortables/bomber/bomber_traverse_warp_up.csv"]];
    _id_055BE9AD4F064AA9["traverse_warp_down"] = [[0, "animselectortables/soldier/soldier_traverse_warp_down.csv"], [1, "animselectortables/civilian/civilian_traverse_warp_down.csv"], [2, "animselectortables/bomber/bomber_traverse_warp_down.csv"]];
    _id_055BE9AD4F064AA9["traverse_warp_over"] = [[0, "animselectortables/soldier/soldier_traverse_warp_over.csv"], [1, "animselectortables/civilian/civilian_traverse_warp_over.csv"], [2, "animselectortables/bomber/bomber_traverse_warp_over.csv"]];
    _id_055BE9AD4F064AA9["traverse_warp_across"] = [[0, "animselectortables/soldier/soldier_traverse_warp_across.csv"], [1, "animselectortables/civilian/civilian_traverse_warp_across.csv"], [2, "animselectortables/bomber/bomber_traverse_warp_across.csv"]];
    _id_055BE9AD4F064AA9["traverse_warp_external"] = [[0, "animselectortables/soldier/soldier_traverse_warp_external.csv"], [1, "animselectortables/civilian/civilian_traverse_warp_external.csv"], [2, "animselectortables/bomber/bomber_traverse_warp_external.csv"]];
  }

  return _id_055BE9AD4F064AA9;
}

init() {
  if(getdvarint("r_reflectionprobegenerate") != 0 || getdvarint("g_connectpaths") != 0) {
    return;
  }
  anim.animselectorfeaturetable = [];
  anim.animselectorfeaturetable["min_height"] = ["height", 0];
  anim.animselectorfeaturetable["max_height"] = ["height", 1];
  anim.animselectorfeaturetable["min_arrival_yaw"] = ["arrival_yaw", 0];
  anim.animselectorfeaturetable["max_arrival_yaw"] = ["arrival_yaw", 1];
  anim.animselectorfeaturetable["min_length"] = ["length", 0];
  anim.animselectorfeaturetable["max_length"] = ["length", 1];
  anim.animselectorfeaturetable["min_drop_height"] = ["drop_height", 0];
  anim.animselectorfeaturetable["max_drop_height"] = ["drop_height", 1];
  anim.animselectorfeaturetable["min_speed"] = ["speed", 0];
  anim.animselectorfeaturetable["max_speed"] = ["speed", 1];
  anim.animselector = [];
  _id_055BE9AD4F064AA9 = getanimselectorfilenames();

  foreach(statename, _id_466B9E66CB072005 in _id_055BE9AD4F064AA9) {
    foreach(_id_A10838651FE8C3DF, _id_615B735DDA2A4C94 in _id_466B9E66CB072005) {
      anim.animselector[statename][_id_A10838651FE8C3DF] = spawnStruct();
      anim.animselector[statename][_id_A10838651FE8C3DF].aliases = [];
      anim.animselector[statename][_id_A10838651FE8C3DF].features = [];
      anim.animselector[statename][_id_A10838651FE8C3DF].values = [];
      _id_EF6DAE508D785188 = tablelookuprownum(_id_615B735DDA2A4C94[1], 0, "__END__");
      _id_EF6DAE508D785188 = _id_EF6DAE508D785188 - 1;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_EF6DAE508D785188; _id_AC0E594AC96AA3A8++) {
        alias = tablelookupbyrow(_id_615B735DDA2A4C94[1], _id_AC0E594AC96AA3A8 + 1, 0);
        anim.animselector[statename][_id_A10838651FE8C3DF].aliases[_id_AC0E594AC96AA3A8] = alias;
      }

      _id_AA68DD236CF6EF27 = undefined;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 50; _id_AC0E594AC96AA3A8++) {
        _id_E8614B97C15BDA69 = tablelookupbyrow(_id_615B735DDA2A4C94[1], 0, _id_AC0E594AC96AA3A8 + 1);

        if(_id_E8614B97C15BDA69 == "__END__" || _id_E8614B97C15BDA69 == "") {
          _id_AA68DD236CF6EF27 = _id_AC0E594AC96AA3A8;
          break;
        } else
          anim.animselector[statename][_id_A10838651FE8C3DF].features[_id_AC0E594AC96AA3A8] = _id_E8614B97C15BDA69;
      }

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_EF6DAE508D785188; _id_AC0E594AC96AA3A8++) {
        for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_AA68DD236CF6EF27; _id_AC0E5C4AC96AAA41++) {
          alias = anim.animselector[statename][_id_A10838651FE8C3DF].aliases[_id_AC0E594AC96AA3A8];
          _id_E8614B97C15BDA69 = anim.animselector[statename][_id_A10838651FE8C3DF].features[_id_AC0E5C4AC96AAA41];
          val = tablelookupbyrow(_id_615B735DDA2A4C94[1], _id_AC0E594AC96AA3A8 + 1, _id_AC0E5C4AC96AAA41 + 1);

          if(val == "")
            val = undefined;
          else
            val = float(val);

          anim.animselector[statename][_id_A10838651FE8C3DF].values[alias][_id_E8614B97C15BDA69] = val;
        }
      }
    }
  }
}

checkfeaturevalue(val, _id_E8614B97C15BDA69, _id_E9DB8FC3741A7E52) {
  _id_3F44C731FDDDD082 = anim.animselectorfeaturetable[_id_E8614B97C15BDA69][0];
  _id_EE3EE378F67448A7 = anim.animselectorfeaturetable[_id_E8614B97C15BDA69][1];
  _id_2A6A6A7923586558 = _id_E9DB8FC3741A7E52[_id_3F44C731FDDDD082];

  if(!isDefined(_id_2A6A6A7923586558))
    return 1;

  if(_id_EE3EE378F67448A7 == 0)
    return _id_2A6A6A7923586558 >= val;
  else if(_id_EE3EE378F67448A7 == 1)
    return _id_2A6A6A7923586558 <= val;
}

selectanim(statename, _id_E9DB8FC3741A7E52, _id_1B240BBF89180B65) {
  traverseinfo = anim.animselector[statename][_id_1B240BBF89180B65];

  foreach(alias in traverseinfo.aliases) {
    if(isai(self) && !scripts\asm\asm::asm_hasalias(statename, alias)) {
      continue;
    }
    _id_B4D9AB801DAFC0FD = 1;

    foreach(_id_E8614B97C15BDA69 in traverseinfo.features) {
      val = traverseinfo.values[alias][_id_E8614B97C15BDA69];

      if(isDefined(val)) {
        if(!checkfeaturevalue(val, _id_E8614B97C15BDA69, _id_E9DB8FC3741A7E52)) {
          _id_B4D9AB801DAFC0FD = 0;
          break;
        }
      }
    }

    if(_id_B4D9AB801DAFC0FD)
      return alias;
  }
}

gettraverserindex() {
  archetype = self getbasearchetype();

  if(isDefined(archetype)) {
    switch (archetype) {
      case "juggernaut_cp":
      case "soldier_female":
      case "hero_salter":
      case "rebel":
      case "soldier_cp":
      case "soldier_pistol":
      case "farah":
      case "juggernaut":
      case "soldier":
        return 0;
      case "civilian_female":
      case "hadir_yth":
      case "civilian":
        return 1;
      default:
        if(isDefined(self._id_AE3EA15396B65C1F) && self._id_AE3EA15396B65C1F == "suicidebomber_cp")
          return 2;

        if(isDefined(self.unittype) && self.unittype == "soldier")
          return 0;

        return -1;
    }
  }

  return -1;
}