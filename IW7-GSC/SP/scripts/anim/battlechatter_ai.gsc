/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\battlechatter_ai.gsc
*********************************************/

_id_185D(var_0) {
  self endon("death");

  if(!scripts\anim\battlechatter::_id_29CA()) {
    return;
  }
  if(self._id_3D4B) {
    return;
  }
  if(!isDefined(self._id_10AC8._id_3D4B) || !self._id_10AC8._id_3D4B)
    self._id_10AC8 scripts\anim\battlechatter::_id_9762();

  self._id_6552 = "infantry";
  self._id_376A = [];

  if(isPlayer(self) || scripts\engine\utility::player_is_in_jackal() && self == level._id_D127) {
    self._id_28CF = 0;
    self._id_6EE9 = 0;
    self.type = "human";
    return;
  }

  if(isDefined(self._id_29B8) && self._id_29B8) {
    self._id_28CF = 0;
    self._id_6EE9 = 0;
  } else {
    if(self.unittype == "c12") {
      self._id_28CF = 0;
      self._id_6552 = "c12";
      return;
    }

    if(self.unittype == "c8" || isDefined(self.asmname) && self.asmname == "seeker") {
      self._id_28CF = 0;
      self._id_6EE9 = 0;
      return;
    }

    if(self.team == "neutral") {
      self._id_6552 = undefined;
      self._id_28CF = 0;
      self._id_6EE9 = 0;
      return;
    }

    if(self.unittype == "c6") {
      self addaieventlistener("grenade danger");
      thread _id_29B6();
    }

    self._id_8C7E = _id_0A1E::_id_2356("Knobs", "head");
    self._id_EF82 = _id_0A1E::_id_2356("Knobs", "scripted_talking");
    self._id_504D = _id_0A1E::_id_2356("Knobs", "default_talking");
  }

  if(!isDefined(self.voice)) {
    return;
  }
  self._id_46BC = anim._id_46BD[self.voice];

  if(!isDefined(self._id_46BC)) {
    return;
  }
  _id_23CF();
  thread _id_1A54();
  _id_94E5();
  thread _id_1B06();
}

_id_23CF() {
  if(isDefined(self._id_EDB8)) {
    var_0 = tolower(self._id_EDB8);

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

    _id_F7BB();
    return;
    return;
    return;
    return;
    return;
    return;
    return;
    return;
    return;
  } else {
    if(isDefined(self._id_29B8) && self._id_29B8) {
      while(!isDefined(anim._id_13075) || !isDefined(anim._id_13075[self.voice]))
        wait 0.05;
    }

    _id_F7BB();
  }
}

_id_72C2() {
  if(!getdvarint("bcs_forceEnglish", 0))
    return 0;

  switch (level.script) {
    case "pmc_strike":
      return 1;
  }

  return 0;
}

_id_1B06() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isDefined(self.team)) {
    return;
  }
  var_0 = 0.5;
  wait(var_0);

  if(!scripts\engine\utility::player_is_in_jackal())
    thread _id_1A10();

  thread _id_1A0F();

  if(self.team == "allies") {
    wait(var_0);
    thread _id_1A0E();
  } else if((self.team == "axis" || self.team == "team3") && !_id_9D3A(self._id_46BC)) {
    thread _id_1A19();
    var_0 = 5.0;
  }

  if(isDefined(anim.player) && self.team == anim.player.team)
    thread _id_D085();

  wait(var_0);
  thread _id_1A07();
}

_id_9D3A(var_0) {
  if(var_0 == "UN" || var_0 == "JK")
    return 1;

  return 0;
}

_id_F7BB() {
  var_0 = anim._id_13075[self.voice];
  var_1 = var_0.size;
  var_2 = randomintrange(0, var_1);
  var_3 = var_2;

  for(var_4 = 0; var_4 <= var_1; var_4++) {
    if(var_0[(var_2 + var_4) % var_1].count < var_0[var_3].count)
      var_3 = (var_2 + var_4) % var_1;
  }

  thread _id_C19E(var_3);
  self.npcid = var_0[var_3].npcid;

  if(self.voice == "unitednationsfemale")
    self.npcid = "w" + self.npcid;
}

