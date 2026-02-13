/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2432.gsc
*************************************************/

_id_7FC5(var_0) {
  var_1 = scripts\engine\utility::getstructarray("jaroslav_machine", "script_noteworthy");
  level._id_8B7B = level._id_8393["jaroslav_machine"]._id_3D91;
  level._id_5F04 = 3000;
  level._id_5F05 = 6000;

  foreach(var_3 in var_1) {
    var_4 = getEntArray(var_3.target, "targetname");

    foreach(var_6 in var_4) {
      if(var_6._id_039B == "fnf_machine") {
        var_3._id_9923 = var_6;
        continue;
      }

      if(var_6._id_039B == "fnf_jaw") {
        var_3._id_8BA2 = var_6;
        continue;
      }

      if(var_6._id_039B == "fnf_light") {
        if(!isDefined(var_3._id_949B)) {
          var_3._id_949B = [];
        }

        var_3._id_949B[var_3._id_949B.size] = var_6;
      }
    }

    var_3._id_9923 setscriptablepartstate("teller", "safe_off");
    var_3._id_8BA2 setModel("zmb_fortune_teller_machine_jaw_01");
    var_3 thread _id_BABD();
  }
}

_id_DAEE() {
  if(getdvarint("#x3ad67579137c951a9") != 17 && getdvarint("#x3ad67579137c951a9") != 1) {
    return 0;
  }

  return 0;
}

_id_BABD() {
  foreach(var_1 in self._id_949B) {
    var_1 _meth_8338(0);

    if(istrue(self._id_C588)) {
      var_1 thread _id_F804(self);
    }
  }
}

_id_F804(var_0) {
  for(;;) {
    var_1 = level scripts\engine\utility::_id_10898("power_on", var_0._id_BA97 + " power_on", "power_off");

    if(var_1 == "power_off") {
      self _meth_8338(0);
      var_0._id_BAD8 = 0;
      continue;
    }

    self _meth_8338(0.65);
    var_0._id_9923 setscriptablepartstate("machine", "default_on");
    var_0._id_9923 setscriptablepartstate("teller", "safe_on");

    if(!var_0._id_BAD8) {
      level thread _id_0746::_id_102A("jaroslav_anc_attract", var_0._id_8BA2.origin, 120, 120, 250000, 100);
    }

    var_0._id_BAD8 = 1;
  }
}

_id_8373(var_0, var_1) {
  level thread _id_A1DE(var_0, 3);
  var_1 notify("stop_interaction_logic");
  var_1._id_8F31 = undefined;
  var_2 = getarraykeys(var_1._id_3BB3);
  var_1 notify("cards_replenished");

  if(var_1 scripts\cp\utility::_id_1A46()) {
    foreach(var_4 in var_2) {
      var_1 notify(var_4 + "_exited_early");
    }
  }

  wait 0.5;
  var_1 _id_0981::_id_C5C7();
  var_1._id_3267 = var_1._id_3267 + 1;
  var_1 thread _id_0981::_id_F7FF();
  var_1 thread _id_0981::_id_9DEF();
  var_1 _id_0741::_id_BD77("mt_faf_refill_deck");
  playsoundatpos(var_0.origin, "jaroslav_anc_activate_use");
  level thread _id_8B7A(var_1);
  level thread _id_076F::_id_C3D1("nag_need_fateandfort");
  var_1 _id_0737::_id_C1A2();
}

_id_8B7A(var_0) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  wait 2;
  var_0 thread _id_076F::_id_F72D("wonder_restock", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
}

_id_A1DE(var_0, var_1) {
  if(isDefined(var_0._id_8BA2._id_A280)) {
    return;
  }
  var_0._id_9923 setscriptablepartstate("mouth", "smoke");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_0._id_8BA2._id_A280 = 1;
    var_0._id_8BA2 movez(-1, 0.2);
    var_0._id_8BA2 waittill("movedone");
    wait 1;
    var_0._id_8BA2 movez(1, 0.2);
    var_0._id_8BA2 waittill("movedone");
  }

  var_0._id_8BA2._id_A280 = undefined;
}

_id_8B79(var_0, var_1) {
  if(var_0._id_C588 && !var_0._id_BAD8) {
    return &"COOP_INTERACTIONS/REQUIRES_POWER";
  }

  level thread _id_A1DE(var_0, 1);

  if(var_1 scripts\cp\utility::_id_1A46()) {
    var_2 = &"COOP_INTERACTIONS/FNF_WHILE_ACTIVE";
  } else {
    var_2 = level._id_835D[var_0._id_039B];
  }

  switch (var_1._id_3267) {
    case 1:
    case 0:
      return var_2;
    default:
      return &"COOP_INTERACTIONS/NO_MORE_CARDS_OWNED";
  }
}

_id_B4F9(var_0) {
  var_0._id_5F06 = 0;
  var_0._id_3267 = 0;
}

_id_C1EF() {
  level._id_835D["jaroslav_machine"] = &"COOP_INTERACTIONS/FNF";
  _id_0737::_id_C1EE("jaroslav_machine", "wondercard_machine", 1, ::_id_8B79, ::_id_8373, 3000, 1, ::_id_7FC5);
}