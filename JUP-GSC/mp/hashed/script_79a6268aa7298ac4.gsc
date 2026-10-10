/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_79a6268aa7298ac4.gsc
*************************************************/

#using script_3d2770dc09c1243;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_a6c9c44798b37fa6;

function function_14f6e531ffd2958d() {
  var_e6aedea5e48791ea = 1;
  var_19a94df60dbbe38c = 2;
  var_18ff7658e43bce3b = 3;
  var_3c34b3ea7ee34f5d = getdvarfloat(@ "hash_7bf0de1b1d9ca208", 150);
  var_a7fab0fd5ac2f4d1 = getdvarfloat(@ "hash_7748ba4302072dca", 150);
  var_69556696b54e51f6 = getdvarfloat(@ "hash_25616f5e79c1fb81", 230);
  var_a704907794bc2db5 = 30;
  var_48f2369d220b0952 = 0.9;
  var_91e8b9ab485c6a23 = 30;
  var_97168cfe753f1c25 = [];
  var_c3daefaff1082323 = function_528c7588ba48da94();

  for(lastindex = var_c3daefaff1082323.size - 1; lastindex >= 1; lastindex--) {
    var_cb42ce070ff82453 = var_c3daefaff1082323[lastindex];
    var_d93ac0e132165264 = var_cb42ce070ff82453.centerposition;
    var_657be1df9e18e72b = var_cb42ce070ff82453.orientation;

    for(index = 0; index < lastindex; index++) {
      var_fef716c724980e99 = var_c3daefaff1082323[index];
      var_577ad0355b2f1a06 = var_fef716c724980e99.centerposition;
      var_f5fb1a229968f9fd = var_fef716c724980e99.orientation;

      if(abs(var_d93ac0e132165264[2] - var_577ad0355b2f1a06[2]) > var_a704907794bc2db5) {
        continue;
      }

      var_15f7a0a2c8478034 = undefined;
      dist = distance(var_d93ac0e132165264, var_577ad0355b2f1a06);

      if(abs(vectordot(var_657be1df9e18e72b, var_f5fb1a229968f9fd)) >= var_48f2369d220b0952) {
        var_917557ef8589c314 = abs(vectordot(var_657be1df9e18e72b, var_577ad0355b2f1a06 - var_d93ac0e132165264));

        if(var_917557ef8589c314 >= var_91e8b9ab485c6a23) {
          if(dist <= var_3c34b3ea7ee34f5d) {
            var_1ac16b7e89c07b85 = physics_raycast(var_d93ac0e132165264 + (0, 0, 30), var_577ad0355b2f1a06 + (0, 0, 30), scripts\engine\trace::create_default_contents(), undefined, 0, "physicsquery_all", 0, 1);
            var_300330130b817bbc = 1;

            foreach(item in var_1ac16b7e89c07b85) {
              if(!isDefined(item["scriptable"]) || !(array_contains(var_cb42ce070ff82453.doors, item["scriptable"]) || array_contains(var_fef716c724980e99.doors, item["scriptable"]))) {
                var_300330130b817bbc = 0;
                break;
              }
            }

            if(var_300330130b817bbc) {
              var_15f7a0a2c8478034 = spawnStruct();
              var_15f7a0a2c8478034.type = var_e6aedea5e48791ea;
              var_15f7a0a2c8478034.scores = [var_917557ef8589c314 * -1];
            }
          }
        } else if(dist <= var_a7fab0fd5ac2f4d1) {
          var_15f7a0a2c8478034 = spawnStruct();
          var_15f7a0a2c8478034.type = var_19a94df60dbbe38c;
          var_15f7a0a2c8478034.scores = [var_917557ef8589c314 * -1];
        }
      } else if(dist <= var_69556696b54e51f6) {
        var_15f7a0a2c8478034 = spawnStruct();
        var_15f7a0a2c8478034.type = var_18ff7658e43bce3b;
      }

      if(isDefined(var_15f7a0a2c8478034)) {
        var_15f7a0a2c8478034.pairs = [var_cb42ce070ff82453, var_fef716c724980e99];
        var_15f7a0a2c8478034.scores = array_insert(default_to(var_15f7a0a2c8478034.scores, []), dist * -1, 0);
        var_15f7a0a2c8478034.distance = dist;
        var_97168cfe753f1c25[var_97168cfe753f1c25.size] = var_15f7a0a2c8478034;
      }
    }
  }

  var_97168cfe753f1c25 = array_sort_with_func(var_97168cfe753f1c25, &function_c630903df040bc01);
  typestrings = [];
  typestrings[var_e6aedea5e48791ea] = "parallel";
  typestrings[var_19a94df60dbbe38c] = "collinear";
  typestrings[var_18ff7658e43bce3b] = "perpendicular";
  outputlog("AdjacentDoubleDoorsInfo", "#time; #type; #positions; #distance");

  for(index = 0; index < var_97168cfe753f1c25.size; index++) {
    var_15f7a0a2c8478034 = var_97168cfe753f1c25[index];
    typestring = typestrings[var_15f7a0a2c8478034.type];
    dist = var_15f7a0a2c8478034.distance;
    pos1 = var_15f7a0a2c8478034.pairs[0].centerposition;
    pos2 = var_15f7a0a2c8478034.pairs[1].centerposition;
    reportstring = gettime() + "; " + typestring + "; " + pos1 + ", " + pos2 + "; " + dist;
    outputlog("AdjacentDoubleDoorsInfo", reportstring);
  }
}

