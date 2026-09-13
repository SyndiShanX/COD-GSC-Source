/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6f8df08fda691535.gsc
***********************************************/

onplayerconnectrunonce() {
  level endon("game_ended");
  self endon("disconnect");
  level _id_0CBB0697DE4C5728::_id_3B59B4D385A202E6();

  if(getdvarint("dvar_5B297D60086F0068", 1) == 1)
    setDvar("dvar_7B242DB976CD82C7", 0);

  level.playerviewowner = self;
  level._id_C2632CE3B62E8E16 = 1;
  level._id_8A919D89CD6129AE = "iw9_";
  level._id_9AA5B3137BD141B4 = "";

  if(isDefined(level.playerconnectedevents)) {
    return;
  }
  level.playerconnectedevents = 1;
  scripts\engine\utility::init_struct_class();
  thread play_fx();
  thread scripts\cp_mp\frontendutils::setup_rarity_ui_images();
  thread _id_B5F3DDB65D04E2FD();
  thread _id_118645267F63501D();
  thread _id_76EF0B0EB3E55129();
  scripts\cp_mp\frontendutils::initialize_transition_array();
  scripts\cp_mp\frontendutils::_id_E7F97D640F18B510();
  scripts\cp_mp\frontendutils::_id_B7807AB9EFBE2177();
  self enablephysicaldepthoffieldscripting();
  wait 0.5;
  _id_425BC62DF4C0DE8E::main();
  _id_6D7F02B97798B6D4::main();
}

callback_frontendplayerconnect() {
  thread onplayerconnectrunonce();
  thread scripts\cp_mp\frontendutils::frontend_camera_watcher(scripts\cp_mp\frontendutils::camera_section_change);
  thread scripts\cp_mp\frontendutils::epictauntlistener();
  thread scripts\cp_mp\frontendutils::luinotifylistener();

  if(getdvarint("dvar_0E809FCAE6B0D1D5", 1))
    thread _id_387376C964B87290::_id_C1B99BC04C9CFE4A();
}

_id_725EC88952496746() {
  setDvar("dvar_8ABFCBDA995D5AC7", " 0.0 0.0 1.0");
  setDvar("dvar_B18595CA486864B7", "45 10");
  setDvar("dvar_45B0A73A964F330C", 1);
  setDvar("dvar_8ED702D6312A78B0", 2);
  setDvar("dvar_BC82F376D1811FAD", 2);
  setDvar("dvar_B071824130B16C58", 1);
  setDvar("dvar_D58971FC7E97AED6", "1 1");
  setDvar("dvar_8CD1E9B67117A0FF", 0.25);
}

_id_B5F3DDB65D04E2FD() {
  _id_725EC88952496746();
  level._id_28C306C65EF1895F = getEnt("foam_large", "targetname");
  level._id_D55766761A712C2F = getEnt("foam_med", "targetname");
  level._id_6C24151F9005D287 = getEnt("foam_small", "targetname");
  level._id_28C306C65EF1895F show();
  level._id_D55766761A712C2F hide();
  level._id_6C24151F9005D287 hide();

  for(;;) {
    self waittill("luinotifyserver", msg, _id_8B461603A1F825D3);
    setDvar("r_tessellationOverride", 0);

    if(msg == "swap_gun_foam") {
      if(_id_8B461603A1F825D3 == 3) {
        level._id_28C306C65EF1895F show();
        level._id_D55766761A712C2F hide();
        level._id_6C24151F9005D287 hide();
        continue;
      }

      if(_id_8B461603A1F825D3 == 2) {
        level._id_28C306C65EF1895F hide();
        level._id_D55766761A712C2F show();
        level._id_6C24151F9005D287 hide();
        continue;
      }

      if(_id_8B461603A1F825D3 == 1) {
        level._id_28C306C65EF1895F hide();
        level._id_D55766761A712C2F hide();
        level._id_6C24151F9005D287 show();
      }
    }
  }
}

_id_90384E8D6B1996D5() {
  _id_4D53CAFBBD7BF91D = getEnt("shop_character_bg", "targetname");
  level._id_3455211A7FD01921 = spawn("script_model", _id_4D53CAFBBD7BF91D.origin);
  level._id_3455211A7FD01921.angles = _id_4D53CAFBBD7BF91D.angles;
  level._id_A41E68B26A527A29 = _id_4D53CAFBBD7BF91D.origin;
  _id_5E2C7A5A2F9BAB0E = getEnt("shop_bundle_bg", "targetname");
  level._id_2179AABA15B2D35E = spawn("script_model", _id_5E2C7A5A2F9BAB0E.origin);
  level._id_2179AABA15B2D35E.angles = _id_5E2C7A5A2F9BAB0E.angles;
  level._id_96B8921FE92408F1 = _id_5E2C7A5A2F9BAB0E.angles;
  level._id_5AF5EF2A9A52F0CA = _id_5E2C7A5A2F9BAB0E.origin;
}

