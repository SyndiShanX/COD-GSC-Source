/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_pickup_hostage.gsc
***********************************************/

#using script_cbb0697de4c5728;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_anim;
#using scripts\cp\cp_kidnapper;
#using scripts\cp\cp_objectives;
#using scripts\cp\cp_outofbounds;
#using scripts\cp\cp_pickup_hostage;
#using scripts\cp\cp_player_battlechatter;
#using scripts\cp\cp_weapons;
#using scripts\cp\interaction;
#using scripts\cp\utility;
#using scripts\cp_mp\anim_scene;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace cp_pickup_hostage;
#using_animtree("script_model");

function registerhvtscriptmodels() {
  level.scr_animtree["hvt"] = #animtree;
  init_anims();
}

function initdefaulthvtmodel(origin, bodymodel, headmodel, pickuphintstring, drophintstring, var_de45455f6c181b1b, carryobjectasset, isfemale) {
  if(!isDefined(origin)) {
    return;
  }

  if(!isDefined(bodymodel)) {
    if(istrue(isfemale)) {
      bodymodel = "morales_hostage_fullbody";
    } else {
      bodymodel = "british_pilot_fullbody";
    }
  }

  if(!isDefined(pickuphintstring)) {
    pickuphintstring = &"CP_BR_SYRK_OBJECTIVES/HVT_PICKUP";
  }

  if(!isDefined(drophintstring)) {
    drophintstring = "drop_pilot_hostage";
  }

  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight"]);
  endpoint = scripts\engine\trace::ray_trace(origin + (0, 0, 100), origin - (0, 0, 100), undefined, contents);
  hvt = spawn("script_model", endpoint["position"]);
  hvt.body = spawn("script_model", hvt.origin);
  hvt.body setModel(bodymodel);
  hvt.body linkTo(hvt);
  hvt.idleanim = ter_op(istrue(isfemale), "sdr_cp_hostage_dropoff_ground_idle_female", "sdr_cp_hostage_dropoff_ground_idle_pilot");
  hvt.headoffset = ter_op(istrue(isfemale), (-6, 1, 0), (-9, 1, 0));
  hvt.spawn_origin = hvt.origin;

  if(isDefined(headmodel)) {
    hvt.head = spawn("script_model", hvt.origin);
    hvt.head setModel(headmodel);
    hvt.head linkTo(hvt.body, "j_neck", hvt.headoffset, (0, 0, 0));
    hvt.head.animname = "hvt";
    hvt.head useanimtree(level.scr_animtree["hvt"]);
    hvt.headmodel = headmodel;
    hvt.head scriptmodelplayanim(hvt.idleanim);
  }

  hvt.gender = ter_op(istrue(isfemale), "female", "male");
  hvt.body.animname = "hvt";
  hvt.body useanimtree(level.scr_animtree["hvt"]);
  hvt.bodymodel = bodymodel;
  hvt.drophintstring = drophintstring;
  hvt.pickuphintstring = pickuphintstring;
  hvt.body scriptmodelplayanim(hvt.idleanim);
  hvt.carryobjectasset = ter_op(isDefined(carryobjectasset), carryobjectasset, "hostage_pilot");

  if(!isDefined(level.hvtlist)) {
    level.hvtlist = [];
  }

  level.hvtlist[level.hvtlist.size] = hvt;
  hvt thread hostage_enable_rescue(0, 0);
  hvt thread monitorhvt_gooddroppos();
  return hvt;
}

function hostagespawnwm(bodymodel, headmodel, headoffset, donthide) {
  hostage = spawn("script_model", self gettagorigin("j_clavicle_le"));
  hostage.head = spawn("script_model", self gettagorigin("j_clavicle_le"));
  hostage.angles = self gettagangles("j_clavicle_le");

  if(isDefined(bodymodel)) {
    hostage setModel(bodymodel);
  }

  if(isDefined(headmodel)) {
    hostage.head setModel(headmodel);
  }

  if(!isDefined(headoffset)) {
    headoffset = (-9, 1, 0);
  }

  hostage.head linkTo(hostage, "j_neck", headoffset, (0, 0, 0));
  hostage scriptmodelplayanim("sdr_cp_hostage_walk_hostage");
  hostage linkTo(self, "j_clavicle_le");

  if(!istrue(donthide)) {
    hostage hide();
    hostage.head hide();
  }

  if(isPlayer(self)) {
    hostage hidefromplayer(self);
    hostage.head hidefromplayer(self);
  }

  hostage.animname = "hvt";
  hostage.head.animname = "hvt";
  hostage.head useanimtree(level.scr_animtree["hvt"]);
  hostage useanimtree(level.scr_animtree["hvt"]);
  self.wmhostage = hostage;
  return hostage;
}

function deletepickuphostage() {
  if(isDefined(self.head)) {
    self.head delete();
  }

  self notify("delete");
  waitframe();
  self delete();
}

function hostagedrop(player, hostage, position, spawndrop, waittime, forcepos, preventuse, invehicle) {
  self endon("delete");

  if(!isDefined(player)) {
    player = self.carrier;
  }

  if(!isDefined(position)) {
    position = hostage.origin;
  }

  if(!isDefined(hostage)) {
    hostage = self;
  }

  if(!isDefined(invehicle)) {
    invehicle = 0;
  }

  player notify("hostage_dropped_by_me");

  if(isDefined(self.objectiveent)) {
    self.objectiveent unlink();
    self.objectiveent.origin = self.origin;
    self.objectiveent linkTo(self);
    objective_setzoffset(self.objnum, 30);
    objective_unpinforclient(self.objnum, player);
  }

  if(isDefined(self.hostage_drop_override_data)) {
    waittime = self.hostage_drop_override_data.waittime;
    forcepos = self.hostage_drop_override_data.forcepos;
    preventuse = self.hostage_drop_override_data.preventuse;
  }

  hostage.carried = 0;
  hostage.carrier = undefined;
  hostage unlink();

  if(!player.inlaststand) {
    player enableusability();
  }

  toggledrophintstring(0, player, hostage);
  player notify("dropped_hostage");

  if(istrue(forcepos)) {
    hostage.origin = position;
  } else {
    if(hostage hostage_carrier_oob(player)) {
      if(isDefined(hostage.last_good_drop_pos)) {
        position = hostage.last_good_drop_pos;
      }
    }

    hostage.origin = _getphysicspointaboutnavmesh(position);

    if(hostage is_hostage_oob()) {
      if(isDefined(hostage.last_good_drop_pos)) {
        position = hostage.last_good_drop_pos;
        hostage.origin = _getphysicspointaboutnavmesh(position);
      }
    }

    hostage thread hostage_confirm_good_angles(player);
  }

  if(!istrue(invehicle)) {
    hostage.angles = getanglesfromsurfacenormal(hostage.origin, self);
  }

  if(!isDefined(spawndrop) && isDefined(hostage.useobj)) {
    hostage.useobj.origin = hostage.origin;
  }

  if(isDefined(player)) {
    player.carryobject = undefined;
    player.disable_map_tablet = undefined;

    if(isDefined(player.wmhostage)) {
      player.wmhostage unlink();

      if(isDefined(player.wmhostage.head)) {
        player.wmhostage.head delete();
      }

      player.wmhostage delete();
      player.wmhostage = undefined;
    }

    player player_restoreweapons();
    player player_removecarrydebuff();
  }

  if(isDefined(waittime)) {
    wait waittime;
  }

  if(isDefined(player) && isDefined(player.hostagecarried)) {
    player.hostagecarried show();

    if(isDefined(player.hostagecarried.head)) {
      player.hostagecarried.head show();
    }

    player.hostagecarried = undefined;
    player.is_dropping_hostage = undefined;
  }

  if(istrue(preventuse)) {
    hostage hudoutlinedisable();

    if(isDefined(hostage.head)) {
      hostage.head hudoutlinedisable();
    }

    hostage notify("dropped");
    player hint_prompt("enter_vehicle_with_hostage", 0);
    return hostage;
  }

  hostage togglehvtusable(1);

  if(!isDefined(hostage.pickuphintstring)) {
    hostage.pickuphintstring = &"CP_BR_SYRK_OBJECTIVES/HVT_PICKUP";
  }

  if(!isDefined(hostage.hostage_drop_override_data)) {
    if(isDefined(hostage.idleanim)) {
      hostage.body scriptmodelplayanim(hostage.idleanim);

      if(isDefined(hostage.head)) {
        hostage.head scriptmodelplayanim(hostage.idleanim);
      }
    }
  }

  if(!istrue(hostage.nowaypoint) && !isDefined(self.waypoint)) {
    hostage.waypoint = create_objective(hostage.origin + (0, 0, 30), "icon_waypoint_marker");
    objective_setplayintro(hostage.waypoint, 0);
    objective_setplayoutro(hostage.waypoint, 0);
  }

  hostage thread hostage_enable_rescue(0);
  hostage thread watchfordelete();
  hostage thread watchfornewdrop();

  if(isDefined(hostage.hostage_drop_override_data)) {
    if(isDefined(hostage.hostage_drop_override_data.call_back_func)) {
      level thread[[hostage.hostage_drop_override_data.call_back_func]](hostage, hostage.hostage_drop_override_data);
    }

    waitframe();
    hostage.vehicle = hostage.hostage_drop_override_data.vehicle;
    hostage.hostage_drop_override_data = undefined;
  }

  hostage notify("dropped");
  return hostage;
}

