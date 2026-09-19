/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\zombie_assassin_shellshock.gsc
******************************************************************/

seek_special_ability_use() {
  return !common_scripts\utility::_id_562E(self.specialoverheated) && maps\mp\zombies\zombie_assassin::there_is_close_player(250);
}

activate_special_ability() {
  thread maps\mp\zombies\zombie_assassin::recharge_special_ability(8);
}

special_assassin_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {}

spawn_an_aod() {
  var_0 = self.origin;
  playFX(common_scripts\utility::_id_44F5("stunning_burst_aoe"), var_0);
  _id_0378::_id_8D74("aud_assassin_use_shell_shock");

  if(isDefined(self.custom_on_shellshock_func))
    self thread[[self.custom_on_shellshock_func]]();

  foreach(var_2 in level.players) {
    if(!isalive(var_2)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_2._id_5728)) {
      continue;
    }
    if(_func_0E1(var_0, var_2.origin) < 265 && _func_0AE(self.origin[2] - var_2.origin[2]) < 128) {
      var_3 = 3 * (_func_0E1(var_0, var_2.origin) / 265);
      var_4 = 4 * (_func_0E1(var_0, var_2.origin) / 265);
      var_2 thread run_shellshock(var_4, var_3, self.origin);
      level notify("survivalist_blood_2_type_2_failed");
    }

    if(_func_0E1(var_0, var_2.origin) > 185 || _func_0AE(self.origin[2] - var_2.origin[2]) > 128) {
      continue;
    }
    level notify("survivalist_blood_2_type_2_failed");
    var_2 _meth_8059(75, var_0);
  }
}

run_shellshock(var_0, var_1, var_2) {
  var_3 = 300;
  self endon("death");
  self _meth_8182("zm_heavy_hit", var_0 * 1.4, var_1);
  self _meth_8308(0);
  self _meth_809F("damage_heavy");
  var_4 = self.origin - var_2;
  var_4 = (var_4[0], var_4[1], 0);
  var_4 = var_3 * vectorNormalize(var_4);
  var_4 = (var_4[0], var_4[1], 125);
  self _meth_82F7(var_4);
  self _meth_8308(1);
  self.current_fog_state = undefined;
}

assassin_stunning_burst_notetrack_handler(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.asn_notetrack_count))
    self.asn_notetrack_count = 0;

  switch (var_0) {
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
  var_0 = 4;
  var_1 = 400;
  var_2 = 285;
  var_3 = 360;
  var_4 = 720;
  var_5 = [];
  var_5 = common_scripts\utility::_id_0F6F(var_5, "day_trenches_corrugated_walls_06a_wet");
  var_5 = common_scripts\utility::_id_0F6F(var_5, "zmi_fish_cage_01_lid");
  var_5 = common_scripts\utility::_id_0F6F(var_5, "zmi_fish_single_01");
  var_5 = common_scripts\utility::_id_0F6F(var_5, "zmi_fish_cage_03");
  var_5 = common_scripts\utility::_id_0F6F(var_5, "ger_crate_ammo_box_sm_01");
  var_5 = common_scripts\utility::_id_0F6F(var_5, "can_ger_dynamite_box_lid_01");
  var_5 = common_scripts\utility::array_randomize(var_5);
  var_5 = common_scripts\utility::_id_0FA3(var_5, 0, var_0);

  if(common_scripts\utility::_id_562E(level.players_sacrificed_jack))
    var_5 = common_scripts\utility::_id_0F6F(var_5, "vm_zom_jack_in_the_box");

  var_6 = 0;

  foreach(var_8 in var_5) {
    if(_id_0547::_id_5565(var_8, "vm_zom_jack_in_the_box")) {
      var_9 = level.player;

      foreach(var_11 in common_scripts\utility::array_randomize(level.players)) {
        if(common_scripts\utility::_id_562E(var_11._id_5728)) {
          continue;
        }
        if(common_scripts\utility::_id_562E(var_11.sessionstate == "spectator")) {
          continue;
        }
        var_9 = var_11;
        break;
      }

      var_13 = 215 * vectorNormalize(anglesToForward(vectortoangles(var_9.origin - self.origin)));
      var_13 = (var_13[0], var_13[1], var_2);
      var_14 = _func_071("jack_in_box_decoy_zm", _func_2E1(self.origin, self) + (0, 0, 32), var_13, 10, self, 1);
      _id_057D::_id_737D(var_14, 30, ::do_shellshock_jack_buff);
      continue;
    }

    var_6 = var_6 + 45;
    var_15 = var_1 * vectorNormalize(anglesToForward((0, var_6, 0)));
    var_15 = (var_15[0], var_15[1], var_2);
    var_14 = spawn("script_model", self.origin + (randomint(64) - 64, randomint(64) - 64, 0));
    var_14 setModel(var_8);
    var_14 _meth_82B5(var_15, 5);
    var_14 _meth_83E5((_func_0A4(var_3, var_4), _func_0A4(var_3, var_4), _func_0A4(var_3, var_4)), 5);
    var_14 thread delete_after(5);
  }
}

do_shellshock_jack_buff(var_0) {
  self endon(var_0);
  self endon("death");

  for(;;) {
    var_1 = _id_0547::_id_408F();

    foreach(var_3 in var_1) {
      if(common_scripts\utility::_id_562E(var_3.isjackbloodbuffed)) {
        continue;
      }
      if(_id_0547::_id_5565(var_3._id_0A4B, "zombie_assassin")) {
        continue;
      }
      if(!var_3 _id_0547::_id_4B2C()) {
        continue;
      }
      if(distance(self.origin, var_3.origin) > 112) {
        continue;
      }
      do_jack_blood_beam(var_3);
    }

    waitframe();
  }
}

do_jack_blood_beam(var_0) {
  var_0 endon("death");
  var_0.isjackbloodbuffed = 1;
  var_0.zombie_shielding_func = undefined;
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("tag_origin");
  waitframe();
  playFX(common_scripts\utility::_id_44F5("stunning_burst"), self.origin);
  var_2 = _func_382("zmb_geistkraft_reg_beam_med", var_1, "tag_origin", var_0, "j_neck");
  var_0 thread _id_0378::_id_8D74("aud_wonder_weapon_electrocute_strt");
  wait 0.75;
  var_0 thread _id_0378::_id_8D74("aud_wonder_weapon_electrocute_end");
  playFX(common_scripts\utility::_id_44F5("zmb_isl_med_trap_gib_rnr"), var_0.origin);
  var_0 _meth_8059(var_0.health + 1, self.origin, undefined, undefined, "MOD_PROJECTILE", "fliegerfaust_zm");
  var_2 delete();
  var_1 delete();
}

delete_after(var_0) {
  wait(var_0);
  self delete();
}

get_velocity(var_0, var_1) {
  return var_0 + (randomint(var_1) - var_1);
}