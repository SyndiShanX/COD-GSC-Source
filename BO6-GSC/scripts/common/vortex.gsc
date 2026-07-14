/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\vortex.gsc
**************************************/

#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\values;
#using scripts\engine\trace;
#namespace vortex;

function function_fa01e0266f8127e3(vortex_mode, priority) {
  if(!isDefined(level.vortex_priority)) {
    level.vortex_priority = [];
  }

  level.vortex_priority[vortex_mode] = priority;
}

function is_pulled() {
  return istrue(self._blackboard.vortexispulled);
}

function function_efc8979c4099dfc5(vortex_mode, source) {
  if(isDefined(self.vortex_state) && self.vortex_state.size > 0) {
    active_vortex = self.vortex_state[0];

    if(active_vortex.mode == vortex_mode && active_vortex.source === source) {
      return istrue(self._blackboard.var_6fe6e5c22aebde1d);
    }
  }

  return false;
}

function private function_6735796ac4691c5c(vortex_state, is_new) {
  if(!is_pulled()) {
    val::set("0\xd2#\x95\xc8[~\xff\xab\x96\xa6", "\x0e\xefW\xc9+R\xe5\x95\a4\xcf\xd7D4\xe6\xbe8\x85\xe0");
    val::set("0\xd2#\x95\xc8[~\xff\xab\x96\xa6", "9\xff\x85\xc7\xc3\xb4\xa8\xd7p\xb3\x11\x82\xa7/\xd8\x1c\xb2\xc2");
    val::set("0\xd2#\x95\xc8[~\xff\xab\x96\xa6", "\xf8\xec\x9b+\xacL\x0f\xe1\xfe6]\xda\xa9");
  }

  self._blackboard.vortexpullorigin = vortex_state.pull_origin;
  self._blackboard.var_175efb1081edf7b = vortex_state.death_range;
  self._blackboard.vortexmode = vortex_state.mode;
  self._blackboard.vortexispulled = 1;

  if(is_new) {
    self notify("\x05\xe7\x13\x05\xfb:\r\x8b\xf4\xf5\xf3\xcf\xad*\xc0_\xfb#");
    callback::callback("\xde\xcd\xbeg\xed\x9c:\xacx\xbep]c\xb1\xd76\r\x857v\x952", vortex_state.callback_payload);
    return;
  }

  callback::callback(";\x1c\x7f\x95~\xb1\xc7\xfe\\\x98n\xfbJ\x97\xbe|Z\xbd\x99\xd0\xafh", vortex_state.callback_payload);
}

function private function_5c516f41257ab76f(has_transition) {
  val::reset_all("0\xd2#\x95\xc8[~\xff\xab\x96\xa6");
  self._blackboard.vortexispulled = 0;

  if(istrue(has_transition) && isDefined(archetypegetaliases(self.animsetname, "o\xbeQr\xc7u\xa6\xf8\xfbn\xf0\xe7Nu\xd8\xf4\xa7"))) {
    self function_5b307148e3debcfc("\xfe\xd7\xcci`\v>\x8e\xdb3bd_\xac\xbf\xab*", 1);
  } else {
    self._blackboard.vortexmode = undefined;
  }

  callback::callback("\xf1\x87\t^\xdf\x92\xc1\xc9I\xbf\xbc\xbas\x05\\\xc3\xc4\xa3\x1d^");
}

function function_23773cfafe8d558f(vortex_mode) {
  vortex_count = 0;

  if(isDefined(self.vortex_state)) {
    foreach(vortex_state in self.vortex_state) {
      if(vortex_state.mode == vortex_mode) {
        vortex_count++;
      }
    }
  }

  return vortex_count;
}

