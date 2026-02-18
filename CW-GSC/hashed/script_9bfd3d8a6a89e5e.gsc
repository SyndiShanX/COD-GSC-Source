/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_9bfd3d8a6a89e5e.gsc
***********************************************/

#using script_3626f1b2cf51a99c;
#using script_3d18e87594285298;
#using script_3dc93ca9902a9cda;
#using script_52da18c20f45c56a;
#using script_5431e074c1428743;
#using scripts\core_common\animation_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\achievements;
#using scripts\cp_common\bb;
#using scripts\cp_common\ui\prompts;
#namespace namespace_6cecf2d8;

function private autoexec __init__system__() {
  system::register(#"hash_7ee44bf733d7a7ac", &preinit, undefined, undefined, #"hash_7e93e9089f28804f");
}

function private preinit() {
  if(!isDefined(level.body_shield)) {
    level.body_shield = spawnStruct();
    actions::action_register("body_shield", &function_53e50b40, "takedown", "grab");
    actions::function_b1543a9d("body_shield", "td_anims_body_shield");
    animation::add_global_notetrack_handler("start_bodyshield_gesture", &function_89295627, 0);
  }
}

function function_53e50b40(action) {
  self endon(action.ender);

  if(is_true(self actions::function_83bde308(action))) {
    if(self.takedown.var_67582ca5.player_actions.enabled[# "body_shield"] === 0) {
      return false;
    }

    self thread function_e3e4c03c(action, self.takedown.var_67582ca5);
    self.takedown.var_67582ca5 = undefined;
    return true;
  }

  return false;
}

function function_e3e4c03c(action, body) {
  assert(isPlayer(self));

  if(!isDefined(action)) {
    action = level.player_actions.actions[# "body_shield"];
  }

  if(isalive(body)) {
    if(body scene::function_c935c42()) {
      [[body._scene_object._o_scene]] - > stop();
    }

    body stopanimscripted();
  }

  if(!isalive(body)) {
    self actions::function_942d9213();
    return;
  }

  bb::function_cd497743("bodyshield_grab", self);
  victim_scene = self actions::function_abaa32c("body_shield");

  if(!isDefined(victim_scene)) {
    victim_scene = namespace_9c83b58d::function_3c43bd2a(action, body, self);
  }

  if(!isDefined(victim_scene.scene)) {
    return;
  }

  self flag::set("body_shield_active");
  self flag::set("body_shield_gun_up");
  self thread function_257c21b5(action);
  self.var_d3b4e4f4 = &function_fc288808;
  self.var_852e84c9 = &actions::function_e972f9a5;

  if(!isDefined(self.takedown)) {
    self.takedown = spawnStruct();
  }

  self.takedown.body_shield = spawnStruct();
  self.takedown.body_shield.model = body.model;
  self.takedown.body_shield.classname = body.classname;
  self.takedown.body_shield.spawner = body.spawner;
  self.takedown.body_shield.weapons = body.weapons;
  self.takedown.body_shield.aitype = body.aitype;
  self.takedown.body_shield.health = 70;
  self.takedown.body_shield.healthmax = self.takedown.body_shield.health;
  self.takedown.body_shield.var_70faf312 = self.takedown.body_shield.health;
  self.takedown.body_shield.var_ea2da6bc = gettime();

  if(isai(body)) {
    self.takedown.body_shield.actor = body;
    body notify(#"takedown_executed");
  }

  for(i = 0; i < body getattachsize(); i++) {
    self.takedown.body_shield.var_cf230c0[i] = body getattachmodelname(i);
    self.takedown.body_shield.attach_tag[i] = body getattachtagname(i);
  }

  self notify(#"stop_disable_weapons_offscreen");
  self action_utility::allow_weapon(0);
  self.takedown.body = body;
  scene_root = isDefined(victim_scene.scene_root) ? victim_scene.scene_root : self namespace_9c83b58d::function_5169db86();

  if(!isDefined(self.takedown.body.animname)) {
    self.takedown.body.animname = "generic";
  }

  self.takedown.body.var_69defa17 = 1;
  self.takedown.body show();
  self.takedown.body util::delay(0.2, undefined, &prompts::remove_group, #"actions");
  self util::delay(0.5, undefined, &function_40622d99);
  self util::delay(0.2, undefined, &val::set, #"action", "takedamage", 0);
  scene_root action_utility::scene_play(victim_scene.scene, self, body);
  self thread action_utility::function_d76eed10(action);
  self action_utility::function_464d0412();

  if(body !== self.takedown.body) {
    body delete();
  }

  self.in_melee_death = undefined;
  self thread function_a8501d78(action);
}

function private function_40622d99() {
  assert(isPlayer(self));
  self endon(#"death", #"disconnect");
  var_62ba1300 = self action_utility::function_1a2a3654();

  if(var_62ba1300 !== self getcurrentweapon()) {
    self switchtoweaponimmediate(var_62ba1300);
    self hideviewmodel();

    while(self getcurrentweapon() !== var_62ba1300) {
      waitframe(1);
    }

    self util::delay(0.2, undefined, &showviewmodel);
    self action_utility::gesture_play(self.var_621f8539, undefined, undefined, undefined, undefined, 1);
  }
}

function function_ead8fde7(active) {
  self.var_108942e2 = is_true(active) ? 1 : undefined;
}

function function_fc288808(quick) {
  if(self flag::get("body_shield_gun_up")) {
    self action_utility::allow_weapon(1, 1, self action_utility::function_98f117ad("ges_body_shield"));
    return;
  }

  self action_utility::allow_weapon(1, 1);
}

function function_a8501d78(action) {
  self endon(action.ender);
  assert(isPlayer(self));
  self flag::clear("body_shield_gun_up");
  self action_utility::function_e2fcacb2(3);
  achievements::function_533e57d6(self, 1);
  override = self actions::function_abaa32c("body_shield");
  var_df227d8a = actions::function_1028d928(action.name, "a");

  if(var_df227d8a) {
    self childthread namespace_e1cd3aae::function_d521a78f();
  }

  self function_ead8fde7(action.name == "body_shield");
  self val::set(#"action", "takedamage", 1);
  self action_utility::allow_weapon(1);
  self action_utility::function_2795d678(1, 1, 0, 0, ["cinematicmotion_body_shield", "cinematicmotion_body_shield_ads"]);
  self.takedown.body_shield.actor action_utility::function_35d0bd11(1);
  self.takedown.body show();
  self.takedown.body linkto(self, "tag_origin", (-1000, 0, 0), (0, 0, 0));
  self.takedown.body action_utility::function_b82cae8f(1);
  self thread function_756e29bb(action, isDefined(override.anim_name) ? override.anim_name : action.anim_name);
  self.takedown.scene_root = undefined;
  self childthread function_c6059aa(action);
  self childthread function_c13ab5c7(action);
  self childthread function_7acc6ae7(action);
  self childthread function_e98922fb(action);

  if(var_df227d8a) {
    self util::delay(0.2, undefined, &actions::function_3af7d065, 1);
  }
}

function function_89295627() {
  player = getplayers()[0];
}

function function_756e29bb(action, anim_name, var_c09e9b1c, var_d60fb210, var_2e7da7fb, var_7369af2b) {
  self notify("250887938b7d1675");
  self endon("250887938b7d1675");
  self endoncallback(&function_d6fbc26, action.ender, #"hash_6e2a24679f8eca8e");

  if(isDefined(var_d60fb210)) {
    self endon(var_d60fb210);
  }

  self.var_de5476af = undefined;
  self.var_a7f1f0d6 = undefined;
  transtime = isDefined(var_7369af2b) ? var_7369af2b : 0.05;
  weapon = self getcurrentweapon();
  var_36a368e3 = "ges_body_shield";

  if(isDefined(var_c09e9b1c)) {
    var_36a368e3 = var_c09e9b1c;
  }

  gesture = self action_utility::function_98f117ad(var_36a368e3);
  gestureads = self action_utility::function_98f117ad(var_36a368e3, "ads");
  firstframe = 1;
  self thread action_utility::function_6e8e5902(action.ender);
  self childthread function_2513e926(action);

  if(!is_true(var_2e7da7fb)) {
    self childthread function_80f856a8(action, anim_name, var_7369af2b);
  }

  self childthread function_8ebed231(action);

  while(true) {
    adspressed = self action_utility::function_29fd0abd();
    var_fcd67307 = self action_utility::function_bda1ed48();
    doreload = self function_1dcff2c3(weapon);

    if(!doreload && (adspressed !== self.var_de5476af || var_fcd67307 !== self.var_a7f1f0d6)) {
      var_adb7de30 = undefined;

      if(adspressed !== self.var_de5476af) {
        if(adspressed) {
          self action_utility::gesture_play(gestureads, undefined, 1, transtime);
          self.takedown.gesture = gestureads;

          if(isDefined(self.var_de5476af)) {
            var_adb7de30 = "_ads_in";
          }
        } else {
          self action_utility::gesture_play(gesture, undefined, 1, transtime);
          self.takedown.gesture = gesture;

          if(isDefined(self.var_de5476af)) {
            var_adb7de30 = "_ads_out";
          }
        }
      }

      self.var_de5476af = adspressed;
      self.var_a7f1f0d6 = var_fcd67307;

      if(!is_true(var_2e7da7fb)) {
        transtime = 0.2;

        if(firstframe) {
          firstframe = 0;
          waitframe(1);
          continue;
        }

        if(isDefined(var_adb7de30)) {
          if(isDefined(self.takedown.body)) {
            self.takedown.body thread action_utility::function_3f4de57b(anim_name + var_adb7de30);
          }

          if(isDefined(self.var_6639d45b)) {
            if(doreload) {
              self.var_6639d45b thread action_utility::function_3f4de57b(anim_name + var_adb7de30);
            } else {
              self.var_6639d45b action_utility::function_3f4de57b(anim_name + var_adb7de30);
            }
          }

          self.var_a7f1f0d6 = undefined;
        }
      }
    }

    if(doreload) {
      self function_501ef65d(weapon);
      self action_utility::gesture_stop(gestureads, 0, 1);
      self action_utility::gesture_stop(gesture, 0, 1);
      self.var_de5476af = undefined;
      self.var_a7f1f0d6 = undefined;
    }

    waitframe(1);
  }
}

function function_2513e926(action) {
  while(true) {
    self thread action_utility::function_1c2992ed(self action_utility::function_29fd0abd());
    waitframe(1);
  }
}

function function_80f856a8(action, anim_name, var_7369af2b) {
  firstframe = 1;

  while(true) {
    loop_anim = action_utility::function_47ffa6b8(var_7369af2b);

    if(!isDefined(self.var_6639d45b.var_3f4de57b)) {
      blendtime = firstframe ? 0 : undefined;

      if(isDefined(self.takedown.body)) {
        self.takedown.body thread action_utility::function_d621e6d6(loop_anim, blendtime);
      }

      if(isDefined(self.var_6639d45b)) {
        self.var_6639d45b thread action_utility::function_d621e6d6(loop_anim, blendtime);
      }
    }

    firstframe = 0;
    waitframe(1);
  }
}

function function_d6fbc26(params) {
  self thread action_utility::function_1c2992ed(0);
}

function function_8ebed231(action) {
  visible = 1;

  while(true) {
    var_2d6631c2 = 1;

    if(self flag::get("snipercam")) {
      var_2d6631c2 = 0;
    }

    if(var_2d6631c2 != visible) {
      if(var_2d6631c2) {
        if(isDefined(self.takedown.body)) {
          self.takedown.body show();
        }

        if(isDefined(self.var_6639d45b)) {
          self.var_6639d45b show();
        }
      } else {
        if(isDefined(self.takedown.body)) {
          self.takedown.body hide();
        }

        if(isDefined(self.var_6639d45b)) {
          self.var_6639d45b hide();
        }
      }

      visible = var_2d6631c2;
    }

    waitframe(1);
  }
}

function function_501ef65d(weapon) {
  self action_utility::allow_weapon(0, undefined, "ges_body_shield_reload");
  var_5a130b17 = self getweaponammostock(weapon);
  ammo_in_clip = self getweaponammoclip(weapon);
  wait 0.5;

  switch (weapon.weapclass) {
    case # "pistol":
      snd::play("fly_bodyshield_reload_pistol");
      wait 0.5;
      break;
    case # "smg":
      snd::play("fly_bodyshield_reload_smg");
      wait 0.7;
      break;
    case # "rifle":
      snd::play("fly_bodyshield_reload_rifle");
      wait 0.7;
      break;
    case # "sniper":
      snd::play("fly_bodyshield_reload_smg");
      wait 1;
      break;
    case # "shotgun":
      snd::play("fly_bodyshield_reload_shotgun");
      wait 1;
      break;
    default:
      snd::play("fly_bodyshield_reload_lmg");
      wait 2;
      break;
  }

  delta = min(var_5a130b17, weapon.clipsize - ammo_in_clip);

  if(self hasweapon(weapon)) {
    self setweaponammoclip(weapon, int(ammo_in_clip + delta));
    self setweaponammostock(weapon, int(var_5a130b17 - delta));
  }

  self action_utility::allow_weapon(1);
}

function function_1dcff2c3(weapon) {
  if(is_true(weapon.iscliponly)) {
    return 0;
  }

  if(!isDefined(self.takedown.var_6cf436f)) {
    self.takedown.var_6cf436f = 0;
  }

  clip_size = weapon.clipsize;
  ammo_in_clip = self getweaponammoclip(weapon);
  var_5a130b17 = self getweaponammostock(weapon);
  var_b8b29a85 = var_5a130b17 > 0 && ammo_in_clip < clip_size;
  self.takedown.showreload = var_b8b29a85 && ammo_in_clip < clip_size * 0.33;

  if(ammo_in_clip == 0) {
    self.takedown.var_6cf436f += float(function_60d95f53()) / 1000;
  } else {
    self.takedown.var_6cf436f = 0;
  }

  doreload = var_b8b29a85 && (self.takedown.var_6cf436f > 0.2 || self reloadbuttonPressed());
  return doreload;
}

function function_f6dd3d45(prompt_struct) {
  return isDefined(self.takedown.showreload) && is_true(self.takedown.showreload);
}

function function_9c53ef0a() {
  self function_f077863a("ges_body_shield_rifle");
  self function_f077863a("ges_body_shield_rifle_ads");
  self function_f077863a("ges_body_shield_rpg_ads");
  self notify(#"hash_6e2a24679f8eca8e");
  self action_utility::gesture_stop();
}

function function_257c21b5(action, immediate) {
  self endon(#"hash_28d504c4e7c5eef0");

  if(!is_true(immediate)) {
    self waittill(action.ender);
  }

  self prompts::remove(#"reload");
  self function_ead8fde7(0);
  self.var_de5476af = undefined;
  self.var_a7f1f0d6 = undefined;
  self function_9c53ef0a();
  self val::reset_all(#"action");
  self action_utility::function_e2fcacb2(3);
  self flag::clear("body_shield_active");
  self.in_melee_death = undefined;

  if(is_true(action.var_43769020)) {
    action_utility::function_3fbe0931(action);
  }

  self notify(#"hash_28d504c4e7c5eef0");
}

function function_f077863a(gesture) {
  if(isDefined(self.takedown.gesture_hold) && self.takedown.gesture_hold == gesture) {
    self.takedown.gesture_hold = undefined;
    return;
  }

  self action_utility::gesture_stop(gesture, 0.01, 1);
}

function function_7acc6ae7(action) {
  self endon(action.ender, #"hash_2d036a7855e382b1");
  self waittill(#"death", #"hash_2b62b2990144ebf6");

  if(isDefined(self.takedown.body)) {
    self.takedown.body hide();
  }

  self action_utility::function_76e2ec80();
}

function function_c13ab5c7(action) {
  self endon(action.ender, #"hash_2d036a7855e382b1");

  while(true) {
    result = self waittill(#"body_shield_damage");
    min_time = 2;
    time_slice = 300;
    var_6f8dfb10 = self.takedown.body_shield.healthmax / min_time;
    var_7ac1bcf6 = var_6f8dfb10 / 1000 / float(time_slice);
    new_health = self.takedown.body_shield.health - result.idamage;
    new_health = max(new_health, self.takedown.body_shield.var_70faf312 - var_7ac1bcf6);

    if(gettime() - self.takedown.body_shield.var_ea2da6bc > time_slice) {
      self.takedown.body_shield.var_70faf312 = new_health;
      self.takedown.body_shield.var_ea2da6bc = gettime();
    }

    self.takedown.body_shield.var_13356219 = 1;
    self.takedown.body_shield.health = new_health;
    self notify(#"hash_3cc22522d66c35f8");
    playFX("blood/fx9_takedowns_blood_bdyshld_impact_rnr", result.vpoint, anglesToForward(self.angles), anglestoup(self.angles));
    screenshake(self.origin, randomintrange(1, 2), 0, 0, 0.5, 0, 0.5, 0, 5, 0, 0, 2);
    snd::play("evt_sys_cp_bodyshield_impact", level.player);
    thread function_a74e8dd3();

    if(self.takedown.body_shield.health <= 0) {
      self notify(#"hash_244459f2eb8f0a38");
      return;
    }

    self childthread action_utility::function_aee5f6a6("body_shield");
  }
}

function function_e98922fb(action) {
  self endon(action.ender, #"hash_2d036a7855e382b1");
  wait 5;

  while(true) {
    result = self waittilltimeout(1, #"body_shield_damage");

    if(result._notify != "body_shield_damage") {
      self.takedown.body_shield.health -= 7;
      self.takedown.body_shield.var_70faf312 = self.takedown.body_shield.health;
      self.takedown.body_shield.var_ea2da6bc = gettime();
      self notify(#"hash_3cc22522d66c35f8");

      if(self.takedown.body_shield.health <= 0) {
        self notify(#"hash_244459f2eb8f0a38");
        return;
      }
    }
  }
}

function function_bec58af5() {
  assert(isPlayer(self));

  if(isDefined(self.takedown.body_shield) && isDefined(self.takedown.body_shield.actor)) {
    self.takedown.body_shield.actor delete();
    self.takedown.body_shield.actor = undefined;
  }
}

function function_9fa1a484() {
  assert(isPlayer(self));

  if(!isDefined(self.takedown.body_shield.actor)) {
    return;
  }

  if(!self flag::get("body_shield_active")) {
    return;
  }

  self.takedown.body_shield.actor delete();
  self waittill(#"hash_2a87a221154d292");
}

function function_b25119b6(action) {
  assert(isPlayer(self));

  if(!isDefined(self.takedown.body_shield)) {
    return;
  }

  if(!self flag::get("body_shield_active")) {
    return;
  }

  self function_bec58af5();
  self function_257c21b5(action, 1);
  self.takedown.body delete();
  self.takedown.body = undefined;
  self action_utility::function_2795d678(0);
  self actions::function_942d9213();
}

function function_c6059aa(action) {
  self endon(#"death", action.ender);
  self prompts::function_82cf95d9(#"uie_ui_hud_cp_body_shield");

  while(true) {
    var_4109ff8e = self.takedown.body_shield.health / self.takedown.body_shield.healthmax;

    if(isDefined(self.var_3e95b88f)) {
      self prompts::function_b1cfa4bc(var_4109ff8e);
    }

    if(var_4109ff8e <= 0) {
      if(isDefined(self.var_3e95b88f)) {
        self prompts::function_82cf95d9(#"uie_ui_hud_cp_body_shield_skull");
      }

      break;
    }

    self waittill(#"hash_3cc22522d66c35f8");
  }
}

function function_a74e8dd3() {
  waittime = randomfloatrange(0.2, 0.6);
  wait waittime;
  snd::play("evt_sys_cp_bodyshield_impact_gore", level.player);
}