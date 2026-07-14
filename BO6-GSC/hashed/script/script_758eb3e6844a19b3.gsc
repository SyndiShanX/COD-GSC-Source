/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_758eb3e6844a19b3.gsc
*****************************************************/

#using scripts\common\system;
#using scripts\common\ui;
#using scripts\engine\hud_management;
#namespace input_prompts;

function private autoexec __init__system__() {
  system::register(#"input_prompts", undefined, undefined, &post_main);
}

function private post_main() {
  if(!isDefined(level.input_prompts)) {
    level.input_prompts = spawnStruct();
  }

  level.input_prompts.groups = [];
  level.input_prompts.lookups = [];
  ui::lui_registercallback("\xa5\xcdp\xd5G}\xe0r\xedm\xc1:\xebn\xae\x1bl\xca7s", &success);
  groups = getscriptbundlenames("\xb478Wt\x1c\xc9\xed\xb5\xe0\xe8\xb39\xb7\xab\a");

  foreach(group in groups) {
    function_21e6efbfb5980c03(group);
  }
}

function function_21e6efbfb5980c03(var_e88a5e3a7c49084) {
  if(!isxhashasset(var_e88a5e3a7c49084)) {
    var_e88a5e3a7c49084 = hashcat(%"hash_2e2c28b413c2b7e7", var_e88a5e3a7c49084);
  }

  data = getscriptbundle(var_e88a5e3a7c49084);

  if(isDefined(data.var_8ce42bab3779be5b) && isstring(data.var_8ce42bab3779be5b)) {
    switch (data.var_8ce42bab3779be5b) {
      case #"hash_fcca13ff94fb6ab0":
        data.var_8ce42bab3779be5b = 0;
        break;
      case #"hash_a653d8ebf51ebac4":
        data.var_8ce42bab3779be5b = 1;
        break;
      case #"hash_5b6fb3c943bab625":
        data.var_8ce42bab3779be5b = 2;
        break;
      case #"hash_175a301ae8d1236a":
        data.var_8ce42bab3779be5b = 3;
        break;
      default:
        data.var_8ce42bab3779be5b = undefined;
        break;
    }
  }

  if(isDefined(data.var_b0042c68cb799285) && isstring(data.var_b0042c68cb799285)) {
    switch (data.var_b0042c68cb799285) {
      case #"hash_58baad6cbe764d7c":
        data.var_b0042c68cb799285 = 0;
        break;
      case #"hash_4fdc8686e8ea358":
        data.var_b0042c68cb799285 = 1;
        break;
      case #"hash_62df33229372c36a":
        data.var_b0042c68cb799285 = 2;
        break;
      case #"hash_175a301ae8d1236a":
        data.var_b0042c68cb799285 = 3;
        break;
      default:
        data.var_b0042c68cb799285 = undefined;
        break;
    }
  }

  if(isDefined(data.var_580d3f4a43b4538f) && isstring(data.var_580d3f4a43b4538f)) {
    switch (data.var_580d3f4a43b4538f) {
      case #"hash_fcca13ff94fb6ab0":
        data.var_580d3f4a43b4538f = 0;
        break;
      case #"hash_a653d8ebf51ebac4":
        data.var_580d3f4a43b4538f = 1;
        break;
      case #"hash_5b6fb3c943bab625":
        data.var_580d3f4a43b4538f = 2;
        break;
      case #"hash_175a301ae8d1236a":
        data.var_580d3f4a43b4538f = 3;
        break;
      default:
        data.var_580d3f4a43b4538f = undefined;
        break;
    }
  }

  if(isDefined(data.var_cd95faa9d2343fe9) && isstring(data.var_cd95faa9d2343fe9)) {
    switch (data.var_cd95faa9d2343fe9) {
      case #"hash_58baad6cbe764d7c":
        data.var_cd95faa9d2343fe9 = 0;
        break;
      case #"hash_4fdc8686e8ea358":
        data.var_cd95faa9d2343fe9 = 1;
        break;
      case #"hash_62df33229372c36a":
        data.var_cd95faa9d2343fe9 = 2;
        break;
      case #"hash_175a301ae8d1236a":
        data.var_cd95faa9d2343fe9 = 3;
        break;
      default:
        data.var_cd95faa9d2343fe9 = undefined;
        break;
    }
  }

  register_group(data.name, data.list_widget, data.prompt_widget, data.x_pos, data.y_pos, data.var_8ce42bab3779be5b, data.var_b0042c68cb799285, data.var_580d3f4a43b4538f, data.var_cd95faa9d2343fe9);
}

function register_group(group_name, list_widget = "S\x1b\xb3\xf2\x8d\x19\xe7\x80@\xf2\x03\xa8\xc7)u@\t\x7fR\xae\x81T\xeb\x1f$\xfb\xec\x95", prompt_widget = "b|Nh\xc8\xce{\xea\x83\x85\xd2\x84+s\xa5\xb8\x06\x9e\x82\xaf\x9d\xf44k0\x97\xe8\x16", pos_x, pos_y, var_8ce42bab3779be5b, var_b0042c68cb799285, var_580d3f4a43b4538f, var_cd95faa9d2343fe9) {
  group_name = tolower(group_name);
  level.input_prompts.groups[group_name] = spawnStruct();
  level.input_prompts.groups[group_name].pos_x = pos_x ?? 0;
  level.input_prompts.groups[group_name].pos_y = pos_y ?? 0;
  level.input_prompts.groups[group_name].list_widget = list_widget;
  level.input_prompts.groups[group_name].prompt_widget = prompt_widget;
  level.input_prompts.groups[group_name].var_8ce42bab3779be5b = var_8ce42bab3779be5b ?? 1;
  level.input_prompts.groups[group_name].var_b0042c68cb799285 = var_b0042c68cb799285 ?? 1;
  level.input_prompts.groups[group_name].var_580d3f4a43b4538f = var_580d3f4a43b4538f ?? 1;
  level.input_prompts.groups[group_name].var_cd95faa9d2343fe9 = var_cd95faa9d2343fe9 ?? 1;
  level.input_prompts.groups[group_name].prompts = [];
}

function function_e1ed844222decdfd(group_name, prompt_ref, prompt_text, hold_time, clientside_input, consume_input, keep_filled, success_callback, var_e7db9f4254c6cef8) {
  group_name = tolower(group_name);
  prompt_ref = tolower(prompt_ref);
  assert(isDefined(level.input_prompts) && isDefined(level.input_prompts.groups[group_name]), "<dev string:x24>" + group_name + "<dev string:x86>");

  if(!hud_management::function_48c98ea9a4f0da89(group_name)) {
    hud_management::function_91ff36a22dc2c60e(group_name, level.input_prompts.groups[group_name].list_widget);
    hud_management::function_85d8a0ba2e35b6f2(group_name, level.input_prompts.groups[group_name].pos_x, level.input_prompts.groups[group_name].pos_y, level.input_prompts.groups[group_name].var_8ce42bab3779be5b, level.input_prompts.groups[group_name].var_b0042c68cb799285);
    hud_management::function_df75afbce41341f9(group_name, level.input_prompts.groups[group_name].var_580d3f4a43b4538f, level.input_prompts.groups[group_name].var_cd95faa9d2343fe9);
  }

  if(!isDefined(var_e7db9f4254c6cef8)) {
    var_e7db9f4254c6cef8 = level.input_prompts.groups[group_name].prompt_widget;
  }

  if(!hud_management::function_f5acbf99bab0dc68(group_name, prompt_ref)) {
    hud_management::function_222841054993effd(group_name, prompt_ref, var_e7db9f4254c6cef8);
  }

  var_c752b1ba4163d648 = spawnStruct();
  var_c752b1ba4163d648.group = group_name;
  var_c752b1ba4163d648.prompt = prompt_ref;
  item_index = hud_management::function_79735b461f0a5aeb(group_name, prompt_ref);
  level.input_prompts.lookups[item_index] = var_c752b1ba4163d648;
  fields = [];
  fields["\xe2\xa7.m\xa5\xf2\x18\x84\f\xc45~x\x9f:"] = function_30e4f86dded0873(prompt_text);
  fields["\x92\xd3\x9f\xbb"] = hold_time ?? 0;
  fields["\xee\x18A\xce\xda\xe8\xe7p#WM\x0e\xd8\x8e\xb8N"] = istrue(clientside_input);
  fields["\xcaY\x15\x15\xe6)q\x1f\v\xb6w\x94\x8d"] = istrue(consume_input);
  fields["\x80z\x99\xf7\xeb\x1b\xd5\xe8\xea=[\x86\xaa\xeb\xe8\xcaG\x86{P\xfe"] = istrue(keep_filled);
  level.input_prompts.groups[group_name].prompts[prompt_ref] = spawnStruct();
  level.input_prompts.groups[group_name].prompts[prompt_ref].success_callback = success_callback;
  hud_management::function_f5104e32d4bc69f2(group_name, prompt_ref, fields);
}

function function_5025f31db5233d4b(group_name, prompt_ref, text, hold_time, clientside_input, consume_input, keep_filled) {
  if(isDefined(text)) {
    set_text(group_name, prompt_ref, text);
  }

  if(isDefined(hold_time)) {
    function_a967e31452103e76(group_name, prompt_ref, hold_time);
  }

  if(isDefined(clientside_input)) {
    function_63ce5439c4944e06(group_name, prompt_ref, clientside_input);
  }

  if(isDefined(consume_input)) {
    function_6cab05f02a3c793c(group_name, prompt_ref, consume_input);
  }

  if(isDefined(keep_filled)) {
    function_5393f141cfa80070(group_name, prompt_ref, keep_filled);
  }
}

function set_text(group_name, prompt_ref, text) {
  hud_management::function_bad8975c9b6b18b7(group_name, prompt_ref, "\xe2\xa7.m\xa5\xf2\x18\x84\f\xc45~x\x9f:", function_30e4f86dded0873(text));
}

function function_a967e31452103e76(group_name, prompt_ref, hold_time) {
  hud_management::function_bad8975c9b6b18b7(group_name, prompt_ref, "\x92\xd3\x9f\xbb", hold_time);
  hud_management::function_41477c414b969e8d(group_name, prompt_ref, gettime());
}

function function_63ce5439c4944e06(group_name, prompt_ref, clientside_input) {
  hud_management::function_bad8975c9b6b18b7(group_name, prompt_ref, "\xee\x18A\xce\xda\xe8\xe7p#WM\x0e\xd8\x8e\xb8N", clientside_input);
}

function function_6cab05f02a3c793c(group_name, prompt_ref, consume_input) {
  hud_management::function_bad8975c9b6b18b7(group_name, prompt_ref, "\xcaY\x15\x15\xe6)q\x1f\v\xb6w\x94\x8d", consume_input);
}

function function_5393f141cfa80070(group_name, prompt_ref, keep_filled) {
  hud_management::function_bad8975c9b6b18b7(group_name, prompt_ref, "\x80z\x99\xf7\xeb\x1b\xd5\xe8\xea=[\x86\xaa\xeb\xe8\xcaG\x86{P\xfe", keep_filled);
}

function function_a81ae46b4c59cbf5(group_name, prompt_ref, param_ref) {
  hud_management::function_eeded2ac210fa100(group_name, prompt_ref, param_ref);
}

function function_69d9d9bf6d1cc779(group_name, prompt_ref, state_ref) {
  hud_management::function_54a35c35697bfbc4(group_name, prompt_ref, state_ref);
}

function function_b9239e3615fcb225(group_name, prompt_ref) {
  hud_management::function_41477c414b969e8d(group_name, prompt_ref, gettime());
}

function function_8b6d36feadeac3d3(group_name, prompt_ref, var_6d30d0a16596818 = 1) {
  group_name = tolower(group_name);
  prompt_ref = tolower(prompt_ref);
  assert(isDefined(level.input_prompts) && isDefined(level.input_prompts.groups[group_name]), "<dev string:xc1>" + group_name + "<dev string:x86>");
  item_index = hud_management::function_79735b461f0a5aeb(group_name, prompt_ref);

  if(isDefined(item_index)) {
    level.input_prompts.lookups[item_index] = undefined;
    level.input_prompts.groups[group_name].prompts[prompt_ref] = undefined;
    hud_management::function_699c996caa7bb53e(group_name, prompt_ref, 1);

    if(var_6d30d0a16596818) {
      if(level.input_prompts.groups[group_name].prompts.size == 0) {
        hud_management::function_995d1afc30296a16(group_name);
      }
    }
  }
}

function clear_group(group_name) {
  group_name = tolower(group_name);

  if(hud_management::function_48c98ea9a4f0da89(group_name)) {
    foreach(prompt in level.input_prompts.groups[group_name].prompts) {
      function_8b6d36feadeac3d3(group_name, prompt_ref, 0);
    }
  }
}

function close_group(group_name) {
  group_name = tolower(group_name);

  if(hud_management::function_48c98ea9a4f0da89(group_name)) {
    indices = [];

    foreach(index, data in level.input_prompts.lookups) {
      if(data.group == group_name) {
        indices[indices.size] = index;
      }
    }

    foreach(index in indices) {
      level.input_prompts.lookups[index] = undefined;
    }

    level.input_prompts.groups[group_name].prompts = [];
    hud_management::function_995d1afc30296a16(group_name);
  }
}

function function_b9f10eee2e26e566(group_name, prompt_ref) {
  return isDefined(hud_management::function_79735b461f0a5aeb(group_name, prompt_ref));
}

function private success(var_421c773344a80ae7) {
  var_c752b1ba4163d648 = level.input_prompts.lookups[var_421c773344a80ae7];
  assert(isDefined(var_421c773344a80ae7));
  success_callback = level.input_prompts.groups[var_c752b1ba4163d648.group].prompts[var_c752b1ba4163d648.prompt].success_callback;

  if(isDefined(success_callback)) {
    self[[success_callback]](var_c752b1ba4163d648.group, var_c752b1ba4163d648.prompt);
  }
}