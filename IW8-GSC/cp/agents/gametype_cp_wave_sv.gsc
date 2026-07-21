/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\agents\gametype_cp_wave_sv.gsc
***********************************************/

givestreakpointswithtext(var_0, var_1, var_2) {
  if(isDefined(level.ignorescoring)) {
    return;
  }
  if(isDefined(var_2))
    var_3 = var_2;
  else
    var_3 = scripts\cp\drone\emp_drone::getscoreinfovalue(var_0);

  var_3 = modifyunifiedpoints(var_0, var_3, var_1);
  displayscoreeventpoints(var_3, var_0);
}

giveunifiedpoints(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(level.ignorescoring) && !issubstr(var_0, "_encstr_A1BD075837DCD29B47")) {
    return;
  }
  if(isDefined(var_2))
    var_6 = var_2;
  else
    var_6 = scripts\cp\drone\emp_drone::getscoreinfovalue(var_0);

  var_6 = modifyunifiedpoints(var_0, var_6, var_1);
  var_7 = var_0 == "_encstr_ABD70578F3D02C";
  var_8 = 0;
  var_9 = 0;
  var_10 = istrue(self.isjuggernaut);
  var_11 = update_objective_setmlgbackground(var_1);
  var_12 = scripts\cp\utility::_hasperk("_encstr_96F4242EE80FF173FE6A107031140B684373352655C738D763625158EA2DF581871CBE15A947");
  var_13 = var_9 && scripts\cp\utility::_hasperk("_encstr_AF821CB938956CD285363ACB7DB1D0C24B37D76D961BD89B47C9952CDADC") && istrue(var_5);

  if(isDefined(var_4)) {
    if(isDefined(self._id_119D4) && self._id_119D4.size > 0) {
      if(istrue(self._id_119D4[var_4 getentitynumber()])) {
        self._id_119D4[var_4 getentitynumber()] = undefined;
        return;
      }
    }
  }

  if((var_7 || var_8 || var_13 || var_12) && (!var_10 || var_13 || var_12) && (!var_11 || var_12)) {}

  if(level.gametype == "_encstr_839E0CBFD1801B5DB0D34C932998") {
    if(!isDefined(var_1))
      thread screenent_a(var_6);
  }

  if(!istrue(var_3))
    thread scripts\cp\drone\emp_drone::giverankxp(var_0, var_6, var_1);
}

screenent_a(var_0) {
  var_1 = scripts\cp\cp_persistence::quickdropremovearmorfrominventory();
  var_0 = scripts\cp\cp_gamescore::round_up_to_nearest(var_0, 5);

  if(isDefined(self._id_13BF3) && isDefined(self._id_11B67)) {
    if(self._id_13BF3 > self._id_11B67)
      var_0 = 0;
    else
      self._id_13BF3 = self._id_13BF3 + var_0;
  }

  var_2 = scripts\cp\cp_persistence::get_player_max_currency();
  var_3 = var_1 + var_0;
  var_3 = min(var_3, var_2);
  scripts\cp\cp_persistence::_id_130AA(var_3);
}

modifyunifiedpoints(var_0, var_1, var_2) {
  switch (var_0) {
    case "_encstr_B2BE0788BAF573592F":
      return 0;
    default:
      break;
  }

  var_3 = 0;

  if(var_0 == "_encstr_ABD70578F3D02C" && var_2 hasattachment("_encstr_AA210BC97B46A89D1397FFB993"))
    var_3 = var_3 + 20;

  var_1 = var_1 + var_3;

  if(isDefined(level.modifyunifiedpointscallback))
    var_1 = [[level.modifyunifiedpointscallback]](var_1, var_0, self, var_2);

  return int(var_1);
}

displayscoreeventpoints(var_0, var_1) {
  if(getdvarint("_encstr_8FA517573F931898A91AE199C58D694EFAD3E39F8B9ADF18F0", 0) == 1) {
    return;
  }
  if(scripts\cp\utility::turn_off_sniper_laser())
    return;
  else if(isDefined(self.totalxpearned) && isDefined(self._id_11B7F)) {
    if(self.totalxpearned >= self._id_11B7F)
      return;
  }

  if(level.codcasterenabled) {
    foreach(var_3 in level.players) {
      if(var_3 ismlgspectator()) {
        var_4 = var_3 getspectatingplayer();

        if(isDefined(var_4)) {
          var_5 = var_4 getentitynumber();
          var_6 = self getentitynumber();

          if(var_5 == var_6) {
            var_3 thread scripts\cp\drone\emp_drone::scorepointspopup(var_0);
            var_3 thread scripts\cp\drone\emp_drone::scoreeventpopup(var_1);
          }
        }
      }
    }
  }

  if(!isDefined(level.skippointdisplayxp)) {
    var_8 = 0;

    if(scripts\cp\utility::issimultaneouskillenabled())
      var_8 = var_1 == "_encstr_ABD70578F3D02C";

    thread scripts\cp\drone\emp_drone::scorepointspopup(var_0, var_8);
  }
}

