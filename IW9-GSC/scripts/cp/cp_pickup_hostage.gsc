/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_pickup_hostage.gsc
***********************************************/

#using_animtree("script_model");

registerhvtscriptmodels() {
  level.scr_animtree["hvt"] = #animtree;
  init_anims();
}

initdefaulthvtmodel(origin, bodymodel, headmodel, pickuphintstring, drophintstring, _id_DE45455F6C181B1B, carryobjectasset, isfemale) {
  if(!isDefined(origin)) {
    return;
  }
  if(!isDefined(bodymodel)) {
    if(istrue(isfemale))
      bodymodel = "morales_hostage_fullbody";
    else
      bodymodel = "british_pilot_fullbody";
  }

  if(!isDefined(pickuphintstring))
    pickuphintstring = &"CP_BR_SYRK_OBJECTIVES/HVT_PICKUP";

  if(!isDefined(drophintstring))
    drophintstring = "drop_pilot_hostage";

  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight"]);
  endpoint = scripts\engine\trace::ray_trace(origin + (0, 0, 100), origin - (0, 0, 100), undefined, contents);
  _id_0BA89A03FF462799 = spawn("script_model", endpoint["position"]);
  _id_0BA89A03FF462799.body = spawn("script_model", _id_0BA89A03FF462799.origin);
  _id_0BA89A03FF462799.body setModel(bodymodel);
  _id_0BA89A03FF462799.body linkTo(_id_0BA89A03FF462799);
  _id_0BA89A03FF462799.idleanim = scripts\engine\utility::ter_op(istrue(isfemale), "sdr_cp_hostage_dropoff_ground_idle_female", "sdr_cp_hostage_dropoff_ground_idle_pilot");
  _id_0BA89A03FF462799.headoffset = scripts\engine\utility::ter_op(istrue(isfemale), (-6, 1, 0), (-9, 1, 0));
  _id_0BA89A03FF462799.spawn_origin = _id_0BA89A03FF462799.origin;

  if(isDefined(headmodel)) {
    _id_0BA89A03FF462799.head = spawn("script_model", _id_0BA89A03FF462799.origin);
    _id_0BA89A03FF462799.head setModel(headmodel);
    _id_0BA89A03FF462799.head linkTo(_id_0BA89A03FF462799.body, "j_neck", _id_0BA89A03FF462799.headoffset, (0, 0, 0));
    _id_0BA89A03FF462799.head.animname = "hvt";
    _id_0BA89A03FF462799.head useanimtree(level.scr_animtree["hvt"]);
    _id_0BA89A03FF462799.headmodel = headmodel;
    _id_0BA89A03FF462799.head scriptmodelplayanim(_id_0BA89A03FF462799.idleanim);
  }

  _id_0BA89A03FF462799.gender = scripts\engine\utility::ter_op(istrue(isfemale), "female", "male");
  _id_0BA89A03FF462799.body.animname = "hvt";
  _id_0BA89A03FF462799.body useanimtree(level.scr_animtree["hvt"]);
  _id_0BA89A03FF462799.bodymodel = bodymodel;
  _id_0BA89A03FF462799.drophintstring = drophintstring;
  _id_0BA89A03FF462799.pickuphintstring = pickuphintstring;
  _id_0BA89A03FF462799.body scriptmodelplayanim(_id_0BA89A03FF462799.idleanim);
  _id_0BA89A03FF462799.carryobjectasset = scripts\engine\utility::ter_op(isDefined(carryobjectasset), carryobjectasset, "hostage_pilot");

  if(!isDefined(level.hvtlist))
    level.hvtlist = [];

  level.hvtlist[level.hvtlist.size] = _id_0BA89A03FF462799;
  _id_0BA89A03FF462799 thread hostage_enable_rescue(0, 0);
  _id_0BA89A03FF462799 thread monitorhvt_gooddroppos();
  return _id_0BA89A03FF462799;
}

