/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\pack_a_punch.gsc
***********************************************/

#using script_638d701d263ee1ed;
#using script_6bffae1b97f70547;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\content_manager;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\purchasemenu;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#using scripts\mp\utility\lui_game_event_aggregator;
#using scripts\mp\utility\perk;
#namespace pack_a_punch;

function init_pap(var_74cdac95bea43e20) {
  level thread function_3749f024c16fcc43();

  level.var_28967913115d1fa3 = [];
  level.var_74cdac95bea43e20 = [];
  scripts\cp_mp\content_manager::register_script("pack_a_punch", &function_b7481f7bce6ae192);
  level callback::add("player_connect", &function_4fea0f8d04cd5a9f);

  callback::add("<dev string:x1c>", &function_ac138c84c0432491);

  callback::add("player_weapon_change", &function_9978ad7acc70bbd0);
  level.var_999ad4260faef0e = ["", "_pack", "_pack", "_pack"];
  level.var_b4d422cd8fbde1ad = 1;

  if(!istrue(level.gamemodebundle.var_7746f48b0ed07126)) {
    level thread function_f2d3dc064699b591();
  } else {
    callback::add("ob_content_process_create_script", &function_f2d3dc064699b591);
  }

  level thread function_4aa535a603fcb16a(var_74cdac95bea43e20);
  registersharedfunc("zombie", "get_pap_level", &get_pap_level);
  level.var_41b1ceff53cc7e4d = throttle::throttle_initialize("pap_disable_camo");
  level callback::add("ob_content_process_create_script", &function_5b6d2196b317fd35);
}

function function_5b6d2196b317fd35(params) {
  if(isDefined(level.var_c383b967aa7e551b)) {
    var_81a0a69befe256bd = [];
    var_3c3122af5c02bd7 = getStructArray("content_struct", "variantname");

    foreach(struct in var_3c3122af5c02bd7) {
      if(isDefined(struct.content_key) && struct.content_key == "pap_spawn") {
        var_81a0a69befe256bd = array_add(var_81a0a69befe256bd, struct);
      }
    }

    var_647e08da9152309b = [];
    var_81a0a69befe256bd = array_randomize(var_81a0a69befe256bd);

    foreach(s_pap in var_81a0a69befe256bd) {
      region = namespace_f721fc7d0d2d0f47::get_region(s_pap.origin);

      if(!isDefined(region)) {
        continue;
      }

      regiondifficulty = namespace_f721fc7d0d2d0f47::function_cf8b9cfdad89cbec(region);

      if(regiondifficulty == "difficulty_hard" || regiondifficulty == "difficulty_darkaether") {
        function_d76a5a37bdc449e3(s_pap);
        var_647e08da9152309b[var_647e08da9152309b.size] = s_pap;
        break;
      }
    }

    var_81a0a69befe256bd = [[level.var_c383b967aa7e551b]]("pap", var_81a0a69befe256bd, &function_d76a5a37bdc449e3, var_647e08da9152309b);
    level.var_28967913115d1fa3 = array_combine_unique(level.var_28967913115d1fa3, var_81a0a69befe256bd);
  }
}

function private function_d76a5a37bdc449e3(var_cf7a501ac4f86500) {
  var_cf7a501ac4f86500 function_e9a23532607e421b();
}

function function_4fea0f8d04cd5a9f(params) {
  self.var_7a6ac8a30c8eef4c = [];
}

function function_ac138c84c0432491(params) {
  self endon("<dev string:x2e>");
  wait 3;

  if(level.var_b4d422cd8fbde1ad) {
    function_6e7290c8ee4f558b("<dev string:x3c>" + self.name + "<dev string:x63>");

    foreach(s_pap in level.var_28967913115d1fa3) {
      function_b23a59dfb4ca49a1(s_pap.name, "<dev string:x68>" + s_pap.name + "<dev string:x7c>" + self.name, &function_d1ffd6e50972869b);
    }

    function_fe953f000498048f();
    function_6e7290c8ee4f558b("<dev string:x81>" + self.name + "<dev string:x63>");

    foreach(s_pap in level.var_28967913115d1fa3) {
      function_b23a59dfb4ca49a1(s_pap.name, "<dev string:xad>" + s_pap.name + "<dev string:x7c>" + self.name, &function_5b1246d4c3b2bae8);
    }

    function_fe953f000498048f();
  }
}

function function_f46640f2061fa40e() {
  level.var_389f96815631487 = [];
  var_3bdc59ecfc03a38d = function_127acf3af63de42e();
  level.var_389f96815631487["hintstring_only"] = spawnStruct();
  level.var_389f96815631487["hintstring_only"].var_f3201c9531e84083 = var_3bdc59ecfc03a38d.var_b310d95a43d51411;
  level.var_389f96815631487["hintstring_only"].var_40c5fe63017a0028 = var_3bdc59ecfc03a38d.var_b174fd304230ba35;
  level.var_389f96815631487["hintstring_only"].var_f3201d9531e842b6 = var_3bdc59ecfc03a38d.var_b310d65a43d50d78;
  level.var_389f96815631487["hintstring_only"].var_d9a16a76860e6fb5 = var_3bdc59ecfc03a38d.var_3a327e1fbf019eb6;
  level.var_389f96815631487["hintstring_only"].var_f3201e9531e844e9 = var_3bdc59ecfc03a38d.var_b310d75a43d50fab;
  level.var_389f96815631487["hintstring_only"].var_7a6ad8de7cb26202 = var_3bdc59ecfc03a38d.var_1dac12541578526b;
  level.var_389f96815631487["hintstring_only"].var_546f21bbff45af2f = var_3bdc59ecfc03a38d.var_741fb5ba0af7dbec;
  level.var_389f96815631487["hintstring_only"].var_e532cc181ecbb197 = var_3bdc59ecfc03a38d.var_34a3243d4dbe42f2;
}

