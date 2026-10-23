/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\utility.gsc
**************************************/

_id_55BF(var_0) {
  if(_isvector(var_0)) {
    return _id_55BF(var_0[0]) || _id_55BF(var_0[1]) || _id_55BF(var_0[2]);
  } else if(_isnumber(var_0)) {
    return !(var_0 < 0 || var_0 > 0 || var_0 == 0);
  }

  return 0;
}

_id_562E(var_0) {
  return isDefined(var_0) && var_0;
}

noself_func(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.func)) {
    return;
  }
  if(!isDefined(level.func[var_0])) {
    return;
  }
  if(!isDefined(var_1)) {
    call[[level.func[var_0]]]();
    return;
  }

  if(!isDefined(var_2)) {
    call[[level.func[var_0]]](var_1);
    return;
  }

  if(!isDefined(var_3)) {
    call[[level.func[var_0]]](var_1, var_2);
    return;
  }

  if(!isDefined(var_4)) {
    call[[level.func[var_0]]](var_1, var_2, var_3);
    return;
  }

  call[[level.func[var_0]]](var_1, var_2, var_3, var_4);
}

getweaponheatlevel(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.func[var_0])) {
    return;
  }
  if(!isDefined(var_1)) {
    self call[[level.func[var_0]]]();
    return;
  }

  if(!isDefined(var_2)) {
    self call[[level.func[var_0]]](var_1);
    return;
  }

  if(!isDefined(var_3)) {
    self call[[level.func[var_0]]](var_1, var_2);
    return;
  }

  if(!isDefined(var_4)) {
    self call[[level.func[var_0]]](var_1, var_2, var_3);
    return;
  }

  self call[[level.func[var_0]]](var_1, var_2, var_3, var_4);
}

randomvector(var_0) {
  return (_randomfloat(var_0) - var_0 * 0.5, _randomfloat(var_0) - var_0 * 0.5, _randomfloat(var_0) - var_0 * 0.5);
}

randomvectorrange(var_0, var_1) {
  var_2 = _randomfloatrange(var_0, var_1);

  if(randomint(2) == 0) {
    var_2 = var_2 * -1;
  }

  var_3 = _randomfloatrange(var_0, var_1);

  if(randomint(2) == 0) {
    var_3 = var_3 * -1;
  }

  var_4 = _randomfloatrange(var_0, var_1);

  if(randomint(2) == 0) {
    var_4 = var_4 * -1;
  }

  return (var_2, var_3, var_4);
}

randomvectorincone(var_0, var_1) {
  var_2 = _randomfloat(var_1);
  var_3 = _randomfloat(360);
  var_4 = _sin(var_2);
  var_5 = _cos(var_2);
  var_6 = _sin(var_3);
  var_7 = _cos(var_3);
  var_8 = (var_5, var_7 * var_4, var_6 * var_4);
  return _rotatevector(var_8, vectortoangles(var_0));
}

sign(var_0) {
  if(var_0 >= 0) {
    return 1;
  }

  return -1;
}

mod(var_0, var_1) {
  var_2 = int(var_0 / var_1);

  if(var_0 * var_1 < 0) {
    var_2 = var_2 - 1;
  }

  return var_0 - var_2 * var_1;
}

tostring(var_0) {
  return "" + var_0;
}

track(var_0) {
  if(isDefined(self.current_target)) {
    if(var_0 == self.current_target) {
      return;
    }
  }

  self.current_target = var_0;
}

get_enemy_team(var_0) {
  var_1 = [];
  var_1["axis"] = "allies";
  var_1["allies"] = "axis";
  return var_1[var_0];
}

clear_exception(var_0) {
  self.exception[var_0] = anim.defaultexception;
}

set_exception(var_0, var_1) {
  self.exception[var_0] = var_1;
}

set_all_exceptions(var_0) {
  var_1 = getarraykeys(self.exception);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    self.exception[var_1[var_2]] = var_0;
  }
}

cointoss() {
  return randomint(100) >= 50;
}

choose_from_weighted_array(var_0, var_1) {
  var_2 = randomint(var_1[var_1.size - 1] + 1);

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(var_2 <= var_1[var_3]) {
      return var_0[var_3];
    }
  }
}

get_cumulative_weights(var_0) {
  var_1 = [];
  var_2 = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_2 = var_2 + var_0[var_3];
    var_1[var_3] = var_2;
  }

  return var_1;
}

_id_67EC(var_0, var_1) {
  wait(var_0);
  self notify(var_1);
}

waittill_string(var_0, var_1) {
  if(var_0 != "death") {
    self endon("death");
  }

  var_1 endon("die");
  self waittill(var_0);
  var_1 notify("returned", var_0, self);
}

waittill_string_parms(var_0, var_1) {
  if(var_0 != "death") {
    self endon("death");
  }

  var_1 endon("die");
  self waittill(var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  var_12 = [];
  var_12[0] = var_0;

  if(isDefined(var_2)) {
    var_12[1] = var_2;
  }

  if(isDefined(var_3)) {
    var_12[2] = var_3;
  }

  if(isDefined(var_4)) {
    var_12[3] = var_4;
  }

  if(isDefined(var_5)) {
    var_12[4] = var_5;
  }

  if(isDefined(var_6)) {
    var_12[5] = var_6;
  }

  if(isDefined(var_7)) {
    var_12[6] = var_7;
  }

  if(isDefined(var_8)) {
    var_12[7] = var_8;
  }

  if(isDefined(var_9)) {
    var_12[8] = var_9;
  }

  if(isDefined(var_10)) {
    var_12[9] = var_10;
  }

  if(isDefined(var_11)) {
    var_12[10] = var_11;
  }

  var_1 notify("returned", var_12, self);
}

waittill_string_no_endon_death(var_0, var_1) {
  var_1 endon("die");
  self waittill(var_0);
  var_1 notify("returned", var_0);
}

waittill_multiple(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5 = spawnStruct();
  var_5.threads = 0;

  if(isDefined(var_0)) {
    childthread waittill_string(var_0, var_5);
    var_5.threads++;
  }

  if(isDefined(var_1)) {
    childthread waittill_string(var_1, var_5);
    var_5.threads++;
  }

  if(isDefined(var_2)) {
    childthread waittill_string(var_2, var_5);
    var_5.threads++;
  }

  if(isDefined(var_3)) {
    childthread waittill_string(var_3, var_5);
    var_5.threads++;
  }

  if(isDefined(var_4)) {
    childthread waittill_string(var_4, var_5);
    var_5.threads++;
  }

  while(var_5.threads) {
    var_5 waittill("returned");
    var_5.threads--;
  }

  var_5 notify("die");
}

waittill_multiple_ents(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  var_8 = spawnStruct();
  var_8.threads = 0;

  if(isDefined(var_0)) {
    var_0 childthread waittill_string(var_1, var_8);
    var_8.threads++;
  }

  if(isDefined(var_2)) {
    var_2 childthread waittill_string(var_3, var_8);
    var_8.threads++;
  }

  if(isDefined(var_4)) {
    var_4 childthread waittill_string(var_5, var_8);
    var_8.threads++;
  }

  if(isDefined(var_6)) {
    var_6 childthread waittill_string(var_7, var_8);
    var_8.threads++;
  }

  while(var_8.threads) {
    var_8 waittill("returned");
    var_8.threads--;
  }

  var_8 notify("die");
}

_id_A748(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("death");
  var_9 = spawnStruct();
  var_9.threads = 0;

  if(isDefined(var_1)) {
    var_1 childthread waittill_string_no_endon_death(var_2, var_9);
    var_9.threads++;
  }

  if(isDefined(var_3)) {
    var_3 childthread waittill_string_no_endon_death(var_4, var_9);
    var_9.threads++;
  }

  if(isDefined(var_5)) {
    var_5 childthread waittill_string_no_endon_death(var_6, var_9);
    var_9.threads++;
  }

  if(isDefined(var_7)) {
    var_7 childthread waittill_string_no_endon_death(var_8, var_9);
    var_9.threads++;
  }

  var_10 = "ents_notified";

  while(var_9.threads) {
    if(isDefined(var_0)) {
      var_11 = var_9 waittill_notify_or_timeout_return("returned", var_0);

      if(isDefined(var_11) && var_11 == "timeout") {
        var_9.threads = 0;
        var_10 = "timeout";
      } else
        var_9.threads--;

      continue;
    }

    var_9 waittill("returned");
    var_9.threads--;
  }

  var_9 notify("die");
  return var_10;
}

waittill_any_return(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death") && (!isDefined(var_7) || var_7 != "death") && (!isDefined(var_8) || var_8 != "death")) {
    self endon("death");
  }

  var_9 = spawnStruct();

  if(isDefined(var_0)) {
    childthread waittill_string(var_0, var_9);
  }

  if(isDefined(var_1)) {
    childthread waittill_string(var_1, var_9);
  }

  if(isDefined(var_2)) {
    childthread waittill_string(var_2, var_9);
  }

  if(isDefined(var_3)) {
    childthread waittill_string(var_3, var_9);
  }

  if(isDefined(var_4)) {
    childthread waittill_string(var_4, var_9);
  }

  if(isDefined(var_5)) {
    childthread waittill_string(var_5, var_9);
  }

  if(isDefined(var_6)) {
    childthread waittill_string(var_6, var_9);
  }

  if(isDefined(var_7)) {
    childthread waittill_string(var_7, var_9);
  }

  if(isDefined(var_8)) {
    childthread waittill_string(var_8, var_9);
  }

  var_9 waittill("returned", var_10);
  var_9 notify("die");
  return var_10;
}

waittill_any_return_parms(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death") && (!isDefined(var_7) || var_7 != "death")) {
    self endon("death");
  }

  var_8 = spawnStruct();

  if(isDefined(var_0)) {
    childthread waittill_string_parms(var_0, var_8);
  }

  if(isDefined(var_1)) {
    childthread waittill_string_parms(var_1, var_8);
  }

  if(isDefined(var_2)) {
    childthread waittill_string_parms(var_2, var_8);
  }

  if(isDefined(var_3)) {
    childthread waittill_string_parms(var_3, var_8);
  }

  if(isDefined(var_4)) {
    childthread waittill_string_parms(var_4, var_8);
  }

  if(isDefined(var_5)) {
    childthread waittill_string_parms(var_5, var_8);
  }

  if(isDefined(var_6)) {
    childthread waittill_string_parms(var_6, var_8);
  }

  if(isDefined(var_7)) {
    childthread waittill_string_parms(var_7, var_8);
  }

  var_8 waittill("returned", var_9);
  var_8 notify("die");
  return var_9;
}

_id_A70F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16) {
  self endon("death");
  var_17 = spawnStruct();

  if((!isDefined(var_2) || var_2 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_6) || var_6 != "death") && (!isDefined(var_8) || var_8 != "death") && (!isDefined(var_10) || var_10 != "death") && (!isDefined(var_12) || var_12 != "death") && (!isDefined(var_14) || var_14 != "death") && (!isDefined(var_16) || var_16 != "death")) {
    self endon("death");
  }

  if(isDefined(var_1) && isDefined(var_2)) {
    var_1 childthread waittill_string_parms(var_2, var_17);
  }

  if(isDefined(var_3) && isDefined(var_4)) {
    var_3 childthread waittill_string_parms(var_4, var_17);
  }

  if(isDefined(var_5) && isDefined(var_6)) {
    var_5 childthread waittill_string_parms(var_6, var_17);
  }

  if(isDefined(var_7) && isDefined(var_8)) {
    var_7 childthread waittill_string_parms(var_8, var_17);
  }

  if(isDefined(var_9) && isDefined(var_10)) {
    var_9 childthread waittill_string_parms(var_10, var_17);
  }

  if(isDefined(var_11) && isDefined(var_12)) {
    var_11 childthread waittill_string_parms(var_12, var_17);
  }

  if(isDefined(var_13) && isDefined(var_14)) {
    var_13 childthread waittill_string_parms(var_14, var_17);
  }

  if(isDefined(var_15) && isDefined(var_16)) {
    var_15 childthread waittill_string_parms(var_16, var_17);
  }

  if(var_0 > 0) {
    childthread _id_A763(var_17, "returned", var_0);
  }

  var_17 waittill("returned", var_18, var_19);

  if(isDefined(var_18) && !_isarray(var_18) && var_18 == "timeout") {
    var_17 notify("die");
    return ["timeout", "timeout"];
  } else {
    var_17 notify("die");
    var_20 = _id_0F73([var_19], var_18);
    return var_20;
  }
}

_id_A719(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("death");

  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death") && (!isDefined(var_7) || var_7 != "death") && (!isDefined(var_8) || var_8 != "death")) {
    self endon("death");
  }

  var_9 = spawnStruct();

  if(isDefined(var_1)) {
    childthread waittill_string_parms(var_1, var_9);
  }

  if(isDefined(var_2)) {
    childthread waittill_string_parms(var_2, var_9);
  }

  if(isDefined(var_3)) {
    childthread waittill_string_parms(var_3, var_9);
  }

  if(isDefined(var_4)) {
    childthread waittill_string_parms(var_4, var_9);
  }

  if(isDefined(var_5)) {
    childthread waittill_string_parms(var_5, var_9);
  }

  if(isDefined(var_6)) {
    childthread waittill_string_parms(var_6, var_9);
  }

  if(isDefined(var_7)) {
    childthread waittill_string_parms(var_7, var_9);
  }

  if(isDefined(var_8)) {
    childthread waittill_string_parms(var_8, var_9);
  }

  childthread _id_A763(var_9, "returned", var_0);
  var_9 waittill("returned", var_10);

  if(isDefined(var_10) && !_isarray(var_10) && var_10 == "timeout") {
    var_9 notify("die");
    return ["timeout"];
  } else {
    var_9 notify("die");
    return var_10;
  }
}

