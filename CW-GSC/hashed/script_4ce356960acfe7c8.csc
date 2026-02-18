/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4ce356960acfe7c8.csc
***********************************************/

#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_81245006;

function private autoexec __init__system__() {
  system::register(#"hash_130a49b747d3bf82", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!sessionmodeiszombiesgame()) {
    return;
  }

  for(i = 0; i < 6; i++) {
    clientfield::register("actor", "" + # "weakpoint_state" + i, 1, 1, "int", &function_9c1a4204, 0, 0);
    clientfield::register("actor", "" + # "weakpoint_fx" + i, 1, 1, "counter", &function_e5efcc39, 0, 0);
  }

  ai::add_ai_spawn_function(&initweakpoints);
}

function function_9c1a4204(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(binitialsnap);

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.var_5ace757d)) {
    return;
  }

  foreach(var_dd54fdb1 in self.var_5ace757d) {
    if(var_dd54fdb1.var_ee8794bf == bwastimejump) {
      function_6c64ebd3(binitialsnap, var_dd54fdb1, fieldname == 1 ? 1 : 2);
      break;
    }
  }
}

function function_e5efcc39(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.var_5ace757d)) {
    return;
  }

  foreach(var_dd54fdb1 in self.var_5ace757d) {
    if(var_dd54fdb1.var_98634dc5 == bwastimejump) {
      function_239993de(fieldname, var_dd54fdb1.hitfx, self, var_dd54fdb1.var_6fb74226);
      break;
    }
  }
}

function initweakpoints() {
  entity = self;

  if(!isDefined(self.aitype)) {
    return;
  }

  var_97e1b97d = function_768b9c03(self.aitype);

  if(!isDefined(var_97e1b97d)) {
    return;
  }

  var_5ace757d = getscriptbundle(var_97e1b97d);

  if(!isDefined(var_5ace757d) || !isDefined(var_5ace757d.weakpoints) || !isDefined(var_5ace757d.var_8009bee)) {
    return;
  }

  entity.var_5ace757d = [];
  clientfield_index = 0;

  foreach(var_8cc382e6 in var_5ace757d.var_8009bee) {
    if(!isDefined(var_8cc382e6.var_4aa216c9) || !isDefined(var_8cc382e6.weakpoint)) {
      continue;
    }

    entity.var_5ace757d[entity.var_5ace757d.size] = {
      #var_ee8794bf: "" + # "weakpoint_state" + clientfield_index, #var_98634dc5: "" + # "weakpoint_fx" + clientfield_index, #hitfx: var_8cc382e6.var_4aa216c9, #var_6fb74226: var_8cc382e6.fxtag, #var_47b606f3: function_aed4cd9e(var_8cc382e6), #currstate: 2
    };
    clientfield_index++;
  }
}

function function_aed4cd9e(var_dd54fdb1) {
  var_47b606f3 = [];

  foreach(var_91e65f92 in var_dd54fdb1.var_47b606f3) {
    var_47b606f3[var_47b606f3.size] = var_91e65f92.tag;
  }

  return var_47b606f3;
}

function function_6c64ebd3(localclientnum, var_dd54fdb1, state) {
  var_dd54fdb1.currstate = state;

  if(var_dd54fdb1.currstate == 1) {
    foreach(tag in var_dd54fdb1.var_47b606f3) {
      self function_f1f85b1d(localclientnum, tag, 0);
    }

    return;
  }

  foreach(tag in var_dd54fdb1.var_47b606f3) {
    self function_f1f85b1d(localclientnum, tag, 1);
  }
}