/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_26f456dbdf9aa216.gsc
*****************************************************/

#using scripts\asm\gesture;
#namespace namespace_7e6e4b4ee3dc551c;

function function_8540bf644f70b69a(statename, params) {
  id = self getinteractionid();

  if(params.size == 1) {
    thread gesture::ai_request_gesture(params[0], undefined, undefined, "\xd7\xd8\xae\xb6\x0ea\xab");
    return;
  }

  if(params.size == 2) {
    thread gesture::ai_request_gesture(params[0], params[1], undefined, "\xd7\xd8\xae\xb6\x0ea\xab");
    return;
  }

  if(params.size == 3) {
    thread gesture::ai_request_gesture(params[0], params[1], params[2], "\xd7\xd8\xae\xb6\x0ea\xab");
    return;
  }

  if(params.size == 4) {
    thread gesture::ai_request_gesture(params[0], params[1], params[2], params[3]);
    return;
  }

  assertmsg("<dev string:x24>" + params.size + "<dev string:x67>");
}