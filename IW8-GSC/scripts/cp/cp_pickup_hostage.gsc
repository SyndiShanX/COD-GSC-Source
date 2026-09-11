/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_pickup_hostage.gsc
***********************************************/

#using_animtree("script_model");

function registerhvtscriptmodels() {
  level.scr_animtree["hvt"] = #animtree;
  init_anims();
}

function initdefaulthvtmodel(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_1)) {
    if(istrue(var_7)) {
      var_1 = "morales_hostage_fullbody";
    } else {
      var_1 = "british_pilot_fullbody";
    }
  }

  if(!isDefined(var_3)) {
    var_3 = &"CP_BR_SYRK_OBJECTIVES/HVT_PICKUP";
  }

  if(!isDefined(var_4)) {
    var_4 = "drop_pilot_hostage";
  }

  var_8 = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_ainosight"]);
  var_9 = scripts\engine\trace::ray_trace(var_0 + (0, 0, 100), var_0 - (0, 0, 100), undefined, var_8);
  var_10 = spawn("script_model", var_9["position"]);
  var_10.body = spawn("script_model", var_10.origin);
  var_10.body setModel(var_1);
  var_10.body linkTo(var_10);
  var_10.idleanim = scripts\engine\utility::ter_op(istrue(var_7), "sdr_cp_hostage_dropoff_ground_idle_female", "sdr_cp_hostage_dropoff_ground_idle_pilot");
  var_10.shownonspectatingwinnersplash = scripts\engine\utility::ter_op(istrue(var_7), (-6, 1, 0), (-9, 1, 0));
  var_10.ref_135ab = var_10.origin;

  if(isDefined(var_2)) {
    var_10.head = spawn("script_model", var_10.origin);
    var_10.head setModel(var_2);
    var_10.head linkTo(var_10.body, "j_neck", var_10.shownonspectatingwinnersplash, (0, 0, 0));
    var_10.head.animname = "hvt";
    var_10.head useanimtree(level.scr_animtree["hvt"]);
    var_10.headmodel = var_2;
    var_10.head scriptmodelplayanim(var_10.idleanim);
  }

  var_10.gender = scripts\engine\utility::ter_op(istrue(var_7), "female", "male");
  var_10.body.animname = "hvt";
  var_10.body useanimtree(level.scr_animtree["hvt"]);
  var_10.bodymodel = var_1;
  var_10.drophintstring = var_4;
  var_10.pickuphintstring = var_3;
  var_10.body scriptmodelplayanim(var_10.idleanim);
  var_10.carryobjectasset = scripts\engine\utility::ter_op(isDefined(var_6), var_6, "hostage_pilot");

  if(!isDefined(level.spawnjuggernautcrateatposition)) {
    level.spawnjuggernautcrateatposition = [];
  }

  level.spawnjuggernautcrateatposition[level.spawnjuggernautcrateatposition.size] = var_10;
  thread hostage_enable_rescue(var_10, 0);
  thread ref_11d0a();
  return var_10;
}

function hostagespawnwm(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", self gettagorigin("j_clavicle_le"));
  var_4.head = spawn("script_model", self gettagorigin("j_clavicle_le"));
  var_4.angles = self gettagangles("j_clavicle_le");

  if(isDefined(var_0)) {
    var_4 setModel(var_0);
  }

  if(isDefined(var_1)) {
    var_4.head setModel(var_1);
  }

  if(!isDefined(var_2)) {
    var_2 = (-9, 1, 0);
  }

  var_4.head linkTo(var_4, "j_neck", var_2, (0, 0, 0));
  var_4 scriptmodelplayanim("sdr_cp_hostage_walk_hostage");
  var_4 linkTo(self, "j_clavicle_le");

  if(!istrue(var_3)) {
    var_4 hide();
    var_4.head hide();
  }

  if(isPlayer(self)) {
    var_4 hidefromplayer(self);
    var_4.head hidefromplayer(self);
  }

  var_4.animname = "hvt";
  var_4.head.animname = "hvt";
  var_4.head useanimtree(level.scr_animtree["hvt"]);
  var_4 useanimtree(level.scr_animtree["hvt"]);
  self.wmhostage = var_4;
  return var_4;
}

function deletepickuphostage() {
  if(isDefined(self.head)) {
    self.head delete();
  }

  self notify("delete");
  waitframe();
  self delete();
}

function hostagedrop(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("delete");

  if(!isDefined(var_0)) {
    var_0 = self.carrier;
  }

  if(!isDefined(var_2)) {
    var_2 = var_1.origin;
  }

  if(!isDefined(var_1)) {
    var_1 = self;
  }

  if(!isDefined(var_7)) {
    var_7 = 0;
  }

  var_0 notify("hostage_dropped_by_me");

  if(isDefined(self.objectiveent)) {
    self.objectiveent unlink();
    self.objectiveent.origin = self.origin;
    self.objectiveent linkTo(self);
    objective_setzoffset(self.objnum, 30);
    objective_unpinforclient(self.objnum, var_0);
  }

  if(isDefined(self.hostage_drop_override_data)) {
    var_4 = self.hostage_drop_override_data.waittime;
    var_5 = self.hostage_drop_override_data.forcepos;
    var_6 = self.hostage_drop_override_data.preventuse;
  }

  var_1.carried = 0;
  var_1.carrier = undefined;
  var_1 unlink();

  if(!var_0.inlaststand) {
    var_0 enableusability();
  }

  toggledrophintstring(0, var_0, var_1);
  var_0 notify("dropped_hostage");

  if(istrue(var_5)) {
    var_1.origin = var_2;
  } else {
    if(spawn_module_building_chopper1(var_1, var_0)) {
      if(isDefined(var_1.waittill_any_timeout_6)) {
        var_2 = var_1.waittill_any_timeout_6;
      }
    }

    var_1.origin = _getphysicspointaboutnavmesh(var_2);

    if(triggermatchendtimer(var_1)) {
      if(isDefined(var_1.waittill_any_timeout_6)) {
        var_2 = var_1.waittill_any_timeout_6;
        var_1.origin = _getphysicspointaboutnavmesh(var_2);
      }
    }

    thread spawn_module_building_chopper2(var_1);
  }

  if(!istrue(var_7)) {
    var_1.angles = registerchallenge(var_1.origin, self);
  }

  if(!isDefined(var_3) && isDefined(var_1.useobj)) {
    var_1.useobj.origin = var_1.origin;
  }

  if(isDefined(var_0)) {
    var_0.carryobject = undefined;
    var_0.disable_map_tablet = undefined;

    if(isDefined(var_0.wmhostage)) {
      var_0.wmhostage unlink();

      if(isDefined(var_0.wmhostage.head)) {
        var_0.wmhostage.head delete();
      }

      var_0.wmhostage delete();
      var_0.wmhostage = undefined;
    }

    player_restoreweapons(var_0);
    player_removecarrydebuff(var_0);
  }

  if(isDefined(var_4)) {
    wait var_4;
  }

  if(isDefined(var_0) && isDefined(var_0.hostagecarried)) {
    var_0.hostagecarried show();

    if(isDefined(var_0.hostagecarried.head)) {
      var_0.hostagecarried.head show();
    }

    var_0.hostagecarried = undefined;
    var_0.trigger_water_fx = undefined;
  }

  if(istrue(var_6)) {
    var_1 hudoutlinedisable();

    if(isDefined(var_1.head)) {
      var_1.head hudoutlinedisable();
    }

    var_1 notify("dropped");
    var_0 scripts\cp\utility::hint_prompt("enter_vehicle_with_hostage", 0);
    return var_1;
  }

  togglehvtusable(var_1, 1);

  if(!isDefined(var_1.pickuphintstring)) {
    var_1.pickuphintstring = &"CP_BR_SYRK_OBJECTIVES/HVT_PICKUP";
  }

  if(!isDefined(var_1.hostage_drop_override_data)) {
    if(isDefined(var_1.idleanim)) {
      var_1.body scriptmodelplayanim(var_1.idleanim);

      if(isDefined(var_1.head)) {
        var_1.head scriptmodelplayanim(var_1.idleanim);
      }
    }
  }

  if(!istrue(var_1.nowaypoint) && !isDefined(self.waypoint)) {
    var_1.waypoint = create_objective(var_1.origin + (0, 0, 30), "icon_waypoint_marker");
    objective_setplayintro(var_1.waypoint, 0);
    objective_setplayoutro(var_1.waypoint, 0);
  }

  thread hostage_enable_rescue(var_1);
  thread watchfordelete();
  thread ref_144c4();

  if(isDefined(var_1.hostage_drop_override_data)) {
    if(isDefined(var_1.hostage_drop_override_data.call_back_func)) {
      level thread[[var_1.hostage_drop_override_data.call_back_func]](var_1, var_1.hostage_drop_override_data);
    }

    waitframe();
    var_1.vehicle = var_1.hostage_drop_override_data.vehicle;
    var_1.hostage_drop_override_data = undefined;
  }

  var_1 notify("dropped");
  return var_1;
}

