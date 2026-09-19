/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1382.gsc
**************************************/

#using_animtree("zombie_generic");

init() {
  level._id_0A41["zombie_generic"] = level._id_0A41["zombie"];
  level._id_0A41["zombie_generic"]["think"] = ::_id_ABB3;
  level._id_0A41["zombie_generic"]["on_damaged"] = ::_id_ABB2;
  level._id_0A41["zombie_generic"]["get_action_params"] = ::zombie_generic_get_action_params;
  var_0 = ["zom_head_fdr02_org1", "zom_head_fdr03_org1", "zom_head_fdr04_org1"];
  var_1 = ["zom_m40helmet_net1", "zom_m40helmet_org1", "zom_m40helmet_org2"];
  var_2 = ["zom_m34cap_org1", "zom_m40officercap_org1", "zom_m42cap_org1", "zom_m43cap_org1", "zom_m43cap_org2", "zom_m43overseacap_org1"];
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = spawnStruct();
  var_6._id_5ED2["guts"]["whole_body"] = "zom_infantrya_bodywhole";
  var_6._id_5ED2["guts"]["torso"] = "zom_infantrya_torso_slice";
  var_6._id_5ED2["guts"]["left_arm"] = "zom_infantrya_l_arm_slice";
  var_6._id_5ED2["guts"]["left_leg"] = "zom_infantrya_l_leg_slice";
  var_6._id_5ED2["guts"]["right_arm"] = "zom_infantrya_r_arm_slice";
  var_6._id_5ED2["guts"]["right_leg"] = "zom_infantrya_r_leg_slice";
  var_6._id_5ED2["guts"]["heads"] = var_0;
  var_6._id_5ED2["guts"]["caps"] = var_2;
  var_6._id_5ED2["guts"]["helmets"] = var_1;
  var_6._id_5ED2["guts"]["facegear"] = var_5;
  var_6._id_5ED2["poncho"]["whole_body"] = "zom_snipera_bodywhole";
  var_6._id_5ED2["poncho"]["torso"] = "zom_snipera_torso_slice";
  var_6._id_5ED2["poncho"]["left_arm"] = "zom_snipera_l_arm_slice";
  var_6._id_5ED2["poncho"]["left_leg"] = "zom_snipera_l_leg_slice";
  var_6._id_5ED2["poncho"]["right_arm"] = "zom_snipera_r_arm_slice";
  var_6._id_5ED2["poncho"]["right_leg"] = "zom_snipera_r_leg_slice";
  var_6._id_5ED2["poncho"]["heads"] = var_0;
  var_6._id_5ED2["poncho"]["caps"] = var_2;
  var_6._id_5ED2["poncho"]["helmets"] = var_1;
  var_6._id_5ED2["poncho"]["facegear"] = var_5;
  var_6._id_5ED2["possum"]["whole_body"] = "zom_infantrya_bodywhole";
  var_6._id_5ED2["possum"]["torso"] = "zom_infantrya_torso_slice";
  var_6._id_5ED2["possum"]["left_arm"] = "zom_infantrya_l_arm_slice";
  var_6._id_5ED2["possum"]["left_leg"] = "zom_infantrya_l_leg_slice";
  var_6._id_5ED2["possum"]["right_arm"] = "zom_infantrya_r_arm_slice";
  var_6._id_5ED2["possum"]["right_leg"] = "zom_infantrya_r_leg_slice";
  var_6._id_5ED2["possum"]["heads"] = ["zom_head_fdr02_org1"];
  var_6._id_5ED2["possum"]["request only"] = 1;
  var_6._id_5ED2["soldier"]["whole_body"] = "zom_inf_smga_org1_mm3";
  var_6._id_5ED2["soldier"]["request only"] = 1;
  var_6._id_5ED2["soldier_rus"]["whole_body"] = "zom_rus_infantry_org1";
  var_6._id_5ED2["soldier_rus"]["request only"] = 1;
  var_6._id_0A4B = "zombie_generic";
  var_6._id_0EAE = "zombie_animclass";
  var_6._id_0879 = "zombie_generic";
  var_6._id_4C12 = 1;
  var_6._id_60E2 = 40;
  var_6._id_8302 = 65;
  var_6._id_8303 = 15;
  var_6.suppressive_fire_speed_multiplier = 0.3;
  var_6.tacklebymelee = 1;
  var_6.tacklebycharge = 1;
  var_6.knockbyravensword = 1;
  var_6.shockbyteslablood = 1;
  var_6.knockbybladebarbarossa = 1;
  var_6.energyhold = 1;
  var_6.energyholdkill = 1;
  var_6.energyholdsecondary = 1;
  var_6.throwable = 1;

  if(isDefined(level._id_62AB))
    var_6 = [[level._id_62AB]](var_6);

  _id_0547::_id_0A52(var_6, "zombie_generic");
  _id_0547::registeranimtree("zombie_generic", #animtree);
}

_id_ABB5() {
  maps\mp\agents\humanoid\_humanoid::_id_8A27();
  thread _id_054D::_id_AC15();
  thread _id_0547::_id_A692();
  thread _id_AB4F();
  thread _id_054D::_id_A0EE();
  thread _id_054D::_id_A146();
  thread _id_053C::_id_0778();
  thread _id_053C::_id_4F95();
  thread _id_053C::_id_635C();

  if(self._id_0A4B == "zombie_generic") {
    if(!isDefined(level.var_scaling_reach_max_wave))
      var_0 = 47;
    else
      var_0 = level.var_scaling_reach_max_wave;

    if(!isDefined(level.var_scaling_reach_min_wave))
      var_1 = 25;
    else
      var_1 = level.var_scaling_reach_min_wave;

    var_2 = (self._id_901F - var_1) / (var_0 - var_1);
    var_3 = _func_2CA(60, 72, var_2);
    var_3 = clamp(var_3, 60, 72);
    _id_0547::_id_86C7(var_3);
  }
}

_id_ABB3() {
  self _meth_85A1("zombie");
  _id_ABB4();
}

zombie_generic_think_wait(var_0) {
  if(!isDefined(var_0))
    var_0 = 0.2;

  wait(common_scripts\utility::_id_98E7(isDefined(self.has_think_waited), var_0, _randomfloat(var_0)));
  self.has_think_waited = 1;
}

_id_ABB4() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  _id_ABB5();

  for(;;) {
    if(_id_053C::_id_4F8C()) {} else if(_id_053C::_id_4F84()) {} else if(_id_053C::_id_4F9B()) {} else if(_id_053C::_id_4F9A()) {} else
      _id_053C::_id_0647();

    zombie_generic_think_wait();
  }
}

