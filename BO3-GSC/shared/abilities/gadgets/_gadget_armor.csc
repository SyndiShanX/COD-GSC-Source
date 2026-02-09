/******************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_armor.csc
******************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_power;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace _gadget_armor;

function autoexec __init__sytem__() {
  system::register("gadget_armor", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_localplayer_spawned(&on_local_player_spawned);
  clientfield::register("allplayers", "armor_status", 1, 5, "int", &player_armor_changed, 0, 0);
  clientfield::register("toplayer", "player_damage_type", 1, 1, "int", &player_damage_type_changed, 0, 0);
  duplicate_render::set_dr_filter_framebuffer_duplicate("armor_pl", 40, "armor_on", undefined, 1, "mc/mtl_power_armor", 0);
  level thread armor_overlay_think();
}

function on_local_player_spawned(localclientnum) {
  if(self != getlocalplayer(localclientnum)) {
    return;
  }
  newval = self clientfield::get("armor_status");
  self player_armor_changed_event(localclientnum, newval);
}

function player_damage_type_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self armor_update_fx_event(localclientnum, newval);
}

function player_armor_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self player_armor_changed_event(localclientnum, newval);
}

function player_armor_changed_event(localclientnum, newval) {
  self armor_update_fx_event(localclientnum, newval);
  self armor_update_shader_event(localclientnum, newval);
}

function armor_update_shader_event(localclientnum, armorstatusnew) {
  if(armorstatusnew) {
    self duplicate_render::update_dr_flag(localclientnum, "armor_on", 1);
    shieldexpansionncolor = "scriptVector3";
    shieldexpansionvaluex = 0.3;
    colorvector = armor_get_shader_color(armorstatusnew);
    if(getdvarint("scr_armor_dev")) {
      shieldexpansionvaluex = getdvarfloat("scr_armor_expand", shieldexpansionvaluex);
      colorvector = (getdvarfloat("scr_armor_colorR", colorvector[0]), getdvarfloat("scr_armor_colorG", colorvector[1]), getdvarfloat("scr_armor_colorB", colorvector[2]));
    }
    colortintvaluey = colorvector[0];
    colortintvaluez = colorvector[1];
    colortintvaluew = colorvector[2];
    damagestate = "scriptVector4";
    damagestatevalue = armorstatusnew / 5;
    self mapshaderconstant(localclientnum, 0, shieldexpansionncolor, shieldexpansionvaluex, colortintvaluey, colortintvaluez, colortintvaluew);
    self mapshaderconstant(localclientnum, 0, damagestate, damagestatevalue);
  } else {
    self duplicate_render::update_dr_flag(localclientnum, "armor_on", 0);
  }
}

function armor_get_shader_color(armorstatusnew) {
  color = (0.3, 0.3, 0.2);
  return color;
}

function armor_update_fx_event(localclientnum, doarmorfx) {
  if(!self armor_is_local_player(localclientnum)) {
    return;
  }
  if(doarmorfx) {
    self setdamagedirectionindicator(1);
    setsoundcontext("plr_impact", "pwr_armor");
  } else {
    self setdamagedirectionindicator(0);
    setsoundcontext("plr_impact", "");
  }
}

function armor_overlay_transition_fx(localclientnum, armorstatusnew) {
  self endon("disconnect");
  if(!isDefined(self._gadget_armor_state)) {
    self._gadget_armor_state = 0;
  }
  if(armorstatusnew == self._gadget_armor_state) {
    return;
  }
  self._gadget_armor_state = armorstatusnew;
  if(armorstatusnew == 5) {
    return;
  }
  if(isDefined(self._armor_doing_transition) && self._armor_doing_transition) {
    return;
  }
  self._armor_doing_transition = 1;
  transition = 0;
  flicker_start_time = getrealtime();
  saved_vision = getvisionsetnaked(localclientnum);
  visionsetnaked(localclientnum, "taser_mine_shock", transition);
  self playSound(0, "wpn_taser_mine_tacmask");
  wait(0.3);
  visionsetnaked(localclientnum, saved_vision, transition);
  self._armor_doing_transition = 0;
}

function armor_is_local_player(localclientnum) {
  player_view = getlocalplayer(localclientnum);
  sameentity = self == player_view;
  return sameentity;
}

function armor_overlay_think() {
  armorstatus = 0;
  setDvar("", 0);
  while(true) {
    wait(0.1);
    armorstatusnew = getdvarint("");
    if(armorstatusnew != armorstatus) {
      players = getlocalplayers();
      foreach(i, localplayer in players) {
        if(!isDefined(localplayer)) {
          continue;
        }
        localplayer player_armor_changed_event(i, armorstatusnew);
      }
      armorstatus = armorstatusnew;
    }
  }
}