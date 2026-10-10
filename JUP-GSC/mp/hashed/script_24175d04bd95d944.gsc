/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_24175d04bd95d944.gsc
*************************************************/

#using script_3c4008d0ac301044;
#using scripts\engine\utility;
#namespace namespace_ccabef44488edcf1;

function autoexec auto() {
  utility::registersharedfunc("ob_unstable_rift", "init_map", &init);
}

function init() {
  mp_jup_fort_ob_unstable_rift_cs::main();

  if(getdvarint(@ "hash_bc12bf20804347c5", 1)) {
    function_eb7f544259415a09("mp_jup_fort_ob_unstable_rifts");
  }

  if(getdvarint(@ "hash_af186b5cfdb2e7c0", 1)) {
    thread function_d963b1c1ea4328e6();
  }
}

function function_d963b1c1ea4328e6() {
  utility::flag_wait("scriptables_ready");
  var_45b5395bf31775c7 = getentitylessscriptablearray(%"hash_1c8642bc14680df");

  foreach(index, crystal in var_45b5395bf31775c7) {
    if(index % 10 == 0) {
      waitframe();
    }

    crystal.var_f6f86c3af9ca88a0 = 1;
    crystal setscriptablepartstate(#"loot_crystal", #"dead");
  }

  var_45b5395bf31775c7 = getentitylessscriptablearray(%"hash_1c8652bc1468292");

  foreach(index, crystal in var_45b5395bf31775c7) {
    if(index % 10 == 0) {
      waitframe();
    }

    crystal.var_f6f86c3af9ca88a0 = 1;
    crystal setscriptablepartstate(#"loot_crystal", #"dead");
    waitframe();
  }
}