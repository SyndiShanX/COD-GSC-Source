/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\zm\remotemissile.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\remotemissile_shared;
#using scripts\killstreaks\zm\killstreaks;
#namespace remotemissile;

function private autoexec __init__system__() {
  system::register(#"remotemissile", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  clientfield::register("world", "" + # "hash_59ec82b1a72deb72", 1, 1, "int", &function_c668b489, 0, 0);
  clientfield::register("toplayer", "" + # "remotemissile_fov", 6000, 1, "int", &remotemissile_fov, 0, 1);
  clientfield::register("toplayer", "" + # "hash_4241f7b51f8c144", 8000, 1, "int", &function_73155fe5, 0, 0);
  init_shared();
}

function function_c668b489(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    function_3385d776(#"hash_320dd60f8482919f");
    function_3385d776(#"hash_55c5552fc2e0f419");
    return;
  }

  function_c22a1ca2(#"hash_320dd60f8482919f");
  function_c22a1ca2(#"hash_55c5552fc2e0f419");
}

function remotemissile_fov(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

function function_73155fe5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(level.var_a396a670 === 1) {
    self function_4fe8eba6(bwastimejump);
  }

  if(level.var_a7c8e7d7 === 1) {
    self killstreaks::function_d79281c4(bwastimejump);
  }

  zombies = getentarraybytype(fieldname, 15);
  localplayer = function_27673a7(fieldname);

  if(isDefined(level.orda) && localplayer === self) {
    level.orda renderoverridebundle::function_f4eab437(fieldname, bwastimejump, #"hash_2c6fce4151016478");
  }

  foreach(zombie in zombies) {
    if(localplayer === self && isalive(zombie)) {
      zombie renderoverridebundle::function_f4eab437(fieldname, bwastimejump, #"hash_2c6fce4151016478");
    }
  }
}

function private function_4fe8eba6(newval) {
  if(newval) {
    fov = getdvarfloat(#"cg_fov", 80);

    if(fov > 110) {
      var_a0a59056 = 21;
    } else if(fov > 93) {
      var_a0a59056 = 20;
    } else if(fov > 85) {
      var_a0a59056 = 19;
    }

    if(isDefined(var_a0a59056)) {
      self function_49cdf043(var_a0a59056, 0);
    }

    return;
  }

  self function_9298adaf(0);
}