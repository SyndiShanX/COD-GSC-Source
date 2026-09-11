/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\animselector.gsc
***********************************************/

function getanimselectorfilenames() {
  var_0 = [];

  if(scripts\common\utility::iscp()) {
    GscBinSkip0(0x2e, "traverse_warp_up", [[0, "animselectortables/soldier_traverse_warp_up.csv"], [1, "animselectortables/civilian_traverse_warp_up.csv"], [2, "animselectortables/bomber_traverse_warp_up.csv"]]);
  }

  GscBinSkip0(0x2e, "traverse_warp_up", [[0, "animselectortables/soldier_traverse_warp_up.csv"], [1, "animselectortables/civilian_traverse_warp_up.csv"]]);
}

function init() {
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
  var_0 = getanimselectorfilenames();

  foreach(var_13, var_2 in var_0) {
    foreach(var_12, var_4 in var_2) {
      anim.animselector[var_13][var_12] = spawnStruct();
      anim.animselector[var_13][var_12].aliases = [];
      anim.animselector[var_13][var_12].features = [];
      anim.animselector[var_13][var_12].values = [];
      var_5 = tablelookuprownum(var_4[1], 0, "__END__");
      var_5 -= 1;

      for(var_6 = 0; var_6 < var_5; var_6++) {
        var_7 = tablelookupbyrow(var_4[1], var_6 + 1, 0);
        anim.animselector[var_13][var_12].aliases[var_6] = var_7;
      }

      var_8 = undefined;

      for(var_6 = 0; var_6 < 50; var_6++) {
        var_9 = tablelookupbyrow(var_4[1], 0, var_6 + 1);

        if(var_9 == "__END__" || var_9 == "") {
          var_8 = var_6;
          break;
        }

        anim.animselector[var_13][var_12].features[var_6] = var_9;
      }

      for(var_6 = 0; var_6 < var_5; var_6++) {
        for(var_10 = 0; var_10 < var_8; var_10++) {
          var_7 = anim.animselector[var_13][var_12].aliases[var_6];
          var_9 = anim.animselector[var_13][var_12].features[var_10];
          var_11 = tablelookupbyrow(var_4[1], var_6 + 1, var_10 + 1);

          if(var_11 == "") {
            var_11 = undefined;
          } else {
            var_11 = float(var_11);
          }

          anim.animselector[var_13][var_12].values[var_7][var_9] = var_11;
        }
      }
    }
  }
}

function checkfeaturevalue(var_0, var_1, var_2) {
  var_3 = anim.animselectorfeaturetable[var_1][0];
  var_4 = anim.animselectorfeaturetable[var_1][1];
  var_5 = var_2[var_3];

  if(!isDefined(var_5)) {
    return 1;
  }

  if(var_4 == 0) {
    return (var_5 >= var_0);
  }

  if(var_4 == 1) {
    return (var_5 <= var_0);
  }
}

function selectanim(var_0, var_1, var_2) {
  var_3 = anim.animselector[var_0][var_2];

  foreach(var_5 in var_3.aliases) {
    if(isai(self) && !scripts\asm\asm::asm_hasalias(var_0, var_5)) {
      continue;
    }

    var_6 = 1;

    foreach(var_8 in var_3.features) {
      var_9 = var_3.values[var_5][var_8];

      if(isDefined(var_9)) {
        if(!checkfeaturevalue(var_9, var_8, var_1)) {
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

function gettraverserindex() {
  var_0 = scripts\asm\shared\utility::getbasearchetype();

  if(isDefined(var_0)) {
    switch (var_0) {
      case "juggernaut_cp":
      case "soldier_pistol":
      case "soldier_female":
      case "farah":
      case "hero_salter":
      case "soldier_cp":
      case "rebel":
      case "soldier":
      case "juggernaut":
        return 0;
      case "civilian_female":
      case "hadir_yth":
      case "civilian":
        return 1;
      default:
        if(isDefined(self.asm.archetype) && self.asm.archetype == "suicidebomber_cp") {
          return 2;
        }

        if(isDefined(self.unittype) && self.unittype == "soldier") {
          return 0;
        }

        return -1;
    }
  }

  return -1;
}