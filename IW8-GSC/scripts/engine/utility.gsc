/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\engine\utility.gsc
***********************************************/

function noself_func(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.func)) {
    return;
  }

  if(!isDefined(level.func[var_0])) {
    return;
  }

  if(!isDefined(var_1)) {
    builtin[[level.func[var_0]]]();
    return;
  }

  if(!isDefined(var_2)) {
    builtin[[level.func[var_0]]](var_1);
    return;
  }

  if(!isDefined(var_3)) {
    builtin[[level.func[var_0]]](var_1, var_2);
    return;
  }

  if(!isDefined(var_4)) {
    builtin[[level.func[var_0]]](var_1, var_2, var_3);
    return;
  }

  builtin[[level.func[var_0]]](var_1, var_2, var_3, var_4);
}

function noself_func_return(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.func)) {
    return undefined;
  }

  if(!isDefined(level.func[var_0])) {
    return undefined;
  }

  if(!isDefined(var_1)) {
    return builtin[[level.func[var_0]]]();
  }

  if(!isDefined(var_2)) {
    return builtin[[level.func[var_0]]](var_1);
  }

  if(!isDefined(var_3)) {
    return builtin[[level.func[var_0]]](var_1, var_2);
  }

  if(!isDefined(var_4)) {
    return builtin[[level.func[var_0]]](var_1, var_2, var_3);
  }

  return builtin[[level.func[var_0]]](var_1, var_2, var_3, var_4);
}

function self_func(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.func[var_0])) {
    return;
  }

  if(!isDefined(var_1)) {
    self builtin[[level.func[var_0]]]();
    return;
  }

  if(!isDefined(var_2)) {
    self builtin[[level.func[var_0]]](var_1);
    return;
  }

  if(!isDefined(var_3)) {
    self builtin[[level.func[var_0]]](var_1, var_2);
    return;
  }

  if(!isDefined(var_4)) {
    self builtin[[level.func[var_0]]](var_1, var_2, var_3);
    return;
  }

  self builtin[[level.func[var_0]]](var_1, var_2, var_3, var_4);
}

function script_func(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.func[var_0])) {
    return;
  }

  if(!isDefined(var_1)) {
    return self[[level.func[var_0]]]();
  } else if(!isDefined(var_2)) {
    return self[[level.func[var_0]]](var_1);
  } else if(!isDefined(var_3)) {
    return self[[level.func[var_0]]](var_1, var_2);
  } else if(!isDefined(var_4)) {
    return self[[level.func[var_0]]](var_1, var_2, var_3);
  }

  return self[[level.func[var_0]]](var_1, var_2, var_3, var_4);
}

function randomvector(var_0) {
  return (randomfloat(var_0) - var_0 * 0.5, randomfloat(var_0) - var_0 * 0.5, randomfloat(var_0) - var_0 * 0.5);
}

function randomvectorrange(var_0, var_1) {
  var_2 = randomfloatrange(var_0, var_1);

  if(randomint(2) == 0) {
    var_2 *= -1;
  }

  var_3 = randomfloatrange(var_0, var_1);

  if(randomint(2) == 0) {
    var_3 *= -1;
  }

  var_4 = randomfloatrange(var_0, var_1);

  if(randomint(2) == 0) {
    var_4 *= -1;
  }

  return (var_2, var_3, var_4);
}

function sign(var_0) {
  if(var_0 >= 0) {
    return 1;
  }

  return -1;
}

function randomonunitsphere() {
  var_0 = randomfloat(180);
  var_1 = randomfloat(360);
  var_2 = cos(var_1) * cos(var_0);
  var_3 = cos(var_1) * sin(var_0);
  var_4 = sin(var_1);
  return (var_2, var_3, var_4);
}

function mod(var_0, var_1) {
  var_2 = int(var_0 / var_1);

  if(var_0 * var_1 < 0) {
    var_2 -= 1;
  }

  return var_0 - var_2 * var_1;
}

function get_enemy_team(var_0) {
  var_1 = [];
  GscBinSkip0(0x2e, "axis", "allies");
}

function clear_exception(var_0) {
  self.exception[var_0] = anim.defaultexception;
}

function cointoss() {
  return randomint(100) >= 50;
}

function choose_from_weighted_array(var_0, var_1) {
  var_2 = randomint(var_1[var_1.size - 1] + 1);

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(var_2 <= var_1[var_3]) {
      return var_0[var_3];
    }
  }
}

function waittill_string(var_0, var_1) {
  if(var_0 != "death") {
    self endon("death");
  }

  var_1 endon("die");
  self waittill(var_0);
  var_1 notify("returned", var_0);
}

function waittillmatch_string(var_0, var_1, var_2) {
  if(var_1 != "death") {
    self endon("death");
  }

  var_2 endon("die");
  self waittillmatch(var_0, var_1);
  var_2 notify("returned", var_1);
}

function waittill_string_no_endon_death(var_0, var_1) {
  var_1 endon("die");
  self waittill(var_0);
  var_1 notify("returned", var_0);
}

function waittill_multiple(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5 = spawnStruct();
  var_5.threads = 0;

  if(isDefined(var_0)) {
    GscBinSkip4(0x35, var_0, var_5);
  }

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_5);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_5);
  }

  if(isDefined(var_3)) {
    GscBinSkip4(0x35, var_3, var_5);
  }

  if(isDefined(var_4)) {
    GscBinSkip4(0x35, var_4, var_5);
  }

  while(var_5.threads) {
    var_5 waittill("returned");
    var_5.threads--;
  }

  var_5 notify("die");
}

function ref_1439f(var_0, var_1) {
  self endon("death");
  var_2 = spawnStruct();
  var_2.threads = 0;

  if(isDefined(var_0)) {
    GscBinSkip4(0x35, var_0, var_2);
  }

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_2);
  }

  while(var_2.threads) {
    var_2 waittill("returned");
    var_2.threads--;
  }

  var_2 notify("die");
}

function waittillmatch_notify(var_0, var_1, var_2) {
  self endon("death");
  self waittillmatch(var_0, var_1);
  self notify(var_2);
}

function ref_143ac(var_0) {
  if(!isDefined(var_0) || var_0 != "death") {
    self endon("death");
  }

  var_1 = spawnStruct();
  jumpiffalse(isDefined(var_0)) LOC_0000002c;
  GscBinSkip4(0x35, var_0, var_1);

  var_1 waittill("returned", var_2);
  var_1 notify("die");
  return var_2;
}

function ref_143ad(var_0, var_1) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death")) {
    self endon("death");
  }

  var_2 = spawnStruct();

  if(isDefined(var_0)) {
    GscBinSkip4(0x35, var_0, var_2);
  }

  jumpiffalse(isDefined(var_1)) LOC_0000004a;
  GscBinSkip4(0x35, var_1, var_2);

  var_2 waittill("returned", var_3);
  var_2 notify("die");
  return var_3;
}

function ref_143ae(var_0, var_1, var_2) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death")) {
    self endon("death");
  }

  var_3 = spawnStruct();

  if(isDefined(var_0)) {
    GscBinSkip4(0x35, var_0, var_3);
  }

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_3);
  }

  jumpiffalse(isDefined(var_2)) LOC_00000068;
  GscBinSkip4(0x35, var_2, var_3);

  var_3 waittill("returned", var_4);
  var_3 notify("die");
  return var_4;
}

function ref_143af(var_0, var_1, var_2, var_3) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death")) {
    self endon("death");
  }

  var_4 = spawnStruct();

  if(isDefined(var_0)) {
    GscBinSkip4(0x35, var_0, var_4);
  }

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_4);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_4);
  }

  jumpiffalse(isDefined(var_3)) LOC_00000086;
  GscBinSkip4(0x35, var_3, var_4);

  var_4 waittill("returned", var_5);
  var_4 notify("die");
  return var_5;
}

function ref_143b0(var_0, var_1, var_2, var_3, var_4) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death")) {
    self endon("death");
  }

  var_5 = spawnStruct();

  if(isDefined(var_0)) {
    GscBinSkip4(0x35, var_0, var_5);
  }

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_5);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_5);
  }

  if(isDefined(var_3)) {
    GscBinSkip4(0x35, var_3, var_5);
  }

  jumpiffalse(isDefined(var_4)) LOC_000000a4;
  GscBinSkip4(0x35, var_4, var_5);

  var_5 waittill("returned", var_6);
  var_5 notify("die");
  return var_6;
}

function ref_143b1(var_0, var_1, var_2, var_3, var_4, var_5) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death")) {
    self endon("death");
  }

  var_6 = spawnStruct();

  if(isDefined(var_0)) {
    GscBinSkip4(0x35, var_0, var_6);
  }

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_6);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_6);
  }

  if(isDefined(var_3)) {
    GscBinSkip4(0x35, var_3, var_6);
  }

  if(isDefined(var_4)) {
    GscBinSkip4(0x35, var_4, var_6);
  }

  jumpiffalse(isDefined(var_5)) LOC_000000c4;
  GscBinSkip4(0x35, var_5, var_6);

  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

function ref_143b2(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death")) {
    self endon("death");
  }

  var_7 = spawnStruct();

  if(isDefined(var_0)) {
    GscBinSkip4(0x35, var_0, var_7);
  }

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_7);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_7);
  }

  if(isDefined(var_3)) {
    GscBinSkip4(0x35, var_3, var_7);
  }

  if(isDefined(var_4)) {
    GscBinSkip4(0x35, var_4, var_7);
  }

  if(isDefined(var_5)) {
    GscBinSkip4(0x35, var_5, var_7);
  }

  jumpiffalse(isDefined(var_6)) LOC_000000e6;
  GscBinSkip4(0x35, var_6, var_7);

  var_7 waittill("returned", var_8);
  var_7 notify("die");
  return var_8;
}

function waittill_any_return(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death") && (!isDefined(var_7) || var_7 != "death")) {
    self endon("death");
  }

  var_8 = spawnStruct();

  if(isDefined(var_0)) {
    GscBinSkip4(0x35, var_0, var_8);
  }

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_8);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_8);
  }

  if(isDefined(var_3)) {
    GscBinSkip4(0x35, var_3, var_8);
  }

  if(isDefined(var_4)) {
    GscBinSkip4(0x35, var_4, var_8);
  }

  if(isDefined(var_5)) {
    GscBinSkip4(0x35, var_5, var_8);
  }

  if(isDefined(var_6)) {
    GscBinSkip4(0x35, var_6, var_8);
  }

  jumpiffalse(isDefined(var_7)) LOC_00000108;
  GscBinSkip4(0x35, var_7, var_8);

  var_8 waittill("returned", var_9);
  var_8 notify("die");
  return var_9;
}

function waittillmatch_any_return(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death")) {
    self endon("death");
  }

  var_7 = spawnStruct();

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_0, var_1, var_7);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_0, var_2, var_7);
  }

  if(isDefined(var_3)) {
    GscBinSkip4(0x35, var_0, var_3, var_7);
  }

  if(isDefined(var_4)) {
    GscBinSkip4(0x35, var_0, var_4, var_7);
  }

  if(isDefined(var_5)) {
    GscBinSkip4(0x35, var_0, var_5, var_7);
  }

  jumpiffalse(isDefined(var_6)) LOC_000000d1;
  GscBinSkip4(0x35, var_0, var_6, var_7);

  var_7 waittill("returned", var_8);
  var_7 notify("die");
  return var_8;
}

function ref_143b3(var_0) {
  var_1 = spawnStruct();
  jumpiffalse(isDefined(var_0)) LOC_00000015;
  GscBinSkip4(0x35, var_0, var_1);

  var_1 waittill("returned", var_2);
  var_1 notify("die");
  return var_2;
}

function ref_143b4(var_0, var_1) {
  var_2 = spawnStruct();

  if(isDefined(var_0)) {
    GscBinSkip4(0x35, var_0, var_2);
  }

  jumpiffalse(isDefined(var_1)) LOC_00000023;
  GscBinSkip4(0x35, var_1, var_2);

  var_2 waittill("returned", var_3);
  var_2 notify("die");
  return var_3;
}

function ref_143b5(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  if(isDefined(var_0)) {
    GscBinSkip4(0x35, var_0, var_3);
  }

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_3);
  }

  jumpiffalse(isDefined(var_2)) LOC_00000031;
  GscBinSkip4(0x35, var_2, var_3);

  var_3 waittill("returned", var_4);
  var_3 notify("die");
  return var_4;
}

function ref_143b6(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();

  if(isDefined(var_0)) {
    GscBinSkip4(0x35, var_0, var_4);
  }

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_4);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_4);
  }

  jumpiffalse(isDefined(var_3)) LOC_0000003f;
  GscBinSkip4(0x35, var_3, var_4);

  var_4 waittill("returned", var_5);
  var_4 notify("die");
  return var_5;
}

function ref_143b7(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();

  if(isDefined(var_0)) {
    GscBinSkip4(0x35, var_0, var_5);
  }

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_5);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_5);
  }

  if(isDefined(var_3)) {
    GscBinSkip4(0x35, var_3, var_5);
  }

  jumpiffalse(isDefined(var_4)) LOC_0000004d;
  GscBinSkip4(0x35, var_4, var_5);

  var_5 waittill("returned", var_6);
  var_5 notify("die");
  return var_6;
}

function ref_143b8(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();

  if(isDefined(var_0)) {
    GscBinSkip4(0x35, var_0, var_6);
  }

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_6);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_6);
  }

  if(isDefined(var_3)) {
    GscBinSkip4(0x35, var_3, var_6);
  }

  if(isDefined(var_4)) {
    GscBinSkip4(0x35, var_4, var_6);
  }

  jumpiffalse(isDefined(var_5)) LOC_0000005d;
  GscBinSkip4(0x35, var_5, var_6);

  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

function waittill_any_return_no_endon_death(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();

  if(isDefined(var_0)) {
    GscBinSkip4(0x35, var_0, var_6);
  }

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_6);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_6);
  }

  if(isDefined(var_3)) {
    GscBinSkip4(0x35, var_3, var_6);
  }

  if(isDefined(var_4)) {
    GscBinSkip4(0x35, var_4, var_6);
  }

  jumpiffalse(isDefined(var_5)) LOC_0000005d;
  GscBinSkip4(0x35, var_5, var_6);

  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

