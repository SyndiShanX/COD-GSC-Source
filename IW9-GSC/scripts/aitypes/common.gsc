/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\common.gsc
***********************************************/

returnsuccessiftrue(_id_B8EBE3F71A08AB40, params) {
  if(params == 1)
    return anim.success;

  return anim.failure;
}

isvariabledefined(_id_B8EBE3F71A08AB40, params) {
  if(isDefined(params))
    return anim.success;

  return anim.failure;
}

setupwait(taskid, params) {
  self.bt.instancedata[taskid] = [];
  self.bt.instancedata[taskid]["waitStartTime"] = gettime();
}

dowait(taskid, params) {
  starttime = self.bt.instancedata[taskid]["waitStartTime"];

  if(gettime() - starttime < params)
    return anim.running;

  return anim.success;
}

haslos(_id_B8EBE3F71A08AB40, params) {
  _id_CC2828DA32453F24 = params;

  if(self cansee(_id_CC2828DA32453F24))
    return anim.success;

  return anim.failure;
}

valuewithinrange(_id_B8EBE3F71A08AB40, params) {
  val = params[0];
  min = params[1];
  max = params[2];

  if(min <= val && val <= max)
    return anim.success;

  return anim.failure;
}

randchance(_id_B8EBE3F71A08AB40, params) {
  range = params[0];
  _id_181FC9F20D29A00F = params[1];

  if(randomint(range) < _id_181FC9F20D29A00F)
    return anim.success;

  return anim.failure;
}

cointoss(_id_B8EBE3F71A08AB40) {
  if(randomint(100) < 50)
    return anim.success;

  return anim.failure;
}

ifisalive(_id_B8EBE3F71A08AB40, params) {
  if(isDefined(params))
    ent = params;
  else
    ent = self;

  return isalive(ent);
}

ifselfdestruct(_id_B8EBE3F71A08AB40) {
  if(scripts\asm\asm_bb::bb_isselfdestruct())
    return anim.success;

  return anim.failure;
}