/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_f01501ac138f999.gsc
****************************************************/

#using script_157e7fec25404847;
#using script_1aae2eb1ef28b239;
#using script_4e1f1a7ef824ddd5;
#using script_570f992e202c79b4;
#using script_73a03aaf11b641f5;
#using script_77873e194e406c6d;
#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace namespace_7b5dc905a7ea3e0f;

function function_946dc3008e92ada() {
  function_2c4c1f4c43b34fe5();
  function_53508910e37b2afa();
}

function function_df771d052ab39d5e(associatedscriptbundlename, activityvariant) {
  var_9cce53f296541d7 = utility::string_split(associatedscriptbundlename, "\xb0");

  if(var_9cce53f296541d7.size == 1) {
    associatedscriptbundlename = "`*t\xc1\x88H\x1eW\x80\x7f\xe6C\xdb\xb4x\xc2\xf4\x83\xb5" + associatedscriptbundlename;
  }

  activityvariantdefinition = {
    #associatedscriptbundlename: associatedscriptbundlename, #isactivitydefinition: 1
  };
  activitydefinitionscriptbundle = function_206bb162bd7af568(associatedscriptbundlename, activityvariantdefinition);
  activitycategory = function_3269948ea31c7332(activitydefinitionscriptbundle);
  activitytype = function_779dce70feffeacf(activitydefinitionscriptbundle);

  if(!activity_common::isactivityenabled(activitycategory, activitytype, activityvariant)) {
    namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x24>" + activitytype + "<dev string:x32>" + activityvariant + "<dev string:x39>", @ "hash_72a413c7683cfc8d");

    return undefined;
  }

  if(!isDefined(level.activities.definitions[activityvariant])) {
    if(!isDefined(level.activities.var_ca45771bdb7140b2[associatedscriptbundlename])) {
      level.activities.var_ca45771bdb7140b2[associatedscriptbundlename] = activitydefinitionscriptbundle.customproperties;
    }

    level.activities.definitions[activityvariant] = activityvariantdefinition;

    namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x98>" + activityvariant + "<dev string:xae>", @ "hash_72a413c7683cfc8d");

    if(isDefined(level.activities.var_87296b46f3a87209)) {
      [[level.activities.var_87296b46f3a87209]](activityvariant, activitydefinitionscriptbundle);
    }
  }

  return level.activities.definitions[activityvariant];
}

function function_2c4c1f4c43b34fe5(var_9987c04da42c06bc = 1, var_65e2c5e7ecb2534f = undefined) {
  foreach(var_afcbd2f25ff4f5c in level.activities.var_a0bd3e0a4a59438b) {
    function_4c0b74c8bd8b55de(var_afcbd2f25ff4f5c.var_aa12a35f3dd537d9, var_9987c04da42c06bc, var_65e2c5e7ecb2534f);
  }

  activity_common::function_a322f61b8485707f();
}

function function_4c0b74c8bd8b55de(var_2931abe86458b32a, var_9987c04da42c06bc = 1, var_65e2c5e7ecb2534f = undefined) {
  assert(isfunction(var_2931abe86458b32a), "<dev string:xec>");
  var_17d7395d0f0a46fb = [[var_2931abe86458b32a]]();
  assert(isfunction(var_17d7395d0f0a46fb.metadatafunction), "<dev string:x145>");
  var_cd7aa333cbb47ab2 = [[var_17d7395d0f0a46fb.metadatafunction]]();

  if(!isDefined(var_65e2c5e7ecb2534f)) {
    var_65e2c5e7ecb2534f = [];
  }

  if(istrue(var_9987c04da42c06bc) && isfunction(var_17d7395d0f0a46fb.mainfunction)) {
    [[var_17d7395d0f0a46fb.mainfunction]]();
  }

  activitynexussettings = level.activities.activitynexussettings;

  foreach(activityvariantname, variantmetadata in var_cd7aa333cbb47ab2) {
    var_5d9b8d2a91cf01e6 = utility::array_find(var_65e2c5e7ecb2534f, activityvariantname);
    var_4603f64a8ba9d11e = !isDefined(var_5d9b8d2a91cf01e6);

    if(var_4603f64a8ba9d11e) {
      function_e50b747c6e194a4b(activityvariantname, var_cd7aa333cbb47ab2, var_17d7395d0f0a46fb);

      if(!istrue(activitynexussettings.var_25738be6071c5d35)) {
        struct = spawnStruct();
        [[var_17d7395d0f0a46fb.var_51a3cca8aceb3131]](activityvariantname, struct, activityvariantname);
      }

      continue;
    }

    namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x24>" + activityvariantname + "<dev string:x1a1>", @ "hash_72a413c7683cfc8d");
  }
}

function function_e50b747c6e194a4b(activityvariantname, var_cd7aa333cbb47ab2, var_17d7395d0f0a46fb) {
  scriptbundlename = function_cbbb5ec8d68d73d8(activityvariantname, var_cd7aa333cbb47ab2, var_17d7395d0f0a46fb);
  variantscriptstructinfo = activity_common::function_d4c38791b19a0631(activityvariantname);

  if(isDefined(scriptbundlename) && variantscriptstructinfo.variantstruct.var_6e3343a8befc8c46 != "\x87") {
    activitydefinition = function_df771d052ab39d5e(scriptbundlename, activityvariantname);

    if(isDefined(activitydefinition)) {
      activitydefinition.var_ec8683e4f9e8ae3a = 1;
      activitydefinition.var_373357e98a75852d = var_17d7395d0f0a46fb.var_51a3cca8aceb3131;
      activitydefinition.var_2d8a6120cb208bd6 = var_17d7395d0f0a46fb.metadatafunction;
    }
  }
}

function function_cbbb5ec8d68d73d8(activityvariantname, var_cd7aa333cbb47ab2, var_17d7395d0f0a46fb) {
  activitydefinitionbundlename = undefined;
  var_dd6c7b716a72cc19 = var_cd7aa333cbb47ab2[activityvariantname];

  if(!isDefined(var_dd6c7b716a72cc19)) {
    return function_cbcb2c30f2bc7bd6(activityvariantname);
  }

  if(isDefined(var_dd6c7b716a72cc19.scriptbundle) && var_dd6c7b716a72cc19.scriptbundle != "") {
    activitydefinitionbundlename = var_dd6c7b716a72cc19.scriptbundle;
  } else if(isDefined(var_dd6c7b716a72cc19.parentvariant)) {
    return function_cbbb5ec8d68d73d8(var_dd6c7b716a72cc19.parentvariant, var_cd7aa333cbb47ab2, var_17d7395d0f0a46fb);
  }

  if(!isDefined(activitydefinitionbundlename) && isDefined(var_17d7395d0f0a46fb.scriptbundle) && var_17d7395d0f0a46fb.scriptbundle != "") {
    activitydefinitionbundlename = var_17d7395d0f0a46fb.scriptbundle;
  }

  var_9cce53f296541d7 = utility::string_split(activitydefinitionbundlename, "\xb0");

  if(var_9cce53f296541d7.size == 1) {
    activitydefinitionbundlename = "`*t\xc1\x88H\x1eW\x80\x7f\xe6C\xdb\xb4x\xc2\xf4\x83\xb5" + activitydefinitionbundlename;
  }

  return activitydefinitionbundlename;
}

