/*********************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\_zombies_harmonic_kinetic_accelerator.gsc
*********************************************************************/

init() {
  common_scripts\utility::flag_init("zmb_double_points_available");
  common_scripts\utility::func_92C("dlc_zmb_dig02_sword_looping", "vfx/map/mp_zombie_dig02/dlc_zmb_dig02_sword_looping");
  common_scripts\utility::func_92C("side_ee_reward_green", "vfx/zombie/prototype_fx/dlc4/side_ee_reward_green");
  common_scripts\utility::func_92C("side_ee_reward_cyan", "vfx/zombie/prototype_fx/dlc4/side_ee_reward_cyan");
  common_scripts\utility::func_92C("side_ee_reward_magenta", "vfx/zombie/prototype_fx/dlc4/side_ee_reward_magenta");
  level.zmb_side_ee_colors = ["side_ee_reward_green", "side_ee_reward_cyan", "side_ee_reward_magenta"];
  level thread run_troubled_double_points();
  level thread maps\mp\_utility::func_6F74(::rungenerator_jump);
}

rungenerator_jump() {
  var_00 = self;
  var_00 endon("disconnect");
  var_01 = common_scripts\utility::func_46B7("generator_path_ends", "targetname");
  common_scripts\utility::func_3C9F(lib_0557::func_7838("quest_deathraven", "quest_deathraven_survive_rush"));
  for(;;) {
    wait 0.05;
    if(!var_00 method_82E5()) {
      continue;
    }

    foreach(var_03 in var_01) {
      if(distance(var_00.origin, var_03.origin) < 65) {
        var_04 = level.oribital_rotator_2;
        if(issubstr(var_03.script_noteworthy, "b")) {
          var_04 = level.oribital_rotator_1;
        }

        var_05 = level.oribital_rotator_1 common_scripts\utility::func_8FFC();
        var_00 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_05);
        var_05 show();
        if(var_04 == level.oribital_rotator_2) {
          var_05 rotateYaw(-310, 1.7, 0, 0.8);
        } else {
          var_05 rotateYaw(310, 1.7, 0, 0.8);
        }

        var_00 setstance("crouch");
        var_00 setplayerangles(var_03.angles);
        var_00 playerlinktoabsolute(var_05);
        var_06 = common_scripts\utility::func_F93(var_01, var_03);
        var_00 disableweapons();
        var_00 childthread renable_weaps();
        wait(1.7);
        var_00 unlink();
        var_00 setstance("stand");
        var_05 delete();
        break;
      }
    }

    wait(1);
  }
}

renable_weaps() {
  var_00 = self;
  wait(1.2);
  var_00 enableweapons();
}

run_troubled_double_points(param_00) {
  common_scripts\utility::flag_init("troubled_double_points_0");
  common_scripts\utility::flag_init("troubled_double_points_1");
  common_scripts\utility::flag_init("troubled_double_points_2");
  var_01 = common_scripts\utility::func_46B5("side_raven_ee", "targetname");
  var_02 = getEntArray(var_01.target, "targetname");
  common_scripts\utility::array_thread(var_02, ::set_flag_on_damage);
  for(;;) {
    var_03 = 1;
    foreach(var_05 in var_02) {
      if(!common_scripts\utility::func_562E(var_05.var_8A9)) {
        var_03 = 0;
        break;
      }
    }

    if(var_03) {
      break;
    }

    wait 0.05;
  }

  var_07 = common_scripts\utility::func_46B5("troubled_double_points", "targetname");
  var_08 = common_scripts\utility::func_46B7(var_07.target, "targetname");
  var_09 = var_07 common_scripts\utility::func_8FFC();
  var_09.angles = (0, 30, 0);
  var_09 show();
  var_0A = ["troubled_double_points_spawn", "troubled_double_points_spawn_2", "troubled_double_points_spawn_3"];
  foreach(var_0D, var_0C in var_0A) {
    if(!common_scripts\utility::func_3C77("troubled_double_points_" + var_0D)) {
      var_09 childthread wait_for_grab("troubled_double_points_" + var_0D);
      var_09 childthread move_around(common_scripts\utility::func_46B7(var_0C, "targetname"));
      common_scripts\utility::func_3C9F("troubled_double_points_" + var_0D);
    }

    if(isDefined(var_09.fx)) {
      var_09.fx delete();
    }

    var_09.origin = (0, 0, 0);
  }

  level thread maps / mp / gametypes / zombies::func_8AA();
  var_0E = common_scripts\utility::func_46B5("zmb_dlc4_size_ee_final", "targetname");
  var_0F = 0;
  while(!common_scripts\utility::func_562E(var_0F)) {
    var_0F = run_mini_game(var_0E);
    if(common_scripts\utility::func_562E(var_0F)) {
      break;
    }
  }

  if(isDefined(var_09.fx)) {
    var_09.fx delete();
  }

  if(isDefined(var_09)) {
    var_09 delete();
  }
}

