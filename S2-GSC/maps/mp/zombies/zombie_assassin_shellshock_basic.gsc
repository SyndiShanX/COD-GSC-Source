/****************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombie_assassin_shellshock_basic.gsc
****************************************************************/

seek_special_ability_use() {
  return !common_scripts\utility::func_562E(self.specialoverheated) && maps\mp\zombies\zombie_assassin_basic::there_is_close_player(250);
}

activate_special_ability() {
  thread maps\mp\zombies\zombie_assassin_basic::recharge_special_ability(8);
}

special_assassin_damaged(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {}

spawn_an_aod() {
  var_00 = self.var_116;
  playFX(common_scripts\utility::func_44F5("stunning_burst_aoe"), var_00);
  lib_0378::func_8D74("aud_assassin_use_shell_shock");
  if(isDefined(self.custom_on_shellshock_func)) {
    self thread[[self.custom_on_shellshock_func]]();
  }

  foreach(var_02 in level.var_744A) {
    if(!isalive(var_02)) {
      continue;
    }

    if(common_scripts\utility::func_562E(var_02.var_5728)) {
      continue;
    }

    if(distance2d(var_00, var_02.var_116) < 265 && abs(self.var_116[2] - var_02.var_116[2]) < 128) {
      if(lib_0564::should_longburn(var_02)) {
        thread lib_0564::prolonged_damage(var_02, 5);
      }

      var_03 = 3 * distance2d(var_00, var_02.var_116) / 265;
      var_04 = 4 * distance2d(var_00, var_02.var_116) / 265;
      var_02 thread run_shellshock(var_04, var_03, self.var_116);
      level notify("survivalist_blood_2_type_2_failed");
    }

    if(distance2d(var_00, var_02.var_116) > 185 || abs(self.var_116[2] - var_02.var_116[2]) > 128) {
      continue;
    }

    level notify("survivalist_blood_2_type_2_failed");
    var_02 dodamage(75, var_00);
  }
}

run_shellshock(param_00, param_01, param_02) {
  var_03 = 300;
  self endon("death");
  self shellshock("zm_heavy_hit", param_00 * 1.4, param_01);
  self method_8308(0);
  self playrumbleonentity("damage_heavy");
  var_04 = self.var_116 - param_02;
  var_04 = (var_04[0], var_04[1], 0);
  var_04 = var_03 * vectornormalize(var_04);
  var_04 = (var_04[0], var_04[1], 125);
  self setvelocity(var_04);
  self method_8308(1);
  self.current_fog_state = undefined;
}

assassin_stunning_burst_notetrack_handler(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.asn_notetrack_count)) {
    self.asn_notetrack_count = 0;
  }

  switch (param_00) {
    case "footstep_walk_left_asn":
      self.asn_notetrack_count++;
      if(self.asn_notetrack_count > 1) {
        self.asn_notetrack_count = 0;
        thread spawn_an_aod();
      }
      break;
  }
}

throw_debris() {
  var_00 = 4;
  var_01 = 400;
  var_02 = 285;
  var_03 = 360;
  var_04 = 720;
  var_05 = [];
  var_05 = common_scripts\utility::func_F6F(var_05, "day_trenches_corrugated_walls_06a_wet");
  var_05 = common_scripts\utility::func_F6F(var_05, "zmi_fish_cage_01_lid");
  var_05 = common_scripts\utility::func_F6F(var_05, "zmi_fish_single_01");
  var_05 = common_scripts\utility::func_F6F(var_05, "zmi_fish_cage_03");
  var_05 = common_scripts\utility::func_F6F(var_05, "ger_crate_ammo_box_sm_01");
  var_05 = common_scripts\utility::func_F6F(var_05, "can_ger_dynamite_box_lid_01");
  var_05 = common_scripts\utility::func_F92(var_05);
  var_05 = common_scripts\utility::func_FA3(var_05, 0, var_00);
  if(common_scripts\utility::func_562E(level.players_sacrificed_jack)) {
    var_05 = common_scripts\utility::func_F6F(var_05, "vm_zom_jack_in_the_box");
  }

  var_06 = 0;
  foreach(var_08 in var_05) {
    if(lib_0547::func_5565(var_08, "vm_zom_jack_in_the_box")) {
      var_09 = level.var_721C;
      foreach(var_0B in common_scripts\utility::func_F92(level.var_744A)) {
        if(common_scripts\utility::func_562E(var_0B.var_5728)) {
          continue;
        }

        if(common_scripts\utility::func_562E(var_0B.var_178 == "spectator")) {
          continue;
        }

        var_09 = var_0B;
        break;
      }

      var_0D = 215 * vectornormalize(anglesToForward(vectortoangles(var_09.var_116 - self.var_116)));
      var_0D = (var_0D[0], var_0D[1], var_02);
      var_0E = magicgrenademanual("jack_in_box_decoy_zm", getclosestpointonnavmesh(self.var_116, self) + (0, 0, 32), var_0D, 10, self, 1);
      lib_057D::func_737D(var_0E, 30, ::do_shellshock_jack_buff);
      continue;
    }

    var_06 = var_06 + 45;
    var_0F = var_01 * vectornormalize(anglesToForward((0, var_06, 0)));
    var_0F = (var_0F[0], var_0F[1], var_02);
    var_0E = spawn("script_model", self.var_116 + (randomint(64) - 64, randomint(64) - 64, 0));
    var_0E setModel(var_08);
    var_0E gravitymove(var_0F, 5);
    var_0E rotateby((randomintrange(var_03, var_04), randomintrange(var_03, var_04), randomintrange(var_03, var_04)), 5);
    var_0E thread delete_after(5);
  }
}

do_shellshock_jack_buff(param_00) {
  self endon(param_00);
  self endon("death");
  for(;;) {
    var_01 = lib_0547::func_408F();
    foreach(var_03 in var_01) {
      if(common_scripts\utility::func_562E(var_03.isjackbloodbuffed)) {
        continue;
      }

      if(lib_0547::func_5565(var_03.var_A4B, "zombie_assassin")) {
        continue;
      }

      if(!var_03 lib_0547::func_4B2C()) {
        continue;
      }

      if(distance(self.var_116, var_03.var_116) > 112) {
        continue;
      }

      do_jack_blood_beam(var_03);
    }

    wait 0.05;
  }
}

do_jack_blood_beam(param_00) {
  param_00 endon("death");
  param_00.isjackbloodbuffed = 1;
  param_00.zombie_shielding_func = undefined;
  var_01 = spawn("script_model", self.var_116);
  var_01 setModel("tag_origin");
  wait 0.05;
  playFX(common_scripts\utility::func_44F5("stunning_burst"), self.var_116);
  var_02 = launchbeam("zmb_geistkraft_reg_beam_med", var_01, "tag_origin", param_00, "j_neck");
  param_00 thread lib_0378::func_8D74("aud_wonder_weapon_electrocute_strt");
  wait(0.75);
  param_00 thread lib_0378::func_8D74("aud_wonder_weapon_electrocute_end");
  playFX(common_scripts\utility::func_44F5("zmb_isl_med_trap_gib_rnr"), param_00.var_116);
  param_00 dodamage(param_00.var_BC + 1, self.var_116, undefined, undefined, "MOD_PROJECTILE", "fliegerfaust_zm");
  var_02 delete();
  var_01 delete();
}

delete_after(param_00) {
  wait(param_00);
  self delete();
}

get_velocity(param_00, param_01) {
  return param_00 + randomint(param_01) - param_01;
}