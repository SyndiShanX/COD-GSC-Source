/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\engine\utility.gsc
***********************************************/

function noself_func(var0, var1, var2, var3, var4) {
  if(!isDefined(level.func)) {
    return;
  }

  if(!isDefined(level.func[var0])) {
    return;
  }

  if(!isDefined(var1)) {
    builtin[[level.func[var0]]]();
    return;
  }

  if(!isDefined(var2)) {
    builtin[[level.func[var0]]](var1);
    return;
  }

  if(!isDefined(var3)) {
    builtin[[level.func[var0]]](var1, var2);
    return;
  }

  if(!isDefined(var4)) {
    builtin[[level.func[var0]]](var1, var2, var3);
    return;
  }

  builtin[[level.func[var0]]](var1, var2, var3, var4);
}

function noself_func_return(var0, var1, var2, var3, var4) {
  if(!isDefined(level.func)) {
    return undefined;
  }

  if(!isDefined(level.func[var0])) {
    return undefined;
  }

  if(!isDefined(var1)) {
    return builtin[[level.func[var0]]]();
  }

  if(!isDefined(var2)) {
    return builtin[[level.func[var0]]](var1);
  }

  if(!isDefined(var3)) {
    return builtin[[level.func[var0]]](var1, var2);
  }

  if(!isDefined(var4)) {
    return builtin[[level.func[var0]]](var1, var2, var3);
  }

  return builtin[[level.func[var0]]](var1, var2, var3, var4);
}

function self_func(var0, var1, var2, var3, var4) {
  if(!isDefined(level.func[var0])) {
    return;
  }

  if(!isDefined(var1)) {
    self builtin[[level.func[var0]]]();
    return;
  }

  if(!isDefined(var2)) {
    self builtin[[level.func[var0]]](var1);
    return;
  }

  if(!isDefined(var3)) {
    self builtin[[level.func[var0]]](var1, var2);
    return;
  }

  if(!isDefined(var4)) {
    self builtin[[level.func[var0]]](var1, var2, var3);
    return;
  }

  self builtin[[level.func[var0]]](var1, var2, var3, var4);
}

function script_func(var0, var1, var2, var3, var4) {
  if(!isDefined(level.func[var0])) {
    return;
  }

  if(!isDefined(var1)) {
    return self[[level.func[var0]]]();
  } else if(!isDefined(var2)) {
    return self[[level.func[var0]]](var1);
  } else if(!isDefined(var3)) {
    return self[[level.func[var0]]](var1, var2);
  } else if(!isDefined(var4)) {
    return self[[level.func[var0]]](var1, var2, var3);
  }

  return self[[level.func[var0]]](var1, var2, var3, var4);
}

function randomvector(var0) {
  return (randomfloat(var0) - var0 * 0.5, randomfloat(var0) - var0 * 0.5, randomfloat(var0) - var0 * 0.5);
}

function randomvectorrange(var0, var1) {
  var2 = randomfloatrange(var0, var1);

  if(randomint(2) == 0) {
    var2 *= -1;
  }

  var3 = randomfloatrange(var0, var1);

  if(randomint(2) == 0) {
    var3 *= -1;
  }

  var4 = randomfloatrange(var0, var1);

  if(randomint(2) == 0) {
    var4 *= -1;
  }

  return (var2, var3, var4);
}

function sign(var0) {
  if(var0 >= 0) {
    return 1;
  }

  return -1;
}

function randomonunitsphere() {
  var0 = randomfloat(180);
  var1 = randomfloat(360);
  var2 = cos(var1) * cos(var0);
  var3 = cos(var1) * sin(var0);
  var4 = sin(var1);
  return (var2, var3, var4);
}

function mod(var0, var1) {
  var2 = int(var0 / var1);

  if(var0 * var1 < 0) {
    var2 -= 1;
  }

  return var0 - var2 * var1;
}

function get_enemy_team(var0) {
  var1 = [];
  GscBinSkip0(0x2e, "axis", "allies");
}

function clear_exception(var0) {
  self.exception[var0] = anim.defaultexception;
}

function cointoss() {
  return randomint(100) >= 50;
}

function choose_from_weighted_array(var0, var1) {
  var2 = randomint(var1[var1.size - 1] + 1);

  for(var3 = 0; var3 < var1.size; var3++) {
    if(var2 <= var1[var3]) {
      return var0[var3];
    }
  }
}

function waittill_string(var0, var1) {
  if(var0 != "death") {
    self endon("death");
  }

  var1 endon("die");
  self waittill(var0);
  var1 notify("returned", var0);
}

function waittillmatch_string(var0, var1, var2) {
  if(var1 != "death") {
    self endon("death");
  }

  var2 endon("die");
  self waittillmatch(var0, var1);
  var2 notify("returned", var1);
}

function waittill_string_no_endon_death(var0, var1) {
  var1 endon("die");
  self waittill(var0);
  var1 notify("returned", var0);
}

function waittill_multiple(var0, var1, var2, var3, var4) {
  self endon("death");
  var5 = spawnStruct();
  var5.threads = 0;

  if(isDefined(var0)) {
    GscBinSkip4(0x35, var0, var5);
  }

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var5);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var5);
  }

  if(isDefined(var3)) {
    GscBinSkip4(0x35, var3, var5);
  }

  if(isDefined(var4)) {
    GscBinSkip4(0x35, var4, var5);
  }

  while(var5.threads) {
    var5 waittill("returned");
    var5.threads--;
  }

  var5 notify("die");
}

function ref_1439f(var0, var1) {
  self endon("death");
  var2 = spawnStruct();
  var2.threads = 0;

  if(isDefined(var0)) {
    GscBinSkip4(0x35, var0, var2);
  }

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var2);
  }

  while(var2.threads) {
    var2 waittill("returned");
    var2.threads--;
  }

  var2 notify("die");
}

function waittillmatch_notify(var0, var1, var2) {
  self endon("death");
  self waittillmatch(var0, var1);
  self notify(var2);
}

function ref_143ac(var0) {
  if(!isDefined(var0) || var0 != "death") {
    self endon("death");
  }

  var1 = spawnStruct();
  jumpiffalse(isDefined(var0)) LOC_0000002c;
  GscBinSkip4(0x35, var0, var1);

  var1 waittill("returned", var2);
  var1 notify("die");
  return var2;
}

function ref_143ad(var0, var1) {
  if((!isDefined(var0) || var0 != "death") && (!isDefined(var1) || var1 != "death")) {
    self endon("death");
  }

  var2 = spawnStruct();

  if(isDefined(var0)) {
    GscBinSkip4(0x35, var0, var2);
  }

  jumpiffalse(isDefined(var1)) LOC_0000004a;
  GscBinSkip4(0x35, var1, var2);

  var2 waittill("returned", var3);
  var2 notify("die");
  return var3;
}

function ref_143ae(var0, var1, var2) {
  if((!isDefined(var0) || var0 != "death") && (!isDefined(var1) || var1 != "death") && (!isDefined(var2) || var2 != "death")) {
    self endon("death");
  }

  var3 = spawnStruct();

  if(isDefined(var0)) {
    GscBinSkip4(0x35, var0, var3);
  }

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var3);
  }

  jumpiffalse(isDefined(var2)) LOC_00000068;
  GscBinSkip4(0x35, var2, var3);

  var3 waittill("returned", var4);
  var3 notify("die");
  return var4;
}

function ref_143af(var0, var1, var2, var3) {
  if((!isDefined(var0) || var0 != "death") && (!isDefined(var1) || var1 != "death") && (!isDefined(var2) || var2 != "death") && (!isDefined(var3) || var3 != "death")) {
    self endon("death");
  }

  var4 = spawnStruct();

  if(isDefined(var0)) {
    GscBinSkip4(0x35, var0, var4);
  }

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var4);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var4);
  }

  jumpiffalse(isDefined(var3)) LOC_00000086;
  GscBinSkip4(0x35, var3, var4);

  var4 waittill("returned", var5);
  var4 notify("die");
  return var5;
}

function ref_143b0(var0, var1, var2, var3, var4) {
  if((!isDefined(var0) || var0 != "death") && (!isDefined(var1) || var1 != "death") && (!isDefined(var2) || var2 != "death") && (!isDefined(var3) || var3 != "death") && (!isDefined(var4) || var4 != "death")) {
    self endon("death");
  }

  var5 = spawnStruct();

  if(isDefined(var0)) {
    GscBinSkip4(0x35, var0, var5);
  }

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var5);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var5);
  }

  if(isDefined(var3)) {
    GscBinSkip4(0x35, var3, var5);
  }

  jumpiffalse(isDefined(var4)) LOC_000000a4;
  GscBinSkip4(0x35, var4, var5);

  var5 waittill("returned", var6);
  var5 notify("die");
  return var6;
}

function ref_143b1(var0, var1, var2, var3, var4, var5) {
  if((!isDefined(var0) || var0 != "death") && (!isDefined(var1) || var1 != "death") && (!isDefined(var2) || var2 != "death") && (!isDefined(var3) || var3 != "death") && (!isDefined(var4) || var4 != "death") && (!isDefined(var5) || var5 != "death")) {
    self endon("death");
  }

  var6 = spawnStruct();

  if(isDefined(var0)) {
    GscBinSkip4(0x35, var0, var6);
  }

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var6);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var6);
  }

  if(isDefined(var3)) {
    GscBinSkip4(0x35, var3, var6);
  }

  if(isDefined(var4)) {
    GscBinSkip4(0x35, var4, var6);
  }

  jumpiffalse(isDefined(var5)) LOC_000000c4;
  GscBinSkip4(0x35, var5, var6);

  var6 waittill("returned", var7);
  var6 notify("die");
  return var7;
}

function ref_143b2(var0, var1, var2, var3, var4, var5, var6) {
  if((!isDefined(var0) || var0 != "death") && (!isDefined(var1) || var1 != "death") && (!isDefined(var2) || var2 != "death") && (!isDefined(var3) || var3 != "death") && (!isDefined(var4) || var4 != "death") && (!isDefined(var5) || var5 != "death") && (!isDefined(var6) || var6 != "death")) {
    self endon("death");
  }

  var7 = spawnStruct();

  if(isDefined(var0)) {
    GscBinSkip4(0x35, var0, var7);
  }

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var7);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var7);
  }

  if(isDefined(var3)) {
    GscBinSkip4(0x35, var3, var7);
  }

  if(isDefined(var4)) {
    GscBinSkip4(0x35, var4, var7);
  }

  if(isDefined(var5)) {
    GscBinSkip4(0x35, var5, var7);
  }

  jumpiffalse(isDefined(var6)) LOC_000000e6;
  GscBinSkip4(0x35, var6, var7);

  var7 waittill("returned", var8);
  var7 notify("die");
  return var8;
}

function waittill_any_return(var0, var1, var2, var3, var4, var5, var6, var7) {
  if((!isDefined(var0) || var0 != "death") && (!isDefined(var1) || var1 != "death") && (!isDefined(var2) || var2 != "death") && (!isDefined(var3) || var3 != "death") && (!isDefined(var4) || var4 != "death") && (!isDefined(var5) || var5 != "death") && (!isDefined(var6) || var6 != "death") && (!isDefined(var7) || var7 != "death")) {
    self endon("death");
  }

  var8 = spawnStruct();

  if(isDefined(var0)) {
    GscBinSkip4(0x35, var0, var8);
  }

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var8);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var8);
  }

  if(isDefined(var3)) {
    GscBinSkip4(0x35, var3, var8);
  }

  if(isDefined(var4)) {
    GscBinSkip4(0x35, var4, var8);
  }

  if(isDefined(var5)) {
    GscBinSkip4(0x35, var5, var8);
  }

  if(isDefined(var6)) {
    GscBinSkip4(0x35, var6, var8);
  }

  jumpiffalse(isDefined(var7)) LOC_00000108;
  GscBinSkip4(0x35, var7, var8);

  var8 waittill("returned", var9);
  var8 notify("die");
  return var9;
}

function waittillmatch_any_return(var0, var1, var2, var3, var4, var5, var6) {
  if((!isDefined(var1) || var1 != "death") && (!isDefined(var2) || var2 != "death") && (!isDefined(var3) || var3 != "death") && (!isDefined(var4) || var4 != "death") && (!isDefined(var5) || var5 != "death") && (!isDefined(var6) || var6 != "death")) {
    self endon("death");
  }

  var7 = spawnStruct();

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var0, var1, var7);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var0, var2, var7);
  }

  if(isDefined(var3)) {
    GscBinSkip4(0x35, var0, var3, var7);
  }

  if(isDefined(var4)) {
    GscBinSkip4(0x35, var0, var4, var7);
  }

  if(isDefined(var5)) {
    GscBinSkip4(0x35, var0, var5, var7);
  }

  jumpiffalse(isDefined(var6)) LOC_000000d1;
  GscBinSkip4(0x35, var0, var6, var7);

  var7 waittill("returned", var8);
  var7 notify("die");
  return var8;
}

function ref_143b3(var0) {
  var1 = spawnStruct();
  jumpiffalse(isDefined(var0)) LOC_00000015;
  GscBinSkip4(0x35, var0, var1);

  var1 waittill("returned", var2);
  var1 notify("die");
  return var2;
}

function ref_143b4(var0, var1) {
  var2 = spawnStruct();

  if(isDefined(var0)) {
    GscBinSkip4(0x35, var0, var2);
  }

  jumpiffalse(isDefined(var1)) LOC_00000023;
  GscBinSkip4(0x35, var1, var2);

  var2 waittill("returned", var3);
  var2 notify("die");
  return var3;
}

function ref_143b5(var0, var1, var2) {
  var3 = spawnStruct();

  if(isDefined(var0)) {
    GscBinSkip4(0x35, var0, var3);
  }

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var3);
  }

  jumpiffalse(isDefined(var2)) LOC_00000031;
  GscBinSkip4(0x35, var2, var3);

  var3 waittill("returned", var4);
  var3 notify("die");
  return var4;
}

function ref_143b6(var0, var1, var2, var3) {
  var4 = spawnStruct();

  if(isDefined(var0)) {
    GscBinSkip4(0x35, var0, var4);
  }

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var4);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var4);
  }

  jumpiffalse(isDefined(var3)) LOC_0000003f;
  GscBinSkip4(0x35, var3, var4);

  var4 waittill("returned", var5);
  var4 notify("die");
  return var5;
}

function ref_143b7(var0, var1, var2, var3, var4) {
  var5 = spawnStruct();

  if(isDefined(var0)) {
    GscBinSkip4(0x35, var0, var5);
  }

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var5);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var5);
  }

  if(isDefined(var3)) {
    GscBinSkip4(0x35, var3, var5);
  }

  jumpiffalse(isDefined(var4)) LOC_0000004d;
  GscBinSkip4(0x35, var4, var5);

  var5 waittill("returned", var6);
  var5 notify("die");
  return var6;
}

