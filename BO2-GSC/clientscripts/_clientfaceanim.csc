/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_clientfaceanim.csc
*********************************************/

#include clientscripts\_utility;
#include clientscripts\_face_utility;
#include clientscripts\_clientfaceanim;

actor_facial_anim_flag_handler(localclientnum, set, newent) {
  if(set) {
    if(getdvarint(#"_id_B5C61264") != 0)
      println("*** SET flag face_disable - for ent " + self getentitynumber() + "[" + self.type + "]");

    self.face_disable = 1;
    self notify("face", "face_advance");
  } else {
    if(getdvarint(#"_id_B5C61264") != 0)
      println("*** CLEARED flag face_disable - for ent " + self getentitynumber() + "[" + self.type + "]");

    self.face_disable = 0;
    self notify("face", "face_advance");
  }
}

init_clientfaceanim() {
  register_clientflag_callback("actor", 1, ::actor_facial_anim_flag_handler);
  level._faceanimcbfunc = clientscripts\_clientfaceanim::doface;
}

doface(localclientnum) {
  if(self isplayer())
    return;
  else if(isDefined(level._facecbfunc_generichuman))
    self[[level._facecbfunc_generichuman]](localclientnum);
}