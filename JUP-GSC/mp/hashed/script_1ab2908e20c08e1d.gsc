/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1ab2908e20c08e1d.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\utility\player;
#using scripts\mp\utility\weapon;
#namespace inhibitor;

function function_3670f4d8dcce3aec() {
  level._effect["inhibitor_pulse"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_sporecontrol_inhibitor_pulse.vfx");
  level._effect["inhibitor_idle"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_sporecontrol_inhibitor_idle.vfx");
}

function function_427def4c56968d9f(grenade) {
  grenade endon("death");
  grenade thread monitor_timeout(grenade.inhibitor_model);
  function_acccb8cab20190d9(grenade);
  grenade thread function_554cebc2d67c5e02(self);

  if(scripts\engine\utility::issharedfuncdefined("entity", "trackEntityLimit")) {
    [[scripts\engine\utility::getsharedfunc("entity", "trackEntityLimit")]](grenade, self, "inhibitor");
    grenade thread function_36645b2e031dc50b();
  }
}

function function_acccb8cab20190d9(grenade) {
  level endon("game_ended");
  self endon("disconnect");
  grenade endon("death");
  relaunchvelocity = getdvarint(@ "hash_d57482b850330a6", 150);

  while(true) {
    grenade childthread function_53b45ece303b029c(self);
    grenade waittill("missile_stuck", var_82d5e3b42d0191c9, hitentpart, surfacetype, velocity, position, hitnormal);
    ignoreents = vehicle_getarrayinradius(grenade.origin, 500, 500);
    tracecontents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1, 0, 1);
    tracestart = grenade.origin;
    var_3a7f0173b03f5767 = -2000;
    traceend = grenade.origin + (0, 0, var_3a7f0173b03f5767);
    traceresults = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, tracecontents);
    var_cb4d3248c7f2eadf = 0;

    if(isDefined(var_82d5e3b42d0191c9)) {
      if(var_82d5e3b42d0191c9 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        if(isDefined(hitentpart)) {
          hitentpart = scripts\common\vehicle::function_8ed0ffa3f8be7c75(hitentpart);
          iswheel = issubstr(hitentpart, "wheel");

          if(iswheel) {
            var_cb4d3248c7f2eadf = 1;
          }
        }
      }
    }

    if(var_cb4d3248c7f2eadf) {
      grenade unlink();
      offsetvec = hitnormal + self gettagorigin("j_spineupper") - grenade.origin;
      neworigin = grenade.origin + vectorNormalize(offsetvec) * 10;
      grenade = scripts\mp\utility\weapon::_launchgrenade("trophy_mp", neworigin, hitnormal * relaunchvelocity, undefined, 1, grenade);
      continue;
    }

    break;
  }
}

function function_53b45ece303b029c(player) {
  self endon("death");
  self endon("missile_stuck");
  player endon("disconnect");
  msg = waittill_any_timeout_1(2, "touching_platform");

  if(msg == "timeout") {
    return;
  }

  groundentity = undefined;
  ignoreents = vehicle_getarrayinradius(self.origin, 500, 500);
  ignoreents[ignoreents.size] = self;
  tracecontents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1, 0, 1);
  tracestart = self.origin;
  var_3a7f0173b03f5767 = -2000;
  traceend = self.origin + (0, 0, var_3a7f0173b03f5767);
  traceresults = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, tracecontents);

  if(traceresults["fraction"] < 1) {
    groundentity = traceresults["entity"];

    if(isDefined(groundentity)) {
      if(is_train_ent(groundentity)) {
        self.origin = player.origin;
      }
    }
  }
}

function function_554cebc2d67c5e02(player) {
  self endon("death");
  grenade = self;
  grenade hide();
  grenade.angles = grenade.angles;
  ground_pos = grenade.origin;

  if(function_f4091cdf59c6f35c(ground_pos)) {
    dir = vectorNormalize(grenade.origin - player.origin);
    ground_pos = getgroundposition(grenade.origin - dir * 26, 1);
  }

  inhibitor_model = spawn("script_model", ground_pos);
  inhibitor_model.angles = grenade.angles;
  inhibitor_model setModel("wm_jup_zm_inhibitor_device");
  inhibitor_model notsolid();
  grenade.origin = ground_pos;
  inhibitor_model.grenade = grenade;
  inhibitor_model.team = self.team;
  grenade.inhibitor_model = inhibitor_model;
  grenade.inhibitor_model linkTo(grenade, "tag_origin");
  grenade.inhibitor_model.player_owner = player;

  if(!isDefined(grenade) && isDefined(inhibitor_model)) {
    inhibitor_model delete();
  }

  grenade thread function_fecb0c5ebbe74c13();
}

function function_fecb0c5ebbe74c13() {
  grenade = self;
  grenade.inhibitor_model setscriptablepartstate("body", "active_usable");

  foreach(player in level.players) {
    grenade.inhibitor_model disablescriptableplayeruse(player);
  }

  grenade.inhibitor_model enablescriptableplayeruse(grenade.inhibitor_model.player_owner);
  scriptable_addusedcallback(&function_f2a91412bc5778c2);
  grenade thread function_85348883faef3ae0();
  grenade thread function_8d6c1168a68452d6();
}

function function_ba64a36771329308() {
  if(!is_equal(self.inhibitor_model getscriptablepartstate("state"), "detection")) {
    self.inhibitor_model setscriptablepartstate("state", "detection");
    self.inhibitor_model.angles = (0, 0, 0);

    if(isPlayer(self.inhibitor_model.player_owner)) {
      self.inhibitor_model hudoutlineenableforclient(self.inhibitor_model.player_owner, "shimmer");
    }
  }
}