_id_C19E(var_0) {
  anim._id_13075[self.voice][var_0].count++;
  scripts\engine\utility::waittill_either("death", "removed from battleChatter");

  if(!scripts\anim\battlechatter::_id_29CA()) {
    return;
  }
  anim._id_13075[self.voice][var_0].count--;
}

_id_1A19() {
  self endon("death");
  self endon("removed from battleChatter");
  wait 2;

  for(;;) {
    if(distancesquared(self.origin, anim.player.origin) < 1048576) {
      if(isDefined(self._id_10AC8._id_B65C) && self._id_10AC8._id_B65C > 1)
        _id_181C("taunt", "hostileburst");
    }

    wait(randomfloatrange(2, 5));
  }
}

_id_1A07() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    scripts\anim\battlechatter::_id_CEE8();
    wait(0.3 + randomfloat(0.2));
  }
}

_id_1A54() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    self._id_29AD = scripts\anim\battlechatter::_id_7FD8();
    self._id_29B3 = scripts\anim\battlechatter::getrank();
    self waittill("set name and rank");
  }
}

_id_E11B(var_0) {
  if(scripts\anim\battlechatter::_id_29CA()) {
    if(_id_1A1B() || !isalive(self)) {
      if(isDefined(self)) {
        _id_1A0C();
        _id_1A0A();
      }
    }
  }

  if(isDefined(self)) {
    self._id_28CF = 0;
    self._id_3D4B = 0;
  }

  self notify("removed from battleChatter");

  if(isDefined(self)) {
    self._id_3D4C = undefined;
    self._id_BFA8 = undefined;
    self._id_BFA9 = undefined;
    self._id_9F6B = undefined;
    self._id_6552 = undefined;
    self._id_376A = undefined;
    self._id_46BC = undefined;
    self.npcid = undefined;
  }
}

_id_94E5() {
  self._id_3D4C = [];
  self._id_3D4C["threat"] = spawnStruct();
  self._id_3D4C["threat"]._id_698B = 0;
  self._id_3D4C["threat"].priority = 0.0;
  self._id_3D4C["response"] = spawnStruct();
  self._id_3D4C["response"]._id_698B = 0;
  self._id_3D4C["response"].priority = 0.0;
  self._id_3D4C["reaction"] = spawnStruct();
  self._id_3D4C["reaction"]._id_698B = 0;
  self._id_3D4C["reaction"].priority = 0.0;
  self._id_3D4C["inform"] = spawnStruct();
  self._id_3D4C["inform"]._id_698B = 0;
  self._id_3D4C["inform"].priority = 0.0;
  self._id_3D4C["order"] = spawnStruct();
  self._id_3D4C["order"]._id_698B = 0;
  self._id_3D4C["order"].priority = 0.0;
  self._id_3D4C["custom"] = spawnStruct();
  self._id_3D4C["custom"]._id_698B = 0;
  self._id_3D4C["custom"].priority = 0.0;
  self._id_BFA8 = gettime() + 50;
  self._id_BFA9["threat"] = 0;
  self._id_BFA9["reaction"] = 0;
  self._id_BFA9["response"] = 0;
  self._id_BFA9["inform"] = 0;
  self._id_BFA9["order"] = 0;
  self._id_BFA9["custom"] = 0;
  self._id_9F6B = 0;
  self._id_29BF = 0.0;
  self._id_1C8B = [];
  scripts\anim\battlechatter::_id_17A2("exposed");
  scripts\anim\battlechatter::_id_17A2("ai_contact_clock");
  scripts\anim\battlechatter::_id_17A2("ai_target_clock");

  if(self.team == "allies") {
    if(scripts\engine\utility::array_contains(anim._id_D3DD, self.voice)) {
      scripts\anim\battlechatter::_id_17A2("player_contact_clock");
      scripts\anim\battlechatter::_id_17A2("player_target_clock");
      scripts\anim\battlechatter::_id_17A2("player_cardinal");
      scripts\anim\battlechatter::_id_17A2("player_obvious");
      scripts\anim\battlechatter::_id_17A2("player_object_clock");
      scripts\anim\battlechatter::_id_17A2("player_location");
    }

    scripts\anim\battlechatter::_id_17A2("ai_location");
    scripts\anim\battlechatter::_id_17A2("generic_location");

    if(self.voice == "unitednations" || self.voice == "unitednationsfemale") {
      scripts\anim\battlechatter::_id_17A2("ai_obvious");
      scripts\anim\battlechatter::_id_17A2("ai_casual_clock");
      scripts\anim\battlechatter::_id_17A2("concat_location");
      scripts\anim\battlechatter::_id_17A2("concat_location");
      scripts\anim\battlechatter::_id_17A2("player_distance");
      scripts\anim\battlechatter::_id_17A2("player_target_clock_high");
      scripts\anim\battlechatter::_id_17A2("ai_distance");
      scripts\anim\battlechatter::_id_17A2("ai_target_clock_high");
    }
  }

  self._id_28CF = 0;

  if(isDefined(self._id_ED15) && self._id_ED15 || anim._id_29B7)
    self._id_28CF = level._id_28CF[self.team];

  self._id_6EE9 = 0;

  if(scripts\anim\battlechatter::_id_13528() && level._id_6EE9[self.team] == 1 && self != anim.player)
    self._id_6EE9 = 1;
  else
    self._id_6EE9 = 0;

  if(level._id_7410)
    scripts\sp\utility::_id_F3C0(1);
  else
    scripts\sp\utility::_id_F3C0(0);

  self._id_3D4B = 1;
}