update_objective_setmlgbackground(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isstring(var_0))
    var_0 = getcompleteweaponname(var_0);

  switch (var_0.basename) {
    case "_encstr_B65F1413E4B03236ACF2D78EDBDDEB83E4BD4DFAD61C":
    case "_encstr_81D911B12DB386D14716DC6DBE8EABE4F5ADE0":
    case "_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07":
      return 1;
  }

  return 0;
}

unset_relic_doomslayer(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isstring(var_0))
    var_0 = getcompleteweaponname(var_0);

  switch (var_0.basename) {
    case "_encstr_A96115C8B283C6B7E5AFA6BA9DB32BC9372CBAE8FAADE0":
    case "_encstr_A9AF1246CAC1367B2FAF0B969CC8C9DB07AFD683":
    case "_encstr_A22812C4735AC7E2B64317C3CF560A3128DE7D0A":
    case "_encstr_95D71524C4F171FB83E84B7380FB9FFB1F50EA5FB8F33B":
      return 1;
  }

  return 0;
}

calculatematchbonus(var_0, var_1) {
  var_2 = 250;
  var_3 = var_1 / 60;
  var_4 = scripts\cp\drone\emp_drone::getscoreinfovalue(var_0);
  var_5 = self.timeplayed["_encstr_BE7D0633C08849E2"] / var_1;

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    var_3 = 1;
    var_5 = 1;
  }

  var_6 = scripts\cp\drone\emp_drone::getgametypexpmultiplier();
  var_7 = int(var_2 * var_4 * var_3 * var_5 * var_6);
  return var_7;
}

updatematchbonusscores(var_0) {
  if(istrue(level.forcedend)) {
    var_1 = scripts\cp\cp_endgame::get_play_time() / 1000;
    var_1 = min(var_1, 1200);
  } else
    var_1 = scripts\cp\cp_endgame::get_play_time() / 1000;

  if(level.teambased) {
    if(var_0 != "_encstr_8D19048EA595")
      setwinningteam(var_0);

    foreach(var_3 in level.players) {
      if(isDefined(var_3.connectedpostgame)) {
        continue;
      }
      if(var_3.timeplayed["_encstr_BE7D0633C08849E2"] < 1 || var_3.pers["_encstr_BED60EFF9EE32990DB1728A84BF968A5"] < 1) {
        continue;
      }
      if(istrue(level.hostforcedend) && var_3 ishost()) {
        continue;
      }
      if(!istrue(var_3.pers["_encstr_8ED5113B4F634B98558FDD4AF3BFA74056A763"])) {
        continue;
      }
      if(var_0 == "_encstr_8D19048EA595") {
        var_4 = var_3 calculatematchbonus("_encstr_8D19048EA595", var_1);
        var_3 thread givematchbonus("_encstr_8D19048EA595", var_4);
        var_3.matchbonus = var_4;
      } else if(isDefined(var_3.pers["_encstr_8AEF05472BC2D6"]) && var_3.pers["_encstr_8AEF05472BC2D6"] == var_0) {
        var_4 = var_3 calculatematchbonus("_encstr_91190447C232", var_1);
        var_3 thread givematchbonus("_encstr_91190447C232", var_4);
        var_3.matchbonus = var_4;
      } else if(isDefined(var_3.pers["_encstr_8AEF05472BC2D6"]) && var_3.pers["_encstr_8AEF05472BC2D6"] != var_0) {
        var_4 = var_3 calculatematchbonus("_encstr_8CAD05DB100303", var_1);
        var_3 thread givematchbonus("_encstr_8CAD05DB100303", var_4);
        var_3.matchbonus = var_4;
      }

      var_3 freight_lift_button_activation(var_1);
    }
  } else {
    var_6 = "_encstr_91190447C232";
    var_7 = "_encstr_8CAD05DB100303";

    if(!isDefined(var_0)) {
      var_6 = "_encstr_8D19048EA595";
      var_7 = "_encstr_8D19048EA595";
    }

    foreach(var_3 in level.players) {
      if(isDefined(var_3.connectedpostgame)) {
        continue;
      }
      if(var_3.timeplayed["_encstr_BE7D0633C08849E2"] < 1 || var_3.pers["_encstr_BED60EFF9EE32990DB1728A84BF968A5"] < 1) {
        continue;
      }
      if(!istrue(var_3.pers["_encstr_8ED5113B4F634B98558FDD4AF3BFA74056A763"])) {
        continue;
      }
      var_9 = 0;

      for(var_10 = 0; var_10 < min(level.placement["_encstr_AF1904A7F929"].size, 3); var_10++) {
        if(level.placement["_encstr_AF1904A7F929"][var_10] != var_3) {
          continue;
        }
        var_9 = 1;
      }

      if(var_9) {
        var_4 = var_3 calculatematchbonus(var_6, var_1);
        var_3 thread givematchbonus("_encstr_91190447C232", var_4);
        var_3.matchbonus = var_4;
      } else {
        var_4 = var_3 calculatematchbonus(var_7, var_1);
        var_3 thread givematchbonus("_encstr_8CAD05DB100303", var_4);
        var_3.matchbonus = var_4;
      }

      var_3 freight_lift_button_activation(var_1);
    }
  }
}

