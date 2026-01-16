/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\blackboard.gsc
*************************************************/

#namespace blackboard;

function registerblackboardattribute(entity, attributename, defaultattributevalue, getterfunction) {
  assert(isdefined(entity.__blackboard), "");
  assert(!isdefined(entity.__blackboard[attributename]), ("" + attributename) + "");
  if(isdefined(getterfunction)) {
    assert(isfunctionptr(getterfunction));
    entity.__blackboard[attributename] = getterfunction;
  } else {
    if(!isdefined(defaultattributevalue)) {
      defaultattributevalue = undefined;
    }
    entity.__blackboard[attributename] = defaultattributevalue;
  }
}

function getblackboardattribute(entity, attributename) {
  if(isfunctionptr(entity.__blackboard[attributename])) {
    getterfunction = entity.__blackboard[attributename];
    attributevalue = entity[[getterfunction]]();
    if(isactor(entity)) {
      entity updatetrackedblackboardattribute(attributename);
    }
    return attributevalue;
  }
  if(isactor(entity)) {
    entity updatetrackedblackboardattribute(attributename);
  }
  return entity.__blackboard[attributename];
}

function setblackboardattribute(entity, attributename, attributevalue) {
  if(isdefined(entity.__blackboard[attributename])) {
    if(!isdefined(attributevalue) && isfunctionptr(entity.__blackboard[attributename])) {
      return;
    }
    assert(!isfunctionptr(entity.__blackboard[attributename]), "");
  }
  entity.__blackboard[attributename] = attributevalue;
  if(isactor(entity)) {
    entity updatetrackedblackboardattribute(attributename);
  }
}

function createblackboardforentity(entity) {
  if(!isdefined(entity.__blackboard)) {
    entity.__blackboard = [];
  }
  if(!isdefined(level._setblackboardattributefunc)) {
    level._setblackboardattributefunc = & setblackboardattribute;
  }
}