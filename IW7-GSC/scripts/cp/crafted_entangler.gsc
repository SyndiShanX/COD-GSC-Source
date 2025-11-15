/********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\crafted_entangler.gsc
********************************************/

init() {
  var_00 = spawnStruct();
  var_00.timeout = 60;
  var_00.var_9F43 = 0;
  if(!isDefined(level.var_47B3)) {
    level.var_47B3 = [];
  }

  level.var_47B3["crafted_entangler"] = var_00;
  level thread watchforentangleractivation();
  initentanglermodels();
}

watchforentangleractivation() {
  level endon("game_ended");
  level waittill("complete_stay_on_pressure_plates");
  scripts\cp\utility::set_quest_icon(2);
  scripts\cp\maps\cp_final\cp_final_mpq::activateinteractionsbynoteworthy("entangler_spawner");
  var_00 = scripts\engine\utility::getstruct("entangler_spawner", "script_noteworthy");
  var_01 = spawn("script_model", var_00.origin);
  var_01.angles = var_00.angles;
  var_01 setModel("weapon_entangler_wm");
  var_01 thread moveandrotateentangler(var_01, var_00.origin);
  var_02 = spawn("script_model", scripts\engine\utility::drop_to_ground(var_00.origin, 12, -100) + (0, 0, 1));
  var_02 setModel("final_gns_quest_origin");
  var_01.fx = var_02;
  var_01.fx setscriptablepartstate("pressure_plate", "on");
  var_00.var_870F = var_01;
}

moveandrotateentangler(param_00, param_01) {
  level endon("game_ended");
  for(;;) {
    param_00 rotateyaw(360, 6);
    param_00 moveto(param_01 + (0, 0, 48), 3, 1, 1);
    wait(3);
    param_00 moveto(param_01, 3, 0.5, 0.5);
    wait(3);
  }
}

give_crafted_entangler(param_00, param_01) {
  param_01 thread watch_dpad();
  param_01 notify("new_power", "crafted_entangler");
  param_01 setclientomnvar("zom_crafted_weapon", 19);
  param_01 thread scripts\cp\utility::usegrenadegesture(param_01, "iw7_pickup_zm");
  param_01.hascraftedentangler = 1;
  scripts\cp\utility::set_crafted_inventory_item("crafted_entangler", ::give_crafted_entangler, param_01);
}

unsetentanglerflagondeath(param_00) {
  param_00 endon("disconnect");
  param_00 endon("craft_dpad_watcher");
  param_00 waittill("death");
  param_00.hascollectedentangler = undefined;
}

watch_dpad() {
  self endon("disconnect");
  self endon("death");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self.hascollectedentangler = 1;
  thread unsetentanglerflagondeath(self);
  self notifyonplayercommand("pullout_trap", "+actionslot 3");
  for(;;) {
    self waittill("pullout_trap");
    if(scripts\engine\utility::istrue(self.iscarrying)) {
      self playlocalsound("perk_machine_deny");
      continue;
    }

    if(scripts\engine\utility::istrue(self.isusingsupercard)) {
      self playlocalsound("perk_machine_deny");
      continue;
    }

    if(scripts\engine\utility::istrue(self.linked_to_coaster)) {
      self playlocalsound("perk_machine_deny");
      continue;
    }

    if(scripts\engine\utility::istrue(self.attemptingpuzzle)) {
      continue;
    }

    if(isDefined(self.allow_carry) && self.allow_carry == 0) {
      self playlocalsound("perk_machine_deny");
      continue;
    }

    if(scripts\engine\utility::istrue(self.carriedsentry)) {
      self playlocalsound("perk_machine_deny");
      continue;
    }

    if(scripts\cp\utility::is_valid_player()) {
      break;
    }
  }

  thread give_entangler(self);
}

