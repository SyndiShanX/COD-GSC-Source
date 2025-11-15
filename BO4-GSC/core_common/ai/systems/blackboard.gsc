/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\blackboard.gsc
*************************************************/

#namespace blackboard;

registerblackboardattribute(entity, attributename, defaultattributevalue, getterfunction) {
  assert(isDefined(entity.__blackboard), "<dev string:x38>");
  assert(!isDefined(entity.__blackboard[attributename]), "<dev string:x77>" + attributename + "<dev string:x91>");

  if(isDefined(getterfunction)) {
    assert(isfunctionptr(getterfunction));
    entity.__blackboard[attributename] = getterfunction;
  } else {
    if(!isDefined(defaultattributevalue)) {
      defaultattributevalue = undefined;
    }

    entity.__blackboard[attributename] = defaultattributevalue;
  }

  if(isactor(entity)) {
    entity trackblackboardattribute(attributename);
  }

}

getstructblackboardattribute(struct, attributename) {
  assert(isstruct(struct));

  if(isfunctionptr(struct.__blackboard[attributename])) {
    getterfunction = struct.__blackboard[attributename];
    attributevalue = struct[[getterfunction]]();
    return attributevalue;
  }

  return struct.__blackboard[attributename];
}

setstructblackboardattribute(struct, attributename, attributevalue) {
  assert(isstruct(struct));

  if(isDefined(struct.__blackboard[attributename])) {
    if(!isDefined(attributevalue) && isfunctionptr(struct.__blackboard[attributename])) {
      return;
    }

    assert(!isfunctionptr(struct.__blackboard[attributename]), "<dev string:xa8>");
  }

  struct.__blackboard[attributename] = attributevalue;
}

createblackboardforentity(entity) {
  if(!isDefined(entity.__blackboard)) {
    entity.__blackboard = [];

    if(isentity(entity)) {
      entity createblackboardentries();
    }
  }

  if(!isDefined(level._setblackboardattributefunc)) {
    level._setblackboardattributefunc = &setblackboardattribute;
  }
}

cloneblackboardfromstruct(struct) {
  assert(isstruct(struct));
  blackboard = [];

  if(isDefined(struct.__blackboard)) {
    foreach(k, v in struct.__blackboard) {
      blackboard[k] = getstructblackboardattribute(struct, k);
    }
  }

  return blackboard;
}