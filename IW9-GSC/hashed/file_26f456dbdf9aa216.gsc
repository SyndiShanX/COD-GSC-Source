/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_26f456dbdf9aa216.gsc
***********************************************/

_id_5AD32AB5F21DDF93(statename, params) {
  id = self _meth_92435C7A6AE85C3C();

  if(params.size == 1)
    thread scripts\asm\gesture::ai_request_gesture(params[0], undefined, undefined, "gesture");
  else if(params.size == 2)
    thread scripts\asm\gesture::ai_request_gesture(params[0], params[1], undefined, "gesture");
  else if(params.size == 3)
    thread scripts\asm\gesture::ai_request_gesture(params[0], params[1], params[2], "gesture");
  else if(params.size == 4)
    thread scripts\asm\gesture::ai_request_gesture(params[0], params[1], params[2], params[3]);
  else {}
}