/*************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\animation_state_machine_notetracks.gsc
*************************************************************************/

#namespace animationstatenetwork;

autoexec initnotetrackhandler() {
  level._notetrack_handler = [];
}

private event_handler[runnotetrackhandler] runnotetrackhandler(eventstruct) {
  assert(isarray(eventstruct.notetracks));

  for(index = 0; index < eventstruct.notetracks.size; index++) {
    handlenotetrack(eventstruct.entity, eventstruct.notetracks[index]);
  }
}

private handlenotetrack(entity, notetrack) {
  notetrackhandler = level._notetrack_handler[notetrack];

  if(!isDefined(notetrackhandler)) {
    return;
  }

  if(isfunctionptr(notetrackhandler)) {
    [[notetrackhandler]](entity);
    return;
  }

  entity setblackboardattribute(notetrackhandler.blackboardattributename, notetrackhandler.blackboardvalue);
}

registernotetrackhandlerfunction(notetrackname, notetrackfuncptr) {
  assert(isstring(notetrackname), "<dev string:x38>");
  assert(isfunctionptr(notetrackfuncptr), "<dev string:x73>");
  assert(!isDefined(level._notetrack_handler[notetrackname]), "<dev string:xbd>" + notetrackname + "<dev string:xe2>");
  level._notetrack_handler[notetrackname] = notetrackfuncptr;
}

registerblackboardnotetrackhandler(notetrackname, blackboardattributename, blackboardvalue) {
  notetrackhandler = spawnStruct();
  notetrackhandler.blackboardattributename = blackboardattributename;
  notetrackhandler.blackboardvalue = blackboardvalue;
  level._notetrack_handler[notetrackname] = notetrackhandler;
}