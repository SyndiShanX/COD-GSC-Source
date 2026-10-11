/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_24f248b33b79e48d.gsc
*************************************************/

#using script_220d0eb95a8fab7d;
#using script_2707474774db34b;
#using script_3ab210ea917601e7;
#using script_41387eecc35b88bf;
#using script_54f6d121e91434f8;
#using script_5d8202968463a21d;
#using script_6617e2f2bb62b52b;
#using script_7956d56c4922bd1;
#using scripts\common\data_tracker;
#using scripts\common\progress_tracker;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_6ffa16dea1979f22;

function function_572fe6fc04592e85(var_acb3b2a1800aa703) {
  var_a6306814ebb7a58c = var_acb3b2a1800aa703.var_a6306814ebb7a58c;
  var_e690c121ea291e3e = spawnStruct();
  var_e690c121ea291e3e.var_d329713f6ab28a1f = [];

  foreach(broadcast in var_a6306814ebb7a58c.playerbroadcasts) {
    broadcasttype = function_97f68450b5c9ed9f(broadcast);

    if(broadcasttype == "ActivationNameBucket") {
      function_6b83f7908da7ccb7(var_e690c121ea291e3e, broadcast);
      continue;
    }

    var_e690c121ea291e3e.var_d329713f6ab28a1f[var_e690c121ea291e3e.var_d329713f6ab28a1f.size] = broadcast;
  }

  return var_e690c121ea291e3e.var_d329713f6ab28a1f;
}

function function_70dadbed22105e0c(var_f565df3793c12460, broadcastdefinitions) {
  if(!isarray(broadcastdefinitions) || broadcastdefinitions.size == 0) {
    return;
  }

  for(var_7cfcb49cddb466ea = 0; var_7cfcb49cddb466ea < broadcastdefinitions.size; var_7cfcb49cddb466ea++) {
    broadcastdefinition = broadcastdefinitions[var_7cfcb49cddb466ea];
    broadcastdefinition.id = var_f565df3793c12460.var_84827c1e71ea3472;
    var_f565df3793c12460.var_84827c1e71ea3472++;
    var_35e27bed393e774c = function_c24185c47d989c1a(broadcastdefinition);

    if(var_35e27bed393e774c == "ActivationName") {
      broadcastactivationname = function_41392da51bde3a01(broadcastdefinition);

      if(isDefined(broadcastactivationname)) {
        if(!isDefined(var_f565df3793c12460.var_ce5a4a81ad64ed80[broadcastactivationname])) {
          var_f565df3793c12460.var_ce5a4a81ad64ed80[broadcastactivationname] = [];
        }

        activationnamearraysize = var_f565df3793c12460.var_ce5a4a81ad64ed80[broadcastactivationname].size;
        var_f565df3793c12460.var_ce5a4a81ad64ed80[broadcastactivationname][activationnamearraysize] = broadcastdefinition;
        var_f565df3793c12460.var_4e00614961473a63[var_f565df3793c12460.var_4e00614961473a63.size] = broadcastdefinition;
      }

      continue;
    }

    if(!isDefined(var_f565df3793c12460.var_38b0dd2cea06c40b[var_35e27bed393e774c])) {
      var_f565df3793c12460.var_38b0dd2cea06c40b[var_35e27bed393e774c] = [];
    }

    var_955c216995050d2b = var_f565df3793c12460.var_38b0dd2cea06c40b[var_35e27bed393e774c].size;
    var_f565df3793c12460.var_38b0dd2cea06c40b[var_35e27bed393e774c][var_955c216995050d2b] = broadcastdefinition;
    var_f565df3793c12460.var_4e00614961473a63[var_f565df3793c12460.var_4e00614961473a63.size] = broadcastdefinition;
  }
}

function function_1e7b6190459c97f5() {
  var_f565df3793c12460 = spawnStruct();
  var_f565df3793c12460.var_38b0dd2cea06c40b = [];
  var_f565df3793c12460.var_ce5a4a81ad64ed80 = [];
  var_f565df3793c12460.var_4e00614961473a63 = [];
  var_f565df3793c12460.var_84827c1e71ea3472 = 0;
  return var_f565df3793c12460;
}

function function_1c05f7e3290f8e6e(broadcastdefinition) {
  return broadcastdefinition.id;
}

