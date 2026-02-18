/*************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\blackboard.gsc
*************************************************/

#namespace blackboard;

function registerblackboardattribute(entity, attributename, defaultattributevalue, getterfunction) {
  assert(isDefined(entity.__blackboard), "<dev string:x38>");
  assert(!isDefined(entity.__blackboard[attributename]), "<dev string:x78>" + attributename + "<dev string:x93>");

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

function getstructblackboardattribute(struct, attributename) {
  assert(isstruct(struct) || isentity(struct));

  if(isfunctionptr(struct.__blackboard[attributename])) {
    getterfunction = struct.__blackboard[attributename];
    attributevalue = struct[[getterfunction]]();
    return attributevalue;
  }

  return struct.__blackboard[attributename];
}

function setstructblackboardattribute(struct, attributename, attributevalue) {
  assert(isstruct(struct) || isentity(struct));

  if(isDefined(struct.__blackboard[attributename])) {
    if(!isDefined(attributevalue) && isfunctionptr(struct.__blackboard[attributename])) {
      return;
    }

    assert(!isfunctionptr(struct.__blackboard[attributename]), "<dev string:xab>");
  }

  struct.__blackboard[attributename] = attributevalue;
}

function createblackboardforentity(entity) {
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

function cloneblackboardfromstruct(struct) {
  assert(isstruct(struct) || isentity(struct));
  blackboard = [];

  if(isDefined(struct.__blackboard)) {
    foreach(k, v in struct.__blackboard) {
      blackboard[k] = getstructblackboardattribute(struct, k);
    }
  }

  return blackboard;
}