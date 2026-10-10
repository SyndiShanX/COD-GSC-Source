/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_6b80871eb8142180.gsc
*************************************************/

#using script_3a8f9ace195c9da9;
#using script_42f868a5dda17294;
#using script_737f801e6beb18c7;
#using script_a13c48184daa195;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp\pickups;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\stealth\debug;
#namespace namespace_48eb4046c956bbd1;

function function_4d36d847fd19889a() {
  self endon("disconnect");
  self endon("death");
  precacheshader("icon_waypoint_ally_marker");
  flag_set("map_scanner_idle");
  function_7a252abaaa15fcd7(["cp_equipment_pickups_spawned", "cp_custom_pickups_spawned", "item_caches_populated", "cp_munition_pickups_spawned", "cp_offhand_boxes_spawned"]);
  waittillframeend();
  var_d1a27c6e808af349 = namespace_1170726b2799ea65::function_ce720be6f935d1d4();

  if(isDefined(level.var_bb3505b72e24c478) && level.var_bb3505b72e24c478 == 1 || !isDefined(var_d1a27c6e808af349) || !isDefined(level.var_1b908bf18691b097)) {
    return;
  }

  if(getdvarint(@ "hash_889e903da314daeb") == 1) {
    function_2637c3558c8c74f2();
  }

  if(getdvarint(@ "hash_628e7a73a363d0cc", 0)) {
    return;
  }

  if(!isDefined(level.var_8b30d8e5d8aecf1)) {
    level.var_8b30d8e5d8aecf1 = spawnStruct();
  }

  setDvar(@ "hash_c12c690dcfc6dba8", 350);
  setDvar(@ "hash_19bde514af504ec5", 700);
  level.var_8b30d8e5d8aecf1.var_c22af36562dc6076 = 0;
  level.var_8b30d8e5d8aecf1.var_5f450c113ba90011 = 0;
  level.var_8b30d8e5d8aecf1.valid_entities = [];
  level.var_8b30d8e5d8aecf1.var_464ebc06bf7bd464 = function_64b3e41c19cd6764();
  level.var_8b30d8e5d8aecf1.valid_entities = function_321063175386197b();
  flag_clear("map_scanner_idle");
  level.var_8b30d8e5d8aecf1.var_de2c4be6028d536c = function_3df24da797614c3();
  level.var_8b30d8e5d8aecf1.var_ee6a16a8432a3f45 = [];
  level.var_8b30d8e5d8aecf1.var_7d2a44df69cf87b5 = 0;

  if(getdvarint(@ "hash_b8ee9af63e78f89a", 0)) {
    level function_88b96430fdacbb80();
  }

  thread function_2b6ed7aa07f89126();
  level function_dc3a836fb5697aa8();
  thread function_8bf9e23e9a179be0();

  level thread function_36c5aa6eecd737c3();

  flag_set("discoverable_population_complete");
}

function function_acaca00d0dfa757a() {
  var_8106529d8e3a6ac4 = function_a0f6a656b4ff38a2();

  if(isDefined(var_8106529d8e3a6ac4) && var_8106529d8e3a6ac4.size > 0) {
    while(namespace_e875ad14b292bd61::binoculars_isads()) {
      foreach(object in var_8106529d8e3a6ac4) {
        if(istrue(object.var_3d33ce746b270d75.is_objective)) {
          if(!istrue(object.var_3d33ce746b270d75.var_13d96f83acbfad65) || level.players[0] namespace_e875ad14b292bd61::function_67da6f8a8e37737b(object)) {
            object function_d82ca87796cf3232(1);
          } else {
            object function_d82ca87796cf3232(0);
          }

          continue;
        }

        object function_d82ca87796cf3232(level.players[0] namespace_e875ad14b292bd61::function_67da6f8a8e37737b(object));
      }

      wait 0.2;
    }
  }
}

function function_28f91cd6b13189a3() {
  var_8106529d8e3a6ac4 = function_a0f6a656b4ff38a2();

  if(isDefined(var_8106529d8e3a6ac4) && var_8106529d8e3a6ac4.size > 0) {
    foreach(object in var_8106529d8e3a6ac4) {
      object function_d82ca87796cf3232(0);
    }
  }
}

function function_8bf9e23e9a179be0() {
  self endon("death");
  self endon("disconnect");

  while(true) {
    if(namespace_e875ad14b292bd61::binoculars_isads()) {
      function_acaca00d0dfa757a();
    } else {
      function_28f91cd6b13189a3();
      self waittill("binoculars_ads_on");
    }

    wait 0.2;
  }
}

function function_321063175386197b() {
  discoverables = function_d27198aa1774955b();
  discoverables = function_6627a24ea20be5f5(discoverables);
  return discoverables;
}

function private function_d27198aa1774955b() {
  var_9aef2680c63367fc = [];

  foreach(var_4a188de690ec2901 in level.var_8b30d8e5d8aecf1.var_464ebc06bf7bd464) {
    founditems = function_8655f005f7a31be8(var_4a188de690ec2901);

    for(i = founditems.size; i >= 0; i--) {
      if(isDefined(founditems[i]) && istrue(founditems[i].var_be6b0f71bd991349)) {
        founditems[i] = undefined;
        continue;
      }

      if(isDefined(founditems[i])) {
        founditems[i].var_3d33ce746b270d75 = spawnStruct();
        founditems[i].var_3d33ce746b270d75.discovery_name = function_8c79e5a8c80c56c5(var_4a188de690ec2901);
      }
    }

    founditems = array_removeundefined(founditems);
    var_9aef2680c63367fc = array_combine(var_9aef2680c63367fc, founditems);
  }

  return var_9aef2680c63367fc;
}

function private function_8655f005f7a31be8(var_4a188de690ec2901) {
  if(!isDefined(var_4a188de690ec2901)) {
    return [];
  }

  founditems = getentitylessscriptablearray(var_4a188de690ec2901);

  if(!isDefined(founditems) || founditems.size == 0) {
    keys = ["targetname", "classname"];

    foreach(key in keys) {
      founditems = getEntArray(var_4a188de690ec2901, key);

      if(isDefined(founditems) && founditems.size > 0) {
        break;
      }
    }
  }

  return isDefined(founditems) && founditems.size > 0 ? founditems : [];
}

function private function_8c79e5a8c80c56c5(var_4a188de690ec2901) {
  var_a4e0ca52f78b686c = ["scriptable_"];
  estrings = ["_depth01", "_depth03", "_depth06", "_depth07", "_depth10", "_depth15", "_depth30"];

  foreach(sstring in var_a4e0ca52f78b686c) {
    var_4a188de690ec2901 = issubstr(var_4a188de690ec2901, sstring) ? removesubstr(var_4a188de690ec2901, sstring) : var_4a188de690ec2901;
  }

  foreach(estring in estrings) {
    var_4a188de690ec2901 = isendstr(var_4a188de690ec2901, estring) ? function_e84a5f30606d3a09(var_4a188de690ec2901, estring) : var_4a188de690ec2901;
  }

  return var_4a188de690ec2901;
}