function ref_143b8(var0, var1, var2, var3, var4, var5) {
  var6 = spawnStruct();

  if(isDefined(var0)) {
    GscBinSkip4(0x35, var0, var6);
  }

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var6);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var6);
  }

  if(isDefined(var3)) {
    GscBinSkip4(0x35, var3, var6);
  }

  if(isDefined(var4)) {
    GscBinSkip4(0x35, var4, var6);
  }

  jumpiffalse(isDefined(var5)) LOC_0000005d;
  GscBinSkip4(0x35, var5, var6);

  var6 waittill("returned", var7);
  var6 notify("die");
  return var7;
}

function waittill_any_return_no_endon_death(var0, var1, var2, var3, var4, var5) {
  var6 = spawnStruct();

  if(isDefined(var0)) {
    GscBinSkip4(0x35, var0, var6);
  }

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var6);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var6);
  }

  if(isDefined(var3)) {
    GscBinSkip4(0x35, var3, var6);
  }

  if(isDefined(var4)) {
    GscBinSkip4(0x35, var4, var6);
  }

  jumpiffalse(isDefined(var5)) LOC_0000005d;
  GscBinSkip4(0x35, var5, var6);

  var6 waittill("returned", var7);
  var6 notify("die");
  return var7;
}

function waittill_any_in_array_return(var0) {
  var1 = spawnStruct();
  var2 = 0;
  var3 = var0;
  var5 = getfirstarraykey(var3);

  if(isDefined(var5)) {
    var4 = var3[var5];
    GscBinSkip4(0x35, var4, var1);
  }

  var3 = undefined;
  var5 = undefined;
  jumpiftrue(var2) LOC_0000004d;
  self endon("death");
  var1 waittill("returned", var6);
  var1 notify("die");
  return var6;
}

function waittill_any_in_array_return_no_endon_death(var0) {
  var1 = spawnStruct();
  var2 = var0;
  var4 = getfirstarraykey(var2);

  if(isDefined(var4)) {
    var3 = var2[var4];
    GscBinSkip4(0x35, var3, var1);
  }

  var2 = undefined;
  var4 = undefined;
  var1 waittill("returned", var5);
  var1 notify("die");
  return var5;
}

function waittill_any_in_array_or_timeout(var0, var1) {
  var2 = spawnStruct();
  var3 = 0;
  var4 = var0;
  var6 = getfirstarraykey(var4);

  if(isDefined(var6)) {
    var5 = var4[var6];
    GscBinSkip4(0x35, var5, var2);
  }

  var4 = undefined;
  var6 = undefined;

  if(!var3) {
    self endon("death");
  }

  GscBinSkip4(0x6e, var2, var1);
}

function waittill_any_in_array_or_timeout_no_endon_death(var0, var1) {
  var2 = spawnStruct();
  var3 = var0;
  var5 = getfirstarraykey(var3);

  if(isDefined(var5)) {
    var4 = var3[var5];
    GscBinSkip4(0x35, var4, var2);
  }

  var3 = undefined;
  var5 = undefined;
  thread _timeout(var2);
  var2 waittill("returned", var6);
  var2 notify("die");
  return var6;
}

function waittill_all_in_array(var0) {
  while(var0.size) {
    var1 = waittill_any_in_array_return(var0);
    var0 = array_remove(var0, var1);
  }
}

function ref_143b9(var0, var1) {
  if(!isDefined(var1) || var1 != "death") {
    self endon("death");
  }

  var2 = spawnStruct();

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var2);
  }

  GscBinSkip4(0x6e, var2, var0);
}

function ref_143ba(var0, var1, var2) {
  if((!isDefined(var1) || var1 != "death") && (!isDefined(var2) || var2 != "death")) {
    self endon("death");
  }

  var3 = spawnStruct();

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var3);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var3);
  }

  GscBinSkip4(0x6e, var3, var0);
}

function ref_143bb(var0, var1, var2, var3) {
  if((!isDefined(var1) || var1 != "death") && (!isDefined(var2) || var2 != "death") && (!isDefined(var3) || var3 != "death")) {
    self endon("death");
  }

  var4 = spawnStruct();

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var4);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var4);
  }

  if(isDefined(var3)) {
    GscBinSkip4(0x35, var3, var4);
  }

  GscBinSkip4(0x6e, var4, var0);
}

function ref_143bc(var0, var1, var2, var3, var4) {
  if((!isDefined(var1) || var1 != "death") && (!isDefined(var2) || var2 != "death") && (!isDefined(var3) || var3 != "death") && (!isDefined(var4) || var4 != "death")) {
    self endon("death");
  }

  var5 = spawnStruct();

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var5);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var5);
  }

  if(isDefined(var3)) {
    GscBinSkip4(0x35, var3, var5);
  }

  if(isDefined(var4)) {
    GscBinSkip4(0x35, var4, var5);
  }

  GscBinSkip4(0x6e, var5, var0);
}

function ref_143bd(var0, var1, var2, var3, var4, var5) {
  if((!isDefined(var1) || var1 != "death") && (!isDefined(var2) || var2 != "death") && (!isDefined(var3) || var3 != "death") && (!isDefined(var4) || var4 != "death") && (!isDefined(var5) || var5 != "death")) {
    self endon("death");
  }

  var6 = spawnStruct();

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var6);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var6);
  }

  if(isDefined(var3)) {
    GscBinSkip4(0x35, var3, var6);
  }

  if(isDefined(var4)) {
    GscBinSkip4(0x35, var4, var6);
  }

  if(isDefined(var5)) {
    GscBinSkip4(0x35, var5, var6);
  }

  GscBinSkip4(0x6e, var6, var0);
}

function ref_143be(var0, var1, var2, var3, var4, var5, var6) {
  if((!isDefined(var1) || var1 != "death") && (!isDefined(var2) || var2 != "death") && (!isDefined(var3) || var3 != "death") && (!isDefined(var4) || var4 != "death") && (!isDefined(var5) || var5 != "death") && (!isDefined(var6) || var6 != "death")) {
    self endon("death");
  }

  var7 = spawnStruct();

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var7);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var7);
  }

  if(isDefined(var3)) {
    GscBinSkip4(0x35, var3, var7);
  }

  if(isDefined(var4)) {
    GscBinSkip4(0x35, var4, var7);
  }

  if(isDefined(var5)) {
    GscBinSkip4(0x35, var5, var7);
  }

  if(isDefined(var6)) {
    GscBinSkip4(0x35, var6, var7);
  }

  GscBinSkip4(0x6e, var7, var0);
}

function waittill_any_timeout(var0, var1, var2, var3, var4, var5, var6) {
  if((!isDefined(var1) || var1 != "death") && (!isDefined(var2) || var2 != "death") && (!isDefined(var3) || var3 != "death") && (!isDefined(var4) || var4 != "death") && (!isDefined(var5) || var5 != "death") && (!isDefined(var6) || var6 != "death")) {
    self endon("death");
  }

  var7 = spawnStruct();

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var7);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var7);
  }

  if(isDefined(var3)) {
    GscBinSkip4(0x35, var3, var7);
  }

  if(isDefined(var4)) {
    GscBinSkip4(0x35, var4, var7);
  }

  if(isDefined(var5)) {
    GscBinSkip4(0x35, var5, var7);
  }

  if(isDefined(var6)) {
    GscBinSkip4(0x35, var6, var7);
  }

  GscBinSkip4(0x6e, var7, var0);
}

function _timeout(var0) {
  self endon("die");
  wait var0;
  self notify("returned", "timeout");
}

function ref_143bf(var0, var1) {
  var2 = spawnStruct();

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var2);
  }

  GscBinSkip4(0x6e, var2, var0);
}

function ref_143c0(var0, var1, var2) {
  var3 = spawnStruct();

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var3);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var3);
  }

  GscBinSkip4(0x6e, var3, var0);
}

function ref_143c1(var0, var1, var2, var3) {
  var4 = spawnStruct();

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var4);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var4);
  }

  if(isDefined(var3)) {
    GscBinSkip4(0x35, var3, var4);
  }

  GscBinSkip4(0x6e, var4, var0);
}

function ref_143c2(var0, var1, var2, var3, var4) {
  var5 = spawnStruct();

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var5);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var5);
  }

  if(isDefined(var3)) {
    GscBinSkip4(0x35, var3, var5);
  }

  if(isDefined(var4)) {
    GscBinSkip4(0x35, var4, var5);
  }

  GscBinSkip4(0x6e, var5, var0);
}

function ref_143c3(var0, var1, var2, var3, var4, var5) {
  var6 = spawnStruct();

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var6);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var6);
  }

  if(isDefined(var3)) {
    GscBinSkip4(0x35, var3, var6);
  }

  if(isDefined(var4)) {
    GscBinSkip4(0x35, var4, var6);
  }

  if(isDefined(var5)) {
    GscBinSkip4(0x35, var5, var6);
  }

  GscBinSkip4(0x6e, var6, var0);
}

function waittill_any_timeout_no_endon_death(var0, var1, var2, var3, var4, var5) {
  var6 = spawnStruct();

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var6);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var6);
  }

  if(isDefined(var3)) {
    GscBinSkip4(0x35, var3, var6);
  }

  if(isDefined(var4)) {
    GscBinSkip4(0x35, var4, var6);
  }

  if(isDefined(var5)) {
    GscBinSkip4(0x35, var5, var6);
  }

  GscBinSkip4(0x6e, var6, var0);
}

function ref_143a5(var0, var1) {
  if(isDefined(var1)) {
    self endon(var1);
  }

  self waittill(var0);
}

function ref_143a6(var0, var1, var2) {
  if(isDefined(var1)) {
    self endon(var1);
  }

  if(isDefined(var2)) {
    self endon(var2);
  }

  self waittill(var0);
}

function ref_143a7(var0, var1, var2, var3) {
  if(isDefined(var1)) {
    self endon(var1);
  }

  if(isDefined(var2)) {
    self endon(var2);
  }

  if(isDefined(var3)) {
    self endon(var3);
  }

  self waittill(var0);
}

function ref_143a8(var0, var1, var2, var3, var4) {
  if(isDefined(var1)) {
    self endon(var1);
  }

  if(isDefined(var2)) {
    self endon(var2);
  }

  if(isDefined(var3)) {
    self endon(var3);
  }

  if(isDefined(var4)) {
    self endon(var4);
  }

  self waittill(var0);
}

function ref_143a9(var0, var1, var2, var3, var4, var5) {
  if(isDefined(var1)) {
    self endon(var1);
  }

  if(isDefined(var2)) {
    self endon(var2);
  }

  if(isDefined(var3)) {
    self endon(var3);
  }

  if(isDefined(var4)) {
    self endon(var4);
  }

  if(isDefined(var5)) {
    self endon(var5);
  }

  self waittill(var0);
}

function ref_143aa(var0, var1, var2, var3, var4, var5, var6) {
  if(isDefined(var1)) {
    self endon(var1);
  }

  if(isDefined(var2)) {
    self endon(var2);
  }

  if(isDefined(var3)) {
    self endon(var3);
  }

  if(isDefined(var4)) {
    self endon(var4);
  }

  if(isDefined(var5)) {
    self endon(var5);
  }

  if(isDefined(var6)) {
    self endon(var6);
  }

  self waittill(var0);
}

function ref_143ab(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(isDefined(var1)) {
    self endon(var1);
  }

  if(isDefined(var2)) {
    self endon(var2);
  }

  if(isDefined(var3)) {
    self endon(var3);
  }

  if(isDefined(var4)) {
    self endon(var4);
  }

  if(isDefined(var5)) {
    self endon(var5);
  }

  if(isDefined(var6)) {
    self endon(var6);
  }

  if(isDefined(var7)) {
    self endon(var7);
  }

  self waittill(var0);
}

function waittill_any(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(isDefined(var1)) {
    self endon(var1);
  }

  if(isDefined(var2)) {
    self endon(var2);
  }

  if(isDefined(var3)) {
    self endon(var3);
  }

  if(isDefined(var4)) {
    self endon(var4);
  }

  if(isDefined(var5)) {
    self endon(var5);
  }

  if(isDefined(var6)) {
    self endon(var6);
  }

  if(isDefined(var7)) {
    self endon(var7);
  }

  self waittill(var0);
}

function waittill_any_two(var0, var1) {
  if(isDefined(var1)) {
    self endon(var1);
  }

  self waittill(var0);
}

function waittill_any_ents(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
  if(isDefined(var2) && isDefined(var3)) {
    var2 endon(var3);
  }

  if(isDefined(var4) && isDefined(var5)) {
    var4 endon(var5);
  }

  if(isDefined(var6) && isDefined(var7)) {
    var6 endon(var7);
  }

  if(isDefined(var8) && isDefined(var9)) {
    var8 endon(var9);
  }

  if(isDefined(var10) && isDefined(var11)) {
    var10 endon(var11);
  }

  if(isDefined(var12) && isDefined(var13)) {
    var12 endon(var13);
  }

  var0 waittill(var1);
}

function waittill_any_ents_return(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
  self endon("death");
  var14 = spawnStruct();
  GscBinSkip4(0x6e, var0, var1, var14);
}

function waittill_any_ents_array(var0, var1, var2, var3, var4, var5, var6, var7) {
  foreach(var9 in var0) {
    if(var9 != var0[0]) {
      var9 endon(var1);
    }

    if(isDefined(var2)) {
      var9 endon(var2);
    }

    if(isDefined(var3)) {
      var9 endon(var3);
    }

    if(isDefined(var4)) {
      var9 endon(var4);
    }

    if(isDefined(var5)) {
      var9 endon(var5);
    }

    if(isDefined(var6)) {
      var9 endon(var6);
    }

    if(isDefined(var7)) {
      var9 endon(var7);
    }
  }

  var0[0] waittill(var1);
}

