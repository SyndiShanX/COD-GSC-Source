/*****************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\animation_state_machine_utility.gsc
*****************************************************************/

#using scripts\shared\ai\archetype_utility;
#namespace animationstatenetworkutility;

function requeststate(entity, statename) {
  assert(isDefined(entity));
  entity asmrequestsubstate(statename);
}

function searchanimationmap(entity, aliasname) {
  if(isDefined(entity) && isDefined(aliasname)) {
    animationname = entity animmappingsearch(istring(aliasname));
    if(isDefined(animationname)) {
      return findanimbyname("generic", animationname);
    }
  }
}