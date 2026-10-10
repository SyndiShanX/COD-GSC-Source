/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_42f868a5dda17294.gsc
*************************************************/

#using script_3a8f9ace195c9da9;
#using script_46b342a079938c68;
#using script_6b80871eb8142180;
#using script_737f801e6beb18c7;
#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#namespace namespace_a8e999320b18af1d;

function function_2b6ed7aa07f89126() {
  self endon("disconnect");
  self endon("death");
  level.var_8b30d8e5d8aecf1.var_cbefd54560ae748b = 0;

  if(!isDefined(level.var_8b30d8e5d8aecf1.var_15649dca955ec899)) {
    level.var_8b30d8e5d8aecf1.var_15649dca955ec899 = function_8996551ace9f412();
    level.var_8b30d8e5d8aecf1.struct_map = [];
    function_933650aaf0f8897a();
  }

  level.var_8b30d8e5d8aecf1.objectivelocations = function_39f40beae668b99e();
  setDvar(@ "hash_8d8d07ebd5c01625", 1);
}

function function_85aedb842bdb548b(discovery_name, enabled, objective_radius, should_persist, cooldown, should_draw_quest_circle, quest_circle_radius, quest_circle_origin_override, allow_spotter, skip_spotter_delay, spotter_ignore_water, allow_los, los_distance, allow_proximity, should_draw_device_icon, discover_block_flag, min_distance) {
  if(!isDefined(self)) {
    assertmsg("Not valid object for discovery");
    return;
  }

  if(!isDefined(self.var_3d33ce746b270d75)) {
    self.var_3d33ce746b270d75 = spawnStruct();
  }

  if(!isDefined(level.var_8b30d8e5d8aecf1.var_15649dca955ec899)) {
    level.var_8b30d8e5d8aecf1.var_15649dca955ec899 = function_8996551ace9f412();
    level.var_8b30d8e5d8aecf1.struct_map = [];
    function_933650aaf0f8897a();
  }

  typecast_kvps();
  self.var_3d33ce746b270d75.is_objective = 1;

  if(flag("map_scanner_idle")) {
    if(!isDefined(level.var_8b30d8e5d8aecf1)) {
      level.var_8b30d8e5d8aecf1 = spawnStruct();
    }

    if(!isDefined(level.var_8b30d8e5d8aecf1.var_d2d40b11daa9282b)) {
      level.var_8b30d8e5d8aecf1.var_d2d40b11daa9282b = [];
    }

    level.var_8b30d8e5d8aecf1.var_d2d40b11daa9282b = array_add(level.var_8b30d8e5d8aecf1.var_d2d40b11daa9282b, self);
    return;
  }

  foreach(setting in level.var_8b30d8e5d8aecf1.var_15649dca955ec899) {
    defaultsetting = level.var_8b30d8e5d8aecf1.struct_map[setting].defaultsetting;

    switch (setting) {
      case #"hash_d6d0f2f8a901b9fd":
        self.var_3d33ce746b270d75.discovery_name = isDefined(self.var_3d33ce746b270d75.discovery_name) ? self.var_3d33ce746b270d75.discovery_name : default_to(discovery_name, isDefined(self.script_noteworthy) ? self.script_noteworthy : defaultsetting);
        break;
      case #"hash_fe0f2103d5e6f97e":
        self.var_3d33ce746b270d75.enabled = isDefined(self.var_3d33ce746b270d75.enabled) ? self.var_3d33ce746b270d75.enabled : default_to(enabled, isDefined(self.enabled) ? self.enabled : defaultsetting);
        break;
      case #"hash_b915fc5a5d63c7b3":
        self.var_3d33ce746b270d75.objective_radius = isDefined(self.var_3d33ce746b270d75.objective_radius) ? self.var_3d33ce746b270d75.objective_radius : default_to(objective_radius, isDefined(self.objective_radius) ? self.objective_radius : defaultsetting);
        break;
      case #"hash_69d120f65437dfed":
        self.var_3d33ce746b270d75.should_persist = isDefined(self.var_3d33ce746b270d75.should_persist) ? self.var_3d33ce746b270d75.should_persist : default_to(should_persist, isDefined(self.should_persist) ? self.should_persist : defaultsetting);
        break;
      case #"hash_7b6614415d1b2e48":
        self.var_3d33ce746b270d75.cooldown = isDefined(self.var_3d33ce746b270d75.cooldown) ? self.var_3d33ce746b270d75.cooldown : default_to(cooldown, isDefined(self.cooldown) ? self.cooldown : defaultsetting);
        break;
      case #"hash_a5c807181bedf71":
        self.var_3d33ce746b270d75.quest_circle_radius = isDefined(self.var_3d33ce746b270d75.quest_circle_radius) ? self.var_3d33ce746b270d75.quest_circle_radius : default_to(quest_circle_radius, isDefined(self.radius) ? self.radius : isDefined(self.quest_circle_radius) ? self.quest_circle_radius : defaultsetting);
        break;
      case #"hash_6241b3d45f637356":
        self.var_3d33ce746b270d75.quest_circle_origin_override = isDefined(self.var_3d33ce746b270d75.quest_circle_origin_override) ? self.var_3d33ce746b270d75.quest_circle_origin_override : default_to(quest_circle_origin_override, isDefined(self.quest_circle_origin_override) ? self.quest_circle_origin_override : defaultsetting);
        break;
      case #"hash_a5fcdf32b085d9f1":
        self.var_3d33ce746b270d75.should_draw_quest_circle = isDefined(self.var_3d33ce746b270d75.should_draw_quest_circle) ? self.var_3d33ce746b270d75.should_draw_quest_circle : default_to(should_draw_quest_circle, isDefined(self.should_draw_quest_circle) ? self.should_draw_quest_circle : defaultsetting);

        if(istrue(self.var_3d33ce746b270d75.should_draw_quest_circle)) {
          function_172d0beeceaf5163(0);
        }

        break;
      case #"hash_c1e511c2e0fe1aba":
        self.var_3d33ce746b270d75.allow_spotter = isDefined(self.var_3d33ce746b270d75.allow_spotter) ? self.var_3d33ce746b270d75.allow_spotter : default_to(allow_spotter, isDefined(self.spotter) ? self.spotter : defaultsetting);
        break;
      case #"hash_135276b3546d194e":
        self.var_3d33ce746b270d75.skip_spotter_delay = isDefined(self.var_3d33ce746b270d75.skip_spotter_delay) ? self.var_3d33ce746b270d75.skip_spotter_delay : default_to(skip_spotter_delay, isDefined(self.skip_spotter_delay) ? self.skip_spotter_delay : defaultsetting);
        break;
      case #"hash_9b9cbf8d07d50013":
        self.var_3d33ce746b270d75.spotter_ignore_water = isDefined(self.var_3d33ce746b270d75.spotter_ignore_water) ? self.var_3d33ce746b270d75.spotter_ignore_water : default_to(spotter_ignore_water, isDefined(self.spotter_ignore_water) ? self.spotter_ignore_water : defaultsetting);
        break;
      case #"hash_87ac8497d076bcfb":
        self.var_3d33ce746b270d75.allow_los = isDefined(self.var_3d33ce746b270d75.allow_los) ? self.var_3d33ce746b270d75.allow_los : default_to(allow_los, istrue(self.los) ? 1 : 0);
        break;
      case #"hash_fb276a280398f7fd":
        self.var_3d33ce746b270d75.los_distance = isDefined(self.var_3d33ce746b270d75.los_distance) ? self.var_3d33ce746b270d75.los_distance : default_to(los_distance, isDefined(self.los_distance) ? self.los_distance : defaultsetting);
        break;
      case #"hash_cbf5517d15c305d0":
        self.var_3d33ce746b270d75.allow_proximity = isDefined(self.var_3d33ce746b270d75.allow_proximity) ? self.var_3d33ce746b270d75.allow_proximity : default_to(allow_proximity, istrue(self.proximity) ? 1 : 0);
        break;
      case #"hash_cd735096462515a3":
        self.var_3d33ce746b270d75.discover_block_flag = isDefined(self.var_3d33ce746b270d75.discover_block_flag) ? self.var_3d33ce746b270d75.discover_block_flag : default_to(discover_block_flag, isDefined(self.discover_block_flag) ? self.discover_block_flag : defaultsetting);
        break;
      case #"hash_ddb2514b3e1a3ee0":
        self.var_3d33ce746b270d75.should_draw_device_icon = isDefined(self.var_3d33ce746b270d75.should_draw_device_icon) ? self.var_3d33ce746b270d75.should_draw_device_icon : default_to(should_draw_device_icon, isDefined(self.should_draw_device_icon) ? self.should_draw_device_icon : defaultsetting);

        if(istrue(self.var_3d33ce746b270d75.should_draw_device_icon)) {
          function_ead81f9d7c6670d3();
        }

        break;
      case #"hash_3bab558141f6bed3":
        self.var_3d33ce746b270d75.min_distance = isDefined(self.var_3d33ce746b270d75.min_distance) ? self.var_3d33ce746b270d75.min_distance : default_to(min_distance, isDefined(self.min_distance) ? self.min_distance : defaultsetting);
        break;
    }
  }

  self.var_3d33ce746b270d75.id = function_b89b55d24d45aa95();

  if(!istrue(self.var_3d33ce746b270d75.should_persist)) {
    if(function_2a2a8e6796cccfc4(self)) {
      namespace_1170726b2799ea65::function_cc8a338bb3b0a9fe(self.var_3d33ce746b270d75.id, 0);
    }
  }

  self.var_3d33ce746b270d75.var_abaad65a4510ef4 = default_to(function_2a2a8e6796cccfc4(self), 0);

  if(flag("discoverable_population_complete")) {
    level.var_8b30d8e5d8aecf1.objectivelocations = array_add(level.var_8b30d8e5d8aecf1.objectivelocations, self);
  }
}

