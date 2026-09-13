/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_53aac5ae7d2ac1b4.gsc
***********************************************/

_id_773691F1A617F7D9(origin) {
  forward = anglesToForward(self.angles);
  up = anglestoup(self.angles);
  _id_A011729D000A28D2 = origin - self.origin;
  _id_B6F39E71200FE477 = _func_D559A384B9C4E7D9(origin, self.origin, self.angles);
  _id_F945F5534FFEDF42 = _id_B6F39E71200FE477[0];
  _id_B383C5F0357008AE = _id_B6F39E71200FE477[1];
  _id_74DA97EBCA1BA2E7 = _id_B6F39E71200FE477[2];
  _id_9AA67BDF5007E363 = _id_F945F5534FFEDF42 > -225 && _id_F945F5534FFEDF42 < 225;
  _id_91678D915537FE2D = _id_B383C5F0357008AE > -60 && _id_B383C5F0357008AE < 60;
  _id_CBB36D65C8C53644 = _id_74DA97EBCA1BA2E7 > -235 && _id_74DA97EBCA1BA2E7 < -25;
  return _id_9AA67BDF5007E363 && _id_91678D915537FE2D && _id_CBB36D65C8C53644;
}