function is_hostage_oob() {
  if(isDefined(level.outofboundstriggers)) {
    foreach(trigger in level.outofboundstriggers) {
      if(self istouching(trigger)) {
        return true;
      }
    }
  }

  return false;
}

function _getphysicspointaboutnavmesh(pt) {
  contents = scripts\engine\trace::create_contents(undefined, 1, 1, undefined, undefined, undefined, undefined);
  var_bc1fb594d8a6e68a = physics_raycast(pt + (0, 0, 48), pt - (0, 0, 48), contents, undefined, 0, "physicsquery_closest");
  hit = isDefined(var_bc1fb594d8a6e68a) && var_bc1fb594d8a6e68a.size > 0;

  if(hit) {
    hitpos = var_bc1fb594d8a6e68a[0]["position"];
    return hitpos;
  }

  return pt;
}

function player_restoreweapons() {
  player = self;

  if(istrue(player.inlaststand)) {
    return;
  }

  if(isDefined(player.hostagetemppistol)) {
    player scripts\cp\cp_weapons::_takeweapon(player.hostagetemppistol);
    player.hostagetemppistol = undefined;
  }

  if(isDefined(player.puhostagerestoreweapon)) {
    self switchtoweapon(player.puhostagerestoreweapon);
    player.puhostagerestoreweapon = undefined;
  }
}

function hostage_confirm_good_angles(player) {
  var_8fdee444bf3f0305 = confirm_good_pickup_location(self.origin, self.angles, player);

  if(!istrue(var_8fdee444bf3f0305.failed)) {
    self.angles = var_8fdee444bf3f0305.angles;
    return;
  }

  var_72189ddd797f8bb2 = 0;
  var_2d86928904c0521c = [];
  var_2d86928904c0521c[var_2d86928904c0521c.size] = var_8fdee444bf3f0305.currentbestpos;

  if(isDefined(var_8fdee444bf3f0305.currentbestpos)) {
    currentbestdist = var_8fdee444bf3f0305.currentbestdist;
    currentbestpos = getclosestpointonnavmesh(var_8fdee444bf3f0305.currentbestpos);

    for(i = 0; i < 10; i++) {
      var_df814e82bd6814f8 = confirm_good_pickup_location(currentbestpos, self.angles, player);

      if(!istrue(var_df814e82bd6814f8.failed)) {
        self.origin = var_df814e82bd6814f8.origin;
        self.angles = var_df814e82bd6814f8.angles;
        return;
      } else {
        var_2d86928904c0521c[var_2d86928904c0521c.size] = currentbestpos;

        if(var_df814e82bd6814f8.currentbestdist > currentbestdist && !array_contains(var_2d86928904c0521c, getclosestpointonnavmesh(var_df814e82bd6814f8.currentbestpos))) {
          currentbestdist = var_df814e82bd6814f8.currentbestdist;
          currentbestpos = getclosestpointonnavmesh(var_df814e82bd6814f8.currentbestpos);
        } else {
          currentbestdist = 0;
          var_72189ddd797f8bb2 += 512;
          randompoint = getrandomnavpoint(self.origin, var_72189ddd797f8bb2);
          currentbestpos = getclosestpointonnavmesh(randompoint);
        }
      }

      wait 0.05;
    }
  }

  announcement("<dev string:x1c>");

  if(isDefined(self.spawn_origin)) {
    self.origin = self.spawn_origin;
  }
}

function confirm_good_pickup_location(var_abbb4b8615510568, ref_angles, player, radius) {
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1);
  currentangles = ref_angles;
  var_79b0da6daa286045 = var_abbb4b8615510568 + (0, 0, 24);

  if(!isDefined(radius)) {
    radius = 36;
  }

  info = spawnStruct();
  info.currentbestdist = 0;

  for(i = 0; i < 12; i++) {
    var_4f1e8173f86258 = var_abbb4b8615510568 + anglesToForward(currentangles) * radius + (0, 0, 24);

    if(scripts\engine\trace::ray_trace_passed(var_79b0da6daa286045, var_4f1e8173f86258, self, contents)) {
      var_647c8c4cc914e7d1 = var_4f1e8173f86258 - (0, 0, 4);
      var_647c9e4cc9150f67 = var_4f1e8173f86258 + (0, 0, 4);
      playertrace = undefined;

      if(isPlayer(player)) {
        playertrace = player scripts\engine\trace::player_trace(var_647c8c4cc914e7d1, var_647c9e4cc9150f67, player.angles, player, contents);
      } else {
        playertrace = player scripts\engine\trace::capsule_trace(var_647c8c4cc914e7d1, var_647c9e4cc9150f67, 30, 60, player.angles, player, contents);
      }

      var_bf43a05b1ee8acb6 = playertrace["fraction"];

      if(isDefined(var_bf43a05b1ee8acb6) && var_bf43a05b1ee8acb6 >= 1) {
        if(i > 0) {
          print3d(var_4f1e8173f86258, "<dev string:x4d>", (0, 1, 0), 1, 1, 300, 1);
        }

        info.origin = var_abbb4b8615510568;
        info.angles = currentangles;
        var_311bf43e8fc0f6d8 = distancesquared(var_4f1e8173f86258, getclosestpointonnavmesh(var_4f1e8173f86258));

        if(var_311bf43e8fc0f6d8 > info.currentbestdist) {
          info.currentbestdist = var_311bf43e8fc0f6d8;
          info.currentbestpos = var_4f1e8173f86258;
        }

        return info;
      } else {
        print3d(var_4f1e8173f86258, "<dev string:x4f>", (1, 1, 0), 1, 1, 300, 1);

        var_311bf43e8fc0f6d8 = distancesquared(var_4f1e8173f86258, getclosestpointonnavmesh(var_4f1e8173f86258));

        if(var_311bf43e8fc0f6d8 > info.currentbestdist) {
          info.currentbestdist = var_311bf43e8fc0f6d8;
          info.currentbestpos = var_4f1e8173f86258;
        }
      }
    } else {
      print3d(var_4f1e8173f86258, "<dev string:x4f>", (1, 0, 0), 1, 1, 300, 1);
    }

    if(currentangles[1] + 30 >= 360) {
      currentangles = (currentangles[0], currentangles[1] - 360, currentangles[2]);
    }

    currentangles = (currentangles[0], currentangles[1] + 30, currentangles[2]);
  }

  info.failed = 1;
  return info;
}

function hostage_enable_rescue(var_a09f4cc9e6523d76, var_de45455f6c181b1b) {
  self endon("delete");
  duration = "duration_medium";

  if(istrue(var_de45455f6c181b1b)) {
    duration = "duration_long";
  }

  wait 1;
  togglehvtusable(1, "duration_medium");

  while(true) {
    self.interaction_handle waittill("trigger", player);

    if(!player is_valid_player() || istrue(player.isjuggernaut)) {
      continue;
    }

    if(istrue(self.pickup_disabled)) {
      continue;
    }

    player val::set("hostage", "vehicle_use", 0);
    togglehvtusable(0);
    waitframe();

    if(istrue(self.carried_by_vehicle) && !istrue(self.convoy_pickedup)) {
      hostage_onuse(player, "truck");
    } else if(istrue(self.convoy_pickedup)) {
      hostage_onuse(player, "moving_ai_truck");
      self.convoy_pickedup = undefined;
    } else {
      hostage_onuse(player);
    }

    break;
  }

  if(var_a09f4cc9e6523d76) {
    self notify("hostage_rescued");
  }
}

