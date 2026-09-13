/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_67e2c9bd89ed9289.gsc
***********************************************/

_id_683C095E6767C4C8(_id_D8EAD19C14184DEC, _id_3777ECE6A73EADA5, _id_070E8A85177297C1) {
  level endon("game_ended");
  self endon("disconnect");

  while(!_id_B69898678ED4466D(_id_D8EAD19C14184DEC, _id_3777ECE6A73EADA5))
    waitframe();

  if(isDefined(_id_070E8A85177297C1))
    self[[_id_070E8A85177297C1]]();
}

_id_ED838558EF4E4E91(entity, _id_3777ECE6A73EADA5, mindistance) {
  return _id_B69898678ED4466D(entity.origin, _id_3777ECE6A73EADA5, mindistance);
}

_id_B69898678ED4466D(position, _id_3777ECE6A73EADA5, mindistance) {
  if(isDefined(mindistance) && distance2d(self.origin, position) > mindistance)
    return 0;

  forward = anglesToForward(self getplayerangles(0));
  _id_840ACC643EEB4984 = vectorNormalize(position - self getEye());
  return scripts\engine\math::anglebetweenvectorsunit(forward, _id_840ACC643EEB4984) <= _id_3777ECE6A73EADA5;
}