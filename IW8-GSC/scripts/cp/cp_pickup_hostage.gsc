/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_pickup_hostage.gsc
***********************************************/

#using_animtree("script_model");

function registerhvtscriptmodels() {
  level.scr_animtree["hvt"] = #animtree;
  init_anims();
}

function initdefaulthvtmodel(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var1)) {
    if(istrue(var7)) {
      var1 = "morales_hostage_fullbody";
    } else {
      var1 = "british_pilot_fullbody";
    }
  }

  if(!isDefined(var3)) {
    var3 = &"CP_BR_SYRK_OBJECTIVES/HVT_PICKUP";
  }

  if(!isDefined(var4)) {
    var4 = "drop_pilot_hostage";
  }

  var8 = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_ainosight"]);
  var9 = scripts\engine\trace::ray_trace(var0 + (0, 0, 100), var0 - (0, 0, 100), undefined, var8);
  var10 = spawn("script_model", var9["position"]);
  var10.body = spawn("script_model", var10.origin);
  var10.body setModel(var1);
  var10.body linkTo(var10);
  var10.idleanim = scripts\engine\utility::ter_op(istrue(var7), "sdr_cp_hostage_dropoff_ground_idle_female", "sdr_cp_hostage_dropoff_ground_idle_pilot");
  var10.shownonspectatingwinnersplash = scripts\engine\utility::ter_op(istrue(var7), (-6, 1, 0), (-9, 1, 0));
  var10.ref_135ab = var10.origin;

  if(isDefined(var2)) {
    var10.head = spawn("script_model", var10.origin);
    var10.head setModel(var2);
    var10.head linkTo(var10.body, "j_neck", var10.shownonspectatingwinnersplash, (0, 0, 0));
    var10.head.animname = "hvt";
    var10.head useanimtree(level.scr_animtree["hvt"]);
    var10.headmodel = var2;
    var10.head scriptmodelplayanim(var10.idleanim);
  }

  var10.gender = scripts\engine\utility::ter_op(istrue(var7), "female", "male");
  var10.body.animname = "hvt";
  var10.body useanimtree(level.scr_animtree["hvt"]);
  var10.bodymodel = var1;
  var10.drophintstring = var4;
  var10.pickuphintstring = var3;
  var10.body scriptmodelplayanim(var10.idleanim);
  var10.carryobjectasset = scripts\engine\utility::ter_op(isDefined(var6), var6, "hostage_pilot");

  if(!isDefined(level.spawnjuggernautcrateatposition)) {
    level.spawnjuggernautcrateatposition = [];
  }

  level.spawnjuggernautcrateatposition[level.spawnjuggernautcrateatposition.size] = var10;
  thread hostage_enable_rescue(var10, 0);
  thread ref_11d0a();
  return var10;
}

function hostagespawnwm(var0, var1, var2, var3) {
  var4 = spawn("script_model", self gettagorigin("j_clavicle_le"));
  var4.head = spawn("script_model", self gettagorigin("j_clavicle_le"));
  var4.angles = self gettagangles("j_clavicle_le");

  if(isDefined(var0)) {
    var4 setModel(var0);
  }

  if(isDefined(var1)) {
    var4.head setModel(var1);
  }

  if(!isDefined(var2)) {
    var2 = (-9, 1, 0);
  }

  var4.head linkTo(var4, "j_neck", var2, (0, 0, 0));
  var4 scriptmodelplayanim("sdr_cp_hostage_walk_hostage");
  var4 linkTo(self, "j_clavicle_le");

  if(!istrue(var3)) {
    var4 hide();
    var4.head hide();
  }

  if(isPlayer(self)) {
    var4 hidefromplayer(self);
    var4.head hidefromplayer(self);
  }

  var4.animname = "hvt";
  var4.head.animname = "hvt";
  var4.head useanimtree(level.scr_animtree["hvt"]);
  var4 useanimtree(level.scr_animtree["hvt"]);
  self.wmhostage = var4;
  return var4;
}

function deletepickuphostage() {
  if(isDefined(self.head)) {
    self.head delete();
  }

  self notify("delete");
  waitframe();
  self delete();
}

