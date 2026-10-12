/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\ae_utility.gsc
***********************************************/

#using scripts\engine\utility;
#namespace ae_utility;

function init() {
  function_28026771d64f5484();
}

function private function_28026771d64f5484() {
  if(isDefined(level.var_5d0e3c105d8df7e6)) {
    return;
  }

  level.var_5d0e3c105d8df7e6 = [];
  level.var_7003d55e99a01f70 = [];
  level.var_7157035465a73c2d = [];
  level.var_dee8cd959aa57e26 = [];
  level.var_d0ef8c79b6e23661 = [];

  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0) == 1) {
    return;
  }

  if(getDvar(@ "hash_742caa13b3c2e685") == "<dev string:x1c>") {
    return;
  }

  projectscriptbundle = getprojectscriptbundle();
  var_eb8b55369eb4fd41 = getscriptbundle(hashcat(%"hash_1fa266a862bf9762", projectscriptbundle.aeeventlist));
  var_7b9e1c88d69bf5ba = getscriptbundle(hashcat(%"hash_65c0e77ca29a053d", projectscriptbundle.var_97801c7bd0f4b8e2));

  assetmissing = 0;

  if(!isDefined(var_eb8b55369eb4fd41)) {
    println("<dev string:x21>" + projectscriptbundle.aeeventlist);
    assetmissing = 1;
  }

  if(!isDefined(var_7b9e1c88d69bf5ba)) {
    println("<dev string:x4e>" + projectscriptbundle.var_97801c7bd0f4b8e2);
    assetmissing = 1;
  }

  if(assetmissing) {
    return;
  }

  eventlist = var_eb8b55369eb4fd41.eventlist;
  var_1878b2531d72df64 = var_7b9e1c88d69bf5ba.var_1878b2531d72df64;

  for(i = 0; i < eventlist.size; i++) {
    var_87db3db683ff41b3 = getscriptbundle(hashcat(%"hash_6dd4e4d4a6505f3a", eventlist[i].event));

    if(!isDefined(var_87db3db683ff41b3)) {
      println("<dev string:x7a>" + projectscriptbundle.aeeventlist + "<dev string:xb1>" + eventlist[i].event);
      continue;
    }

    if(var_87db3db683ff41b3.source == "server") {
      var_a5edf37d75183d91 = var_87db3db683ff41b3.sharedname;
      level.var_5d0e3c105d8df7e6[var_a5edf37d75183d91] = var_87db3db683ff41b3;
      keymapping = [];
      eventkeys = var_87db3db683ff41b3.keys;

      for(j = 0; j < eventkeys.size; j++) {
        var_d2de5b69db3b768c = getscriptbundle(hashcat(%"hash_683f777d2122709b", eventkeys[j].key));
        var_cb4e6cbee807f160 = var_d2de5b69db3b768c.sharedname;
        keymapping[keymapping.size] = var_cb4e6cbee807f160;

        if(!isDefined(level.var_7157035465a73c2d[var_cb4e6cbee807f160])) {
          level.var_7157035465a73c2d[var_cb4e6cbee807f160] = var_d2de5b69db3b768c;
        }

        if(isDefined(var_d2de5b69db3b768c.bitfield) && var_d2de5b69db3b768c.bitfield.size > 0) {
          level.var_dee8cd959aa57e26[var_cb4e6cbee807f160] = [];

          for(k = 0; k < var_d2de5b69db3b768c.bitfield.size; k++) {
            bitname = var_d2de5b69db3b768c.bitfield[k].sharedname;
            level.var_dee8cd959aa57e26[var_cb4e6cbee807f160][bitname] = var_d2de5b69db3b768c.bitfield[k].bitindex;
          }
        }
      }

      level.var_7003d55e99a01f70[var_a5edf37d75183d91] = keymapping;
    }
  }

  for(i = 0; i < var_1878b2531d72df64.size; i++) {
    var_1cdcaa1b699683c2 = getscriptbundle(hashcat(%"hash_56154d39395feb69", var_1878b2531d72df64[i].enum));

    if(!isDefined(var_1cdcaa1b699683c2)) {
      println("<dev string:xb7>" + projectscriptbundle.var_97801c7bd0f4b8e2 + "<dev string:xb1>" + var_1878b2531d72df64[i].enum);
      continue;
    }

    var_d0ef8c79b6e23661 = [];
    elements = var_1cdcaa1b699683c2.elements;

    for(j = 0; j < elements.size; j++) {
      element = elements[j];
      var_d0ef8c79b6e23661[element.sharedname] = element.id;
    }

    level.var_d0ef8c79b6e23661[var_1cdcaa1b699683c2.sharedname] = var_d0ef8c79b6e23661;
  }
}