run_mini_game(param_00) {
  var_01 = common_scripts\utility::func_46B7(param_00.target, "targetname");
  var_02 = var_01[0] common_scripts\utility::func_8FFC();
  var_02 show();
  var_02.children = [];
  var_02 thread rotate_target();
  var_02 set_orbiters(20);
  var_03 = var_02 run_game_sequence(var_01, param_00);
  var_04 = common_scripts\utility::func_46B5("dlc4_ee_weap_reward", "targetname");
  var_05 = common_scripts\utility::func_46B5(var_04.target, "targetname");
  foreach(var_07 in var_02.children) {
    var_07 show();
  }

  var_02 set_orbiters(10);
  var_02.origin = var_05.origin + (0, 0, -10);
  var_02.angles = (90, 0, 0);
  var_09 = spawn_a_floating_weapon_award(maps\mp\zombies\_zombies_magicbox::func_454B(var_03, "blunderbuss_pap_zm"), var_04.origin, var_03);
  var_09.linkent.origin = var_04.origin;
  var_0A = undefined;
  var_09.linkent moveTo(var_05.origin, 4, 0, 1);
  wait(3.5);
  while(!isDefined(var_0A) || var_0A != var_03) {
    var_0A = get_new_player(var_09);
    wait 0.05;
  }

  maps\mp\zombies\_zombies_magicbox::func_A7D6(var_0A, maps\mp\zombies\_zombies_magicbox::func_454B(var_03, "blunderbuss_pap_zm"));
  var_09 delete();
  var_09.linkent delete();
  var_02 movez(-512, 8, 3);
  wait(2);
  foreach(var_0C in var_02.children) {
    var_0C delete();
  }

  var_02 delete();
  return 1;
}

spawn_a_floating_weapon_award(param_00, param_01, param_02) {
  var_03 = prespawn_a_floating_award(param_00, param_01, param_02);
  var_04 = 10000;
  var_05 = gettime() + var_04;
  while(gettime() < var_05) {
    if(isDefined(param_02)) {
      var_06 = [param_02];
    } else {
      var_06 = level.players;
    }

    var_07 = 1;
    foreach(var_09 in var_06) {
      if(!var_09 method_8530(param_00)) {
        var_07 = 0;
      }
    }

    if(var_07) {
      break;
    }

    wait 0.05;
  }

  var_03 show_prespawned_floating_award(param_02);
  return var_03;
}

show_prespawned_floating_award(param_00) {
  set_shown_only_to_player(param_00);
  if(isDefined(self.fx)) {
    self.fx set_shown_only_to_player(param_00);
    triggerfx(self.fx);
  }
}

prespawn_a_floating_award(param_00, param_01, param_02) {
  var_03 = spawn("weapon_" + param_00, getclosestpointonnavmesh(param_01) + (0, 0, 8));
  var_03.angles = (var_03.angles[0] - 30, randomint(360), var_03.angles[2]);
  var_03 makeunusable();
  var_03 set_hidden_but_sent_to_player(param_02);
  var_04 = var_03 common_scripts\utility::func_8FFC();
  var_04.origin = var_04.origin + (0, 0, 8);
  var_04 set_hidden_but_sent_to_player(param_02);
  var_03.origin = var_04.origin;
  var_03 linktosynchronizedparent(var_04, "tag_origin");
  var_03.linkent = var_04;
  var_04 rotateYaw(-29536, 850);
  var_05 = spawnStruct();
  var_05.origin = var_03.origin;
  return var_03;
}

set_hidden_but_sent_to_player(param_00) {
  set_shown_only_to_player(param_00);
  self method_8511();
}

set_shown_only_to_player(param_00) {
  if(isDefined(param_00)) {
    self hide();
    self showtoclient(param_00);
    return;
  }

  self show();
}