function function_16eb9705410e02ab() {
  return function_c24185c47d989c1a(self.broadcastdefinition);
}

function function_c24185c47d989c1a(broadcastdefinition) {
  if(isDefined(broadcastdefinition.variant_object.activationmoment) && broadcastdefinition.variant_object.activationmoment.size > 0) {
    return broadcastdefinition.variant_object.activationmoment[0].variant_object.activationmoment;
  }

  uniquename = function_97d99a58c1ec5772(broadcastdefinition);
  broadcastuniquename = default_to(uniquename, "<dev string:x1c>");
  assertex(isDefined(uniquename), "<dev string:x23>");

  return "None";
}

function function_6a312795248d0f1c() {
  return function_429075b722e9214d(self.broadcastdefinition);
}

function function_429075b722e9214d(broadcastdefinition) {
  if(isDefined(broadcastdefinition.variant_object.deactivationmoment) && broadcastdefinition.variant_object.deactivationmoment.size > 0) {
    return broadcastdefinition.variant_object.deactivationmoment[0].variant_object.activationmoment;
  }

  return "None";
}

function function_97f68450b5c9ed9f(broadcastdefinition) {
  assertex(isDefined(broadcastdefinition.variant_object.broadcasttype), "<dev string:xa3>");
  return broadcastdefinition.variant_object.broadcasttype;
}

function getbroadcastdestination() {
  return function_f5a44c850aa837e3(self.broadcastdefinition);
}

function function_f5a44c850aa837e3(broadcastdefinition) {
  if(isDefined(broadcastdefinition.variant_object.destination) && broadcastdefinition.variant_object.destination.size > 0) {
    return broadcastdefinition.variant_object.destination[0].variant_object.broadcastdestination;
  }

  broadcastuniquename = default_to(function_97d99a58c1ec5772(broadcastdefinition), "<dev string:x1c>");

  return "Instance";
}

function function_c0e15a98cb263ae6() {
  return function_1f62a8e43252c6b3(self.broadcastdefinition);
}

function function_1f62a8e43252c6b3(broadcastdefinition) {
  assertex(isDefined(broadcastdefinition.variant_object.priority), "<dev string:xf4>");
  prioritynum = 2;

  switch (broadcastdefinition.variant_object.priority) {
    case #"hash_4f2a820d1b7462cf":
      prioritynum = 0;
      break;
    case #"hash_3e26921a2943163d":
      prioritynum = 1;
      break;
    case #"hash_4d3d7a9f6b7b2fb6":
      prioritynum = 2;
      break;
    case #"hash_1dd8746c9fb86ec1":
      prioritynum = 3;
      break;
    case #"hash_ee858280143c22fb":
      prioritynum = 4;
      break;
    default:
      break;
  }

  return prioritynum;
}

function function_ecce2ca2c125d18b(broadcastdefinition) {
  return istrue(broadcastdefinition.variant_object.var_67bacee34bc7dbcc);
}

function function_3c05525e7efc4bc3(broadcastdefinition) {
  if(isDefined(broadcastdefinition.variant_object.var_183531a09f83701e) && broadcastdefinition.variant_object.var_183531a09f83701e.size > 0) {
    return broadcastdefinition.variant_object.var_183531a09f83701e[0].variant_object.var_b5131ed52726b9c1;
  }

  broadcasttype = function_97f68450b5c9ed9f(broadcastdefinition);
  return function_d7c3ce8df52d35c9(broadcasttype);
}

function function_84c3c2bce8659070(broadcastdefinition) {
  var_b5131ed52726b9c1 = function_3c05525e7efc4bc3(broadcastdefinition);
  assertex(var_b5131ed52726b9c1 == "<dev string:x155>", "<dev string:x15e>");

  if(isDefined(broadcastdefinition.variant_object.var_183531a09f83701e) && broadcastdefinition.variant_object.var_183531a09f83701e.size > 0) {
    var_15309dae6e19a117 = broadcastdefinition.variant_object.var_183531a09f83701e[0].variant_object.maximumdelaytime;

    if(isDefined(var_15309dae6e19a117)) {
      return var_15309dae6e19a117;
    }
  }

  return 10;
}

