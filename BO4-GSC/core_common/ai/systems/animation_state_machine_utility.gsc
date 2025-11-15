/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\animation_state_machine_utility.gsc
**********************************************************************/

#namespace animationstatenetworkutility;

requeststate(entity, statename) {
  assert(isDefined(entity));
  entity asmrequestsubstate(statename);
}

searchanimationmap(entity, aliasname) {
  if(isDefined(entity) && isDefined(aliasname)) {
    animationname = entity animmappingsearch(aliasname);
    return animationname;
  }
}