_id_AB4F() {
  self endon("death");

  for(;;) {
    var_0 = common_scripts\utility::_id_A717("attack_hit", "attack_miss");

    switch (var_0[0]) {
      case "attack_hit":
        if(isDefined(self._id_071D))
          thread _id_054E::_id_3102("attack_hit", self._id_071D._id_0A47);

        var_1 = var_0[1];

        if(isDefined(var_1) && isPlayer(var_1)) {
          if(self._id_0A4B == "zombie_generic" || self._id_0A4B == "zombie_assassin" || self._id_0A4B == "zombie_sizzler") {
            if(isalive(var_1))
              var_1 _id_0380::_id_2888("zmb_hit", var_1);
            else
              var_1 _id_0380::_id_288B("zmb_hit", var_1, var_1);
          } else if(self._id_0A4B == "zombie_heavy" && isDefined(self._id_1F52)) {
            if(isalive(var_1))
              var_1 _id_0380::_id_2888("zmb_follower_mace_imp", var_1);
            else
              var_1 _id_0380::_id_288B("zmb_follower_mace_imp", var_1, var_1);
          } else if(self._id_0A4B == "zombie_bob" && isDefined(self._id_1F52)) {
            if(isalive(var_1))
              var_1 _id_0380::_id_2888("zmb_bob_melee_hit", var_1);
            else
              var_1 _id_0380::_id_288B("zmb_bob_melee_hit", var_1, var_1);
          } else if(self._id_0A4B == "zombie_guardian" && isDefined(self._id_1F52)) {
            if(isalive(var_1))
              var_1 _id_0380::_id_2888("zmb_hit", var_1);
            else
              var_1 _id_0380::_id_288B("zmb_hit", var_1, var_1);
          }
        }

        break;
      case "attack_miss":
        thread _id_054E::_id_3102("attack_miss", self._id_0A4B);
        break;
    }
  }
}

_id_ABB2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(var_5 == "panzerschreck_zm" || var_5 == "bazooka_zm")
    var_2 = self.maxhealth;

  if(var_5 == "turretweapon_zeppelin_gun_zm") {
    var_4 = "MOD_RIFLE_BULLET";

    if(common_scripts\utility::_id_562E(self._id_A87C))
      var_2 = var_2 * 0;
    else
      var_2 = var_2 * 1;
  }

  if(isDefined(self.prop_decorator)) {
    if(var_8 == "head") {
      if(self.prop_decorator.model == "usa_water_bucket_01" || self.prop_decorator.model == "aac_kitchen_skillet_01") {
        var_11 = spawn("script_model", self.prop_decorator.origin);
        var_11 setModel(self.prop_decorator.model);
        var_11.angles = self.prop_decorator.angles;
        self.prop_decorator delete();
        var_2 = 1;
        var_12 = spawn("script_model", var_11.origin);
        var_12 setModel("helmet_collision");
        var_12.angles = var_11.angles;
        var_11 linkto(var_12);
        var_12._id_6292 = var_11;
        var_12 thread decoratorlaunch(var_7);
        var_12 hideallparts();
      }
    }
  }

  _id_054D::_id_6BD1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

decoratorlaunch(var_0) {
  level endon("game_ended");
  var_1 = 5000;
  var_2 = 3000;

  if(!isDefined(var_0))
    var_0 = anglesToForward(self.angles);

  var_3 = var_0;
  var_4 = var_3[0] * var_1;
  var_5 = var_3[1] * var_1;
  var_6 = var_3[2] * var_2;
  var_7 = self.origin + var_0 * -5;
  self physicslaunchclient(var_7, (var_4, var_5, var_6));
  wait 15;
  self._id_6292 delete();
  self delete();
}

zombie_generic_get_action_params() {
  if(isDefined(self.action_param_override_func))
    var_0 = [[self.action_param_override_func]]();
  else
    var_0 = _id_054D::_id_AC22();

  return var_0;
}