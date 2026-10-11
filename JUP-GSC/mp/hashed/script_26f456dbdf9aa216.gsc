/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_26f456dbdf9aa216.gsc
*************************************************/

#using scripts\aitypes\bt_util;
#using scripts\asm\gesture;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_cbce62193111f79;

function function_5ad32ab5f21ddf93(statename, params) {
  id = self getinteractionid();

  if(params.size == 1) {
    thread scripts\asm\gesture::ai_request_gesture(params[0], undefined, undefined, "gesture");
    return;
  }

  if(params.size == 2) {
    thread scripts\asm\gesture::ai_request_gesture(params[0], params[1], undefined, "gesture");
    return;
  }

  if(params.size == 3) {
    thread scripts\asm\gesture::ai_request_gesture(params[0], params[1], params[2], "gesture");
    return;
  }

  if(params.size == 4) {
    thread scripts\asm\gesture::ai_request_gesture(params[0], params[1], params[2], params[3]);
    return;
  }

  assertmsg("<dev string:x1c>" + params.size + "<dev string:x5f>");
}