function function_2e6ca705d9ae7f12(var_7d86b3a2a6006f34) {
  activityvariantstructs = level.activities.var_135a3840c5a5907c;

  foreach(activityvariantstruct in activityvariantstructs) {
    if(isDefined(activityvariantstruct.variantstruct.activity_bundle) && activityvariantstruct.variantstruct.activity_bundle != "") {
      activityvariantname = activityvariantstruct.variantstruct.name;
      var_4603f64a8ba9d11e = isDefined(utility::array_find(var_7d86b3a2a6006f34, activityvariantname));

      if(var_4603f64a8ba9d11e) {
        function_38522dcf793ec2e3(activityvariantstruct);
      }
    }
  }
}

function function_53508910e37b2afa(var_91ed0fa7b6818662) {
  activity_common::function_a322f61b8485707f();

  if(!isDefined(var_91ed0fa7b6818662)) {
    var_91ed0fa7b6818662 = [];
  }

  activityvariantstructs = level.activities.var_135a3840c5a5907c;

  foreach(activityvariantstruct in activityvariantstructs) {
    if(isDefined(activityvariantstruct.variantstruct.activity_bundle) && activityvariantstruct.variantstruct.activity_bundle != "") {
      activityvariantname = activityvariantstruct.variantstruct.name;
      var_5a758375c977e158 = isDefined(utility::array_find(var_91ed0fa7b6818662, activityvariantname));

      if(!var_5a758375c977e158) {
        function_38522dcf793ec2e3(activityvariantstruct);
      }
    }
  }
}

function function_a4e7db016016846b(activityinstance) {
  activitydefinition = function_e2fc5d3b23f01ac5(activityinstance);

  if(isDefined(activitydefinition.var_2d8a6120cb208bd6)) {
    function_fbd3218df26cefc(activityinstance, activitydefinition.var_2d8a6120cb208bd6);
  }

  function_b0d948f86d8df7db(activityinstance);
  activityvariantname = activityinstance.varianttag;
  function_2ae9247044bf03cd(activityvariantname, activityinstance);
}

function function_2ae9247044bf03cd(activityvariantname, spatialzonecontainer, specificzonename) {
  for(variantscriptstructinfo = activity_common::function_d4c38791b19a0631(activityvariantname); isDefined(variantscriptstructinfo); variantscriptstructinfo = undefined) {
    variantstruct = variantscriptstructinfo.variantstruct;

    if(isDefined(variantstruct.origin) && namespace_9342d78fcaacff0b::function_a2f5a6979eb10328(spatialzonecontainer, "\x8b\xef\xf6\x04Pn\xf7\xde\x89\xaft\xda\x0f\x19\xe0\xdc\x1b\xeeO") == 0) {
      namespace_9342d78fcaacff0b::function_d98dd1246d42a25e(spatialzonecontainer, "\x8b\xef\xf6\x04Pn\xf7\xde\x89\xaft\xda\x0f\x19\xe0\xdc\x1b\xeeO", variantstruct.origin);
    }

    linkedstructs = variantscriptstructinfo.linkedstructs;

    foreach(linkedstruct in linkedstructs) {
      var_4c91c86dc6fa0996 = linkedstruct.targetname === "[\xa3\x1bje\xa0op\xc0=\xb1\xcb)u'\x17p\xd0\x14\x8bH\xea\xcb\xe7c\xbfS" && isstring(linkedstruct.script_noteworthy) && linkedstruct.script_noteworthy != "";

      if(var_4c91c86dc6fa0996) {
        if(isDefined(specificzonename) && linkedstruct.script_noteworthy != specificzonename) {
          continue;
        }

        zoneinfostruct = function_7cc26a86c2a80e65(spatialzonecontainer, linkedstruct.script_noteworthy);
        ignoreheight = zoneinfostruct.ignoreheightvalue == 1;
        namespace_9342d78fcaacff0b::function_d98dd1246d42a25e(spatialzonecontainer, linkedstruct.script_noteworthy, linkedstruct.origin, linkedstruct.radius, ignoreheight);

        if(namespace_59dbf6a1bb28a43f::isactivityinstance(spatialzonecontainer) && zoneinfostruct.var_150502cbcbf04619 == 1) {
          namespace_9342d78fcaacff0b::function_7ade4e318cc0a207(spatialzonecontainer, linkedstruct.script_noteworthy, &namespace_59dbf6a1bb28a43f::function_c1c44508d7539941, [spatialzonecontainer]);
        }
      }
    }

    parentactivityvariantname = variantstruct.parent;

    if(isstring(parentactivityvariantname)) {
      variantscriptstructinfo = activity_common::function_d4c38791b19a0631(parentactivityvariantname);
      continue;
    }
  }
}

function getactivitydefinition(varianttag) {
  activitydef = level.activities.definitions[varianttag];
  assert(isDefined(activitydef), "<dev string:x23f>" + varianttag);
  return activitydef;
}

function function_8cc79ac6faec26fb(activitytype) {
  activitydefinitionlist = [];
  assert(function_8546b133b55379f6(activitytype), "<dev string:x28e>");

  foreach(activitydefinition in level.activities.definitions) {
    if(function_779dce70feffeacf(activitydefinition) == activitytype) {
      activitydefinitionlist[activityvariantname] = activitydefinition;
    }
  }

  return activitydefinitionlist;
}

function function_e2fc5d3b23f01ac5(activityinstance = self) {
  assert(namespace_59dbf6a1bb28a43f::isactivityinstance(activityinstance), "<dev string:x2bc>");
  return getactivitydefinition(activityinstance.varianttag);
}

function private function_779dce70feffeacf(var_1f9fe9da7d30659a) {
  customproperties = function_fd62fda7d944b7b1(var_1f9fe9da7d30659a);
  return customproperties.activitytype;
}

function function_3269948ea31c7332(var_1f9fe9da7d30659a) {
  activitycustomproperties = function_5f18e8aad46e3f21(var_1f9fe9da7d30659a);

  if(isDefined(activitycustomproperties.activitytypegroup[0].variant_object.activitycategory)) {
    return activitycustomproperties.activitytypegroup[0].variant_object.activitycategory;
  }

  return "\f+x5";
}

function function_cdcd003e29297cbd(var_1f9fe9da7d30659a, abandontriggertype) {
  var_ab450e320225526a = function_e7d6e4c875d16d11(var_1f9fe9da7d30659a, abandontriggertype);

  if(isDefined(var_ab450e320225526a) && var_ab450e320225526a.size == 1) {
    return istrue(var_ab450e320225526a[0].variant_object.var_ad7532ebd0a9d9ee);
  }

  return false;
}

function function_7df855ef2ada1d3c(var_1f9fe9da7d30659a, abandontriggertype) {
  var_ab450e320225526a = function_e7d6e4c875d16d11(var_1f9fe9da7d30659a, abandontriggertype);

  if(isDefined(var_ab450e320225526a) && var_ab450e320225526a.size == 1) {
    return istrue(var_ab450e320225526a[0].variant_object.var_d507f95a8be65654);
  }

  return false;
}

function function_644fd4af8d9cc127(var_1f9fe9da7d30659a, abandontriggertype) {
  var_ab450e320225526a = function_e7d6e4c875d16d11(var_1f9fe9da7d30659a, abandontriggertype);

  if(isDefined(var_ab450e320225526a) && var_ab450e320225526a.size == 1) {
    return istrue(var_ab450e320225526a[0].variant_object.var_374a5c1355d22e1e);
  }

  return true;
}

