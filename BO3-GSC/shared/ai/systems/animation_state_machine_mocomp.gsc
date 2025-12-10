/****************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\animation_state_machine_mocomp.gsc
****************************************************************/

#namespace animationstatenetwork;

function autoexec initanimationmocomps() {
  level._animationmocomps = [];
}

function runanimationmocomp(mocompname, mocompstatus, asmentity, mocompanim, mocompanimblendouttime, mocompduration) {
  assert(mocompstatus >= 0 && mocompstatus <= 2, ("" + mocompstatus) + "");
  assert(isDefined(level._animationmocomps[mocompname]), ("" + mocompname) + "");
  if(mocompstatus == 0) {
    mocompstatus = "asm_mocomp_start";
  } else {
    if(mocompstatus == 1) {
      mocompstatus = "asm_mocomp_update";
    } else {
      mocompstatus = "asm_mocomp_terminate";
    }
  }
  animationmocompresult = asmentity[[level._animationmocomps[mocompname][mocompstatus]]](asmentity, mocompanim, mocompanimblendouttime, "", mocompduration);
  return animationmocompresult;
}

function registeranimationmocomp(mocompname, startfuncptr, updatefuncptr, terminatefuncptr) {
  mocompname = tolower(mocompname);
  assert(isstring(mocompname), "");
  assert(!isDefined(level._animationmocomps[mocompname]), ("" + mocompname) + "");
  level._animationmocomps[mocompname] = array();
  assert(isDefined(startfuncptr) && isfunctionptr(startfuncptr), "");
  level._animationmocomps[mocompname]["asm_mocomp_start"] = startfuncptr;
  if(isDefined(updatefuncptr)) {
    assert(isfunctionptr(updatefuncptr), "");
    level._animationmocomps[mocompname]["asm_mocomp_update"] = updatefuncptr;
  } else {
    level._animationmocomps[mocompname]["asm_mocomp_update"] = &animationmocompemptyfunc;
  }
  if(isDefined(terminatefuncptr)) {
    assert(isfunctionptr(terminatefuncptr), "");
    level._animationmocomps[mocompname]["asm_mocomp_terminate"] = terminatefuncptr;
  } else {
    level._animationmocomps[mocompname]["asm_mocomp_terminate"] = &animationmocompemptyfunc;
  }
}

function animationmocompemptyfunc(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {}