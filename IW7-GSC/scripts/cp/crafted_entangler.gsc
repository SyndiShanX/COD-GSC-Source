/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\crafted_entangler.gsc
*********************************************/

init() {
  var_0 = spawnStruct();
  var_0.timeout = 60;
  var_0.var_9F43 = 0;
  if(!isDefined(level.var_47B3)) {
    level.var_47B3 = [];
  }

  level.var_47B3["crafted_entangler"] = var_0;
  level thread watchforentangleractivation();
  initentanglermodels();
}

watchforentangleractivation() {
  level endon("game_ended");
  level waittill("complete_stay_on_pressure_plates");
  scripts\cp\utility::set_quest_icon(2);
  scripts\cp\maps\cp_final\cp_final_mpq::activateinteractionsbynoteworthy("entangler_spawner");
  var_0 = scripts\engine\utility::getstruct("entangler_spawner", "script_noteworthy");
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel("weapon_entangler_wm");
  var_1 thread moveandrotateentangler(var_1, var_0.origin);
  var_2 = spawn("script_model", scripts\engine\utility::drop_to_ground(var_0.origin, 12, -100) + (0, 0, 1));
  var_2 setModel("final_gns_quest_origin");
  var_1.fx = var_2;
  var_1.fx setscriptablepartstate("pressure_plate", "on");
  var_0.var_870F = var_1;
}

moveandrotateentangler(var_0, var_1) {
  level endon("game_ended");
  for(;;) {
    var_0 rotateyaw(360, 6);
    var_0 moveto(var_1 + (0, 0, 48), 3, 1, 1);
    wait(3);
    var_0 moveto(var_1, 3, 0.5, 0.5);
    wait(3);
  }
}

give_crafted_entangler(var_0, var_1) {
  var_1 thread watch_dpad();
  var_1 notify("new_power", "crafted_entangler");
  var_1 setclientomnvar("zom_crafted_weapon", 19);
  var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
  var_1.hascraftedentangler = 1;
  scripts\cp\utility::set_crafted_inventory_item("crafted_entangler", ::give_crafted_entangler, var_1);
}

