/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\cp\spy_camera.gsc
***********************************************/

#using script_13114d8a31c6152a;
#using script_35ae72be7b4fec10;
#using script_37f9ff47f340fbe8;
#using script_4937c6974f43bb71;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\util;
#namespace spy_camera;

function private autoexec __init__system__() {
  system::register("spy_camera", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_weapon_change(&on_weapon_change);
  callback::on_spawned(&function_ab7ec803);
  clientfield::register("toplayer", "spy_camera_state", 1, 2, "int");
  clientfield::register("toplayer", "binoculars_overlay", 1, 1, "int");
  clientfield::register("toplayer", "spy_camera_tagging", 1, 1, "int");
  clientfield::register("actor", "spy_camera_remove_highlight", 1, 1, "int");
  var_1e935eba = array("actor", "scriptmover");

  foreach(str_type in var_1e935eba) {
    clientfield::register(str_type, "spy_camera_object_of_interest", 1, 2, "int");
  }

  level.var_e3f5eafc = getweapon("eq_spy_camera");
  level.var_42db149f = getweapon("eq_binoculars");
}

function function_f785d9e9(objects, var_7eb1c6be = 0, var_354b19f1) {
  if(!isDefined(objects)) {
    objects = [];
  } else if(!isarray(objects)) {
    objects = array(objects);
  }

  val = 1;

  if(var_7eb1c6be) {
    val = 2;
  }

  foreach(object in objects) {
    object clientfield::set("spy_camera_object_of_interest", val);
    object thread function_654fa552(var_354b19f1);

    if(var_7eb1c6be) {
      object thread function_a6928964(var_354b19f1);
    }
  }
}

function private function_654fa552(wz_character_richtofen_wz) {
  self endon(#"death", #"hash_54e0f219fc10204a");
  self waittillmatch({
    #var_aad36d51: 0, #fieldvalue: 1
  }, #"hash_72a5fe161eb7a0ce");
  self notify(#"photo_taken");

  if(isDefined(wz_character_richtofen_wz)) {
    wz_character_richtofen_wz notify(#"photo_taken");
  }
}

function private function_a6928964(wz_character_richtofen_wz) {
  self endon(#"death", #"photo_taken", #"hash_54e0f219fc10204a");

  while(true) {
    self waittillmatch({
      #var_aad36d51: 0, #fieldvalue: 2
    }, #"hash_72a5fe161eb7a0ce");
    self notify(#"hash_54596dc066040d8c");

    if(isDefined(wz_character_richtofen_wz)) {
      wz_character_richtofen_wz notify(#"hash_54596dc066040d8c");
    }
  }
}

function function_b28ab5a9(object) {
  object clientfield::set("spy_camera_object_of_interest", 0);
  object notify(#"hash_54e0f219fc10204a");
}

function function_69190c4e() {
  clientfield::set_to_player("spy_camera_tagging", 1);
}

function function_c11bdcc0() {
  clientfield::set_to_player("spy_camera_tagging", 0);
}

function on_weapon_change(params) {
  var_b67a0cc6 = is_true(self.var_340d4e74) || params.last_weapon !== level.weaponnone && (params.last_weapon === level.var_e3f5eafc || params.last_weapon === level.var_42db149f);

  if(var_b67a0cc6 || params.last_weapon === level.weaponnone && self clientfield::get_to_player("spy_camera_state") != 0) {
    self.var_340d4e74 = undefined;
    self thread function_d704edcd(params.last_weapon === level.var_42db149f);
  }

  var_d14812a6 = params.weapon !== level.weaponnone && (params.weapon === level.var_e3f5eafc || params.weapon === level.var_42db149f);

  if(var_d14812a6) {
    var_c5c03b2 = params.weapon === level.var_42db149f;
    ads_gesture = "ges_spy_camera_ads";
    self.var_340d4e74 = 1;

    if(var_c5c03b2) {
      ads_gesture = "ges_binoculars_ads";
    }

    self thread function_b917e313(params.weapon, ads_gesture, var_c5c03b2);
  }
}

function function_ab7ec803() {
  level flag::delay_set(0.1, "flg_spy_cam_player_spawned");
}

function function_6de171e9(slot = 4) {
  assert(level.var_e3f5eafc != level.weaponnone);
  self giveweapon(level.var_e3f5eafc);
  self setactionslot(slot, "weapon", level.var_e3f5eafc);
  self.var_390003ff = slot;
}

function function_8606cd15(slot = 4) {
  assert(level.var_42db149f != level.weaponnone);
  self giveweapon(level.var_42db149f);
  self setactionslot(slot, "weapon", level.var_42db149f);
  self.var_5915e3c5 = slot;
}

function function_b83af2a9() {
  player = undefined;

  if(isPlayer(self)) {
    player = self;
  } else {
    player = getplayers()[0];
  }

  if(player hasweapon(level.var_e3f5eafc)) {
    player takeweapon(level.var_e3f5eafc);
  }

  if(isDefined(player.var_390003ff)) {
    player setactionslot(player.var_390003ff, "");
    player.var_390003ff = undefined;
  }
}

function function_d9015b8c() {
  player = undefined;

  if(isPlayer(self)) {
    player = self;
  } else {
    player = getplayers()[0];
  }

  if(player hasweapon(level.var_42db149f)) {
    player takeweapon(level.var_42db149f);
  }

  if(isDefined(player.var_5915e3c5)) {
    player setactionslot(player.var_5915e3c5, "");
    player.var_5915e3c5 = undefined;
  }
}

function function_f91a82ef(b_enabled = 1, var_b3649521 = # "hash_12be6ba1327c64b1", initial_delay = 8000, var_34487abc) {
  level.var_e3f5eafc.var_f91a82ef = b_enabled;
  level.var_e3f5eafc.var_7d598677 = var_b3649521;
  level.var_e3f5eafc.var_3a0d6cd6 = initial_delay;
  level.var_e3f5eafc.var_257480e5 = var_34487abc;

  if(b_enabled == 0) {
    level flag::wait_till("flg_spy_cam_player_spawned");
    getplayers()[0] thread util::hide_hint_text();
  }
}

function function_de6d9b74(prompts) {
  assert(isarray(prompts) || ishash(prompts));
  level.var_af143f1d = [];

  if(isarray(prompts)) {
    level.var_af143f1d = prompts;
    return;
  }

  if(!isDefined(level.var_af143f1d)) {
    level.var_af143f1d = [];
  } else if(!isarray(level.var_af143f1d)) {
    level.var_af143f1d = array(level.var_af143f1d);
  }

  level.var_af143f1d[level.var_af143f1d.size] = prompts;
}

function private function_b917e313(camera, ads_gesture, var_c5c03b2) {
  self endon(#"death", #"ability_deactivated_camera");

  if(!isDefined(self.spy_camera)) {
    self.spy_camera = spawnStruct();
  }

  var_f94537f6 = 0;
  finished_ads = 0;
  var_ff17ab00 = 0;
  var_697c5b2b = int(2 * 1000);
  var_a05f9c5f = 0;
  var_83cf950f = self getgesturestarttime(ads_gesture, "loop") * 1000;
  var_4308b3d8 = 0;
  was_ads = 0;
  self val::set("spy_camera", "disable_weapon_fire", 1);
  self notify(#"ability_activated_camera");

  if(!var_c5c03b2) {
    self notify(#"hide_camera_equip_hint");
    self thread function_2d8ba5c4();
    setuimodelvalue(getuimodel(function_90d058e8(#"spy_camera"), "stream"), 1);
  } else {
    setuimodelvalue(getuimodel(function_90d058e8(#"spy_camera"), "stream"), 2);
  }

  while(true) {
    if(!self isswitchingweapons() && !self isreloading() && self adsButtonPressed()) {
      if(!was_ads) {
        was_ads = 1;
        self playgestureviewmodel(ads_gesture, undefined, 1);
        var_4308b3d8 = var_83cf950f + gettime();
        finished_ads = 0;
        self notify(#"hash_19f1b179d8ebf1dd");
        self val::set("spy_camera", "freezecontrols_allowlook", 1);
        self val::set("spy_camera", "disable_weapon_cycling", 1);
      } else if(self isgestureplaying(ads_gesture) && gettime() > var_4308b3d8) {
        if(!var_f94537f6) {
          var_f94537f6 = 1;
          self notify(#"hash_59b80e9e535f9788");
        }

        if(var_a05f9c5f != 1) {
          var_a05f9c5f = 1;
          self clientfield::set_to_player("spy_camera_state", 1);
          namespace_82bfe441::fade(1, "FadeFast");

          if(var_c5c03b2) {
            self clientfield::set_to_player("binoculars_overlay", 1);
            namespace_61e6d095::create(#"binoculars", #"hash_1703896731dc6998");
          }

          self thread function_376f686f();
          self hideviewmodel();
          self val::reset("spy_camera", "disable_weapon_fire");
          namespace_c8e236da::removelist();

          if(!isDefined(level.var_af143f1d) || level.var_af143f1d.size == 0) {
            level.var_af143f1d = [];

            if(self gamepadusedlast()) {
              if(!isDefined(level.var_af143f1d)) {
                level.var_af143f1d = [];
              } else if(!isarray(level.var_af143f1d)) {
                level.var_af143f1d = array(level.var_af143f1d);
              }

              level.var_af143f1d[level.var_af143f1d.size] = # "hash_4d41512a9dd19c05";
            } else {
              if(!isDefined(level.var_af143f1d)) {
                level.var_af143f1d = [];
              } else if(!isarray(level.var_af143f1d)) {
                level.var_af143f1d = array(level.var_af143f1d);
              }

              level.var_af143f1d[level.var_af143f1d.size] = # "hash_d4008a2e030bdb1";

              if(!isDefined(level.var_af143f1d)) {
                level.var_af143f1d = [];
              } else if(!isarray(level.var_af143f1d)) {
                level.var_af143f1d = array(level.var_af143f1d);
              }

              level.var_af143f1d[level.var_af143f1d.size] = # "hash_2057dc2d69c5cb2";
            }

            if(!var_c5c03b2) {
              if(!isDefined(level.var_af143f1d)) {
                level.var_af143f1d = [];
              } else if(!isarray(level.var_af143f1d)) {
                level.var_af143f1d = array(level.var_af143f1d);
              }

              level.var_af143f1d[level.var_af143f1d.size] = # "hash_38a90a5154d5fa9a";
            }
          }

          foreach(item in level.var_af143f1d) {
            namespace_c8e236da::function_ebf737f8(item);
          }
        } else if(!var_c5c03b2 && self attackButtonPressed() && gettime() > var_ff17ab00) {
          var_a05f9c5f = 2;
          var_ff17ab00 = var_697c5b2b + gettime();
          self clientfield::set_to_player("spy_camera_state", 2);
          namespace_c8e236da::function_f7362969(hash("spy_camera_photo_taken"));
          self notify(#"take_picture");
          self val::set("spy_camera", "disable_weapon_fire", 1);
          self util::delay(float(var_697c5b2b) / 1000 - 0.5, "death", &namespace_c8e236da::function_f7362969, hash("spy_camera_photo_taken"), 0);
          wait float(var_697c5b2b) / 1000 - 0.25;
        }
      }
    } else if(was_ads) {
      was_ads = 0;

      if(var_f94537f6) {
        var_f94537f6 = 0;
        namespace_c8e236da::removelist();
      }

      if(var_a05f9c5f != 0) {
        self lui::screen_fade_out(0.1);
        var_a05f9c5f = 0;
        self clientfield::set_to_player("spy_camera_state", 0);
        wait 0.1;
        namespace_82bfe441::fade(0, "FadeFast");

        if(var_c5c03b2) {
          self clientfield::set_to_player("binoculars_overlay", 0);
          namespace_61e6d095::remove(#"binoculars");
        }

        self lui::screen_fade_in(0.05);
        self showviewmodel();
        self val::set("spy_camera", "disable_weapon_fire", 1);
      }

      self stopgestureviewmodel(ads_gesture);
      self notifyonplayercommandremove("toggle_stance", "+stance");
      self notifyonplayercommandremove("go_stand", "+gostand");
      self notify(#"hash_5512f0799022267");
      self val::reset("spy_camera", "freezecontrols_allowlook");
      self val::reset("spy_camera", "disable_weapon_cycling");

      while(self isgestureplaying(ads_gesture)) {
        waitframe(1);
      }

      self notify(#"end_camera_ads");
    }

    waitframe(1);
  }
}

function private function_376f686f() {
  self endon(#"hash_5512f0799022267", #"ability_deactivated_camera", #"death");
  self notifyonplayercommand("toggle_stance", "+stance");
  self notifyonplayercommand("go_stand", "+gostand");

  while(true) {
    ret = self waittill(#"toggle_stance", #"go_stand");

    if(ret._notify == "go_stand" || self getstance() != "stand") {
      self setstance("stand");
    } else {
      self setstance("crouch");
    }

    wait 0.5;
  }
}

function private function_d704edcd(var_c5c03b2) {
  self notify(#"ability_deactivated_camera");
  namespace_c8e236da::removelist();
  self val::reset("spy_camera", "freezecontrols_allowlook");
  self val::reset("spy_camera", "disable_weapon_cycling");
  self clientfield::set_to_player("spy_camera_state", 0);
  namespace_82bfe441::fade(0, "FadeFast");
  self lui::function_a6eb5334(0);

  if(namespace_61e6d095::exists(#"binoculars")) {
    self clientfield::set_to_player("binoculars_overlay", 0);
    namespace_61e6d095::remove(#"binoculars");
  }

  self notify(#"hash_2977cbecfddfcab6");
  self notify(#"hash_167fe97f3e95d4c2");
  self notify(#"hide_camera_unequip_hint");
  level.var_af143f1d = [];
  self showviewmodel();
  self val::reset_all("spy_camera");
  self notifyonplayercommandremove("toggle_stance", "+stance");
  self notifyonplayercommandremove("go_stand", "+gostand");
  setuimodelvalue(getuimodel(function_90d058e8(#"spy_camera"), "stream"), 0);
}

function private function_2d8ba5c4() {
  self notify(#"hash_2977cbecfddfcab6");
  self endon(#"hash_2977cbecfddfcab6", #"death");
  var_acca0715 = gettime();

  if(!isDefined(level.var_e3f5eafc.var_7d598677)) {
    level.var_e3f5eafc.var_7d598677 = # "hash_12be6ba1327c64b1";
  }

  if(!isDefined(level.var_e3f5eafc.var_3a0d6cd6)) {
    level.var_e3f5eafc.var_3a0d6cd6 = 8000;
  }

  if(!isDefined(level.var_e3f5eafc.var_f91a82ef)) {
    level.var_e3f5eafc.var_f91a82ef = 1;
  }

  while(true) {
    var_b3fccd4b = gettime();
    var_496bb3bc = var_b3fccd4b - var_acca0715;

    if(is_true(level.var_e3f5eafc.var_f91a82ef) && var_496bb3bc >= level.var_e3f5eafc.var_3a0d6cd6 && !self scene::function_c935c42() && !self flag::get(#"lockpicking")) {
      var_34487abc = isDefined(level.var_e3f5eafc.var_257480e5) ? level.var_e3f5eafc.var_257480e5 : "hide_camera_unequip_hint";
      self util::show_hint_text(level.var_e3f5eafc.var_7d598677, undefined, var_34487abc, 4000);
      self waittill(#"hash_19f1b179d8ebf1dd");
      self util::hide_hint_text(0);
    } else if(self scene::function_c935c42() || self flag::get(#"lockpicking")) {
      wait 1;
      var_acca0715 = gettime();
    }

    if(self isgestureplaying(#"ges_spy_camera_ads")) {
      self waittill(#"end_camera_ads");
      var_acca0715 = gettime();
    }

    wait 0.5;
  }
}