function function_75002b8400884f8(broadcastinstance) {
  broadcastinstance = default_to(broadcastinstance, self);
  assertex(function_9cf7afd6797ae365(broadcastinstance), "<dev string:x1cc>");
  return istrue(broadcastinstance.broadcastdefinition.variant_object.var_3994ad54a864b660);
}

function function_32cce566a03b93e9(broadcastinstance) {
  broadcastinstance = default_to(broadcastinstance, self);
  assertex(function_9cf7afd6797ae365(broadcastinstance), "<dev string:x1cc>");
  var_2f881c28157cc352 = function_d20c7983c54fc98a(broadcastinstance);

  if(function_75002b8400884f8(broadcastinstance) || var_2f881c28157cc352) {
    return true;
  }

  return false;
}

function function_d20c7983c54fc98a(broadcastinstance, uniquename) {
  broadcastinstance = default_to(broadcastinstance, self);
  assertex(function_9cf7afd6797ae365(broadcastinstance), "<dev string:x1cc>");
  dataobjects = broadcastinstance function_7437a8d48556e45e();

  foreach(dataobject in dataobjects) {
    dynamicdatastructs = function_f04267a7d3561996(dataobject);

    if(dynamicdatastructs.size > 0) {
      if(isDefined(uniquename)) {
        foreach(dynamicdatastruct in dynamicdatastructs) {
          if(uniquename == dynamicdatastruct.variant_object.uniquename) {
            return true;
          }
        }

        continue;
      }

      return true;
    }
  }

  return false;
}

function getuniquename() {
  return function_97d99a58c1ec5772(self.broadcastdefinition);
}

function function_97d99a58c1ec5772(broadcastdefinition) {
  if(isDefined(broadcastdefinition.variant_object.uniquename)) {
    return broadcastdefinition.variant_object.uniquename;
  }

  return undefined;
}

function getactivationname() {
  return function_41392da51bde3a01(self.broadcastdefinition);
}

function function_41392da51bde3a01(broadcastdefinition) {
  activationmoment = function_c24185c47d989c1a(broadcastdefinition);
  assertex(activationmoment == "<dev string:x25a>", "<dev string:x26c>");
  assertex(isDefined(broadcastdefinition.variant_object.activationmoment[0].variant_object.activationname), "<dev string:x2d9>");
  return broadcastdefinition.variant_object.activationmoment[0].variant_object.activationname;
}

function getdeactivationname() {
  return function_74e4bce48b3a6552(self.broadcastdefinition);
}

function function_74e4bce48b3a6552(broadcastdefinition) {
  var_1c7a0ae1a3f274b0 = function_429075b722e9214d(broadcastdefinition);

  if(isDefined(var_1c7a0ae1a3f274b0) && var_1c7a0ae1a3f274b0 == "ActivationName") {
    return broadcastdefinition.variant_object.deactivationmoment[0].variant_object.deactivationname;
  } else {
    var_a27a0ebc43f2eb60 = istrue(isDefined(var_1c7a0ae1a3f274b0) && var_1c7a0ae1a3f274b0 != "<dev string:x25a>");
    assertex(var_a27a0ebc43f2eb60, "<dev string:x335>");
  }

  return undefined;
}

function function_45575393a3d8e399(broadcastinstance) {
  broadcastdestination = broadcastinstance getbroadcastdestination();

  if("<dev string:x3be>" != broadcastdestination) {
    assertmsg("<dev string:x3ca>" + broadcastinstance getbroadcastuniqueid() + "<dev string:x3de>");
    return;
  }

  broadcastinstancespatialzonename = "Broadcast Spatial Zone: " + broadcastinstance getbroadcastuniqueid();

  if(!namespace_8480efeffcd6e233::function_1888d1b2aeeda25(self, broadcastinstancespatialzonename)) {
    zoneinfostruct = broadcastinstance.broadcastdefinition.variant_object.destination[0].variant_object.broadcastdistance[0].variant_object;
    namespace_c8e2077fca5ac679::function_c3c41d6d385b5b81(self, broadcastinstancespatialzonename, zoneinfostruct);
  }

  return namespace_8480efeffcd6e233::function_7ec62d1550b9897e(self, broadcastinstancespatialzonename);
}