unsetentanglerflagondeath(var_0) {
  var_0 endon("disconnect");
  var_0 endon("craft_dpad_watcher");
  var_0 waittill("death");
  var_0.hascollectedentangler = undefined;
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

give_entangler(var_0) {
  var_0 endon("disconnect");
  foreach(var_2 in level.wall_buy_interactions) {
    if(isDefined(var_2.trigger)) {
      var_2.trigger hidefromplayer(var_0);
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_2, var_0);
  }

  level notify("entangler_given", var_0);
  var_0.hasentanglerequipped = 1;
  var_0 scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_0.itemtype = "entangler";
  var_0 removeperks();
  var_0.restoreweapon = var_0 scripts\cp\utility::getvalidtakeweapon();
  var_4 = "iw7_entangler2_zm";
  if(scripts\engine\utility::flag("meph_fight")) {
    var_4 = "iw7_entangler_zm";
  }

  var_0.isusingsupercard = 1;
  var_0 scripts\cp\utility::_giveweapon(var_4, undefined, undefined, 1);
  var_0 switchtoweapon(var_4);
  var_5 = var_0 watchforputaway();
  var_0.hasentanglerequipped = undefined;
  foreach(var_2 in level.wall_buy_interactions) {
    if(scripts\engine\utility::istrue(var_2.should_be_hidden)) {
      continue;
    }

    if(isDefined(var_2.trigger)) {
      var_2.trigger showtoplayer(var_0);
    }

    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_2, var_0);
  }

  var_0.isusingsupercard = undefined;
  var_0.carriedsentry = undefined;
  var_0 thread waitrestoreperks();
  var_0 restoreweapons();
  var_0.iscarrying = 0;
  var_0 notify("entangler_removed");
  level notify("entangler_removed_" + var_0.name);
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
    var_0 = scripts\cp\utility::waittill_any_ents_return(self, "cancel_entangler", self, "craft_dpad_watcher", self, "weapon_purchased", self, "last_stand", self, "death", level, "players_activated_gns");
    if(scripts\engine\utility::istrue(self.playing_ghosts_n_skulls)) {
      continue;
    }

    if(isDefined(var_0)) {
      if(var_0 == "death") {
        self.hascollectedentangler = undefined;
      }

      if(var_0 == "craft_dpad_watcher") {
        if(!scripts\engine\utility::isweaponswitchallowed()) {
          scripts\engine\utility::allow_weapon_switch(1);
        }

        if(scripts\engine\utility::flag("meph_fight")) {
          var_1 = "iw7_entangler_zm";
        } else {
          var_1 = "iw7_entangler2_zm";
          self.hascollectedentangler = undefined;
        }

        if(self hasweapon(var_1)) {
          self takeweapon(var_1);
        }

        scripts\cp\utility::remove_crafted_item_from_inventory(self);
        self notify("end_Ghost_Idle_Loop");
        break;
      } else {
        if(!scripts\engine\utility::isweaponswitchallowed()) {
          scripts\engine\utility::allow_weapon_switch(1);
        }

        var_1 = "iw7_entangler2_zm";
        if(scripts\engine\utility::flag("meph_fight")) {
          var_1 = "iw7_entangler_zm";
        }

        if(self hasweapon(var_1)) {
          self takeweapon(var_1);
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

entangleitem(var_0, var_1, var_2) {
  var_2 endon("death");
  if(isDefined(var_0)) {
    var_0 notifyonplayercommand("item_released", "-attack");
    var_0 setscriptablepartstate("entangler", "active");
  }

  var_2 notify("item_entangled");
  if(var_0 scripts\cp\utility::isweaponfireenabled()) {
    var_0 scripts\engine\utility::allow_fire(0);
  }

  if(var_0 scripts\cp\utility::issprintenabled()) {
    var_0 scripts\engine\utility::allow_sprint(0);
  }

  if(var_2.model == "cp_final_brute_mascot_mask") {
    var_2 scripts\cp\maps\cp_final\cp_final_interactions::helmet_not_useable();
  }

  var_3 = gettagfrommodel(var_2);
  var_4 = playfxontagsbetweenclients(level._effect["entangler_beam"], var_0, "tag_flash", var_2, var_3);
  var_2.entangled = 1;
  var_2.carriedby = var_0;
  moveitemtowardsplayer(var_0, var_1, var_3);
  if(!isDefined(var_0)) {
    var_2.forcerelease = 1;
  }

  if(isDefined(var_0)) {
    var_0 notify("end_move_towards_player");
    var_0 setscriptablepartstate("entangler", "fired");
  }

  if(isDefined(var_4)) {
    var_4 delete();
  }

  if(isDefined(var_0)) {
    if(!var_0 scripts\cp\utility::isweaponfireenabled()) {
      var_0 scripts\engine\utility::allow_fire(1);
    }

    if(!var_0 scripts\cp\utility::issprintenabled()) {
      var_0 scripts\engine\utility::allow_sprint(1);
    }
  }

  if(isDefined(var_2.customlaunchfunc)) {
    thread[[var_2.customlaunchfunc]](var_0, var_2, var_1);
    return;
  }

  launchitem(var_0, var_2, var_1);
}

releaseitemaftertime(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("item_released");
  var_0 endon("entangler_removed");
  wait(gettimeoutfrommodel(var_1));
  var_1.forcerelease = 1;
  var_0 notify("item_released");
}

gettimeoutfrommodel(var_0) {
  switch (var_0.model) {
    case "ref_space_helmet_02":
      return 60;

    default:
      return 90;
  }
}

gettagfrommodel(var_0) {
  switch (var_0.model) {
    case "ref_space_helmet_02":
      return "us_space_helmet_a_lod1";

    default:
      return "tag_origin";
  }
}

initentanglermodels() {
  var_0 = scripts\engine\utility::getStructArray("entangler_structs", "targetname");
  foreach(var_2 in var_0) {
    level thread spawnentanglermodel(var_2);
  }
}

spawnentanglermodel(var_0, var_1, var_2) {
  if(isDefined(var_0.entanglemodel)) {
    var_0.entanglemodel scripts\cp\cp_weapon::placeequipmentfailed("pillage", 1, var_0.entanglemodel.origin);
    var_0.entanglemodel delete();
  }

  if(isDefined(var_1)) {
    var_3 = var_1;
  } else {
    var_3 = var_1.origin;
  }

  if(isDefined(var_2)) {
    var_4 = var_2;
  } else if(isDefined(var_1.angles)) {
    var_4 = var_1.angles;
  } else {
    var_4 = (0, 0, 0);
  }

  var_5 = spawn("script_model", var_3);
  var_5.angles = var_4;
  if(isDefined(var_0.script_noteworthy)) {
    var_5 setModel(var_0.script_noteworthy);
  } else {
    var_5 setModel("ref_space_helmet_02");
  }

  var_0.entanglemodel = var_5;
  var_0 notify("new_model_created");
  var_5.parent_struct = var_0;
  var_5 thread watchforentanglerdamage(var_0, var_5);
  var_5 thread outlineitemforplayers(var_0, var_5);
}

watchforentanglerdamage(var_0, var_1) {
  var_1 notify("watchForEntanglerDamage");
  var_1 endon("watchForEntanglerDamage");
  level endon("game_ended");
  var_0 endon("new_model_created");
  var_0 endon("vent_grabbed_puzzle_piece");
  var_1 endon("end_entangler_funcs");
  var_0 endon("stop_watching_for_entangler_damage");
  var_1 setCanDamage(1);
  var_1.health = 9999999;
  var_1.maxhealth = 9999999;
  for(;;) {
    var_1 waittill("damage", var_2, var_3, var_2, var_2, var_2, var_2, var_2, var_2, var_2, var_4);
    if(isDefined(var_4) && getweaponbasename(var_4) == "iw7_entangler2_zm") {
      var_3.entangledmodel = var_1;
      thread entangleitem(var_3, var_0, var_1);
      var_1 waittill("released", var_5, var_6, var_7);
      var_8 = isDefined(var_0.groupname);
      var_9 = var_1.origin;
      if(var_1 istouching(getent("electric_trap_trig", "targetname"))) {
        var_5 = 1;
      }

      if(!scripts\engine\utility::istrue(var_5) && scripts\cp\maps\cp_final\cp_final::validateplayspace(var_9, var_3, var_8, var_8, var_7)) {
        if(var_1.model == "cp_final_brute_mascot_mask") {
          var_1 scripts\cp\maps\cp_final\cp_final_interactions::helmet_useable();
        } else {
          var_1 physicsstopserver();
          if(isDefined(var_0.groupname)) {
            level.undergratepuzzlepiece = var_1;
            level notify("vent_fx");
          }

          if(scripts\engine\utility::istrue(var_6)) {
            var_1 notify("end_entangler_funcs");
          }
        }
      } else if(isDefined(var_0.var_1088C)) {
        thread[[var_0.var_1088C]](var_0.id, var_0);
      } else if(var_1.model == "cp_final_brute_mascot_mask") {
        var_1 scripts\cp\maps\cp_final\cp_final_interactions::helmet_useable();
        level.brute_helm_out_of_bounds = 1;
      } else {
        level thread spawnentanglermodel(var_0, var_0.origin, var_0.angles);
      }
    }
  }
}

moveitemtowardsplayer(var_0, var_1, var_2) {
  var_0 endon("entangler_removed");
  var_0 endon("disconnect");
  var_0 endon("item_released");
  level endon("entangler_removed_" + var_0.name);
  wait(0.1);
  var_3 = 1250;
  var_4 = 0;
  var_5 = 72;
  var_6 = 0;
  var_7 = var_0.entangledmodel;
  var_8 = 1;
  var_9 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 0, 1);
  var_10 = scripts\common\trace::create_contents(1, 1, 1, 1, 1, 0, 0);
  var_11 = getcapsulefrommodel(var_7);
  var_7 endon("end_entangle_move_to_logic");
  var_7.lasteffecttime = 0;
  if(isDefined(var_7.script_parameters) && var_7.script_parameters == "heavy_helmet") {
    var_5 = 100;
    var_3 = 250;
    var_8 = 0;
  }

  playFXOnTag(level._effect["vfx_item_entagled"], var_7, var_2);
  thread delaykillfx(var_7, var_2, var_0);
  var_0 thread monitorplayerviewangles(var_0, var_7);
  var_12 = 0;
  var_13 = 0;
  for(var_14 = 0; isDefined(var_0) && var_0 getcurrentweapon() == "iw7_entangler2_zm"; var_14++) {
    var_15 = gettime();
    if(var_7.lasteffecttime + 250 <= var_15) {
      var_7.lasteffecttime = var_15;
    }

    var_5 = 72;
    var_10 = var_0 getvelocity();
    var_11 = vectordot(var_10, var_0.angles);
    if(var_11 >= 1) {
      var_12 = length(var_10);
      if(var_12 >= 250) {
        var_5 = var_5 + 48;
      } else if(var_12 >= 185) {
        var_5 = var_5 + 24;
      } else if(var_12 >= 100) {
        var_5 = var_5 + 12;
      }
    }

    var_13 = var_12 >= 10;
    var_14 = var_12 >= 20;
    var_13 = var_14 >= 5;
    var_15 = scripts\engine\utility::array_combine(level.players, [var_7]);
    var_16 = var_0 getEye();
    var_17 = var_0.origin + (0, 0, 56);
    var_18 = (0, var_5, 0);
    var_19 = var_0 getplayerangles();
    var_1A = anglesToForward(var_19);
    var_1B = anglestoup(var_19);
    var_1C = anglestoright(var_19);
    var_1D = var_6;
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
    if(isDefined(var_1.entanglerangleupdate)) {
      var_17 = [[var_1.entanglerangleupdate]](var_0, var_1, var_7);
      var_23 = vectortoangles(var_17 - var_7.origin);
    } else {
      var_23 = vectortoangles(var_0.origin - var_7.origin);
    }

    if(var_7.model == "cp_final_subway_turnstyle_arm") {
      var_7.angles = (var_23[0], var_23[1], var_23[2]);
    } else {
      var_7.angles = (var_7.angles[0], var_23[1], var_23[2]);
    }

    var_24 = distance(var_7.origin, var_1F);
    var_4 = var_24 / var_3;
    if(var_4 < 0.05) {
      var_4 = 0.05;
    }

    if(var_8) {
      if(scripts\engine\utility::istrue(var_0.is_off_grid) || scripts\engine\utility::istrue(var_0.isfasttravelling)) {
        var_13 = 0;
        var_12 = 0;
        var_7.origin = var_1F;
      } else if(!isDefined(var_1.entanglemovetofunc)) {
        if(var_13) {
          var_25 = var_7.origin + anglesToForward(vectortoangles(var_0.origin - var_7.origin)) * 12;
          var_26 = scripts\common\trace::capsule_trace(var_25, var_1F, var_11[0], var_11[1], undefined, var_15, var_9, 1);
          var_1F = var_26["shape_position"] - (0, 0, var_26["shape_position"][2]) + (0, 0, var_20);
        }

        if(var_24 <= 64) {
          var_7.origin = var_1F;
        } else {
          var_7 moveto(var_1F, var_4);
          var_0 scripts\engine\utility::waittill_any_timeout(var_4, "update_item_pos", "delete_equipment");
        }
      } else if(isDefined(var_1.entanglemovetofunc)) {
        var_13 = 0;
        if([[var_1.entanglemovetofunc]](var_1, var_1F, var_7, var_0)) {
          if(var_24 <= 64) {
            var_7.origin = var_1F;
          } else {
            var_7 moveto(var_1F, var_4);
            var_0 scripts\engine\utility::waittill_any_timeout(var_4, "update_item_pos", "delete_equipment");
          }
        } else {
          var_15 = scripts\engine\utility::array_combine(level.players, [var_7]);
          var_26 = scripts\common\trace::capsule_trace(var_1.origin, var_0.origin, var_11[0], var_11[1], undefined, var_15, var_9, 24);
          var_27 = var_26["shape_position"] + (0, 0, 32);
          var_7.origin = var_27;
        }
      } else if(var_24 <= 56) {
        var_7.origin = var_1F;
      } else {
        var_7 moveto(var_1F, var_4);
        var_0 scripts\engine\utility::waittill_any_timeout(var_4, "update_item_pos", "delete_equipment");
      }

      scripts\engine\utility::waitframe();
      if(var_13) {
        var_25 = var_7.origin + anglesToForward(var_7.angles) * 18;
        var_15 = scripts\engine\utility::array_combine(level.players, [var_7]);
        var_28 = scripts\common\trace::ray_trace(var_16, var_25 + (0, 0, 16), var_15, var_10);
        if(isDefined(var_28["hittype"]) && var_28["hittype"] != "hittype_none") {
          if(var_28["hittype"] == "hittype_entity" && isDefined(var_28["entity"]) && !isPlayer(var_28["entity"])) {
            if(var_14) {
              var_7.forcerelease = 1;
              var_0 notify("item_released");
            }
          } else {
            var_7.forcerelease = 1;
            var_0 notify("item_released");
          }
        } else {
          var_12 = 0;
          continue;
        }
      }
    } else if(var_24 >= 8) {
      var_7 moveto(var_1F, var_4);
      var_0 scripts\engine\utility::waittill_any_timeout(var_4, "update_item_pos", "delete_equipment");
    } else {
      scripts\engine\utility::waitframe();
      if(var_13) {
        var_25 = var_7.origin + anglesToForward(var_7.angles) * 18;
        var_15 = scripts\engine\utility::array_combine(level.players, [var_7]);
        var_28 = scripts\common\trace::ray_trace(var_16, var_25 + (0, 0, 16), var_15, var_10);
        if(isDefined(var_28["hittype"]) && var_28["hittype"] != "hittype_none") {
          if(var_28["hittype"] == "hittype_entity" && isDefined(var_28["entity"]) && !isPlayer(var_28["entity"])) {
            if(var_14) {
              var_7.forcerelease = 1;
              var_0 notify("item_released");
            }
          } else {
            var_7.forcerelease = 1;
            var_0 notify("item_released");
          }
        } else {
          var_12 = 0;
          continue;
        }
      }
    }

    var_12++;
  }
}

delaykillfx(var_0, var_1, var_2) {
  level endon("game_ended");
  var_2 scripts\engine\utility::waittill_any("disconnect", "end_move_towards_player");
  stopFXOnTag(level._effect["vfx_item_entagled"], var_0, var_1);
}

getcapsulefrommodel(var_0) {
  switch (var_0.model) {
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

monitorplayerviewangles(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 endon("death");
  var_0 endon("item_released");
  level endon("entangler_removed_" + var_0.name);
  for(;;) {
    var_2 = var_0 getEye();
    var_3 = vectornormalize(anglesToForward(var_0 getplayerangles())) * 72;
    var_4 = var_2 + var_3;
    if(distance(var_1.origin, var_4) >= 5) {
      var_0 notify("update_item_pos");
    }

    scripts\engine\utility::waitframe();
  }
}

launchitem(var_0, var_1, var_2) {
  level endon("game_ended");
  if(isDefined(var_0)) {
    var_0 endon("disconnect");
    var_3 = [var_0, var_1];
  } else {
    var_3 = [var_2];
  }

  if(!isDefined(var_1)) {
    if(isDefined(var_0) && isDefined(var_0.entangledmodel)) {
      var_1 = var_0.entangledmodel;
    } else {
      return;
    }
  }

  if(isDefined(var_0)) {
    var_0.entangledmodel = undefined;
  }

  var_1.launched = 1;
  if(isDefined(var_0)) {
    var_4 = var_0 getEye();
  } else {
    var_4 = var_2.origin;
  }

  var_5 = var_1.origin;
  var_6 = (0, 10000, 0);
  if(isDefined(var_0)) {
    var_7 = var_0 getplayerangles();
  } else {
    var_7 = anglesToForward(var_2.angles) * -1;
  }

  var_8 = 0;
  var_5 = var_5 + var_6[0] * anglestoright(var_7);
  var_5 = var_5 + var_6[1] * anglesToForward(var_7);
  var_5 = var_5 + var_6[2] * anglestoup(var_7);
  var_9 = rotatepointaroundvector(anglestoup(var_7), anglesToForward(var_7), var_8);
  var_10 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 0, 1);
  var_11 = scripts\common\trace::capsule_trace(var_4, var_5 + var_9, 16, 32, undefined, var_3, var_10, 24);
  var_12 = var_11["shape_position"];
  var_13 = var_5;
  var_14 = vectornormalize(var_5 - var_12);
  var_14 = var_14 * 10000;
  if(isDefined(var_1.script_parameters) && var_1.script_parameters == "heavy_helmet") {
    var_14 = var_14 / 2;
  }

  if(scripts\engine\utility::istrue(var_1.forcerelease)) {
    var_15 = scripts\engine\utility::drop_to_ground(var_1.origin, 24, -200);
    var_10 = -150;
    var_14 = trajectorycalculateinitialvelocity(var_15 + (0, 0, 20), var_15 + (0, 0, 20) + (randomintrange(-10, 10), randomintrange(-10, 10), 0), (0, 0, var_10), 2);
    var_1.forcerelease = undefined;
  }

  var_1 physicslaunchserver(var_13, var_14);
  var_1 physics_registerforcollisioncallback();
  if(isDefined(var_1.collisionfunc)) {
    thread[[var_1.collisionfunc]](var_1, var_2, var_0);
    return;
  }

  thread delaykillitem(var_1, var_2, var_0);
}

delaykillitem(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 waittill("collision", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  var_11 = gettime();
  var_0.soundlastplayed = var_11;
  playsoundatpos(var_0.origin, "weap_axe_throw_impact");
  var_12 = var_0.origin;
  for(var_13 = 0; var_13 <= 20; var_13++) {
    var_14 = var_0.origin;
    var_15 = var_0.angles;
    var_0 scripts\engine\utility::waittill_any_timeout(0.1, "collision");
    level notify("entangler_item_collision", var_0.origin);
    if(distance(var_14, var_0.origin) < 1 && var_15 == var_0.angles) {
      break;
    }

    var_11 = gettime();
    if(var_0.soundlastplayed <= var_11 - 250) {
      var_0.soundlastplayed = var_11;
      playsoundatpos(var_0.origin, "weap_axe_throw_impact");
    }
  }

  if(var_13 >= 20) {
    var_0.forcedrespawn = 1;
  }

  var_0.hasbeenthrown = 1;
  var_0.launched = undefined;
  var_0 notify("released");
  var_0.var_A5AB = 0;
}

outlineitemforplayers(var_0, var_1) {}

outlineitemforplayer(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }

  level endon("game_ended");
  var_0 endon("disconnect");
  var_1 endon("death");
  entangleritemoutlinemonitor(var_0, var_1);
  if(!isDefined(var_1)) {
    return;
  }

  var_1 hudoutlinedisableforclient(var_0);
}

entangleritemoutlinemonitor(var_0, var_1) {
  level endon("game_ended");
  level endon("entangler_removed_" + var_0.name);
  var_0 endon("disconnect");
  var_1 endon("end_entangler_funcs");
  var_1 endon("death");
  for(;;) {
    if(isDefined(var_1)) {
      if(isDefined(var_0.entangledmodel) && var_0.entangledmodel == var_1) {
        var_1 hudoutlinedisableforclient(var_0);
      } else if(scripts\engine\utility::istrue(var_1.launched)) {
        var_1 hudoutlinedisableforclient(var_0);
      } else if(distance(var_0.origin, var_1.origin) <= 500) {
        var_1 hudoutlineenableforclient(var_0, 5, 1, 0, 0);
      } else {
        var_1 hudoutlinedisableforclient(var_0);
      }
    } else {
      break;
    }

    wait(0.25);
  }
}