/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2339.gsc
*************************************************/

throwing_knife_init_cp() {
  level.aether_grenade_tag_overrides["s4_throwing_knife_zm"] = "tag_knife_fx";
}

_id_F1A2(var_0) {
  level endon("game_ended");
  var_0 makeunusable();

  if(!isDefined(var_0._id_5562)) {
    var_0._id_5562 = "equip_throwing_knife";
  }

  var_1 = undefined;
  var_2 = undefined;
  var_3 = self.name;
  var_0 waittill("missile_stuck", var_1, var_2);

  if(!isDefined(var_0)) {
    return;
  }
  level notify("grenade_exploded_during_stealth", var_0, "s4_throwing_knife_mp", var_3);
  var_4 = isDefined(var_2) && var_2 == "tag_flicker";
  var_5 = isDefined(var_2) && var_2 == "tag_weapon";

  if(isDefined(var_1) && isalive(var_1)) {
    var_6 = var_0 _id_F199(0);
    var_6 _meth_8746(var_0);
    var_6 setscriptablepartstate("cploot_offhand_throwing_knife", "visibleNoAutoPickup");
    var_0 _meth_81A6();
    scripts\engine\utility::_id_1088C(var_6, "death", var_1, "death");

    if(isalive(var_1)) {
      if(isDefined(var_0)) {
        var_0 delete();
      }

      return;
    }

    var_6 _meth_8747();
    _id_092E::_id_4744(var_6);

    if(isDefined(var_0)) {
      var_6 = var_0 _id_F199(1);
      var_0 delete();
    }
  } else {
    var_6 = var_0 _id_F199(isDefined(var_1));
    var_0 delete();

    if(!isDefined(var_1)) {
      var_6 setscriptablepartstate("cploot_offhand_throwing_knife", "visibleAfterThrow");
    }
  }
}

_id_F199(var_0) {
  var_1 = self.origin;
  var_2 = self.angles;

  if(istrue(var_0)) {
    [var_1, var_2, var_4] = _id_073D::_id_6531(0, self.origin, self.angles);
  }

  return _id_092E::_id_E178("cploot_offhand_throwing_knife", var_1, var_2, undefined, var_0);
}