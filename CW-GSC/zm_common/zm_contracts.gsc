/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_contracts.gsc
***********************************************/

#using script_437ce686d29bb81b;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;
#namespace contracts;

function private autoexec __init__system__() {
  system::register(#"contracts", &preinit, undefined, &finalize_init, undefined);
}

function private preinit() {
  if(!isDefined(level.challengescallbacks)) {
    level.challengescallbacks = [];
  }

  init_player_contract_events();
  level callback::add_callback(#"hash_540f54ade63017ea", &function_feafa020);
}

function private finalize_init() {
  if(can_process_contracts()) {
    callback::on_connect(&on_player_connect);
    callback::function_74872db6(&function_74872db6);
    callback::on_round_end(&on_round_end);
    zm_player::function_a827358a(&function_8968a076);
    level.var_79a93566 = &function_902ef0de;
    level.var_c3e2bb05 = 3;

    level thread devgui_setup();
    level.var_b4ef4d73 = 1;
  }
}

function on_player_connect() {
  self setup_player_contracts(3, &registerpower_grid_displaycontrolrobotmelee);
  self function_df42ef94();
  self.shlocalh = 0;
  self.var_45ce0c21 = 0;

  if(self is_contract_active(#"contract_zm_no_pap") || is_true(level.var_b4ef4d73)) {
    self thread function_677a89c8();
  }

  if(self is_contract_active(#"contract_zm_same_shield") || is_true(level.var_b4ef4d73)) {
    self thread function_9d5cd9ee();
  }

  if(self is_contract_active(#"contract_zm_same_location") || is_true(level.var_b4ef4d73)) {
    self thread function_51db541e();
  }
}

function function_8968a076(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
  if(psoffsettime > 0) {
    self.shlocalh = 0;
  }
}

function function_74872db6() {
  if(level.round_number == 20) {
    foreach(e_player in getplayers()) {
      if(!is_true(e_player.var_bd1368a8)) {
        e_player increment_zm_contract(#"contract_zm_no_pap", 1, #"zstandard");
      }
    }

    level notify(#"hash_786860db94bcc0f3");
  }

  if(level.round_number == 30) {
    foreach(e_player in getplayers()) {
      e_player increment_zm_contract(#"contract_zm_rounds", 1, #"zstandard");
    }

    callback::function_50fdac80(&function_74872db6);
  }
}

function on_round_end() {
  switch (level.script) {
    case # "zm_zodt8":
      var_c5440c34 = # "contract_zm_zodt8_rounds";
      break;
    case # "zm_towers":
      var_c5440c34 = # "contract_zm_towers_rounds";
      break;
    case # "zm_escape":
      var_c5440c34 = # "contract_zm_escape_rounds";
      break;
    case # "zm_office":
      var_c5440c34 = # "contract_zm_office_rounds";
      break;
    case # "zm_mansion":
      var_c5440c34 = # "contract_zm_mansion_rounds";
      break;
    case # "zm_red":
      var_c5440c34 = # "contract_zm_red_rounds";
      break;
  }

  switch (level.var_837aa533) {
    case # "zclassic":
      var_fc80b645 = # "contract_zm_classic_rounds";
      break;
    case # "ztrials":
      var_fc80b645 = # "contract_zm_gauntlet_rounds";
      break;
  }

  foreach(e_player in getplayers()) {
    if(isDefined(var_c5440c34)) {
      e_player increment_zm_contract(var_c5440c34, 1, #"zstandard");
    }

    if(isDefined(var_fc80b645)) {
      e_player increment_zm_contract(var_fc80b645, 1);
    }
  }
}

function can_process_contracts() {
  if(getdvarint(#"contracts_enabled", 0) == 0) {
    return false;
  }

  if(getdvarint(#"contracts_enabled_zm", 1) == 0) {
    return false;
  }

  if(getdvarint(#"debugchallenges", 0) > 0) {
    return true;
  }

  if(!level.onlinegame || is_true(level.var_aa2d5655)) {
    return false;
  }

  return true;
}

function increment_zm_contract(var_38280f2f, delta = 1, var_86024473) {
  if(!can_process_contracts() || !self is_contract_active(var_38280f2f)) {
    return;
  }

  if(isDefined(var_86024473)) {
    if(!isDefined(var_86024473)) {
      var_86024473 = [];
    } else if(!isarray(var_86024473)) {
      var_86024473 = array(var_86024473);
    }

    foreach(var_86603201 in var_86024473) {
      if(var_86603201 == util::get_game_type()) {
        return;
      }
    }
  }

  self function_902ef0de(var_38280f2f, delta);
}

function private function_902ef0de(var_38280f2f, delta) {
  if(getdvarint(#"scr_contract_debug_multiplier", 0) > 0) {
    delta *= getdvarint(#"scr_contract_debug_multiplier", 1);
  }

  if(delta <= 0) {
    return;
  }

  target_value = self.pers[# "contracts"][var_38280f2f].target_value;
  old_progress = isDefined(self.pers[# "contracts"][var_38280f2f].current_value) ? self.pers[# "contracts"][var_38280f2f].current_value : self.pers[# "contracts"][var_38280f2f].var_59cb904f;

  if(old_progress == target_value) {
    return;
  }

  new_progress = int(old_progress + delta);

  if(new_progress > target_value) {
    new_progress = target_value;
  }

  if(new_progress != old_progress) {
    self.pers[# "contracts"][var_38280f2f].current_value = new_progress;

    if(isDefined(level.contract_ids[var_38280f2f])) {
      self luinotifyevent(#"hash_4b04b1cb4b3498d0", 2, level.contract_ids[var_38280f2f], new_progress);
    }
  }

  if(old_progress < target_value && target_value <= new_progress) {
    self.pers[# "contracts"][var_38280f2f].var_be5bf249 = self.pers[# "time_played_total"];

    if(isDefined(level.contract_ids[var_38280f2f])) {
      self zm_stats::function_fbce465a(#"hash_777766b99c35007f");
      zm_stats::function_ea5b4947(0);
      self luinotifyevent(#"hash_1739c4bd5baf83bc", 1, level.contract_ids[var_38280f2f]);
    }
  }

  if(getdvarint(#"scr_contract_debug", 0) > 0) {
    iprintln(function_9e72a96(var_38280f2f) + "<dev string:x38>" + new_progress + "<dev string:x47>" + target_value);

    if(old_progress < target_value && target_value <= new_progress) {
      iprintln(function_9e72a96(var_38280f2f) + "<dev string:x4c>");
    }
  }

}

function registerpower_grid_displaycontrolrobotmelee(slot) {
  return function_d17bcd3c(slot);
}

function private function_df42ef94() {
  if(namespace_cf6efd05::function_85b812c9()) {
    for(slot = 0; slot < 3; slot++) {
      var_b973083d = self registerpower_grid_displaycontrolrobotmelee(slot);
      n_progress = namespace_cf6efd05::function_48b5c403(self, #"hash_47c5fe6b4bbd9f0f", slot);

      if(isDefined(n_progress) && n_progress > 0) {
        self.pers[# "contracts"][var_b973083d.var_38280f2f].var_59cb904f = n_progress;
        self.pers[# "contracts"][var_b973083d.var_38280f2f].current_value = n_progress;
      }
    }
  }
}

function private function_feafa020() {
  foreach(player in getplayers()) {
    for(slot = 0; slot < 3; slot++) {
      var_b973083d = player registerpower_grid_displaycontrolrobotmelee(slot);
      n_progress = isDefined(player.pers[# "contracts"][var_b973083d.var_38280f2f].current_value) ? player.pers[# "contracts"][var_b973083d.var_38280f2f].current_value : player.pers[# "contracts"][var_b973083d.var_38280f2f].var_59cb904f;
      namespace_cf6efd05::function_53721fc4(player, #"hash_47c5fe6b4bbd9f0f", slot, n_progress);
    }
  }
}

function function_4a56b14d() {
  if(!can_process_contracts()) {
    return;
  }

  function_d3fba20e();
}

function function_dff4c02f() {
  if(!can_process_contracts() || !self is_contract_active(#"hash_38b41a1f3105c462")) {
    return;
  }

  self.shlocalh++;

  if(self.shlocalh == 100) {
    self increment_zm_contract(#"hash_38b41a1f3105c462");
  }
}

function function_ac03f21e() {
  if(!can_process_contracts() || !self is_contract_active(#"contract_zm_single_special")) {
    return;
  }

  if(self.var_72d6f15d !== 2) {
    return;
  }

  self.var_45ce0c21++;

  if(self.var_45ce0c21 == 25) {
    self increment_zm_contract(#"contract_zm_single_special");
  }
}

function function_677a89c8() {
  level endon(#"hash_786860db94bcc0f3");
  self endon(#"disconnect");

  while(true) {
    s_notify = self waittill(#"weapon_change");
    w_current = s_notify.weapon;

    if(zm_weapons::is_weapon_upgraded(w_current)) {
      self.var_bd1368a8 = 1;
      return;
    }
  }
}

function function_9d5cd9ee() {
  self endoncallback(&function_1395d508, #"disconnect", #"destroy_riotshield");
  var_c16ab86f = 0;

  while(true) {
    level waittill(#"start_of_round");

    if(!is_true(self.hasriotshield)) {
      var_c16ab86f = 0;
      continue;
    }

    level waittill(#"end_of_round");

    if(is_true(self.hasriotshield)) {
      var_c16ab86f++;
    } else {
      var_c16ab86f = 0;
    }

    if(var_c16ab86f >= 10) {
      self increment_zm_contract(#"contract_zm_same_shield");
      return;
    }
  }
}

function function_1395d508(var_c34665fc) {
  self endon(#"disconnect");

  if(var_c34665fc == "destroy_riotshield") {
    waittillframeend();
    self thread function_9d5cd9ee();
  }
}

function function_51db541e() {
  self endon(#"disconnect");
  var_c16ab86f = 0;
  var_b90fea5 = 1;

  while(true) {
    level waittill(#"start_of_round");

    if(is_true(var_b90fea5)) {
      var_b90fea5 = 0;
      wait 5;
    }

    if(isDefined(level.var_27028b8e)) {
      var_a26574af = [[level.var_27028b8e]](self zm_zonemgr::get_player_zone());
    } else {
      var_a26574af = self zm_zonemgr::get_player_zone();
    }

    if(!isDefined(var_a26574af)) {
      continue;
    }

    if(!isDefined(self.var_42a6fc40)) {
      self.var_42a6fc40 = var_a26574af;
      var_c16ab86f = 0;
      self thread function_1d4fae71();
    } else {
      var_c16ab86f++;
    }

    if(var_c16ab86f >= 10) {
      self increment_zm_contract(#"contract_zm_same_location");
      self notify(#"hash_4bf9f2755fe74a0d");
      return;
    }
  }
}

function function_1d4fae71() {
  self endon(#"disconnect", #"hash_4bf9f2755fe74a0d");

  while(true) {
    zone_name = # "";

    if(isDefined(level.var_27028b8e)) {
      zone_name = [[level.var_27028b8e]](self zm_zonemgr::get_player_zone());
    }

    if(!isalive(self) || self.var_42a6fc40 !== zone_name) {
      self.var_42a6fc40 = undefined;
      return;
    }

    waitframe(1);
  }
}

function devgui_setup() {
  devgui_base = "<dev string:x6e>";
  wait 3;
  function_e07e542b(devgui_base, undefined);
  function_295a8005(devgui_base);
}

function function_295a8005(var_1d89ece6) {
  var_bbd68476 = var_1d89ece6 + "<dev string:x7f>";
  var_c8d599b5 = "<dev string:x88>";
  var_86418430 = var_bbd68476 + "<dev string:xc5>";
  util::function_3f749abc(var_86418430 + "<dev string:xcf>", var_c8d599b5 + "<dev string:xdf>");
  util::function_3f749abc(var_86418430 + "<dev string:xfb>", var_c8d599b5 + "<dev string:x10e>");
  util::function_3f749abc(var_86418430 + "<dev string:x129>", var_c8d599b5 + "<dev string:x13c>");
  util::function_3f749abc(var_86418430 + "<dev string:x15b>", var_c8d599b5 + "<dev string:x16d>");
  util::function_3f749abc(var_86418430 + "<dev string:x186>", var_c8d599b5 + "<dev string:x18f>");
  util::function_3f749abc(var_86418430 + "<dev string:x1a4>", var_c8d599b5 + "<dev string:x1b0>");
  util::function_3f749abc(var_86418430 + "<dev string:x1c8>", var_c8d599b5 + "<dev string:x1d5>");
  util::function_3f749abc(var_86418430 + "<dev string:x1ee>", var_c8d599b5 + "<dev string:x1fe>");
  util::function_3f749abc(var_86418430 + "<dev string:x21a>", var_c8d599b5 + "<dev string:x22b>");
  util::function_3f749abc(var_86418430 + "<dev string:x248>", var_c8d599b5 + "<dev string:x255>");
  util::function_3f749abc(var_86418430 + "<dev string:x26e>", var_c8d599b5 + "<dev string:x27e>");
  util::function_3f749abc(var_86418430 + "<dev string:x29a>", var_c8d599b5 + "<dev string:x2a6>");
  util::function_3f749abc(var_86418430 + "<dev string:x2be>", var_c8d599b5 + "<dev string:x2cd>");
  util::function_3f749abc(var_86418430 + "<dev string:x2e8>", var_c8d599b5 + "<dev string:x2fe>");
  util::function_3f749abc(var_86418430 + "<dev string:x31a>", var_c8d599b5 + "<dev string:x332>");
  util::function_3f749abc(var_86418430 + "<dev string:x356>", var_c8d599b5 + "<dev string:x367>");
  util::function_3f749abc(var_86418430 + "<dev string:x384>", var_c8d599b5 + "<dev string:x393>");
  util::function_3f749abc(var_86418430 + "<dev string:x3ae>", var_c8d599b5 + "<dev string:x3c5>");
  util::function_3f749abc(var_86418430 + "<dev string:x3e8>", var_c8d599b5 + "<dev string:x3f6>");
  util::function_3f749abc(var_86418430 + "<dev string:x410>", var_c8d599b5 + "<dev string:x422>");
  util::function_3f749abc(var_86418430 + "<dev string:x440>", var_c8d599b5 + "<dev string:x450>");
  util::function_3f749abc(var_86418430 + "<dev string:x46c>", var_c8d599b5 + "<dev string:x47e>");
  var_86418430 = var_bbd68476 + "<dev string:x49c>";
  util::function_3f749abc(var_86418430 + "<dev string:x4af>", var_c8d599b5 + "<dev string:x4ca>");
  util::function_3f749abc(var_86418430 + "<dev string:x4eb>", var_c8d599b5 + "<dev string:x518>");
  var_86418430 = var_bbd68476 + "<dev string:x536>";
  util::function_3f749abc(var_86418430 + "<dev string:x544>", var_c8d599b5 + "<dev string:x554>");
  util::function_3f749abc(var_86418430 + "<dev string:x569>", var_c8d599b5 + "<dev string:x57e>");
  util::function_3f749abc(var_86418430 + "<dev string:x59a>", var_c8d599b5 + "<dev string:x5ae>");
  util::function_3f749abc(var_86418430 + "<dev string:x5c6>", var_c8d599b5 + "<dev string:x5d9>");
  util::function_3f749abc(var_86418430 + "<dev string:x5f1>", var_c8d599b5 + "<dev string:x603>");
  util::function_3f749abc(var_86418430 + "<dev string:x621>", var_c8d599b5 + "<dev string:x640>");
  var_86418430 = var_bbd68476 + "<dev string:x655>";
  util::function_3f749abc(var_86418430 + "<dev string:x660>", var_c8d599b5 + "<dev string:x671>");
  util::function_3f749abc(var_86418430 + "<dev string:x687>", var_c8d599b5 + "<dev string:x69e>");
  util::function_3f749abc(var_86418430 + "<dev string:x6b4>", var_c8d599b5 + "<dev string:x6d9>");
  util::function_3f749abc(var_86418430 + "<dev string:x6f4>", var_c8d599b5 + "<dev string:x715>");
  util::function_3f749abc(var_86418430 + "<dev string:x732>", var_c8d599b5 + "<dev string:x744>");
  var_86418430 = var_bbd68476 + "<dev string:x762>";
  util::function_3f749abc(var_86418430 + "<dev string:x76d>", var_c8d599b5 + "<dev string:x77e>");
  util::function_3f749abc(var_86418430 + "<dev string:x79b>", var_c8d599b5 + "<dev string:x7ab>");
  var_86418430 = var_bbd68476 + "<dev string:x7c7>";
  util::function_3f749abc(var_86418430 + "<dev string:x7d4>", var_c8d599b5 + "<dev string:x7e4>");
  util::function_3f749abc(var_86418430 + "<dev string:x803>", var_c8d599b5 + "<dev string:x81e>");
  util::function_3f749abc(var_86418430 + "<dev string:x83d>", var_c8d599b5 + "<dev string:x850>");
  var_86418430 = var_bbd68476 + "<dev string:x86f>";
  util::function_3f749abc(var_86418430 + "<dev string:x878>", var_c8d599b5 + "<dev string:x891>");
  util::function_3f749abc(var_86418430 + "<dev string:x8ae>", var_c8d599b5 + "<dev string:x8b5>");
  util::function_3f749abc(var_86418430 + "<dev string:x8ae>", var_c8d599b5 + "<dev string:x8ce>");
  util::function_3f749abc(var_86418430 + "<dev string:x8e8>", var_c8d599b5 + "<dev string:x8fa>");
  var_86418430 = var_bbd68476 + "<dev string:x919>";
  util::function_3f749abc(var_86418430 + "<dev string:x922>", var_c8d599b5 + "<dev string:x932>");
  util::function_3f749abc(var_86418430 + "<dev string:x94e>", var_c8d599b5 + "<dev string:x95f>");
  util::function_3f749abc(var_86418430 + "<dev string:x97c>", var_c8d599b5 + "<dev string:x98d>");
  util::function_3f749abc(var_86418430 + "<dev string:x9aa>", var_c8d599b5 + "<dev string:x9bb>");
  util::function_3f749abc(var_86418430 + "<dev string:x9d8>", var_c8d599b5 + "<dev string:x9ea>");
  util::function_3f749abc(var_86418430 + "<dev string:xa08>", var_c8d599b5 + "<dev string:xa16>");
  var_86418430 = var_bbd68476 + "<dev string:xa30>";
  util::function_3f749abc(var_86418430 + "<dev string:xa39>", var_c8d599b5 + "<dev string:xa45>");
  util::function_3f749abc(var_86418430 + "<dev string:xa5d>", var_c8d599b5 + "<dev string:xa6f>");
  util::function_3f749abc(var_86418430 + "<dev string:xa87>", var_c8d599b5 + "<dev string:xa96>");
}