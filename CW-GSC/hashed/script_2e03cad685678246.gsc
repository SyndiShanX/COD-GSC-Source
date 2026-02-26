/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2e03cad685678246.gsc
***********************************************/

#using script_3626f1b2cf51a99c;
#using script_3dc93ca9902a9cda;
#using script_4ab78e327b76395f;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\animation_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\zipline;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace namespace_8af9269b;

function private autoexec __init__system__() {
  system::register(#"hash_2261850aec98f6f8", &preload, undefined, undefined, undefined);
}

function preload() {
  clientfield::register("toplayer", "zipline_postfx", 1, 1, "int");
  clientfield::register("toplayer", "zipline_gesture_strap_visibility", 1, 1, "int");
  clientfield::register("toplayer", "zipline_player_landing_fx", 1, 2, "counter");
  clientfield::register("actor", "zipline_ai_landing_fx", 1, 2, "counter");
  clientfield::register("scriptmover", "zipline_strap_visibility", 1, 1, "int");
  animationstatenetwork::registernotetrackhandlerfunction("zipline_spawn_prop", &function_38cb6163);
  setDvar(#"hash_62b74e3b3b1fc836", 1);
  setDvar(#"hash_3ec5964e8c4f81da", 0);
  level.var_7428aa92 = &function_a8f3484;
  level.var_42da2b06 = &function_e9f7f0d4;
  level.var_ebc8a996 = &function_f33d0f47;
  level.var_4b3860d7 = &function_b8e9daa0;
}

function function_1acebbc0(str_targetname, var_a375f19a = 1, var_dc6e66ea = 1, z_offset = 80, var_c9f2a2 = 0, var_23f866eb = 0, var_1b1aded2 = 0, var_fc006495 = undefined, var_1e72ce9a = 0) {
  var_cf56bb8f = getent(str_targetname, "targetname");
  assert(isDefined(var_cf56bb8f), "<dev string:x38>" + str_targetname);
  var_cf56bb8f.var_a375f19a = var_a375f19a;
  var_cf56bb8f.var_dc6e66ea = var_dc6e66ea;
  var_cf56bb8f.z_offset = z_offset;
  var_cf56bb8f.var_c9f2a2 = var_c9f2a2;
  var_cf56bb8f.var_23f866eb = var_23f866eb;
  var_cf56bb8f.var_1b1aded2 = var_1b1aded2;
  var_cf56bb8f.var_fc006495 = var_fc006495;
  assert(isDefined(var_cf56bb8f.target2), var_cf56bb8f.targetname + "<dev string:x82>");
  var_9f483599 = struct::get(var_cf56bb8f.target2, "targetname");
  var_9f483599.var_cf56bb8f = var_cf56bb8f;
  var_cf56bb8f.var_9f483599 = var_9f483599;
  var_cf56bb8f function_33c566c();
  var_cf56bb8f function_84ca6381();

  if(var_1e72ce9a) {
    var_cf56bb8f thread zipline::function_a8c07396(var_cf56bb8f.v_start_pos, var_cf56bb8f.v_end_pos, var_cf56bb8f.origin);
  }

  level flag::wait_till("game_start");
  var_cf56bb8f.var_9f483599 util::create_cursor_hint(undefined, undefined, #"hash_65784960e7f05b72", 1500, 0, undefined, undefined, 1000, 180, 0, 1, 0, &function_819ed9b3);
  var_cf56bb8f thread function_d41f7e0e();
}

function private function_84ca6381() {
  n_distance = distance(self.v_start_pos, self.v_end_pos);
  var_fce4ba4e = self.v_start_pos[2] - self.v_end_pos[2];
  var_dcd5b4c5 = asin(var_fce4ba4e / n_distance);
  assert(var_dcd5b4c5 >= 2, "<dev string:xbf>" + var_dcd5b4c5 + "<dev string:xdf>");
  assert(var_dcd5b4c5 <= 25, "<dev string:xbf>" + var_dcd5b4c5 + "<dev string:x123>");
  var_aff2bad6 = 6.5;

  if(var_dcd5b4c5 > 6) {
    var_597b2be3 = var_dcd5b4c5 - 6;
    var_1161bec3 = var_597b2be3 / 19;
    var_aff2bad6 += lerpfloat(0, 15, var_1161bec3);
  }

  self.n_distance = n_distance;
  self.var_dcd5b4c5 = var_dcd5b4c5;
  self.var_aff2bad6 = var_aff2bad6;
  self.var_333fa1fd = 0;
}

function function_33c566c() {
  var_cf04fc05 = getvehiclenode(self.target, "targetname");
  self.var_ad1b31ea = var_cf04fc05;
  self.v_start_pos = var_cf04fc05.origin;
  self.var_d9c9a508 = [];

  if(!isDefined(self.var_d9c9a508)) {
    self.var_d9c9a508 = [];
  } else if(!isarray(self.var_d9c9a508)) {
    self.var_d9c9a508 = array(self.var_d9c9a508);
  }

  self.var_d9c9a508[self.var_d9c9a508.size] = var_cf04fc05;

  while(isDefined(var_cf04fc05.target)) {
    var_cf04fc05 = getvehiclenode(var_cf04fc05.target, "targetname");

    if(!isDefined(self.var_d9c9a508)) {
      self.var_d9c9a508 = [];
    } else if(!isarray(self.var_d9c9a508)) {
      self.var_d9c9a508 = array(self.var_d9c9a508);
    }

    self.var_d9c9a508[self.var_d9c9a508.size] = var_cf04fc05;
  }

  self.var_afbab71e = var_cf04fc05;
  self.v_end_pos = var_cf04fc05.origin;
  self.var_ad1b31ea.var_cf56bb8f = self;
}

function function_819ed9b3(s_info) {
  result = 0;

  if(isDefined(self.var_cf56bb8f)) {
    result = self.var_cf56bb8f function_c2f40095();
  }

  return result;
}

function private function_c2f40095() {
  result = 1;
  player = getplayers()[0];

  if(is_true(player.is_ziplining) || is_true(self.var_c9f2a2) && !player isonground() || !player istouching(self) || isDefined(player.takedown) && (isDefined(player.takedown.var_67582ca5) || isDefined(player.takedown.body)) || player flag::get("body_shield_active") || player namespace_5f6e61d9::function_cad84e26() || player scene::function_c935c42() || player isreloading() || player util::is_ads() || player function_104d7b4d()) {
    result = 0;
  }

  return result;
}

function private function_aaeede4e(enabled) {
  println("<dev string:x15e>" + gettime() + "<dev string:x187>" + enabled);
  self actions::function_202ab848(enabled);
  self actions::function_6c59e78f(enabled);
  self.takedown.disabled = !enabled;
}

function private function_d41f7e0e() {
  level endon(#"game_ended");
  a_e_players = getplayers();
  e_player = a_e_players[0];
  e_player endoncallback(&function_3dbd3643, #"death");

  while(true) {
    self.var_9f483599 waittill(#"trigger");

    if(function_c2f40095()) {
      var_1a43c7ac = self.n_distance;
      var_56a048f8 = self.var_dcd5b4c5;
      var_900ff2c3 = self.var_aff2bad6 * self.var_a375f19a;

      if(var_900ff2c3 < 1) {
        var_900ff2c3 = 1;
      } else if(var_900ff2c3 > 35) {
        var_900ff2c3 = 35;
      }

      var_6aa64d21 = self.var_333fa1fd;
      e_player.is_ziplining = 1;
      e_player function_aaeede4e(0);
      e_player.var_d7d83470 = self.targetname;
      e_player notify(#"player_zipline_start", {
        #var_14af458a: self.targetname
      });
      var_d571c86 = e_player getplayerspeed();

      if(is_true(self.var_1b1aded2) && isDefined(self.var_d9c9a508) && self.var_d9c9a508.size > 2) {
        self zipline::function_63d01c33();
      }

      e_player function_f5ce83f7();
      var_b20b0960 = spawner::simple_spawn_single(getent("veh_zipline", "targetname"));
      var_b20b0960 val::set(#"hash_2261850aec98f6f8", "allowdeath", 0);
      var_b20b0960 val::set(#"hash_2261850aec98f6f8", "takedamage", 0);

      while(!isDefined(var_b20b0960)) {
        waitframe(1);
      }

      var_b20b0960 setmovingplatformenabled(1);
      w_current = e_player getcurrentweapon();

      if(is_true(self.var_c9f2a2)) {
        self function_76a94f6f(e_player);
        waitframe(1);
        e_player setplayerangles(self.var_ad1b31ea.angles);
        waitframe(1);
      } else {
        var_e87fe6aa = zipline::function_61418721(e_player.origin, self.v_start_pos, self.v_end_pos);

        if(e_player isonground()) {
          if(w_current hms_util::function_17fe30b7()) {
            e_player setlowready(1);
          }

          waitframe(1);
          e_player playgestureviewmodel("ges_t9_cp_zipline_start");
          var_5385c2b6 = util::spawn_model(#"tag_origin", e_player.origin, e_player.angles);

          while(!isDefined(var_5385c2b6)) {
            waitframe(1);
          }

          e_player function_648c1f6(var_5385c2b6, "tag_origin", 1, 95, 95, 45, 45, 1, 1);
          var_5385c2b6 rotateto(self.var_ad1b31ea.angles, 0.5);
          var_ab2bf9d7 = getclosestpointonnavmesh(var_e87fe6aa, 200);

          if(isDefined(var_ab2bf9d7)) {
            var_5385c2b6 moveto(var_ab2bf9d7, 0.4);
            wait 0.3;
            var_5385c2b6 moveto(var_e87fe6aa - (0, 0, 80), 0.075);
            wait 0.2;
          } else {
            var_5385c2b6 moveto(var_e87fe6aa - (0, 0, 80), 0.375);
            wait 0.5;
          }

          var_5385c2b6 unlink();
          var_5385c2b6 delete();
          e_player setlowready(0);
        } else {
          if(!w_current hms_util::function_17fe30b7()) {
            e_player playgestureviewmodel("ges_t9_cp_zipline_start");
          }

          e_player function_4522ae79(var_e87fe6aa);
        }
      }

      var_e87fe6aa = zipline::function_61418721(e_player.origin, self.v_start_pos, self.v_end_pos);
      self.var_ad1b31ea.origin = var_e87fe6aa;
      var_b20b0960.origin = var_e87fe6aa;
      var_b20b0960.angles = e_player.angles;
      e_player.var_b20b0960 = var_b20b0960;
      var_5385c2b6 = util::spawn_model(#"tag_origin", e_player.origin, e_player.angles);
      var_5385c2b6 setmovingplatformenabled(1);
      e_player.var_5385c2b6 = var_5385c2b6;

      if(is_true(self.var_23f866eb)) {
        var_22dd3701 = 38;
        var_3e1e5ecd = 22.5;
      } else {
        var_22dd3701 = 95;
        var_3e1e5ecd = 45;
      }

      var_5385c2b6 linkto(var_b20b0960, undefined, (0, 0, 80 * -1));
      e_player function_648c1f6(var_5385c2b6, undefined, 1, var_22dd3701, var_22dd3701, var_3e1e5ecd, var_3e1e5ecd, 1, 1);
      waitframe(1);

      if(is_true(self.var_c9f2a2)) {
        var_b20b0960 setspeed(1);
      } else {
        var_d571c86 /= 17.6;
        var_b20b0960 setspeed(var_d571c86);
      }

      e_player playrumbleonentity(#"jump_rumble_start");
      var_b20b0960 thread vehicle::get_on_and_go_path(self.var_ad1b31ea);
      waitframe(1);
      var_b20b0960 setspeed(35, self.var_aff2bad6);
      e_player playrumblelooponentity(#"buzz_high");

      if(is_true(self.var_23f866eb)) {
        e_player thread function_b6764a75(self);
      } else {
        e_player thread function_4a7a6dd7();
      }

      var_b20b0960 thread function_25f7c630();
      snd::play("evt_zipline_start_lr", e_player);
      snd::play("evt_zipline_lp_lr", var_b20b0960);
      snd::play("evt_zipline_wind_lp_lr", var_b20b0960);
      e_player clientfield::set_to_player("zipline_postfx", 1);
      var_2eb0d943 = var_b20b0960 waittill(#"reached_end_node", #"zipline_start_disconnect");

      if(!is_true(self.var_23f866eb)) {
        w_current = e_player getcurrentweapon();

        if(!w_current hms_util::function_17fe30b7()) {
          e_player playgestureviewmodel("ges_t9_cp_zipline_end");
        }

        if(var_2eb0d943._notify == "zipline_start_disconnect") {
          s_results = var_b20b0960 waittilltimeout(0.35, #"reached_end_node");
        }
      }

      e_player thread clientfield::set_to_player("zipline_postfx", 0);
      e_player stoprumble(#"buzz_high");
      e_player function_2e1a479c();
      snd::play("evt_zipline_end_lr", self);
      snd::stop_alias("evt_zipline_lp_lr", var_b20b0960, 0.5);
      snd::stop_alias("evt_zipline_wind_lp_lr", var_b20b0960, 0.5);
      var_ae64746f = var_b20b0960.var_ae64746f;
      waitframe(1);

      if(isDefined(var_b20b0960)) {
        var_b20b0960 unlink();
        var_b20b0960 delete();
        self.var_b20b0960 = undefined;
      }

      if(isDefined(var_5385c2b6)) {
        var_5385c2b6 unlink();
        var_5385c2b6 delete();
        self.var_5385c2b6 = undefined;
      }

      waitframe(1);

      if(isDefined(e_player)) {
        e_player.is_ziplining = 0;
        e_player function_aaeede4e(1);
        e_player notify(#"hash_3726f5b254bceb00");

        if(is_true(self.var_23f866eb)) {
          level notify(#"hash_3ede0d97e45af550");
          level hint_tutorial::function_9f427d88(0);
        } else {
          e_player function_8dd002b4(var_ae64746f, self);

          while(!e_player isonground() && isalive(e_player)) {
            waitframe(1);
          }

          if(isDefined(e_player)) {
            e_player playrumbleonentity("jump_rumble_end");
            earthquake(0.5, 0.25, e_player.origin, 100);

            if(isDefined(self.var_fc006495)) {
              switch (self.var_fc006495) {
                case # "snow":
                  e_player clientfield::increment_to_player("zipline_player_landing_fx", 1);
                  snd::play("evt_zip_player_land_snow");
                  break;
                case # "dirt":
                  e_player clientfield::increment_to_player("zipline_player_landing_fx", 2);
                  snd::play("evt_zip_player_land_dirt");
                  break;
                default:
                  break;
              }
            }
          }
        }

        if(isDefined(e_player)) {
          e_player.var_d7d83470 = undefined;
        }
      }
    }
  }
}

function function_4a7a6dd7() {
  self endon(#"hash_3726f5b254bceb00", #"death");
  wait 0.25;

  while(true) {
    n_magnitude = randomfloatrange(0.05, 0.2);
    earthquake(n_magnitude, 0.35, self.origin, 100);
    wait 0.35;
  }
}

function function_b6764a75(var_88dc621c) {
  self endon(#"hash_3726f5b254bceb00", #"death");
  var_f5558cea = var_88dc621c.n_distance * var_88dc621c.n_distance;
  n_time = 0;
  wait 0.25;

  while(true) {
    var_5b7a38e7 = var_f5558cea - distancesquared(self.origin, var_88dc621c.v_end_pos);

    if(var_5b7a38e7 < 0) {
      var_5b7a38e7 = 0;
    } else if(var_5b7a38e7 > var_f5558cea) {
      var_5b7a38e7 = var_f5558cea;
    }

    var_7ddd94c0 = var_5b7a38e7 / var_f5558cea;
    n_magnitude = lerpfloat(0.05, 0.3, var_7ddd94c0);
    earthquake(n_magnitude, 0.1, self.origin, 100);
    wait 0.1;
    n_time += 0.1;
  }
}

function function_4522ae79(var_e87fe6aa) {
  self endon(#"death");

  while(!self isonground() && self.origin[2] + 80 >= var_e87fe6aa[2] + 5) {
    waitframe(1);
  }
}

function private function_25f7c630() {
  self endon(#"death", #"reached_end_node", #"zipline_start_disconnect");

  while(true) {
    waitframe(1);
    self.var_ae64746f = self getspeedmph();
  }
}

function private function_f5ce83f7() {
  str_stance = self getstance();

  switch (str_stance) {
    case # "crouch":
      self setstance("stand");
      wait 0.2;
      break;
    case # "prone":
      self setstance("stand");
      wait 1;
      break;
  }

  self val::set(#"zipline", "allow_crouch", 0);
  self val::set(#"zipline", "allow_prone", 0);
  self val::set(#"zipline", "allow_jump", 0);
  self val::set(#"zipline", "allow_melee", 0);
}

function private function_2e1a479c() {
  self val::reset_all(#"zipline");
}

function private function_8dd002b4(var_ae64746f, var_cf56bb8f) {
  var_3b2572fe = var_ae64746f / 35;
  var_a236526d = int(lerpfloat(0, 100, var_3b2572fe));
  self applyknockback(var_a236526d, anglesToForward(var_cf56bb8f.var_afbab71e.angles));
}

function function_3dbd3643(str_notify) {
  self thread clientfield::set_to_player("zipline_postfx", 0);
  self stoprumble(#"buzz_high");
  self val::reset_all(#"zipline");

  if(isDefined(self.var_b20b0960)) {
    self.var_b20b0960 unlink();
    self.var_b20b0960 delete();
    self.var_b20b0960 = undefined;
  }

  if(isDefined(self.var_5385c2b6)) {
    self.var_5385c2b6 unlink();
    self.var_5385c2b6 delete();
    self.var_5385c2b6 = undefined;
  }
}

function function_76a94f6f(e_player) {
  e_player endon(#"death");
  scene::add_scene_func("scene_yam_2010_zip_player", &function_4ed637bf, "zip_intro_start");
  level.player val::set(#"hash_7ed7bcbce040b788", "disable_weapons", 1);
  level.player val::set(#"hash_7ed7bcbce040b788", "freezecontrols_allowlook", 1);
  wait 0.4;
  level scene::play("scene_yam_2010_zip_player", "zip_intro_start");
  level.player val::reset_all(#"hash_7ed7bcbce040b788");
}

function function_4ed637bf(ents) {
  snd::play("evt_yam_zipline_attach", level.player);
  strap = ents[#"strap"];
  strap clientfield::set("zipline_strap_visibility", 0);
  strap waittill(#"hash_6452723c1568c7bd");
  strap clientfield::set("zipline_strap_visibility", 1);
}

function function_a8b4a98e(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
  n_damage = modelindex;

  if(!isPlayer(self) && is_true(self.is_ziplining)) {
    n_damage *= 10;
  }

  return n_damage;
}

function private function_8d7e0323(var_d0b8fd1f, var_3c7fa0d6) {
  self.var_c6b02ec0 = util::spawn_model("p9_fxanim_cp_yam_zipline_rappel_strap", var_3c7fa0d6, var_d0b8fd1f);
  self.var_c6b02ec0 useanimtree("generic");
  self.var_c6b02ec0 notsolid();
  self.var_c6b02ec0 linkto(self, "tag_origin");
}

function private function_38cb6163(entity) {
  if(isalive(self) && !isDefined(self.var_c6b02ec0)) {
    var_d0b8fd1f = self gettagangles("tag_origin");
    var_3c7fa0d6 = self gettagorigin("tag_origin");
    function_8d7e0323(var_d0b8fd1f, var_3c7fa0d6);

    if(isDefined(self.var_c6b02ec0) && isassetloaded("xanim", "t9_yam_0000_ambient_zipline_strap_enter")) {
      self.var_c6b02ec0 animscripted("t9_yam_0000_ambient_zipline_strap_enter", var_3c7fa0d6, var_d0b8fd1f, "t9_yam_0000_ambient_zipline_strap_enter", "normal", "root", 1, 0);
    }
  }
}

function private function_a8f3484() {
  snd::play("evt_zipline_npc_start", self.var_b20b0960);
  snd::play("evt_zipline_npc_lp", self.var_b20b0960);
  var_d0b8fd1f = self gettagangles("tag_origin");
  var_3c7fa0d6 = self gettagorigin("tag_origin");

  if(!isDefined(self.var_c6b02ec0)) {
    function_8d7e0323(var_d0b8fd1f, var_3c7fa0d6);
  }

  if(isDefined(self.var_c6b02ec0) && isassetloaded("xanim", "t9_yam_0000_ambient_zipline_strap_loop")) {
    self.var_c6b02ec0 animscripted("t9_yam_0000_ambient_zipline_strap_loop", var_3c7fa0d6, var_d0b8fd1f, "t9_yam_0000_ambient_zipline_strap_loop", "normal", "root", 1, 0);
  }
}

function private function_e9f7f0d4() {
  snd::stop_alias("evt_zipline_npc_lp", self.var_b20b0960, 0);

  if(isDefined(self.var_c6b02ec0)) {
    self.var_c6b02ec0 delete();
  }
}

function private function_f33d0f47() {
  if(isDefined(self.var_b20b0960)) {
    snd::stop_alias("evt_zipline_npc_lp", self.var_b20b0960);
  }
}

function private function_b8e9daa0() {
  var_cf56bb8f = self.zipline_start.var_cf56bb8f;

  if(isDefined(var_cf56bb8f.var_fc006495)) {
    switch (var_cf56bb8f.var_fc006495) {
      case # "snow":
        self clientfield::increment("zipline_ai_landing_fx", 1);
        break;
      case # "dirt":
        self clientfield::increment("zipline_ai_landing_fx", 2);
        break;
      default:
        break;
    }
  }
}