give_entangler(param_00) {
  param_00 endon("disconnect");
  foreach(var_02 in level.wall_buy_interactions) {
    if(isDefined(var_02.trigger)) {
      var_02.trigger hidefromplayer(param_00);
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_02, param_00);
  }

  level notify("entangler_given", param_00);
  param_00.hasentanglerequipped = 1;
  param_00 scripts\cp\utility::clearlowermessage("msg_power_hint");
  param_00.itemtype = "entangler";
  param_00 removeperks();
  param_00.restoreweapon = param_00 scripts\cp\utility::getvalidtakeweapon();
  var_04 = "iw7_entangler2_zm";
  if(scripts\engine\utility::flag("meph_fight")) {
    var_04 = "iw7_entangler_zm";
  }

  param_00.isusingsupercard = 1;
  param_00 scripts\cp\utility::_giveweapon(var_04, undefined, undefined, 1);
  param_00 switchtoweapon(var_04);
  var_05 = param_00 watchforputaway();
  param_00.hasentanglerequipped = undefined;
  foreach(var_02 in level.wall_buy_interactions) {
    if(scripts\engine\utility::istrue(var_02.should_be_hidden)) {
      continue;
    }

    if(isDefined(var_02.trigger)) {
      var_02.trigger showtoplayer(param_00);
    }

    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_02, param_00);
  }

  param_00.isusingsupercard = undefined;
  param_00.carriedsentry = undefined;
  param_00 thread waitrestoreperks();
  param_00 restoreweapons();
  param_00.iscarrying = 0;
  param_00 notify("entangler_removed");
  level notify("entangler_removed_" + param_00.name);
}

watchforputaway() {
  self endon("disconnect");
  scripts\engine\utility::allow_weapon_switch(0);
  self notifyonplayercommand("cancel_entangler", "+actionslot 3");
  self notifyonplayercommand("cancel_entangler", "+weapnext");
  if(!level.console) {
    self notifyonplayercommand("cancel_entangler", "+actionslot 5");
    self notifyonplayercommand("cancel_entangler", "+actionslot 6");
    self notifyonplayercommand("cancel_entangler", "+actionslot 7");
  }

  for(;;) {
    var_00 = scripts\cp\utility::waittill_any_ents_return(self, "cancel_entangler", self, "craft_dpad_watcher", self, "weapon_purchased", self, "last_stand", self, "death", level, "players_activated_gns");
    if(scripts\engine\utility::istrue(self.playing_ghosts_n_skulls)) {
      continue;
    }

    if(isDefined(var_00)) {
      if(var_00 == "death") {
        self.hascollectedentangler = undefined;
      }

      if(var_00 == "craft_dpad_watcher") {
        if(!scripts\engine\utility::isweaponswitchallowed()) {
          scripts\engine\utility::allow_weapon_switch(1);
        }

        if(scripts\engine\utility::flag("meph_fight")) {
          var_01 = "iw7_entangler_zm";
        } else {
          var_01 = "iw7_entangler2_zm";
          self.hascollectedentangler = undefined;
        }

        if(self hasweapon(var_01)) {
          self takeweapon(var_01);
        }

        scripts\cp\utility::remove_crafted_item_from_inventory(self);
        self notify("end_Ghost_Idle_Loop");
        break;
      } else {
        if(!scripts\engine\utility::isweaponswitchallowed()) {
          scripts\engine\utility::allow_weapon_switch(1);
        }

        var_01 = "iw7_entangler2_zm";
        if(scripts\engine\utility::flag("meph_fight")) {
          var_01 = "iw7_entangler_zm";
        }

        if(self hasweapon(var_01)) {
          self takeweapon(var_01);
        }

        self notify("end_Ghost_Idle_Loop");
        thread watch_dpad();
        break;
      }
    }
  }
}

removeperks() {
  if(scripts\cp\utility::_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    scripts\cp\utility::_unsetperk("specialty_explosivebullets");
  }
}

restoreweapons() {
  if(isDefined(self.restoreweapon)) {
    if(self hasweapon(self.restoreweapon)) {
      self switchtoweapon(self.restoreweapon);
    } else {
      self switchtoweapon(scripts\cp\utility::getvalidtakeweapon());
    }
  } else {
    self switchtoweapon(scripts\cp\utility::getvalidtakeweapon());
  }

  self.restoreweapon = undefined;
}

