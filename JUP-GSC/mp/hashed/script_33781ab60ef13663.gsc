/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_33781ab60ef13663.gsc
*************************************************/

#using scripts\asm\asm;
#using scripts\common\callbacks;
#using scripts\engine\utility;
#namespace namespace_ab4bb52668162033;

function function_96f220b689167b22() {
  callback::get_template(self.animsetname) callback::add("on_zombie_ai_damaged", &function_ce8c7137ccfd571e);
}

function function_ce8c7137ccfd571e(params) {
  if(params.smeansofdeath == "MOD_CRUSH" && isDefined(params.einflictor) && params.einflictor.classname == "script_vehicle") {
    forward_vec = anglesToForward(self.angles);

    if(vectordot(params.vpoint - self.origin, forward_vec) < 0) {
      return;
    }

    if(isDefined(self.var_bf971c68459203a3) && !time_has_passed(self.var_bf971c68459203a3, 5)) {
      return;
    }

    if(params.einflictor vehicle_getspeed() < 15) {
      return;
    }

    if(!istrue(self.var_3bf23e7f7a47ea2a)) {
      self.var_3bf23e7f7a47ea2a = 1;
      function_ac90fa5cc0a80298("vehicle_impact_pass_in");
    }

    thread handle_vehicle_impact_anim();
  }
}

function handle_vehicle_impact_anim() {
  self notify("handle_vehicle_impact_anim_singleton");
  self endon("handle_vehicle_impact_anim_singleton");

  while(isalive(self)) {
    waittill_any_timeout_1(0.1, "death");

    if(!isDefined(self.var_64c4f7086b0c04f4) || time_has_passed(self.var_64c4f7086b0c04f4, 0.1)) {
      break;
    }
  }

  self.var_bf971c68459203a3 = gettime();

  if(isDefined(self)) {
    self.var_3bf23e7f7a47ea2a = undefined;
  }
}

function function_8bcd44e8a5b0f6ea(asmname, statename, tostatename, params) {
  return istrue(self.var_3bf23e7f7a47ea2a);
}