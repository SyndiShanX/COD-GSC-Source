/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\scene_sequence.gsc
************************************************/

#using scripts\common\scene;
#using scripts\engine\utility;
#namespace scene_sequence;

function function_e514286a93d143da() {}

function function_7227ec8ef6d85118(existingentities, sequencename, defaultscenename) {
  var_3fb4893405249050 = self;

  var_6fb1514b3fe5c721 = [];
  sequencebundle = getscriptbundle("sequencescriptbundle:" + sequencename);
  var_3fb4893405249050.scenesequence = spawnStruct();
  var_3fb4893405249050.scenesequence.sequencename = sequencename;
  var_3fb4893405249050.scenesequence.sequencebundle = sequencebundle;
  var_3fb4893405249050.existingentities = existingentities;
  var_3fb4893405249050.scenesequence.nodes = [];
  var_3fb4893405249050.scenesequence.scenestructs = [];
  var_3fb4893405249050.scenesequence.running = [];
  startnode = undefined;
  var_a2f0efa133d35b66 = undefined;

  foreach(scenenode in sequencebundle.sequencenodes) {
    var_3fb4893405249050.scenesequence.nodes[scenenode.name] = scenenode;

    if(istrue(scenenode.var_3f62c90b71689589) && !isDefined(startnode)) {
      startnode = scenenode;
    }

    if(!isDefined(scenenode.scene)) {
      if(isDefined(defaultscenename)) {
        scenenode.scene = defaultscenename;

        if(!isDefined(var_a2f0efa133d35b66)) {
          var_bf0ed7802686aa = getscriptbundle("scenescriptbundle:" + scenenode.scene);
          var_a2f0efa133d35b66 = var_bf0ed7802686aa scene::function_8a37fe423de2b9db();
        }

        if(!isDefined(var_6fb1514b3fe5c721[scenenode.scene]) && array_contains(var_a2f0efa133d35b66, scenenode.shot)) {
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
    var_bc084584b46923e7 = -1;

    if(isDefined(level.var_f99b1d319e65854c)) {
      for(i = 0; i < level.var_f99b1d319e65854c.size; i++) {
        if(level.var_f99b1d319e65854c[i] == scenename) {
          var_bc084584b46923e7 = i;
          break;
        }
      }
    }

    if(var_bc084584b46923e7 >= 0) {
      var_3fb4893405249050.scenesequence.scenestructs[scenename] = level.var_a0b4eb1703be349a[var_bc084584b46923e7];
      continue;
    }

    var_3fb4893405249050.scenesequence.scenestructs[scenename] = spawnStruct();
    var_3fb4893405249050.scenesequence.scenestructs[scenename].origin = var_3fb4893405249050.origin;
    var_3fb4893405249050.scenesequence.scenestructs[scenename].angles = var_3fb4893405249050.angles;
  }

  thread start_sequence(startnode);
}

function private start_sequence(startnode) {
  var_3fb4893405249050 = self;
  var_3fb4893405249050 thread function_fcafbb83f84886ce(startnode);
  var_3fb4893405249050 waittill("sequence_finished");
}

function private play_node(scenestruct, shot, scene, existingentities, var_8ae676fd0285f8c2) {
  foreach(conditionname in var_8ae676fd0285f8c2) {
    self endon(conditionname);
  }

  scene::play(existingentities, shot, scene);
  scenestruct notify("Complete" + shot);
}

function private function_fcafbb83f84886ce(currentnode) {
  var_3fb4893405249050 = self;
  scenestruct = var_3fb4893405249050.scenesequence.scenestructs[currentnode.scene];
  var_3fb4893405249050.scenesequence.running[currentnode.scene + "-" + currentnode.shot] = scenestruct;
  var_926d6911427d0585 = [];
  var_3f8a8c5b87e149b1 = [];
  var_e06c9ea172ad5900 = [];
  var_90773fd2e792f06c = undefined;

  foreach(condition in currentnode.var_50f41da7fed36214) {
    if(condition.var_a3a06df92bada64e.size > 0) {
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

  var_3fb4893405249050 thread play_node(scenestruct, currentnode.shot, currentnode.scene, var_3fb4893405249050.existingentities, var_3f8a8c5b87e149b1);

  foreach(condition in var_926d6911427d0585) {
    if(var_3fb4893405249050 ent_flag_exist(condition.name)) {
      var_3fb4893405249050 thread finish_node(currentnode, condition);
      return;
    }
  }

  var_3f8a8c5b87e149b1[var_3f8a8c5b87e149b1.size] = "Complete" + currentnode.shot;
  var_498eb82cbce10930 = scenestruct waittill_any_in_array_return(var_3f8a8c5b87e149b1);

  if(var_498eb82cbce10930 == "Complete" + currentnode.shot) {
    if(!isDefined(var_90773fd2e792f06c) && var_e06c9ea172ad5900.size > 0) {
      var_b6b8a3e9e4f5d9f2 = [];

      foreach(condition in var_e06c9ea172ad5900) {
        var_b6b8a3e9e4f5d9f2[var_b6b8a3e9e4f5d9f2.size] = condition.name;
      }

      var_498eb82cbce10930 = scenestruct waittill_any_in_array_return(var_b6b8a3e9e4f5d9f2);
    }

    foreach(condition in var_e06c9ea172ad5900) {
      if(var_498eb82cbce10930 == condition.name || var_3fb4893405249050 ent_flag_exist(condition.name)) {
        var_3fb4893405249050 thread finish_node(currentnode, condition);
        return;
      }
    }

    var_3fb4893405249050 thread finish_node(currentnode, var_90773fd2e792f06c);
    return;
  }

  foreach(condition in var_926d6911427d0585) {
    if(var_498eb82cbce10930 == condition.name || var_3fb4893405249050 ent_flag_exist(condition.name)) {
      var_3fb4893405249050 thread finish_node(currentnode, condition);
      return;
    }
  }
}

function private finish_node(currentnode, exitcondition) {
  var_3fb4893405249050 = self;
  var_3fb4893405249050.scenesequence.running[currentnode.scene + "-" + currentnode.shot] = undefined;
  scenestruct = var_3fb4893405249050.scenesequence.scenestructs[currentnode.scene];
  scenestruct function_5e4d2ddddbc6b48b(currentnode.shot);

  if(isDefined(exitcondition)) {
    foreach(nextnodename in exitcondition.var_a3a06df92bada64e) {
      nextnode = var_3fb4893405249050.scenesequence.nodes[nextnodename.var_dfd206830b573422];
      var_3fb4893405249050 thread function_fcafbb83f84886ce(nextnode);
    }
  }

  waitframe();

  if(var_3fb4893405249050.scenesequence.running.size == 0) {
    var_3fb4893405249050 notify("sequence_finished");
  }
}

function function_d2345fa03215e539(note) {
  var_3fb4893405249050 = self;
  var_3fb4893405249050 notify(note);

  if(isDefined(var_3fb4893405249050.scenesequence) && isDefined(var_3fb4893405249050.scenesequence.scenestructs)) {
    foreach(scenestruct in var_3fb4893405249050.scenesequence.scenestructs) {
      scenestruct notify(note);
    }
  }
}

function function_2af98a24e1bf3199(notifytarget, note, objectname, repeat) {
  var_3fb4893405249050 = self;

  if(isDefined(var_3fb4893405249050.scenesequence) && isDefined(var_3fb4893405249050.scenesequence.scenestructs)) {
    foreach(scenestruct in var_3fb4893405249050.scenesequence.scenestructs) {
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
  var_3fb4893405249050 = self;
  scenestruct = undefined;

  if(isstruct(scene)) {
    foreach(st in var_3fb4893405249050.scenesequence.scenestructs) {
      if(st == scene) {
        scenestruct = scene;
        break;
      }
    }
  } else if(isstring(scene)) {
    if(isDefined(var_3fb4893405249050.scenesequence.scenestructs[scene])) {
      scenestruct = var_3fb4893405249050.scenesequence.scenestructs[scene];
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