function function_b86d00bf56de247() {
  if(isDefined(level.var_8b30d8e5d8aecf1.var_cbefd54560ae748b)) {
    return (level.var_8b30d8e5d8aecf1.var_cbefd54560ae748b > 0);
  }

  return false;
}

function function_ac954082a55b68b7(spread_offset) {
  if(isDefined(level.var_8b30d8e5d8aecf1) && isDefined(level.var_8b30d8e5d8aecf1.var_3f2c367416b5b6e7)) {
    level.var_8b30d8e5d8aecf1.var_3f2c367416b5b6e7 = spread_offset;
    return;
  }

  assertmsg("Discovery Projection Spread is not set");
}

function function_3c886a3ecef3e90e(var_53b1635570b0e202) {
  switch (var_53b1635570b0e202) {
    case #"hash_7ba90eb9ea770f88":
      return istrue(self.var_3d33ce746b270d75.allow_spotter);
    case #"hash_1d73586c9f6890cd":
      return istrue(self.var_3d33ce746b270d75.allow_los);
    case #"hash_161d2d6c65d1cc82":
      return istrue(self.var_3d33ce746b270d75.allow_proximity);
  }

  return false;
}

function function_c83d1e8771ec8f57(searchname) {
  assertex(function_409b4b9bee1fbe1c(self), "<dev string:x1c>");
  self.var_3d33ce746b270d75.discovery_name = searchname;
}