function function_6627a24ea20be5f5(discoverables) {
  discoverables = sortbydistance(discoverables, (0, 0, 0));
  var_8fd4f4614f12573 = level.var_1b908bf18691b097.discoverables.size;

  for(i = 0; i < discoverables.size; i++) {
    if(i > var_8fd4f4614f12573) {
      break;
    }

    discoverables[i].var_3d33ce746b270d75.id = i;
    discoverables[i].var_3d33ce746b270d75.is_objective = 0;
    discoverables[i] function_e1eea6c52f38e3d5();
    discoverables[i] thread function_491f24d966ee89e3();
    level.var_8b30d8e5d8aecf1.var_c22af36562dc6076++;

    if(istrue(discoverables[i].var_3d33ce746b270d75.var_daec7d5cd85f55aa)) {
      discoverables[i] function_4d683611cc7d88fc();
    }
  }

  return discoverables;
}

function function_491f24d966ee89e3() {
  self endon("death");
  self endon("disconnect");
  self endon("object_discovered");
  is_crate = 0;

  if(function_80df9ee9e6c0b982()) {
    is_crate = 1;
  }

  while(true) {
    if(function_2a2a8e6796cccfc4() || !isDefined(self.origin)) {
      return;
    }

    if(level.players[0] namespace_e875ad14b292bd61::binoculars_isads()) {
      level.players[0] waittill("binoculars_ads_off");
    }

    var_def88a7e3787ba2c = 0;
    var_c7cfde456d34aeff = 0;

    if(isDefined(self.origin)) {
      if(function_bd47fa2849af5d47()) {
        var_12cbfe2100735319 = distance2dsquared(level.players[0].origin, self.origin);
      } else {
        var_12cbfe2100735319 = distancesquared(level.players[0].origin, self.origin);
      }

      var_def88a7e3787ba2c = var_12cbfe2100735319 <= 160000;

      if(istrue(is_crate)) {
        var_c7cfde456d34aeff = var_12cbfe2100735319 <= 90000;
      }
    }

    if(istrue(var_def88a7e3787ba2c)) {
      if(function_b12843c9d4bcfc89()) {
        function_4d683611cc7d88fc();
        return;
      } else if(istrue(is_crate) && istrue(var_c7cfde456d34aeff)) {
        function_4d683611cc7d88fc();
        return;
      }
    }

    if(isDefined(var_12cbfe2100735319)) {
      var_dfd27826183345dc = scripts\engine\math::normalize_value(0, 9000000, var_12cbfe2100735319);
      var_8c63757398b7b574 = easepower(var_dfd27826183345dc, 3, 1) * 5;
    }

    var_a2d5336409f147fe = default_to(var_8c63757398b7b574, 0.2);

    if(is_crate) {
      var_a2d5336409f147fe = clamp(var_a2d5336409f147fe, 0.2, 0.5);
    } else {
      var_a2d5336409f147fe = clamp(var_a2d5336409f147fe, 0.2, 5);
    }

    if(getdvarint(@ "hash_f96cf0eb7c0d0f90") == 1) {
      var_44b853c1749f963 = scripts\engine\math::normalize_value(0, 1, var_12cbfe2100735319);
      thread scripts\common\debug::debug_print3d(self, var_a2d5336409f147fe, (var_44b853c1749f963, 0, abs(1 - var_44b853c1749f963)), var_a2d5336409f147fe, "<dev string:x1c>", "<dev string:x2e>", undefined, undefined, 40);
    }

    level scripts\engine\utility::waittill_notify_or_timeout("binoculars_ads_on", var_a2d5336409f147fe);
  }
}

function function_dc3a836fb5697aa8() {
  foreach(item in level.var_8b30d8e5d8aecf1.valid_entities) {
    if(!isDefined(item.var_3d33ce746b270d75)) {
      continue;
    }

    if(isDefined(level.var_1b908bf18691b097) && isDefined(item.var_3d33ce746b270d75.id)) {
      itemfound = level.var_1b908bf18691b097.discoverables[item.var_3d33ce746b270d75.id];

      if(istrue(itemfound) && !isDefined(item.var_3d33ce746b270d75.headicon)) {
        item notify("object_discovered");
        item function_7284fd619bba77c9(item.var_3d33ce746b270d75.var_14505fba23f1ed63);
      }
    }
  }
}

function function_7284fd619bba77c9(icon, icon_size) {
  self endon("death");
  self endon("disconnect");
  icon = default_to(self.var_3d33ce746b270d75.var_14505fba23f1ed63);
  icon_size = default_to(icon_size, isDefined(self.var_3d33ce746b270d75.icon_size) ? self.var_3d33ce746b270d75.icon_size : "icon_small");

  if(isDefined(self.var_3d33ce746b270d75.headicon)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.var_3d33ce746b270d75.headicon);
  }

  if(isDefined(self.var_3d33ce746b270d75.var_3d2eff7fd9e84a72)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.var_3d33ce746b270d75.var_3d2eff7fd9e84a72);
  }

  if(function_4f4e8e89908ada73()) {
    icon = self.var_3d33ce746b270d75.var_9616b8b44dd3cc22;
    self.var_3d33ce746b270d75.var_9616b8b44dd3cc22 = undefined;
  }

  function_c23f03606d30fc1f(icon, icon_size, 1, 1);
  function_c23f03606d30fc1f(icon, "icon_small", 0, 6000);

  if(!istrue(level.players[0] namespace_e875ad14b292bd61::binoculars_isads())) {
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.var_3d33ce746b270d75.var_3d2eff7fd9e84a72, level.players[0]);
  }

  if(getdvarint(@ "hash_7dcc2628da4d8ee9", 0)) {
    thread function_b328c49dd5143c78(self.var_3d33ce746b270d75.headicon);

    if(isDefined(self.var_3d33ce746b270d75.var_bd7c116a578294be)) {
      thread function_b328c49dd5143c78(self.var_3d33ce746b270d75.var_bd7c116a578294be);
    }
  }

  thread remove_item_minimap_on_death();
}

