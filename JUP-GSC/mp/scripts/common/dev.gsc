/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\dev.gsc
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
  thread devscriptmoversdebugdraw();
}

function private devscriptmoversdebugdraw() {
  white = (1, 1, 1);
  red = (1, 0, 0);
  green = (0, 1, 0);
  blue = (0, 0, 1);

  while(true) {
    if(getdvarint(@ "hash_ebdec3f29783ea70") > 0) {
      script_models = getEntArray("<dev string:x21>", "<dev string:x31>");
      script_origins = getEntArray("<dev string:x3e>", "<dev string:x31>");
      scriptmovercounts = spawnStruct();
      scriptmovercounts.scriptmodeltargets = [];
      scriptmovercounts.scriptmodelnoteworthy = [];
      scriptmovercounts.scriptmodelmisc = 0;
      scriptmovercounts.scriptorigintargets = [];
      scriptmovercounts.scriptoriginnoteworthy = [];
      scriptmovercounts.scriptoriginmisc = 0;

      foreach(ent in script_models) {
        line(ent.origin, ent.origin + anglesToForward(ent.angles) * 10, red);
        line(ent.origin, ent.origin + anglestoright(ent.angles) * 10, green);
        line(ent.origin, ent.origin + anglestoup(ent.angles) * 10, blue);

        if(isDefined(ent.targetname)) {
          color = white;
          alpha = 1;
          scale = 1;
          print3d(ent.origin, ent.targetname, color, alpha, scale);
          originstring = "<dev string:x4f>" + ent.origin[0] + "<dev string:x54>" + ent.origin[1] + "<dev string:x54>" + ent.origin[2] + "<dev string:x5a>";
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
          originstring = "<dev string:x4f>" + ent.origin[0] + "<dev string:x54>" + ent.origin[1] + "<dev string:x54>" + ent.origin[2] + "<dev string:x5a>";
          print3d(ent.origin + (0, 0, -20), originstring, color, alpha, scale);

          if(isDefined(scriptmovercounts.scriptorigintargets[ent.targetname])) {
            scriptmovercounts.scriptorigintargets[ent.targetname] += 1;
          } else {
            scriptmovercounts.scriptorigintargets[ent.targetname] = 1;
          }

          continue;
        }

        if(isDefined(ent.script_noteworthy)) {
          if(isDefined(scriptmovercounts.scriptoriginnoteworthy[ent.script_noteworthy])) {
            scriptmovercounts.scriptoriginnoteworthy[ent.script_noteworthy] += 1;
          } else {
            scriptmovercounts.scriptoriginnoteworthy[ent.script_noteworthy] = 1;
          }

          continue;
        }

        scriptmovercounts.scriptoriginmisc += 1;
      }

      screenposx = 400;
      screenposy = 50;
      screenposyspacing = 15;
      printtoscreen2d(screenposx, screenposy, "<dev string:x8e>");
      screenposy += screenposyspacing;
      printtoscreen2d(screenposx, screenposy, "<dev string:xac>");
      screenposy += screenposyspacing;
      printtoscreen2d(screenposx, screenposy, "<dev string:xbe>" + scriptmovercounts.scriptmodelmisc);
      screenposy += screenposyspacing;
      printtoscreen2d(screenposx, screenposy, "<dev string:xd1>");
      screenposy += screenposyspacing;

      foreach(targetname, targetcount in scriptmovercounts.scriptmodeltargets) {
        printtoscreen2d(screenposx, screenposy, targetname + "<dev string:xdc>" + targetcount);
        screenposy += screenposyspacing;
      }

      printtoscreen2d(screenposx, screenposy, "<dev string:xe2>");
      screenposy += screenposyspacing;

      foreach(noteworthyname, noteworthycount in scriptmovercounts.scriptmodelnoteworthy) {
        printtoscreen2d(screenposx, screenposy, noteworthyname + "<dev string:xdc>" + noteworthycount);
        screenposy += screenposyspacing;
      }

      printtoscreen2d(screenposx, screenposy, "<dev string:xf1>");
      screenposy += screenposyspacing;
      printtoscreen2d(screenposx, screenposy, "<dev string:xbe>" + scriptmovercounts.scriptoriginmisc);
      screenposy += screenposyspacing;
      printtoscreen2d(screenposx, screenposy, "<dev string:xd1>");
      screenposy += screenposyspacing;

      foreach(targetname, targetcount in scriptmovercounts.scriptorigintargets) {
        printtoscreen2d(screenposx, screenposy, targetname + "<dev string:xdc>" + targetcount);
        screenposy += screenposyspacing;
      }

      printtoscreen2d(screenposx, screenposy, "<dev string:xe2>");
      screenposy += screenposyspacing;

      foreach(noteworthyname, noteworthycount in scriptmovercounts.scriptoriginnoteworthy) {
        printtoscreen2d(screenposx, screenposy, noteworthyname + "<dev string:xdc>" + noteworthycount);
        screenposy += screenposyspacing;
      }
    }

    wait 0.05;
  }
}

# /