function wait_time_in_ms(var0) {
  var1 = gettime() + var0;

  while(gettime() < var1) {
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
  var0 = gettime();

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

  return gettime() - var0;
}

function isflashed() {
  if(!isDefined(self.flashendtime)) {
    return false;
  }

  return gettime() < self.flashendtime;
}

function flag_exist(var0) {
  if(!isDefined(level.flag)) {
    return false;
  }

  return isDefined(level.flag[var0]);
}

function flag(var0) {
  return level.flag[var0];
}

function flag_init(var0) {
  if(!isDefined(level.flag)) {
    scripts\engine\flags::init_flags();
  }

  level.flag[var0] = 0;
  init_trigger_flags();

  if(!isDefined(level.trigger_flags[var0])) {
    level.trigger_flags[var0] = [];
    return;
  }
}

function empty_init_func(var0) {}

function flag_set(var0, var1) {
  level.flag[var0] = 1;
  set_trigger_flag_permissions(var0);

  if(isDefined(var1)) {
    level notify(var0, var1);
    return;
  }

  level notify(var0);
}

function flag_wait(var0) {
  var1 = undefined;

  while(!flag(var0)) {
    var1 = undefined;
    level waittill(var0, var1);
  }

  if(isDefined(var1)) {
    return var1;
  }
}

function flag_clear(var0) {
  if(!flag(var0)) {
    return;
  }

  level.flag[var0] = 0;
  set_trigger_flag_permissions(var0);
  level notify(var0);
}

function flag_waitopen(var0) {
  while(flag(var0)) {
    level waittill(var0);
  }
}

function waittill_either(var0, var1) {
  self endon(var0);
  self waittill(var1);
  return var1;
}

function trigger_on(var0, var1) {
  if(isDefined(var0) && isDefined(var1)) {
    var2 = getEntArray(var0, var1);
    array_thread(var2, &trigger_on_proc);
    return;
  }

  trigger_on_proc();
}

function trigger_on_proc() {
  self triggerenable();
  self.trigger_off = undefined;
}

function trigger_off(var0, var1) {
  if(isDefined(var0) && isDefined(var1)) {
    var2 = getEntArray(var0, var1);
    array_thread(var2, &trigger_off_proc);
    return;
  }

  trigger_off_proc();
}

function trigger_off_proc() {
  self triggerdisable();
  self.trigger_off = 1;
  self notify("trigger_off");
}

function set_trigger_flag_permissions(var0) {
  if(!isDefined(level.trigger_flags)) {
    return;
  }

  level.trigger_flags[var0] = array_removeundefined(level.trigger_flags[var0]);
  array_thread(level.trigger_flags[var0], &update_trigger_based_on_flags);
}

function update_trigger_based_on_flags() {
  var0 = 1;

  if(isDefined(self.script_flag_true)) {
    var0 = 0;
    var1 = create_flags_and_return_tokens(self.script_flag_true);

    foreach(var3 in var1) {
      if(flag(var3)) {
        var0 = 1;
        break;
      }
    }
  }

  var5 = 1;

  if(isDefined(self.script_flag_false)) {
    var1 = create_flags_and_return_tokens(self.script_flag_false);

    foreach(var3 in var1) {
      if(flag(var3)) {
        var5 = 0;
        break;
      }
    }
  }

  [[level.trigger_func[var0 && var5]]]();
}

function create_flags_and_return_tokens(var0) {
  var1 = strtok(var0, " ");

  for(var2 = 0; var2 < var1.size; var2++) {
    if(!isDefined(level.flag[var1[var2]])) {
      flag_init(var1[var2]);
    }
  }

  return var1;
}

function init_trigger_flags() {
  if(!add_init_script("trigger_flags", &init_trigger_flags)) {
    return;
  }

  level.trigger_flags = [];
  level.trigger_func[1] = &trigger_on;
  level.trigger_func[0] = &trigger_off;
}

function getStruct(var0, var1) {
  var2 = level.struct_class_names[var1][var0];

  if(!isDefined(var2)) {
    return undefined;
  }

  if(var2.size > 1) {
    return undefined;
  }

  return var2[0];
}

function getStructArray(var0, var1) {
  var2 = level.struct_class_names[var1][var0];

  if(!isDefined(var2)) {
    return [];
  }

  return var2;
}

function add_smartobject_point(var0) {
  if(!isDefined(anim.smartobjectpoints)) {
    anim.smartobjectpoints = [];
  }

  anim.smartobjectpoints[anim.smartobjectpoints.size] = var0;
}

function store_linked_smartobjects() {
  if(!isDefined(anim.smartobjectpoints)) {
    return;
  }

  foreach(var1 in anim.smartobjectpoints) {
    if(isDefined(var1.script_linkto)) {
      var2 = get_linked_structs(var1);

      foreach(var4 in var2) {
        if(var4 == var1) {
          continue;
        }

        if(!isDefined(var4.script_smartobject)) {
          continue;
        }

        if(!isDefined(var1.linkedsmartobjects)) {
          var1.linkedsmartobjects = [];
        }

        var1.linkedsmartobjects[var1.linkedsmartobjects.size] = var4;
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

  foreach(var1 in level.struct) {
    if(isDefined(var1.script_smartobject)) {
      add_smartobject_point(var1);
    }

    if(isDefined(var1.targetname)) {
      if(var1.targetname == "delete_on_load") {
        level.struct[var3] = undefined;
        continue;
      }

      if(isDefined(level.struct_filter)) {
        if(![[level.struct_filter]](var1)) {
          level.struct[var3] = undefined;
          continue;
        }
      }

      if(!isDefined(level.struct_class_names["targetname"][var1.targetname])) {
        level.struct_class_names["targetname"][var1.targetname] = [];
      }

      var2 = level.struct_class_names["targetname"][var1.targetname].size;
      level.struct_class_names["targetname"][var1.targetname][var2] = var1;
    }

    if(isDefined(var1.target)) {
      if(!isDefined(level.struct_class_names["target"][var1.target])) {
        level.struct_class_names["target"][var1.target] = [];
      }

      var2 = level.struct_class_names["target"][var1.target].size;
      level.struct_class_names["target"][var1.target][var2] = var1;
    }

    if(isDefined(var1.script_noteworthy)) {
      if(!isDefined(level.struct_class_names["script_noteworthy"][var1.script_noteworthy])) {
        level.struct_class_names["script_noteworthy"][var1.script_noteworthy] = [];
      }

      var2 = level.struct_class_names["script_noteworthy"][var1.script_noteworthy].size;
      level.struct_class_names["script_noteworthy"][var1.script_noteworthy][var2] = var1;
    }

    if(isDefined(var1.script_linkname)) {
      if(!isDefined(level.struct_class_names["script_linkname"][var1.script_linkname])) {
        level.struct_class_names["script_linkname"][var1.script_linkname] = [];
      }

      var2 = level.struct_class_names["script_linkname"][var1.script_linkname].size;
      level.struct_class_names["script_linkname"][var1.script_linkname][var2] = var1;
    }
  }

  store_linked_smartobjects();
}

function deletestructarray(var0, var1, var2) {
  var3 = getStructArray(var0, var1);
  deletestructarray_ref(var3, var2);
}

function deletestruct_ref(var0) {
  if(!isDefined(var0)) {
    return;
  }

  var1 = var0.script_linkname;

  if(isDefined(var1) && isDefined(level.struct_class_names["script_linkname"]) && isDefined(level.struct_class_names["script_linkname"][var1])) {
    foreach(var4, var3 in level.struct_class_names["script_linkname"][var1]) {
      if(isDefined(var3) && var0 == var3) {
        level.struct_class_names["script_linkname"][var1][var4] = undefined;
      }
    }

    if(level.struct_class_names["script_linkname"][var1].size == 0) {
      level.struct_class_names["script_linkname"][var1] = undefined;
    }
  }

  var1 = var0.script_noteworthy;

  if(isDefined(var1) && isDefined(level.struct_class_names["script_noteworthy"]) && isDefined(level.struct_class_names["script_noteworthy"][var1])) {
    foreach(var4, var3 in level.struct_class_names["script_noteworthy"][var1]) {
      if(isDefined(var3) && var0 == var3) {
        level.struct_class_names["script_noteworthy"][var1][var4] = undefined;
      }
    }

    if(level.struct_class_names["script_noteworthy"][var1].size == 0) {
      level.struct_class_names["script_noteworthy"][var1] = undefined;
    }
  }

  var1 = var0.target;

  if(isDefined(var1) && isDefined(level.struct_class_names["target"]) && isDefined(level.struct_class_names["target"][var1])) {
    foreach(var4, var3 in level.struct_class_names["target"][var1]) {
      if(isDefined(var3) && var0 == var3) {
        level.struct_class_names["target"][var1][var4] = undefined;
      }
    }

    if(level.struct_class_names["target"][var1].size == 0) {
      level.struct_class_names["target"][var1] = undefined;
    }
  }

  var1 = var0.targetname;

  if(isDefined(var1) && isDefined(level.struct_class_names["targetname"]) && isDefined(level.struct_class_names["targetname"][var1])) {
    foreach(var3 in level.struct_class_names["targetname"][var1]) {
      if(isDefined(var3) && var0 == var3) {
        level.struct_class_names["targetname"][var1][var4] = undefined;
      }
    }

    if(level.struct_class_names["targetname"][var1].size == 0) {
      level.struct_class_names["targetname"][var1] = undefined;
    }
  }

  if(isDefined(level.struct)) {
    if(level.struct.size > 5000) {
      var8 = 2500;
      var9 = 0;
      var10 = var8;
      ref_12c27(var0, var9, var10);

      while(var10 < level.struct.size) {
        var9 = var10 + 1;
        var10 = ter_op(var10 + var8 < level.struct.size, var10 + var8, level.struct.size);
        ref_12c27(var0, var9, var10);
      }

      return;
    }

    ref_12c27(var0, 0, level.struct.size);
    return;
  }
}

function ref_12c27(var0, var1, var2) {
  for(var3 = var1; var3 <= var2; var3++) {
    var4 = level.struct[var3];

    if(isDefined(var4) && var0 == var4) {
      level.struct[var3] = undefined;
    }
  }
}

function deletestructarray_ref(var0, var1) {
  if(!isDefined(var0) || !isarray(var0) || var0.size == 0) {
    return;
  }

  var1 = ter_op(isDefined(var1), var1, 0);
  var1 = ter_op(var1 > 0, var1, 0);
  jumpiffalse(var1 > 0) LOC_00000062;

  foreach(var3 in var0) {
    deletestruct_ref(var3);
    wait var1;
  }

  return;
}

function getstruct_delete(var0, var1) {
  var2 = getStruct(var0, var1);
  deletestruct_ref(var2);
  return var2;
}

function getstructarray_delete(var0, var1, var2) {
  var3 = getStructArray(var0, var1);
  deletestructarray_ref(var3, var2);
  return var3;
}

function getent_or_struct(var0, var1) {
  var2 = getEnt(var0, var1);

  if(isDefined(var2)) {
    return var2;
  }

  return getStruct(var0, var1);
}

function fileprint_start(var0) {}

function fileprint_map_start() {}

function fileprint_map_header(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
    return;
  }
}

function fileprint_map_keypairprint(var0, var1) {}

function fileprint_map_entity_start() {}

function fileprint_map_entity_end() {}

function fileprint_radiant_vec(var0) {}

function call_on_notify_no_endon_death(var0, var1, var2, var3) {
  GscBinSkip4(0x35, var0, var1, var2, var3);
}

function call_on_notify(var0, var1, var2, var3) {
  self endon("death");
  GscBinSkip4(0x35, var0, var1, var2, var3);
}

function call_on_notify_proc(var0, var1, var2, var3) {
  self waittill(var0);

  if(isDefined(var3)) {
    self builtin[[var1]](var2, var3);
    return;
  }

  if(isDefined(var2)) {
    self builtin[[var1]](var2);
    return;
  }

  self builtin[[var1]]();
}

function thread_on_notify_no_endon_death(var0, var1, var2, var3, var4) {
  GscBinSkip4(0x35, var0, var1, var2, var3, var4);
}

function thread_on_notify(var0, var1, var2, var3, var4, var5, var6) {
  self endon("death");

  if(isDefined(var5) && isDefined(var6)) {
    if(!isarray(var5)) {
      var5 = [var5];
    }

    if(!isarray(var6)) {
      var6 = [var6];
    }

    foreach(var8 in var5) {
      foreach(var10 in var6) {
        var8 endon(var10);
      }
    }
  }

  GscBinSkip4(0x35, var0, var1, var2, var3, var4);
}

function thread_on_notify_proc(var0, var1, var2, var3, var4) {
  self waittill(var0);

  if(!isDefined(var4)) {
    var4 = self;
  }

  if(isDefined(var3)) {
    var4 thread[[var1]](var2, var3);
    return;
  }

  if(isDefined(var2)) {
    var4 thread[[var1]](var2);
    return;
  }

  var4 thread[[var1]]();
}

function delaycall(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
  thread delaycall_proc(var1, var0, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
}

function delaycallwatchself(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
  thread delaycall_proc_watchself(var1, var0, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
}

function delaycall_proc_watchself(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
  self endon("disconnect");
  self endon("death");
  delaycall_proc(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
}

function delaycall_proc(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
  if(scripts\common\utility::issp()) {
    self endon("death");
    self endon("stop_delay_call");
  }

  wait var1;

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(var13)) {
    self builtin[[var0]](var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
    return;
  }

  if(isDefined(var12)) {
    self builtin[[var0]](var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12);
    return;
  }

  if(isDefined(var11)) {
    self builtin[[var0]](var2, var3, var4, var5, var6, var7, var8, var9, var10, var11);
    return;
  }

  if(isDefined(var10)) {
    self builtin[[var0]](var2, var3, var4, var5, var6, var7, var8, var9, var10);
    return;
  }

  if(isDefined(var9)) {
    self builtin[[var0]](var2, var3, var4, var5, var6, var7, var8, var9);
    return;
  }

  if(isDefined(var8)) {
    self builtin[[var0]](var2, var3, var4, var5, var6, var7, var8);
    return;
  }

  if(isDefined(var7)) {
    self builtin[[var0]](var2, var3, var4, var5, var6, var7);
    return;
  }

  if(isDefined(var6)) {
    self builtin[[var0]](var2, var3, var4, var5, var6);
    return;
  }

  if(isDefined(var5)) {
    self builtin[[var0]](var2, var3, var4, var5);
    return;
  }

  if(isDefined(var4)) {
    self builtin[[var0]](var2, var3, var4);
    return;
  }

  if(isDefined(var3)) {
    self builtin[[var0]](var2, var3);
    return;
  }

  if(isDefined(var2)) {
    self builtin[[var0]](var2);
    return;
  }

  self builtin[[var0]]();
}

function string_starts_with(var0, var1) {
  if(var0.size < var1.size) {
    return false;
  }

  var2 = getsubstr(var0, 0, var1.size);

  if(var2 == var1) {
    return true;
  }

  return false;
}

function plot_points(var0, var1, var2, var3, var4) {
  var5 = var0[0];

  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(!isDefined(var3)) {
    var3 = 1;
  }

  if(!isDefined(var4)) {
    var4 = 0.05;
  }

  for(var6 = 1; var6 < var0.size; var6++) {
    thread draw_line_for_time(var5, var0[var6], var1, var2, var3, var4);
    var5 = var0[var6];
  }
}

function draw_line_for_time(var0, var1, var2, var3, var4, var5) {
  var5 = gettime() + var5 * 1000;

  while(gettime() < var5) {
    wait 0.05;
  }
}

function draw_circle(var0, var1, var2, var3, var4, var5, var6) {
  var7 = 16;

  if(isDefined(var6)) {
    var7 = var6;
  }

  var8 = 360 / var7;
  var9 = [];

  for(var10 = 0; var10 < var7; var10++) {
    var11 = var8 * var10;
    var12 = cos(var11) * var1;
    var13 = sin(var11) * var1;
    var14 = var0[0] + var12;
    var15 = var0[1] + var13;
    var16 = var0[2];
    var9 = (var14, var15, var16);
  }

  for(var10 = 0; var10 < var9.size; var10++) {
    var17 = var9[var10];

    if(var10 + 1 >= var9.size) {
      var18 = var9[0];
      continue;
    }

    var18 = var9[var10 + 1];
  }
}

function array_add(var0, var1) {
  var0 = var1;
  return var0;
}

function array_add_safe(var0, var1) {
  if(!isDefined(var1)) {
    return var0;
  }

  if(!isDefined(var0)) {
    var0 = var1;
  } else {
    var0 = var1;
  }

  return var0;
}

function array_delete(var0) {
  foreach(var2 in var0) {
    if(isDefined(var2)) {
      var2 delete();
    }
  }
}

function array_insert(var0, var1, var2) {
  if(var2 == var0.size) {
    var3 = var0;
    GscBinSkip0(0x2e, var3.size, var1);
  }

  var3 = [];
  var4 = 0;

  for(var5 = 0; var5 < var1.size; var5++) {
    if(var5 == var3) {
      var3 = var2;
      var4 = 1;
    }

    var3 = var1[var5];
  }

  return var3;
}

function array_combine(var0, var1, var2, var3, var4) {
  var5 = [];

  if(isDefined(var0)) {
    foreach(var7 in var0) {
      var5 = var7;
    }
  }

  if(isDefined(var1)) {
    foreach(var7 in var1) {
      var5 = var7;
    }
  }

  if(isDefined(var2)) {
    foreach(var7 in var2) {
      var5 = var7;
    }
  }

  if(isDefined(var3)) {
    foreach(var7 in var3) {
      var5 = var7;
    }
  }

  if(isDefined(var4)) {
    foreach(var7 in var4) {
      var5 = var7;
    }
  }

  return var5;
}

function array_combine_multiple(var0) {
  var1 = [];

  foreach(var3 in var0) {
    foreach(var5 in var3) {
      var1 = var5;
    }
  }

  return var1;
}

function array_combine_unique(var0, var1) {
  var2 = [];

  foreach(var4 in var0) {
    var2 = var4;
  }

  foreach(var4 in var1) {
    if(array_contains(var2, var4)) {
      continue;
    }

    var2 = var4;
  }

  return var2;
}

function array_combine_unique_keys(var0, var1) {
  foreach(var3 in var1) {
    if(!isDefined(var0[var4])) {
      var0 = var3;
    }
  }

  return var0;
}

function array_combine_non_integer_indices(var0, var1) {
  var2 = [];

  foreach(var5, var4 in var0) {
    var2 = var4;
  }

  foreach(var4 in var1) {
    var2 = var4;
  }

  return var2;
}

function array_intersection(var0, var1) {
  var2 = [];

  foreach(var4 in var0) {
    if(array_contains(var1, var4)) {
      var2 = var4;
    }
  }

  return var2;
}

function array_has_intersection(var0, var1) {
  foreach(var3 in var0) {
    if(array_contains(var1, var3)) {
      return true;
    }
  }

  return false;
}

function array_difference(var0, var1) {
  var2 = [];

  foreach(var4 in var0) {
    if(!array_contains(var1, var4)) {
      var2 = var4;
    }
  }

  return var2;
}

function can_be_shot_again(var0) {
  var1 = [];

  foreach(var3 in var0) {
    var1 = var3;
  }

  return var1;
}

function array_randomize(var0) {
  for(var1 = 0; var1 < var0.size - 1; var1++) {
    var2 = randomintrange(var1, var0.size);
    var3 = var0[var1];
    var0 = var0[var2];
    var0 = var3;
  }

  return var0;
}

function array_randomize_objects(var0) {
  var1 = [];

  for(var2 = var0; var2.size > 0; var2 = var4) {
    var3 = randomintrange(0, var2.size);
    var4 = [];
    var5 = 0;

    foreach(var8, var7 in var2) {
      if(var5 == var3) {
        var1 = var7;
      } else {
        var4 = var7;
      }

      var5++;
    }
  }

  return var1;
}

function array_reverse(var0) {
  var1 = [];

  for(var2 = var0.size - 1; var2 >= 0; var2--) {
    var1 = var0[var2];
  }

  return var1;
}

function array_slice(var0, var1, var2) {
  if(var0.size <= 0) {
    return [];
  }

  if(!isDefined(var2) || var2 > var0.size) {
    var2 = var0.size;
  }

  if(var1 == 0 && var2 == var0.size) {
    return var0;
  }

  var3 = [];

  for(var4 = var1; var4 < var2; var4++) {
    var3 = var0[var4];
  }

  return var3;
}

function array_contains(var0, var1) {
  if(var0.size <= 0) {
    return false;
  }

  foreach(var3 in var0) {
    if(var3 == var1) {
      return true;
    }
  }

  return false;
}

function array_contains_key(var0, var1) {
  foreach(var3 in var0) {
    if(var4 == var1) {
      return true;
    }
  }

  return false;
}

function array_find(var0, var1) {
  foreach(var3 in var0) {
    if(var3 == var1) {
      return var4;
    }
  }

  return undefined;
}

function array_remove(var0, var1) {
  var2 = [];

  foreach(var4 in var0) {
    if(var4 != var1) {
      var2 = var4;
    }
  }

  return var2;
}

function array_remove_array(var0, var1) {
  foreach(var3 in var1) {
    var0 = array_remove(var0, var3);
  }

  return var0;
}

function array_remove_index(var0, var1, var2) {
  var3 = [];

  foreach(var5 in var0) {
    if(var7 == var1) {
      continue;
    }

    if(istrue(var2)) {
      var6 = var7;
    } else {
      var6 = var3.size;
    }

    var3 = var5;
  }

  return var3;
}

function can_path_to_target(var0, var1) {
  if(var1 < 0 || var1 >= var0.size) {
    return var0;
  }

  for(var2 = var1; var2 < var0.size - 1; var2++) {
    var0 = var0[var2 + 1];
  }

  var0[var0.size - 1] = undefined;
  return var0;
}

function array_removeundefined(var0) {
  var1 = [];

  foreach(var3 in var0) {
    if(!isDefined(var3)) {
      continue;
    }

    var1 = var3;
  }

  return var1;
}

function array_removedead(var0) {
  var1 = [];

  foreach(var3 in var0) {
    if(!isalive(var3)) {
      continue;
    }

    var1 = var3;
  }

  return var1;
}

function array_remove_key(var0, var1) {
  var2 = [];

  foreach(var4 in var0) {
    if(var1 == var5) {
      continue;
    }

    var2 = var4;
  }

  return var2;
}

function array_remove_duplicates(var0) {
  var1 = [];

  foreach(var3 in var0) {
    if(!isDefined(var3)) {
      continue;
    }

    var4 = 1;

    foreach(var6 in var1) {
      if(var3 == var6) {
        var4 = 0;
        break;
      }
    }

    if(var4) {
      var1 = var3;
    }
  }

  return var1;
}

function array_get_first_item(var0) {
  foreach(var2 in var0) {
    return var2;
  }

  var2 = undefined;
  return undefined;
}

function array_levelthread(var0, var1, var2, var3, var4) {
  if(isDefined(var4)) {
    var5 = var0;
    var7 = getfirstarraykey(var5);

    if(isDefined(var7)) {
      var6 = var5[var7];
      GscBinSkip1(0x74, var1, var6, var2, var3, var4);
    }

    var5 = undefined;
    var7 = undefined;
    return;
  }

  if(isDefined(var6)) {
    var8 = var3;
    var9 = getfirstarraykey(var8);

    if(isDefined(var9)) {
      var6 = var8[var9];
      GscBinSkip1(0x74, var4, var6, var5, var6);
    }

    var8 = undefined;
    var9 = undefined;
    return;
  }

  if(isDefined(var8)) {
    var10 = var6;
    var11 = getfirstarraykey(var10);

    if(isDefined(var11)) {
      var6 = var10[var11];
      GscBinSkip1(0x74, var7, var6, var8);
    }

    var10 = undefined;
    var11 = undefined;
    return;
  }

  var12 = var6;
  var13 = getfirstarraykey(var12);

  if(isDefined(var13)) {
    var6 = var12[var13];
    GscBinSkip1(0x74, var9, var6);
  }

  var12 = undefined;
  var13 = undefined;
}

function array_levelcall(var0, var1, var2, var3, var4) {
  if(isDefined(var4)) {
    foreach(var6 in var0) {
      builtin[[var1]](var6, var2, var3, var4);
    }

    return;
  }

  if(isDefined(var6)) {
    foreach(var6 in var3) {
      builtin[[var4]](var6, var5, var6);
    }

    return;
  }

  if(isDefined(var8)) {
    foreach(var6 in var6) {
      builtin[[var7]](var6, var8);
    }

    return;
  }

  foreach(var6 in var6) {
    builtin[[var9]](var6);
  }
}

function array_sort_with_func(var0, var1) {
  for(var2 = 1; var2 < var0.size; var2++) {
    var3 = var0[var2];

    for(var4 = var2 - 1; var4 >= 0 && ![[var1]](var0[var4], var3); var4--) {
      var0 = var0[var4];
    }

    var0 = var3;
  }

  return var0;
}

function array_average(var0) {
  return array_sum(var0) / var0.size;
}

function array_sum(var0) {
  var1 = 0;

  foreach(var3 in var0) {
    var1 += var3;
  }

  return var1;
}

function array_divide(var0, var1) {
  for(var2 = 0; var2 < var0.size; var2++) {
    var0 = var0[var2] / var1;
  }

  return var0;
}

function random(var0) {
  var1 = [];

  foreach(var3 in var0) {
    var1 = var3;
  }

  if(!var1.size) {
    return undefined;
  }

  return var1[randomint(var1.size)];
}

function random_weight_sorted(var0) {
  var1 = [];

  foreach(var3 in var0) {
    var1 = var3;
  }

  if(!var1.size) {
    return undefined;
  }

  var5 = randomint(var1.size * var1.size);
  return var1[var1.size - 1 - int(sqrt(var5))];
}

function alphabetize(var0) {
  if(var0.size <= 1) {
    return var0;
  }

  var1 = 0;

  for(var2 = var0.size - 1; var2 >= 1; var2--) {
    var3 = var0[var2];
    var4 = var2;

    for(var5 = 0; var5 < var2; var5++) {
      var6 = var0[var5];

      if(stricmp(var6, var3) > 0) {
        var3 = var6;
        var4 = var5;
      }
    }

    if(var4 != var2) {
      var0 = var0[var2];
      var0 = var3;
    }
  }

  return var0;
}

function array_thread_amortized(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  if(!isDefined(var3)) {
    foreach(var14, var13 in var0) {
      var13 thread[[var1]]();
      wait var2;
    }

    return;
  }

  if(!isDefined(var7)) {
    foreach(var16, var13 in var3) {
      var13 thread[[var4]](var6);
      wait var5;
    }

    return;
  }

  if(!isDefined(var11)) {
    foreach(var18, var13 in var6) {
      var13 thread[[var7]](var9, var10);
      wait var8;
    }

    return;
  }

  if(!isDefined(var15)) {
    foreach(var20, var13 in var9) {
      var13 thread[[var10]](var12, var13, var14);
      wait var11;
    }

    return;
  }

  if(!isDefined(var13)) {
    foreach(var22, var13 in var12) {
      var13 thread[[var13]](var15, var13, var16, var17);
      wait var14;
    }

    return;
  }

  if(!isDefined(var20)) {
    foreach(var24, var13 in var15) {
      var13 thread[[var13]](var17, var13, var18, var19, var13);
      wait var16;
    }

    return;
  }

  if(!isDefined(var23)) {
    foreach(var26, var13 in var17) {
      var13 thread[[var13]](var19, var13, var20, var21, var13, var22);
      wait var18;
    }

    return;
  }

  if(!isDefined(var13)) {
    foreach(var28, var13 in var19) {
      var13 thread[[var13]](var21, var13, var22, var23, var13, var24, var25);
      wait var20;
    }

    return;
  }

  if(!isDefined(var28)) {
    foreach(var13 in var21) {
      var13 thread[[var13]](var23, var13, var24, var25, var13, var26, var27, var13);
      wait var22;
    }

    return;
  }

  foreach(var13 in var23) {
    var13 thread[[var13]](var25, var13, var26, var27, var13, var28, var29, var13, var30);
    wait var24;
  }
}

function array_thread(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  if(isDefined(var10)) {
    foreach(var13, var12 in var0) {
      var12 thread[[var1]](var2, var3, var4, var5, var6, var7, var8, var9, var10);
    }

    return;
  }

  if(isDefined(var12)) {
    foreach(var15, var12 in var3) {
      var12 thread[[var4]](var5, var6, var7, var8, var9, var10, var11, var12);
    }

    return;
  }

  if(isDefined(var14)) {
    foreach(var17, var12 in var6) {
      var12 thread[[var7]](var8, var9, var10, var11, var12, var13, var14);
    }

    return;
  }

  if(isDefined(var15)) {
    foreach(var19, var12 in var9) {
      var12 thread[[var10]](var11, var12, var13, var14, var12, var15);
    }

    return;
  }

  if(isDefined(var12)) {
    foreach(var12 in var12) {
      var12 thread[[var13]](var14, var12, var15, var16, var12);
    }

    return;
  }

  if(isDefined(var18)) {
    foreach(var12 in var12) {
      var12 thread[[var15]](var16, var12, var17, var18);
    }

    return;
  }

  if(isDefined(var19)) {
    foreach(var12 in var12) {
      var12 thread[[var17]](var18, var12, var19);
    }

    return;
  }

  if(isDefined(var12)) {
    foreach(var12 in var12) {
      var12 thread[[var19]](var20, var12);
    }

    return;
  }

  if(isDefined(var22)) {
    foreach(var12 in var12) {
      var12 thread[[var21]](var22);
    }

    return;
  }

  foreach(var12 in var12) {
    var12 thread[[var23]]();
  }
}

function array_call(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isDefined(var9)) {
    foreach(var12, var11 in var0) {
      var11 builtin[[var1]](var2, var3, var4, var5, var6, var7, var8, var9);
    }

    return;
  }

  if(isDefined(var11)) {
    foreach(var14, var11 in var3) {
      var11 builtin[[var4]](var5, var6, var7, var8, var9, var10, var11);
    }

    return;
  }

  if(isDefined(var13)) {
    foreach(var16, var11 in var6) {
      var11 builtin[[var7]](var8, var9, var10, var11, var12, var13);
    }

    return;
  }

  if(isDefined(var14)) {
    foreach(var18, var11 in var9) {
      var11 builtin[[var10]](var11, var12, var13, var11, var14);
    }

    return;
  }

  if(isDefined(var11)) {
    foreach(var11 in var12) {
      var11 builtin[[var13]](var11, var14, var15, var11);
    }

    return;
  }

  if(isDefined(var17)) {
    foreach(var11 in var14) {
      var11 builtin[[var15]](var11, var16, var17);
    }

    return;
  }

  if(isDefined(var18)) {
    foreach(var11 in var16) {
      var11 builtin[[var17]](var11, var18);
    }

    return;
  }

  if(isDefined(var11)) {
    foreach(var11 in var18) {
      var11 builtin[[var19]](var11);
    }

    return;
  }

  foreach(var11 in var20) {
    var11 builtin[[var21]]();
  }
}

function flat_angle(var0) {
  var1 = (0, var0[1], 0);
  return var1;
}

function flat_origin(var0) {
  var1 = (var0[0], var0[1], 0);
  return var1;
}

function flatten_vector(var0, var1) {
  if(!isDefined(var1)) {
    var1 = (0, 0, 1);
  }

  var2 = vectorNormalize(var0 - vectordot(var1, var0) * var1);
  return var2;
}

function draw_arrow_time(var0, var1, var2, var3) {
  level endon("newpath");
  var4 = [];
  var5 = vectortoangles(var0 - var1);
  var6 = anglestoright(var5);
  var7 = anglesToForward(var5);
  var8 = anglestoup(var5);
  var9 = distance(var0, var1);
  var10 = [];
  var11 = 0.1;
  var10 = var0;
  var10 = var0 + var6 * var9 * var11 + var7 * var9 * -0.1;
  var10 = var1;
  var10 = var0 + var6 * var9 * -1 * var11 + var7 * var9 * -0.1;
  var10 = var0;
  var10 = var0 + var8 * var9 * var11 + var7 * var9 * -0.1;
  var10 = var1;
  var10 = var0 + var8 * var9 * -1 * var11 + var7 * var9 * -0.1;
  var10 = var0;
  var12 = var2[0];
  var13 = var2[1];
  var14 = var2[2];
  plot_points(var10, var12, var13, var14, var3);
}

function draw_arrow(var0, var1, var2) {
  level endon("newpath");
  var3 = [];
  var4 = vectortoangles(var0 - var1);
  var5 = anglestoright(var4);
  var6 = anglesToForward(var4);
  var7 = distance(var0, var1);
  var8 = [];
  var9 = 0.05;
  var8 = var0;
  var8 = var0 + var5 * var7 * var9 + var6 * var7 * -0.2;
  var8 = var1;
  var8 = var0 + var5 * var7 * -1 * var9 + var6 * var7 * -0.2;

  for(var10 = 0; var10 < 4; var10++) {
    var11 = var10 + 1;

    if(var11 >= 4) {
      var11 = 0;
    }
  }
}

function draw_capsule(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(var3)) {
    var3 = (0, 0, 0);
  }

  if(!isDefined(var5)) {
    var5 = 0;
  }

  if(!isDefined(var6)) {
    var6 = 1;
  }

  var7 = anglesToForward(var3);
  var8 = anglestoright(var3);
  var9 = anglestoup(var3);
  var10 = var0 + var9 * var1;
  var11 = var0 + var9 * var2;
  var11 -= var9 * var1;
  var12 = var10 + var7 * var1;
  var13 = var11 + var7 * var1;
  var14 = var10 - var7 * var1;
  var15 = var11 - var7 * var1;
  var16 = var10 + var8 * var1;
  var17 = var11 + var8 * var1;
  var18 = var10 - var8 * var1;
  var19 = var11 - var8 * var1;
}

function draw_character_capsule(var0, var1, var2) {
  var3 = self physics_getcharactercollisioncapsule();
  draw_capsule(self getorigin(), var3["radius"], var3["half_height"] * 2, self.angles, var0, var1, var2);
}

function draw_player_capsule(var0, var1, var2) {
  var3 = self physics_getcharactercollisioncapsule();
  draw_capsule(self getorigin(), var3["radius"], var3["half_height"] * 2, self getplayerangles(), var0, var1, var2);
}

function draw_ent_bone_forever(var0, var1) {
  self endon("stop_drawing_axis");
  self endon("death");

  for(;;) {
    var2 = self gettagorigin(var0);
    var3 = self gettagangles(var0);
    draw_angles(var3, var2, var1);
    waitframe();
  }
}

function draw_ent_axis_forever(var0, var1) {
  self endon("stop_drawing_axis");
  self endon("death");

  for(;;) {
    draw_ent_axis(var0, undefined, var1);
    waitframe();
  }
}

function draw_tag_axis_forever(var0, var1, var2) {
  self endon("stop_drawing_axis");
  self endon("death");

  for(;;) {
    draw_tag_axis(var0, var1, undefined, var2);
    waitframe();
  }
}

function draw_ent_axis(var0, var1, var2) {
  waittillframeend();

  if(isDefined(self.angles)) {
    var3 = self.angles;
  } else {
    var3 = (0, 0, 0);
  }

  draw_angles(var3, self.origin, var1, var2, var3);
}

function draw_tag_axis(var0, var1, var2, var3) {
  waittillframeend();
  var4 = self gettagangles(var0);
  var5 = self gettagorigin(var0);
  draw_angles(var4, var5, var1, var2, var3);
}

function draw_angles(var0, var1, var2, var3, var4) {
  waittillframeend();
  var5 = anglesToForward(var0);
  var6 = anglestoright(var0);
  var7 = anglestoup(var0);

  if(!isDefined(var2)) {
    var2 = (1, 0, 1);
  }

  if(!isDefined(var3)) {
    var3 = 1;
  }

  if(!isDefined(var4)) {
    var4 = 10;
  }
}

function draw_entity_bounds(var0, var1, var2, var3, var4) {
  if(!isDefined(var2)) {
    var2 = (0, 1, 0);
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(!isDefined(var4)) {
    var4 = 0.05;
  }

  if(var3) {
    var5 = int(var4 / 0.05);
  } else {
    var5 = int(var2 / 0.05);
  }

  var6 = [];
  var7 = [];
  var8 = gettime();
  var9 = var8 + var2 * 1000;

  while(var8 < var9 && isDefined(var1)) {
    var6 = var1 getpointinbounds(1, 1, 1);
    var6 = var1 getpointinbounds(1, 1, -1);
    var6 = var1 getpointinbounds(-1, 1, -1);
    var6 = var1 getpointinbounds(-1, 1, 1);
    var7 = var1 getpointinbounds(1, -1, 1);
    var7 = var1 getpointinbounds(1, -1, -1);
    var7 = var1 getpointinbounds(-1, -1, -1);
    var7 = var1 getpointinbounds(-1, -1, 1);

    for(var10 = 0; var10 < 4; var10++) {
      var11 = var10 + 1;

      if(var11 == 4) {
        var11 = 0;
      }
    }

    if(!var4) {
      return;
    }

    wait var5;
    var8 = gettime();
  }
}

function getfx(var0) {
  return level._effect[var0];
}

function fxexists(var0) {
  return isDefined(level._effect[var0]);
}

function playerunlimitedammothread() {}

function spawn_tag_origin(var0, var1) {
  if(!isDefined(var1) && isDefined(self.angles)) {
    var1 = self.angles;
  }

  if(!isDefined(var0) && isDefined(self.origin)) {
    var0 = self.origin;
  } else if(!isDefined(var0)) {
    var0 = (0, 0, 0);
  }

  var2 = spawn("script_model", var0);
  var2 setModel("tag_origin");
  var2 hide();

  if(isDefined(var1)) {
    var2.angles = var1;
  }

  return var2;
}

function waittill_notify_or_timeout(var0, var1) {
  self endon(var0);
  wait var1;
}

function waittill_notify_or_timeout_return(var0, var1) {
  var2 = spawnStruct();
  thread waittill_notify_proc(var2, var0);
  thread waittill_timeout_proc(var2, var1);
  var2 waittill("waittill_proc", var3);
  return var3;
}

function waittill_notify_proc(var0, var1) {
  var0 endon("waittill_proc");
  self waittill(var1);
  var0 notify("waittill_proc", var1);
}

function waittill_timeout_proc(var0, var1) {
  var0 endon("waittill_proc");
  wait var1;
  var0 notify("waittill_proc", "timeout");
}

function waittill_notify_and_time(var0, var1) {
  var2 = gettime();
  self waittill(var0);
  var3 = var2 + var1 * 1000;
  var4 = var3 - var2;

  if(var4 > 0) {
    var5 = var4 / 1000;
    wait var5;
    return;
  }
}

function array_wait(var0, var1, var2) {
  var3 = spawnStruct();

  if(istrue(var2)) {
    thread array_wait_timeout_proc(var3, var2);
    var3 endon("array_wait_timeout");
  }

  foreach(var5 in var0) {
    thread array_wait_proc(var3, var5, var1);
  }

  for(var7 = 0; var7 < var0.size; var7++) {
    var3 waittill("array_wait_proc");
  }

  var3 notify("array_wait_success");
}

function array_wait_proc(var0, var1, var2) {
  var0 endon("array_wait_success");
  ref_143a5(var1, var2, "death");
  var0 notify("array_wait_proc");
}

function array_wait_timeout_proc(var0, var1) {
  var0 endon("array_wait_success");
  wait var1;
  var0 notify("array_wait_timeout");
}

function array_any_wait(var0, var1) {
  var2 = spawnStruct();

  foreach(var4 in var0) {
    thread array_any_wait_proc(var2, var4, var1);
  }

  var2 waittill("array_wait_proc", var6);
  return var6;
}

function array_any_wait_timeout(var0, var1, var2) {
  var3 = spawnStruct();
  thread array_any_wait_timeout_proc(var3, var2);

  foreach(var5 in var0) {
    thread array_any_wait_proc(var3, var5, var1);
  }

  var3 waittill("array_wait_proc", var7);
  return var7;
}

function array_any_wait_proc(var0, var1, var2) {
  var3 = waittill_any_return_no_endon_death(var1, var2, "death");
  var0 notify("array_wait_proc", var3);
}

function array_any_wait_timeout_proc(var0, var1) {
  var0 endon("array_wait_proc");
  wait var1;
  var0 notify("array_wait_proc", "timeout");
}

function array_any_wait_return(var0, var1) {
  var2 = spawnStruct();

  foreach(var4 in var0) {
    thread array_any_wait_return_proc(var2, var4, var1);
  }

  var2 waittill("array_wait_proc", var4);
  return var4;
}

function array_any_wait_return_proc(var0, var1, var2) {
  var3 = ref_143ad(var1, var2, "death");
  var0 notify("array_wait_proc", var1);
}

function fileprint_launcher_start_file()
{
  level.fileprintlauncher_linecount = 0;
  level. fileprint_launcher = 1;
  fileprint_launcher( "GAMEPRINTSTARTFILE:" );
}

function fileprint_launcher( var0 )
{
  level.fileprintlauncher_linecount++;

  if(level.fileprintlauncher_linecount > 200) {
    wait 0.05;
    level.fileprintlauncher_linecount = 0;
  }
}

function fileprint_launcher_end_file( var0, var1 )
{
  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(var1) {
    fileprint_launcher( "GAMEPRINTENDFILE:GAMEPRINTP4ENABLED:" + var0 );
  } else {
    fileprint_launcher( "GAMEPRINTENDFILE:" + var0 );
  }

  var2 = gettime() + 4000;

  while(getdvarint("LAUNCHER_PRINT_SUCCESS") == 0 && getDvar("LAUNCHER_PRINT_FAIL") == "0" && gettime() < var2) {
    wait 0.05;
  }

  if(!(gettime() < var2)) {
    iprintlnbold("LAUNCHER_PRINT_FAIL:( TIMEOUT ): launcherconflict? restart launcher and try again? ");
    level. fileprint_launcher = undefined;
    return false;
  }

  var3 = getDvar("LAUNCHER_PRINT_FAIL");

  if(var3 != "0") {
    iprintlnbold("LAUNCHER_PRINT_FAIL:( " + var3 + " ): launcherconflict? restart launcher and try again? ");
    level. fileprint_launcher = undefined;
    return false;
  }

  iprintlnbold("Launcher write to file successful!");
  level. fileprint_launcher = undefined;
  return true;
}

function launcher_write_clipboard(var0) {
  level.fileprintlauncher_linecount = 0;
  fileprint_launcher( "LAUNCHER_CLIP:" + var0 );
}

function activate_individual_exploder() {
  scripts\common\exploder::activate_individual_exploder_proc();
}

function get_target_ent(var0) {
  if(!isDefined(var0)) {
    var0 = self.target;
  }

  var1 = getEnt(var0, "targetname");

  if(isDefined(var1)) {
    return var1;
  }

  if(scripts\common\utility::issp()) {
    var1 = builtin[[level.getnodefunction]](var0, "targetname");

    if(isDefined(var1)) {
      return var1;
    }

    var1 = builtin[[level.func["getspawner"]]](var0, "targetname");

    if(isDefined(var1)) {
      return var1;
    }
  }

  var1 = getStruct(var0, "targetname");

  if(isDefined(var1)) {
    return var1;
  }

  var1 = getvehiclenode(var0, "targetname");

  if(isDefined(var1)) {
    return var1;
  }
}

function get_links() {
  return strtok(self.script_linkto, " ");
}

function get_linked_ents() {
  var0 = [];

  if(isDefined(self.script_linkto)) {
    var1 = get_links();

    foreach(var3 in var1) {
      var4 = getEntArray(var3, "script_linkname");

      if(var4.size > 0) {
        var0 = array_combine(var0, var4);
      }
    }
  }

  return var0;
}

function get_linked_ent() {
  var0 = get_linked_ents();
  return var0[0];
}

function get_linked_nodes() {
  var0 = [];

  if(isDefined(self.script_linkto)) {
    var1 = get_links();

    foreach(var3 in var1) {
      var4 = getnodearray(var3, "script_linkname");

      if(var4.size > 0) {
        var0 = array_combine(var0, var4);
      }
    }
  }

  return var0;
}

function do_earthquake(var0, var1) {
  var2 = level.earthquake[var0];
  earthquake(var2["magnitude"], var2["duration"], var1, var2["radius"]);
}

function play_loopsound_in_space(var0, var1) {
  var2 = spawn("script_origin", (0, 0, 0));

  if(!isDefined(var1)) {
    var1 = self.origin;
  }

  var2.origin = var1;
  var2 playLoopSound(var0);
  return var2;
}

function play_sound_in_space_with_angles(var0, var1, var2, var3, var4) {
  var5 = spawn("script_origin", (0, 0, 1));

  if(!isDefined(var1)) {
    var1 = self.origin;
  }

  var5.origin = var1;
  var5.angles = var2;

  if(isDefined(var4)) {
    var5 linkTo(var4);
  }

  if(scripts\common\utility::issp()) {
    var5 playSound(var0, "sounddone");
    var5 waittill("sounddone");
  } else {
    var5 playSound(var0);
  }

  var5 delete();
}

function play_sound_in_space(var0, var1, var2, var3) {
  play_sound_in_space_with_angles(var0, var1, (0, 0, 0), var2, var3);
}

function loop_fx_sound(var0, var1, var2, var3, var4) {
  loop_fx_sound_with_angles(var0, var1, (0, 0, 0), var2, var3, var4);
}

function loop_fx_sound_with_angles(var0, var1, var2, var3, var4, var5, var6) {
  if(istrue(var3)) {
    if(!isDefined(level.first_frame) || level.first_frame == 1) {
      spawnloopingsound(var0, var1, var2);
      return;
    }

    return;
  }

  if(level.createfx_enabled && isDefined(var5.loopsound_ent)) {
    var7 = var5.loopsound_ent;
  } else {
    var7 = spawn("script_origin", (0, 0, 0));
  }

  if(isDefined(var5)) {
    thread loop_sound_delete(var5, var7);
    self endon(var5);
  }

  var7.origin = var2;
  var7.angles = var3;
  var7 playLoopSound(var1);

  if(level.createfx_enabled) {
    var6.loopsound_ent = var7;
    return;
  }

  var7 willneverchange();
}

function loop_fx_sound_interval(var0, var1, var2, var3, var4, var5) {
  loop_fx_sound_interval_with_angles(var0, var1, (0, 0, 0), var2, var3, var4, var5);
}

function loop_fx_sound_interval_with_angles(var0, var1, var2, var3, var4, var5, var6) {
  self.origin = var1;
  self.angles = var2;

  if(isDefined(var3)) {
    self endon(var3);
  }

  if(var5 >= var6) {
    for(;;) {
      wait 0.05;
    }
  }

  if(!soundexists(var0)) {
    for(;;) {
      wait 0.05;
    }
  }

  for(;;) {
    wait randomfloatrange(var5, var6);
    lock("createfx_looper");
    thread play_sound_in_space_with_angles(var0, self.origin, self.angles, undefined);
    unlock("createfx_looper");
  }
}

function loop_sound_delete(var0, var1) {
  var1 endon("death");
  self waittill(var0);
  var1 delete();
}

function createloopeffect(var0) {
  var1 = scripts\common\createfx::createeffect("loopfx", var0);
  var1.v["delay"] = scripts\common\createfx::getloopeffectdelaydefault();
  return var1;
}

function createoneshoteffect(var0) {
  var1 = scripts\common\createfx::createeffect("oneshotfx", var0);
  var1.v["delay"] = scripts\common\createfx::getoneshoteffectdelaydefault();
  return var1;
}

function createexploder(var0, var1) {
  var2 = scripts\common\createfx::createeffect("exploder", var0, var1);
  var2.v["delay"] = scripts\common\createfx::getexploderdelaydefault();
  var2.v["exploder_type"] = "normal";
  return var2;
}

function play_loop_sound_on_entity(var0, var1) {
  var2 = spawn("script_origin", (0, 0, 0));
  var2 endon("death");
  thread delete_on_death(var2);

  if(isDefined(var1)) {
    var2.origin = self.origin + var1;
    var2.angles = self.angles;
    var2 linkTo(self);
  } else {
    var2.origin = self.origin;
    var2.angles = self.angles;
    var2 linkTo(self);
  }

  var2 playLoopSound(var0);
  self waittill("stop sound" + var0);
  var2 stoploopsound(var0);
  var2 delete();
}

function stop_loop_sound_on_entity(var0) {
  self notify("stop sound" + var0);
}

function delete_on_death(var0) {
  var0 endon("death");
  self waittill("death");

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function delete_on_sounddone() {
  self waittill("sounddone");
  self delete();
}

function delete_on_notify(var0) {
  self waittill(var0);
  self delete();
}

function error(var0) {
  waitframe();
}

function exploder(var0, var1, var2) {
  [[level._fx.exploderfunction]](var0, var1, var2);
}

function delete_exploder(var0) {
  scripts\common\exploder::delete_exploder_proc(var0);
}

function hide_exploder_models(var0) {
  scripts\common\exploder::hide_exploder_models_proc(var0);
}

function show_exploder_models(var0) {
  scripts\common\exploder::show_exploder_models_proc(var0);
}

function stop_exploder(var0, var1) {
  scripts\common\exploder::stop_exploder_proc(var0, var1, 0);
}

function kill_exploder(var0, var1) {
  scripts\common\exploder::stop_exploder_proc(var0, var1, 1);
}

function get_exploder_array(var0) {
  return scripts\common\exploder::get_exploder_array_proc(var0);
}

function ter_op(var0, var1, var2) {
  if(var0) {
    return var1;
  }

  return var2;
}

function create_lock(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(!isDefined(level.lock)) {
    level.lock = [];
  }

  var2 = spawnStruct();
  var2.max_count = var1;
  var2.count = 0;
  level.lock[var0] = var2;
}

function lock(var0) {
  var1 = level.lock[var0];

  while(var1.count >= var1.max_count) {
    var1 waittill("unlocked");
  }

  var1.count++;
}

function unlock(var0) {
  thread unlock_thread(var0);
}

function unlock_thread(var0) {
  wait 0.05;
  var1 = level.lock[var0];
  var1.count--;
  var1 notify("unlocked");
}

function unlock_wait(var0) {
  thread unlock_thread(var0);
  wait 0.05;
}

function is_player_gamepad_enabled() {
  var0 = self usinggamepad();

  if(isDefined(var0)) {
    return var0;
  }

  if(self ispcplayer()) {
    return 0;
  }

  return 1;
}

function distance_2d_squared(var0, var1) {
  return length2dsquared(var0 - var1);
}

function get_array_of_farthest(var0, var1, var2, var3, var4, var5) {
  var6 = get_array_of_closest(var0, var1, var2, var3, var4, var5);
  var6 = array_reverse(var6);
  return var6;
}

function get_array_of_closest(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var3)) {
    var3 = var1.size;
  }

  if(!isDefined(var2)) {
    var2 = [];
  }

  var6 = undefined;

  if(isDefined(var4)) {
    var6 = var4 * var4;
  }

  var7 = 0;

  if(isDefined(var5)) {
    var7 = var5 * var5;
  }

  if(var2.size == 0 && var3 >= var1.size && var7 == 0 && !isDefined(var6)) {
    return sortbydistance(var1, var0);
  }

  var8 = [];

  foreach(var10 in var1) {
    var11 = 0;

    foreach(var13 in var2) {
      if(var10 == var13) {
        var11 = 1;
        break;
      }
    }

    if(var11) {
      continue;
    }

    var15 = distancesquared(var0, var10.origin);

    if(isDefined(var6) && var15 > var6) {
      continue;
    }

    if(var15 < var7) {
      continue;
    }

    var8 = var10;
  }

  var8 = sortbydistance(var8, var0);

  if(var3 >= var8.size) {
    return var8;
  }

  var17 = [];

  for(var18 = 0; var18 < var3; var18++) {
    var17 = var8[var18];
  }

  return var17;
}

function drop_to_ground(var0, var1, var2, var3, var4) {
  if(!isDefined(var1)) {
    var1 = 1500;
  }

  if(!isDefined(var2)) {
    var2 = -12000;
  }

  if(!isDefined(var4)) {
    var4 = scripts\engine\trace::create_solid_ai_contents(1);
  }

  if(isDefined(var3)) {
    return scripts\engine\trace::ray_trace(var0 + var1 * var3, var0 + var2 * var3, undefined, var4)["position"];
  }

  return scripts\engine\trace::ray_trace(var0 + (0, 0, var1), var0 + (0, 0, var2), undefined, var4)["position"];
}

function player_drop_to_ground(var0, var1, var2, var3, var4) {
  if(!isDefined(var2)) {
    var2 = 1500;
  }

  if(!isDefined(var3)) {
    var3 = -12000;
  }

  var5 = scripts\engine\trace::create_solid_ai_contents(1);

  if(isDefined(var4)) {
    return scripts\engine\trace::sphere_trace(var0 + var2 * var4, var0 + var3 * var4, var1, undefined, var5)["position"];
  }

  return scripts\engine\trace::sphere_trace(var0 + (0, 0, var2), var0 + (0, 0, var3), var1, undefined, var5)["position"];
}

function within_fov(var0, var1, var2, var3) {
  var4 = vectorNormalize(var2 - var0);
  var5 = anglesToForward(var1);
  var6 = vectordot(var5, var4);
  return var6 >= var3;
}

function ai_3d_sighting_model(var0) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["ai_3d_sighting_model"])) {
    return self[[level.bot_funcs["ai_3d_sighting_model"]]](var0);
  }
}

function getclosest(var0, var1, var2) {
  if(var1.size == 0) {
    return undefined;
  }

  var3 = sortbydistance(var1, var0)[0];

  if(isDefined(var2) && distancesquared(var0, var3.origin) > squared(var2)) {
    return undefined;
  }

  return var3;
}

function missile_settargetandflightmode(var0, var1, var2) {
  var2 = ter_op(isDefined(var2), var2, (0, 0, 0));
  self missile_settargetEnt(var0, var2);

  switch (var1) {
    case "direct":
      self missile_setflightmodedirect();
      break;
    case "top":
      self missile_setflightmodetop();
      break;
  }
}

function add_fx(var0, var1) {
  if(!isDefined(level._effect)) {
    level._effect = [];
  }

  level._effect[var0] = loadfx(var1);
}

function create_func_ref(var0, var1) {
  if(!isDefined(level.func)) {
    level.func = [];
  }

  level.func[var0] = var1;
}

function create_empty_func_ref(var0) {
  if(!isDefined(level.func)) {
    level.func = [];
  }

  if(!isDefined(level.func[var0])) {
    create_func_ref(var0, &empty_init_func);
    return;
  }
}

function func_ref_exist(var0) {
  return isDefined(level.func) && isDefined(level.func[var0]);
}

function add_init_script(var0, var1) {
  if(!isDefined(level.init_script)) {
    level.init_script = [];
  }

  if(isDefined(level.init_script[var0])) {
    return false;
  }

  level.init_script[var0] = var1;
  return true;
}

function add_frame_event(var0) {
  if(!isDefined(self.frame_events)) {
    self.frame_events = [var0];
    thread process_frame_events();
    return;
  }

  self.frame_events[self.frame_events.size] = var0;
}

function process_frame_events() {
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    foreach(var1 in self.frame_events) {
      self thread[[var1]]();
    }

    waitframe();
  }
}

