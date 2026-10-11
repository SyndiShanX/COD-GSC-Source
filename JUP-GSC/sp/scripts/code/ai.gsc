/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\code\ai.gsc
***********************************************/

#namespace ai;

function free_expendable() {
  if(!isDefined(self.spawner) || !isDefined(self.script_suspend)) {
    return;
  }

  spawner = self.spawner;
  struct = spawnStruct();
  struct.origin = self.origin;
  struct.angles = self.angles;
  struct.suspendtime = gettime();

  if(isDefined(self.suspendvars)) {
    struct.suspendvars = self.suspendvars;
  } else {
    struct.suspendvars = spawnStruct();
  }

  if(isDefined(self.stealth)) {
    struct.stealth = spawnStruct();
    struct.stealth.bsmstate = self.stealth_bsmstate;

    if(isDefined(self.var_743f5eeb386835f5)) {
      struct.stealth.investigateevent = self[[self.var_743f5eeb386835f5]]();
    }
  }

  if(isDefined(self.node)) {
    if(isDefined(self.using_goto_node)) {
      if(isDefined(self.node.targetname)) {
        struct.target = self.node.targetname;
      }

      struct.node = self.node;
    }

    struct.target = self.node.targetname;
  }

  spawner.suspended_ai = struct;

  if(isDefined(self.script_suspend_group) && !isDefined(self.script_free)) {
    free_groupname(self.script_suspend_group);
  }

  spawner thread function_1ef621491ffaeede();
}

function free_groupname(groupname) {
  if(!isDefined(level.processfreegroupname)) {
    level.processfreegroupname = [];
  }

  if(isDefined(level.processfreegroupname[groupname])) {
    return;
  }

  level.processfreegroupname[groupname] = 1;
  aiarray = getaiarray();

  foreach(ai in aiarray) {
    if(ai == self) {
      continue;
    }

    if(!isDefined(ai.script_suspend_group)) {
      continue;
    }

    if(ai.script_suspend_group != groupname) {
      continue;
    }

    ai.script_free = 1;
    ai free_expendable();
    println("<dev string:x1c>" + groupname + "<dev string:x2e>" + ai.origin);
    ai delete();
  }

  level.processfreegroupname[groupname] = undefined;
}

function function_1ef621491ffaeede(spawner) {
  self endon("<dev string:x38>");

  if(!isDefined(level.func)) {
    return;
  }

  if(!isDefined(level.func["<dev string:x3e>"])) {
    return;
  }

  while(true) {
    waitframe();

    if(!isDefined(self.suspended_ai)) {
      return;
    }

    if(getdvarint(@ "hash_6efeeea168f0a561") == 0) {
      continue;
    }

    [[level.func["<dev string:x3e>"]]](self.suspended_ai.origin, self.suspended_ai.angles, (1, 0.5, 0.25));
  }
}

function create_weapon_in_script(weaponarray, weaponposition) {
  if(!isDefined(level.fnscriptedweaponassignment)) {
    self.usescriptedweapon = undefined;

    if(!isDefined(weaponarray)) {
      weapon = nullweapon();
    } else if(!isarray(weaponarray) && weaponarray == "") {
      weapon = nullweapon();
    } else if(isarray(weaponarray)) {
      weapon = makeweapon(weaponarray[randomint(weaponarray.size)]);
    } else {
      weapon = makeweapon(weaponarray);
    }

    if(!isnullweapon(weapon)) {
      self.scriptedweaponfailed = 1;

      if(isDefined(weaponposition) && weaponposition == "sidearm") {
        self.scriptedweaponfailed_sidearmarray = weaponarray;
      } else {
        self.scriptedweaponfailed_primaryarray = weaponarray;
      }
    }

    println("<dev string:x4b>" + self getentitynumber() + "<dev string:x82>" + getweaponbasename(weapon));
    return weapon;
  }

  return [[level.fnscriptedweaponassignment]](weaponarray, weaponposition);
}