function function_fd62fda7d944b7b1(var_1f9fe9da7d30659a) {
  activitycustomproperties = function_5f18e8aad46e3f21(var_1f9fe9da7d30659a);

  if(isDefined(activitycustomproperties) && isDefined(activitycustomproperties.activitytypegroup) && activitycustomproperties.activitytypegroup.size > 0) {
    var_6886b0f1888f2094 = activitycustomproperties.activitytypegroup[0].variant_object.var_6886b0f1888f2094;

    if(isDefined(var_6886b0f1888f2094)) {
      return var_6886b0f1888f2094[0].variant_object;
    }
  }

  assertmsg("<dev string:x347>");
  return undefined;
}

function getminplayercount(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);

  if(!isDefined(var_3b18ddaec245ad61.var_347a51a7bc8b8f05.playerjoinsettings.minplayercount)) {
    return 0;
  }

  return var_3b18ddaec245ad61.var_347a51a7bc8b8f05.playerjoinsettings.minplayercount;
}

function getmaxplayercount(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);

  if(!isDefined(var_3b18ddaec245ad61.var_347a51a7bc8b8f05.playerjoinsettings.maxplayercount)) {
    assertmsg("<dev string:x394>");
    return 0;
  }

  return var_3b18ddaec245ad61.var_347a51a7bc8b8f05.playerjoinsettings.maxplayercount;
}

function function_2499423a8a5868f1(var_1f9fe9da7d30659a, fromstate) {
  var_19d6942f47ac8b83 = [];
  var_19d6942f47ac8b83 = function_e933af4059193dd2(var_1f9fe9da7d30659a, fromstate, var_19d6942f47ac8b83);
  var_19d6942f47ac8b83 = function_e933af4059193dd2(var_1f9fe9da7d30659a, "s \x83", var_19d6942f47ac8b83);
  return var_19d6942f47ac8b83;
}

function function_ae56f032ad9177f4(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  return istrue(var_3b18ddaec245ad61.var_347a51a7bc8b8f05.playerjoinsettings.var_17775d85a49dcb80);
}

function function_7522bc12a8539615(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  return istrue(var_3b18ddaec245ad61.var_347a51a7bc8b8f05.playerjoinsettings.var_451fc4d9f0b6e301);
}

function function_653c923491d1ab8c(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  return istrue(var_3b18ddaec245ad61.var_347a51a7bc8b8f05.playerjoinsettings.var_11879a701182c4f8);
}

function function_c179dc3eb1dee9f0(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  activitycategory = function_3269948ea31c7332(var_1f9fe9da7d30659a);

  if(activitycategory == "\f+x5") {
    return false;
  }

  return istrue(var_3b18ddaec245ad61.var_347a51a7bc8b8f05.playerjoinsettings.var_b34b4739a4860e6f);
}

function function_86b33180e918436d(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  return var_3b18ddaec245ad61.var_5dddcc8d8d2fcba0[0].variant_object.var_9c09a8fd5d6aecdb;
}

function function_16c019964dfd7adb(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  var_16f85eca74e112d9 = var_3b18ddaec245ad61.var_5dddcc8d8d2fcba0[0].variant_object.var_4bf9a183205b49d4;

  if(isDefined(var_16f85eca74e112d9) && var_16f85eca74e112d9.size > 0) {
    return var_16f85eca74e112d9[0].variant_object.activitymoment;
  }

  println("<dev string:x40c>");
  return "\x14\x9b{|,\x05\xd9\f9\x86)\xce6";
}

function function_9bee4ffc7d3c4a4a(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  var_14a6851e7eab2f82 = var_3b18ddaec245ad61.var_5dddcc8d8d2fcba0[0].variant_object.var_23c036d8190c75f3;

  if(isDefined(var_14a6851e7eab2f82) && var_14a6851e7eab2f82.size > 0) {
    return var_14a6851e7eab2f82[0].variant_object.activitymoment;
  }

  println("<dev string:x46a>");
  return "\x94\xe6n\x8e\v\xdclYEsd";
}

function function_be103d7a1345b487(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  var_255758de65f0a4e5 = isDefined(var_3b18ddaec245ad61.var_5dddcc8d8d2fcba0) && var_3b18ddaec245ad61.var_5dddcc8d8d2fcba0.size > 0;
  return var_255758de65f0a4e5 && istrue(var_3b18ddaec245ad61.var_5dddcc8d8d2fcba0[0].variant_object.var_9ef2ec4a36908a33);
}

function function_fae78aedd860c0e7(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  return istrue(var_3b18ddaec245ad61.var_e600d382a20e3c58);
}

function function_d85f647ad03a40b1(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  return istrue(var_3b18ddaec245ad61.var_aba1ac2bb5638312);
}

function function_d34bce97eb9105ec(var_1f9fe9da7d30659a) {
  return istrue(function_cdcd003e29297cbd(var_1f9fe9da7d30659a, 1));
}

function function_855c7737d7bdda88(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  return istrue(var_3b18ddaec245ad61.var_416a472a0ddd3e1);
}

function function_66ef8e950107b96b(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  return istrue(var_3b18ddaec245ad61.switchtoactivityloadout) && isDefined(var_3b18ddaec245ad61.activityloadout);
}

function function_fe2232b8e8c57173(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  return var_3b18ddaec245ad61.activityloadout;
}

function function_e516262c61529d3b(var_1f9fe9da7d30659a) {
  var_8d7fe3600702a26a = [];
  scriptbundlename = function_f881b88edcc64c1e(var_1f9fe9da7d30659a);
  var_8d7fe3600702a26a = level.activities.var_f64d5c67db3bc1ae namespace_98284635f20f4696::function_35359b4155f1691b(scriptbundlename);

  if(!isDefined(var_8d7fe3600702a26a)) {
    function_cf8e90abd42ad2f1(scriptbundlename, var_1f9fe9da7d30659a);
    var_8d7fe3600702a26a = level.activities.var_f64d5c67db3bc1ae namespace_98284635f20f4696::function_35359b4155f1691b(scriptbundlename);
  }

  return var_8d7fe3600702a26a;
}

function function_a6491be1f27a366d(var_1f9fe9da7d30659a) {
  customproperties = function_5f18e8aad46e3f21(var_1f9fe9da7d30659a);

  if(isDefined(customproperties.activitytypegroup) && customproperties.activitytypegroup.size > 0) {
    return customproperties.activitytypegroup[0].variant_object;
  }

  return undefined;
}

function function_86cd1c6a270fef78(radiantobjectidentifier) {
  assert(isDefined(radiantobjectidentifier.name), "<dev string:x4ca>");
  assert(isDefined(radiantobjectidentifier.key), "<dev string:x504>");
  struct = utility::getStruct(radiantobjectidentifier.name, radiantobjectidentifier.key);
  assert(isDefined(struct), "<dev string:x53d>" + radiantobjectidentifier.key + "<dev string:x565>" + radiantobjectidentifier.name + "<dev string:x574>");
  return struct;
}

function function_145f6801f63114c(var_1f9fe9da7d30659a, activityspatialzonename) {
  return function_7cc26a86c2a80e65(var_1f9fe9da7d30659a, activityspatialzonename);
}

