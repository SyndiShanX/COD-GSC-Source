/******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_raid_incendiary_can.gsc
******************************************************/

runincendiarycanlogic() {
  level.var_611["incendiary_fire"] = loadfx("vfx/fire/fire_bomb_impact_fire");
  level.var_5A61["incendiary_can"] = ::tryuseincendiarycan;
  level.var_5A7D["incendiary_can"] = "tripwire";
  setdvarifuninitialized("scorestreak_enabled_incendiary_can", 1);
}

tryuseincendiarycan(param_00) {
  var_01 = useincendiarycanwatcher();
  return 1;
}

useincendiarycanwatcher() {
  var_00 = spawnandattachcan();
  if(isDefined(var_00)) {
    var_00 incendiarycanitemenable();
    var_00 maps\mp\gametypes\_gameobjects::func_86F9(self);
  }

  return 1;
}

spawnandattachcan() {
  var_00 = spawn("script_model", self.var_116);
  var_00 setModel("ger_jerry_can_01_gas_raid_projectile");
  var_01 = spawn("trigger_radius", var_00.var_116, 0, 48, 20);
  var_01 enablelinkto();
  var_01.var_66F0 = 1;
  var_02 = [var_00];
  var_03 = maps\mp\gametypes\_gameobjects::func_27D6(game["attackers"], var_01, var_02, (0, 0, 0), 1, 1);
  var_03.var_695F = 1;
  var_03.var_7D25 = 1;
  var_03.var_10F5 = 1;
  var_03.var_C2C = 1;
  var_03.var_A414 = 1;
  var_03 maps\mp\gametypes\_gameobjects::func_6B52(1);
  var_01.var_2016 = var_03;
  var_03 maps\mp\gametypes\_gameobjects::func_873F("friendly", &"RAIDS_RESUPPLY_USING_SOURCE_PICKUP");
  var_03 maps\mp\gametypes\_gameobjects::func_873F("enemy", &"MP_RETURNING_FLAG");
  var_03 maps\mp\gametypes\_gameobjects::func_C1D("friendly");
  var_03 maps\mp\gametypes\_gameobjects::func_8A5A(1);
  var_03.var_9D65 = var_01;
  var_03.var_A23E = 14;
  var_03.var_6B62 = ::onincediarycanpickup;
  var_03.var_6AEF = ::onincendiarycandrop;
  var_03.var_866E = ::onincendiarycansetdropped;
  var_03.var_6ABC = ::oncanbeginuse;
  var_03.var_6AFA = ::oncanenduse;
  var_03.var_201C = "m712carry_mp";
  if(var_03.var_201C == "noWeapSwitch") {
    var_03.var_201C = undefined;
  }

  var_03.var_59D9 = ::shouldplayerkeepcarryweapon;
  var_03.var_201D = ::func_A900;
  var_03.var_6BBE = ::oncanupdateuserate;
  var_03.var_1F84 = ::canuseincendiarycan;
  var_03.var_1F6A = ::canseeincendiarycan;
  var_03.var_C33 = 1;
  var_03.var_2D5A = 0;
  var_03.var_501F = spawn("script_origin", var_02[0].var_116);
  var_03.var_501F setModel("tag_origin");
  var_03.ignoreboundaries = 1;
  var_03.var_4B80 = [];
  var_03 incendiarycandisable();
  return var_03;
}

onincediarycanpickup(param_00) {
  self notify("picked_up");
  self.var_A879 = 0;
  var_01 = param_00.var_12C["team"];
  var_02 = maps\mp\_utility::func_45DE(var_01);
  self.var_10F5 = 0;
  var_03 = self.var_A582[0] getlinkedparent();
  if(isDefined(var_03)) {
    self.var_A582[0] unlink();
  }

  self.var_A582[0] method_84E0();
  self.var_A582[0] maps\mp\_movers::func_67F9();
  self.var_A582[0] method_805B();
  self.var_A582[0] method_8511();
  self.var_A582[0].var_116 = self.var_A582[0].var_116 + (0, 0, -10000);
  self.var_9D65 maps\mp\_movers::func_93CE();
  param_00 thread attachcan(self);
  param_00 common_scripts\utility::func_601();
  param_00 lib_0502::replacehintstringclient(&"RAIDS_USE_CONSTRUCT", &"RAIDS_TRIPWIRE_BLANK");
  maps\mp\gametypes\_gameobjects::func_8A60("any");
  maps\mp\gametypes\_gameobjects::func_8740("friendly", 1);
  maps\mp\gametypes\_gameobjects::func_8740("enemy", 1);
  if(isDefined(self.var_201C)) {
    param_00 givemaxammo(self.var_201C);
  }

  param_00 thread func_941D(self.var_79AD);
  thread supplycarrierwithammo();
  param_00 thread func_2CE1();
}

