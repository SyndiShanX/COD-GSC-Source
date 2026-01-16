/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\battlechatter_ai.gsc
*********************************************/

func_185D(var_0) {
  self endon("death");
  if(!scripts\anim\battlechatter::func_29CA()) {
    return;
  }

  if(self.var_3D4B) {
    return;
  }

  if(!isDefined(self.var_10AC8.var_3D4B) || !self.var_10AC8.var_3D4B) {
    self.var_10AC8 scripts\anim\battlechatter::func_9762();
  }

  self.var_6552 = "infantry";
  self.var_376A = [];
  if(isplayer(self) || scripts\engine\utility::player_is_in_jackal() && self == level.var_D127) {
    self.var_28CF = 0;
    self.var_6EE9 = 0;
    self.type = "human";
    return;
  }

  if(isDefined(self.var_29B8) && self.var_29B8) {
    self.var_28CF = 0;
    self.var_6EE9 = 0;
  } else {
    if(self.unittype == "c12") {
      self.var_28CF = 0;
      self.var_6552 = "c12";
      return;
    }

    if(self.unittype == "c8" || isDefined(self.asmname) && self.asmname == "seeker") {
      self.var_28CF = 0;
      self.var_6EE9 = 0;
      return;
    }

    if(self.team == "neutral") {
      self.var_6552 = undefined;
      self.var_28CF = 0;
      self.var_6EE9 = 0;
      return;
    }

    if(self.unittype == "c6") {
      self getnodeyawfromoffsettable("grenade danger");
      thread func_29B6();
    }

    self.var_8C7E = lib_0A1E::func_2356("Knobs", "head");
    self.var_EF82 = lib_0A1E::func_2356("Knobs", "scripted_talking");
    self.var_504D = lib_0A1E::func_2356("Knobs", "default_talking");
  }

  if(!isDefined(self.voice)) {
    return;
  }

  self.var_46BC = level.var_46BD[self.voice];
  if(!isDefined(self.var_46BC)) {
    return;
  }

  func_23CF();
  thread func_1A54();
  func_94E5();
  thread func_1B06();
}

func_23CF() {
  if(isDefined(self.var_EDB8)) {
    var_0 = tolower(self.var_EDB8);
    if(issubstr(var_0, "eth.3n")) {
      self.npcid = "eth";
      return;
    }

    if(issubstr(var_0, "ethan")) {
      self.npcid = "eth";
      return;
    }

    if(issubstr(var_0, "salter")) {
      self.npcid = "slt";
      return;
    }

    if(issubstr(var_0, "brooks")) {
      self.npcid = "brk";
      return;
    }

    if(issubstr(var_0, "kashima")) {
      self.npcid = "ksh";
      return;
    }

    if(issubstr(var_0, "omar")) {
      self.npcid = "omr";
      return;
    }

    if(issubstr(var_0, "mco")) {
      self.npcid = "omr";
      return;
    }

    if(issubstr(var_0, "macallum")) {
      self.npcid = "mac";
      return;
    }

    if(issubstr(var_0, "raines")) {
      self.npcid = "adm";
      return;
    }

    func_F7BB();
    return;
  }

  if(isDefined(self.var_29B8) && self.var_29B8) {
    while(!isDefined(level.var_13075) || !isDefined(level.var_13075[self.voice])) {
      wait(0.05);
    }
  }

  func_F7BB();
}

func_72C2() {
  if(!getdvarint("bcs_forceEnglish", 0)) {
    return 0;
  }

  switch (level.script) {
    case "pmc_strike":
      return 1;
  }

  return 0;
}

func_1B06() {
  self endon("death");
  self endon("removed from battleChatter");
  if(!isDefined(self.team)) {
    return;
  }

  var_0 = 0.5;
  wait(var_0);
  if(!scripts\engine\utility::player_is_in_jackal()) {
    thread func_1A10();
  }

  thread func_1A0F();
  if(self.team == "allies") {
    wait(var_0);
    thread func_1A0E();
  } else if((self.team == "axis" || self.team == "team3") && !func_9D3A(self.var_46BC)) {
    thread func_1A19();
    var_0 = 5;
  }

  if(isDefined(level.player) && self.team == level.player.team) {
    thread func_D085();
  }

  wait(var_0);
  thread func_1A07();
}

func_9D3A(var_0) {
  if(var_0 == "UN" || var_0 == "JK") {
    return 1;
  }

  return 0;
}

