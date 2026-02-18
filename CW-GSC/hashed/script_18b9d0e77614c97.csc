/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_18b9d0e77614c97.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#namespace streamer;

function function_d46dcfc2(var_74f025c6, var_11a76757, var_352bdb5f, var_45269c45) {
  if(!isDefined(level.var_80747947)) {
    level.var_80747947 = [];
  }

  level.var_80747947[var_74f025c6] = {
    #var_11a76757: var_11a76757, #var_352bdb5f: var_352bdb5f, #var_45269c45: var_45269c45
  };
  assert(!level flag::get(var_74f025c6));
  [[level.var_80747947[var_74f025c6].var_45269c45]]();
}

function force_stream(var_74f025c6) {
  level flag::increment(var_74f025c6);
  [[level.var_80747947[var_74f025c6].var_352bdb5f]]();
  self.var_74f025c6 = var_74f025c6;
  self callback::on_shutdown(&on_shutdown);
}

function private on_shutdown(localclientnum) {
  if(!isDefined(self.var_74f025c6)) {
    return;
  }

  level flag::decrement(self.var_74f025c6);

  if(!level flag::get(self.var_74f025c6)) {
    [[level.var_80747947[self.var_74f025c6].var_45269c45]]();
    function_121f6fcf(level.var_80747947[self.var_74f025c6].var_11a76757);
  }
}

function private function_121f6fcf(var_11a76757) {
  if(!isDefined(level.var_80747947)) {
    return;
  }

  foreach(var_74f025c6, entry in level.var_80747947) {
    if(var_11a76757 &entry.var_11a76757 == 0) {
      continue;
    }

    if(level flag::get(var_74f025c6)) {
      [[entry.var_352bdb5f]]();
    }
  }
}