attachcan(param_00) {
  self endon("detachCan");
  self endon("disconnect");
  wait(0.2);
  self.var_2013 = "ger_jerry_can_01_gas_raid_projectile";
  if(!isDefined(self.carryflagtag)) {
    self.carryflagtag = "tag_weapon_left";
  }

  self attach(self.var_2013, self.carryflagtag, 1);
}

func_941D(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("drop_object");
  while(self method_8126()) {
    wait 0.05;
  }

  var_01 = "raid_carryflag_mp";
  if(1) {
    if(!isDefined(self.var_9426)) {
      self.var_9426 = [];
    }

    var_02 = spawnStruct();
    var_02.var_109 = self method_834A();
    var_02.var_2420 = self getweaponammoclip(var_02.var_109, "right");
    var_02.var_93AF = self getweaponammostock(var_02.var_109);
    self.var_9426["lethal_offhand"] = var_02;
    var_03 = spawnStruct();
    var_03.var_109 = self method_831F();
    var_03.var_2420 = self getweaponammoclip(var_03.var_109, "right");
    var_03.var_93AF = self getweaponammostock(var_03.var_109);
    self.var_9426["tactical_offhand"] = var_03;
    if(var_02.var_109 != "none") {
      self takeweapon(var_02.var_109);
    }

    if(var_03.var_109 != "none") {
      self takeweapon(var_03.var_109);
    }

    self method_8349(var_01);
    self giveweapon(var_01);
    self method_82FA(var_01, 1, "right");
    self setweaponammostock(var_01, 1);
    return;
  }

  self giveweapon(var_01);
}

supplycarrierwithammo() {
  level endon("game_ended");
  self endon("reset");
  self endon("dropped");
  var_00 = self.var_2006;
  if(!isDefined(var_00)) {
    return;
  }

  var_00 endon("death");
  var_00 endon("disconnect");
  while(maps\mp\_utility::func_57A0(var_00)) {
    var_00 waittill("reload");
    var_01 = var_00 getcurrentprimaryweapon();
    var_02 = var_00 getweaponammostock(var_01);
    var_03 = weaponclipsize(var_01, var_00);
    if(var_02 < var_03) {
      var_00 setweaponammostock(var_01, var_03);
    }
  }
}

func_2CE1() {
  wait(1);
  self method_8327();
}

onincendiarycandrop(param_00) {
  maps\mp\gametypes\_gameobjects::func_C1D("any");
  maps\mp\gametypes\_gameobjects::func_8740("enemy", 1);
  maps\mp\gametypes\_gameobjects::func_8740("friendly", 1);
  maps\mp\gametypes\_gameobjects::func_8A60("any");
  if(isDefined(param_00)) {
    var_01 = undefined;
    if(common_scripts\utility::func_562E(self.var_A879)) {
      var_01 = 0.5;
    }

    param_00 thread func_7DE9(var_01);
    param_00 detachcan();
    param_00 lib_0502::replacehintstringclient(&"RAIDS_USE_CONSTRUCT", undefined);
  }
}

func_7DE9(param_00) {
  if(isDefined(param_00)) {
    wait(param_00);
  }

  var_01 = "m712carry_mp";
  if(var_01 != "noWeapSwitch" && self hasweapon(var_01)) {
    self takeweapon(var_01);
  }

  var_02 = "raid_carryflag_mp";
  if(self hasweapon(var_02)) {
    self takeweapon(var_02);
  }

  if(!isDefined(self.var_9426)) {
    return;
  }

  var_03 = self.var_9426["lethal_offhand"];
  if(var_03.var_109 != "none") {
    self method_8349(var_03.var_109);
    self giveweapon(var_03.var_109);
    self method_82FA(var_03.var_109, var_03.var_2420, "right");
    self setweaponammostock(var_03.var_109, var_03.var_93AF);
  }

  var_04 = self.var_9426["tactical_offhand"];
  if(var_04.var_109 != "none") {
    self method_831E(var_04.var_109);
    self giveweapon(var_04.var_109);
    self method_82FA(var_04.var_109, var_04.var_2420, "right");
    self setweaponammostock(var_04.var_109, var_04.var_93AF);
  }
}