func_F7BB() {
  var_0 = level.var_13075[self.voice];
  var_1 = var_0.size;
  var_2 = randomintrange(0, var_1);
  var_3 = var_2;
  for(var_4 = 0; var_4 <= var_1; var_4++) {
    if(var_0[var_2 + var_4 % var_1].var_C1 < var_0[var_3].var_C1) {
      var_3 = var_2 + var_4 % var_1;
    }
  }

  thread func_C19E(var_3);
  self.npcid = var_0[var_3].npcid;
  if(self.voice == "unitednationsfemale") {
    self.npcid = "w" + self.npcid;
  }
}

func_C19E(var_0) {
  level.var_13075[self.voice][var_0].var_C1++;
  scripts\engine\utility::waittill_either("death", "removed from battleChatter");
  if(!scripts\anim\battlechatter::func_29CA()) {
    return;
  }

  level.var_13075[self.voice][var_0].var_C1--;
}

func_1A19() {
  self endon("death");
  self endon("removed from battleChatter");
  wait(2);
  for(;;) {
    if(distancesquared(self.origin, level.player.origin) < 1048576) {
      if(isDefined(self.var_10AC8.var_B65C) && self.var_10AC8.var_B65C > 1) {
        func_181C("taunt", "hostileburst");
      }
    }

    wait(randomfloatrange(2, 5));
  }
}

func_1A07() {
  self endon("death");
  self endon("removed from battleChatter");
  for(;;) {
    scripts\anim\battlechatter::func_CEE8();
    wait(0.3 + randomfloat(0.2));
  }
}

func_1A54() {
  self endon("death");
  self endon("removed from battleChatter");
  for(;;) {
    self.var_29AD = scripts\anim\battlechatter::func_7FD8();
    self.var_29B3 = scripts\anim\battlechatter::getrank();
    self waittill("set name and rank");
  }
}

func_E11B(var_0) {
  if(scripts\anim\battlechatter::func_29CA()) {
    if(func_1A1B() || !isalive(self)) {
      if(isDefined(self)) {
        func_1A0C();
        func_1A0A();
      }
    }
  }

  if(isDefined(self)) {
    self.var_28CF = 0;
    self.var_3D4B = 0;
  }

  self notify("removed from battleChatter");
  if(isDefined(self)) {
    self.var_3D4C = undefined;
    self.var_BFA8 = undefined;
    self.var_BFA9 = undefined;
    self.var_9F6B = undefined;
    self.var_6552 = undefined;
    self.var_376A = undefined;
    self.var_46BC = undefined;
    self.npcid = undefined;
  }
}

func_94E5() {
  self.var_3D4C = [];
  self.var_3D4C["threat"] = spawnStruct();
  self.var_3D4C["threat"].var_698B = 0;
  self.var_3D4C["threat"].priority = 0;
  self.var_3D4C["response"] = spawnStruct();
  self.var_3D4C["response"].var_698B = 0;
  self.var_3D4C["response"].priority = 0;
  self.var_3D4C["reaction"] = spawnStruct();
  self.var_3D4C["reaction"].var_698B = 0;
  self.var_3D4C["reaction"].priority = 0;
  self.var_3D4C["inform"] = spawnStruct();
  self.var_3D4C["inform"].var_698B = 0;
  self.var_3D4C["inform"].priority = 0;
  self.var_3D4C["order"] = spawnStruct();
  self.var_3D4C["order"].var_698B = 0;
  self.var_3D4C["order"].priority = 0;
  self.var_3D4C["custom"] = spawnStruct();
  self.var_3D4C["custom"].var_698B = 0;
  self.var_3D4C["custom"].priority = 0;
  self.var_BFA8 = gettime() + 50;
  self.var_BFA9["threat"] = 0;
  self.var_BFA9["reaction"] = 0;
  self.var_BFA9["response"] = 0;
  self.var_BFA9["inform"] = 0;
  self.var_BFA9["order"] = 0;
  self.var_BFA9["custom"] = 0;
  self.var_9F6B = 0;
  self.var_29BF = 0;
  self.var_1C8B = [];
  scripts\anim\battlechatter::func_17A2("exposed");
  scripts\anim\battlechatter::func_17A2("ai_contact_clock");
  scripts\anim\battlechatter::func_17A2("ai_target_clock");
  if(self.team == "allies") {
    if(scripts\engine\utility::array_contains(level.var_D3DD, self.voice)) {
      scripts\anim\battlechatter::func_17A2("player_contact_clock");
      scripts\anim\battlechatter::func_17A2("player_target_clock");
      scripts\anim\battlechatter::func_17A2("player_cardinal");
      scripts\anim\battlechatter::func_17A2("player_obvious");
      scripts\anim\battlechatter::func_17A2("player_object_clock");
      scripts\anim\battlechatter::func_17A2("player_location");
    }

    scripts\anim\battlechatter::func_17A2("ai_location");
    scripts\anim\battlechatter::func_17A2("generic_location");
    if(self.voice == "unitednations" || self.voice == "unitednationsfemale") {
      scripts\anim\battlechatter::func_17A2("ai_obvious");
      scripts\anim\battlechatter::func_17A2("ai_casual_clock");
      scripts\anim\battlechatter::func_17A2("concat_location");
      scripts\anim\battlechatter::func_17A2("concat_location");
      scripts\anim\battlechatter::func_17A2("player_distance");
      scripts\anim\battlechatter::func_17A2("player_target_clock_high");
      scripts\anim\battlechatter::func_17A2("ai_distance");
      scripts\anim\battlechatter::func_17A2("ai_target_clock_high");
    }
  }

  self.var_28CF = 0;
  if((isDefined(self.var_ED15) && self.var_ED15) || level.var_29B7) {
    self.var_28CF = level.var_28CF[self.team];
  }

  self.var_6EE9 = 0;
  if(scripts\anim\battlechatter::func_13528() && level.var_6EE9[self.team] == 1 && self != level.player) {
    self.var_6EE9 = 1;
  } else {
    self.var_6EE9 = 0;
  }

  if(level.var_7410) {
    scripts\sp\utility::func_F3C0(1);
  } else {
    scripts\sp\utility::func_F3C0(0);
  }

  self.var_3D4B = 1;
}