restoreperks() {
  if(isDefined(self.restoreperk)) {
    scripts\cp\utility::giveperk(self.restoreperk);
    self.restoreperk = undefined;
  }
}

waitrestoreperks() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(0.05);
  restoreperks();
}

entangleitem(param_00, param_01, param_02) {
  param_02 endon("death");
  if(isDefined(param_00)) {
    param_00 notifyonplayercommand("item_released", "-attack");
    param_00 setscriptablepartstate("entangler", "active");
  }

  param_02 notify("item_entangled");
  if(param_00 scripts\cp\utility::isweaponfireenabled()) {
    param_00 scripts\engine\utility::allow_fire(0);
  }

  if(param_00 scripts\cp\utility::issprintenabled()) {
    param_00 scripts\engine\utility::allow_sprint(0);
  }

  if(param_02.model == "cp_final_brute_mascot_mask") {
    param_02 scripts\cp\maps\cp_final\cp_final_interactions::helmet_not_useable();
  }

  var_03 = gettagfrommodel(param_02);
  var_04 = playfxontagsbetweenclients(level._effect["entangler_beam"], param_00, "tag_flash", param_02, var_03);
  param_02.entangled = 1;
  param_02.carriedby = param_00;
  moveitemtowardsplayer(param_00, param_01, var_03);
  if(!isDefined(param_00)) {
    param_02.forcerelease = 1;
  }

  if(isDefined(param_00)) {
    param_00 notify("end_move_towards_player");
    param_00 setscriptablepartstate("entangler", "fired");
  }

  if(isDefined(var_04)) {
    var_04 delete();
  }

  if(isDefined(param_00)) {
    if(!param_00 scripts\cp\utility::isweaponfireenabled()) {
      param_00 scripts\engine\utility::allow_fire(1);
    }

    if(!param_00 scripts\cp\utility::issprintenabled()) {
      param_00 scripts\engine\utility::allow_sprint(1);
    }
  }

  if(isDefined(param_02.customlaunchfunc)) {
    thread[[param_02.customlaunchfunc]](param_00, param_02, param_01);
    return;
  }

  launchitem(param_00, param_02, param_01);
}

releaseitemaftertime(param_00, param_01) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("item_released");
  param_00 endon("entangler_removed");
  wait(gettimeoutfrommodel(param_01));
  param_01.forcerelease = 1;
  param_00 notify("item_released");
}

gettimeoutfrommodel(param_00) {
  switch (param_00.model) {
    case "ref_space_helmet_02":
      return 60;

    default:
      return 90;
  }
}

gettagfrommodel(param_00) {
  switch (param_00.model) {
    case "ref_space_helmet_02":
      return "us_space_helmet_a_lod1";

    default:
      return "tag_origin";
  }
}

initentanglermodels() {
  var_00 = scripts\engine\utility::getstructarray("entangler_structs", "targetname");
  foreach(var_02 in var_00) {
    level thread spawnentanglermodel(var_02);
  }
}

spawnentanglermodel(param_00, param_01, param_02) {
  if(isDefined(param_00.entanglemodel)) {
    param_00.entanglemodel scripts\cp\cp_weapon::placeequipmentfailed("pillage", 1, param_00.entanglemodel.origin);
    param_00.entanglemodel delete();
  }

  if(isDefined(param_01)) {
    var_03 = param_01;
  } else {
    var_03 = param_01.origin;
  }

  if(isDefined(param_02)) {
    var_04 = param_02;
  } else if(isDefined(param_01.angles)) {
    var_04 = param_01.angles;
  } else {
    var_04 = (0, 0, 0);
  }

  var_05 = spawn("script_model", var_03);
  var_05.angles = var_04;
  if(isDefined(param_00.script_noteworthy)) {
    var_05 setModel(param_00.script_noteworthy);
  } else {
    var_05 setModel("ref_space_helmet_02");
  }

  param_00.entanglemodel = var_05;
  param_00 notify("new_model_created");
  var_05.parent_struct = param_00;
  var_05 thread watchforentanglerdamage(param_00, var_05);
  var_05 thread outlineitemforplayers(param_00, var_05);
}