function remove_item_minimap_on_death() {
  self endon("death");
  self endon("disconnect");
  self notify("remove_item_minimap_on_death");
  self endon("remove_item_minimap_on_death");
  player = level.players[0];
  waittill_any_6("death", "offhand_box_kill", "entitydeleted", "self_hidden", "loadout_crate_opened", "blueprint_crate_opened");

  if(isDefined(self.var_3d33ce746b270d75.headicon)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.var_3d33ce746b270d75.headicon);
    self notify("discovery_icon_removed");
  }

  if(isDefined(self.var_3d33ce746b270d75.var_3d2eff7fd9e84a72)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.var_3d33ce746b270d75.var_3d2eff7fd9e84a72);
  }

  if(isDefined(self.var_3d33ce746b270d75.var_9616b8b44dd3cc22)) {
    function_c23f03606d30fc1f(self.var_3d33ce746b270d75.var_9616b8b44dd3cc22, "icon_small", 1, 1);
    function_c23f03606d30fc1f(self.var_3d33ce746b270d75.var_9616b8b44dd3cc22, "icon_small", 0);
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.var_3d33ce746b270d75.var_3d2eff7fd9e84a72, level.players[0]);
    self.var_3d33ce746b270d75.var_9616b8b44dd3cc22 = undefined;
    thread remove_item_minimap_on_death();
    return;
  }

  self notify("object_removed");
  function_8e08c96cf39f7dd1(self, 1);
}

function function_b328c49dd5143c78(headicon) {
  self endon("disconnect");
  self endon("death");

  if(function_bd27c13c6b8f16fd(self) && !istrue(self.var_3d33ce746b270d75.var_daec7d5cd85f55aa) && function_a2a780464918dc3a() && getdvarint(@ "hash_b7d46b36430341a5", 0)) {
    if(function_bd27c13c6b8f16fd(self) && isDefined(self.origin) && level.players[0] function_80f8ad4df1927d77(self.origin)) {
      return;
    }

    if(isDefined(self)) {
      scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(headicon, level.players[0]);
    }

    while(isDefined(self) && isDefined(self.origin) && !level.players[0] function_80f8ad4df1927d77(self.origin)) {
      wait 0.25;
    }

    if(isDefined(self)) {
      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(headicon, level.players[0]);
    }
  }
}

function function_b12843c9d4bcfc89() {
  self endon("disconnect");
  self endon("death");

  if(!isDefined(self.origin)) {
    return false;
  }

  player = level.players[0];
  origin = self.origin + (0, 0, 15);

  if(function_bd47fa2849af5d47() || within_fov(player getEye(), player getplayerangles(), origin, cos(65))) {
    if(function_bd47fa2849af5d47()) {
      tracepoints = function_2d378799a63801a0();
    } else {
      midpoint = function_7f5f53871d3db00c();
      tracepoints = [origin, midpoint];
    }

    foreach(tracepoint in tracepoints) {
      ignoreent = undefined;

      if(isent(self)) {
        ignoreent = self;
      }

      if(!isDefined(level.var_8b30d8e5d8aecf1.item_contents)) {
        level.var_8b30d8e5d8aecf1.item_contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1);
      }

      raycast = physics_raycast(player getvieworigin(), tracepoint, level.var_8b30d8e5d8aecf1.item_contents, undefined, 0, "physicsquery_closest", 1, 1);

      if(isDefined(raycast) && getdvarint(@ "hash_f96cf0eb7c0d0f90") == 1) {
        debug_results = scripts\engine\trace::internal_create_debug_data(raycast, "<dev string:x40>", player getEye(), tracepoint);
        thread scripts\engine\trace::draw_trace(debug_results, (1, 1, 1), 1, 5);
      }

      if(isDefined(raycast) && raycast.size == 0 || isDefined(raycast[0]["entity"]) && raycast[0]["entity"] == self || isDefined(raycast[0]["scriptable"]) && raycast[0]["scriptable"] == self) {
        return true;
      }
    }
  }

  return false;
}

function private function_2d378799a63801a0() {
  if(!isDefined(self) || !isDefined(self.origin)) {
    return [];
  }

  if(!isDefined(self.var_3d33ce746b270d75.var_c771dc8336087985) && !isDefined(self.var_3d33ce746b270d75.var_d080815319e36ef7)) {
    playerpos = level.player getEye();
    var_9592ae45bccbfdda = playerpos[2] < self.origin[2] ? -1 : 1;
    var_6c724eb921dce489 = self.origin + anglestoup(self.angles) * var_9592ae45bccbfdda * 1500;
    level.var_8b30d8e5d8aecf1.var_802acf4d8e1c8f13 = default_to(level.var_8b30d8e5d8aecf1.var_802acf4d8e1c8f13, physics_createcontents(["physicscontents_item", "physicscontents_itemclip"]));
    trace = physics_raycast(self.origin, var_6c724eb921dce489, level.var_8b30d8e5d8aecf1.var_802acf4d8e1c8f13, undefined, 0, "physicsquery_closest");
    var_589d265f68c47c19 = isDefined(trace) && trace.size > 0 && isDefined(trace[0]["position"]) ? trace[0]["position"] : var_6c724eb921dce489;

    if(self.origin[2] >= var_589d265f68c47c19[2]) {
      toppoint = self.origin;
      var_489201cbf1f57770 = var_589d265f68c47c19;
    } else {
      toppoint = var_589d265f68c47c19;
      var_489201cbf1f57770 = self.origin;
    }

    self.var_3d33ce746b270d75.var_c771dc8336087985 = toppoint;
    self.var_3d33ce746b270d75.var_d080815319e36ef7 = var_489201cbf1f57770;
  }

  var_72f982b659117546 = pointonsegmentnearesttopoint(self.var_3d33ce746b270d75.var_d080815319e36ef7, self.var_3d33ce746b270d75.var_c771dc8336087985, level.player getEye());
  return [var_72f982b659117546];
}

function function_143a84e50b38dded() {
  switch (self.var_3d33ce746b270d75.discovery_name) {
    case #"hash_25029ada347b7ee7":
    case #"hash_82efa6b3c705aba0":
    case #"hash_fcbdb6d4a74ca932":
      if(isDefined(self.var_7b4b93daa27c204e)) {
        return true;
      }

      break;
    default:
      return true;
  }

  return false;
}

function function_6021e91c9efbc35c() {
  if(!function_bd27c13c6b8f16fd(self) || !function_dd9b6d0db1c55513()) {
    return;
  }

  level.var_8b30d8e5d8aecf1.var_ee6a16a8432a3f45[level.var_8b30d8e5d8aecf1.var_7d2a44df69cf87b5] = self;
  self.var_3d33ce746b270d75.var_7230693117949738 = level.var_8b30d8e5d8aecf1.var_de2c4be6028d536c[level.var_8b30d8e5d8aecf1.var_7d2a44df69cf87b5];
  self.var_3d33ce746b270d75.var_7230693117949738 show();
  level.var_8b30d8e5d8aecf1.var_7d2a44df69cf87b5++;

  if(isDefined(self.var_3d33ce746b270d75.var_7230693117949738)) {
    self.var_3d33ce746b270d75.var_7230693117949738.origin = function_7f5f53871d3db00c();
  }
}