func_183F(var_0, var_1, var_2) {
  self endon("death");
  self endon("removed from battleChatter");
  if(!scripts\anim\battlechatter::cansay("threat", var_0, var_2)) {
    return;
  }

  if(scripts\anim\battlechatter::func_117ED(var_1) && !isplayer(var_1)) {
    return;
  }

  var_3 = scripts\anim\battlechatter::func_4995("threat", var_0, var_2);
  switch (var_0) {
    case "infantry":
      var_3.var_117B9 = var_1;
      break;

    case "acquired":
      var_3.var_117B9 = var_1;
      break;
  }

  if(isDefined(var_1.var_10AC8)) {
    self.var_10AC8 scripts\anim\battlechatter::func_12E7C(var_1.var_10AC8.var_10AEE, self);
  }

  self.var_3D4C["threat"] = undefined;
  self.var_3D4C["threat"] = var_3;
}

func_1820(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread func_1821(var_0, var_1, var_2, var_3, var_4, var_5);
}

func_1821(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  self endon("removed from battleChatter");
  self endon("responseEvent_failsafe");
  thread func_E2A1(var_2);
  var_6 = var_2 scripts\engine\utility::waittill_any_return("death", "done speaking", "cancel speaking");
  if(var_6 == "cancel speaking") {
    return;
  }

  if(!isalive(var_2)) {
    return;
  }

  if(!scripts\anim\battlechatter::cansay("response", var_0, var_3, var_1)) {
    return;
  }

  if(!isplayer(var_2)) {
    if(scripts\anim\battlechatter::func_9FC7(var_2)) {
      return;
    }
  }

  var_7 = scripts\anim\battlechatter::func_4995("response", var_0, var_3);
  if(isDefined(var_4)) {
    var_7.var_E1A1 = var_4;
  }

  if(isDefined(var_5)) {
    var_7.location = var_5;
  }

  var_7.var_E29D = var_2;
  var_7.modifiedspawnpoints = var_1;
  self.var_3D4C["response"] = undefined;
  self.var_3D4C["response"] = var_7;
}

func_E2A1(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  var_0 endon("death");
  var_0 endon("done speaking");
  var_0 endon("cancel speaking");
  wait(25);
  self notify("responseEvent_failsafe");
}

func_17D2(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("removed from battleChatter");
  if(!scripts\anim\battlechatter::cansay("inform", var_0, var_3, var_1)) {
    return;
  }

  var_5 = scripts\anim\battlechatter::func_4995("inform", var_0, var_3);
  switch (var_0) {
    case "reloading":
      var_5.modifiedspawnpoints = var_1;
      var_5.var_94C2 = var_2;
      break;

    case "killfirm":
      if(isDefined(var_4)) {
        var_5.var_117DE = var_4;
      }

      break;

    default:
      var_5.modifiedspawnpoints = var_1;
      break;
  }

  self.var_3D4C["inform"] = undefined;
  self.var_3D4C["inform"] = var_5;
}

func_181C(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");
  if(!isDefined(self.var_3D4C)) {
    return;
  }

  if(!isDefined(level.var_68AF) || !isDefined(level.var_68B5)) {
    return;
  }

  var_4 = scripts\anim\battlechatter::func_4995("reaction", var_0, var_3);
  var_4.var_DD60 = var_2;
  var_4.modifiedspawnpoints = var_1;
  self.var_3D4C["reaction"] = undefined;
  self.var_3D4C["reaction"] = var_4;
}