function triggermatchendtimer() {
  if(isDefined(level.outofboundstriggers)) {
    foreach(var_1 in level.outofboundstriggers) {
      if(self istouching(var_1)) {
        return true;
      }
    }
  }

  return false;
}

function _getphysicspointaboutnavmesh(var_0) {
  var_1 = scripts\engine\trace::create_contents(undefined, 1, 1, undefined, undefined, undefined, undefined);
  var_2 = physics_raycast(var_0 + (0, 0, 48), var_0 - (0, 0, 48), var_1, undefined, 0, "physicsquery_closest");
  var_3 = isDefined(var_2) && var_2.size > 0;

  if(var_3) {
    var_4 = var_2[0]["position"];
    return var_4;
  }

  return var_1;
}

function player_restoreweapons() {
  var_0 = self;

  if(istrue(var_0.inlaststand)) {
    return;
  }

  if(isDefined(var_0.spawn_module_intro4)) {
    var_0 scripts\cp\cp_weapons::_takeweapon(var_0.spawn_module_intro4);
    var_0.spawn_module_intro4 = undefined;
  }

  if(isDefined(var_0.ref_12939)) {
    self switchtoweapon(var_0.ref_12939);
    var_0.ref_12939 = undefined;
    return;
  }
}

function spawn_module_building_chopper2(var_0) {
  var_1 = hostage_confirm_good_angles(self.origin, self.angles, var_0);

  if(!istrue(var_1.failed)) {
    self.angles = var_1.angles;
    return;
  }

  var_2 = 0;
  var_3 = [];
  GscBinSkip0(0x2e, var_3.size, var_1.initpropcircles);
}

function hostage_confirm_good_angles(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1);
  var_5 = var_1;
  var_6 = var_0 + (0, 0, 24);

  if(!isDefined(var_3)) {
    var_3 = 36;
  }

  var_7 = spawnStruct();
  var_7.initprematchspawnlocations = 0;
  var_8 = 0;

  while(var_8 < 12) {
    var_9 = var_0 + anglesToForward(var_5) * var_3 + (0, 0, 24);

    if(scripts\engine\trace::ray_trace_passed(var_6, var_9, self, var_4)) {
      var_10 = var_9 - (0, 0, 4);
      var_11 = var_9 + (0, 0, 4);
      var_12 = undefined;

      if(isPlayer(var_2)) {
        var_12 = var_2 scripts\engine\trace::player_trace(var_10, var_11, var_2.angles, var_2, var_4);
      } else {
        var_12 = var_2 scripts\engine\trace::capsule_trace(var_10, var_11, 30, 60, var_2.angles, var_2, var_4);
      }

      var_13 = var_12["fraction"];

      if(isDefined(var_13) && var_13 >= 1) {
        var_7.origin = var_0;
        var_7.angles = var_5;
        var_14 = distancesquared(var_9, getclosestpointonnavmesh(var_9));

        if(var_14 > var_7.initprematchspawnlocations) {
          var_7.initprematchspawnlocations = var_14;
          var_7.initpropcircles = var_9;
        }

        return var_7;
      } else {
        var_14 = distancesquared(var_10, getclosestpointonnavmesh(var_10));

        if(var_14 > var_8.initprematchspawnlocations) {
          var_8.initprematchspawnlocations = var_14;
          var_8.initpropcircles = var_10;
        }
      }
    }

    if(var_6[1] + 30 >= 360) {
      var_6 = (var_6[0], var_6[1] - 360, var_6[2]);
    }

    var_6 = (var_6[0], var_6[1] + 30, var_6[2]);
    var_9++;
  }

  var_8.failed = 1;
  return var_8;
}

function hostage_enable_rescue(var_0, var_1) {
  self endon("delete");
  var_2 = "duration_medium";

  if(istrue(var_1)) {
    var_2 = "duration_long";
  }

  wait 1;
  togglehvtusable(1, "duration_medium");

  for(;;) {
    self.interaction_handle waittill("trigger", var_3);

    if(!var_3 scripts\cp\utility::is_valid_player() || istrue(var_3.isjuggernaut)) {
      continue;
    }

    if(istrue(self.pickup_disabled)) {
      continue;
    }

    var_3 scripts\common\utility::allow_vehicle_use(0);
    togglehvtusable(0);
    waitframe();

    if(istrue(self.carried_by_vehicle) && !istrue(self.convoy_pickedup)) {
      hostage_onuse(var_3, "truck");
    } else if(istrue(self.convoy_pickedup)) {
      hostage_onuse(var_3, "moving_ai_truck");
      self.convoy_pickedup = undefined;
    } else {
      hostage_onuse(var_3);
    }

    break;
  }

  if(var_0) {
    self notify("hostage_rescued");
    return;
  }
}

function togglehvtusable(var_0, var_1) {
  if(!isDefined(self.interaction_handle)) {
    self.interaction_handle = spawn("script_model", self.origin + (16, 0, 8));
    self.interaction_handle linkTo(self);
  }

  if(var_0) {
    self.pickup_disabled = 0;
    self.interaction_handle makeusable();

    if(!isDefined(self.interaction_handle.pickuphintstring)) {
      self.interaction_handle.pickuphintstring = &"CP_BR_SYRK_OBJECTIVES/HVT_PICKUP";
    }

    self.interaction_handle setCursorHint("HINT_BUTTON");
    self.interaction_handle setHintString(self.pickuphintstring);
    self.interaction_handle setuserange(64);
    self.interaction_handle sethintdisplayrange(128);
    self.interaction_handle sethintdisplayfov(80);
    self.interaction_handle sethintonobstruction("show");

    if(isDefined(var_1)) {
      self.interaction_handle setuseholdduration(var_1);
    } else {
      self.interaction_handle setuseholdduration("duration_short");
    }

    if(!isDefined(var_1) || var_1 == "duration_short") {
      self.interaction_handle sethintrequiresholding(0);
    } else {
      self.interaction_handle sethintrequiresholding(1);
    }

    if(!istrue(self.nowaypoint) && !isDefined(self.waypoint)) {
      self.waypoint = create_objective(self.origin + (0, 0, 30), "icon_waypoint_marker");
    }
  } else {
    self.pickup_disabled = 1;
    self.interaction_handle makeunusable();

    if(!istrue(self.nowaypoint)) {
      self notify("freedobjective");
      scripts\cp\cp_objectives::freeworldid("pickup_hostage");

      if(isDefined(self.waypoint)) {
        objective_delete(self.waypoint);
        self.waypoint = undefined;
      }
    }
  }

  self notify("hvt_interaction_updated");
}

function ref_11d0a() {
  level endon("game_ended");
  self endon("delete");
  self notify("monitor_good_droppos");
  self endon("monitor_good_droppos");
  self.waittill_any_timeout_6 = self.origin;

  for(;;) {
    wait 1;

    if(spawn_module_building_chopper1()) {
      continue;
    }

    self.waittill_any_timeout_6 = self.origin;
  }
}

function spawn_module_building_chopper1(var_0) {
  if(isDefined(self.carrier)) {
    var_0 = self.carrier;
  }

  if(isDefined(var_0) && isPlayer(var_0)) {
    if(scripts\cp\cp_outofbounds::isoob(var_0, 0)) {
      return true;
    }
  }

  return false;
}

function watchfordelete() {
  level endon("game_ended");
  var_0 = 0;

  if(isDefined(self.waypoint)) {
    var_0 = self.waypoint;
  }

  scripts\engine\utility::ref_143a5("deleted", "death");
  scripts\cp\cp_objectives::freeworldid("pickup_hostage");
  objective_delete(var_0);
  self.waypoint = undefined;

  if(scripts\engine\utility::array_contains(level.spawnjuggernautcrateatposition, self)) {
    scripts\engine\utility::array_remove(level.spawnjuggernautcrateatposition, self);
    return;
  }
}

function ref_144c4() {
  level endon("game_ended");
  self endon("deleted");
  self endon("death");
  self endon("player_picked_up_hostage");
  self endon("convoy_pickedup_hvt");
  self notify("watchNewDrop");
  self endon("watchNewDrop");

  for(;;) {
    wait 2.5;
    var_0 = scripts\engine\trace::ray_trace(self.origin + (0, 0, 2), self.origin - (0, 0, 24));
    var_1 = var_0["fraction"];

    if(isDefined(var_1) && var_1 >= 1) {
      var_2 = scripts\engine\utility::drop_to_ground(self.origin, 72);
      self.origin = _getphysicspointaboutnavmesh(var_2) + (0, 0, 2);
    }
  }
}

