/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2833.gsc
**************************************/

_id_37A9() {
  precachemodel("fx_org_view");
}

_id_CCBE() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0 linkTo(level.player, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0._id_C04F = 1;
  level.player._id_763C = var_0;
  var_1 = scripts\engine\utility::getStructArray("fxchain_start", "script_noteworthy");
  level._id_AD40 = [];
  level._id_C1E0 = var_1.size;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_1[var_2]._id_3C0A = var_2;
    var_1[var_2] _id_6C76();
  }

  var_1 = undefined;
  level._id_C1E0 = undefined;
  level._id_AD40 = scripts\engine\utility::array_sort_with_func(level._id_AD40, ::_id_445A);
  level._id_37CF = level._id_AD40[0]["start_struct"];
  level._id_37CE = 0;
  playFXOnTag(scripts\engine\utility::getfx(level._id_37CF.script_parameters), var_0, "tag_origin");
  level._id_AD40 = undefined;
  var_3 = scripts\engine\utility::getStructArray("fxchain_transition", "targetname");
  thread _id_68A8(var_0);

  for(;;) {
    wait 0.25;

    if(level._id_37CE) {
      continue;
    }
    if(var_3.size > 0) {
      var_4 = sortbydistance(var_3, level.player.origin)[0];

      if(distance2dsquared(level.player.origin, var_4.origin) <= squared(var_4.radius)) {
        var_5 = scripts\engine\utility::getStruct(var_4.script_noteworthy, "targetname");
        var_6 = scripts\engine\utility::getStruct(var_4.script_parameters, "targetname");
        var_7 = vectordot(anglesToForward(var_4.angles), level.player.origin - var_4.origin);
        var_8 = undefined;

        if(var_7 > 0 && level._id_37CF._id_3C0A == var_6._id_3C0A)
          var_8 = var_5;

        if(var_7 < 0 && level._id_37CF._id_3C0A == var_5._id_3C0A)
          var_8 = var_6;

        if(isDefined(var_8))
          _id_12660(var_8, var_0);
      }
    }

    var_9 = [];

    foreach(var_11 in scripts\engine\utility::getStructArray(level._id_37CF.targetname, "target"))
    var_9[var_9.size] = _id_7A8D(var_11, level._id_37CF);

    if(isDefined(level._id_37CF.target)) {
      var_13 = scripts\engine\utility::getStructArray(level._id_37CF.target, "targetname");

      foreach(var_15 in var_13) {
        var_9[var_9.size] = _id_7A8D(level._id_37CF, var_15);

        if(isDefined(var_15.target)) {
          var_16 = scripts\engine\utility::getStructArray(var_15.target, "targetname");

          foreach(var_18 in var_16)
          var_9[var_9.size] = _id_7A8D(var_15, var_18);
        }
      }
    }

    var_9 = scripts\engine\utility::array_sort_with_func(var_9, ::_id_445A);
    var_8 = var_9[0]["start_struct"];

    if(var_8.origin != level._id_37CF.origin) {
      if(var_8.script_parameters != level._id_37CF.script_parameters) {
        _id_12660(var_8, var_0);
        continue;
      }

      level._id_37CF = var_8;
    }
  }
}

_id_6C76() {
  if(isDefined(self.target)) {
    var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");

    foreach(var_2 in var_0) {
      if(!isDefined(var_2._id_3C0A)) {
        var_2._id_3C0A = self._id_3C0A;
        level._id_AD40[level._id_AD40.size] = _id_7A8D(self, var_2);
        level._id_C1E0++;
        var_2 _id_6C76();
      }
    }
  }
}

_id_7A8D(var_0, var_1) {
  var_2 = [];
  var_2["start_struct"] = var_0;
  var_2["closest_point"] = pointonsegmentnearesttopoint(var_0.origin, var_1.origin, level.player.origin);
  return var_2;
}

_id_445A(var_0, var_1) {
  return distancesquared(var_0["closest_point"], level.player.origin) < distancesquared(var_1["closest_point"], level.player.origin);
}

_id_68A8(var_0) {}

_id_12660(var_0, var_1) {
  stopFXOnTag(scripts\engine\utility::getfx(level._id_37CF.script_parameters), var_1, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx(var_0.script_parameters), var_1, "tag_origin");
  level._id_37CF = var_0;
}