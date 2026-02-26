/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\ui\prompts.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using script_37f9ff47f340fbe8;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\util;
#namespace prompts;

function private autoexec __init__system__() {
  system::register(#"prompts", &preload, undefined, undefined, undefined);
}

function private preload() {
  level.prompts[#"use"] = {
    #button_text: # "hash_5797cba717dc64d5", #var_92bb1cb1: &function_99bb5bbe, #var_9a98e590: &function_ab46a161, #notify_string: "trigger"};
  level.prompts[#"use_tap"] = {
    #button_action: # "hash_100ec99123fe5092", #button_text: # "hash_5797cba717dc64d5", #var_92bb1cb1: &function_99bb5bbe, #var_9a98e590: &function_ab46a161, #notify_string: "trigger"};
  level.prompts[#"melee"] = {
    #button_text: # "hash_18d0a7d5aff08dd8", #var_92bb1cb1: &function_99bb5bbe, #var_9a98e590: &function_ab46a161, #notify_string: "damage"};
  level.prompts[#"melee_hold"] = {
    #button_action: # "hash_2d1efe88663d0c48", #button_text: # "hash_18d0a7d5aff08dd8", #var_92bb1cb1: &function_99bb5bbe, #var_9a98e590: &function_ab46a161, #notify_string: "grab"};
  level.prompts[#"attack"] = {
    #button_text: # "hash_3c124085ee45de36", #var_92bb1cb1: &function_99bb5bbe, #var_9a98e590: &function_ab46a161, #notify_string: "attack"};
  level.prompts[#"reload"] = {
    #button_text: # "hash_27324f18b09b7a6d", #var_92bb1cb1: &function_99bb5bbe, #var_9a98e590: &function_ab46a161, #notify_string: "reload"};
  level.prompts[#"frag"] = {
    #button_text: # "hash_c7de853806860ce", #var_92bb1cb1: &function_99bb5bbe, #var_9a98e590: &function_ab46a161, #notify_string: "frag"};
  level.prompts[#"stance"] = {
    #button_text: # "hash_34ccc944003048fe", #var_92bb1cb1: &function_99bb5bbe, #var_9a98e590: &function_ab46a161, #notify_string: "stance", #var_b753c5a5: "BUTTON_BIT_ANY_DOWN"};
  level.prompts[#"weapnext"] = {
    #button_text: # "hash_4b3f0bed118eaaf1", #var_92bb1cb1: &function_99bb5bbe, #var_9a98e590: &function_ab46a161, #notify_string: "weapnext"};
  level.prompts[#"ads"] = {
    #button_text: # "hash_41f7ff5095b74d02", #var_92bb1cb1: &function_99bb5bbe, #var_9a98e590: &function_ab46a161, #notify_string: "aim"};
  level.prompts[#"vehicle_attack"] = {
    #button_text: # "hash_6a2aef10bb120a0d", #var_92bb1cb1: &function_99bb5bbe, #var_9a98e590: &function_ab46a161, #notify_string: "attack"};
  level.prompts[#"confirm"] = {
    #button_text: # "hash_686cc531969c8555", #var_92bb1cb1: &function_eee54dd8, #var_9a98e590: &function_ab46a161, #notify_string: "select", #var_e4c7b05f: # "hash_7179662091387b23"};
  level.prompts[#"cancel"] = {
    #button_text: # "hash_2ac0a4c8c1d0c8d", #var_92bb1cb1: &function_eee54dd8, #var_9a98e590: &function_ab46a161, #notify_string: "cancel", #var_e4c7b05f: # "hash_2eb2f3b39714ea5f"};
  level.prompts[#"alt1"] = {
    #button_text: # "hash_1fb4a5c9d34c7339", #var_92bb1cb1: &function_eee54dd8, #var_9a98e590: &function_ab46a161, #notify_string: "alt1", #var_e4c7b05f: # "hash_7179672091387cd6", #lui_button: 7, #var_b35ba5c: "MOUSE2"};
  level.prompts[#"alt2"] = {
    #button_text: # "hash_7b5f7a069d7cd3a", #var_92bb1cb1: &function_eee54dd8, #var_9a98e590: &function_ab46a161, #notify_string: "alt2", #var_e4c7b05f: # "hash_7179682091387e89", #lui_button: 8, #var_b35ba5c: "MOUSE3"};
  level.var_a8ea96e8 = [];
  level.var_6a7fb742 = &function_c97a48c7;
  level.var_a29d8d23 = &function_a4cf2cde;
  level.var_3626dfc = &remove;
  level.var_503dffcb = [];
  callback::on_spawned(&on_player_spawned);
  util::init_dvar("cg_cpMaxHoldDurationIgnore", 0, &function_5baa8d71);

  util::init_dvar("<dev string:x38>", 0, &function_db698ba5);
  util::init_dvar("<dev string:x4b>", 0, &function_db698ba5);
  util::init_dvar("<dev string:x62>", 0, &function_db698ba5);
  util::init_dvar("<dev string:x7e>", 0, &function_db698ba5);
  util::init_dvar("<dev string:x9b>", -1, &function_db698ba5);
  util::init_dvar("<dev string:xb3>", -1, &function_db698ba5);
  util::init_dvar("<dev string:xcc>", -1, &function_db698ba5);
  util::init_dvar("<dev string:xe7>", -1, &function_db698ba5);
  util::init_dvar("<dev string:x102>", 0, &function_db698ba5);
  util::init_dvar("<dev string:x113>", "<dev string:x132>", &function_db698ba5);
  util::init_dvar("<dev string:x136>", -1, &function_db698ba5);
  util::init_dvar("<dev string:x153>", -1, &function_db698ba5);
  util::init_dvar("<dev string:x171>", -1, &function_db698ba5);
  util::init_dvar("<dev string:x191>", -1, &function_db698ba5);
  util::init_dvar("<dev string:x1aa>", -1, &function_db698ba5);
}

function private function_5baa8d71(dvar) {
  level.var_503dffcb[dvar.name] = dvar.value;
}

function private function_db698ba5(dvar) {
  level.var_a48f9f79[dvar.name] = dvar.value;
}

function on_player_spawned() {
  self endon(#"death");

  if(!isDefined(self.var_b3c804a4)) {
    self.var_b3c804a4 = [];
  }

  time_interval = 1;
  var_f08f2050 = pow(528 * time_interval, 2);

  while(true) {
    last_pos = self.origin;
    wait time_interval;

    if(distancesquared(self.origin, last_pos) > var_f08f2050) {
      self notify(#"teleported");
    }
  }
}

function register(prompt, var_92bb1cb1, button_text, notify_string, var_9a98e590) {
  level.prompts[prompt] = {
    #button_text: button_text, #var_92bb1cb1: var_92bb1cb1, #var_9a98e590: var_9a98e590, #notify_string: notify_string
  };
}

function create(prompt = # "use", prompt_text, complete_callback, var_531201f1, notify_string, offset, tag, var_754bedbb, var_de6f0004, var_4ac77177, var_71b9f0c0, var_87c991f3, var_5e83875a, var_8ce60046, var_9a27c4ee, var_be77841a, flags, var_c9643122) {
  prompt_struct = {
    #prompt_text: prompt_text, #complete_callback: complete_callback, #var_531201f1: var_531201f1, #notify_string: notify_string, #offset: offset, #tag: tag, #var_754bedbb: var_754bedbb, #var_de6f0004: var_de6f0004, #var_4ac77177: var_4ac77177, #var_71b9f0c0: var_71b9f0c0, #var_87c991f3: var_87c991f3, #var_5e83875a: var_5e83875a, #var_8ce60046: var_8ce60046, #var_9a27c4ee: var_9a27c4ee, #var_be77841a: var_be77841a, #flags: flags, #var_c9643122: var_c9643122
  };
  self function_c97a48c7(prompt, prompt_struct);
}

function function_c97a48c7(prompt, prompt_struct) {
  assert(isDefined(prompt), "<dev string:x1c3>");
  assert(isDefined(level.prompts[prompt]), "<dev string:x208>");
  assert(isentity(self) || isstruct(self) && isDefined(self.origin) && isDefined(self.angles), "<dev string:x2b7>");
  self remove(prompt, 1);
  var_a23c5e1 = !isDefined(self.var_3e95b88f);

  if(!isDefined(self.var_3e95b88f)) {
    self.var_3e95b88f = {};
  }

  if(!isDefined(self.var_3e95b88f.prompts)) {
    self.var_3e95b88f.prompts = [];
  }

  if(!isDefined(self.var_3e95b88f.var_294a441e)) {
    self.var_3e95b88f.var_294a441e = [];
  }

  if(!isDefined(self.var_3e95b88f.hud)) {
    self.var_3e95b88f.hud = isPlayer(self);
  }

  if(prompt_struct.var_de6f0004 === 0.25) {
    prompt_struct.var_de6f0004 = undefined;
  }

  if(prompt_struct.var_4ac77177 === 0.1) {
    prompt_struct.var_4ac77177 = undefined;
  }

  if(prompt_struct.var_71b9f0c0 === 240) {
    prompt_struct.var_71b9f0c0 = undefined;
  }

  if(prompt_struct.var_9c89c587 === 0) {
    prompt_struct.var_9c89c587 = undefined;
  }

  if(prompt_struct.var_f17a78a7 === 180) {
    prompt_struct.var_f17a78a7 = undefined;
  }

  if(prompt_struct.var_87c991f3 === 85) {
    prompt_struct.var_87c991f3 = undefined;
  }

  if(prompt_struct.var_5e83875a === 30) {
    prompt_struct.var_5e83875a = undefined;
  }

  if(prompt_struct.var_7faab93d === 1) {
    prompt_struct.var_7faab93d = undefined;
  }

  if(prompt_struct.var_8ce60046 === 1) {
    prompt_struct.var_8ce60046 = undefined;
  }

  if(prompt_struct.var_9a27c4ee === 1) {
    prompt_struct.var_9a27c4ee = undefined;
  }

  if(prompt_struct.var_be77841a === 1) {
    prompt_struct.var_be77841a = undefined;
  }

  if(prompt_struct.var_c9643122 === 0) {
    prompt_struct.var_c9643122 = undefined;
  }

  prompt_struct.state = 0;
  priority = isDefined(prompt_struct.priority) ? prompt_struct.priority : 1;

  if(!isDefined(self.var_3e95b88f.var_294a441e[prompt])) {
    for(priority = int(priority * 10); isinarray(self.var_3e95b88f.var_294a441e, priority); priority++) {}

    self.var_3e95b88f.var_294a441e[prompt] = priority;
  } else {
    priority = self.var_3e95b88f.var_294a441e[prompt];
  }

  if(isDefined(prompt_struct.groups) && !isarray(prompt_struct.groups)) {
    prompt_struct.groups = array(prompt_struct.groups);
  }

  self.var_3e95b88f.prompts[prompt] = structcopy(prompt_struct);
  self.var_3e95b88f.prompts[prompt].priority = priority;
  self.var_3e95b88f.prompts[prompt].flags = 0;

  if(isDefined(prompt_struct.flags)) {
    foreach(flag in prompt_struct.flags) {
      self.var_3e95b88f.prompts[prompt].flags |= 1 << flag;
    }
  }

  if(isDefined(prompt_struct.image)) {
    self.var_3e95b88f.image = prompt_struct.image;
    self.var_3e95b88f.prompts[prompt].image = undefined;
  }

  self function_a4cf2cde({
    #offset: prompt_struct.offset, #tag: prompt_struct.tag, #var_754bedbb: prompt_struct.var_754bedbb, #var_51f93e19: prompt_struct.var_51f93e19
  });
  self notify("prompt_added_" + prompt);

  if(var_a23c5e1) {
    self thread _think();
  }
}

function function_46df0bc7(prompt, priority) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x333>");
  assert(isDefined(self.var_3e95b88f.prompts[prompt]), "<dev string:x390>" + function_9e72a96(prompt) + "<dev string:x3f1>");
  priority = int(priority * 10);
  arrayremoveindex(self.var_3e95b88f.var_294a441e, prompt, 1);

  while(isinarray(self.var_3e95b88f.var_294a441e, priority)) {
    priority++;
  }

  self.var_3e95b88f.var_294a441e[prompt] = priority;
  self.var_3e95b88f.prompts[prompt].priority = priority;
}

function function_a4cf2cde(offset_struct) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x3f6>");
  var_68131ee = 0;
  offset = (0, 0, 0);

  if(!self function_5a11b8f6()) {
    self.var_3e95b88f.var_80778410 = 0;
  } else {
    self.var_3e95b88f.var_80778410 = 1;
  }

  if(isDefined(offset_struct.offset)) {
    offset += offset_struct.offset;
  } else if(isPlayer(self)) {
    offset = (914.286, 675, 0);
  }

  if(offset != (0, 0, 0)) {
    self.var_3e95b88f.offset = offset;
    var_68131ee = 1;
  }

  if(isDefined(offset_struct.tag) && self haspart(offset_struct.tag)) {
    self.var_3e95b88f.tag = offset_struct.tag;
  } else if(isDefined(offset_struct.var_754bedbb)) {
    self.var_3e95b88f.var_754bedbb = offset_struct.var_754bedbb;
    var_68131ee = 1;
  }

  if(isDefined(offset_struct.var_51f93e19)) {
    self.var_3e95b88f.var_80778410 = offset_struct.var_51f93e19;
    var_68131ee = 1;
  }

  if(var_68131ee) {
    self notify(#"hash_17cbfac9e551855a");
  }
}

function function_92127496(var_80534db1, var_a5ce465f = 0) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x450>");

  if(!isPlayer(self)) {
    self.var_3e95b88f.hud = var_80534db1;
    self.var_3e95b88f.var_a5ce465f = var_a5ce465f;
  }
}

function set_text(text) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x450>");
  self.var_3e95b88f.text = text;

  if(isDefined(self.var_3e95b88f.uid)) {
    namespace_61e6d095::set_text(self.var_3e95b88f.uid, text);
  }
}

function function_309bf7c2(image) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x450>");
  self.var_3e95b88f.image = image;

  if(isDefined(self.var_3e95b88f.uid)) {
    namespace_61e6d095::function_309bf7c2(self.var_3e95b88f.uid, image);
  }
}

function function_82cf95d9(image) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x450>");
  self.var_3e95b88f.namespace_image = image;

  if(isDefined(self.var_3e95b88f.uid)) {
    namespace_61e6d095::function_9ade1d9b(self.var_3e95b88f.uid, "namespace_image", image);
    globallogic_ui::function_ec25f500(" ", 0);
  }
}

function function_b1cfa4bc(progress) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x450>");
  self.var_3e95b88f.var_fc01e65d = progress;

  if(isDefined(self.var_3e95b88f.uid)) {
    namespace_61e6d095::function_b1e6d7a8(self.var_3e95b88f.uid, progress);
    globallogic_ui::function_ec25f500(" ", 0);
  }
}

function function_dade5b1a(name, team) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x450>");
  self.var_3e95b88f.display_name = name;
  self.var_3e95b88f.team = util::getteamindex(isDefined(team) ? team : self getteam());

  if(isDefined(self.var_3e95b88f.uid)) {
    globallogic_ui::function_ec25f500(name, team);
  }
}

function set_objective(str_objective) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x450>");

  if(!isDefined(self.var_3e95b88f)) {
    return;
  }

  self.var_3e95b88f.objective = str_objective;

  if(isDefined(str_objective)) {
    uid = self.var_3e95b88f.var_b003a020;

    if(!isDefined(uid)) {
      uid = self.var_3e95b88f.uid;
    }

    if(isDefined(uid)) {
      state = namespace_61e6d095::function_f7c4c669(uid, "state");
      objectives_ui::function_278c15e6(str_objective, self, isDefined(state) && state != 1);
    }
  }
}

function function_263320e2(prompt, prompt_text) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x333>");
  assert(isDefined(self.var_3e95b88f.prompts[prompt]), "<dev string:x390>" + function_9e72a96(prompt) + "<dev string:x3f1>");

  if(self.var_3e95b88f.prompts[prompt].prompt_text === prompt_text) {
    return;
  }

  self.var_3e95b88f.prompts[prompt].prompt_text = prompt_text;
  uid = self.var_3e95b88f.uid;

  if(isDefined(uid) && namespace_61e6d095::function_cd59371c(uid, self.var_3e95b88f.var_294a441e[prompt], self.var_3e95b88f.var_db58523e) && !is_true(self.var_3e95b88f.prompts[prompt].removing)) {
    if(isDefined(prompt_text)) {
      namespace_61e6d095::function_f2a9266(self.var_3e95b88f.uid, self.var_3e95b88f.var_294a441e[prompt], "text", prompt_text, self.var_3e95b88f.var_db58523e);
      return;
    }

    namespace_61e6d095::function_f2a9266(self.var_3e95b88f.uid, self.var_3e95b88f.var_294a441e[prompt], "text", #"", self.var_3e95b88f.var_db58523e);
  }
}

function function_75d5e526(prompt, complete_callback) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x333>");
  assert(isDefined(self.var_3e95b88f.prompts[prompt]), "<dev string:x390>" + function_9e72a96(prompt) + "<dev string:x3f1>");
  self.var_3e95b88f.prompts[prompt].complete_callback = complete_callback;
}

function function_a4a9acfc(prompt, var_531201f1) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x333>");
  assert(isDefined(self.var_3e95b88f.prompts[prompt]), "<dev string:x390>" + function_9e72a96(prompt) + "<dev string:x3f1>");
  self.var_3e95b88f.prompts[prompt].var_531201f1 = var_531201f1;
}

function function_cd2391cb(prompt, notify_string) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x333>");
  assert(isDefined(self.var_3e95b88f.prompts[prompt]), "<dev string:x390>" + function_9e72a96(prompt) + "<dev string:x3f1>");
  self.var_3e95b88f.prompts[prompt].notify_string = notify_string;
}

function set_offset(offset, tag, var_754bedbb, var_51f93e19) {
  self function_a4cf2cde({
    #offset: offset, #tag: tag, #var_754bedbb: var_754bedbb, #var_51f93e19: var_51f93e19
  });
}

function function_46f198(uid, var_db58523e) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x333>");
  self.var_3e95b88f.uid = uid;
  self.var_3e95b88f.var_db58523e = var_db58523e;
}

function function_816ddada(prompt, var_1df3804c) {
  self.var_3e95b88f.prompts[prompt].var_1df3804c = var_1df3804c;
}

function function_44d7831a(prompt, flags, var_cca4e0db = 0) {
  if(var_cca4e0db) {
    self.var_3e95b88f.prompts[prompt].flags |= flags;
  } else {
    if(!isDefined(flags)) {
      flags = [];
    } else if(!isarray(flags)) {
      flags = array(flags);
    }

    foreach(flag in flags) {
      self.var_3e95b88f.prompts[prompt].flags |= 1 << flag;
    }
  }

  uid = self.var_3e95b88f.uid;

  if(isDefined(uid) && namespace_61e6d095::function_cd59371c(uid, self.var_3e95b88f.var_294a441e[prompt], self.var_3e95b88f.var_db58523e) && !is_true(self.var_3e95b88f.prompts[prompt].removing)) {
    namespace_61e6d095::function_9bc1d2f1(uid, self.var_3e95b88f.var_294a441e[prompt], self.var_3e95b88f.prompts[prompt].flags, 1);
  }
}

function function_4b556f63(prompt, flags, var_cca4e0db = 0) {
  if(var_cca4e0db) {
    self.var_3e95b88f.prompts[prompt].flags &= ~flags;
  } else {
    if(!isDefined(flags)) {
      flags = [];
    } else if(!isarray(flags)) {
      flags = array(flags);
    }

    foreach(flag in flags) {
      self.var_3e95b88f.prompts[prompt].flags &= ~flag;
    }
  }

  uid = self.var_3e95b88f.uid;

  if(isDefined(uid) && namespace_61e6d095::function_cd59371c(uid, self.var_3e95b88f.var_294a441e[prompt], self.var_3e95b88f.var_db58523e) && !is_true(self.var_3e95b88f.prompts[prompt].removing)) {
    namespace_61e6d095::function_e8c19a33(uid, self.var_3e95b88f.var_294a441e[prompt], flags, 1);
  }
}

function function_d03d79d6(prompt, var_de6f0004) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x333>");
  assert(isDefined(self.var_3e95b88f.prompts[prompt]), "<dev string:x390>" + function_9e72a96(prompt) + "<dev string:x3f1>");
  self.var_3e95b88f.prompts[prompt].var_de6f0004 = var_de6f0004;

  if(self.var_3e95b88f.prompts[prompt].var_de6f0004 === 0.25) {
    self.var_3e95b88f.prompts[prompt].var_de6f0004 = undefined;
  }
}

function function_8f5eb0a6(prompt, var_4ac77177) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x333>");
  assert(isDefined(self.var_3e95b88f.prompts[prompt]), "<dev string:x390>" + function_9e72a96(prompt) + "<dev string:x3f1>");
  self.var_3e95b88f.prompts[prompt].var_4ac77177 = var_4ac77177;

  if(self.var_3e95b88f.prompts[prompt].var_4ac77177 === 0.1) {
    self.var_3e95b88f.prompts[prompt].var_4ac77177 = undefined;
  }
}

function function_5fe46a16(prompt, var_71b9f0c0) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x333>");
  assert(isDefined(self.var_3e95b88f.prompts[prompt]), "<dev string:x390>" + function_9e72a96(prompt) + "<dev string:x3f1>");
  self.var_3e95b88f.prompts[prompt].var_71b9f0c0 = var_71b9f0c0;

  if(self.var_3e95b88f.prompts[prompt].var_71b9f0c0 === 240) {
    self.var_3e95b88f.prompts[prompt].var_71b9f0c0 = undefined;
  }
}

function function_cf884581(prompt, var_79a4cbfc) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x333>");
  assert(isDefined(self.var_3e95b88f.prompts[prompt]), "<dev string:x390>" + function_9e72a96(prompt) + "<dev string:x3f1>");
  self.var_3e95b88f.prompts[prompt].var_9c89c587 = var_79a4cbfc;

  if(self.var_3e95b88f.prompts[prompt].var_9c89c587 === 0) {
    self.var_3e95b88f.prompts[prompt].var_9c89c587 = undefined;
  }
}

function function_5698d1c9(prompt, var_5f57572a) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x333>");
  assert(isDefined(self.var_3e95b88f.prompts[prompt]), "<dev string:x390>" + function_9e72a96(prompt) + "<dev string:x3f1>");
  self.var_3e95b88f.prompts[prompt].var_f17a78a7 = var_5f57572a;

  if(self.var_3e95b88f.prompts[prompt].var_f17a78a7 === 180) {
    self.var_3e95b88f.prompts[prompt].var_f17a78a7 = undefined;
  }
}

function function_68782902(prompt, var_87c991f3) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x333>");
  assert(isDefined(self.var_3e95b88f.prompts[prompt]), "<dev string:x390>" + function_9e72a96(prompt) + "<dev string:x3f1>");
  self.var_3e95b88f.prompts[prompt].var_87c991f3 = var_87c991f3;

  if(self.var_3e95b88f.prompts[prompt].var_87c991f3 === 85) {
    self.var_3e95b88f.prompts[prompt].var_87c991f3 = undefined;
  }
}