func_1809(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");
  if(!scripts\anim\battlechatter::cansay("order", var_0, var_3, var_1)) {
    return;
  }

  var_4 = scripts\anim\battlechatter::func_4995("order", var_0, var_3);
  var_4.modifiedspawnpoints = var_1;
  var_4.var_C6E5 = var_2;
  self.var_3D4C["order"] = undefined;
  self.var_3D4C["order"] = var_4;
}

isthrowinggrenade(var_0, var_1) {
  var_2 = var_0.size;
  if(var_2 == 0) {
    wait(var_1);
    return var_0;
  }

  var_3 = var_1 * 20;
  var_4 = var_2 / var_3;
  var_5 = [];
  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_7 = var_0[var_6];
    if(self.var_10AEE != "jackal_allies") {
      if(!isDefined(var_7) || isDefined(var_7) && !isDefined(var_7.voice)) {
        continue;
      }
    } else if(!isDefined(var_7)) {
      continue;
    }

    if(!isDefined(var_7.var_6552) || self.var_10AEE == "jackal_allies" && isDefined(var_7.voice)) {
      continue;
    }

    var_5[var_5.size] = var_0[var_6];
  }

  if(var_5.size == 0) {
    wait(var_1);
    return var_5;
  }

  var_5 = sortbydistance(var_5, level.player.origin);
  var_8 = [];
  var_9 = [];
  var_10 = 0;
  foreach(var_12 in var_5) {
    if(isDefined(var_12) && func_117E8(var_12)) {
      var_13 = var_12 scripts\anim\battlechatter::getlocation();
      if(isDefined(var_13) && !scripts\anim\battlechatter::location_called_out_recently(var_13)) {
        var_8[var_8.size] = var_12;
      } else {
        var_9[var_9.size] = var_12;
      }
    }

    var_10++;
    if(var_10 >= var_4) {
      wait(0.05);
      var_10 = 0;
    }
  }

  var_5 = [];
  foreach(var_10 in var_8) {
    var_5[var_5.size] = var_10;
  }

  foreach(var_10 in var_9) {
    var_5[var_5.size] = var_10;
  }

  return var_5;
}

func_117E8(var_0) {
  if(distancesquared(level.player.origin, var_0.origin) > level.var_29BE) {
    return 0;
  }

  if(!level.player scripts\anim\battlechatter::func_6632(var_0)) {
    if(scripts\engine\utility::player_is_in_jackal() && isDefined(level.player.var_58B7) && level.player.var_58B7 == var_0) {
      return 1;
    } else {
      return 0;
    }
  }

  return 1;
}

func_10AFB() {
  anim endon("battlechatter disabled");
  anim endon("squad deleted " + self.var_10AEE);
  for(;;) {
    while(!isDefined(level.var_29B7) || !level.var_29B7) {
      wait(0.05);
    }

    while(level.var_29B7) {
      if(self.team == "allies") {
        if(self.var_10AEE == "jackal_allies") {
          var_0 = level.var_A056.var_1630;
          var_1 = isthrowinggrenade(var_0, 0.5);
        } else {
          var_1 = isthrowinggrenade(getaiarray("axis", "team3"), 0.5);
        }
      } else if(self.team == "team3") {
        var_1 = isthrowinggrenade(getaiarray("allies", "axis"), 0.5);
      } else {
        wait(0.5);
        if(self.var_10AEE == "jackal_axis") {
          var_0 = level.var_A056.var_1630;
          var_1 = isthrowinggrenade(var_0, 0.5);
        } else {
          var_1 = getaiarray("allies", "team3");
          var_1[var_1.size] = level.player;
        }
      }

      if(!var_1.size) {
        wait(0.1);
        continue;
      }

      var_2 = [];
      foreach(var_4 in self.var_B661) {
        if(!isalive(var_4)) {
          continue;
        }

        if(isDefined(var_4.unittype) && var_4.unittype == "c8") {
          continue;
        }

        if(isDefined(var_4.unittype) && var_4.unittype == "c12") {
          continue;
        }

        if(!var_1.size) {
          var_1 = var_2;
          var_2 = [];
        }

        foreach(var_12, var_6 in var_1) {
          if(scripts\engine\utility::player_is_in_jackal()) {
            if(var_6 == level.player) {
              var_6 = level.var_D127;
            }
          } else if(isDefined(var_4.var_29B8) && var_4.var_29B8) {
            continue;
          }

          if(!isDefined(var_6)) {
            if(var_12 == 0) {
              var_1 = [];
            }

            continue;
          }

          if(!isalive(var_6)) {
            continue;
          }

          if(!isDefined(var_6.var_6552)) {
            continue;
          }

          if(!var_4 func_29A2(var_6)) {
            if((scripts\engine\utility::player_is_in_jackal() && var_6 == level.var_D127) || !scripts\engine\utility::player_is_in_jackal() && isplayer(var_6)) {
              continue;
            }

            if(!isDefined(var_6.team) || isDefined(var_6.team) && var_6.team == level.player.team) {
              continue;
            }

            if(!level.player func_29A2(var_6) && !scripts\engine\utility::player_is_in_jackal()) {
              continue;
            }
          }

          var_7 = var_4 getskill();
          if(isDefined(var_7)) {
            var_4 func_17D2("incoming", "seeker", undefined, 0.9);
          } else if(isDefined(var_4.bt) && isDefined(var_4.bt.var_DB05)) {
            var_4 func_181C("danger", undefined, var_4.bt.var_DB05);
          } else {
            var_4 func_183F(var_6.var_6552, var_6);
          }

          var_2[var_2.size] = var_6;
          var_8 = [];
          var_7 = undefined;
          foreach(var_10 in var_1) {
            if(var_10 != var_6) {
              var_8[var_8.size] = var_10;
            }
          }

          var_1 = var_8;
          break;
        }

        wait(0.05);
      }

      wait(0.05);
    }
  }
}

