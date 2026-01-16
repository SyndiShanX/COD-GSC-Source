/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_stalingrad_pap_quest.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\beam_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_utility;
#using scripts\zm\craftables\_zm_craftables;
#namespace zm_stalingrad_pap;

function autoexec __init__sytem__() {
  system::register("zm_stalingrad_pap", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("world", "lockdown_lights_west", 12000, 1, "int", & lockdown_lights_west, 0, 0);
  clientfield::register("world", "lockdown_lights_north", 12000, 1, "int", & lockdown_lights_north, 0, 0);
  clientfield::register("world", "lockdown_lights_east", 12000, 1, "int", & lockdown_lights_east, 0, 0);
}

function lockdown_lights_west(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isdefined(level.var_ff3f0000)) {
    level.var_ff3f0000 = struct::get_array("lockdown_lights_west");
  }
  level thread function_4ec66a83(localclientnum, newval, level.var_ff3f0000);
}

function lockdown_lights_north(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isdefined(level.var_80d95152)) {
    level.var_80d95152 = struct::get_array("lockdown_lights_north");
  }
  level thread function_4ec66a83(localclientnum, newval, level.var_80d95152);
}

function lockdown_lights_east(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isdefined(level.var_4f41d366)) {
    level.var_4f41d366 = struct::get_array("lockdown_lights_east");
  }
  level thread function_4ec66a83(localclientnum, newval, level.var_4f41d366);
}

function function_4ec66a83(localclientnum, newval, a_s_lights) {
  if(newval) {
    foreach(s_light in a_s_lights) {
      s_light.fx_light = playfx(localclientnum, level._effect["pavlov_lockdown_light"], s_light.origin);
    }
  } else {
    foreach(s_light in a_s_lights) {
      if(isdefined(s_light.fx_light)) {
        stopfx(localclientnum, s_light.fx_light);
        s_light.fx_light = undefined;
      }
    }
  }
}

function drop_pod_streaming(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    forcestreamxmodel("p7_fxanim_zm_stal_pack_a_punch_base_mod");
    forcestreamxmodel("p7_fxanim_zm_stal_pack_a_punch_pod_mod");
    forcestreamxmodel("p7_fxanim_zm_stal_pack_a_punch_umbrella_mod");
  } else {
    stopforcestreamingxmodel("p7_fxanim_zm_stal_pack_a_punch_base_mod");
    stopforcestreamingxmodel("p7_fxanim_zm_stal_pack_a_punch_pod_mod");
    stopforcestreamingxmodel("p7_fxanim_zm_stal_pack_a_punch_umbrella_mod");
  }
}

function function_5858bdaf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level.var_f6abb894[localclientnum] = self;
  self thread function_ca87037d(localclientnum);
}

function function_ca87037d(localclientnum) {
  self endon("entity_shutdown");
  while (isdefined(self)) {
    self playrumbleonentity(localclientnum, "zm_stalingrad_drop_pod_ambient");
    wait(1.1);
  }
}

function function_c86c0cdd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  e_pod = level.var_f6abb894[localclientnum];
  mdl_target = util::spawn_model(localclientnum, "tag_origin", e_pod gettagorigin("tag_fx"));
  var_e43465f2 = util::spawn_model(localclientnum, "tag_origin", self gettagorigin("j_spine4"), self gettagangles("j_spine4"));
  var_e43465f2 thread function_1d3ab9dd(mdl_target);
}

function function_1d3ab9dd(mdl_target) {
  level beam::launch(self, "tag_origin", mdl_target, "tag_origin", "electric_arc_zombie_to_drop_pod");
  mdl_target playsound(0, "zmb_pod_electrocute");
  wait(0.2);
  self playsound(0, "zmb_pod_electrocute_zmb");
  level beam::kill(self, "tag_origin", mdl_target, "tag_origin", "electric_arc_zombie_to_drop_pod");
  mdl_target delete();
  self delete();
}

function function_5e369bd2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_165d49f6 = level.var_f6abb894[localclientnum];
  switch (newval) {
    case 1: {
      var_165d49f6.var_888bfca3 = playfxontag(localclientnum, level._effect["drop_pod_hp_light_green"], var_165d49f6, "tag_health_green");
      break;
    }
    case 2: {
      if(isdefined(var_165d49f6.var_888bfca3)) {
        stopfx(localclientnum, var_165d49f6.var_888bfca3);
      }
      var_165d49f6.var_888bfca3 = playfxontag(localclientnum, level._effect["drop_pod_hp_light_yellow"], var_165d49f6, "tag_health_yellow");
      break;
    }
    case 3: {
      if(isdefined(var_165d49f6.var_888bfca3)) {
        stopfx(localclientnum, var_165d49f6.var_888bfca3);
      }
      var_165d49f6.var_888bfca3 = playfxontag(localclientnum, level._effect["drop_pod_hp_light_red"], var_165d49f6, "tag_health_red");
      break;
    }
    default: {
      break;
    }
  }
}