_id_A763(var_0, var_1, var_2) {
  self endon(var_1);
  wait(var_2);
  var_0 notify("returned", "timeout");
}

waittill_any_return_no_endon_death(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();

  if(isDefined(var_0)) {
    childthread waittill_string_no_endon_death(var_0, var_7);
  }

  if(isDefined(var_1)) {
    childthread waittill_string_no_endon_death(var_1, var_7);
  }

  if(isDefined(var_2)) {
    childthread waittill_string_no_endon_death(var_2, var_7);
  }

  if(isDefined(var_3)) {
    childthread waittill_string_no_endon_death(var_3, var_7);
  }

  if(isDefined(var_4)) {
    childthread waittill_string_no_endon_death(var_4, var_7);
  }

  if(isDefined(var_5)) {
    childthread waittill_string_no_endon_death(var_5, var_7);
  }

  if(isDefined(var_6)) {
    childthread waittill_string_no_endon_death(var_6, var_7);
  }

  var_7 waittill("returned", var_8);
  var_7 notify("die");
  return var_8;
}

waittill_any_in_array_return(var_0) {
  var_1 = spawnStruct();
  var_2 = 0;

  foreach(var_4 in var_0) {
    childthread waittill_string(var_4, var_1);

    if(var_4 == "death") {
      var_2 = 1;
    }
  }

  if(!var_2) {
    self endon("death");
  }

  var_1 waittill("returned", var_6);
  var_1 notify("die");
  return var_6;
}

waittill_any_in_array_return_no_endon_death(var_0) {
  var_1 = spawnStruct();

  foreach(var_3 in var_0) {
    childthread waittill_string_no_endon_death(var_3, var_1);
  }

  var_1 waittill("returned", var_5);
  var_1 notify("die");
  return var_5;
}

waittill_any_in_array_or_timeout(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = 0;

  foreach(var_5 in var_0) {
    childthread waittill_string(var_5, var_2);

    if(var_5 == "death") {
      var_3 = 1;
    }
  }

  if(!var_3) {
    self endon("death");
  }

  var_2 childthread _id_0730(var_1);
  var_2 waittill("returned", var_7);
  var_2 notify("die");
  return var_7;
}

waittill_any_in_array_or_timeout_no_endon_death(var_0, var_1) {
  var_2 = spawnStruct();

  foreach(var_4 in var_0) {
    childthread waittill_string_no_endon_death(var_4, var_2);
  }

  var_2 thread _id_0730(var_1);
  var_2 waittill("returned", var_6);
  var_2 notify("die");
  return var_6;
}

waittill_any_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death")) {
    self endon("death");
  }

  var_7 = spawnStruct();

  if(isDefined(var_1)) {
    childthread waittill_string(var_1, var_7);
  }

  if(isDefined(var_2)) {
    childthread waittill_string(var_2, var_7);
  }

  if(isDefined(var_3)) {
    childthread waittill_string(var_3, var_7);
  }

  if(isDefined(var_4)) {
    childthread waittill_string(var_4, var_7);
  }

  if(isDefined(var_5)) {
    childthread waittill_string(var_5, var_7);
  }

  if(isDefined(var_6)) {
    childthread waittill_string(var_6, var_7);
  }

  var_7 childthread _id_0730(var_0);
  var_7 waittill("returned", var_8);
  var_7 notify("die");
  return var_8;
}

_id_0730(var_0) {
  self endon("die");
  wait(var_0);
  self notify("returned", "timeout");
}

waittill_any_timeout_no_endon_death(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();

  if(isDefined(var_1)) {
    childthread waittill_string_no_endon_death(var_1, var_6);
  }

  if(isDefined(var_2)) {
    childthread waittill_string_no_endon_death(var_2, var_6);
  }

  if(isDefined(var_3)) {
    childthread waittill_string_no_endon_death(var_3, var_6);
  }

  if(isDefined(var_4)) {
    childthread waittill_string_no_endon_death(var_4, var_6);
  }

  if(isDefined(var_5)) {
    childthread waittill_string_no_endon_death(var_5, var_6);
  }

  var_6 childthread _id_0730(var_0);
  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

waittill_any(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  if(isDefined(var_3)) {
    self endon(var_3);
  }

  if(isDefined(var_4)) {
    self endon(var_4);
  }

  if(isDefined(var_5)) {
    self endon(var_5);
  }

  if(isDefined(var_6)) {
    self endon(var_6);
  }

  if(isDefined(var_7)) {
    self endon(var_7);
  }

  self waittill(var_0);
}

wait_endon(var_0, var_1, var_2, var_3) {
  self endon(var_1);

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  if(isDefined(var_3)) {
    self endon(var_3);
  }

  wait(var_0);
}

waittill_any_ents(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(isDefined(var_2) && isDefined(var_3)) {
    var_2 endon(var_3);
  }

  if(isDefined(var_4) && isDefined(var_5)) {
    var_4 endon(var_5);
  }

  if(isDefined(var_6) && isDefined(var_7)) {
    var_6 endon(var_7);
  }

  if(isDefined(var_8) && isDefined(var_9)) {
    var_8 endon(var_9);
  }

  if(isDefined(var_10) && isDefined(var_11)) {
    var_10 endon(var_11);
  }

  if(isDefined(var_12) && isDefined(var_13)) {
    var_12 endon(var_13);
  }

  var_0 waittill(var_1);
}

_id_A70E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15) {
  var_16 = spawnStruct();

  if(isDefined(var_1)) {
    var_0 childthread waittill_string(var_1, var_16);
  }

  if(isDefined(var_3)) {
    var_2 childthread waittill_string(var_3, var_16);
  }

  if(isDefined(var_5)) {
    var_4 childthread waittill_string(var_5, var_16);
  }

  if(isDefined(var_7)) {
    var_6 childthread waittill_string(var_7, var_16);
  }

  if(isDefined(var_9)) {
    var_8 childthread waittill_string(var_9, var_16);
  }

  if(isDefined(var_11)) {
    var_10 childthread waittill_string(var_11, var_16);
  }

  if(isDefined(var_13)) {
    var_12 childthread waittill_string(var_13, var_16);
  }

  if(isDefined(var_15)) {
    var_14 childthread waittill_string(var_15, var_16);
  }

  var_16 waittill("returned", var_17, var_18);
  var_16 notify("die");
  return [var_17, var_18];
}

_id_A70D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(isDefined(var_3) && isDefined(var_4)) {
    var_3 endon(var_4);
  }

  if(isDefined(var_5) && isDefined(var_6)) {
    var_5 endon(var_6);
  }

  if(isDefined(var_7) && isDefined(var_8)) {
    var_7 endon(var_8);
  }

  if(isDefined(var_9) && isDefined(var_10)) {
    var_9 endon(var_10);
  }

  if(isDefined(var_11) && isDefined(var_12)) {
    var_11 endon(var_12);
  }

  if(isDefined(var_13) && isDefined(var_14)) {
    var_13 endon(var_14);
  }

  var_1 waittill_notify_or_timeout(var_2, var_0);
}

_id_A70B(var_0, var_1) {
  var_2 = spawnStruct();

  foreach(var_4 in var_0) {
    var_4 childthread waittill_string(var_1, var_2);
  }

  var_2 waittill("returned", var_6, var_7);
  var_2 notify("die");
  return var_7;
}

script_delay() {
  if(isDefined(self.script_delay) && self.script_delay > 0) {
    wait(self.script_delay);
    return 1;
  } else if(isDefined(self.script_delay_min) && isDefined(self.setbottomarc)) {
    wait(_randomfloatrange(self.script_delay_min, self.setbottomarc));
    return 1;
  }

  return 0;
}

_id_4B3F() {
  if(isDefined(self.script_delay)) {
    return 1;
  }

  if(isDefined(self.script_delay_min) && isDefined(self.setbottomarc)) {
    return 1;
  }

  return 0;
}

setautorotationdelay() {
  if(isDefined(self.setautorotationdelay)) {
    wait(self.setautorotationdelay);
    return 1;
  } else if(isDefined(self._id_8157) && isDefined(self.setdefaultdroppitch)) {
    wait(_randomfloatrange(self._id_8157, self.setdefaultdroppitch));
    return 1;
  }

  return 0;
}

script_wait() {
  var_0 = gettime();

  if(isDefined(self.script_wait)) {
    wait(self.script_wait);

    if(isDefined(self.playfx)) {
      self.script_wait = self.script_wait + self.playfx;
    }
  } else if(isDefined(self.playerrecoilscaleoff) && isDefined(self.playerrecoilscaleon)) {
    wait(_randomfloatrange(self.playerrecoilscaleoff, self.playerrecoilscaleon));

    if(isDefined(self.playfx)) {
      self.playerrecoilscaleoff = self.playerrecoilscaleoff + self.playfx;
      self.playerrecoilscaleon = self.playerrecoilscaleon + self.playfx;
    }
  }

  return gettime() - var_0;
}

_id_0F91(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(self)) {
    self endon("death");
    self endon("array_random_iterate_stop");
  }

  if(isDefined(var_10)) {
    level endon(var_10);
  }

  var_11 = [];

  foreach(var_14, var_13 in var_0) {
    var_11[var_11.size] = var_13;
  }

  var_15 = 0;

  while(!(isDefined(var_9) && var_9 == 1)) {
    if(var_15) {
      waitframe();

      if(var_2 <= var_1) {
        wait(var_1);
      } else {
        wait(_randomfloatrange(var_1, var_2));
      }
    }

    var_15 = 1;
    var_16 = var_11.size;

    while(var_16 > 0) {
      var_17 = randomint(var_16);
      var_18 = var_11[var_17];
      var_16 = var_16 - 1;
      var_11[var_17] = var_11[var_16];
      var_11[var_16] = var_18;

      if(!isDefined(var_5)) {
        if(!isDefined(var_4)) {
          var_19 = [[var_3]](var_18);
        } else {
          var_19 = var_4[[var_3]](var_18);
        }
      } else if(!isDefined(var_6)) {
        if(!isDefined(var_4)) {
          var_19 = [[var_3]](var_18, var_5);
        } else {
          var_19 = var_4[[var_3]](var_18, var_5);
        }
      } else if(!isDefined(var_7)) {
        if(!isDefined(var_4)) {
          var_19 = [[var_3]](var_18, var_5, var_6);
        } else {
          var_19 = var_4[[var_3]](var_18, var_5, var_6);
        }
      } else if(!isDefined(var_8)) {
        if(!isDefined(var_4)) {
          var_19 = [[var_3]](var_18, var_5, var_6, var_7);
        } else {
          var_19 = var_4[[var_3]](var_18, var_5, var_6, var_7);
        }
      } else if(!isDefined(var_4))
        var_19 = [[var_3]](var_18, var_5, var_6, var_7, var_8);
      else {
        var_19 = var_4[[var_3]](var_18, var_5, var_6, var_7, var_8);
      }

      if(!isDefined(var_19) || var_19) {
        var_15 = 0;

        if(var_2 <= var_1) {
          wait(var_1);
          continue;
        }

        wait(_randomfloatrange(var_1, var_2));
      }
    }
  }
}

_id_56F4() {
  var_0 = gettime();

  if(isDefined(self.flashendtime) && var_0 < self.flashendtime) {
    return 1;
  }

  return 0;
}

_id_56B5() {
  var_0 = gettime();

  if(isDefined(self.concussionendtime) && var_0 < self.concussionendtime) {
    return 1;
  }

  return 0;
}

_id_56F2() {
  var_0 = gettime();

  if(isDefined(self._id_3D39) && var_0 < self._id_3D39) {
    return 1;
  }

  return 0;
}

_id_5701() {
  var_0 = gettime();

  if(isDefined(self._id_3FE5) && var_0 < self._id_3FE5) {
    return 1;
  }

  return 0;
}

_id_57D0() {
  var_0 = gettime();

  if(isDefined(self._id_8C5E) && var_0 < self._id_8C5E) {
    return 1;
  }

  if(isDefined(self._id_8C5B) && var_0 < self._id_8C5B) {
    return 1;
  }

  return 0;
}

flag_exist(var_0) {
  return isDefined(level.flag[var_0]);
}

flag(var_0) {
  return level.flag[var_0];
}

_id_3C89(var_0) {
  if(!flag_exist(var_0)) {
    return 0;
  }

  return flag(var_0);
}

init_flags() {
  level.flag = [];
  level.flags_lock = [];
  level.generic_index = 0;

  if(!isDefined(level.sp_stat_tracking_func)) {
    level.sp_stat_tracking_func = ::empty_init_func;
  }

  level.flag_struct = spawnStruct();
  level.flag_struct assign_unique_id();
}

