/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58310.gsc
***********************************************/

_id_13D79() {
  self.thermiteradiusweaponref = anglesToForward(self.angles);
  self.initial_up = anglestoup(self.angles);
  self.thermitestuckpains = anglestoright(self.angles);

  if(!isDefined(level.targets_thinking))
    level.targets_thinking = 0;

  level.targets_thinking++;
  self.down_angles = self.angles;
  self.parts = getEntArray(self.script_linkname, "_encstr_818E0EB98D4EA5078ED7C64B37B6E8ED");
  self.parts = scripts\engine\utility::array_remove(self.parts, self);

  foreach(var_1 in self.parts) {
    switch (var_1.script_noteworthy) {
      case "_encstr_AB270DF4CF33E72F9991639A58A167":
        self.plate = var_1;
        break;
      case "_encstr_875112130386CADD1046BA85B928E581559387EB":
        self.plate = var_1;
        self._id_123B5 = var_1;
        break;
      case "_encstr_81640BFBC970878AED6F4F0B63":
        self.arm = var_1;
        break;
      case "_encstr_970D0C6907A334A0E441D18972DD":
        self.base = var_1;
        break;
      case "_encstr_B4D60E3A164EB3B2E8EBBB432B958DCD":
        self.wheels = var_1;
        break;
      case "_encstr_912B12B09762E1C34329475BBD2913ABCB0F9B28":
        self.aim_assist = var_1;
        break;
      case "_encstr_B26D119BA910E72A4DCFE7DF8179D24B60F095":
        self.collision = var_1;
        break;
      case "_encstr_85CC16EB30732712A1E08E8551A9EAFBB8D80BBFF0088FEA":
        self.collision_down = var_1;
        break;
      case "_encstr_88D5148E163976CA1DEBB1ED8D36D2DCA5DB73AFAB38":
        self.collision_up = var_1;
        break;
      default:
        break;
    }

    var_1.target = "_encstr_A3BA05E0735C50";
    var_1.targetname = "_encstr_A3BA05E0735C50";
  }

  self.plate linkTo(self);
  self.arm linkTo(self);

  if(isDefined(self.wheels))
    self.wheels linkTo(self.base);

  if(isDefined(self.base)) {
    if(isDefined(self.collision))
      self.collision linkTo(self.base);

    if(isDefined(self.collision_down))
      self.collision_down linkTo(self.base);

    if(isDefined(self.collision_up))
      self.collision_up linkTo(self.base);
  }

  self.state_up = 0;
  self.flipping = 0;

  if(issubstr(self.script_noteworthy, "_encstr_83E8094727E333E8F9CE50")) {
    self.is_civilian = 1;
    level.civilian_targets[level.civilian_targets.size] = self;
  } else {
    self.is_civilian = 0;
    level.enemy_targets[level.enemy_targets.size] = self;
  }

  thread _id_13D72();

  if(isDefined(self._id_123B5))
    thread _id_13D70();

  self.activated = 0;
  thread _id_13D78();

  if(issubstr(self.script_noteworthy, "_encstr_ACC107AD988D31CD07"))
    thread _id_13D55();

  if(isDefined(level._id_13D7A))
    self[[level._id_13D7A]]();

  if(isDefined(level._id_13D7B))
    self thread[[level._id_13D7B]]();

  level.targets_thinking--;
}

gettargetarray() {
  var_0 = ["_encstr_ADEA101F347937E09B80F4F15B67A091577B", "_encstr_830514CD1D0B9B9158E491F53AB09C7656E8BE89E081", "_encstr_83FE19501BA90809AA2A9D0883826D9115B3A95897562021729680", "_encstr_A3C00CC6AC85E6F5D12C39D9CA1D", "_encstr_93A915B1ACC2CDF5E8B039EC2B47EBB12DCEA5B14B0B9B", "_encstr_BDED0E55B8FD8276F1D9FBB7A8A9351B", "_encstr_A22F17DA7BCE9673ECFAA32C93B3B28EBE1BD23B961BD285CD"];
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3[var_2] = scripts\engine\utility::getStructArray(var_0[var_2], "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

    foreach(var_5 in var_3[var_2]) {
      var_6 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_5.origin);
      var_6.angles = var_5.angles;
      var_6.script_gameobjectname = var_5.script_gameobjectname;
      var_6.script_linkname = var_5.script_linkname;
      var_6.script_noteworthy = var_5.script_noteworthy;
      var_6.target = var_5.target;
      var_6.targetname = var_5.targetname;
    }
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++)
    var_1[var_2] = getEntArray(var_0[var_2], "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  return scripts\engine\utility::array_combine_multiple(var_1);
}

