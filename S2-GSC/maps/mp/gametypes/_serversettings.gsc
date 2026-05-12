/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_serversettings.gsc
*************************************************/

func_00D5() {
  level.var_4E0E = getDvar("5656");
  if(level.var_4E0E == "") {
    level.var_4E0E = "CoDHost";
  }

  setDvar("5656", level.var_4E0E);
  level.var_0C32 = getdvarint("4372", 1);
  setDvar("4372", level.var_0C32);
  level.var_3EC4 = maps\mp\gametypes\_tweakables::func_46F7("team", "fftype");
  func_2596(getDvar("1924"));
  for(;;) {
    func_A164();
    wait(5);
  }
}

func_A164() {
  var_00 = getDvar("5656");
  if(level.var_4E0E != var_00) {
    level.var_4E0E = var_00;
  }

  var_01 = getdvarint("4372", 1);
  if(level.var_0C32 != var_01) {
    level.var_0C32 = var_01;
  }

  var_02 = maps\mp\gametypes\_tweakables::func_46F7("team", "fftype");
  if(level.var_3EC4 != var_02) {
    level.var_3EC4 = var_02;
  }
}

func_2596(param_00) {
  var_01 = getEntArray();
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_03 = var_01[var_02];
    if(param_00 == "dm") {
      if(isDefined(var_03.var_81C1) && var_03.var_81C1 != "1") {
        var_03 delete();
      }

      continue;
    }

    if(param_00 == "tdm") {
      if(isDefined(var_03.var_81C5) && var_03.var_81C5 != "1") {
        var_03 delete();
      }

      continue;
    }

    if(param_00 == "ctf") {
      if(isDefined(var_03.var_81C0) && var_03.var_81C0 != "1") {
        var_03 delete();
      }

      continue;
    }

    if(param_00 == "hq") {
      if(isDefined(var_03.var_81C2) && var_03.var_81C2 != "1") {
        var_03 delete();
      }

      continue;
    }

    if(param_00 == "sd") {
      if(isDefined(var_03.var_81C4) && var_03.var_81C4 != "1") {
        var_03 delete();
      }

      continue;
    }

    if(param_00 == "koth") {
      if(isDefined(var_03.var_81C3) && var_03.var_81C3 != "1") {
        var_03 delete();
      }

      continue;
    }

    if(param_00 == "atdm") {
      if(isDefined(var_03.var_81BF) && var_03.var_81BF != "1") {
        var_03 delete();
      }
    }
  }
}