function function_a1a4c60871710624() {
  if(!isDefined(level.var_8b30d8e5d8aecf1.var_ee6a16a8432a3f45) || level.var_8b30d8e5d8aecf1.var_ee6a16a8432a3f45.size == 0) {
    return;
  }

  level.var_8b30d8e5d8aecf1.var_7d2a44df69cf87b5 = 0;

  foreach(object in level.var_8b30d8e5d8aecf1.var_ee6a16a8432a3f45) {
    if(isDefined(object)) {
      object.var_3d33ce746b270d75.var_7230693117949738 = undefined;
    }
  }

  foreach(dummyent in level.var_8b30d8e5d8aecf1.var_de2c4be6028d536c) {
    if(dummyent.origin != (0, 0, -4000)) {
      dummyent.origin = (0, 0, -4000);
      dummyent hide();
    }
  }

  level.var_8b30d8e5d8aecf1.var_ee6a16a8432a3f45 = [];
}

function function_4d683611cc7d88fc() {
  assert(function_bd27c13c6b8f16fd(self) || isDefined(level.var_1b908bf18691b097));

  if(!function_2a2a8e6796cccfc4()) {
    namespace_1170726b2799ea65::function_cc8a338bb3b0a9fe(self.var_3d33ce746b270d75.id, 1);
    level.var_8b30d8e5d8aecf1.var_5f450c113ba90011++;
    self.var_3d33ce746b270d75.var_b97aaea781f69cd8 = 1;
  }

  function_7284fd619bba77c9();
  self notify("object_discovered");
}

function function_bd27c13c6b8f16fd(object) {
  if(isDefined(object) && isDefined(object.var_3d33ce746b270d75) && isDefined(object.var_3d33ce746b270d75.id)) {
    return true;
  }

  return false;
}

function function_bd47fa2849af5d47() {
  return function_bd27c13c6b8f16fd(self) && istrue(self.var_3d33ce746b270d75.discovery_name == "military_ascendertop_heavy");
}

function function_80df9ee9e6c0b982() {
  if(isDefined(self.var_3d33ce746b270d75) && isDefined(self.var_3d33ce746b270d75.discovery_name) && (self.var_3d33ce746b270d75.discovery_name == "cp_blueprint_crate_dungeons" || self.var_3d33ce746b270d75.discovery_name == "cp_loadout_crate_dungeons") || self.var_3d33ce746b270d75.discovery_name == "cp_jup_itembox" || self.var_3d33ce746b270d75.discovery_name == "cp_loot_box" || self.var_3d33ce746b270d75.discovery_name == "cp_blueprint_crate_dungeons_large" || self.var_3d33ce746b270d75.discovery_name == "cp_blueprint_crate_dungeons_pistol" || self.var_3d33ce746b270d75.discovery_name == "cp_blueprint_crate_dungeons_xlarge") {
    return true;
  }

  return false;
}

function function_923fd9757eaef5b1() {
  return istrue(isDefined(self.type) && isDefined(self.itemname) && (issubstr(self.itemname, "jup") || issubstr(self.itemname, "iw9")));
}

function function_2a2a8e6796cccfc4(object) {
  object = isDefined(object) ? object : self;
  itemfound = 0;

  if(isDefined(object) && isDefined(object.var_3d33ce746b270d75) && isDefined(object.var_3d33ce746b270d75.id)) {
    itemfound = level.var_1b908bf18691b097.discoverables[object.var_3d33ce746b270d75.id];
  }

  return istrue(itemfound);
}

function function_5808c2d6dc5cca9d() {
  if(isDefined(level.var_8b30d8e5d8aecf1.var_cbefd54560ae748b)) {
    return (level.var_8b30d8e5d8aecf1.var_5f450c113ba90011 > 0);
  }

  return false;
}

function function_64b3e41c19cd6764() {
  discoverables = ["brloot_armor_plate", "armor_restock", "scriptable_cp_loot_box", "brloot_self_revive", "military_ascendertop_heavy", "ammo", "cp_offhand_box", "cp_offhand_bag", "scriptable_cp_blueprint_crate_dungeons", "scriptable_cp_loadout_crate_dungeons", "scriptable_cp_loadout_pile", "cp_blueprint_crate_dungeons", "cp_loadout_pile", "cp_blueprint_crate_dungeons_large", "cp_loadout_crate_dungeons", "cp_blueprint_crate_dungeons_pistol", "cp_blueprint_crate_dungeons_xlarge"];
  var_95ffb72b90666365 = ["_depth01", "_depth03", "_depth06", "_depth07", "_depth10", "_depth15", "_depth30"];
  discoverables = function_5b51bbf166f9c51(discoverables, "blueprint", var_95ffb72b90666365);

  foreach(index in level.br_pickups.br_itemtype) {
    if(index == #"killstreak" || index == #"munition") {
      discoverables = function_6d6af8144a5131f1(discoverables, item);
    }
  }

  return discoverables;
}

function private function_5b51bbf166f9c51(discoverables, substring, var_60b3d09fc85e7561) {
  if(!isDefined(discoverables) || !isarray(discoverables)) {
    return;
  }

  if(!isDefined(substring) || !isDefined(var_60b3d09fc85e7561)) {
    return discoverables;
  }

  var_de0daf226633b78e = discoverables.size;

  for(i = 0; i <= var_de0daf226633b78e; i++) {
    if(issubstr(discoverables[i], substring)) {
      foreach(appendstring in var_60b3d09fc85e7561) {
        discoverables[discoverables.size] = discoverables[i] + appendstring;
      }
    }
  }

  return discoverables;
}

function function_b89b55d24d45aa95() {
  var_8fd4f4614f12573 = level.var_1b908bf18691b097.discoverables.size;
  var_b5814604a94778d3 = level.var_8b30d8e5d8aecf1.var_c22af36562dc6076;
  level.var_8b30d8e5d8aecf1.var_c22af36562dc6076++;

  if(level.var_8b30d8e5d8aecf1.var_c22af36562dc6076 > var_8fd4f4614f12573) {
    level.var_8b30d8e5d8aecf1.var_c22af36562dc6076 = var_8fd4f4614f12573 - 1;
    assertmsg("Max DLL Cap Exceeded");
  }

  return var_b5814604a94778d3;
}

function function_75d09d086b745c89() {
  return 0.25;
}

