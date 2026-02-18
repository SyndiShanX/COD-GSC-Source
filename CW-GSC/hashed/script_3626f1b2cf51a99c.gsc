/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3626f1b2cf51a99c.gsc
***********************************************/

#using script_52da18c20f45c56a;
#using scripts\core_common\animation_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\ui\prompts;
#using scripts\weapons\weapon_utils;
#namespace actions;

function private autoexec __init__system__() {
  system::register(#"actions", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  function_5ac4dc99("<dev string:x38>", 0);

  level.player_actions = spawnStruct();
  level.player_actions.actions = [];
  animation::add_global_notetrack_handler("release", &function_303a7a74, 0);
  animation::add_global_notetrack_handler("chain", &function_3af7d065, 0);
  animation::add_global_notetrack_handler("event", &function_ebc59735, 0);
  animation::add_global_notetrack_handler("become_corpse", &action_utility::become_corpse, 0);
  action_register("root");
  callback::on_spawned(&on_player_spawned);
}

function on_player_spawned() {
  self.player_actions = spawnStruct();
  self.player_actions.enabled = [];
  self.player_actions.var_13a66c62 = [];

  foreach(action_name, action in level.player_actions.actions) {
    self function_b0868791(action_name, 1);
  }
}

function action_register(action_name, var_7eba8145, parent_name, var_9386e7ce, anim_name) {
  if(!isDefined(parent_name) && action_name != "root") {
    parent_name = "root";
  }

  if(!isDefined(var_9386e7ce)) {
    var_9386e7ce = "a";
  }

  if(!isDefined(anim_name)) {
    anim_name = action_name;
  }

  if(isDefined(level.player_actions.actions[action_name]) && level.player_actions.actions[action_name].var_7eba8145 != var_7eba8145) {
    assertmsg("<dev string:x49>");
    return;
  }

  action = spawnStruct();
  action.name = tolower(action_name);
  action.var_9386e7ce = tolower(var_9386e7ce);
  action.anim_name = tolower(anim_name);
  action.ender = "action_end_" + action.name;
  action.children = [];
  action.var_7eba8145 = var_7eba8145;
  level.player_actions.actions[action_name] = action;

  if(isDefined(parent_name)) {
    if(!isarray(parent_name)) {
      parent_name = [parent_name];
    }

    foreach(parent in parent_name) {
      thread function_ff81e3cc(parent, action_name);
    }
  }

  level notify(#"action_register", {
    #action: action_name
  });

  foreach(player in getplayers()) {
    player function_b0868791(action_name, 1);
  }
}

function function_1028d928(action_name, var_9386e7ce) {
  if(!isDefined(level.player_actions.actions[action_name])) {
    return false;
  }

  var_9386e7ce = tolower(var_9386e7ce);

  foreach(child in level.player_actions.actions[action_name].children) {
    if(child.var_9386e7ce == var_9386e7ce) {
      return true;
    }
  }

  return false;
}

function function_2ecf3fa7(var_5103505d, anim_name, scene_root, phase) {
  if(!isarray(var_5103505d)) {
    var_5103505d = [var_5103505d];
  }

  foreach(action_name in var_5103505d) {
    key = function_4e61a046(action_name, phase);

    if(isDefined(anim_name)) {
      self.var_9d46265b[key] = [anim_name, scene_root];
      continue;
    }

    self.var_9d46265b[key] = undefined;
  }
}

function function_bf28d531() {
  self.var_9d46265b = undefined;
}