_id_183F(var_0, var_1, var_2) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter::cansay("threat", var_0, var_2)) {
    return;
  }
  if(scripts\anim\battlechatter::_id_117ED(var_1) && !isPlayer(var_1)) {
    return;
  }
  var_3 = scripts\anim\battlechatter::_id_4995("threat", var_0, var_2);

  switch (var_0) {
    case "infantry":
      var_3._id_117B9 = var_1;
      break;
    case "acquired":
      var_3._id_117B9 = var_1;
      break;
  }

  if(isDefined(var_1._id_10AC8))
    self._id_10AC8 scripts\anim\battlechatter::_id_12E7C(var_1._id_10AC8._id_10AEE, self);

  self._id_3D4C["threat"] = undefined;
  self._id_3D4C["threat"] = var_3;
}

_id_1820(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread _id_1821(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_1821(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  self endon("removed from battleChatter");
  self endon("responseEvent_failsafe");
  thread _id_E2A1(var_2);
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
  if(!isPlayer(var_2)) {
    if(scripts\anim\battlechatter::_id_9FC7(var_2))
      return;
  }

  var_7 = scripts\anim\battlechatter::_id_4995("response", var_0, var_3);

  if(isDefined(var_4))
    var_7._id_E1A1 = var_4;

  if(isDefined(var_5))
    var_7.location = var_5;

  var_7._id_E29D = var_2;
  var_7.modifiedspawnpoints = var_1;
  self._id_3D4C["response"] = undefined;
  self._id_3D4C["response"] = var_7;
}

_id_E2A1(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  var_0 endon("death");
  var_0 endon("done speaking");
  var_0 endon("cancel speaking");
  wait 25;
  self notify("responseEvent_failsafe");
}

_id_17D2(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter::cansay("inform", var_0, var_3, var_1)) {
    return;
  }
  var_5 = scripts\anim\battlechatter::_id_4995("inform", var_0, var_3);

  switch (var_0) {
    case "reloading":
      var_5.modifiedspawnpoints = var_1;
      var_5._id_94C2 = var_2;
      break;
    case "killfirm":
      if(isDefined(var_4))
        var_5._id_117DE = var_4;
    default:
      var_5.modifiedspawnpoints = var_1;
  }

  self._id_3D4C["inform"] = undefined;
  self._id_3D4C["inform"] = var_5;
}

_id_181C(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isDefined(self._id_3D4C)) {
    return;
  }
  if(!isDefined(anim._id_68AF) || !isDefined(anim._id_68B5)) {
    return;
  }
  var_4 = scripts\anim\battlechatter::_id_4995("reaction", var_0, var_3);
  var_4._id_DD60 = var_2;
  var_4.modifiedspawnpoints = var_1;
  self._id_3D4C["reaction"] = undefined;
  self._id_3D4C["reaction"] = var_4;
}