#using_animtree("");

function do_hvt_pickup_anim(var_0) {
  var_0.ref_12939 = var_0 getcurrentweapon();
  var_0.ability_invulnerable = 1;
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "obj_hvi_pickup");
  var_1 = getcompleteweaponname("iw8_gunless");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 1);
  var_2 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1, 0);
  var_0.gunlessweapon = var_1;
  var_0 scripts\common\utility::allow_weapon_switch(0);
  var_0 scripts\common\utility::allow_weapon_pickup(0, "hvt");
  var_0 setstance("stand");
  var_0 scripts\common\utility::allow_usability(0);
  var_0 scripts\engine\utility::ref_143b9(1, "weapon_change");
  thread create_player_rig(var_0, var_0);
  self.body scripts\common\anim::anim_first_frame_solo(var_0.player_rig, "pickup_hvt_ground");
  link_player_to_rig(var_0, 0.25);
  var_0.vmvip = spawn("script_model", self.origin);
  var_0.vmvip.angles = self.angles;
  var_0.vmvip setModel(self.bodymodel);
  var_0.vmvip.animname = "hvt_vm";

  if(!isDefined(self.gender)) {
    self.gender = "male";
  }

  var_3 = scripts\engine\utility::ter_op(self.gender == "female", "hvt_vm_female", "hvt_vm");
  var_0.vmvip useanimtree(level.scr_animtree[var_3]);

  if(self.gender == "female") {
    self.body useanimtree(level.scr_animtree["hvt_female"]);
  }

  if(!isDefined(self.bodymodel)) {
    self.bodymodel = self.body.model;
  }

  self.body scripts\common\anim::anim_first_frame_solo(var_0.vmvip, "pickup_hvt_ground");
  var_0.vmvip hide();
  var_0.vmvip showtoplayer(var_0);

  if(isDefined(var_0.vmvip.head)) {
    var_0.vmvip.head hide();
    var_0.vmvip.head showtoplayer(var_0);
  }

  if(isDefined(self.head)) {
    self.head hidefromplayer(var_0);
  }

  self.body hidefromplayer(var_0);
  self.body thread scripts\common\anim::anim_single_solo(var_0.vmvip, "pickup_hvt_ground");
  self.body thread scripts\common\anim::anim_single_solo(self.body, "pickup_hvt_ground");
  self.body thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "pickup_hvt_ground");
  wait getanimlength(%vm_carry_ally_in_player);
  self.body hide();

  if(isDefined(self.head)) {
    self.head hide();
  }

  self linkTo(var_0);
  self.body useanimtree(level.scr_animtree["hvt"]);

  if(isDefined(var_0.vmvip.head)) {
    var_0.vmvip.head delete();
  }

  var_0.vmvip delete();
  var_4 = run_stealth_funcs(var_0, self);
  var_0 setOrigin(var_4);
  var_0 notify("remove_rig");
  var_0.ability_invulnerable = undefined;
}

function do_fast_hvt_pickup(var_0) {
  var_0.ref_12939 = var_0 getcurrentweapon();
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "obj_hvi_pickup");
  var_1 = getcompleteweaponname("iw8_gunless");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 1);
  var_2 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1, 0);
  var_0.gunlessweapon = var_1;
  var_0 scripts\common\utility::allow_weapon_switch(0);
  var_0 scripts\common\utility::allow_weapon_pickup(0, "hvt");
  var_0 setstance("stand");
  var_0 scripts\engine\utility::ref_143b9(1, "weapon_change");
  self.body hide();

  if(isDefined(self.head)) {
    self.head hide();
  }

  self linkTo(var_0);
}

function create_player_rig(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0.player_rig)) {
    return;
  }

  var_0.animname = var_1;

  if(!isDefined(var_2)) {
    var_2 = "viewhands_base_iw8";
  }

  var_0 predictstreampos(var_0.origin);
  var_3 = spawn("script_arms", var_0.origin, 0, 0, var_0);
  var_3.player = var_0;
  var_0.player_rig = var_3;
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
  var_0.player_rig.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  scripts\engine\utility::ref_143a6("remove_rig", "death", "disconnect");
  remove_player_rig(var_0);
}

function remove_player_rig(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }

  var_0 unlink();
  var_0.player_rig delete();
  var_0.player_rig = undefined;
}

function link_player_to_rig(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");

  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.25;
  }

  var_0 playerlinktoblend(var_0.player_rig, "tag_player", var_1, 0.1, 0.1);
  wait var_1;
  var_0 playerlinktodelta(var_0.player_rig, "tag_player", 1, 0, 0, 0, 0, 1, 1, 1);
  var_0.player_rig showonlytoplayer(var_0);
}

function do_hvt_drop_anim(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "medium";
  }

  var_2 = getcompleteweaponname("iw8_gunless");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2, undefined, undefined, 1);
  var_3 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_2, 0);
  var_0 scripts\engine\utility::ref_143b9(1, "weapon_change");
  var_0 resetcarryobject();
  var_0 setstance("stand");
  var_0 scripts\common\utility::allow_usability(0);
  var_0 unlink();
  var_0 allowmovement(1);
  self unlink();
  self.body unlink();
  self.body show();
  self.body hidefromplayer(var_0);
  var_0.vmvip = spawn("script_model", self.origin);
  var_0.vmvip.angles = self.angles;
  var_0.vmvip setModel(self.bodymodel);
  var_0.vmvip.animname = "hvt_vm";
  var_0.vmvip useanimtree(level.scr_animtree["hvt_vm"]);
  var_0.vmvip hide();
  var_0.vmvip showtoplayer(var_0);
  var_0 scripts\common\anim::anim_first_frame_solo(var_0.vmvip, "drop_hvt_ground");
  var_0 scripts\common\anim::anim_first_frame_solo(self.body, "drop_hvt_ground");

  if(isDefined(self.head) && isDefined(var_0.vmvip.head)) {
    var_0 scripts\common\anim::anim_first_frame_solo(var_0.vmvip.head, "drop_hvt_ground");
    var_0 scripts\common\anim::anim_first_frame_solo(self.head, "drop_hvt_ground");
  }

  var_4 = "drop_hvt_ground";
  thread create_player_rig(var_0, var_0);
  var_0 scripts\common\anim::anim_first_frame_solo(var_0.player_rig, var_4);
  link_player_to_rig(var_0);
  var_0 scripts\common\anim::anim_first_frame_solo(var_0.vmvip, "drop_hvt_ground");
  var_0 scripts\common\anim::anim_first_frame_solo(self.body, "drop_hvt_ground");

  if(isDefined(self.head) && isDefined(var_0.vmvip.head)) {
    var_0 scripts\common\anim::anim_first_frame_solo(var_0.vmvip.head, "drop_hvt_ground");
    var_0 scripts\common\anim::anim_first_frame_solo(self.head, "drop_hvt_ground");
  }

  var_0 thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, var_4);
  var_0 thread scripts\common\anim::anim_single_solo(self.body, var_4);
  var_0 thread scripts\common\anim::anim_single_solo(var_0.vmvip, var_4);
  var_5 = getanimlength(%sdr_cp_hostage_dropoff_ground_player);
  var_6 = getanimlength(%sdr_cp_hostage_dropoff_ground_pilot);
  wait var_5;
  var_0 notify("remove_rig");
  var_0 scripts\cp\cp_weapons::_takeweapon(var_2);
  var_7 = run_stealth_funcs(var_0, self);
  var_0 setOrigin(var_7);
  thread player_restoreweapons();
  wait var_6 - var_5;
  var_0.vmvip delete();
  self.body show();
  self.origin = self.body.origin;
  self.angles = self.body.angles;
  wait 0.25;
  self.body linkTo(self);
}