function function_8ffd6120b9e72251(v_pos) {
  if(isDefined(level.var_780248e36eabf6ef)) {
    var_2fcb35d230365682 = [[level.var_780248e36eabf6ef]](v_pos);
  } else {
    var_2fcb35d230365682 = purchasemenu::function_cfd0e1fb13d7e080(#"pap");
  }

  return var_2fcb35d230365682;
}

function function_3749f024c16fcc43() {
  function_6e7290c8ee4f558b("<dev string:xc6>");
  function_a9a864379a098ad6("<dev string:xdd>", "<dev string:xf0>", &function_48d69eea9b7ed244, 1);
  function_a9a864379a098ad6("<dev string:x103>", "<dev string:x11a>", &function_310eb57e9f489403);
  function_a9a864379a098ad6("<dev string:x131>", "<dev string:x147>", &function_6301b4b9186189ec);
  function_a9a864379a098ad6("<dev string:x15d>", "<dev string:x175>", &function_9b340159cdb06093);
  function_fe953f000498048f();
  function_6e7290c8ee4f558b("<dev string:x18d>");
  function_a9a864379a098ad6("<dev string:x131>", "<dev string:x147>", &function_6301b4b9186189ec);
  function_a9a864379a098ad6("<dev string:x15d>", "<dev string:x175>", &function_9b340159cdb06093);
  function_fe953f000498048f();
}

function private function_d1ffd6e50972869b(params) {
  s_pap = undefined;

  foreach(s_pap in level.var_28967913115d1fa3) {
    if(s_pap.name == params[0]) {
      foreach(player in level.players) {
        if(player.name == params[1]) {
          player.var_5070f05815274d88 = undefined;
          s_pap.mdl_pap.interact function_c1b2d811be564958(player);
          return;
        }
      }
    }
  }
}

function private function_5b1246d4c3b2bae8(params) {
  s_pap = undefined;

  foreach(s_pap in level.var_28967913115d1fa3) {
    if(s_pap.name == params[0]) {
      foreach(player in level.players) {
        if(player.name == params[1]) {
          if(isDefined(player.s_pap_machine)) {
            player.var_5070f05815274d88 = 1;
          }

          return;
        }
      }
    }
  }
}

function private function_6301b4b9186189ec() {
  foreach(player in level.players) {
    currentweapon = player getcurrentweapon();

    if(player can_pap(currentweapon)) {
      var_5476695cf42091ed = player get_pap_level(currentweapon);
      player pap_weapon(currentweapon, var_5476695cf42091ed);
    }
  }
}

function private function_9b340159cdb06093() {
  foreach(player in level.players) {
    player function_8a514af6a4020(player getcurrentweapon());
  }
}

function private function_310eb57e9f489403() {
  foreach(var_429a9d29cea7b27d in level.var_28967913115d1fa3) {
    var_429a9d29cea7b27d enable_pap();
  }
}

function function_f2d3dc064699b591(params) {
  level endon("game_ended");
  function_f46640f2061fa40e();
  function_4fc54a99a17b78cb();
  waittillframeend();
  a_destinations = getStructArray("content_destination", "variantname");

  foreach(destination in a_destinations) {
    level thread function_e89cb00407326ff5(destination);
  }

  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&function_7555b4c311cdf27c);
}

function function_e89cb00407326ff5(destination) {
  foreach(location in destination.locations) {
    pap_instance = location.instances["pack_a_punch"];

    if(isDefined(pap_instance)) {
      foreach(instance in pap_instance.versions) {
        scripts\cp_mp\content_manager::spawn_instance(instance);
      }
    }
  }
}

function private function_b7481f7bce6ae192(instance) {
  level.var_28967913115d1fa3 = array_combine_unique(level.var_28967913115d1fa3, instance.contentgroups["pap_spawn"]);

  foreach(var_429a9d29cea7b27d in level.var_28967913115d1fa3) {
    var_429a9d29cea7b27d.str_destination = instance.location.destination.targetname;
    var_429a9d29cea7b27d function_e9a23532607e421b(instance);
  }
}

function function_4aa535a603fcb16a(var_74cdac95bea43e20) {
  if(isDefined(level.weaponmetadata)) {
    var_74cdac95bea43e20 = [];

    foreach(str_weapon_name, s_weapon in level.weaponmetadata) {
      if(istrue(s_weapon.canpap)) {
        var_74cdac95bea43e20[str_weapon_name] = str_weapon_name;
      }
    }
  }

  if(!isDefined(var_74cdac95bea43e20)) {
    assertmsg("<dev string:x1ac>");
  }

  level.var_74cdac95bea43e20 = var_74cdac95bea43e20;
}

function function_127acf3af63de42e() {
  assertex(isDefined(level.gamemodebundle.packapunchbundle), "<dev string:x1d5>");
  str_bundle_name = default_to(level.var_ae30f5b886731a98, level.gamemodebundle.packapunchbundle);
  return getscriptbundle("packapunch:" + str_bundle_name);
}

function function_4fc54a99a17b78cb() {
  s_bundle = function_127acf3af63de42e();
  level.pap_camos = s_bundle.camolist;
}

function function_5e8f96f1bc95aacd() {
  s_bundle = function_127acf3af63de42e();

  if(isDefined(s_bundle.scriptable) && s_bundle.scriptable != "") {
    return true;
  }

  return false;
}

