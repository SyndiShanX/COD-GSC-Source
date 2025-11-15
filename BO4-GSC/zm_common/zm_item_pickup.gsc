/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_item_pickup.gsc
***********************************************/

#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;

#namespace zm_item_pickup;

create_item_pickup(var_3d455c82, var_4b1985dd, var_b4bbefe4, n_radius = 64, var_c12c30aa = 0) {
  if(zm_utility::is_ee_enabled() || !var_c12c30aa) {
    if(!isDefined(var_4b1985dd)) {
      var_4b1985dd = zm_utility::function_d6046228(#"hash_388256f1e5a62d7c", #"hash_7693de01f82d93f0");
    }

    s_unitrigger = self zm_unitrigger::create(var_4b1985dd, n_radius, undefined, 1, var_c12c30aa);
    self.var_b4a870af = var_3d455c82;
    self.var_4bac8510 = var_b4bbefe4;
    self thread item_think();
    return s_unitrigger;
  }
}

private item_think() {
  self endon(#"death");

  while(true) {
    s_notify = self waittill(#"trigger_activated");

    if(!isDefined(self.var_4bac8510) || [
        [self.var_4bac8510]
      ](s_notify.e_who)) {
      level thread[[self.var_b4a870af]](self, s_notify.e_who);
      self function_d6812b9d();
    }
  }
}

function_d6812b9d() {
  zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
  self.s_unitrigger = undefined;
  self delete();
}

item_pickup_init(func_callback, var_c12c30aa = 0) {
  if(var_c12c30aa && !zm_utility::is_ee_enabled()) {
    return;
  }

  s_unitrigger = self zm_unitrigger::create("", 64, &function_8769717c, 1, var_c12c30aa);
  s_unitrigger.pickup_callbacks = array(func_callback);
  return s_unitrigger;
}

private function_8769717c() {
  self endon(#"death");
  waitresult = self waittill(#"trigger");
  s_stub = self.stub;

  if(isDefined(waitresult.activator) && s_stub.b_picked_up !== 1) {
    s_stub.b_picked_up = 1;

    foreach(func_callback in s_stub.pickup_callbacks) {
      waitresult.activator thread[[func_callback]](s_stub.related_parent);
    }

    s_stub.related_parent hide();
    zm_unitrigger::unregister_unitrigger(s_stub);
  }
}