function function_b4f81cd2bdc5602e(activationmoment) {
  var_20a64c9312332c84 = [];
  var_88234ac4109fc206 = function_85f01c1d56e32f7c(self, activationmoment);

  if(!isDefined(var_88234ac4109fc206) || istrue(var_88234ac4109fc206)) {
    var_f565df3793c12460 = function_42a790b5e4c0dd36(self);
    var_8325119ddf1616e0 = var_f565df3793c12460.var_38b0dd2cea06c40b[activationmoment];

    if(isDefined(var_8325119ddf1616e0)) {
      for(broadcastarrayindex = 0; broadcastarrayindex < var_8325119ddf1616e0.size; broadcastarrayindex++) {
        broadcastdefinition = var_8325119ddf1616e0[broadcastarrayindex];
        broadcastdefinitionid = function_1c05f7e3290f8e6e(broadcastdefinition);
        var_20a64c9312332c84[var_20a64c9312332c84.size] = function_3c4e7239271dbe30(broadcastdefinition, broadcastdefinitionid);
      }
    }
  }

  return var_20a64c9312332c84;
}

function function_709eb291cbeeb02(activityinstance, uniquename) {
  var_b77f3618b272f4a4 = undefined;
  var_f565df3793c12460 = function_42a790b5e4c0dd36(activityinstance);

  var_c850801a15ad511b = 0;

  for(broadcastarrayindex = 0; broadcastarrayindex < var_f565df3793c12460.var_4e00614961473a63.size; broadcastarrayindex++) {
    broadcastdefinition = var_f565df3793c12460.var_4e00614961473a63[broadcastarrayindex];
    broadcastuniquename = function_97d99a58c1ec5772(broadcastdefinition);

    if(isDefined(broadcastuniquename) && broadcastuniquename == uniquename) {
      broadcastdefinitionid = function_1c05f7e3290f8e6e(broadcastdefinition);
      var_b77f3618b272f4a4 = function_3c4e7239271dbe30(broadcastdefinition, broadcastdefinitionid);

      var_c850801a15ad511b++;
    }
  }

  if(var_c850801a15ad511b == 0) {
    assertmsg("<dev string:x43f>");
  } else if(var_c850801a15ad511b > 1) {
    assertmsg("<dev string:x4c9>");
  }

  return var_b77f3618b272f4a4;
}

function function_e38f1d6d5a208fe1(activationname, specificbroadcasttype) {
  var_aee1297400a66c99 = [];
  var_f565df3793c12460 = function_42a790b5e4c0dd36(self);
  var_76f28f9ed47d04b6 = var_f565df3793c12460.var_ce5a4a81ad64ed80[activationname];

  if(isDefined(var_76f28f9ed47d04b6)) {
    for(broadcastarrayindex = 0; broadcastarrayindex < var_76f28f9ed47d04b6.size; broadcastarrayindex++) {
      broadcastdefinition = var_76f28f9ed47d04b6[broadcastarrayindex];
      broadcasttypeisallowed = !isDefined(specificbroadcasttype) || specificbroadcasttype == function_97f68450b5c9ed9f(broadcastdefinition);

      if(broadcasttypeisallowed) {
        broadcastdefinitionid = function_1c05f7e3290f8e6e(broadcastdefinition);
        var_aee1297400a66c99[var_aee1297400a66c99.size] = function_3c4e7239271dbe30(broadcastdefinition, broadcastdefinitionid);
      }
    }
  }

  return var_aee1297400a66c99;
}

function function_a577c68231ddca0b(broadcastdefinition) {
  assertex(isDefined(broadcastdefinition.variant_object.broadcastdata) && isDefined(broadcastdefinition.variant_object.broadcastdata.size > 0), "<dev string:x56e>");
  return broadcastdefinition.variant_object.broadcastdata;
}

function function_feb90d1dee0c97d1(broadcastdataobject) {
  return broadcastdataobject.variant_type;
}

function function_2756e9e9dc98a709(broadcastdataobject) {
  assertex(isDefined(broadcastdataobject.variant_object.stringreference), "<dev string:x5b9>");
  return broadcastdataobject.variant_object.stringreference;
}

function function_f26baa739c00a3c7(broadcastdataobject) {
  assertex(isDefined(broadcastdataobject.variant_object.splashreference), "<dev string:x622>");
  return broadcastdataobject.variant_object.splashreference;
}

function function_dbb11dc6ea65794e(broadcastdataobject) {
  return broadcastdataobject.variant_object.splashlistoverride;
}