function togglehvtusable(toggle, duration) {
  if(!isDefined(self.interaction_handle)) {
    self.interaction_handle = spawn("script_model", self.origin + (16, 0, 8));
    self.interaction_handle linkTo(self);
  }

  if(toggle) {
    self.pickup_disabled = 0;
    self.interaction_handle function_dfb78b3e724ad620(1);

    if(!isDefined(self.interaction_handle.pickuphintstring)) {
      self.interaction_handle.pickuphintstring = &"CP_BR_SYRK_OBJECTIVES/HVT_PICKUP";
    }

    self.interaction_handle setCursorHint("HINT_BUTTON");
    self.interaction_handle setHintString(self.pickuphintstring);
    self.interaction_handle setuserange(64);
    self.interaction_handle sethintdisplayrange(128);
    self.interaction_handle sethintdisplayfov(80);
    self.interaction_handle sethintonobstruction("show");

    if(isDefined(duration)) {
      self.interaction_handle setuseholdduration(duration);
    } else {
      self.interaction_handle setuseholdduration("duration_short");
    }

    if(!isDefined(duration) || duration == "duration_short") {
      self.interaction_handle sethintrequiresholding(0);
    } else {
      self.interaction_handle sethintrequiresholding(1);
    }

    if(!istrue(self.nowaypoint) && !isDefined(self.waypoint)) {
      self.waypoint = create_objective(self.origin + (0, 0, 30), "icon_waypoint_marker");
    }
  } else {
    self.pickup_disabled = 1;
    self.interaction_handle function_dfb78b3e724ad620(0);

    if(!istrue(self.nowaypoint)) {
      self notify("freedobjective");
      freeworldid("pickup_hostage");

      if(isDefined(self.waypoint)) {
        objective_delete(self.waypoint);
        self.waypoint = undefined;
      }
    }
  }

  self notify("hvt_interaction_updated");
}

function monitorhvt_gooddroppos() {
  level endon("game_ended");
  self endon("delete");
  self notify("monitor_good_droppos");
  self endon("monitor_good_droppos");
  self.last_good_drop_pos = self.origin;

  while(true) {
    wait 1;

    if(hostage_carrier_oob()) {
      continue;
    }

    self.last_good_drop_pos = self.origin;
  }
}

function hostage_carrier_oob(player) {
  if(isDefined(self.carrier)) {
    player = self.carrier;
  }

  if(isDefined(player) && isPlayer(player)) {
    if(scripts\cp\cp_outofbounds::isoob(player, 0)) {
      return true;
    }
  }

  return false;
}

function watchfordelete() {
  level endon("game_ended");
  wp = 0;

  if(isDefined(self.waypoint)) {
    wp = self.waypoint;
  }

  waittill_any_2("deleted", "death");
  freeworldid("pickup_hostage");
  objective_delete(wp);
  self.waypoint = undefined;

  if(array_contains(level.hvtlist, self)) {
    array_remove(level.hvtlist, self);
  }
}

function watchfornewdrop() {
  level endon("game_ended");
  self endon("deleted");
  self endon("death");
  self endon("player_picked_up_hostage");
  self endon("convoy_pickedup_hvt");
  self notify("watchNewDrop");
  self endon("watchNewDrop");

  while(true) {
    wait 2.5;
    trace = ray_trace(self.origin + (0, 0, 2), self.origin - (0, 0, 24));
    var_24a474d9ccb84218 = trace["fraction"];

    if(isDefined(var_24a474d9ccb84218) && var_24a474d9ccb84218 >= 1) {
      groundpoint = drop_to_ground(self.origin, 72);
      self.origin = _getphysicspointaboutnavmesh(groundpoint) + (0, 0, 2);
    }
  }
}

function do_hvt_pickup_anim(player) {
  player.puhostagerestoreweapon = player getcurrentweapon();
  player.ability_invulnerable = 1;
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "obj_hvi_pickup");
  gunless = makeweapon("iw8_gunless");
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  success = player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 0);
  player.gunlessweapon = gunless;
  player val::set("carry", "weapon_switch", 0);
  player val::set("carry", "weapon_pickup", 0);
  player setstance("stand");
  player val::set("carry", "usability", 0);
  player waittill_any_timeout_1(1, "weapon_change");
  player thread create_player_rig(player, "player_pickup_hvt");
  self.body anim_first_frame_solo(player.player_rig, "pickup_hvt_ground");
  link_player_to_rig(player, 0.25);
  player.vmvip = spawn("script_model", self.origin);
  player.vmvip.angles = self.angles;
  player.vmvip setModel(self.bodymodel);
  player.vmvip.animname = "hvt_vm";

  if(!isDefined(self.gender)) {
    self.gender = "male";
  }

  var_6c88a02daa90e205 = ter_op(self.gender == "female", "hvt_vm_female", "hvt_vm");
  player.vmvip useanimtree(level.scr_animtree[var_6c88a02daa90e205]);

  if(self.gender == "female") {
    self.body useanimtree(level.scr_animtree["hvt_female"]);
  }

  if(!isDefined(self.bodymodel)) {
    self.bodymodel = self.body.model;
  }

  self.body anim_first_frame_solo(player.vmvip, "pickup_hvt_ground");
  player.vmvip hide();
  player.vmvip showtoplayer(player);

  if(isDefined(player.vmvip.head)) {
    player.vmvip.head hide();
    player.vmvip.head showtoplayer(player);
  }

  if(isDefined(self.head)) {
    self.head hidefromplayer(player);
  }

  self.body hidefromplayer(player);
  self.body thread scripts\common\anim::anim_single_solo(player.vmvip, "pickup_hvt_ground");
  self.body thread scripts\common\anim::anim_single_solo(self.body, "pickup_hvt_ground");
  self.body thread scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, "pickup_hvt_ground");
  wait getanimlength(%vm_carry_ally_in_player);
  self.body hide();

  if(isDefined(self.head)) {
    self.head hide();
  }

  self linkTo(player);
  self.body useanimtree(level.scr_animtree["hvt"]);

  if(isDefined(player.vmvip.head)) {
    player.vmvip.head delete();
  }

  player.vmvip delete();
  groundpos = gettruegroundposition(player, self);
  player setOrigin(groundpos);
  player notify("remove_rig");
  player.ability_invulnerable = undefined;
}

function do_fast_hvt_pickup(player) {
  player.puhostagerestoreweapon = player getcurrentweapon();
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "obj_hvi_pickup");
  gunless = makeweapon("iw8_gunless");
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  success = player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 0);
  player.gunlessweapon = gunless;
  player val::set("carry", "weapon_switch", 0);
  player val::set("carry", "weapon_pickup", 0);
  player setstance("stand");
  player waittill_any_timeout_1(1, "weapon_change");
  self.body hide();

  if(isDefined(self.head)) {
    self.head hide();
  }

  self linkTo(player);
}

