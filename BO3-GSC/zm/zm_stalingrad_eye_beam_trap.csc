/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_stalingrad_eye_beam_trap.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace zm_stalingrad_eye_beam_trap;

function autoexec __init__sytem__() {
  system::register("zm_stalingrad_eye_beam_trap", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "eye_beam_trap_postfx", 12000, 1, "int", &function_822dbe7f, 0, 0);
  clientfield::register("world", "eye_beam_rumble_factory", 12000, 1, "int", &function_3d1860f, 0, 0);
  clientfield::register("world", "eye_beam_rumble_library", 12000, 1, "int", &function_ea1e41d4, 0, 0);
}

function function_822dbe7f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self thread postfx::playpostfxbundle("pstfx_eye_beam_dmg");
  } else {
    self thread postfx::stoppostfxbundle();
  }
}

function function_3d1860f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  e_player = getlocalplayer(localclientnum);
  if(newval) {
    e_player.var_ce79a8bf = function_3975127(localclientnum, "factory");
  } else if(isDefined(e_player.var_ce79a8bf)) {
    e_player.var_ce79a8bf stoprumble(localclientnum, "zm_stalingrad_eye_beam_rumble");
    e_player.var_ce79a8bf delete();
  }
}

function function_ea1e41d4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  e_player = getlocalplayer(localclientnum);
  if(newval) {
    e_player.var_5082384e = function_3975127(localclientnum, "library");
  } else if(isDefined(e_player.var_5082384e)) {
    e_player.var_5082384e stoprumble(localclientnum, "zm_stalingrad_eye_beam_rumble");
    e_player.var_5082384e delete();
  }
}

function function_3975127(localclientnum, str_location) {
  var_459eee06 = struct::get("eye_beam_rumble_" + str_location, "targetname");
  var_7cbc8176 = util::spawn_model(localclientnum, "tag_origin", var_459eee06.origin);
  var_7cbc8176 playrumbleonentity(localclientnum, "zm_stalingrad_eye_beam_rumble");
  return var_7cbc8176;
}