flag_init(var_0) {
  if(!isDefined(level.flag)) {
    init_flags();
  }

  level.flag[var_0] = 0;

  if(!isDefined(level.trigger_flags)) {
    init_trigger_flags();
    level.trigger_flags[var_0] = [];
  } else if(!isDefined(level.trigger_flags[var_0]))
    level.trigger_flags[var_0] = [];

  if(_id_578E(var_0, "aa_")) {
    thread[[level.sp_stat_tracking_func]](var_0);
  }
}

empty_init_func(var_0) {}

_id_57E9(var_0, var_1, var_2, var_3) {
  if(var_1.size > var_0.size) {
    return 0;
  }

  var_4 = getsubstr(var_0, var_2, var_3);
  return var_4 == var_1;
}

_id_578E(var_0, var_1) {
  return _id_57E9(var_0, var_1, 0, var_1.size);
}

_id_57EF(var_0, var_1) {
  return _id_57E9(var_0, var_1, var_0.size - var_1.size, var_0.size);
}

flag_set(var_0, var_1) {
  level.flag[var_0] = 1;
  set_trigger_flag_permissions(var_0);

  if(isDefined(var_1)) {
    level notify(var_0, var_1);
  } else {
    level notify(var_0);
  }
}

assign_unique_id() {
  self.unique_id = "generic" + level.generic_index;
  level.generic_index++;
}

flag_wait(var_0) {
  var_1 = undefined;

  while(!flag(var_0)) {
    var_1 = undefined;
    level waittill(var_0, var_1);
  }

  if(isDefined(var_1)) {
    return var_1;
  }
}

flag_clear(var_0, var_1) {
  if(!flag(var_0)) {
    return;
  }
  level.flag[var_0] = 0;
  set_trigger_flag_permissions(var_0);

  if(isDefined(var_1)) {
    level notify(var_0, var_1);
  } else {
    level notify(var_0);
  }
}

flag_waitopen(var_0) {
  var_1 = undefined;

  while(flag(var_0)) {
    var_1 = undefined;
    level waittill(var_0, var_1);
  }

  if(isDefined(var_1)) {
    return var_1;
  }
}

ent_flag_init(var_0) {
  if(!isDefined(self.ent_flag)) {
    self.ent_flag = [];
    self._id_37A3 = [];
  }

  self.ent_flag[var_0] = 0;
}

ent_flag_exist(var_0) {
  if(isDefined(self.ent_flag) && isDefined(self.ent_flag[var_0])) {
    return 1;
  }

  return 0;
}

_id_379B(var_0, var_1) {
  self endon("death");
  wait(var_1);
  ent_flag_set(var_0);
}

ent_flag_set(var_0) {
  self.ent_flag[var_0] = 1;
  self notify(var_0);
}

ent_flag_clear(var_0, var_1) {
  if(self.ent_flag[var_0]) {
    self.ent_flag[var_0] = 0;
    self notify(var_0);
  }

  if(isDefined(var_1) && var_1) {
    self.ent_flag[var_0] = undefined;
  }
}

_id_3797(var_0, var_1) {
  wait(var_1);
  ent_flag_clear(var_0);
}

ent_flag(var_0) {
  return self.ent_flag[var_0];
}

ent_flag_wait(var_0) {
  while(isDefined(self) && !self.ent_flag[var_0]) {
    self waittill(var_0);
  }
}

_id_37A0(var_0) {
  while(isDefined(self) && !self.ent_flag[var_0]) {
    self waittill(var_0);
  }
}

_id_379E(var_0, var_1) {
  while(isDefined(self)) {
    if(ent_flag(var_0)) {
      return;
    }
    if(ent_flag(var_1)) {
      return;
    }
    waittill_either(var_0, var_1);
  }
}

_id_379F(var_0, var_1) {
  var_2 = gettime();

  while(isDefined(self)) {
    if(self.ent_flag[var_0]) {
      break;
    }

    if(gettime() >= var_2 + var_1 * 1000) {
      break;
    }

    _id_37AF(var_0, var_1);
  }
}

_id_37AF(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

ent_flag_waitopen(var_0) {
  while(isDefined(self) && self.ent_flag[var_0]) {
    self waittill(var_0);
  }
}

_id_3795(var_0) {}

_id_37A2(var_0, var_1) {
  while(isDefined(self)) {
    if(!ent_flag(var_0)) {
      return;
    }
    if(!ent_flag(var_1)) {
      return;
    }
    waittill_either(var_0, var_1);
  }
}

waittill_either(var_0, var_1) {
  self endon(var_0);
  self waittill(var_1);
}

_id_0FB2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(var_10)) {
    foreach(var_12 in var_0) {
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    }
  } else {
    if(isDefined(var_9)) {
      foreach(var_12 in var_0) {
        var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
      }

      return;
    }

    if(isDefined(var_8)) {
      foreach(var_12 in var_0) {
        var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
      }

      return;
    }

    if(isDefined(var_7)) {
      foreach(var_12 in var_0) {
        var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7);
      }

      return;
    }

    if(isDefined(var_6)) {
      foreach(var_12 in var_0) {
        var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6);
      }

      return;
    }

    if(isDefined(var_5)) {
      foreach(var_12 in var_0) {
        var_12 thread[[var_1]](var_2, var_3, var_4, var_5);
      }

      return;
    }

    if(isDefined(var_4)) {
      foreach(var_12 in var_0) {
        var_12 thread[[var_1]](var_2, var_3, var_4);
      }

      return;
    }

    if(isDefined(var_3)) {
      foreach(var_12 in var_0) {
        var_12 thread[[var_1]](var_2, var_3);
      }

      return;
    }

    if(isDefined(var_2)) {
      foreach(var_12 in var_0) {
        var_12 thread[[var_1]](var_2);
      }

      return;
    }

    foreach(var_12 in var_0) {
      var_12 thread[[var_1]]();
    }
  }
}

_id_0F71(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_5)) {
    foreach(var_7 in var_0) {
      var_7 call[[var_1]](var_2, var_3, var_4, var_5);
    }

    return;
  }

  if(isDefined(var_4)) {
    foreach(var_7 in var_0) {
      var_7 call[[var_1]](var_2, var_3, var_4);
    }

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_7 in var_0) {
      var_7 call[[var_1]](var_2, var_3);
    }

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_7 in var_0) {
      var_7 call[[var_1]](var_2);
    }

    return;
  }

  foreach(var_7 in var_0) {
    var_7 call[[var_1]]();
  }
}

noself_array_call(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    foreach(var_6 in var_0) {
      call[[var_1]](var_6, var_2, var_3, var_4);
    }

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_6 in var_0) {
      call[[var_1]](var_6, var_2, var_3);
    }

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_6 in var_0) {
      call[[var_1]](var_6, var_2);
    }

    return;
  }

  foreach(var_6 in var_0) {
    call[[var_1]](var_6);
  }
}

_id_0FB5(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_0FB2(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_0FB6(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_0FB2(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

trigger_on(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = getEntArray(var_0, var_1);
    _id_0FB2(var_2, ::trigger_on_proc);
  } else
    trigger_on_proc();
}

trigger_on_proc() {
  if(isDefined(self.realorigin)) {
    self.origin = self.realorigin;
  }

  self.trigger_off = undefined;
}

trigger_off(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = getEntArray(var_0, var_1);
    _id_0FB2(var_2, ::trigger_off_proc);
  } else
    trigger_off_proc();
}

trigger_off_proc() {
  if(!isDefined(self.realorigin)) {
    self.realorigin = self.origin;
  }

  if(self.origin == self.realorigin) {
    self.origin = self.origin + (0, 0, -10000);
  }

  self.trigger_off = 1;
}

set_trigger_flag_permissions(var_0) {
  if(!isDefined(level.trigger_flags)) {
    return;
  }
  level.trigger_flags[var_0] = _id_0FA0(level.trigger_flags[var_0]);
  _id_0FB2(level.trigger_flags[var_0], ::update_trigger_based_on_flags);
}

update_trigger_based_on_flags() {
  var_0 = 1;

  if(isDefined(self.setgoalnode)) {
    var_0 = 0;
    var_1 = create_flags_and_return_tokens(self.setgoalnode);

    foreach(var_3 in var_1) {
      if(flag(var_3)) {
        var_0 = 1;
        break;
      }
    }
  }

  var_5 = 1;

  if(isDefined(self.pushplayer)) {
    var_1 = create_flags_and_return_tokens(self.pushplayer);

    foreach(var_3 in var_1) {
      if(flag(var_3)) {
        var_5 = 0;
        break;
      }
    }
  }

  [[level.trigger_func[var_0 && var_5]]]();
}

create_flags_and_return_tokens(var_0) {
  var_1 = strtok(var_0, " ");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isDefined(level.flag[var_1[var_2]])) {
      flag_init(var_1[var_2]);
    }
  }

  return var_1;
}

init_trigger_flags() {
  level.trigger_flags = [];
  level.trigger_func[1] = ::trigger_on;
  level.trigger_func[0] = ::trigger_off;
}

get_trigger_flag() {
  if(isDefined(self.getnegotiationnextnode)) {
    return self.getnegotiationnextnode;
  }
}

getstruct(var_0, var_1) {
  var_2 = level.struct_class_names[var_1][var_0];

  if(!isDefined(var_2)) {
    return undefined;
  }

  if(var_2.size > 1) {
    return undefined;
  }

  return var_2[0];
}

getstructarray(var_0, var_1) {
  var_2 = level.struct_class_names[var_1][var_0];

  if(!isDefined(var_2)) {
    return [];
  }

  return var_2;
}

getent_or_struct(var_0, var_1) {
  var_2 = _getEnt(var_0, var_1);

  if(isDefined(var_2)) {
    return var_2;
  }

  return getstruct(var_0, var_1);
}

_id_44BE(var_0, var_1) {
  var_2 = getstructarray(var_0, var_1);
  var_3 = getEntArray(var_0, var_1);

  if(var_3.size > 0) {
    var_2 = _id_0F73(var_2, var_3);
  }

  return var_2;
}

_id_44BF(var_0, var_1) {
  var_2 = getent_or_struct(var_0, var_1);

  if(!isDefined(var_2)) {
    var_2 = _getnode(var_0, var_1);
  }

  if(!isDefined(var_2)) {
    var_2 = _getvehiclenode(var_0, var_1);
  }

  return var_2;
}

_id_44C0(var_0, var_1) {
  var_2 = getstructarray(var_0, var_1);
  var_3 = getEntArray(var_0, var_1);

  if(var_3.size > 0) {
    var_2 = _id_0F73(var_2, var_3);
  }

  var_3 = _getnodearray(var_0, var_1);

  if(var_3.size > 0) {
    var_2 = _id_0F73(var_2, var_3);
  }

  var_3 = _getvehiclenodearray(var_0, var_1);

  if(var_3.size > 0) {
    var_2 = _id_0F73(var_2, var_3);
  }

  return var_2;
}

_id_947B() {
  level.struct_class_names = [];
  level.struct_class_names["target"] = [];
  level.struct_class_names["targetname"] = [];
  level.struct_class_names["script_noteworthy"] = [];
  level.struct_class_names["script_linkname"] = [];

  foreach(var_1 in level.struct) {
    _id_096C(var_1);
  }
}

_id_096C(var_0) {
  if(isDefined(var_0.targetname)) {
    if(!isDefined(level.struct_class_names["targetname"][var_0.targetname])) {
      level.struct_class_names["targetname"][var_0.targetname] = [];
    }

    var_1 = level.struct_class_names["targetname"][var_0.targetname].size;
    level.struct_class_names["targetname"][var_0.targetname][var_1] = var_0;
  }

  if(isDefined(var_0.target)) {
    if(!isDefined(level.struct_class_names["target"][var_0.target])) {
      level.struct_class_names["target"][var_0.target] = [];
    }

    var_1 = level.struct_class_names["target"][var_0.target].size;
    level.struct_class_names["target"][var_0.target][var_1] = var_0;
  }

  if(isDefined(var_0._id_0165)) {
    if(!isDefined(level.struct_class_names["script_noteworthy"][var_0._id_0165])) {
      level.struct_class_names["script_noteworthy"][var_0._id_0165] = [];
    }

    var_1 = level.struct_class_names["script_noteworthy"][var_0._id_0165].size;
    level.struct_class_names["script_noteworthy"][var_0._id_0165][var_1] = var_0;
  }

  if(isDefined(var_0._id_0164)) {
    if(!isDefined(level.struct_class_names["script_linkname"][var_0._id_0164])) {
      level.struct_class_names["script_linkname"][var_0._id_0164] = [];
    }

    var_1 = level.struct_class_names["script_linkname"][var_0._id_0164].size;
    level.struct_class_names["script_linkname"][var_0._id_0164][var_1] = var_0;
  }
}

_id_3ABC(var_0) {}

fileprint_map_start() {}

fileprint_map_header(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }
}

fileprint_map_keypairprint(var_0, var_1) {}

fileprint_map_entity_start() {}

fileprint_map_entity_end() {}

fileprint_radiant_vec(var_0) {}

