/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1b2f6ef7778cf920.csc
***********************************************/

#using script_12a356e85208ae89;
#using script_18910f59cc847b42;
#using script_20b40cfe13d341c4;
#using script_20d6a8a1b41c0add;
#using script_245f38df21b701ca;
#using script_2fbf885102bafd03;
#using script_30c7fb449869910;
#using script_30efbc1e0156ebae;
#using script_33128b01aae27d52;
#using script_3314b730521b9666;
#using script_38635d174016f682;
#using script_41540e991952b0c1;
#using script_42cbbdcd1e160063;
#using script_43e930c786cc935;
#using script_45a4ac4fad69575c;
#using script_4adf64e112e9afec;
#using script_5965abece570193b;
#using script_60a2f38d6d37fd6a;
#using script_64e5d3ad71ce8140;
#using script_67049b48b589d81;
#using script_6872cf0845191c15;
#using script_6b71c9befed901f2;
#using script_71603a58e2da0698;
#using script_75c3996cce8959f7;
#using script_75e0a2c8a5c12652;
#using script_76abb7986de59601;
#using script_77163d5a569e2071;
#using script_771f5bff431d8d57;
#using script_7bf1bd99605135bf;
#using script_87f762606a9546;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_4dae815d;

function init() {
  level thread function_170b90e5();
  level.var_43cd3fe5 = doa_keytrade::register();
  clientfield::register("world", "world_state", 1, 3, "int", &function_fefe581c, 0, 0);
  clientfield::register("world", "roundNumber", 1, 10, "int", &function_5b2f0c51, 0, 0);
  clientfield::function_5b7d846d("DOA_GLOBALUIMODEL_WORLDSTATE", #"doa_world", #"worldstate", 1, 3, "int", undefined, 0, 0);
  clientfield::function_5b7d846d("DOA_GLOBALUIMODEL_COUNTDOWN", #"doa_world", #"countdown", 1, 11, "int", undefined, 0, 0);
  clientfield::function_5b7d846d("DOA_GLOBALUIMODEL_ARENANUMBER", #"doa_world", #"arenanumber", 1, 4, "int", undefined, 0, 0);
  clientfield::function_5b7d846d("DOA_GLOBALUIMODEL_ROUNDNUMBER", #"doa_world", #"roundnumber", 1, 16, "int", undefined, 0, 0);
  level.doa.var_99ee4341 = &function_c69e4ad3;
  setsaveddvar(#"cg_disableearthquake", 1);
  setsaveddvar(#"cg_splitscreenletterboxsize", 0);
  setsaveddvar(#"hash_6d8494547e990924", 0);
  setsaveddvar(#"hash_517069e39659d251", 1);
}

function function_170b90e5() {
  function_32d5e898();
  namespace_981c1f3c::init();
  namespace_8c04284b::init();
  namespace_77eccc4f::init();
  doa_banner::init();
  namespace_5a917022::init();
  namespace_ac2a80f5::init();
  doa_enemy::init();
  namespace_250e9486::init();
  namespace_1c2a96f9::init();
  namespace_ed80aead::init();
  namespace_268747c0::init();
  namespace_6e90e490::init();
  namespace_b7d49cfd::init();
  namespace_dfc652ee::init();
  doa_player::init();
  namespace_83eb6304::init();
  namespace_eccff4fb::init();
  namespace_e32bb68::init();
  namespace_9fc66ac::init();
  namespace_c85a46fe::init();
  doa_wild::init();
  namespace_491fa2b2::init();
}

function function_fefe581c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level notify(#"hash_6c5fd7c95b05ac71");

  if(fieldname == 1 && bwastimejump == 0) {
    function_32d5e898(binitialsnap, 1);
  }

  level.doa.world_state = bwastimejump;
  namespace_9fc66ac::function_65fcd877();
  level.var_fb0679ad = 0;
  function_b6e8ef46();

  if(level.doa.world_state == 2) {
    player = getplayers(binitialsnap)[0];
    player thread namespace_7f5aeb59::function_4d692cc4(binitialsnap, "default");
  }

  if(level.doa.world_state == 1) {
    if(isDefined(level.doa.var_99ee4341)) {
      level thread[[level.doa.var_99ee4341]](binitialsnap);
    }

    level.doa.var_318aa67a = 0;
  }

  setsaveddvar(#"hash_2d5b0d6d4ce995d7", level.doa.world_state >= 4);
}

function function_5b2f0c51(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level.doa.roundnumber = bwastimejump;
  rootmodel = function_1df4c3b0(fieldname, #"hash_2ea8961f59d263ac");

  if(isDefined(rootmodel)) {
    var_8cde191 = getuimodel(rootmodel, #"hash_7c6ed19dcbb33bcb");

    if(isDefined(var_8cde191)) {
      setuimodelvalue(var_8cde191, bwastimejump);
    }

    var_2c531ea2 = getuimodel(rootmodel, #"hash_6c6869e61a797192");

    if(isDefined(var_2c531ea2)) {
      setuimodelvalue(var_2c531ea2, bwastimejump);
    }
  }

  namespace_9fc66ac::function_2fc07d61();
}

function function_32d5e898(localclientnum = 0, restart = 0) {
  if(!isDefined(level.doa)) {
    level.doa = spawnStruct();
  }

  level.doa.world_state = 0;
  level.var_fb0679ad = 0;
  level.doa.cutscene = 0;
  level.doa.var_318aa67a = getdvarint(#"hash_670ddb067d311f3d", 0);
  level.doa.hardcoremode = getdvarint(#"hash_47849a8681a67ce7", 0);

  if(restart) {
    namespace_8c04284b::function_32d5e898(localclientnum);
    namespace_77eccc4f::function_32d5e898(localclientnum);
    doa_banner::function_32d5e898(localclientnum);
    namespace_5a917022::function_32d5e898(localclientnum);
    namespace_ac2a80f5::function_32d5e898(localclientnum);
    doa_enemy::function_32d5e898(localclientnum);
    namespace_250e9486::function_32d5e898(localclientnum);
    namespace_ed80aead::function_32d5e898(localclientnum);
    namespace_1c2a96f9::function_32d5e898(localclientnum);
    namespace_268747c0::function_32d5e898(localclientnum);
    namespace_6e90e490::function_32d5e898(localclientnum);
    namespace_dfc652ee::function_32d5e898(localclientnum);
    doa_player::function_32d5e898(localclientnum);
    namespace_eccff4fb::function_32d5e898(localclientnum);
    namespace_e32bb68::function_32d5e898(localclientnum);
    namespace_9fc66ac::function_32d5e898(localclientnum);
    namespace_c85a46fe::function_32d5e898(localclientnum);
    doa_wild::function_32d5e898(localclientnum);
    namespace_491fa2b2::function_32d5e898(localclientnum);
  }
}

function function_c69e4ad3(localclientnum) {}

function function_aa00217e() {
  if(isDefined(level.localplayers) && level.localplayers.size > 1) {
    return (level.doa.r_splitscreenexpandfull == 1);
  }

  return true;
}

function function_e1887b0f(val) {
  localplayers = getlocalplayers();

  if(isDefined(localplayers) && localplayers.size > 1) {
    setsaveddvar(#"r_splitscreenexpandfull", val);
    level.doa.r_splitscreenexpandfull = val;

    foreach(player in localplayers) {
      if(!isDefined(player)) {
        continue;
      }

      if(!isDefined(player.doa)) {
        continue;
      }

      if(val == 0) {
        setDvar(#"hash_4f816615d4fd775f", 3);

        if(!isDefined(player.doa.cameramode) || player.doa.cameramode == 4) {
          player.doa.cameramode = 1;
        }

        continue;
      }

      if(val == 1) {
        if(!isDefined(player.doa.cameramode) || player.doa.cameramode < 4) {
          player.doa.cameramode = 4;
        }
      }
    }
  }
}

function function_abcdf17f() {
  var_3b172c06 = 0;
  localplayers = getlocalplayers();

  if(localplayers.size > 1) {
    if(level.doa.world_state >= 4) {
      return 1;
    }

    if(is_true(level.doa.var_182fb75a)) {
      return 1;
    }

    var_3b172c06 = doa_player::function_505038df();
  }

  return var_3b172c06;
}

function function_b6e8ef46() {
  result = function_abcdf17f();
  function_e1887b0f(result ? 0 : 1);
}