function hostagedrop(var0, var1, var2, var3, var4, var5, var6, var7) {
  self endon("delete");

  if(!isDefined(var0)) {
    var0 = self.carrier;
  }

  if(!isDefined(var2)) {
    var2 = var1.origin;
  }

  if(!isDefined(var1)) {
    var1 = self;
  }

  if(!isDefined(var7)) {
    var7 = 0;
  }

  var0 notify("hostage_dropped_by_me");

  if(isDefined(self.objectiveent)) {
    self.objectiveent unlink();
    self.objectiveent.origin = self.origin;
    self.objectiveent linkTo(self);
    objective_setzoffset(self.objnum, 30);
    objective_unpinforclient(self.objnum, var0);
  }

  if(isDefined(self.hostage_drop_override_data)) {
    var4 = self.hostage_drop_override_data.waittime;
    var5 = self.hostage_drop_override_data.forcepos;
    var6 = self.hostage_drop_override_data.preventuse;
  }

  var1.carried = 0;
  var1.carrier = undefined;
  var1 unlink();

  if(!var0.inlaststand) {
    var0 enableusability();
  }

  toggledrophintstring(0, var0, var1);
  var0 notify("dropped_hostage");

  if(istrue(var5)) {
    var1.origin = var2;
  } else {
    if(spawn_module_building_chopper1(var1, var0)) {
      if(isDefined(var1.waittill_any_timeout_6)) {
        var2 = var1.waittill_any_timeout_6;
      }
    }

    var1.origin = _getphysicspointaboutnavmesh(var2);

    if(triggermatchendtimer(var1)) {
      if(isDefined(var1.waittill_any_timeout_6)) {
        var2 = var1.waittill_any_timeout_6;
        var1.origin = _getphysicspointaboutnavmesh(var2);
      }
    }

    thread spawn_module_building_chopper2(var1);
  }

  if(!istrue(var7)) {
    var1.angles = registerchallenge(var1.origin, self);
  }

  if(!isDefined(var3) && isDefined(var1.useobj)) {
    var1.useobj.origin = var1.origin;
  }

  if(isDefined(var0)) {
    var0.carryobject = undefined;
    var0.disable_map_tablet = undefined;

    if(isDefined(var0.wmhostage)) {
      var0.wmhostage unlink();

      if(isDefined(var0.wmhostage.head)) {
        var0.wmhostage.head delete();
      }

      var0.wmhostage delete();
      var0.wmhostage = undefined;
    }

    player_restoreweapons(var0);
    player_removecarrydebuff(var0);
  }

  if(isDefined(var4)) {
    wait var4;
  }

  if(isDefined(var0) && isDefined(var0.hostagecarried)) {
    var0.hostagecarried show();

    if(isDefined(var0.hostagecarried.head)) {
      var0.hostagecarried.head show();
    }

    var0.hostagecarried = undefined;
    var0.trigger_water_fx = undefined;
  }

  if(istrue(var6)) {
    var1 hudoutlinedisable();

    if(isDefined(var1.head)) {
      var1.head hudoutlinedisable();
    }

    var1 notify("dropped");
    var0 scripts\cp\utility::hint_prompt("enter_vehicle_with_hostage", 0);
    return var1;
  }

  togglehvtusable(var1, 1);

  if(!isDefined(var1.pickuphintstring)) {
    var1.pickuphintstring = &"CP_BR_SYRK_OBJECTIVES/HVT_PICKUP";
  }

  if(!isDefined(var1.hostage_drop_override_data)) {
    if(isDefined(var1.idleanim)) {
      var1.body scriptmodelplayanim(var1.idleanim);

      if(isDefined(var1.head)) {
        var1.head scriptmodelplayanim(var1.idleanim);
      }
    }
  }

  if(!istrue(var1.nowaypoint) && !isDefined(self.waypoint)) {
    var1.waypoint = create_objective(var1.origin + (0, 0, 30), "icon_waypoint_marker");
    objective_setplayintro(var1.waypoint, 0);
    objective_setplayoutro(var1.waypoint, 0);
  }

  thread hostage_enable_rescue(var1);
  thread watchfordelete();
  thread ref_144c4();

  if(isDefined(var1.hostage_drop_override_data)) {
    if(isDefined(var1.hostage_drop_override_data.call_back_func)) {
      level thread[[var1.hostage_drop_override_data.call_back_func]](var1, var1.hostage_drop_override_data);
    }

    waitframe();
    var1.vehicle = var1.hostage_drop_override_data.vehicle;
    var1.hostage_drop_override_data = undefined;
  }

  var1 notify("dropped");
  return var1;
}

function triggermatchendtimer() {
  if(isDefined(level.outofboundstriggers)) {
    foreach(var1 in level.outofboundstriggers) {
      if(self istouching(var1)) {
        return true;
      }
    }
  }

  return false;
}

function _getphysicspointaboutnavmesh(var0) {
  var1 = scripts\engine\trace::create_contents(undefined, 1, 1, undefined, undefined, undefined, undefined);
  var2 = physics_raycast(var0 + (0, 0, 48), var0 - (0, 0, 48), var1, undefined, 0, "physicsquery_closest");
  var3 = isDefined(var2) && var2.size > 0;

  if(var3) {
    var4 = var2[0]["position"];
    return var4;
  }

  return var1;
}

function player_restoreweapons() {
  var0 = self;

  if(istrue(var0.inlaststand)) {
    return;
  }

  if(isDefined(var0.spawn_module_intro4)) {
    var0 scripts\cp\cp_weapons::_takeweapon(var0.spawn_module_intro4);
    var0.spawn_module_intro4 = undefined;
  }

  if(isDefined(var0.ref_12939)) {
    self switchtoweapon(var0.ref_12939);
    var0.ref_12939 = undefined;
    return;
  }
}

function spawn_module_building_chopper2(var0) {
  var1 = hostage_confirm_good_angles(self.origin, self.angles, var0);

  if(!istrue(var1.failed)) {
    self.angles = var1.angles;
    return;
  }

  var2 = 0;
  var3 = [];
  GscBinSkip0(0x2e, var3.size, var1.initpropcircles);
}

function hostage_confirm_good_angles(var0, var1, var2, var3) {
  var4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1);
  var5 = var1;
  var6 = var0 + (0, 0, 24);

  if(!isDefined(var3)) {
    var3 = 36;
  }

  var7 = spawnStruct();
  var7.initprematchspawnlocations = 0;
  var8 = 0;

  while(var8 < 12) {
    var9 = var0 + anglesToForward(var5) * var3 + (0, 0, 24);

    if(scripts\engine\trace::ray_trace_passed(var6, var9, self, var4)) {
      var10 = var9 - (0, 0, 4);
      var11 = var9 + (0, 0, 4);
      var12 = undefined;

      if(isPlayer(var2)) {
        var12 = var2 scripts\engine\trace::player_trace(var10, var11, var2.angles, var2, var4);
      } else {
        var12 = var2 scripts\engine\trace::capsule_trace(var10, var11, 30, 60, var2.angles, var2, var4);
      }

      var13 = var12["fraction"];

      if(isDefined(var13) && var13 >= 1) {
        var7.origin = var0;
        var7.angles = var5;
        var14 = distancesquared(var9, getclosestpointonnavmesh(var9));

        if(var14 > var7.initprematchspawnlocations) {
          var7.initprematchspawnlocations = var14;
          var7.initpropcircles = var9;
        }

        return var7;
      } else {
        var14 = distancesquared(var10, getclosestpointonnavmesh(var10));

        if(var14 > var8.initprematchspawnlocations) {
          var8.initprematchspawnlocations = var14;
          var8.initpropcircles = var10;
        }
      }
    }

    if(var6[1] + 30 >= 360) {
      var6 = (var6[0], var6[1] - 360, var6[2]);
    }

    var6 = (var6[0], var6[1] + 30, var6[2]);
    var9++;
  }

  var8.failed = 1;
  return var8;
}