function stealth_callback(callbackname, ai, param1, param2, param3, param4) {
  result = undefined;

  if(isDefined(level.stealth.var_e376d807bb8ce93b)) {
    result = ai[[level.stealth.var_e376d807bb8ce93b]](callbackname, param1, param2, param3, param4);
  }

  return istrue(result);
}

function function_9aead378ca03cb28(charactertype, position, dormantindex) {
  if(isDefined(level.var_74e9c02b56e4ba52)) {
    [[level.var_74e9c02b56e4ba52]](charactertype, position, dormantindex);
  }
}

function dormant_callback(ent, dormantindex) {
  if(isDefined(level.var_8a42b71f799936ad)) {
    [[level.var_8a42b71f799936ad]](ent, dormantindex);
  }
}

function function_d5ee270afc41e925(dormantindex) {
  if(isDefined(level.var_19ef4572543c12c1)) {
    return [[level.var_19ef4572543c12c1]](dormantindex);
  }

  return 1;
}

function function_8ff6b395c2615881(callbackname, requestid, data) {
  if(isDefined(level.var_3ae5f7de11d142f)) {
    return [[level.var_3ae5f7de11d142f]](callbackname, requestid, data);
  }
}

function function_2c18f4deacb75a6d(ent, state) {
  if(isDefined(ent.var_82420c8df7f30a5b)) {
    ent thread[[ent.var_82420c8df7f30a5b]](state);
  }
}

function function_2392636ed67e9fed() {}

function function_56543479237033c3() {
  return &function_2392636ed67e9fed;
}

function function_74939cb3d7c3057b() {
  function_87dc2db63d1cfe13();
}

