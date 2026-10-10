/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_70215259b7bd2d.gsc
***********************************************/

#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\utility\script;
#namespace br_flyover;

function autoexec main() {
  if(getdvarint(@ "hash_c8d311b3800e73a1", 0) == 0) {
    return;
  }

  level.var_368ef77d49005b22 = spawnStruct();
  level.var_368ef77d49005b22.scriptbundles = [];
  thread function_556aa2258083cba2();
}

function function_556aa2258083cba2() {
  scripts\mp\flags::function_1240434f4201ac9d("prematch_done");

  level thread function_57a1e7f67cf6778b();

  var_12a6bf9eca01f177 = undefined;

  if(issharedfuncdefined("br_flyover", "getFlyoverScriptbundleName")) {
    var_12a6bf9eca01f177 = [[getsharedfunc("br_flyover", "getFlyoverScriptbundleName")]]();
  }

  if(!isDefined(var_12a6bf9eca01f177)) {
    return;
  }

  function_fd817d756ea414a7(var_12a6bf9eca01f177, 1);
  level.var_368ef77d49005b22.var_20d9348b7cb4cebe = (0, 0, default_to(level.respawnheightoverride, level.var_dc52a11d1ee2690e) + 100);
}

function function_fd817d756ea414a7(var_41fdaab3e199d5d4, var_8db494ef01340c1b) {
  var_c30137026b24924f = getscriptbundle(hashcat(%"hash_4951d6ef559952e1", var_41fdaab3e199d5d4));

  if(!isDefined(var_c30137026b24924f)) {
    scripts\mp\utility\script::demoforcesre("Could not find scriptbundle flyover type " + var_41fdaab3e199d5d4);
    return undefined;
  }

  var_c30137026b24924f.var_41fdaab3e199d5d4 = var_41fdaab3e199d5d4;
  var_c30137026b24924f.var_b28365da565bc29 = getDvar(hashcat(@ "hash_dcd9cf804c479920", var_41fdaab3e199d5d4, "_model"), var_c30137026b24924f.var_b28365da565bc29);
  var_c30137026b24924f.var_3623f607841a422e = getDvar(hashcat(@ "hash_dcd9cf804c479920", var_41fdaab3e199d5d4, "_offset_type"), default_to(var_c30137026b24924f.var_3623f607841a422e, "from_circle_center"));
  offset = (default_to(var_c30137026b24924f.originx, 0), default_to(var_c30137026b24924f.originy, 0), default_to(var_c30137026b24924f.originz, 0));
  var_c30137026b24924f.offset = getdvarvector(hashcat(@ "hash_dcd9cf804c479920", var_41fdaab3e199d5d4, "_offset"), offset);
  var_c30137026b24924f.minangle = getdvarint(hashcat(@ "hash_dcd9cf804c479920", var_41fdaab3e199d5d4, "_min_angle"), int(var_c30137026b24924f.minangle));
  var_c30137026b24924f.maxangle = getdvarint(hashcat(@ "hash_dcd9cf804c479920", var_41fdaab3e199d5d4, "_max_angle"), int(var_c30137026b24924f.maxangle));

  for(i = 0; i < var_c30137026b24924f.size; i++) {
    var_c30137026b24924f.var_e908cc93c16d9635[i].circleindex = getdvarint(hashcat(@ "hash_dcd9cf804c479920", var_41fdaab3e199d5d4, "_circle_index_", i), var_c30137026b24924f.var_e908cc93c16d9635[i].circleindex);
    var_c30137026b24924f.var_e908cc93c16d9635[i].var_ac5531401e9adfab = getdvarint(hashcat(@ "hash_dcd9cf804c479920", var_41fdaab3e199d5d4, "_odds_", i), var_c30137026b24924f.var_e908cc93c16d9635[i].var_ac5531401e9adfab);
    var_c30137026b24924f.var_e908cc93c16d9635[i].count = getdvarint(hashcat(@ "hash_dcd9cf804c479920", var_41fdaab3e199d5d4, "_count_", i), var_c30137026b24924f.var_e908cc93c16d9635[i].count);
    var_c30137026b24924f.var_e908cc93c16d9635[i].mindelay = getdvarint(hashcat(@ "hash_dcd9cf804c479920", var_41fdaab3e199d5d4, "_min_delay_", i), var_c30137026b24924f.var_e908cc93c16d9635[i].mindelay);
    var_c30137026b24924f.var_e908cc93c16d9635[i].maxdelay = getdvarint(hashcat(@ "hash_dcd9cf804c479920", var_41fdaab3e199d5d4, "_max_delay_", i), var_c30137026b24924f.var_e908cc93c16d9635[i].maxdelay);
  }

  level.var_368ef77d49005b22.scriptbundles[var_41fdaab3e199d5d4] = var_c30137026b24924f;

  if(istrue(var_8db494ef01340c1b)) {
    thread function_5cb8cc4c0c7b3f7a(var_41fdaab3e199d5d4);
  }
}

