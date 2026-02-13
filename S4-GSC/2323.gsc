/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2323.gsc
*************************************************/

_id_3801() {
  while(!isDefined(level.players)) {
    wait 0.1;
  }
}

_id_6667(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_1 = var_0 scripts\cp\utility::getplayerdataloadoutgroup();
  var_2 = var_0 getplayerdata(level.loadoutsgroup, "squadMembers", "cpFieldUpgrade");
}

_id_6F26(var_0) {
  self notify("giving_class");
  _id_0945::_id_7F66();
  var_1 = scripts\cp\utility::getplayerdataloadoutgroup();
  var_2 = _id_073C::_id_2E8A();
  var_3 = "none";

  if(!scripts\cp\utility::_id_86C9()) {
    self setviewkickscale(0.5);

    for(var_4 = 0; var_4 < 3; var_4++) {
      var_5 = var_4;

      if(isDefined(var_0)) {
        var_6 = _id_073C::_id_EC69(level._id_3809, var_0, var_4);
      } else {
        var_6 = self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_2, "loadoutPerks", var_5);
      }

      if(isDefined(var_6)) {
        scripts\cp\utility::_id_6FC2(var_6);
      }
    }
  }

  _id_8067();
}

_id_6ECB() {
  self.class = "assault";
  scripts\cp\utility::_id_6FC2("specialty_fastreload");
}

_id_C37C() {
  scripts\cp\utility::_id_EDCE("specialty_fastreload");
}

_id_6EDD() {
  self.class = "crusader";
}

_id_C39B() {}

_id_106C8(var_0, var_1) {
  wait(var_1);
  scripts\cp\utility::_id_6FC2(var_0);
}

_id_6F5C() {
  self.class = "tank";
}

_id_C452() {}

_id_6F0D() {
  self.class = "medic";
}

_id_C406() {}

_id_6EF5() {
  self.class = "hunter";
  _id_0945::_id_C177();
}

_id_C3F1() {
  _id_0945::_id_C43B();
}

_id_6EE3() {
  self.class = "engineer";
}

_id_C3B1() {}

_id_6EDF() {
  var_0 = scripts\engine\utility::random(["medic", "tank", "crusader", "assault", "hunter", "engineer"]);

  switch (var_0) {
    case "medic":
      _id_6F0D();
      break;
    case "tank":
      _id_6F5C();
      break;
    case "crusader":
      _id_6EDD();
      break;
    case "assault":
      _id_6ECB();
      break;
    case "hunter":
      _id_6EF5();
    case "engineer":
      _id_6EE3();
      break;
  }
}

_id_8067() {
  var_0 = self;
  var_0 setplayerdata("cp", "CPSession", "skill_level", 1, 0);
  var_0 setplayerdata("cp", "CPSession", "skill_level", 2, 0);
  var_0 setplayerdata("cp", "CPSession", "skill_level", 3, 0);
  var_0 setplayerdata("cp", "CPSession", "skill_level", 4, 0);
  var_0 setplayerdata("cp", "CPSession", "skill_points", 0);
}

_id_C004() {
  foreach(var_1 in level.players) {
    var_1 setplayerdata("cp", "CPSession", "skill_level", 1, randomint(5));
    var_1 setplayerdata("cp", "CPSession", "skill_level", 2, randomint(5));
    var_1 setplayerdata("cp", "CPSession", "skill_level", 3, randomint(5));
    var_1 setplayerdata("cp", "CPSession", "skill_level", 4, randomint(5));
  }
}

_id_6F4F(var_0) {
  var_1 = self getplayerdata("cp", "CPSession", "skill_points");
  self setplayerdata("cp", "CPSession", "skill_points", var_1 + var_0);
}

_id_ED9E(var_0) {
  var_1 = self getplayerdata("cp", "CPSession", "skill_points");
  self setplayerdata("cp", "CPSession", "skill_points", var_1 - var_0);
}

_id_6FF0(var_0) {
  var_1 = self getplayerdata("cp", "CPSession", "skill_level", var_0);
  var_2 = self._id_DD79[var_0 - 1];
  _id_1018(var_2, 1);
}

_id_D188(var_0) {
  switch (var_0) {
    case "assault":
      var_1 = 1;
      break;
    case "tank":
      var_1 = 2;
      break;
    case "medic":
      var_1 = 3;
      break;
    case "hunter":
      var_1 = 4;
      break;
    default:
      var_1 = 0;
      break;
  }
}

_id_C313() {}

_id_1018(var_0, var_1) {}

_id_444F(var_0) {
  _id_6F26(var_0);
}

_id_C78D(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("disconnect");

  if(!istrue(var_0._id_10DA7)) {
    var_0 waittill("player_weapon_build_kit_initialized");
  }

  if(isDefined(var_0._id_10CEA[var_1])) {
    return makeweaponfromstring(var_0._id_10CEA[var_1]);
  } else {
    return var_2;
  }
}