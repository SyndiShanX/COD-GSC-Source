/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\scene_sequence.gsc
*********************************************/

#using scripts\common\scene;
#using scripts\engine\utility;
#namespace scene_sequence;

function function_de9d3fee10016eab() {}

function function_bca8ad726ca07611(existingentities, sequencename, defaultscenename) {
  seqroot = self;

  var_5b761641fabe9278 = [];
  sequencebundle = getscriptbundle("xI\xd4U{\x98b\x8a\xb3\xcc\x12W8\xff\a\x12\x1fV\xa0\x10\xd2" + sequencename);
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

    if(istrue(scenenode.var_9b72b4ca4087bcd0) && !isDefined(startnode)) {
      startnode = scenenode;
    }

    if(!isDefined(scenenode.scene)) {
      if(isDefined(defaultscenename)) {
        scenenode.scene = defaultscenename;

        if(!isDefined(defaultshotnames)) {
          defaultscenebundle = getscriptbundle("\xdc6\xb2\xdcV7\xd8'i\x0e\x1d\x13u\xcd\x19\x8dV:" + scenenode.scene);
          defaultshotnames = defaultscenebundle scene::function_48af8687380ad88a();
        }

        if(!isDefined(var_5b761641fabe9278[scenenode.scene]) && arraycontains(defaultshotnames, scenenode.shot)) {
          var_5b761641fabe9278[scenenode.scene] = scenenode.scene;
        }
      }

      continue;
    }

    if(isDefined(scenenode.scene) && !isDefined(var_5b761641fabe9278[scenenode.scene])) {
      var_5b761641fabe9278[scenenode.scene] = scenenode.scene;
    }
  }

  foreach(scenename in var_5b761641fabe9278) {
    existingstructindex = -1;

    if(isDefined(level.var_7f665b6b5cc35199)) {
      for(i = 0; i < level.var_7f665b6b5cc35199.size; i++) {
        if(level.var_7f665b6b5cc35199[i] == scenename) {
          existingstructindex = i;
          break;
        }
      }
    }

    if(existingstructindex >= 0) {
      seqroot.scenesequence.scenestructs[scenename] = level.var_9f7916307ccddb43[existingstructindex];
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
  seqroot thread function_7bf86c4cb63f2dfb(startnode);
  seqroot waittill("\x9c=\x10k\xadY\x94\"\x1b\x1b\x84\xdb\xb1m:\x90\xee");
}

function private play_node(scenestruct, shot, scene, existingentities, earlyexitconditions) {
  foreach(conditionname in earlyexitconditions) {
    self endon(conditionname);
  }

  scene::play(existingentities, shot, scene);
  scenestruct notify("\xa1ok\ac\xb2\xd1V" + shot);
}

function private function_7bf86c4cb63f2dfb(currentnode) {
  seqroot = self;
  scenestruct = seqroot.scenesequence.scenestructs[currentnode.scene];
  seqroot.scenesequence.running[currentnode.scene + "\xcf" + currentnode.shot] = scenestruct;
  var_26fa3e1e8c6b1884 = [];
  var_7f82433ce373580c = [];
  var_cd7c9bb8a594cb55 = [];
  var_99ad341f5d38f255 = undefined;

  foreach(condition in currentnode.sequenceconnectors) {
    if(condition.nextsequencenodes.size > 0) {
      if(condition.outputcondition == "\x18\x8b0\xf2\b\x03\xee\x1f\x16\x03\x8f\xc7\xf4xf\xa5\xdd\x05") {
        var_cd7c9bb8a594cb55[var_cd7c9bb8a594cb55.size] = condition;
        var_26fa3e1e8c6b1884[var_26fa3e1e8c6b1884.size] = condition;
        var_7f82433ce373580c[var_7f82433ce373580c.size] = condition.name;
        continue;
      }

      if(condition.outputcondition == "Xk\xdexT#\xe2\x18\xd6\x1e\x81\xad\xfe\x04\xc3\xd0\xa8.:\xa0") {
        var_cd7c9bb8a594cb55[var_cd7c9bb8a594cb55.size] = condition;
        continue;
      }

      var_99ad341f5d38f255 = condition;
    }
  }

  seqroot thread play_node(scenestruct, currentnode.shot, currentnode.scene, seqroot.existingentities, var_7f82433ce373580c);

  foreach(condition in var_26fa3e1e8c6b1884) {
    if(seqroot utility::ent_flag_exist(condition.name)) {
      seqroot thread finish_node(currentnode, condition);
      return;
    }
  }

  var_7f82433ce373580c[var_7f82433ce373580c.size] = "\xa1ok\ac\xb2\xd1V" + currentnode.shot;
  completedconditionname = scenestruct utility::waittill_any_in_array_return(var_7f82433ce373580c);

  if(completedconditionname == "\xa1ok\ac\xb2\xd1V" + currentnode.shot) {
    if(!isDefined(var_99ad341f5d38f255) && var_cd7c9bb8a594cb55.size > 0) {
      var_4a187d7773beb53f = [];

      foreach(condition in var_cd7c9bb8a594cb55) {
        var_4a187d7773beb53f[var_4a187d7773beb53f.size] = condition.name;
      }

      completedconditionname = scenestruct utility::waittill_any_in_array_return(var_4a187d7773beb53f);
    }

    foreach(condition in var_cd7c9bb8a594cb55) {
      if(completedconditionname == condition.name || seqroot utility::ent_flag_exist(condition.name)) {
        seqroot thread finish_node(currentnode, condition);
        return;
      }
    }

    seqroot thread finish_node(currentnode, var_99ad341f5d38f255);
    return;
  }

  foreach(condition in var_26fa3e1e8c6b1884) {
    if(completedconditionname == condition.name || seqroot utility::ent_flag_exist(condition.name)) {
      seqroot thread finish_node(currentnode, condition);
      return;
    }
  }
}

function private finish_node(currentnode, exitcondition) {
  seqroot = self;
  seqroot.scenesequence.running[currentnode.scene + "\xcf" + currentnode.shot] = undefined;
  scenestruct = seqroot.scenesequence.scenestructs[currentnode.scene];
  scenestruct function_bfa395b257e60766(currentnode.shot);

  if(isDefined(exitcondition)) {
    foreach(nextnodename in exitcondition.nextsequencenodes) {
      nextnode = seqroot.scenesequence.nodes[nextnodename.var_97643a94036492af];
      seqroot thread function_7bf86c4cb63f2dfb(nextnode);
    }
  }

  waitframe();

  if(seqroot.scenesequence.running.size == 0) {
    seqroot notify("\x9c=\x10k\xadY\x94\"\x1b\x1b\x84\xdb\xb1m:\x90\xee");
  }
}

function function_a966dbac9a60e8a4(note) {
  seqroot = self;
  seqroot notify(note);

  if(isDefined(seqroot.scenesequence) && isDefined(seqroot.scenesequence.scenestructs)) {
    foreach(scenestruct in seqroot.scenesequence.scenestructs) {
      scenestruct notify(note);
    }
  }
}

function function_5a7604201f1da364(notifytarget, note, objectname, repeat) {
  seqroot = self;

  if(isDefined(seqroot.scenesequence) && isDefined(seqroot.scenesequence.scenestructs)) {
    foreach(scenestruct in seqroot.scenesequence.scenestructs) {
      scenestruct scene::function_993ae53c5ec4240b(notifytarget, note, objectname, repeat);
    }
  }
}

function function_744fb1a8b6eddbf7(conditionname) {
  if(isstring(conditionname)) {
    utility::ent_flag_set(conditionname);
  }
}

function function_ceab08cac7ebdfaa(conditionname) {
  if(isstring(conditionname)) {
    utility::ent_flag_clear(conditionname, 1);
  }
}

function function_124c0163514c859e(scene, shotname, func, ...) {
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
    scenestruct.callbacks[shotname][index].vararg = vararg;
    scenestruct.callbacks[shotname][index].varargcount = varargcount;
  }
}

function private function_bfa395b257e60766(shotname) {
  scenestruct = self;

  if(isDefined(scenestruct.callbacks) && isDefined(scenestruct.callbacks[shotname])) {
    foreach(callbackstruct in scenestruct.callbacks[shotname]) {
      if(isDefined(callbackstruct.func)) {
        self[[callbackstruct.func]](flat_args(callbackstruct.vararg, callbackstruct.varargcount));
      }
    }
  }
}