_id_0F93(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(var_4 != var_1) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_0F7D(var_0, var_1) {
  var_2 = var_0;
  var_2 = _id_0F94(var_2, var_1);
  return var_2;
}

_id_0F94(var_0, var_1) {
  foreach(var_3 in var_1) {
    var_0 = _id_0F93(var_0, var_3);
  }

  return var_0;
}

_id_0F98(var_0, var_1) {
  if(!isDefined(var_1)) {
    return undefined;
  }

  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(isDefined(var_0)) {
      if(var_0 != var_4) {
        var_2[var_2.size] = var_4;
      }

      continue;
    }

    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_0FA0(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_0F97(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = 1;

    foreach(var_6 in var_1) {
      if(var_3 == var_6) {
        var_4 = 0;
        break;
      }
    }

    if(var_4) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_0F8A(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    foreach(var_6 in var_0) {
      thread[[var_1]](var_6, var_2, var_3, var_4);
    }

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_6 in var_0) {
      thread[[var_1]](var_6, var_2, var_3);
    }

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_6 in var_0) {
      thread[[var_1]](var_6, var_2);
    }

    return;
  }

  foreach(var_6 in var_0) {
    thread[[var_1]](var_6);
  }
}

_id_0F89(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    foreach(var_6 in var_0) {
      call[[var_1]](var_6, var_2, var_3, var_4);
    }

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_6 in var_0) {
      call[[var_1]](var_6, var_2, var_3);
    }

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_6 in var_0) {
      call[[var_1]](var_6, var_2);
    }

    return;
  }

  foreach(var_6 in var_0) {
    call[[var_1]](var_6);
  }
}

_id_0F8C(var_0, var_1) {
  if(var_0.size == 0) {
    return var_1;
  }

  if(var_1.size == 0) {
    return var_0;
  }

  var_2 = var_0;

  foreach(var_4 in var_1) {
    var_5 = 0;

    foreach(var_7 in var_0) {
      if(var_7 == var_4) {
        var_5 = 1;
        break;
      }
    }

    if(var_5) {
      continue;
    } else {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_0972(var_0, var_1) {
  if(!isDefined(var_1)) {
    return var_0;
  }

  if(!isDefined(var_0)) {
    var_0[0] = var_1;
  } else {
    var_0[var_0.size] = var_1;
  }

  return var_0;
}

_id_0FA3(var_0, var_1, var_2) {
  if(var_0.size <= 0) {
    return [];
  }

  if(!isDefined(var_2) || var_2 > var_0.size) {
    var_2 = var_0.size;
  }

  if(var_1 == 0 && var_2 == var_0.size) {
    return var_0;
  }

  var_3 = [];

  for(var_4 = var_1; var_4 < var_2; var_4++) {
    var_3[var_3.size] = var_0[var_4];
  }

  return var_3;
}

flag_assert(var_0) {}

flag_wait_either(var_0, var_1) {
  for(;;) {
    if(flag(var_0)) {
      return;
    }
    if(flag(var_1)) {
      return;
    }
    level waittill_either(var_0, var_1);
  }
}

flag_wait_either_return(var_0, var_1) {
  for(;;) {
    if(flag(var_0)) {
      return var_0;
    }

    if(flag(var_1)) {
      return var_1;
    }

    var_2 = level waittill_any_return(var_0, var_1);
    return var_2;
  }
}

flag_waitopen_either(var_0, var_1) {
  for(;;) {
    if(!flag(var_0)) {
      return var_0;
    }

    if(!flag(var_1)) {
      return var_1;
    }

    level waittill_either(var_0, var_1);
  }
}

flag_waitopen_either_return(var_0, var_1) {
  return flag_waitopen_either(var_0, var_1);
}

_id_3CA3(var_0) {
  foreach(var_2 in var_0) {
    if(flag(var_2)) {
      return var_2;
    }
  }

  return level waittill_any_in_array_return(var_0);
}

flag_wait_any(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];

  if(isDefined(var_5)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
    var_6[var_6.size] = var_3;
    var_6[var_6.size] = var_4;
    var_6[var_6.size] = var_5;
  } else if(isDefined(var_4)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
    var_6[var_6.size] = var_3;
    var_6[var_6.size] = var_4;
  } else if(isDefined(var_3)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
    var_6[var_6.size] = var_3;
  } else if(isDefined(var_2)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
  } else if(isDefined(var_1)) {
    flag_wait_either(var_0, var_1);
    return;
  } else
    return;

  for(;;) {
    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      if(flag(var_6[var_7])) {
        return;
      }
    }

    level waittill_any(var_0, var_1, var_2, var_3, var_4, var_5);
  }
}

flag_wait_any_return(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];

  if(isDefined(var_4)) {
    var_5[var_5.size] = var_0;
    var_5[var_5.size] = var_1;
    var_5[var_5.size] = var_2;
    var_5[var_5.size] = var_3;
    var_5[var_5.size] = var_4;
  } else if(isDefined(var_3)) {
    var_5[var_5.size] = var_0;
    var_5[var_5.size] = var_1;
    var_5[var_5.size] = var_2;
    var_5[var_5.size] = var_3;
  } else if(isDefined(var_2)) {
    var_5[var_5.size] = var_0;
    var_5[var_5.size] = var_1;
    var_5[var_5.size] = var_2;
  } else if(isDefined(var_1)) {
    var_6 = flag_wait_either_return(var_0, var_1);
    return var_6;
  } else
    return;

  for(;;) {
    for(var_7 = 0; var_7 < var_5.size; var_7++) {
      if(flag(var_5[var_7])) {
        return var_5[var_7];
      }
    }

    var_6 = level waittill_any_return(var_0, var_1, var_2, var_3, var_4);
    return var_6;
  }
}

flag_wait_all(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    flag_wait(var_0);
  }

  if(isDefined(var_1)) {
    flag_wait(var_1);
  }

  if(isDefined(var_2)) {
    flag_wait(var_2);
  }

  if(isDefined(var_3)) {
    flag_wait(var_3);
  }
}

_id_3CA1(var_0) {
  var_0 = _id_0FA0(var_0);

  for(;;) {
    foreach(var_2 in var_0) {
      flag_wait(var_2);
    }

    var_4 = 0;

    foreach(var_2 in var_0) {
      if(flag(var_2)) {
        var_4++;
      }
    }

    if(var_4 == var_0.size) {
      break;
    }
  }
}

flag_wait_or_timeout(var_0, var_1) {
  var_2 = var_1 * 1000;
  var_3 = gettime();

  for(;;) {
    if(flag(var_0)) {
      break;
    }

    if(gettime() >= var_3 + var_2) {
      break;
    }

    var_4 = var_2 - (gettime() - var_3);
    var_5 = var_4 / 1000;
    wait_for_flag_or_time_elapses(var_0, var_5);
  }
}

flag_waitopen_or_timeout(var_0, var_1) {
  var_2 = gettime();

  for(;;) {
    if(!flag(var_0)) {
      break;
    }

    if(gettime() >= var_2 + var_1 * 1000) {
      break;
    }

    wait_for_flag_or_time_elapses(var_0, var_1);
  }
}

wait_for_flag_or_time_elapses(var_0, var_1) {
  level endon(var_0);
  wait(var_1);
}

delaycall(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  thread delaycall_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

delaycall_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(issp()) {
    self endon("death");
    self endon("stop_delay_call");
  }

  wait(var_1);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_10)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  } else if(isDefined(var_9)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  } else if(isDefined(var_8)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  } else if(isDefined(var_7)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  } else if(isDefined(var_6)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6);
  } else if(isDefined(var_5)) {
    self call[[var_0]](var_2, var_3, var_4, var_5);
  } else if(isDefined(var_4)) {
    self call[[var_0]](var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    self call[[var_0]](var_2, var_3);
  } else if(isDefined(var_2)) {
    self call[[var_0]](var_2);
  } else {
    self call[[var_0]]();
  }
}

_id_2CB7(var_0) {
  self endon("death");
  self notify("cancel_delayed_show");
  self endon("cancel_delayed_show");

  if(isDefined(var_0) && var_0 > 0) {
    wait(var_0);
  }

  if(isDefined(self)) {
    self show();
  }
}

delay_script_call(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  thread delay_script_call_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

delay_script_call_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  wait(var_1);

  if(isDefined(var_10)) {
    self[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  } else if(isDefined(var_9)) {
    self[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  } else if(isDefined(var_8)) {
    self[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  } else if(isDefined(var_7)) {
    self[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  } else if(isDefined(var_6)) {
    self[[var_0]](var_2, var_3, var_4, var_5, var_6);
  } else if(isDefined(var_5)) {
    self[[var_0]](var_2, var_3, var_4, var_5);
  } else if(isDefined(var_4)) {
    self[[var_0]](var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    self[[var_0]](var_2, var_3);
  } else if(isDefined(var_2)) {
    self[[var_0]](var_2);
  } else {
    self[[var_0]]();
  }
}

makeentitysentient(var_0) {
  switch (var_0.size) {
    case 1:
      return self[[var_0[0]]]();
    case 2:
      return self[[var_0[0]]](var_0[1]);
    case 3:
      return self[[var_0[0]]](var_0[1], var_0[2]);
    case 4:
      return self[[var_0[0]]](var_0[1], var_0[2], var_0[3]);
    case 5:
      return self[[var_0[0]]](var_0[1], var_0[2], var_0[3], var_0[4]);
    case 6:
      return self[[var_0[0]]](var_0[1], var_0[2], var_0[3], var_0[4], var_0[5]);
    case 7:
      return self[[var_0[0]]](var_0[1], var_0[2], var_0[3], var_0[4], var_0[5], var_0[6]);
    case 8:
      return self[[var_0[0]]](var_0[1], var_0[2], var_0[3], var_0[4], var_0[5], var_0[6], var_0[7]);
    default:
      return;
  }
}

maketurretinoperable(var_0, var_1) {
  if(!isDefined(var_1) || var_1.size == 0) {
    self[[var_0]]();
  } else {
    switch (var_1.size) {
      case 1:
        self[[var_0]](var_1[0]);
        break;
      case 2:
        self[[var_0]](var_1[0], var_1[1]);
        break;
      case 3:
        self[[var_0]](var_1[0], var_1[1], var_1[2]);
        break;
      case 4:
        self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3]);
        break;
      case 5:
        self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4]);
        break;
      case 6:
        self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5]);
        break;
      case 7:
        self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6]);
        break;
      case 8:
        self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7]);
        break;
      default:
        break;
    }
  }
}

_id_248D(var_0) {
  switch (var_0.size) {
    case 1:
      return call[[var_0[0]]]();
    case 2:
      return call[[var_0[0]]](var_0[1]);
    case 3:
      return call[[var_0[0]]](var_0[1], var_0[2]);
    case 4:
      return call[[var_0[0]]](var_0[1], var_0[2], var_0[3]);
    case 5:
      return call[[var_0[0]]](var_0[1], var_0[2], var_0[3], var_0[4]);
    case 6:
      return call[[var_0[0]]](var_0[1], var_0[2], var_0[3], var_0[4], var_0[5]);
    case 7:
      return call[[var_0[0]]](var_0[1], var_0[2], var_0[3], var_0[4], var_0[5], var_0[6]);
    case 8:
      return call[[var_0[0]]](var_0[1], var_0[2], var_0[3], var_0[4], var_0[5], var_0[6], var_0[7]);
    default:
      return;
  }
}

noself_delaycall(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread noself_delaycall_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

noself_delaycall_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  wait(var_1);

  if(isDefined(var_7)) {
    call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  } else if(isDefined(var_6)) {
    call[[var_0]](var_2, var_3, var_4, var_5, var_6);
  } else if(isDefined(var_5)) {
    call[[var_0]](var_2, var_3, var_4, var_5);
  } else if(isDefined(var_4)) {
    call[[var_0]](var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    call[[var_0]](var_2, var_3);
  } else if(isDefined(var_2)) {
    call[[var_0]](var_2);
  } else {
    call[[var_0]]();
  }
}

issp() {
  if(!isDefined(level.issp)) {
    level.issp = !string_starts_with(getDvar("1673"), "mp_");
  }

  return level.issp;
}

issp_towerdefense() {
  if(!isDefined(level.issp_towerdefense)) {
    level.issp_towerdefense = string_starts_with(getDvar("1673"), "so_td_");
  }

  return level.issp_towerdefense;
}

string_starts_with(var_0, var_1) {
  if(var_0.size < var_1.size) {
    return 0;
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(_tolower(var_0[var_2]) != _tolower(var_1[var_2])) {
      return 0;
    }
  }

  return 1;
}

string_find(var_0, var_1) {
  if(var_0.size < var_1.size) {
    return -1;
  }

  if(var_1.size == 0) {
    return 0;
  }

  var_2 = 0;

  for(var_3 = 0; var_2 < var_0.size; var_2++) {
    if(_tolower(var_0[var_2]) == _tolower(var_1[var_3])) {
      var_3++;
    } else {
      var_3 = 0;

      if(_tolower(var_0[var_2]) == _tolower(var_1[var_3])) {
        var_3++;
      } else if(var_2 > var_0.size - var_1.size) {
        return -1;
      }
    }

    if(var_3 >= var_1.size) {
      return var_2 - var_3 + 1;
    }
  }

  return -1;
}

plot_points(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0[0];

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(!isDefined(var_4)) {
    var_4 = 0.05;
  }

  for(var_6 = 1; var_6 < var_0.size; var_6++) {
    thread draw_line_for_time(var_5, var_0[var_6], var_1, var_2, var_3, var_4);
    var_5 = var_0[var_6];
  }
}

draw_line_for_time(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_6)) {
    var_6 = 0;
  }
}