function function_79dc6a4dd519d5cd(broadcastdataobject) {
  return broadcastdataobject.variant_object.musicreference;
}

function function_8cc6c17907ab41bf(broadcastdataobject) {
  return broadcastdataobject.variant_object.musicdelay;
}

function function_84ac089886facee5(broadcastdataobject) {
  assertex(isDefined(broadcastdataobject.variant_object.var_9404a226fab29acd), "<dev string:x68b>");
  return broadcastdataobject.variant_object.var_9404a226fab29acd;
}

function function_5be1a4fd3bd9c0a7(broadcastdataobject) {
  return istrue(broadcastdataobject.variant_object.var_26c983ff67cd2a4f);
}

function function_63b7c6f0e6f2a9f7(broadcastdataobject) {
  return istrue(broadcastdataobject.variant_object.shouldinterruptcurrent);
}

function function_ffbb8d6b4076cfa7(broadcastdataobject) {
  return broadcastdataobject.variant_object.var_c86c03369dc036bf;
}

function function_61d68ed67d014ce9(broadcastdataobject) {
  assertex(isDefined(broadcastdataobject.variant_object.omnvarname), "<dev string:x6fc>");
  return broadcastdataobject.variant_object.omnvarname;
}

function function_35f7a3c169395432(broadcastdataobject) {
  assertex(isDefined(broadcastdataobject.variant_object.omnvartype), "<dev string:x760>");
  return broadcastdataobject.variant_object.omnvartype;
}

function function_5a2dda4763cf5dcb(broadcastdataobject) {
  if(!isDefined(broadcastdataobject.variant_object.omnvarvalue)) {
    omnvartype = function_35f7a3c169395432(broadcastdataobject);

    switch (omnvartype) {
      case #"hash_4730906c2f53f03e":
        return 0;
      case #"hash_7e95f72ed09f139d":
        return 0;
      case #"hash_3e4a6f464c850b65":
        return 0;
      case #"hash_2ac140ce3b5ea398":
        return "";
      default:
        assertmsg("<dev string:x7c4>" + default_to(omnvartype, "<dev string:x80d>") + "<dev string:x81a>");
        break;
    }
  }

  return broadcastdataobject.variant_object.omnvarvalue;
}

function function_2e71b566ccbca32a(broadcastdataobject) {
  return broadcastdataobject.variant_object.var_cf52064ee3abd32;
}

function function_4e3ccf5ebd81daea(broadcastdataobject) {
  if(isDefined(broadcastdataobject.variant_object.stylesettings) && broadcastdataobject.variant_object.stylesettings.size > 0) {
    return broadcastdataobject.variant_object.stylesettings[0].variant_object.broadcaststyle;
  }

  return "None";
}

function function_b683ad721a792a8e(broadcastdataobject) {
  if(isDefined(broadcastdataobject.variant_object.stylesettings) && broadcastdataobject.variant_object.stylesettings.size > 0) {
    return broadcastdataobject.variant_object.stylesettings[0].variant_object;
  }

  assertmsg("<dev string:x85d>");
  return undefined;
}

function function_f04267a7d3561996(broadcastdataobject) {
  if(isDefined(broadcastdataobject.variant_object.dynamicdata)) {
    return broadcastdataobject.variant_object.dynamicdata;
  }

  return [];
}

function function_684411bce1d1c8bc(broadcastinstance, broadcastdataobject, var_19266e4011b5f63d) {
  dynamicdatastructs = function_f04267a7d3561996(broadcastdataobject);
  var_839a3b46d36c45b7 = dynamicdatastructs[var_19266e4011b5f63d];

  if(isDefined(var_839a3b46d36c45b7)) {
    associateddatatracker = broadcastinstance function_8362248b8fb9637f();
    var_aa30a02555c77ef8 = function_4a145984b790852f(var_839a3b46d36c45b7);
    dynamicdatatype = function_add6a5e1e7f656c7(var_839a3b46d36c45b7);
    var_1336db8efd12ba34 = associateddatatracker scripts\common\data_tracker::function_6a26856f16c6a207(var_aa30a02555c77ef8);
    dynamicdataformat = default_to(var_839a3b46d36c45b7.variant_object.format, undefined);
    var_e89c655fba344976 = function_a2ddac402ee3ea8f(dynamicdatatype, undefined, dynamicdataformat);

    if(var_1336db8efd12ba34) {
      var_e89c655fba344976.value = associateddatatracker scripts\common\data_tracker::getdatavalue(var_aa30a02555c77ef8);
    } else {
      var_e89c655fba344976.value = function_ec28f992a3ffd931(var_839a3b46d36c45b7);
    }

    return var_e89c655fba344976;
  }

  return undefined;
}

