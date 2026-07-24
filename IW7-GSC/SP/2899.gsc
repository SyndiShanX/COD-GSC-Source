/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2899.gsc
**************************************/

_id_B908(var_0, var_1, var_2) {
  if(!isDefined(level._id_B901))
    level._id_B901 = [];

  if(!isDefined(level._id_B901[var_0])) {
    level._id_B901[var_0] = spawnStruct();
    level._id_B901[var_0]._id_13C0B = [];
    level._id_B901[var_0]._id_756F = [];
    level._id_B901[var_0]._id_7605 = spawnStruct();
    level._id_B901[var_0]._id_7596 = undefined;
  }

  if(!isDefined(level._id_B902))
    level._id_B902 = 0;

  _id_B900(var_0, var_1);
  _id_B8FF(var_0, var_2);
  _id_B907(var_0);
}

_id_B90D(var_0) {
  level._id_B903 = var_0;
}

_id_B90C(var_0, var_1) {
  if(!isDefined(level._id_B901) || !isDefined(level._id_B901[var_0])) {
    return;
  }
  level._id_B901[var_0]._id_7596 = var_1;
}

_id_B900(var_0, var_1) {
  if(!isDefined(level._id_B901) || !isDefined(level._id_B901[var_0]) || !isDefined(level._id_B901[var_0]._id_13C0B)) {
    return;
  }
  var_2 = 0;

  for(;;) {
    var_3 = tolower(tablelookupbyrow(var_1, var_2, 0));

    if(!isDefined(var_3) || var_3 == "") {
      var_3 = tolower(tablelookupbyrow(var_1, var_2, 1));

      if(!isDefined(var_3) || var_3 == "") {
        break;
      }
    }

    if(scripts\engine\utility::string_starts_with(var_3, "#")) {
      var_2++;
      continue;
    }

    if(!isDefined(level._id_B901[var_0]._id_13C0B[var_3]))
      level._id_B901[var_0]._id_13C0B[var_3] = spawnStruct();

    level._id_B901[var_0]._id_13C0B[var_3]._id_CA0A = float(tablelookupbyrow(var_1, var_2, 2));
    level._id_B901[var_0]._id_13C0B[var_3]._id_CA09 = float(tablelookupbyrow(var_1, var_2, 3));
    level._id_B901[var_0]._id_13C0B[var_3]._id_98F7 = float(tablelookupbyrow(var_1, var_2, 4));
    level._id_B901[var_0]._id_13C0B[var_3]._id_C75D = float(tablelookupbyrow(var_1, var_2, 5));
    level._id_B901[var_0]._id_13C0B[var_3]._id_DC08 = float(tablelookupbyrow(var_1, var_2, 6));
    level._id_B901[var_0]._id_13C0B[var_3]._id_118D4 = float(tablelookupbyrow(var_1, var_2, 7));
    level._id_B901[var_0]._id_13C0B[var_3]._id_118D3 = float(tablelookupbyrow(var_1, var_2, 8));
    level._id_B901[var_0]._id_13C0B[var_3]._id_6B7B = float(tablelookupbyrow(var_1, var_2, 9));
    level._id_B901[var_0]._id_13C0B[var_3]._id_6B7A = float(tablelookupbyrow(var_1, var_2, 10));
    level._id_B901[var_0]._id_13C0B[var_3]._id_9348 = tablelookupbyrow(var_1, var_2, 11);
    var_2++;
  }
}

_id_B8FF(var_0, var_1) {
  if(!isDefined(level._id_B901) || !isDefined(level._id_B901[var_0]) || !isDefined(level._id_B901[var_0]._id_756F)) {
    return;
  }
  var_2 = 0;

  for(;;) {
    var_3 = tolower(tablelookupbyrow(var_1, var_2, 0));

    if(!isDefined(var_3) || var_3 == "") {
      break;
    }

    if(scripts\engine\utility::string_starts_with(var_3, "#")) {
      var_2++;
      continue;
    }

    if(!isDefined(level._id_B901[var_0]._id_756F[var_3]))
      level._id_B901[var_0]._id_756F[var_3] = [];

    var_4 = level._id_B901[var_0]._id_756F[var_3].size;
    level._id_B901[var_0]._id_756F[var_3][var_4] = spawnStruct();
    level._id_B901[var_0]._id_756F[var_3][var_4].effect = tolower(tablelookupbyrow(var_1, var_2, 1));
    level._id_B901[var_0]._id_756F[var_3][var_4]._id_CE63 = float(tablelookupbyrow(var_1, var_2, 2));
    level._effect[var_0 + "_" + var_3 + "_" + var_4] = loadfx(level._id_B901[var_0]._id_756F[var_3][var_4].effect);
    var_2++;
  }
}