run_game_sequence(param_00, param_01) {
  var_02 = self;
  var_03 = 0;
  var_04 = undefined;
  while(!var_03) {
    param_01.fx = lib_0547::func_8FBA(param_01, "zmf_descent_vision_blood_ready");
    triggerfx(param_01.fx);
    foreach(var_06 in var_02.children) {
      var_06 hide();
    }

    var_04 = get_new_player(param_01);
    var_04.is_in_side_ee_mini_game = 1;
    param_01.fx delete();
    var_04 childthread maintain_grenades();
    var_08 = level.var_A980;
    var_03 = 0;
    foreach(var_0A in param_00) {
      foreach(var_06 in var_02.children) {
        var_06 hide();
      }

      var_02.origin = var_0A.origin;
      var_02.angles = vectortoangles(var_02.origin - param_01.origin);
      wait(1);
      foreach(var_06 in var_02.children) {
        var_06 show();
      }

      var_03 = var_02 wait_for_success_or_timeout();
      if(var_03) {
        foreach(var_06 in var_02.children) {
          playFX(common_scripts\utility::func_44F5("proj_trail_green_os"), var_06.origin);
        }

        continue;
      }

      foreach(var_06 in var_02.children) {
        var_06 hide();
      }

      break;
    }

    var_04.is_in_side_ee_mini_game = 0;
    if(!var_03) {
      while(level.var_A980 < var_08 + 5) {
        wait 0.05;
      }

      continue;
    }

    break;
    wait 0.05;
  }

  return var_04;
}

set_orbiters(param_00) {
  var_01 = self;
  var_02 = [];
  var_02[0] = (0, param_00, 0);
  var_02[1] = (0, -1 * param_00, 0);
  var_02[2] = (0, 0, param_00);
  var_02[3] = (0, 0, -1 * param_00);
  if(!isDefined(var_01.children)) {
    var_01.children = [];
  }

  foreach(var_04 in var_01.children) {
    stopFXOnTag(common_scripts\utility::func_44F5("proj_trail_white"), var_04, "tag_origin");
  }

  if(!isDefined(var_01.children) || var_01.children.size == 0) {
    for(var_06 = 0; var_06 < 4; var_06++) {
      var_07 = var_01 common_scripts\utility::func_8FFC();
      var_07 show();
      var_07 linktosynchronizedparent(var_01, "tag_origin", var_02[var_06], (0, 0, 0));
      var_01.children[var_01.children.size] = var_07;
    }
  } else {
    for(var_06 = 0; var_06 < 4; var_06++) {
      var_07 = var_01.children[var_06];
      var_07 unlink();
      var_07 linktosynchronizedparent(var_01, "tag_origin", var_02[var_06], (0, 0, 0));
    }
  }

  var_01 thread reset_fx();
}

reset_fx() {
  var_00 = self;
  wait 0.05;
  foreach(var_02 in var_00.children) {
    playFXOnTag(common_scripts\utility::func_44F5("proj_trail_white"), var_02, "tag_origin");
  }
}

wait_for_success_or_timeout() {
  var_00 = gettime();
  while(gettime() - var_00 < 5000) {
    foreach(var_02 in maps / mp / zombies / _zombies_orbital_gravity_entangler::get_all_magical_grenades()) {
      if(distance(var_02.origin, self.origin) < 40) {
        return 1;
      }
    }

    wait 0.05;
  }

  return 0;
}

rotate_target() {
  self endon("entitydeleted");
  for(;;) {
    self rotatevelocity((0, 0, 36), 0.05);
    wait 0.05;
  }
}

maintain_grenades() {
  var_00 = self;
  while(common_scripts\utility::func_562E(var_00.is_in_side_ee_mini_game)) {
    var_00.grenadecolorsheld = ["proj_trail_white", "proj_trail_white", "proj_trail_white", "proj_trail_white"];
    lib_0586::func_478A(var_00);
    wait 0.05;
  }
}

get_new_player(param_00) {
  for(;;) {
    foreach(var_02 in level.players) {
      if(!isDefined(var_02.zmb_dlc4_size_ee_final_hold_time)) {
        var_02.zmb_dlc4_size_ee_final_hold_time = 0;
      }

      if(distance(param_00.origin, var_02.origin) > 60) {
        var_02.zmb_dlc4_size_ee_final_hold_time = 0;
        continue;
      }

      if(!var_02 useButtonPressed()) {
        var_02.zmb_dlc4_size_ee_final_hold_time = 0;
        continue;
      }

      var_02.zmb_dlc4_size_ee_final_hold_time = var_02.zmb_dlc4_size_ee_final_hold_time + 0.1;
      if(var_02.zmb_dlc4_size_ee_final_hold_time >= 0.5) {
        return var_02;
      }
    }

    wait(0.1);
  }
}

