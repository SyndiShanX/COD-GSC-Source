/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2899.gsc
***************************************/

func_B908(var_00, var_01, var_02) {
  if(!isDefined(level.func_B901))
    level.func_B901 = [];

  if(!isDefined(level.func_B901[var_00])) {
    level.func_B901[var_00] = spawnStruct();
    level.func_B901[var_00].func_13C0B = [];
    level.func_B901[var_00].func_756F = [];
    level.func_B901[var_00].func_7605 = spawnStruct();
    level.func_B901[var_00].func_7596 = undefined;
  }

  if(!isDefined(level.func_B902))
    level.func_B902 = 0;

  func_B900(var_00, var_01);
  func_B8FF(var_00, var_02);
  func_B907(var_00);
}

func_B90D(var_00) {
  level.func_B903 = var_00;
}

func_B90C(var_00, var_01) {
  if(!isDefined(level.func_B901) || !isDefined(level.func_B901[var_00])) {
    return;
  }
  level.func_B901[var_00].func_7596 = var_01;
}

func_B900(var_00, var_01) {
  if(!isDefined(level.func_B901) || !isDefined(level.func_B901[var_00]) || !isDefined(level.func_B901[var_00].func_13C0B)) {
    return;
  }
  var_02 = 0;

  for(;;) {
    var_03 = tolower(tablelookupbyrow(var_01, var_02, 0));

    if(!isDefined(var_03) || var_03 == "") {
      var_03 = tolower(tablelookupbyrow(var_01, var_02, 1));

      if(!isDefined(var_03) || var_03 == "") {
        break;
      }
    }

    if(scripts\engine\utility::string_starts_with(var_03, "#")) {
      var_2++;
      continue;
    }

    if(!isDefined(level.func_B901[var_00].func_13C0B[var_03]))
      level.func_B901[var_00].func_13C0B[var_03] = spawnStruct();

    level.func_B901[var_00].func_13C0B[var_03].func_CA0A = float(tablelookupbyrow(var_01, var_02, 2));
    level.func_B901[var_00].func_13C0B[var_03].func_CA09 = float(tablelookupbyrow(var_01, var_02, 3));
    level.func_B901[var_00].func_13C0B[var_03].func_98F7 = float(tablelookupbyrow(var_01, var_02, 4));
    level.func_B901[var_00].func_13C0B[var_03].func_C75D = float(tablelookupbyrow(var_01, var_02, 5));
    level.func_B901[var_00].func_13C0B[var_03].func_DC08 = float(tablelookupbyrow(var_01, var_02, 6));
    level.func_B901[var_00].func_13C0B[var_03].func_118D4 = float(tablelookupbyrow(var_01, var_02, 7));
    level.func_B901[var_00].func_13C0B[var_03].func_118D3 = float(tablelookupbyrow(var_01, var_02, 8));
    level.func_B901[var_00].func_13C0B[var_03].func_6B7B = float(tablelookupbyrow(var_01, var_02, 9));
    level.func_B901[var_00].func_13C0B[var_03].func_6B7A = float(tablelookupbyrow(var_01, var_02, 10));
    level.func_B901[var_00].func_13C0B[var_03].func_9348 = tablelookupbyrow(var_01, var_02, 11);
    var_2++;
  }
}

func_B8FF(var_00, var_01) {
  if(!isDefined(level.func_B901) || !isDefined(level.func_B901[var_00]) || !isDefined(level.func_B901[var_00].func_756F)) {
    return;
  }
  var_02 = 0;

  for(;;) {
    var_03 = tolower(tablelookupbyrow(var_01, var_02, 0));

    if(!isDefined(var_03) || var_03 == "") {
      break;
    }
    if(scripts\engine\utility::string_starts_with(var_03, "#")) {
      var_2++;
      continue;
    }

    if(!isDefined(level.func_B901[var_00].func_756F[var_03]))
      level.func_B901[var_00].func_756F[var_03] = [];

    var_04 = level.func_B901[var_00].func_756F[var_03].size;
    level.func_B901[var_00].func_756F[var_03][var_04] = spawnStruct();
    level.func_B901[var_00].func_756F[var_03][var_04].effect = tolower(tablelookupbyrow(var_01, var_02, 1));
    level.func_B901[var_00].func_756F[var_03][var_04].func_CE63 = float(tablelookupbyrow(var_01, var_02, 2));
    level._effect[var_00 + "_" + var_03 + "_" + var_04] = loadfx(level.func_B901[var_00].func_756F[var_03][var_04].effect);
    var_2++;
  }
}

