/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\nuke.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace nuke;

function private autoexec __init__system__() {
  system::register(#"nuke", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  level.var_bdab9ccd = getscriptbundle("killstreak_nuke");
  clientfield::register("scriptmover", "" + # "hash_494d8af20db4dc73", 1, 1, "int", &function_fd98ff7f, 0, 0);
  clientfield::register("world", "" + # "hash_6a6a21b8c5e1528e", 1, 1, "int", &function_977aa020, 0, 0);
  clientfield::register("world", "" + # "hash_1559e8163efbdb7a", 1, 1, "int", &function_b5fd20b3, 0, 0);
  clientfield::register("world", "" + # "hash_50ae988d8c6973f5", 1, 2, "int", &function_43cfe793, 0, 0);
  callback::on_localplayer_spawned(&on_localplayer_spawned);
}

function on_localplayer_spawned(localclientnum) {
  self thread function_b2067aca(localclientnum);
}

function function_b2067aca(localclientnum) {
  self notify("10969d89536716a2");
  self endon("10969d89536716a2");
  self endon(#"death");
  util::function_89a98f85();
  var_82a0a786 = level clientfield::get("" + # "hash_50ae988d8c6973f5");

  if(var_82a0a786 == 0) {
    if(isDefined(level.var_e1dcc9e7) || isDefined(level.var_8bb199d1)) {
      self function_43cfe793(localclientnum, 0, var_82a0a786);
    }

    return;
  }

  if(!isDefined(level.var_e1dcc9e7) && !isDefined(level.var_8bb199d1)) {
    self function_43cfe793(localclientnum, 0, var_82a0a786);
  }
}

function function_fd98ff7f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(isDefined(level.var_bdab9ccd.var_cef97854) && !isDefined(level.var_667ac9a6)) {
      forward = anglesToForward(self.angles);
      up = anglestoup(self.angles);
      level.var_667ac9a6 = playFX(fieldname, level.var_bdab9ccd.var_cef97854, self.origin, forward, up);
    }

    return;
  }

  if(isDefined(level.var_667ac9a6)) {
    deletefx(fieldname, level.var_667ac9a6);
    level.var_667ac9a6 = undefined;
  }
}

function function_977aa020(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.var_bdab9ccd.var_8e78250d)) {
    return;
  }

  if(bwastimejump) {
    function_a837926b(fieldname, level.var_bdab9ccd.var_8e78250d);
    return;
  }

  codestoppostfxbundlelocal(fieldname, level.var_bdab9ccd.var_8e78250d);
}

function function_b5fd20b3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.var_bdab9ccd.var_5e5fbb8b)) {
    return;
  }

  if(bwastimejump) {
    function_a837926b(fieldname, level.var_bdab9ccd.var_5e5fbb8b);
    return;
  }

  function_24cd4cfb(fieldname, level.var_bdab9ccd.var_5e5fbb8b);
}

function function_43cfe793(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = function_27673a7(fieldname);
  player util::waittill_dobj(fieldname);

  if(!isDefined(player)) {
    return;
  }

  function_d1208379(fieldname);

  if(bwastimejump == 1) {
    if(isDefined(level.var_bdab9ccd.var_b263d69f)) {
      level.var_e1dcc9e7 = playtagfxset(fieldname, level.var_bdab9ccd.var_b263d69f, player);
    }

    return;
  }

  if(bwastimejump == 2) {
    if(isDefined(level.var_bdab9ccd.var_7daf63f0)) {
      level.var_8bb199d1 = playtagfxset(fieldname, level.var_bdab9ccd.var_7daf63f0, player);
    }
  }
}

function private function_d1208379(localclientnum) {
  if(isDefined(level.var_e1dcc9e7)) {
    foreach(tagfx in level.var_e1dcc9e7) {
      if(isfxplaying(localclientnum, tagfx)) {
        killfx(localclientnum, tagfx);
      }
    }
  }

  if(isDefined(level.var_8bb199d1)) {
    foreach(tagfx in level.var_8bb199d1) {
      if(isfxplaying(localclientnum, tagfx)) {
        killfx(localclientnum, tagfx);
      }
    }
  }

  level.var_e1dcc9e7 = undefined;
  level.var_8bb199d1 = undefined;
}