function function_87dc2db63d1cfe13() {
  if(true) {
    ai_cornercheck_behaviors_default = spawnStruct();
    ai_cornercheck_behaviors_default.m_specs[0] = spawnStruct();
    ai_cornercheck_behaviors_default.m_specs[0].name = "default";
    ai_cornercheck_behaviors_default.m_specs[0].query = spawnStruct();
    obj = ai_cornercheck_behaviors_default.m_specs[0].query;
    obj.var_9efb032663ad97c1[0] = 64;
    obj.var_3d5cc1a409a98fd0 = 300;
    obj.var_63173b6856e415e7 = 130;
    obj.var_94cf3022fca2b151 = 200;
    ai_cornercheck_behaviors_default.m_specs[0].combined[0] = spawnStruct();
    obj = ai_cornercheck_behaviors_default.m_specs[0].combined[0];
    obj.types = "aim_only";
    obj.decelwindow = spawnStruct();
    obj.decelwindow.speed = 80;
    obj.decelwindow.types = "aim_only";
    obj.action = spawnStruct();
    obj.action.var_c84c06a4463ee99c = 24;
    obj.action.var_d40d255ab3b9623b = 90;
    obj.action.var_fb95ad1022e86854 = 90;
    obj.action.var_1373755bb3b8c41 = 32;
    obj.validation = spawnStruct();
    obj.validation.var_d1e64a8da97c5f9a = 170;
    obj.validation.var_d40d255ab3b9623b = 70;
    obj.validation.var_fb95ad1022e86854 = 70;
    obj.validation.var_1373755bb3b8c41 = 32;
    obj.validation.var_c2866d21d8ade257 = 60;
    obj.validation.var_6af25e49ed56b1cc = 300;
    ai_cornercheck_behaviors_default.m_specs[0].combined[1] = spawnStruct();
    obj = ai_cornercheck_behaviors_default.m_specs[0].combined[1];
    obj.types = "strafe_only";
    obj.decelwindow = spawnStruct();
    obj.decelwindow.speed = 60;
    obj.decelwindow.types = "strafe_only";
    obj.action = spawnStruct();
    obj.action.var_c84c06a4463ee99c = 24;
    obj.action.var_d40d255ab3b9623b = 180;
    obj.action.var_fb95ad1022e86854 = 120;
    obj.action.var_1373755bb3b8c41 = 32;
    obj.action.var_2efd5c4e05ac0023 = 0.5;
    obj.validation = spawnStruct();
    obj.validation.var_d1e64a8da97c5f9a = 170;
    obj.validation.var_d40d255ab3b9623b = 90;
    obj.validation.var_fb95ad1022e86854 = 90;
    obj.validation.var_1373755bb3b8c41 = 32;
    obj.validation.var_c2866d21d8ade257 = 60;
    obj.validation.var_6af25e49ed56b1cc = 200;
    ai_cornercheck_behaviors_default.m_specs[0].combined[2] = spawnStruct();
    obj = ai_cornercheck_behaviors_default.m_specs[0].combined[2];
    obj.types = "shallow";
    obj.decelwindow = spawnStruct();
    obj.decelwindow.speed = 49;
    obj.decelwindow.maxspeedvalid = 75;
    obj.decelwindow.types = "shallow";
    obj.action = spawnStruct();
    obj.action.var_c84c06a4463ee99c = 24;
    obj.action.var_1373755bb3b8c41 = 32;
    obj.animtest = spawnStruct();
    obj.animtest.var_832c9aa8484af5bb = 48;
    obj.validation = spawnStruct();
    obj.validation.var_26e073f24350c158 = 40;
    obj.validation.var_d1e64a8da97c5f9a = 135;
    obj.validation.maxspeed = 50;
    obj.validation.asmstatename = "cautious_shallow_corner_check";
    obj.validation.var_1373755bb3b8c41 = 32;
    ai_cornercheck_behaviors_default.m_specs[0].decelwindows[0] = spawnStruct();
    ai_cornercheck_behaviors_default.m_specs[0].decelwindows[0].types = "shallow";
    ai_cornercheck_behaviors_default.m_specs[0].decelwindows[0].speed = 80;
    ai_cornercheck_behaviors_default.m_specs[0].decelwindows[0].minspeedvalid = 75;
    ai_cornercheck_behaviors_default.m_specs[0].validations[0] = spawnStruct();
    obj = ai_cornercheck_behaviors_default.m_specs[0].validations[0];
    obj.types = "shallow";
    obj.asmstatename = "cornercheck_shallow_fast";
    obj.maxspeed = 90;
    obj.minspeed = 75;
    obj.var_26e073f24350c158 = 40;
    obj.var_d1e64a8da97c5f9a = 135;
    ai_cornercheck_behaviors_default.m_specs[0].var_3951cabc31d342f = 6;
    ai_cornercheck_behaviors_default.m_specs[1] = structcopy(ai_cornercheck_behaviors_default.m_specs[0], 1);
    ai_cornercheck_behaviors_default.m_specs[1].name = "nightwar_start";
    ai_cornercheck_behaviors_default.m_specs[1].allowedtypes = "shallow";
    ai_cornercheck_behaviors_default.m_specs[1].combined[0].visibility = spawnStruct();
    ai_cornercheck_behaviors_default.m_specs[1].combined[0].visibility.var_6bb8b086cbae934 = 0;
    ai_cornercheck_behaviors_default.m_specs[1].combined[0].visibility.var_5f5e6a9e5b0d045f = 0;
    ai_cornercheck_behaviors_default.m_specs[1].combined[1].visibility = spawnStruct();
    ai_cornercheck_behaviors_default.m_specs[1].combined[1].visibility.var_6bb8b086cbae934 = 0;
    ai_cornercheck_behaviors_default.m_specs[1].combined[1].visibility.var_5f5e6a9e5b0d045f = 0;
    ai_cornercheck_behaviors_default.m_specs[1].combined[2].visibility = spawnStruct();
    ai_cornercheck_behaviors_default.m_specs[1].combined[2].visibility.var_6bb8b086cbae934 = 0;
    ai_cornercheck_behaviors_default.m_specs[1].combined[2].visibility.var_5f5e6a9e5b0d045f = 0;
    ai_cornercheck_behaviors_default.m_specs[2] = structcopy(ai_cornercheck_behaviors_default.m_specs[0], 1);
    ai_cornercheck_behaviors_default.m_specs[2].name = "soldier_paranoid";
    obj = ai_cornercheck_behaviors_default.m_specs[2].query;
    obj.var_9efb032663ad97c1[0] = 64;
    obj.var_9efb032663ad97c1[1] = 164;
    obj.var_3d5cc1a409a98fd0 = 300;
    obj.var_63173b6856e415e7 = 130;
    obj.var_94cf3022fca2b151 = 200;
    obj.var_f2801301f3d1c032 = 200;
    obj = ai_cornercheck_behaviors_default.m_specs[2].combined[0];
    obj.validation.var_d1e64a8da97c5f9a = 170;
    obj.validation.var_d40d255ab3b9623b = 70;
    obj.validation.var_fb95ad1022e86854 = 70;
    obj.validation.var_1373755bb3b8c41 = 32;
    obj.validation.var_c2866d21d8ade257 = 60;
    obj.validation.var_6af25e49ed56b1cc = 300;
    obj = ai_cornercheck_behaviors_default.m_specs[2].combined[1];
    obj.validation.var_d1e64a8da97c5f9a = 170;
    obj.validation.var_d40d255ab3b9623b = 90;
    obj.validation.var_fb95ad1022e86854 = 90;
    obj.validation.var_1373755bb3b8c41 = 32;
    obj.validation.var_c2866d21d8ade257 = 60;
    obj.validation.var_6af25e49ed56b1cc = 200;
    ai_cornercheck_behaviors_default.m_specs[3] = structcopy(ai_cornercheck_behaviors_default.m_specs[0], 1);
    ai_cornercheck_behaviors_default.m_specs[3].name = "combat_default";
    ai_cornercheck_behaviors_default.m_specs[3].validations[0].requiretarget = 1;
    obj = ai_cornercheck_behaviors_default.m_specs[3].combined[0];
    obj.decelwindow.types = "";
    obj.validation.requiretarget = 1;
    obj = ai_cornercheck_behaviors_default.m_specs[3].combined[1];
    obj.decelwindow.types = "";
    obj.validation.requiretarget = 1;
    obj = ai_cornercheck_behaviors_default.m_specs[3].combined[2];
    obj.decelwindow.types = "";
    obj.validation.requiretarget = 1;
    addaidatabaseentry("component", ai_cornercheck_behaviors_default, "ai_cornercheck_behaviors", "ai_cornercheck_behaviors_default_script");
  }

  if(true) {
    defaultlookatspec = spawnStruct();
    defaultlookatspec.var_ec5d24a985f94861 = "simple";
    ai_lookat_behaviors_default = spawnStruct();
    ai_lookat_behaviors_default.m_specs[0] = structcopy(defaultlookatspec, 1);
    obj = ai_lookat_behaviors_default.m_specs[0];
    obj.name = "cover_right";
    obj.limit_left = 15;
    obj.limit_right = 30;
    obj.limit_up = 20;
    obj.limit_down = 30;
    ai_lookat_behaviors_default.m_specs[1] = structcopy(defaultlookatspec, 1);
    obj = ai_lookat_behaviors_default.m_specs[1];
    obj.name = "cover_left";
    obj.limit_left = 60;
    obj.limit_right = 15;
    obj.limit_up = 20;
    obj.limit_down = 30;
    ai_lookat_behaviors_default.m_specs[2] = structcopy(defaultlookatspec, 1);
    obj = ai_lookat_behaviors_default.m_specs[2];
    obj.name = "cover_crouch";
    obj.limit_left = 15;
    obj.limit_right = 45;
    obj.limit_up = 20;
    obj.limit_down = 30;
    ai_lookat_behaviors_default.m_specs[3] = structcopy(defaultlookatspec, 1);
    obj = ai_lookat_behaviors_default.m_specs[3];
    obj.name = "exposed";
    obj.limit_left = 45;
    obj.limit_right = 45;
    obj.limit_up = 30;
    obj.limit_down = 30;
    ai_lookat_behaviors_default.m_specs[4] = structcopy(defaultlookatspec, 1);
    obj = ai_lookat_behaviors_default.m_specs[4];
    obj.name = "default";
    obj.limit_left = 60;
    obj.limit_right = 60;
    obj.limit_up = 45;
    obj.limit_down = 45;
    ai_lookat_behaviors_default.m_specs[5] = structcopy(defaultlookatspec, 1);
    obj = ai_lookat_behaviors_default.m_specs[5];
    obj.name = "exposed_aim";
    obj.limit_left = 20;
    obj.limit_right = 20;
    obj.limit_up = 30;
    obj.limit_down = 10;
    ai_lookat_behaviors_default.m_specs[6] = structcopy(ai_lookat_behaviors_default.m_specs[4], 1);
    obj = ai_lookat_behaviors_default.m_specs[6];
    obj.name = "advanced_default";
    obj.var_ec5d24a985f94861 = "advanced_default";
    obj.limit_left = 120;
    obj.limit_right = 120;
    obj.limit_up = 80;
    obj.limit_down = 80;
    ai_lookat_behaviors_default.m_specs[7] = structcopy(defaultlookatspec, 1);
    obj = ai_lookat_behaviors_default.m_specs[7];
    obj.name = "tight_with_player";
    obj.limit_left = 60;
    obj.limit_right = 60;
    obj.limit_up = 45;
    obj.limit_down = 45;
    obj.overridepercent = 100;
    obj.var_6f341aa6029aa6a6 = 0;
    ai_lookat_behaviors_default.m_specs[8] = structcopy(defaultlookatspec, 1);
    obj = ai_lookat_behaviors_default.m_specs[8];
    obj.name = "default_no_spine";
    obj.limit_left = 60;
    obj.limit_right = 60;
    obj.limit_up = 45;
    obj.limit_down = 45;
    obj.var_ece6263298ae714 = 1;
    ai_lookat_behaviors_default.m_specs[9] = structcopy(defaultlookatspec, 1);
    obj = ai_lookat_behaviors_default.m_specs[9];
    obj.name = "animscripted_with_player";
    obj.limit_left = 100;
    obj.limit_right = 100;
    obj.limit_up = 45;
    obj.limit_down = 45;
    obj.var_fe3d05a9f4ea87e = 1;
    obj.var_cb96e471adcd131 = 0;
    addaidatabaseentry("component", ai_lookat_behaviors_default, "ai_lookat_behaviors", "ai_lookat_behaviors_default_script");
  }

  if(true) {
    ai_lookat_anim_mappings_default = spawnStruct();
    ai_lookat_anim_mappings_default.var_21c27c0ac99d29ed[0] = spawnStruct();
    ai_lookat_anim_mappings_default.var_21c27c0ac99d29ed[0].mappedname = "cover_right";
    ai_lookat_anim_mappings_default.var_21c27c0ac99d29ed[0].m_animnames[0] = "cover_right_crouch";
    ai_lookat_anim_mappings_default.var_21c27c0ac99d29ed[0].m_animnames[1] = "cover_right";
    ai_lookat_anim_mappings_default.var_21c27c0ac99d29ed[1] = spawnStruct();
    ai_lookat_anim_mappings_default.var_21c27c0ac99d29ed[1].mappedname = "cover_left";
    ai_lookat_anim_mappings_default.var_21c27c0ac99d29ed[1].m_animnames[0] = "cover_left_crouch";
    ai_lookat_anim_mappings_default.var_21c27c0ac99d29ed[1].m_animnames[1] = "cover_left";
    ai_lookat_anim_mappings_default.var_21c27c0ac99d29ed[2] = spawnStruct();
    ai_lookat_anim_mappings_default.var_21c27c0ac99d29ed[2].mappedname = "cover_crouch";
    ai_lookat_anim_mappings_default.var_21c27c0ac99d29ed[2].m_animnames[0] = "cover_crouch";
    ai_lookat_anim_mappings_default.var_21c27c0ac99d29ed[3] = spawnStruct();
    ai_lookat_anim_mappings_default.var_21c27c0ac99d29ed[3].mappedname = "exposed";
    arr[0] = "cover_right_crouch_stand";
    arr[arr.size] = "cover_right_crouch_exposed_left";
    arr[arr.size] = "cover_right_crouch_exposed_right";
    arr[arr.size] = "cover_left_crouch_stand";
    arr[arr.size] = "cover_left_crouch_exposed_left";
    arr[arr.size] = "cover_left_crouch_exposed_right";
    arr[arr.size] = "cover_left_crouch_exposed_a";
    arr[arr.size] = "cover_left_crouch_exposed_b";
    arr[arr.size] = "cover_right_crouch_exposed_a";
    arr[arr.size] = "cover_right_crouch_exposed_b";
    arr[arr.size] = "cover_left_exposed_a";
    arr[arr.size] = "cover_left_exposed_b";
    arr[arr.size] = "cover_right_exposed_a";
    arr[arr.size] = "cover_right_exposed_b";
    arr[arr.size] = "exposed_idle";
    arr[arr.size] = "cover_stand";
    ai_lookat_anim_mappings_default.var_21c27c0ac99d29ed[3].m_animnames = arr;
    addaidatabaseentry("component", ai_lookat_anim_mappings_default, "ai_lookat_anim_mappings", "ai_lookat_anim_mappings_default_script");
  }

  if(true) {
    ai_jailer_settings_default = spawnStruct();
    ai_jailer_settings_default.m_settings[0] = spawnStruct();
    ai_jailer_settings_default.m_settings[0].name = "default";
    ai_jailer_settings_default.m_settings[0].minaccuracy = getdvarfloat(@ "hash_f8240d5c0c37ac7e", 0.4);
    ai_jailer_settings_default.m_settings[0].maxaccuracy = getdvarfloat(@ "hash_960bb94e318db890", 1.2);
    ai_jailer_settings_default.m_settings[0].walkspeed = 55;
    ai_jailer_settings_default.m_settings[0].jogspeed = 120;
    ai_jailer_settings_default.m_settings[0].runspeed = 200;
    ai_jailer_settings_default.m_settings[0].acceleration = 300;
    ai_jailer_settings_default.m_settings[0].deceleration = -300;
    ai_jailer_settings_default.m_settings[0].var_26e7c5c27c4a71a5 = 200;
    ai_jailer_settings_default.m_settings[0].var_810f84117b47d883 = 300;
    ai_jailer_settings_default.m_settings[0].var_97184e9f093ea3a0 = 550;
    ai_jailer_settings_default.m_settings[0].var_12fa7e4bf627b292 = 700;
    ai_jailer_settings_default.m_settings[0].var_8756726934e12803 = 1000;
    ai_jailer_settings_default.m_settings[0].var_3afd9cf782198639 = 0;
    ai_jailer_settings_default.m_settings[0].stopdistance = 20;
    ai_jailer_settings_default.m_settings[0].jogduration = 1500;
    ai_jailer_settings_default.m_settings[0].var_6358e5c58d47f837 = 1000;
    ai_jailer_settings_default.m_settings[0].chargecooldown = 3000;
    ai_jailer_settings_default.m_settings[0].var_4ab749aad99e7631 = 4000;
    ai_jailer_settings_default.m_settings[0].var_63bc3f012ac7583e = 2000;
    ai_jailer_settings_default.m_settings[0].var_e1283f20324cb7dd = 100;
    ai_jailer_settings_default.m_settings[0].maxsweepduration = 4000;
    ai_jailer_settings_default.m_settings[0].sweepcooldownduration = 10000;
    ai_jailer_settings_default.m_settings[0].clustermaxdist = 512;
    ai_jailer_settings_default.m_settings[0].var_f5f29f48bf54f95e = 0.86;
    ai_jailer_settings_default.m_settings[0].var_e773207de29064c4 = 200;
    ai_jailer_settings_default.m_settings[0].var_73849610029138d6 = 2500;
    ai_jailer_settings_default.m_settings[0].var_e3462e8bcc2c2bbb = 7000;
    ai_jailer_settings_default.m_settings[0].maxburstduration = 8000;
    ai_jailer_settings_default.m_settings[0].var_d6c13152ac9aa81d = 1000;
    ai_jailer_settings_default.m_settings[0].var_ee7e07bdbdae989b = 1250;
    ai_jailer_settings_default.m_settings[0].var_f5d9e4cdce6fc2f9 = 200;
    ai_jailer_settings_default.m_settings[0].var_f23d7d041b2acfb3 = 300;
    ai_jailer_settings_default.m_settings[0].var_fa40aef304cab126 = 600;
    ai_jailer_settings_default.m_settings[0].var_db66dd499f459cda = 50;
    ai_jailer_settings_default.m_settings[0].var_dafbef1cc10672c0 = 100;
    ai_jailer_settings_default.m_settings[0].var_97d83c01d694ebef = 200;
    ai_jailer_settings_default.m_settings[0].var_4ddfc5d089928b41 = 300;
    addaidatabaseentry("component", ai_jailer_settings_default, "ai_jailer_settings", "ai_jailer_settings_default_script");
  }

  if(true) {
    ai_focus_behaviors_default = spawnStruct();
    ai_focus_behaviors_default.var_51112681bd4d019b[0] = spawnStruct();
    behaviorspec = ai_focus_behaviors_default.var_51112681bd4d019b[0];
    behaviorspec.name = "default";
    behaviorspec.var_4b83a6c557f7c86f[0] = spawnStruct();
    obj = behaviorspec.var_4b83a6c557f7c86f[0];
    obj.name = "default";
    obj.var_bcc1548fdc16ad48 = "look_glance";
    obj.var_c749ad488c6d5e09 = "aim_default";
    obj.var_f834d1a05586efc = "default";
    obj.var_b7960a38a0297273 = "default";
    obj.var_1d868cc67f9dd5bb = "default";
    behaviorspec.var_4b83a6c557f7c86f[1] = spawnStruct();
    obj = behaviorspec.var_4b83a6c557f7c86f[1];
    obj.name = "panic";
    obj.var_bcc1548fdc16ad48 = "look_glance";
    obj.var_c749ad488c6d5e09 = "aim_default";
    obj.var_f834d1a05586efc = "default";
    obj.var_b7960a38a0297273 = "default";
    obj.var_1d868cc67f9dd5bb = "default";
    behaviorspec.var_4b83a6c557f7c86f[2] = spawnStruct();
    obj = behaviorspec.var_4b83a6c557f7c86f[2];
    obj.name = "civ_default";
    obj.var_bcc1548fdc16ad48 = "look_glance";
    obj.var_c749ad488c6d5e09 = "aim_default";
    obj.var_f834d1a05586efc = "default";
    obj.var_b7960a38a0297273 = "no_aim";
    obj.var_1d868cc67f9dd5bb = "default";
    behaviorspec.var_89df35098e4c90a2[0] = spawnStruct();
    obj = behaviorspec.var_89df35098e4c90a2[0];
    obj.name = "default";
    obj.var_22366064e4b2b3ff = -1;
    obj.var_22136e64e48c8b11 = -1;
    obj.var_d8306289a5a3547b = 1000;
    obj.var_d80d5889a57cf6c5 = 2000;
    obj.var_2c42dba8ffe8e4d6 = 1500;
    obj.var_2c65cda9000f0dc4 = 3000;
    obj.var_c89e2d1e53b941ee = 1000;
    obj.var_ecbe7a4cf4c2babe = 4000;
    obj.var_ae27a0f08d1cf26d = 1500;
    behaviorspec.var_89df35098e4c90a2[1] = spawnStruct();
    obj = behaviorspec.var_89df35098e4c90a2[1];
    obj.name = "no_aim";
    obj.allowedsources = "none";
    behaviorspec.var_c371c157a0ead74a[0] = spawnStruct();
    obj = behaviorspec.var_c371c157a0ead74a[0];
    obj.name = "default";
    obj.var_22366064e4b2b3ff = 1500;
    obj.var_22136e64e48c8b11 = 3000;
    obj.var_d8306289a5a3547b = 1000;
    obj.var_d80d5889a57cf6c5 = 2000;
    obj.var_2c42dba8ffe8e4d6 = 1500;
    obj.var_2c65cda9000f0dc4 = 3000;
    obj.var_c89e2d1e53b941ee = 500;
    obj.var_ecbe7a4cf4c2babe = 500;
    obj.var_ae27a0f08d1cf26d = 1500;
    behaviorspec.var_c371c157a0ead74a[1] = spawnStruct();
    obj = behaviorspec.var_c371c157a0ead74a[1];
    obj.name = "no_look";
    obj.allowedsources = "none";
    behaviorspec.var_fd50e6db62ce8cc5[0] = spawnStruct();
    obj = behaviorspec.var_fd50e6db62ce8cc5[0];
    obj.name = "look_glance";
    obj.allowedsources = "all";
    obj.var_1550743f6e9673a5 = 60;
    obj.var_15737e3f6ebcd15b = 90;
    obj.anglebias = 10;
    obj.var_e16f134ab2dba426 = 60;
    obj.maxyaw = 90;
    obj.mindistance = 0;
    obj.maxdistance = 9999;
    behaviorspec.var_fd50e6db62ce8cc5[1] = spawnStruct();
    obj = behaviorspec.var_fd50e6db62ce8cc5[1];
    obj.name = "aim_default";
    obj.allowedsources = "all";
    obj.var_1550743f6e9673a5 = 0;
    obj.var_15737e3f6ebcd15b = 90;
    obj.anglebias = 10;
    obj.var_e16f134ab2dba426 = 60;
    obj.maxyaw = 90;
    obj.mindistance = 0;
    obj.maxdistance = 9999;
    behaviorspec.var_726cbdb5ce313d64[0] = spawnStruct();
    obj1 = behaviorspec.var_726cbdb5ce313d64[0];
    obj1.name = "default";
    obj1.sourcespecs[0] = spawnStruct();
    obj2 = obj1.sourcespecs[0];
    obj2.sources = "all";
    obj2.mindistance = 0;
    obj2.maxdistance = 512;
    obj2.minangle = -90;
    obj2.maxangle = 90;
    obj2.var_3821d46c3a4c58af = "default";
    behaviorspec.var_2c9fecf790dd3de3[0] = spawnStruct();
    obj = behaviorspec.var_2c9fecf790dd3de3[0];
    obj.name = "default";
    obj.startinginterest = 0;
    obj.var_d628c443c1ece758 = 700;
    obj.var_d64bda43c2135f72 = 1400;
    obj.var_a4ab7e2116dad865 = 2000;
    obj.var_a4cf88211703691b = 3000;
    obj.timeout = 5000;
    obj.priority = "background";
    addaidatabaseentry("component", ai_focus_behaviors_default, "ai_focus_behaviors", "ai_focus_behaviors_default_script");
  }
}