function function_443bf722a7d22510(spatialzonecontainer, spatialzonename, zoneinfostruct) {
  if(istrue(zoneinfostruct.usecustomdistance)) {
    radius = function_e3deb0acef076d88(zoneinfostruct.var_bf7db32797cd3ee3);
    ignoreheight = function_2bc7f629db0f8a81(zoneinfostruct);
    namespace_9342d78fcaacff0b::function_d98dd1246d42a25e(spatialzonecontainer, spatialzonename, undefined, radius, ignoreheight);

    if(namespace_59dbf6a1bb28a43f::isactivityinstance(spatialzonecontainer)) {
      activityinstance = spatialzonecontainer;
      namespace_9342d78fcaacff0b::function_7ade4e318cc0a207(activityinstance, spatialzonename, &namespace_59dbf6a1bb28a43f::function_c1c44508d7539941, [activityinstance]);
    }

    return;
  }

  if(istrue(zoneinfostruct.var_507cc120f9b7ee8b)) {
    activity_common::function_9c3896bd08c52ae8(spatialzonecontainer, spatialzonename);
    return;
  }

  if(istrue(zoneinfostruct.var_acca16dcdd4ee810)) {
    linkedspatialzonename = function_fcb4365d279ed596(zoneinfostruct);

    if(isstring(linkedspatialzonename)) {
      var_b00aad571ec97f4a = (zoneinfostruct.var_4e7ee3d004a3cacb ?? 100) / 100;
      namespace_9342d78fcaacff0b::function_f76bf9dd3e47f0b4(spatialzonecontainer, spatialzonename, linkedspatialzonename, var_b00aad571ec97f4a);
    }
  }
}

function function_5c77bda56fe385e2(var_1f9fe9da7d30659a) {
  var_de8531909e87a90c = function_dec39406a55e9143(var_1f9fe9da7d30659a);
  var_fdbcd0b410eb0c89 = var_de8531909e87a90c.var_fdbcd0b410eb0c89;

  if(isDefined(var_fdbcd0b410eb0c89) && var_fdbcd0b410eb0c89.size == 1) {
    return true;
  }

  return false;
}

function function_7c1644850897e5c1(var_1f9fe9da7d30659a) {
  if(function_5c77bda56fe385e2(var_1f9fe9da7d30659a)) {
    var_de8531909e87a90c = function_dec39406a55e9143(var_1f9fe9da7d30659a);
    var_fdbcd0b410eb0c89 = var_de8531909e87a90c.var_fdbcd0b410eb0c89;
    return istrue(var_fdbcd0b410eb0c89[0].variant_type == "E^\xe0\xca\xcd\xaf\x9a\xe0\x16\xee\xcd\x94\xb9G\x95\xc9\xb0\x1b\x8e\xd4\xd89-\x0e\x1dX1\x1b\xac7\x9e7\xa9\xc69-\x0e\xe8\xd4\xa3N]\x8d:\xe6");
  }

  activitytype = function_4ec07cb6fead3806(var_1f9fe9da7d30659a);
  assert("<dev string:x587>" + activitytype);

  return false;
}

function function_c69faaa88b7628a4(var_1f9fe9da7d30659a) {
  if(function_5c77bda56fe385e2(var_1f9fe9da7d30659a)) {
    var_de8531909e87a90c = function_dec39406a55e9143(var_1f9fe9da7d30659a);
    var_fdbcd0b410eb0c89 = var_de8531909e87a90c.var_fdbcd0b410eb0c89;
    return var_fdbcd0b410eb0c89[0].variant_object.interactscriptable;
  }

  activitytype = function_4ec07cb6fead3806(var_1f9fe9da7d30659a);
  assert("<dev string:x587>" + activitytype);

  return undefined;
}

function function_2bf68c0249646099(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  var_de8531909e87a90c = function_dec39406a55e9143(var_1f9fe9da7d30659a);
  var_86cd8e14cbf88467 = var_de8531909e87a90c.var_86cd8e14cbf88467;

  if(isDefined(var_86cd8e14cbf88467)) {
    return istrue(var_86cd8e14cbf88467.var_976d604aadc61d49);
  }

  return false;
}

function function_4e1b0bfd64c0896(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  var_de8531909e87a90c = function_dec39406a55e9143(var_1f9fe9da7d30659a);
  joinsettings = var_de8531909e87a90c.proximityjoinsettings;

  if(isDefined(joinsettings) && joinsettings.size == 1) {
    return istrue(joinsettings[0].variant_object.var_bc990e7302f707f6);
  }

  return false;
}

function function_f5d8690ade75cb8a(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);

  if(function_4e1b0bfd64c0896(var_1f9fe9da7d30659a)) {
    var_de8531909e87a90c = function_dec39406a55e9143(var_1f9fe9da7d30659a);
    joinsettings = var_de8531909e87a90c.proximityjoinsettings;
    var_222e9709ecba430c = joinsettings[0].variant_object.var_3651599a44f6b8bc;

    if(isDefined(var_222e9709ecba430c) && var_222e9709ecba430c.size == 1) {
      return var_222e9709ecba430c[0].variant_object.activitymoment;
    }
  }

  return undefined;
}

function function_57355d5ef27c993f(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);

  if(function_4e1b0bfd64c0896(var_1f9fe9da7d30659a)) {
    var_de8531909e87a90c = function_dec39406a55e9143(var_1f9fe9da7d30659a);
    joinsettings = var_de8531909e87a90c.proximityjoinsettings;
    var_99a569c1bf10a36a = joinsettings[0].variant_object.var_b9c93f66d978e962;

    if(isDefined(var_99a569c1bf10a36a) && var_99a569c1bf10a36a.size == 1) {
      return var_99a569c1bf10a36a[0].variant_object.activitymoment;
    }
  }

  return undefined;
}

function function_2c4568c15eb8e794(var_1f9fe9da7d30659a) {
  playerfocussettings = function_3b735c53f3171749(var_1f9fe9da7d30659a);

  if(!(isDefined(playerfocussettings) && isDefined(playerfocussettings.var_efead8c9cb49b822))) {
    return 0;
  }

  return playerfocussettings.var_efead8c9cb49b822;
}

function function_ea157702d5e19d15(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);

  if(isDefined(var_3b18ddaec245ad61.var_60296d5b1a44c547) && var_3b18ddaec245ad61.var_60296d5b1a44c547.size == 1) {
    return isDefined(var_3b18ddaec245ad61.var_60296d5b1a44c547[0].variant_object.var_4f4e3a88928c255c);
  }

  return false;
}

function function_a03971aca814705(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  assert(function_ea157702d5e19d15(var_1f9fe9da7d30659a), "<dev string:x5fb>");
  return var_3b18ddaec245ad61.var_60296d5b1a44c547[0].variant_object.var_4f4e3a88928c255c;
}

function function_ee52ff2d6c0218a1(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  assert(function_ea157702d5e19d15(var_1f9fe9da7d30659a), "<dev string:x668>");
  objectivemarkertype = function_a03971aca814705(var_1f9fe9da7d30659a);

  if(objectivemarkertype == "Y\xf2Z\x1b\xc3\x03\xb9\xee\xd1\x95") {
    return var_3b18ddaec245ad61.var_60296d5b1a44c547[0].variant_object.objectivemarkerscriptable;
  }

  if(objectivemarkertype == "yw\xf9\x973\xc6@t\xee") {
    return var_3b18ddaec245ad61.var_60296d5b1a44c547[0].variant_object.objectivemarkerscriptbundle;
  }

  assertmsg("<dev string:x6d6>" + objectivemarkertype + "<dev string:x700>");
}

function function_d8fec2f7c41a0122(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  assert(function_ea157702d5e19d15(var_1f9fe9da7d30659a), "<dev string:x668>");
  var_721827543b78578b = var_3b18ddaec245ad61.var_60296d5b1a44c547[0].variant_object.var_721827543b78578b;

  if(!isDefined(var_721827543b78578b) || var_721827543b78578b.size == 0) {
    iprintln("<dev string:x714>");

    return "n\x9b\xad\xd2\x96\xc1\x19}\xcf%\as\x11";
  }

  return var_721827543b78578b[0].variant_object.activitymoment;
}

