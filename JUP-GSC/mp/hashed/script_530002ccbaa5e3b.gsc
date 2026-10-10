/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_530002ccbaa5e3b.gsc
************************************************/

#namespace namespace_9b9fbf828d53f353;

function function_54dfca3641c2c1ab(filenamerequested) {
  if(!isDefined(level.var_87766fb0b0a03a87)) {
    level.var_87766fb0b0a03a87 = [];
  }

  fileobject = function_113ae197e6c38cb8(filenamerequested);

  if(!isDefined(fileobject)) {
    fileobject = function_a22fc988697bb76d(filenamerequested);

    if(fileobject) {
      function_b6d1131bbf38fd70(filenamerequested, fileobject);
    }
  }

  return fileobject;
}

function private function_b6d1131bbf38fd70(filename, fileobject) {
  if(fileobject) {
    var_dae5b56fef5253a7 = spawnStruct();
    var_dae5b56fef5253a7.id = filename;
    var_dae5b56fef5253a7.object = fileobject;
    level.var_87766fb0b0a03a87[level.var_87766fb0b0a03a87.size] = var_dae5b56fef5253a7;
    return true;
  }

  return false;
}

function private function_113ae197e6c38cb8(filerequested) {
  foreach(var_b643a4a42d8b8dbf in level.var_87766fb0b0a03a87) {
    if(var_b643a4a42d8b8dbf.id == filerequested) {
      return var_b643a4a42d8b8dbf.object;
    }
  }

  return undefined;
}

function private function_a22fc988697bb76d(filerequested) {
  while(istrue(level.var_6ff7b075bad15e1b)) {
    waitframe();
  }

  if(function_a5eda2d3293e9225(filerequested)) {
    level.var_6ff7b075bad15e1b = 1;
    filename = "";
    fileobject = undefined;
    succeed = 0;

    while(filename != filerequested) {
      level waittill("publisher_download_completed", succeed, filename);
    }

    if(succeed) {
      fileobject = function_e7f8033f0614eb44();
    }

    level.var_6ff7b075bad15e1b = 0;
    return fileobject;
  }

  return undefined;
}