function function_e9a23532607e421b(instance) {
  if(isDefined(self.mdl_pap)) {
    return;
  }

  s_bundle = function_127acf3af63de42e();
  self.var_2217ae64fad1e = s_bundle.model;
  self.radius = default_to(self.radius, 64);
  level.var_47ea54565556fd68 = default_to(level.var_47ea54565556fd68, 0);
  self.name = default_to(self.targetname, "PAP_" + level.var_47ea54565556fd68);
  level.var_47ea54565556fd68++;

  if(function_5e8f96f1bc95aacd()) {
    var_e89a9a6a3475bd0a = function_127acf3af63de42e().scriptable;
    self.mdl_pap = spawnscriptable(var_e89a9a6a3475bd0a, self.origin, self.angles);
    self.mdl_pap.interact = scripts\cp_mp\interaction::function_32645103f7520635(self.mdl_pap, &function_c1b2d811be564958);
    self.mdl_pap.s_pap = self;
    self.mdl_pap.var_2fcb35d230365682 = function_8ffd6120b9e72251(self.mdl_pap.origin);
    thread function_89884a03ad5f622c();

    if(!istrue(s_bundle.var_69e6100b657f07a6)) {
      self.mdl_pap.interact scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_3b2684b76c1ab98e);
    }
  } else {
    self.mdl_pap = scripts\cp_mp\content_manager::spawn_script_model(self, self.var_2217ae64fad1e, 1, 1);
    assertex(self.mdl_pap isscriptable(), "<dev string:x22b>");
    self.mdl_pap.var_2fcb35d230365682 = function_8ffd6120b9e72251(self.mdl_pap.origin);
    self.mdl_pap.var_f18bb191dfec8db9 = createnavobstaclebyent(self.mdl_pap);
  }

  if(!function_5e8f96f1bc95aacd()) {
    if(istrue(s_bundle.var_69e6100b657f07a6)) {
      self.mdl_pap.interact = scripts\cp_mp\interaction::register_interact(self.mdl_pap, self.radius, &function_c1b2d811be564958);
      self.mdl_pap.interact scripts\cp_mp\interaction::function_9a0883b5a0999dac();
      self.mdl_pap.interact scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_4572d5e97616f34c);
    } else {
      self.mdl_pap.interact = scripts\cp_mp\interaction::register_interact(self.mdl_pap, self.radius, &function_c1b2d811be564958);
      self.mdl_pap.interact scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_3b2684b76c1ab98e);
    }

    if(self.mdl_pap.interact tagexists("tag_hint")) {
      self.mdl_pap.interact sethinttag("tag_hint");
    }

    self.mdl_pap.interact.s_pap = self;
  }

  if(istrue(self.script_start)) {
    enable_pap(1);
    return;
  }

  disable_pap(1);
  thread function_d0c65b564a1ac22();
}

function private function_89884a03ad5f622c() {
  if(isDefined(self.mdl_pap.var_2fcb35d230365682.var_6c3d26c5e933dcfd)) {
    b_success = self.mdl_pap utility::function_3677f2be30fdd581("region_color", "off");
    waitframe();
    b_success = self.mdl_pap utility::function_3677f2be30fdd581("region_color", self.mdl_pap.var_2fcb35d230365682.var_6c3d26c5e933dcfd);
  }
}