function waittill_any_in_array_return(var_0) {
  var_1 = spawnStruct();
  var_2 = 0;
  var_3 = var_0;
  var_5 = getfirstarraykey(var_3);

  if(isDefined(var_5)) {
    var_4 = var_3[var_5];
    GscBinSkip4(0x35, var_4, var_1);
  }

  var_3 = undefined;
  var_5 = undefined;
  jumpiftrue(var_2) LOC_0000004d;
  self endon("death");
  var_1 waittill("returned", var_6);
  var_1 notify("die");
  return var_6;
}

function waittill_any_in_array_return_no_endon_death(var_0) {
  var_1 = spawnStruct();
  var_2 = var_0;
  var_4 = getfirstarraykey(var_2);

  if(isDefined(var_4)) {
    var_3 = var_2[var_4];
    GscBinSkip4(0x35, var_3, var_1);
  }

  var_2 = undefined;
  var_4 = undefined;
  var_1 waittill("returned", var_5);
  var_1 notify("die");
  return var_5;
}

function waittill_any_in_array_or_timeout(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = 0;
  var_4 = var_0;
  var_6 = getfirstarraykey(var_4);

  if(isDefined(var_6)) {
    var_5 = var_4[var_6];
    GscBinSkip4(0x35, var_5, var_2);
  }

  var_4 = undefined;
  var_6 = undefined;

  if(!var_3) {
    self endon("death");
  }

  GscBinSkip4(0x6e, var_2, var_1);
}

function waittill_any_in_array_or_timeout_no_endon_death(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = var_0;
  var_5 = getfirstarraykey(var_3);

  if(isDefined(var_5)) {
    var_4 = var_3[var_5];
    GscBinSkip4(0x35, var_4, var_2);
  }

  var_3 = undefined;
  var_5 = undefined;
  thread _timeout(var_2);
  var_2 waittill("returned", var_6);
  var_2 notify("die");
  return var_6;
}

function waittill_all_in_array(var_0) {
  while(var_0.size) {
    var_1 = waittill_any_in_array_return(var_0);
    var_0 = array_remove(var_0, var_1);
  }
}

function ref_143b9(var_0, var_1) {
  if(!isDefined(var_1) || var_1 != "death") {
    self endon("death");
  }

  var_2 = spawnStruct();

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_2);
  }

  GscBinSkip4(0x6e, var_2, var_0);
}

function ref_143ba(var_0, var_1, var_2) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death")) {
    self endon("death");
  }

  var_3 = spawnStruct();

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_3);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_3);
  }

  GscBinSkip4(0x6e, var_3, var_0);
}

function ref_143bb(var_0, var_1, var_2, var_3) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death")) {
    self endon("death");
  }

  var_4 = spawnStruct();

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_4);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_4);
  }

  if(isDefined(var_3)) {
    GscBinSkip4(0x35, var_3, var_4);
  }

  GscBinSkip4(0x6e, var_4, var_0);
}

function ref_143bc(var_0, var_1, var_2, var_3, var_4) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death")) {
    self endon("death");
  }

  var_5 = spawnStruct();

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_5);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_5);
  }

  if(isDefined(var_3)) {
    GscBinSkip4(0x35, var_3, var_5);
  }

  if(isDefined(var_4)) {
    GscBinSkip4(0x35, var_4, var_5);
  }

  GscBinSkip4(0x6e, var_5, var_0);
}

function ref_143bd(var_0, var_1, var_2, var_3, var_4, var_5) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death")) {
    self endon("death");
  }

  var_6 = spawnStruct();

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_6);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_6);
  }

  if(isDefined(var_3)) {
    GscBinSkip4(0x35, var_3, var_6);
  }

  if(isDefined(var_4)) {
    GscBinSkip4(0x35, var_4, var_6);
  }

  if(isDefined(var_5)) {
    GscBinSkip4(0x35, var_5, var_6);
  }

  GscBinSkip4(0x6e, var_6, var_0);
}

function ref_143be(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death")) {
    self endon("death");
  }

  var_7 = spawnStruct();

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_7);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_7);
  }

  if(isDefined(var_3)) {
    GscBinSkip4(0x35, var_3, var_7);
  }

  if(isDefined(var_4)) {
    GscBinSkip4(0x35, var_4, var_7);
  }

  if(isDefined(var_5)) {
    GscBinSkip4(0x35, var_5, var_7);
  }

  if(isDefined(var_6)) {
    GscBinSkip4(0x35, var_6, var_7);
  }

  GscBinSkip4(0x6e, var_7, var_0);
}

function waittill_any_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death")) {
    self endon("death");
  }

  var_7 = spawnStruct();

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_7);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_7);
  }

  if(isDefined(var_3)) {
    GscBinSkip4(0x35, var_3, var_7);
  }

  if(isDefined(var_4)) {
    GscBinSkip4(0x35, var_4, var_7);
  }

  if(isDefined(var_5)) {
    GscBinSkip4(0x35, var_5, var_7);
  }

  if(isDefined(var_6)) {
    GscBinSkip4(0x35, var_6, var_7);
  }

  GscBinSkip4(0x6e, var_7, var_0);
}

function _timeout(var_0) {
  self endon("die");
  wait var_0;
  self notify("returned", "timeout");
}

function ref_143bf(var_0, var_1) {
  var_2 = spawnStruct();

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_2);
  }

  GscBinSkip4(0x6e, var_2, var_0);
}

function ref_143c0(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_3);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_3);
  }

  GscBinSkip4(0x6e, var_3, var_0);
}

function ref_143c1(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_4);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_4);
  }

  if(isDefined(var_3)) {
    GscBinSkip4(0x35, var_3, var_4);
  }

  GscBinSkip4(0x6e, var_4, var_0);
}

function ref_143c2(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_5);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_5);
  }

  if(isDefined(var_3)) {
    GscBinSkip4(0x35, var_3, var_5);
  }

  if(isDefined(var_4)) {
    GscBinSkip4(0x35, var_4, var_5);
  }

  GscBinSkip4(0x6e, var_5, var_0);
}

function ref_143c3(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_6);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_6);
  }

  if(isDefined(var_3)) {
    GscBinSkip4(0x35, var_3, var_6);
  }

  if(isDefined(var_4)) {
    GscBinSkip4(0x35, var_4, var_6);
  }

  if(isDefined(var_5)) {
    GscBinSkip4(0x35, var_5, var_6);
  }

  GscBinSkip4(0x6e, var_6, var_0);
}

function waittill_any_timeout_no_endon_death(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_6);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_6);
  }

  if(isDefined(var_3)) {
    GscBinSkip4(0x35, var_3, var_6);
  }

  if(isDefined(var_4)) {
    GscBinSkip4(0x35, var_4, var_6);
  }

  if(isDefined(var_5)) {
    GscBinSkip4(0x35, var_5, var_6);
  }

  GscBinSkip4(0x6e, var_6, var_0);
}

function ref_143a5(var_0, var_1) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  self waittill(var_0);
}

function ref_143a6(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  self waittill(var_0);
}

function ref_143a7(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  if(isDefined(var_3)) {
    self endon(var_3);
  }

  self waittill(var_0);
}

function ref_143a8(var_0, var_1, var_2, var_3, var_4) {
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

  self waittill(var_0);
}

function ref_143a9(var_0, var_1, var_2, var_3, var_4, var_5) {
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

  self waittill(var_0);
}

function ref_143aa(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
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

  self waittill(var_0);
}

function ref_143ab(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
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

function waittill_any(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
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

function waittill_any_two(var_0, var_1) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  self waittill(var_0);
}

function waittill_any_ents(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
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

function waittill_any_ents_return(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  self endon("death");
  var_14 = spawnStruct();
  GscBinSkip4(0x6e, var_0, var_1, var_14);
}

function waittill_any_ents_array(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  foreach(var_9 in var_0) {
    if(var_9 != var_0[0]) {
      var_9 endon(var_1);
    }

    if(isDefined(var_2)) {
      var_9 endon(var_2);
    }

    if(isDefined(var_3)) {
      var_9 endon(var_3);
    }

    if(isDefined(var_4)) {
      var_9 endon(var_4);
    }

    if(isDefined(var_5)) {
      var_9 endon(var_5);
    }

    if(isDefined(var_6)) {
      var_9 endon(var_6);
    }

    if(isDefined(var_7)) {
      var_9 endon(var_7);
    }
  }

  var_0[0] waittill(var_1);
}

function wait_time_in_ms(var_0) {
  var_1 = gettime() + var_0;

  while(gettime() < var_1) {
    waitframe();
  }
}

function script_delay() {
  if(isDefined(self.script_delay)) {
    wait self.script_delay;
    return true;
  } else if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max)) {
    wait randomfloatrange(self.script_delay_min, self.script_delay_max);
    return true;
  }

  return false;
}

function script_wait() {
  var_0 = gettime();

  if(isDefined(self.script_wait)) {
    wait self.script_wait;

    if(isDefined(self.script_wait_add)) {
      self.script_wait += self.script_wait_add;
    }
  } else if(isDefined(self.script_wait_min) && isDefined(self.script_wait_max)) {
    wait randomfloatrange(self.script_wait_min, self.script_wait_max);

    if(isDefined(self.script_wait_add)) {
      self.script_wait_min += self.script_wait_add;
      self.script_wait_max += self.script_wait_add;
    }
  }

  return gettime() - var_0;
}

function isflashed() {
  if(!isDefined(self.flashendtime)) {
    return false;
  }

  return gettime() < self.flashendtime;
}

function flag_exist(var_0) {
  if(!isDefined(level.flag)) {
    return false;
  }

  return isDefined(level.flag[var_0]);
}

function flag(var_0) {
  return level.flag[var_0];
}

function flag_init(var_0) {
  if(!isDefined(level.flag)) {
    scripts\engine\flags::init_flags();
  }

  level.flag[var_0] = 0;
  init_trigger_flags();

  if(!isDefined(level.trigger_flags[var_0])) {
    level.trigger_flags[var_0] = [];
    return;
  }
}

function empty_init_func(var_0) {}

function flag_set(var_0, var_1) {
  level.flag[var_0] = 1;
  set_trigger_flag_permissions(var_0);

  if(isDefined(var_1)) {
    level notify(var_0, var_1);
    return;
  }

  level notify(var_0);
}

function flag_wait(var_0) {
  var_1 = undefined;

  while(!flag(var_0)) {
    var_1 = undefined;
    level waittill(var_0, var_1);
  }

  if(isDefined(var_1)) {
    return var_1;
  }
}

function flag_clear(var_0) {
  if(!flag(var_0)) {
    return;
  }

  level.flag[var_0] = 0;
  set_trigger_flag_permissions(var_0);
  level notify(var_0);
}

function flag_waitopen(var_0) {
  while(flag(var_0)) {
    level waittill(var_0);
  }
}

function waittill_either(var_0, var_1) {
  self endon(var_0);
  self waittill(var_1);
  return var_1;
}

function trigger_on(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = getEntArray(var_0, var_1);
    array_thread(var_2, &trigger_on_proc);
    return;
  }

  trigger_on_proc();
}

function trigger_on_proc() {
  self triggerenable();
  self.trigger_off = undefined;
}

function trigger_off(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = getEntArray(var_0, var_1);
    array_thread(var_2, &trigger_off_proc);
    return;
  }

  trigger_off_proc();
}

function trigger_off_proc() {
  self triggerdisable();
  self.trigger_off = 1;
  self notify("trigger_off");
}

function set_trigger_flag_permissions(var_0) {
  if(!isDefined(level.trigger_flags)) {
    return;
  }

  level.trigger_flags[var_0] = array_removeundefined(level.trigger_flags[var_0]);
  array_thread(level.trigger_flags[var_0], &update_trigger_based_on_flags);
}

function update_trigger_based_on_flags() {
  var_0 = 1;

  if(isDefined(self.script_flag_true)) {
    var_0 = 0;
    var_1 = create_flags_and_return_tokens(self.script_flag_true);

    foreach(var_3 in var_1) {
      if(flag(var_3)) {
        var_0 = 1;
        break;
      }
    }
  }

  var_5 = 1;

  if(isDefined(self.script_flag_false)) {
    var_1 = create_flags_and_return_tokens(self.script_flag_false);

    foreach(var_3 in var_1) {
      if(flag(var_3)) {
        var_5 = 0;
        break;
      }
    }
  }

  [[level.trigger_func[var_0 && var_5]]]();
}

function create_flags_and_return_tokens(var_0) {
  var_1 = strtok(var_0, " ");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isDefined(level.flag[var_1[var_2]])) {
      flag_init(var_1[var_2]);
    }
  }

  return var_1;
}

function init_trigger_flags() {
  if(!add_init_script("trigger_flags", &init_trigger_flags)) {
    return;
  }

  level.trigger_flags = [];
  level.trigger_func[1] = &trigger_on;
  level.trigger_func[0] = &trigger_off;
}

function getStruct(var_0, var_1) {
  var_2 = level.struct_class_names[var_1][var_0];

  if(!isDefined(var_2)) {
    return undefined;
  }

  if(var_2.size > 1) {
    return undefined;
  }

  return var_2[0];
}

function getStructArray(var_0, var_1) {
  var_2 = level.struct_class_names[var_1][var_0];

  if(!isDefined(var_2)) {
    return [];
  }

  return var_2;
}

function add_smartobject_point(var_0) {
  if(!isDefined(anim.smartobjectpoints)) {
    anim.smartobjectpoints = [];
  }

  anim.smartobjectpoints[anim.smartobjectpoints.size] = var_0;
}

function store_linked_smartobjects() {
  if(!isDefined(anim.smartobjectpoints)) {
    return;
  }

  foreach(var_1 in anim.smartobjectpoints) {
    if(isDefined(var_1.script_linkto)) {
      var_2 = get_linked_structs(var_1);

      foreach(var_4 in var_2) {
        if(var_4 == var_1) {
          continue;
        }

        if(!isDefined(var_4.script_smartobject)) {
          continue;
        }

        if(!isDefined(var_1.linkedsmartobjects)) {
          var_1.linkedsmartobjects = [];
        }

        var_1.linkedsmartobjects[var_1.linkedsmartobjects.size] = var_4;
      }
    }
  }
}

