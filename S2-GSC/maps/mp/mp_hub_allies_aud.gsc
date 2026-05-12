/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_hub_allies_aud.gsc
*********************************************/

func_00F9() {
  func_7BD2();
  func_5C22();
}

func_5C22() {
  thread func_5C18();
}

func_5C18() {
  wait(0.5);
}

func_7BD2() {
  lib_0378::func_8DC7("start_hub_music", ::func_922A);
  lib_0378::func_8DC7("truck_grp_a_moving", ::func_4A87);
  lib_0378::func_8DC7("truck_grp_b_moving", ::func_4A88);
  lib_0378::func_8DC7("truck_load", ::func_9DE7);
  lib_0378::func_8DC7("truck_unload", ::func_9DEF);
  lib_0378::func_8DC7("theater_cinematic_started", ::func_4A76);
  lib_0378::func_8DC7("theater_cinematic_stopped", ::func_4A77);
  lib_0378::func_8DC7("ks_carepackage_firstImpact", ::func_1FF7);
  lib_0378::func_8DC7("res_bomber_flyby_start", ::resistance_bomber_flyby);
  lib_0378::func_8DC7("aud_timer_tag_take_bomb", ::timer_tag_take_bomb);
  lib_0378::func_8DC7("aud_timer_tag_give_bomb", ::timer_tag_give_bomb);
  lib_0378::func_8DC7("aud_timer_tag_fireworks", ::timer_tag_fireworks);
}

func_922A() {
  var_00 = self;
  var_00 method_8626("mp_hub_allies_postmatch_mus_mix");
  var_00 thread func_483B();
  var_00 thread func_9216();
}

func_1FF7() {
  var_00 = self;
  lib_0380::func_6844("mp_hub_crpkg_imp_allies", undefined, self);
}

func_4A87() {
  var_00 = self;
  var_01 = lib_0380::func_6846("mp_hub_allies_truck_engine_lp_dist", undefined, var_00);
}

func_4A88(param_00, param_01) {
  var_02 = lib_0380::func_6846("mp_hub_allies_truck_engine_lp", undefined, param_00);
  var_03 = lib_0380::func_6846("mp_hub_allies_truck_engine_lp", undefined, param_01);
}

func_9DE7() {
  var_00 = self;
  var_01 = lib_0380::func_6846("mp_hub_qm_load_box_truck", undefined, var_00);
}

func_9DEF() {
  var_00 = self;
  var_01 = lib_0380::func_6846("mp_hub_qm_unload_box_truck", undefined, var_00);
}

func_4A76() {
  var_00 = self;
  var_00 method_8626("duck_background_sfx");
}

func_4A77() {
  var_00 = self;
  var_00 method_8627("duck_background_sfx");
}

func_9216() {
  self endon("disconnect");
  self endon("death");
  wait(1);
  var_00 = self;
  lib_0380::func_2889("emt_mp_hub_allies_projector_lp", var_00, (-1579, 1589, 20));
}

func_483B() {
  self endon("disconnect");
  self endon("death");
  wait(1);
  var_00 = self;
  var_01 = lookupsoundlength("mp_hub_mus_1");
  var_02 = lookupsoundlength("mp_hub_mus_2");
  var_03 = lookupsoundlength("mp_hub_mus_3");
  var_04 = lookupsoundlength("mp_hub_mus_4");
  var_05 = 0;
  var_06 = 0;
  for(;;) {
    for(var_05 = randomintrange(1, 5); var_05 == var_06; var_05 = randomintrange(1, 4)) {}

    var_06 = var_05;
    var_07 = common_scripts\utility::func_9AAD(var_05);
    var_08 = "mp_hub_mus_" + var_07;
    var_09 = lib_0380::func_2889(var_08, var_00, (-973, 3317, -245));
    wait(1.5);
    if(var_05 == 1) {
      wait(var_01);
    } else if(var_05 == 2) {
      wait(var_02);
    } else if(var_05 == 3) {
      wait(var_03);
    } else if(var_05 == 4) {
      wait(var_04);
    }

    wait(1);
  }
}

resistance_bomber_flyby() {
  var_00 = self;
  lib_0380::func_6846("mp_hub_resistance_bomber_flyby", undefined, var_00);
  wait(5);
  var_01 = lib_0380::func_6840("mp_resistance_flyers_lp", undefined, 3, 1);
  wait(10);
  if(isDefined(var_01)) {
    lib_0380::func_6850(var_01, 10);
    var_01 = undefined;
  }
}

timer_tag_take_bomb() {
  var_00 = self;
  lib_0380::func_2889("mp_hub_timer_tag_bomb_take", undefined, var_00.var_0116);
}

timer_tag_give_bomb() {
  var_00 = self;
  lib_0380::func_2889("mp_hub_timer_tag_bomb_give", undefined, var_00.var_0116);
}

timer_tag_fireworks() {
  var_00 = self;
  lib_0380::func_2889("mp_hub_timer_tag_fireworks", undefined, var_00.var_0116);
}