function function_c1cc6dcce270f411(isallowed) {
  assertex(function_409b4b9bee1fbe1c(self), "<dev string:x1c>");
  self.var_3d33ce746b270d75.allow_spotter = isallowed;
}

function function_847531f882fe30d0(isallowed) {
  assertex(function_409b4b9bee1fbe1c(self), "<dev string:x1c>");
  self.var_3d33ce746b270d75.allow_los = isallowed;

  if(function_3c886a3ecef3e90e("LOS")) {
    thread compare_objective_distance();
  }
}

function function_70c1d0abf9be9b83(isallowed) {
  assertex(function_409b4b9bee1fbe1c(self), "<dev string:x1c>");
  self.var_3d33ce746b270d75.allow_proximity = isallowed;

  if(function_3c886a3ecef3e90e("proximity")) {
    thread compare_objective_distance();
  }
}

function function_bab704273dd54bf8(var_366f9b64a15f4a45) {
  assertex(function_409b4b9bee1fbe1c(self), "<dev string:x1c>");
  self.var_3d33ce746b270d75.los_distance = var_366f9b64a15f4a45;
}

function function_75bf86ba2237d4a2(searchradius) {
  assertex(function_409b4b9bee1fbe1c(self), "<dev string:x1c>");
  self.var_3d33ce746b270d75.objective_radius = searchradius;
}

function function_64c508c5eab90d48(var_97fd57deadfd2036) {
  assertex(function_409b4b9bee1fbe1c(self), "<dev string:x1c>");
  self.var_3d33ce746b270d75.should_persist = var_97fd57deadfd2036;
}

function function_13ffcc0bd41e3ed3(var_9fb5f0eb77be5010) {
  assertex(function_409b4b9bee1fbe1c(self), "<dev string:x1c>");
  self.var_3d33ce746b270d75.skip_spotter_delay = var_9fb5f0eb77be5010;
}

function function_a613cc0392f03812(var_49542827403c0577) {
  assertex(function_409b4b9bee1fbe1c(self), "<dev string:x1c>");
  self.var_3d33ce746b270d75.spotter_ignore_water = var_49542827403c0577;
}

function function_bc16e47a5d8d241a(min_distance) {
  assertex(function_409b4b9bee1fbe1c(self), "<dev string:x1c>");
  self.var_3d33ce746b270d75.min_distance = min_distance;
}

function function_9ab6c382d227266(flag) {
  assertex(function_409b4b9bee1fbe1c(self), "<dev string:x1c>");
  self.var_3d33ce746b270d75.discover_block_flag = flag;
}

function function_e41386b37a9ecd5(cooldown) {
  assertex(function_409b4b9bee1fbe1c(self), "<dev string:x1c>");
  self.var_3d33ce746b270d75.cooldown = cooldown;
}

function function_f78ace0b96872cae() {
  return isDefined(self.var_3d33ce746b270d75.var_6e8887bfb1ba92ea);
}

function function_26541bcd24e1161(function, params) {
  assertex(function_409b4b9bee1fbe1c(self), "<dev string:x1c>");

  if(!isDefined(self.var_3d33ce746b270d75.var_6e8887bfb1ba92ea)) {
    self.var_3d33ce746b270d75.var_6e8887bfb1ba92ea = [];
  }

  index = self.var_3d33ce746b270d75.var_6e8887bfb1ba92ea.size;

  if(isDefined(function)) {
    self.var_3d33ce746b270d75.var_6e8887bfb1ba92ea[index]["function"] = function;

    if(isDefined(params)) {
      if(!isarray(params)) {
        params = [params];
      }
    }

    self.var_3d33ce746b270d75.var_6e8887bfb1ba92ea[index]["params"] = params;
  }
}

function function_7ee915c93a6fe72e(newradius, seconds) {
  assertex(function_acaa75ca8754452e(), "<dev string:x3d>");

  if(isDefined(seconds) && float(seconds) > 0) {
    currentradius = self.var_3d33ce746b270d75.quest_circle_radius;
    deltaradius = newradius - currentradius;
    thread function_c6c97baa041205e(&function_4584ad1c0e2c58ec, currentradius, deltaradius, seconds);
  } else {
    function_4584ad1c0e2c58ec(newradius);
  }

  self.var_3d33ce746b270d75.quest_circle_radius = newradius;
}