function init_struct_class() {
  if(!add_init_script("struct_classes", &init_struct_class)) {
    return;
  }

  level.struct_class_names = [];
  level.struct_class_names["target"] = [];
  level.struct_class_names["targetname"] = [];
  level.struct_class_names["script_noteworthy"] = [];
  level.struct_class_names["script_linkname"] = [];

  foreach(var_1 in level.struct) {
    if(isDefined(var_1.script_smartobject)) {
      add_smartobject_point(var_1);
    }

    if(isDefined(var_1.targetname)) {
      if(var_1.targetname == "delete_on_load") {
        level.struct[var_3] = undefined;
        continue;
      }

      if(isDefined(level.struct_filter)) {
        if(![[level.struct_filter]](var_1)) {
          level.struct[var_3] = undefined;
          continue;
        }
      }

      if(!isDefined(level.struct_class_names["targetname"][var_1.targetname])) {
        level.struct_class_names["targetname"][var_1.targetname] = [];
      }

      var_2 = level.struct_class_names["targetname"][var_1.targetname].size;
      level.struct_class_names["targetname"][var_1.targetname][var_2] = var_1;
    }

    if(isDefined(var_1.target)) {
      if(!isDefined(level.struct_class_names["target"][var_1.target])) {
        level.struct_class_names["target"][var_1.target] = [];
      }

      var_2 = level.struct_class_names["target"][var_1.target].size;
      level.struct_class_names["target"][var_1.target][var_2] = var_1;
    }

    if(isDefined(var_1.script_noteworthy)) {
      if(!isDefined(level.struct_class_names["script_noteworthy"][var_1.script_noteworthy])) {
        level.struct_class_names["script_noteworthy"][var_1.script_noteworthy] = [];
      }

      var_2 = level.struct_class_names["script_noteworthy"][var_1.script_noteworthy].size;
      level.struct_class_names["script_noteworthy"][var_1.script_noteworthy][var_2] = var_1;
    }

    if(isDefined(var_1.script_linkname)) {
      if(!isDefined(level.struct_class_names["script_linkname"][var_1.script_linkname])) {
        level.struct_class_names["script_linkname"][var_1.script_linkname] = [];
      }

      var_2 = level.struct_class_names["script_linkname"][var_1.script_linkname].size;
      level.struct_class_names["script_linkname"][var_1.script_linkname][var_2] = var_1;
    }
  }

  store_linked_smartobjects();
}

function deletestructarray(var_0, var_1, var_2) {
  var_3 = getStructArray(var_0, var_1);
  deletestructarray_ref(var_3, var_2);
}

function deletestruct_ref(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = var_0.script_linkname;

  if(isDefined(var_1) && isDefined(level.struct_class_names["script_linkname"]) && isDefined(level.struct_class_names["script_linkname"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["script_linkname"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level.struct_class_names["script_linkname"][var_1][var_4] = undefined;
      }
    }

    if(level.struct_class_names["script_linkname"][var_1].size == 0) {
      level.struct_class_names["script_linkname"][var_1] = undefined;
    }
  }

  var_1 = var_0.script_noteworthy;

  if(isDefined(var_1) && isDefined(level.struct_class_names["script_noteworthy"]) && isDefined(level.struct_class_names["script_noteworthy"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["script_noteworthy"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level.struct_class_names["script_noteworthy"][var_1][var_4] = undefined;
      }
    }

    if(level.struct_class_names["script_noteworthy"][var_1].size == 0) {
      level.struct_class_names["script_noteworthy"][var_1] = undefined;
    }
  }

  var_1 = var_0.target;

  if(isDefined(var_1) && isDefined(level.struct_class_names["target"]) && isDefined(level.struct_class_names["target"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["target"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level.struct_class_names["target"][var_1][var_4] = undefined;
      }
    }

    if(level.struct_class_names["target"][var_1].size == 0) {
      level.struct_class_names["target"][var_1] = undefined;
    }
  }

  var_1 = var_0.targetname;

  if(isDefined(var_1) && isDefined(level.struct_class_names["targetname"]) && isDefined(level.struct_class_names["targetname"][var_1])) {
    foreach(var_3 in level.struct_class_names["targetname"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level.struct_class_names["targetname"][var_1][var_4] = undefined;
      }
    }

    if(level.struct_class_names["targetname"][var_1].size == 0) {
      level.struct_class_names["targetname"][var_1] = undefined;
    }
  }

  if(isDefined(level.struct)) {
    if(level.struct.size > 5000) {
      var_8 = 2500;
      var_9 = 0;
      var_10 = var_8;
      ref_12c27(var_0, var_9, var_10);

      while(var_10 < level.struct.size) {
        var_9 = var_10 + 1;
        var_10 = ter_op(var_10 + var_8 < level.struct.size, var_10 + var_8, level.struct.size);
        ref_12c27(var_0, var_9, var_10);
      }

      return;
    }

    ref_12c27(var_0, 0, level.struct.size);
    return;
  }
}

function ref_12c27(var_0, var_1, var_2) {
  for(var_3 = var_1; var_3 <= var_2; var_3++) {
    var_4 = level.struct[var_3];

    if(isDefined(var_4) && var_0 == var_4) {
      level.struct[var_3] = undefined;
    }
  }
}

function deletestructarray_ref(var_0, var_1) {
  if(!isDefined(var_0) || !isarray(var_0) || var_0.size == 0) {
    return;
  }

  var_1 = ter_op(isDefined(var_1), var_1, 0);
  var_1 = ter_op(var_1 > 0, var_1, 0);
  jumpiffalse(var_1 > 0) LOC_00000062;

  foreach(var_3 in var_0) {
    deletestruct_ref(var_3);
    wait var_1;
  }

  return;
}

function getstruct_delete(var_0, var_1) {
  var_2 = getStruct(var_0, var_1);
  deletestruct_ref(var_2);
  return var_2;
}

function getstructarray_delete(var_0, var_1, var_2) {
  var_3 = getStructArray(var_0, var_1);
  deletestructarray_ref(var_3, var_2);
  return var_3;
}

function getent_or_struct(var_0, var_1) {
  var_2 = getEnt(var_0, var_1);

  if(isDefined(var_2)) {
    return var_2;
  }

  return getStruct(var_0, var_1);
}

function fileprint_start(var_0) {}

function fileprint_map_start() {}

function fileprint_map_header(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
    return;
  }
}

function fileprint_map_keypairprint(var_0, var_1) {}

function fileprint_map_entity_start() {}

function fileprint_map_entity_end() {}

function fileprint_radiant_vec(var_0) {}

function call_on_notify_no_endon_death(var_0, var_1, var_2, var_3) {
  GscBinSkip4(0x35, var_0, var_1, var_2, var_3);
}

function call_on_notify(var_0, var_1, var_2, var_3) {
  self endon("death");
  GscBinSkip4(0x35, var_0, var_1, var_2, var_3);
}

function call_on_notify_proc(var_0, var_1, var_2, var_3) {
  self waittill(var_0);

  if(isDefined(var_3)) {
    self builtin[[var_1]](var_2, var_3);
    return;
  }

  if(isDefined(var_2)) {
    self builtin[[var_1]](var_2);
    return;
  }

  self builtin[[var_1]]();
}

function thread_on_notify_no_endon_death(var_0, var_1, var_2, var_3, var_4) {
  GscBinSkip4(0x35, var_0, var_1, var_2, var_3, var_4);
}

function thread_on_notify(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");

  if(isDefined(var_5) && isDefined(var_6)) {
    if(!isarray(var_5)) {
      var_5 = [var_5];
    }

    if(!isarray(var_6)) {
      var_6 = [var_6];
    }

    foreach(var_8 in var_5) {
      foreach(var_10 in var_6) {
        var_8 endon(var_10);
      }
    }
  }

  GscBinSkip4(0x35, var_0, var_1, var_2, var_3, var_4);
}

function thread_on_notify_proc(var_0, var_1, var_2, var_3, var_4) {
  self waittill(var_0);

  if(!isDefined(var_4)) {
    var_4 = self;
  }

  if(isDefined(var_3)) {
    var_4 thread[[var_1]](var_2, var_3);
    return;
  }

  if(isDefined(var_2)) {
    var_4 thread[[var_1]](var_2);
    return;
  }

  var_4 thread[[var_1]]();
}

function delaycall(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  thread delaycall_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
}

function delaycallwatchself(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  thread delaycall_proc_watchself(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
}

function delaycall_proc_watchself(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  self endon("disconnect");
  self endon("death");
  delaycall_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
}

function delaycall_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(scripts\common\utility::issp()) {
    self endon("death");
    self endon("stop_delay_call");
  }

  wait var_1;

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(var_13)) {
    self builtin[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    return;
  }

  if(isDefined(var_12)) {
    self builtin[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    return;
  }

  if(isDefined(var_11)) {
    self builtin[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    return;
  }

  if(isDefined(var_10)) {
    self builtin[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    return;
  }

  if(isDefined(var_9)) {
    self builtin[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    return;
  }

  if(isDefined(var_8)) {
    self builtin[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    return;
  }

  if(isDefined(var_7)) {
    self builtin[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
    return;
  }

  if(isDefined(var_6)) {
    self builtin[[var_0]](var_2, var_3, var_4, var_5, var_6);
    return;
  }

  if(isDefined(var_5)) {
    self builtin[[var_0]](var_2, var_3, var_4, var_5);
    return;
  }

  if(isDefined(var_4)) {
    self builtin[[var_0]](var_2, var_3, var_4);
    return;
  }

  if(isDefined(var_3)) {
    self builtin[[var_0]](var_2, var_3);
    return;
  }

  if(isDefined(var_2)) {
    self builtin[[var_0]](var_2);
    return;
  }

  self builtin[[var_0]]();
}

function string_starts_with(var_0, var_1) {
  if(var_0.size < var_1.size) {
    return false;
  }

  var_2 = getsubstr(var_0, 0, var_1.size);

  if(var_2 == var_1) {
    return true;
  }

  return false;
}

function plot_points(var_0, var_1, var_2, var_3, var_4) {
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

function draw_line_for_time(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_5 = gettime() + var_5 * 1000;

  while(gettime() < var_5) {
    wait 0.05;
  }
}

function draw_circle(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 16;

  if(isDefined(var_6)) {
    var_7 = var_6;
  }

  var_8 = 360 / var_7;
  var_9 = [];

  for(var_10 = 0; var_10 < var_7; var_10++) {
    var_11 = var_8 * var_10;
    var_12 = cos(var_11) * var_1;
    var_13 = sin(var_11) * var_1;
    var_14 = var_0[0] + var_12;
    var_15 = var_0[1] + var_13;
    var_16 = var_0[2];
    var_9 = (var_14, var_15, var_16);
  }

  for(var_10 = 0; var_10 < var_9.size; var_10++) {
    var_17 = var_9[var_10];

    if(var_10 + 1 >= var_9.size) {
      var_18 = var_9[0];
      continue;
    }

    var_18 = var_9[var_10 + 1];
  }
}

function array_add(var_0, var_1) {
  var_0 = var_1;
  return var_0;
}

function array_add_safe(var_0, var_1) {
  if(!isDefined(var_1)) {
    return var_0;
  }

  if(!isDefined(var_0)) {
    var_0 = var_1;
  } else {
    var_0 = var_1;
  }

  return var_0;
}

function array_delete(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 delete();
    }
  }
}

function array_insert(var_0, var_1, var_2) {
  if(var_2 == var_0.size) {
    var_3 = var_0;
    GscBinSkip0(0x2e, var_3.size, var_1);
  }

  var_3 = [];
  var_4 = 0;

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    if(var_5 == var_3) {
      var_3 = var_2;
      var_4 = 1;
    }

    var_3 = var_1[var_5];
  }

  return var_3;
}

function array_combine(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];

  if(isDefined(var_0)) {
    foreach(var_7 in var_0) {
      var_5 = var_7;
    }
  }

  if(isDefined(var_1)) {
    foreach(var_7 in var_1) {
      var_5 = var_7;
    }
  }

  if(isDefined(var_2)) {
    foreach(var_7 in var_2) {
      var_5 = var_7;
    }
  }

  if(isDefined(var_3)) {
    foreach(var_7 in var_3) {
      var_5 = var_7;
    }
  }

  if(isDefined(var_4)) {
    foreach(var_7 in var_4) {
      var_5 = var_7;
    }
  }

  return var_5;
}

function array_combine_multiple(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    foreach(var_5 in var_3) {
      var_1 = var_5;
    }
  }

  return var_1;
}

function array_combine_unique(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_2 = var_4;
  }

  foreach(var_4 in var_1) {
    if(array_contains(var_2, var_4)) {
      continue;
    }

    var_2 = var_4;
  }

  return var_2;
}

function array_combine_unique_keys(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(!isDefined(var_0[var_4])) {
      var_0 = var_3;
    }
  }

  return var_0;
}

function array_combine_non_integer_indices(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    var_2 = var_4;
  }

  foreach(var_4 in var_1) {
    var_2 = var_4;
  }

  return var_2;
}

function array_intersection(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(array_contains(var_1, var_4)) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function array_has_intersection(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(array_contains(var_1, var_3)) {
      return true;
    }
  }

  return false;
}

function array_difference(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(!array_contains(var_1, var_4)) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function can_be_shot_again(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_1 = var_3;
  }

  return var_1;
}

function array_randomize(var_0) {
  for(var_1 = 0; var_1 < var_0.size - 1; var_1++) {
    var_2 = randomintrange(var_1, var_0.size);
    var_3 = var_0[var_1];
    var_0 = var_0[var_2];
    var_0 = var_3;
  }

  return var_0;
}

function array_randomize_objects(var_0) {
  var_1 = [];

  for(var_2 = var_0; var_2.size > 0; var_2 = var_4) {
    var_3 = randomintrange(0, var_2.size);
    var_4 = [];
    var_5 = 0;

    foreach(var_8, var_7 in var_2) {
      if(var_5 == var_3) {
        var_1 = var_7;
      } else {
        var_4 = var_7;
      }

      var_5++;
    }
  }

  return var_1;
}

function array_reverse(var_0) {
  var_1 = [];

  for(var_2 = var_0.size - 1; var_2 >= 0; var_2--) {
    var_1 = var_0[var_2];
  }

  return var_1;
}

function array_slice(var_0, var_1, var_2) {
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
    var_3 = var_0[var_4];
  }

  return var_3;
}

function array_contains(var_0, var_1) {
  if(var_0.size <= 0) {
    return false;
  }

  foreach(var_3 in var_0) {
    if(var_3 == var_1) {
      return true;
    }
  }

  return false;
}

function array_contains_key(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_4 == var_1) {
      return true;
    }
  }

  return false;
}

function array_find(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3 == var_1) {
      return var_4;
    }
  }

  return undefined;
}

function array_remove(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(var_4 != var_1) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function array_remove_array(var_0, var_1) {
  foreach(var_3 in var_1) {
    var_0 = array_remove(var_0, var_3);
  }

  return var_0;
}

function array_remove_index(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_0) {
    if(var_7 == var_1) {
      continue;
    }

    if(istrue(var_2)) {
      var_6 = var_7;
    } else {
      var_6 = var_3.size;
    }

    var_3 = var_5;
  }

  return var_3;
}

function can_path_to_target(var_0, var_1) {
  if(var_1 < 0 || var_1 >= var_0.size) {
    return var_0;
  }

  for(var_2 = var_1; var_2 < var_0.size - 1; var_2++) {
    var_0 = var_0[var_2 + 1];
  }

  var_0[var_0.size - 1] = undefined;
  return var_0;
}

function array_removeundefined(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_1 = var_3;
  }

  return var_1;
}

function array_removedead(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }

    var_1 = var_3;
  }

  return var_1;
}

function array_remove_key(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(var_1 == var_5) {
      continue;
    }

    var_2 = var_4;
  }

  return var_2;
}

function array_remove_duplicates(var_0) {
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
      var_1 = var_3;
    }
  }

  return var_1;
}

function array_get_first_item(var_0) {
  foreach(var_2 in var_0) {
    return var_2;
  }

  var_2 = undefined;
  return undefined;
}

function array_levelthread(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    var_5 = var_0;
    var_7 = getfirstarraykey(var_5);

    if(isDefined(var_7)) {
      var_6 = var_5[var_7];
      GscBinSkip1(0x74, var_1, var_6, var_2, var_3, var_4);
    }

    var_5 = undefined;
    var_7 = undefined;
    return;
  }

  if(isDefined(var_6)) {
    var_8 = var_3;
    var_9 = getfirstarraykey(var_8);

    if(isDefined(var_9)) {
      var_6 = var_8[var_9];
      GscBinSkip1(0x74, var_4, var_6, var_5, var_6);
    }

    var_8 = undefined;
    var_9 = undefined;
    return;
  }

  if(isDefined(var_8)) {
    var_10 = var_6;
    var_11 = getfirstarraykey(var_10);

    if(isDefined(var_11)) {
      var_6 = var_10[var_11];
      GscBinSkip1(0x74, var_7, var_6, var_8);
    }

    var_10 = undefined;
    var_11 = undefined;
    return;
  }

  var_12 = var_6;
  var_13 = getfirstarraykey(var_12);

  if(isDefined(var_13)) {
    var_6 = var_12[var_13];
    GscBinSkip1(0x74, var_9, var_6);
  }

  var_12 = undefined;
  var_13 = undefined;
}

function array_levelcall(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    foreach(var_6 in var_0) {
      builtin[[var_1]](var_6, var_2, var_3, var_4);
    }

    return;
  }

  if(isDefined(var_6)) {
    foreach(var_6 in var_3) {
      builtin[[var_4]](var_6, var_5, var_6);
    }

    return;
  }

  if(isDefined(var_8)) {
    foreach(var_6 in var_6) {
      builtin[[var_7]](var_6, var_8);
    }

    return;
  }

  foreach(var_6 in var_6) {
    builtin[[var_9]](var_6);
  }
}

function array_sort_with_func(var_0, var_1) {
  for(var_2 = 1; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    for(var_4 = var_2 - 1; var_4 >= 0 && ![[var_1]](var_0[var_4], var_3); var_4--) {
      var_0 = var_0[var_4];
    }

    var_0 = var_3;
  }

  return var_0;
}

function array_average(var_0) {
  return array_sum(var_0) / var_0.size;
}

function array_sum(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    var_1 += var_3;
  }

  return var_1;
}

function array_divide(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0 = var_0[var_2] / var_1;
  }

  return var_0;
}

function random(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_1 = var_3;
  }

  if(!var_1.size) {
    return undefined;
  }

  return var_1[randomint(var_1.size)];
}

function random_weight_sorted(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_1 = var_3;
  }

  if(!var_1.size) {
    return undefined;
  }

  var_5 = randomint(var_1.size * var_1.size);
  return var_1[var_1.size - 1 - int(sqrt(var_5))];
}

function alphabetize(var_0) {
  if(var_0.size <= 1) {
    return var_0;
  }

  var_1 = 0;

  for(var_2 = var_0.size - 1; var_2 >= 1; var_2--) {
    var_3 = var_0[var_2];
    var_4 = var_2;

    for(var_5 = 0; var_5 < var_2; var_5++) {
      var_6 = var_0[var_5];

      if(stricmp(var_6, var_3) > 0) {
        var_3 = var_6;
        var_4 = var_5;
      }
    }

    if(var_4 != var_2) {
      var_0 = var_0[var_2];
      var_0 = var_3;
    }
  }

  return var_0;
}

function array_thread_amortized(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_3)) {
    foreach(var_14, var_13 in var_0) {
      var_13 thread[[var_1]]();
      wait var_2;
    }

    return;
  }

  if(!isDefined(var_7)) {
    foreach(var_16, var_13 in var_3) {
      var_13 thread[[var_4]](var_6);
      wait var_5;
    }

    return;
  }

  if(!isDefined(var_11)) {
    foreach(var_18, var_13 in var_6) {
      var_13 thread[[var_7]](var_9, var_10);
      wait var_8;
    }

    return;
  }

  if(!isDefined(var_15)) {
    foreach(var_20, var_13 in var_9) {
      var_13 thread[[var_10]](var_12, var_13, var_14);
      wait var_11;
    }

    return;
  }

  if(!isDefined(var_13)) {
    foreach(var_22, var_13 in var_12) {
      var_13 thread[[var_13]](var_15, var_13, var_16, var_17);
      wait var_14;
    }

    return;
  }

  if(!isDefined(var_20)) {
    foreach(var_24, var_13 in var_15) {
      var_13 thread[[var_13]](var_17, var_13, var_18, var_19, var_13);
      wait var_16;
    }

    return;
  }

  if(!isDefined(var_23)) {
    foreach(var_26, var_13 in var_17) {
      var_13 thread[[var_13]](var_19, var_13, var_20, var_21, var_13, var_22);
      wait var_18;
    }

    return;
  }

  if(!isDefined(var_13)) {
    foreach(var_28, var_13 in var_19) {
      var_13 thread[[var_13]](var_21, var_13, var_22, var_23, var_13, var_24, var_25);
      wait var_20;
    }

    return;
  }

  if(!isDefined(var_28)) {
    foreach(var_13 in var_21) {
      var_13 thread[[var_13]](var_23, var_13, var_24, var_25, var_13, var_26, var_27, var_13);
      wait var_22;
    }

    return;
  }

  foreach(var_13 in var_23) {
    var_13 thread[[var_13]](var_25, var_13, var_26, var_27, var_13, var_28, var_29, var_13, var_30);
    wait var_24;
  }
}

function array_thread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(var_10)) {
    foreach(var_13, var_12 in var_0) {
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    }

    return;
  }

  if(isDefined(var_12)) {
    foreach(var_15, var_12 in var_3) {
      var_12 thread[[var_4]](var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    }

    return;
  }

  if(isDefined(var_14)) {
    foreach(var_17, var_12 in var_6) {
      var_12 thread[[var_7]](var_8, var_9, var_10, var_11, var_12, var_13, var_14);
    }

    return;
  }

  if(isDefined(var_15)) {
    foreach(var_19, var_12 in var_9) {
      var_12 thread[[var_10]](var_11, var_12, var_13, var_14, var_12, var_15);
    }

    return;
  }

  if(isDefined(var_12)) {
    foreach(var_12 in var_12) {
      var_12 thread[[var_13]](var_14, var_12, var_15, var_16, var_12);
    }

    return;
  }

  if(isDefined(var_18)) {
    foreach(var_12 in var_12) {
      var_12 thread[[var_15]](var_16, var_12, var_17, var_18);
    }

    return;
  }

  if(isDefined(var_19)) {
    foreach(var_12 in var_12) {
      var_12 thread[[var_17]](var_18, var_12, var_19);
    }

    return;
  }

  if(isDefined(var_12)) {
    foreach(var_12 in var_12) {
      var_12 thread[[var_19]](var_20, var_12);
    }

    return;
  }

  if(isDefined(var_22)) {
    foreach(var_12 in var_12) {
      var_12 thread[[var_21]](var_22);
    }

    return;
  }

  foreach(var_12 in var_12) {
    var_12 thread[[var_23]]();
  }
}

function array_call(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_9)) {
    foreach(var_12, var_11 in var_0) {
      var_11 builtin[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    }

    return;
  }

  if(isDefined(var_11)) {
    foreach(var_14, var_11 in var_3) {
      var_11 builtin[[var_4]](var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    }

    return;
  }

  if(isDefined(var_13)) {
    foreach(var_16, var_11 in var_6) {
      var_11 builtin[[var_7]](var_8, var_9, var_10, var_11, var_12, var_13);
    }

    return;
  }

  if(isDefined(var_14)) {
    foreach(var_18, var_11 in var_9) {
      var_11 builtin[[var_10]](var_11, var_12, var_13, var_11, var_14);
    }

    return;
  }

  if(isDefined(var_11)) {
    foreach(var_11 in var_12) {
      var_11 builtin[[var_13]](var_11, var_14, var_15, var_11);
    }

    return;
  }

  if(isDefined(var_17)) {
    foreach(var_11 in var_14) {
      var_11 builtin[[var_15]](var_11, var_16, var_17);
    }

    return;
  }

  if(isDefined(var_18)) {
    foreach(var_11 in var_16) {
      var_11 builtin[[var_17]](var_11, var_18);
    }

    return;
  }

  if(isDefined(var_11)) {
    foreach(var_11 in var_18) {
      var_11 builtin[[var_19]](var_11);
    }

    return;
  }

  foreach(var_11 in var_20) {
    var_11 builtin[[var_21]]();
  }
}

function flat_angle(var_0) {
  var_1 = (0, var_0[1], 0);
  return var_1;
}

function flat_origin(var_0) {
  var_1 = (var_0[0], var_0[1], 0);
  return var_1;
}

function flatten_vector(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 1);
  }

  var_2 = vectorNormalize(var_0 - vectordot(var_1, var_0) * var_1);
  return var_2;
}

function draw_arrow_time(var_0, var_1, var_2, var_3) {
  level endon("newpath");
  var_4 = [];
  var_5 = vectortoangles(var_0 - var_1);
  var_6 = anglestoright(var_5);
  var_7 = anglesToForward(var_5);
  var_8 = anglestoup(var_5);
  var_9 = distance(var_0, var_1);
  var_10 = [];
  var_11 = 0.1;
  var_10 = var_0;
  var_10 = var_0 + var_6 * var_9 * var_11 + var_7 * var_9 * -0.1;
  var_10 = var_1;
  var_10 = var_0 + var_6 * var_9 * -1 * var_11 + var_7 * var_9 * -0.1;
  var_10 = var_0;
  var_10 = var_0 + var_8 * var_9 * var_11 + var_7 * var_9 * -0.1;
  var_10 = var_1;
  var_10 = var_0 + var_8 * var_9 * -1 * var_11 + var_7 * var_9 * -0.1;
  var_10 = var_0;
  var_12 = var_2[0];
  var_13 = var_2[1];
  var_14 = var_2[2];
  plot_points(var_10, var_12, var_13, var_14, var_3);
}

function draw_arrow(var_0, var_1, var_2) {
  level endon("newpath");
  var_3 = [];
  var_4 = vectortoangles(var_0 - var_1);
  var_5 = anglestoright(var_4);
  var_6 = anglesToForward(var_4);
  var_7 = distance(var_0, var_1);
  var_8 = [];
  var_9 = 0.05;
  var_8 = var_0;
  var_8 = var_0 + var_5 * var_7 * var_9 + var_6 * var_7 * -0.2;
  var_8 = var_1;
  var_8 = var_0 + var_5 * var_7 * -1 * var_9 + var_6 * var_7 * -0.2;

  for(var_10 = 0; var_10 < 4; var_10++) {
    var_11 = var_10 + 1;

    if(var_11 >= 4) {
      var_11 = 0;
    }
  }
}

function draw_capsule(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_6)) {
    var_6 = 1;
  }

  var_7 = anglesToForward(var_3);
  var_8 = anglestoright(var_3);
  var_9 = anglestoup(var_3);
  var_10 = var_0 + var_9 * var_1;
  var_11 = var_0 + var_9 * var_2;
  var_11 -= var_9 * var_1;
  var_12 = var_10 + var_7 * var_1;
  var_13 = var_11 + var_7 * var_1;
  var_14 = var_10 - var_7 * var_1;
  var_15 = var_11 - var_7 * var_1;
  var_16 = var_10 + var_8 * var_1;
  var_17 = var_11 + var_8 * var_1;
  var_18 = var_10 - var_8 * var_1;
  var_19 = var_11 - var_8 * var_1;
}

function draw_character_capsule(var_0, var_1, var_2) {
  var_3 = self physics_getcharactercollisioncapsule();
  draw_capsule(self getorigin(), var_3["radius"], var_3["half_height"] * 2, self.angles, var_0, var_1, var_2);
}

function draw_player_capsule(var_0, var_1, var_2) {
  var_3 = self physics_getcharactercollisioncapsule();
  draw_capsule(self getorigin(), var_3["radius"], var_3["half_height"] * 2, self getplayerangles(), var_0, var_1, var_2);
}

function draw_ent_bone_forever(var_0, var_1) {
  self endon("stop_drawing_axis");
  self endon("death");

  for(;;) {
    var_2 = self gettagorigin(var_0);
    var_3 = self gettagangles(var_0);
    draw_angles(var_3, var_2, var_1);
    waitframe();
  }
}