watchforentanglerdamage(param_00, param_01) {
  param_01 notify("watchForEntanglerDamage");
  param_01 endon("watchForEntanglerDamage");
  level endon("game_ended");
  param_00 endon("new_model_created");
  param_00 endon("vent_grabbed_puzzle_piece");
  param_01 endon("end_entangler_funcs");
  param_00 endon("stop_watching_for_entangler_damage");
  param_01 setCanDamage(1);
  param_01.health = 9999999;
  param_01.maxhealth = 9999999;
  for(;;) {
    param_01 waittill("damage", var_02, var_03, var_02, var_02, var_02, var_02, var_02, var_02, var_02, var_04);
    if(isDefined(var_04) && getweaponbasename(var_04) == "iw7_entangler2_zm") {
      var_03.entangledmodel = param_01;
      thread entangleitem(var_03, param_00, param_01);
      param_01 waittill("released", var_05, var_06, var_07);
      var_08 = isDefined(param_00.groupname);
      var_09 = param_01.origin;
      if(param_01 istouching(getent("electric_trap_trig", "targetname"))) {
        var_05 = 1;
      }

      if(!scripts\engine\utility::istrue(var_05) && scripts\cp\maps\cp_final\cp_final::validateplayspace(var_09, var_03, var_08, var_08, var_07)) {
        if(param_01.model == "cp_final_brute_mascot_mask") {
          param_01 scripts\cp\maps\cp_final\cp_final_interactions::helmet_useable();
        } else {
          param_01 physicsstopserver();
          if(isDefined(param_00.groupname)) {
            level.undergratepuzzlepiece = param_01;
            level notify("vent_fx");
          }

          if(scripts\engine\utility::istrue(var_06)) {
            param_01 notify("end_entangler_funcs");
          }
        }
      } else if(isDefined(param_00.var_1088C)) {
        thread[[param_00.var_1088C]](param_00.id, param_00);
      } else if(param_01.model == "cp_final_brute_mascot_mask") {
        param_01 scripts\cp\maps\cp_final\cp_final_interactions::helmet_useable();
        level.brute_helm_out_of_bounds = 1;
      } else {
        level thread spawnentanglermodel(param_00, param_00.origin, param_00.angles);
      }
    }
  }
}