func_1A1B() {
  if(isDefined(self.asmname) && self.asmname == "jackal") {
    return 1;
  }

  return 0;
}

func_29A2(var_0) {
  if(isDefined(level.var_D127)) {
    if(!scripts\engine\utility::player_is_in_jackal() && self == level.var_D127) {
      return 0;
    }
  }

  if(func_1A1B() || scripts\engine\utility::player_is_in_jackal() && self == level.var_D127) {
    if(var_0 func_1A1B()) {
      var_1 = vectornormalize(var_0.origin - self.origin);
      var_2 = anglesToForward(self.angles);
      var_3 = vectordot(var_2, var_1);
      if(var_3 > 0.6) {
        return 1;
      }
    }
  } else if(self == level.player) {
    if(scripts\sp\utility::func_CFAC(var_0)) {
      return 1;
    }
  } else if(self cansee(var_0)) {
    return 1;
  }

  return 0;
}

func_10AE7() {
  anim endon("battlechatter disabled");
  anim endon("squad deleted " + self.var_10AEE);
  if(self.var_10AEE != "jackal_allies") {
    return;
  }

  while(!isDefined(level.var_29B7) || !level.var_29B7) {
    wait(0.05);
  }

  var_0 = undefined;
  var_1 = undefined;
  for(;;) {
    while(level.var_29B7) {
      foreach(var_3 in self.var_B661) {
        if(var_3 != level.player) {
          if(isDefined(var_3.bt) && isDefined(var_3.bt.var_A533) && var_3.bt.var_A533) {
            var_0 = "flare";
            var_1 = var_3;
            break;
          } else if(isDefined(var_3.var_B8A4) && var_3.var_B8A4.size > 0) {
            var_0 = "missile";
            var_1 = var_3;
            break;
          } else if(var_3 scripts\sp\utility::func_65DF("jackal_firing")) {
            if(var_3 scripts\sp\utility::func_65DB("jackal_firing")) {
              var_0 = "guns";
              var_1 = var_3;
              break;
            }
          }

          continue;
        }

        if(!level.player scripts\sp\utility::func_65DB("disable_jackal_flares")) {
          if(var_3.var_6E9C.var_C1 < var_3.var_6E9C.var_B417 && var_3.var_6E9C.var_A989 < gettime() - 50) {
            var_0 = "flare";
            var_1 = var_3;
            break;
          }
        }

        if(!level.player scripts\sp\utility::func_65DB("disable_jackal_missiles")) {
          if(var_3 scripts\sp\utility::func_65DB("player_jackal_missile")) {
            var_0 = "missile";
            var_1 = var_3;
            break;
          }
        }
      }

      if(isDefined(var_1)) {
        var_1 thread func_67CF(var_0);
        var_1 = undefined;
        wait(randomintrange(5, 10));
        continue;
      }

      wait(0.5);
    }

    wait(0.5);
  }

  wait(1);
}

getskill() {
  if(!isDefined(level.var_F10A.var_1633) || isDefined(level.var_F10A.var_1633) && level.var_F10A.var_1633.size < 1) {
    return;
  }

  if(scripts\anim\battlechatter::func_9B42(self)) {
    return;
  }

  var_0 = undefined;
  foreach(var_2 in level.var_F10A.var_1633) {
    if(var_2.team == self.team) {
      continue;
    }

    var_3 = distancesquared(self.origin, var_2.origin);
    if(var_3 < 360000 && isDefined(var_2.bt.var_F15D) && var_2.bt.var_F15D != self) {
      var_0 = var_2;
      break;
    }
  }

  return var_0;
}