function function_c23f03606d30fc1f(icon, icon_size, var_22ff68f3b2e83af1, var_c5409ca7522182b3, overrideorigin) {
  head_icon = undefined;
  self.var_3d33ce746b270d75.var_14505fba23f1ed63 = icon;
  icon_size = default_to(icon_size, "icon_small");
  var_22ff68f3b2e83af1 = default_to(var_22ff68f3b2e83af1, 0);
  var_c5409ca7522182b3 = default_to(var_c5409ca7522182b3, 0);
  useorigin = isent(self) ? undefined : self.origin;
  self.var_3d33ce746b270d75.var_7631c19595d20350 = isDefined(overrideorigin) ? overrideorigin : isDefined(self.var_3d33ce746b270d75.var_7631c19595d20350) ? self.var_3d33ce746b270d75.var_7631c19595d20350 : self.origin;
  overrideorigin = default_to(overrideorigin, useorigin);

  if(var_22ff68f3b2e83af1) {
    self.var_3d33ce746b270d75.headicon = scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players[0], icon, 0, 0, var_c5409ca7522182b3, 1, 0, 1, 0, overrideorigin, 1, icon_size);

    if(isDefined(level.var_aba7e24cef7c6d5)) {
      self thread[[level.var_aba7e24cef7c6d5]]();
    }

    function_8e08c96cf39f7dd1(self);
    head_icon = self.var_3d33ce746b270d75.headicon;
    self notify("discovery_icon_moved");
  } else {
    var_728a86501ed6ca69 = distance(self.origin, function_7f5f53871d3db00c());
    zoffset = var_728a86501ed6ca69 * 2 + 5;

    if(icon == function_914b829c1006fba6()) {
      head_icon = scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players[0], icon, zoffset, 1, var_c5409ca7522182b3, 500, 0, 1, 1, overrideorigin, 0, icon_size);
      self.var_3d33ce746b270d75.var_3d2eff7fd9e84a72 = head_icon;
      function_a0889a73efaeafd3(head_icon, 0);
    } else {
      if(isDefined(self.var_3d33ce746b270d75.var_f4b5b02fe89b66a1) && function_4f4e8e89908ada73()) {
        icon = self.var_3d33ce746b270d75.var_f4b5b02fe89b66a1;
      }

      head_icon = scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players[0], icon, zoffset, 1, var_c5409ca7522182b3, 500, 0, 1, 0, overrideorigin, 0, icon_size);
      self.var_3d33ce746b270d75.var_3d2eff7fd9e84a72 = head_icon;
      function_a0889a73efaeafd3(head_icon, 1);
    }

    if(isDefined(head_icon)) {
      function_272322fc1191dc50(head_icon, 0);
    }
  }

  if(isDefined(head_icon)) {
    if(isDefined(self.var_3d33ce746b270d75.var_1e4273b240a1f24d)) {
      function_ce9d0299637c2c24(head_icon, 1);
      function_e7d3a3c369b81c2d(head_icon, int(self.var_3d33ce746b270d75.var_1e4273b240a1f24d[0]), int(self.var_3d33ce746b270d75.var_1e4273b240a1f24d[1]), int(self.var_3d33ce746b270d75.var_1e4273b240a1f24d[2]));
      return;
    }

    function_ce9d0299637c2c24(head_icon, 0);
  }
}

function function_893e7f94e741a414(point, var_8b1b1a279b4efd62) {
  if(!isDefined(point)) {
    return [];
  }

  var_8b1b1a279b4efd62 = default_to(var_8b1b1a279b4efd62, 10000);
  var_e06cfe2a04c4821 = [];

  foreach(item in level.var_8b30d8e5d8aecf1.valid_entities) {
    if(isDefined(item)) {
      var_d08735289fbe387b = item.var_3d33ce746b270d75.var_7631c19595d20350;

      if(isDefined(var_d08735289fbe387b)) {
        distancetoitem = distance2dsquared(var_d08735289fbe387b, point);

        if(distancetoitem <= var_8b1b1a279b4efd62) {
          item.var_3d33ce746b270d75.var_36d4d849041842b4 = distancetoitem;
          var_e06cfe2a04c4821[var_e06cfe2a04c4821.size] = item;
        }
      }
    }
  }

  return var_e06cfe2a04c4821;
}