function delaythread(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  thread delaythread_proc(var1, var0, var2, var3, var4, var5, var6, var7, var8);
}

function delaythread_proc(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  self endon("stop_delay_thread");

  if(isPlayer(self)) {
    self endon("death_or_disconnect");
  } else {
    self endon("death");
  }

  wait var1;

  if(isDefined(var8)) {
    GscBinSkip1(0x74, var0, var2, var3, var4, var5, var6, var7, var8);
  }

  if(isDefined(var7)) {
    GscBinSkip1(0x74, var0, var2, var3, var4, var5, var6, var7);
  }

  if(isDefined(var6)) {
    GscBinSkip1(0x74, var0, var2, var3, var4, var5, var6);
  }

  if(isDefined(var5)) {
    GscBinSkip1(0x74, var0, var2, var3, var4, var5);
  }

  if(isDefined(var4)) {
    GscBinSkip1(0x74, var0, var2, var3, var4);
  }

  if(isDefined(var3)) {
    GscBinSkip1(0x74, var0, var2, var3);
  }

  if(isDefined(var2)) {
    GscBinSkip1(0x74, var0, var2);
  }

  GscBinSkip1(0x74, var0);
}

function damagelocationisany(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  if(isDefined(self.damagelocation)) {
    if(!isDefined(var0)) {
      return 0;
    }

    if(self.damagelocation == var0) {
      return 1;
    }

    if(!isDefined(var1)) {
      return 0;
    }

    if(self.damagelocation == var1) {
      return 1;
    }

    if(!isDefined(var2)) {
      return 0;
    }

    if(self.damagelocation == var2) {
      return 1;
    }

    if(!isDefined(var3)) {
      return 0;
    }

    if(self.damagelocation == var3) {
      return 1;
    }

    if(!isDefined(var4)) {
      return 0;
    }

    if(self.damagelocation == var4) {
      return 1;
    }

    if(!isDefined(var5)) {
      return 0;
    }

    if(self.damagelocation == var5) {
      return 1;
    }

    if(!isDefined(var6)) {
      return 0;
    }

    if(self.damagelocation == var6) {
      return 1;
    }

    if(!isDefined(var7)) {
      return 0;
    }

    if(self.damagelocation == var7) {
      return 1;
    }

    if(!isDefined(var8)) {
      return 0;
    }

    if(self.damagelocation == var8) {
      return 1;
    }

    if(!isDefined(var9)) {
      return 0;
    }

    if(self.damagelocation == var9) {
      return 1;
    }

    if(!isDefined(var10)) {
      return 0;
    }

    if(self.damagelocation == var10) {
      return 1;
    }
  }

  return damagesubpartlocationisany(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11);
}

