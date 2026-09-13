/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2178ff9c3f4f4f8b.gsc
***********************************************/

_id_9CA6FDFF29CB3A3C() {
  triggers = [];
  triggers["hunk_85316436"] = ::_id_4FCA949501CCFB87;
  triggers["hunk_6D885125"] = ::_id_A6F0A183B211222B;
  triggers["hunk_CFBEB0C3"] = ::_id_8852D7A2B07F0447;
  return triggers;
}

_id_A6F0A183B211222B(_id_B92F1CF567538EEE) {
  return isDefined(self.br_infil_type) && self.br_infil_type == "c130" && scripts\mp\flags::gameflag("br_ready_to_jump");
}

_id_4FCA949501CCFB87(_id_B92F1CF567538EEE) {
  return scripts\mp\flags::gameflag("prematch_done");
}

_id_8852D7A2B07F0447(_id_B92F1CF567538EEE) {
  if(distance2d(self.origin, _id_B92F1CF567538EEE._id_9F3256AA0DB81EA4) <= _id_B92F1CF567538EEE.triggerdistance)
    return 1;

  return 0;
}