function create_player_rig(player, animname, rig_model) {
  if(!isDefined(player) || isDefined(player.player_rig)) {
    return;
  }

  player.animname = animname;

  if(!isDefined(rig_model)) {
    rig_model = "viewhands_base_iw8";
  }

  player function_b88c89bb7cd1ab8e(player.origin);
  player_rig = spawn("script_arms", player.origin, 0, 0, player);
  player_rig.player = player;
  player.player_rig = player_rig;
  player.player_rig hide();
  player.player_rig.animname = animname;
  player.player_rig useanimtree(#animtree);
  player.player_rig.angles = ter_op(isDefined(player.angles), player.angles, (0, 0, 0));
  waittill_any_3("remove_rig", "death", "disconnect");
  remove_player_rig(player);
}

function remove_player_rig(player) {
  if(!isDefined(player) || !isDefined(player.player_rig)) {
    return;
  }

  player unlink();
  player.player_rig delete();
  player.player_rig = undefined;
}

function link_player_to_rig(player, blendtime) {
  player endon("death");
  player endon("disconnect");

  if(!isDefined(player) || !isDefined(player.player_rig)) {
    return;
  }

  if(!isDefined(blendtime)) {
    blendtime = 0.25;
  }

  player playerlinktoblend(player.player_rig, "tag_player", blendtime, 0.1, 0.1);
  wait blendtime;
  player playerlinktodelta(player.player_rig, "tag_player", 1, 0, 0, 0, 0, 1, 1, 1);
  player.player_rig showonlytoplayer(player);
}

function do_hvt_drop_anim(player, dropdistance) {
  if(!isDefined(dropdistance)) {
    dropdistance = "medium";
  }

  gunless = makeweapon("iw8_gunless");
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  success = player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 0);
  player waittill_any_timeout_1(1, "weapon_change");
  player resetcarryobject();
  player setstance("stand");
  player val::set("carry", "usability", 0);
  player unlink();
  player allowmovement(1);
  self unlink();
  self.body unlink();
  self.body show();
  self.body hidefromplayer(player);
  player.vmvip = spawn("script_model", self.origin);
  player.vmvip.angles = self.angles;
  player.vmvip setModel(self.bodymodel);
  player.vmvip.animname = "hvt_vm";
  player.vmvip useanimtree(level.scr_animtree["hvt_vm"]);
  player.vmvip hide();
  player.vmvip showtoplayer(player);
  player anim_first_frame_solo(player.vmvip, "drop_hvt_ground");
  player anim_first_frame_solo(self.body, "drop_hvt_ground");

  if(isDefined(self.head) && isDefined(player.vmvip.head)) {
    player anim_first_frame_solo(player.vmvip.head, "drop_hvt_ground");
    player anim_first_frame_solo(self.head, "drop_hvt_ground");
  }

  dropanim = "drop_hvt_ground";
  player thread create_player_rig(player, "player_drop_hvt");
  player anim_first_frame_solo(player.player_rig, dropanim);
  link_player_to_rig(player);
  player anim_first_frame_solo(player.vmvip, "drop_hvt_ground");
  player anim_first_frame_solo(self.body, "drop_hvt_ground");

  if(isDefined(self.head) && isDefined(player.vmvip.head)) {
    player anim_first_frame_solo(player.vmvip.head, "drop_hvt_ground");
    player anim_first_frame_solo(self.head, "drop_hvt_ground");
  }

  player thread scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, dropanim);
  player thread scripts\common\anim::anim_single_solo(self.body, dropanim);
  player thread scripts\common\anim::anim_single_solo(player.vmvip, dropanim);
  var_a29a724ba7b5e149 = getanimlength(%sdr_cp_hostage_dropoff_ground_player);
  var_27f60ee941918228 = getanimlength(%sdr_cp_hostage_dropoff_ground_pilot);
  wait var_a29a724ba7b5e149;
  player notify("remove_rig");
  player scripts\cp\cp_weapons::_takeweapon(gunless);
  groundpos = gettruegroundposition(player, self);
  player setOrigin(groundpos);
  player thread player_restoreweapons();
  wait var_27f60ee941918228 - var_a29a724ba7b5e149;
  player.vmvip delete();
  self.body show();
  self.origin = self.body.origin;
  self.angles = self.body.angles;
  wait 0.25;
  self.body linkTo(self);
}

#using_animtree("mp_vehicles_always_loaded");

function do_hvt_pickup_from_truck_anim(player) {
  init_anims();
  truck = self.vehicle;
  var_4ad036db23f15698 = self;
  player.puhostagerestoreweapon = player getcurrentweapon();
  gunless = makeweapon("iw8_gunless");
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  success = player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 0);
  player.gunlessweapon = gunless;
  player val::set("carry", "weapon_switch", 0);
  player val::set("carry", "weapon_pickup", 0);
  player freezecontrols(1);
  player setstance("stand");
  player waittill_any_timeout_1(1, "weapon_change");
  player thread create_player_rig(player, "player_vip_decho");
  truck anim_first_frame_solo(player.player_rig, "truck_hvt_pickup");
  link_player_to_rig(player, 0.5);
  player.vmvip = spawn("script_model", self.origin);
  player.vmvip.angles = self.angles;
  player.vmvip setModel(self.body.model);
  player.vmvip.animname = "hvt_vm";
  player.vmvip useanimtree(level.scr_animtree["hvt_vm"]);

  if(isDefined(self.head)) {
    player.vmvip.head = spawn("script_model", self.origin);
    player.vmvip.head setModel(self.head.model);
    player.vmvip.head linkTo(player.vmvip, "j_neck", self.headoffset, (0, 0, 0));
    player.vmvip.head.animname = "hvt_vm";
    player.vmvip.head useanimtree(level.scr_animtree["hvt_vm"]);
  }

  player.vmvip hide();

  if(isDefined(player.vmvip.head)) {
    player.vmvip.head hide();
  }

  player.vmvip showtoplayer(player);

  if(isDefined(player.vmvip.head)) {
    player.vmvip.head showtoplayer(player);
  }

  var_4ad036db23f15698.body hidefromplayer(player);

  if(isDefined(var_4ad036db23f15698.head)) {
    var_4ad036db23f15698.head hidefromplayer(player);
  }

  truck anim_first_frame_solo(var_4ad036db23f15698.body, "truck_hvt_pickup");

  if(isDefined(var_4ad036db23f15698.head)) {
    truck anim_first_frame_solo(var_4ad036db23f15698.head, "truck_hvt_pickup");
  }

  truck anim_first_frame_solo(player.vmvip, "truck_hvt_pickup");

  if(isDefined(player.vmvip.head)) {
    truck anim_first_frame_solo(player.vmvip.head, "truck_hvt_pickup");
  }

  truck thread scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, "truck_hvt_pickup");
  truck thread scripts\common\anim::anim_single_solo(player.vmvip, "truck_hvt_pickup");
  truck thread scripts\common\anim::anim_single_solo(var_4ad036db23f15698.body, "truck_hvt_pickup");
  truck vehicleplayanim(%vm_hostage_pickup_truck_decho);
  wait getanimlength(%sdr_cp_hostage_pickup_truck_decho);
  var_4ad036db23f15698.body hide();

  if(isDefined(var_4ad036db23f15698.head)) {
    var_4ad036db23f15698.head hide();
  }

  var_4ad036db23f15698 linkTo(player);
  player.vmvip delete();

  if(isDefined(player.vmvip.head)) {
    player.vmvip.head delete();
  }

  player notify("remove_rig");
  player freezecontrols(0);
}