function function_298a9e5ee57b3737(broadcastformat, startingvalue, currentvalue, endvalue) {
  if(broadcastformat == "X_Complete") {
    return [currentvalue];
  } else if(broadcastformat == "X_Remaining") {
    assertex(isDefined(endvalue), "<dev string:x8ce>");
    remainingvalue = abs(endvalue - currentvalue);
    return [remainingvalue];
  } else if(broadcastformat == "X_Out_Of_Y") {
    assertex(isDefined(endvalue), "<dev string:x8ce>");
    return [currentvalue, endvalue];
  } else if(broadcastformat == "X_Percentage_Complete") {
    assertex(isDefined(endvalue), "<dev string:x8ce>");
    totalvalue = abs(endvalue - startingvalue);
    percentagecomplete = currentvalue / totalvalue * 100;

    if(endvalue < startingvalue) {
      numerator = totalvalue - currentvalue;
      percentagecomplete = numerator / totalvalue * 100;
    }

    return [percentagecomplete];
  } else if(broadcastformat == "X_Percentage_Remaining") {
    assertex(isDefined(endvalue), "<dev string:x8ce>");
    totalvalue = abs(endvalue - startingvalue);
    percentageremaining = currentvalue / totalvalue * 100;

    if(endvalue > startingvalue) {
      numerator = totalvalue - currentvalue;
      percentageremaining = numerator / totalvalue * 100;
    }

    return [percentageremaining];
  } else if(broadcastformat == "XX_YY_Clock") {
    minutes = currentvalue / 60;
    leftnumber = floor(minutes);
    rightnumber = floor((minutes - leftnumber) * 60);
    return [leftnumber, rightnumber];
  } else {
    assertmsg("<dev string:x935>");
  }

  return [currentvalue];
}

function private function_3c4e7239271dbe30(broadcastdefinition, broadcastid) {
  broadcastinstance = function_91be3e69db760bef(broadcastdefinition, broadcastid);
  assertex(isDefined(broadcastinstance), "<dev string:x99f>");
  activebroadcastinstance = getactivebroadcastinstance(broadcastinstance getbroadcastuniqueid());

  if(isDefined(activebroadcastinstance)) {
    return activebroadcastinstance;
  }

  return broadcastinstance;
}

function private function_91be3e69db760bef(broadcastdefinition, broadcastid) {
  activityinstance = self;
  broadcasttype = function_97f68450b5c9ed9f(broadcastdefinition);
  broadcastinstance = function_3186d88f9311acf4(broadcasttype);
  broadcastinstance.groupid = activityinstance.id;
  broadcastinstance.uniqueid = activityinstance.id + " broadcast ID: " + broadcastid;
  broadcastinstance.broadcastdefinition = broadcastdefinition;
  broadcastinstance function_a2b3a19c012e474b(activityinstance);
  broadcastinstance.var_57214832d7aad3b6 = function_af0f8a1d90725bfa(broadcastdefinition);
  broadcastinstance.broadcastdataobjects = function_a577c68231ddca0b(broadcastdefinition);
  activityinstance function_8cd36bde2e65efd1(broadcastinstance, broadcastdefinition);
  return broadcastinstance;
}

function private function_8cd36bde2e65efd1(broadcastinstance, broadcastdefinition) {
  activityinstance = self;
  var_afb5c037a8f13bd5 = broadcastinstance function_c3bc406fe5bf3d79(broadcastdefinition);
  var_b917dfe737d8414f = !function_ecce2ca2c125d18b(broadcastdefinition);
  var_b5131ed52726b9c1 = function_3c05525e7efc4bc3(broadcastdefinition);
  var_57bae934aff55b69 = var_b5131ed52726b9c1 != "None";
  function_fd7a0d7af53408c9(broadcastinstance, activityinstance, var_b917dfe737d8414f, var_afb5c037a8f13bd5, var_57bae934aff55b69);

  if(var_b5131ed52726b9c1 != "None") {
    if(var_b5131ed52726b9c1 == "Delay") {
      var_15309dae6e19a117 = function_84c3c2bce8659070(broadcastdefinition);
      broadcastinstance function_15c75941af255c67(var_15309dae6e19a117);
    }
  }
}