main() {
  level._id_70AEE737D4082DAF = 1;
  _id_49CA976153B9EE31::main();
  _id_0AC3AC2EF3F9B72C::main();
  _id_425BC62DF4C0DE8E::main();
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  scripts\cp_mp\frontendutils::create_camera_position_list();
  scripts\cp_mp\frontendutils::setup_initial_entities();
  level.transition_interrupted = 0;
  level.showseasonalcontent = getdvarint("dvar_CA079D844E54E73A");
  level.ttlos_suppressasserts = 1;
  level._id_1A2B600A06EC21F4 = _func_1E231FC15FDAB31D();
  _id_2669878CF5A1B6BC::buildweaponmap();
  _id_2669878CF5A1B6BC::buildattachmentmaps();
  _id_2669878CF5A1B6BC::_id_EE4A536A155313B7();
  level.callbackplayerconnect = ::callback_frontendplayerconnect;
  level thread _id_777406E0DD520161();
  level thread _id_90384E8D6B1996D5();
}

_id_118645267F63501D() {
  level.lanetriggers = getEntArray("shooting_range_lane_triggers", "targetname");
  level._id_56AEC0E4292D0F76 = getEnt("shooting_range_room_trigger", "targetname");
  level._id_C19CC64D3F6AEC77 = getEntArray("enemyTarget", "targetname");
  level._id_20E9B9E742A3703F = getEntArray("firingrange_target_1", "targetname");
  level._id_20E9BAE742A37272 = getEntArray("firingrange_target_2", "targetname");
  level._id_20E9BBE742A374A5 = getEntArray("firingrange_target_3", "targetname");
  level._id_B609004A0ECEC80F = scripts\engine\utility::array_combine(level._id_20E9B9E742A3703F, level._id_20E9BAE742A37272, level._id_20E9BBE742A374A5);
  level._id_ACE7BC84ECAC30F5 = 0;

  foreach(_id_4B153956989C9328 in level._id_C19CC64D3F6AEC77) {
    _id_8BE25B38B6CC08EC = scripts\engine\utility::getStructArray(_id_4B153956989C9328.target, "targetname");

    foreach(position in _id_8BE25B38B6CC08EC) {
      switch (position.script_noteworthy) {
        case "lane1":
          _id_4B153956989C9328._id_E4B7AB9A96C7FA45 = position.origin;
          break;
        case "lane2":
          _id_4B153956989C9328._id_E4B7A89A96C7F3AC = position.origin;
          break;
        case "lane3":
          _id_4B153956989C9328._id_E4B7A99A96C7F5DF = position.origin;
          break;
        default:
          break;
      }
    }

    _id_041B356A205C48A9 = getEntArray(_id_4B153956989C9328.target, "targetname");

    foreach(_id_261D5FDEE9F7C760 in _id_041B356A205C48A9) {
      _id_261D5FDEE9F7C760 enablelinkTo();

      if(!isPlayer(_id_261D5FDEE9F7C760))
        _id_261D5FDEE9F7C760 linkTo(_id_4B153956989C9328);
    }
  }

  foreach(light in level._id_B609004A0ECEC80F)
  light._id_86102E35E838B321 = light getlightintensity();

  thread _id_BA26A4BCB29225CB("lane1");

  foreach(trig in level.lanetriggers) {
    trig._id_27654D98D67BCCC8 = 0;
    trig thread _id_2E13E46E49665ACB();
  }

  setomnvar("ui_firing_range_lane", -1);
  setomnvar("ui_firing_range_target_kill_count", 0);
}

_id_2E13E46E49665ACB() {
  for(;;) {
    if(!self._id_27654D98D67BCCC8) {
      self waittill("trigger");
      thread _id_F18749DDFEF7D6C0(self.script_noteworthy);
      thread _id_BA26A4BCB29225CB(self.script_noteworthy);

      foreach(trig in level.lanetriggers)
      trig._id_27654D98D67BCCC8 = 0;

      self._id_27654D98D67BCCC8 = 1;
      setomnvar("ui_firing_range_target_kill_count", 0);
      setomnvar("ui_firing_range_accuracy", 0.0);
      level._id_91D278FB245D797B = 0;
      level._id_37A55ECAF979D920 = 0;
      level._id_EDCA0E3497F3463F = 0;
      level._id_FEBC1F5F6FC40F70 = 0;
      continue;
    }

    wait 1;
  }
}