func_B907(var_00) {
  if(!isDefined(level.func_B901) || !isDefined(level.func_B901[var_00]) || !isDefined(level.func_B901[var_00].func_7605)) {
    return;
  }
  var_01 = scripts\engine\utility::getstruct(var_00 + "_fx_tag_origin", "targetname");

  if(!isDefined(var_01)) {
    return;
  }
  level.func_B901[var_00].func_7605.origin = var_1.origin;
  level.func_B901[var_00].func_7605.angles = var_1.angles;
  level.func_B901[var_00].func_7605.func_75C6 = scripts\engine\utility::getstructarray(var_00 + "_fx_point", "targetname");
}

func_B906(var_00, var_01, var_02, var_03) {
  var_04 = self.model;

  if(isDefined(self.func_B904))
    var_04 = self.func_B904;

  if(!isDefined(var_04)) {
    return;
  }
  if(!isDefined(level.func_B901) || !isDefined(level.func_B901[var_04])) {
    return;
  }
  if(!isDefined(var_02) || !isDefined(level.func_B901[var_04].func_13C0B[var_02])) {
    var_02 = var_03;

    if(!isDefined(var_02) || !isDefined(level.func_B901[var_04].func_13C0B[var_03]))
      return;
  }

  var_01 = vectornormalize(var_01);
  thread func_B90B(var_04, var_00, var_01, var_02);
  var_05 = level.func_B901[var_04].func_13C0B[var_02].func_CA09;

  if(level.func_B901[var_04].func_13C0B[var_02].func_CA09 != level.func_B901[var_04].func_13C0B[var_02].func_CA0A)
    var_05 = randomfloatrange(level.func_B901[var_04].func_13C0B[var_02].func_CA0A, level.func_B901[var_04].func_13C0B[var_02].func_CA09);

  var_06 = level.func_B901[var_04].func_13C0B[var_02].func_C75D;

  if(level.func_B901[var_04].func_13C0B[var_02].func_DC08 > 0.0)
    var_06 = var_06 + randomfloat(level.func_B901[var_04].func_13C0B[var_02].func_DC08);

  var_07 = level.func_B901[var_04].func_13C0B[var_02].func_118D3;

  if(level.func_B901[var_04].func_13C0B[var_02].func_118D3 != level.func_B901[var_04].func_13C0B[var_02].func_118D4)
    var_07 = randomfloatrange(level.func_B901[var_04].func_13C0B[var_02].func_118D4, level.func_B901[var_04].func_13C0B[var_02].func_118D3);

  var_08 = level.func_B901[var_04].func_13C0B[var_02].func_6B7A;

  if(level.func_B901[var_04].func_13C0B[var_02].func_6B7A != level.func_B901[var_04].func_13C0B[var_02].func_6B7B)
    var_08 = randomfloatrange(level.func_B901[var_04].func_13C0B[var_02].func_6B7B, level.func_B901[var_04].func_13C0B[var_02].func_6B7A);

  var_09 = var_00 + var_01 * var_05;
  var_10 = level.func_B901[var_04].func_7605.origin + rotatevector(var_09 - self.origin, level.func_B901[var_04].func_7605.angles - self.angles);
  var_11 = var_06 * var_06;
  var_12 = _pow(level.func_B901[var_04].func_13C0B[var_02].func_98F7, 2.0);

  foreach(var_16, var_14 in level.func_B901[var_04].func_7605.func_75C6) {
    var_15 = distancesquared(var_14.origin, var_10);

    if(var_15 >= var_12 && var_15 <= var_11)
      thread func_B90A(var_14, var_16, sqrt(var_15), var_06, var_07, var_08);
  }
}

func_B90B(var_00, var_01, var_02, var_03) {
  if(isDefined(level.func_B903) && level.func_B902 >= level.func_B903) {
    return;
  }
  var_04 = level.func_B901[var_00].func_13C0B[var_03].func_9348;

  if(isDefined(level.func_B901[var_00].func_756F[var_04])) {
    var_05 = scripts\engine\trace::ray_trace_detail(var_01 - var_02 * 6.0, var_01 + var_02 * 6.0);

    if(var_5["fraction"] < 1.0) {
      var_06 = scripts\engine\utility::spawn_tag_origin(var_01, vectortoangles(var_5["normal"]));
      var_06 linkto(self);
      var_07 = randomint(level.func_B901[var_00].func_756F[var_04].size);
      var_08 = var_00 + "_" + var_04 + "_" + var_07;
      playFXOnTag(scripts\engine\utility::getfx(var_08), var_06, "tag_origin");
      level.func_B902++;

      if(isDefined(level.func_B901[var_00].func_756F[var_04][var_07].func_CE63))
        scripts\engine\utility::waittill_any_timeout(level.func_B901[var_00].func_756F[var_04][var_07].func_CE63, "entitydeleted");
      else
        self waittill("entitydeleted");

      var_06 delete();
      level.func_B902--;
    }
  }
}