_id_1809(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter::cansay("order", var_0, var_3, var_1)) {
    return;
  }
  var_4 = scripts\anim\battlechatter::_id_4995("order", var_0, var_3);
  var_4.modifiedspawnpoints = var_1;
  var_4._id_C6E5 = var_2;
  self._id_3D4C["order"] = undefined;
  self._id_3D4C["order"] = var_4;
}

_id_81C6(var_0, var_1) {
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

    if(self._id_10AEE != "jackal_allies") {
      if(!isDefined(var_7) || isDefined(var_7) && !isDefined(var_7.voice))
        continue;
    } else if(!isDefined(var_7)) {
      continue;
    }
    if(!isDefined(var_7._id_6552) || self._id_10AEE == "jackal_allies" && isDefined(var_7.voice)) {
      continue;
    }
    var_5[var_5.size] = var_0[var_6];
  }

  if(var_5.size == 0) {
    wait(var_1);
    return var_5;
  }

  var_5 = sortbydistance(var_5, anim.player.origin);
  var_8 = [];
  var_9 = [];
  var_10 = 0;

  foreach(var_12 in var_5) {
    if(isDefined(var_12) && _id_117E8(var_12)) {
      var_13 = var_12 scripts\anim\battlechatter::getlocation();

      if(isDefined(var_13) && !scripts\anim\battlechatter::location_called_out_recently(var_13))
        var_8[var_8.size] = var_12;
      else
        var_9[var_9.size] = var_12;
    }

    var_10++;

    if(var_10 >= var_4) {
      wait 0.05;
      var_10 = 0;
    }
  }

  var_5 = [];

  foreach(var_16 in var_8)
  var_5[var_5.size] = var_16;

  foreach(var_16 in var_9)
  var_5[var_5.size] = var_16;

  return var_5;
}

_id_117E8(var_0) {
  if(distancesquared(anim.player.origin, var_0.origin) > level._id_29BE)
    return 0;

  if(!anim.player scripts\anim\battlechatter::_id_6632(var_0)) {
    if(scripts\engine\utility::player_is_in_jackal() && (isDefined(level.player._id_58B7) && level.player._id_58B7 == var_0))
      return 1;
    else
      return 0;
  }

  return 1;
}

_id_10AFB() {
  anim endon("battlechatter disabled");
  anim endon("squad deleted " + self._id_10AEE);

  for(;;) {
    while(!isDefined(anim._id_29B7) || !anim._id_29B7)
      wait 0.05;

    while(anim._id_29B7) {
      if(self.team == "allies") {
        if(self._id_10AEE == "jackal_allies") {
          var_0 = level._id_A056._id_1630;
          var_1 = _id_81C6(var_0, 0.5);
        } else
          var_1 = _id_81C6(getaiarray("axis", "team3"), 0.5);
      } else if(self.team == "team3")
        var_1 = _id_81C6(getaiarray("allies", "axis"), 0.5);
      else {
        wait 0.5;

        if(self._id_10AEE == "jackal_axis") {
          var_0 = level._id_A056._id_1630;
          var_1 = _id_81C6(var_0, 0.5);
        } else {
          var_1 = getaiarray("allies", "team3");
          var_1[var_1.size] = anim.player;
        }
      }

      if(!var_1.size) {
        wait 0.1;
        continue;
      }

      var_2 = [];

      foreach(var_13, var_4 in self._id_B661) {
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
            if(var_6 == anim.player)
              var_6 = level._id_D127;
          } else if(isDefined(var_4._id_29B8) && var_4._id_29B8) {
            continue;
          }
          if(!isDefined(var_6)) {
            if(var_12 == 0)
              var_1 = [];

            continue;
          }

          if(!isalive(var_6)) {
            continue;
          }
          if(!isDefined(var_6._id_6552)) {
            continue;
          }
          if(!var_4 _id_29A2(var_6)) {
            if(scripts\engine\utility::player_is_in_jackal() && var_6 == level._id_D127 || !scripts\engine\utility::player_is_in_jackal() && isPlayer(var_6)) {
              continue;
            }
            if(!isDefined(var_6.team) || isDefined(var_6.team) && var_6.team == anim.player.team) {
              continue;
            }
            if(!anim.player _id_29A2(var_6) && !scripts\engine\utility::player_is_in_jackal())
              continue;
          }

          var_7 = var_4 _id_810F();

          if(isDefined(var_7))
            var_4 _id_17D2("incoming", "seeker", undefined, 0.9);
          else if(isDefined(var_4.bt) && isDefined(var_4.bt._id_DB05))
            var_4 _id_181C("danger", undefined, var_4.bt._id_DB05);
          else
            var_4 _id_183F(var_6._id_6552, var_6);

          var_2[var_2.size] = var_6;
          var_8 = [];
          var_7 = undefined;

          foreach(var_10 in var_1) {
            if(var_10 != var_6)
              var_8[var_8.size] = var_10;
          }

          var_1 = var_8;
          break;
        }

        wait 0.05;
      }

      wait 0.05;
    }
  }
}