function hostage_enable_rescue(var0, var1) {
  self endon("delete");
  var2 = "duration_medium";

  if(istrue(var1)) {
    var2 = "duration_long";
  }

  wait 1;
  togglehvtusable(1, "duration_medium");

  for(;;) {
    self.interaction_handle waittill("trigger", var3);

    if(!var3 scripts\cp\utility::is_valid_player() || istrue(var3.isjuggernaut)) {
      continue;
    }

    if(istrue(self.pickup_disabled)) {
      continue;
    }

    var3 scripts\common\utility::allow_vehicle_use(0);
    togglehvtusable(0);
    waitframe();

    if(istrue(self.carried_by_vehicle) && !istrue(self.convoy_pickedup)) {
      hostage_onuse(var3, "truck");
    } else if(istrue(self.convoy_pickedup)) {
      hostage_onuse(var3, "moving_ai_truck");
      self.convoy_pickedup = undefined;
    } else {
      hostage_onuse(var3);
    }

    break;
  }

  if(var0) {
    self notify("hostage_rescued");
    return;
  }
}

function togglehvtusable(var0, var1) {
  if(!isDefined(self.interaction_handle)) {
    self.interaction_handle = spawn("script_model", self.origin + (16, 0, 8));
    self.interaction_handle linkTo(self);
  }

  if(var0) {
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

    if(isDefined(var1)) {
      self.interaction_handle setuseholdduration(var1);
    } else {
      self.interaction_handle setuseholdduration("duration_short");
    }

    if(!isDefined(var1) || var1 == "duration_short") {
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

function spawn_module_building_chopper1(var0) {
  if(isDefined(self.carrier)) {
    var0 = self.carrier;
  }

  if(isDefined(var0) && isPlayer(var0)) {
    if(scripts\cp\cp_outofbounds::isoob(var0, 0)) {
      return true;
    }
  }

  return false;
}

function watchfordelete() {
  level endon("game_ended");
  var0 = 0;

  if(isDefined(self.waypoint)) {
    var0 = self.waypoint;
  }

  scripts\engine\utility::ref_143a5("deleted", "death");
  scripts\cp\cp_objectives::freeworldid("pickup_hostage");
  objective_delete(var0);
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
    var0 = scripts\engine\trace::ray_trace(self.origin + (0, 0, 2), self.origin - (0, 0, 24));
    var1 = var0["fraction"];

    if(isDefined(var1) && var1 >= 1) {
      var2 = scripts\engine\utility::drop_to_ground(self.origin, 72);
      self.origin = _getphysicspointaboutnavmesh(var2) + (0, 0, 2);
    }
  }
}

#using_animtree("");

function do_hvt_pickup_anim(var0) {
  var0.ref_12939 = var0 getcurrentweapon();
  var0.ability_invulnerable = 1;
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "obj_hvi_pickup");
  var1 = getcompleteweaponname("iw8_gunless");
  var0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var1, undefined, undefined, 1);
  var2 = var0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var1, 0);
  var0.gunlessweapon = var1;
  var0 scripts\common\utility::allow_weapon_switch(0);
  var0 scripts\common\utility::allow_weapon_pickup(0, "hvt");
  var0 setstance("stand");
  var0 scripts\common\utility::allow_usability(0);
  var0 scripts\engine\utility::ref_143b9(1, "weapon_change");
  thread create_player_rig(var0, var0);
  self.body scripts\common\anim::anim_first_frame_solo(var0.player_rig, "pickup_hvt_ground");
  link_player_to_rig(var0, 0.25);
  var0.vmvip = spawn("script_model", self.origin);
  var0.vmvip.angles = self.angles;
  var0.vmvip setModel(self.bodymodel);
  var0.vmvip.animname = "hvt_vm";

  if(!isDefined(self.gender)) {
    self.gender = "male";
  }

  var3 = scripts\engine\utility::ter_op(self.gender == "female", "hvt_vm_female", "hvt_vm");
  var0.vmvip useanimtree(level.scr_animtree[var3]);

  if(self.gender == "female") {
    self.body useanimtree(level.scr_animtree["hvt_female"]);
  }

  if(!isDefined(self.bodymodel)) {
    self.bodymodel = self.body.model;
  }

  self.body scripts\common\anim::anim_first_frame_solo(var0.vmvip, "pickup_hvt_ground");
  var0.vmvip hide();
  var0.vmvip showtoplayer(var0);

  if(isDefined(var0.vmvip.head)) {
    var0.vmvip.head hide();
    var0.vmvip.head showtoplayer(var0);
  }

  if(isDefined(self.head)) {
    self.head hidefromplayer(var0);
  }

  self.body hidefromplayer(var0);
  self.body thread scripts\common\anim::anim_single_solo(var0.vmvip, "pickup_hvt_ground");
  self.body thread scripts\common\anim::anim_single_solo(self.body, "pickup_hvt_ground");
  self.body thread scripts\cp\cp_anim::anim_player_solo(var0, var0.player_rig, "pickup_hvt_ground");
  wait getanimlength(%vm_carry_ally_in_player);
  self.body hide();

  if(isDefined(self.head)) {
    self.head hide();
  }

  self linkTo(var0);
  self.body useanimtree(level.scr_animtree["hvt"]);

  if(isDefined(var0.vmvip.head)) {
    var0.vmvip.head delete();
  }

  var0.vmvip delete();
  var4 = run_stealth_funcs(var0, self);
  var0 setOrigin(var4);
  var0 notify("remove_rig");
  var0.ability_invulnerable = undefined;
}