function damagesubpartlocationisany(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  if(!isDefined(self.damagedsubpart)) {
    return false;
  }

  if(!isDefined(var0)) {
    return false;
  }

  if(self.damagedsubpart == var0) {
    return true;
  }

  if(!isDefined(var1)) {
    return false;
  }

  if(self.damagedsubpart == var1) {
    return true;
  }

  if(!isDefined(var2)) {
    return false;
  }

  if(self.damagedsubpart == var2) {
    return true;
  }

  if(!isDefined(var3)) {
    return false;
  }

  if(self.damagedsubpart == var3) {
    return true;
  }

  if(!isDefined(var4)) {
    return false;
  }

  if(self.damagedsubpart == var4) {
    return true;
  }

  if(!isDefined(var5)) {
    return false;
  }

  if(self.damagedsubpart == var5) {
    return true;
  }

  if(!isDefined(var6)) {
    return false;
  }

  if(self.damagedsubpart == var6) {
    return true;
  }

  if(!isDefined(var7)) {
    return false;
  }

  if(self.damagedsubpart == var7) {
    return true;
  }

  if(!isDefined(var8)) {
    return false;
  }

  if(self.damagedsubpart == var8) {
    return true;
  }

  if(!isDefined(var9)) {
    return false;
  }

  if(self.damagedsubpart == var9) {
    return true;
  }

  if(!isDefined(var10)) {
    return false;
  }

  if(self.damagedsubpart == var10) {
    return true;
  }

  return false;
}