_id_1A1B() {
  if(isDefined(self.asmname) && self.asmname == "jackal")
    return 1;

  return 0;
}

_id_29A2(var_0) {
  if(isDefined(level._id_D127)) {
    if(!scripts\engine\utility::player_is_in_jackal() && self == level._id_D127)
      return 0;
  }

  if(_id_1A1B() || scripts\engine\utility::player_is_in_jackal() && self == level._id_D127) {
    if(var_0 _id_1A1B()) {
      var_1 = vectorNormalize(var_0.origin - self.origin);
      var_2 = anglesToForward(self.angles);
      var_3 = vectordot(var_2, var_1);

      if(var_3 > 0.6)
        return 1;
    }
  } else if(self == level.player) {
    if(scripts\sp\utility::_id_CFAC(var_0))
      return 1;
  } else if(self cansee(var_0))
    return 1;

  return 0;
}

_id_10AE7() {
  anim endon("battlechatter disabled");
  anim endon("squad deleted " + self._id_10AEE);

  if(self._id_10AEE != "jackal_allies") {
    return;
  }
  while(!isDefined(anim._id_29B7) || !anim._id_29B7)
    wait 0.05;

  var_0 = undefined;
  var_1 = undefined;

  for(;;) {
    while(anim._id_29B7) {
      foreach(var_3 in self._id_B661) {
        if(var_3 != anim.player) {
          if(isDefined(var_3.bt) && isDefined(var_3.bt._id_A533) && var_3.bt._id_A533) {
            var_0 = "flare";
            var_1 = var_3;
            break;
          } else if(isDefined(var_3._id_B8A4) && var_3._id_B8A4.size > 0) {
            var_0 = "missile";
            var_1 = var_3;
            break;
          } else if(var_3 scripts\sp\utility::_id_65DF("jackal_firing")) {
            if(var_3 scripts\sp\utility::_id_65DB("jackal_firing")) {
              var_0 = "guns";
              var_1 = var_3;
              break;
            }
          }
        } else {
          if(!level.player scripts\sp\utility::_id_65DB("disable_jackal_flares")) {
            if(var_3._id_6E9C.count < var_3._id_6E9C._id_B417 && var_3._id_6E9C._id_A989 < gettime() - 50) {
              var_0 = "flare";
              var_1 = var_3;
              break;
            }
          }

          if(!level.player scripts\sp\utility::_id_65DB("disable_jackal_missiles")) {
            if(var_3 scripts\sp\utility::_id_65DB("player_jackal_missile")) {
              var_0 = "missile";
              var_1 = var_3;
              break;
            }
          }
        }
      }

      if(isDefined(var_1)) {
        var_1 thread _id_67CF(var_0);
        var_1 = undefined;
        wait(randomintrange(5, 10));
        continue;
      }

      wait 0.5;
    }

    wait 0.5;
  }

  wait 1.0;
}