function do_fast_hvt_pickup(var0) {
  var0.ref_12939 = var0 getcurrentweapon();
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "obj_hvi_pickup");
  var1 = getcompleteweaponname("iw8_gunless");
  var0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var1, undefined, undefined, 1);
  var2 = var0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var1, 0);
  var0.gunlessweapon = var1;
  var0 scripts\common\utility::allow_weapon_switch(0);
  var0 scripts\common\utility::allow_weapon_pickup(0, "hvt");
  var0 setstance("stand");
  var0 scripts\engine\utility::ref_143b9(1, "weapon_change");
  self.body hide();

  if(isDefined(self.head)) {
    self.head hide();
  }

  self linkTo(var0);
}

function create_player_rig(var0, var1, var2) {
  if(!isDefined(var0) || isDefined(var0.player_rig)) {
    return;
  }

  var0.animname = var1;

  if(!isDefined(var2)) {
    var2 = "viewhands_base_iw8";
  }

  var0 predictstreampos(var0.origin);
  var3 = spawn("script_arms", var0.origin, 0, 0, var0);
  var3.player = var0;
  var0.player_rig = var3;
  var0.player_rig hide();
  var0.player_rig.animname = var1;
  var0.player_rig useanimtree(#animtree);
  var0.player_rig.angles = scripts\engine\utility::ter_op(isDefined(var0.angles), var0.angles, (0, 0, 0));
  scripts\engine\utility::ref_143a6("remove_rig", "death", "disconnect");
  remove_player_rig(var0);
}

function remove_player_rig(var0) {
  if(!isDefined(var0) || !isDefined(var0.player_rig)) {
    return;
  }

  var0 unlink();
  var0.player_rig delete();
  var0.player_rig = undefined;
}

function link_player_to_rig(var0, var1) {
  var0 endon("death");
  var0 endon("disconnect");

  if(!isDefined(var0) || !isDefined(var0.player_rig)) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = 0.25;
  }

  var0 playerlinktoblend(var0.player_rig, "tag_player", var1, 0.1, 0.1);
  wait var1;
  var0 playerlinktodelta(var0.player_rig, "tag_player", 1, 0, 0, 0, 0, 1, 1, 1);
  var0.player_rig showonlytoplayer(var0);
}

function do_hvt_drop_anim(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "medium";
  }

  var2 = getcompleteweaponname("iw8_gunless");
  var0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var2, undefined, undefined, 1);
  var3 = var0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var2, 0);
  var0 scripts\engine\utility::ref_143b9(1, "weapon_change");
  var0 resetcarryobject();
  var0 setstance("stand");
  var0 scripts\common\utility::allow_usability(0);
  var0 unlink();
  var0 allowmovement(1);
  self unlink();
  self.body unlink();
  self.body show();
  self.body hidefromplayer(var0);
  var0.vmvip = spawn("script_model", self.origin);
  var0.vmvip.angles = self.angles;
  var0.vmvip setModel(self.bodymodel);
  var0.vmvip.animname = "hvt_vm";
  var0.vmvip useanimtree(level.scr_animtree["hvt_vm"]);
  var0.vmvip hide();
  var0.vmvip showtoplayer(var0);
  var0 scripts\common\anim::anim_first_frame_solo(var0.vmvip, "drop_hvt_ground");
  var0 scripts\common\anim::anim_first_frame_solo(self.body, "drop_hvt_ground");

  if(isDefined(self.head) && isDefined(var0.vmvip.head)) {
    var0 scripts\common\anim::anim_first_frame_solo(var0.vmvip.head, "drop_hvt_ground");
    var0 scripts\common\anim::anim_first_frame_solo(self.head, "drop_hvt_ground");
  }

  var4 = "drop_hvt_ground";
  thread create_player_rig(var0, var0);
  var0 scripts\common\anim::anim_first_frame_solo(var0.player_rig, var4);
  link_player_to_rig(var0);
  var0 scripts\common\anim::anim_first_frame_solo(var0.vmvip, "drop_hvt_ground");
  var0 scripts\common\anim::anim_first_frame_solo(self.body, "drop_hvt_ground");

  if(isDefined(self.head) && isDefined(var0.vmvip.head)) {
    var0 scripts\common\anim::anim_first_frame_solo(var0.vmvip.head, "drop_hvt_ground");
    var0 scripts\common\anim::anim_first_frame_solo(self.head, "drop_hvt_ground");
  }

  var0 thread scripts\cp\cp_anim::anim_player_solo(var0, var0.player_rig, var4);
  var0 thread scripts\common\anim::anim_single_solo(self.body, var4);
  var0 thread scripts\common\anim::anim_single_solo(var0.vmvip, var4);
  var5 = getanimlength(%sdr_cp_hostage_dropoff_ground_player);
  var6 = getanimlength(%sdr_cp_hostage_dropoff_ground_pilot);
  wait var5;
  var0 notify("remove_rig");
  var0 scripts\cp\cp_weapons::_takeweapon(var2);
  var7 = run_stealth_funcs(var0, self);
  var0 setOrigin(var7);
  thread player_restoreweapons();
  wait var6 - var5;
  var0.vmvip delete();
  self.body show();
  self.origin = self.body.origin;
  self.angles = self.body.angles;
  wait 0.25;
  self.body linkTo(self);
}