function private function_5ca3bdbcf741615f(eventname, keyname) {
  assert(isxhash(eventname));
  assert(isxhash(keyname));
  var_9ff7bcdcbe037c9e = level.var_7003d55e99a01f70[eventname];

  if(isDefined(var_9ff7bcdcbe037c9e)) {
    return arraycontains(var_9ff7bcdcbe037c9e, keyname);
  } else {
    println("<dev string:xed>" + getxhashsourcename(eventname));
  }

  return 0;
}

function function_6e2deb013c9ca85e(eventname) {
  assert(isxhash(eventname));
  var_87db3db683ff41b3 = level.var_5d0e3c105d8df7e6[eventname];

  if(isDefined(var_87db3db683ff41b3)) {
    return string(var_87db3db683ff41b3.id);
  } else {
    println("<dev string:xed>" + getxhashsourcename(eventname));
  }

  return undefined;
}

function function_d6f771aedba70ce7(eventname, keyname) {
  assert(isxhash(eventname));
  assert(isxhash(keyname));

  if(function_5ca3bdbcf741615f(eventname, keyname)) {
    var_4de8dd33e1da2178 = level.var_7157035465a73c2d[keyname];

    if(isDefined(var_4de8dd33e1da2178)) {
      return var_4de8dd33e1da2178.id;
    } else {
      println("<dev string:x115>" + getxhashsourcename(keyname));
    }
  } else {
    println("<dev string:x13b>" + getxhashsourcename(keyname) + "<dev string:x150>" + getxhashsourcename(eventname));
  }

  return undefined;
}

function function_e2ff8f4b4e94f723(keyname, bitname) {
  assert(isxhash(keyname));
  assert(isxhash(bitname));
  bitfield = level.var_dee8cd959aa57e26[keyname];

  if(isDefined(bitfield)) {
    bitid = bitfield[bitname];

    if(!isDefined(bitid)) {
      println("<dev string:x16b>" + getxhashsourcename(bitname) + "<dev string:x180>" + getxhashsourcename(keyname));
    }

    return bitid;
  } else {
    println("<dev string:x13b>" + getxhashsourcename(keyname) + "<dev string:x199>");
  }

  return undefined;
}

function function_ec8877db4e73e4e8(eventparams, eventname, keyname, value) {
  assert(isxhash(eventname));
  assert(isxhash(keyname));
  keyid = function_d6f771aedba70ce7(eventname, keyname);

  if(isDefined(keyid)) {
    eventparams[eventparams.size] = keyid;
    eventparams[eventparams.size] = int(value);
  } else {
    println("<dev string:x1af>" + getxhashsourcename(keyname) + "<dev string:x1cb>" + value + "<dev string:x1d1>" + getxhashsourcename(eventname));
  }

  return eventparams;
}

function function_b40278e5e468c6c1(var_5d4647843a66d457, elementname) {
  assert(isxhash(var_5d4647843a66d457));
  assert(isxhash(elementname));

  if(isDefined(level.var_d0ef8c79b6e23661[var_5d4647843a66d457])) {
    if(isDefined(level.var_d0ef8c79b6e23661[var_5d4647843a66d457][elementname])) {
      return level.var_d0ef8c79b6e23661[var_5d4647843a66d457][elementname];
    } else {
      println("<dev string:x1e3>" + getxhashsourcename(elementname) + "<dev string:x1f9>" + getxhashsourcename(var_5d4647843a66d457));
    }
  } else {
    println("<dev string:x21a>" + getxhashsourcename(var_5d4647843a66d457));
  }

  return undefined;
}

function function_7042dad035dc176c(stringref) {
  stringhash = getxhash("ae_stringref_" + stringref);
  var_947b262137165984 = function_b40278e5e468c6c1(#"stringref", stringhash);

  if(!isDefined(var_947b262137165984)) {
    println("<dev string:x238>" + stringref + "<dev string:x25b>");
  }

  return var_947b262137165984;
}