table_combine(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    var_2[var_5] = var_4;
  }

  foreach(var_5, var_4 in var_1) {
    var_2[var_5] = var_4;
  }

  return var_2;
}

_id_0F73(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = [];

  foreach(var_5 in var_0) {
    if(isDefined(var_5) || var_2) {
      var_3[var_3.size] = var_5;
    }
  }

  foreach(var_5 in var_1) {
    if(isDefined(var_5) || var_2) {
      var_3[var_3.size] = var_5;
    }
  }

  return var_3;
}

_id_0F76(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    var_2[var_5] = var_4;
  }

  foreach(var_5, var_4 in var_1) {
    var_2[var_5] = var_4;
  }

  return var_2;
}

array_randomize(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = randomint(var_0.size);
    var_3 = var_0[var_1];
    var_0[var_1] = var_0[var_2];
    var_0[var_2] = var_3;
  }

  return var_0;
}

_id_0F6F(var_0, var_1) {
  var_0[var_0.size] = var_1;
  return var_0;
}

_id_0F82(var_0) {
  var_1 = undefined;

  foreach(var_3 in var_0) {
    var_1 = var_3;
    break;
  }

  return var_1;
}

_id_0F88(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  foreach(var_6, var_5 in var_0) {
    if(var_3 < var_1) {
      var_2[var_6] = var_5;
    } else {
      break;
    }

    var_3++;
  }

  return var_2;
}

_id_0F86(var_0, var_1, var_2) {
  if(var_2 == var_0.size) {
    var_3 = var_0;
    var_3[var_3.size] = var_1;
    return var_3;
  }

  var_3 = [];
  var_4 = 0;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    if(var_5 == var_2) {
      var_3[var_5] = var_1;
      var_4 = 1;
    }

    var_3[var_5 + var_4] = var_0[var_5];
  }

  return var_3;
}

_id_0F9B(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(var_0[var_3] != var_1) {
      var_2[var_2.size] = var_0[var_3];
    }
  }

  return var_2;
}

_id_0F9A(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size - 1; var_2++) {
    if(var_2 == var_1) {
      var_0[var_2] = var_0[var_2 + 1];
      var_1++;
    }
  }

  var_0[var_0.size - 1] = undefined;
  return var_0;
}

_id_0F8E(var_0, var_1, var_2) {
  foreach(var_5, var_4 in var_0) {
    var_4 notify(var_1, var_2);
  }
}

_id_0F79(var_0, var_1) {
  if(var_0.size <= 0) {
    return 0;
  }

  foreach(var_3 in var_0) {
    if(var_3 == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_0F7E(var_0, var_1) {
  foreach(var_4, var_3 in var_0) {
    if(var_3 == var_1) {
      return var_4;
    }
  }

  return undefined;
}

_id_0F78(var_0, var_1) {
  if(var_0.size != var_1.size) {
    return 0;
  }

  foreach(var_5, var_3 in var_0) {
    if(!isDefined(var_1[var_5])) {
      return 0;
    }

    var_4 = var_1[var_5];

    if(var_4 != var_3) {
      return 0;
    }
  }

  return 1;
}

flat_angle(var_0) {
  var_1 = (0, var_0[1], 0);
  return var_1;
}

flat_origin(var_0) {
  var_1 = (var_0[0], var_0[1], 0);
  return var_1;
}

draw_arrow_time(var_0, var_1, var_2, var_3) {
  level endon("newpath");
  var_4 = [];
  var_5 = vectortoangles(var_0 - var_1);
  var_6 = anglestoright(var_5);
  var_7 = anglesToForward(var_5);
  var_8 = anglestoup(var_5);
  var_9 = distance(var_0, var_1);
  var_10 = [];
  var_11 = 0.1;
  var_10[0] = var_0;
  var_10[1] = var_0 + var_6 * (var_9 * var_11) + var_7 * (var_9 * -0.1);
  var_10[2] = var_1;
  var_10[3] = var_0 + var_6 * (var_9 * (-1 * var_11)) + var_7 * (var_9 * -0.1);
  var_10[4] = var_0;
  var_10[5] = var_0 + var_8 * (var_9 * var_11) + var_7 * (var_9 * -0.1);
  var_10[6] = var_1;
  var_10[7] = var_0 + var_8 * (var_9 * (-1 * var_11)) + var_7 * (var_9 * -0.1);
  var_10[8] = var_0;
  var_12 = var_2[0];
  var_13 = var_2[1];
  var_14 = var_2[2];
  plot_points(var_10, var_12, var_13, var_14, var_3);
}

get_linked_structs() {
  var_0 = [];

  if(isDefined(self.script_exploder)) {
    var_1 = get_links();

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = getstructarray(var_1[var_2], "script_linkname");

      if(var_3.size > 0) {
        var_0 = _id_0F73(var_0, var_3);
      }
    }
  }

  return var_0;
}

get_linked_ents() {
  var_0 = [];

  if(isDefined(self.script_exploder)) {
    var_1 = get_links();

    foreach(var_3 in var_1) {
      var_4 = getEntArray(var_3, "script_linkname");

      if(var_4.size > 0) {
        var_0 = _id_0F73(var_0, var_4);
      }
    }
  }

  return var_0;
}

_id_41EE() {
  var_0 = [];

  if(isDefined(self.script_exploder)) {
    var_1 = get_links();

    foreach(var_3 in var_1) {
      var_4 = _getnodearray(var_3, "script_linkname");

      if(var_4.size > 0) {
        var_0 = _id_0F73(var_0, var_4);
      }
    }
  }

  return var_0;
}

_id_41F2() {
  var_0 = [];

  if(isDefined(self.script_exploder)) {
    var_1 = get_links();

    foreach(var_3 in var_1) {
      var_4 = _getvehiclenodearray(var_3, "script_linkname");

      if(var_4.size > 0) {
        var_0 = _id_0F73(var_0, var_4);
      }
    }
  }

  return var_0;
}

get_linked_ent() {
  var_0 = get_linked_ents();
  return var_0[0];
}

get_linked_vehicle_node() {
  var_0 = _id_41F2();
  return var_0[0];
}

get_links() {
  return strtok(self.script_exploder, " ");
}

run_thread_on_targetname(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_0, "targetname");
  _id_0FB2(var_5, var_1, var_2, var_3, var_4);
  var_5 = getstructarray(var_0, "targetname");
  _id_0FB2(var_5, var_1, var_2, var_3, var_4);
  var_5 = call[[level.getnodearrayfunction]](var_0, "targetname");
  _id_0FB2(var_5, var_1, var_2, var_3, var_4);
  var_5 = _getvehiclenodearray(var_0, "targetname");
  _id_0FB2(var_5, var_1, var_2, var_3, var_4);
}

run_thread_on_noteworthy(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_0, "script_noteworthy");
  _id_0FB2(var_5, var_1, var_2, var_3, var_4);
  var_5 = getstructarray(var_0, "script_noteworthy");
  _id_0FB2(var_5, var_1, var_2, var_3, var_4);
  var_5 = call[[level.getnodearrayfunction]](var_0, "script_noteworthy");
  _id_0FB2(var_5, var_1, var_2, var_3, var_4);
  var_5 = _getvehiclenodearray(var_0, "script_noteworthy");
  _id_0FB2(var_5, var_1, var_2, var_3, var_4);
}

_id_339D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = -1 * var_4;
  var_9 = undefined;

  for(var_10 = 0; var_10 <= var_5; var_10++) {
    var_11 = vectorNormalize(_rotatevector(var_3, (0, var_8, 0)));
    var_12 = var_11 * var_1;

    if(var_10 == 0 || var_10 == var_5) {}

    if(isDefined(var_9)) {}

    var_9 = var_12;
    var_8 = var_8 + var_4 * 2 * (1 / var_5);
  }
}

draw_arrow(var_0, var_1, var_2) {
  level endon("newpath");
  var_3 = [];
  var_4 = vectortoangles(var_0 - var_1);
  var_5 = anglestoright(var_4);
  var_6 = anglesToForward(var_4);
  var_7 = distance(var_0, var_1);
  var_8 = [];
  var_9 = 0.05;
  var_8[0] = var_0;
  var_8[1] = var_0 + var_5 * (var_7 * var_9) + var_6 * (var_7 * -0.2);
  var_8[2] = var_1;
  var_8[3] = var_0 + var_5 * (var_7 * (-1 * var_9)) + var_6 * (var_7 * -0.2);

  for(var_10 = 0; var_10 < 4; var_10++) {
    var_11 = var_10 + 1;

    if(var_11 >= 4) {
      var_11 = 0;
    }
  }
}

draw_entity_bounds(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = (0, 1, 0);
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0.05;
  }

  if(var_3) {
    var_5 = int(var_4 / 0.05);
  } else {
    var_5 = int(var_1 / 0.05);
  }

  var_6 = [];
  var_7 = [];
  var_8 = gettime();

  for(var_9 = var_8 + var_1 * 1000; var_8 < var_9 && isDefined(var_0); var_8 = gettime()) {
    var_6[0] = var_0 getpointinbounds(1, 1, 1);
    var_6[1] = var_0 getpointinbounds(1, 1, -1);
    var_6[2] = var_0 getpointinbounds(-1, 1, -1);
    var_6[3] = var_0 getpointinbounds(-1, 1, 1);
    var_7[0] = var_0 getpointinbounds(1, -1, 1);
    var_7[1] = var_0 getpointinbounds(1, -1, -1);
    var_7[2] = var_0 getpointinbounds(-1, -1, -1);
    var_7[3] = var_0 getpointinbounds(-1, -1, 1);

    for(var_10 = 0; var_10 < 4; var_10++) {
      var_11 = var_10 + 1;

      if(var_11 == 4) {
        var_11 = 0;
      }
    }

    if(!var_3) {
      return;
    }
    wait(var_4);
  }
}

draw_volume(var_0, var_1, var_2, var_3, var_4) {
  draw_entity_bounds(var_0, var_1, var_2, var_3, var_4);
}

draw_trigger(var_0, var_1, var_2, var_3, var_4) {
  draw_entity_bounds(var_0, var_1, var_2, var_3, var_4);
}

_id_339C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = _getanimlength(var_0);

  if(!isDefined(var_4)) {
    var_4 = var_7;
  }

  if(!isDefined(var_6)) {
    var_6 = 1;
  }

  var_8 = 0.05;

  for(var_9 = 0; var_9 <= var_7; var_9 = var_9 + var_8) {
    var_10 = var_6 * _getmovedelta(var_0, 0, var_9 / var_7);
    var_11 = var_6 * _getmovedelta(var_0, 0, _min((var_9 + 0.05) / var_7, 1));
    var_12 = _transformmove(var_1, var_2, (0, 0, 0), (0, 0, 0), var_10, (0, 0, 0))["origin"];
    var_13 = _transformmove(var_1, var_2, (0, 0, 0), (0, 0, 0), var_11, (0, 0, 0))["origin"];
    draw_arrow_time(var_12, var_13, var_3, var_4);

    if(isDefined(var_5) && var_9 + var_8 >= var_7) {}
  }
}

getfx(var_0) {
  return level._effect[var_0];
}

fxexists(var_0) {
  return isDefined(level._effect[var_0]);
}

print_csv_asset(var_0, var_1) {
  var_2 = var_1 + "," + var_0;

  if(isDefined(level.csv_lines[var_2])) {
    return;
  }
  level.csv_lines[var_2] = 1;
}

fileprint_csv_start(var_0) {}

getlastweapon() {
  return self.disconnectnode;
}

playerunlimitedammothread() {}

isusabilityenabled() {
  return !self.disabledusability;
}

_id_0601() {
  if(!isDefined(self.disabledusability)) {
    self.disabledusability = 0;
  }

  self.disabledusability++;
  self disableusability();
}

_id_0615() {
  if(!isDefined(self.disabledusability)) {
    self.disabledusability = 0;
  } else if(self.disabledusability > 0) {
    self.disabledusability--;

    if(self.disabledusability == 0) {
      self enableusability();
    }
  }
}

resetusability() {
  self.disabledusability = 0;
  self enableusability();
}

_id_0602() {
  if(!isDefined(self.disabledweapon)) {
    self.disabledweapon = 0;
  }

  self.disabledweapon++;
  self disableweapons();
}

_id_0616() {
  if(!isDefined(self.disabledweapon)) {
    self.disabledweapon = 0;
  }

  self.disabledweapon--;

  if(!self.disabledweapon) {
    self enableweapons();
  }
}

isweaponenabled() {
  return !self.disabledweapon;
}

_id_0603() {
  if(!isDefined(self.disabledweaponswitch)) {
    self.disabledweaponswitch = 0;
  }

  self.disabledweaponswitch++;
  self disableweaponswitch();
}

_id_0617() {
  if(!isDefined(self.disabledweaponswitch)) {
    self.disabledweaponswitch = 0;
  }

  self.disabledweaponswitch--;

  if(!self.disabledweaponswitch) {
    self enableweaponswitch();
  }
}

_id_0668() {
  return !self.disabledweaponswitch;
}