function private function_a2ddac402ee3ea8f(datatype, value, format) {
  var_e89c655fba344976 = spawnStruct();
  var_e89c655fba344976.type = datatype;
  var_e89c655fba344976.value = value;
  var_e89c655fba344976.format = format;
  return var_e89c655fba344976;
}

function private function_4a145984b790852f(var_8f2fc031475aef64) {
  defaultuniquename = "<dev string:x9e5>";

  if(!isDefined(var_8f2fc031475aef64.variant_object.uniquename) || var_8f2fc031475aef64.variant_object.uniquename == defaultuniquename) {
    assertmsg("<dev string:xa1c>");
  }

  return var_8f2fc031475aef64.variant_object.uniquename;
}

function private function_add6a5e1e7f656c7(var_cd1bcf4d1329635e) {
  return var_cd1bcf4d1329635e.variant_object.dynamicdatatype;
}

function private function_ec28f992a3ffd931(var_cd1bcf4d1329635e) {
  dynamicdatatype = function_add6a5e1e7f656c7(var_cd1bcf4d1329635e);
  defaultvalue = var_cd1bcf4d1329635e.variant_object.defaultvalue;

  if(dynamicdatatype == "ProgressTracker") {
    return scripts\common\progress_tracker::createprogresstracker(defaultvalue.defaultstartingvalue, defaultvalue.defaultfinalvalue);
  }

  return defaultvalue;
}

function private function_6b83f7908da7ccb7(var_e690c121ea291e3e, dialogbucket) {
  foreach(broadcastdata in dialogbucket.variant_object.broadcastdata) {
    var_420b9a9f4293a416 = structcopy(dialogbucket, 1);
    function_4c3aca27bf7091cb(var_420b9a9f4293a416, broadcastdata.variant_object.activationname);

    if(broadcastdata.variant_type == "Types_ActivityBroadcastData_ActivationName_StringReference") {
      function_fea9146cdc329ceb(var_420b9a9f4293a416, "StringReference");
    } else if(broadcastdata.variant_type == "Types_ActivityBroadcastData_ActivationName_SplashReference") {
      function_fea9146cdc329ceb(var_420b9a9f4293a416, "TitleSplash");
    } else if(broadcastdata.variant_type == "Types_ActivityBroadcastData_ActivationName_MusicReference") {
      function_fea9146cdc329ceb(var_420b9a9f4293a416, "Music");
    } else if(broadcastdata.variant_type == "Types_ActivityBroadcastData_ActivationName_OverlordReference" || broadcastdata.variant_type == "Types_ActivityBroadcastData_ActivationName_OverlordConversation") {
      function_fea9146cdc329ceb(var_420b9a9f4293a416, "Overlord");
    } else if(broadcastdata.variant_type == "Types_ActivityBroadcastData_ActivationName_Omnvar") {
      function_fea9146cdc329ceb(var_420b9a9f4293a416, "Omnvar");
    }

    var_420b9a9f4293a416.variant_object.broadcastdata = [broadcastdata];
    var_e690c121ea291e3e.var_d329713f6ab28a1f[var_e690c121ea291e3e.var_d329713f6ab28a1f.size] = var_420b9a9f4293a416;
  }
}

function private function_4c3aca27bf7091cb(broadcastdefinition, activationname) {
  activationmoment = function_c24185c47d989c1a(broadcastdefinition);
  assertex(activationmoment == "<dev string:x25a>", "<dev string:x26c>");
  broadcastdefinition.variant_object.activationmoment[0].variant_object.activationname = activationname;
}

function private function_fea9146cdc329ceb(broadcastdefinition, broadcasttype) {
  broadcastdefinition.variant_object.broadcasttype = broadcasttype;
}

function private function_c3bc406fe5bf3d79(broadcastdefinition) {
  return istrue(broadcastdefinition.variant_object.var_b3c357c514efd6dc);
}

function private function_af0f8a1d90725bfa(broadcastdefinition) {
  return istrue(broadcastdefinition.variant_object.var_57214832d7aad3b6);
}