/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3832.gsc
**************************************/

_id_FE04(var_0, var_1) {
  level _id_0EFB::_id_FE05();

  if(!isDefined(level._id_FD6E.spawners))
    level._id_FD6E.spawners = [];

  if(!isDefined(level._id_FD6E._id_1087F))
    level._id_FD6E._id_1087F = [];

  if(!isDefined(level._id_FD6E._id_1087D))
    level._id_FD6E._id_1087D = [];

  if(!isDefined(level._id_FD6E._id_1912))
    level._id_FD6E._id_1912 = [];

  level._id_FD6E.spawners[var_0] = [];
  level._id_FD6E.spawners[var_0] = getspawnerarray(var_0);
  scripts\engine\utility::array_thread(level._id_FD6E.spawners[var_0], scripts\sp\utility::_id_1747, ::_id_FDFE);
  level._id_FD6E._id_1087D[var_0] = level._id_FD6E.spawners[var_0];

  foreach(var_3 in level._id_FD6E._id_1087D[var_0]) {
    if(!isDefined(var_3.script_parameters)) {
      level._id_FD6E._id_1087D[var_0] = scripts\engine\utility::array_remove(level._id_FD6E._id_1087D[var_0], var_3);
      continue;
    }

    if(var_3.script_parameters != "female")
      level._id_FD6E._id_1087D[var_0] = scripts\engine\utility::array_remove(level._id_FD6E._id_1087D[var_0], var_3);
  }

  if(level._id_FD6E._id_1087D[var_0].size < 1)
    level._id_FD6E._id_1087D[var_0] = undefined;

  level._id_FD6E._id_1087F[var_0] = level._id_FD6E.spawners[var_0];

  foreach(var_3 in level._id_FD6E._id_1087F[var_0]) {
    if(isDefined(var_3.script_parameters) && var_3.script_parameters != "male")
      level._id_FD6E._id_1087F[var_0] = scripts\engine\utility::array_remove(level._id_FD6E._id_1087F[var_0], var_3);
  }

  if(level._id_FD6E._id_1087F[var_0].size < 1)
    level._id_FD6E._id_1087F[var_0] = undefined;

  if(isDefined(var_1)) {
    if(issubstr(var_1, "female"))
      return level._id_FD6E._id_1087D[var_0];

    if(issubstr(var_1, "male"))
      return level._id_FD6E._id_1087F[var_0];
    else
      return level._id_FD6E.spawners[var_0];
  } else
    return level._id_FD6E.spawners[var_0];
}

#using_animtree("generic_human");

_id_FD9E() {
  return % body;
}

_id_FE01(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return _id_FDFC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, "male");
}

_id_FDFD(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return _id_FDFC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, "female");
}