function draw_ent_axis_forever(var_0, var_1) {
  self endon("stop_drawing_axis");
  self endon("death");

  for(;;) {
    draw_ent_axis(var_0, undefined, var_1);
    waitframe();
  }
}

function draw_tag_axis_forever(var_0, var_1, var_2) {
  self endon("stop_drawing_axis");
  self endon("death");

  for(;;) {
    draw_tag_axis(var_0, var_1, undefined, var_2);
    waitframe();
  }
}

function draw_ent_axis(var_0, var_1, var_2) {
  waittillframeend();

  if(isDefined(self.angles)) {
    var_3 = self.angles;
  } else {
    var_3 = (0, 0, 0);
  }

  draw_angles(var_3, self.origin, var_1, var_2, var_3);
}

function draw_tag_axis(var_0, var_1, var_2, var_3) {
  waittillframeend();
  var_4 = self gettagangles(var_0);
  var_5 = self gettagorigin(var_0);
  draw_angles(var_4, var_5, var_1, var_2, var_3);
}

function draw_angles(var_0, var_1, var_2, var_3, var_4) {
  waittillframeend();
  var_5 = anglesToForward(var_0);
  var_6 = anglestoright(var_0);
  var_7 = anglestoup(var_0);

  if(!isDefined(var_2)) {
    var_2 = (1, 0, 1);
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(!isDefined(var_4)) {
    var_4 = 10;
  }
}

function draw_entity_bounds(var_0, var_1, var_2, var_3, var_4) {
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
    var_5 = int(var_2 / 0.05);
  }

  var_6 = [];
  var_7 = [];
  var_8 = gettime();
  var_9 = var_8 + var_2 * 1000;

  while(var_8 < var_9 && isDefined(var_1)) {
    var_6 = var_1 getpointinbounds(1, 1, 1);
    var_6 = var_1 getpointinbounds(1, 1, -1);
    var_6 = var_1 getpointinbounds(-1, 1, -1);
    var_6 = var_1 getpointinbounds(-1, 1, 1);
    var_7 = var_1 getpointinbounds(1, -1, 1);
    var_7 = var_1 getpointinbounds(1, -1, -1);
    var_7 = var_1 getpointinbounds(-1, -1, -1);
    var_7 = var_1 getpointinbounds(-1, -1, 1);

    for(var_10 = 0; var_10 < 4; var_10++) {
      var_11 = var_10 + 1;

      if(var_11 == 4) {
        var_11 = 0;
      }
    }

    if(!var_4) {
      return;
    }

    wait var_5;
    var_8 = gettime();
  }
}

function getfx(var_0) {
  return level._effect[var_0];
}

function fxexists(var_0) {
  return isDefined(level._effect[var_0]);
}

function playerunlimitedammothread() {}

function spawn_tag_origin(var_0, var_1) {
  if(!isDefined(var_1) && isDefined(self.angles)) {
    var_1 = self.angles;
  }

  if(!isDefined(var_0) && isDefined(self.origin)) {
    var_0 = self.origin;
  } else if(!isDefined(var_0)) {
    var_0 = (0, 0, 0);
  }

  var_2 = spawn("script_model", var_0);
  var_2 setModel("tag_origin");
  var_2 hide();

  if(isDefined(var_1)) {
    var_2.angles = var_1;
  }

  return var_2;
}

function waittill_notify_or_timeout(var_0, var_1) {
  self endon(var_0);
  wait var_1;
}

function waittill_notify_or_timeout_return(var_0, var_1) {
  var_2 = spawnStruct();
  thread waittill_notify_proc(var_2, var_0);
  thread waittill_timeout_proc(var_2, var_1);
  var_2 waittill("waittill_proc", var_3);
  return var_3;
}

function waittill_notify_proc(var_0, var_1) {
  var_0 endon("waittill_proc");
  self waittill(var_1);
  var_0 notify("waittill_proc", var_1);
}

function waittill_timeout_proc(var_0, var_1) {
  var_0 endon("waittill_proc");
  wait var_1;
  var_0 notify("waittill_proc", "timeout");
}

function waittill_notify_and_time(var_0, var_1) {
  var_2 = gettime();
  self waittill(var_0);
  var_3 = var_2 + var_1 * 1000;
  var_4 = var_3 - var_2;

  if(var_4 > 0) {
    var_5 = var_4 / 1000;
    wait var_5;
    return;
  }
}

function array_wait(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  if(istrue(var_2)) {
    thread array_wait_timeout_proc(var_3, var_2);
    var_3 endon("array_wait_timeout");
  }

  foreach(var_5 in var_0) {
    thread array_wait_proc(var_3, var_5, var_1);
  }

  for(var_7 = 0; var_7 < var_0.size; var_7++) {
    var_3 waittill("array_wait_proc");
  }

  var_3 notify("array_wait_success");
}

function array_wait_proc(var_0, var_1, var_2) {
  var_0 endon("array_wait_success");
  ref_143a5(var_1, var_2, "death");
  var_0 notify("array_wait_proc");
}

function array_wait_timeout_proc(var_0, var_1) {
  var_0 endon("array_wait_success");
  wait var_1;
  var_0 notify("array_wait_timeout");
}

function array_any_wait(var_0, var_1) {
  var_2 = spawnStruct();

  foreach(var_4 in var_0) {
    thread array_any_wait_proc(var_2, var_4, var_1);
  }

  var_2 waittill("array_wait_proc", var_6);
  return var_6;
}

function array_any_wait_timeout(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  thread array_any_wait_timeout_proc(var_3, var_2);

  foreach(var_5 in var_0) {
    thread array_any_wait_proc(var_3, var_5, var_1);
  }

  var_3 waittill("array_wait_proc", var_7);
  return var_7;
}

function array_any_wait_proc(var_0, var_1, var_2) {
  var_3 = waittill_any_return_no_endon_death(var_1, var_2, "death");
  var_0 notify("array_wait_proc", var_3);
}

function array_any_wait_timeout_proc(var_0, var_1) {
  var_0 endon("array_wait_proc");
  wait var_1;
  var_0 notify("array_wait_proc", "timeout");
}

function array_any_wait_return(var_0, var_1) {
  var_2 = spawnStruct();

  foreach(var_4 in var_0) {
    thread array_any_wait_return_proc(var_2, var_4, var_1);
  }

  var_2 waittill("array_wait_proc", var_4);
  return var_4;
}

function array_any_wait_return_proc(var_0, var_1, var_2) {
  var_3 = ref_143ad(var_1, var_2, "death");
  var_0 notify("array_wait_proc", var_1);
}

function fileprint_launcher_start_file()
{
  level.fileprintlauncher_linecount = 0;
  level. fileprint_launcher = 1;
  fileprint_launcher( "GAMEPRINTSTARTFILE:" );
}

function fileprint_launcher( var_0 )
{
  level.fileprintlauncher_linecount++;

  if(level.fileprintlauncher_linecount > 200) {
    wait 0.05;
    level.fileprintlauncher_linecount = 0;
  }
}

function fileprint_launcher_end_file( var_0, var_1 )
{
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    fileprint_launcher( "GAMEPRINTENDFILE:GAMEPRINTP4ENABLED:" + var_0 );
  } else {
    fileprint_launcher( "GAMEPRINTENDFILE:" + var_0 );
  }

  var_2 = gettime() + 4000;

  while(getdvarint("LAUNCHER_PRINT_SUCCESS") == 0 && getDvar("LAUNCHER_PRINT_FAIL") == "0" && gettime() < var_2) {
    wait 0.05;
  }

  if(!(gettime() < var_2)) {
    iprintlnbold("LAUNCHER_PRINT_FAIL:( TIMEOUT ): launcherconflict? restart launcher and try again? ");
    level. fileprint_launcher = undefined;
    return false;
  }

  var_3 = getDvar("LAUNCHER_PRINT_FAIL");

  if(var_3 != "0") {
    iprintlnbold("LAUNCHER_PRINT_FAIL:( " + var_3 + " ): launcherconflict? restart launcher and try again? ");
    level. fileprint_launcher = undefined;
    return false;
  }

  iprintlnbold("Launcher write to file successful!");
  level. fileprint_launcher = undefined;
  return true;
}

function launcher_write_clipboard(var_0) {
  level.fileprintlauncher_linecount = 0;
  fileprint_launcher( "LAUNCHER_CLIP:" + var_0 );
}

function activate_individual_exploder() {
  scripts\common\exploder::activate_individual_exploder_proc();
}

function get_target_ent(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self.target;
  }

  var_1 = getEnt(var_0, "targetname");

  if(isDefined(var_1)) {
    return var_1;
  }

  if(scripts\common\utility::issp()) {
    var_1 = builtin[[level.getnodefunction]](var_0, "targetname");

    if(isDefined(var_1)) {
      return var_1;
    }

    var_1 = builtin[[level.func["getspawner"]]](var_0, "targetname");

    if(isDefined(var_1)) {
      return var_1;
    }
  }

  var_1 = getStruct(var_0, "targetname");

  if(isDefined(var_1)) {
    return var_1;
  }

  var_1 = getvehiclenode(var_0, "targetname");

  if(isDefined(var_1)) {
    return var_1;
  }
}

function get_links() {
  return strtok(self.script_linkto, " ");
}

function get_linked_ents() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = get_links();

    foreach(var_3 in var_1) {
      var_4 = getEntArray(var_3, "script_linkname");

      if(var_4.size > 0) {
        var_0 = array_combine(var_0, var_4);
      }
    }
  }

  return var_0;
}

function get_linked_ent() {
  var_0 = get_linked_ents();
  return var_0[0];
}

function get_linked_nodes() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = get_links();

    foreach(var_3 in var_1) {
      var_4 = getnodearray(var_3, "script_linkname");

      if(var_4.size > 0) {
        var_0 = array_combine(var_0, var_4);
      }
    }
  }

  return var_0;
}

function do_earthquake(var_0, var_1) {
  var_2 = level.earthquake[var_0];
  earthquake(var_2["magnitude"], var_2["duration"], var_1, var_2["radius"]);
}

function play_loopsound_in_space(var_0, var_1) {
  var_2 = spawn("script_origin", (0, 0, 0));

  if(!isDefined(var_1)) {
    var_1 = self.origin;
  }

  var_2.origin = var_1;
  var_2 playLoopSound(var_0);
  return var_2;
}

function play_sound_in_space_with_angles(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_origin", (0, 0, 1));

  if(!isDefined(var_1)) {
    var_1 = self.origin;
  }

  var_5.origin = var_1;
  var_5.angles = var_2;

  if(isDefined(var_4)) {
    var_5 linkTo(var_4);
  }

  if(scripts\common\utility::issp()) {
    var_5 playSound(var_0, "sounddone");
    var_5 waittill("sounddone");
  } else {
    var_5 playSound(var_0);
  }

  var_5 delete();
}

function play_sound_in_space(var_0, var_1, var_2, var_3) {
  play_sound_in_space_with_angles(var_0, var_1, (0, 0, 0), var_2, var_3);
}

function loop_fx_sound(var_0, var_1, var_2, var_3, var_4) {
  loop_fx_sound_with_angles(var_0, var_1, (0, 0, 0), var_2, var_3, var_4);
}

function loop_fx_sound_with_angles(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(istrue(var_3)) {
    if(!isDefined(level.first_frame) || level.first_frame == 1) {
      spawnloopingsound(var_0, var_1, var_2);
      return;
    }

    return;
  }

  if(level.createfx_enabled && isDefined(var_5.loopsound_ent)) {
    var_7 = var_5.loopsound_ent;
  } else {
    var_7 = spawn("script_origin", (0, 0, 0));
  }

  if(isDefined(var_5)) {
    thread loop_sound_delete(var_5, var_7);
    self endon(var_5);
  }

  var_7.origin = var_2;
  var_7.angles = var_3;
  var_7 playLoopSound(var_1);

  if(level.createfx_enabled) {
    var_6.loopsound_ent = var_7;
    return;
  }

  var_7 willneverchange();
}

function loop_fx_sound_interval(var_0, var_1, var_2, var_3, var_4, var_5) {
  loop_fx_sound_interval_with_angles(var_0, var_1, (0, 0, 0), var_2, var_3, var_4, var_5);
}

function loop_fx_sound_interval_with_angles(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self.origin = var_1;
  self.angles = var_2;

  if(isDefined(var_3)) {
    self endon(var_3);
  }

  if(var_5 >= var_6) {
    for(;;) {
      wait 0.05;
    }
  }

  if(!soundexists(var_0)) {
    for(;;) {
      wait 0.05;
    }
  }

  for(;;) {
    wait randomfloatrange(var_5, var_6);
    lock("createfx_looper");
    thread play_sound_in_space_with_angles(var_0, self.origin, self.angles, undefined);
    unlock("createfx_looper");
  }
}

function loop_sound_delete(var_0, var_1) {
  var_1 endon("death");
  self waittill(var_0);
  var_1 delete();
}

function createloopeffect(var_0) {
  var_1 = scripts\common\createfx::createeffect("loopfx", var_0);
  var_1.v["delay"] = scripts\common\createfx::getloopeffectdelaydefault();
  return var_1;
}

function createoneshoteffect(var_0) {
  var_1 = scripts\common\createfx::createeffect("oneshotfx", var_0);
  var_1.v["delay"] = scripts\common\createfx::getoneshoteffectdelaydefault();
  return var_1;
}

function createexploder(var_0, var_1) {
  var_2 = scripts\common\createfx::createeffect("exploder", var_0, var_1);
  var_2.v["delay"] = scripts\common\createfx::getexploderdelaydefault();
  var_2.v["exploder_type"] = "normal";
  return var_2;
}

function play_loop_sound_on_entity(var_0, var_1) {
  var_2 = spawn("script_origin", (0, 0, 0));
  var_2 endon("death");
  thread delete_on_death(var_2);

  if(isDefined(var_1)) {
    var_2.origin = self.origin + var_1;
    var_2.angles = self.angles;
    var_2 linkTo(self);
  } else {
    var_2.origin = self.origin;
    var_2.angles = self.angles;
    var_2 linkTo(self);
  }

  var_2 playLoopSound(var_0);
  self waittill("stop sound" + var_0);
  var_2 stoploopsound(var_0);
  var_2 delete();
}