function function_8e08c96cf39f7dd1(currentitem, removeitem, offset) {
  removeitem = default_to(removeitem, 0);
  offset = default_to(offset, 120);
  var_49765eb4a4dce0e7 = isDefined(currentitem.origin) ? currentitem.origin : isDefined(currentitem.var_3d33ce746b270d75.var_a3ec75fc57b65f60) ? currentitem.var_3d33ce746b270d75.var_a3ec75fc57b65f60 : isDefined(currentitem.var_3d33ce746b270d75.var_7631c19595d20350) ? currentitem.var_3d33ce746b270d75.var_7631c19595d20350 : (0, 0, 0);
  var_84f2271d381844b0 = function_893e7f94e741a414(var_49765eb4a4dce0e7);

  if(var_84f2271d381844b0.size == 0) {
    return;
  }

  var_4034fbdd04ead03e = [];

  foreach(var_c549f19328c9bbb8 in var_84f2271d381844b0) {
    if(!currentitem function_80df9ee9e6c0b982() && !currentitem function_b2151c343030d1f0() && var_c549f19328c9bbb8.var_3d33ce746b270d75.var_14505fba23f1ed63 == currentitem.var_3d33ce746b270d75.var_14505fba23f1ed63) {
      var_4034fbdd04ead03e[var_4034fbdd04ead03e.size] = var_c549f19328c9bbb8;
    }
  }

  if(var_4034fbdd04ead03e.size > 1 || removeitem && var_4034fbdd04ead03e.size >= 1) {
    positions = [];

    foreach(item in var_4034fbdd04ead03e) {
      if(removeitem && item == currentitem || item function_52dcb2ef5c1618ba()) {
        continue;
      }

      positions[positions.size] = default_to(item.var_3d33ce746b270d75.var_a3ec75fc57b65f60, item.var_3d33ce746b270d75.var_7631c19595d20350);
    }

    if(positions.size == 0) {
      return;
    }

    averageposition = averagepoint(positions);

    foreach(item in var_4034fbdd04ead03e) {
      scripts\cp_mp\entityheadicons::setheadicon_deleteicon(item.var_3d33ce746b270d75.headicon);
      item.var_3d33ce746b270d75.var_a3ec75fc57b65f60 = default_to(item.var_3d33ce746b270d75.var_a3ec75fc57b65f60, item.var_3d33ce746b270d75.var_7631c19595d20350);
      item.var_3d33ce746b270d75.var_7631c19595d20350 = undefined;
      item notify("discovery_icon_removed");
    }

    iconowner = removeitem ? var_4034fbdd04ead03e[0] : currentitem;
    icon_size = isDefined(iconowner.var_3d33ce746b270d75.icon_size) ? iconowner.var_3d33ce746b270d75.icon_size : "icon_small";
    iconowner.var_3d33ce746b270d75.headicon = iconowner scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players[0], iconowner.var_3d33ce746b270d75.var_14505fba23f1ed63, 0, 0, 1, 1, 0, 1, 0, averageposition, 1, icon_size);
    iconowner notify("discovery_icon_moved");

    if(var_4034fbdd04ead03e.size > 1) {
      foreach(item in var_4034fbdd04ead03e) {
        item.var_3d33ce746b270d75.headicon = iconowner.var_3d33ce746b270d75.headicon;
      }
    }
  }

  numloops = istrue(removeitem) ? 1 : 2;

  while(numloops > 0) {
    foreach(var_c549f19328c9bbb8 in var_84f2271d381844b0) {
      if(var_c549f19328c9bbb8 == currentitem) {
        continue;
      }

      if(isDefined(var_c549f19328c9bbb8.var_3d33ce746b270d75.var_7631c19595d20350)) {
        var_2934858324fac3bd = var_c549f19328c9bbb8.var_3d33ce746b270d75.var_7631c19595d20350;
        direction = vectornormalize2(var_49765eb4a4dce0e7 - var_2934858324fac3bd);

        if(removeitem) {
          direction *= -1;
        }

        if(isDefined(var_c549f19328c9bbb8.var_3d33ce746b270d75.var_36d4d849041842b4)) {
          var_2881d987a44375e0 = 10000 - var_c549f19328c9bbb8.var_3d33ce746b270d75.var_36d4d849041842b4;
          offset = scripts\engine\math::remap(var_2881d987a44375e0, 0, 10000, offset / 4, offset);
          var_c549f19328c9bbb8.var_3d33ce746b270d75.var_36d4d849041842b4 = undefined;
        } else {
          offset /= 2;
        }

        var_49765eb4a4dce0e7 = offset_icon(var_49765eb4a4dce0e7, direction, offset);
        var_2934858324fac3bd = offset_icon(var_2934858324fac3bd, direction * -1, offset);

        if(!removeitem) {
          function_56b6132482769a2a(currentitem, var_49765eb4a4dce0e7);
        }

        function_56b6132482769a2a(var_c549f19328c9bbb8, var_2934858324fac3bd);
      }

      if(numloops - 1 > 0) {
        var_84f2271d381844b0 = function_893e7f94e741a414(currentitem.var_3d33ce746b270d75.var_7631c19595d20350);
      }
    }

    numloops -= 1;
  }
}

function private function_56b6132482769a2a(item, newpos) {
  icon_size = isDefined(item.var_3d33ce746b270d75.icon_size) ? item.var_3d33ce746b270d75.icon_size : "icon_small";
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(item.var_3d33ce746b270d75.headicon);
  item.var_3d33ce746b270d75.headicon = item scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players[0], item.var_3d33ce746b270d75.var_14505fba23f1ed63, 0, 0, 1, 1, 0, 1, 0, newpos, 1, icon_size);
  item.var_3d33ce746b270d75.var_7631c19595d20350 = newpos;
  item notify("discovery_icon_moved");
}

function private offset_icon(pos, direction, offset) {
  return pos + (direction[0] * offset / 2, direction[1] * offset / 2, 0);
}

function private function_52dcb2ef5c1618ba() {
  return istrue(isDefined(self.item_models) && self.item_models.size == 0);
}

function private function_e1eea6c52f38e3d5() {
  if(isDefined(self.var_3d33ce746b270d75)) {
    switch (self.var_3d33ce746b270d75.discovery_name) {
      case #"hash_55798564991651ac":
      case #"hash_7b000c17064a1f80":
      case #"hash_c7bbd8ecefd5180a":
        self.var_3d33ce746b270d75.var_14505fba23f1ed63 = "jup_hud_icon_minimap_armor";
        break;
      case #"hash_5b1cf11e5c07a9dc":
      case #"hash_5b48ec1e5c2a343f":
        function_a05b110ec01c0776();
        break;
      case #"hash_e1bb4a1f55b50d4":
      case #"hash_1c91a53a2491ebf6":
      case #"hash_2b44f760955c36e2":
      case #"hash_309de04f99910b78":
      case #"hash_39d74aea83d127ab":
      case #"hash_7437bcb5826a51dd":
        self.var_3d33ce746b270d75.var_14505fba23f1ed63 = "hud_icon_minimap_misc_squad_loot_box_padded";
        self.var_3d33ce746b270d75.var_9616b8b44dd3cc22 = default_to(function_1aa5b9363615d0d9(), "jup_hud_icon_minimap_item_case");
        self.var_3d33ce746b270d75.var_a937ef7b50355341 = 1;
        break;
      case #"hash_f87cab272555f116":
        self.var_3d33ce746b270d75.var_14505fba23f1ed63 = "hud_icon_fieldupgrade_loadout_drop";
        self.var_3d33ce746b270d75.var_a937ef7b50355341 = 1;
        self.var_3d33ce746b270d75.var_daec7d5cd85f55aa = 1;
        break;
      case #"hash_a500f53d3e52d6e":
        self.var_3d33ce746b270d75.var_14505fba23f1ed63 = "jup_hud_icon_minimap_self_revive";
        break;
      case #"hash_812de5bc468be78e":
      case #"hash_a10998ccf30198f8":
      case #"hash_c3048091a4b0babd":
      case #"hash_da6eb3835ed26295":
        self.var_3d33ce746b270d75.var_14505fba23f1ed63 = "jup_hud_icon_minimap_shortcut";
        self.var_3d33ce746b270d75.var_a937ef7b50355341 = 1;
        break;
    }

    if(!isDefined(self.var_3d33ce746b270d75.var_14505fba23f1ed63)) {
      self.var_3d33ce746b270d75.var_14505fba23f1ed63 = function_1aa5b9363615d0d9();

      if(!isDefined(self.var_3d33ce746b270d75.var_14505fba23f1ed63) || istrue(self.var_3d33ce746b270d75.var_833e18c57460a7c8)) {
        pickupitem = level.br_pickups.var_a5e4b146866d7fd[self.var_3d33ce746b270d75.discovery_name];

        if(isDefined(pickupitem)) {
          tableinfo = scripts\cp\pickups::getequipmenttableinfo(pickupitem);
          icon = scripts\cp\pickups::function_f28d303ba069eb4b(self.var_3d33ce746b270d75.discovery_name);

          if(istrue(self.var_3d33ce746b270d75.var_833e18c57460a7c8)) {
            self.var_3d33ce746b270d75.var_f4b5b02fe89b66a1 = icon;
            return;
          }

          self.var_3d33ce746b270d75.var_14505fba23f1ed63 = icon;
        }
      }
    }
  }
}