func_1A0C() {
  var_0 = self.opcode::OP_EvalLocalVariableRefCached;
  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(self.unittype) && self.unittype == "seeker") {
    return;
  }

  if(isDefined(self.var_10AC8) && isDefined(var_0.var_10AC8) && self.var_10AC8 == var_0.var_10AC8) {
    return;
  }

  scripts\engine\utility::array_thread(self.var_10AC8.var_B661, ::func_1A0B, self);
  if(!isDefined(var_0.var_28CF)) {
    return;
  }

  if(isalive(var_0) && !isplayer(var_0) && isDefined(var_0.var_10AC8) && var_0.var_28CF) {
    if(isDefined(var_0.var_376A) && isDefined(var_0.var_376A[var_0.var_10AC8.var_10AEE])) {
      var_0.var_376A[var_0.var_10AC8.var_10AEE] = undefined;
    }

    if(!isDefined(var_0.var_6552)) {
      return;
    }

    if(!var_0 scripts\anim\battlechatter::is_in_callable_location()) {
      return;
    }

    foreach(var_2 in self.var_10AC8.var_B661) {
      if(var_2 == level.player) {
        continue;
      }

      if(gettime() > var_2.lastenemysighttime + 2000) {
        continue;
      }

      var_2 func_183F(var_0.var_6552, var_0);
    }
  }
}

func_1A0B(var_0) {
  if(!isalive(self)) {
    return;
  }

  if(scripts\sp\utility::func_D123()) {
    return;
  }

  if(isDefined(self.unittype) && self.unittype == "c6") {
    return;
  }

  self endon("death");
  self endon("removed from battleChatter");
  self notify("aiDeathEventThread");
  self endon("aiDeathEventThread");
  if(self == level.player) {
    if(isDefined(var_0) && !level.player func_29A2(var_0)) {
      return;
    }
  }

  wait(1.2);
  func_181C("casualty", "generic", self, 0.9);
}

func_1A0A() {
  var_0 = self.opcode::OP_EvalLocalVariableRefCached;
  var_1 = undefined;
  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(var_0.team) && var_0.team == "allies" && isDefined(var_0.unittype) && var_0.unittype == "c12") {
    var_2 = scripts\sp\utility::func_78BB(var_0.origin, level.player.var_10AC8.var_B661, 5000);
    var_1 = "ally_c12_kill";
    if(isDefined(var_2)) {
      var_3 = var_2;
    }
  } else if(scripts\engine\utility::player_is_in_jackal()) {
    foreach(var_5 in level.var_10AF9["jackal_allies"].var_B661) {
      if(isDefined(var_5.var_4BC7) && var_5.var_4BC7 == self) {
        var_0 = var_5;
        var_1 = "jackal";
      }
    }
  } else if(!isalive(var_0) || !issentient(var_0) && var_0 != level.player || !isDefined(var_0.var_10AC8)) {
    return;
  }

  if(!isDefined(var_0.var_46BC)) {
    return;
  }

  if(var_0.var_46BC == "UN" || var_0.var_46BC == "JK") {
    if(!isDefined(var_1)) {
      var_1 = self.unittype;
    }

    if(isDefined(var_1)) {
      var_0 thread func_1A1C(var_1);
    }
  }
}

func_1A1C(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  if(var_0 == "civilian") {
    return;
  }

  wait(1.2);
  func_17D2("killfirm", "generic", undefined, undefined, var_0);
}

func_1A10() {
  self endon("death");
  self endon("removed from battleChatter");
  var_0 = undefined;
  for(;;) {
    self waittill("grenade danger", var_1);
    if(getdvarint("bcs_enable") == 0) {
      continue;
    }

    if(isDefined(var_1)) {
      var_0 = func_1A11(var_1);
      if(!isDefined(var_0)) {
        continue;
      }
    } else if(isDefined(self.unittype) && self.unittype == "c6") {
      var_0 = "frag";
    } else {
      continue;
    }

    func_17D2("incoming", var_0);
  }
}

func_1A11(var_0) {
  var_1 = undefined;
  if(var_0.model == "frag_grenade_wm") {
    var_1 = "frag";
  }

  if(var_0.model == "emp_grenade_wm") {
    var_1 = "shock";
  }

  if(var_0.model == "anti_grav_grenade_wm") {
    var_1 = "ant";
  }

  return var_1;
}

