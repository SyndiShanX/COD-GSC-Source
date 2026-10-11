/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3e34d236a84cfd96.gsc
*************************************************/

#using script_1284b3cfbb3c5dff;
#using script_41387eecc35b88bf;
#using script_60166ec58f894b68;
#using script_638d701d263ee1ed;
#using script_fe797d0f2980f96;
#using scripts\common\create_script_utility;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_cbce72e68c388ef8;

function function_b4bf8c9d70e9be33() {
  function_79f6b9ffeb872713();
  function_d330f3a028854239();

  if(!function_fd8734d232315c9d()) {
    return;
  }

  if(isDefined(level.var_5b7c4eafd38d35c)) {
    assertmsg("<dev string:x1c>");
    return;
  }

  function_c477fdff9390e85c();
  level.var_5b7c4eafd38d35c = spawnStruct();
  level.var_5b7c4eafd38d35c.var_440d9c34db4e31c6 = function_449be28dc3149e33();
  level.var_5b7c4eafd38d35c.activityinstances = function_edc905da95ecccc0();
  level.var_5b7c4eafd38d35c.runninginstances = function_edc905da95ecccc0();
  level.var_5b7c4eafd38d35c.var_5bae03c7e426693e = [];
  var_a165f6980e3e577 = function_6a64df48ad4ce4f9();

  foreach(supportedclass in var_a165f6980e3e577) {
    level thread function_c32b2819d846538a(supportedclass);
  }

  namespace_925730df71cc5248::init();

  if(getdvarint(@ "hash_dede58a4093c8a4e", 0) != 0) {
    thread function_98c2a72b9cf77ce8();
  }
}

function function_6a64df48ad4ce4f9() {
  return ["global", "activity", "contract", "objective", "startup"];
}

function function_fd8734d232315c9d() {
  return getdvarint(@ "am_enabled", 1) != 0;
}

