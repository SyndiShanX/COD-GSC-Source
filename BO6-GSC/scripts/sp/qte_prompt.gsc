/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\qte_prompt.gsc
**************************************/

#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\values;
#using scripts\engine\hud_management;
#using scripts\engine\utility;
#namespace qte_prompt;

function private autoexec __init__system__() {
  system::register(#"qte_prompt", undefined, undefined, &post_main);
}

function private post_main() {
  thread function_433ea44c099a4727();
}

function private function_433ea44c099a4727() {
  ui::lui_registercallback("\xa9\x97f\xcc\xed]\x1a\x15S\xef[\xec\x84kd9\x8d\xd6g>\xec", &qte_sequence_complete);
  level utility::flag_set("\x8b:\x95\xfa\x1cN\xed[\x0e\x1d\xafi\xe6\xd2\x1d\x96\x16\x8d\xa5z\xca\x19");
}

function function_ae26a5caf1ee4fdc(scene, var_fa4641bec05e765d) {
  foreach(note_data in var_fa4641bec05e765d) {
    scene scene::function_993ae53c5ec4240b(note_data.target, note_data.note_name, note_data.scene_object, note_data.does_repeat);
  }

  utility::ent_flag_clear("\xf8\x84\xd9M%^\xc2,\xab*");
}

function function_9bdb9c822bded22(scene_name, scene_struct, scene_ents, var_3e5817856680f757, var_86654025d0026d70, var_5e051be9d46ccdc9, var_e4c78e0fe3f26553, sequence_ref) {
  scene_data = spawnStruct();
  assert(isDefined(scene_name), "<dev string:x24>");
  scene_data.scene_name = scene_name;
  assert(isDefined(scene_struct), "<dev string:x6a>");
  scene_data.scene = scene_struct;
  assert(isDefined(scene_ents), "<dev string:xb2>");
  scene_data.scene_ents = scene_ents;
  assert(isDefined(var_3e5817856680f757), "<dev string:xfa>");
  scene_data.var_3e5817856680f757 = var_3e5817856680f757;
  assert(isDefined(var_86654025d0026d70), "<dev string:x145>");
  scene_data.main_shot = var_86654025d0026d70;
  assert(isDefined(var_5e051be9d46ccdc9), "<dev string:x193>");
  scene_data.fail_shot = var_5e051be9d46ccdc9;
  assert(isDefined(var_e4c78e0fe3f26553), "<dev string:x1e1>");
  scene_data.var_42e6b998beaec615 = var_e4c78e0fe3f26553;
  return scene_data;
}

function function_e3708172bd159dde(var_94ebc78290826946, var_4fcfe1e4006a9436) {
  return (var_94ebc78290826946 - var_4fcfe1e4006a9436) * 0.033;
}

function function_1bad9dc62c53cd(initial, final = 1, delta = 0) {
  time_data = spawnStruct();
  assert(isDefined(initial), "<dev string:x230>");
  time_data.initial = initial;
  time_data.final = final;
  time_data.delta = delta;
  return time_data;
}

function function_929ef756eea7db47(mash_value = 5, decay_value = 1, start_value = 60) {
  var_d25a7c71bb607981 = spawnStruct();
  var_d25a7c71bb607981.mash_value = mash_value;
  var_d25a7c71bb607981.decay_value = decay_value;
  var_d25a7c71bb607981.start_value = start_value;
  return var_d25a7c71bb607981;
}

function function_a8532a3a46e0e597(ref = undefined, shot_name = undefined, input = undefined, anchor_data = undefined, var_b4abfca89641f973 = undefined, decision_time = 0, var_659bb3b0fb6d222f = undefined, var_22f5b1517e2f1c3a = undefined, var_767e1cd1672beb0 = undefined, var_d25a7c71bb607981 = undefined) {
  choice_data = spawnStruct();
  assert(isDefined(ref), "<dev string:x26b>");
  choice_data.ref = ref;
  assert(isDefined(input), "<dev string:x29f>");
  choice_data.input = input;
  assert(isDefined(anchor_data), "<dev string:x2ef>");
  choice_data.anchor_data = anchor_data;
  assert(isDefined(var_b4abfca89641f973), "<dev string:x343>");
  choice_data.var_b4abfca89641f973 = var_b4abfca89641f973;
  choice_data.shot_name = shot_name;
  choice_data.decision_time = decision_time;
  choice_data.var_c3e808ea3febcde5 = var_659bb3b0fb6d222f;
  choice_data.callback_func = var_22f5b1517e2f1c3a;
  choice_data.timescale_data = var_767e1cd1672beb0;
  choice_data.var_d25a7c71bb607981 = var_d25a7c71bb607981;
  choice_data.is_button_mash = 0;

  if(isDefined(var_d25a7c71bb607981)) {
    choice_data.is_button_mash = 1;
  }

  return choice_data;
}

function function_ce770f6dc8e89cc8(qte_data) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  assert(isDefined(qte_data.scene_data), "<dev string:x39e>");
  assert(isDefined(qte_data.choices_array), "<dev string:x420>");

  if(utility::ent_flag("\xf8\x84\xd9M%^\xc2,\xab*")) {
    if(!isDefined(self.var_1bbe064e764889b8)) {
      self.var_1bbe064e764889b8 = [];
    }

    self.var_1bbe064e764889b8[self.var_1bbe064e764889b8.size] = qte_data;
    return;
  }

  self.var_105dc12f73347abb = qte_data.scene_data.sequence_ref;
  thread qte_process_event(qte_data);
}