function function_62a8f782b04a867f(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  assert(function_ea157702d5e19d15(var_1f9fe9da7d30659a), "<dev string:x668>");
  var_5594057f7b188338 = var_3b18ddaec245ad61.var_60296d5b1a44c547[0].variant_object.var_5594057f7b188338;

  if(!isDefined(var_5594057f7b188338) || var_5594057f7b188338.size == 0) {
    iprintln("<dev string:x7b3>");

    return "(\xbd%\xa1\x18I\xd2xur\xcb";
  }

  return var_5594057f7b188338[0].variant_object.activitymoment;
}

function function_a2a1b2d9799211b3(var_1f9fe9da7d30659a) {
  assert(function_ea157702d5e19d15(var_1f9fe9da7d30659a), "<dev string:x668>");
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  return istrue(var_3b18ddaec245ad61.var_60296d5b1a44c547[0].variant_object.var_ac2ac62036eb1ab1);
}

function function_f358faf830e4352b(var_1f9fe9da7d30659a) {
  assert(function_ea157702d5e19d15(var_1f9fe9da7d30659a), "<dev string:x668>");
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  return istrue(var_3b18ddaec245ad61.var_60296d5b1a44c547[0].variant_object.shouldpin);
}

function function_2bc7f629db0f8a81(zoneinfostruct) {
  return istrue(zoneinfostruct.ignoreheightvalue);
}

function function_55562bba8ab39b02(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  return istrue(var_3b18ddaec245ad61.var_f6aefb481f084215.var_832bc2a110e590f.var_68105c573fae96e7);
}

function function_b6af53d8e1851fa4(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  return istrue(var_3b18ddaec245ad61.var_f6aefb481f084215.var_832bc2a110e590f.var_64f58fdc6c0e84ef);
}

function function_8a9095c5f92d736(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  return istrue(var_3b18ddaec245ad61.hibernationsettings.hibernationisenabled);
}

function function_a21bf9df37710597(var_1f9fe9da7d30659a) {
  if(isDefined(var_1f9fe9da7d30659a)) {
    var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);

    if(isDefined(var_3b18ddaec245ad61)) {
      return var_3b18ddaec245ad61.activityrewardcaches;
    }
  }

  return undefined;
}

function function_57c19a651f5972b5(var_1f9fe9da7d30659a) {
  associatedscriptbundlename = function_f881b88edcc64c1e(var_1f9fe9da7d30659a);

  if(isDefined(associatedscriptbundlename)) {
    var_16a1d06ab76c27c2 = getscriptbundle(associatedscriptbundlename);
    return var_16a1d06ab76c27c2;
  }

  assertmsg("<dev string:x854>");
  return undefined;
}

function private function_fbd3218df26cefc(activityinstance, var_2d8a6120cb208bd6) {
  activitytype = activityinstance.type;
  varianttag = activityinstance.varianttag;
  var_cf8d92d9a34baa52 = undefined;

  if(isDefined(var_2d8a6120cb208bd6)) {
    var_e489d85161bb3157 = [[var_2d8a6120cb208bd6]]();
    var_cf8d92d9a34baa52 = var_e489d85161bb3157[varianttag];
  }

  if(!(isDefined(var_cf8d92d9a34baa52.scriptstructorigin) && isDefined(var_cf8d92d9a34baa52.scriptstructoriginoffset))) {
    assertmsg("<dev string:x8ba>" + activitytype + "<dev string:x8ea>" + varianttag + "<dev string:x8ef>");
  }

  cscenterstruct = spawnStruct();
  cscenterstruct.origin = var_cf8d92d9a34baa52.scriptstructorigin;
  cscenterstruct.angles = (0, 0, 0);
  create_script_utility::translate_position_with_offset_data(var_cf8d92d9a34baa52.cf, cscenterstruct, var_cf8d92d9a34baa52.scriptstructoriginoffset, (0, 0, 0));
  namespace_9342d78fcaacff0b::function_d98dd1246d42a25e(activityinstance, "\x8b\xef\xf6\x04Pn\xf7\xde\x89\xaft\xda\x0f\x19\xe0\xdc\x1b\xeeO", cscenterstruct.origin);

  if(isDefined(var_cf8d92d9a34baa52.var_d5904a0477c7b1b6)) {
    foreach(var_6dc8898b57bcff12 in var_cf8d92d9a34baa52.var_d5904a0477c7b1b6) {
      function_f45e4ebe57d5cb01(activityinstance, spatialzonename, var_cf8d92d9a34baa52, var_6dc8898b57bcff12);
    }
  }
}

function private function_f45e4ebe57d5cb01(activitydefinition, spatialzonename, instancemetadata, zonemetadata) {
  zoneinfostruct = function_145f6801f63114c(activitydefinition, spatialzonename);
  var_a3da7d6163845fd6 = !isDefined(zoneinfostruct) || istrue(zoneinfostruct.var_da954b0b740c62d6);
  var_95620cdc2a0ee662 = isDefined(zonemetadata);

  if(var_95620cdc2a0ee662 && var_a3da7d6163845fd6) {
    function_f8677bfa64912834(zonemetadata, instancemetadata.cf, instancemetadata.scriptstructoriginoffset);

    if(isDefined(zoneinfostruct) && istrue(zoneinfostruct.var_150502cbcbf04619)) {
      namespace_9342d78fcaacff0b::function_2aec393c918e9b98(activitydefinition, spatialzonename);
    } else {
      namespace_9342d78fcaacff0b::addspatialzone(activitydefinition, spatialzonename);
    }

    for(sphereindex = 0; sphereindex < zonemetadata.locationorigin.size; sphereindex++) {
      origin = zonemetadata.locationorigin[sphereindex];
      radius = zonemetadata.locationradius[sphereindex];

      if(isDefined(zoneinfostruct)) {
        ignoreheight = function_2bc7f629db0f8a81(zoneinfostruct);
        namespace_9342d78fcaacff0b::function_d98dd1246d42a25e(activitydefinition, spatialzonename, origin, radius, ignoreheight);
        continue;
      }

      namespace_9342d78fcaacff0b::function_d98dd1246d42a25e(activitydefinition, spatialzonename, origin, radius);
    }
  }

  if(var_95620cdc2a0ee662 && isDefined(zoneinfostruct) && !istrue(zoneinfostruct.var_da954b0b740c62d6)) {
    activitytype = function_4ec07cb6fead3806(activitydefinition);
    assertmsg("<dev string:x92e>" + activitytype + "<dev string:x941>" + spatialzonename + "<dev string:x956>");
  }
}

function private function_f8677bfa64912834(var_4767542bbc644feb, createscriptfile, centeroffset) {
  for(originindex = 0; originindex < var_4767542bbc644feb.locationorigin.size; originindex++) {
    center = spawnStruct();
    center.origin = var_4767542bbc644feb.locationorigin[originindex];
    center.angles = (0, 0, 0);
    create_script_utility::translate_position_with_offset_data(createscriptfile, center, centeroffset, (0, 0, 0));
    var_4767542bbc644feb.locationorigin[originindex] = center.origin;
  }
}