function function_b773df738fa8577a(neworigin, seconds) {
  assertex(function_acaa75ca8754452e(), "<dev string:x3d>");

  if(isDefined(seconds) && float(seconds) > 0) {
    currentorigin = function_d9583306c5a171e4();
    newx = neworigin[0] - currentorigin[0];
    newy = neworigin[1] - currentorigin[1];
    newz = currentorigin[2];
    deltaorigin = (newx, newy, newz);
    function_c6c97baa041205e(&function_6e148c8da2e4db13, currentorigin, deltaorigin, seconds);
  } else {
    function_6e148c8da2e4db13(neworigin);
  }

  self.var_3d33ce746b270d75.quest_circle_origin_override = neworigin;
  self notify("quest_circle_origin_updated");
}

function function_a45e799ed3aaf7e8(object) {
  assertex(isDefined(self) && isDefined(self.origin), "<dev string:x88>");
  assertex(function_acaa75ca8754452e(), "<dev string:x3d>");
  thread function_d0e54e027ab4bd55(object);
}

function function_b6f9073a006577f7(offset) {
  assertex(function_acaa75ca8754452e(), "<dev string:x3d>");
  xoffset = randomfloatrange(offset * -1, offset);
  yoffset = randomfloatrange(offset * -1, offset);
  currentorigin = function_d9583306c5a171e4();
  offsetorigin = (currentorigin[0] + xoffset, currentorigin[1] + yoffset, currentorigin[2]);
  return offsetorigin;
}

function function_b87282ce9cad9ef7(var_4a2ae3da61f890e6, var_15cc723b93d60fae, circleradius, circleorigin) {
  var_15cc723b93d60fae = default_to(var_15cc723b93d60fae, var_4a2ae3da61f890e6);

  if(var_15cc723b93d60fae && !function_acaa75ca8754452e()) {
    self.var_3d33ce746b270d75.quest_circle_radius = default_to(circleradius, isDefined(self.var_3d33ce746b270d75.quest_circle_radius) ? self.var_3d33ce746b270d75.quest_circle_radius : 500);
    self.var_3d33ce746b270d75.quest_circle_origin_override = default_to(circleorigin, isDefined(self.var_3d33ce746b270d75.quest_circle_origin_override) ? self.var_3d33ce746b270d75.quest_circle_origin_override : self.origin);
    function_172d0beeceaf5163(var_4a2ae3da61f890e6);
    function_cfd53c8f6878014f(level.player);
  }

  if(istrue(var_4a2ae3da61f890e6)) {
    function_6988310081de7b45();
    return;
  }

  function_4eaf685bc40a3b9();
}

function function_630feb56af340ca8(var_4a2ae3da61f890e6, var_91f3fabf8fd39bb2) {
  objectives = function_628b627739980112(var_91f3fabf8fd39bb2);

  foreach(objective in objectives) {
    objective function_b87282ce9cad9ef7(var_4a2ae3da61f890e6);
  }
}

function function_628b627739980112(var_91f3fabf8fd39bb2) {
  objectives = [];

  if(!isDefined(level.var_8b30d8e5d8aecf1.objectivelocations) && !istrue(var_91f3fabf8fd39bb2)) {
    return objectives;
  }

  foreach(objective in level.var_8b30d8e5d8aecf1.objectivelocations) {
    if(objective function_409b4b9bee1fbe1c() || istrue(var_91f3fabf8fd39bb2)) {
      if(objective function_acaa75ca8754452e()) {
        objectives = array_add(objectives, objective);
      }
    }
  }

  return objectives;
}

function function_e1d5982417835a53() {
  assertex(function_409b4b9bee1fbe1c(self), "<dev string:x1c>");
  return isDefined(self.var_3d33ce746b270d75.var_3d2eff7fd9e84a72);
}

function function_138084ca49ce8b6() {
  objectives = [];

  if(!isDefined(level.var_8b30d8e5d8aecf1.objectivelocations)) {
    return objectives;
  }

  foreach(objective in level.var_8b30d8e5d8aecf1.objectivelocations) {
    if(objective function_409b4b9bee1fbe1c() && isDefined(self.var_3d33ce746b270d75.var_3d2eff7fd9e84a72)) {
      objectives = array_add(objectives, objective);
    }
  }

  return objectives;
}

function function_ead81f9d7c6670d3(icon, size, overrideorigin, var_19d9dafda168ba8f) {
  if(function_e1d5982417835a53()) {
    function_d578cb697ac20521();
  }

  function_1a7274eea64e4be5(icon, size, undefined, overrideorigin, var_19d9dafda168ba8f);
  function_d82ca87796cf3232(0);
}

function function_d578cb697ac20521() {
  if(function_e1d5982417835a53()) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.var_3d33ce746b270d75.var_3d2eff7fd9e84a72);
  }

  self.var_3d33ce746b270d75.var_3d2eff7fd9e84a72 = undefined;
}

function function_d82ca87796cf3232(var_a5cda730360ff920) {
  if(istrue(var_a5cda730360ff920)) {
    scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.var_3d33ce746b270d75.var_3d2eff7fd9e84a72, level.player);
    return;
  }

  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.var_3d33ce746b270d75.var_3d2eff7fd9e84a72, level.player);
}

function function_38efe55695a668bf(var_a5cda730360ff920) {
  objectives = function_138084ca49ce8b6();

  foreach(objective in objectives) {
    objective function_d82ca87796cf3232(var_a5cda730360ff920);
  }
}