function private function_da67744ea91e96be(anchor_ent, widget_ref, widget_type, anchor_type, archetype_fields) {
  hud_management::function_f084d4c0fc5a8b4b(anchor_ent, widget_ref, widget_type, anchor_type);
  hud_management::function_282d7915f90d757c(anchor_ent, widget_ref, archetype_fields);
  hud_management::function_583d46528b2c47a(anchor_ent, widget_ref, "\xf1\xba\x8f\x9d");
}

function private qte_process_event(qte_data) {
  self notify("Z\xd6m\xb0tzcNr\x80\xae\x8f\xa2\n*v\xb0");
  self endon("Z\xd6m\xb0tzcNr\x80\xae\x8f\xa2\n*v\xb0");
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  utility::ent_flag_set("\xf8\x84\xd9M%^\xc2,\xab*");
  val::set_array("\xbc2)\xda \x02+\xa6w\xed", ["\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ", "y\xec\xfb2\x97\x904\xb9\xd7aMa\x1a", "\xe2,^\xd6p\xea\xde\xb7X+\x19\xe8\x9f\xa7VG\x1d\xb01\xbd\xf2", "\xdeu\xb6Qb\xdd\xa6c\x8a\xc9\x04\x80\xb5X", "\vz4-S\xd4H\xd4\xe8\x93\xed\b\x9a8gss^\xad", "e\xac\xb6 \x8e\x02\v\xd1Knl\xe6\x19\xb6\a*^\xd3+f\x96\xff", "a\xd8c\xb7\xdd\xd7\xc6-8\xa1\xb2\x93\xbe\x83W\xa7\xe9\x1bV"], 0);
  scene_data = qte_data.scene_data;
  scene_data.scene thread scene::play(scene_data.scene_ents, scene_data.main_shot, scene_data.scene_name);
  self waittill(scene_data.var_3e5817856680f757);
  soundsettimescalefactorfromtable("\xabI\xb1\x93\xa0\xcf\xed\xf5\xe8i\x11\"\x1e\xc5\xd6\x8ep");

  if(isDefined(qte_data.time_options)) {
    setslowmotion(qte_data.time_options.initial, qte_data.time_options.final, qte_data.time_options.delta);
  }

  self.var_2b7190ac8a1a3f81 = [];
  self.var_8b7284b62a7e3dba = undefined;
  self.var_8db7c32f51493255 = undefined;
  self.var_6c8799766e440df8 = undefined;
  self.var_de0ca57cf9ad826d = undefined;

  foreach(choice in qte_data.choices_array) {
    function_5579b698d980bcaa(choice);

    if(choice.is_button_mash == 1) {
      thread function_972d904d38a4a36c(choice);
      continue;
    }

    thread function_b69d7c0f5b5c1c1b(choice);

    if(!isDefined(self.var_5cfdde2ced179aca)) {
      self.var_5cfdde2ced179aca = choice.decision_time;
      childthread function_3d530b0cd5673645();
    }
  }

  msg = utility::waittill_any_return("e\x97\xbeM\xc9\xfe\xc2\xa2\xfd\xdcZn\xe3\x1b\xaf", "8\xdb\x90", "\xb8\x8e\xac\xeb\x98\xea\xa3\xd1\xde7\xeb\xb6,\xdc\x1a\xeb\xdc\xba\xb1\xb1\x95s7", "|z\xa4\xa2\x18\xac,9#\xb6\xec(\xff\xb5\x97\x1f\xa2\xf8t1");

  if(isDefined(self.var_de0ca57cf9ad826d)) {
    setslowmotion(self.var_de0ca57cf9ad826d.initial, self.var_de0ca57cf9ad826d.final, self.var_de0ca57cf9ad826d.delta);
  } else {
    setslowmotion(1, 1, 0);
    settimescale(1);
  }

  soundsettimescalefactorfromtable("!kk\t\xdb\xe5\x8c\xca\x94\rD\xb7\x13\x13");
  var_a1ef25c1779eb33c = function_ea629f8b965fb697();

  if(msg == "e\x97\xbeM\xc9\xfe\xc2\xa2\xfd\xdcZn\xe3\x1b\xaf" && !var_a1ef25c1779eb33c) {
    self waittill("8\xdb\x90");
  }

  utility::ent_flag_clear("\xf8\x84\xd9M%^\xc2,\xab*");
  self.var_5cfdde2ced179aca = undefined;

  if(msg == "e\x97\xbeM\xc9\xfe\xc2\xa2\xfd\xdcZn\xe3\x1b\xaf" || msg == "\xb8\x8e\xac\xeb\x98\xea\xa3\xd1\xde7\xeb\xb6,\xdc\x1a\xeb\xdc\xba\xb1\xb1\x95s7") {
    if(isDefined(self.var_8b7284b62a7e3dba)) {
      scene_data.scene scene::play(scene_data.scene_ents, self.var_8b7284b62a7e3dba, scene_data.scene_name);
    }

    if(isDefined(self.var_8db7c32f51493255)) {
      self thread[[self.var_8db7c32f51493255]]();
    }

    if(isDefined(self.var_6c8799766e440df8)) {
      self thread[[self.var_6c8799766e440df8]]();
    } else {
      thread function_e43320e7e52dcc39();
    }
  } else if(msg == "8\xdb\x90" || msg == "|z\xa4\xa2\x18\xac,9#\xb6\xec(\xff\xb5\x97\x1f\xa2\xf8t1") {
    self notify("\t\x7f\x96G\x87\x92\x04{");
    scene_data.scene thread scene::play(scene_data.scene_ents, scene_data.fail_shot, scene_data.scene_name);
    self[[scene_data.var_42e6b998beaec615]]();
  }

  val::reset_all("\xbc2)\xda \x02+\xa6w\xed");
}

