/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_52da18c20f45c56a.gsc
***********************************************/

#using script_3626f1b2cf51a99c;
#using scripts\abilities\gadgets\gadget_health_regen;
#using scripts\core_common\animation_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#using scripts\weapons\weapon_utils;
#namespace action_utility;

function private autoexec __init__system__() {
  system::register(#"action_utility", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("scriptmover", "link_to_camera", 1, 2, "int");
  clientfield::register("actor", "link_to_camera", 1, 2, "int");
  clientfield::register("toplayer", "fake_ads", 1, 1, "int");
}

function function_30b535ff(inuse) {
  if(!isDefined(self.var_30b535ff)) {
    self.var_30b535ff = 0;
  }

  if(inuse) {
    self.var_30b535ff = max(1, self.var_30b535ff + 1);
  } else {
    self.var_30b535ff = max(0, self.var_30b535ff - 1);
  }

  return self.var_30b535ff;
}

function function_77af90aa(var_cf230c0, attach_tag) {
  self detachall();

  if(isDefined(var_cf230c0)) {
    assert(isDefined(attach_tag));
    assert(var_cf230c0.size == attach_tag.size);

    for(i = 0; i < var_cf230c0.size; i++) {
      self attach(var_cf230c0[i], attach_tag[i], 1);
    }
  }
}

function level_pitch(link_ents, var_e4df1bec) {
  assert(isPlayer(self));
  pitch = abs(angleclamp180(self getplayerangles()[0]));

  if(pitch > 0) {
    prep = util::spawn_model("tag_origin", self.origin, self.angles);
    duration = pitch / 180;
    self playerlinktoblend(prep, "tag_player", duration, duration * 0.5, duration * 0.5);

    if(isDefined(link_ents)) {
      foreach(ent_to_link in link_ents) {
        ent_to_link function_b82cae8f(1);
      }
    }

    if(is_true(var_e4df1bec)) {
      self thread function_e4df1bec(duration);
    }

    wait duration + float(function_60d95f53()) / 1000;

    if(isDefined(link_ents)) {
      foreach(ent_to_link in link_ents) {
        ent_to_link function_b82cae8f(0);
      }
    }

    self unlink();
    prep delete();
  }
}

function function_e4df1bec(duration) {
  self thread easing::ease_dvar("bg_viewBobAmplitudeStanding", self.var_74c52b3d.var_c9e720e2, duration, "linear");
  self thread easing::ease_dvar("bg_bobMax", self.var_74c52b3d.viewbobmax, duration, "linear");
  self thread easing::ease_dvar("bg_bobTransTime", self.var_74c52b3d.var_945795a5, duration, "linear");
}

function become_corpse() {
  if(self clientfield::get("link_to_camera")) {
    self function_b82cae8f(0);
  }

  if(!iscorpse(self) && !is_true(getplayers()[0].var_9ebbaa46.var_7e5a6cf9)) {
    aitype = self.ai_type;

    if(!isDefined(aitype)) {
      aitype = self.aitype;
    }

    self solid();

    if(!isactor(self)) {
      var_b9c0ade5 = self.var_b9c0ade5;
      corpse = self function_f5408e2c(aitype, getplayers()[0].velocity);
      corpse.var_b9c0ade5 = var_b9c0ade5;
    }
  }
}

function function_2e55c59e(var_f68ce314) {
  assert(isDefined(var_f68ce314) && isfloat(var_f68ce314));
  level.player_actions.var_671420ae = var_f68ce314;
}

function function_e3b9f13() {
  level.player_actions.var_671420ae = 0.5;
}

function function_e46cbbf7() {
  if(!isDefined(level.player_actions.var_671420ae)) {
    level.player_actions.var_671420ae = 0.5;
  }

  return level.player_actions.var_671420ae;
}

function function_31df4786(var_165b239b = 1, allow_ads = 1) {
  assert(!isDefined(self.var_31df4786));
  self.var_31df4786 = 1;
  self val::set(#"hash_681a4eb9df49482f", "disable_weapon_cycling", 1);
  self val::set(#"hash_681a4eb9df49482f", "disable_weapon_reload", 1);
  self val::set(#"hash_681a4eb9df49482f", "disable_weapon_pickup", 1);
  self val::set(#"hash_681a4eb9df49482f", "disable_offhand_weapons", 1);
  self val::set(#"hash_681a4eb9df49482f", "disable_offhand_special", 1);
  self val::set(#"hash_681a4eb9df49482f", "disable_aim_assist", 1);
  self val::set(#"hash_681a4eb9df49482f", "allow_crouch", 0);
  self val::set(#"hash_681a4eb9df49482f", "allow_prone", 0);
  self val::set(#"hash_681a4eb9df49482f", "allow_sprint", 0);
  self val::set(#"hash_681a4eb9df49482f", "allow_jump", 0);
  self val::set(#"hash_681a4eb9df49482f", "allow_climb", 0);
  self val::set(#"hash_681a4eb9df49482f", "allow_mantle", 0);
  self val::set(#"hash_681a4eb9df49482f", "allow_melee_victim", 0);

  if(!var_165b239b) {
    self val::set(#"hash_681a4eb9df49482f", "disable_weapons", 1);
  }

  if(!allow_ads) {
    self val::set(#"hash_681a4eb9df49482f", "allow_ads", 0);
  }

  if(!function_1fac6486(self getcurrentweapon())) {
    self val::set(#"hash_681a4eb9df49482f", "allow_melee", 0);
  }
}

function function_9123bbf0() {
  self val::reset_all(#"hash_681a4eb9df49482f");
  self.var_31df4786 = undefined;
}

function function_2795d678(encumbered, var_165b239b, var_37e68004, allow_ads, var_6a87e928) {
  player = self;
  assert(isPlayer(player));
  pistol = undefined;

  if(!isDefined(var_165b239b)) {
    var_165b239b = 1;
  }

  if(!isDefined(var_37e68004)) {
    var_37e68004 = 0;
  }

  if(!isDefined(allow_ads)) {
    allow_ads = 1;
  }

  if(encumbered) {
    if(!isDefined(player.var_74c52b3d)) {
      self.var_74c52b3d = spawnStruct();
      self function_31df4786(var_165b239b, allow_ads);
      player.var_74c52b3d.movespeedscale = player getmovespeedscale();
      player.var_74c52b3d.var_c9e720e2 = getDvar(#"bg_viewbobamplitudestanding");
      player.var_74c52b3d.var_c9e720e2 = string(player.var_74c52b3d.var_c9e720e2[0]) + " " + string(player.var_74c52b3d.var_c9e720e2[1]);
      player.var_74c52b3d.viewbobmax = getdvarfloat(#"bg_bobmax");
      player.var_74c52b3d.var_945795a5 = getdvarint(#"bg_bobtranstime");
      var_b56db8c = function_e46cbbf7();
      player setmovespeedscale(var_b56db8c);
      player thread function_854fc491(var_6a87e928);

      if(var_165b239b) {
        if(var_37e68004) {
          pistol = player function_d338e637();

          if(isDefined(pistol)) {
            player.var_74c52b3d.weapon_list = player getweaponslist();
            player.var_74c52b3d.weapon_last = player getcurrentweapon();

            if(!isDefined(player.var_74c52b3d.weapon_last) || player.var_74c52b3d.weapon_last.basename == "none") {
              player.var_74c52b3d.weapon_last = level.player.last_weapon;
            }

            player switchtoweapon(pistol);
          }
        }

        if(isDefined(player.var_74c52b3d.weapon_list)) {
          foreach(weap in player.var_74c52b3d.weapon_list) {
            if(isDefined(pistol) && weap != pistol) {
              player takeweapon(weap);
            }
          }
        }
      }

      self prompts::function_e79f51ec([#"actions", #"doors", #"body_carry"]);
      self flag::set("encumbered");
    }

    return;
  }

  if(isDefined(player.var_74c52b3d)) {
    self function_9123bbf0();
    player setmovespeedscale(player.var_74c52b3d.movespeedscale);
    player thread function_854fc491();

    if(isDefined(player.var_74c52b3d.weapon_list)) {
      foreach(weap in player.var_74c52b3d.weapon_list) {
        if(isDefined(pistol) && weap != pistol) {
          player giveweapon(weap);
        }
      }
    }

    if(isDefined(player.var_74c52b3d.weapon_last)) {
      player switchtoweapon(player.var_74c52b3d.weapon_last);
    }

    self prompts::function_398ab9eb();
    self flag::clear("encumbered");
  }

  player.var_74c52b3d = undefined;
}

function function_854fc491(var_6a87e928) {
  player = self;
  assert(isPlayer(player));
  player endon(#"death");
  self notify("74e9614dd06b695a");
  self endon("74e9614dd06b695a");

  if(isDefined(var_6a87e928)) {
    if(!isDefined(var_6a87e928)) {
      var_6a87e928 = [];
    } else if(!isarray(var_6a87e928)) {
      var_6a87e928 = array(var_6a87e928);
    }
  }

  if(isDefined(var_6a87e928)) {
    lastmode = -1;

    while(true) {
      newmode = lastmode;

      if(player function_29fd0abd() && var_6a87e928.size > 1) {
        newmode = 1;
      } else {
        newmode = 0;
      }

      if(lastmode != newmode) {
        player util::function_5f1df718(var_6a87e928[newmode]);
      }

      lastmode = newmode;
      waitframe(1);
    }

    return;
  }

  player util::function_5f1df718(undefined);
}

function function_d338e637() {
  foreach(weap in self getweaponslist()) {
    if(weapons::ispistol(weap)) {
      return weap;
    }
  }

  return undefined;
}

function function_c4e06b5a() {
  return "j_spinelower";
}

function function_eef2dca9(guys) {
  assert(isPlayer(self));
  scene_root = spawnStruct();
  scene_root.angles = self.angles;
  scene_root.origin = self.origin + self getvelocity() * float(function_60d95f53()) / 1000;

  if(!isDefined(guys)) {
    guys = [];
  } else if(!isarray(guys)) {
    guys = array(guys);
  }

  foreach(guy in guys) {
    if(isDefined(guy)) {
      guy dontinterpolate();
    }
  }

  return scene_root;
}

function function_b82cae8f(linktype, var_5596253c = 1) {
  offset = (0, 0, -60);
  player = getplayers()[0];

  if(self.var_47f0a724 === 2) {
    offset = (0, 0, 0);
  }

  if(is_true(linktype) && self.var_47f0a724 !== linktype) {
    self clientfield::set("link_to_camera", linktype);
    self.var_47f0a724 = linktype;
    return;
  }

  if(!is_true(linktype) && is_true(self.var_47f0a724)) {
    self clientfield::set("link_to_camera", 0);

    if(is_true(var_5596253c)) {
      origin = player getplayercamerapos();
      angles = player getplayerangles();
      axis = anglestoaxis(angles);
      origin += offset[0] * axis.forward;
      origin += offset[1] * axis.right;
      origin += offset[2] * axis.up;

      if(isactor(self)) {
        self teleport(origin, angles);
      } else {
        self.origin = origin;
        self.angles = angles;
        self dontinterpolate();
      }
    }

    self.var_47f0a724 = undefined;
  }
}

function function_bda1ed48() {
  var_9d19b745 = 400;
  assert(isPlayer(self));
  return lengthsquared(self getvelocity()) > var_9d19b745;
}

function function_3fbe0931(action) {
  self notify(#"hash_4dff86580406a1af");
  self function_2795d678(0);
  self allow_weapon(1);
  self val::reset_all(#"action");
}

function allow_weapon(allowed, forced, gesture, var_dfce6e2d) {
  if(!allowed) {
    if(!isDefined(gesture)) {
      gesture = "ges_body_shield_gundown_quick";
    }

    self.var_15c4009c = (isDefined(self.var_15c4009c) ? self.var_15c4009c : 0) + 1;

    if(self.var_15c4009c === 1) {
      self val::set(#"hash_1759513a118d68fd", "disable_weapon_fire", 1);
      self val::set(#"hash_1759513a118d68fd", "disable_weapon_reload", 1);
      self val::set(#"hash_1759513a118d68fd", "disable_weapon_pickup", 1);
      self val::set(#"hash_1759513a118d68fd", "disable_weapon_cycling", 1);
      self val::set(#"hash_1759513a118d68fd", "disable_offhand_weapons", 1);
      self val::set(#"hash_1759513a118d68fd", "disable_offhand_special", 1);
      self.var_621f8539 = gesture;

      if(!is_true(var_dfce6e2d) && !function_1c2cb657(self getcurrentweapon())) {
        self thread gesture_play(self.var_621f8539);
      }
    }

    return;
  }

  if(isDefined(self.var_15c4009c)) {
    self.var_15c4009c -= 1;

    if(is_true(forced) || self.var_15c4009c <= 0) {
      self val::reset_all(#"hash_1759513a118d68fd");
      self val::reset_all(#"hash_58b9fd1cfcf4a27d");

      if(!function_1c2cb657(self getcurrentweapon())) {
        if(isDefined(gesture)) {
          self thread gesture_play(gesture);
        } else if(isDefined(self.var_621f8539)) {
          self thread gesture_stop(self.var_621f8539);
        }
      }

      self.var_15c4009c = undefined;
      self.var_621f8539 = undefined;
    }
  }
}

function function_1e9599a7(other) {
  self.weapon = other.weapon;
  self.primaryweapon = other.primaryweapon;
  self.secondaryweapon = other.secondaryweapon;
  self.sidearm = other.sidearm;
  self.grenadeweapon = other.grenadeweapon;
  self.weaponinfo = other.weaponinfo;

  if(!isDefined(self.a)) {
    self.a = spawnStruct();
    self.a.weaponpos = [];
    self.a.weaponposdropping = [];
  }

  if(isDefined(other.a)) {
    self.a.weaponpos = other.a.weaponpos;
  }

  self.var_9d46265b = other.var_9d46265b;
}

function function_b5d8286c(action, scene_root, anim_ents, anim_name, victim, phase) {
  var_fc8116b2 = self function_462c34d0(action, scene_root, anim_name, victim, phase);

  if(isDefined(var_fc8116b2.scene_root) && isDefined(var_fc8116b2.scene_root.target)) {
    anim_ents = arraycombine(anim_ents, getEntArray(var_fc8116b2.scene_root.target, "targetname"));
  }

  if(isDefined(var_fc8116b2.scene_root) && isDefined(var_fc8116b2.scene_root.script_linkto)) {
    anim_ents = arraycombine(anim_ents, getEntArray(var_fc8116b2.scene_root.script_linkto, "script_linkname"));
  }

  var_3c131b96 = undefined;

  foreach(ent in anim_ents) {
    if(ent === self || !isDefined(var_3c131b96)) {
      var_3c131b96 = ent;
    }

    ent.var_3f4de57b = level.player_actions.anims[ent.animname][var_fc8116b2.anim_name];
    ent notify(#"new_scripted_anim");
    ent thread function_3f4de57b(var_fc8116b2.anim_name);
  }

  if(isDefined(var_3c131b96)) {
    wait getanimlength(var_3c131b96.var_3f4de57b);
  }

  foreach(ent in anim_ents) {
    ent.var_3f4de57b = undefined;
  }

  return var_fc8116b2.var_da0c6cb;
}

function function_aee5f6a6(var_b56433f8) {
  self notify("55dd956a145bde6");
  self endon("55dd956a145bde6");
  index = randomintrange(1, 4);
  self playrumbleonentity(#"reload_small");
  pain_anim = var_b56433f8 + "_pain_" + index;

  if(is_true(self.var_de5476af)) {
    pain_anim = var_b56433f8 + "_ads_pain_" + index;
  }

  if(isDefined(level.player_actions.anims[#"generic"][pain_anim])) {
    self.takedown.body thread function_3f4de57b(pain_anim, 0);
    self.var_6639d45b function_3f4de57b(pain_anim, 0);
    loop_anim = self function_47ffa6b8(var_b56433f8);
    self.takedown.body thread function_d621e6d6(loop_anim);
    self.var_6639d45b thread function_d621e6d6(loop_anim);
  }
}

function function_1e132b9f(blendtime, clearanims) {
  self notify(#"hash_23e6132220ac0e4d");
  self notify(#"new_scripted_anim");

  if(!isDefined(blendtime)) {
    blendtime = 0.2;
  }

  if(!isDefined(clearanims)) {
    clearanims = 1;
  }

  if(isDefined(self.var_d621e6d6)) {
    if(clearanims) {
      self clearanim(self.var_d621e6d6, blendtime);
    }

    self.var_d621e6d6 = undefined;
  }

  if(isDefined(self.var_3f4de57b)) {
    if(clearanims) {
      self clearanim(self.var_3f4de57b, blendtime);
    }

    self.var_3f4de57b = undefined;
  }
}

function function_3f4de57b(animnameplay, blendtime = isDefined(level.player_actions.blend[self.animname][animnameplay]) ? level.player_actions.blend[self.animname][animnameplay] : 0.2, clearanims = 1) {
  self function_1e132b9f(blendtime, clearanims);
  self endon(#"death", #"entitydeleted", #"hash_23e6132220ac0e4d");
  animplay = level.player_actions.anims[self.animname][animnameplay];
  assert(isDefined(animplay));
  self thread animation::play(animplay, self.origin, self.angles, 1, blendtime, blendtime);
  self.var_3f4de57b = animplay;
  wait getanimlength(animplay);
  self.var_3f4de57b = undefined;

  if(clearanims) {
    self clearanim(animplay, blendtime);
  }
}

function function_d621e6d6(var_eea30707, blendtime) {
  if(isDefined(self.var_d621e6d6) && self.var_d621e6d6 == level.player_actions.anims[self.animname][var_eea30707]) {
    return;
  }

  if(!isDefined(blendtime)) {
    blendtime = isDefined(level.player_actions.blend[self.animname][var_eea30707]) ? level.player_actions.blend[self.animname][var_eea30707] : 0.2;
  }

  self function_1e132b9f(blendtime);
  self endon(#"death");
  self endon(#"entitydeleted");
  self endon(#"hash_23e6132220ac0e4d");
  animloop = level.player_actions.anims[self.animname][var_eea30707];
  self thread animation::play(animloop, self.origin, self.angles, 1, blendtime, blendtime);
  self.var_d621e6d6 = animloop;

  while(isDefined(animloop)) {
    self setanimtime(animloop, 0);
    animlength = getanimlength(animloop);
    wait animlength;
  }
}

function function_47ffa6b8(var_b56433f8) {
  suffix = "";

  if(is_true(self.var_de5476af)) {
    suffix += "_ads";
  }

  suffix += "_loop";

  if(self function_bda1ed48()) {
    suffix += "_walk";
  }

  return var_b56433f8 + suffix;
}

function function_462c34d0(action, scene_root, anim_name, victim, phase) {
  assert(isPlayer(self));
  key = actions::function_4e61a046(action.name, phase);
  var_b3d30f5f = undefined;

  if(isDefined(victim) && isDefined(victim.var_9d46265b) && isDefined(victim.var_9d46265b[key])) {
    var_b3d30f5f = victim.var_9d46265b[key];
  } else if(isDefined(self.var_9d46265b) && isDefined(self.var_9d46265b[key])) {
    var_b3d30f5f = self.var_9d46265b[key];
  } else if(isDefined(level.var_9d46265b) && isDefined(level.var_9d46265b[key])) {
    var_b3d30f5f = level.var_9d46265b[key];
  }

  result = spawnStruct();
  result.anim_name = anim_name;
  result.scene_root = scene_root;
  result.var_da0c6cb = 0;
  result.blend_time = 0.2;

  if(isDefined(var_b3d30f5f)) {
    result.anim_name = var_b3d30f5f[0];

    if(isDefined(var_b3d30f5f[1])) {
      result.scene_root = var_b3d30f5f[1];
      result.var_5e5653b2 = 1;
    }

    result.var_da0c6cb = 1;
  }

  var_386b7517 = self.var_6639d45b.animname;

  if(isDefined(level.player_actions.blend[var_386b7517]) && isDefined(level.player_actions.blend[var_386b7517][result.anim_name])) {
    result.blend_time = level.player_actions.blend[var_386b7517][result.anim_name];
    result.var_7d26075f = 1;
  }

  return result;
}

function function_4cbb6ca7(anim_name, var_f09f326c) {
  assert(isPlayer(self));
  assert(isDefined(self.var_6639d45b));
  player_arms = self.var_6639d45b;

  if(!isarray(var_f09f326c)) {
    var_d89d1589 = [];

    if(isDefined(level.player_actions.blend[#"generic"])) {
      var_d89d1589[#"generic"] = level.player_actions.blend[#"generic"][anim_name];
    }

    if(isDefined(level.player_actions.blend[player_arms.animname])) {
      var_d89d1589[player_arms.animname] = level.player_actions.blend[player_arms.animname][anim_name];
    }

    level.player_actions.blend[#"generic"][anim_name] = var_f09f326c;
    level.player_actions.blend[player_arms.animname][anim_name] = var_f09f326c;
    return var_d89d1589;
  } else {
    level.player_actions.blend[#"generic"][anim_name] = var_f09f326c[#"generic"];
    level.player_actions.blend[player_arms.animname][anim_name] = var_f09f326c[player_arms.animname];
  }

  return undefined;
}

function function_1c2992ed(enabled) {
  var_49b6c927 = is_true(self clientfield::get_to_player("fake_ads"));
  var_4f735d6e = is_true(enabled);

  if(var_4f735d6e && !var_49b6c927) {
    self clientfield::set_to_player("fake_ads", 1);
    self easing::ease_dvar("bg_aimSpreadScale", 1, 0.2, 0.2, #"sine");
    self capturnrate(45, 90);
    return;
  }

  if(!var_4f735d6e && var_49b6c927) {
    self clientfield::set_to_player("fake_ads", 0);
    self easing::ease_dvar("bg_aimSpreadScale", 1, 1, 0.2, #"sine");
    self capturnrate(90, 260);
  }
}

function function_6e8e5902(ender) {
  self notify(#"hash_420f563c810c5f2c");
  self endon(#"hash_420f563c810c5f2c");
  result = self waittill(ender, #"hash_4a7c2a6c1d3c2382", #"level_restarting");

  if(result._notify !== "level_restarting") {
    self thread function_1c2992ed(0);
  } else {
    setsaveddvar(#"bg_aimspreadscale", 1);
  }

  self capturnrate(0, 0);
}

function function_7920d338(notifyevent) {
  self endon(notifyevent, #"disconnect");
  waitframe(1);

  while(self getcurrentweapon().basename == "none") {
    waitframe(1);
  }

  while(self getweaponammoclip(self getcurrentweapon()) > 0) {
    waitframe(1);
  }

  self notify(notifyevent);
}

function function_98f117ad(var_36a368e3, type = "") {
  if(type.size > 0) {
    type = "_" + type;
  }

  weap = self getcurrentweapon();
  suffix = "_rifle";

  if(weapons::islauncher(weap) && type == "_ads") {
    suffix = "_rpg";
  }

  return var_36a368e3 + suffix + type;
}

function function_35d0bd11(var_4b5540a0) {
  assert(isai(self));
  self flag::clear("stealth_enabled");

  if(is_true(var_4b5540a0)) {
    self.ignoreall = 1;
    self.ignoreme = 1;
    self battlechatter::function_2ab9360b(0);
    self notsolid();
    self clearenemy();
    self setgoal(self.origin);
    self thread function_91639a4c(1);
    self animcustom(&function_e9aef609);
    self.var_4b5540a0 = 1;
    return;
  }

  self.ignoreme = 0;
  self battlechatter::function_2ab9360b(1);
  self util::delay(float(function_60d95f53()) / 1000, undefined, &solid);
  self setgoal(self.origin);
  self thread function_91639a4c(0);

  if(isDefined(self.magic_bullet_shield)) {
    self util::stop_magic_bullet_shield();
  }

  self.var_4b5540a0 = undefined;
}

function function_e9aef609() {
  self endon(#"killanimscript");
  self animmode("nogravity");
  self waittill(#"never");
}

function function_c0f7b46e(fullbody, clearanims, linktype = 1) {
  assert(isPlayer(self));

  if(!isDefined(self.var_6639d45b)) {
    self.var_6639d45b = spawn("script_model", self.origin);

    if(isDefined(self.var_6639d45b)) {
      self.var_6639d45b.angles = self.angles;
      self.var_6639d45b useanimtree("generic");
      self.var_6639d45b.animname = "player";
      self.var_6639d45b notsolid();
      self.var_6639d45b hide();
      self.var_6639d45b.health = 100;
      self.var_6639d45b setowner(self);
      self.var_6639d45b.team = self.team;
    }
  }

  var_41206ae3 = self function_5d23af5b();

  if(isDefined(var_41206ae3)) {
    self.var_6639d45b setModel(var_41206ae3);
  }

  var_b4d88433 = self function_cde23658();

  if(isDefined(self.var_6639d45b.var_b4d88433)) {
    self.var_6639d45b detach(self.var_6639d45b.var_b4d88433);
    self.var_6639d45b.var_b4d88433 = undefined;
  }

  if(is_true(clearanims) && isDefined(var_b4d88433)) {
    self.var_6639d45b attach(var_b4d88433);
    self.var_6639d45b.var_b4d88433 = var_b4d88433;
  }

  self.var_6639d45b function_b82cae8f(linktype);
  self.var_6639d45b function_1fac41e4(self function_19124308());
  self.var_6639d45b hide();
  return self.var_6639d45b;
}

function function_464d0412(fullbody, player_arms, clearanims, linktype) {
  assert(isPlayer(self));
  self function_c0f7b46e(fullbody, clearanims, linktype);

  if(!isDefined(player_arms)) {
    player_arms = self.var_6639d45b;
  }

  if(isDefined(player_arms)) {
    player_arms show();
  }
}

function function_76e2ec80(player_arms) {
  assert(isPlayer(self));

  if(!isDefined(player_arms)) {
    player_arms = self.var_6639d45b;
  }

  if(isDefined(player_arms)) {
    player_arms hide();
    player_arms function_1e132b9f();
  }
}

function function_b0190b65(action) {
  assert(isPlayer(self));
  self.takedown.var_84ade654 = 1;
  curweap = self getcurrentweapon();

  if(isDefined(curweap) && curweap.name !== # "none") {
    self.last_weapon = curweap;
  }

  self.takedown.stance[action.name] = self getstance();
  self setstance("stand");
  self val::set(#"hash_16b14161e87e9ac4", "allow_crouch", 0);
  self val::set(#"hash_16b14161e87e9ac4", "allow_prone", 0);
  self gesture_play("ges_body_shield_gundown_quick");
  self function_9d7828b0(0.5);
}

function function_9d7828b0(delay) {
  self util::delay(delay, "stop_disable_weapons_offscreen", &function_5faaaecd);
}

function function_5faaaecd() {
  self function_6179ffe7(self getcurrentweapon());
  self val::set(#"hash_58b9fd1cfcf4a27d", "disable_weapons", 2);
  wait 0.5;

  if(isDefined(self.var_621f8539)) {
    self thread gesture_stop(self.var_621f8539);
  }
}

function function_44a46209(var_d8ba335a) {
  assert(isPlayer(self));
  self val::reset_all(#"hash_16b14161e87e9ac4");

  if(!is_true(self.takedown.var_84ade654)) {
    return;
  }

  if(!self.var_6639d45b function_30b535ff(0)) {
    self function_76e2ec80();
  }

  if(isDefined(var_d8ba335a)) {
    self setstance(var_d8ba335a);
  }

  self.takedown.var_84ade654 = undefined;
  self val::reset_all(#"hash_58b9fd1cfcf4a27d");
}

function gesture_play(gesture = "", target, ignore_state, blendtime, starttime, canceltrans, stopall) {
  if(isgesture(gesture)) {
    self thread function_6f3e9127(gesture, target, ignore_state, blendtime, starttime, canceltrans, stopall);
    return;
  }

  iprintln("<dev string:x38>" + gesture + "<dev string:x51>");
}

function function_b56ad054() {
  self.takedown.var_adad6efa = 1;
}

function private function_6f3e9127(gesture, target, ignore_state, blendtime, starttime, canceltrans, stopall) {
  self notify("39ccfd1ac8ddccb");
  self endon("39ccfd1ac8ddccb");
  assert(isgesture(target));
  self endon(target + "_stop");
  var_66f0ae81 = undefined;

  if(is_true(self.takedown.var_adad6efa)) {
    self.takedown.var_adad6efa = undefined;
    self function_44a46209();
  }

  while(self function_b2ec14ab()) {
    waitframe(1);
    var_66f0ae81 = 1;
  }

  if(is_true(var_66f0ae81)) {
    waitframe(1);
  }

  self playgestureviewmodel(target, ignore_state, blendtime, 0, starttime, canceltrans, stopall);
}

function gesture_stop(gesture, outtime, canceltrans) {
  if(!isDefined(outtime)) {
    return;
  }

  if(isDefined(outtime) && isgesture(outtime)) {
    self notify(outtime + "_stop");
    self stopgestureviewmodel(outtime, 0, canceltrans);
    return;
  }

  if(isDefined(outtime)) {
    iprintln("<dev string:x38>" + outtime + "<dev string:x51>");
  }
}

function scene_play(scene, player, victim) {
  a_ents = [];
  a_ents[#"player"] = player;
  a_ents[#"victim"] = victim;

  if(isDefined(level.takedowns)) {
    level.takedowns.scene = scene;
    level.takedowns.scene_root = self;
  }

  self scene::play(scene, a_ents);
}

function scene_stop() {
  if(isDefined(level.takedowns.scene) && isDefined(level.takedowns.scene_root)) {
    level.takedowns.scene_root scene::stop(level.takedowns.scene);
  }
}

function function_91639a4c(var_ee1fe147) {
  self notify("2cb5a47e02c20ef");
  self endon("2cb5a47e02c20ef");
  self function_a17b179f(var_ee1fe147);

  if(is_true(var_ee1fe147)) {
    self endon(#"death");
    self waittill(#"hash_7884feb21ff33557");
    self.var_d5bd339b = 1;
    return;
  }

  self.var_d5bd339b = undefined;
}

function function_71180c30(isolated) {
  if(!isDefined(self)) {
    return;
  }

  assert(isactor(self));
  victim = self;

  if(is_true(isolated) && !isDefined(victim.var_419b4b2)) {
    victim flag::set("in_action");
    victim.var_419b4b2 = spawnStruct();
    victim.var_419b4b2.ignoreall = victim.ignoreall;
    victim.var_419b4b2.ignoreme = victim.ignoreme;
    victim.var_419b4b2.var_6eed8aea = victim.var_6eed8aea;
    victim.var_419b4b2.magic_bullet_shield = victim.magic_bullet_shield;
    victim.var_419b4b2.dontattackme = victim.dontattackme;
    victim.var_419b4b2.diequietly = victim.diequietly;
    victim.var_419b4b2.var_e9c62827 = victim.var_e9c62827;
    victim.var_419b4b2.var_3544dda3 = victim flag::get("scripted_lookat_disable");
    victim thread function_91639a4c(1);
    victim flag::set("scripted_lookat_disable");
    victim.ignoreall = 1;
    victim.ignoreme = 1;
    victim.syncedmeleetarget = undefined;
    victim.var_6eed8aea = 0;
    victim.dontattackme = 1;
    victim.diequietly = 1;

    if(isDefined(victim.var_d26a48de)) {
      victim[[victim.var_d26a48de]]();
    }

    victim.var_419b4b2.var_c2eaacf4 = victim spawner::function_461ce3e9();
    victim notify(#"killanimscript");

    if(!is_true(victim.delayeddeath)) {
      victim thread util::magic_bullet_shield();
    }

    victim lookatpos(undefined);
    victim notsolid();
    victim setforcenocull();
    victim.var_e9c62827 = 1;
    return;
  }

  if(isDefined(victim.var_419b4b2)) {
    victim thread function_91639a4c(0);
    victim.ignoreall = victim.var_419b4b2.ignoreall;
    victim.ignoreme = victim.var_419b4b2.ignoreme;
    victim.var_6eed8aea = victim.var_419b4b2.var_6eed8aea;
    victim.in_melee_death = undefined;
    victim solid();
    victim removeforcenocull();
    victim.var_e9c62827 = victim.var_419b4b2.var_e9c62827;
    victim.dontattackme = victim.var_419b4b2.dontattackme;
    victim.diequietly = victim.var_419b4b2.diequietly;

    if(!is_true(victim.var_419b4b2.var_3544dda3)) {
      victim flag::clear("scripted_lookat_disable");
    }

    if(!is_true(victim.var_419b4b2.magic_bullet_shield)) {
      victim thread util::stop_magic_bullet_shield();
    }

    if(isDefined(victim.var_419b4b2.var_c2eaacf4)) {
      victim spawner::go_to_node(victim.var_419b4b2.var_c2eaacf4);
    }

    victim.var_419b4b2 = undefined;
    victim flag::clear("in_action");
    getplayers()[0] actions::function_942d9213();
  }
}

function function_1a2a3654() {
  assert(isPlayer(self));
  currentweapon = self getcurrentweapon();

  if(!function_a06867b0(currentweapon)) {
    return currentweapon;
  }

  result = undefined;
  resultammo = -1;

  foreach(weapon in self getweaponslist()) {
    if(weapon !== currentweapon && !function_a06867b0(weapon)) {
      weaponammo = self getweaponammoclip(weapon);

      if(!isDefined(result) || weaponammo > resultammo) {
        result = weapon;
        resultammo = weaponammo;
      }
    }
  }

  return result;
}

function function_a06867b0(weapon) {
  if(!isweapon(weapon)) {
    return true;
  }

  if(is_true(weapon.isboltaction)) {
    return true;
  }

  if(is_true(weapon.isgrenadeweapon)) {
    return true;
  }

  if(isDefined(level.var_e3f5eafc) && weapon === level.var_e3f5eafc) {
    return true;
  }

  if(isDefined(level.var_42db149f) && weapon === level.var_42db149f) {
    return true;
  }

  if(weapon.name == # "launcher_freefire_t9" || weapon.name == # "hash_1e25706a023b5e09" || weapon.name == # "launcher_freefire_t9_upgraded") {
    return true;
  }

  return false;
}

function function_1c2cb657(weapon) {
  if(!isweapon(weapon)) {
    return false;
  }

  if(!is_true(weapon.ismeleeweapon) && (!is_true(weapon.isbulletweapon) || is_true(weapon.issniperweapon))) {
    return true;
  }

  return false;
}

function function_1fac6486(weapon) {
  if(!isweapon(weapon)) {
    return false;
  }

  if(is_true(weapon.ismeleeweapon) && !is_true(weapon.isbulletweapon)) {
    return true;
  }

  return false;
}

function function_396e2076(var_860605de = 1, var_4170b151 = 1, do_wait = 0) {
  result = 0;
  e_player = getplayers()[0];

  if(is_true(var_860605de) && e_player flag::get("body_shield_active")) {
    result = 1;
    assert(isDefined(e_player.takedown.body_shield.actor) && isai(e_player.takedown.body_shield.actor), "<dev string:x57>");
    e_player.takedown.body_shield.actor delete();

    if(do_wait) {
      wait 2.75;
    }
  } else if(is_true(var_4170b151)) {
    result = isDefined(e_player.takedown.body);
    level notify(#"drop_corpse");

    if(do_wait && result) {
      wait 1.25;
    }
  }

  return result;
}

function function_e2fcacb2(time = 3) {
  self thread function_cc15d11(time);
}

function private function_cc15d11(time) {
  self notify("9aa41f49060e5fb");
  self endon("9aa41f49060e5fb");
  assert(isPlayer(self));
  self endon(#"death");

  if(time > 0) {
    self val::set(#"hash_1ac08695042a6154", "disablegadgets", 1);
    wait time;
  }

  self val::reset_all(#"hash_1ac08695042a6154");
}

function function_29fd0abd() {
  assert(isPlayer(self));
  curweap = self getcurrentweapon();

  if(!is_true(curweap.aimdownsight)) {
    return 0;
  }

  return self adsButtonPressed();
}

function function_d76eed10(action) {
  assert(isPlayer(self));
  step = 10;
  trace_pos = playerphysicstrace(self.origin + (0, 0, 1), self.origin);

  if(trace_pos != self.origin) {
    trace_pos = playerphysicstrace(self.takedown.start_origin + (0, 0, step), self.origin + (0, 0, step));

    if(trace_pos[0] != self.origin[0] || trace_pos[1] != self.origin[1]) {
      trace_pos += vectornormalize(self.takedown.start_origin - self.origin);
    }

    trace_pos = playerphysicstrace(trace_pos, trace_pos - (0, 0, step));
    var_f5aab51b = playerphysicstrace(trace_pos + (0, 0, 1), trace_pos);

    if(trace_pos != var_f5aab51b) {
      msg = "<dev string:xa6>" + action.name + "<dev string:xaa>" + self.takedown.start_origin[0] + "<dev string:xe1>" + self.takedown.start_origin[1] + "<dev string:xe1>" + self.takedown.start_origin[2] + "<dev string:xe7>";
      iprintlnbold(msg);
      println(msg + "<dev string:xed>");

      trace_pos = self.takedown.start_origin;
    }

    self setorigin(trace_pos);
  }
}

function function_fdff1cf3(forwarddist = 30) {
  assert(isDefined(self.takedown));

  if(!isDefined(self.takedown.var_b44d4135)) {
    self.takedown.var_b44d4135 = [];
  }

  if(!isDefined(self.takedown.var_b187389a)) {
    self.takedown.var_b187389a = [];
  }

  if(isDefined(self.takedown.var_b44d4135[forwarddist]) && gettime() == self.takedown.var_b44d4135[forwarddist]) {
    return self.takedown.var_b187389a[forwarddist];
  }

  zoffset = (0, 0, 8);
  start = self.origin + zoffset;
  end = start + anglesToForward(self.angles) * forwarddist + zoffset;
  self.takedown.var_b187389a[forwarddist] = 0;
  radius = 15;
  trace = physicstrace(start, end, (radius * -1, radius * -1, 0), (radius, radius, 70), undefined, 32 | 1, 32768 | 8388608);

  if(trace[#"fraction"] == 1) {
    self.takedown.var_b187389a[forwarddist] = 1;
  }

  self.takedown.var_b44d4135[forwarddist] = gettime();
  return self.takedown.var_b187389a[forwarddist];
}