func_29B6() {
  self endon("death");
  self endon("removed from battleChatter");
  for(;;) {
    self waittill("ai_events", var_0);
    foreach(var_2 in var_0) {
      if(var_2.type == "grenade danger") {
        self notify("grenade danger");
        break;
      }
    }

    wait(5);
  }
}

func_1A0E() {
  self endon("death");
  self endon("removed from battleChatter");
  if(isDefined(self.unittype) && self.unittype == "c6") {
    return;
  }

  for(;;) {
    self waittill("trigger");
    if(getdvarint("bcs_enable") == 0) {
      continue;
    }

    if(gettime() < self.a.var_C888 + 4000) {
      continue;
    }

    func_1820("ack", "yes", level.player, 1);
  }
}

func_67D2(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  if(isDefined(self.unittype) && self.unittype == "c6") {
    return;
  }

  if(!scripts\anim\battlechatter::func_29CA()) {
    return;
  }

  if(!isDefined(self.node)) {
    return;
  }

  if(distancesquared(self.origin, self.node.origin) < 23040) {
    return;
  }

  if(!scripts\anim\battlechatter::isnodecoverorconceal()) {
    return;
  }

  if(!func_BE58()) {
    return;
  }

  var_1 = scripts\anim\battlechatter::finishplayerdamage(24, 1024, "response");
  if(self.team != "axis" && self.team != "team3") {
    if(!isDefined(var_1)) {
      var_1 = level.player;
    } else if(randomint(100) < level.var_68AE["moveEvent"]["ordertoplayer"]) {
      var_1 = level.player;
    }
  }

  if(self.var_440E > 0) {
    if(randomint(100) < level.var_68AE["moveEvent"]["coverme"]) {
      func_1809("action", "coverme", var_1);
      return;
    }

    func_1809("move", "combat", var_1);
    return;
  }

  if(func_BE59()) {
    if(gettime() - self.starttime > 3000) {
      func_1809("move", "noncombat", var_1);
      return;
    }
  }
}

func_BE58() {
  if(self.var_46BC == "SS") {
    return 0;
  }

  return 1;
}

func_BE59() {
  if(self.var_46BC == "UN") {
    return 1;
  }

  return 0;
}

func_1A0F() {
  self endon("death");
  self endon("removed from battleChatter");
  if(isDefined(self.unittype) && self.unittype == "c6") {
    return;
  }

  for(;;) {
    level waittill("follow order", var_0);
    if(!scripts\anim\battlechatter::func_29CA()) {
      return;
    }

    if(!isDefined(self.team)) {
      return;
    }

    if(!isDefined(var_0)) {
      continue;
    }

    if(!isalive(var_0) || var_0.team != self.team) {
      continue;
    }

    if(distancesquared(self.origin, var_0.origin) < 360000) {
      func_1820("ack", "yes", var_0, 0.9);
    }
  }
}

func_D085() {
  self endon("death");
  self endon("removed from battleChatter");
  if(isDefined(self.unittype) && self.unittype == "c6") {
    return;
  }

  thread func_D086();
  for(;;) {
    self waittill("bulletwhizby", var_0, var_1);
    if(!scripts\anim\battlechatter::func_29CA()) {
      continue;
    }

    if(!isplayer(var_0)) {
      if(level.var_46BD[self.voice] == "GM" && scripts\anim\battlechatter::cansay("reaction", "takingfire", 1, undefined)) {
        func_181C("takingfire", undefined, var_0, 1);
      }

      continue;
    }
  }
}

func_D084() {
  func_181C("friendlyfire", undefined, level.player, 1);
}

func_D086() {
  self endon("death");
  self endon("removed from battleChatter");
  for(;;) {
    self waittill("damage", var_0, var_1, var_0, var_0, var_2);
    if(isDefined(var_1) && var_1 == level.player) {
      if(func_4D04(var_2)) {
        func_D084();
      }
    }
  }
}

func_4D04(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "MOD_CRUSH":
    case "MOD_IMPACT":
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_MELEE":
      return 0;
  }

  return 1;
}

func_7414(var_0, var_1) {
  var_2 = 65536;
  var_3 = 42;
  if(distancesquared(var_0.origin, self.origin) < var_2) {
    return 0;
  }

  if(var_1 > var_3) {
    return 0;
  }

  return 1;
}

func_67D4() {
  self endon("death");
  self endon("removed from battleChatter");
  if(isDefined(self.unittype) && self.unittype == "c6") {
    return;
  }

  if(!scripts\anim\battlechatter::func_29CA()) {
    return;
  }

  func_17D2("reloading", "generic");
}

func_67D1() {
  self endon("death");
  self endon("removed from battleChatter");
  if(!scripts\anim\battlechatter::func_29CA()) {
    return 0;
  }

  if(!isDefined(self.enemy)) {
    return 0;
  }

  return 0;
}

