/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_4e1f1a7ef824ddd5.gsc
*****************************************************/

#using script_569138730a0a130f;
#using script_73a03aaf11b641f5;
#using script_f01501ac138f999;
#using scripts\common\data_tracker;
#using scripts\common\player_broadcasting;
#using scripts\common\progress_tracker;
#namespace namespace_59b081b19a436abb;

function function_3b9f86835341433c(var_461c27928f0d83e2) {
  var_3b18ddaec245ad61 = var_461c27928f0d83e2.var_3b18ddaec245ad61;
  var_b7485e4088882b6b = spawnStruct();
  var_b7485e4088882b6b.var_cba657841af1a95a = [];

  foreach(broadcast in var_3b18ddaec245ad61.playerbroadcasts) {
    broadcasttype = function_6c3383780eb60d4e(broadcast);

    if(broadcasttype == "\x04\xb6\xc8\xcf\xce|H\b\x06[\xaa\x8b\x8c\xadA\xc9\r\rZ\xbc") {
      function_f152f241fa5161fa(var_b7485e4088882b6b, broadcast);
      continue;
    }

    var_b7485e4088882b6b.var_cba657841af1a95a[var_b7485e4088882b6b.var_cba657841af1a95a.size] = broadcast;
  }

  return var_b7485e4088882b6b.var_cba657841af1a95a;
}

function function_721deecee0910981(var_40df77b7bf9c2521, broadcastdefinitions) {
  if(!isarray(broadcastdefinitions) || broadcastdefinitions.size == 0) {
    return;
  }

  for(var_a7df5f8dd30a5c53 = 0; var_a7df5f8dd30a5c53 < broadcastdefinitions.size; var_a7df5f8dd30a5c53++) {
    broadcastdefinition = broadcastdefinitions[var_a7df5f8dd30a5c53];
    broadcastdefinition.id = var_40df77b7bf9c2521.var_ca1d04080a1066e3;
    var_40df77b7bf9c2521.var_ca1d04080a1066e3++;
    var_f9829369d3deb8b1 = function_add68d8a4439f59f(broadcastdefinition);

    if(var_f9829369d3deb8b1 == "\x97\xe7\xd3\v%\a\x9d*\xd7\x92\xdeY?\xdf") {
      broadcastactivationname = function_e136c91b1840ea40(broadcastdefinition);

      if(isDefined(broadcastactivationname)) {
        if(!isDefined(var_40df77b7bf9c2521.var_f2518140e481e225[broadcastactivationname])) {
          var_40df77b7bf9c2521.var_f2518140e481e225[broadcastactivationname] = [];
        }

        activationnamearraysize = var_40df77b7bf9c2521.var_f2518140e481e225[broadcastactivationname].size;
        var_40df77b7bf9c2521.var_f2518140e481e225[broadcastactivationname][activationnamearraysize] = broadcastdefinition;
        var_40df77b7bf9c2521.var_b1e9e5a2b5541a7e[var_40df77b7bf9c2521.var_b1e9e5a2b5541a7e.size] = broadcastdefinition;
      }

      continue;
    }

    if(!isDefined(var_40df77b7bf9c2521.var_b697c59ea7cd5e7a[var_f9829369d3deb8b1])) {
      var_40df77b7bf9c2521.var_b697c59ea7cd5e7a[var_f9829369d3deb8b1] = [];
    }

    var_a0ab7cbc3a536ed2 = var_40df77b7bf9c2521.var_b697c59ea7cd5e7a[var_f9829369d3deb8b1].size;
    var_40df77b7bf9c2521.var_b697c59ea7cd5e7a[var_f9829369d3deb8b1][var_a0ab7cbc3a536ed2] = broadcastdefinition;
    var_40df77b7bf9c2521.var_b1e9e5a2b5541a7e[var_40df77b7bf9c2521.var_b1e9e5a2b5541a7e.size] = broadcastdefinition;
  }
}