hostagespawnwm(bodymodel, headmodel, headoffset, _id_7B4388C3A450812A) {
  hostage = spawn("script_model", self gettagorigin("j_clavicle_le"));
  hostage.head = spawn("script_model", self gettagorigin("j_clavicle_le"));
  hostage.angles = self gettagangles("j_clavicle_le");

  if(isDefined(bodymodel))
    hostage setModel(bodymodel);

  if(isDefined(headmodel))
    hostage.head setModel(headmodel);

  if(!isDefined(headoffset))
    headoffset = (-9, 1, 0);

  hostage.head linkTo(hostage, "j_neck", headoffset, (0, 0, 0));
  hostage scriptmodelplayanim("sdr_cp_hostage_walk_hostage");
  hostage linkTo(self, "j_clavicle_le");

  if(!istrue(_id_7B4388C3A450812A)) {
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

deletepickuphostage() {
  if(isDefined(self.head))
    self.head delete();

  self notify("delete");
  waitframe();
  self delete();
}

hostagedrop(player, hostage, position, _id_7006C5C506086629, waittime, forcepos, preventuse, invehicle) {
  self endon("delete");

  if(!isDefined(player))
    player = self.carrier;

  if(!isDefined(position))
    position = hostage.origin;

  if(!isDefined(hostage))
    hostage = self;

  if(!isDefined(invehicle))
    invehicle = 0;

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

  if(!player.inlaststand)
    player enableusability();

  toggledrophintstring(0, player, hostage);
  player notify("dropped_hostage");

  if(istrue(forcepos))
    hostage.origin = position;
  else {
    if(hostage hostage_carrier_oob(player)) {
      if(isDefined(hostage.last_good_drop_pos))
        position = hostage.last_good_drop_pos;
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

  if(!istrue(invehicle))
    hostage.angles = getanglesfromsurfacenormal(hostage.origin, self);

  if(!isDefined(_id_7006C5C506086629) && isDefined(hostage.useobj))
    hostage.useobj.origin = hostage.origin;

  if(isDefined(player)) {
    player.carryobject = undefined;
    player.disable_map_tablet = undefined;

    if(isDefined(player.wmhostage)) {
      player.wmhostage unlink();

      if(isDefined(player.wmhostage.head))
        player.wmhostage.head delete();

      player.wmhostage delete();
      player.wmhostage = undefined;
    }

    player player_restoreweapons();
    player player_removecarrydebuff();
  }

  if(isDefined(waittime))
    wait(waittime);

  if(isDefined(player) && isDefined(player.hostagecarried)) {
    player.hostagecarried show();

    if(isDefined(player.hostagecarried.head))
      player.hostagecarried.head show();

    player.hostagecarried = undefined;
    player.is_dropping_hostage = undefined;
  }

  if(istrue(preventuse)) {
    hostage hudoutlinedisable();

    if(isDefined(hostage.head))
      hostage.head hudoutlinedisable();

    hostage notify("dropped");
    player scripts\cp\utility::hint_prompt("enter_vehicle_with_hostage", 0);
    return hostage;
  }

  hostage togglehvtusable(1);

  if(!isDefined(hostage.pickuphintstring))
    hostage.pickuphintstring = &"CP_BR_SYRK_OBJECTIVES/HVT_PICKUP";

  if(!isDefined(hostage.hostage_drop_override_data)) {
    if(isDefined(hostage.idleanim)) {
      hostage.body scriptmodelplayanim(hostage.idleanim);

      if(isDefined(hostage.head))
        hostage.head scriptmodelplayanim(hostage.idleanim);
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
    if(isDefined(hostage.hostage_drop_override_data.call_back_func))
      level thread[[hostage.hostage_drop_override_data.call_back_func]](hostage, hostage.hostage_drop_override_data);

    waitframe();
    hostage.vehicle = hostage.hostage_drop_override_data.vehicle;
    hostage.hostage_drop_override_data = undefined;
  }

  hostage notify("dropped");
  return hostage;
}

is_hostage_oob() {
  if(isDefined(level.outofboundstriggers)) {
    foreach(trigger in level.outofboundstriggers) {
      if(self istouching(trigger))
        return 1;
    }
  }

  return 0;
}

_getphysicspointaboutnavmesh(_id_CDCD3178F5176585) {
  contents = scripts\engine\trace::create_contents(undefined, 1, 1, undefined, undefined, undefined, undefined);
  _id_BC1FB594D8A6E68A = physics_raycast(_id_CDCD3178F5176585 + (0, 0, 48), _id_CDCD3178F5176585 - (0, 0, 48), contents, undefined, 0, "physicsquery_closest");
  hit = isDefined(_id_BC1FB594D8A6E68A) && _id_BC1FB594D8A6E68A.size > 0;

  if(hit) {
    _id_2E3BC21C15E7AB6C = _id_BC1FB594D8A6E68A[0]["position"];
    return _id_2E3BC21C15E7AB6C;
  }

  return _id_CDCD3178F5176585;
}

player_restoreweapons() {
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

hostage_confirm_good_angles(player) {
  _id_8FDEE444BF3F0305 = confirm_good_pickup_location(self.origin, self.angles, player);

  if(!istrue(_id_8FDEE444BF3F0305.failed)) {
    self.angles = _id_8FDEE444BF3F0305.angles;
    return;
  } else {
    _id_72189DDD797F8BB2 = 0;
    _id_2D86928904C0521C = [];
    _id_2D86928904C0521C[_id_2D86928904C0521C.size] = _id_8FDEE444BF3F0305.currentbestpos;

    if(isDefined(_id_8FDEE444BF3F0305.currentbestpos)) {
      currentbestdist = _id_8FDEE444BF3F0305.currentbestdist;
      currentbestpos = getclosestpointonnavmesh(_id_8FDEE444BF3F0305.currentbestpos);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++) {
        _id_DF814E82BD6814F8 = confirm_good_pickup_location(currentbestpos, self.angles, player);

        if(!istrue(_id_DF814E82BD6814F8.failed)) {
          self.origin = _id_DF814E82BD6814F8.origin;
          self.angles = _id_DF814E82BD6814F8.angles;
          return;
        } else {
          _id_2D86928904C0521C[_id_2D86928904C0521C.size] = currentbestpos;

          if(_id_DF814E82BD6814F8.currentbestdist > currentbestdist && !scripts\engine\utility::array_contains(_id_2D86928904C0521C, getclosestpointonnavmesh(_id_DF814E82BD6814F8.currentbestpos))) {
            currentbestdist = _id_DF814E82BD6814F8.currentbestdist;
            currentbestpos = getclosestpointonnavmesh(_id_DF814E82BD6814F8.currentbestpos);
          } else {
            currentbestdist = 0;
            _id_72189DDD797F8BB2 = _id_72189DDD797F8BB2 + 512;
            _id_332BFCF7ECA6F520 = getrandomnavpoint(self.origin, _id_72189DDD797F8BB2);
            currentbestpos = getclosestpointonnavmesh(_id_332BFCF7ECA6F520);
          }
        }

        wait 0.05;
      }
    }

    if(isDefined(self.spawn_origin))
      self.origin = self.spawn_origin;
  }
}

confirm_good_pickup_location(_id_ABBB4B8615510568, _id_5539460D8E2F6A2B, player, radius) {
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1);
  _id_9DBC893FB4BE54F2 = _id_5539460D8E2F6A2B;
  _id_79B0DA6DAA286045 = _id_ABBB4B8615510568 + (0, 0, 24);

  if(!isDefined(radius))
    radius = 36.0;

  info = spawnStruct();
  info.currentbestdist = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 12; _id_AC0E594AC96AA3A8++) {
    _id_004F1E8173F86258 = _id_ABBB4B8615510568 + anglesToForward(_id_9DBC893FB4BE54F2) * radius + (0, 0, 24);

    if(scripts\engine\trace::ray_trace_passed(_id_79B0DA6DAA286045, _id_004F1E8173F86258, self, contents)) {
      _id_647C8C4CC914E7D1 = _id_004F1E8173F86258 - (0, 0, 4);
      _id_647C9E4CC9150F67 = _id_004F1E8173F86258 + (0, 0, 4);
      _id_8C685A74E876C0FD = undefined;

      if(isPlayer(player))
        _id_8C685A74E876C0FD = player scripts\engine\trace::player_trace(_id_647C8C4CC914E7D1, _id_647C9E4CC9150F67, player.angles, player, contents);
      else
        _id_8C685A74E876C0FD = player scripts\engine\trace::capsule_trace(_id_647C8C4CC914E7D1, _id_647C9E4CC9150F67, 30, 60, player.angles, player, contents);

      _id_BF43A05B1EE8ACB6 = _id_8C685A74E876C0FD["fraction"];

      if(isDefined(_id_BF43A05B1EE8ACB6) && _id_BF43A05B1EE8ACB6 >= 1) {
        info.origin = _id_ABBB4B8615510568;
        info.angles = _id_9DBC893FB4BE54F2;
        _id_311BF43E8FC0F6D8 = distancesquared(_id_004F1E8173F86258, getclosestpointonnavmesh(_id_004F1E8173F86258));

        if(_id_311BF43E8FC0F6D8 > info.currentbestdist) {
          info.currentbestdist = _id_311BF43E8FC0F6D8;
          info.currentbestpos = _id_004F1E8173F86258;
        }

        return info;
      } else {
        _id_311BF43E8FC0F6D8 = distancesquared(_id_004F1E8173F86258, getclosestpointonnavmesh(_id_004F1E8173F86258));

        if(_id_311BF43E8FC0F6D8 > info.currentbestdist) {
          info.currentbestdist = _id_311BF43E8FC0F6D8;
          info.currentbestpos = _id_004F1E8173F86258;
        }
      }
    } else {}

    if(_id_9DBC893FB4BE54F2[1] + 30 >= 360)
      _id_9DBC893FB4BE54F2 = (_id_9DBC893FB4BE54F2[0], _id_9DBC893FB4BE54F2[1] - 360, _id_9DBC893FB4BE54F2[2]);

    _id_9DBC893FB4BE54F2 = (_id_9DBC893FB4BE54F2[0], _id_9DBC893FB4BE54F2[1] + 30, _id_9DBC893FB4BE54F2[2]);
  }

  info.failed = 1;
  return info;
}

hostage_enable_rescue(_id_A09F4CC9E6523D76, _id_DE45455F6C181B1B) {
  self endon("delete");
  duration = "duration_medium";

  if(istrue(_id_DE45455F6C181B1B))
    duration = "duration_long";

  wait 1;
  togglehvtusable(1, "duration_medium");

  for(;;) {
    self.interaction_handle waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player() || istrue(player.isjuggernaut)) {
      continue;
    }
    if(istrue(self.pickup_disabled)) {
      continue;
    }
    player _id_3B64EB40368C1450::set("hostage", "vehicle_use", 0);
    togglehvtusable(0);
    waitframe();

    if(istrue(self.carried_by_vehicle) && !istrue(self.convoy_pickedup))
      hostage_onuse(player, "truck");
    else if(istrue(self.convoy_pickedup)) {
      hostage_onuse(player, "moving_ai_truck");
      self.convoy_pickedup = undefined;
    } else
      hostage_onuse(player);

    break;
  }

  if(_id_A09F4CC9E6523D76)
    self notify("hostage_rescued");
}

togglehvtusable(_id_41D8BF229CF29051, duration) {
  if(!isDefined(self.interaction_handle)) {
    self.interaction_handle = spawn("script_model", self.origin + (16, 0, 8));
    self.interaction_handle linkTo(self);
  }

  if(_id_41D8BF229CF29051) {
    self.pickup_disabled = 0;
    self.interaction_handle _meth_DFB78B3E724AD620(1);

    if(!isDefined(self.interaction_handle.pickuphintstring))
      self.interaction_handle.pickuphintstring = &"CP_BR_SYRK_OBJECTIVES/HVT_PICKUP";

    self.interaction_handle setCursorHint("HINT_BUTTON");
    self.interaction_handle setHintString(self.pickuphintstring);
    self.interaction_handle setuserange(64);
    self.interaction_handle sethintdisplayrange(128);
    self.interaction_handle sethintdisplayfov(80);
    self.interaction_handle sethintonobstruction("show");

    if(isDefined(duration))
      self.interaction_handle setuseholdduration(duration);
    else
      self.interaction_handle setuseholdduration("duration_short");

    if(!isDefined(duration) || duration == "duration_short")
      self.interaction_handle sethintrequiresholding(0);
    else
      self.interaction_handle sethintrequiresholding(1);

    if(!istrue(self.nowaypoint) && !isDefined(self.waypoint))
      self.waypoint = create_objective(self.origin + (0, 0, 30), "icon_waypoint_marker");
  } else {
    self.pickup_disabled = 1;
    self.interaction_handle _meth_DFB78B3E724AD620(0);

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

monitorhvt_gooddroppos() {
  level endon("game_ended");
  self endon("delete");
  self notify("monitor_good_droppos");
  self endon("monitor_good_droppos");
  self.last_good_drop_pos = self.origin;

  for(;;) {
    wait 1;

    if(hostage_carrier_oob()) {
      continue;
    }
    self.last_good_drop_pos = self.origin;
  }
}

hostage_carrier_oob(player) {
  if(isDefined(self.carrier))
    player = self.carrier;

  if(isDefined(player) && isPlayer(player)) {
    if(scripts\cp\cp_outofbounds::isoob(player, 0))
      return 1;
  }

  return 0;
}

watchfordelete() {
  level endon("game_ended");
  _id_CDE32B78F52F8B86 = 0;

  if(isDefined(self.waypoint))
    _id_CDE32B78F52F8B86 = self.waypoint;

  scripts\engine\utility::waittill_any_2("deleted", "death");
  scripts\cp\cp_objectives::freeworldid("pickup_hostage");
  objective_delete(_id_CDE32B78F52F8B86);
  self.waypoint = undefined;

  if(scripts\engine\utility::array_contains(level.hvtlist, self))
    scripts\engine\utility::array_remove(level.hvtlist, self);
}

watchfornewdrop() {
  level endon("game_ended");
  self endon("deleted");
  self endon("death");
  self endon("player_picked_up_hostage");
  self endon("convoy_pickedup_hvt");
  self notify("watchNewDrop");
  self endon("watchNewDrop");

  for(;;) {
    wait 2.5;
    trace = scripts\engine\trace::ray_trace(self.origin + (0, 0, 2), self.origin - (0, 0, 24));
    _id_24A474D9CCB84218 = trace["fraction"];

    if(isDefined(_id_24A474D9CCB84218) && _id_24A474D9CCB84218 >= 1) {
      _id_43035DD4CCA0A234 = scripts\engine\utility::drop_to_ground(self.origin, 72);
      self.origin = _getphysicspointaboutnavmesh(_id_43035DD4CCA0A234) + (0, 0, 2);
    }
  }
}

do_hvt_pickup_anim(player) {
  player.puhostagerestoreweapon = player getcurrentweapon();
  player.ability_invulnerable = 1;
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "obj_hvi_pickup");
  gunless = makeweapon("iw8_gunless");
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  success = player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 0);
  player.gunlessweapon = gunless;
  player _id_3B64EB40368C1450::set("carry", "weapon_switch", 0);
  player _id_3B64EB40368C1450::set("carry", "weapon_pickup", 0);
  player setstance("stand");
  player _id_3B64EB40368C1450::set("carry", "usability", 0);
  player scripts\engine\utility::waittill_any_timeout_1(1, "weapon_change");
  player thread create_player_rig(player, "player_pickup_hvt");
  self.body scripts\common\anim::anim_first_frame_solo(player.player_rig, "pickup_hvt_ground");
  link_player_to_rig(player, 0.25);
  player.vmvip = spawn("script_model", self.origin);
  player.vmvip.angles = self.angles;
  player.vmvip setModel(self.bodymodel);
  player.vmvip.animname = "hvt_vm";

  if(!isDefined(self.gender))
    self.gender = "male";

  _id_6C88A02DAA90E205 = scripts\engine\utility::ter_op(self.gender == "female", "hvt_vm_female", "hvt_vm");
  player.vmvip useanimtree(level.scr_animtree[_id_6C88A02DAA90E205]);

  if(self.gender == "female")
    self.body useanimtree(level.scr_animtree["hvt_female"]);

  if(!isDefined(self.bodymodel))
    self.bodymodel = self.body.model;

  self.body scripts\common\anim::anim_first_frame_solo(player.vmvip, "pickup_hvt_ground");
  player.vmvip hide();
  player.vmvip showtoplayer(player);

  if(isDefined(player.vmvip.head)) {
    player.vmvip.head hide();
    player.vmvip.head showtoplayer(player);
  }

  if(isDefined(self.head))
    self.head hidefromplayer(player);

  self.body hidefromplayer(player);
  self.body thread scripts\common\anim::anim_single_solo(player.vmvip, "pickup_hvt_ground");
  self.body thread scripts\common\anim::anim_single_solo(self.body, "pickup_hvt_ground");
  self.body thread scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, "pickup_hvt_ground");
  wait(getanimlength(%vm_carry_ally_in_player));
  self.body hide();

  if(isDefined(self.head))
    self.head hide();

  self linkTo(player);
  self.body useanimtree(level.scr_animtree["hvt"]);

  if(isDefined(player.vmvip.head))
    player.vmvip.head delete();

  player.vmvip delete();
  groundpos = gettruegroundposition(player, self);
  player setOrigin(groundpos);
  player notify("remove_rig");
  player.ability_invulnerable = undefined;
}

do_fast_hvt_pickup(player) {
  player.puhostagerestoreweapon = player getcurrentweapon();
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "obj_hvi_pickup");
  gunless = makeweapon("iw8_gunless");
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  success = player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 0);
  player.gunlessweapon = gunless;
  player _id_3B64EB40368C1450::set("carry", "weapon_switch", 0);
  player _id_3B64EB40368C1450::set("carry", "weapon_pickup", 0);
  player setstance("stand");
  player scripts\engine\utility::waittill_any_timeout_1(1, "weapon_change");
  self.body hide();

  if(isDefined(self.head))
    self.head hide();

  self linkTo(player);
}