function private qte_sequence_complete(val) {
  println("<dev string:x4ab>");
  anchor_ents = self.var_2b7190ac8a1a3f81;

  foreach(ent in anchor_ents) {
    hud_management::function_3f1b5295108139ee(ent);
  }
}

function private function_21e32a456c1d7b4c(choice_data, mash_value) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("|z\xa4\xa2\x18\xac,9#\xb6\xec(\xff\xb5\x97\x1f\xa2\xf8t1");
  choice_ref = choice_data.ref;

  while(true) {
    self notifyonplayercommand(choice_ref, choice_data.input);
    self waittill(choice_ref);
    self notify(";[d\x81T`\xffw\x91\xf7k\xd50\x963\x0f\xaf\x1b,\xd6\x80b/\xe1\x05at\xc9\x95\x05");
    self.current_progress += mash_value;

    if(self.current_progress >= 100) {
      self.var_8b7284b62a7e3dba = choice_data.shot_name;
      self.var_8db7c32f51493255 = choice_data.callback_func;
      self.var_6c8799766e440df8 = choice_data.var_c3e808ea3febcde5;
      self.var_de0ca57cf9ad826d = choice_data.timescale_data;
      self notify("\xb8\x8e\xac\xeb\x98\xea\xa3\xd1\xde7\xeb\xb6,\xdc\x1a\xeb\xdc\xba\xb1\xb1\x95s7");
      hud_management::function_583d46528b2c47a(self.var_2b7190ac8a1a3f81[choice_ref], choice_ref, "\x8b\a\x17_");
      self notifyonplayercommandremove(choice_ref, choice_data.input);
      break;
    }
  }
}

