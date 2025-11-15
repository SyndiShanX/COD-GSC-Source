/******************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_thief.csc
******************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace gadget_thief;

function autoexec __init__sytem__() {
  system::register("gadget_thief", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "gadget_thief_fx", 11000, 1, "int", & thief_clientfield_cb, 0, 0);
  clientfield::register("toplayer", "thief_state", 11000, 2, "int", & thief_ui_model_clientfield_cb, 0, 0);
  clientfield::register("toplayer", "thief_weapon_option", 11000, 4, "int", & thief_weapon_option_ui_model_clientfield_cb, 0, 0);
  clientfield::register("clientuimodel", "playerAbilities.playerGadget3.flashStart", 11000, 3, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "playerAbilities.playerGadget3.flashEnd", 11000, 3, "int", undefined, 0, 0);
  level._effect["fx_hero_blackjack_beam_source"] = "weapon/fx_hero_blackjack_beam_source";
  level._effect["fx_hero_blackjack_beam_target"] = "weapon/fx_hero_blackjack_beam_target";
  callback::on_localplayer_spawned( & on_localplayer_spawned);
}

function thief_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  playfxoncamera(localclientnum, level._effect["fx_hero_blackjack_beam_target"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
  playFX(localclientnum, level._effect["fx_hero_blackjack_beam_source"], self.origin);
}

function thief_ui_model_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  update_thief(localclientnum, newval);
}

function thief_weapon_option_ui_model_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  update_thief_weapon(localclientnum, newval);
}

function update_thief(localclientnum, newval) {
  controllermodel = getuimodelforcontroller(localclientnum);
  if(isDefined(controllermodel)) {
    thiefstatusmodel = getuimodel(controllermodel, "playerAbilities.playerGadget3.thiefStatus");
    if(isDefined(thiefstatusmodel)) {
      setuimodelvalue(thiefstatusmodel, newval);
    }
  }
}

function update_thief_weapon(localclientnum, newval) {
  controllermodel = getuimodelforcontroller(localclientnum);
  if(isDefined(controllermodel)) {
    thiefstatusmodel = getuimodel(controllermodel, "playerAbilities.playerGadget3.thiefWeaponStatus");
    if(isDefined(thiefstatusmodel)) {
      setuimodelvalue(thiefstatusmodel, newval);
    }
  }
}

function on_localplayer_spawned(localclientnum) {
  thief_state = 0;
  thief_weapon_option = 0;
  if(getserverhighestclientfieldversion() >= 11000) {
    thief_state = self clientfield::get_to_player("thief_state");
    thief_weapon_option = self clientfield::get_to_player("thief_weapon_option");
  }
  update_thief(localclientnum, thief_state);
  update_thief_weapon(localclientnum, thief_weapon_option);
}