_disableoffhandweapons() {
  if(!isDefined(self.disabledoffhandweapons)) {
    self.disabledoffhandweapons = 0;
  }

  self.disabledoffhandweapons++;
  self disableoffhandweapons();
}

_id_0614() {
  if(!isDefined(self.disabledoffhandweapons)) {
    self.disabledoffhandweapons = 0;
  }

  self.disabledoffhandweapons--;

  if(!self.disabledoffhandweapons) {
    self enableoffhandweapons();
  }
}

isoffhandweaponenabled() {
  return !self.disabledoffhandweapons;
}

_id_0613(var_0, var_1) {
  if(!self hasweapon(var_0)) {
    return;
  }
  if(self getdetonateenabled(var_0) == var_1) {
    return;
  }
  self enabledetonate(var_0, var_1);

  if(var_1) {
    self notify("WeaponDetonateEnabled", var_0);
  } else {
    self notify("WeaponDetonateDisabled", var_0);
  }
}

random(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    var_1[var_1.size] = var_3;
  }

  if(!var_1.size) {
    return undefined;
  }

  return var_1[randomint(var_1.size)];
}

random_weight_sorted(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    var_1[var_1.size] = var_3;
  }

  if(!var_1.size) {
    return undefined;
  }

  var_5 = randomint(var_1.size * var_1.size);
  return var_1[var_1.size - 1 - int(_sqrt(var_5))];
}

_id_7A45(var_0) {
  var_1 = 0.0;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    var_5 = 1;

    if(isDefined(var_4.weaponlockstart)) {
      var_5 = max(1, int(var_4.weaponlockstart));
    }

    for(var_6 = 0; var_6 < var_5; var_6++) {
      var_1 = var_1 + 1.0;

      if(_randomfloatrange(0.0, 1.0) <= 1.0 / var_1) {
        var_2 = var_4;
      }
    }
  }

  return var_2;
}

spawn_tag_origin() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0 hide();

  if(isDefined(self.origin)) {
    var_0.origin = self.origin;
  }

  if(isDefined(self.angles)) {
    var_0.angles = self.angles;
  }

  return var_0;
}

waittill_notify_or_timeout(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

waittill_notify_or_timeout_return(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
  return "timeout";
}

fileprint_launcher()
{
  level.fileprintlauncher_linecount = 0;
  level. fileprint_launcher_start_file = 1;
  fileprint_launcher_start_file( "GAMEPRINTSTARTFILE:" );
}

fileprint_launcher_start_file( var_0 )
{
  level.fileprintlauncher_linecount++;

  if(level.fileprintlauncher_linecount > 200) {
    waitframe();
    level.fileprintlauncher_linecount = 0;
  }
}

fileprint_launcher_end_file( var_0, var_1 )
{
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    fileprint_launcher_start_file( "GAMEPRINTENDFILE:GAMEPRINTP4ENABLED:" + var_0 );
  } else {
    fileprint_launcher_start_file( "GAMEPRINTENDFILE:" + var_0 );
  }

  var_2 = gettime() + 4000;

  while(getdvarint("LAUNCHER_PRINT_SUCCESS") == 0 && getDvar("LAUNCHER_PRINT_FAIL") == "0" && gettime() < var_2) {
    waitframe();
  }

  if(!(gettime() < var_2)) {
    _iprintlnbold("LAUNCHER_PRINT_FAIL:( TIMEOUT ): launcherconflict? restart launcher and try again? ");
    level. fileprint_launcher_start_file = undefined;
    return 0;
  }

  var_3 = getDvar("LAUNCHER_PRINT_FAIL");

  if(var_3 != "0") {
    _iprintlnbold("LAUNCHER_PRINT_FAIL:( " + var_3 + " ): launcherconflict? restart launcher and try again? ");
    level. fileprint_launcher_start_file = undefined;
    return 0;
  }

  level. fileprint_launcher_start_file = undefined;
  return 1;
}

launcher_write_clipboard(var_0) {
  level.fileprintlauncher_linecount = 0;
  fileprint_launcher_start_file( "LAUNCHER_CLIP:" + var_0 );
}

isdestructible() {
  if(!isDefined(self)) {
    return 0;
  }

  return isDefined(self._id_0075);
}

pauseeffect() {
  common_scripts\_createfx::stop_fx_looper();
}

activate_individual_exploder() {
  common_scripts\_exploder::_id_0895();
}

get_target_ent(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self.target;
  }

  var_1 = _getEnt(var_0, "targetname");

  if(isDefined(var_1)) {
    return var_1;
  }

  if(issp()) {
    var_1 = call[[level._id_45B4]](var_0, "targetname");

    if(isDefined(var_1)) {
      return var_1;
    }
  }

  var_1 = getstruct(var_0, "targetname");

  if(isDefined(var_1)) {
    return var_1;
  }

  var_1 = _getvehiclenode(var_0, "targetname");

  if(isDefined(var_1)) {
    return var_1;
  }
}

get_noteworthy_ent(var_0) {
  var_1 = _getEnt(var_0, "script_noteworthy");

  if(isDefined(var_1)) {
    return var_1;
  }

  if(issp()) {
    var_1 = call[[level._id_45B4]](var_0, "script_noteworthy");

    if(isDefined(var_1)) {
      return var_1;
    }
  }

  var_1 = getstruct(var_0, "script_noteworthy");

  if(isDefined(var_1)) {
    return var_1;
  }

  var_1 = _getvehiclenode(var_0, "script_noteworthy");

  if(isDefined(var_1)) {
    return var_1;
  }
}

do_earthquake(var_0, var_1) {
  var_2 = level.earthquake[var_0];
  _earthquake(var_2["magnitude"], var_2["duration"], var_1, var_2["radius"]);
}

play_loopsound_in_space(var_0, var_1) {
  if(!_soundexists(var_0)) {
    return;
  }
  var_2 = spawn("script_origin", (0, 0, 0));

  if(!isDefined(var_1)) {
    var_1 = self.origin;
  }

  var_2.origin = var_1;
  var_2 playLoopSound(var_0);
  return var_2;
}

play_sound_in_space_with_angles(var_0, var_1, var_2, var_3) {
  if(!_soundexists(var_0)) {
    return;
  }
  var_4 = spawn("script_origin", (0, 0, 1));

  if(!isDefined(var_1)) {
    var_1 = self.origin;
  }

  var_4.origin = var_1;
  var_4.angles = var_2;

  if(isDefined(var_3) && var_3) {
    var_4 playsoundasmaster(var_0, "sounddone");
  } else {
    var_4 playSound(var_0, "sounddone");
  }

  var_4 waittill("sounddone");
  var_4 delete();
}

play_sound_in_space(var_0, var_1, var_2) {
  play_sound_in_space_with_angles(var_0, var_1, (0, 0, 0), var_2);
}

_id_5EDF(var_0, var_1, var_2, var_3, var_4) {
  if(!_soundexists(var_0)) {
    return;
  }
  if(isDefined(var_3)) {
    var_2 = undefined;
  }

  self.v["snd_ent"] = _id_3F50(var_0, var_1);

  if(isDefined(var_3)) {
    thread _id_5EE9(var_3);
  }
}

loop_fx_sound_with_angles(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!_soundexists(var_0)) {
    return;
  }
  _id_5EDF(var_0, var_1, var_3, var_4, var_5);
}

loop_fx_sound_interval(var_0, var_1, var_2, var_3, var_4, var_5) {
  loop_fx_sound_interval_with_angles(var_0, var_1, (0, 0, 0), var_2, var_3, var_4, var_5);
}

loop_fx_sound_interval_with_angles(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_3)) {
    self endon(var_3);
  }

  if(var_5 >= var_6) {
    for(;;) {
      waitframe();
    }
  }

  if(!_soundexists(var_0)) {
    for(;;) {
      waitframe();
    }
  }

  for(;;) {
    wait(_randomfloatrange(var_5, var_6));
    lock("createfx_looper");
    _id_3F50(var_0, var_1);
    unlock("createfx_looper");
  }
}

_id_3F50(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  if(!_soundexists(var_0)) {
    return undefined;
  }

  if(soundscripts/_audio_music(var_0)) {
    var_3 = 0.05;
  }

  var_4 = soundscripts/_audio_vehicle_manager(var_0, var_1, var_2, var_3);
  return var_4;
}

_id_3F51() {
  if(isDefined(self) && isDefined(self.v["snd_ent"])) {
    self.v["snd_ent"] _meth_863F(0.05);
    self.v["snd_ent"] = undefined;
  }
}

_id_5EE9(var_0) {
  var_1 = self.v["snd_ent"];
  self endon("death");
  self waittill(var_0);

  if(isDefined(var_1)) {
    var_1 _meth_863F(0.05);
  }
}

createloopeffect(var_0) {
  var_1 = common_scripts\_createfx::createeffect("loopfx", var_0);
  var_1.v["delay"] = common_scripts\_createfx::getloopeffectdelaydefault();
  return var_1;
}

createoneshoteffect(var_0) {
  var_1 = common_scripts\_createfx::createeffect("oneshotfx", var_0);
  var_1.v["delay"] = common_scripts\_createfx::getoneshoteffectdelaydefault();
  return var_1;
}

createexploder(var_0) {
  var_1 = common_scripts\_createfx::createeffect("exploder", var_0);
  var_1.v["delay"] = common_scripts\_createfx::getexploderdelaydefault();
  var_1.v["exploder_type"] = "normal";
  return var_1;
}

alphabetize(var_0) {
  if(var_0.size <= 1) {
    return var_0;
  }

  var_1 = 0;

  for(var_2 = var_0.size - 1; var_2 >= 1; var_2--) {
    var_3 = var_0[var_2];
    var_4 = var_2;

    for(var_5 = 0; var_5 < var_2; var_5++) {
      var_6 = var_0[var_5];

      if(_stricmp(var_6, var_3) > 0) {
        var_3 = var_6;
        var_4 = var_5;
      }
    }

    if(var_4 != var_2) {
      var_0[var_4] = var_0[var_2];
      var_0[var_2] = var_3;
    }
  }

  return var_0;
}

is_later_in_alphabet(var_0, var_1) {
  return _stricmp(var_0, var_1) > 0;
}

play_loop_sound_on_entity(var_0, var_1) {
  if(!_soundexists(var_0)) {
    return;
  }
  var_2 = spawn("script_origin", (0, 0, 0));
  var_2 endon("death");
  thread delete_on_death(var_2);

  if(isDefined(var_1)) {
    var_2.origin = self.origin + var_1;
    var_2.angles = self.angles;
    var_2 linktosynchronizedparent(self);
  } else {
    var_2.origin = self.origin;
    var_2.angles = self.angles;
    var_2 linktosynchronizedparent(self);
  }

  var_2 playLoopSound(var_0);
  self waittill("stop sound" + var_0);
  var_2 stoploopsound(var_0);
  var_2 delete();
}

stop_loop_sound_on_entity(var_0) {
  self notify("stop sound" + var_0);
}

delete_on_death(var_0) {
  var_0 endon("death");
  waittill_any("death", "disconnect");

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

error(var_0) {}

create_dvar(var_0, var_1) {
  setdvarifuninitialized(var_0, var_1);
}

void(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {}

tag_project(var_0, var_1) {
  var_2 = self gettagorigin(var_0);
  var_3 = self gettagangles(var_0);
  var_4 = anglesToForward(var_3);
  var_4 = vectorNormalize(var_4) * var_1;
  return var_2 + var_4;
}

ter_op(var_0, var_1, var_2) {
  if(var_0) {
    return var_1;
  }

  return var_2;
}

create_lock(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(level.lock)) {
    level.lock = [];
  }

  var_2 = spawnStruct();
  var_2.max_count = var_1;
  var_2._id_005C = 0;
  level.lock[var_0] = var_2;
}

lock_exists(var_0) {
  if(!isDefined(level.lock)) {
    return 0;
  }

  return isDefined(level.lock[var_0]);
}

lock(var_0) {
  var_1 = level.lock[var_0];

  while(var_1._id_005C >= var_1.max_count) {
    var_1 waittill("unlocked");
  }

  var_1._id_005C++;
}

is_locked(var_0) {
  var_1 = level.lock[var_0];
  return var_1._id_005C > var_1.max_count;
}

unlock_wait(var_0) {
  thread unlock_thread(var_0);
  waitframe();
}

unlock(var_0) {
  thread unlock_thread(var_0);
}

unlock_thread(var_0) {
  waitframe();
  var_1 = level.lock[var_0];
  var_1._id_005C--;
  var_1 notify("unlocked");
}

get_template_level() {
  var_0 = level._id_015D;

  if(isDefined(level.template_script)) {
    var_0 = level.template_script;
  }

  return var_0;
}

_id_0FA2(var_0) {
  var_1 = [];
  var_2 = var_0.size > 0 && _isstring(getfirstarraykey(var_0));

  if(var_2) {
    var_3 = getarraykeys(var_0);

    for(var_4 = var_3.size - 1; var_4 >= 0; var_4--) {
      var_5 = var_3[var_4];
      var_1[var_5] = var_0[var_5];
    }
  } else {
    for(var_4 = var_0.size - 1; var_4 >= 0; var_4--) {
      var_1[var_1.size] = var_0[var_4];
    }
  }

  return var_1;
}

distance_2d_squared(var_0, var_1) {
  return _length2dsquared(var_0 - var_1);
}

get_array_of_farthest(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_array_of_closest(var_0, var_1, var_2, var_3, var_4, var_5);
  var_6 = _id_0FA2(var_6);
  return var_6;
}

get_array_of_closest(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3)) {
    var_3 = var_1.size;
  }

  if(!isDefined(var_2)) {
    var_2 = [];
  }

  var_6 = undefined;

  if(isDefined(var_4)) {
    var_6 = var_4 * var_4;
  }

  var_7 = 0;

  if(isDefined(var_5)) {
    var_7 = var_5 * var_5;
  }

  if(var_2.size == 0 && var_3 >= var_1.size && var_7 == 0 && !isDefined(var_6)) {
    return _sortbydistance(var_1, var_0);
  }

  var_8 = [];

  foreach(var_10 in var_1) {
    var_11 = 0;

    foreach(var_13 in var_2) {
      if(var_10 == var_13) {
        var_11 = 1;
        break;
      }
    }

    if(var_11) {
      continue;
    }
    var_15 = distancesquared(var_0, var_10.origin);

    if(isDefined(var_6) && var_15 > var_6) {
      continue;
    }
    if(var_15 < var_7) {
      continue;
    }
    var_8[var_8.size] = var_10;
  }

  var_8 = _sortbydistance(var_8, var_0);

  if(var_3 >= var_8.size) {
    return var_8;
  }

  var_17 = [];

  for(var_18 = 0; var_18 < var_3; var_18++) {
    var_17[var_18] = var_8[var_18];
  }

  return var_17;
}