function do_hvt_pickup_from_truck_anim(var_0) {
  init_anims();
  var_1 = self.vehicle;
  var_2 = self;
  var_0.ref_12939 = var_0 getcurrentweapon();
  var_3 = getcompleteweaponname("iw8_gunless");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3, undefined, undefined, 1);
  var_4 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_3, 0);
  var_0.gunlessweapon = var_3;
  var_0 scripts\common\utility::allow_weapon_switch(0);
  var_0 scripts\common\utility::allow_weapon_pickup(0, "hvt");
  var_0 freezecontrols(1);
  var_0 setstance("stand");
  var_0 scripts\engine\utility::ref_143b9(1, "weapon_change");
  thread create_player_rig(var_0, var_0);
  var_1 scripts\common\anim::anim_first_frame_solo(var_0.player_rig, "truck_hvt_pickup");
  link_player_to_rig(var_0, 0.5);
  var_0.vmvip = spawn("script_model", self.origin);
  var_0.vmvip.angles = self.angles;
  var_0.vmvip setModel(self.body.model);
  var_0.vmvip.animname = "hvt_vm";
  var_0.vmvip useanimtree(level.scr_animtree["hvt_vm"]);

  if(isDefined(self.head)) {
    var_0.vmvip.head = spawn("script_model", self.origin);
    var_0.vmvip.head setModel(self.head.model);
    var_0.vmvip.head linkTo(var_0.vmvip, "j_neck", self.shownonspectatingwinnersplash, (0, 0, 0));
    var_0.vmvip.head.animname = "hvt_vm";
    var_0.vmvip.head useanimtree(level.scr_animtree["hvt_vm"]);
  }

  var_0.vmvip hide();

  if(isDefined(var_0.vmvip.head)) {
    var_0.vmvip.head hide();
  }

  var_0.vmvip showtoplayer(var_0);

  if(isDefined(var_0.vmvip.head)) {
    var_0.vmvip.head showtoplayer(var_0);
  }

  var_2.body hidefromplayer(var_0);

  if(isDefined(var_2.head)) {
    var_2.head hidefromplayer(var_0);
  }

  var_1 scripts\common\anim::anim_first_frame_solo(var_2.body, "truck_hvt_pickup");

  if(isDefined(var_2.head)) {
    var_1 scripts\common\anim::anim_first_frame_solo(var_2.head, "truck_hvt_pickup");
  }

  var_1 scripts\common\anim::anim_first_frame_solo(var_0.vmvip, "truck_hvt_pickup");

  if(isDefined(var_0.vmvip.head)) {
    var_1 scripts\common\anim::anim_first_frame_solo(var_0.vmvip.head, "truck_hvt_pickup");
  }

  var_1 thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "truck_hvt_pickup");
  var_1 thread scripts\common\anim::anim_single_solo(var_0.vmvip, "truck_hvt_pickup");
  var_1 thread scripts\common\anim::anim_single_solo(var_2.body, "truck_hvt_pickup");
  var_1 vehicleplayanim(%vm_hostage_pickup_truck_decho);
  wait getanimlength($sdr_cp_hostage_pickup_truck_decho);
  var_2.body hide();

  if(isDefined(var_2.head)) {
    var_2.head hide();
  }

  var_2 linkTo(var_0);
  var_0.vmvip delete();

  if(isDefined(var_0.vmvip.head)) {
    var_0.vmvip.head delete();
  }

  var_0 notify("remove_rig");
  var_0 freezecontrols(0);
}

function do_hvt_load_on_truck_anim(var_0) {
  init_anims();
  self.hostage_drop_override_data = var_0.hostage_drop_override_data;
  var_1 = var_0.hostage_drop_override_data.vehicle;
  var_2 = self;
  var_3 = getcompleteweaponname("iw8_gunless");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3, undefined, undefined, 1);
  var_4 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_3, 0);
  var_0 scripts\engine\utility::ref_143b9(1, "weapon_change");
  var_0 setstance("stand");
  var_0 allowcrouch(0);
  var_0 unlink();
  var_0 allowmovement(1);
  self unlink();
  self.body unlink();
  var_2.animname = "hvt";
  var_2 useanimtree(level.scr_animtree["hvt"]);
  thread create_player_rig(var_0, var_0);
  var_1 scripts\common\anim::anim_first_frame_solo(var_0.player_rig, "truck_hvt_dropoff");
  link_player_to_rig(var_0, 0.5);
  var_0 resetcarryobject();
  self.body show();
  self.body hidefromplayer(var_0);
  var_0.vmvip = spawn("script_model", var_1.origin);
  var_0.vmvip.angles = self.angles;
  var_0.vmvip setModel(self.bodymodel);
  var_0.vmvip.animname = "hvt_vm";
  var_0.vmvip useanimtree(level.scr_animtree["hvt_vm"]);
  var_0.vmvip hide();

  if(isDefined(var_0.vmvip.head)) {
    var_0.vmvip.head hide();
  }

  var_0.vmvip showtoplayer(var_0);

  if(isDefined(var_0.vmvip.head)) {
    var_0.vmvip.head showtoplayer(var_0);
  }

  var_2.body show();
  var_2.body hidefromplayer(var_0);
  var_1 scripts\common\anim::anim_first_frame_solo(var_2.body, "truck_hvt_dropoff");

  if(isDefined(var_2.head)) {
    var_1 scripts\common\anim::anim_first_frame_solo(var_2.head, "truck_hvt_dropoff");
  }

  var_1 scripts\common\anim::anim_first_frame_solo(var_0.vmvip, "truck_hvt_dropoff");

  if(isDefined(var_0.vmvip.head)) {
    var_1 scripts\common\anim::anim_first_frame_solo(var_0.vmvip.head, "truck_hvt_dropoff");
  }

  var_1 vehicleplayanim(%vm_hostage_dropoff_truck_decho);
  var_1 thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "truck_hvt_dropoff", "tag_origin");
  var_1 thread scripts\common\anim::anim_single_solo(var_0.vmvip, "truck_hvt_dropoff", "tag_origin");
  var_1 thread scripts\common\anim::anim_single_solo(var_2.body, "truck_hvt_dropoff", "tag_origin");
  wait getanimlength(level.scr_anim["player_vip_decho"]["truck_hvt_dropoff"]);

  if(isDefined(var_0.vmvip.head)) {
    var_0.vmvip.head delete();
  }

  var_0.vmvip delete();
  var_2.body show();

  if(isDefined(var_2.head)) {
    var_2.head show();
  }

  var_1 thread scripts\common\anim::anim_single_solo(var_2.body, "truck_hvt_idle", "tag_origin");
  var_0 notify("remove_rig");
  var_0 allowcrouch(1);
  var_0 scripts\cp\cp_weapons::_takeweapon(var_3);
  self.origin = self.body.origin;
  self.angles = self.body.angles;
  self.body linkTo(self);
  self linkTo(var_1);
}

