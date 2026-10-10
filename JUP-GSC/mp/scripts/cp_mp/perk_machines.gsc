/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\perk_machines.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using scripts\anim\utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\content_manager;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\purchasemenu;
#using scripts\cp_mp\zombie_perks;
#using scripts\engine\utility;
#using scripts\mp\utility\lui_game_event_aggregator;
#namespace perk_machines;

function function_c349718d60cc262b() {
  if(function_5ec3518dfd1490af(1 | 64 | 2 | 4 | 8 | 16 | 32)) {
    return;
  }

  scripts\cp_mp\content_manager::register_script("perk_machine", &function_203543d2ee9dcaf3);
  scripts\cp_mp\content_manager::register_script("perk_machine_choice", &function_9da5ba88150e778f);
  setup_wunderfizz();

  if(!istrue(level.gamemodebundle.var_7746f48b0ed07126)) {
    level thread function_7af59e607ac4bb14();
    return;
  }

  callback::add("ob_content_process_create_script", &function_7af59e607ac4bb14);
}

function function_ecf921d010c33dea() {
  return purchasemenu::function_cfd0e1fb13d7e080(#"wunderfizz");
}

function setup_wunderfizz() {
  level._custom_perks["specialty_choice"] = spawnStruct();
  level._custom_perks["specialty_choice"].cost = default_to(get_perk_machine_cost("specialty_choice"), 300);
  level._custom_perks["specialty_choice"].str_currency = default_to(function_bc4d94fa05ac7078("specialty_choice"), "essence");
  level._custom_perks["specialty_choice"].hint_string = &"SHARED_HINTSTRINGS/PERK_MACHINE_WUNDERFIZZ_USE";
}

function function_7af59e607ac4bb14(params) {
  level endon("game_ended");
  waittillframeend();
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&perk_choice_purchase);
  a_destinations = getStructArray("content_destination", "variantname");

  foreach(destination in a_destinations) {
    level thread function_b6cefb59989d14c(destination);
  }
}

function function_b6cefb59989d14c(destination, str_currency) {
  foreach(location in destination.locations) {
    var_24c0882a3b85c79f = location.instances["perk_machine"];

    if(isDefined(var_24c0882a3b85c79f)) {
      foreach(instance in var_24c0882a3b85c79f.versions) {
        scripts\cp_mp\content_manager::spawn_instance(instance);
      }
    }

    var_b34c518c4df088eb = location.instances["perk_machine_choice"];

    if(isDefined(var_b34c518c4df088eb)) {
      foreach(instance in var_b34c518c4df088eb.versions) {
        instance.script_currency = str_currency;
        scripts\cp_mp\content_manager::spawn_instance(instance);
      }
    }
  }
}

function function_948391d32c2e5823(instance) {
  perk = default_to(self.script_noteworthy, "talent_juggernog");

  if(!isDefined(self.script_noteworthy)) {
    println("<dev string:x1c>" + self.origin + "<dev string:x63>");
  }

  assertex(isDefined(level._custom_perks[perk]), "<dev string:x7a>" + perk + "<dev string:x83>");
  self.var_e89a9a6a3475bd0a = default_to(level._custom_perks[perk].var_e89a9a6a3475bd0a, "t10_zm_machine_juggernog");
  str_modelname = default_to(level._custom_perks[perk].var_6e91b48935b6d44f, self.var_e89a9a6a3475bd0a);
  self.var_a3266878acd43bb3 = spawnscriptable(str_modelname, self.origin, self.angles);
  self.script_currency = default_to(self.script_currency, function_bc4d94fa05ac7078(perk));
  self.radius = default_to(self.radius, 64);
  self.script_cost = default_to(self.script_cost, level._custom_perks[perk].cost);
  self.var_a3266878acd43bb3.interact = function_32645103f7520635(self.var_a3266878acd43bb3, &function_544d06d1d36ed577);
  self.var_a3266878acd43bb3.interact scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_b92f7075e8fd3081);
  self.var_a3266878acd43bb3 function_4c7967371b16c7f3(self.var_a3266878acd43bb3.interact);

  if(self.var_a3266878acd43bb3 getscriptablehaspart("use")) {
    self.var_a3266878acd43bb3 setscriptablepartstate("use", "default");
  }

  self.var_a3266878acd43bb3.interact.var_a2738a1d42906829 = self;
  self.var_a3266878acd43bb3 thread perk_machine_think(perk, self.var_a3266878acd43bb3.interact);
  self.var_a3266878acd43bb3 thread spare_change();
}

