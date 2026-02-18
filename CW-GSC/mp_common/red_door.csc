/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\red_door.csc
***********************************************/

#using script_13da4e6b98ca81a1;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace red_door;

function private autoexec __init__system__() {
  system::register(#"red_door", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_clientfields();
  init_fx();
}

function init_clientfields() {
  clientfield::register("allplayers", "" + # "hash_57c792bbf6365c17", 1, 1, "counter", &function_e10bfb69, 0, 0);
  clientfield::register("allplayers", "" + # "hash_520c94f4af55e3b8", 1, 1, "counter", &function_afb3813c, 0, 0);
  clientfield::register("allplayers", "" + # "hash_60d81b0a1fcd2454", 1, 1, "counter", &function_76090e23, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_7948e032082fdac", 1, 2, "int", &function_1d5c7052, 0, 0);
  clientfield::register("toplayer", "" + # "hash_3c5be6b25c626e06", 1, 3, "int", &function_d17296b4, 0, 0);
  clientfield::register("toplayer", "" + # "hash_60df070a1fd32106", 1, 1, "int", &function_4198ac3f, 0, 0);
}

function init_fx() {}

function function_d17296b4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump > 0) {
    if(bwastimejump > 4) {
      bwastimejump = 4;
    }

    str_name = "s_teleport_room_" + bwastimejump;
    s_teleport_room = struct::get(str_name, "targetname");
    self camerasetposition(s_teleport_room.origin);
    self camerasetlookat(s_teleport_room.angles);
    self cameraactivate(1);
    self flag::set(#"hash_7151daf10b79dc1");
    self.var_535fa083 = self playSound(fieldname, #"hash_38dea1bc296d1a50");
    return;
  }

  self cameraactivate(0);
  self flag::clear(#"hash_7151daf10b79dc1");

  if(isDefined(self.var_535fa083)) {
    stopsound(self.var_535fa083);
  }
}

function function_1d5c7052(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death", #"disconnect");
  str_fx = "zombie/fx9_aether_tear_portal_tunnel_1p";

  if(isDefined(str_fx)) {
    self util::waittill_dobj(bwastimejump);
    waitframe(1);
    level.portal_fx = util::playFXOnTag(bwastimejump, str_fx, self, "tag_fx_wormhole");
  }
}

function function_4198ac3f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(codcaster::function_b8fe9b52(binitialsnap)) {
    return;
  }

  if(bwastimejump != fieldname) {
    if(bwastimejump) {
      self endon(#"death", #"disconnect");
      waitframe(1);
      self util::waittill_dobj(binitialsnap);

      if(!isalive(self)) {
        return;
      }

      if(!function_1cbf351b(binitialsnap)) {
        playtagfxset(binitialsnap, #"hash_c8d1cd982807459", self);
      }
    }
  }
}

function function_76090e23(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump != fieldname) {
    if(bwastimejump) {
      self endon(#"death", #"disconnect");
      waitframe(1);
      self util::waittill_dobj(binitialsnap);

      if(!isalive(self)) {
        return;
      }

      if(!function_1cbf351b(binitialsnap)) {
        util::playFXOnTag(binitialsnap, #"hash_35accd8f03ca67be", self, "tag_origin");
      }
    }
  }
}

function function_e10bfb69(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump != fieldname) {
    if(bwastimejump) {
      exploder::exploder("fxexp_red_door_enter_mall");
    }
  }
}

function function_afb3813c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump != fieldname) {
    if(bwastimejump) {
      exploder::exploder("fxexp_red_door_enter_temple");
    }
  }
}