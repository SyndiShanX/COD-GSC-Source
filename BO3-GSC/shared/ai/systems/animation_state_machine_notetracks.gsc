/********************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\animation_state_machine_notetracks.gsc
********************************************************************/

#using scripts\shared\ai\systems\blackboard;
#namespace animationstatenetwork;

function autoexec initnotetrackhandler() {
  level._notetrack_handler = [];
}

function private runnotetrackhandler(entity, notetracks) {
  assert(isarray(notetracks));
  for (index = 0; index < notetracks.size; index++) {
    handlenotetrack(entity, notetracks[index]);
  }
}

function private handlenotetrack(entity, notetrack) {
  notetrackhandler = level._notetrack_handler[notetrack];
  if(!isdefined(notetrackhandler)) {
    return;
  }
  if(isfunctionptr(notetrackhandler)) {
    [
      [notetrackhandler]
    ](entity);
  } else {
    blackboard::setblackboardattribute(entity, notetrackhandler.blackboardattributename, notetrackhandler.blackboardvalue);
  }
}

function registernotetrackhandlerfunction(notetrackname, notetrackfuncptr) {
  assert(isstring(notetrackname), "");
  assert(isfunctionptr(notetrackfuncptr), "");
  assert(!isdefined(level._notetrack_handler[notetrackname]), ("" + notetrackname) + "");
  level._notetrack_handler[notetrackname] = notetrackfuncptr;
}

function registerblackboardnotetrackhandler(notetrackname, blackboardattributename, blackboardvalue) {
  notetrackhandler = spawnstruct();
  notetrackhandler.blackboardattributename = blackboardattributename;
  notetrackhandler.blackboardvalue = blackboardvalue;
  level._notetrack_handler[notetrackname] = notetrackhandler;
}