function isbulletdamage(var0) {
  switch (var0) {
    case "MOD_HEAD_SHOT":
    case "MOD_PISTOL_BULLET":
    case "MOD_RIFLE_BULLET":
      return 1;
    default:
      return 0;
  }
}

function isvalidpeekoutdir(var0) {
  var1 = self;
  var2 = var1 getvalidcoverpeekouts();

  foreach(var4 in var2) {
    if(var4 == var0) {
      return true;
    }
  }

  return false;
}

function getbestcovermultinodetype(var0) {
  var1 = var0 getvalidcovermultinodetypes();

  if(var1.size <= 0) {
    return undefined;
  }

  var2 = 0;

  if(isDefined(self.enemy)) {
    var3 = self.enemy.origin;

    if(issentient(self.enemy) && self lastknowntime(self.enemy) > 0) {
      var3 = self lastknownpos(self.enemy);
    }

    var4 = vectortoangles(var3 - var0.origin);
    var2 = angleclamp180(var4[1] - var0.angles[1]);
  }

  foreach(var6 in var1) {
    switch (var6) {
      case "Cover Stand":
      case "Cover Crouch":
        if(abs(var2) < 30) {
          return var6;
        }

        break;
      case "Cover Left Crouch":
      case "Cover Left":
        if(var2 > 30) {
          return "Cover Left";
        }

        break;
      case "Cover Right Crouch":
      case "Cover Right":
        if(var2 < -30) {
          return "Cover Right";
        }

        break;
      default:
        break;
    }
  }

  var8 = var1[0];

  switch (var8) {
    case "Cover Left Crouch":
      return "Cover Left";
    case "Cover Right Crouch":
      return "Cover Right";
  }

  return var8;
}