detachcan() {
  self notify("detachCan");
  var_00 = 0;
  if(common_scripts\utility::func_562E(self.var_A871)) {
    var_00 = 1;
  }

  if(isDefined(self.var_2013)) {
    var_01 = self method_802E(self.var_2013, self.carryflagtag, !function_02BD());
  }

  self.var_A871 = 0;
  self.var_2013 = undefined;
}

onincendiarycansetdropped(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  self.var_57A6 = 1;
  self notify("dropped");
  var_01 = self.var_2006;
  if(isDefined(var_01) && isDefined(var_01.var_230C)) {
    var_01.var_230C.var_28D5 = 0;
  }

  if(isDefined(var_01) && var_01.var_12C["team"] != "spectator") {
    var_02 = var_01.var_116;
  } else {
    var_02 = self.var_802F;
  }

  var_02 = var_02 + (0, 0, 40);
  var_03 = (0, 0, 0);
  for(var_04 = 0; var_04 < self.var_A582.size; var_04++) {
    self.var_A582[var_04].var_116 = var_02;
    self.var_A582[var_04].var_1D = var_03;
    self.var_A582[var_04] method_805B();
  }

  self.var_9D65.var_116 = var_02;
  self.var_A582[0] method_808C();
  self.var_28D4 = self.var_9D65.var_116;
  can_carrier_cleanup();
  if(isDefined(self.var_6AEF)) {
    self[[self.var_6AEF]](self.var_2006);
  }

  maps\mp\gametypes\_gameobjects::func_23DA();
  maps\mp\gametypes\_gameobjects::func_A0FE();
  maps\mp\gametypes\_gameobjects::func_A19B();
  self.var_57A6 = 0;
  if(!param_00) {
    canphysicslaunch((0, 0, 80));
  } else {
    maps\mp\gametypes\_gameobjects::func_8740("friendly", 1);
  }

  var_05 = self.var_A582[0];
  var_05.var_2016 = self;
  var_05 setdamagecallbackon(1);
  var_05.var_29B5 = ::incendiarydamagecallback;
  var_05 setCanDamage(1);
  var_05 method_86B7();
  var_05 method_80B0(8576);
  var_01 maps\mp\_utility::func_955C(var_01 getweaponslistprimaries()[1]);
  return 1;
}

can_carrier_cleanup() {
  if(isDefined(self.var_2006)) {
    self.var_2006 common_scripts\utility::func_615();
  }
}

canphysicslaunch(param_00, param_01) {
  var_02 = self.var_A582[0];
  var_02.var_6C43 = undefined;
  if(isDefined(param_01)) {
    var_03 = param_01.var_1D;
    var_02.var_1D = (0, var_03[1] + 250, 120);
  }

  var_02 physicslaunchserver(var_02.var_116, param_00);
}

oncanbeginuse(param_00) {
  param_00.var_230C = self;
}

oncanenduse(param_00, param_01, param_02) {
  if(isDefined(param_01)) {
    param_01.var_230C = undefined;
    param_01 enableusability();
  }
}

shouldplayerkeepcarryweapon(param_00) {
  return param_00.var_12C["team"] == maps\mp\gametypes\_gameobjects::func_45F7();
}

func_A900() {
  thread func_5FD8();
  thread func_5FDE();
}

func_5FDE() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");
  for(;;) {
    self waittill("grenade_fire", var_00, var_01);
    if(var_01 != "raid_carryflag_mp") {
      continue;
    }

    self.var_6735 = gettime() + 500;
    self.var_A871 = 1;
    thread throwphysicscan(self, var_00);
    var_00 method_81D6();
    self notify("incendiary_can_used");
    break;
  }
}