func_B90A(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(isDefined(self.func_4CEB) && scripts\engine\utility::array_contains(self.func_4CEB, var_01)) {
    return;
  }
  if(isDefined(level.func_B903) && level.func_B902 >= level.func_B903) {
    return;
  }
  var_06 = self.model;

  if(isDefined(self.func_B904))
    var_06 = self.func_B904;

  if(!isDefined(var_0.script_noteworthy)) {
    var_07 = var_0.origin - level.func_B901[var_06].func_7605.origin;
    return;
  }

  if(!isDefined(self.func_4CEB))
    self.func_4CEB = [];

  self.func_4CEB[self.func_4CEB.size] = var_01;
  var_08 = var_02 / var_03;
  var_09 = var_04 * _pow(var_08, var_05);

  if(var_09 > 0.05)
    wait(var_09);

  if(isDefined(level.func_B903) && level.func_B902 >= level.func_B903) {
    return;
  }
  var_10 = var_0.script_noteworthy;
  var_11 = getsubstr(var_0.script_noteworthy, var_0.script_noteworthy.size - 4, var_0.script_noteworthy.size);

  if(var_11 == "_sml" || var_11 == "_med" || var_11 == "_lrg") {
    var_10 = getsubstr(var_0.script_noteworthy, 0, var_0.script_noteworthy.size - 4);

    if(var_08 < 0.5)
      var_10 = var_10 + "_sml";
    else if(var_08 < 0.9)
      var_10 = var_10 + "_med";
    else
      var_10 = var_10 + "_lrg";
  }

  if(isDefined(self)) {
    var_07 = var_0.origin - level.func_B901[var_06].func_7605.origin;
    var_12 = self.angles - level.func_B901[var_06].func_7605.angles;
    var_13 = self.origin + rotatevector(var_07, var_12);
    var_14 = var_0.angles + var_12;

    if(!isDefined(var_10) || !isDefined(level.func_B901[var_06].func_756F[var_10])) {
      return;
    }
    var_15 = int(clamp(floor(level.func_B901[var_06].func_756F[var_10].size * var_08), 0, level.func_B901[var_06].func_756F[var_10].size - 1));
    var_16 = var_06 + "_" + var_10 + "_" + var_15;

    if(isDefined(level.func_B901[var_06].func_7596) && self[[level.func_B901[var_06].func_7596]](var_06, var_13, var_14, var_16)) {
      return;
    }
    var_17 = scripts\engine\utility::spawn_tag_origin(var_13, var_14);
    var_17 linkto(self);
    playFXOnTag(scripts\engine\utility::getfx(var_16), var_17, "tag_origin");
    level.func_B902++;

    if(isDefined(var_0.target)) {
      foreach(var_19 in getEntArray(var_0.target, "targetname"))
      thread func_B90A(var_19, var_02, var_03, 0.0, var_05);
    }

    if(isDefined(level.func_B901[var_06].func_756F[var_10][var_15].func_CE63))
      scripts\engine\utility::waittill_any_timeout(level.func_B901[var_06].func_756F[var_10][var_15].func_CE63, "entitydeleted");
    else
      self waittill("entitydeleted");

    if(isDefined(self))
      self.func_4CEB = scripts\engine\utility::array_remove(self.func_4CEB, var_01);

    var_17 delete();
    level.func_B902--;
  }
}

func_B909() {
  self notify("model_damage_end_monitoring");
  self endon("death");
  self endon("destroyed");
  self endon("entitydeleted");
  self endon("model_damage_end_monitoring");
  var_00 = self.model;

  if(isDefined(self.func_B904))
    var_00 = self.func_B904;

  if(!isDefined(var_00)) {
    return;
  }
  if(!isDefined(level.func_B901) || !isDefined(level.func_B901[var_00])) {
    return;
  }
  while(isDefined(self)) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10);
    thread func_B906(var_04, var_03, var_10, var_05);
  }
}

func_B905() {
  var_00 = self.model;

  if(isDefined(self.func_B904))
    var_00 = self.func_B904;

  if(!isDefined(var_00) || !isDefined(level.func_B901) || !isDefined(level.func_B901[var_00]) || level.func_B901[var_00].func_7605.func_75C6.size == 0)
    return self.origin;

  var_01 = level.func_B901[var_00].func_7605.func_75C6[randomint(level.func_B901[var_00].func_7605.func_75C6.size)];
  var_02 = var_1.origin - level.func_B901[var_00].func_7605.origin;
  var_03 = self.angles - level.func_B901[var_00].func_7605.angles;
  return self.origin + rotatevector(var_02, var_03);
}