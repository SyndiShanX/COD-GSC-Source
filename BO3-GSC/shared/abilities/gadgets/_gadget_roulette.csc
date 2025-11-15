/*********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_roulette.csc
*********************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace gadget_roulette;

function autoexec __init__sytem__() {
  system::register("gadget_roulette", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "roulette_state", 11000, 2, "int", & roulette_clientfield_cb, 0, 0);
  callback::on_localplayer_spawned( & on_localplayer_spawned);
}

function roulette_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  update_roulette(localclientnum, newval);
}

function update_roulette(localclientnum, newval) {
  controllermodel = getuimodelforcontroller(localclientnum);
  if(isDefined(controllermodel)) {
    roulettestatusmodel = getuimodel(controllermodel, "playerAbilities.playerGadget3.rouletteStatus");
    if(isDefined(roulettestatusmodel)) {
      setuimodelvalue(roulettestatusmodel, newval);
    }
  }
}

function on_localplayer_spawned(localclientnum) {
  roulette_state = 0;
  if(getserverhighestclientfieldversion() >= 11000) {
    roulette_state = self clientfield::get_to_player("roulette_state");
  }
  update_roulette(localclientnum, roulette_state);
}