function isnodecoverleft(var0) {
  return var0.type == "Cover Left";
}

function isnodecoverright(var0) {
  return var0.type == "Cover Right";
}

function isnodecovercrouchtype(var0, var1) {
  if(var0.type == "Cover Crouch" && isDefined(self._blackboard.croucharrivaltype)) {
    return (self._blackboard.croucharrivaltype == var1);
  }

  return false;
}

function isnode3d(var0) {
  return isnodecover3d(var0) || isnodeexposed3d(var0);
}

function isnodecover3d(var0) {
  return var0.type == "Cover Stand 3D" || var0.type == "Cover 3D";
}

function isnodeexposed3d(var0) {
  return var0.type == "Exposed 3D" || var0.type == "Path 3D";
}

function isnodecovercrouch(var0) {
  return var0.type == "Cover Crouch" || var0.type == "Cover Crouch Window" || var0.type == "Conceal Crouch";
}

function absangleclamp180(var0) {
  return abs(angleclamp180(var0));
}

function getaimyawtopoint(var0) {
  var1 = getyawtospot(var0);
  var2 = distance(self.origin, var0);

  if(var2 > 3) {
    var3 = asin(-3 / var2);
    var1 -= var3;
  }

  var1 = angleclamp180(var1);
  return var1;
}

function getyawtospot(var0) {
  if(actor_is3d()) {
    var1 = anglesToForward(self.angles);
    var2 = rotatepointaroundvector(var1, var0 - self.origin, self.angles[2] * -1);
    var0 = var2 + self.origin;
  }

  var3 = getyaw(var0) - self.angles[1];
  var3 = angleclamp180(var3);
  return var3;
}

function getyaw(var0) {
  return vectortoyaw(var0 - self.origin);
}

function getaimyawtopoint3d(var0) {
  var1 = getyawtospot3d(var0);
  var2 = distance(self.origin, var0);

  if(var2 > 3) {
    var3 = asin(-3 / var2);
    var1 -= var3;
  }

  var1 = angleclamp180(var1);
  return var1;
}

function getyawtospot3d(var0) {
  var1 = var0 - self.origin;
  var2 = rotatevectorinverted(var1, self.angles);
  var3 = vectortoyaw(var2);
  var4 = angleclamp180(var3);
  return var4;
}

function getaimpitchtopoint3d(var0) {
  var1 = getpitchtospot3d(var0);
  var2 = distance(self.origin, var0);

  if(var2 > 3) {
    var3 = asin(-3 / var2);
    var1 -= var3;
  }

  var1 = angleclamp180(var1);
  return var1;
}

function getpitchtospot3d(var0) {
  var1 = var0 - self.origin;
  var2 = rotatevectorinverted(var1, self.angles);
  var3 = vectortopitch(var2);
  var4 = angleclamp180(var3);
  return var4;
}

function getplayerpitch(var0) {
  var1 = var0 getplayerangles();
  return (var1[0] + 360) % 360;
}

function getplayeryaw(var0) {
  var1 = var0 getplayerangles();
  return (var1[1] + 360) % 360;
}

function actor_isspace() {
  return istrue(self.space);
}

function actor_is3d() {
  return actor_isspace();
}

function getpredictedaimyawtoshootentorpos(var0, var1, var2) {
  if(!isDefined(var1)) {
    if(!isDefined(var2)) {
      return 0;
    }

    return getaimyawtopoint(var2);
  }

  var3 = (0, 0, 0);

  if(isPlayer(var1)) {
    var3 = var1 getvelocity();
  } else if(isai(var1)) {
    var3 = var1.velocity;
  }

  var4 = var1.origin + var3 * var0;
  return getaimyawtopoint(var4);
}

function getpredictedaimyawtoshootentorpos3d(var0, var1, var2) {
  if(!isDefined(var1)) {
    if(!isDefined(var2)) {
      return 0;
    }

    return getaimyawtopoint3d(var2);
  }

  var3 = (0, 0, 0);

  if(isPlayer(var1)) {
    var3 = var1 getvelocity();
  } else if(isai(var1)) {
    var3 = var1.velocity;
  }

  var4 = var1.origin + var3 * var0;
  return getaimyawtopoint3d(var4);
}

function getpredictedaimpitchtoshootentorpos3d(var0, var1, var2) {
  if(!isDefined(var1)) {
    if(!isDefined(var2)) {
      return 0;
    }

    return getaimpitchtopoint3d(var2);
  }

  var3 = (0, 0, 0);

  if(isPlayer(var1)) {
    var3 = var1 getvelocity();
  } else if(isai(var1)) {
    var3 = var1.velocity;
  }

  var4 = var1.origin + var3 * var0;
  return getaimpitchtopoint3d(var4);
}

function is_equal(var0, var1) {
  if(isDefined(var0) && isDefined(var1) && var0 == var1) {
    return true;
  }

  return false;
}

function player_is_in_jackal() {
  return false;
}

function set_createfx_enabled() {
  if(!isDefined(level.createfx_enabled)) {
    level.createfx_enabled = getDvar("LSTTOTKPNP") != "";
    return;
  }
}

function flag_set_delayed(var0, var1, var2) {
  wait var1;
  flag_set(var0, var2);
}

function noself_array_call(var0, var1, var2, var3, var4) {
  if(isDefined(var4)) {
    foreach(var6 in var0) {
      builtin[[var1]](var6, var2, var3, var4);
    }

    return;
  }

  if(isDefined(var6)) {
    foreach(var6 in var3) {
      builtin[[var4]](var6, var5, var6);
    }

    return;
  }

  if(isDefined(var8)) {
    foreach(var6 in var6) {
      builtin[[var7]](var6, var8);
    }

    return;
  }

  foreach(var6 in var6) {
    builtin[[var9]](var6);
  }
}

function flag_assert(var0) {}

function flag_wait_either(var0, var1) {
  for(;;) {
    if(flag(var0)) {
      return;
    }

    if(flag(var1)) {
      return;
    }

    waittill_either(level, var0, var1);
  }
}

function flag_wait_either_return(var0, var1) {
  if(flag(var0)) {
    return var0;
  }

  if(flag(var1)) {
    return var1;
  }

  var2 = ref_143ad(level, var0, var1);
  return var2;
}

function flag_wait_any(var0, var1, var2, var3, var4, var5) {
  var6 = [];

  if(isDefined(var5)) {
    GscBinSkip0(0x2e, var6.size, var0);
  }

  if(isDefined(var4)) {
    GscBinSkip0(0x2e, var6.size, var0);
  }

  if(isDefined(var3)) {
    GscBinSkip0(0x2e, var6.size, var0);
  }

  if(isDefined(var2)) {
    GscBinSkip0(0x2e, var6.size, var0);
  }

  if(isDefined(var1)) {
    flag_wait_either(var0, var1);
    return;
  }

  return;
}

function flag_wait_any_timeout(var0, var1, var2, var3, var4, var5, var6) {
  var7 = var0 * 1000;
  var8 = gettime();
  var9 = [];

  if(isDefined(var6)) {
    GscBinSkip0(0x2e, var9.size, var1);
  }

  if(isDefined(var5)) {
    GscBinSkip0(0x2e, var9.size, var1);
  }

  if(isDefined(var4)) {
    GscBinSkip0(0x2e, var9.size, var1);
  }

  if(isDefined(var3)) {
    GscBinSkip0(0x2e, var9.size, var1);
  }

  if(isDefined(var2)) {
    GscBinSkip0(0x2e, var9.size, var1);
  }
}

function internal_wait_for_any_flag_or_time_elapses(var0, var1) {
  foreach(var3 in var0) {
    level endon(var3);
  }

  wait var1;
}

function flag_wait_any_return(var0, var1, var2, var3, var4) {
  var5 = [];

  if(isDefined(var4)) {
    GscBinSkip0(0x2e, var5.size, var0);
  }

  if(isDefined(var3)) {
    GscBinSkip0(0x2e, var5.size, var0);
  }

  if(isDefined(var2)) {
    GscBinSkip0(0x2e, var5.size, var0);
  }

  if(isDefined(var1)) {
    var6 = flag_wait_either_return(var0, var1);
    return var6;
  } else {
    return;
  }

  for(var7 = 0; var7 < var6.size; var7++) {
    if(flag(var6[var7])) {
      return var6[var7];
    }
  }

  var6 = ref_143b0(level, var1, var2, var3, var4, var5);
  return var6;
}

function flag_wait_all(var0, var1, var2, var3) {
  if(isDefined(var0)) {
    flag_wait(var0);
  }

  if(isDefined(var1)) {
    flag_wait(var1);
  }

  if(isDefined(var2)) {
    flag_wait(var2);
  }

  if(isDefined(var3)) {
    flag_wait(var3);
    return;
  }
}

function flag_wait_or_timeout(var0, var1) {
  var2 = var1 * 1000;
  var3 = gettime();

  for(;;) {
    if(flag(var0)) {
      break;
    }

    if(gettime() >= var3 + var2) {
      break;
    }

    var4 = var2 - gettime() - var3;
    var5 = var4 / 1000;
    wait_for_flag_or_time_elapses(var0, var5);
  }
}

function flag_waitopen_or_timeout(var0, var1) {
  var2 = gettime();

  for(;;) {
    if(!flag(var0)) {
      break;
    }

    if(gettime() >= var2 + var1 * 1000) {
      break;
    }

    wait_for_flag_or_time_elapses(var0, var1);
  }
}

function wait_for_flag_or_time_elapses(var0, var1) {
  level endon(var0);
  wait var1;
}

function noself_delaycall(var0, var1, var2, var3, var4, var5) {
  thread noself_delaycall_proc(var1, var0, var2, var3, var4, var5);
}

function noself_delaycall_proc(var0, var1, var2, var3, var4, var5) {
  wait var1;

  if(isDefined(var5)) {
    builtin[[var0]](var2, var3, var4, var5);
    return;
  }

  if(isDefined(var4)) {
    builtin[[var0]](var2, var3, var4);
    return;
  }

  if(isDefined(var3)) {
    builtin[[var0]](var2, var3);
    return;
  }

  if(isDefined(var2)) {
    builtin[[var0]](var2);
    return;
  }

  builtin[[var0]]();
}

function get_target_array(var0) {
  if(!isDefined(var0)) {
    var0 = self.target;
  }

  var1 = getEntArray(var0, "targetname");

  if(var1.size > 0) {
    return var1;
  }

  if(scripts\common\utility::issp()) {
    var1 = builtin[[level.getnodearrayfunction]](var0, "targetname");

    if(var1.size > 0) {
      return var1;
    }
  }

  var1 = getStructArray(var0, "targetname");

  if(var1.size > 0) {
    return var1;
  }

  var1 = getvehiclenodearray(var0, "targetname");

  if(var1.size > 0) {
    return var1;
  }
}

function pauseeffect() {
  scripts\common\createfx::stop_fx_looper();
}

function spawn_script_origin(var0, var1) {
  if(!isDefined(var1) && isDefined(self.angles)) {
    var1 = self.angles;
  }

  if(!isDefined(var0) && isDefined(self.origin)) {
    var0 = self.origin;
  } else if(!isDefined(var0)) {
    var0 = (0, 0, 0);
  }

  var2 = spawn("script_origin", var0);

  if(isDefined(var1)) {
    var2.angles = var1;
  }

  return var2;
}

function get_noteworthy_array(var0) {
  var1 = getEntArray(var0, "script_noteworthy");

  if(var1.size > 0) {
    return var1;
  }

  if(scripts\common\utility::issp()) {
    var1 = builtin[[level.getnodearrayfunction]](var0, "script_noteworthy");

    if(var1.size > 0) {
      return var1;
    }
  }

  var1 = getStructArray(var0, "script_noteworthy");

  if(var1.size > 0) {
    return var1;
  }

  var1 = getvehiclenodearray(var0, "script_noteworthy");

  if(var1.size > 0) {
    return var1;
  }
}

function get_cumulative_weights(var0) {
  var1 = [];
  var2 = 0;

  for(var3 = 0; var3 < var0.size; var3++) {
    var2 += var0[var3];
    var1 = var2;
  }

  return var1;
}

function void() {}

function getanim(var0) {
  return level.scr_anim[self.animname][var0];
}

function hasanim(var0) {
  return isDefined(level.scr_anim[self.animname][var0]);
}

function getanim_from_animname(var0, var1) {
  return level.scr_anim[var1][var0];
}

function getanim_generic(var0) {
  return level.scr_anim["generic"][var0];
}

function hasanim_generic(var0) {
  return isDefined(level.scr_anim["generic"][var0]);
}

function waittill_match_or_timeout(var0, var1, var2) {
  var3 = spawnStruct();
  var3 endon("complete");
  delaythread(var3, var2, &send_notify, "complete");
  self waittillmatch(var0, var1);
}

function waittill_match_or_timeout_return(var0, var1, var2) {
  var3 = spawnStruct();
  var3 endon("complete");
  delaythread(var3, var2, &send_notify, "complete");
  self waittill(var0, var1);
  return var1;
}

function send_notify(var0, var1) {
  if(isDefined(var1)) {
    self notify(var0, var1);
    return;
  }

  self notify(var0);
}

function get_notetrack_time(var0, var1) {
  var2 = getnotetracktimes(var0, var1);
  var3 = getanimlength(var0);
  return var2[0] * var3;
}

function mph_to_ips(var0) {
  return var0 * 17.6;
}

function ips_to_mph(var0) {
  return var0 * 0.056818;
}

function add_dialogue_line(var0, var1, var2) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }

  if(!isDefined(level.dialogue_huds)) {
    level.dialogue_huds = [];
  }

  if(level.dialogue_huds.size == 5) {
    var3 = level.dialogue_huds[0];
    level.dialogue_huds = array_remove_index(level.dialogue_huds, 0);
    update_dialogue_huds();
    thread destroy_dialogue_hud();
  }

  var4 = "^3";

  if(isDefined(var2)) {
    switch (var2) {
      case "red":
      case "r":
        var4 = "^1";
        break;
      case "green":
      case "g":
        var4 = "^2";
        break;
      case "yellow":
      case "y":
        var4 = "^3";
        break;
      case "blue":
      case "b":
        var4 = "^4";
        break;
      case "cyan":
      case "c":
        var4 = "^5";
        break;
      case "purple":
      case "p":
        var4 = "^6";
        break;
      case "white":
      case "w":
        var4 = "^7";
        break;
      case "black":
      case "bl":
        var4 = "^8";
        break;
    }
  }

  var5 = 1;

  if(isDefined(level.dialoguelinescale)) {
    var5 = level.dialoguelinescale;
  }

  var6 = newhudelem();
  var6.elemtype = "font";
  var6.font = "default";
  var6.fontscale = var5;
  var6.x = 0;
  var6.y = 0;
  var6.width = 0;
  var6.height = int(level.fontheight * var5);
  var6.xoffset = 0;
  var6.yoffset = 0;
  var7 = level.dialogue_huds.size;
  level.dialogue_huds[var7] = var6;
  var6.foreground = 1;
  var6.sort = 20;
  var6.x = 40;
  var6.y = 260 + var7 * 12 * var5;
  var6.label = "" + var4 + var0 + ": ^7" + var1;
  var6.alpha = 0;
  var6 fadeovertime(0.2);
  var6.alpha = 1;
  var6 endon("death");
  wait 8;
  level.dialogue_huds = array_remove(level.dialogue_huds, var6);
  update_dialogue_huds();
  thread destroy_dialogue_hud();
}