function function_238f43a4d2d691d1(duration, originoverride) {
  self.var_3d33ce746b270d75.marker = newhudelem();
  self.var_3d33ce746b270d75.marker setshader("icon_waypoint_ally_marker", 1, 1);
  self.var_3d33ce746b270d75.marker.alpha = 1;
  self.var_3d33ce746b270d75.marker.color = (0, 1, 1);
  self.var_3d33ce746b270d75.marker setwaypoint(1, 0, 0);

  if(isDefined(originoverride)) {
    self.var_3d33ce746b270d75.marker.x = originoverride[0];
    self.var_3d33ce746b270d75.marker.y = originoverride[1];
    self.var_3d33ce746b270d75.marker.z = originoverride[2];
  } else if(isDefined(self.var_3d33ce746b270d75.entity)) {
    self.var_3d33ce746b270d75.marker linkwaypointtotargetwithoffset(self.var_3d33ce746b270d75.entity, (0, 0, 0));
  } else {
    self.var_3d33ce746b270d75.marker.x = self.origin[0];
    self.var_3d33ce746b270d75.marker.y = self.origin[1];
    self.var_3d33ce746b270d75.marker.z = self.origin[2];
  }

  level.players[0] playlocalsound("br_ping_location");
  thread function_abde4baaca273089(self.var_3d33ce746b270d75.ping_duration);
}

function function_abde4baaca273089(duration) {
  self endon("death");

  if(!isDefined(self.var_3d33ce746b270d75.marker)) {
    return;
  }

  if(isDefined(duration) && isnumber(duration)) {
    wait duration;
  } else if(level.players[0] namespace_e875ad14b292bd61::binoculars_isads()) {
    level.players[0] waittill("binoculars_ads_off");
  } else {
    self waittill("objective_complete");
  }

  self.var_3d33ce746b270d75.marker destroy();
  self notify("objective_ping_complete");
}

function function_8877d1ab9056dac1(duration) {
  assertex(function_409b4b9bee1fbe1c(self), "<dev string:x1c>");
  self.var_3d33ce746b270d75.ping_duration = duration;
}

function function_5115845eb1cdee21(shouldping, pingduration, originoverride) {
  assertex(function_409b4b9bee1fbe1c(self), "<dev string:x1c>");
  self.var_3d33ce746b270d75.var_9bb11c7b9e7d17a2 = shouldping;
  self.var_3d33ce746b270d75.var_6854e8a3c5653e5d = originoverride;

  if(shouldping) {
    if(isDefined(pingduration)) {
      function_8877d1ab9056dac1(pingduration);
    }
  }
}

function function_9258d9b4344f8922(objective) {
  assertex(function_409b4b9bee1fbe1c(self), "<dev string:x1c>");
  return istrue(self.var_3d33ce746b270d75.var_9bb11c7b9e7d17a2);
}

function function_f27e7dcea1050aab() {
  assertex(function_409b4b9bee1fbe1c(self), "<dev string:x1c>");
  self.var_3d33ce746b270d75.discover_block_flag = undefined;
}

function function_409b4b9bee1fbe1c(objective) {
  objective = default_to(objective, self);

  if(isDefined(objective) && isDefined(objective.var_3d33ce746b270d75) && istrue(objective.var_3d33ce746b270d75.is_objective)) {
    return true;
  }

  return false;
}

function function_5175ee2a98016ca8(objective) {
  objective = default_to(objective, self);
  return function_409b4b9bee1fbe1c(objective) && istrue(objective.var_3d33ce746b270d75.is_volume);
}

function function_8628f3714288d06d(objective) {
  objective = default_to(objective, self);

  if(function_409b4b9bee1fbe1c() && isDefined(objective.var_3d33ce746b270d75.discover_block_flag) && flag(objective.var_3d33ce746b270d75.discover_block_flag)) {
    return true;
  }

  return false;
}

function function_23425e6521e47280(objective) {
  objective = default_to(objective, self);
  return istrue(objective.var_3d33ce746b270d75.var_abaad65a4510ef4);
}

function function_496475b45501e30d(isenabled) {
  assertex(function_409b4b9bee1fbe1c(self), "<dev string:x1c>");

  if(function_3c886a3ecef3e90e("LOS")) {
    if(istrue(isenabled)) {
      thread compare_objective_distance();
    } else {
      self notify("compare_objective_distance");
    }
  }

  self.var_3d33ce746b270d75.enabled = isenabled;
}

function function_4eca06647c264c23(objective) {
  assert(function_409b4b9bee1fbe1c(objective));
  return istrue(objective.var_3d33ce746b270d75.enabled);
}

function function_7bc08bcf1793eea3() {
  if(isDefined(self.var_3d33ce746b270d75)) {
    return self.var_3d33ce746b270d75.var_e3f964a745320980;
  }

  return undefined;
}

function function_7223f6c3d6c4f979(var_e5b495906761a6cc) {
  var_45b55a8a7dca4c18 = isDefined(var_e5b495906761a6cc) ? function_3c886a3ecef3e90e(var_e5b495906761a6cc) : 1;

  if(function_409b4b9bee1fbe1c(self) && function_4eca06647c264c23(self) && !function_8628f3714288d06d(self) && !function_23425e6521e47280(self) && var_45b55a8a7dca4c18) {
    return true;
  }

  return false;
}

function function_cea825be3aa05c9(objective) {
  objective = default_to(objective, self);

  if(isDefined(objective.var_3d33ce746b270d75) && istrue(objective.var_3d33ce746b270d75.var_b97aaea781f69cd8)) {
    return true;
  }

  return false;
}

