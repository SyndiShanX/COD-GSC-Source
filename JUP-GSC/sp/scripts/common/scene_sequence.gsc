/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\common\scene_sequence.gsc
************************************************/

#using scripts\common\scene;
#using scripts\engine\utility;
#namespace scene_sequence;

function function_e514286a93d143da() {}

function function_7227ec8ef6d85118(existingentities, sequencename, defaultscenename) {
  seqroot = self;

  var_6fb1514b3fe5c721 = [];
  sequencebundle = getscriptbundle("sequencescriptbundle:" + sequencename);
  seqroot.scenesequence = spawnStruct();
  seqroot.scenesequence.sequencename = sequencename;
  seqroot.scenesequence.sequencebundle = sequencebundle;
  seqroot.existingentities = existingentities;
  seqroot.scenesequence.nodes = [];
  seqroot.scenesequence.scenestructs = [];
  seqroot.scenesequence.running = [];
  startnode = undefined;
  defaultshotnames = undefined;

  foreach(scenenode in sequencebundle.sequencenodes) {
    seqroot.scenesequence.nodes[scenenode.name] = scenenode;

    if(istrue(scenenode.var_3f62c90b71689589) && !isDefined(startnode)) {
      startnode = scenenode;
    }

    if(!isDefined(scenenode.scene)) {
      if(isDefined(defaultscenename)) {
        scenenode.scene = defaultscenename;

        if(!isDefined(defaultshotnames)) {
          defaultscenebundle = getscriptbundle("scenescriptbundle:" + scenenode.scene);
          defaultshotnames = defaultscenebundle scene::function_8a37fe423de2b9db();
        }

        if(!isDefined(var_6fb1514b3fe5c721[scenenode.scene]) && array_contains(defaultshotnames, scenenode.shot)) {
          var_6fb1514b3fe5c721[scenenode.scene] = scenenode.scene;
        }
      }

      continue;
    }

    if(isDefined(scenenode.scene) && !isDefined(var_6fb1514b3fe5c721[scenenode.scene])) {
      var_6fb1514b3fe5c721[scenenode.scene] = scenenode.scene;
    }
  }

  foreach(scenename in var_6fb1514b3fe5c721) {
    existingstructindex = -1;

    if(isDefined(level.a_scene_names)) {
      for(i = 0; i < level.a_scene_names.size; i++) {
        if(level.a_scene_names[i] == scenename) {
          existingstructindex = i;
          break;
        }
      }
    }

    if(existingstructindex >= 0) {
      seqroot.scenesequence.scenestructs[scenename] = level.var_a0b4eb1703be349a[existingstructindex];
      continue;
    }

    seqroot.scenesequence.scenestructs[scenename] = spawnStruct();
    seqroot.scenesequence.scenestructs[scenename].origin = seqroot.origin;
    seqroot.scenesequence.scenestructs[scenename].angles = seqroot.angles;
  }

  thread start_sequence(startnode);
}

function private start_sequence(startnode) {
  seqroot = self;
  seqroot thread function_fcafbb83f84886ce(startnode);
  seqroot waittill("sequence_finished");
}

function private play_node(scenestruct, shot, scene, existingentities, earlyexitconditions) {
  foreach(conditionname in earlyexitconditions) {
    self endon(conditionname);
  }

  scene::play(existingentities, shot, scene);
  scenestruct notify("Complete" + shot);
}

function private function_fcafbb83f84886ce(currentnode) {
  seqroot = self;
  scenestruct = seqroot.scenesequence.scenestructs[currentnode.scene];
  seqroot.scenesequence.running[currentnode.scene + "-" + currentnode.shot] = scenestruct;
  var_926d6911427d0585 = [];
  var_3f8a8c5b87e149b1 = [];
  var_e06c9ea172ad5900 = [];
  var_90773fd2e792f06c = undefined;

  foreach(condition in currentnode.sequenceconnectors) {
    if(condition.nextsequencenodes.size > 0) {
      if(condition.outputcondition == "ConditionAndActive") {
        var_e06c9ea172ad5900[var_e06c9ea172ad5900.size] = condition;
        var_926d6911427d0585[var_926d6911427d0585.size] = condition;
        var_3f8a8c5b87e149b1[var_3f8a8c5b87e149b1.size] = condition.name;
        continue;
      }

      if(condition.outputcondition == "ConditionAndComplete") {
        var_e06c9ea172ad5900[var_e06c9ea172ad5900.size] = condition;
        continue;
      }

      var_90773fd2e792f06c = condition;
    }
  }

  seqroot thread play_node(scenestruct, currentnode.shot, currentnode.scene, seqroot.existingentities, var_3f8a8c5b87e149b1);

  foreach(condition in var_926d6911427d0585) {
    if(seqroot ent_flag_exist(condition.name)) {
      seqroot thread finish_node(currentnode, condition);
      return;
    }
  }

  var_3f8a8c5b87e149b1[var_3f8a8c5b87e149b1.size] = "Complete" + currentnode.shot;
  completedconditionname = scenestruct waittill_any_in_array_return(var_3f8a8c5b87e149b1);

  if(completedconditionname == "Complete" + currentnode.shot) {
    if(!isDefined(var_90773fd2e792f06c) && var_e06c9ea172ad5900.size > 0) {
      var_b6b8a3e9e4f5d9f2 = [];

      foreach(condition in var_e06c9ea172ad5900) {
        var_b6b8a3e9e4f5d9f2[var_b6b8a3e9e4f5d9f2.size] = condition.name;
      }

      completedconditionname = scenestruct waittill_any_in_array_return(var_b6b8a3e9e4f5d9f2);
    }

    foreach(condition in var_e06c9ea172ad5900) {
      if(completedconditionname == condition.name || seqroot ent_flag_exist(condition.name)) {
        seqroot thread finish_node(currentnode, condition);
        return;
      }
    }

    seqroot thread finish_node(currentnode, var_90773fd2e792f06c);
    return;
  }

  foreach(condition in var_926d6911427d0585) {
    if(completedconditionname == condition.name || seqroot ent_flag_exist(condition.name)) {
      seqroot thread finish_node(currentnode, condition);
      return;
    }
  }
}