function destroy_dialogue_hud() {
  var0 = 1;

  if(isDefined(level.dialoguelinescale)) {
    var0 = level.dialoguelinescale;
  }

  self endon("death");
  self fadeovertime(0.2);
  self moveovertime(0.2);
  self.y -= 12 * var0;
  self.alpha = 0;
  wait 0.2;
  self destroy();
}

function update_dialogue_huds() {
  var0 = 1;

  if(isDefined(level.dialoguelinescale)) {
    var0 = level.dialoguelinescale;
  }

  level.dialogue_huds = array_removeundefined(level.dialogue_huds);

  foreach(var2 in level.dialogue_huds) {
    var2 moveovertime(0.2);
    var2.y = 260 + var3 * 12 * var0;
  }
}

function closestdistancebetweenlines(var0, var1, var2, var3) {
  var4 = var0 - var2;
  var5 = var3 - var2;

  if(abs(var5[0]) < 1e-06 && abs(var5[1]) < 1e-06 && abs(var5[2]) < 1e-06) {
    return undefined;
  }

  var6 = var1 - var0;

  if(abs(var6[0]) < 1e-06 && abs(var6[1]) < 1e-06 && abs(var6[2]) < 1e-06) {
    return undefined;
  }

  var7 = var4[0] * var5[0] + var4[1] * var5[1] + var4[2] * var5[2];
  var8 = var5[0] * var6[0] + var5[1] * var6[1] + var5[2] * var6[2];
  var9 = var4[0] * var6[0] + var4[1] * var6[1] + var4[2] * var6[2];
  var10 = var5[0] * var5[0] + var5[1] * var5[1] + var5[2] * var5[2];
  var11 = var6[0] * var6[0] + var6[1] * var6[1] + var6[2] * var6[2];
  var12 = var11 * var10 - var8 * var8;

  if(abs(var12) < 1e-06) {
    return undefined;
  }

  var13 = var7 * var8 - var9 * var10;
  var14 = var13 / var12;
  var15 = (var7 + var8 * var14) / var10;
  var16 = var0 + var14 * var6;
  var17 = var2 + var15 * var5;
  var18 = [var16, var17, distance(var16, var17)];
  return var18;
}

function closestdistancebetweensegments(var0, var1, var2, var3) {
  var4 = var1 - var0;
  var5 = var3 - var2;
  var6 = var0 - var2;
  var7 = vectordot(var4, var4);
  var8 = vectordot(var4, var5);
  var9 = vectordot(var5, var5);
  var10 = vectordot(var4, var6);
  var11 = vectordot(var5, var6);
  var12 = var7 * var9 - var8 * var8;
  var13 = var12;
  var14 = var12;
  var15 = 0;
  var16 = 0;
  var17 = 0;
  var18 = 0;

  if(var12 < 1e-08) {
    var16 = 0;
    var13 = 1;
    var18 = var11;
    var14 = var9;
  } else {
    var16 = var8 * var11 - var9 * var10;
    var18 = var7 * var11 - var8 * var10;

    if(var16 < 0) {
      var16 = 0;
      var18 = var11;
      var14 = var9;
    } else if(var16 > var13) {
      var16 = var13;
      var18 = var11 + var8;
      var14 = var9;
    }
  }

  if(var18 < 0) {
    var18 = 0;

    if(var10 * -1 < 0) {
      var16 = 0;
    } else if(var10 * -1 > var7) {
      var16 = var13;
    } else {
      var16 = var10 * -1;
      var13 = var7;
    }
  } else if(var18 > var14) {
    var18 = var14;

    if(var8 - var10 < 0) {
      var16 = 0;
    } else if(var8 - var10 > var7) {
      var16 = var13;
    } else {
      var16 = var8 - var10;
      var13 = var7;
    }
  }

  if(abs(var16) > 1e-08) {
    var15 = var16 / var13;
  }

  if(abs(var18) > 1e-08) {
    var17 = var18 / var14;
  }

  var19 = var0 + var15 * var4;
  var20 = var2 + var17 * var5;
  var21 = [var19, var20, distance(var19, var20)];
  return var21;
}

function is_dead_sentient() {
  return issentient(self) && !isalive(self);
}

function hastag(var0, var1) {
  if(!isDefined(var0) || var0 == "") {
    return 0;
  }

  if(!isDefined(level.has_tag)) {
    level.has_tag = [];
  }

  var2 = var0 + "_" + var1;

  if(isDefined(level.has_tag[var2])) {
    return level.has_tag[var2];
  }

  var3 = getnumparts(var0);

  if(var3 > 0) {
    for(var4 = 0; var4 < var3; var4++) {
      var5 = tolower(getpartname(var0, var4));

      if(var5 == tolower(var1)) {
        level.has_tag[var2] = 1;
        return 1;
      }
    }

    level.has_tag[var2] = 0;
  }

  return 0;
}

function flashbanggettimeleftsec() {
  var0 = self.flashendtime - gettime();

  if(var0 < 0) {
    return 0;
  }

  return var0 * 0.001;
}

function flashbangisactive() {
  return flashbanggettimeleftsec() > 0;
}

function player_died_recently() {
  return getdvarint("player_died_recently_count", "0");
}

function string(var0) {
  return "" + var0;
}

function playsoundontag(var0, var1, var2, var3, var4) {
  [[level.fnplaysoundontag]](var0, var1, var2, var3, var4);
}

function playsoundonentity(var0, var1) {
  [[level.fnplaysoundonentity]](var0, var1);
}

function set_movement_speed(var0) {
  self._blackboard.requestedspeed = var0;
  self aisetdesiredspeed(var0);
}

function set_cautious_navigation(var0) {
  self.cautiousnavigation = var0;
}

function set_bounding_overwatch(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "cover_bounding_overwatch";
  }

  self.boundingoverwatchenabled = var0;
  self.defaultcoverselector = var1;
}

function doinglongdeath() {
  return isDefined(self.a.doinglongdeath);
}

function motionwarpwithnotetracks(var0, var1, var2, var3, var4, var5, var6) {
  if(isDefined(var3)) {
    var7 = getnotetracktimes(var0, var3)[0];

    if(!isDefined(var7)) {
      var7 = 0;
    }
  } else {
    var7 = 0;
  }

  if(isDefined(var5)) {
    var8 = getnotetracktimes(var1, var5)[0];

    if(!isDefined(var8)) {
      var8 = 1;
    }
  } else {
    var8 = 1;
  }

  motionwarpwithtimes(var2, var3, var4, var8, var8, var7, var7);
}

function motionwarpwithtimes(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(var6)) {
    var6 = 1;
  }

  var7 = getangledelta(var0, var3, var4);
  var8 = getmovedelta(var0, var3, var4);
  var8 = rotatevector(var8, (0, var2[1] - var7, 0));
  var9 = var1 - var8;
  var10 = var2[1] - var7;
  var11 = (var2[0], var10, var2[2]);
  var12 = 1;
  var13 = length(var1 - self.origin);

  if(var6 && var13 > 0) {
    var12 = length(var8) / var13;
    var12 = clamp(var12, 0.5, 2);
    self aisetanimrate(var0, var12);
  }

  if(!isDefined(var5)) {
    var14 = getanimlength(var0) / var12;
    var5 = int((var4 - var3) * var14 * 1000);
  }

  if(var5 < 50) {
    var5 = 50;
  }

  self motionwarpwithanim(var9, var11, var1, var2, var5);
  return var12;
}

function waittill_any_ents_or_timeout_return(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14) {
  self endon("death");
  var15 = spawnStruct();
  GscBinSkip4(0x6e, var1, var2, var15);
}

function time_has_passed(var0, var1) {
  if(!isDefined(var0)) {
    return false;
  }

  return gettime() - var0 >= var1 * 1000;
}

function reacttolightifpossible(var0) {
  self.lightreaction_lightorigin = var0;
  self.lightreaction_requesttime = gettime();
}

function setcovercrouchtype(var0) {
  switch (var0) {
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

function setcornerstepoutsdisabled(var0) {
  self.cornerstepoutsdisabled = var0;
}

function getcornerstepoutsdisabled() {
  if(isDefined(self.cornerstepoutsdisabled)) {
    return self.cornerstepoutsdisabled;
  }

  return 0;
}

function can_trace_to_ai(var0, var1, var2, var3) {
  if(isent(self) || isai(self)) {
    var4 = [self, var1];
  } else {
    var4 = [var2];
  }

  if(isDefined(var3)) {
    var4 = array_combine(var4, var3);
  }

  if(scripts\engine\trace::ray_trace_passed(var1, var2.origin, var4, var4)) {
    return true;
  }

  if(scripts\engine\trace::ray_trace_passed(var1, var2 gettagorigin("j_spine4"), var4, var4)) {
    return true;
  }

  if(scripts\engine\trace::ray_trace_passed(var1, var2 getEye(), var4, var4)) {
    return true;
  }

  return false;
}

function array_removedead_or_dying(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  var2 = [];

  foreach(var4 in var0) {
    if(!isalive(var4)) {
      continue;
    }

    if(isai(var4) && var1 && doinglongdeath(var4)) {
      continue;
    }

    var2 = var4;
  }

  return var2;
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

function ent_flag_wait(var0) {
  while(isDefined(self) && !self.ent_flag[var0]) {
    self waittill(var0);
  }
}

function nuke_playmushroombnk(var0, var1, var2, var3) {
  while(isDefined(self)) {
    if(self.ent_flag[var0] && self.ent_flag[var1] && (!isDefined(var2) || self.ent_flag[var2]) && (!isDefined(var3) || self.ent_flag[var3])) {
      break;
    }

    ref_143a7(var0, var1, var2, var3);
  }
}

function array_ent_flag_wait(var0, var1) {
  var2 = spawnStruct();

  foreach(var4 in var0) {
    if(ent_flag(var4, var1)) {
      var0 = array_remove(var0, var4);
    }
  }

  array_thread(var0, &array_ent_flag_wait_proc, var2, var1);

  for(var6 = 0; var6 < var0.size; var6++) {
    var2 waittill("notify");
  }
}

function array_ent_flag_wait_proc(var0, var1) {
  ent_flag_wait(var1);
  var0 notify("notify");
}

function ent_flag_wait_vehicle_node(var0) {
  while(isDefined(self) && !self.ent_flag[var0]) {
    self waittill(var0);
  }
}

function ent_flag_wait_either(var0, var1) {
  while(isDefined(self)) {
    if(ent_flag(var0)) {
      return;
    }

    if(ent_flag(var1)) {
      return;
    }

    waittill_either(var0, var1);
  }
}

function ent_flag_wait_or_timeout(var0, var1) {
  var2 = gettime();

  while(isDefined(self)) {
    if(self.ent_flag[var0]) {
      break;
    }

    if(gettime() >= var2 + var1 * 1000) {
      break;
    }

    ent_wait_for_flag_or_time_elapses(var0, var1);
  }
}

function ent_wait_for_flag_or_time_elapses(var0, var1) {
  self endon(var0);
  wait var1;
}

function ent_flag_waitopen(var0) {
  while(isDefined(self) && self.ent_flag[var0]) {
    self waittill(var0);
  }
}

function ent_flag_assert(var0) {}

function ent_flag_waitopen_either(var0, var1) {
  while(isDefined(self)) {
    if(!ent_flag(var0)) {
      return;
    }

    if(!ent_flag(var1)) {
      return;
    }

    waittill_either(var0, var1);
  }
}

function ent_flag_init(var0) {
  if(!isDefined(self.ent_flag)) {
    self.ent_flag = [];
    self.ent_flags_lock = [];
  }

  self.ent_flag[var0] = 0;
}

function ent_flag_exist(var0) {
  if(isDefined(self.ent_flag) && isDefined(self.ent_flag[var0])) {
    return true;
  }

  return false;
}

function ent_flag_set_delayed(var0, var1) {
  self endon("death");
  wait var1;
  ent_flag_set(var0);
}

function ent_flag_set(var0) {
  self.ent_flag[var0] = 1;
  self notify(var0);
}

function ent_flag_clear(var0, var1) {
  if(self.ent_flag[var0]) {
    self.ent_flag[var0] = 0;
    self notify(var0);
  }

  if(istrue(var1)) {
    self.ent_flag[var0] = undefined;
    return;
  }
}

function ent_flag_clear_delayed(var0, var1) {
  wait var1;

  if(isDefined(self)) {
    ent_flag_clear(var0);
    return;
  }
}

function ent_flag(var0) {
  return self.ent_flag[var0];
}

function get_linked_structs() {
  var0 = [];

  if(isDefined(self.script_linkto)) {
    var1 = get_links();

    for(var2 = 0; var2 < var1.size; var2++) {
      var3 = getStructArray(var1[var2], "script_linkname");

      if(var3.size > 0) {
        var0 = array_combine(var0, var3);
      }
    }
  }

  return var0;
}

function updatescrapassistdata(var0, var1, var2) {
  if(squared(var0[0] - var1[0]) + squared(var0[1] - var1[1]) <= squared(var2)) {
    return true;
  }

  return false;
}

function ref_12c44(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self setpredictedstreamloaddist(var0);

  for(;;) {
    self waittill("luinotifyserver", var1, var2);

    if(var1 == "gamerprofile_request") {
      return var2;
    }
  }
}

function update_hint_logic_killstreak() {
  var0 = 1;
  var1 = 0;

  if(is_player_gamepad_enabled()) {
    var1 = ref_12c44("mountButtonConfig");
  } else {
    var1 = ref_12c44("mountButtonConfigKBM");
  }

  return var1 != var0;
}

function remove_player_rig_laser_panel(var0) {
  if(isnumber(var0)) {
    return int(var0);
  }

  return 0;
}

function ref_13926(var0) {
  var1 = (0, 0, 0);
  var2 = strtok(var0, " ");

  if(var2.size == 3) {
    var1 = (float(var2[0]), float(var2[1]), float(var2[2]));
  }

  return var1;
}

function multitablelookup(var0, var1, var2, var3) {
  foreach(var5 in var0) {
    var6 = tablelookup(var5, var1, var2, var3);

    if(isDefined(var6)) {
      return var6;
    }
  }

  return undefined;
}