function function_2557566(prompt, var_7faab93d) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x333>");
  assert(isDefined(self.var_3e95b88f.prompts[prompt]), "<dev string:x390>" + function_9e72a96(prompt) + "<dev string:x3f1>");
  self.var_3e95b88f.prompts[prompt].var_7faab93d = var_7faab93d;

  if(self.var_3e95b88f.prompts[prompt].var_7faab93d === 1) {
    self.var_3e95b88f.prompts[prompt].var_7faab93d = undefined;
  }
}

function function_b95d71cd(prompt, var_5e83875a) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x333>");
  assert(isDefined(self.var_3e95b88f.prompts[prompt]), "<dev string:x390>" + function_9e72a96(prompt) + "<dev string:x3f1>");
  self.var_3e95b88f.prompts[prompt].var_5e83875a = var_5e83875a;

  if(self.var_3e95b88f.prompts[prompt].var_5e83875a === 30) {
    self.var_3e95b88f.prompts[prompt].var_5e83875a = undefined;
  }
}

function function_1a5e1da6(prompt, var_3c8a8153, var_c8a53909) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x333>");
  assert(isDefined(self.var_3e95b88f.prompts[prompt]), "<dev string:x390>" + function_9e72a96(prompt) + "<dev string:x3f1>");
  self.var_3e95b88f.prompts[prompt].var_3c8a8153 = var_3c8a8153;
  self.var_3e95b88f.prompts[prompt].var_88ceabd = var_c8a53909;
}

