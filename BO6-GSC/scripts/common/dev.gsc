/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\dev.gsc
**************************************/

#namespace dev;

function init() {
  initdvars();
  initthreads();
}

function private initdvars() {
  setdevdvarifuninitialized(@ "hash_ebdec3f29783ea70", "<dev string:x24>");
  setdevdvarifuninitialized(@ "hash_c744a130cac039c1", 0, 0, 1);
  setdevdvarifuninitialized(@ "hash_95b6f5a816be82ab", 1, 0.1, 10);
}

function private initthreads() {
  thread function_a7afe26a10dcdaef();
  thread function_f01fab7891253b0e();
}

function private function_a7afe26a10dcdaef() {
  white = (1, 1, 1);
  red = (1, 0, 0);
  green = (0, 1, 0);
  blue = (0, 0, 1);

  while(true) {
    if(getdvarint(@ "hash_ebdec3f29783ea70") > 0) {
      script_models = getEntArray("<dev string:x29>", #classname);
      script_origins = getEntArray("<dev string:x39>", #classname);
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
          originstring = "<dev string:x4a>" + ent.origin[0] + "<dev string:x4f>" + ent.origin[1] + "<dev string:x4f>" + ent.origin[2] + "<dev string:x55>";
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
          originstring = "<dev string:x4a>" + ent.origin[0] + "<dev string:x4f>" + ent.origin[1] + "<dev string:x4f>" + ent.origin[2] + "<dev string:x55>";
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
      printtoscreen2d(screenposx, screenposy, "<dev string:x89>");
      screenposy += screenposyspacing;
      printtoscreen2d(screenposx, screenposy, "<dev string:xa7>");
      screenposy += screenposyspacing;
      printtoscreen2d(screenposx, screenposy, "<dev string:xb9>" + scriptmovercounts.scriptmodelmisc);
      screenposy += screenposyspacing;
      printtoscreen2d(screenposx, screenposy, "<dev string:xcc>");
      screenposy += screenposyspacing;

      foreach(targetname, targetcount in scriptmovercounts.scriptmodeltargets) {
        printtoscreen2d(screenposx, screenposy, targetname + "<dev string:xd7>" + targetcount);
        screenposy += screenposyspacing;
      }

      printtoscreen2d(screenposx, screenposy, "<dev string:xdd>");
      screenposy += screenposyspacing;

      foreach(noteworthyname, noteworthycount in scriptmovercounts.scriptmodelnoteworthy) {
        printtoscreen2d(screenposx, screenposy, noteworthyname + "<dev string:xd7>" + noteworthycount);
        screenposy += screenposyspacing;
      }

      printtoscreen2d(screenposx, screenposy, "<dev string:xec>");
      screenposy += screenposyspacing;
      printtoscreen2d(screenposx, screenposy, "<dev string:xb9>" + scriptmovercounts.scriptoriginmisc);
      screenposy += screenposyspacing;
      printtoscreen2d(screenposx, screenposy, "<dev string:xcc>");
      screenposy += screenposyspacing;

      foreach(targetcount in scriptmovercounts.scriptorigintargets) {
        printtoscreen2d(screenposx, screenposy, targetname + "<dev string:xd7>" + targetcount);
        screenposy += screenposyspacing;
      }

      printtoscreen2d(screenposx, screenposy, "<dev string:xdd>");
      screenposy += screenposyspacing;

      foreach(noteworthycount in scriptmovercounts.scriptoriginnoteworthy) {
        printtoscreen2d(screenposx, screenposy, noteworthyname + "<dev string:xd7>" + noteworthycount);
        screenposy += screenposyspacing;
      }
    }

    wait 0.05;
  }
}

function function_f01fab7891253b0e() {
  while(true) {
    if(getdvarint(@ "hash_c744a130cac039c1", 0) > 0) {
      ai = getaiarray();
      scale = getdvarfloat(@ "hash_95b6f5a816be82ab", 1);

      if(istrue(level.ismp)) {
        players = level.players;

        foreach(player in players) {
          if(player == level.player) {
            continue;
          }

          if(isalive(player)) {
            if(isDefined(player.operatorcustomization)) {
              operator = getxhashsourcename(player.operatorcustomization.operatorref);
              geartext = "<dev string:xff>" + player getgeartype();
              clothtext = "<dev string:x109>" + player getclothtype();
              player function_b1f4b2440fe2aadf(operator, geartext, clothtext, scale);
            }
          }
        }
      }

      foreach(player in ai) {
        operator = player.classname;
        operator = removesubstr(operator, "<dev string:x114>");
        geartext = "<dev string:xff>" + player getgeartype();
        clothtext = "<dev string:x109>" + player getclothtype();
        player function_b1f4b2440fe2aadf(operator, geartext, clothtext, scale);
      }
    }

    wait 0.5;
  }
}

function function_b1f4b2440fe2aadf(operator, geartext, clothtext, scale) {
  print3d(self.origin, geartext, (0, 1, 0), 1, scale, 30, 1);
  print3d(self.origin + (0, 0, 30), clothtext, (0, 1, 0), 1, scale, 30, 1);
  print3d(self.origin + (0, 0, 60), operator, (0, 1, 0), 1, scale, 30, 1);
}

# /