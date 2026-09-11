/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\animselector.gsc
***********************************************/

function getanimselectorfilenames() {
  var0 = [];

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
  var0 = getanimselectorfilenames();

  foreach(var13, var2 in var0) {
    foreach(var12, var4 in var2) {
      anim.animselector[var13][var12] = spawnStruct();
      anim.animselector[var13][var12].aliases = [];
      anim.animselector[var13][var12].features = [];
      anim.animselector[var13][var12].values = [];
      var5 = tablelookuprownum(var4[1], 0, "__END__");
      var5 -= 1;

      for(var6 = 0; var6 < var5; var6++) {
        var7 = tablelookupbyrow(var4[1], var6 + 1, 0);
        anim.animselector[var13][var12].aliases[var6] = var7;
      }

      var8 = undefined;

      for(var6 = 0; var6 < 50; var6++) {
        var9 = tablelookupbyrow(var4[1], 0, var6 + 1);

        if(var9 == "__END__" || var9 == "") {
          var8 = var6;
          break;
        }

        anim.animselector[var13][var12].features[var6] = var9;
      }

      for(var6 = 0; var6 < var5; var6++) {
        for(var10 = 0; var10 < var8; var10++) {
          var7 = anim.animselector[var13][var12].aliases[var6];
          var9 = anim.animselector[var13][var12].features[var10];
          var11 = tablelookupbyrow(var4[1], var6 + 1, var10 + 1);

          if(var11 == "") {
            var11 = undefined;
          } else {
            var11 = float(var11);
          }

          anim.animselector[var13][var12].values[var7][var9] = var11;
        }
      }
    }
  }
}

function checkfeaturevalue(var0, var1, var2) {
  var3 = anim.animselectorfeaturetable[var1][0];
  var4 = anim.animselectorfeaturetable[var1][1];
  var5 = var2[var3];

  if(!isDefined(var5)) {
    return 1;
  }

  if(var4 == 0) {
    return (var5 >= var0);
  }

  if(var4 == 1) {
    return (var5 <= var0);
  }
}

function selectanim(var0, var1, var2) {
  var3 = anim.animselector[var0][var2];

  foreach(var5 in var3.aliases) {
    if(isai(self) && !scripts\asm\asm::asm_hasalias(var0, var5)) {
      continue;
    }

    var6 = 1;

    foreach(var8 in var3.features) {
      var9 = var3.values[var5][var8];

      if(isDefined(var9)) {
        if(!checkfeaturevalue(var9, var8, var1)) {
          var6 = 0;
          break;
        }
      }
    }

    if(var6) {
      return var5;
    }
  }
}

function gettraverserindex() {
  var0 = scripts\asm\shared\utility::getbasearchetype();

  if(isDefined(var0)) {
    switch (var0) {
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