function function_b1543a9d(anim_name, animset) {
  var_4f3681cc = getscriptbundle(animset);

  if(!isDefined(var_4f3681cc)) {
    assertmsg("<dev string:x9d>" + animset + "<dev string:xab>");
    return;
  }

  assert(var_4f3681cc.type == "<dev string:xbc>");
  assert(isDefined(level.player_actions));

  foreach(group in var_4f3681cc.animset) {
    foreach(index, animentry in group.anims) {
      entryname = anim_name + "_" + group.name;

      if(group.anims.size > 1) {
        entryname = entryname + "_" + index + 1;
      }

      level.player_actions.anims[group.animname][entryname] = animentry.xanim;

      if(group.blend !== 0.2) {
        level.player_actions.blend[group.animname][entryname] = isDefined(group.blend) ? group.blend : 0;
      }

      if(group.animname == "generic" && !isDefined(level.player_actions.anims[# "player"][entryname])) {
        level.player_actions.anims[# "player"][entryname] = animentry.xanim;
        level.player_actions.blend[# "player"][entryname] = group.blend;
      }
    }
  }
}

function function_df6077(action_name, enabled) {
  assert(isactor(self));

  if(enabled && !is_true(self.player_actions.enabled[action_name])) {
    self.player_actions.enabled[action_name] = undefined;
    return;
  }

  if(!enabled) {
    if(!isDefined(self.player_actions)) {
      self.player_actions = {};
    }

    self.player_actions.enabled[action_name] = 0;
  }
}

function function_b0868791(action_name, enabled) {
  assert(isPlayer(self));

  if(enabled && !is_true(self.player_actions.enabled[action_name])) {
    self.player_actions.enabled[action_name] = 1;
  } else if(!enabled && is_true(self.player_actions.enabled[action_name])) {
    self notify(level.player_actions.actions[action_name].ender);
    self.player_actions.enabled[action_name] = undefined;
  }

  self function_3af7d065(1);
  self function_3af7d065(1, level.player_actions.actions[action_name].var_9386e7ce);
  self thread function_942d9213();
}

function function_202ab848(enabled) {
  assert(isPlayer(self));
  self.player_actions.disabled = enabled ? undefined : 1;
  self thread function_942d9213();
}

function function_6c59e78f(enabled) {
  assert(isPlayer(self));
  self.player_actions.var_36a4a92c = enabled ? undefined : 1;
}

function function_8488e359(var_ecfa567f, var_c7a00bcb) {
  self.player_actions.var_c4e66a91 = undefined;

  if(isDefined(var_ecfa567f)) {
    self.player_actions.var_c4e66a91[var_ecfa567f] = 1;
    self notify("_plr_cmd_clk_" + var_ecfa567f);
  }

  if(isDefined(var_c7a00bcb)) {
    self.player_actions.var_c4e66a91[var_c7a00bcb] = 1;
    self notify("_plr_cmd_clk_" + var_c7a00bcb);
  }
}

function function_1c027741(action_name) {
  assert(isPlayer(self));
  self thread function_e3401e0e(action_name);
}

function function_d0cba98(action_name, override) {
  if(!isDefined(self.player_actions.overrides)) {
    self.player_actions.overrides = [];
  }

  self.player_actions.overrides[action_name] = override;
}

function function_abaa32c(action_name) {
  if(!isDefined(self.player_actions.overrides)) {
    self.player_actions.overrides = [];
  }

  return self.player_actions.overrides[action_name];
}

function function_3af7d065(enabled, var_9386e7ce) {
  assert(isPlayer(self));

  if(!isalive(self)) {
    return;
  }

  flagname = function_f3f7e971(var_9386e7ce);
  self flag::set_val(flagname, enabled);
}

function function_c004e236(prompt, var_9386e7ce) {
  self endon(#"death", #"disconnect");
  assert(isPlayer(self));

  if(!isalive(self)) {
    return;
  }

  flagname = function_f3f7e971(var_9386e7ce);
  self flag::wait_till(flagname);
  self flag::wait_till_clear(flagname);
}

function function_83bde308(action, var_d61bdbea, var_1ad5f3d8) {
  self endon(#"death", #"disconnect");
  assert(isPlayer(self));
  assert(isstruct(action));

  if(!isalive(self)) {
    return false;
  }

  if(isDefined(var_d61bdbea)) {
    self thread function_fb6a1439(action, var_d61bdbea, var_1ad5f3d8);
  }

  self flag::wait_till(function_f3f7e971(action));

  if(isDefined(var_d61bdbea)) {
    self flag::wait_till(function_3e2aeb63(var_d61bdbea));
  }

  return true;
}

function function_1927d2a8(immediate) {
  assert(isPlayer(self));

  if(isDefined(self.var_2cb06cc6) && self.var_2cb06cc6 !== "root") {
    self.var_2cb06cc6.var_43769020 = immediate;
    self notify(self.var_2cb06cc6.ender);
    waitframe(1);
  }
}

function function_942d9213() {
  self thread function_676e0128();
}

function function_c11b51e1() {
  return !isDefined(self.var_2cb06cc6.name) || self.var_2cb06cc6.name === "root";
}

function function_ff81e3cc(parent_name, action_name) {
  if(!isDefined(parent_name) || !isDefined(action_name)) {
    assertmsg("<dev string:xc7>");
    return;
  }

  if(tolower(parent_name) == tolower(action_name)) {
    assertmsg("<dev string:x104>" + action_name + "<dev string:x138>");
    return;
  }

  if(!isDefined(level.player_actions.actions[action_name])) {
    assertmsg("<dev string:x13f>" + action_name + "<dev string:x138>");
    return;
  }

  if(!isDefined(level.player_actions.actions[parent_name])) {
    level waittillmatch({
      #action: parent_name
    }, #"action_register");

    if(!isDefined(level.player_actions.actions[parent_name])) {
      assertmsg("<dev string:x171>" + action_name + "<dev string:x19b>" + parent_name + "<dev string:x138>");
      return;
    }
  }

  parent = level.player_actions.actions[parent_name];
  parent.children[action_name] = level.player_actions.actions[action_name];
}

function function_ebc59735(event_name, radius = 800) {
  ai = function_e45cbe76(self.origin, radius, self.team);

  foreach(guy in ai) {
    if(guy == self) {
      continue;
    }

    guy function_a3fcf9e0(event_name, getplayers()[0], self.origin);
  }
}

function function_f3f7e971(var_a50a7fa0) {
  if(isstruct(var_a50a7fa0)) {
    action = var_a50a7fa0;
    return ("action_chain_enabled_" + action.var_9386e7ce);
  }

  if(isDefined(var_a50a7fa0)) {
    var_9386e7ce = var_a50a7fa0;
    return ("action_chain_enabled_" + tolower(var_9386e7ce));
  }

  return "action_chain_enabled_" + "a";
}

function private function_303a7a74() {
  player = getplayers()[0];
  player thread action_utility::function_76e2ec80();
  player action_utility::function_2795d678(0);
  player action_utility::allow_weapon(1, 1);
  player enableweapons();
  player val::reset_all(#"action");
  var_13a66c62 = player.player_actions.var_13a66c62[player.var_2cb06cc6.name];

  if(isDefined(var_13a66c62)) {
    player[[var_13a66c62]](player.var_2cb06cc6);
  }
}

function function_fc288808(quick) {
  if(isPlayer(self)) {
    self action_utility::allow_weapon(1, 1);
  }
}

function function_e972f9a5(quick) {
  if(isPlayer(self)) {
    self action_utility::allow_weapon(0, 1);
  }
}

function function_4e61a046(action_name, phase) {
  if(isDefined(action_name) && isDefined(phase)) {
    action_name = action_name + ":" + phase;
  }

  return action_name;
}

function function_3e2aeb63(var_d61bdbea) {
  return "action_command_" + var_d61bdbea;
}

function function_fb6a1439(action, var_d61bdbea, var_1ad5f3d8) {
  self endon(action.ender);
  self endon(#"death", #"disconnect");
  flag = function_3e2aeb63(var_d61bdbea);
  self flag::clear(flag);
  var_414729dc = strtok(var_d61bdbea, "_");
  self function_2f22cd0b(action, var_414729dc[0], var_414729dc[1], flag);

  if(isDefined(var_1ad5f3d8)) {}
}

function function_2f22cd0b(action, command, type = "click", flag) {
  if(type == "hold") {
    while(function_ae44e21b(action, command)) {
      self flag::set(flag);
      waitframe(1);
    }

    self flag::clear(flag);
    return;
  }

  self function_9cb5ca63(action, command);
  self flag::set(flag);
}

function function_ae44e21b(action, command) {
  if(isDefined(self.player_actions.var_c4e66a91)) {
    return isDefined(self.player_actions.var_c4e66a91[command]);
  }

  switch (command) {
    case # "melee":
      return self meleeButtonPressed();
    case # "ads":
      return self adsButtonPressed();
    case # "use":
      return self useButtonPressed();
    case # "frag":
      return self fragButtonPressed();
    case # "smoke":
      return self secondaryoffhandbuttonPressed();
    case # "stance":
      return (self stancebuttonPressed() || self buttonbitstate("BUTTON_BIT_ANY_DOWN"));
  }

  return 0;
}

function function_9cb5ca63(action, command) {
  self endon(action.ender);
  self endon(#"death", #"disconnect");
  triggername = "_plr_cmd_clk_" + command;

  if(isDefined(self.player_actions.var_c4e66a91)) {
    waitframe(1);

    if(isDefined(self.player_actions.var_c4e66a91[command])) {
      return true;
    }

    self waittill(#"never");
  }

  switch (command) {
    case # "melee":
      self notifyonplayercommand(triggername, "+melee");
      self notifyonplayercommand(triggername, "+melee_breath");
      self notifyonplayercommand(triggername, "+melee_zoom");
      self thread function_7ca47b7c(action, triggername);
      break;
    case # "ads":
      self notifyonplayercommand(triggername, "+ads_akimbo_accessible");
      break;
    case # "use":
      self notifyonplayercommand(triggername, "+usereload");
      break;
    case # "frag":
      self notifyonplayercommand(triggername, "+frag");
      self notifyonplayercommand(triggername, "+equip_toggle_throw");
      break;
    case # "smoke":
      self notifyonplayercommand(triggername, "+smoke");
      self notifyonplayercommand(triggername, "+equip_toggle_throw");
      break;
    case # "stance":
      self notifyonplayercommand(triggername, "+stance");
      self notifyonplayercommand(triggername, "+movedown");
      self notifyonplayercommand(triggername, "+lowerstance");
      self notifyonplayercommand(triggername, "+prone");
      break;
    default:
      return false;
  }

  self waittill(triggername);
  return true;
}

function function_7ca47b7c(action, event) {
  self endon(action.ender);
  self endon(#"death", #"disconnect");
  self notifyonplayercommand("player_cmd_melee_atk", "+attack");
  self notifyonplayercommand("player_cmd_melee_atk", "+attack_akimbo_accessible");

  while(true) {
    self waittill(#"player_cmd_melee_atk");
    weapon = self getcurrentweapon();

    if(weapons::isknife(weapon)) {
      self notify(event);
    }
  }
}

function function_676e0128() {
  assert(isPlayer(self));
  self notify(#"hash_177677e1af36d866");
  self endon(#"death", #"disconnect", #"hash_177677e1af36d866");
  waitframe(1);
  self prompts::remove_group(#"actions");
  self prompts::function_d675f5a4();

  if(isDefined(self.var_6639d45b)) {}

  function_42a5d542(self.var_2cb06cc6);
  self action_utility::function_3fbe0931();

  if(self.player_actions.enabled.size > 0) {
    self util::delay(0.01, undefined, &function_1c027741, "root");
  }
}

function function_42a5d542(action, var_994af9bf) {
  if(isDefined(action) && action.name != "root") {
    if(isDefined(action.var_1eb98b2a)) {
      foreach(child in action.var_1eb98b2a) {
        if(!isDefined(var_994af9bf) || child != var_994af9bf) {
          self notify(child.ender);
        }
      }
    }
  }
}

function function_e3401e0e(name) {
  assert(isPlayer(self));

  if(!isalive(self)) {
    return;
  }

  self notify(#"hash_2f508e0571f37e47");
  self endon(#"death", #"disconnect", #"hash_2f508e0571f37e47");
  action = level.player_actions.actions[name];
  self thread function_1927d2a8();
  self.var_2cb06cc6 = action;
  self.var_2cb06cc6.var_43769020 = undefined;

  foreach(child in action.children) {
    self childthread function_2fc00159(name, child);
  }

  action.var_1eb98b2a = arraycopy(action.children);

  if(!isDefined(action.var_1eb98b2a)) {
    action.var_1eb98b2a = [];
  } else if(!isarray(action.var_1eb98b2a)) {
    action.var_1eb98b2a = array(action.var_1eb98b2a);
  }

  while(action.var_1eb98b2a.size > 0) {
    var_9c42c399 = self function_abc34a6c();

    foreach(result in var_9c42c399) {
      var_2b8c0efb = result[0];
      var_994b10ae = result[1];
      assert(isDefined(var_2b8c0efb), "<dev string:x1b5>");

      if(is_true(var_994b10ae)) {
        function_42a5d542(action, var_2b8c0efb);
        self thread function_e3401e0e(var_2b8c0efb.name);
        return;
      }

      if(var_2b8c0efb.ender != action.ender) {
        self notify(var_2b8c0efb.ender);
      }

      if(action.name == "root") {
        self childthread function_2fc00159(name, var_2b8c0efb);
        continue;
      }

      arrayremovevalue(action.var_1eb98b2a, var_2b8c0efb);
    }
  }
}

function function_2fc00159(var_498c5966, action) {
  self endon(#"hash_670dd8182b8b941");

  if(var_498c5966 == "root") {
    self flag::set(function_f3f7e971(action));
  } else {
    self flag::clear(function_f3f7e971(action));
  }

  waittillframeend();

  if(action.name != "root" && is_true(self.player_actions.disabled)) {
    return;
  }

  if(!is_true(self.player_actions.enabled[action.name])) {
    self function_43ad32c1(action);
    return;
  }

  if(isDefined(action.var_7eba8145)) {
    result = [[action.var_7eba8145]](action);
    self function_43ad32c1(action, result);
  }
}

function private function_abc34a6c() {
  self notify("37f9bd8032719bae");
  self endon("37f9bd8032719bae");
  self.var_a7c7b958 = [];
  self waittill(#"hash_41a2ad64c03a0ec3");
  return self.var_a7c7b958;
}

function private function_43ad32c1(action, result) {
  if(isDefined(self) && !function_3132f113(self)) {
    self.var_a7c7b958[self.var_a7c7b958.size] = [action, result];
    self notify(#"hash_41a2ad64c03a0ec3");
  }
}

function function_d661f822() {
  self notify(#"hash_2eaf8be0116c39a9");
  self endoncallback(&function_67860a50, #"hash_2eaf8be0116c39a9");
  var_5283788 = 8;
  self.var_56116d92 = [];

  for(i = 0; i < var_5283788; i++) {
    self.var_56116d92[i] = newdebughudelem();
    self.var_56116d92[i].x = 50;
    self.var_56116d92[i].y = 100 + i * 13;
    self.var_56116d92[i].alignx = "<dev string:x1f7>";
    self.var_56116d92[i].aligny = "<dev string:x1ff>";
    self.var_56116d92[i].horzalign = "<dev string:x206>";
    self.var_56116d92[i].vertalign = "<dev string:x206>";
    self.var_56116d92[i].fontscale = 1;
  }

  while(true) {
    waitframe(1);

    for(i = 0; i < var_5283788; i++) {
      text = "<dev string:x214>";

      switch (i) {
        case 0:
          if(isDefined(self.var_2cb06cc6)) {
            text += self.var_2cb06cc6.name + "<dev string:x218>";

            foreach(child in self.var_2cb06cc6.var_1eb98b2a) {
              text += child.name + "<dev string:x221>";
            }

            text += "<dev string:x228>";
          }

          break;
        case 1:
          text = "<dev string:x22d>";

          if(isDefined(self.takedown.body)) {
            text = "<dev string:x238>" + self.takedown.body getentitynumber();
          }

          break;
        case 2:
          text = "<dev string:x244>";

          if(isDefined(self.var_6639d45b)) {
            text = "<dev string:x24f>" + self.var_6639d45b getentitynumber();
          }

          break;
        case 3:
          var_e817484d = isDefined(self.takedown.var_70354814) ? self.takedown.var_70354814 : "<dev string:x214>";

          if(var_e817484d != "<dev string:x214>") {
            if(isDefined(getscriptbundle(var_e817484d))) {
              text = "<dev string:x25b>" + var_e817484d;
            } else {
              text = "<dev string:x25b>" + var_e817484d + "<dev string:x26f>";
            }
          }

          break;
      }

      self.var_56116d92[i] settext(text);
    }
  }
}

function private function_67860a50(params) {
  if(isDefined(self.var_56116d92)) {
    foreach(elem in self.var_56116d92) {
      elem destroy();
    }
  }

  self.var_56116d92 = undefined;
}