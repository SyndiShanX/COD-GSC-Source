/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3d18e87594285298.gsc
***********************************************/

#using script_3626f1b2cf51a99c;
#using script_52da18c20f45c56a;
#using script_5431e074c1428743;
#using script_9bfd3d8a6a89e5e;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#namespace namespace_e1cd3aae;

function private autoexec __init__system__() {
  system::register(#"hash_63ef0cf11243d45a", &preinit, undefined, undefined, #"hash_7ee44bf733d7a7ac");
}

function private preinit() {
  if(!isDefined(level.body_shield.var_30c92ca9)) {
    level.body_shield.var_30c92ca9 = 1;
    animation::add_global_notetrack_handler("contact", &function_faf4a34d, 0);
    animation::add_global_notetrack_handler("slomo", &function_dec110ef, 0);
    animation::add_global_notetrack_handler("hide", &function_85d6c09b, 0);
    animation::add_global_notetrack_handler("grenade_detonate", &grenade_explode, 0);
    animation::add_global_notetrack_handler("push_enable", &function_9c87450d, 0);
    animation::add_global_notetrack_handler("push_disable", &function_39a3991b, 0);
    animation::add_global_notetrack_handler("camera_unlink", &function_a3d6cc6, 0);
    actions::action_register("body_shield_grenade", &function_dcc1570d, "body_shield");
    actions::action_register("body_shield_kill", &function_a471f3b0, "body_shield");
    actions::function_b1543a9d("body_shield_grenade", "td_anims_body_shield_grenade");
    actions::function_b1543a9d("body_shield_kill", "td_anims_body_shield_kill");
    actions::function_b1543a9d("body_shield_push", "td_anims_body_shield_push");
    level.var_c9e10637 = [];
    level.var_c9e10637[# "frag"] = "body_shield_grenade";
    level.var_c9e10637[# "stance"] = "body_shield_kill";
  }
}

function function_dcc1570d(action) {
  self endon(action.ender);

  while(true) {
    if(is_true(self actions::function_83bde308(action, "frag"))) {
      if(self function_5ebe8eba(action.name)) {
        self thread function_5053f358(action, self.takedown.body);
        return true;
      }
    }

    waitframe(1);
  }

  return false;
}

function function_a471f3b0(action) {
  self endon(action.ender);
  self childthread function_b6bc0788(action);

  if(isDefined(self.takedown.body)) {
    self.takedown.body childthread function_dc160233(action);
  }

  while(true) {
    if(is_true(self actions::function_83bde308(action, "stance"))) {
      var_9a585e5c = isDefined(self.player_actions.var_c4e66a91);
      self actions::function_8488e359();

      if(var_9a585e5c || self function_5ebe8eba(action.name)) {
        self thread function_6c9ddc07(action, self.takedown.body);
        return true;
      }
    }

    waitframe(1);
  }

  return false;
}

function function_b6bc0788(action) {
  self waittill(#"hash_244459f2eb8f0a38");
  self.takedown.body_shield.drop = "dead";
  self actions::function_8488e359("stance");
}

function function_dc160233(action) {
  if(is_true(self.var_d5bd339b)) {
    wait 0.2;
  } else {
    self waittill(#"hash_7884feb21ff33557");
    self.var_d5bd339b = 1;
  }

  player = getplayers()[0];

  if(!isalive(self)) {
    player.takedown.body_shield.drop = "dead";
  }

  player actions::function_8488e359("stance");
}

function function_faf4a34d(guy) {
  player = getplayers()[0];
  victim = isDefined(player.takedown.var_198a4d10) ? player.takedown.var_198a4d10 : self;

  if(isactor(victim)) {
    victim animmode("gravity");
  }

  player val::set(#"action", "takedamage", 0);
  player util::delay(0.5, undefined, &val::set, #"action", "takedamage", 1);
  player playrumbleonentity("damage_heavy");
}

function function_dec110ef(guy) {
  player = getplayers()[0];

  if(player.var_2cb06cc6.name == "body_shield_grenade") {
    return;
  }

  level.fnasmsoldiergetpainweaponsize = &function_5c01c962;
  player util::function_5045bb33(4, 0.25);
  level.fnasmsoldiergetpainweaponsize = undefined;
}

function function_5c01c962(size) {
  return "_lg";
}

function function_85d6c09b(guy) {
  player = getplayers()[0];
  player action_utility::function_76e2ec80();
}

function function_d521a78f() {
  player = self;
  prompt_struct = {};
  prompt_struct.var_4ac77177 = 0;
  prompt_struct.var_de6f0004 = 0;
  prompt_struct.var_531201f1 = &function_d2cf74ab;
  prompt_struct.var_be77841a = 0;
  prompt_struct.groups = [# "actions"];
  self prompts::function_c97a48c7(#"stance", prompt_struct);
  self prompts::function_263320e2(#"stance", #"hash_738e0cc280f3474f");
  self prompts::function_c97a48c7(#"frag", prompt_struct);
  self prompts::function_263320e2(#"frag", #"hash_4ac43752337031be");
  setDvar(#"scr_door_player_gestures", 0);
}

function function_5ebe8eba(action_name) {
  if(is_true(self flag::get("snipercam"))) {
    return 0;
  }

  if(is_true(self.player_actions.var_36a4a92c)) {
    return 0;
  }

  if(!is_true(self.player_actions.enabled[action_name])) {
    return 0;
  }

  override = self actions::function_abaa32c("body_shield");

  if(isDefined(override.disable) && array::contains(override.disable, action_name)) {
    return 0;
  }

  if(self.takedown.body_shield.health > 0) {
    switch (action_name) {
      case # "body_shield_kill":
        return self action_utility::function_fdff1cf3();
      case # "body_shield_grenade":
        return (self action_utility::function_fdff1cf3() && self function_a02c0e4f(self.var_edbc8698));
    }
  }

  return 0;
}

function function_d2cf74ab(prompt_struct) {
  action = level.var_c9e10637[prompt_struct.prompt];
  return isDefined(action) && self function_5ebe8eba(action);
}

function function_a02c0e4f(victim) {
  assert(isPlayer(self));
  return true;
}

function function_ecd2291d() {
  if(isDefined(self.takedown.gesture)) {
    self action_utility::gesture_stop(self.takedown.gesture);
  }
}

function function_849bed38(link_ents, var_e4df1bec, var_cee46280) {
  assert(isPlayer(self));
  waitframe(1);
  pitch = abs(angleclamp180(self getplayerangles()[0]));
  duration = pitch / 180;
  prep = undefined;

  if(pitch > 0) {
    prep = util::spawn_model("tag_origin", self.origin, self.angles);
    self playerlinktoblend(prep, "tag_origin", duration, duration * 0.5, duration * 0.5);
  }

  wait duration + float(function_60d95f53()) / 1000 * 2;

  if(isDefined(prep)) {
    prep delete();
  }
}

function function_5e89af5d(action, victim, var_17fee02c, var_dfce6e2d, var_f510f19d) {
  self.takedown.gesture_hold = self.takedown.gesture;
  self util::function_5f1df718(#"cinematicmotion_static");
  self action_utility::allow_weapon(0, undefined, var_17fee02c, var_dfce6e2d);
  self val::set(#"action", "freezecontrols", 1);
  level prompts::function_86eedc();
  self util::delay(0.2, undefined, &val::set, #"action", "takedamage", 0);
  self function_849bed38([self.var_6639d45b, self.takedown.body], undefined);
  self action_utility::function_2795d678(0);
  self util::delay(0.2, undefined, &function_ecd2291d);

  if(!is_true(var_f510f19d)) {
    self action_utility::function_9d7828b0(0.5);
  }

  self.takedown.var_198a4d10 = self.takedown.body_shield.actor;
}

function function_8ba805b3() {
  self val::reset_all(#"action");
  level prompts::function_d675f5a4();
  self action_utility::allow_weapon(1);
  self.var_d3b4e4f4 = undefined;
  self.var_852e84c9 = undefined;
  prompts::function_398ab9eb();
  self notify(#"hash_2a87a221154d292");
}

function function_5053f358(action, body) {
  self function_5e89af5d(action, body, undefined, 1);
  bb::function_cd497743("bodyshield_grenade", self);
  scene = array::random(["td_scene_bodyshield_grenade_a", "td_scene_bodyshield_grenade_b"]);
  animation = function_11b042fc(scene, "victim");
  body thread function_17414a13(body);
  var_ae5fe668 = 4;
  start = gettime();
  body solid();
  self function_7ead73b1(action, body, "grenade", scene, "ges_body_shield_to_grenade");
  self function_8ba805b3();
  var_ae5fe668 -= float(gettime() - start) / 1000;

  if(var_ae5fe668 > 0) {
    wait var_ae5fe668;
  }

  thread grenade_explode(body);
}

function function_6c9ddc07(action, body = self.takedown.body) {
  var_de098861 = undefined;
  var_6e477ca8 = "td_scene_bodyshield_kill";

  if(self.takedown.body_shield.drop === "dead") {
    var_6e477ca8 = "td_scene_bodyshield_drop";
    var_de098861 = "ges_body_shield_rifle_drop";
    bb::function_cd497743("bodyshield_drop", self);
    self function_5e89af5d(action, body, undefined, 1, 1);
  } else {
    bb::function_cd497743("bodyshield_kill", self);
    self function_5e89af5d(action, body);
  }

  override = self actions::function_abaa32c("body_shield");
  self function_7ead73b1(action, body, "kill", isDefined(override.var_4a561920) ? override.var_4a561920 : var_6e477ca8, var_de098861);

  if(isalive(self.takedown.var_198a4d10)) {
    util::stop_magic_bullet_shield(self.takedown.var_198a4d10);
    self.takedown.var_198a4d10 kill();
  }

  self function_8ba805b3();
}

function function_58980558(victim) {
  self notify("25be7002b301b234");
  self endon("25be7002b301b234");

  if(isactor(victim)) {
    self thread function_ae4d480a(victim);
  }

  while(isDefined(victim)) {
    self.takedown.victim_origin = victim getcorpsephysicsorigin() + (0, 0, 1);
    waitframe(1);
  }
}

function function_ae4d480a(victim) {
  victim endon(#"entitydeleted");
  result = victim waittill(#"actor_corpse");
  self thread function_58980558(result.corpse);
}

function function_7ead73b1(action, body, animnameplay, scene, gesture) {
  assert(isPlayer(self));
  waittillframeend();
  player = self;
  self prompts::remove_group(#"actions");
  player.var_ca6b6423 = undefined;
  setDvar(#"scr_door_player_gestures", 1);
  scene_root = spawnStruct();
  scene_root.origin = self.origin;
  scene_root.angles = self.angles;

  if(!self action_utility::function_fdff1cf3()) {
    offset = (0, 0, 8);
    scene_root.origin = playerphysicstrace(self.origin + offset, self.origin + anglesToForward(self.angles) * -15 + offset);
    scene_root.origin = playerphysicstrace(scene_root.origin, scene_root.origin - offset);
  }

  self.takedown.victim = [];
  self.takedown.body = undefined;
  self.takedown.body_shield.scene_root = scene_root;
  self.takedown.body_shield.actor unlink();
  self.takedown.body_shield.actor forceteleport(scene_root.origin, scene_root.angles);
  self.takedown.body_shield.actor.health = int(max(1, self.takedown.body_shield.health));
  self.takedown.body_shield.actor.var_c681e4c1 = 1;
  self.takedown.body_shield.actor action_utility::function_35d0bd11(0);
  self.takedown.body_shield.actor notsolid();
  ai::setaiattribute(self.takedown.body_shield.actor, "useGrenades", 0);
  self thread function_58980558(self.takedown.body_shield.actor);
  self.takedown.body_shield.actor.var_f6639ad8 = function_11b042fc(scene, "victim");
  notes = getnotetracktimes(self.takedown.body_shield.actor.var_f6639ad8, "push_enable");
  self.takedown.body_shield.actor.var_1a1dd1a0 = notes[0];

  if(isDefined(gesture)) {
    self.var_621f8539 = gesture;
    self thread action_utility::gesture_play(gesture);
  }

  self util::delay(float(function_60d95f53()) / 1000, undefined, &action_utility::function_76e2ec80);
  scene_root action_utility::scene_play(scene, self, self.takedown.body_shield.actor);
  self.takedown.body_shield.actor action_utility::function_b82cae8f(0, 0);
  self action_utility::function_76e2ec80();

  if(isalive(self.takedown.body_shield.actor)) {
    self.takedown.body_shield.actor solid();
  }

  self action_utility::function_2795d678(0);
  self actions::function_942d9213();
  self flag::clear("in_action");
}

function function_11b042fc(scenename, objectname, shot = 0, var_dd00fdae = 0) {
  scene = getscriptbundle(scenename);

  if(isDefined(scene.objects)) {
    var_61da41d8 = tolower(objectname);

    foreach(obj in scene.objects) {
      if(tolower(obj.name) === var_61da41d8) {
        return obj.shots[shot].entry[var_dd00fdae].anim;
      }
    }
  }
}

function function_1058ffa1(guy = self) {
  assert(isactor(guy));
  guy.var_54163419 = util::spawn_model(#"wpn_t9_eqp_grenade_frag_view", guy.origin, guy.angles);
  guy.var_54163419 notsolid();
  guy.var_54163419 linkto(guy, "tag_accessory_left", (0, 0, 0), (0, 0, 0));
  guy callback::function_30c3f95d(&function_6794cd13);
}

function function_17414a13(guy) {
  guy waittill(#"death");
  function_30e6300b(guy);
}

function function_30e6300b(var_5fb1bd74) {
  if(isDefined(var_5fb1bd74.var_54163419) && isDefined(var_5fb1bd74.var_bc2602c8) && !is_true(var_5fb1bd74.var_54163419.dropped)) {
    var_5fb1bd74.var_54163419.dropped = 1;
    launchforce = var_5fb1bd74.var_bc2602c8 * 2;
    launchforce += (randomfloatrange(-0.5, 0.5), randomfloatrange(-0.5, 0.5), randomfloatrange(-0.5, 0.5));
    launchforce = vectornormalize(launchforce) * 0.1;
    var_5fb1bd74.var_54163419 unlink();
    var_5fb1bd74.var_54163419 physicslaunch(var_5fb1bd74.var_54163419.origin - (0, 0, 3), launchforce);
    var_5fb1bd74.var_54163419 thread grenade_explode(var_5fb1bd74, 2);
  }
}

function grenade_explode(var_5fb1bd74, delay) {
  if(isDefined(var_5fb1bd74.var_54163419)) {
    grenade = var_5fb1bd74.var_54163419;
    grenade notify(#"grenade_explode");
    grenade endon(#"grenade_explode");

    if(isDefined(delay)) {
      now = gettime();

      if(!isDefined(grenade.var_be9d05c3)) {
        grenade.var_be9d05c3 = gettime() + delay * 1000;
      }

      if((isDefined(grenade.var_be9d05c3) ? grenade.var_be9d05c3 : now) > now) {
        wait float(grenade.var_be9d05c3 - now) / 1000;
      }
    }

    if(isDefined(grenade)) {
      origin = grenade.origin;
      grenade delete();
      wpn_grenade = getweapon(#"frag_grenade");
      player = getplayers()[0];
      player.body_shield_grenade = player magicgrenademanualplayer(origin, (0, 0, 0), wpn_grenade, 0);
    }
  }
}

function function_6794cd13(params) {
  self.var_54163419 = params.original.var_54163419;

  if(isDefined(self.var_54163419) && isDefined(params.original.var_54163419)) {
    self.var_54163419.var_be9d05c3 = params.original.var_54163419.var_be9d05c3;
  }

  self.var_bc2602c8 = params.original.var_bc2602c8;
  function_30e6300b(self);
}

function function_a3d6cc6(params) {
  if(isPlayer(self) && isDefined(self.takedown.body_shield.actor)) {
    self.takedown.body_shield.actor action_utility::function_b82cae8f(0, 0);
    return;
  }

  if(isactor(self)) {
    self action_utility::function_b82cae8f(0, 0);
  }
}

function function_13841987() {
  self endon(#"death", #"killanimscript");

  if(!isDefined(self.var_f6639ad8)) {
    iprintlnbold("<dev string:x38>");

    return;
  }

  player = getplayers()[0];

  if(self scene::function_c935c42()) {
    objectlist = arraycopy(self._scene_object._o_scene._a_objects);

    foreach(object in objectlist) {
      if(object._e !== player && isDefined(object._e._scene_object)) {
        [[object._e._scene_object]] - > stop();
      }

      if(isDefined(object._e) && !isactor(object._e) && !isPlayer(object._e)) {
        object._e delete();
      }
    }
  }

  self stopanimscripted();
  self.allowpain = 0;
  self.ignoreme = 1;
  scene_root = player.takedown.body_shield.scene_root;
  self.var_13841987 = 1;
  self orientmode("face default");
  self animmode("nogravity");
  self animation::play(self.var_f6639ad8, scene_root.origin, scene_root.angles, 1, 0, 0, 0, self.var_1a1dd1a0, undefined, undefined, undefined, undefined, "custom");

  if(isalive(self)) {
    self animmode("zonly_physics");
    self.allowpain = 1;
    self.ignoreme = 0;
    self.var_f6639ad8 = undefined;
    self.in_melee_death = undefined;
  }
}

function function_2d4ccf74() {
  if(isDefined(self) && !isalive(self)) {
    self startragdoll(1);
  }

  self.var_13841987 = undefined;
}

function function_9c87450d() {
  if(!is_true(self.var_13841987)) {
    self function_1058ffa1(self);
    self animcustom(&function_13841987, &function_2d4ccf74);
    self thread function_306feb88();
  }
}

function function_39a3991b() {
  self notify(#"hash_2860a6b03ec878f6");
}

function function_84d08d48(delay) {
  if(isDefined(delay) && delay > 0) {
    wait delay;
  }

  if(isDefined(self.var_406bdb5c)) {}
}

function function_bae5ad1b() {
  player = getplayers()[0];

  if(!isai(self)) {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  if(self.primaryweapon.name === "#none" || isDefined(player.takedown.body_shield) && is_true(player.takedown.body_shield.var_13356219)) {
    self.forceragdollimmediate = 1;
    self kill(self.origin, player, player);
  }
}

function function_306feb88(guy) {
  if(is_true(self.var_306feb88)) {
    return;
  }

  self notify(#"hash_2860a6b03ec878f6");
  self.var_306feb88 = 1;
  self endoncallback(&function_e69bc894, #"hash_2860a6b03ec878f6", #"death", #"killanimscript");
  last_position = self.origin;
  anim_name = undefined;
  player = getplayers()[0];
  player endon(#"disconnect");
  destroyed = [];
  var_29fbf4b0 = max(60, max(80, 32));

  while(true) {
    waitframe(1);
    move_delta = self.origin - last_position;
    move_delta = (move_delta[0], move_delta[1], 0);
    last_position = self.origin;

    if(lengthsquared(move_delta) < 0.01) {
      continue;
    }

    interactables = getentitiesinradius(self.origin, var_29fbf4b0);

    foreach(interact in interactables) {
      if(interact === self) {
        continue;
      }

      if(isPlayer(interact)) {
        continue;
      }

      if(isDefined(interact.var_f6639ad8)) {
        continue;
      }

      dir = interact.origin - self.origin;
      dir = vectornormalize((dir[0], dir[1], 0));
      move_dir = vectornormalize(move_delta);
      dot = vectordot(move_dir, dir);

      if(dot < 0) {
        continue;
      }

      if(isai(interact)) {
        if(interact scene::function_c935c42() && !is_true(interact.takedamage)) {
          continue;
        }

        if(interact flag::get("push_immune")) {
          continue;
        }

        if(distancesquared(self.origin, interact.origin) > 80 * 80) {
          continue;
        }

        if(dot > cos(30) && !is_true(interact.var_bb317c90)) {
          dot_right = vectordot(vectorcross(move_dir, (0, 0, 1)), dir);

          if(dot_right > 0) {
            dir = rotatepoint(move_dir, (0, -45, 0));
          } else {
            dir = rotatepoint(move_dir, (0, 45, 0));
          }

          var_ba580a85 = "body_shield_push" + "_push_" + randomintrange(1, 5);
          interact.var_f6639ad8 = level.player_actions.anims[# "generic"][var_ba580a85];
          interact.var_475b4bbe = vectortoangles(dir)[1] + 180;
          interact animcustom(&function_adf3cfb0, &function_9e4f9044);
        }

        continue;
      }

      if(isDefined(interact.c_door)) {
        if(interact.c_door flag::get("locked")) {
          continue;
        }

        if(is_true(interact.c_door.var_81f24576)) {
          continue;
        }

        if(distancesquared(self.origin, interact.origin) > 60 * 60) {
          continue;
        }

        interact.c_door thread doors::door_bash_open(player, 1, self.origin);
        continue;
      }

      if(interact.classname === "script_model" && is_true(interact.allowdeath) && !isDefined(destroyed[interact getentitynumber()])) {
        if(dot > cos(45)) {
          pt = rotatepoint(move_dir, (0, 0, 0) - interact.angles) * -1;
          test_point = interact getpointinbounds(pt[0], pt[1], pt[2]);

          if(distance2dsquared(self.origin, test_point) < 32 * 32) {
            impactpoint = interact.origin + (0, 0, 15);
            impactpoint += vectornormalize(self.origin - interact.origin) * 10;
            radiusdamage(impactpoint, 16, interact.health + 1, interact.health, self, "MOD_IMPACT");
            destroyed[interact getentitynumber()] = interact;
          }
        }
      }
    }

    var_c3548f43 = move_delta * 3;
    var_858fa287 = move_delta * 5;
    zoffset = (0, 0, 16);
    boundsmin = (-16, -16, 0);
    boundsmax = (16, 16, 40);
    mask = 1 | 8 | 2;
    tracestart = self.origin + zoffset;
    traceend = tracestart + var_c3548f43;
    traceendfar = tracestart + var_858fa287;
    trace = physicstrace(tracestart, traceend, boundsmin, boundsmax, self, mask);
    movedir = vectornormalize(move_delta);
    facingdir = anglesToForward(self.angles);
    facingdir = vectornormalize((facingdir[0], facingdir[1], 0));
    dotfwd = vectordot(facingdir, movedir);
    self.var_bc2602c8 = movedir;
    anim_name = undefined;

    if(!isDefined(trace[# "entity"]) && trace[# "fraction"] < 1) {
      anim_name = "body_shield_push" + (dotfwd < 0 ? "_bounce_back_" : "_bounce_front_") + randomintrange(1, 3);
    } else if(trace[# "fraction"] >= 1) {
      trace = physicstrace(traceend, traceendfar, boundsmin, boundsmax, self, mask);

      if(trace[# "fraction"] >= 1) {
        tracestart = traceendfar;
        traceend = tracestart + zoffset * -3;
        trace = physicstrace(tracestart, traceend, boundsmin, boundsmax, self, mask);

        if(trace[# "fraction"] >= 1) {
          anim_name = "body_shield_push" + (dotfwd < 0 ? "_fall_back" : "_fall_front");
          dokill = 1;

          if(abs(dotfwd) < 0.7) {
            right = vectorcross(movedir, (0, 0, 1));
            dotright = vectordot(facingdir, right);
            anim_name = "body_shield_push" + (dotright > 0 ? "_fall_right" : "_fall_left");
          }
        }
      }
    }

    if(isDefined(anim_name)) {
      animtoplay = level.player_actions.anims[# "generic"][anim_name];

      if(isDefined(animtoplay)) {
        self animscripted(animtoplay, self.origin, self.angles, animtoplay, "custom", undefined, undefined, 0.1);
        self endon(#"death");
        wait getanimlength(animtoplay) - 0.1;
        self.skipdeathanim = 1;
        self kill();
        return;
      }
    }
  }
}

function function_e69bc894(guy) {
  self.var_306feb88 = undefined;
}

function function_adf3cfb0() {
  self endoncallback(&function_adf60f68, #"death", #"killanimscript");

  if(!isDefined(self.var_f6639ad8)) {
    iprintlnbold("<dev string:x5f>");

    return;
  }

  self.allowpain = 0;
  self.ignoreme = 1;
  self.var_bb317c90 = 1;

  if(self isragdoll()) {
    return;
  }

  self orientmode("face angle", self.var_475b4bbe);
  self animmode("gravity");
  self animscripted(self.var_f6639ad8, self.origin, self.angles, self.var_f6639ad8, "custom");
  wait getanimlength(self.var_f6639ad8);
}

function function_9e4f9044() {
  self.allowpain = 1;
  self.ignoreme = 0;
  self.var_f6639ad8 = undefined;
  self.var_bb317c90 = undefined;
}

function function_adf60f68(params) {
  if(params === # "death") {
    self startragdoll();
  }
}