givematchbonus(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level waittill("_encstr_82AA118770E83DA1F98B93B7E1883A7F705B3A");
  scripts\cp\drone\emp_drone::giverankxp(var_0, var_1);

  if(var_0 == "_encstr_91190447C232")
    thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_950113DAC247C643EB1BB7B583D8B2E8CAEBEE4B9B");
  else
    thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_8C170FBFCB3D3268019935BDD3B0ADFB1D");
}

freight_lift_button_activation(var_0) {
  var_0 = 600;

  if(istrue(self.pers["_encstr_AF8417A8EFCBC71DDB0F0F46D8B5D8EBF82B0E301607D5533E"]) || !isDefined(self.pers["_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D"])) {
    return;
  }
  var_1 = scripts\cp\cp_weaponrank::reload_handle_hintstring() / 60;
  var_2 = var_0 / 60;
  var_3 = int(var_1 * var_2);
  var_4 = int(50.0);
  var_5 = self.timeplayed["_encstr_BE7D0633C08849E2"] / var_0;
  var_6 = var_4 * var_5;
  var_7 = int(var_3 * var_6);
  var_7 = var_7 - int(self.pers["_encstr_A743160C1A128338F593613C3B48D9A7E5DD92AFEB79E17E"] * var_6);

  if(var_7 <= 0) {
    return;
  }
  var_8 = 0;

  foreach(var_10 in self.pers["_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D"])
  var_8 = var_8 + (var_3 - var_10.killcount);

  if(var_8 <= 0) {
    return;
  }
  foreach(var_19, var_10 in self.pers["_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D"]) {
    var_13 = (var_3 - var_10.killcount) / var_8;
    var_14 = int(var_7 * var_13);
    scripts\cp\drone\emp_drone::incrankxp(0, var_10, var_14);

    foreach(var_18, var_16 in self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"]) {
      if(issubstr(var_18, var_19)) {
        if(isDefined(var_16.stats["_encstr_8E8D0697EB01F243"]) && var_10.killcount > 0) {
          var_17 = var_13 * (var_16.stats["_encstr_8E8D0697EB01F243"] / var_10.killcount);
          var_14 = int(var_7 * var_17);

          if(isDefined(var_16.stats["_encstr_AF2F0A13317F6999F380EB53"]))
            var_16.stats["_encstr_AF2F0A13317F6999F380EB53"] = var_16.stats["_encstr_AF2F0A13317F6999F380EB53"] + var_14;
          else
            var_16.stats["_encstr_AF2F0A13317F6999F380EB53"] = var_14;
        }
      }
    }
  }
}

sethasdonecombat(var_0, var_1) {
  if(var_1 && !istrue(var_0.hasdonecombat)) {}

  var_0.hasdonecombat = var_1;

  if(var_1 && !istrue(var_0.pers["_encstr_8ED5113B4F634B98558FDD4AF3BFA74056A763"]))
    var_0.pers["_encstr_8ED5113B4F634B98558FDD4AF3BFA74056A763"] = 1;
}