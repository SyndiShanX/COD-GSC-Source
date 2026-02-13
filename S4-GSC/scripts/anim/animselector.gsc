/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\anim\animselector.gsc
*************************************************/

_id_68C8() {
  var_0 = [];

  if(scripts\common\utility::iscp()) {
    var_0["traverse_warp_up"] = [[0, "animselectortables/soldier_traverse_warp_up.csv"], [1, "animselectortables/civilian_traverse_warp_up.csv"], [2, "animselectortables/bomber_traverse_warp_up.csv"]];
    var_0["traverse_warp_down"] = [[0, "animselectortables/soldier_traverse_warp_down.csv"], [1, "animselectortables/civilian_traverse_warp_down.csv"], [2, "animselectortables/bomber_traverse_warp_down.csv"]];
    var_0["traverse_warp_over"] = [[0, "animselectortables/soldier_traverse_warp_over_cp.csv"], [1, "animselectortables/civilian_traverse_warp_over.csv"], [2, "animselectortables/bomber_traverse_warp_over.csv"]];
    var_0["traverse_warp_across"] = [[0, "animselectortables/soldier_traverse_warp_across_cp.csv"], [1, "animselectortables/civilian_traverse_warp_across.csv"], [2, "animselectortables/bomber_traverse_warp_across.csv"]];
    var_0["traverse_warp_jump_across"] = [[0, "animselectortables/soldier_traverse_warp_jump_across_cp.csv"], [1, "animselectortables/civilian_traverse_warp_jump_across.csv"], [2, "animselectortables/bomber_traverse_warp_jump_across.csv"]];
    var_0["traverse_warp_external"] = [[0, "animselectortables/soldier_traverse_warp_external.csv"], [1, "animselectortables/civilian_traverse_warp_external.csv"], [2, "animselectortables/bomber_traverse_warp_external.csv"]];
  } else {
    var_0["traverse_warp_up"] = [[0, "animselectortables/soldier_traverse_warp_up.csv"], [1, "animselectortables/civilian_traverse_warp_up.csv"], [2, "animselectortables/dog_traverse_warp_up.csv"]];
    var_0["traverse_warp_down"] = [[0, "animselectortables/soldier_traverse_warp_down.csv"], [1, "animselectortables/civilian_traverse_warp_down.csv"], [2, "animselectortables/dog_traverse_warp_down.csv"]];
    var_0["traverse_warp_over"] = [[0, "animselectortables/soldier_traverse_warp_over.csv"], [1, "animselectortables/civilian_traverse_warp_over.csv"], [2, "animselectortables/dog_traverse_warp_over.csv"]];
    var_0["traverse_warp_across"] = [[0, "animselectortables/soldier_traverse_warp_across.csv"], [1, "animselectortables/civilian_traverse_warp_across.csv"], [2, "animselectortables/dog_traverse_warp_across.csv"]];
    var_0["traverse_warp_jump_across"] = [[0, "animselectortables/soldier_traverse_warp_jump_across.csv"], [1, "animselectortables/civilian_traverse_warp_jump_across.csv"], [2, "animselectortables/dog_traverse_warp_jump_across.csv"]];
    var_0["traverse_warp_external"] = [[0, "animselectortables/soldier_traverse_warp_external.csv"], [1, "animselectortables/civilian_traverse_warp_external.csv"], [2, "animselectortables/dog_traverse_warp_external.csv"]];
  }

  return var_0;
}

