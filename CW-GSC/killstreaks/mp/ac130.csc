/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\ac130.csc
***********************************************/

#using script_13da4e6b98ca81a1;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\ac130_shared;
#namespace ac130;

function private autoexec __init__system__() {
  system::register(#"ac130", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  init_shared();
  clientfield::register("toplayer", "inAC130", 1, 1, "int", &function_555656fe, 0, 1);
  callback::function_74f5faf8(&function_74f5faf8);
}

function function_555656fe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  postfxbundle = level.var_3e7d252b.ksvehicleposteffectbun;

  if(!isDefined(postfxbundle)) {
    return;
  }

  self util::function_6d0694af();

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump && codcaster::function_c955fbd1(fieldname)) {
    bwastimejump = 0;
  }

  if(bwastimejump) {
    if(self postfx::function_556665f2(postfxbundle) == 0) {
      self codeplaypostfxbundle(postfxbundle);
    }

    return;
  }

  if(self postfx::function_556665f2(postfxbundle)) {
    self codestoppostfxbundle(postfxbundle);
  }
}

function function_74f5faf8(eventparams) {
  localclientnum = eventparams.localclientnum;

  if(codcaster::function_b8fe9b52(localclientnum)) {
    player = function_5c10bd79(localclientnum);

    if(player clientfield::get_to_player("inAC130")) {
      function_555656fe(localclientnum, undefined, !codcaster::function_c955fbd1(localclientnum));
    }
  }
}