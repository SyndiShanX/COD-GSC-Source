/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\death.gsc
**************************************/

#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace anim_death;

function init_deathfx() {
  utility::add_fx("\xf0Q\xbcFz\x8a~i\x89D\xa0e\xc7O\xd0\x93\nf\xd0\xb7W\x9eiB ", "\x88\xcd\xc6\xdc\xda5q\xb0\x17Qw\x92L\xa9H\x04,>u6s\xf8\xd9\x86&h!\xd3\xc4>\xf3\xae{\xfd\xb7\x87\xf4\x91\xee");
}

function main() {
  self endon("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
  self waittill("\\\xe9 ,Z\x0e\xfb\xbf\xcb\xd3\xb6\xf2\x8e\xc0\x93");
}

function doimmediateragdolldeath() {
  assertmsg("<dev string:x24>");
}

function play_blood_pool(note, flagname) {
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.skipbloodpool)) {
    assert(self.skipbloodpool, "<dev string:x4f>");
    return;
  }

  tagpos = self gettagorigin("\xb8y\xa4\x8fk\x05b\x02(U\xe7\xf3");
  tagangles = self gettagangles("\xb8y\xa4\x8fk\x05b\x02(U\xe7\xf3");
  forward = anglesToForward(tagangles);
  up = anglestoup(tagangles);
  right = anglestoright(tagangles);
  tagpos = tagpos + forward * -8.5 + up * 5 + right * 0;
  trace = trace::_bullet_trace(tagpos + (0, 0, 30), tagpos - (0, 0, 100), 0, undefined);

  if(trace["+0a<s,"][2] > 0.9) {
    playFX(level._effect["\xf0Q\xbcFz\x8a~i\x89D\xa0e\xc7O\xd0\x93\nf\xd0\xb7W\x9eiB "], tagpos);
  }
}