function function_51fd5f0f2c9e0cba(var_e5b495906761a6cc) {
  self endon("death");
  self endon("disconnect");

  if(!function_7223f6c3d6c4f979(var_e5b495906761a6cc)) {
    return;
  }

  if(function_f78ace0b96872cae()) {
    foreach(function in self.var_3d33ce746b270d75.var_6e8887bfb1ba92ea) {
      params = default_to(function ["params"], []);
      thread scripts\engine\utility::function_399a710b148277ad(self.var_3d33ce746b270d75.discovery_name, function ["function"], params, self);
    }
  }

  function_d4f691f9fcef6c1f(var_e5b495906761a6cc);

  if(istrue(self.var_3d33ce746b270d75.var_9bb11c7b9e7d17a2) && isDefined(var_e5b495906761a6cc) && var_e5b495906761a6cc == "spotter") {
    function_238f43a4d2d691d1(undefined, self.var_3d33ce746b270d75.var_6854e8a3c5653e5d);
  }

  level.var_8b30d8e5d8aecf1.var_cbefd54560ae748b++;
  self.var_3d33ce746b270d75.var_b97aaea781f69cd8 = 1;
  self.var_3d33ce746b270d75.var_e3f964a745320980 = var_e5b495906761a6cc;

  if(istrue(self.var_3d33ce746b270d75.should_persist)) {
    namespace_1170726b2799ea65::function_cc8a338bb3b0a9fe(self.var_3d33ce746b270d75.id, 1);
  }

  self.var_3d33ce746b270d75.var_abaad65a4510ef4 = 1;

  if(isDefined(self.var_3d33ce746b270d75.cooldown)) {
    function_2933bf03d3275ea4();
    self.var_3d33ce746b270d75.var_abaad65a4510ef4 = 0;

    if(function_3c886a3ecef3e90e("LOS") || function_3c886a3ecef3e90e("proximity")) {
      thread compare_objective_distance();
    }
  }
}

function function_914b829c1006fba6() {
  return "jup_question_mark";
}

function function_ab522b97af67094c(linecolor) {
  origin = self.origin;
  size_min = self.struct.var_74e936bbadd15418;
  size_max = self.struct.var_750c4cbbadf7cc32;
  angles = self.angles;
  box_width = size_max[0] + size_min[0];
  box_depth = size_max[1] + size_min[1];
  box_height = size_max[2] + size_min[2];
  forward = anglesToForward(angles);
  right = anglestoright(angles);
  up = anglestoup(angles);
  topleftfront = origin + forward * size_max[0] + right * size_max[1] + up * size_max[2];
  toprightfront = origin - forward * size_min[0] + right * size_max[1] + up * size_max[2];
  topleftback = origin + forward * size_max[0] - right * size_min[1] + up * size_max[2];
  toprightback = origin - forward * size_min[0] - right * size_min[1] + up * size_max[2];
  bottomleftfront = origin + forward * size_max[0] + right * size_max[1] - up * size_min[2];
  bottomrightfront = origin - forward * size_min[0] + right * size_max[1] - up * size_min[2];
  var_2febbcb4c37b3b64 = origin + forward * size_max[0] - right * size_min[1] - up * size_min[2];
  var_3a64b6f876a6b09f = origin - forward * size_min[0] - right * size_min[1] - up * size_min[2];
  thread scripts\cp_mp\utility\debug_utility::drawboxfrompoints(topleftfront, toprightfront, topleftback, toprightback, bottomleftfront, bottomrightfront, var_2febbcb4c37b3b64, var_3a64b6f876a6b09f, function_75d09d086b745c89(), linecolor);
}

function private function_39f40beae668b99e() {
  objectives = function_62a59bb3c360a4ab();

  if(isDefined(level.var_8b30d8e5d8aecf1.var_d2d40b11daa9282b)) {
    objectives = array_combine_unique(objectives, level.var_8b30d8e5d8aecf1.var_d2d40b11daa9282b);
  }

  if(!isDefined(objectives)) {
    return;
  }

  objectives = sortbydistance(objectives, (0, 0, 0));
  level.var_8b30d8e5d8aecf1.var_d2d40b11daa9282b = [];

  for(i = 0; i < objectives.size; i++) {
    objectives[i] function_85aedb842bdb548b();

    if(objectives[i] function_3c886a3ecef3e90e("LOS") || objectives[i] function_3c886a3ecef3e90e("proximity")) {
      objectives[i] thread compare_objective_distance();
    }
  }

  return objectives;
}

function private function_c6c97baa041205e(func, currentparam, deltaparam, seconds) {
  self endon("death");
  self endon("disconnect");
  self endon("end_function_over_time");
  starttime = gettime();
  seconds *= 1000;

  while(true) {
    elapsedtime = gettime() - starttime;

    if(elapsedtime >= seconds) {
      break;
    }

    scale = elapsedtime / seconds;
    newparam = currentparam + deltaparam * scale;
    self[[func]](newparam);
    waitframe();
  }
}