function private finish_node(currentnode, exitcondition) {
  seqroot = self;
  seqroot.scenesequence.running[currentnode.scene + "-" + currentnode.shot] = undefined;
  scenestruct = seqroot.scenesequence.scenestructs[currentnode.scene];
  scenestruct function_5e4d2ddddbc6b48b(currentnode.shot);

  if(isDefined(exitcondition)) {
    foreach(nextnodename in exitcondition.nextsequencenodes) {
      nextnode = seqroot.scenesequence.nodes[nextnodename.var_dfd206830b573422];
      seqroot thread function_fcafbb83f84886ce(nextnode);
    }
  }

  waitframe();

  if(seqroot.scenesequence.running.size == 0) {
    seqroot notify("sequence_finished");
  }
}

function function_d2345fa03215e539(note) {
  seqroot = self;
  seqroot notify(note);

  if(isDefined(seqroot.scenesequence) && isDefined(seqroot.scenesequence.scenestructs)) {
    foreach(scenestruct in seqroot.scenesequence.scenestructs) {
      scenestruct notify(note);
    }
  }
}

function function_2af98a24e1bf3199(notifytarget, note, objectname, repeat) {
  seqroot = self;

  if(isDefined(seqroot.scenesequence) && isDefined(seqroot.scenesequence.scenestructs)) {
    foreach(scenestruct in seqroot.scenesequence.scenestructs) {
      scenestruct scene::function_8207074e79f22926(notifytarget, note, objectname, repeat);
    }
  }
}

function function_12b58037eff0f736(conditionname) {
  if(isstring(conditionname)) {
    ent_flag_set(conditionname);
  }
}

function function_919ec256b1627543(conditionname) {
  if(isstring(conditionname)) {
    ent_flag_clear(conditionname, 1);
  }
}

function function_d57898e86f3bb52f(scene, shotname, func, param1, param2, param3, param4) {
  seqroot = self;
  scenestruct = undefined;

  if(isstruct(scene)) {
    foreach(st in seqroot.scenesequence.scenestructs) {
      if(st == scene) {
        scenestruct = scene;
        break;
      }
    }
  } else if(isstring(scene)) {
    if(isDefined(seqroot.scenesequence.scenestructs[scene])) {
      scenestruct = seqroot.scenesequence.scenestructs[scene];
    }
  }

  if(isDefined(scenestruct)) {
    if(!isDefined(scenestruct.callbacks)) {
      scenestruct.callbacks = [];
    }

    if(!isDefined(scenestruct.callbacks[shotname])) {
      scenestruct.callbacks[shotname] = [];
    }

    index = scenestruct.callbacks[shotname].size;
    scenestruct.callbacks[shotname][index] = spawnStruct();
    scenestruct.callbacks[shotname][index].func = func;
    scenestruct.callbacks[shotname][index].param1 = param1;
    scenestruct.callbacks[shotname][index].param2 = param2;
    scenestruct.callbacks[shotname][index].param3 = param3;
    scenestruct.callbacks[shotname][index].param4 = param4;
  }
}

function private function_5e4d2ddddbc6b48b(shotname) {
  scenestruct = self;

  if(isDefined(scenestruct.callbacks) && isDefined(scenestruct.callbacks[shotname])) {
    foreach(callbackstruct in scenestruct.callbacks[shotname]) {
      if(isDefined(callbackstruct.func)) {
        if(isDefined(callbackstruct.parm4)) {
          self[[callbackstruct.func]](callbackstruct.parm1, callbackstruct.parm2, callbackstruct.parm3, callbackstruct.parm4);
          continue;
        }

        if(isDefined(callbackstruct.parm3)) {
          self[[callbackstruct.func]](callbackstruct.parm1, callbackstruct.parm2, callbackstruct.parm3, callbackstruct.parm4);
          continue;
        }

        if(isDefined(callbackstruct.parm2)) {
          self[[callbackstruct.func]](callbackstruct.parm1, callbackstruct.parm2);
          continue;
        }

        if(isDefined(callbackstruct.parm1)) {
          self[[callbackstruct.func]](callbackstruct.parm1);
          continue;
        }

        self[[callbackstruct.func]]();
      }
    }
  }
}