_id_FDFC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  var_8 = 0;

  if(isstring(var_1) && var_1 == "homebase") {
    var_8 = 1;
    var_1 = (0, 0, 0);
  }

  if(!isDefined(var_2))
    var_2 = "default";

  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_4))
    var_4 = 0;

  if(var_4 && var_3) {}

  if(!isDefined(var_5))
    var_5 = 0;

  if(!isDefined(var_6))
    var_6 = 1;

  var_9 = undefined;
  var_10 = _id_0EFB::_id_7D7A(var_1);
  level _id_FE04(var_0, var_7);
  var_9 = undefined;
  var_11 = 1;
  var_12 = 1;

  for(;;) {
    if(var_11 > 10) {
      if(var_12 > 3)
        return undefined;

      level _id_FE04(var_0, var_7);
    }

    var_11++;
    var_12++;
    var_13 = level._id_FD6E.spawners[var_0];

    if(isDefined(var_7)) {
      if(issubstr(var_7, "female")) {
        if(isDefined(level._id_FD6E._id_1087D[var_0]))
          var_13 = level._id_FD6E._id_1087D[var_0];
      } else if(issubstr(var_7, "male")) {
        if(isDefined(level._id_FD6E._id_1087F[var_0]))
          var_13 = level._id_FD6E._id_1087F[var_0];
      }
    }

    foreach(var_15 in var_13) {
      if(var_2 == "cheap") {
        var_9 = _id_FDC1(var_15, var_5);
        break;
      }

      if(!isDefined(var_15._id_EFE0) || var_15._id_EFE0 != gettime()) {
        var_15._id_EFE0 = gettime();
        var_9 = var_15 scripts\sp\utility::_id_10619(1);
        break;
      }
    }

    if(isDefined(var_9)) {
      var_9.goalradius = 4;
      break;
    }

    scripts\engine\utility::waitframe();
  }

  var_17 = getsubstr(var_0, 8);

  switch (var_17) {
    case "salter_dirty_wh":
    case "salter":
      level._id_EA2C = var_9;
      var_9._id_1FBB = "salter";
      var_9._id_134C3 = "yellow";
      var_9.gender = "female_1";
      var_9 thread _id_FDFF();
      break;
    case "salter_dress":
      level._id_EA2C = var_9;
      var_9._id_1FBB = "salter";
      var_9._id_134C3 = "yellow";
      var_9.gender = "female_1";
      break;
    case "salter_dirty":
      level._id_EA2C = var_9;
      var_9._id_1FBB = "salter";
      var_9._id_134C3 = "yellow";
      var_9.gender = "female_1";
      break;
    case "ethan":
      level._id_6754 = var_9;
      var_9._id_1FBB = "ethan";
      var_9._id_134C3 = "blue";
      var_9.gender = "c6";
      break;
    case "omar":
      level._id_C47F = var_9;
      var_9._id_1FBB = "omar";
      var_9._id_134C3 = "green";
      var_9 thread _id_FDFF();
      var_9.gender = "male_1";
      break;
    case "omar_casual":
      level._id_C47F = var_9;
      var_9._id_1FBB = "omar";
      var_9._id_134C3 = "green";
      var_9.gender = "male_1";
      break;
    case "admiral":
      level._id_188A = var_9;
      var_9._id_1FBB = "admiral";
      var_9._id_134C3 = "purple";
      var_9.gender = "male_1";
      break;
    case "mac":
      level._id_B11D = var_9;
      var_9._id_1FBB = "mac";
      var_9._id_134C3 = "cyan";
      var_9.gender = "female_1";
      var_9 thread _id_FDFF();
      break;
    case "brooks":
      level._id_30F6 = var_9;
      var_9._id_1FBB = "brooks";
      var_9 thread _id_FDFF();
      var_9.gender = "male_1";
      break;
    case "brooks_casual":
      level._id_30F6 = var_9;
      var_9._id_1FBB = "brooks";
      var_9.gender = "male_1";
      break;
    case "kash":
      level._id_A538 = var_9;
      level._id_FDC3 = var_9;
      var_9._id_1FBB = "kash";
      var_9 thread _id_FDFF();
      var_9.gender = "male_1";
      break;
    case "kash_casual":
      level._id_A538 = var_9;
      level._id_FDC3 = var_9;
      var_9._id_1FBB = "kash";
      var_9.gender = "male_1";
      break;
    case "boggs":
      level._id_2C23 = var_9;
      var_9 thread _id_FDFF();
      var_9.gender = "male_1";
      break;
    case "nunez":
      level._id_C24B = var_9;
      var_9._id_1FBB = "nunez";
      var_9.gender = "female_1";
      break;
    case "nunez_casual":
      level._id_C24B = var_9;
      var_9._id_1FBB = "nunez";
      var_9.gender = "female_1";
      break;
    case "marcus":
      level._id_B33A = var_9;
      var_9._id_1FBB = "marcus";
      var_9.gender = "male_1";
      break;
    case "gibson":
      level._id_828C = var_9;
      var_9._id_1FBB = "gibson";
      var_9.gender = "female_1";
      break;
    case "sahora":
      level._id_EA29 = var_9;
      var_9._id_1FBB = "sahora";
      var_9 scripts\sp\utility::_id_DC45("raise");
      var_9.gender = "male_1";
      break;
    case "griff":
      level._id_8604 = var_9;
      var_9._id_1FBB = "griff";
      var_9.gender = "male_1";
      break;
    case "gator":
      level._id_76FB = var_9;
      var_9._id_1FBB = "gator";
      var_9.gender = "male_1";
      break;
    case "sotomura":
      level._id_1044B = var_9;
      var_9._id_1FBB = "sotomura";
      var_9._id_907D = _id_0EFB::_id_EFDB("boats");
      var_9.gender = "female_1";
      break;
    case "sipes":
      level._id_10214 = var_9;
      var_9._id_1FBB = "sipes";
      var_9._id_907D = _id_0EFB::_id_EFDB("boats");
      var_9.gender = "male_1";
      break;
    case "comms":
      level._id_4451 = var_9;
      var_9._id_1FBB = "comms";
      var_9._id_907D = _id_0EFB::_id_EFDB("comms");
      var_9.gender = "female_1";
      break;
    case "drop_officer":
      level._id_5CFC = var_9;
      var_9._id_1FBB = "drop_officer";
      var_9._id_907D = _id_0EFB::_id_EFDB("drop");
      var_9.gender = "female_1";
      break;
    case "ferran":
      level._id_6BD5 = var_9;
      var_9._id_1FBB = "ferran";
      var_9._id_134C3 = "purple";
      var_9.gender = "female_1";
      break;
    case "twoone":
      level._id_12ADD = var_9;
      var_9._id_1FBB = "twoone";
      var_9.gender = "male_1";
      break;
    case "kloos":
      level._id_A6F4 = var_9;
      var_9._id_1FBB = "kloos";
      var_9.gender = "male_1";
      break;
    case "vr_user":
      level._id_1356A = var_9;
      var_9._id_1FBB = "vr_user";
      var_9.gender = "female_1";
      break;
    case "bridge_ftl1":
      level._id_3014 = var_9;
      var_9._id_907D = _id_0EFB::_id_EFDB("ftl1");
      var_9._id_1FBB = "ftl1";
      var_9.gender = "female_1";
      break;
    case "bridge_ftl2":
      level._id_3015 = var_9;
      var_9._id_907D = _id_0EFB::_id_EFDB("ftl2");
      var_9._id_1FBB = "ftl2";
      var_9.gender = "male_1";
      break;
    case "bridge_ftl3":
      level._id_3016 = var_9;
      var_9._id_907D = _id_0EFB::_id_EFDB("ftl3");
      var_9._id_1FBB = "ftl3";
      var_9.gender = "male_2";
      break;
    case "bridge_tac1":
      level._id_30C0 = var_9;
      var_9._id_907D = _id_0EFB::_id_EFDB("tac1");
      var_9._id_1FBB = "tac1";
      var_9.gender = "male_3";
      break;
    case "bridge_tac2":
      level._id_30C1 = var_9;
      var_9._id_907D = _id_0EFB::_id_EFDB("tac2");
      var_9._id_1FBB = "tac2";
      var_9.gender = "male_1";
      break;
    case "bridge_tac3":
      level._id_30C2 = var_9;
      var_9._id_907D = _id_0EFB::_id_EFDB("tac3");
      var_9._id_1FBB = "tac3";
      var_9.gender = "male_2";
      break;
    case "bridge_tac4":
      level._id_30C4 = var_9;
      var_9._id_907D = _id_0EFB::_id_EFDB("tac4");
      var_9._id_1FBB = "tac4";
      var_9.gender = "female_3";
      break;
    case "bridge_sys1":
      level._id_30B9 = var_9;
      var_9._id_907D = _id_0EFB::_id_EFDB("sys1");
      var_9._id_1FBB = "sys1";
      var_9.gender = "male_3";
      break;
    case "bridge_sys2":
      level._id_30BB = var_9;
      var_9._id_907D = _id_0EFB::_id_EFDB("sys2");
      var_9._id_1FBB = "sys2";
      var_9.gender = "male_1";
      break;
    case "bridge_sys3":
      level._id_30BD = var_9;
      var_9._id_907D = _id_0EFB::_id_EFDB("sys3");
      var_9._id_1FBB = "sys3";
      var_9.gender = "female_3";
      break;
  }

  if(var_8)
    var_10 = var_9._id_907D;

  if(!isDefined(var_9._id_9B89)) {
    var_9 _meth_80F1(var_10.origin, var_10.angles);
    var_9 orientmode("face angle", var_10.angles[1]);
    scripts\engine\utility::waitframe();
    var_9 setgoalpos(var_10.origin);
  } else {
    var_9.origin = var_10.origin;
    var_9.angles = var_10.angles;
  }

  level._id_FD6E._id_1912["all"] = scripts\engine\utility::add_to_array(level._id_FD6E._id_1912["all"], var_9);

  if(isDefined(var_10._id_ECE7))
    level._id_FD6E._id_1912[var_10._id_ECE7] = scripts\engine\utility::add_to_array(level._id_FD6E._id_1912[var_10._id_ECE7], var_9);
  else if(isDefined(var_9._id_ECE7))
    level._id_FD6E._id_1912[var_9._id_ECE7] = scripts\engine\utility::add_to_array(level._id_FD6E._id_1912[var_9._id_ECE7], var_9);

  level thread _id_0EFB::_id_FD72(var_9);

  if(var_3 && scripts\sp\interaction::_id_9C26(var_10)) {
    if(isDefined(var_10._id_EE92)) {
      if(issubstr(var_10._id_EE92, "opsmap"))
        var_9 thread scripts\sp\interaction::_id_CD50(var_10._id_EE92);
      else {
        var_9._id_D6E2 = var_9 _id_0EF1::_id_789F();
        var_18 = var_9._id_D6E2[0];

        if(isDefined(var_10.script_parameters) && soundexists(var_10.script_parameters))
          var_18 = var_10.script_parameters;

        var_9 thread scripts\sp\interaction::_id_CE18(var_10._id_EE92, var_18, var_9._id_D6E2);
      }
    } else {
      var_9._id_D6E2 = var_9 _id_0EF1::_id_789F();
      var_18 = var_9._id_D6E2[0];

      if(isDefined(var_10.script_parameters) && soundexists(var_10.script_parameters))
        var_18 = var_10.script_parameters;

      var_9 thread scripts\sp\interaction::_id_CE18(var_10.script_noteworthy, var_18, var_9._id_D6E2);
    }
  } else if(var_4 && scripts\sp\idles::_id_9B62(var_10))
    var_9 thread scripts\sp\idles::_id_CC7F(var_10.script_noteworthy);
  else if(var_3 && scripts\sp\interaction::_id_9CD7(var_10))
    var_9 thread scripts\sp\interaction_manager::_id_CE40(var_10._id_EE92);

  if(isDefined(var_6) && var_6)
    var_9._id_1ED4 = ::_id_FD9E;

  return var_9;
}