function do_hvt_pickup_from_truck_anim(var0) {
  init_anims();
  var1 = self.vehicle;
  var2 = self;
  var0.ref_12939 = var0 getcurrentweapon();
  var3 = getcompleteweaponname("iw8_gunless");
  var0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var3, undefined, undefined, 1);
  var4 = var0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var3, 0);
  var0.gunlessweapon = var3;
  var0 scripts\common\utility::allow_weapon_switch(0);
  var0 scripts\common\utility::allow_weapon_pickup(0, "hvt");
  var0 freezecontrols(1);
  var0 setstance("stand");
  var0 scripts\engine\utility::ref_143b9(1, "weapon_change");
  thread create_player_rig(var0, var0);
  var1 scripts\common\anim::anim_first_frame_solo(var0.player_rig, "truck_hvt_pickup");
  link_player_to_rig(var0, 0.5);
  var0.vmvip = spawn("script_model", self.origin);
  var0.vmvip.angles = self.angles;
  var0.vmvip setModel(self.body.model);
  var0.vmvip.animname = "hvt_vm";
  var0.vmvip useanimtree(level.scr_animtree["hvt_vm"]);

  if(isDefined(self.head)) {
    var0.vmvip.head = spawn("script_model", self.origin);
    var0.vmvip.head setModel(self.head.model);
    var0.vmvip.head linkTo(var0.vmvip, "j_neck", self.shownonspectatingwinnersplash, (0, 0, 0));
    var0.vmvip.head.animname = "hvt_vm";
    var0.vmvip.head useanimtree(level.scr_animtree["hvt_vm"]);
  }

  var0.vmvip hide();

  if(isDefined(var0.vmvip.head)) {
    var0.vmvip.head hide();
  }

  var0.vmvip showtoplayer(var0);

  if(isDefined(var0.vmvip.head)) {
    var0.vmvip.head showtoplayer(var0);
  }

  var2.body hidefromplayer(var0);

  if(isDefined(var2.head)) {
    var2.head hidefromplayer(var0);
  }

  var1 scripts\common\anim::anim_first_frame_solo(var2.body, "truck_hvt_pickup");

  if(isDefined(var2.head)) {
    var1 scripts\common\anim::anim_first_frame_solo(var2.head, "truck_hvt_pickup");
  }

  var1 scripts\common\anim::anim_first_frame_solo(var0.vmvip, "truck_hvt_pickup");

  if(isDefined(var0.vmvip.head)) {
    var1 scripts\common\anim::anim_first_frame_solo(var0.vmvip.head, "truck_hvt_pickup");
  }

  var1 thread scripts\cp\cp_anim::anim_player_solo(var0, var0.player_rig, "truck_hvt_pickup");
  var1 thread scripts\common\anim::anim_single_solo(var0.vmvip, "truck_hvt_pickup");
  var1 thread scripts\common\anim::anim_single_solo(var2.body, "truck_hvt_pickup");
  var1 vehicleplayanim(%vm_hostage_pickup_truck_decho);
  wait getanimlength($sdr_cp_hostage_pickup_truck_decho);
  var2.body hide();

  if(isDefined(var2.head)) {
    var2.head hide();
  }

  var2 linkTo(var0);
  var0.vmvip delete();

  if(isDefined(var0.vmvip.head)) {
    var0.vmvip.head delete();
  }

  var0 notify("remove_rig");
  var0 freezecontrols(0);
}

function do_hvt_load_on_truck_anim(var0) {
  init_anims();
  self.hostage_drop_override_data = var0.hostage_drop_override_data;
  var1 = var0.hostage_drop_override_data.vehicle;
  var2 = self;
  var3 = getcompleteweaponname("iw8_gunless");
  var0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var3, undefined, undefined, 1);
  var4 = var0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var3, 0);
  var0 scripts\engine\utility::ref_143b9(1, "weapon_change");
  var0 setstance("stand");
  var0 allowcrouch(0);
  var0 unlink();
  var0 allowmovement(1);
  self unlink();
  self.body unlink();
  var2.animname = "hvt";
  var2 useanimtree(level.scr_animtree["hvt"]);
  thread create_player_rig(var0, var0);
  var1 scripts\common\anim::anim_first_frame_solo(var0.player_rig, "truck_hvt_dropoff");
  link_player_to_rig(var0, 0.5);
  var0 resetcarryobject();
  self.body show();
  self.body hidefromplayer(var0);
  var0.vmvip = spawn("script_model", var1.origin);
  var0.vmvip.angles = self.angles;
  var0.vmvip setModel(self.bodymodel);
  var0.vmvip.animname = "hvt_vm";
  var0.vmvip useanimtree(level.scr_animtree["hvt_vm"]);
  var0.vmvip hide();

  if(isDefined(var0.vmvip.head)) {
    var0.vmvip.head hide();
  }

  var0.vmvip showtoplayer(var0);

  if(isDefined(var0.vmvip.head)) {
    var0.vmvip.head showtoplayer(var0);
  }

  var2.body show();
  var2.body hidefromplayer(var0);
  var1 scripts\common\anim::anim_first_frame_solo(var2.body, "truck_hvt_dropoff");

  if(isDefined(var2.head)) {
    var1 scripts\common\anim::anim_first_frame_solo(var2.head, "truck_hvt_dropoff");
  }

  var1 scripts\common\anim::anim_first_frame_solo(var0.vmvip, "truck_hvt_dropoff");

  if(isDefined(var0.vmvip.head)) {
    var1 scripts\common\anim::anim_first_frame_solo(var0.vmvip.head, "truck_hvt_dropoff");
  }

  var1 vehicleplayanim(%vm_hostage_dropoff_truck_decho);
  var1 thread scripts\cp\cp_anim::anim_player_solo(var0, var0.player_rig, "truck_hvt_dropoff", "tag_origin");
  var1 thread scripts\common\anim::anim_single_solo(var0.vmvip, "truck_hvt_dropoff", "tag_origin");
  var1 thread scripts\common\anim::anim_single_solo(var2.body, "truck_hvt_dropoff", "tag_origin");
  wait getanimlength(level.scr_anim["player_vip_decho"]["truck_hvt_dropoff"]);

  if(isDefined(var0.vmvip.head)) {
    var0.vmvip.head delete();
  }

  var0.vmvip delete();
  var2.body show();

  if(isDefined(var2.head)) {
    var2.head show();
  }

  var1 thread scripts\common\anim::anim_single_solo(var2.body, "truck_hvt_idle", "tag_origin");
  var0 notify("remove_rig");
  var0 allowcrouch(1);
  var0 scripts\cp\cp_weapons::_takeweapon(var3);
  self.origin = self.body.origin;
  self.angles = self.body.angles;
  self.body linkTo(self);
  self linkTo(var1);
}