function function_c2380a1826a779f3(var_ab4a81377b413b10) {
  direction = self.inhibitor_model.origin;
  direction = (direction[1], direction[0], 0);

  if(direction[1] < 0 || direction[0] > 0 && direction[1] > 0) {
    direction = (direction[0], direction[1] * -1, 0);
  } else if(direction[0] < 0) {
    direction = (direction[0] * -1, direction[1], 0);
  }

  if(!is_equal(self.inhibitor_model getscriptablepartstate("state"), "fire")) {
    self.inhibitor_model setscriptablepartstate("state", "fire");

    if(isPlayer(self.inhibitor_model.player_owner)) {
      self.inhibitor_model hudoutlinedisableforclient(self.inhibitor_model.player_owner);
    }
  }

  self.inhibitor_model setscriptablepartstate("sound", "pulse");
  playFXOnTag(getfx("inhibitor_pulse"), self.inhibitor_model, "tag_origin");

  foreach(var_ca97c8b14589f30b in var_ab4a81377b413b10) {
    switch (var_ca97c8b14589f30b.identifier) {
      case #"hash_c09cb639830e59e5":
        var_ca97c8b14589f30b scripts\common\callbacks::callback("inhibitor_interact");
        break;
      case #"hash_77e279e245316bbf":
        if(isDefined(var_ca97c8b14589f30b.control_point)) {
          params = spawnStruct();
          params.eattacker = self.inhibitor_model.player_owner;
          params.einflictor = self;
          params.idamage = 100;
          params.instance = var_ca97c8b14589f30b.control_point;
          params.instance.var_9f7b53f50c23948e = default_to(params.instance.var_9f7b53f50c23948e, []);
          params.instance.var_9f7b53f50c23948e = function_6d6af8144a5131f1(params.instance.var_9f7b53f50c23948e, self);
          var_ca97c8b14589f30b.control_point scripts\common\callbacks::callback("shield_damaged", params);
        }

        break;
    }
  }
}

function function_f4091cdf59c6f35c(spawn_origin) {
  self endon("death");
  a_models = getentarrayinradius("script_model", "classname", spawn_origin, 20);
  var_ab4a81377b413b10 = [];

  foreach(var_ca97c8b14589f30b in a_models) {
    if(is_equal(var_ca97c8b14589f30b.identifier, "jup_ob_zombie_control_spore") || is_equal(var_ca97c8b14589f30b.identifier, "jup_ob_zombie_inhibitor_interact")) {
      return true;
    }
  }

  return false;
}

function function_85348883faef3ae0() {
  self endon("death");
  self.inhibitor_model setscriptablepartstate("vfx", "active");
  playFXOnTag(getfx("inhibitor_idle"), self.inhibitor_model, "tag_origin");

  while(true) {
    if(isDefined(self.inhibitor_model)) {
      a_models = getentarrayinradius("script_model", "classname", self.inhibitor_model.origin, 200);
      var_ab4a81377b413b10 = [];

      foreach(var_ca97c8b14589f30b in a_models) {
        if(is_equal(var_ca97c8b14589f30b.identifier, "jup_ob_zombie_control_spore") || is_equal(var_ca97c8b14589f30b.identifier, "jup_ob_zombie_inhibitor_interact")) {
          var_ab4a81377b413b10 = function_6d6af8144a5131f1(var_ab4a81377b413b10, var_ca97c8b14589f30b);
        }
      }

      if(var_ab4a81377b413b10.size > 0) {
        function_c2380a1826a779f3(var_ab4a81377b413b10);
      } else {
        function_ba64a36771329308();
      }
    }

    wait 2;
  }
}

function function_f2a91412bc5778c2(instance, part, state, player, bautouse, usestring) {
  if(!function_621b71c9df814ea4(instance.type)) {
    return;
  }

  fakeitem = spawnStruct();
  fakeitem.type = "obloot_offhand_inhibitor";
  fakeitem.count = 1;
  fakeitem.fromcache = 0;
  player scripts\cp_mp\loot\common_item::function_576728d3d4486bd6(fakeitem, 0);
  instance.entity.grenade function_6b4e113e860a21e8();
}

function function_8d6c1168a68452d6() {
  self endon("death");
  wait 120;
  thread function_b4ccc4be633a50ed();
}

function function_b4ccc4be633a50ed() {
  self endon("death");

  while(true) {
    players = scripts\mp\utility\player::getplayersinradius(self.origin, 1500);

    if(is_equal(players.size, 0)) {
      self.inhibitor_model setscriptablepartstate("sound", "despawn");
      waitframe();
      function_6b4e113e860a21e8();
    }

    wait 2;
  }
}

function function_6b4e113e860a21e8() {
  self endon("death");
  self.inhibitor_model stopsoundchannel("explo_atmo_3d");
  waitframe();

  if(isDefined(self.inhibitor_model)) {
    self.inhibitor_model delete();
  }

  self delete();
}

function function_621b71c9df814ea4(scriptablename) {
  return isDefined(scriptablename) && scriptablename == "equip_inhibitor";
}

function private monitor_timeout(inhibitor_model) {
  self endon("missile_stuck");
  wait 10;

  if(!isDefined(self)) {
    if(isDefined(inhibitor_model)) {
      inhibitor_model delete();
    }

    return;
  }

  if(isDefined(inhibitor_model)) {
    inhibitor_model delete();
  }

  self delete();
}

function is_train_ent(hitent) {
  if(isDefined(level.wztrain_info)) {
    foreach(ent in level.wztrain_info.train_array) {
      if(ent == hitent) {
        return true;
      }

      if(isDefined(ent.linked_model) && ent.linked_model == hitent) {
        return true;
      }
    }
  }

  return false;
}

function function_36645b2e031dc50b() {
  self endon("death");
  self waittill("entity_limit_destroy");
  function_6b4e113e860a21e8();
}