/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\planner_blackboard.gsc
*********************************************************/

#namespace plannerblackboard;

autoexec main() {
  level.__ai_debugplannerblackboard = getdvarint(#"ai_debugplannerblackboard", 0);
}

clearundostack(blackboard) {
  assert(isstruct(blackboard));
  blackboard.undostack = [];
}

create(&blackboardvalues) {
  assert(isarray(blackboardvalues));
  blackboard = spawnStruct();
  blackboard.undostack = [];
  blackboard.values = blackboardvalues;
  setreadmode(blackboard);
  return blackboard;
}

getattribute(blackboard, attribute) {
  assert(isstruct(blackboard));
  assert(isstring(attribute) || ishash(attribute));
  assert(isarray(blackboard.values));
  value = blackboard.values[attribute];

  if(isarray(value)) {
    return arraycopy(value);
  }

  return value;
}

getundostacksize(blackboard) {
  assert(isstruct(blackboard));
  assert(isarray(blackboard.undostack));
  return blackboard.undostack.size;
}

setattribute(blackboard, attribute, value, readonly = 0) {
  assert(isstruct(blackboard));
  assert(isstring(attribute) || ishash(attribute));
  assert(isarray(blackboard.values));
  assert(isarray(blackboard.undostack));
  assert(blackboard.mode === "<dev string:x38>");

  if(isDefined(level.__ai_debugplannerblackboard) && level.__ai_debugplannerblackboard > 0 && !readonly) {
    assert(!isstruct(value), "<dev string:x3d>");

    if(isarray(value)) {
      foreach(entryvalue in value) {
        assert(!isstruct(entryvalue), "<dev string:x87>");
      }
    }
  }

  stackvalue = spawnStruct();
  stackvalue.attribute = attribute;
  stackvalue.value = blackboard.values[attribute];
  blackboard.undostack[blackboard.undostack.size] = stackvalue;
  blackboard.values[attribute] = value;
}

setreadmode(blackboard) {
  blackboard.mode = "r";
}

setreadwritemode(blackboard) {
  blackboard.mode = "rw";
}

undo(blackboard, stackindex) {
  assert(isstruct(blackboard));
  assert(isarray(blackboard.values));
  assert(isarray(blackboard.undostack));
  assert(stackindex < blackboard.undostack.size);

  for(index = blackboard.undostack.size - 1; index > stackindex; index--) {
    stackvalue = blackboard.undostack[index];
    blackboard.values[stackvalue.attribute] = stackvalue.value;
    arrayremoveindex(blackboard.undostack, index);
  }
}