function load_hvt(var0, var1, var2) {
  var1 notify("handoff_hvt");
  var0 notify("loading_hvt_onto_heli");

  if(!isDefined(var2)) {
    var2 = "left";
  }

  var3 = "blima_drop_l";
  var4 = "sdr_cp_hostage_dropoff_blima_L_idle_outro_ally";
  var5 = "sdr_cp_hostage_dropoff_blima_L_idle_outro_pilot";

  if(var2 == "right") {
    var3 = "blima_drop_r";
    var4 = "sdr_cp_hostage_dropoff_blima_R_idle_outro_ally";
    var5 = "sdr_cp_hostage_dropoff_blima_R_idle_outro_pilot";
  }

  var6 = var1.wmexfilally;
  var7 = getcompleteweaponname("iw8_gunless");
  var0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var7, undefined, undefined, 1);
  var8 = var0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var7, 0);
  var0 scripts\engine\utility::ref_143b9(1, "weapon_change");
  var0 setstance("stand");
  var0 allowcrouch(0);
  var9 = var0.hostagecarried;
  var9.onchopper = 1;
  var0 unlink();
  var0 allowmovement(1);
  var9 unlink();
  var9.body unlink();
  var9.body useanimtree(level.scr_animtree["hvt"]);
  var9.body.animname = "hvt";
  thread create_player_rig(var0, var0);
  var1 scripts\common\anim::anim_first_frame_solo(var0.player_rig, var3);
  link_player_to_rig(var0, 0.4);
  var0 resetcarryobject();
  var9.body show();
  var9.body hidefromplayer(var0);
  var10 = spawn("script_model", var1.origin);
  var10 setModel("allied_pilot_fullbody_3");
  var10 useanimtree(level.scr_animtree["exfil_ally"]);
  var10.animname = "exfil_ally";
  var11 = spawn("script_model", var1.origin);
  var11 setModel(var9.bodymodel);
  var11 useanimtree(level.scr_animtree["hvt_vm"]);
  var11.animname = "hvt_vm";

  if(isDefined(var9.head)) {
    var11.head = spawn("script_model", var1.origin);
    var11.head setModel(var9.headmodel);
    var11.head linkTo(var11, "j_neck", (-9, 1, 0), (0, 0, 0));
    var11.head.animname = "hvt_vm";
    var11.head useanimtree(level.scr_animtree["hvt_vm"]);
    var11.head showonlytoplayer(var0);
  }

  var11 showonlytoplayer(var0);
  var10 showonlytoplayer(var0);
  var6 show();
  var6 hidefromplayer(var0);
  var9.body show();
  var9.body hidefromplayer(var0);

  if(isDefined(var9.head)) {
    var9.head hidefromplayer(var0);
  }

  var12 = getstartorigin(var1.origin, var1.angles, level.scr_anim["exfil_ally"][var3]);
  var13 = getstartangles(var1.origin, var1.angles, level.scr_anim["exfil_ally"][var3]);
  var14 = getstartorigin(var1.origin, var1.angles, level.scr_anim["exfil_ally_vm"][var3]);
  var15 = getstartangles(var1.origin, var1.angles, level.scr_anim["exfil_ally_vm"][var3]);
  var16 = getstartorigin(var1.origin, var1.angles, level.scr_anim["hvt_vm"][var3]);
  var17 = getstartangles(var1.origin, var1.angles, level.scr_anim["hvt_vm"][var3]);
  var6.origin = var12;
  var6.angles = var13;
  var10.origin = var14;
  var10.angles = var15;
  var11.origin = var16;
  var11.angles = var17;
  var9.origin = var16;
  var9.angles = var17;
  var10 linkTo(var1);
  var11 linkTo(var1);
  var9 linkTo(var1);
  var1.vmexfilally = var10;
  var1.vmhvt = var11;
  var18 = getstartorigin(var1.origin, var1.angles, level.scr_anim["player_vip_blima"][var3]);
  var19 = getstartangles(var1.origin, var1.angles, level.scr_anim["player_vip_blima"][var3]);
  var0 allowcrouch(0);
  var0 setstance("stand");
  var6 notify("stop_idle_anim");
  var1 thread scripts\cp\cp_anim::anim_player_solo(var0, var0.player_rig, var3, "tag_origin");
  var1 thread scripts\common\anim::anim_single_solo(var10, var3, "tag_origin");
  var1 thread scripts\common\anim::anim_single_solo(var6, var3, "tag_origin");
  var1 thread scripts\common\anim::anim_single_solo(var11, var3, "tag_origin");
  var1 thread scripts\common\anim::anim_single_solo(var9.body, var3, "tag_origin");
  var20 = getanimlength(level.scr_anim["player_vip_blima"][var3]);
  var21 = getanimlength(level.scr_anim["hvt"][var3]);
  wait var20;
  var0 setstance("stand");
  var0 notify("remove_rig");
  var0 scripts\cp\cp_weapons::_takeweapon(var7);
  var0 allowcrouch(1);
  hostagedrop(var0, var0.hostagecarried, var0.hostagecarried.origin, 0, 0.5, 1, 1, 1);
  wait var21 - var20;
  var9.body linkTo(var9);

  if(isDefined(var9.head)) {
    var9.head linkTo(var9.body);
  }

  var9 linkTo(var1);

  if(isDefined(var11.head)) {
    var11.head delete();
  }

  var11 delete();
  var10 delete();
  var9.body show();

  if(isDefined(var9.head)) {
    var9.head show();
  }

  var6 show();
  var9.body scriptmodelplayanim(var5);
  var6 scriptmodelplayanim(var4);
}

