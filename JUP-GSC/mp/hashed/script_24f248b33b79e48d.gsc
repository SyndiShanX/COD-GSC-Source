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

  foreach(broadcast in var_a6306814ebb7a58c.var_76fc63fd0797ef6c) {
    broadcasttype = function_97f68450b5c9ed9f(broadcast);

    if(broadcasttype == "ActivationNameBucket") {
      function_6b83f7908da7ccb7(var_e690c121ea291e3e, broadcast);
      continue;
    }

    var_e690c121ea291e3e.var_d329713f6ab28a1f[var_e690c121ea291e3e.var_d329713f6ab28a1f.size] = broadcast;
  }

  return var_e690c121ea291e3e.var_d329713f6ab28a1f;
}

function function_70dadbed22105e0c(var_f565df3793c12460, var_ce71fe28918136c6) {
  if(!isarray(var_ce71fe28918136c6) || var_ce71fe28918136c6.size == 0) {
    return;
  }

  for(var_7cfcb49cddb466ea = 0; var_7cfcb49cddb466ea < var_ce71fe28918136c6.size; var_7cfcb49cddb466ea++) {
    broadcastdefinition = var_ce71fe28918136c6[var_7cfcb49cddb466ea];
    broadcastdefinition.id = var_f565df3793c12460.var_84827c1e71ea3472;
    var_f565df3793c12460.var_84827c1e71ea3472++;
    var_35e27bed393e774c = function_c24185c47d989c1a(broadcastdefinition);

    if(var_35e27bed393e774c == "ActivationName") {
      var_f3c55aafff2be133 = function_41392da51bde3a01(broadcastdefinition);

      if(isDefined(var_f3c55aafff2be133)) {
        if(!isDefined(var_f565df3793c12460.var_ce5a4a81ad64ed80[var_f3c55aafff2be133])) {
          var_f565df3793c12460.var_ce5a4a81ad64ed80[var_f3c55aafff2be133] = [];
        }

        var_c3b7e14420005f1a = var_f565df3793c12460.var_ce5a4a81ad64ed80[var_f3c55aafff2be133].size;
        var_f565df3793c12460.var_ce5a4a81ad64ed80[var_f3c55aafff2be133][var_c3b7e14420005f1a] = broadcastdefinition;
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
  if(isDefined(broadcastdefinition.variant_object.var_a84449a9bd492279) && broadcastdefinition.variant_object.var_a84449a9bd492279.size > 0) {
    return broadcastdefinition.variant_object.var_a84449a9bd492279[0].variant_object.var_a84449a9bd492279;
  }

  uniquename = function_97d99a58c1ec5772(broadcastdefinition);
  var_5ae6a11bbc87d784 = default_to(uniquename, "<dev string:x1c>");
  assertex(isDefined(uniquename), "<dev string:x23>");

  return "None";
}

function function_6a312795248d0f1c() {
  return function_429075b722e9214d(self.broadcastdefinition);
}

function function_429075b722e9214d(broadcastdefinition) {
  if(isDefined(broadcastdefinition.variant_object.var_7c0025e4cf44b11a) && broadcastdefinition.variant_object.var_7c0025e4cf44b11a.size > 0) {
    return broadcastdefinition.variant_object.var_7c0025e4cf44b11a[0].variant_object.var_a84449a9bd492279;
  }

  return "None";
}

function function_97f68450b5c9ed9f(broadcastdefinition) {
  assertex(isDefined(broadcastdefinition.variant_object.broadcasttype), "<dev string:xa3>");
  return broadcastdefinition.variant_object.broadcasttype;
}

function function_c9dd0ad4f024db96() {
  return function_f5a44c850aa837e3(self.broadcastdefinition);
}

function function_f5a44c850aa837e3(broadcastdefinition) {
  if(isDefined(broadcastdefinition.variant_object.destination) && broadcastdefinition.variant_object.destination.size > 0) {
    return broadcastdefinition.variant_object.destination[0].variant_object.broadcastdestination;
  }

  var_5ae6a11bbc87d784 = default_to(function_97d99a58c1ec5772(broadcastdefinition), "<dev string:x1c>");

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
    var_b082ea0e98192364 = function_f04267a7d3561996(dataobject);

    if(var_b082ea0e98192364.size > 0) {
      if(isDefined(uniquename)) {
        foreach(var_12b1a5e86193d37f in var_b082ea0e98192364) {
          if(uniquename == var_12b1a5e86193d37f.variant_object.uniquename) {
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

function function_4f3f1f9cedf2d883() {
  return function_97d99a58c1ec5772(self.broadcastdefinition);
}

function function_97d99a58c1ec5772(broadcastdefinition) {
  if(isDefined(broadcastdefinition.variant_object.uniquename)) {
    return broadcastdefinition.variant_object.uniquename;
  }

  return undefined;
}

function function_27486f42d37da990() {
  return function_41392da51bde3a01(self.broadcastdefinition);
}

function function_41392da51bde3a01(broadcastdefinition) {
  var_a84449a9bd492279 = function_c24185c47d989c1a(broadcastdefinition);
  assertex(var_a84449a9bd492279 == "<dev string:x25a>", "<dev string:x26c>");
  assertex(isDefined(broadcastdefinition.variant_object.var_a84449a9bd492279[0].variant_object.activationname), "<dev string:x2d9>");
  return broadcastdefinition.variant_object.var_a84449a9bd492279[0].variant_object.activationname;
}

function function_a3b4a80d61094f63() {
  return function_74e4bce48b3a6552(self.broadcastdefinition);
}

function function_74e4bce48b3a6552(broadcastdefinition) {
  var_1c7a0ae1a3f274b0 = function_429075b722e9214d(broadcastdefinition);

  if(isDefined(var_1c7a0ae1a3f274b0) && var_1c7a0ae1a3f274b0 == "ActivationName") {
    return broadcastdefinition.variant_object.var_7c0025e4cf44b11a[0].variant_object.deactivationname;
  } else {
    var_a27a0ebc43f2eb60 = istrue(isDefined(var_1c7a0ae1a3f274b0) && var_1c7a0ae1a3f274b0 != "<dev string:x25a>");
    assertex(var_a27a0ebc43f2eb60, "<dev string:x335>");
  }

  return undefined;
}

function function_45575393a3d8e399(broadcastinstance) {
  broadcastdestination = broadcastinstance function_c9dd0ad4f024db96();

  if("<dev string:x3be>" != broadcastdestination) {
    assertmsg("<dev string:x3ca>" + broadcastinstance function_cf54c2c8650d9688() + "<dev string:x3de>");
    return;
  }

  var_c48f0dda5b074110 = "Broadcast Spatial Zone: " + broadcastinstance function_cf54c2c8650d9688();

  if(!namespace_8480efeffcd6e233::function_1888d1b2aeeda25(self, var_c48f0dda5b074110)) {
    var_a845183e758f6b9e = broadcastinstance.broadcastdefinition.variant_object.destination[0].variant_object.broadcastdistance[0].variant_object;
    namespace_c8e2077fca5ac679::function_c3c41d6d385b5b81(self, var_c48f0dda5b074110, var_a845183e758f6b9e);
  }

  return namespace_8480efeffcd6e233::function_7ec62d1550b9897e(self, var_c48f0dda5b074110);
}

function function_b4f81cd2bdc5602e(var_a84449a9bd492279) {
  var_20a64c9312332c84 = [];
  var_88234ac4109fc206 = function_85f01c1d56e32f7c(self, var_a84449a9bd492279);

  if(!isDefined(var_88234ac4109fc206) || istrue(var_88234ac4109fc206)) {
    var_f565df3793c12460 = function_42a790b5e4c0dd36(self);
    var_8325119ddf1616e0 = var_f565df3793c12460.var_38b0dd2cea06c40b[var_a84449a9bd492279];

    if(isDefined(var_8325119ddf1616e0)) {
      for(var_4acb1935b73e5153 = 0; var_4acb1935b73e5153 < var_8325119ddf1616e0.size; var_4acb1935b73e5153++) {
        broadcastdefinition = var_8325119ddf1616e0[var_4acb1935b73e5153];
        var_8649a137ff962c24 = function_1c05f7e3290f8e6e(broadcastdefinition);
        var_20a64c9312332c84[var_20a64c9312332c84.size] = function_3c4e7239271dbe30(broadcastdefinition, var_8649a137ff962c24);
      }
    }
  }

  return var_20a64c9312332c84;
}

function function_709eb291cbeeb02(activityinstance, uniquename) {
  var_b77f3618b272f4a4 = undefined;
  var_f565df3793c12460 = function_42a790b5e4c0dd36(activityinstance);

  var_c850801a15ad511b = 0;

  for(var_4acb1935b73e5153 = 0; var_4acb1935b73e5153 < var_f565df3793c12460.var_4e00614961473a63.size; var_4acb1935b73e5153++) {
    broadcastdefinition = var_f565df3793c12460.var_4e00614961473a63[var_4acb1935b73e5153];
    var_5ae6a11bbc87d784 = function_97d99a58c1ec5772(broadcastdefinition);

    if(isDefined(var_5ae6a11bbc87d784) && var_5ae6a11bbc87d784 == uniquename) {
      var_8649a137ff962c24 = function_1c05f7e3290f8e6e(broadcastdefinition);
      var_b77f3618b272f4a4 = function_3c4e7239271dbe30(broadcastdefinition, var_8649a137ff962c24);

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

function function_e38f1d6d5a208fe1(activationname, var_90e824cc8b12a39c) {
  var_aee1297400a66c99 = [];
  var_f565df3793c12460 = function_42a790b5e4c0dd36(self);
  var_76f28f9ed47d04b6 = var_f565df3793c12460.var_ce5a4a81ad64ed80[activationname];

  if(isDefined(var_76f28f9ed47d04b6)) {
    for(var_4acb1935b73e5153 = 0; var_4acb1935b73e5153 < var_76f28f9ed47d04b6.size; var_4acb1935b73e5153++) {
      broadcastdefinition = var_76f28f9ed47d04b6[var_4acb1935b73e5153];
      var_352832458f7b0400 = !isDefined(var_90e824cc8b12a39c) || var_90e824cc8b12a39c == function_97f68450b5c9ed9f(broadcastdefinition);

      if(var_352832458f7b0400) {
        var_8649a137ff962c24 = function_1c05f7e3290f8e6e(broadcastdefinition);
        var_aee1297400a66c99[var_aee1297400a66c99.size] = function_3c4e7239271dbe30(broadcastdefinition, var_8649a137ff962c24);
      }
    }
  }

  return var_aee1297400a66c99;
}

function function_a577c68231ddca0b(broadcastdefinition) {
  assertex(isDefined(broadcastdefinition.variant_object.broadcastdata) && isDefined(broadcastdefinition.variant_object.broadcastdata.size > 0), "<dev string:x56e>");
  return broadcastdefinition.variant_object.broadcastdata;
}

function function_feb90d1dee0c97d1(var_4ed40899ed266f0f) {
  return var_4ed40899ed266f0f.variant_type;
}

function function_2756e9e9dc98a709(var_4ed40899ed266f0f) {
  assertex(isDefined(var_4ed40899ed266f0f.variant_object.stringreference), "<dev string:x5b9>");
  return var_4ed40899ed266f0f.variant_object.stringreference;
}

function function_f26baa739c00a3c7(var_4ed40899ed266f0f) {
  assertex(isDefined(var_4ed40899ed266f0f.variant_object.splashreference), "<dev string:x622>");
  return var_4ed40899ed266f0f.variant_object.splashreference;
}

function function_dbb11dc6ea65794e(var_4ed40899ed266f0f) {
  return var_4ed40899ed266f0f.variant_object.var_42b1e877ab187c6;
}

function function_79dc6a4dd519d5cd(var_4ed40899ed266f0f) {
  return var_4ed40899ed266f0f.variant_object.musicreference;
}

function function_8cc6c17907ab41bf(var_4ed40899ed266f0f) {
  return var_4ed40899ed266f0f.variant_object.musicdelay;
}

function function_84ac089886facee5(var_4ed40899ed266f0f) {
  assertex(isDefined(var_4ed40899ed266f0f.variant_object.var_9404a226fab29acd), "<dev string:x68b>");
  return var_4ed40899ed266f0f.variant_object.var_9404a226fab29acd;
}

function function_5be1a4fd3bd9c0a7(var_4ed40899ed266f0f) {
  return istrue(var_4ed40899ed266f0f.variant_object.var_26c983ff67cd2a4f);
}

function function_63b7c6f0e6f2a9f7(var_4ed40899ed266f0f) {
  return istrue(var_4ed40899ed266f0f.variant_object.var_a992c85bbf2c3bd6);
}

function function_ffbb8d6b4076cfa7(var_4ed40899ed266f0f) {
  return var_4ed40899ed266f0f.variant_object.var_c86c03369dc036bf;
}

function function_61d68ed67d014ce9(var_4ed40899ed266f0f) {
  assertex(isDefined(var_4ed40899ed266f0f.variant_object.var_e9d476a3809cb3f1), "<dev string:x6fc>");
  return var_4ed40899ed266f0f.variant_object.var_e9d476a3809cb3f1;
}

function function_35f7a3c169395432(var_4ed40899ed266f0f) {
  assertex(isDefined(var_4ed40899ed266f0f.variant_object.var_26641d000f48954a), "<dev string:x760>");
  return var_4ed40899ed266f0f.variant_object.var_26641d000f48954a;
}

function function_5a2dda4763cf5dcb(var_4ed40899ed266f0f) {
  if(!isDefined(var_4ed40899ed266f0f.variant_object.omnvarvalue)) {
    var_26641d000f48954a = function_35f7a3c169395432(var_4ed40899ed266f0f);

    switch (var_26641d000f48954a) {
      case #"hash_4730906c2f53f03e":
        return 0;
      case #"hash_7e95f72ed09f139d":
        return 0;
      case #"hash_3e4a6f464c850b65":
        return 0;
      case #"hash_2ac140ce3b5ea398":
        return "";
      default:
        assertmsg("<dev string:x7c4>" + default_to(var_26641d000f48954a, "<dev string:x80d>") + "<dev string:x81a>");
        break;
    }
  }

  return var_4ed40899ed266f0f.variant_object.omnvarvalue;
}

function function_2e71b566ccbca32a(var_4ed40899ed266f0f) {
  return var_4ed40899ed266f0f.variant_object.var_cf52064ee3abd32;
}

function function_4e3ccf5ebd81daea(var_4ed40899ed266f0f) {
  if(isDefined(var_4ed40899ed266f0f.variant_object.stylesettings) && var_4ed40899ed266f0f.variant_object.stylesettings.size > 0) {
    return var_4ed40899ed266f0f.variant_object.stylesettings[0].variant_object.broadcaststyle;
  }

  return "None";
}

function function_b683ad721a792a8e(var_4ed40899ed266f0f) {
  if(isDefined(var_4ed40899ed266f0f.variant_object.stylesettings) && var_4ed40899ed266f0f.variant_object.stylesettings.size > 0) {
    return var_4ed40899ed266f0f.variant_object.stylesettings[0].variant_object;
  }

  assertmsg("<dev string:x85d>");
  return undefined;
}

function function_f04267a7d3561996(var_4ed40899ed266f0f) {
  if(isDefined(var_4ed40899ed266f0f.variant_object.dynamicdata)) {
    return var_4ed40899ed266f0f.variant_object.dynamicdata;
  }

  return [];
}

function function_684411bce1d1c8bc(broadcastinstance, var_4ed40899ed266f0f, var_19266e4011b5f63d) {
  var_b082ea0e98192364 = function_f04267a7d3561996(var_4ed40899ed266f0f);
  var_839a3b46d36c45b7 = var_b082ea0e98192364[var_19266e4011b5f63d];

  if(isDefined(var_839a3b46d36c45b7)) {
    var_c113183796dfd41 = broadcastinstance function_8362248b8fb9637f();
    var_aa30a02555c77ef8 = function_4a145984b790852f(var_839a3b46d36c45b7);
    var_477873cc7f7f96ba = function_add6a5e1e7f656c7(var_839a3b46d36c45b7);
    var_1336db8efd12ba34 = var_c113183796dfd41 scripts\common\data_tracker::function_6a26856f16c6a207(var_aa30a02555c77ef8);
    var_944664ec659ee119 = default_to(var_839a3b46d36c45b7.variant_object.format, undefined);
    var_e89c655fba344976 = function_a2ddac402ee3ea8f(var_477873cc7f7f96ba, undefined, var_944664ec659ee119);

    if(var_1336db8efd12ba34) {
      var_e89c655fba344976.value = var_c113183796dfd41 scripts\common\data_tracker::function_e989e3f023f50368(var_aa30a02555c77ef8);
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
  var_cecb6f8a13d4084d = function_a558693f33df78c7(broadcastinstance function_cf54c2c8650d9688());

  if(isDefined(var_cecb6f8a13d4084d)) {
    return var_cecb6f8a13d4084d;
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
  broadcastinstance.var_82be66848b872db4 = function_a577c68231ddca0b(broadcastdefinition);
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
  var_c30742abf91f386e = "<dev string:x9e5>";

  if(!isDefined(var_8f2fc031475aef64.variant_object.uniquename) || var_8f2fc031475aef64.variant_object.uniquename == var_c30742abf91f386e) {
    assertmsg("<dev string:xa1c>");
  }

  return var_8f2fc031475aef64.variant_object.uniquename;
}

function private function_add6a5e1e7f656c7(var_cd1bcf4d1329635e) {
  return var_cd1bcf4d1329635e.variant_object.var_477873cc7f7f96ba;
}

function private function_ec28f992a3ffd931(var_cd1bcf4d1329635e) {
  var_477873cc7f7f96ba = function_add6a5e1e7f656c7(var_cd1bcf4d1329635e);
  defaultvalue = var_cd1bcf4d1329635e.variant_object.defaultvalue;

  if(var_477873cc7f7f96ba == "ProgressTracker") {
    return scripts\common\progress_tracker::function_b58813f6489727f2(defaultvalue.var_a6b66cc5de548567, defaultvalue.var_2d80b9b9b9b8a29f);
  }

  return defaultvalue;
}

function private function_6b83f7908da7ccb7(var_e690c121ea291e3e, var_d88a4b756f4d46c7) {
  foreach(broadcastdata in var_d88a4b756f4d46c7.variant_object.broadcastdata) {
    var_420b9a9f4293a416 = structcopy(var_d88a4b756f4d46c7, 1);
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
  var_a84449a9bd492279 = function_c24185c47d989c1a(broadcastdefinition);
  assertex(var_a84449a9bd492279 == "<dev string:x25a>", "<dev string:x26c>");
  broadcastdefinition.variant_object.var_a84449a9bd492279[0].variant_object.activationname = activationname;
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