moveitemtowardsplayer(param_00, param_01, param_02) {
  param_00 endon("entangler_removed");
  param_00 endon("disconnect");
  param_00 endon("item_released");
  level endon("entangler_removed_" + param_00.name);
  wait(0.1);
  var_03 = 1250;
  var_04 = 0;
  var_05 = 72;
  var_06 = 0;
  var_07 = param_00.entangledmodel;
  var_08 = 1;
  var_09 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 0, 1);
  var_0A = scripts\common\trace::create_contents(1, 1, 1, 1, 1, 0, 0);
  var_0B = getcapsulefrommodel(var_07);
  var_07 endon("end_entangle_move_to_logic");
  var_07.lasteffecttime = 0;
  if(isDefined(var_07.script_parameters) && var_07.script_parameters == "heavy_helmet") {
    var_05 = 100;
    var_03 = 250;
    var_08 = 0;
  }

  playFXOnTag(level._effect["vfx_item_entagled"], var_07, param_02);
  thread delaykillfx(var_07, param_02, param_00);
  param_00 thread monitorplayerviewangles(param_00, var_07);
  var_0C = 0;
  var_0D = 0;
  for(var_0E = 0; isDefined(param_00) && param_00 getcurrentweapon() == "iw7_entangler2_zm"; var_0E++) {
    var_0F = gettime();
    if(var_07.lasteffecttime + 250 <= var_0F) {
      var_07.lasteffecttime = var_0F;
    }

    var_05 = 72;
    var_10 = param_00 getvelocity();
    var_11 = vectordot(var_10, param_00.angles);
    if(var_11 >= 1) {
      var_12 = length(var_10);
      if(var_12 >= 250) {
        var_05 = var_05 + 48;
      } else if(var_12 >= 185) {
        var_05 = var_05 + 24;
      } else if(var_12 >= 100) {
        var_05 = var_05 + 12;
      }
    }

    var_13 = var_0C >= 10;
    var_14 = var_0C >= 20;
    var_0D = var_0E >= 5;
    var_15 = scripts\engine\utility::array_combine(level.players, [var_07]);
    var_16 = param_00 getEye();
    var_17 = param_00.origin + (0, 0, 56);
    var_18 = (0, var_05, 0);
    var_19 = param_00 getplayerangles();
    var_1A = anglesToForward(var_19);
    var_1B = anglestoup(var_19);
    var_1C = anglestoright(var_19);
    var_1D = var_06;
    var_17 = var_17 + var_18[0] * var_1C;
    var_17 = var_17 + var_18[1] * var_1A;
    var_17 = var_17 + var_18[2] * var_1B;
    var_1E = rotatepointaroundvector(anglestoup(var_19), anglesToForward(var_19), var_1D);
    var_1F = var_17 + var_1E;
    var_20 = var_1F[2];
    var_21 = scripts\engine\utility::drop_to_ground(var_16, 12, -100)[2] + 16;
    var_22 = min(var_16[2] + 12, var_21 + 56);
    var_20 = clamp(var_1F[2], var_21, var_22);
    var_1F = (var_1F[0], var_1F[1], var_20);
    if(isDefined(param_01.entanglerangleupdate)) {
      var_17 = [
        [param_01.entanglerangleupdate]
      ](param_00, param_01, var_07);
      var_23 = vectortoangles(var_17 - var_07.origin);
    } else {
      var_23 = vectortoangles(param_00.origin - var_07.origin);
    }

    if(var_07.model == "cp_final_subway_turnstyle_arm") {
      var_07.angles = (var_23[0], var_23[1], var_23[2]);
    } else {
      var_07.angles = (var_07.angles[0], var_23[1], var_23[2]);
    }

    var_24 = distance(var_07.origin, var_1F);
    var_04 = var_24 / var_03;
    if(var_04 < 0.05) {
      var_04 = 0.05;
    }

    if(var_08) {
      if(scripts\engine\utility::istrue(param_00.is_off_grid) || scripts\engine\utility::istrue(param_00.isfasttravelling)) {
        var_13 = 0;
        var_0C = 0;
        var_07.origin = var_1F;
      } else if(!isDefined(param_01.entanglemovetofunc)) {
        if(var_0D) {
          var_25 = var_07.origin + anglesToForward(vectortoangles(param_00.origin - var_07.origin)) * 12;
          var_26 = scripts\common\trace::capsule_trace(var_25, var_1F, var_0B[0], var_0B[1], undefined, var_15, var_09, 1);
          var_1F = var_26["shape_position"] - (0, 0, var_26["shape_position"][2]) + (0, 0, var_20);
        }

        if(var_24 <= 64) {
          var_07.origin = var_1F;
        } else {
          var_07 moveto(var_1F, var_04);
          param_00 scripts\engine\utility::waittill_any_timeout_1(var_04, "update_item_pos", "delete_equipment");
        }
      } else if(isDefined(param_01.entanglemovetofunc)) {
        var_13 = 0;
        if([
            [param_01.entanglemovetofunc]
          ](param_01, var_1F, var_07, param_00)) {
          if(var_24 <= 64) {
            var_07.origin = var_1F;
          } else {
            var_07 moveto(var_1F, var_04);
            param_00 scripts\engine\utility::waittill_any_timeout_1(var_04, "update_item_pos", "delete_equipment");
          }
        } else {
          var_15 = scripts\engine\utility::array_combine(level.players, [var_07]);
          var_26 = scripts\common\trace::capsule_trace(param_01.origin, param_00.origin, var_0B[0], var_0B[1], undefined, var_15, var_09, 24);
          var_27 = var_26["shape_position"] + (0, 0, 32);
          var_07.origin = var_27;
        }
      } else if(var_24 <= 56) {
        var_07.origin = var_1F;
      } else {
        var_07 moveto(var_1F, var_04);
        param_00 scripts\engine\utility::waittill_any_timeout_1(var_04, "update_item_pos", "delete_equipment");
      }

      scripts\engine\utility::waitframe();
      if(var_13) {
        var_25 = var_07.origin + anglesToForward(var_07.angles) * 18;
        var_15 = scripts\engine\utility::array_combine(level.players, [var_07]);
        var_28 = scripts\common\trace::ray_trace(var_16, var_25 + (0, 0, 16), var_15, var_0A);
        if(isDefined(var_28["hittype"]) && var_28["hittype"] != "hittype_none") {
          if(var_28["hittype"] == "hittype_entity" && isDefined(var_28["entity"]) && !isplayer(var_28["entity"])) {
            if(var_14) {
              var_07.forcerelease = 1;
              param_00 notify("item_released");
            }
          } else {
            var_07.forcerelease = 1;
            param_00 notify("item_released");
          }
        } else {
          var_0C = 0;
          continue;
        }
      }
    } else if(var_24 >= 8) {
      var_07 moveto(var_1F, var_04);
      param_00 scripts\engine\utility::waittill_any_timeout_1(var_04, "update_item_pos", "delete_equipment");
    } else {
      scripts\engine\utility::waitframe();
      if(var_13) {
        var_25 = var_07.origin + anglesToForward(var_07.angles) * 18;
        var_15 = scripts\engine\utility::array_combine(level.players, [var_07]);
        var_28 = scripts\common\trace::ray_trace(var_16, var_25 + (0, 0, 16), var_15, var_0A);
        if(isDefined(var_28["hittype"]) && var_28["hittype"] != "hittype_none") {
          if(var_28["hittype"] == "hittype_entity" && isDefined(var_28["entity"]) && !isplayer(var_28["entity"])) {
            if(var_14) {
              var_07.forcerelease = 1;
              param_00 notify("item_released");
            }
          } else {
            var_07.forcerelease = 1;
            param_00 notify("item_released");
          }
        } else {
          var_0C = 0;
          continue;
        }
      }
    }

    var_0C++;
  }
}