function function_4cb5d3a1(prompt, var_8ce60046) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x333>");
  assert(isDefined(self.var_3e95b88f.prompts[prompt]), "<dev string:x390>" + function_9e72a96(prompt) + "<dev string:x3f1>");
  self.var_3e95b88f.prompts[prompt].var_8ce60046 = var_8ce60046;

  if(self.var_3e95b88f.prompts[prompt].var_8ce60046 === 1) {
    self.var_3e95b88f.prompts[prompt].var_8ce60046 = undefined;
  }
}

function function_dcf99fad(prompt, var_9a27c4ee, ignore_ent) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x333>");
  assert(isDefined(self.var_3e95b88f.prompts[prompt]), "<dev string:x390>" + function_9e72a96(prompt) + "<dev string:x3f1>");
  self.var_3e95b88f.prompts[prompt].var_9a27c4ee = var_9a27c4ee;
  self.var_3e95b88f.prompts[prompt].var_1e4cbecf = ignore_ent;

  if(self.var_3e95b88f.prompts[prompt].var_9a27c4ee === 1) {
    self.var_3e95b88f.prompts[prompt].var_9a27c4ee = undefined;
  }
}

function function_2bd2431a(prompt, var_be77841a) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x333>");
  assert(isDefined(self.var_3e95b88f.prompts[prompt]), "<dev string:x390>" + function_9e72a96(prompt) + "<dev string:x3f1>");
  self.var_3e95b88f.prompts[prompt].var_be77841a = var_be77841a;

  if(self.var_3e95b88f.prompts[prompt].var_be77841a === 1) {
    self.var_3e95b88f.prompts[prompt].var_be77841a = undefined;
  }
}

function function_3171730f(prompt, groups) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x333>");
  assert(isDefined(self.var_3e95b88f.prompts[prompt]), "<dev string:x390>" + function_9e72a96(prompt) + "<dev string:x3f1>");

  if(!isDefined(groups)) {
    groups = [];
  } else if(!isarray(groups)) {
    groups = array(groups);
  }

  self.var_3e95b88f.prompts[prompt].groups = groups;
}

function function_e79f51ec(groups) {
  if(!isDefined(groups)) {
    groups = [];
  } else if(!isarray(groups)) {
    groups = array(groups);
  }

  level.var_a8ea96e8 = groups;
}

function function_398ab9eb() {
  level.var_a8ea96e8 = [];
}

function function_2e6d74f5(prompt, pause) {
  assert(isDefined(self.var_3e95b88f), "<dev string:x333>");
  assert(isDefined(self.var_3e95b88f.prompts[prompt]), "<dev string:x390>" + function_9e72a96(prompt) + "<dev string:x3f1>");
  self.var_3e95b88f.prompts[prompt].var_f14d06ca = pause;
}

function remove(prompt, immediate) {
  if(isDefined(self.var_3e95b88f) && isDefined(self.var_3e95b88f.prompts[prompt]) && !is_true(self.var_3e95b88f.prompts[prompt].removing)) {
    self notify(#"prompt_removed", {
      #prompt: prompt
    });
    self notify("prompt_removed_" + prompt);

    if(isDefined(self.var_3e95b88f.uid) && isDefined(self.var_3e95b88f.var_294a441e[prompt])) {
      function_17578ab7(prompt, self.var_3e95b88f);
      namespace_61e6d095::function_7239e030(self.var_3e95b88f.uid, self.var_3e95b88f.var_294a441e[prompt], self.var_3e95b88f.var_db58523e);
    }

    self.var_3e95b88f.prompts[prompt].removing = 1;
    self thread function_660c618b(prompt, immediate);
  }
}