function function_a055325e4e4436fe(point, fastcheck) {
  if(!isvector(point)) {
    assertmsg("<dev string:x4e>");
    return false;
  }

  if(!function_e06af65b4d65ed48()) {
    return false;
  }

  classes = function_6a64df48ad4ce4f9();
  regions = [];

  if(fastcheck) {
    distancecheck = getdvarint(@ "hash_61fb7ce4a31695dd", 10000);
    regions[regions.size] = namespace_f721fc7d0d2d0f47::get_region(point);
    regions[regions.size] = namespace_f721fc7d0d2d0f47::get_region(point + (distancecheck, 0, 0));
    regions[regions.size] = namespace_f721fc7d0d2d0f47::get_region(point + (distancecheck * -1, 0, 0));
    regions[regions.size] = namespace_f721fc7d0d2d0f47::get_region(point + (0, distancecheck, 0));
    regions[regions.size] = namespace_f721fc7d0d2d0f47::get_region(point + (0, distancecheck * -1, 0));
    regions[regions.size] = namespace_f721fc7d0d2d0f47::get_region(point + (distancecheck, distancecheck, 0));
    regions[regions.size] = namespace_f721fc7d0d2d0f47::get_region(point + (distancecheck * -1, distancecheck, 0));
    regions[regions.size] = namespace_f721fc7d0d2d0f47::get_region(point + (distancecheck, distancecheck * -1, 0));
    regions[regions.size] = namespace_f721fc7d0d2d0f47::get_region(point + (distancecheck * -1, distancecheck * -1, 0));
    regions = utility::array_remove_duplicates(regions);
  } else {
    regions = function_a859e6c35826dace();
  }

  profilebeginevent(#"hash_59dcf9369a70c0af");

  foreach(activityclass in classes) {
    var_d3f80f753ed44895 = function_1b47ccaf25ca8af6(@ "hash_176090f07a9fa6df", activityclass, 1800);

    foreach(region in regions) {
      foreach(var_ff9517ad7a67fe1b, runninginstances in level.var_5b7c4eafd38d35c.runninginstances[activityclass][region]) {
        foreach(var_fc3502c3e30b9ee8, runninginstance in runninginstances) {
          var_b8ae05752fde29d7 = level.var_5b7c4eafd38d35c.activityinstances[activityclass][region][var_ff9517ad7a67fe1b][var_fc3502c3e30b9ee8];

          if(var_b8ae05752fde29d7.origins.size >= 0) {
            assert(var_b8ae05752fde29d7.origins.size == var_b8ae05752fde29d7.radii.size);

            for(var_5f44e70a575de704 = 0; var_5f44e70a575de704 < var_b8ae05752fde29d7.origins.size; var_5f44e70a575de704++) {
              runningorigin = var_b8ae05752fde29d7.origins[var_5f44e70a575de704];
              runningradius = var_b8ae05752fde29d7.radii[var_5f44e70a575de704];
              testdistancesquared = squared(max(runningradius + var_d3f80f753ed44895, 0));

              if(distance2dsquared(point, runningorigin) <= testdistancesquared) {
                profileendevent();
                return true;
              }
            }
          }
        }
      }
    }
  }

  profileendevent();
  return false;
}

function function_d0ac7479e6ae2265(enabled) {
  assert(isint(enabled));
  setDvar(@ "am_enabled", enabled);
}

function private function_f4e7d933f9ff61a8(var_d6f4e59152a8fc10, var_e20111b91d278970, var_dbeb0b118366fd67, var_1de192faa35779c5, var_9e256fbd86835c52) {
  if(!isDefined(level.var_5b7c4eafd38d35c.var_5bae03c7e426693e[var_d6f4e59152a8fc10])) {
    level.var_5b7c4eafd38d35c.var_5bae03c7e426693e[var_d6f4e59152a8fc10] = [];
  }

  if(!isDefined(level.var_5b7c4eafd38d35c.var_5bae03c7e426693e[var_d6f4e59152a8fc10][var_e20111b91d278970])) {
    level.var_5b7c4eafd38d35c.var_5bae03c7e426693e[var_d6f4e59152a8fc10][var_e20111b91d278970] = [];
  }

  if(!isDefined(level.var_5b7c4eafd38d35c.var_5bae03c7e426693e[var_d6f4e59152a8fc10][var_e20111b91d278970][var_dbeb0b118366fd67])) {
    level.var_5b7c4eafd38d35c.var_5bae03c7e426693e[var_d6f4e59152a8fc10][var_e20111b91d278970][var_dbeb0b118366fd67] = [];
  }

  level.var_5b7c4eafd38d35c.var_5bae03c7e426693e[var_d6f4e59152a8fc10][var_e20111b91d278970][var_dbeb0b118366fd67][var_1de192faa35779c5] = var_9e256fbd86835c52;
}

function function_c5aad7bc83cfa234(var_d6f4e59152a8fc10, var_e20111b91d278970, var_dbeb0b118366fd67, var_1de192faa35779c5, var_9e256fbd86835c52, unidirectional) {
  assert(isstring(var_d6f4e59152a8fc10));
  assert(isstring(var_dbeb0b118366fd67));
  assert(isnumber(var_9e256fbd86835c52));

  if(!function_e06af65b4d65ed48()) {
    return;
  }

  if(!isDefined(level.var_5b7c4eafd38d35c.var_5bae03c7e426693e)) {
    return;
  }

  function_f4e7d933f9ff61a8(var_d6f4e59152a8fc10, var_e20111b91d278970, var_dbeb0b118366fd67, var_1de192faa35779c5, var_9e256fbd86835c52);

  if(!istrue(unidirectional)) {
    function_f4e7d933f9ff61a8(var_dbeb0b118366fd67, var_1de192faa35779c5, var_d6f4e59152a8fc10, var_e20111b91d278970, var_9e256fbd86835c52);
  }
}

function function_ba98175a5f6557f2() {
  if(!function_e06af65b4d65ed48()) {
    return;
  }

  regions = function_a859e6c35826dace();
  classes = function_6a64df48ad4ce4f9();

  foreach(class in classes) {
    foreach(region in regions) {
      var_7d0882489e1ab140 = level.var_5b7c4eafd38d35c.activityinstances[class];

      foreach(activityinstances in var_7d0882489e1ab140[region]) {
        foreach(activityinstance in activityinstances) {
          activityinstance.var_c0158bce0946adab = function_a9bc1c96653fa4f0(class, region);
        }
      }
    }
  }
}

function function_a3b6ebf2f2846ed0(var_7a6619a30fe9f174, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f) {
  function_34fc101e3004d00a("objective", var_7a6619a30fe9f174, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f);
}

function function_45eadbd1e9e2dc3b(var_7a6619a30fe9f174, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f) {
  function_34fc101e3004d00a("contract", var_7a6619a30fe9f174, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f);
}

function function_16ab635aed793576(var_7a6619a30fe9f174, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f) {
  function_34fc101e3004d00a("global", var_7a6619a30fe9f174, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f);
}

function function_427cb6a2999148d4(var_7a6619a30fe9f174, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f) {
  function_34fc101e3004d00a("activity", var_7a6619a30fe9f174, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f);
}

function function_9e6c7813519c70d2(var_7a6619a30fe9f174, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f) {
  function_34fc101e3004d00a("startup", var_7a6619a30fe9f174, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f);
}

function function_b13928c589ec4254(activityclass, activityname) {
  if(!function_e06af65b4d65ed48()) {
    return false;
  }

  return isDefined(level.var_5b7c4eafd38d35c.var_440d9c34db4e31c6[activityclass][activityname]);
}

function private function_34fc101e3004d00a(activityclass, var_7a6619a30fe9f174, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f) {
  if(!function_e06af65b4d65ed48()) {
    return;
  }

  if(!function_672ba119dd1f340b(activityclass)) {
    return;
  }

  activityinfo = function_bf8944ef44d7665d(var_7a6619a30fe9f174);

  switch (activityclass) {
    case #"hash_15b9dadf23855b18":
      function_4d6dac99a67dedd6(activityinfo.name, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f);
      break;
    case #"hash_2103aa2d1f280263":
      function_3e8da9e83064cf45(activityinfo.name, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f);
      break;
    case #"hash_ee9e2bde0e1c8f4c":
      function_dd08f7bbc7374382(activityinfo.name, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f);
      break;
    case #"hash_db12a76bc451230e":
      function_950b6b34320b4740(activityinfo.name, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f);
      break;
    case #"hash_5d34f36bda34d78a":
      function_4d5f2ad6e3e7fa3c(activityinfo.name, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f);
      break;
    default:
      assertmsg("<dev string:x67>" + activityclass + "<dev string:x9e>");
      return;
  }

  definition = level.var_5b7c4eafd38d35c.var_440d9c34db4e31c6[activityclass][activityinfo.name];
  definition.var_56afeaf9e971a742[definition.var_56afeaf9e971a742.size] = activityinfo.mainfunction;
  definition.var_fbb3826d104f8cfa[definition.var_fbb3826d104f8cfa.size] = activityinfo.var_6e7eb28b2997b5b4;
  definition.var_ae8e50faf55f2356[definition.var_ae8e50faf55f2356.size] = activityinfo.metadatafunction;

  if(isDefined(activityinfo.scriptbundle)) {
    customproperties = getscriptbundlefieldvalue("activitydefinition:" + activityinfo.scriptbundle, #"customproperties");

    if(isDefined(customproperties) && isDefined(customproperties.activitytypegroup) && customproperties.activitytypegroup.size > 0) {
      definition.var_24cab756258ffc20 = customproperties.activitytypegroup[0].variant_object.var_24cab756258ffc20;
    }
  }

  function_6cada256b1ccc701(activityclass, activityinfo.name);
}

function function_4d6dac99a67dedd6(var_25aa6146673bf134, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f) {
  function_d7f0ba8d6c684faa("objective", var_25aa6146673bf134, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f);
}

function function_3e8da9e83064cf45(var_25aa6146673bf134, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f) {
  function_d7f0ba8d6c684faa("contract", var_25aa6146673bf134, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f);
}

function function_950b6b34320b4740(var_25aa6146673bf134, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f) {
  function_d7f0ba8d6c684faa("global", var_25aa6146673bf134, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f);
}

function function_dd08f7bbc7374382(var_25aa6146673bf134, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f) {
  function_d7f0ba8d6c684faa("activity", var_25aa6146673bf134, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f);
}

function function_4d5f2ad6e3e7fa3c(var_25aa6146673bf134, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f) {
  function_d7f0ba8d6c684faa("startup", var_25aa6146673bf134, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f);
}

function private function_e768d504ba4cdcf8(dvarbase, activityclass, region) {
  return hashcat(dvarbase, "__" + activityclass + "__" + region);
}

function private function_8297ac58da06a3d8(dvarbase, activityclass, region, defaultvalue) {
  value = undefined;
  regiondvar = undefined;

  if(isDefined(region)) {
    regiondvar = function_e768d504ba4cdcf8(dvarbase, activityclass, region);
  }

  if(isDefined(regiondvar) && isdvardefined(regiondvar)) {
    value = getdvarfloat(regiondvar);
  } else {
    value = function_1b47ccaf25ca8af6(dvarbase, activityclass, defaultvalue);
  }

  return value;
}

function private function_cd752a1884d6a9f3(dvarbase, activityclass, region, defaultvalue) {
  value = undefined;
  regiondvar = undefined;

  if(isDefined(region)) {
    regiondvar = function_e768d504ba4cdcf8(dvarbase, activityclass, region);
  }

  if(isDefined(regiondvar) && isdvardefined(regiondvar)) {
    value = getdvarint(regiondvar);
  } else {
    value = function_2a4dbeaf064ede7d(dvarbase, activityclass, defaultvalue);
  }

  return value;
}

function private function_7172c55bf7552eef(dvarbase, activityclass) {
  return hashcat(dvarbase, "__" + activityclass);
}

function private function_4bd63b2a541a59ab(activityclass) {
  var_54a31331d144fa6f = function_2a4dbeaf064ede7d(@ "hash_79d920728fc09a25", activityclass, 6);
  return var_54a31331d144fa6f;
}

function private function_5bd6b6fa1f46dc2(activityclass, region) {
  var_daac4c9f210d9010 = function_cd752a1884d6a9f3(@ "hash_7ee06cb015cf2d8", activityclass, region, 3);
  return var_daac4c9f210d9010;
}

function private function_37b214a3b7aafcf(activityclass, regiondifficulty) {
  assert(regiondifficulty == "<dev string:xa4>" || regiondifficulty == "<dev string:xb7>" || regiondifficulty == "<dev string:xcc>" || regiondifficulty == "<dev string:xdf>");
  maxactivities = 2147483646;

  switch (regiondifficulty) {
    case #"hash_7bb2cd766703d463":
      maxactivities = function_2a4dbeaf064ede7d(@ "hash_7205a8d2fa8a13fa", activityclass, 100);
      break;
    case #"hash_af83e47edfa8900a":
      maxactivities = function_2a4dbeaf064ede7d(@ "hash_df5f2e2818b47dbf", activityclass, 100);
      break;
    case #"hash_5343b465e56ec9a4":
      maxactivities = function_2a4dbeaf064ede7d(@ "hash_d1954cda398ebe31", activityclass, 100);
      break;
    case #"hash_651f76c0ad6741ec":
      maxactivities = function_2a4dbeaf064ede7d(@ "hash_1c179ab570055896", activityclass, 100);
      break;
    case #"hash_a1e09f51896088fb":
    default:
      break;
  }

  return maxactivities;
}

function private function_1b47ccaf25ca8af6(dvarbase, activityclass, defaultvalue) {
  value = undefined;
  classdvar = function_7172c55bf7552eef(dvarbase, activityclass);

  if(isdvardefined(classdvar)) {
    value = getdvarfloat(classdvar);
  } else {
    value = getdvarfloat(dvarbase, defaultvalue);
  }

  return value;
}

function private function_2a4dbeaf064ede7d(dvarbase, activityclass, defaultvalue) {
  value = undefined;
  classdvar = function_7172c55bf7552eef(dvarbase, activityclass);

  if(isdvardefined(classdvar)) {
    value = getdvarint(classdvar);
  } else {
    value = getdvarint(dvarbase, defaultvalue);
  }

  return value;
}

function private function_d7f0ba8d6c684faa(activityclass, var_25aa6146673bf134, initfunction, startfunction, stopfunction, var_3d0f9e8cbbd7aa6f) {
  if(!function_e06af65b4d65ed48()) {
    return;
  }

  if(!function_672ba119dd1f340b(activityclass)) {
    return;
  }

  if(isDefined(initfunction) && !isfunction(initfunction)) {
    assertmsg("<dev string:xf8>" + var_25aa6146673bf134 + "<dev string:x10b>");
    return;
  }

  if(isDefined(stopfunction) && !isfunction(stopfunction)) {
    assertmsg("<dev string:xf8>" + var_25aa6146673bf134 + "<dev string:x13f>");
    return;
  }

  if(isDefined(var_3d0f9e8cbbd7aa6f) && !isfunction(var_3d0f9e8cbbd7aa6f)) {
    assertmsg("<dev string:xf8>" + var_25aa6146673bf134 + "<dev string:x169>");
    return;
  }

  if(isDefined(level.var_5b7c4eafd38d35c.var_440d9c34db4e31c6[activityclass][var_25aa6146673bf134])) {
    assertmsg("<dev string:xf8>" + var_25aa6146673bf134 + "<dev string:x199>");
    return;
  }

  definition = spawnStruct();
  definition.initfunction = initfunction;
  definition.startfunction = startfunction;
  definition.var_3d0f9e8cbbd7aa6f = var_3d0f9e8cbbd7aa6f;
  definition.lasttimeselected = -1;
  definition.var_56afeaf9e971a742 = [];
  definition.var_fbb3826d104f8cfa = [];
  definition.var_ae8e50faf55f2356 = [];
  level.var_5b7c4eafd38d35c.var_440d9c34db4e31c6[activityclass][var_25aa6146673bf134] = definition;

  function_c5fe5d9ce72fa0bc(activityclass, var_25aa6146673bf134);
}

function function_28ac67fd6f2cfa07(var_7a6619a30fe9f174) {
  function_2ef33d9d5bc5b9c("objective", var_7a6619a30fe9f174);
}

function function_3684f1c1e8a961f8(var_7a6619a30fe9f174) {
  function_2ef33d9d5bc5b9c("contract", var_7a6619a30fe9f174);
}

function function_9d145151be8c6b2d(var_7a6619a30fe9f174) {
  function_2ef33d9d5bc5b9c("global", var_7a6619a30fe9f174);
}

function function_b000c5869d9963b(var_7a6619a30fe9f174) {
  function_2ef33d9d5bc5b9c("activity", var_7a6619a30fe9f174);
}

function function_e0817a8472617b61(var_7a6619a30fe9f174) {
  function_2ef33d9d5bc5b9c("startup", var_7a6619a30fe9f174);
}

function private function_2ef33d9d5bc5b9c(activityclass, var_7a6619a30fe9f174) {
  if(!function_e06af65b4d65ed48()) {
    return;
  }

  if(!function_672ba119dd1f340b(activityclass)) {
    return;
  }

  activityinfo = function_bf8944ef44d7665d(var_7a6619a30fe9f174);
  definition = level.var_5b7c4eafd38d35c.var_440d9c34db4e31c6[activityclass][activityinfo.name];

  if(!isDefined(definition)) {
    function_34fc101e3004d00a(activityclass, var_7a6619a30fe9f174);
    return;
  }

  definition.var_56afeaf9e971a742[definition.var_56afeaf9e971a742.size] = activityinfo.mainfunction;
  definition.var_fbb3826d104f8cfa[definition.var_fbb3826d104f8cfa.size] = activityinfo.var_6e7eb28b2997b5b4;
  definition.var_ae8e50faf55f2356[definition.var_ae8e50faf55f2356.size] = activityinfo.metadatafunction;

  if(isDefined(activityinfo.mainfunction) && isfunction(activityinfo.mainfunction)) {
    [[activityinfo.mainfunction]]();
  }
}

function function_4846ba8883b7839a(activitytypename, var_3015d9ab6a011010, params, regionoverride, locationoverride, sizeoverride) {
  function_fc4f46cbb4e9184c("objective", activitytypename, var_3015d9ab6a011010, params, regionoverride, locationoverride, sizeoverride);
}

function function_7d0eeacebc6154b7(activitytypename, var_3015d9ab6a011010, params, regionoverride, locationoverride, sizeoverride) {
  function_fc4f46cbb4e9184c("contract", activitytypename, var_3015d9ab6a011010, params, regionoverride, locationoverride, sizeoverride);
}

function function_d3c3ba1486889678(activitytypename, var_3015d9ab6a011010, params, regionoverride, locationoverride, sizeoverride) {
  function_fc4f46cbb4e9184c("global", activitytypename, var_3015d9ab6a011010, params, regionoverride, locationoverride, sizeoverride);
}

function function_45e4da7d3290c92e(activitytypename, var_3015d9ab6a011010, params, regionoverride, locationoverride, sizeoverride) {
  function_fc4f46cbb4e9184c("activity", activitytypename, var_3015d9ab6a011010, params, regionoverride, locationoverride, sizeoverride);
}

function function_845c6bd78f5ef04(activitytypename, var_3015d9ab6a011010, params, regionoverride, locationoverride, sizeoverride) {
  function_fc4f46cbb4e9184c("startup", activitytypename, var_3015d9ab6a011010, params, regionoverride, locationoverride, sizeoverride);
}

function function_4856bb3eba48f3a(activityclass, activitytypename, var_3015d9ab6a011010, regionoverride, locationoverride, sizeoverride) {
  activityinstance = function_134d004a1a0667dd(activityclass, activitytypename, var_3015d9ab6a011010);
  assertex(isDefined(activityinstance), "<dev string:x1bb>" + var_3015d9ab6a011010);

  if(isDefined(locationoverride) || isDefined(sizeoverride)) {
    function_98f1af3d9898dd93(activityinstance, locationoverride, sizeoverride);
  }

  if(isDefined(regionoverride)) {
    activityinstance.region = function_b4295a2ec5bbe04d(activityinstance, regionoverride);
  }
}

function function_9485315c704e6f6d(activitytypename, location, optionaldifficulty, additionalspawndatastruct) {
  assert(isDefined(activitytypename));
  assert(isvector(location));

  if(!function_e06af65b4d65ed48()) {
    return false;
  }

  classes = function_6a64df48ad4ce4f9();
  validregions = function_a859e6c35826dace();

  if(isDefined(optionaldifficulty) && isstring(optionaldifficulty)) {
    regions = validregions;
    validregions = [];

    foreach(region in regions) {
      regiondifficulty = namespace_f721fc7d0d2d0f47::function_cf8b9cfdad89cbec(region);

      if(regiondifficulty == optionaldifficulty) {
        validregions[validregions.size] = region;
      }
    }
  }

  var_eb31c668f6a8068f = undefined;

  foreach(class in classes) {
    var_eb31c668f6a8068f = function_e50aadacdc935801(class, activitytypename, location, validregions);

    if(isDefined(var_eb31c668f6a8068f)) {
      break;
    }
  }

  if(isDefined(var_eb31c668f6a8068f)) {
    level thread function_78f9e27897742528(var_eb31c668f6a8068f, additionalspawndatastruct);
    return true;
  }

  return false;
}

function function_2458cb44e6e9a787(activitytypename, var_3015d9ab6a011010, region) {
  return function_2bd063ed5d2c8de0("<dev string:x20e>", activitytypename, var_3015d9ab6a011010, region);
}

function function_10ed50d4fedfaeec(activitytypename, var_3015d9ab6a011010, region) {
  return function_2bd063ed5d2c8de0("<dev string:x21a>", activitytypename, var_3015d9ab6a011010, region);
}

function function_c7b2752079935413(activitytypename, var_3015d9ab6a011010, region) {
  return function_2bd063ed5d2c8de0("<dev string:x226>", activitytypename, var_3015d9ab6a011010, region);
}

function private function_2bd063ed5d2c8de0(activityclass, activitytypename, var_3015d9ab6a011010, region) {
  assert(isDefined(activityclass));
  assert(isDefined(activitytypename));
  assert(isDefined(var_3015d9ab6a011010));

  if(!isDefined(region)) {
    region = "<dev string:x233>";
  }

  if(!isDefined(level.var_5b7c4eafd38d35c.activityinstances[activityclass])) {
    return 0;
  }

  if(!isDefined(level.var_5b7c4eafd38d35c.activityinstances[activityclass][region])) {
    return 0;
  }

  if(!isDefined(level.var_5b7c4eafd38d35c.activityinstances[activityclass][region][activitytypename])) {
    return 0;
  }

  activityinstances = level.var_5b7c4eafd38d35c.activityinstances[activityclass][region][activitytypename];

  if(!isDefined(activityinstances)) {
    return 0;
  }

  var_b6d95c655b8e4a0f = activityinstances[var_3015d9ab6a011010];

  if(!isDefined(var_b6d95c655b8e4a0f)) {
    return 0;
  }

  level thread function_78f9e27897742528(var_b6d95c655b8e4a0f);
  return 1;
}

function private function_fc4f46cbb4e9184c(activityclass, activitytypename, var_3015d9ab6a011010, params, regionoverride, locationoverride, sizeoverride) {
  if(!function_fd8734d232315c9d()) {
    return;
  }

  if(!function_672ba119dd1f340b(activityclass)) {
    return;
  }

  if(!isDefined(activitytypename) || !isstring(activitytypename)) {
    assertmsg("<dev string:x243>");
    return;
  }

  activityinstance = spawnStruct();
  activityinstance.class = activityclass;
  activityinstance.name = var_3015d9ab6a011010;
  activityinstance.type = activitytypename;
  activityinstance.params = params;
  activityinstance.lasttimeselected = -1;
  activityinstance.lasttimecompleted = -1;
  activityinstance.var_f2c9e94c8c1c846 = 0;
  function_98f1af3d9898dd93(activityinstance, locationoverride, sizeoverride);
  region = function_b4295a2ec5bbe04d(activityinstance, regionoverride);
  activityinstance.region = region;
  activityinstance.var_c0158bce0946adab = function_a9bc1c96653fa4f0(activityclass, region);
  activityinstances = level.var_5b7c4eafd38d35c.activityinstances[activityclass][region][activitytypename];

  if(!isDefined(activityinstances)) {
    level.var_5b7c4eafd38d35c.activityinstances[activityclass][region][activitytypename] = [];
    level.var_5b7c4eafd38d35c.runninginstances[activityclass][region][activitytypename] = [];
    activityinstances = level.var_5b7c4eafd38d35c.activityinstances[activityclass][region][activitytypename];
  }

  if(isDefined(activityinstances[var_3015d9ab6a011010])) {
    assertmsg("<dev string:x267>" + var_3015d9ab6a011010 + "<dev string:x27d>" + activitytypename + "<dev string:x9e>");
    return;
  }

  activityinstances[var_3015d9ab6a011010] = activityinstance;
  level.var_5b7c4eafd38d35c.activityinstances[activityclass][region][activitytypename] = activityinstances;
}

function function_449be28dc3149e33() {
  classes = function_6a64df48ad4ce4f9();
  classcontainer = [];

  foreach(class in classes) {
    classcontainer[class] = [];
  }

  return classcontainer;
}

function private function_f7b5e1eb9788d863() {
  regionnames = function_a859e6c35826dace();
  regioncontainer = [];

  foreach(name in regionnames) {
    regioncontainer[name] = [];
  }

  return regioncontainer;
}

function private function_edc905da95ecccc0() {
  classes = function_6a64df48ad4ce4f9();
  regionnames = function_a859e6c35826dace();
  typeregions = [];

  foreach(class in classes) {
    regions = [];

    foreach(region in regionnames) {
      regions[region] = [];
    }

    typeregions[class] = regions;
  }

  return typeregions;
}

function private function_b4295a2ec5bbe04d(activityinstance, regionoverride) {
  assert(isstruct(activityinstance));
  region = regionoverride;

  if(!isDefined(activityinstance.region) && activityinstance.origins.size > 0) {
    centroid = activityinstance.origins[0];

    for(index = 1; index < activityinstance.origins.size; index++) {
      centroid += activityinstance.origins[index];
    }

    centroid /= activityinstance.origins.size;
    region = namespace_f721fc7d0d2d0f47::get_region(centroid);
  }

  if(!isDefined(region)) {
    region = "WORLD_REGION";
  }

  return region;
}

function private function_86522828e78b7efc(activityinstance) {
  assert(isstruct(activityinstance));
  definition = level.var_5b7c4eafd38d35c.var_440d9c34db4e31c6[activityinstance.class][activityinstance.type];

  if(!isDefined(definition)) {
    assertmsg("<dev string:x2b2>" + activityinstance.type + "<dev string:x2c5>");
    return;
  }

  foreach(var_ae8e50faf55f2356 in definition.var_ae8e50faf55f2356) {
    var_d2000bf029089c7a = [[var_ae8e50faf55f2356]]();

    if(!isDefined(var_d2000bf029089c7a)) {
      continue;
    }

    if(isDefined(var_d2000bf029089c7a[activityinstance.name])) {
      return var_ae8e50faf55f2356;
    }
  }

  return undefined;
}

function private function_98f1af3d9898dd93(activityinstance, locationoverride, sizeoverride) {
  assert(isstruct(activityinstance));
  definition = level.var_5b7c4eafd38d35c.var_440d9c34db4e31c6[activityinstance.class][activityinstance.type];

  if(!isDefined(definition)) {
    assertmsg("<dev string:x2b2>" + activityinstance.type + "<dev string:x2c5>");
    return;
  }

  activityinstance.scriptbundle = undefined;
  activityinstance.resources = undefined;
  activityinstance.origins = [];
  activityinstance.radii = [];

  if(isDefined(locationoverride)) {
    if(!isvector(locationoverride)) {
      assertmsg("<dev string:x2e4>");
      return;
    }

    if(isDefined(sizeoverride) && !isnumber(sizeoverride)) {
      assertmsg("<dev string:x313>");
      return;
    }

    locationsize = sizeoverride;

    if(!isDefined(locationsize)) {
      locationsize = function_1b47ccaf25ca8af6(@ "hash_7e407689865b2b81", activityinstance.class, 1000);
    }

    activityinstance.origins[activityinstance.origins.size] = locationoverride;
    activityinstance.radii[activityinstance.radii.size] = locationsize;
    return;
  }

  foreach(var_ae8e50faf55f2356 in definition.var_ae8e50faf55f2356) {
    var_d2000bf029089c7a = [[var_ae8e50faf55f2356]]();

    if(!isDefined(var_d2000bf029089c7a)) {
      continue;
    }

    instancemetadata = var_d2000bf029089c7a[activityinstance.name];

    if(!isDefined(instancemetadata)) {
      continue;
    }

    activityinstance.scriptbundle = instancemetadata.scriptbundle;

    if(isDefined(activityinstance.scriptbundle)) {
      activityinstance.resources = getscriptbundlefieldvalue("activitydefinition:" + activityinstance.scriptbundle, #"activityresources");
      customproperties = getscriptbundlefieldvalue("activitydefinition:" + activityinstance.scriptbundle, #"customproperties");

      if(isDefined(customproperties) && isDefined(customproperties.activitytypegroup) && customproperties.activitytypegroup.size > 0) {
        activityinstance.var_24cab756258ffc20 = customproperties.activitytypegroup[0].variant_object.var_24cab756258ffc20;
      }
    }

    assert(instancemetadata.locationorigin.size == instancemetadata.locationoriginoffset.size);
    assert(instancemetadata.locationorigin.size == instancemetadata.var_45283ef87b6e04b6.size);
    assert(instancemetadata.locationorigin.size == instancemetadata.locationradius.size);
    var_4d52d9dab765759 = spawnStruct();

    for(index = 0; index < instancemetadata.locationorigin.size; index++) {
      var_4d52d9dab765759.origin = instancemetadata.locationorigin[index];
      scripts\common\create_script_utility::translate_and_rotate_from_level_overrides(instancemetadata.cf, var_4d52d9dab765759);
      activityinstance.origins[index] = instancemetadata.locationoriginoffset[index] + rotatevector(var_4d52d9dab765759.origin, instancemetadata.var_45283ef87b6e04b6[index]);
    }

    activityinstance.radii = instancemetadata.locationradius;

    if(activityinstance.origins.size <= 0) {
      var_4d52d9dab765759.origin = instancemetadata.scriptstructorigin;
      var_4d52d9dab765759.angles = (0, 0, 0);
      scripts\common\create_script_utility::translate_position_with_offset_data(instancemetadata.cf, var_4d52d9dab765759, instancemetadata.scriptstructoriginoffset, (0, 0, 0));
      activityinstance.origins[activityinstance.origins.size] = var_4d52d9dab765759.origin;
      activityinstance.radii[activityinstance.radii.size] = 1;
    }
  }
}

function private function_e7cee5294e996e3e(activityclass, activitytypename, var_3015d9ab6a011010) {
  regions = function_a859e6c35826dace();
  region = undefined;

  foreach(region in regions) {
    if(!isDefined(level.var_5b7c4eafd38d35c.activityinstances[activityclass])) {
      continue;
    }

    if(!isDefined(level.var_5b7c4eafd38d35c.activityinstances[activityclass][region])) {
      continue;
    }

    if(!isDefined(level.var_5b7c4eafd38d35c.activityinstances[activityclass][region][activitytypename])) {
      continue;
    }

    runninginstance = level.var_5b7c4eafd38d35c.activityinstances[activityclass][region][activitytypename][var_3015d9ab6a011010];

    if(isDefined(runninginstance)) {
      return region;
    }
  }
}

function private function_f4b7a7345d5dda8e(activityclass, activitytypename, var_3015d9ab6a011010) {
  regions = function_a859e6c35826dace();
  region = undefined;

  foreach(region in regions) {
    if(!isDefined(level.var_5b7c4eafd38d35c.runninginstances[activityclass])) {
      continue;
    }

    if(!isDefined(level.var_5b7c4eafd38d35c.runninginstances[activityclass][region])) {
      continue;
    }

    if(!isDefined(level.var_5b7c4eafd38d35c.runninginstances[activityclass][region][activitytypename])) {
      continue;
    }

    runninginstance = level.var_5b7c4eafd38d35c.runninginstances[activityclass][region][activitytypename][var_3015d9ab6a011010];

    if(isDefined(runninginstance)) {
      return region;
    }
  }
}

function function_ef92878cd2be9387(activityclass, activitytypename, var_3015d9ab6a011010) {
  if(!function_672ba119dd1f340b(activityclass)) {
    return;
  }

  regions = function_a859e6c35826dace();
  region = function_f4b7a7345d5dda8e(activityclass, activitytypename, var_3015d9ab6a011010);

  if(!isDefined(region)) {
    assertmsg("<dev string:x33e>" + var_3015d9ab6a011010 + "<dev string:x365>");
    return;
  }

  activityinstances = level.var_5b7c4eafd38d35c.runninginstances[activityclass][region][activitytypename];

  if(!isDefined(activityinstances) || activityinstances.size <= 0) {
    return;
  }

  var_b6d95c655b8e4a0f = activityinstances[var_3015d9ab6a011010];
  level.var_5b7c4eafd38d35c.runninginstances[activityclass][region][activitytypename] = array_remove_key(activityinstances, var_3015d9ab6a011010);
  activityinstance = level.var_5b7c4eafd38d35c.activityinstances[activityclass][region][activitytypename][var_3015d9ab6a011010];
  activityinstance.lasttimecompleted = gettime();
  activityinfo = level.var_5b7c4eafd38d35c.var_440d9c34db4e31c6[activityclass][activitytypename];
  function_fbfbbb605ff0d0f6(var_b6d95c655b8e4a0f);
  function_cf5c19fe5c042e90(activityclass, activitytypename, var_3015d9ab6a011010, activityinstance.resources);
}

function private function_a9bc1c96653fa4f0(activityclass, region) {
  var_f374daae640f6c0a = function_cd752a1884d6a9f3(@ "hash_f87b20273f0955f0", activityclass, region, 10000000);
  var_fbe8090ae22114fc = function_cd752a1884d6a9f3(@ "hash_d431c6b00b5d6b2a", activityclass, region, 10000000);

  if(var_fbe8090ae22114fc < 0) {
    assertmsg("<dev string:x386>");
    var_fbe8090ae22114fc = 0;
  }

  if(var_f374daae640f6c0a < 0) {
    var_f374daae640f6c0a = 2147483646;
  }

  if(var_f374daae640f6c0a < var_fbe8090ae22114fc) {
    var_f374daae640f6c0a = var_fbe8090ae22114fc;
  }

  return randomintrange(var_fbe8090ae22114fc, var_f374daae640f6c0a + 1);
}

function private function_672ba119dd1f340b(activityclass) {
  if(!isDefined(activityclass)) {
    assertmsg("<dev string:x3b7>");
    return false;
  }

  var_a165f6980e3e577 = function_6a64df48ad4ce4f9();

  foreach(supportedclass in var_a165f6980e3e577) {
    if(activityclass == supportedclass) {
      return true;
    }
  }

  assertmsg("<dev string:x3d7>" + activityclass + "<dev string:x3eb>");
  return false;
}

function private function_bf8944ef44d7665d(var_7a6619a30fe9f174) {
  if(!isfunction(var_7a6619a30fe9f174)) {
    assertmsg("<dev string:x41a>");
    return;
  }

  activityinfo = [[var_7a6619a30fe9f174]]();

  if(!isDefined(activityinfo)) {
    assertmsg("<dev string:x465>");
    return;
  }

  if(!isDefined(activityinfo.name)) {
    assertmsg("<dev string:x4a9>");
    return;
  }

  return activityinfo;
}

function private function_e06af65b4d65ed48() {
  if(!function_fd8734d232315c9d()) {
    return false;
  }

  if(!isDefined(level.var_5b7c4eafd38d35c)) {
    assertmsg("<dev string:x4de>");
    return false;
  }

  return true;
}

function private function_6cada256b1ccc701(activityclass, activitytypename) {
  definition = level.var_5b7c4eafd38d35c.var_440d9c34db4e31c6[activityclass][activitytypename];

  if(!isDefined(definition)) {
    assertmsg("<dev string:xf8>" + activitytypename + "<dev string:x50a>");
    return;
  }

  foreach(mainfunction in definition.var_56afeaf9e971a742) {
    [[mainfunction]]();
  }
}

function private function_9122969ed0435ccf() {
  instanceinfo = spawnStruct();
  instanceinfo.starttime = gettime();
  return instanceinfo;
}

function function_fa5136406f67c5a5(var_b6d95c655b8e4a0f, additionalspawndatastruct) {
  return function_78f9e27897742528(var_b6d95c655b8e4a0f, additionalspawndatastruct);
}

function private function_78f9e27897742528(var_b6d95c655b8e4a0f, additionalspawndatastruct) {
  assert(isstruct(var_b6d95c655b8e4a0f));
  activityclass = var_b6d95c655b8e4a0f.class;
  activitytype = var_b6d95c655b8e4a0f.type;
  activityname = var_b6d95c655b8e4a0f.name;
  activityregion = var_b6d95c655b8e4a0f.region;

  if(isDefined(level.var_5b7c4eafd38d35c.runninginstances[activityclass][activityregion][activitytype]) && isDefined(level.var_5b7c4eafd38d35c.runninginstances[activityclass][activityregion][activitytype][activityname])) {
    return undefined;
  }

  activityinfo = level.var_5b7c4eafd38d35c.var_440d9c34db4e31c6[activityclass][activitytype];
  level.var_5b7c4eafd38d35c.var_440d9c34db4e31c6[activityclass][activitytype].lasttimeselected = gettime();
  activityinstance = level.var_5b7c4eafd38d35c.activityinstances[activityclass][activityregion][activitytype][activityname];

  if(activityinstance.lasttimeselected < 0 && activityinfo.var_fbb3826d104f8cfa.size > 0) {
    struct = spawnStruct();
    createscriptid = scripts\common\create_script_utility::function_b055d49370405173();

    foreach(var_fbb3826d104f8cfa in activityinfo.var_fbb3826d104f8cfa) {
      level[[var_fbb3826d104f8cfa]](activityname, struct, createscriptid);
    }
  }

  activityinstance.lasttimeselected = gettime();
  activityinstance.var_f2c9e94c8c1c846++;
  level.var_5b7c4eafd38d35c.runninginstances[activityclass][activityregion][activitytype][activityname] = function_9122969ed0435ccf();

  if(isDefined(activityinfo.startfunction)) {
    var_fb6a27936e71b3eb = function_86522828e78b7efc(activityinstance);
    params = var_b6d95c655b8e4a0f.params;
    assert(params.size == 3);

    if(isDefined(additionalspawndatastruct)) {
      params[params.size] = additionalspawndatastruct;
    }

    activityinstance = [[activityinfo.startfunction]](var_fb6a27936e71b3eb, params);
  }

  function_1f896f1cc450fd5f(activityclass, activitytype, activityname, var_b6d95c655b8e4a0f.resources);
  return activityinstance;
}

function private function_6f5b23575803d640(activityclass) {
  isenabled = function_2a4dbeaf064ede7d(@ "hash_f599645d1543dcbe", activityclass, 1);
  return isenabled;
}

function private function_9c1a256762340be5(activityclass, activityregion) {
  var_e6bfc8dd16739560 = [];
  regionnames = function_a859e6c35826dace();
  regiondifficulty = namespace_f721fc7d0d2d0f47::function_cf8b9cfdad89cbec(activityregion);
  var_be478e6dfc4efa36 = [];

  foreach(region in regionnames) {
    var_2e0e0e6bb92bb3bc = namespace_f721fc7d0d2d0f47::function_cf8b9cfdad89cbec(region);
    var_be478e6dfc4efa36[region] = var_2e0e0e6bb92bb3bc;
  }

  foreach(activitytype, activityinstances in level.var_5b7c4eafd38d35c.activityinstances[activityclass][activityregion]) {
    if(activityinstances.size <= 0) {
      continue;
    }

    var_a1c2c69510a7b870 = level.var_5b7c4eafd38d35c.activityinstances[activityclass][activityregion][activitytype];

    if(!isDefined(var_a1c2c69510a7b870)) {
      continue;
    }

    if(level.var_5b7c4eafd38d35c.runninginstances[activityclass][activityregion][activitytype].size == var_a1c2c69510a7b870.size) {
      continue;
    }

    instancekey = getarraykey(var_a1c2c69510a7b870, 0);
    instanceinfo = var_a1c2c69510a7b870[instancekey];

    if(isDefined(instanceinfo.var_24cab756258ffc20)) {
      var_10d8a792476762f2 = isDefined(instanceinfo.var_24cab756258ffc20.var_10d8a792476762f2) ? instanceinfo.var_24cab756258ffc20.var_10d8a792476762f2 : 0;
      var_68c70e12284f609 = utility::function_c89ed1840c8d0f0f(gettime());

      if(var_10d8a792476762f2 > 0 && var_10d8a792476762f2 > var_68c70e12284f609) {
        continue;
      }
    }

    waitframe();
    profilebeginevent(hashcat(#"hash_ade086aad3f7603f", activityclass, ")"));
    var_74e6cad72ee6900c = int(getDvar(hashcat(@ "hash_c34a7721a96faf72", activitytype), "-1234"));

    if(var_74e6cad72ee6900c == -1234) {
      var_74e6cad72ee6900c = undefined;
    }

    if(isDefined(instanceinfo.var_24cab756258ffc20) || isDefined(var_74e6cad72ee6900c)) {
      var_adc16068f51004c9 = var_74e6cad72ee6900c;

      if(!isDefined(var_adc16068f51004c9)) {
        var_adc16068f51004c9 = isDefined(instanceinfo.var_24cab756258ffc20.var_adc16068f51004c9) ? instanceinfo.var_24cab756258ffc20.var_adc16068f51004c9 : 0;
      }

      if(var_adc16068f51004c9 == 0) {
        profileendevent();
        continue;
      }

      var_efa56b8e81f81f80 = 0;

      foreach(testregion in regionnames) {
        runninginstances = level.var_5b7c4eafd38d35c.runninginstances[activityclass][testregion][activitytype];

        if(isDefined(runninginstances)) {
          var_efa56b8e81f81f80 += runninginstances.size;
        }
      }

      if(var_efa56b8e81f81f80 >= var_adc16068f51004c9) {
        profileendevent();
        continue;
      }
    }

    profileendevent();
    waitframe();
    profilebeginevent(hashcat(#"hash_7ef08f8073c8dc51", activityclass, ")"));

    if(isDefined(instanceinfo.var_24cab756258ffc20)) {
      var_a41484042d9f9c03 = 0;

      switch (regiondifficulty) {
        case #"hash_7bb2cd766703d463":
          var_a41484042d9f9c03 = isDefined(instanceinfo.var_24cab756258ffc20.var_f76440a7a517d5e1) ? instanceinfo.var_24cab756258ffc20.var_f76440a7a517d5e1 : 0;
          break;
        case #"hash_af83e47edfa8900a":
          var_a41484042d9f9c03 = isDefined(instanceinfo.var_24cab756258ffc20.var_ad415994f8661932) ? instanceinfo.var_24cab756258ffc20.var_ad415994f8661932 : 0;
          break;
        case #"hash_5343b465e56ec9a4":
          var_a41484042d9f9c03 = isDefined(instanceinfo.var_24cab756258ffc20.var_a223827e4f31d95c) ? instanceinfo.var_24cab756258ffc20.var_a223827e4f31d95c : 0;
          break;
        case #"hash_651f76c0ad6741ec":
          var_a41484042d9f9c03 = isDefined(instanceinfo.var_24cab756258ffc20.var_48cfd8c43e46be7d) ? instanceinfo.var_24cab756258ffc20.var_48cfd8c43e46be7d : 0;
          break;
        default:
          var_a41484042d9f9c03 = 2147483647;
          break;
      }

      if(var_a41484042d9f9c03 == 0) {
        profileendevent();
        continue;
      }

      var_efa56b8e81f81f80 = 0;

      foreach(testregion in regionnames) {
        if(var_be478e6dfc4efa36[testregion] != regiondifficulty) {
          continue;
        }

        runninginstances = level.var_5b7c4eafd38d35c.runninginstances[activityclass][testregion][activitytype];

        if(isDefined(runninginstances)) {
          var_efa56b8e81f81f80 += runninginstances.size;
        }
      }

      if(var_efa56b8e81f81f80 >= var_a41484042d9f9c03) {
        profileendevent();
        continue;
      }
    }

    profileendevent();
    waitframe();
    var_e6bfc8dd16739560[var_e6bfc8dd16739560.size] = activitytype;
  }

  if(var_e6bfc8dd16739560.size <= 0) {
    return;
  }

  return array_randomize(var_e6bfc8dd16739560);
}

function private function_134d004a1a0667dd(activityclass, activitytypename, var_3015d9ab6a011010) {
  regions = function_a859e6c35826dace();

  foreach(region in regions) {
    if(!isDefined(level.var_5b7c4eafd38d35c.activityinstances[activityclass])) {
      continue;
    }

    if(!isDefined(level.var_5b7c4eafd38d35c.activityinstances[activityclass][region])) {
      continue;
    }

    if(!isDefined(level.var_5b7c4eafd38d35c.activityinstances[activityclass][region][activitytypename])) {
      continue;
    }

    activityinstance = level.var_5b7c4eafd38d35c.activityinstances[activityclass][region][activitytypename][var_3015d9ab6a011010];

    if(isDefined(activityinstance)) {
      return activityinstance;
    }
  }
}

function private function_a859e6c35826dace() {
  regionnames = namespace_f721fc7d0d2d0f47::get_regions();

  if(!isDefined(regionnames)) {
    regionnames = [];
  }

  regionnames[regionnames.size] = "WORLD_REGION";
  return regionnames;
}

function private function_ce9c1c2112ae2200(activityclass, region) {
  if(!isDefined(level.var_5b7c4eafd38d35c.runninginstances[activityclass][region])) {
    return 0;
  }

  runningcount = 0;

  foreach(var_a1c2c69510a7b870 in level.var_5b7c4eafd38d35c.runninginstances[activityclass][region]) {
    runningcount += var_a1c2c69510a7b870.size;
  }

  return runningcount;
}

function private function_5e9dbe35cb8eb352(activityclass, regionnames) {
  var_568b02cf1c9933b4 = [];
  var_9d1a2089c281f69e = [];
  maxcount = 0;

  foreach(region in regionnames) {
    var_7d0882489e1ab140 = level.var_5b7c4eafd38d35c.runninginstances[activityclass][region];
    activitycount = 0;

    foreach(activityinstances in var_7d0882489e1ab140) {
      activitycount += activityinstances.size;
    }

    regionlist = var_9d1a2089c281f69e[activitycount];

    if(!isDefined(regionlist)) {
      regionlist = [];
    }

    regionlist[regionlist.size] = region;
    var_9d1a2089c281f69e[activitycount] = regionlist;

    if(activitycount > maxcount) {
      maxcount = activitycount;
    }
  }

  for(index = 0; index <= maxcount; index++) {
    var_eaaf40909c02acd8 = var_9d1a2089c281f69e[index];

    if(!isDefined(var_eaaf40909c02acd8)) {
      continue;
    }

    var_eaaf40909c02acd8 = array_randomize(var_eaaf40909c02acd8);

    foreach(region in var_eaaf40909c02acd8) {
      var_568b02cf1c9933b4[var_568b02cf1c9933b4.size] = region;
    }
  }

  return var_568b02cf1c9933b4;
}

function function_4a4911b696acc29c(activityclass) {
  return function_ee72aa84383aa927(activityclass);
}

function private function_ee72aa84383aa927(activityclass) {
  regionnames = function_a859e6c35826dace();
  var_d45d42abdcefe5f4 = function_6a64df48ad4ce4f9();
  regionspread = function_2a4dbeaf064ede7d(@ "hash_ae5eaee208c0e4ed", activityclass, 0);

  if(regionspread > 0) {
    regionnames = function_5e9dbe35cb8eb352(activityclass, regionnames);
  } else {
    regionnames = array_randomize(regionnames);
  }

  var_196ff61200360658 = [];
  var_196ff61200360658["difficulty_easy"] = 0;
  var_196ff61200360658["difficulty_normal"] = 0;
  var_196ff61200360658["difficulty_hard"] = 0;
  var_196ff61200360658["difficulty_darkaether"] = 0;
  var_be478e6dfc4efa36 = [];

  foreach(region in regionnames) {
    regiondifficulty = namespace_f721fc7d0d2d0f47::function_cf8b9cfdad89cbec(region);
    var_be478e6dfc4efa36[region] = regiondifficulty;

    if(!isDefined(var_196ff61200360658[regiondifficulty])) {
      continue;
    }

    var_5fffc9758bb02db4 = function_ce9c1c2112ae2200(activityclass, region);
    var_196ff61200360658[regiondifficulty] += var_5fffc9758bb02db4;
  }

  waitframe();

  foreach(region in regionnames) {
    regiondifficulty = namespace_f721fc7d0d2d0f47::function_cf8b9cfdad89cbec(region);

    if(regiondifficulty != "difficulty_undefined") {
      var_2bfe175508eba086 = function_37b214a3b7aafcf(activityclass, regiondifficulty);

      if(isDefined(var_196ff61200360658[regiondifficulty]) && var_196ff61200360658[regiondifficulty] >= var_2bfe175508eba086) {
        continue;
      }
    }

    waitframe();
    var_daac4c9f210d9010 = function_5bd6b6fa1f46dc2(activityclass, region);

    if(var_daac4c9f210d9010 <= 0) {
      continue;
    }

    var_5fffc9758bb02db4 = function_ce9c1c2112ae2200(activityclass, region);

    if(var_5fffc9758bb02db4 >= var_daac4c9f210d9010) {
      continue;
    }

    waitframe();
    activitytypes = function_9c1a256762340be5(activityclass, region);

    if(!isDefined(activitytypes)) {
      continue;
    }

    foreach(activitytype in activitytypes) {
      instances = level.var_5b7c4eafd38d35c.activityinstances[activityclass][region][activitytype];
      instances = array_randomize_objects(instances);

      if(instances.size <= 0) {
        continue;
      }

      validinstances = instances;
      instancekey = undefined;
      runninginstances = level.var_5b7c4eafd38d35c.runninginstances[activityclass][region][activitytype];
      testinstances = validinstances;
      validinstances = [];
      enableddefault = function_6f5b23575803d640(activityclass);
      var_79a69d3b2771dbfa = int(getDvar(hashcat(@ "hash_862d7d5538370d45", activitytype), "-1234"));

      foreach(instancekey, instance in testinstances) {
        instancedvarvalue = int(getDvar(hashcat(@ "hash_b17313d000a837eb", instancekey), "-1234"));

        if(instancedvarvalue != -1234) {
          if(instancedvarvalue != 0) {
            validinstances[instancekey] = instance;
          }

          continue;
        }

        if(var_79a69d3b2771dbfa != -1234) {
          if(var_79a69d3b2771dbfa != 0) {
            validinstances[instancekey] = instance;
          }

          continue;
        }

        if(enableddefault) {
          validinstances[instancekey] = instance;
        }
      }

      waitframe();
      profilebeginevent(hashcat(#"hash_ba7a02ac7eb32001", activityclass, ")"));

      if(validinstances.size > 0 && isDefined(runninginstances) && runninginstances.size > 0) {
        testinstances = validinstances;
        validinstances = [];
        instancekeys = getarraykeys(testinstances);

        for(index = 0; index < testinstances.size; index++) {
          instancekey = instancekeys[index];

          if(isDefined(runninginstances[instancekey])) {
            continue;
          }

          validinstances[instancekey] = testinstances[instancekey];
        }
      }

      profileendevent();
      waitframe();
      profilebeginevent(hashcat(#"hash_c7a3cdcb935f44c5", activityclass, ")"));

      if(validinstances.size > 0) {
        testinstances = validinstances;
        validinstances = [];
        var_31a64f8e98ef161e = function_2a4dbeaf064ede7d(@ "hash_66a45e1fc2707d68", activityclass, 120);
        var_fb95b3a87e91d735 = function_a5b14435e3229bed(var_31a64f8e98ef161e);
        time = gettime();

        foreach(instancekey, instance in testinstances) {
          if(instance.lasttimecompleted > 0 && instance.lasttimecompleted + var_fb95b3a87e91d735 >= time) {
            continue;
          }

          validinstances[instancekey] = instance;
        }
      }

      profileendevent();
      profilebeginevent(hashcat(#"hash_aec19b65da5d5aea", activityclass, ")"));

      if(validinstances.size > 0) {
        testinstances = validinstances;
        validinstances = [];

        foreach(instancekey, instance in testinstances) {
          if(instance.var_f2c9e94c8c1c846 >= instance.var_c0158bce0946adab) {
            continue;
          }

          validinstances[instancekey] = instance;
        }
      }

      profileendevent();
      profilebeginevent(hashcat(#"hash_e658aa7d1f1f9540", activityclass, ")"));

      if(validinstances.size > 0) {
        testinstances = validinstances;
        validinstances = [];

        foreach(instancekey, instance in testinstances) {
          instanceinfo = level.var_5b7c4eafd38d35c.activityinstances[activityclass][region][activitytype][instancekey];

          if(function_756b62f54a8121ff(activityclass, activitytype, instancekey, instanceinfo.resources)) {
            validinstances[instancekey] = instance;
          }
        }
      }

      profileendevent();
      waitframe();
      profilebeginevent(hashcat(#"hash_b7464bfa4c68fee0", activityclass, ")"));

      if(validinstances.size > 0 && isDefined(runninginstances) && runninginstances.size > 0) {
        var_97dc2a287cc91ce4 = function_2a4dbeaf064ede7d(@ "hash_9a1268e639489626", activityclass, 1);

        if(var_97dc2a287cc91ce4 > 0) {
          testinstances = validinstances;
          validinstances = [];
          regioninstances = [];

          foreach(var_fc3502c3e30b9ee8, runninginstance in runninginstances) {
            var_b8ae05752fde29d7 = level.var_5b7c4eafd38d35c.activityinstances[activityclass][region][activitytype][var_fc3502c3e30b9ee8];

            if(!isDefined(regioninstances[var_b8ae05752fde29d7.region])) {
              regioninstances[var_b8ae05752fde29d7.region] = 1;
              continue;
            }

            regioninstances[var_b8ae05752fde29d7.region]++;
          }

          foreach(instancekey, instance in testinstances) {
            if(instance.region != "WORLD_REGION" && isDefined(regioninstances[instance.region]) && regioninstances[instance.region] >= var_97dc2a287cc91ce4) {
              continue;
            }

            validinstances[instancekey] = instance;
          }
        }
      }

      profileendevent();
      waitframe();
      profilebeginevent(hashcat(#"hash_7e2663a2e09c7f10", activityclass, ")"));

      if(validinstances.size > 0) {
        testinstances = validinstances;
        validinstances = [];
        var_1ea87c3bbdc2eae4 = function_1b47ccaf25ca8af6(@ "hash_af678d6174008e62", activityclass, 0);

        if(var_1ea87c3bbdc2eae4 <= 0) {
          validinstances = testinstances;
        } else {
          testplayers = [];

          foreach(player in level.players) {
            if(isDefined(player) && isDefined(player.origin) && isDefined(player.team) && isalive(player)) {
              testplayers[testplayers.size] = player;
            }
          }

          foreach(var_98146ac89d663215, testinstance in testinstances) {
            var_6bc4286e8f399586 = level.var_5b7c4eafd38d35c.activityinstances[activityclass][region][activitytype][var_98146ac89d663215];

            if(var_6bc4286e8f399586.origins.size <= 0) {
              validinstances[var_98146ac89d663215] = testinstance;
              continue;
            }

            instanceisvalid = 1;

            foreach(player in testplayers) {
              if(!instanceisvalid) {
                break;
              }

              for(var_34ec8adfcc383b3d = 0; var_34ec8adfcc383b3d < var_6bc4286e8f399586.origins.size && instanceisvalid; var_34ec8adfcc383b3d++) {
                testorigin = var_6bc4286e8f399586.origins[var_34ec8adfcc383b3d];
                testradius = var_6bc4286e8f399586.radii[var_34ec8adfcc383b3d];
                distancesquared = distance2dsquared(player.origin, testorigin);
                testdistancesquared = squared(max(testradius + var_1ea87c3bbdc2eae4, 0));
                instanceisvalid = distancesquared > testdistancesquared;
              }
            }

            if(instanceisvalid) {
              validinstances[var_98146ac89d663215] = testinstance;
            }
          }
        }
      }

      profileendevent();
      waitframe();

      if(validinstances.size > 0 && isDefined(level.aether_storm) && isvector(level.aether_storm.starting_origin) && isDefined(level.aether_storm.starting_radius)) {
        testinstances = validinstances;
        validinstances = [];
        profilebeginevent(hashcat(#"hash_20f7c64afdf021eb", activityclass, ")"));

        foreach(var_98146ac89d663215, testinstance in testinstances) {
          var_6bc4286e8f399586 = level.var_5b7c4eafd38d35c.activityinstances[activityclass][region][activitytype][var_98146ac89d663215];

          if(var_6bc4286e8f399586.origins.size <= 0) {
            validinstances[var_98146ac89d663215] = testinstance;
            continue;
          }

          for(var_34ec8adfcc383b3d = 0; var_34ec8adfcc383b3d < var_6bc4286e8f399586.origins.size; var_34ec8adfcc383b3d++) {
            testorigin = var_6bc4286e8f399586.origins[var_34ec8adfcc383b3d];
            testradius = var_6bc4286e8f399586.radii[var_34ec8adfcc383b3d];
            distancesquared = distance2dsquared(level.aether_storm.starting_origin, testorigin);
            testdistancesquared = squared(max(testradius + level.aether_storm.starting_radius, 0));

            if(distancesquared > testdistancesquared) {
              validinstances[var_98146ac89d663215] = testinstance;
            }
          }
        }

        profileendevent();
      }

      waitframe();

      if(validinstances.size > 0) {
        testinstances = validinstances;
        validinstances = [];
        var_edfb3b0ea71a2b8e = 0;
        var_f729eca2558fcb02 = 50;
        var_430e41520b43c79b = function_a859e6c35826dace();

        foreach(var_98146ac89d663215, testinstance in testinstances) {
          profilebeginevent(hashcat(#"hash_1934350dd458aec5", activityclass, ")"));
          var_6bc4286e8f399586 = level.var_5b7c4eafd38d35c.activityinstances[activityclass][region][activitytype][var_98146ac89d663215];
          assert(var_6bc4286e8f399586.origins.size == var_6bc4286e8f399586.radii.size);

          if(var_6bc4286e8f399586.origins.size <= 0) {
            validinstances[var_98146ac89d663215] = testinstance;
            profileendevent();
            continue;
          }

          instanceisvalid = 1;

          foreach(var_b4d04d187a289710 in var_d45d42abdcefe5f4) {
            if(!instanceisvalid) {
              break;
            }

            var_d3f80f753ed44895 = function_1b47ccaf25ca8af6(@ "hash_176090f07a9fa6df", var_b4d04d187a289710, 1800);

            foreach(testregion in var_430e41520b43c79b) {
              if(!instanceisvalid) {
                break;
              }

              foreach(var_38b62d4e2d935443, var_fcdff57277d8bb78 in level.var_5b7c4eafd38d35c.runninginstances[var_b4d04d187a289710][testregion]) {
                if(!instanceisvalid) {
                  break;
                }

                if(var_b4d04d187a289710 != activityclass) {
                  definition = level.var_5b7c4eafd38d35c.var_440d9c34db4e31c6[var_b4d04d187a289710][var_38b62d4e2d935443];
                  var_1e4d24e9f76747d5 = 1;

                  if(!isDefined(definition.var_24cab756258ffc20) || !isDefined(definition.var_24cab756258ffc20.preventoverlaps) || definition.var_24cab756258ffc20.preventoverlaps == 0) {
                    var_1e4d24e9f76747d5 = 0;
                  }

                  if(isDefined(level.var_5b7c4eafd38d35c.var_5bae03c7e426693e) && isDefined(level.var_5b7c4eafd38d35c.var_5bae03c7e426693e[activityclass]) && isDefined(level.var_5b7c4eafd38d35c.var_5bae03c7e426693e[activityclass][activitytype]) && isDefined(level.var_5b7c4eafd38d35c.var_5bae03c7e426693e[activityclass][activitytype][var_b4d04d187a289710]) && isDefined(level.var_5b7c4eafd38d35c.var_5bae03c7e426693e[activityclass][activitytype][var_b4d04d187a289710][var_38b62d4e2d935443])) {
                    var_1e4d24e9f76747d5 = 1;
                  }

                  if(!var_1e4d24e9f76747d5) {
                    break;
                  }
                }

                foreach(var_fc3502c3e30b9ee8, runninginstance in var_fcdff57277d8bb78) {
                  var_edfb3b0ea71a2b8e++;
                  var_edfb3b0ea71a2b8e %= var_f729eca2558fcb02;

                  if(var_edfb3b0ea71a2b8e == 0) {
                    profileendevent();
                    waitframe();
                    profilebeginevent(hashcat(#"hash_1934350dd458aec5", activityclass, ")"));
                  }

                  if(!instanceisvalid) {
                    break;
                  }

                  var_b8ae05752fde29d7 = level.var_5b7c4eafd38d35c.activityinstances[var_b4d04d187a289710][testregion][var_38b62d4e2d935443][var_fc3502c3e30b9ee8];

                  if(var_6bc4286e8f399586.origins.size >= 0) {
                    mindistancesquared = 2147483647;
                    assert(var_b8ae05752fde29d7.origins.size == var_b8ae05752fde29d7.radii.size);

                    for(var_5f44e70a575de704 = 0; var_5f44e70a575de704 < var_b8ae05752fde29d7.origins.size && instanceisvalid; var_5f44e70a575de704++) {
                      runningorigin = var_b8ae05752fde29d7.origins[var_5f44e70a575de704];
                      runningradius = var_b8ae05752fde29d7.radii[var_5f44e70a575de704];

                      for(var_34ec8adfcc383b3d = 0; var_34ec8adfcc383b3d < var_6bc4286e8f399586.origins.size && instanceisvalid; var_34ec8adfcc383b3d++) {
                        testorigin = var_6bc4286e8f399586.origins[var_34ec8adfcc383b3d];
                        testradius = var_6bc4286e8f399586.radii[var_34ec8adfcc383b3d];
                        distancesquared = distance2dsquared(runningorigin, testorigin);
                        testdistancesquared = squared(max(runningradius + testradius + var_d3f80f753ed44895, 0));
                        instanceisvalid = distancesquared > testdistancesquared;

                        if(distancesquared < mindistancesquared) {
                          mindistancesquared = distancesquared;
                        }
                      }
                    }

                    if(instanceisvalid && isDefined(var_6bc4286e8f399586.var_24cab756258ffc20) && isDefined(var_6bc4286e8f399586.var_24cab756258ffc20.mindistinstances) && var_6bc4286e8f399586.var_24cab756258ffc20.mindistinstances > 0 && activitytype == var_38b62d4e2d935443) {
                      instanceisvalid = squared(var_6bc4286e8f399586.var_24cab756258ffc20.mindistinstances) < mindistancesquared;
                    }

                    if(instanceisvalid && isDefined(level.var_5b7c4eafd38d35c.var_5bae03c7e426693e) && isDefined(level.var_5b7c4eafd38d35c.var_5bae03c7e426693e[activityclass]) && isDefined(level.var_5b7c4eafd38d35c.var_5bae03c7e426693e[activityclass][activitytype]) && isDefined(level.var_5b7c4eafd38d35c.var_5bae03c7e426693e[activityclass][activitytype][var_b4d04d187a289710]) && isDefined(level.var_5b7c4eafd38d35c.var_5bae03c7e426693e[activityclass][activitytype][var_b4d04d187a289710][var_38b62d4e2d935443])) {
                      instanceisvalid = squared(level.var_5b7c4eafd38d35c.var_5bae03c7e426693e[activityclass][activitytype][var_b4d04d187a289710][var_38b62d4e2d935443]) < mindistancesquared;
                    }
                  }
                }
              }
            }
          }

          if(instanceisvalid) {
            validinstances[var_98146ac89d663215] = testinstance;
          }

          profileendevent();
          waitframe();
        }
      }

      waitframe();

      if(validinstances.size > 0) {
        instancenumber = randomint(validinstances.size);
        instancekey = getarraykey(validinstances, instancenumber);

        if(isDefined(instancekey)) {
          return instances[instancekey];
        }
      }
    }
  }
}

function private function_65baa0b22df8b362(activityclass) {
  profilebeginevent(hashcat(#"hash_370f42ea3295006e", activityclass, ")"));
  var_ccd2bc8536f2f0f9 = 0;
  regionnames = function_a859e6c35826dace();

  foreach(region in regionnames) {
    activitytypes = getarraykeys(level.var_5b7c4eafd38d35c.runninginstances[activityclass][region]);

    foreach(activitytype in activitytypes) {
      var_ccd2bc8536f2f0f9 += level.var_5b7c4eafd38d35c.runninginstances[activityclass][region][activitytype].size;
    }
  }

  var_cbc731913a3a26bd = function_2a4dbeaf064ede7d(@ "hash_e8e7ed44b0e01db", activityclass, -1);

  if(var_cbc731913a3a26bd < 0) {
    var_cbc731913a3a26bd = 2147483647;
  }

  var_54a31331d144fa6f = function_4bd63b2a541a59ab(activityclass);

  if(var_54a31331d144fa6f < 0) {
    profileendevent();
    return true;
  }

  if(var_cbc731913a3a26bd < var_54a31331d144fa6f) {
    assertmsg("<dev string:x51f>");
    var_cbc731913a3a26bd = var_54a31331d144fa6f;
  }

  profileendevent();
  return var_ccd2bc8536f2f0f9 < var_54a31331d144fa6f;
}

function private function_fbfbbb605ff0d0f6(var_b6d95c655b8e4a0f) {}

function private function_d61acf2f0e102259(activityclass) {
  forceall = function_2a4dbeaf064ede7d(@ "hash_1f77ee2c5138ab84", activityclass, 0);

  if(!isDefined(forceall) || forceall != 1) {
    return;
  }

  if(!isDefined(level.var_5b7c4eafd38d35c.activityinstances[activityclass])) {
    return;
  }

  regionnames = function_a859e6c35826dace();

  foreach(region in regionnames) {
    var_a1c2c69510a7b870 = level.var_5b7c4eafd38d35c.activityinstances[activityclass][region];
    activitytypes = getarraykeys(var_a1c2c69510a7b870);

    foreach(activitytype in activitytypes) {
      instances = level.var_5b7c4eafd38d35c.activityinstances[activityclass][region][activitytype];
      runninginstances = level.var_5b7c4eafd38d35c.runninginstances[activityclass][region][activitytype];

      if(instances.size == runninginstances.size) {
        continue;
      }

      foreach(instancename, instanceinfo in instances) {
        if(!isDefined(runninginstances) || !isDefined(runninginstances[instancename])) {
          return instanceinfo;
        }
      }
    }
  }
}

function private function_52281d8c5a3708e7(activityclass) {
  forcedactivity = getDvar(@ "hash_71a5c2a0d6091580", "");

  if(forcedactivity == "") {
    return;
  }

  activitytoken = strtoksubstr(forcedactivity, "__");

  if(activitytoken.size != 3) {
    if(activitytoken.size > 3) {
      iprintlnbold("<dev string:x565>");
    } else {
      iprintlnbold("<dev string:x593>");
    }

    setDvar(@ "hash_71a5c2a0d6091580", "");
    return;
  }

  var_90799b5547a5682b = activitytoken[0];
  var_96177dc32581e062 = activitytoken[1];
  var_c2f50b422162b35d = activitytoken[2];
  region = function_e7cee5294e996e3e(var_90799b5547a5682b, var_96177dc32581e062, var_c2f50b422162b35d);

  if(var_90799b5547a5682b != activityclass) {
    var_e762aa9f47a689ec = function_6a64df48ad4ce4f9();
    supportedclass = 0;

    foreach(var_b4d04d187a289710 in var_e762aa9f47a689ec) {
      if(var_90799b5547a5682b == var_b4d04d187a289710) {
        supportedclass = 1;
        break;
      }
    }

    if(!supportedclass) {
      iprintlnbold("<dev string:x5c1>" + var_90799b5547a5682b + "<dev string:x5e8>");

      setDvar(@ "hash_71a5c2a0d6091580", "");
      return;
    }
  }

  setDvar(@ "hash_71a5c2a0d6091580", "");

  if(!isDefined(level.var_5b7c4eafd38d35c.activityinstances[var_90799b5547a5682b])) {
    iprintlnbold("<dev string:x5ed>");

    return;
  }

  if(!isDefined(level.var_5b7c4eafd38d35c.activityinstances[var_90799b5547a5682b][region][var_96177dc32581e062])) {
    iprintlnbold("<dev string:x625>");

    return;
  }

  activityinstances = level.var_5b7c4eafd38d35c.activityinstances[var_90799b5547a5682b][region][var_96177dc32581e062];
  var_b6d95c655b8e4a0f = activityinstances[var_c2f50b422162b35d];

  if(!isDefined(var_b6d95c655b8e4a0f)) {
    iprintlnbold("<dev string:x656>");

    return;
  }

  return var_b6d95c655b8e4a0f;
}

function private function_c32b2819d846538a(activityclass) {
  level endon("game_ended");

  while(true) {
    wait function_2a4dbeaf064ede7d(@ "am_rate", activityclass, 10);

    if(!function_fd8734d232315c9d()) {
      continue;
    }

    var_b6d95c655b8e4a0f = function_52281d8c5a3708e7(activityclass);

    if(!isDefined(var_b6d95c655b8e4a0f)) {
      var_b6d95c655b8e4a0f = function_d61acf2f0e102259(activityclass);
    }

    waitframe();

    if(isDefined(var_b6d95c655b8e4a0f)) {
      level thread function_78f9e27897742528(var_b6d95c655b8e4a0f);
      continue;
    }

    if(!function_65baa0b22df8b362(activityclass)) {
      continue;
    }

    waitframe();
    var_b6d95c655b8e4a0f = function_ee72aa84383aa927(activityclass);
    waitframe();

    if(isDefined(var_b6d95c655b8e4a0f)) {
      level thread function_78f9e27897742528(var_b6d95c655b8e4a0f);
    }
  }
}

function private function_e50aadacdc935801(activityclass, activitytype, origin, regionoverrides) {
  if(!isvector(origin)) {
    assert(0);
    return;
  }

  if(!function_e06af65b4d65ed48()) {
    return;
  }

  closestdistancesq = undefined;
  var_b0033fbe9a9ad3ea = undefined;
  activitytypes = [];

  if(isDefined(activitytype)) {
    activitytypes[activitytypes.size] = activitytype;
  }

  regions = regionoverrides;

  if(!isDefined(regions)) {
    regions = function_a859e6c35826dace();
  }

  foreach(region in regions) {
    if(!isDefined(activitytype)) {
      activitytypes = getarraykeys(level.var_5b7c4eafd38d35c.activityinstances[activityclass][region]);

      if(!isDefined(activitytypes)) {
        continue;
      }
    }

    foreach(var_18a69c2478d56acb in activitytypes) {
      activityinstances = level.var_5b7c4eafd38d35c.activityinstances[activityclass][region][var_18a69c2478d56acb];

      if(!isDefined(activityinstances)) {
        continue;
      }

      foreach(var_3015d9ab6a011010, activityinstance in activityinstances) {
        if(isDefined(level.var_5b7c4eafd38d35c.runninginstances[activityclass]) && isDefined(level.var_5b7c4eafd38d35c.runninginstances[activityclass][region]) && isDefined(level.var_5b7c4eafd38d35c.runninginstances[activityclass][region][var_18a69c2478d56acb]) && isDefined(level.var_5b7c4eafd38d35c.runninginstances[activityclass][region][var_18a69c2478d56acb][var_3015d9ab6a011010])) {
          continue;
        }

        foreach(instanceorigin in activityinstance.origins) {
          calcdistancesq = distancesquared(origin, instanceorigin);

          if(!isDefined(closestdistancesq) || calcdistancesq < closestdistancesq) {
            closestdistancesq = calcdistancesq;
            var_b0033fbe9a9ad3ea = activityinstance;
          }
        }

        if(activityinstance.origins.size == 0 && !isDefined(var_b0033fbe9a9ad3ea)) {
          var_b0033fbe9a9ad3ea = activityinstance;
        }
      }
    }
  }

  return var_b0033fbe9a9ad3ea;
}

function private function_98c2a72b9cf77ce8() {
  wait 10;

  foreach(activityclass, var_96840e9790c685a5 in level.var_5b7c4eafd38d35c.var_440d9c34db4e31c6) {
    foreach(activitytype, var_6ac57142cec43c95 in level.var_5b7c4eafd38d35c.var_440d9c34db4e31c6[activityclass]) {
      activityinfo = level.var_5b7c4eafd38d35c.var_440d9c34db4e31c6[activityclass][activitytype];

      foreach(activityregion, var_553490b49fea5549 in level.var_5b7c4eafd38d35c.activityinstances[activityclass]) {
        if(isDefined(level.var_5b7c4eafd38d35c.activityinstances[activityclass][activityregion][activitytype])) {
          foreach(activityname, var_d37a654e73a0dc68 in level.var_5b7c4eafd38d35c.activityinstances[activityclass][activityregion][activitytype]) {
            activityinstance = level.var_5b7c4eafd38d35c.activityinstances[activityclass][activityregion][activitytype][activityname];
            function_9e186329e7622af0(activityinfo, activityinstance, activityname);
          }
        }
      }
    }
  }
}

function private function_9e186329e7622af0(activityinfo, activityinstance, activityname) {
  if(activityinfo.var_fbb3826d104f8cfa.size > 0) {
    struct = spawnStruct();
    createscriptid = scripts\common\create_script_utility::function_b055d49370405173();

    foreach(var_fbb3826d104f8cfa in activityinfo.var_fbb3826d104f8cfa) {
      iprintln("<dev string:x68b>" + activityname + "<dev string:x6ce>");
      level[[var_fbb3826d104f8cfa]](activityname, struct, createscriptid);
    }

    activityinstance.lasttimeselected = gettime();
  }
}

function private function_d330f3a028854239() {
  if(!isDefined(level.var_2d70874069468dab)) {
    assertmsg("<dev string:x6d9>");
    return;
  }

  level.var_2d70874069468dab.var_1aeea1d49e49164b = &function_e50aadacdc935801;
  level.var_2d70874069468dab.var_fe3181404203f4d7 = &function_78f9e27897742528;
  level.var_2d70874069468dab.var_fa51068d985cfd59 = &function_a859e6c35826dace;
  level.var_2d70874069468dab.var_fb1eec0d33d8dc19 = &function_5bd6b6fa1f46dc2;
  level.var_2d70874069468dab.var_c7aef763b2f3aa8 = &function_4bd63b2a541a59ab;
  level.var_2d70874069468dab.var_a19c8c0604529f78 = &function_37b214a3b7aafcf;
  level.var_2d70874069468dab.var_aa4bf0d23a33bd92 = &function_1b47ccaf25ca8af6;
}

# /