function private function_206bb162bd7af568(scriptbundlename, var_1f9fe9da7d30659a) {
  activitydefinitionbundle = level.activities.var_30a589f82d9a8555 namespace_98284635f20f4696::function_35359b4155f1691b(scriptbundlename);

  if(!isDefined(activitydefinitionbundle)) {
    activitydefinitionbundle = getscriptbundle(scriptbundlename);

    if(isDefined(activitydefinitionbundle)) {
      function_52549fca7b71df2(scriptbundlename, activitydefinitionbundle, var_1f9fe9da7d30659a);
      level.activities.var_30a589f82d9a8555 namespace_98284635f20f4696::addtocache(scriptbundlename, activitydefinitionbundle);
    }
  }

  return activitydefinitionbundle;
}

function private function_f881b88edcc64c1e(var_1f9fe9da7d30659a) {
  associatedscriptbundlename = undefined;

  if(namespace_59dbf6a1bb28a43f::isactivityinstance(var_1f9fe9da7d30659a)) {
    activitydefinition = function_e2fc5d3b23f01ac5(var_1f9fe9da7d30659a);
    associatedscriptbundlename = activitydefinition.associatedscriptbundlename;
  } else if(function_19b33c2d5e586393(var_1f9fe9da7d30659a)) {
    activitydefinition = var_1f9fe9da7d30659a;
    associatedscriptbundlename = activitydefinition.associatedscriptbundlename;
  }

  assert(isDefined(associatedscriptbundlename), "<dev string:x854>");
  return associatedscriptbundlename;
}

function private function_b0d948f86d8df7db(activityinstance) {
  if(function_20efd4f715d6d4d(activityinstance, "\xa0\xdda\x9c\x95\xb9\x95\xdcs}K\xb7\xb9\x95")) {
    zoneinfostruct = function_7cc26a86c2a80e65(activityinstance, "\xa0\xdda\x9c\x95\xb9\x95\xdcs}K\xb7\xb9\x95");
    function_443bf722a7d22510(activityinstance, "\xa0\xdda\x9c\x95\xb9\x95\xdcs}K\xb7\xb9\x95", zoneinfostruct);
  }

  if(function_20efd4f715d6d4d(activityinstance, "\xc7=\x8d\xdaq\x05\xa1\x80d8\x16\xb0\xe8\x13\xd2\xd0\xb9^\x82")) {
    zoneinfostruct = function_7cc26a86c2a80e65(activityinstance, "\xc7=\x8d\xdaq\x05\xa1\x80d8\x16\xb0\xe8\x13\xd2\xd0\xb9^\x82");
    function_443bf722a7d22510(activityinstance, "\xc7=\x8d\xdaq\x05\xa1\x80d8\x16\xb0\xe8\x13\xd2\xd0\xb9^\x82", zoneinfostruct);
  }

  if(function_20efd4f715d6d4d(activityinstance, "(\xd4\xd3\r\xeb\xfd\x1a\b\x9dN\x9dF\x1f\xcd\xf0_\xb5/\x82\x17\x9d\xad")) {
    zoneinfostruct = function_7cc26a86c2a80e65(activityinstance, "(\xd4\xd3\r\xeb\xfd\x1a\b\x9dN\x9dF\x1f\xcd\xf0_\xb5/\x82\x17\x9d\xad");
    function_443bf722a7d22510(activityinstance, "(\xd4\xd3\r\xeb\xfd\x1a\b\x9dN\x9dF\x1f\xcd\xf0_\xb5/\x82\x17\x9d\xad", zoneinfostruct);
  }

  if(function_20efd4f715d6d4d(activityinstance, "\xc8\x01\xe2\xf79Go\xc7\xd2\xde\x167\xa8&\xb2nL4\x9c\xa3q\xbe\x9dR(")) {
    zoneinfostruct = function_7cc26a86c2a80e65(activityinstance, "\xc8\x01\xe2\xf79Go\xc7\xd2\xde\x167\xa8&\xb2nL4\x9c\xa3q\xbe\x9dR(");
    function_443bf722a7d22510(activityinstance, "\xc8\x01\xe2\xf79Go\xc7\xd2\xde\x167\xa8&\xb2nL4\x9c\xa3q\xbe\x9dR(", zoneinfostruct);
  }

  if(function_20efd4f715d6d4d(activityinstance, "\x8f/\x117>.\xa1\xf9\xf5<\xeb\x7fUmO!")) {
    zoneinfostruct = function_7cc26a86c2a80e65(activityinstance, "\x8f/\x117>.\xa1\xf9\xf5<\xeb\x7fUmO!");
    function_443bf722a7d22510(activityinstance, "\x8f/\x117>.\xa1\xf9\xf5<\xeb\x7fUmO!", zoneinfostruct);
  }
}

function private function_fcb4365d279ed596(zoneinfostruct) {
  return zoneinfostruct.spatialzonename[0].variant_object.spatialzonename;
}

function private function_20efd4f715d6d4d(var_1f9fe9da7d30659a, activityspatialzone) {
  zoneinfostruct = function_7cc26a86c2a80e65(var_1f9fe9da7d30659a, activityspatialzone);

  if(isDefined(zoneinfostruct)) {
    var_48d19746cf6fe9ae = !isDefined(zoneinfostruct.var_8559dd495af4d7e4);
    return var_48d19746cf6fe9ae;
  }

  return 0;
}

function private function_7cc26a86c2a80e65(var_1f9fe9da7d30659a, activityspatialzone) {
  zoneinfostruct = undefined;

  if(activityspatialzone == "\xa0\xdda\x9c\x95\xb9\x95\xdcs}K\xb7\xb9\x95") {
    zoneinfostruct = function_756314acd2f66c6d(var_1f9fe9da7d30659a);
  } else if(activityspatialzone == "\xc7=\x8d\xdaq\x05\xa1\x80d8\x16\xb0\xe8\x13\xd2\xd0\xb9^\x82") {
    zoneinfostruct = function_72bfe6c8971d2fdd(var_1f9fe9da7d30659a);
  } else if(activityspatialzone == "\xc8\x01\xe2\xf79Go\xc7\xd2\xde\x167\xa8&\xb2nL4\x9c\xa3q\xbe\x9dR(") {
    zoneinfostruct = function_dcf2a74addaf5ac(var_1f9fe9da7d30659a);
  } else if(activityspatialzone == "\x8f/\x117>.\xa1\xf9\xf5<\xeb\x7fUmO!") {
    zoneinfostruct = function_92c54dd4b928e713(var_1f9fe9da7d30659a);
  } else if(activityspatialzone == "(\xd4\xd3\r\xeb\xfd\x1a\b\x9dN\x9dF\x1f\xcd\xf0_\xb5/\x82\x17\x9d\xad") {
    zoneinfostruct = function_1de668263b0f5437(var_1f9fe9da7d30659a);
  }

  return zoneinfostruct;
}

function private function_e7d6e4c875d16d11(var_1f9fe9da7d30659a, abandontriggertype) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);

  if(abandontriggertype == 0) {
    return var_3b18ddaec245ad61.var_347a51a7bc8b8f05.var_eaca878eccaf18a1.var_eeb66b99fafc172b;
  } else if(abandontriggertype == 1) {
    return var_3b18ddaec245ad61.var_347a51a7bc8b8f05.var_eaca878eccaf18a1.var_c74db9362a4da70f;
  }

  assert("<dev string:x9af>" + abandontriggertype + "<dev string:x9c9>");
  return undefined;
}

function private function_3b735c53f3171749(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  return var_3b18ddaec245ad61.var_347a51a7bc8b8f05.playerfocussettings;
}