_id_BA26A4BCB29225CB(lane) {
  foreach(light in level._id_B609004A0ECEC80F)
  light setlightintensity(0);

  level._id_ACE7BC84ECAC30F5++;
  thread _id_13B3C42528A8FD7C();
  wait 1.5;

  if(level._id_ACE7BC84ECAC30F5 < 2) {
    switch (lane) {
      case "lane1":
        foreach(light in level._id_20E9B9E742A3703F)
        light setlightintensity(light._id_86102E35E838B321);

        break;
      case "lane2":
        foreach(light in level._id_20E9BAE742A37272)
        light setlightintensity(light._id_86102E35E838B321);

        break;
      case "lane3":
        foreach(light in level._id_20E9BBE742A374A5)
        light setlightintensity(light._id_86102E35E838B321);

        break;
      default:
        break;
    }
  }

  level._id_ACE7BC84ECAC30F5--;
}

_id_13B3C42528A8FD7C() {
  level notify("lights_toggle_sfx");
  level endon("lights_toggle_sfx");
  wait 1.5;
  playsoundatpos((-6775, -3468, 80), "uin_firingrange_light_on");
}

_id_F18749DDFEF7D6C0(_id_762114A68005AF12) {
  level._id_37A55ECAF979D920 = 0;
  level._id_91D278FB245D797B = 0;
  level._id_FEBC1F5F6FC40F70 = 0;
  level._id_EDCA0E3497F3463F = 0;
  setomnvar("ui_firing_range_target_kill_count", 0);
  setomnvar("ui_firing_range_accuracy", 0.0);

  switch (_id_762114A68005AF12) {
    case "lane1":
      setomnvar("ui_firing_range_lane", 1);
      break;
    case "lane2":
      setomnvar("ui_firing_range_lane", 2);
      break;
    case "lane3":
      setomnvar("ui_firing_range_lane", 3);
      break;
    default:
      setomnvar("ui_firing_range_lane", -1);
      break;
  }

  foreach(_id_4B153956989C9328 in level._id_C19CC64D3F6AEC77) {
    switch (_id_762114A68005AF12) {
      case "lane1":
        if(istrue(_id_4B153956989C9328._id_9A74C6FBE0CF64EB))
          _id_4B153956989C9328 thread _id_65CC3CB6946266D8(_id_4B153956989C9328._id_E4B7AB9A96C7FA45);
        else
          _id_4B153956989C9328 thread _id_38D5B2330D87313E(_id_4B153956989C9328._id_E4B7AB9A96C7FA45);

        break;
      case "lane2":
        if(istrue(_id_4B153956989C9328._id_9A74C6FBE0CF64EB))
          _id_4B153956989C9328 thread _id_65CC3CB6946266D8(_id_4B153956989C9328._id_E4B7A89A96C7F3AC);
        else
          _id_4B153956989C9328 thread _id_38D5B2330D87313E(_id_4B153956989C9328._id_E4B7A89A96C7F3AC);

        break;
      case "lane3":
        if(istrue(_id_4B153956989C9328._id_9A74C6FBE0CF64EB))
          _id_4B153956989C9328 thread _id_65CC3CB6946266D8(_id_4B153956989C9328._id_E4B7A99A96C7F5DF);
        else
          _id_4B153956989C9328 thread _id_38D5B2330D87313E(_id_4B153956989C9328._id_E4B7A99A96C7F5DF);

        break;
    }
  }
}

_id_76EF0B0EB3E55129() {
  loc = (-3064, 3048, 64);

  if(!isDefined(level._id_59B5FE4C717CAC88)) {
    level._id_59B5FE4C717CAC88 = spawn("script_model", loc);
    level._id_59B5FE4C717CAC88 setModel("mp_frontend_iw9_weapon_false_sky");
  }
}

_id_38D5B2330D87313E(position) {
  self moveTo(position, 1.5, 0.25, 0.5);

  if(self.origin != position)
    thread _id_E9618A25A1C711D0();

  currenttime = gettime();
  endtime = currenttime + 1500;

  while(currenttime < endtime) {
    currenttime = gettime();

    if(istrue(self._id_9A74C6FBE0CF64EB)) {
      thread _id_65CC3CB6946266D8(position);
      break;
    }

    wait 0.1;
  }
}