create_player_rig(player, animname, _id_486DB5FA512A3B6B) {
  if(!isDefined(player) || isDefined(player.player_rig)) {
    return;
  }
  player.animname = animname;

  if(!isDefined(_id_486DB5FA512A3B6B))
    _id_486DB5FA512A3B6B = "viewhands_base_iw8";

  player _meth_B88C89BB7CD1AB8E(player.origin);
  player_rig = spawn("script_arms", player.origin, 0, 0, player);
  player_rig.player = player;
  player.player_rig = player_rig;
  player.player_rig hide();
  player.player_rig.animname = animname;
  player.player_rig useanimtree(#animtree);
  player.player_rig.angles = scripts\engine\utility::ter_op(isDefined(player.angles), player.angles, (0, 0, 0));
  scripts\engine\utility::waittill_any_3("remove_rig", "death", "disconnect");
  remove_player_rig(player);
}

remove_player_rig(player) {
  if(!isDefined(player) || !isDefined(player.player_rig)) {
    return;
  }
  player unlink();
  player.player_rig delete();
  player.player_rig = undefined;
}

link_player_to_rig(player, _id_D180B535A33B044D) {
  player endon("death");
  player endon("disconnect");

  if(!isDefined(player) || !isDefined(player.player_rig)) {
    return;
  }
  if(!isDefined(_id_D180B535A33B044D))
    _id_D180B535A33B044D = 0.25;

  player playerlinktoblend(player.player_rig, "tag_player", _id_D180B535A33B044D, 0.1, 0.1);
  wait(_id_D180B535A33B044D);
  player playerlinktodelta(player.player_rig, "tag_player", 1, 0, 0, 0, 0, 1, 1, 1);
  player.player_rig showonlytoplayer(player);
}

do_hvt_drop_anim(player, _id_11E85672419D0F53) {
  if(!isDefined(_id_11E85672419D0F53))
    _id_11E85672419D0F53 = "medium";

  gunless = makeweapon("iw8_gunless");
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  success = player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 0);
  player scripts\engine\utility::waittill_any_timeout_1(1, "weapon_change");
  player resetcarryobject();
  player setstance("stand");
  player _id_3B64EB40368C1450::set("carry", "usability", 0);
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
  player scripts\common\anim::anim_first_frame_solo(player.vmvip, "drop_hvt_ground");
  player scripts\common\anim::anim_first_frame_solo(self.body, "drop_hvt_ground");

  if(isDefined(self.head) && isDefined(player.vmvip.head)) {
    player scripts\common\anim::anim_first_frame_solo(player.vmvip.head, "drop_hvt_ground");
    player scripts\common\anim::anim_first_frame_solo(self.head, "drop_hvt_ground");
  }

  dropanim = "drop_hvt_ground";
  player thread create_player_rig(player, "player_drop_hvt");
  player scripts\common\anim::anim_first_frame_solo(player.player_rig, dropanim);
  link_player_to_rig(player);
  player scripts\common\anim::anim_first_frame_solo(player.vmvip, "drop_hvt_ground");
  player scripts\common\anim::anim_first_frame_solo(self.body, "drop_hvt_ground");

  if(isDefined(self.head) && isDefined(player.vmvip.head)) {
    player scripts\common\anim::anim_first_frame_solo(player.vmvip.head, "drop_hvt_ground");
    player scripts\common\anim::anim_first_frame_solo(self.head, "drop_hvt_ground");
  }

  player thread scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, dropanim);
  player thread scripts\common\anim::anim_single_solo(self.body, dropanim);
  player thread scripts\common\anim::anim_single_solo(player.vmvip, dropanim);
  _id_A29A724BA7B5E149 = getanimlength(%sdr_cp_hostage_dropoff_ground_player);
  _id_27F60EE941918228 = getanimlength(%sdr_cp_hostage_dropoff_ground_pilot);
  wait(_id_A29A724BA7B5E149);
  player notify("remove_rig");
  player scripts\cp\cp_weapons::_takeweapon(gunless);
  groundpos = gettruegroundposition(player, self);
  player setOrigin(groundpos);
  player thread player_restoreweapons();
  wait(_id_27F60EE941918228 - _id_A29A724BA7B5E149);
  player.vmvip delete();
  self.body show();
  self.origin = self.body.origin;
  self.angles = self.body.angles;
  wait 0.25;
  self.body linkTo(self);
}