function private function_cd05c1904d540a87(var_1f9fe9da7d30659a) {
  if(namespace_59dbf6a1bb28a43f::isactivityinstance(var_1f9fe9da7d30659a)) {
    activitydefinition = function_e2fc5d3b23f01ac5(var_1f9fe9da7d30659a);
    associatedscriptbundle = function_206bb162bd7af568(activitydefinition.associatedscriptbundlename, var_1f9fe9da7d30659a);
    return associatedscriptbundle.var_3b18ddaec245ad61;
  } else if(function_19b33c2d5e586393(var_1f9fe9da7d30659a)) {
    activitydefinition = var_1f9fe9da7d30659a;
    associatedscriptbundle = function_206bb162bd7af568(activitydefinition.associatedscriptbundlename, var_1f9fe9da7d30659a);
    return associatedscriptbundle.var_3b18ddaec245ad61;
  } else if(isDefined(var_1f9fe9da7d30659a.var_3b18ddaec245ad61)) {
    return var_1f9fe9da7d30659a.var_3b18ddaec245ad61;
  }

  assertmsg("<dev string:x854>");
  return undefined;
}

function private function_5f18e8aad46e3f21(var_1f9fe9da7d30659a) {
  if(namespace_59dbf6a1bb28a43f::isactivityinstance(var_1f9fe9da7d30659a)) {
    activitydefinition = function_e2fc5d3b23f01ac5(var_1f9fe9da7d30659a);
    return level.activities.var_ca45771bdb7140b2[activitydefinition.associatedscriptbundlename];
  } else if(function_19b33c2d5e586393(var_1f9fe9da7d30659a)) {
    activitydefinition = var_1f9fe9da7d30659a;
    return level.activities.var_ca45771bdb7140b2[activitydefinition.associatedscriptbundlename];
  } else if(isDefined(var_1f9fe9da7d30659a.var_3b18ddaec245ad61)) {
    return var_1f9fe9da7d30659a.customproperties;
  }

  assertmsg("<dev string:x854>");
  return undefined;
}

function private function_4ec07cb6fead3806(var_1f9fe9da7d30659a) {
  customproperties = function_fd62fda7d944b7b1(var_1f9fe9da7d30659a);
  return customproperties.activitytype;
}

function private function_38522dcf793ec2e3(var_862702a16f3382e2) {
  if(isDefined(level.activities.definitions[var_862702a16f3382e2.variantstruct.name])) {
    return getactivitydefinition(var_862702a16f3382e2.variantstruct.name);
  }

  activityvariantname = var_862702a16f3382e2.variantstruct.name;
  bundlename = var_862702a16f3382e2.variantstruct.activity_bundle;

  if(!isDefined(bundlename)) {
    bundlename = function_cbcb2c30f2bc7bd6(activityvariantname);
  }

  if(isstring(bundlename) && bundlename != "") {
    activitydefinition = function_df771d052ab39d5e(bundlename, activityvariantname);
    return activitydefinition;
  }

  assert("<dev string:x9ec>" + activityvariantname);
}

function private function_cbcb2c30f2bc7bd6(activityvariantname) {
  var_1a182f6776aa5f = undefined;

  for(variantscriptstructinfo = activity_common::function_d4c38791b19a0631(activityvariantname); !isDefined(var_1a182f6776aa5f) && isDefined(variantscriptstructinfo); variantscriptstructinfo = undefined) {
    var_dd6c7b716a72cc19 = variantscriptstructinfo.variantstruct;

    if(isDefined(var_dd6c7b716a72cc19.activity_bundle)) {
      var_1a182f6776aa5f = var_dd6c7b716a72cc19.activity_bundle;
      continue;
    }

    if(isstring(var_dd6c7b716a72cc19.parent)) {
      variantscriptstructinfo = activity_common::function_d4c38791b19a0631(var_dd6c7b716a72cc19.parent);
      continue;
    }
  }

  var_9cce53f296541d7 = utility::string_split(var_1a182f6776aa5f, "\xb0");

  if(var_9cce53f296541d7.size == 1) {
    var_1a182f6776aa5f = "`*t\xc1\x88H\x1eW\x80\x7f\xe6C\xdb\xb4x\xc2\xf4\x83\xb5" + var_1a182f6776aa5f;
  }

  return var_1a182f6776aa5f;
}

function private function_e3deb0acef076d88(distancesettings) {
  if(!isDefined(distancesettings.customdistance)) {
    assertmsg("<dev string:xa37>");
    return 0;
  }

  return distancesettings.customdistance;
}

function private function_8546b133b55379f6(activitytype) {
  return isDefined(level.activities.types[activitytype]);
}

function private function_491fdf88e169c30(activitytype) {
  assert(function_8546b133b55379f6(activitytype), "<dev string:xaa3>");
  return level.activities.types[activitytype];
}

function private function_c084714427c7e9f6(var_1f9fe9da7d30659a, startstate, endstate) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);

  if(startstate == "\xb1\x88\xc2*" && endstate == "\xc3\x93}=nD") {
    return var_3b18ddaec245ad61.var_f6aefb481f084215.var_2e9fcd41641b92c8;
  }

  if(startstate == "\xa2\xb9\x19\x95d" && endstate == "@Z'\v\x9eS\xce") {
    return var_3b18ddaec245ad61.var_f6aefb481f084215.var_73bebf6a4d946175;
  }
}

function private function_52549fca7b71df2(scriptbundlename, scriptbundle, var_1f9fe9da7d30659a) {
  var_c3d2a1adfefc87a7 = level.activities.var_f64d5c67db3bc1ae namespace_98284635f20f4696::function_35359b4155f1691b(scriptbundlename);

  if(!isDefined(var_c3d2a1adfefc87a7)) {
    function_cf8e90abd42ad2f1(scriptbundlename, var_1f9fe9da7d30659a, scriptbundle);
  }

  scriptbundle.var_3b18ddaec245ad61.playerbroadcasts = undefined;
  scriptbundle.var_3b18ddaec245ad61.customproperties = undefined;
}

function private function_cf8e90abd42ad2f1(scriptbundlename, var_1f9fe9da7d30659a, var_7e12853ca2478df3) {
  if(!isDefined(var_7e12853ca2478df3)) {
    var_7e12853ca2478df3 = function_57c19a651f5972b5(var_1f9fe9da7d30659a);
  }

  activitycategory = function_3269948ea31c7332(var_7e12853ca2478df3);
  var_5cd34a2b78854ee5 = activity_common::function_e2a88f5f71c982cf();
  var_7be8abaca7f8d1b4 = activity_common::function_5cd62eb0de217a5f(activitycategory);
  var_8d7fe3600702a26a = namespace_59b081b19a436abb::function_3b9f86835341433c(var_7e12853ca2478df3);
  var_40df77b7bf9c2521 = namespace_59b081b19a436abb::function_b7a7d4f5a06e3e20();
  namespace_59b081b19a436abb::function_721deecee0910981(var_40df77b7bf9c2521, var_5cd34a2b78854ee5);
  namespace_59b081b19a436abb::function_721deecee0910981(var_40df77b7bf9c2521, var_7be8abaca7f8d1b4);
  namespace_59b081b19a436abb::function_721deecee0910981(var_40df77b7bf9c2521, var_8d7fe3600702a26a);
  level.activities.var_f64d5c67db3bc1ae namespace_98284635f20f4696::addtocache(scriptbundlename, var_40df77b7bf9c2521);
}