_id_65CC3CB6946266D8(position) {
  self notify("move_dummy");
  self endon("delete");
  self endon("move_dummy");

  while(istrue(self._id_9A74C6FBE0CF64EB))
    waitframe();

  self moveTo(position, 1.5, 0.25, 0.5);

  if(self.origin != position)
    thread _id_E9618A25A1C711D0();
}

_id_E9618A25A1C711D0() {
  self playSound("uin_firingrange_target_move");
}

play_fx() {
  waitframe();
  level.frontendfx = [];
  wait 0.5;
}

endlesslobbyfloor() {
  wait 0.1;
  _id_E1090EABDB435850 = getEnt("mp_lobby_floor_01", "targetname");
  _id_D84BA0BFD9897989 = getEntArray("floor_01_clutter", "targetname");
  _id_E10911ABDB435EE9 = getEnt("mp_lobby_floor_02", "targetname");
  _id_80ACB33EE101DD52 = getEntArray("floor_02_clutter", "targetname");

  foreach(_id_0686BE50F6D1395A in _id_D84BA0BFD9897989)
  _id_0686BE50F6D1395A linkTo(_id_E1090EABDB435850);

  foreach(_id_0686BE50F6D1395A in _id_80ACB33EE101DD52)
  _id_0686BE50F6D1395A linkTo(_id_E10911ABDB435EE9);

  _id_0EC1EDA9F068079F = _id_E1090EABDB435850.origin;
  _id_295832D2FC0E963C = _id_E10911ABDB435EE9.origin;
  dist = distance(_id_0EC1EDA9F068079F, _id_295832D2FC0E963C);
  speed = 36.96;
  time = dist / speed;
  _id_C9E915E56C1B6170 = _id_0EC1EDA9F068079F + vectorNormalize(_id_0EC1EDA9F068079F - _id_295832D2FC0E963C) * dist;
  _id_9702326CF645545F = 1;

  for(;;) {
    if(_id_9702326CF645545F) {
      _id_E10911ABDB435EE9 hide();
      _id_E10911ABDB435EE9.origin = _id_E10911ABDB435EE9.origin + (0, 0, -200);
      waitframe();
      _id_E10911ABDB435EE9.origin = _id_295832D2FC0E963C + (0, 0, -200);
      waitframe();
      _id_E10911ABDB435EE9.origin = _id_295832D2FC0E963C;
      _id_E10911ABDB435EE9 show();
      _id_E10911ABDB435EE9 moveTo(_id_0EC1EDA9F068079F, time);
      _id_E1090EABDB435850 moveTo(_id_C9E915E56C1B6170, time);
    } else {
      _id_E1090EABDB435850 hide();
      _id_E1090EABDB435850.origin = _id_E1090EABDB435850.origin + (0, 0, -500);
      waitframe();
      _id_E1090EABDB435850.origin = _id_295832D2FC0E963C + (0, 0, -500);
      waitframe();
      _id_E1090EABDB435850.origin = _id_295832D2FC0E963C;
      _id_E1090EABDB435850 show();
      _id_E1090EABDB435850 moveTo(_id_0EC1EDA9F068079F, time);
      _id_E10911ABDB435EE9 moveTo(_id_C9E915E56C1B6170, time);
    }

    _id_9702326CF645545F = !_id_9702326CF645545F;
    wait(time);
  }
}

_id_777406E0DD520161() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_5762AC2F22202BA2::_id_6B5E33C2F005F4A6();
  level.course_triggers = getEntArray("progression", "targetname");
  _id_B73C05F4BABD6B8E();
  level.course_targets = gettargetarray();
  level.civilian_targets = [];
  level.enemy_targets = [];

  foreach(_id_B8E70FF71A02E32D in level.course_triggers)
  _id_B8E70FF71A02E32D thread trial_trigger_think();

  foreach(_id_B8E70FF71A02E32D in level.course_targets)
  _id_B8E70FF71A02E32D thread _id_2C304F9C3C96CD70();

  level._id_F350D6BEB0D98524 = level.civilian_targets.size;
  level._id_BF2546E3156DB5D9 = level.enemy_targets.size;
}