function function_b7a7d4f5a06e3e20() {
  var_40df77b7bf9c2521 = spawnStruct();
  var_40df77b7bf9c2521.var_b697c59ea7cd5e7a = [];
  var_40df77b7bf9c2521.var_f2518140e481e225 = [];
  var_40df77b7bf9c2521.var_b1e9e5a2b5541a7e = [];
  var_40df77b7bf9c2521.var_ca1d04080a1066e3 = 0;
  return var_40df77b7bf9c2521;
}

function function_176bc52cdecac6ef(broadcastdefinition) {
  return broadcastdefinition.id;
}

function function_c51149ed508940be() {
  return function_add68d8a4439f59f(self.broadcastdefinition);
}

function function_add68d8a4439f59f(broadcastdefinition) {
  if(isDefined(broadcastdefinition.variant_object.activationmoment) && broadcastdefinition.variant_object.activationmoment.size > 0) {
    return broadcastdefinition.variant_object.activationmoment[0].variant_object.activationmoment;
  }

  uniquename = function_99fa01f8d887919f(broadcastdefinition);
  broadcastuniquename = uniquename ?? "<dev string:x24>";
  assert(isDefined(uniquename), "<dev string:x2b>");

  return "\f+x5";
}

function function_17e937c71acd5689() {
  return function_df27e2c50112a660(self.broadcastdefinition);
}

function function_df27e2c50112a660(broadcastdefinition) {
  if(isDefined(broadcastdefinition.variant_object.deactivationmoment) && broadcastdefinition.variant_object.deactivationmoment.size > 0) {
    return broadcastdefinition.variant_object.deactivationmoment[0].variant_object.activationmoment;
  }

  return "\f+x5";
}

function function_6c3383780eb60d4e(broadcastdefinition) {
  assert(isDefined(broadcastdefinition.variant_object.broadcasttype), "<dev string:xab>");
  return broadcastdefinition.variant_object.broadcasttype;
}

function getbroadcastdestination() {
  return function_cfb99aaf548a14e6(self.broadcastdefinition);
}

function function_cfb99aaf548a14e6(broadcastdefinition) {
  if(isDefined(broadcastdefinition.variant_object.destination) && broadcastdefinition.variant_object.destination.size > 0) {
    return broadcastdefinition.variant_object.destination[0].variant_object.broadcastdestination;
  }

  broadcastuniquename = function_99fa01f8d887919f(broadcastdefinition) ?? "<dev string:x24>";

  return "\xde\xb1^\xd2\xeb\x13\xe7\x8a";
}

function function_8bee93cd57209ba3() {
  return function_c5bbef99ea2379e(self.broadcastdefinition);
}