function do_hvt_load_on_truck_anim(player) {
  init_anims();
  self.hostage_drop_override_data = player.hostage_drop_override_data;
  truck = player.hostage_drop_override_data.vehicle;
  var_4ad036db23f15698 = self;
  gunless = makeweapon("iw8_gunless");
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  success = player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 0);
  player waittill_any_timeout_1(1, "weapon_change");
  player setstance("stand");
  player allowcrouch(0);
  player unlink();
  player allowmovement(1);
  self unlink();
  self.body unlink();
  var_4ad036db23f15698.animname = "hvt";
  var_4ad036db23f15698 useanimtree(level.scr_animtree["hvt"]);
  player thread create_player_rig(player, "player_vip_decho");
  truck anim_first_frame_solo(player.player_rig, "truck_hvt_dropoff");
  link_player_to_rig(player, 0.5);
  player resetcarryobject();
  self.body show();
  self.body hidefromplayer(player);
  player.vmvip = spawn("script_model", truck.origin);
  player.vmvip.angles = self.angles;
  player.vmvip setModel(self.bodymodel);
  player.vmvip.animname = "hvt_vm";
  player.vmvip useanimtree(level.scr_animtree["hvt_vm"]);
  player.vmvip hide();

  if(isDefined(player.vmvip.head)) {
    player.vmvip.head hide();
  }

  player.vmvip showtoplayer(player);

  if(isDefined(player.vmvip.head)) {
    player.vmvip.head showtoplayer(player);
  }

  var_4ad036db23f15698.body show();
  var_4ad036db23f15698.body hidefromplayer(player);
  truck anim_first_frame_solo(var_4ad036db23f15698.body, "truck_hvt_dropoff");

  if(isDefined(var_4ad036db23f15698.head)) {
    truck anim_first_frame_solo(var_4ad036db23f15698.head, "truck_hvt_dropoff");
  }

  truck anim_first_frame_solo(player.vmvip, "truck_hvt_dropoff");

  if(isDefined(player.vmvip.head)) {
    truck anim_first_frame_solo(player.vmvip.head, "truck_hvt_dropoff");
  }

  truck vehicleplayanim(%vm_hostage_dropoff_truck_decho);
  truck thread scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, "truck_hvt_dropoff", "tag_origin");
  truck thread scripts\common\anim::anim_single_solo(player.vmvip, "truck_hvt_dropoff", "tag_origin");
  truck thread scripts\common\anim::anim_single_solo(var_4ad036db23f15698.body, "truck_hvt_dropoff", "tag_origin");
  wait getanimlength(level.scr_anim["player_vip_decho"]["truck_hvt_dropoff"]);

  if(isDefined(player.vmvip.head)) {
    player.vmvip.head delete();
  }

  player.vmvip delete();
  var_4ad036db23f15698.body show();

  if(isDefined(var_4ad036db23f15698.head)) {
    var_4ad036db23f15698.head show();
  }

  truck thread scripts\common\anim::anim_single_solo(var_4ad036db23f15698.body, "truck_hvt_idle", "tag_origin");
  player notify("remove_rig");
  player allowcrouch(1);
  player scripts\cp\cp_weapons::_takeweapon(gunless);
  self.origin = self.body.origin;
  self.angles = self.body.angles;
  self.body linkTo(self);
  self linkTo(truck);
}

function load_hvt(player, heli, side) {
  heli notify("handoff_hvt");
  player notify("loading_hvt_onto_heli");

  if(!isDefined(side)) {
    side = "left";
  }

  animalias = "blima_drop_l";
  var_13279a856648c13a = "sdr_cp_hostage_dropoff_blima_L_idle_outro_ally";
  var_b4db4339a112636 = "sdr_cp_hostage_dropoff_blima_L_idle_outro_pilot";

  if(side == "right") {
    animalias = "blima_drop_r";
    var_13279a856648c13a = "sdr_cp_hostage_dropoff_blima_R_idle_outro_ally";
    var_b4db4339a112636 = "sdr_cp_hostage_dropoff_blima_R_idle_outro_pilot";
  }

  wmexfilally = heli.wmexfilally;
  gunless = makeweapon("iw8_gunless");
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  success = player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 0);
  player waittill_any_timeout_1(1, "weapon_change");
  player setstance("stand");
  player allowcrouch(0);
  hvt = player.hostagecarried;
  hvt.onchopper = 1;
  player unlink();
  player allowmovement(1);
  hvt unlink();
  hvt.body unlink();
  hvt.body useanimtree(level.scr_animtree["hvt"]);
  hvt.body.animname = "hvt";
  player thread scripts\cp\cp_pickup_hostage::create_player_rig(player, "player_vip_blima");
  heli scripts\common\anim::anim_first_frame_solo(player.player_rig, animalias);
  link_player_to_rig(player, 0.4);
  player resetcarryobject();
  hvt.body show();
  hvt.body hidefromplayer(player);
  vmexfilally = spawn("script_model", heli.origin);
  vmexfilally setModel("allied_pilot_fullbody_3");
  vmexfilally useanimtree(level.scr_animtree["exfil_ally"]);
  vmexfilally.animname = "exfil_ally";
  vmhvt = spawn("script_model", heli.origin);
  vmhvt setModel(hvt.bodymodel);
  vmhvt useanimtree(level.scr_animtree["hvt_vm"]);
  vmhvt.animname = "hvt_vm";

  if(isDefined(hvt.head)) {
    vmhvt.head = spawn("script_model", heli.origin);
    vmhvt.head setModel(hvt.headmodel);
    vmhvt.head linkTo(vmhvt, "j_neck", (-9, 1, 0), (0, 0, 0));
    vmhvt.head.animname = "hvt_vm";
    vmhvt.head useanimtree(level.scr_animtree["hvt_vm"]);
    vmhvt.head showonlytoplayer(player);
  }

  vmhvt showonlytoplayer(player);
  vmexfilally showonlytoplayer(player);
  wmexfilally show();
  wmexfilally hidefromplayer(player);
  hvt.body show();
  hvt.body hidefromplayer(player);

  if(isDefined(hvt.head)) {
    hvt.head hidefromplayer(player);
  }

  var_fa1c3ebf57b2cb57 = getstartorigin(heli.origin, heli.angles, level.scr_anim["exfil_ally"][animalias]);
  var_17f23f3c3c2c39b7 = getstartangles(heli.origin, heli.angles, level.scr_anim["exfil_ally"][animalias]);
  var_2acda10e084f8bee = getstartorigin(heli.origin, heli.angles, level.scr_anim["exfil_ally_vm"][animalias]);
  var_4d1a68cf58abbbc4 = getstartangles(heli.origin, heli.angles, level.scr_anim["exfil_ally_vm"][animalias]);
  var_58c75ed97b180840 = getstartorigin(heli.origin, heli.angles, level.scr_anim["hvt_vm"][animalias]);
  var_b13a37b4f6f912ee = getstartangles(heli.origin, heli.angles, level.scr_anim["hvt_vm"][animalias]);
  wmexfilally.origin = var_fa1c3ebf57b2cb57;
  wmexfilally.angles = var_17f23f3c3c2c39b7;
  vmexfilally.origin = var_2acda10e084f8bee;
  vmexfilally.angles = var_4d1a68cf58abbbc4;
  vmhvt.origin = var_58c75ed97b180840;
  vmhvt.angles = var_b13a37b4f6f912ee;
  hvt.origin = var_58c75ed97b180840;
  hvt.angles = var_b13a37b4f6f912ee;
  vmexfilally linkTo(heli);
  vmhvt linkTo(heli);
  hvt linkTo(heli);
  heli.vmexfilally = vmexfilally;
  heli.vmhvt = vmhvt;
  startpos = getstartorigin(heli.origin, heli.angles, level.scr_anim["player_vip_blima"][animalias]);
  startangles = getstartangles(heli.origin, heli.angles, level.scr_anim["player_vip_blima"][animalias]);
  player allowcrouch(0);
  player setstance("stand");
  wmexfilally notify("stop_idle_anim");
  heli thread scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, animalias, "tag_origin");
  heli thread scripts\common\anim::anim_single_solo(vmexfilally, animalias, "tag_origin");
  heli thread scripts\common\anim::anim_single_solo(wmexfilally, animalias, "tag_origin");
  heli thread scripts\common\anim::anim_single_solo(vmhvt, animalias, "tag_origin");
  heli thread scripts\common\anim::anim_single_solo(hvt.body, animalias, "tag_origin");
  var_a29a724ba7b5e149 = getanimlength(level.scr_anim["player_vip_blima"][animalias]);
  var_27f60ee941918228 = getanimlength(level.scr_anim["hvt"][animalias]);
  wait var_a29a724ba7b5e149;
  player setstance("stand");
  player notify("remove_rig");
  player scripts\cp\cp_weapons::_takeweapon(gunless);
  player allowcrouch(1);
  hostagedrop(player, player.hostagecarried, player.hostagecarried.origin, 0, 0.5, 1, 1, 1);
  wait var_27f60ee941918228 - var_a29a724ba7b5e149;
  hvt.body linkTo(hvt);

  if(isDefined(hvt.head)) {
    hvt.head linkTo(hvt.body);
  }

  hvt linkTo(heli);

  if(isDefined(vmhvt.head)) {
    vmhvt.head delete();
  }

  vmhvt delete();
  vmexfilally delete();
  hvt.body show();

  if(isDefined(hvt.head)) {
    hvt.head show();
  }

  wmexfilally show();
  hvt.body scriptmodelplayanim(var_b4db4339a112636);
  wmexfilally scriptmodelplayanim(var_13279a856648c13a);
}