function private function_62a59bb3c360a4ab() {
  objectives = [];
  struct_objectives = getStructArray("scan_objective", "targetname");

  foreach(struct in struct_objectives) {
    var_25abbf787ca0afe2 = 1;

    if(isDefined(level.var_8b30d8e5d8aecf1.var_d2d40b11daa9282b)) {
      foreach(var_2f9e676cecaabadd in level.var_8b30d8e5d8aecf1.var_d2d40b11daa9282b) {
        if(struct.origin == var_2f9e676cecaabadd.origin) {
          if(isDefined(var_2f9e676cecaabadd.var_3d33ce746b270d75)) {
            var_2f9e676cecaabadd.var_3d33ce746b270d75.is_struct = 1;
          }

          var_25abbf787ca0afe2 = 0;
        }
      }
    }

    if(var_25abbf787ca0afe2) {
      if(!isDefined(struct.var_3d33ce746b270d75)) {
        struct.var_3d33ce746b270d75 = spawnStruct();
      }

      struct.var_3d33ce746b270d75.is_struct = 1;
      objectives = array_add(objectives, struct);
    }
  }

  volume_objectives = function_f159c10d5cf8f0b4("scan_volume", "targetname");

  foreach(volume in volume_objectives) {
    var_25abbf787ca0afe2 = 1;

    if(isDefined(level.var_8b30d8e5d8aecf1.var_d2d40b11daa9282b)) {
      foreach(var_2f9e676cecaabadd in level.var_8b30d8e5d8aecf1.var_d2d40b11daa9282b) {
        if(volume.origin == var_2f9e676cecaabadd.origin) {
          if(isDefined(volume.var_3d33ce746b270d75)) {
            var_2f9e676cecaabadd.var_3d33ce746b270d75.is_volume = 1;
          }

          var_25abbf787ca0afe2 = 0;
        }
      }
    }

    if(var_25abbf787ca0afe2) {
      if(!isDefined(volume.var_3d33ce746b270d75)) {
        volume.var_3d33ce746b270d75 = spawnStruct();
      }

      volume.var_3d33ce746b270d75.is_volume = 1;
      objectives = array_add(objectives, volume);
    }
  }

  return objectives;
}

function private function_172d0beeceaf5163(var_bec2a42cbb441433) {
  if(function_acaa75ca8754452e()) {
    if(istrue(var_bec2a42cbb441433)) {
      function_6988310081de7b45();
    }

    return;
  }

  var_5e02c77a388b779d = default_to(self.var_3d33ce746b270d75.quest_circle_radius, 500);
  draworigin = default_to(self.var_3d33ce746b270d75.quest_circle_origin_override, self.origin);
  function_6b6b6273f8180522("ObjectiveDiscovery_cp", draworigin, var_5e02c77a388b779d, level.players[0]);
}

function private function_1a7274eea64e4be5(icon, size, var_c5409ca7522182b3, overrideorigin, var_19d9dafda168ba8f) {
  icon = default_to(icon, "jup_question_mark");
  size = default_to(size, "icon_large");
  var_c5409ca7522182b3 = default_to(var_c5409ca7522182b3, 0);
  useorigin = isent(self) ? undefined : self.origin;
  overrideorigin = default_to(overrideorigin, useorigin);
  self.var_3d33ce746b270d75.var_13d96f83acbfad65 = default_to(var_19d9dafda168ba8f, 0);
  function_c23f03606d30fc1f(icon, size, 0, var_c5409ca7522182b3, overrideorigin);
}

function private function_d4f691f9fcef6c1f(var_e5b495906761a6cc) {
  var_e5b495906761a6cc = default_to(var_e5b495906761a6cc, "NONE");

  if(isDefined(self.var_3d33ce746b270d75.discovery_name)) {
    if(getdvarint(@ "hash_f96cf0eb7c0d0f90", 0) == 1) {
      iprintlnbold("<dev string:xf0>" + self.var_3d33ce746b270d75.discovery_name + "<dev string:xf9>" + var_e5b495906761a6cc);
    }

    flag_set(self.var_3d33ce746b270d75.discovery_name, var_e5b495906761a6cc);
    self notify(self.var_3d33ce746b270d75.discovery_name, var_e5b495906761a6cc);
    self notify("objective_discovered");
  }

  if(!isDefined(self.var_3d33ce746b270d75.discovery_name)) {
    iprintlnbold("<dev string:x103>");
  }
}

function private compare_objective_distance() {
  self endon("death");
  self endon("disconnect");
  self notify("compare_objective_distance");
  self endon("compare_objective_distance");
  self endon("objective_discovered");

  while(flag("map_scanner_idle")) {
    wait 1;
  }

  player = level.players[0];

  while(function_3c886a3ecef3e90e("LOS") || function_3c886a3ecef3e90e("proximity")) {
    wait function_75d09d086b745c89();
    var_e5b495906761a6cc = undefined;

    if(level.players[0] namespace_e875ad14b292bd61::binoculars_isads()) {
      level.players[0] waittill("binoculars_ads_off");
      continue;
    }

    if(function_3c886a3ecef3e90e("proximity")) {
      var_69759bd657284bc9 = function_a9b5d13fe5f689e9();
      var_e5b495906761a6cc = istrue(var_69759bd657284bc9) ? "proximity" : undefined;
    }

    if(!isDefined(var_e5b495906761a6cc) && function_3c886a3ecef3e90e("LOS")) {
      var_69759bd657284bc9 = function_33f65e70afe93566();
      var_e5b495906761a6cc = istrue(var_69759bd657284bc9) ? "LOS" : undefined;
    }

    if(isDefined(var_e5b495906761a6cc)) {
      thread function_51fd5f0f2c9e0cba(var_e5b495906761a6cc);
    }
  }
}

