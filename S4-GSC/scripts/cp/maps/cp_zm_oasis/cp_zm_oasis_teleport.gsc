/****************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_teleport.gsc
****************************************************************/

init() {
  level._effect["teleport_portal_red"] = loadfx("vfx/s4/zombie/vfx_hub_portal_variant");
  level thread init_portals();
}

init_portals() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("interactions_initialized");
  _id_0737::_id_C266("player_teleport_portal_interact", ::get_teleport_portal_hint, ::activate_teleport_portal, ::init_teleport_portals);
  level._id_8393["player_teleport_portal_interact"]._id_E3FF = "teleport_portal";
  level._id_8393["player_teleport_portal_interact"]._id_3D91 = 500;
  level._id_8393["player_teleport_portal_interact"].hint_type_func = ::get_teleport_portal_hint_type;
  level._id_8393["player_teleport_portal_interact"].hintstring_show_cost = 1;
  level._id_8393["player_teleport_portal_interact"]._id_3108 = ::can_use_teleport_portal;
}

init_teleport_portals(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.mdl)) {
      continue;
    }
    var_2.mdl = getent(var_2.target, "targetname");

    if(!isDefined(var_2.mdl)) {
      continue;
    }
    if(isDefined(var_2._id_0359)) {
      var_2._id_425E = var_2._id_0359;
    } else {
      var_2._id_425E = 120;
    }

    var_2._id_605B = scripts\cp\utility::_id_E190("tag_origin", var_2.mdl.origin, var_2.mdl.angles);
    var_3 = scripts\engine\utility::getstruct(var_2.mdl.target, "targetname");

    if(!isDefined(var_3)) {
      return;
    }
    var_2.a_teleport_destination = scripts\engine\utility::getStructArray(var_3.target, "targetname");
    var_2.in_cooldown = 0;
    playFXOnTag(level._effect["teleport_portal_red"], var_2._id_605B, "tag_origin");
    var_2._id_605B playLoopSound("zmb_player_portal_lp");
  }
}

get_teleport_portal_hint_type(var_0, var_1) {
  if(istrue(var_0.in_cooldown) || istrue(level.disable_portal)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

get_teleport_portal_hint(var_0, var_1) {
  if(istrue(var_0.is_teleporting)) {
    return "";
  }

  if(istrue(level.disable_portal)) {
    return &"CP_ZM_OASIS/PORTAL_UNAVAILABLE";
  }

  if(istrue(var_0.in_cooldown)) {
    return &"CP_ZM_OASIS/PORTAL_IS_COOLING_DOWN";
  }

  if(isDefined(level._id_8393["player_teleport_portal_interact"]._id_3D91) && !var_1 _id_074E::_id_B4C5(level._id_8393["player_teleport_portal_interact"]._id_3D91)) {
    return &"CP_ZM_OASIS/ENTER_THE_PORTAL_LACK_MONEY";
  } else {
    return &"CP_ZM_OASIS/ENTER_THE_PORTAL";
  }

  return &"CP_ZM_OASIS/ENTER_THE_PORTAL";
}

activate_teleport_portal(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("death");

  if(istrue(var_0.in_cooldown) || istrue(var_0.is_teleporting) || istrue(level.disable_portal)) {
    return;
  }
  var_0.in_cooldown = 1;
  var_0.is_teleporting = 1;
  var_1.is_in_teleport = 1;
  var_0 thread teleport_portal_cooldown_watcher();
  var_1._id_0E05 = 1;
  var_2 = scripts\engine\utility::array_randomize(var_0.a_teleport_destination);
  _id_098A::warp_sepcific_player(var_2, var_1);
  var_0.is_teleporting = 0;
  var_1.is_in_teleport = 0;
  var_1._id_0E05 = undefined;
}

can_use_teleport_portal(var_0, var_1) {
  if(istrue(var_0.in_cooldown) || istrue(var_0.is_teleporting) || istrue(level.disable_portal)) {
    return 0;
  }

  return 1;
}

teleport_portal_cooldown_watcher() {
  level endon("game_ended");
  self endon("death");
  wait 30;
  self.in_cooldown = 0;
}