#using_animtree("mp_vehicles_always_loaded");

do_hvt_pickup_from_truck_anim(player) {
  init_anims();
  truck = self.vehicle;
  _id_4AD036DB23F15698 = self;
  player.puhostagerestoreweapon = player getcurrentweapon();
  gunless = makeweapon("iw8_gunless");
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  success = player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 0);
  player.gunlessweapon = gunless;
  player _id_3B64EB40368C1450::set("carry", "weapon_switch", 0);
  player _id_3B64EB40368C1450::set("carry", "weapon_pickup", 0);
  player freezecontrols(1);
  player setstance("stand");
  player scripts\engine\utility::waittill_any_timeout_1(1, "weapon_change");
  player thread create_player_rig(player, "player_vip_decho");
  truck scripts\common\anim::anim_first_frame_solo(player.player_rig, "truck_hvt_pickup");
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

  if(isDefined(player.vmvip.head))
    player.vmvip.head hide();

  player.vmvip showtoplayer(player);

  if(isDefined(player.vmvip.head))
    player.vmvip.head showtoplayer(player);

  _id_4AD036DB23F15698.body hidefromplayer(player);

  if(isDefined(_id_4AD036DB23F15698.head))
    _id_4AD036DB23F15698.head hidefromplayer(player);

  truck scripts\common\anim::anim_first_frame_solo(_id_4AD036DB23F15698.body, "truck_hvt_pickup");

  if(isDefined(_id_4AD036DB23F15698.head))
    truck scripts\common\anim::anim_first_frame_solo(_id_4AD036DB23F15698.head, "truck_hvt_pickup");

  truck scripts\common\anim::anim_first_frame_solo(player.vmvip, "truck_hvt_pickup");

  if(isDefined(player.vmvip.head))
    truck scripts\common\anim::anim_first_frame_solo(player.vmvip.head, "truck_hvt_pickup");

  truck thread scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, "truck_hvt_pickup");
  truck thread scripts\common\anim::anim_single_solo(player.vmvip, "truck_hvt_pickup");
  truck thread scripts\common\anim::anim_single_solo(_id_4AD036DB23F15698.body, "truck_hvt_pickup");
  truck vehicleplayanim(%vm_hostage_pickup_truck_decho);
  wait(getanimlength(%sdr_cp_hostage_pickup_truck_decho));
  _id_4AD036DB23F15698.body hide();

  if(isDefined(_id_4AD036DB23F15698.head))
    _id_4AD036DB23F15698.head hide();

  _id_4AD036DB23F15698 linkTo(player);
  player.vmvip delete();

  if(isDefined(player.vmvip.head))
    player.vmvip.head delete();

  player notify("remove_rig");
  player freezecontrols(0);
}