function load_hvt(var_0, var_1, var_2) {
  var_1 notify("handoff_hvt");
  var_0 notify("loading_hvt_onto_heli");

  if(!isDefined(var_2)) {
    var_2 = "left";
  }

  var_3 = "blima_drop_l";
  var_4 = "sdr_cp_hostage_dropoff_blima_L_idle_outro_ally";
  var_5 = "sdr_cp_hostage_dropoff_blima_L_idle_outro_pilot";

  if(var_2 == "right") {
    var_3 = "blima_drop_r";
    var_4 = "sdr_cp_hostage_dropoff_blima_R_idle_outro_ally";
    var_5 = "sdr_cp_hostage_dropoff_blima_R_idle_outro_pilot";
  }

  var_6 = var_1.wmexfilally;
  var_7 = getcompleteweaponname("iw8_gunless");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_7, undefined, undefined, 1);
  var_8 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_7, 0);
  var_0 scripts\engine\utility::ref_143b9(1, "weapon_change");
  var_0 setstance("stand");
  var_0 allowcrouch(0);
  var_9 = var_0.hostagecarried;
  var_9.onchopper = 1;
  var_0 unlink();
  var_0 allowmovement(1);
  var_9 unlink();
  var_9.body unlink();
  var_9.body useanimtree(level.scr_animtree["hvt"]);
  var_9.body.animname = "hvt";
  thread create_player_rig(var_0, var_0);
  var_1 scripts\common\anim::anim_first_frame_solo(var_0.player_rig, var_3);
  link_player_to_rig(var_0, 0.4);
  var_0 resetcarryobject();
  var_9.body show();
  var_9.body hidefromplayer(var_0);
  var_10 = spawn("script_model", var_1.origin);
  var_10 setModel("allied_pilot_fullbody_3");
  var_10 useanimtree(level.scr_animtree["exfil_ally"]);
  var_10.animname = "exfil_ally";
  var_11 = spawn("script_model", var_1.origin);
  var_11 setModel(var_9.bodymodel);
  var_11 useanimtree(level.scr_animtree["hvt_vm"]);
  var_11.animname = "hvt_vm";

  if(isDefined(var_9.head)) {
    var_11.head = spawn("script_model", var_1.origin);
    var_11.head setModel(var_9.headmodel);
    var_11.head linkTo(var_11, "j_neck", (-9, 1, 0), (0, 0, 0));
    var_11.head.animname = "hvt_vm";
    var_11.head useanimtree(level.scr_animtree["hvt_vm"]);
    var_11.head showonlytoplayer(var_0);
  }

  var_11 showonlytoplayer(var_0);
  var_10 showonlytoplayer(var_0);
  var_6 show();
  var_6 hidefromplayer(var_0);
  var_9.body show();
  var_9.body hidefromplayer(var_0);

  if(isDefined(var_9.head)) {
    var_9.head hidefromplayer(var_0);
  }

  var_12 = getstartorigin(var_1.origin, var_1.angles, level.scr_anim["exfil_ally"][var_3]);
  var_13 = getstartangles(var_1.origin, var_1.angles, level.scr_anim["exfil_ally"][var_3]);
  var_14 = getstartorigin(var_1.origin, var_1.angles, level.scr_anim["exfil_ally_vm"][var_3]);
  var_15 = getstartangles(var_1.origin, var_1.angles, level.scr_anim["exfil_ally_vm"][var_3]);
  var_16 = getstartorigin(var_1.origin, var_1.angles, level.scr_anim["hvt_vm"][var_3]);
  var_17 = getstartangles(var_1.origin, var_1.angles, level.scr_anim["hvt_vm"][var_3]);
  var_6.origin = var_12;
  var_6.angles = var_13;
  var_10.origin = var_14;
  var_10.angles = var_15;
  var_11.origin = var_16;
  var_11.angles = var_17;
  var_9.origin = var_16;
  var_9.angles = var_17;
  var_10 linkTo(var_1);
  var_11 linkTo(var_1);
  var_9 linkTo(var_1);
  var_1.vmexfilally = var_10;
  var_1.vmhvt = var_11;
  var_18 = getstartorigin(var_1.origin, var_1.angles, level.scr_anim["player_vip_blima"][var_3]);
  var_19 = getstartangles(var_1.origin, var_1.angles, level.scr_anim["player_vip_blima"][var_3]);
  var_0 allowcrouch(0);
  var_0 setstance("stand");
  var_6 notify("stop_idle_anim");
  var_1 thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, var_3, "tag_origin");
  var_1 thread scripts\common\anim::anim_single_solo(var_10, var_3, "tag_origin");
  var_1 thread scripts\common\anim::anim_single_solo(var_6, var_3, "tag_origin");
  var_1 thread scripts\common\anim::anim_single_solo(var_11, var_3, "tag_origin");
  var_1 thread scripts\common\anim::anim_single_solo(var_9.body, var_3, "tag_origin");
  var_20 = getanimlength(level.scr_anim["player_vip_blima"][var_3]);
  var_21 = getanimlength(level.scr_anim["hvt"][var_3]);
  wait var_20;
  var_0 setstance("stand");
  var_0 notify("remove_rig");
  var_0 scripts\cp\cp_weapons::_takeweapon(var_7);
  var_0 allowcrouch(1);
  hostagedrop(var_0, var_0.hostagecarried, var_0.hostagecarried.origin, 0, 0.5, 1, 1, 1);
  wait var_21 - var_20;
  var_9.body linkTo(var_9);

  if(isDefined(var_9.head)) {
    var_9.head linkTo(var_9.body);
  }

  var_9 linkTo(var_1);

  if(isDefined(var_11.head)) {
    var_11.head delete();
  }

  var_11 delete();
  var_10 delete();
  var_9.body show();

  if(isDefined(var_9.head)) {
    var_9.head show();
  }

  var_6 show();
  var_9.body scriptmodelplayanim(var_5);
  var_6 scriptmodelplayanim(var_4);
}

function hostage_onuse(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("dropped");

  if(!isDefined(var_1)) {
    var_1 = "ground";
  }

  if(isDefined(self.waypoint)) {
    objective_delete(self.waypoint);
    self.waypoint = undefined;
  }

  if(isDefined(self.objectiveent)) {
    self.objectiveent unlink();
    self.objectiveent.origin = var_0.origin;
    self.objectiveent linkTo(var_0);
    objective_setzoffset(self.objnum, 45);
    objective_pinforclient(self.objnum, var_0);
  }

  self.angles = (0, self.angles[1], 0);

  switch (var_1) {
    case "heli":
      var_2[[level.hostage_onusefunc]](var_0, self);
      break;
    case "truck":
      do_hvt_pickup_from_truck_anim(var_0);
      break;
    case "ground":
      do_hvt_pickup_anim(var_0);
      break;
    case "moving_ai_truck":
      do_fast_hvt_pickup(var_0);
      break;
  }

  var_0 setcarryobject(self.carryobjectasset);
  var_0 scripts\common\utility::allow_weapon_switch(1);
  var_0 scripts\common\utility::allow_weapon_pickup(1, "hvt");

  if(isDefined(var_0.gunlessweapon)) {
    var_0 scripts\cp\cp_weapons::_takeweapon(var_0.gunlessweapon);
    var_0.gunlessweapon = undefined;
  }

  player_carrydebuff(var_0);
  var_0.carryobject = self;
  thread listen_for_super_triggered();
  thread hostage_watchdrop(var_0, self, self.useobj);
  thread hostage_laststandlistener(var_0);
  thread watchfordrophintstring(var_0, var_0);
  wait 0.3;
  var_0.hostagecarried = self;
  self.carried_by_vehicle = 0;
  level notify("player_picked_up_hostage", var_0);
  self notify("player_picked_up_hostage", var_0);
}

function toggledrophintstring(var_0, var_1, var_2) {
  if(isDefined(var_2.overridehintstring)) {
    var_1 scripts\cp\utility::hint_prompt(var_2.overridehintstring, var_0);
    return;
  }

  if(!isDefined(var_2.drophintstring)) {
    var_1 scripts\cp\utility::hint_prompt("drop_pilot_hostage", var_0);
    return;
  }

  var_1 scripts\cp\utility::hint_prompt(var_2.drophintstring, var_0);
}

function watchfordrophintstring(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("hostage_dropped_by_me");
  var_0 endon("loading_hvt_onto_heli");
  var_1 endon("dropped");

  for(;;) {
    if(candrophostage(var_0)) {
      toggledrophintstring(1, var_0, var_1);
    } else {
      toggledrophintstring(0, var_0, var_1);
    }

    waitframe();
  }
}

function hostage_laststandlistener(var_0) {
  level endon("game_ended");
  self endon("dropped");
  var_0 scripts\engine\utility::ref_143a6("last_stand", "disconnect", "being_subdued");
  var_0 disableusability();
  var_0 resetcarryobject();
  toggledrophintstring(0, var_0, self);
  self.body show();

  if(isDefined(self.head)) {
    self.head show();
  }

  thread x1ops6();
  hostagedrop(var_0, self, var_0.origin);
}

function x1ops6() {
  self endon("disconnect");
  self waittill("revive");

  while(isDefined(self.bspawningviaac130)) {
    self waittill("landed_after_respawn");
  }

  if(isDefined(self.spawn_module_intro4)) {
    scripts\cp\cp_weapons::_takeweapon(self.spawn_module_intro4);
    self.spawn_module_intro4 = undefined;

    if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
      scripts\cp\cp_weapons::switchtoweaponreliable(self.weaponlist[0]);
      return;
    }

    return;
  }
}

function hostage_watchdrop(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  self endon("death");
  var_0 endon("last_stand");
  var_0 endon("loading_hvt_onto_heli");
  self.carried = 1;
  var_3 = 0;
  self.carrier = var_0;
  var_4 = 0.05;

  while(self.carried) {
    if(!var_0 useButtonPressed()) {
      var_3 = 1;
    }

    if(!istrue(candrophostage(var_0))) {
      waitframe();
      continue;
    }

    var_5 = 0;
    var_0 setclientomnvar("zm_hint_progress", var_5);
    var_0 allowmovement(1);

    while(var_3 && var_0 useButtonPressed()) {
      var_5 += var_4;
      var_0 allowmovement(0);

      if(var_5 > 0.3 && candrophostage(var_0)) {
        var_0.trigger_water_fx = 1;

        if(isDefined(var_0.wmhostage)) {
          var_0.wmhostage unlink();

          if(isDefined(var_0.wmhostage.head)) {
            var_0.wmhostage.head delete();
          }

          var_0.wmhostage delete();
          var_0.wmhostage = undefined;
        }

        var_0.ability_invulnerable = 1;
        var_0 notify("hostage_dropped_by_me");
        toggledrophintstring(0, var_0, var_1);
        var_6 = 0;

        if(isDefined(var_0.hostage_drop_override_data)) {
          do_hvt_load_on_truck_anim(var_0);
          var_6 = 1;
        } else {
          do_hvt_drop_anim(var_0, "medium");
        }

        var_7 = self.origin;
        hostagedrop(var_0, var_1, var_7, undefined, 0.4, 0, 0, var_6);
        var_0.ability_invulnerable = undefined;
        return;
      }

      var_2 setclientomnvar("zm_hint_progress", var_7 / 0.3);
      wait var_6;
    }

    waitframe();
  }
}