function hostage_onuse(var0, var1, var2) {
  level endon("game_ended");
  self endon("dropped");

  if(!isDefined(var1)) {
    var1 = "ground";
  }

  if(isDefined(self.waypoint)) {
    objective_delete(self.waypoint);
    self.waypoint = undefined;
  }

  if(isDefined(self.objectiveent)) {
    self.objectiveent unlink();
    self.objectiveent.origin = var0.origin;
    self.objectiveent linkTo(var0);
    objective_setzoffset(self.objnum, 45);
    objective_pinforclient(self.objnum, var0);
  }

  self.angles = (0, self.angles[1], 0);

  switch (var1) {
    case "heli":
      var2[[level.hostage_onusefunc]](var0, self);
      break;
    case "truck":
      do_hvt_pickup_from_truck_anim(var0);
      break;
    case "ground":
      do_hvt_pickup_anim(var0);
      break;
    case "moving_ai_truck":
      do_fast_hvt_pickup(var0);
      break;
  }

  var0 setcarryobject(self.carryobjectasset);
  var0 scripts\common\utility::allow_weapon_switch(1);
  var0 scripts\common\utility::allow_weapon_pickup(1, "hvt");

  if(isDefined(var0.gunlessweapon)) {
    var0 scripts\cp\cp_weapons::_takeweapon(var0.gunlessweapon);
    var0.gunlessweapon = undefined;
  }

  player_carrydebuff(var0);
  var0.carryobject = self;
  thread listen_for_super_triggered();
  thread hostage_watchdrop(var0, self, self.useobj);
  thread hostage_laststandlistener(var0);
  thread watchfordrophintstring(var0, var0);
  wait 0.3;
  var0.hostagecarried = self;
  self.carried_by_vehicle = 0;
  level notify("player_picked_up_hostage", var0);
  self notify("player_picked_up_hostage", var0);
}

function toggledrophintstring(var0, var1, var2) {
  if(isDefined(var2.overridehintstring)) {
    var1 scripts\cp\utility::hint_prompt(var2.overridehintstring, var0);
    return;
  }

  if(!isDefined(var2.drophintstring)) {
    var1 scripts\cp\utility::hint_prompt("drop_pilot_hostage", var0);
    return;
  }

  var1 scripts\cp\utility::hint_prompt(var2.drophintstring, var0);
}

function watchfordrophintstring(var0, var1) {
  level endon("game_ended");
  var0 endon("death");
  var0 endon("hostage_dropped_by_me");
  var0 endon("loading_hvt_onto_heli");
  var1 endon("dropped");

  for(;;) {
    if(candrophostage(var0)) {
      toggledrophintstring(1, var0, var1);
    } else {
      toggledrophintstring(0, var0, var1);
    }

    waitframe();
  }
}