do_hvt_load_on_truck_anim(player) {
  init_anims();
  self.hostage_drop_override_data = player.hostage_drop_override_data;
  truck = player.hostage_drop_override_data.vehicle;
  _id_4AD036DB23F15698 = self;
  gunless = makeweapon("iw8_gunless");
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  success = player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 0);
  player scripts\engine\utility::waittill_any_timeout_1(1, "weapon_change");
  player setstance("stand");
  player allowcrouch(0);
  player unlink();
  player allowmovement(1);
  self unlink();
  self.body unlink();
  _id_4AD036DB23F15698.animname = "hvt";
  _id_4AD036DB23F15698 useanimtree(level.scr_animtree["hvt"]);
  player thread create_player_rig(player, "player_vip_decho");
  truck scripts\common\anim::anim_first_frame_solo(player.player_rig, "truck_hvt_dropoff");
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

  if(isDefined(player.vmvip.head))
    player.vmvip.head hide();

  player.vmvip showtoplayer(player);

  if(isDefined(player.vmvip.head))
    player.vmvip.head showtoplayer(player);

  _id_4AD036DB23F15698.body show();
  _id_4AD036DB23F15698.body hidefromplayer(player);
  truck scripts\common\anim::anim_first_frame_solo(_id_4AD036DB23F15698.body, "truck_hvt_dropoff");

  if(isDefined(_id_4AD036DB23F15698.head))
    truck scripts\common\anim::anim_first_frame_solo(_id_4AD036DB23F15698.head, "truck_hvt_dropoff");

  truck scripts\common\anim::anim_first_frame_solo(player.vmvip, "truck_hvt_dropoff");

  if(isDefined(player.vmvip.head))
    truck scripts\common\anim::anim_first_frame_solo(player.vmvip.head, "truck_hvt_dropoff");

  truck vehicleplayanim(%vm_hostage_dropoff_truck_decho);
  truck thread scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, "truck_hvt_dropoff", "tag_origin");
  truck thread scripts\common\anim::anim_single_solo(player.vmvip, "truck_hvt_dropoff", "tag_origin");
  truck thread scripts\common\anim::anim_single_solo(_id_4AD036DB23F15698.body, "truck_hvt_dropoff", "tag_origin");
  wait(getanimlength(level.scr_anim["player_vip_decho"]["truck_hvt_dropoff"]));

  if(isDefined(player.vmvip.head))
    player.vmvip.head delete();

  player.vmvip delete();
  _id_4AD036DB23F15698.body show();

  if(isDefined(_id_4AD036DB23F15698.head))
    _id_4AD036DB23F15698.head show();

  truck thread scripts\common\anim::anim_single_solo(_id_4AD036DB23F15698.body, "truck_hvt_idle", "tag_origin");
  player notify("remove_rig");
  player allowcrouch(1);
  player scripts\cp\cp_weapons::_takeweapon(gunless);
  self.origin = self.body.origin;
  self.angles = self.body.angles;
  self.body linkTo(self);
  self linkTo(truck);
}