is_player_gamepad_enabled() {
  if(!level.console) {
    var_0 = self usinggamepad();

    if(isDefined(var_0)) {
      return var_0;
    } else {
      return 0;
    }
  }

  return 1;
}

drop_to_ground(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 1500;
  }

  if(!isDefined(var_2)) {
    var_2 = -12000;
  }

  return _physicstrace(var_0 + (0, 0, var_1), var_0 + (0, 0, var_2));
}

_id_091E(var_0, var_1) {
  if(!isDefined(level.destructible_functions)) {
    level.destructible_functions = [];
  }

  level.destructible_functions[var_0] = var_1;
}

_id_091F(var_0, var_1) {
  if(!isDefined(level.destructible_transient)) {
    level.destructible_transient = [];
  }

  level.destructible_transient[var_0] = var_1;
}

within_fov(var_0, var_1, var_2, var_3) {
  var_4 = vectorNormalize(var_2 - var_0);
  var_5 = anglesToForward(var_1);
  var_6 = vectordot(var_5, var_4);
  return var_6 >= var_3;
}

_id_7237(var_0, var_1, var_2) {
  if(isDefined(self.clientid)) {
    var_3 = self.clientid;
  } else {
    var_3 = 0;
  }

  var_4 = gettime();

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_5 = 0.766;

  if(isDefined(var_2)) {
    var_5 = _cos(var_2);
  }

  if(!isDefined(var_0.playerseesmetime)) {
    var_0.playerseesmetime = [];
    var_0.playerseesme = [];
  }

  if(isDefined(var_0.playerseesmetime[var_3]) && var_0.playerseesmetime[var_3] + var_1 >= var_4) {
    return var_0.playerseesme[var_3];
  }

  var_0.playerseesmetime[var_3] = var_4;

  if(!within_fov(self.origin, self _meth_8566(), var_0.origin, var_5)) {
    var_0.playerseesme[var_3] = 0;
    return 0;
  }

  var_6 = self getEye();
  var_7 = var_0.origin;

  if(_sighttracepassed(var_6, var_7, 1, self, var_0)) {
    var_0.playerseesme[var_3] = 1;
    return 1;
  }

  var_8 = var_0 getEye();

  if(_sighttracepassed(var_6, var_8, 1, self, var_0)) {
    var_0.playerseesme[var_3] = 1;
    return 1;
  }

  var_9 = (var_8 + var_7) * 0.5;

  if(_sighttracepassed(var_6, var_9, 1, self, var_0)) {
    var_0.playerseesme[var_3] = 1;
    return 1;
  }

  var_0.playerseesme[var_3] = 0;
  return 0;
}

entity_path_disconnect_thread(var_0) {
  self notify("entity_path_disconnect_thread");
  self endon("entity_path_disconnect_thread");
  self endon("death");
  level endon("game_ended");
  var_1 = 0;
  self.forcedisconnectuntil = 0;

  for(;;) {
    var_2 = self.origin;
    var_3 = waittill_any_timeout(var_0, "path_disconnect");
    var_4 = 0;
    var_5 = distancesquared(self.origin, var_2) > 0;

    if(var_5) {
      var_4 = 1;
    }

    if(isDefined(var_3) && var_3 == "path_disconnect") {
      var_4 = 1;
    }

    if(gettime() < self.forcedisconnectuntil) {
      var_4 = 1;
    }

    foreach(var_7 in maps/_lights()) {
      if(_isai(var_7) && distancesquared(self.origin, var_7.origin) < 250000) {
        var_4 = 1;
        self.forcedisconnectuntil = max(gettime() + 30000, self.forcedisconnectuntil);
      }
    }

    if(var_4 != var_1 || var_5) {
      if(var_4) {
        self disconnectPaths();
      } else {
        self connectpaths();
      }

      var_1 = var_4;
    }
  }
}

make_entity_sentient_mp(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_make_entity_sentient"])) {
    return self[[level.bot_funcs["bots_make_entity_sentient"]]](var_0, var_1, var_2, var_3, var_4);
  }
}

free_entity_sentient_mp() {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_free_entity_sentient"])) {
    return self[[level.bot_funcs["bots_free_entity_sentient"]]]();
  }
}

_id_64F3() {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bot_bots_enabled_or_added"])) {
    return self[[level.bot_funcs["bot_bots_enabled_or_added"]]]();
  }

  return 0;
}

_id_0A63(var_0) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["ai_3d_sighting_model"])) {
    return self[[level.bot_funcs["ai_3d_sighting_model"]]](var_0);
  }
}

physicsgetangvel(var_0, var_1, var_2) {
  if(!isDefined(level._id_0E2F)) {
    level._id_0E2F = [];
  }

  var_3 = _tolower(getDvar("1673"));
  var_4 = 1;

  if(string_starts_with(var_3, "mp_")) {
    var_4 = 0;
  }

  if(var_4) {
    level._id_0E2F[var_0]["basic"] = var_1;
  } else {
    level._id_0E2F[var_0]["basic"] = var_2;
  }
}

getclosest(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 500000;
  }

  var_3 = undefined;

  foreach(var_5 in var_1) {
    if(!isDefined(var_5)) {
      continue;
    }
    var_6 = distance(var_5.origin, var_0);

    if(var_6 >= var_2) {
      continue;
    }
    var_2 = var_6;
    var_3 = var_5;
  }

  return var_3;
}

_id_4467(var_0, var_1) {
  var_2 = 0;
  var_3 = distance(var_0, var_1[0]);

  for(var_4 = 1; var_4 < var_1.size; var_4++) {
    var_5 = distance(var_0, var_1[var_4]);

    if(var_5 < var_3) {
      var_2 = var_4;
      var_3 = var_5;
    }
  }

  return var_1[var_2];
}

getfarthest(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 500000;
  }

  var_3 = 0;
  var_4 = undefined;

  foreach(var_6 in var_1) {
    var_7 = distance(var_6.origin, var_0);

    if(var_7 <= var_3 || var_7 >= var_2) {
      continue;
    }
    var_3 = var_7;
    var_4 = var_6;
  }

  return var_4;
}

missile_settargetandflightmode(var_0, var_1, var_2) {
  var_2 = ter_op(isDefined(var_2), var_2, (0, 0, 0));
  self missile_settargetEnt(var_0, var_2);

  switch (var_1) {
    case "direct":
      self missile_setflightmodedirect();
      break;
    case "top":
      self missile_setflightmodetop();
      break;
  }
}

evfromluminancenits(var_0) {
  return _log(var_0 + 0.000061) / _log(2.0) + 2.84;
}

lineartogamma_srgb(var_0) {
  if(var_0 <= 0.0031308) {
    return var_0 * 12.92;
  } else {
    return _pow(var_0, 0.416667) * 1.055 - 0.055;
  }
}

_id_2617(var_0) {}

_id_2616(var_0) {
  if(isDefined(level._id_38D0)) {
    switch (level._id_38D0) {
      case "alfog":
        break;
      case "normal_fog":
        break;
      default:
    }
  }
}

finishentitydamage(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  _id_2617(var_0);
  _id_2616(var_0);

  if(isDefined(var_0.atmosfogenabled)) {
    if(level._id_010B) {
      if(var_0.atmosfogenabled) {
        if(isPlayer(self)) {
          self playersetatmosfog(var_0.atmosfogenabled, var_1, var_0.atmosfogsunfogcolor, var_0.atmosfoghazecolor, var_0.atmosfoghazestrength, var_0.atmosfoghazespread, var_0.atmosfogextinctiondesaturation, var_0.atmosfogextinctionstrength, var_0.atmosfoginscatterstrength, var_0.atmosfoghalfplanedistance, var_0.atmosfogstartdistance, var_0.atmosfogdistancescale, int(var_0.atmosfogskydistance), var_0.atmosfogskyangularfalloffenabled, var_0.atmosfogskyfalloffstartangle, var_0.atmosfogskyfalloffanglerange, var_0.atmosfogsundirection, var_0.atmosfogheightfogenabled, var_0.atmosfogheightfogbaseheight, var_0.atmosfogheightfoghalfplanedistance, var_0.atmosfogheightfogmaximumoffset, var_0.atmosfogheightfogstrengthofdepthfog, var_0.atmosfogentityscale, var_0.atmosfogairlightcapacity, var_0.atmosfogairlightdensityscalar, var_0.atmosfogairlightvertexinnermutedradius, var_0.atmosfogsplineenabled, var_0.atmosfogsplinemaxdistance, var_0.atmosfogsplinecustomdistance1, var_0.atmosfogsplinecustomdistance2, var_0.atmosfogsplinecustomdistance3, var_0.atmosfogsplinecustomvisibility1, var_0.atmosfogsplinecustomvisibility2, var_0.atmosfogsplinecustomvisibility3, var_0.atmosfogsplinemaxdistancevisibility, var_0.atmosfogsplineusemaxdistancevisibilityoverride, var_0.atmosfogsplinemaxdistancevisibilityoverride, var_0.atmosfogsplinecustomtangentsenabled, var_0.atmosfogsplinestartingtangentangle, var_0.atmosfogsplinecustomtangentangle1, var_0.atmosfogsplinecustomtangentangle2, var_0.atmosfogsplinecustomtangentangle3, var_0.atmosfogsplinemaxdistancetangentangle);
        } else {
          _setatmosfog(var_0.atmosfogenabled, var_1, var_0.atmosfogsunfogcolor, var_0.atmosfoghazecolor, var_0.atmosfoghazestrength, var_0.atmosfoghazespread, var_0.atmosfogextinctiondesaturation, var_0.atmosfogextinctionstrength, var_0.atmosfoginscatterstrength, var_0.atmosfoghalfplanedistance, var_0.atmosfogstartdistance, var_0.atmosfogdistancescale, int(var_0.atmosfogskydistance), var_0.atmosfogskyangularfalloffenabled, var_0.atmosfogskyfalloffstartangle, var_0.atmosfogskyfalloffanglerange, var_0.atmosfogsundirection, var_0.atmosfogheightfogenabled, var_0.atmosfogheightfogbaseheight, var_0.atmosfogheightfoghalfplanedistance, var_0.atmosfogheightfogmaximumoffset, var_0.atmosfogheightfogstrengthofdepthfog, var_0.atmosfogentityscale, var_0.atmosfogairlightcapacity, var_0.atmosfogairlightdensityscalar, var_0.atmosfogairlightvertexinnermutedradius, var_0.atmosfogsplineenabled, var_0.atmosfogsplinemaxdistance, var_0.atmosfogsplinecustomdistance1, var_0.atmosfogsplinecustomdistance2, var_0.atmosfogsplinecustomdistance3, var_0.atmosfogsplinecustomvisibility1, var_0.atmosfogsplinecustomvisibility2, var_0.atmosfogsplinecustomvisibility3, var_0.atmosfogsplinemaxdistancevisibility, var_0.atmosfogsplineusemaxdistancevisibilityoverride, var_0.atmosfogsplinemaxdistancevisibilityoverride, var_0.atmosfogsplinecustomtangentsenabled, var_0.atmosfogsplinestartingtangentangle, var_0.atmosfogsplinecustomtangentangle1, var_0.atmosfogsplinecustomtangentangle2, var_0.atmosfogsplinecustomtangentangle3, var_0.atmosfogsplinemaxdistancetangentangle);
        }
      } else if(isPlayer(self))
        self playersetatmosfog(var_0.atmosfogenabled, var_1);
      else {
        _setatmosfog(var_0.atmosfogenabled, var_1);
      }
    }
  }
}

_id_092C(var_0, var_1) {
  if(!isDefined(level._effect)) {
    level._effect = [];
  }

  level._effect[var_0] = loadfx(var_1);
}