function hostage_onuse(player, pickup_type, useobj) {
  level endon("game_ended");
  self endon("dropped");

  if(!isDefined(pickup_type)) {
    pickup_type = "ground";
  }

  if(isDefined(self.waypoint)) {
    objective_delete(self.waypoint);
    self.waypoint = undefined;
  }

  if(isDefined(self.objectiveent)) {
    self.objectiveent unlink();
    self.objectiveent.origin = player.origin;
    self.objectiveent linkTo(player);
    objective_setzoffset(self.objnum, 45);
    objective_pinforclient(self.objnum, player);
  }

  self.angles = (0, self.angles[1], 0);

  switch (pickup_type) {
    case #"hash_b111a4547c7d9125":
      useobj[[level.hostage_onusefunc]](player, self);
      break;
    case #"hash_bd2b14a6c78f31a8":
      do_hvt_pickup_from_truck_anim(player);
      break;
    case #"hash_8d96201d150187de":
      do_hvt_pickup_anim(player);
      break;
    case #"hash_47e8e37fa4dd7fde":
      do_fast_hvt_pickup(player);
      break;
  }

  player setcarryobject(self.carryobjectasset);
  player val::reset_all("carry");

  if(isDefined(player.gunlessweapon)) {
    player scripts\cp\cp_weapons::_takeweapon(player.gunlessweapon);
    player.gunlessweapon = undefined;
  }

  player player_carrydebuff();
  player.carryobject = self;
  player thread listen_for_super_triggered();
  thread hostage_watchdrop(player, self, self.useobj);
  thread hostage_laststandlistener(player);
  player thread watchfordrophintstring(player, self);
  wait 0.3;
  player.hostagecarried = self;
  self.carried_by_vehicle = 0;
  level notify("player_picked_up_hostage", player);
  self notify("player_picked_up_hostage", player);
}

function toggledrophintstring(toggle, player, hostage) {
  if(isDefined(hostage.overridehintstring)) {
    player hint_prompt(hostage.overridehintstring, toggle);
    return;
  }

  if(!isDefined(hostage.drophintstring)) {
    player hint_prompt("drop_pilot_hostage", toggle);
    return;
  }

  player hint_prompt(hostage.drophintstring, toggle);
}

function watchfordrophintstring(player, hostage) {
  level endon("game_ended");
  player endon("death");
  player endon("hostage_dropped_by_me");
  player endon("loading_hvt_onto_heli");
  hostage endon("dropped");

  while(true) {
    if(candrophostage(player)) {
      toggledrophintstring(1, player, hostage);
    } else {
      toggledrophintstring(0, player, hostage);
    }

    waitframe();
  }
}

function hostage_laststandlistener(player) {
  level endon("game_ended");
  self endon("dropped");
  player waittill_any_3("last_stand", "disconnect", "being_subdued");
  player disableusability();
  player resetcarryobject();
  toggledrophintstring(0, player, self);
  self.body show();

  if(isDefined(self.head)) {
    self.head show();
  }

  player thread listen_for_revive();
  hostagedrop(player, self, player.origin);
}

function listen_for_revive() {
  self endon("disconnect");
  self waittill("revive");

  while(isDefined(self.bspawningviaac130)) {
    self waittill("landed_after_respawn");
  }

  if(isDefined(self.hostagetemppistol)) {
    scripts\cp\cp_weapons::_takeweapon(self.hostagetemppistol);
    self.hostagetemppistol = undefined;

    if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
      scripts\cp\cp_weapons::switchtoweaponreliable(self.weaponlist[0]);
    }
  }
}

function hostage_watchdrop(player, hostage, useobj) {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  self endon("death");
  player endon("last_stand");
  player endon("loading_hvt_onto_heli");
  self.carried = 1;
  var_4d8d53679dd13086 = 0;
  self.carrier = player;
  updaterate = 0.05;

  while(self.carried) {
    if(!player useButtonPressed()) {
      var_4d8d53679dd13086 = 1;
    }

    if(!istrue(candrophostage(player))) {
      waitframe();
      continue;
    }

    timeused = 0;
    player setclientomnvar("zm_hint_progress", timeused);
    player allowmovement(1);

    while(var_4d8d53679dd13086 && player useButtonPressed()) {
      timeused += updaterate;
      player allowmovement(0);

      if(timeused > 0.3 && candrophostage(player)) {
        player.is_dropping_hostage = 1;

        if(isDefined(player.wmhostage)) {
          player.wmhostage unlink();

          if(isDefined(player.wmhostage.head)) {
            player.wmhostage.head delete();
          }

          player.wmhostage delete();
          player.wmhostage = undefined;
        }

        player.ability_invulnerable = 1;
        player notify("hostage_dropped_by_me");
        toggledrophintstring(0, player, hostage);
        invehicle = 0;

        if(isDefined(player.hostage_drop_override_data)) {
          do_hvt_load_on_truck_anim(player);
          invehicle = 1;
        } else {
          do_hvt_drop_anim(player, "medium");
        }

        droppos = self.origin;
        hostagedrop(player, hostage, droppos, undefined, 0.4, 0, 0, invehicle);
        player.ability_invulnerable = undefined;
        return;
      }

      player setclientomnvar("zm_hint_progress", timeused / 0.3);
      wait updaterate;
    }

    waitframe();
  }
}

function candrophostage(player) {
  if(player isonladder()) {
    return 0;
  }

  if(isDefined(player.hostage_drop_override_data)) {
    return 1;
  }

  if(isDefined(level.exfil_heli_landing) && distance2d(level.exfil_heli_landing.origin, player.origin) <= 512) {
    return 0;
  }

  var_30ee65724920b3ca = player.origin + anglesToForward(player.angles) * 72 + (0, 0, 24);
  trace = ray_trace(player.origin + (0, 0, 24), var_30ee65724920b3ca);

  if(trace["fraction"] >= 1) {
    groundpoint = drop_to_ground(var_30ee65724920b3ca, 24);

    if(abs(groundpoint[2] - var_30ee65724920b3ca[2]) > 40) {
      return 0;
    } else {
      return 1;
    }

    return;
  }

  return 0;
}

function get_hostage_drop_pos(player) {
  var_30ee65724920b3ca = player.origin + anglesToForward(player.angles) * 72 + (0, 0, 24);
  trace = ray_trace(player.origin + (0, 0, 24), var_30ee65724920b3ca);

  if(trace["fraction"] >= 1) {
    droppos = getclosestpointonnavmesh(var_30ee65724920b3ca, player);
  } else {
    droppos = player.origin;
  }

  return droppos;
}

function getanglesfromsurfacenormal(position, hostage) {
  starttrace = position + (0, 0, 30);
  endtrace = position;
  trace = ray_trace(starttrace, endtrace, [self.body, self]);
  surfacenormal = trace["normal"];
  upangles = vectortoangles(surfacenormal);

  if(!isDefined(surfacenormal) || surfacenormal == (0, 0, 0)) {
    return self.angles;
  }

  var_e76c0c29a4590aeb = generateaxisanglesfromupvector(surfacenormal, self.angles);

  iprintlnbold(var_e76c0c29a4590aeb);

  return var_e76c0c29a4590aeb;
}

function create_objective(objective_pos, icon) {
  objective_id = requestworldid("pickup_hostage", 10);

  if(!isDefined(icon)) {
    icon = "icon_waypoint_marker";
  }

  objective_setplayintro(objective_id, 0);
  objective_state(objective_id, "current");
  objective_icon(objective_id, icon);

  if(!isDefined(self.attach_entity)) {
    objective_position(objective_id, objective_pos);
  } else {
    objective_onentity(objective_id, self.attach_entity);
    objective_setzoffset(objective_id, 32);
  }

  objective_setbackground(objective_id, 2);
  var_5977073fd144597b = "CP_BR_SYRK_OBJECTIVES/HVT";

  if(isDefined(self.label)) {
    var_5977073fd144597b = self.label;
  }

  objective_setlabel(objective_id, var_5977073fd144597b);
  return objective_id;
}

function set_hvt_label(label, compass) {
  if(!isDefined(self.waypoint)) {
    return;
  }

  objective_setlabel(self.waypoint, label);
  self.label = label;

  if(isDefined(compass)) {
    objective_setshowoncompass(self.waypoint, 1);
  }
}