delaykillfx(param_00, param_01, param_02) {
  level endon("game_ended");
  param_02 scripts\engine\utility::waittill_any_3("disconnect", "end_move_towards_player");
  stopFXOnTag(level._effect["vfx_item_entagled"], param_00, param_01);
}

getcapsulefrommodel(param_00) {
  switch (param_00.model) {
    case "cp_final_brute_mascot_mask":
      return [16, 32];

    case "final_kevin_head":
      return [10, 20];

    case "ref_space_helmet_02":
      return [8, 16];

    default:
      return [12, 24];
  }
}

monitorplayerviewangles(param_00, param_01) {
  param_00 endon("disconnect");
  param_01 endon("death");
  param_00 endon("item_released");
  level endon("entangler_removed_" + param_00.name);
  for(;;) {
    var_02 = param_00 getEye();
    var_03 = vectornormalize(anglesToForward(param_00 getplayerangles())) * 72;
    var_04 = var_02 + var_03;
    if(distance(param_01.origin, var_04) >= 5) {
      param_00 notify("update_item_pos");
    }

    scripts\engine\utility::waitframe();
  }
}

launchitem(param_00, param_01, param_02) {
  level endon("game_ended");
  if(isDefined(param_00)) {
    param_00 endon("disconnect");
    var_03 = [param_00, param_01];
  } else {
    var_03 = [param_02];
  }

  if(!isDefined(param_01)) {
    if(isDefined(param_00) && isDefined(param_00.entangledmodel)) {
      param_01 = param_00.entangledmodel;
    } else {
      return;
    }
  }

  if(isDefined(param_00)) {
    param_00.entangledmodel = undefined;
  }

  param_01.launched = 1;
  if(isDefined(param_00)) {
    var_04 = param_00 getEye();
  } else {
    var_04 = param_02.origin;
  }

  var_05 = param_01.origin;
  var_06 = (0, 10000, 0);
  if(isDefined(param_00)) {
    var_07 = param_00 getplayerangles();
  } else {
    var_07 = anglesToForward(param_02.angles) * -1;
  }

  var_08 = 0;
  var_05 = var_05 + var_06[0] * anglestoright(var_07);
  var_05 = var_05 + var_06[1] * anglesToForward(var_07);
  var_05 = var_05 + var_06[2] * anglestoup(var_07);
  var_09 = rotatepointaroundvector(anglestoup(var_07), anglesToForward(var_07), var_08);
  var_0A = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 0, 1);
  var_0B = scripts\common\trace::capsule_trace(var_04, var_05 + var_09, 16, 32, undefined, var_03, var_0A, 24);
  var_0C = var_0B["shape_position"];
  var_0D = var_05;
  var_0E = vectornormalize(var_05 - var_0C);
  var_0E = var_0E * 10000;
  if(isDefined(param_01.script_parameters) && param_01.script_parameters == "heavy_helmet") {
    var_0E = var_0E / 2;
  }

  if(scripts\engine\utility::istrue(param_01.forcerelease)) {
    var_0F = scripts\engine\utility::drop_to_ground(param_01.origin, 24, -200);
    var_10 = -150;
    var_0E = trajectorycalculateinitialvelocity(var_0F + (0, 0, 20), var_0F + (0, 0, 20) + (randomintrange(-10, 10), randomintrange(-10, 10), 0), (0, 0, var_10), 2);
    param_01.forcerelease = undefined;
  }

  param_01 physicslaunchserver(var_0D, var_0E);
  param_01 physics_registerforcollisioncallback();
  if(isDefined(param_01.collisionfunc)) {
    thread[[param_01.collisionfunc]](param_01, param_02, param_00);
    return;
  }

  thread delaykillitem(param_01, param_02, param_00);
}