function private function_2933bf03d3275ea4() {
  self notify("objective_on_cooldown");

  if(isnumber(self.var_3d33ce746b270d75.cooldown)) {
    wait self.var_3d33ce746b270d75.cooldown;
  } else if(isfunction(self.var_3d33ce746b270d75.cooldown)) {
    self[[self.var_3d33ce746b270d75.cooldown]]();
  } else if(isstring(self.var_3d33ce746b270d75.cooldown)) {
    self waittill(self.var_3d33ce746b270d75.cooldown);
  }

  self notify("objective_cooldown_completed");
}

function private function_d0e54e027ab4bd55(object) {
  self endon("death");
  self endon("disconnect");
  self endon("quest_circle_origin_updated");
  assertex(function_409b4b9bee1fbe1c(self), "<dev string:x1c>");
  tracker = default_to(object, self);

  if(!isDefined(self.var_3d33ce746b270d75.quest_circle_origin_override) || self.var_3d33ce746b270d75.quest_circle_origin_override != tracker.origin) {
    self.var_3d33ce746b270d75.quest_circle_origin_override = tracker.origin;
  }

  while(true) {
    origin = tracker.origin;
    var_2a73dee08dd771a7 = function_d9583306c5a171e4();

    if(origin[0] != var_2a73dee08dd771a7[0] && origin[1] != var_2a73dee08dd771a7[1]) {
      function_6e148c8da2e4db13(origin);
    }

    self.var_3d33ce746b270d75.quest_circle_origin_override = tracker.origin;
    waitframe();
  }
}

function private typecast_kvps() {
  if(isDefined(self.spotter)) {
    self.spotter = int(self.spotter);
  }

  if(isDefined(self.skip_spotter_delay)) {
    self.skip_spotter_delay = int(self.skip_spotter_delay);
  }

  if(isDefined(self.los)) {
    self.los = int(self.los);
  }

  if(isDefined(self.los_distance)) {
    self.los_distance = float(self.los_distance);
  }

  if(isDefined(self.should_draw_quest_circle)) {
    self.should_draw_quest_circle = int(self.should_draw_quest_circle);
  }

  if(isDefined(self.quest_circle_radius)) {
    self.quest_circle_radius = float(self.quest_circle_radius);
  }

  if(isDefined(self.objective_radius)) {
    self.objective_radius = float(self.objective_radius);
  }

  if(isDefined(self.spotter_ignore_water)) {
    self.spotter_ignore_water = int(self.spotter_ignore_water);
  }

  if(isDefined(self.cooldown)) {
    self.cooldown = float(self.cooldown);
  }

  if(isDefined(self.should_persist)) {
    self.should_persist = int(self.should_persist);
  }

  if(isDefined(self.min_distance)) {
    self.min_distance = float(self.min_distance);
  }
}

function private function_8996551ace9f412() {
  return ["discovery_name", "enabled", "objective_radius", "should_persist", "cooldown", "should_draw_quest_circle", "quest_circle_radius", "quest_circle_origin_override", "allow_spotter", "skip_spotter_delay", "spotter_ignore_water", "allow_LOS", " LOS_distance", "discover_block_flag", "should_draw_device_icon", "min_distance"];
}

function private function_933650aaf0f8897a() {
  foreach(setting in level.var_8b30d8e5d8aecf1.var_15649dca955ec899) {
    level.var_8b30d8e5d8aecf1.struct_map[setting] = spawnStruct();

    switch (setting) {
      case #"hash_135276b3546d194e":
      case #"hash_c1e511c2e0fe1aba":
      case #"hash_fe0f2103d5e6f97e":
        level.var_8b30d8e5d8aecf1.struct_map[setting].defaultsetting = 1;
        break;
      case #"hash_69d120f65437dfed":
      case #"hash_87ac8497d076bcfb":
      case #"hash_9b9cbf8d07d50013":
      case #"hash_a5fcdf32b085d9f1":
      case #"hash_ddb2514b3e1a3ee0":
        level.var_8b30d8e5d8aecf1.struct_map[setting].defaultsetting = 0;
        break;
      case #"hash_b915fc5a5d63c7b3":
        level.var_8b30d8e5d8aecf1.struct_map[setting].defaultsetting = 200;
        break;
      case #"hash_a5c807181bedf71":
        level.var_8b30d8e5d8aecf1.struct_map[setting].defaultsetting = 500;
        break;
      case #"hash_fb276a280398f7fd":
        level.var_8b30d8e5d8aecf1.struct_map[setting].defaultsetting = 1000;
        break;
      case #"hash_3bab558141f6bed3":
        level.var_8b30d8e5d8aecf1.struct_map[setting].defaultsetting = 200;
        break;
      case #"hash_6241b3d45f637356":
      case #"hash_7b6614415d1b2e48":
      case #"hash_cd735096462515a3":
      case #"hash_d6d0f2f8a901b9fd":
        level.var_8b30d8e5d8aecf1.struct_map[setting].defaultsetting = undefined;
        break;
      default:
        level.var_8b30d8e5d8aecf1.struct_map[setting].defaultsetting = undefined;
        break;
    }
  }
}