function candrophostage(var_0) {
  if(var_0 isonladder()) {
    return 0;
  }

  if(isDefined(var_0.hostage_drop_override_data)) {
    return 1;
  }

  if(isDefined(level.oldkey) && distance2d(level.oldkey.origin, var_0.origin) <= 512) {
    return 0;
  }

  var_1 = var_0.origin + anglesToForward(var_0.angles) * 72 + (0, 0, 24);
  var_2 = scripts\engine\trace::ray_trace(var_0.origin + (0, 0, 24), var_1);

  if(var_2["fraction"] >= 1) {
    var_3 = scripts\engine\utility::drop_to_ground(var_1, 24);

    if(abs(var_3[2] - var_1[2]) > 40) {
      return 0;
    }

    return 1;
  }

  return 0;
}

function get_hostage_drop_pos(var_0) {
  var_1 = var_0.origin + anglesToForward(var_0.angles) * 72 + (0, 0, 24);
  var_2 = scripts\engine\trace::ray_trace(var_0.origin + (0, 0, 24), var_1);

  if(var_2["fraction"] >= 1) {
    var_3 = getclosestpointonnavmesh(var_1, var_0);
  } else {
    var_3 = var_1.origin;
  }

  return var_3;
}

function registerchallenge(var_0, var_1) {
  var_2 = var_0 + (0, 0, 30);
  var_3 = var_0;
  var_4 = scripts\engine\trace::ray_trace(var_2, var_3, [self.body, self]);
  var_5 = var_4["normal"];
  var_6 = vectortoangles(var_5);

  if(!isDefined(var_5) || var_5 == (0, 0, 0)) {
    return self.angles;
  }

  var_7 = generateaxisanglesfromupvector(var_5, self.angles);
  return var_7;
}

function create_objective(var_0, var_1) {
  var_2 = scripts\cp\cp_objectives::requestworldid("pickup_hostage", 10);

  if(!isDefined(var_1)) {
    var_1 = "icon_waypoint_marker";
  }

  objective_setplayintro(var_2, 0);
  objective_state(var_2, "current");
  objective_icon(var_2, var_1);

  if(!isDefined(self.attach_entity)) {
    objective_position(var_2, var_0);
  } else {
    objective_onentity(var_2, self.attach_entity);
    objective_setzoffset(var_2, 32);
  }

  objective_setbackground(var_2, 2);
  var_3 = "CP_BR_SYRK_OBJECTIVES/HVT";

  if(isDefined(self.label)) {
    var_3 = self.label;
  }

  objective_setlabel(var_2, var_3);
  return var_2;
}

function set_hvt_label(var_0, var_1) {
  if(!isDefined(self.waypoint)) {
    return;
  }

  objective_setlabel(self.waypoint, var_0);
  self.label = var_0;

  if(isDefined(var_1)) {
    objective_setshowoncompass(self.waypoint, 1);
    return;
  }
}

function listen_for_super_triggered() {
  self endon("last_stand");
  self endon("dropped_hostage");
  self endon("disconnect");

  for(;;) {
    if(self secondaryoffhandbuttonPressed() && self fragButtonPressed()) {
      if(istrue(self.super_activated) || !self.super_ready) {
        waitframe();
        continue;
      }

      var_0 = getcompleteweaponname("super_default_zm");
      self notify("offhand_fired", var_0);
      wait 1;
    }

    waitframe();
  }
}

function player_removecarrydebuff() {
  scripts\common\utility::allow_mantle(1);
  scripts\common\utility::allow_prone(1);
  scripts\common\utility::allow_crouch(1);
  scripts\common\utility::allow_sprint(1);

  if(!istrue(self.disable_hvt_nomantle)) {
    scripts\common\utility::allow_jump(1);
  }

  scripts\cp\utility::allow_secondary_offhand_weapons(1);
  scripts\cp\utility::brjugg_playerwelcomesplashes(1);
  self enableoffhandweapons();
  self allowmountside(1);
  self allowmounttop(1);
  scripts\common\utility::allow_melee(1);
  self allowjog(1);
  scripts\common\utility::allow_vehicle_use(1);
  scripts\cp\cp_kidnapper::setimmunetokidnapper(0);

  if(isDefined(self.suit)) {
    self setsuit(self.suit);
  } else {
    self setsuit("iw8_suit_cp");
  }

  self disableemptyclipweaponswitch(0);
  self notify("stop_hostagecarrier_watching_for_doors");
  scripts\cp\utility::_unsetperk("specialty_sprintfire");
  self.overrideweaponspeed_speedscale = undefined;
  self[[level.move_speed_scale]]();
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_weapon_switch_clip(1);
  self enableusability();
  scripts\common\utility::allow_weapon_pickup(1, "hvt");
  scripts\common\utility::allow_usability(1);
}

function player_carrydebuff() {
  scripts\common\utility::allow_mantle(0);

  if(!istrue(self.disable_hvt_nomantle)) {
    scripts\common\utility::allow_jump(0);
  }

  scripts\common\utility::allow_prone(0);
  scripts\common\utility::allow_crouch(0);
  scripts\common\utility::allow_sprint(0);
  scripts\common\utility::allow_melee(0);
  scripts\cp\utility::brjugg_playerwelcomesplashes(0);
  self disableoffhandweapons();
  self allowmountside(0);
  self allowmounttop(0);
  scripts\cp\utility::allow_secondary_offhand_weapons(0);
  self allowjog(0);
  scripts\cp\utility::giveperk("specialty_sprintfire");
  self.overrideweaponspeed_speedscale = 0.75;
  self[[level.move_speed_scale]]();
  scripts\cp\cp_kidnapper::setimmunetokidnapper(1);

  if(isDefined(self.ref_12939)) {
    if(turret_fob_self_destruct(self.ref_12939)) {
      var_0 = scripts\cp\cp_weapons::switchtoweaponreliable(self.ref_12939, 0);
    } else {
      self.spawn_module_intro4 = scripts\cp\cp_weapon::buildweapon("iw8_pi_mike1911", [], "none", "none", -1);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self.spawn_module_intro4, undefined, undefined, 1);
      var_0 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.spawn_module_intro4, 0);

      if((self.ref_12939.basename == "iw8_green_beam_mp" || self.ref_12939.basename == "iw8_spotter_scope_mp") && isDefined(self.primaryweaponobj)) {
        self.ref_12939 = self.primaryweaponobj;
      }
    }
  }

  thread scripts\cp\utility::ref_14441();
  scripts\common\utility::allow_weapon_switch(0);
  scripts\common\utility::allow_weapon_switch_clip(0);
  self disableusability();
  scripts\common\utility::allow_weapon_pickup(0, "hvt");
  scripts\common\utility::allow_usability(0);
  self disableemptyclipweaponswitch(1);
  self.disable_map_tablet = 1;
}

function ref_144d1() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("dropped_hostage");
  self endon("stop_hostagecarrier_watching_for_doors");
  var_0 = self;
  var_1 = 64;
  var_2 = 1.5;
  var_3 = ["scriptable_door_wooden_panel_mp_01", "scriptable_door_wooden_hollow_mp_01"];

  for(;;) {
    var_4 = [];
    var_5 = getentitylessscriptablearrayinradius(undefined, undefined, var_0.origin, var_1);

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      if(var_5[var_6] scriptableisdoor()) {
        var_4 = var_5[var_6];
      }
    }

    for(var_7 = 0; var_7 < var_4.size; var_7++) {
      var_4[var_7] setscriptablepartstate("door", "left_30", 0);
    }

    wait var_2;
  }
}

function player_refillammo() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("dropped_hostage");

  for(;;) {
    self waittill("reload");
    self givestartammo(self.currentprimaryweapon);
  }
}

function player_refillsinglecountammo() {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  self endon("disconnect");
  self endon("death");
  self endon("dropped_hostage");
  self endon("hostage_dropped_by_me");

  for(;;) {
    if(scripts\cp_mp\utility\player_utility::_isalive() && self.team != "spectator" && self getcurrentweaponclipammo() <= 0 && self getweaponammostock(self.currentprimaryweapon) <= 0) {
      self givestartammo(self.currentprimaryweapon);
      wait 1;
      continue;
    }

    waitframe();
  }
}

function run_stealth_funcs(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  var_2 = var_0.origin[2];
  var_3 = scripts\engine\trace::create_solid_ai_contents(1);
  var_4 = var_0.origin + (0, 0, 12);
  var_5 = var_0.origin - (0, 0, 24);
  var_6 = [var_0, var_0.player_rig, var_1.body];

  if(isDefined(var_1.head)) {
    GscBinSkip0(0x2e, var_6.size, var_1.head);
  }

  var_7 = var_0 scripts\engine\trace::player_trace(var_4, var_5, var_0.angles, var_6, var_3)["shape_position"];
  return var_7;
}

