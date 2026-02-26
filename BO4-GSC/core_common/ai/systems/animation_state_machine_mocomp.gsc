/*********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\animation_state_machine_mocomp.gsc
*********************************************************************/

#namespace animationstatenetwork;

autoexec initanimationmocomps() {
  level._animationmocomps = [];
}

event_handler[runanimationmocomp] runanimationmocomp(eventstruct) {
  assert(eventstruct.status >= 0 && eventstruct.status <= 2, "<dev string:x38>" + eventstruct.status + "<dev string:x5a>");
  assert(isDefined(level._animationmocomps[eventstruct.name]), "<dev string:x75>" + eventstruct.name + "<dev string:x9b>");

  if(eventstruct.status == 0) {
    eventstruct.status = "asm_mocomp_start";
  } else if(eventstruct.status == 1) {
    eventstruct.status = "asm_mocomp_update";
  } else {
    eventstruct.status = "asm_mocomp_terminate";
  }

  animationmocompresult = eventstruct.entity[[level._animationmocomps[eventstruct.name][eventstruct.status]]](eventstruct.entity, eventstruct.delta_anim, eventstruct.blend_out_time, "", eventstruct.duration);
  return animationmocompresult;
}

registeranimationmocomp(mocompname, startfuncptr, updatefuncptr, terminatefuncptr) {
  mocompname = tolower(mocompname);
  assert(isstring(mocompname), "<dev string:xaf>");
  assert(!isDefined(level._animationmocomps[mocompname]), "<dev string:xf0>" + mocompname + "<dev string:x104>");
  level._animationmocomps[mocompname] = array();
  assert(isDefined(startfuncptr) && isfunctionptr(startfuncptr), "<dev string:x11e>");
  level._animationmocomps[mocompname][#"asm_mocomp_start"] = startfuncptr;

  if(isDefined(updatefuncptr)) {
    assert(isfunctionptr(updatefuncptr), "<dev string:x17d>");
    level._animationmocomps[mocompname][#"asm_mocomp_update"] = updatefuncptr;
  } else {
    level._animationmocomps[mocompname][#"asm_mocomp_update"] = &animationmocompemptyfunc;
  }

  if(isDefined(terminatefuncptr)) {
    assert(isfunctionptr(terminatefuncptr), "<dev string:x1d9>");
    level._animationmocomps[mocompname][#"asm_mocomp_terminate"] = terminatefuncptr;
    return;
  }

  level._animationmocomps[mocompname][#"asm_mocomp_terminate"] = &animationmocompemptyfunc;
}

animationmocompemptyfunc(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {}