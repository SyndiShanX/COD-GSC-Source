/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\coop.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#namespace coop;

function autoexec init() {
  registerclientfield("playercorpse", "hide_body", 1, 1, "int", & function_d630ecfc, 0);
  registerclientfield("toplayer", "killcam_menu", 1, 1, "int", & function_9f1677e1, 0);
}

function main() {}

function onprecachegametype() {}

function onstartgametype() {}

function function_9f1677e1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(getinkillcam(localclientnum)) {
    return;
  }
  if(!isdefined(self.killcam_menu)) {
    self.killcam_menu = createluimenu(localclientnum, "CPKillcam");
  }
  if(newval) {
    openluimenu(localclientnum, self.killcam_menu);
  } else {
    closeluimenu(localclientnum, self.killcam_menu);
  }
}

function function_d630ecfc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval && !getinkillcam(localclientnum)) {
    self hide();
  } else {
    self show();
  }
}