function stop_loop_sound_on_entity(var_0) {
  self notify("stop sound" + var_0);
}

function delete_on_death(var_0) {
  var_0 endon("death");
  self waittill("death");

  if(isDefined(var_0)) {
    var_0 delete();
    return;
  }
}

function delete_on_sounddone() {
  self waittill("sounddone");
  self delete();
}

function delete_on_notify(var_0) {
  self waittill(var_0);
  self delete();
}

function error(var_0) {
  waitframe();
}

function exploder(var_0, var_1, var_2) {
  [[level._fx.exploderfunction]](var_0, var_1, var_2);
}

function delete_exploder(var_0) {
  scripts\common\exploder::delete_exploder_proc(var_0);
}

function hide_exploder_models(var_0) {
  scripts\common\exploder::hide_exploder_models_proc(var_0);
}

function show_exploder_models(var_0) {
  scripts\common\exploder::show_exploder_models_proc(var_0);
}

function stop_exploder(var_0, var_1) {
  scripts\common\exploder::stop_exploder_proc(var_0, var_1, 0);
}

function kill_exploder(var_0, var_1) {
  scripts\common\exploder::stop_exploder_proc(var_0, var_1, 1);
}

function get_exploder_array(var_0) {
  return scripts\common\exploder::get_exploder_array_proc(var_0);
}

function ter_op(var_0, var_1, var_2) {
  if(var_0) {
    return var_1;
  }

  return var_2;
}

function create_lock(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(level.lock)) {
    level.lock = [];
  }

  var_2 = spawnStruct();
  var_2.max_count = var_1;
  var_2.count = 0;
  level.lock[var_0] = var_2;
}

function lock(var_0) {
  var_1 = level.lock[var_0];

  while(var_1.count >= var_1.max_count) {
    var_1 waittill("unlocked");
  }

  var_1.count++;
}

function unlock(var_0) {
  thread unlock_thread(var_0);
}

function unlock_thread(var_0) {
  wait 0.05;
  var_1 = level.lock[var_0];
  var_1.count--;
  var_1 notify("unlocked");
}

function unlock_wait(var_0) {
  thread unlock_thread(var_0);
  wait 0.05;
}

function is_player_gamepad_enabled() {
  var_0 = self usinggamepad();

  if(isDefined(var_0)) {
    return var_0;
  }

  if(self ispcplayer()) {
    return 0;
  }

  return 1;
}

function distance_2d_squared(var_0, var_1) {
  return length2dsquared(var_0 - var_1);
}

function get_array_of_farthest(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_array_of_closest(var_0, var_1, var_2, var_3, var_4, var_5);
  var_6 = array_reverse(var_6);
  return var_6;
}

function get_array_of_closest(var_0, var_1, var_2, var_3, var_4, var_5) {
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
    return sortbydistance(var_1, var_0);
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

    var_8 = var_10;
  }

  var_8 = sortbydistance(var_8, var_0);

  if(var_3 >= var_8.size) {
    return var_8;
  }

  var_17 = [];

  for(var_18 = 0; var_18 < var_3; var_18++) {
    var_17 = var_8[var_18];
  }

  return var_17;
}

function drop_to_ground(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    var_1 = 1500;
  }

  if(!isDefined(var_2)) {
    var_2 = -12000;
  }

  if(!isDefined(var_4)) {
    var_4 = scripts\engine\trace::create_solid_ai_contents(1);
  }

  if(isDefined(var_3)) {
    return scripts\engine\trace::ray_trace(var_0 + var_1 * var_3, var_0 + var_2 * var_3, undefined, var_4)["position"];
  }

  return scripts\engine\trace::ray_trace(var_0 + (0, 0, var_1), var_0 + (0, 0, var_2), undefined, var_4)["position"];
}

function player_drop_to_ground(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = 1500;
  }

  if(!isDefined(var_3)) {
    var_3 = -12000;
  }

  var_5 = scripts\engine\trace::create_solid_ai_contents(1);

  if(isDefined(var_4)) {
    return scripts\engine\trace::sphere_trace(var_0 + var_2 * var_4, var_0 + var_3 * var_4, var_1, undefined, var_5)["position"];
  }

  return scripts\engine\trace::sphere_trace(var_0 + (0, 0, var_2), var_0 + (0, 0, var_3), var_1, undefined, var_5)["position"];
}

function within_fov(var_0, var_1, var_2, var_3) {
  var_4 = vectorNormalize(var_2 - var_0);
  var_5 = anglesToForward(var_1);
  var_6 = vectordot(var_5, var_4);
  return var_6 >= var_3;
}

function ai_3d_sighting_model(var_0) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["ai_3d_sighting_model"])) {
    return self[[level.bot_funcs["ai_3d_sighting_model"]]](var_0);
  }
}

function getclosest(var_0, var_1, var_2) {
  if(var_1.size == 0) {
    return undefined;
  }

  var_3 = sortbydistance(var_1, var_0)[0];

  if(isDefined(var_2) && distancesquared(var_0, var_3.origin) > squared(var_2)) {
    return undefined;
  }

  return var_3;
}

function missile_settargetandflightmode(var_0, var_1, var_2) {
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

function add_fx(var_0, var_1) {
  if(!isDefined(level._effect)) {
    level._effect = [];
  }

  level._effect[var_0] = loadfx(var_1);
}

function create_func_ref(var_0, var_1) {
  if(!isDefined(level.func)) {
    level.func = [];
  }

  level.func[var_0] = var_1;
}

function create_empty_func_ref(var_0) {
  if(!isDefined(level.func)) {
    level.func = [];
  }

  if(!isDefined(level.func[var_0])) {
    create_func_ref(var_0, &empty_init_func);
    return;
  }
}

function func_ref_exist(var_0) {
  return isDefined(level.func) && isDefined(level.func[var_0]);
}

function add_init_script(var_0, var_1) {
  if(!isDefined(level.init_script)) {
    level.init_script = [];
  }

  if(isDefined(level.init_script[var_0])) {
    return false;
  }

  level.init_script[var_0] = var_1;
  return true;
}

function add_frame_event(var_0) {
  if(!isDefined(self.frame_events)) {
    self.frame_events = [var_0];
    thread process_frame_events();
    return;
  }

  self.frame_events[self.frame_events.size] = var_0;
}

function process_frame_events() {
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    foreach(var_1 in self.frame_events) {
      self thread[[var_1]]();
    }

    waitframe();
  }
}

function delaythread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  thread delaythread_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

function delaythread_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("stop_delay_thread");

  if(isPlayer(self)) {
    self endon("death_or_disconnect");
  } else {
    self endon("death");
  }

  wait var_1;

  if(isDefined(var_8)) {
    GscBinSkip1(0x74, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  if(isDefined(var_7)) {
    GscBinSkip1(0x74, var_0, var_2, var_3, var_4, var_5, var_6, var_7);
  }

  if(isDefined(var_6)) {
    GscBinSkip1(0x74, var_0, var_2, var_3, var_4, var_5, var_6);
  }

  if(isDefined(var_5)) {
    GscBinSkip1(0x74, var_0, var_2, var_3, var_4, var_5);
  }

  if(isDefined(var_4)) {
    GscBinSkip1(0x74, var_0, var_2, var_3, var_4);
  }

  if(isDefined(var_3)) {
    GscBinSkip1(0x74, var_0, var_2, var_3);
  }

  if(isDefined(var_2)) {
    GscBinSkip1(0x74, var_0, var_2);
  }

  GscBinSkip1(0x74, var_0);
}

function damagelocationisany(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(self.damagelocation)) {
    if(!isDefined(var_0)) {
      return 0;
    }

    if(self.damagelocation == var_0) {
      return 1;
    }

    if(!isDefined(var_1)) {
      return 0;
    }

    if(self.damagelocation == var_1) {
      return 1;
    }

    if(!isDefined(var_2)) {
      return 0;
    }

    if(self.damagelocation == var_2) {
      return 1;
    }

    if(!isDefined(var_3)) {
      return 0;
    }

    if(self.damagelocation == var_3) {
      return 1;
    }

    if(!isDefined(var_4)) {
      return 0;
    }

    if(self.damagelocation == var_4) {
      return 1;
    }

    if(!isDefined(var_5)) {
      return 0;
    }

    if(self.damagelocation == var_5) {
      return 1;
    }

    if(!isDefined(var_6)) {
      return 0;
    }

    if(self.damagelocation == var_6) {
      return 1;
    }

    if(!isDefined(var_7)) {
      return 0;
    }

    if(self.damagelocation == var_7) {
      return 1;
    }

    if(!isDefined(var_8)) {
      return 0;
    }

    if(self.damagelocation == var_8) {
      return 1;
    }

    if(!isDefined(var_9)) {
      return 0;
    }

    if(self.damagelocation == var_9) {
      return 1;
    }

    if(!isDefined(var_10)) {
      return 0;
    }

    if(self.damagelocation == var_10) {
      return 1;
    }
  }

  return damagesubpartlocationisany(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

function damagesubpartlocationisany(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(self.damagedsubpart)) {
    return false;
  }

  if(!isDefined(var_0)) {
    return false;
  }

  if(self.damagedsubpart == var_0) {
    return true;
  }

  if(!isDefined(var_1)) {
    return false;
  }

  if(self.damagedsubpart == var_1) {
    return true;
  }

  if(!isDefined(var_2)) {
    return false;
  }

  if(self.damagedsubpart == var_2) {
    return true;
  }

  if(!isDefined(var_3)) {
    return false;
  }

  if(self.damagedsubpart == var_3) {
    return true;
  }

  if(!isDefined(var_4)) {
    return false;
  }

  if(self.damagedsubpart == var_4) {
    return true;
  }

  if(!isDefined(var_5)) {
    return false;
  }

  if(self.damagedsubpart == var_5) {
    return true;
  }

  if(!isDefined(var_6)) {
    return false;
  }

  if(self.damagedsubpart == var_6) {
    return true;
  }

  if(!isDefined(var_7)) {
    return false;
  }

  if(self.damagedsubpart == var_7) {
    return true;
  }

  if(!isDefined(var_8)) {
    return false;
  }

  if(self.damagedsubpart == var_8) {
    return true;
  }

  if(!isDefined(var_9)) {
    return false;
  }

  if(self.damagedsubpart == var_9) {
    return true;
  }

  if(!isDefined(var_10)) {
    return false;
  }

  if(self.damagedsubpart == var_10) {
    return true;
  }

  return false;
}

function isbulletdamage(var_0) {
  switch (var_0) {
    case "MOD_HEAD_SHOT":
    case "MOD_PISTOL_BULLET":
    case "MOD_RIFLE_BULLET":
      return 1;
    default:
      return 0;
  }
}

function isvalidpeekoutdir(var_0) {
  var_1 = self;
  var_2 = var_1 getvalidcoverpeekouts();

  foreach(var_4 in var_2) {
    if(var_4 == var_0) {
      return true;
    }
  }

  return false;
}

function getbestcovermultinodetype(var_0) {
  var_1 = var_0 getvalidcovermultinodetypes();

  if(var_1.size <= 0) {
    return undefined;
  }

  var_2 = 0;

  if(isDefined(self.enemy)) {
    var_3 = self.enemy.origin;

    if(issentient(self.enemy) && self lastknowntime(self.enemy) > 0) {
      var_3 = self lastknownpos(self.enemy);
    }

    var_4 = vectortoangles(var_3 - var_0.origin);
    var_2 = angleclamp180(var_4[1] - var_0.angles[1]);
  }

  foreach(var_6 in var_1) {
    switch (var_6) {
      case "Cover Stand":
      case "Cover Crouch":
        if(abs(var_2) < 30) {
          return var_6;
        }

        break;
      case "Cover Left Crouch":
      case "Cover Left":
        if(var_2 > 30) {
          return "Cover Left";
        }

        break;
      case "Cover Right Crouch":
      case "Cover Right":
        if(var_2 < -30) {
          return "Cover Right";
        }

        break;
      default:
        break;
    }
  }

  var_8 = var_1[0];

  switch (var_8) {
    case "Cover Left Crouch":
      return "Cover Left";
    case "Cover Right Crouch":
      return "Cover Right";
  }

  return var_8;
}

function isnodecoverleft(var_0) {
  return var_0.type == "Cover Left";
}

function isnodecoverright(var_0) {
  return var_0.type == "Cover Right";
}

function isnodecovercrouchtype(var_0, var_1) {
  if(var_0.type == "Cover Crouch" && isDefined(self._blackboard.croucharrivaltype)) {
    return (self._blackboard.croucharrivaltype == var_1);
  }

  return false;
}

function isnode3d(var_0) {
  return isnodecover3d(var_0) || isnodeexposed3d(var_0);
}

function isnodecover3d(var_0) {
  return var_0.type == "Cover Stand 3D" || var_0.type == "Cover 3D";
}

function isnodeexposed3d(var_0) {
  return var_0.type == "Exposed 3D" || var_0.type == "Path 3D";
}

function isnodecovercrouch(var_0) {
  return var_0.type == "Cover Crouch" || var_0.type == "Cover Crouch Window" || var_0.type == "Conceal Crouch";
}

function absangleclamp180(var_0) {
  return abs(angleclamp180(var_0));
}

function getaimyawtopoint(var_0) {
  var_1 = getyawtospot(var_0);
  var_2 = distance(self.origin, var_0);

  if(var_2 > 3) {
    var_3 = asin(-3 / var_2);
    var_1 -= var_3;
  }

  var_1 = angleclamp180(var_1);
  return var_1;
}

function getyawtospot(var_0) {
  if(actor_is3d()) {
    var_1 = anglesToForward(self.angles);
    var_2 = rotatepointaroundvector(var_1, var_0 - self.origin, self.angles[2] * -1);
    var_0 = var_2 + self.origin;
  }

  var_3 = getyaw(var_0) - self.angles[1];
  var_3 = angleclamp180(var_3);
  return var_3;
}

function getyaw(var_0) {
  return vectortoyaw(var_0 - self.origin);
}

function getaimyawtopoint3d(var_0) {
  var_1 = getyawtospot3d(var_0);
  var_2 = distance(self.origin, var_0);

  if(var_2 > 3) {
    var_3 = asin(-3 / var_2);
    var_1 -= var_3;
  }

  var_1 = angleclamp180(var_1);
  return var_1;
}

function getyawtospot3d(var_0) {
  var_1 = var_0 - self.origin;
  var_2 = rotatevectorinverted(var_1, self.angles);
  var_3 = vectortoyaw(var_2);
  var_4 = angleclamp180(var_3);
  return var_4;
}

function getaimpitchtopoint3d(var_0) {
  var_1 = getpitchtospot3d(var_0);
  var_2 = distance(self.origin, var_0);

  if(var_2 > 3) {
    var_3 = asin(-3 / var_2);
    var_1 -= var_3;
  }

  var_1 = angleclamp180(var_1);
  return var_1;
}

function getpitchtospot3d(var_0) {
  var_1 = var_0 - self.origin;
  var_2 = rotatevectorinverted(var_1, self.angles);
  var_3 = vectortopitch(var_2);
  var_4 = angleclamp180(var_3);
  return var_4;
}

function getplayerpitch(var_0) {
  var_1 = var_0 getplayerangles();
  return (var_1[0] + 360) % 360;
}

function getplayeryaw(var_0) {
  var_1 = var_0 getplayerangles();
  return (var_1[1] + 360) % 360;
}

function actor_isspace() {
  return istrue(self.space);
}

function actor_is3d() {
  return actor_isspace();
}

function getpredictedaimyawtoshootentorpos(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    if(!isDefined(var_2)) {
      return 0;
    }

    return getaimyawtopoint(var_2);
  }

  var_3 = (0, 0, 0);

  if(isPlayer(var_1)) {
    var_3 = var_1 getvelocity();
  } else if(isai(var_1)) {
    var_3 = var_1.velocity;
  }

  var_4 = var_1.origin + var_3 * var_0;
  return getaimyawtopoint(var_4);
}