function private function_972d904d38a4a36c(choice_data) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("\xb8\x8e\xac\xeb\x98\xea\xa3\xd1\xde7\xeb\xb6,\xdc\x1a\xeb\xdc\xba\xb1\xb1\x95s7");
  choice_ref = choice_data.ref;
  self.current_progress = choice_data.var_d25a7c71bb607981.start_value;
  decay_value = choice_data.var_d25a7c71bb607981.decay_value;
  mash_value = choice_data.var_d25a7c71bb607981.mash_value;
  thread function_21e32a456c1d7b4c(choice_data, mash_value);
  fields = [];

  while(true) {
    waitframe();
    self.current_progress -= decay_value;

    if(self.current_progress <= 20) {
      self notify("|z\xa4\xa2\x18\xac,9#\xb6\xec(\xff\xb5\x97\x1f\xa2\xf8t1");
      hud_management::function_583d46528b2c47a(self.var_2b7190ac8a1a3f81[choice_ref], choice_ref, "\xf70C\x15");
      self notifyonplayercommandremove(choice_ref, choice_data.input);
      break;
    }

    progress_pct = self.current_progress / 100;
    fields["\xb9\xf3u\x98}s\xdc\xa2\xceK68"] = progress_pct;
    hud_management::function_282d7915f90d757c(self.var_2b7190ac8a1a3f81[choice_ref], choice_ref, fields);
  }
}

function private function_b69d7c0f5b5c1c1b(choice_data) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  choice_ref = choice_data.ref;
  self notifyonplayercommand(choice_ref, choice_data.input);
  msg = utility::waittill_any_return(choice_ref, "e\x97\xbeM\xc9\xfe\xc2\xa2\xfd\xdcZn\xe3\x1b\xaf", "\t\x7f\x96G\x87\x92\x04{");
  widget_state = undefined;

  if(msg == choice_ref) {
    self.var_8b7284b62a7e3dba = choice_data.shot_name;
    self.var_8db7c32f51493255 = choice_data.callback_func;
    self.var_6c8799766e440df8 = choice_data.var_c3e808ea3febcde5;
    self.var_de0ca57cf9ad826d = choice_data.timescale_data;
    widget_state = "\x8b\a\x17_";
    self notify("e\x97\xbeM\xc9\xfe\xc2\xa2\xfd\xdcZn\xe3\x1b\xaf");
  } else if(msg == "e\x97\xbeM\xc9\xfe\xc2\xa2\xfd\xdcZn\xe3\x1b\xaf") {
    widget_state = "\x19b\xc2y";
  } else {
    widget_state = "\xf70C\x15";
  }

  hud_management::function_583d46528b2c47a(self.var_2b7190ac8a1a3f81[choice_ref], choice_ref, widget_state);
  self notifyonplayercommandremove(choice_ref, choice_data.input);
}

