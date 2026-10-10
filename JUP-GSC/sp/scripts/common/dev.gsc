/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\common\dev.gsc
***********************************************/

#namespace dev;

function init() {
  initdvars();
  initthreads();
}

function private initdvars() {
  setdevdvarifuninitialized(@ "hash_ebdec3f29783ea70", "<dev string:x1c>");
}

function private initthreads() {
  thread function_945e8b4a4a05b526();
}

function private function_945e8b4a4a05b526() {
  white = (1, 1, 1);
  red = (1, 0, 0);
  green = (0, 1, 0);
  blue = (0, 0, 1);

  while(true) {
    if(getdvarint(@ "hash_ebdec3f29783ea70") > 0) {
      script_models = getEntArray("<dev string:x1e>", "<dev string:x2b>");
      script_origins = getEntArray("<dev string:x35>", "<dev string:x2b>");
      scriptmovercounts = spawnStruct();
      scriptmovercounts.scriptmodeltargets = [];
      scriptmovercounts.scriptmodelnoteworthy = [];
      scriptmovercounts.scriptmodelmisc = 0;
      scriptmovercounts.var_f6496cc6c6cd9606 = [];
      scriptmovercounts.var_14a5f24d72a497bf = [];
      scriptmovercounts.var_174f250d6560ec80 = 0;

      foreach(ent in script_models) {
        line(ent.origin, ent.origin + anglesToForward(ent.angles) * 10, red);
        line(ent.origin, ent.origin + anglestoright(ent.angles) * 10, green);
        line(ent.origin, ent.origin + anglestoup(ent.angles) * 10, blue);

        if(isDefined(ent.targetname)) {
          color = white;
          alpha = 1;
          scale = 1;
          print3d(ent.origin, ent.targetname, color, alpha, scale);
          originstring = "<dev string:x43>" + ent.origin[0] + "<dev string:x45>" + ent.origin[1] + "<dev string:x45>" + ent.origin[2] + "<dev string:x48>";
          print3d(ent.origin + (0, 0, -20), originstring, color, alpha, scale);

          if(isDefined(scriptmovercounts.scriptmodeltargets[ent.targetname])) {
            scriptmovercounts.scriptmodeltargets[ent.targetname] += 1;
          } else {
            scriptmovercounts.scriptmodeltargets[ent.targetname] = 1;
          }

          continue;
        }

        if(isDefined(ent.script_noteworthy)) {
          if(isDefined(scriptmovercounts.scriptmodelnoteworthy[ent.script_noteworthy])) {
            scriptmovercounts.scriptmodelnoteworthy[ent.script_noteworthy] += 1;
          } else {
            scriptmovercounts.scriptmodelnoteworthy[ent.script_noteworthy] = 1;
          }

          continue;
        }

        scriptmovercounts.scriptmodelmisc += 1;
      }

      foreach(ent in script_origins) {
        line(ent.origin, ent.origin + anglesToForward(ent.angles) * 10, red);
        line(ent.origin, ent.origin + anglestoright(ent.angles) * 10, green);
        line(ent.origin, ent.origin + anglestoup(ent.angles) * 10, blue);

        if(isDefined(ent.targetname)) {
          color = white;
          alpha = 1;
          scale = 1;

          switch (ent.targetname) {
            case #"hash_b1841f3499756c6a":
              color = red;
              scale = 3;
              break;
            case #"hash_18b8d1ddd9bd830d":
            case #"hash_c7f2713f8146c2fe":
              color = green;
              scale = 3;
              break;
          }

          print3d(ent.origin, ent.targetname, color, alpha, scale);
          originstring = "<dev string:x43>" + ent.origin[0] + "<dev string:x45>" + ent.origin[1] + "<dev string:x45>" + ent.origin[2] + "<dev string:x48>";
          print3d(ent.origin + (0, 0, -20), originstring, color, alpha, scale);

          if(isDefined(scriptmovercounts.var_f6496cc6c6cd9606[ent.targetname])) {
            scriptmovercounts.var_f6496cc6c6cd9606[ent.targetname] += 1;
          } else {
            scriptmovercounts.var_f6496cc6c6cd9606[ent.targetname] = 1;
          }

          continue;
        }

        if(isDefined(ent.script_noteworthy)) {
          if(isDefined(scriptmovercounts.var_14a5f24d72a497bf[ent.script_noteworthy])) {
            scriptmovercounts.var_14a5f24d72a497bf[ent.script_noteworthy] += 1;
          } else {
            scriptmovercounts.var_14a5f24d72a497bf[ent.script_noteworthy] = 1;
          }

          continue;
        }

        scriptmovercounts.var_174f250d6560ec80 += 1;
      }

      var_bc545feded2c6a23 = 400;
      var_bc545eeded2c67f0 = 50;
      var_916c5c90b430d951 = 15;
      printtoscreen2d(var_bc545feded2c6a23, var_bc545eeded2c67f0, "<dev string:x70>");
      var_bc545eeded2c67f0 += var_916c5c90b430d951;
      printtoscreen2d(var_bc545feded2c6a23, var_bc545eeded2c67f0, "<dev string:x8b>");
      var_bc545eeded2c67f0 += var_916c5c90b430d951;
      printtoscreen2d(var_bc545feded2c6a23, var_bc545eeded2c67f0, "<dev string:x9a>" + scriptmovercounts.scriptmodelmisc);
      var_bc545eeded2c67f0 += var_916c5c90b430d951;
      printtoscreen2d(var_bc545feded2c6a23, var_bc545eeded2c67f0, "<dev string:xaa>");
      var_bc545eeded2c67f0 += var_916c5c90b430d951;

      foreach(targetname, targetcount in scriptmovercounts.scriptmodeltargets) {
        printtoscreen2d(var_bc545feded2c6a23, var_bc545eeded2c67f0, targetname + "<dev string:xb2>" + targetcount);
        var_bc545eeded2c67f0 += var_916c5c90b430d951;
      }

      printtoscreen2d(var_bc545feded2c6a23, var_bc545eeded2c67f0, "<dev string:xb5>");
      var_bc545eeded2c67f0 += var_916c5c90b430d951;

      foreach(noteworthyname, noteworthycount in scriptmovercounts.scriptmodelnoteworthy) {
        printtoscreen2d(var_bc545feded2c6a23, var_bc545eeded2c67f0, noteworthyname + "<dev string:xb2>" + noteworthycount);
        var_bc545eeded2c67f0 += var_916c5c90b430d951;
      }

      printtoscreen2d(var_bc545feded2c6a23, var_bc545eeded2c67f0, "<dev string:xc1>");
      var_bc545eeded2c67f0 += var_916c5c90b430d951;
      printtoscreen2d(var_bc545feded2c6a23, var_bc545eeded2c67f0, "<dev string:x9a>" + scriptmovercounts.var_174f250d6560ec80);
      var_bc545eeded2c67f0 += var_916c5c90b430d951;
      printtoscreen2d(var_bc545feded2c6a23, var_bc545eeded2c67f0, "<dev string:xaa>");
      var_bc545eeded2c67f0 += var_916c5c90b430d951;

      foreach(targetcount in scriptmovercounts.var_f6496cc6c6cd9606) {
        printtoscreen2d(var_bc545feded2c6a23, var_bc545eeded2c67f0, targetname + "<dev string:xb2>" + targetcount);
        var_bc545eeded2c67f0 += var_916c5c90b430d951;
      }

      printtoscreen2d(var_bc545feded2c6a23, var_bc545eeded2c67f0, "<dev string:xb5>");
      var_bc545eeded2c67f0 += var_916c5c90b430d951;

      foreach(noteworthycount in scriptmovercounts.var_14a5f24d72a497bf) {
        printtoscreen2d(var_bc545feded2c6a23, var_bc545eeded2c67f0, noteworthyname + "<dev string:xb2>" + noteworthycount);
        var_bc545eeded2c67f0 += var_916c5c90b430d951;
      }
    }

    wait 0.05;
  }
}

# /