function getpredictedaimyawtoshootentorpos3d(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    if(!isDefined(var_2)) {
      return 0;
    }

    return getaimyawtopoint3d(var_2);
  }

  var_3 = (0, 0, 0);

  if(isPlayer(var_1)) {
    var_3 = var_1 getvelocity();
  } else if(isai(var_1)) {
    var_3 = var_1.velocity;
  }

  var_4 = var_1.origin + var_3 * var_0;
  return getaimyawtopoint3d(var_4);
}

function getpredictedaimpitchtoshootentorpos3d(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    if(!isDefined(var_2)) {
      return 0;
    }

    return getaimpitchtopoint3d(var_2);
  }

  var_3 = (0, 0, 0);

  if(isPlayer(var_1)) {
    var_3 = var_1 getvelocity();
  } else if(isai(var_1)) {
    var_3 = var_1.velocity;
  }

  var_4 = var_1.origin + var_3 * var_0;
  return getaimpitchtopoint3d(var_4);
}

function is_equal(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1) && var_0 == var_1) {
    return true;
  }

  return false;
}

function player_is_in_jackal() {
  return false;
}

function set_createfx_enabled() {
  if(!isDefined(level.createfx_enabled)) {
    level.createfx_enabled = getDvar("createfx") != "";
    return;
  }
}

function flag_set_delayed(var_0, var_1, var_2) {
  wait var_1;
  flag_set(var_0, var_2);
}

function noself_array_call(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    foreach(var_6 in var_0) {
      builtin[[var_1]](var_6, var_2, var_3, var_4);
    }

    return;
  }

  if(isDefined(var_6)) {
    foreach(var_6 in var_3) {
      builtin[[var_4]](var_6, var_5, var_6);
    }

    return;
  }

  if(isDefined(var_8)) {
    foreach(var_6 in var_6) {
      builtin[[var_7]](var_6, var_8);
    }

    return;
  }

  foreach(var_6 in var_6) {
    builtin[[var_9]](var_6);
  }
}

function flag_assert(var_0) {}

function flag_wait_either(var_0, var_1) {
  for(;;) {
    if(flag(var_0)) {
      return;
    }

    if(flag(var_1)) {
      return;
    }

    waittill_either(level, var_0, var_1);
  }
}

function flag_wait_either_return(var_0, var_1) {
  if(flag(var_0)) {
    return var_0;
  }

  if(flag(var_1)) {
    return var_1;
  }

  var_2 = ref_143ad(level, var_0, var_1);
  return var_2;
}

function flag_wait_any(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];

  if(isDefined(var_5)) {
    GscBinSkip0(0x2e, var_6.size, var_0);
  }

  if(isDefined(var_4)) {
    GscBinSkip0(0x2e, var_6.size, var_0);
  }

  if(isDefined(var_3)) {
    GscBinSkip0(0x2e, var_6.size, var_0);
  }

  if(isDefined(var_2)) {
    GscBinSkip0(0x2e, var_6.size, var_0);
  }

  if(isDefined(var_1)) {
    flag_wait_either(var_0, var_1);
    return;
  }

  return;
}

function flag_wait_any_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_0 * 1000;
  var_8 = gettime();
  var_9 = [];

  if(isDefined(var_6)) {
    GscBinSkip0(0x2e, var_9.size, var_1);
  }

  if(isDefined(var_5)) {
    GscBinSkip0(0x2e, var_9.size, var_1);
  }

  if(isDefined(var_4)) {
    GscBinSkip0(0x2e, var_9.size, var_1);
  }

  if(isDefined(var_3)) {
    GscBinSkip0(0x2e, var_9.size, var_1);
  }

  if(isDefined(var_2)) {
    GscBinSkip0(0x2e, var_9.size, var_1);
  }
}

function internal_wait_for_any_flag_or_time_elapses(var_0, var_1) {
  foreach(var_3 in var_0) {
    level endon(var_3);
  }

  wait var_1;
}

function flag_wait_any_return(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];

  if(isDefined(var_4)) {
    GscBinSkip0(0x2e, var_5.size, var_0);
  }

  if(isDefined(var_3)) {
    GscBinSkip0(0x2e, var_5.size, var_0);
  }

  if(isDefined(var_2)) {
    GscBinSkip0(0x2e, var_5.size, var_0);
  }

  if(isDefined(var_1)) {
    var_6 = flag_wait_either_return(var_0, var_1);
    return var_6;
  } else {
    return;
  }

  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    if(flag(var_6[var_7])) {
      return var_6[var_7];
    }
  }

  var_6 = ref_143b0(level, var_1, var_2, var_3, var_4, var_5);
  return var_6;
}

function flag_wait_all(var_0, var_1, var_2, var_3) {
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
    return;
  }
}

function flag_wait_or_timeout(var_0, var_1) {
  var_2 = var_1 * 1000;
  var_3 = gettime();

  for(;;) {
    if(flag(var_0)) {
      break;
    }

    if(gettime() >= var_3 + var_2) {
      break;
    }

    var_4 = var_2 - gettime() - var_3;
    var_5 = var_4 / 1000;
    wait_for_flag_or_time_elapses(var_0, var_5);
  }
}

function flag_waitopen_or_timeout(var_0, var_1) {
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

function wait_for_flag_or_time_elapses(var_0, var_1) {
  level endon(var_0);
  wait var_1;
}

function noself_delaycall(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread noself_delaycall_proc(var_1, var_0, var_2, var_3, var_4, var_5);
}

function noself_delaycall_proc(var_0, var_1, var_2, var_3, var_4, var_5) {
  wait var_1;

  if(isDefined(var_5)) {
    builtin[[var_0]](var_2, var_3, var_4, var_5);
    return;
  }

  if(isDefined(var_4)) {
    builtin[[var_0]](var_2, var_3, var_4);
    return;
  }

  if(isDefined(var_3)) {
    builtin[[var_0]](var_2, var_3);
    return;
  }

  if(isDefined(var_2)) {
    builtin[[var_0]](var_2);
    return;
  }

  builtin[[var_0]]();
}

function get_target_array(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self.target;
  }

  var_1 = getEntArray(var_0, "targetname");

  if(var_1.size > 0) {
    return var_1;
  }

  if(scripts\common\utility::issp()) {
    var_1 = builtin[[level.getnodearrayfunction]](var_0, "targetname");

    if(var_1.size > 0) {
      return var_1;
    }
  }

  var_1 = getStructArray(var_0, "targetname");

  if(var_1.size > 0) {
    return var_1;
  }

  var_1 = getvehiclenodearray(var_0, "targetname");

  if(var_1.size > 0) {
    return var_1;
  }
}

function pauseeffect() {
  scripts\common\createfx::stop_fx_looper();
}

function spawn_script_origin(var_0, var_1) {
  if(!isDefined(var_1) && isDefined(self.angles)) {
    var_1 = self.angles;
  }

  if(!isDefined(var_0) && isDefined(self.origin)) {
    var_0 = self.origin;
  } else if(!isDefined(var_0)) {
    var_0 = (0, 0, 0);
  }

  var_2 = spawn("script_origin", var_0);

  if(isDefined(var_1)) {
    var_2.angles = var_1;
  }

  return var_2;
}

function get_noteworthy_array(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");

  if(var_1.size > 0) {
    return var_1;
  }

  if(scripts\common\utility::issp()) {
    var_1 = builtin[[level.getnodearrayfunction]](var_0, "script_noteworthy");

    if(var_1.size > 0) {
      return var_1;
    }
  }

  var_1 = getStructArray(var_0, "script_noteworthy");

  if(var_1.size > 0) {
    return var_1;
  }

  var_1 = getvehiclenodearray(var_0, "script_noteworthy");

  if(var_1.size > 0) {
    return var_1;
  }
}

function get_cumulative_weights(var_0) {
  var_1 = [];
  var_2 = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_2 += var_0[var_3];
    var_1 = var_2;
  }

  return var_1;
}

function void() {}

function getanim(var_0) {
  return level.scr_anim[self.animname][var_0];
}

function hasanim(var_0) {
  return isDefined(level.scr_anim[self.animname][var_0]);
}

function getanim_from_animname(var_0, var_1) {
  return level.scr_anim[var_1][var_0];
}

function getanim_generic(var_0) {
  return level.scr_anim["generic"][var_0];
}

function hasanim_generic(var_0) {
  return isDefined(level.scr_anim["generic"][var_0]);
}

function waittill_match_or_timeout(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3 endon("complete");
  delaythread(var_3, var_2, &send_notify, "complete");
  self waittillmatch(var_0, var_1);
}

function waittill_match_or_timeout_return(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3 endon("complete");
  delaythread(var_3, var_2, &send_notify, "complete");
  self waittill(var_0, var_1);
  return var_1;
}

function send_notify(var_0, var_1) {
  if(isDefined(var_1)) {
    self notify(var_0, var_1);
    return;
  }

  self notify(var_0);
}

function get_notetrack_time(var_0, var_1) {
  var_2 = getnotetracktimes(var_0, var_1);
  var_3 = getanimlength(var_0);
  return var_2[0] * var_3;
}

function mph_to_ips(var_0) {
  return var_0 * 17.6;
}

function ips_to_mph(var_0) {
  return var_0 * 0.056818;
}

function add_dialogue_line(var_0, var_1, var_2) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }

  if(!isDefined(level.dialogue_huds)) {
    level.dialogue_huds = [];
  }

  if(level.dialogue_huds.size == 5) {
    var_3 = level.dialogue_huds[0];
    level.dialogue_huds = array_remove_index(level.dialogue_huds, 0);
    update_dialogue_huds();
    thread destroy_dialogue_hud();
  }

  var_4 = "^3";

  if(isDefined(var_2)) {
    switch (var_2) {
      case "red":
      case "r":
        var_4 = "^1";
        break;
      case "green":
      case "g":
        var_4 = "^2";
        break;
      case "yellow":
      case "y":
        var_4 = "^3";
        break;
      case "blue":
      case "b":
        var_4 = "^4";
        break;
      case "cyan":
      case "c":
        var_4 = "^5";
        break;
      case "purple":
      case "p":
        var_4 = "^6";
        break;
      case "white":
      case "w":
        var_4 = "^7";
        break;
      case "black":
      case "bl":
        var_4 = "^8";
        break;
    }
  }

  var_5 = 1;

  if(isDefined(level.dialoguelinescale)) {
    var_5 = level.dialoguelinescale;
  }

  var_6 = newhudelem();
  var_6.elemtype = "font";
  var_6.font = "default";
  var_6.fontscale = var_5;
  var_6.x = 0;
  var_6.y = 0;
  var_6.width = 0;
  var_6.height = int(level.fontheight * var_5);
  var_6.xoffset = 0;
  var_6.yoffset = 0;
  var_7 = level.dialogue_huds.size;
  level.dialogue_huds[var_7] = var_6;
  var_6.foreground = 1;
  var_6.sort = 20;
  var_6.x = 40;
  var_6.y = 260 + var_7 * 12 * var_5;
  var_6.label = "" + var_4 + var_0 + ": ^7" + var_1;
  var_6.alpha = 0;
  var_6 fadeovertime(0.2);
  var_6.alpha = 1;
  var_6 endon("death");
  wait 8;
  level.dialogue_huds = array_remove(level.dialogue_huds, var_6);
  update_dialogue_huds();
  thread destroy_dialogue_hud();
}

function destroy_dialogue_hud() {
  var_0 = 1;

  if(isDefined(level.dialoguelinescale)) {
    var_0 = level.dialoguelinescale;
  }

  self endon("death");
  self fadeovertime(0.2);
  self moveovertime(0.2);
  self.y -= 12 * var_0;
  self.alpha = 0;
  wait 0.2;
  self destroy();
}

function update_dialogue_huds() {
  var_0 = 1;

  if(isDefined(level.dialoguelinescale)) {
    var_0 = level.dialoguelinescale;
  }

  level.dialogue_huds = array_removeundefined(level.dialogue_huds);

  foreach(var_2 in level.dialogue_huds) {
    var_2 moveovertime(0.2);
    var_2.y = 260 + var_3 * 12 * var_0;
  }
}