function private function_5579b698d980bcaa(choice_data) {
  var_5350667d368e8d73 = utility::getStruct(choice_data.anchor_data, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
  var_6743124af6f69fe1 = var_5350667d368e8d73 utility::function_94c66bbed3da2a18(var_5350667d368e8d73.origin, var_5350667d368e8d73.angles);
  self.var_2b7190ac8a1a3f81[choice_data.ref] = var_6743124af6f69fe1;
  soundtable_index = function_8b1b61614baf5baf(var_6743124af6f69fe1);
  var_fcef1d1f4dbe5290 = [];
  var_fcef1d1f4dbe5290["\xe2\xa7.m\xa5\xf2\x18\x84\f\xc45~x\x9f:"] = function_30e4f86dded0873(choice_data.var_b4abfca89641f973);
  var_fcef1d1f4dbe5290["\x92\xd3\x9f\xbb"] = choice_data.decision_time;
  var_fcef1d1f4dbe5290["7T\xef~\xab\x1e\xb9\b\x10\xee\xc0\xb9\xb2m g"] = soundtable_index;
  var_fcef1d1f4dbe5290["\x12\x89~h\xbeq\f\x0e\xd3^\x88O$\xe0"] = choice_data.is_button_mash;
  function_da67744ea91e96be(var_6743124af6f69fe1, choice_data.ref, "\x97G)3t;\xb1+\x9dC\xfb\xcc&\xc9l\xb9\x85\xa7]@\x8f\xcc\xec\xe7\n{", "\xb9l\xe4\xd2\x83\x8e\xb2d\xd7\xee\xb4d\x9d\xac\xa3\xaf\x85\xcdlh\xb7\x93\xaf\xdbr\xb4v\xa57\xeb\xd8la\xb6\xe0\xca\x8c", var_fcef1d1f4dbe5290);
  var_6743124af6f69fe1 thread utility::function_591376874f1f2f4(self, "\x15\xbcX\x19vI\x7f\\\xf7\xeb}l\x168vP\xe7:@\x04fg\xe8D\\\x91" + choice_data.ref);
}

function private function_e43320e7e52dcc39() {
  if(!isDefined(self.var_1bbe064e764889b8)) {
    return;
  }

  if(self.var_1bbe064e764889b8 > 0) {
    var_cd3ac0438656d357 = self.var_1bbe064e764889b8[0];
    thread qte_process_event(var_cd3ac0438656d357);
    self.var_1bbe064e764889b8 = utility::array_remove_index(self.var_1bbe064e764889b8, 0);
  }
}

function private function_8b1b61614baf5baf(anchor_ent) {
  index = 2;
  to_ent = anchor_ent.origin - self getEye();
  var_37df0e6bf424b9bc = vectorNormalize((to_ent[0], to_ent[1], 0));
  player_right = anglestoright(self getplayerangles());
  dot = vectordot(var_37df0e6bf424b9bc, player_right);

  if(abs(dot < 0.134)) {
    index = 3;
  } else if(dot < 0) {
    index = 1;
  }

  return index;
}

function private function_3d530b0cd5673645() {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("e\x97\xbeM\xc9\xfe\xc2\xa2\xfd\xdcZn\xe3\x1b\xaf");
  self endon("8\xdb\x90");
  self.var_2629dc13ff40853b = 0;

  while(self.var_2629dc13ff40853b < self.var_5cfdde2ced179aca) {
    self.var_2629dc13ff40853b += 0.033;
    waitframe();
  }
}

function private function_ea629f8b965fb697() {
  result = 1;

  if(isDefined(self.var_5cfdde2ced179aca)) {
    var_d8c15ad146a9793e = self.var_5cfdde2ced179aca - 0.26;

    if(self.var_2629dc13ff40853b < var_d8c15ad146a9793e) {
      result = 0;
    }
  }

  return result;
}