function private function_528c7588ba48da94() {
  var_c3daefaff1082323 = [];
  doubledoors = function_e10ebb6744a748d8();
  assert(doubledoors.size % 2 == 0);
  lastindex = doubledoors.size - 1;

  while(lastindex >= 1) {
    onedoor = doubledoors[lastindex];
    var_80105f354ee4398b = onedoor function_d90515f5e17dbc6f();
    targetindex = undefined;
    mindistsq = undefined;

    for(index = 0; index < lastindex; index++) {
      doorpos = doubledoors[index] function_d90515f5e17dbc6f();
      distsq = distancesquared(doorpos, var_80105f354ee4398b);

      if(!isDefined(mindistsq) || distsq < mindistsq) {
        mindistsq = distsq;
        targetindex = index;
      }
    }

    var_d6bb47a1b21d7e1e = doubledoors[targetindex];

    if(targetindex != lastindex - 1) {
      doubledoors[targetindex] = doubledoors[lastindex - 1];
    }

    var_4c79e3a2a493cb22 = spawnStruct();
    var_4c79e3a2a493cb22.doors = [onedoor, var_d6bb47a1b21d7e1e];
    var_731e3a183f1b0964 = var_d6bb47a1b21d7e1e function_d90515f5e17dbc6f();
    var_4c79e3a2a493cb22.centerposition = (var_80105f354ee4398b + var_731e3a183f1b0964) / 2;
    var_4c79e3a2a493cb22.orientation = anglesToForward(onedoor.angles + (0, -90, 0));
    var_c3daefaff1082323[var_c3daefaff1082323.size] = var_4c79e3a2a493cb22;
    lastindex -= 2;
  }

  return var_c3daefaff1082323;
}

function private function_e10ebb6744a748d8() {
  doubledoors = [];
  doors = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "door");

  foreach(door in doors) {
    if(door scriptabledoorisdouble()) {
      doubledoors[doubledoors.size] = door;
    }
  }

  return doubledoors;
}

function private function_c630903df040bc01(lhs, rhs) {
  assert(isDefined(lhs.type) && isDefined(lhs.scores));

  if(lhs.type != rhs.type) {
    return (lhs.type < rhs.type);
  }

  assert(lhs.scores.size == rhs.scores.size);

  for(i = 0; i < lhs.scores.size; i++) {
    if(lhs.scores[i] != rhs.scores[i]) {
      return (lhs.scores[i] > rhs.scores[i]);
    }
  }

  return true;
}