set_flag_on_damage() {
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(lib_0547::func_5565(var_04, "MOD_EXPLOSIVE")) {
      continue;
    }

    break;
  }

  self.var_8A9 = 1;
  if(self.classname == "script_model") {
    var_0A = (0, 0, 13);
  } else {
    var_0A = (0, 0, 5);
  }

  var_0B = self.angles;
  if(!isDefined(var_0B)) {
    var_0B = (0, 0, 0);
  }

  playFX(common_scripts\utility::func_44F5("ee_lamp_fx"), self.origin + var_0A, anglesToForward(var_0B), anglestoup(var_0B));
  lib_0378::func_8D74("aud_raven_fly_away");
}

move_around(param_00) {
  self endon("double_points_grabbed");
  self endon("entitydeleted");
  self.fx = undefined;
  if(isDefined(self.fx)) {
    self.fx delete();
  }

  var_01 = common_scripts\utility::random(param_00);
  self.origin = var_01.origin;
  var_02 = common_scripts\utility::random(level.zmb_side_ee_colors);
  self.ee_color = maps / mp / zombies / _zombies_orbital_gravity_entangler::get_color_for_grenade(var_02);
  for(;;) {
    self.angles = (randomint(360), randomint(360), randomint(360));
    self.fx = lib_0547::func_8FBA(self, var_02);
    triggerfx(self.fx);
    wait(7);
    if(function_0279(self)) {
      return;
    }

    var_01 = common_scripts\utility::random(param_00);
    playFX(level._effect["zmb_dnk_geistkraftexplode"], self.origin);
    lib_0378::func_8D74("aud_dlc4_magic_poof", self.origin);
    if(isDefined(self.fx)) {
      self.fx delete();
    }

    wait(0.7);
    if(function_0279(self)) {
      return;
    }

    self.origin = var_01.origin;
    playFX(level._effect["zmb_dnk_geistkraftexplode"], var_01.origin);
    lib_0378::func_8D74("dlc3_magic_poof", self.origin);
  }
}

wait_for_grab(param_00) {
  self endon("double_points_grabbed");
  while(!isDefined(level.players)) {
    wait 0.05;
  }

  var_01 = 0;
  var_02 = undefined;
  while(!var_01) {
    var_03 = maps / mp / zombies / _zombies_orbital_gravity_entangler::get_all_magical_grenades();
    foreach(var_05 in var_03) {
      if(distance(var_05.origin, self.origin) > 90 || !lib_0547::func_5565(var_05.ee_color, self.ee_color)) {
        continue;
      } else {
        var_01 = 1;
        break;
      }
    }

    wait 0.05;
  }

  common_scripts\utility::flag_set(param_00);
  self notify("double_points_grabbed");
}

run_harmonic_kinectic_acceleration() {
  initialize_plate();
  wait 0.05;
  if(self.var_82EC == "a") {
    common_scripts\utility::func_3C9F("flag_archives_to_bridge_1");
    common_scripts\utility::func_3C9F("flag_gallery_to_bridge_1");
    common_scripts\utility::flag_set("zmb_double_points_available");
  }

  level thread maps\mp\_utility::func_6F74(::launchplayers, self);
}

launchplayers(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  var_02 = -800;
  var_03 = 10;
  if(!isDefined(var_01.launchpadfx)) {
    var_01.launchpadfx = [];
  }

  for(;;) {
    if(isDefined(var_01.launchpadfx[param_00.var_82EC])) {
      var_01.launchpadfx[param_00.var_82EC] delete();
    }

    var_01.launchpadfx[param_00.var_82EC] = lib_0547::func_8FBA(param_00.plate_model, "dlc_zmb_dig02_sword_looping", var_01);
    triggerfx(var_01.launchpadfx[param_00.var_82EC]);
    while(!var_01 jumpbuttonPressed() || distance(var_01.origin, param_00.origin) > 132) {
      wait 0.05;
    }

    if(isDefined(var_01.launchpadfx[param_00.var_82EC])) {
      var_01.launchpadfx[param_00.var_82EC] delete();
    }

    var_04 = distance(var_01.origin, param_00.dest_path.landing.origin) < 512;
    lib_0378::func_8D74("tesla_hc_energy_lamp_destruct", var_01.origin);
    if(!var_04) {
      var_05 = var_01 common_scripts\utility::func_8FFC();
      var_05 show();
      var_06 = var_01 common_scripts\utility::func_8FFC();
      var_06 show();
      var_01 playerlinkTo(var_05, "tag_player");
      var_07 = get_required_velocity(param_00.dest_path.origin, var_01.origin);
      var_08 = param_00.dest_path.landing.origin[2] - var_01.origin[2];
      var_03 = func_8F12(var_02 / 2, var_07[2], -1 * var_08);
      var_05 gravitymove(var_07, var_03);
      var_09 = 0;
      var_0A = var_05 track_velocity();
      var_01 unlink();
      var_06.origin = var_05.origin;
      var_01 playerlinkTo(var_06, "tag_player");
      var_06 moveTo(var_0A, 0.3);
      wait(0.3);
      var_01 unlink();
      var_05 delete();
      var_06 delete();
    } else {
      var_0B = var_01 geteyeangles();
      var_0B = common_scripts\utility::func_3D5C(var_0B);
      var_0C = vectorNormalize(anglesToForward(var_0B));
      var_07 = get_required_velocity((var_01.origin[0] + 128 * var_0C[0], var_01.origin[1] + 128 * var_0C[1], param_00.dest_path.origin[2]), var_01.origin);
      var_01 setvelocity(var_07);
    }

    level common_scripts\utility::func_A70D(8, level, "round complete");
  }
}