_id_13D72() {
  var_0 = undefined;

  if(isDefined(self._id_123B5)) {
    var_1 = "_encstr_B140237CED4056A3B87342ABDE05CFCA58BBF4CF4598DA67D68BE902C0D767492003996BE9";
    var_0 = level.start_area_fx;
  } else
    var_1 = "_encstr_AF6D2475BEDAB35539A74FBB11338F8DC1DD95F7E3819A27E5F9285823DB968A89DA509AFA33";

  for(;;) {
    self.activated = 0;

    while(self.state_up == 0)
      waitframe();

    self.plate waittill("_encstr_B2BE0788BAF573592F", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    self.plate playSound(var_1);

    if(self.is_civilian == 1)
      level.player thread _tablethide::_id_13D4B(self, 0, 1, 0);
    else
      level.player thread _tablethide::_id_13D4B(self, 1, 0, 0);

    self.activated = 1;

    if(var_6 == "_encstr_8DED0A21C79B660BC7588981")
      level.player notify("_encstr_81D812992CB5567D7756C20EDECDFACC964ECA8C");

    if(self.is_civilian && isDefined(level._id_13D71))
      self[[level._id_13D71]]();
    else if(isDefined(level._id_13D73))
      self[[level._id_13D73]]();

    if(isDefined(level._id_13D76) && self.plate tagexists("_encstr_A34D09138A0738D0D7E949") && distance(self.plate gettagorigin("_encstr_A34D09138A0738D0D7E949"), var_5) <= 5)
      self[[level._id_13D76]]();

    if(isDefined(var_0))
      playFX(var_0, var_5);

    if(isDefined(self._id_123B5)) {
      self._id_123B5 hide();
      wait(randomfloatrange(0.7, 1));
    }

    thread _id_13D74("_encstr_9767056D0FBFA8");
    level waittill("_encstr_B8D80D131723B292AB2759B2975BA0");

    if(isDefined(self._id_123B5)) {
      _tablethide::trial_ui_waittill_retry();
      self._id_123B5 show();
    }
  }
}

_id_13D74(var_0) {
  if(var_0 == "_encstr_87070365F7") {
    if(isDefined(self.script_delay))
      wait(self.script_delay);

    self.plate setCanDamage(1);

    if(isDefined(self.aim_assist))
      self.aim_assist enableaimassist();

    if(isDefined(self.collision_up))
      self.collision_up solid();

    if(isDefined(self.collision_down))
      self.collision_up notsolid();

    if(self.state_up == 1) {
      return;
    }
    self.state_up = 1;
    var_1 = 1;
  } else {
    self.plate setCanDamage(0);

    if(isDefined(self.aim_assist))
      self.aim_assist disableaimassist();

    if(isDefined(self.collision_up))
      self.collision_up notsolid();

    if(isDefined(self.collision_down))
      self.collision_up solid();

    if(self.state_up == 0) {
      return;
    }
    self.state_up = 0;
    var_1 = -1;
  }

  var_2 = undefined;
  var_3 = undefined;

  switch (self.script_noteworthy) {
    case "_encstr_83FE19501BA90809AA2A9D0883826D9115B3A95897562021729680":
    case "_encstr_A22F17DA7BCE9673ECFAA32C93B3B28EBE1BD23B961BD285CD":
    case "_encstr_BDED0E55B8FD8276F1D9FBB7A8A9351B":
    case "_encstr_ADEA101F347937E09B80F4F15B67A091577B":
      var_3 = 90;
      var_2 = 0.2;
      break;
    case "_encstr_93A915B1ACC2CDF5E8B039EC2B47EBB12DCEA5B14B0B9B":
    case "_encstr_A3C00CC6AC85E6F5D12C39D9CA1D":
      var_3 = 30;
      var_2 = 0.15;
      break;
    case "_encstr_830514CD1D0B9B9158E491F53AB09C7656E8BE89E081":
      var_3 = 180;
      var_2 = 0.4;
      break;
    default:
      var_3 = 90;
      var_2 = 0.2;
      break;
  }

  self.flipping = 1;

  if(issubstr(self.script_noteworthy, "_encstr_ACC107AD988D31CD07"))
    waitframe();

  if(var_0 == "_encstr_87070365F7")
    self playsoundonmovingent("_encstr_AB551805A2AAFBB86FE710D86F7CD115928FFD183F5253632D83");

  if(self.thermitestuckpains[2] != 0)
    self rotateYaw(-1 * self.thermitestuckpains[2] * var_3 * var_1, var_2);
  else
    self rotatepitch(var_3 * var_1, var_2);

  wait(var_2);

  if(var_0 == "_encstr_9767056D0FBFA8") {
    waitframe();
    self playsoundonmovingent("_encstr_B61F1A9390482F7117603BBBB1458922DFB7C5C91D48BBF093D547AE");
    self.angles = self.down_angles;
  }

  self.flipping = 0;
}

_id_13D55() {
  self.mover = scripts\engine\utility::getclosest(self.origin, level.course_movers, 32);

  if(!isDefined(self.mover)) {
    return;
  }
  self.mover_ends = scripts\engine\utility::getStructArray(self.mover.targetname, "_encstr_A16007A921A23B85E3");
  self.mover_ends = sortbydistance(self.mover_ends, self.mover.origin);
  var_0 = self.mover.origin - self.origin;
  self.mover.origin = self.mover.origin + var_0;
  self.mover_ends[0].origin = self.mover_ends[0].origin + var_0;
  self.mover_ends[1].origin = self.mover_ends[1].origin + var_0;
  self.moveforward = 1;
  self.moving = 0;

  if(isDefined(self.script_speed))
    self.move_speed = self.script_speed;
  else
    self.move_speed = 32;

  level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23");
  thread _id_13D54();

  for(;;) {
    if(self.moving && (90 > distance(level.player.origin, self.origin) || !self.state_up)) {
      self notify("_encstr_A1C40C9E5C97238F6DCAF04BB287");
      self.moving = 0;
      self.dummy delete();
      self.plate playSound("_encstr_96061B104082C73A4E430AB35FEBE3D3E46DFB58304AD0FF616B3D08B2");
      self.dummy thread scripts\engine\utility::stop_loop_sound_on_entity("_encstr_86891BD1935AB063EBCDCCC3AF1DB0273B591DBE5BDE3B59AF8DED7B07");
    } else if(self.flipping == 0 && self.moving == 0 && 90 < distance(level.player.origin, self.origin) && self.state_up == 1)
      thread _id_13D53();

    waitframe();
  }
}

_id_13D53() {
  self endon("_encstr_A1C40C9E5C97238F6DCAF04BB287");
  self.moving = 1;
  self.dummy = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  childthread _id_13D75();
  self.dummy thread scripts\engine\utility::play_loop_sound_on_entity("_encstr_86891BD1935AB063EBCDCCC3AF1DB0273B591DBE5BDE3B59AF8DED7B07");
  self.plate playSound("_encstr_BA491CF465C8DE3B20FBFA23468D4752E0238C57C350A3C7C813D3BA8BE5");

  for(;;) {
    var_0 = self.mover_ends[self.moveforward];
    var_1 = distance(self.dummy.origin, var_0.origin);
    var_2 = var_1 / self.move_speed;
    var_3 = 0.5;
    var_3 = clamp(var_3, 0, var_2 / 2);
    self.dummy moveTo(var_0.origin, var_2, var_3, var_3);
    wait(var_2);
    self.moveforward = !self.moveforward;
  }
}

_id_13D54() {
  for(;;) {
    level waittill("_encstr_93EF1C7B3880D17207869F126D39AB8BEE88AFFB68F906894F9FE74D5DC1");
    waitframe();
    self.origin = self.mover.origin;
    self.base.origin = self.mover.origin;
    self.moveforward = 1;
  }
}

_id_13D75() {
  for(;;) {
    self.origin = self.dummy.origin;
    self.base.origin = self.dummy.origin;
    waitframe();
  }
}

_id_13D70() {
  self.arm setCanDamage(1);

  for(;;) {
    self.arm waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(var_4 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_4 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || var_4 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" && istrue(self.state_up))
      self.plate dodamage(1, self.plate.origin);
  }
}

_id_13D78() {
  waitframe();

  if(isDefined(self.targetname))
    var_0 = getEntArray(self.targetname, "_encstr_A16007A921A23B85E3");
  else
    var_0 = [];

  for(;;) {
    var_1 = 1;

    foreach(var_3 in var_0) {
      if(var_3.activated == 0)
        var_1 = 0;
    }

    if(var_1 == 1) {
      _id_13D74("_encstr_87070365F7");
      level waittill("_encstr_B8D80D131723B292AB2759B2975BA0");
    }

    waitframe();
  }
}

_id_13D82() {
  var_0 = getEntArray("_encstr_86030F6F88715F32D9BDCEC41FEFAA26DB", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  for(;;) {
    self.activated = 0;
    _tablethide::waittill_player_isDefined();

    if(isDefined(self.script_noteworthy)) {
      if(self.script_noteworthy != "_encstr_99AD06D3A5B1538B")
        level waittill("_encstr_85EC0F1BA7D0E24F3566A3DB89966B9FF0");
    } else
      level waittill("_encstr_85EC0F1BA7D0E24F3566A3DB89966B9FF0");

    while(level.player istouching(self))
      waitframe();

    if(isDefined(self.script_noteworthy) && self.script_noteworthy == "_encstr_961804BD954A") {
      for(;;) {
        self waittill("_encstr_8F5C086405E70FBA4B4A");

        if(break_window_glass(var_0)) {
          break;
        }
      }
    } else
      self waittill("_encstr_8F5C086405E70FBA4B4A");

    self.activated = 1;
    level notify("_encstr_8C3D12A0235CC7E1876AB09753EB68BD062B50A8");

    if(isDefined(level._id_13D81))
      self[[level._id_13D81]]();

    level waittill("_encstr_B8D80D131723B292AB2759B2975BA0");
  }
}

break_window_glass(var_0) {
  foreach(var_2 in var_0) {
    if(!var_2.activated)
      return 0;
  }

  return 1;
}