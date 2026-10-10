/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\anim\animselector.gsc
***********************************************/

#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace animselector;

function getanimselectorfilenames() {
  filenamearray = [];

  if(utility::iscp()) {
    filenamearray["traverse_warp_up"] = [[0, "animselectortables/soldier/soldier_traverse_warp_up.csv"], [1, "animselectortables/civilian/civilian_traverse_warp_up.csv"], [2, "animselectortables/bomber/bomber_traverse_warp_up.csv"]];
    filenamearray["traverse_warp_down"] = [[0, "animselectortables/soldier/soldier_traverse_warp_down.csv"], [1, "animselectortables/civilian/civilian_traverse_warp_down.csv"], [2, "animselectortables/bomber/bomber_traverse_warp_down.csv"]];
    filenamearray["traverse_warp_over"] = [[0, "animselectortables/soldier/soldier_traverse_warp_over.csv"], [1, "animselectortables/civilian/civilian_traverse_warp_over.csv"], [2, "animselectortables/bomber/bomber_traverse_warp_over.csv"]];
    filenamearray["traverse_warp_across"] = [[0, "animselectortables/soldier/soldier_traverse_warp_across.csv"], [1, "animselectortables/civilian/civilian_traverse_warp_across.csv"], [2, "animselectortables/bomber/bomber_traverse_warp_across.csv"]];
    filenamearray["traverse_warp_external"] = [[0, "animselectortables/soldier/soldier_traverse_warp_external.csv"], [1, "animselectortables/civilian/civilian_traverse_warp_external.csv"], [2, "animselectortables/bomber/bomber_traverse_warp_external.csv"]];
  } else {
    filenamearray["traverse_warp_up"] = [[0, "animselectortables/soldier/soldier_traverse_warp_up.csv"], [1, "animselectortables/civilian/civilian_traverse_warp_up.csv"], [2, "animselectortables/bomber/bomber_traverse_warp_up.csv"]];
    filenamearray["traverse_warp_down"] = [[0, "animselectortables/soldier/soldier_traverse_warp_down.csv"], [1, "animselectortables/civilian/civilian_traverse_warp_down.csv"], [2, "animselectortables/bomber/bomber_traverse_warp_down.csv"]];
    filenamearray["traverse_warp_over"] = [[0, "animselectortables/soldier/soldier_traverse_warp_over.csv"], [1, "animselectortables/civilian/civilian_traverse_warp_over.csv"], [2, "animselectortables/bomber/bomber_traverse_warp_over.csv"]];
    filenamearray["traverse_warp_across"] = [[0, "animselectortables/soldier/soldier_traverse_warp_across.csv"], [1, "animselectortables/civilian/civilian_traverse_warp_across.csv"], [2, "animselectortables/bomber/bomber_traverse_warp_across.csv"]];
    filenamearray["traverse_warp_external"] = [[0, "animselectortables/soldier/soldier_traverse_warp_external.csv"], [1, "animselectortables/civilian/civilian_traverse_warp_external.csv"], [2, "animselectortables/bomber/bomber_traverse_warp_external.csv"]];
  }

  return filenamearray;
}

function init() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") != 0 || getdvarint(@ "g_connectpaths") != 0) {
    return;
  }

  anim.animselectorfeaturetable = [];
  anim.animselectorfeaturetable["min_height"] = ["height", 0];
  anim.animselectorfeaturetable["max_height"] = ["height", 1];
  anim.animselectorfeaturetable["min_arrival_yaw"] = ["arrival_yaw", 0];
  anim.animselectorfeaturetable["max_arrival_yaw"] = ["arrival_yaw", 1];
  anim.animselectorfeaturetable["min_length"] = ["length", 0];
  anim.animselectorfeaturetable["max_length"] = ["length", 1];
  anim.animselectorfeaturetable["min_drop_height"] = ["drop_height", 0];
  anim.animselectorfeaturetable["max_drop_height"] = ["drop_height", 1];
  anim.animselectorfeaturetable["min_speed"] = ["speed", 0];
  anim.animselectorfeaturetable["max_speed"] = ["speed", 1];
  anim.animselector = [];
  filenamearray = getanimselectorfilenames();

  foreach(statename, filenames in filenamearray) {
    foreach(traverser, filename in filenames) {
      anim.animselector[statename][traverser] = spawnStruct();
      anim.animselector[statename][traverser].aliases = [];
      anim.animselector[statename][traverser].features = [];
      anim.animselector[statename][traverser].values = [];
      num_aliases = tablelookuprownum(filename[1], 0, "__END__");
      assertex(isDefined(num_aliases) && num_aliases != -1, "<dev string:x1c>" + filename[1] + "<dev string:x42>");
      num_aliases -= 1;
      assertex(num_aliases > 0, "<dev string:x6c>");

      for(i = 0; i < num_aliases; i++) {
        alias = tablelookupbyrow(filename[1], i + 1, 0);
        anim.animselector[statename][traverser].aliases[i] = alias;
      }

      num_features = undefined;

      for(i = 0; i < 50; i++) {
        feature = tablelookupbyrow(filename[1], 0, i + 1);

        if(feature == "__END__" || feature == "") {
          num_features = i;
          break;
        }

        anim.animselector[statename][traverser].features[i] = feature;
      }

      assertex(isDefined(num_features), "<dev string:xb7>");
      assertex(num_features > 0, "<dev string:xff>");

      for(i = 0; i < num_aliases; i++) {
        for(j = 0; j < num_features; j++) {
          alias = anim.animselector[statename][traverser].aliases[i];
          feature = anim.animselector[statename][traverser].features[j];
          val = tablelookupbyrow(filename[1], i + 1, j + 1);

          if(val == "") {
            val = undefined;
          } else {
            val = float(val);
          }

          anim.animselector[statename][traverser].values[alias][feature] = val;
        }
      }
    }
  }
}