_id_810F() {
  if(!isDefined(level._id_F10A._id_1633) || isDefined(level._id_F10A._id_1633) && level._id_F10A._id_1633.size < 1) {
    return;
  }
  if(scripts\anim\battlechatter::_id_9B42(self)) {
    return;
  }
  var_0 = undefined;

  foreach(var_2 in level._id_F10A._id_1633) {
    if(var_2.team == self.team) {
      continue;
    }
    var_3 = distancesquared(self.origin, var_2.origin);

    if(var_3 < 360000 && (isDefined(var_2.bt._id_F15D) && var_2.bt._id_F15D != self)) {
      var_0 = var_2;
      break;
    }
  }

  return var_0;
}

_id_1A0C() {
  var_0 = self.attacker;

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(self.unittype) && self.unittype == "seeker") {
    return;
  }
  if(isDefined(self._id_10AC8) && isDefined(var_0._id_10AC8) && self._id_10AC8 == var_0._id_10AC8) {
    return;
  }
  scripts\engine\utility::array_thread(self._id_10AC8._id_B661, ::_id_1A0B, self);

  if(!isDefined(var_0._id_28CF)) {
    return;
  }
  if(isalive(var_0) && !isPlayer(var_0) && isDefined(var_0._id_10AC8) && var_0._id_28CF) {
    if(isDefined(var_0._id_376A) && isDefined(var_0._id_376A[var_0._id_10AC8._id_10AEE]))
      var_0._id_376A[var_0._id_10AC8._id_10AEE] = undefined;

    if(!isDefined(var_0._id_6552)) {
      return;
    }
    if(!var_0 scripts\anim\battlechatter::is_in_callable_location()) {
      return;
    }
    foreach(var_2 in self._id_10AC8._id_B661) {
      if(var_2 == anim.player) {
        continue;
      }
      if(gettime() > var_2.lastenemysighttime + 2000) {
        continue;
      }
      var_2 _id_183F(var_0._id_6552, var_0);
    }
  }
}

_id_1A0B(var_0) {
  if(!isalive(self)) {
    return;
  }
  if(scripts\sp\utility::_id_D123()) {
    return;
  }
  if(isDefined(self.unittype) && self.unittype == "c6") {
    return;
  }
  self endon("death");
  self endon("removed from battleChatter");
  self notify("aiDeathEventThread");
  self endon("aiDeathEventThread");

  if(self == anim.player) {
    if(isDefined(var_0) && !anim.player _id_29A2(var_0))
      return;
  }

  wait 1.2;
  _id_181C("casualty", "generic", self, 0.9);
}

_id_1A0A() {
  var_0 = self.attacker;
  var_1 = undefined;

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.team) && var_0.team == "allies" && (isDefined(var_0.unittype) && var_0.unittype == "c12")) {
    var_2 = scripts\sp\utility::_id_78BB(var_0.origin, anim.player._id_10AC8._id_B661, 5000);
    var_1 = "ally_c12_kill";

    if(isDefined(var_2))
      var_3 = var_2;
  } else if(scripts\engine\utility::player_is_in_jackal()) {
    foreach(var_5 in anim._id_10AF9["jackal_allies"]._id_B661) {
      if(isDefined(var_5._id_4BC7) && var_5._id_4BC7 == self) {
        var_0 = var_5;
        var_1 = "jackal";
      }
    }
  } else if(!isalive(var_0) || !issentient(var_0) && var_0 != anim.player || !isDefined(var_0._id_10AC8)) {
    return;
  }
  if(!isDefined(var_0._id_46BC)) {
    return;
  }
  if(var_0._id_46BC == "UN" || var_0._id_46BC == "JK") {
    if(!isDefined(var_1))
      var_1 = self.unittype;

    if(isDefined(var_1))
      var_0 thread _id_1A1C(var_1);
  }
}

_id_1A1C(var_0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(var_0 == "civilian") {
    return;
  }
  wait 1.2;
  _id_17D2("killfirm", "generic", undefined, undefined, var_0);
}

