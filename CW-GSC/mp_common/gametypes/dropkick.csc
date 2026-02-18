/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\dropkick.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#namespace dropkick;

function event_handler[gametype_init] main(eventstruct) {
  clientfield::register("world", "" + # "hash_69d32ac298f2aa22", 1, 2, "int", &function_311e397d, 0, 0);
  callback::function_56df655f(&function_56df655f);
}

function function_311e397d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1 && level.var_67c8b45f !== 1) {
    level.var_67c8b45f = 1;
    level childthread function_df0960d3(fieldname);
    level childthread function_ef284b9c(fieldname);
    level childthread function_efd48790(fieldname);
    return;
  }

  if(bwastimejump == 2 && level.var_67c8b45f === 1) {
    level.var_67c8b45f = 0;
    function_e8a68a06(fieldname, 0.3);
    return;
  }

  if(bwastimejump == 3) {
    level childthread function_81e1cce7(fieldname);
  }
}

function private function_df0960d3(localclientnum) {
  wait 2;

  if(level.var_67c8b45f === 0) {
    return;
  }

  function_a837926b(localclientnum, #"hash_72d5d84c9d0b25c");
}

function private function_ef284b9c(localclientnum) {
  wait 3.4;

  if(level.var_67c8b45f === 0) {
    return;
  }

  function_a837926b(localclientnum, #"hash_69a53e8913317ecf");
  duration = 6;
  wait duration;

  if(function_148ccc79(localclientnum, #"hash_69a53e8913317ecf")) {
    function_24cd4cfb(localclientnum, #"hash_69a53e8913317ecf");
  }
}

function private function_efd48790(localclientnum) {
  wait 3.4;

  if(level.var_67c8b45f === 0) {
    return;
  }

  player = function_27673a7(localclientnum);
  player util::waittill_dobj(localclientnum);

  if(!isDefined(player) || level.var_67c8b45f === 0) {
    return;
  }

  level.var_abfcab7a = playtagfxset(localclientnum, #"tagfx9_nuke_dropkick_camera_start", player);
  var_68a17fa6 = 6.6;
  wait var_68a17fa6;
  player = function_27673a7(localclientnum);
  player util::waittill_dobj(localclientnum);

  if(!isDefined(player) || level.var_67c8b45f === 0) {
    return;
  }

  level.var_2efb73eb = playtagfxset(localclientnum, #"tagfx9_nuke_dropkick_camera", player);
}

function function_81e1cce7(localclientnum) {
  function_a837926b(localclientnum, #"hash_65e918e7c65c396b");
}

function private function_e8a68a06(localclientnum, waittime) {
  if(isDefined(waittime) && waittime > 0) {
    wait waittime;
  }

  if(function_148ccc79(localclientnum, #"hash_72d5d84c9d0b25c")) {
    codestoppostfxbundlelocal(localclientnum, #"hash_72d5d84c9d0b25c");
  }

  if(function_148ccc79(localclientnum, #"hash_69a53e8913317ecf")) {
    codestoppostfxbundlelocal(localclientnum, #"hash_69a53e8913317ecf");
  }

  if(isDefined(level.var_abfcab7a)) {
    foreach(tagfx in level.var_abfcab7a) {
      stopfx(localclientnum, tagfx);
    }
  }

  if(isDefined(level.var_2efb73eb)) {
    foreach(tagfx in level.var_2efb73eb) {
      stopfx(localclientnum, tagfx);
    }
  }
}

function function_56df655f(params) {
  if(gamemodeismode(5) && level.var_67c8b45f === 1) {
    function_e8a68a06(params.localclientnum, 0);
    level.var_67c8b45f = 0;
  }
}