throwphysicscan(param_00, param_01) {
  var_02 = param_00.var_2016;
  var_03 = -8;
  var_04 = 1;
  var_05 = 37000 * var_04;
  var_06 = param_00 getangles();
  var_06 = var_06 + (var_03, 0, 0);
  var_06 = (clamp(var_06[0], -85, 85), var_06[1], var_06[2]);
  var_07 = anglesToForward(var_06);
  var_08 = param_00 getvelocity();
  var_09 = vectornormalize((var_07[0], var_07[1], 0));
  var_0A = vectornormalize((var_08[0], var_08[1], 0));
  var_0B = 0;
  if(vectordot(var_09, var_0A) >= 0.42 && length(var_08) > 120) {
    var_0C = 1;
    var_0B = 6000 * var_0C;
  }

  var_02.var_A879 = 1;
  var_02 thread onincendiarycansetdropped(1);
  var_02.var_A582[0].var_116 = param_01.var_116;
  var_02 canphysicslaunch(var_07 * var_05 + var_0B, param_00);
}

func_5FD8() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");
  for(;;) {
    wait(1);
    self waittill("weapon_change", var_00);
    if(isDefined(var_00) && var_00 == "raid_carryflag_mp" || var_00 == "m712carry_mp") {
      continue;
    }

    if(isDefined(self.var_2016)) {
      self.var_6735 = gettime() + 2000;
      self.var_2016 thread onincendiarycansetdropped(0);
      self notify("incendiary_can_used");
      return;
    }
  }
}

oncanupdateuserate() {
  self.var_A22B = 0;
  if(self.var_230F != "none") {
    var_00 = self.var_689F[self.var_230F];
    var_01 = self.var_689F[maps\mp\_utility::func_45DE(self.var_230F)];
    var_02 = var_00 && var_01;
    if(var_00 && !var_01) {
      self.var_A22B = 1;
    }
  } else {
    var_02 = 0;
  }

  self.var_915C = var_02;
}

canuseincendiarycan(param_00) {
  if(param_00 islinked()) {
    return 0;
  }

  if(param_00 isusingturret()) {
    return 0;
  }

  if(isDefined(param_00.var_99AC)) {
    return 0;
  }

  if(isDefined(param_00.var_2016)) {
    return 0;
  }

  if(isDefined(param_00.var_2310)) {
    return 0;
  }

  if(isDefined(param_00.var_230C) && param_00.var_230C != self) {
    return 0;
  }

  if(isDefined(param_00.var_6735) && param_00.var_6735 > gettime()) {
    return 0;
  }

  return 1;
}

canseeincendiarycan(param_00, param_01) {
  var_02 = param_01[0];
  var_03 = self.var_A582[0];
  var_04 = [];
  var_05 = [-1, 0, 1];
  foreach(var_07 in var_05) {
    var_04[var_04.size] = var_03 method_8549(0, 0, var_07);
  }

  var_09 = param_00.var_116 - self.var_9D65.var_116;
  var_0A = common_scripts\utility::func_3D5D(var_09);
  var_0B = vectornormalize(var_0A);
  var_0C = var_0B * 5;
  foreach(var_0E in var_04) {
    var_0F = param_00.var_116 + (0, 0, 10);
    var_10 = var_0E + var_0C;
    var_11 = bulletTrace(var_0F, var_10, 0, var_02, 0, 0, 0, 0, 1, 0, 0);
    if(var_11["fraction"] == 1) {
      return 1;
    }
  }

  return 0;
}

incendiarycandisable() {
  if(self.var_9D65 islinked()) {
    self.var_9D65 unlink();
  }

  maps\mp\gametypes\_gameobjects::func_2F93();
  maps\mp\gametypes\_gameobjects::func_8A60("none");
}

incendiarycanitemenable() {
  maps\mp\gametypes\_gameobjects::func_365D();
  self.var_9D65.var_116 = self.var_A582[0].var_116;
  self.var_9D65 linkto(self.var_A582[0]);
  maps\mp\gametypes\_gameobjects::func_8A60("any");
}