function private function_203543d2ee9dcaf3(instance) {
  spawn_points = instance.contentgroups["perk_machine_spawn"];

  foreach(point in spawn_points) {
    point function_948391d32c2e5823(instance);
  }
}

function function_c224859356dbfd3d() {
  level endon("game_ended");

  if(getdvarint(@ "hash_74cacae425805743", 0) > 0) {
    return undefined;
  }

  if(!isDefined(level.var_8241e0d86017df29)) {
    return;
  }

  a_perks = [];

  foreach(key, perk in level._custom_perks) {
    if(key != "specialty_choice") {
      a_perks = function_6d6af8144a5131f1(a_perks, perk);
    }
  }

  var_74dade39e02d8fee = [];
  var_3c3122af5c02bd7 = getStructArray("content_struct", "variantname");

  foreach(struct in var_3c3122af5c02bd7) {
    if(isDefined(struct.content_key) && struct.content_key == "perk_machine_region_spawn") {
      var_74dade39e02d8fee = array_add(var_74dade39e02d8fee, struct);
    }
  }

  if(isDefined(level.var_c383b967aa7e551b)) {
    var_74dade39e02d8fee = [[level.var_c383b967aa7e551b]]("perk", var_74dade39e02d8fee);
  } else {
    var_74dade39e02d8fee = array_randomize(var_74dade39e02d8fee);
  }

  var_aefc5436dfe3990 = [];

  foreach(spawn_point in var_74dade39e02d8fee) {
    str_region = [[level.var_8241e0d86017df29]](spawn_point.origin);

    if(str_region == "difficulty_easy") {
      var_aefc5436dfe3990[var_aefc5436dfe3990.size] = spawn_point;
    }
  }

  foreach(spawn_point in var_74dade39e02d8fee) {
    str_region = [[level.var_8241e0d86017df29]](spawn_point.origin);

    if(str_region != "difficulty_easy") {
      var_aefc5436dfe3990[var_aefc5436dfe3990.size] = spawn_point;
    }
  }

  var_d8343331f9203ec2 = array_randomize(arraycopy(a_perks));

  foreach(spawn_point in var_aefc5436dfe3990) {
    perk_struct = array_get_first_item(var_d8343331f9203ec2);
    perk_name = perk_struct.var_e3d5b979024de96;
    var_d8343331f9203ec2 = array_remove(var_d8343331f9203ec2, perk_struct);

    if(!isDefined(perk_name) || !isDefined(level._custom_perks[perk_name])) {
      continue;
    }

    spawn_point.script_noteworthy = perk_name;
    spawn_point function_948391d32c2e5823();

    if(getdvarint(@ "hash_219f76f29e4d14ce", 0) == 1) {
      level thread function_306940dddbeb1537(spawn_point);
    }

    if(var_d8343331f9203ec2.size < 1) {
      var_d8343331f9203ec2 = array_randomize(arraycopy(a_perks));
    }
  }

  callback::callback("ob_perks_create_script_done");
}

function private function_306940dddbeb1537(spawn_point) {
  level endon("<dev string:x9a>");

  while(isDefined(spawn_point.script_noteworthy)) {
    sphere(spawn_point.origin, 32);
    print3d(spawn_point.origin, spawn_point.script_noteworthy);
    waitframe();
  }
}

function private function_9da5ba88150e778f(instance) {
  spawn_points = instance.contentgroups["perk_machine_choice_spawn"];

  if(isarray(spawn_points)) {
    foreach(point in spawn_points) {
      point thread function_584ef0be51af00df(instance);
    }
  }
}

