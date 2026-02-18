/*************************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\animation_state_machine_notetracks.gsc
*************************************************************************/

#namespace animationstatenetwork;

function autoexec initnotetrackhandler() {
  level._notetrack_handler = [];
}

function private event_handler[runnotetrackhandler] runnotetrackhandler(eventstruct) {
  assert(isarray(eventstruct.notetracks));

  for(index = 0; index < eventstruct.notetracks.size; index++) {
    handlenotetrack(eventstruct.entity, eventstruct.notetracks[index]);
  }
}

function private handlenotetrack(entity, notetrack) {
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

function registernotetrackhandlerfunction(notetrackname, notetrackfuncptr) {
  assert(isstring(notetrackname), "<dev string:x38>");
  assert(isfunctionptr(notetrackfuncptr), "<dev string:x74>");
  assert(!isDefined(level._notetrack_handler[notetrackname]), "<dev string:xbf>" + notetrackname + "<dev string:xe5>");
  level._notetrack_handler[notetrackname] = notetrackfuncptr;
}

function registerblackboardnotetrackhandler(notetrackname, blackboardattributename, blackboardvalue) {
  notetrackhandler = spawnStruct();
  notetrackhandler.blackboardattributename = blackboardattributename;
  notetrackhandler.blackboardvalue = blackboardvalue;
  level._notetrack_handler[notetrackname] = notetrackhandler;
}