_id_1A10() {
  self endon("death");
  self endon("removed from battleChatter");
  var_0 = undefined;

  for(;;) {
    self waittill("grenade danger", var_1);

    if(getdvarint("bcs_enable") == 0) {
      continue;
    }
    if(isDefined(var_1)) {
      var_0 = _id_1A11(var_1);

      if(!isDefined(var_0))
        continue;
    } else if(isDefined(self.unittype) && self.unittype == "c6")
      var_0 = "frag";
    else
      continue;

    _id_17D2("incoming", var_0);
  }
}

_id_1A11(var_0) {
  var_1 = undefined;

  if(var_0.model == "frag_grenade_wm")
    var_1 = "frag";

  if(var_0.model == "emp_grenade_wm")
    var_1 = "shock";

  if(var_0.model == "anti_grav_grenade_wm")
    var_1 = "ant";

  return var_1;
}

_id_29B6() {
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

    wait 5.0;
  }
}

_id_1A0E() {
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
    if(gettime() < self.a._id_C888 + 4000) {
      continue;
    }
    _id_1820("ack", "yes", anim.player, 1.0);
  }
}

_id_67D2(var_0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(isDefined(self.unittype) && self.unittype == "c6") {
    return;
  }
  if(!scripts\anim\battlechatter::_id_29CA()) {
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
  if(!_id_BE58()) {
    return;
  }
  var_1 = scripts\anim\battlechatter::_id_80EA(24, 1024, "response");

  if(self.team != "axis" && self.team != "team3") {
    if(!isDefined(var_1))
      var_1 = anim.player;
    else if(randomint(100) < anim._id_68AE["moveEvent"]["ordertoplayer"])
      var_1 = anim.player;
  }

  if(self._id_440E > 0.0) {
    if(randomint(100) < anim._id_68AE["moveEvent"]["coverme"])
      _id_1809("action", "coverme", var_1);
    else
      _id_1809("move", "combat", var_1);
  } else if(_id_BE59()) {
    if(gettime() - self.starttime > 3000)
      _id_1809("move", "noncombat", var_1);
  }
}

_id_BE58() {
  if(self._id_46BC == "SS")
    return 0;

  return 1;
}

_id_BE59() {
  if(self._id_46BC == "UN")
    return 1;

  return 0;
}

_id_1A0F() {
  self endon("death");
  self endon("removed from battleChatter");

  if(isDefined(self.unittype) && self.unittype == "c6") {
    return;
  }
  for(;;) {
    level waittill("follow order", var_0);

    if(!scripts\anim\battlechatter::_id_29CA()) {
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
    if(distancesquared(self.origin, var_0.origin) < 360000)
      _id_1820("ack", "yes", var_0, 0.9);
  }
}

_id_D085() {
  self endon("death");
  self endon("removed from battleChatter");

  if(isDefined(self.unittype) && self.unittype == "c6") {
    return;
  }
  thread _id_D086();

  for(;;) {
    self waittill("bulletwhizby", var_0, var_1);

    if(!scripts\anim\battlechatter::_id_29CA()) {
      continue;
    }
    if(!isPlayer(var_0)) {
      if(anim._id_46BD[self.voice] == "GM" && scripts\anim\battlechatter::cansay("reaction", "takingfire", 1.0, undefined))
        _id_181C("takingfire", undefined, var_0, 1.0);

      continue;
    }
  }
}

_id_D084() {
  _id_181C("friendlyfire", undefined, anim.player, 1.0);
}

_id_D086() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    self waittill("damage", var_0, var_1, var_0, var_0, var_2);

    if(isDefined(var_1) && var_1 == anim.player) {
      if(_id_4D04(var_2))
        _id_D084();
    }
  }
}

_id_4D04(var_0) {
  if(!isDefined(var_0))
    return 0;

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

_id_7414(var_0, var_1) {
  var_2 = 65536;
  var_3 = 42;

  if(distancesquared(var_0.origin, self.origin) < var_2)
    return 0;

  if(var_1 > var_3)
    return 0;

  return 1;
}

_id_67D4() {
  self endon("death");
  self endon("removed from battleChatter");

  if(isDefined(self.unittype) && self.unittype == "c6") {
    return;
  }
  if(!scripts\anim\battlechatter::_id_29CA()) {
    return;
  }
  _id_17D2("reloading", "generic");
}

_id_67D1() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter::_id_29CA())
    return 0;

  if(!isDefined(self.enemy))
    return 0;

  return 0;
}