function function_36ae09d5a0fa1653() {
  self endon("death");
  self endon("disconnect");
  self notify("watching_border_draw");
  self endon("watching_border_ddadadraw");

  while(true) {
    results = waittill_any_return_2("discovery_icon_moved", "discovery_icon_removed");

    if(!isDefined(results) || !isDefined(self.var_3d33ce746b270d75.var_f4b5b02fe89b66a1)) {
      return;
    }

    switch (results) {
      case #"hash_39e4201c0ff1cf27":
        if(function_bd27c13c6b8f16fd(self) && isDefined(self.var_3d33ce746b270d75.var_f4b5b02fe89b66a1)) {
          if(isDefined(self.var_3d33ce746b270d75.var_bd7c116a578294be)) {
            scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.var_3d33ce746b270d75.var_bd7c116a578294be);
          }

          var_49765eb4a4dce0e7 = isDefined(self.origin) ? self.origin : isDefined(self.var_3d33ce746b270d75.var_a3ec75fc57b65f60) ? self.var_3d33ce746b270d75.var_a3ec75fc57b65f60 : isDefined(self.var_3d33ce746b270d75.var_7631c19595d20350) ? self.var_3d33ce746b270d75.var_7631c19595d20350 : (0, 0, 0);
          self.var_3d33ce746b270d75.var_bd7c116a578294be = scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players[0], self.var_3d33ce746b270d75.var_f4b5b02fe89b66a1, 0, 0, 1, 1, 0, 1, 0, var_49765eb4a4dce0e7, 1, "icon_small");
        }

        break;
      case #"hash_57de0c59ce696fc8":
        if(isDefined(self.var_3d33ce746b270d75.var_bd7c116a578294be)) {
          scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.var_3d33ce746b270d75.var_bd7c116a578294be);
        }

        break;
    }
  }
}

function private function_4f4e8e89908ada73() {
  if(!isDefined(self.var_3d33ce746b270d75.var_9616b8b44dd3cc22)) {
    return false;
  }

  if(function_80df9ee9e6c0b982() && isDefined(self.itemname) && isDefined(level.var_1b908bf18691b097.var_884e10986cbfccc7) && isDefined(level.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist)) {
    var_f47dfca98f97731d = 0;

    for(i = 0; i < level.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist.size; i++) {
      if(self.itemname == level.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist[i].weaponid || self.itemname == level.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist[i].weaponblueprint || self.itemname == level.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist[i].super || self.itemname == level.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist[i].equipment) {
        var_f47dfca98f97731d = level.player namespace_1170726b2799ea65::function_fef34e1a36b57bf6(level.mapname, i);
        break;
      }
    }

    return istrue(var_f47dfca98f97731d);
  }

  return false;
}

function private function_1aa5b9363615d0d9() {
  if(!function_bd27c13c6b8f16fd(self)) {
    return undefined;
  }

  itemname = isDefined(self.script_noteworthy) ? self.script_noteworthy : isDefined(self.itemname) ? self.itemname : self.type;

  if(isDefined(itemname)) {
    if(function_b2151c343030d1f0(itemname)) {
      self.var_3d33ce746b270d75.var_833e18c57460a7c8 = 1;
      thread function_36ae09d5a0fa1653();
      return "jup_cp_hud_icon_minimap_killstreak";
    }

    if(issubstr(itemname, "super")) {
      return "jup_cp_hud_icon_minimap_fieldupgrade_padded";
    }

    if(function_923fd9757eaef5b1()) {
      return "jup_cp_hud_icon_minimap_weapon_padded";
    }
  }
}

function private function_b2151c343030d1f0(itemname) {
  if(!isDefined(itemname)) {
    itemname = isDefined(self.script_noteworthy) ? self.script_noteworthy : isDefined(self.itemname) ? self.itemname : self.type;
  }

  if(isDefined(itemname) && issubstr(itemname, "brloot_munition")) {
    return true;
  }

  return false;
}

function private function_82bbe34c01540309(icon, icon_size) {
  icon_size = isDefined(icon_size) ? icon_size : "icon_small";

  if(isDefined(self.var_3d33ce746b270d75)) {
    function_c23f03606d30fc1f(icon, icon_size, 0, 6000);
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.var_3d33ce746b270d75.var_3d2eff7fd9e84a72, level.players[0]);
  }
}

function private function_a05b110ec01c0776() {
  if(isDefined(self.item_type)) {
    switch (self.item_type) {
      case #"hash_ee5a421e18a58c0f":
        self.var_3d33ce746b270d75.var_14505fba23f1ed63 = "ui_map_icon_ammo_cache";
        break;
      case #"hash_5d11ac1131cddab1":
        self.var_3d33ce746b270d75.var_14505fba23f1ed63 = "hud_icon_equipment_semtex";
        break;
      case #"hash_a68c414683465b09":
        self.var_3d33ce746b270d75.var_14505fba23f1ed63 = "hud_icon_loot_flash";
        break;
      case #"hash_a8e4a914fb03a4d5":
        self.var_3d33ce746b270d75.var_14505fba23f1ed63 = "hud_icon_equipment_frag";
        break;
      case #"hash_fa1e80f6bd5b8e72":
        self.var_3d33ce746b270d75.var_14505fba23f1ed63 = "hud_icon_equipment_c4";
        break;
      case #"hash_7b000c17064a1f80":
        self.var_3d33ce746b270d75.var_14505fba23f1ed63 = "jup_hud_icon_minimap_armor";
        break;
    }
  }
}

function private function_2637c3558c8c74f2() {
  var_643da509e62816cc = namespace_1170726b2799ea65::function_e1e2c6c4a3a0ebad();

  for(i = 0; i < var_643da509e62816cc; i++) {
    namespace_1170726b2799ea65::function_cc8a338bb3b0a9fe(i, 0);
  }
}

function private function_a0f6a656b4ff38a2() {
  var_8106529d8e3a6ac4 = [];
  items_objectives = array_combine(level.var_8b30d8e5d8aecf1.valid_entities, level.var_8b30d8e5d8aecf1.objectivelocations);

  foreach(item_objective in items_objectives) {
    if((function_2a2a8e6796cccfc4(item_objective) || function_409b4b9bee1fbe1c(item_objective)) && isDefined(item_objective.var_3d33ce746b270d75.var_3d2eff7fd9e84a72)) {
      var_8106529d8e3a6ac4 = array_add(var_8106529d8e3a6ac4, item_objective);
    }
  }

  return var_8106529d8e3a6ac4;
}