function checkfeaturevalue(val, feature, featurearray) {
  assertex(isDefined(anim.animselectorfeaturetable), "<dev string:x14d>");
  assertex(isDefined(anim.animselectorfeaturetable[feature]), "<dev string:x17f>" + feature + "<dev string:x19a>");
  featurename = anim.animselectorfeaturetable[feature][0];
  featurereq = anim.animselectorfeaturetable[feature][1];
  featureval = featurearray[featurename];

  if(!isDefined(featureval)) {
    return 1;
  }

  if(featurereq == 0) {
    return (featureval >= val);
  } else if(featurereq == 1) {
    return (featureval <= val);
  }

  assertmsg("<dev string:x1c9>" + feature + "<dev string:x1e5>");
}

function function_99322e10827a8683(statename, featurearray) {
  warningstring = "<dev string:x20b>" + self.animsetname + "<dev string:x237>" + statename + "<dev string:x244>";

  foreach(key, value in featurearray) {
    warningstring = warningstring + key + "<dev string:x255>" + value + "<dev string:x25b>";
  }

  warningstring = warningstring + "<dev string:x261>" + self.origin + "<dev string:x25b>";
  println(warningstring);
}

function selectanim(statename, featurearray, traverserindex) {
  assert(isDefined(anim.animselector[statename]));
  assert(isDefined(traverserindex));
  assertex(traverserindex != -1, "<dev string:x272>");
  traverseinfo = anim.animselector[statename][traverserindex];

  foreach(alias in traverseinfo.aliases) {
    if(isai(self) && !asm_hasalias(statename, alias)) {
      println("<dev string:x29d>" + alias + "<dev string:x2b2>" + statename + "<dev string:x2d6>" + self.animsetname + "<dev string:x2e8>");
      continue;
    }

    var_b4d9ab801dafc0fd = 1;

    foreach(feature in traverseinfo.features) {
      val = traverseinfo.values[alias][feature];

      if(isDefined(val)) {
        if(!checkfeaturevalue(val, feature, featurearray)) {
          var_b4d9ab801dafc0fd = 0;
          break;
        }
      }
    }

    if(var_b4d9ab801dafc0fd) {
      if(isai(self) && alias == "<dev string:x316>") {
        function_99322e10827a8683(statename, featurearray);
      }

      return alias;
    }
  }

  assertmsg("<dev string:x321>" + statename + "<dev string:x354>");
}

function gettraverserindex() {
  archetype = self getbasearchetype();

  if(isDefined(archetype)) {
    switch (archetype) {
      case #"hash_68e7a52445d0df5":
      case #"hash_44aaeb0edd152195":
      case #"hash_4ad475e6e15635bd":
      case #"hash_4ba1525745ce470f":
      case #"hash_62f2aeb0d80aad52":
      case #"hash_85c2b0495aa920dd":
      case #"hash_8f72439a52a5037f":
      case #"hash_a646e2b1476895dd":
      case #"hash_c36adf2d3ad18f39":
        return 0;
      case #"hash_61a5404fe564f969":
      case #"hash_da4c0e7d8f5fe7c5":
      case #"hash_e87767df2e5c3a68":
        return 1;
      default:
        if(isDefined(self.animsetname) && self.animsetname == "suicidebomber_cp") {
          return 2;
        }

        if(isDefined(self.unittype) && self.unittype == "soldier") {
          return 0;
        }

        assertmsg("<dev string:x400>" + self.origin + "<dev string:x41b>" + default_to(self.var_e2b4fc394eef5c0f, "<dev string:x434>") + "<dev string:x439>" + archetype + "<dev string:x449>");
        return -1;
    }
  }

  return -1;
}