function function_c5bbef99ea2379e(broadcastdefinition) {
  assert(isDefined(broadcastdefinition.variant_object.priority), "<dev string:xfc>");
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

function function_bc9177fff51648b6(broadcastdefinition) {
  return istrue(broadcastdefinition.variant_object.var_14eb9b7fe17b88a5);
}

function function_441aa54ce4d2c98e(broadcastdefinition) {
  if(isDefined(broadcastdefinition.variant_object.var_fa82ea9f48db64db) && broadcastdefinition.variant_object.var_fa82ea9f48db64db.size > 0) {
    return broadcastdefinition.variant_object.var_fa82ea9f48db64db[0].variant_object.var_faace539c8a3b054;
  }

  broadcasttype = function_6c3383780eb60d4e(broadcastdefinition);
  return namespace_606113cb7b23f701::function_9284aafeae1d887c(broadcasttype);
}

function function_c6d45f7a3c802e2d(broadcastdefinition) {
  var_faace539c8a3b054 = function_441aa54ce4d2c98e(broadcastdefinition);
  assert(var_faace539c8a3b054 == "<dev string:x15d>", "<dev string:x166>");

  if(isDefined(broadcastdefinition.variant_object.var_fa82ea9f48db64db) && broadcastdefinition.variant_object.var_fa82ea9f48db64db.size > 0) {
    var_cb48e3079f181a46 = broadcastdefinition.variant_object.var_fa82ea9f48db64db[0].variant_object.maximumdelaytime;

    if(isDefined(var_cb48e3079f181a46)) {
      return var_cb48e3079f181a46;
    }
  }

  return 10;
}

function function_7ad7d3e8f5155f0d(broadcastinstance = self) {
  assert(player_broadcasting::function_626c091782971df8(broadcastinstance), "<dev string:x1d4>");
  return istrue(broadcastinstance.broadcastdefinition.variant_object.var_8541a0f08bdff32d);
}

function function_64eaaafd454ed5c8(broadcastinstance = self) {
  assert(player_broadcasting::function_626c091782971df8(broadcastinstance), "<dev string:x1d4>");
  var_6481c0925d22d693 = function_9c2ff2e93fc54c93(broadcastinstance);

  if(function_7ad7d3e8f5155f0d(broadcastinstance) || var_6481c0925d22d693) {
    return true;
  }

  return false;
}

function function_9c2ff2e93fc54c93(broadcastinstance = self, uniquename) {
  assert(player_broadcasting::function_626c091782971df8(broadcastinstance), "<dev string:x1d4>");
  dataobjects = broadcastinstance player_broadcasting::function_242ee4b760cb7bf();

  foreach(dataobject in dataobjects) {
    dynamicdatastructs = function_590fadcee423aa2f(dataobject);

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
  return function_99fa01f8d887919f(self.broadcastdefinition);
}

function function_99fa01f8d887919f(broadcastdefinition) {
  if(isDefined(broadcastdefinition.variant_object.uniquename)) {
    return broadcastdefinition.variant_object.uniquename;
  }

  return undefined;
}

function getactivationname() {
  return function_e136c91b1840ea40(self.broadcastdefinition);
}

function function_e136c91b1840ea40(broadcastdefinition) {
  activationmoment = function_add68d8a4439f59f(broadcastdefinition);
  assert(activationmoment == "<dev string:x262>", "<dev string:x274>");
  assert(isDefined(broadcastdefinition.variant_object.activationmoment[0].variant_object.activationname), "<dev string:x2e1>");
  return broadcastdefinition.variant_object.activationmoment[0].variant_object.activationname;
}

function getdeactivationname() {
  return function_2564ccb61a24e9fb(self.broadcastdefinition);
}

function function_2564ccb61a24e9fb(broadcastdefinition) {
  var_90c89875b6549fc1 = function_df27e2c50112a660(broadcastdefinition);

  if(isDefined(var_90c89875b6549fc1) && var_90c89875b6549fc1 == "\x97\xe7\xd3\v%\a\x9d*\xd7\x92\xdeY?\xdf") {
    return broadcastdefinition.variant_object.deactivationmoment[0].variant_object.deactivationname;
  } else {
    var_b0dcb2eda07221a1 = istrue(isDefined(var_90c89875b6549fc1) && var_90c89875b6549fc1 != "<dev string:x262>");
    assert(var_b0dcb2eda07221a1, "<dev string:x33d>");
  }

  return undefined;
}

function function_7227738ad0add070(broadcastinstance) {
  broadcastdestination = broadcastinstance getbroadcastdestination();

  if("<dev string:x3c6>" != broadcastdestination) {
    assertmsg("<dev string:x3d2>" + broadcastinstance player_broadcasting::getbroadcastuniqueid() + "<dev string:x3e6>");
    return;
  }

  broadcastinstancespatialzonename = "b2ni\xe7seuv\\c\xf0Yw\xaa\x01\x8c\xe0Ew\xee\x956\"" + broadcastinstance player_broadcasting::getbroadcastuniqueid();

  if(!namespace_9342d78fcaacff0b::function_a2f5a6979eb10328(self, broadcastinstancespatialzonename)) {
    zoneinfostruct = broadcastinstance.broadcastdefinition.variant_object.destination[0].variant_object.broadcastdistance[0].variant_object;
    namespace_7b5dc905a7ea3e0f::function_443bf722a7d22510(self, broadcastinstancespatialzonename, zoneinfostruct);
  }

  return namespace_9342d78fcaacff0b::function_501d514afe3347(self, broadcastinstancespatialzonename);
}

function function_7c97484464e11e5f(activationmoment) {
  var_8154ca4f4c3a02d1 = [];
  var_c14923a7631666b3 = namespace_606113cb7b23f701::function_591fcf2786538e49(self, activationmoment);

  if(!isDefined(var_c14923a7631666b3) || istrue(var_c14923a7631666b3)) {
    var_40df77b7bf9c2521 = namespace_7b5dc905a7ea3e0f::function_e516262c61529d3b(self);
    var_de1268f9a1cbdc05 = var_40df77b7bf9c2521.var_b697c59ea7cd5e7a[activationmoment];

    if(isDefined(var_de1268f9a1cbdc05)) {
      for(broadcastarrayindex = 0; broadcastarrayindex < var_de1268f9a1cbdc05.size; broadcastarrayindex++) {
        broadcastdefinition = var_de1268f9a1cbdc05[broadcastarrayindex];
        broadcastdefinitionid = function_176bc52cdecac6ef(broadcastdefinition);
        var_8154ca4f4c3a02d1[var_8154ca4f4c3a02d1.size] = function_2ecc789d7e6824bd(broadcastdefinition, broadcastdefinitionid);
      }
    }
  }

  return var_8154ca4f4c3a02d1;
}

function function_cf7e2214a4e953a7(activityinstance, uniquename) {
  var_96adce65e4026815 = undefined;
  var_40df77b7bf9c2521 = namespace_7b5dc905a7ea3e0f::function_e516262c61529d3b(activityinstance);

  var_5abb8baff9f8fa4a = 0;

  for(broadcastarrayindex = 0; broadcastarrayindex < var_40df77b7bf9c2521.var_b1e9e5a2b5541a7e.size; broadcastarrayindex++) {
    broadcastdefinition = var_40df77b7bf9c2521.var_b1e9e5a2b5541a7e[broadcastarrayindex];
    broadcastuniquename = function_99fa01f8d887919f(broadcastdefinition);

    if(isDefined(broadcastuniquename) && broadcastuniquename == uniquename) {
      broadcastdefinitionid = function_176bc52cdecac6ef(broadcastdefinition);
      var_96adce65e4026815 = function_2ecc789d7e6824bd(broadcastdefinition, broadcastdefinitionid);

      var_5abb8baff9f8fa4a++;
    }
  }

  if(var_5abb8baff9f8fa4a == 0) {
    assertmsg("<dev string:x447>");
  } else if(var_5abb8baff9f8fa4a > 1) {
    assertmsg("<dev string:x4d1>");
  }

  return var_96adce65e4026815;
}

function function_745842809500734(activationname, specificbroadcasttype) {
  var_b0974b41cbb42104 = [];
  var_40df77b7bf9c2521 = namespace_7b5dc905a7ea3e0f::function_e516262c61529d3b(self);
  var_ffdf883ea0c482a3 = var_40df77b7bf9c2521.var_f2518140e481e225[activationname];

  if(isDefined(var_ffdf883ea0c482a3)) {
    for(broadcastarrayindex = 0; broadcastarrayindex < var_ffdf883ea0c482a3.size; broadcastarrayindex++) {
      broadcastdefinition = var_ffdf883ea0c482a3[broadcastarrayindex];
      broadcasttypeisallowed = !isDefined(specificbroadcasttype) || specificbroadcasttype == function_6c3383780eb60d4e(broadcastdefinition);

      if(broadcasttypeisallowed) {
        broadcastdefinitionid = function_176bc52cdecac6ef(broadcastdefinition);
        var_b0974b41cbb42104[var_b0974b41cbb42104.size] = function_2ecc789d7e6824bd(broadcastdefinition, broadcastdefinitionid);
      }
    }
  }

  return var_b0974b41cbb42104;
}

function function_fddbebaf9ee908ca(broadcastdefinition) {
  assert(isDefined(broadcastdefinition.variant_object.broadcastdata) && isDefined(broadcastdefinition.variant_object.broadcastdata.size > 0), "<dev string:x576>");
  return broadcastdefinition.variant_object.broadcastdata;
}

function function_3254bb5e08e154e0(broadcastdataobject) {
  return broadcastdataobject.variant_type;
}

function function_763987466ce76d78(broadcastdataobject) {
  assert(isDefined(broadcastdataobject.variant_object.stringreference), "<dev string:x5c1>");
  return broadcastdataobject.variant_object.stringreference;
}

function function_e2826b54d7477a1a(broadcastdataobject) {
  assert(isDefined(broadcastdataobject.variant_object.splashreference), "<dev string:x62a>");
  return broadcastdataobject.variant_object.splashreference;
}

function function_c42a078a6e0117ab(broadcastdataobject) {
  return broadcastdataobject.variant_object.splashlistoverride;
}

function function_88e2386c029e8410(broadcastdataobject) {
  return broadcastdataobject.variant_object.musicreference;
}

function function_ac41b20c2297c3aa(broadcastdataobject) {
  return broadcastdataobject.variant_object.musicdelay;
}

function function_ef5ebc9d08d49a4c(broadcastdataobject) {
  assert(isDefined(broadcastdataobject.variant_object.var_d64376ebc0637e14), "<dev string:x693>");
  return broadcastdataobject.variant_object.var_d64376ebc0637e14;
}

function function_a98575a439cb8a6e(broadcastdataobject) {
  return istrue(broadcastdataobject.variant_object.var_57652f70a8e03b2);
}

function function_4b4fbe1cd3cf75e6(broadcastdataobject) {
  return istrue(broadcastdataobject.variant_object.shouldinterruptcurrent);
}

function function_19046d2d4163a3ce(broadcastdataobject) {
  return broadcastdataobject.variant_object.var_5b8ad01a7e69d346;
}

function function_2124359cf367f46c(broadcastdataobject) {
  assert(isDefined(broadcastdataobject.variant_object.omnvarname), "<dev string:x704>");
  return broadcastdataobject.variant_object.omnvarname;
}

function function_f3513d05156ba5b3(broadcastdataobject) {
  assert(isDefined(broadcastdataobject.variant_object.omnvartype), "<dev string:x768>");
  return broadcastdataobject.variant_object.omnvartype;
}

function function_97089bccb5200ae6(broadcastdataobject) {
  if(!isDefined(broadcastdataobject.variant_object.omnvarvalue)) {
    omnvartype = function_f3513d05156ba5b3(broadcastdataobject);

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
        assertmsg("<dev string:x7cc>" + (omnvartype ?? "<dev string:x815>") + "<dev string:x822>");
        break;
    }
  }

  return broadcastdataobject.variant_object.omnvarvalue;
}

function function_425b532a28ba8c53(broadcastdataobject) {
  return broadcastdataobject.variant_object.var_e29c4599a15f89db;
}

function function_263bfc890cd94533(broadcastdataobject) {
  if(isDefined(broadcastdataobject.variant_object.stylesettings) && broadcastdataobject.variant_object.stylesettings.size > 0) {
    return broadcastdataobject.variant_object.stylesettings[0].variant_object.broadcaststyle;
  }

  return "\f+x5";
}

function function_637235bbeb1edd3(broadcastdataobject) {
  if(isDefined(broadcastdataobject.variant_object.stylesettings) && broadcastdataobject.variant_object.stylesettings.size > 0) {
    return broadcastdataobject.variant_object.stylesettings[0].variant_object;
  }

  assertmsg("<dev string:x865>");
  return undefined;
}

function function_590fadcee423aa2f(broadcastdataobject) {
  if(isDefined(broadcastdataobject.variant_object.dynamicdata)) {
    return broadcastdataobject.variant_object.dynamicdata;
  }

  return [];
}

function function_9dcfbc1e2bb032c5(broadcastinstance, broadcastdataobject, var_e4da34527d9363d8) {
  dynamicdatastructs = function_590fadcee423aa2f(broadcastdataobject);
  var_c3890e6541a1cdbe = dynamicdatastructs[var_e4da34527d9363d8];

  if(isDefined(var_c3890e6541a1cdbe)) {
    associateddatatracker = broadcastinstance player_broadcasting::function_21198624b23fa66();
    var_43a151bd99d6a971 = function_4d4afed9ac4f2402(var_c3890e6541a1cdbe);
    dynamicdatatype = function_1c96ce6505d3da3a(var_c3890e6541a1cdbe);
    var_a7a1a022f9a0629d = associateddatatracker data_tracker::function_fb39513920c37852(var_43a151bd99d6a971);
    dynamicdataformat = var_c3890e6541a1cdbe.variant_object.format ?? undefined;
    var_9e24eca9ff54d953 = function_b348b5c97ab3c4fa(dynamicdatatype, undefined, dynamicdataformat);

    if(var_a7a1a022f9a0629d) {
      var_9e24eca9ff54d953.value = associateddatatracker data_tracker::getdatavalue(var_43a151bd99d6a971);
    } else {
      var_9e24eca9ff54d953.value = function_d4f2298a7c260240(var_c3890e6541a1cdbe);
    }

    return var_9e24eca9ff54d953;
  }

  return undefined;
}

function function_a7a2f1c10488d00e(broadcastformat, startingvalue, currentvalue, endvalue) {
  if(broadcastformat == "\xceb\xd6\x0f=W\xd2\x80\f^") {
    return [currentvalue];
  } else if(broadcastformat == "\xb0\xbeI+\xda\xc2i\xe6-n\xec") {
    assert(isDefined(endvalue), "<dev string:x8d6>");
    remainingvalue = abs(endvalue - currentvalue);
    return [remainingvalue];
  } else if(broadcastformat == "\xb5!/\x930\xd7\x92\\\xd6D") {
    assert(isDefined(endvalue), "<dev string:x8d6>");
    return [currentvalue, endvalue];
  } else if(broadcastformat == "B\xb4\xab\xdf_\xbe+\x14\b9\x99\xe9\xff\xfc\r\x19\xcd\xd2J\xeb\xe3") {
    assert(isDefined(endvalue), "<dev string:x8d6>");
    totalvalue = abs(endvalue - startingvalue);
    percentagecomplete = currentvalue / totalvalue * 100;

    if(endvalue < startingvalue) {
      numerator = totalvalue - currentvalue;
      percentagecomplete = numerator / totalvalue * 100;
    }

    return [percentagecomplete];
  } else if(broadcastformat == "_\xcb\x95g8(\xf4\x1f\xa7\xf9\xa8?\x7f\"`Zj.\xa4q\xd0z") {
    assert(isDefined(endvalue), "<dev string:x8d6>");
    totalvalue = abs(endvalue - startingvalue);
    percentageremaining = currentvalue / totalvalue * 100;

    if(endvalue > startingvalue) {
      numerator = totalvalue - currentvalue;
      percentageremaining = numerator / totalvalue * 100;
    }

    return [percentageremaining];
  } else if(broadcastformat == "D\x15\x80\xda\xed~\xea\xd9@cz") {
    minutes = currentvalue / 60;
    leftnumber = floor(minutes);
    rightnumber = floor((minutes - leftnumber) * 60);
    return [leftnumber, rightnumber];
  } else {
    assertmsg("<dev string:x93d>");
  }

  return [currentvalue];
}

function private function_2ecc789d7e6824bd(broadcastdefinition, broadcastid) {
  broadcastinstance = function_21c066173e89ac12(broadcastdefinition, broadcastid);
  assert(isDefined(broadcastinstance), "<dev string:x9a7>");
  activebroadcastinstance = namespace_606113cb7b23f701::getactivebroadcastinstance(broadcastinstance player_broadcasting::getbroadcastuniqueid());

  if(isDefined(activebroadcastinstance)) {
    return activebroadcastinstance;
  }

  return broadcastinstance;
}

function private function_21c066173e89ac12(broadcastdefinition, broadcastid) {
  activityinstance = self;
  broadcasttype = function_6c3383780eb60d4e(broadcastdefinition);
  broadcastinstance = player_broadcasting::function_552fcfff4afff671(broadcasttype);
  broadcastinstance.groupid = activityinstance.id;
  broadcastinstance.uniqueid = activityinstance.id + "O\xcetGW\xd5\xc3\x03R\x93\xee \x04\xd2\xeb" + broadcastid;
  broadcastinstance.broadcastdefinition = broadcastdefinition;
  broadcastinstance player_broadcasting::function_f8ecc98eac1d300a(activityinstance);
  broadcastinstance.var_ea770d85bcef8cd7 = function_51e512329f06ecb(broadcastdefinition);
  broadcastinstance.broadcastdataobjects = function_fddbebaf9ee908ca(broadcastdefinition);
  activityinstance function_32301c817948eea4(broadcastinstance, broadcastdefinition);
  return broadcastinstance;
}

function private function_32301c817948eea4(broadcastinstance, broadcastdefinition) {
  activityinstance = self;
  var_35e7a5f8ba3f10c4 = broadcastinstance function_37902cd35fadf910(broadcastdefinition);
  var_8d4f90cc962a4c9a = !function_bc9177fff51648b6(broadcastdefinition);
  var_faace539c8a3b054 = function_441aa54ce4d2c98e(broadcastdefinition);
  var_7e96114525ef6e98 = var_faace539c8a3b054 != "\f+x5";
  namespace_606113cb7b23f701::function_54796bc78139c23c(broadcastinstance, activityinstance, var_8d4f90cc962a4c9a, var_35e7a5f8ba3f10c4, var_7e96114525ef6e98);

  if(var_faace539c8a3b054 != "\f+x5") {
    if(var_faace539c8a3b054 == "K\xd3\x9by\xa3") {
      var_cb48e3079f181a46 = function_c6d45f7a3c802e2d(broadcastdefinition);
      broadcastinstance player_broadcasting::function_961e9fbe7aa8742(var_cb48e3079f181a46);
    }
  }
}

function private function_b348b5c97ab3c4fa(datatype, value, format) {
  var_9e24eca9ff54d953 = spawnStruct();
  var_9e24eca9ff54d953.type = datatype;
  var_9e24eca9ff54d953.value = value;
  var_9e24eca9ff54d953.format = format;
  return var_9e24eca9ff54d953;
}

function private function_4d4afed9ac4f2402(var_6bc8756ae0c73371) {
  defaultuniquename = "<dev string:x9ed>";

  if(!isDefined(var_6bc8756ae0c73371.variant_object.uniquename) || var_6bc8756ae0c73371.variant_object.uniquename == defaultuniquename) {
    assertmsg("<dev string:xa24>");
  }

  return var_6bc8756ae0c73371.variant_object.uniquename;
}

function private function_1c96ce6505d3da3a(var_dff07e14d6be504b) {
  return var_dff07e14d6be504b.variant_object.dynamicdatatype;
}

function private function_d4f2298a7c260240(var_dff07e14d6be504b) {
  dynamicdatatype = function_1c96ce6505d3da3a(var_dff07e14d6be504b);
  defaultvalue = var_dff07e14d6be504b.variant_object.defaultvalue;

  if(dynamicdatatype == "gvA@\xe7\xf3\tO\x9e\x82\x94gjD3") {
    return progress_tracker::createprogresstracker(defaultvalue.defaultstartingvalue, defaultvalue.defaultfinalvalue);
  }

  return defaultvalue;
}

function private function_f152f241fa5161fa(var_b7485e4088882b6b, dialogbucket) {
  foreach(broadcastdata in dialogbucket.variant_object.broadcastdata) {
    var_ce4ba38b0430220f = structcopy(dialogbucket, 1);
    function_b0df33d0c1b0070a(var_ce4ba38b0430220f, broadcastdata.variant_object.activationname);

    if(broadcastdata.variant_type == "\xa2\xbc\xe0+7\xfa(\xc6\xe8Kgi\xa3\xf2$\xc9{\vF\xc6,\x9b\x1dD\xb0t\xb0_\x14\xb1GKv\x16:ion\x9c\x85[+\xd7\xd4\xa3\xc9is\xb3\x94+\x99e'\x95\xe6lV") {
      function_4d54f8474c565fae(var_ce4ba38b0430220f, "\x9a\xd1\x93\xb4\x9bv\x92+3\xb2\xe4e\xdccV");
    } else if(broadcastdata.variant_type == "\x1b\xc3\x04\xfa\x90\xa3\f)\xc4\x7f\x1dG\xb1h\\&=\xc2\x96D\x19O\xa2I\x86\x13\xbf\xff\xeb~v\x1f\xa0\xc5\x17B\nAK\xd0\xb0zW\xefC\xb2\x03\xd6\xe0\xc0\xf7%^\xec\xc7\xaf\xecr") {
      function_4d54f8474c565fae(var_ce4ba38b0430220f, "\xe9\xa4#\xa3\x01\x8a\x88X\x03$r");
    } else if(broadcastdata.variant_type == "Y8~GQ\x843\xad\x15r\x8d\xf1O&\x81\x88`\xb8\xc6\xf0\xc1\xa5\x9c\x90\xb9\x94\xf5\xa0f\xfe0p\x88\x98F'\xa1\x8eI\xb9\xd9\x10\xc4\xa0F~8^\x89\xb8\xce\xc7I\x15J\xa5\x85") {
      function_4d54f8474c565fae(var_ce4ba38b0430220f, "\x17`\xc7\xf0\xdf");
    } else if(broadcastdata.variant_type == "\x0f}\x96\xbf\x91\x0ep!\xf8\xc2\xf6\x81\xd6f\xddR<\xd9+m\x10C\xb6\xd5\x95\x93\xe49\xfeVy}\xb6\xff\xbdX\x893{\xbc\xd0\xff\xc7\xc0\x1c@Zi?\xed@\xcb\b\xa1O\x18\x92%n\xc0" || broadcastdata.variant_type == "\xd4H\xe8\x91D~\xb8\x98G~q\x06\xfdK<r\xec\xba=\xdc/B\r\x85\x01\xd8\xe0\x05\xb3YZ\x92mB\xc8\n\at\xccY\xd7\xde\xac\xb4\x1b\b\xcdZ6\xc2|\xbe\x8dX\xb9\x97>a\xdaV\x8c\x94\xc4") {
      function_4d54f8474c565fae(var_ce4ba38b0430220f, "\xd0\x19\n\x83\xcd{9F");
    } else if(broadcastdata.variant_type == "\xe3\x98T8wT\xcf\xaa\xf6o\xf0_dr\xd4\x1b\x0fY\x03 \xfe\xb4\a4\xa0\a\xfc\xc7\x90\x1flw\x8b9G\x10\x04\xe0\xe7\xa0\x90K$D\b+\x84w\x9b") {
      function_4d54f8474c565fae(var_ce4ba38b0430220f, "\xce'\x18{\xf6\x9d");
    }

    var_ce4ba38b0430220f.variant_object.broadcastdata = [broadcastdata];
    var_b7485e4088882b6b.var_cba657841af1a95a[var_b7485e4088882b6b.var_cba657841af1a95a.size] = var_ce4ba38b0430220f;
  }
}

function private function_b0df33d0c1b0070a(broadcastdefinition, activationname) {
  activationmoment = function_add68d8a4439f59f(broadcastdefinition);
  assert(activationmoment == "<dev string:x262>", "<dev string:x274>");
  broadcastdefinition.variant_object.activationmoment[0].variant_object.activationname = activationname;
}

function private function_4d54f8474c565fae(broadcastdefinition, broadcasttype) {
  broadcastdefinition.variant_object.broadcasttype = broadcasttype;
}

function private function_37902cd35fadf910(broadcastdefinition) {
  return istrue(broadcastdefinition.variant_object.var_4c28a97585468299);
}

function private function_51e512329f06ecb(broadcastdefinition) {
  return istrue(broadcastdefinition.variant_object.var_ea770d85bcef8cd7);
}