func_67D0() {
  self endon("death");
  self endon("removed from battleChatter");
  if(!scripts\anim\battlechatter::func_29CA()) {
    return;
  }

  if(!isDefined(self.enemy)) {}
}

func_67D5() {
  self endon("death");
  self endon("removed from battleChatter");
  if(!scripts\anim\battlechatter::func_29CA()) {
    return;
  }

  func_17D2("suppressed", "generic");
}

func_67CF(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  if(!scripts\anim\battlechatter::func_29CA()) {
    return;
  }

  var_1 = 0;
  var_2 = "frag";
  switch (var_0) {
    case "frag":
      var_2 = "frag";
      break;

    case "emp":
      var_2 = "shock";
      break;

    case "offhandshield":
      var_2 = "shield";
      break;

    case "hackingdevice":
      var_2 = "hack";
      break;

    case "guns":
      var_2 = "weapon_guns";
      var_1 = 1;
      break;

    case "missile":
      var_2 = "weapon_missile";
      var_1 = 1;
      break;

    case "flare":
      var_2 = "weapon_flare";
      break;
  }

  func_17D2("attack", var_2);
  if(var_1) {
    if(randomint(100) < 25) {
      wait(randomfloatrange(1, 2));
      if(isalive(self)) {
        thread func_181C("movement");
        return;
      }
    }
  }
}

func_4C3A() {
  var_0 = [];
  var_0[var_0.size] = "order_move_combat";
  var_0[var_0.size] = "order_move_noncombat";
  var_0[var_0.size] = "order_action_coverme";
  var_0[var_0.size] = "inform_reloading";
  level.var_4C81 = var_0;
}

func_4C3C(var_0) {
  var_1 = 0;
  foreach(var_3 in level.var_4C81) {
    if(var_3 == var_0) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

func_7B7E(var_0) {
  return level.var_29B1 + "custom battlechatter phrase \'" + var_0 + "\' isn\'t valid.look at _utility::custom_battlechatter_init_valid_phrases(), or the util script documentation for custom_battlechatter(), for a list of valid phrases.";
}

func_7854(var_0) {
  return level.var_29B1 + "AI at origin " + self.origin + "wasn\'t able to play custom battlechatter because his nationality is \'" + self.var_46BC + "\'.";
}

func_4C3B(var_0) {
  if(!isDefined(level.var_4C81)) {
    func_4C3A();
  }

  var_0 = tolower(var_0);
  if(!func_4C3C(var_0)) {
    var_1 = func_7B7E(var_0);
    return 0;
  }

  var_2 = scripts\anim\battlechatter::finishplayerdamage(24, 512, "response");
  func_2A62();
  switch (var_1) {
    case "order_move_combat":
      if(!func_BE58()) {
        return 0;
      }

      scripts\anim\battlechatter::func_128A8(self.var_4C84, var_2);
      func_17EF();
      break;

    case "order_move_noncombat":
      if(!func_BE59()) {
        return 0;
      }

      func_17F0();
      break;

    case "order_action_coverme":
      scripts\anim\battlechatter::func_128A8(self.var_4C84, var_2);
      func_1797();
      break;

    case "inform_reloading":
      func_17D3();
      break;

    default:
      var_1 = func_7B7E(var_1);
      return 0;
  }

  func_6314(2000);
  return 1;
}

func_2A62() {
  if(!scripts\anim\battlechatter::func_29CA()) {
    return;
  }

  self.var_4C84 = scripts\anim\battlechatter::func_4996();
}

func_1797() {
  self.var_4C84 scripts\anim\battlechatter::func_1808("action", "coverme");
}

func_17EF() {
  self.var_4C84 scripts\anim\battlechatter::func_1808("move", "combat");
}

func_17F0() {
  self.var_4C84 scripts\anim\battlechatter::func_1808("move", "noncombat");
}

func_17D3() {
  self.var_4C84 scripts\anim\battlechatter::func_17D1("reloading", "generic");
}

func_17F3(var_0) {
  if(!scripts\anim\battlechatter::func_29CA()) {
    return;
  }

  self.var_4C84 scripts\anim\battlechatter::func_17F2(var_0);
}

func_6314(var_0, var_1) {
  if(!scripts\anim\battlechatter::func_29CA()) {
    return;
  }

  var_2 = scripts\anim\battlechatter::func_4995("custom", "generic", 1);
  if(isDefined(var_0)) {
    var_2.var_698B = gettime() + var_0;
  }

  if(isDefined(var_1)) {
    var_2.type = var_1;
  } else {
    var_2.type = "custom";
  }

  self.var_3D4C["custom"] = undefined;
  self.var_3D4C["custom"] = var_2;
}