/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\feature_init.gsc
*******************************************/

#namespace feature_init;

function function_90e8509b148d26ec(key, initcallback, dependencies) {
  if(!isDefined(level.initlist)) {
    level.initlist = [];
  }

  if(isDefined(level.initlist[key])) {
    assertmsg("<dev string:x24>" + key);
    return;
  }

  if(isDefined(dependencies) && !isarray(dependencies)) {
    dependencies = [dependencies];
  }

  initdata = spawnStruct();
  initdata.callback = initcallback;
  initdata.dependencies = dependencies;
  level.initlist[key] = initdata;

  function_ce447df300ea0f54(key);
}

function processinitlist() {
  if(!isDefined(level.initlist)) {
    return;
  }

  level.initcount = 0;
  level.var_bd4af0d2c74f4034 = [];

  foreach(key, initdata in level.initlist) {
    function_1e4bda0c1c1d614d(key);

    callinitfunction(key, initdata);
  }

  level.initcount = undefined;
}

function private function_fa095c834417b1de(key) {
  if(!isDefined(level.initlist[key])) {
    return;
  }

  function_1e4bda0c1c1d614d(key);

  callinitfunction(key, level.initlist[key]);
  level.initlist[key] = undefined;
}

function private callinitfunction(key, initdata) {
  if(!isDefined(initdata.callback)) {
    assertmsg("<dev string:x65>" + key);
    return;
  }

  cancall = function_92bf5037f67a5805(key, initdata);

  if(!cancall) {
    return;
  }

  level[[initdata.callback]]();
  level.var_bd4af0d2c74f4034[key] = 1;
  level.initcount++;
}

function private function_92bf5037f67a5805(key, initdata) {
  if(!isDefined(initdata.dependencies)) {
    return true;
  }

  foreach(dependency in initdata.dependencies) {
    if(!istrue(level.var_bd4af0d2c74f4034[dependency])) {
      assertmsg("<dev string:x97>" + key + "<dev string:xcf>" + dependency);
      return false;
    }
  }

  return true;
}

function function_d4c4e134a04e81d4() {
  if(isDefined(level.var_1fc7bca3dc2a80cb) && isfunction(level.var_1fc7bca3dc2a80cb.init)) {
    [[level.var_1fc7bca3dc2a80cb.init]]();
  }
}

function function_ce447df300ea0f54(key) {
  println("<dev string:xfa>" + level.initlist.size - 1 + "<dev string:x10d>" + key);
}

function function_1e4bda0c1c1d614d(key) {
  println("<dev string:xfa>" + level.initcount + "<dev string:x131>" + key);
}

# /