_id_67D0() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter::_id_29CA()) {
    return;
  }
  if(!isDefined(self.enemy))
    return;
}

_id_67D5() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter::_id_29CA()) {
    return;
  }
  _id_17D2("suppressed", "generic");
}

_id_67CF(var_0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter::_id_29CA()) {
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

  _id_17D2("attack", var_2);

  if(var_1) {
    if(randomint(100) < 25) {
      wait(randomfloatrange(1, 2));

      if(isalive(self))
        thread _id_181C("movement");
    }
  }
}

_id_4C3A() {
  var_0 = [];
  var_0[var_0.size] = "order_move_combat";
  var_0[var_0.size] = "order_move_noncombat";
  var_0[var_0.size] = "order_action_coverme";
  var_0[var_0.size] = "inform_reloading";
  level._id_4C81 = var_0;
}

_id_4C3C(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_4C81) {
    if(var_3 == var_0) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

_id_7B7E(var_0) {
  return anim._id_29B1 + "custom battlechatter phrase '" + var_0 + "' isn't valid.look at _utility::custom_battlechatter_init_valid_phrases(), or the util script documentation for custom_battlechatter(), for a list of valid phrases.";
}

_id_7854(var_0) {
  return anim._id_29B1 + "AI at origin " + self.origin + "wasn't able to play custom battlechatter because his nationality is '" + self._id_46BC + "'.";
}

_id_4C3B(var_0) {
  if(!isDefined(level._id_4C81))
    _id_4C3A();

  var_0 = tolower(var_0);

  if(!_id_4C3C(var_0)) {
    var_1 = _id_7B7E(var_0);
    return 0;
  }

  var_2 = scripts\anim\battlechatter::_id_80EA(24, 512, "response");
  _id_2A62();

  switch (var_0) {
    case "order_move_combat":
      if(!_id_BE58())
        return 0;

      scripts\anim\battlechatter::_id_128A8(self._id_4C84, var_2);
      _id_17EF();
      break;
    case "order_move_noncombat":
      if(!_id_BE59())
        return 0;

      _id_17F0();
      break;
    case "order_action_coverme":
      scripts\anim\battlechatter::_id_128A8(self._id_4C84, var_2);
      _id_1797();
      break;
    case "inform_reloading":
      _id_17D3();
      break;
    default:
      var_1 = _id_7B7E(var_0);
      return 0;
  }

  _id_6314(2000);
  return 1;
}

_id_2A62() {
  if(!scripts\anim\battlechatter::_id_29CA()) {
    return;
  }
  self._id_4C84 = scripts\anim\battlechatter::_id_4996();
}

_id_1797() {
  self._id_4C84 scripts\anim\battlechatter::_id_1808("action", "coverme");
}

_id_17EF() {
  self._id_4C84 scripts\anim\battlechatter::_id_1808("move", "combat");
}

_id_17F0() {
  self._id_4C84 scripts\anim\battlechatter::_id_1808("move", "noncombat");
}

_id_17D3() {
  self._id_4C84 scripts\anim\battlechatter::_id_17D1("reloading", "generic");
}

_id_17F3(var_0) {
  if(!scripts\anim\battlechatter::_id_29CA()) {
    return;
  }
  self._id_4C84 scripts\anim\battlechatter::_id_17F2(var_0);
}

_id_6314(var_0, var_1) {
  if(!scripts\anim\battlechatter::_id_29CA()) {
    return;
  }
  var_2 = scripts\anim\battlechatter::_id_4995("custom", "generic", 1.0);

  if(isDefined(var_0))
    var_2._id_698B = gettime() + var_0;

  if(isDefined(var_1))
    var_2.type = var_1;
  else
    var_2.type = "custom";

  self._id_3D4C["custom"] = undefined;
  self._id_3D4C["custom"] = var_2;
}