function private function_b92f7075e8fd3081(usable, player) {
  if(isDefined(player) && isDefined(usable)) {
    perk = usable.script_notify;
    str_key = default_to(usable.script_notify, "talent_juggernog");

    if(usable getscriptablepartstate("base") == "power_off") {
      return {
        #string: &"SHARED_HINTSTRINGS/NEED_POWER", #type: "HINT_NOBUTTON"};
    } else if(istrue(level.var_7671231718df0382)) {
      return {
        #string: &"", #type: "HINT_NOICON"};
    } else if(istrue(player.interactions_disabled)) {
      return {
        #string: &"", #type: "HINT_NOICON"};
    } else if(player has_perk(level._custom_perks[perk].var_e3d5b979024de96)) {
      return {
        #string: &"", #type: "HINT_NOICON"};
    } else {
      perk_cost = player function_b1e24c0eaeadfac7();
      hint_string = scripts\engine\utility::ter_op(player function_bcc79745d547a99c(function_bc4d94fa05ac7078(perk), perk_cost), level._custom_perks[str_key].hint_string, level._custom_perks[str_key].var_2e1ef6ec4d3bd5bb);
      return {
        #params: [perk_cost], #string: hint_string, #type: "HINT_BUTTON"};
    }
  }

  return {
    #string: &"", #type: "HINT_NOICON"};
}

function function_544d06d1d36ed577(player) {
  perk = self.script_notify;
  assertex(isDefined(level._custom_perks[perk]), "<dev string:x7a>" + perk + "<dev string:x83>");
  var_a2738a1d42906829 = self.var_a2738a1d42906829;

  if(isDefined(player) && isDefined(var_a2738a1d42906829.script_currency)) {
    if(player has_perk(level._custom_perks[perk].var_e3d5b979024de96)) {
      return;
    }

    if(istrue(level.var_7671231718df0382)) {
      return;
    }

    if(istrue(player.interactions_disabled)) {
      return;
    }

    if(!player scripts\cp_mp\currency::attempt_purchase(var_a2738a1d42906829.script_currency, player function_b1e24c0eaeadfac7(), 1, undefined, #"perk", perk)) {
      return;
    }

    var_a3266878acd43bb3 = var_a2738a1d42906829.var_a3266878acd43bb3;

    if(var_a3266878acd43bb3 getscriptablehaspart("use")) {
      if(var_a3266878acd43bb3 getscriptablepartstate("use") == "default") {
        var_a3266878acd43bb3 setscriptablepartstate("use", "purchase");
      }
    }

    gesture = default_to(level._custom_perks[perk].perk_bottle_weapon, "cer_zm_vm_ges_001");
    player thread function_fe9f92094d839eaf(gesture);
    thread function_578601bd71a362c8(perk);
    params = spawnStruct();
    params.perk_machine = self;
    player callback::callback("zm_perk_machine_used", params);
    paramspurchased = spawnStruct();
    paramspurchased.perkref = perk;
    player callback::callback("zm_perk_purchased", paramspurchased);
    player give_perk(perk, 1);
  }
}

function perk_machine_think(str_key, interact) {
  assertex(isDefined(str_key), "<dev string:xa8>");
  str_endon = str_key + "_power_thread_end";
  level endon(str_endon);
  self endon(str_endon);
  str_notify = str_key + "_power_on";
  power_flag = "power_on";
  var_d3ad2dc5ad2d4ce1 = 0;
  var_67aef9f8f6e33e53 = isDefined(self.var_a2738a1d42906829.script_int) ? 1 : 0;

  while(true) {
    self setscriptablepartstate("base", "power_off");
    self.script_notify = str_key;
    self.b_keep_when_turned_off = 1;
    var_c5f973f78b2d3fa = get_perk_machine_start_state(str_key);

    if(!var_d3ad2dc5ad2d4ce1 && var_c5f973f78b2d3fa) {
      waitframe();
    } else if(var_67aef9f8f6e33e53) {
      level flag_wait(power_flag + self.var_a2738a1d42906829.script_int);
    } else {
      level flag_wait(power_flag);
    }

    function_b7b11dcefd51d18f(str_key, interact);
    level notify(str_notify);
    var_d3ad2dc5ad2d4ce1 = 1;

    if(var_67aef9f8f6e33e53) {
      level flag_waitopen(power_flag + self.var_a2738a1d42906829.script_int);
    } else {
      if(!level flag_exist(power_flag)) {
        return;
      }

      level flag_waitopen(power_flag);
    }

    function_4c7967371b16c7f3(interact);
  }
}

function get_perk_machine_start_state(perk) {
  if(istrue(level.vending_machines_powered_on_at_start)) {
    return true;
  }

  if(isDefined(level.var_ab3f1eda83f38495) && istrue(level.var_ab3f1eda83f38495[perk])) {
    return true;
  }

  return false;
}

function function_4c7967371b16c7f3(interact) {
  self notify("endPerkJingleWatcher");
  self setscriptablepartstate("base", "power_off");
}

function function_b7b11dcefd51d18f(str_key, interact) {
  thread function_b9232d78e96ab157(str_key);
  self setscriptablepartstate("base", "power_activate");
}

function function_c882eef34c5e389b(interact) {
  self notify("endPerkJingleWatcher");
  self setscriptablepartstate("base", "power_off");
  interact sethintinoperable(1);
}

function function_af4a04f18b0a937(str_key, interact) {
  interact sethintinoperable(0);
  thread function_b9232d78e96ab157(str_key, 1);
  self setscriptablepartstate("base", "power_activate");
}

function function_359eb1acd4585386(usable, player) {
  if(isDefined(player) && isDefined(usable)) {
    if(usable getscriptablepartstate("base") == "power_off") {
      return {
        #string: &"SHARED_HINTSTRINGS/NEED_POWER", #type: "HINT_NOBUTTON"};
    } else if(istrue(player.interactions_disabled)) {
      return {
        #string: &"", #type: "HINT_NOICON"};
    } else {
      str_key = default_to(usable.script_notify, "talent_juggernog");
      return {
        #params: [level._custom_perks[str_key].cost], #string: level._custom_perks[str_key].hint_string, #type: "HINT_BUTTON"};
    }
  }

  return {
    #string: &"", #type: "HINT_NOICON"};
}

function spare_change() {
  offsetvec = vectorNormalize(anglesToForward(self.angles)) * 20;
  trigger = spawn("noent_volume_trigger_rotatable_radius", self.origin + offsetvec, 0, 64, 64);
  trigger.mdl_machine = self;
  trigger thread check_for_change();
}

function check_for_change() {
  self endon("death");

  while(true) {
    self waittill("trigger", player);

    if(!isDefined(player.inlaststand)) {
      player.inlaststand = 0;
    }

    if(isPlayer(player) && player getstance() == "prone" && !player.inlaststand) {
      params = spawnStruct();
      params.scoreevent = #"loose_change";
      player callback::callback("zombie_score_event", params);

      if(self.mdl_machine getscriptablehaspart("sparechange")) {
        self.mdl_machine setscriptablepartstate("sparechange", "activate");
      }

      player playRumbleOnEntity("damage_light");
      break;
    }

    wait 0.1;
  }

  self delete();
}

function function_b9232d78e96ab157(var_8686b40485143989, var_95427d8098dd59a1) {
  if(!isDefined(var_95427d8098dd59a1)) {
    var_95427d8098dd59a1 = 0;
  }

  self endon("death");
  self endon("endPerkJingleWatcher");

  while(true) {
    wait randomintrange(90, 180);

    if(self getscriptablehaspart("music")) {
      if(self getscriptablepartstate("music") == "off") {
        players = namespace_2b1145f62aa835b8::function_883458a342af3041(self.origin, 1250);

        if(!isDefined(players) || players.size < 1) {
          continue;
        }

        if(var_95427d8098dd59a1) {
          var_273d9353f8f2f553 = array_random(level.var_a2e80fb79bc0de74);
          self setscriptablepartstate("music", var_273d9353f8f2f553 + "_jingle");
          continue;
        }

        self setscriptablepartstate("music", var_8686b40485143989 + "_jingle");
      }
    }
  }
}

function function_578601bd71a362c8(var_8686b40485143989) {
  self endon("death");

  if(self getscriptablehaspart("music")) {
    if(self getscriptablepartstate("music") == "off") {
      self setscriptablepartstate("music", var_8686b40485143989 + "_stinger");
    }
  }
}

function function_584ef0be51af00df(instance) {
  if(getdvarint(@ "hash_74cacae425805743", 0) > 0) {
    return undefined;
  }

  flag_wait("StartGameTypeCallbackFinished");
  perkbundle = level.perkbundles["specialty_wunderfizz"];
  var_953b250010c4fc20 = "t10_zm_machine_wunderfizz";
  var_2f463322f2ae7afc = "t10_zm_machine_wunderfizz_fxanim";

  if(isDefined(perkbundle)) {
    var_953b250010c4fc20 = default_to(perkbundle.var_50ff10282e5fb08f, "t10_zm_machine_wunderfizz");
    var_2f463322f2ae7afc = default_to(perkbundle.var_c70f3f3a7f26b274, "t10_zm_machine_wunderfizz_fxanim");
  }

  self.var_e89a9a6a3475bd0a = default_to(self.script_noteworthy, var_953b250010c4fc20);
  self.var_a3266878acd43bb3 = scripts\cp_mp\content_manager::spawn_script_model(self, var_2f463322f2ae7afc, 1, 1);
  self.script_currency = default_to(instance.script_currency, "essence");
  self.radius = default_to(self.radius, 64);
  self.script_cost = level._custom_perks["specialty_choice"].cost;
  self.var_a3266878acd43bb3.interact = scripts\cp_mp\interaction::register_interact(self.var_a3266878acd43bb3, self.radius, &function_bc46233a2d861c6f);
  self.var_a3266878acd43bb3.interact setusefov(180);
  self.var_a3266878acd43bb3.interact scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_359eb1acd4585386);
  self.var_a3266878acd43bb3 function_c882eef34c5e389b(self.var_a3266878acd43bb3.interact);

  if(self.var_a3266878acd43bb3 getscriptablehaspart("use")) {
    self.var_a3266878acd43bb3 setscriptablepartstate("use", "default");
  }

  if(self.var_a3266878acd43bb3 tagexists("tag_hint")) {
    self.var_a3266878acd43bb3 sethinttag("tag_hint");
  }

  self.var_a3266878acd43bb3.interact.var_a2738a1d42906829 = self;
  self.var_a3266878acd43bb3 thread function_d24f7f1b9f196edc(self.var_a3266878acd43bb3.interact);
  self.var_a3266878acd43bb3 thread spare_change();
}

function function_d24f7f1b9f196edc(interact) {
  str_key = "specialty_choice";
  str_endon = str_key + "_power_thread_end";
  level endon(str_endon);
  self endon(str_endon);
  str_notify = str_key + "_power_on";
  power_flag = "power_on";
  var_d3ad2dc5ad2d4ce1 = 0;
  var_f08be12e08d353d1 = self isscriptable() ? 1 : 0;
  var_67aef9f8f6e33e53 = isDefined(self.var_a2738a1d42906829.script_int) ? 1 : 0;

  while(true) {
    self setscriptablepartstate("base", "power_off");
    self solid();
    self.script_notify = str_key;
    self.b_keep_when_turned_off = 1;
    var_c5f973f78b2d3fa = get_perk_machine_start_state(str_key);

    if(!var_d3ad2dc5ad2d4ce1 && var_c5f973f78b2d3fa) {
      waitframe();
    } else if(var_67aef9f8f6e33e53) {
      level flag_wait(power_flag + self.var_a2738a1d42906829.script_int);
    } else {
      level flag_wait(power_flag);
    }

    function_af4a04f18b0a937(str_key, interact);
    level notify(str_notify);
    var_d3ad2dc5ad2d4ce1 = 1;

    if(var_67aef9f8f6e33e53) {
      level flag_waitopen(power_flag + self.var_a2738a1d42906829.script_int);
    } else {
      if(!level flag_exist(power_flag)) {
        return;
      }

      level flag_waitopen(power_flag);
    }

    function_c882eef34c5e389b(interact);
  }
}

function function_bc46233a2d861c6f(player) {
  if(isDefined(player) && istrue(player.interactions_disabled)) {
    return;
  }

  self.var_a2738a1d42906829.var_c80acd5b1945a70f = player;
  player.var_bc2162598ffb02f5 = self.var_a2738a1d42906829;
  player thread open_perk_choice_menu(self.var_a2738a1d42906829);
}

function perk_choice_purchase(channel, menuitemindex) {
  if(isDefined(menuitemindex)) {
    menuitemindex -= 1;

    if(channel == "perk_choice_purchase") {
      s_menu = function_ecf921d010c33dea();

      if(!isDefined(s_menu)) {
        return;
      }

      valid_perks = function_47a5564594564627();
      active_perks = function_ad6e85c9533ac466();

      if(isarray(active_perks)) {
        valid_perks = array_remove_array(valid_perks, active_perks);
      }

      item = purchasemenu::function_904f24ea774b8f6f(#"wunderfizz", menuitemindex);

      if(!isDefined(item.itemref) || !array_contains(valid_perks, item.itemref)) {
        return;
      }

      if(!istrue(function_6b2b78660b18dad9(menuitemindex, self))) {
        self setclientomnvar(s_menu.var_8b8931f97eef184, 3);
        self setclientomnvar(s_menu.var_fd0ea8a834fa0398, gettime());
        return;
      }

      gesture = default_to(level._custom_perks[item.itemref].perk_bottle_weapon, "cer_zm_vm_ges_001");
      thread function_fe9f92094d839eaf(gesture);
      self playsoundtoplayer("ui_zm_core_purchase_success", self);
      params = spawnStruct();
      params.perk_machine = self;
      callback::callback("zm_perk_machine_used", params);
      give_perk(item.itemref);
      paramspurchased = spawnStruct();
      paramspurchased.perkref = item.itemref;
      callback::callback("zm_perk_purchased", paramspurchased);

      if(isDefined(self.var_bc2162598ffb02f5)) {
        if(isDefined(self.var_bc2162598ffb02f5.var_a3266878acd43bb3)) {
          self.var_bc2162598ffb02f5.var_a3266878acd43bb3 thread function_578601bd71a362c8(item.itemref);
        }
      }

      self setclientomnvar(s_menu.var_8b8931f97eef184, 1);
      self setclientomnvar(s_menu.var_fd0ea8a834fa0398, gettime());
      self notify("wunderfizz_purchase");
      return;
    }

    if(purchasemenu::function_5c9b6f1c3c67dd97(#"wunderfizz", channel)) {
      self.var_9dd6c300aac05ba7 = 1;
    }
  }
}

function function_6b2b78660b18dad9(menuitemindex, player) {
  cost = 0;
  currency = "essence";
  item = purchasemenu::function_904f24ea774b8f6f(#"wunderfizz", menuitemindex);

  if(isDefined(player) && isDefined(item)) {
    cost = player function_b1e24c0eaeadfac7();
    currency = item.currency;
  }

  return scripts\cp_mp\currency::attempt_purchase(currency, cost, 1, undefined, #"perk", item.itemref);
}

function open_perk_choice_menu(var_a2738a1d42906829) {
  self endon("death_or_disconnect");
  self endon("end_open_perk_choice_menu");
  s_menu = function_ecf921d010c33dea();

  if(!isDefined(s_menu)) {
    return;
  }

  var_bf1eb50af72af = default_to(s_menu.id, -1);
  self setclientomnvar("ui_purchasemenu_id", var_bf1eb50af72af);
  self setclientomnvar(s_menu.var_c7ffb2549ca8ab4b, gettime());
  thread function_a9620a0e00513b98(var_a2738a1d42906829);
  thread function_86ea6001c8038726(var_a2738a1d42906829);
}

function function_a9620a0e00513b98(var_a2738a1d42906829) {
  self notify("opened_perk_choice_menu");
  self endon("opened_perk_choice_menu");
  self endon("disconnect");
  s_menu = function_ecf921d010c33dea();

  if(!isDefined(s_menu)) {
    return;
  }

  machine = var_a2738a1d42906829.var_a3266878acd43bb3;
  wait 0.75;
  var_cad20162f5a22ba4 = distance2d(machine.origin, self.origin);
  v_start = self.origin;
  self.var_9dd6c300aac05ba7 = undefined;

  while(isDefined(machine) && isalive(self) && !istrue(self.inlaststand) && (distance2d(machine.origin, self.origin) <= var_cad20162f5a22ba4 || distance2d(self.origin, machine.origin) < 32)) {
    if(!isDefined(machine) || self stancebuttonPressed() || istrue(self.var_9dd6c300aac05ba7)) {
      break;
    }

    waitframe();
  }

  if(isDefined(self)) {
    self.var_9dd6c300aac05ba7 = undefined;
    self setclientomnvar(s_menu.var_8b8931f97eef184, 2);
    self setclientomnvar(s_menu.var_fd0ea8a834fa0398, gettime());
    self.var_a2738a1d42906829 = undefined;
    self notify("end_open_perk_choice_menu");
  }
}

function function_86ea6001c8038726(var_a2738a1d42906829) {
  self notify("opened_perk_choice_purchase_watcher");
  self endon("opened_perk_choice_purchase_watcher");
  self endon("end_open_perk_choice_menu");
  self endon("disconnect");
  var_a3266878acd43bb3 = var_a2738a1d42906829.var_a3266878acd43bb3;

  while(true) {
    self waittill("wunderfizz_purchase");

    if(var_a3266878acd43bb3 getscriptablehaspart("use")) {
      if(var_a3266878acd43bb3 getscriptablepartstate("use") == "default") {
        var_a3266878acd43bb3 setscriptablepartstate("use", "purchase");
      }
    }

    waitframe();
  }
}