function private function_3df24da797614c3() {
  var_b91f5456979c5ef5 = [];

  for(i = 0; i < 20; i++) {
    var_b91f5456979c5ef5[i] = spawn("script_model", (0, 0, -4000));
    var_b91f5456979c5ef5[i].var_b41f2d4772efac2d = 1;
    var_b91f5456979c5ef5[i] hide();
  }

  return var_b91f5456979c5ef5;
}

function private function_dd9b6d0db1c55513() {
  return istrue(isDefined(level.var_8b30d8e5d8aecf1.var_ee6a16a8432a3f45) && level.var_8b30d8e5d8aecf1.var_7d2a44df69cf87b5 < 20);
}

function function_f6168ffcce744398() {
  self endon("<dev string:x44>");
  self endon("<dev string:x4f>");

  while(true) {
    if(getdvarint(@ "hash_f96cf0eb7c0d0f90") == 1) {
      level childthread function_ceeed25326e10780();
    }

    wait 0.25;
  }
}

function function_ceeed25326e10780() {
  level notify("<dev string:x55>");
  level endon("<dev string:x55>");
  self endon("<dev string:x44>");
  self endon("<dev string:x4f>");

  while(!isDefined(level.players[0])) {
    waitframe();
  }

  searchradius = 0;

  foreach(elem in level.var_8b30d8e5d8aecf1.valid_entities) {
    if(isDefined(elem) && isDefined(elem.var_3d33ce746b270d75.id) && isDefined(level.var_1b908bf18691b097)) {
      itemfound = level.var_1b908bf18691b097.discoverables[elem.var_3d33ce746b270d75.id];

      if(istrue(itemfound)) {
        if(isDefined(elem.origin)) {
          var_12cbfe2100735319 = distancesquared(level.players[0].origin, elem.origin);
          var_def88a7e3787ba2c = var_12cbfe2100735319 <= 160000;
        }

        if(var_def88a7e3787ba2c) {
          if(elem function_b12843c9d4bcfc89()) {
            elem thread scripts\cp_mp\utility\debug_utility::drawsphere(elem.origin + (0, 0, 20), 5, 0.25, (0, 0, 1));
            elem namespace_c0269b8ac4e7a573::debug_circle(elem.origin, sqrt(10000), 0.25, (0, 0, 1));
          }
        } else {
          elem thread scripts\cp_mp\utility\debug_utility::drawsphere(elem.origin + (0, 0, 20), 5, 0.25, (0, 1, 0));
          elem namespace_c0269b8ac4e7a573::debug_circle(elem.origin, sqrt(10000), 0.25, (0, 1, 0));
        }

        continue;
      }

      elem thread scripts\cp_mp\utility\debug_utility::drawsphere(elem.origin + (0, 0, 20), 5, 0.25, (1, 0, 0));
      elem namespace_c0269b8ac4e7a573::debug_circle(elem.origin, sqrt(10000), 0.25, (1, 0, 0));
    }
  }

  foreach(objective in level.var_8b30d8e5d8aecf1.objectivelocations) {
    if(function_409b4b9bee1fbe1c(objective)) {
      if(!function_5175ee2a98016ca8(objective)) {
        searchradius = 500;

        if(isDefined(objective.var_3d33ce746b270d75.objective_radius)) {
          searchradius = objective.var_3d33ce746b270d75.objective_radius;
        }

        if(istrue(function_23425e6521e47280(objective))) {
          objective thread scripts\cp_mp\utility\debug_utility::drawsphere(objective.origin, searchradius, 0.25, (0, 1, 0));
        } else {
          objective thread scripts\cp_mp\utility\debug_utility::drawsphere(objective.origin, searchradius, 0.25, (0, 1, 1));
        }

        continue;
      }

      if(istrue(function_23425e6521e47280(objective))) {
        objective function_ab522b97af67094c((0, 1, 0));
        continue;
      }

      objective function_ab522b97af67094c((0, 1, 1));
    }
  }

  if(level.players[0] namespace_e875ad14b292bd61::binoculars_isads()) {
    viewpoint = level.players[0] namespace_e875ad14b292bd61::function_8a8136a64df0f01d();

    if(isDefined(viewpoint)) {
      scripts\cp\weapon::debug_circle(viewpoint, 5, 0.25, (0, 1, 0), 0, 1);
      var_56afec62d47e756b = level.players[0] namespace_e875ad14b292bd61::function_79d9dbea734fc001(viewpoint);

      foreach(offsetpoint in var_56afec62d47e756b) {
        offsetpoint = level.players[0] namespace_e875ad14b292bd61::function_b1ff3731b2ae4f66(offsetpoint);

        if(isDefined(offsetpoint)) {
          draw_line_for_time(level.players[0] getvieworigin(), offsetpoint, 1, 0.25, 0, 0.01);
          scripts\cp\weapon::debug_circle(offsetpoint, 5, 0.25, (0, 1, 0), 0, 1);
        }
      }

      draw_line_for_time(level.players[0] getvieworigin(), viewpoint, 1, 0.25, 0, 0.01);
    }

    return;
  }

  while(true) {
    scripts\stealth\debug::draw_arc(level.players[0] getEye() - (0, 0, 50), -65, 65, level.players[0].angles, sqrt(160000), 1, 15, (0, 0, 1));
    scripts\stealth\debug::draw_arc(level.players[0] getEye() - (0, 0, 50), -65, 65, level.players[0].angles, sqrt(9000000), 1, 15, (1, 0, 1));
    waitframe();
  }
}

function function_36c5aa6eecd737c3() {
  self endon("<dev string:x44>");
  self endon("<dev string:x4f>");
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x79>");
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x98>", "<dev string:x98>", &function_6736a37fd35d7ca6, 1);
  scripts\common\devgui::function_fe953f000498048f();
  level thread function_f6168ffcce744398();
}

function function_6736a37fd35d7ca6() {
  setdvarifuninitialized(@ "hash_f96cf0eb7c0d0f90", 0);

  if(getdvarint(@ "hash_f96cf0eb7c0d0f90") == 1) {
    setDvar(@ "hash_f96cf0eb7c0d0f90", 0);
    level notify("<dev string:x55>");
    return;
  }

  setDvar(@ "hash_f96cf0eb7c0d0f90", 1);
}

function private function_88b96430fdacbb80() {
  foreach(item in level.var_8b30d8e5d8aecf1.valid_entities) {
    if(!istrue(level.var_1b908bf18691b097.discoverables[item.var_3d33ce746b270d75.id])) {
      namespace_1170726b2799ea65::function_cc8a338bb3b0a9fe(item.var_3d33ce746b270d75.id, 1);
    }
  }
}

# /