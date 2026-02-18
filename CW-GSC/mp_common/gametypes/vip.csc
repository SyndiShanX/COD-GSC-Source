/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\vip.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\laststand;
#namespace vip;

function event_handler[gametype_init] main(eventstruct) {
  clientfield::function_5b7d846d("hudItems.war.attackingTeam", #"war_data", #"attackingteam", 1, 2, "int", undefined, 0, 1);
  clientfield::register("allplayers", "vip_keyline", 1, 1, "int", &vip_keyline, 0, 1);
  clientfield::register("toplayer", "vip_ascend_postfx", 1, 1, "int", &vip_ascend_postfx, 0, 0);
  callback::on_localclient_connect(&on_localclient_connect);
}

function on_localclient_connect(localclientnum) {
  setuimodelvalue(createuimodel(function_5f72e972(#"hash_410fe12a68d6e801"), "vipClientNum"), -1);
}

function vip_keyline(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death", #"disconnect");
  self util::waittill_dobj(fieldname);
  var_5f682f83 = function_9b3f0ed1(fieldname);
  localplayer = function_5c10bd79(fieldname);

  if(bwastimejump) {
    var_c4c5aa27 = getuimodel(function_5f72e972(#"hash_410fe12a68d6e801"), "vipClientNum");
    setuimodelvalue(var_c4c5aa27, self getentitynumber());

    if(self.team == var_5f682f83 && self != localplayer && !self function_d2503806(#"hash_aa2ba3bf66e25d2")) {
      self playrenderoverridebundle(#"hash_aa2ba3bf66e25d2");
    }

    return;
  }

  if(self function_d2503806(#"hash_aa2ba3bf66e25d2")) {
    self stoprenderoverridebundle(#"hash_aa2ba3bf66e25d2");
  }
}

function vip_ascend_postfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death", #"disconnect");

  if(bwastimejump) {
    self postfx::playpostfxbundle(#"hash_19450de64ead5f8e");
    return;
  }

  self postfx::stoppostfxbundle(#"hash_19450de64ead5f8e");
}