incendiarydamagecallback(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = self.var_116;
  var_0D = self.var_1D;
  if(isDefined(self.var_2016)) {
    self.var_2016 maps\mp\gametypes\_gameobjects::func_2F93();
    wait 0.05;
    waittillframeend;
    self.carryobjectobjidallies = undefined;
    self.carryobjectobjidaxis = undefined;
    self.carryobjectobjidbroadcaster = undefined;
    if(isDefined(self.var_2016)) {
      self.var_2016 maps\mp\gametypes\_gameobjects::func_2D2F();
    }

    radiusdamage(var_0C, 50, 20, 200);
    level thread func_749B(var_0C, var_0D);
    level thread monitorfiredamage(var_0C, var_0D, param_01, param_01.var_1A7);
  }
}

func_749B(param_00, param_01) {
  var_02 = undefined;
  var_02 = spawnfx(level.var_611["incendiary_fire"], param_00);
  triggerfx(var_02);
  wait(12);
  if(isDefined(var_02)) {
    var_02 delete();
  }
}

monitorfiredamage(param_00, param_01, param_02, param_03, param_04) {
  level endon("game_ended");
  if(!isDefined(param_00) || !isDefined(param_01)) {
    return;
  }

  var_05 = gettime();
  var_06 = 0;
  var_07 = anglesToForward(param_01);
  var_07 = (var_07[0], var_07[1], 0);
  var_07 = vectornormalize(var_07);
  while(var_06 < 12) {
    foreach(var_09 in level.var_744A) {
      if(function_0279(var_09)) {
        continue;
      }

      if(var_09.var_1A7 != param_03 || (isDefined(param_02) && var_09 == param_02) || isDefined(level.var_4B17) && level.var_4B17) {
        if(!isDefined(var_09.var_A019)) {
          if(!isDefined(var_09.lastincendiarycandamagetime) || var_09.lastincendiarycandamagetime != gettime()) {
            if(func_73E1(var_09, param_00, var_07)) {
              if(func_740F(var_09, param_00)) {
                var_09.lastincendiarycandamagetime = gettime();
                var_09 dodamage(40, var_09.var_116, param_02, undefined, "MOD_BURNED", "firebomb_flames_mp");
              }
            }
          }
        }
      }
    }

    wait(0.4);
    var_06 = gettime() - var_05 / 1000;
  }
}

func_740F(param_00, param_01) {
  if(param_00.var_116[2] <= param_01[2]) {
    return bullettracepassed(param_00.var_116 + (0, 0, 10), (param_00.var_116[0], param_00.var_116[1], param_01[2] + 10), 0, param_00) && bullettracepassed(param_01 + (0, 0, 10), (param_00.var_116[0], param_00.var_116[1], param_01[2] + 10), 0, param_00);
  }

  return bullettracepassed(param_01 + (0, 0, 10), (param_01[0], param_01[1], param_00.var_116[2] + 10), 0, param_00) && bullettracepassed(param_00.var_116 + (0, 0, 10), (param_01[0], param_01[1], param_00.var_116[2] + 10), 0, param_00);
}

func_73E1(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    return 0;
  }

  var_03 = param_00 getorigin();
  if(var_03[2] - param_01[2] > 256) {
    return 0;
  }

  var_04 = 103;
  var_05 = func_2825(param_01, param_02, var_04);
  return func_7542(var_03, var_05);
}

func_2825(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  var_04 = param_01 * param_02;
  var_05 = vectorcross(param_01, (0, 0, 1)) * param_02;
  var_03.var_794 = param_00 + var_04 - var_05;
  var_03.var_14C2 = param_00 + var_04 + var_05;
  var_03.var_1DEC = param_00 - var_04 + var_05;
  var_03.var_298F = param_00 - var_04 - var_05;
  return var_03;
}

func_7542(param_00, param_01) {
  return func_803F(param_00, param_01.var_794, param_01.var_14C2, param_01.var_298F) && func_803F(param_00, param_01.var_14C2, param_01.var_1DEC, param_01.var_794) && func_803F(param_00, param_01.var_1DEC, param_01.var_298F, param_01.var_14C2) && func_803F(param_00, param_01.var_298F, param_01.var_794, param_01.var_1DEC);
}

func_803F(param_00, param_01, param_02, param_03) {
  var_04 = vectorcross(param_02 - param_01, param_03 - param_01);
  var_05 = vectorcross(param_02 - param_01, param_00 - param_01);
  return vectordot(var_04, var_05) >= 0;
}