function private function_3b2684b76c1ab98e(usable, player) {
  if(isDefined(player) && istrue(player.interactions_disabled)) {
    return {
      #string: &"", #type: "HINT_NOICON"};
  }

  w_current = player getcurrentweapon();
  n_pap_level = player get_pap_level(w_current);

  if(!player can_pap(w_current)) {
    return {
      #string: level.var_389f96815631487["hintstring_only"].var_546f21bbff45af2f, #type: "HINT_NOBUTTON"};
  }

  str_weapon = w_current.displayname;
  var_2fcb35d230365682 = function_8ffd6120b9e72251(usable.origin);

  if(isDefined(var_2fcb35d230365682)) {
    item = purchasemenu::function_904f24ea774b8f6f(var_2fcb35d230365682.ref, n_pap_level);

    if(isDefined(item)) {
      cost = item.cost;
      currency = item.currency;

      if(player scripts\mp\utility\perk::_hasperk("specialty_exfil_pap_percent_reward")) {
        cost = int(item.cost * level.perkbundles["specialty_exfil_pap_percent_reward"].var_7091af12e157769c);
      }
    } else {
      return {
        #string: level.var_389f96815631487["hintstring_only"].var_e532cc181ecbb197, #type: "HINT_NOBUTTON"};
    }
  } else {
    return {
      #string: level.var_389f96815631487["hintstring_only"].var_e532cc181ecbb197, #type: "HINT_NOBUTTON"};
  }

  switch (n_pap_level) {
    case 0:
      if(player scripts\cp_mp\currency::can_afford(currency, cost)) {
        return {
          #params: [str_weapon, cost], #string: level.var_389f96815631487["hintstring_only"].var_f3201c9531e84083, #type: "HINT_BUTTON"};
      } else {
        return {
          #params: [str_weapon, cost], #string: level.var_389f96815631487["hintstring_only"].var_40c5fe63017a0028, #type: "HINT_BUTTON"};
      }
    case 1:
      if(player scripts\cp_mp\currency::can_afford(currency, cost)) {
        return {
          #params: [str_weapon, cost], #string: level.var_389f96815631487["hintstring_only"].var_f3201d9531e842b6, #type: "HINT_BUTTON"};
      } else {
        return {
          #params: [str_weapon, cost], #string: level.var_389f96815631487["hintstring_only"].var_d9a16a76860e6fb5, #type: "HINT_BUTTON"};
      }
    case 2:
      if(player scripts\cp_mp\currency::can_afford(currency, cost)) {
        return {
          #params: [str_weapon, cost], #string: level.var_389f96815631487["hintstring_only"].var_f3201e9531e844e9, #type: "HINT_BUTTON"};
      } else {
        return {
          #params: [str_weapon, cost], #string: level.var_389f96815631487["hintstring_only"].var_7a6ad8de7cb26202, #type: "HINT_BUTTON"};
      }

      break;
  }

  return {
    #string: level.var_389f96815631487["hintstring_only"].var_e532cc181ecbb197, #type: "HINT_NOBUTTON"};
}

function private function_4572d5e97616f34c(usable, player) {
  if(isDefined(player) && isDefined(usable)) {
    if(istrue(player.interactions_disabled)) {
      return {
        #string: &"", #type: "HINT_NOICON"};
    }

    return {
      #string: &"SHARED_HINTSTRINGS/PAP_USE", #type: "HINT_BUTTON"};
  }

  return {
    #string: &"", #type: "HINT_NOICON"};
}

function function_d0c65b564a1ac22() {
  if(isDefined(self.script_power)) {
    flag_wait(self.script_power);
  }

  thread enable_pap();
}

function disable_pap(b_immediate) {
  if(isDefined(self.mdl_pap)) {
    if(function_5e8f96f1bc95aacd()) {
      self.mdl_pap utility::function_3677f2be30fdd581("usable", "off");

      foreach(player in level.players) {
        self.mdl_pap disablescriptableplayeruse(player);
      }
    } else {
      self.mdl_pap.interact function_dfb78b3e724ad620(0);
    }

    self.var_cd756b37f6f0e181 = undefined;
    self notify("disable_pap");
  }
}

function enable_pap(b_immediate) {
  if(isDefined(self.mdl_pap)) {
    self.var_cd756b37f6f0e181 = 1;

    if(istrue(b_immediate)) {
      self.mdl_pap utility::function_3677f2be30fdd581("base", "pap_idle");
      enable_interact();
    } else {
      var_59e5f52828bb5ed = 4.1;
      self.mdl_pap utility::function_3677f2be30fdd581("base", "pap_activate");
      delaythread(var_59e5f52828bb5ed, &enable_interact);
    }

    thread function_5441576d06b2a361();
  }
}

function function_666c0ed7301de9f3(e_linkto, str_tag, v_origin_offset, v_angles_offset) {
  if(!isDefined(v_origin_offset)) {
    v_origin_offset = (0, 0, 0);
  }

  if(!isDefined(v_angles_offset)) {
    v_angles_offset = (0, 0, 0);
  }

  if(isent(self)) {
    if(isDefined(str_tag)) {
      self linkTo(e_linkto, str_tag, v_origin_offset, v_angles_offset);
    } else {
      self linkTo(e_linkto);
    }

    return;
  }

  self scriptablesetparententity(e_linkto, v_origin_offset, v_angles_offset);
}

function function_a90b4bc92d126cd1(player) {
  if(!isPlayer(player)) {
    return false;
  }

  weapon = player getcurrentweapon();

  if(!isDefined(level.var_74cdac95bea43e20[weapon.var_9d7facbe889e667c]) && !namespace_dc2e59577d3a271f::function_6a22621172a35366(weapon)) {
    return false;
  }

  return true;
}

function function_c1b2d811be564958(player) {
  if(!function_a90b4bc92d126cd1(player)) {
    player playsoundtoplayer("ui_zm_core_purchase_deny", player);
    return;
  }

  if(istrue(player.interactions_disabled)) {
    return;
  }

  self.s_pap.var_c80acd5b1945a70f = player;
  player.s_pap_machine = self.s_pap;
  player thread open_pap_menu(self.s_pap);
}

function enable_interact() {
  if(function_5e8f96f1bc95aacd()) {
    self.mdl_pap utility::function_3677f2be30fdd581("usable", "on");

    foreach(player in level.players) {
      self.mdl_pap enablescriptableplayeruse(player);
    }

    return;
  }

  self.mdl_pap.interact function_dfb78b3e724ad620(1);
}

function function_7555b4c311cdf27c(channel, menuitemindex) {
  if(isDefined(menuitemindex)) {
    menuitemindex -= 1;

    if(channel == "pap_weaponupgrade_purchase") {
      var_2fcb35d230365682 = function_8ffd6120b9e72251(self.origin);

      if(!isDefined(var_2fcb35d230365682)) {
        return;
      }

      currentweapon = self getcurrentweapon();
      var_3cf65499b595d11b = get_pap_level(currentweapon);
      item = purchasemenu::function_904f24ea774b8f6f(var_2fcb35d230365682.ref, menuitemindex);

      if(!isDefined(item) || var_3cf65499b595d11b != item.tier) {
        self setclientomnvar(var_2fcb35d230365682.var_8b8931f97eef184, 4);
        self setclientomnvar(var_2fcb35d230365682.var_fd0ea8a834fa0398, gettime());
        return;
      }

      if(!istrue(function_6cea50c31fdfd0b9(menuitemindex))) {
        self setclientomnvar(var_2fcb35d230365682.var_8b8931f97eef184, 3);
        self setclientomnvar(var_2fcb35d230365682.var_fd0ea8a834fa0398, gettime());
        return;
      }

      if(can_pap(currentweapon)) {
        function_ac4575f20a9ea183(self.s_pap_machine, var_3cf65499b595d11b, currentweapon, item);
      }

      return;
    }

    if(channel == "pap_ammomod_purchase") {
      var_2fcb35d230365682 = function_8ffd6120b9e72251(self.origin);

      if(!isDefined(var_2fcb35d230365682)) {
        return;
      }

      currentweapon = self getcurrentweapon();
      var_c8f3faec06777d2c = function_d4897d4fc2a76e56(currentweapon);
      item = purchasemenu::function_904f24ea774b8f6f(var_2fcb35d230365682.ref, menuitemindex);

      if(!isDefined(item) || var_c8f3faec06777d2c == item.itemref) {
        self setclientomnvar(var_2fcb35d230365682.var_8b8931f97eef184, 4);
        self setclientomnvar(var_2fcb35d230365682.var_fd0ea8a834fa0398, gettime());
        return;
      }

      if(!istrue(function_6cea50c31fdfd0b9(menuitemindex))) {
        self setclientomnvar(var_2fcb35d230365682.var_8b8931f97eef184, 3);
        self setclientomnvar(var_2fcb35d230365682.var_fd0ea8a834fa0398, gettime());
        return;
      }

      if(namespace_dc2e59577d3a271f::function_6a22621172a35366(currentweapon)) {
        function_29fecb7dd1dd0df2(self.s_pap_machine, currentweapon, item);
      }

      return;
    }

    if(purchasemenu::function_5c9b6f1c3c67dd97(#"pap", channel)) {
      self.var_5070f05815274d88 = 1;
    }
  }
}

function function_54241c8e78e3cd50(weapon) {
  if(!isPlayer(self)) {
    return int(0);
  }

  if(namespace_dc2e59577d3a271f::has_ammo_mod(weapon)) {
    return namespace_dc2e59577d3a271f::function_10839073a33f4feb(weapon);
  }

  return int(0);
}

function function_d4897d4fc2a76e56(weapon) {
  if(!isPlayer(self)) {
    return "";
  }

  if(namespace_dc2e59577d3a271f::has_ammo_mod(weapon)) {
    return namespace_dc2e59577d3a271f::get_ammo_mod_name(weapon);
  }

  return "";
}

function get_pap_level(weapon) {
  if(!isPlayer(self) || !isDefined(self.var_7a6ac8a30c8eef4c) || !isDefined(weapon)) {
    return int(0);
  }

  weapon = weapon getnoaltweapon();

  foreach(papstruct in self.var_7a6ac8a30c8eef4c) {
    if(weapon == papstruct.weapon) {
      return papstruct.n_level;
    }
  }

  return int(0);
}

function private function_9978ad7acc70bbd0(params) {
  function_2f370e45d49b5a9d();
}

function private function_2f370e45d49b5a9d(weapon) {
  weapon = default_to(weapon, self getcurrentweapon());
  n_pap_level = get_pap_level(weapon);
  self setclientomnvar("ui_pap_current_level", n_pap_level);
}

function function_29fecb7dd1dd0df2(s_pap, currentweapon, item) {
  s_pap.mdl_pap utility::function_3677f2be30fdd581("base", "pap_activate");
  self playsoundtoplayer("ui_zm_core_purchase_success", self);
  var_2fcb35d230365682 = function_8ffd6120b9e72251(self.origin);
  cost = 0;
  currency = "essence";

  if(isDefined(item)) {
    cost = item.cost;
    currency = item.currency;
  }

  if(isDefined(level.var_cfd619492cf55b20)) {
    cost = [[level.var_cfd619492cf55b20]]();
  }

  namespace_dc2e59577d3a271f::add_ammo_mod_to_weapon(currentweapon, item.itemref);
  self setclientomnvar("ui_pap_current_ammomod", item.itemid);
  scripts\cp_mp\currency::attempt_purchase(currency, cost, 1, undefined, #"ammomod", item.itemref);
  self setclientomnvar(var_2fcb35d230365682.var_8b8931f97eef184, 1);
  self setclientomnvar(var_2fcb35d230365682.var_fd0ea8a834fa0398, gettime());
  level notify("pap_machine_activated");
}

function function_2756cd1449650568(weapon, n_level) {
  var_f4d601b2527b35cf = 0;
  weapon = weapon getnoaltweapon();

  foreach(i, papstruct in self.var_7a6ac8a30c8eef4c) {
    if(papstruct.weapon == weapon) {
      var_f4d601b2527b35cf = 1;
      papstruct.n_level = n_level;

      if(!isDefined(n_level)) {
        self.var_7a6ac8a30c8eef4c[i] = undefined;
        self.var_7a6ac8a30c8eef4c = array_remove_index(self.var_7a6ac8a30c8eef4c, i);
      }
    }
  }

  if(!var_f4d601b2527b35cf && isDefined(n_level)) {
    papstruct = spawnStruct();
    papstruct.weapon = weapon;
    papstruct.n_level = n_level;
    self.var_7a6ac8a30c8eef4c = array_add(self.var_7a6ac8a30c8eef4c, papstruct);
  }

  function_2f370e45d49b5a9d(weapon);
}

function open_pap_menu(s_pap) {
  self endon("death_or_disconnect");
  self endon("end_open_pap_menu");
  var_2fcb35d230365682 = function_8ffd6120b9e72251(self.origin);
  var_57c182cc0f81b65b = function_127acf3af63de42e().var_69e6100b657f07a6;

  if(istrue(var_57c182cc0f81b65b)) {
    iprintlnbold(self.name + "<dev string:x267>" + s_pap.name + "<dev string:x272>");

    w_current = self getcurrentweapon();
    var_3cf65499b595d11b = get_pap_level(w_current);
    var_f8dabd5cffe4bfa2 = function_54241c8e78e3cd50(w_current);
    var_28b67a6edc18367e = var_2fcb35d230365682.ref;
    var_bf1eb50af72af = default_to(var_2fcb35d230365682.id, -1);
    self setclientomnvar("ui_pap_current_level", var_3cf65499b595d11b);
    self setclientomnvar("ui_pap_current_ammomod", var_f8dabd5cffe4bfa2);
    self setclientomnvar("ui_purchasemenu_id", var_bf1eb50af72af);
    self setclientomnvar(var_2fcb35d230365682.var_c7ffb2549ca8ab4b, gettime());
    function_997e20f4d9f30586(1);
    thread function_e1fa842581ec1de5(s_pap);
    return;
  }

  currentweapon = self getcurrentweapon();
  var_3cf65499b595d11b = get_pap_level(currentweapon);
  var_2fcb35d230365682 = function_8ffd6120b9e72251(self.origin);
  item = purchasemenu::function_904f24ea774b8f6f(var_2fcb35d230365682.ref, var_3cf65499b595d11b);

  if(!isDefined(item)) {
    return;
  }

  if(!function_6cea50c31fdfd0b9(var_3cf65499b595d11b) || self ismeleeing()) {
    self playsoundtoplayer("ui_zm_core_purchase_deny", self);
    return;
  }

  if(can_pap(currentweapon)) {
    function_ac4575f20a9ea183(self.s_pap_machine, var_3cf65499b595d11b, currentweapon, item);
  }
}

function function_ac4575f20a9ea183(s_pap, var_5476695cf42091ed, currentweapon, item) {
  var_2fcb35d230365682 = function_8ffd6120b9e72251(self.origin);
  var_ab757fcef92af3cb = var_5476695cf42091ed + 1;
  b_success = s_pap.mdl_pap utility::function_3677f2be30fdd581("base", "pap_activate_" + var_ab757fcef92af3cb);

  if(b_success) {
    s_pap thread function_95cc8bee3147df44("pap_activate_" + var_ab757fcef92af3cb);
  } else {
    s_pap.mdl_pap utility::function_3677f2be30fdd581("base", "pap_activate");
    s_pap thread function_95cc8bee3147df44("pap_activate");
  }

  if(isDefined(level.var_f932763b261a721f)) {
    if(![[level.var_f932763b261a721f]](self)) {
      self playsoundtoplayer("ui_zm_core_purchase_success", self);
    }
  } else {
    self playsoundtoplayer("ui_zm_core_purchase_success", self);
  }

  cost = 0;
  currency = "essence";

  if(isDefined(item)) {
    cost = item.cost;
    currency = item.currency;
  }

  if(isDefined(level.var_cfd619492cf55b20)) {
    cost = [[level.var_cfd619492cf55b20]]();
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_exfil_pap_percent_reward")) {
    cost = int(cost * level.perkbundles["specialty_exfil_pap_percent_reward"].var_7091af12e157769c);
  }

  pap_weapon(currentweapon, var_5476695cf42091ed, cost);
  scripts\cp_mp\currency::attempt_purchase(currency, cost, 1, undefined, #"packapunch");
  params = {
    #n_pap_level: var_5476695cf42091ed + 1, #cost: cost, #weapon: currentweapon
  };
  callback::callback("on_pap_machine_purchase", params);
  self setclientomnvar(var_2fcb35d230365682.var_8b8931f97eef184, 1);
  self setclientomnvar(var_2fcb35d230365682.var_fd0ea8a834fa0398, gettime());
  level notify("pap_machine_activated");
}

function function_95cc8bee3147df44(var_b806709d552b38f7) {
  self.mdl_pap endon("death");

  while(self.mdl_pap utility::function_35c178c80fa19cbd("base", var_b806709d552b38f7)) {
    waitframe();
  }

  thread function_89884a03ad5f622c();
}

function get_pap_camo(currentweapon, upgradedlevel) {
  pap_camo = undefined;
  var_cdc27fec07c02e7d = currentweapon.basename;
  var_57383025a4257b70 = upgradedlevel - 1;

  if(isarray(level.var_87233c2c2faa12cb) && array_contains(level.var_87233c2c2faa12cb, var_cdc27fec07c02e7d)) {
    pap_camo = undefined;
  } else if(isarray(level.pap_camos) && isDefined(level.pap_camos[var_57383025a4257b70]) && var_57383025a4257b70 < level.pap_camos.size) {
    pap_camo = level.pap_camos[var_57383025a4257b70].camo;
  }

  if(!isDefined(pap_camo) || istrue(self.var_f7d4ae1ceae3077d)) {
    return getweaponcamoname(currentweapon);
  }

  return pap_camo;
}

function function_5441576d06b2a361() {
  if(!isDefined(self.mdl_pap)) {
    return;
  }

  self endon("disable_pap");
  self.mdl_pap endon("death");
  var_be315f6c9827b6da = 48;

  while(true) {
    throttle::function_f632348cbb773537(level.var_41b1ceff53cc7e4d, self);
    var_727b1c6120940fca = getplayersandaiarrayinradius(self.origin, var_be315f6c9827b6da);

    if(var_727b1c6120940fca.size == 0) {
      throttle::function_f632348cbb773537(level.var_41b1ceff53cc7e4d, self);
      continue;
    }

    a_players = [];

    foreach(ent in var_727b1c6120940fca) {
      if(isPlayer(ent) && isalive(ent)) {
        a_players[a_players.size] = ent;
      }
    }

    var_8ead1b5013893ee7 = 0;

    foreach(player in a_players) {
      if(player ismeleeing() && !istrue(player.var_69103c55b4319619) && scripts\engine\utility::within_fov(player.origin, player.angles, self.origin, cos(70))) {
        player thread function_b8b51ba0ac848253();

        if(istrue(player.var_f7d4ae1ceae3077d)) {
          player.var_f7d4ae1ceae3077d = undefined;

          iprintlnbold("<dev string:x282>" + player.name);
        } else {
          player.var_f7d4ae1ceae3077d = 1;

          iprintlnbold("<dev string:x2aa>" + player.name);
        }

        var_8ead1b5013893ee7 = 1;
      }
    }

    if(var_8ead1b5013893ee7) {
      self.mdl_pap utility::function_3677f2be30fdd581("base", "pap_static");
      wait 0.5;
      self.mdl_pap utility::function_3677f2be30fdd581("base", "pap_activate");
    }
  }
}

function function_b8b51ba0ac848253() {
  self endon("disconnect");
  self.var_69103c55b4319619 = 1;
  wait 3;
  self.var_69103c55b4319619 = undefined;
}

function pap_weapon(currentweapon, var_5476695cf42091ed, cost, var_4d10547837384577) {
  var_1de7c3eef64bb0bb = var_5476695cf42091ed + 1;
  w_take = currentweapon getnoaltweapon();
  w_new = function_a0537467c5341047(w_take, var_1de7c3eef64bb0bb);
  var_7d014f270bcc9853 = undefined;

  if(w_take != currentweapon) {
    var_7d014f270bcc9853 = w_new getaltweapon();
  }

  var_3a56a10345d2e89a = w_new.var_9d7facbe889e667c;

  if(isDefined(self.ammo_mod[var_3a56a10345d2e89a])) {
    self.ammo_mod[var_3a56a10345d2e89a].weaponobj = w_new;
  }

  if(var_5476695cf42091ed == 0 || istrue(var_4d10547837384577)) {
    if(!isDefined(self.var_c37e65eb7cc773eb)) {
      self.var_c37e65eb7cc773eb = [];
    }

    self.var_c37e65eb7cc773eb[var_3a56a10345d2e89a] = w_take.camo;
  }

  level notify("pap_used", self, var_1de7c3eef64bb0bb, w_new);
  oldammocount = 0;

  if(getdvarint(@ "hash_c4ccc540649a56f0", 0) && istrue(w_take.hasalternate)) {
    var_75a36fc4b9ce8086 = w_take getaltweapon();
    oldammocount = self getweaponammoclip(var_75a36fc4b9ce8086);
  }

  params = spawnStruct();
  params.w_new = w_new;
  params.w_take = w_take;
  params.var_7d014f270bcc9853 = var_7d014f270bcc9853;
  params.n_pap_level = var_5476695cf42091ed + 1;
  params.cost = cost;
  callback::callback("zm_packed_weapon", params);
  self takeweapon(w_take);
  self giveweapon(w_new);
  self switchtoweapon(default_to(var_7d014f270bcc9853, w_new));
  self givemaxammo(w_new);

  if(getdvarint(@ "hash_c4ccc540649a56f0", 0) && istrue(w_new.hasalternate)) {
    var_941519edf56b651d = w_new getaltweapon();

    if(isDefined(var_941519edf56b651d.underbarrel) && var_941519edf56b651d.underbarrel == "jup_ub_flame_01") {
      if(isDefined(var_941519edf56b651d.underbarrel) && var_941519edf56b651d.underbarrel == "jup_ub_flame_01") {
        self setweaponammoclip(var_941519edf56b651d, oldammocount);
      }
    }
  }

  function_2756cd1449650568(w_new, var_1de7c3eef64bb0bb);
  self notify("weapon_level_changed");
  self setclientomnvar("ui_pap_current_level", var_1de7c3eef64bb0bb);
}

function function_a0537467c5341047(currentweapon, var_5476695cf42091ed) {
  ammo_mod_name = function_d4897d4fc2a76e56(currentweapon);
  camo = get_pap_camo(currentweapon, var_5476695cf42091ed);
  reticle = getweaponreticlename(currentweapon);

  if(issubstr(reticle, "scope")) {
    reticle = int(removesubstr(reticle, "scope"));

    if(reticle == 0) {
      reticle = undefined;
    }
  } else if(!isDefined(scripts\cp_mp\weapon::getreticleindex(reticle))) {
    reticle = undefined;
  }

  variantid = getweaponvariantindex(currentweapon);
  stickers = [currentweapon.stickerslot0, currentweapon.stickerslot1, currentweapon.stickerslot2, currentweapon.stickerslot3, default_to(currentweapon.var_b39ac546cc8621f8, "none")];
  currentattachments = currentweapon.attachments;
  currentattachmentids = currentweapon.attachmentvarindices;
  [newattachments, var_e27c23a69f06105a] = function_5672811f81d28777(currentweapon, currentattachments, currentattachmentids, var_5476695cf42091ed);
  w_new = scripts\cp_mp\weapon::buildweapon(currentweapon.basename, newattachments, camo, reticle, variantid, var_e27c23a69f06105a, undefined, stickers);

  if(isDefined(ammo_mod_name) && ammo_mod_name != "") {
    namespace_dc2e59577d3a271f::add_ammo_mod_to_weapon(w_new, ammo_mod_name);
  }

  return w_new;
}

function function_5672811f81d28777(weapon, attachments, attachmentids, usedlevel) {
  str_weapon_name = weapon.var_9d7facbe889e667c;

  if(isDefined(level.weaponmetadata) && isDefined(level.weaponmetadata[str_weapon_name])) {
    var_be53b174c615d624 = level.weaponmetadata[str_weapon_name].var_60cd7d2641a6671b;
    var_c2d75e1eaa5db67a = level.weaponmetadata[str_weapon_name].var_9e1e9ec0fd561685;
    assertex(isDefined(var_be53b174c615d624) && isDefined(var_c2d75e1eaa5db67a), "<dev string:x2d3>");

    if(weapon hasattachment("jup_jp35_sn_moscar_bar_blund")) {
      var_c2d75e1eaa5db67a = "zm_sn_moscar_pack_blund";
    }

    if(!array_contains(attachments, var_c2d75e1eaa5db67a) && weapon canuseattachment(var_c2d75e1eaa5db67a)) {
      attachments = array_remove(attachments, var_be53b174c615d624);
      attachments = array_add(attachments, var_c2d75e1eaa5db67a);
      attachmentids[var_c2d75e1eaa5db67a] = 0;
    }

    if(usedlevel > 1) {
      var_c6813356cbede5a1 = var_c2d75e1eaa5db67a + usedlevel;

      if(weapon canuseattachment(var_c6813356cbede5a1)) {
        attachments = array_remove(attachments, var_c2d75e1eaa5db67a);
        attachments = array_add(attachments, var_c6813356cbede5a1);
        attachmentids[var_c6813356cbede5a1] = 0;
      }
    }
  }

  return [attachments, attachmentids];
}

function function_8a514af6a4020(weapon) {
  new_weapon = undefined;

  if(isDefined(level.weaponmetadata) && isDefined(weapon.var_9d7facbe889e667c) && isDefined(level.weaponmetadata[weapon.var_9d7facbe889e667c]) && isDefined(level.weaponmetadata[weapon.var_9d7facbe889e667c].var_9e1e9ec0fd561685)) {
    var_60616b825c1aaaec = level.weaponmetadata[weapon.var_9d7facbe889e667c].var_9e1e9ec0fd561685;

    if(weapon hasattachment(var_60616b825c1aaaec)) {
      new_weapon = weapon withoutattachment(var_60616b825c1aaaec);
    }
  }

  if(isDefined(level.pap_camos) && isDefined(weapon.camo) && weapon.camo != "none") {
    foreach(camostruct in level.pap_camos) {
      if(weapon.camo == camostruct.camo) {
        if(isDefined(new_weapon)) {
          new_weapon = new_weapon withoutcamo();
        } else {
          new_weapon = weapon withoutcamo();
        }

        break;
      }
    }
  }

  if(isDefined(self.var_c37e65eb7cc773eb)) {
    var_2912941440454da4 = self.var_c37e65eb7cc773eb[weapon.var_9d7facbe889e667c];

    if(isDefined(var_2912941440454da4)) {
      if(isDefined(new_weapon)) {
        new_weapon = new_weapon withcamo(var_2912941440454da4);
      } else {
        new_weapon = weapon withcamo(var_2912941440454da4);
      }

      self.var_c37e65eb7cc773eb[weapon.var_9d7facbe889e667c] = undefined;
    }
  }

  if(isDefined(new_weapon)) {
    self takeweapon(weapon);
    self giveweapon(new_weapon);
    self switchtoweapon(new_weapon);
    function_2756cd1449650568(new_weapon, undefined);
    self notify("weapon_level_changed");
    self setclientomnvar("ui_pap_current_level", 0);
  }
}

function can_pap(weapon) {
  if(!isDefined(weapon)) {
    weapon = self getcurrentweapon();
  }

  if(!isDefined(level.var_74cdac95bea43e20[weapon.var_9d7facbe889e667c])) {
    return false;
  }

  var_3cf65499b595d11b = get_pap_level(weapon);

  if(var_3cf65499b595d11b < 3) {
    return true;
  }

  return false;
}

function function_6cea50c31fdfd0b9(menuitemindex) {
  var_2fcb35d230365682 = function_8ffd6120b9e72251(self.origin);
  item = purchasemenu::function_904f24ea774b8f6f(var_2fcb35d230365682.ref, menuitemindex);
  cost = 0;
  currency = "essence";

  if(isDefined(item)) {
    cost = item.cost;
    currency = item.currency;

    if(scripts\mp\utility\perk::_hasperk("specialty_exfil_pap_percent_reward")) {
      cost = int(cost * level.perkbundles["specialty_exfil_pap_percent_reward"].var_7091af12e157769c);
    }
  }

  return scripts\cp_mp\currency::can_afford(currency, cost);
}

function function_e1fa842581ec1de5(s_pap) {
  self notify("opened_pap_menu");
  self endon("opened_pap_menu");
  self endon("disconnect");
  var_2fcb35d230365682 = function_8ffd6120b9e72251(self.origin);
  machine = s_pap.mdl_pap;
  wait 0.75;
  var_cad20162f5a22ba4 = distance2d(machine.origin, self.origin);
  v_start = self.origin;
  var_85e549a4bd66c511 = utility::function_2e9e02e8bda61ef2();
  var_a8b5d0f96d82b5b3 = utility::function_2e9e02e8bda61ef2();
  var_4e92a6b7c0ecead5 = isDefined(var_85e549a4bd66c511) && isDefined(var_a8b5d0f96d82b5b3);

  while(isDefined(machine) && isalive(self) && !istrue(self.inlaststand) && !istrue(scripts\cp_mp\weapon::iskillstreakweapon(self getcurrentweapon()))) {
    if(!isDefined(machine) || self stancebuttonPressed()) {
      break;
    }

    if(!var_4e92a6b7c0ecead5) {
      if(!(distance2d(machine.origin, self.origin) <= var_cad20162f5a22ba4 || distance2d(self.origin, machine.origin) < 64)) {
        break;
      }
    }

    if(istrue(self.var_5070f05815274d88)) {
      break;
    }

    waitframe();
  }

  if(isDefined(self)) {
    self.var_5070f05815274d88 = undefined;
    self setclientomnvar(var_2fcb35d230365682.var_8b8931f97eef184, 2);
    self setclientomnvar(var_2fcb35d230365682.var_fd0ea8a834fa0398, gettime());
    function_997e20f4d9f30586(0);
    self.s_pap_machine = undefined;
    self notify("end_open_pap_menu");
  }
}

function private function_997e20f4d9f30586(var_87026d0546b5bf78) {
  if(var_87026d0546b5bf78) {
    val::set("using_pap", "melee", 0);
    val::set("using_pap", "killstreaks", 0);
    val::set("using_pap", "crate_use", 0);
    val::set("using_pap", "equipment_primary", 0);
    val::set("using_pap", "equipment_secondary", 0);
    val::set("using_pap", "offhand_weapons", 0);
    val::set("using_pap", "offhand_throwback", 0);
    val::set("using_pap", "weapon_switch", 0);
    return;
  }

  val::reset_all("using_pap");
}

function private function_48d69eea9b7ed244() {
  var_39239d1f90650b = (0, 0, 4);
  var_e33953429ed350f = 0.25;

  while(true) {
    foreach(s_pap in level.var_28967913115d1fa3) {
      if(!isDefined(s_pap.mdl_pap)) {
        continue;
      }

      if(!isDefined(s_pap.s_destination)) {
        if(isDefined(s_pap.str_destination)) {
          s_pap.s_destination = getStruct(s_pap.str_destination, "<dev string:x322>");
        } else {
          s_pap.str_destination = s_pap.name;
          s_pap.s_destination = s_pap;
        }
      }

      v_position = s_pap.mdl_pap.origin;
      line(v_position, s_pap.s_destination.origin, (0, 1, 0));
      draw_circle(v_position, 100, (0, 0, 1), 1, 0, 1);
      print3d(s_pap.s_destination.origin, "<dev string:x330>" + s_pap.str_destination, (0, 1, 0), 1, 0.25);
      print3d(v_position - var_39239d1f90650b * 1, "<dev string:x345>" + s_pap.name, (0, 1, 0), 1, 0.25);
      print3d(v_position - var_39239d1f90650b * 2, "<dev string:x353>" + default_to(s_pap.script_power, "<dev string:x363>"), (0, 1, 0), 1, 0.25);
      print3d(v_position - var_39239d1f90650b * 3, "<dev string:x367>" + ter_op(istrue(s_pap.var_cd756b37f6f0e181), "<dev string:x37a>", "<dev string:x381>"), (0, 1, 0), 1, 0.25);
      print3d(v_position - var_39239d1f90650b * 4, "<dev string:x387>" + s_pap.str_destination, (0, 1, 0), 1, 0.25);

      foreach(player in level.players) {
        if(isDefined(player.s_pap_machine)) {
          print3d(player.origin, player.name + "<dev string:x398>" + player.s_pap_machine.name, (0, 1, 0), 1, 0.25);
        }
      }
    }

    waitframe();
  }
}

# /