function hostage_laststandlistener(var0) {
  level endon("game_ended");
  self endon("dropped");
  var0 scripts\engine\utility::ref_143a6("last_stand", "disconnect", "being_subdued");
  var0 disableusability();
  var0 resetcarryobject();
  toggledrophintstring(0, var0, self);
  self.body show();

  if(isDefined(self.head)) {
    self.head show();
  }

  thread x1ops6();
  hostagedrop(var0, self, var0.origin);
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

function hostage_watchdrop(var0, var1, var2) {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  self endon("death");
  var0 endon("last_stand");
  var0 endon("loading_hvt_onto_heli");
  self.carried = 1;
  var3 = 0;
  self.carrier = var0;
  var4 = 0.05;

  while(self.carried) {
    if(!var0 useButtonPressed()) {
      var3 = 1;
    }

    if(!istrue(candrophostage(var0))) {
      waitframe();
      continue;
    }

    var5 = 0;
    var0 setclientomnvar("zm_hint_progress", var5);
    var0 allowmovement(1);

    while(var3 && var0 useButtonPressed()) {
      var5 += var4;
      var0 allowmovement(0);

      if(var5 > 0.3 && candrophostage(var0)) {
        var0.trigger_water_fx = 1;

        if(isDefined(var0.wmhostage)) {
          var0.wmhostage unlink();

          if(isDefined(var0.wmhostage.head)) {
            var0.wmhostage.head delete();
          }

          var0.wmhostage delete();
          var0.wmhostage = undefined;
        }

        var0.ability_invulnerable = 1;
        var0 notify("hostage_dropped_by_me");
        toggledrophintstring(0, var0, var1);
        var6 = 0;

        if(isDefined(var0.hostage_drop_override_data)) {
          do_hvt_load_on_truck_anim(var0);
          var6 = 1;
        } else {
          do_hvt_drop_anim(var0, "medium");
        }

        var7 = self.origin;
        hostagedrop(var0, var1, var7, undefined, 0.4, 0, 0, var6);
        var0.ability_invulnerable = undefined;
        return;
      }

      var2 setclientomnvar("zm_hint_progress", var7 / 0.3);
      wait var6;
    }

    waitframe();
  }
}

function candrophostage(var0) {
  if(var0 isonladder()) {
    return 0;
  }

  if(isDefined(var0.hostage_drop_override_data)) {
    return 1;
  }

  if(isDefined(level.oldkey) && distance2d(level.oldkey.origin, var0.origin) <= 512) {
    return 0;
  }

  var1 = var0.origin + anglesToForward(var0.angles) * 72 + (0, 0, 24);
  var2 = scripts\engine\trace::ray_trace(var0.origin + (0, 0, 24), var1);

  if(var2["fraction"] >= 1) {
    var3 = scripts\engine\utility::drop_to_ground(var1, 24);

    if(abs(var3[2] - var1[2]) > 40) {
      return 0;
    }

    return 1;
  }

  return 0;
}

function get_hostage_drop_pos(var0) {
  var1 = var0.origin + anglesToForward(var0.angles) * 72 + (0, 0, 24);
  var2 = scripts\engine\trace::ray_trace(var0.origin + (0, 0, 24), var1);

  if(var2["fraction"] >= 1) {
    var3 = getclosestpointonnavmesh(var1, var0);
  } else {
    var3 = var1.origin;
  }

  return var3;
}

function registerchallenge(var0, var1) {
  var2 = var0 + (0, 0, 30);
  var3 = var0;
  var4 = scripts\engine\trace::ray_trace(var2, var3, [self.body, self]);
  var5 = var4["normal"];
  var6 = vectortoangles(var5);

  if(!isDefined(var5) || var5 == (0, 0, 0)) {
    return self.angles;
  }

  var7 = generateaxisanglesfromupvector(var5, self.angles);
  return var7;
}

function create_objective(var0, var1) {
  var2 = scripts\cp\cp_objectives::requestworldid("pickup_hostage", 10);

  if(!isDefined(var1)) {
    var1 = "icon_waypoint_marker";
  }

  objective_setplayintro(var2, 0);
  objective_state(var2, "current");
  objective_icon(var2, var1);

  if(!isDefined(self.attach_entity)) {
    objective_position(var2, var0);
  } else {
    objective_onentity(var2, self.attach_entity);
    objective_setzoffset(var2, 32);
  }

  objective_setbackground(var2, 2);
  var3 = "CP_BR_SYRK_OBJECTIVES/HVT";

  if(isDefined(self.label)) {
    var3 = self.label;
  }

  objective_setlabel(var2, var3);
  return var2;
}

function set_hvt_label(var0, var1) {
  if(!isDefined(self.waypoint)) {
    return;
  }

  objective_setlabel(self.waypoint, var0);
  self.label = var0;

  if(isDefined(var1)) {
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

      var0 = getcompleteweaponname("super_default_zm");
      self notify("offhand_fired", var0);
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
      var0 = scripts\cp\cp_weapons::switchtoweaponreliable(self.ref_12939, 0);
    } else {
      self.spawn_module_intro4 = scripts\cp\cp_weapon::buildweapon("iw8_pi_mike1911", [], "none", "none", -1);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self.spawn_module_intro4, undefined, undefined, 1);
      var0 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.spawn_module_intro4, 0);

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
  var0 = self;
  var1 = 64;
  var2 = 1.5;
  var3 = ["scriptable_door_wooden_panel_mp_01", "scriptable_door_wooden_hollow_mp_01"];

  for(;;) {
    var4 = [];
    var5 = getentitylessscriptablearrayinradius(undefined, undefined, var0.origin, var1);

    for(var6 = 0; var6 < var5.size; var6++) {
      if(var5[var6] scriptableisdoor()) {
        var4 = var5[var6];
      }
    }

    for(var7 = 0; var7 < var4.size; var7++) {
      var4[var7] setscriptablepartstate("door", "left_30", 0);
    }

    wait var2;
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

function run_stealth_funcs(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  var2 = var0.origin[2];
  var3 = scripts\engine\trace::create_solid_ai_contents(1);
  var4 = var0.origin + (0, 0, 12);
  var5 = var0.origin - (0, 0, 24);
  var6 = [var0, var0.player_rig, var1.body];

  if(isDefined(var1.head)) {
    GscBinSkip0(0x2e, var6.size, var1.head);
  }

  var7 = var0 scripts\engine\trace::player_trace(var4, var5, var0.angles, var6, var3)["shape_position"];
  return var7;
}

function turret_fob_self_destruct(var0) {
  if(!isDefined(var0) || !isDefined(var0.classname) || !isDefined(var0.basename)) {
    return false;
  }

  if(istrue(self isalternatemode(var0))) {
    return false;
  }

  if(var0 hasattachment("akimbo", 1)) {
    return false;
  }

  if(istrue(var0.isalternate) && var0.classname == "grenade") {
    return false;
  }

  if(var0.basename == "iw8_ar_mike4_mpv2b" || getsubstr(var0.basename, 0, 19) == "iw8_ar_sierra552_mp") {
    return false;
  }

  if(getsubstr(var0.basename, 0, 7) == "iw8_pi_" || getsubstr(var0.basename, 0, 7) == "iw8_sm_" || getsubstr(var0.basename, 0, 7) == "iw8_ar_" || var0.basename == "iw_lm_lima86_mp" || var0.basename == "iw8_sh_charlie725_mp" || var0.basename == "iw8_sh_oscar12_mp") {
    if(getsubstr(var0.basename, 0, 7) == "iw8_pi_" && var0 hasattachment("stock", 1)) {
      return false;
    }

    return true;
  }

  return false;
}

function ref_12350(var0) {
  var0 playsoundonmovingent("sdr_cop_hostage_pickup_ground_plr");
}

function ref_12351(var0) {
  var0 playsoundonmovingent("sdr_cop_hostage_pickup_ground_plr_npc ");
}

function modeplayerkilledspawn(var0) {
  var0 playsoundonmovingent("sdr_cp_hostage_dropoff_ground_plr");
}

function modeplayerskipdialog(var0) {
  var0 playsoundonmovingent("sdr_cp_hostage_dropoff_ground_plr_npc");
}

function ref_1234f(var0) {
  var0 playsoundonmovingent("sdr_cop_hostage_pickup_ground_pilot");
}

function modeonexitlaststandfunc(var0) {
  var0 playsoundonmovingent("sdr_cp_hostage_dropoff_ground_pilot");
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