function function_5cb8cc4c0c7b3f7a(var_41fdaab3e199d5d4) {
  if(!function_aa7d019e6c4075cc(var_41fdaab3e199d5d4)) {
    scripts\mp\utility\script::demoforcesre("Flyover type " + var_41fdaab3e199d5d4 + " is not registered");
    return;
  }

  level endon("game_ended");
  var_c30137026b24924f = level.var_368ef77d49005b22.scriptbundles[var_41fdaab3e199d5d4];
  var_1de9117955ff6706 = 0;

  while(true) {
    level waittill("br_circle_set");

    if(level.br_circle.circleindex + 1 == var_c30137026b24924f.var_e908cc93c16d9635[var_1de9117955ff6706].circleindex) {
      function_7e9d67e04bfb5eeb(var_c30137026b24924f, var_1de9117955ff6706);
      var_1de9117955ff6706++;

      if(var_c30137026b24924f.var_e908cc93c16d9635.size >= var_1de9117955ff6706) {
        return;
      }
    }
  }
}

function function_7e9d67e04bfb5eeb(var_c30137026b24924f, var_dd5c44be21462d77) {
  level endon("game_ended");
  scripts\mp\flags::function_1240434f4201ac9d("prematch_done");

  level thread function_57a1e7f67cf6778b();

  var_56af67819c70d986 = 0;
  var_26e96d0de755ad84 = var_c30137026b24924f.var_e908cc93c16d9635[var_dd5c44be21462d77];
  var_4d9e2106cab52aa3 = function_8e7c7b731e241928(var_c30137026b24924f, var_26e96d0de755ad84.circleindex);

  while(var_56af67819c70d986 < var_26e96d0de755ad84.count) {
    if(var_26e96d0de755ad84.mindelay != 0 && var_26e96d0de755ad84.maxdelay != 0) {
      var_70f53c8f4c6d411e = randomintrange(var_26e96d0de755ad84.mindelay, var_26e96d0de755ad84.maxdelay);
      wait var_70f53c8f4c6d411e;
    }

    if(percent_chance(var_26e96d0de755ad84.var_ac5531401e9adfab)) {
      function_991f45d648259c50(var_4d9e2106cab52aa3);
    }

    var_56af67819c70d986++;
  }

  if(isDefined(var_4d9e2106cab52aa3)) {
    var_4d9e2106cab52aa3 delete();
  }
}

function function_aa7d019e6c4075cc(var_41fdaab3e199d5d4) {
  return isDefined(level.var_368ef77d49005b22.scriptbundles[var_41fdaab3e199d5d4]);
}

function function_8e7c7b731e241928(var_c30137026b24924f, circleindex) {
  switch (var_c30137026b24924f.var_3623f607841a422e) {
    case #"hash_1769f355d134e48e":
      var_8cd89f492783053f = level.var_368ef77d49005b22.var_20d9348b7cb4cebe + level.br_level.br_circlecenters[circleindex] + var_c30137026b24924f.offset;
      break;
    case #"hash_aeeb8f1aa5effd24":
    default:
      var_8cd89f492783053f = level.var_368ef77d49005b22.var_20d9348b7cb4cebe + var_c30137026b24924f.offset;
      break;
  }

  var_4d9e2106cab52aa3 = spawn("script_model", var_8cd89f492783053f);
  var_4d9e2106cab52aa3 setModel(var_c30137026b24924f.var_b28365da565bc29);

  if(var_c30137026b24924f.minangle != 0 && var_c30137026b24924f.maxangle != 0) {
    if(var_c30137026b24924f.minangle != var_c30137026b24924f.maxangle) {
      var_4d9e2106cab52aa3.angles = (0, randomintrange(var_c30137026b24924f.minangle, var_c30137026b24924f.maxangle), 0);
    } else {
      var_4d9e2106cab52aa3.angles = (0, var_c30137026b24924f.minangle, 0);
    }
  }

  return var_4d9e2106cab52aa3;
}

function function_991f45d648259c50(var_4d9e2106cab52aa3) {
  level endon("game_ended");

  if(!isDefined(var_4d9e2106cab52aa3)) {
    return;
  }

  var_4d9e2106cab52aa3 setscriptablepartstate("skywriter", "write");
  wait 10;
  var_4d9e2106cab52aa3 setscriptablepartstate("skywriter", "rest");
  wait 4;
}

function function_57a1e7f67cf6778b() {
  level endon("<dev string:x1c>");
  setdevdvarifuninitialized(@ "hash_d35e8eaa86a01553", "<dev string:x2a>");

  while(getdvarint(@ "hash_3063000740d0cda7", 0)) {
    var_ab0936d5886c654c = getDvar(@ "hash_d35e8eaa86a01553", "<dev string:x2a>");

    if(var_ab0936d5886c654c.size > 0) {
      if(!function_aa7d019e6c4075cc(var_ab0936d5886c654c)) {
        function_fd817d756ea414a7(var_ab0936d5886c654c, 0);
      }

      iprintlnbold("<dev string:x2e>");
      var_4d9e2106cab52aa3 = function_8e7c7b731e241928(level.var_368ef77d49005b22.scriptbundles[var_ab0936d5886c654c], 0);
      function_991f45d648259c50(var_4d9e2106cab52aa3);
      iprintlnbold("<dev string:x3f>");

      if(isDefined(var_4d9e2106cab52aa3)) {
        var_4d9e2106cab52aa3 delete();
      }

      setDvar(@ "hash_d35e8eaa86a01553", "<dev string:x2a>");
    }

    waitframe();
  }
}

# /