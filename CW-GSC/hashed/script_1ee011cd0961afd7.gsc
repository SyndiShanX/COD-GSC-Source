/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1ee011cd0961afd7.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1b9c0b4f8da07fee;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_40f967ad5d18ea74;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_83eb6304;

function init() {
  level.doa.var_11c4dca4 = [];
  clientfield::register("scriptmover", "play_fx", 1, 8, "int");
  clientfield::register("allplayers", "play_fx", 1, 8, "int");
  clientfield::register("actor", "play_fx", 1, 8, "int");
  clientfield::register("vehicle", "play_fx", 1, 8, "int");
  clientfield::register("scriptmover", "stop_fx", 1, 8, "int");
  clientfield::register("allplayers", "stop_fx", 1, 8, "int");
  clientfield::register("actor", "stop_fx", 1, 8, "int");
  clientfield::register("vehicle", "stop_fx", 1, 8, "int");
  namespace_7e1ec234::function_10d1200d();
}

function function_4060ccb4(name, unused1, var_f80dfd0d, unused2, var_26f1324c = 0) {
  var_318e5b78 = level.doa.var_11c4dca4.size;
  assert(var_318e5b78 < 256, "<dev string:x38>");
  assert(!isDefined(level.doa.var_11c4dca4[unused2]), "<dev string:x55>");
  level.doa.var_11c4dca4[unused2] = {
    #name: unused2, #id: var_318e5b78, #clear: var_26f1324c
  };
}

function function_13be6e83(&queue) {
  var_f53e8844 = 20;
  var_dcf59f7c = 0;

  while(var_f53e8844 > 0) {
    if(!isDefined(self)) {
      return;
    }

    if(queue.size > 0) {
      var_9e787c74 = queue[0];

      if(queue.size > var_dcf59f7c) {
        var_dcf59f7c = queue.size;
      }

      if(gettime() === self.birthtime) {
        waitframe(1);
      }

      if(!isDefined(self)) {
        return;
      }

      self clientfield::set(var_9e787c74.flag, var_9e787c74.fx.id);
      util::wait_network_frame();

      if(!isDefined(self)) {
        return;
      }

      if(var_9e787c74.fx.clear) {
        self clientfield::set(var_9e787c74.flag, 0);
        util::wait_network_frame();
      }

      arrayremoveindex(queue, 0, 0);
    } else {
      self clientfield::set("play_fx", 0);
      self clientfield::set("stop_fx", 0);
      waitframe(1);
      var_f53e8844--;
    }

    if(queue.size > 0) {
      var_f53e8844 = 20;
    }
  }

  if(!isDefined(self)) {
    return;
  }

  assert(queue.size == 0);
  self clientfield::set("play_fx", 0);
  self clientfield::set("stop_fx", 0);
}

function function_dd47bd22(fxcmd) {
  assert(isDefined(fxcmd), "<dev string:x70>");

  if(!isDefined(fxcmd)) {
    return;
  }

  self notify("245ebdee8b7ffcce");
  self endon("245ebdee8b7ffcce");
  self endon(#"disconnect", #"death");

  if(!isDefined(self.var_93d7fb93)) {
    self.var_93d7fb93 = [];
  }

  if(!isDefined(self.var_93d7fb93)) {
    self.var_93d7fb93 = [];
  } else if(!isarray(self.var_93d7fb93)) {
    self.var_93d7fb93 = array(self.var_93d7fb93);
  }

  self.var_93d7fb93[self.var_93d7fb93.size] = fxcmd;
  self function_13be6e83(self.var_93d7fb93);
  self.var_93d7fb93 = undefined;
}

function function_8a1f8325() {
  self endon(#"death");

  while(isDefined(self.var_93d7fb93) && self.var_93d7fb93.size > 0) {
    util::wait_network_frame();
  }
}

function turnofffx(name) {
  if(!isDefined(name) || !isDefined(self)) {
    return;
  }

  if(!isDefined(level.doa.var_11c4dca4[name])) {
    namespace_1e25ad94::debugmsg("FX OFF ERROR for entity [" + (isDefined(self.entnum) ? self.entnum : self getentitynumber()) + "] effect UNDFINED--> [" + name + "] ");
    return;
  }

  fxcmd = {
    #fx: level.doa.var_11c4dca4[name], #flag: "stop_fx"};

  if(!isDefined(self.var_93d7fb93)) {
    self thread function_dd47bd22(fxcmd);
  } else {
    if(!isDefined(self.var_93d7fb93)) {
      self.var_93d7fb93 = [];
    } else if(!isarray(self.var_93d7fb93)) {
      self.var_93d7fb93 = array(self.var_93d7fb93);
    }

    self.var_93d7fb93[self.var_93d7fb93.size] = fxcmd;
  }

  assert(self.var_93d7fb93.size < 60, "<dev string:x83>" + name);
}

function function_3ecfde67(name) {
  if(!isDefined(name) || !isDefined(self)) {
    return;
  }

  if(!isDefined(level.doa.var_11c4dca4[name])) {
    namespace_1e25ad94::debugmsg("FX ON ERROR for entity [" + (isDefined(self.entnum) ? self.entnum : self getentitynumber()) + "] effect UNDFINED--> [" + name + "] ");
    return;
  }

  fxcmd = {
    #fx: level.doa.var_11c4dca4[name], #flag: "play_fx"};

  if(!isDefined(self.var_93d7fb93)) {
    self thread function_dd47bd22(fxcmd);
  } else {
    if(!isDefined(self.var_93d7fb93)) {
      self.var_93d7fb93 = [];
    } else if(!isarray(self.var_93d7fb93)) {
      self.var_93d7fb93 = array(self.var_93d7fb93);
    }

    self.var_93d7fb93[self.var_93d7fb93.size] = fxcmd;
  }

  if(self.var_93d7fb93.size >= 60) {
    i = 1;

    foreach(var_9e787c74 in self.var_93d7fb93) {
      namespace_1e25ad94::debugmsg("<dev string:xab>" + (isDefined(self.entnum) ? self.entnum : self getentitynumber()) + "<dev string:xc4>" + i + "<dev string:xd3>" + var_9e787c74.fx.name + "<dev string:xda>");
      i++;
    }
  }

  assert(self.var_93d7fb93.size < 60, "<dev string:x83>" + name);
}

function function_8b4b9bdd() {
  self callback::on_death(&function_de09b352);
}

function function_de09b352(eventstruct) {
  if(isDefined(eventstruct.corpse)) {
    eventstruct.corpse function_3ecfde67("burn_zombie");
  }
}