function listen_for_super_triggered() {
  self endon("last_stand");
  self endon("dropped_hostage");
  self endon("disconnect");

  while(true) {
    if(self secondaryoffhandbuttonPressed() && self fragButtonPressed()) {
      if(istrue(self.super_activated) || !self.super_ready) {
        waitframe();
        continue;
      }

      super = makeweapon("super_default_zm");
      self notify("offhand_fired", super);
      wait 1;
    }

    waitframe();
  }
}

function player_removecarrydebuff() {
  val::reset_all("carry");
  allow_secondary_offhand_weapons(1);
  allow_player_basejumping(1, "carry_debuff");
  self enableoffhandweapons();
  self allowmountside(1);
  self allowmounttop(1);
  self allowjog(1);
  scripts\cp\cp_kidnapper::setimmunetokidnapper(0);

  if(isDefined(self.suit)) {
    self setsuit(self.suit);
    namespace_46e942396566f2da::function_7c62c6c14aba289b();
  } else {
    self setsuit("iw9_suit_cp");
    namespace_46e942396566f2da::function_7c62c6c14aba289b();
  }

  self disableemptyclipweaponswitch(0);
  self notify("stop_hostagecarrier_watching_for_doors");
  scripts\cp\utility::_unsetperk("specialty_sprintfire");
  self.overrideweaponspeed_speedscale = undefined;
  self[[level.move_speed_scale]]();
  val::reset_all("carry");
}

function player_carrydebuff() {
  val::set("carry", "mantle", 0);

  if(!istrue(self.disable_hvt_nomantle)) {
    val::set("carry", "allow_jump", 0);
  }

  val::set("carry", "prone", 0);
  val::set("carry", "crouch", 0);
  val::set("carry", "sprint", 0);
  val::set("carry", "melee", 0);
  allow_player_basejumping(0, "carry_debuff");
  self disableoffhandweapons();
  self allowmountside(0);
  self allowmounttop(0);
  allow_secondary_offhand_weapons(0);
  self allowjog(0);
  giveperk("specialty_sprintfire");
  self.overrideweaponspeed_speedscale = 0.75;
  self[[level.move_speed_scale]]();
  scripts\cp\cp_kidnapper::setimmunetokidnapper(1);

  if(isDefined(self.puhostagerestoreweapon)) {
    if(isallowedweapon(self.puhostagerestoreweapon)) {
      success = scripts\cp\cp_weapons::switchtoweaponreliable(self.puhostagerestoreweapon, 0);
    } else {
      self.hostagetemppistol = scripts\cp_mp\weapon::buildweapon("iw8_pi_mike1911", [], "none", "none", -1);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self.hostagetemppistol, undefined, undefined, 1);
      success = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.hostagetemppistol, 0);

      if((self.puhostagerestoreweapon.basename == "iw8_green_beam_mp" || self.puhostagerestoreweapon.basename == "iw8_spotter_scope_mp") && isDefined(self.primaryweaponobj)) {
        self.puhostagerestoreweapon = self.primaryweaponobj;
      }
    }
  }

  thread scripts\cp\utility::watch_and_open_scriptable_doors_in_radius();
  val::set("carry", "weapon_switch", 0);
  val::set("carry", "weapon_switch_clip", 0);
  val::set("carry", "weapon_pickup", 0);
  val::set("carry", "usability", 0);
  self.disable_map_tablet = 1;
}

function watchforscriptabledoorsinradius() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("dropped_hostage");
  self endon("stop_hostagecarrier_watching_for_doors");
  player = self;
  radius = 64;
  var_284908edb3c3318d = 1.5;
  var_36f2d54bcbaae65a = ["scriptable_door_wooden_panel_mp_01", "scriptable_door_wooden_hollow_mp_01"];

  while(true) {
    var_9bc823cab1bb2862 = [];
    var_913576e1dc1762b5 = getentitylessscriptablearray(undefined, undefined, player.origin, radius);

    for(i = 0; i < var_913576e1dc1762b5.size; i++) {
      if(var_913576e1dc1762b5[i] scriptableisdoor()) {
        var_9bc823cab1bb2862[var_9bc823cab1bb2862.size] = var_913576e1dc1762b5[i];
      }
    }

    for(x = 0; x < var_9bc823cab1bb2862.size; x++) {
      var_9bc823cab1bb2862[x] setscriptablepartstate("door", "left_30", 0);
    }

    wait var_284908edb3c3318d;
  }
}

function player_refillammo() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("dropped_hostage");

  while(true) {
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

  while(true) {
    if(scripts\cp_mp\utility\player_utility::_isalive() && self.team != "spectator" && self getcurrentweaponclipammo() <= 0 && self getweaponammostock(self.currentprimaryweapon) <= 0) {
      self givestartammo(self.currentprimaryweapon);
      wait 1;
      continue;
    }

    waitframe();
  }
}

function gettruegroundposition(player, hvt) {
  if(!isDefined(player)) {
    return;
  }

  currentz = player.origin[2];
  contents = scripts\engine\trace::create_solid_ai_contents(1);
  startpos = player.origin + 12 * (0, 0, 1);
  endpos = player.origin - 24 * (0, 0, 1);
  ignorearray = [player, player.player_rig, hvt.body];

  if(isDefined(hvt.head)) {
    ignorearray[ignorearray.size] = hvt.head;
  }

  groundpos = player scripts\engine\trace::player_trace(startpos, endpos, player.angles, ignorearray, contents)["shape_position"];
  return groundpos;
}

function isallowedweapon(weapon) {
  if(!isDefined(weapon) || !isDefined(weapon.classname) || !isDefined(weapon.basename)) {
    return false;
  }

  announcement("<dev string:x51>" + weapon.isalternate + "<dev string:x65>" + weapon.classname);

  if(istrue(self isalternatemode(weapon))) {
    return false;
  }

  if(istrue(weapon.isalternate) && weapon.classname == "grenade") {
    return false;
  }

  if(getsubstr(weapon.basename, 0, 7) == "iw8_pi_" || getsubstr(weapon.basename, 0, 7) == "iw8_sm_" || getsubstr(weapon.basename, 0, 7) == "iw8_ar_" || weapon.basename == "iw_lm_lima86_mp" || weapon.basename == "iw8_sh_charlie725_mp" || weapon.basename == "iw8_sh_oscar12_mp") {
    if(getsubstr(weapon.basename, 0, 7) == "iw8_pi_" && weapon hasattachment("stock")) {
      return false;
    }

    return true;
  }

  return false;
}

function pickup_sound_playervm_handler(guy) {
  guy playsoundonmovingent("sdr_cop_hostage_pickup_ground_plr");
}

function pickup_sound_playerwm_handler(guy) {
  guy playsoundonmovingent("sdr_cop_hostage_pickup_ground_plr_npc ");
}

function dropoff_sound_playervm_handler(guy) {
  guy playsoundonmovingent("sdr_cp_hostage_dropoff_ground_plr");
}

function dropoff_sound_playerwm_handler(guy) {
  guy playsoundonmovingent("sdr_cp_hostage_dropoff_ground_plr_npc");
}

function pickup_sound_hvt_handler(guy) {
  guy playsoundonmovingent("sdr_cop_hostage_pickup_ground_pilot");
}

function dropoff_sound_hvt_handler(guy) {
  guy playsoundonmovingent("sdr_cp_hostage_dropoff_ground_pilot");
}

#using_animtree("script_model");