function turret_fob_self_destruct(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.classname) || !isDefined(var_0.basename)) {
    return false;
  }

  if(istrue(self isalternatemode(var_0))) {
    return false;
  }

  if(var_0 hasattachment("akimbo", 1)) {
    return false;
  }

  if(istrue(var_0.isalternate) && var_0.classname == "grenade") {
    return false;
  }

  if(var_0.basename == "iw8_ar_mike4_mpv2b" || getsubstr(var_0.basename, 0, 19) == "iw8_ar_sierra552_mp") {
    return false;
  }

  if(getsubstr(var_0.basename, 0, 7) == "iw8_pi_" || getsubstr(var_0.basename, 0, 7) == "iw8_sm_" || getsubstr(var_0.basename, 0, 7) == "iw8_ar_" || var_0.basename == "iw_lm_lima86_mp" || var_0.basename == "iw8_sh_charlie725_mp" || var_0.basename == "iw8_sh_oscar12_mp") {
    if(getsubstr(var_0.basename, 0, 7) == "iw8_pi_" && var_0 hasattachment("stock", 1)) {
      return false;
    }

    return true;
  }

  return false;
}

function ref_12350(var_0) {
  var_0 playsoundonmovingent("sdr_cop_hostage_pickup_ground_plr");
}

function ref_12351(var_0) {
  var_0 playsoundonmovingent("sdr_cop_hostage_pickup_ground_plr_npc ");
}

function modeplayerkilledspawn(var_0) {
  var_0 playsoundonmovingent("sdr_cp_hostage_dropoff_ground_plr");
}

function modeplayerskipdialog(var_0) {
  var_0 playsoundonmovingent("sdr_cp_hostage_dropoff_ground_plr_npc");
}

function ref_1234f(var_0) {
  var_0 playsoundonmovingent("sdr_cop_hostage_pickup_ground_pilot");
}

function modeonexitlaststandfunc(var_0) {
  var_0 playsoundonmovingent("sdr_cp_hostage_dropoff_ground_pilot");
}