_id_B907(var_0) {
  if(!isDefined(level._id_B901) || !isDefined(level._id_B901[var_0]) || !isDefined(level._id_B901[var_0]._id_7605)) {
    return;
  }
  var_1 = scripts\engine\utility::getStruct(var_0 + "_fx_tag_origin", "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  level._id_B901[var_0]._id_7605.origin = var_1.origin;
  level._id_B901[var_0]._id_7605.angles = var_1.angles;
  level._id_B901[var_0]._id_7605._id_75C6 = scripts\engine\utility::getStructArray(var_0 + "_fx_point", "targetname");
}

_id_B906(var_0, var_1, var_2, var_3) {
  var_4 = self.model;

  if(isDefined(self._id_B904))
    var_4 = self._id_B904;

  if(!isDefined(var_4)) {
    return;
  }
  if(!isDefined(level._id_B901) || !isDefined(level._id_B901[var_4])) {
    return;
  }
  if(!isDefined(var_2) || !isDefined(level._id_B901[var_4]._id_13C0B[var_2])) {
    var_2 = var_3;

    if(!isDefined(var_2) || !isDefined(level._id_B901[var_4]._id_13C0B[var_3]))
      return;
  }

  var_1 = vectorNormalize(var_1);
  thread _id_B90B(var_4, var_0, var_1, var_2);
  var_5 = level._id_B901[var_4]._id_13C0B[var_2]._id_CA09;

  if(level._id_B901[var_4]._id_13C0B[var_2]._id_CA09 != level._id_B901[var_4]._id_13C0B[var_2]._id_CA0A)
    var_5 = randomfloatrange(level._id_B901[var_4]._id_13C0B[var_2]._id_CA0A, level._id_B901[var_4]._id_13C0B[var_2]._id_CA09);

  var_6 = level._id_B901[var_4]._id_13C0B[var_2]._id_C75D;

  if(level._id_B901[var_4]._id_13C0B[var_2]._id_DC08 > 0.0)
    var_6 = var_6 + randomfloat(level._id_B901[var_4]._id_13C0B[var_2]._id_DC08);

  var_7 = level._id_B901[var_4]._id_13C0B[var_2]._id_118D3;

  if(level._id_B901[var_4]._id_13C0B[var_2]._id_118D3 != level._id_B901[var_4]._id_13C0B[var_2]._id_118D4)
    var_7 = randomfloatrange(level._id_B901[var_4]._id_13C0B[var_2]._id_118D4, level._id_B901[var_4]._id_13C0B[var_2]._id_118D3);

  var_8 = level._id_B901[var_4]._id_13C0B[var_2]._id_6B7A;

  if(level._id_B901[var_4]._id_13C0B[var_2]._id_6B7A != level._id_B901[var_4]._id_13C0B[var_2]._id_6B7B)
    var_8 = randomfloatrange(level._id_B901[var_4]._id_13C0B[var_2]._id_6B7B, level._id_B901[var_4]._id_13C0B[var_2]._id_6B7A);

  var_9 = var_0 + var_1 * var_5;
  var_10 = level._id_B901[var_4]._id_7605.origin + rotatevector(var_9 - self.origin, level._id_B901[var_4]._id_7605.angles - self.angles);
  var_11 = var_6 * var_6;
  var_12 = pow(level._id_B901[var_4]._id_13C0B[var_2]._id_98F7, 2.0);

  foreach(var_16, var_14 in level._id_B901[var_4]._id_7605._id_75C6) {
    var_15 = distancesquared(var_14.origin, var_10);

    if(var_15 >= var_12 && var_15 <= var_11)
      thread _id_B90A(var_14, var_16, sqrt(var_15), var_6, var_7, var_8);
  }
}

_id_B90B(var_0, var_1, var_2, var_3) {
  if(isDefined(level._id_B903) && level._id_B902 >= level._id_B903) {
    return;
  }
  var_4 = level._id_B901[var_0]._id_13C0B[var_3]._id_9348;

  if(isDefined(level._id_B901[var_0]._id_756F[var_4])) {
    var_5 = scripts\common\trace::ray_trace_detail(var_1 - var_2 * 6.0, var_1 + var_2 * 6.0);

    if(var_5["fraction"] < 1.0) {
      var_6 = scripts\engine\utility::spawn_tag_origin(var_1, vectortoangles(var_5["normal"]));
      var_6 linkTo(self);
      var_7 = randomint(level._id_B901[var_0]._id_756F[var_4].size);
      var_8 = var_0 + "_" + var_4 + "_" + var_7;
      playFXOnTag(scripts\engine\utility::getfx(var_8), var_6, "tag_origin");
      level._id_B902++;

      if(isDefined(level._id_B901[var_0]._id_756F[var_4][var_7]._id_CE63))
        scripts\engine\utility::waittill_any_timeout(level._id_B901[var_0]._id_756F[var_4][var_7]._id_CE63, "entitydeleted");
      else
        self waittill("entitydeleted");

      var_6 delete();
      level._id_B902--;
    }
  }
}

_id_B90A(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(self._id_4CEB) && scripts\engine\utility::array_contains(self._id_4CEB, var_1)) {
    return;
  }
  if(isDefined(level._id_B903) && level._id_B902 >= level._id_B903) {
    return;
  }
  var_6 = self.model;

  if(isDefined(self._id_B904))
    var_6 = self._id_B904;

  if(!isDefined(var_0.script_noteworthy)) {
    var_7 = var_0.origin - level._id_B901[var_6]._id_7605.origin;
    return;
  }

  if(!isDefined(self._id_4CEB))
    self._id_4CEB = [];

  self._id_4CEB[self._id_4CEB.size] = var_1;
  var_8 = var_2 / var_3;
  var_9 = var_4 * pow(var_8, var_5);

  if(var_9 > 0.05)
    wait(var_9);

  if(isDefined(level._id_B903) && level._id_B902 >= level._id_B903) {
    return;
  }
  var_10 = var_0.script_noteworthy;
  var_11 = getsubstr(var_0.script_noteworthy, var_0.script_noteworthy.size - 4, var_0.script_noteworthy.size);

  if(var_11 == "_sml" || var_11 == "_med" || var_11 == "_lrg") {
    var_10 = getsubstr(var_0.script_noteworthy, 0, var_0.script_noteworthy.size - 4);

    if(var_8 < 0.5)
      var_10 = var_10 + "_sml";
    else if(var_8 < 0.9)
      var_10 = var_10 + "_med";
    else
      var_10 = var_10 + "_lrg";
  }

  if(isDefined(self)) {
    var_7 = var_0.origin - level._id_B901[var_6]._id_7605.origin;
    var_12 = self.angles - level._id_B901[var_6]._id_7605.angles;
    var_13 = self.origin + rotatevector(var_7, var_12);
    var_14 = var_0.angles + var_12;

    if(!isDefined(var_10) || !isDefined(level._id_B901[var_6]._id_756F[var_10])) {
      return;
    }
    var_15 = int(clamp(floor(level._id_B901[var_6]._id_756F[var_10].size * var_8), 0, level._id_B901[var_6]._id_756F[var_10].size - 1));
    var_16 = var_6 + "_" + var_10 + "_" + var_15;

    if(isDefined(level._id_B901[var_6]._id_7596) && self[[level._id_B901[var_6]._id_7596]](var_6, var_13, var_14, var_16)) {
      return;
    }
    var_17 = scripts\engine\utility::spawn_tag_origin(var_13, var_14);
    var_17 linkTo(self);
    playFXOnTag(scripts\engine\utility::getfx(var_16), var_17, "tag_origin");
    level._id_B902++;

    if(isDefined(var_0.target)) {
      foreach(var_19 in getEntArray(var_0.target, "targetname"))
      thread _id_B90A(var_19, var_2, var_3, 0.0, var_5);
    }

    if(isDefined(level._id_B901[var_6]._id_756F[var_10][var_15]._id_CE63))
      scripts\engine\utility::waittill_any_timeout(level._id_B901[var_6]._id_756F[var_10][var_15]._id_CE63, "entitydeleted");
    else
      self waittill("entitydeleted");

    if(isDefined(self))
      self._id_4CEB = scripts\engine\utility::array_remove(self._id_4CEB, var_1);

    var_17 delete();
    level._id_B902--;
  }
}

_id_B909() {
  self notify("model_damage_end_monitoring");
  self endon("death");
  self endon("destroyed");
  self endon("entitydeleted");
  self endon("model_damage_end_monitoring");
  var_0 = self.model;

  if(isDefined(self._id_B904))
    var_0 = self._id_B904;

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(level._id_B901) || !isDefined(level._id_B901[var_0])) {
    return;
  }
  while(isDefined(self)) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    thread _id_B906(var_4, var_3, var_10, var_5);
  }
}

_id_B905() {
  var_0 = self.model;

  if(isDefined(self._id_B904))
    var_0 = self._id_B904;

  if(!isDefined(var_0) || !isDefined(level._id_B901) || !isDefined(level._id_B901[var_0]) || level._id_B901[var_0]._id_7605._id_75C6.size == 0)
    return self.origin;

  var_1 = level._id_B901[var_0]._id_7605._id_75C6[randomint(level._id_B901[var_0]._id_7605._id_75C6.size)];
  var_2 = var_1.origin - level._id_B901[var_0]._id_7605.origin;
  var_3 = self.angles - level._id_B901[var_0]._id_7605.angles;
  return self.origin + rotatevector(var_2, var_3);
}