load_hvt(player, heli, _id_A66BA9B157533F5A) {
  heli notify("handoff_hvt");
  player notify("loading_hvt_onto_heli");

  if(!isDefined(_id_A66BA9B157533F5A))
    _id_A66BA9B157533F5A = "left";

  animalias = "blima_drop_l";
  _id_13279A856648C13A = "sdr_cp_hostage_dropoff_blima_L_idle_outro_ally";
  _id_0B4DB4339A112636 = "sdr_cp_hostage_dropoff_blima_L_idle_outro_pilot";

  if(_id_A66BA9B157533F5A == "right") {
    animalias = "blima_drop_r";
    _id_13279A856648C13A = "sdr_cp_hostage_dropoff_blima_R_idle_outro_ally";
    _id_0B4DB4339A112636 = "sdr_cp_hostage_dropoff_blima_R_idle_outro_pilot";
  }

  wmexfilally = heli.wmexfilally;
  gunless = makeweapon("iw8_gunless");
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  success = player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 0);
  player scripts\engine\utility::waittill_any_timeout_1(1, "weapon_change");
  player setstance("stand");
  player allowcrouch(0);
  _id_0BA89A03FF462799 = player.hostagecarried;
  _id_0BA89A03FF462799.onchopper = 1;
  player unlink();
  player allowmovement(1);
  _id_0BA89A03FF462799 unlink();
  _id_0BA89A03FF462799.body unlink();
  _id_0BA89A03FF462799.body useanimtree(level.scr_animtree["hvt"]);
  _id_0BA89A03FF462799.body.animname = "hvt";
  player thread create_player_rig(player, "player_vip_blima");
  heli scripts\common\anim::anim_first_frame_solo(player.player_rig, animalias);
  link_player_to_rig(player, 0.4);
  player resetcarryobject();
  _id_0BA89A03FF462799.body show();
  _id_0BA89A03FF462799.body hidefromplayer(player);
  vmexfilally = spawn("script_model", heli.origin);
  vmexfilally setModel("allied_pilot_fullbody_3");
  vmexfilally useanimtree(level.scr_animtree["exfil_ally"]);
  vmexfilally.animname = "exfil_ally";
  vmhvt = spawn("script_model", heli.origin);
  vmhvt setModel(_id_0BA89A03FF462799.bodymodel);
  vmhvt useanimtree(level.scr_animtree["hvt_vm"]);
  vmhvt.animname = "hvt_vm";

  if(isDefined(_id_0BA89A03FF462799.head)) {
    vmhvt.head = spawn("script_model", heli.origin);
    vmhvt.head setModel(_id_0BA89A03FF462799.headmodel);
    vmhvt.head linkTo(vmhvt, "j_neck", (-9, 1, 0), (0, 0, 0));
    vmhvt.head.animname = "hvt_vm";
    vmhvt.head useanimtree(level.scr_animtree["hvt_vm"]);
    vmhvt.head showonlytoplayer(player);
  }

  vmhvt showonlytoplayer(player);
  vmexfilally showonlytoplayer(player);
  wmexfilally show();
  wmexfilally hidefromplayer(player);
  _id_0BA89A03FF462799.body show();
  _id_0BA89A03FF462799.body hidefromplayer(player);

  if(isDefined(_id_0BA89A03FF462799.head))
    _id_0BA89A03FF462799.head hidefromplayer(player);

  _id_FA1C3EBF57B2CB57 = getstartorigin(heli.origin, heli.angles, level.scr_anim["exfil_ally"][animalias]);
  _id_17F23F3C3C2C39B7 = getstartangles(heli.origin, heli.angles, level.scr_anim["exfil_ally"][animalias]);
  _id_2ACDA10E084F8BEE = getstartorigin(heli.origin, heli.angles, level.scr_anim["exfil_ally_vm"][animalias]);
  _id_4D1A68CF58ABBBC4 = getstartangles(heli.origin, heli.angles, level.scr_anim["exfil_ally_vm"][animalias]);
  _id_58C75ED97B180840 = getstartorigin(heli.origin, heli.angles, level.scr_anim["hvt_vm"][animalias]);
  _id_B13A37B4F6F912EE = getstartangles(heli.origin, heli.angles, level.scr_anim["hvt_vm"][animalias]);
  wmexfilally.origin = _id_FA1C3EBF57B2CB57;
  wmexfilally.angles = _id_17F23F3C3C2C39B7;
  vmexfilally.origin = _id_2ACDA10E084F8BEE;
  vmexfilally.angles = _id_4D1A68CF58ABBBC4;
  vmhvt.origin = _id_58C75ED97B180840;
  vmhvt.angles = _id_B13A37B4F6F912EE;
  _id_0BA89A03FF462799.origin = _id_58C75ED97B180840;
  _id_0BA89A03FF462799.angles = _id_B13A37B4F6F912EE;
  vmexfilally linkTo(heli);
  vmhvt linkTo(heli);
  _id_0BA89A03FF462799 linkTo(heli);
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
  heli thread scripts\common\anim::anim_single_solo(_id_0BA89A03FF462799.body, animalias, "tag_origin");
  _id_A29A724BA7B5E149 = getanimlength(level.scr_anim["player_vip_blima"][animalias]);
  _id_27F60EE941918228 = getanimlength(level.scr_anim["hvt"][animalias]);
  wait(_id_A29A724BA7B5E149);
  player setstance("stand");
  player notify("remove_rig");
  player scripts\cp\cp_weapons::_takeweapon(gunless);
  player allowcrouch(1);
  hostagedrop(player, player.hostagecarried, player.hostagecarried.origin, 0, 0.5, 1, 1, 1);
  wait(_id_27F60EE941918228 - _id_A29A724BA7B5E149);
  _id_0BA89A03FF462799.body linkTo(_id_0BA89A03FF462799);

  if(isDefined(_id_0BA89A03FF462799.head))
    _id_0BA89A03FF462799.head linkTo(_id_0BA89A03FF462799.body);

  _id_0BA89A03FF462799 linkTo(heli);

  if(isDefined(vmhvt.head))
    vmhvt.head delete();

  vmhvt delete();
  vmexfilally delete();
  _id_0BA89A03FF462799.body show();

  if(isDefined(_id_0BA89A03FF462799.head))
    _id_0BA89A03FF462799.head show();

  wmexfilally show();
  _id_0BA89A03FF462799.body scriptmodelplayanim(_id_0B4DB4339A112636);
  wmexfilally scriptmodelplayanim(_id_13279A856648C13A);
}