function init_anims() {
  level.scr_animtree["player_pickup_hvt"] = #animtree;
  level.scr_anim["player_pickup_hvt"]["pickup_hvt_ground"] = $vm_carry_ally_in_player;
  level.scr_animname["player_pickup_hvt"]["pickup_hvt_ground"] = "vm_carry_ally_in_player";
  level.scr_eventanim["player_pickup_hvt"]["pickup_hvt_ground"] = "vip_pickup_ground";
  scripts\common\anim::addnotetrack_customfunction("player_pickup_hvt", "sdr_cop_hostage_pickup_ground_plr", &ref_12350);
  scripts\common\anim::addnotetrack_customfunction("player_pickup_hvt", "sdr_cop_hostage_pickup_ground_plr_npc", &ref_12351);
  level.scr_animtree["player_drop_hvt"] = #animtree;
  level.scr_anim["player_drop_hvt"]["drop_hvt_ground"] = % vm_carry_ally_out_player;
  level.scr_animname["player_drop_hvt"]["drop_hvt_ground"] = "vm_carry_ally_out_player";
  level.scr_eventanim["player_drop_hvt"]["drop_hvt_ground"] = "vip_dropoff_ground";
  scripts\common\anim::addnotetrack_customfunction("player_drop_hvt", "sdr_cp_hostage_dropoff_ground_plr", &modeplayerkilledspawn);
  scripts\common\anim::addnotetrack_customfunction("player_drop_hvt", "sdr_cp_hostage_dropoff_ground_plr_npc", &modeplayerskipdialog);
  level.scr_animtree["hvt"] = #animtree;
  level.scr_anim["hvt"]["pickup_hvt_ground"] = % sdr_cp_hostage_pickup_ground_pilot;
  level.scr_animname["hvt"]["pickup_hvt_ground"] = "sdr_cp_hostage_pickup_ground_pilot";
  level.scr_animtree["hvt_female"] = #animtree;
  level.scr_anim["hvt_female"]["pickup_hvt_ground"] = % sdr_cp_hostage_pickup_ground_pilot_female;
  level.scr_animname["hvt_female"]["pickup_hvt_ground"] = "sdr_cp_hostage_pickup_ground_pilot_female";
  level.scr_anim["hvt"]["drop_hvt_ground"] = % sdr_cp_hostage_dropoff_ground_pilot;
  level.scr_animname["hvt"]["drop_hvt_ground"] = "sdr_cp_hostage_dropoff_ground_pilot";
  level.scr_animtree["hvt_vm"] = #animtree;
  level.scr_anim["hvt_vm"]["pickup_hvt_ground"] = % vm_carry_ally_in_ally;
  level.scr_animname["hvt_vm"]["pickup_hvt_ground"] = "vm_carry_ally_in_ally";
  level.scr_animtree["hvt_vm_female"] = #animtree;
  level.scr_anim["hvt_vm_female"]["pickup_hvt_ground"] = % vm_carry_ally_in_ally_female;
  level.scr_animname["hvt_vm_female"]["pickup_hvt_ground"] = "vm_carry_ally_in_ally_female";
  level.scr_anim["hvt_vm"]["drop_hvt_ground"] = % vm_carry_ally_out_ally;
  level.scr_animname["hvt_vm"]["drop_hvt_ground"] = "vm_carry_ally_out_ally";
  level.scr_animtree["hvt"] = #animtree;
  level.scr_anim["hvt"]["blima_drop_r"] = % sdr_cp_hostage_dropoff_blima_r_pilot;
  level.scr_animname["hvt"]["blima_drop_r"] = "sdr_cp_hostage_dropoff_blima_R_pilot";
  level.scr_anim["hvt"]["blima_drop_r_idle"] = % sdr_cp_hostage_dropoff_blima_r_idle_outro_pilot;
  level.scr_animname["hvt"]["blima_drop_r_idle"] = "sdr_cp_hostage_dropoff_blima_R_idle_outro_pilot";
  level.scr_anim["hvt"]["blima_drop_l"] = % sdr_cp_hostage_dropoff_blima_l_pilot;
  level.scr_animname["hvt"]["blima_drop_l"] = "sdr_cp_hostage_dropoff_blima_L_pilot";
  level.scr_anim["hvt"]["blima_drop_l_idle"] = % sdr_cp_hostage_dropoff_blima_l_idle_outro_pilot;
  level.scr_animname["hvt"]["blima_drop_l_idle"] = "sdr_cp_hostage_dropoff_blima_L_idle_outro_pilot";
  level.scr_animtree["exfil_ally"] = #animtree;
  level.scr_anim["exfil_ally"]["blima_drop_l"] = % sdr_cp_hostage_dropoff_blima_l_ally;
  level.scr_animname["exfil_ally"]["blima_drop_l"] = "sdr_cp_hostage_dropoff_blima_L_ally";
  level.scr_anim["exfil_ally"]["blima_drop_l_idle_in"] = % sdr_cp_hostage_dropoff_blima_l_idle_intro_ally;
  level.scr_animname["exfil_ally"]["blima_drop_l_idle_in"] = "sdr_cp_hostage_dropoff_blima_L_idle_intro_ally";
  level.scr_anim["exfil_ally"]["blima_drop_l_idle_out"] = % sdr_cp_hostage_dropoff_blima_l_idle_outro_ally;
  level.scr_animname["exfil_ally"]["blima_drop_l_idle_out"] = "sdr_cp_hostage_dropoff_blima_L_idle_outro_ally";
  level.scr_anim["exfil_ally"]["blima_drop_r"] = % sdr_cp_hostage_dropoff_blima_r_ally;
  level.scr_animname["exfil_ally"]["blima_drop_r"] = "sdr_cp_hostage_dropoff_blima_R_ally";
  level.scr_anim["exfil_ally"]["blima_drop_r_idle_in"] = % sdr_cp_hostage_dropoff_blima_r_idle_intro_ally;
  level.scr_animname["exfil_ally"]["blima_drop_r_idle_in"] = "sdr_cp_hostage_dropoff_blima_R_idle_intro_ally";
  level.scr_anim["exfil_ally"]["blima_drop_r_idle_out"] = % sdr_cp_hostage_dropoff_blima_r_idle_outro_ally;
  level.scr_animname["exfil_ally"]["blima_drop_r_idle_out"] = "sdr_cp_hostage_dropoff_blima_R_idle_outro_ally";
  level.scr_anim["exfil_ally_vm"]["blima_drop_l"] = % vm_hostage_dropoff_blima_l_ally;
  level.scr_animname["exfil_ally_vm"]["blima_drop_l"] = "vm_hostage_dropoff_blima_L_ally";
  level.scr_anim["exfil_ally_vm"]["blima_drop_r"] = % vm_hostage_dropoff_blima_r_ally;
  level.scr_animname["exfil_ally_vm"]["blima_drop_r"] = "vm_hostage_dropoff_blima_R_ally";
  level.scr_animtree["player_vip_blima"] = #animtree;
  level.scr_anim["player_vip_blima"]["blima_drop_l"] = % vm_hostage_dropoff_blima_l_player;
  level.scr_animname["player_vip_blima"]["blima_drop_l"] = "vm_hostage_dropoff_blima_L_player";
  level.scr_eventanim["player_vip_blima"]["blima_drop_l"] = "plyr_vip_blima_drop_l";
  level.scr_anim["player_vip_blima"]["blima_drop_r"] = % vm_hostage_dropoff_blima_r_player;
  level.scr_animname["player_vip_blima"]["blima_drop_r"] = "vm_hostage_dropoff_blima_R_player";
  level.scr_eventanim["player_vip_blima"]["blima_drop_r"] = "plyr_vip_blima_drop_r";
  level.scr_anim["hvt_vm"]["blima_drop_l"] = % vm_hostage_dropoff_blima_l_pilot;
  level.scr_animname["hvt_vm"]["blima_drop_l"] = "vm_hostage_dropoff_blima_L_pilot";
  level.scr_anim["hvt_vm"]["blima_drop_r"] = % vm_hostage_dropoff_blima_r_pilot;
  level.scr_animname["hvt_vm"]["blima_drop_r"] = "vm_hostage_dropoff_blima_R_pilot";
  level.scr_anim["hvt_vm"]["truck_hvt_pickup"] = % vm_hostage_pickup_truck_pilot;
  level.scr_animname["hvt_vm"]["truck_hvt_pickup"] = "vm_hostage_pickup_truck_pilot";
  level.scr_anim["hvt_vm"]["truck_hvt_dropoff"] = % vm_hostage_dropoff_truck_pilot;
  level.scr_animname["hvt_vm"]["truck_hvt_dropoff"] = "vm_hostage_dropoff_truck_pilot";
  level.scr_animtree["hvt"] = #animtree;
  level.scr_anim["hvt"]["blima_drop_r"] = % sdr_cp_hostage_dropoff_blima_r_pilot;
  level.scr_animname["hvt"]["blima_drop_r"] = "sdr_cp_hostage_dropoff_blima_R_pilot";
  level.scr_anim["hvt"]["blima_drop_r_idle"] = % sdr_cp_hostage_dropoff_blima_r_idle_outro_pilot;
  level.scr_animname["hvt"]["blima_drop_r_idle"] = "sdr_cp_hostage_dropoff_blima_R_idle_outro_pilot";
  level.scr_anim["hvt"]["blima_drop_l"] = % sdr_cp_hostage_dropoff_blima_l_pilot;
  level.scr_animname["hvt"]["blima_drop_l"] = "sdr_cp_hostage_dropoff_blima_L_pilot";
  level.scr_anim["hvt"]["blima_drop_l_idle"] = % sdr_cp_hostage_dropoff_blima_l_idle_outro_pilot;
  level.scr_animname["hvt"]["blima_drop_l_idle"] = "sdr_cp_hostage_dropoff_blima_L_idle_outro_pilot";
  level.scr_anim["hvt"]["truck_hvt_dropoff"] = % sdr_cp_hostage_dropoff_truck_pilot;
  level.scr_animname["hvt"]["truck_hvt_dropoff"] = "sdr_cp_hostage_dropoff_truck_pilot";
  level.scr_anim["hvt"]["truck_hvt_pickup"] = % sdr_cp_hostage_pickup_truck_pilot;
  level.scr_animname["hvt"]["truck_hvt_pickup"] = "sdr_cp_hostage_pickup_truck_pilot";
  level.scr_anim["hvt"]["truck_hvt_idle"] = % sdr_cp_hostage_dropoff_truck_idle_pilot;
  level.scr_animname["hvt"]["truck_hvt_idle"] = "sdr_cp_hostage_dropoff_truck_idle_pilot";
  level.scr_animtree["exfil_ally"] = #animtree;
  level.scr_anim["exfil_ally"]["blima_drop_l"] = % sdr_cp_hostage_dropoff_blima_l_ally;
  level.scr_animname["exfil_ally"]["blima_drop_l"] = "sdr_cp_hostage_dropoff_blima_L_ally";
  level.scr_anim["exfil_ally"]["blima_drop_l_idle_in"] = % sdr_cp_hostage_dropoff_blima_l_idle_intro_ally;
  level.scr_animname["exfil_ally"]["blima_drop_l_idle_in"] = "sdr_cp_hostage_dropoff_blima_L_idle_intro_ally";
  level.scr_anim["exfil_ally"]["blima_drop_l_idle_out"] = % sdr_cp_hostage_dropoff_blima_l_idle_outro_ally;
  level.scr_animname["exfil_ally"]["blima_drop_l_idle_out"] = "sdr_cp_hostage_dropoff_blima_L_idle_outro_ally";
  level.scr_anim["exfil_ally"]["blima_drop_r"] = % sdr_cp_hostage_dropoff_blima_r_ally;
  level.scr_animname["exfil_ally"]["blima_drop_r"] = "sdr_cp_hostage_dropoff_blima_R_ally";
  level.scr_anim["exfil_ally"]["blima_drop_r_idle_in"] = % sdr_cp_hostage_dropoff_blima_r_idle_intro_ally;
  level.scr_animname["exfil_ally"]["blima_drop_r_idle_in"] = "sdr_cp_hostage_dropoff_blima_R_idle_intro_ally";
  level.scr_anim["exfil_ally"]["blima_drop_r_idle_out"] = % sdr_cp_hostage_dropoff_blima_r_idle_outro_ally;
  level.scr_animname["exfil_ally"]["blima_drop_r_idle_out"] = "sdr_cp_hostage_dropoff_blima_R_idle_outro_ally";
  level.scr_anim["exfil_ally_vm"]["blima_drop_l"] = % vm_hostage_dropoff_blima_l_ally;
  level.scr_animname["exfil_ally_vm"]["blima_drop_l"] = "vm_hostage_dropoff_blima_L_ally";
  level.scr_anim["exfil_ally_vm"]["blima_drop_r"] = % vm_hostage_dropoff_blima_r_ally;
  level.scr_animname["exfil_ally_vm"]["blima_drop_r"] = "vm_hostage_dropoff_blima_R_ally";
  level.scr_animtree["exfil_ally"] = #animtree;
  level.scr_anim["exfil_ally"]["turn_left"] = % sdr_cp_hostage_dropoff_blima_l_transition_l_ally;
  level.scr_animname["exfil_ally"]["turn_left"] = "sdr_cp_hostage_dropoff_blima_L_transition_L_ally";
  level.scr_anim["exfil_ally"]["turn_right"] = % sdr_cp_hostage_dropoff_blima_l_transition_r_ally;
  level.scr_animname["exfil_ally"]["turn_right"] = "sdr_cp_hostage_dropoff_blima_L_transition_R_ally";
  level.scr_animtree["player_vip_decho"] = #animtree;
  level.scr_anim["player_vip_decho"]["truck_hvt_dropoff"] = % vm_hostage_dropoff_truck_player;
  level.scr_animname["player_vip_decho"]["truck_hvt_dropoff"] = "vm_hostage_dropoff_truck_player";
  level.scr_eventanim["player_vip_decho"]["truck_hvt_dropoff"] = "vip_dropoff_truck";
  level.scr_anim["player_vip_decho"]["truck_hvt_pickup"] = % vm_hostage_pickup_truck_player;
  level.scr_animname["player_vip_decho"]["truck_hvt_pickup"] = "vm_hostage_pickup_truck_player";
  level.scr_eventanim["player_vip_decho"]["truck_hvt_pickup"] = "vip_pickup_truck";
  level.scr_animtree["decho_truck"] = #animtree;
  level.scr_anim["decho_truck"]["decho_hvt_pickup"] = % sdr_cp_hostage_pickup_truck_decho;
  level.scr_animname["decho_truck"]["decho_hvt_pickup"] = "sdr_cp_hostage_pickup_truck_decho";
  level.scr_anim["decho_truck"]["decho_hvt_dropoff"] = % sdr_cp_hostage_dropoff_truck_decho;
  level.scr_animname["decho_truck"]["decho_hvt_dropoff"] = "sdr_cp_hostage_dropoff_truck_decho";
  level.scr_animtree["decho_truck_vm"] = #animtree;
  level.scr_anim["decho_truck_vm"]["decho_hvt_pickup"] = % vm_hostage_pickup_truck_decho;
  level.scr_animname["decho_truck_vm"]["decho_hvt_pickup"] = "vm_hostage_pickup_truck_decho";
  level.scr_anim["decho_truck_vm"]["decho_hvt_dropoff"] = % vm_hostage_dropoff_truck_decho;
  level.scr_animname["decho_truck_vm"]["decho_hvt_dropoff"] = "vm_hostage_dropoff_truck_decho";
}