function init_anims() {
  level.scr_animtree["player_pickup_hvt"] = #animtree;
  level.scr_anim["player_pickup_hvt"]["pickup_hvt_ground"] = % vm_carry_ally_in_player;
  level.scr_eventanim["player_pickup_hvt"]["pickup_hvt_ground"] = % "hash_5c49ceb6c3160eb0";
  scripts\common\anim::addnotetrack_customfunction("player_pickup_hvt", "sdr_cop_hostage_pickup_ground_plr", &pickup_sound_playervm_handler);
  scripts\common\anim::addnotetrack_customfunction("player_pickup_hvt", "sdr_cop_hostage_pickup_ground_plr_npc", &pickup_sound_playerwm_handler);
  level.scr_animtree["player_drop_hvt"] = #animtree;
  level.scr_anim["player_drop_hvt"]["drop_hvt_ground"] = % vm_carry_ally_out_player;
  level.scr_eventanim["player_drop_hvt"]["drop_hvt_ground"] = % "hash_32949f6fa736acb6";
  scripts\common\anim::addnotetrack_customfunction("player_drop_hvt", "sdr_cp_hostage_dropoff_ground_plr", &dropoff_sound_playervm_handler);
  scripts\common\anim::addnotetrack_customfunction("player_drop_hvt", "sdr_cp_hostage_dropoff_ground_plr_npc", &dropoff_sound_playerwm_handler);
  level.scr_animtree["hvt"] = #animtree;
  level.scr_anim["hvt"]["pickup_hvt_ground"] = % sdr_cp_hostage_pickup_ground_pilot;
  level.scr_animtree["hvt_female"] = #animtree;
  level.scr_anim["hvt_female"]["pickup_hvt_ground"] = % sdr_cp_hostage_pickup_ground_pilot_female;
  level.scr_anim["hvt"]["drop_hvt_ground"] = % sdr_cp_hostage_dropoff_ground_pilot;
  level.scr_animtree["hvt_vm"] = #animtree;
  level.scr_anim["hvt_vm"]["pickup_hvt_ground"] = % vm_carry_ally_in_ally;
  level.scr_animtree["hvt_vm_female"] = #animtree;
  level.scr_anim["hvt_vm_female"]["pickup_hvt_ground"] = % vm_carry_ally_in_ally_female;
  level.scr_anim["hvt_vm"]["drop_hvt_ground"] = % vm_carry_ally_out_ally;
  level.scr_animtree["hvt"] = #animtree;
  level.scr_anim["hvt"]["blima_drop_r"] = % sdr_cp_hostage_dropoff_blima_r_pilot;
  level.scr_anim["hvt"]["blima_drop_r_idle"] = % sdr_cp_hostage_dropoff_blima_r_idle_outro_pilot;
  level.scr_anim["hvt"]["blima_drop_l"] = % sdr_cp_hostage_dropoff_blima_l_pilot;
  level.scr_anim["hvt"]["blima_drop_l_idle"] = % sdr_cp_hostage_dropoff_blima_l_idle_outro_pilot;
  level.scr_animtree["exfil_ally"] = #animtree;
  level.scr_anim["exfil_ally"]["blima_drop_l"] = % sdr_cp_hostage_dropoff_blima_l_ally;
  level.scr_anim["exfil_ally"]["blima_drop_l_idle_in"] = % sdr_cp_hostage_dropoff_blima_l_idle_intro_ally;
  level.scr_anim["exfil_ally"]["blima_drop_l_idle_out"] = % sdr_cp_hostage_dropoff_blima_l_idle_outro_ally;
  level.scr_anim["exfil_ally"]["blima_drop_r"] = % sdr_cp_hostage_dropoff_blima_r_ally;
  level.scr_anim["exfil_ally"]["blima_drop_r_idle_in"] = % sdr_cp_hostage_dropoff_blima_r_idle_intro_ally;
  level.scr_anim["exfil_ally"]["blima_drop_r_idle_out"] = % sdr_cp_hostage_dropoff_blima_r_idle_outro_ally;
  level.scr_anim["exfil_ally_vm"]["blima_drop_l"] = % vm_hostage_dropoff_blima_l_ally;
  level.scr_anim["exfil_ally_vm"]["blima_drop_r"] = % vm_hostage_dropoff_blima_r_ally;
  level.scr_animtree["player_vip_blima"] = #animtree;
  level.scr_anim["player_vip_blima"]["blima_drop_l"] = % vm_hostage_dropoff_blima_l_player;
  level.scr_eventanim["player_vip_blima"]["blima_drop_l"] = % "hash_7a2fd34023670978";
  level.scr_anim["player_vip_blima"]["blima_drop_r"] = % vm_hostage_dropoff_blima_r_player;
  level.scr_eventanim["player_vip_blima"]["blima_drop_r"] = % "hash_7a2fe14023672142";
  level.scr_anim["hvt_vm"]["blima_drop_l"] = % vm_hostage_dropoff_blima_l_pilot;
  level.scr_anim["hvt_vm"]["blima_drop_r"] = % vm_hostage_dropoff_blima_r_pilot;
  level.scr_anim["hvt_vm"]["truck_hvt_pickup"] = % vm_hostage_pickup_truck_pilot;
  level.scr_anim["hvt_vm"]["truck_hvt_dropoff"] = % vm_hostage_dropoff_truck_pilot;
  level.scr_animtree["hvt"] = #animtree;
  level.scr_anim["hvt"]["blima_drop_r"] = % sdr_cp_hostage_dropoff_blima_r_pilot;
  level.scr_anim["hvt"]["blima_drop_r_idle"] = % sdr_cp_hostage_dropoff_blima_r_idle_outro_pilot;
  level.scr_anim["hvt"]["blima_drop_l"] = % sdr_cp_hostage_dropoff_blima_l_pilot;
  level.scr_anim["hvt"]["blima_drop_l_idle"] = % sdr_cp_hostage_dropoff_blima_l_idle_outro_pilot;
  level.scr_anim["hvt"]["truck_hvt_dropoff"] = % sdr_cp_hostage_dropoff_truck_pilot;
  level.scr_anim["hvt"]["truck_hvt_pickup"] = % sdr_cp_hostage_pickup_truck_pilot;
  level.scr_anim["hvt"]["truck_hvt_idle"] = % sdr_cp_hostage_dropoff_truck_idle_pilot;
  level.scr_animtree["exfil_ally"] = #animtree;
  level.scr_anim["exfil_ally"]["blima_drop_l"] = % sdr_cp_hostage_dropoff_blima_l_ally;
  level.scr_anim["exfil_ally"]["blima_drop_l_idle_in"] = % sdr_cp_hostage_dropoff_blima_l_idle_intro_ally;
  level.scr_anim["exfil_ally"]["blima_drop_l_idle_out"] = % sdr_cp_hostage_dropoff_blima_l_idle_outro_ally;
  level.scr_anim["exfil_ally"]["blima_drop_r"] = % sdr_cp_hostage_dropoff_blima_r_ally;
  level.scr_anim["exfil_ally"]["blima_drop_r_idle_in"] = % sdr_cp_hostage_dropoff_blima_r_idle_intro_ally;
  level.scr_anim["exfil_ally"]["blima_drop_r_idle_out"] = % sdr_cp_hostage_dropoff_blima_r_idle_outro_ally;
  level.scr_anim["exfil_ally_vm"]["blima_drop_l"] = % vm_hostage_dropoff_blima_l_ally;
  level.scr_anim["exfil_ally_vm"]["blima_drop_r"] = % vm_hostage_dropoff_blima_r_ally;
  level.scr_animtree["exfil_ally"] = #animtree;
  level.scr_anim["exfil_ally"]["turn_left"] = % sdr_cp_hostage_dropoff_blima_l_transition_l_ally;
  level.scr_anim["exfil_ally"]["turn_right"] = % sdr_cp_hostage_dropoff_blima_l_transition_r_ally;
  level.scr_animtree["player_vip_decho"] = #animtree;
  level.scr_anim["player_vip_decho"]["truck_hvt_dropoff"] = % vm_hostage_dropoff_truck_player;
  level.scr_eventanim["player_vip_decho"]["truck_hvt_dropoff"] = % "hash_640f8a844959b1c0";
  level.scr_anim["player_vip_decho"]["truck_hvt_pickup"] = % vm_hostage_pickup_truck_player;
  level.scr_eventanim["player_vip_decho"]["truck_hvt_pickup"] = % "hash_b488f6a76678ea";
  level.scr_animtree["decho_truck"] = #animtree;
  level.scr_anim["decho_truck"]["decho_hvt_pickup"] = % sdr_cp_hostage_pickup_truck_decho;
  level.scr_anim["decho_truck"]["decho_hvt_dropoff"] = % sdr_cp_hostage_dropoff_truck_decho;
  level.scr_animtree["decho_truck_vm"] = #animtree;
  level.scr_anim["decho_truck_vm"]["decho_hvt_pickup"] = % vm_hostage_pickup_truck_decho;
  level.scr_anim["decho_truck_vm"]["decho_hvt_dropoff"] = % vm_hostage_dropoff_truck_decho;
}