delaykillitem(param_00, param_01, param_02) {
  level endon("game_ended");
  param_00 waittill("collision", var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
  var_0B = gettime();
  param_00.soundlastplayed = var_0B;
  playsoundatpos(param_00.origin, "weap_axe_throw_impact");
  var_0C = param_00.origin;
  for(var_0D = 0; var_0D <= 20; var_0D++) {
    var_0E = param_00.origin;
    var_0F = param_00.angles;
    param_00 scripts\engine\utility::waittill_any_timeout_1(0.1, "collision");
    level notify("entangler_item_collision", param_00.origin);
    if(distance(var_0E, param_00.origin) < 1 && var_0F == param_00.angles) {
      break;
    }

    var_0B = gettime();
    if(param_00.soundlastplayed <= var_0B - 250) {
      param_00.soundlastplayed = var_0B;
      playsoundatpos(param_00.origin, "weap_axe_throw_impact");
    }
  }

  if(var_0D >= 20) {
    param_00.forcedrespawn = 1;
  }

  param_00.hasbeenthrown = 1;
  param_00.launched = undefined;
  param_00 notify("released");
  param_00.var_A5AB = 0;
}

outlineitemforplayers(param_00, param_01) {}

outlineitemforplayer(param_00, param_01) {
  if(!isDefined(param_01)) {
    return;
  }

  level endon("game_ended");
  param_00 endon("disconnect");
  param_01 endon("death");
  entangleritemoutlinemonitor(param_00, param_01);
  if(!isDefined(param_01)) {
    return;
  }

  param_01 hudoutlinedisableforclient(param_00);
}

entangleritemoutlinemonitor(param_00, param_01) {
  level endon("game_ended");
  level endon("entangler_removed_" + param_00.name);
  param_00 endon("disconnect");
  param_01 endon("end_entangler_funcs");
  param_01 endon("death");
  for(;;) {
    if(isDefined(param_01)) {
      if(isDefined(param_00.entangledmodel) && param_00.entangledmodel == param_01) {
        param_01 hudoutlinedisableforclient(param_00);
      } else if(scripts\engine\utility::istrue(param_01.launched)) {
        param_01 hudoutlinedisableforclient(param_00);
      } else if(distance(param_00.origin, param_01.origin) <= 500) {
        param_01 hudoutlineenableforclient(param_00, 5, 1, 0, 0);
      } else {
        param_01 hudoutlinedisableforclient(param_00);
      }
    } else {
      break;
    }

    wait(0.25);
  }
}