hostage_onuse(player, _id_C7F73E2E97E4E242, useobj) {
  level endon("game_ended");
  self endon("dropped");

  if(!isDefined(_id_C7F73E2E97E4E242))
    _id_C7F73E2E97E4E242 = "ground";

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

  switch (_id_C7F73E2E97E4E242) {
    case "heli":
      useobj[[level.hostage_onusefunc]](player, self);
      break;
    case "truck":
      do_hvt_pickup_from_truck_anim(player);
      break;
    case "ground":
      do_hvt_pickup_anim(player);
      break;
    case "moving_ai_truck":
      do_fast_hvt_pickup(player);
      break;
  }

  player setcarryobject(self.carryobjectasset);
  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("carry");

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

toggledrophintstring(_id_41D8BF229CF29051, player, hostage) {
  if(isDefined(hostage.overridehintstring))
    player scripts\cp\utility::hint_prompt(hostage.overridehintstring, _id_41D8BF229CF29051);
  else if(!isDefined(hostage.drophintstring))
    player scripts\cp\utility::hint_prompt("drop_pilot_hostage", _id_41D8BF229CF29051);
  else
    player scripts\cp\utility::hint_prompt(hostage.drophintstring, _id_41D8BF229CF29051);
}

watchfordrophintstring(player, hostage) {
  level endon("game_ended");
  player endon("death");
  player endon("hostage_dropped_by_me");
  player endon("loading_hvt_onto_heli");
  hostage endon("dropped");

  for(;;) {
    if(candrophostage(player))
      toggledrophintstring(1, player, hostage);
    else
      toggledrophintstring(0, player, hostage);

    waitframe();
  }
}

hostage_laststandlistener(player) {
  level endon("game_ended");
  self endon("dropped");
  player scripts\engine\utility::waittill_any_3("last_stand", "disconnect", "being_subdued");
  player disableusability();
  player resetcarryobject();
  toggledrophintstring(0, player, self);
  self.body show();

  if(isDefined(self.head))
    self.head show();

  player thread listen_for_revive();
  hostagedrop(player, self, player.origin);
}

listen_for_revive() {
  self endon("disconnect");
  self waittill("revive");

  while(isDefined(self.bspawningviaac130))
    self waittill("landed_after_respawn");

  if(isDefined(self.hostagetemppistol)) {
    scripts\cp\cp_weapons::_takeweapon(self.hostagetemppistol);
    self.hostagetemppistol = undefined;

    if(isDefined(self.weaponlist) && self.weaponlist.size > 0)
      scripts\cp\cp_weapons::switchtoweaponreliable(self.weaponlist[0]);
  }
}

hostage_watchdrop(player, hostage, useobj) {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  self endon("death");
  player endon("last_stand");
  player endon("loading_hvt_onto_heli");
  self.carried = 1;
  _id_4D8D53679DD13086 = 0;
  self.carrier = player;
  _id_038FC7BD1495C4B2 = 0.05;

  while(self.carried) {
    if(!player useButtonPressed())
      _id_4D8D53679DD13086 = 1;

    if(!istrue(candrophostage(player))) {
      waitframe();
      continue;
    }

    _id_23B90B34FECC58CD = 0;
    player setclientomnvar("zm_hint_progress", _id_23B90B34FECC58CD);
    player allowmovement(1);

    while(_id_4D8D53679DD13086 && player useButtonPressed()) {
      _id_23B90B34FECC58CD = _id_23B90B34FECC58CD + _id_038FC7BD1495C4B2;
      player allowmovement(0);

      if(_id_23B90B34FECC58CD > 0.3 && candrophostage(player)) {
        player.is_dropping_hostage = 1;

        if(isDefined(player.wmhostage)) {
          player.wmhostage unlink();

          if(isDefined(player.wmhostage.head))
            player.wmhostage.head delete();

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
        } else
          do_hvt_drop_anim(player, "medium");

        _id_5BF3E22BDB650432 = self.origin;
        hostagedrop(player, hostage, _id_5BF3E22BDB650432, undefined, 0.4, 0, 0, invehicle);
        player.ability_invulnerable = undefined;
        return;
      }

      player setclientomnvar("zm_hint_progress", _id_23B90B34FECC58CD / 0.3);
      wait(_id_038FC7BD1495C4B2);
    }

    waitframe();
  }
}

candrophostage(player) {
  if(player isonladder())
    return 0;

  if(isDefined(player.hostage_drop_override_data))
    return 1;

  if(isDefined(level.exfil_heli_landing) && distance2d(level.exfil_heli_landing.origin, player.origin) <= 512)
    return 0;

  _id_30EE65724920B3CA = player.origin + anglesToForward(player.angles) * 72.0 + (0, 0, 24);
  trace = scripts\engine\trace::ray_trace(player.origin + (0, 0, 24), _id_30EE65724920B3CA);

  if(trace["fraction"] >= 1) {
    _id_43035DD4CCA0A234 = scripts\engine\utility::drop_to_ground(_id_30EE65724920B3CA, 24);

    if(abs(_id_43035DD4CCA0A234[2] - _id_30EE65724920B3CA[2]) > 40) {
      return 0;
      return;
    }

    return 1;
    return;
  } else
    return 0;
}

get_hostage_drop_pos(player) {
  _id_30EE65724920B3CA = player.origin + anglesToForward(player.angles) * 72.0 + (0, 0, 24);
  trace = scripts\engine\trace::ray_trace(player.origin + (0, 0, 24), _id_30EE65724920B3CA);

  if(trace["fraction"] >= 1)
    _id_5BF3E22BDB650432 = getclosestpointonnavmesh(_id_30EE65724920B3CA, player);
  else
    _id_5BF3E22BDB650432 = player.origin;

  return _id_5BF3E22BDB650432;
}

getanglesfromsurfacenormal(position, hostage) {
  _id_22C4300CE1D248E8 = position + (0, 0, 30);
  _id_98C6610C2907BA2B = position;
  trace = scripts\engine\trace::ray_trace(_id_22C4300CE1D248E8, _id_98C6610C2907BA2B, [self.body, self]);
  _id_5E8EDE0EF6D7F3AB = trace["normal"];
  upangles = vectortoangles(_id_5E8EDE0EF6D7F3AB);

  if(!isDefined(_id_5E8EDE0EF6D7F3AB) || _id_5E8EDE0EF6D7F3AB == (0, 0, 0))
    return self.angles;

  _id_E76C0C29A4590AEB = generateaxisanglesfromupvector(_id_5E8EDE0EF6D7F3AB, self.angles);
  return _id_E76C0C29A4590AEB;
}

create_objective(_id_EC9CF00CBA0549B5, icon) {
  objective_id = scripts\cp\cp_objectives::requestworldid("pickup_hostage", 10);

  if(!isDefined(icon))
    icon = "icon_waypoint_marker";

  objective_setplayintro(objective_id, 0);
  objective_state(objective_id, "current");
  objective_icon(objective_id, icon);

  if(!isDefined(self.attach_entity))
    objective_position(objective_id, _id_EC9CF00CBA0549B5);
  else {
    objective_onentity(objective_id, self.attach_entity);
    objective_setzoffset(objective_id, 32);
  }

  objective_setbackground(objective_id, 2);
  _id_5977073FD144597B = "CP_BR_SYRK_OBJECTIVES/HVT";

  if(isDefined(self.label))
    _id_5977073FD144597B = self.label;

  objective_setlabel(objective_id, _id_5977073FD144597B);
  return objective_id;
}

set_hvt_label(label, compass) {
  if(!isDefined(self.waypoint)) {
    return;
  }
  objective_setlabel(self.waypoint, label);
  self.label = label;

  if(isDefined(compass))
    objective_setshowoncompass(self.waypoint, 1);
}

listen_for_super_triggered() {
  self endon("last_stand");
  self endon("dropped_hostage");
  self endon("disconnect");

  for(;;) {
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

player_removecarrydebuff() {
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("carry");
  scripts\cp\utility::allow_secondary_offhand_weapons(1);
  scripts\cp\utility::allow_player_basejumping(1, "carry_debuff");
  self enableoffhandweapons();
  self allowmountside(1);
  self allowmounttop(1);
  self allowjog(1);
  scripts\cp\cp_kidnapper::setimmunetokidnapper(0);

  if(isDefined(self.suit)) {
    self setsuit(self.suit);
    _id_0CBB0697DE4C5728::_id_7C62C6C14ABA289B();
  } else {
    self setsuit("iw9_suit_cp");
    _id_0CBB0697DE4C5728::_id_7C62C6C14ABA289B();
  }

  self disableemptyclipweaponswitch(0);
  self notify("stop_hostagecarrier_watching_for_doors");
  scripts\cp\utility::_unsetperk("specialty_sprintfire");
  self.overrideweaponspeed_speedscale = undefined;
  self[[level.move_speed_scale]]();
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("carry");
}

player_carrydebuff() {
  _id_3B64EB40368C1450::set("carry", "mantle", 0);

  if(!istrue(self.disable_hvt_nomantle))
    _id_3B64EB40368C1450::set("carry", "allow_jump", 0);

  _id_3B64EB40368C1450::set("carry", "prone", 0);
  _id_3B64EB40368C1450::set("carry", "crouch", 0);
  _id_3B64EB40368C1450::set("carry", "sprint", 0);
  _id_3B64EB40368C1450::set("carry", "melee", 0);
  scripts\cp\utility::allow_player_basejumping(0, "carry_debuff");
  self disableoffhandweapons();
  self allowmountside(0);
  self allowmounttop(0);
  scripts\cp\utility::allow_secondary_offhand_weapons(0);
  self allowjog(0);
  scripts\cp\utility::giveperk("specialty_sprintfire");
  self.overrideweaponspeed_speedscale = 0.75;
  self[[level.move_speed_scale]]();
  scripts\cp\cp_kidnapper::setimmunetokidnapper(1);

  if(isDefined(self.puhostagerestoreweapon)) {
    if(isallowedweapon(self.puhostagerestoreweapon))
      success = scripts\cp\cp_weapons::switchtoweaponreliable(self.puhostagerestoreweapon, 0);
    else {
      self.hostagetemppistol = _id_2669878CF5A1B6BC::buildweapon("iw8_pi_mike1911", [], "none", "none", -1);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self.hostagetemppistol, undefined, undefined, 1);
      success = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.hostagetemppistol, 0);

      if((self.puhostagerestoreweapon.basename == "iw8_green_beam_mp" || self.puhostagerestoreweapon.basename == "iw8_spotter_scope_mp") && isDefined(self.primaryweaponobj))
        self.puhostagerestoreweapon = self.primaryweaponobj;
    }
  }

  thread scripts\cp\utility::watch_and_open_scriptable_doors_in_radius();
  _id_3B64EB40368C1450::set("carry", "weapon_switch", 0);
  _id_3B64EB40368C1450::set("carry", "weapon_switch_clip", 0);
  _id_3B64EB40368C1450::set("carry", "weapon_pickup", 0);
  _id_3B64EB40368C1450::set("carry", "usability", 0);
  self.disable_map_tablet = 1;
}

watchforscriptabledoorsinradius() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("dropped_hostage");
  self endon("stop_hostagecarrier_watching_for_doors");
  player = self;
  radius = 64;
  _id_284908EDB3C3318D = 1.5;
  _id_36F2D54BCBAAE65A = ["scriptable_door_wooden_panel_mp_01", "scriptable_door_wooden_hollow_mp_01"];

  for(;;) {
    _id_9BC823CAB1BB2862 = [];
    _id_913576E1DC1762B5 = getentitylessscriptablearray(undefined, undefined, player.origin, radius);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_913576E1DC1762B5.size; _id_AC0E594AC96AA3A8++) {
      if(_id_913576E1DC1762B5[_id_AC0E594AC96AA3A8] scriptableisdoor())
        _id_9BC823CAB1BB2862[_id_9BC823CAB1BB2862.size] = _id_913576E1DC1762B5[_id_AC0E594AC96AA3A8];
    }

    for(x = 0; x < _id_9BC823CAB1BB2862.size; x++)
      _id_9BC823CAB1BB2862[x] setscriptablepartstate("door", "left_30", 0);

    wait(_id_284908EDB3C3318D);
  }
}