_id_FDFE() {
  self._id_1FBB = "generic";
  self.script_team = "allies";
  self.script_pushable = 0;
  self.name = "";
  self._id_EDB8 = "";
  scripts\sp\utility::_id_72EC("iw7_m4", "primary");
  scripts\sp\utility::_id_86E4();
  self _meth_8250(0);
  scripts\sp\utility::_id_5131();
  scripts\anim\shared::placeweaponon(self.secondaryweapon, "none");

  if(isDefined(self._id_A489))
    self detach(self._id_A489);
}

_id_FDFF(var_0) {
  self._id_8E08 = ["j_helmet", "J_Visor", "J_Visor_Inner"];

  if(isDefined(var_0)) {
    if(isarray(var_0))
      self._id_8E08 = scripts\engine\utility::array_combine(self._id_8E08, var_0);
    else
      self._id_8E08[self._id_8E08.size] = var_0;
  }

  foreach(var_2 in self._id_8E08)
  self hidepart(var_2);
}

_id_FE00() {
  foreach(var_1 in self._id_8E08)
  self showpart(var_1);
}

_id_FDC1(var_0, var_1) {
  _id_0EFB::_id_FE05();

  if(!isDefined(level._id_FD6E._id_3D53))
    level._id_FD6E._id_3D53 = [];

  var_2 = scripts\sp\utility::_id_5CC9(var_0);
  var_2._id_1FBB = "generic";
  var_2._id_9B89 = 1;
  var_2._id_6B14 = 1;

  if(!isDefined(level._id_EC85["generic"]["head_knob"]))
    thread _id_0EF2::_id_3D4D();

  if(isDefined(var_2.weapon) && var_2.weapon != "none")
    var_2 scripts\sp\utility::_id_86E4();

  if(var_1)
    createnavrepulsor("", 0, var_2, 15);

  if(getdvarint("show_cheap", 0) != 0)
    var_2 thread _id_100CC();

  return var_2;
}

_id_100CC() {
  self endon("death");

  for(;;)
    scripts\engine\utility::waitframe();
}

_id_DB10() {
  self endon("death");
  var_0 = level.players[0];

  for(;;) {
    var_1 = getdvarfloat("push_dist", 55.0);
    var_1 = var_1 * var_1;
    var_2 = distancesquared(var_0.origin, self.origin);

    if(var_2 < var_1) {
      var_3 = getdvarfloat("push_exp", 1.3);
      var_4 = getdvarfloat("push_mul", 0.001);
      var_5 = pow(var_1 - var_2, var_3) * var_4;
      var_6 = self.origin - var_0.origin;
      var_6 = var_6 * -1;
      var_6 = vectorNormalize(var_6);
      var_6 = var_6 * var_5;
      var_0 _meth_8251(var_6, 1);
    } else
      var_0 _meth_8251((0, 0, 0), 1);

    scripts\engine\utility::waitframe();
  }
}