function function_9aa1eaa279099487(vortex_mode, source, vortex_origin, var_8ef1ab45219a50cf, callback_payload) {
  if(!isDefined(self.vortex_state)) {
    self.vortex_state = [];
  }

  assert(!isent(source), "<dev string:x24>");

  if(!isDefined(var_8ef1ab45219a50cf)) {
    var_8ef1ab45219a50cf = 0;
  }

  vortex_priority = level.vortex_priority[vortex_mode] ?? 0;
  new_vortex = 1;

  for(vortex_index = 0; vortex_index < self.vortex_state.size; vortex_index++) {
    vortex_state = self.vortex_state[vortex_index];

    if(vortex_state.mode == vortex_mode && vortex_state.source === source) {
      vortex_state.pull_origin = vortex_origin;
      vortex_state.death_range = var_8ef1ab45219a50cf;
      vortex_state.callback_payload = callback_payload;
      new_vortex = 0;
      break;
    }

    if(vortex_priority > (level.vortex_priority[vortex_state.mode] ?? 0)) {
      for(i = self.vortex_state.size; i > vortex_index; i--) {
        self.vortex_state[i] = self.vortex_state[i - 1];
      }

      break;
    }
  }

  if(new_vortex) {
    vortex_state = {};
    vortex_state.pull_origin = vortex_origin;
    vortex_state.death_range = var_8ef1ab45219a50cf;
    vortex_state.mode = vortex_mode;
    vortex_state.source = source;
    vortex_state.callback_payload = callback_payload;
    self.vortex_state[vortex_index] = vortex_state;
  }

  if(vortex_index == 0) {
    function_6735796ac4691c5c(vortex_state, new_vortex);
  }

  return new_vortex;
}

function function_2f4a0f548b936d00(vortex_mode, source, has_transition) {
  if(isDefined(self.vortex_state)) {
    for(vortex_index = 0; vortex_index < self.vortex_state.size; vortex_index++) {
      vortex_state = self.vortex_state[vortex_index];

      if(vortex_state.mode == vortex_mode && vortex_state.source === source) {
        for(i = vortex_index; i < self.vortex_state.size - 1; i++) {
          self.vortex_state[i] = self.vortex_state[i + 1];
        }

        self.vortex_state[self.vortex_state.size - 1] = undefined;

        if(vortex_index == 0) {
          if(self.vortex_state.size > 0) {
            function_6735796ac4691c5c(self.vortex_state[0], 1);
          } else {
            function_5c516f41257ab76f(has_transition);
            self.vortex_state = undefined;
          }
        }

        return true;
      }
    }
  }

  return false;
}

function function_3bf75a144a50fdd8() {
  thread function_c5658d3e7293248a();
}

function private is_traversing() {
  return ai::function_ee346cd5492bbf05(self);
}

function private function_c5658d3e7293248a() {
  self notify("\xa1\xc3\xdd\xd5p\xcf\xdd\xa1\x81\x9fc\xb8\xd1_f\xaf");
  self endon("\xa1\xc3\xdd\xd5p\xcf\xdd\xa1\x81\x9fc\xb8\xd1_f\xaf");
  self endon("\x1e\xfd\xd1\xa2\a");

  while(is_pulled()) {
    var_57d50b27fc7cb687 = is_traversing() && istrue(self._blackboard.var_50912197674599de);
    var_fb47c58216c7cfc9 = istrue(self._blackboard.var_cab0d8de1ae3a601);

    if(var_57d50b27fc7cb687 || var_fb47c58216c7cfc9) {
      pull_origin = self._blackboard.vortexpullorigin + 5 * (0, 0, 1);
      pull_trace = physics_raycast(self.origin, pull_origin, trace::create_world_contents(), [self], 0, "\x15\xac\x15z\xf1\xed\a\x06BQ,a]\xfb\x1d\xa4e9\xcft");

      if(!isDefined(pull_trace[0][")\x9a\x94]\xee}s"])) {
        forward_vec = vectorNormalize(pull_origin - self.origin);
        right_vec = vectorcross(forward_vec, (0, 0, 1));
        up_vec = vectorcross(right_vec, forward_vec);
        pull_angles = axistoangles(forward_vec, right_vec, up_vec);
        self.var_4f23d3df01c3d403 = pull_angles;

        if(var_57d50b27fc7cb687) {
          asm::asm_fireevent(self.asmname, "\xdd\xc2l6\xbe\xd8N\xc2\xee\x8d_Z\xb9\xa3+\xe4rW\x1c:");
        }
      }
    }

    wait 0.25;
  }
}