function private function_660c618b(prompt, immediate) {
  self endon(#"all_prompts_removed", "prompt_added_" + prompt, #"death");

  if(!is_true(immediate)) {
    waittillframeend();
  }

  if(isDefined(self.var_3e95b88f) && isDefined(self.var_3e95b88f.prompts[prompt])) {
    arrayremoveindex(self.var_3e95b88f.prompts, prompt, 1);
    arrayremoveindex(self.var_3e95b88f.var_294a441e, prompt, 1);
    player = getplayers()[0];

    if(player.var_b3c804a4[prompt] === self) {
      player.var_b3c804a4[prompt] = undefined;
    }

    if(self.var_3e95b88f.prompts.size == 0) {
      if(isDefined(self.var_3e95b88f.uid)) {
        if(!isDefined(self.var_3e95b88f.var_db58523e)) {
          self function_8de9a77a();
        } else if(isDefined(self.var_3e95b88f.var_294a441e)) {
          foreach(index in self.var_3e95b88f.var_294a441e) {
            namespace_61e6d095::function_7239e030(self.var_3e95b88f.uid, index, self.var_3e95b88f.var_db58523e);
          }
        }
      }

      self.var_3e95b88f = undefined;
      self notify(#"all_prompts_removed");
    }
  }
}

function remove_group(group) {
  if(isDefined(self.var_3e95b88f.prompts)) {
    var_c94d18f6 = [];

    foreach(prompt, prompt_struct in self.var_3e95b88f.prompts) {
      if(isDefined(prompt_struct.groups) && isinarray(prompt_struct.groups, group)) {
        var_c94d18f6[var_c94d18f6.size] = prompt;
      }
    }

    foreach(prompt in var_c94d18f6) {
      self thread remove(prompt, 1);
    }
  }
}

function function_334e020() {
  if(isDefined(self.var_3e95b88f)) {
    var_393b6e18 = self.origin;

    if(isentity(self)) {
      if(isDefined(self.var_3e95b88f.tag)) {
        var_393b6e18 = self gettagorigin(self.var_3e95b88f.tag);
      } else if(iscorpse(self)) {
        var_393b6e18 = self getcorpsephysicsorigin() + (0, 0, 6);
      } else if(is_true(self.var_3e95b88f.var_754bedbb)) {
        var_393b6e18 += rotatepoint(self getboundsmidpoint(), self.angles);
      }
    }

    if(isDefined(self.var_3e95b88f.offset) && self.var_3e95b88f.offset != (0, 0, 0)) {
      if(is_true(self.var_3e95b88f.var_80778410)) {
        var_393b6e18 += rotatepoint(self.var_3e95b88f.offset, self.angles);
      } else {
        var_393b6e18 += self.var_3e95b88f.offset;
      }
    }

    return var_393b6e18;
  }

  return undefined;
}

function function_86eedc() {
  self flag::set("prompts_disabled");
}

function function_d675f5a4() {
  self flag::clear("prompts_disabled");
}

function private function_d626d354(prompt, player, dist) {
  var_62bce5b6 = self.var_3e95b88f.prompts[prompt];

  if(self flag::get("prompts_disabled") || level flag::get("prompts_disabled")) {
    return false;
  }

  if(level.var_a8ea96e8.size > 0) {
    if(!isDefined(var_62bce5b6.groups)) {
      return false;
    }

    var_a4d18ab4 = 0;

    foreach(var_405c2a4c in level.var_a8ea96e8) {
      if(isinarray(var_62bce5b6.groups, var_405c2a4c)) {
        var_a4d18ab4 = 1;
        break;
      }
    }

    if(!var_a4d18ab4) {
      return false;
    }
  }

  if(self != player) {
    var_71b9f0c0 = isDefined(var_62bce5b6.var_71b9f0c0) ? var_62bce5b6.var_71b9f0c0 : 240;

    if(level.var_a48f9f79[#"hash_648d8b504449ecd3"] > 0) {
      var_71b9f0c0 = level.var_a48f9f79[#"hash_648d8b504449ecd3"];
    }

    if(dist > var_71b9f0c0) {
      return false;
    }

    self.var_3e95b88f.var_98fa5077 = 1;
    require_los = isDefined(var_62bce5b6.var_8ce60046) ? var_62bce5b6.var_8ce60046 : 1;

    if(level.var_a48f9f79[#"hash_3cdd945161669bf5"] >= 0) {
      require_los = level.var_a48f9f79[#"hash_3cdd945161669bf5"] > 0;
    }

    if(require_los) {
      var_393b6e18 = self function_334e020();
      var_27a7ecaa = isDefined(var_62bce5b6.var_27a7ecaa) ? var_62bce5b6.var_27a7ecaa : player;

      if(!sighttracepassed(player getplayercamerapos(), var_393b6e18, 1, self, var_27a7ecaa)) {
        return false;
      }
    }
  }

  if(isDefined(var_62bce5b6.var_531201f1) && !self[[var_62bce5b6.var_531201f1]]({
      #prompt: prompt, #player: player
    })) {
    return false;
  }

  return true;
}

function private function_12186571(prompt, var_62bce5b6, player, dist, var_393b6e18, var_693a4fcf) {
  if(self != player) {
    if(isDefined(player.var_b3c804a4[prompt]) && player.var_b3c804a4[prompt] != self) {
      return false;
    }

    hud = self.var_3e95b88f.hud;
    var_343e3ef2 = 0;

    if(level.var_a48f9f79[#"hash_464a6e9e035a826e"] > 0) {
      hud = 1;
      var_343e3ef2 = 1;
    } else if(level.var_a48f9f79[#"hash_464a6e9e035a826e"] < 0) {
      hud = 0;
    }

    if(hud) {
      foreach(var_3388fe0e in player.var_b3c804a4) {
        if(isDefined(var_3388fe0e) && var_3388fe0e != self && (var_3388fe0e == player || var_343e3ef2 || var_3388fe0e.var_3e95b88f.hud)) {
          return false;
        }
      }
    }

    var_87c991f3 = isDefined(var_62bce5b6.var_87c991f3) ? var_62bce5b6.var_87c991f3 : 85;

    if(level.var_a48f9f79[#"hash_5188f09d68ab049b"] > 0) {
      var_87c991f3 = level.var_a48f9f79[#"hash_5188f09d68ab049b"];
    }

    if(dist > var_87c991f3) {
      return false;
    }

    var_45913153 = is_true(var_62bce5b6.var_3c8a8153) && level.var_7315ba31 === (isDefined(var_62bce5b6.var_88ceabd) ? var_62bce5b6.var_88ceabd : self);
    var_b0cb5e43 = undefined;

    if(!var_45913153 && var_693a4fcf < 180) {
      var_b0cb5e43 = vectornormalize(var_393b6e18 - player getplayercamerapos());
      angle_delta = acos(math::clamp(vectordot(anglesToForward(player getplayerangles()), var_b0cb5e43), -1, 1));

      if(level.var_a48f9f79[#"hash_4415d97cf206beca"] > 0) {
        var_693a4fcf = level.var_a48f9f79[#"hash_4415d97cf206beca"];
      }

      if(angle_delta > var_693a4fcf) {
        return false;
      }
    }

    if(isDefined(self.angles)) {
      var_9c89c587 = isDefined(var_62bce5b6.var_9c89c587) ? var_62bce5b6.var_9c89c587 : 0;
      var_f17a78a7 = isDefined(var_62bce5b6.var_f17a78a7) ? var_62bce5b6.var_f17a78a7 : 180;

      if(level.var_a48f9f79[#"hash_2665c3284c087179"] >= 0) {
        var_9c89c587 = level.var_a48f9f79[#"hash_2665c3284c087179"];
      }

      if(level.var_a48f9f79[#"hash_264ad5284bf1c857"] > 0) {
        var_f17a78a7 = level.var_a48f9f79[#"hash_264ad5284bf1c857"];
      }

      if(var_9c89c587 > 0 || var_f17a78a7 < 180) {
        if(!isDefined(var_b0cb5e43)) {
          var_b0cb5e43 = vectornormalize(var_393b6e18 - player getplayercamerapos());
        }

        angle_delta = acos(vectordot(anglesToForward(self.angles), var_b0cb5e43));

        if(angle_delta < var_9c89c587 || angle_delta > var_f17a78a7) {
          return false;
        }
      }
    }

    var_9a27c4ee = (isDefined(var_62bce5b6.var_9a27c4ee) ? var_62bce5b6.var_9a27c4ee : 1) || var_45913153;

    if(level.var_a48f9f79[#"hash_d71edc1fface7ff"] >= 0) {
      var_9a27c4ee = level.var_a48f9f79[#"hash_d71edc1fface7ff"] > 0;
    }

    var_1e4cbecf = isDefined(var_62bce5b6.var_1e4cbecf) ? var_62bce5b6.var_1e4cbecf : player;

    if(!var_9a27c4ee && !bullettracepassed(player getplayercamerapos(), var_393b6e18, 1, self, var_1e4cbecf)) {
      return false;
    }
  }

  return true;
}

function private function_99bb5bbe(prompt_struct) {
  if(!prompt_struct.player gamepadusedlast() && isDefined(level.prompts[prompt_struct.prompt].var_b753c5a5)) {
    return prompt_struct.player buttonbitstate(level.prompts[prompt_struct.prompt].var_b753c5a5);
  }

  switch (prompt_struct.prompt) {
    case # "use":
    case # "use_tap":
      return prompt_struct.player useButtonPressed();
    case # "melee_hold":
    case # "melee":
      return prompt_struct.player meleeButtonPressed();
    case # "attack":
      return prompt_struct.player attackButtonPressed();
    case # "reload":
      return prompt_struct.player reloadbuttonPressed();
    case # "frag":
      return prompt_struct.player fragButtonPressed();
    case # "stance":
      return prompt_struct.player stancebuttonPressed();
    case # "weapnext":
      return prompt_struct.player weaponswitchbuttonPressed();
    case # "ads":
      return prompt_struct.player adsButtonPressed();
    case # "vehicle_attack":
      return prompt_struct.player vehicleattackButtonPressed();
  }

  return 0;
}

function private function_eee54dd8(prompt_struct) {
  switch (prompt_struct.prompt) {
    case # "confirm":
      return prompt_struct.player namespace_61e6d095::function_affb1af1();
    case # "cancel":
      return prompt_struct.player namespace_61e6d095::function_57fbd346();
    case # "alt1":
      return prompt_struct.player namespace_61e6d095::function_e4d62f9a();
    case # "alt2":
      return prompt_struct.player namespace_61e6d095::function_728aec47();
    default:
      model = undefined;

      if(prompt_struct.player gamepadusedlast()) {
        assert(isDefined(level.prompts[prompt_struct.prompt].lui_button), "<dev string:x4a7>" + function_9e72a96(prompt_struct.prompt));
        var_d75b2384 = function_90d058e8(#"buttons");
        model = getuimodel(var_d75b2384, string(level.prompts[prompt_struct.prompt].lui_button));
        assert(isDefined(model), "<dev string:x4d1>" + level.prompts[prompt_struct.prompt].lui_button + "<dev string:x4df>" + function_9e72a96(prompt_struct.prompt));
      } else {
        assert(isDefined(level.prompts[prompt_struct.prompt].var_b35ba5c), "<dev string:x4f7>" + function_9e72a96(prompt_struct.prompt));
        var_31a34837 = function_90d058e8(#"hash_48b37823078b5999");
        model = getuimodel(var_31a34837, level.prompts[prompt_struct.prompt].var_b35ba5c);
        assert(isDefined(model), "<dev string:x525>" + level.prompts[prompt_struct.prompt].var_b35ba5c + "<dev string:x4df>" + function_9e72a96(prompt_struct.prompt));
      }

      return (getuimodelvalue(model) > 0);
  }

  return 0;
}

function private function_cd5cbae1(player) {
  player endon(#"death");
  self endon(#"all_prompts_removed");
  level endon(#"level_restarting");
  self waittill(#"death");

  if(isDefined(self.var_3e95b88f.uid)) {
    function_17578ab7(undefined, self.var_3e95b88f);
  }

  arrayremovevalue(player.var_b3c804a4, self, 1);
}

function private _think() {
  self endon(#"death", #"all_prompts_removed");
  level endon(#"level_restarting");

  for(player = getplayers()[0]; !isDefined(player); player = getplayers()[0]) {
    waitframe(1);
  }

  if(self != player) {
    player endon(#"death");
    self thread function_cd5cbae1(player);
  }

  waittillframeend();

  while(isDefined(self.var_3e95b88f)) {
    dist = 0;

    if(self != player) {
      dist = distance(player getplayercamerapos(), isDefined(self function_334e020()) ? self function_334e020() : self.origin);
    }

    var_3808d0ab = 0;

    foreach(prompt, var_62bce5b6 in self.var_3e95b88f.prompts) {
      if(self function_d626d354(prompt, player, dist)) {
        var_3808d0ab = 1;
        break;
      }
    }

    if(var_3808d0ab) {
      self function_e8006b47();

      if(isDefined(player.var_b3c804a4)) {
        arrayremovevalue(player.var_b3c804a4, self, 1);
      }

      if(isDefined(self.var_3e95b88f.uid)) {
        if(!isDefined(self.var_3e95b88f.var_db58523e)) {
          self function_8de9a77a();
        } else {
          foreach(index in self.var_3e95b88f.var_294a441e) {
            namespace_61e6d095::function_7239e030(self.var_3e95b88f.uid, index, self.var_3e95b88f.var_db58523e);
          }
        }
      }

      continue;
    }

    player waittilltimeout(max(float(function_60d95f53()) / 1000, dist / 528), #"teleported");
  }
}

function private function_e8006b47() {
  self endon(#"death", #"all_prompts_removed", #"hash_17cbfac9e551855a");
  level endon(#"level_restarting");
  player = getplayers()[0];

  if(self != player) {
    player endon(#"death");
  }

  if(!isDefined(self.var_3e95b88f.var_db58523e)) {
    self function_a6104953();
  }

  waitframe(1);
  uid = self.var_3e95b88f.uid;
  state = 0;
  var_c6668915 = undefined;
  var_6dbb4310 = 0;
  self.var_3e95b88f.var_98fa5077 = 1;

  while(self.var_3e95b88f.var_98fa5077) {
    var_bc26f34b = 0;
    var_e24c19de = 0;
    old_state = state;
    dist = 0;
    var_b48ce78 = 0;
    var_3714e9ea = 0;
    var_4921a894 = 0;
    var_b6a8b668 = 0;

    if(self != player) {
      var_393b6e18 = self function_334e020();
      var_7f3f225e = player getplayercamerapos();
      dist = distance(var_7f3f225e, var_393b6e18);
      self.var_3e95b88f.var_98fa5077 = 0;

      if(level.var_a48f9f79[#"hash_a1f059a85f5bed3"] != 0) {
        print3d(var_393b6e18, "<dev string:x3f1>", (0, 0, 1), undefined, undefined, undefined, 1);
      }
    }

    foreach(prompt, var_62bce5b6 in self.var_3e95b88f.prompts) {
      self function_263b3850(uid, prompt, player);
      var_b48ce78 = max(var_b48ce78, (isDefined(var_62bce5b6.var_71b9f0c0) ? var_62bce5b6.var_71b9f0c0 : 240) + 12);
      var_3714e9ea = max(var_3714e9ea, isDefined(var_62bce5b6.var_87c991f3) ? var_62bce5b6.var_87c991f3 : 85);
      var_62bce5b6.old_state = var_62bce5b6.state;
      reset_interaction = 1;

      if(self function_d626d354(prompt, player, dist - 12)) {
        var_bc26f34b = 1;

        if(var_62bce5b6.state == 3) {
          var_e24c19de = 1;
          continue;
        }

        var_5e83875a = isDefined(var_62bce5b6.var_5e83875a) ? var_62bce5b6.var_5e83875a : 30;

        if(var_62bce5b6.state != 0 && var_62bce5b6.state != 4) {
          var_5e83875a += isDefined(var_62bce5b6.var_7faab93d) ? var_62bce5b6.var_7faab93d : 1;
        }

        if(function_12186571(prompt, var_62bce5b6, player, dist, var_393b6e18, var_5e83875a)) {
          var_e24c19de = 1;
          var_a33acc5d = self function_6b2492cb(prompt, var_62bce5b6, player);
          reset_interaction = !var_a33acc5d.var_9ad09916;
          var_4921a894 = var_4921a894 || var_a33acc5d.var_4921a894;
          var_b6a8b668 = var_b6a8b668 || var_a33acc5d.var_b6a8b668;
        } else if(var_62bce5b6.state != 3) {
          if(var_62bce5b6.flags & 2) {
            var_62bce5b6.state = 4;
          } else {
            var_62bce5b6.state = 0;
          }
        }
      } else if(var_62bce5b6.state != 3) {
        if(var_62bce5b6.state == 0 || var_62bce5b6.state == 4) {
          reset_interaction = 0;
        }

        var_62bce5b6.state = 0;
      }

      if((var_62bce5b6.state == 0 || var_62bce5b6.state == 4) && player.var_b3c804a4[prompt] === self) {
        player.var_b3c804a4[prompt] = undefined;
      }

      if(reset_interaction) {
        self function_9309081b(uid, prompt);
      }

      if(var_62bce5b6.old_state != var_62bce5b6.state) {
        self function_f4bf235a(uid, prompt, self.var_3e95b88f.prompts[prompt].state);
      }
    }

    if(var_e24c19de) {
      state = 3;
    } else if(var_bc26f34b) {
      state = 2;
    } else if(self.var_3e95b88f.var_98fa5077) {
      state = 1;
    } else {
      break;
    }

    ease_type = # "logarithmic";
    ease_in = 1;
    ease_out = 1;
    var_249ae409 = 10;
    var_81f357d7 = 0;
    max_alpha = 1;

    if(level.var_a48f9f79[#"hash_6958ea0555e58a17"] != "<dev string:x132>" && isDefined(level.ease_funcs[level.var_a48f9f79[#"hash_6958ea0555e58a17"]])) {
      ease_type = level.var_a48f9f79[#"hash_6958ea0555e58a17"];
    }

    if(level.var_a48f9f79[#"hash_428f189debeb7b94"] != -1) {
      ease_in = level.var_a48f9f79[#"hash_428f189debeb7b94"] != 0;
    }

    if(level.var_a48f9f79[#"hash_51a8d457c48c4901"] != -1) {
      ease_out = level.var_a48f9f79[#"hash_51a8d457c48c4901"] != 0;
    }

    if(level.var_a48f9f79[#"hash_2fae9ec41625639c"] != -1) {
      var_249ae409 = level.var_a48f9f79[#"hash_2fae9ec41625639c"];
    }

    if(level.var_a48f9f79[#"hash_72b9e1d573cf513c"] != -1) {
      var_81f357d7 = level.var_a48f9f79[#"hash_72b9e1d573cf513c"];
    }

    if(level.var_a48f9f79[#"hash_729ecfd573b86aee"] != -1) {
      max_alpha = level.var_a48f9f79[#"hash_729ecfd573b86aee"];
    }

    alpha = 1;

    if(var_b48ce78 > var_3714e9ea) {
      var_203de47b = math::clamp((var_b48ce78 - dist) / (var_b48ce78 - var_3714e9ea), 0, 1);

      if(ease_type == # "power" || ease_type == # "exponential" || ease_type == # "logarithmic") {
        alpha = [[level.ease_funcs[ease_type]]](var_81f357d7, max_alpha, var_203de47b, ease_in, ease_out, var_249ae409);
      } else {
        alpha = [[level.ease_funcs[ease_type]]](var_81f357d7, max_alpha, var_203de47b, ease_in, ease_out);
      }

      alpha = ceil(alpha * 1000) / 1000;
    }

    if(var_c6668915 !== alpha) {
      namespace_61e6d095::set_alpha(isDefined(self.var_3e95b88f.var_b003a020) ? self.var_3e95b88f.var_b003a020 : uid, alpha);
      var_c6668915 = alpha;
    }

    if(old_state != state) {
      namespace_61e6d095::set_state(uid, state);

      if(isDefined(self.var_3e95b88f.var_b003a020)) {
        namespace_61e6d095::set_state(self.var_3e95b88f.var_b003a020, state);
      }

      if(isDefined(self.var_3e95b88f.objective)) {
        objectives_ui::function_278c15e6(self.var_3e95b88f.objective, self, state != 1);
      }
    }

    if(var_6dbb4310 != var_4921a894) {
      var_6dbb4310 = var_4921a894;
      self notify(#"hash_5ede0284920c4c56", {
        #interactable: var_4921a894
      });
    }

    if(self flag::get(#"hash_305ce4d5b74a637a") != var_b6a8b668) {
      if(var_b6a8b668) {
        player val::set(#"hash_599ec0eee77657ef", "disable_usability", 1);
        player flag::set(#"hash_599ec0eee77657ef");
        self flag::set(#"hash_305ce4d5b74a637a");
      } else {
        player val::reset_all(#"hash_599ec0eee77657ef");
        player flag::clear(#"hash_599ec0eee77657ef");
        self flag::clear(#"hash_305ce4d5b74a637a");
      }
    }

    waitframe(1);
  }
}

function private function_6b2492cb(prompt, var_62bce5b6, player) {
  player.var_b3c804a4[prompt] = self;
  var_62bce5b6.state = 1;
  lower = 0;
  hud = self.var_3e95b88f.hud;

  if(level.var_a48f9f79[#"hash_464a6e9e035a826e"] > 0) {
    hud = 1;
  } else if(level.var_a48f9f79[#"hash_464a6e9e035a826e"] < 0) {
    hud = 0;
  }

  if(hud) {
    lower = var_62bce5b6.flags & 1;

    if(level.var_a48f9f79[#"hash_464a6e9e035a826e"] == 2) {
      lower = 0;
    } else if(level.var_a48f9f79[#"hash_464a6e9e035a826e"] == 3) {
      lower = 1;
    }
  }

  var_9ad09916 = 0;

  if(self[[level.prompts[prompt].var_92bb1cb1]]({
      #prompt: prompt, #var_62bce5b6: var_62bce5b6, #player: player
    }) && !is_true(var_62bce5b6.var_5a8a10f2)) {
    self function_fcef5f5b(prompt, var_62bce5b6, player);
    var_9ad09916 = 1;
  }

  return {
    #var_9ad09916: var_9ad09916, #var_b6a8b668: lower, #var_4921a894: hud && !lower
  };
}

function private function_fcef5f5b(prompt, var_62bce5b6, player) {
  if(is_true(var_62bce5b6.var_f14d06ca)) {
    if(isDefined(var_62bce5b6.var_c570a6f9)) {
      var_62bce5b6.var_c570a6f9 += float(function_60d95f53()) / 1000;
    }

    return;
  }

  var_62bce5b6.var_5a8a10f2 = undefined;

  if(!isDefined(var_62bce5b6.var_c570a6f9)) {
    var_62bce5b6.var_c570a6f9 = gettime();
  }

  var_de6f0004 = int((isDefined(var_62bce5b6.var_de6f0004) ? var_62bce5b6.var_de6f0004 : 0.25) * 1000);
  var_4ac77177 = int((isDefined(var_62bce5b6.var_4ac77177) ? var_62bce5b6.var_4ac77177 : 0.1) * 1000);

  if(function_2af9819b(prompt, var_62bce5b6, player)) {
    var_62bce5b6.state = 2;
    self function_efb98d80(prompt, var_62bce5b6, player);
    return;
  }

  if(gettime() - var_62bce5b6.var_c570a6f9 >= var_4ac77177) {
    var_62bce5b6.state = 2;
    pct = var_de6f0004 < 0 ? -1 : 0;

    if(pct < 1 && pct >= 0) {
      pct = math::clamp((gettime() - var_62bce5b6.var_c570a6f9 - var_4ac77177) / var_de6f0004, 0, 1);
    }

    namespace_61e6d095::function_f2a9266(self.var_3e95b88f.uid, self.var_3e95b88f.var_294a441e[prompt], "fraction", pct, self.var_3e95b88f.var_db58523e);

    if(pct >= 1 || pct == -1) {
      self function_efb98d80(prompt, var_62bce5b6, player);
    }
  }
}

function private function_2af9819b(prompt, var_62bce5b6, player) {
  var_de6f0004 = int((isDefined(var_62bce5b6.var_de6f0004) ? var_62bce5b6.var_de6f0004 : 0.25) * 1000);
  var_c9643122 = isDefined(var_62bce5b6.var_c9643122) ? var_62bce5b6.var_c9643122 : 0;
  var_ab23834f = prompt == # "use" || prompt == # "use_tap";
  return !player gamepadusedlast() && !player function_5c0f244() && !var_c9643122 && var_de6f0004 <= level.var_503dffcb[#"cg_cpmaxholddurationignore"] && var_ab23834f;
}

function private function_efb98d80(prompt, var_62bce5b6, player) {
  var_1df3804c = isDefined(var_62bce5b6.var_1df3804c) ? var_62bce5b6.var_1df3804c : self;
  var_1df3804c notify("interactive_prompt_" + prompt);
  var_1df3804c notify(#"interact", {
    #prompt: prompt, #player: player
  });
  bb::function_a0d15803(var_62bce5b6.prompt_text, self function_334e020(), player);

  if(prompt == # "use" || prompt == # "use_tap") {
    player function_58b29f4f();
  }

  if(isDefined(level.prompts[prompt].notify_string)) {
    var_1df3804c notify(level.prompts[prompt].notify_string, {
      #activator: player, #prompt: prompt
    });
  }

  if(isDefined(var_62bce5b6.notify_string)) {
    var_1df3804c notify(var_62bce5b6.notify_string);
  }

  if(isDefined(var_62bce5b6.complete_callback)) {
    var_1df3804c thread[[var_62bce5b6.complete_callback]]({
      #prompt: prompt, #player: player
    });
  }

  if(!is_true(var_62bce5b6.removing)) {
    var_62bce5b6.state = 3;
    endons = ["all_prompts_removed", "death"];

    if(isDefined(var_62bce5b6.var_be77841a) ? var_62bce5b6.var_be77841a : 1) {
      self thread util::delay(0.35, endons, &remove, prompt);
      return;
    }

    var_62bce5b6.var_5a8a10f2 = 1;
    endons[endons.size] = "prompt_removed_" + prompt;

    if(var_62bce5b6.flags & 4) {
      self thread util::delay(0.2, endons, &function_f4bf235a, self.var_3e95b88f.uid, prompt, 1);
      return;
    }

    self thread util::delay(0.35, endons, &function_f4bf235a, self.var_3e95b88f.uid, prompt, 0);
  }
}

function private function_f4bf235a(uid, prompt, state) {
  if(is_true(self.var_3e95b88f.prompts[prompt].removing)) {
    return;
  }

  if(isDefined(self.var_3e95b88f.prompts[prompt])) {
    self.var_3e95b88f.prompts[prompt].state = state;
  }

  self notify(#"hash_4de92efaa3e2025e", {
    #prompt: prompt, #state: state
  });

  if(isDefined(self.var_3e95b88f.prompts[prompt].var_67eb3347)) {
    self thread[[self.var_3e95b88f.prompts[prompt].var_67eb3347]]({
      #prompt: prompt, #state: state
    });
  }

  if(isDefined(self.var_3e95b88f.var_294a441e[prompt]) && isDefined(self.var_3e95b88f.uid)) {
    namespace_61e6d095::function_f2a9266(uid, self.var_3e95b88f.var_294a441e[prompt], "state", state, self.var_3e95b88f.var_db58523e);
  }
}

function private function_9309081b(uid, prompt) {
  if(isDefined(self.var_3e95b88f.prompts[prompt].var_c570a6f9)) {
    self.var_3e95b88f.prompts[prompt].var_5a8a10f2 = undefined;
    self.var_3e95b88f.prompts[prompt].var_c570a6f9 = undefined;
    var_de6f0004 = isDefined(self.var_3e95b88f.prompts[prompt].var_de6f0004) ? self.var_3e95b88f.prompts[prompt].var_de6f0004 : 0.25;
    var_e8249df2 = var_de6f0004 < 0 ? -1 : 0;
    namespace_61e6d095::function_f2a9266(uid, self.var_3e95b88f.var_294a441e[prompt], "fraction", var_e8249df2, self.var_3e95b88f.var_db58523e);
  }
}

function private function_ab46a161(prompt, var_62bce5b6) {
  self endon(#"death", "prompt_removed_" + prompt);
  player = getplayers()[0];
  player endon(#"death");
  gamepad = player gamepadusedlast();
  var_1ea21098 = undefined;
  var_34fc0bda = undefined;
  uid = var_62bce5b6.uid;

  while(isDefined(var_62bce5b6.uid)) {
    is_disabled = isDefined(var_62bce5b6.prompts[prompt].state) && (var_62bce5b6.prompts[prompt].state == 0 || var_62bce5b6.prompts[prompt].state == 4);

    if(self[[level.prompts[prompt].var_92bb1cb1]]({
        #prompt: prompt, #var_62bce5b6: var_62bce5b6, #player: player
      }) && (is_true(var_62bce5b6.prompts[prompt].var_f14d06ca) || is_disabled)) {
      self function_2e6d74f5(prompt, 1);
    } else {
      self function_2e6d74f5(prompt, 0);
    }

    var_57f18593 = gamepad != player gamepadusedlast();

    if(var_57f18593) {
      gamepad = !gamepad;
      player val::reset_all(uid);
    }

    var_dc231c8e = 1;
    var_7a529262 = var_62bce5b6.prompts[prompt].var_8cff8c16;

    if(isDefined(var_7a529262)) {
      var_dc231c8e = self[[var_7a529262]]({
        #prompt: prompt, #var_62bce5b6: var_62bce5b6, #player: player
      });
    }

    if(var_1ea21098 !== is_disabled || var_34fc0bda !== var_dc231c8e || var_57f18593) {
      if(var_dc231c8e && !is_disabled) {
        function_f619081c(prompt, var_62bce5b6);
      } else {
        function_17578ab7(prompt, var_62bce5b6);
      }

      var_34fc0bda = var_dc231c8e;
      var_1ea21098 = is_disabled;
    }

    waitframe(1);
  }

  if(isDefined(uid) && !is_true(var_1ea21098)) {
    function_17578ab7(prompt, var_62bce5b6, uid);
  }
}

function private function_6d9e6b7d(player, prompt, uid) {
  player endon(#"death");
  self endon(#"hash_1316225507a4f1bb", "reset_button_inputs_" + prompt);

  while(true) {
    player waittill(#"weapon_fired");
    weapon = player getcurrentweapon();

    if(is_true(weapon.isboltaction) || player getweaponammoclip(weapon) == 0 && player getweaponammostock(weapon) > 0) {
      player val::reset(uid, "disable_weapon_reload");
      wait 0.5;
      player val::set(uid, "disable_weapon_reload", 1);
    }
  }
}

function private function_f619081c(prompt, var_62bce5b6) {
  player = getplayers()[0];

  switch (prompt) {
    case # "use":
    case # "use_tap":
      player val::set(var_62bce5b6.uid, "disable_usability", 1);
      player val::set(var_62bce5b6.uid, "disable_weapon_pickup", 1);

      if(player gamepadusedlast()) {
        player val::set(var_62bce5b6.uid, "disable_weapon_reload", 1);
        self thread function_6d9e6b7d(player, prompt, var_62bce5b6.uid);
      }

      break;
    case # "melee_hold":
    case # "melee":
      player val::set(var_62bce5b6.uid, "allow_melee", 0);
      break;
    case # "attack":
      player val::set(var_62bce5b6.uid, "disable_weapon_fire", 1);
      break;
    case # "reload":
      player val::set(var_62bce5b6.uid, "disable_weapon_reload", 1);
      self thread function_6d9e6b7d(player, prompt, var_62bce5b6.uid);

      if(player gamepadusedlast()) {
        player val::set(var_62bce5b6.uid, "disable_usability", 1);
        player val::set(var_62bce5b6.uid, "disable_weapon_pickup", 1);
      }

      break;
    case # "frag":
      player val::set(var_62bce5b6.uid, "disable_offhand_weapons", 1);
      break;
    case # "stance":
      stance = player getstance();

      if(stance == "stand") {
        player val::set(var_62bce5b6.uid, "allow_stand", 1);
        player val::set(var_62bce5b6.uid, "allow_crouch", 0);
        player val::set(var_62bce5b6.uid, "allow_prone", 0);
      } else if(stance == "crouch") {
        player val::set(var_62bce5b6.uid, "allow_stand", 0);
        player val::set(var_62bce5b6.uid, "allow_crouch", 1);
        player val::set(var_62bce5b6.uid, "allow_prone", 0);
      } else if(stance == "prone") {
        player val::set(var_62bce5b6.uid, "allow_stand", 0);
        player val::set(var_62bce5b6.uid, "allow_crouch", 0);
        player val::set(var_62bce5b6.uid, "allow_prone", 1);
      }

      break;
    case # "weapnext":
      player val::set(var_62bce5b6.uid, "disable_weapon_cycling", 1);
      break;
    case # "ads":
      player val::set(var_62bce5b6.uid, "allow_ads", 0);
      break;
  }
}

function private function_17578ab7(prompt, var_62bce5b6, uid = var_62bce5b6.uid) {
  player = getplayers()[0];

  if(isDefined(uid) && isDefined(player)) {
    if(!isDefined(prompt)) {
      player val::reset_all(uid);
      self notify(#"hash_1316225507a4f1bb");
      return;
    }

    switch (prompt) {
      case # "use":
      case # "use_tap":
        player val::reset(uid, "disable_usability");
        player val::reset(uid, "disable_weapon_pickup");

        if(player gamepadusedlast()) {
          player val::reset(uid, "disable_weapon_reload");
        }

        break;
      case # "melee_hold":
      case # "melee":
        player val::reset(uid, "allow_melee");
        break;
      case # "attack":
        player val::reset(uid, "disable_weapon_fire");
        break;
      case # "reload":
        player val::reset(uid, "disable_weapon_reload");

        if(player gamepadusedlast()) {
          player val::reset(uid, "disable_usability");
          player val::reset(uid, "disable_weapon_pickup");
        }

        break;
      case # "frag":
        player val::reset(uid, "disable_offhand_weapons");
        break;
      case # "stance":
        stance = player getstance();

        if(stance == "stand") {
          player val::reset(uid, "allow_stand");
          player val::reset(uid, "allow_crouch");
          player val::reset(uid, "allow_prone");
        } else if(stance == "crouch") {
          player val::reset(uid, "allow_stand");
          player val::reset(uid, "allow_crouch");
          player val::reset(uid, "allow_prone");
        } else if(stance == "prone") {
          player val::reset(uid, "allow_stand");
          player val::reset(uid, "allow_crouch");
          player val::reset(uid, "allow_prone");
        }

        break;
      case # "weapnext":
        player val::reset(uid, "disable_weapon_cycling");
        break;
      case # "ads":
        player val::reset(uid, "allow_ads");
        break;
    }

    self notify("reset_button_inputs_" + prompt);
  }
}

function private function_a6104953() {
  if(!isDefined(level.var_f4f784c9)) {
    level.var_f4f784c9 = 0;
  }

  if(!isDefined(self.var_3e95b88f.var_9215353e)) {
    self.var_3e95b88f.var_9215353e = "prompt_" + level.var_f4f784c9;
    level.var_f4f784c9++;
  }

  self.var_3e95b88f.uid = self.var_3e95b88f.var_9215353e;
  uid = self.var_3e95b88f.uid;
  var_3a6b0af4 = undefined;
  clamp = 1;
  hud = self.var_3e95b88f.hud;

  if(level.var_a48f9f79[#"hash_464a6e9e035a826e"] > 0) {
    hud = 1;
  } else if(level.var_a48f9f79[#"hash_464a6e9e035a826e"] < 0) {
    hud = 0;
  }

  if(hud) {
    namespace_61e6d095::create(uid, #"hash_2a9f8d08dadef41e");
    self thread function_17533001(uid);

    if(isentity(self)) {
      self thread namespace_61e6d095::delete_on_death(uid);
    }

    if(!is_true(self.var_3e95b88f.var_a5ce465f) && !isPlayer(self) && (!isactor(self) || isDefined(self.var_3e95b88f.prompts[#"use"]))) {
      self.var_3e95b88f.var_b003a020 = uid + "_circle";
      var_3a6b0af4 = self.var_3e95b88f.var_b003a020;
      clamp = 0;
      namespace_61e6d095::create(var_3a6b0af4, #"hash_115c63d4ac6a1d5f");
    }
  } else {
    var_3a6b0af4 = uid;
    namespace_61e6d095::create(uid, #"hash_57fd5ecbc8126b21");
  }

  if(isDefined(var_3a6b0af4)) {
    if(isDefined(self.var_3e95b88f.text)) {
      namespace_61e6d095::set_text(var_3a6b0af4, self.var_3e95b88f.text);
    }

    if(isDefined(self.var_3e95b88f.image)) {
      namespace_61e6d095::function_309bf7c2(var_3a6b0af4, self.var_3e95b88f.image);
    }

    namespace_61e6d095::set_alpha(var_3a6b0af4, 0);
    namespace_61e6d095::set_ent(var_3a6b0af4, self);
    offset = isDefined(self.var_3e95b88f.offset) ? self.var_3e95b88f.offset : (0, 0, 0);

    if(!self function_5a11b8f6()) {
      offset += self.origin;
      self.var_3e95b88f.var_80778410 = 0;
    }

    if(offset != (0, 0, 0)) {
      if(offset[0] != 0) {
        namespace_61e6d095::function_4d9fbc9d(var_3a6b0af4, offset[0]);
      }

      if(offset[1] != 0) {
        namespace_61e6d095::function_52dbc715(var_3a6b0af4, offset[1]);
      }

      if(offset[2] != 0) {
        namespace_61e6d095::function_60856268(var_3a6b0af4, offset[2]);
      }
    }

    if(isDefined(self.var_3e95b88f.tag)) {
      namespace_61e6d095::function_8aa0007(var_3a6b0af4, self.var_3e95b88f.tag);
    } else {
      namespace_61e6d095::function_e648abd8(var_3a6b0af4, is_true(self.var_3e95b88f.var_754bedbb));
    }

    namespace_61e6d095::function_9c3ced73(var_3a6b0af4, self.var_3e95b88f.var_80778410);
    namespace_61e6d095::function_eb16868b(var_3a6b0af4, 1);
    namespace_61e6d095::function_4ef79fca(var_3a6b0af4, clamp);
    namespace_61e6d095::set_state(var_3a6b0af4, 0);
  }

  namespace_61e6d095::function_b1e6d7a8(uid, 0);
  namespace_61e6d095::set_state(uid, 0);
  namespace_61e6d095::function_330981ed(uid);
  self notify(#"hash_6bf192c39a59f343");
}

function private function_263b3850(uid, prompt, player) {
  if(!namespace_61e6d095::function_cd59371c(uid, self.var_3e95b88f.var_294a441e[prompt], self.var_3e95b88f.var_db58523e) && !is_true(self.var_3e95b88f.prompts[prompt].removing)) {
    var_7125b341 = 0;

    if(isDefined(self.var_3e95b88f.prompts[prompt].prompt_text)) {
      namespace_61e6d095::function_f2a9266(uid, self.var_3e95b88f.var_294a441e[prompt], "text", self.var_3e95b88f.prompts[prompt].prompt_text, self.var_3e95b88f.var_db58523e);
      var_7125b341 = 1;
    }

    if(isDefined(level.prompts[prompt].button_text)) {
      if(isDefined(level.prompts[prompt].var_e4c7b05f)) {
        self thread function_93551c9a(uid, prompt);
      } else {
        namespace_61e6d095::function_f2a9266(uid, self.var_3e95b88f.var_294a441e[prompt], "button_text", level.prompts[prompt].button_text, self.var_3e95b88f.var_db58523e);
      }

      var_7125b341 = 1;
    }

    if(isDefined(level.prompts[prompt].button_action)) {
      namespace_61e6d095::function_f2a9266(uid, self.var_3e95b88f.var_294a441e[prompt], "button_action", level.prompts[prompt].button_action, self.var_3e95b88f.var_db58523e);
      var_7125b341 = 1;
    }

    var_2625ed95 = int((isDefined(self.var_3e95b88f.prompts[prompt].var_de6f0004) ? self.var_3e95b88f.prompts[prompt].var_de6f0004 : 0.25) * 1000);

    if(var_2625ed95 <= 0 || function_2af9819b(prompt, self.var_3e95b88f.prompts[prompt], player)) {
      namespace_61e6d095::function_f2a9266(uid, self.var_3e95b88f.var_294a441e[prompt], "fraction", -1, self.var_3e95b88f.var_db58523e);
    } else {
      namespace_61e6d095::function_f2a9266(uid, self.var_3e95b88f.var_294a441e[prompt], "fraction", 0, self.var_3e95b88f.var_db58523e);
    }

    if(var_7125b341) {
      namespace_61e6d095::function_f2a9266(uid, self.var_3e95b88f.var_294a441e[prompt], "state", self.var_3e95b88f.prompts[prompt].state, self.var_3e95b88f.var_db58523e);
    }

    if(isDefined(self.var_3e95b88f.prompts[prompt].var_67eb3347)) {
      self thread[[self.var_3e95b88f.prompts[prompt].var_67eb3347]]({
        #prompt: prompt, #state: self.var_3e95b88f.prompts[prompt].state
      });
    }

    flags = self.var_3e95b88f.prompts[prompt].flags;

    if(level.var_a48f9f79[#"hash_464a6e9e035a826e"] == 2) {
      flags &= ~1;
    } else if(level.var_a48f9f79[#"hash_464a6e9e035a826e"] == 3) {
      flags |= 1;
    }

    namespace_61e6d095::function_9bc1d2f1(uid, self.var_3e95b88f.var_294a441e[prompt], flags, 1, "flags", self.var_3e95b88f.var_db58523e);

    if(isDefined(level.prompts[prompt].var_9a98e590)) {
      self thread[[level.prompts[prompt].var_9a98e590]](prompt, self.var_3e95b88f);
    }
  }
}

function private function_8de9a77a() {
  namespace_61e6d095::remove(self.var_3e95b88f.uid);

  if(isDefined(self.var_3e95b88f.var_b003a020)) {
    namespace_61e6d095::remove(self.var_3e95b88f.var_b003a020);
    self.var_3e95b88f.var_b003a020 = undefined;
  }

  if(isDefined(self.var_3e95b88f.objective)) {
    objectives_ui::function_278c15e6(self.var_3e95b88f.objective, self, 0);
  }

  if(self flag::get(#"hash_305ce4d5b74a637a")) {
    self flag::clear(#"hash_305ce4d5b74a637a");
    player = getplayers()[0];
    player flag::clear(#"hash_599ec0eee77657ef");
    player val::reset_all(#"hash_599ec0eee77657ef");
  }

  self notify(#"hash_7d3af7cbbc793b23");
  self.var_3e95b88f.uid = undefined;
}

function private function_93551c9a(uid, prompt) {
  self endon(#"death", "prompt_removed_" + prompt, #"hash_7d3af7cbbc793b23");
  player = getplayers()[0];
  player endon(#"death");
  gamepad = player gamepadusedlast();
  button_text[0] = level.prompts[prompt].var_e4c7b05f;
  button_text[1] = level.prompts[prompt].button_text;
  namespace_61e6d095::function_f2a9266(uid, self.var_3e95b88f.var_294a441e[prompt], "button_text", button_text[gamepad], self.var_3e95b88f.var_db58523e);

  while(true) {
    waitframe(1);

    if(gamepad != player gamepadusedlast()) {
      gamepad = !gamepad;
      namespace_61e6d095::function_f2a9266(uid, self.var_3e95b88f.var_294a441e[prompt], "button_text", button_text[gamepad], self.var_3e95b88f.var_db58523e);
    }
  }
}

function private function_17533001(uid) {
  self endoncallback(&function_74f42405, #"death", #"all_prompts_removed", #"hash_7d3af7cbbc793b23");
  level endon(#"level_restarting");
  actor_name = isDefined(self.var_3e95b88f.display_name) ? self.var_3e95b88f.display_name : self function_7f0363e8();
  var_2d3f59fc = isDefined(self.var_3e95b88f.team) ? self.var_3e95b88f.team : util::getteamindex(self getteam());

  if(actor_name === "") {
    actor_name = undefined;
  }

  while(true) {
    ret = self waittill(#"hash_5ede0284920c4c56");

    if(ret.interactable || isDefined(self.var_3e95b88f.var_fc01e65d)) {
      if(isDefined(self.var_3e95b88f.namespace_image)) {
        namespace_61e6d095::function_9ade1d9b(uid, "namespace_image", self.var_3e95b88f.namespace_image);
        namespace_61e6d095::function_b1e6d7a8(uid, isDefined(self.var_3e95b88f.var_fc01e65d) ? self.var_3e95b88f.var_fc01e65d : 0);
        self globallogic_ui::function_ec25f500(" ", 0);
      } else if(isDefined(actor_name)) {
        self globallogic_ui::function_ec25f500(actor_name, var_2d3f59fc);
      }

      continue;
    }

    if(isDefined(self.var_3e95b88f.namespace_image)) {
      namespace_61e6d095::function_9ade1d9b(uid, "namespace_image", #"");
      namespace_61e6d095::function_b1e6d7a8(uid, 0);
      self globallogic_ui::function_109202c3();
      continue;
    }

    if(isDefined(actor_name)) {
      self globallogic_ui::function_109202c3();
    }
  }
}

function private function_74f42405(end_on) {
  self globallogic_ui::function_109202c3();
}

function private function_5a11b8f6() {
  if(isstruct(self) || self.classname === "script_origin" || isPlayer(self)) {
    return false;
  }

  return true;
}