init() {
  anim._id_18D8 = [];
  anim._id_18D8["min_height"] = ["height", 1];
  anim._id_18D8["max_height"] = ["height", 2];
  anim._id_18D8["min_arrival_yaw"] = ["arrival_yaw", 1];
  anim._id_18D8["max_arrival_yaw"] = ["arrival_yaw", 2];
  anim._id_18D8["min_length"] = ["length", 1];
  anim._id_18D8["max_length"] = ["length", 2];
  anim._id_18D8["min_drop_height"] = ["drop_height", 1];
  anim._id_18D8["max_drop_height"] = ["drop_height", 2];
  anim._id_18D8["min_speed"] = ["speed", 1];
  anim._id_18D8["max_speed"] = ["speed", 2];
  anim._id_18D8["start_offset"] = ["start_offset", 0];
  anim._id_18D8["end_offset"] = ["end_offset", 0];
  anim._id_18D7 = [];
  var_0 = _id_68C8();

  foreach(var_13, var_2 in var_0) {
    foreach(var_12, var_4 in var_2) {
      anim._id_18D7[var_13][var_12] = spawnStruct();
      anim._id_18D7[var_13][var_12]._id_144B = [];
      anim._id_18D7[var_13][var_12]._id_59F5 = [];
      anim._id_18D7[var_13][var_12]._id_FF6E = [];
      var_5 = tablelookuprownum(var_4[1], 0, "__END__");
      var_5 = var_5 - 1;

      for(var_6 = 0; var_6 < var_5; var_6++) {
        var_7 = tablelookupbyrow(var_4[1], var_6 + 1, 0);
        anim._id_18D7[var_13][var_12]._id_144B[var_6] = var_7;
      }

      var_8 = undefined;

      for(var_6 = 0; var_6 < 50; var_6++) {
        var_9 = tablelookupbyrow(var_4[1], 0, var_6 + 1);

        if(var_9 == "__END__" || var_9 == "") {
          var_8 = var_6;
          break;
        } else
          anim._id_18D7[var_13][var_12]._id_59F5[var_6] = var_9;
      }

      for(var_6 = 0; var_6 < var_5; var_6++) {
        for(var_10 = 0; var_10 < var_8; var_10++) {
          var_7 = anim._id_18D7[var_13][var_12]._id_144B[var_6];
          var_9 = anim._id_18D7[var_13][var_12]._id_59F5[var_10];
          var_11 = tablelookupbyrow(var_4[1], var_6 + 1, var_10 + 1);

          if(var_11 == "") {
            var_11 = undefined;
          } else {
            var_11 = float(var_11);
          }

          anim._id_18D7[var_13][var_12]._id_FF6E[var_7][var_9] = var_11;
        }
      }
    }
  }
}

_id_34FD(var_0, var_1, var_2) {
  var_3 = anim._id_18D8[var_1][0];
  var_4 = anim._id_18D8[var_1][1];
  var_5 = var_2[var_3];

  if(!isDefined(var_5)) {
    return 1;
  }

  if(var_4 == 1) {
    return var_5 >= var_0;
  } else if(var_4 == 2) {
    return var_5 <= var_0;
  } else if(var_4 == 0) {
    return 1;
  }
}

_id_D051(var_0, var_1, var_2) {
  var_3 = anim._id_18D7[var_0][var_2];

  foreach(var_5 in var_3._id_144B) {
    if(isai(self) && !_id_0009::_id_1C72(var_0, var_5)) {
      continue;
    }
    var_6 = 1;

    foreach(var_8 in var_3._id_59F5) {
      var_9 = var_3._id_FF6E[var_5][var_8];

      if(isDefined(var_9)) {
        if(!_id_34FD(var_9, var_8, var_1)) {
          var_6 = 0;
          break;
        }
      }
    }

    if(var_6) {
      return var_5;
    }
  }
}

_id_6DFC(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self _meth_87CE();
  }

  if(isDefined(var_0)) {
    switch (var_0) {
      case "dog":
        return 2;
      case "juggernaut_cp":
      case "soldier_female":
      case "farah":
      case "hero_salter":
      case "soldier_pistol":
      case "juggernaut":
      case "soldier_cp":
      case "rebel":
      case "soldier":
        return 0;
      case "krampus":
      case "civilian_female":
      case "hadir_yth":
      case "civilian":
        return 1;
      default:
        if(isDefined(self._id_1C30._id_1A35) && self._id_1C30._id_1A35 == "suicidebomber_cp") {
          return 2;
        }

        if(isDefined(self._id_04B9) && self._id_04B9 == "soldier") {
          return 0;
        }

        return -1;
    }
  }

  return -1;
}