player_refillammo() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("dropped_hostage");

  for(;;) {
    self waittill("reload");
    self givestartammo(self.currentprimaryweapon);
  }
}

player_refillsinglecountammo() {
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

gettruegroundposition(player, _id_0BA89A03FF462799) {
  if(!isDefined(player)) {
    return;
  }
  _id_31C17768C4ABA01C = player.origin[2];
  contents = scripts\engine\trace::create_solid_ai_contents(1);
  startpos = player.origin + (0, 0, 12);
  endpos = player.origin - (0, 0, 24);
  _id_2FC7B90001702E5C = [player, player.player_rig, _id_0BA89A03FF462799.body];

  if(isDefined(_id_0BA89A03FF462799.head))
    _id_2FC7B90001702E5C[_id_2FC7B90001702E5C.size] = _id_0BA89A03FF462799.head;

  groundpos = player scripts\engine\trace::player_trace(startpos, endpos, player.angles, _id_2FC7B90001702E5C, contents)["shape_position"];
  return groundpos;
}

isallowedweapon(weapon) {
  if(!isDefined(weapon) || !isDefined(weapon.classname) || !isDefined(weapon.basename))
    return 0;

  if(istrue(self isalternatemode(weapon)))
    return 0;

  if(istrue(weapon.isalternate) && weapon.classname == "grenade")
    return 0;

  if(getsubstr(weapon.basename, 0, 7) == "iw8_pi_" || getsubstr(weapon.basename, 0, 7) == "iw8_sm_" || getsubstr(weapon.basename, 0, 7) == "iw8_ar_" || weapon.basename == "iw_lm_lima86_mp" || weapon.basename == "iw8_sh_charlie725_mp" || weapon.basename == "iw8_sh_oscar12_mp") {
    if(getsubstr(weapon.basename, 0, 7) == "iw8_pi_" && weapon hasattachment("stock"))
      return 0;

    return 1;
  }

  return 0;
}

pickup_sound_playervm_handler(guy) {
  guy playsoundonmovingent("sdr_cop_hostage_pickup_ground_plr");
}

pickup_sound_playerwm_handler(guy) {
  guy playsoundonmovingent("sdr_cop_hostage_pickup_ground_plr_npc ");
}

dropoff_sound_playervm_handler(guy) {
  guy playsoundonmovingent("sdr_cp_hostage_dropoff_ground_plr");
}

dropoff_sound_playerwm_handler(guy) {
  guy playsoundonmovingent("sdr_cp_hostage_dropoff_ground_plr_npc");
}

pickup_sound_hvt_handler(guy) {
  guy playsoundonmovingent("sdr_cop_hostage_pickup_ground_pilot");
}

dropoff_sound_hvt_handler(guy) {
  guy playsoundonmovingent("sdr_cp_hostage_dropoff_ground_pilot");
}

#using_animtree("script_model");

init_anims() {
  level.scr_animtree["player_pickup_hvt"] = #animtree;
  level.scr_anim["player_pickup_hvt"]["pickup_hvt_ground"] = % vm_carry_ally_in_player;
  level.scr_animname["player_pickup_hvt"]["pickup_hvt_ground"] = "vm_carry_ally_in_player";
  level.scr_eventanim["player_pickup_hvt"]["pickup_hvt_ground"] = "vip_pickup_ground";
  scripts\common\anim::addnotetrack_customfunction("player_pickup_hvt", "sdr_cop_hostage_pickup_ground_plr", ::pickup_sound_playervm_handler);
  scripts\common\anim::addnotetrack_customfunction("player_pickup_hvt", "sdr_cop_hostage_pickup_ground_plr_npc", ::pickup_sound_playerwm_handler);
  level.scr_animtree["player_drop_hvt"] = #animtree;
  level.scr_anim["player_drop_hvt"]["drop_hvt_ground"] = % vm_carry_ally_out_player;
  level.scr_animname["player_drop_hvt"]["drop_hvt_ground"] = "vm_carry_ally_out_player";
  level.scr_eventanim["player_drop_hvt"]["drop_hvt_ground"] = "vip_dropoff_ground";
  scripts\common\anim::addnotetrack_customfunction("player_drop_hvt", "sdr_cp_hostage_dropoff_ground_plr", ::dropoff_sound_playervm_handler);
  scripts\common\anim::addnotetrack_customfunction("player_drop_hvt", "sdr_cp_hostage_dropoff_ground_plr_npc", ::dropoff_sound_playerwm_handler);
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