function private function_756314acd2f66c6d(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);

  if(isDefined(var_3b18ddaec245ad61.var_1970b3e2fccdfd26) && var_3b18ddaec245ad61.var_1970b3e2fccdfd26.size > 0) {
    return var_3b18ddaec245ad61.var_1970b3e2fccdfd26[0].variant_object;
  }

  return undefined;
}

function private function_72bfe6c8971d2fdd(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);

  if(function_4e1b0bfd64c0896(var_1f9fe9da7d30659a)) {
    var_de8531909e87a90c = function_dec39406a55e9143(var_1f9fe9da7d30659a);
    joinsettings = var_de8531909e87a90c.proximityjoinsettings;

    if(isDefined(joinsettings[0].variant_object.var_e5811db76e6f0ae5) && joinsettings[0].variant_object.var_e5811db76e6f0ae5.size > 0) {
      return joinsettings[0].variant_object.var_e5811db76e6f0ae5[0].variant_object;
    }
  }

  return undefined;
}

function private function_dcf2a74addaf5ac(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);

  if(isDefined(var_3b18ddaec245ad61.var_5dddcc8d8d2fcba0) && var_3b18ddaec245ad61.var_5dddcc8d8d2fcba0.size > 0) {
    if(isDefined(var_3b18ddaec245ad61.var_5dddcc8d8d2fcba0[0].variant_object.var_eab9051b68f0ceaf) && var_3b18ddaec245ad61.var_5dddcc8d8d2fcba0[0].variant_object.var_eab9051b68f0ceaf.size > 0) {
      return var_3b18ddaec245ad61.var_5dddcc8d8d2fcba0[0].variant_object.var_eab9051b68f0ceaf[0].variant_object;
    }
  }

  return undefined;
}

function private function_92c54dd4b928e713(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);

  if(isDefined(var_3b18ddaec245ad61.hibernationsettings.var_67d8584dac2e868c) && var_3b18ddaec245ad61.hibernationsettings.var_67d8584dac2e868c.size > 0) {
    return var_3b18ddaec245ad61.hibernationsettings.var_67d8584dac2e868c[0].variant_object;
  }

  return undefined;
}

function private function_1de668263b0f5437(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  var_51b1523854c64cf5 = function_e7d6e4c875d16d11(var_1f9fe9da7d30659a, 0);

  if(isDefined(var_51b1523854c64cf5)) {
    return var_51b1523854c64cf5[0].variant_object.var_c7b52f786a662026[0].variant_object;
  }

  return undefined;
}

function private function_dec39406a55e9143(var_1f9fe9da7d30659a) {
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  return var_3b18ddaec245ad61.var_347a51a7bc8b8f05.playerjoinsettings.var_de8531909e87a90c;
}

function private function_19b33c2d5e586393(activitydefinition) {
  return istrue(activitydefinition.isactivitydefinition);
}

function private function_e933af4059193dd2(var_1f9fe9da7d30659a, fromstate, var_19d6942f47ac8b83) {
  var_19d6942f47ac8b83 = var_19d6942f47ac8b83 ?? [];
  var_3b18ddaec245ad61 = function_cd05c1904d540a87(var_1f9fe9da7d30659a);
  var_f6aefb481f084215 = var_3b18ddaec245ad61.var_f6aefb481f084215;

  if(isarray(var_f6aefb481f084215.var_b3f8ee947ee03761)) {
    foreach(var_aedb17e463423951 in var_f6aefb481f084215.var_b3f8ee947ee03761) {
      if(isarray(var_aedb17e463423951.var_cd6fa51028d4bd12) && var_aedb17e463423951.fromstate == fromstate) {
        foreach(var_5b2e3a21c2b72f57 in var_aedb17e463423951.var_cd6fa51028d4bd12) {
          if(var_5b2e3a21c2b72f57.variant_type == "Q\xf2\x1ce\xdc\xbeMW\xe6\x1dH\v\xec\x95(la\xf2\x95'\xb9N+\vN\x13yC\xf672\xa5\x1d-\xed7") {
            var_28af4c6b339ea5c4 = {
              #uniquename: "\x82cX\xcbY\x93\xe6\x01]-\x1d\x86K\x9b\x02\xd2\xdb\xb9V\x02H\xb1{\x1b\xb6\xca'", #tostate: var_aedb17e463423951.tostate, #fromstate: var_aedb17e463423951.fromstate
            };
            var_28af4c6b339ea5c4.zoneinfostruct = var_5b2e3a21c2b72f57.variant_object.var_50112a915fbc7e3c[0].variant_object;
            var_19d6942f47ac8b83[var_19d6942f47ac8b83.size] = var_28af4c6b339ea5c4;
          }

          if(var_5b2e3a21c2b72f57.variant_type == "\x12\x06\x0e+\x8e\x81\x9b\x95\xa2\xd7\xe6\x84\xf2\xad\x90-\x8e?\xeb\xb0\xfe\xec\x0eb\xee\x96\xf4.\xc3\x98\xe22 \xa8\x02(#") {
            var_28af4c6b339ea5c4 = {
              #uniquename: "\x14\xc6\xc2\x97eNs\b\xa7u:\xcd\xd2\x19\xac\x10\xd2\xbd\xb9\xac\x01B\xc6o6\xd6Vr", #tostate: var_aedb17e463423951.tostate, #fromstate: var_aedb17e463423951.fromstate
            };
            var_28af4c6b339ea5c4.zoneinfostruct = var_5b2e3a21c2b72f57.variant_object.var_50112a915fbc7e3c[0].variant_object;
            var_19d6942f47ac8b83[var_19d6942f47ac8b83.size] = var_28af4c6b339ea5c4;
          }

          if(var_5b2e3a21c2b72f57.variant_type == "\xe6\aO\xad<K\xde\x02\xb6\tgQe\xc0\xf0\x16r|\x847\xd9\\9tP\x98-Q\x9d\xfdS\f\xd2\xac;\x8dX8\x82\x9e\x98") {
            if(getminplayercount(var_1f9fe9da7d30659a) > 0) {
              var_28af4c6b339ea5c4 = {
                #uniquename: "\xaa\xec\xa1\v\xa4\xdd\r\v\x0e)\xff\xc2\xbfnT\xeb\xed@T\r\x1f\v\x1c\x16.\xc2i\x86\x83q\a\xc1\xe1\x0f\xec\x91", #tostate: var_aedb17e463423951.tostate, #fromstate: var_aedb17e463423951.fromstate
              };
              var_19d6942f47ac8b83[var_19d6942f47ac8b83.size] = var_28af4c6b339ea5c4;
            }
          }

          if(var_5b2e3a21c2b72f57.variant_type == ";\xe5\x9b\\\x83\xf7\xaed\xfd\x0e\xff\x8ba\xb8\x0f\xcd\xa3\xa3\xd8;\x85\x13\xdf\x15&\xf5H\n\xc6'\xa9\xd5Vr\xa9\x8c8\xbc=\x14\xca%\xe5(") {
            var_28af4c6b339ea5c4 = {
              #uniquename: "lu;\xb0<\xc1<\"0R\x9a\xf8\r\xdf7!\xc7\xda", #tostate: var_aedb17e463423951.tostate, #fromstate: var_aedb17e463423951.fromstate
            };
            var_28af4c6b339ea5c4.timedelay = var_5b2e3a21c2b72f57.variant_object.timedelay;
            var_19d6942f47ac8b83[var_19d6942f47ac8b83.size] = var_28af4c6b339ea5c4;
          }
        }
      }
    }
  }

  return var_19d6942f47ac8b83;
}