_id_0FA4(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size - 1; var_2++) {
    for(var_3 = var_2 + 1; var_3 < var_0.size; var_3++) {
      if(var_0[var_3][[var_1]]() < var_0[var_2][[var_1]]()) {
        var_4 = var_0[var_3];
        var_0[var_3] = var_0[var_2];
        var_0[var_2] = var_4;
      }
    }
  }

  return var_0;
}

_id_0FA5(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = -1;
  }

  for(var_3 = 1; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    for(var_5 = var_3 - 1; var_5 >= 0 && ![[var_1]](var_0[var_5], var_4); var_5--) {
      var_0[var_5 + 1] = var_0[var_5];
    }

    var_0[var_5 + 1] = var_4;

    if(var_2 > 0 && var_3 % var_2 == 0) {
      waitframe();
    }
  }

  return var_0;
}

hide_notsolid() {
  if(!isDefined(self.oldcontents)) {
    self.oldcontents = self _meth_80B1();
  }

  self hide();
}

show_solid() {
  if(!_isai(self)) {
    self solid();
  }

  if(isDefined(self.oldcontents)) {
    self setcontents(self.oldcontents);
  }

  self show();
}

_id_A2BE() {
  return (0, 0, 0);
}

_id_A2BA(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1) || !_isvector(var_1) || !_isvector(var_1)) {
    return 0;
  }

  return var_0[0] == var_1[0] && var_0[1] == var_1[1] && var_0[2] == var_1[2];
}

_id_A2B9(var_0) {
  var_1 = _id_A2BE();

  if(!isDefined(var_0) || !_isarray(var_0)) {
    return var_1;
  }

  if(var_0.size == 0) {
    return var_1;
  }

  foreach(var_3 in var_0) {
    var_1 = var_1 + var_3;
  }

  var_1 = var_1 / var_0.size;
  return var_1;
}

_id_6880(var_0) {
  if(!var_0.size) {
    return 0;
  }

  var_1 = 0;

  foreach(var_3 in var_0) {
    var_1 = var_1 + var_3;
  }

  var_5 = var_1 / var_0.size;
  return var_5;
}

setlightingstate(var_0) {
  var_1 = getEntArray();
  _setomnvar("lighting_state", var_0);

  if(!getdvarint("233")) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3.lightingstate) && isDefined(var_3.classname) && (var_3.classname == "script_brushmodel" || var_3.classname == "script_model")) {
        if(var_3.lightingstate == 0) {
          continue;
        }
        if(var_3.lightingstate == var_0) {
          var_3 show_solid();
          continue;
        }

        var_3 hide_notsolid();
      }
    }
  }
}

getstatsgroup_ranked() {
  if(_id_562E(level.iszombiegame)) {
    return "zombiePlayerStats";
  }

  return "rankedPlayerStats";
}

_id_46A8() {
  return "zombiePlayerStats";
}

getstatsgroup_common() {
  return "commonData";
}

_id_46AF() {
  return "rankedloadouts";
}

_id_46AC() {
  return "privateloadouts";
}

getstatsgroup_horde() {
  return "raidData";
}

_id_46AA() {
  return "hubData";
}

_id_46A9() {
  return "costumesData";
}

_id_46AB() {
  return "leaderboardData";
}

_id_ACEE() {
  return "competitiveloadouts";
}

_id_339E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_3)) {
    var_3 = 180;
  }

  if(!isDefined(var_2)) {
    var_2 = 100;
  }

  if(!isDefined(var_1) && isDefined(self.angles)) {
    var_1 = self.angles;
  }

  if(!isDefined(var_0) && isDefined(self.origin)) {
    var_0 = self.origin;
  }

  var_8 = 16;
  var_9 = 360 / var_8;
  var_10 = var_3;
  var_11 = var_10 - var_3 * 2.0;
  var_12 = var_10;
  var_13 = [];
  var_13[var_13.size] = var_0;
  var_13[var_13.size] = var_0 + anglesToForward(_combineangles(var_1, (0, var_12, 0))) * var_2;

  for(var_13[var_13.size] = var_0; var_12 > var_11; var_13[var_13.size - 2] = var_0 + anglesToForward(_combineangles(var_1, (0, var_12, 0))) * var_2) {
    var_12 = max(var_11, var_12 - var_9);
    var_13[var_13.size] = var_13[var_13.size - 1];
  }

  thread _id_33A6(var_13, var_4, var_5, var_6, var_7);
}

_id_33A4(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 16;
  var_7 = 360 / var_6;
  var_8 = [];

  for(var_9 = 0; var_9 < var_6; var_9++) {
    var_10 = var_7 * var_9;
    var_11 = _cos(var_10) * var_1;
    var_12 = _sin(var_10) * var_1;
    var_13 = var_0[0] + var_11;
    var_14 = var_0[1] + var_12;
    var_15 = var_0[2];
    var_8[var_8.size] = (var_13, var_14, var_15);
  }

  thread _id_33A6(var_8, var_2, var_3, var_4, var_5);
}

_id_33A6(var_0, var_1, var_2, var_3, var_4) {
  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];

    if(var_5 + 1 >= var_0.size) {
      var_7 = var_0[0];
    } else {
      var_7 = var_0[var_5 + 1];
    }

    thread draw_line_for_time(var_6, var_7, var_1, var_2, var_3, var_4);
  }
}

_id_33A5(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 16;
  var_6 = 360 / var_5;
  var_7 = [];

  for(var_8 = 0; var_8 < var_5; var_8++) {
    var_9 = anglesToForward(var_2);
    var_10 = _vectorcross(var_9, (0, 0, 1));
    var_11 = _vectorcross(var_10, var_9);
    var_12 = var_6 * var_8;
    var_13 = _cos(var_12) * var_1;
    var_14 = _sin(var_12) * var_1;
    var_7[var_7.size] = var_0 + var_10 * var_13 + var_11 * var_14;
  }

  thread _id_33A6(var_7, var_3[0], var_3[1], var_3[2], var_4);
}

_id_33B0(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4)) {
    var_4 = (1, 1, 1);
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  var_6 = 1;
  var_7 = 0;
  var_1 = vectorNormalize(var_1);

  if(var_1 == (0, 0, 1)) {
    var_8 = (1, 0, 0);
  }

  var_8 = vectorNormalize(_vectorcross(var_1, (0, 0, 1)));
  var_9 = _vectorcross(var_1, var_8);
  var_10 = var_1 * var_3 * _cos(var_2);
  var_11 = var_3 * _sin(var_2);
  var_12 = (0, 0, 0);
  var_13 = int(20 * var_5);
  var_14 = 16;

  for(var_15 = 0; var_15 <= var_14; var_15++) {
    var_16 = var_15 / var_14 * 360;
    var_17 = var_0 + var_10 + var_11 * (var_8 * _cos(var_16) + var_9 * _sin(var_16));

    if(var_15 > 0) {}

    var_12 = var_17;
  }
}

_id_5D92(var_0, var_1, var_2, var_3, var_4) {
  return var_3 + (var_0 - var_1) * (var_4 - var_3) / (var_2 - var_1);
}

linear_map_clamp(var_0, var_1, var_2, var_3, var_4) {
  return clamp(_id_5D92(var_0, var_1, var_2, var_3, var_4), _min(var_3, var_4), max(var_3, var_4));
}

_id_7716(var_0, var_1, var_2, var_3, var_4) {
  level endon(var_0);
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  if(!isDefined(var_2)) {
    var_2 = "*";
  }

  if(!isDefined(var_3)) {
    var_3 = (1, 1, 0);
  }

  if(!isDefined(var_4)) {
    var_4 = 3;
  }

  for(;;) {
    if(_isremovedentity(self)) {
      return;
    }
    waitframe();
  }
}

stringtofloat(var_0) {
  var_1 = strtok(var_0, ".");
  var_2 = int(var_1[0]);

  if(isDefined(var_1[1])) {
    var_3 = 1;

    for(var_4 = 0; var_4 < var_1[1].size; var_4++) {
      var_3 = var_3 * 0.1;
    }

    var_2 = var_2 + int(var_1[1]) * var_3;
  }

  return var_2;
}

_id_7F03(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "nearest";
  }

  var_3 = 1;

  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_3 = var_3 * 10;
  }

  var_5 = var_0 * var_3;

  if(var_2 == "up") {
    var_6 = _ceil(var_5);
  } else if(var_2 == "down") {
    var_6 = _floor(var_5);
  } else {
    var_6 = var_5 + 0.5;
  }

  var_5 = int(var_6);
  var_5 = var_5 / var_3;
  return var_5;
}

_id_40B5() {
  var_0 = spawnStruct();
  var_1 = getDvar("r_mode", "1280x720 [16:9]");
  var_2 = strtok(var_1, " ");
  var_3 = strtok(var_2[0], "x");
  var_0._id_01D2 = stringtofloat(var_3[0]);
  var_0._id_00BD = stringtofloat(var_3[1]);
  var_0._id_1083 = _id_7F03(var_0._id_01D2 / var_0._id_00BD, 3);
  return var_0;
}

_id_6FA9(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getdvarint("turret_plant_debug") == 2;
  var_7 = [];
  var_8 = [];
  var_9 = 20;
  var_10 = undefined;

  if(var_3 > 0) {
    var_10 = int(var_3 / var_9) + 2;
  } else {
    var_9 = -1 * var_9;
    var_10 = int(var_3 / var_9) + 2;
  }

  var_11 = _invertangles(var_1);
  var_12 = 0;

  for(var_13 = 0; var_13 < var_10; var_13++) {
    if(var_13 == var_10 - 1) {
      var_12 = var_3;
    } else {
      var_12 = var_13 * var_9;
    }

    if(var_13 == var_10 - 1) {
      var_12 = var_3;
    } else {
      var_12 = var_13 * var_9;
    }

    var_14 = _combineangles(var_1, (0, var_12, 0));
    var_15 = anglesToForward(var_14) * var_2;
    var_8[var_13] = var_15 + var_0;
  }

  var_7["is_hit"] = 0;
  var_7["arc_end"] = var_8[var_13];

  for(var_13 = 0; var_13 < var_8.size - 1; var_13++) {
    var_16 = var_8[var_13];
    var_17 = var_8[var_13 + 1];

    if(!isDefined(var_5)) {
      var_18 = _physicstrace(var_16, var_17, var_4);
    } else {
      var_19 = maps/_weather(var_16, var_17, var_5, undefined, var_4);

      if(var_19["is_matching_hit_found"]) {
        var_18 = var_19["position"];
      } else {
        var_18 = var_17;
      }
    }

    var_20 = undefined;

    if(!_id_5646(var_18, var_17)) {
      var_21 = _rotatevector(var_18 - var_0, var_11);
      var_20 = _asin(var_21[1] / var_2);

      if(var_7["is_hit"] == 0) {
        var_7["hit_angle"] = var_20;
        var_7["hit_point"] = var_18;
        var_7["is_hit"] = 1;
      } else if(!var_6) {
        break;
      }
    }
  }

  return var_7;
}

_id_5646(var_0, var_1) {
  var_2 = 0.001;
  return _abs(var_0[0] - var_1[0]) < var_2 && _abs(var_0[1] - var_1[1]) < var_2 && _abs(var_0[2] - var_1[2]) < var_2;
}

_id_A087(var_0) {
  var_1 = "0123456789ABCDEF";

  if(var_0 == 0) {
    return var_1[0];
  }

  for(var_2 = ""; var_0 > 0; var_0 = _floor(var_0 / 16)) {
    var_2 = var_1[int(var_0 % 16)] + var_2;
  }

  var_2 = "0x" + var_2;
  return var_2;
}

quicksort(var_0, var_1) {
  var_2 = _id_789B(var_0, 0, var_0.size - 1, var_1);
  var_3 = [];

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_3[var_4] = var_2[var_4];
  }

  return var_3;
}

_id_789B(var_0, var_1, var_2, var_3) {
  var_4 = var_1;
  var_5 = var_2;

  if(!isDefined(var_3)) {
    var_3 = ::_id_7898;
  }

  if(var_2 - var_1 >= 1) {
    var_6 = var_0[var_1];

    while(var_5 > var_4) {
      while([[var_3]](var_0[var_4], var_6) && var_4 <= var_2 && var_5 > var_4) {
        var_4++;
      }

      while(![[var_3]](var_0[var_5], var_6) && var_5 > var_1 && var_5 >= var_4) {
        var_5--;
      }

      if(var_5 > var_4) {
        var_0 = swap(var_0, var_4, var_5);
      }
    }

    var_0 = swap(var_0, var_1, var_5);
    var_0 = _id_789B(var_0, var_1, var_5 - 1, var_3);
    var_0 = _id_789B(var_0, var_5 + 1, var_2, var_3);
  } else
    return var_0;

  return var_0;
}

_id_7898(var_0, var_1) {
  return var_0 <= var_1;
}

_id_7899(var_0, var_1) {
  return var_0 > var_1;
}

swap(var_0, var_1, var_2) {
  var_3 = var_0[var_1];
  var_0[var_1] = var_0[var_2];
  var_0[var_2] = var_3;
  return var_0;
}

_id_73F5(var_0) {
  foreach(var_2 in var_0.pers["killstreaks"]) {
    if(var_2.available == 1) {
      return 1;
    }
  }

  return 0;
}