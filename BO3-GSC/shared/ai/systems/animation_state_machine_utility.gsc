/*****************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\animation_state_machine_utility.gsc
*****************************************************************/

#using scripts\shared\ai\archetype_utility;
#namespace animationstatenetworkutility;

function requeststate(entity, statename) {
  assert(isdefined(entity));
  entity asmrequestsubstate(statename);
}

function searchanimationmap(entity, aliasname) {
  if(isdefined(entity) && isdefined(aliasname)) {
    animationname = entity animmappingsearch(istring(aliasname));
    if(isdefined(animationname)) {
      return findanimbyname("generic", animationname);
    }
  }
}