function closestdistancebetweenlines(var_0, var_1, var_2, var_3) {
  var_4 = var_0 - var_2;
  var_5 = var_3 - var_2;

  if(abs(var_5[0]) < 1e-06 && abs(var_5[1]) < 1e-06 && abs(var_5[2]) < 1e-06) {
    return undefined;
  }

  var_6 = var_1 - var_0;

  if(abs(var_6[0]) < 1e-06 && abs(var_6[1]) < 1e-06 && abs(var_6[2]) < 1e-06) {
    return undefined;
  }

  var_7 = var_4[0] * var_5[0] + var_4[1] * var_5[1] + var_4[2] * var_5[2];
  var_8 = var_5[0] * var_6[0] + var_5[1] * var_6[1] + var_5[2] * var_6[2];
  var_9 = var_4[0] * var_6[0] + var_4[1] * var_6[1] + var_4[2] * var_6[2];
  var_10 = var_5[0] * var_5[0] + var_5[1] * var_5[1] + var_5[2] * var_5[2];
  var_11 = var_6[0] * var_6[0] + var_6[1] * var_6[1] + var_6[2] * var_6[2];
  var_12 = var_11 * var_10 - var_8 * var_8;

  if(abs(var_12) < 1e-06) {
    return undefined;
  }

  var_13 = var_7 * var_8 - var_9 * var_10;
  var_14 = var_13 / var_12;
  var_15 = (var_7 + var_8 * var_14) / var_10;
  var_16 = var_0 + var_14 * var_6;
  var_17 = var_2 + var_15 * var_5;
  var_18 = [var_16, var_17, distance(var_16, var_17)];
  return var_18;
}

function closestdistancebetweensegments(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_0;
  var_5 = var_3 - var_2;
  var_6 = var_0 - var_2;
  var_7 = vectordot(var_4, var_4);
  var_8 = vectordot(var_4, var_5);
  var_9 = vectordot(var_5, var_5);
  var_10 = vectordot(var_4, var_6);
  var_11 = vectordot(var_5, var_6);
  var_12 = var_7 * var_9 - var_8 * var_8;
  var_13 = var_12;
  var_14 = var_12;
  var_15 = 0;
  var_16 = 0;
  var_17 = 0;
  var_18 = 0;

  if(var_12 < 1e-08) {
    var_16 = 0;
    var_13 = 1;
    var_18 = var_11;
    var_14 = var_9;
  } else {
    var_16 = var_8 * var_11 - var_9 * var_10;
    var_18 = var_7 * var_11 - var_8 * var_10;

    if(var_16 < 0) {
      var_16 = 0;
      var_18 = var_11;
      var_14 = var_9;
    } else if(var_16 > var_13) {
      var_16 = var_13;
      var_18 = var_11 + var_8;
      var_14 = var_9;
    }
  }

  if(var_18 < 0) {
    var_18 = 0;

    if(var_10 * -1 < 0) {
      var_16 = 0;
    } else if(var_10 * -1 > var_7) {
      var_16 = var_13;
    } else {
      var_16 = var_10 * -1;
      var_13 = var_7;
    }
  } else if(var_18 > var_14) {
    var_18 = var_14;

    if(var_8 - var_10 < 0) {
      var_16 = 0;
    } else if(var_8 - var_10 > var_7) {
      var_16 = var_13;
    } else {
      var_16 = var_8 - var_10;
      var_13 = var_7;
    }
  }

  if(abs(var_16) > 1e-08) {
    var_15 = var_16 / var_13;
  }

  if(abs(var_18) > 1e-08) {
    var_17 = var_18 / var_14;
  }

  var_19 = var_0 + var_15 * var_4;
  var_20 = var_2 + var_17 * var_5;
  var_21 = [var_19, var_20, distance(var_19, var_20)];
  return var_21;
}

function is_dead_sentient() {
  return issentient(self) && !isalive(self);
}

function hastag(var_0, var_1) {
  if(!isDefined(var_0) || var_0 == "") {
    return 0;
  }

  if(!isDefined(level.has_tag)) {
    level.has_tag = [];
  }

  var_2 = var_0 + "_" + var_1;

  if(isDefined(level.has_tag[var_2])) {
    return level.has_tag[var_2];
  }

  var_3 = getnumparts(var_0);

  if(var_3 > 0) {
    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = tolower(getpartname(var_0, var_4));

      if(var_5 == tolower(var_1)) {
        level.has_tag[var_2] = 1;
        return 1;
      }
    }

    level.has_tag[var_2] = 0;
  }

  return 0;
}

function flashbanggettimeleftsec() {
  var_0 = self.flashendtime - gettime();

  if(var_0 < 0) {
    return 0;
  }

  return var_0 * 0.001;
}

function flashbangisactive() {
  return flashbanggettimeleftsec() > 0;
}

function player_died_recently() {
  return getdvarint("player_died_recently_count", "0");
}

function string(var_0) {
  return "" + var_0;
}

function playsoundontag(var_0, var_1, var_2, var_3, var_4) {
  [[level.fnplaysoundontag]](var_0, var_1, var_2, var_3, var_4);
}

function playsoundonentity(var_0, var_1) {
  [[level.fnplaysoundonentity]](var_0, var_1);
}

function set_movement_speed(var_0) {
  self._blackboard.requestedspeed = var_0;
  self aisetdesiredspeed(var_0);
}

function set_cautious_navigation(var_0) {
  self.cautiousnavigation = var_0;
}

function set_bounding_overwatch(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "cover_bounding_overwatch";
  }

  self.boundingoverwatchenabled = var_0;
  self.defaultcoverselector = var_1;
}

function doinglongdeath() {
  return isDefined(self.a.doinglongdeath);
}

function motionwarpwithnotetracks(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_3)) {
    var_7 = getnotetracktimes(var_0, var_3)[0];

    if(!isDefined(var_7)) {
      var_7 = 0;
    }
  } else {
    var_7 = 0;
  }

  if(isDefined(var_5)) {
    var_8 = getnotetracktimes(var_1, var_5)[0];

    if(!isDefined(var_8)) {
      var_8 = 1;
    }
  } else {
    var_8 = 1;
  }

  motionwarpwithtimes(var_2, var_3, var_4, var_8, var_8, var_7, var_7);
}

function motionwarpwithtimes(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_6)) {
    var_6 = 1;
  }

  var_7 = getangledelta(var_0, var_3, var_4);
  var_8 = getmovedelta(var_0, var_3, var_4);
  var_8 = rotatevector(var_8, (0, var_2[1] - var_7, 0));
  var_9 = var_1 - var_8;
  var_10 = var_2[1] - var_7;
  var_11 = (var_2[0], var_10, var_2[2]);
  var_12 = 1;
  var_13 = length(var_1 - self.origin);

  if(var_6 && var_13 > 0) {
    var_12 = length(var_8) / var_13;
    var_12 = clamp(var_12, 0.5, 2);
    self aisetanimrate(var_0, var_12);
  }

  if(!isDefined(var_5)) {
    var_14 = getanimlength(var_0) / var_12;
    var_5 = int((var_4 - var_3) * var_14 * 1000);
  }

  if(var_5 < 50) {
    var_5 = 50;
  }

  self motionwarpwithanim(var_9, var_11, var_1, var_2, var_5);
  return var_12;
}

function waittill_any_ents_or_timeout_return(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  self endon("death");
  var_15 = spawnStruct();
  GscBinSkip4(0x6e, var_1, var_2, var_15);
}

function time_has_passed(var_0, var_1) {
  if(!isDefined(var_0)) {
    return false;
  }

  return gettime() - var_0 >= var_1 * 1000;
}

function reacttolightifpossible(var_0) {
  self.lightreaction_lightorigin = var_0;
  self.lightreaction_requesttime = gettime();
}

function setcovercrouchtype(var_0) {
  switch (var_0) {
    case "right":
      self.covercrouchtype = "Cover Right Crouch";
      break;
    case "left":
      self.covercrouchtype = "Cover Left Crouch";
      break;
    case "crouch":
    default:
      self.covercrouchtype = "Cover Crouch";
      break;
  }
}

function setcornerstepoutsdisabled(var_0) {
  self.cornerstepoutsdisabled = var_0;
}

function getcornerstepoutsdisabled() {
  if(isDefined(self.cornerstepoutsdisabled)) {
    return self.cornerstepoutsdisabled;
  }

  return 0;
}

function can_trace_to_ai(var_0, var_1, var_2, var_3) {
  if(isent(self) || isai(self)) {
    var_4 = [self, var_1];
  } else {
    var_4 = [var_2];
  }

  if(isDefined(var_3)) {
    var_4 = array_combine(var_4, var_3);
  }

  if(scripts\engine\trace::ray_trace_passed(var_1, var_2.origin, var_4, var_4)) {
    return true;
  }

  if(scripts\engine\trace::ray_trace_passed(var_1, var_2 gettagorigin("j_spine4"), var_4, var_4)) {
    return true;
  }

  if(scripts\engine\trace::ray_trace_passed(var_1, var_2 getEye(), var_4, var_4)) {
    return true;
  }

  return false;
}

function array_removedead_or_dying(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = [];

  foreach(var_4 in var_0) {
    if(!isalive(var_4)) {
      continue;
    }

    if(isai(var_4) && var_1 && doinglongdeath(var_4)) {
      continue;
    }

    var_2 = var_4;
  }

  return var_2;
}

function disable_pain() {
  self.a.disablepain = 1;
  self.allowpain = 0;
}

function enable_pain() {
  self.a.disablepain = 0;
  self.allowpain = 1;
}

function get_ai_number() {
  if(!isDefined(self.unique_id)) {
    set_ai_number();
  }

  return self.unique_id;
}

function set_ai_number() {
  if(!isDefined(level.ai_number)) {
    level.ai_number = 0;
  }

  self.unique_id = "ai" + level.ai_number;
  level.ai_number++;
}

function ent_flag_wait(var_0) {
  while(isDefined(self) && !self.ent_flag[var_0]) {
    self waittill(var_0);
  }
}

function nuke_playmushroombnk(var_0, var_1, var_2, var_3) {
  while(isDefined(self)) {
    if(self.ent_flag[var_0] && self.ent_flag[var_1] && (!isDefined(var_2) || self.ent_flag[var_2]) && (!isDefined(var_3) || self.ent_flag[var_3])) {
      break;
    }

    ref_143a7(var_0, var_1, var_2, var_3);
  }
}

function array_ent_flag_wait(var_0, var_1) {
  var_2 = spawnStruct();

  foreach(var_4 in var_0) {
    if(ent_flag(var_4, var_1)) {
      var_0 = array_remove(var_0, var_4);
    }
  }

  array_thread(var_0, &array_ent_flag_wait_proc, var_2, var_1);

  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    var_2 waittill("notify");
  }
}

function array_ent_flag_wait_proc(var_0, var_1) {
  ent_flag_wait(var_1);
  var_0 notify("notify");
}

function ent_flag_wait_vehicle_node(var_0) {
  while(isDefined(self) && !self.ent_flag[var_0]) {
    self waittill(var_0);
  }
}

function ent_flag_wait_either(var_0, var_1) {
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

function ent_flag_wait_or_timeout(var_0, var_1) {
  var_2 = gettime();

  while(isDefined(self)) {
    if(self.ent_flag[var_0]) {
      break;
    }

    if(gettime() >= var_2 + var_1 * 1000) {
      break;
    }

    ent_wait_for_flag_or_time_elapses(var_0, var_1);
  }
}

function ent_wait_for_flag_or_time_elapses(var_0, var_1) {
  self endon(var_0);
  wait var_1;
}

function ent_flag_waitopen(var_0) {
  while(isDefined(self) && self.ent_flag[var_0]) {
    self waittill(var_0);
  }
}

function ent_flag_assert(var_0) {}

function ent_flag_waitopen_either(var_0, var_1) {
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

function ent_flag_init(var_0) {
  if(!isDefined(self.ent_flag)) {
    self.ent_flag = [];
    self.ent_flags_lock = [];
  }

  self.ent_flag[var_0] = 0;
}

function ent_flag_exist(var_0) {
  if(isDefined(self.ent_flag) && isDefined(self.ent_flag[var_0])) {
    return true;
  }

  return false;
}

function ent_flag_set_delayed(var_0, var_1) {
  self endon("death");
  wait var_1;
  ent_flag_set(var_0);
}

function ent_flag_set(var_0) {
  self.ent_flag[var_0] = 1;
  self notify(var_0);
}

function ent_flag_clear(var_0, var_1) {
  if(self.ent_flag[var_0]) {
    self.ent_flag[var_0] = 0;
    self notify(var_0);
  }

  if(istrue(var_1)) {
    self.ent_flag[var_0] = undefined;
    return;
  }
}

function ent_flag_clear_delayed(var_0, var_1) {
  wait var_1;

  if(isDefined(self)) {
    ent_flag_clear(var_0);
    return;
  }
}

function ent_flag(var_0) {
  return self.ent_flag[var_0];
}

function get_linked_structs() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = get_links();

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = getStructArray(var_1[var_2], "script_linkname");

      if(var_3.size > 0) {
        var_0 = array_combine(var_0, var_3);
      }
    }
  }

  return var_0;
}

function updatescrapassistdata(var_0, var_1, var_2) {
  if(squared(var_0[0] - var_1[0]) + squared(var_0[1] - var_1[1]) <= squared(var_2)) {
    return true;
  }

  return false;
}

function ref_12c44(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self setpredictedstreamloaddist(var_0);

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 == "gamerprofile_request") {
      return var_2;
    }
  }
}

function update_hint_logic_killstreak() {
  var_0 = 1;
  var_1 = 0;

  if(is_player_gamepad_enabled()) {
    var_1 = ref_12c44("mountButtonConfig");
  } else {
    var_1 = ref_12c44("mountButtonConfigKBM");
  }

  return var_1 != var_0;
}

function remove_player_rig_laser_panel(var_0) {
  if(isnumber(var_0)) {
    return int(var_0);
  }

  return 0;
}

function ref_13926(var_0) {
  var_1 = (0, 0, 0);
  var_2 = strtok(var_0, " ");

  if(var_2.size == 3) {
    var_1 = (float(var_2[0]), float(var_2[1]), float(var_2[2]));
  }

  return var_1;
}

function multitablelookup(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_6 = tablelookup(var_5, var_1, var_2, var_3);

    if(isDefined(var_6)) {
      return var_6;
    }
  }

  return undefined;
}