magnitude(param_00) {
  return sqrt(squared(param_00[0]) + squared(param_00[1]) + squared(param_00[2]));
}

track_velocity() {
  self endon("entitydeleted");
  self.my_velocity = (0, 0, 0);
  var_00 = 1;
  var_01 = 0;
  var_02 = 0;
  var_03 = 0;
  var_04 = 0;
  var_05 = 0;
  var_06 = 0;
  var_07 = 0;
  var_08 = undefined;
  for(;;) {
    var_01 = func_4231(self.origin[0], var_04, var_07);
    var_02 = func_4231(self.origin[1], var_05, var_07);
    var_03 = func_4231(self.origin[2], var_06, var_07);
    self.my_velocity = (var_01, var_02, var_03);
    var_04 = self.origin[0];
    var_05 = self.origin[1];
    var_06 = self.origin[2];
    var_07 = gettime();
    if(self.my_velocity[2] < 0) {
      var_09 = vectorNormalize(self.my_velocity);
      var_0A = self.origin;
      var_0B = var_0A + 1000 * var_09;
      var_08 = bulletTrace(var_0A, var_0B, 0);
      if(distance(self.origin, var_08["position"]) < 150) {
        return var_08["position"] + (0, 0, 1);
      }
    }

    wait 0.05;
  }
}

func_4231(param_00, param_01, param_02) {
  return param_00 - param_01 / gettime() - param_02 / 1000;
}

func_8F12(param_00, param_01, param_02) {
  var_03 = param_01 * param_01 - 4 * param_00 * param_02;
  var_04 = 0;
  var_05 = 0;
  if(var_03 > 0) {
    var_04 = -1 * param_01 + sqrt(var_03) / 2 * param_00;
    var_05 = -1 * param_01 - sqrt(var_03) / 2 * param_00;
  }

  return var_05;
}

get_required_velocity(param_00, param_01) {
  var_02 = -800;
  var_03 = param_00[2] - param_01[2];
  var_04 = 2 * param_00[1] - param_01[1];
  var_05 = 2 * param_00[0] - param_01[0];
  var_06 = sqrt(-2 * var_02 * var_03);
  var_07 = -2 * var_06 / var_02;
  var_08 = var_05 / var_07;
  var_09 = var_04 / var_07;
  return (var_08, var_09, var_06);
}

initialize_plate() {
  var_00 = self;
  var_01 = common_scripts\utility::func_44BE(var_00.target, "targetname");
  var_00.dest_path = common_scripts\utility::func_46B5("launch_path_" + var_00.var_82EC, "script_noteworthy");
  var_00.dest_path.landing = common_scripts\utility::func_46B5(var_00.dest_path.target, "targetname");
  foreach(var_03 in var_01) {
    var_04 = var_03.script_noteworthy;
    if(!isDefined(var_04)) {
      continue;
    }

    switch (var_04) {
      case "plate_model_lower":
        var_00.plate_model_lower = var_03;
        break;

      case "plate_model_upper":
        var_00.plate_model_upper = var_03;
        break;

      case "plate_model":
        var_00.plate_model = var_03;
        var_00.model_start_origin = var_03.origin;
        break;

      case "plate_trig":
        var_00.plate_trig = var_03;
        var_00.plate_trig.associated_struct = var_00;
        break;

      case "plate_damage_trig":
        var_00.plate_damage_trig = var_03;
        break;

      case "plate_center_trig":
        var_00.plate_center_trig = var_03;
        break;
    }
  }
}