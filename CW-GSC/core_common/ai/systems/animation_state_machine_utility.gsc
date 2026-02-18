/**********************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\animation_state_machine_utility.gsc
**********************************************************************/

#namespace animationstatenetworkutility;

function requeststate(entity, statename) {
  assert(isDefined(entity));
  entity asmrequestsubstate(statename);
}

function searchanimationmap(entity, aliasname) {
  if(isDefined(entity) && isDefined(aliasname)) {
    animationname = entity animmappingsearch(aliasname);
    return animationname;
  }
}