_id_2C304F9C3C96CD70() {
  self.initial_forward = anglesToForward(self.angles);
  self.initial_up = anglestoup(self.angles);
  self.initial_right = anglestoright(self.angles);

  if(!isDefined(level.targets_thinking))
    level.targets_thinking = 0;

  level.targets_thinking++;
  self.down_angles = self.angles;
  self.parts = getEntArray(self.script_linkname, "script_linkto");
  self.parts = scripts\engine\utility::array_remove(self.parts, self);

  foreach(part in self.parts) {
    switch (part.script_noteworthy) {
      case "target_plate":
        self.plate = part;
        break;
      case "target_plate_dest":
        self.plate = part;
        self.plate_dest = part;
        break;
      case "target_arm":
        self.arm = part;
        break;
      case "target_base":
        self.base = part;
        break;
      case "target_wheels":
        self.wheels = part;
        break;
      case "target_aim_assist":
        self.aim_assist = part;
        break;
      case "target_collision":
        self.collision = part;
        break;
      case "target_collision_down":
        self.collision_down = part;
        break;
      case "target_collision_up":
        self.collision_up = part;
        break;
      default:
        break;
    }

    part.target = "null";
    part.targetname = "null";
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

  if(issubstr(self.script_noteworthy, "civilian")) {
    self.is_civilian = 1;
    level.civilian_targets[level.civilian_targets.size] = self;
  } else {
    self.is_civilian = 0;
    level.enemy_targets[level.enemy_targets.size] = self;
  }

  thread trial_target_think();
}

trial_target_think() {
  self notify("trial_target_think");
  self endon("trial_target_think");
  self.state_up = 0;
  self.flipping = 0;
  thread trial_target_damage();

  if(isDefined(self.plate_dest))
    thread trial_target_arm_damage();

  self.activated = 0;
  thread trial_target_requisites();

  if(issubstr(self.script_noteworthy, "moving"))
    thread trial_moving_target_think();

  if(isDefined(level.trial_target_think_func))
    self[[level.trial_target_think_func]]();

  if(isDefined(level.trial_target_thread_func))
    self thread[[level.trial_target_thread_func]]();

  level.targets_thinking--;
}

gettargetarray() {
  _id_3CA8A977F230716E = ["standard_target", "standard_target_180", "standard_target_civilian", "lean_target", "lean_target_civilian", "moving_target", "moving_target_civilian"];
  _id_53EE9B445DE3B69B = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3CA8A977F230716E.size; _id_AC0E594AC96AA3A8++) {
    _id_15684233DC41D60A[_id_AC0E594AC96AA3A8] = scripts\engine\utility::getStructArray(_id_3CA8A977F230716E[_id_AC0E594AC96AA3A8], "script_noteworthy");

    foreach(struct in _id_15684233DC41D60A[_id_AC0E594AC96AA3A8]) {
      ent = spawn("script_origin", struct.origin);
      ent.angles = struct.angles;
      ent.script_gameobjectname = struct.script_gameobjectname;
      ent.script_linkname = struct.script_linkname;
      ent.script_noteworthy = struct.script_noteworthy;
      ent.target = struct.target;
      ent.targetname = struct.targetname;
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3CA8A977F230716E.size; _id_AC0E594AC96AA3A8++)
    _id_53EE9B445DE3B69B[_id_AC0E594AC96AA3A8] = getEntArray(_id_3CA8A977F230716E[_id_AC0E594AC96AA3A8], "script_noteworthy");

  return scripts\engine\utility::array_combine_multiple(_id_53EE9B445DE3B69B);
}

trial_target_damage() {
  self notify("trial_target_damage");
  self endon("trial_target_damage");
  _id_8C44BF99399EDF9A = undefined;

  if(isDefined(self.plate_dest)) {
    _id_C7D805274B12EF6A = "trial_sfx_target_report_clay_smash";
    _id_8C44BF99399EDF9A = level.impact_vfx;
  } else
    _id_C7D805274B12EF6A = "trial_sfx_target_report_metal_light";

  for(;;) {
    self.activated = 0;

    while(self.state_up == 0)
      waitframe();

    self.plate waittill("damage", _id_8BBC2903A2793B49, attacker, dir, point, type, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);

    if(self.is_civilian == 1)
      level.playerviewowner thread trial_hitmarker(self, 0, 1, 0);
    else
      level.playerviewowner thread trial_hitmarker(self, 1, 0, 0);

    self.activated = 1;

    if(type == "MOD_MELEE")
      level.playerviewowner notify("fake_weapon_fired");

    if(self.is_civilian)
      level._id_F350D6BEB0D98524--;
    else {
      level._id_BF2546E3156DB5D9--;

      if(level._id_BF2546E3156DB5D9 == 0) {
        foreach(door in level._id_F3809FD379F33883) {
          door scriptabledoorfreeze(0);
          door scriptabledooropen("away", level._id_4A2D1176B91B8818.origin);
        }
      }
    }

    if(self.is_civilian && isDefined(level.trial_target_civilian_killed_func))
      self[[level.trial_target_civilian_killed_func]]();
    else if(isDefined(level.trial_target_enemy_killed_func))
      self[[level.trial_target_enemy_killed_func]]();

    if(isDefined(level.trial_target_headshot_func) && self.plate tagexists("tag_head") && distance(self.plate gettagorigin("tag_head"), point) <= 5)
      self[[level.trial_target_headshot_func]]();

    if(isDefined(_id_8C44BF99399EDF9A))
      playFX(_id_8C44BF99399EDF9A, point);

    if(isDefined(self.plate_dest)) {
      self.plate_dest hide();
      wait(randomfloatrange(0.7, 1));
    }

    thread trial_target_flip("down");
    level waittill("course_ended");

    if(isDefined(self.plate_dest)) {
      for(;;) {
        level.playerviewowner waittill("luinotifyserver", msg);

        if(msg == "trial_retry")
          return;
      }

      self.plate_dest show();
    }
  }
}

trial_target_flip(_id_F1118C1A072B6415) {
  if(_id_F1118C1A072B6415 == "up") {
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
    sign = 1;
  } else {
    self.plate setCanDamage(0);

    if(isDefined(self.aim_assist))
      self.aim_assist _meth_ F807A01ED0CF8EB();

    if(isDefined(self.collision_up))
      self.collision_up notsolid();

    if(isDefined(self.collision_down))
      self.collision_up solid();

    if(self.state_up == 0) {
      return;
    }
    self.state_up = 0;
    sign = -1;
  }

  time = undefined;
  _id_8BC14603A27FA3E7 = undefined;

  switch (self.script_noteworthy) {
    case "moving_target_civilian":
    case "moving_target":
    case "standard_target_civilian":
    case "standard_target":
      _id_8BC14603A27FA3E7 = 90;
      time = 0.2;
      break;
    case "lean_target_civilian":
    case "lean_target":
      _id_8BC14603A27FA3E7 = 30;
      time = 0.15;
      break;
    case "standard_target_180":
      _id_8BC14603A27FA3E7 = 180;
      time = 0.4;
      break;
    default:
      _id_8BC14603A27FA3E7 = 90;
      time = 0.2;
      break;
  }

  self.flipping = 1;

  if(issubstr(self.script_noteworthy, "moving"))
    waitframe();

  if(_id_F1118C1A072B6415 == "up") {}

  if(self.initial_right[2] != 0)
    self rotateYaw(-1 * self.initial_right[2] * _id_8BC14603A27FA3E7 * sign, time);
  else
    self rotatepitch(_id_8BC14603A27FA3E7 * sign, time);

  wait(time);

  if(_id_F1118C1A072B6415 == "down") {
    waitframe();
    self.angles = self.down_angles;
  }

  self.flipping = 0;
}

trial_moving_target_think() {
  self notify("trial_moving_target_think");
  self endon("trial_moving_target_think");

  if(!isDefined(self.mover))
    self.mover = scripts\engine\utility::getclosest(self.origin, level.course_movers, 32);

  if(!isDefined(self.mover)) {
    return;
  }
  if(!isDefined(self.mover_ends)) {
    self.mover_ends = scripts\engine\utility::getStructArray(self.mover.targetname, "target");
    self.mover_ends = sortbydistance(self.mover_ends, self.mover.origin);
    _id_100D5996E00840FB = self.mover.origin - self.origin;
    self.mover.origin = self.mover.origin + _id_100D5996E00840FB;
    self.mover_ends[0].origin = self.mover_ends[0].origin + _id_100D5996E00840FB;
    self.mover_ends[1].origin = self.mover_ends[1].origin + _id_100D5996E00840FB;
  }

  self.moveforward = 1;
  self.moving = 0;

  if(isDefined(self.script_speed))
    self.move_speed = self.script_speed;
  else
    self.move_speed = 32;

  level waittill("player_spawned");
  thread trial_moving_target_reset();

  for(;;) {
    if(self.moving && (90 > distance(level.playerviewowner.origin, self.origin) || !self.state_up)) {
      self notify("stop_moving");
      self.moving = 0;
      self.dummy delete();
      self.dummy thread scripts\engine\utility::stop_loop_sound_on_entity("trial_sfx_target_move_loop");
    } else if(self.flipping == 0 && self.moving == 0 && 90 < distance(level.playerviewowner.origin, self.origin) && self.state_up == 1)
      thread trial_moving_target_mover();

    waitframe();
  }
}

trial_moving_target_mover() {
  self endon("stop_moving");
  self.moving = 1;
  self.dummy = spawn("script_origin", self.origin);
  childthread trial_target_follow_dummy();
  self.dummy thread scripts\engine\utility::play_loop_sound_on_entity("trial_sfx_target_move_loop");

  for(;;) {
    _id_6B8A3F291F2D537E = self.mover_ends[self.moveforward];
    dist = distance(self.dummy.origin, _id_6B8A3F291F2D537E.origin);
    time = dist / self.move_speed;
    accel = 0.5;
    accel = clamp(accel, 0, time / 2);
    self.dummy moveTo(_id_6B8A3F291F2D537E.origin, time, accel, accel);
    wait(time);
    self.moveforward = !self.moveforward;
  }
}

trial_moving_target_reset() {
  for(;;) {
    level waittill("trial_results_screen_opened");
    waitframe();
    self.origin = self.mover.origin;
    self.base.origin = self.mover.origin;
    self.moveforward = 1;
  }
}

trial_target_follow_dummy() {
  for(;;) {
    self.origin = self.dummy.origin;
    self.base.origin = self.dummy.origin;
    waitframe();
  }
}

trial_target_arm_damage() {
  self notify("trial_target_arm_damage");
  self endon("trial_target_arm_damage");
  self.arm setCanDamage(1);

  for(;;) {
    self.arm waittill("damage", _id_8BBC2903A2793B49, attacker, dir, point, type, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);

    if(type == "MOD_EXPLOSIVE" || type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" && istrue(self.state_up))
      self.plate dodamage(1, self.plate.origin);
  }
}

trial_target_requisites() {
  self notify("trial_target_requisites");
  self endon("trial_target_requisites");
  waitframe();

  if(isDefined(self.targetname))
    _id_CFCCD3537CE10957 = getEntArray(self.targetname, "target");
  else
    _id_CFCCD3537CE10957 = [];

  for(;;) {
    _id_EC8A7173E0C630FB = 1;

    foreach(_id_27EE92A77AFE203E in _id_CFCCD3537CE10957) {
      if(_id_27EE92A77AFE203E.activated == 0)
        _id_EC8A7173E0C630FB = 0;
    }

    if(_id_EC8A7173E0C630FB == 1) {
      trial_target_flip("up");
      level waittill("course_ended");
    }

    waitframe();
  }
}

trial_trigger_think() {
  self notify("trial_trigger_think");
  self endon("trial_trigger_think");
  _id_761C3A588103E918 = getEntArray("end_checkpoint", "script_noteworthy");

  for(;;) {
    self.activated = 0;

    while(!isDefined(level.playerviewowner))
      waitframe();

    if(isDefined(self.script_noteworthy)) {
      if(self.script_noteworthy != "start")
        level waittill("course_started");
    } else
      level waittill("course_started");

    while(level.playerviewowner istouching(self))
      waitframe();

    if(isDefined(self.script_noteworthy) && self.script_noteworthy == "end") {
      for(;;) {
        self waittill("trigger");

        if(all_end_checkpoints_activated(_id_761C3A588103E918)) {
          break;
        }
      }
    } else
      self waittill("trigger");

    self.activated = 1;
    level notify("trigger_activated");

    if(isDefined(level.trial_trigger_activated_func))
      self[[level.trial_trigger_activated_func]]();

    level waittill("course_ended");
  }
}

all_end_checkpoints_activated(_id_761C3A588103E918) {
  foreach(checkpoint in _id_761C3A588103E918) {
    if(!checkpoint.activated)
      return 0;
  }

  return 1;
}

trial_hitmarker(_id_F182D284B07A828E, _id_B3990D56E2779F79, iscivilian, _id_942B8C491D5D7BD1) {
  if(!isDefined(_id_B3990D56E2779F79))
    _id_B3990D56E2779F79 = 0;

  if(!isDefined(iscivilian))
    iscivilian = 0;

  if(!isDefined(_id_942B8C491D5D7BD1))
    _id_942B8C491D5D7BD1 = 0;

  alias = getDvar("snd_hitmarker_alias");
  trial_updatehitmarker("standard", _id_B3990D56E2779F79, 0, iscivilian);
}

trial_updatehitmarker(_id_E0EA2C8DF06F13EB, _id_D7198CEB7D51DB5B, headshot, _id_C4F1516C772B1C2D, _id_DC382B1157307F94) {
  if(!isDefined(_id_E0EA2C8DF06F13EB)) {
    return;
  }
  if(!isDefined(_id_D7198CEB7D51DB5B))
    _id_D7198CEB7D51DB5B = 0;

  if(!isDefined(headshot))
    headshot = 0;

  if(!isDefined(_id_C4F1516C772B1C2D))
    _id_C4F1516C772B1C2D = 0;

  priority = trial_gethitmarkerpriority(_id_E0EA2C8DF06F13EB);

  if(isDefined(self.lasthitmarkertime) && self.lasthitmarkertime == gettime() && priority <= self.lasthitmarkerpriority && !_id_D7198CEB7D51DB5B) {
    return;
  }
  self.lasthitmarkertime = gettime();
  self.lasthitmarkerpriority = priority;

  if(isDefined(_id_DC382B1157307F94) && !istrue(_id_D7198CEB7D51DB5B)) {
    self setclientomnvar("damage_feedback_icon", _id_DC382B1157307F94);
    self setclientomnvar("damage_feedback_icon_notify", gettime());
  }

  self setclientomnvar("damage_feedback", _id_E0EA2C8DF06F13EB);
  self setclientomnvar("damage_feedback_notify", gettime());

  if(_id_D7198CEB7D51DB5B)
    self setclientomnvar("damage_feedback_kill", 1);
  else
    self setclientomnvar("damage_feedback_kill", 0);

  if(headshot)
    self setclientomnvar("damage_feedback_headshot", 1);
  else
    self setclientomnvar("damage_feedback_headshot", 0);

  if(_id_C4F1516C772B1C2D)
    self setclientomnvar("damage_feedback_nonplayer", 1);
  else
    self setclientomnvar("damage_feedback_nonplayer", 0);
}

trial_gethitmarkerpriority(_id_B98146816886D3C4) {
  if(!isDefined(level.hitmarkerpriorities[_id_B98146816886D3C4]))
    return 0;

  return level.hitmarkerpriorities[_id_B98146816886D3C4];
}

_id_966B1E7BAB387462() {
  for(;;) {
    waitframe();

    if(getdvarint("dvar_F427DF4858AF05FE", 0) != 0) {
      foreach(_id_B8E70FF71A02E32D in level.course_triggers)
      _id_B8E70FF71A02E32D thread trial_trigger_think();

      foreach(_id_B8E70FF71A02E32D in level.course_targets) {
        _id_B8E70FF71A02E32D trial_target_flip("down");
        _id_B8E70FF71A02E32D thread trial_target_think();
      }

      level thread _id_9F7978A6A0C46C0B();
    }

    if(getdvarint("door_test", 0) != 0) {
      foreach(door in level._id_2AAAB671AEF7CDC6)
      door scriptabledooropen("away", level._id_A7BA750765D34CA9.origin);
    }
  }
}

_id_B73C05F4BABD6B8E() {
  level._id_A7BA750765D34CA9 = undefined;
  level._id_4A2D1176B91B8818 = undefined;
  level._id_2AAAB671AEF7CDC6 = [];
  level._id_F3809FD379F33883 = [];

  foreach(trigger in level.course_triggers) {
    if(isDefined(trigger.script_noteworthy)) {
      if(trigger.script_noteworthy == "start") {
        level._id_A7BA750765D34CA9 = trigger;
        level._id_2AAAB671AEF7CDC6 = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(trigger.origin, 512, 1000);
        continue;
      }

      if(trigger.script_noteworthy == "end") {
        level._id_4A2D1176B91B8818 = trigger;
        level._id_F3809FD379F33883 = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(trigger.origin, 512, 1000);
      }
    }
  }
}

_id_9F7978A6A0C46C0B() {
  while(!isDefined(level._id_A7BA750765D34CA9) || !isDefined(level._id_4A2D1176B91B8818))
    waitframe();

  level._id_A7BA750765D34CA9 notify("monitorStartTrigger");
  level._id_A7BA750765D34CA9 endon("monitorStartTrigger");

  foreach(door in level._id_2AAAB671AEF7CDC6)
  door scriptabledoorclose();

  foreach(door in level._id_F3809FD379F33883) {
    door scriptabledoorclose();
    door scriptabledoorfreeze(1);
  }

  level._id_A7BA750765D34CA9 waittill("trigger");

  foreach(door in level._id_2AAAB671AEF7CDC6)
  door scriptabledooropen("away", level._id_A7BA750765D34CA9.origin);

  level._id_915231E52D22D349 = 1;
  level notify("course_started");
  starttime = gettime();
  level._id_4A2D1176B91B8818 waittill("trigger");
  _id_E0BA1A2E8FFB8E1E = (gettime() - starttime) / 1000;
  level.playerviewowner iprintlnbold("MOUT Course Time: " + _id_E0BA1A2E8FFB8E1E);
  level thread _id_9F7978A6A0C46C0B();
}